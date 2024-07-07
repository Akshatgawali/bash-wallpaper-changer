# Wallpaper Changer Setup Documentation

## Table of Contents
1. [Configure and Prepare the Script](#1-configure-and-prepare-the-script)
2. [Set Up systemd Service](#2-set-up-systemd-service)
   - 2.1 [Create change_wallpaper.service File](#21-create-change_wallpaperservice-file)
   - 2.2 [Reload systemd and Start the Service](#22-reload-systemd-and-start-the-service)
   - 2.3 [Enable the Service on Startup](#23-enable-the-service-on-startup)
3. [Environment Variables](#3-environment-variables)
4. [Restart the Service](#4-restart-the-service)
5. [Monitoring and Troubleshooting](#5-monitoring-and-troubleshooting)
6. [Notes](#6-notes)
7. [License](#7-license)

## 1. Configure and Prepare the Script

### Edit the Script
Open the script (`change_wallpaper.sh`) in a text editor and configure the following parameters:
```
nano change_wallpaper.sh
```
Modify these variables as needed:
```
WALLPAPER_DIR="/home/username/Pictures/Wallpapers"
INTERVAL=5
```

### Make the Script Executable
Make the script executable:
```
chmod +x change_wallpaper.sh
```

## 2. Set Up systemd Service

### 2.1 Create change_wallpaper.service File
Create a systemd service file for the wallpaper changer:
```
sudo nano /etc/systemd/system/change_wallpaper.service
```
Paste the following content into the file:
```
[Unit]
Description=Change Wallpaper Every 5 Seconds

[Service]
ExecStart=/home/ace/change_wallpaper.sh
Restart=always
User=ace

[Install]
WantedBy=default.target

```
Replace `username` with your username and `/path/to/auto-wallpaper-changer/` with the actual path to your cloned repository.

### 2.2 Reload systemd and Start the Service
Reload systemd to load the new service file:
```
sudo systemctl daemon-reload
```
Start the wallpaper-changing service:
```
sudo systemctl start change_wallpaper.service
```

### 2.3 Enable the Service on Startup
To ensure the wallpaper changer starts automatically on boot:
```
sudo systemctl enable change_wallpaper.service
```

## 3. Environment Variables
Set the necessary environment variables for DBus communication:
```
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
export XDG_RUNTIME_DIR=/run/user/$(id -u)
```

## 4. Restart the Service
Restart the wallpaper-changing service to apply environment changes:
```
sudo systemctl restart change_wallpaper.service
```

## 5. Monitoring and Troubleshooting
Check the service status and logs to ensure the wallpaper changer is running correctly:
```
sudo systemctl status change_wallpaper.service
```
```
cat /tmp/wallpaper.log
```
Inspect the logs for any errors or confirmations:
```
journalctl -u change_wallpaper.service
```

## 6. Notes
- Ensure your GNOME desktop environment is active and configured correctly.
- Customize the script (`change_wallpaper.sh`) further to suit your preferences, such as adding more wallpapers or adjusting the interval.
- This setup assumes you have `gsettings` installed (`sudo apt install gsettings-desktop-schemas`).
