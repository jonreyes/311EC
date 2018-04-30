usage() { echo "Usage: $0 [-C] [-M <number>] FILE" 1>&2; exit 1; }

m=755
while getopts ":CM:" o; do
    #echo o $o
    case "${o}" in
        C)
            c=true
            ;;
        M)
            m=${OPTARG}
	    if ! [ "$m" -eq "$m" ] 2>/dev/null; then
		a=$m
		m=755
	    fi
            ;;
        *)
            echo "$o"
	    usage
            ;;
    esac
done
shift $((OPTIND-1))

#if $c; then
#	echo capitalize
#fi
#echo "m = ${m}"
#echo $a
f=$1
if [ -n "$a" ]; then
	#echo a
	f=$a
fi
if [ -z "$f" ]; then
	usage
fi
#echo f $f
while read name email rest; 
do 
	first=$(echo $name | cut -d\, -f1)
	last=$(echo $name | cut -d\, -f2)
	dir=$(echo "$last""_""$first")
    	ewb=$(echo $email | sed 's/[][]//g')
	if $c; then
		dir=$(echo $dir | tr /a-z/ /A-Z/)
	fi
	file=$(echo "$dir"/"$ewb")
	mkdir "$dir"
	touch "$file"
	if [ $m -ge 0 ]; then
	 	chmod -R $m $dir
		if [ -n "$ewb" ]; then
			chmod -R $m $file
		fi
	fi
done < "$f"

