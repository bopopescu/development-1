# Preserve original path variable in case we resource this file
if [ -z "$PATH_ORIG" ]
    set -x PATH_ORIG $PATH
    # echo "### Orignal PATH variable saved as: $PATH_ORIG ###"
end
if [ -z "$SHELL_ORIG" ]
    set -x SHELL_ORIG $SHELL

    # echo "### Orignal SHELL variable saved as: $SHELL_ORIG ###"
    # chsh -s /usr/local/bin/fish
end

# Environment variables
#JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home
set -x JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home

# MODIFYING PATH CAN BE DONE IN ONE OF THE FOLLOWING WAYS
set -x PATH $PATH_ORIG . ~/mongodb/bin $CATALINA_HOME/bin ~/maven/bin ~/Scripts ~/activemq/bin ~
#set -U fish_user_paths $fish_user_paths . ~/mongodb/bin $CATALINA_HOME/bin ~/maven/bin ~/Scripts ~/activemq/bin ~

set -x PROFILE_FILE ~/.config/fish/config.fish
set -x GIT_REPO /Users/Sterner/gitrepos
set -x CATALINA_HOME ~/tomcat
set -x SCRIPTS_DIR ~/Scripts
set -x APP_LOG_DIR ~/Logs
set -x SS_LOG $APP_LOG_DIR/security-service.log
set -x AS_LOG $APP_LOG_DIR/asset-service.log
set -x DS_LOG $APP_LOG_DIR/delivery-service.log
set -x DEVELOPMENT_DIR ~/Development
set -x DEV_DIR $DEVELOPMENT_DIR
set -x RESOURCE_DIR src/main/resources
set -x EOL "
"

# export PATH JAVA_HOME GIT_REPO SCRIPTS_DIR APP_LOG_DIR SS_LOG AS_LOG DS_LOG DEVELOPMENT_DIR DEV_DIR

# Aliases
alias ls='ls -G'
alias ll='ls -al'
alias mkdir='mkdir -p'
alias grep='egrep -i'
alias egrep='egrep -i'
alias renv='. $PROFILE_FILE'
alias eenv='vi $PROFILE_FILE'
alias pd='pushd'
alias cdh='cd ~'
alias pdh='pd ~'
alias f='functions'
alias fnc='functions'
alias func='functions'

alias devhome='pushd $DEV_DIR'
alias dev='devhome'
#alias tclog='tail -f -n 50 $CATALINA_HOME/logs'
alias tch='tchome'
alias gotmp='pushd ~/tmp'
#alias goadd='pushd $GIT_REPO/comcast-addelivery'
#alias goadmin='pushd $GIT_REPO/comcast-admin-html5'
#alias goreach='pushd $GIT_REPO/reach-engine'
alias gogit='pushd $GIT_REPO'
alias gg='gogit'
alias gosecurity='gogit; pushd security-service'
alias gosec='gosecurity'
alias gose='gosecurity'
alias goss='gosecurity'
alias goasset='gogit; pushd asset-service'
alias goas='goasset'
alias goass='goasset'
alias godelivery='gogit; pushd delivery-service'
alias gode='godelivery'
alias godel='godelivery'
alias goans='gogit; pd analytics-service'
alias goms='gogit; pd metadata-search-service'
alias gomes='goms'
alias goem='gogit; pd event-messaging-module'
alias gor='pd src/main/resources'
alias gore='gor'
alias gores='gor'
alias home='pushd ~'
alias gore='goreach'
alias m2='pushd ~/.m2'
alias mc='mvn clean'
alias mci='mc install'
alias mciq='mci -q'
alias mcix='mci -X'
alias mcis='mci -DskipTests'
alias mcisq='mcis -q'
alias mcisx='mci -X'
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
alias startss='eval $SCRIPTS_DIR/run-service.sh security-service'
alias startas='eval $SCRIPTS_DIR/run-service.sh asset-service'
alias startds='eval $SCRIPTS_DIR/run-service.sh delivery-service'
alias startms='eval $SCRIPTS_DIR/run-service.sh metadata-search-service; startes'
alias startans='eval $SCRIPTS_DIR/run-service.sh analytics-service'
alias startall='startss;startas;startds;startms;startans'

alias mdbss='eval $SCRIPTS_DIR/db-migrate.sh security-service'
alias mdbas='eval $SCRIPTS_DIR/db-migrate.sh asset-service'
alias mdbds='eval $SCRIPTS_DIR/db-migrate.sh delivery-service'
alias mdbms='eval $SCRIPTS_DIR/db-migrate.sh metadata-search-service'
alias mdbans='eval $SCRIPTS_DIR/db-migrate.sh analytics-service'

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
alias vimig='vi $RESOURCE_DIR/migrations.xml'
alias vidc='vi $RESOURCE_DIR/default-configuration.yml'
alias mvdc='mv $RESOURCE_DIR/default-configuration.yml $RESOURCE_DIR/default-configuration.yml.bak; git checkout $RESOURCE_DIR/default-configuration.yml'
alias rsdc='mv $RESOURCE_DIR/default-configuration.yml.bak $RESOURCE_DIR/default-configuration.yml'

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
alias grhum='git reset --hard upstream/master'
alias gitreset='grhum'
alias gprall='goas;gpr;goans;gpr;godel;gpr;goms;gpr;gose;gpr;goem;gpr'
# Process search & action aliases
alias pstc='ps -aef | grep tomcat | grep -v grep'
alias tcstatus='pstc | grep -v grep'
alias pspg='ps -aef | grep -i gres | grep -v grep'
alias psmg='ps -aef | grep -i mongo | grep -v grep'
alias psmq='ps -aef | grep -i activemq | grep -v grep'

# Node (NPM) Aliases
alias ni='npm install'
alias nodeinstall='ni'
alias nodeupdate='ni'

# Miscellaneous
alias ecp='echoconfigprops'

# Useful functions
function echoarg
echo " argv one is $argv[1]"
#  echo "Argument is $argv[0]"
#  echo "Argument is $argv[1]"
end

function killps
    set PSNAME $argv[1]
    if [ ! -z "$PSNAME" ];
	echo
        echo "Killing all processes matching name '$PSNAME'..."
        kill (eval ps -aef | grep -i $PSNAME | grep -v grep | awk '{print $2}') 2>/dev/null
	echo "Process kill complete."
	echo
    else
	echo "***"
        echo "*** Error: Please provide a process name to search for and terminate ***"
        echo "***"
    end 
end

function echoconfigprops
    echo "  region: us-west-1"
    echo "  endpoint: sqs.us-west-1.amazonaws.com"
    echo "  queueName: test_cloudform_bsterner_queue"
end

function gitpob  -d "Finds current branch and pushes origin"
    set gitcmd (eval gb | awk '/\* [a-zA-Z]/ {print $2}')
    echo "Executing command: git push origin $gitcmd"
    git push origin $gitcmd
end

# Run custom commands in ci config file
# source $SCRIPTS_DIR/ci-custom.sh
