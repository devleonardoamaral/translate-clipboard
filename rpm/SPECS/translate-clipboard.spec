Name:           translate-clipboard
Version:        1.0.0
Release:        1%{?dist}
Summary:        Clipboard translator with yad GUI using translate-shell

License:        GPLv3+
URL:            https://github.com/devleonardoamaral/translate-clipboard
Source0:        translate-clipboard
BuildArch:      noarch
Requires:       bash, yad, xclip, translate-shell

%description
Clipboard translator with yad GUI using translate-shell.
A lightweight Bash script that translates clipboard content and allows
language selection with persistent preference. Supports editing the text
before translation with a simple YAD GUI.

%prep
# No source preparation required for a single script

%install
# Create target directory in build root
mkdir -p %{buildroot}/usr/bin
# Copy the script into build root
cp %{SOURCE0} %{buildroot}/usr/bin/translate-clipboard
# Ensure executable permission
chmod +x %{buildroot}/usr/bin/translate-clipboard

%postun
if [ "$1" -eq 0 ]; then
    for user_home in /home/*; do
        config="$user_home/.translate-clipboard.conf"
        [ -f "$config" ] && rm -f "$config"
    done
fi

%files
/usr/bin/translate-clipboard