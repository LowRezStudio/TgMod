let version = "UDKInstall-2013-02-BETA.exe"
let checksum_sha256 = "b6cf432e9eb36be70b719a5de8110dbbcd78a35fb450a22f3114fe9317b4e1bc"
let download_url = "https://web.archive.org/web/20140913062207id_/http://download.udk.com/UDKInstall-2013-02-BETA.exe"

let install_path = $nu.cache-dir | path join $version

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
