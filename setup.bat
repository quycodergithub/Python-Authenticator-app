@echo off

:: Kiểm tra xem Scoop có được cài đặt chưa
where scoop >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Scoop chưa được cài đặt. Bắt đầu cài đặt Scoop...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "iwr -useb get.scoop.sh | iex"
)

:: Kiểm tra xem Python có được cài đặt chưa
where python >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Python chưa được cài đặt. Bắt đầu cài đặt Python qua Scoop...
    scoop install python
)

:: Cài đặt các thư viện từ requirements.txt
if exist "requirements.txt" (
    python -m pip install -r requirements.txt
) else (
    echo Không tìm thấy file requirements.txt.
    exit /b 1
)

:: Thiết lập biến môi trường Dropbox Access Token
set /p DROPBOX_ACCESS_TOKEN="Nhập Dropbox Access Token của bạn: "
setx DROPBOX_ACCESS_TOKEN "%DROPBOX_ACCESS_TOKEN%"
echo Đã thiết lập biến môi trường 'DROPBOX_ACCESS_TOKEN'.

echo Cài đặt hoàn tất. Bạn có thể chạy dự án!
pause
