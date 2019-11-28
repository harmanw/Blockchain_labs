
###########################################################################
# Functions
###########################################################################

gpid=""

function new_ganacheCLI(){
    if [ ! -z gpid ]
    then
        kill gpid
    fi

    ganache-cli &> /dev/null &
    gpid=$!
    echo "new ganache cli at $gpid"

}

function safe_migrate(){

    migrate=`truffle migrate --reset`
    n=`echo "$migrate" | grep 'have enough funds to send tx' | wc -l`
    #echo "migration error $n"
    if [[ n -gt 0 ]]
    then
        new_ganacheCLI
        sleep 2
        migrate=`truffle migrate --reset`
        n=`echo "$migrate" | grep 'have enough funds to send tx' | wc -l`
        if [[ n -gt 0 ]]
        then
            echo "Migration error. $n"
            exit 
        fi 
    fi
}


function run_single(){

    dir=$1
    submission=`basename $dir`

    mkdir logs

    rm -rf testspace
    mkdir testspace
    cd testspace

    log="../../logs/$submission.log"
    touch $log

    #new_ganacheCLI

    init=`truffle init`
    echo -e "$init" >> $log 

    cp ../files/truffle-config.js .
    cp ../files/2_deploy_contracts.js migrations
    cp ../files/Migrations.sol contracts


    # TEST 
    test=0

    if [ -f "../$dir/essay.sol" ] && [ -f "../$dir/string.sol" ] 
    then
        cp ../$dir/string.sol contracts
        cp ../$dir/essay.sol contracts
        test=1
    else
        echo "No files found for $submission"
    fi 

    echo "" > ../$dir/results.txt

    if [ test ]
    then

        #copy solidity tests for attacker
        rm test/*
        cp ../files/test.sol test

        safe_migrate

        result=`truffle test`

        echo -e "$result" >> ../$dir/results.txt
        echo -e "$result"
    fi


    cd ..
    rm -rr testspace

}


function run_multiple() {

    dir=$1 

    if [ ! -d $dir ]
    then
        echo "No such directory found ($submission)"
        exit
    fi

    for submission in $dir/*; do
        run_single $submission
    done 

}


function result_summary(){
    name=$1
    path=$2
    sed -n "/$name/,/Using network/p" $2 | grep -E "passing|failing"
}


############################################################################

submission=""

while getopts "s:d:h" arg; do
  case $arg in
    s)
      submission=$OPTARG
      run_single $submission
      ;;
    
    d)
      directory=$OPTARG
      run_multiple $directory
      ;;
    
    h)
      echo "usage" 
      ;;
  esac
done

