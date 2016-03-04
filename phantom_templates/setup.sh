source /afs/cern.ch/sw/IntelSoftware/linux/setup.sh intel64
source /afs/cern.ch/sw/IntelSoftware/linux/x86_64/Compiler/11.0/083/bin/ifortvars.sh intel64
export LHAPDF=/afs/cern.ch/user/g/govoni/work/HiggsPlusJets/lhapdf/share/lhapdf/PDFsets
export LD_LIBRARY_PATH=/afs/cern.ch/user/g/govoni/work/HiggsPlusJets/lhapdf/lib/:$LD_LIBRARY_PATH
export PDFLIBDIR=/afs/cern.ch/user/g/govoni/work/HiggsPlusJets/lhapdf/lib/

# these would be necessary to use the pdf libraries prepared by Sandro
#export LHAPDF=/afs/cern.ch/user/b/ballest/phantom/lhapdf-5.8.9_work/share/lhapdf/PDFsets
#export PDFLIBDIR=/afs/cern.ch/user/b/ballest/phantom/lhapdf-5.8.9_work/lib/
#export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/afs/cern.ch/user/b/ballest/phantom/lhapdf-5.8.9_work/lib/

