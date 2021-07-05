#! /usr/bin/bash

RED='\033[1;31m'
BL='\033[1;32m'
NC='\033[0m' # No Color

bold=$(tput bold)
normal=$(tput sgr0)

for x in `ls $1_*.in`
do
    echo -e "${BL}Input:${NC} $x"
    if [ $# -eq 2 ]
    then 
	echo ;
        cat $x
    fi
    
    echo ;
    T="$(date +%s%N)"
    bash -c "./$1 < $x" | tee OutputFile
    T="$(($(date +%s%N)-T))"
    S="$((T/1000000000))" 
    M="$((T/1000000%1000))"
    echo ;

    Name=$(basename $x .in)

    if [ -e $Name.out ]
    then
	    tail -n +4 <(colordiff -cb OutputFile $Name.out) | tee DiffOutput
	    if [ -s DiffOutput ]
	    then
		:
	    else 
		echo -e "${BL}Correct Output!!! ${NC}"
	    fi
	    echo ;
	    bash -c "rm DiffOutput"
    fi

    bash -c "rm OutputFile"
    printf "${RED}Execution time:${NC} %d.%03d\n" "$S" "$M"
    printf %"$COLUMNS"s |tr " " "="
    echo ; echo ;
done


