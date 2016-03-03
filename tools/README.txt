This version  PHANTOM_1_2_8_nc 

   is the same as  PHANTOM_1_2_8  but it is compiled with the 
   latest ifort compiler corresponding to:
    /afs/.cern.ch/sw/IntelSoftware/linux/x86_64/xe2016/compilers_and_libraries_2016.1.150/linux/bin/intel64/ifort

   In order to use this compiler one should use the command
 
 source /afs/cern.ch/sw/IntelSoftware/linux/x86_64/xe2016/compilers_and
_libraries/linux/bin/compilervars.csh intel64

 instead of the previous

source /afs/cern.ch/sw/IntelSoftware/linux/x86_64/Compiler/11.0/083/bin/ifortvars.csh intel64

(If you use a bash shell instead of cshell, replace in the above commands
    .csh --> .sh)

From now on all version will be compiled with the new compiler.



********* PREVIOUS VERSIONS:


IN this version PHANTOM_1_2_8 

  - a bug has been corrected which prevented the cut to suppress top 
    contributions to be effective even when set. 
    This cut has been introduced in version 1_2_7 As a consequence of the bug,
    the generations eventually produced using that version with i_deltacuttop=1
    were produced as if i_deltacuttop were 0 (not set)

  - the mass of the b quark has been set to 4.75 GeV. It was previously set 
    to zero following what was suggested in old Pythia versions.  

  - the mothers corresponding to the Higgs particles are now properly written 
    in LHE files

  - the number of significant digit of the momenta in the events of LHE files
    has been extended to 14 



In  PHANTOM_1_2_7 the main new feature is the implementation of the
  Higgs singlet model computation (see e.g. Pruna Roberts arXiv:1303.1150)
 
  One can choose to use this implementation setting to 1 the flag i_singlet: 

  i_singlet  1

  After this choice one has to fix the mass rmhh of the heavier higgs
  and the parameters of the model cos alfa (flag rcosa) and tg beta (flag tgbeta)

  Moreover one has to fix the width gamhh of the heavier higgs. If this flag is
  negative, the corresponding width is computed by Phantom  multiplying
  the width of the lightest higgs by (1-rcosa**2) and adding the width of the 
  decay of the heavy higgs to 2 light ones: hh-> h+h 

  In this version, as a study case there is also the possibility of having a 
  second higgs in which the couplings are just the ones of the lightest higgs
  multiplied by ghhfactor.

  A new cut has also been introduced in order to eventually suppress in the 
  generation the top contribution.
  This cut is chosen if i_deltacuttop  is set to 1 and in this case all 
  invariant masses of the triplets of outgoing particles who could form a 
  top are excluded in the interval topmas +- deltacuttop . 
   Deltacuttop has to be fixed by the user if i_deltacuttop=1.
  

***

In  PHANTOM_1_2_6 version the computation of the Higgs Signal contribution,
  introduced in 1_2_4, has been extended to compute not only the diagrams which
  have an s channel Higgs propagator given by boson boson fusion, but also
  t and u channel contributions on request and eventually also  
  Higgstrahlung ones.
  The flag i_signal to be set in r.in can now assume 4 different values: 
   
    i_signal= 0 full computation 
    i_signal> 0 Higgs signal only 
                  (only for i_pertorder = 1 alpha_em^6 and i_unitarize = 0)
    i_signal= 1 s channel contributions to boson boson scattering 
                  (boson boson-> Higgs -> boson boson)
    i_signal= 2 all contributions (s+t+u channels) to boson boson scattering 
    i_signal= 3 all contributions (s+t+u channels)to boson boson scattering 
                    and Higgstrahlung with H -> boson boson

  When one chooses i_signal=1 or 2 not all processes contain the corresponding
   contributions. For this reason one must:
         for grid computation with i_signal=1 use setupdir2.pl with -Hs flag
         for grid computation with i_signal=2 use setupdir2.pl with -S flag
         for grid computation with i_signal=3 use setupdir2.pl as for i_signal=0
                                    (no -Hs or -S flag)

  Another new feature of version PHANTOM_1_2_6 is the introduction in r.in of
  two new cuts:  	
   i_rm_min_4l     corresponds to yes/no minimum invariant mass of 4 leptons 
                   for processes with 4l and the corresponding value of the cut
                   is set by rm_min_4l 
   i_rm_min_2l2cq  corresponds to yes/no minimum invariant mass of 2 leptons 
                   and 2 central quark for processes with 2l and the 
                   corresponding value of the cut is set by rm_min_2l2cq 

***

In  PHANTOM 1_2_5 version the only difference with 1_2_4
  is that one can use the value 4 for the flag i_PDFscale   
  not only for processes with four leptons in the final state but 
  also for processes with two leptons. In this case, as indicated in the 
  present r.in file, the scale corresponds  to the invariant mass of the two 
  leptons and of the two central jets, divided by sqrt(2). 


*** 

PHANTOM version 1_2_4 can be used also for computing only the Higgs Signal
contribution. By Higgs Signal we intend in this context the contributions of 
the diagrams which have an s channel Higgs propagator given by boson boson 
fusion.

To use this version one must use the r.in given here, which contains the choice
of the parameter i_signal. 
It is also recommended to use the new version of setupdir  : setupdir2.pl given 
here. This provides a new flag -Hs that must be set if one wants to produce and 
generate only processes containing the signal diagrams.  This flag MUST be set
if one wants the Higgs Signal. (i_signal 1) 
As usual setupdir2.pl -h  gives information on all the flags.

****

 phantom_1_2_3  differs from 1_2_2  for the possibility 
  of varying the higgs couplings by a factor ghfactor fixed in r.in.
  The corresponding higgs width, if computed by phantom and not fixed by the 
  user, is multiplied by ghfactor**2.
  The possibility of varying the couplings is only restricted to the alpha_ew^6
  computations (i_pertorder = 1)

****

 phantom_1_2_2 differs from 1_2_1 only for the additional
  possibility  of fixing a fixed PDF scale with any numerical value given by 
  the user, and of choosing a new dynamical PDF scale which corresponds to 
  the invariant mass of the four leptons divided by sqrt(2) (to be used only 
  for final states which contains four leptons).   

****

 phantom_1_2_1  which differs from version phantom_1_2 
   only for an additional cut on leptons deltaR which can be set by the user


