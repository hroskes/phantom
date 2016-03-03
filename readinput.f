c
c Last update: July 30, 2014
c
************************************************************************
*                        SUBROUTINE READINPUT                          *
*                                                                      *
*                                                                      *
*     Purpose:  reading input_file                                     *
*     Call to subroutines in wread.f                                   *
*                                                                      *
************************************************************************

      SUBROUTINE readinput

      IMPLICIT REAL*8 (a-b,d-h,o-z)
      IMPLICIT DOUBLE COMPLEX (c)

      INCLUDE 'common.h'
      INCLUDE 'common_cut.h'
      INCLUDE 'common_subproc.h'
      INCLUDE 'common_unitarization.h'

*     INTEGRATION COMMONS
c giuseppe 21/05/2007
      DIMENSION ncall_therm(2)
c end giuseppe 21/05/2007
      COMMON/iinteg_readinput/ncall_therm,itmx_therm,ncall,itmx
      COMMON/rinteg_readinput/acc_therm,acc
c giuseppe 07/02/2007
      COMMON/ifxn_readinput/i_PDFscale
c end giuseppe 07/02/2007
c s14
* heavh
*      COMMON/coupling_readinput/ghfactor
      COMMON/coupling_readinput/ghfactor,ghhfactor,rcosa,tgbeta
      COMMON/int_coupling_readinput/i_singlet,i_hh
*hevhend
c s14end
c scale choice
      COMMON/rfxn_readinput/fixed_PDFscale
c end scale choice 
      COMMON/phaones/ionesh

      COMMON /pharand/ idum
*PDF's
      CHARACTER*200 PDFname
      COMMON/phpdfli/ PDFname


      CALL iread('idum',idum,1) ! idum=initialization random number seed
                                !  must be a large negative number

      CALL cread('PDFname',PDFname)

c giuseppe 06/02/2007
      CALL iread('i_PDFscale',i_PDFscale,1) ! selects the way of 
                                            ! calculating the PDF scale:
                                            ! =1 for all processes, 
                                            !     based on pT's of ALL
                                            !     OUTGOING PARTICLES
                                            ! =2 process by process,
                                            !     based on pT of the
                                            !     (RECONSTRUCTED) TOP
                                            !     if possible, otherwise
                                            !     as done in option 1
c end giuseppe 06/02/2007
c scale choice
                                            ! =3 Q a fixed numerical scale 
                                            !      given in r.in
                                            ! =4 Q= m4l/sqrt(2)(invariant mass 
                                            !         of the 4 leptons)/sqrt(2) 
                                            !  (valid only for prosesses with 
                                            !       four outgoing leptons)

      if (i_PDFscale.eq.3) then
        CALL rread('fixed_PDFscale',fixed_PDFscale,1)
      endif
c end scale choice 


c giuseppe ILC 25/06/2007
      CALL iread('i_coll',i_coll,1) ! determines the type of accelerator
                                    !  i_coll=1 => p-p  
                                    !  i_coll=2 => p-pbar
                                    !  i_coll=3 => e+e- 
      IF(i_coll.EQ.3)THEN
        CALL iread('i_isr',i_isr,1) ! yes/no initial state radiation
                                    ! (ISR) for e+e- collider only
        CALL iread('i_beamstrahlung',i_beamstrahlung,1) 
                                    ! yes/no beamstrahlung 
                                    ! for e+e- collider only
      ENDIF                     ! IF(i_coll.EQ.3)THEN
c end giuseppe ILC 25/06/2007

      CALL iread('perturbativeorder',i_pertorder,1 ) 
              !i_pertorder = 1 alpha_em^6 with dedicated amp
              !           = 2 alpha_s^2alpha_em^4
              !           = 3 alpha_em^6 + alpha_s^2alpha_em^4
              !           = 0 alpha_em^6 with amp8fqcd (for test only)
 

*sandro2/3/07end

*diogo29/3/09
      CALL iread('i_massive',i_massive,1 ) 
              !i_massive = 0 use massless amp unless there is at least a b quark
              !          = 1 always use massive amplitudes (massive Z-lines)
*diogoend

*diogo24/4/10 Unitarization

C     iunittype= 0 no unitarization
C            1 kmatrix
C            2 pade
C            3 nd
C            4 largen     
      CALL iread('i_unitarize',i_unitarize,1)
            !i_unitarize = 0   no changes in amplitudes
	    !            = 1   use unitarization routines
      if (i_unitarize.eq.1) then
        CALL iread('iunittype',iunittype,1)
C         iunittype= 0 no unitarization
C                    1 kmatrix
C                    2 pade
C                    3 nd
C                    4 largen
      
        CALL iread('inlo',inlo,1) !yes/no NLO 
        CALL iread('ireson',ireson,1) ! yes/no resonances
        CALL iread('isigma',isigma,1) 
C         yes/no sigma isosinglet scalar resonance IJ=00.
        CALL iread('irho',irho,1) 
C         yes/no rho isotriplet vector resonance IJ=11.      
        CALL iread('iphi',iphi,1) 
C         yes/no phi isosinglet scalar resonance IJ=20.
        CALL iread('iff',iff,1) 
C         yes/no f isosinglet tensor resonance IJ=02.      
        CALL iread('ia',ia,1) 
C         yes/no a isoquintet tensor resonance IJ=22.            

C rg_R  resonances couplings
C rm_R  resonances masses      
C gam_R resonances widths, must be specified in case you don't 
C       use a unitarization scheme.
            
        CALL rread('rg_sigma',rg_sigma,1)
        CALL rread('rm_sigma',rm_sigma,1)
        CALL rread('gam_sigma',gam_sigma,1)
      
        CALL rread('rg_rho',rg_rho,1)
        CALL rread('rm_rho',rm_rho,1)
        CALL rread('gam_rho',gam_rho,1)
      
        CALL rread('rg_phi',rg_phi,1)
        CALL rread('rm_phi',rm_phi,1)
        CALL rread('gam_phi',gam_phi,1)
      
        CALL rread('rg_ff',rg_ff,1)
        CALL rread('rm_ff',rm_ff,1)
        CALL rread('gam_ff',gam_ff,1)      
      
        CALL rread('rg_a',rg_a,1)
        CALL rread('rm_a',rm_a,1)
        CALL rread('gam_a',gam_a,1)      

C NLO parameter, alphas are higher order operators parameters
C rmu is the renormalization scale.
        CALL rread('rmu',rmu,1)
        CALL rread('alpha4',alpha4,1)
        CALL rread('alpha5',alpha5,1)

C N/D scheme: mass parameter       
        CALL rread('rmnd',rmnd,1)      

      endif

*end diogo

      CALL iread('ionesh',ionesh,1) 
                     ! 0= normal run of one process   
                     ! 1= one shot generation of all indicated processes
      
      CALL rread('ecoll',ecoll,1) ! collider energy

      CALL rread('rmh',rmh,1)   ! Higgs mass (GeV) 
	                         ! <0 means no Higgs  
 
c s14
      CALL rread('ghfactor',ghfactor,1)   ! factor which multiplies SM higgs
                                          ! couplings
                                          ! for SM use    ghfactor    1.d0
                  ! when  i_singlet=1 (see below) ghfactor not considered !!!

      if (ghfactor.ne.1.d0.and.i_pertorder.ne.1) then
        print*, 'ERROR: '
        print*, ' higgs couplings different from SM '
        print*, ' (ghfactor different from 1.d0) '
        print*, ' implemented only for  alpha_em^6  (i_pertorder = 1)'
        stop
      endif
      
c s14end

      CALL rread('gamh',gamh,1)   ! Higgs width (GeV)
*                                  ! <0 means computed by phantom
*	                           ! in this last case SM gamh is multiplied
*                                  ! by ghfactor**2 
*                                  ! or by rcosa**2 if i_singlet=1 (see below)

* sig
      CALL iread('i_signal',i_signal,1) ! i_signal= 0 full computation 
                                        ! i_signal> 0 Higgs signal only 
                                        !        (only for i_pertorder = 1 
                                        !                       alpha_em^6
                                        !              and i_unitarize = 0)
                                        ! i_signal= 1 s channel contributions 
                                        !        to boson boson scattering 
                                        !   (boson boson-> Higgs -> boson boson)
                                        ! i_signal= 2 all contributions 
                                        !        (s+t+u channels)
                                        !        to boson boson scattering 
                                        ! i_signal= 3 all contributions 
                                        !        (s+t+u channels)
                                        !        to boson boson scattering 
                                        !        and Higgstrahlung with 
                                        !           H -> boson boson

      if (i_signal.gt.0.and.i_pertorder.ne.1) then
         print*, 'ERROR: for i_signal.gt.0 i_pertorder must be 1'
         stop
      endif
      if (i_signal.gt.0.and.i_unitarize.ne.0) then
        print*,  'ERROR: for i_signal.gt.0 i_unitarize must be 0)'
        stop
      endif
 
* sigend

* heavh  

* SINGLET MODEL OPTION

* singlet model implementation (see e.g. Pruna Roberts arXiv:1303.1150) 

      CALL iread('i_singlet',i_singlet,1) ! yes/no singlet implementation 

      if (i_singlet.eq.1.and.i_pertorder.ne.1) then
        print*, 'WARNING: '
        print*, ' higgs couplings for Singlet Model '
        print*, ' implemented only for  alpha_em^6 '
      endif

* SINGLET MODEL PARAMETERS
      if (i_singlet.eq.1) then

        CALL rread('rmhh',rmhh,1) ! mass of the heavier higgs

        CALL rread('rcosa',rcosa,1) ! parameter cos alfa of arXiv:1303.1150

        CALL rread('tgbeta',tgbeta,1) ! parameter  tg beta of arXiv:1303.1150

        CALL rread('gamhh',gamhh,1) ! heavier Higgs width (GeV)
                                    ! <0 means computed by phantom
                                    ! in this last case SM gamh is multiplied
                                    ! by (1-rcosa**2) + decay of heavy higgs 
                                    !     to 2 light ones: hh-> h+h 
      endif


* HEAVY HIGGS NOT IN THE SINGLET CONTEST (for test only)

      CALL iread('i_hh',i_hh,1) ! yes/no heavy higgs ( not singlet) 


      if (i_hh.eq. 1) then

        if (i_singlet.eq.1) then
          print*,'ERROR'
          print*,'i_hh and i_singlet cannot be both = 1'
          stop
        endif

*from now on parameters regarding a second heavier higgs scalar
****    hh stays for heavy higgs. 


        CALL rread('rmhh_ns',rmhh,1) ! heavier higgs mass (GeV) (not singlet)

        if (i_pertorder.ne.1) then
          print*, 'ERROR: '
          print*, ' higgs couplings different from SM '
          print*, ' i_hh=1 '
          print*, ' implemented only for  alpha_em^6  (i_pertorder = 1)'
          stop
        endif

        CALL rread('ghhfactor',ghhfactor,1) ! factor for second higgs, 
                                           ! which multiplies SM higgs
                                          ! couplings 
                 ! if ghhfactor is negative, ghhfactor=sqrt(1-ghfactor**2)

        IF (ghhfactor.lt.0.d0) ghhfactor=sqrt(1.d0-ghfactor**2)
     
        if (ghhfactor.le.0.d0) then
          print*, ' WARNING '
          print*, ' a hevy higgs has been requested  '
          print*, ' but the couplings are zero'
*          stop
        endif

        CALL rread('gamhh_ns',gamhh,1) ! heavier Higgs width (GeV)
                                    ! <0 means computed by phantom
                                    ! in this last case SM gamh is multiplied
                                    ! by ghhfactor**2 
      endif
      
* set rmhh <0.d0 ad a flag for no heavy higgs (no i_singlet nor i_hh =1)
      if (i_singlet.ne.1.and.i_hh.ne.1) rmhh=-1.d0

* heavend


      CALL iread('i_ccfam',i_ccfam,1)           ! family+CC conjugate
       
      if (ionesh.eq.0) then

        CALL iread('iproc',iproc,8) ! process
*     READ INPUT FOR THE INTEGRATION
        CALL rread('acc_therm',acc_therm,1) ! thermalization accuracy
c giuseppe 21/05/2007
c        CALL iread('ncall_therm',ncall_therm,1)
c                                ! thermalization calls per iteration
        CALL iread('ncall_therm',ncall_therm,2)
                                ! thermalization calls per iteration.
                                ! The first component refers to the 
                                ! number of calls for the first 3 
                                ! iterations, the second one to the 
                                ! calls for the remaining iterations.
c end giuseppe 21/05/2007
        CALL iread('itmx_therm',itmx_therm,1) !thermalization iterations
        CALL rread('acc',acc,1) ! integration accuracy
        CALL iread('ncall',ncall,1) ! integration calls per iteration
        CALL iread('itmx',itmx,1) ! integration iterations 

*     READ INPUT FOR FLAT EVENT GENERATION
        CALL iread('iflat',iflat,1) ! yes/no flat event generation
        IF(iflat.EQ.1)THEN
c          CALL rread('scalemax0',scalemax0,1) 
c                                !scale factor for the maximum
c          scalemax=scalemax0
          scalemax=1.1

c          CALL iread('istorvegas',istorvegas,1)
                                ! yes/no VEGAS data stored
          istorvegas=1

c          CALL iread('iwrite_event',iwrite_event,1)
                  ! yes/no momenta of flat events written in .dat files

          iwrite_event=0

        ENDIF   !iflat

      elseif (ionesh.eq.1) then

*     scale factor for generation

        CALL rread('scalemax',scalemax,1) 
                            !scale factor for the maximum

        CALL iread ('nunwevts',nunwevts,1)	 
               !  number of unweighted events to be produced

        CALL iread('iwrite_event',iwrite_event,1)
                  ! yes/no momenta of flat events written in .dat files

c giuseppe 29/09/2007
        CALL iread('iwrite_mothers',iwrite_mothers,1)
                                ! yes/no information about intermediate 
                                ! particles (mothers) in .dat files
c end giuseppe 29/09/2007

        CALL iread('ihadronize',ihadronize,1) 
                                ! yes/no call to hadronization

        CALL iread('i_exchincoming',i_exchincoming,1)  

c        CALL iread('i_emutau',i_emutau,1)  
        i_emutau=0
      endif

*     READ INPUT FOR CUTS
      CALL iread('i_e_min_lep',i_e_min_lep,1) ! lepton energy lower cuts 
                                !     (GeV)
      IF(i_e_min_lep.EQ.1) CALL rread('e_min_lep',e_min_lep,1) 
      CALL iread('i_pt_min_lep',i_pt_min_lep,1) 
                                ! lepton pt lower cuts (GeV)
      IF(i_pt_min_lep.EQ.1) CALL rread('pt_min_lep',pt_min_lep,1)

c giuseppe 06/02/2007
      CALL iread('i_eta_max_onelep',i_eta_max_onelep,1)
                                ! maximum rapidity (absolute value) for
                                ! AT LEAST one lepton, i.e. at least one
                                ! final state lepton is required to be
                                ! central
c end giuseppe 06/02/2007

      CALL iread('i_eta_max_lep',i_eta_max_lep,1) 
                                ! lepton rapidity upper cuts (absolute
                                ! value), i.e. ALL final state leptons
                                ! are required to be central
c giuseppe 01/03/2007
      IF(i_eta_max_onelep.EQ.1)THEN
        CALL rread('eta_max_onelep',eta_max_onelep,1)
      ENDIF
      IF(i_eta_max_lep.EQ.1)THEN
        CALL rread('eta_max_lep',eta_max_lep,1)      
      ENDIF
c end giuseppe 01/03/2007

      CALL iread('i_ptmiss_min',i_ptmiss_min,1) 
                                ! missing pt lower cuts (GeV)
      IF(i_ptmiss_min.EQ.1) CALL rread('ptmiss_min',ptmiss_min,1)
      CALL iread('i_e_min_j',i_e_min_j,1) ! jet energy lower cuts (GeV)
      IF(i_e_min_j.EQ.1) CALL rread('e_min_j',e_min_j,1)
      CALL iread('i_pt_min_j',i_pt_min_j,1) ! jet pt lower cuts (GeV)
      IF(i_pt_min_j.EQ.1) CALL rread('pt_min_j',pt_min_j,1)
      CALL iread('i_eta_max_j',i_eta_max_j,1) 
                                ! jet rapidity upper cuts  (absolute value)
      IF(i_eta_max_j.EQ.1) CALL rread('eta_max_j',eta_max_j,1)

      CALL iread('i_eta_jf_jb_jc',i_eta_jf_jb_jc,1)
                                ! rapidity of forward, backward and central jets
      IF(i_eta_jf_jb_jc.EQ.1) THEN
        CALL rread('eta_def_jf_min',eta_def_jf_min,1) 
                                ! min rapidity for a jet to be called forward
        CALL rread('eta_def_jb_max',eta_def_jb_max,1) 
                                ! max rapidity for a jet to be called backward
        CALL rread('eta_def_jc_max',eta_def_jc_max,1) 
                                ! max rapidity for a jet to be called central (absolute value)
      ENDIF ! (i_eta_jf_jb_jc.EQ.1)

      CALL iread('i_pt_min_jcjc',i_pt_min_jcjc,1) ! pt lower cuts 
                                ! on two centraljets (GeV)
      IF(i_pt_min_jcjc.EQ.1) 
     &     CALL rread('pt_min_jcjc',pt_min_jcjc,1)

      CALL iread('i_rm_min_jj',i_rm_min_jj,1) 
                                ! minimum invariant mass  between jets (GeV)
      IF(i_rm_min_jj.EQ.1) CALL rread('rm_min_jj',rm_min_jj,1)

      CALL iread('i_rm_min_ll',i_rm_min_ll,1) 
                         ! minimum invariant mass  between charged leptons (GeV)
      IF(i_rm_min_ll.EQ.1) CALL rread('rm_min_ll',rm_min_ll,1)

      CALL iread('i_rm_min_jlep',i_rm_min_jlep,1) 
                                ! minimum invariant mass between jets and lepton (GeV)
      IF(i_rm_min_jlep.EQ.1) CALL rread('rm_min_jlep',rm_min_jlep,1)
      CALL iread('i_rm_min_jcjc',i_rm_min_jcjc,1)
                                ! minimum invariant mass between central jets (GeV)
      IF(i_rm_min_jcjc.EQ.1) 
     &     CALL rread('rm_min_jcjc',rm_min_jcjc,1) 
      CALL iread('i_rm_max_jcjc',i_rm_max_jcjc,1) 
                                ! maximum invariant mass between central jets (GeV)
      IF(i_rm_max_jcjc.EQ.1) 
     &     CALL rread('rm_max_jcjc',rm_max_jcjc,1) 
      CALL iread('i_rm_min_jfjb',i_rm_min_jfjb,1) 
                                ! minimum invariant mass between forward and backward jet
      IF(i_rm_min_jfjb.EQ.1) 
     &     CALL rread('rm_min_jfjb',rm_min_jfjb,1)

* six
      CALL iread('i_rm_min_4l',i_rm_min_4l,1) 
                     ! minimum invariant mass of 4 leptons for processes with 4l
      IF(i_rm_min_4l.EQ.1) 
     &     CALL rread('rm_min_4l',rm_min_4l,1)
      CALL iread('i_rm_min_2l2cq',i_rm_min_2l2cq,1) 
                    ! minimum invariant mass of 2 leptons and 2 central quark for processes with 2l
      IF(i_rm_min_2l2cq.EQ.1) 
     &     CALL rread('rm_min_2l2cq',rm_min_2l2cq,1)

* sixend

* cuttop

      CALL iread('i_deltacuttop',i_deltacuttop,1) 
                     ! yes/no cut on the invariant mass of all triplets of
                     ! particles who could form a top 
                     ! to avoid top contributions
                     ! The corresponding deltacuttop fixes the 
                     ! interval excluded : topmas +- deltatacuttop
 
      IF(i_deltacuttop.EQ.1) 
     &     CALL rread('deltacuttop',deltacuttop,1)

* cuttopend
 
      CALL iread('i_eta_min_jfjb',i_eta_min_jfjb,1) 
                                ! minimum rapidity difference between forward and backward jet
      IF(i_eta_min_jfjb.EQ.1) 
     &     CALL rread('eta_min_jfjb',eta_min_jfjb,1)
      CALL iread('i_d_ar_jj',i_d_ar_jj,1) 
                                ! minimum delta_R separation between jets
      IF(i_d_ar_jj.EQ.1) CALL rread('d_ar_jj',d_ar_jj,1)
      CALL iread('i_d_ar_jlep',i_d_ar_jlep,1)
                                ! minimum delta_R separation between jets and
				! lepton
      IF(i_d_ar_jlep.EQ.1) CALL rread('d_ar_jlep',d_ar_jlep,1)
***aggiunta 1.2.1 su richiesta Pietro
      CALL iread('i_d_ar_leplep',i_d_ar_leplep,1)
                      ! minimum delta_R separation between two charged leptons
				! 
      IF(i_d_ar_leplep.EQ.1) CALL rread('d_ar_leplep',d_ar_leplep,1)
***
      CALL iread('i_thetamin_jj',i_thetamin_jj,1) 
                                ! minimum angle separation between jets (cosine)
      IF(i_thetamin_jj.EQ.1) 
     &     CALL rread('thetamin_jj',thetamin_jj,1)
      CALL iread('i_thetamin_jlep',i_thetamin_jlep,1) 
                                ! minimum angle separation between jets and lepton (cosine)
      IF(i_thetamin_jlep.EQ.1) 
     &     CALL rread('thetamin_jlep',thetamin_jlep,1)
c giuseppe 01/03/2007
      CALL iread('i_thetamin_leplep',i_thetamin_leplep,1) 
                                ! minimum angle separation between charged leptons (cosine)
      IF(i_thetamin_leplep.EQ.1)THEN
        CALL rread('thetamin_leplep',thetamin_leplep,1)
      ENDIF
c end giuseppe 01/03/2007
      CALL iread('i_usercuts',i_usercuts,1) ! yes/no (1/0) additional
                                ! user-defined cuts

      if (ionesh.eq.1) then

*     eventual more restrictive cuts

        CALL iread('iextracuts',iextracuts,1)

        if (iextracuts. eq.1) then

          CALL iread('i_e_min_lepos',i_e_min_lepos,1) 
                                ! lepton energy lower cuts (GeV)
          IF(i_e_min_lepos.EQ.1) CALL rread('e_min_lepos',e_min_lepos,1) 
          CALL iread('i_pt_min_lepos',i_pt_min_lepos,1) 
                                ! lepton pt lower cuts (GeV)
          IF(i_pt_min_lepos.EQ.1) 
     &         CALL rread('pt_min_lepos',pt_min_lepos,1)

c giuseppe 06/02/2007
          CALL iread('i_eta_max_onelepos',i_eta_max_onelepos,1) 
                                ! maximum rapidity (absolute value) for
                                ! AT LEAST one lepton, i.e. at least one
                                ! final state lepton is required to be 
                                ! central
c end giuseppe 06/02/2007

          CALL iread('i_eta_max_lepos',i_eta_max_lepos,1) 
                                ! lepton rapidity upper cuts (absolute 
                                ! value), i.e. ALL final state leptons 
                                ! are required to be central
c giuseppe 01/03/2007
          IF(i_eta_max_onelepos.EQ.1)THEN
            CALL rread('eta_max_onelepos',eta_max_onelepos,1)
          ENDIF
          IF(i_eta_max_lepos.EQ.1)THEN
            CALL rread('eta_max_lepos',eta_max_lepos,1)
          ENDIF
c end giuseppe 01/03/2007

          CALL iread('i_ptmiss_minos',i_ptmiss_minos,1) 
                                ! missing pt lower cuts (GeV)
          IF(i_ptmiss_minos.EQ.1) 
     &         CALL rread('ptmiss_minos',ptmiss_minos,1)
          CALL iread('i_e_min_jos',i_e_min_jos,1) 
                                ! jet energy lower cuts (GeV)
          IF(i_e_min_jos.EQ.1) CALL rread('e_min_jos',e_min_jos,1)
          CALL iread('i_pt_min_jos',i_pt_min_jos,1) 
                                !jet pt lower cuts (GeV)
          IF(i_pt_min_jos.EQ.1) CALL rread('pt_min_jos',pt_min_jos,1)
          CALL iread('i_eta_max_jos',i_eta_max_jos,1) 
                             ! jet rapidity upper cuts  (absolute value)
          IF(i_eta_max_jos.EQ.1) CALL rread('eta_max_jos',eta_max_jos,1)


          CALL iread('i_eta_jf_jb_jcos',i_eta_jf_jb_jcos,1)
                             ! rapidity of forward, backward and central jets
          IF(i_eta_jf_jb_jcos.EQ.1) THEN
            CALL rread('eta_def_jf_minos',eta_def_jf_minos,1) 
                          ! min rapidity for a jet to be called forward
            CALL rread('eta_def_jb_maxos',eta_def_jb_maxos,1) 
                          ! max rapidity for a jet to be called backward
            CALL rread('eta_def_jc_maxos',eta_def_jc_maxos,1)
                ! max rapidity for a jet to be called central (absolute value)
          ENDIF   !  (i_eta_jf_jb_jcos.EQ.1)

          CALL iread('i_pt_min_jcjcos',i_pt_min_jcjcos,1) 
                         ! pt lower cuts  on two centraljets (GeV)
          IF(i_pt_min_jcjcos.EQ.1) 
     &         CALL rread('pt_min_jcjcos',pt_min_jcjcos,1)

          CALL iread('i_rm_min_jjos',i_rm_min_jjos,1) 
                           ! minimum invariant mass  between jets (GeV)
          IF(i_rm_min_jjos.EQ.1) CALL rread('rm_min_jjos',rm_min_jjos,1)

          CALL iread('i_rm_min_llos',i_rm_min_llos,1) 
                   ! minimum invariant mass  between charged leptons (GeV)
          IF(i_rm_min_llos.EQ.1) CALL rread('rm_min_llos',rm_min_llos,1)

          CALL iread('i_rm_min_jlepos',i_rm_min_jlepos,1) 
                      ! minimum invariant mass between jets and lepton (GeV)
          IF(i_rm_min_jlepos.EQ.1) 
     &         CALL rread('rm_min_jlepos',rm_min_jlepos,1)
          CALL iread('i_rm_min_jcjcos',i_rm_min_jcjcos,1)
                     ! minimum invariant mass between central jets (GeV)
          IF(i_rm_min_jcjcos.EQ.1) 
     &         CALL rread('rm_min_jcjcos',rm_min_jcjcos,1) 
          CALL iread('i_rm_max_jcjcos',i_rm_max_jcjcos,1) 
                     ! maximum invariant mass between central jets (GeV)
          IF(i_rm_max_jcjcos.EQ.1) 
     &         CALL rread('rm_max_jcjcos',rm_max_jcjcos,1) 
          CALL iread('i_rm_min_jfjbos',i_rm_min_jfjbos,1) 
               ! minimum invariant mass between forward and backward jet
          IF(i_rm_min_jfjbos.EQ.1) 
     &         CALL rread('rm_min_jfjbos',rm_min_jfjbos,1) 

* six
      CALL iread('i_rm_min_4los',i_rm_min_4los,1) 
                     ! minimum invariant mass of 4 leptons for processes with 4l
      IF(i_rm_min_4los.EQ.1) 
     &     CALL rread('rm_min_4los',rm_min_4los,1)
      CALL iread('i_rm_min_2l2cqos',i_rm_min_2l2cqos,1) 
                    ! minimum invariant mass of 2 leptons and 2 central quark for processes with 2l
      IF(i_rm_min_2l2cqos.EQ.1) 
     &     CALL rread('rm_min_2l2cqos',rm_min_2l2cqos,1)

* sixend

* cuttop

          CALL iread('i_deltacuttopos',i_deltacuttopos,1) 
                     ! yes/no cut on the invariant mass of all triplets of
                     ! particles who could form a top 
                     ! to avoid top contributions
                     ! The corresponding deltacuttop fixes the 
                     ! interval excluded : topmas +- deltatacuttop
          
          IF(i_deltacuttopos.EQ.1) 
     &     CALL rread('deltacuttopos',deltacuttopos,1)

* cuttopend

          CALL iread('i_eta_min_jfjbos',i_eta_min_jfjbos,1) 
          ! minimum rapidity difference between forward and backward jet
          IF(i_eta_min_jfjbos.EQ.1) 
     &         CALL rread('eta_min_jfjbos',eta_min_jfjbos,1)
          CALL iread('i_d_ar_jjos',i_d_ar_jjos,1) 
                    ! minimum delta_R separation between jets
          IF(i_d_ar_jjos.EQ.1) CALL rread('d_ar_jjos',d_ar_jjos,1)
          CALL iread('i_d_ar_jlepos',i_d_ar_jlepos,1)
                   ! minimum delta_R separation between jets and lepton
          IF(i_d_ar_jlepos.EQ.1) CALL rread('d_ar_jlepos',d_ar_jlepos,1)
          CALL iread('i_thetamin_jjos',i_thetamin_jjos,1) 
                   ! minimum angle separation between jets (cosine)
          IF(i_thetamin_jjos.EQ.1) 
     &         CALL rread('thetamin_jjos',thetamin_jjos,1)
          CALL iread('i_thetamin_jlepos',i_thetamin_jlepos,1) 
             ! minimum angle separation between jets and lepton (cosine)
          IF(i_thetamin_jlepos.EQ.1) 
     &         CALL rread('thetamin_jlepos',thetamin_jlepos,1)
c giuseppe 01/03/2007
          CALL iread('i_thetamin_leplepos',i_thetamin_leplepos,1) 
          IF(i_thetamin_leplepos.EQ.1) 
     &         CALL rread('thetamin_leplepos',thetamin_leplepos,1)
c end giuseppe 01/03/2007
          CALL iread('i_usercutsos',i_usercutsos,1) 
                   ! yes/no (1/0) additional  user-defined cuts
        endif

c the number of files to consider and their names are read in oneshot

      endif

      RETURN
      END







