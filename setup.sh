#!/bin/bash

# Kiểm tra hệ điều hành
OS=$(uname)

# Cài đặt cho Ubuntu
if [[ "$OS" == "Linux" && -f /etc/lsb-release ]]; then
    echo "Đang cài đặt cho Ubuntu..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install python3 python3-pip git -y
    pip3 install --upgrade pip
    pip3 install pyotp requests dropbox

# Cài đặt cho macOS
elif [[ "$OS" == "Darwin" ]]; then
    echo "Đang cài đặt cho macOS..."
    brew update
    brew install python git
    pip3 install --upgrade pip
    pip3 install pyotp requests dropbox

# Cài đặt cho Termux
elif [[ "$OS" == "Linux" && -d /data/data/com.termux ]]; then
    echo "Đang cài đặt cho Termux..."
    pkg update && pkg upgrade -y
    pkg install python -y
    pip install --upgrade pip
    pip install pyotp requests dropbox

else
    echo "Hệ điều hành không được hỗ trợ."
    exit 1
fi

cd CLI-Python-Authenticator || exit

echo "Cài đặt hoàn tất! Bạn có thể chạy dự án CLI Python Authenticator."
