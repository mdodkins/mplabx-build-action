# Build with MPLAB X and XC8 GitHub Action

This action will build a MPLAB X / XC8 project.

## Inputs

### `project`

**Required** The path of the project to build (relative to the repository). For example: `firmware.X`.

### `configuration`

The configuration of the project to build. Defaults to `default`.

### `mplabx_version`

The version of [MPLAB X](https://www.microchip.com/en-us/development-tools-tools-and-software/mplab-x-ide) to use. Defaults to `6.00`.

### `complier_name`
The name of the [Compiler](https://www.microchip.com/en-us/development-tools-tools-and-software/mplab-xc-compilers) to use. Defaults to `xc8` Valid options are `xc8`, `xc16`, and `xc32`

### `complier_version`

The version of the [Compiler](https://www.microchip.com/en-us/development-tools-tools-and-software/mplab-xc-compilers) to use. Defaults to `2.36`.

Note: Only the x64 compilers can be used.
## Outputs

None.

## Example Usage

Add the following `.github/workflows/build.yml` file to your project:

```yaml
name: Build
on:
  push:
    branches:
      - master
  pull_request:
    branches:
      - master
jobs:
  build:
    name: Build the project
    runs-on: ubuntu-latest
    steps:
      - name: Download the source code
        uses: actions/checkout@v1
      - name: Build
        uses: callwyat/mplabx-build-action@v0.2.0
        with:
          project: firmware.X
          configuration: default
          mplabx_version: "6.00"
          complier_name: "xc8"
          complier_version: "2.36"
```

# Acknowledgements

Inspired by <https://github.com/velocitek/ghactions-mplabx>.
