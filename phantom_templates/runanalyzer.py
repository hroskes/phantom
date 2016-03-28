import contextlib
import os
import re

@contextlib.contextmanager
def cd(path):
   """http://stackoverflow.com/questions/24469538/sh-cd-using-context-manager"""
   old_path = os.getcwd()
   os.chdir(path)
   try:
       yield
   finally:
       os.chdir(old_path)

template_fixcolors = """
#!/bin/bash
#SBATCH --job-name={jobname}
#SBATCH --time=0:5:0
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=shared
#SBATCH --mem=5000
#SBATCH --mail-type=end
#SBATCH --mail-user=heshyslurm@gmail.com

cd {CMSSW_BASE}
eval $(scram ru -sh)
cd {dir}
ln -s phamom.dat phamom.lhe
/scratch/groups/lhc/heshy/phantom/checklhe/checklhe.py phamom.lhe
""".strip()

template_analyzer = """
#!/bin/bash
#SBATCH --job-name={jobname}
#SBATCH --time=24:0:0
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=shared
#SBATCH --mem=5000
#SBATCH --mail-type=end
#SBATCH --mail-user=heshyslurm@gmail.com

cd {CMSSW_BASE}
eval $(scram ru -sh)
cd {dir}
for a in gen*/; do
    ln -s $a/phamom.dat phamom_$(echo $a | sed "s|[gen/]||g").lhe
done
analyzer indir=$(pwd)/ phamom_*.lhe outdir=$(pwd)/ outfile=phamom.root computeVBFProdAngles=1 computeVHProdAngles=3
""".strip()

def runanalyzer(folder):
    with cd(folder):
        command = ""
        if "forCMS" in folder:
            for dir in os.listdir("."):
                if not (os.path.isdir(dir) and re.match("gen[0-9]*", dir)):
                    continue
                themap = {
                          "CMSSW_BASE": os.environ["CMSSW_BASE"],
                          "dir": os.path.join(os.getcwd(), dir),
                          "jobname": os.path.join(folder, dir),
                         }
                command = template_fixcolors.format(**themap)
                with open("slurm.sh", "w") as f:
                    f.write(command)
                os.system("sbatch slurm.sh")
        else:
            themap = {
                      "CMSSW_BASE": os.environ["CMSSW_BASE"],
                      "dir": os.getcwd(),
                      "jobname": folder,
                     }
            command = template_analyzer.format(**themap)
            with open("slurm.sh", "w") as f:
                f.write(command)
            os.system("sbatch slurm.sh")

if __name__ == "__main__":
    for a in os.listdir("."):
        if a.startswith("gen_") and os.path.isdir(a):
            runanalyzer(a)
