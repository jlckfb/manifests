<p align="center">
  <img src=".github/banner.png" alt="LCSC OPENKITS Banner" width="100%">
</p>

<h1 align="center">TaishanPi Manifests</h1>

<p align="center">
  <b>Unified repo manifest repository for TaishanPi development boards</b><br>
  TaishanPi 系列开发板的统一 repo manifest 仓库
</p>

---

## 🚀 Quick Start

### TaishanPi-3 (RK3576)

**One-Click Install** - Automatically sets up build environment and downloads SDK:

```bash
# Linux SDK (Buildroot/Debian/Ubuntu)
curl -fsSL https://wiki.lckfb.com/storage/scripts/TaishanPi-manifests/install | bash -s -- -b linux/tspi-3-260402 -m github

# Android 14 SDK
curl -fsSL https://wiki.lckfb.com/storage/scripts/TaishanPi-manifests/install | bash -s -- -b android14/tspi-3-260416 -m github
```

> 中国用户网络访问 GitHub 不稳定时，将 `-m github` 替换为 `-m gitee` 即可走 Gitee 镜像。

---

## 💻 System Requirements

### TaishanPi-3 Host Requirements

| Component | Requirement |
|-----------|-------------|
| **OS** | Ubuntu 22.04 LTS (Jammy Jellyfish) |
| **CPU** | x86_64 with VT-x/AMD-V support |
| **RAM** | 16GB+ recommended |
| **Storage** | Linux: 120GB+ / Android: 300GB+ (source + build output) |
| **Network** | Stable internet connection |

**Note**: The installer automatically checks system compatibility and installs required dependencies.

---

## 📦 Available SDKs

| Platform | Board | Branch | Download | Disk Needed | Code Hosting |
|----------|-------|--------|----------|-------------|---------------|
| **Linux** | TaishanPi-3 | `linux/tspi-3-260402` | ~30GB | 120GB+ | [cnb.cool](https://cnb.cool/TaishanPi-3-Rockchip-Linux) |
| **Android 14** | TaishanPi-3 | `android14/tspi-3-260416` | ~100GB | 300GB+ | [cnb.cool](https://cnb.cool/TaishanPi-3-Rockchip-Android) |

---

## 🛠️ Manual Installation

For advanced users who want to download source code only (without build dependencies):

<details>
<summary><b>Click to expand manual installation steps</b></summary>

### 1. Install repo tool

```bash
mkdir -p ~/.bin
curl -fsSL https://cnb.cool/jlckfb/git-repo/-/git/raw/main/repo -o ~/.bin/repo
chmod a+rx ~/.bin/repo
export PATH="$HOME/.bin:$PATH"
export REPO_URL="https://cnb.cool/jlckfb/git-repo"
export REPO_REV="main"
```

### 2. Download SDK

**Linux SDK:**
```bash
mkdir -p ~/TaishanPi-3-Linux && cd ~/TaishanPi-3-Linux
repo init -u https://github.com/jlckfb/TaishanPi-manifests.git -b linux/tspi-3-260402 --depth=1 --no-clone-bundle
repo sync -c --no-clone-bundle -j$(nproc)
```

**Android 14 SDK:**
```bash
mkdir -p ~/TaishanPi-3-Android14 && cd ~/TaishanPi-3-Android14
repo init -u https://github.com/jlckfb/TaishanPi-manifests.git -b android14/tspi-3-260416 --depth=1 --no-clone-bundle
repo sync -c --no-clone-bundle -j$(nproc)
```

> 中国用户可将 `repo init -u` 后的 URL 替换为 `https://gitee.com/taishanpi/TaishanPi-manifests.git`。

### 3. Fetch LFS files (if needed)

```bash
# Install git-lfs if not already installed
sudo apt-get install git-lfs

# Pull LFS objects for repos that use them
repo forall -c 'git lfs ls-files 2>/dev/null | head -1 | grep -q . && git lfs pull'
```

</details>

---

## 📁 Repository Structure

```
TaishanPi-manifests/
├── main                          # Bootstrap script + README
├── linux/tspi-3-260402          # Linux SDK manifest + setup script
└── android14/tspi-3-260416      # Android 14 SDK manifest + setup script
```

Each SDK branch contains:
- `default.xml` - repo manifest defining all repositories
- `setup.sh` - Automated installation script with dependency management

---

## 📋 Branch Naming Convention

Format: `{os}{version}/{board}-{date}`

Examples:
- `linux/tspi-3-260402` - Linux SDK for TaishanPi-3, released 2026-04-02
- `android14/tspi-3-260416` - Android 14 SDK for TaishanPi-3, released 2026-04-16

---

## 📖 Documentation

**TaishanPi Wiki:**
- [English Documentation](https://wiki.lckfb.com/en/tspi-series/)
- [中文文档](https://wiki.lckfb.com/zh-hans/tspi-series/)

**Official Websites:**
- [LCKFB China (中文官网)](https://lckfb.com/)
- [LCKFB Global (Global Website)](https://openkits.easyeda.com/)

---

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:
- Use English for commit messages (see existing commits for format)
- Test changes on Ubuntu 22.04 LTS before sub
- Update documentation when adding new features

---

## 📄 License

This repository contains manifest files and installation scripts. Individual SDK components are licensed separately - refer to each repository for specific license information.
