#!/usr/bin/env bash

OUTPUT="gnome-settings-setup.sh"

{
    echo "#!/usr/bin/env bash"
    echo "set -e"
    echo ""
} > "$OUTPUT"

while IFS= read -r schema; do
    while IFS= read -r key; do
        value=$(gsettings get "$schema" "$key")
        printf "gsettings set %q %q %q\n" "$schema" "$key" "$value"
    done < <(gsettings list-keys "$schema")
done < <(gsettings list-schemas) >> "$OUTPUT"

chmod +x "$OUTPUT"
echo "Export complete -> $OUTPUT"