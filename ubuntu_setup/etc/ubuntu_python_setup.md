### 1. **Python 3.9 설치**

우선, Docker 컨테이너에 Python 3.9가 설치되어 있어야 합니다. 만약 설치되어 있지 않다면, 먼저 Python 3.9를 설치합니다.

```bash
sudo apt-get update
sudo apt-get install python3.9 python3.9-distutils
```

### 2. **Python 대체 경로 등록**

이제 `update-alternatives`를 사용하여 Python 3.8과 Python 3.9를 대체 가능하도록 설정합니다.

```bash
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2
```

여기서 `/usr/bin/python3`은 기본 Python 3 경로이고, 각 Python 버전의 우선순위를 설정합니다. 우선순위가 높은 것이 기본으로 선택됩니다.

### 3. **Python 버전 선택**

다음 명령어를 사용하여 사용할 Python 버전을 선택할 수 있습니다.

```bash
sudo update-alternatives --config python3
```

이 명령을 실행하면, 사용할 수 있는 Python 버전 목록이 표시됩니다. 여기서 원하는 Python 버전의 번호를 입력하여 선택할 수 있습니다.

### 4. **기본 Python 버전 확인**

이제 기본 Python 버전이 올바르게 설정되었는지 확인합니다.

```bash
python3 --version
```

이 명령어를 실행했을 때 `Python 3.9.x`가 출력되면 성공적으로 설정된 것입니다.

### 5. **pip 설정**

Python 3.9에 맞는 pip를 기본으로 사용하도록 설정합니다.

```bash
sudo update-alternatives --install /usr/bin/pip3 pip3 /usr/bin/pip3.8 1
sudo update-alternatives --install /usr/bin/pip3 pip3 /usr/bin/pip3.9 2
```

이 과정을 완료하면 Docker 컨테이너에서 Python 3.9가 기본 Python 3로 설정됩니다.