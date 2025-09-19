# SonimXP3plus5G-Automated-Setup
Automates app installation and setup for the Sonim XP3plus 5G

# What this tool does
* Easily walks the user through enabling developer mode
* Automatically installs and configures MATVT virtual mouse
* Automatically installs and activates Traditional T9 keyboard
* Installs F-Droid and sets permissions for allowing app installation
* Enables system-wide dark mode
* Installs Signal-FOSS and guides the user through F-Droid repo installation
* Installs the Sonim specific build for Zello
* Installs Aurora Store for anonymous Play Store app downloads
* Installs DAVx^(5) for Contacts and Calendar synchronization via CardDAV/CalDAV

# Instructions for Use
1. Download script to your computer
2. Check that the script is executable ``chmod u+x sonim_setup.sh``
3. Ensure that Developer Mode is activate
4. Connect handset to computer via the USB-C port
5. Execute the setup script with ``./sonim_setup.sh`` and follow the on-screen instructions
6. Profit

# Developer Mode Activation Steps
1. From the main screen, press the ``*#*#0701#*#*`` keys and click the ``OPEN DIAG PROPERTY`` button
2. Navigate to System Settings -> About phone -> Build number and click the entry 7 times
3. Press the back button and select System -> Developer options and toggle "Use developer options" to ON
4. Within developer options, scroll down to "Debugging" and toggle "USB debugging" to ON


# Software versions installed
* Zello (v6.10.1-Sonim) 
* DAVx5 (v4.5.3-ose) 
* F-Droid (latest) 
* Aurora Store (v4.7.4) 
* Traditional T9 (v53.0) 
* MATVT (v1.0.3) 
* Signal (v7.54.1.0-FOSS)
