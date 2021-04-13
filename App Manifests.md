# App Manifests

An app manifest is a JSON file that describes how to install a program.

##### A simple example:

```
{
    "version": "1.0",
    "url": "https://github.com/lukesampson/cowsay-psh/archive/master.zip",
    "extract_dir": "cowsay-psh-master",
    "bin": "cowsay.ps1"
}
```

When this manifest is run with it will download the zip file specified by , extract the "cowsay-psh-master" directory from the zip file, and then make the script available on your path.`scoop install` `url` `cowsay.ps1`

For more examples, see the app manifests in the [main Scoop bucket](https://github.com/ScoopInstaller/Main/tree/master/bucket).

### Required Properties

-   `version`: The version of the app that this manifest installs, per the [JSON schema definition](https://github.com/lukesampson/scoop/blob/master/schema.json#L527-L530).

### Optional Properties

-   `##`: A one-line string, or array of strings, containing comments.

-

-   `architecture`: If the app has 32- and 64-bit versions, architecture can be used to wrap the differences ([example](https://github.com/ScoopInstaller/Main/blob/master/bucket/7zip.json)).

-   `32bit|64bit`: contains architecture-specific instructions (, , , , , , , , , , and [ is deprecated]).`bin` `checkver` `extract_dir` `hash` `installer` `pre_install` `post_install` `shortcuts` `uninstaller` `url` `msi` `msi`

-   [`autoupdate`](https://github.com/lukesampson/scoop/wiki/App-Manifest-Autoupdate#adding-autoupdate-to-a-manifest): Definition of how the manifest can be updated automatically.

-   `bin`: A string or array of strings of programs (executables or scripts) to make available on the user's path.

    -   You can also create an alias shim which uses a different name to the real executable and (optionally) passes arguments to the executable. Instead of just using a string for the executable, use e.g: . See [busybox](https://github.com/ScoopInstaller/Main/blob/master/bucket/busybox.json) for an example.`[ "program.exe", "alias", "--arguments" ]`
    -   However if you declare just one shim like this, you must ensure it's enclosed in an outer array, e.g: . Otherwise it will be read as separate shims.`"bin": [ [ "program.exe", "alias" ] ]`

-   [`checkver`](https://github.com/lukesampson/scoop/wiki/App-Manifest-Autoupdate#adding-checkver-to-a-manifest): App maintainers and developers can use the [bin/checkver](https://github.com/lukesampson/scoop/blob/master/bin/checkver.ps1) tool to check for updated versions of apps. The property in a manifest is a regular expression that can be used to match the current stable version of an app from the app's homepage. For an example, see the [go](https://github.com/ScoopInstaller/Main/blob/master/bucket/go.json) manifest. If the homepage doesn't have a reliable indication of the current version, you can also specify a different URL to check—for an example see the [ruby](https://github.com/ScoopInstaller/Main/blob/master/bucket/ruby.json) manifest.`checkver`

-   `depends`: Runtime dependencies for the app which will be installed automatically. See also (below) for an alternative to .`suggest` `depends`

-   `description`: A one line string containing a short description of the program. Don’t include the name of the program, if it’s the same as the app’s filename.

-   `env_add_path`: Add this directory to the user's path (or system path if is used). The directory is relative to the install directory and must be inside the install directory.`--global`

-   `env_set`: Sets one or more environment variables for the user (or system if is used) ([example](https://github.com/ScoopInstaller/Main/blob/master/bucket/go.json)).`--global`

-   `extract_dir`: If points to a compressed file (.zip, .7z, .tar, .gz, .lzma, and .lzh are supported), Scoop will extract just the directory specified from it.`url`

-   `extract_to`: If points to a compressed file (.zip, .7z, .tar, .gz, .lzma, and .lzh are supported), Scoop will extract all content to the directory specified ([example](https://github.com/lukesampson/scoop-extras/blob/master/bucket/irfanview.json)).`url`

-   `hash`: A string or array of strings with a file hash for each URL in . Hashes are SHA256 by default, but you can use SHA512, SHA1 or MD5 by prefixing the hash string with 'sha512:', 'sha1:' or 'md5:'.`url`

-   `homepage`: The home page for the program.

-   `innosetup`: set to the boolean (without quotes) if the installer is InnoSetup based.`true`

-   `installer`: Instructions for running a non-MSI installer.

    -   `file`: The installer executable file. For this defaults to the last URL downloaded. Must be specified for .` installer``uninstaller `
    -   `script`: A one-line string, or array of strings, of commands to be executed as an installer/uninstaller instead of .`file`
    -   `args`: An array of arguments to pass to the installer. Optional.
    -   `keep`: if the installer should be kept after running (for future uninstallation, as an example). If omitted or set to any other value, the installer will be deleted after running. See [`extras/oraclejdk`](https://github.com/lukesampson/scoop-extras/blob/master/oraclejdk.json) for an example. This option will be ignored when used in an directive.`"true"` `uninstaller`
    -   Variables available to and : (the file last downloaded), (the deserialized manifest reference), ( or ), (install directory)`script` `args` `$fname` `$manifest` `$architecture` `64bit` `32bit` `$dir`
    -   Called during both and .`scoop install` `scoop upgrade`

-   `license`: A string or hash of the software license for the program. For well-known licenses, please use the identifier found at https://spdx.org/licenses/ For other licenses, use the URL of the license, if available. Otherwise, use “Freeware”, “Proprietary”, “Public Domain”, “Shareware”, or “Unknown”, as appropriate. If different files have different licenses, separate licenses with a comma (,). If the entire application is [dual licensed](https://en.wikipedia.org/wiki/Multi-licensing), separate licenses with a pipe symbol (|).

    -   `identifier`: The SPDX identifier, or “Freeware”, “Proprietary”, “Public Domain”, “Shareware”, or “Unknown”, as appropriate.
    -   `url`: For non-SPDX licenses, include a link to the license. It is acceptable to include links to SPDX licenses, as well.
    -   If it is difficult to determine all of the different licenses, it is acceptable to add at the end of the SPDX list. If there are both open-source and not open-source licenses, please list all non-open source licenses first (e.g., Freeware/Proprietary/Shareware).`,...`
    -   If you are unable to determine what license the application has, use "Unknown".

-   `notes`: A one-line string, or array of strings, with a message to be displayed after installing the app.

-   `persist`: A string or array of strings of directories and files to persist inside the data directory for the app. [Persistent data](https://github.com/lukesampson/scoop/wiki/Persistent-data)

-   `post_install`: A one-line string, or array of strings, of the commands to be executed after an application is installed. These can use variables like , , and . See [Pre- and post-install Scripts](https://github.com/lukesampson/scoop/wiki/Pre--and-Post-install-scripts) for more details.`$dir` `$persist_dir` `$version`

-   `pre_install`: Same options as , but executed before an application is installed.`post_install`

-   `psmodule`: Install as a PowerShell module in . `~/scoop/modules`

    -   `name` (required for ): the name of the module, which should match at least one file in the extracted directory for PowerShell to recognize this as a module.`psmodule`

-   `shortcuts`: Specifies the shortcut values to make available in the startmenu. See [sourcetree](https://github.com/lukesampson/scoop-extras/blob/master/bucket/sourcetree.json) for an example. The array has to contain a executable/label pair. The third and fourth element are optional.

1. Path to target file [required]
2. Name of the shortcut (supports subdirectories: [e.g. sysinternals](https://github.com/lukesampson/scoop-extras/blob/master/bucket/sysinternals.json)) [required]`<AppsSubDir>\\<AppShortcut>`
3. Start parameters [optional]
4. Path to icon file [optional]

-   `suggest`: Display a message suggesting optional apps that provide complementary features. See [ant](https://github.com/ScoopInstaller/Main/blob/master/bucket/ant.json) for an example.

    -   `["Feature Name"] = [ "app1", "app2"... ]`
        e.g.
        If any of the apps suggested for the feature are already installed, the feature will be treated as 'fulfilled' and the user won't see any suggestions.`"JDK": [ "extras/oraclejdk", "openjdk" ]`

-   `uninstaller`: Same options as , but the file/script is run to uninstall the application. `installer`

    -   Called during both and .`scoop uninstall` `scoop upgrade`

-   `url`: The URL or URLs of files to download. If there's more than one URL, you can use a JSON \* array, e.g. . URLs can be HTTP, HTTPS or FTP. `"url": [ "http://example.org/program.zip", "http://example.org/dependencies.zip" ]`

    -   To change the filename of the downloaded URL, you can append a URL fragment (starting with ) to URLs. For example,`#`
    -   `"http://example.org/program.exe"` -> `"http://example.org/program.exe#/dl.7z"`
    -   Note the fragment must start with for this to work.`#/`
    -   In the above example, Scoop will download but save it as , which will then be extracted automatically with 7-Zip. This technique is commonly used in Scoop manifests to bypass executable installers which might have undesirable side-effects like registry changes, files placed outside the install directory, or an admin elevation prompt.`program.exe` `dl.7z`

### Undocumented Properties

-   `cookie`: only found [here](https://github.com/se35710/scoop-java/search?q=cookie&unscoped_q=cookie)

### Deprecated Properties

-   `_comment`: A one-line string, or array of strings, containing comments. Use instead.`##`

-   `msi`_(deprecated)_: Settings for running an MSI installer
    **This property is deprecated and support will be removed in a future version of Scoop.** _The new method is to treat .msi files just like a .zip and extract the files from it without running the full install. You can use the new method simply by not including this `msi` property in your manifest._

    -   `code` _required_: the product code GUID for the MSI installer
    -   `silent`: should normally be to try to install without popups and UAC prompts`true`
