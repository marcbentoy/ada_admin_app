# ADA - Automatic Digital Attendance

## System Setup Guide

### Major Steps

1. Install app
2. Setup pocketbase server
3. Configure device

### 1. Install app

1. Go to this github repo's release [page](https://github.com/vimsmoke/ada_admin_app/releases).
2. Click the latest version release and download the apk file.
3. Install the apk on to your mobile phone.

### 2. Setup pocketbase server

1. Create a separate WiFi hotspot. You can use your mobile phone's hotspot.
2. Take note of the WiFi hotspot's SSID and password, you will use it to setup the device later.
3. Connect your laptop/computer that will be running the pocketbase server to your newly set up WiFi hotspot.
4. Go to your computer and open up a terminal/command prompt.
5. Enter this command: `ipconfig` and press enter.
6. You will see multiple details about your network configurations but you will need to take note of your `IPv4 Address` under the `Wireless LAN adapter Wi-Fi` category.
7. Now, download a copy of the pocketbase server through this link: [ada server](https://github.com/vimsmoke/automatic_digital_attendance).
8. When you open the link, click on the blue dropdown button that says `Code` and click `Download ZIP`.
9. Once the download has finished, locate the file and unzip it.
10. Open the unzipped file and open the sub-folder until you find a folder named pocketbase. 
11. When you find the `pocketbase` folder, click on the file url of the file explorer and type `cmd`.
12. A command prompt window will appear. To start the server, enter this command: `pocketbase.exe serve --http <laptop_ip_address>:8090` then press enter. Example: `pocketbase.exe serve --http 192.168.219.250:8090`
13. This will start the server.

### 3. Configure device

1. Turn off the saved WiFi hotspot setup.
2. Wait for around 20 secs. 
3. Turn on the saved WiFi hotspot setup.
4. Check the WiFi networks, this will now boot up the WiFi AP.
5. Get a phone and open search for WiFi networks. After around 10 seconds, you will see a new WiFi named `ADA_Config`. Connect to this network using the password: `12345678`.
6. Once connected, go to your internet browser and browse to `192.168.4.1`.
7. This will open up the configuration portal of the device. Input all configuration credentials that's been asked, e.g. the SSID of the WiFi hotspot, it's password, the server url which is `http://<laptop_ip_address>:8090`, room name, and real room name. The room name can also be a subject name. If the room name has spaces, the real room name can contain spaces while the room name field on the configuration should not have spaces and should be replaced with an underscore. For example, a room real name of `Com Lab 1` will have a room name of `Com_Lab_1`.
8. Click `Save` button and it will save the configuration and reboots itself. 
9. Once, it reboots, you will notice a quick twitch of the display. You can now use the whole system.

Enjoy!