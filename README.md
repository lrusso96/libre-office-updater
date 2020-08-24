# libre-office-updater
A simple PowerShell script to download and install Libre Office

## About

This script downloads the Libre Office installer (x86 or x64) from the official website.
Then it starts the installation process, which needs to be manually completed by the user (for settings, custom installation, etc.).

## How to run

```
> & "libre-office-updater.ps1" [-d] [-i] [-win (32|64)] [-v ("7.0.0" | etc.)]
```

### Flags

- **i**: skips the Installation dialog.
- **d**: skips the Download dialog.

### Parameters

- **win**: 32/64. Specifies the architecture.
- **v**. Specifies the version to install, e.g. "7.0.0"

If the previous parameters are not passed to the script, a dialog is prompted to insert them.
