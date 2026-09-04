let version = "UDKInstall-2013-02-BETA.exe"
let checksum_sha256 = "b6cf432e9eb36be70b719a5de8110dbbcd78a35fb450a22f3114fe9317b4e1bc"
let rclone_source = "r2:cdn/UDKInstall-2013-02-BETA.exe"
let download_url = $"https://cdn.xiloe.fr/($version)"

let install_path = $nu.cache-dir | path join $version
let output_path = $env.PWD | path join "output"

let manifest_spec_path = $env.PWD | path join "manifest.toml"
let manifest_spec = open $manifest_spec_path

let bundle_spec_path = $env.PWD | path join "bundle.yaml"
let bundle_spec = open $bundle_spec_path
# nu <0.102 calls it temp-path, newer versions temp-dir
let bundle_path = (($nu.temp-path? | default $nu.temp-dir?) | path join "bundle")

let tempest_mod_path = ($output_path | path join $"($manifest_spec.mod.id).tempest")

if not ($env.PWD | path join "Binaries" | path exists) {
    let cached = ($install_path | path exists) and (sha256-of $install_path) == $checksum_sha256

    if not $cached {
        let r2_creds_set = not (($env.R2_ACCESS_KEY_ID? | is-empty) or ($env.R2_SECRET_ACCESS_KEY? | is-empty) or ($env.R2_ENDPOINT? | is-empty))

        mut downloaded = false
        if $r2_creds_set {
            try {
                let start_time = date now
                with-env {
                    RCLONE_CONFIG_R2_TYPE: "s3"
                    RCLONE_CONFIG_R2_PROVIDER: "Cloudflare"
                    RCLONE_CONFIG_R2_ACCESS_KEY_ID: $env.R2_ACCESS_KEY_ID
                    RCLONE_CONFIG_R2_SECRET_ACCESS_KEY: $env.R2_SECRET_ACCESS_KEY
                    RCLONE_CONFIG_R2_ENDPOINT: $env.R2_ENDPOINT
                } {
                    ^rclone copy $rclone_source $nu.cache-dir --progress
                }
                print $"\nDownloaded \"($version)\" from \"($rclone_source)\" in ((date now) - $start_time)."
                $downloaded = true
            } catch {|err|
                print $"\nDownload from \"($rclone_source)\" failed: ($err.msg)\nFalling back to \"($download_url)\"."
            }
        } else {
            print $"R2 creds not set, downloading \"($version)\" from \"($download_url)\"."
        }

        if not $downloaded {
            # curl, not `http get`: reqwest gets 403 from Cloudflare on the CDN,
            # and this streams to disk instead of buffering 1.9GB in RAM.
            ^curl -fL --retry 3 -o $install_path $download_url
        }
    }

    if not ($install_path | path exists) {
        error make {
            msg: $"Installer missing at ($install_path), cannot continue"
        }
    }

    print $"Verifying checksum of ($install_path) \((ls $install_path | get 0.size)\)..."
    if (sha256-of $install_path) != $checksum_sha256 {
        error make {
            msg: $"Checksum mismatch for ($install_path), expected ($checksum_sha256)"
        }
    }
    print "Checksum OK"

    7z x $install_path -aos -o. ...(open filelist.txt | lines) | ignore

    # UDK.exe imports DirectX-SDK-era DLLs that ship with UE3Redist, not with
    # Windows (d3dx9_43, D3DCompiler_43, X3DAudio1_7, XAPOFX1_5, xinput1_3...).
    # A full UDK install runs UE3Redist; on CI there is no session-0 desktop to
    # run GUI installers in, so just drop the x64 DLLs next to UDK.exe.
    if $nu.os-info.name == "windows" {
        let redist_path = (($nu.temp-path? | default $nu.temp-dir?) | path join "ue3redist")
        try { rm -r $redist_path } catch {}
        mkdir $redist_path
        ^7z x -tzip Binaries/Redist/UE3Redist.exe $"-o($redist_path)" | ignore

        for cab in [
            Jun2010_d3dx9_43_x64
            Jun2010_d3dx11_43_x64
            Jun2010_D3DCompiler_43_x64
            Feb2010_X3DAudio_x64
            Jun2010_XAudio_x64
            APR2007_xinput_x64
        ] {
            ^7z x -y $"($redist_path)/DXRedistCutdown/($cab).cab" $"-o($redist_path)/($cab)" | ignore
            ls $"($redist_path)/($cab)" | where name =~ '\.dll$' | each {|dll| cp $dll.name Binaries/Win64 } | ignore
        }

        # VC++ 2010 SP1 runtime (MSVCP100/MSVCR100), silent; tolerate
        # already-installed / reboot-required exit codes.
        let vcredist = ($redist_path | path join "vcredist_x64_vs2010sp1.exe")
        try {
            ^$vcredist /q /norestart
        } catch {|err|
            print $"vcredist exited non-fatal: ($err.msg)"
        }
        print "UE3Redist DLLs staged into Binaries/Win64"
    }
}

windows ./Binaries/Win64/UDK.com make -unattended

mkdir $output_path
try { rm -r $bundle_path } catch {}
mkdir $bundle_path

$bundle_spec.files | items {|k, v|
    let matched_sources = (glob $k)

    for source in $matched_sources {
        let resolved_source = ($source | path expand)

        # path expand yields backslashes on windows while $env.PWD uses
        # forward slashes, so normalize before comparing
        if not (($resolved_source | str replace -a '\' '/') | str starts-with ($env.PWD | str replace -a '\' '/')) {
            error make {
                msg: "Security Violation: Path traversal detected after expansion",
                label: {
                    text: $"Resolved path '($resolved_source)' escapes project root '($env.PWD)'",
                    span: (metadata $k).span
                }
            }
        }

        if ($source | path type) == "dir" {
            let output_dir = ($bundle_path | path join $v)
            mkdir $output_dir
            cp -r $source $output_dir
        } else {
            let output_file_path = if ($v | str ends-with "/") or ($v | str ends-with `\`) {
                ($bundle_path | path join $v ($source | path basename))
            } else {
                ($bundle_path | path join $v)
            }

            mkdir ($output_file_path | path dirname)
            cp $source $output_file_path
        }
    }
}

try { rm -r $tempest_mod_path } catch {}
7z a -tzip $tempest_mod_path ($bundle_path | path join "*") | ignore

print $bundle_spec.files

# Stream the hash through an external instead of `open`ing the 1.8GB installer
# into nu's memory (Defender live-scanning on CI makes that look like a hang).
def sha256-of [path: string] {
    match ($nu.os-info.name) {
        "windows" => { ^certutil -hashfile $path SHA256 | lines | where {|l| ($l | str trim) =~ '^[0-9a-fA-F]{64}$' } | first | str downcase }
        "macos" => { ^shasum -a 256 $path | split row " " | first }
        _ => { ^sha256sum $path | split row " " | first }
    }
}

def --wrapped windows [
    ...rest
] {
    if $nu.os-info.name == "windows" {
        ^$rest.0 ...($rest | skip 1)
        return
    }

    let data_dir = ($env.XDG_DATA_HOME? | default ($env.HOME | path join ".local" "share"))

    let prefix = ($data_dir | path join "tempest-tool")

    if ($prefix | path type) != "dir" {
        mkdir $prefix

        with-env {
            WINEPREFIX: $prefix
            WINEDEBUG: "-all"
            DXVK_LOG_LEVEL: "none"
        } {
            winetricks -q dotnet48
        }

        windows ./Binaries/Redist/UE3Redist.exe

        if $env.LAST_EXIT_CODE != 0 {
            print -e $"Wine prefix setup failed \(exit code ($env.LAST_EXIT_CODE)\)"
            return
        }
    }

    with-env {
        WINEPREFIX: $prefix
        WINEDEBUG: "-all"
        DXVK_LOG_LEVEL: "none"
    } {
        ^wine ...$rest
    }
}
