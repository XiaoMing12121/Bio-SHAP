#!/usr/bin/env bash
# ============================================================================
# Bio-SHAP 桌面版 · Linux 构建脚本（在 Linux 机器上执行）
# 产出：dist/Bio-SHAP-linux-x64-<版本>.tar.gz 安装包
# 用法：
#   bash pack/linux/build.sh
# ============================================================================
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
VERSION="1.0.0"
cd "$ROOT"

echo "[1/5] 创建 venv"
python3 -m venv .venv-linux
source .venv-linux/bin/activate

echo "[2/5] 安装依赖"
pip install --upgrade pip
pip install -r requirements.txt

echo "[3/5] 生成图标（可选）"
python tools/make_icon.py || true

echo "[4/5] PyInstaller 打包"
python -m PyInstaller --noconfirm --clean pack/windows/Bio-SHAP.spec

echo "[5/5] 生成安装包 tar.gz"
OUT="dist/Bio-SHAP-linux-x64-$VERSION"
rm -rf "$OUT"
mkdir -p "$OUT"
cp -r dist/Bio-SHAP/* "$OUT/"
cp pack/linux/install.sh "$OUT/install.sh"
cp pack/linux/Bio-SHAP.desktop "$OUT/"
chmod +x "$OUT/install.sh"
tar -czf "dist/Bio-SHAP-linux-x64-$VERSION.tar.gz" "$OUT"
echo "完成：dist/Bio-SHAP-linux-x64-$VERSION.tar.gz"
