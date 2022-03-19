mkdir -p ~/.config/nvim
mv ~/.config/nvim ~/.config/oldnvim
ln -s nvim ~/.config/

mkdir -p ~/.local/bin/
cd ~/.local/bin/
wget https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage
mv nvim.appimage nvim
chmod +x nvim



git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf\
~/.fzf/install





echo "Make sure that ~/.local/bin is in PATH!"
