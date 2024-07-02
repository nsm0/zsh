zsh setting
======================


### setting ###
```sh
~ % cd $HOME/
~ % git clone https://github.com/nsm0/zsh.git .zsh
~ %
~ % cd .zsh/
.zsh % git submodule init
.zsh % git submodule update
.zsh
.zsh  cd $HOME/
~ % ln -s .zsh/.zshenv .
~ % ln -s .zsh/.zprofile .
~ % ln -s .zsh/.zshrc .
~ % 
~ % mv .zsh/.zshrc_mba .zsh/.zshrc_{user_name}
```

### compile ###
```sh
~ % cd $HOME/
~ % zcompile ~/.zsh/.zshrc
```

### reload ###
```sh
~ % cd $HOME/
~ % source ~/.zshrc
```
