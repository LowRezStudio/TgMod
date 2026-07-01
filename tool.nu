let version = "UDKInstall-2013-02-BETA.exe"
let checksum_sha256 = "b6cf432e9eb36be70b719a5de8110dbbcd78a35fb450a22f3114fe9317b4e1bc"
let download_url = "https://web.archive.org/web/20140913062207id_/http://download.udk.com/UDKInstall-2013-02-BETA.exe"

let install_path = $nu.cache-dir | path join $version
let output_path = $env.PWD | path join "output"

let manifest_spec_path = $env.PWD | path join "manifest.toml"
let manifest_spec = open $manifest_spec_path

let bundle_spec_path = $env.PWD | path join "bundle.yaml"
let bundle_spec = open $bundle_spec_path
let bundle_path = $nu.temp-dir | path join "bundle"

let tempest_mod_path = ($output_path | path join $"($manifest_spec.mod.id).tempest")

if not ($env.PWD | path join "Binaries" | path exists) {
    let cached = ($install_path | path exists) and (open $install_path | hash sha256) == $checksum_sha256

    if not $cached {
        try {
            let start_time = date now
            (http get --raw $download_url | save --progress $install_path)
            print $"\nDownloaded \"($version)\" from \"($download_url)\" in ((date now) - $start_time)."
        } catch {
            print $"\nSomething went wrong... Please put the \"($version)\" file into \"($nu.cache-dir)\" yourself."
        }
    }

    7z x $install_path -aos -o. ...(open filelist.txt | lines) | ignore
}

windows ./Binaries/Win64/UDK.com make -unattended

mkdir $output_path
try { rm -r $bundle_path } catch {}
mkdir $bundle_path

print $bundle_spec.files
$bundle_spec.files | items {|k, v|
    let matched_sources = (glob $k)

    for source in $matched_sources {
        let resolved_source = ($source | path expand)

        if not ($resolved_source | str starts-with $env.PWD) {
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

def --wrapped windows [
    ...rest
] {
    if $nu.os-info.name == "windows" {
        ^...$rest
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
