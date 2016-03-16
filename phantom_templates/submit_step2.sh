#!/bin/bash
#SBATCH --job-name=JOB_NAME
#SBATCH --time=0:2:0
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=shared
#SBATCH --mem=300
DEPENDENCY_TEMP

cd GRID_FOLDER_TEMP ; 
for fil in `find . -name "phavegas*"`  ; do echo `pwd`/$fil ; done > GEN_FOLDER_TEMP/phav.dat ; 
cd .. ; 

cd GEN_FOLDER_TEMP ; 
echo '*' > .gitignore
ln -s ../gendir.scr ../run.TEMPLATE .
mkdir gen1
cat TEMPLATE_TEMP >gen1/r.in ; 
echo "nfiles " `wc -l phav.dat` >> gen1/r.in ; 
cat phav.dat >> gen1/r.in ; 
echo ; 
echo "****** ENDIF" >> gen1/r.in ; 
cat run.TEMPLATE  | sed -e s%FOLDER%GEN_FOLDER_TEMP/gen1%g -e s%PHANTOMDIR%`pwd`/..%g -e s%MAILADDRESS%EMAIL%g -e s%JOBNAME%JOB_NAME%g -e s%CMSSW_BASE%CMSSW_BASE_TEMP%g > GEN_FOLDER_TEMP/gen1/run ;
./gendir.scr -l MARCC -q QUEUE_TEMP -d 100 -i  `pwd` ; 
./submitfile
