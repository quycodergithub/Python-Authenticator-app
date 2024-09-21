#!/bin/bash

# Kiểm tra xem Python có được cài đặt chưa
if ! command -v python3 &> /dev/null
then
    echo "Python chưa được cài đặt. Bắt đầu cài đặt Python..."
    
    # Cài đặt Python cho Ubuntu/Debian
    if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get update
        sudo apt-get install -y python3 python3-pip
    # Cài đặt Python cho MacOS qua Homebrew
    elif [ -x "$(command -v brew)" ]; then
        brew install python
    else
        echo "Không thể tìm thấy trình quản lý gói phù hợp. Vui lòng cài đặt Python thủ công."
        exit 1
    fi
fi

# Kiểm tra và cài đặt pip nếu chưa có
if ! command -v pip3 &> /dev/null
then
    echo "pip chưa được cài đặt. Cài đặt pip..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py
    rm get-pip.py
fi

# Cài đặt các thư viện từ requirements.txt
if [ -f "requirements.txt" ]; then
    pip3 install -r requirements.txt
else
    echo "Không tìm thấy file requirements.txt."
    exit 1
fi

# Thiết lập biến môi trường Dropbox access token
read -p "Nhập Dropbox Access Token của bạn: " DROPBOX_ACCESS_TOKEN
export DROPBOX_ACCESS_TOKEN="$DROPBOX_ACCESS_TOKEN"
echo "Đã thiết lập biến môi trường 'DROPBOX_ACCESS_TOKEN'."
echo 'export DROPBOX_ACCESS_TOKEN='"$DROPBOX_ACCESS_TOKEN" >> ~/.bashrc

echo "Cài đặt hoàn tất. Bạn có thể chạy dự án!"
