# switch-linux

## Disclaimer

I am not reponsible in case you brick or blow up your Switch, its LCD screen or its battery. Use this at your own risks, as Linux is known to cause **battery calibration desync** and **damage to the LCD display**.

**You have been warned.**

## How to use it

### Step 0 : what you'll need

* A first-gen Switch
* A way to run the exploit (the host machine) :
  * A PC on Windows or Linux
  * A Mac
  * An Android phone with USB OTG support
* A way to plug your Switch in the host machine :
  * If using a computer, an USB A-to-C or C-to-C cable
  * If using an Android device with a Micro USB port, find a Micro USB cable (often labelled "OTG") and chain it to a Type-C cable
  * If using an Android device with a Type-C port, find a C-to-C cable or a C-to-A chained to a A-to-C cable
* A SD card for you Switch (of at least 4Gb)

### Step 1 : downloading things

TODO : IMG links

1. Clone or download this repository ([here](https://github.com/natinusala/switch-linux/archive/master.zip))
2. Download the image file for your desired distribution

### Step 2 : SD card preparation

TODO : Flash a IMG file and done

1. Extract the ZIP of the repository somewhere
2. Copy the contents of the `sd` folder to the root of your SD card
    * You should have a `boot` folder containing multiple files
3. Create a second ext4 partition and put your rootfs here

### Step 3 : booting Linux

#### From a Windows PC

On Windows, you will first need to install the required driver :

1. Get your Switch in RCM mode and plug it into your PC
    * It should appear as "APX" in Windows
2. Download and run the Zadig Driver Installer from here : https://zadig.akeo.ie/ 
3. In the list, choose the device "APX"
    * If it's not showing up, check "List all devices" in the options
4. At the right end of the green arrow, choose "libusbK (v3.0.7.0)"
5. Click on the big "Install driver" button

Then, make sure that your Switch is in RCM mode. Open the folder of this repository (the one you downloaded and extracted) and run `windows-boot.bat` (or `windows-win32-boot.bat` on a 32bit machine). Voilà !

#### From a Linux PC or a Mac

Install Python 3 (usually already installed). Open a terminal to install the required package : `pip3 install pyusb==1.0.0`. I let you deal with permissions issues (hint : `sudo` works on Linux).

Then, put your Switch in RCM mode and run the `linux-macos-boot.sh` script from this repository's folder. Voilà !

#### From an Android device

_NXLoader update coming soon_

## Troubleshooting

* Having a black screen despite the fact that the exploit worked ? Just shut down the Switch (10 seconds power button press) and try again, it happens sometimes.

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
  * Be careful as staying for a long time in Linux desyncs the battery calibration on Horizon and _can_ cause the console to shutdown unexpectedly (at 50%)

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
