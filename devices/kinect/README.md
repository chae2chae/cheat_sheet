## Depth Azure Kinect SDK


- ttyUSB 안 잡혀서 강제 설정함
    
    ```bash
    sudo nano /etc/udev/rules.d/99-custom-usb.rules
    
    # ADD > 99-custom-usb.rules
    # lsusb 를 통해서 확인 후 아래 내용을 추가해야함 idVender , idProduct 교체
    # example : Bus 002 Device 003: ID 07ca:1113 AVerMedia Technologies, Inc. Live Streamer CAP 4K
    
    # Rule for AverMedia Live Streamer CAP 4K
    SUBSYSTEM=="usb", ATTR{idVendor}=="07ca", ATTR{idProduct}=="1113", MODE="0666", SYMLINK+="AverMedia"
    # Rule for Azure Kinect Microphone Array
    SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="097e", MODE="0666", SYMLINK+="AzureKinectMic"
    # Rule for Azure Kinect Depth Camera
    SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="097c", MODE="0666", SYMLINK+="AzureKinectDepth"
    # Rule for Azure Kinect 4K Camera
    SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="097d", MODE="0666", SYMLINK+="AzureKinect4K"
    # Save > exit
    
    # update 
    sudo udevadm control --reload-rules
    sudo udevadm trigger
    #check
    ls -l /dev/AverMedia
    ls -l /dev/AzureKinectMic
    ls -l /dev/AzureKinectDepth
    ls -l /dev/AzureKinect4K
    ```
    

- Ubuntu 22.04 SDK Install
    
    https://medium.com/@asandy520/how-to-use-python-to-run-kinect-azure-dk-on-ubuntu-22-04-7c323442c84b
    
    - 22.04는 따로 k4a  tools 이 없는 듯 합니다!
    - SDK는 다음과 같이 설치해주었고
    
    ```bash
    # READ : https://medium.com/@asandy520/how-to-use-python-to-run-kinect-azure-dk-on-ubuntu-22-04-7c323442c84b
    
    # Install SDK https://learn.microsoft.com/en-us/linux/packages
    curl -sSL -O https://packages.microsoft.com/config/<distribution>/<version>/packages-microsoft-prod.deb
    
    sudo apt-get update
    sudo apt install -y libgl1-mesa-dev libsoundio-dev libvulkan-dev libx11-dev libxcursor-dev libxinerama-dev libxrandr-dev libusb-1.0-0-dev libssl-dev libudev-dev mesa-common-dev uuid-dev
    cd Downloads/
    
    wget https://packages.microsoft.com/ubuntu/18.04/prod/pool/main/k/k4a-tools/k4a-tools_1.4.2_amd64.deb
    wget https://packages.microsoft.com/ubuntu/18.04/prod/pool/main/libk/libk4a1.4-dev/libk4a1.4-dev_1.4.2_amd64.deb
    wget https://packages.microsoft.com/ubuntu/18.04/prod/pool/main/libk/libk4a1.4/libk4a1.4_1.4.2_amd64.deb
    
    # Edit your sources list to temporarily switch to Ubuntu 20.04
    sudo nano /etc/apt/sources.list
    
    # Add the following line for Ubuntu 20.04 mirror source
    deb http://archive.ubuntu.com/ubuntu focal main
    
    # Update and install libsoundio1
    sudo apt update
    
    sudo apt-add-repository -y -n 'deb http://archive.ubuntu.com/ubuntu focal main'
    sudo apt-add-repository -y 'deb http://archive.ubuntu.com/ubuntu focal universe'
    sudo apt-get install -y libsoundio1
    sudo apt-add-repository -r -y -n 'deb http://archive.ubuntu.com/ubuntu focal universe'
    sudo apt-add-repository -r -y 'deb http://archive.ubuntu.com/ubuntu focal main'
    
    # Remove or comment out the line for Ubuntu 20.04
    # Update the package list again
    
    sudo apt update
    sudo dpkg -i libk4a1.4-dev_1.4.2_amd64.deb
    sudo dpkg -i libk4a1.4_1.4.2_amd64.deb
    sudo dpkg -i k4a-tools_1.4.2_amd64.deb
    
    ```
    
    - 권한설정을 마치면 다음과 같이 뜹니다 (참고 USB 3.0 단자에 연결하셔야 볼 수 있습니다)
    
    ![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/cfdb4deb-cc97-49b1-8a43-e6ac4de07746/da04f94c-492c-45c4-a6a9-dbf39970502a/image.png)
    

- 제품 Specification
    
    ![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/cfdb4deb-cc97-49b1-8a43-e6ac4de07746/a44994a8-af37-4528-9cab-16c869d5559f/image.png)
    
    - NFOV(좁은 보기 필드 깊이 모드)
    - WFOV(넓은 보기 필드 깊이 모드)
    - FOV(보기 필드)
    - FPS(초당 프레임 수)
    - IMU(관성 측정 장치)
    - FoI(관심 있는 필드)
    
    ### 깊이
    
    | 모드 | 해결 | FoI | FPS | 작동 범위* | 노출 시간 |
    | --- | --- | --- | --- | --- | --- |
    | NFOV Unbinned | 640 x 576 | 75° x 65° | 0, 5, 15, 30 | 0.5-3.86m | 12.8ms |
    | NFOV 2x2 Binned(SW) | 320 x 288 | 75° x 65° | 0, 5, 15, 30 | 0.5 - 5.46m | 12.8ms |
    | WFOV 2x2 Binned | 512 x 512 | 120° x 120° | 0, 5, 15, 30 | 0.25-2.88m | 12.8ms |
    | WFOV Unbinned | 1024 x 1024 | 120° x 120° | 0, 5, 15 | 0.25-2.21m | 20.3ms |
    | Passive IR | 1024 x 1024 | 해당 없음 | 0, 5, 15, 30 | 해당 없음 | 1.6ms |
    
    ### 컬러
    
    | RGB 카메라 해상도(HxV) | 가로 세로 비율 | 형식 옵션 | 프레임 속도(FPS) | 명목 FOV(HxV)(후처리) |
    | --- | --- | --- | --- | --- |
    | 3840 x 2160 | 16:9 | MJPEG | 0, 5, 15, 30 | 90° x 59° |
    | 2560x1440 | 16:9 | MJPEG | 0, 5, 15, 30 | 90° x 59° |
    | 1920x1080 | 16:9 | MJPEG | 0, 5, 15, 30 | 90° x 59° |
    | 1280 x 720 | 16:9 | MJPEG/YUY2/NV12 | 0, 5, 15, 30 | 90° x 59° |
    | 4096 x 3072 | 4:3 | MJPEG | 0, 5, 15 | 90° x 74.3° |
    | 2048 x 1536 | 4:3 | MJPEG | 0, 5, 15, 30 | 90° x 74.3° |
    
    ## **RGB 카메라 노출 시간 값**
    
    허용되는 RGB 카메라 수동 노출 값에 대한 매핑은 다음과 같습니다.
    
    **테이블 확장**
    
    | exp | 2^exp | 50Hz | 60Hz |
    | --- | --- | --- | --- |
    | -11 | 488 | 500 | 500 |
    | -10 | 977 | 1250 | 1250 |
    | -9 | 1953 | 2500 | 2500 |
    | -8 | 3906 | 10000 | 8330 |
    | -7 | 7813 | 20000 | 16670 |
    | -6 | 15625 | 30000 | 33330 |
    | 5- | 31250 | 40,000 | 41670 |
    | -4 | 62500 | 50000 | 50000 |
    | -3 | 125000 | 60000 | 66670 |
    | -2 | 250000 | 80000 | 83330 |
    | -1 | 500000 | 100000 | 100000 |
    | 0 | 1000000 | 120000 | 116670 |
    | 1 | 2000000 | 130000 | 133330 |
    
    **깊이 센서 원시 타이밍**
    
    **테이블 확장**
    
    | 깊이 모드 | IR펄스 | 펄스Width | 유휴 상태마침표 | Idle Time | 노출Time |
    | --- | --- | --- | --- | --- | --- |
    | NFOV UnbinnedNFOV 2xx BinnedWFOV 2x2 Binned | 9 | 125us | 8 | 1450us | 12.8ms |
    | WFOV Unbinned | 9 | 125us | 8 | 2390us | 20.3ms |
    
    **카메라 보기 필드**
    
    다음 이미지에서는 깊이 및 RGB 카메라 보기 필드 또는 센서의 "가시" 각도를 보여 줍니다. 이 다이어그램의 경우 4:3 모드의 RGB 카메라를 보여 줍니다.
    
    !https://learn.microsoft.com/ko-kr/previous-versions/azure/kinect-dk/media/resources/hardware-specs-media/camera-fov.png
    
    다음 이미지에서는 정면 방향 2,000mm 거리를 주시하는 카메라의 보기 필드를 보여 줍니다.
    
    !https://learn.microsoft.com/ko-kr/previous-versions/azure/kinect-dk/media/resources/hardware-specs-media/fov-front.png
    
    ## **동작 센서(IMU)**
    
    내장형 IMU(관성 측정 장치)는 LSM6DSMUS이며, 가속도계와 자이로스코프를 모두 포함하고 있습니다. 가속도계와 자이로스코프는 1.6kHz로 동시에 샘플링됩니다. 샘플은 208Hz로 호스트에 보고됩니다.
    
    **마이크 배열**
    
    Azure Kinect DK에는 표준 USB 오디오 클래스 2.0 디바이스로 식별되는 7개의 고품질 마이크 순환 어레이가 포함되어 있습니다. 7개 채널 모두에 액세스할 수 있습니다. 성능 사양은 다음과 같습니다.
    
    - 민감도: -22dBFS(94dB SPL, 1kHz)
    - 신호 대 잡음 비율 > 65dB
    - 음향 오버로드 지점: 116dB
    
    !https://learn.microsoft.com/ko-kr/previous-versions/azure/kinect-dk/media/resources/hardware-specs-media/mic-bubble.png
    
    **USB**
    
    Azure Kinect DK는 다음 하드웨어 엔드포인트를 운영 체제에 공개하는 USB3 복합 디바이스입니다.
    
    공급업체 ID는 0x045E(Microsoft)입니다. 아래는 제품 ID 표입니다.
    
    **테이블 확장**
    
    | USB 인터페이스 | PNP IP | 주의 |
    | --- | --- | --- |
    | USB3.1 2세대 허브 | 0x097A | 주 허브 |
    | USB 2.0 허브 | 0x097B | HS USB |
    | 깊이 카메라 | 0x097C | USB3.0 |
    | 컬러 카메라 | 0x097D | USB3.0 |
    | 마이크 | 0x097E | HS USB |
    
    **표시기**
    
    디바이스 전면에는 센서 SDK를 사용하여 프로그래밍 방식으로 비활성화할 수 있는 카메라 스트리밍 표시기가 있습니다.
    
    디바이스 후면에 있는 상태 LED에서 나타내는 디바이스 상태는 다음과 같습니다.
    
    **테이블 확장**
    
    | 표시등 상태 | 의미 |
    | --- | --- |
    | 흰색 고정 | 디바이스가 켜져 있고 제대로 작동합니다. |
    | 흰색 깜박임 | 디바이스가 켜져 있지만 USB 3.0 데이터 연결이 없습니다. |
    | 황색 깜박임 | 디바이스가 작동하는 데 필요한 전원이 부족합니다. |
    | 황색, 다음으로 흰색 깜박임 | 펌웨어 업데이트 또는 복구가 진행 중입니다. |