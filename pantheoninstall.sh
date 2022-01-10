#!/bin/bash
#checking if yay is installed and installing it if it isn't
echo "this script requires yay"
if pacman -Qs yay > /dev/null ;
    then
    echo "yay is already installed, continuing"
else
echo "to install yay, git and base-devel are required"
if pacman -Qs git > /dev/null ;
    then
    echo "git is already installed, continuing"
else
echo "installing git"
sudo pacman -S --noconfirm git
echo "git is installed"
fi
if pacman -Qs base-devel > /dev/null ;
    then
    echo "base-devel is already installed, continuing"
else
echo "installing base-devel"
sudo pacman -S --noconfirm base-devel
echo "base-devel is installed"
fi
git clone https://aur.archlinux.org/yay-bin.git ;
cd yay-bin ;
makepkg -si --noconfirm ;
fi
cd ~ ;
sudo pacman -Syyu --noconfirm
#getting the the components that work properly from repos
echo "beginning installation of working basic components from available repositories"
yay -S --nocleanmenu --nodiffmenu --noeditmenu --noconfirm xorg-server lightdm lightdm-pantheon-greeter wingpanel pantheon-applications-menu pantheon-notifications pantheon-terminal switchboard wingpanel-indicator-bluetooth wingpanel-indicator-datetime wingpanel-indicator-keyboard wingpanel-indicator-network wingpanel-indicator-nightlight wingpanel-indicator-notifications wingpanel-indicator-power wingpanel-indicator-session wingpanel-indicator-sound switchboard-plug-about switchboard-plug-applications switchboard-plug-bluetooth switchboard-plug-datetime switchboard-plug-desktop switchboard-plug-display switchboard-plug-locale switchboard-plug-network switchboard-plug-notifications switchboard-plug-online-accounts switchboard-plug-parental-controls switchboard-plug-power switchboard-plug-printers switchboard-plug-security-privacy switchboard-plug-sharing switchboard-plug-sound switchboard-plug-user-accounts switchboard-plug-wacom pantheon-session pantheon-settings-daemon switchboard-plug-pantheon-tweaks-git pantheon-settings-daemon capnet-assist cerbere contractor granite pantheon-geoclue2-agent pantheon-onboarding pantheon-polkit-agent pantheon-shortcut-overlay pantheon-sideload flatpak touchegg meson
#installing applications
echo "installing default applications"
yay -S --nocleanmenu --nodiffmenu --noeditmenu --noconfirm pantheon-calculator pantheon-calendar pantheon-camera pantheon-code pantheon-files pantheon-mail pantheon-music pantheon-photos pantheon-screenshot pantheon-tasks pantheon-videos
#installing visual components
echo "installing visual components"
yay -S --nocleanmenu --nodiffmenu --noeditmenu --noconfirm elementary-icon-theme elementary-wallpapers gtk-theme-elementary sound-theme-elementary inter-font ttf-opensans ttf roboto-mono
#compiling broken/buggy/incomplete packages from source
echo "some packages have issues, so they need to be compiled from source"
git clone https://github.com/elementary/switchboard-plug-mouse-touchpad
git clone https://github.com/elementary/gala
git clone https://github.com/elementary/dock
git c
echo "installing switchboard-plug-mouse-touchpad from source"
cd switchboard-plug-mouse-touchpad
sed -i 's/option('gnome_40', type : 'boolean', value : false)/option('gnome_40', type : 'boolean', value : true)' ~/switchboard-plug-mouse-touchpad/meson_options.txt
meson build --prefix=/usr
cd build
ninja
sudo ninja install
echo "installing gala window manager from source"
cd ~/gala
meson build --prefix/usr
cd build
ninja
sudo ninja install
echo "installing plank from source"
cd ~/dock
meson build --prefix=/usr
cd build
ninja
sudo ninja install
cd ~
#configuration
echo "configuring Pantheon"
sudo echo "[Desktop Entry]
Name=Plank
Comment=Stupidly simple.
Exec=plank
Icon=plank
Terminal=false
Type=Application
Categories=Utility;
NoDisplay=true
X-GNOME-Autostart-Notify=false
X-GNOME-AutoRestart=true
X-GNOME-Autostart-enabled=true
X-GNOME-Autostart-Phase=Panel
OnlyShowIn=Pantheon;
" > plank.desktop
sudo mv plank.desktop /etc/xdg/autostart/
yay -S pantheon-default-settings
systemctl enable touchegg.service
systemctl start touchegg
sudo echo "gsettings set org.gnome.desktop.interface font-name 'Inter 9'
gsettings set org.gnome.desktop.interface document-font-name 'Open Sans 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'Roboto Mono 10'
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/odin.jpg
sudo rm /etc/xdg/autostart/firstboot.sh
rm -rf ~/switchboard-plug-mouse-touchpad
rm -rf ~/gala
rm -rf ~/dock
" > firstboot.sh
sudo mv firstboot.sh /etc/xdg/autostart/
sudo sed -i -e '$aHidden=true' /usr/share/applications/bvnc.desktop
sudo sed -i -e '$aHidden=true' /usr/share/applications/bssh.desktop
sudo sed -i -e '$aHidden=true' /usr/share/applications/avahi-discover.desktop
sudo sed -i -e '$aHidden=true' /usr/share/applications/qv4l2.desktop
sudo sed -i -e '$aHidden=true' /usr/share/applications/qvidcap.desktop
sudo sed -i -e '$aHidden=true' /usr/share/applications/gda-browser-5.0.desktop
sudo sed -i -e '$aHidden=true' /usr/share/applications/gda-control-center-5.0.desktop
sudo sed -i -e '$aHidden=true' /usr/share/applications/plank.desktop
sudo sed -i '102i\greeter-session=io.elementary.greeter' /etc/lightdm/lightdm.conf
sudo systemctl enable lightdm
echo "if nothing broke then you're probably clear to reboot and get into pantheon"
exit ;
