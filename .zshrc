# zshを起動したときに読み込まれるが、シェルスクリプトを実行したときは読み込まれない。
# エイリアスやキーバインドの設定、zshのオプションなど対話的に使用するための設定を書く。

######################################
# History
#######################################
HISTFILE=$ZDOTDIR/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数


setopt hist_ignore_space  # 余分な空白は詰めて記録
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
#setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する
setopt hist_find_no_dups  # 履歴検索中、重複を飛ばす
setopt no_beep                # beep を無効
setopt interactive_comments   # '#' 以降をコメントとして扱う
setopt nonomatch              # グロブ展開しない


#######################################
# 補完関係
#######################################
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*' ignore-parents parent pwd .. # ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin        # sudo の後ろでコマンド名を補完する
zstyle ':completion:*:processes' command 'ps x -o pid,s,args' # ps コマンドのプロセス名補完


#######################################
# Prompt
#######################################
autoload colors
colors
PROMPT="[%n] %{${fg[yellow]}%}%c%{${reset_color}%} %# "


#######################################
# Color
#######################################
export LSCOLORS=Exfxcxdxbxegedabagacad  # 色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'   # 補完時の色の設定
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true                    # lsコマンド時、自動で色付け
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}  # 補完候補に色を付ける


#######################################
# ssh-add
#######################################
# http://qiita.com/garaemon/items/988da9c6345cf1589d96
echo -n "ssh-agent: "
if [ -e ~/.ssh-agent-info ]; then
 source ~/.ssh-agent-info
fi

ssh-add -l >&/dev/null
if [ $? = 2 ] ; then
 echo -n "ssh-agent: restart...."
 ssh-agent >~/.ssh-agent-info
 source ~/.ssh-agent-info
fi
if ssh-add -l >&/dev/null ; then
 echo "ssh-agent: Identity is already stored."
else
 ssh-add
fi

#######################################
# Alias
#######################################
alias ls="ls -aFG"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

alias df='df -kh'
alias du='du -kh'

alias mkdir='mkdir -p'

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ..='cd ..' # ひとつ上へ
alias ...='cd -'

alias grep='grep -n --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

alias sudo='sudo '    # sudo の後のコマンドでエイリアスを有効にする


#######################################
# function
#######################################
# mkdir & cd
function mkcd(){
  mkdir -p "$@" && cd "$@";
}
alias mkcd=mkcd

# 最終更新日付取得
function statt1 {
  stat -c %z $1 | cut -d '.' -f 1 | sed -e 's/-//g' | sed -e 's/ //g' | sed -e 's/://g'
}
alias statt1='\statt1'
# 最終更新日付を付加してバックアップファイルを作成
function cp_back {
  cp $1 $1.`statt1 $1`
}
alias cpbk='\cp_back'


#######################################
# load .zshrc_*
#######################################
[ -f $ZDOTDIR/.zshrc_prompt ] && . $ZDOTDIR/.zshrc_prompt
[ -f $ZDOTDIR/.zshrc_external ] && . $ZDOTDIR/.zshrc_external
[ -f $ZDOTDIR/.zshrc_local    ] && . $ZDOTDIR/.zshrc_local
[ -f $ZDOTDIR/.zshrc_`whoami`  ] && . $ZDOTDIR/.zshrc_`whoami`
