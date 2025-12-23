#!/bin/zsh

###########################
# somni.dotfiles :: macOS #
###########################
### This script will disable some nonsense (for me) features such as AI, Web3, etc.
### Supports stable, beta, nightly channel installations.

# Declare Brave package name list
declare -a packageNames=(
    "com.brave.Browser"
    "com.brave.Browser.beta"
    "com.brave.Browser.nightly"
)

# Declare group policy settings pair
declare -A policySettings=(
    ["BraveRewardsDisabled"]=true
    ["BraveWalletDisabled"]=true
    ["BraveWeb3Disabled"]=true
    ["BraveVPNDisabled"]=true
    ["BraveAIChatEnabled"]=false
    ["BraveNewsDisabled"]=true
    ["BraveTalkDisabled"]=true
)

# Set group policies for all available installations
for name in ${packageNames[@]}; do
    if defaults read "$name" &> /dev/null; then
        echo "Setting group policies for $name..."

        for policy value in ${(@kv)policySettings}; do
            defaults write "$name" "$policy" -bool $value
        done

        echo "Done."
    else
        echo "Seems like $name is not installed, skipping..."
    fi

    echo ""
done
