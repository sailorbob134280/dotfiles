#!/bin/bash

# Configuration variables
REPO_URL="https://github.com/asdf-vm/asdf"
INSTALL_PATH="/home/$(whoami)/bin"

# Detect platform
PLATFORM=$(uname -s)
ARCH=$(uname -m)

# Fetch the latest release version from GitHub API
LATEST_RELEASE=$(curl --silent "https://api.github.com/repos/asdf-vm/asdf/releases/latest" | jq -r .tag_name)

# Verify latest release fetched successfully
if [ "$LATEST_RELEASE" == "null" ] || [ -z "$LATEST_RELEASE" ]; then
  echo "Failed to fetch the latest release information."
  exit 1
fi

# Check if asdf is already installed and at the latest version
if command -v asdf &> /dev/null; then
  INSTALLED_VERSION=$(asdf version | awk '{print $1}')
  if [ "$INSTALLED_VERSION" == "$LATEST_RELEASE" ]; then
    echo "asdf is already installed at the latest version ($INSTALLED_VERSION). Skipping download."
    exit 0
  else
    echo "asdf is installed, but version ($INSTALLED_VERSION) is outdated. Updating to latest version ($LATEST_RELEASE)."
  fi
else
  echo "asdf is not installed. Proceeding with installation."
fi

echo "Latest release: $LATEST_RELEASE"

# Set filename based on platform, architecture, and version
case "$PLATFORM" in
  Linux)
    INSTALL_PATH="/home/$(whoami)/bin"
    case "$ARCH" in
      x86_64) FILENAME="asdf-$LATEST_RELEASE-linux-amd64.tar.gz" ;;
      aarch64) FILENAME="asdf-$LATEST_RELEASE-linux-arm64.tar.gz" ;;
      *) echo "Unsupported Linux architecture: $ARCH"; exit 1 ;;
    esac
    ;;
  Darwin)
    INSTALL_PATH="/Users/$(whoami)/bin"
    case "$ARCH" in
      x86_64) FILENAME="asdf-$LATEST_RELEASE-darwin-amd64.tar.gz" ;;
      arm64) FILENAME="asdf-$LATEST_RELEASE-darwin-arm64.tar.gz" ;;
      *) echo "Unsupported macOS architecture: $ARCH"; exit 1 ;;
    esac
    ;;
  *)
    echo "Unsupported platform: $PLATFORM"
    exit 1
    ;;
esac

# Construct the URL to download the binary archive
DOWNLOAD_URL="$REPO_URL/releases/download/$LATEST_RELEASE/$FILENAME"

# Download the archive
TEMP_DIR=$(mktemp -d)
echo "Downloading $FILENAME from $DOWNLOAD_URL..."
curl -L "$DOWNLOAD_URL" -o "$TEMP_DIR/$FILENAME"

# Verify download
if [ ! -f "$TEMP_DIR/$FILENAME" ]; then
  echo "Failed to download the archive."
  exit 1
fi

# Extract the archive
echo "Extracting $FILENAME..."
tar -xzf "$TEMP_DIR/$FILENAME" -C "$TEMP_DIR"

# Install binary
EXTRACTED_BINARY="$TEMP_DIR/asdf"
if [ ! -f "$EXTRACTED_BINARY" ]; then
  echo "Extracted binary not found."
  exit 1
fi

echo "Installing asdf to $INSTALL_PATH..."
sudo mv "$EXTRACTED_BINARY" "$INSTALL_PATH/asdf"

# Ensure the binary is executable
sudo chmod +x "$INSTALL_PATH/asdf"

# Verify installation
if command -v asdf &> /dev/null; then
  echo "asdf installed successfully!"
else
  echo "Installation failed."
  exit 1
fi

# Clean up temporary files
rm -rf "$TEMP_DIR"

