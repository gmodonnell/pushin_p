#!/bin/bash
# Graham O'Donnell wants to have a pretty github

# There is a 10% chance I do not code on any given day.
# There is a 5% chance I code a sprint (20-35 commits) on any given day.
# There is an 85% chance I code lightly (1-10 commits) on any given day.
chance = $((1 + $RANDOM % 100))

# CHANGE THESE TO YOUR REPO FILES
# pushfile is the gile that's amended 
# lyricfile is your lyrics
pushfile = /home/didact/Documents/gitRepos/pushin_p/pushin.txt
lyricfile = /home/didact/Documents/gitRepos/pushin_p/lyrics.txt

# Determines number of commits that will be made
# If the roll determines no commits, the program exits
if [ $chance -gt 95 ]
then
	commits = $((11 + $RANDOM % 20))
elif [ $chance -gt 10 ]
then
	commits = $((1 + $RANDOM % 10))
else
	exit 0
fi

# The commit message is generated
cmsg = sed -n '1p' lyricfile #this doesn't work

# The line used for cmsg is moved to the bottom of the file
# and every line is moved up 1 so the next commit message
# is the next lyric in the file

#The chosen number of commits are pushed to the Hub ;)
for i in `seq 1 $commits`;
do
	echo $RANDOM | md5sum > $pushfile
	git add *
	git commit * -m $cmsg
	git push
done
