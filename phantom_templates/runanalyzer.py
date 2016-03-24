import contextlib
import os

@contextlib.contextmanager
def cd(path):
   """http://stackoverflow.com/questions/24469538/sh-cd-using-context-manager"""
   old_path = os.getcwd()
   os.chdir(path)
   try:
       yield
   finally:
       os.chdir(old_path)

template = """
#!/bin/bash
#SBATCH --job-name=JOBNAME
#SBATCH --time=3:0:0
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=shared
#SBATCH --mem=5000
#SBATCH --mail-type=end
#SBATCH --mail-user=heshyslurm@gmail.com

cd {CMSSW_BASE}
eval $(scram ru -sh)
cd {dir}
analyzer indir=$(pwd)/ phamom.lhe outdir=$(pwd)/ outfile=phamom.root computeVBFProdAngles=1 computeVHProdAngles=3
""".strip()

def runanalyzer(folder):
    with cd(folder):
        command = ""
        if not os.path.exists("phamom.root"):
            if not os.path.exists("phamom.lhe"):
                command += "cat */phamom.dat > phamom.lhe\n"
            themap = {
                      "CMSSW_BASE": os.environ["CMSSW_BASE"],
                      "dir": os.getcwd(),
                     }
            command += template.format(**themap)
            with open("slurm.sh", "w") as f:
                f.write(command)
            os.system("sbatch slurm.sh")

if __name__ == "__main__":
    for a in os.listdir("."):
        if a.startswith("gen_") and os.path.isdir(a):
            runanalyzer(a)
