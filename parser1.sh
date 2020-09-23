infile=$1

declare -A indis
id=""
for tk in `grep -Eo '(0 @.*@ INDI|1 NAME .* ?/.*/)' $infile | sed -e 's/0 @/@/g; s/@ INDI/@/g; s/1 NAME //g; y/\x22/\x27/; s/\///g; s/ *$//g; y/ /_/'`; do
	if [ "${tk:0:1}" = "@" ]; then
		id=$tk
	else
		indis[$id]=$tk
	fi
done
i=0
for tk in `grep -Eo '(@.*@|HUSB|WIFE|CHIL) (FAM|@.*@)' $infile`; do
	fams[$i]=$tk
	i=$[ $i + 1 ]
done

i=0
while [ $i -lt ${#fams[@]} ]; do
	i=$[ $i + 2 ]
	if [ ${fams[$i]} = HUSB ]; then
		i=$[ $i + 1 ]
		husb=${indis[${fams[$i]}]}
	elif [ ${fams[$i]} = WIFE ]; then
		i=$[ $i + 1 ]
		wife=${indis[${fams[$i]}]}
	else
		continue
	fi

	i=$[ $i + 1 ]
	if [ ${fams[$i]} = HUSB ]; then
		i=$[ $i + 1 ]
		husb=${indis[${fams[$i]}]}
	elif [ ${fams[$i]} = WIFE ]; then
		i=$[ $i + 1 ]
		wife=${indis[${fams[$i]}]}
	else
		continue
	fi

	i=$[ $i + 1 ]
	while [[ $i -lt ${#fams[@]} && ${fams[$i]} = CHIL ]]; do
		i=$[ $i + 1 ]
		chil=${indis[${fams[$i]}]}
		echo -e "father(\x27$husb\x27,\x27$chil\x27).\nmother(\x27$wife\x27,\x27$chil\x27)." | sed -e 's/\x27_*/\x27/g; s/_*\x27/\x27/g; y/_/ /'
		i=$[ $i + 1 ]
	done
done