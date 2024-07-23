#!/bin/bash

# VNCサーバーを起動
vncserver :1 -geometry 1280x800 -depth 24

# VNCサーバーの起動を確認
if [ $? -ne 0 ]; then
    echo "Failed to start VNC server."
    exit 1
fi

# JupyterLabをトークンなしで起動
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --ServerApp.token='' --ServerApp.password='' --allow-root &

# JupyterLabの起動を確認
JUPYTER_PID=$!
echo "JupyterLab started with PID $JUPYTER_PID on port 8888."

tail -f /root/.vnc/*.log
