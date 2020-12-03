#!/bin/sh 

HOME=/home/gitloganalyzer

if [ -n "$INPUT_INIT_DATE"] && [ -n "$INPUT_END_DATE"]; then
    git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat --after=$INPUT_INIT_DATE --before=$INPUT_END_DATE > $HOME/git.log
else
    MIN_DATE=$(date +'%Y-%m-%d' -d 'last month')
    git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat --after=$MIN_DATE > $HOME/git.log
fi

java -jar $HOME/gitloganalyzer.jar -f $HOME/git.log > $HOME/frecuencies.csv
FREQUENCIES=`cat $HOME/frecuencies.csv`

java -jar $HOME/gitloganalyzer.jar -f $HOME/git.log -coupling $INPUT_MIN_COCHANGES > $HOME/coupling.csv
COUPLING=`cat $HOME/coupling.csv`

if [ -n "$FREQUENCIES"]; then
    echo "::set-output name=frecuencies::$FREQUENCIES"
else
    echo "::set-output name=frecuencies::empty"
fi

if [ -n "$COUPLING"]; then
    echo "::set-output name=coupling::$COUPLING"
else
    echo "::set-output name=coupling::empty"
fi
