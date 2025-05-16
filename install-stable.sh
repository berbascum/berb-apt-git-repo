#!/bin/bash

## Script to install Berbascum's apt repo configs and keyrings
#
## Version 0.0.1
#
# Upstream-Name: berb-apt-git-repo
# Source: https://github.com/berbascum/berb-apt-git-repo
#
# Copyright (C) 2025 Berbascum <berbascum@ticv.cat>
# All rights reserved.
#
# BSD 3-Clause License

## Prereqs
## jq
if ! which jq; then
    echo && echo "sudo password required to install prereqs..."
    sudo apt-get update \
        && sudo apt-get install jq -y
fi
## curl
if ! which curl; then
    echo && echo "sudo password required to install prereqs..."
    sudo apt-get update \
        && sudo apt-get install curl -y
fi

## git apt config debs vars
REMOTE_USER="berbascum"
apt_repo_name="berb-apt-git-repo"
apt_url_api_contents_base="https://api.github.com/repos/${REMOTE_USER}/${apt_repo_name}/contents"
apt_pool_name="stable"
apt_component_name="main"
apt_url_raw_base="https://raw.githubusercontent.com/${REMOTE_USER}/${apt_repo_name}/${apt_component_name}"
apt_url_search_path="pool/${apt_pool_name}/${apt_component_name}/binary-all"


fn_git_search_apt_deb_pkg() {
    debs_found="$(curl -s ${apt_url_api_contents_base}/${apt_url_search_path} | jq -r '.[].name' | grep -c "${apt_url_search_pkg_str}")"
    if [ "${debs_found}" -eq "0" ]; then
        echo "apt-config deb package not found on github"
        exit 1
    elif [ "${debs_found}" -gt "1" ]; then
        ## TODO: Implement search for lastest version
        echo "Multiple apt-config deb packages found on github"
        exit 1
    else
        apt_deb_name="$(curl -s ${apt_url_api_contents_base}/${apt_url_search_path} | jq -r '.[].name' | grep "${apt_url_search_pkg_str}")"
        url_raw_full="${apt_url_raw_base}/${apt_url_search_path}/${apt_deb_name}"
       echo
       echo "url_raw_full val: ${url_raw_full}"
    fi
}


## Search for apt keyring deb
## TODO: Simplify commands and filenames in vars
apt_url_search_pkg_str="apt-keyrings-berbascum"
fn_git_search_apt_deb_pkg
URL_DEB_APT_KEYRING="${url_raw_full}"
## Search for apt config deb
apt_url_search_pkg_str="apt-config-berbascum-${apt_pool_name}"
fn_git_search_apt_deb_pkg
URL_DEB_APT_CONFIG="${url_raw_full}"

## Add berbascum apt stable repo
curl -o /tmp/apt-keyrings-last.deb ${URL_DEB_APT_KEYRING}
curl -o /tmp/apt-config-stable-last.deb ${URL_DEB_APT_CONFIG}
echo && echo "sudo password required to install the packages..."
sudo dpkg -i /tmp/apt-keyrings-last.deb
sudo dpkg -i /tmp/apt-config-stable-last.deb
