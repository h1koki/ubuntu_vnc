# シンプルなUbuntuのVNC+JupyterLab環境

## サービスポート
* 5901:VNC　　パスワードは"password"
* 8888:JupyterLab　　トークン、パスワード不要

## その他追加事項
デフォルトシェルはzshに変更、oh-my-zshのcandyスタイルを使用  
ブラウザはGoogleChrome  
デスクトップ環境はxfce4  
VNCはtightvnc  
JupyterLabはpyenvで起動

## 注意事項
GoggleChromeはroot権限でそのまま起動できないので、--no-sandboxオプションが必要

## 問題点
AppleSilicon(M系)では起動しない  
rootで起動するため、開発環境のみでの使用を推奨  
コピペが上手くいかない気がする
