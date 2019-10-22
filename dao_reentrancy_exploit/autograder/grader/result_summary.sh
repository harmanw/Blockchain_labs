name=$1
path=$2
sed -n "/$name/,/Using network/p" $2 | grep -E "passing|failing"