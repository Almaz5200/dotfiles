#!/bin/zsh

export PATH=$PATH:/opt/homebrew/bin

ensure_installation() {
  tool_name=$1
  installation_command=$2

  if test ! $(which $tool_name); then
    echo "Installing $tool_name..."
    echo "Running: $installation_command"
    eval $installation_command
  fi
}

# Check for Homebrew
if test ! $(which brew); then
	echo "Installing homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

ensure_installation "brew" '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"'
ensure_installation "ansible" 'brew install ansible'
ensure_installation "xcodes" 'brew install xcodesorg/made/xcodes'
ensure_installation "aria2c" 'brew install aria2'
ensure_installation "xcode-build-server" 'brew install xcode-build-server'
ensure_installation "cargo" "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"

export XCODE_VERSION=15.3
export IOS_VERSION=17.4

xcodes install $XCODE_VERSION
xcodes select $XCODE_VERSION

if [ -z "$(xcodes runtimes | grep "iOS $IOS_VERSION (Installed)")" ]; then
  xcodes runtimes install "iOS $IOS_VERSION"
fi
