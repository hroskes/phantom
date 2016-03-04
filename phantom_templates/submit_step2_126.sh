#!/bin/bash

cd GRID_FOLDER_TEMP ; 
for fil in `find -L . -name "phavegas*"`  ; do echo `pwd`/$fil ; done > GEN_FOLDER_TEMP/phav.dat ; 
cd .. ; 

cd GEN_FOLDER_TEMP ; 
cp ../phantom_1_2_6/tools/gendir.scr ./
mkdir gen1
cat TEMPLATE_TEMP >gen1/r.in ; 
echo "nfiles " `wc -l phav.dat` >> gen1/r.in ; 
cat phav.dat >> gen1/r.in ; 
echo ; 
echo "****** ENDIF" >> gen1/r.in ; 
cat /afs/cern.ch/user/g/govoni/work/PHANTOM/phantom_at_cern/phantom_templates/run_1_2_6.TEMPLATE  | sed -e s%FOLDER%GEN_FOLDER_TEMP/gen1% > GEN_FOLDER_TEMP/gen1/run ;
./gendir.scr -l CERN -q QUEUE_TEMP -d 100 -i  `pwd` ; 
./submitfile
