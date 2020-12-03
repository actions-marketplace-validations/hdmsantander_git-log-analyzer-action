# Gitlog Analyzer
Executes an analysis of a git log file to determine coupling and commit frequencies, defaults to last month of commits.

## Inputs

### init date

Starting date to analyze git log from, format is: yyyy-mm-dd.

### min cochanges

Minimum number of cochanges to report in coupling analysis. Defaults to zero.

## Outputs

### `frecuencies`

A CSV of the frecuencies of commmits over the files in the project

###  `coupling`

A CSV of the coupling analysis over the supplied min cochanges threshold. 

## Example usage

_.github/workflows/main.yml_

```
on: [push]

jobs:
  gitlog_job:
    runs-on: ubuntu-latest
    name: Gitlog analysis.
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Execute gitlog analysis.
        id: gitlog
        uses: hdmsantander/git-log-analyzer-action@v1.0
        with:
          min cochanges: 10
```
