# ベースイメージをUbuntuの最新版に設定
FROM --platform=amd64 ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=root

# システム更新、必要なパッケージのインストール
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    xfce4 xfce4-goodies tightvncserver zsh wget git curl nano vim \
    dbus-x11 xfonts-base xfonts-75dpi xfonts-100dpi \
    language-pack-ja fonts-ipafont \
    python3 python3-pip python3-venv

# タイムゾーン設定
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Chromeブラウザのインストール
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y ./google-chrome-stable_current_amd64.deb

# pyenv
ENV PATH="/opt/venv/bin:$PATH"

# JupyterLabを仮想環境にインストール
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install jupyterlab

# oh-my-zshのインストール
RUN sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && \
    chsh -s /bin/zsh

# zshのテーマをcandyに設定
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="candy"/' /root/.zshrc

# VNCサーバー設定
RUN mkdir /root/.vnc && \
    echo "password" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

COPY xstartup /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

# コンテナ起動スクリプト
COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

EXPOSE 5901 8888

CMD ["/usr/local/bin/startup.sh"]