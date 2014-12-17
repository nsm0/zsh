# ログインシェルの場合に１度だけ読み込まれる
# インタラクティブシェルやシェルスクリプトでは不要だけどログインシェルの時だけ必要な設定をする場合にはここに記述する

# echo "Loading $HOME/.zprofile"

### Select OS type
case $OSTYPE {
  sunos*)	export SYSTEM=sun ;;
  solaris*)	export SYSTEM=sol ;;
  irix*)	export SYSTEM=sgi ;;
  osf*)		export SYSTEM=dec ;;
  linux*)	export SYSTEM=gnu ;;
  freebsd*)	export SYSTEM=bsd ;;
  darwin*)	export SYSTEM=darwin ;;    # MacOSX
}

# 環境変数の OS 別設定ファイルを読み込む
if [ -f $ZDOTDIR/.zshrc_$SYSTEM ]; then
  source $ZDOTDIR/.zshrc_$SYSTEM
fi
