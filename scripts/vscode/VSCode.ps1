"post_install": [
        "if (Test-Path \"$dir\\vscode-install-context.reg\") {",
        "  $codepath = \"$dir\\Code - Insiders.exe\".Replace('\\', '\\\\')",
        "  $content = Get-Content \"$dir\\vscode-install-context.reg\"",
        "  $content = $content.Replace('$code', $codepath)",
        "  $content = $content.Replace('&Code', 'Code &Insiders')",
        "  if ($global) {",
        "    $content = $content.Replace('HKEY_CURRENT_USER', 'HKEY_LOCAL_MACHINE')",
        "  }",
        "  $content | Set-Content -Path \"$dir\\vscode-install-context.reg\"",
        "}",
        "if (Test-Path \"$dir\\vscode-uninstall-context.reg\") {",
        "  $content = Get-Content \"$dir\\vscode-uninstall-context.reg\"",
        "  $content = $content.Replace('&Code', 'Code &Insiders')",
        "  if ($global) {",
        "    $content = $content.Replace('HKEY_CURRENT_USER', 'HKEY_LOCAL_MACHINE')",
        "  }",
        "  $content | Set-Content -Path \"$dir\\vscode-uninstall-context.reg\"",
        "}"
    ],