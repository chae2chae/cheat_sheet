# Ubuntu setup
| name-sheet link   | Reference       | update |
|-------------|-------------|-------------|
| [ubuntu20.04](./ubuntu20.04/)    | | 24.09.02|
| [ubuntu22.04](./ubuntu22.04/)    | | 24.09.02|




Ubuntu Kernel version check
```shell
$ uname -a
$ cat /proc/version
```


## Ubuntu Bluetooth module
[https://ubuntu.pkgs.org/20.04/ubuntu-universe-arm64/bluetooth_5.53-0ubuntu3_all.deb.html](https://ubuntu.pkgs.org/20.04/ubuntu-universe-arm64/bluetooth_5.53-0ubuntu3_all.deb.html) => 깔아도 똑같이 dmseg에 뜨지 않는다
- [blueman 설치](https://linux.how2shout.com/how-to-install-blueman-on-linux-mint-or-ubuntu-20-04/)
```python
sudo apt install blueman
sudo apt install bluez bluez-obexd
```
- blueman-manager 실행 시 에러 발생
```shell
blueman-manager version 2.1.2 starting
blueman-manager 23.05.51 ERROR    Manager:118 on_dbus_name_appeared: Default adapter not found, trying first available.
blueman-manager 23.05.51 ERROR    Manager:122 on_dbus_name_appeared: No adapter(s) found, exiting

```
- sudo dmesg 확인시 ERROR발견
```shell
[  764.275596] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a lmp_subver=8761
[  764.276657] Bluetooth: hci0: RTL: rom_version status=0 version=1
[  764.276668] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
[  764.276719] bluetooth hci0: Direct firmware load for rtl_bt/rtl8761bu_fw.bin failed with error -2
[  764.276726] Bluetooth: hci0: RTL: firmware file rtl_bt/rtl8761bu_fw.bin not found
```
- [Install](https://forums.linuxmint.com/viewtopic.php?t=377733)
```
$ cd /usr/lib/firmware/rtl_bt
$ sudo ln -s rtl8761b_fw.bin rtl8761bu_fw.bin
```
- 재시작 하면! 됨
