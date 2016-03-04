#!/usr/bin/python


import sys
from commands import getstatusoutput
import datetime


# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----


if __name__ == '__main__':

    if len (sys.argv) < 2 : 
        print 'provide the cfg file to be parsed\n'
        exit (1)
        
    file = open (sys.argv[1], 'r')

# voglio un contenitore che per ogni taglio abbia: name, flag, value

    tooEarly = 1
    selections = {}
    for line in file.readlines () :
        if tooEarly == 1 and 'READ INPUT FOR CUTS' not in line : continue
        tooEarly = 0
        if len (line.split ()) == 0 : continue
        if 'IF' in line : continue
        if '!' in line : continue
        if '*' in line.split ()[0] : continue
#        print 'LINEA:\t', line.replace ('\n', '')
        # leggi il primo elemento della linea
        firstWord = line.split ()[0]
        if firstWord.split ('_')[0] == 'i' : 
#            print 'FOUND --> ', firstWord.replace ('i_', ''), line.split ()[1]
            selections[firstWord.replace ('i_', '')] = [line.split ()[1], -1]
        elif firstWord in selections :
            if len (line.split ()) > 1 :
                selections[firstWord][1] = line.split ()[1]
        else :
            print 'WARNING on cut flag found for', firstWord
        
    file.close ()
    
    for name, elem in selections.items () :
        if elem[0] == '0' : continue
        if len (name) < 15 : print name, '\t\t=', elem[1]
        else               : print name, '\t=', elem[1]
    
