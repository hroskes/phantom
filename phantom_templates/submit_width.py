#!/usr/bin/env python


import argparse
import datetime
import math
import os
import subprocess
import sys

dir = '/home-2/jroskes1@jhu.edu/work/heshy/phantom/phantom_1_2_8_nc/phantom_templates'


def replaceParameterInFile (inputFile, outputFile, substitute, append=None, mandatory=None):
    with open(inputFile) as f:
        s = f.read()
    if mandatory is not None:
        for m, error in mandatory.iteritems():
            if m in s and (m not in substitute or substitute[m] is None):
                raise error
    for k,v in substitute.iteritems():
        s = s.replace(k, str(v))
    if append is not None:
        s += append + "\n"
    with open(outputFile, 'w') as f:
        f.write(s)


# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----


def execute (command, getoutput=False) :
    if getoutput:
        return subprocess.check_output(command, shell=True).rstrip("\n")
    else:
        return subprocess.check_call(command, shell=True)


# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----


def getparameter(template, parametername, substitute=None):
    result = None
    with open(template) as f:
        for line in f:
            data = line.split()
            if len(data) == 2 and data[0] == parametername:
                if result is not None:
                    raise IOError(parametername + " appears twice in the template!")
                result = data[1]

    if result is None:
        raise IOError(parametername + " doesn't appear in the template!")

    if substitute is not None:
        for k,v in substitute.iteritems():
            result = result.replace(k, str(v))

    return result




if __name__ == '__main__':

    user = os.environ["USER"]
    parser = argparse.ArgumentParser (description = 'run phantom productions on lxplus')
    parser.add_argument('-q', '--queue',     default= '1nw',                   help='batch queue [1nw]')
    parser.add_argument('-m', '--mass',                          type = float, help='Higgs mass')
    parser.add_argument('-w', '--width',                         type = float, help='Higgs width')
    parser.add_argument('-l', '--scaling',   default = 1.,       type = float, help='squared coupling modifier [1]')
    parser.add_argument('-M', '--Xmass',                         type = float, help='Second resonance mass')
    parser.add_argument('-W', '--Xwidth',                        type = float, help='Second resonance width')
    parser.add_argument('-L', '--Xscaling',   default = 1.,      type = float, help='squared coupling modifier [1]')
    parser.add_argument('-s', '--step',                          type = int,   help='production step [1]')
    parser.add_argument('-t', '--template',                                    help='input template file [none]')
    parser.add_argument('-f', '--folder',                                      help='local folder name [from the date]')
    parser.add_argument('-c', '--channel',                                     help='production channel (list of leptons)')
    parser.add_argument('-T', '--Top',                                         help='number of tops (no restriction)')
    parser.add_argument('-e', '--email',     default = user,                   help='email address to send to when jobs are done')

    if "CMSSW_BASE" not in os.environ:
        raise RuntimeError("Need to cmsenv!")

    args = parser.parse_args ()

    if args.step != 3:
        if args.template is None:
            print 'please provide the name of the template file with relative path'
            sys.exit (1)
        elif not os.path.exists (args.template) :
            print 'file', args.template, 'not found'
            print 'please provide an existing template file with relative path'
            sys.exit (1)

    substitute = {
                  'HMASS_TEMP':  args.mass,
                  'HCOUP_TEMP':  math.sqrt(args.scaling),
                  'HWIDTH_TEMP': args.width * args.scaling * args.scaling if args.width is not None else None,
                  'XMASS_TEMP':  args.Xmass,
                  'XCOUP_TEMP':  math.sqrt(args.Xscaling),
                  'XWIDTH_TEMP': args.Xwidth * args.Xscaling * args.Xscaling if args.Xwidth is not None else None,
                 }
    mandatory = {
                 'HMASS_TEMP': IOError("Please provide the higgs mass (-m mass)"),
                 'HWIDTH_TEMP': IOError("Please provide the higgs width (-w width)"),
                 'XMASS_TEMP': IOError("Please provide the second resonance mass (-M mass)"),
                 'XWIDTH_TEMP': IOError("Please provide the second resonance width (-W width)"),
                 'IONESH_TEMP': RuntimeError("Something is wrong!"),
                }

    args.folder = args.folder.rstrip("/")

    if args.step == 1 or args.step is None:
        # generate the grids
        # ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
        substitute['IONESH_TEMP'] = 0
        if args.folder is None :
            gridFolder = os.getcwd () + '/grid_' + datetime.datetime.now().strftime('%y-%m-%d-%H-%M')
        else :
            gridFolder = os.getcwd () + '/grid_' + args.folder
        if os.path.exists (gridFolder) :
            print 'folder', gridFolder, 'exists, quitting'
            sys.exit (1)
        if args.channel is None :
            print 'production channel missing'
            sys.exit (1)

        execute('mkdir ' + gridFolder)
        replaceParameterInFile (args.template, gridFolder + '/r.in', substitute, append="****** ENDIF", mandatory=mandatory)

        command = './setupdir2.pl -b '+dir
        if args.Top is not None:
            command += ' -T ' + args.Top
        i_signal = int(getparameter(args.template, "i_signal"))
        if i_signal == 1: command += " -Hs"
        if i_signal == 2: command += " -S"
        command += ' -d ' + gridFolder
        command += ' -t ' + gridFolder + '/r.in -m ' + args.email
        command += ' -i "' + args.channel + '" -q ' + str (8 - len (args.channel.split ()))
        command += ' -s SLURM -n ' + args.queue

        execute (command)
        execute ('source ' + gridFolder + '/SLURMfile')
        #execute ('squeue -u $USER -o "%.7i %.9P %.20j %.8u %.2t %.10M %.6D %R"')
    if args.step == 2 or args.step is None:
        # generate the events
        # ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
        substitute['IONESH_TEMP'] = 1
        if args.folder is None :
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
        execute ('mkdir ' + genFolder)
        replaceParameterInFile (args.template, genFolder + '/r.in', substitute, mandatory=mandatory)

        jobsrunning = execute ('squeue -u $USER -o "%.7i %.9P %.{}j %.8u %.2t %.10M %.6D %R"'.format(len(args.folder)+10), True).split("\n")
        waitjobs = []
        for job in jobsrunning:
            if not job: continue
            if job.split()[2] == 'grid_' + args.folder:
                waitjobs.append(job.split()[0])
            if job.split()[2] == 'gen_' + args.folder:
                raise RuntimeError("Job is already running:\n" + job)

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
            'DEPENDENCY_TEMP' : dependency,
            'CMSSW_BASE_TEMP' : os.environ["CMSSW_BASE"],
            }

        replaceParameterInFile ('submit_step2.sh', 'gen_' + args.folder + '.sh', substitute_step2)
        execute ('sbatch ./gen_' + args.folder + '.sh')
        os.remove('gen_' + args.folder + '.sh')
        #execute ('squeue -u $USER -o "%.7i %.9P %.20j %.8u %.2t %.10M %.6D %R"')
    if args.step == 3:
        # generate the events
        # ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
        if args.folder is None :
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
        execute (command)

        command = 'cd ' + genFolder + '; grep -A 1 total\ integral gen*/run.o* > res ; '
        command += dir+'/gentotint.exe > result '
        execute (command)

        gridresult = execute ('tail -n 1 ' + gridFolder + '/result', True)
        genresult = execute ('tail -n 1 ' + genFolder + '/result', True)

        print '---> cross section from grids:'
        print gridresult
        print '---> cross section from generation:'
        print genresult

        gridxsec = float(gridresult.split("=")[1].split("+/-")[0])
        griderr  = float(gridresult.split("=")[1].split("+/-")[1])
        genxsec  = float( genresult.split("=")[1].split("+/-")[0])
        generr   = float( genresult.split("=")[1].split("+/-")[1])

        overallxsec = (gridxsec / griderr**2 + genxsec / generr**2) / (1/griderr**2 + 1/generr**2)
        overallerr = 1/(1/griderr**2 + 1/generr**2) ** .5
        overallresult =  "total cross section= {:>25} +/- {:>25}".format(overallxsec, overallerr)

        print "---> combined cross section:"
        print overallresult

        print "---> difference between gen and grid:"
        print "{} = {}*error = {}%".format(genxsec-gridxsec, (genxsec-gridxsec)/(griderr**2 + generr**2)**.5, (genxsec-gridxsec) / overallxsec * 100)
