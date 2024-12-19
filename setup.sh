#!/bin/sh

function core(){
	echo -e "\e[32mInstalling Core System utils\e[0m"
	sudo pacman -Syu alsa-firmware alsa-plugins alsa-utils gst-libav gst-plugin-pipewire gst-plugins-bad gst-plugins-ugly libdvdcss pavucontrol pipewire-alsa pipewire-jack pipewire-pulse rtkit sof-firmware wireplumber mesa mesa-utils nvidia nvidia-utils xf86-input-libinput xf86-video-amdgpu xf86-video-ati xorg-server xorg-xdpyinfo xorg-xinit xorg-xinput xorg-xkill xorg-xrandr intel-ucode firefox neovim btop htop neofetch telegram-desktop wget python-pywal ranger rofi kitty python-pillow git tor flameshot npm vlc pavucontrol discord kleopatra keepassxc pidgin qbittorrent thunar picom
}

function demon_settings(){
	echo -e "\e[32mSetting up Demons\e[0m"
	sudo systemctl enable tor
}

function configure_aur_yay(){
	echo -e "\e[32mConfiguring and Downloading yay\e[0m"
	git clone https://aur.archlinux.org/yay.git /tmp/yay
	cd /tmp/yay
	makepkg -si
}

function setup_config(){
	echo -e "\e[32mSetting up configs\e[0m"
	git cloning the repo 
	git clone https://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@github.com/graymatter10/dotfilesv2 /tmp/dotfiles
	cd /tmp/dotfiles/config
	cp -r kitty nvim rofi wal picom ranger tgpt tmux ~/.config/
}

function zsh_config(){
	echo -e "\e[32mConfiguring zsh\e[0m"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	sed -i 's/robbyrussell/gnzh/g' ~/.zshrc
	echo "(cat ~/.cache/wal/sequences &)" >> ~/.zshrc
	source ~/.zshrc
}



function wm_config(){
	if [ $wm = "i3" ]; then 
		echo -e "\e[32mSetting up i3\e[0m"
		cd /tmp/dotfiles/config
		cp -r i3 rofi ~/.config/
	elif [ $wm = "dwm" ]; then 
		echo -e "\e[31mdwm not Available\e[0m"
		exit
	else
		echo -e "\e[31mSomething Error on wm_config\e[0m"
	fi
}

function download_wallpapers(){
	echo -e "\e[32mSetting up Wallpapers\e[0m"
	mkdir ~/Pictures
	git clone https://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@github.com/graymatter10/wallpapers ~/Pictures/Wallpapers/
}

echo -n "Available Gui Option
1.i3
2.dwm
Which window manager do you want => "
read cwm
if [ $cwm = 1 ]; then 
	wm="i3"
elif [ $cwm = 2 ]; then 
	wm="dwm"
else
	echo -e "\e[31mPlease chose the correct option\e[0m"
	exit
fi
echo -n "Do you wanna download Wallpapers??(y/n)"
read cwal

if [[ $cwal != "y" && $cwal != "n" ]]; then 
	echo -e "\e[31mPlease chose the correct option\e[0m"
	exit
fi

echo -e "\e[32mPlease Ctrl+c if you wanna don't want the configs\e[0m"
sleep 5

echo "

"

core
demon_settings
setup_config
wm_config $wm
zsh_config
if [ $cwal = "y" ]; then 
	download_wallpapers
fi


