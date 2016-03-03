#  $*  is name of the target with the suffix deleted
#  $@  is name of the target


#PDFLIBDIR = /usr/local/lib
#PDFLIBDIR = /wrk04/ballestr/phantom/lhapdf-5.2.2/src/.libs
#PDFLIBDIR = /home/phantom/phantom/lhapdf-5.2.2_intel_8/lib
#PDFLIBDIR = /home/phantom/phantom/lhapdf-5.2.2_intel_10/lib
#PDFLIBDIR = /home/phantom/phantom/lhapdf-5.8.8_work/lib
#PDFLIBDIR = /home/phantom/phantom/lhapdf-5.8.9/lhapdf/lib
PDFLIBDIR = ${LHAPDF_DATA_PATH}/../../lib/

#The following  definitions are to be used for compilation on alpha
#  They must be commented for other compilers

#F77 =  f77
#FLAG = -c -g -O4 -check bounds
##FLAG = -c -g  -check bounds
#FLAG4z = -c -g  -check bounds -O1
#FLAGggzww = -c -g  -check bounds -O1
#FLAGgg3z = -c -g  -check bounds -O1
#FLAG4zqcd = -c -g  -check bounds -O1
#LDFLAG = -L$(PDFLIBDIR) -lLHAPDF


#The following  definitions are to be used for compilation on
# linux pgf77 (Portland Group)
#  They must be commented for other compilers.

# F77 = pgf77
# FLAG = -c -Ktrap=fp -Msave  -Kieee -pc 64 -O2
# FLAG4z = -c -Ktrap=fp -Msave  -Kieee -pc 64 -O2
# FLAGggzww = -c -Ktrap=fp -Msave  -Kieee -pc 64 -O2
# FLAGgg3z = -c -Ktrap=fp -Msave  -Kieee -pc 64 -O1
# FLAG4zqcd = -c -Ktrap=fp -Msave  -Kieee -pc 64 -O1
# #LDFLAG = -Wl,-noinhibit-exec -g77libs \
# #        -L $(PDFLIBDIR) -lLHAPDF
# # the following LDFLAG has to be used for compilation with static libraries,
# #   such that phantom.exe can be used on machines without pgf77 compiler
# LDFLAG = -Wl,-noinhibit-exec -g77libs -Bstatic \
#         -L$(PDFLIBDIR) -lLHAPDF

#The following  definitions are to be used for compilation on
# a recent version Intel compiler.
#  They must be commented for other compilers.

F77 = ifort
FLAG = -c -save -traceback
#FLAG4z = -c -save -O1  -traceback
#FLAGggzww = -c -save -O1 -traceback
#FLAGgg3z = -c -save -O1 -traceback
#FLAG4zqcd = -c -save -O1 -traceback
LDFLAG =   -L$(PDFLIBDIR) -lLHAPDF

#The following definitions are to be used for an older version of Intel
# compiler or if the previous for Intel does not work.
#  They must be commented for other compilers.
#
#F77 = ifort
#FLAG = -c -save  -traceback
#FLAG4z = -c -save   -traceback
#FLAGggzww = -c -save  -traceback
#FLAGgg3z = -c -save -O1 -traceback
#FLAG4zqcd = -c -save -O1  -traceback
#LDFLAG =   -L$(PDFLIBDIR) -lLHAPDF
#LDFLAG = -static  -L$(PDFLIBDIR) -lLHAPDF
#LDFLAG = -Bstatic -static-intel  -L$(PDFLIBDIR) -lLHAPDF


#LDFLAG =
#.f.o: ; $(F77) $(FLAG)  $*.f

OBJS =  phantom.o phavegas.o oneshot.o phread.o util.o \
	phsp_7.o  phsp_ini7.o \
	phsp1_1_4_multi7_c.o  phsp1_1_4_multi7_cjac.o \
	phsp2_4_multi7.o phsp2_4_multi7jac.o \
	phsp1_1_31_multi_c.o phsp1_1_31_multi_cjac.o \
	phsp1_2_3_multi5_c.o phsp1_2_3_multi5_cjac.o\
	phsp3_3_multi5.o phsp3_3_multi5jac.o \
	phsp1_5to1_4to31_multi_c.o phsp1_5to1_4to31_multi_cjac.o \
	phsp2_4to31_multi5.o phsp2_4to31_multi5jac.o \
	coupling.o bernoul.o readinput.o\
	procini.o procextraini.o proc.o \
	integ.o fxn.o extrema.o cuts.o \
	ccfcsym.o perm.o coleval.o colevalew.o isign.o LHAFileInit.o\
	fourw.o twoztwow.o fourz.o \
	fourwqcd.o twoztwowqcd.o amp8fqcd.o\
	perm2g.o amp2g.o ampem.o ggzww.o isr.o \
	pythia_interface.o pythia6225.o \
        circe.o storeLH.o \
	fourz_massless.o twoztwow_massless.o \
	fourzqcd_massless.o twoztwowqcd_massless.o \
	gg3z_massless.o ggzww_massless.o \
        unit_amp.o unit.o


OBJS1 =  fourzqcd.o gg3z.o

# This pseudo target prevents from stopping for some error code different
#   from 0 . In particular here I am not linking circe and it would stop
#   before executing the last target wphact:

.IGNORE:

#
### this target is there just to make wphact.exe executable
#

phantom: phantom.exe
	chmod +x phantom.exe

#
### the main command for the makefile
#

phantom.exe : $(OBJS) $(OBJS1)
	$(F77) -o $@ $(LDFLAG) $(OBJS) $(OBJS1) $(LIB) $(LDFLAG)

extrema.o  :  extrema.f common.h common_subproc.h common_cut.h
	$(F77)  $(FLAG)  $*.f
fxn.o :  fxn.f common.h common_subproc.h common_cut.h
	$(F77)  $(FLAG)  $*.f
readinput.o :  readinput.f common.h common_subproc.h common_cut.h
	$(F77)  $(FLAG)  $*.f

cuts.o :  cuts.f common.h  common_subproc.h
	$(F77)  $(FLAG)  $*.f
integ.o  :  integ.f  common.h  common_subproc.h
	$(F77)  $(FLAG)  $*.f
oneshot.o  :  oneshot.f  common.h  common_subproc.h
	$(F77)  $(FLAG)  $*.f
procextraini.o  :  procextraini.f  common.h  common_subproc.h
	$(F77)  $(FLAG)  $*.f
proc.o   :  proc.f  common.h  common_subproc.h
	$(F77)  $(FLAG)  $*.f
procini.o   :  procini.f  common.h  common_subproc.h
	$(F77)  $(FLAG)  $*.f
pythia_interface.o  :  pythia_interface.f common.h
	$(F77)  $(FLAG)  $*.f
pythia6225.o  :  pythia6225.f
	$(F77)  $(FLAG)  $*.f
phantom.o  :  phantom.f common.h
	$(F77)  $(FLAG)  $*.f
coupling.o  :  coupling.f common.h
	$(F77)  $(FLAG)  $*.f
LHAFileInit.o  :  LHAFileInit.f common.h
	$(F77)  $(FLAG)  $*.f
fourw.o  :  fourw.f common.h
	$(F77)  $(FLAG)  $*.f
twoztwow.o  :  twoztwow.f common.h
	$(F77)  $(FLAG)  $*.f
fourwqcd.o  :  fourwqcd.f  common.h
	$(F77)  $(FLAG)  $*.f
twoztwowqcd.o  :  twoztwowqcd.f common.h
	$(F77)  $(FLAG)  $*.f
amp8fqcd.o :  amp8fqcd.f common.h
	$(F77)  $(FLAG)  $*.f
amp2g.o  :  amp2g.f common.h
	$(F77)  $(FLAG)  $*.f
phavegas.o :  phavegas.f
	$(F77)  $(FLAG)  $*.f
phread.o   :  phread.f
	$(F77)  $(FLAG)  $*.f
util.o     :  util.f
	$(F77)  $(FLAG)  $*.f
phsp1_1_4_multi7_c.o  :  phsp1_1_4_multi7_c.f
	$(F77)  $(FLAG)  $*.f
phsp1_1_4_multi7_cjac.o  :  phsp1_1_4_multi7_cjac.f
	$(F77)  $(FLAG)  $*.f
phsp2_4_multi7.o  :  phsp2_4_multi7.f
	$(F77)  $(FLAG)  $*.f
phsp2_4_multi7jac.o  :  phsp2_4_multi7jac.f
	$(F77)  $(FLAG)  $*.f
phsp1_1_31_multi_c.o  :  phsp1_1_31_multi_c.f
	$(F77)  $(FLAG)  $*.f
phsp1_1_31_multi_cjac.o  :  phsp1_1_31_multi_cjac.f
	$(F77)  $(FLAG)  $*.f
phsp1_2_3_multi5_c.o   :  phsp1_2_3_multi5_c.f
	$(F77)  $(FLAG)  $*.f
phsp1_2_3_multi5_cjac.o  :  phsp1_2_3_multi5_cjac.f
	$(F77)  $(FLAG)  $*.f
phsp3_3_multi5.o  :  phsp3_3_multi5.f
	$(F77)  $(FLAG)  $*.f
phsp3_3_multi5jac.o  :  phsp3_3_multi5jac.f
	$(F77)  $(FLAG)  $*.f
phsp1_5to1_4to31_multi_c.o  :  phsp1_5to1_4to31_multi_c.f
	$(F77)  $(FLAG)  $*.f
phsp1_5to1_4to31_multi_cjac.o  :  phsp1_5to1_4to31_multi_cjac.f
	$(F77)  $(FLAG)  $*.f
phsp2_4to31_multi5.o  :  phsp2_4to31_multi5.f
	$(F77)  $(FLAG)  $*.f
phsp2_4to31_multi5jac.o  :  phsp2_4to31_multi5jac.f
	$(F77)  $(FLAG)  $*.f
phsp_7.o  :  phsp_7.f
	$(F77)  $(FLAG)  $*.f
phsp_ini7.o  :  phsp_ini7.f
	$(F77)  $(FLAG)  $*.f
bernoul.o   :  bernoul.f
	$(F77)  $(FLAG)  $*.f
ccfcsym.o  :  ccfcsym.f
	$(F77)  $(FLAG)  $*.f
perm.o  :  perm.f
	$(F77)  $(FLAG)  $*.f
coleval.o  :  coleval.f
	$(F77)  $(FLAG)  $*.f
colevalew.o  :  colevalew.f
	$(F77)  $(FLAG)  $*.f
isign.o  :  isign.f
	$(F77)  $(FLAG)  $*.f
perm2g.o  :  perm2g.f
	$(F77)  $(FLAG)  $*.f
ampem.o  :  ampem.f common.h common_unitarization.h
	$(F77)  $(FLAG)  $*.f
isr.o  :  isr.f
	$(F77)  $(FLAG)  $*.f
circe.o :  circe.f
	$(F77)  $(FLAG)  $*.f
storeLH.o :  storeLH.f common.h common_subproc.h
	$(F77)  $(FLAG)  $*.f

fourz_massless.o  :  fourz_massless.f common.h
	$(F77)  $(FLAG)  $*.f
twoztwow_massless.o  :  twoztwow_massless.f common.h
	$(F77)  $(FLAG)  $*.f
fourzqcd_massless.o  :  fourzqcd_massless.f common.h
	$(F77)  $(FLAG)  $*.f
twoztwowqcd_massless.o  :  twoztwowqcd_massless.f common.h
	$(F77)  $(FLAG)  $*.f
gg3z_massless.o  :  gg3z_massless.f common.h
	$(F77)  $(FLAG)  $*.f
ggzww_massless.o  :  ggzww_massless.f common.h
	$(F77)  $(FLAG)  $*.f


fourz.o  :  fourz.f common.h
	$(F77)  $(FLAG)  $*.f
ggzww.o   :  ggzww.f  common.h
	$(F77)  $(FLAG)  $*.f
gg3z.o  : gg3z.f  common.h phact_data_types.inc
	$(F77)  $(FLAG)  $*.f
fourzqcd.o : fourzqcd.f  common.h
	$(F77)  $(FLAG)  $*.f

unit_amp.o : unit_amp.f  common.h common_unitarization.h
	$(F77)  $(FLAG)  $*.f
unit.o : unit.f  common.h common_unitarization.h
	$(F77)  $(FLAG)  $*.f



clean:
	$(RM) -f $(OBJS) phantom.exe


