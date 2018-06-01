# Painless Linux

Boot Linux on the Switch without imx_usb_loader - Windows, Linux, Mac OS & Android

## Disclaimer

I am not reponsible in case you brick or blow up your Switch, its LCD screen or its battery. Use this at your own risks, as Linux is known to cause **battery calibration** and **RTC** desync as well as potential **damage to the LCD display**.

**You have been warned.**

## What am I booting ?

### The system

It's Arch Linux ARM (ALARM) with the GNOME desktop manager and some utilities :
* `sudo`
* chromium browser
* scripts to manage GPU clock profiles
* SSH server enabled by default
* automatic root filesystem expand to fit your SD card

The default user is `alarm`, its password is `alarm`. The root password is `root`.

### How to see and select the current GPU clock profile

The system comes with two scripts to see and select the current GPU clock profile. There are currently three profiles which can be enabled :

* `low` (`03`) : normal undockedspeed
* **(default)** `normal` (`0a`) :  normal docked speed
* `high` (`0d`) : (not recommended) maximum speed, will cause power failures

The system will reset to the normal profile at each reboot.

To see the current clock profile, run the `get-gpu-clock-profile` command as root. It will list all the available profiles, with a star next to the one currently activated.

To set the current clock profile, use the `set-gpu-clock-profile` command.

### First boot

When booting for the first time, the system will expand the root partition to fill your entire SD card, and then reboot (like a Raspberry Pi). You will need to run the exploit again once the screen turns black to finalize the reboot process, like when enabling Wi-Fi.

### Good practices

When shutting down the Switch from Linux, **it doesn't actually power it off**. Press the power button for 10 seconds and reboot into Horizon before shutting down from there.

## How to use it

### Step 0 : what you'll need

* A first-gen Switch
* A way to run the exploit (the host machine) :
  * A PC on Windows or Linux
  * A Mac
  * An Android device with Android 4.3 or newer, USB OTG support and a XHCI controller (you can't really know that before trying)
* A way to plug your Switch in the host machine :
  * If using a computer, an USB A-to-C or C-to-C cable
  * If using an Android device with a Micro USB port, find a Micro USB cable (often labelled "OTG") and chain it to a Type-C cable
  * If using an Android device with a Type-C port, find a C-to-C cable or a C-to-A chained to a A-to-C cable
* A SD card for you Switch (of at least 8Gb)
    * 128Gb cards are currently not supported by the Switch, a Linux kernel patch is required
* A way to put your Switch in RCM mode (a jig, a paperclip, a wire, a Joy-Con mod, a screwdriver, a soldering iron...)

### Step 1 : downloading things

1. Clone or download this repository ([here](https://github.com/natinusala/switch-linux/archive/master.zip))
2. Download the latest image file :
    * [from mega.co.gz](https://mega.nz/#!CPBEFARA!eZ2Ylhjz6kkSt14H_tPi2xZPJ0G0-a-6fLdMR7u0qNQ)
    * [from Google Drive (thanks to kevandkkim)](https://drive.google.com/file/d/1rO8XmusLBG6UnB2FfRp13_cL6t_0CsOM/view?usp=sharing)

### Step 2 : SD card preparation

Follow [this guide](https://www.raspberrypi.org/documentation/installation/installing-images/) with your SD card and the image file you downloaded.

TL;DR : on Windows use Etcher, on Linux & Mac OS use `dd`

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

Then, make sure that your Switch is plugged in your PC and in RCM mode. Open the folder of this repository (the one you downloaded and extracted) and run `windows-boot.bat` (or `windows-win32-boot.bat` on a 32bit machine). Voilà !

_Having a Win32 error 31 is normal._

#### From a Linux PC or a Mac

Install Python 3 (usually already installed). Open a terminal to install the required package : `pip3 install pyusb==1.0.0`. I let you deal with permissions issues (hint : `sudo` works on Linux).

Then, plug your switch in your PC and put it in RCM mode. You should use a blue "SS" port as these have a greater chance of success (EHCI controller doesn't work, XHCI controller works, blue ports have a greater chance of using XHCI).

Once ready, run the `linux-macos-boot.sh` script from this repository's folder. Again, I let you deal with permissions issues (if it cannot find the module `usb` it means that you have insufficient permissions). Voilà !

#### From an Android device

1. Download and install the latest release of this app : https://github.com/natinusala/switch_linux_launcher/releases/latest
2. Run it - it will tell you that some files are missing, remember the folder in the dialog, it should look like one of these :
    * `/storage/emulated/0/Android/data/io.mrarm.switchlinuxlauncher.noimx/files/shofel2`
    * `/sdcard/Android/data/io.mrarm.switchlinuxlauncher.noimx/files/shofel2`
4. Exit the app (if you can close the task using the multitask button it's better)
5. From the `payloads` folder of the repository, copy the `cbfs.bin` and `coreboot.rom` files to the `shofel2` folder on your Android device (the folder of the previous step)
6. Run the app again - if the dialog doesn't show up then you can go on, otherwise you did something wrong
7. (Optional) Depending on your device, you might need to enable "OTG" or "OTG Storage" in the Android settings
8. Plug your Switch in your Android device
    * If the Switch is charging from your phone, you can go on
    * If your phone is charging from the Switch, try to reverse the cabling so that your phone charges the Switch instead
    * If nothing happens, I'm afraid your phone doesn't have OTG (or it's not enabled) - the exploit might now work
9. Put your Switch in RCM mode
10. Voilà !

## Troubleshooting

* Having a black screen despite the fact that the exploit worked ? Just shut down the Switch (10 seconds power button press) and try again, it happens sometimes.
* Wi-Fi doesn't work ? Make sure you reboot properly :
    1. Plug your Switch back into your host machine
    2. Using the touchscreen, open the top-right menu and click on the power button
    3. Click on the `Restart` button
    4. Wait for the full reboot of the console
    5. Launch the exploit again so that Linux boots

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
  * No reboot to Linux, only reboot to RCM
  * GPU profile has to be selected by hand
  * Battery level correctly recognized
  * Be careful as staying for a long time in Linux desyncs the battery calibration on Horizon and _can_ cause the console to shutdown unexpectedly (at 50%)
  
* **Gnome-terminal** : Tofix ! It crash use xterm instead .
## How to build it yourself

Follow the steps on fail0verflow's repository, but instead of using their fork of u-boot, use [mine](https://github.com/natinusala/switch-u-boot). If you already built everything, you will need to rebuild u-boot using my fork and _then_ rebuild coreboot.

Then, make sure that the first partition of the console's SD card is FAT32 and create a `boot` folder. Inside, put :
* `Image.gz` : the zipped Linux kernel
* `tegra210-nintendo-switch.dtb` : the DTB
* `boot.scr` : you can generate it by using the `make.sh` script in the `src` folder of this repository

Put the SD card in the console.

Then, use shofel2 to run the coreboot you recompiled, like usual. Linux should boot immediately without the need to run `imx_usb` ! 

_You should probably put a rootfs in mmcblk0p2._

## Credits
* kombos for the pre-built kernel and DTB
* rajkosto for TegraRcmSmash
* MCMrARM for the Switch Linux Launcher app
* Gigaa for the GPU clock speed service
* 00cancer for the initial GNOME image
* ctyler for the rootfs-resize script
* fail0verflow for shofel2 and their coreboot, u-boot & Linux port
* Everyone else who participated !
