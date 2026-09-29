#!/usr/bin/env bash
# ============================================================================
# Bio-SHAP Linux 安装脚本（随安装包分发）
# 安装到 /opt/Bio-SHAP，创建 /usr/local/bin/bioshap 命令与桌面入口。
# 用法：解压安装包后执行  sudo bash install.sh
# ============================================================================
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
APP_DIR="/opt/Bio-SHAP"

echo "[1/3] 复制程序到 $APP_DIR"
sudo rm -rf "$APP_DIR"
sudo mkdir -p "$APP_DIR"
sudo cp -r "$SRC"/* "$APP_DIR/"
sudo chmod +x "$APP_DIR/Bio-SHAP"

echo "[2/3] 创建启动命令 /usr/local/bin/bioshap"
sudo tee /usr/local/bin/bioshap >/dev/null <<EOF
#!/usr/bin/env bash
exec "$APP_DIR/Bio-SHAP" "\$@"
EOF
sudo chmod +x /usr/local/bin/bioshap

echo "[3/3] 创建桌面入口"
sudo cp "$APP_DIR/Bio-SHAP.desktop" /usr/share/applications/
sudo sed -i "s|Exec=.*|Exec=$APP_DIR/Bio-SHAP|" /usr/share/applications/Bio-SHAP.desktop
sudo sed -i "s|Icon=.*|Icon=$APP_DIR/desktop/assets/icon.png|" /usr/share/applications/Bio-SHAP.desktop

echo "安装完成！在终端输入 bioshap 或从应用菜单启动 Bio-SHAP。"
