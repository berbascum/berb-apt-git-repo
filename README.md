# berb-apt-git-repo


## TIP: Enable an apt repo on Github
- A repo with at least one commit need to be hosted on github.
- Go to the Github repo "Settings".
- Enter to "Pages" from "Code and automation" section
- On the "Branch" section, select the branch you want to publish, keep the root directory and save.
- Wait a minuts for dns updates.

## How to add berbascum's apt repo:
```
sudo wget -O /usr/share/keyrings/berb-apt.gpg https://raw.githubusercontent.com/berbascum/berb-apt-git-repo/main/berb-apt.gpg
```
```
sudo wget -O /etc/apt/sources.list.d/berb-apt.list https://raw.githubusercontent.com/berbascum/berb-apt-git-repo/main/berb-apt.list
```
```
sudo apt-get update
```
