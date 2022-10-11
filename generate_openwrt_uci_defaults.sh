#!/bin/sh
# Create OpenWRT uci-defaults file for image builder
# copy generated file to 'files/etc/uci-defaults/' folder in your image builder directory
# 5p0ng3b0b - hxxps://unix.stackexchange.com/questions/539477/how-to-get-all-the-configuration-options-with-the-uci-command-in-openwrt
script="/tmp/99-custom"
echo "#!/bin/sh" > "$script"
echo "uci -q batch << EOI" >> "$script"
for section in $(uci show | awk -F. '{print $1}' | sort -u); do
uci show "$section" | awk -F. '{print "set "$0}' >> "$script"
echo "commit $section" >> "$script"
echo "EOI" >> "$script"
chmod 755 "$script"
done
