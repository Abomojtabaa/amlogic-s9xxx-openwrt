<div align="center">
    <img src="https://www.smartbox.am/webroot/myfiles/images/products/gt1mini/1a140420202d67f82419ee1e1036f15b.jpg" alt="OpenWrt" />
</div>

# OpenWrt



The [OpenWrt](https://openwrt.org/) project is a Linux router operating system designed for embedded devices. Rather than being a single, immutable firmware, OpenWrt provides a fully writable filesystem with package management capabilities, allowing you to freely select the software packages you need to customize your router system. For developers, OpenWrt serves as a framework for building applications without the need to create a complete firmware around it; for end users, it provides full customization capabilities, enabling the device to be used in versatile and unexpected ways. With over 3,000 standardized application packages and extensive third-party plugin support, you can easily deploy them across a wide range of supported devices. Now you can replace the Android TV system on your TV box with the OpenWrt system, transforming it into a powerful router.

This project, thanks to numerous [contributors](https://github.com/ophub/amlogic-s9xxx-armbian/blob/main/CONTRIBUTORS.md), builds the OpenWrt system for `Amlogic`, `Rockchip`, and `Allwinner` boxes. It supports installation to eMMC, kernel updates, and more. For detailed usage instructions, see the [OpenWrt User Guide](./documents). The latest firmware can be downloaded from [Releases](https://github.com/ophub/amlogic-s9xxx-openwrt/releases). You are welcome to `Fork` this repository and customize the software packages. If you find this project helpful, please consider clicking `Star` in the upper right corner of the repository to show your support.

## Default Information for OpenWrt Firmware

| System Name    | Default Username | Default Password  | SSH Port  | IP Address  |
| -------------- | ---------------- | ----------------- | --------- | ----------- |
| 🛜 [OpenWrt.OS](https://github.com/ophub/amlogic-s9xxx-openwrt/releases) | root | password | 22 | 192.168.1.1 |
| 🐋 [OpenWrt.Docker](https://hub.docker.com/u/ophub) | root | password | 22 | 192.168.1.1 |


## Install and Update OpenWrt

Choose the OpenWrt firmware corresponding to your TV box model, and refer to the relevant documentation for device-specific usage instructions.

- ### Install OpenWrt

1. For the `Rockchip` platform, please refer to the [Chapter 8](https://github.com/ophub/amlogic-s9xxx-armbian/blob/main/documents/README.md#8-installing-armbian-to-emmc) of the instruction manual, the installation method is the same as that of Armbian.

2. For the `Amlogic` and `Allwinner` platforms, use tools like [Rufus](https://rufus.ie/) or [balenaEtcher](https://www.balena.io/etcher/) to write the firmware to USB, then insert the USB with the written firmware into the box. Browser access to OpenWrt's IP (e.g. 192.168.1.1) → `Log in to OpenWrt with the default account` → `System Menu` → `Amlogic Treasure Box` → `Install OpenWrt`, select your box from the dropdown list of supported devices, click `Install OpenWrt` button to install.

- ### Update OpenWrt system or kernel

Browser access to OpenWrt's IP (e.g. 192.168.1.1) → `Log in to OpenWrt with your account` → `System Menu` → `Amlogic Treasure Box` → `Manually Upload Update / Online Download Update`

If you select `Manually Upload Update` [OpenWrt Firmware](https://github.com/ophub/amlogic-s9xxx-openwrt/releases), you can upload the compressed package of the compiled OpenWrt firmware, such as openwrt_xxx_k5.15.50.img.gz (recommended to upload the compressed package, the system will automatically decompress. If you upload the decompressed xxx.img format file, it may fail due to the large file size). After the upload is complete, the interface will display the operation button of `Update Firmware`, click to update.

If you select `Manually Upload Update` [OpenWrt Kernel](https://github.com/ophub/kernel/releases/tag/kernel_stable), you can upload the three kernel files: `boot-xxx.tar.gz`, `dtb-xxx.tar.gz`, `modules-xxx.tar.gz` (other kernel files are not needed, if uploaded simultaneously, it does not affect the update, the system can accurately identify the needed kernel files). After the upload is complete, the interface will display the operation button of `Update Kernel`, click to update. When a kernel update failure causes the system to be unbootable, you can use the `openwrt-kernel -s` command for kernel recovery. For the method, see [Kernel Recovery](documents/README.md#9-update-openwrt-system-or-kernel).

If you select `Online Download Update` for OpenWrt firmware or kernel, it will be downloaded according to the `firmware download address` and `kernel download address` in the `Plugin Settings`. You can customize the download source. For specific operation methods, please refer to the compilation and usage instructions of [luci-app-amlogic](https://github.com/ophub/luci-app-amlogic).

- ### Create swap for OpenWrt

If you find the available memory insufficient when running memory-intensive applications such as `docker`, you can create a `swap` virtual memory partition, using a portion of the `/mnt/*4` disk space as virtual memory. The unit for the input parameter in the command below is `GB`, with a default value of `1`.

Browser access to OpenWrt's IP (e.g. 192.168.1.1) → `Log in to OpenWrt with the default account` → `System Menu` → `TTYD Terminal` → enter the command

```yaml
openwrt-swap 1
```

- ### Backup/Restore Original EMMC System

Supports backing up and restoring the `EMMC` partition via `TF/SD/USB`. It is recommended to back up the original Android TV system before installing OpenWrt on a brand-new box, in case you need to restore it later.

Please boot OpenWrt system from a `SD card` or a `USB flash drive`, then access OpenWrt via browser at its IP (e.g. 192.168.1.1) → `Log in to OpenWrt with the default account` → `System Menu` → `TTYD Terminal` → enter the command

```yaml
openwrt-ddbr
```

Follow the prompts to enter `b` to backup the system, or enter `r` to restore the system.

> [!IMPORTANT]
> In addition, the Android system can also be flashed into eMMC using the method of flashing via a cable. The download image of the Android system can be found in [Tools](https://github.com/ophub/kernel/releases/tag/tools).

- ### Control LED Display

Browser access to OpenWrt's IP (e.g. 192.168.1.1) → `Log in to OpenWrt with the default account` → `System Menu` → `TTYD Terminal` → enter the command

```yaml
openwrt-openvfd
```

Refer to [LED Screen Display Control Description](https://github.com/ophub/amlogic-s9xxx-armbian/blob/main/documents/led_screen_display_control.md) for debugging.

- ### Restore to Initial State

Browser access to OpenWrt's IP (e.g. 192.168.1.1) → `Log in to OpenWrt with the default account` → `System Menu` → `Amlogic Service` → `Backup Firmware Config` → `Snapshot Management` → `Select Initialize Snapshot`, and click on `Restore Snap` to revert to the initial state.

Alternatively, you can navigate to `System menu` → `TTYD Terminal` → Enter the command `firstboot` to restore the system to its initial state. Both methods yield the same result.

- ### More Usage Instructions

For common issues and solutions encountered during OpenWrt usage, please refer to the [User Guide](./documents)

## Local Packaging
1. Clone repository to local `git clone --depth 1 https://github.com/ophub/amlogic-s9xxx-openwrt.git`
2. Install necessary packages (for Ubuntu 24.04)

Enter the installation command in the root directory of `~/amlogic-s9xxx-openwrt`:

```shell
sudo apt-get update -y
sudo apt-get full-upgrade -y
# For Ubuntu-24.04
sudo apt-get install -y $(cat make-openwrt/scripts/ubuntu2404-make-openwrt-depends)
```

3. In the root directory of `~/amlogic-s9xxx-openwrt`, create `openwrt-armsr` folder, and upload the `openwrt-armsr-armv8-generic-rootfs.tar.gz` file to this directory.
4. Enter the packaging command in the root directory of `~/amlogic-s9xxx-openwrt`, such as `sudo ./remake -b s905x3 -k 6.1.10`. The packaged OpenWrt firmware is placed in the `openwrt/out` folder in the root directory.

- ### Explanation of Local Packaging Parameters

| Parameter | Meaning       | Description |
| --------- | ------------- | ----------- |
| -b        | Board         | Specifies the target device codename (default is `all`). You can specify a single device (e.g., `-b s905x3`) or connect multiple codenames with underscores to compile them together (e.g., `-b s905x3_s905d`). The parameter also supports special keywords for batch compilation: `all` compiles every device in the database, `first50` compiles the first 50 devices, `range50_100` compiles devices from the 51st to the 100th (similarly for `range100_150`), and `last20` compiles the last 20 devices. Additionally, you can compile by hardware platform (`amlogic`, `rockchip`, `allwinner`) to build all images for that specific platform, for example, `-b amlogic`. Appending numeric values to the platform name allows you to compile a specific range within that platform's support list; for example, `-b amlogic50` builds the first 50 devices under the Amlogic platform, and `-b amlogic50_100` builds the 51st to the 100th devices. For a complete list of supported device codenames, please refer to the `BOARD` configuration items in [model_database.conf](make-openwrt/openwrt-files/common-files/etc/model_database.conf). Default: `all` |
| -r        | KernelRepo    | Specify the `<owner>/<repo>` of the github.com kernel repository. Default: `ophub/kernel` |
| -u        | kernelUsage   | Set the `tag suffix` of the kernel to be used, such as [stable](https://github.com/ophub/kernel/releases/tag/kernel_stable), [flippy](https://github.com/ophub/kernel/releases/tag/kernel_flippy), [beta](https://github.com/ophub/kernel/releases/tag/kernel_beta). Default: `stable` |
| -k        | Kernel        | Specify the [kernel](https://github.com/ophub/kernel/releases/tag/kernel_stable) name, such as `-k 5.10.125`. Connect multiple kernels with `_`, such as `-k 5.10.125_5.15.50`. The kernel version freely specified by the `-k` parameter is only valid for kernels using `stable/flippy/beta`. Other kernel series such as [rk3588](https://github.com/ophub/kernel/releases/tag/kernel_rk3588) / [rk35xx](https://github.com/ophub/kernel/releases/tag/kernel_rk35xx) / [h6](https://github.com/ophub/kernel/releases/tag/kernel_h6) can only use specific kernels. |
| -a        | AutoKernel    | Set whether to automatically adopt the latest version of the same series of kernels. When set to `true`, it will automatically search the kernel library for updates of the same series as the kernel specified in `-k`, such as 5.10.125, and will automatically switch to the latest version if there is a version later than 5.10.125. When set to `false`, it will compile the specified version of the kernel. Default: `true` |
| -p        | IP            | Set the default IP address of the OpenWrt system, for example: `-p 10.1.1.1`. Default value: `192.168.1.1` |
| -s        | Size          | Set the size of the system's image partitions. When setting only the ROOTFS partition size, you can specify a single value, for example: `-s 1024`. When setting both BOOTFS and ROOTFS partition sizes, use / to connect the two values, for example: `-s 256/1024`. The default value is `256/1024` |
| -n        | BuilderName   | Set the signature of the OpenWrt system builder. Do not include spaces when setting signatures. Default: `none` |

- `sudo ./remake` : Use default configuration, use the latest kernel package in the kernel library, and package all models of TV boxes.
- `sudo ./remake -b s905x3 -k 6.1.10` : Recommended. Use default configuration for related kernel packaging.
- `sudo ./remake -b s905x3 -k 6.1.y` : Package the relevant kernels using the default configuration; the kernel utilizes the latest version of the 6.1.y series.
- `sudo ./remake -b s905x3_s905d -k 6.1.10_5.15.50` : Use the default configuration and package multiple kernels at the same time. Use `_` to connect multiple kernel parameters.
- `sudo ./remake -b s905x3 -k 6.1.10 -s 1024` : Use the default configuration, specify a kernel, a model for packaging, and set the firmware size to 1024 MiB.
- `sudo ./remake -b s905x3_s905d` : Use default configuration, package all kernels for multiple models of TV boxes, use `_` to connect multiple models.
- `sudo ./remake -k 6.1.10_5.15.50` : Use the default configuration, specify multiple kernels, package all models of TV boxes, and connect kernel packages with `_`.
- `sudo ./remake -k 6.1.10_5.15.50 -a true` : Use the default configuration, specify multiple kernels, package all models of TV boxes, and connect kernel packages with `_`. Automatically upgrade to the latest kernel of the same series.
- `sudo ./remake -s 1024 -k 6.1.10` : Use the default configuration, set the firmware size to 1024 MiB, and specify the kernel as 6.1.10 to package all models of TV boxes.

## Use GitHub Actions for Compilation

You can modify the related personalized firmware configuration files in the [config](config) directory, as well as the [.yml](.github/workflows) file, customize and compile your OpenWrt firmware, and the firmware can be uploaded to `Actions` and `Releases` on github.com.

1. You can view the personalized firmware configuration instructions in the [user documentation](./documents). The compilation process control file is [.yml](https://github.com/ophub/amlogic-s9xxx-openwrt/blob/main/.github/workflows/build-openwrt-system-image.yml)
2. New compilation: In github.com's [Action](https://github.com/ophub/amlogic-s9xxx-openwrt/actions) select ***`Build OpenWrt system image`***. Click the ***`Run workflow`*** button for one-stop firmware compilation and packaging.
3. Re-compilation: If there is already a compiled `openwrt-armsr-armv8-generic-rootfs.tar.gz` file in [Releases](https://github.com/ophub/amlogic-s9xxx-openwrt/releases), and you only need to rebuild for other board types, you can skip the OpenWrt source compilation and directly use [build-openwrt-using-releases-files.yml](.github/workflows/build-openwrt-using-releases-files.yml) for a secondary build.
4. More Support: The compiled `openwrt-armsr-armv8-generic-rootfs.tar.gz` file is a universal file for building firmware for various board types. It is also compatible with [unifreq](https://github.com/unifreq/openwrt_packit)'s packaging scripts for creating OpenWrt firmware. As the pioneer of running OpenWrt and Armbian systems on TV boxes, unifreq provides support for additional devices, including OpenWrt ([QEMU version](https://github.com/unifreq/openwrt_packit/blob/master/files/qemu-aarch64/qemu-aarch64-readme.md)) running via `KVM` virtual machines in [Armbian](https://github.com/ophub/amlogic-s9xxx-armbian), as well as Amlogic, Rockchip, and Allwinner series. For packaging methods, refer to his repository documentation. In Actions, you can use [build-openwrt-using-unifreq-scripts.yml](.github/workflows/build-openwrt-using-unifreq-scripts.yml) to invoke his packaging scripts for building additional firmware.

```yaml
- name: Package armsr-armv8 as OpenWrt
  uses: ophub/amlogic-s9xxx-openwrt@main
  with:
    openwrt_path: openwrt/bin/targets/*/*/*rootfs.tar.gz
    openwrt_board: s905x2
    openwrt_kernel: 6.12.y_6.18.y
    openwrt_ip: 192.168.1.1
```

- ### GitHub Actions Input Parameters Explanation

These parameters correspond to the `local packaging command`, please refer to the explanations above.

| Parameter      | Default Value | Description                              |
| -------------- | ------------- | ---------------------------------------- |
| openwrt_path   | None          | Set the file path of `openwrt-armsr-armv8-generic-rootfs.tar.gz`, you can use relative path like `openwrt/bin/targets/*/*/*rootfs.tar.gz` or a network file download URL like `https://github.com/*/releases/*/*rootfs.tar.gz` |
| openwrt_board  | all           | Set the `board` of the box to be packaged, functionality refers to `-b` |
| kernel_repo    | ophub/kernel  | Specify `<owner>/<repo>` of the kernel repository on github.com, functionality refers to `-r` |
| kernel_usage   | stable        | Set the `tags suffix` of the kernel to be used, functionality refers to `-u` |
| openwrt_kernel | 6.12.y_6.18.y | Set the kernel version, functionality refers to `-k` |
| auto_kernel    | true          | Set whether to automatically adopt the latest version of the same series of kernels, functionality refers to `-a` |
| openwrt_ip     | 192.168.1.1   | Set the default IP address of the OpenWrt system, functionality refers to `-p` |
| openwrt_size   | 256/1024      | Set the size of the system BOOTFS and ROOTFS partitions, function reference `-s` |
| openwrt_files  | false         | Adds custom OpenWrt files. If set, all files in this directory will be copied to [common-files](make-openwrt/openwrt-files/common-files). The directory structure must mirror the OpenWrt root directory to ensure files are correctly overlaid(e.g., default configuration files should be placed under `etc/config/`). |
| builder_name   | None          | Set the signature of the OpenWrt system builder, functionality refers to `-n` |

- ### GitHub Actions Output Variables Explanation

To upload to `Releases`, you need to set `Workflow read/write permissions` for repository. For details, see [usage instructions](./documents/README.md#2-set-the-privacy-variable-github_token).

| Parameter                      | Default Value     | Description                            |
| ------------------------------ | ----------------- | -------------------------------------- |
| ${{ env.PACKAGED_OUTPUTPATH }} | out               | OpenWrt system files output path       |
| ${{ env.PACKAGED_OUTPUTDATE }} | 04.13.1058        | Packaging date (month.day.hourminute)  |
| ${{ env.PACKAGED_STATUS }}     | success / failure | Packaging status. success / failure    |

## Compilation Options of openwrt-*-rootfs.tar.gz for Packaging

| Option | Value |
| ------ | ----- |
| Target System | Arm SystemReady (EFI) compliant |
| Subtarget | 64-bit (armv8) machines |
| Target Profile | Generic EFI Boot |
| Target Images | tar.gz |

For more information, please refer to the [User Documentation](./documents)

## Compile the Kernel

For instructions on how to compile the kernel, see [compile-kernel](https://github.com/ophub/amlogic-s9xxx-armbian/tree/main/compile-kernel).

```yaml
- name: Compile the kernel
  uses: ophub/amlogic-s9xxx-armbian@main
  with:
    build_target: kernel
    kernel_version: 6.12.y_6.18.y
    kernel_auto: true
    kernel_sign: -yourname
```

## Resource Description

When building the OpenWrt system, the [kernel](https://github.com/ophub/kernel) and [u-boot](https://github.com/ophub/u-boot) files used are the same as those used to build the [Armbian](https://github.com/ophub/amlogic-s9xxx-armbian) system. To avoid redundant maintenance, related content has been organized into the corresponding resource repositories and will be automatically downloaded from them during use.

The [u-boot](https://github.com/ophub/u-boot), [kernel](https://github.com/ophub/kernel), and other resources used by this system are primarily derived from the [unifreq/openwrt_packit](https://github.com/unifreq/openwrt_packit) project. Some files are contributed by users through [Pull Requests](https://github.com/ophub/amlogic-s9xxx-openwrt/pulls) and [Issues](https://github.com/ophub/amlogic-s9xxx-openwrt/issues) in the [amlogic-s9xxx-openwrt](https://github.com/ophub/amlogic-s9xxx-openwrt) / [amlogic-s9xxx-armbian](https://github.com/ophub/amlogic-s9xxx-armbian) / [luci-app-amlogic](https://github.com/ophub/luci-app-amlogic) / [kernel](https://github.com/ophub/kernel) / [u-boot](https://github.com/ophub/u-boot) and other projects. `unifreq` pioneered the use of OpenWrt in TV boxes. Deeply influenced by his work, my firmware production and usage follow his consistent standards. To acknowledge these pioneers and contributors, I have recorded them in [CONTRIBUTORS.md](https://github.com/ophub/amlogic-s9xxx-armbian/blob/main/CONTRIBUTORS.md). Once again, thank you to everyone for giving new life and meaning to these boxes.

## Other Distributions

- [unifreq](https://github.com/unifreq/openwrt_packit) has built `OpenWrt` systems for a wide range of boxes including Amlogic, Rockchip, and Allwinner platforms. It is the benchmark project in the TV box community and is highly recommended.
- The [amlogic-s9xxx-armbian](https://github.com/ophub/amlogic-s9xxx-armbian) project provides the `Armbian` system for TV boxes, which is also compatible with devices that support OpenWrt.
- The [fnnas](https://github.com/ophub/fnnas) project provides the `FnNAS` system for TV boxes, which is also compatible with devices that support OpenWrt.

## Links

- [unifreq](https://github.com/unifreq/openwrt_packit)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [coolsnowwolf](https://github.com/coolsnowwolf/lede)
- [immortalwrt](https://github.com/immortalwrt/immortalwrt)

## License

The amlogic-s9xxx-openwrt © OPHUB is licensed under the [GPL-2.0](https://github.com/ophub/amlogic-s9xxx-openwrt/blob/main/LICENSE) license.
