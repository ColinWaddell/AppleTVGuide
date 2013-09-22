# Introduction

I plan on using this site to document all the steps it take to get me from a factory default Apple TV to something capable of running XBMC, a samba server, Usenet and bit-torrent clients which are operated via web interfaces, BBC iPlayer and a few other things. All this is going to run under the latest Apple TV firmware (3.0.2).

I realise that sites such as [http://wiki.awkwardtv.org](http://wiki.awkwardtv.org) are flush with information, but I want to have a guide which is perfect for myself for the next time I have to perform this. Hopefully if your reading this then it can be of some help to yourself also.

As with any guide of this nature Im saying right now that I am taking no responsibility for anyone who follows any of my instructions and breaks their Apple TV; that’s your fault, not mine. I’m lucky enough to have a lot of experience at this sort of thing, if you don’t know what your doing then please don’t try anything described here.

One last thing. I am hosting all the recommended downloads. This is due to a difficulty not long ago with sourcing the Samba packages after the files dropped offline. I feel like as long as I’ve got a working copy of all the recommended files here then this problem won’t arise again. If however you feel that I shouldn’t be hosting other peoples (or your own) content, please let me know asap and I’ll have it sorted in a jiffy.








# Do You Have A Composite TV?

The Apple TV outputs in component video and HDMI. If you have a tv which requires a composite source (i.e. the video input on your TV just comes via one cable) then your going to have to be patient with a black and white picture for a few more steps.

To get an image on your screen from your Apple TV you need to connect a cable from the green (luma) component output to your yellow composite input and select 480i as the resolution for [NTSC](http://en.wikipedia.org/wiki/NTSC) or 576i for [PAL](http://en.wikipedia.org/wiki/PAL) (or else it will flicker).

![Compisite TV Connector](https://raw.github.com/ColinWaddell/AppleTVGuide/master/readme_img/composite.jpg)









# Patching the Apple TV

The first thing we need to do is patch the apple tv using a memory stick. Thanks to the amazing work done at the [PatchStickBuilder](http://patchstick.wikispaces.com/PatchStickBuilder) project this is one of the easiest parts of the whole process and may be as far as you need to go in modifying your Apple TV.

First you need a USB key which has a capacity of over 1G. Head over to the [PatchStickBuilder](http://patchstick.wikispaces.com/PatchStickBuilder) website and pick up the latest version of their software.

![Patch Stick Builder](https://raw.github.com/ColinWaddell/AppleTVGuide/master/readme_img/patchstickbuilder.jpg)

Get the software to download the latest firmware. Plug in your USB key. Hit `create Patchstick` and let it do its magic. When finished, unplug your AppleTV, plug in the USB key, then plug the Apple TV back in. Once loaded there will be a pile of text on-screen showing the progress of the installation. After the installation is complete, unplug the USB key, unplug your Apple TV, then plug your Apple TV back in. It will restart as normal, then once your at the main menu your Apple TV will restart on its own. This should be the patching complete.

If the patch stick software is having issues with downloading the dmg is requires then a list of firmware versions is held at [iClarified](http://www.iclarified.com/entry/index.php?enid=970) with links to downloads from the apple website. I went for version 3.0.2

Also, not all USB keys work. If you plug it in and switch on the Apple TV and nothing happens then try another key.










# SSH Access

Your going to be using SSH quite a bit from now on. Access is gained using the command

    ssh frontrow@appletv.local

The default password is `frontrow`









# Enabling Read/Write Support

This first thing you need to do if you want to start playing with your Apple TV is enable read/write support. SSH into your Apple TV and run the following

    sudo -s
    mount -uw /
    touch /.readwrite
    reboot

You only have to do this once.








# Install NitoTV

This software is AMAZING. Installing NitoTV saves a lot of time as it provides us with an automated method of providing a lot of functionality to the Apple TV.

From SSH run

    wget http://nitosoft.com/nitoTVInstaller_tt.zip
    unzip nitoTVInstaller_tt.zip
    cd nitoTV Take Three/
    sudo ./installme

This will restart Finder and provide the NitoTV menu.

More details can be found at [The AwkwardTV Forums](http://plugins.awkwardtv.org/det.php?recordID=nitoTV) please check it out.

![Nito Screenshot](https://raw.github.com/ColinWaddell/AppleTVGuide/master/readme_img/nito.jpg)








# NitoTV Smart Installer

This piece of software takes care of installing all the things you really need to get the most from your Apple TV and saves you the trouble of doing it manually.

From the [Nito Wiki](from http://wiki.awkwardtv.org/wiki/NitoTV)

> Once the smart installer finds the location to install from it will scan the AppleTV for any important missing kexts, frameworks or binaries (usb, udf, samba, bluetooth, dvdplayback etc) and install them in their proper location, taking care of any owners, permissions AND will add kexts necessary to load on startup to /etc/rc.local).
> 
> The smart installer will also take care of Turbo’s easy USB patching (not done prior to 0.2.5b9) A reboot will be required for this to take effect.
> 
> Last but not least, the Smart Installer will fix any problems with the /etc/rc.local files not created by the prior version (b8) and add the necessary kexts and the kextloader.

There have been a number of reports of people getting the ‘wrong permissions or owners to work properly’ screen while using the smart installer with Nito 0.2.7 and after. A good fix is to SSH into the AppleTV and run the following:
 
>    cd /System/Library/CoreServices/Finder.app/
>    Contents/PlugIns/nitoTV.frappliance/Contents/Resources/
>    sudo chmod 755 nitoHelper
>    sudo chmod u+s nitoHelper


Running Smart Installer is as simple as getting your remote and pointing your Apple TV in the direction of Nito TV->Settings->Install Software->Smart Installer. Then let it do its thing."


