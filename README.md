# switch-linux

# How to use (not user-friendly yet)

Follow the steps on fail0verflow's repository, but instead of using their fork of u-boot, use [mine](https://github.com/natinusala/switch-u-boot). If you already built everything, you will need to rebuild u-boot using my fork and _then_ rebuild coreboot.

Then, make sure that the first partition of the console's SD card is FAT32 and create a `boot` folder. Inside, put :
* `Image.gz` : the zipped Linux kernel
* `tegra210-nintendo-switch.dtb` : the DTB
* `initramfs.uImage` : the initramfs image (this is the `switch.scr.img` file)
* `boot.scr` : you can generate it by using the `make.sh` script in the `src` folder of this repository

Put the SD card in the console.

Then, use shofel2 to run the coreboot you recompiled, like usual. Linux should boot immediately without the need to run `imx_usb` !
