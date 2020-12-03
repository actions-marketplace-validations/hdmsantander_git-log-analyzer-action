#!/bin/sh 

HOME=/home/gitloganalyzer

git --version

if [ -n "$INPUT_INIT_DATE" ]; then
    echo "Using start date $INPUT_INIT_DATE"
    git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat --after=$INPUT_INIT_DATE > $HOME/git.log
else
    MIN_DATE=$(date +'%Y-%m-%d' -d 'last month')
    echo "Looking for commits since $MIN_DATE"
    git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat --after=$MIN_DATE > $HOME/git.log
fi

FREQUENCIES=$(java -jar $HOME/gitloganalyzer.jar -f $HOME/git.log)
COUPLING=$(java -jar $HOME/gitloganalyzer.jar -f $HOME/git.log -coupling $INPUT_MIN_COCHANGES)

if [ -n "$FREQUENCIES" ]; then
    echo "::set-output name=frecuencies::$FREQUENCIES"
else
    echo "::set-output name=frecuencies::empty"
fi

if [ -n "$COUPLING" ]; then
    echo "::set-output name=coupling::$COUPLING"
else
    echo "::set-output name=coupling::empty"
fi
