#!/usr/bin/env bash

OUTPUT="gnome-settings-setup.sh"

{
    echo "#!/usr/bin/env bash"
    echo "set -e"
    echo ""
} > "$OUTPUT"

IGNORE_KEYS_REGEX='(last-save|recent|history|mru|last-directory|window-position|window-size)'
USER_HOME_REGEX="(${HOME}/)"

dconf dump / | while IFS= read -r line; do

    # Skip section headers
    if [[ "$line" =~ ^\[.*\]$ ]]; then
        current_schema=$(echo "$line" | tr -d '[]' | sed 's|/$||')
        continue
    fi

    # Skip empty lines
    [[ -z "$line" ]] && continue

    key="${line%%=*}"
    value="${line#*=}"

    # Skip volatile keys
    if [[ "$key" =~ $IGNORE_KEYS_REGEX ]]; then
        continue
    fi

    # Skip user home paths
    if [[ "$value" =~ $USER_HOME_REGEX ]]; then
        continue
    fi

    printf "gsettings set %q %q %q\n" "$current_schema" "$key" "$value"

done >> "$OUTPUT"

chmod +x "$OUTPUT"
echo "Export complete (true overrides only) => $OUTPUT"