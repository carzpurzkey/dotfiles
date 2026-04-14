export DEBIAN_FRONTEND=noninteractive
export USERNAME=`whoami`

export INSTALL_ZSH=false
export INSTALL_RUST=true

## update and install required packages
sudo apt-get update
sudo apt-get -y install --no-install-recommends apt-utils dialog 2>&1
sudo apt-get install -y \
  xfonts-utils \
  curl \
  git \
  gnupg2 \
  jq \
  sudo \
  less \
  iproute2 \
  procps \
  wget \
  unzip \
  apt-transport-https \
  lsb-release 

# Install Azure CLI
# echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/azure-cli.list
# curl -sL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - 2>/dev/null
# sudo apt-get update
# sudo apt-get install -y azure-cli;

# Install Jetbrains Mono font
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FantasqueSansMono.zip
sudo unzip FantasqueSansMono.zip -d /usr/share/fonts/FantasqueSansM
sudo mkfontdir /usr/share/fonts/FantasqueSansM
sudo mkfontscale /usr/share/fonts/FantasqueSansM
sudo fc-cache -f -v

# Install & Configure Zsh
if [ "$INSTALL_ZSH" = "true" ]
then
    sudo apt-get install -y \
    fonts-powerline \
    zsh

    cp -f ~/dotfiles/.zshrc ~/.zshrc
    chsh -s /usr/bin/zsh $USERNAME
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    echo "source $PWD/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
fi

# Install & Configure Rust
if [ "$INSTALL_RUST" = "true" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source $HOME/.cargo/env
  rustup component add rust-src
  rustup component add rust-analyzer
fi

# Cleanup
sudo apt-get autoremove -y
sudo apt-get autoremove -y
sudo rm -rf /var/lib/apt/lists/*
