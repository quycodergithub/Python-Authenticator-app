import pyotp
import os
import dropbox
from dropbox.exceptions import AuthError

# Đường dẫn file chứa thông tin OTP
OTP_FILE = "otp_secrets.txt"

# Hàm khởi tạo OTP từ mã bí mật
def generate_otp(service_name, secret):
    totp = pyotp.TOTP(secret)
    otp = totp.now()
    print(f"OTP for {service_name}: {otp}")
    return otp

# Hàm lưu trữ thông tin OTP vào file
def save_otp_to_file(service_name, secret):
    with open(OTP_FILE, 'a') as file:
        file.write(f"{service_name}:{secret}\n")
    print(f"Saved OTP for {service_name}.")

# Hàm lấy mã OTP từ file
def get_otp_from_file(service_name):
    if not os.path.exists(OTP_FILE):
        print("No OTP file found.")
        return None

    with open(OTP_FILE, 'r') as file:
        for line in file:
            stored_service_name, stored_secret = line.strip().split(':')
            if stored_service_name == service_name:
                return generate_otp(service_name, stored_secret)

    print(f"No OTP found for service: {service_name}")
    return None

# Hàm backup file OTP lên Dropbox
def backup_to_dropbox(file_path):
    try:
        dbx = dropbox.Dropbox(os.getenv("DROPBOX_ACCESS_TOKEN"))

        with open(file_path, 'rb') as f:
            print("Uploading to Dropbox...")
            dbx.files_upload(f.read(), f"/{file_path}", mode=dropbox.files.WriteMode("overwrite"))
        print("Backup completed!")
    except AuthError as e:
        print(f"Failed to authenticate Dropbox: {e}")

# Hàm restore file OTP từ Dropbox
def restore_from_dropbox(file_name):
    try:
        dbx = dropbox.Dropbox(os.getenv("DROPBOX_ACCESS_TOKEN"))
        print("Restoring from Dropbox...")

        metadata, res = dbx.files_download(f"/{file_name}")
        with open(file_name, 'wb') as f:
            f.write(res.content)

        print(f"Restored {file_name} from Dropbox.")
    except AuthError as e:
        print(f"Failed to authenticate Dropbox: {e}")
    except dropbox.exceptions.ApiError as e:
        print(f"Error during file download: {e}")

# Hàm chính điều khiển chương trình
def main():
    print("CLI Python Authenticator")
    print("1. Generate OTP")
    print("2. Backup OTP to Dropbox")
    print("3. Restore OTP from Dropbox")
    print("4. Exit")

    choice = input("Enter your choice: ")

    if choice == '1':
        service_name = input("Enter service name: ")
        secret = input("Enter secret for the service: ")
        otp = generate_otp(service_name, secret)
        save_otp_to_file(service_name, secret)

    elif choice == '2':
        if os.path.exists(OTP_FILE):
            backup_to_dropbox(OTP_FILE)
        else:
            print("No OTP file found to backup.")

    elif choice == '3':
        file_name = input("Enter the name of the file to restore: ")
        restore_from_dropbox(file_name)

    elif choice == '4':
        print("Exiting...")
        exit()

    else:
        print("Invalid choice. Exiting...")

if __name__ == "__main__":
    main()
