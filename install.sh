#!/usr/bin/bash

sudo add-apt-repository ppa:xubuntu-dev/staging -y
sudo apt-get update -y

wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes ./chrome-remote-desktop_current_amd64.deb

sudo DEBIAN_FRONTEND=noninteractive \
    apt install --assume-yes xfce4 nautilus firefox metacity

sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'

if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
  eval `dbus-launch --sh-syntax`
fi

gsettings set org.gnome.desktop.wm.preferences button-layout $(xfconf-query -c xsettings -p /Gtk/DecorationLayout)
xfconf-query -c xfce4-session -p /sessions/Failsafe/Client0_Command -n -a -t string -s "metacity"

rm *.deb
