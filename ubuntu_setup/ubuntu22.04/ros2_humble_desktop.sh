# https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html
sudo apt-get update && sudo apt upgrade -y

# Install
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y universe
sudo apt-get install -y curl gnupg2 lsb-release build-essential


# locale  # check for UTF-8
sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# # If you want to set it in Korean # #
# sudo locale-gen ko_KR ko_KR.UTF-8
# sudo update-locale LC_ALL=ko_KR.UTF-8 LANG=ko_KR.UTF-8
# export LANG=ko_KR.UTF-8


sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null 
sudo apt install -y ros-humble-desktop
source /opt/ros/humble/setup.bash

sudo apt update && sudo apt install -y \
  python3-flake8-docstrings \
  python3-pip \
  python3-pytest-cov \
  ros-dev-tools
  
sudo apt install -y \
   python3-flake8-blind-except \
   python3-flake8-builtins \
   python3-flake8-class-newline \
   python3-flake8-comprehensions \
   python3-flake8-deprecated \
   python3-flake8-import-order \
   python3-flake8-quotes \
   python3-pytest-repeat \
   python3-pytest-rerunfailures
   
# sudo apt-get install -y python3-argcomplete python3-colcon-clean
# sudo apt-get install -y python3-colcon-common-extensions
# sudo apt-get install -y python3-rosdep python3-vcstool # https://index.ros.org/doc/ros2/Installation/Linux-Development-Setup/
# [ -e /etc/ros/rosdep/sources.list.d/20-default.list ] ||
# sudo rosdep init
# rosdep update
# grep -F "source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" ~/.bashrc ||
# echo "source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" >> ~/.bashrc
# grep -F "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" ~/.bashrc ||
# echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc

# set +u


echo "success installing ROS2"
echo "Run 'source /opt/ros/humble/setup.bash'"



# # uninstall
# sudo apt remove ~nros-humble-* && sudo apt autoremove
# sudo rm /etc/apt/sources.list.d/ros2.list
# sudo apt update
# sudo apt autoremove
# # Consider upgrading for packages previously shadowed.
# sudo apt upgrade
