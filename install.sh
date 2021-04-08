mkdir -p ~/.config/nvim
mv ~/.config/nvim ~/.config/oldnvim
ln -s nvim ~/.config/

mkdir -p ~/.local/bin/
cd ~/.local/bin/
wget https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage
mv nvim.appimage nvim
chmod +x nvim

ln -s zshrc ~/.zshrc


git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf\
~/.fzf/install


export RUSTUP_HOME=/localhome/${USER}/.rustup 
export CARGO_HOME=/localhome/${USER}/.cargo
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh


echo "Add the following to your bashrc: 
export RUSTUP_HOME=/localhome/${USER}/.rustup 
export CARGO_HOME=/localhome/${USER}/.cargo
"



echo "Make sure that ~/.local/bin is in PATH!"
