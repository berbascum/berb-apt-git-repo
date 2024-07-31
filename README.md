# berb-apt-git-repo


## TIP: Enable an apt repo on Github
- A repo with at least one commit need to be hosted on github.
- Go to the Github repo "Settings".
- Enter to "Pages" from "Code and automation" section
- On the "Branch" section, select the branch you want to publish, keep the root directory and save.
- Wait a minuts for dns updates.

## How to add berbascum's apt repo:
* Download the last version of the berb-apt-config-stable and berb-apt-keyrings packages [from this url](https://github.com/berbascum/berb-apt-git-repo/tree/main/pool/stable/main/binary-all)

* Install the downloaded packages 
```
sudo dpkg -i berb-apt-config-stable<last_version> and berb-apt-keyrings<last_version>
```
* Update the apt archive
```
sudo apt-get update
```
