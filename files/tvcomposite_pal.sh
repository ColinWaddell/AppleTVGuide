#!/bin/sh
echo "Remounting filesystem read-write..."
sudo mount -uw /
echo "Downloading the TVComposite kernel extension..."
wget "http://nitosoft.com/awkward/tvcomposite_pal.tar"
tar xvf tvcomposite_pal.tar


sudo chmod -R 755 TVComposite.kext
sudo chown -R root:wheel TVComposite.kext
echo "Installing TVComposite into /System/Library/Extensions..."
sudo mv TVComposite.kext /System/Library/Extensions
echo "Downloading the turbo_atv_enabler..."
rm turbo_atv_enabler.bin*
wget http://0xfeedbeef.com/appletv/turbo_atv_enabler.bin
chmod u+x turbo_atv_enabler.bin
sudo rm -r /System/Library/StartupItems/ATV_Color
sudo mkdir /System/Library/StartupItems/ATV_Color
sudo touch /System/Library/StartupItems/ATV_Color/ATV_Color
sudo echo '#!/bin/sh
. /etc/rc.common
/Users/frontrow/turbo_atv_enabler.bin
kextload /System/Library/Extensions/TVComposite.kext' > /System/Library/StartupItems/ATV_Color/ATV_Color
sudo chmod +x /System/Library/StartupItems/ATV_Color/ATV_Color
sudo touch /System/Library/StartupItems/ATV_Color/StartupParameters.plist
sudo echo '{
Description     = "Load Composite Kext";
Provides        = ("Composite");
OrderPreference = "First";
}' > /System/Library/StartupItems/ATV_Color/StartupParameters.plist
sudo chown -R root:wheel /System/Library/StartupItems/ATV_Color/
rm -r TVComposite*

echo "Enabling composite-colour mode..."
sudo ./turbo_atv_enabler.bin
sudo kextload /System/Library/Extensions/TVComposite.kext
