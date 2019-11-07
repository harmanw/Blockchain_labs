
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

    perform_test = 0

    # TEST ATTACKER


    if [ -f "../$dir/starter.sol" ]
    then
        cp ../$dir/starter.sol contracts
        perform_test=1
    else
        echo "No starter.sol found for $submission"
    fi 

    echo "" > ../$dir/results.txt

    if [ perform_test ]
    then

        #copy solidity tests 
        rm test/*
        cp ../files/overflow_test.sol test

        safe_migrate

        result=`truffle test`

        echo -e "$result" >> ../$dir/results.txt

        # test answer.json
        res = ""
        res=`grep -E "255.*myanswer" <<< $(cat $fname | jq  -c '.transactions' | jq -c ".[]")`
        if [ -z $res ]
        then
            fail $dir
        else
            pass $dir  
        fi

        echo -e "$result"
    fi

    cd ..
    rm -rf testspace

}

function fail(){

    test_fail="0 Test Failed"
    echo "$test_fail" > $1/result.txt
}

function pass(){
    
    test_pass="1 Test Passed"
    echo "$test_pass" > $1/result.txt
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

