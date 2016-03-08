#!/usr/bin/python


import argparse
import datetime
import math
import os
import subprocess
import sys

dir = '/home-2/jroskes1@jhu.edu/work/heshy/phantom/phantom_1_2_8_nc/phantom_templates'


def replaceParameterInFile (inputFile, outputFile, substitute): 
    f = open (inputFile)
    s = f.read ()
    f.close ()
    for k,v in substitute.items () :
        s = s.replace (k, v)
    f = open (outputFile, 'w')
    f.write (s)
    f.close ()


# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----


def execute (command, getoutput=False) :
    if getoutput:
        return subprocess.check_output(command, shell=True)
    else:
        return subprocess.check_call(command, shell=True)


# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----


if __name__ == '__main__':

    user = os.environ["USER"]
    parser = argparse.ArgumentParser (description = 'run phantom productions on lxplus')
    parser.add_argument('-q', '--queue'    , default= '1nw',    help='batch queue [1nw]')
    parser.add_argument('-m', '--mass'     , default= '126',    help='Higgs mass [126]')
    parser.add_argument('-w', '--width'    , default= 0.00421,  type = float, help='Higgs width []')
    parser.add_argument('-l', '--scaling'  , default= 1.,       type = float, help='squared coupling modifier [1]')
    parser.add_argument('-s', '--step'     , default= '1',      help='production step [1]')
    parser.add_argument('-t', '--template' , default= 'none',   help='input template file [none]')
    parser.add_argument('-f', '--folder'   , default= 'none',   help='local folder name [from the date]')
    parser.add_argument('-c', '--channel'  , default= 'none',   help='production channel (list of leptons)')
    parser.add_argument('-T', '--Top'      , default= 'none',   help='number of tops (no restriction)')
    parser.add_argument('-e', '--email'    , default= user,     help='email address to send to when jobs are done')
    
    args = parser.parse_args ()

#    if args.folder == 'none' and args.step == '2' or :
#        print 'file', args.template, 'not found'
#        print 'please provide an existing template file with relative path'
#        sys.exit (1) 

    if not args.step == '3':
        if args.template == 'none':
            print 'please provide the name of the template file with relative path'
            sys.exit (1) 
        elif not os.path.exists (args.template) :
            print 'file', args.template, 'not found'
            print 'please provide an existing template file with relative path'
            sys.exit (1) 


    substitute = {
        'HMASS_TEMP':  args.mass, 
        'HCOUP_TEMP':  str (math.sqrt(args.scaling)),
        'HWIDTH_TEMP': str (args.width * args.scaling * args.scaling)
        }

    args.folder = args.folder.rstrip("/")

    if args.step == '1' :
        # generate the grids
        # ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
        if args.folder == 'none' :
            args.folder = os.getcwd () + '/grid_' + datetime.datetime.now().strftime('%y-%m-%d-%H-%M')
        else :
            args.folder = os.getcwd () + '/grid_' + args.folder    
        if os.path.exists (args.folder) :
            print 'folder', args.folder, 'exists, quitting'
            sys.exit (1)
        if args.channel == 'none' :
            print 'production channel missing'
            sys.exit (1)
            
        getstatusoutput ('mkdir ' + args.folder)
        replaceParameterInFile (args.template, args.folder + '/r.in', substitute)
        
        command = './setupdir2.pl -b '+dir
        if (args.Top != 'none') : 
            command += ' -T ' + args.Top
        command += ' -d ' + args.folder
        command += ' -t ' + args.folder + '/r.in -m ' + args.email
        command += ' -i "' + args.channel + '" -q ' + str (8 - len (args.channel.split ()))
        command += ' -s SLURM -n ' + args.queue

        execute (command)
        execute ('source ' + args.folder + '/SLURMfile')
        execute ('squeue -u $USER -o "%.7i %.9P %.20j %.8u %.2t %.10M %.6D %R"')
    elif args.step == '2' :
        # generate the events
        # ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
        if args.folder == 'none' :
            print 'please provide a folder name (without the "gen_" prefix)'
            sys.exit (1)
        gridFolder = os.getcwd () + '/grid_' + args.folder    
        genFolder  = os.getcwd () + '/gen_'  + args.folder    
        if os.path.exists (genFolder) :
            print 'folder', genFolder, 'exists, quitting'
            sys.exit (1)
        if not os.path.exists (gridFolder) :
            print 'folder', gridFolder, 'does not exist, quitting'
            sys.exit (1)
        getstatusoutput ('mkdir ' + genFolder)
        replaceParameterInFile (args.template, genFolder + '/r.in', substitute)

        jobsrunning = execute ('squeue -u $USER -o "%.7i %.9P %.{}j %.8u %.2t %.10M %.6D %R"'.format(len(args.folder)+10), True).split("\n")
        waitjobs = []
        for job in jobsrunning:
            if job.split()[3] == 'gen_' + args.folder:
                waitjobs.append(job.split()[1])

        if waitjobs:
            dependency = "#SBATCH --dependency=afterok:" + ":".join(waitjobs)
        else:
            dependency = ""

        substitute_step2 = {
            'GRID_FOLDER_TEMP': gridFolder, 
            'GEN_FOLDER_TEMP' : genFolder,
            'QUEUE_TEMP'      : args.queue,
            'TEMPLATE_TEMP'   : genFolder + '/r.in',
            'EMAIL'           : args.email,
            'JOB_NAME'        : os.path.basename(genFolder),
            'DEPENDENCY'      : dependency,
            }

        replaceParameterInFile ('submit_step2.sh', 'gen_' + args.folder + '.sh', substitute_step2)
        execute ('source ./gen_' + args.folder + '.sh')
        os.remove('gen_' + args.folder + '.sh')
        execute ('squeue -u $USER -o "%.7i %.9P %.20j %.8u %.2t %.10M %.6D %R"')
    elif args.step == '3' :
        # generate the events
        # ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
        if args.folder == 'none' :
            print 'please provide a folder name (without the "gen_" prefix)'
            sys.exit (1)
        gridFolder = os.getcwd () + '/grid_' + args.folder    
        genFolder  = os.getcwd () + '/gen_'  + args.folder    
        if not os.path.exists (genFolder) :
            print 'folder', genFolder, 'does not exist, quitting'
            sys.exit (1)
        if not os.path.exists (gridFolder) :
            print 'folder', gridFolder, 'does not exist, quitting'
            sys.exit (1)
        command = 'cd ' + gridFolder + '; grep SIGMA */run.out > res ; '
        command += dir+'/tools/totint.exe > result '
        print command
        execute (command)
                
        command = 'cd ' + genFolder + '; grep -A 1 total\ integral gen*/run.o* > res ; '
        command += dir+'/gentotint.exe > result '
        print command
        execute (command)
        
        print '---> cross section from grids:'
        execute ('tail -n 1 ' + gridFolder + '/result')
        print '---> cross section from generation:'
        execute ('tail -n 1 ' + genFolder + '/result')



