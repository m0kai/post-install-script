#!/bin/bash
echo 'QT_QPA_PLATFORMTHEME="wayland;xcb"' | sudo tee -a /etc/environment > /dev/null
echo 'GBM_BACKEND=nvidia-drm' | sudo tee -a /etc/environment > /dev/null
echo '__GLX_VENDOR_LIBRARY_NAME=nvidia' | sudo tee -a /etc/environment > /dev/null
echo 'ENABLE_VKBASALT=1' | sudo tee -a /etc/environment > /dev/null
echo 'LIBVA_DRIVER_NAME=nvidia' | sudo tee -a /etc/environment > /dev/null
echo 'WLR_NO_HARDWARE_CURSORS=1' | sudo tee -a /etc/environment > /dev/null
echo 'Put the following into MODULES=() in  /etc/mkinitcpio.conf'
echo 'nvidia nvidia_modeset nvidia_uvm nvidia_drm'
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
sudo mkinitcpio -P
echo 'Put the following into /boot/loader/entries/xxx.conf'
echo "nvidia-drm.modeset=1"
