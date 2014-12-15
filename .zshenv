# 必ず最初に読み込まれる
# ログインシェル、インタラクティブシェル、シェルスクリプトのどの場合でも必要な環境変数などはここに記述

# echo "Loading $HOME/.zshenv"

if [ -x /usr/libexec/path_helper ]; then
   PATH=""
   eval `/usr/libexec/path_helper -s`
fi

ZDOTDIR=$HOME/.zsh
export ZDOTDIR
