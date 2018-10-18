x=$(xinput list-props 11 | sed '2!d' | tr -d -c 0-9) #Skräp, läs status |ta ut rad 2| ta bort allt utom siffror 
if  [ "1471" == "$x" ]; then
	$(xinput disable 11)
	i
else 
	xinput enable 11
fi


