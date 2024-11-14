#!/bin/bash

ask_for_confirmation() {
    echo "Type 'yes' to continue, or anything else to exit:"
    read input

    # Check if the input is 'yes'
    if [[ "${input,,}" == "yes" ]]; then
        return 0  # Continue the script
    else
        echo "Exiting the script."
        exit 1  # Exit the script
    fi
}

echo "Installing music production suite. Continue?"
ask_for_confirmation

# Change Working Directory for external sh call
cd "$(dirname "$0")"

# Status of the setup: rtcqs
# Check the output of the Python script. It will guide you.
git clone https://codeberg.org/rtcqs/rtcqs.git
cd rtcqs
./src/rtcqs/rtcqs.py

# Audio Group with RT


# ardour

mkdir $HOME/.daw/vst3/ $HOME/.daw/lv2/ $HOME/.daw/vst/ $HOME/.daw/.clap/


# Sfizz
echo "Installing Sfizz. Continue?"
ask_for_confirmation

music_prod/install_sfizz.sh

# ZynAddSubFX
echo "Installing ZynAddSubFX. Continue?"
ask_for_confirmation

music_prod/install_zyn.sh

# Cardinal VCV Rack
echo "Installing ZynAddSubFX. Continue?"
ask_for_confirmation

music_prod/install_cardinal.sh


# Surge XT
echo "Installing Surge XT. Continue?"
ask_for_confirmation

music_prod/install_surge.sh

# LSPlugins
echo "Installing LSPlugins. Continue?"
ask_for_confirmation

music_prod/install_lsplugins.sh

# Yabridge
echo "Installing Yabridge. Continue?"
ask_for_confirmation

music_prod/install_yabridge.sh

echo "Need to install BBC Symphony and other Spitfire LABS plugins. Loginware."
echo "Need to install Virtual Playing Orchestra. OneDrive needs auth"
echo "Spitfire needs to be installed within Wine (installed DXVK lib). Screen unresponsible. But inside DAW GUI is bug-free"
echo "Don't forget to add new Yabridge paths: Spitfire"
echo "Finishing Music Production Suie Installation"
