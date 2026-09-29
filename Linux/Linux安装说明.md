# Bio-SHAP · Linux 版说明

> 说明：Windows 版已预构建好安装包（见 `Windows/` 目录）。Linux 版安装包**未预构建**，
> 因为 Linux 包只能在 Linux 机器上构建（PyInstaller 不支持跨平台打包）。
> 有两种方式获得 Linux 安装包，二选一即可。

## 方式一：推送到 GitHub 自动构建（推荐）

本项目已配置 GitHub Actions 工作流（`.github/workflows/build-release.yml`），
代码推送到 GitHub 后会自动在云端构建 **Windows zip + Linux tar.gz** 两个安装包：

1. 把项目推到 GitHub 仓库；
2. 打一个版本标签触发构建：
   ```
   git tag v1.0.0
   git push origin v1.0.0
   ```
3. 打开仓库 Actions 页面，等待两个任务跑完；
4. 在运行记录页下载 `Bio-SHAP-Linux` 构建件（内含 `Bio-SHAP-linux-x64-1.0.0.tar.gz`）。

也可以在 Actions 页面手动点 **Run workflow** 触发，不打标签。

## 方式二：在 Linux 机器上自己构建

把本项目源码拷到任意 Linux 机器（x86_64），执行：

```bash
bash pack/linux/build.sh
```

脚本会自动：装中文字体 → 建虚拟环境 → 装依赖 → PyInstaller 打包 →
生成 `dist/Bio-SHAP-linux-x64-1.0.0.tar.gz`。

## Linux 版安装（拿到 tar.gz 之后）

```bash
tar -xzf Bio-SHAP-linux-x64-1.0.0.tar.gz
cd Bio-SHAP-linux-x64-1.0.0
./install.sh          # 会安装到 ~/.local/share/Bio-SHAP 并创建桌面图标
```

之后从应用菜单或命令行 `bio-shap` 启动。

## 系统要求

- Ubuntu 22.04+ / Debian 12+ / 其他 x86_64 发行版（glibc 2.31+）
- 无需预装 Python

## 已知事项

- 构建时会自动安装文泉驿中文字体，保证图中中文正常渲染；
  若你的发行版没有 apt（如 Fedora），手动安装任意中文字体（Noto Sans CJK 等）即可。
