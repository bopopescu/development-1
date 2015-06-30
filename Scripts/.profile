# Preserve original path variable in case we resource this file
if [ -z "$PATH_ORIG" ]; then
    export PATH_ORIG="$PATH"
    echo
    echo "### Orignal PATH variable saved as: $PATH_ORIG ###"
    echo
fi
if [ -z "$SHELL_ORIG" ]; then
    export SHELL_ORIG="$SHELL"
    echo
    echo "### Orignal SHELL variable saved as: $SHELL_ORIG ###"
    echo
#    chsh -s /usr/local/bin/fish
fi

# Environment variables
#JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home"
JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home"
PATH=$PATH_ORIG:.:~/mongodb/bin:$CATALINA_HOME/bin:~/maven/bin:~/postgres/bin:~/Scripts:~/activemq/bin:~
PROFILE_FILE=~/.profile
GIT_REPO='/Users/Sterner/gitrepos'
CATALINA_HOME=~/tomcat
SCRIPTS_DIR=~/Scripts
APP_LOG_DIR=~/Logs
SS_LOG=$APP_LOG_DIR/security-service.log
AS_LOG=$APP_LOG_DIR/asset-service.log
DS_LOG=$APP_LOG_DIR/delivery-service.log
DEVELOPMENT_DIR=~/Development
DEV_DIR=$DEVELOPMENT_DIR

export PATH JAVA_HOME GIT_REPO SCRIPTS_DIR APP_LOG_DIR SS_LOG AS_LOG DS_LOG DEVELOPMENT_DIR DEV_DIR

# Aliases
alias ls='ls -G'
alias ll='ls -al'
alias mkdir='mkdir -p'
alias grep='egrep -i'
alias egrep='egrep -i'
alias renv='. $PROFILE_FILE'
alias eenv='vi $PROFILE_FILE'
alias pd='pushd'

alias devhome='pushd $DEV_DIR'
alias dev='devhome'
#alias tclog='tail -f -n 50 $CATALINA_HOME/logs'
alias tch='tchome'
#alias goadd='pushd $GIT_REPO/comcast-addelivery'
#alias goadmin='pushd $GIT_REPO/comcast-admin-html5'
#alias goreach='pushd $GIT_REPO/reach-engine'
alias gogit='pushd $GIT_REPO'
alias gg='gogit'
alias gosecurity='gogit; pushd security-service'
alias gosec='gosecurity'
alias gose='gosecurity'
alias goasset='gogit; pushd asset-service'
alias goas='goasset'
alias goass='goasset'
alias godelivery='gogit; pushd delivery-service'
alias gode='godelivery'
alias godel='godelivery'
alias goans='gogit; pd analytics-service'
alias gor='pd src/main/resources'
alias gore='gor'
alias gores='gor'
alias home='pushd ~'
alias gore='goreach'
alias m2='pushd ~/.m2'
alias mc='mvn clean'
alias mci='mc install'
alias mcis='mci -DskipTests'
alias mt='mvn test'
alias fn='find . -name'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias ccdoc='pushd ~/Documents/"Comcast AdDelivery User Guides"'
alias scripts='pushd ~/Scripts'
alias cleardirs='dirs -c'
alias cleardir='cleardirs'
alias cld='cleardirs'
alias cleard='cleardirs'
alias ap='apiary preview'
alias apip='ap'
alias log='pushd $APP_LOG_DIR'

# Build modules
alias mciss='gg;cd security-service;mci'
alias mcias='gg;cd asset-service;mci'
alias mcians='gg;cd analytics-service;mci'
alias mciem='gg;cd event-messaging-module;mci'
alias mciall='mciem;mciss;mcias;mcians'

# Kill processes
alias killmq='killps activemq'
alias killtc='killps tomcat'
alias killpg='killps postgres'
alias killmg='killps mongod'
#alias killall='killmq;killtc;killpg;killmg'

# Application start/stop/home
alias mongod='nohup mongod -dbpath ~/data/db 2>&1 >~/mongodb/logs/mongodb.log &'
alias mongodb='mongod'
alias startmq='pushd ~/activemq/bin;./macosx/activemq start;popd'
alias starttc='$CATALINA_HOME/bin/startup.sh'
alias stoptc='$CATALINA_HOME/bin/shutdown.sh'
alias tchome='pushd $CATALINA_HOME'
# Start cloudform-reference application
alias startcf='gg;pushd cloudform-reference;gulp watch'

# Elastic search aliases
alias startelastic='elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml 2>&1 >$APP_LOG_DIR/elastic-search.log &'
alias startes='startelastic'
alias stopelastic='killps elasticsearch'
alias stopes='stopelastic'
alias esquery='curl -XGET http://localhost:9200/cloudform'

# Cloudform service aliases
alias startss='$SCRIPTS_DIR/run-service.sh security-service'
alias startas='$SCRIPTS_DIR/run-service.sh asset-service'
alias startds='$SCRIPTS_DIR/run-service.sh delivery-service'
alias startms='$SCRIPTS_DIR/run-service.sh metadata-search-service; startes'
alias startans='$SCRIPTS_DIR/run-service.sh analytics-service'
alias startall='startss;startas;startds;startms;startans'

alias mdbss='$SCRIPTS_DIR/db-migrate.sh security-service'
alias mdbas='$SCRIPTS_DIR/db-migrate.sh asset-service'
alias mdbds='$SCRIPTS_DIR/db-migrate.sh delivery-service'
alias mdbms='$SCRIPTS_DIR/db-migrate.sh metadata-search-service'
alias mdbans='$SCRIPTS_DIR/db-migrate.sh analytics-service'

alias sslog='tail $APP_LOG_DIR/security-service.log'
alias aslog='tail $APP_LOG_DIR/asset-service.log'
alias dslog='tail $APP_LOG_DIR/delivery-service.log'
alias mslog='tail $APP_LOG_DIR/metadata-search-service.log'
alias anslog='tail $APP_LOG_DIR/analytics-service.log'
alias sslogf='tail -f $APP_LOG_DIR/security-service.log'
alias aslogf='tail -f $APP_LOG_DIR/asset-service.log'
alias dslogf='tail -f $APP_LOG_DIR/delivery-service.log'
alias mslogf='tail -f $APP_LOG_DIR/metadata-search-service.log'
alias anslogf='tail -f $APP_LOG_DIR/analytics-service.log'
alias visslog='vi $APP_LOG_DIR/security-service.log'
alias viaslog='vi $APP_LOG_DIR/asset-service.log'
alias vidslog='vi $APP_LOG_DIR/delivery-service.log'
alias vimslog='vi $APP_LOG_DIR/metadata-search-service.log'
alias vianslog='vi $APP_LOG_DIR/analytics-service.log'
alias vidc='vi src/main/resources/default-configuration.yml'

alias rsss='killss;startss'
alias rsas='killas;startas'
alias rsds='killds;startds'
alias rsms='killms;startms'
alias rsans='killans;startans'
alias killss='killps security-service'
alias killas='killps asset-service'
alias killds='killps delivery-service'
alias killms='killps metadata-search-service;stopes'
alias killans='killps analytics-service'
alias killall='killss;killas;killds;killms;killans'
alias psgrep='ps aux | grep -v grep | grep'
alias psss='psgrep security-service'
alias psas='psgrep asset-service'
alias psds='psgrep directory-service'
alias psms='psgrep metadata-search-service'
alias psans='psgrep analytics-service'
alias pssvc='psgrep snapshot'

# Git aliases
alias gs='git status'
#alias gi='vi ~/.gitignore'
alias gb='git branch'
alias grau='git remote add upstream '
alias gfu='git fetch upstream'
alias guc='git rebase -i HEAD~3'
alias guc2='`guc`2'
alias gpr='git pull --rebase upstream master'

# Process search & action aliases
alias pstc='ps -aef | grep tomcat | grep -v grep'
alias tcstatus='pstc | grep -v grep'
alias pspg='ps -aef | grep -i gres | grep -v grep'
alias psmg='ps -aef | grep -i mongo | grep -v grep'
alias psmq='ps -aef | grep -i activemq | grep -v grep'

# Useful functions
function killps {
    if [ ! -z "$1" ]; then
	echo
        echo "Killing all processes matching name '$1'..."
        kill `ps -aef | grep -i $1 | grep -v grep | awk '{print $2}'` 2>/dev/null
	echo "Process kill complete."
	echo
    else
	echo "***"
        echo "*** Error: Please provide a process name to search for and terminate ***"
        echo "***"
    fi
}

# Run custom commands in ci config file
source $SCRIPTS_DIR/ci-custom.sh
