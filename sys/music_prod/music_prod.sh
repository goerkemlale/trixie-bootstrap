#!/bin/bash

# Change Working Directory for external sh call
cd "$(dirname "$0")"

# ardour

mkdir $HOME/daw/.vst3/ $HOME/daw/.lv2/ $HOME/daw/.vst/ $HOME/daw/.clap/

# Sfizz
music_prod/install_sfizz.sh

# ZynAddSubFX
music_prod/install_zyn.sh

# Cardinal VCV Rack
music_prod/install_cardinal.sh

# Synth1 by Ichiro Toda
music_prod/install_synth1.sh

# Surge XT
music_prod/install_surge.sh

# Dexed
music_prod/install_dexed.sh

# LSPlugins
music_prod/install_lsplugins.sh

# Yabridge
music_prod/install_yabridge.sh

echo "Need to install Vital Synth from website. Loginware"
echo "Need to install BBC Symphony and other Spitfire LABS plugins. Loginware."
echo "Need to install Virtual Playing Orchestra. OneDrive needs auth"
echo "Spitfire needs to be installed within Wine (installed DXVK lib). Screen unresponsible. But inside DAW GUI is bug-free"
echo "Don't forget to add new Yabridge paths: Spitfire"
