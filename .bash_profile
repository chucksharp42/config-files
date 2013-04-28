# dev logs
alias l="tail -f /etc/httpd/logs/*error* | sed 's/\\\\n/\\n/g'"

# ops
alias d="sudo"
alias seout="sealert -a /var/log/audit/audit.log > out1"
alias r='sudo bash --login'
alias c='cap -f ~/bin/Capfile'

# other
alias resource=". ~/.bash_profile"
alias nh="history | grep"
function h { grep $* ~/.bash_history; }
alias psa='ps ax'
function is () { psa -w | grep "$@" | grep -v grep; }


# source the system wide bashrc if it exists
if [ -e /etc/bash.bashrc ] ; then
  source /etc/bash.bashrc
fi

# source the users bashrc if it exists
if [ -e "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

# Make home directory setup
for d in tmp log svn bin; do
	if [ ! -e $HOME/$d ]; then
		mkdir -p $HOME/$d
	fi
done

# usage: "$ genpasswd 9"
function genpasswd() {
	local l=$1
	[ "$l" == "" ] && l=20
	tr -dc 'A-Za-z0-9_~!@#$%^&*()-=+:;.,<>[]{}/?' < /dev/urandom | head -c ${l} | xargs
}

function ssh_setup() {
  if true; then
  
    KEY=$HOME/.ssh/priv

    # Start ssh-agent or if loaded set appropriate variables to access it
    if [ -f ~/.agent.lock ]; then
        echo "Waiting for another shell to finish ssh user authentication"
    
        while [ -f ~/.agent.lock ]
        do
          sleep 1
        done
    fi
    
    #if [ "$TERM" == "xterm" ]; then
      #SSH_ADD_CMD="echo \"$SSH_ASKPASS\" | ssh-add"
    #else
      SSH_ADD_CMD="ssh-add $KEY"
    #fi
    
    if [ -f ~/.agent.env ]; then
    
      . ~/.agent.env > /dev/null
      
      if [ -z "$SSH_AGENT_PID" ]; then
          echo "AGENT PID not defined! Aborting..."
          exit 255
      fi

      if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        touch ~/.agent.lock
         echo "Stale agent file found. Spawning new agent..."
         eval `ssh-agent | tee ~/.agent.env`
         eval $SSH_ADD_CMD
        rm -f ~/.agent.lock
      fi
    
    else
    
      touch ~/.agent.lock
      echo "Starting ssh-agent"
      eval `ssh-agent | tee ~/.agent.env`
      eval $SSH_ADD_CMD
      rm -f ~/.agent.lock
    
    fi
    
  fi > $HOME/tmp/sshsetup.log.$$ 2>&1
  
}

# User specific environment and startup programs

function addpath() {
	if ! echo $PATH | grep -q '\(^\|:\)'$1'\($\|:\)' ; then
    if [ -d $1 ]; then
      export PATH=$PATH:$1
    fi
	fi
}
export PATH=/usr/local/bin:$PATH
addpath $HOME/.bin
addpath $HOME/bin
unset addpath

# Don't overwrite history file - allows for multiple history sessions
shopt -s histappend
export PROMPT_COMMAND='history -a'

export PAGER="less"
export HISTFILESIZE="10000"
export EDITOR="vi"
export FIGNORE='.o:~:.svn'
export LC_ALL='C'
export LESS="--ignore-case -M"
#export PS1='\n\033[32;1m---- \033[33;1m'$HOSTNAME'\033[0m:\[\033[35;1m\w \033[32;1m---- \033[34;1m\d \t \033[32;1m---- \n\033[30;0m\$ '

if [ -e $HOME/.adminaccount ]; then
	ssh_setup
	shopt -s progcomp
fi

if [ -e $HOME/.runfetchmail ]; then
  /usr/bin/fetchmail
fi

if [ "$TERM" == "xterm" ]; then
	if [ "$USER" == "root" ]; then
		USERSYM='#'
	else
		USERSYM='$'
	fi
	export PROMPT_COMMAND='history -a; echo -ne "\033]0;'$HOSTNAME'${USERSYM}:${PWD}\007"' 
fi

export PROFILE_READ=1

for i in `ls ~/.bash_profile.*`
do
  source $i
done
