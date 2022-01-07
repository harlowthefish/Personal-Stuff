#!/bin/bash
#A quick-start script with basic utilities/applications
#first the basics
if pacman -Qs git > /dev/null ;
    then
    echo "git is installed"
else
sudo pacman -S git
fi
if pacman -Qs base-devel > /dev/null ;
    then
    echo "base-devel is installed"
else
sudo pacman -S base-devel
fi
#if yay is not installed, install it now
if pacman -Qs yay > /dev/null ;
    then
    echo "yay is installed"
else
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
fi
#pacman/AUR installations
yay -S --noconfirm --sudoloop fish microsoft-edge-stable-bin menulibre dconf-editor pamac-all tlp tlpui thermald iio-sensor-proxy libreoffice-fresh file-roller gnome-disk-utility  intel-ucode-clear fastfetch-git
#flatpaks
flatpak install org.freedesktop.Platform org.freedesktop.Platform.GL.default org.freedesktop.Platform.VAAPI.Intel org.freedesktop.Platform.openh264 org.gnome.Platform com.github.alainm23.planner com.github.tenderowl.norka com.github.wwmm.easyeffects org.freedesktop.LinuxAudio.Plugins.LSP org.freedesktop.LinuxAudio.Plugins.ZamPlugins org.zim_wiki.Zim
#setting up VAAPI in edge
mkdir -p ~/.local/share/applications
cp /usr/share/applications/microsoft-edge.desktop ~/.local/share/applications
sed -i 's:Exec=/usr/bin/microsoft-edge-stable":Exec=/usr/bin/microsoft-edge-stable --enable-feature=VaapiVideoDecoder --use-gl=desktop:g' ~/.local/share/applications/microsoft-edge.desktop
exit
# installing the linux-clear kernel
yay -S linux-clear
exit
