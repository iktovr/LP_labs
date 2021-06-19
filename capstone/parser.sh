#!/usr/bin/env bash

infile=$1
outfile=$2

> $outfile

declare -a tokens
i=0

for tk in `grep -Eo '(0 @.*@ INDI|1 NAME .* ?/.*/)' $infile | sed -e '/NAME/s/[ \t]/_/g; s/1_NAME_*/NAME /g; s/0 @/@/g; y/\x27/\x22/; s/\/_*//g;'`; do
	tokens[i]="\x27$tk\x27,"
	i=$[ $i + 1 ]
done

for tk in `grep -Eo '(@.*@|HUSB|WIFE|CHIL) (FAM|@.*@)' $infile`; do
	tokens[i]="\x27$tk\x27,"
	i=$[ $i + 1 ]
done

tokens[$[ $i - 1 ]]=${tokens[$[ $i - 1 ]]:0:$[ ${#tokens[$[ $i - 1 ]]} - 1]}

swipl --goal=main -o parser -c parser.pl || exit 1
echo -e "\x27$outfile\x27.\n[${tokens[@]}]." | sed "s/_/ /g; s/ *'/'/g" | ./parser
sort -o $outfile $outfile
