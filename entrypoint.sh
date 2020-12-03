#!/bin/sh 

if [ -z "$INPUT_INIT_DATE"] && [ -z "$INPUT_END_DATE"]; then
    git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat --after=$INPUT_INIT_DATE --before=$INPUT_END_DATE
else
    MIN_DATE=$(date +'%Y-%m-%d' -d 'last month')
    git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat --after=$MIN_DATE
fi

FREQUENCIES=$(java -jar /home/gitloganalyzer/gitloganalyzer.jar -f git.log)
COUPLING=$(java -jar /home/gitloganalyzer/gitloganalyzer.jar -f git.log -coupling $INPUT_MIN_COCHANGES)

if [ -z "$FREQUENCIES"] && [ -z "$COUPLING"]; then
    echo "::set-output name=frecuencies::$FREQUENCIES"
    echo "::set-output name=coupling::$COUPLING"
else
    echo "::set-output name=frecuencies::error"
    echo "::set-output name=coupling::error"
fi
