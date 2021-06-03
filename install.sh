mkdir -p ~/.config/nvim
mv ~/.config/nvim ~/.config/oldnvim
cp -R nvim ~/.config/

mkdir -p ~/.local/bin/
cd ~/.local/bin/
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
mv nvim.appimage nvim
chmod +x nvim

echo "Make sure that ~/.local/bin is in PATH!"
