#!/bin/bash
# Save as ~/.local/bin/browser-opener.sh

# Get the URL from clipboard or passed argument
URL="${1:-$(wl-paste)}"

# Create array of installed browsers
get_browsers() {
    browsers=()
    # Check for common browsers
    [[ -x $(command -v firefox) ]] && browsers+=("Firefox")
    [[ -x $(command -v chromium) ]] && browsers+=("Chromium")
    [[ -x $(command -v brave) ]] && browsers+=("Brave")
    [[ -x $(command -v vivaldi) ]] && browsers+=("Vivaldi")
    [[ -x $(command -v google-chrome) ]] && browsers+=("Google Chrome")
    
    printf '%s\n' "${browsers[@]}"
}

# Show wofi menu with browsers
selected_browser=$(get_browsers | wofi --dmenu --prompt="Open in browser:" --cache-file=/dev/null)

# Open URL in selected browser
case $selected_browser in
    "Firefox")
        firefox "$URL"
        ;;
    "Chromium")
        chromium "$URL"
        ;;
    "Brave")
        brave "$URL"
        ;;
    "Vivaldi")
        vivaldi "$URL"
        ;;
    "Google Chrome")
        google-chrome-stable "$URL"
        ;;
esac
