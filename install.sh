#!/bin/bash

###############################################################################
# TaishanPi SDK Install Bootstrap
# Usage:
#   curl -fsSL https://wiki.lckfb.com/storage/scripts/TaishanPi-manifests/install \
#       | bash -s -- -b linux/tspi-3-260402     -m gitee
#   curl -fsSL https://wiki.lckfb.com/storage/scripts/TaishanPi-manifests/install \
#       | bash -s -- -b android14/tspi-3-260416 -m github
###############################################################################

set -uo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

MANIFEST_BRANCH=""
MANIFEST_SOURCE=""

usage() {
    echo -e "${BOLD}TaishanPi SDK Install Bootstrap${NC}"
    echo ""
    echo "Usage: curl -fsSL <URL>/install | bash -s -- -b <branch> -m <github|gitee>"
    echo ""
    echo "Options:"
    echo "  -b <branch>         Manifest branch (required)"
    echo "  -m <github|gitee>   Manifest source (required)"
    echo "                        github - International network"
    echo "                        gitee  - China network (recommended for CN users)"
    echo "  -h                  Show this help"
    echo ""
    echo "Examples:"
    echo "  bash -s -- -b linux/tspi-3-260402     -m gitee"
    echo "  bash -s -- -b android14/tspi-3-260416 -m github"
    exit 0
}

while getopts "b:m:h" opt; do
    case $opt in
        b) MANIFEST_BRANCH="$OPTARG" ;;
        m) MANIFEST_SOURCE="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

if [[ -z "$MANIFEST_BRANCH" ]]; then
    echo -e "${RED}[ERR] Missing required option: -b <branch>${NC}"
    echo ""
    usage
fi

if [[ -z "$MANIFEST_SOURCE" ]]; then
    echo -e "${RED}[ERR] Missing required option: -m <github|gitee>${NC}"
    echo -e "${RED}      China users should use: -m gitee${NC}"
    echo -e "${RED}      Other users  should use: -m github${NC}"
    echo ""
    usage
fi

case "$MANIFEST_SOURCE" in
    github)
        RAW_BASE="https://raw.githubusercontent.com/jlckfb/TaishanPi-manifests/refs/heads"
        MANIFEST_REPO_URL="https://github.com/jlckfb/TaishanPi-manifests.git"
        BRANCHES_URL="https://github.com/jlckfb/TaishanPi-manifests/branches"
        ;;
    gitee)
        RAW_BASE="https://raw.giteeusercontent.com/taishanpi/TaishanPi-manifests/raw"
        MANIFEST_REPO_URL="https://gitee.com/taishanpi/TaishanPi-manifests.git"
        BRANCHES_URL="https://gitee.com/taishanpi/TaishanPi-manifests/branches"
        ;;
    *)
        echo -e "${RED}[ERR] Invalid value for -m: '${MANIFEST_SOURCE}' (expected: github | gitee)${NC}"
        echo ""
        usage
        ;;
esac

SETUP_URL="${RAW_BASE}/${MANIFEST_BRANCH}/setup.sh"

echo -e "${CYAN}${BOLD}>>> TaishanPi SDK Installer${NC}"
echo -e "  Branch: ${BOLD}${MANIFEST_BRANCH}${NC}"
echo -e "  Source: ${BOLD}${MANIFEST_SOURCE}${NC}"
echo -e "  Fetching setup script from: ${SETUP_URL}"
echo ""

SETUP_SCRIPT=$(curl -fsSL "$SETUP_URL" 2>&1)
if [[ $? -ne 0 ]]; then
    echo -e "${RED}[ERR] Failed to download setup script${NC}"
    echo -e "${RED}  URL: ${SETUP_URL}${NC}"
    echo -e "${RED}  Please check the branch name is correct${NC}"
    echo ""
    echo "Available branches: ${BRANCHES_URL}"
    exit 1
fi

echo -e "${GREEN}[OK] Setup script downloaded, launching...${NC}"
echo ""

TSPI_MANIFEST_SOURCE="$MANIFEST_SOURCE" \
TSPI_MANIFEST_URL="$MANIFEST_REPO_URL" \
    bash -c "$SETUP_SCRIPT"
