# CLI Python Authenticator

## Mô tả
CLI Python Authenticator là công cụ dòng lệnh giúp tạo mã OTP cho các dịch vụ khác nhau. Dự án bao gồm tính năng backup và restore dữ liệu OTP từ Dropbox, đảm bảo bạn không bị mất thông tin quan trọng.

## Tính năng
- Tạo OTP dựa trên mã bí mật.
- Backup và restore OTP lên/ từ Dropbox.
- Tự động cài đặt và cấu hình môi trường.

## Cài đặt

### Đối với Windows
1. **Cài đặt Python**: Chạy script `setup.bat` để tự động cài đặt **Scoop**, **Python**, và các thư viện cần thiết.
   ```batch
   setup.bat
```
### Đối vời Mac và Linux
 1. chạy script `setup.sh` đễ cài python và dependentcies
```bash
chmod +x setup.sh
./setup.sh
```
# LƯU Ý: nhập dropbox accesstoken khi được yêu cầu

## Cách lấy dropbox access token
1. Vào <a href="https://www.dropbox.com/developers/apps/">Trang Dropbox dành cho Developer</a>
2. Nhấn "Create app"
3. Phần 1 chọn "Scoped access"
4. Phần 2 chọn "App folder"
5. Phần 3 Đặt tên gì cx đc
6. Tick vào ô và nhấn "Create App"
7. Sau khi xong, vào app mới tạo và bấm "Premissions"
8. Tick vào "files.content.write" và "files.content.read"
9. Bấm "Submit"
10. Back ra "Settings"
11. Cuộn xuống , tại phần "Generated Access Token", bấm "Generate"
12. Copy hết cái hiện ra
13. Chạy script cài đặt , tới chỗ yêu cầu nhập Access token thì paste nó vào 

## Chạy file
1. Cách thêm mã OTP
```bash
python pythonauthenticator.py generate <tên hiển thị (cho cái key)>
```
2. Cách backup
```bash
python pythonauthenticator.py backup
```
## Giấy phép
1. MIT
## Các thư viện trong project
1. dropbox
2. pyotp
3. os
# CHÚC CÁC BẠN DÙNG SCRIPT VUI :))
