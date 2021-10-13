```json
{
    // 版本号
    "version": "", 
    "description": "",
    "homepage": "",
    "license": "MIT",
    "architecture": {
        "64bit": {
            "url": "",
            "hash": ""
        }
    },
    // 执行文件位置
    "bin": [[ "program.exe", "alias" ]]
    // 快捷方式
    "shortcuts": [["pwsh.exe", "PowerShell"]],
    "checkver": {
        "url": "",
        "regex": "/Dism\\+\\+([\\d\\.]+)_(?<sha1>[a-fA-F0-9]{40})\\.zip"
    },
    "autoupdate2": {
        "url": "/v$version/Dism++$version_$matchSha1.zip",
        "hash": "sha1:$matchSha1"
    },
    "autoupdate": {
        "architecture": {
            "64bit": {
                "url": "https://github.com/PowerShell/PowerShell/releases/download/v$version/PowerShell-$version-win-x64.zip#/dl.7z",
                "hash": {
                    "url": "https://github.com/PowerShell/PowerShell/releases/tag/v$version/",
                    "regex": "$basename\\s*<ul>\\s*<li>$sha256"
                },
                "hash2": {
                    "url": "$baseurl/sha256.txt",
                    "regex": "$base64\\s+\\./xray_windows_amd64.exe.zip"
                }
            }
        }
    }
}
```
