Ros conda wrapper
- https://answers.ros.org/question/315178/how-can-work-with-ros-inside-a-python-3-conda-env



보통은 Conda 환경에 ROS를 설치하여 사용 : 같이 쓰려 하지말고 python 가상환경이 필요할때는 virtual로 하자!
- $ conda install -c conda-forge -c robostack ros-noetic-desktop
- https://answers.ros.org/question/315178/how-can-work-with-ros-inside-a-python-3-conda-env/
- https://medium.com/robostack/cross-platform-conda-packages-for-ros-fa1974fd1de3



1. ros1 설치하기
http://wiki.ros.org/noetic/Installation/Ubuntu
2. ros2 설치하기
https://docs.ros.org/en/foxy/Installation.html
3. conda 설치하기
https://www.anaconda.com/products/individual
4. 셋다 alias로 실행하기
https://stackoverflow.com/questions/54429210/how-do-i-prevent-conda-from-activating-the-base-environment-by-default

### ~/.bashrc에 작성한다.
```
export CONDA_AUTO_ACTIVATE_BASE=false
alias do_foxy='source /opt/ros/foxy/setup.bash; source ~/chae/ros2_ws/install/local_setup.bash; echo "Activate foxy!"'
alias do_noetic='source /opt/ros/noetic/setup.bash; source ~/chae/ros1_ws/devel/setup.bash; echo "Activate noetic"'
alias do_conda='conda activate base'
```
