## Sound Driver break

- purge 후 install 해야지 가능함! 
- 과정을 진행한 후 reboot 
```bash
sudo apt-get remove --purge alsa-base
sudo apt-get remove --purge pulseaudio
sudo apt-get install alsa-base
sudo apt-get install pulseaudio
sudo alsa force-reload
```
- [Reference 1](https://www.maketecheasier.com/fix-no-sound-issue-ubuntu/)
- [Reference 2](https://superuser.com/questions/1816355/how-to-install-sound-driver-on-ubuntu-20-04)