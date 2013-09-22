# About This Guide

I wrote this guide a long long time ago. The way it's written really makes me cringe now (it's a bit chatty), and my
grammar really needs a good going over. Other than that though, it's really helped a lot of people. I'm redesigning my
personal website and wasn't too sure where to put this guide so I'm going to keep it maintained via GitHub.

> 1.  [Introduction](#introduction)
> 2.  [Do You Have A Composite TV?](#do-you-have-a-composite-tv)
> 3.  [Patching the Apple TV](#patching-the-apple-tv)
> 4.  [SSH Access](#ssh-access)
> 5.  [Enabling Read/Write Support](#enabling-readwrite-support)
> 6.  [Install NitoTV](#install-nitotv)
> 7.  [NitoTV Smart Installer](#nitotv-smart-installer)
> 8.  [Composite Output](#composite-output)
> 9.  [Install Launcher](#install-launcher)
> 10. [Housekeeping](#housekeeping)
> 11. [Install SAMBA](#install-samba)
> 12. [SABNZB Usenet Client](#sabnzb-usenet-client)
> 13. [Starting SABnzbd Automatically](#starting-sabnzbd-automatically)
> 14. [Transmission Bittorrent Client](#transmission-bittorrent-client)
> 15. [Starting Transmission Automatically](#starting-transmission-automatically)





# Introduction

I plan on using this site to document all the steps it take to get me from a factory default Apple TV to something
capable of running XBMC, a samba server, Usenet and bit-torrent clients which are operated via web interfaces, BBC
iPlayer and a few other things. All this is going to run under the latest Apple TV firmware (3.0.2).

I realise that sites such as [http://wiki.awkwardtv.org](http://wiki.awkwardtv.org) are flush with information, but I
want to have a guide which is perfect for myself for the next time I have to perform this. Hopefully if your reading
this then it can be of some help to yourself also.

As with any guide of this nature Im saying right now that I am taking no responsibility for anyone who follows any of
my instructions and breaks their Apple TV; that’s your fault, not mine. I’m lucky enough to have a lot of experience at
this sort of thing, if you don’t know what your doing then please don’t try anything described here.

One last thing. I am hosting all the recommended downloads. This is due to a difficulty not long ago with sourcing the
Samba packages after the files dropped offline. I feel like as long as I’ve got a working copy of all the recommended
files here then this problem won’t arise again. If however you feel that I shouldn’t be hosting other peoples (or your
own) content, please let me know asap and I’ll have it sorted in a jiffy.








# Do You Have A Composite TV?

The Apple TV outputs in component video and HDMI. If you have a tv which requires a composite source (i.e. the video
input on your TV just comes via one cable) then your going to have to be patient with a black and white picture for
a few more steps.

To get an image on your screen from your Apple TV you need to connect a cable from the green (luma) component output to
your yellow composite input and select 480i as the resolution for [NTSC](http://en.wikipedia.org/wiki/NTSC) or 576i for
[PAL](http://en.wikipedia.org/wiki/PAL) (or else it will flicker).

![Compisite TV Connector](https://raw.github.com/ColinWaddell/AppleTVGuide/master/readme_img/composite.jpg)









# Patching the Apple TV

The first thing we need to do is patch the apple tv using a memory stick. Thanks to the amazing work done at the
[PatchStickBuilder](http://patchstick.wikispaces.com/PatchStickBuilder) project this is one of the easiest parts of the
whole process and may be as far as you need to go in modifying your Apple TV.

First you need a USB key which has a capacity of over 1G. Head over to the
[PatchStickBuilder](http://patchstick.wikispaces.com/PatchStickBuilder) website and pick up the latest version of their
software.

![Patch Stick Builder](https://raw.github.com/ColinWaddell/AppleTVGuide/master/readme_img/patchstickbuilder.jpg)

Get the software to download the latest firmware. Plug in your USB key. Hit `create Patchstick` and let it do its
magic. When finished, unplug your AppleTV, plug in the USB key, then plug the Apple TV back in. Once loaded there will
be a pile of text on-screen showing the progress of the installation. After the installation is complete, unplug the
USB key, unplug your Apple TV, then plug your Apple TV back in. It will restart as normal, then once your at the main
menu your Apple TV will restart on its own. This should be the patching complete.

If the patch stick software is having issues with downloading the dmg is requires then a list of firmware versions is
held at [iClarified](http://www.iclarified.com/entry/index.php?enid=970) with links to downloads from the apple
website. I went for version 3.0.2

Also, not all USB keys work. If you plug it in and switch on the Apple TV and nothing happens then try another key.










# SSH Access

Your going to be using SSH quite a bit from now on. Access is gained using the command

    ssh frontrow@appletv.local

The default password is `frontrow`


![SSH](https://raw.github.com/ColinWaddell/AppleTVGuide/master/readme_img/ssh.png)







# Enabling Read/Write Support

This first thing you need to do if you want to start playing with your Apple TV is enable read/write support. SSH into
your Apple TV and run the following

    sudo -s
    mount -uw /
    touch /.readwrite
    reboot

You only have to do this once.








# Install NitoTV

This software is AMAZING. Installing NitoTV saves a lot of time as it provides us with an automated method of providing
a lot of functionality to the Apple TV.

From SSH run

    wget http://nitosoft.com/nitoTVInstaller_tt.zip
    unzip nitoTVInstaller_tt.zip
    cd nitoTV Take Three/
    sudo ./installme

This will restart Finder and provide the NitoTV menu.

More details can be found at [The AwkwardTV Forums](http://plugins.awkwardtv.org/det.php?recordID=nitoTV) please check
it out.

![Nito Screenshot](https://raw.github.com/ColinWaddell/AppleTVGuide/master/readme_img/nito.png)








# NitoTV Smart Installer

This piece of software takes care of installing all the things you really need to get the most from your Apple TV and
saves you the trouble of doing it manually.

From the [Nito Wiki](from http://wiki.awkwardtv.org/wiki/NitoTV)

> Once the smart installer finds the location to install from it will scan the AppleTV for any important missing kexts,
  frameworks or binaries (usb, udf, samba, bluetooth, dvdplayback etc) and install them in their proper location,
  taking care of any owners, permissions AND will add kexts necessary to load on startup to /etc/rc.local).
> 
> The smart installer will also take care of Turbo’s easy USB patching (not done prior to 0.2.5b9) A reboot will be
required for this to take effect.
> 
> Last but not least, the Smart Installer will fix any problems with the /etc/rc.local files not created by the prior
version (b8) and add the necessary kexts and the kextloader.

There have been a number of reports of people getting the ‘wrong permissions or owners to work properly’ screen while
using the smart installer with Nito 0.2.7 and after. A good fix is to SSH into the AppleTV and run the following:
 
    cd /System/Library/CoreServices/Finder.app/
    Contents/PlugIns/nitoTV.frappliance/Contents/Resources/
    sudo chmod 755 nitoHelper
    sudo chmod u+s nitoHelper


Running Smart Installer is as simple as getting your remote and pointing your Apple TV in the direction of
`Nito TV → Settings → Install Software → Smart Installer`. Then let it do its thing.







# Composite Output

_The following instructions are only for people needing a compisite output from their Apple TV. Please ignore if your
using the HDMI or component._

Finally, its time to get some colour!

If you havent installed the NitoTV Smart installer please follow the previous section of these instructions.

I realise that there is an automated installer for the composite plugin in Nito but it never worked for me so I have
just simplified the instructions from [AwkwardTV](http://wiki.awkwardtv.org/wiki/Composite)

SSH into your Apple TV and do the following

For [PAL](http://en.wikipedia.org/wiki/PAL):

    wget --no-check-certificate https://raw.github.com/ColinWaddell/AppleTVGuide/master/files/tvcomposite_pal.sh
    chmod +x tvcomposite_pal.sh
    sudo ./tvcomposite_pal.sh

For [NTSC](http://en.wikipedia.org/wiki/NTSC):

    wget --no-check-certificate https://raw.github.com/ColinWaddell/AppleTVGuide/master/files/tvcomposite_ntsc.sh
    chmod +x tvcomposite_ntsc.sh 
    sudo ./tvcomposite_ntsc.sh

Restart your Apple TV and check it out.








# Install Launcher

Next thing to install is the XBMC/Boxee Launcher.

SSH into your AppleTV and copy and paste the following commands into your terminal.

    cd /tmp/    
    wget --no-check-certificate https://raw.github.com/ColinWaddell/AppleTVGuide/master/files/Launcher-3.2.2-debug.run    
    chmod +x Launcher-3.2.2-debug.run    
    ./Launcher-3.2.2-debug.run

and you should see…

    Verifying archive integrity... All good.
    Uncompressing Launcher 3.2.2-debug......
    This installer must be run as root.
    Please enter your password below to authorize as root.
    In most cases, this password is "frontrow".
    Password:
    == Extracting XBMCLauncher.frappliance
    XBMCLauncher.frappliance successfully installed.
    Finder must be restarted in order to complete the installation.
    Would you like to do this now? (Y/n) Y
    == Restarting Finder





# Housekeeping

One thing before we go any further.

Space on the Apple TVs primary partition is limited to 1G. I imagine if your going on to follow the next set of
instructions to do with bittorrent and usenet, then your going to wanting easy access to the larger drive. Were going
to run a few commands, they will create a dirctory on your larger drive called Downloads, and also create a link to
this in your home directory.

SSH in and run the following

    cd /mnt/
    sudo -s
    mkdir Downloads
    chown frontrow:frontrow Downloads
    exit
    cd ~
    ln -s /mnt/Downloads Downloads

There we go.






# Install SAMBA

Need to run a few commands here then add some info to a conf file. Instructions from [AwkwardTV](http://wiki.awkwardtv.org/wiki/Enable_SAMBA_server)

SSH into your Apple TV and run the following:

    sudo -s
    cd /tmp
    wget --no-check-certificate https://raw.github.com/ColinWaddell/AppleTVGuide/master/files/samba3_macports_bin.tar.bz2
    tar -xvjpf samba3_macports_bin.tar.bz2 -C /
    mkdir /mnt/op
    ln -s /mnt/opt /opt
    cp /opt/local/etc/samba3/smb.conf.sample /opt/local/etc/samba3/smb.conf
    nano -w /opt/local/etc/samba3/smb.conf


Now scroll down and find the following chunk:

    [homes]
    comment = Home Directories
    browseable = no
    writable = yes

Now, I don't want to share this directory, I want to share my Downloads directory,
so I'm going to change that to now say this:

    [Downloads]
    comment = Downloads
    path = /mnt/Downloads
    public = yes
    writable = yes
    printable = no

Press `Ctrl-X` to exit Nano and hit `Y` to save the changes.

The SAMBA passwords are different from the user login ones. Give the user frontrow a password:

    sudo /opt/local/bin/smbpasswd -a frontrow

Change some permissions:

    sudo chown root:wheel /opt/local/sbin/smbd
    sudo chmod 4555 /opt/local/sbin/smbd
    sudo chown root:wheel /opt/local/sbin/nmbd
    sudo chmod 4555 /opt/local/sbin/nmbd

Last thing to do is get it setup to launch at boot:

    sudo nano -w /etc/rc.local

Scroll to the bottom and add the following text:

    # start the SAMBA service
    /opt/local/sbin/smbd -c /opt/local/etc/samba3/smb.conf
    /opt/local/sbin/nmbd -c /opt/local/etc/samba3/smb.conf

Press `Ctrl-X` to exit Nano and hit `Y` to save the changes, then restart the ATV `sudo reboot`.

From a Mac, to access this share, open finder and either hit `cmd+K` or go to `Go → Connect to Server`

In the server address box pop this in there: `smb://AppleTV.local/Downloads` hit Connect, and hopefully a window will
pop up showing you the contents of your Downloads folder.








# SABNZB Usenet Client

I’ve had good results using SABNZB as my Usenet client. Its web interface makes it perfect for the apple tv. My
instructions are a slightly streamlined version of those on [AwkwardTV](http://wiki.awkwardtv.org/wiki/SABnzbd)

SSH into your Apple TV and run the following commands:

    cd /tmp/
    wget --no-check-certificate https://raw.github.com/ColinWaddell/AppleTVGuide/master/files/SABnzbd-0.5.6-osx.dmg
    hdiutil mount SABnzbd-0.5.6-osx.dmg
    cp -R /Volumes/SABnzbd/SABnzbd.app/ /Applications/SABnzbd.app/

Next we need to make some slight modifications to the configuration.

Using Nano we need to add a line to a file, from the Apple TVs command line type

    nano -w /Applications/SABnzbd.app/Contents/Info.plist

Scroll down till you find the section which reads:

    <key>LSHasLocalizedDisplayName</key>
    <false/>
    <key>NSAppleScriptEnabled</key>
    <false/>

And change it to the following

    <key>LSHasLocalizedDisplayName</key>
    <false/>
    <key>LSUIElement</key>
     <string>1</string>
    <key>NSAppleScriptEnabled</key>
    <false/>

Press `Ctrl-X` to exit Nano and hit `Y` to save the changes.

The second alteration we need to make it to create a configuration file, run the command:

    nano -w /Applications/SABnzbd.app/Contents/Resources/sabnzbd.ini

Copy and Paste the following into the file:

    [misc]
    autobrowser = 0
    host = appletv.local

Save and exit.

SABNZB can then be ran using the command:

    open /Applications/SABnzbd.app/

To access SABNZB you just have to point your browser at `http://appletv.local:8080/sabnzbd/`








# Starting SABnzbd Automatically

This was a slight nightmare to get working. Started following this guide but it doesnt work. If you google about you’ll
find a couple other methods to launch it, like using rc.local, they dont work either.

These instructions, however, are gold.

The trick is to get SABnzbd to launch once the frontrow profile is loading. Thats why the all the instructions on the
net don't work. This may have something to do with SABnzbd having been updated after the instructions were written
(and subsequently copy+pasted from forum to forum).

Here we go, ssh in and run these commands:

    mkdir /Users/frontrow/Library/LaunchAgents/
    nano -w /Users/frontrow/Library/LaunchAgents/sabnzbd.plist

copy and paste the following into the file:

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" 
    "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
    <key>GroupName</key>
    <string>frontrow</string>
    <key>Label</key>
    <string>org.m0k.sabcheck</string>
    <key>ProgramArguments</key>
    <array>
    <string>/Users/frontrow/SABcheck.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>ServiceDescription</key>
    <string>sabcheck</string>
    <key>UserName</key>
    <string>frontrow</string>
    </dict>
    </plist>

Save and exit the file: `Ctrl-X` and `Y`.

Next we need to make a script to check if SABnzbd is running, and if not, launch it. From the terminal enter the following commands:

    touch /Users/frontrow/SABcheck.sh 
    chmod +x /Users/frontrow/SABcheck.sh
    nano -w /Users/frontrow/SABcheck.sh

then copy & paste this into the file:

    #!/bin/sh
    if ! ps -auxwww | grep -v grep | grep SABnzbd > /dev/null
    then
    open /Applications/SABnzbd.app &
    fi

Save and Exit. Your now done, restart your Apple TV and see if it has worked.








# Transmission Bittorrent Client

It has been a long road trying to find a good bit torrent client for the Apple TV and I am very pleased with the
results Ive had from running Transmission. Its web interface is wonderful.

First thing to get out the way is an acknowledgement to lfroen who I stumbled across via google. He has managed to
recompile Transmission for the Apple TV and even included the libcurl library in the process so you dont need to
install it separately. I have rehosted the files he made as I wanted to include another directory along with them.
If anyone has any issues with their content getting re-used in this way please contact me asap and Ill get it all
sorted, Ive only hosted the files myself out of sake of convenience for this guide.

Also, a few of the other instructions are again from
[AwkwardTV](http://wiki.awkwardtv.org/wiki/Transmission_on_AppleTV) but condensed.

Here we go….

First thing to do is SSH into the Apple TV and run the following commands. This will download and install transmission.

    cd /tmp/
    wget --no-check-certificate https://raw.github.com/ColinWaddell/AppleTVGuide/master/files/transmission-1.75-appletv-web.tgz
    tar xzvf transmission-1.75-appletv-web.tgz
    cd transmission-1.75-appletv-web
    sudo mv transmission-daemon transmission-remote /usr/sbin/

next we need to run transmission briefly to allow it to create its configuration files

    transmission-daemon -f

Then once its output has settled exit by typing `Ctrl-C`.

Next we need to make a couple of slight alterations to a settings file. From the Apple TV command line type:

    nano -w /Users/frontrow/Library/Application Support/transmission-daemon/settings.json

Your going to have to let transmission allow you to access it from inside your network. The network addresses in most
home networks have the form `192.168.*.*` so find the line that reads:

    “rpc-whitelist”: “127.0.0.1”,

and alter it so that it says:

    “rpc-whitelist”: “127.0.0.1,192.168.*.*”,

Save and exit.

Last thing that needs done is its web interface files need moved into place. Enter the following command:

    mv /tmp/transmission-1.75-appletv-web/web /Users/frontrow/Library/Application Support/transmission-daemon/web

Transmission can now be ran again:

    transmission-daemon -f

Transmission is access by pointing your browser at `http://appletv.local:9091/transmission/web/`

![SSH](https://raw.github.com/ColinWaddell/AppleTVGuide/master/readme_img/tranmission.png)






# Starting Transmission Automatically

These instructions only make sense if you have followed the installation instructions from above and have transmission
installed in `/usr/sbin/`

Skip the following step if you have followed the SABnzbd autostart instruction above, all it does it create the
required directory.

SSH into your Apple TV and running the following:

    mkdir /Users/frontrow/Library/LaunchAgents/

Right, here we go, this will only take a second.

SSH into your Apple TV and run this:

    nano -w /Users/frontrow/Library/LaunchAgents/transmission.plist

Now copy and paste the following into the file:

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" 
    "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
    <key>GroupName</key>
    <string>frontrow</string>
    <key>Label</key>
    <string>org.m0k.transmission</string>
    <key>ProgramArguments</key>
    <array>
    <string>transmission-daemon</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>ServiceDescription</key>
    <string>transmission-daemon</string>
    <key>UserName</key>
    <string>frontrow</string>
    </dict>
    </plist>

Save and exit. That should be you, restart and have a look.








