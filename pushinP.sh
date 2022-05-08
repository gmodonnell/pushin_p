#!/bin/bash
# Authored by Graham O'Donnell
# The easy way to trick recruiters into looking at your github repos.

# There is a 10% chance I do not code on any given day.
# There is a 5% chance I code a sprint (20-35 commits) on any given day.
# There is an 85% chance I code lightly (1-10 commits) on any given day.
chance=$((1 + $RANDOM % 100))
fuck=p
shit=1
# CHANGE THESE TO YOUR REPO FILES
# lyricfile is your lyrics
# repofile is the directory of repos on your machine
lyricfile='/home/didact/Documents/gitRepos/pushin_p/lyrics.txt'
pushfile='/home/didact/Documents/gitRepos/pushin_p/push.txt'
lyrlength=$(wc -l $lyricfile)
# Determines number of commits that will be made
# If the roll determines no commits, the program exits
if [ $chance -gt 95 ]
then
	commits=$((11 + $RANDOM % 20))
elif [ $chance -gt 10 ]
then
	commits=$((1 + $RANDOM % 10))
else
	exit 0
fi

echo "There will be $commits commits posted today"

#The chosen number of commits are pushed to the Hub ;)
for i in `seq 1 $commits`;
do
    echo "Iter $i starting"
	#Push random string to pushfile
	echo $RANDOM | md5sum > $pushfile
	#Check file index line, pull lyric and increment
	lyrnum=$(sed -n '1p' "$lyricfile")
	sedmes="$lyrnum$fuck"
	echo $lyrnum is lyrnum
	# The commit message is generated
    cmsg=$(sed -n "$sedmes" "$lyricfile")
    echo $cmsg is cmsg
    nlyrnum=$(($lyrnum+$shit))
    echo $nlyrnum is the new lyric increment
    sed -i "s/^${lyrnum}/$nlyrnum/g" $lyricfile
	git add *
	git commit * -m "$cmsg"
	git push
	if [ "$lyrnum" -ge "$lyrlength" ] 
	then
	    sed -i "s/^${lyrnum}/2/g" $lyricfile
	else
	    :
	fi
done
