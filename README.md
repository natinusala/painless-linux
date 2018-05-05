# switch-linux

## What works / what doesn't work

* **Wi-Fi** : works after a reboot
  * After each cold boot, you should reboot (it will reboot to RCM) and run the exploit again to enable Wi-Fi
* **Bluetooth** : works partially
  * Keyboards and mice work
  * Joy-Cons, speakers and headphones don't
* **Touch screen** : works
* **Audio** : not working, even through Bluetooth headphones or speakers
* **Hardware graphics acceleration** : works
  * You have to select a power profile manually at each reboot using the `switchpower` script
* **Wired Joy-Cons** : to be implemented
* **Volume buttons** : recognized but don't do anything since there is no audio device
* **Power button** : only works to halt the system with a long-press
  * no graceful shutdown
  * no sleep mode
* **USB** : not working
* **Dock** : to be implemented
* **Power management** : works partially
  * No graceful shutdown
  * GPU profile has to be selected by hand
  * Battery level correctly recognized

## How to build it yourself

Follow the steps on fail0verflow's repository, but instead of using their fork of u-boot, use [mine](https://github.com/natinusala/switch-u-boot). If you already built everything, you will need to rebuild u-boot using my fork and _then_ rebuild coreboot.

Then, make sure that the first partition of the console's SD card is FAT32 and create a `boot` folder. Inside, put :
* `Image.gz` : the zipped Linux kernel
* `tegra210-nintendo-switch.dtb` : the DTB
* `initramfs.uImage` : the initramfs image (this is the `switch.scr.img` file)
* `boot.scr` : you can generate it by using the `make.sh` script in the `src` folder of this repository

Put the SD card in the console.

Then, use shofel2 to run the coreboot you recompiled, like usual. Linux should boot immediately without the need to run `imx_usb` !

## Credits
* kombos for the pre-built kernel and DTB
* rajkosto for TegraRcmSmash
* fail0verflow for their coreboot, u-boot and Linux port
