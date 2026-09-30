#!/usr/bin/env bash
set -euo pipefail

# 1. Handle OS-specific package installations
if [[ -f '/etc/os-release' ]]; then
    source '/etc/os-release'
fi

if [[ "${ID:-}" == "debian" || "${ID:-}" == "ubuntu" ]]; then
    sudo bash -c '
        apt-get update; apt-get -y install fpc
    ' >/dev/null
fi

# 2. Dynamically set kernel directory based on the environment OS
if [[ "${OSTYPE:-}" == "msys" || "${OS:-}" == "Windows_NT" ]]; then
    KERNEL_DIR="windows"
else
    KERNEL_DIR="linux"
fi

# 3. Apply the dynamic path to your compilation options
declare -ar OPS=(
    -Fu"use/mseide-msegui/lib/common/kernel/${KERNEL_DIR}"
    -Fu"use/mseide-msegui/lib/common/*"
    -Mobjfpc -Sh -Fcutf8 -dmse_with_zeoslib -B -Xs -CX -XX -O1 -dmse_dynpo -SIcorba -vewinhq -dusemo
)

declare -i exitCode=0
mapfile -t < <(
    if (fpc "${OPS[@]}" "src/ideU.pas"); then
        printf '\x1b[32mSUCCES\x1b[0m\n' >&2
        printf 'exitCode:0\n'
    else
        printf '\x1b[31mERROR\x1b[0m\n'  >&2
        printf 'exitCode:1\n'
    fi |
        grep --extended-regexp '(Error:|Fatal:|Linking|exitCode)'
)
if ((${#MAPFILE[@]})) && ((${MAPFILE[-1]##*:})); then
    exitCode+=${MAPFILE[-1]##*:}
fi
printf '%s\n' "${MAPFILE[@]}"
exit "${exitCode}"
