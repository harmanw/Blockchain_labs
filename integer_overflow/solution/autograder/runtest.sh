
function usage(){
    USAGE=$(cat <<-END
    USAGE: ./runtest [mode] [path]
    
    Modes:
        -s : single student directory
            Ex: ./runtest.sh -s allsubmissions/student1
        
        -d : single all submissions directory
            Ex: ./runtest.sh -s allsubmissions
        
        -h : usage
END
)
    echo -e "$USAGE"
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

function run_single() {

    dir=$1
    
    echo "run single $1"
    fname="$dir/answer.json"

    if [ ! -f $fname ]
    then
        echo "No such directory found ($submission)"
        fail $dir
    fi

    res=""

    for k in $(cat $fname | jq  -c '.transactions' | jq -c ".[]")
    do  
        res=`grep -E "255.*myanswer" <<< $k`
    done

    if [ -z $res ]
    then
        fail $dir
    else
        pass $dir  
    fi

}

function fail(){

    test_fail="0 Test Failed"
    echo "$test_fail" > $1/result.txt
}

function pass(){
    
    test_pass="1 Test Passed"
    echo "$test_pass" > $1/result.txt
}

###############################################################################3

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
      usage
      ;;
  esac
done
