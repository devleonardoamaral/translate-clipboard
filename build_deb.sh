#!/usr/bin/env bash
set -euo pipefail

APP_NAME="translate-clipboard"
VERSION="1.0.0"

# Paths
SRC="src/$APP_NAME"

# ----------------------------
# Build .deb
# ----------------------------
DEB_DIR="deb_build"
rm -rf "$DEB_DIR"
mkdir -p "$DEB_DIR/usr/local/bin"
cp "$SRC" "$DEB_DIR/usr/local/bin/"
chmod +x "$DEB_DIR/usr/local/bin/$APP_NAME"

# Copy DEBIAN folder
cp -r deb/DEBIAN "$DEB_DIR/"

DEB_FILE="${APP_NAME}_${VERSION}_all.deb"
dpkg-deb --build --root-owner-group "$DEB_DIR" "$DEB_FILE"

echo "Created DEB package: $DEB_FILE"
