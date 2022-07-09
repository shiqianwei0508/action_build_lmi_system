#!/bin/bash
git clone https://github.com/zjw2017/actions_MI12X_test
GITHUB_WORKSPACE=/home/runner/work/action-tmate/action-tmate/actions_MI12X_test
cd $GITHUB_WORKSPACE
URL=https://bigota.d.miui.com/22.7.7/miui_PSYCHEPRE_22.7.7_a83dac045c_12.0.zip
sudo apt install python3 python3-pip aria2 zip p7zip-full
sudo apt --fix-broken install
sudo apt update --fix-missing
pip3 install --upgrade pip
pip3 install pycryptodome
pip3 install docopt
pip3 install requests
pip3 install beautifulsoup4
pip3 install --ignore-installed pyyaml
aria2c -x16 -j$(nproc) -U "Mozilla/5.0" -d "$GITHUB_WORKSPACE" $URL
sudo chmod 777 "$GITHUB_WORKSPACE"/tools/payload-dumper-go
mkdir -p "$GITHUB_WORKSPACE"/tmp
mkdir -p "$GITHUB_WORKSPACE"/images
mkdir -p "$GITHUB_WORKSPACE"/simages
mkdir -p "$GITHUB_WORKSPACE"/zip
ZIP_NAME=${URL##*/}
7z x "$GITHUB_WORKSPACE"/$ZIP_NAME -r -o"$GITHUB_WORKSPACE"/tmp
rm -rf "$GITHUB_WORKSPACE"/$ZIP_NAME
"$GITHUB_WORKSPACE"/tools/payload-dumper-go -p product "$GITHUB_WORKSPACE"/tmp/payload.bin
mv "$GITHUB_WORKSPACE"/payload/product.img "$GITHUB_WORKSPACE"/images/product.img
rm -rf "$GITHUB_WORKSPACE"/tmp
sudo python3 "$GITHUB_WORKSPACE"/tools/imgextractorLinux.py "$GITHUB_WORKSPACE"/images/product.img "$GITHUB_WORKSPACE"/images
rm -rf "$GITHUB_WORKSPACE"/images/product.img
sudo chmod 777 "$GITHUB_WORKSPACE"/tools/mke2fs
sudo chmod 777 "$GITHUB_WORKSPACE"/tools/e2fsdroid
sudo chmod 777 "$GITHUB_WORKSPACE"/tools/img2simg
sudo chmod 777 "$GITHUB_WORKSPACE"/tools/brotli
DATE=${URL%/*}
date=${DATE##*/}