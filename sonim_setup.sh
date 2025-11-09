#!/bin/bash

apk_list=(
	"https://zello.com/data/android/latest/zello-sonim.apk"
	"https://f-droid.org/repo/at.bitfire.davdroid_405030003.apk"
	"https://f-droid.org/F-Droid.apk"
	"https://f-droid.org/repo/com.aurora.store_70.apk"
	"https://github.com/sspanak/tt9/releases/download/v53.0/tt9-v53.0.apk"
	"https://github.com/virresh/matvt/releases/download/phone-v1.03/matvt-v1.0.3-phone-app-release.apk"
	"https://github.com/tw-hx/Signal-Android/releases/download/v7.54.1.0-FOSS/Signal-Android-website-foss-prod-universal-release-signed-7.54.1.apk"
)

# APK downloader and installer
fetch_and_install(){
	local url="$1"
	local filename
	local tmp_dir="/tmp/sonim"

	if [ -z "$url" ]; then
		echo "Error: URL not provided."
		return 1
	fi

	filename=$(basename "$url")

	if [ -z "$filename" ]; then
		echo "Error: Could not extract filename from URL."
		return 1
	fi

	if [ ! -d "$tmp_dir" ]; then
		mkdir -p "$tmp_dir"
	fi

	echo "Downloading $url to $tmp_dir/$filename..."
	if ! wget -q "$url" -O "$tmp_dir/$filename"; then
		echo "Error: Failed to download file."
		return 1
	fi

	echo "Installing $tmp_dir/$filename on handset..."
		if ! adb install "$tmp_dir/$filename"; then
		echo "Error: Failed to install APK. Make sure adb is properly configured and the handset is connected."
		return 1
	fi
}

echo "Sonim XP3plus 5G Autoconfigure script"
echo
echo "DEVELOPER MODE SETUP INSTRUCTIONS"
echo "1. From the main screen, press the *#*#0701#*#* keys and click the \"OPEN DIAG PROPERTY\" button"
echo "2. Navigate to System Settings -> About phone -> Build number and click the entry 7 times"
echo "3. Press the back button and select System -> Developer options and toggle \"Use developer options\" to ON"
echo "4. Within developer options, scroll down to \"Debugging\" and toggle \"USB debugging\" to ON"
echo "5. Connect the handset to your computer via the USB-C port"
echo
echo "Ensure that the Sonim handset is connected"
echo
echo "The following applications will be installed:"
echo -e "Zello (Sonim) \nDAVx5 (v4.5.3-ose) \nF-Droid (latest) \nAurora Store (v4.7.4) \nTraditional T9 (v53.0) \nMATVT (v1.0.3) \nSignal (v7.54.1.0-FOSS)"
echo
read -p "Continue? (Y/n): " continue

if [[ "$continue" != "y" && "$continue" != "Y" ]]; then
	echo "Terminating"
	exit 1
fi

# Fetch and install apps
for apk in "${apk_list[@]}"; do
	fetch_and_install "$apk"
done

# Setup MATVT mouse
echo "Configuring MATV mouse..."
adb shell appops set com.android.cts.io.github.virresh.matvt SYSTEM_ALERT_WINDOW allow
adb shell settings put secure accessibility_enabled 1
adb shell settings put secure enabled_accessibility_services com.android.cts.io.github.virresh.matvt/com.android.cts.io.github.virresh.matvt.services.MouseEventService
adb shell am startservice com.android.cts.io.github.virresh.matvt/com.android.cts.io.github.virresh.matvt.services.MouseEventService

# Setup TT9 keyboard
echo "Enabling Traditional T9 Keyboard..."
adb shell ime enable io.github.sspanak.tt9/.ime.TraditionalT9
echo "Setting Traditional T9 Keyboard as default..."
adb shell ime set io.github.sspanak.tt9/.ime.TraditionalT9

# Set F-Droid installer permissions
echo "Setting F-Droid app installation permissions..."
adb shell appops set --uid org.fdroid.fdroid REQUEST_INSTALL_PACKAGES allow 

# Set system-wide dark mode
echo "Enabling system-wide dark mode..."
adb shell settings put secure ui_night_mode 2
echo "Dark mode will take effect on handset restart"

# Setup Signal repo
echo "Opening Signal-FOSS F-Droid repo on handset..."
adb shell am start -a android.intent.action.VIEW -d fdroidrepos://fdroid.twinhelix.com/fdroid/repo?fingerprint=7B03B0232209B21B10A30A63897D3C6BCA4F58FE29BC3477E8E3D8CF8E304028
echo -e "Click the \"Add Repository\" button on the handset"

# Post-install
echo "Handset configured. Several post-install steps are required:"
echo "- Open MATVT mouse app and check \"Override Activation Key\", enter \"17\" and select \"SAVE\""

