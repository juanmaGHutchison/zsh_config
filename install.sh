#!/bin/bash

set -Eeuo pipefail

declare CURRENT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"

declare BACKUP_FOLDER="${HOME}/zsh_backup"
declare ZSHRC_FILE="${HOME}/.zshrc"
declare ZSH_DIR="${HOME}/.zsh"

function backup_current_config() {
    mkdir -p "${BACKUP_FOLDER}"
    echo -n "Backing up current ZSH configuration to ${BACKUP_FOLDER} ... "
    mv "${ZSHRC_FILE}" "${BACKUP_FOLDER}/."
    mv "${ZSH_DIR}" "${BACKUP_FOLDER}/."
    echo "DONE"
    
    return 0
}

function install_new_config() {
    echo -n "Installing new ZSH configuration ... "
    cp "${CURRENT_PATH}/my_zshrc" "${ZSHRC_FILE}"
    cp -rf "${CURRENT_PATH}/zsh" "${ZSH_DIR}"

    # curl -fsSL https://raw.githubusercontent.com/yetone/smart-suggestion/main/install.sh | bash
    echo "DONE"

    return 0
}

backup_current_config
install_new_config

echo "INFO: Do not forget to setup your API_KEY for the 'smart-suggestion' plugin"
echo "INFO: See: https://raw.githubusercontent.com/yetone/smart-suggestion"

exit 0

