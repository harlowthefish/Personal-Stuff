#!/bin/bash
#A pantheon installation script that accounts for some of the inconsistensies and issues in existing solutions
#things that just work (tm)
#this will need yay, so let's check if it's installed and install it if it's not
if pacman -Qs yay > /dev/null ;
    then
    echo "yay is installed, proceeding"
else
echo "yay is not installed, but is needed for this script; installing it now"
if pacman -Qs git > /dev/null ;
    then
    echo "git is installed"
else
echo "git is not installed; installing it now"
sudo pacman -S git
fi
if pacman -Qs base-devel > /dev/null ;
    then
    echo "base-devel is installed"
else
echo "base-devel is not installed; installing it now"
sudo pacman -S base-devel
fi
git clone https://aur/archlinux.org/yay-bin.git
cd yay-bin makepkg -si
echo "yay is now installed, proceeding"
fi
echo "these packages all work without issues, and will be downloaded from repositories"
yay -S --noconfirm --sudoloop xorg-server lightdm lightdm-pantheon-greeter wingpanel pantheon-applications-menu pantheon-notifications pantheon-terminal switchboard wingpanel-indicator-a11y wingpanel-indicator-bluetooth wingpanel-indicator-datetime wingpanel-indicator-keyboard wingpanel-indicator-network wingpanel-indicator-nightlight wingpanel-indicator-notifications wingpanel-indicator-power wingpanel-indicator-session wingpanel-indicator-sound switchboard-plug-a11y switchboard-plug-about switchboard-plug-applications switchboard-plug-bluetooth switchboard-plug-datetime switchboard-plug-desktop switchboard-plug-display switchboard-plug-keyboard switchboard-plug-locale switchboard-plug-mouse-touchpad switchboard-plug-network switchboard-plug-notifications switchboard-plug-online-accounts switchboard-plug-parental-controls switchboard-plug-power switchboard-plug-printers switchboard-plug-security-privacy switchboard-plug-sharing switchboard-plug-sound switchboard-plug-user-accounts switchboard-plug-wacom switchboard-plug-pantheon-tweaks-git pantheon-calculator pantheon-calendar pantheon-camera pantheon-code pantheon-files pantheon-mail pantheon-music pantheon-photos pantheon-screenshot pantheon-tasks pantheon-videos elementary-icon-theme elementary-wallpapers gtk-theme-elementary pantheon-default-settings pantheon-session pantheon-settings-daemon sound-theme-elementary capnet-assist cerbere contractor granite pantheon-geoclue2-agent pantheon-onboarding pantheon-polkit-agent pantheon-shortcut-overlay pantheon-sideload touchegg inter-font ttf-opensans ttf-roboto-mono
#things that are busted and need manual compilation for now
echo "these "
git clone https://github.com/elementary/dock
git clone https://github.com/elementary/gala
git clone https://github.com/elementary/switchboard-plug-mouse-touchpad
cd ~/dock
meson build --prefix=/usr
cd build
ninja
sudo ninja install
cd ~/gala
meson build --prefix=/usr
cd build
ninja
sudo ninja install
cd ~/switchboard-plug-mouse-touchpad
sed -i 's/option('gnome_40', type : 'boolean', value : false)/option('gnome_40', type : 'boolean', value : true)'  ~/switchboard-plug-mouse-touchpad/meson_options.txt
meson build --prefix=/usr
ninja
sudo ninja install
cd ~/
#getting stuff set up
clear
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
gsettings set org.gnome.desktop.interface font-name 'Inter 9'
gsettings set org.gnome.desktop.interface document-font-name 'Open Sans 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'Roboto Mono 10'
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/odin.jpg
clear
sudo sed -i -e '$aHidden=true' /usr/share/applications/bvnc.desktop
sudo sed -i -e '$aHidden=true' /usr/share/applications/bssh.desktop
sudo sed -i -e '$aHidden=true' /usr/share/applications/avahi-discover.desktop
sudo sed -i -e '$aHidden=true' /usr/share/applications/qv4l2.desktop
sudo sed -i -e '$aHidden=true' /usr/share/applications/qvidcap.desktop
sudo sed -i -e '$aHidden=true' /usr/share/applications/gda-browser-5.0.desktop
sudo sed -i -e '$aHidden=true' /usr/share/applications/gda-control-center-5.0.desktop
sudo sed -i -e '$aHidden=true' /usr/share/applications/plank.desktop
clear
sudo sed -i '102i\greeter-session=io.elementary.greeter' /etc/lightdm/lightdm.conf
sudo systemctl enable lightdm
echo "if nothing broke then you're probably clear to reboot and get into pantheon"
exit ;
