#!/usr/bin/env bash
set -euo pipefail

# Ensure tools installed
if ! rpm -q rpm-build >/dev/null 2>&1; then
    if ! pkexec dnf install -y rpm-build; then
        echo "rpm-build installation failed."
        exit 1
    fi
fi

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

# Generate current Unix timestamp
SOURCE_DATE_EPOCH=$(date +%s)

rpmbuild -bb \
    --define "_topdir $(pwd)/$RPMBUILD_ROOT" \
    --define "_source_date_epoch $SOURCE_DATE_EPOCH" \
    rpm/SPECS/$APP_NAME.spec

echo "RPM build finished. Check $RPMBUILD_ROOT/RPMS/noarch/"
