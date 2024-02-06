# .server-setup
A repository with useful scripts to setup a Linux Server environment

# Before Setup
This setup assumes you are logged in as a sudo user, use
```sh
usermod -aG sudo username
```
while logged in as root to add the user to the sudoers.

## Package Manager
A working and configured package manager (here apt) is required!
Before continuing it is advised to update the repositories and upgrade all packages:
```sh
sudo apt update && sudo apt upgrade
```

# NeoVim
You will have a better time with an actual editor, so install nvim using:
```sh
sudo apt install neovim
```

# ssh
Configuring over SSH is probably preferrable, because you can copy paste a lot of stuff.
## Installation
Install Openssh-Server and check its running status
```sh
sudo apt install openssh-server && sudo systemctl status ssh
```
## Adding ssh-keys
On the client machines, generate keys:
```sh
ssh-keygen -t ed25519 -C "<email>"
```
You would probably use your github mail here, because your client will use github: ```51530686+tyrongabriel@users.noreply.github.com```

Add the key to the server using:
```sh
ssh-copy-id -i ~/.ssh/id_ed25519.pub username@serveraddress
```
Optionally you can edit the ```~/.ssh/authorized_keys``` file and add your public key there.

## Configuring ssh
This step should probable be done after the git configuration!
Clone this repository:
```sh
git clone git@github.com:tyrongabriel/.server-setup.git ~/.server-setup
```

To copy the ssh configuration, copy the file from this repository:
```sh
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak # Create a backup of the existing config
# IMPORTANT: BE SURE TO HAVE A VALID SSH-KEY ADDED, OTHERWISE YOU WILL BE LOCKED OUT!
sudo cp <path_to_repo>/ssh/sshd_config /etc/ssh/sshd_config # Copy config from repo to system
```
This should block root login, change default port to 22022 and more.

# Git
To use the scripts in this repository, you will need to be able to use git!

## Install Git
Run the command:
```sh
sudo apt install git
```
## Configure User
Setup the correct Git user. to edit the config, run the command ```git config --global --edit```
for the name, enter your name: ```Tyron Gabriel```
for the email, use the GitHub noreply email: ```51530686+tyrongabriel@users.noreply.github.com```

### Add server SSH key to get private repos
Generate keypair
```sh
ssh-keygen -t ed25519 -C "51530686+tyrongabriel@users.noreply.github.com"
```
Add the output of
```sh
cat ~/.ssh/id_ed25519.pub
```
to your git account (be sure to add a linebreak at the end!)

# Dotfiles
Now you should have set up git and ssh correctly, now you can clone your dotfiles repository and get the configuration for all the optional tools you use!
Clone the repo:
```sh
git clone git@github.com:tyrongabriel/.dotfiles.git ~/.dotfiles
```
Follow the dotfile installation for any further steps!

# Other services
In this repository, there are more services, such as docker, portainer etc. with installation scripts you can run.
Some of these may be incomplete and/or be broken, use with caution!
(You may need to make the files executable using ```chmod +X install.sh```

