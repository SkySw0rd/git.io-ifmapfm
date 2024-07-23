sudo crouton -r noble -t core -n neon && \

sudo enter-chroot -n neon -u 0 bash -c "\
    apt install software-properties-common -y && \
    wget -qO - 'http://archive.neon.kde.org/public.key' | sudo apt-key add - && \
    sudo apt-add-repository http://archive.neon.kde.org/user && \
    sudo apt update && \
    sudo apt full-upgrade -y && \
    sudo apt install xterm xinit -y" && \

sudo crouton -r noble -t xorg -n neon -u && \

sudo enter-chroot -n neon -u 0 bash -c "\
    apt install neon-desktop -y && \
    apt install xserver-xorg-input-synaptics -y && \
    apt remove xterm -y && \
    apt auto-remove -y" && \


sudo echo '#!/bin/sh -e
# Copyright (c) 2016 The crouton Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set -e

APPLICATION="${0##*/}"

USAGE="$APPLICATION [options]

Wraps enter-chroot to start a KDE session.
By default, it will log into the primary user on the first chroot found.

Options are directly passed to enter-chroot; run enter-chroot to list them."

exec sh -e "`dirname "\`readlink -f -- "$0"\`"`/enter-chroot" -n neon "$@" "" \
    exec xinit /usr/bin/startplasma-x11' | sudo tee /usr/local/bin/startplasma && \
    sudo chmod +x /usr/local/bin/startplasma && \
    
echo -e "\n\nKDE Neon has been installed.\nStart with: sudo startplasma\n"
