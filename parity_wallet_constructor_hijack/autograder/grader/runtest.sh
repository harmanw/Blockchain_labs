
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

    test_attacker=0
    test_bank=0

    # TEST ATTACKER

    if [ -f "../$dir/attacker.sol" ]
    then
        cp ../$dir/attacker.sol contracts
        test_attacker=1
    else
        echo "No attacker.sol found for $submission"
    fi 

    echo "" > ../$dir/results.txt

    if [ test_attacker ]
    then

        #copy vulnerbale bank contract
        cp ../files/bank_vuln.sol contracts/bank.sol

        #copy solidity tests for attacker
        rm test/*
        cp ../files/attacker_test.sol test

        safe_migrate

        result=`truffle test`

        echo -e "$result" >> ../$dir/results.txt
        echo -e "$result"
    fi

    # TEST BANK

    if [ -f "../$dir/bank.sol" ]
    then
        cp ../$dir/bank.sol contracts
        test_bank=1
    else
        echo "No bank.sol found for $submission"
    fi 

    if [ test_bank ]
    then

        #copy correct attacker exploit contract
        cp ../files/attacker_correct.sol contracts/attacker.sol

        #copy solidity tests for bank
        rm test/*
        cp ../files/bank_test.sol test

        safe_migrate
        
        result=`truffle test`

        echo -e "$result" >> ../$dir/results.txt
        echo -e "$result"
    fi

    cd ..
    rm -rf testspace

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

