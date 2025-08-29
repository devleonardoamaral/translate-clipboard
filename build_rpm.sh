#!/usr/bin/env bash
set -euo pipefail

APP_NAME="translate-clipboard"
VERSION="1.0.0"

# Paths
SRC="src/$APP_NAME"

# ----------------------------
# Build .rpm
# ----------------------------
RPMBUILD_ROOT="rpm_build"
rm -rf "$RPMBUILD_ROOT"

# RPM directories
mkdir -p "$RPMBUILD_ROOT"/{BUILD,RPMS,SOURCES,BUILDROOT,SPECS}
cp "$SRC" "$RPMBUILD_ROOT/SOURCES/"

rpmbuild -bb \
    --define "_topdir $(pwd)/$RPMBUILD_ROOT" \
    rpm/SPECS/$APP_NAME.spec

echo "RPM build finished. Check $RPMBUILD_ROOT/RPMS/noarch/"
