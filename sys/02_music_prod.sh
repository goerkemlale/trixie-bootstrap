#!/bin/bash

# Change Working Directory for external sh call
cd "$(dirname "$0")"

# Function to check if user wants to continue
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

# Function to append limits to /etc/security/limits.d/audio.conf
add_audio_limits() {
    # Define the lines to be appended
    local lines="@audio   -  rtprio     95
@audio   -  memlock    unlimited"

    # Ask the user to type 'yes' to continue
    echo "Type 'yes' to append the audio limits to /etc/security/limits.d/audio.conf"
    read user_input

    # Check if the input is 'yes'
    if [[ "$user_input" != "yes" ]]; then
        echo "You did not type 'yes'. Skipping this step."
        return  # Exit the function and continue with the script
    fi

    # If the user typed 'yes', append the lines
    echo "You typed 'yes'. Appending the following lines to /etc/security/limits.d/audio.conf:"

    # Check if the file exists, create it if not
    if [ ! -f /etc/security/limits.d/audio.conf ]; then
        echo "File /etc/security/limits.d/audio.conf does not exist. Creating it..."
        sudo touch /etc/security/limits.d/audio.conf
    fi

    # Append the lines to the file
    echo "$lines" | sudo tee -a /etc/security/limits.d/audio.conf > /dev/null

    echo "Lines have been successfully appended."
    echo "Now adding current user to audio group..."
    sudo groupadd audio
    sudo usermod -a -G audio $USER
    echo "$USER is now in audio group"
}

echo "Installing music production suite. Continue?"
ask_for_confirmation

# Install audio interface
echo "Installing PipeWire"
sudo apt-fast install alsa-utils pipewire pipewire-audio pipewire-audio-client-libraries pipewire-alsa pipewire-jack wireplumber

# Tell all apps that use JACK to now use the Pipewire JACK
sudo "Configuring PipeWire to fool JACK programs"
sudo cp /usr/share/doc/pipewire/examples/ld.so.conf.d/pipewire-jack-*.conf /etc/ld.so.conf.d/
sudo ldconfig

# CPU Options
sudo echo 'vm.swappiness=10' >> /etc/sysctl.d/99-sysctl.conf

echo "Optional:"
echo "make sure in /etc/default/grub 'preempt', 'threadirqs' and 'governor' same as below:"
echo 'GRUB_CMDLINE_LINUX="preempt=full threadirqs cpufreq.default_governor=performance"'
echo "---------------------------------------------------------------------------------"
echo "Current status of the grub file at mentioned line:"
grep GRUB_CMDLINE_LINUX= /etc/default/grub
echo "---------------------------------------------------------------------------------"
echo "Checked it. Then, add that line and run sudo update-grub. Type yes if you completed this step."
ask_for_confirmation

# Audio Group with RT
echo "Check if following lines are present:"
echo "@audio   -  rtprio     95"
echo "@audio   -  memlock    unlimited"
echo "Content of the :/etc/security/limits.d/audio.conf"
echo "--------------------------------------------------"
cat /etc/security/limits.d/audio.conf
echo "--------------------------------------------------"
echo "Add the necessary lines?"
add_audio_limits

# Ardour
echo "Creating plugin folder in $HOME/.daw"
echo "Do not forget to include these folders in Ardour"
mkdir -p $HOME/.daw/vst3/ $HOME/.daw/lv2/ $HOME/.daw/vst/ $HOME/.daw/.clap/

# Plugins
echo "Select programs to install"
echo "1 - Sfizz SFZ Rompler"
echo "2 - ZynAddSubFX"
echo "3 - Cardinal VCV Rack"
echo "4 - Surge XT Synth"
echo "5 - LSPlugins"
echo "6 - Yabridge"

read -p "Enter your choices (e.g., 2 3 - Splitted by space): " user_input
choices=($user_input)

for choice in "${choices[@]}"; do
    case $choice in
        1)
            echo "Installing SFizz..."
            bash "music_prod/install_sfizz.sh"
            ;;
        2)
            echo "Installing ZynAddSubFX."
            bash "music_prod/install_zyn.sh"
            ;;
        3)
            echo "Installing Cardinal..."
            bash "music_prod/install_cardinal.sh" 
            ;;
        4)
            echo "Installing SurgeXT..."
            bash "music_prod/install_surge.sh"
            ;;
        5)
            echo "Installing LSPlugins..."
            bash "music_prod/install_lsplugins.sh"
            ;;
        6)
            echo "Installing Yabridge..."
            bash "music_prod/install_yabridge"
            ;;
        *)
            echo "Invalid option: $choice. Please choose 1 to 6"
            ;;
    esac
done

# Status of the setup: rtcqs
# Check the output of the Python script. It will guide you.
git clone https://codeberg.org/rtcqs/rtcqs.git
cd rtcqs
./src/rtcqs/rtcqs.py

echo "Need to install BBC Symphony and other Spitfire LABS plugins. Loginware."
echo "Need to install Virtual Playing Orchestra. OneDrive needs auth"
echo "Spitfire needs to be installed within Wine (installed DXVK lib). Screen unresponsible. But inside DAW GUI is bug-free"
echo "Don't forget to add new Yabridge paths: Spitfire"
echo "Finishing Music Production Suie Installation"
