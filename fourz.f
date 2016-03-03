  
************************************************************************
*                                                                       
* This routine computes the basic amplitude corresponding to 8          
*  outgoing  fermions which can form 4Z                                 
*  All 8 fermions  are supposed  massless.                              
*  The input particles are ordered from 1 to 8 in such a way that       
*  odd are particles, even antiparticles.                               
*  p1, ...p8 are all outgoing momenta                                   
*  id1....id8 give the identities of the outgoing particles             
*the routine gives the result "res" which is in this case the modulos sq
* of only 3 forks topologies the different declararion are also temporar
*                                                                       
************************************************************************
*  Comments:   "Z"  stay for a couple of particles                      
*   which can form a Z (particle anti-particle) .                       
*   Correpsondingly  Zline stay for a fermion line which                
*    ends with two particles  which can form a Z (particle anti-particle
*                                                                       
      subroutine fourz(p1,p2,p3,p4,p5,p6,p7,p8,
     &              id1,id2,id3,id4,id5,id6,id7,id8,cres)
  
      implicit real*8 (a-b,d-h,o-z)
      implicit double complex (c)
  
*FOUR MOMENTA                                                           
  
*single momenta                                                         
  
      dimension p1(0:3),p2(0:3),p3(0:3),p4(0:3),p5(0:3),p6(0:3),
     &  p7(0:3),p8(0:3)
  
*forks momenta                                                          
  
      dimension p12(0:3),p34(0:3),p56(0:3),p78(0:3)
  
*left insertion momenta                                                 
  
      dimension p134(0:3),p156(0:3),p178(0:3),p312(0:3),p356(0:3),
     & p378(0:3),p512(0:3),p534(0:3),p578(0:3),p712(0:3),p734(0:3),
     & p756(0:3),p1234(0:3),p1256(0:3),p1278(0:3),p3456(0:3),	
     & p3478(0:3),p5678(0:3)	
  
  
*right insertion momenta                                                
  
      dimension p234(0:3),p256(0:3),p278(0:3),p412(0:3),p456(0:3),
     &	p478(0:3),p612(0:3),p634(0:3),p678(0:3),p812(0:3),p856(0:3),
     &  p834(0:3)	
  
  
  
* auxiliary structure used in mline                                     
  
      structure/aux/
        double complex a(2,2),b(2,2),c(2,2),d(2,2)
      end structure
      record/aux/clineth,clinet_mu(0:3),clineth_4f(2,2)
  
* forks                                                                 
      dimension ch12(2,2),ch34(2,2), ch56(2,2),ch78(2,2),
     & cz1234(2,2,2,2,0:3),cf1234(2,2,2,2,0:3),cz1256(2,2,2,2,0:3),
     & cf1256(2,2,2,2,0:3),cz3478(2,2,2,2,0:3),cf3478(2,2,2,2,0:3),
     & cz5678(2,2,2,2,0:3),cf5678(2,2,2,2,0:3),cz1278(2,2,2,2,0:3),
     & cf1278(2,2,2,2,0:3),cz3456(2,2,2,2,0:3),cf3456(2,2,2,2,0:3),
     &ch1234(2,2,2,2),ch5678(2,2,2,2),ch1278(2,2,2,2),ch1256(2,2,2,2),
     &ch3456(2,2,2,2),ch3478(2,2,2,2),	
     & chh1234(2,2,2,2),chh5678(2,2,2,2),chh1278(2,2,2,2),
     & chh1256(2,2,2,2),chh3456(2,2,2,2),chh3478(2,2,2,2),
* auxiliary                                                             
     &     cdum(2,2,2,2),	
     & cp1234dotcz1234(2,2,2,2),cp1234dotcz5678(2,2,2,2),
     & cp1256dotcz1256(2,2,2,2),cp1256dotcz3478(2,2,2,2),
     & cp1278dotcz1278(2,2,2,2),cp1278dotcz3456(2,2,2,2),
     & cz_zzhh5678(2,2,2,2),cz_zzhh1234(2,2,2,2),cz_zzhh3478(2,2,2,2),
     & cz_zzhh1256(2,2,2,2),cz_zzhh3456(2,2,2,2),cz_zzhh1278(2,2,2,2)
  
  
      structure/polcom/
        double complex e(0:3),ek0,v
      end structure
      record/polcom/cz12(2,2),cz34(2,2),cf12(2,2),cf34(2,2)
     &     ,cz56(2,2),cz78(2,2),cf56(2,2),cf78(2,2)
  
  
* left t Zline                                                          
  
      structure/l_zline/
         double complex a(2,2),b(2,2),c(2,2),d(2,2)
      end structure
      record/l_zline/l1_34(2,2),l1_56(2,2),l1_78(2,2),l3_12(2,2),
     &	l3_56(2,2),l3_78(2,2),l5_12(2,2),l5_34(2,2),l5_78(2,2),
     &  l7_12(2,2),l7_34(2,2),l7_56(2,2),
     &  lz1_234(0:3),lz1_256(0:3), lz1_278(0:3), lz3_412(0:3),	
     &  lz3_456(0:3),lz3_478(0:3), lz5_612(0:3), lz5_634(0:3),
     &	lz5_678(0:3),lz7_812(0:3), lz7_834(0:3), lz7_856(0:3),
     &  lf1_234(0:3),lf1_256(0:3), lf1_278(0:3), lf3_412(0:3),	
     &  lf3_456(0:3),lf3_478(0:3), lf5_612(0:3), lf5_634(0:3),
     &	lf5_678(0:3),lf7_812(0:3), lf7_834(0:3), lf7_856(0:3),
     &  lh1_234,lh1_256, lh1_278, lh3_412,	
     &  lh3_456,lh3_478, lh5_612, lh5_634,
     &	lh5_678,lh7_812, lh7_834, lh7_856
  
* right t Zline                                                         
  
      structure/r_zline/
         double complex a(2,2),b(2,2),c(2,2),d(2,2)
      end structure
      record/r_zline/r2_34(2,2),r2_56(2,2),r2_78(2,2),r4_12(2,2),
     &	r4_56(2,2),r4_78(2,2),r6_12(2,2),r6_34(2,2),r6_78(2,2),
     &  r8_12(2,2),r8_34(2,2),r8_56(2,2),
     &  rz2_134(0:3), rz2_156(0:3), rz2_178(0:3), rz4_312(0:3),
     &	rz4_356(0:3), rz4_378(0:3), rz6_512(0:3), rz6_534(0:3),
     &	rz6_578(0:3), rz8_712(0:3), rz8_734(0:3), rz8_756(0:3),
     &  rf2_134(0:3), rf2_156(0:3), rf2_178(0:3), rf4_312(0:3),
     &	rf4_356(0:3), rf4_378(0:3), rf6_512(0:3), rf6_534(0:3),
     &	rf6_578(0:3), rf8_712(0:3), rf8_734(0:3), rf8_756(0:3),
     &  rh2_134, rh2_156, rh2_178, rh4_312,
     &	rh4_356, rh4_378, rh6_512, rh6_534,
     &	rh6_578, rh8_712, rh8_734, rh8_756
  
* u t Zline (middele insertion)                                         
  
      structure/u_zline/
         double complex a(2,2),b(2,2),c(2,2),d(2,2)
      end structure
      record/u_zline/u134_56(2,2),u134_78(2,2),u156_34(2,2),
     &	u156_78(2,2),u178_34(2,2),u178_56(2,2),u312_56(2,2),
     &  u312_78(2,2),u356_12(2,2),u356_78(2,2),u378_12(2,2),
     &  u378_56(2,2),u512_34(2,2),u512_78(2,2),u534_12(2,2),
     &  u534_78(2,2),u578_12(2,2),u578_34(2,2),u712_34(2,2),
     &  u734_12(2,2),u756_12(2,2),u712_56(2,2),u734_56(2,2),
     &  u756_34(2,2)
                                             	
  
* left*middele  results (two forks)                                     
  
       	 structure/two_forks/
          double complex a(2,2),b(2,2),c(2,2),d(2,2)
       	end structure
       	record/two_forks/u1_3456(2,2,2,2),u1_5634(2,2,2,2),		
     & u1_3478(2,2,2,2),u1_7834(2,2,2,2),u1_5678(2,2,2,2),
     & u1_7856(2,2,2,2),u3_1256(2,2,2,2),u3_5612(2,2,2,2),
     & u3_1278(2,2,2,2),u3_7812(2,2,2,2),u3_5678(2,2,2,2),
     & u3_7856(2,2,2,2),u5_1234(2,2,2,2),u5_3412(2,2,2,2),
     & u5_3478(2,2,2,2),u5_7834(2,2,2,2),u5_1278(2,2,2,2),	
     & u5_7812(2,2,2,2),u7_1234(2,2,2,2),u7_3412(2,2,2,2),
     & u7_1256(2,2,2,2),u7_5612(2,2,2,2),u7_3456(2,2,2,2),
     & u7_5634(2,2,2,2)
                                                       	
*3 forks amplitudes (left*middele*right )                               
  
       structure/three_forks/
        double complex a(2,2),b(2,2),c(2,2),d(2,2)
       end structure
       record/three_forks/cline_3forks_12(2,2,2,2,2,2),
     & cline_3forks_34(2,2,2,2,2,2),cline_3forks_56(2,2,2,2,2,2),
     & cline_3forks_78(2,2,2,2,2,2),clinetzz(2,2,0:3),
     & clinetfz(2,2,0:3) 	
  
*Final 3 forks amplitude (summed)                                       
  
       structure/three_forks_amp/
        double complex pol(2,2)
       end structure
       record/three_forks_amp/cres_3forks(2,2,2,2,2,2),				
     & cres_3forks_12(2,2,2,2,2,2),cres_3forks_34(2,2,2,2,2,2),
     & cres_3forks_56(2,2,2,2,2,2),cres_3forks_78(2,2,2,2,2,2),
     & creszz_z_zz(2,2,2,2,2,2),creszz_f_zz(2,2,2,2,2,2),
     & creszz_zz(2,2,2,2,2,2),creszz_h_zz(2,2,2,2,2,2),	
     & creszz_hh_zz(2,2,2,2,2,2),	
     & cresquad_hh_zz(2,2,2,2,2,2),cresquad_hh_hh(2,2,2,2,2,2),
     & cres(2,2,2,2,2,2),cunit(2,2,2,2,2,2)
  
*common blocks                                                          
  
* generic common                                                        
      include 'common.h'
      include 'common_unitarization.h'
  
  
* sig                                                                   
  
      if (i_signal.eq.1) then
* eliminate higgstrahlung                                               
        if (p1(0).lt.0.d0.and.p2(0).lt.0.d0.or.
     &        p3(0).lt.0.d0.and.p4(0).lt.0.d0.or.
     &        p5(0).lt.0.d0.and.p6(0).lt.0.d0.or.
     &        p7(0).lt.0.d0.and.p8(0).lt.0.d0)then
          do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
                  do i5=1,2
                    do i6=1,2
                      do i7=1,2
                        do i8=1,2
  
                          cres(i1,i2,i3,i4,i5,i6).pol(i7,i8)=czero
  
                        enddo
                      enddo
                    enddo
                  enddo
                enddo
              enddo
            enddo
          enddo
          return
        endif
      endif
* sigend                                                                
  
  
* 4momenta and their sums                                               
  
* pk0 -- p=p1
      p1k0=p1(0)-p1(1)
* pk0 -- p=p2
      p2k0=p2(0)-p2(1)
* pk0 -- p=p3
      p3k0=p3(0)-p3(1)
* pk0 -- p=p4
      p4k0=p4(0)-p4(1)
* pk0 -- p=p5
      p5k0=p5(0)-p5(1)
* pk0 -- p=p6
      p6k0=p6(0)-p6(1)
* pk0 -- p=p7
      p7k0=p7(0)-p7(1)
* pk0 -- p=p8
      p8k0=p8(0)-p8(1)
  
      do m=0,3
        p12(m)=p1(m)+p2(m)
      enddo
      do m=0,3
        p34(m)=p3(m)+p4(m)
      enddo
      do m=0,3
        p56(m)=p5(m)+p6(m)
      enddo
      do m=0,3
        p78(m)=p7(m)+p8(m)
      enddo
  
      do mu=0,3
        p1234(mu)=p12(mu)+p34(mu)
      enddo
* p.q -- p.q=p1234q,p=p1234,q=p1234,bef=,aft=
      p1234q=(p1234(0)*p1234(0)-p1234(1)*p1234(1)-p1234(2)*p1234
     & (2)-p1234(3)*p1234(3))
      do mu=0,3
        p1256(mu)=p12(mu)+p56(mu)
      enddo
* p.q -- p.q=p1256q,p=p1256,q=p1256,bef=,aft=
      p1256q=(p1256(0)*p1256(0)-p1256(1)*p1256(1)-p1256(2)*p1256
     & (2)-p1256(3)*p1256(3))
      do mu=0,3
        p1278(mu)=p12(mu)+p78(mu)
      enddo
* p.q -- p.q=p1278q,p=p1278,q=p1278,bef=,aft=
      p1278q=(p1278(0)*p1278(0)-p1278(1)*p1278(1)-p1278(2)*p1278
     & (2)-p1278(3)*p1278(3))
      do mu=0,3
        p3456(mu)=p34(mu)+p56(mu)
      enddo
* p.q -- p.q=p3456q,p=p3456,q=p3456,bef=,aft=
      p3456q=(p3456(0)*p3456(0)-p3456(1)*p3456(1)-p3456(2)*p3456
     & (2)-p3456(3)*p3456(3))
      do mu=0,3
        p3478(mu)=p34(mu)+p78(mu)
      enddo
* p.q -- p.q=p3478q,p=p3478,q=p3478,bef=,aft=
      p3478q=(p3478(0)*p3478(0)-p3478(1)*p3478(1)-p3478(2)*p3478
     & (2)-p3478(3)*p3478(3))
      do mu=0,3
        p5678(mu)=p56(mu)+p78(mu)
      enddo
* p.q -- p.q=p5678q,p=p5678,q=p5678,bef=,aft=
      p5678q=(p5678(0)*p5678(0)-p5678(1)*p5678(1)-p5678(2)*p5678
     & (2)-p5678(3)*p5678(3))
  
*                                                                       
*  COMPUTE ALL FORKS (  Z'S, GAMMA'S, HIGGS'S "DECAYING" TO TWO FERMIONS
*                                                                       
*                                                                       
*     		 Z'S AND GAMMAS  AND HIGGS                                      
*                                                                       
*                                                                       
*            _Z,f,h_/                                                   
*                   \                                                   
  
  
  
* quqd -- p=p1,q=p2
      quqd=p1(0)*p2(0)-p1(1)*p2(1)-p1(2)*p2(2)-p1(3)*p2(3)
      s12=2.d0*quqd+rmass2(id1)+rmass2(id2)
      ccr=zcr(id1)/(-s12+cmz2)
      ccl=zcl(id1)/(-s12+cmz2)
* T -- qu=p1,qd=p2,v=0,a=clinet_mu(0).a,b=clinet_mu(0).b,c=clinet_mu(0).
* c,d=clinet_mu(0).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p1(2)*p2(3)+p2(2)*p1(3)
      ceps_0=eps_0*cim
      ceps_1=p1(3)*cim
      ceps_2=p2(3)*cim
      auxa=-quqd+p1k0*p2(0)+p2k0*p1(0)
      clinet_mu(0).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(0).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(0).b(1,2)=-ccl*(p2(2)+ceps_2)
      clinet_mu(0).b(2,1)=ccr*(p2(2)-ceps_2)
      clinet_mu(0).c(1,2)=ccr*(p1(2)+ceps_1)
      clinet_mu(0).c(2,1)=ccl*(-p1(2)+ceps_1)
      clinet_mu(0).d(1,1)=ccl
      clinet_mu(0).d(2,2)=ccr
* T -- qu=p1,qd=p2,v=1,a=clinet_mu(1).a,b=clinet_mu(1).b,c=clinet_mu(1).
* c,d=clinet_mu(1).d,cr=ccr,cl=ccl,nsum=0
      auxa=-quqd+p1k0*p2(1)+p2k0*p1(1)
      clinet_mu(1).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(1).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(1).b(1,2)=-ccl*(p2(2)+ceps_2)
      clinet_mu(1).b(2,1)=ccr*(p2(2)-ceps_2)
      clinet_mu(1).c(1,2)=ccr*(p1(2)+ceps_1)
      clinet_mu(1).c(2,1)=ccl*(-p1(2)+ceps_1)
      clinet_mu(1).d(1,1)=ccl
      clinet_mu(1).d(2,2)=ccr
* T -- qu=p1,qd=p2,v=2,a=clinet_mu(2).a,b=clinet_mu(2).b,c=clinet_mu(2).
* c,d=clinet_mu(2).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p1k0*p2(3)+p2k0*p1(3)
      ceps_0=eps_0*cim
      auxa=p1k0*p2(2)+p2k0*p1(2)
      clinet_mu(2).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(2).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(2).b(1,2)=-ccl*p2k0
      clinet_mu(2).b(2,1)=ccr*p2k0
      clinet_mu(2).c(1,2)=ccr*p1k0
      clinet_mu(2).c(2,1)=-ccl*p1k0
* T -- qu=p1,qd=p2,v=3,a=clinet_mu(3).a,b=clinet_mu(3).b,c=clinet_mu(3).
* c,d=clinet_mu(3).d,cr=ccr,cl=ccl,nsum=0
      eps_0=p1k0*p2(2)-p2k0*p1(2)
      ceps_0=eps_0*cim
      ceps_1=p1k0*cim
      ceps_2=p2k0*cim
      auxa=+p1k0*p2(3)+p2k0*p1(3)
      clinet_mu(3).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(3).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(3).b(1,2)=-ccl*ceps_2
      clinet_mu(3).b(2,1)=-ccr*ceps_2
      clinet_mu(3).c(1,2)=ccr*ceps_1
      clinet_mu(3).c(2,1)=ccl*ceps_1
      rmassl=rmass(id1)
      rmassr=-rmassl
      do mu=0,3
* mline -- res=cz12(&1,&2).e(mu),abcd=clinet_mu(mu).,m1=rmassl,m2=rmassr
* ,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cz12(iut,jut).e(mu)=clinet_mu(mu).a(iut,jut)+rmassl*clinet
     & _mu(mu).b(iut,jut)+rmassr*clinet_mu(mu).c(iut,jut)+rmassl
     & *rmassr*clinet_mu(mu).d(iut,jut)
      enddo
      enddo
      end do
  
      if (imass(id1).eq.1) then
        do i1=1,2
          do i2=1,2
* p.q -- p.q=cauxdot,p=p12,q=cz12(i1,i2).e,bef=,aft=
      cauxdot=(p12(0)*cz12(i1,i2).e(0)-p12(1)*cz12(i1,i2).e(1)-p
     & 12(2)*cz12(i1,i2).e(2)-p12(3)*cz12(i1,i2).e(3))
            do mu=0,3
             cz12(i1,i2).e(mu)=cz12(i1,i2).e(mu)-p12(mu)*cauxdot
     &             /cmz2
            enddo
          enddo
        enddo
      endif
      do i1=1,2
      do i2=1,2
* pk0 -- p=cz12(i1,i2).e
      cz12(i1,i2).ek0=cz12(i1,i2).e(0)-cz12(i1,i2).e(1)
      end do
      end do
      ccr=fcr(id1)/(-s12)
      ccl=fcl(id1)/(-s12)
* T -- qu=p1,qd=p2,v=0,a=clinet_mu(0).a,b=clinet_mu(0).b,c=clinet_mu(0).
* c,d=clinet_mu(0).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p1(2)*p2(3)+p2(2)*p1(3)
      ceps_0=eps_0*cim
      ceps_1=p1(3)*cim
      ceps_2=p2(3)*cim
      auxa=-quqd+p1k0*p2(0)+p2k0*p1(0)
      clinet_mu(0).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(0).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(0).b(1,2)=-ccl*(p2(2)+ceps_2)
      clinet_mu(0).b(2,1)=ccr*(p2(2)-ceps_2)
      clinet_mu(0).c(1,2)=ccr*(p1(2)+ceps_1)
      clinet_mu(0).c(2,1)=ccl*(-p1(2)+ceps_1)
      clinet_mu(0).d(1,1)=ccl
      clinet_mu(0).d(2,2)=ccr
* T -- qu=p1,qd=p2,v=1,a=clinet_mu(1).a,b=clinet_mu(1).b,c=clinet_mu(1).
* c,d=clinet_mu(1).d,cr=ccr,cl=ccl,nsum=0
      auxa=-quqd+p1k0*p2(1)+p2k0*p1(1)
      clinet_mu(1).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(1).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(1).b(1,2)=-ccl*(p2(2)+ceps_2)
      clinet_mu(1).b(2,1)=ccr*(p2(2)-ceps_2)
      clinet_mu(1).c(1,2)=ccr*(p1(2)+ceps_1)
      clinet_mu(1).c(2,1)=ccl*(-p1(2)+ceps_1)
      clinet_mu(1).d(1,1)=ccl
      clinet_mu(1).d(2,2)=ccr
* T -- qu=p1,qd=p2,v=2,a=clinet_mu(2).a,b=clinet_mu(2).b,c=clinet_mu(2).
* c,d=clinet_mu(2).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p1k0*p2(3)+p2k0*p1(3)
      ceps_0=eps_0*cim
      auxa=p1k0*p2(2)+p2k0*p1(2)
      clinet_mu(2).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(2).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(2).b(1,2)=-ccl*p2k0
      clinet_mu(2).b(2,1)=ccr*p2k0
      clinet_mu(2).c(1,2)=ccr*p1k0
      clinet_mu(2).c(2,1)=-ccl*p1k0
* T -- qu=p1,qd=p2,v=3,a=clinet_mu(3).a,b=clinet_mu(3).b,c=clinet_mu(3).
* c,d=clinet_mu(3).d,cr=ccr,cl=ccl,nsum=0
      eps_0=p1k0*p2(2)-p2k0*p1(2)
      ceps_0=eps_0*cim
      ceps_1=p1k0*cim
      ceps_2=p2k0*cim
      auxa=+p1k0*p2(3)+p2k0*p1(3)
      clinet_mu(3).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(3).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(3).b(1,2)=-ccl*ceps_2
      clinet_mu(3).b(2,1)=-ccr*ceps_2
      clinet_mu(3).c(1,2)=ccr*ceps_1
      clinet_mu(3).c(2,1)=ccl*ceps_1
      rmassl=rmass(id1)
      rmassr=-rmassl
      do mu=0,3
* mline -- res=cf12(&1,&2).e(mu),abcd=clinet_mu(mu).,m1=rmassl,m2=rmassr
* ,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cf12(iut,jut).e(mu)=clinet_mu(mu).a(iut,jut)+rmassl*clinet
     & _mu(mu).b(iut,jut)+rmassr*clinet_mu(mu).c(iut,jut)+rmassl
     & *rmassr*clinet_mu(mu).d(iut,jut)
      enddo
      enddo
      end do
  
      do i1=1,2
      do i2=1,2
* pk0 -- p=cf12(i1,i2).e
      cf12(i1,i2).ek0=cf12(i1,i2).e(0)-cf12(i1,i2).e(1)
      end do
      end do
  
*      higgs                                                            
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id1.eq.5.and.rmh.ge.0.d0) then
  
  
  
* TH -- qu=p1,qd=p2,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p1k0*p2(2)+p2k0*p1(2)
      cauxa=auxa-cim*(p2(3)*p1k0-p1(3)*p2k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p2k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p1k0
      clineth.c(2,2)=clineth.c(1,1)
* mline -- res=ch12(&1,&2),abcd=clineth.,m1=rmassl,m2=rmassr,den=0,nsum=
* 0
      do iut=1,2
      do jut=1,2
      ch12(iut,jut)=clineth.a(iut,jut)+rmassl*clineth.b(iut,jut)
     & +rmassr*clineth.c(iut,jut)+rmassl*rmassr*clineth.d(iut,ju
     & t)
      enddo
      enddo
  
  
      else
        do i1=1,2
          do i2=1,2
            ch12(i1,i2)=czero
          enddo
        enddo
      endif
* quqd -- p=p3,q=p4
      quqd=p3(0)*p4(0)-p3(1)*p4(1)-p3(2)*p4(2)-p3(3)*p4(3)
      s34=2.d0*quqd+rmass2(id3)+rmass2(id4)
      ccr=zcr(id3)/(-s34+cmz2)
      ccl=zcl(id3)/(-s34+cmz2)
* T -- qu=p3,qd=p4,v=0,a=clinet_mu(0).a,b=clinet_mu(0).b,c=clinet_mu(0).
* c,d=clinet_mu(0).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p3(2)*p4(3)+p4(2)*p3(3)
      ceps_0=eps_0*cim
      ceps_1=p3(3)*cim
      ceps_2=p4(3)*cim
      auxa=-quqd+p3k0*p4(0)+p4k0*p3(0)
      clinet_mu(0).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(0).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(0).b(1,2)=-ccl*(p4(2)+ceps_2)
      clinet_mu(0).b(2,1)=ccr*(p4(2)-ceps_2)
      clinet_mu(0).c(1,2)=ccr*(p3(2)+ceps_1)
      clinet_mu(0).c(2,1)=ccl*(-p3(2)+ceps_1)
      clinet_mu(0).d(1,1)=ccl
      clinet_mu(0).d(2,2)=ccr
* T -- qu=p3,qd=p4,v=1,a=clinet_mu(1).a,b=clinet_mu(1).b,c=clinet_mu(1).
* c,d=clinet_mu(1).d,cr=ccr,cl=ccl,nsum=0
      auxa=-quqd+p3k0*p4(1)+p4k0*p3(1)
      clinet_mu(1).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(1).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(1).b(1,2)=-ccl*(p4(2)+ceps_2)
      clinet_mu(1).b(2,1)=ccr*(p4(2)-ceps_2)
      clinet_mu(1).c(1,2)=ccr*(p3(2)+ceps_1)
      clinet_mu(1).c(2,1)=ccl*(-p3(2)+ceps_1)
      clinet_mu(1).d(1,1)=ccl
      clinet_mu(1).d(2,2)=ccr
* T -- qu=p3,qd=p4,v=2,a=clinet_mu(2).a,b=clinet_mu(2).b,c=clinet_mu(2).
* c,d=clinet_mu(2).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p3k0*p4(3)+p4k0*p3(3)
      ceps_0=eps_0*cim
      auxa=p3k0*p4(2)+p4k0*p3(2)
      clinet_mu(2).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(2).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(2).b(1,2)=-ccl*p4k0
      clinet_mu(2).b(2,1)=ccr*p4k0
      clinet_mu(2).c(1,2)=ccr*p3k0
      clinet_mu(2).c(2,1)=-ccl*p3k0
* T -- qu=p3,qd=p4,v=3,a=clinet_mu(3).a,b=clinet_mu(3).b,c=clinet_mu(3).
* c,d=clinet_mu(3).d,cr=ccr,cl=ccl,nsum=0
      eps_0=p3k0*p4(2)-p4k0*p3(2)
      ceps_0=eps_0*cim
      ceps_1=p3k0*cim
      ceps_2=p4k0*cim
      auxa=+p3k0*p4(3)+p4k0*p3(3)
      clinet_mu(3).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(3).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(3).b(1,2)=-ccl*ceps_2
      clinet_mu(3).b(2,1)=-ccr*ceps_2
      clinet_mu(3).c(1,2)=ccr*ceps_1
      clinet_mu(3).c(2,1)=ccl*ceps_1
      rmassl=rmass(id3)
      rmassr=-rmassl
      do mu=0,3
* mline -- res=cz34(&1,&2).e(mu),abcd=clinet_mu(mu).,m1=rmassl,m2=rmassr
* ,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cz34(iut,jut).e(mu)=clinet_mu(mu).a(iut,jut)+rmassl*clinet
     & _mu(mu).b(iut,jut)+rmassr*clinet_mu(mu).c(iut,jut)+rmassl
     & *rmassr*clinet_mu(mu).d(iut,jut)
      enddo
      enddo
      end do
  
      if (imass(id3).eq.1) then
        do i1=1,2
          do i2=1,2
* p.q -- p.q=cauxdot,p=p34,q=cz34(i1,i2).e,bef=,aft=
      cauxdot=(p34(0)*cz34(i1,i2).e(0)-p34(1)*cz34(i1,i2).e(1)-p
     & 34(2)*cz34(i1,i2).e(2)-p34(3)*cz34(i1,i2).e(3))
            do mu=0,3
             cz34(i1,i2).e(mu)=cz34(i1,i2).e(mu)-p34(mu)*cauxdot
     &             /cmz2
            enddo
          enddo
        enddo
      endif
      do i1=1,2
      do i2=1,2
* pk0 -- p=cz34(i1,i2).e
      cz34(i1,i2).ek0=cz34(i1,i2).e(0)-cz34(i1,i2).e(1)
      end do
      end do
      ccr=fcr(id3)/(-s34)
      ccl=fcl(id3)/(-s34)
* T -- qu=p3,qd=p4,v=0,a=clinet_mu(0).a,b=clinet_mu(0).b,c=clinet_mu(0).
* c,d=clinet_mu(0).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p3(2)*p4(3)+p4(2)*p3(3)
      ceps_0=eps_0*cim
      ceps_1=p3(3)*cim
      ceps_2=p4(3)*cim
      auxa=-quqd+p3k0*p4(0)+p4k0*p3(0)
      clinet_mu(0).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(0).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(0).b(1,2)=-ccl*(p4(2)+ceps_2)
      clinet_mu(0).b(2,1)=ccr*(p4(2)-ceps_2)
      clinet_mu(0).c(1,2)=ccr*(p3(2)+ceps_1)
      clinet_mu(0).c(2,1)=ccl*(-p3(2)+ceps_1)
      clinet_mu(0).d(1,1)=ccl
      clinet_mu(0).d(2,2)=ccr
* T -- qu=p3,qd=p4,v=1,a=clinet_mu(1).a,b=clinet_mu(1).b,c=clinet_mu(1).
* c,d=clinet_mu(1).d,cr=ccr,cl=ccl,nsum=0
      auxa=-quqd+p3k0*p4(1)+p4k0*p3(1)
      clinet_mu(1).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(1).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(1).b(1,2)=-ccl*(p4(2)+ceps_2)
      clinet_mu(1).b(2,1)=ccr*(p4(2)-ceps_2)
      clinet_mu(1).c(1,2)=ccr*(p3(2)+ceps_1)
      clinet_mu(1).c(2,1)=ccl*(-p3(2)+ceps_1)
      clinet_mu(1).d(1,1)=ccl
      clinet_mu(1).d(2,2)=ccr
* T -- qu=p3,qd=p4,v=2,a=clinet_mu(2).a,b=clinet_mu(2).b,c=clinet_mu(2).
* c,d=clinet_mu(2).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p3k0*p4(3)+p4k0*p3(3)
      ceps_0=eps_0*cim
      auxa=p3k0*p4(2)+p4k0*p3(2)
      clinet_mu(2).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(2).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(2).b(1,2)=-ccl*p4k0
      clinet_mu(2).b(2,1)=ccr*p4k0
      clinet_mu(2).c(1,2)=ccr*p3k0
      clinet_mu(2).c(2,1)=-ccl*p3k0
* T -- qu=p3,qd=p4,v=3,a=clinet_mu(3).a,b=clinet_mu(3).b,c=clinet_mu(3).
* c,d=clinet_mu(3).d,cr=ccr,cl=ccl,nsum=0
      eps_0=p3k0*p4(2)-p4k0*p3(2)
      ceps_0=eps_0*cim
      ceps_1=p3k0*cim
      ceps_2=p4k0*cim
      auxa=+p3k0*p4(3)+p4k0*p3(3)
      clinet_mu(3).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(3).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(3).b(1,2)=-ccl*ceps_2
      clinet_mu(3).b(2,1)=-ccr*ceps_2
      clinet_mu(3).c(1,2)=ccr*ceps_1
      clinet_mu(3).c(2,1)=ccl*ceps_1
      rmassl=rmass(id3)
      rmassr=-rmassl
      do mu=0,3
* mline -- res=cf34(&1,&2).e(mu),abcd=clinet_mu(mu).,m1=rmassl,m2=rmassr
* ,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cf34(iut,jut).e(mu)=clinet_mu(mu).a(iut,jut)+rmassl*clinet
     & _mu(mu).b(iut,jut)+rmassr*clinet_mu(mu).c(iut,jut)+rmassl
     & *rmassr*clinet_mu(mu).d(iut,jut)
      enddo
      enddo
      end do
  
      do i1=1,2
      do i2=1,2
* pk0 -- p=cf34(i1,i2).e
      cf34(i1,i2).ek0=cf34(i1,i2).e(0)-cf34(i1,i2).e(1)
      end do
      end do
  
*      higgs                                                            
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id3.eq.5.and.rmh.ge.0.d0) then
  
  
  
* TH -- qu=p3,qd=p4,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p3k0*p4(2)+p4k0*p3(2)
      cauxa=auxa-cim*(p4(3)*p3k0-p3(3)*p4k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p4k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p3k0
      clineth.c(2,2)=clineth.c(1,1)
* mline -- res=ch34(&1,&2),abcd=clineth.,m1=rmassl,m2=rmassr,den=0,nsum=
* 0
      do iut=1,2
      do jut=1,2
      ch34(iut,jut)=clineth.a(iut,jut)+rmassl*clineth.b(iut,jut)
     & +rmassr*clineth.c(iut,jut)+rmassl*rmassr*clineth.d(iut,ju
     & t)
      enddo
      enddo
  
  
      else
        do i3=1,2
          do i4=1,2
            ch34(i3,i4)=czero
          enddo
        enddo
      endif
* quqd -- p=p5,q=p6
      quqd=p5(0)*p6(0)-p5(1)*p6(1)-p5(2)*p6(2)-p5(3)*p6(3)
      s56=2.d0*quqd+rmass2(id5)+rmass2(id6)
      ccr=zcr(id5)/(-s56+cmz2)
      ccl=zcl(id5)/(-s56+cmz2)
* T -- qu=p5,qd=p6,v=0,a=clinet_mu(0).a,b=clinet_mu(0).b,c=clinet_mu(0).
* c,d=clinet_mu(0).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p5(2)*p6(3)+p6(2)*p5(3)
      ceps_0=eps_0*cim
      ceps_1=p5(3)*cim
      ceps_2=p6(3)*cim
      auxa=-quqd+p5k0*p6(0)+p6k0*p5(0)
      clinet_mu(0).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(0).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(0).b(1,2)=-ccl*(p6(2)+ceps_2)
      clinet_mu(0).b(2,1)=ccr*(p6(2)-ceps_2)
      clinet_mu(0).c(1,2)=ccr*(p5(2)+ceps_1)
      clinet_mu(0).c(2,1)=ccl*(-p5(2)+ceps_1)
      clinet_mu(0).d(1,1)=ccl
      clinet_mu(0).d(2,2)=ccr
* T -- qu=p5,qd=p6,v=1,a=clinet_mu(1).a,b=clinet_mu(1).b,c=clinet_mu(1).
* c,d=clinet_mu(1).d,cr=ccr,cl=ccl,nsum=0
      auxa=-quqd+p5k0*p6(1)+p6k0*p5(1)
      clinet_mu(1).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(1).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(1).b(1,2)=-ccl*(p6(2)+ceps_2)
      clinet_mu(1).b(2,1)=ccr*(p6(2)-ceps_2)
      clinet_mu(1).c(1,2)=ccr*(p5(2)+ceps_1)
      clinet_mu(1).c(2,1)=ccl*(-p5(2)+ceps_1)
      clinet_mu(1).d(1,1)=ccl
      clinet_mu(1).d(2,2)=ccr
* T -- qu=p5,qd=p6,v=2,a=clinet_mu(2).a,b=clinet_mu(2).b,c=clinet_mu(2).
* c,d=clinet_mu(2).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p5k0*p6(3)+p6k0*p5(3)
      ceps_0=eps_0*cim
      auxa=p5k0*p6(2)+p6k0*p5(2)
      clinet_mu(2).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(2).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(2).b(1,2)=-ccl*p6k0
      clinet_mu(2).b(2,1)=ccr*p6k0
      clinet_mu(2).c(1,2)=ccr*p5k0
      clinet_mu(2).c(2,1)=-ccl*p5k0
* T -- qu=p5,qd=p6,v=3,a=clinet_mu(3).a,b=clinet_mu(3).b,c=clinet_mu(3).
* c,d=clinet_mu(3).d,cr=ccr,cl=ccl,nsum=0
      eps_0=p5k0*p6(2)-p6k0*p5(2)
      ceps_0=eps_0*cim
      ceps_1=p5k0*cim
      ceps_2=p6k0*cim
      auxa=+p5k0*p6(3)+p6k0*p5(3)
      clinet_mu(3).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(3).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(3).b(1,2)=-ccl*ceps_2
      clinet_mu(3).b(2,1)=-ccr*ceps_2
      clinet_mu(3).c(1,2)=ccr*ceps_1
      clinet_mu(3).c(2,1)=ccl*ceps_1
      rmassl=rmass(id5)
      rmassr=-rmassl
      do mu=0,3
* mline -- res=cz56(&1,&2).e(mu),abcd=clinet_mu(mu).,m1=rmassl,m2=rmassr
* ,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cz56(iut,jut).e(mu)=clinet_mu(mu).a(iut,jut)+rmassl*clinet
     & _mu(mu).b(iut,jut)+rmassr*clinet_mu(mu).c(iut,jut)+rmassl
     & *rmassr*clinet_mu(mu).d(iut,jut)
      enddo
      enddo
      end do
  
      if (imass(id5).eq.1) then
        do i1=1,2
          do i2=1,2
* p.q -- p.q=cauxdot,p=p56,q=cz56(i1,i2).e,bef=,aft=
      cauxdot=(p56(0)*cz56(i1,i2).e(0)-p56(1)*cz56(i1,i2).e(1)-p
     & 56(2)*cz56(i1,i2).e(2)-p56(3)*cz56(i1,i2).e(3))
            do mu=0,3
             cz56(i1,i2).e(mu)=cz56(i1,i2).e(mu)-p56(mu)*cauxdot
     &             /cmz2
            enddo
          enddo
        enddo
      endif
      do i1=1,2
      do i2=1,2
* pk0 -- p=cz56(i1,i2).e
      cz56(i1,i2).ek0=cz56(i1,i2).e(0)-cz56(i1,i2).e(1)
      end do
      end do
      ccr=fcr(id5)/(-s56)
      ccl=fcl(id5)/(-s56)
* T -- qu=p5,qd=p6,v=0,a=clinet_mu(0).a,b=clinet_mu(0).b,c=clinet_mu(0).
* c,d=clinet_mu(0).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p5(2)*p6(3)+p6(2)*p5(3)
      ceps_0=eps_0*cim
      ceps_1=p5(3)*cim
      ceps_2=p6(3)*cim
      auxa=-quqd+p5k0*p6(0)+p6k0*p5(0)
      clinet_mu(0).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(0).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(0).b(1,2)=-ccl*(p6(2)+ceps_2)
      clinet_mu(0).b(2,1)=ccr*(p6(2)-ceps_2)
      clinet_mu(0).c(1,2)=ccr*(p5(2)+ceps_1)
      clinet_mu(0).c(2,1)=ccl*(-p5(2)+ceps_1)
      clinet_mu(0).d(1,1)=ccl
      clinet_mu(0).d(2,2)=ccr
* T -- qu=p5,qd=p6,v=1,a=clinet_mu(1).a,b=clinet_mu(1).b,c=clinet_mu(1).
* c,d=clinet_mu(1).d,cr=ccr,cl=ccl,nsum=0
      auxa=-quqd+p5k0*p6(1)+p6k0*p5(1)
      clinet_mu(1).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(1).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(1).b(1,2)=-ccl*(p6(2)+ceps_2)
      clinet_mu(1).b(2,1)=ccr*(p6(2)-ceps_2)
      clinet_mu(1).c(1,2)=ccr*(p5(2)+ceps_1)
      clinet_mu(1).c(2,1)=ccl*(-p5(2)+ceps_1)
      clinet_mu(1).d(1,1)=ccl
      clinet_mu(1).d(2,2)=ccr
* T -- qu=p5,qd=p6,v=2,a=clinet_mu(2).a,b=clinet_mu(2).b,c=clinet_mu(2).
* c,d=clinet_mu(2).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p5k0*p6(3)+p6k0*p5(3)
      ceps_0=eps_0*cim
      auxa=p5k0*p6(2)+p6k0*p5(2)
      clinet_mu(2).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(2).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(2).b(1,2)=-ccl*p6k0
      clinet_mu(2).b(2,1)=ccr*p6k0
      clinet_mu(2).c(1,2)=ccr*p5k0
      clinet_mu(2).c(2,1)=-ccl*p5k0
* T -- qu=p5,qd=p6,v=3,a=clinet_mu(3).a,b=clinet_mu(3).b,c=clinet_mu(3).
* c,d=clinet_mu(3).d,cr=ccr,cl=ccl,nsum=0
      eps_0=p5k0*p6(2)-p6k0*p5(2)
      ceps_0=eps_0*cim
      ceps_1=p5k0*cim
      ceps_2=p6k0*cim
      auxa=+p5k0*p6(3)+p6k0*p5(3)
      clinet_mu(3).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(3).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(3).b(1,2)=-ccl*ceps_2
      clinet_mu(3).b(2,1)=-ccr*ceps_2
      clinet_mu(3).c(1,2)=ccr*ceps_1
      clinet_mu(3).c(2,1)=ccl*ceps_1
      rmassl=rmass(id5)
      rmassr=-rmassl
      do mu=0,3
* mline -- res=cf56(&1,&2).e(mu),abcd=clinet_mu(mu).,m1=rmassl,m2=rmassr
* ,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cf56(iut,jut).e(mu)=clinet_mu(mu).a(iut,jut)+rmassl*clinet
     & _mu(mu).b(iut,jut)+rmassr*clinet_mu(mu).c(iut,jut)+rmassl
     & *rmassr*clinet_mu(mu).d(iut,jut)
      enddo
      enddo
      end do
  
      do i1=1,2
      do i2=1,2
* pk0 -- p=cf56(i1,i2).e
      cf56(i1,i2).ek0=cf56(i1,i2).e(0)-cf56(i1,i2).e(1)
      end do
      end do
  
*      higgs                                                            
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id5.eq.5.and.rmh.ge.0.d0) then
  
  
  
* TH -- qu=p5,qd=p6,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p5k0*p6(2)+p6k0*p5(2)
      cauxa=auxa-cim*(p6(3)*p5k0-p5(3)*p6k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p6k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p5k0
      clineth.c(2,2)=clineth.c(1,1)
* mline -- res=ch56(&1,&2),abcd=clineth.,m1=rmassl,m2=rmassr,den=0,nsum=
* 0
      do iut=1,2
      do jut=1,2
      ch56(iut,jut)=clineth.a(iut,jut)+rmassl*clineth.b(iut,jut)
     & +rmassr*clineth.c(iut,jut)+rmassl*rmassr*clineth.d(iut,ju
     & t)
      enddo
      enddo
  
  
      else
        do i5=1,2
          do i6=1,2
            ch56(i5,i6)=czero
          enddo
        enddo
      endif
* quqd -- p=p7,q=p8
      quqd=p7(0)*p8(0)-p7(1)*p8(1)-p7(2)*p8(2)-p7(3)*p8(3)
      s78=2.d0*quqd+rmass2(id7)+rmass2(id8)
      ccr=zcr(id7)/(-s78+cmz2)
      ccl=zcl(id7)/(-s78+cmz2)
* T -- qu=p7,qd=p8,v=0,a=clinet_mu(0).a,b=clinet_mu(0).b,c=clinet_mu(0).
* c,d=clinet_mu(0).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p7(2)*p8(3)+p8(2)*p7(3)
      ceps_0=eps_0*cim
      ceps_1=p7(3)*cim
      ceps_2=p8(3)*cim
      auxa=-quqd+p7k0*p8(0)+p8k0*p7(0)
      clinet_mu(0).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(0).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(0).b(1,2)=-ccl*(p8(2)+ceps_2)
      clinet_mu(0).b(2,1)=ccr*(p8(2)-ceps_2)
      clinet_mu(0).c(1,2)=ccr*(p7(2)+ceps_1)
      clinet_mu(0).c(2,1)=ccl*(-p7(2)+ceps_1)
      clinet_mu(0).d(1,1)=ccl
      clinet_mu(0).d(2,2)=ccr
* T -- qu=p7,qd=p8,v=1,a=clinet_mu(1).a,b=clinet_mu(1).b,c=clinet_mu(1).
* c,d=clinet_mu(1).d,cr=ccr,cl=ccl,nsum=0
      auxa=-quqd+p7k0*p8(1)+p8k0*p7(1)
      clinet_mu(1).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(1).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(1).b(1,2)=-ccl*(p8(2)+ceps_2)
      clinet_mu(1).b(2,1)=ccr*(p8(2)-ceps_2)
      clinet_mu(1).c(1,2)=ccr*(p7(2)+ceps_1)
      clinet_mu(1).c(2,1)=ccl*(-p7(2)+ceps_1)
      clinet_mu(1).d(1,1)=ccl
      clinet_mu(1).d(2,2)=ccr
* T -- qu=p7,qd=p8,v=2,a=clinet_mu(2).a,b=clinet_mu(2).b,c=clinet_mu(2).
* c,d=clinet_mu(2).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p7k0*p8(3)+p8k0*p7(3)
      ceps_0=eps_0*cim
      auxa=p7k0*p8(2)+p8k0*p7(2)
      clinet_mu(2).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(2).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(2).b(1,2)=-ccl*p8k0
      clinet_mu(2).b(2,1)=ccr*p8k0
      clinet_mu(2).c(1,2)=ccr*p7k0
      clinet_mu(2).c(2,1)=-ccl*p7k0
* T -- qu=p7,qd=p8,v=3,a=clinet_mu(3).a,b=clinet_mu(3).b,c=clinet_mu(3).
* c,d=clinet_mu(3).d,cr=ccr,cl=ccl,nsum=0
      eps_0=p7k0*p8(2)-p8k0*p7(2)
      ceps_0=eps_0*cim
      ceps_1=p7k0*cim
      ceps_2=p8k0*cim
      auxa=+p7k0*p8(3)+p8k0*p7(3)
      clinet_mu(3).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(3).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(3).b(1,2)=-ccl*ceps_2
      clinet_mu(3).b(2,1)=-ccr*ceps_2
      clinet_mu(3).c(1,2)=ccr*ceps_1
      clinet_mu(3).c(2,1)=ccl*ceps_1
      rmassl=rmass(id7)
      rmassr=-rmassl
      do mu=0,3
* mline -- res=cz78(&1,&2).e(mu),abcd=clinet_mu(mu).,m1=rmassl,m2=rmassr
* ,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cz78(iut,jut).e(mu)=clinet_mu(mu).a(iut,jut)+rmassl*clinet
     & _mu(mu).b(iut,jut)+rmassr*clinet_mu(mu).c(iut,jut)+rmassl
     & *rmassr*clinet_mu(mu).d(iut,jut)
      enddo
      enddo
      end do
  
      if (imass(id7).eq.1) then
        do i1=1,2
          do i2=1,2
* p.q -- p.q=cauxdot,p=p78,q=cz78(i1,i2).e,bef=,aft=
      cauxdot=(p78(0)*cz78(i1,i2).e(0)-p78(1)*cz78(i1,i2).e(1)-p
     & 78(2)*cz78(i1,i2).e(2)-p78(3)*cz78(i1,i2).e(3))
            do mu=0,3
             cz78(i1,i2).e(mu)=cz78(i1,i2).e(mu)-p78(mu)*cauxdot
     &             /cmz2
            enddo
          enddo
        enddo
      endif
      do i1=1,2
      do i2=1,2
* pk0 -- p=cz78(i1,i2).e
      cz78(i1,i2).ek0=cz78(i1,i2).e(0)-cz78(i1,i2).e(1)
      end do
      end do
      ccr=fcr(id7)/(-s78)
      ccl=fcl(id7)/(-s78)
* T -- qu=p7,qd=p8,v=0,a=clinet_mu(0).a,b=clinet_mu(0).b,c=clinet_mu(0).
* c,d=clinet_mu(0).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p7(2)*p8(3)+p8(2)*p7(3)
      ceps_0=eps_0*cim
      ceps_1=p7(3)*cim
      ceps_2=p8(3)*cim
      auxa=-quqd+p7k0*p8(0)+p8k0*p7(0)
      clinet_mu(0).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(0).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(0).b(1,2)=-ccl*(p8(2)+ceps_2)
      clinet_mu(0).b(2,1)=ccr*(p8(2)-ceps_2)
      clinet_mu(0).c(1,2)=ccr*(p7(2)+ceps_1)
      clinet_mu(0).c(2,1)=ccl*(-p7(2)+ceps_1)
      clinet_mu(0).d(1,1)=ccl
      clinet_mu(0).d(2,2)=ccr
* T -- qu=p7,qd=p8,v=1,a=clinet_mu(1).a,b=clinet_mu(1).b,c=clinet_mu(1).
* c,d=clinet_mu(1).d,cr=ccr,cl=ccl,nsum=0
      auxa=-quqd+p7k0*p8(1)+p8k0*p7(1)
      clinet_mu(1).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(1).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(1).b(1,2)=-ccl*(p8(2)+ceps_2)
      clinet_mu(1).b(2,1)=ccr*(p8(2)-ceps_2)
      clinet_mu(1).c(1,2)=ccr*(p7(2)+ceps_1)
      clinet_mu(1).c(2,1)=ccl*(-p7(2)+ceps_1)
      clinet_mu(1).d(1,1)=ccl
      clinet_mu(1).d(2,2)=ccr
* T -- qu=p7,qd=p8,v=2,a=clinet_mu(2).a,b=clinet_mu(2).b,c=clinet_mu(2).
* c,d=clinet_mu(2).d,cr=ccr,cl=ccl,nsum=0
      eps_0=-p7k0*p8(3)+p8k0*p7(3)
      ceps_0=eps_0*cim
      auxa=p7k0*p8(2)+p8k0*p7(2)
      clinet_mu(2).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(2).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(2).b(1,2)=-ccl*p8k0
      clinet_mu(2).b(2,1)=ccr*p8k0
      clinet_mu(2).c(1,2)=ccr*p7k0
      clinet_mu(2).c(2,1)=-ccl*p7k0
* T -- qu=p7,qd=p8,v=3,a=clinet_mu(3).a,b=clinet_mu(3).b,c=clinet_mu(3).
* c,d=clinet_mu(3).d,cr=ccr,cl=ccl,nsum=0
      eps_0=p7k0*p8(2)-p8k0*p7(2)
      ceps_0=eps_0*cim
      ceps_1=p7k0*cim
      ceps_2=p8k0*cim
      auxa=+p7k0*p8(3)+p8k0*p7(3)
      clinet_mu(3).a(1,1)=ccr*(auxa+ceps_0)
      clinet_mu(3).a(2,2)=ccl*(auxa-ceps_0)
      clinet_mu(3).b(1,2)=-ccl*ceps_2
      clinet_mu(3).b(2,1)=-ccr*ceps_2
      clinet_mu(3).c(1,2)=ccr*ceps_1
      clinet_mu(3).c(2,1)=ccl*ceps_1
      rmassl=rmass(id7)
      rmassr=-rmassl
      do mu=0,3
* mline -- res=cf78(&1,&2).e(mu),abcd=clinet_mu(mu).,m1=rmassl,m2=rmassr
* ,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cf78(iut,jut).e(mu)=clinet_mu(mu).a(iut,jut)+rmassl*clinet
     & _mu(mu).b(iut,jut)+rmassr*clinet_mu(mu).c(iut,jut)+rmassl
     & *rmassr*clinet_mu(mu).d(iut,jut)
      enddo
      enddo
      end do
  
      do i1=1,2
      do i2=1,2
* pk0 -- p=cf78(i1,i2).e
      cf78(i1,i2).ek0=cf78(i1,i2).e(0)-cf78(i1,i2).e(1)
      end do
      end do
  
*      higgs                                                            
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id7.eq.5.and.rmh.ge.0.d0) then
  
  
  
* TH -- qu=p7,qd=p8,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p7k0*p8(2)+p8k0*p7(2)
      cauxa=auxa-cim*(p8(3)*p7k0-p7(3)*p8k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p8k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p7k0
      clineth.c(2,2)=clineth.c(1,1)
* mline -- res=ch78(&1,&2),abcd=clineth.,m1=rmassl,m2=rmassr,den=0,nsum=
* 0
      do iut=1,2
      do jut=1,2
      ch78(iut,jut)=clineth.a(iut,jut)+rmassl*clineth.b(iut,jut)
     & +rmassr*clineth.c(iut,jut)+rmassl*rmassr*clineth.d(iut,ju
     & t)
      enddo
      enddo
  
  
      else
        do i7=1,2
          do i8=1,2
            ch78(i7,i8)=czero
          enddo
        enddo
      endif
  
  
  
  
* COMPUTE ALL SINGLE INSERTIONS OF THE TYPE LI_ (I=1,3,5,7)  FOR A ZLINE
* AND A Z  GAMMA AND EVENTUALLY HIGGS INSERTION                         
*                                                                       
*        i __                                                           
*            |_Z,f,h_/                                                  
*            |       \                                                  
*                                                                       
*together with its propagator and pk0                                   
      do m=0,3
        p134(m)=p1(m)+p34(m)
      enddo
* pk0 -- p=p134
      p134k0=p134(0)-p134(1)
* p.q -- p.q=p134q,p=p134,q=p134,bef=,aft=
      p134q=(p134(0)*p134(0)-p134(1)*p134(1)-p134(2)*p134(2)-p13
     & 4(3)*p134(3))
  
* quqd -- p=p1,q=p134
      quqd=p1(0)*p134(0)-p1(1)*p134(1)-p1(2)*p134(2)-p1(3)*p134(
     & 3)
      ccr=zcr(id1)/((p134q-rmass2(id1))*p134k0)
      ccl=zcl(id1)/((p134q-rmass2(id1))*p134k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p1,qd=p134,v=cz34(i1,i2).e,a=l1_34(i1,i2).a,b=l1_34(i1,i2).b,c
* =l1_34(i1,i2).c,d=l1_34(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz34(i1,i2).ek0*(p1(2)*p134(3)-p134(2)*p1(3))+p1k0
     & *(cz34(i1,i2).e(2)*p134(3)-p134(2)*cz34(i1,i2).e(3))-p134
     & k0*(cz34(i1,i2).e(2)*p1(3)-p1(2)*cz34(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz34(i1,i2).e(3)*p1k0+p1(3)*cz34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz34(i1,i2).e(3)*p134k0+p134(3)*cz34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz34(i1,i2).e(0)*p1(0)-cz34(i1,i2).e(1)*p1(1)-cz34(i1
     & ,i2).e(2)*p1(2)-cz34(i1,i2).e(3)*p1(3)
      cvqd=cz34(i1,i2).e(0)*p134(0)-cz34(i1,i2).e(1)*p134(1)-cz3
     & 4(i1,i2).e(2)*p134(2)-cz34(i1,i2).e(3)*p134(3)
      cauxa=-cz34(i1,i2).ek0*quqd+p1k0*cvqd+p134k0*cvqu
      cauxb=-cz34(i1,i2).ek0*p134(2)+p134k0*cz34(i1,i2).e(2)
      cauxc=+cz34(i1,i2).ek0*p1(2)-p1k0*cz34(i1,i2).e(2)
      l1_34(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      l1_34(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      l1_34(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      l1_34(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      l1_34(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      l1_34(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      l1_34(i1,i2).d(1,1)=ccl*cz34(i1,i2).ek0
      l1_34(i1,i2).d(2,2)=ccr*cz34(i1,i2).ek0
      end do
      end do
      ccr=fcr(id1)/((p134q-rmass2(id1))*p134k0)
      ccl=fcl(id1)/((p134q-rmass2(id1))*p134k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p1,qd=p134,v=cf34(i1,i2).e,a=l1_34(i1,i2).a,b=l1_34(i1,i2).b,c
* =l1_34(i1,i2).c,d=l1_34(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf34(i1,i2).ek0*(p1(2)*p134(3)-p134(2)*p1(3))+p1k0
     & *(cf34(i1,i2).e(2)*p134(3)-p134(2)*cf34(i1,i2).e(3))-p134
     & k0*(cf34(i1,i2).e(2)*p1(3)-p1(2)*cf34(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf34(i1,i2).e(3)*p1k0+p1(3)*cf34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf34(i1,i2).e(3)*p134k0+p134(3)*cf34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf34(i1,i2).e(0)*p1(0)-cf34(i1,i2).e(1)*p1(1)-cf34(i1
     & ,i2).e(2)*p1(2)-cf34(i1,i2).e(3)*p1(3)
      cvqd=cf34(i1,i2).e(0)*p134(0)-cf34(i1,i2).e(1)*p134(1)-cf3
     & 4(i1,i2).e(2)*p134(2)-cf34(i1,i2).e(3)*p134(3)
      cauxa=-cf34(i1,i2).ek0*quqd+p1k0*cvqd+p134k0*cvqu
      cauxb=-cf34(i1,i2).ek0*p134(2)+p134k0*cf34(i1,i2).e(2)
      cauxc=+cf34(i1,i2).ek0*p1(2)-p1k0*cf34(i1,i2).e(2)
      l1_34(i1,i2).a(1,1)=l1_34(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      l1_34(i1,i2).a(2,2)=l1_34(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      l1_34(i1,i2).b(1,2)=l1_34(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      l1_34(i1,i2).b(2,1)=l1_34(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      l1_34(i1,i2).c(1,2)=l1_34(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      l1_34(i1,i2).c(2,1)=l1_34(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      l1_34(i1,i2).d(1,1)=l1_34(i1,i2).d(1,1)+ccl*cf34(i1,i2).ek
     & 0
      l1_34(i1,i2).d(2,2)=l1_34(i1,i2).d(2,2)+ccr*cf34(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id1.eq.5.and.id3.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p1,qd=p134,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p1k0*p134(2)+p134k0*p1(2)
      cauxa=auxa-cim*(p134(3)*p1k0-p1(3)*p134k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p134k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p1k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s34-cmh2)+rhhbb**2/(s34-cmhh2)
      cfactor= cffactor/((p134q-rmass2(id1))*p134k0)
  
       do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l1_34(i1,i2).a(i3,i4)=ch34(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  l1_34(i1,i2).b(i3,i4)=ch34(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  l1_34(i1,i2).c(i3,i4)=ch34(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l1_34(i1,i2).a(i3,i4)=czero
                else
                  l1_34(i1,i2).b(i3,i4)=czero
                  l1_34(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
      do m=0,3
        p156(m)=p1(m)+p56(m)
      enddo
* pk0 -- p=p156
      p156k0=p156(0)-p156(1)
* p.q -- p.q=p156q,p=p156,q=p156,bef=,aft=
      p156q=(p156(0)*p156(0)-p156(1)*p156(1)-p156(2)*p156(2)-p15
     & 6(3)*p156(3))
  
* quqd -- p=p1,q=p156
      quqd=p1(0)*p156(0)-p1(1)*p156(1)-p1(2)*p156(2)-p1(3)*p156(
     & 3)
      ccr=zcr(id1)/((p156q-rmass2(id1))*p156k0)
      ccl=zcl(id1)/((p156q-rmass2(id1))*p156k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p1,qd=p156,v=cz56(i1,i2).e,a=l1_56(i1,i2).a,b=l1_56(i1,i2).b,c
* =l1_56(i1,i2).c,d=l1_56(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz56(i1,i2).ek0*(p1(2)*p156(3)-p156(2)*p1(3))+p1k0
     & *(cz56(i1,i2).e(2)*p156(3)-p156(2)*cz56(i1,i2).e(3))-p156
     & k0*(cz56(i1,i2).e(2)*p1(3)-p1(2)*cz56(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz56(i1,i2).e(3)*p1k0+p1(3)*cz56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz56(i1,i2).e(3)*p156k0+p156(3)*cz56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz56(i1,i2).e(0)*p1(0)-cz56(i1,i2).e(1)*p1(1)-cz56(i1
     & ,i2).e(2)*p1(2)-cz56(i1,i2).e(3)*p1(3)
      cvqd=cz56(i1,i2).e(0)*p156(0)-cz56(i1,i2).e(1)*p156(1)-cz5
     & 6(i1,i2).e(2)*p156(2)-cz56(i1,i2).e(3)*p156(3)
      cauxa=-cz56(i1,i2).ek0*quqd+p1k0*cvqd+p156k0*cvqu
      cauxb=-cz56(i1,i2).ek0*p156(2)+p156k0*cz56(i1,i2).e(2)
      cauxc=+cz56(i1,i2).ek0*p1(2)-p1k0*cz56(i1,i2).e(2)
      l1_56(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      l1_56(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      l1_56(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      l1_56(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      l1_56(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      l1_56(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      l1_56(i1,i2).d(1,1)=ccl*cz56(i1,i2).ek0
      l1_56(i1,i2).d(2,2)=ccr*cz56(i1,i2).ek0
      end do
      end do
      ccr=fcr(id1)/((p156q-rmass2(id1))*p156k0)
      ccl=fcl(id1)/((p156q-rmass2(id1))*p156k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p1,qd=p156,v=cf56(i1,i2).e,a=l1_56(i1,i2).a,b=l1_56(i1,i2).b,c
* =l1_56(i1,i2).c,d=l1_56(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf56(i1,i2).ek0*(p1(2)*p156(3)-p156(2)*p1(3))+p1k0
     & *(cf56(i1,i2).e(2)*p156(3)-p156(2)*cf56(i1,i2).e(3))-p156
     & k0*(cf56(i1,i2).e(2)*p1(3)-p1(2)*cf56(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf56(i1,i2).e(3)*p1k0+p1(3)*cf56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf56(i1,i2).e(3)*p156k0+p156(3)*cf56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf56(i1,i2).e(0)*p1(0)-cf56(i1,i2).e(1)*p1(1)-cf56(i1
     & ,i2).e(2)*p1(2)-cf56(i1,i2).e(3)*p1(3)
      cvqd=cf56(i1,i2).e(0)*p156(0)-cf56(i1,i2).e(1)*p156(1)-cf5
     & 6(i1,i2).e(2)*p156(2)-cf56(i1,i2).e(3)*p156(3)
      cauxa=-cf56(i1,i2).ek0*quqd+p1k0*cvqd+p156k0*cvqu
      cauxb=-cf56(i1,i2).ek0*p156(2)+p156k0*cf56(i1,i2).e(2)
      cauxc=+cf56(i1,i2).ek0*p1(2)-p1k0*cf56(i1,i2).e(2)
      l1_56(i1,i2).a(1,1)=l1_56(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      l1_56(i1,i2).a(2,2)=l1_56(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      l1_56(i1,i2).b(1,2)=l1_56(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      l1_56(i1,i2).b(2,1)=l1_56(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      l1_56(i1,i2).c(1,2)=l1_56(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      l1_56(i1,i2).c(2,1)=l1_56(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      l1_56(i1,i2).d(1,1)=l1_56(i1,i2).d(1,1)+ccl*cf56(i1,i2).ek
     & 0
      l1_56(i1,i2).d(2,2)=l1_56(i1,i2).d(2,2)+ccr*cf56(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id1.eq.5.and.id5.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p1,qd=p156,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p1k0*p156(2)+p156k0*p1(2)
      cauxa=auxa-cim*(p156(3)*p1k0-p1(3)*p156k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p156k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p1k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s56-cmh2)+rhhbb**2/(s56-cmhh2)
      cfactor= cffactor/((p156q-rmass2(id1))*p156k0)
  
       do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l1_56(i1,i2).a(i3,i4)=ch56(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  l1_56(i1,i2).b(i3,i4)=ch56(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  l1_56(i1,i2).c(i3,i4)=ch56(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l1_56(i1,i2).a(i3,i4)=czero
                else
                  l1_56(i1,i2).b(i3,i4)=czero
                  l1_56(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
      do m=0,3
        p178(m)=p1(m)+p78(m)
      enddo
* pk0 -- p=p178
      p178k0=p178(0)-p178(1)
* p.q -- p.q=p178q,p=p178,q=p178,bef=,aft=
      p178q=(p178(0)*p178(0)-p178(1)*p178(1)-p178(2)*p178(2)-p17
     & 8(3)*p178(3))
  
* quqd -- p=p1,q=p178
      quqd=p1(0)*p178(0)-p1(1)*p178(1)-p1(2)*p178(2)-p1(3)*p178(
     & 3)
      ccr=zcr(id1)/((p178q-rmass2(id1))*p178k0)
      ccl=zcl(id1)/((p178q-rmass2(id1))*p178k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p1,qd=p178,v=cz78(i1,i2).e,a=l1_78(i1,i2).a,b=l1_78(i1,i2).b,c
* =l1_78(i1,i2).c,d=l1_78(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz78(i1,i2).ek0*(p1(2)*p178(3)-p178(2)*p1(3))+p1k0
     & *(cz78(i1,i2).e(2)*p178(3)-p178(2)*cz78(i1,i2).e(3))-p178
     & k0*(cz78(i1,i2).e(2)*p1(3)-p1(2)*cz78(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz78(i1,i2).e(3)*p1k0+p1(3)*cz78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz78(i1,i2).e(3)*p178k0+p178(3)*cz78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz78(i1,i2).e(0)*p1(0)-cz78(i1,i2).e(1)*p1(1)-cz78(i1
     & ,i2).e(2)*p1(2)-cz78(i1,i2).e(3)*p1(3)
      cvqd=cz78(i1,i2).e(0)*p178(0)-cz78(i1,i2).e(1)*p178(1)-cz7
     & 8(i1,i2).e(2)*p178(2)-cz78(i1,i2).e(3)*p178(3)
      cauxa=-cz78(i1,i2).ek0*quqd+p1k0*cvqd+p178k0*cvqu
      cauxb=-cz78(i1,i2).ek0*p178(2)+p178k0*cz78(i1,i2).e(2)
      cauxc=+cz78(i1,i2).ek0*p1(2)-p1k0*cz78(i1,i2).e(2)
      l1_78(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      l1_78(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      l1_78(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      l1_78(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      l1_78(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      l1_78(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      l1_78(i1,i2).d(1,1)=ccl*cz78(i1,i2).ek0
      l1_78(i1,i2).d(2,2)=ccr*cz78(i1,i2).ek0
      end do
      end do
      ccr=fcr(id1)/((p178q-rmass2(id1))*p178k0)
      ccl=fcl(id1)/((p178q-rmass2(id1))*p178k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p1,qd=p178,v=cf78(i1,i2).e,a=l1_78(i1,i2).a,b=l1_78(i1,i2).b,c
* =l1_78(i1,i2).c,d=l1_78(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf78(i1,i2).ek0*(p1(2)*p178(3)-p178(2)*p1(3))+p1k0
     & *(cf78(i1,i2).e(2)*p178(3)-p178(2)*cf78(i1,i2).e(3))-p178
     & k0*(cf78(i1,i2).e(2)*p1(3)-p1(2)*cf78(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf78(i1,i2).e(3)*p1k0+p1(3)*cf78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf78(i1,i2).e(3)*p178k0+p178(3)*cf78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf78(i1,i2).e(0)*p1(0)-cf78(i1,i2).e(1)*p1(1)-cf78(i1
     & ,i2).e(2)*p1(2)-cf78(i1,i2).e(3)*p1(3)
      cvqd=cf78(i1,i2).e(0)*p178(0)-cf78(i1,i2).e(1)*p178(1)-cf7
     & 8(i1,i2).e(2)*p178(2)-cf78(i1,i2).e(3)*p178(3)
      cauxa=-cf78(i1,i2).ek0*quqd+p1k0*cvqd+p178k0*cvqu
      cauxb=-cf78(i1,i2).ek0*p178(2)+p178k0*cf78(i1,i2).e(2)
      cauxc=+cf78(i1,i2).ek0*p1(2)-p1k0*cf78(i1,i2).e(2)
      l1_78(i1,i2).a(1,1)=l1_78(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      l1_78(i1,i2).a(2,2)=l1_78(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      l1_78(i1,i2).b(1,2)=l1_78(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      l1_78(i1,i2).b(2,1)=l1_78(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      l1_78(i1,i2).c(1,2)=l1_78(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      l1_78(i1,i2).c(2,1)=l1_78(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      l1_78(i1,i2).d(1,1)=l1_78(i1,i2).d(1,1)+ccl*cf78(i1,i2).ek
     & 0
      l1_78(i1,i2).d(2,2)=l1_78(i1,i2).d(2,2)+ccr*cf78(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id1.eq.5.and.id7.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p1,qd=p178,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p1k0*p178(2)+p178k0*p1(2)
      cauxa=auxa-cim*(p178(3)*p1k0-p1(3)*p178k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p178k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p1k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s78-cmh2)+rhhbb**2/(s78-cmhh2)
      cfactor= cffactor/((p178q-rmass2(id1))*p178k0)
  
       do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l1_78(i1,i2).a(i3,i4)=ch78(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  l1_78(i1,i2).b(i3,i4)=ch78(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  l1_78(i1,i2).c(i3,i4)=ch78(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l1_78(i1,i2).a(i3,i4)=czero
                else
                  l1_78(i1,i2).b(i3,i4)=czero
                  l1_78(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
      do m=0,3
        p312(m)=p3(m)+p12(m)
      enddo
* pk0 -- p=p312
      p312k0=p312(0)-p312(1)
* p.q -- p.q=p312q,p=p312,q=p312,bef=,aft=
      p312q=(p312(0)*p312(0)-p312(1)*p312(1)-p312(2)*p312(2)-p31
     & 2(3)*p312(3))
  
* quqd -- p=p3,q=p312
      quqd=p3(0)*p312(0)-p3(1)*p312(1)-p3(2)*p312(2)-p3(3)*p312(
     & 3)
      ccr=zcr(id3)/((p312q-rmass2(id3))*p312k0)
      ccl=zcl(id3)/((p312q-rmass2(id3))*p312k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p3,qd=p312,v=cz12(i1,i2).e,a=l3_12(i1,i2).a,b=l3_12(i1,i2).b,c
* =l3_12(i1,i2).c,d=l3_12(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz12(i1,i2).ek0*(p3(2)*p312(3)-p312(2)*p3(3))+p3k0
     & *(cz12(i1,i2).e(2)*p312(3)-p312(2)*cz12(i1,i2).e(3))-p312
     & k0*(cz12(i1,i2).e(2)*p3(3)-p3(2)*cz12(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz12(i1,i2).e(3)*p3k0+p3(3)*cz12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz12(i1,i2).e(3)*p312k0+p312(3)*cz12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz12(i1,i2).e(0)*p3(0)-cz12(i1,i2).e(1)*p3(1)-cz12(i1
     & ,i2).e(2)*p3(2)-cz12(i1,i2).e(3)*p3(3)
      cvqd=cz12(i1,i2).e(0)*p312(0)-cz12(i1,i2).e(1)*p312(1)-cz1
     & 2(i1,i2).e(2)*p312(2)-cz12(i1,i2).e(3)*p312(3)
      cauxa=-cz12(i1,i2).ek0*quqd+p3k0*cvqd+p312k0*cvqu
      cauxb=-cz12(i1,i2).ek0*p312(2)+p312k0*cz12(i1,i2).e(2)
      cauxc=+cz12(i1,i2).ek0*p3(2)-p3k0*cz12(i1,i2).e(2)
      l3_12(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      l3_12(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      l3_12(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      l3_12(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      l3_12(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      l3_12(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      l3_12(i1,i2).d(1,1)=ccl*cz12(i1,i2).ek0
      l3_12(i1,i2).d(2,2)=ccr*cz12(i1,i2).ek0
      end do
      end do
      ccr=fcr(id3)/((p312q-rmass2(id3))*p312k0)
      ccl=fcl(id3)/((p312q-rmass2(id3))*p312k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p3,qd=p312,v=cf12(i1,i2).e,a=l3_12(i1,i2).a,b=l3_12(i1,i2).b,c
* =l3_12(i1,i2).c,d=l3_12(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf12(i1,i2).ek0*(p3(2)*p312(3)-p312(2)*p3(3))+p3k0
     & *(cf12(i1,i2).e(2)*p312(3)-p312(2)*cf12(i1,i2).e(3))-p312
     & k0*(cf12(i1,i2).e(2)*p3(3)-p3(2)*cf12(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf12(i1,i2).e(3)*p3k0+p3(3)*cf12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf12(i1,i2).e(3)*p312k0+p312(3)*cf12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf12(i1,i2).e(0)*p3(0)-cf12(i1,i2).e(1)*p3(1)-cf12(i1
     & ,i2).e(2)*p3(2)-cf12(i1,i2).e(3)*p3(3)
      cvqd=cf12(i1,i2).e(0)*p312(0)-cf12(i1,i2).e(1)*p312(1)-cf1
     & 2(i1,i2).e(2)*p312(2)-cf12(i1,i2).e(3)*p312(3)
      cauxa=-cf12(i1,i2).ek0*quqd+p3k0*cvqd+p312k0*cvqu
      cauxb=-cf12(i1,i2).ek0*p312(2)+p312k0*cf12(i1,i2).e(2)
      cauxc=+cf12(i1,i2).ek0*p3(2)-p3k0*cf12(i1,i2).e(2)
      l3_12(i1,i2).a(1,1)=l3_12(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      l3_12(i1,i2).a(2,2)=l3_12(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      l3_12(i1,i2).b(1,2)=l3_12(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      l3_12(i1,i2).b(2,1)=l3_12(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      l3_12(i1,i2).c(1,2)=l3_12(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      l3_12(i1,i2).c(2,1)=l3_12(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      l3_12(i1,i2).d(1,1)=l3_12(i1,i2).d(1,1)+ccl*cf12(i1,i2).ek
     & 0
      l3_12(i1,i2).d(2,2)=l3_12(i1,i2).d(2,2)+ccr*cf12(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id3.eq.5.and.id1.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p3,qd=p312,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p3k0*p312(2)+p312k0*p3(2)
      cauxa=auxa-cim*(p312(3)*p3k0-p3(3)*p312k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p312k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p3k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s12-cmh2)+rhhbb**2/(s12-cmhh2)
      cfactor= cffactor/((p312q-rmass2(id3))*p312k0)
  
       do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l3_12(i1,i2).a(i3,i4)=ch12(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  l3_12(i1,i2).b(i3,i4)=ch12(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  l3_12(i1,i2).c(i3,i4)=ch12(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l3_12(i1,i2).a(i3,i4)=czero
                else
                  l3_12(i1,i2).b(i3,i4)=czero
                  l3_12(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
      do m=0,3
        p356(m)=p3(m)+p56(m)
      enddo
* pk0 -- p=p356
      p356k0=p356(0)-p356(1)
* p.q -- p.q=p356q,p=p356,q=p356,bef=,aft=
      p356q=(p356(0)*p356(0)-p356(1)*p356(1)-p356(2)*p356(2)-p35
     & 6(3)*p356(3))
  
* quqd -- p=p3,q=p356
      quqd=p3(0)*p356(0)-p3(1)*p356(1)-p3(2)*p356(2)-p3(3)*p356(
     & 3)
      ccr=zcr(id3)/((p356q-rmass2(id3))*p356k0)
      ccl=zcl(id3)/((p356q-rmass2(id3))*p356k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p3,qd=p356,v=cz56(i1,i2).e,a=l3_56(i1,i2).a,b=l3_56(i1,i2).b,c
* =l3_56(i1,i2).c,d=l3_56(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz56(i1,i2).ek0*(p3(2)*p356(3)-p356(2)*p3(3))+p3k0
     & *(cz56(i1,i2).e(2)*p356(3)-p356(2)*cz56(i1,i2).e(3))-p356
     & k0*(cz56(i1,i2).e(2)*p3(3)-p3(2)*cz56(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz56(i1,i2).e(3)*p3k0+p3(3)*cz56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz56(i1,i2).e(3)*p356k0+p356(3)*cz56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz56(i1,i2).e(0)*p3(0)-cz56(i1,i2).e(1)*p3(1)-cz56(i1
     & ,i2).e(2)*p3(2)-cz56(i1,i2).e(3)*p3(3)
      cvqd=cz56(i1,i2).e(0)*p356(0)-cz56(i1,i2).e(1)*p356(1)-cz5
     & 6(i1,i2).e(2)*p356(2)-cz56(i1,i2).e(3)*p356(3)
      cauxa=-cz56(i1,i2).ek0*quqd+p3k0*cvqd+p356k0*cvqu
      cauxb=-cz56(i1,i2).ek0*p356(2)+p356k0*cz56(i1,i2).e(2)
      cauxc=+cz56(i1,i2).ek0*p3(2)-p3k0*cz56(i1,i2).e(2)
      l3_56(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      l3_56(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      l3_56(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      l3_56(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      l3_56(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      l3_56(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      l3_56(i1,i2).d(1,1)=ccl*cz56(i1,i2).ek0
      l3_56(i1,i2).d(2,2)=ccr*cz56(i1,i2).ek0
      end do
      end do
      ccr=fcr(id3)/((p356q-rmass2(id3))*p356k0)
      ccl=fcl(id3)/((p356q-rmass2(id3))*p356k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p3,qd=p356,v=cf56(i1,i2).e,a=l3_56(i1,i2).a,b=l3_56(i1,i2).b,c
* =l3_56(i1,i2).c,d=l3_56(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf56(i1,i2).ek0*(p3(2)*p356(3)-p356(2)*p3(3))+p3k0
     & *(cf56(i1,i2).e(2)*p356(3)-p356(2)*cf56(i1,i2).e(3))-p356
     & k0*(cf56(i1,i2).e(2)*p3(3)-p3(2)*cf56(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf56(i1,i2).e(3)*p3k0+p3(3)*cf56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf56(i1,i2).e(3)*p356k0+p356(3)*cf56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf56(i1,i2).e(0)*p3(0)-cf56(i1,i2).e(1)*p3(1)-cf56(i1
     & ,i2).e(2)*p3(2)-cf56(i1,i2).e(3)*p3(3)
      cvqd=cf56(i1,i2).e(0)*p356(0)-cf56(i1,i2).e(1)*p356(1)-cf5
     & 6(i1,i2).e(2)*p356(2)-cf56(i1,i2).e(3)*p356(3)
      cauxa=-cf56(i1,i2).ek0*quqd+p3k0*cvqd+p356k0*cvqu
      cauxb=-cf56(i1,i2).ek0*p356(2)+p356k0*cf56(i1,i2).e(2)
      cauxc=+cf56(i1,i2).ek0*p3(2)-p3k0*cf56(i1,i2).e(2)
      l3_56(i1,i2).a(1,1)=l3_56(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      l3_56(i1,i2).a(2,2)=l3_56(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      l3_56(i1,i2).b(1,2)=l3_56(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      l3_56(i1,i2).b(2,1)=l3_56(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      l3_56(i1,i2).c(1,2)=l3_56(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      l3_56(i1,i2).c(2,1)=l3_56(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      l3_56(i1,i2).d(1,1)=l3_56(i1,i2).d(1,1)+ccl*cf56(i1,i2).ek
     & 0
      l3_56(i1,i2).d(2,2)=l3_56(i1,i2).d(2,2)+ccr*cf56(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id3.eq.5.and.id5.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p3,qd=p356,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p3k0*p356(2)+p356k0*p3(2)
      cauxa=auxa-cim*(p356(3)*p3k0-p3(3)*p356k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p356k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p3k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s56-cmh2)+rhhbb**2/(s56-cmhh2)
      cfactor= cffactor/((p356q-rmass2(id3))*p356k0)
  
       do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l3_56(i1,i2).a(i3,i4)=ch56(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  l3_56(i1,i2).b(i3,i4)=ch56(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  l3_56(i1,i2).c(i3,i4)=ch56(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l3_56(i1,i2).a(i3,i4)=czero
                else
                  l3_56(i1,i2).b(i3,i4)=czero
                  l3_56(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
      do m=0,3
        p378(m)=p3(m)+p78(m)
      enddo
* pk0 -- p=p378
      p378k0=p378(0)-p378(1)
* p.q -- p.q=p378q,p=p378,q=p378,bef=,aft=
      p378q=(p378(0)*p378(0)-p378(1)*p378(1)-p378(2)*p378(2)-p37
     & 8(3)*p378(3))
  
* quqd -- p=p3,q=p378
      quqd=p3(0)*p378(0)-p3(1)*p378(1)-p3(2)*p378(2)-p3(3)*p378(
     & 3)
      ccr=zcr(id3)/((p378q-rmass2(id3))*p378k0)
      ccl=zcl(id3)/((p378q-rmass2(id3))*p378k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p3,qd=p378,v=cz78(i1,i2).e,a=l3_78(i1,i2).a,b=l3_78(i1,i2).b,c
* =l3_78(i1,i2).c,d=l3_78(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz78(i1,i2).ek0*(p3(2)*p378(3)-p378(2)*p3(3))+p3k0
     & *(cz78(i1,i2).e(2)*p378(3)-p378(2)*cz78(i1,i2).e(3))-p378
     & k0*(cz78(i1,i2).e(2)*p3(3)-p3(2)*cz78(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz78(i1,i2).e(3)*p3k0+p3(3)*cz78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz78(i1,i2).e(3)*p378k0+p378(3)*cz78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz78(i1,i2).e(0)*p3(0)-cz78(i1,i2).e(1)*p3(1)-cz78(i1
     & ,i2).e(2)*p3(2)-cz78(i1,i2).e(3)*p3(3)
      cvqd=cz78(i1,i2).e(0)*p378(0)-cz78(i1,i2).e(1)*p378(1)-cz7
     & 8(i1,i2).e(2)*p378(2)-cz78(i1,i2).e(3)*p378(3)
      cauxa=-cz78(i1,i2).ek0*quqd+p3k0*cvqd+p378k0*cvqu
      cauxb=-cz78(i1,i2).ek0*p378(2)+p378k0*cz78(i1,i2).e(2)
      cauxc=+cz78(i1,i2).ek0*p3(2)-p3k0*cz78(i1,i2).e(2)
      l3_78(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      l3_78(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      l3_78(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      l3_78(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      l3_78(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      l3_78(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      l3_78(i1,i2).d(1,1)=ccl*cz78(i1,i2).ek0
      l3_78(i1,i2).d(2,2)=ccr*cz78(i1,i2).ek0
      end do
      end do
      ccr=fcr(id3)/((p378q-rmass2(id3))*p378k0)
      ccl=fcl(id3)/((p378q-rmass2(id3))*p378k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p3,qd=p378,v=cf78(i1,i2).e,a=l3_78(i1,i2).a,b=l3_78(i1,i2).b,c
* =l3_78(i1,i2).c,d=l3_78(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf78(i1,i2).ek0*(p3(2)*p378(3)-p378(2)*p3(3))+p3k0
     & *(cf78(i1,i2).e(2)*p378(3)-p378(2)*cf78(i1,i2).e(3))-p378
     & k0*(cf78(i1,i2).e(2)*p3(3)-p3(2)*cf78(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf78(i1,i2).e(3)*p3k0+p3(3)*cf78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf78(i1,i2).e(3)*p378k0+p378(3)*cf78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf78(i1,i2).e(0)*p3(0)-cf78(i1,i2).e(1)*p3(1)-cf78(i1
     & ,i2).e(2)*p3(2)-cf78(i1,i2).e(3)*p3(3)
      cvqd=cf78(i1,i2).e(0)*p378(0)-cf78(i1,i2).e(1)*p378(1)-cf7
     & 8(i1,i2).e(2)*p378(2)-cf78(i1,i2).e(3)*p378(3)
      cauxa=-cf78(i1,i2).ek0*quqd+p3k0*cvqd+p378k0*cvqu
      cauxb=-cf78(i1,i2).ek0*p378(2)+p378k0*cf78(i1,i2).e(2)
      cauxc=+cf78(i1,i2).ek0*p3(2)-p3k0*cf78(i1,i2).e(2)
      l3_78(i1,i2).a(1,1)=l3_78(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      l3_78(i1,i2).a(2,2)=l3_78(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      l3_78(i1,i2).b(1,2)=l3_78(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      l3_78(i1,i2).b(2,1)=l3_78(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      l3_78(i1,i2).c(1,2)=l3_78(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      l3_78(i1,i2).c(2,1)=l3_78(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      l3_78(i1,i2).d(1,1)=l3_78(i1,i2).d(1,1)+ccl*cf78(i1,i2).ek
     & 0
      l3_78(i1,i2).d(2,2)=l3_78(i1,i2).d(2,2)+ccr*cf78(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id3.eq.5.and.id7.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p3,qd=p378,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p3k0*p378(2)+p378k0*p3(2)
      cauxa=auxa-cim*(p378(3)*p3k0-p3(3)*p378k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p378k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p3k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s78-cmh2)+rhhbb**2/(s78-cmhh2)
      cfactor= cffactor/((p378q-rmass2(id3))*p378k0)
  
       do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l3_78(i1,i2).a(i3,i4)=ch78(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  l3_78(i1,i2).b(i3,i4)=ch78(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  l3_78(i1,i2).c(i3,i4)=ch78(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l3_78(i1,i2).a(i3,i4)=czero
                else
                  l3_78(i1,i2).b(i3,i4)=czero
                  l3_78(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
      do m=0,3
        p512(m)=p5(m)+p12(m)
      enddo
* pk0 -- p=p512
      p512k0=p512(0)-p512(1)
* p.q -- p.q=p512q,p=p512,q=p512,bef=,aft=
      p512q=(p512(0)*p512(0)-p512(1)*p512(1)-p512(2)*p512(2)-p51
     & 2(3)*p512(3))
  
* quqd -- p=p5,q=p512
      quqd=p5(0)*p512(0)-p5(1)*p512(1)-p5(2)*p512(2)-p5(3)*p512(
     & 3)
      ccr=zcr(id5)/((p512q-rmass2(id5))*p512k0)
      ccl=zcl(id5)/((p512q-rmass2(id5))*p512k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p5,qd=p512,v=cz12(i1,i2).e,a=l5_12(i1,i2).a,b=l5_12(i1,i2).b,c
* =l5_12(i1,i2).c,d=l5_12(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz12(i1,i2).ek0*(p5(2)*p512(3)-p512(2)*p5(3))+p5k0
     & *(cz12(i1,i2).e(2)*p512(3)-p512(2)*cz12(i1,i2).e(3))-p512
     & k0*(cz12(i1,i2).e(2)*p5(3)-p5(2)*cz12(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz12(i1,i2).e(3)*p5k0+p5(3)*cz12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz12(i1,i2).e(3)*p512k0+p512(3)*cz12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz12(i1,i2).e(0)*p5(0)-cz12(i1,i2).e(1)*p5(1)-cz12(i1
     & ,i2).e(2)*p5(2)-cz12(i1,i2).e(3)*p5(3)
      cvqd=cz12(i1,i2).e(0)*p512(0)-cz12(i1,i2).e(1)*p512(1)-cz1
     & 2(i1,i2).e(2)*p512(2)-cz12(i1,i2).e(3)*p512(3)
      cauxa=-cz12(i1,i2).ek0*quqd+p5k0*cvqd+p512k0*cvqu
      cauxb=-cz12(i1,i2).ek0*p512(2)+p512k0*cz12(i1,i2).e(2)
      cauxc=+cz12(i1,i2).ek0*p5(2)-p5k0*cz12(i1,i2).e(2)
      l5_12(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      l5_12(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      l5_12(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      l5_12(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      l5_12(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      l5_12(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      l5_12(i1,i2).d(1,1)=ccl*cz12(i1,i2).ek0
      l5_12(i1,i2).d(2,2)=ccr*cz12(i1,i2).ek0
      end do
      end do
      ccr=fcr(id5)/((p512q-rmass2(id5))*p512k0)
      ccl=fcl(id5)/((p512q-rmass2(id5))*p512k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p5,qd=p512,v=cf12(i1,i2).e,a=l5_12(i1,i2).a,b=l5_12(i1,i2).b,c
* =l5_12(i1,i2).c,d=l5_12(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf12(i1,i2).ek0*(p5(2)*p512(3)-p512(2)*p5(3))+p5k0
     & *(cf12(i1,i2).e(2)*p512(3)-p512(2)*cf12(i1,i2).e(3))-p512
     & k0*(cf12(i1,i2).e(2)*p5(3)-p5(2)*cf12(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf12(i1,i2).e(3)*p5k0+p5(3)*cf12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf12(i1,i2).e(3)*p512k0+p512(3)*cf12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf12(i1,i2).e(0)*p5(0)-cf12(i1,i2).e(1)*p5(1)-cf12(i1
     & ,i2).e(2)*p5(2)-cf12(i1,i2).e(3)*p5(3)
      cvqd=cf12(i1,i2).e(0)*p512(0)-cf12(i1,i2).e(1)*p512(1)-cf1
     & 2(i1,i2).e(2)*p512(2)-cf12(i1,i2).e(3)*p512(3)
      cauxa=-cf12(i1,i2).ek0*quqd+p5k0*cvqd+p512k0*cvqu
      cauxb=-cf12(i1,i2).ek0*p512(2)+p512k0*cf12(i1,i2).e(2)
      cauxc=+cf12(i1,i2).ek0*p5(2)-p5k0*cf12(i1,i2).e(2)
      l5_12(i1,i2).a(1,1)=l5_12(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      l5_12(i1,i2).a(2,2)=l5_12(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      l5_12(i1,i2).b(1,2)=l5_12(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      l5_12(i1,i2).b(2,1)=l5_12(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      l5_12(i1,i2).c(1,2)=l5_12(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      l5_12(i1,i2).c(2,1)=l5_12(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      l5_12(i1,i2).d(1,1)=l5_12(i1,i2).d(1,1)+ccl*cf12(i1,i2).ek
     & 0
      l5_12(i1,i2).d(2,2)=l5_12(i1,i2).d(2,2)+ccr*cf12(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id5.eq.5.and.id1.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p5,qd=p512,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p5k0*p512(2)+p512k0*p5(2)
      cauxa=auxa-cim*(p512(3)*p5k0-p5(3)*p512k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p512k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p5k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s12-cmh2)+rhhbb**2/(s12-cmhh2)
      cfactor= cffactor/((p512q-rmass2(id5))*p512k0)
  
       do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l5_12(i1,i2).a(i3,i4)=ch12(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  l5_12(i1,i2).b(i3,i4)=ch12(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  l5_12(i1,i2).c(i3,i4)=ch12(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l5_12(i1,i2).a(i3,i4)=czero
                else
                  l5_12(i1,i2).b(i3,i4)=czero
                  l5_12(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
      do m=0,3
        p534(m)=p5(m)+p34(m)
      enddo
* pk0 -- p=p534
      p534k0=p534(0)-p534(1)
* p.q -- p.q=p534q,p=p534,q=p534,bef=,aft=
      p534q=(p534(0)*p534(0)-p534(1)*p534(1)-p534(2)*p534(2)-p53
     & 4(3)*p534(3))
  
* quqd -- p=p5,q=p534
      quqd=p5(0)*p534(0)-p5(1)*p534(1)-p5(2)*p534(2)-p5(3)*p534(
     & 3)
      ccr=zcr(id5)/((p534q-rmass2(id5))*p534k0)
      ccl=zcl(id5)/((p534q-rmass2(id5))*p534k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p5,qd=p534,v=cz34(i1,i2).e,a=l5_34(i1,i2).a,b=l5_34(i1,i2).b,c
* =l5_34(i1,i2).c,d=l5_34(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz34(i1,i2).ek0*(p5(2)*p534(3)-p534(2)*p5(3))+p5k0
     & *(cz34(i1,i2).e(2)*p534(3)-p534(2)*cz34(i1,i2).e(3))-p534
     & k0*(cz34(i1,i2).e(2)*p5(3)-p5(2)*cz34(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz34(i1,i2).e(3)*p5k0+p5(3)*cz34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz34(i1,i2).e(3)*p534k0+p534(3)*cz34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz34(i1,i2).e(0)*p5(0)-cz34(i1,i2).e(1)*p5(1)-cz34(i1
     & ,i2).e(2)*p5(2)-cz34(i1,i2).e(3)*p5(3)
      cvqd=cz34(i1,i2).e(0)*p534(0)-cz34(i1,i2).e(1)*p534(1)-cz3
     & 4(i1,i2).e(2)*p534(2)-cz34(i1,i2).e(3)*p534(3)
      cauxa=-cz34(i1,i2).ek0*quqd+p5k0*cvqd+p534k0*cvqu
      cauxb=-cz34(i1,i2).ek0*p534(2)+p534k0*cz34(i1,i2).e(2)
      cauxc=+cz34(i1,i2).ek0*p5(2)-p5k0*cz34(i1,i2).e(2)
      l5_34(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      l5_34(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      l5_34(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      l5_34(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      l5_34(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      l5_34(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      l5_34(i1,i2).d(1,1)=ccl*cz34(i1,i2).ek0
      l5_34(i1,i2).d(2,2)=ccr*cz34(i1,i2).ek0
      end do
      end do
      ccr=fcr(id5)/((p534q-rmass2(id5))*p534k0)
      ccl=fcl(id5)/((p534q-rmass2(id5))*p534k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p5,qd=p534,v=cf34(i1,i2).e,a=l5_34(i1,i2).a,b=l5_34(i1,i2).b,c
* =l5_34(i1,i2).c,d=l5_34(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf34(i1,i2).ek0*(p5(2)*p534(3)-p534(2)*p5(3))+p5k0
     & *(cf34(i1,i2).e(2)*p534(3)-p534(2)*cf34(i1,i2).e(3))-p534
     & k0*(cf34(i1,i2).e(2)*p5(3)-p5(2)*cf34(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf34(i1,i2).e(3)*p5k0+p5(3)*cf34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf34(i1,i2).e(3)*p534k0+p534(3)*cf34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf34(i1,i2).e(0)*p5(0)-cf34(i1,i2).e(1)*p5(1)-cf34(i1
     & ,i2).e(2)*p5(2)-cf34(i1,i2).e(3)*p5(3)
      cvqd=cf34(i1,i2).e(0)*p534(0)-cf34(i1,i2).e(1)*p534(1)-cf3
     & 4(i1,i2).e(2)*p534(2)-cf34(i1,i2).e(3)*p534(3)
      cauxa=-cf34(i1,i2).ek0*quqd+p5k0*cvqd+p534k0*cvqu
      cauxb=-cf34(i1,i2).ek0*p534(2)+p534k0*cf34(i1,i2).e(2)
      cauxc=+cf34(i1,i2).ek0*p5(2)-p5k0*cf34(i1,i2).e(2)
      l5_34(i1,i2).a(1,1)=l5_34(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      l5_34(i1,i2).a(2,2)=l5_34(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      l5_34(i1,i2).b(1,2)=l5_34(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      l5_34(i1,i2).b(2,1)=l5_34(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      l5_34(i1,i2).c(1,2)=l5_34(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      l5_34(i1,i2).c(2,1)=l5_34(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      l5_34(i1,i2).d(1,1)=l5_34(i1,i2).d(1,1)+ccl*cf34(i1,i2).ek
     & 0
      l5_34(i1,i2).d(2,2)=l5_34(i1,i2).d(2,2)+ccr*cf34(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id5.eq.5.and.id3.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p5,qd=p534,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p5k0*p534(2)+p534k0*p5(2)
      cauxa=auxa-cim*(p534(3)*p5k0-p5(3)*p534k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p534k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p5k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s34-cmh2)+rhhbb**2/(s34-cmhh2)
      cfactor= cffactor/((p534q-rmass2(id5))*p534k0)
  
       do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l5_34(i1,i2).a(i3,i4)=ch34(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  l5_34(i1,i2).b(i3,i4)=ch34(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  l5_34(i1,i2).c(i3,i4)=ch34(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l5_34(i1,i2).a(i3,i4)=czero
                else
                  l5_34(i1,i2).b(i3,i4)=czero
                  l5_34(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
      do m=0,3
        p578(m)=p5(m)+p78(m)
      enddo
* pk0 -- p=p578
      p578k0=p578(0)-p578(1)
* p.q -- p.q=p578q,p=p578,q=p578,bef=,aft=
      p578q=(p578(0)*p578(0)-p578(1)*p578(1)-p578(2)*p578(2)-p57
     & 8(3)*p578(3))
  
* quqd -- p=p5,q=p578
      quqd=p5(0)*p578(0)-p5(1)*p578(1)-p5(2)*p578(2)-p5(3)*p578(
     & 3)
      ccr=zcr(id5)/((p578q-rmass2(id5))*p578k0)
      ccl=zcl(id5)/((p578q-rmass2(id5))*p578k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p5,qd=p578,v=cz78(i1,i2).e,a=l5_78(i1,i2).a,b=l5_78(i1,i2).b,c
* =l5_78(i1,i2).c,d=l5_78(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz78(i1,i2).ek0*(p5(2)*p578(3)-p578(2)*p5(3))+p5k0
     & *(cz78(i1,i2).e(2)*p578(3)-p578(2)*cz78(i1,i2).e(3))-p578
     & k0*(cz78(i1,i2).e(2)*p5(3)-p5(2)*cz78(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz78(i1,i2).e(3)*p5k0+p5(3)*cz78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz78(i1,i2).e(3)*p578k0+p578(3)*cz78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz78(i1,i2).e(0)*p5(0)-cz78(i1,i2).e(1)*p5(1)-cz78(i1
     & ,i2).e(2)*p5(2)-cz78(i1,i2).e(3)*p5(3)
      cvqd=cz78(i1,i2).e(0)*p578(0)-cz78(i1,i2).e(1)*p578(1)-cz7
     & 8(i1,i2).e(2)*p578(2)-cz78(i1,i2).e(3)*p578(3)
      cauxa=-cz78(i1,i2).ek0*quqd+p5k0*cvqd+p578k0*cvqu
      cauxb=-cz78(i1,i2).ek0*p578(2)+p578k0*cz78(i1,i2).e(2)
      cauxc=+cz78(i1,i2).ek0*p5(2)-p5k0*cz78(i1,i2).e(2)
      l5_78(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      l5_78(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      l5_78(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      l5_78(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      l5_78(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      l5_78(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      l5_78(i1,i2).d(1,1)=ccl*cz78(i1,i2).ek0
      l5_78(i1,i2).d(2,2)=ccr*cz78(i1,i2).ek0
      end do
      end do
      ccr=fcr(id5)/((p578q-rmass2(id5))*p578k0)
      ccl=fcl(id5)/((p578q-rmass2(id5))*p578k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p5,qd=p578,v=cf78(i1,i2).e,a=l5_78(i1,i2).a,b=l5_78(i1,i2).b,c
* =l5_78(i1,i2).c,d=l5_78(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf78(i1,i2).ek0*(p5(2)*p578(3)-p578(2)*p5(3))+p5k0
     & *(cf78(i1,i2).e(2)*p578(3)-p578(2)*cf78(i1,i2).e(3))-p578
     & k0*(cf78(i1,i2).e(2)*p5(3)-p5(2)*cf78(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf78(i1,i2).e(3)*p5k0+p5(3)*cf78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf78(i1,i2).e(3)*p578k0+p578(3)*cf78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf78(i1,i2).e(0)*p5(0)-cf78(i1,i2).e(1)*p5(1)-cf78(i1
     & ,i2).e(2)*p5(2)-cf78(i1,i2).e(3)*p5(3)
      cvqd=cf78(i1,i2).e(0)*p578(0)-cf78(i1,i2).e(1)*p578(1)-cf7
     & 8(i1,i2).e(2)*p578(2)-cf78(i1,i2).e(3)*p578(3)
      cauxa=-cf78(i1,i2).ek0*quqd+p5k0*cvqd+p578k0*cvqu
      cauxb=-cf78(i1,i2).ek0*p578(2)+p578k0*cf78(i1,i2).e(2)
      cauxc=+cf78(i1,i2).ek0*p5(2)-p5k0*cf78(i1,i2).e(2)
      l5_78(i1,i2).a(1,1)=l5_78(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      l5_78(i1,i2).a(2,2)=l5_78(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      l5_78(i1,i2).b(1,2)=l5_78(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      l5_78(i1,i2).b(2,1)=l5_78(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      l5_78(i1,i2).c(1,2)=l5_78(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      l5_78(i1,i2).c(2,1)=l5_78(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      l5_78(i1,i2).d(1,1)=l5_78(i1,i2).d(1,1)+ccl*cf78(i1,i2).ek
     & 0
      l5_78(i1,i2).d(2,2)=l5_78(i1,i2).d(2,2)+ccr*cf78(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id5.eq.5.and.id7.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p5,qd=p578,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p5k0*p578(2)+p578k0*p5(2)
      cauxa=auxa-cim*(p578(3)*p5k0-p5(3)*p578k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p578k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p5k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s78-cmh2)+rhhbb**2/(s78-cmhh2)
      cfactor= cffactor/((p578q-rmass2(id5))*p578k0)
  
       do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l5_78(i1,i2).a(i3,i4)=ch78(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  l5_78(i1,i2).b(i3,i4)=ch78(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  l5_78(i1,i2).c(i3,i4)=ch78(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l5_78(i1,i2).a(i3,i4)=czero
                else
                  l5_78(i1,i2).b(i3,i4)=czero
                  l5_78(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
      do m=0,3
        p712(m)=p7(m)+p12(m)
      enddo
* pk0 -- p=p712
      p712k0=p712(0)-p712(1)
* p.q -- p.q=p712q,p=p712,q=p712,bef=,aft=
      p712q=(p712(0)*p712(0)-p712(1)*p712(1)-p712(2)*p712(2)-p71
     & 2(3)*p712(3))
  
* quqd -- p=p7,q=p712
      quqd=p7(0)*p712(0)-p7(1)*p712(1)-p7(2)*p712(2)-p7(3)*p712(
     & 3)
      ccr=zcr(id7)/((p712q-rmass2(id7))*p712k0)
      ccl=zcl(id7)/((p712q-rmass2(id7))*p712k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p7,qd=p712,v=cz12(i1,i2).e,a=l7_12(i1,i2).a,b=l7_12(i1,i2).b,c
* =l7_12(i1,i2).c,d=l7_12(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz12(i1,i2).ek0*(p7(2)*p712(3)-p712(2)*p7(3))+p7k0
     & *(cz12(i1,i2).e(2)*p712(3)-p712(2)*cz12(i1,i2).e(3))-p712
     & k0*(cz12(i1,i2).e(2)*p7(3)-p7(2)*cz12(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz12(i1,i2).e(3)*p7k0+p7(3)*cz12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz12(i1,i2).e(3)*p712k0+p712(3)*cz12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz12(i1,i2).e(0)*p7(0)-cz12(i1,i2).e(1)*p7(1)-cz12(i1
     & ,i2).e(2)*p7(2)-cz12(i1,i2).e(3)*p7(3)
      cvqd=cz12(i1,i2).e(0)*p712(0)-cz12(i1,i2).e(1)*p712(1)-cz1
     & 2(i1,i2).e(2)*p712(2)-cz12(i1,i2).e(3)*p712(3)
      cauxa=-cz12(i1,i2).ek0*quqd+p7k0*cvqd+p712k0*cvqu
      cauxb=-cz12(i1,i2).ek0*p712(2)+p712k0*cz12(i1,i2).e(2)
      cauxc=+cz12(i1,i2).ek0*p7(2)-p7k0*cz12(i1,i2).e(2)
      l7_12(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      l7_12(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      l7_12(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      l7_12(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      l7_12(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      l7_12(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      l7_12(i1,i2).d(1,1)=ccl*cz12(i1,i2).ek0
      l7_12(i1,i2).d(2,2)=ccr*cz12(i1,i2).ek0
      end do
      end do
      ccr=fcr(id7)/((p712q-rmass2(id7))*p712k0)
      ccl=fcl(id7)/((p712q-rmass2(id7))*p712k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p7,qd=p712,v=cf12(i1,i2).e,a=l7_12(i1,i2).a,b=l7_12(i1,i2).b,c
* =l7_12(i1,i2).c,d=l7_12(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf12(i1,i2).ek0*(p7(2)*p712(3)-p712(2)*p7(3))+p7k0
     & *(cf12(i1,i2).e(2)*p712(3)-p712(2)*cf12(i1,i2).e(3))-p712
     & k0*(cf12(i1,i2).e(2)*p7(3)-p7(2)*cf12(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf12(i1,i2).e(3)*p7k0+p7(3)*cf12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf12(i1,i2).e(3)*p712k0+p712(3)*cf12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf12(i1,i2).e(0)*p7(0)-cf12(i1,i2).e(1)*p7(1)-cf12(i1
     & ,i2).e(2)*p7(2)-cf12(i1,i2).e(3)*p7(3)
      cvqd=cf12(i1,i2).e(0)*p712(0)-cf12(i1,i2).e(1)*p712(1)-cf1
     & 2(i1,i2).e(2)*p712(2)-cf12(i1,i2).e(3)*p712(3)
      cauxa=-cf12(i1,i2).ek0*quqd+p7k0*cvqd+p712k0*cvqu
      cauxb=-cf12(i1,i2).ek0*p712(2)+p712k0*cf12(i1,i2).e(2)
      cauxc=+cf12(i1,i2).ek0*p7(2)-p7k0*cf12(i1,i2).e(2)
      l7_12(i1,i2).a(1,1)=l7_12(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      l7_12(i1,i2).a(2,2)=l7_12(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      l7_12(i1,i2).b(1,2)=l7_12(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      l7_12(i1,i2).b(2,1)=l7_12(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      l7_12(i1,i2).c(1,2)=l7_12(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      l7_12(i1,i2).c(2,1)=l7_12(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      l7_12(i1,i2).d(1,1)=l7_12(i1,i2).d(1,1)+ccl*cf12(i1,i2).ek
     & 0
      l7_12(i1,i2).d(2,2)=l7_12(i1,i2).d(2,2)+ccr*cf12(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id7.eq.5.and.id1.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p7,qd=p712,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p7k0*p712(2)+p712k0*p7(2)
      cauxa=auxa-cim*(p712(3)*p7k0-p7(3)*p712k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p712k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p7k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s12-cmh2)+rhhbb**2/(s12-cmhh2)
      cfactor= cffactor/((p712q-rmass2(id7))*p712k0)
  
       do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l7_12(i1,i2).a(i3,i4)=ch12(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  l7_12(i1,i2).b(i3,i4)=ch12(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  l7_12(i1,i2).c(i3,i4)=ch12(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l7_12(i1,i2).a(i3,i4)=czero
                else
                  l7_12(i1,i2).b(i3,i4)=czero
                  l7_12(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
      do m=0,3
        p734(m)=p7(m)+p34(m)
      enddo
* pk0 -- p=p734
      p734k0=p734(0)-p734(1)
* p.q -- p.q=p734q,p=p734,q=p734,bef=,aft=
      p734q=(p734(0)*p734(0)-p734(1)*p734(1)-p734(2)*p734(2)-p73
     & 4(3)*p734(3))
  
* quqd -- p=p7,q=p734
      quqd=p7(0)*p734(0)-p7(1)*p734(1)-p7(2)*p734(2)-p7(3)*p734(
     & 3)
      ccr=zcr(id7)/((p734q-rmass2(id7))*p734k0)
      ccl=zcl(id7)/((p734q-rmass2(id7))*p734k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p7,qd=p734,v=cz34(i1,i2).e,a=l7_34(i1,i2).a,b=l7_34(i1,i2).b,c
* =l7_34(i1,i2).c,d=l7_34(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz34(i1,i2).ek0*(p7(2)*p734(3)-p734(2)*p7(3))+p7k0
     & *(cz34(i1,i2).e(2)*p734(3)-p734(2)*cz34(i1,i2).e(3))-p734
     & k0*(cz34(i1,i2).e(2)*p7(3)-p7(2)*cz34(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz34(i1,i2).e(3)*p7k0+p7(3)*cz34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz34(i1,i2).e(3)*p734k0+p734(3)*cz34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz34(i1,i2).e(0)*p7(0)-cz34(i1,i2).e(1)*p7(1)-cz34(i1
     & ,i2).e(2)*p7(2)-cz34(i1,i2).e(3)*p7(3)
      cvqd=cz34(i1,i2).e(0)*p734(0)-cz34(i1,i2).e(1)*p734(1)-cz3
     & 4(i1,i2).e(2)*p734(2)-cz34(i1,i2).e(3)*p734(3)
      cauxa=-cz34(i1,i2).ek0*quqd+p7k0*cvqd+p734k0*cvqu
      cauxb=-cz34(i1,i2).ek0*p734(2)+p734k0*cz34(i1,i2).e(2)
      cauxc=+cz34(i1,i2).ek0*p7(2)-p7k0*cz34(i1,i2).e(2)
      l7_34(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      l7_34(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      l7_34(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      l7_34(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      l7_34(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      l7_34(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      l7_34(i1,i2).d(1,1)=ccl*cz34(i1,i2).ek0
      l7_34(i1,i2).d(2,2)=ccr*cz34(i1,i2).ek0
      end do
      end do
      ccr=fcr(id7)/((p734q-rmass2(id7))*p734k0)
      ccl=fcl(id7)/((p734q-rmass2(id7))*p734k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p7,qd=p734,v=cf34(i1,i2).e,a=l7_34(i1,i2).a,b=l7_34(i1,i2).b,c
* =l7_34(i1,i2).c,d=l7_34(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf34(i1,i2).ek0*(p7(2)*p734(3)-p734(2)*p7(3))+p7k0
     & *(cf34(i1,i2).e(2)*p734(3)-p734(2)*cf34(i1,i2).e(3))-p734
     & k0*(cf34(i1,i2).e(2)*p7(3)-p7(2)*cf34(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf34(i1,i2).e(3)*p7k0+p7(3)*cf34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf34(i1,i2).e(3)*p734k0+p734(3)*cf34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf34(i1,i2).e(0)*p7(0)-cf34(i1,i2).e(1)*p7(1)-cf34(i1
     & ,i2).e(2)*p7(2)-cf34(i1,i2).e(3)*p7(3)
      cvqd=cf34(i1,i2).e(0)*p734(0)-cf34(i1,i2).e(1)*p734(1)-cf3
     & 4(i1,i2).e(2)*p734(2)-cf34(i1,i2).e(3)*p734(3)
      cauxa=-cf34(i1,i2).ek0*quqd+p7k0*cvqd+p734k0*cvqu
      cauxb=-cf34(i1,i2).ek0*p734(2)+p734k0*cf34(i1,i2).e(2)
      cauxc=+cf34(i1,i2).ek0*p7(2)-p7k0*cf34(i1,i2).e(2)
      l7_34(i1,i2).a(1,1)=l7_34(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      l7_34(i1,i2).a(2,2)=l7_34(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      l7_34(i1,i2).b(1,2)=l7_34(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      l7_34(i1,i2).b(2,1)=l7_34(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      l7_34(i1,i2).c(1,2)=l7_34(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      l7_34(i1,i2).c(2,1)=l7_34(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      l7_34(i1,i2).d(1,1)=l7_34(i1,i2).d(1,1)+ccl*cf34(i1,i2).ek
     & 0
      l7_34(i1,i2).d(2,2)=l7_34(i1,i2).d(2,2)+ccr*cf34(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id7.eq.5.and.id3.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p7,qd=p734,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p7k0*p734(2)+p734k0*p7(2)
      cauxa=auxa-cim*(p734(3)*p7k0-p7(3)*p734k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p734k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p7k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s34-cmh2)+rhhbb**2/(s34-cmhh2)
      cfactor= cffactor/((p734q-rmass2(id7))*p734k0)
  
       do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l7_34(i1,i2).a(i3,i4)=ch34(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  l7_34(i1,i2).b(i3,i4)=ch34(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  l7_34(i1,i2).c(i3,i4)=ch34(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l7_34(i1,i2).a(i3,i4)=czero
                else
                  l7_34(i1,i2).b(i3,i4)=czero
                  l7_34(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
      do m=0,3
        p756(m)=p7(m)+p56(m)
      enddo
* pk0 -- p=p756
      p756k0=p756(0)-p756(1)
* p.q -- p.q=p756q,p=p756,q=p756,bef=,aft=
      p756q=(p756(0)*p756(0)-p756(1)*p756(1)-p756(2)*p756(2)-p75
     & 6(3)*p756(3))
  
* quqd -- p=p7,q=p756
      quqd=p7(0)*p756(0)-p7(1)*p756(1)-p7(2)*p756(2)-p7(3)*p756(
     & 3)
      ccr=zcr(id7)/((p756q-rmass2(id7))*p756k0)
      ccl=zcl(id7)/((p756q-rmass2(id7))*p756k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p7,qd=p756,v=cz56(i1,i2).e,a=l7_56(i1,i2).a,b=l7_56(i1,i2).b,c
* =l7_56(i1,i2).c,d=l7_56(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz56(i1,i2).ek0*(p7(2)*p756(3)-p756(2)*p7(3))+p7k0
     & *(cz56(i1,i2).e(2)*p756(3)-p756(2)*cz56(i1,i2).e(3))-p756
     & k0*(cz56(i1,i2).e(2)*p7(3)-p7(2)*cz56(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz56(i1,i2).e(3)*p7k0+p7(3)*cz56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz56(i1,i2).e(3)*p756k0+p756(3)*cz56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz56(i1,i2).e(0)*p7(0)-cz56(i1,i2).e(1)*p7(1)-cz56(i1
     & ,i2).e(2)*p7(2)-cz56(i1,i2).e(3)*p7(3)
      cvqd=cz56(i1,i2).e(0)*p756(0)-cz56(i1,i2).e(1)*p756(1)-cz5
     & 6(i1,i2).e(2)*p756(2)-cz56(i1,i2).e(3)*p756(3)
      cauxa=-cz56(i1,i2).ek0*quqd+p7k0*cvqd+p756k0*cvqu
      cauxb=-cz56(i1,i2).ek0*p756(2)+p756k0*cz56(i1,i2).e(2)
      cauxc=+cz56(i1,i2).ek0*p7(2)-p7k0*cz56(i1,i2).e(2)
      l7_56(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      l7_56(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      l7_56(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      l7_56(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      l7_56(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      l7_56(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      l7_56(i1,i2).d(1,1)=ccl*cz56(i1,i2).ek0
      l7_56(i1,i2).d(2,2)=ccr*cz56(i1,i2).ek0
      end do
      end do
      ccr=fcr(id7)/((p756q-rmass2(id7))*p756k0)
      ccl=fcl(id7)/((p756q-rmass2(id7))*p756k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p7,qd=p756,v=cf56(i1,i2).e,a=l7_56(i1,i2).a,b=l7_56(i1,i2).b,c
* =l7_56(i1,i2).c,d=l7_56(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf56(i1,i2).ek0*(p7(2)*p756(3)-p756(2)*p7(3))+p7k0
     & *(cf56(i1,i2).e(2)*p756(3)-p756(2)*cf56(i1,i2).e(3))-p756
     & k0*(cf56(i1,i2).e(2)*p7(3)-p7(2)*cf56(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf56(i1,i2).e(3)*p7k0+p7(3)*cf56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf56(i1,i2).e(3)*p756k0+p756(3)*cf56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf56(i1,i2).e(0)*p7(0)-cf56(i1,i2).e(1)*p7(1)-cf56(i1
     & ,i2).e(2)*p7(2)-cf56(i1,i2).e(3)*p7(3)
      cvqd=cf56(i1,i2).e(0)*p756(0)-cf56(i1,i2).e(1)*p756(1)-cf5
     & 6(i1,i2).e(2)*p756(2)-cf56(i1,i2).e(3)*p756(3)
      cauxa=-cf56(i1,i2).ek0*quqd+p7k0*cvqd+p756k0*cvqu
      cauxb=-cf56(i1,i2).ek0*p756(2)+p756k0*cf56(i1,i2).e(2)
      cauxc=+cf56(i1,i2).ek0*p7(2)-p7k0*cf56(i1,i2).e(2)
      l7_56(i1,i2).a(1,1)=l7_56(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      l7_56(i1,i2).a(2,2)=l7_56(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      l7_56(i1,i2).b(1,2)=l7_56(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      l7_56(i1,i2).b(2,1)=l7_56(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      l7_56(i1,i2).c(1,2)=l7_56(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      l7_56(i1,i2).c(2,1)=l7_56(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      l7_56(i1,i2).d(1,1)=l7_56(i1,i2).d(1,1)+ccl*cf56(i1,i2).ek
     & 0
      l7_56(i1,i2).d(2,2)=l7_56(i1,i2).d(2,2)+ccr*cf56(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id7.eq.5.and.id5.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p7,qd=p756,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p7k0*p756(2)+p756k0*p7(2)
      cauxa=auxa-cim*(p756(3)*p7k0-p7(3)*p756k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p756k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p7k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s56-cmh2)+rhhbb**2/(s56-cmhh2)
      cfactor= cffactor/((p756q-rmass2(id7))*p756k0)
  
       do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l7_56(i1,i2).a(i3,i4)=ch56(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  l7_56(i1,i2).b(i3,i4)=ch56(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  l7_56(i1,i2).c(i3,i4)=ch56(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  l7_56(i1,i2).a(i3,i4)=czero
                else
                  l7_56(i1,i2).b(i3,i4)=czero
                  l7_56(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* COMPUTE ALL SINGLE INSERTIONS OF THE TYPE RI_ (I=2,4,6,8)  FOR A ZLINE
* AND A Z  GAMMA AND EVENTUALLY HIGGS INSERTION                         
*                                                                       
*            |_Z,f,h_/                                                  
*         i__|       \                                                  
*                                                                       
*together with its propagator and pk0                                   
  
      do m=0,3
        p234(m)=-p2(m)-p34(m)
      enddo
* pk0 -- p=p234
      p234k0=p234(0)-p234(1)
* p.q -- p.q=p234q,p=p234,q=p234,bef=,aft=
      p234q=(p234(0)*p234(0)-p234(1)*p234(1)-p234(2)*p234(2)-p23
     & 4(3)*p234(3))
  
* quqd -- p=p234,q=p2
      quqd=p234(0)*p2(0)-p234(1)*p2(1)-p234(2)*p2(2)-p234(3)*p2(
     & 3)
      ccr=zcr(id2)/((p234q-rmass2(id2))*p234k0)
      ccl=zcl(id2)/((p234q-rmass2(id2))*p234k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p234,qd=p2,v=cz34(i1,i2).e,a=r2_34(i1,i2).a,b=r2_34(i1,i2).b,c
* =r2_34(i1,i2).c,d=r2_34(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz34(i1,i2).ek0*(p234(2)*p2(3)-p2(2)*p234(3))+p234
     & k0*(cz34(i1,i2).e(2)*p2(3)-p2(2)*cz34(i1,i2).e(3))-p2k0*(
     & cz34(i1,i2).e(2)*p234(3)-p234(2)*cz34(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz34(i1,i2).e(3)*p234k0+p234(3)*cz34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz34(i1,i2).e(3)*p2k0+p2(3)*cz34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz34(i1,i2).e(0)*p234(0)-cz34(i1,i2).e(1)*p234(1)-cz3
     & 4(i1,i2).e(2)*p234(2)-cz34(i1,i2).e(3)*p234(3)
      cvqd=cz34(i1,i2).e(0)*p2(0)-cz34(i1,i2).e(1)*p2(1)-cz34(i1
     & ,i2).e(2)*p2(2)-cz34(i1,i2).e(3)*p2(3)
      cauxa=-cz34(i1,i2).ek0*quqd+p234k0*cvqd+p2k0*cvqu
      cauxb=-cz34(i1,i2).ek0*p2(2)+p2k0*cz34(i1,i2).e(2)
      cauxc=+cz34(i1,i2).ek0*p234(2)-p234k0*cz34(i1,i2).e(2)
      r2_34(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      r2_34(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      r2_34(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      r2_34(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      r2_34(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      r2_34(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      r2_34(i1,i2).d(1,1)=ccl*cz34(i1,i2).ek0
      r2_34(i1,i2).d(2,2)=ccr*cz34(i1,i2).ek0
      end do
      end do
      ccr=fcr(id2)/((p234q-rmass2(id2))*p234k0)
      ccl=fcl(id2)/((p234q-rmass2(id2))*p234k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p234,qd=p2,v=cf34(i1,i2).e,a=r2_34(i1,i2).a,b=r2_34(i1,i2).b,c
* =r2_34(i1,i2).c,d=r2_34(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf34(i1,i2).ek0*(p234(2)*p2(3)-p2(2)*p234(3))+p234
     & k0*(cf34(i1,i2).e(2)*p2(3)-p2(2)*cf34(i1,i2).e(3))-p2k0*(
     & cf34(i1,i2).e(2)*p234(3)-p234(2)*cf34(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf34(i1,i2).e(3)*p234k0+p234(3)*cf34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf34(i1,i2).e(3)*p2k0+p2(3)*cf34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf34(i1,i2).e(0)*p234(0)-cf34(i1,i2).e(1)*p234(1)-cf3
     & 4(i1,i2).e(2)*p234(2)-cf34(i1,i2).e(3)*p234(3)
      cvqd=cf34(i1,i2).e(0)*p2(0)-cf34(i1,i2).e(1)*p2(1)-cf34(i1
     & ,i2).e(2)*p2(2)-cf34(i1,i2).e(3)*p2(3)
      cauxa=-cf34(i1,i2).ek0*quqd+p234k0*cvqd+p2k0*cvqu
      cauxb=-cf34(i1,i2).ek0*p2(2)+p2k0*cf34(i1,i2).e(2)
      cauxc=+cf34(i1,i2).ek0*p234(2)-p234k0*cf34(i1,i2).e(2)
      r2_34(i1,i2).a(1,1)=r2_34(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      r2_34(i1,i2).a(2,2)=r2_34(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      r2_34(i1,i2).b(1,2)=r2_34(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      r2_34(i1,i2).b(2,1)=r2_34(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      r2_34(i1,i2).c(1,2)=r2_34(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      r2_34(i1,i2).c(2,1)=r2_34(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      r2_34(i1,i2).d(1,1)=r2_34(i1,i2).d(1,1)+ccl*cf34(i1,i2).ek
     & 0
      r2_34(i1,i2).d(2,2)=r2_34(i1,i2).d(2,2)+ccr*cf34(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id2.eq.-5.and.id4.eq.-5.and.rmh.ge.0.d0) then
  
* TH -- qu=p234,qd=p2,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p234k0*p2(2)+p2k0*p234(2)
      cauxa=auxa-cim*(p2(3)*p234k0-p234(3)*p2k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p2k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p234k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s34-cmh2)+rhhbb**2/(s34-cmhh2)
      cfactor= cffactor/((p234q-rmass2(id2))*p234k0)
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r2_34(i1,i2).a(i3,i4)=ch34(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  r2_34(i1,i2).b(i3,i4)=ch34(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  r2_34(i1,i2).c(i3,i4)=ch34(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r2_34(i1,i2).a(i3,i4)=czero
                else
                  r2_34(i1,i2).b(i3,i4)=czero
                  r2_34(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
      do m=0,3
        p256(m)=-p2(m)-p56(m)
      enddo
* pk0 -- p=p256
      p256k0=p256(0)-p256(1)
* p.q -- p.q=p256q,p=p256,q=p256,bef=,aft=
      p256q=(p256(0)*p256(0)-p256(1)*p256(1)-p256(2)*p256(2)-p25
     & 6(3)*p256(3))
  
* quqd -- p=p256,q=p2
      quqd=p256(0)*p2(0)-p256(1)*p2(1)-p256(2)*p2(2)-p256(3)*p2(
     & 3)
      ccr=zcr(id2)/((p256q-rmass2(id2))*p256k0)
      ccl=zcl(id2)/((p256q-rmass2(id2))*p256k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p256,qd=p2,v=cz56(i1,i2).e,a=r2_56(i1,i2).a,b=r2_56(i1,i2).b,c
* =r2_56(i1,i2).c,d=r2_56(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz56(i1,i2).ek0*(p256(2)*p2(3)-p2(2)*p256(3))+p256
     & k0*(cz56(i1,i2).e(2)*p2(3)-p2(2)*cz56(i1,i2).e(3))-p2k0*(
     & cz56(i1,i2).e(2)*p256(3)-p256(2)*cz56(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz56(i1,i2).e(3)*p256k0+p256(3)*cz56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz56(i1,i2).e(3)*p2k0+p2(3)*cz56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz56(i1,i2).e(0)*p256(0)-cz56(i1,i2).e(1)*p256(1)-cz5
     & 6(i1,i2).e(2)*p256(2)-cz56(i1,i2).e(3)*p256(3)
      cvqd=cz56(i1,i2).e(0)*p2(0)-cz56(i1,i2).e(1)*p2(1)-cz56(i1
     & ,i2).e(2)*p2(2)-cz56(i1,i2).e(3)*p2(3)
      cauxa=-cz56(i1,i2).ek0*quqd+p256k0*cvqd+p2k0*cvqu
      cauxb=-cz56(i1,i2).ek0*p2(2)+p2k0*cz56(i1,i2).e(2)
      cauxc=+cz56(i1,i2).ek0*p256(2)-p256k0*cz56(i1,i2).e(2)
      r2_56(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      r2_56(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      r2_56(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      r2_56(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      r2_56(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      r2_56(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      r2_56(i1,i2).d(1,1)=ccl*cz56(i1,i2).ek0
      r2_56(i1,i2).d(2,2)=ccr*cz56(i1,i2).ek0
      end do
      end do
      ccr=fcr(id2)/((p256q-rmass2(id2))*p256k0)
      ccl=fcl(id2)/((p256q-rmass2(id2))*p256k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p256,qd=p2,v=cf56(i1,i2).e,a=r2_56(i1,i2).a,b=r2_56(i1,i2).b,c
* =r2_56(i1,i2).c,d=r2_56(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf56(i1,i2).ek0*(p256(2)*p2(3)-p2(2)*p256(3))+p256
     & k0*(cf56(i1,i2).e(2)*p2(3)-p2(2)*cf56(i1,i2).e(3))-p2k0*(
     & cf56(i1,i2).e(2)*p256(3)-p256(2)*cf56(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf56(i1,i2).e(3)*p256k0+p256(3)*cf56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf56(i1,i2).e(3)*p2k0+p2(3)*cf56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf56(i1,i2).e(0)*p256(0)-cf56(i1,i2).e(1)*p256(1)-cf5
     & 6(i1,i2).e(2)*p256(2)-cf56(i1,i2).e(3)*p256(3)
      cvqd=cf56(i1,i2).e(0)*p2(0)-cf56(i1,i2).e(1)*p2(1)-cf56(i1
     & ,i2).e(2)*p2(2)-cf56(i1,i2).e(3)*p2(3)
      cauxa=-cf56(i1,i2).ek0*quqd+p256k0*cvqd+p2k0*cvqu
      cauxb=-cf56(i1,i2).ek0*p2(2)+p2k0*cf56(i1,i2).e(2)
      cauxc=+cf56(i1,i2).ek0*p256(2)-p256k0*cf56(i1,i2).e(2)
      r2_56(i1,i2).a(1,1)=r2_56(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      r2_56(i1,i2).a(2,2)=r2_56(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      r2_56(i1,i2).b(1,2)=r2_56(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      r2_56(i1,i2).b(2,1)=r2_56(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      r2_56(i1,i2).c(1,2)=r2_56(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      r2_56(i1,i2).c(2,1)=r2_56(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      r2_56(i1,i2).d(1,1)=r2_56(i1,i2).d(1,1)+ccl*cf56(i1,i2).ek
     & 0
      r2_56(i1,i2).d(2,2)=r2_56(i1,i2).d(2,2)+ccr*cf56(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id2.eq.-5.and.id6.eq.-5.and.rmh.ge.0.d0) then
  
* TH -- qu=p256,qd=p2,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p256k0*p2(2)+p2k0*p256(2)
      cauxa=auxa-cim*(p2(3)*p256k0-p256(3)*p2k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p2k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p256k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s56-cmh2)+rhhbb**2/(s56-cmhh2)
      cfactor= cffactor/((p256q-rmass2(id2))*p256k0)
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r2_56(i1,i2).a(i3,i4)=ch56(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  r2_56(i1,i2).b(i3,i4)=ch56(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  r2_56(i1,i2).c(i3,i4)=ch56(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r2_56(i1,i2).a(i3,i4)=czero
                else
                  r2_56(i1,i2).b(i3,i4)=czero
                  r2_56(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
      do m=0,3
        p278(m)=-p2(m)-p78(m)
      enddo
* pk0 -- p=p278
      p278k0=p278(0)-p278(1)
* p.q -- p.q=p278q,p=p278,q=p278,bef=,aft=
      p278q=(p278(0)*p278(0)-p278(1)*p278(1)-p278(2)*p278(2)-p27
     & 8(3)*p278(3))
  
* quqd -- p=p278,q=p2
      quqd=p278(0)*p2(0)-p278(1)*p2(1)-p278(2)*p2(2)-p278(3)*p2(
     & 3)
      ccr=zcr(id2)/((p278q-rmass2(id2))*p278k0)
      ccl=zcl(id2)/((p278q-rmass2(id2))*p278k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p278,qd=p2,v=cz78(i1,i2).e,a=r2_78(i1,i2).a,b=r2_78(i1,i2).b,c
* =r2_78(i1,i2).c,d=r2_78(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz78(i1,i2).ek0*(p278(2)*p2(3)-p2(2)*p278(3))+p278
     & k0*(cz78(i1,i2).e(2)*p2(3)-p2(2)*cz78(i1,i2).e(3))-p2k0*(
     & cz78(i1,i2).e(2)*p278(3)-p278(2)*cz78(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz78(i1,i2).e(3)*p278k0+p278(3)*cz78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz78(i1,i2).e(3)*p2k0+p2(3)*cz78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz78(i1,i2).e(0)*p278(0)-cz78(i1,i2).e(1)*p278(1)-cz7
     & 8(i1,i2).e(2)*p278(2)-cz78(i1,i2).e(3)*p278(3)
      cvqd=cz78(i1,i2).e(0)*p2(0)-cz78(i1,i2).e(1)*p2(1)-cz78(i1
     & ,i2).e(2)*p2(2)-cz78(i1,i2).e(3)*p2(3)
      cauxa=-cz78(i1,i2).ek0*quqd+p278k0*cvqd+p2k0*cvqu
      cauxb=-cz78(i1,i2).ek0*p2(2)+p2k0*cz78(i1,i2).e(2)
      cauxc=+cz78(i1,i2).ek0*p278(2)-p278k0*cz78(i1,i2).e(2)
      r2_78(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      r2_78(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      r2_78(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      r2_78(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      r2_78(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      r2_78(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      r2_78(i1,i2).d(1,1)=ccl*cz78(i1,i2).ek0
      r2_78(i1,i2).d(2,2)=ccr*cz78(i1,i2).ek0
      end do
      end do
      ccr=fcr(id2)/((p278q-rmass2(id2))*p278k0)
      ccl=fcl(id2)/((p278q-rmass2(id2))*p278k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p278,qd=p2,v=cf78(i1,i2).e,a=r2_78(i1,i2).a,b=r2_78(i1,i2).b,c
* =r2_78(i1,i2).c,d=r2_78(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf78(i1,i2).ek0*(p278(2)*p2(3)-p2(2)*p278(3))+p278
     & k0*(cf78(i1,i2).e(2)*p2(3)-p2(2)*cf78(i1,i2).e(3))-p2k0*(
     & cf78(i1,i2).e(2)*p278(3)-p278(2)*cf78(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf78(i1,i2).e(3)*p278k0+p278(3)*cf78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf78(i1,i2).e(3)*p2k0+p2(3)*cf78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf78(i1,i2).e(0)*p278(0)-cf78(i1,i2).e(1)*p278(1)-cf7
     & 8(i1,i2).e(2)*p278(2)-cf78(i1,i2).e(3)*p278(3)
      cvqd=cf78(i1,i2).e(0)*p2(0)-cf78(i1,i2).e(1)*p2(1)-cf78(i1
     & ,i2).e(2)*p2(2)-cf78(i1,i2).e(3)*p2(3)
      cauxa=-cf78(i1,i2).ek0*quqd+p278k0*cvqd+p2k0*cvqu
      cauxb=-cf78(i1,i2).ek0*p2(2)+p2k0*cf78(i1,i2).e(2)
      cauxc=+cf78(i1,i2).ek0*p278(2)-p278k0*cf78(i1,i2).e(2)
      r2_78(i1,i2).a(1,1)=r2_78(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      r2_78(i1,i2).a(2,2)=r2_78(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      r2_78(i1,i2).b(1,2)=r2_78(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      r2_78(i1,i2).b(2,1)=r2_78(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      r2_78(i1,i2).c(1,2)=r2_78(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      r2_78(i1,i2).c(2,1)=r2_78(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      r2_78(i1,i2).d(1,1)=r2_78(i1,i2).d(1,1)+ccl*cf78(i1,i2).ek
     & 0
      r2_78(i1,i2).d(2,2)=r2_78(i1,i2).d(2,2)+ccr*cf78(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id2.eq.-5.and.id8.eq.-5.and.rmh.ge.0.d0) then
  
* TH -- qu=p278,qd=p2,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p278k0*p2(2)+p2k0*p278(2)
      cauxa=auxa-cim*(p2(3)*p278k0-p278(3)*p2k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p2k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p278k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s78-cmh2)+rhhbb**2/(s78-cmhh2)
      cfactor= cffactor/((p278q-rmass2(id2))*p278k0)
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r2_78(i1,i2).a(i3,i4)=ch78(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  r2_78(i1,i2).b(i3,i4)=ch78(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  r2_78(i1,i2).c(i3,i4)=ch78(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r2_78(i1,i2).a(i3,i4)=czero
                else
                  r2_78(i1,i2).b(i3,i4)=czero
                  r2_78(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
      do m=0,3
        p412(m)=-p4(m)-p12(m)
      enddo
* pk0 -- p=p412
      p412k0=p412(0)-p412(1)
* p.q -- p.q=p412q,p=p412,q=p412,bef=,aft=
      p412q=(p412(0)*p412(0)-p412(1)*p412(1)-p412(2)*p412(2)-p41
     & 2(3)*p412(3))
  
* quqd -- p=p412,q=p4
      quqd=p412(0)*p4(0)-p412(1)*p4(1)-p412(2)*p4(2)-p412(3)*p4(
     & 3)
      ccr=zcr(id4)/((p412q-rmass2(id4))*p412k0)
      ccl=zcl(id4)/((p412q-rmass2(id4))*p412k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p412,qd=p4,v=cz12(i1,i2).e,a=r4_12(i1,i2).a,b=r4_12(i1,i2).b,c
* =r4_12(i1,i2).c,d=r4_12(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz12(i1,i2).ek0*(p412(2)*p4(3)-p4(2)*p412(3))+p412
     & k0*(cz12(i1,i2).e(2)*p4(3)-p4(2)*cz12(i1,i2).e(3))-p4k0*(
     & cz12(i1,i2).e(2)*p412(3)-p412(2)*cz12(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz12(i1,i2).e(3)*p412k0+p412(3)*cz12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz12(i1,i2).e(3)*p4k0+p4(3)*cz12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz12(i1,i2).e(0)*p412(0)-cz12(i1,i2).e(1)*p412(1)-cz1
     & 2(i1,i2).e(2)*p412(2)-cz12(i1,i2).e(3)*p412(3)
      cvqd=cz12(i1,i2).e(0)*p4(0)-cz12(i1,i2).e(1)*p4(1)-cz12(i1
     & ,i2).e(2)*p4(2)-cz12(i1,i2).e(3)*p4(3)
      cauxa=-cz12(i1,i2).ek0*quqd+p412k0*cvqd+p4k0*cvqu
      cauxb=-cz12(i1,i2).ek0*p4(2)+p4k0*cz12(i1,i2).e(2)
      cauxc=+cz12(i1,i2).ek0*p412(2)-p412k0*cz12(i1,i2).e(2)
      r4_12(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      r4_12(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      r4_12(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      r4_12(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      r4_12(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      r4_12(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      r4_12(i1,i2).d(1,1)=ccl*cz12(i1,i2).ek0
      r4_12(i1,i2).d(2,2)=ccr*cz12(i1,i2).ek0
      end do
      end do
      ccr=fcr(id4)/((p412q-rmass2(id4))*p412k0)
      ccl=fcl(id4)/((p412q-rmass2(id4))*p412k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p412,qd=p4,v=cf12(i1,i2).e,a=r4_12(i1,i2).a,b=r4_12(i1,i2).b,c
* =r4_12(i1,i2).c,d=r4_12(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf12(i1,i2).ek0*(p412(2)*p4(3)-p4(2)*p412(3))+p412
     & k0*(cf12(i1,i2).e(2)*p4(3)-p4(2)*cf12(i1,i2).e(3))-p4k0*(
     & cf12(i1,i2).e(2)*p412(3)-p412(2)*cf12(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf12(i1,i2).e(3)*p412k0+p412(3)*cf12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf12(i1,i2).e(3)*p4k0+p4(3)*cf12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf12(i1,i2).e(0)*p412(0)-cf12(i1,i2).e(1)*p412(1)-cf1
     & 2(i1,i2).e(2)*p412(2)-cf12(i1,i2).e(3)*p412(3)
      cvqd=cf12(i1,i2).e(0)*p4(0)-cf12(i1,i2).e(1)*p4(1)-cf12(i1
     & ,i2).e(2)*p4(2)-cf12(i1,i2).e(3)*p4(3)
      cauxa=-cf12(i1,i2).ek0*quqd+p412k0*cvqd+p4k0*cvqu
      cauxb=-cf12(i1,i2).ek0*p4(2)+p4k0*cf12(i1,i2).e(2)
      cauxc=+cf12(i1,i2).ek0*p412(2)-p412k0*cf12(i1,i2).e(2)
      r4_12(i1,i2).a(1,1)=r4_12(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      r4_12(i1,i2).a(2,2)=r4_12(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      r4_12(i1,i2).b(1,2)=r4_12(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      r4_12(i1,i2).b(2,1)=r4_12(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      r4_12(i1,i2).c(1,2)=r4_12(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      r4_12(i1,i2).c(2,1)=r4_12(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      r4_12(i1,i2).d(1,1)=r4_12(i1,i2).d(1,1)+ccl*cf12(i1,i2).ek
     & 0
      r4_12(i1,i2).d(2,2)=r4_12(i1,i2).d(2,2)+ccr*cf12(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id4.eq.-5.and.id2.eq.-5.and.rmh.ge.0.d0) then
  
* TH -- qu=p412,qd=p4,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p412k0*p4(2)+p4k0*p412(2)
      cauxa=auxa-cim*(p4(3)*p412k0-p412(3)*p4k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p4k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p412k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s12-cmh2)+rhhbb**2/(s12-cmhh2)
      cfactor= cffactor/((p412q-rmass2(id4))*p412k0)
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r4_12(i1,i2).a(i3,i4)=ch12(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  r4_12(i1,i2).b(i3,i4)=ch12(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  r4_12(i1,i2).c(i3,i4)=ch12(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r4_12(i1,i2).a(i3,i4)=czero
                else
                  r4_12(i1,i2).b(i3,i4)=czero
                  r4_12(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
      do m=0,3
        p456(m)=-p4(m)-p56(m)
      enddo
* pk0 -- p=p456
      p456k0=p456(0)-p456(1)
* p.q -- p.q=p456q,p=p456,q=p456,bef=,aft=
      p456q=(p456(0)*p456(0)-p456(1)*p456(1)-p456(2)*p456(2)-p45
     & 6(3)*p456(3))
  
* quqd -- p=p456,q=p4
      quqd=p456(0)*p4(0)-p456(1)*p4(1)-p456(2)*p4(2)-p456(3)*p4(
     & 3)
      ccr=zcr(id4)/((p456q-rmass2(id4))*p456k0)
      ccl=zcl(id4)/((p456q-rmass2(id4))*p456k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p456,qd=p4,v=cz56(i1,i2).e,a=r4_56(i1,i2).a,b=r4_56(i1,i2).b,c
* =r4_56(i1,i2).c,d=r4_56(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz56(i1,i2).ek0*(p456(2)*p4(3)-p4(2)*p456(3))+p456
     & k0*(cz56(i1,i2).e(2)*p4(3)-p4(2)*cz56(i1,i2).e(3))-p4k0*(
     & cz56(i1,i2).e(2)*p456(3)-p456(2)*cz56(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz56(i1,i2).e(3)*p456k0+p456(3)*cz56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz56(i1,i2).e(3)*p4k0+p4(3)*cz56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz56(i1,i2).e(0)*p456(0)-cz56(i1,i2).e(1)*p456(1)-cz5
     & 6(i1,i2).e(2)*p456(2)-cz56(i1,i2).e(3)*p456(3)
      cvqd=cz56(i1,i2).e(0)*p4(0)-cz56(i1,i2).e(1)*p4(1)-cz56(i1
     & ,i2).e(2)*p4(2)-cz56(i1,i2).e(3)*p4(3)
      cauxa=-cz56(i1,i2).ek0*quqd+p456k0*cvqd+p4k0*cvqu
      cauxb=-cz56(i1,i2).ek0*p4(2)+p4k0*cz56(i1,i2).e(2)
      cauxc=+cz56(i1,i2).ek0*p456(2)-p456k0*cz56(i1,i2).e(2)
      r4_56(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      r4_56(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      r4_56(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      r4_56(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      r4_56(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      r4_56(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      r4_56(i1,i2).d(1,1)=ccl*cz56(i1,i2).ek0
      r4_56(i1,i2).d(2,2)=ccr*cz56(i1,i2).ek0
      end do
      end do
      ccr=fcr(id4)/((p456q-rmass2(id4))*p456k0)
      ccl=fcl(id4)/((p456q-rmass2(id4))*p456k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p456,qd=p4,v=cf56(i1,i2).e,a=r4_56(i1,i2).a,b=r4_56(i1,i2).b,c
* =r4_56(i1,i2).c,d=r4_56(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf56(i1,i2).ek0*(p456(2)*p4(3)-p4(2)*p456(3))+p456
     & k0*(cf56(i1,i2).e(2)*p4(3)-p4(2)*cf56(i1,i2).e(3))-p4k0*(
     & cf56(i1,i2).e(2)*p456(3)-p456(2)*cf56(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf56(i1,i2).e(3)*p456k0+p456(3)*cf56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf56(i1,i2).e(3)*p4k0+p4(3)*cf56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf56(i1,i2).e(0)*p456(0)-cf56(i1,i2).e(1)*p456(1)-cf5
     & 6(i1,i2).e(2)*p456(2)-cf56(i1,i2).e(3)*p456(3)
      cvqd=cf56(i1,i2).e(0)*p4(0)-cf56(i1,i2).e(1)*p4(1)-cf56(i1
     & ,i2).e(2)*p4(2)-cf56(i1,i2).e(3)*p4(3)
      cauxa=-cf56(i1,i2).ek0*quqd+p456k0*cvqd+p4k0*cvqu
      cauxb=-cf56(i1,i2).ek0*p4(2)+p4k0*cf56(i1,i2).e(2)
      cauxc=+cf56(i1,i2).ek0*p456(2)-p456k0*cf56(i1,i2).e(2)
      r4_56(i1,i2).a(1,1)=r4_56(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      r4_56(i1,i2).a(2,2)=r4_56(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      r4_56(i1,i2).b(1,2)=r4_56(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      r4_56(i1,i2).b(2,1)=r4_56(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      r4_56(i1,i2).c(1,2)=r4_56(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      r4_56(i1,i2).c(2,1)=r4_56(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      r4_56(i1,i2).d(1,1)=r4_56(i1,i2).d(1,1)+ccl*cf56(i1,i2).ek
     & 0
      r4_56(i1,i2).d(2,2)=r4_56(i1,i2).d(2,2)+ccr*cf56(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id4.eq.-5.and.id6.eq.-5.and.rmh.ge.0.d0) then
  
* TH -- qu=p456,qd=p4,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p456k0*p4(2)+p4k0*p456(2)
      cauxa=auxa-cim*(p4(3)*p456k0-p456(3)*p4k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p4k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p456k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s56-cmh2)+rhhbb**2/(s56-cmhh2)
      cfactor= cffactor/((p456q-rmass2(id4))*p456k0)
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r4_56(i1,i2).a(i3,i4)=ch56(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  r4_56(i1,i2).b(i3,i4)=ch56(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  r4_56(i1,i2).c(i3,i4)=ch56(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r4_56(i1,i2).a(i3,i4)=czero
                else
                  r4_56(i1,i2).b(i3,i4)=czero
                  r4_56(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
      do m=0,3
        p478(m)=-p4(m)-p78(m)
      enddo
* pk0 -- p=p478
      p478k0=p478(0)-p478(1)
* p.q -- p.q=p478q,p=p478,q=p478,bef=,aft=
      p478q=(p478(0)*p478(0)-p478(1)*p478(1)-p478(2)*p478(2)-p47
     & 8(3)*p478(3))
  
* quqd -- p=p478,q=p4
      quqd=p478(0)*p4(0)-p478(1)*p4(1)-p478(2)*p4(2)-p478(3)*p4(
     & 3)
      ccr=zcr(id4)/((p478q-rmass2(id4))*p478k0)
      ccl=zcl(id4)/((p478q-rmass2(id4))*p478k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p478,qd=p4,v=cz78(i1,i2).e,a=r4_78(i1,i2).a,b=r4_78(i1,i2).b,c
* =r4_78(i1,i2).c,d=r4_78(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz78(i1,i2).ek0*(p478(2)*p4(3)-p4(2)*p478(3))+p478
     & k0*(cz78(i1,i2).e(2)*p4(3)-p4(2)*cz78(i1,i2).e(3))-p4k0*(
     & cz78(i1,i2).e(2)*p478(3)-p478(2)*cz78(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz78(i1,i2).e(3)*p478k0+p478(3)*cz78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz78(i1,i2).e(3)*p4k0+p4(3)*cz78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz78(i1,i2).e(0)*p478(0)-cz78(i1,i2).e(1)*p478(1)-cz7
     & 8(i1,i2).e(2)*p478(2)-cz78(i1,i2).e(3)*p478(3)
      cvqd=cz78(i1,i2).e(0)*p4(0)-cz78(i1,i2).e(1)*p4(1)-cz78(i1
     & ,i2).e(2)*p4(2)-cz78(i1,i2).e(3)*p4(3)
      cauxa=-cz78(i1,i2).ek0*quqd+p478k0*cvqd+p4k0*cvqu
      cauxb=-cz78(i1,i2).ek0*p4(2)+p4k0*cz78(i1,i2).e(2)
      cauxc=+cz78(i1,i2).ek0*p478(2)-p478k0*cz78(i1,i2).e(2)
      r4_78(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      r4_78(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      r4_78(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      r4_78(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      r4_78(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      r4_78(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      r4_78(i1,i2).d(1,1)=ccl*cz78(i1,i2).ek0
      r4_78(i1,i2).d(2,2)=ccr*cz78(i1,i2).ek0
      end do
      end do
      ccr=fcr(id4)/((p478q-rmass2(id4))*p478k0)
      ccl=fcl(id4)/((p478q-rmass2(id4))*p478k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p478,qd=p4,v=cf78(i1,i2).e,a=r4_78(i1,i2).a,b=r4_78(i1,i2).b,c
* =r4_78(i1,i2).c,d=r4_78(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf78(i1,i2).ek0*(p478(2)*p4(3)-p4(2)*p478(3))+p478
     & k0*(cf78(i1,i2).e(2)*p4(3)-p4(2)*cf78(i1,i2).e(3))-p4k0*(
     & cf78(i1,i2).e(2)*p478(3)-p478(2)*cf78(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf78(i1,i2).e(3)*p478k0+p478(3)*cf78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf78(i1,i2).e(3)*p4k0+p4(3)*cf78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf78(i1,i2).e(0)*p478(0)-cf78(i1,i2).e(1)*p478(1)-cf7
     & 8(i1,i2).e(2)*p478(2)-cf78(i1,i2).e(3)*p478(3)
      cvqd=cf78(i1,i2).e(0)*p4(0)-cf78(i1,i2).e(1)*p4(1)-cf78(i1
     & ,i2).e(2)*p4(2)-cf78(i1,i2).e(3)*p4(3)
      cauxa=-cf78(i1,i2).ek0*quqd+p478k0*cvqd+p4k0*cvqu
      cauxb=-cf78(i1,i2).ek0*p4(2)+p4k0*cf78(i1,i2).e(2)
      cauxc=+cf78(i1,i2).ek0*p478(2)-p478k0*cf78(i1,i2).e(2)
      r4_78(i1,i2).a(1,1)=r4_78(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      r4_78(i1,i2).a(2,2)=r4_78(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      r4_78(i1,i2).b(1,2)=r4_78(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      r4_78(i1,i2).b(2,1)=r4_78(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      r4_78(i1,i2).c(1,2)=r4_78(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      r4_78(i1,i2).c(2,1)=r4_78(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      r4_78(i1,i2).d(1,1)=r4_78(i1,i2).d(1,1)+ccl*cf78(i1,i2).ek
     & 0
      r4_78(i1,i2).d(2,2)=r4_78(i1,i2).d(2,2)+ccr*cf78(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id4.eq.-5.and.id8.eq.-5.and.rmh.ge.0.d0) then
  
* TH -- qu=p478,qd=p4,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p478k0*p4(2)+p4k0*p478(2)
      cauxa=auxa-cim*(p4(3)*p478k0-p478(3)*p4k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p4k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p478k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s78-cmh2)+rhhbb**2/(s78-cmhh2)
      cfactor= cffactor/((p478q-rmass2(id4))*p478k0)
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r4_78(i1,i2).a(i3,i4)=ch78(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  r4_78(i1,i2).b(i3,i4)=ch78(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  r4_78(i1,i2).c(i3,i4)=ch78(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r4_78(i1,i2).a(i3,i4)=czero
                else
                  r4_78(i1,i2).b(i3,i4)=czero
                  r4_78(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
      do m=0,3
        p612(m)=-p6(m)-p12(m)
      enddo
* pk0 -- p=p612
      p612k0=p612(0)-p612(1)
* p.q -- p.q=p612q,p=p612,q=p612,bef=,aft=
      p612q=(p612(0)*p612(0)-p612(1)*p612(1)-p612(2)*p612(2)-p61
     & 2(3)*p612(3))
  
* quqd -- p=p612,q=p6
      quqd=p612(0)*p6(0)-p612(1)*p6(1)-p612(2)*p6(2)-p612(3)*p6(
     & 3)
      ccr=zcr(id6)/((p612q-rmass2(id6))*p612k0)
      ccl=zcl(id6)/((p612q-rmass2(id6))*p612k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p612,qd=p6,v=cz12(i1,i2).e,a=r6_12(i1,i2).a,b=r6_12(i1,i2).b,c
* =r6_12(i1,i2).c,d=r6_12(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz12(i1,i2).ek0*(p612(2)*p6(3)-p6(2)*p612(3))+p612
     & k0*(cz12(i1,i2).e(2)*p6(3)-p6(2)*cz12(i1,i2).e(3))-p6k0*(
     & cz12(i1,i2).e(2)*p612(3)-p612(2)*cz12(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz12(i1,i2).e(3)*p612k0+p612(3)*cz12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz12(i1,i2).e(3)*p6k0+p6(3)*cz12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz12(i1,i2).e(0)*p612(0)-cz12(i1,i2).e(1)*p612(1)-cz1
     & 2(i1,i2).e(2)*p612(2)-cz12(i1,i2).e(3)*p612(3)
      cvqd=cz12(i1,i2).e(0)*p6(0)-cz12(i1,i2).e(1)*p6(1)-cz12(i1
     & ,i2).e(2)*p6(2)-cz12(i1,i2).e(3)*p6(3)
      cauxa=-cz12(i1,i2).ek0*quqd+p612k0*cvqd+p6k0*cvqu
      cauxb=-cz12(i1,i2).ek0*p6(2)+p6k0*cz12(i1,i2).e(2)
      cauxc=+cz12(i1,i2).ek0*p612(2)-p612k0*cz12(i1,i2).e(2)
      r6_12(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      r6_12(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      r6_12(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      r6_12(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      r6_12(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      r6_12(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      r6_12(i1,i2).d(1,1)=ccl*cz12(i1,i2).ek0
      r6_12(i1,i2).d(2,2)=ccr*cz12(i1,i2).ek0
      end do
      end do
      ccr=fcr(id6)/((p612q-rmass2(id6))*p612k0)
      ccl=fcl(id6)/((p612q-rmass2(id6))*p612k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p612,qd=p6,v=cf12(i1,i2).e,a=r6_12(i1,i2).a,b=r6_12(i1,i2).b,c
* =r6_12(i1,i2).c,d=r6_12(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf12(i1,i2).ek0*(p612(2)*p6(3)-p6(2)*p612(3))+p612
     & k0*(cf12(i1,i2).e(2)*p6(3)-p6(2)*cf12(i1,i2).e(3))-p6k0*(
     & cf12(i1,i2).e(2)*p612(3)-p612(2)*cf12(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf12(i1,i2).e(3)*p612k0+p612(3)*cf12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf12(i1,i2).e(3)*p6k0+p6(3)*cf12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf12(i1,i2).e(0)*p612(0)-cf12(i1,i2).e(1)*p612(1)-cf1
     & 2(i1,i2).e(2)*p612(2)-cf12(i1,i2).e(3)*p612(3)
      cvqd=cf12(i1,i2).e(0)*p6(0)-cf12(i1,i2).e(1)*p6(1)-cf12(i1
     & ,i2).e(2)*p6(2)-cf12(i1,i2).e(3)*p6(3)
      cauxa=-cf12(i1,i2).ek0*quqd+p612k0*cvqd+p6k0*cvqu
      cauxb=-cf12(i1,i2).ek0*p6(2)+p6k0*cf12(i1,i2).e(2)
      cauxc=+cf12(i1,i2).ek0*p612(2)-p612k0*cf12(i1,i2).e(2)
      r6_12(i1,i2).a(1,1)=r6_12(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      r6_12(i1,i2).a(2,2)=r6_12(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      r6_12(i1,i2).b(1,2)=r6_12(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      r6_12(i1,i2).b(2,1)=r6_12(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      r6_12(i1,i2).c(1,2)=r6_12(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      r6_12(i1,i2).c(2,1)=r6_12(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      r6_12(i1,i2).d(1,1)=r6_12(i1,i2).d(1,1)+ccl*cf12(i1,i2).ek
     & 0
      r6_12(i1,i2).d(2,2)=r6_12(i1,i2).d(2,2)+ccr*cf12(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id6.eq.-5.and.id2.eq.-5.and.rmh.ge.0.d0) then
  
* TH -- qu=p612,qd=p6,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p612k0*p6(2)+p6k0*p612(2)
      cauxa=auxa-cim*(p6(3)*p612k0-p612(3)*p6k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p6k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p612k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s12-cmh2)+rhhbb**2/(s12-cmhh2)
      cfactor= cffactor/((p612q-rmass2(id6))*p612k0)
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r6_12(i1,i2).a(i3,i4)=ch12(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  r6_12(i1,i2).b(i3,i4)=ch12(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  r6_12(i1,i2).c(i3,i4)=ch12(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r6_12(i1,i2).a(i3,i4)=czero
                else
                  r6_12(i1,i2).b(i3,i4)=czero
                  r6_12(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
      do m=0,3
        p634(m)=-p6(m)-p34(m)
      enddo
* pk0 -- p=p634
      p634k0=p634(0)-p634(1)
* p.q -- p.q=p634q,p=p634,q=p634,bef=,aft=
      p634q=(p634(0)*p634(0)-p634(1)*p634(1)-p634(2)*p634(2)-p63
     & 4(3)*p634(3))
  
* quqd -- p=p634,q=p6
      quqd=p634(0)*p6(0)-p634(1)*p6(1)-p634(2)*p6(2)-p634(3)*p6(
     & 3)
      ccr=zcr(id6)/((p634q-rmass2(id6))*p634k0)
      ccl=zcl(id6)/((p634q-rmass2(id6))*p634k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p634,qd=p6,v=cz34(i1,i2).e,a=r6_34(i1,i2).a,b=r6_34(i1,i2).b,c
* =r6_34(i1,i2).c,d=r6_34(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz34(i1,i2).ek0*(p634(2)*p6(3)-p6(2)*p634(3))+p634
     & k0*(cz34(i1,i2).e(2)*p6(3)-p6(2)*cz34(i1,i2).e(3))-p6k0*(
     & cz34(i1,i2).e(2)*p634(3)-p634(2)*cz34(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz34(i1,i2).e(3)*p634k0+p634(3)*cz34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz34(i1,i2).e(3)*p6k0+p6(3)*cz34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz34(i1,i2).e(0)*p634(0)-cz34(i1,i2).e(1)*p634(1)-cz3
     & 4(i1,i2).e(2)*p634(2)-cz34(i1,i2).e(3)*p634(3)
      cvqd=cz34(i1,i2).e(0)*p6(0)-cz34(i1,i2).e(1)*p6(1)-cz34(i1
     & ,i2).e(2)*p6(2)-cz34(i1,i2).e(3)*p6(3)
      cauxa=-cz34(i1,i2).ek0*quqd+p634k0*cvqd+p6k0*cvqu
      cauxb=-cz34(i1,i2).ek0*p6(2)+p6k0*cz34(i1,i2).e(2)
      cauxc=+cz34(i1,i2).ek0*p634(2)-p634k0*cz34(i1,i2).e(2)
      r6_34(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      r6_34(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      r6_34(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      r6_34(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      r6_34(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      r6_34(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      r6_34(i1,i2).d(1,1)=ccl*cz34(i1,i2).ek0
      r6_34(i1,i2).d(2,2)=ccr*cz34(i1,i2).ek0
      end do
      end do
      ccr=fcr(id6)/((p634q-rmass2(id6))*p634k0)
      ccl=fcl(id6)/((p634q-rmass2(id6))*p634k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p634,qd=p6,v=cf34(i1,i2).e,a=r6_34(i1,i2).a,b=r6_34(i1,i2).b,c
* =r6_34(i1,i2).c,d=r6_34(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf34(i1,i2).ek0*(p634(2)*p6(3)-p6(2)*p634(3))+p634
     & k0*(cf34(i1,i2).e(2)*p6(3)-p6(2)*cf34(i1,i2).e(3))-p6k0*(
     & cf34(i1,i2).e(2)*p634(3)-p634(2)*cf34(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf34(i1,i2).e(3)*p634k0+p634(3)*cf34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf34(i1,i2).e(3)*p6k0+p6(3)*cf34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf34(i1,i2).e(0)*p634(0)-cf34(i1,i2).e(1)*p634(1)-cf3
     & 4(i1,i2).e(2)*p634(2)-cf34(i1,i2).e(3)*p634(3)
      cvqd=cf34(i1,i2).e(0)*p6(0)-cf34(i1,i2).e(1)*p6(1)-cf34(i1
     & ,i2).e(2)*p6(2)-cf34(i1,i2).e(3)*p6(3)
      cauxa=-cf34(i1,i2).ek0*quqd+p634k0*cvqd+p6k0*cvqu
      cauxb=-cf34(i1,i2).ek0*p6(2)+p6k0*cf34(i1,i2).e(2)
      cauxc=+cf34(i1,i2).ek0*p634(2)-p634k0*cf34(i1,i2).e(2)
      r6_34(i1,i2).a(1,1)=r6_34(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      r6_34(i1,i2).a(2,2)=r6_34(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      r6_34(i1,i2).b(1,2)=r6_34(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      r6_34(i1,i2).b(2,1)=r6_34(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      r6_34(i1,i2).c(1,2)=r6_34(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      r6_34(i1,i2).c(2,1)=r6_34(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      r6_34(i1,i2).d(1,1)=r6_34(i1,i2).d(1,1)+ccl*cf34(i1,i2).ek
     & 0
      r6_34(i1,i2).d(2,2)=r6_34(i1,i2).d(2,2)+ccr*cf34(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id6.eq.-5.and.id4.eq.-5.and.rmh.ge.0.d0) then
  
* TH -- qu=p634,qd=p6,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p634k0*p6(2)+p6k0*p634(2)
      cauxa=auxa-cim*(p6(3)*p634k0-p634(3)*p6k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p6k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p634k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s34-cmh2)+rhhbb**2/(s34-cmhh2)
      cfactor= cffactor/((p634q-rmass2(id6))*p634k0)
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r6_34(i1,i2).a(i3,i4)=ch34(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  r6_34(i1,i2).b(i3,i4)=ch34(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  r6_34(i1,i2).c(i3,i4)=ch34(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r6_34(i1,i2).a(i3,i4)=czero
                else
                  r6_34(i1,i2).b(i3,i4)=czero
                  r6_34(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
      do m=0,3
        p678(m)=-p6(m)-p78(m)
      enddo
* pk0 -- p=p678
      p678k0=p678(0)-p678(1)
* p.q -- p.q=p678q,p=p678,q=p678,bef=,aft=
      p678q=(p678(0)*p678(0)-p678(1)*p678(1)-p678(2)*p678(2)-p67
     & 8(3)*p678(3))
  
* quqd -- p=p678,q=p6
      quqd=p678(0)*p6(0)-p678(1)*p6(1)-p678(2)*p6(2)-p678(3)*p6(
     & 3)
      ccr=zcr(id6)/((p678q-rmass2(id6))*p678k0)
      ccl=zcl(id6)/((p678q-rmass2(id6))*p678k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p678,qd=p6,v=cz78(i1,i2).e,a=r6_78(i1,i2).a,b=r6_78(i1,i2).b,c
* =r6_78(i1,i2).c,d=r6_78(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz78(i1,i2).ek0*(p678(2)*p6(3)-p6(2)*p678(3))+p678
     & k0*(cz78(i1,i2).e(2)*p6(3)-p6(2)*cz78(i1,i2).e(3))-p6k0*(
     & cz78(i1,i2).e(2)*p678(3)-p678(2)*cz78(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz78(i1,i2).e(3)*p678k0+p678(3)*cz78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz78(i1,i2).e(3)*p6k0+p6(3)*cz78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz78(i1,i2).e(0)*p678(0)-cz78(i1,i2).e(1)*p678(1)-cz7
     & 8(i1,i2).e(2)*p678(2)-cz78(i1,i2).e(3)*p678(3)
      cvqd=cz78(i1,i2).e(0)*p6(0)-cz78(i1,i2).e(1)*p6(1)-cz78(i1
     & ,i2).e(2)*p6(2)-cz78(i1,i2).e(3)*p6(3)
      cauxa=-cz78(i1,i2).ek0*quqd+p678k0*cvqd+p6k0*cvqu
      cauxb=-cz78(i1,i2).ek0*p6(2)+p6k0*cz78(i1,i2).e(2)
      cauxc=+cz78(i1,i2).ek0*p678(2)-p678k0*cz78(i1,i2).e(2)
      r6_78(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      r6_78(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      r6_78(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      r6_78(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      r6_78(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      r6_78(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      r6_78(i1,i2).d(1,1)=ccl*cz78(i1,i2).ek0
      r6_78(i1,i2).d(2,2)=ccr*cz78(i1,i2).ek0
      end do
      end do
      ccr=fcr(id6)/((p678q-rmass2(id6))*p678k0)
      ccl=fcl(id6)/((p678q-rmass2(id6))*p678k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p678,qd=p6,v=cf78(i1,i2).e,a=r6_78(i1,i2).a,b=r6_78(i1,i2).b,c
* =r6_78(i1,i2).c,d=r6_78(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf78(i1,i2).ek0*(p678(2)*p6(3)-p6(2)*p678(3))+p678
     & k0*(cf78(i1,i2).e(2)*p6(3)-p6(2)*cf78(i1,i2).e(3))-p6k0*(
     & cf78(i1,i2).e(2)*p678(3)-p678(2)*cf78(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf78(i1,i2).e(3)*p678k0+p678(3)*cf78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf78(i1,i2).e(3)*p6k0+p6(3)*cf78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf78(i1,i2).e(0)*p678(0)-cf78(i1,i2).e(1)*p678(1)-cf7
     & 8(i1,i2).e(2)*p678(2)-cf78(i1,i2).e(3)*p678(3)
      cvqd=cf78(i1,i2).e(0)*p6(0)-cf78(i1,i2).e(1)*p6(1)-cf78(i1
     & ,i2).e(2)*p6(2)-cf78(i1,i2).e(3)*p6(3)
      cauxa=-cf78(i1,i2).ek0*quqd+p678k0*cvqd+p6k0*cvqu
      cauxb=-cf78(i1,i2).ek0*p6(2)+p6k0*cf78(i1,i2).e(2)
      cauxc=+cf78(i1,i2).ek0*p678(2)-p678k0*cf78(i1,i2).e(2)
      r6_78(i1,i2).a(1,1)=r6_78(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      r6_78(i1,i2).a(2,2)=r6_78(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      r6_78(i1,i2).b(1,2)=r6_78(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      r6_78(i1,i2).b(2,1)=r6_78(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      r6_78(i1,i2).c(1,2)=r6_78(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      r6_78(i1,i2).c(2,1)=r6_78(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      r6_78(i1,i2).d(1,1)=r6_78(i1,i2).d(1,1)+ccl*cf78(i1,i2).ek
     & 0
      r6_78(i1,i2).d(2,2)=r6_78(i1,i2).d(2,2)+ccr*cf78(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id6.eq.-5.and.id8.eq.-5.and.rmh.ge.0.d0) then
  
* TH -- qu=p678,qd=p6,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p678k0*p6(2)+p6k0*p678(2)
      cauxa=auxa-cim*(p6(3)*p678k0-p678(3)*p6k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p6k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p678k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s78-cmh2)+rhhbb**2/(s78-cmhh2)
      cfactor= cffactor/((p678q-rmass2(id6))*p678k0)
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r6_78(i1,i2).a(i3,i4)=ch78(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  r6_78(i1,i2).b(i3,i4)=ch78(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  r6_78(i1,i2).c(i3,i4)=ch78(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r6_78(i1,i2).a(i3,i4)=czero
                else
                  r6_78(i1,i2).b(i3,i4)=czero
                  r6_78(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
      do m=0,3
        p812(m)=-p8(m)-p12(m)
      enddo
* pk0 -- p=p812
      p812k0=p812(0)-p812(1)
* p.q -- p.q=p812q,p=p812,q=p812,bef=,aft=
      p812q=(p812(0)*p812(0)-p812(1)*p812(1)-p812(2)*p812(2)-p81
     & 2(3)*p812(3))
  
* quqd -- p=p812,q=p8
      quqd=p812(0)*p8(0)-p812(1)*p8(1)-p812(2)*p8(2)-p812(3)*p8(
     & 3)
      ccr=zcr(id8)/((p812q-rmass2(id8))*p812k0)
      ccl=zcl(id8)/((p812q-rmass2(id8))*p812k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p812,qd=p8,v=cz12(i1,i2).e,a=r8_12(i1,i2).a,b=r8_12(i1,i2).b,c
* =r8_12(i1,i2).c,d=r8_12(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz12(i1,i2).ek0*(p812(2)*p8(3)-p8(2)*p812(3))+p812
     & k0*(cz12(i1,i2).e(2)*p8(3)-p8(2)*cz12(i1,i2).e(3))-p8k0*(
     & cz12(i1,i2).e(2)*p812(3)-p812(2)*cz12(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz12(i1,i2).e(3)*p812k0+p812(3)*cz12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz12(i1,i2).e(3)*p8k0+p8(3)*cz12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz12(i1,i2).e(0)*p812(0)-cz12(i1,i2).e(1)*p812(1)-cz1
     & 2(i1,i2).e(2)*p812(2)-cz12(i1,i2).e(3)*p812(3)
      cvqd=cz12(i1,i2).e(0)*p8(0)-cz12(i1,i2).e(1)*p8(1)-cz12(i1
     & ,i2).e(2)*p8(2)-cz12(i1,i2).e(3)*p8(3)
      cauxa=-cz12(i1,i2).ek0*quqd+p812k0*cvqd+p8k0*cvqu
      cauxb=-cz12(i1,i2).ek0*p8(2)+p8k0*cz12(i1,i2).e(2)
      cauxc=+cz12(i1,i2).ek0*p812(2)-p812k0*cz12(i1,i2).e(2)
      r8_12(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      r8_12(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      r8_12(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      r8_12(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      r8_12(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      r8_12(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      r8_12(i1,i2).d(1,1)=ccl*cz12(i1,i2).ek0
      r8_12(i1,i2).d(2,2)=ccr*cz12(i1,i2).ek0
      end do
      end do
      ccr=fcr(id8)/((p812q-rmass2(id8))*p812k0)
      ccl=fcl(id8)/((p812q-rmass2(id8))*p812k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p812,qd=p8,v=cf12(i1,i2).e,a=r8_12(i1,i2).a,b=r8_12(i1,i2).b,c
* =r8_12(i1,i2).c,d=r8_12(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf12(i1,i2).ek0*(p812(2)*p8(3)-p8(2)*p812(3))+p812
     & k0*(cf12(i1,i2).e(2)*p8(3)-p8(2)*cf12(i1,i2).e(3))-p8k0*(
     & cf12(i1,i2).e(2)*p812(3)-p812(2)*cf12(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf12(i1,i2).e(3)*p812k0+p812(3)*cf12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf12(i1,i2).e(3)*p8k0+p8(3)*cf12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf12(i1,i2).e(0)*p812(0)-cf12(i1,i2).e(1)*p812(1)-cf1
     & 2(i1,i2).e(2)*p812(2)-cf12(i1,i2).e(3)*p812(3)
      cvqd=cf12(i1,i2).e(0)*p8(0)-cf12(i1,i2).e(1)*p8(1)-cf12(i1
     & ,i2).e(2)*p8(2)-cf12(i1,i2).e(3)*p8(3)
      cauxa=-cf12(i1,i2).ek0*quqd+p812k0*cvqd+p8k0*cvqu
      cauxb=-cf12(i1,i2).ek0*p8(2)+p8k0*cf12(i1,i2).e(2)
      cauxc=+cf12(i1,i2).ek0*p812(2)-p812k0*cf12(i1,i2).e(2)
      r8_12(i1,i2).a(1,1)=r8_12(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      r8_12(i1,i2).a(2,2)=r8_12(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      r8_12(i1,i2).b(1,2)=r8_12(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      r8_12(i1,i2).b(2,1)=r8_12(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      r8_12(i1,i2).c(1,2)=r8_12(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      r8_12(i1,i2).c(2,1)=r8_12(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      r8_12(i1,i2).d(1,1)=r8_12(i1,i2).d(1,1)+ccl*cf12(i1,i2).ek
     & 0
      r8_12(i1,i2).d(2,2)=r8_12(i1,i2).d(2,2)+ccr*cf12(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id8.eq.-5.and.id2.eq.-5.and.rmh.ge.0.d0) then
  
* TH -- qu=p812,qd=p8,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p812k0*p8(2)+p8k0*p812(2)
      cauxa=auxa-cim*(p8(3)*p812k0-p812(3)*p8k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p8k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p812k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s12-cmh2)+rhhbb**2/(s12-cmhh2)
      cfactor= cffactor/((p812q-rmass2(id8))*p812k0)
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r8_12(i1,i2).a(i3,i4)=ch12(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  r8_12(i1,i2).b(i3,i4)=ch12(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  r8_12(i1,i2).c(i3,i4)=ch12(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r8_12(i1,i2).a(i3,i4)=czero
                else
                  r8_12(i1,i2).b(i3,i4)=czero
                  r8_12(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
      do m=0,3
        p834(m)=-p8(m)-p34(m)
      enddo
* pk0 -- p=p834
      p834k0=p834(0)-p834(1)
* p.q -- p.q=p834q,p=p834,q=p834,bef=,aft=
      p834q=(p834(0)*p834(0)-p834(1)*p834(1)-p834(2)*p834(2)-p83
     & 4(3)*p834(3))
  
* quqd -- p=p834,q=p8
      quqd=p834(0)*p8(0)-p834(1)*p8(1)-p834(2)*p8(2)-p834(3)*p8(
     & 3)
      ccr=zcr(id8)/((p834q-rmass2(id8))*p834k0)
      ccl=zcl(id8)/((p834q-rmass2(id8))*p834k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p834,qd=p8,v=cz34(i1,i2).e,a=r8_34(i1,i2).a,b=r8_34(i1,i2).b,c
* =r8_34(i1,i2).c,d=r8_34(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz34(i1,i2).ek0*(p834(2)*p8(3)-p8(2)*p834(3))+p834
     & k0*(cz34(i1,i2).e(2)*p8(3)-p8(2)*cz34(i1,i2).e(3))-p8k0*(
     & cz34(i1,i2).e(2)*p834(3)-p834(2)*cz34(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz34(i1,i2).e(3)*p834k0+p834(3)*cz34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz34(i1,i2).e(3)*p8k0+p8(3)*cz34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz34(i1,i2).e(0)*p834(0)-cz34(i1,i2).e(1)*p834(1)-cz3
     & 4(i1,i2).e(2)*p834(2)-cz34(i1,i2).e(3)*p834(3)
      cvqd=cz34(i1,i2).e(0)*p8(0)-cz34(i1,i2).e(1)*p8(1)-cz34(i1
     & ,i2).e(2)*p8(2)-cz34(i1,i2).e(3)*p8(3)
      cauxa=-cz34(i1,i2).ek0*quqd+p834k0*cvqd+p8k0*cvqu
      cauxb=-cz34(i1,i2).ek0*p8(2)+p8k0*cz34(i1,i2).e(2)
      cauxc=+cz34(i1,i2).ek0*p834(2)-p834k0*cz34(i1,i2).e(2)
      r8_34(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      r8_34(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      r8_34(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      r8_34(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      r8_34(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      r8_34(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      r8_34(i1,i2).d(1,1)=ccl*cz34(i1,i2).ek0
      r8_34(i1,i2).d(2,2)=ccr*cz34(i1,i2).ek0
      end do
      end do
      ccr=fcr(id8)/((p834q-rmass2(id8))*p834k0)
      ccl=fcl(id8)/((p834q-rmass2(id8))*p834k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p834,qd=p8,v=cf34(i1,i2).e,a=r8_34(i1,i2).a,b=r8_34(i1,i2).b,c
* =r8_34(i1,i2).c,d=r8_34(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf34(i1,i2).ek0*(p834(2)*p8(3)-p8(2)*p834(3))+p834
     & k0*(cf34(i1,i2).e(2)*p8(3)-p8(2)*cf34(i1,i2).e(3))-p8k0*(
     & cf34(i1,i2).e(2)*p834(3)-p834(2)*cf34(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf34(i1,i2).e(3)*p834k0+p834(3)*cf34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf34(i1,i2).e(3)*p8k0+p8(3)*cf34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf34(i1,i2).e(0)*p834(0)-cf34(i1,i2).e(1)*p834(1)-cf3
     & 4(i1,i2).e(2)*p834(2)-cf34(i1,i2).e(3)*p834(3)
      cvqd=cf34(i1,i2).e(0)*p8(0)-cf34(i1,i2).e(1)*p8(1)-cf34(i1
     & ,i2).e(2)*p8(2)-cf34(i1,i2).e(3)*p8(3)
      cauxa=-cf34(i1,i2).ek0*quqd+p834k0*cvqd+p8k0*cvqu
      cauxb=-cf34(i1,i2).ek0*p8(2)+p8k0*cf34(i1,i2).e(2)
      cauxc=+cf34(i1,i2).ek0*p834(2)-p834k0*cf34(i1,i2).e(2)
      r8_34(i1,i2).a(1,1)=r8_34(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      r8_34(i1,i2).a(2,2)=r8_34(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      r8_34(i1,i2).b(1,2)=r8_34(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      r8_34(i1,i2).b(2,1)=r8_34(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      r8_34(i1,i2).c(1,2)=r8_34(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      r8_34(i1,i2).c(2,1)=r8_34(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      r8_34(i1,i2).d(1,1)=r8_34(i1,i2).d(1,1)+ccl*cf34(i1,i2).ek
     & 0
      r8_34(i1,i2).d(2,2)=r8_34(i1,i2).d(2,2)+ccr*cf34(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id8.eq.-5.and.id4.eq.-5.and.rmh.ge.0.d0) then
  
* TH -- qu=p834,qd=p8,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p834k0*p8(2)+p8k0*p834(2)
      cauxa=auxa-cim*(p8(3)*p834k0-p834(3)*p8k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p8k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p834k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s34-cmh2)+rhhbb**2/(s34-cmhh2)
      cfactor= cffactor/((p834q-rmass2(id8))*p834k0)
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r8_34(i1,i2).a(i3,i4)=ch34(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  r8_34(i1,i2).b(i3,i4)=ch34(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  r8_34(i1,i2).c(i3,i4)=ch34(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r8_34(i1,i2).a(i3,i4)=czero
                else
                  r8_34(i1,i2).b(i3,i4)=czero
                  r8_34(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
      do m=0,3
        p856(m)=-p8(m)-p56(m)
      enddo
* pk0 -- p=p856
      p856k0=p856(0)-p856(1)
* p.q -- p.q=p856q,p=p856,q=p856,bef=,aft=
      p856q=(p856(0)*p856(0)-p856(1)*p856(1)-p856(2)*p856(2)-p85
     & 6(3)*p856(3))
  
* quqd -- p=p856,q=p8
      quqd=p856(0)*p8(0)-p856(1)*p8(1)-p856(2)*p8(2)-p856(3)*p8(
     & 3)
      ccr=zcr(id8)/((p856q-rmass2(id8))*p856k0)
      ccl=zcl(id8)/((p856q-rmass2(id8))*p856k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p856,qd=p8,v=cz56(i1,i2).e,a=r8_56(i1,i2).a,b=r8_56(i1,i2).b,c
* =r8_56(i1,i2).c,d=r8_56(i1,i2).d,cr=ccr,cl=ccl,nsum=0
      ceps_0=-cz56(i1,i2).ek0*(p856(2)*p8(3)-p8(2)*p856(3))+p856
     & k0*(cz56(i1,i2).e(2)*p8(3)-p8(2)*cz56(i1,i2).e(3))-p8k0*(
     & cz56(i1,i2).e(2)*p856(3)-p856(2)*cz56(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cz56(i1,i2).e(3)*p856k0+p856(3)*cz56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz56(i1,i2).e(3)*p8k0+p8(3)*cz56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz56(i1,i2).e(0)*p856(0)-cz56(i1,i2).e(1)*p856(1)-cz5
     & 6(i1,i2).e(2)*p856(2)-cz56(i1,i2).e(3)*p856(3)
      cvqd=cz56(i1,i2).e(0)*p8(0)-cz56(i1,i2).e(1)*p8(1)-cz56(i1
     & ,i2).e(2)*p8(2)-cz56(i1,i2).e(3)*p8(3)
      cauxa=-cz56(i1,i2).ek0*quqd+p856k0*cvqd+p8k0*cvqu
      cauxb=-cz56(i1,i2).ek0*p8(2)+p8k0*cz56(i1,i2).e(2)
      cauxc=+cz56(i1,i2).ek0*p856(2)-p856k0*cz56(i1,i2).e(2)
      r8_56(i1,i2).a(1,1)=ccr*(cauxa+ceps_0)
      r8_56(i1,i2).a(2,2)=ccl*(cauxa-ceps_0)
      r8_56(i1,i2).b(1,2)=ccl*(cauxb-ceps_2)
      r8_56(i1,i2).b(2,1)=ccr*(-cauxb-ceps_2)
      r8_56(i1,i2).c(1,2)=ccr*(cauxc+ceps_1)
      r8_56(i1,i2).c(2,1)=ccl*(-cauxc+ceps_1)
      r8_56(i1,i2).d(1,1)=ccl*cz56(i1,i2).ek0
      r8_56(i1,i2).d(2,2)=ccr*cz56(i1,i2).ek0
      end do
      end do
      ccr=fcr(id8)/((p856q-rmass2(id8))*p856k0)
      ccl=fcl(id8)/((p856q-rmass2(id8))*p856k0)
      do i1=1,2
      do i2=1,2
* T -- qu=p856,qd=p8,v=cf56(i1,i2).e,a=r8_56(i1,i2).a,b=r8_56(i1,i2).b,c
* =r8_56(i1,i2).c,d=r8_56(i1,i2).d,cr=ccr,cl=ccl,nsum=1
      ceps_0=-cf56(i1,i2).ek0*(p856(2)*p8(3)-p8(2)*p856(3))+p856
     & k0*(cf56(i1,i2).e(2)*p8(3)-p8(2)*cf56(i1,i2).e(3))-p8k0*(
     & cf56(i1,i2).e(2)*p856(3)-p856(2)*cf56(i1,i2).e(3))
      ceps_0=ceps_0*cim
      ceps_1=-cf56(i1,i2).e(3)*p856k0+p856(3)*cf56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf56(i1,i2).e(3)*p8k0+p8(3)*cf56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf56(i1,i2).e(0)*p856(0)-cf56(i1,i2).e(1)*p856(1)-cf5
     & 6(i1,i2).e(2)*p856(2)-cf56(i1,i2).e(3)*p856(3)
      cvqd=cf56(i1,i2).e(0)*p8(0)-cf56(i1,i2).e(1)*p8(1)-cf56(i1
     & ,i2).e(2)*p8(2)-cf56(i1,i2).e(3)*p8(3)
      cauxa=-cf56(i1,i2).ek0*quqd+p856k0*cvqd+p8k0*cvqu
      cauxb=-cf56(i1,i2).ek0*p8(2)+p8k0*cf56(i1,i2).e(2)
      cauxc=+cf56(i1,i2).ek0*p856(2)-p856k0*cf56(i1,i2).e(2)
      r8_56(i1,i2).a(1,1)=r8_56(i1,i2).a(1,1)+ccr*(cauxa+ceps_0)
      r8_56(i1,i2).a(2,2)=r8_56(i1,i2).a(2,2)+ccl*(cauxa-ceps_0)
      r8_56(i1,i2).b(1,2)=r8_56(i1,i2).b(1,2)+ccl*(cauxb-ceps_2)
      r8_56(i1,i2).b(2,1)=r8_56(i1,i2).b(2,1)+ccr*(-cauxb-ceps_2
     & )
      r8_56(i1,i2).c(1,2)=r8_56(i1,i2).c(1,2)+ccr*(cauxc+ceps_1)
      r8_56(i1,i2).c(2,1)=r8_56(i1,i2).c(2,1)+ccl*(-cauxc+ceps_1
     & )
      r8_56(i1,i2).d(1,1)=r8_56(i1,i2).d(1,1)+ccl*cf56(i1,i2).ek
     & 0
      r8_56(i1,i2).d(2,2)=r8_56(i1,i2).d(2,2)+ccr*cf56(i1,i2).ek
     & 0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id8.eq.-5.and.id6.eq.-5.and.rmh.ge.0.d0) then
  
* TH -- qu=p856,qd=p8,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.
      auxa=-p856k0*p8(2)+p8k0*p856(2)
      cauxa=auxa-cim*(p8(3)*p856k0-p856(3)*p8k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p8k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p856k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cffactor=rhbb**2/(s56-cmh2)+rhhbb**2/(s56-cmhh2)
      cfactor= cffactor/((p856q-rmass2(id8))*p856k0)
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r8_56(i1,i2).a(i3,i4)=ch56(i1,i2)*clineth.a(i3,i4)
     &                 *cfactor
                else
                  r8_56(i1,i2).b(i3,i4)=ch56(i1,i2)*clineth.b(i3,i4)
     &                 *cfactor
                  r8_56(i1,i2).c(i3,i4)=ch56(i1,i2)*clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  r8_56(i1,i2).a(i3,i4)=czero
                else
                  r8_56(i1,i2).b(i3,i4)=czero
                  r8_56(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
* COMPUTE ALL SINGLE Z OR GAMMA OR HIGGS INSERTIONS IN THE MIDDLE OF A  
*  TRIPLE INSERTION ZLINE                                               
*                                                                       
*            |                                                          
*            |_Z,f,h__/                                                 
*            |        \                                                 
*            |                                                          
* quqd -- p=p134,q=p278
      quqd=p134(0)*p278(0)-p134(1)*p278(1)-p134(2)*p278(2)-p134(
     & 3)*p278(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p134,qd=p278,v=cz56(i1,i2).e,a=u134_56(i1,i2).a,b=u134_56(i1,i
* 2).b,c=u134_56(i1,i2).c,d=u134_56(i1,i2).d,cr=zcr(id1),cl=zcl(id1),nsu
* m=0
      ceps_0=-cz56(i1,i2).ek0*(p134(2)*p278(3)-p278(2)*p134(3))+
     & p134k0*(cz56(i1,i2).e(2)*p278(3)-p278(2)*cz56(i1,i2).e(3)
     & )-p278k0*(cz56(i1,i2).e(2)*p134(3)-p134(2)*cz56(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz56(i1,i2).e(3)*p134k0+p134(3)*cz56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz56(i1,i2).e(3)*p278k0+p278(3)*cz56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz56(i1,i2).e(0)*p134(0)-cz56(i1,i2).e(1)*p134(1)-cz5
     & 6(i1,i2).e(2)*p134(2)-cz56(i1,i2).e(3)*p134(3)
      cvqd=cz56(i1,i2).e(0)*p278(0)-cz56(i1,i2).e(1)*p278(1)-cz5
     & 6(i1,i2).e(2)*p278(2)-cz56(i1,i2).e(3)*p278(3)
      cauxa=-cz56(i1,i2).ek0*quqd+p134k0*cvqd+p278k0*cvqu
      cauxb=-cz56(i1,i2).ek0*p278(2)+p278k0*cz56(i1,i2).e(2)
      cauxc=+cz56(i1,i2).ek0*p134(2)-p134k0*cz56(i1,i2).e(2)
      u134_56(i1,i2).a(1,1)=zcr(id1)*(cauxa+ceps_0)
      u134_56(i1,i2).a(2,2)=zcl(id1)*(cauxa-ceps_0)
      u134_56(i1,i2).b(1,2)=zcl(id1)*(cauxb-ceps_2)
      u134_56(i1,i2).b(2,1)=zcr(id1)*(-cauxb-ceps_2)
      u134_56(i1,i2).c(1,2)=zcr(id1)*(cauxc+ceps_1)
      u134_56(i1,i2).c(2,1)=zcl(id1)*(-cauxc+ceps_1)
      u134_56(i1,i2).d(1,1)=zcl(id1)*cz56(i1,i2).ek0
      u134_56(i1,i2).d(2,2)=zcr(id1)*cz56(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p134,qd=p278,v=cf56(i1,i2).e,a=u134_56(i1,i2).a,b=u134_56(i1,i
* 2).b,c=u134_56(i1,i2).c,d=u134_56(i1,i2).d,cr=fcr(id1),cl=fcl(id1),nsu
* m=1
      ceps_0=-cf56(i1,i2).ek0*(p134(2)*p278(3)-p278(2)*p134(3))+
     & p134k0*(cf56(i1,i2).e(2)*p278(3)-p278(2)*cf56(i1,i2).e(3)
     & )-p278k0*(cf56(i1,i2).e(2)*p134(3)-p134(2)*cf56(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf56(i1,i2).e(3)*p134k0+p134(3)*cf56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf56(i1,i2).e(3)*p278k0+p278(3)*cf56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf56(i1,i2).e(0)*p134(0)-cf56(i1,i2).e(1)*p134(1)-cf5
     & 6(i1,i2).e(2)*p134(2)-cf56(i1,i2).e(3)*p134(3)
      cvqd=cf56(i1,i2).e(0)*p278(0)-cf56(i1,i2).e(1)*p278(1)-cf5
     & 6(i1,i2).e(2)*p278(2)-cf56(i1,i2).e(3)*p278(3)
      cauxa=-cf56(i1,i2).ek0*quqd+p134k0*cvqd+p278k0*cvqu
      cauxb=-cf56(i1,i2).ek0*p278(2)+p278k0*cf56(i1,i2).e(2)
      cauxc=+cf56(i1,i2).ek0*p134(2)-p134k0*cf56(i1,i2).e(2)
      u134_56(i1,i2).a(1,1)=u134_56(i1,i2).a(1,1)+fcr(id1)*(caux
     & a+ceps_0)
      u134_56(i1,i2).a(2,2)=u134_56(i1,i2).a(2,2)+fcl(id1)*(caux
     & a-ceps_0)
      u134_56(i1,i2).b(1,2)=u134_56(i1,i2).b(1,2)+fcl(id1)*(caux
     & b-ceps_2)
      u134_56(i1,i2).b(2,1)=u134_56(i1,i2).b(2,1)+fcr(id1)*(-cau
     & xb-ceps_2)
      u134_56(i1,i2).c(1,2)=u134_56(i1,i2).c(1,2)+fcr(id1)*(caux
     & c+ceps_1)
      u134_56(i1,i2).c(2,1)=u134_56(i1,i2).c(2,1)+fcl(id1)*(-cau
     & xc+ceps_1)
      u134_56(i1,i2).d(1,1)=u134_56(i1,i2).d(1,1)+fcl(id1)*cf56(
     & i1,i2).ek0
      u134_56(i1,i2).d(2,2)=u134_56(i1,i2).d(2,2)+fcr(id1)*cf56(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id1.eq.5.and.id5.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p134,qd=p278,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p134k0*p278(2)+p278k0*p134(2)
      cauxa=auxa-cim*(p278(3)*p134k0-p134(3)*p278k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p278k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p134k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s56-cmh2)+rhhbb**2/(s56-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u134_56(i1,i2).a(i3,i4)=ch56(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u134_56(i1,i2).b(i3,i4)=ch56(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u134_56(i1,i2).c(i3,i4)=ch56(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u134_56(i1,i2).a(i3,i4)=czero
                else
                  u134_56(i1,i2).b(i3,i4)=czero
                  u134_56(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p134,q=p256
      quqd=p134(0)*p256(0)-p134(1)*p256(1)-p134(2)*p256(2)-p134(
     & 3)*p256(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p134,qd=p256,v=cz78(i1,i2).e,a=u134_78(i1,i2).a,b=u134_78(i1,i
* 2).b,c=u134_78(i1,i2).c,d=u134_78(i1,i2).d,cr=zcr(id1),cl=zcl(id1),nsu
* m=0
      ceps_0=-cz78(i1,i2).ek0*(p134(2)*p256(3)-p256(2)*p134(3))+
     & p134k0*(cz78(i1,i2).e(2)*p256(3)-p256(2)*cz78(i1,i2).e(3)
     & )-p256k0*(cz78(i1,i2).e(2)*p134(3)-p134(2)*cz78(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz78(i1,i2).e(3)*p134k0+p134(3)*cz78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz78(i1,i2).e(3)*p256k0+p256(3)*cz78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz78(i1,i2).e(0)*p134(0)-cz78(i1,i2).e(1)*p134(1)-cz7
     & 8(i1,i2).e(2)*p134(2)-cz78(i1,i2).e(3)*p134(3)
      cvqd=cz78(i1,i2).e(0)*p256(0)-cz78(i1,i2).e(1)*p256(1)-cz7
     & 8(i1,i2).e(2)*p256(2)-cz78(i1,i2).e(3)*p256(3)
      cauxa=-cz78(i1,i2).ek0*quqd+p134k0*cvqd+p256k0*cvqu
      cauxb=-cz78(i1,i2).ek0*p256(2)+p256k0*cz78(i1,i2).e(2)
      cauxc=+cz78(i1,i2).ek0*p134(2)-p134k0*cz78(i1,i2).e(2)
      u134_78(i1,i2).a(1,1)=zcr(id1)*(cauxa+ceps_0)
      u134_78(i1,i2).a(2,2)=zcl(id1)*(cauxa-ceps_0)
      u134_78(i1,i2).b(1,2)=zcl(id1)*(cauxb-ceps_2)
      u134_78(i1,i2).b(2,1)=zcr(id1)*(-cauxb-ceps_2)
      u134_78(i1,i2).c(1,2)=zcr(id1)*(cauxc+ceps_1)
      u134_78(i1,i2).c(2,1)=zcl(id1)*(-cauxc+ceps_1)
      u134_78(i1,i2).d(1,1)=zcl(id1)*cz78(i1,i2).ek0
      u134_78(i1,i2).d(2,2)=zcr(id1)*cz78(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p134,qd=p256,v=cf78(i1,i2).e,a=u134_78(i1,i2).a,b=u134_78(i1,i
* 2).b,c=u134_78(i1,i2).c,d=u134_78(i1,i2).d,cr=fcr(id1),cl=fcl(id1),nsu
* m=1
      ceps_0=-cf78(i1,i2).ek0*(p134(2)*p256(3)-p256(2)*p134(3))+
     & p134k0*(cf78(i1,i2).e(2)*p256(3)-p256(2)*cf78(i1,i2).e(3)
     & )-p256k0*(cf78(i1,i2).e(2)*p134(3)-p134(2)*cf78(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf78(i1,i2).e(3)*p134k0+p134(3)*cf78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf78(i1,i2).e(3)*p256k0+p256(3)*cf78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf78(i1,i2).e(0)*p134(0)-cf78(i1,i2).e(1)*p134(1)-cf7
     & 8(i1,i2).e(2)*p134(2)-cf78(i1,i2).e(3)*p134(3)
      cvqd=cf78(i1,i2).e(0)*p256(0)-cf78(i1,i2).e(1)*p256(1)-cf7
     & 8(i1,i2).e(2)*p256(2)-cf78(i1,i2).e(3)*p256(3)
      cauxa=-cf78(i1,i2).ek0*quqd+p134k0*cvqd+p256k0*cvqu
      cauxb=-cf78(i1,i2).ek0*p256(2)+p256k0*cf78(i1,i2).e(2)
      cauxc=+cf78(i1,i2).ek0*p134(2)-p134k0*cf78(i1,i2).e(2)
      u134_78(i1,i2).a(1,1)=u134_78(i1,i2).a(1,1)+fcr(id1)*(caux
     & a+ceps_0)
      u134_78(i1,i2).a(2,2)=u134_78(i1,i2).a(2,2)+fcl(id1)*(caux
     & a-ceps_0)
      u134_78(i1,i2).b(1,2)=u134_78(i1,i2).b(1,2)+fcl(id1)*(caux
     & b-ceps_2)
      u134_78(i1,i2).b(2,1)=u134_78(i1,i2).b(2,1)+fcr(id1)*(-cau
     & xb-ceps_2)
      u134_78(i1,i2).c(1,2)=u134_78(i1,i2).c(1,2)+fcr(id1)*(caux
     & c+ceps_1)
      u134_78(i1,i2).c(2,1)=u134_78(i1,i2).c(2,1)+fcl(id1)*(-cau
     & xc+ceps_1)
      u134_78(i1,i2).d(1,1)=u134_78(i1,i2).d(1,1)+fcl(id1)*cf78(
     & i1,i2).ek0
      u134_78(i1,i2).d(2,2)=u134_78(i1,i2).d(2,2)+fcr(id1)*cf78(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id1.eq.5.and.id7.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p134,qd=p256,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p134k0*p256(2)+p256k0*p134(2)
      cauxa=auxa-cim*(p256(3)*p134k0-p134(3)*p256k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p256k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p134k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s78-cmh2)+rhhbb**2/(s78-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u134_78(i1,i2).a(i3,i4)=ch78(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u134_78(i1,i2).b(i3,i4)=ch78(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u134_78(i1,i2).c(i3,i4)=ch78(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u134_78(i1,i2).a(i3,i4)=czero
                else
                  u134_78(i1,i2).b(i3,i4)=czero
                  u134_78(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p156,q=p278
      quqd=p156(0)*p278(0)-p156(1)*p278(1)-p156(2)*p278(2)-p156(
     & 3)*p278(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p156,qd=p278,v=cz34(i1,i2).e,a=u156_34(i1,i2).a,b=u156_34(i1,i
* 2).b,c=u156_34(i1,i2).c,d=u156_34(i1,i2).d,cr=zcr(id1),cl=zcl(id1),nsu
* m=0
      ceps_0=-cz34(i1,i2).ek0*(p156(2)*p278(3)-p278(2)*p156(3))+
     & p156k0*(cz34(i1,i2).e(2)*p278(3)-p278(2)*cz34(i1,i2).e(3)
     & )-p278k0*(cz34(i1,i2).e(2)*p156(3)-p156(2)*cz34(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz34(i1,i2).e(3)*p156k0+p156(3)*cz34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz34(i1,i2).e(3)*p278k0+p278(3)*cz34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz34(i1,i2).e(0)*p156(0)-cz34(i1,i2).e(1)*p156(1)-cz3
     & 4(i1,i2).e(2)*p156(2)-cz34(i1,i2).e(3)*p156(3)
      cvqd=cz34(i1,i2).e(0)*p278(0)-cz34(i1,i2).e(1)*p278(1)-cz3
     & 4(i1,i2).e(2)*p278(2)-cz34(i1,i2).e(3)*p278(3)
      cauxa=-cz34(i1,i2).ek0*quqd+p156k0*cvqd+p278k0*cvqu
      cauxb=-cz34(i1,i2).ek0*p278(2)+p278k0*cz34(i1,i2).e(2)
      cauxc=+cz34(i1,i2).ek0*p156(2)-p156k0*cz34(i1,i2).e(2)
      u156_34(i1,i2).a(1,1)=zcr(id1)*(cauxa+ceps_0)
      u156_34(i1,i2).a(2,2)=zcl(id1)*(cauxa-ceps_0)
      u156_34(i1,i2).b(1,2)=zcl(id1)*(cauxb-ceps_2)
      u156_34(i1,i2).b(2,1)=zcr(id1)*(-cauxb-ceps_2)
      u156_34(i1,i2).c(1,2)=zcr(id1)*(cauxc+ceps_1)
      u156_34(i1,i2).c(2,1)=zcl(id1)*(-cauxc+ceps_1)
      u156_34(i1,i2).d(1,1)=zcl(id1)*cz34(i1,i2).ek0
      u156_34(i1,i2).d(2,2)=zcr(id1)*cz34(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p156,qd=p278,v=cf34(i1,i2).e,a=u156_34(i1,i2).a,b=u156_34(i1,i
* 2).b,c=u156_34(i1,i2).c,d=u156_34(i1,i2).d,cr=fcr(id1),cl=fcl(id1),nsu
* m=1
      ceps_0=-cf34(i1,i2).ek0*(p156(2)*p278(3)-p278(2)*p156(3))+
     & p156k0*(cf34(i1,i2).e(2)*p278(3)-p278(2)*cf34(i1,i2).e(3)
     & )-p278k0*(cf34(i1,i2).e(2)*p156(3)-p156(2)*cf34(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf34(i1,i2).e(3)*p156k0+p156(3)*cf34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf34(i1,i2).e(3)*p278k0+p278(3)*cf34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf34(i1,i2).e(0)*p156(0)-cf34(i1,i2).e(1)*p156(1)-cf3
     & 4(i1,i2).e(2)*p156(2)-cf34(i1,i2).e(3)*p156(3)
      cvqd=cf34(i1,i2).e(0)*p278(0)-cf34(i1,i2).e(1)*p278(1)-cf3
     & 4(i1,i2).e(2)*p278(2)-cf34(i1,i2).e(3)*p278(3)
      cauxa=-cf34(i1,i2).ek0*quqd+p156k0*cvqd+p278k0*cvqu
      cauxb=-cf34(i1,i2).ek0*p278(2)+p278k0*cf34(i1,i2).e(2)
      cauxc=+cf34(i1,i2).ek0*p156(2)-p156k0*cf34(i1,i2).e(2)
      u156_34(i1,i2).a(1,1)=u156_34(i1,i2).a(1,1)+fcr(id1)*(caux
     & a+ceps_0)
      u156_34(i1,i2).a(2,2)=u156_34(i1,i2).a(2,2)+fcl(id1)*(caux
     & a-ceps_0)
      u156_34(i1,i2).b(1,2)=u156_34(i1,i2).b(1,2)+fcl(id1)*(caux
     & b-ceps_2)
      u156_34(i1,i2).b(2,1)=u156_34(i1,i2).b(2,1)+fcr(id1)*(-cau
     & xb-ceps_2)
      u156_34(i1,i2).c(1,2)=u156_34(i1,i2).c(1,2)+fcr(id1)*(caux
     & c+ceps_1)
      u156_34(i1,i2).c(2,1)=u156_34(i1,i2).c(2,1)+fcl(id1)*(-cau
     & xc+ceps_1)
      u156_34(i1,i2).d(1,1)=u156_34(i1,i2).d(1,1)+fcl(id1)*cf34(
     & i1,i2).ek0
      u156_34(i1,i2).d(2,2)=u156_34(i1,i2).d(2,2)+fcr(id1)*cf34(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id1.eq.5.and.id3.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p156,qd=p278,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p156k0*p278(2)+p278k0*p156(2)
      cauxa=auxa-cim*(p278(3)*p156k0-p156(3)*p278k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p278k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p156k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s34-cmh2)+rhhbb**2/(s34-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u156_34(i1,i2).a(i3,i4)=ch34(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u156_34(i1,i2).b(i3,i4)=ch34(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u156_34(i1,i2).c(i3,i4)=ch34(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u156_34(i1,i2).a(i3,i4)=czero
                else
                  u156_34(i1,i2).b(i3,i4)=czero
                  u156_34(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p156,q=p234
      quqd=p156(0)*p234(0)-p156(1)*p234(1)-p156(2)*p234(2)-p156(
     & 3)*p234(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p156,qd=p234,v=cz78(i1,i2).e,a=u156_78(i1,i2).a,b=u156_78(i1,i
* 2).b,c=u156_78(i1,i2).c,d=u156_78(i1,i2).d,cr=zcr(id1),cl=zcl(id1),nsu
* m=0
      ceps_0=-cz78(i1,i2).ek0*(p156(2)*p234(3)-p234(2)*p156(3))+
     & p156k0*(cz78(i1,i2).e(2)*p234(3)-p234(2)*cz78(i1,i2).e(3)
     & )-p234k0*(cz78(i1,i2).e(2)*p156(3)-p156(2)*cz78(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz78(i1,i2).e(3)*p156k0+p156(3)*cz78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz78(i1,i2).e(3)*p234k0+p234(3)*cz78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz78(i1,i2).e(0)*p156(0)-cz78(i1,i2).e(1)*p156(1)-cz7
     & 8(i1,i2).e(2)*p156(2)-cz78(i1,i2).e(3)*p156(3)
      cvqd=cz78(i1,i2).e(0)*p234(0)-cz78(i1,i2).e(1)*p234(1)-cz7
     & 8(i1,i2).e(2)*p234(2)-cz78(i1,i2).e(3)*p234(3)
      cauxa=-cz78(i1,i2).ek0*quqd+p156k0*cvqd+p234k0*cvqu
      cauxb=-cz78(i1,i2).ek0*p234(2)+p234k0*cz78(i1,i2).e(2)
      cauxc=+cz78(i1,i2).ek0*p156(2)-p156k0*cz78(i1,i2).e(2)
      u156_78(i1,i2).a(1,1)=zcr(id1)*(cauxa+ceps_0)
      u156_78(i1,i2).a(2,2)=zcl(id1)*(cauxa-ceps_0)
      u156_78(i1,i2).b(1,2)=zcl(id1)*(cauxb-ceps_2)
      u156_78(i1,i2).b(2,1)=zcr(id1)*(-cauxb-ceps_2)
      u156_78(i1,i2).c(1,2)=zcr(id1)*(cauxc+ceps_1)
      u156_78(i1,i2).c(2,1)=zcl(id1)*(-cauxc+ceps_1)
      u156_78(i1,i2).d(1,1)=zcl(id1)*cz78(i1,i2).ek0
      u156_78(i1,i2).d(2,2)=zcr(id1)*cz78(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p156,qd=p234,v=cf78(i1,i2).e,a=u156_78(i1,i2).a,b=u156_78(i1,i
* 2).b,c=u156_78(i1,i2).c,d=u156_78(i1,i2).d,cr=fcr(id1),cl=fcl(id1),nsu
* m=1
      ceps_0=-cf78(i1,i2).ek0*(p156(2)*p234(3)-p234(2)*p156(3))+
     & p156k0*(cf78(i1,i2).e(2)*p234(3)-p234(2)*cf78(i1,i2).e(3)
     & )-p234k0*(cf78(i1,i2).e(2)*p156(3)-p156(2)*cf78(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf78(i1,i2).e(3)*p156k0+p156(3)*cf78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf78(i1,i2).e(3)*p234k0+p234(3)*cf78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf78(i1,i2).e(0)*p156(0)-cf78(i1,i2).e(1)*p156(1)-cf7
     & 8(i1,i2).e(2)*p156(2)-cf78(i1,i2).e(3)*p156(3)
      cvqd=cf78(i1,i2).e(0)*p234(0)-cf78(i1,i2).e(1)*p234(1)-cf7
     & 8(i1,i2).e(2)*p234(2)-cf78(i1,i2).e(3)*p234(3)
      cauxa=-cf78(i1,i2).ek0*quqd+p156k0*cvqd+p234k0*cvqu
      cauxb=-cf78(i1,i2).ek0*p234(2)+p234k0*cf78(i1,i2).e(2)
      cauxc=+cf78(i1,i2).ek0*p156(2)-p156k0*cf78(i1,i2).e(2)
      u156_78(i1,i2).a(1,1)=u156_78(i1,i2).a(1,1)+fcr(id1)*(caux
     & a+ceps_0)
      u156_78(i1,i2).a(2,2)=u156_78(i1,i2).a(2,2)+fcl(id1)*(caux
     & a-ceps_0)
      u156_78(i1,i2).b(1,2)=u156_78(i1,i2).b(1,2)+fcl(id1)*(caux
     & b-ceps_2)
      u156_78(i1,i2).b(2,1)=u156_78(i1,i2).b(2,1)+fcr(id1)*(-cau
     & xb-ceps_2)
      u156_78(i1,i2).c(1,2)=u156_78(i1,i2).c(1,2)+fcr(id1)*(caux
     & c+ceps_1)
      u156_78(i1,i2).c(2,1)=u156_78(i1,i2).c(2,1)+fcl(id1)*(-cau
     & xc+ceps_1)
      u156_78(i1,i2).d(1,1)=u156_78(i1,i2).d(1,1)+fcl(id1)*cf78(
     & i1,i2).ek0
      u156_78(i1,i2).d(2,2)=u156_78(i1,i2).d(2,2)+fcr(id1)*cf78(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id1.eq.5.and.id7.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p156,qd=p234,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p156k0*p234(2)+p234k0*p156(2)
      cauxa=auxa-cim*(p234(3)*p156k0-p156(3)*p234k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p234k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p156k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s78-cmh2)+rhhbb**2/(s78-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u156_78(i1,i2).a(i3,i4)=ch78(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u156_78(i1,i2).b(i3,i4)=ch78(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u156_78(i1,i2).c(i3,i4)=ch78(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u156_78(i1,i2).a(i3,i4)=czero
                else
                  u156_78(i1,i2).b(i3,i4)=czero
                  u156_78(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p178,q=p256
      quqd=p178(0)*p256(0)-p178(1)*p256(1)-p178(2)*p256(2)-p178(
     & 3)*p256(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p178,qd=p256,v=cz34(i1,i2).e,a=u178_34(i1,i2).a,b=u178_34(i1,i
* 2).b,c=u178_34(i1,i2).c,d=u178_34(i1,i2).d,cr=zcr(id1),cl=zcl(id1),nsu
* m=0
      ceps_0=-cz34(i1,i2).ek0*(p178(2)*p256(3)-p256(2)*p178(3))+
     & p178k0*(cz34(i1,i2).e(2)*p256(3)-p256(2)*cz34(i1,i2).e(3)
     & )-p256k0*(cz34(i1,i2).e(2)*p178(3)-p178(2)*cz34(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz34(i1,i2).e(3)*p178k0+p178(3)*cz34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz34(i1,i2).e(3)*p256k0+p256(3)*cz34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz34(i1,i2).e(0)*p178(0)-cz34(i1,i2).e(1)*p178(1)-cz3
     & 4(i1,i2).e(2)*p178(2)-cz34(i1,i2).e(3)*p178(3)
      cvqd=cz34(i1,i2).e(0)*p256(0)-cz34(i1,i2).e(1)*p256(1)-cz3
     & 4(i1,i2).e(2)*p256(2)-cz34(i1,i2).e(3)*p256(3)
      cauxa=-cz34(i1,i2).ek0*quqd+p178k0*cvqd+p256k0*cvqu
      cauxb=-cz34(i1,i2).ek0*p256(2)+p256k0*cz34(i1,i2).e(2)
      cauxc=+cz34(i1,i2).ek0*p178(2)-p178k0*cz34(i1,i2).e(2)
      u178_34(i1,i2).a(1,1)=zcr(id1)*(cauxa+ceps_0)
      u178_34(i1,i2).a(2,2)=zcl(id1)*(cauxa-ceps_0)
      u178_34(i1,i2).b(1,2)=zcl(id1)*(cauxb-ceps_2)
      u178_34(i1,i2).b(2,1)=zcr(id1)*(-cauxb-ceps_2)
      u178_34(i1,i2).c(1,2)=zcr(id1)*(cauxc+ceps_1)
      u178_34(i1,i2).c(2,1)=zcl(id1)*(-cauxc+ceps_1)
      u178_34(i1,i2).d(1,1)=zcl(id1)*cz34(i1,i2).ek0
      u178_34(i1,i2).d(2,2)=zcr(id1)*cz34(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p178,qd=p256,v=cf34(i1,i2).e,a=u178_34(i1,i2).a,b=u178_34(i1,i
* 2).b,c=u178_34(i1,i2).c,d=u178_34(i1,i2).d,cr=fcr(id1),cl=fcl(id1),nsu
* m=1
      ceps_0=-cf34(i1,i2).ek0*(p178(2)*p256(3)-p256(2)*p178(3))+
     & p178k0*(cf34(i1,i2).e(2)*p256(3)-p256(2)*cf34(i1,i2).e(3)
     & )-p256k0*(cf34(i1,i2).e(2)*p178(3)-p178(2)*cf34(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf34(i1,i2).e(3)*p178k0+p178(3)*cf34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf34(i1,i2).e(3)*p256k0+p256(3)*cf34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf34(i1,i2).e(0)*p178(0)-cf34(i1,i2).e(1)*p178(1)-cf3
     & 4(i1,i2).e(2)*p178(2)-cf34(i1,i2).e(3)*p178(3)
      cvqd=cf34(i1,i2).e(0)*p256(0)-cf34(i1,i2).e(1)*p256(1)-cf3
     & 4(i1,i2).e(2)*p256(2)-cf34(i1,i2).e(3)*p256(3)
      cauxa=-cf34(i1,i2).ek0*quqd+p178k0*cvqd+p256k0*cvqu
      cauxb=-cf34(i1,i2).ek0*p256(2)+p256k0*cf34(i1,i2).e(2)
      cauxc=+cf34(i1,i2).ek0*p178(2)-p178k0*cf34(i1,i2).e(2)
      u178_34(i1,i2).a(1,1)=u178_34(i1,i2).a(1,1)+fcr(id1)*(caux
     & a+ceps_0)
      u178_34(i1,i2).a(2,2)=u178_34(i1,i2).a(2,2)+fcl(id1)*(caux
     & a-ceps_0)
      u178_34(i1,i2).b(1,2)=u178_34(i1,i2).b(1,2)+fcl(id1)*(caux
     & b-ceps_2)
      u178_34(i1,i2).b(2,1)=u178_34(i1,i2).b(2,1)+fcr(id1)*(-cau
     & xb-ceps_2)
      u178_34(i1,i2).c(1,2)=u178_34(i1,i2).c(1,2)+fcr(id1)*(caux
     & c+ceps_1)
      u178_34(i1,i2).c(2,1)=u178_34(i1,i2).c(2,1)+fcl(id1)*(-cau
     & xc+ceps_1)
      u178_34(i1,i2).d(1,1)=u178_34(i1,i2).d(1,1)+fcl(id1)*cf34(
     & i1,i2).ek0
      u178_34(i1,i2).d(2,2)=u178_34(i1,i2).d(2,2)+fcr(id1)*cf34(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id1.eq.5.and.id3.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p178,qd=p256,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p178k0*p256(2)+p256k0*p178(2)
      cauxa=auxa-cim*(p256(3)*p178k0-p178(3)*p256k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p256k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p178k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s34-cmh2)+rhhbb**2/(s34-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u178_34(i1,i2).a(i3,i4)=ch34(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u178_34(i1,i2).b(i3,i4)=ch34(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u178_34(i1,i2).c(i3,i4)=ch34(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u178_34(i1,i2).a(i3,i4)=czero
                else
                  u178_34(i1,i2).b(i3,i4)=czero
                  u178_34(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p178,q=p234
      quqd=p178(0)*p234(0)-p178(1)*p234(1)-p178(2)*p234(2)-p178(
     & 3)*p234(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p178,qd=p234,v=cz56(i1,i2).e,a=u178_56(i1,i2).a,b=u178_56(i1,i
* 2).b,c=u178_56(i1,i2).c,d=u178_56(i1,i2).d,cr=zcr(id1),cl=zcl(id1),nsu
* m=0
      ceps_0=-cz56(i1,i2).ek0*(p178(2)*p234(3)-p234(2)*p178(3))+
     & p178k0*(cz56(i1,i2).e(2)*p234(3)-p234(2)*cz56(i1,i2).e(3)
     & )-p234k0*(cz56(i1,i2).e(2)*p178(3)-p178(2)*cz56(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz56(i1,i2).e(3)*p178k0+p178(3)*cz56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz56(i1,i2).e(3)*p234k0+p234(3)*cz56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz56(i1,i2).e(0)*p178(0)-cz56(i1,i2).e(1)*p178(1)-cz5
     & 6(i1,i2).e(2)*p178(2)-cz56(i1,i2).e(3)*p178(3)
      cvqd=cz56(i1,i2).e(0)*p234(0)-cz56(i1,i2).e(1)*p234(1)-cz5
     & 6(i1,i2).e(2)*p234(2)-cz56(i1,i2).e(3)*p234(3)
      cauxa=-cz56(i1,i2).ek0*quqd+p178k0*cvqd+p234k0*cvqu
      cauxb=-cz56(i1,i2).ek0*p234(2)+p234k0*cz56(i1,i2).e(2)
      cauxc=+cz56(i1,i2).ek0*p178(2)-p178k0*cz56(i1,i2).e(2)
      u178_56(i1,i2).a(1,1)=zcr(id1)*(cauxa+ceps_0)
      u178_56(i1,i2).a(2,2)=zcl(id1)*(cauxa-ceps_0)
      u178_56(i1,i2).b(1,2)=zcl(id1)*(cauxb-ceps_2)
      u178_56(i1,i2).b(2,1)=zcr(id1)*(-cauxb-ceps_2)
      u178_56(i1,i2).c(1,2)=zcr(id1)*(cauxc+ceps_1)
      u178_56(i1,i2).c(2,1)=zcl(id1)*(-cauxc+ceps_1)
      u178_56(i1,i2).d(1,1)=zcl(id1)*cz56(i1,i2).ek0
      u178_56(i1,i2).d(2,2)=zcr(id1)*cz56(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p178,qd=p234,v=cf56(i1,i2).e,a=u178_56(i1,i2).a,b=u178_56(i1,i
* 2).b,c=u178_56(i1,i2).c,d=u178_56(i1,i2).d,cr=fcr(id1),cl=fcl(id1),nsu
* m=1
      ceps_0=-cf56(i1,i2).ek0*(p178(2)*p234(3)-p234(2)*p178(3))+
     & p178k0*(cf56(i1,i2).e(2)*p234(3)-p234(2)*cf56(i1,i2).e(3)
     & )-p234k0*(cf56(i1,i2).e(2)*p178(3)-p178(2)*cf56(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf56(i1,i2).e(3)*p178k0+p178(3)*cf56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf56(i1,i2).e(3)*p234k0+p234(3)*cf56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf56(i1,i2).e(0)*p178(0)-cf56(i1,i2).e(1)*p178(1)-cf5
     & 6(i1,i2).e(2)*p178(2)-cf56(i1,i2).e(3)*p178(3)
      cvqd=cf56(i1,i2).e(0)*p234(0)-cf56(i1,i2).e(1)*p234(1)-cf5
     & 6(i1,i2).e(2)*p234(2)-cf56(i1,i2).e(3)*p234(3)
      cauxa=-cf56(i1,i2).ek0*quqd+p178k0*cvqd+p234k0*cvqu
      cauxb=-cf56(i1,i2).ek0*p234(2)+p234k0*cf56(i1,i2).e(2)
      cauxc=+cf56(i1,i2).ek0*p178(2)-p178k0*cf56(i1,i2).e(2)
      u178_56(i1,i2).a(1,1)=u178_56(i1,i2).a(1,1)+fcr(id1)*(caux
     & a+ceps_0)
      u178_56(i1,i2).a(2,2)=u178_56(i1,i2).a(2,2)+fcl(id1)*(caux
     & a-ceps_0)
      u178_56(i1,i2).b(1,2)=u178_56(i1,i2).b(1,2)+fcl(id1)*(caux
     & b-ceps_2)
      u178_56(i1,i2).b(2,1)=u178_56(i1,i2).b(2,1)+fcr(id1)*(-cau
     & xb-ceps_2)
      u178_56(i1,i2).c(1,2)=u178_56(i1,i2).c(1,2)+fcr(id1)*(caux
     & c+ceps_1)
      u178_56(i1,i2).c(2,1)=u178_56(i1,i2).c(2,1)+fcl(id1)*(-cau
     & xc+ceps_1)
      u178_56(i1,i2).d(1,1)=u178_56(i1,i2).d(1,1)+fcl(id1)*cf56(
     & i1,i2).ek0
      u178_56(i1,i2).d(2,2)=u178_56(i1,i2).d(2,2)+fcr(id1)*cf56(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id1.eq.5.and.id5.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p178,qd=p234,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p178k0*p234(2)+p234k0*p178(2)
      cauxa=auxa-cim*(p234(3)*p178k0-p178(3)*p234k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p234k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p178k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s56-cmh2)+rhhbb**2/(s56-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u178_56(i1,i2).a(i3,i4)=ch56(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u178_56(i1,i2).b(i3,i4)=ch56(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u178_56(i1,i2).c(i3,i4)=ch56(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u178_56(i1,i2).a(i3,i4)=czero
                else
                  u178_56(i1,i2).b(i3,i4)=czero
                  u178_56(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p312,q=p478
      quqd=p312(0)*p478(0)-p312(1)*p478(1)-p312(2)*p478(2)-p312(
     & 3)*p478(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p312,qd=p478,v=cz56(i1,i2).e,a=u312_56(i1,i2).a,b=u312_56(i1,i
* 2).b,c=u312_56(i1,i2).c,d=u312_56(i1,i2).d,cr=zcr(id3),cl=zcl(id3),nsu
* m=0
      ceps_0=-cz56(i1,i2).ek0*(p312(2)*p478(3)-p478(2)*p312(3))+
     & p312k0*(cz56(i1,i2).e(2)*p478(3)-p478(2)*cz56(i1,i2).e(3)
     & )-p478k0*(cz56(i1,i2).e(2)*p312(3)-p312(2)*cz56(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz56(i1,i2).e(3)*p312k0+p312(3)*cz56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz56(i1,i2).e(3)*p478k0+p478(3)*cz56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz56(i1,i2).e(0)*p312(0)-cz56(i1,i2).e(1)*p312(1)-cz5
     & 6(i1,i2).e(2)*p312(2)-cz56(i1,i2).e(3)*p312(3)
      cvqd=cz56(i1,i2).e(0)*p478(0)-cz56(i1,i2).e(1)*p478(1)-cz5
     & 6(i1,i2).e(2)*p478(2)-cz56(i1,i2).e(3)*p478(3)
      cauxa=-cz56(i1,i2).ek0*quqd+p312k0*cvqd+p478k0*cvqu
      cauxb=-cz56(i1,i2).ek0*p478(2)+p478k0*cz56(i1,i2).e(2)
      cauxc=+cz56(i1,i2).ek0*p312(2)-p312k0*cz56(i1,i2).e(2)
      u312_56(i1,i2).a(1,1)=zcr(id3)*(cauxa+ceps_0)
      u312_56(i1,i2).a(2,2)=zcl(id3)*(cauxa-ceps_0)
      u312_56(i1,i2).b(1,2)=zcl(id3)*(cauxb-ceps_2)
      u312_56(i1,i2).b(2,1)=zcr(id3)*(-cauxb-ceps_2)
      u312_56(i1,i2).c(1,2)=zcr(id3)*(cauxc+ceps_1)
      u312_56(i1,i2).c(2,1)=zcl(id3)*(-cauxc+ceps_1)
      u312_56(i1,i2).d(1,1)=zcl(id3)*cz56(i1,i2).ek0
      u312_56(i1,i2).d(2,2)=zcr(id3)*cz56(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p312,qd=p478,v=cf56(i1,i2).e,a=u312_56(i1,i2).a,b=u312_56(i1,i
* 2).b,c=u312_56(i1,i2).c,d=u312_56(i1,i2).d,cr=fcr(id3),cl=fcl(id3),nsu
* m=1
      ceps_0=-cf56(i1,i2).ek0*(p312(2)*p478(3)-p478(2)*p312(3))+
     & p312k0*(cf56(i1,i2).e(2)*p478(3)-p478(2)*cf56(i1,i2).e(3)
     & )-p478k0*(cf56(i1,i2).e(2)*p312(3)-p312(2)*cf56(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf56(i1,i2).e(3)*p312k0+p312(3)*cf56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf56(i1,i2).e(3)*p478k0+p478(3)*cf56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf56(i1,i2).e(0)*p312(0)-cf56(i1,i2).e(1)*p312(1)-cf5
     & 6(i1,i2).e(2)*p312(2)-cf56(i1,i2).e(3)*p312(3)
      cvqd=cf56(i1,i2).e(0)*p478(0)-cf56(i1,i2).e(1)*p478(1)-cf5
     & 6(i1,i2).e(2)*p478(2)-cf56(i1,i2).e(3)*p478(3)
      cauxa=-cf56(i1,i2).ek0*quqd+p312k0*cvqd+p478k0*cvqu
      cauxb=-cf56(i1,i2).ek0*p478(2)+p478k0*cf56(i1,i2).e(2)
      cauxc=+cf56(i1,i2).ek0*p312(2)-p312k0*cf56(i1,i2).e(2)
      u312_56(i1,i2).a(1,1)=u312_56(i1,i2).a(1,1)+fcr(id3)*(caux
     & a+ceps_0)
      u312_56(i1,i2).a(2,2)=u312_56(i1,i2).a(2,2)+fcl(id3)*(caux
     & a-ceps_0)
      u312_56(i1,i2).b(1,2)=u312_56(i1,i2).b(1,2)+fcl(id3)*(caux
     & b-ceps_2)
      u312_56(i1,i2).b(2,1)=u312_56(i1,i2).b(2,1)+fcr(id3)*(-cau
     & xb-ceps_2)
      u312_56(i1,i2).c(1,2)=u312_56(i1,i2).c(1,2)+fcr(id3)*(caux
     & c+ceps_1)
      u312_56(i1,i2).c(2,1)=u312_56(i1,i2).c(2,1)+fcl(id3)*(-cau
     & xc+ceps_1)
      u312_56(i1,i2).d(1,1)=u312_56(i1,i2).d(1,1)+fcl(id3)*cf56(
     & i1,i2).ek0
      u312_56(i1,i2).d(2,2)=u312_56(i1,i2).d(2,2)+fcr(id3)*cf56(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id3.eq.5.and.id5.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p312,qd=p478,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p312k0*p478(2)+p478k0*p312(2)
      cauxa=auxa-cim*(p478(3)*p312k0-p312(3)*p478k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p478k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p312k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s56-cmh2)+rhhbb**2/(s56-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u312_56(i1,i2).a(i3,i4)=ch56(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u312_56(i1,i2).b(i3,i4)=ch56(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u312_56(i1,i2).c(i3,i4)=ch56(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u312_56(i1,i2).a(i3,i4)=czero
                else
                  u312_56(i1,i2).b(i3,i4)=czero
                  u312_56(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p312,q=p456
      quqd=p312(0)*p456(0)-p312(1)*p456(1)-p312(2)*p456(2)-p312(
     & 3)*p456(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p312,qd=p456,v=cz78(i1,i2).e,a=u312_78(i1,i2).a,b=u312_78(i1,i
* 2).b,c=u312_78(i1,i2).c,d=u312_78(i1,i2).d,cr=zcr(id3),cl=zcl(id3),nsu
* m=0
      ceps_0=-cz78(i1,i2).ek0*(p312(2)*p456(3)-p456(2)*p312(3))+
     & p312k0*(cz78(i1,i2).e(2)*p456(3)-p456(2)*cz78(i1,i2).e(3)
     & )-p456k0*(cz78(i1,i2).e(2)*p312(3)-p312(2)*cz78(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz78(i1,i2).e(3)*p312k0+p312(3)*cz78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz78(i1,i2).e(3)*p456k0+p456(3)*cz78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz78(i1,i2).e(0)*p312(0)-cz78(i1,i2).e(1)*p312(1)-cz7
     & 8(i1,i2).e(2)*p312(2)-cz78(i1,i2).e(3)*p312(3)
      cvqd=cz78(i1,i2).e(0)*p456(0)-cz78(i1,i2).e(1)*p456(1)-cz7
     & 8(i1,i2).e(2)*p456(2)-cz78(i1,i2).e(3)*p456(3)
      cauxa=-cz78(i1,i2).ek0*quqd+p312k0*cvqd+p456k0*cvqu
      cauxb=-cz78(i1,i2).ek0*p456(2)+p456k0*cz78(i1,i2).e(2)
      cauxc=+cz78(i1,i2).ek0*p312(2)-p312k0*cz78(i1,i2).e(2)
      u312_78(i1,i2).a(1,1)=zcr(id3)*(cauxa+ceps_0)
      u312_78(i1,i2).a(2,2)=zcl(id3)*(cauxa-ceps_0)
      u312_78(i1,i2).b(1,2)=zcl(id3)*(cauxb-ceps_2)
      u312_78(i1,i2).b(2,1)=zcr(id3)*(-cauxb-ceps_2)
      u312_78(i1,i2).c(1,2)=zcr(id3)*(cauxc+ceps_1)
      u312_78(i1,i2).c(2,1)=zcl(id3)*(-cauxc+ceps_1)
      u312_78(i1,i2).d(1,1)=zcl(id3)*cz78(i1,i2).ek0
      u312_78(i1,i2).d(2,2)=zcr(id3)*cz78(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p312,qd=p456,v=cf78(i1,i2).e,a=u312_78(i1,i2).a,b=u312_78(i1,i
* 2).b,c=u312_78(i1,i2).c,d=u312_78(i1,i2).d,cr=fcr(id3),cl=fcl(id3),nsu
* m=1
      ceps_0=-cf78(i1,i2).ek0*(p312(2)*p456(3)-p456(2)*p312(3))+
     & p312k0*(cf78(i1,i2).e(2)*p456(3)-p456(2)*cf78(i1,i2).e(3)
     & )-p456k0*(cf78(i1,i2).e(2)*p312(3)-p312(2)*cf78(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf78(i1,i2).e(3)*p312k0+p312(3)*cf78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf78(i1,i2).e(3)*p456k0+p456(3)*cf78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf78(i1,i2).e(0)*p312(0)-cf78(i1,i2).e(1)*p312(1)-cf7
     & 8(i1,i2).e(2)*p312(2)-cf78(i1,i2).e(3)*p312(3)
      cvqd=cf78(i1,i2).e(0)*p456(0)-cf78(i1,i2).e(1)*p456(1)-cf7
     & 8(i1,i2).e(2)*p456(2)-cf78(i1,i2).e(3)*p456(3)
      cauxa=-cf78(i1,i2).ek0*quqd+p312k0*cvqd+p456k0*cvqu
      cauxb=-cf78(i1,i2).ek0*p456(2)+p456k0*cf78(i1,i2).e(2)
      cauxc=+cf78(i1,i2).ek0*p312(2)-p312k0*cf78(i1,i2).e(2)
      u312_78(i1,i2).a(1,1)=u312_78(i1,i2).a(1,1)+fcr(id3)*(caux
     & a+ceps_0)
      u312_78(i1,i2).a(2,2)=u312_78(i1,i2).a(2,2)+fcl(id3)*(caux
     & a-ceps_0)
      u312_78(i1,i2).b(1,2)=u312_78(i1,i2).b(1,2)+fcl(id3)*(caux
     & b-ceps_2)
      u312_78(i1,i2).b(2,1)=u312_78(i1,i2).b(2,1)+fcr(id3)*(-cau
     & xb-ceps_2)
      u312_78(i1,i2).c(1,2)=u312_78(i1,i2).c(1,2)+fcr(id3)*(caux
     & c+ceps_1)
      u312_78(i1,i2).c(2,1)=u312_78(i1,i2).c(2,1)+fcl(id3)*(-cau
     & xc+ceps_1)
      u312_78(i1,i2).d(1,1)=u312_78(i1,i2).d(1,1)+fcl(id3)*cf78(
     & i1,i2).ek0
      u312_78(i1,i2).d(2,2)=u312_78(i1,i2).d(2,2)+fcr(id3)*cf78(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id3.eq.5.and.id7.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p312,qd=p456,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p312k0*p456(2)+p456k0*p312(2)
      cauxa=auxa-cim*(p456(3)*p312k0-p312(3)*p456k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p456k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p312k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s78-cmh2)+rhhbb**2/(s78-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u312_78(i1,i2).a(i3,i4)=ch78(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u312_78(i1,i2).b(i3,i4)=ch78(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u312_78(i1,i2).c(i3,i4)=ch78(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u312_78(i1,i2).a(i3,i4)=czero
                else
                  u312_78(i1,i2).b(i3,i4)=czero
                  u312_78(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p356,q=p478
      quqd=p356(0)*p478(0)-p356(1)*p478(1)-p356(2)*p478(2)-p356(
     & 3)*p478(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p356,qd=p478,v=cz12(i1,i2).e,a=u356_12(i1,i2).a,b=u356_12(i1,i
* 2).b,c=u356_12(i1,i2).c,d=u356_12(i1,i2).d,cr=zcr(id3),cl=zcl(id3),nsu
* m=0
      ceps_0=-cz12(i1,i2).ek0*(p356(2)*p478(3)-p478(2)*p356(3))+
     & p356k0*(cz12(i1,i2).e(2)*p478(3)-p478(2)*cz12(i1,i2).e(3)
     & )-p478k0*(cz12(i1,i2).e(2)*p356(3)-p356(2)*cz12(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz12(i1,i2).e(3)*p356k0+p356(3)*cz12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz12(i1,i2).e(3)*p478k0+p478(3)*cz12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz12(i1,i2).e(0)*p356(0)-cz12(i1,i2).e(1)*p356(1)-cz1
     & 2(i1,i2).e(2)*p356(2)-cz12(i1,i2).e(3)*p356(3)
      cvqd=cz12(i1,i2).e(0)*p478(0)-cz12(i1,i2).e(1)*p478(1)-cz1
     & 2(i1,i2).e(2)*p478(2)-cz12(i1,i2).e(3)*p478(3)
      cauxa=-cz12(i1,i2).ek0*quqd+p356k0*cvqd+p478k0*cvqu
      cauxb=-cz12(i1,i2).ek0*p478(2)+p478k0*cz12(i1,i2).e(2)
      cauxc=+cz12(i1,i2).ek0*p356(2)-p356k0*cz12(i1,i2).e(2)
      u356_12(i1,i2).a(1,1)=zcr(id3)*(cauxa+ceps_0)
      u356_12(i1,i2).a(2,2)=zcl(id3)*(cauxa-ceps_0)
      u356_12(i1,i2).b(1,2)=zcl(id3)*(cauxb-ceps_2)
      u356_12(i1,i2).b(2,1)=zcr(id3)*(-cauxb-ceps_2)
      u356_12(i1,i2).c(1,2)=zcr(id3)*(cauxc+ceps_1)
      u356_12(i1,i2).c(2,1)=zcl(id3)*(-cauxc+ceps_1)
      u356_12(i1,i2).d(1,1)=zcl(id3)*cz12(i1,i2).ek0
      u356_12(i1,i2).d(2,2)=zcr(id3)*cz12(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p356,qd=p478,v=cf12(i1,i2).e,a=u356_12(i1,i2).a,b=u356_12(i1,i
* 2).b,c=u356_12(i1,i2).c,d=u356_12(i1,i2).d,cr=fcr(id3),cl=fcl(id3),nsu
* m=1
      ceps_0=-cf12(i1,i2).ek0*(p356(2)*p478(3)-p478(2)*p356(3))+
     & p356k0*(cf12(i1,i2).e(2)*p478(3)-p478(2)*cf12(i1,i2).e(3)
     & )-p478k0*(cf12(i1,i2).e(2)*p356(3)-p356(2)*cf12(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf12(i1,i2).e(3)*p356k0+p356(3)*cf12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf12(i1,i2).e(3)*p478k0+p478(3)*cf12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf12(i1,i2).e(0)*p356(0)-cf12(i1,i2).e(1)*p356(1)-cf1
     & 2(i1,i2).e(2)*p356(2)-cf12(i1,i2).e(3)*p356(3)
      cvqd=cf12(i1,i2).e(0)*p478(0)-cf12(i1,i2).e(1)*p478(1)-cf1
     & 2(i1,i2).e(2)*p478(2)-cf12(i1,i2).e(3)*p478(3)
      cauxa=-cf12(i1,i2).ek0*quqd+p356k0*cvqd+p478k0*cvqu
      cauxb=-cf12(i1,i2).ek0*p478(2)+p478k0*cf12(i1,i2).e(2)
      cauxc=+cf12(i1,i2).ek0*p356(2)-p356k0*cf12(i1,i2).e(2)
      u356_12(i1,i2).a(1,1)=u356_12(i1,i2).a(1,1)+fcr(id3)*(caux
     & a+ceps_0)
      u356_12(i1,i2).a(2,2)=u356_12(i1,i2).a(2,2)+fcl(id3)*(caux
     & a-ceps_0)
      u356_12(i1,i2).b(1,2)=u356_12(i1,i2).b(1,2)+fcl(id3)*(caux
     & b-ceps_2)
      u356_12(i1,i2).b(2,1)=u356_12(i1,i2).b(2,1)+fcr(id3)*(-cau
     & xb-ceps_2)
      u356_12(i1,i2).c(1,2)=u356_12(i1,i2).c(1,2)+fcr(id3)*(caux
     & c+ceps_1)
      u356_12(i1,i2).c(2,1)=u356_12(i1,i2).c(2,1)+fcl(id3)*(-cau
     & xc+ceps_1)
      u356_12(i1,i2).d(1,1)=u356_12(i1,i2).d(1,1)+fcl(id3)*cf12(
     & i1,i2).ek0
      u356_12(i1,i2).d(2,2)=u356_12(i1,i2).d(2,2)+fcr(id3)*cf12(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id3.eq.5.and.id1.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p356,qd=p478,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p356k0*p478(2)+p478k0*p356(2)
      cauxa=auxa-cim*(p478(3)*p356k0-p356(3)*p478k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p478k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p356k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s12-cmh2)+rhhbb**2/(s12-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u356_12(i1,i2).a(i3,i4)=ch12(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u356_12(i1,i2).b(i3,i4)=ch12(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u356_12(i1,i2).c(i3,i4)=ch12(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u356_12(i1,i2).a(i3,i4)=czero
                else
                  u356_12(i1,i2).b(i3,i4)=czero
                  u356_12(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p356,q=p412
      quqd=p356(0)*p412(0)-p356(1)*p412(1)-p356(2)*p412(2)-p356(
     & 3)*p412(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p356,qd=p412,v=cz78(i1,i2).e,a=u356_78(i1,i2).a,b=u356_78(i1,i
* 2).b,c=u356_78(i1,i2).c,d=u356_78(i1,i2).d,cr=zcr(id3),cl=zcl(id3),nsu
* m=0
      ceps_0=-cz78(i1,i2).ek0*(p356(2)*p412(3)-p412(2)*p356(3))+
     & p356k0*(cz78(i1,i2).e(2)*p412(3)-p412(2)*cz78(i1,i2).e(3)
     & )-p412k0*(cz78(i1,i2).e(2)*p356(3)-p356(2)*cz78(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz78(i1,i2).e(3)*p356k0+p356(3)*cz78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz78(i1,i2).e(3)*p412k0+p412(3)*cz78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz78(i1,i2).e(0)*p356(0)-cz78(i1,i2).e(1)*p356(1)-cz7
     & 8(i1,i2).e(2)*p356(2)-cz78(i1,i2).e(3)*p356(3)
      cvqd=cz78(i1,i2).e(0)*p412(0)-cz78(i1,i2).e(1)*p412(1)-cz7
     & 8(i1,i2).e(2)*p412(2)-cz78(i1,i2).e(3)*p412(3)
      cauxa=-cz78(i1,i2).ek0*quqd+p356k0*cvqd+p412k0*cvqu
      cauxb=-cz78(i1,i2).ek0*p412(2)+p412k0*cz78(i1,i2).e(2)
      cauxc=+cz78(i1,i2).ek0*p356(2)-p356k0*cz78(i1,i2).e(2)
      u356_78(i1,i2).a(1,1)=zcr(id3)*(cauxa+ceps_0)
      u356_78(i1,i2).a(2,2)=zcl(id3)*(cauxa-ceps_0)
      u356_78(i1,i2).b(1,2)=zcl(id3)*(cauxb-ceps_2)
      u356_78(i1,i2).b(2,1)=zcr(id3)*(-cauxb-ceps_2)
      u356_78(i1,i2).c(1,2)=zcr(id3)*(cauxc+ceps_1)
      u356_78(i1,i2).c(2,1)=zcl(id3)*(-cauxc+ceps_1)
      u356_78(i1,i2).d(1,1)=zcl(id3)*cz78(i1,i2).ek0
      u356_78(i1,i2).d(2,2)=zcr(id3)*cz78(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p356,qd=p412,v=cf78(i1,i2).e,a=u356_78(i1,i2).a,b=u356_78(i1,i
* 2).b,c=u356_78(i1,i2).c,d=u356_78(i1,i2).d,cr=fcr(id3),cl=fcl(id3),nsu
* m=1
      ceps_0=-cf78(i1,i2).ek0*(p356(2)*p412(3)-p412(2)*p356(3))+
     & p356k0*(cf78(i1,i2).e(2)*p412(3)-p412(2)*cf78(i1,i2).e(3)
     & )-p412k0*(cf78(i1,i2).e(2)*p356(3)-p356(2)*cf78(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf78(i1,i2).e(3)*p356k0+p356(3)*cf78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf78(i1,i2).e(3)*p412k0+p412(3)*cf78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf78(i1,i2).e(0)*p356(0)-cf78(i1,i2).e(1)*p356(1)-cf7
     & 8(i1,i2).e(2)*p356(2)-cf78(i1,i2).e(3)*p356(3)
      cvqd=cf78(i1,i2).e(0)*p412(0)-cf78(i1,i2).e(1)*p412(1)-cf7
     & 8(i1,i2).e(2)*p412(2)-cf78(i1,i2).e(3)*p412(3)
      cauxa=-cf78(i1,i2).ek0*quqd+p356k0*cvqd+p412k0*cvqu
      cauxb=-cf78(i1,i2).ek0*p412(2)+p412k0*cf78(i1,i2).e(2)
      cauxc=+cf78(i1,i2).ek0*p356(2)-p356k0*cf78(i1,i2).e(2)
      u356_78(i1,i2).a(1,1)=u356_78(i1,i2).a(1,1)+fcr(id3)*(caux
     & a+ceps_0)
      u356_78(i1,i2).a(2,2)=u356_78(i1,i2).a(2,2)+fcl(id3)*(caux
     & a-ceps_0)
      u356_78(i1,i2).b(1,2)=u356_78(i1,i2).b(1,2)+fcl(id3)*(caux
     & b-ceps_2)
      u356_78(i1,i2).b(2,1)=u356_78(i1,i2).b(2,1)+fcr(id3)*(-cau
     & xb-ceps_2)
      u356_78(i1,i2).c(1,2)=u356_78(i1,i2).c(1,2)+fcr(id3)*(caux
     & c+ceps_1)
      u356_78(i1,i2).c(2,1)=u356_78(i1,i2).c(2,1)+fcl(id3)*(-cau
     & xc+ceps_1)
      u356_78(i1,i2).d(1,1)=u356_78(i1,i2).d(1,1)+fcl(id3)*cf78(
     & i1,i2).ek0
      u356_78(i1,i2).d(2,2)=u356_78(i1,i2).d(2,2)+fcr(id3)*cf78(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id3.eq.5.and.id7.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p356,qd=p412,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p356k0*p412(2)+p412k0*p356(2)
      cauxa=auxa-cim*(p412(3)*p356k0-p356(3)*p412k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p412k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p356k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s78-cmh2)+rhhbb**2/(s78-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u356_78(i1,i2).a(i3,i4)=ch78(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u356_78(i1,i2).b(i3,i4)=ch78(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u356_78(i1,i2).c(i3,i4)=ch78(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u356_78(i1,i2).a(i3,i4)=czero
                else
                  u356_78(i1,i2).b(i3,i4)=czero
                  u356_78(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p378,q=p456
      quqd=p378(0)*p456(0)-p378(1)*p456(1)-p378(2)*p456(2)-p378(
     & 3)*p456(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p378,qd=p456,v=cz12(i1,i2).e,a=u378_12(i1,i2).a,b=u378_12(i1,i
* 2).b,c=u378_12(i1,i2).c,d=u378_12(i1,i2).d,cr=zcr(id3),cl=zcl(id3),nsu
* m=0
      ceps_0=-cz12(i1,i2).ek0*(p378(2)*p456(3)-p456(2)*p378(3))+
     & p378k0*(cz12(i1,i2).e(2)*p456(3)-p456(2)*cz12(i1,i2).e(3)
     & )-p456k0*(cz12(i1,i2).e(2)*p378(3)-p378(2)*cz12(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz12(i1,i2).e(3)*p378k0+p378(3)*cz12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz12(i1,i2).e(3)*p456k0+p456(3)*cz12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz12(i1,i2).e(0)*p378(0)-cz12(i1,i2).e(1)*p378(1)-cz1
     & 2(i1,i2).e(2)*p378(2)-cz12(i1,i2).e(3)*p378(3)
      cvqd=cz12(i1,i2).e(0)*p456(0)-cz12(i1,i2).e(1)*p456(1)-cz1
     & 2(i1,i2).e(2)*p456(2)-cz12(i1,i2).e(3)*p456(3)
      cauxa=-cz12(i1,i2).ek0*quqd+p378k0*cvqd+p456k0*cvqu
      cauxb=-cz12(i1,i2).ek0*p456(2)+p456k0*cz12(i1,i2).e(2)
      cauxc=+cz12(i1,i2).ek0*p378(2)-p378k0*cz12(i1,i2).e(2)
      u378_12(i1,i2).a(1,1)=zcr(id3)*(cauxa+ceps_0)
      u378_12(i1,i2).a(2,2)=zcl(id3)*(cauxa-ceps_0)
      u378_12(i1,i2).b(1,2)=zcl(id3)*(cauxb-ceps_2)
      u378_12(i1,i2).b(2,1)=zcr(id3)*(-cauxb-ceps_2)
      u378_12(i1,i2).c(1,2)=zcr(id3)*(cauxc+ceps_1)
      u378_12(i1,i2).c(2,1)=zcl(id3)*(-cauxc+ceps_1)
      u378_12(i1,i2).d(1,1)=zcl(id3)*cz12(i1,i2).ek0
      u378_12(i1,i2).d(2,2)=zcr(id3)*cz12(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p378,qd=p456,v=cf12(i1,i2).e,a=u378_12(i1,i2).a,b=u378_12(i1,i
* 2).b,c=u378_12(i1,i2).c,d=u378_12(i1,i2).d,cr=fcr(id3),cl=fcl(id3),nsu
* m=1
      ceps_0=-cf12(i1,i2).ek0*(p378(2)*p456(3)-p456(2)*p378(3))+
     & p378k0*(cf12(i1,i2).e(2)*p456(3)-p456(2)*cf12(i1,i2).e(3)
     & )-p456k0*(cf12(i1,i2).e(2)*p378(3)-p378(2)*cf12(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf12(i1,i2).e(3)*p378k0+p378(3)*cf12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf12(i1,i2).e(3)*p456k0+p456(3)*cf12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf12(i1,i2).e(0)*p378(0)-cf12(i1,i2).e(1)*p378(1)-cf1
     & 2(i1,i2).e(2)*p378(2)-cf12(i1,i2).e(3)*p378(3)
      cvqd=cf12(i1,i2).e(0)*p456(0)-cf12(i1,i2).e(1)*p456(1)-cf1
     & 2(i1,i2).e(2)*p456(2)-cf12(i1,i2).e(3)*p456(3)
      cauxa=-cf12(i1,i2).ek0*quqd+p378k0*cvqd+p456k0*cvqu
      cauxb=-cf12(i1,i2).ek0*p456(2)+p456k0*cf12(i1,i2).e(2)
      cauxc=+cf12(i1,i2).ek0*p378(2)-p378k0*cf12(i1,i2).e(2)
      u378_12(i1,i2).a(1,1)=u378_12(i1,i2).a(1,1)+fcr(id3)*(caux
     & a+ceps_0)
      u378_12(i1,i2).a(2,2)=u378_12(i1,i2).a(2,2)+fcl(id3)*(caux
     & a-ceps_0)
      u378_12(i1,i2).b(1,2)=u378_12(i1,i2).b(1,2)+fcl(id3)*(caux
     & b-ceps_2)
      u378_12(i1,i2).b(2,1)=u378_12(i1,i2).b(2,1)+fcr(id3)*(-cau
     & xb-ceps_2)
      u378_12(i1,i2).c(1,2)=u378_12(i1,i2).c(1,2)+fcr(id3)*(caux
     & c+ceps_1)
      u378_12(i1,i2).c(2,1)=u378_12(i1,i2).c(2,1)+fcl(id3)*(-cau
     & xc+ceps_1)
      u378_12(i1,i2).d(1,1)=u378_12(i1,i2).d(1,1)+fcl(id3)*cf12(
     & i1,i2).ek0
      u378_12(i1,i2).d(2,2)=u378_12(i1,i2).d(2,2)+fcr(id3)*cf12(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id3.eq.5.and.id1.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p378,qd=p456,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p378k0*p456(2)+p456k0*p378(2)
      cauxa=auxa-cim*(p456(3)*p378k0-p378(3)*p456k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p456k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p378k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s12-cmh2)+rhhbb**2/(s12-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u378_12(i1,i2).a(i3,i4)=ch12(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u378_12(i1,i2).b(i3,i4)=ch12(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u378_12(i1,i2).c(i3,i4)=ch12(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u378_12(i1,i2).a(i3,i4)=czero
                else
                  u378_12(i1,i2).b(i3,i4)=czero
                  u378_12(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p378,q=p412
      quqd=p378(0)*p412(0)-p378(1)*p412(1)-p378(2)*p412(2)-p378(
     & 3)*p412(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p378,qd=p412,v=cz56(i1,i2).e,a=u378_56(i1,i2).a,b=u378_56(i1,i
* 2).b,c=u378_56(i1,i2).c,d=u378_56(i1,i2).d,cr=zcr(id3),cl=zcl(id3),nsu
* m=0
      ceps_0=-cz56(i1,i2).ek0*(p378(2)*p412(3)-p412(2)*p378(3))+
     & p378k0*(cz56(i1,i2).e(2)*p412(3)-p412(2)*cz56(i1,i2).e(3)
     & )-p412k0*(cz56(i1,i2).e(2)*p378(3)-p378(2)*cz56(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz56(i1,i2).e(3)*p378k0+p378(3)*cz56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz56(i1,i2).e(3)*p412k0+p412(3)*cz56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz56(i1,i2).e(0)*p378(0)-cz56(i1,i2).e(1)*p378(1)-cz5
     & 6(i1,i2).e(2)*p378(2)-cz56(i1,i2).e(3)*p378(3)
      cvqd=cz56(i1,i2).e(0)*p412(0)-cz56(i1,i2).e(1)*p412(1)-cz5
     & 6(i1,i2).e(2)*p412(2)-cz56(i1,i2).e(3)*p412(3)
      cauxa=-cz56(i1,i2).ek0*quqd+p378k0*cvqd+p412k0*cvqu
      cauxb=-cz56(i1,i2).ek0*p412(2)+p412k0*cz56(i1,i2).e(2)
      cauxc=+cz56(i1,i2).ek0*p378(2)-p378k0*cz56(i1,i2).e(2)
      u378_56(i1,i2).a(1,1)=zcr(id3)*(cauxa+ceps_0)
      u378_56(i1,i2).a(2,2)=zcl(id3)*(cauxa-ceps_0)
      u378_56(i1,i2).b(1,2)=zcl(id3)*(cauxb-ceps_2)
      u378_56(i1,i2).b(2,1)=zcr(id3)*(-cauxb-ceps_2)
      u378_56(i1,i2).c(1,2)=zcr(id3)*(cauxc+ceps_1)
      u378_56(i1,i2).c(2,1)=zcl(id3)*(-cauxc+ceps_1)
      u378_56(i1,i2).d(1,1)=zcl(id3)*cz56(i1,i2).ek0
      u378_56(i1,i2).d(2,2)=zcr(id3)*cz56(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p378,qd=p412,v=cf56(i1,i2).e,a=u378_56(i1,i2).a,b=u378_56(i1,i
* 2).b,c=u378_56(i1,i2).c,d=u378_56(i1,i2).d,cr=fcr(id3),cl=fcl(id3),nsu
* m=1
      ceps_0=-cf56(i1,i2).ek0*(p378(2)*p412(3)-p412(2)*p378(3))+
     & p378k0*(cf56(i1,i2).e(2)*p412(3)-p412(2)*cf56(i1,i2).e(3)
     & )-p412k0*(cf56(i1,i2).e(2)*p378(3)-p378(2)*cf56(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf56(i1,i2).e(3)*p378k0+p378(3)*cf56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf56(i1,i2).e(3)*p412k0+p412(3)*cf56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf56(i1,i2).e(0)*p378(0)-cf56(i1,i2).e(1)*p378(1)-cf5
     & 6(i1,i2).e(2)*p378(2)-cf56(i1,i2).e(3)*p378(3)
      cvqd=cf56(i1,i2).e(0)*p412(0)-cf56(i1,i2).e(1)*p412(1)-cf5
     & 6(i1,i2).e(2)*p412(2)-cf56(i1,i2).e(3)*p412(3)
      cauxa=-cf56(i1,i2).ek0*quqd+p378k0*cvqd+p412k0*cvqu
      cauxb=-cf56(i1,i2).ek0*p412(2)+p412k0*cf56(i1,i2).e(2)
      cauxc=+cf56(i1,i2).ek0*p378(2)-p378k0*cf56(i1,i2).e(2)
      u378_56(i1,i2).a(1,1)=u378_56(i1,i2).a(1,1)+fcr(id3)*(caux
     & a+ceps_0)
      u378_56(i1,i2).a(2,2)=u378_56(i1,i2).a(2,2)+fcl(id3)*(caux
     & a-ceps_0)
      u378_56(i1,i2).b(1,2)=u378_56(i1,i2).b(1,2)+fcl(id3)*(caux
     & b-ceps_2)
      u378_56(i1,i2).b(2,1)=u378_56(i1,i2).b(2,1)+fcr(id3)*(-cau
     & xb-ceps_2)
      u378_56(i1,i2).c(1,2)=u378_56(i1,i2).c(1,2)+fcr(id3)*(caux
     & c+ceps_1)
      u378_56(i1,i2).c(2,1)=u378_56(i1,i2).c(2,1)+fcl(id3)*(-cau
     & xc+ceps_1)
      u378_56(i1,i2).d(1,1)=u378_56(i1,i2).d(1,1)+fcl(id3)*cf56(
     & i1,i2).ek0
      u378_56(i1,i2).d(2,2)=u378_56(i1,i2).d(2,2)+fcr(id3)*cf56(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id3.eq.5.and.id5.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p378,qd=p412,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p378k0*p412(2)+p412k0*p378(2)
      cauxa=auxa-cim*(p412(3)*p378k0-p378(3)*p412k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p412k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p378k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s56-cmh2)+rhhbb**2/(s56-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u378_56(i1,i2).a(i3,i4)=ch56(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u378_56(i1,i2).b(i3,i4)=ch56(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u378_56(i1,i2).c(i3,i4)=ch56(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u378_56(i1,i2).a(i3,i4)=czero
                else
                  u378_56(i1,i2).b(i3,i4)=czero
                  u378_56(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p512,q=p678
      quqd=p512(0)*p678(0)-p512(1)*p678(1)-p512(2)*p678(2)-p512(
     & 3)*p678(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p512,qd=p678,v=cz34(i1,i2).e,a=u512_34(i1,i2).a,b=u512_34(i1,i
* 2).b,c=u512_34(i1,i2).c,d=u512_34(i1,i2).d,cr=zcr(id5),cl=zcl(id5),nsu
* m=0
      ceps_0=-cz34(i1,i2).ek0*(p512(2)*p678(3)-p678(2)*p512(3))+
     & p512k0*(cz34(i1,i2).e(2)*p678(3)-p678(2)*cz34(i1,i2).e(3)
     & )-p678k0*(cz34(i1,i2).e(2)*p512(3)-p512(2)*cz34(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz34(i1,i2).e(3)*p512k0+p512(3)*cz34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz34(i1,i2).e(3)*p678k0+p678(3)*cz34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz34(i1,i2).e(0)*p512(0)-cz34(i1,i2).e(1)*p512(1)-cz3
     & 4(i1,i2).e(2)*p512(2)-cz34(i1,i2).e(3)*p512(3)
      cvqd=cz34(i1,i2).e(0)*p678(0)-cz34(i1,i2).e(1)*p678(1)-cz3
     & 4(i1,i2).e(2)*p678(2)-cz34(i1,i2).e(3)*p678(3)
      cauxa=-cz34(i1,i2).ek0*quqd+p512k0*cvqd+p678k0*cvqu
      cauxb=-cz34(i1,i2).ek0*p678(2)+p678k0*cz34(i1,i2).e(2)
      cauxc=+cz34(i1,i2).ek0*p512(2)-p512k0*cz34(i1,i2).e(2)
      u512_34(i1,i2).a(1,1)=zcr(id5)*(cauxa+ceps_0)
      u512_34(i1,i2).a(2,2)=zcl(id5)*(cauxa-ceps_0)
      u512_34(i1,i2).b(1,2)=zcl(id5)*(cauxb-ceps_2)
      u512_34(i1,i2).b(2,1)=zcr(id5)*(-cauxb-ceps_2)
      u512_34(i1,i2).c(1,2)=zcr(id5)*(cauxc+ceps_1)
      u512_34(i1,i2).c(2,1)=zcl(id5)*(-cauxc+ceps_1)
      u512_34(i1,i2).d(1,1)=zcl(id5)*cz34(i1,i2).ek0
      u512_34(i1,i2).d(2,2)=zcr(id5)*cz34(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p512,qd=p678,v=cf34(i1,i2).e,a=u512_34(i1,i2).a,b=u512_34(i1,i
* 2).b,c=u512_34(i1,i2).c,d=u512_34(i1,i2).d,cr=fcr(id5),cl=fcl(id5),nsu
* m=1
      ceps_0=-cf34(i1,i2).ek0*(p512(2)*p678(3)-p678(2)*p512(3))+
     & p512k0*(cf34(i1,i2).e(2)*p678(3)-p678(2)*cf34(i1,i2).e(3)
     & )-p678k0*(cf34(i1,i2).e(2)*p512(3)-p512(2)*cf34(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf34(i1,i2).e(3)*p512k0+p512(3)*cf34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf34(i1,i2).e(3)*p678k0+p678(3)*cf34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf34(i1,i2).e(0)*p512(0)-cf34(i1,i2).e(1)*p512(1)-cf3
     & 4(i1,i2).e(2)*p512(2)-cf34(i1,i2).e(3)*p512(3)
      cvqd=cf34(i1,i2).e(0)*p678(0)-cf34(i1,i2).e(1)*p678(1)-cf3
     & 4(i1,i2).e(2)*p678(2)-cf34(i1,i2).e(3)*p678(3)
      cauxa=-cf34(i1,i2).ek0*quqd+p512k0*cvqd+p678k0*cvqu
      cauxb=-cf34(i1,i2).ek0*p678(2)+p678k0*cf34(i1,i2).e(2)
      cauxc=+cf34(i1,i2).ek0*p512(2)-p512k0*cf34(i1,i2).e(2)
      u512_34(i1,i2).a(1,1)=u512_34(i1,i2).a(1,1)+fcr(id5)*(caux
     & a+ceps_0)
      u512_34(i1,i2).a(2,2)=u512_34(i1,i2).a(2,2)+fcl(id5)*(caux
     & a-ceps_0)
      u512_34(i1,i2).b(1,2)=u512_34(i1,i2).b(1,2)+fcl(id5)*(caux
     & b-ceps_2)
      u512_34(i1,i2).b(2,1)=u512_34(i1,i2).b(2,1)+fcr(id5)*(-cau
     & xb-ceps_2)
      u512_34(i1,i2).c(1,2)=u512_34(i1,i2).c(1,2)+fcr(id5)*(caux
     & c+ceps_1)
      u512_34(i1,i2).c(2,1)=u512_34(i1,i2).c(2,1)+fcl(id5)*(-cau
     & xc+ceps_1)
      u512_34(i1,i2).d(1,1)=u512_34(i1,i2).d(1,1)+fcl(id5)*cf34(
     & i1,i2).ek0
      u512_34(i1,i2).d(2,2)=u512_34(i1,i2).d(2,2)+fcr(id5)*cf34(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id5.eq.5.and.id3.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p512,qd=p678,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p512k0*p678(2)+p678k0*p512(2)
      cauxa=auxa-cim*(p678(3)*p512k0-p512(3)*p678k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p678k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p512k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s34-cmh2)+rhhbb**2/(s34-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u512_34(i1,i2).a(i3,i4)=ch34(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u512_34(i1,i2).b(i3,i4)=ch34(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u512_34(i1,i2).c(i3,i4)=ch34(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u512_34(i1,i2).a(i3,i4)=czero
                else
                  u512_34(i1,i2).b(i3,i4)=czero
                  u512_34(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p512,q=p634
      quqd=p512(0)*p634(0)-p512(1)*p634(1)-p512(2)*p634(2)-p512(
     & 3)*p634(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p512,qd=p634,v=cz78(i1,i2).e,a=u512_78(i1,i2).a,b=u512_78(i1,i
* 2).b,c=u512_78(i1,i2).c,d=u512_78(i1,i2).d,cr=zcr(id5),cl=zcl(id5),nsu
* m=0
      ceps_0=-cz78(i1,i2).ek0*(p512(2)*p634(3)-p634(2)*p512(3))+
     & p512k0*(cz78(i1,i2).e(2)*p634(3)-p634(2)*cz78(i1,i2).e(3)
     & )-p634k0*(cz78(i1,i2).e(2)*p512(3)-p512(2)*cz78(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz78(i1,i2).e(3)*p512k0+p512(3)*cz78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz78(i1,i2).e(3)*p634k0+p634(3)*cz78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz78(i1,i2).e(0)*p512(0)-cz78(i1,i2).e(1)*p512(1)-cz7
     & 8(i1,i2).e(2)*p512(2)-cz78(i1,i2).e(3)*p512(3)
      cvqd=cz78(i1,i2).e(0)*p634(0)-cz78(i1,i2).e(1)*p634(1)-cz7
     & 8(i1,i2).e(2)*p634(2)-cz78(i1,i2).e(3)*p634(3)
      cauxa=-cz78(i1,i2).ek0*quqd+p512k0*cvqd+p634k0*cvqu
      cauxb=-cz78(i1,i2).ek0*p634(2)+p634k0*cz78(i1,i2).e(2)
      cauxc=+cz78(i1,i2).ek0*p512(2)-p512k0*cz78(i1,i2).e(2)
      u512_78(i1,i2).a(1,1)=zcr(id5)*(cauxa+ceps_0)
      u512_78(i1,i2).a(2,2)=zcl(id5)*(cauxa-ceps_0)
      u512_78(i1,i2).b(1,2)=zcl(id5)*(cauxb-ceps_2)
      u512_78(i1,i2).b(2,1)=zcr(id5)*(-cauxb-ceps_2)
      u512_78(i1,i2).c(1,2)=zcr(id5)*(cauxc+ceps_1)
      u512_78(i1,i2).c(2,1)=zcl(id5)*(-cauxc+ceps_1)
      u512_78(i1,i2).d(1,1)=zcl(id5)*cz78(i1,i2).ek0
      u512_78(i1,i2).d(2,2)=zcr(id5)*cz78(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p512,qd=p634,v=cf78(i1,i2).e,a=u512_78(i1,i2).a,b=u512_78(i1,i
* 2).b,c=u512_78(i1,i2).c,d=u512_78(i1,i2).d,cr=fcr(id5),cl=fcl(id5),nsu
* m=1
      ceps_0=-cf78(i1,i2).ek0*(p512(2)*p634(3)-p634(2)*p512(3))+
     & p512k0*(cf78(i1,i2).e(2)*p634(3)-p634(2)*cf78(i1,i2).e(3)
     & )-p634k0*(cf78(i1,i2).e(2)*p512(3)-p512(2)*cf78(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf78(i1,i2).e(3)*p512k0+p512(3)*cf78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf78(i1,i2).e(3)*p634k0+p634(3)*cf78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf78(i1,i2).e(0)*p512(0)-cf78(i1,i2).e(1)*p512(1)-cf7
     & 8(i1,i2).e(2)*p512(2)-cf78(i1,i2).e(3)*p512(3)
      cvqd=cf78(i1,i2).e(0)*p634(0)-cf78(i1,i2).e(1)*p634(1)-cf7
     & 8(i1,i2).e(2)*p634(2)-cf78(i1,i2).e(3)*p634(3)
      cauxa=-cf78(i1,i2).ek0*quqd+p512k0*cvqd+p634k0*cvqu
      cauxb=-cf78(i1,i2).ek0*p634(2)+p634k0*cf78(i1,i2).e(2)
      cauxc=+cf78(i1,i2).ek0*p512(2)-p512k0*cf78(i1,i2).e(2)
      u512_78(i1,i2).a(1,1)=u512_78(i1,i2).a(1,1)+fcr(id5)*(caux
     & a+ceps_0)
      u512_78(i1,i2).a(2,2)=u512_78(i1,i2).a(2,2)+fcl(id5)*(caux
     & a-ceps_0)
      u512_78(i1,i2).b(1,2)=u512_78(i1,i2).b(1,2)+fcl(id5)*(caux
     & b-ceps_2)
      u512_78(i1,i2).b(2,1)=u512_78(i1,i2).b(2,1)+fcr(id5)*(-cau
     & xb-ceps_2)
      u512_78(i1,i2).c(1,2)=u512_78(i1,i2).c(1,2)+fcr(id5)*(caux
     & c+ceps_1)
      u512_78(i1,i2).c(2,1)=u512_78(i1,i2).c(2,1)+fcl(id5)*(-cau
     & xc+ceps_1)
      u512_78(i1,i2).d(1,1)=u512_78(i1,i2).d(1,1)+fcl(id5)*cf78(
     & i1,i2).ek0
      u512_78(i1,i2).d(2,2)=u512_78(i1,i2).d(2,2)+fcr(id5)*cf78(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id5.eq.5.and.id7.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p512,qd=p634,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p512k0*p634(2)+p634k0*p512(2)
      cauxa=auxa-cim*(p634(3)*p512k0-p512(3)*p634k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p634k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p512k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s78-cmh2)+rhhbb**2/(s78-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u512_78(i1,i2).a(i3,i4)=ch78(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u512_78(i1,i2).b(i3,i4)=ch78(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u512_78(i1,i2).c(i3,i4)=ch78(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u512_78(i1,i2).a(i3,i4)=czero
                else
                  u512_78(i1,i2).b(i3,i4)=czero
                  u512_78(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p534,q=p678
      quqd=p534(0)*p678(0)-p534(1)*p678(1)-p534(2)*p678(2)-p534(
     & 3)*p678(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p534,qd=p678,v=cz12(i1,i2).e,a=u534_12(i1,i2).a,b=u534_12(i1,i
* 2).b,c=u534_12(i1,i2).c,d=u534_12(i1,i2).d,cr=zcr(id5),cl=zcl(id5),nsu
* m=0
      ceps_0=-cz12(i1,i2).ek0*(p534(2)*p678(3)-p678(2)*p534(3))+
     & p534k0*(cz12(i1,i2).e(2)*p678(3)-p678(2)*cz12(i1,i2).e(3)
     & )-p678k0*(cz12(i1,i2).e(2)*p534(3)-p534(2)*cz12(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz12(i1,i2).e(3)*p534k0+p534(3)*cz12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz12(i1,i2).e(3)*p678k0+p678(3)*cz12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz12(i1,i2).e(0)*p534(0)-cz12(i1,i2).e(1)*p534(1)-cz1
     & 2(i1,i2).e(2)*p534(2)-cz12(i1,i2).e(3)*p534(3)
      cvqd=cz12(i1,i2).e(0)*p678(0)-cz12(i1,i2).e(1)*p678(1)-cz1
     & 2(i1,i2).e(2)*p678(2)-cz12(i1,i2).e(3)*p678(3)
      cauxa=-cz12(i1,i2).ek0*quqd+p534k0*cvqd+p678k0*cvqu
      cauxb=-cz12(i1,i2).ek0*p678(2)+p678k0*cz12(i1,i2).e(2)
      cauxc=+cz12(i1,i2).ek0*p534(2)-p534k0*cz12(i1,i2).e(2)
      u534_12(i1,i2).a(1,1)=zcr(id5)*(cauxa+ceps_0)
      u534_12(i1,i2).a(2,2)=zcl(id5)*(cauxa-ceps_0)
      u534_12(i1,i2).b(1,2)=zcl(id5)*(cauxb-ceps_2)
      u534_12(i1,i2).b(2,1)=zcr(id5)*(-cauxb-ceps_2)
      u534_12(i1,i2).c(1,2)=zcr(id5)*(cauxc+ceps_1)
      u534_12(i1,i2).c(2,1)=zcl(id5)*(-cauxc+ceps_1)
      u534_12(i1,i2).d(1,1)=zcl(id5)*cz12(i1,i2).ek0
      u534_12(i1,i2).d(2,2)=zcr(id5)*cz12(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p534,qd=p678,v=cf12(i1,i2).e,a=u534_12(i1,i2).a,b=u534_12(i1,i
* 2).b,c=u534_12(i1,i2).c,d=u534_12(i1,i2).d,cr=fcr(id5),cl=fcl(id5),nsu
* m=1
      ceps_0=-cf12(i1,i2).ek0*(p534(2)*p678(3)-p678(2)*p534(3))+
     & p534k0*(cf12(i1,i2).e(2)*p678(3)-p678(2)*cf12(i1,i2).e(3)
     & )-p678k0*(cf12(i1,i2).e(2)*p534(3)-p534(2)*cf12(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf12(i1,i2).e(3)*p534k0+p534(3)*cf12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf12(i1,i2).e(3)*p678k0+p678(3)*cf12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf12(i1,i2).e(0)*p534(0)-cf12(i1,i2).e(1)*p534(1)-cf1
     & 2(i1,i2).e(2)*p534(2)-cf12(i1,i2).e(3)*p534(3)
      cvqd=cf12(i1,i2).e(0)*p678(0)-cf12(i1,i2).e(1)*p678(1)-cf1
     & 2(i1,i2).e(2)*p678(2)-cf12(i1,i2).e(3)*p678(3)
      cauxa=-cf12(i1,i2).ek0*quqd+p534k0*cvqd+p678k0*cvqu
      cauxb=-cf12(i1,i2).ek0*p678(2)+p678k0*cf12(i1,i2).e(2)
      cauxc=+cf12(i1,i2).ek0*p534(2)-p534k0*cf12(i1,i2).e(2)
      u534_12(i1,i2).a(1,1)=u534_12(i1,i2).a(1,1)+fcr(id5)*(caux
     & a+ceps_0)
      u534_12(i1,i2).a(2,2)=u534_12(i1,i2).a(2,2)+fcl(id5)*(caux
     & a-ceps_0)
      u534_12(i1,i2).b(1,2)=u534_12(i1,i2).b(1,2)+fcl(id5)*(caux
     & b-ceps_2)
      u534_12(i1,i2).b(2,1)=u534_12(i1,i2).b(2,1)+fcr(id5)*(-cau
     & xb-ceps_2)
      u534_12(i1,i2).c(1,2)=u534_12(i1,i2).c(1,2)+fcr(id5)*(caux
     & c+ceps_1)
      u534_12(i1,i2).c(2,1)=u534_12(i1,i2).c(2,1)+fcl(id5)*(-cau
     & xc+ceps_1)
      u534_12(i1,i2).d(1,1)=u534_12(i1,i2).d(1,1)+fcl(id5)*cf12(
     & i1,i2).ek0
      u534_12(i1,i2).d(2,2)=u534_12(i1,i2).d(2,2)+fcr(id5)*cf12(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id5.eq.5.and.id1.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p534,qd=p678,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p534k0*p678(2)+p678k0*p534(2)
      cauxa=auxa-cim*(p678(3)*p534k0-p534(3)*p678k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p678k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p534k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s12-cmh2)+rhhbb**2/(s12-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u534_12(i1,i2).a(i3,i4)=ch12(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u534_12(i1,i2).b(i3,i4)=ch12(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u534_12(i1,i2).c(i3,i4)=ch12(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u534_12(i1,i2).a(i3,i4)=czero
                else
                  u534_12(i1,i2).b(i3,i4)=czero
                  u534_12(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p534,q=p612
      quqd=p534(0)*p612(0)-p534(1)*p612(1)-p534(2)*p612(2)-p534(
     & 3)*p612(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p534,qd=p612,v=cz78(i1,i2).e,a=u534_78(i1,i2).a,b=u534_78(i1,i
* 2).b,c=u534_78(i1,i2).c,d=u534_78(i1,i2).d,cr=zcr(id5),cl=zcl(id5),nsu
* m=0
      ceps_0=-cz78(i1,i2).ek0*(p534(2)*p612(3)-p612(2)*p534(3))+
     & p534k0*(cz78(i1,i2).e(2)*p612(3)-p612(2)*cz78(i1,i2).e(3)
     & )-p612k0*(cz78(i1,i2).e(2)*p534(3)-p534(2)*cz78(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz78(i1,i2).e(3)*p534k0+p534(3)*cz78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz78(i1,i2).e(3)*p612k0+p612(3)*cz78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz78(i1,i2).e(0)*p534(0)-cz78(i1,i2).e(1)*p534(1)-cz7
     & 8(i1,i2).e(2)*p534(2)-cz78(i1,i2).e(3)*p534(3)
      cvqd=cz78(i1,i2).e(0)*p612(0)-cz78(i1,i2).e(1)*p612(1)-cz7
     & 8(i1,i2).e(2)*p612(2)-cz78(i1,i2).e(3)*p612(3)
      cauxa=-cz78(i1,i2).ek0*quqd+p534k0*cvqd+p612k0*cvqu
      cauxb=-cz78(i1,i2).ek0*p612(2)+p612k0*cz78(i1,i2).e(2)
      cauxc=+cz78(i1,i2).ek0*p534(2)-p534k0*cz78(i1,i2).e(2)
      u534_78(i1,i2).a(1,1)=zcr(id5)*(cauxa+ceps_0)
      u534_78(i1,i2).a(2,2)=zcl(id5)*(cauxa-ceps_0)
      u534_78(i1,i2).b(1,2)=zcl(id5)*(cauxb-ceps_2)
      u534_78(i1,i2).b(2,1)=zcr(id5)*(-cauxb-ceps_2)
      u534_78(i1,i2).c(1,2)=zcr(id5)*(cauxc+ceps_1)
      u534_78(i1,i2).c(2,1)=zcl(id5)*(-cauxc+ceps_1)
      u534_78(i1,i2).d(1,1)=zcl(id5)*cz78(i1,i2).ek0
      u534_78(i1,i2).d(2,2)=zcr(id5)*cz78(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p534,qd=p612,v=cf78(i1,i2).e,a=u534_78(i1,i2).a,b=u534_78(i1,i
* 2).b,c=u534_78(i1,i2).c,d=u534_78(i1,i2).d,cr=fcr(id5),cl=fcl(id5),nsu
* m=1
      ceps_0=-cf78(i1,i2).ek0*(p534(2)*p612(3)-p612(2)*p534(3))+
     & p534k0*(cf78(i1,i2).e(2)*p612(3)-p612(2)*cf78(i1,i2).e(3)
     & )-p612k0*(cf78(i1,i2).e(2)*p534(3)-p534(2)*cf78(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf78(i1,i2).e(3)*p534k0+p534(3)*cf78(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf78(i1,i2).e(3)*p612k0+p612(3)*cf78(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf78(i1,i2).e(0)*p534(0)-cf78(i1,i2).e(1)*p534(1)-cf7
     & 8(i1,i2).e(2)*p534(2)-cf78(i1,i2).e(3)*p534(3)
      cvqd=cf78(i1,i2).e(0)*p612(0)-cf78(i1,i2).e(1)*p612(1)-cf7
     & 8(i1,i2).e(2)*p612(2)-cf78(i1,i2).e(3)*p612(3)
      cauxa=-cf78(i1,i2).ek0*quqd+p534k0*cvqd+p612k0*cvqu
      cauxb=-cf78(i1,i2).ek0*p612(2)+p612k0*cf78(i1,i2).e(2)
      cauxc=+cf78(i1,i2).ek0*p534(2)-p534k0*cf78(i1,i2).e(2)
      u534_78(i1,i2).a(1,1)=u534_78(i1,i2).a(1,1)+fcr(id5)*(caux
     & a+ceps_0)
      u534_78(i1,i2).a(2,2)=u534_78(i1,i2).a(2,2)+fcl(id5)*(caux
     & a-ceps_0)
      u534_78(i1,i2).b(1,2)=u534_78(i1,i2).b(1,2)+fcl(id5)*(caux
     & b-ceps_2)
      u534_78(i1,i2).b(2,1)=u534_78(i1,i2).b(2,1)+fcr(id5)*(-cau
     & xb-ceps_2)
      u534_78(i1,i2).c(1,2)=u534_78(i1,i2).c(1,2)+fcr(id5)*(caux
     & c+ceps_1)
      u534_78(i1,i2).c(2,1)=u534_78(i1,i2).c(2,1)+fcl(id5)*(-cau
     & xc+ceps_1)
      u534_78(i1,i2).d(1,1)=u534_78(i1,i2).d(1,1)+fcl(id5)*cf78(
     & i1,i2).ek0
      u534_78(i1,i2).d(2,2)=u534_78(i1,i2).d(2,2)+fcr(id5)*cf78(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id5.eq.5.and.id7.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p534,qd=p612,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p534k0*p612(2)+p612k0*p534(2)
      cauxa=auxa-cim*(p612(3)*p534k0-p534(3)*p612k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p612k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p534k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s78-cmh2)+rhhbb**2/(s78-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u534_78(i1,i2).a(i3,i4)=ch78(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u534_78(i1,i2).b(i3,i4)=ch78(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u534_78(i1,i2).c(i3,i4)=ch78(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u534_78(i1,i2).a(i3,i4)=czero
                else
                  u534_78(i1,i2).b(i3,i4)=czero
                  u534_78(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p578,q=p634
      quqd=p578(0)*p634(0)-p578(1)*p634(1)-p578(2)*p634(2)-p578(
     & 3)*p634(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p578,qd=p634,v=cz12(i1,i2).e,a=u578_12(i1,i2).a,b=u578_12(i1,i
* 2).b,c=u578_12(i1,i2).c,d=u578_12(i1,i2).d,cr=zcr(id5),cl=zcl(id5),nsu
* m=0
      ceps_0=-cz12(i1,i2).ek0*(p578(2)*p634(3)-p634(2)*p578(3))+
     & p578k0*(cz12(i1,i2).e(2)*p634(3)-p634(2)*cz12(i1,i2).e(3)
     & )-p634k0*(cz12(i1,i2).e(2)*p578(3)-p578(2)*cz12(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz12(i1,i2).e(3)*p578k0+p578(3)*cz12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz12(i1,i2).e(3)*p634k0+p634(3)*cz12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz12(i1,i2).e(0)*p578(0)-cz12(i1,i2).e(1)*p578(1)-cz1
     & 2(i1,i2).e(2)*p578(2)-cz12(i1,i2).e(3)*p578(3)
      cvqd=cz12(i1,i2).e(0)*p634(0)-cz12(i1,i2).e(1)*p634(1)-cz1
     & 2(i1,i2).e(2)*p634(2)-cz12(i1,i2).e(3)*p634(3)
      cauxa=-cz12(i1,i2).ek0*quqd+p578k0*cvqd+p634k0*cvqu
      cauxb=-cz12(i1,i2).ek0*p634(2)+p634k0*cz12(i1,i2).e(2)
      cauxc=+cz12(i1,i2).ek0*p578(2)-p578k0*cz12(i1,i2).e(2)
      u578_12(i1,i2).a(1,1)=zcr(id5)*(cauxa+ceps_0)
      u578_12(i1,i2).a(2,2)=zcl(id5)*(cauxa-ceps_0)
      u578_12(i1,i2).b(1,2)=zcl(id5)*(cauxb-ceps_2)
      u578_12(i1,i2).b(2,1)=zcr(id5)*(-cauxb-ceps_2)
      u578_12(i1,i2).c(1,2)=zcr(id5)*(cauxc+ceps_1)
      u578_12(i1,i2).c(2,1)=zcl(id5)*(-cauxc+ceps_1)
      u578_12(i1,i2).d(1,1)=zcl(id5)*cz12(i1,i2).ek0
      u578_12(i1,i2).d(2,2)=zcr(id5)*cz12(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p578,qd=p634,v=cf12(i1,i2).e,a=u578_12(i1,i2).a,b=u578_12(i1,i
* 2).b,c=u578_12(i1,i2).c,d=u578_12(i1,i2).d,cr=fcr(id5),cl=fcl(id5),nsu
* m=1
      ceps_0=-cf12(i1,i2).ek0*(p578(2)*p634(3)-p634(2)*p578(3))+
     & p578k0*(cf12(i1,i2).e(2)*p634(3)-p634(2)*cf12(i1,i2).e(3)
     & )-p634k0*(cf12(i1,i2).e(2)*p578(3)-p578(2)*cf12(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf12(i1,i2).e(3)*p578k0+p578(3)*cf12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf12(i1,i2).e(3)*p634k0+p634(3)*cf12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf12(i1,i2).e(0)*p578(0)-cf12(i1,i2).e(1)*p578(1)-cf1
     & 2(i1,i2).e(2)*p578(2)-cf12(i1,i2).e(3)*p578(3)
      cvqd=cf12(i1,i2).e(0)*p634(0)-cf12(i1,i2).e(1)*p634(1)-cf1
     & 2(i1,i2).e(2)*p634(2)-cf12(i1,i2).e(3)*p634(3)
      cauxa=-cf12(i1,i2).ek0*quqd+p578k0*cvqd+p634k0*cvqu
      cauxb=-cf12(i1,i2).ek0*p634(2)+p634k0*cf12(i1,i2).e(2)
      cauxc=+cf12(i1,i2).ek0*p578(2)-p578k0*cf12(i1,i2).e(2)
      u578_12(i1,i2).a(1,1)=u578_12(i1,i2).a(1,1)+fcr(id5)*(caux
     & a+ceps_0)
      u578_12(i1,i2).a(2,2)=u578_12(i1,i2).a(2,2)+fcl(id5)*(caux
     & a-ceps_0)
      u578_12(i1,i2).b(1,2)=u578_12(i1,i2).b(1,2)+fcl(id5)*(caux
     & b-ceps_2)
      u578_12(i1,i2).b(2,1)=u578_12(i1,i2).b(2,1)+fcr(id5)*(-cau
     & xb-ceps_2)
      u578_12(i1,i2).c(1,2)=u578_12(i1,i2).c(1,2)+fcr(id5)*(caux
     & c+ceps_1)
      u578_12(i1,i2).c(2,1)=u578_12(i1,i2).c(2,1)+fcl(id5)*(-cau
     & xc+ceps_1)
      u578_12(i1,i2).d(1,1)=u578_12(i1,i2).d(1,1)+fcl(id5)*cf12(
     & i1,i2).ek0
      u578_12(i1,i2).d(2,2)=u578_12(i1,i2).d(2,2)+fcr(id5)*cf12(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id5.eq.5.and.id1.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p578,qd=p634,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p578k0*p634(2)+p634k0*p578(2)
      cauxa=auxa-cim*(p634(3)*p578k0-p578(3)*p634k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p634k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p578k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s12-cmh2)+rhhbb**2/(s12-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u578_12(i1,i2).a(i3,i4)=ch12(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u578_12(i1,i2).b(i3,i4)=ch12(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u578_12(i1,i2).c(i3,i4)=ch12(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u578_12(i1,i2).a(i3,i4)=czero
                else
                  u578_12(i1,i2).b(i3,i4)=czero
                  u578_12(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p578,q=p612
      quqd=p578(0)*p612(0)-p578(1)*p612(1)-p578(2)*p612(2)-p578(
     & 3)*p612(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p578,qd=p612,v=cz34(i1,i2).e,a=u578_34(i1,i2).a,b=u578_34(i1,i
* 2).b,c=u578_34(i1,i2).c,d=u578_34(i1,i2).d,cr=zcr(id5),cl=zcl(id5),nsu
* m=0
      ceps_0=-cz34(i1,i2).ek0*(p578(2)*p612(3)-p612(2)*p578(3))+
     & p578k0*(cz34(i1,i2).e(2)*p612(3)-p612(2)*cz34(i1,i2).e(3)
     & )-p612k0*(cz34(i1,i2).e(2)*p578(3)-p578(2)*cz34(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz34(i1,i2).e(3)*p578k0+p578(3)*cz34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz34(i1,i2).e(3)*p612k0+p612(3)*cz34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz34(i1,i2).e(0)*p578(0)-cz34(i1,i2).e(1)*p578(1)-cz3
     & 4(i1,i2).e(2)*p578(2)-cz34(i1,i2).e(3)*p578(3)
      cvqd=cz34(i1,i2).e(0)*p612(0)-cz34(i1,i2).e(1)*p612(1)-cz3
     & 4(i1,i2).e(2)*p612(2)-cz34(i1,i2).e(3)*p612(3)
      cauxa=-cz34(i1,i2).ek0*quqd+p578k0*cvqd+p612k0*cvqu
      cauxb=-cz34(i1,i2).ek0*p612(2)+p612k0*cz34(i1,i2).e(2)
      cauxc=+cz34(i1,i2).ek0*p578(2)-p578k0*cz34(i1,i2).e(2)
      u578_34(i1,i2).a(1,1)=zcr(id5)*(cauxa+ceps_0)
      u578_34(i1,i2).a(2,2)=zcl(id5)*(cauxa-ceps_0)
      u578_34(i1,i2).b(1,2)=zcl(id5)*(cauxb-ceps_2)
      u578_34(i1,i2).b(2,1)=zcr(id5)*(-cauxb-ceps_2)
      u578_34(i1,i2).c(1,2)=zcr(id5)*(cauxc+ceps_1)
      u578_34(i1,i2).c(2,1)=zcl(id5)*(-cauxc+ceps_1)
      u578_34(i1,i2).d(1,1)=zcl(id5)*cz34(i1,i2).ek0
      u578_34(i1,i2).d(2,2)=zcr(id5)*cz34(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p578,qd=p612,v=cf34(i1,i2).e,a=u578_34(i1,i2).a,b=u578_34(i1,i
* 2).b,c=u578_34(i1,i2).c,d=u578_34(i1,i2).d,cr=fcr(id5),cl=fcl(id5),nsu
* m=1
      ceps_0=-cf34(i1,i2).ek0*(p578(2)*p612(3)-p612(2)*p578(3))+
     & p578k0*(cf34(i1,i2).e(2)*p612(3)-p612(2)*cf34(i1,i2).e(3)
     & )-p612k0*(cf34(i1,i2).e(2)*p578(3)-p578(2)*cf34(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf34(i1,i2).e(3)*p578k0+p578(3)*cf34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf34(i1,i2).e(3)*p612k0+p612(3)*cf34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf34(i1,i2).e(0)*p578(0)-cf34(i1,i2).e(1)*p578(1)-cf3
     & 4(i1,i2).e(2)*p578(2)-cf34(i1,i2).e(3)*p578(3)
      cvqd=cf34(i1,i2).e(0)*p612(0)-cf34(i1,i2).e(1)*p612(1)-cf3
     & 4(i1,i2).e(2)*p612(2)-cf34(i1,i2).e(3)*p612(3)
      cauxa=-cf34(i1,i2).ek0*quqd+p578k0*cvqd+p612k0*cvqu
      cauxb=-cf34(i1,i2).ek0*p612(2)+p612k0*cf34(i1,i2).e(2)
      cauxc=+cf34(i1,i2).ek0*p578(2)-p578k0*cf34(i1,i2).e(2)
      u578_34(i1,i2).a(1,1)=u578_34(i1,i2).a(1,1)+fcr(id5)*(caux
     & a+ceps_0)
      u578_34(i1,i2).a(2,2)=u578_34(i1,i2).a(2,2)+fcl(id5)*(caux
     & a-ceps_0)
      u578_34(i1,i2).b(1,2)=u578_34(i1,i2).b(1,2)+fcl(id5)*(caux
     & b-ceps_2)
      u578_34(i1,i2).b(2,1)=u578_34(i1,i2).b(2,1)+fcr(id5)*(-cau
     & xb-ceps_2)
      u578_34(i1,i2).c(1,2)=u578_34(i1,i2).c(1,2)+fcr(id5)*(caux
     & c+ceps_1)
      u578_34(i1,i2).c(2,1)=u578_34(i1,i2).c(2,1)+fcl(id5)*(-cau
     & xc+ceps_1)
      u578_34(i1,i2).d(1,1)=u578_34(i1,i2).d(1,1)+fcl(id5)*cf34(
     & i1,i2).ek0
      u578_34(i1,i2).d(2,2)=u578_34(i1,i2).d(2,2)+fcr(id5)*cf34(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id5.eq.5.and.id3.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p578,qd=p612,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p578k0*p612(2)+p612k0*p578(2)
      cauxa=auxa-cim*(p612(3)*p578k0-p578(3)*p612k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p612k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p578k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s34-cmh2)+rhhbb**2/(s34-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u578_34(i1,i2).a(i3,i4)=ch34(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u578_34(i1,i2).b(i3,i4)=ch34(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u578_34(i1,i2).c(i3,i4)=ch34(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u578_34(i1,i2).a(i3,i4)=czero
                else
                  u578_34(i1,i2).b(i3,i4)=czero
                  u578_34(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p712,q=p856
      quqd=p712(0)*p856(0)-p712(1)*p856(1)-p712(2)*p856(2)-p712(
     & 3)*p856(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p712,qd=p856,v=cz34(i1,i2).e,a=u712_34(i1,i2).a,b=u712_34(i1,i
* 2).b,c=u712_34(i1,i2).c,d=u712_34(i1,i2).d,cr=zcr(id7),cl=zcl(id7),nsu
* m=0
      ceps_0=-cz34(i1,i2).ek0*(p712(2)*p856(3)-p856(2)*p712(3))+
     & p712k0*(cz34(i1,i2).e(2)*p856(3)-p856(2)*cz34(i1,i2).e(3)
     & )-p856k0*(cz34(i1,i2).e(2)*p712(3)-p712(2)*cz34(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz34(i1,i2).e(3)*p712k0+p712(3)*cz34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz34(i1,i2).e(3)*p856k0+p856(3)*cz34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz34(i1,i2).e(0)*p712(0)-cz34(i1,i2).e(1)*p712(1)-cz3
     & 4(i1,i2).e(2)*p712(2)-cz34(i1,i2).e(3)*p712(3)
      cvqd=cz34(i1,i2).e(0)*p856(0)-cz34(i1,i2).e(1)*p856(1)-cz3
     & 4(i1,i2).e(2)*p856(2)-cz34(i1,i2).e(3)*p856(3)
      cauxa=-cz34(i1,i2).ek0*quqd+p712k0*cvqd+p856k0*cvqu
      cauxb=-cz34(i1,i2).ek0*p856(2)+p856k0*cz34(i1,i2).e(2)
      cauxc=+cz34(i1,i2).ek0*p712(2)-p712k0*cz34(i1,i2).e(2)
      u712_34(i1,i2).a(1,1)=zcr(id7)*(cauxa+ceps_0)
      u712_34(i1,i2).a(2,2)=zcl(id7)*(cauxa-ceps_0)
      u712_34(i1,i2).b(1,2)=zcl(id7)*(cauxb-ceps_2)
      u712_34(i1,i2).b(2,1)=zcr(id7)*(-cauxb-ceps_2)
      u712_34(i1,i2).c(1,2)=zcr(id7)*(cauxc+ceps_1)
      u712_34(i1,i2).c(2,1)=zcl(id7)*(-cauxc+ceps_1)
      u712_34(i1,i2).d(1,1)=zcl(id7)*cz34(i1,i2).ek0
      u712_34(i1,i2).d(2,2)=zcr(id7)*cz34(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p712,qd=p856,v=cf34(i1,i2).e,a=u712_34(i1,i2).a,b=u712_34(i1,i
* 2).b,c=u712_34(i1,i2).c,d=u712_34(i1,i2).d,cr=fcr(id7),cl=fcl(id7),nsu
* m=1
      ceps_0=-cf34(i1,i2).ek0*(p712(2)*p856(3)-p856(2)*p712(3))+
     & p712k0*(cf34(i1,i2).e(2)*p856(3)-p856(2)*cf34(i1,i2).e(3)
     & )-p856k0*(cf34(i1,i2).e(2)*p712(3)-p712(2)*cf34(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf34(i1,i2).e(3)*p712k0+p712(3)*cf34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf34(i1,i2).e(3)*p856k0+p856(3)*cf34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf34(i1,i2).e(0)*p712(0)-cf34(i1,i2).e(1)*p712(1)-cf3
     & 4(i1,i2).e(2)*p712(2)-cf34(i1,i2).e(3)*p712(3)
      cvqd=cf34(i1,i2).e(0)*p856(0)-cf34(i1,i2).e(1)*p856(1)-cf3
     & 4(i1,i2).e(2)*p856(2)-cf34(i1,i2).e(3)*p856(3)
      cauxa=-cf34(i1,i2).ek0*quqd+p712k0*cvqd+p856k0*cvqu
      cauxb=-cf34(i1,i2).ek0*p856(2)+p856k0*cf34(i1,i2).e(2)
      cauxc=+cf34(i1,i2).ek0*p712(2)-p712k0*cf34(i1,i2).e(2)
      u712_34(i1,i2).a(1,1)=u712_34(i1,i2).a(1,1)+fcr(id7)*(caux
     & a+ceps_0)
      u712_34(i1,i2).a(2,2)=u712_34(i1,i2).a(2,2)+fcl(id7)*(caux
     & a-ceps_0)
      u712_34(i1,i2).b(1,2)=u712_34(i1,i2).b(1,2)+fcl(id7)*(caux
     & b-ceps_2)
      u712_34(i1,i2).b(2,1)=u712_34(i1,i2).b(2,1)+fcr(id7)*(-cau
     & xb-ceps_2)
      u712_34(i1,i2).c(1,2)=u712_34(i1,i2).c(1,2)+fcr(id7)*(caux
     & c+ceps_1)
      u712_34(i1,i2).c(2,1)=u712_34(i1,i2).c(2,1)+fcl(id7)*(-cau
     & xc+ceps_1)
      u712_34(i1,i2).d(1,1)=u712_34(i1,i2).d(1,1)+fcl(id7)*cf34(
     & i1,i2).ek0
      u712_34(i1,i2).d(2,2)=u712_34(i1,i2).d(2,2)+fcr(id7)*cf34(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id7.eq.5.and.id3.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p712,qd=p856,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p712k0*p856(2)+p856k0*p712(2)
      cauxa=auxa-cim*(p856(3)*p712k0-p712(3)*p856k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p856k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p712k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s34-cmh2)+rhhbb**2/(s34-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u712_34(i1,i2).a(i3,i4)=ch34(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u712_34(i1,i2).b(i3,i4)=ch34(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u712_34(i1,i2).c(i3,i4)=ch34(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u712_34(i1,i2).a(i3,i4)=czero
                else
                  u712_34(i1,i2).b(i3,i4)=czero
                  u712_34(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p712,q=p834
      quqd=p712(0)*p834(0)-p712(1)*p834(1)-p712(2)*p834(2)-p712(
     & 3)*p834(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p712,qd=p834,v=cz56(i1,i2).e,a=u712_56(i1,i2).a,b=u712_56(i1,i
* 2).b,c=u712_56(i1,i2).c,d=u712_56(i1,i2).d,cr=zcr(id7),cl=zcl(id7),nsu
* m=0
      ceps_0=-cz56(i1,i2).ek0*(p712(2)*p834(3)-p834(2)*p712(3))+
     & p712k0*(cz56(i1,i2).e(2)*p834(3)-p834(2)*cz56(i1,i2).e(3)
     & )-p834k0*(cz56(i1,i2).e(2)*p712(3)-p712(2)*cz56(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz56(i1,i2).e(3)*p712k0+p712(3)*cz56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz56(i1,i2).e(3)*p834k0+p834(3)*cz56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz56(i1,i2).e(0)*p712(0)-cz56(i1,i2).e(1)*p712(1)-cz5
     & 6(i1,i2).e(2)*p712(2)-cz56(i1,i2).e(3)*p712(3)
      cvqd=cz56(i1,i2).e(0)*p834(0)-cz56(i1,i2).e(1)*p834(1)-cz5
     & 6(i1,i2).e(2)*p834(2)-cz56(i1,i2).e(3)*p834(3)
      cauxa=-cz56(i1,i2).ek0*quqd+p712k0*cvqd+p834k0*cvqu
      cauxb=-cz56(i1,i2).ek0*p834(2)+p834k0*cz56(i1,i2).e(2)
      cauxc=+cz56(i1,i2).ek0*p712(2)-p712k0*cz56(i1,i2).e(2)
      u712_56(i1,i2).a(1,1)=zcr(id7)*(cauxa+ceps_0)
      u712_56(i1,i2).a(2,2)=zcl(id7)*(cauxa-ceps_0)
      u712_56(i1,i2).b(1,2)=zcl(id7)*(cauxb-ceps_2)
      u712_56(i1,i2).b(2,1)=zcr(id7)*(-cauxb-ceps_2)
      u712_56(i1,i2).c(1,2)=zcr(id7)*(cauxc+ceps_1)
      u712_56(i1,i2).c(2,1)=zcl(id7)*(-cauxc+ceps_1)
      u712_56(i1,i2).d(1,1)=zcl(id7)*cz56(i1,i2).ek0
      u712_56(i1,i2).d(2,2)=zcr(id7)*cz56(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p712,qd=p834,v=cf56(i1,i2).e,a=u712_56(i1,i2).a,b=u712_56(i1,i
* 2).b,c=u712_56(i1,i2).c,d=u712_56(i1,i2).d,cr=fcr(id7),cl=fcl(id7),nsu
* m=1
      ceps_0=-cf56(i1,i2).ek0*(p712(2)*p834(3)-p834(2)*p712(3))+
     & p712k0*(cf56(i1,i2).e(2)*p834(3)-p834(2)*cf56(i1,i2).e(3)
     & )-p834k0*(cf56(i1,i2).e(2)*p712(3)-p712(2)*cf56(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf56(i1,i2).e(3)*p712k0+p712(3)*cf56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf56(i1,i2).e(3)*p834k0+p834(3)*cf56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf56(i1,i2).e(0)*p712(0)-cf56(i1,i2).e(1)*p712(1)-cf5
     & 6(i1,i2).e(2)*p712(2)-cf56(i1,i2).e(3)*p712(3)
      cvqd=cf56(i1,i2).e(0)*p834(0)-cf56(i1,i2).e(1)*p834(1)-cf5
     & 6(i1,i2).e(2)*p834(2)-cf56(i1,i2).e(3)*p834(3)
      cauxa=-cf56(i1,i2).ek0*quqd+p712k0*cvqd+p834k0*cvqu
      cauxb=-cf56(i1,i2).ek0*p834(2)+p834k0*cf56(i1,i2).e(2)
      cauxc=+cf56(i1,i2).ek0*p712(2)-p712k0*cf56(i1,i2).e(2)
      u712_56(i1,i2).a(1,1)=u712_56(i1,i2).a(1,1)+fcr(id7)*(caux
     & a+ceps_0)
      u712_56(i1,i2).a(2,2)=u712_56(i1,i2).a(2,2)+fcl(id7)*(caux
     & a-ceps_0)
      u712_56(i1,i2).b(1,2)=u712_56(i1,i2).b(1,2)+fcl(id7)*(caux
     & b-ceps_2)
      u712_56(i1,i2).b(2,1)=u712_56(i1,i2).b(2,1)+fcr(id7)*(-cau
     & xb-ceps_2)
      u712_56(i1,i2).c(1,2)=u712_56(i1,i2).c(1,2)+fcr(id7)*(caux
     & c+ceps_1)
      u712_56(i1,i2).c(2,1)=u712_56(i1,i2).c(2,1)+fcl(id7)*(-cau
     & xc+ceps_1)
      u712_56(i1,i2).d(1,1)=u712_56(i1,i2).d(1,1)+fcl(id7)*cf56(
     & i1,i2).ek0
      u712_56(i1,i2).d(2,2)=u712_56(i1,i2).d(2,2)+fcr(id7)*cf56(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id7.eq.5.and.id5.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p712,qd=p834,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p712k0*p834(2)+p834k0*p712(2)
      cauxa=auxa-cim*(p834(3)*p712k0-p712(3)*p834k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p834k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p712k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s56-cmh2)+rhhbb**2/(s56-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u712_56(i1,i2).a(i3,i4)=ch56(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u712_56(i1,i2).b(i3,i4)=ch56(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u712_56(i1,i2).c(i3,i4)=ch56(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u712_56(i1,i2).a(i3,i4)=czero
                else
                  u712_56(i1,i2).b(i3,i4)=czero
                  u712_56(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p734,q=p856
      quqd=p734(0)*p856(0)-p734(1)*p856(1)-p734(2)*p856(2)-p734(
     & 3)*p856(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p734,qd=p856,v=cz12(i1,i2).e,a=u734_12(i1,i2).a,b=u734_12(i1,i
* 2).b,c=u734_12(i1,i2).c,d=u734_12(i1,i2).d,cr=zcr(id7),cl=zcl(id7),nsu
* m=0
      ceps_0=-cz12(i1,i2).ek0*(p734(2)*p856(3)-p856(2)*p734(3))+
     & p734k0*(cz12(i1,i2).e(2)*p856(3)-p856(2)*cz12(i1,i2).e(3)
     & )-p856k0*(cz12(i1,i2).e(2)*p734(3)-p734(2)*cz12(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz12(i1,i2).e(3)*p734k0+p734(3)*cz12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz12(i1,i2).e(3)*p856k0+p856(3)*cz12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz12(i1,i2).e(0)*p734(0)-cz12(i1,i2).e(1)*p734(1)-cz1
     & 2(i1,i2).e(2)*p734(2)-cz12(i1,i2).e(3)*p734(3)
      cvqd=cz12(i1,i2).e(0)*p856(0)-cz12(i1,i2).e(1)*p856(1)-cz1
     & 2(i1,i2).e(2)*p856(2)-cz12(i1,i2).e(3)*p856(3)
      cauxa=-cz12(i1,i2).ek0*quqd+p734k0*cvqd+p856k0*cvqu
      cauxb=-cz12(i1,i2).ek0*p856(2)+p856k0*cz12(i1,i2).e(2)
      cauxc=+cz12(i1,i2).ek0*p734(2)-p734k0*cz12(i1,i2).e(2)
      u734_12(i1,i2).a(1,1)=zcr(id7)*(cauxa+ceps_0)
      u734_12(i1,i2).a(2,2)=zcl(id7)*(cauxa-ceps_0)
      u734_12(i1,i2).b(1,2)=zcl(id7)*(cauxb-ceps_2)
      u734_12(i1,i2).b(2,1)=zcr(id7)*(-cauxb-ceps_2)
      u734_12(i1,i2).c(1,2)=zcr(id7)*(cauxc+ceps_1)
      u734_12(i1,i2).c(2,1)=zcl(id7)*(-cauxc+ceps_1)
      u734_12(i1,i2).d(1,1)=zcl(id7)*cz12(i1,i2).ek0
      u734_12(i1,i2).d(2,2)=zcr(id7)*cz12(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p734,qd=p856,v=cf12(i1,i2).e,a=u734_12(i1,i2).a,b=u734_12(i1,i
* 2).b,c=u734_12(i1,i2).c,d=u734_12(i1,i2).d,cr=fcr(id7),cl=fcl(id7),nsu
* m=1
      ceps_0=-cf12(i1,i2).ek0*(p734(2)*p856(3)-p856(2)*p734(3))+
     & p734k0*(cf12(i1,i2).e(2)*p856(3)-p856(2)*cf12(i1,i2).e(3)
     & )-p856k0*(cf12(i1,i2).e(2)*p734(3)-p734(2)*cf12(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf12(i1,i2).e(3)*p734k0+p734(3)*cf12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf12(i1,i2).e(3)*p856k0+p856(3)*cf12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf12(i1,i2).e(0)*p734(0)-cf12(i1,i2).e(1)*p734(1)-cf1
     & 2(i1,i2).e(2)*p734(2)-cf12(i1,i2).e(3)*p734(3)
      cvqd=cf12(i1,i2).e(0)*p856(0)-cf12(i1,i2).e(1)*p856(1)-cf1
     & 2(i1,i2).e(2)*p856(2)-cf12(i1,i2).e(3)*p856(3)
      cauxa=-cf12(i1,i2).ek0*quqd+p734k0*cvqd+p856k0*cvqu
      cauxb=-cf12(i1,i2).ek0*p856(2)+p856k0*cf12(i1,i2).e(2)
      cauxc=+cf12(i1,i2).ek0*p734(2)-p734k0*cf12(i1,i2).e(2)
      u734_12(i1,i2).a(1,1)=u734_12(i1,i2).a(1,1)+fcr(id7)*(caux
     & a+ceps_0)
      u734_12(i1,i2).a(2,2)=u734_12(i1,i2).a(2,2)+fcl(id7)*(caux
     & a-ceps_0)
      u734_12(i1,i2).b(1,2)=u734_12(i1,i2).b(1,2)+fcl(id7)*(caux
     & b-ceps_2)
      u734_12(i1,i2).b(2,1)=u734_12(i1,i2).b(2,1)+fcr(id7)*(-cau
     & xb-ceps_2)
      u734_12(i1,i2).c(1,2)=u734_12(i1,i2).c(1,2)+fcr(id7)*(caux
     & c+ceps_1)
      u734_12(i1,i2).c(2,1)=u734_12(i1,i2).c(2,1)+fcl(id7)*(-cau
     & xc+ceps_1)
      u734_12(i1,i2).d(1,1)=u734_12(i1,i2).d(1,1)+fcl(id7)*cf12(
     & i1,i2).ek0
      u734_12(i1,i2).d(2,2)=u734_12(i1,i2).d(2,2)+fcr(id7)*cf12(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id7.eq.5.and.id1.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p734,qd=p856,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p734k0*p856(2)+p856k0*p734(2)
      cauxa=auxa-cim*(p856(3)*p734k0-p734(3)*p856k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p856k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p734k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s12-cmh2)+rhhbb**2/(s12-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u734_12(i1,i2).a(i3,i4)=ch12(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u734_12(i1,i2).b(i3,i4)=ch12(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u734_12(i1,i2).c(i3,i4)=ch12(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u734_12(i1,i2).a(i3,i4)=czero
                else
                  u734_12(i1,i2).b(i3,i4)=czero
                  u734_12(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p734,q=p812
      quqd=p734(0)*p812(0)-p734(1)*p812(1)-p734(2)*p812(2)-p734(
     & 3)*p812(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p734,qd=p812,v=cz56(i1,i2).e,a=u734_56(i1,i2).a,b=u734_56(i1,i
* 2).b,c=u734_56(i1,i2).c,d=u734_56(i1,i2).d,cr=zcr(id7),cl=zcl(id7),nsu
* m=0
      ceps_0=-cz56(i1,i2).ek0*(p734(2)*p812(3)-p812(2)*p734(3))+
     & p734k0*(cz56(i1,i2).e(2)*p812(3)-p812(2)*cz56(i1,i2).e(3)
     & )-p812k0*(cz56(i1,i2).e(2)*p734(3)-p734(2)*cz56(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz56(i1,i2).e(3)*p734k0+p734(3)*cz56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz56(i1,i2).e(3)*p812k0+p812(3)*cz56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz56(i1,i2).e(0)*p734(0)-cz56(i1,i2).e(1)*p734(1)-cz5
     & 6(i1,i2).e(2)*p734(2)-cz56(i1,i2).e(3)*p734(3)
      cvqd=cz56(i1,i2).e(0)*p812(0)-cz56(i1,i2).e(1)*p812(1)-cz5
     & 6(i1,i2).e(2)*p812(2)-cz56(i1,i2).e(3)*p812(3)
      cauxa=-cz56(i1,i2).ek0*quqd+p734k0*cvqd+p812k0*cvqu
      cauxb=-cz56(i1,i2).ek0*p812(2)+p812k0*cz56(i1,i2).e(2)
      cauxc=+cz56(i1,i2).ek0*p734(2)-p734k0*cz56(i1,i2).e(2)
      u734_56(i1,i2).a(1,1)=zcr(id7)*(cauxa+ceps_0)
      u734_56(i1,i2).a(2,2)=zcl(id7)*(cauxa-ceps_0)
      u734_56(i1,i2).b(1,2)=zcl(id7)*(cauxb-ceps_2)
      u734_56(i1,i2).b(2,1)=zcr(id7)*(-cauxb-ceps_2)
      u734_56(i1,i2).c(1,2)=zcr(id7)*(cauxc+ceps_1)
      u734_56(i1,i2).c(2,1)=zcl(id7)*(-cauxc+ceps_1)
      u734_56(i1,i2).d(1,1)=zcl(id7)*cz56(i1,i2).ek0
      u734_56(i1,i2).d(2,2)=zcr(id7)*cz56(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p734,qd=p812,v=cf56(i1,i2).e,a=u734_56(i1,i2).a,b=u734_56(i1,i
* 2).b,c=u734_56(i1,i2).c,d=u734_56(i1,i2).d,cr=fcr(id7),cl=fcl(id7),nsu
* m=1
      ceps_0=-cf56(i1,i2).ek0*(p734(2)*p812(3)-p812(2)*p734(3))+
     & p734k0*(cf56(i1,i2).e(2)*p812(3)-p812(2)*cf56(i1,i2).e(3)
     & )-p812k0*(cf56(i1,i2).e(2)*p734(3)-p734(2)*cf56(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf56(i1,i2).e(3)*p734k0+p734(3)*cf56(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf56(i1,i2).e(3)*p812k0+p812(3)*cf56(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf56(i1,i2).e(0)*p734(0)-cf56(i1,i2).e(1)*p734(1)-cf5
     & 6(i1,i2).e(2)*p734(2)-cf56(i1,i2).e(3)*p734(3)
      cvqd=cf56(i1,i2).e(0)*p812(0)-cf56(i1,i2).e(1)*p812(1)-cf5
     & 6(i1,i2).e(2)*p812(2)-cf56(i1,i2).e(3)*p812(3)
      cauxa=-cf56(i1,i2).ek0*quqd+p734k0*cvqd+p812k0*cvqu
      cauxb=-cf56(i1,i2).ek0*p812(2)+p812k0*cf56(i1,i2).e(2)
      cauxc=+cf56(i1,i2).ek0*p734(2)-p734k0*cf56(i1,i2).e(2)
      u734_56(i1,i2).a(1,1)=u734_56(i1,i2).a(1,1)+fcr(id7)*(caux
     & a+ceps_0)
      u734_56(i1,i2).a(2,2)=u734_56(i1,i2).a(2,2)+fcl(id7)*(caux
     & a-ceps_0)
      u734_56(i1,i2).b(1,2)=u734_56(i1,i2).b(1,2)+fcl(id7)*(caux
     & b-ceps_2)
      u734_56(i1,i2).b(2,1)=u734_56(i1,i2).b(2,1)+fcr(id7)*(-cau
     & xb-ceps_2)
      u734_56(i1,i2).c(1,2)=u734_56(i1,i2).c(1,2)+fcr(id7)*(caux
     & c+ceps_1)
      u734_56(i1,i2).c(2,1)=u734_56(i1,i2).c(2,1)+fcl(id7)*(-cau
     & xc+ceps_1)
      u734_56(i1,i2).d(1,1)=u734_56(i1,i2).d(1,1)+fcl(id7)*cf56(
     & i1,i2).ek0
      u734_56(i1,i2).d(2,2)=u734_56(i1,i2).d(2,2)+fcr(id7)*cf56(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id7.eq.5.and.id5.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p734,qd=p812,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p734k0*p812(2)+p812k0*p734(2)
      cauxa=auxa-cim*(p812(3)*p734k0-p734(3)*p812k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p812k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p734k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s56-cmh2)+rhhbb**2/(s56-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u734_56(i1,i2).a(i3,i4)=ch56(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u734_56(i1,i2).b(i3,i4)=ch56(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u734_56(i1,i2).c(i3,i4)=ch56(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u734_56(i1,i2).a(i3,i4)=czero
                else
                  u734_56(i1,i2).b(i3,i4)=czero
                  u734_56(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p756,q=p834
      quqd=p756(0)*p834(0)-p756(1)*p834(1)-p756(2)*p834(2)-p756(
     & 3)*p834(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p756,qd=p834,v=cz12(i1,i2).e,a=u756_12(i1,i2).a,b=u756_12(i1,i
* 2).b,c=u756_12(i1,i2).c,d=u756_12(i1,i2).d,cr=zcr(id7),cl=zcl(id7),nsu
* m=0
      ceps_0=-cz12(i1,i2).ek0*(p756(2)*p834(3)-p834(2)*p756(3))+
     & p756k0*(cz12(i1,i2).e(2)*p834(3)-p834(2)*cz12(i1,i2).e(3)
     & )-p834k0*(cz12(i1,i2).e(2)*p756(3)-p756(2)*cz12(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz12(i1,i2).e(3)*p756k0+p756(3)*cz12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz12(i1,i2).e(3)*p834k0+p834(3)*cz12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz12(i1,i2).e(0)*p756(0)-cz12(i1,i2).e(1)*p756(1)-cz1
     & 2(i1,i2).e(2)*p756(2)-cz12(i1,i2).e(3)*p756(3)
      cvqd=cz12(i1,i2).e(0)*p834(0)-cz12(i1,i2).e(1)*p834(1)-cz1
     & 2(i1,i2).e(2)*p834(2)-cz12(i1,i2).e(3)*p834(3)
      cauxa=-cz12(i1,i2).ek0*quqd+p756k0*cvqd+p834k0*cvqu
      cauxb=-cz12(i1,i2).ek0*p834(2)+p834k0*cz12(i1,i2).e(2)
      cauxc=+cz12(i1,i2).ek0*p756(2)-p756k0*cz12(i1,i2).e(2)
      u756_12(i1,i2).a(1,1)=zcr(id7)*(cauxa+ceps_0)
      u756_12(i1,i2).a(2,2)=zcl(id7)*(cauxa-ceps_0)
      u756_12(i1,i2).b(1,2)=zcl(id7)*(cauxb-ceps_2)
      u756_12(i1,i2).b(2,1)=zcr(id7)*(-cauxb-ceps_2)
      u756_12(i1,i2).c(1,2)=zcr(id7)*(cauxc+ceps_1)
      u756_12(i1,i2).c(2,1)=zcl(id7)*(-cauxc+ceps_1)
      u756_12(i1,i2).d(1,1)=zcl(id7)*cz12(i1,i2).ek0
      u756_12(i1,i2).d(2,2)=zcr(id7)*cz12(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p756,qd=p834,v=cf12(i1,i2).e,a=u756_12(i1,i2).a,b=u756_12(i1,i
* 2).b,c=u756_12(i1,i2).c,d=u756_12(i1,i2).d,cr=fcr(id7),cl=fcl(id7),nsu
* m=1
      ceps_0=-cf12(i1,i2).ek0*(p756(2)*p834(3)-p834(2)*p756(3))+
     & p756k0*(cf12(i1,i2).e(2)*p834(3)-p834(2)*cf12(i1,i2).e(3)
     & )-p834k0*(cf12(i1,i2).e(2)*p756(3)-p756(2)*cf12(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf12(i1,i2).e(3)*p756k0+p756(3)*cf12(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf12(i1,i2).e(3)*p834k0+p834(3)*cf12(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf12(i1,i2).e(0)*p756(0)-cf12(i1,i2).e(1)*p756(1)-cf1
     & 2(i1,i2).e(2)*p756(2)-cf12(i1,i2).e(3)*p756(3)
      cvqd=cf12(i1,i2).e(0)*p834(0)-cf12(i1,i2).e(1)*p834(1)-cf1
     & 2(i1,i2).e(2)*p834(2)-cf12(i1,i2).e(3)*p834(3)
      cauxa=-cf12(i1,i2).ek0*quqd+p756k0*cvqd+p834k0*cvqu
      cauxb=-cf12(i1,i2).ek0*p834(2)+p834k0*cf12(i1,i2).e(2)
      cauxc=+cf12(i1,i2).ek0*p756(2)-p756k0*cf12(i1,i2).e(2)
      u756_12(i1,i2).a(1,1)=u756_12(i1,i2).a(1,1)+fcr(id7)*(caux
     & a+ceps_0)
      u756_12(i1,i2).a(2,2)=u756_12(i1,i2).a(2,2)+fcl(id7)*(caux
     & a-ceps_0)
      u756_12(i1,i2).b(1,2)=u756_12(i1,i2).b(1,2)+fcl(id7)*(caux
     & b-ceps_2)
      u756_12(i1,i2).b(2,1)=u756_12(i1,i2).b(2,1)+fcr(id7)*(-cau
     & xb-ceps_2)
      u756_12(i1,i2).c(1,2)=u756_12(i1,i2).c(1,2)+fcr(id7)*(caux
     & c+ceps_1)
      u756_12(i1,i2).c(2,1)=u756_12(i1,i2).c(2,1)+fcl(id7)*(-cau
     & xc+ceps_1)
      u756_12(i1,i2).d(1,1)=u756_12(i1,i2).d(1,1)+fcl(id7)*cf12(
     & i1,i2).ek0
      u756_12(i1,i2).d(2,2)=u756_12(i1,i2).d(2,2)+fcr(id7)*cf12(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id7.eq.5.and.id1.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p756,qd=p834,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p756k0*p834(2)+p834k0*p756(2)
      cauxa=auxa-cim*(p834(3)*p756k0-p756(3)*p834k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p834k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p756k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s12-cmh2)+rhhbb**2/(s12-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u756_12(i1,i2).a(i3,i4)=ch12(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u756_12(i1,i2).b(i3,i4)=ch12(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u756_12(i1,i2).c(i3,i4)=ch12(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u756_12(i1,i2).a(i3,i4)=czero
                else
                  u756_12(i1,i2).b(i3,i4)=czero
                  u756_12(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
* quqd -- p=p756,q=p812
      quqd=p756(0)*p812(0)-p756(1)*p812(1)-p756(2)*p812(2)-p756(
     & 3)*p812(3)
      do i1=1,2
      do i2=1,2
* T -- qu=p756,qd=p812,v=cz34(i1,i2).e,a=u756_34(i1,i2).a,b=u756_34(i1,i
* 2).b,c=u756_34(i1,i2).c,d=u756_34(i1,i2).d,cr=zcr(id7),cl=zcl(id7),nsu
* m=0
      ceps_0=-cz34(i1,i2).ek0*(p756(2)*p812(3)-p812(2)*p756(3))+
     & p756k0*(cz34(i1,i2).e(2)*p812(3)-p812(2)*cz34(i1,i2).e(3)
     & )-p812k0*(cz34(i1,i2).e(2)*p756(3)-p756(2)*cz34(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cz34(i1,i2).e(3)*p756k0+p756(3)*cz34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cz34(i1,i2).e(3)*p812k0+p812(3)*cz34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cz34(i1,i2).e(0)*p756(0)-cz34(i1,i2).e(1)*p756(1)-cz3
     & 4(i1,i2).e(2)*p756(2)-cz34(i1,i2).e(3)*p756(3)
      cvqd=cz34(i1,i2).e(0)*p812(0)-cz34(i1,i2).e(1)*p812(1)-cz3
     & 4(i1,i2).e(2)*p812(2)-cz34(i1,i2).e(3)*p812(3)
      cauxa=-cz34(i1,i2).ek0*quqd+p756k0*cvqd+p812k0*cvqu
      cauxb=-cz34(i1,i2).ek0*p812(2)+p812k0*cz34(i1,i2).e(2)
      cauxc=+cz34(i1,i2).ek0*p756(2)-p756k0*cz34(i1,i2).e(2)
      u756_34(i1,i2).a(1,1)=zcr(id7)*(cauxa+ceps_0)
      u756_34(i1,i2).a(2,2)=zcl(id7)*(cauxa-ceps_0)
      u756_34(i1,i2).b(1,2)=zcl(id7)*(cauxb-ceps_2)
      u756_34(i1,i2).b(2,1)=zcr(id7)*(-cauxb-ceps_2)
      u756_34(i1,i2).c(1,2)=zcr(id7)*(cauxc+ceps_1)
      u756_34(i1,i2).c(2,1)=zcl(id7)*(-cauxc+ceps_1)
      u756_34(i1,i2).d(1,1)=zcl(id7)*cz34(i1,i2).ek0
      u756_34(i1,i2).d(2,2)=zcr(id7)*cz34(i1,i2).ek0
      end do
      end do
      do i1=1,2
      do i2=1,2
* T -- qu=p756,qd=p812,v=cf34(i1,i2).e,a=u756_34(i1,i2).a,b=u756_34(i1,i
* 2).b,c=u756_34(i1,i2).c,d=u756_34(i1,i2).d,cr=fcr(id7),cl=fcl(id7),nsu
* m=1
      ceps_0=-cf34(i1,i2).ek0*(p756(2)*p812(3)-p812(2)*p756(3))+
     & p756k0*(cf34(i1,i2).e(2)*p812(3)-p812(2)*cf34(i1,i2).e(3)
     & )-p812k0*(cf34(i1,i2).e(2)*p756(3)-p756(2)*cf34(i1,i2).e(
     & 3))
      ceps_0=ceps_0*cim
      ceps_1=-cf34(i1,i2).e(3)*p756k0+p756(3)*cf34(i1,i2).ek0
      ceps_1=ceps_1*cim
      ceps_2=-cf34(i1,i2).e(3)*p812k0+p812(3)*cf34(i1,i2).ek0
      ceps_2=ceps_2*cim
      cvqu=cf34(i1,i2).e(0)*p756(0)-cf34(i1,i2).e(1)*p756(1)-cf3
     & 4(i1,i2).e(2)*p756(2)-cf34(i1,i2).e(3)*p756(3)
      cvqd=cf34(i1,i2).e(0)*p812(0)-cf34(i1,i2).e(1)*p812(1)-cf3
     & 4(i1,i2).e(2)*p812(2)-cf34(i1,i2).e(3)*p812(3)
      cauxa=-cf34(i1,i2).ek0*quqd+p756k0*cvqd+p812k0*cvqu
      cauxb=-cf34(i1,i2).ek0*p812(2)+p812k0*cf34(i1,i2).e(2)
      cauxc=+cf34(i1,i2).ek0*p756(2)-p756k0*cf34(i1,i2).e(2)
      u756_34(i1,i2).a(1,1)=u756_34(i1,i2).a(1,1)+fcr(id7)*(caux
     & a+ceps_0)
      u756_34(i1,i2).a(2,2)=u756_34(i1,i2).a(2,2)+fcl(id7)*(caux
     & a-ceps_0)
      u756_34(i1,i2).b(1,2)=u756_34(i1,i2).b(1,2)+fcl(id7)*(caux
     & b-ceps_2)
      u756_34(i1,i2).b(2,1)=u756_34(i1,i2).b(2,1)+fcr(id7)*(-cau
     & xb-ceps_2)
      u756_34(i1,i2).c(1,2)=u756_34(i1,i2).c(1,2)+fcr(id7)*(caux
     & c+ceps_1)
      u756_34(i1,i2).c(2,1)=u756_34(i1,i2).c(2,1)+fcl(id7)*(-cau
     & xc+ceps_1)
      u756_34(i1,i2).d(1,1)=u756_34(i1,i2).d(1,1)+fcl(id7)*cf34(
     & i1,i2).ek0
      u756_34(i1,i2).d(2,2)=u756_34(i1,i2).d(2,2)+fcr(id7)*cf34(
     & i1,i2).ek0
      end do
      end do
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (id7.eq.5.and.id3.eq.5.and.rmh.ge.0.d0) then
  
* TH -- qu=p756,qd=p812,a=clineth.a,b=clineth.b,c=clineth.c,coupl=1.d0
      auxa=-p756k0*p812(2)+p812k0*p756(2)
      cauxa=auxa-cim*(p812(3)*p756k0-p756(3)*p812k0)
      clineth.a(1,2)=cauxa
      clineth.a(2,1)=-conjg(cauxa)
      clineth.b(1,1)=p812k0
      clineth.b(2,2)=clineth.b(1,1)
      clineth.c(1,1)=p756k0
      clineth.c(2,2)=clineth.c(1,1)
  
      cfactor= rhbb**2/(s34-cmh2)+rhhbb**2/(s34-cmhh2)
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u756_34(i1,i2).a(i3,i4)=ch34(i1,i2)
     &                 *clineth.a(i3,i4)
     &                 *cfactor
                else
                  u756_34(i1,i2).b(i3,i4)=ch34(i1,i2)
     &                 *clineth.b(i3,i4)
     &                 *cfactor
                  u756_34(i1,i2).c(i3,i4)=ch34(i1,i2)
     &                 *clineth.c(i3,i4)
     &                 *cfactor
                endif
              enddo
            enddo
          enddo
        enddo
      else
         do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                if (i3.ne.i4) then
                  u756_34(i1,i2).a(i3,i4)=czero
                else
                  u756_34(i1,i2).b(i3,i4)=czero
                  u756_34(i1,i2).c(i3,i4)=czero
                endif
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
  
  
  
* COMPUTE ALL DOUBLE INSERTIONS  OF THE TYPE UI_JKLM                    
*     FOR A ZLINE                                                       
*                                                                       
*        I __                                                           
*            |___/                                                      
*            |   \                                                      
*            |                                                          
*            |___/                                                      
*            |   \                                                      
*            |                                                          
*                                                                       
  
*Initialization of the variables to sum                                 
  
      do i1=1,2
       do i2=1,2
        do i3=1,2
         do i4=1,2
          do i5=1,2
           do i6=1,2
  
                u1_3456(i1,i2,i3,i4).a(i5,i6)=czero
                u1_3456(i1,i2,i3,i4).b(i5,i6)=czero
                u1_3456(i1,i2,i3,i4).c(i5,i6)=czero
                u1_3456(i1,i2,i3,i4).d(i5,i6)=czero
  
                u1_3478(i1,i2,i3,i4).a(i5,i6)=czero
                u1_3478(i1,i2,i3,i4).b(i5,i6)=czero
                u1_3478(i1,i2,i3,i4).c(i5,i6)=czero
                u1_3478(i1,i2,i3,i4).d(i5,i6)=czero
  
                u1_5678(i1,i2,i3,i4).a(i5,i6)=czero
                u1_5678(i1,i2,i3,i4).b(i5,i6)=czero
                u1_5678(i1,i2,i3,i4).c(i5,i6)=czero
                u1_5678(i1,i2,i3,i4).d(i5,i6)=czero
  
                u3_1256(i1,i2,i3,i4).a(i5,i6)=czero
                u3_1256(i1,i2,i3,i4).b(i5,i6)=czero
                u3_1256(i1,i2,i3,i4).c(i5,i6)=czero
                u3_1256(i1,i2,i3,i4).d(i5,i6)=czero
  
                u3_1278(i1,i2,i3,i4).a(i5,i6)=czero
                u3_1278(i1,i2,i3,i4).b(i5,i6)=czero
                u3_1278(i1,i2,i3,i4).c(i5,i6)=czero
                u3_1278(i1,i2,i3,i4).d(i5,i6)=czero
  
                u3_5678(i1,i2,i3,i4).a(i5,i6)=czero
                u3_5678(i1,i2,i3,i4).b(i5,i6)=czero
                u3_5678(i1,i2,i3,i4).c(i5,i6)=czero
                u3_5678(i1,i2,i3,i4).d(i5,i6)=czero
  
                u5_1234(i1,i2,i3,i4).a(i5,i6)=czero
                u5_1234(i1,i2,i3,i4).b(i5,i6)=czero
                u5_1234(i1,i2,i3,i4).c(i5,i6)=czero
                u5_1234(i1,i2,i3,i4).d(i5,i6)=czero
  
                u5_1278(i1,i2,i3,i4).a(i5,i6)=czero
                u5_1278(i1,i2,i3,i4).b(i5,i6)=czero
                u5_1278(i1,i2,i3,i4).c(i5,i6)=czero
                u5_1278(i1,i2,i3,i4).d(i5,i6)=czero
  
                u5_3478(i1,i2,i3,i4).a(i5,i6)=czero
                u5_3478(i1,i2,i3,i4).b(i5,i6)=czero
                u5_3478(i1,i2,i3,i4).c(i5,i6)=czero
                u5_3478(i1,i2,i3,i4).d(i5,i6)=czero
  
  
                u7_1234(i1,i2,i3,i4).a(i5,i6)=czero
                u7_1234(i1,i2,i3,i4).b(i5,i6)=czero
                u7_1234(i1,i2,i3,i4).c(i5,i6)=czero
                u7_1234(i1,i2,i3,i4).d(i5,i6)=czero
  
                u7_1256(i1,i2,i3,i4).a(i5,i6)=czero
                u7_1256(i1,i2,i3,i4).b(i5,i6)=czero
                u7_1256(i1,i2,i3,i4).c(i5,i6)=czero
                u7_1256(i1,i2,i3,i4).d(i5,i6)=czero
  
                u7_3456(i1,i2,i3,i4).a(i5,i6)=czero
                u7_3456(i1,i2,i3,i4).b(i5,i6)=czero
                u7_3456(i1,i2,i3,i4).c(i5,i6)=czero
                u7_3456(i1,i2,i3,i4).d(i5,i6)=czero
  
  
  
           enddo
          enddo
         enddo
        enddo	
       enddo
      enddo
  
  
* p.q -- p.q=p134q,p=p134,q=p134,bef=,aft=
      p134q=(p134(0)*p134(0)-p134(1)*p134(1)-p134(2)*p134(2)-p13
     & 4(3)*p134(3))
  
      if(id1.ne.5.or.(id3.ne.5.and.id5.ne.5))then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TT -- aa=u1_3456(i3,i4,i5,i6).a,bb=u1_3456(i3,i4,i5,i6).b,cc=u1_3456(i
* 3,i4,i5,i6).c,dd=u1_3456(i3,i4,i5,i6).d,a1=l1_34(i3,i4).a,b1=l1_34(i3,
* i4).b,c1=l1_34(i3,i4).c,d1=l1_34(i3,i4).d,a2=u134_56(i5,i6).a,b2=u134_
* 56(i5,i6).b,c2=u134_56(i5,i6).c,d2=u134_56(i5,i6).d,prq=p134q,m=rmass(
* id1),nsum=1
      u1_3456(i3,i4,i5,i6).a(1,1)=u1_3456(i3,i4,i5,i6).a(1,1)+l1
     & _34(i3,i4).a(1,1)*u134_56(i5,i6).a(1,1)+l1_34(i3,i4).c(1,
     & 2)*p134q*u134_56(i5,i6).b(2,1)
      u1_3456(i3,i4,i5,i6).b(1,1)=u1_3456(i3,i4,i5,i6).b(1,1)+rm
     & ass(id1)*(l1_34(i3,i4).d(1,1)*u134_56(i5,i6).a(1,1)+l1_34
     & (i3,i4).b(1,2)*u134_56(i5,i6).b(2,1))
      u1_3456(i3,i4,i5,i6).c(1,1)=u1_3456(i3,i4,i5,i6).c(1,1)+rm
     & ass(id1)*(l1_34(i3,i4).a(1,1)*u134_56(i5,i6).d(1,1)+l1_34
     & (i3,i4).c(1,2)*u134_56(i5,i6).c(2,1))
      u1_3456(i3,i4,i5,i6).d(1,1)=u1_3456(i3,i4,i5,i6).d(1,1)+l1
     & _34(i3,i4).d(1,1)*p134q*u134_56(i5,i6).d(1,1)+l1_34(i3,i4
     & ).b(1,2)*u134_56(i5,i6).c(2,1)
      u1_3456(i3,i4,i5,i6).a(1,2)=u1_3456(i3,i4,i5,i6).a(1,2)+rm
     & ass(id1)*(l1_34(i3,i4).a(1,1)*u134_56(i5,i6).b(1,2)+l1_34
     & (i3,i4).c(1,2)*u134_56(i5,i6).a(2,2))
      u1_3456(i3,i4,i5,i6).b(1,2)=u1_3456(i3,i4,i5,i6).b(1,2)+l1
     & _34(i3,i4).d(1,1)*p134q*u134_56(i5,i6).b(1,2)+l1_34(i3,i4
     & ).b(1,2)*u134_56(i5,i6).a(2,2)
      u1_3456(i3,i4,i5,i6).c(1,2)=u1_3456(i3,i4,i5,i6).c(1,2)+l1
     & _34(i3,i4).a(1,1)*u134_56(i5,i6).c(1,2)+l1_34(i3,i4).c(1,
     & 2)*p134q*u134_56(i5,i6).d(2,2)
      u1_3456(i3,i4,i5,i6).d(1,2)=u1_3456(i3,i4,i5,i6).d(1,2)+rm
     & ass(id1)*(l1_34(i3,i4).d(1,1)*u134_56(i5,i6).c(1,2)+l1_34
     & (i3,i4).b(1,2)*u134_56(i5,i6).d(2,2))
      u1_3456(i3,i4,i5,i6).a(2,1)=u1_3456(i3,i4,i5,i6).a(2,1)+rm
     & ass(id1)*(l1_34(i3,i4).c(2,1)*u134_56(i5,i6).a(1,1)+l1_34
     & (i3,i4).a(2,2)*u134_56(i5,i6).b(2,1))
      u1_3456(i3,i4,i5,i6).b(2,1)=u1_3456(i3,i4,i5,i6).b(2,1)+l1
     & _34(i3,i4).b(2,1)*u134_56(i5,i6).a(1,1)+l1_34(i3,i4).d(2,
     & 2)*p134q*u134_56(i5,i6).b(2,1)
      u1_3456(i3,i4,i5,i6).c(2,1)=u1_3456(i3,i4,i5,i6).c(2,1)+l1
     & _34(i3,i4).c(2,1)*p134q*u134_56(i5,i6).d(1,1)+l1_34(i3,i4
     & ).a(2,2)*u134_56(i5,i6).c(2,1)
      u1_3456(i3,i4,i5,i6).d(2,1)=u1_3456(i3,i4,i5,i6).d(2,1)+rm
     & ass(id1)*(l1_34(i3,i4).b(2,1)*u134_56(i5,i6).d(1,1)+l1_34
     & (i3,i4).d(2,2)*u134_56(i5,i6).c(2,1))
      u1_3456(i3,i4,i5,i6).a(2,2)=u1_3456(i3,i4,i5,i6).a(2,2)+l1
     & _34(i3,i4).c(2,1)*p134q*u134_56(i5,i6).b(1,2)+l1_34(i3,i4
     & ).a(2,2)*u134_56(i5,i6).a(2,2)
      u1_3456(i3,i4,i5,i6).b(2,2)=u1_3456(i3,i4,i5,i6).b(2,2)+rm
     & ass(id1)*(l1_34(i3,i4).b(2,1)*u134_56(i5,i6).b(1,2)+l1_34
     & (i3,i4).d(2,2)*u134_56(i5,i6).a(2,2))
      u1_3456(i3,i4,i5,i6).c(2,2)=u1_3456(i3,i4,i5,i6).c(2,2)+rm
     & ass(id1)*(l1_34(i3,i4).c(2,1)*u134_56(i5,i6).c(1,2)+l1_34
     & (i3,i4).a(2,2)*u134_56(i5,i6).d(2,2))
      u1_3456(i3,i4,i5,i6).d(2,2)=u1_3456(i3,i4,i5,i6).d(2,2)+l1
     & _34(i3,i4).b(2,1)*u134_56(i5,i6).c(1,2)+l1_34(i3,i4).d(2,
     & 2)*p134q*u134_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id1.eq.5.and.id3.eq.5.and.id5.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TsTs -- aa=u1_3456(i3,i4,i5,i6).a,bb=u1_3456(i3,i4,i5,i6).b,cc=u1_3456
* (i3,i4,i5,i6).c,dd=u1_3456(i3,i4,i5,i6).d,a1=l1_34(i3,i4).a,b1=l1_34(i
* 3,i4).b,c1=l1_34(i3,i4).c,d1=l1_34(i3,i4).d,a2=u134_56(i5,i6).a,b2=u13
* 4_56(i5,i6).b,c2=u134_56(i5,i6).c,d2=u134_56(i5,i6).d,prq=p134q,m=rmas
* s(id1),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u134_56(i5,i6).a(1,jut)+rmass(id1)*u134_56(i5,i6).b(1,
     & jut)
      cx2=u134_56(i5,i6).a(2,jut)+rmass(id1)*u134_56(i5,i6).b(2,
     & jut)
      cy1=p134q*u134_56(i5,i6).b(1,jut)+rmass(id1)*u134_56(i5,i6
     & ).a(1,jut)
      cy2=p134q*u134_56(i5,i6).b(2,jut)+rmass(id1)*u134_56(i5,i6
     & ).a(2,jut)
      u1_3456(i3,i4,i5,i6).a(iut,jut)=u1_3456(i3,i4,i5,i6).a(iut
     & ,jut)+l1_34(i3,i4).a(iut,1)*cx1+l1_34(i3,i4).c(iut,1)*cy1
     & +l1_34(i3,i4).a(iut,2)*cx2+l1_34(i3,i4).c(iut,2)*cy2
      u1_3456(i3,i4,i5,i6).b(iut,jut)=u1_3456(i3,i4,i5,i6).b(iut
     & ,jut)+l1_34(i3,i4).b(iut,1)*cx1+l1_34(i3,i4).d(iut,1)*cy1
     & +l1_34(i3,i4).b(iut,2)*cx2+l1_34(i3,i4).d(iut,2)*cy2
      cw1=u134_56(i5,i6).c(1,jut)+rmass(id1)*u134_56(i5,i6).d(1,
     & jut)
      cw2=u134_56(i5,i6).c(2,jut)+rmass(id1)*u134_56(i5,i6).d(2,
     & jut)
      cz1=p134q*u134_56(i5,i6).d(1,jut)+rmass(id1)*u134_56(i5,i6
     & ).c(1,jut)
      cz2=p134q*u134_56(i5,i6).d(2,jut)+rmass(id1)*u134_56(i5,i6
     & ).c(2,jut)
      u1_3456(i3,i4,i5,i6).c(iut,jut)=u1_3456(i3,i4,i5,i6).c(iut
     & ,jut)+l1_34(i3,i4).a(iut,1)*cw1+l1_34(i3,i4).c(iut,1)*cz1
     & +l1_34(i3,i4).a(iut,2)*cw2+l1_34(i3,i4).c(iut,2)*cz2
      u1_3456(i3,i4,i5,i6).d(iut,jut)=u1_3456(i3,i4,i5,i6).d(iut
     & ,jut)+l1_34(i3,i4).b(iut,1)*cw1+l1_34(i3,i4).d(iut,1)*cz1
     & +l1_34(i3,i4).b(iut,2)*cw2+l1_34(i3,i4).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id1.eq.5.and.id3.eq.5.and.id5.ne.5)then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TsT -- aa=u1_3456(i3,i4,i5,i6).a,bb=u1_3456(i3,i4,i5,i6).b,cc=u1_3456(
* i3,i4,i5,i6).c,dd=u1_3456(i3,i4,i5,i6).d,a1=l1_34(i3,i4).a,b1=l1_34(i3
* ,i4).b,c1=l1_34(i3,i4).c,d1=l1_34(i3,i4).d,a2=u134_56(i5,i6).a,b2=u134
* _56(i5,i6).b,c2=u134_56(i5,i6).c,d2=u134_56(i5,i6).d,prq=p134q,m=rmass
* (id1),nsum=1
      do iut=1,2
      cx1=l1_34(i3,i4).a(iut,1)+l1_34(i3,i4).c(iut,1)*rmass(id1)
      cx2=l1_34(i3,i4).c(iut,2)*p134q+l1_34(i3,i4).a(iut,2)*rmas
     & s(id1)
      cy1=l1_34(i3,i4).b(iut,1)+l1_34(i3,i4).d(iut,1)*rmass(id1)
      cy2=l1_34(i3,i4).d(iut,2)*p134q+l1_34(i3,i4).b(iut,2)*rmas
     & s(id1)
      cw1=l1_34(i3,i4).c(iut,1)*p134q+l1_34(i3,i4).a(iut,1)*rmas
     & s(id1)
      cw2=l1_34(i3,i4).a(iut,2)+l1_34(i3,i4).c(iut,2)*rmass(id1)
      cz1=l1_34(i3,i4).d(iut,1)*p134q+l1_34(i3,i4).b(iut,1)*rmas
     & s(id1)
      cz2=l1_34(i3,i4).b(iut,2)+l1_34(i3,i4).d(iut,2)*rmass(id1)
      u1_3456(i3,i4,i5,i6).a(iut,1)=u1_3456(i3,i4,i5,i6).a(iut,1
     & )+cx1*u134_56(i5,i6).a(1,1)+cx2*u134_56(i5,i6).b(2,1)
      u1_3456(i3,i4,i5,i6).b(iut,1)=u1_3456(i3,i4,i5,i6).b(iut,1
     & )+cy1*u134_56(i5,i6).a(1,1)+cy2*u134_56(i5,i6).b(2,1)
      u1_3456(i3,i4,i5,i6).c(iut,1)=u1_3456(i3,i4,i5,i6).c(iut,1
     & )+cw1*u134_56(i5,i6).d(1,1)+cw2*u134_56(i5,i6).c(2,1)
      u1_3456(i3,i4,i5,i6).d(iut,1)=u1_3456(i3,i4,i5,i6).d(iut,1
     & )+cz1*u134_56(i5,i6).d(1,1)+cz2*u134_56(i5,i6).c(2,1)
      u1_3456(i3,i4,i5,i6).a(iut,2)=u1_3456(i3,i4,i5,i6).a(iut,2
     & )+cw1*u134_56(i5,i6).b(1,2)+cw2*u134_56(i5,i6).a(2,2)
      u1_3456(i3,i4,i5,i6).b(iut,2)=u1_3456(i3,i4,i5,i6).b(iut,2
     & )+cz1*u134_56(i5,i6).b(1,2)+cz2*u134_56(i5,i6).a(2,2)
      u1_3456(i3,i4,i5,i6).c(iut,2)=u1_3456(i3,i4,i5,i6).c(iut,2
     & )+cx1*u134_56(i5,i6).c(1,2)+cx2*u134_56(i5,i6).d(2,2)
      u1_3456(i3,i4,i5,i6).d(iut,2)=u1_3456(i3,i4,i5,i6).d(iut,2
     & )+cy1*u134_56(i5,i6).c(1,2)+cy2*u134_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id1.eq.5.and.id3.ne.5.and.id5.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TTs -- aa=u1_3456(i3,i4,i5,i6).a,bb=u1_3456(i3,i4,i5,i6).b,cc=u1_3456(
* i3,i4,i5,i6).c,dd=u1_3456(i3,i4,i5,i6).d,a1=l1_34(i3,i4).a,b1=l1_34(i3
* ,i4).b,c1=l1_34(i3,i4).c,d1=l1_34(i3,i4).d,a2=u134_56(i5,i6).a,b2=u134
* _56(i5,i6).b,c2=u134_56(i5,i6).c,d2=u134_56(i5,i6).d,prq=p134q,m=rmass
* (id1),nsum=1
      do jut=1,2
      cx1=u134_56(i5,i6).a(1,jut)+rmass(id1)*u134_56(i5,i6).b(1,
     & jut)
      cx2=u134_56(i5,i6).a(2,jut)+rmass(id1)*u134_56(i5,i6).b(2,
     & jut)
      cy1=p134q*u134_56(i5,i6).b(1,jut)+rmass(id1)*u134_56(i5,i6
     & ).a(1,jut)
      cy2=p134q*u134_56(i5,i6).b(2,jut)+rmass(id1)*u134_56(i5,i6
     & ).a(2,jut)
      cw1=u134_56(i5,i6).c(1,jut)+rmass(id1)*u134_56(i5,i6).d(1,
     & jut)
      cw2=u134_56(i5,i6).c(2,jut)+rmass(id1)*u134_56(i5,i6).d(2,
     & jut)
      cz1=p134q*u134_56(i5,i6).d(1,jut)+rmass(id1)*u134_56(i5,i6
     & ).c(1,jut)
      cz2=p134q*u134_56(i5,i6).d(2,jut)+rmass(id1)*u134_56(i5,i6
     & ).c(2,jut)
      u1_3456(i3,i4,i5,i6).a(1,jut)=u1_3456(i3,i4,i5,i6).a(1,jut
     & )+l1_34(i3,i4).a(1,1)*cx1+l1_34(i3,i4).c(1,2)*cy2
      u1_3456(i3,i4,i5,i6).b(1,jut)=u1_3456(i3,i4,i5,i6).b(1,jut
     & )+l1_34(i3,i4).d(1,1)*cy1+l1_34(i3,i4).b(1,2)*cx2
      u1_3456(i3,i4,i5,i6).c(1,jut)=u1_3456(i3,i4,i5,i6).c(1,jut
     & )+l1_34(i3,i4).a(1,1)*cw1+l1_34(i3,i4).c(1,2)*cz2
      u1_3456(i3,i4,i5,i6).d(1,jut)=u1_3456(i3,i4,i5,i6).d(1,jut
     & )+l1_34(i3,i4).d(1,1)*cz1+l1_34(i3,i4).b(1,2)*cw2
      u1_3456(i3,i4,i5,i6).a(2,jut)=u1_3456(i3,i4,i5,i6).a(2,jut
     & )+l1_34(i3,i4).c(2,1)*cy1+l1_34(i3,i4).a(2,2)*cx2
      u1_3456(i3,i4,i5,i6).b(2,jut)=u1_3456(i3,i4,i5,i6).b(2,jut
     & )+l1_34(i3,i4).b(2,1)*cx1+l1_34(i3,i4).d(2,2)*cy2
      u1_3456(i3,i4,i5,i6).c(2,jut)=u1_3456(i3,i4,i5,i6).c(2,jut
     & )+l1_34(i3,i4).c(2,1)*cz1+l1_34(i3,i4).a(2,2)*cw2
      u1_3456(i3,i4,i5,i6).d(2,jut)=u1_3456(i3,i4,i5,i6).d(2,jut
     & )+l1_34(i3,i4).b(2,1)*cw1+l1_34(i3,i4).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p156q,p=p156,q=p156,bef=,aft=
      p156q=(p156(0)*p156(0)-p156(1)*p156(1)-p156(2)*p156(2)-p15
     & 6(3)*p156(3))
  
      if(id1.ne.5.or.(id5.ne.5.and.id3.ne.5))then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TT -- aa=u1_3456(i3,i4,i5,i6).a,bb=u1_3456(i3,i4,i5,i6).b,cc=u1_3456(i
* 3,i4,i5,i6).c,dd=u1_3456(i3,i4,i5,i6).d,a1=l1_56(i5,i6).a,b1=l1_56(i5,
* i6).b,c1=l1_56(i5,i6).c,d1=l1_56(i5,i6).d,a2=u156_34(i3,i4).a,b2=u156_
* 34(i3,i4).b,c2=u156_34(i3,i4).c,d2=u156_34(i3,i4).d,prq=p156q,m=rmass(
* id1),nsum=1
      u1_3456(i3,i4,i5,i6).a(1,1)=u1_3456(i3,i4,i5,i6).a(1,1)+l1
     & _56(i5,i6).a(1,1)*u156_34(i3,i4).a(1,1)+l1_56(i5,i6).c(1,
     & 2)*p156q*u156_34(i3,i4).b(2,1)
      u1_3456(i3,i4,i5,i6).b(1,1)=u1_3456(i3,i4,i5,i6).b(1,1)+rm
     & ass(id1)*(l1_56(i5,i6).d(1,1)*u156_34(i3,i4).a(1,1)+l1_56
     & (i5,i6).b(1,2)*u156_34(i3,i4).b(2,1))
      u1_3456(i3,i4,i5,i6).c(1,1)=u1_3456(i3,i4,i5,i6).c(1,1)+rm
     & ass(id1)*(l1_56(i5,i6).a(1,1)*u156_34(i3,i4).d(1,1)+l1_56
     & (i5,i6).c(1,2)*u156_34(i3,i4).c(2,1))
      u1_3456(i3,i4,i5,i6).d(1,1)=u1_3456(i3,i4,i5,i6).d(1,1)+l1
     & _56(i5,i6).d(1,1)*p156q*u156_34(i3,i4).d(1,1)+l1_56(i5,i6
     & ).b(1,2)*u156_34(i3,i4).c(2,1)
      u1_3456(i3,i4,i5,i6).a(1,2)=u1_3456(i3,i4,i5,i6).a(1,2)+rm
     & ass(id1)*(l1_56(i5,i6).a(1,1)*u156_34(i3,i4).b(1,2)+l1_56
     & (i5,i6).c(1,2)*u156_34(i3,i4).a(2,2))
      u1_3456(i3,i4,i5,i6).b(1,2)=u1_3456(i3,i4,i5,i6).b(1,2)+l1
     & _56(i5,i6).d(1,1)*p156q*u156_34(i3,i4).b(1,2)+l1_56(i5,i6
     & ).b(1,2)*u156_34(i3,i4).a(2,2)
      u1_3456(i3,i4,i5,i6).c(1,2)=u1_3456(i3,i4,i5,i6).c(1,2)+l1
     & _56(i5,i6).a(1,1)*u156_34(i3,i4).c(1,2)+l1_56(i5,i6).c(1,
     & 2)*p156q*u156_34(i3,i4).d(2,2)
      u1_3456(i3,i4,i5,i6).d(1,2)=u1_3456(i3,i4,i5,i6).d(1,2)+rm
     & ass(id1)*(l1_56(i5,i6).d(1,1)*u156_34(i3,i4).c(1,2)+l1_56
     & (i5,i6).b(1,2)*u156_34(i3,i4).d(2,2))
      u1_3456(i3,i4,i5,i6).a(2,1)=u1_3456(i3,i4,i5,i6).a(2,1)+rm
     & ass(id1)*(l1_56(i5,i6).c(2,1)*u156_34(i3,i4).a(1,1)+l1_56
     & (i5,i6).a(2,2)*u156_34(i3,i4).b(2,1))
      u1_3456(i3,i4,i5,i6).b(2,1)=u1_3456(i3,i4,i5,i6).b(2,1)+l1
     & _56(i5,i6).b(2,1)*u156_34(i3,i4).a(1,1)+l1_56(i5,i6).d(2,
     & 2)*p156q*u156_34(i3,i4).b(2,1)
      u1_3456(i3,i4,i5,i6).c(2,1)=u1_3456(i3,i4,i5,i6).c(2,1)+l1
     & _56(i5,i6).c(2,1)*p156q*u156_34(i3,i4).d(1,1)+l1_56(i5,i6
     & ).a(2,2)*u156_34(i3,i4).c(2,1)
      u1_3456(i3,i4,i5,i6).d(2,1)=u1_3456(i3,i4,i5,i6).d(2,1)+rm
     & ass(id1)*(l1_56(i5,i6).b(2,1)*u156_34(i3,i4).d(1,1)+l1_56
     & (i5,i6).d(2,2)*u156_34(i3,i4).c(2,1))
      u1_3456(i3,i4,i5,i6).a(2,2)=u1_3456(i3,i4,i5,i6).a(2,2)+l1
     & _56(i5,i6).c(2,1)*p156q*u156_34(i3,i4).b(1,2)+l1_56(i5,i6
     & ).a(2,2)*u156_34(i3,i4).a(2,2)
      u1_3456(i3,i4,i5,i6).b(2,2)=u1_3456(i3,i4,i5,i6).b(2,2)+rm
     & ass(id1)*(l1_56(i5,i6).b(2,1)*u156_34(i3,i4).b(1,2)+l1_56
     & (i5,i6).d(2,2)*u156_34(i3,i4).a(2,2))
      u1_3456(i3,i4,i5,i6).c(2,2)=u1_3456(i3,i4,i5,i6).c(2,2)+rm
     & ass(id1)*(l1_56(i5,i6).c(2,1)*u156_34(i3,i4).c(1,2)+l1_56
     & (i5,i6).a(2,2)*u156_34(i3,i4).d(2,2))
      u1_3456(i3,i4,i5,i6).d(2,2)=u1_3456(i3,i4,i5,i6).d(2,2)+l1
     & _56(i5,i6).b(2,1)*u156_34(i3,i4).c(1,2)+l1_56(i5,i6).d(2,
     & 2)*p156q*u156_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id1.eq.5.and.id5.eq.5.and.id3.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TsTs -- aa=u1_3456(i3,i4,i5,i6).a,bb=u1_3456(i3,i4,i5,i6).b,cc=u1_3456
* (i3,i4,i5,i6).c,dd=u1_3456(i3,i4,i5,i6).d,a1=l1_56(i5,i6).a,b1=l1_56(i
* 5,i6).b,c1=l1_56(i5,i6).c,d1=l1_56(i5,i6).d,a2=u156_34(i3,i4).a,b2=u15
* 6_34(i3,i4).b,c2=u156_34(i3,i4).c,d2=u156_34(i3,i4).d,prq=p156q,m=rmas
* s(id1),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u156_34(i3,i4).a(1,jut)+rmass(id1)*u156_34(i3,i4).b(1,
     & jut)
      cx2=u156_34(i3,i4).a(2,jut)+rmass(id1)*u156_34(i3,i4).b(2,
     & jut)
      cy1=p156q*u156_34(i3,i4).b(1,jut)+rmass(id1)*u156_34(i3,i4
     & ).a(1,jut)
      cy2=p156q*u156_34(i3,i4).b(2,jut)+rmass(id1)*u156_34(i3,i4
     & ).a(2,jut)
      u1_3456(i3,i4,i5,i6).a(iut,jut)=u1_3456(i3,i4,i5,i6).a(iut
     & ,jut)+l1_56(i5,i6).a(iut,1)*cx1+l1_56(i5,i6).c(iut,1)*cy1
     & +l1_56(i5,i6).a(iut,2)*cx2+l1_56(i5,i6).c(iut,2)*cy2
      u1_3456(i3,i4,i5,i6).b(iut,jut)=u1_3456(i3,i4,i5,i6).b(iut
     & ,jut)+l1_56(i5,i6).b(iut,1)*cx1+l1_56(i5,i6).d(iut,1)*cy1
     & +l1_56(i5,i6).b(iut,2)*cx2+l1_56(i5,i6).d(iut,2)*cy2
      cw1=u156_34(i3,i4).c(1,jut)+rmass(id1)*u156_34(i3,i4).d(1,
     & jut)
      cw2=u156_34(i3,i4).c(2,jut)+rmass(id1)*u156_34(i3,i4).d(2,
     & jut)
      cz1=p156q*u156_34(i3,i4).d(1,jut)+rmass(id1)*u156_34(i3,i4
     & ).c(1,jut)
      cz2=p156q*u156_34(i3,i4).d(2,jut)+rmass(id1)*u156_34(i3,i4
     & ).c(2,jut)
      u1_3456(i3,i4,i5,i6).c(iut,jut)=u1_3456(i3,i4,i5,i6).c(iut
     & ,jut)+l1_56(i5,i6).a(iut,1)*cw1+l1_56(i5,i6).c(iut,1)*cz1
     & +l1_56(i5,i6).a(iut,2)*cw2+l1_56(i5,i6).c(iut,2)*cz2
      u1_3456(i3,i4,i5,i6).d(iut,jut)=u1_3456(i3,i4,i5,i6).d(iut
     & ,jut)+l1_56(i5,i6).b(iut,1)*cw1+l1_56(i5,i6).d(iut,1)*cz1
     & +l1_56(i5,i6).b(iut,2)*cw2+l1_56(i5,i6).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id1.eq.5.and.id5.eq.5.and.id3.ne.5)then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TsT -- aa=u1_3456(i3,i4,i5,i6).a,bb=u1_3456(i3,i4,i5,i6).b,cc=u1_3456(
* i3,i4,i5,i6).c,dd=u1_3456(i3,i4,i5,i6).d,a1=l1_56(i5,i6).a,b1=l1_56(i5
* ,i6).b,c1=l1_56(i5,i6).c,d1=l1_56(i5,i6).d,a2=u156_34(i3,i4).a,b2=u156
* _34(i3,i4).b,c2=u156_34(i3,i4).c,d2=u156_34(i3,i4).d,prq=p156q,m=rmass
* (id1),nsum=1
      do iut=1,2
      cx1=l1_56(i5,i6).a(iut,1)+l1_56(i5,i6).c(iut,1)*rmass(id1)
      cx2=l1_56(i5,i6).c(iut,2)*p156q+l1_56(i5,i6).a(iut,2)*rmas
     & s(id1)
      cy1=l1_56(i5,i6).b(iut,1)+l1_56(i5,i6).d(iut,1)*rmass(id1)
      cy2=l1_56(i5,i6).d(iut,2)*p156q+l1_56(i5,i6).b(iut,2)*rmas
     & s(id1)
      cw1=l1_56(i5,i6).c(iut,1)*p156q+l1_56(i5,i6).a(iut,1)*rmas
     & s(id1)
      cw2=l1_56(i5,i6).a(iut,2)+l1_56(i5,i6).c(iut,2)*rmass(id1)
      cz1=l1_56(i5,i6).d(iut,1)*p156q+l1_56(i5,i6).b(iut,1)*rmas
     & s(id1)
      cz2=l1_56(i5,i6).b(iut,2)+l1_56(i5,i6).d(iut,2)*rmass(id1)
      u1_3456(i3,i4,i5,i6).a(iut,1)=u1_3456(i3,i4,i5,i6).a(iut,1
     & )+cx1*u156_34(i3,i4).a(1,1)+cx2*u156_34(i3,i4).b(2,1)
      u1_3456(i3,i4,i5,i6).b(iut,1)=u1_3456(i3,i4,i5,i6).b(iut,1
     & )+cy1*u156_34(i3,i4).a(1,1)+cy2*u156_34(i3,i4).b(2,1)
      u1_3456(i3,i4,i5,i6).c(iut,1)=u1_3456(i3,i4,i5,i6).c(iut,1
     & )+cw1*u156_34(i3,i4).d(1,1)+cw2*u156_34(i3,i4).c(2,1)
      u1_3456(i3,i4,i5,i6).d(iut,1)=u1_3456(i3,i4,i5,i6).d(iut,1
     & )+cz1*u156_34(i3,i4).d(1,1)+cz2*u156_34(i3,i4).c(2,1)
      u1_3456(i3,i4,i5,i6).a(iut,2)=u1_3456(i3,i4,i5,i6).a(iut,2
     & )+cw1*u156_34(i3,i4).b(1,2)+cw2*u156_34(i3,i4).a(2,2)
      u1_3456(i3,i4,i5,i6).b(iut,2)=u1_3456(i3,i4,i5,i6).b(iut,2
     & )+cz1*u156_34(i3,i4).b(1,2)+cz2*u156_34(i3,i4).a(2,2)
      u1_3456(i3,i4,i5,i6).c(iut,2)=u1_3456(i3,i4,i5,i6).c(iut,2
     & )+cx1*u156_34(i3,i4).c(1,2)+cx2*u156_34(i3,i4).d(2,2)
      u1_3456(i3,i4,i5,i6).d(iut,2)=u1_3456(i3,i4,i5,i6).d(iut,2
     & )+cy1*u156_34(i3,i4).c(1,2)+cy2*u156_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id1.eq.5.and.id5.ne.5.and.id3.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TTs -- aa=u1_3456(i3,i4,i5,i6).a,bb=u1_3456(i3,i4,i5,i6).b,cc=u1_3456(
* i3,i4,i5,i6).c,dd=u1_3456(i3,i4,i5,i6).d,a1=l1_56(i5,i6).a,b1=l1_56(i5
* ,i6).b,c1=l1_56(i5,i6).c,d1=l1_56(i5,i6).d,a2=u156_34(i3,i4).a,b2=u156
* _34(i3,i4).b,c2=u156_34(i3,i4).c,d2=u156_34(i3,i4).d,prq=p156q,m=rmass
* (id1),nsum=1
      do jut=1,2
      cx1=u156_34(i3,i4).a(1,jut)+rmass(id1)*u156_34(i3,i4).b(1,
     & jut)
      cx2=u156_34(i3,i4).a(2,jut)+rmass(id1)*u156_34(i3,i4).b(2,
     & jut)
      cy1=p156q*u156_34(i3,i4).b(1,jut)+rmass(id1)*u156_34(i3,i4
     & ).a(1,jut)
      cy2=p156q*u156_34(i3,i4).b(2,jut)+rmass(id1)*u156_34(i3,i4
     & ).a(2,jut)
      cw1=u156_34(i3,i4).c(1,jut)+rmass(id1)*u156_34(i3,i4).d(1,
     & jut)
      cw2=u156_34(i3,i4).c(2,jut)+rmass(id1)*u156_34(i3,i4).d(2,
     & jut)
      cz1=p156q*u156_34(i3,i4).d(1,jut)+rmass(id1)*u156_34(i3,i4
     & ).c(1,jut)
      cz2=p156q*u156_34(i3,i4).d(2,jut)+rmass(id1)*u156_34(i3,i4
     & ).c(2,jut)
      u1_3456(i3,i4,i5,i6).a(1,jut)=u1_3456(i3,i4,i5,i6).a(1,jut
     & )+l1_56(i5,i6).a(1,1)*cx1+l1_56(i5,i6).c(1,2)*cy2
      u1_3456(i3,i4,i5,i6).b(1,jut)=u1_3456(i3,i4,i5,i6).b(1,jut
     & )+l1_56(i5,i6).d(1,1)*cy1+l1_56(i5,i6).b(1,2)*cx2
      u1_3456(i3,i4,i5,i6).c(1,jut)=u1_3456(i3,i4,i5,i6).c(1,jut
     & )+l1_56(i5,i6).a(1,1)*cw1+l1_56(i5,i6).c(1,2)*cz2
      u1_3456(i3,i4,i5,i6).d(1,jut)=u1_3456(i3,i4,i5,i6).d(1,jut
     & )+l1_56(i5,i6).d(1,1)*cz1+l1_56(i5,i6).b(1,2)*cw2
      u1_3456(i3,i4,i5,i6).a(2,jut)=u1_3456(i3,i4,i5,i6).a(2,jut
     & )+l1_56(i5,i6).c(2,1)*cy1+l1_56(i5,i6).a(2,2)*cx2
      u1_3456(i3,i4,i5,i6).b(2,jut)=u1_3456(i3,i4,i5,i6).b(2,jut
     & )+l1_56(i5,i6).b(2,1)*cx1+l1_56(i5,i6).d(2,2)*cy2
      u1_3456(i3,i4,i5,i6).c(2,jut)=u1_3456(i3,i4,i5,i6).c(2,jut
     & )+l1_56(i5,i6).c(2,1)*cz1+l1_56(i5,i6).a(2,2)*cw2
      u1_3456(i3,i4,i5,i6).d(2,jut)=u1_3456(i3,i4,i5,i6).d(2,jut
     & )+l1_56(i5,i6).b(2,1)*cw1+l1_56(i5,i6).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p134q,p=p134,q=p134,bef=,aft=
      p134q=(p134(0)*p134(0)-p134(1)*p134(1)-p134(2)*p134(2)-p13
     & 4(3)*p134(3))
  
      if(id1.ne.5.or.(id3.ne.5.and.id7.ne.5))then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=u1_3478(i3,i4,i7,i8).a,bb=u1_3478(i3,i4,i7,i8).b,cc=u1_3478(i
* 3,i4,i7,i8).c,dd=u1_3478(i3,i4,i7,i8).d,a1=l1_34(i3,i4).a,b1=l1_34(i3,
* i4).b,c1=l1_34(i3,i4).c,d1=l1_34(i3,i4).d,a2=u134_78(i7,i8).a,b2=u134_
* 78(i7,i8).b,c2=u134_78(i7,i8).c,d2=u134_78(i7,i8).d,prq=p134q,m=rmass(
* id1),nsum=1
      u1_3478(i3,i4,i7,i8).a(1,1)=u1_3478(i3,i4,i7,i8).a(1,1)+l1
     & _34(i3,i4).a(1,1)*u134_78(i7,i8).a(1,1)+l1_34(i3,i4).c(1,
     & 2)*p134q*u134_78(i7,i8).b(2,1)
      u1_3478(i3,i4,i7,i8).b(1,1)=u1_3478(i3,i4,i7,i8).b(1,1)+rm
     & ass(id1)*(l1_34(i3,i4).d(1,1)*u134_78(i7,i8).a(1,1)+l1_34
     & (i3,i4).b(1,2)*u134_78(i7,i8).b(2,1))
      u1_3478(i3,i4,i7,i8).c(1,1)=u1_3478(i3,i4,i7,i8).c(1,1)+rm
     & ass(id1)*(l1_34(i3,i4).a(1,1)*u134_78(i7,i8).d(1,1)+l1_34
     & (i3,i4).c(1,2)*u134_78(i7,i8).c(2,1))
      u1_3478(i3,i4,i7,i8).d(1,1)=u1_3478(i3,i4,i7,i8).d(1,1)+l1
     & _34(i3,i4).d(1,1)*p134q*u134_78(i7,i8).d(1,1)+l1_34(i3,i4
     & ).b(1,2)*u134_78(i7,i8).c(2,1)
      u1_3478(i3,i4,i7,i8).a(1,2)=u1_3478(i3,i4,i7,i8).a(1,2)+rm
     & ass(id1)*(l1_34(i3,i4).a(1,1)*u134_78(i7,i8).b(1,2)+l1_34
     & (i3,i4).c(1,2)*u134_78(i7,i8).a(2,2))
      u1_3478(i3,i4,i7,i8).b(1,2)=u1_3478(i3,i4,i7,i8).b(1,2)+l1
     & _34(i3,i4).d(1,1)*p134q*u134_78(i7,i8).b(1,2)+l1_34(i3,i4
     & ).b(1,2)*u134_78(i7,i8).a(2,2)
      u1_3478(i3,i4,i7,i8).c(1,2)=u1_3478(i3,i4,i7,i8).c(1,2)+l1
     & _34(i3,i4).a(1,1)*u134_78(i7,i8).c(1,2)+l1_34(i3,i4).c(1,
     & 2)*p134q*u134_78(i7,i8).d(2,2)
      u1_3478(i3,i4,i7,i8).d(1,2)=u1_3478(i3,i4,i7,i8).d(1,2)+rm
     & ass(id1)*(l1_34(i3,i4).d(1,1)*u134_78(i7,i8).c(1,2)+l1_34
     & (i3,i4).b(1,2)*u134_78(i7,i8).d(2,2))
      u1_3478(i3,i4,i7,i8).a(2,1)=u1_3478(i3,i4,i7,i8).a(2,1)+rm
     & ass(id1)*(l1_34(i3,i4).c(2,1)*u134_78(i7,i8).a(1,1)+l1_34
     & (i3,i4).a(2,2)*u134_78(i7,i8).b(2,1))
      u1_3478(i3,i4,i7,i8).b(2,1)=u1_3478(i3,i4,i7,i8).b(2,1)+l1
     & _34(i3,i4).b(2,1)*u134_78(i7,i8).a(1,1)+l1_34(i3,i4).d(2,
     & 2)*p134q*u134_78(i7,i8).b(2,1)
      u1_3478(i3,i4,i7,i8).c(2,1)=u1_3478(i3,i4,i7,i8).c(2,1)+l1
     & _34(i3,i4).c(2,1)*p134q*u134_78(i7,i8).d(1,1)+l1_34(i3,i4
     & ).a(2,2)*u134_78(i7,i8).c(2,1)
      u1_3478(i3,i4,i7,i8).d(2,1)=u1_3478(i3,i4,i7,i8).d(2,1)+rm
     & ass(id1)*(l1_34(i3,i4).b(2,1)*u134_78(i7,i8).d(1,1)+l1_34
     & (i3,i4).d(2,2)*u134_78(i7,i8).c(2,1))
      u1_3478(i3,i4,i7,i8).a(2,2)=u1_3478(i3,i4,i7,i8).a(2,2)+l1
     & _34(i3,i4).c(2,1)*p134q*u134_78(i7,i8).b(1,2)+l1_34(i3,i4
     & ).a(2,2)*u134_78(i7,i8).a(2,2)
      u1_3478(i3,i4,i7,i8).b(2,2)=u1_3478(i3,i4,i7,i8).b(2,2)+rm
     & ass(id1)*(l1_34(i3,i4).b(2,1)*u134_78(i7,i8).b(1,2)+l1_34
     & (i3,i4).d(2,2)*u134_78(i7,i8).a(2,2))
      u1_3478(i3,i4,i7,i8).c(2,2)=u1_3478(i3,i4,i7,i8).c(2,2)+rm
     & ass(id1)*(l1_34(i3,i4).c(2,1)*u134_78(i7,i8).c(1,2)+l1_34
     & (i3,i4).a(2,2)*u134_78(i7,i8).d(2,2))
      u1_3478(i3,i4,i7,i8).d(2,2)=u1_3478(i3,i4,i7,i8).d(2,2)+l1
     & _34(i3,i4).b(2,1)*u134_78(i7,i8).c(1,2)+l1_34(i3,i4).d(2,
     & 2)*p134q*u134_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id1.eq.5.and.id3.eq.5.and.id7.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=u1_3478(i3,i4,i7,i8).a,bb=u1_3478(i3,i4,i7,i8).b,cc=u1_3478
* (i3,i4,i7,i8).c,dd=u1_3478(i3,i4,i7,i8).d,a1=l1_34(i3,i4).a,b1=l1_34(i
* 3,i4).b,c1=l1_34(i3,i4).c,d1=l1_34(i3,i4).d,a2=u134_78(i7,i8).a,b2=u13
* 4_78(i7,i8).b,c2=u134_78(i7,i8).c,d2=u134_78(i7,i8).d,prq=p134q,m=rmas
* s(id1),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u134_78(i7,i8).a(1,jut)+rmass(id1)*u134_78(i7,i8).b(1,
     & jut)
      cx2=u134_78(i7,i8).a(2,jut)+rmass(id1)*u134_78(i7,i8).b(2,
     & jut)
      cy1=p134q*u134_78(i7,i8).b(1,jut)+rmass(id1)*u134_78(i7,i8
     & ).a(1,jut)
      cy2=p134q*u134_78(i7,i8).b(2,jut)+rmass(id1)*u134_78(i7,i8
     & ).a(2,jut)
      u1_3478(i3,i4,i7,i8).a(iut,jut)=u1_3478(i3,i4,i7,i8).a(iut
     & ,jut)+l1_34(i3,i4).a(iut,1)*cx1+l1_34(i3,i4).c(iut,1)*cy1
     & +l1_34(i3,i4).a(iut,2)*cx2+l1_34(i3,i4).c(iut,2)*cy2
      u1_3478(i3,i4,i7,i8).b(iut,jut)=u1_3478(i3,i4,i7,i8).b(iut
     & ,jut)+l1_34(i3,i4).b(iut,1)*cx1+l1_34(i3,i4).d(iut,1)*cy1
     & +l1_34(i3,i4).b(iut,2)*cx2+l1_34(i3,i4).d(iut,2)*cy2
      cw1=u134_78(i7,i8).c(1,jut)+rmass(id1)*u134_78(i7,i8).d(1,
     & jut)
      cw2=u134_78(i7,i8).c(2,jut)+rmass(id1)*u134_78(i7,i8).d(2,
     & jut)
      cz1=p134q*u134_78(i7,i8).d(1,jut)+rmass(id1)*u134_78(i7,i8
     & ).c(1,jut)
      cz2=p134q*u134_78(i7,i8).d(2,jut)+rmass(id1)*u134_78(i7,i8
     & ).c(2,jut)
      u1_3478(i3,i4,i7,i8).c(iut,jut)=u1_3478(i3,i4,i7,i8).c(iut
     & ,jut)+l1_34(i3,i4).a(iut,1)*cw1+l1_34(i3,i4).c(iut,1)*cz1
     & +l1_34(i3,i4).a(iut,2)*cw2+l1_34(i3,i4).c(iut,2)*cz2
      u1_3478(i3,i4,i7,i8).d(iut,jut)=u1_3478(i3,i4,i7,i8).d(iut
     & ,jut)+l1_34(i3,i4).b(iut,1)*cw1+l1_34(i3,i4).d(iut,1)*cz1
     & +l1_34(i3,i4).b(iut,2)*cw2+l1_34(i3,i4).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id1.eq.5.and.id3.eq.5.and.id7.ne.5)then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=u1_3478(i3,i4,i7,i8).a,bb=u1_3478(i3,i4,i7,i8).b,cc=u1_3478(
* i3,i4,i7,i8).c,dd=u1_3478(i3,i4,i7,i8).d,a1=l1_34(i3,i4).a,b1=l1_34(i3
* ,i4).b,c1=l1_34(i3,i4).c,d1=l1_34(i3,i4).d,a2=u134_78(i7,i8).a,b2=u134
* _78(i7,i8).b,c2=u134_78(i7,i8).c,d2=u134_78(i7,i8).d,prq=p134q,m=rmass
* (id1),nsum=1
      do iut=1,2
      cx1=l1_34(i3,i4).a(iut,1)+l1_34(i3,i4).c(iut,1)*rmass(id1)
      cx2=l1_34(i3,i4).c(iut,2)*p134q+l1_34(i3,i4).a(iut,2)*rmas
     & s(id1)
      cy1=l1_34(i3,i4).b(iut,1)+l1_34(i3,i4).d(iut,1)*rmass(id1)
      cy2=l1_34(i3,i4).d(iut,2)*p134q+l1_34(i3,i4).b(iut,2)*rmas
     & s(id1)
      cw1=l1_34(i3,i4).c(iut,1)*p134q+l1_34(i3,i4).a(iut,1)*rmas
     & s(id1)
      cw2=l1_34(i3,i4).a(iut,2)+l1_34(i3,i4).c(iut,2)*rmass(id1)
      cz1=l1_34(i3,i4).d(iut,1)*p134q+l1_34(i3,i4).b(iut,1)*rmas
     & s(id1)
      cz2=l1_34(i3,i4).b(iut,2)+l1_34(i3,i4).d(iut,2)*rmass(id1)
      u1_3478(i3,i4,i7,i8).a(iut,1)=u1_3478(i3,i4,i7,i8).a(iut,1
     & )+cx1*u134_78(i7,i8).a(1,1)+cx2*u134_78(i7,i8).b(2,1)
      u1_3478(i3,i4,i7,i8).b(iut,1)=u1_3478(i3,i4,i7,i8).b(iut,1
     & )+cy1*u134_78(i7,i8).a(1,1)+cy2*u134_78(i7,i8).b(2,1)
      u1_3478(i3,i4,i7,i8).c(iut,1)=u1_3478(i3,i4,i7,i8).c(iut,1
     & )+cw1*u134_78(i7,i8).d(1,1)+cw2*u134_78(i7,i8).c(2,1)
      u1_3478(i3,i4,i7,i8).d(iut,1)=u1_3478(i3,i4,i7,i8).d(iut,1
     & )+cz1*u134_78(i7,i8).d(1,1)+cz2*u134_78(i7,i8).c(2,1)
      u1_3478(i3,i4,i7,i8).a(iut,2)=u1_3478(i3,i4,i7,i8).a(iut,2
     & )+cw1*u134_78(i7,i8).b(1,2)+cw2*u134_78(i7,i8).a(2,2)
      u1_3478(i3,i4,i7,i8).b(iut,2)=u1_3478(i3,i4,i7,i8).b(iut,2
     & )+cz1*u134_78(i7,i8).b(1,2)+cz2*u134_78(i7,i8).a(2,2)
      u1_3478(i3,i4,i7,i8).c(iut,2)=u1_3478(i3,i4,i7,i8).c(iut,2
     & )+cx1*u134_78(i7,i8).c(1,2)+cx2*u134_78(i7,i8).d(2,2)
      u1_3478(i3,i4,i7,i8).d(iut,2)=u1_3478(i3,i4,i7,i8).d(iut,2
     & )+cy1*u134_78(i7,i8).c(1,2)+cy2*u134_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id1.eq.5.and.id3.ne.5.and.id7.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TTs -- aa=u1_3478(i3,i4,i7,i8).a,bb=u1_3478(i3,i4,i7,i8).b,cc=u1_3478(
* i3,i4,i7,i8).c,dd=u1_3478(i3,i4,i7,i8).d,a1=l1_34(i3,i4).a,b1=l1_34(i3
* ,i4).b,c1=l1_34(i3,i4).c,d1=l1_34(i3,i4).d,a2=u134_78(i7,i8).a,b2=u134
* _78(i7,i8).b,c2=u134_78(i7,i8).c,d2=u134_78(i7,i8).d,prq=p134q,m=rmass
* (id1),nsum=1
      do jut=1,2
      cx1=u134_78(i7,i8).a(1,jut)+rmass(id1)*u134_78(i7,i8).b(1,
     & jut)
      cx2=u134_78(i7,i8).a(2,jut)+rmass(id1)*u134_78(i7,i8).b(2,
     & jut)
      cy1=p134q*u134_78(i7,i8).b(1,jut)+rmass(id1)*u134_78(i7,i8
     & ).a(1,jut)
      cy2=p134q*u134_78(i7,i8).b(2,jut)+rmass(id1)*u134_78(i7,i8
     & ).a(2,jut)
      cw1=u134_78(i7,i8).c(1,jut)+rmass(id1)*u134_78(i7,i8).d(1,
     & jut)
      cw2=u134_78(i7,i8).c(2,jut)+rmass(id1)*u134_78(i7,i8).d(2,
     & jut)
      cz1=p134q*u134_78(i7,i8).d(1,jut)+rmass(id1)*u134_78(i7,i8
     & ).c(1,jut)
      cz2=p134q*u134_78(i7,i8).d(2,jut)+rmass(id1)*u134_78(i7,i8
     & ).c(2,jut)
      u1_3478(i3,i4,i7,i8).a(1,jut)=u1_3478(i3,i4,i7,i8).a(1,jut
     & )+l1_34(i3,i4).a(1,1)*cx1+l1_34(i3,i4).c(1,2)*cy2
      u1_3478(i3,i4,i7,i8).b(1,jut)=u1_3478(i3,i4,i7,i8).b(1,jut
     & )+l1_34(i3,i4).d(1,1)*cy1+l1_34(i3,i4).b(1,2)*cx2
      u1_3478(i3,i4,i7,i8).c(1,jut)=u1_3478(i3,i4,i7,i8).c(1,jut
     & )+l1_34(i3,i4).a(1,1)*cw1+l1_34(i3,i4).c(1,2)*cz2
      u1_3478(i3,i4,i7,i8).d(1,jut)=u1_3478(i3,i4,i7,i8).d(1,jut
     & )+l1_34(i3,i4).d(1,1)*cz1+l1_34(i3,i4).b(1,2)*cw2
      u1_3478(i3,i4,i7,i8).a(2,jut)=u1_3478(i3,i4,i7,i8).a(2,jut
     & )+l1_34(i3,i4).c(2,1)*cy1+l1_34(i3,i4).a(2,2)*cx2
      u1_3478(i3,i4,i7,i8).b(2,jut)=u1_3478(i3,i4,i7,i8).b(2,jut
     & )+l1_34(i3,i4).b(2,1)*cx1+l1_34(i3,i4).d(2,2)*cy2
      u1_3478(i3,i4,i7,i8).c(2,jut)=u1_3478(i3,i4,i7,i8).c(2,jut
     & )+l1_34(i3,i4).c(2,1)*cz1+l1_34(i3,i4).a(2,2)*cw2
      u1_3478(i3,i4,i7,i8).d(2,jut)=u1_3478(i3,i4,i7,i8).d(2,jut
     & )+l1_34(i3,i4).b(2,1)*cw1+l1_34(i3,i4).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p178q,p=p178,q=p178,bef=,aft=
      p178q=(p178(0)*p178(0)-p178(1)*p178(1)-p178(2)*p178(2)-p17
     & 8(3)*p178(3))
  
      if(id1.ne.5.or.(id7.ne.5.and.id3.ne.5))then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=u1_3478(i3,i4,i7,i8).a,bb=u1_3478(i3,i4,i7,i8).b,cc=u1_3478(i
* 3,i4,i7,i8).c,dd=u1_3478(i3,i4,i7,i8).d,a1=l1_78(i7,i8).a,b1=l1_78(i7,
* i8).b,c1=l1_78(i7,i8).c,d1=l1_78(i7,i8).d,a2=u178_34(i3,i4).a,b2=u178_
* 34(i3,i4).b,c2=u178_34(i3,i4).c,d2=u178_34(i3,i4).d,prq=p178q,m=rmass(
* id1),nsum=1
      u1_3478(i3,i4,i7,i8).a(1,1)=u1_3478(i3,i4,i7,i8).a(1,1)+l1
     & _78(i7,i8).a(1,1)*u178_34(i3,i4).a(1,1)+l1_78(i7,i8).c(1,
     & 2)*p178q*u178_34(i3,i4).b(2,1)
      u1_3478(i3,i4,i7,i8).b(1,1)=u1_3478(i3,i4,i7,i8).b(1,1)+rm
     & ass(id1)*(l1_78(i7,i8).d(1,1)*u178_34(i3,i4).a(1,1)+l1_78
     & (i7,i8).b(1,2)*u178_34(i3,i4).b(2,1))
      u1_3478(i3,i4,i7,i8).c(1,1)=u1_3478(i3,i4,i7,i8).c(1,1)+rm
     & ass(id1)*(l1_78(i7,i8).a(1,1)*u178_34(i3,i4).d(1,1)+l1_78
     & (i7,i8).c(1,2)*u178_34(i3,i4).c(2,1))
      u1_3478(i3,i4,i7,i8).d(1,1)=u1_3478(i3,i4,i7,i8).d(1,1)+l1
     & _78(i7,i8).d(1,1)*p178q*u178_34(i3,i4).d(1,1)+l1_78(i7,i8
     & ).b(1,2)*u178_34(i3,i4).c(2,1)
      u1_3478(i3,i4,i7,i8).a(1,2)=u1_3478(i3,i4,i7,i8).a(1,2)+rm
     & ass(id1)*(l1_78(i7,i8).a(1,1)*u178_34(i3,i4).b(1,2)+l1_78
     & (i7,i8).c(1,2)*u178_34(i3,i4).a(2,2))
      u1_3478(i3,i4,i7,i8).b(1,2)=u1_3478(i3,i4,i7,i8).b(1,2)+l1
     & _78(i7,i8).d(1,1)*p178q*u178_34(i3,i4).b(1,2)+l1_78(i7,i8
     & ).b(1,2)*u178_34(i3,i4).a(2,2)
      u1_3478(i3,i4,i7,i8).c(1,2)=u1_3478(i3,i4,i7,i8).c(1,2)+l1
     & _78(i7,i8).a(1,1)*u178_34(i3,i4).c(1,2)+l1_78(i7,i8).c(1,
     & 2)*p178q*u178_34(i3,i4).d(2,2)
      u1_3478(i3,i4,i7,i8).d(1,2)=u1_3478(i3,i4,i7,i8).d(1,2)+rm
     & ass(id1)*(l1_78(i7,i8).d(1,1)*u178_34(i3,i4).c(1,2)+l1_78
     & (i7,i8).b(1,2)*u178_34(i3,i4).d(2,2))
      u1_3478(i3,i4,i7,i8).a(2,1)=u1_3478(i3,i4,i7,i8).a(2,1)+rm
     & ass(id1)*(l1_78(i7,i8).c(2,1)*u178_34(i3,i4).a(1,1)+l1_78
     & (i7,i8).a(2,2)*u178_34(i3,i4).b(2,1))
      u1_3478(i3,i4,i7,i8).b(2,1)=u1_3478(i3,i4,i7,i8).b(2,1)+l1
     & _78(i7,i8).b(2,1)*u178_34(i3,i4).a(1,1)+l1_78(i7,i8).d(2,
     & 2)*p178q*u178_34(i3,i4).b(2,1)
      u1_3478(i3,i4,i7,i8).c(2,1)=u1_3478(i3,i4,i7,i8).c(2,1)+l1
     & _78(i7,i8).c(2,1)*p178q*u178_34(i3,i4).d(1,1)+l1_78(i7,i8
     & ).a(2,2)*u178_34(i3,i4).c(2,1)
      u1_3478(i3,i4,i7,i8).d(2,1)=u1_3478(i3,i4,i7,i8).d(2,1)+rm
     & ass(id1)*(l1_78(i7,i8).b(2,1)*u178_34(i3,i4).d(1,1)+l1_78
     & (i7,i8).d(2,2)*u178_34(i3,i4).c(2,1))
      u1_3478(i3,i4,i7,i8).a(2,2)=u1_3478(i3,i4,i7,i8).a(2,2)+l1
     & _78(i7,i8).c(2,1)*p178q*u178_34(i3,i4).b(1,2)+l1_78(i7,i8
     & ).a(2,2)*u178_34(i3,i4).a(2,2)
      u1_3478(i3,i4,i7,i8).b(2,2)=u1_3478(i3,i4,i7,i8).b(2,2)+rm
     & ass(id1)*(l1_78(i7,i8).b(2,1)*u178_34(i3,i4).b(1,2)+l1_78
     & (i7,i8).d(2,2)*u178_34(i3,i4).a(2,2))
      u1_3478(i3,i4,i7,i8).c(2,2)=u1_3478(i3,i4,i7,i8).c(2,2)+rm
     & ass(id1)*(l1_78(i7,i8).c(2,1)*u178_34(i3,i4).c(1,2)+l1_78
     & (i7,i8).a(2,2)*u178_34(i3,i4).d(2,2))
      u1_3478(i3,i4,i7,i8).d(2,2)=u1_3478(i3,i4,i7,i8).d(2,2)+l1
     & _78(i7,i8).b(2,1)*u178_34(i3,i4).c(1,2)+l1_78(i7,i8).d(2,
     & 2)*p178q*u178_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id1.eq.5.and.id7.eq.5.and.id3.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=u1_3478(i3,i4,i7,i8).a,bb=u1_3478(i3,i4,i7,i8).b,cc=u1_3478
* (i3,i4,i7,i8).c,dd=u1_3478(i3,i4,i7,i8).d,a1=l1_78(i7,i8).a,b1=l1_78(i
* 7,i8).b,c1=l1_78(i7,i8).c,d1=l1_78(i7,i8).d,a2=u178_34(i3,i4).a,b2=u17
* 8_34(i3,i4).b,c2=u178_34(i3,i4).c,d2=u178_34(i3,i4).d,prq=p178q,m=rmas
* s(id1),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u178_34(i3,i4).a(1,jut)+rmass(id1)*u178_34(i3,i4).b(1,
     & jut)
      cx2=u178_34(i3,i4).a(2,jut)+rmass(id1)*u178_34(i3,i4).b(2,
     & jut)
      cy1=p178q*u178_34(i3,i4).b(1,jut)+rmass(id1)*u178_34(i3,i4
     & ).a(1,jut)
      cy2=p178q*u178_34(i3,i4).b(2,jut)+rmass(id1)*u178_34(i3,i4
     & ).a(2,jut)
      u1_3478(i3,i4,i7,i8).a(iut,jut)=u1_3478(i3,i4,i7,i8).a(iut
     & ,jut)+l1_78(i7,i8).a(iut,1)*cx1+l1_78(i7,i8).c(iut,1)*cy1
     & +l1_78(i7,i8).a(iut,2)*cx2+l1_78(i7,i8).c(iut,2)*cy2
      u1_3478(i3,i4,i7,i8).b(iut,jut)=u1_3478(i3,i4,i7,i8).b(iut
     & ,jut)+l1_78(i7,i8).b(iut,1)*cx1+l1_78(i7,i8).d(iut,1)*cy1
     & +l1_78(i7,i8).b(iut,2)*cx2+l1_78(i7,i8).d(iut,2)*cy2
      cw1=u178_34(i3,i4).c(1,jut)+rmass(id1)*u178_34(i3,i4).d(1,
     & jut)
      cw2=u178_34(i3,i4).c(2,jut)+rmass(id1)*u178_34(i3,i4).d(2,
     & jut)
      cz1=p178q*u178_34(i3,i4).d(1,jut)+rmass(id1)*u178_34(i3,i4
     & ).c(1,jut)
      cz2=p178q*u178_34(i3,i4).d(2,jut)+rmass(id1)*u178_34(i3,i4
     & ).c(2,jut)
      u1_3478(i3,i4,i7,i8).c(iut,jut)=u1_3478(i3,i4,i7,i8).c(iut
     & ,jut)+l1_78(i7,i8).a(iut,1)*cw1+l1_78(i7,i8).c(iut,1)*cz1
     & +l1_78(i7,i8).a(iut,2)*cw2+l1_78(i7,i8).c(iut,2)*cz2
      u1_3478(i3,i4,i7,i8).d(iut,jut)=u1_3478(i3,i4,i7,i8).d(iut
     & ,jut)+l1_78(i7,i8).b(iut,1)*cw1+l1_78(i7,i8).d(iut,1)*cz1
     & +l1_78(i7,i8).b(iut,2)*cw2+l1_78(i7,i8).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id1.eq.5.and.id7.eq.5.and.id3.ne.5)then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=u1_3478(i3,i4,i7,i8).a,bb=u1_3478(i3,i4,i7,i8).b,cc=u1_3478(
* i3,i4,i7,i8).c,dd=u1_3478(i3,i4,i7,i8).d,a1=l1_78(i7,i8).a,b1=l1_78(i7
* ,i8).b,c1=l1_78(i7,i8).c,d1=l1_78(i7,i8).d,a2=u178_34(i3,i4).a,b2=u178
* _34(i3,i4).b,c2=u178_34(i3,i4).c,d2=u178_34(i3,i4).d,prq=p178q,m=rmass
* (id1),nsum=1
      do iut=1,2
      cx1=l1_78(i7,i8).a(iut,1)+l1_78(i7,i8).c(iut,1)*rmass(id1)
      cx2=l1_78(i7,i8).c(iut,2)*p178q+l1_78(i7,i8).a(iut,2)*rmas
     & s(id1)
      cy1=l1_78(i7,i8).b(iut,1)+l1_78(i7,i8).d(iut,1)*rmass(id1)
      cy2=l1_78(i7,i8).d(iut,2)*p178q+l1_78(i7,i8).b(iut,2)*rmas
     & s(id1)
      cw1=l1_78(i7,i8).c(iut,1)*p178q+l1_78(i7,i8).a(iut,1)*rmas
     & s(id1)
      cw2=l1_78(i7,i8).a(iut,2)+l1_78(i7,i8).c(iut,2)*rmass(id1)
      cz1=l1_78(i7,i8).d(iut,1)*p178q+l1_78(i7,i8).b(iut,1)*rmas
     & s(id1)
      cz2=l1_78(i7,i8).b(iut,2)+l1_78(i7,i8).d(iut,2)*rmass(id1)
      u1_3478(i3,i4,i7,i8).a(iut,1)=u1_3478(i3,i4,i7,i8).a(iut,1
     & )+cx1*u178_34(i3,i4).a(1,1)+cx2*u178_34(i3,i4).b(2,1)
      u1_3478(i3,i4,i7,i8).b(iut,1)=u1_3478(i3,i4,i7,i8).b(iut,1
     & )+cy1*u178_34(i3,i4).a(1,1)+cy2*u178_34(i3,i4).b(2,1)
      u1_3478(i3,i4,i7,i8).c(iut,1)=u1_3478(i3,i4,i7,i8).c(iut,1
     & )+cw1*u178_34(i3,i4).d(1,1)+cw2*u178_34(i3,i4).c(2,1)
      u1_3478(i3,i4,i7,i8).d(iut,1)=u1_3478(i3,i4,i7,i8).d(iut,1
     & )+cz1*u178_34(i3,i4).d(1,1)+cz2*u178_34(i3,i4).c(2,1)
      u1_3478(i3,i4,i7,i8).a(iut,2)=u1_3478(i3,i4,i7,i8).a(iut,2
     & )+cw1*u178_34(i3,i4).b(1,2)+cw2*u178_34(i3,i4).a(2,2)
      u1_3478(i3,i4,i7,i8).b(iut,2)=u1_3478(i3,i4,i7,i8).b(iut,2
     & )+cz1*u178_34(i3,i4).b(1,2)+cz2*u178_34(i3,i4).a(2,2)
      u1_3478(i3,i4,i7,i8).c(iut,2)=u1_3478(i3,i4,i7,i8).c(iut,2
     & )+cx1*u178_34(i3,i4).c(1,2)+cx2*u178_34(i3,i4).d(2,2)
      u1_3478(i3,i4,i7,i8).d(iut,2)=u1_3478(i3,i4,i7,i8).d(iut,2
     & )+cy1*u178_34(i3,i4).c(1,2)+cy2*u178_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id1.eq.5.and.id7.ne.5.and.id3.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TTs -- aa=u1_3478(i3,i4,i7,i8).a,bb=u1_3478(i3,i4,i7,i8).b,cc=u1_3478(
* i3,i4,i7,i8).c,dd=u1_3478(i3,i4,i7,i8).d,a1=l1_78(i7,i8).a,b1=l1_78(i7
* ,i8).b,c1=l1_78(i7,i8).c,d1=l1_78(i7,i8).d,a2=u178_34(i3,i4).a,b2=u178
* _34(i3,i4).b,c2=u178_34(i3,i4).c,d2=u178_34(i3,i4).d,prq=p178q,m=rmass
* (id1),nsum=1
      do jut=1,2
      cx1=u178_34(i3,i4).a(1,jut)+rmass(id1)*u178_34(i3,i4).b(1,
     & jut)
      cx2=u178_34(i3,i4).a(2,jut)+rmass(id1)*u178_34(i3,i4).b(2,
     & jut)
      cy1=p178q*u178_34(i3,i4).b(1,jut)+rmass(id1)*u178_34(i3,i4
     & ).a(1,jut)
      cy2=p178q*u178_34(i3,i4).b(2,jut)+rmass(id1)*u178_34(i3,i4
     & ).a(2,jut)
      cw1=u178_34(i3,i4).c(1,jut)+rmass(id1)*u178_34(i3,i4).d(1,
     & jut)
      cw2=u178_34(i3,i4).c(2,jut)+rmass(id1)*u178_34(i3,i4).d(2,
     & jut)
      cz1=p178q*u178_34(i3,i4).d(1,jut)+rmass(id1)*u178_34(i3,i4
     & ).c(1,jut)
      cz2=p178q*u178_34(i3,i4).d(2,jut)+rmass(id1)*u178_34(i3,i4
     & ).c(2,jut)
      u1_3478(i3,i4,i7,i8).a(1,jut)=u1_3478(i3,i4,i7,i8).a(1,jut
     & )+l1_78(i7,i8).a(1,1)*cx1+l1_78(i7,i8).c(1,2)*cy2
      u1_3478(i3,i4,i7,i8).b(1,jut)=u1_3478(i3,i4,i7,i8).b(1,jut
     & )+l1_78(i7,i8).d(1,1)*cy1+l1_78(i7,i8).b(1,2)*cx2
      u1_3478(i3,i4,i7,i8).c(1,jut)=u1_3478(i3,i4,i7,i8).c(1,jut
     & )+l1_78(i7,i8).a(1,1)*cw1+l1_78(i7,i8).c(1,2)*cz2
      u1_3478(i3,i4,i7,i8).d(1,jut)=u1_3478(i3,i4,i7,i8).d(1,jut
     & )+l1_78(i7,i8).d(1,1)*cz1+l1_78(i7,i8).b(1,2)*cw2
      u1_3478(i3,i4,i7,i8).a(2,jut)=u1_3478(i3,i4,i7,i8).a(2,jut
     & )+l1_78(i7,i8).c(2,1)*cy1+l1_78(i7,i8).a(2,2)*cx2
      u1_3478(i3,i4,i7,i8).b(2,jut)=u1_3478(i3,i4,i7,i8).b(2,jut
     & )+l1_78(i7,i8).b(2,1)*cx1+l1_78(i7,i8).d(2,2)*cy2
      u1_3478(i3,i4,i7,i8).c(2,jut)=u1_3478(i3,i4,i7,i8).c(2,jut
     & )+l1_78(i7,i8).c(2,1)*cz1+l1_78(i7,i8).a(2,2)*cw2
      u1_3478(i3,i4,i7,i8).d(2,jut)=u1_3478(i3,i4,i7,i8).d(2,jut
     & )+l1_78(i7,i8).b(2,1)*cw1+l1_78(i7,i8).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p156q,p=p156,q=p156,bef=,aft=
      p156q=(p156(0)*p156(0)-p156(1)*p156(1)-p156(2)*p156(2)-p15
     & 6(3)*p156(3))
  
      if(id1.ne.5.or.(id5.ne.5.and.id7.ne.5))then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=u1_5678(i5,i6,i7,i8).a,bb=u1_5678(i5,i6,i7,i8).b,cc=u1_5678(i
* 5,i6,i7,i8).c,dd=u1_5678(i5,i6,i7,i8).d,a1=l1_56(i5,i6).a,b1=l1_56(i5,
* i6).b,c1=l1_56(i5,i6).c,d1=l1_56(i5,i6).d,a2=u156_78(i7,i8).a,b2=u156_
* 78(i7,i8).b,c2=u156_78(i7,i8).c,d2=u156_78(i7,i8).d,prq=p156q,m=rmass(
* id1),nsum=1
      u1_5678(i5,i6,i7,i8).a(1,1)=u1_5678(i5,i6,i7,i8).a(1,1)+l1
     & _56(i5,i6).a(1,1)*u156_78(i7,i8).a(1,1)+l1_56(i5,i6).c(1,
     & 2)*p156q*u156_78(i7,i8).b(2,1)
      u1_5678(i5,i6,i7,i8).b(1,1)=u1_5678(i5,i6,i7,i8).b(1,1)+rm
     & ass(id1)*(l1_56(i5,i6).d(1,1)*u156_78(i7,i8).a(1,1)+l1_56
     & (i5,i6).b(1,2)*u156_78(i7,i8).b(2,1))
      u1_5678(i5,i6,i7,i8).c(1,1)=u1_5678(i5,i6,i7,i8).c(1,1)+rm
     & ass(id1)*(l1_56(i5,i6).a(1,1)*u156_78(i7,i8).d(1,1)+l1_56
     & (i5,i6).c(1,2)*u156_78(i7,i8).c(2,1))
      u1_5678(i5,i6,i7,i8).d(1,1)=u1_5678(i5,i6,i7,i8).d(1,1)+l1
     & _56(i5,i6).d(1,1)*p156q*u156_78(i7,i8).d(1,1)+l1_56(i5,i6
     & ).b(1,2)*u156_78(i7,i8).c(2,1)
      u1_5678(i5,i6,i7,i8).a(1,2)=u1_5678(i5,i6,i7,i8).a(1,2)+rm
     & ass(id1)*(l1_56(i5,i6).a(1,1)*u156_78(i7,i8).b(1,2)+l1_56
     & (i5,i6).c(1,2)*u156_78(i7,i8).a(2,2))
      u1_5678(i5,i6,i7,i8).b(1,2)=u1_5678(i5,i6,i7,i8).b(1,2)+l1
     & _56(i5,i6).d(1,1)*p156q*u156_78(i7,i8).b(1,2)+l1_56(i5,i6
     & ).b(1,2)*u156_78(i7,i8).a(2,2)
      u1_5678(i5,i6,i7,i8).c(1,2)=u1_5678(i5,i6,i7,i8).c(1,2)+l1
     & _56(i5,i6).a(1,1)*u156_78(i7,i8).c(1,2)+l1_56(i5,i6).c(1,
     & 2)*p156q*u156_78(i7,i8).d(2,2)
      u1_5678(i5,i6,i7,i8).d(1,2)=u1_5678(i5,i6,i7,i8).d(1,2)+rm
     & ass(id1)*(l1_56(i5,i6).d(1,1)*u156_78(i7,i8).c(1,2)+l1_56
     & (i5,i6).b(1,2)*u156_78(i7,i8).d(2,2))
      u1_5678(i5,i6,i7,i8).a(2,1)=u1_5678(i5,i6,i7,i8).a(2,1)+rm
     & ass(id1)*(l1_56(i5,i6).c(2,1)*u156_78(i7,i8).a(1,1)+l1_56
     & (i5,i6).a(2,2)*u156_78(i7,i8).b(2,1))
      u1_5678(i5,i6,i7,i8).b(2,1)=u1_5678(i5,i6,i7,i8).b(2,1)+l1
     & _56(i5,i6).b(2,1)*u156_78(i7,i8).a(1,1)+l1_56(i5,i6).d(2,
     & 2)*p156q*u156_78(i7,i8).b(2,1)
      u1_5678(i5,i6,i7,i8).c(2,1)=u1_5678(i5,i6,i7,i8).c(2,1)+l1
     & _56(i5,i6).c(2,1)*p156q*u156_78(i7,i8).d(1,1)+l1_56(i5,i6
     & ).a(2,2)*u156_78(i7,i8).c(2,1)
      u1_5678(i5,i6,i7,i8).d(2,1)=u1_5678(i5,i6,i7,i8).d(2,1)+rm
     & ass(id1)*(l1_56(i5,i6).b(2,1)*u156_78(i7,i8).d(1,1)+l1_56
     & (i5,i6).d(2,2)*u156_78(i7,i8).c(2,1))
      u1_5678(i5,i6,i7,i8).a(2,2)=u1_5678(i5,i6,i7,i8).a(2,2)+l1
     & _56(i5,i6).c(2,1)*p156q*u156_78(i7,i8).b(1,2)+l1_56(i5,i6
     & ).a(2,2)*u156_78(i7,i8).a(2,2)
      u1_5678(i5,i6,i7,i8).b(2,2)=u1_5678(i5,i6,i7,i8).b(2,2)+rm
     & ass(id1)*(l1_56(i5,i6).b(2,1)*u156_78(i7,i8).b(1,2)+l1_56
     & (i5,i6).d(2,2)*u156_78(i7,i8).a(2,2))
      u1_5678(i5,i6,i7,i8).c(2,2)=u1_5678(i5,i6,i7,i8).c(2,2)+rm
     & ass(id1)*(l1_56(i5,i6).c(2,1)*u156_78(i7,i8).c(1,2)+l1_56
     & (i5,i6).a(2,2)*u156_78(i7,i8).d(2,2))
      u1_5678(i5,i6,i7,i8).d(2,2)=u1_5678(i5,i6,i7,i8).d(2,2)+l1
     & _56(i5,i6).b(2,1)*u156_78(i7,i8).c(1,2)+l1_56(i5,i6).d(2,
     & 2)*p156q*u156_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id1.eq.5.and.id5.eq.5.and.id7.eq.5)then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=u1_5678(i5,i6,i7,i8).a,bb=u1_5678(i5,i6,i7,i8).b,cc=u1_5678
* (i5,i6,i7,i8).c,dd=u1_5678(i5,i6,i7,i8).d,a1=l1_56(i5,i6).a,b1=l1_56(i
* 5,i6).b,c1=l1_56(i5,i6).c,d1=l1_56(i5,i6).d,a2=u156_78(i7,i8).a,b2=u15
* 6_78(i7,i8).b,c2=u156_78(i7,i8).c,d2=u156_78(i7,i8).d,prq=p156q,m=rmas
* s(id1),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u156_78(i7,i8).a(1,jut)+rmass(id1)*u156_78(i7,i8).b(1,
     & jut)
      cx2=u156_78(i7,i8).a(2,jut)+rmass(id1)*u156_78(i7,i8).b(2,
     & jut)
      cy1=p156q*u156_78(i7,i8).b(1,jut)+rmass(id1)*u156_78(i7,i8
     & ).a(1,jut)
      cy2=p156q*u156_78(i7,i8).b(2,jut)+rmass(id1)*u156_78(i7,i8
     & ).a(2,jut)
      u1_5678(i5,i6,i7,i8).a(iut,jut)=u1_5678(i5,i6,i7,i8).a(iut
     & ,jut)+l1_56(i5,i6).a(iut,1)*cx1+l1_56(i5,i6).c(iut,1)*cy1
     & +l1_56(i5,i6).a(iut,2)*cx2+l1_56(i5,i6).c(iut,2)*cy2
      u1_5678(i5,i6,i7,i8).b(iut,jut)=u1_5678(i5,i6,i7,i8).b(iut
     & ,jut)+l1_56(i5,i6).b(iut,1)*cx1+l1_56(i5,i6).d(iut,1)*cy1
     & +l1_56(i5,i6).b(iut,2)*cx2+l1_56(i5,i6).d(iut,2)*cy2
      cw1=u156_78(i7,i8).c(1,jut)+rmass(id1)*u156_78(i7,i8).d(1,
     & jut)
      cw2=u156_78(i7,i8).c(2,jut)+rmass(id1)*u156_78(i7,i8).d(2,
     & jut)
      cz1=p156q*u156_78(i7,i8).d(1,jut)+rmass(id1)*u156_78(i7,i8
     & ).c(1,jut)
      cz2=p156q*u156_78(i7,i8).d(2,jut)+rmass(id1)*u156_78(i7,i8
     & ).c(2,jut)
      u1_5678(i5,i6,i7,i8).c(iut,jut)=u1_5678(i5,i6,i7,i8).c(iut
     & ,jut)+l1_56(i5,i6).a(iut,1)*cw1+l1_56(i5,i6).c(iut,1)*cz1
     & +l1_56(i5,i6).a(iut,2)*cw2+l1_56(i5,i6).c(iut,2)*cz2
      u1_5678(i5,i6,i7,i8).d(iut,jut)=u1_5678(i5,i6,i7,i8).d(iut
     & ,jut)+l1_56(i5,i6).b(iut,1)*cw1+l1_56(i5,i6).d(iut,1)*cz1
     & +l1_56(i5,i6).b(iut,2)*cw2+l1_56(i5,i6).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id1.eq.5.and.id5.eq.5.and.id7.ne.5)then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=u1_5678(i5,i6,i7,i8).a,bb=u1_5678(i5,i6,i7,i8).b,cc=u1_5678(
* i5,i6,i7,i8).c,dd=u1_5678(i5,i6,i7,i8).d,a1=l1_56(i5,i6).a,b1=l1_56(i5
* ,i6).b,c1=l1_56(i5,i6).c,d1=l1_56(i5,i6).d,a2=u156_78(i7,i8).a,b2=u156
* _78(i7,i8).b,c2=u156_78(i7,i8).c,d2=u156_78(i7,i8).d,prq=p156q,m=rmass
* (id1),nsum=1
      do iut=1,2
      cx1=l1_56(i5,i6).a(iut,1)+l1_56(i5,i6).c(iut,1)*rmass(id1)
      cx2=l1_56(i5,i6).c(iut,2)*p156q+l1_56(i5,i6).a(iut,2)*rmas
     & s(id1)
      cy1=l1_56(i5,i6).b(iut,1)+l1_56(i5,i6).d(iut,1)*rmass(id1)
      cy2=l1_56(i5,i6).d(iut,2)*p156q+l1_56(i5,i6).b(iut,2)*rmas
     & s(id1)
      cw1=l1_56(i5,i6).c(iut,1)*p156q+l1_56(i5,i6).a(iut,1)*rmas
     & s(id1)
      cw2=l1_56(i5,i6).a(iut,2)+l1_56(i5,i6).c(iut,2)*rmass(id1)
      cz1=l1_56(i5,i6).d(iut,1)*p156q+l1_56(i5,i6).b(iut,1)*rmas
     & s(id1)
      cz2=l1_56(i5,i6).b(iut,2)+l1_56(i5,i6).d(iut,2)*rmass(id1)
      u1_5678(i5,i6,i7,i8).a(iut,1)=u1_5678(i5,i6,i7,i8).a(iut,1
     & )+cx1*u156_78(i7,i8).a(1,1)+cx2*u156_78(i7,i8).b(2,1)
      u1_5678(i5,i6,i7,i8).b(iut,1)=u1_5678(i5,i6,i7,i8).b(iut,1
     & )+cy1*u156_78(i7,i8).a(1,1)+cy2*u156_78(i7,i8).b(2,1)
      u1_5678(i5,i6,i7,i8).c(iut,1)=u1_5678(i5,i6,i7,i8).c(iut,1
     & )+cw1*u156_78(i7,i8).d(1,1)+cw2*u156_78(i7,i8).c(2,1)
      u1_5678(i5,i6,i7,i8).d(iut,1)=u1_5678(i5,i6,i7,i8).d(iut,1
     & )+cz1*u156_78(i7,i8).d(1,1)+cz2*u156_78(i7,i8).c(2,1)
      u1_5678(i5,i6,i7,i8).a(iut,2)=u1_5678(i5,i6,i7,i8).a(iut,2
     & )+cw1*u156_78(i7,i8).b(1,2)+cw2*u156_78(i7,i8).a(2,2)
      u1_5678(i5,i6,i7,i8).b(iut,2)=u1_5678(i5,i6,i7,i8).b(iut,2
     & )+cz1*u156_78(i7,i8).b(1,2)+cz2*u156_78(i7,i8).a(2,2)
      u1_5678(i5,i6,i7,i8).c(iut,2)=u1_5678(i5,i6,i7,i8).c(iut,2
     & )+cx1*u156_78(i7,i8).c(1,2)+cx2*u156_78(i7,i8).d(2,2)
      u1_5678(i5,i6,i7,i8).d(iut,2)=u1_5678(i5,i6,i7,i8).d(iut,2
     & )+cy1*u156_78(i7,i8).c(1,2)+cy2*u156_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id1.eq.5.and.id5.ne.5.and.id7.eq.5)then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TTs -- aa=u1_5678(i5,i6,i7,i8).a,bb=u1_5678(i5,i6,i7,i8).b,cc=u1_5678(
* i5,i6,i7,i8).c,dd=u1_5678(i5,i6,i7,i8).d,a1=l1_56(i5,i6).a,b1=l1_56(i5
* ,i6).b,c1=l1_56(i5,i6).c,d1=l1_56(i5,i6).d,a2=u156_78(i7,i8).a,b2=u156
* _78(i7,i8).b,c2=u156_78(i7,i8).c,d2=u156_78(i7,i8).d,prq=p156q,m=rmass
* (id1),nsum=1
      do jut=1,2
      cx1=u156_78(i7,i8).a(1,jut)+rmass(id1)*u156_78(i7,i8).b(1,
     & jut)
      cx2=u156_78(i7,i8).a(2,jut)+rmass(id1)*u156_78(i7,i8).b(2,
     & jut)
      cy1=p156q*u156_78(i7,i8).b(1,jut)+rmass(id1)*u156_78(i7,i8
     & ).a(1,jut)
      cy2=p156q*u156_78(i7,i8).b(2,jut)+rmass(id1)*u156_78(i7,i8
     & ).a(2,jut)
      cw1=u156_78(i7,i8).c(1,jut)+rmass(id1)*u156_78(i7,i8).d(1,
     & jut)
      cw2=u156_78(i7,i8).c(2,jut)+rmass(id1)*u156_78(i7,i8).d(2,
     & jut)
      cz1=p156q*u156_78(i7,i8).d(1,jut)+rmass(id1)*u156_78(i7,i8
     & ).c(1,jut)
      cz2=p156q*u156_78(i7,i8).d(2,jut)+rmass(id1)*u156_78(i7,i8
     & ).c(2,jut)
      u1_5678(i5,i6,i7,i8).a(1,jut)=u1_5678(i5,i6,i7,i8).a(1,jut
     & )+l1_56(i5,i6).a(1,1)*cx1+l1_56(i5,i6).c(1,2)*cy2
      u1_5678(i5,i6,i7,i8).b(1,jut)=u1_5678(i5,i6,i7,i8).b(1,jut
     & )+l1_56(i5,i6).d(1,1)*cy1+l1_56(i5,i6).b(1,2)*cx2
      u1_5678(i5,i6,i7,i8).c(1,jut)=u1_5678(i5,i6,i7,i8).c(1,jut
     & )+l1_56(i5,i6).a(1,1)*cw1+l1_56(i5,i6).c(1,2)*cz2
      u1_5678(i5,i6,i7,i8).d(1,jut)=u1_5678(i5,i6,i7,i8).d(1,jut
     & )+l1_56(i5,i6).d(1,1)*cz1+l1_56(i5,i6).b(1,2)*cw2
      u1_5678(i5,i6,i7,i8).a(2,jut)=u1_5678(i5,i6,i7,i8).a(2,jut
     & )+l1_56(i5,i6).c(2,1)*cy1+l1_56(i5,i6).a(2,2)*cx2
      u1_5678(i5,i6,i7,i8).b(2,jut)=u1_5678(i5,i6,i7,i8).b(2,jut
     & )+l1_56(i5,i6).b(2,1)*cx1+l1_56(i5,i6).d(2,2)*cy2
      u1_5678(i5,i6,i7,i8).c(2,jut)=u1_5678(i5,i6,i7,i8).c(2,jut
     & )+l1_56(i5,i6).c(2,1)*cz1+l1_56(i5,i6).a(2,2)*cw2
      u1_5678(i5,i6,i7,i8).d(2,jut)=u1_5678(i5,i6,i7,i8).d(2,jut
     & )+l1_56(i5,i6).b(2,1)*cw1+l1_56(i5,i6).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p178q,p=p178,q=p178,bef=,aft=
      p178q=(p178(0)*p178(0)-p178(1)*p178(1)-p178(2)*p178(2)-p17
     & 8(3)*p178(3))
  
      if(id1.ne.5.or.(id7.ne.5.and.id5.ne.5))then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=u1_5678(i5,i6,i7,i8).a,bb=u1_5678(i5,i6,i7,i8).b,cc=u1_5678(i
* 5,i6,i7,i8).c,dd=u1_5678(i5,i6,i7,i8).d,a1=l1_78(i7,i8).a,b1=l1_78(i7,
* i8).b,c1=l1_78(i7,i8).c,d1=l1_78(i7,i8).d,a2=u178_56(i5,i6).a,b2=u178_
* 56(i5,i6).b,c2=u178_56(i5,i6).c,d2=u178_56(i5,i6).d,prq=p178q,m=rmass(
* id1),nsum=1
      u1_5678(i5,i6,i7,i8).a(1,1)=u1_5678(i5,i6,i7,i8).a(1,1)+l1
     & _78(i7,i8).a(1,1)*u178_56(i5,i6).a(1,1)+l1_78(i7,i8).c(1,
     & 2)*p178q*u178_56(i5,i6).b(2,1)
      u1_5678(i5,i6,i7,i8).b(1,1)=u1_5678(i5,i6,i7,i8).b(1,1)+rm
     & ass(id1)*(l1_78(i7,i8).d(1,1)*u178_56(i5,i6).a(1,1)+l1_78
     & (i7,i8).b(1,2)*u178_56(i5,i6).b(2,1))
      u1_5678(i5,i6,i7,i8).c(1,1)=u1_5678(i5,i6,i7,i8).c(1,1)+rm
     & ass(id1)*(l1_78(i7,i8).a(1,1)*u178_56(i5,i6).d(1,1)+l1_78
     & (i7,i8).c(1,2)*u178_56(i5,i6).c(2,1))
      u1_5678(i5,i6,i7,i8).d(1,1)=u1_5678(i5,i6,i7,i8).d(1,1)+l1
     & _78(i7,i8).d(1,1)*p178q*u178_56(i5,i6).d(1,1)+l1_78(i7,i8
     & ).b(1,2)*u178_56(i5,i6).c(2,1)
      u1_5678(i5,i6,i7,i8).a(1,2)=u1_5678(i5,i6,i7,i8).a(1,2)+rm
     & ass(id1)*(l1_78(i7,i8).a(1,1)*u178_56(i5,i6).b(1,2)+l1_78
     & (i7,i8).c(1,2)*u178_56(i5,i6).a(2,2))
      u1_5678(i5,i6,i7,i8).b(1,2)=u1_5678(i5,i6,i7,i8).b(1,2)+l1
     & _78(i7,i8).d(1,1)*p178q*u178_56(i5,i6).b(1,2)+l1_78(i7,i8
     & ).b(1,2)*u178_56(i5,i6).a(2,2)
      u1_5678(i5,i6,i7,i8).c(1,2)=u1_5678(i5,i6,i7,i8).c(1,2)+l1
     & _78(i7,i8).a(1,1)*u178_56(i5,i6).c(1,2)+l1_78(i7,i8).c(1,
     & 2)*p178q*u178_56(i5,i6).d(2,2)
      u1_5678(i5,i6,i7,i8).d(1,2)=u1_5678(i5,i6,i7,i8).d(1,2)+rm
     & ass(id1)*(l1_78(i7,i8).d(1,1)*u178_56(i5,i6).c(1,2)+l1_78
     & (i7,i8).b(1,2)*u178_56(i5,i6).d(2,2))
      u1_5678(i5,i6,i7,i8).a(2,1)=u1_5678(i5,i6,i7,i8).a(2,1)+rm
     & ass(id1)*(l1_78(i7,i8).c(2,1)*u178_56(i5,i6).a(1,1)+l1_78
     & (i7,i8).a(2,2)*u178_56(i5,i6).b(2,1))
      u1_5678(i5,i6,i7,i8).b(2,1)=u1_5678(i5,i6,i7,i8).b(2,1)+l1
     & _78(i7,i8).b(2,1)*u178_56(i5,i6).a(1,1)+l1_78(i7,i8).d(2,
     & 2)*p178q*u178_56(i5,i6).b(2,1)
      u1_5678(i5,i6,i7,i8).c(2,1)=u1_5678(i5,i6,i7,i8).c(2,1)+l1
     & _78(i7,i8).c(2,1)*p178q*u178_56(i5,i6).d(1,1)+l1_78(i7,i8
     & ).a(2,2)*u178_56(i5,i6).c(2,1)
      u1_5678(i5,i6,i7,i8).d(2,1)=u1_5678(i5,i6,i7,i8).d(2,1)+rm
     & ass(id1)*(l1_78(i7,i8).b(2,1)*u178_56(i5,i6).d(1,1)+l1_78
     & (i7,i8).d(2,2)*u178_56(i5,i6).c(2,1))
      u1_5678(i5,i6,i7,i8).a(2,2)=u1_5678(i5,i6,i7,i8).a(2,2)+l1
     & _78(i7,i8).c(2,1)*p178q*u178_56(i5,i6).b(1,2)+l1_78(i7,i8
     & ).a(2,2)*u178_56(i5,i6).a(2,2)
      u1_5678(i5,i6,i7,i8).b(2,2)=u1_5678(i5,i6,i7,i8).b(2,2)+rm
     & ass(id1)*(l1_78(i7,i8).b(2,1)*u178_56(i5,i6).b(1,2)+l1_78
     & (i7,i8).d(2,2)*u178_56(i5,i6).a(2,2))
      u1_5678(i5,i6,i7,i8).c(2,2)=u1_5678(i5,i6,i7,i8).c(2,2)+rm
     & ass(id1)*(l1_78(i7,i8).c(2,1)*u178_56(i5,i6).c(1,2)+l1_78
     & (i7,i8).a(2,2)*u178_56(i5,i6).d(2,2))
      u1_5678(i5,i6,i7,i8).d(2,2)=u1_5678(i5,i6,i7,i8).d(2,2)+l1
     & _78(i7,i8).b(2,1)*u178_56(i5,i6).c(1,2)+l1_78(i7,i8).d(2,
     & 2)*p178q*u178_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id1.eq.5.and.id7.eq.5.and.id5.eq.5)then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=u1_5678(i5,i6,i7,i8).a,bb=u1_5678(i5,i6,i7,i8).b,cc=u1_5678
* (i5,i6,i7,i8).c,dd=u1_5678(i5,i6,i7,i8).d,a1=l1_78(i7,i8).a,b1=l1_78(i
* 7,i8).b,c1=l1_78(i7,i8).c,d1=l1_78(i7,i8).d,a2=u178_56(i5,i6).a,b2=u17
* 8_56(i5,i6).b,c2=u178_56(i5,i6).c,d2=u178_56(i5,i6).d,prq=p178q,m=rmas
* s(id1),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u178_56(i5,i6).a(1,jut)+rmass(id1)*u178_56(i5,i6).b(1,
     & jut)
      cx2=u178_56(i5,i6).a(2,jut)+rmass(id1)*u178_56(i5,i6).b(2,
     & jut)
      cy1=p178q*u178_56(i5,i6).b(1,jut)+rmass(id1)*u178_56(i5,i6
     & ).a(1,jut)
      cy2=p178q*u178_56(i5,i6).b(2,jut)+rmass(id1)*u178_56(i5,i6
     & ).a(2,jut)
      u1_5678(i5,i6,i7,i8).a(iut,jut)=u1_5678(i5,i6,i7,i8).a(iut
     & ,jut)+l1_78(i7,i8).a(iut,1)*cx1+l1_78(i7,i8).c(iut,1)*cy1
     & +l1_78(i7,i8).a(iut,2)*cx2+l1_78(i7,i8).c(iut,2)*cy2
      u1_5678(i5,i6,i7,i8).b(iut,jut)=u1_5678(i5,i6,i7,i8).b(iut
     & ,jut)+l1_78(i7,i8).b(iut,1)*cx1+l1_78(i7,i8).d(iut,1)*cy1
     & +l1_78(i7,i8).b(iut,2)*cx2+l1_78(i7,i8).d(iut,2)*cy2
      cw1=u178_56(i5,i6).c(1,jut)+rmass(id1)*u178_56(i5,i6).d(1,
     & jut)
      cw2=u178_56(i5,i6).c(2,jut)+rmass(id1)*u178_56(i5,i6).d(2,
     & jut)
      cz1=p178q*u178_56(i5,i6).d(1,jut)+rmass(id1)*u178_56(i5,i6
     & ).c(1,jut)
      cz2=p178q*u178_56(i5,i6).d(2,jut)+rmass(id1)*u178_56(i5,i6
     & ).c(2,jut)
      u1_5678(i5,i6,i7,i8).c(iut,jut)=u1_5678(i5,i6,i7,i8).c(iut
     & ,jut)+l1_78(i7,i8).a(iut,1)*cw1+l1_78(i7,i8).c(iut,1)*cz1
     & +l1_78(i7,i8).a(iut,2)*cw2+l1_78(i7,i8).c(iut,2)*cz2
      u1_5678(i5,i6,i7,i8).d(iut,jut)=u1_5678(i5,i6,i7,i8).d(iut
     & ,jut)+l1_78(i7,i8).b(iut,1)*cw1+l1_78(i7,i8).d(iut,1)*cz1
     & +l1_78(i7,i8).b(iut,2)*cw2+l1_78(i7,i8).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id1.eq.5.and.id7.eq.5.and.id5.ne.5)then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=u1_5678(i5,i6,i7,i8).a,bb=u1_5678(i5,i6,i7,i8).b,cc=u1_5678(
* i5,i6,i7,i8).c,dd=u1_5678(i5,i6,i7,i8).d,a1=l1_78(i7,i8).a,b1=l1_78(i7
* ,i8).b,c1=l1_78(i7,i8).c,d1=l1_78(i7,i8).d,a2=u178_56(i5,i6).a,b2=u178
* _56(i5,i6).b,c2=u178_56(i5,i6).c,d2=u178_56(i5,i6).d,prq=p178q,m=rmass
* (id1),nsum=1
      do iut=1,2
      cx1=l1_78(i7,i8).a(iut,1)+l1_78(i7,i8).c(iut,1)*rmass(id1)
      cx2=l1_78(i7,i8).c(iut,2)*p178q+l1_78(i7,i8).a(iut,2)*rmas
     & s(id1)
      cy1=l1_78(i7,i8).b(iut,1)+l1_78(i7,i8).d(iut,1)*rmass(id1)
      cy2=l1_78(i7,i8).d(iut,2)*p178q+l1_78(i7,i8).b(iut,2)*rmas
     & s(id1)
      cw1=l1_78(i7,i8).c(iut,1)*p178q+l1_78(i7,i8).a(iut,1)*rmas
     & s(id1)
      cw2=l1_78(i7,i8).a(iut,2)+l1_78(i7,i8).c(iut,2)*rmass(id1)
      cz1=l1_78(i7,i8).d(iut,1)*p178q+l1_78(i7,i8).b(iut,1)*rmas
     & s(id1)
      cz2=l1_78(i7,i8).b(iut,2)+l1_78(i7,i8).d(iut,2)*rmass(id1)
      u1_5678(i5,i6,i7,i8).a(iut,1)=u1_5678(i5,i6,i7,i8).a(iut,1
     & )+cx1*u178_56(i5,i6).a(1,1)+cx2*u178_56(i5,i6).b(2,1)
      u1_5678(i5,i6,i7,i8).b(iut,1)=u1_5678(i5,i6,i7,i8).b(iut,1
     & )+cy1*u178_56(i5,i6).a(1,1)+cy2*u178_56(i5,i6).b(2,1)
      u1_5678(i5,i6,i7,i8).c(iut,1)=u1_5678(i5,i6,i7,i8).c(iut,1
     & )+cw1*u178_56(i5,i6).d(1,1)+cw2*u178_56(i5,i6).c(2,1)
      u1_5678(i5,i6,i7,i8).d(iut,1)=u1_5678(i5,i6,i7,i8).d(iut,1
     & )+cz1*u178_56(i5,i6).d(1,1)+cz2*u178_56(i5,i6).c(2,1)
      u1_5678(i5,i6,i7,i8).a(iut,2)=u1_5678(i5,i6,i7,i8).a(iut,2
     & )+cw1*u178_56(i5,i6).b(1,2)+cw2*u178_56(i5,i6).a(2,2)
      u1_5678(i5,i6,i7,i8).b(iut,2)=u1_5678(i5,i6,i7,i8).b(iut,2
     & )+cz1*u178_56(i5,i6).b(1,2)+cz2*u178_56(i5,i6).a(2,2)
      u1_5678(i5,i6,i7,i8).c(iut,2)=u1_5678(i5,i6,i7,i8).c(iut,2
     & )+cx1*u178_56(i5,i6).c(1,2)+cx2*u178_56(i5,i6).d(2,2)
      u1_5678(i5,i6,i7,i8).d(iut,2)=u1_5678(i5,i6,i7,i8).d(iut,2
     & )+cy1*u178_56(i5,i6).c(1,2)+cy2*u178_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id1.eq.5.and.id7.ne.5.and.id5.eq.5)then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TTs -- aa=u1_5678(i5,i6,i7,i8).a,bb=u1_5678(i5,i6,i7,i8).b,cc=u1_5678(
* i5,i6,i7,i8).c,dd=u1_5678(i5,i6,i7,i8).d,a1=l1_78(i7,i8).a,b1=l1_78(i7
* ,i8).b,c1=l1_78(i7,i8).c,d1=l1_78(i7,i8).d,a2=u178_56(i5,i6).a,b2=u178
* _56(i5,i6).b,c2=u178_56(i5,i6).c,d2=u178_56(i5,i6).d,prq=p178q,m=rmass
* (id1),nsum=1
      do jut=1,2
      cx1=u178_56(i5,i6).a(1,jut)+rmass(id1)*u178_56(i5,i6).b(1,
     & jut)
      cx2=u178_56(i5,i6).a(2,jut)+rmass(id1)*u178_56(i5,i6).b(2,
     & jut)
      cy1=p178q*u178_56(i5,i6).b(1,jut)+rmass(id1)*u178_56(i5,i6
     & ).a(1,jut)
      cy2=p178q*u178_56(i5,i6).b(2,jut)+rmass(id1)*u178_56(i5,i6
     & ).a(2,jut)
      cw1=u178_56(i5,i6).c(1,jut)+rmass(id1)*u178_56(i5,i6).d(1,
     & jut)
      cw2=u178_56(i5,i6).c(2,jut)+rmass(id1)*u178_56(i5,i6).d(2,
     & jut)
      cz1=p178q*u178_56(i5,i6).d(1,jut)+rmass(id1)*u178_56(i5,i6
     & ).c(1,jut)
      cz2=p178q*u178_56(i5,i6).d(2,jut)+rmass(id1)*u178_56(i5,i6
     & ).c(2,jut)
      u1_5678(i5,i6,i7,i8).a(1,jut)=u1_5678(i5,i6,i7,i8).a(1,jut
     & )+l1_78(i7,i8).a(1,1)*cx1+l1_78(i7,i8).c(1,2)*cy2
      u1_5678(i5,i6,i7,i8).b(1,jut)=u1_5678(i5,i6,i7,i8).b(1,jut
     & )+l1_78(i7,i8).d(1,1)*cy1+l1_78(i7,i8).b(1,2)*cx2
      u1_5678(i5,i6,i7,i8).c(1,jut)=u1_5678(i5,i6,i7,i8).c(1,jut
     & )+l1_78(i7,i8).a(1,1)*cw1+l1_78(i7,i8).c(1,2)*cz2
      u1_5678(i5,i6,i7,i8).d(1,jut)=u1_5678(i5,i6,i7,i8).d(1,jut
     & )+l1_78(i7,i8).d(1,1)*cz1+l1_78(i7,i8).b(1,2)*cw2
      u1_5678(i5,i6,i7,i8).a(2,jut)=u1_5678(i5,i6,i7,i8).a(2,jut
     & )+l1_78(i7,i8).c(2,1)*cy1+l1_78(i7,i8).a(2,2)*cx2
      u1_5678(i5,i6,i7,i8).b(2,jut)=u1_5678(i5,i6,i7,i8).b(2,jut
     & )+l1_78(i7,i8).b(2,1)*cx1+l1_78(i7,i8).d(2,2)*cy2
      u1_5678(i5,i6,i7,i8).c(2,jut)=u1_5678(i5,i6,i7,i8).c(2,jut
     & )+l1_78(i7,i8).c(2,1)*cz1+l1_78(i7,i8).a(2,2)*cw2
      u1_5678(i5,i6,i7,i8).d(2,jut)=u1_5678(i5,i6,i7,i8).d(2,jut
     & )+l1_78(i7,i8).b(2,1)*cw1+l1_78(i7,i8).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p312q,p=p312,q=p312,bef=,aft=
      p312q=(p312(0)*p312(0)-p312(1)*p312(1)-p312(2)*p312(2)-p31
     & 2(3)*p312(3))
  
      if(id3.ne.5.or.(id1.ne.5.and.id5.ne.5))then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TT -- aa=u3_1256(i1,i2,i5,i6).a,bb=u3_1256(i1,i2,i5,i6).b,cc=u3_1256(i
* 1,i2,i5,i6).c,dd=u3_1256(i1,i2,i5,i6).d,a1=l3_12(i1,i2).a,b1=l3_12(i1,
* i2).b,c1=l3_12(i1,i2).c,d1=l3_12(i1,i2).d,a2=u312_56(i5,i6).a,b2=u312_
* 56(i5,i6).b,c2=u312_56(i5,i6).c,d2=u312_56(i5,i6).d,prq=p312q,m=rmass(
* id3),nsum=1
      u3_1256(i1,i2,i5,i6).a(1,1)=u3_1256(i1,i2,i5,i6).a(1,1)+l3
     & _12(i1,i2).a(1,1)*u312_56(i5,i6).a(1,1)+l3_12(i1,i2).c(1,
     & 2)*p312q*u312_56(i5,i6).b(2,1)
      u3_1256(i1,i2,i5,i6).b(1,1)=u3_1256(i1,i2,i5,i6).b(1,1)+rm
     & ass(id3)*(l3_12(i1,i2).d(1,1)*u312_56(i5,i6).a(1,1)+l3_12
     & (i1,i2).b(1,2)*u312_56(i5,i6).b(2,1))
      u3_1256(i1,i2,i5,i6).c(1,1)=u3_1256(i1,i2,i5,i6).c(1,1)+rm
     & ass(id3)*(l3_12(i1,i2).a(1,1)*u312_56(i5,i6).d(1,1)+l3_12
     & (i1,i2).c(1,2)*u312_56(i5,i6).c(2,1))
      u3_1256(i1,i2,i5,i6).d(1,1)=u3_1256(i1,i2,i5,i6).d(1,1)+l3
     & _12(i1,i2).d(1,1)*p312q*u312_56(i5,i6).d(1,1)+l3_12(i1,i2
     & ).b(1,2)*u312_56(i5,i6).c(2,1)
      u3_1256(i1,i2,i5,i6).a(1,2)=u3_1256(i1,i2,i5,i6).a(1,2)+rm
     & ass(id3)*(l3_12(i1,i2).a(1,1)*u312_56(i5,i6).b(1,2)+l3_12
     & (i1,i2).c(1,2)*u312_56(i5,i6).a(2,2))
      u3_1256(i1,i2,i5,i6).b(1,2)=u3_1256(i1,i2,i5,i6).b(1,2)+l3
     & _12(i1,i2).d(1,1)*p312q*u312_56(i5,i6).b(1,2)+l3_12(i1,i2
     & ).b(1,2)*u312_56(i5,i6).a(2,2)
      u3_1256(i1,i2,i5,i6).c(1,2)=u3_1256(i1,i2,i5,i6).c(1,2)+l3
     & _12(i1,i2).a(1,1)*u312_56(i5,i6).c(1,2)+l3_12(i1,i2).c(1,
     & 2)*p312q*u312_56(i5,i6).d(2,2)
      u3_1256(i1,i2,i5,i6).d(1,2)=u3_1256(i1,i2,i5,i6).d(1,2)+rm
     & ass(id3)*(l3_12(i1,i2).d(1,1)*u312_56(i5,i6).c(1,2)+l3_12
     & (i1,i2).b(1,2)*u312_56(i5,i6).d(2,2))
      u3_1256(i1,i2,i5,i6).a(2,1)=u3_1256(i1,i2,i5,i6).a(2,1)+rm
     & ass(id3)*(l3_12(i1,i2).c(2,1)*u312_56(i5,i6).a(1,1)+l3_12
     & (i1,i2).a(2,2)*u312_56(i5,i6).b(2,1))
      u3_1256(i1,i2,i5,i6).b(2,1)=u3_1256(i1,i2,i5,i6).b(2,1)+l3
     & _12(i1,i2).b(2,1)*u312_56(i5,i6).a(1,1)+l3_12(i1,i2).d(2,
     & 2)*p312q*u312_56(i5,i6).b(2,1)
      u3_1256(i1,i2,i5,i6).c(2,1)=u3_1256(i1,i2,i5,i6).c(2,1)+l3
     & _12(i1,i2).c(2,1)*p312q*u312_56(i5,i6).d(1,1)+l3_12(i1,i2
     & ).a(2,2)*u312_56(i5,i6).c(2,1)
      u3_1256(i1,i2,i5,i6).d(2,1)=u3_1256(i1,i2,i5,i6).d(2,1)+rm
     & ass(id3)*(l3_12(i1,i2).b(2,1)*u312_56(i5,i6).d(1,1)+l3_12
     & (i1,i2).d(2,2)*u312_56(i5,i6).c(2,1))
      u3_1256(i1,i2,i5,i6).a(2,2)=u3_1256(i1,i2,i5,i6).a(2,2)+l3
     & _12(i1,i2).c(2,1)*p312q*u312_56(i5,i6).b(1,2)+l3_12(i1,i2
     & ).a(2,2)*u312_56(i5,i6).a(2,2)
      u3_1256(i1,i2,i5,i6).b(2,2)=u3_1256(i1,i2,i5,i6).b(2,2)+rm
     & ass(id3)*(l3_12(i1,i2).b(2,1)*u312_56(i5,i6).b(1,2)+l3_12
     & (i1,i2).d(2,2)*u312_56(i5,i6).a(2,2))
      u3_1256(i1,i2,i5,i6).c(2,2)=u3_1256(i1,i2,i5,i6).c(2,2)+rm
     & ass(id3)*(l3_12(i1,i2).c(2,1)*u312_56(i5,i6).c(1,2)+l3_12
     & (i1,i2).a(2,2)*u312_56(i5,i6).d(2,2))
      u3_1256(i1,i2,i5,i6).d(2,2)=u3_1256(i1,i2,i5,i6).d(2,2)+l3
     & _12(i1,i2).b(2,1)*u312_56(i5,i6).c(1,2)+l3_12(i1,i2).d(2,
     & 2)*p312q*u312_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id3.eq.5.and.id1.eq.5.and.id5.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TsTs -- aa=u3_1256(i1,i2,i5,i6).a,bb=u3_1256(i1,i2,i5,i6).b,cc=u3_1256
* (i1,i2,i5,i6).c,dd=u3_1256(i1,i2,i5,i6).d,a1=l3_12(i1,i2).a,b1=l3_12(i
* 1,i2).b,c1=l3_12(i1,i2).c,d1=l3_12(i1,i2).d,a2=u312_56(i5,i6).a,b2=u31
* 2_56(i5,i6).b,c2=u312_56(i5,i6).c,d2=u312_56(i5,i6).d,prq=p312q,m=rmas
* s(id3),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u312_56(i5,i6).a(1,jut)+rmass(id3)*u312_56(i5,i6).b(1,
     & jut)
      cx2=u312_56(i5,i6).a(2,jut)+rmass(id3)*u312_56(i5,i6).b(2,
     & jut)
      cy1=p312q*u312_56(i5,i6).b(1,jut)+rmass(id3)*u312_56(i5,i6
     & ).a(1,jut)
      cy2=p312q*u312_56(i5,i6).b(2,jut)+rmass(id3)*u312_56(i5,i6
     & ).a(2,jut)
      u3_1256(i1,i2,i5,i6).a(iut,jut)=u3_1256(i1,i2,i5,i6).a(iut
     & ,jut)+l3_12(i1,i2).a(iut,1)*cx1+l3_12(i1,i2).c(iut,1)*cy1
     & +l3_12(i1,i2).a(iut,2)*cx2+l3_12(i1,i2).c(iut,2)*cy2
      u3_1256(i1,i2,i5,i6).b(iut,jut)=u3_1256(i1,i2,i5,i6).b(iut
     & ,jut)+l3_12(i1,i2).b(iut,1)*cx1+l3_12(i1,i2).d(iut,1)*cy1
     & +l3_12(i1,i2).b(iut,2)*cx2+l3_12(i1,i2).d(iut,2)*cy2
      cw1=u312_56(i5,i6).c(1,jut)+rmass(id3)*u312_56(i5,i6).d(1,
     & jut)
      cw2=u312_56(i5,i6).c(2,jut)+rmass(id3)*u312_56(i5,i6).d(2,
     & jut)
      cz1=p312q*u312_56(i5,i6).d(1,jut)+rmass(id3)*u312_56(i5,i6
     & ).c(1,jut)
      cz2=p312q*u312_56(i5,i6).d(2,jut)+rmass(id3)*u312_56(i5,i6
     & ).c(2,jut)
      u3_1256(i1,i2,i5,i6).c(iut,jut)=u3_1256(i1,i2,i5,i6).c(iut
     & ,jut)+l3_12(i1,i2).a(iut,1)*cw1+l3_12(i1,i2).c(iut,1)*cz1
     & +l3_12(i1,i2).a(iut,2)*cw2+l3_12(i1,i2).c(iut,2)*cz2
      u3_1256(i1,i2,i5,i6).d(iut,jut)=u3_1256(i1,i2,i5,i6).d(iut
     & ,jut)+l3_12(i1,i2).b(iut,1)*cw1+l3_12(i1,i2).d(iut,1)*cz1
     & +l3_12(i1,i2).b(iut,2)*cw2+l3_12(i1,i2).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id3.eq.5.and.id1.eq.5.and.id5.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TsT -- aa=u3_1256(i1,i2,i5,i6).a,bb=u3_1256(i1,i2,i5,i6).b,cc=u3_1256(
* i1,i2,i5,i6).c,dd=u3_1256(i1,i2,i5,i6).d,a1=l3_12(i1,i2).a,b1=l3_12(i1
* ,i2).b,c1=l3_12(i1,i2).c,d1=l3_12(i1,i2).d,a2=u312_56(i5,i6).a,b2=u312
* _56(i5,i6).b,c2=u312_56(i5,i6).c,d2=u312_56(i5,i6).d,prq=p312q,m=rmass
* (id3),nsum=1
      do iut=1,2
      cx1=l3_12(i1,i2).a(iut,1)+l3_12(i1,i2).c(iut,1)*rmass(id3)
      cx2=l3_12(i1,i2).c(iut,2)*p312q+l3_12(i1,i2).a(iut,2)*rmas
     & s(id3)
      cy1=l3_12(i1,i2).b(iut,1)+l3_12(i1,i2).d(iut,1)*rmass(id3)
      cy2=l3_12(i1,i2).d(iut,2)*p312q+l3_12(i1,i2).b(iut,2)*rmas
     & s(id3)
      cw1=l3_12(i1,i2).c(iut,1)*p312q+l3_12(i1,i2).a(iut,1)*rmas
     & s(id3)
      cw2=l3_12(i1,i2).a(iut,2)+l3_12(i1,i2).c(iut,2)*rmass(id3)
      cz1=l3_12(i1,i2).d(iut,1)*p312q+l3_12(i1,i2).b(iut,1)*rmas
     & s(id3)
      cz2=l3_12(i1,i2).b(iut,2)+l3_12(i1,i2).d(iut,2)*rmass(id3)
      u3_1256(i1,i2,i5,i6).a(iut,1)=u3_1256(i1,i2,i5,i6).a(iut,1
     & )+cx1*u312_56(i5,i6).a(1,1)+cx2*u312_56(i5,i6).b(2,1)
      u3_1256(i1,i2,i5,i6).b(iut,1)=u3_1256(i1,i2,i5,i6).b(iut,1
     & )+cy1*u312_56(i5,i6).a(1,1)+cy2*u312_56(i5,i6).b(2,1)
      u3_1256(i1,i2,i5,i6).c(iut,1)=u3_1256(i1,i2,i5,i6).c(iut,1
     & )+cw1*u312_56(i5,i6).d(1,1)+cw2*u312_56(i5,i6).c(2,1)
      u3_1256(i1,i2,i5,i6).d(iut,1)=u3_1256(i1,i2,i5,i6).d(iut,1
     & )+cz1*u312_56(i5,i6).d(1,1)+cz2*u312_56(i5,i6).c(2,1)
      u3_1256(i1,i2,i5,i6).a(iut,2)=u3_1256(i1,i2,i5,i6).a(iut,2
     & )+cw1*u312_56(i5,i6).b(1,2)+cw2*u312_56(i5,i6).a(2,2)
      u3_1256(i1,i2,i5,i6).b(iut,2)=u3_1256(i1,i2,i5,i6).b(iut,2
     & )+cz1*u312_56(i5,i6).b(1,2)+cz2*u312_56(i5,i6).a(2,2)
      u3_1256(i1,i2,i5,i6).c(iut,2)=u3_1256(i1,i2,i5,i6).c(iut,2
     & )+cx1*u312_56(i5,i6).c(1,2)+cx2*u312_56(i5,i6).d(2,2)
      u3_1256(i1,i2,i5,i6).d(iut,2)=u3_1256(i1,i2,i5,i6).d(iut,2
     & )+cy1*u312_56(i5,i6).c(1,2)+cy2*u312_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id3.eq.5.and.id1.ne.5.and.id5.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TTs -- aa=u3_1256(i1,i2,i5,i6).a,bb=u3_1256(i1,i2,i5,i6).b,cc=u3_1256(
* i1,i2,i5,i6).c,dd=u3_1256(i1,i2,i5,i6).d,a1=l3_12(i1,i2).a,b1=l3_12(i1
* ,i2).b,c1=l3_12(i1,i2).c,d1=l3_12(i1,i2).d,a2=u312_56(i5,i6).a,b2=u312
* _56(i5,i6).b,c2=u312_56(i5,i6).c,d2=u312_56(i5,i6).d,prq=p312q,m=rmass
* (id3),nsum=1
      do jut=1,2
      cx1=u312_56(i5,i6).a(1,jut)+rmass(id3)*u312_56(i5,i6).b(1,
     & jut)
      cx2=u312_56(i5,i6).a(2,jut)+rmass(id3)*u312_56(i5,i6).b(2,
     & jut)
      cy1=p312q*u312_56(i5,i6).b(1,jut)+rmass(id3)*u312_56(i5,i6
     & ).a(1,jut)
      cy2=p312q*u312_56(i5,i6).b(2,jut)+rmass(id3)*u312_56(i5,i6
     & ).a(2,jut)
      cw1=u312_56(i5,i6).c(1,jut)+rmass(id3)*u312_56(i5,i6).d(1,
     & jut)
      cw2=u312_56(i5,i6).c(2,jut)+rmass(id3)*u312_56(i5,i6).d(2,
     & jut)
      cz1=p312q*u312_56(i5,i6).d(1,jut)+rmass(id3)*u312_56(i5,i6
     & ).c(1,jut)
      cz2=p312q*u312_56(i5,i6).d(2,jut)+rmass(id3)*u312_56(i5,i6
     & ).c(2,jut)
      u3_1256(i1,i2,i5,i6).a(1,jut)=u3_1256(i1,i2,i5,i6).a(1,jut
     & )+l3_12(i1,i2).a(1,1)*cx1+l3_12(i1,i2).c(1,2)*cy2
      u3_1256(i1,i2,i5,i6).b(1,jut)=u3_1256(i1,i2,i5,i6).b(1,jut
     & )+l3_12(i1,i2).d(1,1)*cy1+l3_12(i1,i2).b(1,2)*cx2
      u3_1256(i1,i2,i5,i6).c(1,jut)=u3_1256(i1,i2,i5,i6).c(1,jut
     & )+l3_12(i1,i2).a(1,1)*cw1+l3_12(i1,i2).c(1,2)*cz2
      u3_1256(i1,i2,i5,i6).d(1,jut)=u3_1256(i1,i2,i5,i6).d(1,jut
     & )+l3_12(i1,i2).d(1,1)*cz1+l3_12(i1,i2).b(1,2)*cw2
      u3_1256(i1,i2,i5,i6).a(2,jut)=u3_1256(i1,i2,i5,i6).a(2,jut
     & )+l3_12(i1,i2).c(2,1)*cy1+l3_12(i1,i2).a(2,2)*cx2
      u3_1256(i1,i2,i5,i6).b(2,jut)=u3_1256(i1,i2,i5,i6).b(2,jut
     & )+l3_12(i1,i2).b(2,1)*cx1+l3_12(i1,i2).d(2,2)*cy2
      u3_1256(i1,i2,i5,i6).c(2,jut)=u3_1256(i1,i2,i5,i6).c(2,jut
     & )+l3_12(i1,i2).c(2,1)*cz1+l3_12(i1,i2).a(2,2)*cw2
      u3_1256(i1,i2,i5,i6).d(2,jut)=u3_1256(i1,i2,i5,i6).d(2,jut
     & )+l3_12(i1,i2).b(2,1)*cw1+l3_12(i1,i2).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p356q,p=p356,q=p356,bef=,aft=
      p356q=(p356(0)*p356(0)-p356(1)*p356(1)-p356(2)*p356(2)-p35
     & 6(3)*p356(3))
  
      if(id3.ne.5.or.(id5.ne.5.and.id1.ne.5))then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TT -- aa=u3_1256(i1,i2,i5,i6).a,bb=u3_1256(i1,i2,i5,i6).b,cc=u3_1256(i
* 1,i2,i5,i6).c,dd=u3_1256(i1,i2,i5,i6).d,a1=l3_56(i5,i6).a,b1=l3_56(i5,
* i6).b,c1=l3_56(i5,i6).c,d1=l3_56(i5,i6).d,a2=u356_12(i1,i2).a,b2=u356_
* 12(i1,i2).b,c2=u356_12(i1,i2).c,d2=u356_12(i1,i2).d,prq=p356q,m=rmass(
* id3),nsum=1
      u3_1256(i1,i2,i5,i6).a(1,1)=u3_1256(i1,i2,i5,i6).a(1,1)+l3
     & _56(i5,i6).a(1,1)*u356_12(i1,i2).a(1,1)+l3_56(i5,i6).c(1,
     & 2)*p356q*u356_12(i1,i2).b(2,1)
      u3_1256(i1,i2,i5,i6).b(1,1)=u3_1256(i1,i2,i5,i6).b(1,1)+rm
     & ass(id3)*(l3_56(i5,i6).d(1,1)*u356_12(i1,i2).a(1,1)+l3_56
     & (i5,i6).b(1,2)*u356_12(i1,i2).b(2,1))
      u3_1256(i1,i2,i5,i6).c(1,1)=u3_1256(i1,i2,i5,i6).c(1,1)+rm
     & ass(id3)*(l3_56(i5,i6).a(1,1)*u356_12(i1,i2).d(1,1)+l3_56
     & (i5,i6).c(1,2)*u356_12(i1,i2).c(2,1))
      u3_1256(i1,i2,i5,i6).d(1,1)=u3_1256(i1,i2,i5,i6).d(1,1)+l3
     & _56(i5,i6).d(1,1)*p356q*u356_12(i1,i2).d(1,1)+l3_56(i5,i6
     & ).b(1,2)*u356_12(i1,i2).c(2,1)
      u3_1256(i1,i2,i5,i6).a(1,2)=u3_1256(i1,i2,i5,i6).a(1,2)+rm
     & ass(id3)*(l3_56(i5,i6).a(1,1)*u356_12(i1,i2).b(1,2)+l3_56
     & (i5,i6).c(1,2)*u356_12(i1,i2).a(2,2))
      u3_1256(i1,i2,i5,i6).b(1,2)=u3_1256(i1,i2,i5,i6).b(1,2)+l3
     & _56(i5,i6).d(1,1)*p356q*u356_12(i1,i2).b(1,2)+l3_56(i5,i6
     & ).b(1,2)*u356_12(i1,i2).a(2,2)
      u3_1256(i1,i2,i5,i6).c(1,2)=u3_1256(i1,i2,i5,i6).c(1,2)+l3
     & _56(i5,i6).a(1,1)*u356_12(i1,i2).c(1,2)+l3_56(i5,i6).c(1,
     & 2)*p356q*u356_12(i1,i2).d(2,2)
      u3_1256(i1,i2,i5,i6).d(1,2)=u3_1256(i1,i2,i5,i6).d(1,2)+rm
     & ass(id3)*(l3_56(i5,i6).d(1,1)*u356_12(i1,i2).c(1,2)+l3_56
     & (i5,i6).b(1,2)*u356_12(i1,i2).d(2,2))
      u3_1256(i1,i2,i5,i6).a(2,1)=u3_1256(i1,i2,i5,i6).a(2,1)+rm
     & ass(id3)*(l3_56(i5,i6).c(2,1)*u356_12(i1,i2).a(1,1)+l3_56
     & (i5,i6).a(2,2)*u356_12(i1,i2).b(2,1))
      u3_1256(i1,i2,i5,i6).b(2,1)=u3_1256(i1,i2,i5,i6).b(2,1)+l3
     & _56(i5,i6).b(2,1)*u356_12(i1,i2).a(1,1)+l3_56(i5,i6).d(2,
     & 2)*p356q*u356_12(i1,i2).b(2,1)
      u3_1256(i1,i2,i5,i6).c(2,1)=u3_1256(i1,i2,i5,i6).c(2,1)+l3
     & _56(i5,i6).c(2,1)*p356q*u356_12(i1,i2).d(1,1)+l3_56(i5,i6
     & ).a(2,2)*u356_12(i1,i2).c(2,1)
      u3_1256(i1,i2,i5,i6).d(2,1)=u3_1256(i1,i2,i5,i6).d(2,1)+rm
     & ass(id3)*(l3_56(i5,i6).b(2,1)*u356_12(i1,i2).d(1,1)+l3_56
     & (i5,i6).d(2,2)*u356_12(i1,i2).c(2,1))
      u3_1256(i1,i2,i5,i6).a(2,2)=u3_1256(i1,i2,i5,i6).a(2,2)+l3
     & _56(i5,i6).c(2,1)*p356q*u356_12(i1,i2).b(1,2)+l3_56(i5,i6
     & ).a(2,2)*u356_12(i1,i2).a(2,2)
      u3_1256(i1,i2,i5,i6).b(2,2)=u3_1256(i1,i2,i5,i6).b(2,2)+rm
     & ass(id3)*(l3_56(i5,i6).b(2,1)*u356_12(i1,i2).b(1,2)+l3_56
     & (i5,i6).d(2,2)*u356_12(i1,i2).a(2,2))
      u3_1256(i1,i2,i5,i6).c(2,2)=u3_1256(i1,i2,i5,i6).c(2,2)+rm
     & ass(id3)*(l3_56(i5,i6).c(2,1)*u356_12(i1,i2).c(1,2)+l3_56
     & (i5,i6).a(2,2)*u356_12(i1,i2).d(2,2))
      u3_1256(i1,i2,i5,i6).d(2,2)=u3_1256(i1,i2,i5,i6).d(2,2)+l3
     & _56(i5,i6).b(2,1)*u356_12(i1,i2).c(1,2)+l3_56(i5,i6).d(2,
     & 2)*p356q*u356_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id3.eq.5.and.id5.eq.5.and.id1.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TsTs -- aa=u3_1256(i1,i2,i5,i6).a,bb=u3_1256(i1,i2,i5,i6).b,cc=u3_1256
* (i1,i2,i5,i6).c,dd=u3_1256(i1,i2,i5,i6).d,a1=l3_56(i5,i6).a,b1=l3_56(i
* 5,i6).b,c1=l3_56(i5,i6).c,d1=l3_56(i5,i6).d,a2=u356_12(i1,i2).a,b2=u35
* 6_12(i1,i2).b,c2=u356_12(i1,i2).c,d2=u356_12(i1,i2).d,prq=p356q,m=rmas
* s(id3),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u356_12(i1,i2).a(1,jut)+rmass(id3)*u356_12(i1,i2).b(1,
     & jut)
      cx2=u356_12(i1,i2).a(2,jut)+rmass(id3)*u356_12(i1,i2).b(2,
     & jut)
      cy1=p356q*u356_12(i1,i2).b(1,jut)+rmass(id3)*u356_12(i1,i2
     & ).a(1,jut)
      cy2=p356q*u356_12(i1,i2).b(2,jut)+rmass(id3)*u356_12(i1,i2
     & ).a(2,jut)
      u3_1256(i1,i2,i5,i6).a(iut,jut)=u3_1256(i1,i2,i5,i6).a(iut
     & ,jut)+l3_56(i5,i6).a(iut,1)*cx1+l3_56(i5,i6).c(iut,1)*cy1
     & +l3_56(i5,i6).a(iut,2)*cx2+l3_56(i5,i6).c(iut,2)*cy2
      u3_1256(i1,i2,i5,i6).b(iut,jut)=u3_1256(i1,i2,i5,i6).b(iut
     & ,jut)+l3_56(i5,i6).b(iut,1)*cx1+l3_56(i5,i6).d(iut,1)*cy1
     & +l3_56(i5,i6).b(iut,2)*cx2+l3_56(i5,i6).d(iut,2)*cy2
      cw1=u356_12(i1,i2).c(1,jut)+rmass(id3)*u356_12(i1,i2).d(1,
     & jut)
      cw2=u356_12(i1,i2).c(2,jut)+rmass(id3)*u356_12(i1,i2).d(2,
     & jut)
      cz1=p356q*u356_12(i1,i2).d(1,jut)+rmass(id3)*u356_12(i1,i2
     & ).c(1,jut)
      cz2=p356q*u356_12(i1,i2).d(2,jut)+rmass(id3)*u356_12(i1,i2
     & ).c(2,jut)
      u3_1256(i1,i2,i5,i6).c(iut,jut)=u3_1256(i1,i2,i5,i6).c(iut
     & ,jut)+l3_56(i5,i6).a(iut,1)*cw1+l3_56(i5,i6).c(iut,1)*cz1
     & +l3_56(i5,i6).a(iut,2)*cw2+l3_56(i5,i6).c(iut,2)*cz2
      u3_1256(i1,i2,i5,i6).d(iut,jut)=u3_1256(i1,i2,i5,i6).d(iut
     & ,jut)+l3_56(i5,i6).b(iut,1)*cw1+l3_56(i5,i6).d(iut,1)*cz1
     & +l3_56(i5,i6).b(iut,2)*cw2+l3_56(i5,i6).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id3.eq.5.and.id5.eq.5.and.id1.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TsT -- aa=u3_1256(i1,i2,i5,i6).a,bb=u3_1256(i1,i2,i5,i6).b,cc=u3_1256(
* i1,i2,i5,i6).c,dd=u3_1256(i1,i2,i5,i6).d,a1=l3_56(i5,i6).a,b1=l3_56(i5
* ,i6).b,c1=l3_56(i5,i6).c,d1=l3_56(i5,i6).d,a2=u356_12(i1,i2).a,b2=u356
* _12(i1,i2).b,c2=u356_12(i1,i2).c,d2=u356_12(i1,i2).d,prq=p356q,m=rmass
* (id3),nsum=1
      do iut=1,2
      cx1=l3_56(i5,i6).a(iut,1)+l3_56(i5,i6).c(iut,1)*rmass(id3)
      cx2=l3_56(i5,i6).c(iut,2)*p356q+l3_56(i5,i6).a(iut,2)*rmas
     & s(id3)
      cy1=l3_56(i5,i6).b(iut,1)+l3_56(i5,i6).d(iut,1)*rmass(id3)
      cy2=l3_56(i5,i6).d(iut,2)*p356q+l3_56(i5,i6).b(iut,2)*rmas
     & s(id3)
      cw1=l3_56(i5,i6).c(iut,1)*p356q+l3_56(i5,i6).a(iut,1)*rmas
     & s(id3)
      cw2=l3_56(i5,i6).a(iut,2)+l3_56(i5,i6).c(iut,2)*rmass(id3)
      cz1=l3_56(i5,i6).d(iut,1)*p356q+l3_56(i5,i6).b(iut,1)*rmas
     & s(id3)
      cz2=l3_56(i5,i6).b(iut,2)+l3_56(i5,i6).d(iut,2)*rmass(id3)
      u3_1256(i1,i2,i5,i6).a(iut,1)=u3_1256(i1,i2,i5,i6).a(iut,1
     & )+cx1*u356_12(i1,i2).a(1,1)+cx2*u356_12(i1,i2).b(2,1)
      u3_1256(i1,i2,i5,i6).b(iut,1)=u3_1256(i1,i2,i5,i6).b(iut,1
     & )+cy1*u356_12(i1,i2).a(1,1)+cy2*u356_12(i1,i2).b(2,1)
      u3_1256(i1,i2,i5,i6).c(iut,1)=u3_1256(i1,i2,i5,i6).c(iut,1
     & )+cw1*u356_12(i1,i2).d(1,1)+cw2*u356_12(i1,i2).c(2,1)
      u3_1256(i1,i2,i5,i6).d(iut,1)=u3_1256(i1,i2,i5,i6).d(iut,1
     & )+cz1*u356_12(i1,i2).d(1,1)+cz2*u356_12(i1,i2).c(2,1)
      u3_1256(i1,i2,i5,i6).a(iut,2)=u3_1256(i1,i2,i5,i6).a(iut,2
     & )+cw1*u356_12(i1,i2).b(1,2)+cw2*u356_12(i1,i2).a(2,2)
      u3_1256(i1,i2,i5,i6).b(iut,2)=u3_1256(i1,i2,i5,i6).b(iut,2
     & )+cz1*u356_12(i1,i2).b(1,2)+cz2*u356_12(i1,i2).a(2,2)
      u3_1256(i1,i2,i5,i6).c(iut,2)=u3_1256(i1,i2,i5,i6).c(iut,2
     & )+cx1*u356_12(i1,i2).c(1,2)+cx2*u356_12(i1,i2).d(2,2)
      u3_1256(i1,i2,i5,i6).d(iut,2)=u3_1256(i1,i2,i5,i6).d(iut,2
     & )+cy1*u356_12(i1,i2).c(1,2)+cy2*u356_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id3.eq.5.and.id5.ne.5.and.id1.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TTs -- aa=u3_1256(i1,i2,i5,i6).a,bb=u3_1256(i1,i2,i5,i6).b,cc=u3_1256(
* i1,i2,i5,i6).c,dd=u3_1256(i1,i2,i5,i6).d,a1=l3_56(i5,i6).a,b1=l3_56(i5
* ,i6).b,c1=l3_56(i5,i6).c,d1=l3_56(i5,i6).d,a2=u356_12(i1,i2).a,b2=u356
* _12(i1,i2).b,c2=u356_12(i1,i2).c,d2=u356_12(i1,i2).d,prq=p356q,m=rmass
* (id3),nsum=1
      do jut=1,2
      cx1=u356_12(i1,i2).a(1,jut)+rmass(id3)*u356_12(i1,i2).b(1,
     & jut)
      cx2=u356_12(i1,i2).a(2,jut)+rmass(id3)*u356_12(i1,i2).b(2,
     & jut)
      cy1=p356q*u356_12(i1,i2).b(1,jut)+rmass(id3)*u356_12(i1,i2
     & ).a(1,jut)
      cy2=p356q*u356_12(i1,i2).b(2,jut)+rmass(id3)*u356_12(i1,i2
     & ).a(2,jut)
      cw1=u356_12(i1,i2).c(1,jut)+rmass(id3)*u356_12(i1,i2).d(1,
     & jut)
      cw2=u356_12(i1,i2).c(2,jut)+rmass(id3)*u356_12(i1,i2).d(2,
     & jut)
      cz1=p356q*u356_12(i1,i2).d(1,jut)+rmass(id3)*u356_12(i1,i2
     & ).c(1,jut)
      cz2=p356q*u356_12(i1,i2).d(2,jut)+rmass(id3)*u356_12(i1,i2
     & ).c(2,jut)
      u3_1256(i1,i2,i5,i6).a(1,jut)=u3_1256(i1,i2,i5,i6).a(1,jut
     & )+l3_56(i5,i6).a(1,1)*cx1+l3_56(i5,i6).c(1,2)*cy2
      u3_1256(i1,i2,i5,i6).b(1,jut)=u3_1256(i1,i2,i5,i6).b(1,jut
     & )+l3_56(i5,i6).d(1,1)*cy1+l3_56(i5,i6).b(1,2)*cx2
      u3_1256(i1,i2,i5,i6).c(1,jut)=u3_1256(i1,i2,i5,i6).c(1,jut
     & )+l3_56(i5,i6).a(1,1)*cw1+l3_56(i5,i6).c(1,2)*cz2
      u3_1256(i1,i2,i5,i6).d(1,jut)=u3_1256(i1,i2,i5,i6).d(1,jut
     & )+l3_56(i5,i6).d(1,1)*cz1+l3_56(i5,i6).b(1,2)*cw2
      u3_1256(i1,i2,i5,i6).a(2,jut)=u3_1256(i1,i2,i5,i6).a(2,jut
     & )+l3_56(i5,i6).c(2,1)*cy1+l3_56(i5,i6).a(2,2)*cx2
      u3_1256(i1,i2,i5,i6).b(2,jut)=u3_1256(i1,i2,i5,i6).b(2,jut
     & )+l3_56(i5,i6).b(2,1)*cx1+l3_56(i5,i6).d(2,2)*cy2
      u3_1256(i1,i2,i5,i6).c(2,jut)=u3_1256(i1,i2,i5,i6).c(2,jut
     & )+l3_56(i5,i6).c(2,1)*cz1+l3_56(i5,i6).a(2,2)*cw2
      u3_1256(i1,i2,i5,i6).d(2,jut)=u3_1256(i1,i2,i5,i6).d(2,jut
     & )+l3_56(i5,i6).b(2,1)*cw1+l3_56(i5,i6).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p312q,p=p312,q=p312,bef=,aft=
      p312q=(p312(0)*p312(0)-p312(1)*p312(1)-p312(2)*p312(2)-p31
     & 2(3)*p312(3))
  
      if(id3.ne.5.or.(id1.ne.5.and.id7.ne.5))then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=u3_1278(i1,i2,i7,i8).a,bb=u3_1278(i1,i2,i7,i8).b,cc=u3_1278(i
* 1,i2,i7,i8).c,dd=u3_1278(i1,i2,i7,i8).d,a1=l3_12(i1,i2).a,b1=l3_12(i1,
* i2).b,c1=l3_12(i1,i2).c,d1=l3_12(i1,i2).d,a2=u312_78(i7,i8).a,b2=u312_
* 78(i7,i8).b,c2=u312_78(i7,i8).c,d2=u312_78(i7,i8).d,prq=p312q,m=rmass(
* id3),nsum=1
      u3_1278(i1,i2,i7,i8).a(1,1)=u3_1278(i1,i2,i7,i8).a(1,1)+l3
     & _12(i1,i2).a(1,1)*u312_78(i7,i8).a(1,1)+l3_12(i1,i2).c(1,
     & 2)*p312q*u312_78(i7,i8).b(2,1)
      u3_1278(i1,i2,i7,i8).b(1,1)=u3_1278(i1,i2,i7,i8).b(1,1)+rm
     & ass(id3)*(l3_12(i1,i2).d(1,1)*u312_78(i7,i8).a(1,1)+l3_12
     & (i1,i2).b(1,2)*u312_78(i7,i8).b(2,1))
      u3_1278(i1,i2,i7,i8).c(1,1)=u3_1278(i1,i2,i7,i8).c(1,1)+rm
     & ass(id3)*(l3_12(i1,i2).a(1,1)*u312_78(i7,i8).d(1,1)+l3_12
     & (i1,i2).c(1,2)*u312_78(i7,i8).c(2,1))
      u3_1278(i1,i2,i7,i8).d(1,1)=u3_1278(i1,i2,i7,i8).d(1,1)+l3
     & _12(i1,i2).d(1,1)*p312q*u312_78(i7,i8).d(1,1)+l3_12(i1,i2
     & ).b(1,2)*u312_78(i7,i8).c(2,1)
      u3_1278(i1,i2,i7,i8).a(1,2)=u3_1278(i1,i2,i7,i8).a(1,2)+rm
     & ass(id3)*(l3_12(i1,i2).a(1,1)*u312_78(i7,i8).b(1,2)+l3_12
     & (i1,i2).c(1,2)*u312_78(i7,i8).a(2,2))
      u3_1278(i1,i2,i7,i8).b(1,2)=u3_1278(i1,i2,i7,i8).b(1,2)+l3
     & _12(i1,i2).d(1,1)*p312q*u312_78(i7,i8).b(1,2)+l3_12(i1,i2
     & ).b(1,2)*u312_78(i7,i8).a(2,2)
      u3_1278(i1,i2,i7,i8).c(1,2)=u3_1278(i1,i2,i7,i8).c(1,2)+l3
     & _12(i1,i2).a(1,1)*u312_78(i7,i8).c(1,2)+l3_12(i1,i2).c(1,
     & 2)*p312q*u312_78(i7,i8).d(2,2)
      u3_1278(i1,i2,i7,i8).d(1,2)=u3_1278(i1,i2,i7,i8).d(1,2)+rm
     & ass(id3)*(l3_12(i1,i2).d(1,1)*u312_78(i7,i8).c(1,2)+l3_12
     & (i1,i2).b(1,2)*u312_78(i7,i8).d(2,2))
      u3_1278(i1,i2,i7,i8).a(2,1)=u3_1278(i1,i2,i7,i8).a(2,1)+rm
     & ass(id3)*(l3_12(i1,i2).c(2,1)*u312_78(i7,i8).a(1,1)+l3_12
     & (i1,i2).a(2,2)*u312_78(i7,i8).b(2,1))
      u3_1278(i1,i2,i7,i8).b(2,1)=u3_1278(i1,i2,i7,i8).b(2,1)+l3
     & _12(i1,i2).b(2,1)*u312_78(i7,i8).a(1,1)+l3_12(i1,i2).d(2,
     & 2)*p312q*u312_78(i7,i8).b(2,1)
      u3_1278(i1,i2,i7,i8).c(2,1)=u3_1278(i1,i2,i7,i8).c(2,1)+l3
     & _12(i1,i2).c(2,1)*p312q*u312_78(i7,i8).d(1,1)+l3_12(i1,i2
     & ).a(2,2)*u312_78(i7,i8).c(2,1)
      u3_1278(i1,i2,i7,i8).d(2,1)=u3_1278(i1,i2,i7,i8).d(2,1)+rm
     & ass(id3)*(l3_12(i1,i2).b(2,1)*u312_78(i7,i8).d(1,1)+l3_12
     & (i1,i2).d(2,2)*u312_78(i7,i8).c(2,1))
      u3_1278(i1,i2,i7,i8).a(2,2)=u3_1278(i1,i2,i7,i8).a(2,2)+l3
     & _12(i1,i2).c(2,1)*p312q*u312_78(i7,i8).b(1,2)+l3_12(i1,i2
     & ).a(2,2)*u312_78(i7,i8).a(2,2)
      u3_1278(i1,i2,i7,i8).b(2,2)=u3_1278(i1,i2,i7,i8).b(2,2)+rm
     & ass(id3)*(l3_12(i1,i2).b(2,1)*u312_78(i7,i8).b(1,2)+l3_12
     & (i1,i2).d(2,2)*u312_78(i7,i8).a(2,2))
      u3_1278(i1,i2,i7,i8).c(2,2)=u3_1278(i1,i2,i7,i8).c(2,2)+rm
     & ass(id3)*(l3_12(i1,i2).c(2,1)*u312_78(i7,i8).c(1,2)+l3_12
     & (i1,i2).a(2,2)*u312_78(i7,i8).d(2,2))
      u3_1278(i1,i2,i7,i8).d(2,2)=u3_1278(i1,i2,i7,i8).d(2,2)+l3
     & _12(i1,i2).b(2,1)*u312_78(i7,i8).c(1,2)+l3_12(i1,i2).d(2,
     & 2)*p312q*u312_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id3.eq.5.and.id1.eq.5.and.id7.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=u3_1278(i1,i2,i7,i8).a,bb=u3_1278(i1,i2,i7,i8).b,cc=u3_1278
* (i1,i2,i7,i8).c,dd=u3_1278(i1,i2,i7,i8).d,a1=l3_12(i1,i2).a,b1=l3_12(i
* 1,i2).b,c1=l3_12(i1,i2).c,d1=l3_12(i1,i2).d,a2=u312_78(i7,i8).a,b2=u31
* 2_78(i7,i8).b,c2=u312_78(i7,i8).c,d2=u312_78(i7,i8).d,prq=p312q,m=rmas
* s(id3),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u312_78(i7,i8).a(1,jut)+rmass(id3)*u312_78(i7,i8).b(1,
     & jut)
      cx2=u312_78(i7,i8).a(2,jut)+rmass(id3)*u312_78(i7,i8).b(2,
     & jut)
      cy1=p312q*u312_78(i7,i8).b(1,jut)+rmass(id3)*u312_78(i7,i8
     & ).a(1,jut)
      cy2=p312q*u312_78(i7,i8).b(2,jut)+rmass(id3)*u312_78(i7,i8
     & ).a(2,jut)
      u3_1278(i1,i2,i7,i8).a(iut,jut)=u3_1278(i1,i2,i7,i8).a(iut
     & ,jut)+l3_12(i1,i2).a(iut,1)*cx1+l3_12(i1,i2).c(iut,1)*cy1
     & +l3_12(i1,i2).a(iut,2)*cx2+l3_12(i1,i2).c(iut,2)*cy2
      u3_1278(i1,i2,i7,i8).b(iut,jut)=u3_1278(i1,i2,i7,i8).b(iut
     & ,jut)+l3_12(i1,i2).b(iut,1)*cx1+l3_12(i1,i2).d(iut,1)*cy1
     & +l3_12(i1,i2).b(iut,2)*cx2+l3_12(i1,i2).d(iut,2)*cy2
      cw1=u312_78(i7,i8).c(1,jut)+rmass(id3)*u312_78(i7,i8).d(1,
     & jut)
      cw2=u312_78(i7,i8).c(2,jut)+rmass(id3)*u312_78(i7,i8).d(2,
     & jut)
      cz1=p312q*u312_78(i7,i8).d(1,jut)+rmass(id3)*u312_78(i7,i8
     & ).c(1,jut)
      cz2=p312q*u312_78(i7,i8).d(2,jut)+rmass(id3)*u312_78(i7,i8
     & ).c(2,jut)
      u3_1278(i1,i2,i7,i8).c(iut,jut)=u3_1278(i1,i2,i7,i8).c(iut
     & ,jut)+l3_12(i1,i2).a(iut,1)*cw1+l3_12(i1,i2).c(iut,1)*cz1
     & +l3_12(i1,i2).a(iut,2)*cw2+l3_12(i1,i2).c(iut,2)*cz2
      u3_1278(i1,i2,i7,i8).d(iut,jut)=u3_1278(i1,i2,i7,i8).d(iut
     & ,jut)+l3_12(i1,i2).b(iut,1)*cw1+l3_12(i1,i2).d(iut,1)*cz1
     & +l3_12(i1,i2).b(iut,2)*cw2+l3_12(i1,i2).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id3.eq.5.and.id1.eq.5.and.id7.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=u3_1278(i1,i2,i7,i8).a,bb=u3_1278(i1,i2,i7,i8).b,cc=u3_1278(
* i1,i2,i7,i8).c,dd=u3_1278(i1,i2,i7,i8).d,a1=l3_12(i1,i2).a,b1=l3_12(i1
* ,i2).b,c1=l3_12(i1,i2).c,d1=l3_12(i1,i2).d,a2=u312_78(i7,i8).a,b2=u312
* _78(i7,i8).b,c2=u312_78(i7,i8).c,d2=u312_78(i7,i8).d,prq=p312q,m=rmass
* (id3),nsum=1
      do iut=1,2
      cx1=l3_12(i1,i2).a(iut,1)+l3_12(i1,i2).c(iut,1)*rmass(id3)
      cx2=l3_12(i1,i2).c(iut,2)*p312q+l3_12(i1,i2).a(iut,2)*rmas
     & s(id3)
      cy1=l3_12(i1,i2).b(iut,1)+l3_12(i1,i2).d(iut,1)*rmass(id3)
      cy2=l3_12(i1,i2).d(iut,2)*p312q+l3_12(i1,i2).b(iut,2)*rmas
     & s(id3)
      cw1=l3_12(i1,i2).c(iut,1)*p312q+l3_12(i1,i2).a(iut,1)*rmas
     & s(id3)
      cw2=l3_12(i1,i2).a(iut,2)+l3_12(i1,i2).c(iut,2)*rmass(id3)
      cz1=l3_12(i1,i2).d(iut,1)*p312q+l3_12(i1,i2).b(iut,1)*rmas
     & s(id3)
      cz2=l3_12(i1,i2).b(iut,2)+l3_12(i1,i2).d(iut,2)*rmass(id3)
      u3_1278(i1,i2,i7,i8).a(iut,1)=u3_1278(i1,i2,i7,i8).a(iut,1
     & )+cx1*u312_78(i7,i8).a(1,1)+cx2*u312_78(i7,i8).b(2,1)
      u3_1278(i1,i2,i7,i8).b(iut,1)=u3_1278(i1,i2,i7,i8).b(iut,1
     & )+cy1*u312_78(i7,i8).a(1,1)+cy2*u312_78(i7,i8).b(2,1)
      u3_1278(i1,i2,i7,i8).c(iut,1)=u3_1278(i1,i2,i7,i8).c(iut,1
     & )+cw1*u312_78(i7,i8).d(1,1)+cw2*u312_78(i7,i8).c(2,1)
      u3_1278(i1,i2,i7,i8).d(iut,1)=u3_1278(i1,i2,i7,i8).d(iut,1
     & )+cz1*u312_78(i7,i8).d(1,1)+cz2*u312_78(i7,i8).c(2,1)
      u3_1278(i1,i2,i7,i8).a(iut,2)=u3_1278(i1,i2,i7,i8).a(iut,2
     & )+cw1*u312_78(i7,i8).b(1,2)+cw2*u312_78(i7,i8).a(2,2)
      u3_1278(i1,i2,i7,i8).b(iut,2)=u3_1278(i1,i2,i7,i8).b(iut,2
     & )+cz1*u312_78(i7,i8).b(1,2)+cz2*u312_78(i7,i8).a(2,2)
      u3_1278(i1,i2,i7,i8).c(iut,2)=u3_1278(i1,i2,i7,i8).c(iut,2
     & )+cx1*u312_78(i7,i8).c(1,2)+cx2*u312_78(i7,i8).d(2,2)
      u3_1278(i1,i2,i7,i8).d(iut,2)=u3_1278(i1,i2,i7,i8).d(iut,2
     & )+cy1*u312_78(i7,i8).c(1,2)+cy2*u312_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id3.eq.5.and.id1.ne.5.and.id7.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TTs -- aa=u3_1278(i1,i2,i7,i8).a,bb=u3_1278(i1,i2,i7,i8).b,cc=u3_1278(
* i1,i2,i7,i8).c,dd=u3_1278(i1,i2,i7,i8).d,a1=l3_12(i1,i2).a,b1=l3_12(i1
* ,i2).b,c1=l3_12(i1,i2).c,d1=l3_12(i1,i2).d,a2=u312_78(i7,i8).a,b2=u312
* _78(i7,i8).b,c2=u312_78(i7,i8).c,d2=u312_78(i7,i8).d,prq=p312q,m=rmass
* (id3),nsum=1
      do jut=1,2
      cx1=u312_78(i7,i8).a(1,jut)+rmass(id3)*u312_78(i7,i8).b(1,
     & jut)
      cx2=u312_78(i7,i8).a(2,jut)+rmass(id3)*u312_78(i7,i8).b(2,
     & jut)
      cy1=p312q*u312_78(i7,i8).b(1,jut)+rmass(id3)*u312_78(i7,i8
     & ).a(1,jut)
      cy2=p312q*u312_78(i7,i8).b(2,jut)+rmass(id3)*u312_78(i7,i8
     & ).a(2,jut)
      cw1=u312_78(i7,i8).c(1,jut)+rmass(id3)*u312_78(i7,i8).d(1,
     & jut)
      cw2=u312_78(i7,i8).c(2,jut)+rmass(id3)*u312_78(i7,i8).d(2,
     & jut)
      cz1=p312q*u312_78(i7,i8).d(1,jut)+rmass(id3)*u312_78(i7,i8
     & ).c(1,jut)
      cz2=p312q*u312_78(i7,i8).d(2,jut)+rmass(id3)*u312_78(i7,i8
     & ).c(2,jut)
      u3_1278(i1,i2,i7,i8).a(1,jut)=u3_1278(i1,i2,i7,i8).a(1,jut
     & )+l3_12(i1,i2).a(1,1)*cx1+l3_12(i1,i2).c(1,2)*cy2
      u3_1278(i1,i2,i7,i8).b(1,jut)=u3_1278(i1,i2,i7,i8).b(1,jut
     & )+l3_12(i1,i2).d(1,1)*cy1+l3_12(i1,i2).b(1,2)*cx2
      u3_1278(i1,i2,i7,i8).c(1,jut)=u3_1278(i1,i2,i7,i8).c(1,jut
     & )+l3_12(i1,i2).a(1,1)*cw1+l3_12(i1,i2).c(1,2)*cz2
      u3_1278(i1,i2,i7,i8).d(1,jut)=u3_1278(i1,i2,i7,i8).d(1,jut
     & )+l3_12(i1,i2).d(1,1)*cz1+l3_12(i1,i2).b(1,2)*cw2
      u3_1278(i1,i2,i7,i8).a(2,jut)=u3_1278(i1,i2,i7,i8).a(2,jut
     & )+l3_12(i1,i2).c(2,1)*cy1+l3_12(i1,i2).a(2,2)*cx2
      u3_1278(i1,i2,i7,i8).b(2,jut)=u3_1278(i1,i2,i7,i8).b(2,jut
     & )+l3_12(i1,i2).b(2,1)*cx1+l3_12(i1,i2).d(2,2)*cy2
      u3_1278(i1,i2,i7,i8).c(2,jut)=u3_1278(i1,i2,i7,i8).c(2,jut
     & )+l3_12(i1,i2).c(2,1)*cz1+l3_12(i1,i2).a(2,2)*cw2
      u3_1278(i1,i2,i7,i8).d(2,jut)=u3_1278(i1,i2,i7,i8).d(2,jut
     & )+l3_12(i1,i2).b(2,1)*cw1+l3_12(i1,i2).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p378q,p=p378,q=p378,bef=,aft=
      p378q=(p378(0)*p378(0)-p378(1)*p378(1)-p378(2)*p378(2)-p37
     & 8(3)*p378(3))
  
      if(id3.ne.5.or.(id7.ne.5.and.id1.ne.5))then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=u3_1278(i1,i2,i7,i8).a,bb=u3_1278(i1,i2,i7,i8).b,cc=u3_1278(i
* 1,i2,i7,i8).c,dd=u3_1278(i1,i2,i7,i8).d,a1=l3_78(i7,i8).a,b1=l3_78(i7,
* i8).b,c1=l3_78(i7,i8).c,d1=l3_78(i7,i8).d,a2=u378_12(i1,i2).a,b2=u378_
* 12(i1,i2).b,c2=u378_12(i1,i2).c,d2=u378_12(i1,i2).d,prq=p378q,m=rmass(
* id3),nsum=1
      u3_1278(i1,i2,i7,i8).a(1,1)=u3_1278(i1,i2,i7,i8).a(1,1)+l3
     & _78(i7,i8).a(1,1)*u378_12(i1,i2).a(1,1)+l3_78(i7,i8).c(1,
     & 2)*p378q*u378_12(i1,i2).b(2,1)
      u3_1278(i1,i2,i7,i8).b(1,1)=u3_1278(i1,i2,i7,i8).b(1,1)+rm
     & ass(id3)*(l3_78(i7,i8).d(1,1)*u378_12(i1,i2).a(1,1)+l3_78
     & (i7,i8).b(1,2)*u378_12(i1,i2).b(2,1))
      u3_1278(i1,i2,i7,i8).c(1,1)=u3_1278(i1,i2,i7,i8).c(1,1)+rm
     & ass(id3)*(l3_78(i7,i8).a(1,1)*u378_12(i1,i2).d(1,1)+l3_78
     & (i7,i8).c(1,2)*u378_12(i1,i2).c(2,1))
      u3_1278(i1,i2,i7,i8).d(1,1)=u3_1278(i1,i2,i7,i8).d(1,1)+l3
     & _78(i7,i8).d(1,1)*p378q*u378_12(i1,i2).d(1,1)+l3_78(i7,i8
     & ).b(1,2)*u378_12(i1,i2).c(2,1)
      u3_1278(i1,i2,i7,i8).a(1,2)=u3_1278(i1,i2,i7,i8).a(1,2)+rm
     & ass(id3)*(l3_78(i7,i8).a(1,1)*u378_12(i1,i2).b(1,2)+l3_78
     & (i7,i8).c(1,2)*u378_12(i1,i2).a(2,2))
      u3_1278(i1,i2,i7,i8).b(1,2)=u3_1278(i1,i2,i7,i8).b(1,2)+l3
     & _78(i7,i8).d(1,1)*p378q*u378_12(i1,i2).b(1,2)+l3_78(i7,i8
     & ).b(1,2)*u378_12(i1,i2).a(2,2)
      u3_1278(i1,i2,i7,i8).c(1,2)=u3_1278(i1,i2,i7,i8).c(1,2)+l3
     & _78(i7,i8).a(1,1)*u378_12(i1,i2).c(1,2)+l3_78(i7,i8).c(1,
     & 2)*p378q*u378_12(i1,i2).d(2,2)
      u3_1278(i1,i2,i7,i8).d(1,2)=u3_1278(i1,i2,i7,i8).d(1,2)+rm
     & ass(id3)*(l3_78(i7,i8).d(1,1)*u378_12(i1,i2).c(1,2)+l3_78
     & (i7,i8).b(1,2)*u378_12(i1,i2).d(2,2))
      u3_1278(i1,i2,i7,i8).a(2,1)=u3_1278(i1,i2,i7,i8).a(2,1)+rm
     & ass(id3)*(l3_78(i7,i8).c(2,1)*u378_12(i1,i2).a(1,1)+l3_78
     & (i7,i8).a(2,2)*u378_12(i1,i2).b(2,1))
      u3_1278(i1,i2,i7,i8).b(2,1)=u3_1278(i1,i2,i7,i8).b(2,1)+l3
     & _78(i7,i8).b(2,1)*u378_12(i1,i2).a(1,1)+l3_78(i7,i8).d(2,
     & 2)*p378q*u378_12(i1,i2).b(2,1)
      u3_1278(i1,i2,i7,i8).c(2,1)=u3_1278(i1,i2,i7,i8).c(2,1)+l3
     & _78(i7,i8).c(2,1)*p378q*u378_12(i1,i2).d(1,1)+l3_78(i7,i8
     & ).a(2,2)*u378_12(i1,i2).c(2,1)
      u3_1278(i1,i2,i7,i8).d(2,1)=u3_1278(i1,i2,i7,i8).d(2,1)+rm
     & ass(id3)*(l3_78(i7,i8).b(2,1)*u378_12(i1,i2).d(1,1)+l3_78
     & (i7,i8).d(2,2)*u378_12(i1,i2).c(2,1))
      u3_1278(i1,i2,i7,i8).a(2,2)=u3_1278(i1,i2,i7,i8).a(2,2)+l3
     & _78(i7,i8).c(2,1)*p378q*u378_12(i1,i2).b(1,2)+l3_78(i7,i8
     & ).a(2,2)*u378_12(i1,i2).a(2,2)
      u3_1278(i1,i2,i7,i8).b(2,2)=u3_1278(i1,i2,i7,i8).b(2,2)+rm
     & ass(id3)*(l3_78(i7,i8).b(2,1)*u378_12(i1,i2).b(1,2)+l3_78
     & (i7,i8).d(2,2)*u378_12(i1,i2).a(2,2))
      u3_1278(i1,i2,i7,i8).c(2,2)=u3_1278(i1,i2,i7,i8).c(2,2)+rm
     & ass(id3)*(l3_78(i7,i8).c(2,1)*u378_12(i1,i2).c(1,2)+l3_78
     & (i7,i8).a(2,2)*u378_12(i1,i2).d(2,2))
      u3_1278(i1,i2,i7,i8).d(2,2)=u3_1278(i1,i2,i7,i8).d(2,2)+l3
     & _78(i7,i8).b(2,1)*u378_12(i1,i2).c(1,2)+l3_78(i7,i8).d(2,
     & 2)*p378q*u378_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id3.eq.5.and.id7.eq.5.and.id1.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=u3_1278(i1,i2,i7,i8).a,bb=u3_1278(i1,i2,i7,i8).b,cc=u3_1278
* (i1,i2,i7,i8).c,dd=u3_1278(i1,i2,i7,i8).d,a1=l3_78(i7,i8).a,b1=l3_78(i
* 7,i8).b,c1=l3_78(i7,i8).c,d1=l3_78(i7,i8).d,a2=u378_12(i1,i2).a,b2=u37
* 8_12(i1,i2).b,c2=u378_12(i1,i2).c,d2=u378_12(i1,i2).d,prq=p378q,m=rmas
* s(id3),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u378_12(i1,i2).a(1,jut)+rmass(id3)*u378_12(i1,i2).b(1,
     & jut)
      cx2=u378_12(i1,i2).a(2,jut)+rmass(id3)*u378_12(i1,i2).b(2,
     & jut)
      cy1=p378q*u378_12(i1,i2).b(1,jut)+rmass(id3)*u378_12(i1,i2
     & ).a(1,jut)
      cy2=p378q*u378_12(i1,i2).b(2,jut)+rmass(id3)*u378_12(i1,i2
     & ).a(2,jut)
      u3_1278(i1,i2,i7,i8).a(iut,jut)=u3_1278(i1,i2,i7,i8).a(iut
     & ,jut)+l3_78(i7,i8).a(iut,1)*cx1+l3_78(i7,i8).c(iut,1)*cy1
     & +l3_78(i7,i8).a(iut,2)*cx2+l3_78(i7,i8).c(iut,2)*cy2
      u3_1278(i1,i2,i7,i8).b(iut,jut)=u3_1278(i1,i2,i7,i8).b(iut
     & ,jut)+l3_78(i7,i8).b(iut,1)*cx1+l3_78(i7,i8).d(iut,1)*cy1
     & +l3_78(i7,i8).b(iut,2)*cx2+l3_78(i7,i8).d(iut,2)*cy2
      cw1=u378_12(i1,i2).c(1,jut)+rmass(id3)*u378_12(i1,i2).d(1,
     & jut)
      cw2=u378_12(i1,i2).c(2,jut)+rmass(id3)*u378_12(i1,i2).d(2,
     & jut)
      cz1=p378q*u378_12(i1,i2).d(1,jut)+rmass(id3)*u378_12(i1,i2
     & ).c(1,jut)
      cz2=p378q*u378_12(i1,i2).d(2,jut)+rmass(id3)*u378_12(i1,i2
     & ).c(2,jut)
      u3_1278(i1,i2,i7,i8).c(iut,jut)=u3_1278(i1,i2,i7,i8).c(iut
     & ,jut)+l3_78(i7,i8).a(iut,1)*cw1+l3_78(i7,i8).c(iut,1)*cz1
     & +l3_78(i7,i8).a(iut,2)*cw2+l3_78(i7,i8).c(iut,2)*cz2
      u3_1278(i1,i2,i7,i8).d(iut,jut)=u3_1278(i1,i2,i7,i8).d(iut
     & ,jut)+l3_78(i7,i8).b(iut,1)*cw1+l3_78(i7,i8).d(iut,1)*cz1
     & +l3_78(i7,i8).b(iut,2)*cw2+l3_78(i7,i8).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id3.eq.5.and.id7.eq.5.and.id1.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=u3_1278(i1,i2,i7,i8).a,bb=u3_1278(i1,i2,i7,i8).b,cc=u3_1278(
* i1,i2,i7,i8).c,dd=u3_1278(i1,i2,i7,i8).d,a1=l3_78(i7,i8).a,b1=l3_78(i7
* ,i8).b,c1=l3_78(i7,i8).c,d1=l3_78(i7,i8).d,a2=u378_12(i1,i2).a,b2=u378
* _12(i1,i2).b,c2=u378_12(i1,i2).c,d2=u378_12(i1,i2).d,prq=p378q,m=rmass
* (id3),nsum=1
      do iut=1,2
      cx1=l3_78(i7,i8).a(iut,1)+l3_78(i7,i8).c(iut,1)*rmass(id3)
      cx2=l3_78(i7,i8).c(iut,2)*p378q+l3_78(i7,i8).a(iut,2)*rmas
     & s(id3)
      cy1=l3_78(i7,i8).b(iut,1)+l3_78(i7,i8).d(iut,1)*rmass(id3)
      cy2=l3_78(i7,i8).d(iut,2)*p378q+l3_78(i7,i8).b(iut,2)*rmas
     & s(id3)
      cw1=l3_78(i7,i8).c(iut,1)*p378q+l3_78(i7,i8).a(iut,1)*rmas
     & s(id3)
      cw2=l3_78(i7,i8).a(iut,2)+l3_78(i7,i8).c(iut,2)*rmass(id3)
      cz1=l3_78(i7,i8).d(iut,1)*p378q+l3_78(i7,i8).b(iut,1)*rmas
     & s(id3)
      cz2=l3_78(i7,i8).b(iut,2)+l3_78(i7,i8).d(iut,2)*rmass(id3)
      u3_1278(i1,i2,i7,i8).a(iut,1)=u3_1278(i1,i2,i7,i8).a(iut,1
     & )+cx1*u378_12(i1,i2).a(1,1)+cx2*u378_12(i1,i2).b(2,1)
      u3_1278(i1,i2,i7,i8).b(iut,1)=u3_1278(i1,i2,i7,i8).b(iut,1
     & )+cy1*u378_12(i1,i2).a(1,1)+cy2*u378_12(i1,i2).b(2,1)
      u3_1278(i1,i2,i7,i8).c(iut,1)=u3_1278(i1,i2,i7,i8).c(iut,1
     & )+cw1*u378_12(i1,i2).d(1,1)+cw2*u378_12(i1,i2).c(2,1)
      u3_1278(i1,i2,i7,i8).d(iut,1)=u3_1278(i1,i2,i7,i8).d(iut,1
     & )+cz1*u378_12(i1,i2).d(1,1)+cz2*u378_12(i1,i2).c(2,1)
      u3_1278(i1,i2,i7,i8).a(iut,2)=u3_1278(i1,i2,i7,i8).a(iut,2
     & )+cw1*u378_12(i1,i2).b(1,2)+cw2*u378_12(i1,i2).a(2,2)
      u3_1278(i1,i2,i7,i8).b(iut,2)=u3_1278(i1,i2,i7,i8).b(iut,2
     & )+cz1*u378_12(i1,i2).b(1,2)+cz2*u378_12(i1,i2).a(2,2)
      u3_1278(i1,i2,i7,i8).c(iut,2)=u3_1278(i1,i2,i7,i8).c(iut,2
     & )+cx1*u378_12(i1,i2).c(1,2)+cx2*u378_12(i1,i2).d(2,2)
      u3_1278(i1,i2,i7,i8).d(iut,2)=u3_1278(i1,i2,i7,i8).d(iut,2
     & )+cy1*u378_12(i1,i2).c(1,2)+cy2*u378_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id3.eq.5.and.id7.ne.5.and.id1.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TTs -- aa=u3_1278(i1,i2,i7,i8).a,bb=u3_1278(i1,i2,i7,i8).b,cc=u3_1278(
* i1,i2,i7,i8).c,dd=u3_1278(i1,i2,i7,i8).d,a1=l3_78(i7,i8).a,b1=l3_78(i7
* ,i8).b,c1=l3_78(i7,i8).c,d1=l3_78(i7,i8).d,a2=u378_12(i1,i2).a,b2=u378
* _12(i1,i2).b,c2=u378_12(i1,i2).c,d2=u378_12(i1,i2).d,prq=p378q,m=rmass
* (id3),nsum=1
      do jut=1,2
      cx1=u378_12(i1,i2).a(1,jut)+rmass(id3)*u378_12(i1,i2).b(1,
     & jut)
      cx2=u378_12(i1,i2).a(2,jut)+rmass(id3)*u378_12(i1,i2).b(2,
     & jut)
      cy1=p378q*u378_12(i1,i2).b(1,jut)+rmass(id3)*u378_12(i1,i2
     & ).a(1,jut)
      cy2=p378q*u378_12(i1,i2).b(2,jut)+rmass(id3)*u378_12(i1,i2
     & ).a(2,jut)
      cw1=u378_12(i1,i2).c(1,jut)+rmass(id3)*u378_12(i1,i2).d(1,
     & jut)
      cw2=u378_12(i1,i2).c(2,jut)+rmass(id3)*u378_12(i1,i2).d(2,
     & jut)
      cz1=p378q*u378_12(i1,i2).d(1,jut)+rmass(id3)*u378_12(i1,i2
     & ).c(1,jut)
      cz2=p378q*u378_12(i1,i2).d(2,jut)+rmass(id3)*u378_12(i1,i2
     & ).c(2,jut)
      u3_1278(i1,i2,i7,i8).a(1,jut)=u3_1278(i1,i2,i7,i8).a(1,jut
     & )+l3_78(i7,i8).a(1,1)*cx1+l3_78(i7,i8).c(1,2)*cy2
      u3_1278(i1,i2,i7,i8).b(1,jut)=u3_1278(i1,i2,i7,i8).b(1,jut
     & )+l3_78(i7,i8).d(1,1)*cy1+l3_78(i7,i8).b(1,2)*cx2
      u3_1278(i1,i2,i7,i8).c(1,jut)=u3_1278(i1,i2,i7,i8).c(1,jut
     & )+l3_78(i7,i8).a(1,1)*cw1+l3_78(i7,i8).c(1,2)*cz2
      u3_1278(i1,i2,i7,i8).d(1,jut)=u3_1278(i1,i2,i7,i8).d(1,jut
     & )+l3_78(i7,i8).d(1,1)*cz1+l3_78(i7,i8).b(1,2)*cw2
      u3_1278(i1,i2,i7,i8).a(2,jut)=u3_1278(i1,i2,i7,i8).a(2,jut
     & )+l3_78(i7,i8).c(2,1)*cy1+l3_78(i7,i8).a(2,2)*cx2
      u3_1278(i1,i2,i7,i8).b(2,jut)=u3_1278(i1,i2,i7,i8).b(2,jut
     & )+l3_78(i7,i8).b(2,1)*cx1+l3_78(i7,i8).d(2,2)*cy2
      u3_1278(i1,i2,i7,i8).c(2,jut)=u3_1278(i1,i2,i7,i8).c(2,jut
     & )+l3_78(i7,i8).c(2,1)*cz1+l3_78(i7,i8).a(2,2)*cw2
      u3_1278(i1,i2,i7,i8).d(2,jut)=u3_1278(i1,i2,i7,i8).d(2,jut
     & )+l3_78(i7,i8).b(2,1)*cw1+l3_78(i7,i8).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p356q,p=p356,q=p356,bef=,aft=
      p356q=(p356(0)*p356(0)-p356(1)*p356(1)-p356(2)*p356(2)-p35
     & 6(3)*p356(3))
  
      if(id3.ne.5.or.(id5.ne.5.and.id7.ne.5))then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=u3_5678(i5,i6,i7,i8).a,bb=u3_5678(i5,i6,i7,i8).b,cc=u3_5678(i
* 5,i6,i7,i8).c,dd=u3_5678(i5,i6,i7,i8).d,a1=l3_56(i5,i6).a,b1=l3_56(i5,
* i6).b,c1=l3_56(i5,i6).c,d1=l3_56(i5,i6).d,a2=u356_78(i7,i8).a,b2=u356_
* 78(i7,i8).b,c2=u356_78(i7,i8).c,d2=u356_78(i7,i8).d,prq=p356q,m=rmass(
* id3),nsum=1
      u3_5678(i5,i6,i7,i8).a(1,1)=u3_5678(i5,i6,i7,i8).a(1,1)+l3
     & _56(i5,i6).a(1,1)*u356_78(i7,i8).a(1,1)+l3_56(i5,i6).c(1,
     & 2)*p356q*u356_78(i7,i8).b(2,1)
      u3_5678(i5,i6,i7,i8).b(1,1)=u3_5678(i5,i6,i7,i8).b(1,1)+rm
     & ass(id3)*(l3_56(i5,i6).d(1,1)*u356_78(i7,i8).a(1,1)+l3_56
     & (i5,i6).b(1,2)*u356_78(i7,i8).b(2,1))
      u3_5678(i5,i6,i7,i8).c(1,1)=u3_5678(i5,i6,i7,i8).c(1,1)+rm
     & ass(id3)*(l3_56(i5,i6).a(1,1)*u356_78(i7,i8).d(1,1)+l3_56
     & (i5,i6).c(1,2)*u356_78(i7,i8).c(2,1))
      u3_5678(i5,i6,i7,i8).d(1,1)=u3_5678(i5,i6,i7,i8).d(1,1)+l3
     & _56(i5,i6).d(1,1)*p356q*u356_78(i7,i8).d(1,1)+l3_56(i5,i6
     & ).b(1,2)*u356_78(i7,i8).c(2,1)
      u3_5678(i5,i6,i7,i8).a(1,2)=u3_5678(i5,i6,i7,i8).a(1,2)+rm
     & ass(id3)*(l3_56(i5,i6).a(1,1)*u356_78(i7,i8).b(1,2)+l3_56
     & (i5,i6).c(1,2)*u356_78(i7,i8).a(2,2))
      u3_5678(i5,i6,i7,i8).b(1,2)=u3_5678(i5,i6,i7,i8).b(1,2)+l3
     & _56(i5,i6).d(1,1)*p356q*u356_78(i7,i8).b(1,2)+l3_56(i5,i6
     & ).b(1,2)*u356_78(i7,i8).a(2,2)
      u3_5678(i5,i6,i7,i8).c(1,2)=u3_5678(i5,i6,i7,i8).c(1,2)+l3
     & _56(i5,i6).a(1,1)*u356_78(i7,i8).c(1,2)+l3_56(i5,i6).c(1,
     & 2)*p356q*u356_78(i7,i8).d(2,2)
      u3_5678(i5,i6,i7,i8).d(1,2)=u3_5678(i5,i6,i7,i8).d(1,2)+rm
     & ass(id3)*(l3_56(i5,i6).d(1,1)*u356_78(i7,i8).c(1,2)+l3_56
     & (i5,i6).b(1,2)*u356_78(i7,i8).d(2,2))
      u3_5678(i5,i6,i7,i8).a(2,1)=u3_5678(i5,i6,i7,i8).a(2,1)+rm
     & ass(id3)*(l3_56(i5,i6).c(2,1)*u356_78(i7,i8).a(1,1)+l3_56
     & (i5,i6).a(2,2)*u356_78(i7,i8).b(2,1))
      u3_5678(i5,i6,i7,i8).b(2,1)=u3_5678(i5,i6,i7,i8).b(2,1)+l3
     & _56(i5,i6).b(2,1)*u356_78(i7,i8).a(1,1)+l3_56(i5,i6).d(2,
     & 2)*p356q*u356_78(i7,i8).b(2,1)
      u3_5678(i5,i6,i7,i8).c(2,1)=u3_5678(i5,i6,i7,i8).c(2,1)+l3
     & _56(i5,i6).c(2,1)*p356q*u356_78(i7,i8).d(1,1)+l3_56(i5,i6
     & ).a(2,2)*u356_78(i7,i8).c(2,1)
      u3_5678(i5,i6,i7,i8).d(2,1)=u3_5678(i5,i6,i7,i8).d(2,1)+rm
     & ass(id3)*(l3_56(i5,i6).b(2,1)*u356_78(i7,i8).d(1,1)+l3_56
     & (i5,i6).d(2,2)*u356_78(i7,i8).c(2,1))
      u3_5678(i5,i6,i7,i8).a(2,2)=u3_5678(i5,i6,i7,i8).a(2,2)+l3
     & _56(i5,i6).c(2,1)*p356q*u356_78(i7,i8).b(1,2)+l3_56(i5,i6
     & ).a(2,2)*u356_78(i7,i8).a(2,2)
      u3_5678(i5,i6,i7,i8).b(2,2)=u3_5678(i5,i6,i7,i8).b(2,2)+rm
     & ass(id3)*(l3_56(i5,i6).b(2,1)*u356_78(i7,i8).b(1,2)+l3_56
     & (i5,i6).d(2,2)*u356_78(i7,i8).a(2,2))
      u3_5678(i5,i6,i7,i8).c(2,2)=u3_5678(i5,i6,i7,i8).c(2,2)+rm
     & ass(id3)*(l3_56(i5,i6).c(2,1)*u356_78(i7,i8).c(1,2)+l3_56
     & (i5,i6).a(2,2)*u356_78(i7,i8).d(2,2))
      u3_5678(i5,i6,i7,i8).d(2,2)=u3_5678(i5,i6,i7,i8).d(2,2)+l3
     & _56(i5,i6).b(2,1)*u356_78(i7,i8).c(1,2)+l3_56(i5,i6).d(2,
     & 2)*p356q*u356_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id3.eq.5.and.id5.eq.5.and.id7.eq.5)then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=u3_5678(i5,i6,i7,i8).a,bb=u3_5678(i5,i6,i7,i8).b,cc=u3_5678
* (i5,i6,i7,i8).c,dd=u3_5678(i5,i6,i7,i8).d,a1=l3_56(i5,i6).a,b1=l3_56(i
* 5,i6).b,c1=l3_56(i5,i6).c,d1=l3_56(i5,i6).d,a2=u356_78(i7,i8).a,b2=u35
* 6_78(i7,i8).b,c2=u356_78(i7,i8).c,d2=u356_78(i7,i8).d,prq=p356q,m=rmas
* s(id3),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u356_78(i7,i8).a(1,jut)+rmass(id3)*u356_78(i7,i8).b(1,
     & jut)
      cx2=u356_78(i7,i8).a(2,jut)+rmass(id3)*u356_78(i7,i8).b(2,
     & jut)
      cy1=p356q*u356_78(i7,i8).b(1,jut)+rmass(id3)*u356_78(i7,i8
     & ).a(1,jut)
      cy2=p356q*u356_78(i7,i8).b(2,jut)+rmass(id3)*u356_78(i7,i8
     & ).a(2,jut)
      u3_5678(i5,i6,i7,i8).a(iut,jut)=u3_5678(i5,i6,i7,i8).a(iut
     & ,jut)+l3_56(i5,i6).a(iut,1)*cx1+l3_56(i5,i6).c(iut,1)*cy1
     & +l3_56(i5,i6).a(iut,2)*cx2+l3_56(i5,i6).c(iut,2)*cy2
      u3_5678(i5,i6,i7,i8).b(iut,jut)=u3_5678(i5,i6,i7,i8).b(iut
     & ,jut)+l3_56(i5,i6).b(iut,1)*cx1+l3_56(i5,i6).d(iut,1)*cy1
     & +l3_56(i5,i6).b(iut,2)*cx2+l3_56(i5,i6).d(iut,2)*cy2
      cw1=u356_78(i7,i8).c(1,jut)+rmass(id3)*u356_78(i7,i8).d(1,
     & jut)
      cw2=u356_78(i7,i8).c(2,jut)+rmass(id3)*u356_78(i7,i8).d(2,
     & jut)
      cz1=p356q*u356_78(i7,i8).d(1,jut)+rmass(id3)*u356_78(i7,i8
     & ).c(1,jut)
      cz2=p356q*u356_78(i7,i8).d(2,jut)+rmass(id3)*u356_78(i7,i8
     & ).c(2,jut)
      u3_5678(i5,i6,i7,i8).c(iut,jut)=u3_5678(i5,i6,i7,i8).c(iut
     & ,jut)+l3_56(i5,i6).a(iut,1)*cw1+l3_56(i5,i6).c(iut,1)*cz1
     & +l3_56(i5,i6).a(iut,2)*cw2+l3_56(i5,i6).c(iut,2)*cz2
      u3_5678(i5,i6,i7,i8).d(iut,jut)=u3_5678(i5,i6,i7,i8).d(iut
     & ,jut)+l3_56(i5,i6).b(iut,1)*cw1+l3_56(i5,i6).d(iut,1)*cz1
     & +l3_56(i5,i6).b(iut,2)*cw2+l3_56(i5,i6).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id3.eq.5.and.id5.eq.5.and.id7.ne.5)then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=u3_5678(i5,i6,i7,i8).a,bb=u3_5678(i5,i6,i7,i8).b,cc=u3_5678(
* i5,i6,i7,i8).c,dd=u3_5678(i5,i6,i7,i8).d,a1=l3_56(i5,i6).a,b1=l3_56(i5
* ,i6).b,c1=l3_56(i5,i6).c,d1=l3_56(i5,i6).d,a2=u356_78(i7,i8).a,b2=u356
* _78(i7,i8).b,c2=u356_78(i7,i8).c,d2=u356_78(i7,i8).d,prq=p356q,m=rmass
* (id3),nsum=1
      do iut=1,2
      cx1=l3_56(i5,i6).a(iut,1)+l3_56(i5,i6).c(iut,1)*rmass(id3)
      cx2=l3_56(i5,i6).c(iut,2)*p356q+l3_56(i5,i6).a(iut,2)*rmas
     & s(id3)
      cy1=l3_56(i5,i6).b(iut,1)+l3_56(i5,i6).d(iut,1)*rmass(id3)
      cy2=l3_56(i5,i6).d(iut,2)*p356q+l3_56(i5,i6).b(iut,2)*rmas
     & s(id3)
      cw1=l3_56(i5,i6).c(iut,1)*p356q+l3_56(i5,i6).a(iut,1)*rmas
     & s(id3)
      cw2=l3_56(i5,i6).a(iut,2)+l3_56(i5,i6).c(iut,2)*rmass(id3)
      cz1=l3_56(i5,i6).d(iut,1)*p356q+l3_56(i5,i6).b(iut,1)*rmas
     & s(id3)
      cz2=l3_56(i5,i6).b(iut,2)+l3_56(i5,i6).d(iut,2)*rmass(id3)
      u3_5678(i5,i6,i7,i8).a(iut,1)=u3_5678(i5,i6,i7,i8).a(iut,1
     & )+cx1*u356_78(i7,i8).a(1,1)+cx2*u356_78(i7,i8).b(2,1)
      u3_5678(i5,i6,i7,i8).b(iut,1)=u3_5678(i5,i6,i7,i8).b(iut,1
     & )+cy1*u356_78(i7,i8).a(1,1)+cy2*u356_78(i7,i8).b(2,1)
      u3_5678(i5,i6,i7,i8).c(iut,1)=u3_5678(i5,i6,i7,i8).c(iut,1
     & )+cw1*u356_78(i7,i8).d(1,1)+cw2*u356_78(i7,i8).c(2,1)
      u3_5678(i5,i6,i7,i8).d(iut,1)=u3_5678(i5,i6,i7,i8).d(iut,1
     & )+cz1*u356_78(i7,i8).d(1,1)+cz2*u356_78(i7,i8).c(2,1)
      u3_5678(i5,i6,i7,i8).a(iut,2)=u3_5678(i5,i6,i7,i8).a(iut,2
     & )+cw1*u356_78(i7,i8).b(1,2)+cw2*u356_78(i7,i8).a(2,2)
      u3_5678(i5,i6,i7,i8).b(iut,2)=u3_5678(i5,i6,i7,i8).b(iut,2
     & )+cz1*u356_78(i7,i8).b(1,2)+cz2*u356_78(i7,i8).a(2,2)
      u3_5678(i5,i6,i7,i8).c(iut,2)=u3_5678(i5,i6,i7,i8).c(iut,2
     & )+cx1*u356_78(i7,i8).c(1,2)+cx2*u356_78(i7,i8).d(2,2)
      u3_5678(i5,i6,i7,i8).d(iut,2)=u3_5678(i5,i6,i7,i8).d(iut,2
     & )+cy1*u356_78(i7,i8).c(1,2)+cy2*u356_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id3.eq.5.and.id5.ne.5.and.id7.eq.5)then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TTs -- aa=u3_5678(i5,i6,i7,i8).a,bb=u3_5678(i5,i6,i7,i8).b,cc=u3_5678(
* i5,i6,i7,i8).c,dd=u3_5678(i5,i6,i7,i8).d,a1=l3_56(i5,i6).a,b1=l3_56(i5
* ,i6).b,c1=l3_56(i5,i6).c,d1=l3_56(i5,i6).d,a2=u356_78(i7,i8).a,b2=u356
* _78(i7,i8).b,c2=u356_78(i7,i8).c,d2=u356_78(i7,i8).d,prq=p356q,m=rmass
* (id3),nsum=1
      do jut=1,2
      cx1=u356_78(i7,i8).a(1,jut)+rmass(id3)*u356_78(i7,i8).b(1,
     & jut)
      cx2=u356_78(i7,i8).a(2,jut)+rmass(id3)*u356_78(i7,i8).b(2,
     & jut)
      cy1=p356q*u356_78(i7,i8).b(1,jut)+rmass(id3)*u356_78(i7,i8
     & ).a(1,jut)
      cy2=p356q*u356_78(i7,i8).b(2,jut)+rmass(id3)*u356_78(i7,i8
     & ).a(2,jut)
      cw1=u356_78(i7,i8).c(1,jut)+rmass(id3)*u356_78(i7,i8).d(1,
     & jut)
      cw2=u356_78(i7,i8).c(2,jut)+rmass(id3)*u356_78(i7,i8).d(2,
     & jut)
      cz1=p356q*u356_78(i7,i8).d(1,jut)+rmass(id3)*u356_78(i7,i8
     & ).c(1,jut)
      cz2=p356q*u356_78(i7,i8).d(2,jut)+rmass(id3)*u356_78(i7,i8
     & ).c(2,jut)
      u3_5678(i5,i6,i7,i8).a(1,jut)=u3_5678(i5,i6,i7,i8).a(1,jut
     & )+l3_56(i5,i6).a(1,1)*cx1+l3_56(i5,i6).c(1,2)*cy2
      u3_5678(i5,i6,i7,i8).b(1,jut)=u3_5678(i5,i6,i7,i8).b(1,jut
     & )+l3_56(i5,i6).d(1,1)*cy1+l3_56(i5,i6).b(1,2)*cx2
      u3_5678(i5,i6,i7,i8).c(1,jut)=u3_5678(i5,i6,i7,i8).c(1,jut
     & )+l3_56(i5,i6).a(1,1)*cw1+l3_56(i5,i6).c(1,2)*cz2
      u3_5678(i5,i6,i7,i8).d(1,jut)=u3_5678(i5,i6,i7,i8).d(1,jut
     & )+l3_56(i5,i6).d(1,1)*cz1+l3_56(i5,i6).b(1,2)*cw2
      u3_5678(i5,i6,i7,i8).a(2,jut)=u3_5678(i5,i6,i7,i8).a(2,jut
     & )+l3_56(i5,i6).c(2,1)*cy1+l3_56(i5,i6).a(2,2)*cx2
      u3_5678(i5,i6,i7,i8).b(2,jut)=u3_5678(i5,i6,i7,i8).b(2,jut
     & )+l3_56(i5,i6).b(2,1)*cx1+l3_56(i5,i6).d(2,2)*cy2
      u3_5678(i5,i6,i7,i8).c(2,jut)=u3_5678(i5,i6,i7,i8).c(2,jut
     & )+l3_56(i5,i6).c(2,1)*cz1+l3_56(i5,i6).a(2,2)*cw2
      u3_5678(i5,i6,i7,i8).d(2,jut)=u3_5678(i5,i6,i7,i8).d(2,jut
     & )+l3_56(i5,i6).b(2,1)*cw1+l3_56(i5,i6).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p378q,p=p378,q=p378,bef=,aft=
      p378q=(p378(0)*p378(0)-p378(1)*p378(1)-p378(2)*p378(2)-p37
     & 8(3)*p378(3))
  
      if(id3.ne.5.or.(id7.ne.5.and.id5.ne.5))then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=u3_5678(i5,i6,i7,i8).a,bb=u3_5678(i5,i6,i7,i8).b,cc=u3_5678(i
* 5,i6,i7,i8).c,dd=u3_5678(i5,i6,i7,i8).d,a1=l3_78(i7,i8).a,b1=l3_78(i7,
* i8).b,c1=l3_78(i7,i8).c,d1=l3_78(i7,i8).d,a2=u378_56(i5,i6).a,b2=u378_
* 56(i5,i6).b,c2=u378_56(i5,i6).c,d2=u378_56(i5,i6).d,prq=p378q,m=rmass(
* id3),nsum=1
      u3_5678(i5,i6,i7,i8).a(1,1)=u3_5678(i5,i6,i7,i8).a(1,1)+l3
     & _78(i7,i8).a(1,1)*u378_56(i5,i6).a(1,1)+l3_78(i7,i8).c(1,
     & 2)*p378q*u378_56(i5,i6).b(2,1)
      u3_5678(i5,i6,i7,i8).b(1,1)=u3_5678(i5,i6,i7,i8).b(1,1)+rm
     & ass(id3)*(l3_78(i7,i8).d(1,1)*u378_56(i5,i6).a(1,1)+l3_78
     & (i7,i8).b(1,2)*u378_56(i5,i6).b(2,1))
      u3_5678(i5,i6,i7,i8).c(1,1)=u3_5678(i5,i6,i7,i8).c(1,1)+rm
     & ass(id3)*(l3_78(i7,i8).a(1,1)*u378_56(i5,i6).d(1,1)+l3_78
     & (i7,i8).c(1,2)*u378_56(i5,i6).c(2,1))
      u3_5678(i5,i6,i7,i8).d(1,1)=u3_5678(i5,i6,i7,i8).d(1,1)+l3
     & _78(i7,i8).d(1,1)*p378q*u378_56(i5,i6).d(1,1)+l3_78(i7,i8
     & ).b(1,2)*u378_56(i5,i6).c(2,1)
      u3_5678(i5,i6,i7,i8).a(1,2)=u3_5678(i5,i6,i7,i8).a(1,2)+rm
     & ass(id3)*(l3_78(i7,i8).a(1,1)*u378_56(i5,i6).b(1,2)+l3_78
     & (i7,i8).c(1,2)*u378_56(i5,i6).a(2,2))
      u3_5678(i5,i6,i7,i8).b(1,2)=u3_5678(i5,i6,i7,i8).b(1,2)+l3
     & _78(i7,i8).d(1,1)*p378q*u378_56(i5,i6).b(1,2)+l3_78(i7,i8
     & ).b(1,2)*u378_56(i5,i6).a(2,2)
      u3_5678(i5,i6,i7,i8).c(1,2)=u3_5678(i5,i6,i7,i8).c(1,2)+l3
     & _78(i7,i8).a(1,1)*u378_56(i5,i6).c(1,2)+l3_78(i7,i8).c(1,
     & 2)*p378q*u378_56(i5,i6).d(2,2)
      u3_5678(i5,i6,i7,i8).d(1,2)=u3_5678(i5,i6,i7,i8).d(1,2)+rm
     & ass(id3)*(l3_78(i7,i8).d(1,1)*u378_56(i5,i6).c(1,2)+l3_78
     & (i7,i8).b(1,2)*u378_56(i5,i6).d(2,2))
      u3_5678(i5,i6,i7,i8).a(2,1)=u3_5678(i5,i6,i7,i8).a(2,1)+rm
     & ass(id3)*(l3_78(i7,i8).c(2,1)*u378_56(i5,i6).a(1,1)+l3_78
     & (i7,i8).a(2,2)*u378_56(i5,i6).b(2,1))
      u3_5678(i5,i6,i7,i8).b(2,1)=u3_5678(i5,i6,i7,i8).b(2,1)+l3
     & _78(i7,i8).b(2,1)*u378_56(i5,i6).a(1,1)+l3_78(i7,i8).d(2,
     & 2)*p378q*u378_56(i5,i6).b(2,1)
      u3_5678(i5,i6,i7,i8).c(2,1)=u3_5678(i5,i6,i7,i8).c(2,1)+l3
     & _78(i7,i8).c(2,1)*p378q*u378_56(i5,i6).d(1,1)+l3_78(i7,i8
     & ).a(2,2)*u378_56(i5,i6).c(2,1)
      u3_5678(i5,i6,i7,i8).d(2,1)=u3_5678(i5,i6,i7,i8).d(2,1)+rm
     & ass(id3)*(l3_78(i7,i8).b(2,1)*u378_56(i5,i6).d(1,1)+l3_78
     & (i7,i8).d(2,2)*u378_56(i5,i6).c(2,1))
      u3_5678(i5,i6,i7,i8).a(2,2)=u3_5678(i5,i6,i7,i8).a(2,2)+l3
     & _78(i7,i8).c(2,1)*p378q*u378_56(i5,i6).b(1,2)+l3_78(i7,i8
     & ).a(2,2)*u378_56(i5,i6).a(2,2)
      u3_5678(i5,i6,i7,i8).b(2,2)=u3_5678(i5,i6,i7,i8).b(2,2)+rm
     & ass(id3)*(l3_78(i7,i8).b(2,1)*u378_56(i5,i6).b(1,2)+l3_78
     & (i7,i8).d(2,2)*u378_56(i5,i6).a(2,2))
      u3_5678(i5,i6,i7,i8).c(2,2)=u3_5678(i5,i6,i7,i8).c(2,2)+rm
     & ass(id3)*(l3_78(i7,i8).c(2,1)*u378_56(i5,i6).c(1,2)+l3_78
     & (i7,i8).a(2,2)*u378_56(i5,i6).d(2,2))
      u3_5678(i5,i6,i7,i8).d(2,2)=u3_5678(i5,i6,i7,i8).d(2,2)+l3
     & _78(i7,i8).b(2,1)*u378_56(i5,i6).c(1,2)+l3_78(i7,i8).d(2,
     & 2)*p378q*u378_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id3.eq.5.and.id7.eq.5.and.id5.eq.5)then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=u3_5678(i5,i6,i7,i8).a,bb=u3_5678(i5,i6,i7,i8).b,cc=u3_5678
* (i5,i6,i7,i8).c,dd=u3_5678(i5,i6,i7,i8).d,a1=l3_78(i7,i8).a,b1=l3_78(i
* 7,i8).b,c1=l3_78(i7,i8).c,d1=l3_78(i7,i8).d,a2=u378_56(i5,i6).a,b2=u37
* 8_56(i5,i6).b,c2=u378_56(i5,i6).c,d2=u378_56(i5,i6).d,prq=p378q,m=rmas
* s(id3),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u378_56(i5,i6).a(1,jut)+rmass(id3)*u378_56(i5,i6).b(1,
     & jut)
      cx2=u378_56(i5,i6).a(2,jut)+rmass(id3)*u378_56(i5,i6).b(2,
     & jut)
      cy1=p378q*u378_56(i5,i6).b(1,jut)+rmass(id3)*u378_56(i5,i6
     & ).a(1,jut)
      cy2=p378q*u378_56(i5,i6).b(2,jut)+rmass(id3)*u378_56(i5,i6
     & ).a(2,jut)
      u3_5678(i5,i6,i7,i8).a(iut,jut)=u3_5678(i5,i6,i7,i8).a(iut
     & ,jut)+l3_78(i7,i8).a(iut,1)*cx1+l3_78(i7,i8).c(iut,1)*cy1
     & +l3_78(i7,i8).a(iut,2)*cx2+l3_78(i7,i8).c(iut,2)*cy2
      u3_5678(i5,i6,i7,i8).b(iut,jut)=u3_5678(i5,i6,i7,i8).b(iut
     & ,jut)+l3_78(i7,i8).b(iut,1)*cx1+l3_78(i7,i8).d(iut,1)*cy1
     & +l3_78(i7,i8).b(iut,2)*cx2+l3_78(i7,i8).d(iut,2)*cy2
      cw1=u378_56(i5,i6).c(1,jut)+rmass(id3)*u378_56(i5,i6).d(1,
     & jut)
      cw2=u378_56(i5,i6).c(2,jut)+rmass(id3)*u378_56(i5,i6).d(2,
     & jut)
      cz1=p378q*u378_56(i5,i6).d(1,jut)+rmass(id3)*u378_56(i5,i6
     & ).c(1,jut)
      cz2=p378q*u378_56(i5,i6).d(2,jut)+rmass(id3)*u378_56(i5,i6
     & ).c(2,jut)
      u3_5678(i5,i6,i7,i8).c(iut,jut)=u3_5678(i5,i6,i7,i8).c(iut
     & ,jut)+l3_78(i7,i8).a(iut,1)*cw1+l3_78(i7,i8).c(iut,1)*cz1
     & +l3_78(i7,i8).a(iut,2)*cw2+l3_78(i7,i8).c(iut,2)*cz2
      u3_5678(i5,i6,i7,i8).d(iut,jut)=u3_5678(i5,i6,i7,i8).d(iut
     & ,jut)+l3_78(i7,i8).b(iut,1)*cw1+l3_78(i7,i8).d(iut,1)*cz1
     & +l3_78(i7,i8).b(iut,2)*cw2+l3_78(i7,i8).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id3.eq.5.and.id7.eq.5.and.id5.ne.5)then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=u3_5678(i5,i6,i7,i8).a,bb=u3_5678(i5,i6,i7,i8).b,cc=u3_5678(
* i5,i6,i7,i8).c,dd=u3_5678(i5,i6,i7,i8).d,a1=l3_78(i7,i8).a,b1=l3_78(i7
* ,i8).b,c1=l3_78(i7,i8).c,d1=l3_78(i7,i8).d,a2=u378_56(i5,i6).a,b2=u378
* _56(i5,i6).b,c2=u378_56(i5,i6).c,d2=u378_56(i5,i6).d,prq=p378q,m=rmass
* (id3),nsum=1
      do iut=1,2
      cx1=l3_78(i7,i8).a(iut,1)+l3_78(i7,i8).c(iut,1)*rmass(id3)
      cx2=l3_78(i7,i8).c(iut,2)*p378q+l3_78(i7,i8).a(iut,2)*rmas
     & s(id3)
      cy1=l3_78(i7,i8).b(iut,1)+l3_78(i7,i8).d(iut,1)*rmass(id3)
      cy2=l3_78(i7,i8).d(iut,2)*p378q+l3_78(i7,i8).b(iut,2)*rmas
     & s(id3)
      cw1=l3_78(i7,i8).c(iut,1)*p378q+l3_78(i7,i8).a(iut,1)*rmas
     & s(id3)
      cw2=l3_78(i7,i8).a(iut,2)+l3_78(i7,i8).c(iut,2)*rmass(id3)
      cz1=l3_78(i7,i8).d(iut,1)*p378q+l3_78(i7,i8).b(iut,1)*rmas
     & s(id3)
      cz2=l3_78(i7,i8).b(iut,2)+l3_78(i7,i8).d(iut,2)*rmass(id3)
      u3_5678(i5,i6,i7,i8).a(iut,1)=u3_5678(i5,i6,i7,i8).a(iut,1
     & )+cx1*u378_56(i5,i6).a(1,1)+cx2*u378_56(i5,i6).b(2,1)
      u3_5678(i5,i6,i7,i8).b(iut,1)=u3_5678(i5,i6,i7,i8).b(iut,1
     & )+cy1*u378_56(i5,i6).a(1,1)+cy2*u378_56(i5,i6).b(2,1)
      u3_5678(i5,i6,i7,i8).c(iut,1)=u3_5678(i5,i6,i7,i8).c(iut,1
     & )+cw1*u378_56(i5,i6).d(1,1)+cw2*u378_56(i5,i6).c(2,1)
      u3_5678(i5,i6,i7,i8).d(iut,1)=u3_5678(i5,i6,i7,i8).d(iut,1
     & )+cz1*u378_56(i5,i6).d(1,1)+cz2*u378_56(i5,i6).c(2,1)
      u3_5678(i5,i6,i7,i8).a(iut,2)=u3_5678(i5,i6,i7,i8).a(iut,2
     & )+cw1*u378_56(i5,i6).b(1,2)+cw2*u378_56(i5,i6).a(2,2)
      u3_5678(i5,i6,i7,i8).b(iut,2)=u3_5678(i5,i6,i7,i8).b(iut,2
     & )+cz1*u378_56(i5,i6).b(1,2)+cz2*u378_56(i5,i6).a(2,2)
      u3_5678(i5,i6,i7,i8).c(iut,2)=u3_5678(i5,i6,i7,i8).c(iut,2
     & )+cx1*u378_56(i5,i6).c(1,2)+cx2*u378_56(i5,i6).d(2,2)
      u3_5678(i5,i6,i7,i8).d(iut,2)=u3_5678(i5,i6,i7,i8).d(iut,2
     & )+cy1*u378_56(i5,i6).c(1,2)+cy2*u378_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id3.eq.5.and.id7.ne.5.and.id5.eq.5)then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TTs -- aa=u3_5678(i5,i6,i7,i8).a,bb=u3_5678(i5,i6,i7,i8).b,cc=u3_5678(
* i5,i6,i7,i8).c,dd=u3_5678(i5,i6,i7,i8).d,a1=l3_78(i7,i8).a,b1=l3_78(i7
* ,i8).b,c1=l3_78(i7,i8).c,d1=l3_78(i7,i8).d,a2=u378_56(i5,i6).a,b2=u378
* _56(i5,i6).b,c2=u378_56(i5,i6).c,d2=u378_56(i5,i6).d,prq=p378q,m=rmass
* (id3),nsum=1
      do jut=1,2
      cx1=u378_56(i5,i6).a(1,jut)+rmass(id3)*u378_56(i5,i6).b(1,
     & jut)
      cx2=u378_56(i5,i6).a(2,jut)+rmass(id3)*u378_56(i5,i6).b(2,
     & jut)
      cy1=p378q*u378_56(i5,i6).b(1,jut)+rmass(id3)*u378_56(i5,i6
     & ).a(1,jut)
      cy2=p378q*u378_56(i5,i6).b(2,jut)+rmass(id3)*u378_56(i5,i6
     & ).a(2,jut)
      cw1=u378_56(i5,i6).c(1,jut)+rmass(id3)*u378_56(i5,i6).d(1,
     & jut)
      cw2=u378_56(i5,i6).c(2,jut)+rmass(id3)*u378_56(i5,i6).d(2,
     & jut)
      cz1=p378q*u378_56(i5,i6).d(1,jut)+rmass(id3)*u378_56(i5,i6
     & ).c(1,jut)
      cz2=p378q*u378_56(i5,i6).d(2,jut)+rmass(id3)*u378_56(i5,i6
     & ).c(2,jut)
      u3_5678(i5,i6,i7,i8).a(1,jut)=u3_5678(i5,i6,i7,i8).a(1,jut
     & )+l3_78(i7,i8).a(1,1)*cx1+l3_78(i7,i8).c(1,2)*cy2
      u3_5678(i5,i6,i7,i8).b(1,jut)=u3_5678(i5,i6,i7,i8).b(1,jut
     & )+l3_78(i7,i8).d(1,1)*cy1+l3_78(i7,i8).b(1,2)*cx2
      u3_5678(i5,i6,i7,i8).c(1,jut)=u3_5678(i5,i6,i7,i8).c(1,jut
     & )+l3_78(i7,i8).a(1,1)*cw1+l3_78(i7,i8).c(1,2)*cz2
      u3_5678(i5,i6,i7,i8).d(1,jut)=u3_5678(i5,i6,i7,i8).d(1,jut
     & )+l3_78(i7,i8).d(1,1)*cz1+l3_78(i7,i8).b(1,2)*cw2
      u3_5678(i5,i6,i7,i8).a(2,jut)=u3_5678(i5,i6,i7,i8).a(2,jut
     & )+l3_78(i7,i8).c(2,1)*cy1+l3_78(i7,i8).a(2,2)*cx2
      u3_5678(i5,i6,i7,i8).b(2,jut)=u3_5678(i5,i6,i7,i8).b(2,jut
     & )+l3_78(i7,i8).b(2,1)*cx1+l3_78(i7,i8).d(2,2)*cy2
      u3_5678(i5,i6,i7,i8).c(2,jut)=u3_5678(i5,i6,i7,i8).c(2,jut
     & )+l3_78(i7,i8).c(2,1)*cz1+l3_78(i7,i8).a(2,2)*cw2
      u3_5678(i5,i6,i7,i8).d(2,jut)=u3_5678(i5,i6,i7,i8).d(2,jut
     & )+l3_78(i7,i8).b(2,1)*cw1+l3_78(i7,i8).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p512q,p=p512,q=p512,bef=,aft=
      p512q=(p512(0)*p512(0)-p512(1)*p512(1)-p512(2)*p512(2)-p51
     & 2(3)*p512(3))
  
      if(id5.ne.5.or.(id1.ne.5.and.id3.ne.5))then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TT -- aa=u5_1234(i1,i2,i3,i4).a,bb=u5_1234(i1,i2,i3,i4).b,cc=u5_1234(i
* 1,i2,i3,i4).c,dd=u5_1234(i1,i2,i3,i4).d,a1=l5_12(i1,i2).a,b1=l5_12(i1,
* i2).b,c1=l5_12(i1,i2).c,d1=l5_12(i1,i2).d,a2=u512_34(i3,i4).a,b2=u512_
* 34(i3,i4).b,c2=u512_34(i3,i4).c,d2=u512_34(i3,i4).d,prq=p512q,m=rmass(
* id5),nsum=1
      u5_1234(i1,i2,i3,i4).a(1,1)=u5_1234(i1,i2,i3,i4).a(1,1)+l5
     & _12(i1,i2).a(1,1)*u512_34(i3,i4).a(1,1)+l5_12(i1,i2).c(1,
     & 2)*p512q*u512_34(i3,i4).b(2,1)
      u5_1234(i1,i2,i3,i4).b(1,1)=u5_1234(i1,i2,i3,i4).b(1,1)+rm
     & ass(id5)*(l5_12(i1,i2).d(1,1)*u512_34(i3,i4).a(1,1)+l5_12
     & (i1,i2).b(1,2)*u512_34(i3,i4).b(2,1))
      u5_1234(i1,i2,i3,i4).c(1,1)=u5_1234(i1,i2,i3,i4).c(1,1)+rm
     & ass(id5)*(l5_12(i1,i2).a(1,1)*u512_34(i3,i4).d(1,1)+l5_12
     & (i1,i2).c(1,2)*u512_34(i3,i4).c(2,1))
      u5_1234(i1,i2,i3,i4).d(1,1)=u5_1234(i1,i2,i3,i4).d(1,1)+l5
     & _12(i1,i2).d(1,1)*p512q*u512_34(i3,i4).d(1,1)+l5_12(i1,i2
     & ).b(1,2)*u512_34(i3,i4).c(2,1)
      u5_1234(i1,i2,i3,i4).a(1,2)=u5_1234(i1,i2,i3,i4).a(1,2)+rm
     & ass(id5)*(l5_12(i1,i2).a(1,1)*u512_34(i3,i4).b(1,2)+l5_12
     & (i1,i2).c(1,2)*u512_34(i3,i4).a(2,2))
      u5_1234(i1,i2,i3,i4).b(1,2)=u5_1234(i1,i2,i3,i4).b(1,2)+l5
     & _12(i1,i2).d(1,1)*p512q*u512_34(i3,i4).b(1,2)+l5_12(i1,i2
     & ).b(1,2)*u512_34(i3,i4).a(2,2)
      u5_1234(i1,i2,i3,i4).c(1,2)=u5_1234(i1,i2,i3,i4).c(1,2)+l5
     & _12(i1,i2).a(1,1)*u512_34(i3,i4).c(1,2)+l5_12(i1,i2).c(1,
     & 2)*p512q*u512_34(i3,i4).d(2,2)
      u5_1234(i1,i2,i3,i4).d(1,2)=u5_1234(i1,i2,i3,i4).d(1,2)+rm
     & ass(id5)*(l5_12(i1,i2).d(1,1)*u512_34(i3,i4).c(1,2)+l5_12
     & (i1,i2).b(1,2)*u512_34(i3,i4).d(2,2))
      u5_1234(i1,i2,i3,i4).a(2,1)=u5_1234(i1,i2,i3,i4).a(2,1)+rm
     & ass(id5)*(l5_12(i1,i2).c(2,1)*u512_34(i3,i4).a(1,1)+l5_12
     & (i1,i2).a(2,2)*u512_34(i3,i4).b(2,1))
      u5_1234(i1,i2,i3,i4).b(2,1)=u5_1234(i1,i2,i3,i4).b(2,1)+l5
     & _12(i1,i2).b(2,1)*u512_34(i3,i4).a(1,1)+l5_12(i1,i2).d(2,
     & 2)*p512q*u512_34(i3,i4).b(2,1)
      u5_1234(i1,i2,i3,i4).c(2,1)=u5_1234(i1,i2,i3,i4).c(2,1)+l5
     & _12(i1,i2).c(2,1)*p512q*u512_34(i3,i4).d(1,1)+l5_12(i1,i2
     & ).a(2,2)*u512_34(i3,i4).c(2,1)
      u5_1234(i1,i2,i3,i4).d(2,1)=u5_1234(i1,i2,i3,i4).d(2,1)+rm
     & ass(id5)*(l5_12(i1,i2).b(2,1)*u512_34(i3,i4).d(1,1)+l5_12
     & (i1,i2).d(2,2)*u512_34(i3,i4).c(2,1))
      u5_1234(i1,i2,i3,i4).a(2,2)=u5_1234(i1,i2,i3,i4).a(2,2)+l5
     & _12(i1,i2).c(2,1)*p512q*u512_34(i3,i4).b(1,2)+l5_12(i1,i2
     & ).a(2,2)*u512_34(i3,i4).a(2,2)
      u5_1234(i1,i2,i3,i4).b(2,2)=u5_1234(i1,i2,i3,i4).b(2,2)+rm
     & ass(id5)*(l5_12(i1,i2).b(2,1)*u512_34(i3,i4).b(1,2)+l5_12
     & (i1,i2).d(2,2)*u512_34(i3,i4).a(2,2))
      u5_1234(i1,i2,i3,i4).c(2,2)=u5_1234(i1,i2,i3,i4).c(2,2)+rm
     & ass(id5)*(l5_12(i1,i2).c(2,1)*u512_34(i3,i4).c(1,2)+l5_12
     & (i1,i2).a(2,2)*u512_34(i3,i4).d(2,2))
      u5_1234(i1,i2,i3,i4).d(2,2)=u5_1234(i1,i2,i3,i4).d(2,2)+l5
     & _12(i1,i2).b(2,1)*u512_34(i3,i4).c(1,2)+l5_12(i1,i2).d(2,
     & 2)*p512q*u512_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id5.eq.5.and.id1.eq.5.and.id3.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TsTs -- aa=u5_1234(i1,i2,i3,i4).a,bb=u5_1234(i1,i2,i3,i4).b,cc=u5_1234
* (i1,i2,i3,i4).c,dd=u5_1234(i1,i2,i3,i4).d,a1=l5_12(i1,i2).a,b1=l5_12(i
* 1,i2).b,c1=l5_12(i1,i2).c,d1=l5_12(i1,i2).d,a2=u512_34(i3,i4).a,b2=u51
* 2_34(i3,i4).b,c2=u512_34(i3,i4).c,d2=u512_34(i3,i4).d,prq=p512q,m=rmas
* s(id5),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u512_34(i3,i4).a(1,jut)+rmass(id5)*u512_34(i3,i4).b(1,
     & jut)
      cx2=u512_34(i3,i4).a(2,jut)+rmass(id5)*u512_34(i3,i4).b(2,
     & jut)
      cy1=p512q*u512_34(i3,i4).b(1,jut)+rmass(id5)*u512_34(i3,i4
     & ).a(1,jut)
      cy2=p512q*u512_34(i3,i4).b(2,jut)+rmass(id5)*u512_34(i3,i4
     & ).a(2,jut)
      u5_1234(i1,i2,i3,i4).a(iut,jut)=u5_1234(i1,i2,i3,i4).a(iut
     & ,jut)+l5_12(i1,i2).a(iut,1)*cx1+l5_12(i1,i2).c(iut,1)*cy1
     & +l5_12(i1,i2).a(iut,2)*cx2+l5_12(i1,i2).c(iut,2)*cy2
      u5_1234(i1,i2,i3,i4).b(iut,jut)=u5_1234(i1,i2,i3,i4).b(iut
     & ,jut)+l5_12(i1,i2).b(iut,1)*cx1+l5_12(i1,i2).d(iut,1)*cy1
     & +l5_12(i1,i2).b(iut,2)*cx2+l5_12(i1,i2).d(iut,2)*cy2
      cw1=u512_34(i3,i4).c(1,jut)+rmass(id5)*u512_34(i3,i4).d(1,
     & jut)
      cw2=u512_34(i3,i4).c(2,jut)+rmass(id5)*u512_34(i3,i4).d(2,
     & jut)
      cz1=p512q*u512_34(i3,i4).d(1,jut)+rmass(id5)*u512_34(i3,i4
     & ).c(1,jut)
      cz2=p512q*u512_34(i3,i4).d(2,jut)+rmass(id5)*u512_34(i3,i4
     & ).c(2,jut)
      u5_1234(i1,i2,i3,i4).c(iut,jut)=u5_1234(i1,i2,i3,i4).c(iut
     & ,jut)+l5_12(i1,i2).a(iut,1)*cw1+l5_12(i1,i2).c(iut,1)*cz1
     & +l5_12(i1,i2).a(iut,2)*cw2+l5_12(i1,i2).c(iut,2)*cz2
      u5_1234(i1,i2,i3,i4).d(iut,jut)=u5_1234(i1,i2,i3,i4).d(iut
     & ,jut)+l5_12(i1,i2).b(iut,1)*cw1+l5_12(i1,i2).d(iut,1)*cz1
     & +l5_12(i1,i2).b(iut,2)*cw2+l5_12(i1,i2).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id5.eq.5.and.id1.eq.5.and.id3.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TsT -- aa=u5_1234(i1,i2,i3,i4).a,bb=u5_1234(i1,i2,i3,i4).b,cc=u5_1234(
* i1,i2,i3,i4).c,dd=u5_1234(i1,i2,i3,i4).d,a1=l5_12(i1,i2).a,b1=l5_12(i1
* ,i2).b,c1=l5_12(i1,i2).c,d1=l5_12(i1,i2).d,a2=u512_34(i3,i4).a,b2=u512
* _34(i3,i4).b,c2=u512_34(i3,i4).c,d2=u512_34(i3,i4).d,prq=p512q,m=rmass
* (id5),nsum=1
      do iut=1,2
      cx1=l5_12(i1,i2).a(iut,1)+l5_12(i1,i2).c(iut,1)*rmass(id5)
      cx2=l5_12(i1,i2).c(iut,2)*p512q+l5_12(i1,i2).a(iut,2)*rmas
     & s(id5)
      cy1=l5_12(i1,i2).b(iut,1)+l5_12(i1,i2).d(iut,1)*rmass(id5)
      cy2=l5_12(i1,i2).d(iut,2)*p512q+l5_12(i1,i2).b(iut,2)*rmas
     & s(id5)
      cw1=l5_12(i1,i2).c(iut,1)*p512q+l5_12(i1,i2).a(iut,1)*rmas
     & s(id5)
      cw2=l5_12(i1,i2).a(iut,2)+l5_12(i1,i2).c(iut,2)*rmass(id5)
      cz1=l5_12(i1,i2).d(iut,1)*p512q+l5_12(i1,i2).b(iut,1)*rmas
     & s(id5)
      cz2=l5_12(i1,i2).b(iut,2)+l5_12(i1,i2).d(iut,2)*rmass(id5)
      u5_1234(i1,i2,i3,i4).a(iut,1)=u5_1234(i1,i2,i3,i4).a(iut,1
     & )+cx1*u512_34(i3,i4).a(1,1)+cx2*u512_34(i3,i4).b(2,1)
      u5_1234(i1,i2,i3,i4).b(iut,1)=u5_1234(i1,i2,i3,i4).b(iut,1
     & )+cy1*u512_34(i3,i4).a(1,1)+cy2*u512_34(i3,i4).b(2,1)
      u5_1234(i1,i2,i3,i4).c(iut,1)=u5_1234(i1,i2,i3,i4).c(iut,1
     & )+cw1*u512_34(i3,i4).d(1,1)+cw2*u512_34(i3,i4).c(2,1)
      u5_1234(i1,i2,i3,i4).d(iut,1)=u5_1234(i1,i2,i3,i4).d(iut,1
     & )+cz1*u512_34(i3,i4).d(1,1)+cz2*u512_34(i3,i4).c(2,1)
      u5_1234(i1,i2,i3,i4).a(iut,2)=u5_1234(i1,i2,i3,i4).a(iut,2
     & )+cw1*u512_34(i3,i4).b(1,2)+cw2*u512_34(i3,i4).a(2,2)
      u5_1234(i1,i2,i3,i4).b(iut,2)=u5_1234(i1,i2,i3,i4).b(iut,2
     & )+cz1*u512_34(i3,i4).b(1,2)+cz2*u512_34(i3,i4).a(2,2)
      u5_1234(i1,i2,i3,i4).c(iut,2)=u5_1234(i1,i2,i3,i4).c(iut,2
     & )+cx1*u512_34(i3,i4).c(1,2)+cx2*u512_34(i3,i4).d(2,2)
      u5_1234(i1,i2,i3,i4).d(iut,2)=u5_1234(i1,i2,i3,i4).d(iut,2
     & )+cy1*u512_34(i3,i4).c(1,2)+cy2*u512_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id5.eq.5.and.id1.ne.5.and.id3.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TTs -- aa=u5_1234(i1,i2,i3,i4).a,bb=u5_1234(i1,i2,i3,i4).b,cc=u5_1234(
* i1,i2,i3,i4).c,dd=u5_1234(i1,i2,i3,i4).d,a1=l5_12(i1,i2).a,b1=l5_12(i1
* ,i2).b,c1=l5_12(i1,i2).c,d1=l5_12(i1,i2).d,a2=u512_34(i3,i4).a,b2=u512
* _34(i3,i4).b,c2=u512_34(i3,i4).c,d2=u512_34(i3,i4).d,prq=p512q,m=rmass
* (id5),nsum=1
      do jut=1,2
      cx1=u512_34(i3,i4).a(1,jut)+rmass(id5)*u512_34(i3,i4).b(1,
     & jut)
      cx2=u512_34(i3,i4).a(2,jut)+rmass(id5)*u512_34(i3,i4).b(2,
     & jut)
      cy1=p512q*u512_34(i3,i4).b(1,jut)+rmass(id5)*u512_34(i3,i4
     & ).a(1,jut)
      cy2=p512q*u512_34(i3,i4).b(2,jut)+rmass(id5)*u512_34(i3,i4
     & ).a(2,jut)
      cw1=u512_34(i3,i4).c(1,jut)+rmass(id5)*u512_34(i3,i4).d(1,
     & jut)
      cw2=u512_34(i3,i4).c(2,jut)+rmass(id5)*u512_34(i3,i4).d(2,
     & jut)
      cz1=p512q*u512_34(i3,i4).d(1,jut)+rmass(id5)*u512_34(i3,i4
     & ).c(1,jut)
      cz2=p512q*u512_34(i3,i4).d(2,jut)+rmass(id5)*u512_34(i3,i4
     & ).c(2,jut)
      u5_1234(i1,i2,i3,i4).a(1,jut)=u5_1234(i1,i2,i3,i4).a(1,jut
     & )+l5_12(i1,i2).a(1,1)*cx1+l5_12(i1,i2).c(1,2)*cy2
      u5_1234(i1,i2,i3,i4).b(1,jut)=u5_1234(i1,i2,i3,i4).b(1,jut
     & )+l5_12(i1,i2).d(1,1)*cy1+l5_12(i1,i2).b(1,2)*cx2
      u5_1234(i1,i2,i3,i4).c(1,jut)=u5_1234(i1,i2,i3,i4).c(1,jut
     & )+l5_12(i1,i2).a(1,1)*cw1+l5_12(i1,i2).c(1,2)*cz2
      u5_1234(i1,i2,i3,i4).d(1,jut)=u5_1234(i1,i2,i3,i4).d(1,jut
     & )+l5_12(i1,i2).d(1,1)*cz1+l5_12(i1,i2).b(1,2)*cw2
      u5_1234(i1,i2,i3,i4).a(2,jut)=u5_1234(i1,i2,i3,i4).a(2,jut
     & )+l5_12(i1,i2).c(2,1)*cy1+l5_12(i1,i2).a(2,2)*cx2
      u5_1234(i1,i2,i3,i4).b(2,jut)=u5_1234(i1,i2,i3,i4).b(2,jut
     & )+l5_12(i1,i2).b(2,1)*cx1+l5_12(i1,i2).d(2,2)*cy2
      u5_1234(i1,i2,i3,i4).c(2,jut)=u5_1234(i1,i2,i3,i4).c(2,jut
     & )+l5_12(i1,i2).c(2,1)*cz1+l5_12(i1,i2).a(2,2)*cw2
      u5_1234(i1,i2,i3,i4).d(2,jut)=u5_1234(i1,i2,i3,i4).d(2,jut
     & )+l5_12(i1,i2).b(2,1)*cw1+l5_12(i1,i2).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p534q,p=p534,q=p534,bef=,aft=
      p534q=(p534(0)*p534(0)-p534(1)*p534(1)-p534(2)*p534(2)-p53
     & 4(3)*p534(3))
  
      if(id5.ne.5.or.(id3.ne.5.and.id1.ne.5))then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TT -- aa=u5_1234(i1,i2,i3,i4).a,bb=u5_1234(i1,i2,i3,i4).b,cc=u5_1234(i
* 1,i2,i3,i4).c,dd=u5_1234(i1,i2,i3,i4).d,a1=l5_34(i3,i4).a,b1=l5_34(i3,
* i4).b,c1=l5_34(i3,i4).c,d1=l5_34(i3,i4).d,a2=u534_12(i1,i2).a,b2=u534_
* 12(i1,i2).b,c2=u534_12(i1,i2).c,d2=u534_12(i1,i2).d,prq=p534q,m=rmass(
* id5),nsum=1
      u5_1234(i1,i2,i3,i4).a(1,1)=u5_1234(i1,i2,i3,i4).a(1,1)+l5
     & _34(i3,i4).a(1,1)*u534_12(i1,i2).a(1,1)+l5_34(i3,i4).c(1,
     & 2)*p534q*u534_12(i1,i2).b(2,1)
      u5_1234(i1,i2,i3,i4).b(1,1)=u5_1234(i1,i2,i3,i4).b(1,1)+rm
     & ass(id5)*(l5_34(i3,i4).d(1,1)*u534_12(i1,i2).a(1,1)+l5_34
     & (i3,i4).b(1,2)*u534_12(i1,i2).b(2,1))
      u5_1234(i1,i2,i3,i4).c(1,1)=u5_1234(i1,i2,i3,i4).c(1,1)+rm
     & ass(id5)*(l5_34(i3,i4).a(1,1)*u534_12(i1,i2).d(1,1)+l5_34
     & (i3,i4).c(1,2)*u534_12(i1,i2).c(2,1))
      u5_1234(i1,i2,i3,i4).d(1,1)=u5_1234(i1,i2,i3,i4).d(1,1)+l5
     & _34(i3,i4).d(1,1)*p534q*u534_12(i1,i2).d(1,1)+l5_34(i3,i4
     & ).b(1,2)*u534_12(i1,i2).c(2,1)
      u5_1234(i1,i2,i3,i4).a(1,2)=u5_1234(i1,i2,i3,i4).a(1,2)+rm
     & ass(id5)*(l5_34(i3,i4).a(1,1)*u534_12(i1,i2).b(1,2)+l5_34
     & (i3,i4).c(1,2)*u534_12(i1,i2).a(2,2))
      u5_1234(i1,i2,i3,i4).b(1,2)=u5_1234(i1,i2,i3,i4).b(1,2)+l5
     & _34(i3,i4).d(1,1)*p534q*u534_12(i1,i2).b(1,2)+l5_34(i3,i4
     & ).b(1,2)*u534_12(i1,i2).a(2,2)
      u5_1234(i1,i2,i3,i4).c(1,2)=u5_1234(i1,i2,i3,i4).c(1,2)+l5
     & _34(i3,i4).a(1,1)*u534_12(i1,i2).c(1,2)+l5_34(i3,i4).c(1,
     & 2)*p534q*u534_12(i1,i2).d(2,2)
      u5_1234(i1,i2,i3,i4).d(1,2)=u5_1234(i1,i2,i3,i4).d(1,2)+rm
     & ass(id5)*(l5_34(i3,i4).d(1,1)*u534_12(i1,i2).c(1,2)+l5_34
     & (i3,i4).b(1,2)*u534_12(i1,i2).d(2,2))
      u5_1234(i1,i2,i3,i4).a(2,1)=u5_1234(i1,i2,i3,i4).a(2,1)+rm
     & ass(id5)*(l5_34(i3,i4).c(2,1)*u534_12(i1,i2).a(1,1)+l5_34
     & (i3,i4).a(2,2)*u534_12(i1,i2).b(2,1))
      u5_1234(i1,i2,i3,i4).b(2,1)=u5_1234(i1,i2,i3,i4).b(2,1)+l5
     & _34(i3,i4).b(2,1)*u534_12(i1,i2).a(1,1)+l5_34(i3,i4).d(2,
     & 2)*p534q*u534_12(i1,i2).b(2,1)
      u5_1234(i1,i2,i3,i4).c(2,1)=u5_1234(i1,i2,i3,i4).c(2,1)+l5
     & _34(i3,i4).c(2,1)*p534q*u534_12(i1,i2).d(1,1)+l5_34(i3,i4
     & ).a(2,2)*u534_12(i1,i2).c(2,1)
      u5_1234(i1,i2,i3,i4).d(2,1)=u5_1234(i1,i2,i3,i4).d(2,1)+rm
     & ass(id5)*(l5_34(i3,i4).b(2,1)*u534_12(i1,i2).d(1,1)+l5_34
     & (i3,i4).d(2,2)*u534_12(i1,i2).c(2,1))
      u5_1234(i1,i2,i3,i4).a(2,2)=u5_1234(i1,i2,i3,i4).a(2,2)+l5
     & _34(i3,i4).c(2,1)*p534q*u534_12(i1,i2).b(1,2)+l5_34(i3,i4
     & ).a(2,2)*u534_12(i1,i2).a(2,2)
      u5_1234(i1,i2,i3,i4).b(2,2)=u5_1234(i1,i2,i3,i4).b(2,2)+rm
     & ass(id5)*(l5_34(i3,i4).b(2,1)*u534_12(i1,i2).b(1,2)+l5_34
     & (i3,i4).d(2,2)*u534_12(i1,i2).a(2,2))
      u5_1234(i1,i2,i3,i4).c(2,2)=u5_1234(i1,i2,i3,i4).c(2,2)+rm
     & ass(id5)*(l5_34(i3,i4).c(2,1)*u534_12(i1,i2).c(1,2)+l5_34
     & (i3,i4).a(2,2)*u534_12(i1,i2).d(2,2))
      u5_1234(i1,i2,i3,i4).d(2,2)=u5_1234(i1,i2,i3,i4).d(2,2)+l5
     & _34(i3,i4).b(2,1)*u534_12(i1,i2).c(1,2)+l5_34(i3,i4).d(2,
     & 2)*p534q*u534_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id5.eq.5.and.id3.eq.5.and.id1.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TsTs -- aa=u5_1234(i1,i2,i3,i4).a,bb=u5_1234(i1,i2,i3,i4).b,cc=u5_1234
* (i1,i2,i3,i4).c,dd=u5_1234(i1,i2,i3,i4).d,a1=l5_34(i3,i4).a,b1=l5_34(i
* 3,i4).b,c1=l5_34(i3,i4).c,d1=l5_34(i3,i4).d,a2=u534_12(i1,i2).a,b2=u53
* 4_12(i1,i2).b,c2=u534_12(i1,i2).c,d2=u534_12(i1,i2).d,prq=p534q,m=rmas
* s(id5),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u534_12(i1,i2).a(1,jut)+rmass(id5)*u534_12(i1,i2).b(1,
     & jut)
      cx2=u534_12(i1,i2).a(2,jut)+rmass(id5)*u534_12(i1,i2).b(2,
     & jut)
      cy1=p534q*u534_12(i1,i2).b(1,jut)+rmass(id5)*u534_12(i1,i2
     & ).a(1,jut)
      cy2=p534q*u534_12(i1,i2).b(2,jut)+rmass(id5)*u534_12(i1,i2
     & ).a(2,jut)
      u5_1234(i1,i2,i3,i4).a(iut,jut)=u5_1234(i1,i2,i3,i4).a(iut
     & ,jut)+l5_34(i3,i4).a(iut,1)*cx1+l5_34(i3,i4).c(iut,1)*cy1
     & +l5_34(i3,i4).a(iut,2)*cx2+l5_34(i3,i4).c(iut,2)*cy2
      u5_1234(i1,i2,i3,i4).b(iut,jut)=u5_1234(i1,i2,i3,i4).b(iut
     & ,jut)+l5_34(i3,i4).b(iut,1)*cx1+l5_34(i3,i4).d(iut,1)*cy1
     & +l5_34(i3,i4).b(iut,2)*cx2+l5_34(i3,i4).d(iut,2)*cy2
      cw1=u534_12(i1,i2).c(1,jut)+rmass(id5)*u534_12(i1,i2).d(1,
     & jut)
      cw2=u534_12(i1,i2).c(2,jut)+rmass(id5)*u534_12(i1,i2).d(2,
     & jut)
      cz1=p534q*u534_12(i1,i2).d(1,jut)+rmass(id5)*u534_12(i1,i2
     & ).c(1,jut)
      cz2=p534q*u534_12(i1,i2).d(2,jut)+rmass(id5)*u534_12(i1,i2
     & ).c(2,jut)
      u5_1234(i1,i2,i3,i4).c(iut,jut)=u5_1234(i1,i2,i3,i4).c(iut
     & ,jut)+l5_34(i3,i4).a(iut,1)*cw1+l5_34(i3,i4).c(iut,1)*cz1
     & +l5_34(i3,i4).a(iut,2)*cw2+l5_34(i3,i4).c(iut,2)*cz2
      u5_1234(i1,i2,i3,i4).d(iut,jut)=u5_1234(i1,i2,i3,i4).d(iut
     & ,jut)+l5_34(i3,i4).b(iut,1)*cw1+l5_34(i3,i4).d(iut,1)*cz1
     & +l5_34(i3,i4).b(iut,2)*cw2+l5_34(i3,i4).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id5.eq.5.and.id3.eq.5.and.id1.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TsT -- aa=u5_1234(i1,i2,i3,i4).a,bb=u5_1234(i1,i2,i3,i4).b,cc=u5_1234(
* i1,i2,i3,i4).c,dd=u5_1234(i1,i2,i3,i4).d,a1=l5_34(i3,i4).a,b1=l5_34(i3
* ,i4).b,c1=l5_34(i3,i4).c,d1=l5_34(i3,i4).d,a2=u534_12(i1,i2).a,b2=u534
* _12(i1,i2).b,c2=u534_12(i1,i2).c,d2=u534_12(i1,i2).d,prq=p534q,m=rmass
* (id5),nsum=1
      do iut=1,2
      cx1=l5_34(i3,i4).a(iut,1)+l5_34(i3,i4).c(iut,1)*rmass(id5)
      cx2=l5_34(i3,i4).c(iut,2)*p534q+l5_34(i3,i4).a(iut,2)*rmas
     & s(id5)
      cy1=l5_34(i3,i4).b(iut,1)+l5_34(i3,i4).d(iut,1)*rmass(id5)
      cy2=l5_34(i3,i4).d(iut,2)*p534q+l5_34(i3,i4).b(iut,2)*rmas
     & s(id5)
      cw1=l5_34(i3,i4).c(iut,1)*p534q+l5_34(i3,i4).a(iut,1)*rmas
     & s(id5)
      cw2=l5_34(i3,i4).a(iut,2)+l5_34(i3,i4).c(iut,2)*rmass(id5)
      cz1=l5_34(i3,i4).d(iut,1)*p534q+l5_34(i3,i4).b(iut,1)*rmas
     & s(id5)
      cz2=l5_34(i3,i4).b(iut,2)+l5_34(i3,i4).d(iut,2)*rmass(id5)
      u5_1234(i1,i2,i3,i4).a(iut,1)=u5_1234(i1,i2,i3,i4).a(iut,1
     & )+cx1*u534_12(i1,i2).a(1,1)+cx2*u534_12(i1,i2).b(2,1)
      u5_1234(i1,i2,i3,i4).b(iut,1)=u5_1234(i1,i2,i3,i4).b(iut,1
     & )+cy1*u534_12(i1,i2).a(1,1)+cy2*u534_12(i1,i2).b(2,1)
      u5_1234(i1,i2,i3,i4).c(iut,1)=u5_1234(i1,i2,i3,i4).c(iut,1
     & )+cw1*u534_12(i1,i2).d(1,1)+cw2*u534_12(i1,i2).c(2,1)
      u5_1234(i1,i2,i3,i4).d(iut,1)=u5_1234(i1,i2,i3,i4).d(iut,1
     & )+cz1*u534_12(i1,i2).d(1,1)+cz2*u534_12(i1,i2).c(2,1)
      u5_1234(i1,i2,i3,i4).a(iut,2)=u5_1234(i1,i2,i3,i4).a(iut,2
     & )+cw1*u534_12(i1,i2).b(1,2)+cw2*u534_12(i1,i2).a(2,2)
      u5_1234(i1,i2,i3,i4).b(iut,2)=u5_1234(i1,i2,i3,i4).b(iut,2
     & )+cz1*u534_12(i1,i2).b(1,2)+cz2*u534_12(i1,i2).a(2,2)
      u5_1234(i1,i2,i3,i4).c(iut,2)=u5_1234(i1,i2,i3,i4).c(iut,2
     & )+cx1*u534_12(i1,i2).c(1,2)+cx2*u534_12(i1,i2).d(2,2)
      u5_1234(i1,i2,i3,i4).d(iut,2)=u5_1234(i1,i2,i3,i4).d(iut,2
     & )+cy1*u534_12(i1,i2).c(1,2)+cy2*u534_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id5.eq.5.and.id3.ne.5.and.id1.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TTs -- aa=u5_1234(i1,i2,i3,i4).a,bb=u5_1234(i1,i2,i3,i4).b,cc=u5_1234(
* i1,i2,i3,i4).c,dd=u5_1234(i1,i2,i3,i4).d,a1=l5_34(i3,i4).a,b1=l5_34(i3
* ,i4).b,c1=l5_34(i3,i4).c,d1=l5_34(i3,i4).d,a2=u534_12(i1,i2).a,b2=u534
* _12(i1,i2).b,c2=u534_12(i1,i2).c,d2=u534_12(i1,i2).d,prq=p534q,m=rmass
* (id5),nsum=1
      do jut=1,2
      cx1=u534_12(i1,i2).a(1,jut)+rmass(id5)*u534_12(i1,i2).b(1,
     & jut)
      cx2=u534_12(i1,i2).a(2,jut)+rmass(id5)*u534_12(i1,i2).b(2,
     & jut)
      cy1=p534q*u534_12(i1,i2).b(1,jut)+rmass(id5)*u534_12(i1,i2
     & ).a(1,jut)
      cy2=p534q*u534_12(i1,i2).b(2,jut)+rmass(id5)*u534_12(i1,i2
     & ).a(2,jut)
      cw1=u534_12(i1,i2).c(1,jut)+rmass(id5)*u534_12(i1,i2).d(1,
     & jut)
      cw2=u534_12(i1,i2).c(2,jut)+rmass(id5)*u534_12(i1,i2).d(2,
     & jut)
      cz1=p534q*u534_12(i1,i2).d(1,jut)+rmass(id5)*u534_12(i1,i2
     & ).c(1,jut)
      cz2=p534q*u534_12(i1,i2).d(2,jut)+rmass(id5)*u534_12(i1,i2
     & ).c(2,jut)
      u5_1234(i1,i2,i3,i4).a(1,jut)=u5_1234(i1,i2,i3,i4).a(1,jut
     & )+l5_34(i3,i4).a(1,1)*cx1+l5_34(i3,i4).c(1,2)*cy2
      u5_1234(i1,i2,i3,i4).b(1,jut)=u5_1234(i1,i2,i3,i4).b(1,jut
     & )+l5_34(i3,i4).d(1,1)*cy1+l5_34(i3,i4).b(1,2)*cx2
      u5_1234(i1,i2,i3,i4).c(1,jut)=u5_1234(i1,i2,i3,i4).c(1,jut
     & )+l5_34(i3,i4).a(1,1)*cw1+l5_34(i3,i4).c(1,2)*cz2
      u5_1234(i1,i2,i3,i4).d(1,jut)=u5_1234(i1,i2,i3,i4).d(1,jut
     & )+l5_34(i3,i4).d(1,1)*cz1+l5_34(i3,i4).b(1,2)*cw2
      u5_1234(i1,i2,i3,i4).a(2,jut)=u5_1234(i1,i2,i3,i4).a(2,jut
     & )+l5_34(i3,i4).c(2,1)*cy1+l5_34(i3,i4).a(2,2)*cx2
      u5_1234(i1,i2,i3,i4).b(2,jut)=u5_1234(i1,i2,i3,i4).b(2,jut
     & )+l5_34(i3,i4).b(2,1)*cx1+l5_34(i3,i4).d(2,2)*cy2
      u5_1234(i1,i2,i3,i4).c(2,jut)=u5_1234(i1,i2,i3,i4).c(2,jut
     & )+l5_34(i3,i4).c(2,1)*cz1+l5_34(i3,i4).a(2,2)*cw2
      u5_1234(i1,i2,i3,i4).d(2,jut)=u5_1234(i1,i2,i3,i4).d(2,jut
     & )+l5_34(i3,i4).b(2,1)*cw1+l5_34(i3,i4).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p512q,p=p512,q=p512,bef=,aft=
      p512q=(p512(0)*p512(0)-p512(1)*p512(1)-p512(2)*p512(2)-p51
     & 2(3)*p512(3))
  
      if(id5.ne.5.or.(id1.ne.5.and.id7.ne.5))then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=u5_1278(i1,i2,i7,i8).a,bb=u5_1278(i1,i2,i7,i8).b,cc=u5_1278(i
* 1,i2,i7,i8).c,dd=u5_1278(i1,i2,i7,i8).d,a1=l5_12(i1,i2).a,b1=l5_12(i1,
* i2).b,c1=l5_12(i1,i2).c,d1=l5_12(i1,i2).d,a2=u512_78(i7,i8).a,b2=u512_
* 78(i7,i8).b,c2=u512_78(i7,i8).c,d2=u512_78(i7,i8).d,prq=p512q,m=rmass(
* id5),nsum=1
      u5_1278(i1,i2,i7,i8).a(1,1)=u5_1278(i1,i2,i7,i8).a(1,1)+l5
     & _12(i1,i2).a(1,1)*u512_78(i7,i8).a(1,1)+l5_12(i1,i2).c(1,
     & 2)*p512q*u512_78(i7,i8).b(2,1)
      u5_1278(i1,i2,i7,i8).b(1,1)=u5_1278(i1,i2,i7,i8).b(1,1)+rm
     & ass(id5)*(l5_12(i1,i2).d(1,1)*u512_78(i7,i8).a(1,1)+l5_12
     & (i1,i2).b(1,2)*u512_78(i7,i8).b(2,1))
      u5_1278(i1,i2,i7,i8).c(1,1)=u5_1278(i1,i2,i7,i8).c(1,1)+rm
     & ass(id5)*(l5_12(i1,i2).a(1,1)*u512_78(i7,i8).d(1,1)+l5_12
     & (i1,i2).c(1,2)*u512_78(i7,i8).c(2,1))
      u5_1278(i1,i2,i7,i8).d(1,1)=u5_1278(i1,i2,i7,i8).d(1,1)+l5
     & _12(i1,i2).d(1,1)*p512q*u512_78(i7,i8).d(1,1)+l5_12(i1,i2
     & ).b(1,2)*u512_78(i7,i8).c(2,1)
      u5_1278(i1,i2,i7,i8).a(1,2)=u5_1278(i1,i2,i7,i8).a(1,2)+rm
     & ass(id5)*(l5_12(i1,i2).a(1,1)*u512_78(i7,i8).b(1,2)+l5_12
     & (i1,i2).c(1,2)*u512_78(i7,i8).a(2,2))
      u5_1278(i1,i2,i7,i8).b(1,2)=u5_1278(i1,i2,i7,i8).b(1,2)+l5
     & _12(i1,i2).d(1,1)*p512q*u512_78(i7,i8).b(1,2)+l5_12(i1,i2
     & ).b(1,2)*u512_78(i7,i8).a(2,2)
      u5_1278(i1,i2,i7,i8).c(1,2)=u5_1278(i1,i2,i7,i8).c(1,2)+l5
     & _12(i1,i2).a(1,1)*u512_78(i7,i8).c(1,2)+l5_12(i1,i2).c(1,
     & 2)*p512q*u512_78(i7,i8).d(2,2)
      u5_1278(i1,i2,i7,i8).d(1,2)=u5_1278(i1,i2,i7,i8).d(1,2)+rm
     & ass(id5)*(l5_12(i1,i2).d(1,1)*u512_78(i7,i8).c(1,2)+l5_12
     & (i1,i2).b(1,2)*u512_78(i7,i8).d(2,2))
      u5_1278(i1,i2,i7,i8).a(2,1)=u5_1278(i1,i2,i7,i8).a(2,1)+rm
     & ass(id5)*(l5_12(i1,i2).c(2,1)*u512_78(i7,i8).a(1,1)+l5_12
     & (i1,i2).a(2,2)*u512_78(i7,i8).b(2,1))
      u5_1278(i1,i2,i7,i8).b(2,1)=u5_1278(i1,i2,i7,i8).b(2,1)+l5
     & _12(i1,i2).b(2,1)*u512_78(i7,i8).a(1,1)+l5_12(i1,i2).d(2,
     & 2)*p512q*u512_78(i7,i8).b(2,1)
      u5_1278(i1,i2,i7,i8).c(2,1)=u5_1278(i1,i2,i7,i8).c(2,1)+l5
     & _12(i1,i2).c(2,1)*p512q*u512_78(i7,i8).d(1,1)+l5_12(i1,i2
     & ).a(2,2)*u512_78(i7,i8).c(2,1)
      u5_1278(i1,i2,i7,i8).d(2,1)=u5_1278(i1,i2,i7,i8).d(2,1)+rm
     & ass(id5)*(l5_12(i1,i2).b(2,1)*u512_78(i7,i8).d(1,1)+l5_12
     & (i1,i2).d(2,2)*u512_78(i7,i8).c(2,1))
      u5_1278(i1,i2,i7,i8).a(2,2)=u5_1278(i1,i2,i7,i8).a(2,2)+l5
     & _12(i1,i2).c(2,1)*p512q*u512_78(i7,i8).b(1,2)+l5_12(i1,i2
     & ).a(2,2)*u512_78(i7,i8).a(2,2)
      u5_1278(i1,i2,i7,i8).b(2,2)=u5_1278(i1,i2,i7,i8).b(2,2)+rm
     & ass(id5)*(l5_12(i1,i2).b(2,1)*u512_78(i7,i8).b(1,2)+l5_12
     & (i1,i2).d(2,2)*u512_78(i7,i8).a(2,2))
      u5_1278(i1,i2,i7,i8).c(2,2)=u5_1278(i1,i2,i7,i8).c(2,2)+rm
     & ass(id5)*(l5_12(i1,i2).c(2,1)*u512_78(i7,i8).c(1,2)+l5_12
     & (i1,i2).a(2,2)*u512_78(i7,i8).d(2,2))
      u5_1278(i1,i2,i7,i8).d(2,2)=u5_1278(i1,i2,i7,i8).d(2,2)+l5
     & _12(i1,i2).b(2,1)*u512_78(i7,i8).c(1,2)+l5_12(i1,i2).d(2,
     & 2)*p512q*u512_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id5.eq.5.and.id1.eq.5.and.id7.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=u5_1278(i1,i2,i7,i8).a,bb=u5_1278(i1,i2,i7,i8).b,cc=u5_1278
* (i1,i2,i7,i8).c,dd=u5_1278(i1,i2,i7,i8).d,a1=l5_12(i1,i2).a,b1=l5_12(i
* 1,i2).b,c1=l5_12(i1,i2).c,d1=l5_12(i1,i2).d,a2=u512_78(i7,i8).a,b2=u51
* 2_78(i7,i8).b,c2=u512_78(i7,i8).c,d2=u512_78(i7,i8).d,prq=p512q,m=rmas
* s(id5),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u512_78(i7,i8).a(1,jut)+rmass(id5)*u512_78(i7,i8).b(1,
     & jut)
      cx2=u512_78(i7,i8).a(2,jut)+rmass(id5)*u512_78(i7,i8).b(2,
     & jut)
      cy1=p512q*u512_78(i7,i8).b(1,jut)+rmass(id5)*u512_78(i7,i8
     & ).a(1,jut)
      cy2=p512q*u512_78(i7,i8).b(2,jut)+rmass(id5)*u512_78(i7,i8
     & ).a(2,jut)
      u5_1278(i1,i2,i7,i8).a(iut,jut)=u5_1278(i1,i2,i7,i8).a(iut
     & ,jut)+l5_12(i1,i2).a(iut,1)*cx1+l5_12(i1,i2).c(iut,1)*cy1
     & +l5_12(i1,i2).a(iut,2)*cx2+l5_12(i1,i2).c(iut,2)*cy2
      u5_1278(i1,i2,i7,i8).b(iut,jut)=u5_1278(i1,i2,i7,i8).b(iut
     & ,jut)+l5_12(i1,i2).b(iut,1)*cx1+l5_12(i1,i2).d(iut,1)*cy1
     & +l5_12(i1,i2).b(iut,2)*cx2+l5_12(i1,i2).d(iut,2)*cy2
      cw1=u512_78(i7,i8).c(1,jut)+rmass(id5)*u512_78(i7,i8).d(1,
     & jut)
      cw2=u512_78(i7,i8).c(2,jut)+rmass(id5)*u512_78(i7,i8).d(2,
     & jut)
      cz1=p512q*u512_78(i7,i8).d(1,jut)+rmass(id5)*u512_78(i7,i8
     & ).c(1,jut)
      cz2=p512q*u512_78(i7,i8).d(2,jut)+rmass(id5)*u512_78(i7,i8
     & ).c(2,jut)
      u5_1278(i1,i2,i7,i8).c(iut,jut)=u5_1278(i1,i2,i7,i8).c(iut
     & ,jut)+l5_12(i1,i2).a(iut,1)*cw1+l5_12(i1,i2).c(iut,1)*cz1
     & +l5_12(i1,i2).a(iut,2)*cw2+l5_12(i1,i2).c(iut,2)*cz2
      u5_1278(i1,i2,i7,i8).d(iut,jut)=u5_1278(i1,i2,i7,i8).d(iut
     & ,jut)+l5_12(i1,i2).b(iut,1)*cw1+l5_12(i1,i2).d(iut,1)*cz1
     & +l5_12(i1,i2).b(iut,2)*cw2+l5_12(i1,i2).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id5.eq.5.and.id1.eq.5.and.id7.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=u5_1278(i1,i2,i7,i8).a,bb=u5_1278(i1,i2,i7,i8).b,cc=u5_1278(
* i1,i2,i7,i8).c,dd=u5_1278(i1,i2,i7,i8).d,a1=l5_12(i1,i2).a,b1=l5_12(i1
* ,i2).b,c1=l5_12(i1,i2).c,d1=l5_12(i1,i2).d,a2=u512_78(i7,i8).a,b2=u512
* _78(i7,i8).b,c2=u512_78(i7,i8).c,d2=u512_78(i7,i8).d,prq=p512q,m=rmass
* (id5),nsum=1
      do iut=1,2
      cx1=l5_12(i1,i2).a(iut,1)+l5_12(i1,i2).c(iut,1)*rmass(id5)
      cx2=l5_12(i1,i2).c(iut,2)*p512q+l5_12(i1,i2).a(iut,2)*rmas
     & s(id5)
      cy1=l5_12(i1,i2).b(iut,1)+l5_12(i1,i2).d(iut,1)*rmass(id5)
      cy2=l5_12(i1,i2).d(iut,2)*p512q+l5_12(i1,i2).b(iut,2)*rmas
     & s(id5)
      cw1=l5_12(i1,i2).c(iut,1)*p512q+l5_12(i1,i2).a(iut,1)*rmas
     & s(id5)
      cw2=l5_12(i1,i2).a(iut,2)+l5_12(i1,i2).c(iut,2)*rmass(id5)
      cz1=l5_12(i1,i2).d(iut,1)*p512q+l5_12(i1,i2).b(iut,1)*rmas
     & s(id5)
      cz2=l5_12(i1,i2).b(iut,2)+l5_12(i1,i2).d(iut,2)*rmass(id5)
      u5_1278(i1,i2,i7,i8).a(iut,1)=u5_1278(i1,i2,i7,i8).a(iut,1
     & )+cx1*u512_78(i7,i8).a(1,1)+cx2*u512_78(i7,i8).b(2,1)
      u5_1278(i1,i2,i7,i8).b(iut,1)=u5_1278(i1,i2,i7,i8).b(iut,1
     & )+cy1*u512_78(i7,i8).a(1,1)+cy2*u512_78(i7,i8).b(2,1)
      u5_1278(i1,i2,i7,i8).c(iut,1)=u5_1278(i1,i2,i7,i8).c(iut,1
     & )+cw1*u512_78(i7,i8).d(1,1)+cw2*u512_78(i7,i8).c(2,1)
      u5_1278(i1,i2,i7,i8).d(iut,1)=u5_1278(i1,i2,i7,i8).d(iut,1
     & )+cz1*u512_78(i7,i8).d(1,1)+cz2*u512_78(i7,i8).c(2,1)
      u5_1278(i1,i2,i7,i8).a(iut,2)=u5_1278(i1,i2,i7,i8).a(iut,2
     & )+cw1*u512_78(i7,i8).b(1,2)+cw2*u512_78(i7,i8).a(2,2)
      u5_1278(i1,i2,i7,i8).b(iut,2)=u5_1278(i1,i2,i7,i8).b(iut,2
     & )+cz1*u512_78(i7,i8).b(1,2)+cz2*u512_78(i7,i8).a(2,2)
      u5_1278(i1,i2,i7,i8).c(iut,2)=u5_1278(i1,i2,i7,i8).c(iut,2
     & )+cx1*u512_78(i7,i8).c(1,2)+cx2*u512_78(i7,i8).d(2,2)
      u5_1278(i1,i2,i7,i8).d(iut,2)=u5_1278(i1,i2,i7,i8).d(iut,2
     & )+cy1*u512_78(i7,i8).c(1,2)+cy2*u512_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id5.eq.5.and.id1.ne.5.and.id7.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TTs -- aa=u5_1278(i1,i2,i7,i8).a,bb=u5_1278(i1,i2,i7,i8).b,cc=u5_1278(
* i1,i2,i7,i8).c,dd=u5_1278(i1,i2,i7,i8).d,a1=l5_12(i1,i2).a,b1=l5_12(i1
* ,i2).b,c1=l5_12(i1,i2).c,d1=l5_12(i1,i2).d,a2=u512_78(i7,i8).a,b2=u512
* _78(i7,i8).b,c2=u512_78(i7,i8).c,d2=u512_78(i7,i8).d,prq=p512q,m=rmass
* (id5),nsum=1
      do jut=1,2
      cx1=u512_78(i7,i8).a(1,jut)+rmass(id5)*u512_78(i7,i8).b(1,
     & jut)
      cx2=u512_78(i7,i8).a(2,jut)+rmass(id5)*u512_78(i7,i8).b(2,
     & jut)
      cy1=p512q*u512_78(i7,i8).b(1,jut)+rmass(id5)*u512_78(i7,i8
     & ).a(1,jut)
      cy2=p512q*u512_78(i7,i8).b(2,jut)+rmass(id5)*u512_78(i7,i8
     & ).a(2,jut)
      cw1=u512_78(i7,i8).c(1,jut)+rmass(id5)*u512_78(i7,i8).d(1,
     & jut)
      cw2=u512_78(i7,i8).c(2,jut)+rmass(id5)*u512_78(i7,i8).d(2,
     & jut)
      cz1=p512q*u512_78(i7,i8).d(1,jut)+rmass(id5)*u512_78(i7,i8
     & ).c(1,jut)
      cz2=p512q*u512_78(i7,i8).d(2,jut)+rmass(id5)*u512_78(i7,i8
     & ).c(2,jut)
      u5_1278(i1,i2,i7,i8).a(1,jut)=u5_1278(i1,i2,i7,i8).a(1,jut
     & )+l5_12(i1,i2).a(1,1)*cx1+l5_12(i1,i2).c(1,2)*cy2
      u5_1278(i1,i2,i7,i8).b(1,jut)=u5_1278(i1,i2,i7,i8).b(1,jut
     & )+l5_12(i1,i2).d(1,1)*cy1+l5_12(i1,i2).b(1,2)*cx2
      u5_1278(i1,i2,i7,i8).c(1,jut)=u5_1278(i1,i2,i7,i8).c(1,jut
     & )+l5_12(i1,i2).a(1,1)*cw1+l5_12(i1,i2).c(1,2)*cz2
      u5_1278(i1,i2,i7,i8).d(1,jut)=u5_1278(i1,i2,i7,i8).d(1,jut
     & )+l5_12(i1,i2).d(1,1)*cz1+l5_12(i1,i2).b(1,2)*cw2
      u5_1278(i1,i2,i7,i8).a(2,jut)=u5_1278(i1,i2,i7,i8).a(2,jut
     & )+l5_12(i1,i2).c(2,1)*cy1+l5_12(i1,i2).a(2,2)*cx2
      u5_1278(i1,i2,i7,i8).b(2,jut)=u5_1278(i1,i2,i7,i8).b(2,jut
     & )+l5_12(i1,i2).b(2,1)*cx1+l5_12(i1,i2).d(2,2)*cy2
      u5_1278(i1,i2,i7,i8).c(2,jut)=u5_1278(i1,i2,i7,i8).c(2,jut
     & )+l5_12(i1,i2).c(2,1)*cz1+l5_12(i1,i2).a(2,2)*cw2
      u5_1278(i1,i2,i7,i8).d(2,jut)=u5_1278(i1,i2,i7,i8).d(2,jut
     & )+l5_12(i1,i2).b(2,1)*cw1+l5_12(i1,i2).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p578q,p=p578,q=p578,bef=,aft=
      p578q=(p578(0)*p578(0)-p578(1)*p578(1)-p578(2)*p578(2)-p57
     & 8(3)*p578(3))
  
      if(id5.ne.5.or.(id7.ne.5.and.id1.ne.5))then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=u5_1278(i1,i2,i7,i8).a,bb=u5_1278(i1,i2,i7,i8).b,cc=u5_1278(i
* 1,i2,i7,i8).c,dd=u5_1278(i1,i2,i7,i8).d,a1=l5_78(i7,i8).a,b1=l5_78(i7,
* i8).b,c1=l5_78(i7,i8).c,d1=l5_78(i7,i8).d,a2=u578_12(i1,i2).a,b2=u578_
* 12(i1,i2).b,c2=u578_12(i1,i2).c,d2=u578_12(i1,i2).d,prq=p578q,m=rmass(
* id5),nsum=1
      u5_1278(i1,i2,i7,i8).a(1,1)=u5_1278(i1,i2,i7,i8).a(1,1)+l5
     & _78(i7,i8).a(1,1)*u578_12(i1,i2).a(1,1)+l5_78(i7,i8).c(1,
     & 2)*p578q*u578_12(i1,i2).b(2,1)
      u5_1278(i1,i2,i7,i8).b(1,1)=u5_1278(i1,i2,i7,i8).b(1,1)+rm
     & ass(id5)*(l5_78(i7,i8).d(1,1)*u578_12(i1,i2).a(1,1)+l5_78
     & (i7,i8).b(1,2)*u578_12(i1,i2).b(2,1))
      u5_1278(i1,i2,i7,i8).c(1,1)=u5_1278(i1,i2,i7,i8).c(1,1)+rm
     & ass(id5)*(l5_78(i7,i8).a(1,1)*u578_12(i1,i2).d(1,1)+l5_78
     & (i7,i8).c(1,2)*u578_12(i1,i2).c(2,1))
      u5_1278(i1,i2,i7,i8).d(1,1)=u5_1278(i1,i2,i7,i8).d(1,1)+l5
     & _78(i7,i8).d(1,1)*p578q*u578_12(i1,i2).d(1,1)+l5_78(i7,i8
     & ).b(1,2)*u578_12(i1,i2).c(2,1)
      u5_1278(i1,i2,i7,i8).a(1,2)=u5_1278(i1,i2,i7,i8).a(1,2)+rm
     & ass(id5)*(l5_78(i7,i8).a(1,1)*u578_12(i1,i2).b(1,2)+l5_78
     & (i7,i8).c(1,2)*u578_12(i1,i2).a(2,2))
      u5_1278(i1,i2,i7,i8).b(1,2)=u5_1278(i1,i2,i7,i8).b(1,2)+l5
     & _78(i7,i8).d(1,1)*p578q*u578_12(i1,i2).b(1,2)+l5_78(i7,i8
     & ).b(1,2)*u578_12(i1,i2).a(2,2)
      u5_1278(i1,i2,i7,i8).c(1,2)=u5_1278(i1,i2,i7,i8).c(1,2)+l5
     & _78(i7,i8).a(1,1)*u578_12(i1,i2).c(1,2)+l5_78(i7,i8).c(1,
     & 2)*p578q*u578_12(i1,i2).d(2,2)
      u5_1278(i1,i2,i7,i8).d(1,2)=u5_1278(i1,i2,i7,i8).d(1,2)+rm
     & ass(id5)*(l5_78(i7,i8).d(1,1)*u578_12(i1,i2).c(1,2)+l5_78
     & (i7,i8).b(1,2)*u578_12(i1,i2).d(2,2))
      u5_1278(i1,i2,i7,i8).a(2,1)=u5_1278(i1,i2,i7,i8).a(2,1)+rm
     & ass(id5)*(l5_78(i7,i8).c(2,1)*u578_12(i1,i2).a(1,1)+l5_78
     & (i7,i8).a(2,2)*u578_12(i1,i2).b(2,1))
      u5_1278(i1,i2,i7,i8).b(2,1)=u5_1278(i1,i2,i7,i8).b(2,1)+l5
     & _78(i7,i8).b(2,1)*u578_12(i1,i2).a(1,1)+l5_78(i7,i8).d(2,
     & 2)*p578q*u578_12(i1,i2).b(2,1)
      u5_1278(i1,i2,i7,i8).c(2,1)=u5_1278(i1,i2,i7,i8).c(2,1)+l5
     & _78(i7,i8).c(2,1)*p578q*u578_12(i1,i2).d(1,1)+l5_78(i7,i8
     & ).a(2,2)*u578_12(i1,i2).c(2,1)
      u5_1278(i1,i2,i7,i8).d(2,1)=u5_1278(i1,i2,i7,i8).d(2,1)+rm
     & ass(id5)*(l5_78(i7,i8).b(2,1)*u578_12(i1,i2).d(1,1)+l5_78
     & (i7,i8).d(2,2)*u578_12(i1,i2).c(2,1))
      u5_1278(i1,i2,i7,i8).a(2,2)=u5_1278(i1,i2,i7,i8).a(2,2)+l5
     & _78(i7,i8).c(2,1)*p578q*u578_12(i1,i2).b(1,2)+l5_78(i7,i8
     & ).a(2,2)*u578_12(i1,i2).a(2,2)
      u5_1278(i1,i2,i7,i8).b(2,2)=u5_1278(i1,i2,i7,i8).b(2,2)+rm
     & ass(id5)*(l5_78(i7,i8).b(2,1)*u578_12(i1,i2).b(1,2)+l5_78
     & (i7,i8).d(2,2)*u578_12(i1,i2).a(2,2))
      u5_1278(i1,i2,i7,i8).c(2,2)=u5_1278(i1,i2,i7,i8).c(2,2)+rm
     & ass(id5)*(l5_78(i7,i8).c(2,1)*u578_12(i1,i2).c(1,2)+l5_78
     & (i7,i8).a(2,2)*u578_12(i1,i2).d(2,2))
      u5_1278(i1,i2,i7,i8).d(2,2)=u5_1278(i1,i2,i7,i8).d(2,2)+l5
     & _78(i7,i8).b(2,1)*u578_12(i1,i2).c(1,2)+l5_78(i7,i8).d(2,
     & 2)*p578q*u578_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id5.eq.5.and.id7.eq.5.and.id1.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=u5_1278(i1,i2,i7,i8).a,bb=u5_1278(i1,i2,i7,i8).b,cc=u5_1278
* (i1,i2,i7,i8).c,dd=u5_1278(i1,i2,i7,i8).d,a1=l5_78(i7,i8).a,b1=l5_78(i
* 7,i8).b,c1=l5_78(i7,i8).c,d1=l5_78(i7,i8).d,a2=u578_12(i1,i2).a,b2=u57
* 8_12(i1,i2).b,c2=u578_12(i1,i2).c,d2=u578_12(i1,i2).d,prq=p578q,m=rmas
* s(id5),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u578_12(i1,i2).a(1,jut)+rmass(id5)*u578_12(i1,i2).b(1,
     & jut)
      cx2=u578_12(i1,i2).a(2,jut)+rmass(id5)*u578_12(i1,i2).b(2,
     & jut)
      cy1=p578q*u578_12(i1,i2).b(1,jut)+rmass(id5)*u578_12(i1,i2
     & ).a(1,jut)
      cy2=p578q*u578_12(i1,i2).b(2,jut)+rmass(id5)*u578_12(i1,i2
     & ).a(2,jut)
      u5_1278(i1,i2,i7,i8).a(iut,jut)=u5_1278(i1,i2,i7,i8).a(iut
     & ,jut)+l5_78(i7,i8).a(iut,1)*cx1+l5_78(i7,i8).c(iut,1)*cy1
     & +l5_78(i7,i8).a(iut,2)*cx2+l5_78(i7,i8).c(iut,2)*cy2
      u5_1278(i1,i2,i7,i8).b(iut,jut)=u5_1278(i1,i2,i7,i8).b(iut
     & ,jut)+l5_78(i7,i8).b(iut,1)*cx1+l5_78(i7,i8).d(iut,1)*cy1
     & +l5_78(i7,i8).b(iut,2)*cx2+l5_78(i7,i8).d(iut,2)*cy2
      cw1=u578_12(i1,i2).c(1,jut)+rmass(id5)*u578_12(i1,i2).d(1,
     & jut)
      cw2=u578_12(i1,i2).c(2,jut)+rmass(id5)*u578_12(i1,i2).d(2,
     & jut)
      cz1=p578q*u578_12(i1,i2).d(1,jut)+rmass(id5)*u578_12(i1,i2
     & ).c(1,jut)
      cz2=p578q*u578_12(i1,i2).d(2,jut)+rmass(id5)*u578_12(i1,i2
     & ).c(2,jut)
      u5_1278(i1,i2,i7,i8).c(iut,jut)=u5_1278(i1,i2,i7,i8).c(iut
     & ,jut)+l5_78(i7,i8).a(iut,1)*cw1+l5_78(i7,i8).c(iut,1)*cz1
     & +l5_78(i7,i8).a(iut,2)*cw2+l5_78(i7,i8).c(iut,2)*cz2
      u5_1278(i1,i2,i7,i8).d(iut,jut)=u5_1278(i1,i2,i7,i8).d(iut
     & ,jut)+l5_78(i7,i8).b(iut,1)*cw1+l5_78(i7,i8).d(iut,1)*cz1
     & +l5_78(i7,i8).b(iut,2)*cw2+l5_78(i7,i8).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id5.eq.5.and.id7.eq.5.and.id1.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=u5_1278(i1,i2,i7,i8).a,bb=u5_1278(i1,i2,i7,i8).b,cc=u5_1278(
* i1,i2,i7,i8).c,dd=u5_1278(i1,i2,i7,i8).d,a1=l5_78(i7,i8).a,b1=l5_78(i7
* ,i8).b,c1=l5_78(i7,i8).c,d1=l5_78(i7,i8).d,a2=u578_12(i1,i2).a,b2=u578
* _12(i1,i2).b,c2=u578_12(i1,i2).c,d2=u578_12(i1,i2).d,prq=p578q,m=rmass
* (id5),nsum=1
      do iut=1,2
      cx1=l5_78(i7,i8).a(iut,1)+l5_78(i7,i8).c(iut,1)*rmass(id5)
      cx2=l5_78(i7,i8).c(iut,2)*p578q+l5_78(i7,i8).a(iut,2)*rmas
     & s(id5)
      cy1=l5_78(i7,i8).b(iut,1)+l5_78(i7,i8).d(iut,1)*rmass(id5)
      cy2=l5_78(i7,i8).d(iut,2)*p578q+l5_78(i7,i8).b(iut,2)*rmas
     & s(id5)
      cw1=l5_78(i7,i8).c(iut,1)*p578q+l5_78(i7,i8).a(iut,1)*rmas
     & s(id5)
      cw2=l5_78(i7,i8).a(iut,2)+l5_78(i7,i8).c(iut,2)*rmass(id5)
      cz1=l5_78(i7,i8).d(iut,1)*p578q+l5_78(i7,i8).b(iut,1)*rmas
     & s(id5)
      cz2=l5_78(i7,i8).b(iut,2)+l5_78(i7,i8).d(iut,2)*rmass(id5)
      u5_1278(i1,i2,i7,i8).a(iut,1)=u5_1278(i1,i2,i7,i8).a(iut,1
     & )+cx1*u578_12(i1,i2).a(1,1)+cx2*u578_12(i1,i2).b(2,1)
      u5_1278(i1,i2,i7,i8).b(iut,1)=u5_1278(i1,i2,i7,i8).b(iut,1
     & )+cy1*u578_12(i1,i2).a(1,1)+cy2*u578_12(i1,i2).b(2,1)
      u5_1278(i1,i2,i7,i8).c(iut,1)=u5_1278(i1,i2,i7,i8).c(iut,1
     & )+cw1*u578_12(i1,i2).d(1,1)+cw2*u578_12(i1,i2).c(2,1)
      u5_1278(i1,i2,i7,i8).d(iut,1)=u5_1278(i1,i2,i7,i8).d(iut,1
     & )+cz1*u578_12(i1,i2).d(1,1)+cz2*u578_12(i1,i2).c(2,1)
      u5_1278(i1,i2,i7,i8).a(iut,2)=u5_1278(i1,i2,i7,i8).a(iut,2
     & )+cw1*u578_12(i1,i2).b(1,2)+cw2*u578_12(i1,i2).a(2,2)
      u5_1278(i1,i2,i7,i8).b(iut,2)=u5_1278(i1,i2,i7,i8).b(iut,2
     & )+cz1*u578_12(i1,i2).b(1,2)+cz2*u578_12(i1,i2).a(2,2)
      u5_1278(i1,i2,i7,i8).c(iut,2)=u5_1278(i1,i2,i7,i8).c(iut,2
     & )+cx1*u578_12(i1,i2).c(1,2)+cx2*u578_12(i1,i2).d(2,2)
      u5_1278(i1,i2,i7,i8).d(iut,2)=u5_1278(i1,i2,i7,i8).d(iut,2
     & )+cy1*u578_12(i1,i2).c(1,2)+cy2*u578_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id5.eq.5.and.id7.ne.5.and.id1.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
* TTs -- aa=u5_1278(i1,i2,i7,i8).a,bb=u5_1278(i1,i2,i7,i8).b,cc=u5_1278(
* i1,i2,i7,i8).c,dd=u5_1278(i1,i2,i7,i8).d,a1=l5_78(i7,i8).a,b1=l5_78(i7
* ,i8).b,c1=l5_78(i7,i8).c,d1=l5_78(i7,i8).d,a2=u578_12(i1,i2).a,b2=u578
* _12(i1,i2).b,c2=u578_12(i1,i2).c,d2=u578_12(i1,i2).d,prq=p578q,m=rmass
* (id5),nsum=1
      do jut=1,2
      cx1=u578_12(i1,i2).a(1,jut)+rmass(id5)*u578_12(i1,i2).b(1,
     & jut)
      cx2=u578_12(i1,i2).a(2,jut)+rmass(id5)*u578_12(i1,i2).b(2,
     & jut)
      cy1=p578q*u578_12(i1,i2).b(1,jut)+rmass(id5)*u578_12(i1,i2
     & ).a(1,jut)
      cy2=p578q*u578_12(i1,i2).b(2,jut)+rmass(id5)*u578_12(i1,i2
     & ).a(2,jut)
      cw1=u578_12(i1,i2).c(1,jut)+rmass(id5)*u578_12(i1,i2).d(1,
     & jut)
      cw2=u578_12(i1,i2).c(2,jut)+rmass(id5)*u578_12(i1,i2).d(2,
     & jut)
      cz1=p578q*u578_12(i1,i2).d(1,jut)+rmass(id5)*u578_12(i1,i2
     & ).c(1,jut)
      cz2=p578q*u578_12(i1,i2).d(2,jut)+rmass(id5)*u578_12(i1,i2
     & ).c(2,jut)
      u5_1278(i1,i2,i7,i8).a(1,jut)=u5_1278(i1,i2,i7,i8).a(1,jut
     & )+l5_78(i7,i8).a(1,1)*cx1+l5_78(i7,i8).c(1,2)*cy2
      u5_1278(i1,i2,i7,i8).b(1,jut)=u5_1278(i1,i2,i7,i8).b(1,jut
     & )+l5_78(i7,i8).d(1,1)*cy1+l5_78(i7,i8).b(1,2)*cx2
      u5_1278(i1,i2,i7,i8).c(1,jut)=u5_1278(i1,i2,i7,i8).c(1,jut
     & )+l5_78(i7,i8).a(1,1)*cw1+l5_78(i7,i8).c(1,2)*cz2
      u5_1278(i1,i2,i7,i8).d(1,jut)=u5_1278(i1,i2,i7,i8).d(1,jut
     & )+l5_78(i7,i8).d(1,1)*cz1+l5_78(i7,i8).b(1,2)*cw2
      u5_1278(i1,i2,i7,i8).a(2,jut)=u5_1278(i1,i2,i7,i8).a(2,jut
     & )+l5_78(i7,i8).c(2,1)*cy1+l5_78(i7,i8).a(2,2)*cx2
      u5_1278(i1,i2,i7,i8).b(2,jut)=u5_1278(i1,i2,i7,i8).b(2,jut
     & )+l5_78(i7,i8).b(2,1)*cx1+l5_78(i7,i8).d(2,2)*cy2
      u5_1278(i1,i2,i7,i8).c(2,jut)=u5_1278(i1,i2,i7,i8).c(2,jut
     & )+l5_78(i7,i8).c(2,1)*cz1+l5_78(i7,i8).a(2,2)*cw2
      u5_1278(i1,i2,i7,i8).d(2,jut)=u5_1278(i1,i2,i7,i8).d(2,jut
     & )+l5_78(i7,i8).b(2,1)*cw1+l5_78(i7,i8).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p534q,p=p534,q=p534,bef=,aft=
      p534q=(p534(0)*p534(0)-p534(1)*p534(1)-p534(2)*p534(2)-p53
     & 4(3)*p534(3))
  
      if(id5.ne.5.or.(id3.ne.5.and.id7.ne.5))then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=u5_3478(i3,i4,i7,i8).a,bb=u5_3478(i3,i4,i7,i8).b,cc=u5_3478(i
* 3,i4,i7,i8).c,dd=u5_3478(i3,i4,i7,i8).d,a1=l5_34(i3,i4).a,b1=l5_34(i3,
* i4).b,c1=l5_34(i3,i4).c,d1=l5_34(i3,i4).d,a2=u534_78(i7,i8).a,b2=u534_
* 78(i7,i8).b,c2=u534_78(i7,i8).c,d2=u534_78(i7,i8).d,prq=p534q,m=rmass(
* id5),nsum=1
      u5_3478(i3,i4,i7,i8).a(1,1)=u5_3478(i3,i4,i7,i8).a(1,1)+l5
     & _34(i3,i4).a(1,1)*u534_78(i7,i8).a(1,1)+l5_34(i3,i4).c(1,
     & 2)*p534q*u534_78(i7,i8).b(2,1)
      u5_3478(i3,i4,i7,i8).b(1,1)=u5_3478(i3,i4,i7,i8).b(1,1)+rm
     & ass(id5)*(l5_34(i3,i4).d(1,1)*u534_78(i7,i8).a(1,1)+l5_34
     & (i3,i4).b(1,2)*u534_78(i7,i8).b(2,1))
      u5_3478(i3,i4,i7,i8).c(1,1)=u5_3478(i3,i4,i7,i8).c(1,1)+rm
     & ass(id5)*(l5_34(i3,i4).a(1,1)*u534_78(i7,i8).d(1,1)+l5_34
     & (i3,i4).c(1,2)*u534_78(i7,i8).c(2,1))
      u5_3478(i3,i4,i7,i8).d(1,1)=u5_3478(i3,i4,i7,i8).d(1,1)+l5
     & _34(i3,i4).d(1,1)*p534q*u534_78(i7,i8).d(1,1)+l5_34(i3,i4
     & ).b(1,2)*u534_78(i7,i8).c(2,1)
      u5_3478(i3,i4,i7,i8).a(1,2)=u5_3478(i3,i4,i7,i8).a(1,2)+rm
     & ass(id5)*(l5_34(i3,i4).a(1,1)*u534_78(i7,i8).b(1,2)+l5_34
     & (i3,i4).c(1,2)*u534_78(i7,i8).a(2,2))
      u5_3478(i3,i4,i7,i8).b(1,2)=u5_3478(i3,i4,i7,i8).b(1,2)+l5
     & _34(i3,i4).d(1,1)*p534q*u534_78(i7,i8).b(1,2)+l5_34(i3,i4
     & ).b(1,2)*u534_78(i7,i8).a(2,2)
      u5_3478(i3,i4,i7,i8).c(1,2)=u5_3478(i3,i4,i7,i8).c(1,2)+l5
     & _34(i3,i4).a(1,1)*u534_78(i7,i8).c(1,2)+l5_34(i3,i4).c(1,
     & 2)*p534q*u534_78(i7,i8).d(2,2)
      u5_3478(i3,i4,i7,i8).d(1,2)=u5_3478(i3,i4,i7,i8).d(1,2)+rm
     & ass(id5)*(l5_34(i3,i4).d(1,1)*u534_78(i7,i8).c(1,2)+l5_34
     & (i3,i4).b(1,2)*u534_78(i7,i8).d(2,2))
      u5_3478(i3,i4,i7,i8).a(2,1)=u5_3478(i3,i4,i7,i8).a(2,1)+rm
     & ass(id5)*(l5_34(i3,i4).c(2,1)*u534_78(i7,i8).a(1,1)+l5_34
     & (i3,i4).a(2,2)*u534_78(i7,i8).b(2,1))
      u5_3478(i3,i4,i7,i8).b(2,1)=u5_3478(i3,i4,i7,i8).b(2,1)+l5
     & _34(i3,i4).b(2,1)*u534_78(i7,i8).a(1,1)+l5_34(i3,i4).d(2,
     & 2)*p534q*u534_78(i7,i8).b(2,1)
      u5_3478(i3,i4,i7,i8).c(2,1)=u5_3478(i3,i4,i7,i8).c(2,1)+l5
     & _34(i3,i4).c(2,1)*p534q*u534_78(i7,i8).d(1,1)+l5_34(i3,i4
     & ).a(2,2)*u534_78(i7,i8).c(2,1)
      u5_3478(i3,i4,i7,i8).d(2,1)=u5_3478(i3,i4,i7,i8).d(2,1)+rm
     & ass(id5)*(l5_34(i3,i4).b(2,1)*u534_78(i7,i8).d(1,1)+l5_34
     & (i3,i4).d(2,2)*u534_78(i7,i8).c(2,1))
      u5_3478(i3,i4,i7,i8).a(2,2)=u5_3478(i3,i4,i7,i8).a(2,2)+l5
     & _34(i3,i4).c(2,1)*p534q*u534_78(i7,i8).b(1,2)+l5_34(i3,i4
     & ).a(2,2)*u534_78(i7,i8).a(2,2)
      u5_3478(i3,i4,i7,i8).b(2,2)=u5_3478(i3,i4,i7,i8).b(2,2)+rm
     & ass(id5)*(l5_34(i3,i4).b(2,1)*u534_78(i7,i8).b(1,2)+l5_34
     & (i3,i4).d(2,2)*u534_78(i7,i8).a(2,2))
      u5_3478(i3,i4,i7,i8).c(2,2)=u5_3478(i3,i4,i7,i8).c(2,2)+rm
     & ass(id5)*(l5_34(i3,i4).c(2,1)*u534_78(i7,i8).c(1,2)+l5_34
     & (i3,i4).a(2,2)*u534_78(i7,i8).d(2,2))
      u5_3478(i3,i4,i7,i8).d(2,2)=u5_3478(i3,i4,i7,i8).d(2,2)+l5
     & _34(i3,i4).b(2,1)*u534_78(i7,i8).c(1,2)+l5_34(i3,i4).d(2,
     & 2)*p534q*u534_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id5.eq.5.and.id3.eq.5.and.id7.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=u5_3478(i3,i4,i7,i8).a,bb=u5_3478(i3,i4,i7,i8).b,cc=u5_3478
* (i3,i4,i7,i8).c,dd=u5_3478(i3,i4,i7,i8).d,a1=l5_34(i3,i4).a,b1=l5_34(i
* 3,i4).b,c1=l5_34(i3,i4).c,d1=l5_34(i3,i4).d,a2=u534_78(i7,i8).a,b2=u53
* 4_78(i7,i8).b,c2=u534_78(i7,i8).c,d2=u534_78(i7,i8).d,prq=p534q,m=rmas
* s(id5),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u534_78(i7,i8).a(1,jut)+rmass(id5)*u534_78(i7,i8).b(1,
     & jut)
      cx2=u534_78(i7,i8).a(2,jut)+rmass(id5)*u534_78(i7,i8).b(2,
     & jut)
      cy1=p534q*u534_78(i7,i8).b(1,jut)+rmass(id5)*u534_78(i7,i8
     & ).a(1,jut)
      cy2=p534q*u534_78(i7,i8).b(2,jut)+rmass(id5)*u534_78(i7,i8
     & ).a(2,jut)
      u5_3478(i3,i4,i7,i8).a(iut,jut)=u5_3478(i3,i4,i7,i8).a(iut
     & ,jut)+l5_34(i3,i4).a(iut,1)*cx1+l5_34(i3,i4).c(iut,1)*cy1
     & +l5_34(i3,i4).a(iut,2)*cx2+l5_34(i3,i4).c(iut,2)*cy2
      u5_3478(i3,i4,i7,i8).b(iut,jut)=u5_3478(i3,i4,i7,i8).b(iut
     & ,jut)+l5_34(i3,i4).b(iut,1)*cx1+l5_34(i3,i4).d(iut,1)*cy1
     & +l5_34(i3,i4).b(iut,2)*cx2+l5_34(i3,i4).d(iut,2)*cy2
      cw1=u534_78(i7,i8).c(1,jut)+rmass(id5)*u534_78(i7,i8).d(1,
     & jut)
      cw2=u534_78(i7,i8).c(2,jut)+rmass(id5)*u534_78(i7,i8).d(2,
     & jut)
      cz1=p534q*u534_78(i7,i8).d(1,jut)+rmass(id5)*u534_78(i7,i8
     & ).c(1,jut)
      cz2=p534q*u534_78(i7,i8).d(2,jut)+rmass(id5)*u534_78(i7,i8
     & ).c(2,jut)
      u5_3478(i3,i4,i7,i8).c(iut,jut)=u5_3478(i3,i4,i7,i8).c(iut
     & ,jut)+l5_34(i3,i4).a(iut,1)*cw1+l5_34(i3,i4).c(iut,1)*cz1
     & +l5_34(i3,i4).a(iut,2)*cw2+l5_34(i3,i4).c(iut,2)*cz2
      u5_3478(i3,i4,i7,i8).d(iut,jut)=u5_3478(i3,i4,i7,i8).d(iut
     & ,jut)+l5_34(i3,i4).b(iut,1)*cw1+l5_34(i3,i4).d(iut,1)*cz1
     & +l5_34(i3,i4).b(iut,2)*cw2+l5_34(i3,i4).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id5.eq.5.and.id3.eq.5.and.id7.ne.5)then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=u5_3478(i3,i4,i7,i8).a,bb=u5_3478(i3,i4,i7,i8).b,cc=u5_3478(
* i3,i4,i7,i8).c,dd=u5_3478(i3,i4,i7,i8).d,a1=l5_34(i3,i4).a,b1=l5_34(i3
* ,i4).b,c1=l5_34(i3,i4).c,d1=l5_34(i3,i4).d,a2=u534_78(i7,i8).a,b2=u534
* _78(i7,i8).b,c2=u534_78(i7,i8).c,d2=u534_78(i7,i8).d,prq=p534q,m=rmass
* (id5),nsum=1
      do iut=1,2
      cx1=l5_34(i3,i4).a(iut,1)+l5_34(i3,i4).c(iut,1)*rmass(id5)
      cx2=l5_34(i3,i4).c(iut,2)*p534q+l5_34(i3,i4).a(iut,2)*rmas
     & s(id5)
      cy1=l5_34(i3,i4).b(iut,1)+l5_34(i3,i4).d(iut,1)*rmass(id5)
      cy2=l5_34(i3,i4).d(iut,2)*p534q+l5_34(i3,i4).b(iut,2)*rmas
     & s(id5)
      cw1=l5_34(i3,i4).c(iut,1)*p534q+l5_34(i3,i4).a(iut,1)*rmas
     & s(id5)
      cw2=l5_34(i3,i4).a(iut,2)+l5_34(i3,i4).c(iut,2)*rmass(id5)
      cz1=l5_34(i3,i4).d(iut,1)*p534q+l5_34(i3,i4).b(iut,1)*rmas
     & s(id5)
      cz2=l5_34(i3,i4).b(iut,2)+l5_34(i3,i4).d(iut,2)*rmass(id5)
      u5_3478(i3,i4,i7,i8).a(iut,1)=u5_3478(i3,i4,i7,i8).a(iut,1
     & )+cx1*u534_78(i7,i8).a(1,1)+cx2*u534_78(i7,i8).b(2,1)
      u5_3478(i3,i4,i7,i8).b(iut,1)=u5_3478(i3,i4,i7,i8).b(iut,1
     & )+cy1*u534_78(i7,i8).a(1,1)+cy2*u534_78(i7,i8).b(2,1)
      u5_3478(i3,i4,i7,i8).c(iut,1)=u5_3478(i3,i4,i7,i8).c(iut,1
     & )+cw1*u534_78(i7,i8).d(1,1)+cw2*u534_78(i7,i8).c(2,1)
      u5_3478(i3,i4,i7,i8).d(iut,1)=u5_3478(i3,i4,i7,i8).d(iut,1
     & )+cz1*u534_78(i7,i8).d(1,1)+cz2*u534_78(i7,i8).c(2,1)
      u5_3478(i3,i4,i7,i8).a(iut,2)=u5_3478(i3,i4,i7,i8).a(iut,2
     & )+cw1*u534_78(i7,i8).b(1,2)+cw2*u534_78(i7,i8).a(2,2)
      u5_3478(i3,i4,i7,i8).b(iut,2)=u5_3478(i3,i4,i7,i8).b(iut,2
     & )+cz1*u534_78(i7,i8).b(1,2)+cz2*u534_78(i7,i8).a(2,2)
      u5_3478(i3,i4,i7,i8).c(iut,2)=u5_3478(i3,i4,i7,i8).c(iut,2
     & )+cx1*u534_78(i7,i8).c(1,2)+cx2*u534_78(i7,i8).d(2,2)
      u5_3478(i3,i4,i7,i8).d(iut,2)=u5_3478(i3,i4,i7,i8).d(iut,2
     & )+cy1*u534_78(i7,i8).c(1,2)+cy2*u534_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id5.eq.5.and.id3.ne.5.and.id7.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TTs -- aa=u5_3478(i3,i4,i7,i8).a,bb=u5_3478(i3,i4,i7,i8).b,cc=u5_3478(
* i3,i4,i7,i8).c,dd=u5_3478(i3,i4,i7,i8).d,a1=l5_34(i3,i4).a,b1=l5_34(i3
* ,i4).b,c1=l5_34(i3,i4).c,d1=l5_34(i3,i4).d,a2=u534_78(i7,i8).a,b2=u534
* _78(i7,i8).b,c2=u534_78(i7,i8).c,d2=u534_78(i7,i8).d,prq=p534q,m=rmass
* (id5),nsum=1
      do jut=1,2
      cx1=u534_78(i7,i8).a(1,jut)+rmass(id5)*u534_78(i7,i8).b(1,
     & jut)
      cx2=u534_78(i7,i8).a(2,jut)+rmass(id5)*u534_78(i7,i8).b(2,
     & jut)
      cy1=p534q*u534_78(i7,i8).b(1,jut)+rmass(id5)*u534_78(i7,i8
     & ).a(1,jut)
      cy2=p534q*u534_78(i7,i8).b(2,jut)+rmass(id5)*u534_78(i7,i8
     & ).a(2,jut)
      cw1=u534_78(i7,i8).c(1,jut)+rmass(id5)*u534_78(i7,i8).d(1,
     & jut)
      cw2=u534_78(i7,i8).c(2,jut)+rmass(id5)*u534_78(i7,i8).d(2,
     & jut)
      cz1=p534q*u534_78(i7,i8).d(1,jut)+rmass(id5)*u534_78(i7,i8
     & ).c(1,jut)
      cz2=p534q*u534_78(i7,i8).d(2,jut)+rmass(id5)*u534_78(i7,i8
     & ).c(2,jut)
      u5_3478(i3,i4,i7,i8).a(1,jut)=u5_3478(i3,i4,i7,i8).a(1,jut
     & )+l5_34(i3,i4).a(1,1)*cx1+l5_34(i3,i4).c(1,2)*cy2
      u5_3478(i3,i4,i7,i8).b(1,jut)=u5_3478(i3,i4,i7,i8).b(1,jut
     & )+l5_34(i3,i4).d(1,1)*cy1+l5_34(i3,i4).b(1,2)*cx2
      u5_3478(i3,i4,i7,i8).c(1,jut)=u5_3478(i3,i4,i7,i8).c(1,jut
     & )+l5_34(i3,i4).a(1,1)*cw1+l5_34(i3,i4).c(1,2)*cz2
      u5_3478(i3,i4,i7,i8).d(1,jut)=u5_3478(i3,i4,i7,i8).d(1,jut
     & )+l5_34(i3,i4).d(1,1)*cz1+l5_34(i3,i4).b(1,2)*cw2
      u5_3478(i3,i4,i7,i8).a(2,jut)=u5_3478(i3,i4,i7,i8).a(2,jut
     & )+l5_34(i3,i4).c(2,1)*cy1+l5_34(i3,i4).a(2,2)*cx2
      u5_3478(i3,i4,i7,i8).b(2,jut)=u5_3478(i3,i4,i7,i8).b(2,jut
     & )+l5_34(i3,i4).b(2,1)*cx1+l5_34(i3,i4).d(2,2)*cy2
      u5_3478(i3,i4,i7,i8).c(2,jut)=u5_3478(i3,i4,i7,i8).c(2,jut
     & )+l5_34(i3,i4).c(2,1)*cz1+l5_34(i3,i4).a(2,2)*cw2
      u5_3478(i3,i4,i7,i8).d(2,jut)=u5_3478(i3,i4,i7,i8).d(2,jut
     & )+l5_34(i3,i4).b(2,1)*cw1+l5_34(i3,i4).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p578q,p=p578,q=p578,bef=,aft=
      p578q=(p578(0)*p578(0)-p578(1)*p578(1)-p578(2)*p578(2)-p57
     & 8(3)*p578(3))
  
      if(id5.ne.5.or.(id7.ne.5.and.id3.ne.5))then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=u5_3478(i3,i4,i7,i8).a,bb=u5_3478(i3,i4,i7,i8).b,cc=u5_3478(i
* 3,i4,i7,i8).c,dd=u5_3478(i3,i4,i7,i8).d,a1=l5_78(i7,i8).a,b1=l5_78(i7,
* i8).b,c1=l5_78(i7,i8).c,d1=l5_78(i7,i8).d,a2=u578_34(i3,i4).a,b2=u578_
* 34(i3,i4).b,c2=u578_34(i3,i4).c,d2=u578_34(i3,i4).d,prq=p578q,m=rmass(
* id5),nsum=1
      u5_3478(i3,i4,i7,i8).a(1,1)=u5_3478(i3,i4,i7,i8).a(1,1)+l5
     & _78(i7,i8).a(1,1)*u578_34(i3,i4).a(1,1)+l5_78(i7,i8).c(1,
     & 2)*p578q*u578_34(i3,i4).b(2,1)
      u5_3478(i3,i4,i7,i8).b(1,1)=u5_3478(i3,i4,i7,i8).b(1,1)+rm
     & ass(id5)*(l5_78(i7,i8).d(1,1)*u578_34(i3,i4).a(1,1)+l5_78
     & (i7,i8).b(1,2)*u578_34(i3,i4).b(2,1))
      u5_3478(i3,i4,i7,i8).c(1,1)=u5_3478(i3,i4,i7,i8).c(1,1)+rm
     & ass(id5)*(l5_78(i7,i8).a(1,1)*u578_34(i3,i4).d(1,1)+l5_78
     & (i7,i8).c(1,2)*u578_34(i3,i4).c(2,1))
      u5_3478(i3,i4,i7,i8).d(1,1)=u5_3478(i3,i4,i7,i8).d(1,1)+l5
     & _78(i7,i8).d(1,1)*p578q*u578_34(i3,i4).d(1,1)+l5_78(i7,i8
     & ).b(1,2)*u578_34(i3,i4).c(2,1)
      u5_3478(i3,i4,i7,i8).a(1,2)=u5_3478(i3,i4,i7,i8).a(1,2)+rm
     & ass(id5)*(l5_78(i7,i8).a(1,1)*u578_34(i3,i4).b(1,2)+l5_78
     & (i7,i8).c(1,2)*u578_34(i3,i4).a(2,2))
      u5_3478(i3,i4,i7,i8).b(1,2)=u5_3478(i3,i4,i7,i8).b(1,2)+l5
     & _78(i7,i8).d(1,1)*p578q*u578_34(i3,i4).b(1,2)+l5_78(i7,i8
     & ).b(1,2)*u578_34(i3,i4).a(2,2)
      u5_3478(i3,i4,i7,i8).c(1,2)=u5_3478(i3,i4,i7,i8).c(1,2)+l5
     & _78(i7,i8).a(1,1)*u578_34(i3,i4).c(1,2)+l5_78(i7,i8).c(1,
     & 2)*p578q*u578_34(i3,i4).d(2,2)
      u5_3478(i3,i4,i7,i8).d(1,2)=u5_3478(i3,i4,i7,i8).d(1,2)+rm
     & ass(id5)*(l5_78(i7,i8).d(1,1)*u578_34(i3,i4).c(1,2)+l5_78
     & (i7,i8).b(1,2)*u578_34(i3,i4).d(2,2))
      u5_3478(i3,i4,i7,i8).a(2,1)=u5_3478(i3,i4,i7,i8).a(2,1)+rm
     & ass(id5)*(l5_78(i7,i8).c(2,1)*u578_34(i3,i4).a(1,1)+l5_78
     & (i7,i8).a(2,2)*u578_34(i3,i4).b(2,1))
      u5_3478(i3,i4,i7,i8).b(2,1)=u5_3478(i3,i4,i7,i8).b(2,1)+l5
     & _78(i7,i8).b(2,1)*u578_34(i3,i4).a(1,1)+l5_78(i7,i8).d(2,
     & 2)*p578q*u578_34(i3,i4).b(2,1)
      u5_3478(i3,i4,i7,i8).c(2,1)=u5_3478(i3,i4,i7,i8).c(2,1)+l5
     & _78(i7,i8).c(2,1)*p578q*u578_34(i3,i4).d(1,1)+l5_78(i7,i8
     & ).a(2,2)*u578_34(i3,i4).c(2,1)
      u5_3478(i3,i4,i7,i8).d(2,1)=u5_3478(i3,i4,i7,i8).d(2,1)+rm
     & ass(id5)*(l5_78(i7,i8).b(2,1)*u578_34(i3,i4).d(1,1)+l5_78
     & (i7,i8).d(2,2)*u578_34(i3,i4).c(2,1))
      u5_3478(i3,i4,i7,i8).a(2,2)=u5_3478(i3,i4,i7,i8).a(2,2)+l5
     & _78(i7,i8).c(2,1)*p578q*u578_34(i3,i4).b(1,2)+l5_78(i7,i8
     & ).a(2,2)*u578_34(i3,i4).a(2,2)
      u5_3478(i3,i4,i7,i8).b(2,2)=u5_3478(i3,i4,i7,i8).b(2,2)+rm
     & ass(id5)*(l5_78(i7,i8).b(2,1)*u578_34(i3,i4).b(1,2)+l5_78
     & (i7,i8).d(2,2)*u578_34(i3,i4).a(2,2))
      u5_3478(i3,i4,i7,i8).c(2,2)=u5_3478(i3,i4,i7,i8).c(2,2)+rm
     & ass(id5)*(l5_78(i7,i8).c(2,1)*u578_34(i3,i4).c(1,2)+l5_78
     & (i7,i8).a(2,2)*u578_34(i3,i4).d(2,2))
      u5_3478(i3,i4,i7,i8).d(2,2)=u5_3478(i3,i4,i7,i8).d(2,2)+l5
     & _78(i7,i8).b(2,1)*u578_34(i3,i4).c(1,2)+l5_78(i7,i8).d(2,
     & 2)*p578q*u578_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id5.eq.5.and.id7.eq.5.and.id3.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=u5_3478(i3,i4,i7,i8).a,bb=u5_3478(i3,i4,i7,i8).b,cc=u5_3478
* (i3,i4,i7,i8).c,dd=u5_3478(i3,i4,i7,i8).d,a1=l5_78(i7,i8).a,b1=l5_78(i
* 7,i8).b,c1=l5_78(i7,i8).c,d1=l5_78(i7,i8).d,a2=u578_34(i3,i4).a,b2=u57
* 8_34(i3,i4).b,c2=u578_34(i3,i4).c,d2=u578_34(i3,i4).d,prq=p578q,m=rmas
* s(id5),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u578_34(i3,i4).a(1,jut)+rmass(id5)*u578_34(i3,i4).b(1,
     & jut)
      cx2=u578_34(i3,i4).a(2,jut)+rmass(id5)*u578_34(i3,i4).b(2,
     & jut)
      cy1=p578q*u578_34(i3,i4).b(1,jut)+rmass(id5)*u578_34(i3,i4
     & ).a(1,jut)
      cy2=p578q*u578_34(i3,i4).b(2,jut)+rmass(id5)*u578_34(i3,i4
     & ).a(2,jut)
      u5_3478(i3,i4,i7,i8).a(iut,jut)=u5_3478(i3,i4,i7,i8).a(iut
     & ,jut)+l5_78(i7,i8).a(iut,1)*cx1+l5_78(i7,i8).c(iut,1)*cy1
     & +l5_78(i7,i8).a(iut,2)*cx2+l5_78(i7,i8).c(iut,2)*cy2
      u5_3478(i3,i4,i7,i8).b(iut,jut)=u5_3478(i3,i4,i7,i8).b(iut
     & ,jut)+l5_78(i7,i8).b(iut,1)*cx1+l5_78(i7,i8).d(iut,1)*cy1
     & +l5_78(i7,i8).b(iut,2)*cx2+l5_78(i7,i8).d(iut,2)*cy2
      cw1=u578_34(i3,i4).c(1,jut)+rmass(id5)*u578_34(i3,i4).d(1,
     & jut)
      cw2=u578_34(i3,i4).c(2,jut)+rmass(id5)*u578_34(i3,i4).d(2,
     & jut)
      cz1=p578q*u578_34(i3,i4).d(1,jut)+rmass(id5)*u578_34(i3,i4
     & ).c(1,jut)
      cz2=p578q*u578_34(i3,i4).d(2,jut)+rmass(id5)*u578_34(i3,i4
     & ).c(2,jut)
      u5_3478(i3,i4,i7,i8).c(iut,jut)=u5_3478(i3,i4,i7,i8).c(iut
     & ,jut)+l5_78(i7,i8).a(iut,1)*cw1+l5_78(i7,i8).c(iut,1)*cz1
     & +l5_78(i7,i8).a(iut,2)*cw2+l5_78(i7,i8).c(iut,2)*cz2
      u5_3478(i3,i4,i7,i8).d(iut,jut)=u5_3478(i3,i4,i7,i8).d(iut
     & ,jut)+l5_78(i7,i8).b(iut,1)*cw1+l5_78(i7,i8).d(iut,1)*cz1
     & +l5_78(i7,i8).b(iut,2)*cw2+l5_78(i7,i8).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id5.eq.5.and.id7.eq.5.and.id3.ne.5)then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=u5_3478(i3,i4,i7,i8).a,bb=u5_3478(i3,i4,i7,i8).b,cc=u5_3478(
* i3,i4,i7,i8).c,dd=u5_3478(i3,i4,i7,i8).d,a1=l5_78(i7,i8).a,b1=l5_78(i7
* ,i8).b,c1=l5_78(i7,i8).c,d1=l5_78(i7,i8).d,a2=u578_34(i3,i4).a,b2=u578
* _34(i3,i4).b,c2=u578_34(i3,i4).c,d2=u578_34(i3,i4).d,prq=p578q,m=rmass
* (id5),nsum=1
      do iut=1,2
      cx1=l5_78(i7,i8).a(iut,1)+l5_78(i7,i8).c(iut,1)*rmass(id5)
      cx2=l5_78(i7,i8).c(iut,2)*p578q+l5_78(i7,i8).a(iut,2)*rmas
     & s(id5)
      cy1=l5_78(i7,i8).b(iut,1)+l5_78(i7,i8).d(iut,1)*rmass(id5)
      cy2=l5_78(i7,i8).d(iut,2)*p578q+l5_78(i7,i8).b(iut,2)*rmas
     & s(id5)
      cw1=l5_78(i7,i8).c(iut,1)*p578q+l5_78(i7,i8).a(iut,1)*rmas
     & s(id5)
      cw2=l5_78(i7,i8).a(iut,2)+l5_78(i7,i8).c(iut,2)*rmass(id5)
      cz1=l5_78(i7,i8).d(iut,1)*p578q+l5_78(i7,i8).b(iut,1)*rmas
     & s(id5)
      cz2=l5_78(i7,i8).b(iut,2)+l5_78(i7,i8).d(iut,2)*rmass(id5)
      u5_3478(i3,i4,i7,i8).a(iut,1)=u5_3478(i3,i4,i7,i8).a(iut,1
     & )+cx1*u578_34(i3,i4).a(1,1)+cx2*u578_34(i3,i4).b(2,1)
      u5_3478(i3,i4,i7,i8).b(iut,1)=u5_3478(i3,i4,i7,i8).b(iut,1
     & )+cy1*u578_34(i3,i4).a(1,1)+cy2*u578_34(i3,i4).b(2,1)
      u5_3478(i3,i4,i7,i8).c(iut,1)=u5_3478(i3,i4,i7,i8).c(iut,1
     & )+cw1*u578_34(i3,i4).d(1,1)+cw2*u578_34(i3,i4).c(2,1)
      u5_3478(i3,i4,i7,i8).d(iut,1)=u5_3478(i3,i4,i7,i8).d(iut,1
     & )+cz1*u578_34(i3,i4).d(1,1)+cz2*u578_34(i3,i4).c(2,1)
      u5_3478(i3,i4,i7,i8).a(iut,2)=u5_3478(i3,i4,i7,i8).a(iut,2
     & )+cw1*u578_34(i3,i4).b(1,2)+cw2*u578_34(i3,i4).a(2,2)
      u5_3478(i3,i4,i7,i8).b(iut,2)=u5_3478(i3,i4,i7,i8).b(iut,2
     & )+cz1*u578_34(i3,i4).b(1,2)+cz2*u578_34(i3,i4).a(2,2)
      u5_3478(i3,i4,i7,i8).c(iut,2)=u5_3478(i3,i4,i7,i8).c(iut,2
     & )+cx1*u578_34(i3,i4).c(1,2)+cx2*u578_34(i3,i4).d(2,2)
      u5_3478(i3,i4,i7,i8).d(iut,2)=u5_3478(i3,i4,i7,i8).d(iut,2
     & )+cy1*u578_34(i3,i4).c(1,2)+cy2*u578_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id5.eq.5.and.id7.ne.5.and.id3.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TTs -- aa=u5_3478(i3,i4,i7,i8).a,bb=u5_3478(i3,i4,i7,i8).b,cc=u5_3478(
* i3,i4,i7,i8).c,dd=u5_3478(i3,i4,i7,i8).d,a1=l5_78(i7,i8).a,b1=l5_78(i7
* ,i8).b,c1=l5_78(i7,i8).c,d1=l5_78(i7,i8).d,a2=u578_34(i3,i4).a,b2=u578
* _34(i3,i4).b,c2=u578_34(i3,i4).c,d2=u578_34(i3,i4).d,prq=p578q,m=rmass
* (id5),nsum=1
      do jut=1,2
      cx1=u578_34(i3,i4).a(1,jut)+rmass(id5)*u578_34(i3,i4).b(1,
     & jut)
      cx2=u578_34(i3,i4).a(2,jut)+rmass(id5)*u578_34(i3,i4).b(2,
     & jut)
      cy1=p578q*u578_34(i3,i4).b(1,jut)+rmass(id5)*u578_34(i3,i4
     & ).a(1,jut)
      cy2=p578q*u578_34(i3,i4).b(2,jut)+rmass(id5)*u578_34(i3,i4
     & ).a(2,jut)
      cw1=u578_34(i3,i4).c(1,jut)+rmass(id5)*u578_34(i3,i4).d(1,
     & jut)
      cw2=u578_34(i3,i4).c(2,jut)+rmass(id5)*u578_34(i3,i4).d(2,
     & jut)
      cz1=p578q*u578_34(i3,i4).d(1,jut)+rmass(id5)*u578_34(i3,i4
     & ).c(1,jut)
      cz2=p578q*u578_34(i3,i4).d(2,jut)+rmass(id5)*u578_34(i3,i4
     & ).c(2,jut)
      u5_3478(i3,i4,i7,i8).a(1,jut)=u5_3478(i3,i4,i7,i8).a(1,jut
     & )+l5_78(i7,i8).a(1,1)*cx1+l5_78(i7,i8).c(1,2)*cy2
      u5_3478(i3,i4,i7,i8).b(1,jut)=u5_3478(i3,i4,i7,i8).b(1,jut
     & )+l5_78(i7,i8).d(1,1)*cy1+l5_78(i7,i8).b(1,2)*cx2
      u5_3478(i3,i4,i7,i8).c(1,jut)=u5_3478(i3,i4,i7,i8).c(1,jut
     & )+l5_78(i7,i8).a(1,1)*cw1+l5_78(i7,i8).c(1,2)*cz2
      u5_3478(i3,i4,i7,i8).d(1,jut)=u5_3478(i3,i4,i7,i8).d(1,jut
     & )+l5_78(i7,i8).d(1,1)*cz1+l5_78(i7,i8).b(1,2)*cw2
      u5_3478(i3,i4,i7,i8).a(2,jut)=u5_3478(i3,i4,i7,i8).a(2,jut
     & )+l5_78(i7,i8).c(2,1)*cy1+l5_78(i7,i8).a(2,2)*cx2
      u5_3478(i3,i4,i7,i8).b(2,jut)=u5_3478(i3,i4,i7,i8).b(2,jut
     & )+l5_78(i7,i8).b(2,1)*cx1+l5_78(i7,i8).d(2,2)*cy2
      u5_3478(i3,i4,i7,i8).c(2,jut)=u5_3478(i3,i4,i7,i8).c(2,jut
     & )+l5_78(i7,i8).c(2,1)*cz1+l5_78(i7,i8).a(2,2)*cw2
      u5_3478(i3,i4,i7,i8).d(2,jut)=u5_3478(i3,i4,i7,i8).d(2,jut
     & )+l5_78(i7,i8).b(2,1)*cw1+l5_78(i7,i8).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p712q,p=p712,q=p712,bef=,aft=
      p712q=(p712(0)*p712(0)-p712(1)*p712(1)-p712(2)*p712(2)-p71
     & 2(3)*p712(3))
  
      if(id7.ne.5.or.(id1.ne.5.and.id3.ne.5))then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TT -- aa=u7_1234(i1,i2,i3,i4).a,bb=u7_1234(i1,i2,i3,i4).b,cc=u7_1234(i
* 1,i2,i3,i4).c,dd=u7_1234(i1,i2,i3,i4).d,a1=l7_12(i1,i2).a,b1=l7_12(i1,
* i2).b,c1=l7_12(i1,i2).c,d1=l7_12(i1,i2).d,a2=u712_34(i3,i4).a,b2=u712_
* 34(i3,i4).b,c2=u712_34(i3,i4).c,d2=u712_34(i3,i4).d,prq=p712q,m=rmass(
* id7),nsum=1
      u7_1234(i1,i2,i3,i4).a(1,1)=u7_1234(i1,i2,i3,i4).a(1,1)+l7
     & _12(i1,i2).a(1,1)*u712_34(i3,i4).a(1,1)+l7_12(i1,i2).c(1,
     & 2)*p712q*u712_34(i3,i4).b(2,1)
      u7_1234(i1,i2,i3,i4).b(1,1)=u7_1234(i1,i2,i3,i4).b(1,1)+rm
     & ass(id7)*(l7_12(i1,i2).d(1,1)*u712_34(i3,i4).a(1,1)+l7_12
     & (i1,i2).b(1,2)*u712_34(i3,i4).b(2,1))
      u7_1234(i1,i2,i3,i4).c(1,1)=u7_1234(i1,i2,i3,i4).c(1,1)+rm
     & ass(id7)*(l7_12(i1,i2).a(1,1)*u712_34(i3,i4).d(1,1)+l7_12
     & (i1,i2).c(1,2)*u712_34(i3,i4).c(2,1))
      u7_1234(i1,i2,i3,i4).d(1,1)=u7_1234(i1,i2,i3,i4).d(1,1)+l7
     & _12(i1,i2).d(1,1)*p712q*u712_34(i3,i4).d(1,1)+l7_12(i1,i2
     & ).b(1,2)*u712_34(i3,i4).c(2,1)
      u7_1234(i1,i2,i3,i4).a(1,2)=u7_1234(i1,i2,i3,i4).a(1,2)+rm
     & ass(id7)*(l7_12(i1,i2).a(1,1)*u712_34(i3,i4).b(1,2)+l7_12
     & (i1,i2).c(1,2)*u712_34(i3,i4).a(2,2))
      u7_1234(i1,i2,i3,i4).b(1,2)=u7_1234(i1,i2,i3,i4).b(1,2)+l7
     & _12(i1,i2).d(1,1)*p712q*u712_34(i3,i4).b(1,2)+l7_12(i1,i2
     & ).b(1,2)*u712_34(i3,i4).a(2,2)
      u7_1234(i1,i2,i3,i4).c(1,2)=u7_1234(i1,i2,i3,i4).c(1,2)+l7
     & _12(i1,i2).a(1,1)*u712_34(i3,i4).c(1,2)+l7_12(i1,i2).c(1,
     & 2)*p712q*u712_34(i3,i4).d(2,2)
      u7_1234(i1,i2,i3,i4).d(1,2)=u7_1234(i1,i2,i3,i4).d(1,2)+rm
     & ass(id7)*(l7_12(i1,i2).d(1,1)*u712_34(i3,i4).c(1,2)+l7_12
     & (i1,i2).b(1,2)*u712_34(i3,i4).d(2,2))
      u7_1234(i1,i2,i3,i4).a(2,1)=u7_1234(i1,i2,i3,i4).a(2,1)+rm
     & ass(id7)*(l7_12(i1,i2).c(2,1)*u712_34(i3,i4).a(1,1)+l7_12
     & (i1,i2).a(2,2)*u712_34(i3,i4).b(2,1))
      u7_1234(i1,i2,i3,i4).b(2,1)=u7_1234(i1,i2,i3,i4).b(2,1)+l7
     & _12(i1,i2).b(2,1)*u712_34(i3,i4).a(1,1)+l7_12(i1,i2).d(2,
     & 2)*p712q*u712_34(i3,i4).b(2,1)
      u7_1234(i1,i2,i3,i4).c(2,1)=u7_1234(i1,i2,i3,i4).c(2,1)+l7
     & _12(i1,i2).c(2,1)*p712q*u712_34(i3,i4).d(1,1)+l7_12(i1,i2
     & ).a(2,2)*u712_34(i3,i4).c(2,1)
      u7_1234(i1,i2,i3,i4).d(2,1)=u7_1234(i1,i2,i3,i4).d(2,1)+rm
     & ass(id7)*(l7_12(i1,i2).b(2,1)*u712_34(i3,i4).d(1,1)+l7_12
     & (i1,i2).d(2,2)*u712_34(i3,i4).c(2,1))
      u7_1234(i1,i2,i3,i4).a(2,2)=u7_1234(i1,i2,i3,i4).a(2,2)+l7
     & _12(i1,i2).c(2,1)*p712q*u712_34(i3,i4).b(1,2)+l7_12(i1,i2
     & ).a(2,2)*u712_34(i3,i4).a(2,2)
      u7_1234(i1,i2,i3,i4).b(2,2)=u7_1234(i1,i2,i3,i4).b(2,2)+rm
     & ass(id7)*(l7_12(i1,i2).b(2,1)*u712_34(i3,i4).b(1,2)+l7_12
     & (i1,i2).d(2,2)*u712_34(i3,i4).a(2,2))
      u7_1234(i1,i2,i3,i4).c(2,2)=u7_1234(i1,i2,i3,i4).c(2,2)+rm
     & ass(id7)*(l7_12(i1,i2).c(2,1)*u712_34(i3,i4).c(1,2)+l7_12
     & (i1,i2).a(2,2)*u712_34(i3,i4).d(2,2))
      u7_1234(i1,i2,i3,i4).d(2,2)=u7_1234(i1,i2,i3,i4).d(2,2)+l7
     & _12(i1,i2).b(2,1)*u712_34(i3,i4).c(1,2)+l7_12(i1,i2).d(2,
     & 2)*p712q*u712_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id7.eq.5.and.id1.eq.5.and.id3.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TsTs -- aa=u7_1234(i1,i2,i3,i4).a,bb=u7_1234(i1,i2,i3,i4).b,cc=u7_1234
* (i1,i2,i3,i4).c,dd=u7_1234(i1,i2,i3,i4).d,a1=l7_12(i1,i2).a,b1=l7_12(i
* 1,i2).b,c1=l7_12(i1,i2).c,d1=l7_12(i1,i2).d,a2=u712_34(i3,i4).a,b2=u71
* 2_34(i3,i4).b,c2=u712_34(i3,i4).c,d2=u712_34(i3,i4).d,prq=p712q,m=rmas
* s(id7),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u712_34(i3,i4).a(1,jut)+rmass(id7)*u712_34(i3,i4).b(1,
     & jut)
      cx2=u712_34(i3,i4).a(2,jut)+rmass(id7)*u712_34(i3,i4).b(2,
     & jut)
      cy1=p712q*u712_34(i3,i4).b(1,jut)+rmass(id7)*u712_34(i3,i4
     & ).a(1,jut)
      cy2=p712q*u712_34(i3,i4).b(2,jut)+rmass(id7)*u712_34(i3,i4
     & ).a(2,jut)
      u7_1234(i1,i2,i3,i4).a(iut,jut)=u7_1234(i1,i2,i3,i4).a(iut
     & ,jut)+l7_12(i1,i2).a(iut,1)*cx1+l7_12(i1,i2).c(iut,1)*cy1
     & +l7_12(i1,i2).a(iut,2)*cx2+l7_12(i1,i2).c(iut,2)*cy2
      u7_1234(i1,i2,i3,i4).b(iut,jut)=u7_1234(i1,i2,i3,i4).b(iut
     & ,jut)+l7_12(i1,i2).b(iut,1)*cx1+l7_12(i1,i2).d(iut,1)*cy1
     & +l7_12(i1,i2).b(iut,2)*cx2+l7_12(i1,i2).d(iut,2)*cy2
      cw1=u712_34(i3,i4).c(1,jut)+rmass(id7)*u712_34(i3,i4).d(1,
     & jut)
      cw2=u712_34(i3,i4).c(2,jut)+rmass(id7)*u712_34(i3,i4).d(2,
     & jut)
      cz1=p712q*u712_34(i3,i4).d(1,jut)+rmass(id7)*u712_34(i3,i4
     & ).c(1,jut)
      cz2=p712q*u712_34(i3,i4).d(2,jut)+rmass(id7)*u712_34(i3,i4
     & ).c(2,jut)
      u7_1234(i1,i2,i3,i4).c(iut,jut)=u7_1234(i1,i2,i3,i4).c(iut
     & ,jut)+l7_12(i1,i2).a(iut,1)*cw1+l7_12(i1,i2).c(iut,1)*cz1
     & +l7_12(i1,i2).a(iut,2)*cw2+l7_12(i1,i2).c(iut,2)*cz2
      u7_1234(i1,i2,i3,i4).d(iut,jut)=u7_1234(i1,i2,i3,i4).d(iut
     & ,jut)+l7_12(i1,i2).b(iut,1)*cw1+l7_12(i1,i2).d(iut,1)*cz1
     & +l7_12(i1,i2).b(iut,2)*cw2+l7_12(i1,i2).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id7.eq.5.and.id1.eq.5.and.id3.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TsT -- aa=u7_1234(i1,i2,i3,i4).a,bb=u7_1234(i1,i2,i3,i4).b,cc=u7_1234(
* i1,i2,i3,i4).c,dd=u7_1234(i1,i2,i3,i4).d,a1=l7_12(i1,i2).a,b1=l7_12(i1
* ,i2).b,c1=l7_12(i1,i2).c,d1=l7_12(i1,i2).d,a2=u712_34(i3,i4).a,b2=u712
* _34(i3,i4).b,c2=u712_34(i3,i4).c,d2=u712_34(i3,i4).d,prq=p712q,m=rmass
* (id7),nsum=1
      do iut=1,2
      cx1=l7_12(i1,i2).a(iut,1)+l7_12(i1,i2).c(iut,1)*rmass(id7)
      cx2=l7_12(i1,i2).c(iut,2)*p712q+l7_12(i1,i2).a(iut,2)*rmas
     & s(id7)
      cy1=l7_12(i1,i2).b(iut,1)+l7_12(i1,i2).d(iut,1)*rmass(id7)
      cy2=l7_12(i1,i2).d(iut,2)*p712q+l7_12(i1,i2).b(iut,2)*rmas
     & s(id7)
      cw1=l7_12(i1,i2).c(iut,1)*p712q+l7_12(i1,i2).a(iut,1)*rmas
     & s(id7)
      cw2=l7_12(i1,i2).a(iut,2)+l7_12(i1,i2).c(iut,2)*rmass(id7)
      cz1=l7_12(i1,i2).d(iut,1)*p712q+l7_12(i1,i2).b(iut,1)*rmas
     & s(id7)
      cz2=l7_12(i1,i2).b(iut,2)+l7_12(i1,i2).d(iut,2)*rmass(id7)
      u7_1234(i1,i2,i3,i4).a(iut,1)=u7_1234(i1,i2,i3,i4).a(iut,1
     & )+cx1*u712_34(i3,i4).a(1,1)+cx2*u712_34(i3,i4).b(2,1)
      u7_1234(i1,i2,i3,i4).b(iut,1)=u7_1234(i1,i2,i3,i4).b(iut,1
     & )+cy1*u712_34(i3,i4).a(1,1)+cy2*u712_34(i3,i4).b(2,1)
      u7_1234(i1,i2,i3,i4).c(iut,1)=u7_1234(i1,i2,i3,i4).c(iut,1
     & )+cw1*u712_34(i3,i4).d(1,1)+cw2*u712_34(i3,i4).c(2,1)
      u7_1234(i1,i2,i3,i4).d(iut,1)=u7_1234(i1,i2,i3,i4).d(iut,1
     & )+cz1*u712_34(i3,i4).d(1,1)+cz2*u712_34(i3,i4).c(2,1)
      u7_1234(i1,i2,i3,i4).a(iut,2)=u7_1234(i1,i2,i3,i4).a(iut,2
     & )+cw1*u712_34(i3,i4).b(1,2)+cw2*u712_34(i3,i4).a(2,2)
      u7_1234(i1,i2,i3,i4).b(iut,2)=u7_1234(i1,i2,i3,i4).b(iut,2
     & )+cz1*u712_34(i3,i4).b(1,2)+cz2*u712_34(i3,i4).a(2,2)
      u7_1234(i1,i2,i3,i4).c(iut,2)=u7_1234(i1,i2,i3,i4).c(iut,2
     & )+cx1*u712_34(i3,i4).c(1,2)+cx2*u712_34(i3,i4).d(2,2)
      u7_1234(i1,i2,i3,i4).d(iut,2)=u7_1234(i1,i2,i3,i4).d(iut,2
     & )+cy1*u712_34(i3,i4).c(1,2)+cy2*u712_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id7.eq.5.and.id1.ne.5.and.id3.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TTs -- aa=u7_1234(i1,i2,i3,i4).a,bb=u7_1234(i1,i2,i3,i4).b,cc=u7_1234(
* i1,i2,i3,i4).c,dd=u7_1234(i1,i2,i3,i4).d,a1=l7_12(i1,i2).a,b1=l7_12(i1
* ,i2).b,c1=l7_12(i1,i2).c,d1=l7_12(i1,i2).d,a2=u712_34(i3,i4).a,b2=u712
* _34(i3,i4).b,c2=u712_34(i3,i4).c,d2=u712_34(i3,i4).d,prq=p712q,m=rmass
* (id7),nsum=1
      do jut=1,2
      cx1=u712_34(i3,i4).a(1,jut)+rmass(id7)*u712_34(i3,i4).b(1,
     & jut)
      cx2=u712_34(i3,i4).a(2,jut)+rmass(id7)*u712_34(i3,i4).b(2,
     & jut)
      cy1=p712q*u712_34(i3,i4).b(1,jut)+rmass(id7)*u712_34(i3,i4
     & ).a(1,jut)
      cy2=p712q*u712_34(i3,i4).b(2,jut)+rmass(id7)*u712_34(i3,i4
     & ).a(2,jut)
      cw1=u712_34(i3,i4).c(1,jut)+rmass(id7)*u712_34(i3,i4).d(1,
     & jut)
      cw2=u712_34(i3,i4).c(2,jut)+rmass(id7)*u712_34(i3,i4).d(2,
     & jut)
      cz1=p712q*u712_34(i3,i4).d(1,jut)+rmass(id7)*u712_34(i3,i4
     & ).c(1,jut)
      cz2=p712q*u712_34(i3,i4).d(2,jut)+rmass(id7)*u712_34(i3,i4
     & ).c(2,jut)
      u7_1234(i1,i2,i3,i4).a(1,jut)=u7_1234(i1,i2,i3,i4).a(1,jut
     & )+l7_12(i1,i2).a(1,1)*cx1+l7_12(i1,i2).c(1,2)*cy2
      u7_1234(i1,i2,i3,i4).b(1,jut)=u7_1234(i1,i2,i3,i4).b(1,jut
     & )+l7_12(i1,i2).d(1,1)*cy1+l7_12(i1,i2).b(1,2)*cx2
      u7_1234(i1,i2,i3,i4).c(1,jut)=u7_1234(i1,i2,i3,i4).c(1,jut
     & )+l7_12(i1,i2).a(1,1)*cw1+l7_12(i1,i2).c(1,2)*cz2
      u7_1234(i1,i2,i3,i4).d(1,jut)=u7_1234(i1,i2,i3,i4).d(1,jut
     & )+l7_12(i1,i2).d(1,1)*cz1+l7_12(i1,i2).b(1,2)*cw2
      u7_1234(i1,i2,i3,i4).a(2,jut)=u7_1234(i1,i2,i3,i4).a(2,jut
     & )+l7_12(i1,i2).c(2,1)*cy1+l7_12(i1,i2).a(2,2)*cx2
      u7_1234(i1,i2,i3,i4).b(2,jut)=u7_1234(i1,i2,i3,i4).b(2,jut
     & )+l7_12(i1,i2).b(2,1)*cx1+l7_12(i1,i2).d(2,2)*cy2
      u7_1234(i1,i2,i3,i4).c(2,jut)=u7_1234(i1,i2,i3,i4).c(2,jut
     & )+l7_12(i1,i2).c(2,1)*cz1+l7_12(i1,i2).a(2,2)*cw2
      u7_1234(i1,i2,i3,i4).d(2,jut)=u7_1234(i1,i2,i3,i4).d(2,jut
     & )+l7_12(i1,i2).b(2,1)*cw1+l7_12(i1,i2).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p734q,p=p734,q=p734,bef=,aft=
      p734q=(p734(0)*p734(0)-p734(1)*p734(1)-p734(2)*p734(2)-p73
     & 4(3)*p734(3))
  
      if(id7.ne.5.or.(id3.ne.5.and.id1.ne.5))then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TT -- aa=u7_1234(i1,i2,i3,i4).a,bb=u7_1234(i1,i2,i3,i4).b,cc=u7_1234(i
* 1,i2,i3,i4).c,dd=u7_1234(i1,i2,i3,i4).d,a1=l7_34(i3,i4).a,b1=l7_34(i3,
* i4).b,c1=l7_34(i3,i4).c,d1=l7_34(i3,i4).d,a2=u734_12(i1,i2).a,b2=u734_
* 12(i1,i2).b,c2=u734_12(i1,i2).c,d2=u734_12(i1,i2).d,prq=p734q,m=rmass(
* id7),nsum=1
      u7_1234(i1,i2,i3,i4).a(1,1)=u7_1234(i1,i2,i3,i4).a(1,1)+l7
     & _34(i3,i4).a(1,1)*u734_12(i1,i2).a(1,1)+l7_34(i3,i4).c(1,
     & 2)*p734q*u734_12(i1,i2).b(2,1)
      u7_1234(i1,i2,i3,i4).b(1,1)=u7_1234(i1,i2,i3,i4).b(1,1)+rm
     & ass(id7)*(l7_34(i3,i4).d(1,1)*u734_12(i1,i2).a(1,1)+l7_34
     & (i3,i4).b(1,2)*u734_12(i1,i2).b(2,1))
      u7_1234(i1,i2,i3,i4).c(1,1)=u7_1234(i1,i2,i3,i4).c(1,1)+rm
     & ass(id7)*(l7_34(i3,i4).a(1,1)*u734_12(i1,i2).d(1,1)+l7_34
     & (i3,i4).c(1,2)*u734_12(i1,i2).c(2,1))
      u7_1234(i1,i2,i3,i4).d(1,1)=u7_1234(i1,i2,i3,i4).d(1,1)+l7
     & _34(i3,i4).d(1,1)*p734q*u734_12(i1,i2).d(1,1)+l7_34(i3,i4
     & ).b(1,2)*u734_12(i1,i2).c(2,1)
      u7_1234(i1,i2,i3,i4).a(1,2)=u7_1234(i1,i2,i3,i4).a(1,2)+rm
     & ass(id7)*(l7_34(i3,i4).a(1,1)*u734_12(i1,i2).b(1,2)+l7_34
     & (i3,i4).c(1,2)*u734_12(i1,i2).a(2,2))
      u7_1234(i1,i2,i3,i4).b(1,2)=u7_1234(i1,i2,i3,i4).b(1,2)+l7
     & _34(i3,i4).d(1,1)*p734q*u734_12(i1,i2).b(1,2)+l7_34(i3,i4
     & ).b(1,2)*u734_12(i1,i2).a(2,2)
      u7_1234(i1,i2,i3,i4).c(1,2)=u7_1234(i1,i2,i3,i4).c(1,2)+l7
     & _34(i3,i4).a(1,1)*u734_12(i1,i2).c(1,2)+l7_34(i3,i4).c(1,
     & 2)*p734q*u734_12(i1,i2).d(2,2)
      u7_1234(i1,i2,i3,i4).d(1,2)=u7_1234(i1,i2,i3,i4).d(1,2)+rm
     & ass(id7)*(l7_34(i3,i4).d(1,1)*u734_12(i1,i2).c(1,2)+l7_34
     & (i3,i4).b(1,2)*u734_12(i1,i2).d(2,2))
      u7_1234(i1,i2,i3,i4).a(2,1)=u7_1234(i1,i2,i3,i4).a(2,1)+rm
     & ass(id7)*(l7_34(i3,i4).c(2,1)*u734_12(i1,i2).a(1,1)+l7_34
     & (i3,i4).a(2,2)*u734_12(i1,i2).b(2,1))
      u7_1234(i1,i2,i3,i4).b(2,1)=u7_1234(i1,i2,i3,i4).b(2,1)+l7
     & _34(i3,i4).b(2,1)*u734_12(i1,i2).a(1,1)+l7_34(i3,i4).d(2,
     & 2)*p734q*u734_12(i1,i2).b(2,1)
      u7_1234(i1,i2,i3,i4).c(2,1)=u7_1234(i1,i2,i3,i4).c(2,1)+l7
     & _34(i3,i4).c(2,1)*p734q*u734_12(i1,i2).d(1,1)+l7_34(i3,i4
     & ).a(2,2)*u734_12(i1,i2).c(2,1)
      u7_1234(i1,i2,i3,i4).d(2,1)=u7_1234(i1,i2,i3,i4).d(2,1)+rm
     & ass(id7)*(l7_34(i3,i4).b(2,1)*u734_12(i1,i2).d(1,1)+l7_34
     & (i3,i4).d(2,2)*u734_12(i1,i2).c(2,1))
      u7_1234(i1,i2,i3,i4).a(2,2)=u7_1234(i1,i2,i3,i4).a(2,2)+l7
     & _34(i3,i4).c(2,1)*p734q*u734_12(i1,i2).b(1,2)+l7_34(i3,i4
     & ).a(2,2)*u734_12(i1,i2).a(2,2)
      u7_1234(i1,i2,i3,i4).b(2,2)=u7_1234(i1,i2,i3,i4).b(2,2)+rm
     & ass(id7)*(l7_34(i3,i4).b(2,1)*u734_12(i1,i2).b(1,2)+l7_34
     & (i3,i4).d(2,2)*u734_12(i1,i2).a(2,2))
      u7_1234(i1,i2,i3,i4).c(2,2)=u7_1234(i1,i2,i3,i4).c(2,2)+rm
     & ass(id7)*(l7_34(i3,i4).c(2,1)*u734_12(i1,i2).c(1,2)+l7_34
     & (i3,i4).a(2,2)*u734_12(i1,i2).d(2,2))
      u7_1234(i1,i2,i3,i4).d(2,2)=u7_1234(i1,i2,i3,i4).d(2,2)+l7
     & _34(i3,i4).b(2,1)*u734_12(i1,i2).c(1,2)+l7_34(i3,i4).d(2,
     & 2)*p734q*u734_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id7.eq.5.and.id3.eq.5.and.id1.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TsTs -- aa=u7_1234(i1,i2,i3,i4).a,bb=u7_1234(i1,i2,i3,i4).b,cc=u7_1234
* (i1,i2,i3,i4).c,dd=u7_1234(i1,i2,i3,i4).d,a1=l7_34(i3,i4).a,b1=l7_34(i
* 3,i4).b,c1=l7_34(i3,i4).c,d1=l7_34(i3,i4).d,a2=u734_12(i1,i2).a,b2=u73
* 4_12(i1,i2).b,c2=u734_12(i1,i2).c,d2=u734_12(i1,i2).d,prq=p734q,m=rmas
* s(id7),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u734_12(i1,i2).a(1,jut)+rmass(id7)*u734_12(i1,i2).b(1,
     & jut)
      cx2=u734_12(i1,i2).a(2,jut)+rmass(id7)*u734_12(i1,i2).b(2,
     & jut)
      cy1=p734q*u734_12(i1,i2).b(1,jut)+rmass(id7)*u734_12(i1,i2
     & ).a(1,jut)
      cy2=p734q*u734_12(i1,i2).b(2,jut)+rmass(id7)*u734_12(i1,i2
     & ).a(2,jut)
      u7_1234(i1,i2,i3,i4).a(iut,jut)=u7_1234(i1,i2,i3,i4).a(iut
     & ,jut)+l7_34(i3,i4).a(iut,1)*cx1+l7_34(i3,i4).c(iut,1)*cy1
     & +l7_34(i3,i4).a(iut,2)*cx2+l7_34(i3,i4).c(iut,2)*cy2
      u7_1234(i1,i2,i3,i4).b(iut,jut)=u7_1234(i1,i2,i3,i4).b(iut
     & ,jut)+l7_34(i3,i4).b(iut,1)*cx1+l7_34(i3,i4).d(iut,1)*cy1
     & +l7_34(i3,i4).b(iut,2)*cx2+l7_34(i3,i4).d(iut,2)*cy2
      cw1=u734_12(i1,i2).c(1,jut)+rmass(id7)*u734_12(i1,i2).d(1,
     & jut)
      cw2=u734_12(i1,i2).c(2,jut)+rmass(id7)*u734_12(i1,i2).d(2,
     & jut)
      cz1=p734q*u734_12(i1,i2).d(1,jut)+rmass(id7)*u734_12(i1,i2
     & ).c(1,jut)
      cz2=p734q*u734_12(i1,i2).d(2,jut)+rmass(id7)*u734_12(i1,i2
     & ).c(2,jut)
      u7_1234(i1,i2,i3,i4).c(iut,jut)=u7_1234(i1,i2,i3,i4).c(iut
     & ,jut)+l7_34(i3,i4).a(iut,1)*cw1+l7_34(i3,i4).c(iut,1)*cz1
     & +l7_34(i3,i4).a(iut,2)*cw2+l7_34(i3,i4).c(iut,2)*cz2
      u7_1234(i1,i2,i3,i4).d(iut,jut)=u7_1234(i1,i2,i3,i4).d(iut
     & ,jut)+l7_34(i3,i4).b(iut,1)*cw1+l7_34(i3,i4).d(iut,1)*cz1
     & +l7_34(i3,i4).b(iut,2)*cw2+l7_34(i3,i4).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id7.eq.5.and.id3.eq.5.and.id1.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TsT -- aa=u7_1234(i1,i2,i3,i4).a,bb=u7_1234(i1,i2,i3,i4).b,cc=u7_1234(
* i1,i2,i3,i4).c,dd=u7_1234(i1,i2,i3,i4).d,a1=l7_34(i3,i4).a,b1=l7_34(i3
* ,i4).b,c1=l7_34(i3,i4).c,d1=l7_34(i3,i4).d,a2=u734_12(i1,i2).a,b2=u734
* _12(i1,i2).b,c2=u734_12(i1,i2).c,d2=u734_12(i1,i2).d,prq=p734q,m=rmass
* (id7),nsum=1
      do iut=1,2
      cx1=l7_34(i3,i4).a(iut,1)+l7_34(i3,i4).c(iut,1)*rmass(id7)
      cx2=l7_34(i3,i4).c(iut,2)*p734q+l7_34(i3,i4).a(iut,2)*rmas
     & s(id7)
      cy1=l7_34(i3,i4).b(iut,1)+l7_34(i3,i4).d(iut,1)*rmass(id7)
      cy2=l7_34(i3,i4).d(iut,2)*p734q+l7_34(i3,i4).b(iut,2)*rmas
     & s(id7)
      cw1=l7_34(i3,i4).c(iut,1)*p734q+l7_34(i3,i4).a(iut,1)*rmas
     & s(id7)
      cw2=l7_34(i3,i4).a(iut,2)+l7_34(i3,i4).c(iut,2)*rmass(id7)
      cz1=l7_34(i3,i4).d(iut,1)*p734q+l7_34(i3,i4).b(iut,1)*rmas
     & s(id7)
      cz2=l7_34(i3,i4).b(iut,2)+l7_34(i3,i4).d(iut,2)*rmass(id7)
      u7_1234(i1,i2,i3,i4).a(iut,1)=u7_1234(i1,i2,i3,i4).a(iut,1
     & )+cx1*u734_12(i1,i2).a(1,1)+cx2*u734_12(i1,i2).b(2,1)
      u7_1234(i1,i2,i3,i4).b(iut,1)=u7_1234(i1,i2,i3,i4).b(iut,1
     & )+cy1*u734_12(i1,i2).a(1,1)+cy2*u734_12(i1,i2).b(2,1)
      u7_1234(i1,i2,i3,i4).c(iut,1)=u7_1234(i1,i2,i3,i4).c(iut,1
     & )+cw1*u734_12(i1,i2).d(1,1)+cw2*u734_12(i1,i2).c(2,1)
      u7_1234(i1,i2,i3,i4).d(iut,1)=u7_1234(i1,i2,i3,i4).d(iut,1
     & )+cz1*u734_12(i1,i2).d(1,1)+cz2*u734_12(i1,i2).c(2,1)
      u7_1234(i1,i2,i3,i4).a(iut,2)=u7_1234(i1,i2,i3,i4).a(iut,2
     & )+cw1*u734_12(i1,i2).b(1,2)+cw2*u734_12(i1,i2).a(2,2)
      u7_1234(i1,i2,i3,i4).b(iut,2)=u7_1234(i1,i2,i3,i4).b(iut,2
     & )+cz1*u734_12(i1,i2).b(1,2)+cz2*u734_12(i1,i2).a(2,2)
      u7_1234(i1,i2,i3,i4).c(iut,2)=u7_1234(i1,i2,i3,i4).c(iut,2
     & )+cx1*u734_12(i1,i2).c(1,2)+cx2*u734_12(i1,i2).d(2,2)
      u7_1234(i1,i2,i3,i4).d(iut,2)=u7_1234(i1,i2,i3,i4).d(iut,2
     & )+cy1*u734_12(i1,i2).c(1,2)+cy2*u734_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id7.eq.5.and.id3.ne.5.and.id1.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* TTs -- aa=u7_1234(i1,i2,i3,i4).a,bb=u7_1234(i1,i2,i3,i4).b,cc=u7_1234(
* i1,i2,i3,i4).c,dd=u7_1234(i1,i2,i3,i4).d,a1=l7_34(i3,i4).a,b1=l7_34(i3
* ,i4).b,c1=l7_34(i3,i4).c,d1=l7_34(i3,i4).d,a2=u734_12(i1,i2).a,b2=u734
* _12(i1,i2).b,c2=u734_12(i1,i2).c,d2=u734_12(i1,i2).d,prq=p734q,m=rmass
* (id7),nsum=1
      do jut=1,2
      cx1=u734_12(i1,i2).a(1,jut)+rmass(id7)*u734_12(i1,i2).b(1,
     & jut)
      cx2=u734_12(i1,i2).a(2,jut)+rmass(id7)*u734_12(i1,i2).b(2,
     & jut)
      cy1=p734q*u734_12(i1,i2).b(1,jut)+rmass(id7)*u734_12(i1,i2
     & ).a(1,jut)
      cy2=p734q*u734_12(i1,i2).b(2,jut)+rmass(id7)*u734_12(i1,i2
     & ).a(2,jut)
      cw1=u734_12(i1,i2).c(1,jut)+rmass(id7)*u734_12(i1,i2).d(1,
     & jut)
      cw2=u734_12(i1,i2).c(2,jut)+rmass(id7)*u734_12(i1,i2).d(2,
     & jut)
      cz1=p734q*u734_12(i1,i2).d(1,jut)+rmass(id7)*u734_12(i1,i2
     & ).c(1,jut)
      cz2=p734q*u734_12(i1,i2).d(2,jut)+rmass(id7)*u734_12(i1,i2
     & ).c(2,jut)
      u7_1234(i1,i2,i3,i4).a(1,jut)=u7_1234(i1,i2,i3,i4).a(1,jut
     & )+l7_34(i3,i4).a(1,1)*cx1+l7_34(i3,i4).c(1,2)*cy2
      u7_1234(i1,i2,i3,i4).b(1,jut)=u7_1234(i1,i2,i3,i4).b(1,jut
     & )+l7_34(i3,i4).d(1,1)*cy1+l7_34(i3,i4).b(1,2)*cx2
      u7_1234(i1,i2,i3,i4).c(1,jut)=u7_1234(i1,i2,i3,i4).c(1,jut
     & )+l7_34(i3,i4).a(1,1)*cw1+l7_34(i3,i4).c(1,2)*cz2
      u7_1234(i1,i2,i3,i4).d(1,jut)=u7_1234(i1,i2,i3,i4).d(1,jut
     & )+l7_34(i3,i4).d(1,1)*cz1+l7_34(i3,i4).b(1,2)*cw2
      u7_1234(i1,i2,i3,i4).a(2,jut)=u7_1234(i1,i2,i3,i4).a(2,jut
     & )+l7_34(i3,i4).c(2,1)*cy1+l7_34(i3,i4).a(2,2)*cx2
      u7_1234(i1,i2,i3,i4).b(2,jut)=u7_1234(i1,i2,i3,i4).b(2,jut
     & )+l7_34(i3,i4).b(2,1)*cx1+l7_34(i3,i4).d(2,2)*cy2
      u7_1234(i1,i2,i3,i4).c(2,jut)=u7_1234(i1,i2,i3,i4).c(2,jut
     & )+l7_34(i3,i4).c(2,1)*cz1+l7_34(i3,i4).a(2,2)*cw2
      u7_1234(i1,i2,i3,i4).d(2,jut)=u7_1234(i1,i2,i3,i4).d(2,jut
     & )+l7_34(i3,i4).b(2,1)*cw1+l7_34(i3,i4).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p712q,p=p712,q=p712,bef=,aft=
      p712q=(p712(0)*p712(0)-p712(1)*p712(1)-p712(2)*p712(2)-p71
     & 2(3)*p712(3))
  
      if(id7.ne.5.or.(id1.ne.5.and.id5.ne.5))then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TT -- aa=u7_1256(i1,i2,i5,i6).a,bb=u7_1256(i1,i2,i5,i6).b,cc=u7_1256(i
* 1,i2,i5,i6).c,dd=u7_1256(i1,i2,i5,i6).d,a1=l7_12(i1,i2).a,b1=l7_12(i1,
* i2).b,c1=l7_12(i1,i2).c,d1=l7_12(i1,i2).d,a2=u712_56(i5,i6).a,b2=u712_
* 56(i5,i6).b,c2=u712_56(i5,i6).c,d2=u712_56(i5,i6).d,prq=p712q,m=rmass(
* id7),nsum=1
      u7_1256(i1,i2,i5,i6).a(1,1)=u7_1256(i1,i2,i5,i6).a(1,1)+l7
     & _12(i1,i2).a(1,1)*u712_56(i5,i6).a(1,1)+l7_12(i1,i2).c(1,
     & 2)*p712q*u712_56(i5,i6).b(2,1)
      u7_1256(i1,i2,i5,i6).b(1,1)=u7_1256(i1,i2,i5,i6).b(1,1)+rm
     & ass(id7)*(l7_12(i1,i2).d(1,1)*u712_56(i5,i6).a(1,1)+l7_12
     & (i1,i2).b(1,2)*u712_56(i5,i6).b(2,1))
      u7_1256(i1,i2,i5,i6).c(1,1)=u7_1256(i1,i2,i5,i6).c(1,1)+rm
     & ass(id7)*(l7_12(i1,i2).a(1,1)*u712_56(i5,i6).d(1,1)+l7_12
     & (i1,i2).c(1,2)*u712_56(i5,i6).c(2,1))
      u7_1256(i1,i2,i5,i6).d(1,1)=u7_1256(i1,i2,i5,i6).d(1,1)+l7
     & _12(i1,i2).d(1,1)*p712q*u712_56(i5,i6).d(1,1)+l7_12(i1,i2
     & ).b(1,2)*u712_56(i5,i6).c(2,1)
      u7_1256(i1,i2,i5,i6).a(1,2)=u7_1256(i1,i2,i5,i6).a(1,2)+rm
     & ass(id7)*(l7_12(i1,i2).a(1,1)*u712_56(i5,i6).b(1,2)+l7_12
     & (i1,i2).c(1,2)*u712_56(i5,i6).a(2,2))
      u7_1256(i1,i2,i5,i6).b(1,2)=u7_1256(i1,i2,i5,i6).b(1,2)+l7
     & _12(i1,i2).d(1,1)*p712q*u712_56(i5,i6).b(1,2)+l7_12(i1,i2
     & ).b(1,2)*u712_56(i5,i6).a(2,2)
      u7_1256(i1,i2,i5,i6).c(1,2)=u7_1256(i1,i2,i5,i6).c(1,2)+l7
     & _12(i1,i2).a(1,1)*u712_56(i5,i6).c(1,2)+l7_12(i1,i2).c(1,
     & 2)*p712q*u712_56(i5,i6).d(2,2)
      u7_1256(i1,i2,i5,i6).d(1,2)=u7_1256(i1,i2,i5,i6).d(1,2)+rm
     & ass(id7)*(l7_12(i1,i2).d(1,1)*u712_56(i5,i6).c(1,2)+l7_12
     & (i1,i2).b(1,2)*u712_56(i5,i6).d(2,2))
      u7_1256(i1,i2,i5,i6).a(2,1)=u7_1256(i1,i2,i5,i6).a(2,1)+rm
     & ass(id7)*(l7_12(i1,i2).c(2,1)*u712_56(i5,i6).a(1,1)+l7_12
     & (i1,i2).a(2,2)*u712_56(i5,i6).b(2,1))
      u7_1256(i1,i2,i5,i6).b(2,1)=u7_1256(i1,i2,i5,i6).b(2,1)+l7
     & _12(i1,i2).b(2,1)*u712_56(i5,i6).a(1,1)+l7_12(i1,i2).d(2,
     & 2)*p712q*u712_56(i5,i6).b(2,1)
      u7_1256(i1,i2,i5,i6).c(2,1)=u7_1256(i1,i2,i5,i6).c(2,1)+l7
     & _12(i1,i2).c(2,1)*p712q*u712_56(i5,i6).d(1,1)+l7_12(i1,i2
     & ).a(2,2)*u712_56(i5,i6).c(2,1)
      u7_1256(i1,i2,i5,i6).d(2,1)=u7_1256(i1,i2,i5,i6).d(2,1)+rm
     & ass(id7)*(l7_12(i1,i2).b(2,1)*u712_56(i5,i6).d(1,1)+l7_12
     & (i1,i2).d(2,2)*u712_56(i5,i6).c(2,1))
      u7_1256(i1,i2,i5,i6).a(2,2)=u7_1256(i1,i2,i5,i6).a(2,2)+l7
     & _12(i1,i2).c(2,1)*p712q*u712_56(i5,i6).b(1,2)+l7_12(i1,i2
     & ).a(2,2)*u712_56(i5,i6).a(2,2)
      u7_1256(i1,i2,i5,i6).b(2,2)=u7_1256(i1,i2,i5,i6).b(2,2)+rm
     & ass(id7)*(l7_12(i1,i2).b(2,1)*u712_56(i5,i6).b(1,2)+l7_12
     & (i1,i2).d(2,2)*u712_56(i5,i6).a(2,2))
      u7_1256(i1,i2,i5,i6).c(2,2)=u7_1256(i1,i2,i5,i6).c(2,2)+rm
     & ass(id7)*(l7_12(i1,i2).c(2,1)*u712_56(i5,i6).c(1,2)+l7_12
     & (i1,i2).a(2,2)*u712_56(i5,i6).d(2,2))
      u7_1256(i1,i2,i5,i6).d(2,2)=u7_1256(i1,i2,i5,i6).d(2,2)+l7
     & _12(i1,i2).b(2,1)*u712_56(i5,i6).c(1,2)+l7_12(i1,i2).d(2,
     & 2)*p712q*u712_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id7.eq.5.and.id1.eq.5.and.id5.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TsTs -- aa=u7_1256(i1,i2,i5,i6).a,bb=u7_1256(i1,i2,i5,i6).b,cc=u7_1256
* (i1,i2,i5,i6).c,dd=u7_1256(i1,i2,i5,i6).d,a1=l7_12(i1,i2).a,b1=l7_12(i
* 1,i2).b,c1=l7_12(i1,i2).c,d1=l7_12(i1,i2).d,a2=u712_56(i5,i6).a,b2=u71
* 2_56(i5,i6).b,c2=u712_56(i5,i6).c,d2=u712_56(i5,i6).d,prq=p712q,m=rmas
* s(id7),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u712_56(i5,i6).a(1,jut)+rmass(id7)*u712_56(i5,i6).b(1,
     & jut)
      cx2=u712_56(i5,i6).a(2,jut)+rmass(id7)*u712_56(i5,i6).b(2,
     & jut)
      cy1=p712q*u712_56(i5,i6).b(1,jut)+rmass(id7)*u712_56(i5,i6
     & ).a(1,jut)
      cy2=p712q*u712_56(i5,i6).b(2,jut)+rmass(id7)*u712_56(i5,i6
     & ).a(2,jut)
      u7_1256(i1,i2,i5,i6).a(iut,jut)=u7_1256(i1,i2,i5,i6).a(iut
     & ,jut)+l7_12(i1,i2).a(iut,1)*cx1+l7_12(i1,i2).c(iut,1)*cy1
     & +l7_12(i1,i2).a(iut,2)*cx2+l7_12(i1,i2).c(iut,2)*cy2
      u7_1256(i1,i2,i5,i6).b(iut,jut)=u7_1256(i1,i2,i5,i6).b(iut
     & ,jut)+l7_12(i1,i2).b(iut,1)*cx1+l7_12(i1,i2).d(iut,1)*cy1
     & +l7_12(i1,i2).b(iut,2)*cx2+l7_12(i1,i2).d(iut,2)*cy2
      cw1=u712_56(i5,i6).c(1,jut)+rmass(id7)*u712_56(i5,i6).d(1,
     & jut)
      cw2=u712_56(i5,i6).c(2,jut)+rmass(id7)*u712_56(i5,i6).d(2,
     & jut)
      cz1=p712q*u712_56(i5,i6).d(1,jut)+rmass(id7)*u712_56(i5,i6
     & ).c(1,jut)
      cz2=p712q*u712_56(i5,i6).d(2,jut)+rmass(id7)*u712_56(i5,i6
     & ).c(2,jut)
      u7_1256(i1,i2,i5,i6).c(iut,jut)=u7_1256(i1,i2,i5,i6).c(iut
     & ,jut)+l7_12(i1,i2).a(iut,1)*cw1+l7_12(i1,i2).c(iut,1)*cz1
     & +l7_12(i1,i2).a(iut,2)*cw2+l7_12(i1,i2).c(iut,2)*cz2
      u7_1256(i1,i2,i5,i6).d(iut,jut)=u7_1256(i1,i2,i5,i6).d(iut
     & ,jut)+l7_12(i1,i2).b(iut,1)*cw1+l7_12(i1,i2).d(iut,1)*cz1
     & +l7_12(i1,i2).b(iut,2)*cw2+l7_12(i1,i2).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id7.eq.5.and.id1.eq.5.and.id5.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TsT -- aa=u7_1256(i1,i2,i5,i6).a,bb=u7_1256(i1,i2,i5,i6).b,cc=u7_1256(
* i1,i2,i5,i6).c,dd=u7_1256(i1,i2,i5,i6).d,a1=l7_12(i1,i2).a,b1=l7_12(i1
* ,i2).b,c1=l7_12(i1,i2).c,d1=l7_12(i1,i2).d,a2=u712_56(i5,i6).a,b2=u712
* _56(i5,i6).b,c2=u712_56(i5,i6).c,d2=u712_56(i5,i6).d,prq=p712q,m=rmass
* (id7),nsum=1
      do iut=1,2
      cx1=l7_12(i1,i2).a(iut,1)+l7_12(i1,i2).c(iut,1)*rmass(id7)
      cx2=l7_12(i1,i2).c(iut,2)*p712q+l7_12(i1,i2).a(iut,2)*rmas
     & s(id7)
      cy1=l7_12(i1,i2).b(iut,1)+l7_12(i1,i2).d(iut,1)*rmass(id7)
      cy2=l7_12(i1,i2).d(iut,2)*p712q+l7_12(i1,i2).b(iut,2)*rmas
     & s(id7)
      cw1=l7_12(i1,i2).c(iut,1)*p712q+l7_12(i1,i2).a(iut,1)*rmas
     & s(id7)
      cw2=l7_12(i1,i2).a(iut,2)+l7_12(i1,i2).c(iut,2)*rmass(id7)
      cz1=l7_12(i1,i2).d(iut,1)*p712q+l7_12(i1,i2).b(iut,1)*rmas
     & s(id7)
      cz2=l7_12(i1,i2).b(iut,2)+l7_12(i1,i2).d(iut,2)*rmass(id7)
      u7_1256(i1,i2,i5,i6).a(iut,1)=u7_1256(i1,i2,i5,i6).a(iut,1
     & )+cx1*u712_56(i5,i6).a(1,1)+cx2*u712_56(i5,i6).b(2,1)
      u7_1256(i1,i2,i5,i6).b(iut,1)=u7_1256(i1,i2,i5,i6).b(iut,1
     & )+cy1*u712_56(i5,i6).a(1,1)+cy2*u712_56(i5,i6).b(2,1)
      u7_1256(i1,i2,i5,i6).c(iut,1)=u7_1256(i1,i2,i5,i6).c(iut,1
     & )+cw1*u712_56(i5,i6).d(1,1)+cw2*u712_56(i5,i6).c(2,1)
      u7_1256(i1,i2,i5,i6).d(iut,1)=u7_1256(i1,i2,i5,i6).d(iut,1
     & )+cz1*u712_56(i5,i6).d(1,1)+cz2*u712_56(i5,i6).c(2,1)
      u7_1256(i1,i2,i5,i6).a(iut,2)=u7_1256(i1,i2,i5,i6).a(iut,2
     & )+cw1*u712_56(i5,i6).b(1,2)+cw2*u712_56(i5,i6).a(2,2)
      u7_1256(i1,i2,i5,i6).b(iut,2)=u7_1256(i1,i2,i5,i6).b(iut,2
     & )+cz1*u712_56(i5,i6).b(1,2)+cz2*u712_56(i5,i6).a(2,2)
      u7_1256(i1,i2,i5,i6).c(iut,2)=u7_1256(i1,i2,i5,i6).c(iut,2
     & )+cx1*u712_56(i5,i6).c(1,2)+cx2*u712_56(i5,i6).d(2,2)
      u7_1256(i1,i2,i5,i6).d(iut,2)=u7_1256(i1,i2,i5,i6).d(iut,2
     & )+cy1*u712_56(i5,i6).c(1,2)+cy2*u712_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id7.eq.5.and.id1.ne.5.and.id5.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TTs -- aa=u7_1256(i1,i2,i5,i6).a,bb=u7_1256(i1,i2,i5,i6).b,cc=u7_1256(
* i1,i2,i5,i6).c,dd=u7_1256(i1,i2,i5,i6).d,a1=l7_12(i1,i2).a,b1=l7_12(i1
* ,i2).b,c1=l7_12(i1,i2).c,d1=l7_12(i1,i2).d,a2=u712_56(i5,i6).a,b2=u712
* _56(i5,i6).b,c2=u712_56(i5,i6).c,d2=u712_56(i5,i6).d,prq=p712q,m=rmass
* (id7),nsum=1
      do jut=1,2
      cx1=u712_56(i5,i6).a(1,jut)+rmass(id7)*u712_56(i5,i6).b(1,
     & jut)
      cx2=u712_56(i5,i6).a(2,jut)+rmass(id7)*u712_56(i5,i6).b(2,
     & jut)
      cy1=p712q*u712_56(i5,i6).b(1,jut)+rmass(id7)*u712_56(i5,i6
     & ).a(1,jut)
      cy2=p712q*u712_56(i5,i6).b(2,jut)+rmass(id7)*u712_56(i5,i6
     & ).a(2,jut)
      cw1=u712_56(i5,i6).c(1,jut)+rmass(id7)*u712_56(i5,i6).d(1,
     & jut)
      cw2=u712_56(i5,i6).c(2,jut)+rmass(id7)*u712_56(i5,i6).d(2,
     & jut)
      cz1=p712q*u712_56(i5,i6).d(1,jut)+rmass(id7)*u712_56(i5,i6
     & ).c(1,jut)
      cz2=p712q*u712_56(i5,i6).d(2,jut)+rmass(id7)*u712_56(i5,i6
     & ).c(2,jut)
      u7_1256(i1,i2,i5,i6).a(1,jut)=u7_1256(i1,i2,i5,i6).a(1,jut
     & )+l7_12(i1,i2).a(1,1)*cx1+l7_12(i1,i2).c(1,2)*cy2
      u7_1256(i1,i2,i5,i6).b(1,jut)=u7_1256(i1,i2,i5,i6).b(1,jut
     & )+l7_12(i1,i2).d(1,1)*cy1+l7_12(i1,i2).b(1,2)*cx2
      u7_1256(i1,i2,i5,i6).c(1,jut)=u7_1256(i1,i2,i5,i6).c(1,jut
     & )+l7_12(i1,i2).a(1,1)*cw1+l7_12(i1,i2).c(1,2)*cz2
      u7_1256(i1,i2,i5,i6).d(1,jut)=u7_1256(i1,i2,i5,i6).d(1,jut
     & )+l7_12(i1,i2).d(1,1)*cz1+l7_12(i1,i2).b(1,2)*cw2
      u7_1256(i1,i2,i5,i6).a(2,jut)=u7_1256(i1,i2,i5,i6).a(2,jut
     & )+l7_12(i1,i2).c(2,1)*cy1+l7_12(i1,i2).a(2,2)*cx2
      u7_1256(i1,i2,i5,i6).b(2,jut)=u7_1256(i1,i2,i5,i6).b(2,jut
     & )+l7_12(i1,i2).b(2,1)*cx1+l7_12(i1,i2).d(2,2)*cy2
      u7_1256(i1,i2,i5,i6).c(2,jut)=u7_1256(i1,i2,i5,i6).c(2,jut
     & )+l7_12(i1,i2).c(2,1)*cz1+l7_12(i1,i2).a(2,2)*cw2
      u7_1256(i1,i2,i5,i6).d(2,jut)=u7_1256(i1,i2,i5,i6).d(2,jut
     & )+l7_12(i1,i2).b(2,1)*cw1+l7_12(i1,i2).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p756q,p=p756,q=p756,bef=,aft=
      p756q=(p756(0)*p756(0)-p756(1)*p756(1)-p756(2)*p756(2)-p75
     & 6(3)*p756(3))
  
      if(id7.ne.5.or.(id5.ne.5.and.id1.ne.5))then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TT -- aa=u7_1256(i1,i2,i5,i6).a,bb=u7_1256(i1,i2,i5,i6).b,cc=u7_1256(i
* 1,i2,i5,i6).c,dd=u7_1256(i1,i2,i5,i6).d,a1=l7_56(i5,i6).a,b1=l7_56(i5,
* i6).b,c1=l7_56(i5,i6).c,d1=l7_56(i5,i6).d,a2=u756_12(i1,i2).a,b2=u756_
* 12(i1,i2).b,c2=u756_12(i1,i2).c,d2=u756_12(i1,i2).d,prq=p756q,m=rmass(
* id7),nsum=1
      u7_1256(i1,i2,i5,i6).a(1,1)=u7_1256(i1,i2,i5,i6).a(1,1)+l7
     & _56(i5,i6).a(1,1)*u756_12(i1,i2).a(1,1)+l7_56(i5,i6).c(1,
     & 2)*p756q*u756_12(i1,i2).b(2,1)
      u7_1256(i1,i2,i5,i6).b(1,1)=u7_1256(i1,i2,i5,i6).b(1,1)+rm
     & ass(id7)*(l7_56(i5,i6).d(1,1)*u756_12(i1,i2).a(1,1)+l7_56
     & (i5,i6).b(1,2)*u756_12(i1,i2).b(2,1))
      u7_1256(i1,i2,i5,i6).c(1,1)=u7_1256(i1,i2,i5,i6).c(1,1)+rm
     & ass(id7)*(l7_56(i5,i6).a(1,1)*u756_12(i1,i2).d(1,1)+l7_56
     & (i5,i6).c(1,2)*u756_12(i1,i2).c(2,1))
      u7_1256(i1,i2,i5,i6).d(1,1)=u7_1256(i1,i2,i5,i6).d(1,1)+l7
     & _56(i5,i6).d(1,1)*p756q*u756_12(i1,i2).d(1,1)+l7_56(i5,i6
     & ).b(1,2)*u756_12(i1,i2).c(2,1)
      u7_1256(i1,i2,i5,i6).a(1,2)=u7_1256(i1,i2,i5,i6).a(1,2)+rm
     & ass(id7)*(l7_56(i5,i6).a(1,1)*u756_12(i1,i2).b(1,2)+l7_56
     & (i5,i6).c(1,2)*u756_12(i1,i2).a(2,2))
      u7_1256(i1,i2,i5,i6).b(1,2)=u7_1256(i1,i2,i5,i6).b(1,2)+l7
     & _56(i5,i6).d(1,1)*p756q*u756_12(i1,i2).b(1,2)+l7_56(i5,i6
     & ).b(1,2)*u756_12(i1,i2).a(2,2)
      u7_1256(i1,i2,i5,i6).c(1,2)=u7_1256(i1,i2,i5,i6).c(1,2)+l7
     & _56(i5,i6).a(1,1)*u756_12(i1,i2).c(1,2)+l7_56(i5,i6).c(1,
     & 2)*p756q*u756_12(i1,i2).d(2,2)
      u7_1256(i1,i2,i5,i6).d(1,2)=u7_1256(i1,i2,i5,i6).d(1,2)+rm
     & ass(id7)*(l7_56(i5,i6).d(1,1)*u756_12(i1,i2).c(1,2)+l7_56
     & (i5,i6).b(1,2)*u756_12(i1,i2).d(2,2))
      u7_1256(i1,i2,i5,i6).a(2,1)=u7_1256(i1,i2,i5,i6).a(2,1)+rm
     & ass(id7)*(l7_56(i5,i6).c(2,1)*u756_12(i1,i2).a(1,1)+l7_56
     & (i5,i6).a(2,2)*u756_12(i1,i2).b(2,1))
      u7_1256(i1,i2,i5,i6).b(2,1)=u7_1256(i1,i2,i5,i6).b(2,1)+l7
     & _56(i5,i6).b(2,1)*u756_12(i1,i2).a(1,1)+l7_56(i5,i6).d(2,
     & 2)*p756q*u756_12(i1,i2).b(2,1)
      u7_1256(i1,i2,i5,i6).c(2,1)=u7_1256(i1,i2,i5,i6).c(2,1)+l7
     & _56(i5,i6).c(2,1)*p756q*u756_12(i1,i2).d(1,1)+l7_56(i5,i6
     & ).a(2,2)*u756_12(i1,i2).c(2,1)
      u7_1256(i1,i2,i5,i6).d(2,1)=u7_1256(i1,i2,i5,i6).d(2,1)+rm
     & ass(id7)*(l7_56(i5,i6).b(2,1)*u756_12(i1,i2).d(1,1)+l7_56
     & (i5,i6).d(2,2)*u756_12(i1,i2).c(2,1))
      u7_1256(i1,i2,i5,i6).a(2,2)=u7_1256(i1,i2,i5,i6).a(2,2)+l7
     & _56(i5,i6).c(2,1)*p756q*u756_12(i1,i2).b(1,2)+l7_56(i5,i6
     & ).a(2,2)*u756_12(i1,i2).a(2,2)
      u7_1256(i1,i2,i5,i6).b(2,2)=u7_1256(i1,i2,i5,i6).b(2,2)+rm
     & ass(id7)*(l7_56(i5,i6).b(2,1)*u756_12(i1,i2).b(1,2)+l7_56
     & (i5,i6).d(2,2)*u756_12(i1,i2).a(2,2))
      u7_1256(i1,i2,i5,i6).c(2,2)=u7_1256(i1,i2,i5,i6).c(2,2)+rm
     & ass(id7)*(l7_56(i5,i6).c(2,1)*u756_12(i1,i2).c(1,2)+l7_56
     & (i5,i6).a(2,2)*u756_12(i1,i2).d(2,2))
      u7_1256(i1,i2,i5,i6).d(2,2)=u7_1256(i1,i2,i5,i6).d(2,2)+l7
     & _56(i5,i6).b(2,1)*u756_12(i1,i2).c(1,2)+l7_56(i5,i6).d(2,
     & 2)*p756q*u756_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id7.eq.5.and.id5.eq.5.and.id1.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TsTs -- aa=u7_1256(i1,i2,i5,i6).a,bb=u7_1256(i1,i2,i5,i6).b,cc=u7_1256
* (i1,i2,i5,i6).c,dd=u7_1256(i1,i2,i5,i6).d,a1=l7_56(i5,i6).a,b1=l7_56(i
* 5,i6).b,c1=l7_56(i5,i6).c,d1=l7_56(i5,i6).d,a2=u756_12(i1,i2).a,b2=u75
* 6_12(i1,i2).b,c2=u756_12(i1,i2).c,d2=u756_12(i1,i2).d,prq=p756q,m=rmas
* s(id7),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u756_12(i1,i2).a(1,jut)+rmass(id7)*u756_12(i1,i2).b(1,
     & jut)
      cx2=u756_12(i1,i2).a(2,jut)+rmass(id7)*u756_12(i1,i2).b(2,
     & jut)
      cy1=p756q*u756_12(i1,i2).b(1,jut)+rmass(id7)*u756_12(i1,i2
     & ).a(1,jut)
      cy2=p756q*u756_12(i1,i2).b(2,jut)+rmass(id7)*u756_12(i1,i2
     & ).a(2,jut)
      u7_1256(i1,i2,i5,i6).a(iut,jut)=u7_1256(i1,i2,i5,i6).a(iut
     & ,jut)+l7_56(i5,i6).a(iut,1)*cx1+l7_56(i5,i6).c(iut,1)*cy1
     & +l7_56(i5,i6).a(iut,2)*cx2+l7_56(i5,i6).c(iut,2)*cy2
      u7_1256(i1,i2,i5,i6).b(iut,jut)=u7_1256(i1,i2,i5,i6).b(iut
     & ,jut)+l7_56(i5,i6).b(iut,1)*cx1+l7_56(i5,i6).d(iut,1)*cy1
     & +l7_56(i5,i6).b(iut,2)*cx2+l7_56(i5,i6).d(iut,2)*cy2
      cw1=u756_12(i1,i2).c(1,jut)+rmass(id7)*u756_12(i1,i2).d(1,
     & jut)
      cw2=u756_12(i1,i2).c(2,jut)+rmass(id7)*u756_12(i1,i2).d(2,
     & jut)
      cz1=p756q*u756_12(i1,i2).d(1,jut)+rmass(id7)*u756_12(i1,i2
     & ).c(1,jut)
      cz2=p756q*u756_12(i1,i2).d(2,jut)+rmass(id7)*u756_12(i1,i2
     & ).c(2,jut)
      u7_1256(i1,i2,i5,i6).c(iut,jut)=u7_1256(i1,i2,i5,i6).c(iut
     & ,jut)+l7_56(i5,i6).a(iut,1)*cw1+l7_56(i5,i6).c(iut,1)*cz1
     & +l7_56(i5,i6).a(iut,2)*cw2+l7_56(i5,i6).c(iut,2)*cz2
      u7_1256(i1,i2,i5,i6).d(iut,jut)=u7_1256(i1,i2,i5,i6).d(iut
     & ,jut)+l7_56(i5,i6).b(iut,1)*cw1+l7_56(i5,i6).d(iut,1)*cz1
     & +l7_56(i5,i6).b(iut,2)*cw2+l7_56(i5,i6).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id7.eq.5.and.id5.eq.5.and.id1.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TsT -- aa=u7_1256(i1,i2,i5,i6).a,bb=u7_1256(i1,i2,i5,i6).b,cc=u7_1256(
* i1,i2,i5,i6).c,dd=u7_1256(i1,i2,i5,i6).d,a1=l7_56(i5,i6).a,b1=l7_56(i5
* ,i6).b,c1=l7_56(i5,i6).c,d1=l7_56(i5,i6).d,a2=u756_12(i1,i2).a,b2=u756
* _12(i1,i2).b,c2=u756_12(i1,i2).c,d2=u756_12(i1,i2).d,prq=p756q,m=rmass
* (id7),nsum=1
      do iut=1,2
      cx1=l7_56(i5,i6).a(iut,1)+l7_56(i5,i6).c(iut,1)*rmass(id7)
      cx2=l7_56(i5,i6).c(iut,2)*p756q+l7_56(i5,i6).a(iut,2)*rmas
     & s(id7)
      cy1=l7_56(i5,i6).b(iut,1)+l7_56(i5,i6).d(iut,1)*rmass(id7)
      cy2=l7_56(i5,i6).d(iut,2)*p756q+l7_56(i5,i6).b(iut,2)*rmas
     & s(id7)
      cw1=l7_56(i5,i6).c(iut,1)*p756q+l7_56(i5,i6).a(iut,1)*rmas
     & s(id7)
      cw2=l7_56(i5,i6).a(iut,2)+l7_56(i5,i6).c(iut,2)*rmass(id7)
      cz1=l7_56(i5,i6).d(iut,1)*p756q+l7_56(i5,i6).b(iut,1)*rmas
     & s(id7)
      cz2=l7_56(i5,i6).b(iut,2)+l7_56(i5,i6).d(iut,2)*rmass(id7)
      u7_1256(i1,i2,i5,i6).a(iut,1)=u7_1256(i1,i2,i5,i6).a(iut,1
     & )+cx1*u756_12(i1,i2).a(1,1)+cx2*u756_12(i1,i2).b(2,1)
      u7_1256(i1,i2,i5,i6).b(iut,1)=u7_1256(i1,i2,i5,i6).b(iut,1
     & )+cy1*u756_12(i1,i2).a(1,1)+cy2*u756_12(i1,i2).b(2,1)
      u7_1256(i1,i2,i5,i6).c(iut,1)=u7_1256(i1,i2,i5,i6).c(iut,1
     & )+cw1*u756_12(i1,i2).d(1,1)+cw2*u756_12(i1,i2).c(2,1)
      u7_1256(i1,i2,i5,i6).d(iut,1)=u7_1256(i1,i2,i5,i6).d(iut,1
     & )+cz1*u756_12(i1,i2).d(1,1)+cz2*u756_12(i1,i2).c(2,1)
      u7_1256(i1,i2,i5,i6).a(iut,2)=u7_1256(i1,i2,i5,i6).a(iut,2
     & )+cw1*u756_12(i1,i2).b(1,2)+cw2*u756_12(i1,i2).a(2,2)
      u7_1256(i1,i2,i5,i6).b(iut,2)=u7_1256(i1,i2,i5,i6).b(iut,2
     & )+cz1*u756_12(i1,i2).b(1,2)+cz2*u756_12(i1,i2).a(2,2)
      u7_1256(i1,i2,i5,i6).c(iut,2)=u7_1256(i1,i2,i5,i6).c(iut,2
     & )+cx1*u756_12(i1,i2).c(1,2)+cx2*u756_12(i1,i2).d(2,2)
      u7_1256(i1,i2,i5,i6).d(iut,2)=u7_1256(i1,i2,i5,i6).d(iut,2
     & )+cy1*u756_12(i1,i2).c(1,2)+cy2*u756_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id7.eq.5.and.id5.ne.5.and.id1.eq.5)then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
* TTs -- aa=u7_1256(i1,i2,i5,i6).a,bb=u7_1256(i1,i2,i5,i6).b,cc=u7_1256(
* i1,i2,i5,i6).c,dd=u7_1256(i1,i2,i5,i6).d,a1=l7_56(i5,i6).a,b1=l7_56(i5
* ,i6).b,c1=l7_56(i5,i6).c,d1=l7_56(i5,i6).d,a2=u756_12(i1,i2).a,b2=u756
* _12(i1,i2).b,c2=u756_12(i1,i2).c,d2=u756_12(i1,i2).d,prq=p756q,m=rmass
* (id7),nsum=1
      do jut=1,2
      cx1=u756_12(i1,i2).a(1,jut)+rmass(id7)*u756_12(i1,i2).b(1,
     & jut)
      cx2=u756_12(i1,i2).a(2,jut)+rmass(id7)*u756_12(i1,i2).b(2,
     & jut)
      cy1=p756q*u756_12(i1,i2).b(1,jut)+rmass(id7)*u756_12(i1,i2
     & ).a(1,jut)
      cy2=p756q*u756_12(i1,i2).b(2,jut)+rmass(id7)*u756_12(i1,i2
     & ).a(2,jut)
      cw1=u756_12(i1,i2).c(1,jut)+rmass(id7)*u756_12(i1,i2).d(1,
     & jut)
      cw2=u756_12(i1,i2).c(2,jut)+rmass(id7)*u756_12(i1,i2).d(2,
     & jut)
      cz1=p756q*u756_12(i1,i2).d(1,jut)+rmass(id7)*u756_12(i1,i2
     & ).c(1,jut)
      cz2=p756q*u756_12(i1,i2).d(2,jut)+rmass(id7)*u756_12(i1,i2
     & ).c(2,jut)
      u7_1256(i1,i2,i5,i6).a(1,jut)=u7_1256(i1,i2,i5,i6).a(1,jut
     & )+l7_56(i5,i6).a(1,1)*cx1+l7_56(i5,i6).c(1,2)*cy2
      u7_1256(i1,i2,i5,i6).b(1,jut)=u7_1256(i1,i2,i5,i6).b(1,jut
     & )+l7_56(i5,i6).d(1,1)*cy1+l7_56(i5,i6).b(1,2)*cx2
      u7_1256(i1,i2,i5,i6).c(1,jut)=u7_1256(i1,i2,i5,i6).c(1,jut
     & )+l7_56(i5,i6).a(1,1)*cw1+l7_56(i5,i6).c(1,2)*cz2
      u7_1256(i1,i2,i5,i6).d(1,jut)=u7_1256(i1,i2,i5,i6).d(1,jut
     & )+l7_56(i5,i6).d(1,1)*cz1+l7_56(i5,i6).b(1,2)*cw2
      u7_1256(i1,i2,i5,i6).a(2,jut)=u7_1256(i1,i2,i5,i6).a(2,jut
     & )+l7_56(i5,i6).c(2,1)*cy1+l7_56(i5,i6).a(2,2)*cx2
      u7_1256(i1,i2,i5,i6).b(2,jut)=u7_1256(i1,i2,i5,i6).b(2,jut
     & )+l7_56(i5,i6).b(2,1)*cx1+l7_56(i5,i6).d(2,2)*cy2
      u7_1256(i1,i2,i5,i6).c(2,jut)=u7_1256(i1,i2,i5,i6).c(2,jut
     & )+l7_56(i5,i6).c(2,1)*cz1+l7_56(i5,i6).a(2,2)*cw2
      u7_1256(i1,i2,i5,i6).d(2,jut)=u7_1256(i1,i2,i5,i6).d(2,jut
     & )+l7_56(i5,i6).b(2,1)*cw1+l7_56(i5,i6).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p734q,p=p734,q=p734,bef=,aft=
      p734q=(p734(0)*p734(0)-p734(1)*p734(1)-p734(2)*p734(2)-p73
     & 4(3)*p734(3))
  
      if(id7.ne.5.or.(id3.ne.5.and.id5.ne.5))then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TT -- aa=u7_3456(i3,i4,i5,i6).a,bb=u7_3456(i3,i4,i5,i6).b,cc=u7_3456(i
* 3,i4,i5,i6).c,dd=u7_3456(i3,i4,i5,i6).d,a1=l7_34(i3,i4).a,b1=l7_34(i3,
* i4).b,c1=l7_34(i3,i4).c,d1=l7_34(i3,i4).d,a2=u734_56(i5,i6).a,b2=u734_
* 56(i5,i6).b,c2=u734_56(i5,i6).c,d2=u734_56(i5,i6).d,prq=p734q,m=rmass(
* id7),nsum=1
      u7_3456(i3,i4,i5,i6).a(1,1)=u7_3456(i3,i4,i5,i6).a(1,1)+l7
     & _34(i3,i4).a(1,1)*u734_56(i5,i6).a(1,1)+l7_34(i3,i4).c(1,
     & 2)*p734q*u734_56(i5,i6).b(2,1)
      u7_3456(i3,i4,i5,i6).b(1,1)=u7_3456(i3,i4,i5,i6).b(1,1)+rm
     & ass(id7)*(l7_34(i3,i4).d(1,1)*u734_56(i5,i6).a(1,1)+l7_34
     & (i3,i4).b(1,2)*u734_56(i5,i6).b(2,1))
      u7_3456(i3,i4,i5,i6).c(1,1)=u7_3456(i3,i4,i5,i6).c(1,1)+rm
     & ass(id7)*(l7_34(i3,i4).a(1,1)*u734_56(i5,i6).d(1,1)+l7_34
     & (i3,i4).c(1,2)*u734_56(i5,i6).c(2,1))
      u7_3456(i3,i4,i5,i6).d(1,1)=u7_3456(i3,i4,i5,i6).d(1,1)+l7
     & _34(i3,i4).d(1,1)*p734q*u734_56(i5,i6).d(1,1)+l7_34(i3,i4
     & ).b(1,2)*u734_56(i5,i6).c(2,1)
      u7_3456(i3,i4,i5,i6).a(1,2)=u7_3456(i3,i4,i5,i6).a(1,2)+rm
     & ass(id7)*(l7_34(i3,i4).a(1,1)*u734_56(i5,i6).b(1,2)+l7_34
     & (i3,i4).c(1,2)*u734_56(i5,i6).a(2,2))
      u7_3456(i3,i4,i5,i6).b(1,2)=u7_3456(i3,i4,i5,i6).b(1,2)+l7
     & _34(i3,i4).d(1,1)*p734q*u734_56(i5,i6).b(1,2)+l7_34(i3,i4
     & ).b(1,2)*u734_56(i5,i6).a(2,2)
      u7_3456(i3,i4,i5,i6).c(1,2)=u7_3456(i3,i4,i5,i6).c(1,2)+l7
     & _34(i3,i4).a(1,1)*u734_56(i5,i6).c(1,2)+l7_34(i3,i4).c(1,
     & 2)*p734q*u734_56(i5,i6).d(2,2)
      u7_3456(i3,i4,i5,i6).d(1,2)=u7_3456(i3,i4,i5,i6).d(1,2)+rm
     & ass(id7)*(l7_34(i3,i4).d(1,1)*u734_56(i5,i6).c(1,2)+l7_34
     & (i3,i4).b(1,2)*u734_56(i5,i6).d(2,2))
      u7_3456(i3,i4,i5,i6).a(2,1)=u7_3456(i3,i4,i5,i6).a(2,1)+rm
     & ass(id7)*(l7_34(i3,i4).c(2,1)*u734_56(i5,i6).a(1,1)+l7_34
     & (i3,i4).a(2,2)*u734_56(i5,i6).b(2,1))
      u7_3456(i3,i4,i5,i6).b(2,1)=u7_3456(i3,i4,i5,i6).b(2,1)+l7
     & _34(i3,i4).b(2,1)*u734_56(i5,i6).a(1,1)+l7_34(i3,i4).d(2,
     & 2)*p734q*u734_56(i5,i6).b(2,1)
      u7_3456(i3,i4,i5,i6).c(2,1)=u7_3456(i3,i4,i5,i6).c(2,1)+l7
     & _34(i3,i4).c(2,1)*p734q*u734_56(i5,i6).d(1,1)+l7_34(i3,i4
     & ).a(2,2)*u734_56(i5,i6).c(2,1)
      u7_3456(i3,i4,i5,i6).d(2,1)=u7_3456(i3,i4,i5,i6).d(2,1)+rm
     & ass(id7)*(l7_34(i3,i4).b(2,1)*u734_56(i5,i6).d(1,1)+l7_34
     & (i3,i4).d(2,2)*u734_56(i5,i6).c(2,1))
      u7_3456(i3,i4,i5,i6).a(2,2)=u7_3456(i3,i4,i5,i6).a(2,2)+l7
     & _34(i3,i4).c(2,1)*p734q*u734_56(i5,i6).b(1,2)+l7_34(i3,i4
     & ).a(2,2)*u734_56(i5,i6).a(2,2)
      u7_3456(i3,i4,i5,i6).b(2,2)=u7_3456(i3,i4,i5,i6).b(2,2)+rm
     & ass(id7)*(l7_34(i3,i4).b(2,1)*u734_56(i5,i6).b(1,2)+l7_34
     & (i3,i4).d(2,2)*u734_56(i5,i6).a(2,2))
      u7_3456(i3,i4,i5,i6).c(2,2)=u7_3456(i3,i4,i5,i6).c(2,2)+rm
     & ass(id7)*(l7_34(i3,i4).c(2,1)*u734_56(i5,i6).c(1,2)+l7_34
     & (i3,i4).a(2,2)*u734_56(i5,i6).d(2,2))
      u7_3456(i3,i4,i5,i6).d(2,2)=u7_3456(i3,i4,i5,i6).d(2,2)+l7
     & _34(i3,i4).b(2,1)*u734_56(i5,i6).c(1,2)+l7_34(i3,i4).d(2,
     & 2)*p734q*u734_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id7.eq.5.and.id3.eq.5.and.id5.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TsTs -- aa=u7_3456(i3,i4,i5,i6).a,bb=u7_3456(i3,i4,i5,i6).b,cc=u7_3456
* (i3,i4,i5,i6).c,dd=u7_3456(i3,i4,i5,i6).d,a1=l7_34(i3,i4).a,b1=l7_34(i
* 3,i4).b,c1=l7_34(i3,i4).c,d1=l7_34(i3,i4).d,a2=u734_56(i5,i6).a,b2=u73
* 4_56(i5,i6).b,c2=u734_56(i5,i6).c,d2=u734_56(i5,i6).d,prq=p734q,m=rmas
* s(id7),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u734_56(i5,i6).a(1,jut)+rmass(id7)*u734_56(i5,i6).b(1,
     & jut)
      cx2=u734_56(i5,i6).a(2,jut)+rmass(id7)*u734_56(i5,i6).b(2,
     & jut)
      cy1=p734q*u734_56(i5,i6).b(1,jut)+rmass(id7)*u734_56(i5,i6
     & ).a(1,jut)
      cy2=p734q*u734_56(i5,i6).b(2,jut)+rmass(id7)*u734_56(i5,i6
     & ).a(2,jut)
      u7_3456(i3,i4,i5,i6).a(iut,jut)=u7_3456(i3,i4,i5,i6).a(iut
     & ,jut)+l7_34(i3,i4).a(iut,1)*cx1+l7_34(i3,i4).c(iut,1)*cy1
     & +l7_34(i3,i4).a(iut,2)*cx2+l7_34(i3,i4).c(iut,2)*cy2
      u7_3456(i3,i4,i5,i6).b(iut,jut)=u7_3456(i3,i4,i5,i6).b(iut
     & ,jut)+l7_34(i3,i4).b(iut,1)*cx1+l7_34(i3,i4).d(iut,1)*cy1
     & +l7_34(i3,i4).b(iut,2)*cx2+l7_34(i3,i4).d(iut,2)*cy2
      cw1=u734_56(i5,i6).c(1,jut)+rmass(id7)*u734_56(i5,i6).d(1,
     & jut)
      cw2=u734_56(i5,i6).c(2,jut)+rmass(id7)*u734_56(i5,i6).d(2,
     & jut)
      cz1=p734q*u734_56(i5,i6).d(1,jut)+rmass(id7)*u734_56(i5,i6
     & ).c(1,jut)
      cz2=p734q*u734_56(i5,i6).d(2,jut)+rmass(id7)*u734_56(i5,i6
     & ).c(2,jut)
      u7_3456(i3,i4,i5,i6).c(iut,jut)=u7_3456(i3,i4,i5,i6).c(iut
     & ,jut)+l7_34(i3,i4).a(iut,1)*cw1+l7_34(i3,i4).c(iut,1)*cz1
     & +l7_34(i3,i4).a(iut,2)*cw2+l7_34(i3,i4).c(iut,2)*cz2
      u7_3456(i3,i4,i5,i6).d(iut,jut)=u7_3456(i3,i4,i5,i6).d(iut
     & ,jut)+l7_34(i3,i4).b(iut,1)*cw1+l7_34(i3,i4).d(iut,1)*cz1
     & +l7_34(i3,i4).b(iut,2)*cw2+l7_34(i3,i4).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id7.eq.5.and.id3.eq.5.and.id5.ne.5)then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TsT -- aa=u7_3456(i3,i4,i5,i6).a,bb=u7_3456(i3,i4,i5,i6).b,cc=u7_3456(
* i3,i4,i5,i6).c,dd=u7_3456(i3,i4,i5,i6).d,a1=l7_34(i3,i4).a,b1=l7_34(i3
* ,i4).b,c1=l7_34(i3,i4).c,d1=l7_34(i3,i4).d,a2=u734_56(i5,i6).a,b2=u734
* _56(i5,i6).b,c2=u734_56(i5,i6).c,d2=u734_56(i5,i6).d,prq=p734q,m=rmass
* (id7),nsum=1
      do iut=1,2
      cx1=l7_34(i3,i4).a(iut,1)+l7_34(i3,i4).c(iut,1)*rmass(id7)
      cx2=l7_34(i3,i4).c(iut,2)*p734q+l7_34(i3,i4).a(iut,2)*rmas
     & s(id7)
      cy1=l7_34(i3,i4).b(iut,1)+l7_34(i3,i4).d(iut,1)*rmass(id7)
      cy2=l7_34(i3,i4).d(iut,2)*p734q+l7_34(i3,i4).b(iut,2)*rmas
     & s(id7)
      cw1=l7_34(i3,i4).c(iut,1)*p734q+l7_34(i3,i4).a(iut,1)*rmas
     & s(id7)
      cw2=l7_34(i3,i4).a(iut,2)+l7_34(i3,i4).c(iut,2)*rmass(id7)
      cz1=l7_34(i3,i4).d(iut,1)*p734q+l7_34(i3,i4).b(iut,1)*rmas
     & s(id7)
      cz2=l7_34(i3,i4).b(iut,2)+l7_34(i3,i4).d(iut,2)*rmass(id7)
      u7_3456(i3,i4,i5,i6).a(iut,1)=u7_3456(i3,i4,i5,i6).a(iut,1
     & )+cx1*u734_56(i5,i6).a(1,1)+cx2*u734_56(i5,i6).b(2,1)
      u7_3456(i3,i4,i5,i6).b(iut,1)=u7_3456(i3,i4,i5,i6).b(iut,1
     & )+cy1*u734_56(i5,i6).a(1,1)+cy2*u734_56(i5,i6).b(2,1)
      u7_3456(i3,i4,i5,i6).c(iut,1)=u7_3456(i3,i4,i5,i6).c(iut,1
     & )+cw1*u734_56(i5,i6).d(1,1)+cw2*u734_56(i5,i6).c(2,1)
      u7_3456(i3,i4,i5,i6).d(iut,1)=u7_3456(i3,i4,i5,i6).d(iut,1
     & )+cz1*u734_56(i5,i6).d(1,1)+cz2*u734_56(i5,i6).c(2,1)
      u7_3456(i3,i4,i5,i6).a(iut,2)=u7_3456(i3,i4,i5,i6).a(iut,2
     & )+cw1*u734_56(i5,i6).b(1,2)+cw2*u734_56(i5,i6).a(2,2)
      u7_3456(i3,i4,i5,i6).b(iut,2)=u7_3456(i3,i4,i5,i6).b(iut,2
     & )+cz1*u734_56(i5,i6).b(1,2)+cz2*u734_56(i5,i6).a(2,2)
      u7_3456(i3,i4,i5,i6).c(iut,2)=u7_3456(i3,i4,i5,i6).c(iut,2
     & )+cx1*u734_56(i5,i6).c(1,2)+cx2*u734_56(i5,i6).d(2,2)
      u7_3456(i3,i4,i5,i6).d(iut,2)=u7_3456(i3,i4,i5,i6).d(iut,2
     & )+cy1*u734_56(i5,i6).c(1,2)+cy2*u734_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id7.eq.5.and.id3.ne.5.and.id5.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TTs -- aa=u7_3456(i3,i4,i5,i6).a,bb=u7_3456(i3,i4,i5,i6).b,cc=u7_3456(
* i3,i4,i5,i6).c,dd=u7_3456(i3,i4,i5,i6).d,a1=l7_34(i3,i4).a,b1=l7_34(i3
* ,i4).b,c1=l7_34(i3,i4).c,d1=l7_34(i3,i4).d,a2=u734_56(i5,i6).a,b2=u734
* _56(i5,i6).b,c2=u734_56(i5,i6).c,d2=u734_56(i5,i6).d,prq=p734q,m=rmass
* (id7),nsum=1
      do jut=1,2
      cx1=u734_56(i5,i6).a(1,jut)+rmass(id7)*u734_56(i5,i6).b(1,
     & jut)
      cx2=u734_56(i5,i6).a(2,jut)+rmass(id7)*u734_56(i5,i6).b(2,
     & jut)
      cy1=p734q*u734_56(i5,i6).b(1,jut)+rmass(id7)*u734_56(i5,i6
     & ).a(1,jut)
      cy2=p734q*u734_56(i5,i6).b(2,jut)+rmass(id7)*u734_56(i5,i6
     & ).a(2,jut)
      cw1=u734_56(i5,i6).c(1,jut)+rmass(id7)*u734_56(i5,i6).d(1,
     & jut)
      cw2=u734_56(i5,i6).c(2,jut)+rmass(id7)*u734_56(i5,i6).d(2,
     & jut)
      cz1=p734q*u734_56(i5,i6).d(1,jut)+rmass(id7)*u734_56(i5,i6
     & ).c(1,jut)
      cz2=p734q*u734_56(i5,i6).d(2,jut)+rmass(id7)*u734_56(i5,i6
     & ).c(2,jut)
      u7_3456(i3,i4,i5,i6).a(1,jut)=u7_3456(i3,i4,i5,i6).a(1,jut
     & )+l7_34(i3,i4).a(1,1)*cx1+l7_34(i3,i4).c(1,2)*cy2
      u7_3456(i3,i4,i5,i6).b(1,jut)=u7_3456(i3,i4,i5,i6).b(1,jut
     & )+l7_34(i3,i4).d(1,1)*cy1+l7_34(i3,i4).b(1,2)*cx2
      u7_3456(i3,i4,i5,i6).c(1,jut)=u7_3456(i3,i4,i5,i6).c(1,jut
     & )+l7_34(i3,i4).a(1,1)*cw1+l7_34(i3,i4).c(1,2)*cz2
      u7_3456(i3,i4,i5,i6).d(1,jut)=u7_3456(i3,i4,i5,i6).d(1,jut
     & )+l7_34(i3,i4).d(1,1)*cz1+l7_34(i3,i4).b(1,2)*cw2
      u7_3456(i3,i4,i5,i6).a(2,jut)=u7_3456(i3,i4,i5,i6).a(2,jut
     & )+l7_34(i3,i4).c(2,1)*cy1+l7_34(i3,i4).a(2,2)*cx2
      u7_3456(i3,i4,i5,i6).b(2,jut)=u7_3456(i3,i4,i5,i6).b(2,jut
     & )+l7_34(i3,i4).b(2,1)*cx1+l7_34(i3,i4).d(2,2)*cy2
      u7_3456(i3,i4,i5,i6).c(2,jut)=u7_3456(i3,i4,i5,i6).c(2,jut
     & )+l7_34(i3,i4).c(2,1)*cz1+l7_34(i3,i4).a(2,2)*cw2
      u7_3456(i3,i4,i5,i6).d(2,jut)=u7_3456(i3,i4,i5,i6).d(2,jut
     & )+l7_34(i3,i4).b(2,1)*cw1+l7_34(i3,i4).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
* p.q -- p.q=p756q,p=p756,q=p756,bef=,aft=
      p756q=(p756(0)*p756(0)-p756(1)*p756(1)-p756(2)*p756(2)-p75
     & 6(3)*p756(3))
  
      if(id7.ne.5.or.(id5.ne.5.and.id3.ne.5))then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TT -- aa=u7_3456(i3,i4,i5,i6).a,bb=u7_3456(i3,i4,i5,i6).b,cc=u7_3456(i
* 3,i4,i5,i6).c,dd=u7_3456(i3,i4,i5,i6).d,a1=l7_56(i5,i6).a,b1=l7_56(i5,
* i6).b,c1=l7_56(i5,i6).c,d1=l7_56(i5,i6).d,a2=u756_34(i3,i4).a,b2=u756_
* 34(i3,i4).b,c2=u756_34(i3,i4).c,d2=u756_34(i3,i4).d,prq=p756q,m=rmass(
* id7),nsum=1
      u7_3456(i3,i4,i5,i6).a(1,1)=u7_3456(i3,i4,i5,i6).a(1,1)+l7
     & _56(i5,i6).a(1,1)*u756_34(i3,i4).a(1,1)+l7_56(i5,i6).c(1,
     & 2)*p756q*u756_34(i3,i4).b(2,1)
      u7_3456(i3,i4,i5,i6).b(1,1)=u7_3456(i3,i4,i5,i6).b(1,1)+rm
     & ass(id7)*(l7_56(i5,i6).d(1,1)*u756_34(i3,i4).a(1,1)+l7_56
     & (i5,i6).b(1,2)*u756_34(i3,i4).b(2,1))
      u7_3456(i3,i4,i5,i6).c(1,1)=u7_3456(i3,i4,i5,i6).c(1,1)+rm
     & ass(id7)*(l7_56(i5,i6).a(1,1)*u756_34(i3,i4).d(1,1)+l7_56
     & (i5,i6).c(1,2)*u756_34(i3,i4).c(2,1))
      u7_3456(i3,i4,i5,i6).d(1,1)=u7_3456(i3,i4,i5,i6).d(1,1)+l7
     & _56(i5,i6).d(1,1)*p756q*u756_34(i3,i4).d(1,1)+l7_56(i5,i6
     & ).b(1,2)*u756_34(i3,i4).c(2,1)
      u7_3456(i3,i4,i5,i6).a(1,2)=u7_3456(i3,i4,i5,i6).a(1,2)+rm
     & ass(id7)*(l7_56(i5,i6).a(1,1)*u756_34(i3,i4).b(1,2)+l7_56
     & (i5,i6).c(1,2)*u756_34(i3,i4).a(2,2))
      u7_3456(i3,i4,i5,i6).b(1,2)=u7_3456(i3,i4,i5,i6).b(1,2)+l7
     & _56(i5,i6).d(1,1)*p756q*u756_34(i3,i4).b(1,2)+l7_56(i5,i6
     & ).b(1,2)*u756_34(i3,i4).a(2,2)
      u7_3456(i3,i4,i5,i6).c(1,2)=u7_3456(i3,i4,i5,i6).c(1,2)+l7
     & _56(i5,i6).a(1,1)*u756_34(i3,i4).c(1,2)+l7_56(i5,i6).c(1,
     & 2)*p756q*u756_34(i3,i4).d(2,2)
      u7_3456(i3,i4,i5,i6).d(1,2)=u7_3456(i3,i4,i5,i6).d(1,2)+rm
     & ass(id7)*(l7_56(i5,i6).d(1,1)*u756_34(i3,i4).c(1,2)+l7_56
     & (i5,i6).b(1,2)*u756_34(i3,i4).d(2,2))
      u7_3456(i3,i4,i5,i6).a(2,1)=u7_3456(i3,i4,i5,i6).a(2,1)+rm
     & ass(id7)*(l7_56(i5,i6).c(2,1)*u756_34(i3,i4).a(1,1)+l7_56
     & (i5,i6).a(2,2)*u756_34(i3,i4).b(2,1))
      u7_3456(i3,i4,i5,i6).b(2,1)=u7_3456(i3,i4,i5,i6).b(2,1)+l7
     & _56(i5,i6).b(2,1)*u756_34(i3,i4).a(1,1)+l7_56(i5,i6).d(2,
     & 2)*p756q*u756_34(i3,i4).b(2,1)
      u7_3456(i3,i4,i5,i6).c(2,1)=u7_3456(i3,i4,i5,i6).c(2,1)+l7
     & _56(i5,i6).c(2,1)*p756q*u756_34(i3,i4).d(1,1)+l7_56(i5,i6
     & ).a(2,2)*u756_34(i3,i4).c(2,1)
      u7_3456(i3,i4,i5,i6).d(2,1)=u7_3456(i3,i4,i5,i6).d(2,1)+rm
     & ass(id7)*(l7_56(i5,i6).b(2,1)*u756_34(i3,i4).d(1,1)+l7_56
     & (i5,i6).d(2,2)*u756_34(i3,i4).c(2,1))
      u7_3456(i3,i4,i5,i6).a(2,2)=u7_3456(i3,i4,i5,i6).a(2,2)+l7
     & _56(i5,i6).c(2,1)*p756q*u756_34(i3,i4).b(1,2)+l7_56(i5,i6
     & ).a(2,2)*u756_34(i3,i4).a(2,2)
      u7_3456(i3,i4,i5,i6).b(2,2)=u7_3456(i3,i4,i5,i6).b(2,2)+rm
     & ass(id7)*(l7_56(i5,i6).b(2,1)*u756_34(i3,i4).b(1,2)+l7_56
     & (i5,i6).d(2,2)*u756_34(i3,i4).a(2,2))
      u7_3456(i3,i4,i5,i6).c(2,2)=u7_3456(i3,i4,i5,i6).c(2,2)+rm
     & ass(id7)*(l7_56(i5,i6).c(2,1)*u756_34(i3,i4).c(1,2)+l7_56
     & (i5,i6).a(2,2)*u756_34(i3,i4).d(2,2))
      u7_3456(i3,i4,i5,i6).d(2,2)=u7_3456(i3,i4,i5,i6).d(2,2)+l7
     & _56(i5,i6).b(2,1)*u756_34(i3,i4).c(1,2)+l7_56(i5,i6).d(2,
     & 2)*p756q*u756_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
  
      else
  
       if(id7.eq.5.and.id5.eq.5.and.id3.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TsTs -- aa=u7_3456(i3,i4,i5,i6).a,bb=u7_3456(i3,i4,i5,i6).b,cc=u7_3456
* (i3,i4,i5,i6).c,dd=u7_3456(i3,i4,i5,i6).d,a1=l7_56(i5,i6).a,b1=l7_56(i
* 5,i6).b,c1=l7_56(i5,i6).c,d1=l7_56(i5,i6).d,a2=u756_34(i3,i4).a,b2=u75
* 6_34(i3,i4).b,c2=u756_34(i3,i4).c,d2=u756_34(i3,i4).d,prq=p756q,m=rmas
* s(id7),nsum=1
      do iut=1,2
      do jut=1,2
      cx1=u756_34(i3,i4).a(1,jut)+rmass(id7)*u756_34(i3,i4).b(1,
     & jut)
      cx2=u756_34(i3,i4).a(2,jut)+rmass(id7)*u756_34(i3,i4).b(2,
     & jut)
      cy1=p756q*u756_34(i3,i4).b(1,jut)+rmass(id7)*u756_34(i3,i4
     & ).a(1,jut)
      cy2=p756q*u756_34(i3,i4).b(2,jut)+rmass(id7)*u756_34(i3,i4
     & ).a(2,jut)
      u7_3456(i3,i4,i5,i6).a(iut,jut)=u7_3456(i3,i4,i5,i6).a(iut
     & ,jut)+l7_56(i5,i6).a(iut,1)*cx1+l7_56(i5,i6).c(iut,1)*cy1
     & +l7_56(i5,i6).a(iut,2)*cx2+l7_56(i5,i6).c(iut,2)*cy2
      u7_3456(i3,i4,i5,i6).b(iut,jut)=u7_3456(i3,i4,i5,i6).b(iut
     & ,jut)+l7_56(i5,i6).b(iut,1)*cx1+l7_56(i5,i6).d(iut,1)*cy1
     & +l7_56(i5,i6).b(iut,2)*cx2+l7_56(i5,i6).d(iut,2)*cy2
      cw1=u756_34(i3,i4).c(1,jut)+rmass(id7)*u756_34(i3,i4).d(1,
     & jut)
      cw2=u756_34(i3,i4).c(2,jut)+rmass(id7)*u756_34(i3,i4).d(2,
     & jut)
      cz1=p756q*u756_34(i3,i4).d(1,jut)+rmass(id7)*u756_34(i3,i4
     & ).c(1,jut)
      cz2=p756q*u756_34(i3,i4).d(2,jut)+rmass(id7)*u756_34(i3,i4
     & ).c(2,jut)
      u7_3456(i3,i4,i5,i6).c(iut,jut)=u7_3456(i3,i4,i5,i6).c(iut
     & ,jut)+l7_56(i5,i6).a(iut,1)*cw1+l7_56(i5,i6).c(iut,1)*cz1
     & +l7_56(i5,i6).a(iut,2)*cw2+l7_56(i5,i6).c(iut,2)*cz2
      u7_3456(i3,i4,i5,i6).d(iut,jut)=u7_3456(i3,i4,i5,i6).d(iut
     & ,jut)+l7_56(i5,i6).b(iut,1)*cw1+l7_56(i5,i6).d(iut,1)*cz1
     & +l7_56(i5,i6).b(iut,2)*cw2+l7_56(i5,i6).d(iut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id7.eq.5.and.id5.eq.5.and.id3.ne.5)then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TsT -- aa=u7_3456(i3,i4,i5,i6).a,bb=u7_3456(i3,i4,i5,i6).b,cc=u7_3456(
* i3,i4,i5,i6).c,dd=u7_3456(i3,i4,i5,i6).d,a1=l7_56(i5,i6).a,b1=l7_56(i5
* ,i6).b,c1=l7_56(i5,i6).c,d1=l7_56(i5,i6).d,a2=u756_34(i3,i4).a,b2=u756
* _34(i3,i4).b,c2=u756_34(i3,i4).c,d2=u756_34(i3,i4).d,prq=p756q,m=rmass
* (id7),nsum=1
      do iut=1,2
      cx1=l7_56(i5,i6).a(iut,1)+l7_56(i5,i6).c(iut,1)*rmass(id7)
      cx2=l7_56(i5,i6).c(iut,2)*p756q+l7_56(i5,i6).a(iut,2)*rmas
     & s(id7)
      cy1=l7_56(i5,i6).b(iut,1)+l7_56(i5,i6).d(iut,1)*rmass(id7)
      cy2=l7_56(i5,i6).d(iut,2)*p756q+l7_56(i5,i6).b(iut,2)*rmas
     & s(id7)
      cw1=l7_56(i5,i6).c(iut,1)*p756q+l7_56(i5,i6).a(iut,1)*rmas
     & s(id7)
      cw2=l7_56(i5,i6).a(iut,2)+l7_56(i5,i6).c(iut,2)*rmass(id7)
      cz1=l7_56(i5,i6).d(iut,1)*p756q+l7_56(i5,i6).b(iut,1)*rmas
     & s(id7)
      cz2=l7_56(i5,i6).b(iut,2)+l7_56(i5,i6).d(iut,2)*rmass(id7)
      u7_3456(i3,i4,i5,i6).a(iut,1)=u7_3456(i3,i4,i5,i6).a(iut,1
     & )+cx1*u756_34(i3,i4).a(1,1)+cx2*u756_34(i3,i4).b(2,1)
      u7_3456(i3,i4,i5,i6).b(iut,1)=u7_3456(i3,i4,i5,i6).b(iut,1
     & )+cy1*u756_34(i3,i4).a(1,1)+cy2*u756_34(i3,i4).b(2,1)
      u7_3456(i3,i4,i5,i6).c(iut,1)=u7_3456(i3,i4,i5,i6).c(iut,1
     & )+cw1*u756_34(i3,i4).d(1,1)+cw2*u756_34(i3,i4).c(2,1)
      u7_3456(i3,i4,i5,i6).d(iut,1)=u7_3456(i3,i4,i5,i6).d(iut,1
     & )+cz1*u756_34(i3,i4).d(1,1)+cz2*u756_34(i3,i4).c(2,1)
      u7_3456(i3,i4,i5,i6).a(iut,2)=u7_3456(i3,i4,i5,i6).a(iut,2
     & )+cw1*u756_34(i3,i4).b(1,2)+cw2*u756_34(i3,i4).a(2,2)
      u7_3456(i3,i4,i5,i6).b(iut,2)=u7_3456(i3,i4,i5,i6).b(iut,2
     & )+cz1*u756_34(i3,i4).b(1,2)+cz2*u756_34(i3,i4).a(2,2)
      u7_3456(i3,i4,i5,i6).c(iut,2)=u7_3456(i3,i4,i5,i6).c(iut,2
     & )+cx1*u756_34(i3,i4).c(1,2)+cx2*u756_34(i3,i4).d(2,2)
      u7_3456(i3,i4,i5,i6).d(iut,2)=u7_3456(i3,i4,i5,i6).d(iut,2
     & )+cy1*u756_34(i3,i4).c(1,2)+cy2*u756_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
      end do
  
        endif
  
        if(id7.eq.5.and.id5.ne.5.and.id3.eq.5)then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TTs -- aa=u7_3456(i3,i4,i5,i6).a,bb=u7_3456(i3,i4,i5,i6).b,cc=u7_3456(
* i3,i4,i5,i6).c,dd=u7_3456(i3,i4,i5,i6).d,a1=l7_56(i5,i6).a,b1=l7_56(i5
* ,i6).b,c1=l7_56(i5,i6).c,d1=l7_56(i5,i6).d,a2=u756_34(i3,i4).a,b2=u756
* _34(i3,i4).b,c2=u756_34(i3,i4).c,d2=u756_34(i3,i4).d,prq=p756q,m=rmass
* (id7),nsum=1
      do jut=1,2
      cx1=u756_34(i3,i4).a(1,jut)+rmass(id7)*u756_34(i3,i4).b(1,
     & jut)
      cx2=u756_34(i3,i4).a(2,jut)+rmass(id7)*u756_34(i3,i4).b(2,
     & jut)
      cy1=p756q*u756_34(i3,i4).b(1,jut)+rmass(id7)*u756_34(i3,i4
     & ).a(1,jut)
      cy2=p756q*u756_34(i3,i4).b(2,jut)+rmass(id7)*u756_34(i3,i4
     & ).a(2,jut)
      cw1=u756_34(i3,i4).c(1,jut)+rmass(id7)*u756_34(i3,i4).d(1,
     & jut)
      cw2=u756_34(i3,i4).c(2,jut)+rmass(id7)*u756_34(i3,i4).d(2,
     & jut)
      cz1=p756q*u756_34(i3,i4).d(1,jut)+rmass(id7)*u756_34(i3,i4
     & ).c(1,jut)
      cz2=p756q*u756_34(i3,i4).d(2,jut)+rmass(id7)*u756_34(i3,i4
     & ).c(2,jut)
      u7_3456(i3,i4,i5,i6).a(1,jut)=u7_3456(i3,i4,i5,i6).a(1,jut
     & )+l7_56(i5,i6).a(1,1)*cx1+l7_56(i5,i6).c(1,2)*cy2
      u7_3456(i3,i4,i5,i6).b(1,jut)=u7_3456(i3,i4,i5,i6).b(1,jut
     & )+l7_56(i5,i6).d(1,1)*cy1+l7_56(i5,i6).b(1,2)*cx2
      u7_3456(i3,i4,i5,i6).c(1,jut)=u7_3456(i3,i4,i5,i6).c(1,jut
     & )+l7_56(i5,i6).a(1,1)*cw1+l7_56(i5,i6).c(1,2)*cz2
      u7_3456(i3,i4,i5,i6).d(1,jut)=u7_3456(i3,i4,i5,i6).d(1,jut
     & )+l7_56(i5,i6).d(1,1)*cz1+l7_56(i5,i6).b(1,2)*cw2
      u7_3456(i3,i4,i5,i6).a(2,jut)=u7_3456(i3,i4,i5,i6).a(2,jut
     & )+l7_56(i5,i6).c(2,1)*cy1+l7_56(i5,i6).a(2,2)*cx2
      u7_3456(i3,i4,i5,i6).b(2,jut)=u7_3456(i3,i4,i5,i6).b(2,jut
     & )+l7_56(i5,i6).b(2,1)*cx1+l7_56(i5,i6).d(2,2)*cy2
      u7_3456(i3,i4,i5,i6).c(2,jut)=u7_3456(i3,i4,i5,i6).c(2,jut
     & )+l7_56(i5,i6).c(2,1)*cz1+l7_56(i5,i6).a(2,2)*cw2
      u7_3456(i3,i4,i5,i6).d(2,jut)=u7_3456(i3,i4,i5,i6).d(2,jut
     & )+l7_56(i5,i6).b(2,1)*cw1+l7_56(i5,i6).d(2,2)*cz2
      end do
      end do
      end do
      end do
      end do
  
        endif
  
      endif
  
  
*  COMPUTE  DIAGRAMS  WITH 3 FORKS ATTACHED TO A ZLINE                  
*               __                                                      
*                 |_Z,f,h_/                                             
*                 |       \                                             
*                 |                                                     
*                 |_Z,f,h_/                                             
*                 |       \                                             
*                 |                                                     
*                 |_Z,f,h_/                                             
*               __|       \                                             
*                                                                       
  
*Initialization of the variables to sum                                 
  
      do i1=1,2
       do i2=1,2
        do i3=1,2
         do i4=1,2
          do i5=1,2
           do i6=1,2
            do i7=1,2
             do i8=1,2
  
  
      cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)=czero
  
             enddo
            enddo		
           enddo
          enddo
         enddo
        enddo	
       enddo
      enddo
  
  
  
  
  
      if(id1.ne.5)then
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=cline_3forks_12(i3,i4,i5,i6,i7,i8).a,bb=cline_3forks_12(i3,i4
* ,i5,i6,i7,i8).b,cc=cline_3forks_12(i3,i4,i5,i6,i7,i8).c,dd=cline_3fork
* s_12(i3,i4,i5,i6,i7,i8).d,a1=u1_3456(i3,i4,i5,i6).a,b1=u1_3456(i3,i4,i
* 5,i6).b,c1=u1_3456(i3,i4,i5,i6).c,d1=u1_3456(i3,i4,i5,i6).d,a2=r2_78(i
* 7,i8).a,b2=r2_78(i7,i8).b,c2=r2_78(i7,i8).c,d2=r2_78(i7,i8).d,prq=p278
* q,m=rmass(id1),nsum=0
      cline_3forks_12(i3,i4,i5,i6,i7,i8).a(1,1)=u1_3456(i3,i4,i5
     & ,i6).a(1,1)*r2_78(i7,i8).a(1,1)+u1_3456(i3,i4,i5,i6).c(1,
     & 2)*p278q*r2_78(i7,i8).b(2,1)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).b(1,1)=rmass(id1)*(u1_3
     & 456(i3,i4,i5,i6).d(1,1)*r2_78(i7,i8).a(1,1)+u1_3456(i3,i4
     & ,i5,i6).b(1,2)*r2_78(i7,i8).b(2,1))
      cline_3forks_12(i3,i4,i5,i6,i7,i8).c(1,1)=rmass(id1)*(u1_3
     & 456(i3,i4,i5,i6).a(1,1)*r2_78(i7,i8).d(1,1)+u1_3456(i3,i4
     & ,i5,i6).c(1,2)*r2_78(i7,i8).c(2,1))
      cline_3forks_12(i3,i4,i5,i6,i7,i8).d(1,1)=u1_3456(i3,i4,i5
     & ,i6).d(1,1)*p278q*r2_78(i7,i8).d(1,1)+u1_3456(i3,i4,i5,i6
     & ).b(1,2)*r2_78(i7,i8).c(2,1)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).a(1,2)=rmass(id1)*(u1_3
     & 456(i3,i4,i5,i6).a(1,1)*r2_78(i7,i8).b(1,2)+u1_3456(i3,i4
     & ,i5,i6).c(1,2)*r2_78(i7,i8).a(2,2))
      cline_3forks_12(i3,i4,i5,i6,i7,i8).b(1,2)=u1_3456(i3,i4,i5
     & ,i6).d(1,1)*p278q*r2_78(i7,i8).b(1,2)+u1_3456(i3,i4,i5,i6
     & ).b(1,2)*r2_78(i7,i8).a(2,2)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).c(1,2)=u1_3456(i3,i4,i5
     & ,i6).a(1,1)*r2_78(i7,i8).c(1,2)+u1_3456(i3,i4,i5,i6).c(1,
     & 2)*p278q*r2_78(i7,i8).d(2,2)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).d(1,2)=rmass(id1)*(u1_3
     & 456(i3,i4,i5,i6).d(1,1)*r2_78(i7,i8).c(1,2)+u1_3456(i3,i4
     & ,i5,i6).b(1,2)*r2_78(i7,i8).d(2,2))
      cline_3forks_12(i3,i4,i5,i6,i7,i8).a(2,1)=rmass(id1)*(u1_3
     & 456(i3,i4,i5,i6).c(2,1)*r2_78(i7,i8).a(1,1)+u1_3456(i3,i4
     & ,i5,i6).a(2,2)*r2_78(i7,i8).b(2,1))
      cline_3forks_12(i3,i4,i5,i6,i7,i8).b(2,1)=u1_3456(i3,i4,i5
     & ,i6).b(2,1)*r2_78(i7,i8).a(1,1)+u1_3456(i3,i4,i5,i6).d(2,
     & 2)*p278q*r2_78(i7,i8).b(2,1)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).c(2,1)=u1_3456(i3,i4,i5
     & ,i6).c(2,1)*p278q*r2_78(i7,i8).d(1,1)+u1_3456(i3,i4,i5,i6
     & ).a(2,2)*r2_78(i7,i8).c(2,1)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).d(2,1)=rmass(id1)*(u1_3
     & 456(i3,i4,i5,i6).b(2,1)*r2_78(i7,i8).d(1,1)+u1_3456(i3,i4
     & ,i5,i6).d(2,2)*r2_78(i7,i8).c(2,1))
      cline_3forks_12(i3,i4,i5,i6,i7,i8).a(2,2)=u1_3456(i3,i4,i5
     & ,i6).c(2,1)*p278q*r2_78(i7,i8).b(1,2)+u1_3456(i3,i4,i5,i6
     & ).a(2,2)*r2_78(i7,i8).a(2,2)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).b(2,2)=rmass(id1)*(u1_3
     & 456(i3,i4,i5,i6).b(2,1)*r2_78(i7,i8).b(1,2)+u1_3456(i3,i4
     & ,i5,i6).d(2,2)*r2_78(i7,i8).a(2,2))
      cline_3forks_12(i3,i4,i5,i6,i7,i8).c(2,2)=rmass(id1)*(u1_3
     & 456(i3,i4,i5,i6).c(2,1)*r2_78(i7,i8).c(1,2)+u1_3456(i3,i4
     & ,i5,i6).a(2,2)*r2_78(i7,i8).d(2,2))
      cline_3forks_12(i3,i4,i5,i6,i7,i8).d(2,2)=u1_3456(i3,i4,i5
     & ,i6).b(2,1)*r2_78(i7,i8).c(1,2)+u1_3456(i3,i4,i5,i6).d(2,
     & 2)*p278q*r2_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
  
      else
  
         if(id1.eq.5.and.id7.ne.5)then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=cline_3forks_12(i3,i4,i5,i6,i7,i8).a,bb=cline_3forks_12(i3,i
* 4,i5,i6,i7,i8).b,cc=cline_3forks_12(i3,i4,i5,i6,i7,i8).c,dd=cline_3for
* ks_12(i3,i4,i5,i6,i7,i8).d,a1=u1_3456(i3,i4,i5,i6).a,b1=u1_3456(i3,i4,
* i5,i6).b,c1=u1_3456(i3,i4,i5,i6).c,d1=u1_3456(i3,i4,i5,i6).d,a2=r2_78(
* i7,i8).a,b2=r2_78(i7,i8).b,c2=r2_78(i7,i8).c,d2=r2_78(i7,i8).d,prq=p27
* 8q,m=rmass(id1),nsum=0
      do iut=1,2
      cx1=u1_3456(i3,i4,i5,i6).a(iut,1)+u1_3456(i3,i4,i5,i6).c(i
     & ut,1)*rmass(id1)
      cx2=u1_3456(i3,i4,i5,i6).c(iut,2)*p278q+u1_3456(i3,i4,i5,i
     & 6).a(iut,2)*rmass(id1)
      cy1=u1_3456(i3,i4,i5,i6).b(iut,1)+u1_3456(i3,i4,i5,i6).d(i
     & ut,1)*rmass(id1)
      cy2=u1_3456(i3,i4,i5,i6).d(iut,2)*p278q+u1_3456(i3,i4,i5,i
     & 6).b(iut,2)*rmass(id1)
      cw1=u1_3456(i3,i4,i5,i6).c(iut,1)*p278q+u1_3456(i3,i4,i5,i
     & 6).a(iut,1)*rmass(id1)
      cw2=u1_3456(i3,i4,i5,i6).a(iut,2)+u1_3456(i3,i4,i5,i6).c(i
     & ut,2)*rmass(id1)
      cz1=u1_3456(i3,i4,i5,i6).d(iut,1)*p278q+u1_3456(i3,i4,i5,i
     & 6).b(iut,1)*rmass(id1)
      cz2=u1_3456(i3,i4,i5,i6).b(iut,2)+u1_3456(i3,i4,i5,i6).d(i
     & ut,2)*rmass(id1)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).a(iut,1)=cx1*r2_78(i7,i
     & 8).a(1,1)+cx2*r2_78(i7,i8).b(2,1)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).b(iut,1)=cy1*r2_78(i7,i
     & 8).a(1,1)+cy2*r2_78(i7,i8).b(2,1)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).c(iut,1)=cw1*r2_78(i7,i
     & 8).d(1,1)+cw2*r2_78(i7,i8).c(2,1)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).d(iut,1)=cz1*r2_78(i7,i
     & 8).d(1,1)+cz2*r2_78(i7,i8).c(2,1)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).a(iut,2)=cw1*r2_78(i7,i
     & 8).b(1,2)+cw2*r2_78(i7,i8).a(2,2)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).b(iut,2)=cz1*r2_78(i7,i
     & 8).b(1,2)+cz2*r2_78(i7,i8).a(2,2)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).c(iut,2)=cx1*r2_78(i7,i
     & 8).c(1,2)+cx2*r2_78(i7,i8).d(2,2)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).d(iut,2)=cy1*r2_78(i7,i
     & 8).c(1,2)+cy2*r2_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
   	
      else
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=cline_3forks_12(i3,i4,i5,i6,i7,i8).a,bb=cline_3forks_12(i3,
* i4,i5,i6,i7,i8).b,cc=cline_3forks_12(i3,i4,i5,i6,i7,i8).c,dd=cline_3fo
* rks_12(i3,i4,i5,i6,i7,i8).d,a1=u1_3456(i3,i4,i5,i6).a,b1=u1_3456(i3,i4
* ,i5,i6).b,c1=u1_3456(i3,i4,i5,i6).c,d1=u1_3456(i3,i4,i5,i6).d,a2=r2_78
* (i7,i8).a,b2=r2_78(i7,i8).b,c2=r2_78(i7,i8).c,d2=r2_78(i7,i8).d,prq=p2
* 78q,m=rmass(id1),nsum=0
      do iut=1,2
      do jut=1,2
      cx1=r2_78(i7,i8).a(1,jut)+rmass(id1)*r2_78(i7,i8).b(1,jut)
      cx2=r2_78(i7,i8).a(2,jut)+rmass(id1)*r2_78(i7,i8).b(2,jut)
      cy1=p278q*r2_78(i7,i8).b(1,jut)+rmass(id1)*r2_78(i7,i8).a(
     & 1,jut)
      cy2=p278q*r2_78(i7,i8).b(2,jut)+rmass(id1)*r2_78(i7,i8).a(
     & 2,jut)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).a(iut,jut)=u1_3456(i3,i
     & 4,i5,i6).a(iut,1)*cx1+u1_3456(i3,i4,i5,i6).c(iut,1)*cy1+u
     & 1_3456(i3,i4,i5,i6).a(iut,2)*cx2+u1_3456(i3,i4,i5,i6).c(i
     & ut,2)*cy2
      cline_3forks_12(i3,i4,i5,i6,i7,i8).b(iut,jut)=u1_3456(i3,i
     & 4,i5,i6).b(iut,1)*cx1+u1_3456(i3,i4,i5,i6).d(iut,1)*cy1+u
     & 1_3456(i3,i4,i5,i6).b(iut,2)*cx2+u1_3456(i3,i4,i5,i6).d(i
     & ut,2)*cy2
      cw1=r2_78(i7,i8).c(1,jut)+rmass(id1)*r2_78(i7,i8).d(1,jut)
      cw2=r2_78(i7,i8).c(2,jut)+rmass(id1)*r2_78(i7,i8).d(2,jut)
      cz1=p278q*r2_78(i7,i8).d(1,jut)+rmass(id1)*r2_78(i7,i8).c(
     & 1,jut)
      cz2=p278q*r2_78(i7,i8).d(2,jut)+rmass(id1)*r2_78(i7,i8).c(
     & 2,jut)
      cline_3forks_12(i3,i4,i5,i6,i7,i8).c(iut,jut)=u1_3456(i3,i
     & 4,i5,i6).a(iut,1)*cw1+u1_3456(i3,i4,i5,i6).c(iut,1)*cz1+u
     & 1_3456(i3,i4,i5,i6).a(iut,2)*cw2+u1_3456(i3,i4,i5,i6).c(i
     & ut,2)*cz2
      cline_3forks_12(i3,i4,i5,i6,i7,i8).d(iut,jut)=u1_3456(i3,i
     & 4,i5,i6).b(iut,1)*cw1+u1_3456(i3,i4,i5,i6).d(iut,1)*cz1+u
     & 1_3456(i3,i4,i5,i6).b(iut,2)*cw2+u1_3456(i3,i4,i5,i6).d(i
     & ut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
        	
  
  
      endif	
  
  
      rmassl=rmass(id1)
      rmassr=-rmassl
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* mline -- res=cres_3forks_12(i3,i4,i5,i6,i7,i8).pol(&1,&2),abcd=cline_3
* forks_12(i3,i4,i5,i6,i7,i8).,m1=rmassl,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cres_3forks_12(i3,i4,i5,i6,i7,i8).pol(iut,jut)=cline_3fork
     & s_12(i3,i4,i5,i6,i7,i8).a(iut,jut)+rmassl*cline_3forks_12
     & (i3,i4,i5,i6,i7,i8).b(iut,jut)+rmassr*cline_3forks_12(i3,
     & i4,i5,i6,i7,i8).c(iut,jut)+rmassl*rmassr*cline_3forks_12(
     & i3,i4,i5,i6,i7,i8).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
      end do
      end do
      end do
  
      do i1=1,2
       do i2=1,2
        do i3=1,2
         do i4=1,2
          do i5=1,2
           do i6=1,2
            do i7=1,2
             do i8=1,2
                        	
            cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &      cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &      cres_3forks_12(i3,i4,i5,i6,i7,i8).pol(i1,i2)
  
             enddo
            enddo		
           enddo
          enddo
         enddo
        enddo	
       enddo
      enddo
  
  
  
  
  
  
  
      if(id1.ne.5)then
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
      do i5=1,2
      do i6=1,2
* TT -- aa=cline_3forks_12(i3,i4,i7,i8,i5,i6).a,bb=cline_3forks_12(i3,i4
* ,i7,i8,i5,i6).b,cc=cline_3forks_12(i3,i4,i7,i8,i5,i6).c,dd=cline_3fork
* s_12(i3,i4,i7,i8,i5,i6).d,a1=u1_3478(i3,i4,i7,i8).a,b1=u1_3478(i3,i4,i
* 7,i8).b,c1=u1_3478(i3,i4,i7,i8).c,d1=u1_3478(i3,i4,i7,i8).d,a2=r2_56(i
* 5,i6).a,b2=r2_56(i5,i6).b,c2=r2_56(i5,i6).c,d2=r2_56(i5,i6).d,prq=p256
* q,m=rmass(id1),nsum=0
      cline_3forks_12(i3,i4,i7,i8,i5,i6).a(1,1)=u1_3478(i3,i4,i7
     & ,i8).a(1,1)*r2_56(i5,i6).a(1,1)+u1_3478(i3,i4,i7,i8).c(1,
     & 2)*p256q*r2_56(i5,i6).b(2,1)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).b(1,1)=rmass(id1)*(u1_3
     & 478(i3,i4,i7,i8).d(1,1)*r2_56(i5,i6).a(1,1)+u1_3478(i3,i4
     & ,i7,i8).b(1,2)*r2_56(i5,i6).b(2,1))
      cline_3forks_12(i3,i4,i7,i8,i5,i6).c(1,1)=rmass(id1)*(u1_3
     & 478(i3,i4,i7,i8).a(1,1)*r2_56(i5,i6).d(1,1)+u1_3478(i3,i4
     & ,i7,i8).c(1,2)*r2_56(i5,i6).c(2,1))
      cline_3forks_12(i3,i4,i7,i8,i5,i6).d(1,1)=u1_3478(i3,i4,i7
     & ,i8).d(1,1)*p256q*r2_56(i5,i6).d(1,1)+u1_3478(i3,i4,i7,i8
     & ).b(1,2)*r2_56(i5,i6).c(2,1)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).a(1,2)=rmass(id1)*(u1_3
     & 478(i3,i4,i7,i8).a(1,1)*r2_56(i5,i6).b(1,2)+u1_3478(i3,i4
     & ,i7,i8).c(1,2)*r2_56(i5,i6).a(2,2))
      cline_3forks_12(i3,i4,i7,i8,i5,i6).b(1,2)=u1_3478(i3,i4,i7
     & ,i8).d(1,1)*p256q*r2_56(i5,i6).b(1,2)+u1_3478(i3,i4,i7,i8
     & ).b(1,2)*r2_56(i5,i6).a(2,2)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).c(1,2)=u1_3478(i3,i4,i7
     & ,i8).a(1,1)*r2_56(i5,i6).c(1,2)+u1_3478(i3,i4,i7,i8).c(1,
     & 2)*p256q*r2_56(i5,i6).d(2,2)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).d(1,2)=rmass(id1)*(u1_3
     & 478(i3,i4,i7,i8).d(1,1)*r2_56(i5,i6).c(1,2)+u1_3478(i3,i4
     & ,i7,i8).b(1,2)*r2_56(i5,i6).d(2,2))
      cline_3forks_12(i3,i4,i7,i8,i5,i6).a(2,1)=rmass(id1)*(u1_3
     & 478(i3,i4,i7,i8).c(2,1)*r2_56(i5,i6).a(1,1)+u1_3478(i3,i4
     & ,i7,i8).a(2,2)*r2_56(i5,i6).b(2,1))
      cline_3forks_12(i3,i4,i7,i8,i5,i6).b(2,1)=u1_3478(i3,i4,i7
     & ,i8).b(2,1)*r2_56(i5,i6).a(1,1)+u1_3478(i3,i4,i7,i8).d(2,
     & 2)*p256q*r2_56(i5,i6).b(2,1)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).c(2,1)=u1_3478(i3,i4,i7
     & ,i8).c(2,1)*p256q*r2_56(i5,i6).d(1,1)+u1_3478(i3,i4,i7,i8
     & ).a(2,2)*r2_56(i5,i6).c(2,1)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).d(2,1)=rmass(id1)*(u1_3
     & 478(i3,i4,i7,i8).b(2,1)*r2_56(i5,i6).d(1,1)+u1_3478(i3,i4
     & ,i7,i8).d(2,2)*r2_56(i5,i6).c(2,1))
      cline_3forks_12(i3,i4,i7,i8,i5,i6).a(2,2)=u1_3478(i3,i4,i7
     & ,i8).c(2,1)*p256q*r2_56(i5,i6).b(1,2)+u1_3478(i3,i4,i7,i8
     & ).a(2,2)*r2_56(i5,i6).a(2,2)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).b(2,2)=rmass(id1)*(u1_3
     & 478(i3,i4,i7,i8).b(2,1)*r2_56(i5,i6).b(1,2)+u1_3478(i3,i4
     & ,i7,i8).d(2,2)*r2_56(i5,i6).a(2,2))
      cline_3forks_12(i3,i4,i7,i8,i5,i6).c(2,2)=rmass(id1)*(u1_3
     & 478(i3,i4,i7,i8).c(2,1)*r2_56(i5,i6).c(1,2)+u1_3478(i3,i4
     & ,i7,i8).a(2,2)*r2_56(i5,i6).d(2,2))
      cline_3forks_12(i3,i4,i7,i8,i5,i6).d(2,2)=u1_3478(i3,i4,i7
     & ,i8).b(2,1)*r2_56(i5,i6).c(1,2)+u1_3478(i3,i4,i7,i8).d(2,
     & 2)*p256q*r2_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
  
      else
  
         if(id1.eq.5.and.id5.ne.5)then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
      do i5=1,2
      do i6=1,2
* TsT -- aa=cline_3forks_12(i3,i4,i7,i8,i5,i6).a,bb=cline_3forks_12(i3,i
* 4,i7,i8,i5,i6).b,cc=cline_3forks_12(i3,i4,i7,i8,i5,i6).c,dd=cline_3for
* ks_12(i3,i4,i7,i8,i5,i6).d,a1=u1_3478(i3,i4,i7,i8).a,b1=u1_3478(i3,i4,
* i7,i8).b,c1=u1_3478(i3,i4,i7,i8).c,d1=u1_3478(i3,i4,i7,i8).d,a2=r2_56(
* i5,i6).a,b2=r2_56(i5,i6).b,c2=r2_56(i5,i6).c,d2=r2_56(i5,i6).d,prq=p25
* 6q,m=rmass(id1),nsum=0
      do iut=1,2
      cx1=u1_3478(i3,i4,i7,i8).a(iut,1)+u1_3478(i3,i4,i7,i8).c(i
     & ut,1)*rmass(id1)
      cx2=u1_3478(i3,i4,i7,i8).c(iut,2)*p256q+u1_3478(i3,i4,i7,i
     & 8).a(iut,2)*rmass(id1)
      cy1=u1_3478(i3,i4,i7,i8).b(iut,1)+u1_3478(i3,i4,i7,i8).d(i
     & ut,1)*rmass(id1)
      cy2=u1_3478(i3,i4,i7,i8).d(iut,2)*p256q+u1_3478(i3,i4,i7,i
     & 8).b(iut,2)*rmass(id1)
      cw1=u1_3478(i3,i4,i7,i8).c(iut,1)*p256q+u1_3478(i3,i4,i7,i
     & 8).a(iut,1)*rmass(id1)
      cw2=u1_3478(i3,i4,i7,i8).a(iut,2)+u1_3478(i3,i4,i7,i8).c(i
     & ut,2)*rmass(id1)
      cz1=u1_3478(i3,i4,i7,i8).d(iut,1)*p256q+u1_3478(i3,i4,i7,i
     & 8).b(iut,1)*rmass(id1)
      cz2=u1_3478(i3,i4,i7,i8).b(iut,2)+u1_3478(i3,i4,i7,i8).d(i
     & ut,2)*rmass(id1)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).a(iut,1)=cx1*r2_56(i5,i
     & 6).a(1,1)+cx2*r2_56(i5,i6).b(2,1)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).b(iut,1)=cy1*r2_56(i5,i
     & 6).a(1,1)+cy2*r2_56(i5,i6).b(2,1)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).c(iut,1)=cw1*r2_56(i5,i
     & 6).d(1,1)+cw2*r2_56(i5,i6).c(2,1)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).d(iut,1)=cz1*r2_56(i5,i
     & 6).d(1,1)+cz2*r2_56(i5,i6).c(2,1)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).a(iut,2)=cw1*r2_56(i5,i
     & 6).b(1,2)+cw2*r2_56(i5,i6).a(2,2)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).b(iut,2)=cz1*r2_56(i5,i
     & 6).b(1,2)+cz2*r2_56(i5,i6).a(2,2)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).c(iut,2)=cx1*r2_56(i5,i
     & 6).c(1,2)+cx2*r2_56(i5,i6).d(2,2)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).d(iut,2)=cy1*r2_56(i5,i
     & 6).c(1,2)+cy2*r2_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
   	
      else
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
      do i5=1,2
      do i6=1,2
* TsTs -- aa=cline_3forks_12(i3,i4,i7,i8,i5,i6).a,bb=cline_3forks_12(i3,
* i4,i7,i8,i5,i6).b,cc=cline_3forks_12(i3,i4,i7,i8,i5,i6).c,dd=cline_3fo
* rks_12(i3,i4,i7,i8,i5,i6).d,a1=u1_3478(i3,i4,i7,i8).a,b1=u1_3478(i3,i4
* ,i7,i8).b,c1=u1_3478(i3,i4,i7,i8).c,d1=u1_3478(i3,i4,i7,i8).d,a2=r2_56
* (i5,i6).a,b2=r2_56(i5,i6).b,c2=r2_56(i5,i6).c,d2=r2_56(i5,i6).d,prq=p2
* 56q,m=rmass(id1),nsum=0
      do iut=1,2
      do jut=1,2
      cx1=r2_56(i5,i6).a(1,jut)+rmass(id1)*r2_56(i5,i6).b(1,jut)
      cx2=r2_56(i5,i6).a(2,jut)+rmass(id1)*r2_56(i5,i6).b(2,jut)
      cy1=p256q*r2_56(i5,i6).b(1,jut)+rmass(id1)*r2_56(i5,i6).a(
     & 1,jut)
      cy2=p256q*r2_56(i5,i6).b(2,jut)+rmass(id1)*r2_56(i5,i6).a(
     & 2,jut)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).a(iut,jut)=u1_3478(i3,i
     & 4,i7,i8).a(iut,1)*cx1+u1_3478(i3,i4,i7,i8).c(iut,1)*cy1+u
     & 1_3478(i3,i4,i7,i8).a(iut,2)*cx2+u1_3478(i3,i4,i7,i8).c(i
     & ut,2)*cy2
      cline_3forks_12(i3,i4,i7,i8,i5,i6).b(iut,jut)=u1_3478(i3,i
     & 4,i7,i8).b(iut,1)*cx1+u1_3478(i3,i4,i7,i8).d(iut,1)*cy1+u
     & 1_3478(i3,i4,i7,i8).b(iut,2)*cx2+u1_3478(i3,i4,i7,i8).d(i
     & ut,2)*cy2
      cw1=r2_56(i5,i6).c(1,jut)+rmass(id1)*r2_56(i5,i6).d(1,jut)
      cw2=r2_56(i5,i6).c(2,jut)+rmass(id1)*r2_56(i5,i6).d(2,jut)
      cz1=p256q*r2_56(i5,i6).d(1,jut)+rmass(id1)*r2_56(i5,i6).c(
     & 1,jut)
      cz2=p256q*r2_56(i5,i6).d(2,jut)+rmass(id1)*r2_56(i5,i6).c(
     & 2,jut)
      cline_3forks_12(i3,i4,i7,i8,i5,i6).c(iut,jut)=u1_3478(i3,i
     & 4,i7,i8).a(iut,1)*cw1+u1_3478(i3,i4,i7,i8).c(iut,1)*cz1+u
     & 1_3478(i3,i4,i7,i8).a(iut,2)*cw2+u1_3478(i3,i4,i7,i8).c(i
     & ut,2)*cz2
      cline_3forks_12(i3,i4,i7,i8,i5,i6).d(iut,jut)=u1_3478(i3,i
     & 4,i7,i8).b(iut,1)*cw1+u1_3478(i3,i4,i7,i8).d(iut,1)*cz1+u
     & 1_3478(i3,i4,i7,i8).b(iut,2)*cw2+u1_3478(i3,i4,i7,i8).d(i
     & ut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
        	
  
  
      endif	
  
  
      rmassl=rmass(id1)
      rmassr=-rmassl
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
      do i5=1,2
      do i6=1,2
* mline -- res=cres_3forks_12(i3,i4,i7,i8,i5,i6).pol(&1,&2),abcd=cline_3
* forks_12(i3,i4,i7,i8,i5,i6).,m1=rmassl,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cres_3forks_12(i3,i4,i7,i8,i5,i6).pol(iut,jut)=cline_3fork
     & s_12(i3,i4,i7,i8,i5,i6).a(iut,jut)+rmassl*cline_3forks_12
     & (i3,i4,i7,i8,i5,i6).b(iut,jut)+rmassr*cline_3forks_12(i3,
     & i4,i7,i8,i5,i6).c(iut,jut)+rmassl*rmassr*cline_3forks_12(
     & i3,i4,i7,i8,i5,i6).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
      end do
      end do
      end do
  
      do i1=1,2
       do i2=1,2
        do i3=1,2
         do i4=1,2
          do i5=1,2
           do i6=1,2
            do i7=1,2
             do i8=1,2
                        	
            cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &      cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &      cres_3forks_12(i3,i4,i7,i8,i5,i6).pol(i1,i2)
  
             enddo
            enddo		
           enddo
          enddo
         enddo
        enddo	
       enddo
      enddo
  
  
  
  
  
  
  
      if(id1.ne.5)then
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
      do i3=1,2
      do i4=1,2
* TT -- aa=cline_3forks_12(i5,i6,i7,i8,i3,i4).a,bb=cline_3forks_12(i5,i6
* ,i7,i8,i3,i4).b,cc=cline_3forks_12(i5,i6,i7,i8,i3,i4).c,dd=cline_3fork
* s_12(i5,i6,i7,i8,i3,i4).d,a1=u1_5678(i5,i6,i7,i8).a,b1=u1_5678(i5,i6,i
* 7,i8).b,c1=u1_5678(i5,i6,i7,i8).c,d1=u1_5678(i5,i6,i7,i8).d,a2=r2_34(i
* 3,i4).a,b2=r2_34(i3,i4).b,c2=r2_34(i3,i4).c,d2=r2_34(i3,i4).d,prq=p234
* q,m=rmass(id1),nsum=0
      cline_3forks_12(i5,i6,i7,i8,i3,i4).a(1,1)=u1_5678(i5,i6,i7
     & ,i8).a(1,1)*r2_34(i3,i4).a(1,1)+u1_5678(i5,i6,i7,i8).c(1,
     & 2)*p234q*r2_34(i3,i4).b(2,1)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).b(1,1)=rmass(id1)*(u1_5
     & 678(i5,i6,i7,i8).d(1,1)*r2_34(i3,i4).a(1,1)+u1_5678(i5,i6
     & ,i7,i8).b(1,2)*r2_34(i3,i4).b(2,1))
      cline_3forks_12(i5,i6,i7,i8,i3,i4).c(1,1)=rmass(id1)*(u1_5
     & 678(i5,i6,i7,i8).a(1,1)*r2_34(i3,i4).d(1,1)+u1_5678(i5,i6
     & ,i7,i8).c(1,2)*r2_34(i3,i4).c(2,1))
      cline_3forks_12(i5,i6,i7,i8,i3,i4).d(1,1)=u1_5678(i5,i6,i7
     & ,i8).d(1,1)*p234q*r2_34(i3,i4).d(1,1)+u1_5678(i5,i6,i7,i8
     & ).b(1,2)*r2_34(i3,i4).c(2,1)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).a(1,2)=rmass(id1)*(u1_5
     & 678(i5,i6,i7,i8).a(1,1)*r2_34(i3,i4).b(1,2)+u1_5678(i5,i6
     & ,i7,i8).c(1,2)*r2_34(i3,i4).a(2,2))
      cline_3forks_12(i5,i6,i7,i8,i3,i4).b(1,2)=u1_5678(i5,i6,i7
     & ,i8).d(1,1)*p234q*r2_34(i3,i4).b(1,2)+u1_5678(i5,i6,i7,i8
     & ).b(1,2)*r2_34(i3,i4).a(2,2)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).c(1,2)=u1_5678(i5,i6,i7
     & ,i8).a(1,1)*r2_34(i3,i4).c(1,2)+u1_5678(i5,i6,i7,i8).c(1,
     & 2)*p234q*r2_34(i3,i4).d(2,2)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).d(1,2)=rmass(id1)*(u1_5
     & 678(i5,i6,i7,i8).d(1,1)*r2_34(i3,i4).c(1,2)+u1_5678(i5,i6
     & ,i7,i8).b(1,2)*r2_34(i3,i4).d(2,2))
      cline_3forks_12(i5,i6,i7,i8,i3,i4).a(2,1)=rmass(id1)*(u1_5
     & 678(i5,i6,i7,i8).c(2,1)*r2_34(i3,i4).a(1,1)+u1_5678(i5,i6
     & ,i7,i8).a(2,2)*r2_34(i3,i4).b(2,1))
      cline_3forks_12(i5,i6,i7,i8,i3,i4).b(2,1)=u1_5678(i5,i6,i7
     & ,i8).b(2,1)*r2_34(i3,i4).a(1,1)+u1_5678(i5,i6,i7,i8).d(2,
     & 2)*p234q*r2_34(i3,i4).b(2,1)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).c(2,1)=u1_5678(i5,i6,i7
     & ,i8).c(2,1)*p234q*r2_34(i3,i4).d(1,1)+u1_5678(i5,i6,i7,i8
     & ).a(2,2)*r2_34(i3,i4).c(2,1)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).d(2,1)=rmass(id1)*(u1_5
     & 678(i5,i6,i7,i8).b(2,1)*r2_34(i3,i4).d(1,1)+u1_5678(i5,i6
     & ,i7,i8).d(2,2)*r2_34(i3,i4).c(2,1))
      cline_3forks_12(i5,i6,i7,i8,i3,i4).a(2,2)=u1_5678(i5,i6,i7
     & ,i8).c(2,1)*p234q*r2_34(i3,i4).b(1,2)+u1_5678(i5,i6,i7,i8
     & ).a(2,2)*r2_34(i3,i4).a(2,2)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).b(2,2)=rmass(id1)*(u1_5
     & 678(i5,i6,i7,i8).b(2,1)*r2_34(i3,i4).b(1,2)+u1_5678(i5,i6
     & ,i7,i8).d(2,2)*r2_34(i3,i4).a(2,2))
      cline_3forks_12(i5,i6,i7,i8,i3,i4).c(2,2)=rmass(id1)*(u1_5
     & 678(i5,i6,i7,i8).c(2,1)*r2_34(i3,i4).c(1,2)+u1_5678(i5,i6
     & ,i7,i8).a(2,2)*r2_34(i3,i4).d(2,2))
      cline_3forks_12(i5,i6,i7,i8,i3,i4).d(2,2)=u1_5678(i5,i6,i7
     & ,i8).b(2,1)*r2_34(i3,i4).c(1,2)+u1_5678(i5,i6,i7,i8).d(2,
     & 2)*p234q*r2_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
  
      else
  
         if(id1.eq.5.and.id3.ne.5)then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
      do i3=1,2
      do i4=1,2
* TsT -- aa=cline_3forks_12(i5,i6,i7,i8,i3,i4).a,bb=cline_3forks_12(i5,i
* 6,i7,i8,i3,i4).b,cc=cline_3forks_12(i5,i6,i7,i8,i3,i4).c,dd=cline_3for
* ks_12(i5,i6,i7,i8,i3,i4).d,a1=u1_5678(i5,i6,i7,i8).a,b1=u1_5678(i5,i6,
* i7,i8).b,c1=u1_5678(i5,i6,i7,i8).c,d1=u1_5678(i5,i6,i7,i8).d,a2=r2_34(
* i3,i4).a,b2=r2_34(i3,i4).b,c2=r2_34(i3,i4).c,d2=r2_34(i3,i4).d,prq=p23
* 4q,m=rmass(id1),nsum=0
      do iut=1,2
      cx1=u1_5678(i5,i6,i7,i8).a(iut,1)+u1_5678(i5,i6,i7,i8).c(i
     & ut,1)*rmass(id1)
      cx2=u1_5678(i5,i6,i7,i8).c(iut,2)*p234q+u1_5678(i5,i6,i7,i
     & 8).a(iut,2)*rmass(id1)
      cy1=u1_5678(i5,i6,i7,i8).b(iut,1)+u1_5678(i5,i6,i7,i8).d(i
     & ut,1)*rmass(id1)
      cy2=u1_5678(i5,i6,i7,i8).d(iut,2)*p234q+u1_5678(i5,i6,i7,i
     & 8).b(iut,2)*rmass(id1)
      cw1=u1_5678(i5,i6,i7,i8).c(iut,1)*p234q+u1_5678(i5,i6,i7,i
     & 8).a(iut,1)*rmass(id1)
      cw2=u1_5678(i5,i6,i7,i8).a(iut,2)+u1_5678(i5,i6,i7,i8).c(i
     & ut,2)*rmass(id1)
      cz1=u1_5678(i5,i6,i7,i8).d(iut,1)*p234q+u1_5678(i5,i6,i7,i
     & 8).b(iut,1)*rmass(id1)
      cz2=u1_5678(i5,i6,i7,i8).b(iut,2)+u1_5678(i5,i6,i7,i8).d(i
     & ut,2)*rmass(id1)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).a(iut,1)=cx1*r2_34(i3,i
     & 4).a(1,1)+cx2*r2_34(i3,i4).b(2,1)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).b(iut,1)=cy1*r2_34(i3,i
     & 4).a(1,1)+cy2*r2_34(i3,i4).b(2,1)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).c(iut,1)=cw1*r2_34(i3,i
     & 4).d(1,1)+cw2*r2_34(i3,i4).c(2,1)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).d(iut,1)=cz1*r2_34(i3,i
     & 4).d(1,1)+cz2*r2_34(i3,i4).c(2,1)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).a(iut,2)=cw1*r2_34(i3,i
     & 4).b(1,2)+cw2*r2_34(i3,i4).a(2,2)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).b(iut,2)=cz1*r2_34(i3,i
     & 4).b(1,2)+cz2*r2_34(i3,i4).a(2,2)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).c(iut,2)=cx1*r2_34(i3,i
     & 4).c(1,2)+cx2*r2_34(i3,i4).d(2,2)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).d(iut,2)=cy1*r2_34(i3,i
     & 4).c(1,2)+cy2*r2_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
   	
      else
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
      do i3=1,2
      do i4=1,2
* TsTs -- aa=cline_3forks_12(i5,i6,i7,i8,i3,i4).a,bb=cline_3forks_12(i5,
* i6,i7,i8,i3,i4).b,cc=cline_3forks_12(i5,i6,i7,i8,i3,i4).c,dd=cline_3fo
* rks_12(i5,i6,i7,i8,i3,i4).d,a1=u1_5678(i5,i6,i7,i8).a,b1=u1_5678(i5,i6
* ,i7,i8).b,c1=u1_5678(i5,i6,i7,i8).c,d1=u1_5678(i5,i6,i7,i8).d,a2=r2_34
* (i3,i4).a,b2=r2_34(i3,i4).b,c2=r2_34(i3,i4).c,d2=r2_34(i3,i4).d,prq=p2
* 34q,m=rmass(id1),nsum=0
      do iut=1,2
      do jut=1,2
      cx1=r2_34(i3,i4).a(1,jut)+rmass(id1)*r2_34(i3,i4).b(1,jut)
      cx2=r2_34(i3,i4).a(2,jut)+rmass(id1)*r2_34(i3,i4).b(2,jut)
      cy1=p234q*r2_34(i3,i4).b(1,jut)+rmass(id1)*r2_34(i3,i4).a(
     & 1,jut)
      cy2=p234q*r2_34(i3,i4).b(2,jut)+rmass(id1)*r2_34(i3,i4).a(
     & 2,jut)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).a(iut,jut)=u1_5678(i5,i
     & 6,i7,i8).a(iut,1)*cx1+u1_5678(i5,i6,i7,i8).c(iut,1)*cy1+u
     & 1_5678(i5,i6,i7,i8).a(iut,2)*cx2+u1_5678(i5,i6,i7,i8).c(i
     & ut,2)*cy2
      cline_3forks_12(i5,i6,i7,i8,i3,i4).b(iut,jut)=u1_5678(i5,i
     & 6,i7,i8).b(iut,1)*cx1+u1_5678(i5,i6,i7,i8).d(iut,1)*cy1+u
     & 1_5678(i5,i6,i7,i8).b(iut,2)*cx2+u1_5678(i5,i6,i7,i8).d(i
     & ut,2)*cy2
      cw1=r2_34(i3,i4).c(1,jut)+rmass(id1)*r2_34(i3,i4).d(1,jut)
      cw2=r2_34(i3,i4).c(2,jut)+rmass(id1)*r2_34(i3,i4).d(2,jut)
      cz1=p234q*r2_34(i3,i4).d(1,jut)+rmass(id1)*r2_34(i3,i4).c(
     & 1,jut)
      cz2=p234q*r2_34(i3,i4).d(2,jut)+rmass(id1)*r2_34(i3,i4).c(
     & 2,jut)
      cline_3forks_12(i5,i6,i7,i8,i3,i4).c(iut,jut)=u1_5678(i5,i
     & 6,i7,i8).a(iut,1)*cw1+u1_5678(i5,i6,i7,i8).c(iut,1)*cz1+u
     & 1_5678(i5,i6,i7,i8).a(iut,2)*cw2+u1_5678(i5,i6,i7,i8).c(i
     & ut,2)*cz2
      cline_3forks_12(i5,i6,i7,i8,i3,i4).d(iut,jut)=u1_5678(i5,i
     & 6,i7,i8).b(iut,1)*cw1+u1_5678(i5,i6,i7,i8).d(iut,1)*cz1+u
     & 1_5678(i5,i6,i7,i8).b(iut,2)*cw2+u1_5678(i5,i6,i7,i8).d(i
     & ut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
        	
  
  
      endif	
  
  
      rmassl=rmass(id1)
      rmassr=-rmassl
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
      do i3=1,2
      do i4=1,2
* mline -- res=cres_3forks_12(i5,i6,i7,i8,i3,i4).pol(&1,&2),abcd=cline_3
* forks_12(i5,i6,i7,i8,i3,i4).,m1=rmassl,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cres_3forks_12(i5,i6,i7,i8,i3,i4).pol(iut,jut)=cline_3fork
     & s_12(i5,i6,i7,i8,i3,i4).a(iut,jut)+rmassl*cline_3forks_12
     & (i5,i6,i7,i8,i3,i4).b(iut,jut)+rmassr*cline_3forks_12(i5,
     & i6,i7,i8,i3,i4).c(iut,jut)+rmassl*rmassr*cline_3forks_12(
     & i5,i6,i7,i8,i3,i4).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
      end do
      end do
      end do
  
      do i1=1,2
       do i2=1,2
        do i3=1,2
         do i4=1,2
          do i5=1,2
           do i6=1,2
            do i7=1,2
             do i8=1,2
                        	
            cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &      cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &      cres_3forks_12(i5,i6,i7,i8,i3,i4).pol(i1,i2)
  
             enddo
            enddo		
           enddo
          enddo
         enddo
        enddo	
       enddo
      enddo
  
  
  
  
  
  
  
      if(id3.ne.5)then
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=cline_3forks_34(i1,i2,i5,i6,i7,i8).a,bb=cline_3forks_34(i1,i2
* ,i5,i6,i7,i8).b,cc=cline_3forks_34(i1,i2,i5,i6,i7,i8).c,dd=cline_3fork
* s_34(i1,i2,i5,i6,i7,i8).d,a1=u3_1256(i1,i2,i5,i6).a,b1=u3_1256(i1,i2,i
* 5,i6).b,c1=u3_1256(i1,i2,i5,i6).c,d1=u3_1256(i1,i2,i5,i6).d,a2=r4_78(i
* 7,i8).a,b2=r4_78(i7,i8).b,c2=r4_78(i7,i8).c,d2=r4_78(i7,i8).d,prq=p478
* q,m=rmass(id3),nsum=0
      cline_3forks_34(i1,i2,i5,i6,i7,i8).a(1,1)=u3_1256(i1,i2,i5
     & ,i6).a(1,1)*r4_78(i7,i8).a(1,1)+u3_1256(i1,i2,i5,i6).c(1,
     & 2)*p478q*r4_78(i7,i8).b(2,1)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).b(1,1)=rmass(id3)*(u3_1
     & 256(i1,i2,i5,i6).d(1,1)*r4_78(i7,i8).a(1,1)+u3_1256(i1,i2
     & ,i5,i6).b(1,2)*r4_78(i7,i8).b(2,1))
      cline_3forks_34(i1,i2,i5,i6,i7,i8).c(1,1)=rmass(id3)*(u3_1
     & 256(i1,i2,i5,i6).a(1,1)*r4_78(i7,i8).d(1,1)+u3_1256(i1,i2
     & ,i5,i6).c(1,2)*r4_78(i7,i8).c(2,1))
      cline_3forks_34(i1,i2,i5,i6,i7,i8).d(1,1)=u3_1256(i1,i2,i5
     & ,i6).d(1,1)*p478q*r4_78(i7,i8).d(1,1)+u3_1256(i1,i2,i5,i6
     & ).b(1,2)*r4_78(i7,i8).c(2,1)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).a(1,2)=rmass(id3)*(u3_1
     & 256(i1,i2,i5,i6).a(1,1)*r4_78(i7,i8).b(1,2)+u3_1256(i1,i2
     & ,i5,i6).c(1,2)*r4_78(i7,i8).a(2,2))
      cline_3forks_34(i1,i2,i5,i6,i7,i8).b(1,2)=u3_1256(i1,i2,i5
     & ,i6).d(1,1)*p478q*r4_78(i7,i8).b(1,2)+u3_1256(i1,i2,i5,i6
     & ).b(1,2)*r4_78(i7,i8).a(2,2)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).c(1,2)=u3_1256(i1,i2,i5
     & ,i6).a(1,1)*r4_78(i7,i8).c(1,2)+u3_1256(i1,i2,i5,i6).c(1,
     & 2)*p478q*r4_78(i7,i8).d(2,2)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).d(1,2)=rmass(id3)*(u3_1
     & 256(i1,i2,i5,i6).d(1,1)*r4_78(i7,i8).c(1,2)+u3_1256(i1,i2
     & ,i5,i6).b(1,2)*r4_78(i7,i8).d(2,2))
      cline_3forks_34(i1,i2,i5,i6,i7,i8).a(2,1)=rmass(id3)*(u3_1
     & 256(i1,i2,i5,i6).c(2,1)*r4_78(i7,i8).a(1,1)+u3_1256(i1,i2
     & ,i5,i6).a(2,2)*r4_78(i7,i8).b(2,1))
      cline_3forks_34(i1,i2,i5,i6,i7,i8).b(2,1)=u3_1256(i1,i2,i5
     & ,i6).b(2,1)*r4_78(i7,i8).a(1,1)+u3_1256(i1,i2,i5,i6).d(2,
     & 2)*p478q*r4_78(i7,i8).b(2,1)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).c(2,1)=u3_1256(i1,i2,i5
     & ,i6).c(2,1)*p478q*r4_78(i7,i8).d(1,1)+u3_1256(i1,i2,i5,i6
     & ).a(2,2)*r4_78(i7,i8).c(2,1)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).d(2,1)=rmass(id3)*(u3_1
     & 256(i1,i2,i5,i6).b(2,1)*r4_78(i7,i8).d(1,1)+u3_1256(i1,i2
     & ,i5,i6).d(2,2)*r4_78(i7,i8).c(2,1))
      cline_3forks_34(i1,i2,i5,i6,i7,i8).a(2,2)=u3_1256(i1,i2,i5
     & ,i6).c(2,1)*p478q*r4_78(i7,i8).b(1,2)+u3_1256(i1,i2,i5,i6
     & ).a(2,2)*r4_78(i7,i8).a(2,2)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).b(2,2)=rmass(id3)*(u3_1
     & 256(i1,i2,i5,i6).b(2,1)*r4_78(i7,i8).b(1,2)+u3_1256(i1,i2
     & ,i5,i6).d(2,2)*r4_78(i7,i8).a(2,2))
      cline_3forks_34(i1,i2,i5,i6,i7,i8).c(2,2)=rmass(id3)*(u3_1
     & 256(i1,i2,i5,i6).c(2,1)*r4_78(i7,i8).c(1,2)+u3_1256(i1,i2
     & ,i5,i6).a(2,2)*r4_78(i7,i8).d(2,2))
      cline_3forks_34(i1,i2,i5,i6,i7,i8).d(2,2)=u3_1256(i1,i2,i5
     & ,i6).b(2,1)*r4_78(i7,i8).c(1,2)+u3_1256(i1,i2,i5,i6).d(2,
     & 2)*p478q*r4_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
  
      else
  
         if(id3.eq.5.and.id7.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=cline_3forks_34(i1,i2,i5,i6,i7,i8).a,bb=cline_3forks_34(i1,i
* 2,i5,i6,i7,i8).b,cc=cline_3forks_34(i1,i2,i5,i6,i7,i8).c,dd=cline_3for
* ks_34(i1,i2,i5,i6,i7,i8).d,a1=u3_1256(i1,i2,i5,i6).a,b1=u3_1256(i1,i2,
* i5,i6).b,c1=u3_1256(i1,i2,i5,i6).c,d1=u3_1256(i1,i2,i5,i6).d,a2=r4_78(
* i7,i8).a,b2=r4_78(i7,i8).b,c2=r4_78(i7,i8).c,d2=r4_78(i7,i8).d,prq=p47
* 8q,m=rmass(id3),nsum=0
      do iut=1,2
      cx1=u3_1256(i1,i2,i5,i6).a(iut,1)+u3_1256(i1,i2,i5,i6).c(i
     & ut,1)*rmass(id3)
      cx2=u3_1256(i1,i2,i5,i6).c(iut,2)*p478q+u3_1256(i1,i2,i5,i
     & 6).a(iut,2)*rmass(id3)
      cy1=u3_1256(i1,i2,i5,i6).b(iut,1)+u3_1256(i1,i2,i5,i6).d(i
     & ut,1)*rmass(id3)
      cy2=u3_1256(i1,i2,i5,i6).d(iut,2)*p478q+u3_1256(i1,i2,i5,i
     & 6).b(iut,2)*rmass(id3)
      cw1=u3_1256(i1,i2,i5,i6).c(iut,1)*p478q+u3_1256(i1,i2,i5,i
     & 6).a(iut,1)*rmass(id3)
      cw2=u3_1256(i1,i2,i5,i6).a(iut,2)+u3_1256(i1,i2,i5,i6).c(i
     & ut,2)*rmass(id3)
      cz1=u3_1256(i1,i2,i5,i6).d(iut,1)*p478q+u3_1256(i1,i2,i5,i
     & 6).b(iut,1)*rmass(id3)
      cz2=u3_1256(i1,i2,i5,i6).b(iut,2)+u3_1256(i1,i2,i5,i6).d(i
     & ut,2)*rmass(id3)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).a(iut,1)=cx1*r4_78(i7,i
     & 8).a(1,1)+cx2*r4_78(i7,i8).b(2,1)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).b(iut,1)=cy1*r4_78(i7,i
     & 8).a(1,1)+cy2*r4_78(i7,i8).b(2,1)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).c(iut,1)=cw1*r4_78(i7,i
     & 8).d(1,1)+cw2*r4_78(i7,i8).c(2,1)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).d(iut,1)=cz1*r4_78(i7,i
     & 8).d(1,1)+cz2*r4_78(i7,i8).c(2,1)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).a(iut,2)=cw1*r4_78(i7,i
     & 8).b(1,2)+cw2*r4_78(i7,i8).a(2,2)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).b(iut,2)=cz1*r4_78(i7,i
     & 8).b(1,2)+cz2*r4_78(i7,i8).a(2,2)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).c(iut,2)=cx1*r4_78(i7,i
     & 8).c(1,2)+cx2*r4_78(i7,i8).d(2,2)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).d(iut,2)=cy1*r4_78(i7,i
     & 8).c(1,2)+cy2*r4_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
   	
      else
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=cline_3forks_34(i1,i2,i5,i6,i7,i8).a,bb=cline_3forks_34(i1,
* i2,i5,i6,i7,i8).b,cc=cline_3forks_34(i1,i2,i5,i6,i7,i8).c,dd=cline_3fo
* rks_34(i1,i2,i5,i6,i7,i8).d,a1=u3_1256(i1,i2,i5,i6).a,b1=u3_1256(i1,i2
* ,i5,i6).b,c1=u3_1256(i1,i2,i5,i6).c,d1=u3_1256(i1,i2,i5,i6).d,a2=r4_78
* (i7,i8).a,b2=r4_78(i7,i8).b,c2=r4_78(i7,i8).c,d2=r4_78(i7,i8).d,prq=p4
* 78q,m=rmass(id3),nsum=0
      do iut=1,2
      do jut=1,2
      cx1=r4_78(i7,i8).a(1,jut)+rmass(id3)*r4_78(i7,i8).b(1,jut)
      cx2=r4_78(i7,i8).a(2,jut)+rmass(id3)*r4_78(i7,i8).b(2,jut)
      cy1=p478q*r4_78(i7,i8).b(1,jut)+rmass(id3)*r4_78(i7,i8).a(
     & 1,jut)
      cy2=p478q*r4_78(i7,i8).b(2,jut)+rmass(id3)*r4_78(i7,i8).a(
     & 2,jut)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).a(iut,jut)=u3_1256(i1,i
     & 2,i5,i6).a(iut,1)*cx1+u3_1256(i1,i2,i5,i6).c(iut,1)*cy1+u
     & 3_1256(i1,i2,i5,i6).a(iut,2)*cx2+u3_1256(i1,i2,i5,i6).c(i
     & ut,2)*cy2
      cline_3forks_34(i1,i2,i5,i6,i7,i8).b(iut,jut)=u3_1256(i1,i
     & 2,i5,i6).b(iut,1)*cx1+u3_1256(i1,i2,i5,i6).d(iut,1)*cy1+u
     & 3_1256(i1,i2,i5,i6).b(iut,2)*cx2+u3_1256(i1,i2,i5,i6).d(i
     & ut,2)*cy2
      cw1=r4_78(i7,i8).c(1,jut)+rmass(id3)*r4_78(i7,i8).d(1,jut)
      cw2=r4_78(i7,i8).c(2,jut)+rmass(id3)*r4_78(i7,i8).d(2,jut)
      cz1=p478q*r4_78(i7,i8).d(1,jut)+rmass(id3)*r4_78(i7,i8).c(
     & 1,jut)
      cz2=p478q*r4_78(i7,i8).d(2,jut)+rmass(id3)*r4_78(i7,i8).c(
     & 2,jut)
      cline_3forks_34(i1,i2,i5,i6,i7,i8).c(iut,jut)=u3_1256(i1,i
     & 2,i5,i6).a(iut,1)*cw1+u3_1256(i1,i2,i5,i6).c(iut,1)*cz1+u
     & 3_1256(i1,i2,i5,i6).a(iut,2)*cw2+u3_1256(i1,i2,i5,i6).c(i
     & ut,2)*cz2
      cline_3forks_34(i1,i2,i5,i6,i7,i8).d(iut,jut)=u3_1256(i1,i
     & 2,i5,i6).b(iut,1)*cw1+u3_1256(i1,i2,i5,i6).d(iut,1)*cz1+u
     & 3_1256(i1,i2,i5,i6).b(iut,2)*cw2+u3_1256(i1,i2,i5,i6).d(i
     & ut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
        	
  
  
      endif	
  
  
      rmassl=rmass(id3)
      rmassr=-rmassl
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* mline -- res=cres_3forks_34(i1,i2,i5,i6,i7,i8).pol(&1,&2),abcd=cline_3
* forks_34(i1,i2,i5,i6,i7,i8).,m1=rmassl,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cres_3forks_34(i1,i2,i5,i6,i7,i8).pol(iut,jut)=cline_3fork
     & s_34(i1,i2,i5,i6,i7,i8).a(iut,jut)+rmassl*cline_3forks_34
     & (i1,i2,i5,i6,i7,i8).b(iut,jut)+rmassr*cline_3forks_34(i1,
     & i2,i5,i6,i7,i8).c(iut,jut)+rmassl*rmassr*cline_3forks_34(
     & i1,i2,i5,i6,i7,i8).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
      end do
      end do
      end do
  
      do i1=1,2
       do i2=1,2
        do i3=1,2
         do i4=1,2
          do i5=1,2
           do i6=1,2
            do i7=1,2
             do i8=1,2
                        	
            cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &      cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &      cres_3forks_34(i1,i2,i5,i6,i7,i8).pol(i3,i4)
  
             enddo
            enddo		
           enddo
          enddo
         enddo
        enddo	
       enddo
      enddo
  
  
  
  
  
  
  
      if(id3.ne.5)then
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
      do i1=1,2
      do i2=1,2
* TT -- aa=cline_3forks_34(i5,i6,i7,i8,i1,i2).a,bb=cline_3forks_34(i5,i6
* ,i7,i8,i1,i2).b,cc=cline_3forks_34(i5,i6,i7,i8,i1,i2).c,dd=cline_3fork
* s_34(i5,i6,i7,i8,i1,i2).d,a1=u3_5678(i5,i6,i7,i8).a,b1=u3_5678(i5,i6,i
* 7,i8).b,c1=u3_5678(i5,i6,i7,i8).c,d1=u3_5678(i5,i6,i7,i8).d,a2=r4_12(i
* 1,i2).a,b2=r4_12(i1,i2).b,c2=r4_12(i1,i2).c,d2=r4_12(i1,i2).d,prq=p412
* q,m=rmass(id3),nsum=0
      cline_3forks_34(i5,i6,i7,i8,i1,i2).a(1,1)=u3_5678(i5,i6,i7
     & ,i8).a(1,1)*r4_12(i1,i2).a(1,1)+u3_5678(i5,i6,i7,i8).c(1,
     & 2)*p412q*r4_12(i1,i2).b(2,1)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).b(1,1)=rmass(id3)*(u3_5
     & 678(i5,i6,i7,i8).d(1,1)*r4_12(i1,i2).a(1,1)+u3_5678(i5,i6
     & ,i7,i8).b(1,2)*r4_12(i1,i2).b(2,1))
      cline_3forks_34(i5,i6,i7,i8,i1,i2).c(1,1)=rmass(id3)*(u3_5
     & 678(i5,i6,i7,i8).a(1,1)*r4_12(i1,i2).d(1,1)+u3_5678(i5,i6
     & ,i7,i8).c(1,2)*r4_12(i1,i2).c(2,1))
      cline_3forks_34(i5,i6,i7,i8,i1,i2).d(1,1)=u3_5678(i5,i6,i7
     & ,i8).d(1,1)*p412q*r4_12(i1,i2).d(1,1)+u3_5678(i5,i6,i7,i8
     & ).b(1,2)*r4_12(i1,i2).c(2,1)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).a(1,2)=rmass(id3)*(u3_5
     & 678(i5,i6,i7,i8).a(1,1)*r4_12(i1,i2).b(1,2)+u3_5678(i5,i6
     & ,i7,i8).c(1,2)*r4_12(i1,i2).a(2,2))
      cline_3forks_34(i5,i6,i7,i8,i1,i2).b(1,2)=u3_5678(i5,i6,i7
     & ,i8).d(1,1)*p412q*r4_12(i1,i2).b(1,2)+u3_5678(i5,i6,i7,i8
     & ).b(1,2)*r4_12(i1,i2).a(2,2)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).c(1,2)=u3_5678(i5,i6,i7
     & ,i8).a(1,1)*r4_12(i1,i2).c(1,2)+u3_5678(i5,i6,i7,i8).c(1,
     & 2)*p412q*r4_12(i1,i2).d(2,2)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).d(1,2)=rmass(id3)*(u3_5
     & 678(i5,i6,i7,i8).d(1,1)*r4_12(i1,i2).c(1,2)+u3_5678(i5,i6
     & ,i7,i8).b(1,2)*r4_12(i1,i2).d(2,2))
      cline_3forks_34(i5,i6,i7,i8,i1,i2).a(2,1)=rmass(id3)*(u3_5
     & 678(i5,i6,i7,i8).c(2,1)*r4_12(i1,i2).a(1,1)+u3_5678(i5,i6
     & ,i7,i8).a(2,2)*r4_12(i1,i2).b(2,1))
      cline_3forks_34(i5,i6,i7,i8,i1,i2).b(2,1)=u3_5678(i5,i6,i7
     & ,i8).b(2,1)*r4_12(i1,i2).a(1,1)+u3_5678(i5,i6,i7,i8).d(2,
     & 2)*p412q*r4_12(i1,i2).b(2,1)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).c(2,1)=u3_5678(i5,i6,i7
     & ,i8).c(2,1)*p412q*r4_12(i1,i2).d(1,1)+u3_5678(i5,i6,i7,i8
     & ).a(2,2)*r4_12(i1,i2).c(2,1)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).d(2,1)=rmass(id3)*(u3_5
     & 678(i5,i6,i7,i8).b(2,1)*r4_12(i1,i2).d(1,1)+u3_5678(i5,i6
     & ,i7,i8).d(2,2)*r4_12(i1,i2).c(2,1))
      cline_3forks_34(i5,i6,i7,i8,i1,i2).a(2,2)=u3_5678(i5,i6,i7
     & ,i8).c(2,1)*p412q*r4_12(i1,i2).b(1,2)+u3_5678(i5,i6,i7,i8
     & ).a(2,2)*r4_12(i1,i2).a(2,2)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).b(2,2)=rmass(id3)*(u3_5
     & 678(i5,i6,i7,i8).b(2,1)*r4_12(i1,i2).b(1,2)+u3_5678(i5,i6
     & ,i7,i8).d(2,2)*r4_12(i1,i2).a(2,2))
      cline_3forks_34(i5,i6,i7,i8,i1,i2).c(2,2)=rmass(id3)*(u3_5
     & 678(i5,i6,i7,i8).c(2,1)*r4_12(i1,i2).c(1,2)+u3_5678(i5,i6
     & ,i7,i8).a(2,2)*r4_12(i1,i2).d(2,2))
      cline_3forks_34(i5,i6,i7,i8,i1,i2).d(2,2)=u3_5678(i5,i6,i7
     & ,i8).b(2,1)*r4_12(i1,i2).c(1,2)+u3_5678(i5,i6,i7,i8).d(2,
     & 2)*p412q*r4_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
  
      else
  
         if(id3.eq.5.and.id1.ne.5)then
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
      do i1=1,2
      do i2=1,2
* TsT -- aa=cline_3forks_34(i5,i6,i7,i8,i1,i2).a,bb=cline_3forks_34(i5,i
* 6,i7,i8,i1,i2).b,cc=cline_3forks_34(i5,i6,i7,i8,i1,i2).c,dd=cline_3for
* ks_34(i5,i6,i7,i8,i1,i2).d,a1=u3_5678(i5,i6,i7,i8).a,b1=u3_5678(i5,i6,
* i7,i8).b,c1=u3_5678(i5,i6,i7,i8).c,d1=u3_5678(i5,i6,i7,i8).d,a2=r4_12(
* i1,i2).a,b2=r4_12(i1,i2).b,c2=r4_12(i1,i2).c,d2=r4_12(i1,i2).d,prq=p41
* 2q,m=rmass(id3),nsum=0
      do iut=1,2
      cx1=u3_5678(i5,i6,i7,i8).a(iut,1)+u3_5678(i5,i6,i7,i8).c(i
     & ut,1)*rmass(id3)
      cx2=u3_5678(i5,i6,i7,i8).c(iut,2)*p412q+u3_5678(i5,i6,i7,i
     & 8).a(iut,2)*rmass(id3)
      cy1=u3_5678(i5,i6,i7,i8).b(iut,1)+u3_5678(i5,i6,i7,i8).d(i
     & ut,1)*rmass(id3)
      cy2=u3_5678(i5,i6,i7,i8).d(iut,2)*p412q+u3_5678(i5,i6,i7,i
     & 8).b(iut,2)*rmass(id3)
      cw1=u3_5678(i5,i6,i7,i8).c(iut,1)*p412q+u3_5678(i5,i6,i7,i
     & 8).a(iut,1)*rmass(id3)
      cw2=u3_5678(i5,i6,i7,i8).a(iut,2)+u3_5678(i5,i6,i7,i8).c(i
     & ut,2)*rmass(id3)
      cz1=u3_5678(i5,i6,i7,i8).d(iut,1)*p412q+u3_5678(i5,i6,i7,i
     & 8).b(iut,1)*rmass(id3)
      cz2=u3_5678(i5,i6,i7,i8).b(iut,2)+u3_5678(i5,i6,i7,i8).d(i
     & ut,2)*rmass(id3)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).a(iut,1)=cx1*r4_12(i1,i
     & 2).a(1,1)+cx2*r4_12(i1,i2).b(2,1)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).b(iut,1)=cy1*r4_12(i1,i
     & 2).a(1,1)+cy2*r4_12(i1,i2).b(2,1)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).c(iut,1)=cw1*r4_12(i1,i
     & 2).d(1,1)+cw2*r4_12(i1,i2).c(2,1)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).d(iut,1)=cz1*r4_12(i1,i
     & 2).d(1,1)+cz2*r4_12(i1,i2).c(2,1)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).a(iut,2)=cw1*r4_12(i1,i
     & 2).b(1,2)+cw2*r4_12(i1,i2).a(2,2)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).b(iut,2)=cz1*r4_12(i1,i
     & 2).b(1,2)+cz2*r4_12(i1,i2).a(2,2)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).c(iut,2)=cx1*r4_12(i1,i
     & 2).c(1,2)+cx2*r4_12(i1,i2).d(2,2)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).d(iut,2)=cy1*r4_12(i1,i
     & 2).c(1,2)+cy2*r4_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
   	
      else
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
      do i1=1,2
      do i2=1,2
* TsTs -- aa=cline_3forks_34(i5,i6,i7,i8,i1,i2).a,bb=cline_3forks_34(i5,
* i6,i7,i8,i1,i2).b,cc=cline_3forks_34(i5,i6,i7,i8,i1,i2).c,dd=cline_3fo
* rks_34(i5,i6,i7,i8,i1,i2).d,a1=u3_5678(i5,i6,i7,i8).a,b1=u3_5678(i5,i6
* ,i7,i8).b,c1=u3_5678(i5,i6,i7,i8).c,d1=u3_5678(i5,i6,i7,i8).d,a2=r4_12
* (i1,i2).a,b2=r4_12(i1,i2).b,c2=r4_12(i1,i2).c,d2=r4_12(i1,i2).d,prq=p4
* 12q,m=rmass(id3),nsum=0
      do iut=1,2
      do jut=1,2
      cx1=r4_12(i1,i2).a(1,jut)+rmass(id3)*r4_12(i1,i2).b(1,jut)
      cx2=r4_12(i1,i2).a(2,jut)+rmass(id3)*r4_12(i1,i2).b(2,jut)
      cy1=p412q*r4_12(i1,i2).b(1,jut)+rmass(id3)*r4_12(i1,i2).a(
     & 1,jut)
      cy2=p412q*r4_12(i1,i2).b(2,jut)+rmass(id3)*r4_12(i1,i2).a(
     & 2,jut)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).a(iut,jut)=u3_5678(i5,i
     & 6,i7,i8).a(iut,1)*cx1+u3_5678(i5,i6,i7,i8).c(iut,1)*cy1+u
     & 3_5678(i5,i6,i7,i8).a(iut,2)*cx2+u3_5678(i5,i6,i7,i8).c(i
     & ut,2)*cy2
      cline_3forks_34(i5,i6,i7,i8,i1,i2).b(iut,jut)=u3_5678(i5,i
     & 6,i7,i8).b(iut,1)*cx1+u3_5678(i5,i6,i7,i8).d(iut,1)*cy1+u
     & 3_5678(i5,i6,i7,i8).b(iut,2)*cx2+u3_5678(i5,i6,i7,i8).d(i
     & ut,2)*cy2
      cw1=r4_12(i1,i2).c(1,jut)+rmass(id3)*r4_12(i1,i2).d(1,jut)
      cw2=r4_12(i1,i2).c(2,jut)+rmass(id3)*r4_12(i1,i2).d(2,jut)
      cz1=p412q*r4_12(i1,i2).d(1,jut)+rmass(id3)*r4_12(i1,i2).c(
     & 1,jut)
      cz2=p412q*r4_12(i1,i2).d(2,jut)+rmass(id3)*r4_12(i1,i2).c(
     & 2,jut)
      cline_3forks_34(i5,i6,i7,i8,i1,i2).c(iut,jut)=u3_5678(i5,i
     & 6,i7,i8).a(iut,1)*cw1+u3_5678(i5,i6,i7,i8).c(iut,1)*cz1+u
     & 3_5678(i5,i6,i7,i8).a(iut,2)*cw2+u3_5678(i5,i6,i7,i8).c(i
     & ut,2)*cz2
      cline_3forks_34(i5,i6,i7,i8,i1,i2).d(iut,jut)=u3_5678(i5,i
     & 6,i7,i8).b(iut,1)*cw1+u3_5678(i5,i6,i7,i8).d(iut,1)*cz1+u
     & 3_5678(i5,i6,i7,i8).b(iut,2)*cw2+u3_5678(i5,i6,i7,i8).d(i
     & ut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
        	
  
  
      endif	
  
  
      rmassl=rmass(id3)
      rmassr=-rmassl
  
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
      do i1=1,2
      do i2=1,2
* mline -- res=cres_3forks_34(i5,i6,i7,i8,i1,i2).pol(&1,&2),abcd=cline_3
* forks_34(i5,i6,i7,i8,i1,i2).,m1=rmassl,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cres_3forks_34(i5,i6,i7,i8,i1,i2).pol(iut,jut)=cline_3fork
     & s_34(i5,i6,i7,i8,i1,i2).a(iut,jut)+rmassl*cline_3forks_34
     & (i5,i6,i7,i8,i1,i2).b(iut,jut)+rmassr*cline_3forks_34(i5,
     & i6,i7,i8,i1,i2).c(iut,jut)+rmassl*rmassr*cline_3forks_34(
     & i5,i6,i7,i8,i1,i2).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
      end do
      end do
      end do
  
      do i1=1,2
       do i2=1,2
        do i3=1,2
         do i4=1,2
          do i5=1,2
           do i6=1,2
            do i7=1,2
             do i8=1,2
                        	
            cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &      cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &      cres_3forks_34(i5,i6,i7,i8,i1,i2).pol(i3,i4)
  
             enddo
            enddo		
           enddo
          enddo
         enddo
        enddo	
       enddo
      enddo
  
  
  
  
  
  
  
      if(id3.ne.5)then
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
      do i5=1,2
      do i6=1,2
* TT -- aa=cline_3forks_34(i1,i2,i7,i8,i5,i6).a,bb=cline_3forks_34(i1,i2
* ,i7,i8,i5,i6).b,cc=cline_3forks_34(i1,i2,i7,i8,i5,i6).c,dd=cline_3fork
* s_34(i1,i2,i7,i8,i5,i6).d,a1=u3_1278(i1,i2,i7,i8).a,b1=u3_1278(i1,i2,i
* 7,i8).b,c1=u3_1278(i1,i2,i7,i8).c,d1=u3_1278(i1,i2,i7,i8).d,a2=r4_56(i
* 5,i6).a,b2=r4_56(i5,i6).b,c2=r4_56(i5,i6).c,d2=r4_56(i5,i6).d,prq=p456
* q,m=rmass(id3),nsum=0
      cline_3forks_34(i1,i2,i7,i8,i5,i6).a(1,1)=u3_1278(i1,i2,i7
     & ,i8).a(1,1)*r4_56(i5,i6).a(1,1)+u3_1278(i1,i2,i7,i8).c(1,
     & 2)*p456q*r4_56(i5,i6).b(2,1)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).b(1,1)=rmass(id3)*(u3_1
     & 278(i1,i2,i7,i8).d(1,1)*r4_56(i5,i6).a(1,1)+u3_1278(i1,i2
     & ,i7,i8).b(1,2)*r4_56(i5,i6).b(2,1))
      cline_3forks_34(i1,i2,i7,i8,i5,i6).c(1,1)=rmass(id3)*(u3_1
     & 278(i1,i2,i7,i8).a(1,1)*r4_56(i5,i6).d(1,1)+u3_1278(i1,i2
     & ,i7,i8).c(1,2)*r4_56(i5,i6).c(2,1))
      cline_3forks_34(i1,i2,i7,i8,i5,i6).d(1,1)=u3_1278(i1,i2,i7
     & ,i8).d(1,1)*p456q*r4_56(i5,i6).d(1,1)+u3_1278(i1,i2,i7,i8
     & ).b(1,2)*r4_56(i5,i6).c(2,1)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).a(1,2)=rmass(id3)*(u3_1
     & 278(i1,i2,i7,i8).a(1,1)*r4_56(i5,i6).b(1,2)+u3_1278(i1,i2
     & ,i7,i8).c(1,2)*r4_56(i5,i6).a(2,2))
      cline_3forks_34(i1,i2,i7,i8,i5,i6).b(1,2)=u3_1278(i1,i2,i7
     & ,i8).d(1,1)*p456q*r4_56(i5,i6).b(1,2)+u3_1278(i1,i2,i7,i8
     & ).b(1,2)*r4_56(i5,i6).a(2,2)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).c(1,2)=u3_1278(i1,i2,i7
     & ,i8).a(1,1)*r4_56(i5,i6).c(1,2)+u3_1278(i1,i2,i7,i8).c(1,
     & 2)*p456q*r4_56(i5,i6).d(2,2)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).d(1,2)=rmass(id3)*(u3_1
     & 278(i1,i2,i7,i8).d(1,1)*r4_56(i5,i6).c(1,2)+u3_1278(i1,i2
     & ,i7,i8).b(1,2)*r4_56(i5,i6).d(2,2))
      cline_3forks_34(i1,i2,i7,i8,i5,i6).a(2,1)=rmass(id3)*(u3_1
     & 278(i1,i2,i7,i8).c(2,1)*r4_56(i5,i6).a(1,1)+u3_1278(i1,i2
     & ,i7,i8).a(2,2)*r4_56(i5,i6).b(2,1))
      cline_3forks_34(i1,i2,i7,i8,i5,i6).b(2,1)=u3_1278(i1,i2,i7
     & ,i8).b(2,1)*r4_56(i5,i6).a(1,1)+u3_1278(i1,i2,i7,i8).d(2,
     & 2)*p456q*r4_56(i5,i6).b(2,1)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).c(2,1)=u3_1278(i1,i2,i7
     & ,i8).c(2,1)*p456q*r4_56(i5,i6).d(1,1)+u3_1278(i1,i2,i7,i8
     & ).a(2,2)*r4_56(i5,i6).c(2,1)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).d(2,1)=rmass(id3)*(u3_1
     & 278(i1,i2,i7,i8).b(2,1)*r4_56(i5,i6).d(1,1)+u3_1278(i1,i2
     & ,i7,i8).d(2,2)*r4_56(i5,i6).c(2,1))
      cline_3forks_34(i1,i2,i7,i8,i5,i6).a(2,2)=u3_1278(i1,i2,i7
     & ,i8).c(2,1)*p456q*r4_56(i5,i6).b(1,2)+u3_1278(i1,i2,i7,i8
     & ).a(2,2)*r4_56(i5,i6).a(2,2)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).b(2,2)=rmass(id3)*(u3_1
     & 278(i1,i2,i7,i8).b(2,1)*r4_56(i5,i6).b(1,2)+u3_1278(i1,i2
     & ,i7,i8).d(2,2)*r4_56(i5,i6).a(2,2))
      cline_3forks_34(i1,i2,i7,i8,i5,i6).c(2,2)=rmass(id3)*(u3_1
     & 278(i1,i2,i7,i8).c(2,1)*r4_56(i5,i6).c(1,2)+u3_1278(i1,i2
     & ,i7,i8).a(2,2)*r4_56(i5,i6).d(2,2))
      cline_3forks_34(i1,i2,i7,i8,i5,i6).d(2,2)=u3_1278(i1,i2,i7
     & ,i8).b(2,1)*r4_56(i5,i6).c(1,2)+u3_1278(i1,i2,i7,i8).d(2,
     & 2)*p456q*r4_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
  
      else
  
         if(id3.eq.5.and.id5.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
      do i5=1,2
      do i6=1,2
* TsT -- aa=cline_3forks_34(i1,i2,i7,i8,i5,i6).a,bb=cline_3forks_34(i1,i
* 2,i7,i8,i5,i6).b,cc=cline_3forks_34(i1,i2,i7,i8,i5,i6).c,dd=cline_3for
* ks_34(i1,i2,i7,i8,i5,i6).d,a1=u3_1278(i1,i2,i7,i8).a,b1=u3_1278(i1,i2,
* i7,i8).b,c1=u3_1278(i1,i2,i7,i8).c,d1=u3_1278(i1,i2,i7,i8).d,a2=r4_56(
* i5,i6).a,b2=r4_56(i5,i6).b,c2=r4_56(i5,i6).c,d2=r4_56(i5,i6).d,prq=p45
* 6q,m=rmass(id3),nsum=0
      do iut=1,2
      cx1=u3_1278(i1,i2,i7,i8).a(iut,1)+u3_1278(i1,i2,i7,i8).c(i
     & ut,1)*rmass(id3)
      cx2=u3_1278(i1,i2,i7,i8).c(iut,2)*p456q+u3_1278(i1,i2,i7,i
     & 8).a(iut,2)*rmass(id3)
      cy1=u3_1278(i1,i2,i7,i8).b(iut,1)+u3_1278(i1,i2,i7,i8).d(i
     & ut,1)*rmass(id3)
      cy2=u3_1278(i1,i2,i7,i8).d(iut,2)*p456q+u3_1278(i1,i2,i7,i
     & 8).b(iut,2)*rmass(id3)
      cw1=u3_1278(i1,i2,i7,i8).c(iut,1)*p456q+u3_1278(i1,i2,i7,i
     & 8).a(iut,1)*rmass(id3)
      cw2=u3_1278(i1,i2,i7,i8).a(iut,2)+u3_1278(i1,i2,i7,i8).c(i
     & ut,2)*rmass(id3)
      cz1=u3_1278(i1,i2,i7,i8).d(iut,1)*p456q+u3_1278(i1,i2,i7,i
     & 8).b(iut,1)*rmass(id3)
      cz2=u3_1278(i1,i2,i7,i8).b(iut,2)+u3_1278(i1,i2,i7,i8).d(i
     & ut,2)*rmass(id3)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).a(iut,1)=cx1*r4_56(i5,i
     & 6).a(1,1)+cx2*r4_56(i5,i6).b(2,1)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).b(iut,1)=cy1*r4_56(i5,i
     & 6).a(1,1)+cy2*r4_56(i5,i6).b(2,1)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).c(iut,1)=cw1*r4_56(i5,i
     & 6).d(1,1)+cw2*r4_56(i5,i6).c(2,1)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).d(iut,1)=cz1*r4_56(i5,i
     & 6).d(1,1)+cz2*r4_56(i5,i6).c(2,1)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).a(iut,2)=cw1*r4_56(i5,i
     & 6).b(1,2)+cw2*r4_56(i5,i6).a(2,2)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).b(iut,2)=cz1*r4_56(i5,i
     & 6).b(1,2)+cz2*r4_56(i5,i6).a(2,2)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).c(iut,2)=cx1*r4_56(i5,i
     & 6).c(1,2)+cx2*r4_56(i5,i6).d(2,2)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).d(iut,2)=cy1*r4_56(i5,i
     & 6).c(1,2)+cy2*r4_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
   	
      else
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
      do i5=1,2
      do i6=1,2
* TsTs -- aa=cline_3forks_34(i1,i2,i7,i8,i5,i6).a,bb=cline_3forks_34(i1,
* i2,i7,i8,i5,i6).b,cc=cline_3forks_34(i1,i2,i7,i8,i5,i6).c,dd=cline_3fo
* rks_34(i1,i2,i7,i8,i5,i6).d,a1=u3_1278(i1,i2,i7,i8).a,b1=u3_1278(i1,i2
* ,i7,i8).b,c1=u3_1278(i1,i2,i7,i8).c,d1=u3_1278(i1,i2,i7,i8).d,a2=r4_56
* (i5,i6).a,b2=r4_56(i5,i6).b,c2=r4_56(i5,i6).c,d2=r4_56(i5,i6).d,prq=p4
* 56q,m=rmass(id3),nsum=0
      do iut=1,2
      do jut=1,2
      cx1=r4_56(i5,i6).a(1,jut)+rmass(id3)*r4_56(i5,i6).b(1,jut)
      cx2=r4_56(i5,i6).a(2,jut)+rmass(id3)*r4_56(i5,i6).b(2,jut)
      cy1=p456q*r4_56(i5,i6).b(1,jut)+rmass(id3)*r4_56(i5,i6).a(
     & 1,jut)
      cy2=p456q*r4_56(i5,i6).b(2,jut)+rmass(id3)*r4_56(i5,i6).a(
     & 2,jut)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).a(iut,jut)=u3_1278(i1,i
     & 2,i7,i8).a(iut,1)*cx1+u3_1278(i1,i2,i7,i8).c(iut,1)*cy1+u
     & 3_1278(i1,i2,i7,i8).a(iut,2)*cx2+u3_1278(i1,i2,i7,i8).c(i
     & ut,2)*cy2
      cline_3forks_34(i1,i2,i7,i8,i5,i6).b(iut,jut)=u3_1278(i1,i
     & 2,i7,i8).b(iut,1)*cx1+u3_1278(i1,i2,i7,i8).d(iut,1)*cy1+u
     & 3_1278(i1,i2,i7,i8).b(iut,2)*cx2+u3_1278(i1,i2,i7,i8).d(i
     & ut,2)*cy2
      cw1=r4_56(i5,i6).c(1,jut)+rmass(id3)*r4_56(i5,i6).d(1,jut)
      cw2=r4_56(i5,i6).c(2,jut)+rmass(id3)*r4_56(i5,i6).d(2,jut)
      cz1=p456q*r4_56(i5,i6).d(1,jut)+rmass(id3)*r4_56(i5,i6).c(
     & 1,jut)
      cz2=p456q*r4_56(i5,i6).d(2,jut)+rmass(id3)*r4_56(i5,i6).c(
     & 2,jut)
      cline_3forks_34(i1,i2,i7,i8,i5,i6).c(iut,jut)=u3_1278(i1,i
     & 2,i7,i8).a(iut,1)*cw1+u3_1278(i1,i2,i7,i8).c(iut,1)*cz1+u
     & 3_1278(i1,i2,i7,i8).a(iut,2)*cw2+u3_1278(i1,i2,i7,i8).c(i
     & ut,2)*cz2
      cline_3forks_34(i1,i2,i7,i8,i5,i6).d(iut,jut)=u3_1278(i1,i
     & 2,i7,i8).b(iut,1)*cw1+u3_1278(i1,i2,i7,i8).d(iut,1)*cz1+u
     & 3_1278(i1,i2,i7,i8).b(iut,2)*cw2+u3_1278(i1,i2,i7,i8).d(i
     & ut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
        	
  
  
      endif	
  
  
      rmassl=rmass(id3)
      rmassr=-rmassl
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
      do i5=1,2
      do i6=1,2
* mline -- res=cres_3forks_34(i1,i2,i7,i8,i5,i6).pol(&1,&2),abcd=cline_3
* forks_34(i1,i2,i7,i8,i5,i6).,m1=rmassl,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cres_3forks_34(i1,i2,i7,i8,i5,i6).pol(iut,jut)=cline_3fork
     & s_34(i1,i2,i7,i8,i5,i6).a(iut,jut)+rmassl*cline_3forks_34
     & (i1,i2,i7,i8,i5,i6).b(iut,jut)+rmassr*cline_3forks_34(i1,
     & i2,i7,i8,i5,i6).c(iut,jut)+rmassl*rmassr*cline_3forks_34(
     & i1,i2,i7,i8,i5,i6).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
      end do
      end do
      end do
  
      do i1=1,2
       do i2=1,2
        do i3=1,2
         do i4=1,2
          do i5=1,2
           do i6=1,2
            do i7=1,2
             do i8=1,2
                        	
            cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &      cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &      cres_3forks_34(i1,i2,i7,i8,i5,i6).pol(i3,i4)
  
             enddo
            enddo		
           enddo
          enddo
         enddo
        enddo	
       enddo
      enddo
  
  
  
  
  
  
  
      if(id5.ne.5)then
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TT -- aa=cline_3forks_56(i1,i2,i3,i4,i7,i8).a,bb=cline_3forks_56(i1,i2
* ,i3,i4,i7,i8).b,cc=cline_3forks_56(i1,i2,i3,i4,i7,i8).c,dd=cline_3fork
* s_56(i1,i2,i3,i4,i7,i8).d,a1=u5_1234(i1,i2,i3,i4).a,b1=u5_1234(i1,i2,i
* 3,i4).b,c1=u5_1234(i1,i2,i3,i4).c,d1=u5_1234(i1,i2,i3,i4).d,a2=r6_78(i
* 7,i8).a,b2=r6_78(i7,i8).b,c2=r6_78(i7,i8).c,d2=r6_78(i7,i8).d,prq=p678
* q,m=rmass(id5),nsum=0
      cline_3forks_56(i1,i2,i3,i4,i7,i8).a(1,1)=u5_1234(i1,i2,i3
     & ,i4).a(1,1)*r6_78(i7,i8).a(1,1)+u5_1234(i1,i2,i3,i4).c(1,
     & 2)*p678q*r6_78(i7,i8).b(2,1)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).b(1,1)=rmass(id5)*(u5_1
     & 234(i1,i2,i3,i4).d(1,1)*r6_78(i7,i8).a(1,1)+u5_1234(i1,i2
     & ,i3,i4).b(1,2)*r6_78(i7,i8).b(2,1))
      cline_3forks_56(i1,i2,i3,i4,i7,i8).c(1,1)=rmass(id5)*(u5_1
     & 234(i1,i2,i3,i4).a(1,1)*r6_78(i7,i8).d(1,1)+u5_1234(i1,i2
     & ,i3,i4).c(1,2)*r6_78(i7,i8).c(2,1))
      cline_3forks_56(i1,i2,i3,i4,i7,i8).d(1,1)=u5_1234(i1,i2,i3
     & ,i4).d(1,1)*p678q*r6_78(i7,i8).d(1,1)+u5_1234(i1,i2,i3,i4
     & ).b(1,2)*r6_78(i7,i8).c(2,1)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).a(1,2)=rmass(id5)*(u5_1
     & 234(i1,i2,i3,i4).a(1,1)*r6_78(i7,i8).b(1,2)+u5_1234(i1,i2
     & ,i3,i4).c(1,2)*r6_78(i7,i8).a(2,2))
      cline_3forks_56(i1,i2,i3,i4,i7,i8).b(1,2)=u5_1234(i1,i2,i3
     & ,i4).d(1,1)*p678q*r6_78(i7,i8).b(1,2)+u5_1234(i1,i2,i3,i4
     & ).b(1,2)*r6_78(i7,i8).a(2,2)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).c(1,2)=u5_1234(i1,i2,i3
     & ,i4).a(1,1)*r6_78(i7,i8).c(1,2)+u5_1234(i1,i2,i3,i4).c(1,
     & 2)*p678q*r6_78(i7,i8).d(2,2)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).d(1,2)=rmass(id5)*(u5_1
     & 234(i1,i2,i3,i4).d(1,1)*r6_78(i7,i8).c(1,2)+u5_1234(i1,i2
     & ,i3,i4).b(1,2)*r6_78(i7,i8).d(2,2))
      cline_3forks_56(i1,i2,i3,i4,i7,i8).a(2,1)=rmass(id5)*(u5_1
     & 234(i1,i2,i3,i4).c(2,1)*r6_78(i7,i8).a(1,1)+u5_1234(i1,i2
     & ,i3,i4).a(2,2)*r6_78(i7,i8).b(2,1))
      cline_3forks_56(i1,i2,i3,i4,i7,i8).b(2,1)=u5_1234(i1,i2,i3
     & ,i4).b(2,1)*r6_78(i7,i8).a(1,1)+u5_1234(i1,i2,i3,i4).d(2,
     & 2)*p678q*r6_78(i7,i8).b(2,1)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).c(2,1)=u5_1234(i1,i2,i3
     & ,i4).c(2,1)*p678q*r6_78(i7,i8).d(1,1)+u5_1234(i1,i2,i3,i4
     & ).a(2,2)*r6_78(i7,i8).c(2,1)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).d(2,1)=rmass(id5)*(u5_1
     & 234(i1,i2,i3,i4).b(2,1)*r6_78(i7,i8).d(1,1)+u5_1234(i1,i2
     & ,i3,i4).d(2,2)*r6_78(i7,i8).c(2,1))
      cline_3forks_56(i1,i2,i3,i4,i7,i8).a(2,2)=u5_1234(i1,i2,i3
     & ,i4).c(2,1)*p678q*r6_78(i7,i8).b(1,2)+u5_1234(i1,i2,i3,i4
     & ).a(2,2)*r6_78(i7,i8).a(2,2)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).b(2,2)=rmass(id5)*(u5_1
     & 234(i1,i2,i3,i4).b(2,1)*r6_78(i7,i8).b(1,2)+u5_1234(i1,i2
     & ,i3,i4).d(2,2)*r6_78(i7,i8).a(2,2))
      cline_3forks_56(i1,i2,i3,i4,i7,i8).c(2,2)=rmass(id5)*(u5_1
     & 234(i1,i2,i3,i4).c(2,1)*r6_78(i7,i8).c(1,2)+u5_1234(i1,i2
     & ,i3,i4).a(2,2)*r6_78(i7,i8).d(2,2))
      cline_3forks_56(i1,i2,i3,i4,i7,i8).d(2,2)=u5_1234(i1,i2,i3
     & ,i4).b(2,1)*r6_78(i7,i8).c(1,2)+u5_1234(i1,i2,i3,i4).d(2,
     & 2)*p678q*r6_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
  
      else
  
         if(id5.eq.5.and.id7.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TsT -- aa=cline_3forks_56(i1,i2,i3,i4,i7,i8).a,bb=cline_3forks_56(i1,i
* 2,i3,i4,i7,i8).b,cc=cline_3forks_56(i1,i2,i3,i4,i7,i8).c,dd=cline_3for
* ks_56(i1,i2,i3,i4,i7,i8).d,a1=u5_1234(i1,i2,i3,i4).a,b1=u5_1234(i1,i2,
* i3,i4).b,c1=u5_1234(i1,i2,i3,i4).c,d1=u5_1234(i1,i2,i3,i4).d,a2=r6_78(
* i7,i8).a,b2=r6_78(i7,i8).b,c2=r6_78(i7,i8).c,d2=r6_78(i7,i8).d,prq=p67
* 8q,m=rmass(id5),nsum=0
      do iut=1,2
      cx1=u5_1234(i1,i2,i3,i4).a(iut,1)+u5_1234(i1,i2,i3,i4).c(i
     & ut,1)*rmass(id5)
      cx2=u5_1234(i1,i2,i3,i4).c(iut,2)*p678q+u5_1234(i1,i2,i3,i
     & 4).a(iut,2)*rmass(id5)
      cy1=u5_1234(i1,i2,i3,i4).b(iut,1)+u5_1234(i1,i2,i3,i4).d(i
     & ut,1)*rmass(id5)
      cy2=u5_1234(i1,i2,i3,i4).d(iut,2)*p678q+u5_1234(i1,i2,i3,i
     & 4).b(iut,2)*rmass(id5)
      cw1=u5_1234(i1,i2,i3,i4).c(iut,1)*p678q+u5_1234(i1,i2,i3,i
     & 4).a(iut,1)*rmass(id5)
      cw2=u5_1234(i1,i2,i3,i4).a(iut,2)+u5_1234(i1,i2,i3,i4).c(i
     & ut,2)*rmass(id5)
      cz1=u5_1234(i1,i2,i3,i4).d(iut,1)*p678q+u5_1234(i1,i2,i3,i
     & 4).b(iut,1)*rmass(id5)
      cz2=u5_1234(i1,i2,i3,i4).b(iut,2)+u5_1234(i1,i2,i3,i4).d(i
     & ut,2)*rmass(id5)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).a(iut,1)=cx1*r6_78(i7,i
     & 8).a(1,1)+cx2*r6_78(i7,i8).b(2,1)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).b(iut,1)=cy1*r6_78(i7,i
     & 8).a(1,1)+cy2*r6_78(i7,i8).b(2,1)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).c(iut,1)=cw1*r6_78(i7,i
     & 8).d(1,1)+cw2*r6_78(i7,i8).c(2,1)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).d(iut,1)=cz1*r6_78(i7,i
     & 8).d(1,1)+cz2*r6_78(i7,i8).c(2,1)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).a(iut,2)=cw1*r6_78(i7,i
     & 8).b(1,2)+cw2*r6_78(i7,i8).a(2,2)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).b(iut,2)=cz1*r6_78(i7,i
     & 8).b(1,2)+cz2*r6_78(i7,i8).a(2,2)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).c(iut,2)=cx1*r6_78(i7,i
     & 8).c(1,2)+cx2*r6_78(i7,i8).d(2,2)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).d(iut,2)=cy1*r6_78(i7,i
     & 8).c(1,2)+cy2*r6_78(i7,i8).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
   	
      else
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* TsTs -- aa=cline_3forks_56(i1,i2,i3,i4,i7,i8).a,bb=cline_3forks_56(i1,
* i2,i3,i4,i7,i8).b,cc=cline_3forks_56(i1,i2,i3,i4,i7,i8).c,dd=cline_3fo
* rks_56(i1,i2,i3,i4,i7,i8).d,a1=u5_1234(i1,i2,i3,i4).a,b1=u5_1234(i1,i2
* ,i3,i4).b,c1=u5_1234(i1,i2,i3,i4).c,d1=u5_1234(i1,i2,i3,i4).d,a2=r6_78
* (i7,i8).a,b2=r6_78(i7,i8).b,c2=r6_78(i7,i8).c,d2=r6_78(i7,i8).d,prq=p6
* 78q,m=rmass(id5),nsum=0
      do iut=1,2
      do jut=1,2
      cx1=r6_78(i7,i8).a(1,jut)+rmass(id5)*r6_78(i7,i8).b(1,jut)
      cx2=r6_78(i7,i8).a(2,jut)+rmass(id5)*r6_78(i7,i8).b(2,jut)
      cy1=p678q*r6_78(i7,i8).b(1,jut)+rmass(id5)*r6_78(i7,i8).a(
     & 1,jut)
      cy2=p678q*r6_78(i7,i8).b(2,jut)+rmass(id5)*r6_78(i7,i8).a(
     & 2,jut)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).a(iut,jut)=u5_1234(i1,i
     & 2,i3,i4).a(iut,1)*cx1+u5_1234(i1,i2,i3,i4).c(iut,1)*cy1+u
     & 5_1234(i1,i2,i3,i4).a(iut,2)*cx2+u5_1234(i1,i2,i3,i4).c(i
     & ut,2)*cy2
      cline_3forks_56(i1,i2,i3,i4,i7,i8).b(iut,jut)=u5_1234(i1,i
     & 2,i3,i4).b(iut,1)*cx1+u5_1234(i1,i2,i3,i4).d(iut,1)*cy1+u
     & 5_1234(i1,i2,i3,i4).b(iut,2)*cx2+u5_1234(i1,i2,i3,i4).d(i
     & ut,2)*cy2
      cw1=r6_78(i7,i8).c(1,jut)+rmass(id5)*r6_78(i7,i8).d(1,jut)
      cw2=r6_78(i7,i8).c(2,jut)+rmass(id5)*r6_78(i7,i8).d(2,jut)
      cz1=p678q*r6_78(i7,i8).d(1,jut)+rmass(id5)*r6_78(i7,i8).c(
     & 1,jut)
      cz2=p678q*r6_78(i7,i8).d(2,jut)+rmass(id5)*r6_78(i7,i8).c(
     & 2,jut)
      cline_3forks_56(i1,i2,i3,i4,i7,i8).c(iut,jut)=u5_1234(i1,i
     & 2,i3,i4).a(iut,1)*cw1+u5_1234(i1,i2,i3,i4).c(iut,1)*cz1+u
     & 5_1234(i1,i2,i3,i4).a(iut,2)*cw2+u5_1234(i1,i2,i3,i4).c(i
     & ut,2)*cz2
      cline_3forks_56(i1,i2,i3,i4,i7,i8).d(iut,jut)=u5_1234(i1,i
     & 2,i3,i4).b(iut,1)*cw1+u5_1234(i1,i2,i3,i4).d(iut,1)*cz1+u
     & 5_1234(i1,i2,i3,i4).b(iut,2)*cw2+u5_1234(i1,i2,i3,i4).d(i
     & ut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
        	
  
  
      endif	
  
  
      rmassl=rmass(id5)
      rmassr=-rmassl
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
* mline -- res=cres_3forks_56(i1,i2,i3,i4,i7,i8).pol(&1,&2),abcd=cline_3
* forks_56(i1,i2,i3,i4,i7,i8).,m1=rmassl,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cres_3forks_56(i1,i2,i3,i4,i7,i8).pol(iut,jut)=cline_3fork
     & s_56(i1,i2,i3,i4,i7,i8).a(iut,jut)+rmassl*cline_3forks_56
     & (i1,i2,i3,i4,i7,i8).b(iut,jut)+rmassr*cline_3forks_56(i1,
     & i2,i3,i4,i7,i8).c(iut,jut)+rmassl*rmassr*cline_3forks_56(
     & i1,i2,i3,i4,i7,i8).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
      end do
      end do
      end do
  
      do i1=1,2
       do i2=1,2
        do i3=1,2
         do i4=1,2
          do i5=1,2
           do i6=1,2
            do i7=1,2
             do i8=1,2
                        	
            cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &      cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &      cres_3forks_56(i1,i2,i3,i4,i7,i8).pol(i5,i6)
  
             enddo
            enddo		
           enddo
          enddo
         enddo
        enddo	
       enddo
      enddo
  
  
  
  
  
  
  
      if(id5.ne.5)then
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
      do i3=1,2
      do i4=1,2
* TT -- aa=cline_3forks_56(i1,i2,i7,i8,i3,i4).a,bb=cline_3forks_56(i1,i2
* ,i7,i8,i3,i4).b,cc=cline_3forks_56(i1,i2,i7,i8,i3,i4).c,dd=cline_3fork
* s_56(i1,i2,i7,i8,i3,i4).d,a1=u5_1278(i1,i2,i7,i8).a,b1=u5_1278(i1,i2,i
* 7,i8).b,c1=u5_1278(i1,i2,i7,i8).c,d1=u5_1278(i1,i2,i7,i8).d,a2=r6_34(i
* 3,i4).a,b2=r6_34(i3,i4).b,c2=r6_34(i3,i4).c,d2=r6_34(i3,i4).d,prq=p634
* q,m=rmass(id5),nsum=0
      cline_3forks_56(i1,i2,i7,i8,i3,i4).a(1,1)=u5_1278(i1,i2,i7
     & ,i8).a(1,1)*r6_34(i3,i4).a(1,1)+u5_1278(i1,i2,i7,i8).c(1,
     & 2)*p634q*r6_34(i3,i4).b(2,1)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).b(1,1)=rmass(id5)*(u5_1
     & 278(i1,i2,i7,i8).d(1,1)*r6_34(i3,i4).a(1,1)+u5_1278(i1,i2
     & ,i7,i8).b(1,2)*r6_34(i3,i4).b(2,1))
      cline_3forks_56(i1,i2,i7,i8,i3,i4).c(1,1)=rmass(id5)*(u5_1
     & 278(i1,i2,i7,i8).a(1,1)*r6_34(i3,i4).d(1,1)+u5_1278(i1,i2
     & ,i7,i8).c(1,2)*r6_34(i3,i4).c(2,1))
      cline_3forks_56(i1,i2,i7,i8,i3,i4).d(1,1)=u5_1278(i1,i2,i7
     & ,i8).d(1,1)*p634q*r6_34(i3,i4).d(1,1)+u5_1278(i1,i2,i7,i8
     & ).b(1,2)*r6_34(i3,i4).c(2,1)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).a(1,2)=rmass(id5)*(u5_1
     & 278(i1,i2,i7,i8).a(1,1)*r6_34(i3,i4).b(1,2)+u5_1278(i1,i2
     & ,i7,i8).c(1,2)*r6_34(i3,i4).a(2,2))
      cline_3forks_56(i1,i2,i7,i8,i3,i4).b(1,2)=u5_1278(i1,i2,i7
     & ,i8).d(1,1)*p634q*r6_34(i3,i4).b(1,2)+u5_1278(i1,i2,i7,i8
     & ).b(1,2)*r6_34(i3,i4).a(2,2)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).c(1,2)=u5_1278(i1,i2,i7
     & ,i8).a(1,1)*r6_34(i3,i4).c(1,2)+u5_1278(i1,i2,i7,i8).c(1,
     & 2)*p634q*r6_34(i3,i4).d(2,2)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).d(1,2)=rmass(id5)*(u5_1
     & 278(i1,i2,i7,i8).d(1,1)*r6_34(i3,i4).c(1,2)+u5_1278(i1,i2
     & ,i7,i8).b(1,2)*r6_34(i3,i4).d(2,2))
      cline_3forks_56(i1,i2,i7,i8,i3,i4).a(2,1)=rmass(id5)*(u5_1
     & 278(i1,i2,i7,i8).c(2,1)*r6_34(i3,i4).a(1,1)+u5_1278(i1,i2
     & ,i7,i8).a(2,2)*r6_34(i3,i4).b(2,1))
      cline_3forks_56(i1,i2,i7,i8,i3,i4).b(2,1)=u5_1278(i1,i2,i7
     & ,i8).b(2,1)*r6_34(i3,i4).a(1,1)+u5_1278(i1,i2,i7,i8).d(2,
     & 2)*p634q*r6_34(i3,i4).b(2,1)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).c(2,1)=u5_1278(i1,i2,i7
     & ,i8).c(2,1)*p634q*r6_34(i3,i4).d(1,1)+u5_1278(i1,i2,i7,i8
     & ).a(2,2)*r6_34(i3,i4).c(2,1)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).d(2,1)=rmass(id5)*(u5_1
     & 278(i1,i2,i7,i8).b(2,1)*r6_34(i3,i4).d(1,1)+u5_1278(i1,i2
     & ,i7,i8).d(2,2)*r6_34(i3,i4).c(2,1))
      cline_3forks_56(i1,i2,i7,i8,i3,i4).a(2,2)=u5_1278(i1,i2,i7
     & ,i8).c(2,1)*p634q*r6_34(i3,i4).b(1,2)+u5_1278(i1,i2,i7,i8
     & ).a(2,2)*r6_34(i3,i4).a(2,2)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).b(2,2)=rmass(id5)*(u5_1
     & 278(i1,i2,i7,i8).b(2,1)*r6_34(i3,i4).b(1,2)+u5_1278(i1,i2
     & ,i7,i8).d(2,2)*r6_34(i3,i4).a(2,2))
      cline_3forks_56(i1,i2,i7,i8,i3,i4).c(2,2)=rmass(id5)*(u5_1
     & 278(i1,i2,i7,i8).c(2,1)*r6_34(i3,i4).c(1,2)+u5_1278(i1,i2
     & ,i7,i8).a(2,2)*r6_34(i3,i4).d(2,2))
      cline_3forks_56(i1,i2,i7,i8,i3,i4).d(2,2)=u5_1278(i1,i2,i7
     & ,i8).b(2,1)*r6_34(i3,i4).c(1,2)+u5_1278(i1,i2,i7,i8).d(2,
     & 2)*p634q*r6_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
  
      else
  
         if(id5.eq.5.and.id3.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
      do i3=1,2
      do i4=1,2
* TsT -- aa=cline_3forks_56(i1,i2,i7,i8,i3,i4).a,bb=cline_3forks_56(i1,i
* 2,i7,i8,i3,i4).b,cc=cline_3forks_56(i1,i2,i7,i8,i3,i4).c,dd=cline_3for
* ks_56(i1,i2,i7,i8,i3,i4).d,a1=u5_1278(i1,i2,i7,i8).a,b1=u5_1278(i1,i2,
* i7,i8).b,c1=u5_1278(i1,i2,i7,i8).c,d1=u5_1278(i1,i2,i7,i8).d,a2=r6_34(
* i3,i4).a,b2=r6_34(i3,i4).b,c2=r6_34(i3,i4).c,d2=r6_34(i3,i4).d,prq=p63
* 4q,m=rmass(id5),nsum=0
      do iut=1,2
      cx1=u5_1278(i1,i2,i7,i8).a(iut,1)+u5_1278(i1,i2,i7,i8).c(i
     & ut,1)*rmass(id5)
      cx2=u5_1278(i1,i2,i7,i8).c(iut,2)*p634q+u5_1278(i1,i2,i7,i
     & 8).a(iut,2)*rmass(id5)
      cy1=u5_1278(i1,i2,i7,i8).b(iut,1)+u5_1278(i1,i2,i7,i8).d(i
     & ut,1)*rmass(id5)
      cy2=u5_1278(i1,i2,i7,i8).d(iut,2)*p634q+u5_1278(i1,i2,i7,i
     & 8).b(iut,2)*rmass(id5)
      cw1=u5_1278(i1,i2,i7,i8).c(iut,1)*p634q+u5_1278(i1,i2,i7,i
     & 8).a(iut,1)*rmass(id5)
      cw2=u5_1278(i1,i2,i7,i8).a(iut,2)+u5_1278(i1,i2,i7,i8).c(i
     & ut,2)*rmass(id5)
      cz1=u5_1278(i1,i2,i7,i8).d(iut,1)*p634q+u5_1278(i1,i2,i7,i
     & 8).b(iut,1)*rmass(id5)
      cz2=u5_1278(i1,i2,i7,i8).b(iut,2)+u5_1278(i1,i2,i7,i8).d(i
     & ut,2)*rmass(id5)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).a(iut,1)=cx1*r6_34(i3,i
     & 4).a(1,1)+cx2*r6_34(i3,i4).b(2,1)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).b(iut,1)=cy1*r6_34(i3,i
     & 4).a(1,1)+cy2*r6_34(i3,i4).b(2,1)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).c(iut,1)=cw1*r6_34(i3,i
     & 4).d(1,1)+cw2*r6_34(i3,i4).c(2,1)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).d(iut,1)=cz1*r6_34(i3,i
     & 4).d(1,1)+cz2*r6_34(i3,i4).c(2,1)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).a(iut,2)=cw1*r6_34(i3,i
     & 4).b(1,2)+cw2*r6_34(i3,i4).a(2,2)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).b(iut,2)=cz1*r6_34(i3,i
     & 4).b(1,2)+cz2*r6_34(i3,i4).a(2,2)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).c(iut,2)=cx1*r6_34(i3,i
     & 4).c(1,2)+cx2*r6_34(i3,i4).d(2,2)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).d(iut,2)=cy1*r6_34(i3,i
     & 4).c(1,2)+cy2*r6_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
   	
      else
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
      do i3=1,2
      do i4=1,2
* TsTs -- aa=cline_3forks_56(i1,i2,i7,i8,i3,i4).a,bb=cline_3forks_56(i1,
* i2,i7,i8,i3,i4).b,cc=cline_3forks_56(i1,i2,i7,i8,i3,i4).c,dd=cline_3fo
* rks_56(i1,i2,i7,i8,i3,i4).d,a1=u5_1278(i1,i2,i7,i8).a,b1=u5_1278(i1,i2
* ,i7,i8).b,c1=u5_1278(i1,i2,i7,i8).c,d1=u5_1278(i1,i2,i7,i8).d,a2=r6_34
* (i3,i4).a,b2=r6_34(i3,i4).b,c2=r6_34(i3,i4).c,d2=r6_34(i3,i4).d,prq=p6
* 34q,m=rmass(id5),nsum=0
      do iut=1,2
      do jut=1,2
      cx1=r6_34(i3,i4).a(1,jut)+rmass(id5)*r6_34(i3,i4).b(1,jut)
      cx2=r6_34(i3,i4).a(2,jut)+rmass(id5)*r6_34(i3,i4).b(2,jut)
      cy1=p634q*r6_34(i3,i4).b(1,jut)+rmass(id5)*r6_34(i3,i4).a(
     & 1,jut)
      cy2=p634q*r6_34(i3,i4).b(2,jut)+rmass(id5)*r6_34(i3,i4).a(
     & 2,jut)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).a(iut,jut)=u5_1278(i1,i
     & 2,i7,i8).a(iut,1)*cx1+u5_1278(i1,i2,i7,i8).c(iut,1)*cy1+u
     & 5_1278(i1,i2,i7,i8).a(iut,2)*cx2+u5_1278(i1,i2,i7,i8).c(i
     & ut,2)*cy2
      cline_3forks_56(i1,i2,i7,i8,i3,i4).b(iut,jut)=u5_1278(i1,i
     & 2,i7,i8).b(iut,1)*cx1+u5_1278(i1,i2,i7,i8).d(iut,1)*cy1+u
     & 5_1278(i1,i2,i7,i8).b(iut,2)*cx2+u5_1278(i1,i2,i7,i8).d(i
     & ut,2)*cy2
      cw1=r6_34(i3,i4).c(1,jut)+rmass(id5)*r6_34(i3,i4).d(1,jut)
      cw2=r6_34(i3,i4).c(2,jut)+rmass(id5)*r6_34(i3,i4).d(2,jut)
      cz1=p634q*r6_34(i3,i4).d(1,jut)+rmass(id5)*r6_34(i3,i4).c(
     & 1,jut)
      cz2=p634q*r6_34(i3,i4).d(2,jut)+rmass(id5)*r6_34(i3,i4).c(
     & 2,jut)
      cline_3forks_56(i1,i2,i7,i8,i3,i4).c(iut,jut)=u5_1278(i1,i
     & 2,i7,i8).a(iut,1)*cw1+u5_1278(i1,i2,i7,i8).c(iut,1)*cz1+u
     & 5_1278(i1,i2,i7,i8).a(iut,2)*cw2+u5_1278(i1,i2,i7,i8).c(i
     & ut,2)*cz2
      cline_3forks_56(i1,i2,i7,i8,i3,i4).d(iut,jut)=u5_1278(i1,i
     & 2,i7,i8).b(iut,1)*cw1+u5_1278(i1,i2,i7,i8).d(iut,1)*cz1+u
     & 5_1278(i1,i2,i7,i8).b(iut,2)*cw2+u5_1278(i1,i2,i7,i8).d(i
     & ut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
        	
  
  
      endif	
  
  
      rmassl=rmass(id5)
      rmassr=-rmassl
  
      do i1=1,2
      do i2=1,2
      do i7=1,2
      do i8=1,2
      do i3=1,2
      do i4=1,2
* mline -- res=cres_3forks_56(i1,i2,i7,i8,i3,i4).pol(&1,&2),abcd=cline_3
* forks_56(i1,i2,i7,i8,i3,i4).,m1=rmassl,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cres_3forks_56(i1,i2,i7,i8,i3,i4).pol(iut,jut)=cline_3fork
     & s_56(i1,i2,i7,i8,i3,i4).a(iut,jut)+rmassl*cline_3forks_56
     & (i1,i2,i7,i8,i3,i4).b(iut,jut)+rmassr*cline_3forks_56(i1,
     & i2,i7,i8,i3,i4).c(iut,jut)+rmassl*rmassr*cline_3forks_56(
     & i1,i2,i7,i8,i3,i4).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
      end do
      end do
      end do
  
      do i1=1,2
       do i2=1,2
        do i3=1,2
         do i4=1,2
          do i5=1,2
           do i6=1,2
            do i7=1,2
             do i8=1,2
                        	
            cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &      cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &      cres_3forks_56(i1,i2,i7,i8,i3,i4).pol(i5,i6)
  
             enddo
            enddo		
           enddo
          enddo
         enddo
        enddo	
       enddo
      enddo
  
  
  
  
  
  
  
      if(id5.ne.5)then
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
      do i1=1,2
      do i2=1,2
* TT -- aa=cline_3forks_56(i3,i4,i7,i8,i1,i2).a,bb=cline_3forks_56(i3,i4
* ,i7,i8,i1,i2).b,cc=cline_3forks_56(i3,i4,i7,i8,i1,i2).c,dd=cline_3fork
* s_56(i3,i4,i7,i8,i1,i2).d,a1=u5_3478(i3,i4,i7,i8).a,b1=u5_3478(i3,i4,i
* 7,i8).b,c1=u5_3478(i3,i4,i7,i8).c,d1=u5_3478(i3,i4,i7,i8).d,a2=r6_12(i
* 1,i2).a,b2=r6_12(i1,i2).b,c2=r6_12(i1,i2).c,d2=r6_12(i1,i2).d,prq=p612
* q,m=rmass(id5),nsum=0
      cline_3forks_56(i3,i4,i7,i8,i1,i2).a(1,1)=u5_3478(i3,i4,i7
     & ,i8).a(1,1)*r6_12(i1,i2).a(1,1)+u5_3478(i3,i4,i7,i8).c(1,
     & 2)*p612q*r6_12(i1,i2).b(2,1)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).b(1,1)=rmass(id5)*(u5_3
     & 478(i3,i4,i7,i8).d(1,1)*r6_12(i1,i2).a(1,1)+u5_3478(i3,i4
     & ,i7,i8).b(1,2)*r6_12(i1,i2).b(2,1))
      cline_3forks_56(i3,i4,i7,i8,i1,i2).c(1,1)=rmass(id5)*(u5_3
     & 478(i3,i4,i7,i8).a(1,1)*r6_12(i1,i2).d(1,1)+u5_3478(i3,i4
     & ,i7,i8).c(1,2)*r6_12(i1,i2).c(2,1))
      cline_3forks_56(i3,i4,i7,i8,i1,i2).d(1,1)=u5_3478(i3,i4,i7
     & ,i8).d(1,1)*p612q*r6_12(i1,i2).d(1,1)+u5_3478(i3,i4,i7,i8
     & ).b(1,2)*r6_12(i1,i2).c(2,1)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).a(1,2)=rmass(id5)*(u5_3
     & 478(i3,i4,i7,i8).a(1,1)*r6_12(i1,i2).b(1,2)+u5_3478(i3,i4
     & ,i7,i8).c(1,2)*r6_12(i1,i2).a(2,2))
      cline_3forks_56(i3,i4,i7,i8,i1,i2).b(1,2)=u5_3478(i3,i4,i7
     & ,i8).d(1,1)*p612q*r6_12(i1,i2).b(1,2)+u5_3478(i3,i4,i7,i8
     & ).b(1,2)*r6_12(i1,i2).a(2,2)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).c(1,2)=u5_3478(i3,i4,i7
     & ,i8).a(1,1)*r6_12(i1,i2).c(1,2)+u5_3478(i3,i4,i7,i8).c(1,
     & 2)*p612q*r6_12(i1,i2).d(2,2)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).d(1,2)=rmass(id5)*(u5_3
     & 478(i3,i4,i7,i8).d(1,1)*r6_12(i1,i2).c(1,2)+u5_3478(i3,i4
     & ,i7,i8).b(1,2)*r6_12(i1,i2).d(2,2))
      cline_3forks_56(i3,i4,i7,i8,i1,i2).a(2,1)=rmass(id5)*(u5_3
     & 478(i3,i4,i7,i8).c(2,1)*r6_12(i1,i2).a(1,1)+u5_3478(i3,i4
     & ,i7,i8).a(2,2)*r6_12(i1,i2).b(2,1))
      cline_3forks_56(i3,i4,i7,i8,i1,i2).b(2,1)=u5_3478(i3,i4,i7
     & ,i8).b(2,1)*r6_12(i1,i2).a(1,1)+u5_3478(i3,i4,i7,i8).d(2,
     & 2)*p612q*r6_12(i1,i2).b(2,1)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).c(2,1)=u5_3478(i3,i4,i7
     & ,i8).c(2,1)*p612q*r6_12(i1,i2).d(1,1)+u5_3478(i3,i4,i7,i8
     & ).a(2,2)*r6_12(i1,i2).c(2,1)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).d(2,1)=rmass(id5)*(u5_3
     & 478(i3,i4,i7,i8).b(2,1)*r6_12(i1,i2).d(1,1)+u5_3478(i3,i4
     & ,i7,i8).d(2,2)*r6_12(i1,i2).c(2,1))
      cline_3forks_56(i3,i4,i7,i8,i1,i2).a(2,2)=u5_3478(i3,i4,i7
     & ,i8).c(2,1)*p612q*r6_12(i1,i2).b(1,2)+u5_3478(i3,i4,i7,i8
     & ).a(2,2)*r6_12(i1,i2).a(2,2)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).b(2,2)=rmass(id5)*(u5_3
     & 478(i3,i4,i7,i8).b(2,1)*r6_12(i1,i2).b(1,2)+u5_3478(i3,i4
     & ,i7,i8).d(2,2)*r6_12(i1,i2).a(2,2))
      cline_3forks_56(i3,i4,i7,i8,i1,i2).c(2,2)=rmass(id5)*(u5_3
     & 478(i3,i4,i7,i8).c(2,1)*r6_12(i1,i2).c(1,2)+u5_3478(i3,i4
     & ,i7,i8).a(2,2)*r6_12(i1,i2).d(2,2))
      cline_3forks_56(i3,i4,i7,i8,i1,i2).d(2,2)=u5_3478(i3,i4,i7
     & ,i8).b(2,1)*r6_12(i1,i2).c(1,2)+u5_3478(i3,i4,i7,i8).d(2,
     & 2)*p612q*r6_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
  
      else
  
         if(id5.eq.5.and.id1.ne.5)then
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
      do i1=1,2
      do i2=1,2
* TsT -- aa=cline_3forks_56(i3,i4,i7,i8,i1,i2).a,bb=cline_3forks_56(i3,i
* 4,i7,i8,i1,i2).b,cc=cline_3forks_56(i3,i4,i7,i8,i1,i2).c,dd=cline_3for
* ks_56(i3,i4,i7,i8,i1,i2).d,a1=u5_3478(i3,i4,i7,i8).a,b1=u5_3478(i3,i4,
* i7,i8).b,c1=u5_3478(i3,i4,i7,i8).c,d1=u5_3478(i3,i4,i7,i8).d,a2=r6_12(
* i1,i2).a,b2=r6_12(i1,i2).b,c2=r6_12(i1,i2).c,d2=r6_12(i1,i2).d,prq=p61
* 2q,m=rmass(id5),nsum=0
      do iut=1,2
      cx1=u5_3478(i3,i4,i7,i8).a(iut,1)+u5_3478(i3,i4,i7,i8).c(i
     & ut,1)*rmass(id5)
      cx2=u5_3478(i3,i4,i7,i8).c(iut,2)*p612q+u5_3478(i3,i4,i7,i
     & 8).a(iut,2)*rmass(id5)
      cy1=u5_3478(i3,i4,i7,i8).b(iut,1)+u5_3478(i3,i4,i7,i8).d(i
     & ut,1)*rmass(id5)
      cy2=u5_3478(i3,i4,i7,i8).d(iut,2)*p612q+u5_3478(i3,i4,i7,i
     & 8).b(iut,2)*rmass(id5)
      cw1=u5_3478(i3,i4,i7,i8).c(iut,1)*p612q+u5_3478(i3,i4,i7,i
     & 8).a(iut,1)*rmass(id5)
      cw2=u5_3478(i3,i4,i7,i8).a(iut,2)+u5_3478(i3,i4,i7,i8).c(i
     & ut,2)*rmass(id5)
      cz1=u5_3478(i3,i4,i7,i8).d(iut,1)*p612q+u5_3478(i3,i4,i7,i
     & 8).b(iut,1)*rmass(id5)
      cz2=u5_3478(i3,i4,i7,i8).b(iut,2)+u5_3478(i3,i4,i7,i8).d(i
     & ut,2)*rmass(id5)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).a(iut,1)=cx1*r6_12(i1,i
     & 2).a(1,1)+cx2*r6_12(i1,i2).b(2,1)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).b(iut,1)=cy1*r6_12(i1,i
     & 2).a(1,1)+cy2*r6_12(i1,i2).b(2,1)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).c(iut,1)=cw1*r6_12(i1,i
     & 2).d(1,1)+cw2*r6_12(i1,i2).c(2,1)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).d(iut,1)=cz1*r6_12(i1,i
     & 2).d(1,1)+cz2*r6_12(i1,i2).c(2,1)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).a(iut,2)=cw1*r6_12(i1,i
     & 2).b(1,2)+cw2*r6_12(i1,i2).a(2,2)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).b(iut,2)=cz1*r6_12(i1,i
     & 2).b(1,2)+cz2*r6_12(i1,i2).a(2,2)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).c(iut,2)=cx1*r6_12(i1,i
     & 2).c(1,2)+cx2*r6_12(i1,i2).d(2,2)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).d(iut,2)=cy1*r6_12(i1,i
     & 2).c(1,2)+cy2*r6_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
   	
      else
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
      do i1=1,2
      do i2=1,2
* TsTs -- aa=cline_3forks_56(i3,i4,i7,i8,i1,i2).a,bb=cline_3forks_56(i3,
* i4,i7,i8,i1,i2).b,cc=cline_3forks_56(i3,i4,i7,i8,i1,i2).c,dd=cline_3fo
* rks_56(i3,i4,i7,i8,i1,i2).d,a1=u5_3478(i3,i4,i7,i8).a,b1=u5_3478(i3,i4
* ,i7,i8).b,c1=u5_3478(i3,i4,i7,i8).c,d1=u5_3478(i3,i4,i7,i8).d,a2=r6_12
* (i1,i2).a,b2=r6_12(i1,i2).b,c2=r6_12(i1,i2).c,d2=r6_12(i1,i2).d,prq=p6
* 12q,m=rmass(id5),nsum=0
      do iut=1,2
      do jut=1,2
      cx1=r6_12(i1,i2).a(1,jut)+rmass(id5)*r6_12(i1,i2).b(1,jut)
      cx2=r6_12(i1,i2).a(2,jut)+rmass(id5)*r6_12(i1,i2).b(2,jut)
      cy1=p612q*r6_12(i1,i2).b(1,jut)+rmass(id5)*r6_12(i1,i2).a(
     & 1,jut)
      cy2=p612q*r6_12(i1,i2).b(2,jut)+rmass(id5)*r6_12(i1,i2).a(
     & 2,jut)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).a(iut,jut)=u5_3478(i3,i
     & 4,i7,i8).a(iut,1)*cx1+u5_3478(i3,i4,i7,i8).c(iut,1)*cy1+u
     & 5_3478(i3,i4,i7,i8).a(iut,2)*cx2+u5_3478(i3,i4,i7,i8).c(i
     & ut,2)*cy2
      cline_3forks_56(i3,i4,i7,i8,i1,i2).b(iut,jut)=u5_3478(i3,i
     & 4,i7,i8).b(iut,1)*cx1+u5_3478(i3,i4,i7,i8).d(iut,1)*cy1+u
     & 5_3478(i3,i4,i7,i8).b(iut,2)*cx2+u5_3478(i3,i4,i7,i8).d(i
     & ut,2)*cy2
      cw1=r6_12(i1,i2).c(1,jut)+rmass(id5)*r6_12(i1,i2).d(1,jut)
      cw2=r6_12(i1,i2).c(2,jut)+rmass(id5)*r6_12(i1,i2).d(2,jut)
      cz1=p612q*r6_12(i1,i2).d(1,jut)+rmass(id5)*r6_12(i1,i2).c(
     & 1,jut)
      cz2=p612q*r6_12(i1,i2).d(2,jut)+rmass(id5)*r6_12(i1,i2).c(
     & 2,jut)
      cline_3forks_56(i3,i4,i7,i8,i1,i2).c(iut,jut)=u5_3478(i3,i
     & 4,i7,i8).a(iut,1)*cw1+u5_3478(i3,i4,i7,i8).c(iut,1)*cz1+u
     & 5_3478(i3,i4,i7,i8).a(iut,2)*cw2+u5_3478(i3,i4,i7,i8).c(i
     & ut,2)*cz2
      cline_3forks_56(i3,i4,i7,i8,i1,i2).d(iut,jut)=u5_3478(i3,i
     & 4,i7,i8).b(iut,1)*cw1+u5_3478(i3,i4,i7,i8).d(iut,1)*cz1+u
     & 5_3478(i3,i4,i7,i8).b(iut,2)*cw2+u5_3478(i3,i4,i7,i8).d(i
     & ut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
        	
  
  
      endif	
  
  
      rmassl=rmass(id5)
      rmassr=-rmassl
  
      do i3=1,2
      do i4=1,2
      do i7=1,2
      do i8=1,2
      do i1=1,2
      do i2=1,2
* mline -- res=cres_3forks_56(i3,i4,i7,i8,i1,i2).pol(&1,&2),abcd=cline_3
* forks_56(i3,i4,i7,i8,i1,i2).,m1=rmassl,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cres_3forks_56(i3,i4,i7,i8,i1,i2).pol(iut,jut)=cline_3fork
     & s_56(i3,i4,i7,i8,i1,i2).a(iut,jut)+rmassl*cline_3forks_56
     & (i3,i4,i7,i8,i1,i2).b(iut,jut)+rmassr*cline_3forks_56(i3,
     & i4,i7,i8,i1,i2).c(iut,jut)+rmassl*rmassr*cline_3forks_56(
     & i3,i4,i7,i8,i1,i2).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
      end do
      end do
      end do
  
      do i1=1,2
       do i2=1,2
        do i3=1,2
         do i4=1,2
          do i5=1,2
           do i6=1,2
            do i7=1,2
             do i8=1,2
                        	
            cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &      cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &      cres_3forks_56(i3,i4,i7,i8,i1,i2).pol(i5,i6)
  
             enddo
            enddo		
           enddo
          enddo
         enddo
        enddo	
       enddo
      enddo
  
  
  
  
  
  
  
      if(id7.ne.5)then
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TT -- aa=cline_3forks_78(i1,i2,i3,i4,i5,i6).a,bb=cline_3forks_78(i1,i2
* ,i3,i4,i5,i6).b,cc=cline_3forks_78(i1,i2,i3,i4,i5,i6).c,dd=cline_3fork
* s_78(i1,i2,i3,i4,i5,i6).d,a1=u7_1234(i1,i2,i3,i4).a,b1=u7_1234(i1,i2,i
* 3,i4).b,c1=u7_1234(i1,i2,i3,i4).c,d1=u7_1234(i1,i2,i3,i4).d,a2=r8_56(i
* 5,i6).a,b2=r8_56(i5,i6).b,c2=r8_56(i5,i6).c,d2=r8_56(i5,i6).d,prq=p856
* q,m=rmass(id7),nsum=0
      cline_3forks_78(i1,i2,i3,i4,i5,i6).a(1,1)=u7_1234(i1,i2,i3
     & ,i4).a(1,1)*r8_56(i5,i6).a(1,1)+u7_1234(i1,i2,i3,i4).c(1,
     & 2)*p856q*r8_56(i5,i6).b(2,1)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).b(1,1)=rmass(id7)*(u7_1
     & 234(i1,i2,i3,i4).d(1,1)*r8_56(i5,i6).a(1,1)+u7_1234(i1,i2
     & ,i3,i4).b(1,2)*r8_56(i5,i6).b(2,1))
      cline_3forks_78(i1,i2,i3,i4,i5,i6).c(1,1)=rmass(id7)*(u7_1
     & 234(i1,i2,i3,i4).a(1,1)*r8_56(i5,i6).d(1,1)+u7_1234(i1,i2
     & ,i3,i4).c(1,2)*r8_56(i5,i6).c(2,1))
      cline_3forks_78(i1,i2,i3,i4,i5,i6).d(1,1)=u7_1234(i1,i2,i3
     & ,i4).d(1,1)*p856q*r8_56(i5,i6).d(1,1)+u7_1234(i1,i2,i3,i4
     & ).b(1,2)*r8_56(i5,i6).c(2,1)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).a(1,2)=rmass(id7)*(u7_1
     & 234(i1,i2,i3,i4).a(1,1)*r8_56(i5,i6).b(1,2)+u7_1234(i1,i2
     & ,i3,i4).c(1,2)*r8_56(i5,i6).a(2,2))
      cline_3forks_78(i1,i2,i3,i4,i5,i6).b(1,2)=u7_1234(i1,i2,i3
     & ,i4).d(1,1)*p856q*r8_56(i5,i6).b(1,2)+u7_1234(i1,i2,i3,i4
     & ).b(1,2)*r8_56(i5,i6).a(2,2)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).c(1,2)=u7_1234(i1,i2,i3
     & ,i4).a(1,1)*r8_56(i5,i6).c(1,2)+u7_1234(i1,i2,i3,i4).c(1,
     & 2)*p856q*r8_56(i5,i6).d(2,2)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).d(1,2)=rmass(id7)*(u7_1
     & 234(i1,i2,i3,i4).d(1,1)*r8_56(i5,i6).c(1,2)+u7_1234(i1,i2
     & ,i3,i4).b(1,2)*r8_56(i5,i6).d(2,2))
      cline_3forks_78(i1,i2,i3,i4,i5,i6).a(2,1)=rmass(id7)*(u7_1
     & 234(i1,i2,i3,i4).c(2,1)*r8_56(i5,i6).a(1,1)+u7_1234(i1,i2
     & ,i3,i4).a(2,2)*r8_56(i5,i6).b(2,1))
      cline_3forks_78(i1,i2,i3,i4,i5,i6).b(2,1)=u7_1234(i1,i2,i3
     & ,i4).b(2,1)*r8_56(i5,i6).a(1,1)+u7_1234(i1,i2,i3,i4).d(2,
     & 2)*p856q*r8_56(i5,i6).b(2,1)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).c(2,1)=u7_1234(i1,i2,i3
     & ,i4).c(2,1)*p856q*r8_56(i5,i6).d(1,1)+u7_1234(i1,i2,i3,i4
     & ).a(2,2)*r8_56(i5,i6).c(2,1)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).d(2,1)=rmass(id7)*(u7_1
     & 234(i1,i2,i3,i4).b(2,1)*r8_56(i5,i6).d(1,1)+u7_1234(i1,i2
     & ,i3,i4).d(2,2)*r8_56(i5,i6).c(2,1))
      cline_3forks_78(i1,i2,i3,i4,i5,i6).a(2,2)=u7_1234(i1,i2,i3
     & ,i4).c(2,1)*p856q*r8_56(i5,i6).b(1,2)+u7_1234(i1,i2,i3,i4
     & ).a(2,2)*r8_56(i5,i6).a(2,2)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).b(2,2)=rmass(id7)*(u7_1
     & 234(i1,i2,i3,i4).b(2,1)*r8_56(i5,i6).b(1,2)+u7_1234(i1,i2
     & ,i3,i4).d(2,2)*r8_56(i5,i6).a(2,2))
      cline_3forks_78(i1,i2,i3,i4,i5,i6).c(2,2)=rmass(id7)*(u7_1
     & 234(i1,i2,i3,i4).c(2,1)*r8_56(i5,i6).c(1,2)+u7_1234(i1,i2
     & ,i3,i4).a(2,2)*r8_56(i5,i6).d(2,2))
      cline_3forks_78(i1,i2,i3,i4,i5,i6).d(2,2)=u7_1234(i1,i2,i3
     & ,i4).b(2,1)*r8_56(i5,i6).c(1,2)+u7_1234(i1,i2,i3,i4).d(2,
     & 2)*p856q*r8_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
  
      else
  
         if(id7.eq.5.and.id5.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TsT -- aa=cline_3forks_78(i1,i2,i3,i4,i5,i6).a,bb=cline_3forks_78(i1,i
* 2,i3,i4,i5,i6).b,cc=cline_3forks_78(i1,i2,i3,i4,i5,i6).c,dd=cline_3for
* ks_78(i1,i2,i3,i4,i5,i6).d,a1=u7_1234(i1,i2,i3,i4).a,b1=u7_1234(i1,i2,
* i3,i4).b,c1=u7_1234(i1,i2,i3,i4).c,d1=u7_1234(i1,i2,i3,i4).d,a2=r8_56(
* i5,i6).a,b2=r8_56(i5,i6).b,c2=r8_56(i5,i6).c,d2=r8_56(i5,i6).d,prq=p85
* 6q,m=rmass(id7),nsum=0
      do iut=1,2
      cx1=u7_1234(i1,i2,i3,i4).a(iut,1)+u7_1234(i1,i2,i3,i4).c(i
     & ut,1)*rmass(id7)
      cx2=u7_1234(i1,i2,i3,i4).c(iut,2)*p856q+u7_1234(i1,i2,i3,i
     & 4).a(iut,2)*rmass(id7)
      cy1=u7_1234(i1,i2,i3,i4).b(iut,1)+u7_1234(i1,i2,i3,i4).d(i
     & ut,1)*rmass(id7)
      cy2=u7_1234(i1,i2,i3,i4).d(iut,2)*p856q+u7_1234(i1,i2,i3,i
     & 4).b(iut,2)*rmass(id7)
      cw1=u7_1234(i1,i2,i3,i4).c(iut,1)*p856q+u7_1234(i1,i2,i3,i
     & 4).a(iut,1)*rmass(id7)
      cw2=u7_1234(i1,i2,i3,i4).a(iut,2)+u7_1234(i1,i2,i3,i4).c(i
     & ut,2)*rmass(id7)
      cz1=u7_1234(i1,i2,i3,i4).d(iut,1)*p856q+u7_1234(i1,i2,i3,i
     & 4).b(iut,1)*rmass(id7)
      cz2=u7_1234(i1,i2,i3,i4).b(iut,2)+u7_1234(i1,i2,i3,i4).d(i
     & ut,2)*rmass(id7)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).a(iut,1)=cx1*r8_56(i5,i
     & 6).a(1,1)+cx2*r8_56(i5,i6).b(2,1)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).b(iut,1)=cy1*r8_56(i5,i
     & 6).a(1,1)+cy2*r8_56(i5,i6).b(2,1)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).c(iut,1)=cw1*r8_56(i5,i
     & 6).d(1,1)+cw2*r8_56(i5,i6).c(2,1)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).d(iut,1)=cz1*r8_56(i5,i
     & 6).d(1,1)+cz2*r8_56(i5,i6).c(2,1)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).a(iut,2)=cw1*r8_56(i5,i
     & 6).b(1,2)+cw2*r8_56(i5,i6).a(2,2)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).b(iut,2)=cz1*r8_56(i5,i
     & 6).b(1,2)+cz2*r8_56(i5,i6).a(2,2)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).c(iut,2)=cx1*r8_56(i5,i
     & 6).c(1,2)+cx2*r8_56(i5,i6).d(2,2)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).d(iut,2)=cy1*r8_56(i5,i
     & 6).c(1,2)+cy2*r8_56(i5,i6).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
   	
      else
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* TsTs -- aa=cline_3forks_78(i1,i2,i3,i4,i5,i6).a,bb=cline_3forks_78(i1,
* i2,i3,i4,i5,i6).b,cc=cline_3forks_78(i1,i2,i3,i4,i5,i6).c,dd=cline_3fo
* rks_78(i1,i2,i3,i4,i5,i6).d,a1=u7_1234(i1,i2,i3,i4).a,b1=u7_1234(i1,i2
* ,i3,i4).b,c1=u7_1234(i1,i2,i3,i4).c,d1=u7_1234(i1,i2,i3,i4).d,a2=r8_56
* (i5,i6).a,b2=r8_56(i5,i6).b,c2=r8_56(i5,i6).c,d2=r8_56(i5,i6).d,prq=p8
* 56q,m=rmass(id7),nsum=0
      do iut=1,2
      do jut=1,2
      cx1=r8_56(i5,i6).a(1,jut)+rmass(id7)*r8_56(i5,i6).b(1,jut)
      cx2=r8_56(i5,i6).a(2,jut)+rmass(id7)*r8_56(i5,i6).b(2,jut)
      cy1=p856q*r8_56(i5,i6).b(1,jut)+rmass(id7)*r8_56(i5,i6).a(
     & 1,jut)
      cy2=p856q*r8_56(i5,i6).b(2,jut)+rmass(id7)*r8_56(i5,i6).a(
     & 2,jut)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).a(iut,jut)=u7_1234(i1,i
     & 2,i3,i4).a(iut,1)*cx1+u7_1234(i1,i2,i3,i4).c(iut,1)*cy1+u
     & 7_1234(i1,i2,i3,i4).a(iut,2)*cx2+u7_1234(i1,i2,i3,i4).c(i
     & ut,2)*cy2
      cline_3forks_78(i1,i2,i3,i4,i5,i6).b(iut,jut)=u7_1234(i1,i
     & 2,i3,i4).b(iut,1)*cx1+u7_1234(i1,i2,i3,i4).d(iut,1)*cy1+u
     & 7_1234(i1,i2,i3,i4).b(iut,2)*cx2+u7_1234(i1,i2,i3,i4).d(i
     & ut,2)*cy2
      cw1=r8_56(i5,i6).c(1,jut)+rmass(id7)*r8_56(i5,i6).d(1,jut)
      cw2=r8_56(i5,i6).c(2,jut)+rmass(id7)*r8_56(i5,i6).d(2,jut)
      cz1=p856q*r8_56(i5,i6).d(1,jut)+rmass(id7)*r8_56(i5,i6).c(
     & 1,jut)
      cz2=p856q*r8_56(i5,i6).d(2,jut)+rmass(id7)*r8_56(i5,i6).c(
     & 2,jut)
      cline_3forks_78(i1,i2,i3,i4,i5,i6).c(iut,jut)=u7_1234(i1,i
     & 2,i3,i4).a(iut,1)*cw1+u7_1234(i1,i2,i3,i4).c(iut,1)*cz1+u
     & 7_1234(i1,i2,i3,i4).a(iut,2)*cw2+u7_1234(i1,i2,i3,i4).c(i
     & ut,2)*cz2
      cline_3forks_78(i1,i2,i3,i4,i5,i6).d(iut,jut)=u7_1234(i1,i
     & 2,i3,i4).b(iut,1)*cw1+u7_1234(i1,i2,i3,i4).d(iut,1)*cz1+u
     & 7_1234(i1,i2,i3,i4).b(iut,2)*cw2+u7_1234(i1,i2,i3,i4).d(i
     & ut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
        	
  
  
      endif	
  
  
      rmassl=rmass(id7)
      rmassr=-rmassl
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
* mline -- res=cres_3forks_78(i1,i2,i3,i4,i5,i6).pol(&1,&2),abcd=cline_3
* forks_78(i1,i2,i3,i4,i5,i6).,m1=rmassl,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cres_3forks_78(i1,i2,i3,i4,i5,i6).pol(iut,jut)=cline_3fork
     & s_78(i1,i2,i3,i4,i5,i6).a(iut,jut)+rmassl*cline_3forks_78
     & (i1,i2,i3,i4,i5,i6).b(iut,jut)+rmassr*cline_3forks_78(i1,
     & i2,i3,i4,i5,i6).c(iut,jut)+rmassl*rmassr*cline_3forks_78(
     & i1,i2,i3,i4,i5,i6).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
      end do
      end do
      end do
  
      do i1=1,2
       do i2=1,2
        do i3=1,2
         do i4=1,2
          do i5=1,2
           do i6=1,2
            do i7=1,2
             do i8=1,2
                        	
            cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &      cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &      cres_3forks_78(i1,i2,i3,i4,i5,i6).pol(i7,i8)
  
             enddo
            enddo		
           enddo
          enddo
         enddo
        enddo	
       enddo
      enddo
  
  
  
  
  
  
  
      if(id7.ne.5)then
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
      do i3=1,2
      do i4=1,2
* TT -- aa=cline_3forks_78(i1,i2,i5,i6,i3,i4).a,bb=cline_3forks_78(i1,i2
* ,i5,i6,i3,i4).b,cc=cline_3forks_78(i1,i2,i5,i6,i3,i4).c,dd=cline_3fork
* s_78(i1,i2,i5,i6,i3,i4).d,a1=u7_1256(i1,i2,i5,i6).a,b1=u7_1256(i1,i2,i
* 5,i6).b,c1=u7_1256(i1,i2,i5,i6).c,d1=u7_1256(i1,i2,i5,i6).d,a2=r8_34(i
* 3,i4).a,b2=r8_34(i3,i4).b,c2=r8_34(i3,i4).c,d2=r8_34(i3,i4).d,prq=p834
* q,m=rmass(id7),nsum=0
      cline_3forks_78(i1,i2,i5,i6,i3,i4).a(1,1)=u7_1256(i1,i2,i5
     & ,i6).a(1,1)*r8_34(i3,i4).a(1,1)+u7_1256(i1,i2,i5,i6).c(1,
     & 2)*p834q*r8_34(i3,i4).b(2,1)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).b(1,1)=rmass(id7)*(u7_1
     & 256(i1,i2,i5,i6).d(1,1)*r8_34(i3,i4).a(1,1)+u7_1256(i1,i2
     & ,i5,i6).b(1,2)*r8_34(i3,i4).b(2,1))
      cline_3forks_78(i1,i2,i5,i6,i3,i4).c(1,1)=rmass(id7)*(u7_1
     & 256(i1,i2,i5,i6).a(1,1)*r8_34(i3,i4).d(1,1)+u7_1256(i1,i2
     & ,i5,i6).c(1,2)*r8_34(i3,i4).c(2,1))
      cline_3forks_78(i1,i2,i5,i6,i3,i4).d(1,1)=u7_1256(i1,i2,i5
     & ,i6).d(1,1)*p834q*r8_34(i3,i4).d(1,1)+u7_1256(i1,i2,i5,i6
     & ).b(1,2)*r8_34(i3,i4).c(2,1)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).a(1,2)=rmass(id7)*(u7_1
     & 256(i1,i2,i5,i6).a(1,1)*r8_34(i3,i4).b(1,2)+u7_1256(i1,i2
     & ,i5,i6).c(1,2)*r8_34(i3,i4).a(2,2))
      cline_3forks_78(i1,i2,i5,i6,i3,i4).b(1,2)=u7_1256(i1,i2,i5
     & ,i6).d(1,1)*p834q*r8_34(i3,i4).b(1,2)+u7_1256(i1,i2,i5,i6
     & ).b(1,2)*r8_34(i3,i4).a(2,2)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).c(1,2)=u7_1256(i1,i2,i5
     & ,i6).a(1,1)*r8_34(i3,i4).c(1,2)+u7_1256(i1,i2,i5,i6).c(1,
     & 2)*p834q*r8_34(i3,i4).d(2,2)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).d(1,2)=rmass(id7)*(u7_1
     & 256(i1,i2,i5,i6).d(1,1)*r8_34(i3,i4).c(1,2)+u7_1256(i1,i2
     & ,i5,i6).b(1,2)*r8_34(i3,i4).d(2,2))
      cline_3forks_78(i1,i2,i5,i6,i3,i4).a(2,1)=rmass(id7)*(u7_1
     & 256(i1,i2,i5,i6).c(2,1)*r8_34(i3,i4).a(1,1)+u7_1256(i1,i2
     & ,i5,i6).a(2,2)*r8_34(i3,i4).b(2,1))
      cline_3forks_78(i1,i2,i5,i6,i3,i4).b(2,1)=u7_1256(i1,i2,i5
     & ,i6).b(2,1)*r8_34(i3,i4).a(1,1)+u7_1256(i1,i2,i5,i6).d(2,
     & 2)*p834q*r8_34(i3,i4).b(2,1)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).c(2,1)=u7_1256(i1,i2,i5
     & ,i6).c(2,1)*p834q*r8_34(i3,i4).d(1,1)+u7_1256(i1,i2,i5,i6
     & ).a(2,2)*r8_34(i3,i4).c(2,1)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).d(2,1)=rmass(id7)*(u7_1
     & 256(i1,i2,i5,i6).b(2,1)*r8_34(i3,i4).d(1,1)+u7_1256(i1,i2
     & ,i5,i6).d(2,2)*r8_34(i3,i4).c(2,1))
      cline_3forks_78(i1,i2,i5,i6,i3,i4).a(2,2)=u7_1256(i1,i2,i5
     & ,i6).c(2,1)*p834q*r8_34(i3,i4).b(1,2)+u7_1256(i1,i2,i5,i6
     & ).a(2,2)*r8_34(i3,i4).a(2,2)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).b(2,2)=rmass(id7)*(u7_1
     & 256(i1,i2,i5,i6).b(2,1)*r8_34(i3,i4).b(1,2)+u7_1256(i1,i2
     & ,i5,i6).d(2,2)*r8_34(i3,i4).a(2,2))
      cline_3forks_78(i1,i2,i5,i6,i3,i4).c(2,2)=rmass(id7)*(u7_1
     & 256(i1,i2,i5,i6).c(2,1)*r8_34(i3,i4).c(1,2)+u7_1256(i1,i2
     & ,i5,i6).a(2,2)*r8_34(i3,i4).d(2,2))
      cline_3forks_78(i1,i2,i5,i6,i3,i4).d(2,2)=u7_1256(i1,i2,i5
     & ,i6).b(2,1)*r8_34(i3,i4).c(1,2)+u7_1256(i1,i2,i5,i6).d(2,
     & 2)*p834q*r8_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
  
      else
  
         if(id7.eq.5.and.id3.ne.5)then
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
      do i3=1,2
      do i4=1,2
* TsT -- aa=cline_3forks_78(i1,i2,i5,i6,i3,i4).a,bb=cline_3forks_78(i1,i
* 2,i5,i6,i3,i4).b,cc=cline_3forks_78(i1,i2,i5,i6,i3,i4).c,dd=cline_3for
* ks_78(i1,i2,i5,i6,i3,i4).d,a1=u7_1256(i1,i2,i5,i6).a,b1=u7_1256(i1,i2,
* i5,i6).b,c1=u7_1256(i1,i2,i5,i6).c,d1=u7_1256(i1,i2,i5,i6).d,a2=r8_34(
* i3,i4).a,b2=r8_34(i3,i4).b,c2=r8_34(i3,i4).c,d2=r8_34(i3,i4).d,prq=p83
* 4q,m=rmass(id7),nsum=0
      do iut=1,2
      cx1=u7_1256(i1,i2,i5,i6).a(iut,1)+u7_1256(i1,i2,i5,i6).c(i
     & ut,1)*rmass(id7)
      cx2=u7_1256(i1,i2,i5,i6).c(iut,2)*p834q+u7_1256(i1,i2,i5,i
     & 6).a(iut,2)*rmass(id7)
      cy1=u7_1256(i1,i2,i5,i6).b(iut,1)+u7_1256(i1,i2,i5,i6).d(i
     & ut,1)*rmass(id7)
      cy2=u7_1256(i1,i2,i5,i6).d(iut,2)*p834q+u7_1256(i1,i2,i5,i
     & 6).b(iut,2)*rmass(id7)
      cw1=u7_1256(i1,i2,i5,i6).c(iut,1)*p834q+u7_1256(i1,i2,i5,i
     & 6).a(iut,1)*rmass(id7)
      cw2=u7_1256(i1,i2,i5,i6).a(iut,2)+u7_1256(i1,i2,i5,i6).c(i
     & ut,2)*rmass(id7)
      cz1=u7_1256(i1,i2,i5,i6).d(iut,1)*p834q+u7_1256(i1,i2,i5,i
     & 6).b(iut,1)*rmass(id7)
      cz2=u7_1256(i1,i2,i5,i6).b(iut,2)+u7_1256(i1,i2,i5,i6).d(i
     & ut,2)*rmass(id7)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).a(iut,1)=cx1*r8_34(i3,i
     & 4).a(1,1)+cx2*r8_34(i3,i4).b(2,1)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).b(iut,1)=cy1*r8_34(i3,i
     & 4).a(1,1)+cy2*r8_34(i3,i4).b(2,1)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).c(iut,1)=cw1*r8_34(i3,i
     & 4).d(1,1)+cw2*r8_34(i3,i4).c(2,1)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).d(iut,1)=cz1*r8_34(i3,i
     & 4).d(1,1)+cz2*r8_34(i3,i4).c(2,1)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).a(iut,2)=cw1*r8_34(i3,i
     & 4).b(1,2)+cw2*r8_34(i3,i4).a(2,2)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).b(iut,2)=cz1*r8_34(i3,i
     & 4).b(1,2)+cz2*r8_34(i3,i4).a(2,2)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).c(iut,2)=cx1*r8_34(i3,i
     & 4).c(1,2)+cx2*r8_34(i3,i4).d(2,2)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).d(iut,2)=cy1*r8_34(i3,i
     & 4).c(1,2)+cy2*r8_34(i3,i4).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
   	
      else
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
      do i3=1,2
      do i4=1,2
* TsTs -- aa=cline_3forks_78(i1,i2,i5,i6,i3,i4).a,bb=cline_3forks_78(i1,
* i2,i5,i6,i3,i4).b,cc=cline_3forks_78(i1,i2,i5,i6,i3,i4).c,dd=cline_3fo
* rks_78(i1,i2,i5,i6,i3,i4).d,a1=u7_1256(i1,i2,i5,i6).a,b1=u7_1256(i1,i2
* ,i5,i6).b,c1=u7_1256(i1,i2,i5,i6).c,d1=u7_1256(i1,i2,i5,i6).d,a2=r8_34
* (i3,i4).a,b2=r8_34(i3,i4).b,c2=r8_34(i3,i4).c,d2=r8_34(i3,i4).d,prq=p8
* 34q,m=rmass(id7),nsum=0
      do iut=1,2
      do jut=1,2
      cx1=r8_34(i3,i4).a(1,jut)+rmass(id7)*r8_34(i3,i4).b(1,jut)
      cx2=r8_34(i3,i4).a(2,jut)+rmass(id7)*r8_34(i3,i4).b(2,jut)
      cy1=p834q*r8_34(i3,i4).b(1,jut)+rmass(id7)*r8_34(i3,i4).a(
     & 1,jut)
      cy2=p834q*r8_34(i3,i4).b(2,jut)+rmass(id7)*r8_34(i3,i4).a(
     & 2,jut)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).a(iut,jut)=u7_1256(i1,i
     & 2,i5,i6).a(iut,1)*cx1+u7_1256(i1,i2,i5,i6).c(iut,1)*cy1+u
     & 7_1256(i1,i2,i5,i6).a(iut,2)*cx2+u7_1256(i1,i2,i5,i6).c(i
     & ut,2)*cy2
      cline_3forks_78(i1,i2,i5,i6,i3,i4).b(iut,jut)=u7_1256(i1,i
     & 2,i5,i6).b(iut,1)*cx1+u7_1256(i1,i2,i5,i6).d(iut,1)*cy1+u
     & 7_1256(i1,i2,i5,i6).b(iut,2)*cx2+u7_1256(i1,i2,i5,i6).d(i
     & ut,2)*cy2
      cw1=r8_34(i3,i4).c(1,jut)+rmass(id7)*r8_34(i3,i4).d(1,jut)
      cw2=r8_34(i3,i4).c(2,jut)+rmass(id7)*r8_34(i3,i4).d(2,jut)
      cz1=p834q*r8_34(i3,i4).d(1,jut)+rmass(id7)*r8_34(i3,i4).c(
     & 1,jut)
      cz2=p834q*r8_34(i3,i4).d(2,jut)+rmass(id7)*r8_34(i3,i4).c(
     & 2,jut)
      cline_3forks_78(i1,i2,i5,i6,i3,i4).c(iut,jut)=u7_1256(i1,i
     & 2,i5,i6).a(iut,1)*cw1+u7_1256(i1,i2,i5,i6).c(iut,1)*cz1+u
     & 7_1256(i1,i2,i5,i6).a(iut,2)*cw2+u7_1256(i1,i2,i5,i6).c(i
     & ut,2)*cz2
      cline_3forks_78(i1,i2,i5,i6,i3,i4).d(iut,jut)=u7_1256(i1,i
     & 2,i5,i6).b(iut,1)*cw1+u7_1256(i1,i2,i5,i6).d(iut,1)*cz1+u
     & 7_1256(i1,i2,i5,i6).b(iut,2)*cw2+u7_1256(i1,i2,i5,i6).d(i
     & ut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
        	
  
  
      endif	
  
  
      rmassl=rmass(id7)
      rmassr=-rmassl
  
      do i1=1,2
      do i2=1,2
      do i5=1,2
      do i6=1,2
      do i3=1,2
      do i4=1,2
* mline -- res=cres_3forks_78(i1,i2,i5,i6,i3,i4).pol(&1,&2),abcd=cline_3
* forks_78(i1,i2,i5,i6,i3,i4).,m1=rmassl,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cres_3forks_78(i1,i2,i5,i6,i3,i4).pol(iut,jut)=cline_3fork
     & s_78(i1,i2,i5,i6,i3,i4).a(iut,jut)+rmassl*cline_3forks_78
     & (i1,i2,i5,i6,i3,i4).b(iut,jut)+rmassr*cline_3forks_78(i1,
     & i2,i5,i6,i3,i4).c(iut,jut)+rmassl*rmassr*cline_3forks_78(
     & i1,i2,i5,i6,i3,i4).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
      end do
      end do
      end do
  
      do i1=1,2
       do i2=1,2
        do i3=1,2
         do i4=1,2
          do i5=1,2
           do i6=1,2
            do i7=1,2
             do i8=1,2
                        	
            cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &      cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &      cres_3forks_78(i1,i2,i5,i6,i3,i4).pol(i7,i8)
  
             enddo
            enddo		
           enddo
          enddo
         enddo
        enddo	
       enddo
      enddo
  
  
  
  
  
  
  
      if(id7.ne.5)then
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i1=1,2
      do i2=1,2
* TT -- aa=cline_3forks_78(i3,i4,i5,i6,i1,i2).a,bb=cline_3forks_78(i3,i4
* ,i5,i6,i1,i2).b,cc=cline_3forks_78(i3,i4,i5,i6,i1,i2).c,dd=cline_3fork
* s_78(i3,i4,i5,i6,i1,i2).d,a1=u7_3456(i3,i4,i5,i6).a,b1=u7_3456(i3,i4,i
* 5,i6).b,c1=u7_3456(i3,i4,i5,i6).c,d1=u7_3456(i3,i4,i5,i6).d,a2=r8_12(i
* 1,i2).a,b2=r8_12(i1,i2).b,c2=r8_12(i1,i2).c,d2=r8_12(i1,i2).d,prq=p812
* q,m=rmass(id7),nsum=0
      cline_3forks_78(i3,i4,i5,i6,i1,i2).a(1,1)=u7_3456(i3,i4,i5
     & ,i6).a(1,1)*r8_12(i1,i2).a(1,1)+u7_3456(i3,i4,i5,i6).c(1,
     & 2)*p812q*r8_12(i1,i2).b(2,1)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).b(1,1)=rmass(id7)*(u7_3
     & 456(i3,i4,i5,i6).d(1,1)*r8_12(i1,i2).a(1,1)+u7_3456(i3,i4
     & ,i5,i6).b(1,2)*r8_12(i1,i2).b(2,1))
      cline_3forks_78(i3,i4,i5,i6,i1,i2).c(1,1)=rmass(id7)*(u7_3
     & 456(i3,i4,i5,i6).a(1,1)*r8_12(i1,i2).d(1,1)+u7_3456(i3,i4
     & ,i5,i6).c(1,2)*r8_12(i1,i2).c(2,1))
      cline_3forks_78(i3,i4,i5,i6,i1,i2).d(1,1)=u7_3456(i3,i4,i5
     & ,i6).d(1,1)*p812q*r8_12(i1,i2).d(1,1)+u7_3456(i3,i4,i5,i6
     & ).b(1,2)*r8_12(i1,i2).c(2,1)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).a(1,2)=rmass(id7)*(u7_3
     & 456(i3,i4,i5,i6).a(1,1)*r8_12(i1,i2).b(1,2)+u7_3456(i3,i4
     & ,i5,i6).c(1,2)*r8_12(i1,i2).a(2,2))
      cline_3forks_78(i3,i4,i5,i6,i1,i2).b(1,2)=u7_3456(i3,i4,i5
     & ,i6).d(1,1)*p812q*r8_12(i1,i2).b(1,2)+u7_3456(i3,i4,i5,i6
     & ).b(1,2)*r8_12(i1,i2).a(2,2)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).c(1,2)=u7_3456(i3,i4,i5
     & ,i6).a(1,1)*r8_12(i1,i2).c(1,2)+u7_3456(i3,i4,i5,i6).c(1,
     & 2)*p812q*r8_12(i1,i2).d(2,2)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).d(1,2)=rmass(id7)*(u7_3
     & 456(i3,i4,i5,i6).d(1,1)*r8_12(i1,i2).c(1,2)+u7_3456(i3,i4
     & ,i5,i6).b(1,2)*r8_12(i1,i2).d(2,2))
      cline_3forks_78(i3,i4,i5,i6,i1,i2).a(2,1)=rmass(id7)*(u7_3
     & 456(i3,i4,i5,i6).c(2,1)*r8_12(i1,i2).a(1,1)+u7_3456(i3,i4
     & ,i5,i6).a(2,2)*r8_12(i1,i2).b(2,1))
      cline_3forks_78(i3,i4,i5,i6,i1,i2).b(2,1)=u7_3456(i3,i4,i5
     & ,i6).b(2,1)*r8_12(i1,i2).a(1,1)+u7_3456(i3,i4,i5,i6).d(2,
     & 2)*p812q*r8_12(i1,i2).b(2,1)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).c(2,1)=u7_3456(i3,i4,i5
     & ,i6).c(2,1)*p812q*r8_12(i1,i2).d(1,1)+u7_3456(i3,i4,i5,i6
     & ).a(2,2)*r8_12(i1,i2).c(2,1)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).d(2,1)=rmass(id7)*(u7_3
     & 456(i3,i4,i5,i6).b(2,1)*r8_12(i1,i2).d(1,1)+u7_3456(i3,i4
     & ,i5,i6).d(2,2)*r8_12(i1,i2).c(2,1))
      cline_3forks_78(i3,i4,i5,i6,i1,i2).a(2,2)=u7_3456(i3,i4,i5
     & ,i6).c(2,1)*p812q*r8_12(i1,i2).b(1,2)+u7_3456(i3,i4,i5,i6
     & ).a(2,2)*r8_12(i1,i2).a(2,2)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).b(2,2)=rmass(id7)*(u7_3
     & 456(i3,i4,i5,i6).b(2,1)*r8_12(i1,i2).b(1,2)+u7_3456(i3,i4
     & ,i5,i6).d(2,2)*r8_12(i1,i2).a(2,2))
      cline_3forks_78(i3,i4,i5,i6,i1,i2).c(2,2)=rmass(id7)*(u7_3
     & 456(i3,i4,i5,i6).c(2,1)*r8_12(i1,i2).c(1,2)+u7_3456(i3,i4
     & ,i5,i6).a(2,2)*r8_12(i1,i2).d(2,2))
      cline_3forks_78(i3,i4,i5,i6,i1,i2).d(2,2)=u7_3456(i3,i4,i5
     & ,i6).b(2,1)*r8_12(i1,i2).c(1,2)+u7_3456(i3,i4,i5,i6).d(2,
     & 2)*p812q*r8_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
  
      else
  
         if(id7.eq.5.and.id1.ne.5)then
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i1=1,2
      do i2=1,2
* TsT -- aa=cline_3forks_78(i3,i4,i5,i6,i1,i2).a,bb=cline_3forks_78(i3,i
* 4,i5,i6,i1,i2).b,cc=cline_3forks_78(i3,i4,i5,i6,i1,i2).c,dd=cline_3for
* ks_78(i3,i4,i5,i6,i1,i2).d,a1=u7_3456(i3,i4,i5,i6).a,b1=u7_3456(i3,i4,
* i5,i6).b,c1=u7_3456(i3,i4,i5,i6).c,d1=u7_3456(i3,i4,i5,i6).d,a2=r8_12(
* i1,i2).a,b2=r8_12(i1,i2).b,c2=r8_12(i1,i2).c,d2=r8_12(i1,i2).d,prq=p81
* 2q,m=rmass(id7),nsum=0
      do iut=1,2
      cx1=u7_3456(i3,i4,i5,i6).a(iut,1)+u7_3456(i3,i4,i5,i6).c(i
     & ut,1)*rmass(id7)
      cx2=u7_3456(i3,i4,i5,i6).c(iut,2)*p812q+u7_3456(i3,i4,i5,i
     & 6).a(iut,2)*rmass(id7)
      cy1=u7_3456(i3,i4,i5,i6).b(iut,1)+u7_3456(i3,i4,i5,i6).d(i
     & ut,1)*rmass(id7)
      cy2=u7_3456(i3,i4,i5,i6).d(iut,2)*p812q+u7_3456(i3,i4,i5,i
     & 6).b(iut,2)*rmass(id7)
      cw1=u7_3456(i3,i4,i5,i6).c(iut,1)*p812q+u7_3456(i3,i4,i5,i
     & 6).a(iut,1)*rmass(id7)
      cw2=u7_3456(i3,i4,i5,i6).a(iut,2)+u7_3456(i3,i4,i5,i6).c(i
     & ut,2)*rmass(id7)
      cz1=u7_3456(i3,i4,i5,i6).d(iut,1)*p812q+u7_3456(i3,i4,i5,i
     & 6).b(iut,1)*rmass(id7)
      cz2=u7_3456(i3,i4,i5,i6).b(iut,2)+u7_3456(i3,i4,i5,i6).d(i
     & ut,2)*rmass(id7)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).a(iut,1)=cx1*r8_12(i1,i
     & 2).a(1,1)+cx2*r8_12(i1,i2).b(2,1)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).b(iut,1)=cy1*r8_12(i1,i
     & 2).a(1,1)+cy2*r8_12(i1,i2).b(2,1)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).c(iut,1)=cw1*r8_12(i1,i
     & 2).d(1,1)+cw2*r8_12(i1,i2).c(2,1)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).d(iut,1)=cz1*r8_12(i1,i
     & 2).d(1,1)+cz2*r8_12(i1,i2).c(2,1)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).a(iut,2)=cw1*r8_12(i1,i
     & 2).b(1,2)+cw2*r8_12(i1,i2).a(2,2)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).b(iut,2)=cz1*r8_12(i1,i
     & 2).b(1,2)+cz2*r8_12(i1,i2).a(2,2)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).c(iut,2)=cx1*r8_12(i1,i
     & 2).c(1,2)+cx2*r8_12(i1,i2).d(2,2)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).d(iut,2)=cy1*r8_12(i1,i
     & 2).c(1,2)+cy2*r8_12(i1,i2).d(2,2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
   	
      else
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i1=1,2
      do i2=1,2
* TsTs -- aa=cline_3forks_78(i3,i4,i5,i6,i1,i2).a,bb=cline_3forks_78(i3,
* i4,i5,i6,i1,i2).b,cc=cline_3forks_78(i3,i4,i5,i6,i1,i2).c,dd=cline_3fo
* rks_78(i3,i4,i5,i6,i1,i2).d,a1=u7_3456(i3,i4,i5,i6).a,b1=u7_3456(i3,i4
* ,i5,i6).b,c1=u7_3456(i3,i4,i5,i6).c,d1=u7_3456(i3,i4,i5,i6).d,a2=r8_12
* (i1,i2).a,b2=r8_12(i1,i2).b,c2=r8_12(i1,i2).c,d2=r8_12(i1,i2).d,prq=p8
* 12q,m=rmass(id7),nsum=0
      do iut=1,2
      do jut=1,2
      cx1=r8_12(i1,i2).a(1,jut)+rmass(id7)*r8_12(i1,i2).b(1,jut)
      cx2=r8_12(i1,i2).a(2,jut)+rmass(id7)*r8_12(i1,i2).b(2,jut)
      cy1=p812q*r8_12(i1,i2).b(1,jut)+rmass(id7)*r8_12(i1,i2).a(
     & 1,jut)
      cy2=p812q*r8_12(i1,i2).b(2,jut)+rmass(id7)*r8_12(i1,i2).a(
     & 2,jut)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).a(iut,jut)=u7_3456(i3,i
     & 4,i5,i6).a(iut,1)*cx1+u7_3456(i3,i4,i5,i6).c(iut,1)*cy1+u
     & 7_3456(i3,i4,i5,i6).a(iut,2)*cx2+u7_3456(i3,i4,i5,i6).c(i
     & ut,2)*cy2
      cline_3forks_78(i3,i4,i5,i6,i1,i2).b(iut,jut)=u7_3456(i3,i
     & 4,i5,i6).b(iut,1)*cx1+u7_3456(i3,i4,i5,i6).d(iut,1)*cy1+u
     & 7_3456(i3,i4,i5,i6).b(iut,2)*cx2+u7_3456(i3,i4,i5,i6).d(i
     & ut,2)*cy2
      cw1=r8_12(i1,i2).c(1,jut)+rmass(id7)*r8_12(i1,i2).d(1,jut)
      cw2=r8_12(i1,i2).c(2,jut)+rmass(id7)*r8_12(i1,i2).d(2,jut)
      cz1=p812q*r8_12(i1,i2).d(1,jut)+rmass(id7)*r8_12(i1,i2).c(
     & 1,jut)
      cz2=p812q*r8_12(i1,i2).d(2,jut)+rmass(id7)*r8_12(i1,i2).c(
     & 2,jut)
      cline_3forks_78(i3,i4,i5,i6,i1,i2).c(iut,jut)=u7_3456(i3,i
     & 4,i5,i6).a(iut,1)*cw1+u7_3456(i3,i4,i5,i6).c(iut,1)*cz1+u
     & 7_3456(i3,i4,i5,i6).a(iut,2)*cw2+u7_3456(i3,i4,i5,i6).c(i
     & ut,2)*cz2
      cline_3forks_78(i3,i4,i5,i6,i1,i2).d(iut,jut)=u7_3456(i3,i
     & 4,i5,i6).b(iut,1)*cw1+u7_3456(i3,i4,i5,i6).d(iut,1)*cz1+u
     & 7_3456(i3,i4,i5,i6).b(iut,2)*cw2+u7_3456(i3,i4,i5,i6).d(i
     & ut,2)*cz2
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
        endif
        	
  
  
      endif	
  
  
      rmassl=rmass(id7)
      rmassr=-rmassl
  
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i1=1,2
      do i2=1,2
* mline -- res=cres_3forks_78(i3,i4,i5,i6,i1,i2).pol(&1,&2),abcd=cline_3
* forks_78(i3,i4,i5,i6,i1,i2).,m1=rmassl,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cres_3forks_78(i3,i4,i5,i6,i1,i2).pol(iut,jut)=cline_3fork
     & s_78(i3,i4,i5,i6,i1,i2).a(iut,jut)+rmassl*cline_3forks_78
     & (i3,i4,i5,i6,i1,i2).b(iut,jut)+rmassr*cline_3forks_78(i3,
     & i4,i5,i6,i1,i2).c(iut,jut)+rmassl*rmassr*cline_3forks_78(
     & i3,i4,i5,i6,i1,i2).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
      end do
      end do
      end do
  
      do i1=1,2
       do i2=1,2
        do i3=1,2
         do i4=1,2
          do i5=1,2
           do i6=1,2
            do i7=1,2
             do i8=1,2
                        	
            cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &      cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &      cres_3forks_78(i3,i4,i5,i6,i1,i2).pol(i7,i8)
  
             enddo
            enddo		
           enddo
          enddo
         enddo
        enddo	
       enddo
      enddo
  
  
  
  
  
  
  
  
* COMPUTE ALL SINGLE INSERTIONS OF THE TYPE LZI_ AND LFI_ (I=1,3,5,7)   
*    to a Zline                                                         
*                                                                       
*        i __              i __                                         
*            |_Z__(mu)         |__f__(mu)                               
*            |                 |                                        
  
  
* quqd -- p=p1,q=p234
      quqd=p1(0)*p234(0)-p1(1)*p234(1)-p1(2)*p234(2)-p1(3)*p234(
     & 3)
* T -- qu=p1,qd=p234,v=0,a=lz1_234(0).a,b=lz1_234(0).b,c=lz1_234(0).c,d=
* lz1_234(0).d,cr=zcr(id1),cl=zcl(id1),nsum=0
      eps_0=-p1(2)*p234(3)+p234(2)*p1(3)
      ceps_0=eps_0*cim
      ceps_1=p1(3)*cim
      ceps_2=p234(3)*cim
      auxa=-quqd+p1k0*p234(0)+p234k0*p1(0)
      lz1_234(0).a(1,1)=zcr(id1)*(auxa+ceps_0)
      lz1_234(0).a(2,2)=zcl(id1)*(auxa-ceps_0)
      lz1_234(0).b(1,2)=-zcl(id1)*(p234(2)+ceps_2)
      lz1_234(0).b(2,1)=zcr(id1)*(p234(2)-ceps_2)
      lz1_234(0).c(1,2)=zcr(id1)*(p1(2)+ceps_1)
      lz1_234(0).c(2,1)=zcl(id1)*(-p1(2)+ceps_1)
      lz1_234(0).d(1,1)=zcl(id1)
      lz1_234(0).d(2,2)=zcr(id1)
* T -- qu=p1,qd=p234,v=1,a=lz1_234(1).a,b=lz1_234(1).b,c=lz1_234(1).c,d=
* lz1_234(1).d,cr=zcr(id1),cl=zcl(id1),nsum=0
      auxa=-quqd+p1k0*p234(1)+p234k0*p1(1)
      lz1_234(1).a(1,1)=zcr(id1)*(auxa+ceps_0)
      lz1_234(1).a(2,2)=zcl(id1)*(auxa-ceps_0)
      lz1_234(1).b(1,2)=-zcl(id1)*(p234(2)+ceps_2)
      lz1_234(1).b(2,1)=zcr(id1)*(p234(2)-ceps_2)
      lz1_234(1).c(1,2)=zcr(id1)*(p1(2)+ceps_1)
      lz1_234(1).c(2,1)=zcl(id1)*(-p1(2)+ceps_1)
      lz1_234(1).d(1,1)=zcl(id1)
      lz1_234(1).d(2,2)=zcr(id1)
* T -- qu=p1,qd=p234,v=2,a=lz1_234(2).a,b=lz1_234(2).b,c=lz1_234(2).c,d=
* lz1_234(2).d,cr=zcr(id1),cl=zcl(id1),nsum=0
      eps_0=-p1k0*p234(3)+p234k0*p1(3)
      ceps_0=eps_0*cim
      auxa=p1k0*p234(2)+p234k0*p1(2)
      lz1_234(2).a(1,1)=zcr(id1)*(auxa+ceps_0)
      lz1_234(2).a(2,2)=zcl(id1)*(auxa-ceps_0)
      lz1_234(2).b(1,2)=-zcl(id1)*p234k0
      lz1_234(2).b(2,1)=zcr(id1)*p234k0
      lz1_234(2).c(1,2)=zcr(id1)*p1k0
      lz1_234(2).c(2,1)=-zcl(id1)*p1k0
* T -- qu=p1,qd=p234,v=3,a=lz1_234(3).a,b=lz1_234(3).b,c=lz1_234(3).c,d=
* lz1_234(3).d,cr=zcr(id1),cl=zcl(id1),nsum=0
      eps_0=p1k0*p234(2)-p234k0*p1(2)
      ceps_0=eps_0*cim
      ceps_1=p1k0*cim
      ceps_2=p234k0*cim
      auxa=+p1k0*p234(3)+p234k0*p1(3)
      lz1_234(3).a(1,1)=zcr(id1)*(auxa+ceps_0)
      lz1_234(3).a(2,2)=zcl(id1)*(auxa-ceps_0)
      lz1_234(3).b(1,2)=-zcl(id1)*ceps_2
      lz1_234(3).b(2,1)=-zcr(id1)*ceps_2
      lz1_234(3).c(1,2)=zcr(id1)*ceps_1
      lz1_234(3).c(2,1)=zcl(id1)*ceps_1
  
* T -- qu=p1,qd=p234,v=0,a=lf1_234(0).a,b=lf1_234(0).b,c=lf1_234(0).c,d=
* lf1_234(0).d,cr=fcr(id1),cl=fcl(id1),nsum=0
      eps_0=-p1(2)*p234(3)+p234(2)*p1(3)
      ceps_0=eps_0*cim
      ceps_1=p1(3)*cim
      ceps_2=p234(3)*cim
      auxa=-quqd+p1k0*p234(0)+p234k0*p1(0)
      lf1_234(0).a(1,1)=fcr(id1)*(auxa+ceps_0)
      lf1_234(0).a(2,2)=fcl(id1)*(auxa-ceps_0)
      lf1_234(0).b(1,2)=-fcl(id1)*(p234(2)+ceps_2)
      lf1_234(0).b(2,1)=fcr(id1)*(p234(2)-ceps_2)
      lf1_234(0).c(1,2)=fcr(id1)*(p1(2)+ceps_1)
      lf1_234(0).c(2,1)=fcl(id1)*(-p1(2)+ceps_1)
      lf1_234(0).d(1,1)=fcl(id1)
      lf1_234(0).d(2,2)=fcr(id1)
* T -- qu=p1,qd=p234,v=1,a=lf1_234(1).a,b=lf1_234(1).b,c=lf1_234(1).c,d=
* lf1_234(1).d,cr=fcr(id1),cl=fcl(id1),nsum=0
      auxa=-quqd+p1k0*p234(1)+p234k0*p1(1)
      lf1_234(1).a(1,1)=fcr(id1)*(auxa+ceps_0)
      lf1_234(1).a(2,2)=fcl(id1)*(auxa-ceps_0)
      lf1_234(1).b(1,2)=-fcl(id1)*(p234(2)+ceps_2)
      lf1_234(1).b(2,1)=fcr(id1)*(p234(2)-ceps_2)
      lf1_234(1).c(1,2)=fcr(id1)*(p1(2)+ceps_1)
      lf1_234(1).c(2,1)=fcl(id1)*(-p1(2)+ceps_1)
      lf1_234(1).d(1,1)=fcl(id1)
      lf1_234(1).d(2,2)=fcr(id1)
* T -- qu=p1,qd=p234,v=2,a=lf1_234(2).a,b=lf1_234(2).b,c=lf1_234(2).c,d=
* lf1_234(2).d,cr=fcr(id1),cl=fcl(id1),nsum=0
      eps_0=-p1k0*p234(3)+p234k0*p1(3)
      ceps_0=eps_0*cim
      auxa=p1k0*p234(2)+p234k0*p1(2)
      lf1_234(2).a(1,1)=fcr(id1)*(auxa+ceps_0)
      lf1_234(2).a(2,2)=fcl(id1)*(auxa-ceps_0)
      lf1_234(2).b(1,2)=-fcl(id1)*p234k0
      lf1_234(2).b(2,1)=fcr(id1)*p234k0
      lf1_234(2).c(1,2)=fcr(id1)*p1k0
      lf1_234(2).c(2,1)=-fcl(id1)*p1k0
* T -- qu=p1,qd=p234,v=3,a=lf1_234(3).a,b=lf1_234(3).b,c=lf1_234(3).c,d=
* lf1_234(3).d,cr=fcr(id1),cl=fcl(id1),nsum=0
      eps_0=p1k0*p234(2)-p234k0*p1(2)
      ceps_0=eps_0*cim
      ceps_1=p1k0*cim
      ceps_2=p234k0*cim
      auxa=+p1k0*p234(3)+p234k0*p1(3)
      lf1_234(3).a(1,1)=fcr(id1)*(auxa+ceps_0)
      lf1_234(3).a(2,2)=fcl(id1)*(auxa-ceps_0)
      lf1_234(3).b(1,2)=-fcl(id1)*ceps_2
      lf1_234(3).b(2,1)=-fcr(id1)*ceps_2
      lf1_234(3).c(1,2)=fcr(id1)*ceps_1
      lf1_234(3).c(2,1)=fcl(id1)*ceps_1
  
* quqd -- p=p1,q=p256
      quqd=p1(0)*p256(0)-p1(1)*p256(1)-p1(2)*p256(2)-p1(3)*p256(
     & 3)
* T -- qu=p1,qd=p256,v=0,a=lz1_256(0).a,b=lz1_256(0).b,c=lz1_256(0).c,d=
* lz1_256(0).d,cr=zcr(id1),cl=zcl(id1),nsum=0
      eps_0=-p1(2)*p256(3)+p256(2)*p1(3)
      ceps_0=eps_0*cim
      ceps_1=p1(3)*cim
      ceps_2=p256(3)*cim
      auxa=-quqd+p1k0*p256(0)+p256k0*p1(0)
      lz1_256(0).a(1,1)=zcr(id1)*(auxa+ceps_0)
      lz1_256(0).a(2,2)=zcl(id1)*(auxa-ceps_0)
      lz1_256(0).b(1,2)=-zcl(id1)*(p256(2)+ceps_2)
      lz1_256(0).b(2,1)=zcr(id1)*(p256(2)-ceps_2)
      lz1_256(0).c(1,2)=zcr(id1)*(p1(2)+ceps_1)
      lz1_256(0).c(2,1)=zcl(id1)*(-p1(2)+ceps_1)
      lz1_256(0).d(1,1)=zcl(id1)
      lz1_256(0).d(2,2)=zcr(id1)
* T -- qu=p1,qd=p256,v=1,a=lz1_256(1).a,b=lz1_256(1).b,c=lz1_256(1).c,d=
* lz1_256(1).d,cr=zcr(id1),cl=zcl(id1),nsum=0
      auxa=-quqd+p1k0*p256(1)+p256k0*p1(1)
      lz1_256(1).a(1,1)=zcr(id1)*(auxa+ceps_0)
      lz1_256(1).a(2,2)=zcl(id1)*(auxa-ceps_0)
      lz1_256(1).b(1,2)=-zcl(id1)*(p256(2)+ceps_2)
      lz1_256(1).b(2,1)=zcr(id1)*(p256(2)-ceps_2)
      lz1_256(1).c(1,2)=zcr(id1)*(p1(2)+ceps_1)
      lz1_256(1).c(2,1)=zcl(id1)*(-p1(2)+ceps_1)
      lz1_256(1).d(1,1)=zcl(id1)
      lz1_256(1).d(2,2)=zcr(id1)
* T -- qu=p1,qd=p256,v=2,a=lz1_256(2).a,b=lz1_256(2).b,c=lz1_256(2).c,d=
* lz1_256(2).d,cr=zcr(id1),cl=zcl(id1),nsum=0
      eps_0=-p1k0*p256(3)+p256k0*p1(3)
      ceps_0=eps_0*cim
      auxa=p1k0*p256(2)+p256k0*p1(2)
      lz1_256(2).a(1,1)=zcr(id1)*(auxa+ceps_0)
      lz1_256(2).a(2,2)=zcl(id1)*(auxa-ceps_0)
      lz1_256(2).b(1,2)=-zcl(id1)*p256k0
      lz1_256(2).b(2,1)=zcr(id1)*p256k0
      lz1_256(2).c(1,2)=zcr(id1)*p1k0
      lz1_256(2).c(2,1)=-zcl(id1)*p1k0
* T -- qu=p1,qd=p256,v=3,a=lz1_256(3).a,b=lz1_256(3).b,c=lz1_256(3).c,d=
* lz1_256(3).d,cr=zcr(id1),cl=zcl(id1),nsum=0
      eps_0=p1k0*p256(2)-p256k0*p1(2)
      ceps_0=eps_0*cim
      ceps_1=p1k0*cim
      ceps_2=p256k0*cim
      auxa=+p1k0*p256(3)+p256k0*p1(3)
      lz1_256(3).a(1,1)=zcr(id1)*(auxa+ceps_0)
      lz1_256(3).a(2,2)=zcl(id1)*(auxa-ceps_0)
      lz1_256(3).b(1,2)=-zcl(id1)*ceps_2
      lz1_256(3).b(2,1)=-zcr(id1)*ceps_2
      lz1_256(3).c(1,2)=zcr(id1)*ceps_1
      lz1_256(3).c(2,1)=zcl(id1)*ceps_1
  
* T -- qu=p1,qd=p256,v=0,a=lf1_256(0).a,b=lf1_256(0).b,c=lf1_256(0).c,d=
* lf1_256(0).d,cr=fcr(id1),cl=fcl(id1),nsum=0
      eps_0=-p1(2)*p256(3)+p256(2)*p1(3)
      ceps_0=eps_0*cim
      ceps_1=p1(3)*cim
      ceps_2=p256(3)*cim
      auxa=-quqd+p1k0*p256(0)+p256k0*p1(0)
      lf1_256(0).a(1,1)=fcr(id1)*(auxa+ceps_0)
      lf1_256(0).a(2,2)=fcl(id1)*(auxa-ceps_0)
      lf1_256(0).b(1,2)=-fcl(id1)*(p256(2)+ceps_2)
      lf1_256(0).b(2,1)=fcr(id1)*(p256(2)-ceps_2)
      lf1_256(0).c(1,2)=fcr(id1)*(p1(2)+ceps_1)
      lf1_256(0).c(2,1)=fcl(id1)*(-p1(2)+ceps_1)
      lf1_256(0).d(1,1)=fcl(id1)
      lf1_256(0).d(2,2)=fcr(id1)
* T -- qu=p1,qd=p256,v=1,a=lf1_256(1).a,b=lf1_256(1).b,c=lf1_256(1).c,d=
* lf1_256(1).d,cr=fcr(id1),cl=fcl(id1),nsum=0
      auxa=-quqd+p1k0*p256(1)+p256k0*p1(1)
      lf1_256(1).a(1,1)=fcr(id1)*(auxa+ceps_0)
      lf1_256(1).a(2,2)=fcl(id1)*(auxa-ceps_0)
      lf1_256(1).b(1,2)=-fcl(id1)*(p256(2)+ceps_2)
      lf1_256(1).b(2,1)=fcr(id1)*(p256(2)-ceps_2)
      lf1_256(1).c(1,2)=fcr(id1)*(p1(2)+ceps_1)
      lf1_256(1).c(2,1)=fcl(id1)*(-p1(2)+ceps_1)
      lf1_256(1).d(1,1)=fcl(id1)
      lf1_256(1).d(2,2)=fcr(id1)
* T -- qu=p1,qd=p256,v=2,a=lf1_256(2).a,b=lf1_256(2).b,c=lf1_256(2).c,d=
* lf1_256(2).d,cr=fcr(id1),cl=fcl(id1),nsum=0
      eps_0=-p1k0*p256(3)+p256k0*p1(3)
      ceps_0=eps_0*cim
      auxa=p1k0*p256(2)+p256k0*p1(2)
      lf1_256(2).a(1,1)=fcr(id1)*(auxa+ceps_0)
      lf1_256(2).a(2,2)=fcl(id1)*(auxa-ceps_0)
      lf1_256(2).b(1,2)=-fcl(id1)*p256k0
      lf1_256(2).b(2,1)=fcr(id1)*p256k0
      lf1_256(2).c(1,2)=fcr(id1)*p1k0
      lf1_256(2).c(2,1)=-fcl(id1)*p1k0
* T -- qu=p1,qd=p256,v=3,a=lf1_256(3).a,b=lf1_256(3).b,c=lf1_256(3).c,d=
* lf1_256(3).d,cr=fcr(id1),cl=fcl(id1),nsum=0
      eps_0=p1k0*p256(2)-p256k0*p1(2)
      ceps_0=eps_0*cim
      ceps_1=p1k0*cim
      ceps_2=p256k0*cim
      auxa=+p1k0*p256(3)+p256k0*p1(3)
      lf1_256(3).a(1,1)=fcr(id1)*(auxa+ceps_0)
      lf1_256(3).a(2,2)=fcl(id1)*(auxa-ceps_0)
      lf1_256(3).b(1,2)=-fcl(id1)*ceps_2
      lf1_256(3).b(2,1)=-fcr(id1)*ceps_2
      lf1_256(3).c(1,2)=fcr(id1)*ceps_1
      lf1_256(3).c(2,1)=fcl(id1)*ceps_1
  
* quqd -- p=p1,q=p278
      quqd=p1(0)*p278(0)-p1(1)*p278(1)-p1(2)*p278(2)-p1(3)*p278(
     & 3)
* T -- qu=p1,qd=p278,v=0,a=lz1_278(0).a,b=lz1_278(0).b,c=lz1_278(0).c,d=
* lz1_278(0).d,cr=zcr(id1),cl=zcl(id1),nsum=0
      eps_0=-p1(2)*p278(3)+p278(2)*p1(3)
      ceps_0=eps_0*cim
      ceps_1=p1(3)*cim
      ceps_2=p278(3)*cim
      auxa=-quqd+p1k0*p278(0)+p278k0*p1(0)
      lz1_278(0).a(1,1)=zcr(id1)*(auxa+ceps_0)
      lz1_278(0).a(2,2)=zcl(id1)*(auxa-ceps_0)
      lz1_278(0).b(1,2)=-zcl(id1)*(p278(2)+ceps_2)
      lz1_278(0).b(2,1)=zcr(id1)*(p278(2)-ceps_2)
      lz1_278(0).c(1,2)=zcr(id1)*(p1(2)+ceps_1)
      lz1_278(0).c(2,1)=zcl(id1)*(-p1(2)+ceps_1)
      lz1_278(0).d(1,1)=zcl(id1)
      lz1_278(0).d(2,2)=zcr(id1)
* T -- qu=p1,qd=p278,v=1,a=lz1_278(1).a,b=lz1_278(1).b,c=lz1_278(1).c,d=
* lz1_278(1).d,cr=zcr(id1),cl=zcl(id1),nsum=0
      auxa=-quqd+p1k0*p278(1)+p278k0*p1(1)
      lz1_278(1).a(1,1)=zcr(id1)*(auxa+ceps_0)
      lz1_278(1).a(2,2)=zcl(id1)*(auxa-ceps_0)
      lz1_278(1).b(1,2)=-zcl(id1)*(p278(2)+ceps_2)
      lz1_278(1).b(2,1)=zcr(id1)*(p278(2)-ceps_2)
      lz1_278(1).c(1,2)=zcr(id1)*(p1(2)+ceps_1)
      lz1_278(1).c(2,1)=zcl(id1)*(-p1(2)+ceps_1)
      lz1_278(1).d(1,1)=zcl(id1)
      lz1_278(1).d(2,2)=zcr(id1)
* T -- qu=p1,qd=p278,v=2,a=lz1_278(2).a,b=lz1_278(2).b,c=lz1_278(2).c,d=
* lz1_278(2).d,cr=zcr(id1),cl=zcl(id1),nsum=0
      eps_0=-p1k0*p278(3)+p278k0*p1(3)
      ceps_0=eps_0*cim
      auxa=p1k0*p278(2)+p278k0*p1(2)
      lz1_278(2).a(1,1)=zcr(id1)*(auxa+ceps_0)
      lz1_278(2).a(2,2)=zcl(id1)*(auxa-ceps_0)
      lz1_278(2).b(1,2)=-zcl(id1)*p278k0
      lz1_278(2).b(2,1)=zcr(id1)*p278k0
      lz1_278(2).c(1,2)=zcr(id1)*p1k0
      lz1_278(2).c(2,1)=-zcl(id1)*p1k0
* T -- qu=p1,qd=p278,v=3,a=lz1_278(3).a,b=lz1_278(3).b,c=lz1_278(3).c,d=
* lz1_278(3).d,cr=zcr(id1),cl=zcl(id1),nsum=0
      eps_0=p1k0*p278(2)-p278k0*p1(2)
      ceps_0=eps_0*cim
      ceps_1=p1k0*cim
      ceps_2=p278k0*cim
      auxa=+p1k0*p278(3)+p278k0*p1(3)
      lz1_278(3).a(1,1)=zcr(id1)*(auxa+ceps_0)
      lz1_278(3).a(2,2)=zcl(id1)*(auxa-ceps_0)
      lz1_278(3).b(1,2)=-zcl(id1)*ceps_2
      lz1_278(3).b(2,1)=-zcr(id1)*ceps_2
      lz1_278(3).c(1,2)=zcr(id1)*ceps_1
      lz1_278(3).c(2,1)=zcl(id1)*ceps_1
  
* T -- qu=p1,qd=p278,v=0,a=lf1_278(0).a,b=lf1_278(0).b,c=lf1_278(0).c,d=
* lf1_278(0).d,cr=fcr(id1),cl=fcl(id1),nsum=0
      eps_0=-p1(2)*p278(3)+p278(2)*p1(3)
      ceps_0=eps_0*cim
      ceps_1=p1(3)*cim
      ceps_2=p278(3)*cim
      auxa=-quqd+p1k0*p278(0)+p278k0*p1(0)
      lf1_278(0).a(1,1)=fcr(id1)*(auxa+ceps_0)
      lf1_278(0).a(2,2)=fcl(id1)*(auxa-ceps_0)
      lf1_278(0).b(1,2)=-fcl(id1)*(p278(2)+ceps_2)
      lf1_278(0).b(2,1)=fcr(id1)*(p278(2)-ceps_2)
      lf1_278(0).c(1,2)=fcr(id1)*(p1(2)+ceps_1)
      lf1_278(0).c(2,1)=fcl(id1)*(-p1(2)+ceps_1)
      lf1_278(0).d(1,1)=fcl(id1)
      lf1_278(0).d(2,2)=fcr(id1)
* T -- qu=p1,qd=p278,v=1,a=lf1_278(1).a,b=lf1_278(1).b,c=lf1_278(1).c,d=
* lf1_278(1).d,cr=fcr(id1),cl=fcl(id1),nsum=0
      auxa=-quqd+p1k0*p278(1)+p278k0*p1(1)
      lf1_278(1).a(1,1)=fcr(id1)*(auxa+ceps_0)
      lf1_278(1).a(2,2)=fcl(id1)*(auxa-ceps_0)
      lf1_278(1).b(1,2)=-fcl(id1)*(p278(2)+ceps_2)
      lf1_278(1).b(2,1)=fcr(id1)*(p278(2)-ceps_2)
      lf1_278(1).c(1,2)=fcr(id1)*(p1(2)+ceps_1)
      lf1_278(1).c(2,1)=fcl(id1)*(-p1(2)+ceps_1)
      lf1_278(1).d(1,1)=fcl(id1)
      lf1_278(1).d(2,2)=fcr(id1)
* T -- qu=p1,qd=p278,v=2,a=lf1_278(2).a,b=lf1_278(2).b,c=lf1_278(2).c,d=
* lf1_278(2).d,cr=fcr(id1),cl=fcl(id1),nsum=0
      eps_0=-p1k0*p278(3)+p278k0*p1(3)
      ceps_0=eps_0*cim
      auxa=p1k0*p278(2)+p278k0*p1(2)
      lf1_278(2).a(1,1)=fcr(id1)*(auxa+ceps_0)
      lf1_278(2).a(2,2)=fcl(id1)*(auxa-ceps_0)
      lf1_278(2).b(1,2)=-fcl(id1)*p278k0
      lf1_278(2).b(2,1)=fcr(id1)*p278k0
      lf1_278(2).c(1,2)=fcr(id1)*p1k0
      lf1_278(2).c(2,1)=-fcl(id1)*p1k0
* T -- qu=p1,qd=p278,v=3,a=lf1_278(3).a,b=lf1_278(3).b,c=lf1_278(3).c,d=
* lf1_278(3).d,cr=fcr(id1),cl=fcl(id1),nsum=0
      eps_0=p1k0*p278(2)-p278k0*p1(2)
      ceps_0=eps_0*cim
      ceps_1=p1k0*cim
      ceps_2=p278k0*cim
      auxa=+p1k0*p278(3)+p278k0*p1(3)
      lf1_278(3).a(1,1)=fcr(id1)*(auxa+ceps_0)
      lf1_278(3).a(2,2)=fcl(id1)*(auxa-ceps_0)
      lf1_278(3).b(1,2)=-fcl(id1)*ceps_2
      lf1_278(3).b(2,1)=-fcr(id1)*ceps_2
      lf1_278(3).c(1,2)=fcr(id1)*ceps_1
      lf1_278(3).c(2,1)=fcl(id1)*ceps_1
  
* quqd -- p=p3,q=p412
      quqd=p3(0)*p412(0)-p3(1)*p412(1)-p3(2)*p412(2)-p3(3)*p412(
     & 3)
* T -- qu=p3,qd=p412,v=0,a=lz3_412(0).a,b=lz3_412(0).b,c=lz3_412(0).c,d=
* lz3_412(0).d,cr=zcr(id3),cl=zcl(id3),nsum=0
      eps_0=-p3(2)*p412(3)+p412(2)*p3(3)
      ceps_0=eps_0*cim
      ceps_1=p3(3)*cim
      ceps_2=p412(3)*cim
      auxa=-quqd+p3k0*p412(0)+p412k0*p3(0)
      lz3_412(0).a(1,1)=zcr(id3)*(auxa+ceps_0)
      lz3_412(0).a(2,2)=zcl(id3)*(auxa-ceps_0)
      lz3_412(0).b(1,2)=-zcl(id3)*(p412(2)+ceps_2)
      lz3_412(0).b(2,1)=zcr(id3)*(p412(2)-ceps_2)
      lz3_412(0).c(1,2)=zcr(id3)*(p3(2)+ceps_1)
      lz3_412(0).c(2,1)=zcl(id3)*(-p3(2)+ceps_1)
      lz3_412(0).d(1,1)=zcl(id3)
      lz3_412(0).d(2,2)=zcr(id3)
* T -- qu=p3,qd=p412,v=1,a=lz3_412(1).a,b=lz3_412(1).b,c=lz3_412(1).c,d=
* lz3_412(1).d,cr=zcr(id3),cl=zcl(id3),nsum=0
      auxa=-quqd+p3k0*p412(1)+p412k0*p3(1)
      lz3_412(1).a(1,1)=zcr(id3)*(auxa+ceps_0)
      lz3_412(1).a(2,2)=zcl(id3)*(auxa-ceps_0)
      lz3_412(1).b(1,2)=-zcl(id3)*(p412(2)+ceps_2)
      lz3_412(1).b(2,1)=zcr(id3)*(p412(2)-ceps_2)
      lz3_412(1).c(1,2)=zcr(id3)*(p3(2)+ceps_1)
      lz3_412(1).c(2,1)=zcl(id3)*(-p3(2)+ceps_1)
      lz3_412(1).d(1,1)=zcl(id3)
      lz3_412(1).d(2,2)=zcr(id3)
* T -- qu=p3,qd=p412,v=2,a=lz3_412(2).a,b=lz3_412(2).b,c=lz3_412(2).c,d=
* lz3_412(2).d,cr=zcr(id3),cl=zcl(id3),nsum=0
      eps_0=-p3k0*p412(3)+p412k0*p3(3)
      ceps_0=eps_0*cim
      auxa=p3k0*p412(2)+p412k0*p3(2)
      lz3_412(2).a(1,1)=zcr(id3)*(auxa+ceps_0)
      lz3_412(2).a(2,2)=zcl(id3)*(auxa-ceps_0)
      lz3_412(2).b(1,2)=-zcl(id3)*p412k0
      lz3_412(2).b(2,1)=zcr(id3)*p412k0
      lz3_412(2).c(1,2)=zcr(id3)*p3k0
      lz3_412(2).c(2,1)=-zcl(id3)*p3k0
* T -- qu=p3,qd=p412,v=3,a=lz3_412(3).a,b=lz3_412(3).b,c=lz3_412(3).c,d=
* lz3_412(3).d,cr=zcr(id3),cl=zcl(id3),nsum=0
      eps_0=p3k0*p412(2)-p412k0*p3(2)
      ceps_0=eps_0*cim
      ceps_1=p3k0*cim
      ceps_2=p412k0*cim
      auxa=+p3k0*p412(3)+p412k0*p3(3)
      lz3_412(3).a(1,1)=zcr(id3)*(auxa+ceps_0)
      lz3_412(3).a(2,2)=zcl(id3)*(auxa-ceps_0)
      lz3_412(3).b(1,2)=-zcl(id3)*ceps_2
      lz3_412(3).b(2,1)=-zcr(id3)*ceps_2
      lz3_412(3).c(1,2)=zcr(id3)*ceps_1
      lz3_412(3).c(2,1)=zcl(id3)*ceps_1
  
* T -- qu=p3,qd=p412,v=0,a=lf3_412(0).a,b=lf3_412(0).b,c=lf3_412(0).c,d=
* lf3_412(0).d,cr=fcr(id3),cl=fcl(id3),nsum=0
      eps_0=-p3(2)*p412(3)+p412(2)*p3(3)
      ceps_0=eps_0*cim
      ceps_1=p3(3)*cim
      ceps_2=p412(3)*cim
      auxa=-quqd+p3k0*p412(0)+p412k0*p3(0)
      lf3_412(0).a(1,1)=fcr(id3)*(auxa+ceps_0)
      lf3_412(0).a(2,2)=fcl(id3)*(auxa-ceps_0)
      lf3_412(0).b(1,2)=-fcl(id3)*(p412(2)+ceps_2)
      lf3_412(0).b(2,1)=fcr(id3)*(p412(2)-ceps_2)
      lf3_412(0).c(1,2)=fcr(id3)*(p3(2)+ceps_1)
      lf3_412(0).c(2,1)=fcl(id3)*(-p3(2)+ceps_1)
      lf3_412(0).d(1,1)=fcl(id3)
      lf3_412(0).d(2,2)=fcr(id3)
* T -- qu=p3,qd=p412,v=1,a=lf3_412(1).a,b=lf3_412(1).b,c=lf3_412(1).c,d=
* lf3_412(1).d,cr=fcr(id3),cl=fcl(id3),nsum=0
      auxa=-quqd+p3k0*p412(1)+p412k0*p3(1)
      lf3_412(1).a(1,1)=fcr(id3)*(auxa+ceps_0)
      lf3_412(1).a(2,2)=fcl(id3)*(auxa-ceps_0)
      lf3_412(1).b(1,2)=-fcl(id3)*(p412(2)+ceps_2)
      lf3_412(1).b(2,1)=fcr(id3)*(p412(2)-ceps_2)
      lf3_412(1).c(1,2)=fcr(id3)*(p3(2)+ceps_1)
      lf3_412(1).c(2,1)=fcl(id3)*(-p3(2)+ceps_1)
      lf3_412(1).d(1,1)=fcl(id3)
      lf3_412(1).d(2,2)=fcr(id3)
* T -- qu=p3,qd=p412,v=2,a=lf3_412(2).a,b=lf3_412(2).b,c=lf3_412(2).c,d=
* lf3_412(2).d,cr=fcr(id3),cl=fcl(id3),nsum=0
      eps_0=-p3k0*p412(3)+p412k0*p3(3)
      ceps_0=eps_0*cim
      auxa=p3k0*p412(2)+p412k0*p3(2)
      lf3_412(2).a(1,1)=fcr(id3)*(auxa+ceps_0)
      lf3_412(2).a(2,2)=fcl(id3)*(auxa-ceps_0)
      lf3_412(2).b(1,2)=-fcl(id3)*p412k0
      lf3_412(2).b(2,1)=fcr(id3)*p412k0
      lf3_412(2).c(1,2)=fcr(id3)*p3k0
      lf3_412(2).c(2,1)=-fcl(id3)*p3k0
* T -- qu=p3,qd=p412,v=3,a=lf3_412(3).a,b=lf3_412(3).b,c=lf3_412(3).c,d=
* lf3_412(3).d,cr=fcr(id3),cl=fcl(id3),nsum=0
      eps_0=p3k0*p412(2)-p412k0*p3(2)
      ceps_0=eps_0*cim
      ceps_1=p3k0*cim
      ceps_2=p412k0*cim
      auxa=+p3k0*p412(3)+p412k0*p3(3)
      lf3_412(3).a(1,1)=fcr(id3)*(auxa+ceps_0)
      lf3_412(3).a(2,2)=fcl(id3)*(auxa-ceps_0)
      lf3_412(3).b(1,2)=-fcl(id3)*ceps_2
      lf3_412(3).b(2,1)=-fcr(id3)*ceps_2
      lf3_412(3).c(1,2)=fcr(id3)*ceps_1
      lf3_412(3).c(2,1)=fcl(id3)*ceps_1
  
* quqd -- p=p3,q=p456
      quqd=p3(0)*p456(0)-p3(1)*p456(1)-p3(2)*p456(2)-p3(3)*p456(
     & 3)
* T -- qu=p3,qd=p456,v=0,a=lz3_456(0).a,b=lz3_456(0).b,c=lz3_456(0).c,d=
* lz3_456(0).d,cr=zcr(id3),cl=zcl(id3),nsum=0
      eps_0=-p3(2)*p456(3)+p456(2)*p3(3)
      ceps_0=eps_0*cim
      ceps_1=p3(3)*cim
      ceps_2=p456(3)*cim
      auxa=-quqd+p3k0*p456(0)+p456k0*p3(0)
      lz3_456(0).a(1,1)=zcr(id3)*(auxa+ceps_0)
      lz3_456(0).a(2,2)=zcl(id3)*(auxa-ceps_0)
      lz3_456(0).b(1,2)=-zcl(id3)*(p456(2)+ceps_2)
      lz3_456(0).b(2,1)=zcr(id3)*(p456(2)-ceps_2)
      lz3_456(0).c(1,2)=zcr(id3)*(p3(2)+ceps_1)
      lz3_456(0).c(2,1)=zcl(id3)*(-p3(2)+ceps_1)
      lz3_456(0).d(1,1)=zcl(id3)
      lz3_456(0).d(2,2)=zcr(id3)
* T -- qu=p3,qd=p456,v=1,a=lz3_456(1).a,b=lz3_456(1).b,c=lz3_456(1).c,d=
* lz3_456(1).d,cr=zcr(id3),cl=zcl(id3),nsum=0
      auxa=-quqd+p3k0*p456(1)+p456k0*p3(1)
      lz3_456(1).a(1,1)=zcr(id3)*(auxa+ceps_0)
      lz3_456(1).a(2,2)=zcl(id3)*(auxa-ceps_0)
      lz3_456(1).b(1,2)=-zcl(id3)*(p456(2)+ceps_2)
      lz3_456(1).b(2,1)=zcr(id3)*(p456(2)-ceps_2)
      lz3_456(1).c(1,2)=zcr(id3)*(p3(2)+ceps_1)
      lz3_456(1).c(2,1)=zcl(id3)*(-p3(2)+ceps_1)
      lz3_456(1).d(1,1)=zcl(id3)
      lz3_456(1).d(2,2)=zcr(id3)
* T -- qu=p3,qd=p456,v=2,a=lz3_456(2).a,b=lz3_456(2).b,c=lz3_456(2).c,d=
* lz3_456(2).d,cr=zcr(id3),cl=zcl(id3),nsum=0
      eps_0=-p3k0*p456(3)+p456k0*p3(3)
      ceps_0=eps_0*cim
      auxa=p3k0*p456(2)+p456k0*p3(2)
      lz3_456(2).a(1,1)=zcr(id3)*(auxa+ceps_0)
      lz3_456(2).a(2,2)=zcl(id3)*(auxa-ceps_0)
      lz3_456(2).b(1,2)=-zcl(id3)*p456k0
      lz3_456(2).b(2,1)=zcr(id3)*p456k0
      lz3_456(2).c(1,2)=zcr(id3)*p3k0
      lz3_456(2).c(2,1)=-zcl(id3)*p3k0
* T -- qu=p3,qd=p456,v=3,a=lz3_456(3).a,b=lz3_456(3).b,c=lz3_456(3).c,d=
* lz3_456(3).d,cr=zcr(id3),cl=zcl(id3),nsum=0
      eps_0=p3k0*p456(2)-p456k0*p3(2)
      ceps_0=eps_0*cim
      ceps_1=p3k0*cim
      ceps_2=p456k0*cim
      auxa=+p3k0*p456(3)+p456k0*p3(3)
      lz3_456(3).a(1,1)=zcr(id3)*(auxa+ceps_0)
      lz3_456(3).a(2,2)=zcl(id3)*(auxa-ceps_0)
      lz3_456(3).b(1,2)=-zcl(id3)*ceps_2
      lz3_456(3).b(2,1)=-zcr(id3)*ceps_2
      lz3_456(3).c(1,2)=zcr(id3)*ceps_1
      lz3_456(3).c(2,1)=zcl(id3)*ceps_1
  
* T -- qu=p3,qd=p456,v=0,a=lf3_456(0).a,b=lf3_456(0).b,c=lf3_456(0).c,d=
* lf3_456(0).d,cr=fcr(id3),cl=fcl(id3),nsum=0
      eps_0=-p3(2)*p456(3)+p456(2)*p3(3)
      ceps_0=eps_0*cim
      ceps_1=p3(3)*cim
      ceps_2=p456(3)*cim
      auxa=-quqd+p3k0*p456(0)+p456k0*p3(0)
      lf3_456(0).a(1,1)=fcr(id3)*(auxa+ceps_0)
      lf3_456(0).a(2,2)=fcl(id3)*(auxa-ceps_0)
      lf3_456(0).b(1,2)=-fcl(id3)*(p456(2)+ceps_2)
      lf3_456(0).b(2,1)=fcr(id3)*(p456(2)-ceps_2)
      lf3_456(0).c(1,2)=fcr(id3)*(p3(2)+ceps_1)
      lf3_456(0).c(2,1)=fcl(id3)*(-p3(2)+ceps_1)
      lf3_456(0).d(1,1)=fcl(id3)
      lf3_456(0).d(2,2)=fcr(id3)
* T -- qu=p3,qd=p456,v=1,a=lf3_456(1).a,b=lf3_456(1).b,c=lf3_456(1).c,d=
* lf3_456(1).d,cr=fcr(id3),cl=fcl(id3),nsum=0
      auxa=-quqd+p3k0*p456(1)+p456k0*p3(1)
      lf3_456(1).a(1,1)=fcr(id3)*(auxa+ceps_0)
      lf3_456(1).a(2,2)=fcl(id3)*(auxa-ceps_0)
      lf3_456(1).b(1,2)=-fcl(id3)*(p456(2)+ceps_2)
      lf3_456(1).b(2,1)=fcr(id3)*(p456(2)-ceps_2)
      lf3_456(1).c(1,2)=fcr(id3)*(p3(2)+ceps_1)
      lf3_456(1).c(2,1)=fcl(id3)*(-p3(2)+ceps_1)
      lf3_456(1).d(1,1)=fcl(id3)
      lf3_456(1).d(2,2)=fcr(id3)
* T -- qu=p3,qd=p456,v=2,a=lf3_456(2).a,b=lf3_456(2).b,c=lf3_456(2).c,d=
* lf3_456(2).d,cr=fcr(id3),cl=fcl(id3),nsum=0
      eps_0=-p3k0*p456(3)+p456k0*p3(3)
      ceps_0=eps_0*cim
      auxa=p3k0*p456(2)+p456k0*p3(2)
      lf3_456(2).a(1,1)=fcr(id3)*(auxa+ceps_0)
      lf3_456(2).a(2,2)=fcl(id3)*(auxa-ceps_0)
      lf3_456(2).b(1,2)=-fcl(id3)*p456k0
      lf3_456(2).b(2,1)=fcr(id3)*p456k0
      lf3_456(2).c(1,2)=fcr(id3)*p3k0
      lf3_456(2).c(2,1)=-fcl(id3)*p3k0
* T -- qu=p3,qd=p456,v=3,a=lf3_456(3).a,b=lf3_456(3).b,c=lf3_456(3).c,d=
* lf3_456(3).d,cr=fcr(id3),cl=fcl(id3),nsum=0
      eps_0=p3k0*p456(2)-p456k0*p3(2)
      ceps_0=eps_0*cim
      ceps_1=p3k0*cim
      ceps_2=p456k0*cim
      auxa=+p3k0*p456(3)+p456k0*p3(3)
      lf3_456(3).a(1,1)=fcr(id3)*(auxa+ceps_0)
      lf3_456(3).a(2,2)=fcl(id3)*(auxa-ceps_0)
      lf3_456(3).b(1,2)=-fcl(id3)*ceps_2
      lf3_456(3).b(2,1)=-fcr(id3)*ceps_2
      lf3_456(3).c(1,2)=fcr(id3)*ceps_1
      lf3_456(3).c(2,1)=fcl(id3)*ceps_1
  
* quqd -- p=p3,q=p478
      quqd=p3(0)*p478(0)-p3(1)*p478(1)-p3(2)*p478(2)-p3(3)*p478(
     & 3)
* T -- qu=p3,qd=p478,v=0,a=lz3_478(0).a,b=lz3_478(0).b,c=lz3_478(0).c,d=
* lz3_478(0).d,cr=zcr(id3),cl=zcl(id3),nsum=0
      eps_0=-p3(2)*p478(3)+p478(2)*p3(3)
      ceps_0=eps_0*cim
      ceps_1=p3(3)*cim
      ceps_2=p478(3)*cim
      auxa=-quqd+p3k0*p478(0)+p478k0*p3(0)
      lz3_478(0).a(1,1)=zcr(id3)*(auxa+ceps_0)
      lz3_478(0).a(2,2)=zcl(id3)*(auxa-ceps_0)
      lz3_478(0).b(1,2)=-zcl(id3)*(p478(2)+ceps_2)
      lz3_478(0).b(2,1)=zcr(id3)*(p478(2)-ceps_2)
      lz3_478(0).c(1,2)=zcr(id3)*(p3(2)+ceps_1)
      lz3_478(0).c(2,1)=zcl(id3)*(-p3(2)+ceps_1)
      lz3_478(0).d(1,1)=zcl(id3)
      lz3_478(0).d(2,2)=zcr(id3)
* T -- qu=p3,qd=p478,v=1,a=lz3_478(1).a,b=lz3_478(1).b,c=lz3_478(1).c,d=
* lz3_478(1).d,cr=zcr(id3),cl=zcl(id3),nsum=0
      auxa=-quqd+p3k0*p478(1)+p478k0*p3(1)
      lz3_478(1).a(1,1)=zcr(id3)*(auxa+ceps_0)
      lz3_478(1).a(2,2)=zcl(id3)*(auxa-ceps_0)
      lz3_478(1).b(1,2)=-zcl(id3)*(p478(2)+ceps_2)
      lz3_478(1).b(2,1)=zcr(id3)*(p478(2)-ceps_2)
      lz3_478(1).c(1,2)=zcr(id3)*(p3(2)+ceps_1)
      lz3_478(1).c(2,1)=zcl(id3)*(-p3(2)+ceps_1)
      lz3_478(1).d(1,1)=zcl(id3)
      lz3_478(1).d(2,2)=zcr(id3)
* T -- qu=p3,qd=p478,v=2,a=lz3_478(2).a,b=lz3_478(2).b,c=lz3_478(2).c,d=
* lz3_478(2).d,cr=zcr(id3),cl=zcl(id3),nsum=0
      eps_0=-p3k0*p478(3)+p478k0*p3(3)
      ceps_0=eps_0*cim
      auxa=p3k0*p478(2)+p478k0*p3(2)
      lz3_478(2).a(1,1)=zcr(id3)*(auxa+ceps_0)
      lz3_478(2).a(2,2)=zcl(id3)*(auxa-ceps_0)
      lz3_478(2).b(1,2)=-zcl(id3)*p478k0
      lz3_478(2).b(2,1)=zcr(id3)*p478k0
      lz3_478(2).c(1,2)=zcr(id3)*p3k0
      lz3_478(2).c(2,1)=-zcl(id3)*p3k0
* T -- qu=p3,qd=p478,v=3,a=lz3_478(3).a,b=lz3_478(3).b,c=lz3_478(3).c,d=
* lz3_478(3).d,cr=zcr(id3),cl=zcl(id3),nsum=0
      eps_0=p3k0*p478(2)-p478k0*p3(2)
      ceps_0=eps_0*cim
      ceps_1=p3k0*cim
      ceps_2=p478k0*cim
      auxa=+p3k0*p478(3)+p478k0*p3(3)
      lz3_478(3).a(1,1)=zcr(id3)*(auxa+ceps_0)
      lz3_478(3).a(2,2)=zcl(id3)*(auxa-ceps_0)
      lz3_478(3).b(1,2)=-zcl(id3)*ceps_2
      lz3_478(3).b(2,1)=-zcr(id3)*ceps_2
      lz3_478(3).c(1,2)=zcr(id3)*ceps_1
      lz3_478(3).c(2,1)=zcl(id3)*ceps_1
  
* T -- qu=p3,qd=p478,v=0,a=lf3_478(0).a,b=lf3_478(0).b,c=lf3_478(0).c,d=
* lf3_478(0).d,cr=fcr(id3),cl=fcl(id3),nsum=0
      eps_0=-p3(2)*p478(3)+p478(2)*p3(3)
      ceps_0=eps_0*cim
      ceps_1=p3(3)*cim
      ceps_2=p478(3)*cim
      auxa=-quqd+p3k0*p478(0)+p478k0*p3(0)
      lf3_478(0).a(1,1)=fcr(id3)*(auxa+ceps_0)
      lf3_478(0).a(2,2)=fcl(id3)*(auxa-ceps_0)
      lf3_478(0).b(1,2)=-fcl(id3)*(p478(2)+ceps_2)
      lf3_478(0).b(2,1)=fcr(id3)*(p478(2)-ceps_2)
      lf3_478(0).c(1,2)=fcr(id3)*(p3(2)+ceps_1)
      lf3_478(0).c(2,1)=fcl(id3)*(-p3(2)+ceps_1)
      lf3_478(0).d(1,1)=fcl(id3)
      lf3_478(0).d(2,2)=fcr(id3)
* T -- qu=p3,qd=p478,v=1,a=lf3_478(1).a,b=lf3_478(1).b,c=lf3_478(1).c,d=
* lf3_478(1).d,cr=fcr(id3),cl=fcl(id3),nsum=0
      auxa=-quqd+p3k0*p478(1)+p478k0*p3(1)
      lf3_478(1).a(1,1)=fcr(id3)*(auxa+ceps_0)
      lf3_478(1).a(2,2)=fcl(id3)*(auxa-ceps_0)
      lf3_478(1).b(1,2)=-fcl(id3)*(p478(2)+ceps_2)
      lf3_478(1).b(2,1)=fcr(id3)*(p478(2)-ceps_2)
      lf3_478(1).c(1,2)=fcr(id3)*(p3(2)+ceps_1)
      lf3_478(1).c(2,1)=fcl(id3)*(-p3(2)+ceps_1)
      lf3_478(1).d(1,1)=fcl(id3)
      lf3_478(1).d(2,2)=fcr(id3)
* T -- qu=p3,qd=p478,v=2,a=lf3_478(2).a,b=lf3_478(2).b,c=lf3_478(2).c,d=
* lf3_478(2).d,cr=fcr(id3),cl=fcl(id3),nsum=0
      eps_0=-p3k0*p478(3)+p478k0*p3(3)
      ceps_0=eps_0*cim
      auxa=p3k0*p478(2)+p478k0*p3(2)
      lf3_478(2).a(1,1)=fcr(id3)*(auxa+ceps_0)
      lf3_478(2).a(2,2)=fcl(id3)*(auxa-ceps_0)
      lf3_478(2).b(1,2)=-fcl(id3)*p478k0
      lf3_478(2).b(2,1)=fcr(id3)*p478k0
      lf3_478(2).c(1,2)=fcr(id3)*p3k0
      lf3_478(2).c(2,1)=-fcl(id3)*p3k0
* T -- qu=p3,qd=p478,v=3,a=lf3_478(3).a,b=lf3_478(3).b,c=lf3_478(3).c,d=
* lf3_478(3).d,cr=fcr(id3),cl=fcl(id3),nsum=0
      eps_0=p3k0*p478(2)-p478k0*p3(2)
      ceps_0=eps_0*cim
      ceps_1=p3k0*cim
      ceps_2=p478k0*cim
      auxa=+p3k0*p478(3)+p478k0*p3(3)
      lf3_478(3).a(1,1)=fcr(id3)*(auxa+ceps_0)
      lf3_478(3).a(2,2)=fcl(id3)*(auxa-ceps_0)
      lf3_478(3).b(1,2)=-fcl(id3)*ceps_2
      lf3_478(3).b(2,1)=-fcr(id3)*ceps_2
      lf3_478(3).c(1,2)=fcr(id3)*ceps_1
      lf3_478(3).c(2,1)=fcl(id3)*ceps_1
  
* quqd -- p=p5,q=p612
      quqd=p5(0)*p612(0)-p5(1)*p612(1)-p5(2)*p612(2)-p5(3)*p612(
     & 3)
* T -- qu=p5,qd=p612,v=0,a=lz5_612(0).a,b=lz5_612(0).b,c=lz5_612(0).c,d=
* lz5_612(0).d,cr=zcr(id5),cl=zcl(id5),nsum=0
      eps_0=-p5(2)*p612(3)+p612(2)*p5(3)
      ceps_0=eps_0*cim
      ceps_1=p5(3)*cim
      ceps_2=p612(3)*cim
      auxa=-quqd+p5k0*p612(0)+p612k0*p5(0)
      lz5_612(0).a(1,1)=zcr(id5)*(auxa+ceps_0)
      lz5_612(0).a(2,2)=zcl(id5)*(auxa-ceps_0)
      lz5_612(0).b(1,2)=-zcl(id5)*(p612(2)+ceps_2)
      lz5_612(0).b(2,1)=zcr(id5)*(p612(2)-ceps_2)
      lz5_612(0).c(1,2)=zcr(id5)*(p5(2)+ceps_1)
      lz5_612(0).c(2,1)=zcl(id5)*(-p5(2)+ceps_1)
      lz5_612(0).d(1,1)=zcl(id5)
      lz5_612(0).d(2,2)=zcr(id5)
* T -- qu=p5,qd=p612,v=1,a=lz5_612(1).a,b=lz5_612(1).b,c=lz5_612(1).c,d=
* lz5_612(1).d,cr=zcr(id5),cl=zcl(id5),nsum=0
      auxa=-quqd+p5k0*p612(1)+p612k0*p5(1)
      lz5_612(1).a(1,1)=zcr(id5)*(auxa+ceps_0)
      lz5_612(1).a(2,2)=zcl(id5)*(auxa-ceps_0)
      lz5_612(1).b(1,2)=-zcl(id5)*(p612(2)+ceps_2)
      lz5_612(1).b(2,1)=zcr(id5)*(p612(2)-ceps_2)
      lz5_612(1).c(1,2)=zcr(id5)*(p5(2)+ceps_1)
      lz5_612(1).c(2,1)=zcl(id5)*(-p5(2)+ceps_1)
      lz5_612(1).d(1,1)=zcl(id5)
      lz5_612(1).d(2,2)=zcr(id5)
* T -- qu=p5,qd=p612,v=2,a=lz5_612(2).a,b=lz5_612(2).b,c=lz5_612(2).c,d=
* lz5_612(2).d,cr=zcr(id5),cl=zcl(id5),nsum=0
      eps_0=-p5k0*p612(3)+p612k0*p5(3)
      ceps_0=eps_0*cim
      auxa=p5k0*p612(2)+p612k0*p5(2)
      lz5_612(2).a(1,1)=zcr(id5)*(auxa+ceps_0)
      lz5_612(2).a(2,2)=zcl(id5)*(auxa-ceps_0)
      lz5_612(2).b(1,2)=-zcl(id5)*p612k0
      lz5_612(2).b(2,1)=zcr(id5)*p612k0
      lz5_612(2).c(1,2)=zcr(id5)*p5k0
      lz5_612(2).c(2,1)=-zcl(id5)*p5k0
* T -- qu=p5,qd=p612,v=3,a=lz5_612(3).a,b=lz5_612(3).b,c=lz5_612(3).c,d=
* lz5_612(3).d,cr=zcr(id5),cl=zcl(id5),nsum=0
      eps_0=p5k0*p612(2)-p612k0*p5(2)
      ceps_0=eps_0*cim
      ceps_1=p5k0*cim
      ceps_2=p612k0*cim
      auxa=+p5k0*p612(3)+p612k0*p5(3)
      lz5_612(3).a(1,1)=zcr(id5)*(auxa+ceps_0)
      lz5_612(3).a(2,2)=zcl(id5)*(auxa-ceps_0)
      lz5_612(3).b(1,2)=-zcl(id5)*ceps_2
      lz5_612(3).b(2,1)=-zcr(id5)*ceps_2
      lz5_612(3).c(1,2)=zcr(id5)*ceps_1
      lz5_612(3).c(2,1)=zcl(id5)*ceps_1
  
* T -- qu=p5,qd=p612,v=0,a=lf5_612(0).a,b=lf5_612(0).b,c=lf5_612(0).c,d=
* lf5_612(0).d,cr=fcr(id5),cl=fcl(id5),nsum=0
      eps_0=-p5(2)*p612(3)+p612(2)*p5(3)
      ceps_0=eps_0*cim
      ceps_1=p5(3)*cim
      ceps_2=p612(3)*cim
      auxa=-quqd+p5k0*p612(0)+p612k0*p5(0)
      lf5_612(0).a(1,1)=fcr(id5)*(auxa+ceps_0)
      lf5_612(0).a(2,2)=fcl(id5)*(auxa-ceps_0)
      lf5_612(0).b(1,2)=-fcl(id5)*(p612(2)+ceps_2)
      lf5_612(0).b(2,1)=fcr(id5)*(p612(2)-ceps_2)
      lf5_612(0).c(1,2)=fcr(id5)*(p5(2)+ceps_1)
      lf5_612(0).c(2,1)=fcl(id5)*(-p5(2)+ceps_1)
      lf5_612(0).d(1,1)=fcl(id5)
      lf5_612(0).d(2,2)=fcr(id5)
* T -- qu=p5,qd=p612,v=1,a=lf5_612(1).a,b=lf5_612(1).b,c=lf5_612(1).c,d=
* lf5_612(1).d,cr=fcr(id5),cl=fcl(id5),nsum=0
      auxa=-quqd+p5k0*p612(1)+p612k0*p5(1)
      lf5_612(1).a(1,1)=fcr(id5)*(auxa+ceps_0)
      lf5_612(1).a(2,2)=fcl(id5)*(auxa-ceps_0)
      lf5_612(1).b(1,2)=-fcl(id5)*(p612(2)+ceps_2)
      lf5_612(1).b(2,1)=fcr(id5)*(p612(2)-ceps_2)
      lf5_612(1).c(1,2)=fcr(id5)*(p5(2)+ceps_1)
      lf5_612(1).c(2,1)=fcl(id5)*(-p5(2)+ceps_1)
      lf5_612(1).d(1,1)=fcl(id5)
      lf5_612(1).d(2,2)=fcr(id5)
* T -- qu=p5,qd=p612,v=2,a=lf5_612(2).a,b=lf5_612(2).b,c=lf5_612(2).c,d=
* lf5_612(2).d,cr=fcr(id5),cl=fcl(id5),nsum=0
      eps_0=-p5k0*p612(3)+p612k0*p5(3)
      ceps_0=eps_0*cim
      auxa=p5k0*p612(2)+p612k0*p5(2)
      lf5_612(2).a(1,1)=fcr(id5)*(auxa+ceps_0)
      lf5_612(2).a(2,2)=fcl(id5)*(auxa-ceps_0)
      lf5_612(2).b(1,2)=-fcl(id5)*p612k0
      lf5_612(2).b(2,1)=fcr(id5)*p612k0
      lf5_612(2).c(1,2)=fcr(id5)*p5k0
      lf5_612(2).c(2,1)=-fcl(id5)*p5k0
* T -- qu=p5,qd=p612,v=3,a=lf5_612(3).a,b=lf5_612(3).b,c=lf5_612(3).c,d=
* lf5_612(3).d,cr=fcr(id5),cl=fcl(id5),nsum=0
      eps_0=p5k0*p612(2)-p612k0*p5(2)
      ceps_0=eps_0*cim
      ceps_1=p5k0*cim
      ceps_2=p612k0*cim
      auxa=+p5k0*p612(3)+p612k0*p5(3)
      lf5_612(3).a(1,1)=fcr(id5)*(auxa+ceps_0)
      lf5_612(3).a(2,2)=fcl(id5)*(auxa-ceps_0)
      lf5_612(3).b(1,2)=-fcl(id5)*ceps_2
      lf5_612(3).b(2,1)=-fcr(id5)*ceps_2
      lf5_612(3).c(1,2)=fcr(id5)*ceps_1
      lf5_612(3).c(2,1)=fcl(id5)*ceps_1
  
* quqd -- p=p5,q=p634
      quqd=p5(0)*p634(0)-p5(1)*p634(1)-p5(2)*p634(2)-p5(3)*p634(
     & 3)
* T -- qu=p5,qd=p634,v=0,a=lz5_634(0).a,b=lz5_634(0).b,c=lz5_634(0).c,d=
* lz5_634(0).d,cr=zcr(id5),cl=zcl(id5),nsum=0
      eps_0=-p5(2)*p634(3)+p634(2)*p5(3)
      ceps_0=eps_0*cim
      ceps_1=p5(3)*cim
      ceps_2=p634(3)*cim
      auxa=-quqd+p5k0*p634(0)+p634k0*p5(0)
      lz5_634(0).a(1,1)=zcr(id5)*(auxa+ceps_0)
      lz5_634(0).a(2,2)=zcl(id5)*(auxa-ceps_0)
      lz5_634(0).b(1,2)=-zcl(id5)*(p634(2)+ceps_2)
      lz5_634(0).b(2,1)=zcr(id5)*(p634(2)-ceps_2)
      lz5_634(0).c(1,2)=zcr(id5)*(p5(2)+ceps_1)
      lz5_634(0).c(2,1)=zcl(id5)*(-p5(2)+ceps_1)
      lz5_634(0).d(1,1)=zcl(id5)
      lz5_634(0).d(2,2)=zcr(id5)
* T -- qu=p5,qd=p634,v=1,a=lz5_634(1).a,b=lz5_634(1).b,c=lz5_634(1).c,d=
* lz5_634(1).d,cr=zcr(id5),cl=zcl(id5),nsum=0
      auxa=-quqd+p5k0*p634(1)+p634k0*p5(1)
      lz5_634(1).a(1,1)=zcr(id5)*(auxa+ceps_0)
      lz5_634(1).a(2,2)=zcl(id5)*(auxa-ceps_0)
      lz5_634(1).b(1,2)=-zcl(id5)*(p634(2)+ceps_2)
      lz5_634(1).b(2,1)=zcr(id5)*(p634(2)-ceps_2)
      lz5_634(1).c(1,2)=zcr(id5)*(p5(2)+ceps_1)
      lz5_634(1).c(2,1)=zcl(id5)*(-p5(2)+ceps_1)
      lz5_634(1).d(1,1)=zcl(id5)
      lz5_634(1).d(2,2)=zcr(id5)
* T -- qu=p5,qd=p634,v=2,a=lz5_634(2).a,b=lz5_634(2).b,c=lz5_634(2).c,d=
* lz5_634(2).d,cr=zcr(id5),cl=zcl(id5),nsum=0
      eps_0=-p5k0*p634(3)+p634k0*p5(3)
      ceps_0=eps_0*cim
      auxa=p5k0*p634(2)+p634k0*p5(2)
      lz5_634(2).a(1,1)=zcr(id5)*(auxa+ceps_0)
      lz5_634(2).a(2,2)=zcl(id5)*(auxa-ceps_0)
      lz5_634(2).b(1,2)=-zcl(id5)*p634k0
      lz5_634(2).b(2,1)=zcr(id5)*p634k0
      lz5_634(2).c(1,2)=zcr(id5)*p5k0
      lz5_634(2).c(2,1)=-zcl(id5)*p5k0
* T -- qu=p5,qd=p634,v=3,a=lz5_634(3).a,b=lz5_634(3).b,c=lz5_634(3).c,d=
* lz5_634(3).d,cr=zcr(id5),cl=zcl(id5),nsum=0
      eps_0=p5k0*p634(2)-p634k0*p5(2)
      ceps_0=eps_0*cim
      ceps_1=p5k0*cim
      ceps_2=p634k0*cim
      auxa=+p5k0*p634(3)+p634k0*p5(3)
      lz5_634(3).a(1,1)=zcr(id5)*(auxa+ceps_0)
      lz5_634(3).a(2,2)=zcl(id5)*(auxa-ceps_0)
      lz5_634(3).b(1,2)=-zcl(id5)*ceps_2
      lz5_634(3).b(2,1)=-zcr(id5)*ceps_2
      lz5_634(3).c(1,2)=zcr(id5)*ceps_1
      lz5_634(3).c(2,1)=zcl(id5)*ceps_1
  
* T -- qu=p5,qd=p634,v=0,a=lf5_634(0).a,b=lf5_634(0).b,c=lf5_634(0).c,d=
* lf5_634(0).d,cr=fcr(id5),cl=fcl(id5),nsum=0
      eps_0=-p5(2)*p634(3)+p634(2)*p5(3)
      ceps_0=eps_0*cim
      ceps_1=p5(3)*cim
      ceps_2=p634(3)*cim
      auxa=-quqd+p5k0*p634(0)+p634k0*p5(0)
      lf5_634(0).a(1,1)=fcr(id5)*(auxa+ceps_0)
      lf5_634(0).a(2,2)=fcl(id5)*(auxa-ceps_0)
      lf5_634(0).b(1,2)=-fcl(id5)*(p634(2)+ceps_2)
      lf5_634(0).b(2,1)=fcr(id5)*(p634(2)-ceps_2)
      lf5_634(0).c(1,2)=fcr(id5)*(p5(2)+ceps_1)
      lf5_634(0).c(2,1)=fcl(id5)*(-p5(2)+ceps_1)
      lf5_634(0).d(1,1)=fcl(id5)
      lf5_634(0).d(2,2)=fcr(id5)
* T -- qu=p5,qd=p634,v=1,a=lf5_634(1).a,b=lf5_634(1).b,c=lf5_634(1).c,d=
* lf5_634(1).d,cr=fcr(id5),cl=fcl(id5),nsum=0
      auxa=-quqd+p5k0*p634(1)+p634k0*p5(1)
      lf5_634(1).a(1,1)=fcr(id5)*(auxa+ceps_0)
      lf5_634(1).a(2,2)=fcl(id5)*(auxa-ceps_0)
      lf5_634(1).b(1,2)=-fcl(id5)*(p634(2)+ceps_2)
      lf5_634(1).b(2,1)=fcr(id5)*(p634(2)-ceps_2)
      lf5_634(1).c(1,2)=fcr(id5)*(p5(2)+ceps_1)
      lf5_634(1).c(2,1)=fcl(id5)*(-p5(2)+ceps_1)
      lf5_634(1).d(1,1)=fcl(id5)
      lf5_634(1).d(2,2)=fcr(id5)
* T -- qu=p5,qd=p634,v=2,a=lf5_634(2).a,b=lf5_634(2).b,c=lf5_634(2).c,d=
* lf5_634(2).d,cr=fcr(id5),cl=fcl(id5),nsum=0
      eps_0=-p5k0*p634(3)+p634k0*p5(3)
      ceps_0=eps_0*cim
      auxa=p5k0*p634(2)+p634k0*p5(2)
      lf5_634(2).a(1,1)=fcr(id5)*(auxa+ceps_0)
      lf5_634(2).a(2,2)=fcl(id5)*(auxa-ceps_0)
      lf5_634(2).b(1,2)=-fcl(id5)*p634k0
      lf5_634(2).b(2,1)=fcr(id5)*p634k0
      lf5_634(2).c(1,2)=fcr(id5)*p5k0
      lf5_634(2).c(2,1)=-fcl(id5)*p5k0
* T -- qu=p5,qd=p634,v=3,a=lf5_634(3).a,b=lf5_634(3).b,c=lf5_634(3).c,d=
* lf5_634(3).d,cr=fcr(id5),cl=fcl(id5),nsum=0
      eps_0=p5k0*p634(2)-p634k0*p5(2)
      ceps_0=eps_0*cim
      ceps_1=p5k0*cim
      ceps_2=p634k0*cim
      auxa=+p5k0*p634(3)+p634k0*p5(3)
      lf5_634(3).a(1,1)=fcr(id5)*(auxa+ceps_0)
      lf5_634(3).a(2,2)=fcl(id5)*(auxa-ceps_0)
      lf5_634(3).b(1,2)=-fcl(id5)*ceps_2
      lf5_634(3).b(2,1)=-fcr(id5)*ceps_2
      lf5_634(3).c(1,2)=fcr(id5)*ceps_1
      lf5_634(3).c(2,1)=fcl(id5)*ceps_1
  
* quqd -- p=p5,q=p678
      quqd=p5(0)*p678(0)-p5(1)*p678(1)-p5(2)*p678(2)-p5(3)*p678(
     & 3)
* T -- qu=p5,qd=p678,v=0,a=lz5_678(0).a,b=lz5_678(0).b,c=lz5_678(0).c,d=
* lz5_678(0).d,cr=zcr(id5),cl=zcl(id5),nsum=0
      eps_0=-p5(2)*p678(3)+p678(2)*p5(3)
      ceps_0=eps_0*cim
      ceps_1=p5(3)*cim
      ceps_2=p678(3)*cim
      auxa=-quqd+p5k0*p678(0)+p678k0*p5(0)
      lz5_678(0).a(1,1)=zcr(id5)*(auxa+ceps_0)
      lz5_678(0).a(2,2)=zcl(id5)*(auxa-ceps_0)
      lz5_678(0).b(1,2)=-zcl(id5)*(p678(2)+ceps_2)
      lz5_678(0).b(2,1)=zcr(id5)*(p678(2)-ceps_2)
      lz5_678(0).c(1,2)=zcr(id5)*(p5(2)+ceps_1)
      lz5_678(0).c(2,1)=zcl(id5)*(-p5(2)+ceps_1)
      lz5_678(0).d(1,1)=zcl(id5)
      lz5_678(0).d(2,2)=zcr(id5)
* T -- qu=p5,qd=p678,v=1,a=lz5_678(1).a,b=lz5_678(1).b,c=lz5_678(1).c,d=
* lz5_678(1).d,cr=zcr(id5),cl=zcl(id5),nsum=0
      auxa=-quqd+p5k0*p678(1)+p678k0*p5(1)
      lz5_678(1).a(1,1)=zcr(id5)*(auxa+ceps_0)
      lz5_678(1).a(2,2)=zcl(id5)*(auxa-ceps_0)
      lz5_678(1).b(1,2)=-zcl(id5)*(p678(2)+ceps_2)
      lz5_678(1).b(2,1)=zcr(id5)*(p678(2)-ceps_2)
      lz5_678(1).c(1,2)=zcr(id5)*(p5(2)+ceps_1)
      lz5_678(1).c(2,1)=zcl(id5)*(-p5(2)+ceps_1)
      lz5_678(1).d(1,1)=zcl(id5)
      lz5_678(1).d(2,2)=zcr(id5)
* T -- qu=p5,qd=p678,v=2,a=lz5_678(2).a,b=lz5_678(2).b,c=lz5_678(2).c,d=
* lz5_678(2).d,cr=zcr(id5),cl=zcl(id5),nsum=0
      eps_0=-p5k0*p678(3)+p678k0*p5(3)
      ceps_0=eps_0*cim
      auxa=p5k0*p678(2)+p678k0*p5(2)
      lz5_678(2).a(1,1)=zcr(id5)*(auxa+ceps_0)
      lz5_678(2).a(2,2)=zcl(id5)*(auxa-ceps_0)
      lz5_678(2).b(1,2)=-zcl(id5)*p678k0
      lz5_678(2).b(2,1)=zcr(id5)*p678k0
      lz5_678(2).c(1,2)=zcr(id5)*p5k0
      lz5_678(2).c(2,1)=-zcl(id5)*p5k0
* T -- qu=p5,qd=p678,v=3,a=lz5_678(3).a,b=lz5_678(3).b,c=lz5_678(3).c,d=
* lz5_678(3).d,cr=zcr(id5),cl=zcl(id5),nsum=0
      eps_0=p5k0*p678(2)-p678k0*p5(2)
      ceps_0=eps_0*cim
      ceps_1=p5k0*cim
      ceps_2=p678k0*cim
      auxa=+p5k0*p678(3)+p678k0*p5(3)
      lz5_678(3).a(1,1)=zcr(id5)*(auxa+ceps_0)
      lz5_678(3).a(2,2)=zcl(id5)*(auxa-ceps_0)
      lz5_678(3).b(1,2)=-zcl(id5)*ceps_2
      lz5_678(3).b(2,1)=-zcr(id5)*ceps_2
      lz5_678(3).c(1,2)=zcr(id5)*ceps_1
      lz5_678(3).c(2,1)=zcl(id5)*ceps_1
  
* T -- qu=p5,qd=p678,v=0,a=lf5_678(0).a,b=lf5_678(0).b,c=lf5_678(0).c,d=
* lf5_678(0).d,cr=fcr(id5),cl=fcl(id5),nsum=0
      eps_0=-p5(2)*p678(3)+p678(2)*p5(3)
      ceps_0=eps_0*cim
      ceps_1=p5(3)*cim
      ceps_2=p678(3)*cim
      auxa=-quqd+p5k0*p678(0)+p678k0*p5(0)
      lf5_678(0).a(1,1)=fcr(id5)*(auxa+ceps_0)
      lf5_678(0).a(2,2)=fcl(id5)*(auxa-ceps_0)
      lf5_678(0).b(1,2)=-fcl(id5)*(p678(2)+ceps_2)
      lf5_678(0).b(2,1)=fcr(id5)*(p678(2)-ceps_2)
      lf5_678(0).c(1,2)=fcr(id5)*(p5(2)+ceps_1)
      lf5_678(0).c(2,1)=fcl(id5)*(-p5(2)+ceps_1)
      lf5_678(0).d(1,1)=fcl(id5)
      lf5_678(0).d(2,2)=fcr(id5)
* T -- qu=p5,qd=p678,v=1,a=lf5_678(1).a,b=lf5_678(1).b,c=lf5_678(1).c,d=
* lf5_678(1).d,cr=fcr(id5),cl=fcl(id5),nsum=0
      auxa=-quqd+p5k0*p678(1)+p678k0*p5(1)
      lf5_678(1).a(1,1)=fcr(id5)*(auxa+ceps_0)
      lf5_678(1).a(2,2)=fcl(id5)*(auxa-ceps_0)
      lf5_678(1).b(1,2)=-fcl(id5)*(p678(2)+ceps_2)
      lf5_678(1).b(2,1)=fcr(id5)*(p678(2)-ceps_2)
      lf5_678(1).c(1,2)=fcr(id5)*(p5(2)+ceps_1)
      lf5_678(1).c(2,1)=fcl(id5)*(-p5(2)+ceps_1)
      lf5_678(1).d(1,1)=fcl(id5)
      lf5_678(1).d(2,2)=fcr(id5)
* T -- qu=p5,qd=p678,v=2,a=lf5_678(2).a,b=lf5_678(2).b,c=lf5_678(2).c,d=
* lf5_678(2).d,cr=fcr(id5),cl=fcl(id5),nsum=0
      eps_0=-p5k0*p678(3)+p678k0*p5(3)
      ceps_0=eps_0*cim
      auxa=p5k0*p678(2)+p678k0*p5(2)
      lf5_678(2).a(1,1)=fcr(id5)*(auxa+ceps_0)
      lf5_678(2).a(2,2)=fcl(id5)*(auxa-ceps_0)
      lf5_678(2).b(1,2)=-fcl(id5)*p678k0
      lf5_678(2).b(2,1)=fcr(id5)*p678k0
      lf5_678(2).c(1,2)=fcr(id5)*p5k0
      lf5_678(2).c(2,1)=-fcl(id5)*p5k0
* T -- qu=p5,qd=p678,v=3,a=lf5_678(3).a,b=lf5_678(3).b,c=lf5_678(3).c,d=
* lf5_678(3).d,cr=fcr(id5),cl=fcl(id5),nsum=0
      eps_0=p5k0*p678(2)-p678k0*p5(2)
      ceps_0=eps_0*cim
      ceps_1=p5k0*cim
      ceps_2=p678k0*cim
      auxa=+p5k0*p678(3)+p678k0*p5(3)
      lf5_678(3).a(1,1)=fcr(id5)*(auxa+ceps_0)
      lf5_678(3).a(2,2)=fcl(id5)*(auxa-ceps_0)
      lf5_678(3).b(1,2)=-fcl(id5)*ceps_2
      lf5_678(3).b(2,1)=-fcr(id5)*ceps_2
      lf5_678(3).c(1,2)=fcr(id5)*ceps_1
      lf5_678(3).c(2,1)=fcl(id5)*ceps_1
  
* quqd -- p=p7,q=p812
      quqd=p7(0)*p812(0)-p7(1)*p812(1)-p7(2)*p812(2)-p7(3)*p812(
     & 3)
* T -- qu=p7,qd=p812,v=0,a=lz7_812(0).a,b=lz7_812(0).b,c=lz7_812(0).c,d=
* lz7_812(0).d,cr=zcr(id7),cl=zcl(id7),nsum=0
      eps_0=-p7(2)*p812(3)+p812(2)*p7(3)
      ceps_0=eps_0*cim
      ceps_1=p7(3)*cim
      ceps_2=p812(3)*cim
      auxa=-quqd+p7k0*p812(0)+p812k0*p7(0)
      lz7_812(0).a(1,1)=zcr(id7)*(auxa+ceps_0)
      lz7_812(0).a(2,2)=zcl(id7)*(auxa-ceps_0)
      lz7_812(0).b(1,2)=-zcl(id7)*(p812(2)+ceps_2)
      lz7_812(0).b(2,1)=zcr(id7)*(p812(2)-ceps_2)
      lz7_812(0).c(1,2)=zcr(id7)*(p7(2)+ceps_1)
      lz7_812(0).c(2,1)=zcl(id7)*(-p7(2)+ceps_1)
      lz7_812(0).d(1,1)=zcl(id7)
      lz7_812(0).d(2,2)=zcr(id7)
* T -- qu=p7,qd=p812,v=1,a=lz7_812(1).a,b=lz7_812(1).b,c=lz7_812(1).c,d=
* lz7_812(1).d,cr=zcr(id7),cl=zcl(id7),nsum=0
      auxa=-quqd+p7k0*p812(1)+p812k0*p7(1)
      lz7_812(1).a(1,1)=zcr(id7)*(auxa+ceps_0)
      lz7_812(1).a(2,2)=zcl(id7)*(auxa-ceps_0)
      lz7_812(1).b(1,2)=-zcl(id7)*(p812(2)+ceps_2)
      lz7_812(1).b(2,1)=zcr(id7)*(p812(2)-ceps_2)
      lz7_812(1).c(1,2)=zcr(id7)*(p7(2)+ceps_1)
      lz7_812(1).c(2,1)=zcl(id7)*(-p7(2)+ceps_1)
      lz7_812(1).d(1,1)=zcl(id7)
      lz7_812(1).d(2,2)=zcr(id7)
* T -- qu=p7,qd=p812,v=2,a=lz7_812(2).a,b=lz7_812(2).b,c=lz7_812(2).c,d=
* lz7_812(2).d,cr=zcr(id7),cl=zcl(id7),nsum=0
      eps_0=-p7k0*p812(3)+p812k0*p7(3)
      ceps_0=eps_0*cim
      auxa=p7k0*p812(2)+p812k0*p7(2)
      lz7_812(2).a(1,1)=zcr(id7)*(auxa+ceps_0)
      lz7_812(2).a(2,2)=zcl(id7)*(auxa-ceps_0)
      lz7_812(2).b(1,2)=-zcl(id7)*p812k0
      lz7_812(2).b(2,1)=zcr(id7)*p812k0
      lz7_812(2).c(1,2)=zcr(id7)*p7k0
      lz7_812(2).c(2,1)=-zcl(id7)*p7k0
* T -- qu=p7,qd=p812,v=3,a=lz7_812(3).a,b=lz7_812(3).b,c=lz7_812(3).c,d=
* lz7_812(3).d,cr=zcr(id7),cl=zcl(id7),nsum=0
      eps_0=p7k0*p812(2)-p812k0*p7(2)
      ceps_0=eps_0*cim
      ceps_1=p7k0*cim
      ceps_2=p812k0*cim
      auxa=+p7k0*p812(3)+p812k0*p7(3)
      lz7_812(3).a(1,1)=zcr(id7)*(auxa+ceps_0)
      lz7_812(3).a(2,2)=zcl(id7)*(auxa-ceps_0)
      lz7_812(3).b(1,2)=-zcl(id7)*ceps_2
      lz7_812(3).b(2,1)=-zcr(id7)*ceps_2
      lz7_812(3).c(1,2)=zcr(id7)*ceps_1
      lz7_812(3).c(2,1)=zcl(id7)*ceps_1
  
* T -- qu=p7,qd=p812,v=0,a=lf7_812(0).a,b=lf7_812(0).b,c=lf7_812(0).c,d=
* lf7_812(0).d,cr=fcr(id7),cl=fcl(id7),nsum=0
      eps_0=-p7(2)*p812(3)+p812(2)*p7(3)
      ceps_0=eps_0*cim
      ceps_1=p7(3)*cim
      ceps_2=p812(3)*cim
      auxa=-quqd+p7k0*p812(0)+p812k0*p7(0)
      lf7_812(0).a(1,1)=fcr(id7)*(auxa+ceps_0)
      lf7_812(0).a(2,2)=fcl(id7)*(auxa-ceps_0)
      lf7_812(0).b(1,2)=-fcl(id7)*(p812(2)+ceps_2)
      lf7_812(0).b(2,1)=fcr(id7)*(p812(2)-ceps_2)
      lf7_812(0).c(1,2)=fcr(id7)*(p7(2)+ceps_1)
      lf7_812(0).c(2,1)=fcl(id7)*(-p7(2)+ceps_1)
      lf7_812(0).d(1,1)=fcl(id7)
      lf7_812(0).d(2,2)=fcr(id7)
* T -- qu=p7,qd=p812,v=1,a=lf7_812(1).a,b=lf7_812(1).b,c=lf7_812(1).c,d=
* lf7_812(1).d,cr=fcr(id7),cl=fcl(id7),nsum=0
      auxa=-quqd+p7k0*p812(1)+p812k0*p7(1)
      lf7_812(1).a(1,1)=fcr(id7)*(auxa+ceps_0)
      lf7_812(1).a(2,2)=fcl(id7)*(auxa-ceps_0)
      lf7_812(1).b(1,2)=-fcl(id7)*(p812(2)+ceps_2)
      lf7_812(1).b(2,1)=fcr(id7)*(p812(2)-ceps_2)
      lf7_812(1).c(1,2)=fcr(id7)*(p7(2)+ceps_1)
      lf7_812(1).c(2,1)=fcl(id7)*(-p7(2)+ceps_1)
      lf7_812(1).d(1,1)=fcl(id7)
      lf7_812(1).d(2,2)=fcr(id7)
* T -- qu=p7,qd=p812,v=2,a=lf7_812(2).a,b=lf7_812(2).b,c=lf7_812(2).c,d=
* lf7_812(2).d,cr=fcr(id7),cl=fcl(id7),nsum=0
      eps_0=-p7k0*p812(3)+p812k0*p7(3)
      ceps_0=eps_0*cim
      auxa=p7k0*p812(2)+p812k0*p7(2)
      lf7_812(2).a(1,1)=fcr(id7)*(auxa+ceps_0)
      lf7_812(2).a(2,2)=fcl(id7)*(auxa-ceps_0)
      lf7_812(2).b(1,2)=-fcl(id7)*p812k0
      lf7_812(2).b(2,1)=fcr(id7)*p812k0
      lf7_812(2).c(1,2)=fcr(id7)*p7k0
      lf7_812(2).c(2,1)=-fcl(id7)*p7k0
* T -- qu=p7,qd=p812,v=3,a=lf7_812(3).a,b=lf7_812(3).b,c=lf7_812(3).c,d=
* lf7_812(3).d,cr=fcr(id7),cl=fcl(id7),nsum=0
      eps_0=p7k0*p812(2)-p812k0*p7(2)
      ceps_0=eps_0*cim
      ceps_1=p7k0*cim
      ceps_2=p812k0*cim
      auxa=+p7k0*p812(3)+p812k0*p7(3)
      lf7_812(3).a(1,1)=fcr(id7)*(auxa+ceps_0)
      lf7_812(3).a(2,2)=fcl(id7)*(auxa-ceps_0)
      lf7_812(3).b(1,2)=-fcl(id7)*ceps_2
      lf7_812(3).b(2,1)=-fcr(id7)*ceps_2
      lf7_812(3).c(1,2)=fcr(id7)*ceps_1
      lf7_812(3).c(2,1)=fcl(id7)*ceps_1
  
* quqd -- p=p7,q=p834
      quqd=p7(0)*p834(0)-p7(1)*p834(1)-p7(2)*p834(2)-p7(3)*p834(
     & 3)
* T -- qu=p7,qd=p834,v=0,a=lz7_834(0).a,b=lz7_834(0).b,c=lz7_834(0).c,d=
* lz7_834(0).d,cr=zcr(id7),cl=zcl(id7),nsum=0
      eps_0=-p7(2)*p834(3)+p834(2)*p7(3)
      ceps_0=eps_0*cim
      ceps_1=p7(3)*cim
      ceps_2=p834(3)*cim
      auxa=-quqd+p7k0*p834(0)+p834k0*p7(0)
      lz7_834(0).a(1,1)=zcr(id7)*(auxa+ceps_0)
      lz7_834(0).a(2,2)=zcl(id7)*(auxa-ceps_0)
      lz7_834(0).b(1,2)=-zcl(id7)*(p834(2)+ceps_2)
      lz7_834(0).b(2,1)=zcr(id7)*(p834(2)-ceps_2)
      lz7_834(0).c(1,2)=zcr(id7)*(p7(2)+ceps_1)
      lz7_834(0).c(2,1)=zcl(id7)*(-p7(2)+ceps_1)
      lz7_834(0).d(1,1)=zcl(id7)
      lz7_834(0).d(2,2)=zcr(id7)
* T -- qu=p7,qd=p834,v=1,a=lz7_834(1).a,b=lz7_834(1).b,c=lz7_834(1).c,d=
* lz7_834(1).d,cr=zcr(id7),cl=zcl(id7),nsum=0
      auxa=-quqd+p7k0*p834(1)+p834k0*p7(1)
      lz7_834(1).a(1,1)=zcr(id7)*(auxa+ceps_0)
      lz7_834(1).a(2,2)=zcl(id7)*(auxa-ceps_0)
      lz7_834(1).b(1,2)=-zcl(id7)*(p834(2)+ceps_2)
      lz7_834(1).b(2,1)=zcr(id7)*(p834(2)-ceps_2)
      lz7_834(1).c(1,2)=zcr(id7)*(p7(2)+ceps_1)
      lz7_834(1).c(2,1)=zcl(id7)*(-p7(2)+ceps_1)
      lz7_834(1).d(1,1)=zcl(id7)
      lz7_834(1).d(2,2)=zcr(id7)
* T -- qu=p7,qd=p834,v=2,a=lz7_834(2).a,b=lz7_834(2).b,c=lz7_834(2).c,d=
* lz7_834(2).d,cr=zcr(id7),cl=zcl(id7),nsum=0
      eps_0=-p7k0*p834(3)+p834k0*p7(3)
      ceps_0=eps_0*cim
      auxa=p7k0*p834(2)+p834k0*p7(2)
      lz7_834(2).a(1,1)=zcr(id7)*(auxa+ceps_0)
      lz7_834(2).a(2,2)=zcl(id7)*(auxa-ceps_0)
      lz7_834(2).b(1,2)=-zcl(id7)*p834k0
      lz7_834(2).b(2,1)=zcr(id7)*p834k0
      lz7_834(2).c(1,2)=zcr(id7)*p7k0
      lz7_834(2).c(2,1)=-zcl(id7)*p7k0
* T -- qu=p7,qd=p834,v=3,a=lz7_834(3).a,b=lz7_834(3).b,c=lz7_834(3).c,d=
* lz7_834(3).d,cr=zcr(id7),cl=zcl(id7),nsum=0
      eps_0=p7k0*p834(2)-p834k0*p7(2)
      ceps_0=eps_0*cim
      ceps_1=p7k0*cim
      ceps_2=p834k0*cim
      auxa=+p7k0*p834(3)+p834k0*p7(3)
      lz7_834(3).a(1,1)=zcr(id7)*(auxa+ceps_0)
      lz7_834(3).a(2,2)=zcl(id7)*(auxa-ceps_0)
      lz7_834(3).b(1,2)=-zcl(id7)*ceps_2
      lz7_834(3).b(2,1)=-zcr(id7)*ceps_2
      lz7_834(3).c(1,2)=zcr(id7)*ceps_1
      lz7_834(3).c(2,1)=zcl(id7)*ceps_1
  
* T -- qu=p7,qd=p834,v=0,a=lf7_834(0).a,b=lf7_834(0).b,c=lf7_834(0).c,d=
* lf7_834(0).d,cr=fcr(id7),cl=fcl(id7),nsum=0
      eps_0=-p7(2)*p834(3)+p834(2)*p7(3)
      ceps_0=eps_0*cim
      ceps_1=p7(3)*cim
      ceps_2=p834(3)*cim
      auxa=-quqd+p7k0*p834(0)+p834k0*p7(0)
      lf7_834(0).a(1,1)=fcr(id7)*(auxa+ceps_0)
      lf7_834(0).a(2,2)=fcl(id7)*(auxa-ceps_0)
      lf7_834(0).b(1,2)=-fcl(id7)*(p834(2)+ceps_2)
      lf7_834(0).b(2,1)=fcr(id7)*(p834(2)-ceps_2)
      lf7_834(0).c(1,2)=fcr(id7)*(p7(2)+ceps_1)
      lf7_834(0).c(2,1)=fcl(id7)*(-p7(2)+ceps_1)
      lf7_834(0).d(1,1)=fcl(id7)
      lf7_834(0).d(2,2)=fcr(id7)
* T -- qu=p7,qd=p834,v=1,a=lf7_834(1).a,b=lf7_834(1).b,c=lf7_834(1).c,d=
* lf7_834(1).d,cr=fcr(id7),cl=fcl(id7),nsum=0
      auxa=-quqd+p7k0*p834(1)+p834k0*p7(1)
      lf7_834(1).a(1,1)=fcr(id7)*(auxa+ceps_0)
      lf7_834(1).a(2,2)=fcl(id7)*(auxa-ceps_0)
      lf7_834(1).b(1,2)=-fcl(id7)*(p834(2)+ceps_2)
      lf7_834(1).b(2,1)=fcr(id7)*(p834(2)-ceps_2)
      lf7_834(1).c(1,2)=fcr(id7)*(p7(2)+ceps_1)
      lf7_834(1).c(2,1)=fcl(id7)*(-p7(2)+ceps_1)
      lf7_834(1).d(1,1)=fcl(id7)
      lf7_834(1).d(2,2)=fcr(id7)
* T -- qu=p7,qd=p834,v=2,a=lf7_834(2).a,b=lf7_834(2).b,c=lf7_834(2).c,d=
* lf7_834(2).d,cr=fcr(id7),cl=fcl(id7),nsum=0
      eps_0=-p7k0*p834(3)+p834k0*p7(3)
      ceps_0=eps_0*cim
      auxa=p7k0*p834(2)+p834k0*p7(2)
      lf7_834(2).a(1,1)=fcr(id7)*(auxa+ceps_0)
      lf7_834(2).a(2,2)=fcl(id7)*(auxa-ceps_0)
      lf7_834(2).b(1,2)=-fcl(id7)*p834k0
      lf7_834(2).b(2,1)=fcr(id7)*p834k0
      lf7_834(2).c(1,2)=fcr(id7)*p7k0
      lf7_834(2).c(2,1)=-fcl(id7)*p7k0
* T -- qu=p7,qd=p834,v=3,a=lf7_834(3).a,b=lf7_834(3).b,c=lf7_834(3).c,d=
* lf7_834(3).d,cr=fcr(id7),cl=fcl(id7),nsum=0
      eps_0=p7k0*p834(2)-p834k0*p7(2)
      ceps_0=eps_0*cim
      ceps_1=p7k0*cim
      ceps_2=p834k0*cim
      auxa=+p7k0*p834(3)+p834k0*p7(3)
      lf7_834(3).a(1,1)=fcr(id7)*(auxa+ceps_0)
      lf7_834(3).a(2,2)=fcl(id7)*(auxa-ceps_0)
      lf7_834(3).b(1,2)=-fcl(id7)*ceps_2
      lf7_834(3).b(2,1)=-fcr(id7)*ceps_2
      lf7_834(3).c(1,2)=fcr(id7)*ceps_1
      lf7_834(3).c(2,1)=fcl(id7)*ceps_1
  
* quqd -- p=p7,q=p856
      quqd=p7(0)*p856(0)-p7(1)*p856(1)-p7(2)*p856(2)-p7(3)*p856(
     & 3)
* T -- qu=p7,qd=p856,v=0,a=lz7_856(0).a,b=lz7_856(0).b,c=lz7_856(0).c,d=
* lz7_856(0).d,cr=zcr(id7),cl=zcl(id7),nsum=0
      eps_0=-p7(2)*p856(3)+p856(2)*p7(3)
      ceps_0=eps_0*cim
      ceps_1=p7(3)*cim
      ceps_2=p856(3)*cim
      auxa=-quqd+p7k0*p856(0)+p856k0*p7(0)
      lz7_856(0).a(1,1)=zcr(id7)*(auxa+ceps_0)
      lz7_856(0).a(2,2)=zcl(id7)*(auxa-ceps_0)
      lz7_856(0).b(1,2)=-zcl(id7)*(p856(2)+ceps_2)
      lz7_856(0).b(2,1)=zcr(id7)*(p856(2)-ceps_2)
      lz7_856(0).c(1,2)=zcr(id7)*(p7(2)+ceps_1)
      lz7_856(0).c(2,1)=zcl(id7)*(-p7(2)+ceps_1)
      lz7_856(0).d(1,1)=zcl(id7)
      lz7_856(0).d(2,2)=zcr(id7)
* T -- qu=p7,qd=p856,v=1,a=lz7_856(1).a,b=lz7_856(1).b,c=lz7_856(1).c,d=
* lz7_856(1).d,cr=zcr(id7),cl=zcl(id7),nsum=0
      auxa=-quqd+p7k0*p856(1)+p856k0*p7(1)
      lz7_856(1).a(1,1)=zcr(id7)*(auxa+ceps_0)
      lz7_856(1).a(2,2)=zcl(id7)*(auxa-ceps_0)
      lz7_856(1).b(1,2)=-zcl(id7)*(p856(2)+ceps_2)
      lz7_856(1).b(2,1)=zcr(id7)*(p856(2)-ceps_2)
      lz7_856(1).c(1,2)=zcr(id7)*(p7(2)+ceps_1)
      lz7_856(1).c(2,1)=zcl(id7)*(-p7(2)+ceps_1)
      lz7_856(1).d(1,1)=zcl(id7)
      lz7_856(1).d(2,2)=zcr(id7)
* T -- qu=p7,qd=p856,v=2,a=lz7_856(2).a,b=lz7_856(2).b,c=lz7_856(2).c,d=
* lz7_856(2).d,cr=zcr(id7),cl=zcl(id7),nsum=0
      eps_0=-p7k0*p856(3)+p856k0*p7(3)
      ceps_0=eps_0*cim
      auxa=p7k0*p856(2)+p856k0*p7(2)
      lz7_856(2).a(1,1)=zcr(id7)*(auxa+ceps_0)
      lz7_856(2).a(2,2)=zcl(id7)*(auxa-ceps_0)
      lz7_856(2).b(1,2)=-zcl(id7)*p856k0
      lz7_856(2).b(2,1)=zcr(id7)*p856k0
      lz7_856(2).c(1,2)=zcr(id7)*p7k0
      lz7_856(2).c(2,1)=-zcl(id7)*p7k0
* T -- qu=p7,qd=p856,v=3,a=lz7_856(3).a,b=lz7_856(3).b,c=lz7_856(3).c,d=
* lz7_856(3).d,cr=zcr(id7),cl=zcl(id7),nsum=0
      eps_0=p7k0*p856(2)-p856k0*p7(2)
      ceps_0=eps_0*cim
      ceps_1=p7k0*cim
      ceps_2=p856k0*cim
      auxa=+p7k0*p856(3)+p856k0*p7(3)
      lz7_856(3).a(1,1)=zcr(id7)*(auxa+ceps_0)
      lz7_856(3).a(2,2)=zcl(id7)*(auxa-ceps_0)
      lz7_856(3).b(1,2)=-zcl(id7)*ceps_2
      lz7_856(3).b(2,1)=-zcr(id7)*ceps_2
      lz7_856(3).c(1,2)=zcr(id7)*ceps_1
      lz7_856(3).c(2,1)=zcl(id7)*ceps_1
  
* T -- qu=p7,qd=p856,v=0,a=lf7_856(0).a,b=lf7_856(0).b,c=lf7_856(0).c,d=
* lf7_856(0).d,cr=fcr(id7),cl=fcl(id7),nsum=0
      eps_0=-p7(2)*p856(3)+p856(2)*p7(3)
      ceps_0=eps_0*cim
      ceps_1=p7(3)*cim
      ceps_2=p856(3)*cim
      auxa=-quqd+p7k0*p856(0)+p856k0*p7(0)
      lf7_856(0).a(1,1)=fcr(id7)*(auxa+ceps_0)
      lf7_856(0).a(2,2)=fcl(id7)*(auxa-ceps_0)
      lf7_856(0).b(1,2)=-fcl(id7)*(p856(2)+ceps_2)
      lf7_856(0).b(2,1)=fcr(id7)*(p856(2)-ceps_2)
      lf7_856(0).c(1,2)=fcr(id7)*(p7(2)+ceps_1)
      lf7_856(0).c(2,1)=fcl(id7)*(-p7(2)+ceps_1)
      lf7_856(0).d(1,1)=fcl(id7)
      lf7_856(0).d(2,2)=fcr(id7)
* T -- qu=p7,qd=p856,v=1,a=lf7_856(1).a,b=lf7_856(1).b,c=lf7_856(1).c,d=
* lf7_856(1).d,cr=fcr(id7),cl=fcl(id7),nsum=0
      auxa=-quqd+p7k0*p856(1)+p856k0*p7(1)
      lf7_856(1).a(1,1)=fcr(id7)*(auxa+ceps_0)
      lf7_856(1).a(2,2)=fcl(id7)*(auxa-ceps_0)
      lf7_856(1).b(1,2)=-fcl(id7)*(p856(2)+ceps_2)
      lf7_856(1).b(2,1)=fcr(id7)*(p856(2)-ceps_2)
      lf7_856(1).c(1,2)=fcr(id7)*(p7(2)+ceps_1)
      lf7_856(1).c(2,1)=fcl(id7)*(-p7(2)+ceps_1)
      lf7_856(1).d(1,1)=fcl(id7)
      lf7_856(1).d(2,2)=fcr(id7)
* T -- qu=p7,qd=p856,v=2,a=lf7_856(2).a,b=lf7_856(2).b,c=lf7_856(2).c,d=
* lf7_856(2).d,cr=fcr(id7),cl=fcl(id7),nsum=0
      eps_0=-p7k0*p856(3)+p856k0*p7(3)
      ceps_0=eps_0*cim
      auxa=p7k0*p856(2)+p856k0*p7(2)
      lf7_856(2).a(1,1)=fcr(id7)*(auxa+ceps_0)
      lf7_856(2).a(2,2)=fcl(id7)*(auxa-ceps_0)
      lf7_856(2).b(1,2)=-fcl(id7)*p856k0
      lf7_856(2).b(2,1)=fcr(id7)*p856k0
      lf7_856(2).c(1,2)=fcr(id7)*p7k0
      lf7_856(2).c(2,1)=-fcl(id7)*p7k0
* T -- qu=p7,qd=p856,v=3,a=lf7_856(3).a,b=lf7_856(3).b,c=lf7_856(3).c,d=
* lf7_856(3).d,cr=fcr(id7),cl=fcl(id7),nsum=0
      eps_0=p7k0*p856(2)-p856k0*p7(2)
      ceps_0=eps_0*cim
      ceps_1=p7k0*cim
      ceps_2=p856k0*cim
      auxa=+p7k0*p856(3)+p856k0*p7(3)
      lf7_856(3).a(1,1)=fcr(id7)*(auxa+ceps_0)
      lf7_856(3).a(2,2)=fcl(id7)*(auxa-ceps_0)
      lf7_856(3).b(1,2)=-fcl(id7)*ceps_2
      lf7_856(3).b(2,1)=-fcr(id7)*ceps_2
      lf7_856(3).c(1,2)=fcr(id7)*ceps_1
      lf7_856(3).c(2,1)=fcl(id7)*ceps_1
  
  
  
* compute all single insertions of the type rzi_ and rfi_ (i=2,4)       
*    to a Zline                                                         
*                                                                       
*            |_Z__(mu)         |__f__(mu)                               
*        i __|             i __|                                        
*                                                                       
  
  
* quqd -- p=p134,q=p2
      quqd=p134(0)*p2(0)-p134(1)*p2(1)-p134(2)*p2(2)-p134(3)*p2(
     & 3)
* T -- qu=p134,qd=p2,v=0,a=rz2_134(0).a,b=rz2_134(0).b,c=rz2_134(0).c,d=
* rz2_134(0).d,cr=zcr(id2),cl=zcl(id2),nsum=0
      eps_0=-p134(2)*p2(3)+p2(2)*p134(3)
      ceps_0=eps_0*cim
      ceps_1=p134(3)*cim
      ceps_2=p2(3)*cim
      auxa=-quqd+p134k0*p2(0)+p2k0*p134(0)
      rz2_134(0).a(1,1)=zcr(id2)*(auxa+ceps_0)
      rz2_134(0).a(2,2)=zcl(id2)*(auxa-ceps_0)
      rz2_134(0).b(1,2)=-zcl(id2)*(p2(2)+ceps_2)
      rz2_134(0).b(2,1)=zcr(id2)*(p2(2)-ceps_2)
      rz2_134(0).c(1,2)=zcr(id2)*(p134(2)+ceps_1)
      rz2_134(0).c(2,1)=zcl(id2)*(-p134(2)+ceps_1)
      rz2_134(0).d(1,1)=zcl(id2)
      rz2_134(0).d(2,2)=zcr(id2)
* T -- qu=p134,qd=p2,v=1,a=rz2_134(1).a,b=rz2_134(1).b,c=rz2_134(1).c,d=
* rz2_134(1).d,cr=zcr(id2),cl=zcl(id2),nsum=0
      auxa=-quqd+p134k0*p2(1)+p2k0*p134(1)
      rz2_134(1).a(1,1)=zcr(id2)*(auxa+ceps_0)
      rz2_134(1).a(2,2)=zcl(id2)*(auxa-ceps_0)
      rz2_134(1).b(1,2)=-zcl(id2)*(p2(2)+ceps_2)
      rz2_134(1).b(2,1)=zcr(id2)*(p2(2)-ceps_2)
      rz2_134(1).c(1,2)=zcr(id2)*(p134(2)+ceps_1)
      rz2_134(1).c(2,1)=zcl(id2)*(-p134(2)+ceps_1)
      rz2_134(1).d(1,1)=zcl(id2)
      rz2_134(1).d(2,2)=zcr(id2)
* T -- qu=p134,qd=p2,v=2,a=rz2_134(2).a,b=rz2_134(2).b,c=rz2_134(2).c,d=
* rz2_134(2).d,cr=zcr(id2),cl=zcl(id2),nsum=0
      eps_0=-p134k0*p2(3)+p2k0*p134(3)
      ceps_0=eps_0*cim
      auxa=p134k0*p2(2)+p2k0*p134(2)
      rz2_134(2).a(1,1)=zcr(id2)*(auxa+ceps_0)
      rz2_134(2).a(2,2)=zcl(id2)*(auxa-ceps_0)
      rz2_134(2).b(1,2)=-zcl(id2)*p2k0
      rz2_134(2).b(2,1)=zcr(id2)*p2k0
      rz2_134(2).c(1,2)=zcr(id2)*p134k0
      rz2_134(2).c(2,1)=-zcl(id2)*p134k0
* T -- qu=p134,qd=p2,v=3,a=rz2_134(3).a,b=rz2_134(3).b,c=rz2_134(3).c,d=
* rz2_134(3).d,cr=zcr(id2),cl=zcl(id2),nsum=0
      eps_0=p134k0*p2(2)-p2k0*p134(2)
      ceps_0=eps_0*cim
      ceps_1=p134k0*cim
      ceps_2=p2k0*cim
      auxa=+p134k0*p2(3)+p2k0*p134(3)
      rz2_134(3).a(1,1)=zcr(id2)*(auxa+ceps_0)
      rz2_134(3).a(2,2)=zcl(id2)*(auxa-ceps_0)
      rz2_134(3).b(1,2)=-zcl(id2)*ceps_2
      rz2_134(3).b(2,1)=-zcr(id2)*ceps_2
      rz2_134(3).c(1,2)=zcr(id2)*ceps_1
      rz2_134(3).c(2,1)=zcl(id2)*ceps_1
  
* T -- qu=p134,qd=p2,v=0,a=rf2_134(0).a,b=rf2_134(0).b,c=rf2_134(0).c,d=
* rf2_134(0).d,cr=fcr(id2),cl=fcl(id2),nsum=0
      eps_0=-p134(2)*p2(3)+p2(2)*p134(3)
      ceps_0=eps_0*cim
      ceps_1=p134(3)*cim
      ceps_2=p2(3)*cim
      auxa=-quqd+p134k0*p2(0)+p2k0*p134(0)
      rf2_134(0).a(1,1)=fcr(id2)*(auxa+ceps_0)
      rf2_134(0).a(2,2)=fcl(id2)*(auxa-ceps_0)
      rf2_134(0).b(1,2)=-fcl(id2)*(p2(2)+ceps_2)
      rf2_134(0).b(2,1)=fcr(id2)*(p2(2)-ceps_2)
      rf2_134(0).c(1,2)=fcr(id2)*(p134(2)+ceps_1)
      rf2_134(0).c(2,1)=fcl(id2)*(-p134(2)+ceps_1)
      rf2_134(0).d(1,1)=fcl(id2)
      rf2_134(0).d(2,2)=fcr(id2)
* T -- qu=p134,qd=p2,v=1,a=rf2_134(1).a,b=rf2_134(1).b,c=rf2_134(1).c,d=
* rf2_134(1).d,cr=fcr(id2),cl=fcl(id2),nsum=0
      auxa=-quqd+p134k0*p2(1)+p2k0*p134(1)
      rf2_134(1).a(1,1)=fcr(id2)*(auxa+ceps_0)
      rf2_134(1).a(2,2)=fcl(id2)*(auxa-ceps_0)
      rf2_134(1).b(1,2)=-fcl(id2)*(p2(2)+ceps_2)
      rf2_134(1).b(2,1)=fcr(id2)*(p2(2)-ceps_2)
      rf2_134(1).c(1,2)=fcr(id2)*(p134(2)+ceps_1)
      rf2_134(1).c(2,1)=fcl(id2)*(-p134(2)+ceps_1)
      rf2_134(1).d(1,1)=fcl(id2)
      rf2_134(1).d(2,2)=fcr(id2)
* T -- qu=p134,qd=p2,v=2,a=rf2_134(2).a,b=rf2_134(2).b,c=rf2_134(2).c,d=
* rf2_134(2).d,cr=fcr(id2),cl=fcl(id2),nsum=0
      eps_0=-p134k0*p2(3)+p2k0*p134(3)
      ceps_0=eps_0*cim
      auxa=p134k0*p2(2)+p2k0*p134(2)
      rf2_134(2).a(1,1)=fcr(id2)*(auxa+ceps_0)
      rf2_134(2).a(2,2)=fcl(id2)*(auxa-ceps_0)
      rf2_134(2).b(1,2)=-fcl(id2)*p2k0
      rf2_134(2).b(2,1)=fcr(id2)*p2k0
      rf2_134(2).c(1,2)=fcr(id2)*p134k0
      rf2_134(2).c(2,1)=-fcl(id2)*p134k0
* T -- qu=p134,qd=p2,v=3,a=rf2_134(3).a,b=rf2_134(3).b,c=rf2_134(3).c,d=
* rf2_134(3).d,cr=fcr(id2),cl=fcl(id2),nsum=0
      eps_0=p134k0*p2(2)-p2k0*p134(2)
      ceps_0=eps_0*cim
      ceps_1=p134k0*cim
      ceps_2=p2k0*cim
      auxa=+p134k0*p2(3)+p2k0*p134(3)
      rf2_134(3).a(1,1)=fcr(id2)*(auxa+ceps_0)
      rf2_134(3).a(2,2)=fcl(id2)*(auxa-ceps_0)
      rf2_134(3).b(1,2)=-fcl(id2)*ceps_2
      rf2_134(3).b(2,1)=-fcr(id2)*ceps_2
      rf2_134(3).c(1,2)=fcr(id2)*ceps_1
      rf2_134(3).c(2,1)=fcl(id2)*ceps_1
  
* quqd -- p=p156,q=p2
      quqd=p156(0)*p2(0)-p156(1)*p2(1)-p156(2)*p2(2)-p156(3)*p2(
     & 3)
* T -- qu=p156,qd=p2,v=0,a=rz2_156(0).a,b=rz2_156(0).b,c=rz2_156(0).c,d=
* rz2_156(0).d,cr=zcr(id2),cl=zcl(id2),nsum=0
      eps_0=-p156(2)*p2(3)+p2(2)*p156(3)
      ceps_0=eps_0*cim
      ceps_1=p156(3)*cim
      ceps_2=p2(3)*cim
      auxa=-quqd+p156k0*p2(0)+p2k0*p156(0)
      rz2_156(0).a(1,1)=zcr(id2)*(auxa+ceps_0)
      rz2_156(0).a(2,2)=zcl(id2)*(auxa-ceps_0)
      rz2_156(0).b(1,2)=-zcl(id2)*(p2(2)+ceps_2)
      rz2_156(0).b(2,1)=zcr(id2)*(p2(2)-ceps_2)
      rz2_156(0).c(1,2)=zcr(id2)*(p156(2)+ceps_1)
      rz2_156(0).c(2,1)=zcl(id2)*(-p156(2)+ceps_1)
      rz2_156(0).d(1,1)=zcl(id2)
      rz2_156(0).d(2,2)=zcr(id2)
* T -- qu=p156,qd=p2,v=1,a=rz2_156(1).a,b=rz2_156(1).b,c=rz2_156(1).c,d=
* rz2_156(1).d,cr=zcr(id2),cl=zcl(id2),nsum=0
      auxa=-quqd+p156k0*p2(1)+p2k0*p156(1)
      rz2_156(1).a(1,1)=zcr(id2)*(auxa+ceps_0)
      rz2_156(1).a(2,2)=zcl(id2)*(auxa-ceps_0)
      rz2_156(1).b(1,2)=-zcl(id2)*(p2(2)+ceps_2)
      rz2_156(1).b(2,1)=zcr(id2)*(p2(2)-ceps_2)
      rz2_156(1).c(1,2)=zcr(id2)*(p156(2)+ceps_1)
      rz2_156(1).c(2,1)=zcl(id2)*(-p156(2)+ceps_1)
      rz2_156(1).d(1,1)=zcl(id2)
      rz2_156(1).d(2,2)=zcr(id2)
* T -- qu=p156,qd=p2,v=2,a=rz2_156(2).a,b=rz2_156(2).b,c=rz2_156(2).c,d=
* rz2_156(2).d,cr=zcr(id2),cl=zcl(id2),nsum=0
      eps_0=-p156k0*p2(3)+p2k0*p156(3)
      ceps_0=eps_0*cim
      auxa=p156k0*p2(2)+p2k0*p156(2)
      rz2_156(2).a(1,1)=zcr(id2)*(auxa+ceps_0)
      rz2_156(2).a(2,2)=zcl(id2)*(auxa-ceps_0)
      rz2_156(2).b(1,2)=-zcl(id2)*p2k0
      rz2_156(2).b(2,1)=zcr(id2)*p2k0
      rz2_156(2).c(1,2)=zcr(id2)*p156k0
      rz2_156(2).c(2,1)=-zcl(id2)*p156k0
* T -- qu=p156,qd=p2,v=3,a=rz2_156(3).a,b=rz2_156(3).b,c=rz2_156(3).c,d=
* rz2_156(3).d,cr=zcr(id2),cl=zcl(id2),nsum=0
      eps_0=p156k0*p2(2)-p2k0*p156(2)
      ceps_0=eps_0*cim
      ceps_1=p156k0*cim
      ceps_2=p2k0*cim
      auxa=+p156k0*p2(3)+p2k0*p156(3)
      rz2_156(3).a(1,1)=zcr(id2)*(auxa+ceps_0)
      rz2_156(3).a(2,2)=zcl(id2)*(auxa-ceps_0)
      rz2_156(3).b(1,2)=-zcl(id2)*ceps_2
      rz2_156(3).b(2,1)=-zcr(id2)*ceps_2
      rz2_156(3).c(1,2)=zcr(id2)*ceps_1
      rz2_156(3).c(2,1)=zcl(id2)*ceps_1
  
* T -- qu=p156,qd=p2,v=0,a=rf2_156(0).a,b=rf2_156(0).b,c=rf2_156(0).c,d=
* rf2_156(0).d,cr=fcr(id2),cl=fcl(id2),nsum=0
      eps_0=-p156(2)*p2(3)+p2(2)*p156(3)
      ceps_0=eps_0*cim
      ceps_1=p156(3)*cim
      ceps_2=p2(3)*cim
      auxa=-quqd+p156k0*p2(0)+p2k0*p156(0)
      rf2_156(0).a(1,1)=fcr(id2)*(auxa+ceps_0)
      rf2_156(0).a(2,2)=fcl(id2)*(auxa-ceps_0)
      rf2_156(0).b(1,2)=-fcl(id2)*(p2(2)+ceps_2)
      rf2_156(0).b(2,1)=fcr(id2)*(p2(2)-ceps_2)
      rf2_156(0).c(1,2)=fcr(id2)*(p156(2)+ceps_1)
      rf2_156(0).c(2,1)=fcl(id2)*(-p156(2)+ceps_1)
      rf2_156(0).d(1,1)=fcl(id2)
      rf2_156(0).d(2,2)=fcr(id2)
* T -- qu=p156,qd=p2,v=1,a=rf2_156(1).a,b=rf2_156(1).b,c=rf2_156(1).c,d=
* rf2_156(1).d,cr=fcr(id2),cl=fcl(id2),nsum=0
      auxa=-quqd+p156k0*p2(1)+p2k0*p156(1)
      rf2_156(1).a(1,1)=fcr(id2)*(auxa+ceps_0)
      rf2_156(1).a(2,2)=fcl(id2)*(auxa-ceps_0)
      rf2_156(1).b(1,2)=-fcl(id2)*(p2(2)+ceps_2)
      rf2_156(1).b(2,1)=fcr(id2)*(p2(2)-ceps_2)
      rf2_156(1).c(1,2)=fcr(id2)*(p156(2)+ceps_1)
      rf2_156(1).c(2,1)=fcl(id2)*(-p156(2)+ceps_1)
      rf2_156(1).d(1,1)=fcl(id2)
      rf2_156(1).d(2,2)=fcr(id2)
* T -- qu=p156,qd=p2,v=2,a=rf2_156(2).a,b=rf2_156(2).b,c=rf2_156(2).c,d=
* rf2_156(2).d,cr=fcr(id2),cl=fcl(id2),nsum=0
      eps_0=-p156k0*p2(3)+p2k0*p156(3)
      ceps_0=eps_0*cim
      auxa=p156k0*p2(2)+p2k0*p156(2)
      rf2_156(2).a(1,1)=fcr(id2)*(auxa+ceps_0)
      rf2_156(2).a(2,2)=fcl(id2)*(auxa-ceps_0)
      rf2_156(2).b(1,2)=-fcl(id2)*p2k0
      rf2_156(2).b(2,1)=fcr(id2)*p2k0
      rf2_156(2).c(1,2)=fcr(id2)*p156k0
      rf2_156(2).c(2,1)=-fcl(id2)*p156k0
* T -- qu=p156,qd=p2,v=3,a=rf2_156(3).a,b=rf2_156(3).b,c=rf2_156(3).c,d=
* rf2_156(3).d,cr=fcr(id2),cl=fcl(id2),nsum=0
      eps_0=p156k0*p2(2)-p2k0*p156(2)
      ceps_0=eps_0*cim
      ceps_1=p156k0*cim
      ceps_2=p2k0*cim
      auxa=+p156k0*p2(3)+p2k0*p156(3)
      rf2_156(3).a(1,1)=fcr(id2)*(auxa+ceps_0)
      rf2_156(3).a(2,2)=fcl(id2)*(auxa-ceps_0)
      rf2_156(3).b(1,2)=-fcl(id2)*ceps_2
      rf2_156(3).b(2,1)=-fcr(id2)*ceps_2
      rf2_156(3).c(1,2)=fcr(id2)*ceps_1
      rf2_156(3).c(2,1)=fcl(id2)*ceps_1
  
* quqd -- p=p178,q=p2
      quqd=p178(0)*p2(0)-p178(1)*p2(1)-p178(2)*p2(2)-p178(3)*p2(
     & 3)
* T -- qu=p178,qd=p2,v=0,a=rz2_178(0).a,b=rz2_178(0).b,c=rz2_178(0).c,d=
* rz2_178(0).d,cr=zcr(id2),cl=zcl(id2),nsum=0
      eps_0=-p178(2)*p2(3)+p2(2)*p178(3)
      ceps_0=eps_0*cim
      ceps_1=p178(3)*cim
      ceps_2=p2(3)*cim
      auxa=-quqd+p178k0*p2(0)+p2k0*p178(0)
      rz2_178(0).a(1,1)=zcr(id2)*(auxa+ceps_0)
      rz2_178(0).a(2,2)=zcl(id2)*(auxa-ceps_0)
      rz2_178(0).b(1,2)=-zcl(id2)*(p2(2)+ceps_2)
      rz2_178(0).b(2,1)=zcr(id2)*(p2(2)-ceps_2)
      rz2_178(0).c(1,2)=zcr(id2)*(p178(2)+ceps_1)
      rz2_178(0).c(2,1)=zcl(id2)*(-p178(2)+ceps_1)
      rz2_178(0).d(1,1)=zcl(id2)
      rz2_178(0).d(2,2)=zcr(id2)
* T -- qu=p178,qd=p2,v=1,a=rz2_178(1).a,b=rz2_178(1).b,c=rz2_178(1).c,d=
* rz2_178(1).d,cr=zcr(id2),cl=zcl(id2),nsum=0
      auxa=-quqd+p178k0*p2(1)+p2k0*p178(1)
      rz2_178(1).a(1,1)=zcr(id2)*(auxa+ceps_0)
      rz2_178(1).a(2,2)=zcl(id2)*(auxa-ceps_0)
      rz2_178(1).b(1,2)=-zcl(id2)*(p2(2)+ceps_2)
      rz2_178(1).b(2,1)=zcr(id2)*(p2(2)-ceps_2)
      rz2_178(1).c(1,2)=zcr(id2)*(p178(2)+ceps_1)
      rz2_178(1).c(2,1)=zcl(id2)*(-p178(2)+ceps_1)
      rz2_178(1).d(1,1)=zcl(id2)
      rz2_178(1).d(2,2)=zcr(id2)
* T -- qu=p178,qd=p2,v=2,a=rz2_178(2).a,b=rz2_178(2).b,c=rz2_178(2).c,d=
* rz2_178(2).d,cr=zcr(id2),cl=zcl(id2),nsum=0
      eps_0=-p178k0*p2(3)+p2k0*p178(3)
      ceps_0=eps_0*cim
      auxa=p178k0*p2(2)+p2k0*p178(2)
      rz2_178(2).a(1,1)=zcr(id2)*(auxa+ceps_0)
      rz2_178(2).a(2,2)=zcl(id2)*(auxa-ceps_0)
      rz2_178(2).b(1,2)=-zcl(id2)*p2k0
      rz2_178(2).b(2,1)=zcr(id2)*p2k0
      rz2_178(2).c(1,2)=zcr(id2)*p178k0
      rz2_178(2).c(2,1)=-zcl(id2)*p178k0
* T -- qu=p178,qd=p2,v=3,a=rz2_178(3).a,b=rz2_178(3).b,c=rz2_178(3).c,d=
* rz2_178(3).d,cr=zcr(id2),cl=zcl(id2),nsum=0
      eps_0=p178k0*p2(2)-p2k0*p178(2)
      ceps_0=eps_0*cim
      ceps_1=p178k0*cim
      ceps_2=p2k0*cim
      auxa=+p178k0*p2(3)+p2k0*p178(3)
      rz2_178(3).a(1,1)=zcr(id2)*(auxa+ceps_0)
      rz2_178(3).a(2,2)=zcl(id2)*(auxa-ceps_0)
      rz2_178(3).b(1,2)=-zcl(id2)*ceps_2
      rz2_178(3).b(2,1)=-zcr(id2)*ceps_2
      rz2_178(3).c(1,2)=zcr(id2)*ceps_1
      rz2_178(3).c(2,1)=zcl(id2)*ceps_1
  
* T -- qu=p178,qd=p2,v=0,a=rf2_178(0).a,b=rf2_178(0).b,c=rf2_178(0).c,d=
* rf2_178(0).d,cr=fcr(id2),cl=fcl(id2),nsum=0
      eps_0=-p178(2)*p2(3)+p2(2)*p178(3)
      ceps_0=eps_0*cim
      ceps_1=p178(3)*cim
      ceps_2=p2(3)*cim
      auxa=-quqd+p178k0*p2(0)+p2k0*p178(0)
      rf2_178(0).a(1,1)=fcr(id2)*(auxa+ceps_0)
      rf2_178(0).a(2,2)=fcl(id2)*(auxa-ceps_0)
      rf2_178(0).b(1,2)=-fcl(id2)*(p2(2)+ceps_2)
      rf2_178(0).b(2,1)=fcr(id2)*(p2(2)-ceps_2)
      rf2_178(0).c(1,2)=fcr(id2)*(p178(2)+ceps_1)
      rf2_178(0).c(2,1)=fcl(id2)*(-p178(2)+ceps_1)
      rf2_178(0).d(1,1)=fcl(id2)
      rf2_178(0).d(2,2)=fcr(id2)
* T -- qu=p178,qd=p2,v=1,a=rf2_178(1).a,b=rf2_178(1).b,c=rf2_178(1).c,d=
* rf2_178(1).d,cr=fcr(id2),cl=fcl(id2),nsum=0
      auxa=-quqd+p178k0*p2(1)+p2k0*p178(1)
      rf2_178(1).a(1,1)=fcr(id2)*(auxa+ceps_0)
      rf2_178(1).a(2,2)=fcl(id2)*(auxa-ceps_0)
      rf2_178(1).b(1,2)=-fcl(id2)*(p2(2)+ceps_2)
      rf2_178(1).b(2,1)=fcr(id2)*(p2(2)-ceps_2)
      rf2_178(1).c(1,2)=fcr(id2)*(p178(2)+ceps_1)
      rf2_178(1).c(2,1)=fcl(id2)*(-p178(2)+ceps_1)
      rf2_178(1).d(1,1)=fcl(id2)
      rf2_178(1).d(2,2)=fcr(id2)
* T -- qu=p178,qd=p2,v=2,a=rf2_178(2).a,b=rf2_178(2).b,c=rf2_178(2).c,d=
* rf2_178(2).d,cr=fcr(id2),cl=fcl(id2),nsum=0
      eps_0=-p178k0*p2(3)+p2k0*p178(3)
      ceps_0=eps_0*cim
      auxa=p178k0*p2(2)+p2k0*p178(2)
      rf2_178(2).a(1,1)=fcr(id2)*(auxa+ceps_0)
      rf2_178(2).a(2,2)=fcl(id2)*(auxa-ceps_0)
      rf2_178(2).b(1,2)=-fcl(id2)*p2k0
      rf2_178(2).b(2,1)=fcr(id2)*p2k0
      rf2_178(2).c(1,2)=fcr(id2)*p178k0
      rf2_178(2).c(2,1)=-fcl(id2)*p178k0
* T -- qu=p178,qd=p2,v=3,a=rf2_178(3).a,b=rf2_178(3).b,c=rf2_178(3).c,d=
* rf2_178(3).d,cr=fcr(id2),cl=fcl(id2),nsum=0
      eps_0=p178k0*p2(2)-p2k0*p178(2)
      ceps_0=eps_0*cim
      ceps_1=p178k0*cim
      ceps_2=p2k0*cim
      auxa=+p178k0*p2(3)+p2k0*p178(3)
      rf2_178(3).a(1,1)=fcr(id2)*(auxa+ceps_0)
      rf2_178(3).a(2,2)=fcl(id2)*(auxa-ceps_0)
      rf2_178(3).b(1,2)=-fcl(id2)*ceps_2
      rf2_178(3).b(2,1)=-fcr(id2)*ceps_2
      rf2_178(3).c(1,2)=fcr(id2)*ceps_1
      rf2_178(3).c(2,1)=fcl(id2)*ceps_1
  
* quqd -- p=p312,q=p4
      quqd=p312(0)*p4(0)-p312(1)*p4(1)-p312(2)*p4(2)-p312(3)*p4(
     & 3)
* T -- qu=p312,qd=p4,v=0,a=rz4_312(0).a,b=rz4_312(0).b,c=rz4_312(0).c,d=
* rz4_312(0).d,cr=zcr(id4),cl=zcl(id4),nsum=0
      eps_0=-p312(2)*p4(3)+p4(2)*p312(3)
      ceps_0=eps_0*cim
      ceps_1=p312(3)*cim
      ceps_2=p4(3)*cim
      auxa=-quqd+p312k0*p4(0)+p4k0*p312(0)
      rz4_312(0).a(1,1)=zcr(id4)*(auxa+ceps_0)
      rz4_312(0).a(2,2)=zcl(id4)*(auxa-ceps_0)
      rz4_312(0).b(1,2)=-zcl(id4)*(p4(2)+ceps_2)
      rz4_312(0).b(2,1)=zcr(id4)*(p4(2)-ceps_2)
      rz4_312(0).c(1,2)=zcr(id4)*(p312(2)+ceps_1)
      rz4_312(0).c(2,1)=zcl(id4)*(-p312(2)+ceps_1)
      rz4_312(0).d(1,1)=zcl(id4)
      rz4_312(0).d(2,2)=zcr(id4)
* T -- qu=p312,qd=p4,v=1,a=rz4_312(1).a,b=rz4_312(1).b,c=rz4_312(1).c,d=
* rz4_312(1).d,cr=zcr(id4),cl=zcl(id4),nsum=0
      auxa=-quqd+p312k0*p4(1)+p4k0*p312(1)
      rz4_312(1).a(1,1)=zcr(id4)*(auxa+ceps_0)
      rz4_312(1).a(2,2)=zcl(id4)*(auxa-ceps_0)
      rz4_312(1).b(1,2)=-zcl(id4)*(p4(2)+ceps_2)
      rz4_312(1).b(2,1)=zcr(id4)*(p4(2)-ceps_2)
      rz4_312(1).c(1,2)=zcr(id4)*(p312(2)+ceps_1)
      rz4_312(1).c(2,1)=zcl(id4)*(-p312(2)+ceps_1)
      rz4_312(1).d(1,1)=zcl(id4)
      rz4_312(1).d(2,2)=zcr(id4)
* T -- qu=p312,qd=p4,v=2,a=rz4_312(2).a,b=rz4_312(2).b,c=rz4_312(2).c,d=
* rz4_312(2).d,cr=zcr(id4),cl=zcl(id4),nsum=0
      eps_0=-p312k0*p4(3)+p4k0*p312(3)
      ceps_0=eps_0*cim
      auxa=p312k0*p4(2)+p4k0*p312(2)
      rz4_312(2).a(1,1)=zcr(id4)*(auxa+ceps_0)
      rz4_312(2).a(2,2)=zcl(id4)*(auxa-ceps_0)
      rz4_312(2).b(1,2)=-zcl(id4)*p4k0
      rz4_312(2).b(2,1)=zcr(id4)*p4k0
      rz4_312(2).c(1,2)=zcr(id4)*p312k0
      rz4_312(2).c(2,1)=-zcl(id4)*p312k0
* T -- qu=p312,qd=p4,v=3,a=rz4_312(3).a,b=rz4_312(3).b,c=rz4_312(3).c,d=
* rz4_312(3).d,cr=zcr(id4),cl=zcl(id4),nsum=0
      eps_0=p312k0*p4(2)-p4k0*p312(2)
      ceps_0=eps_0*cim
      ceps_1=p312k0*cim
      ceps_2=p4k0*cim
      auxa=+p312k0*p4(3)+p4k0*p312(3)
      rz4_312(3).a(1,1)=zcr(id4)*(auxa+ceps_0)
      rz4_312(3).a(2,2)=zcl(id4)*(auxa-ceps_0)
      rz4_312(3).b(1,2)=-zcl(id4)*ceps_2
      rz4_312(3).b(2,1)=-zcr(id4)*ceps_2
      rz4_312(3).c(1,2)=zcr(id4)*ceps_1
      rz4_312(3).c(2,1)=zcl(id4)*ceps_1
  
* T -- qu=p312,qd=p4,v=0,a=rf4_312(0).a,b=rf4_312(0).b,c=rf4_312(0).c,d=
* rf4_312(0).d,cr=fcr(id4),cl=fcl(id4),nsum=0
      eps_0=-p312(2)*p4(3)+p4(2)*p312(3)
      ceps_0=eps_0*cim
      ceps_1=p312(3)*cim
      ceps_2=p4(3)*cim
      auxa=-quqd+p312k0*p4(0)+p4k0*p312(0)
      rf4_312(0).a(1,1)=fcr(id4)*(auxa+ceps_0)
      rf4_312(0).a(2,2)=fcl(id4)*(auxa-ceps_0)
      rf4_312(0).b(1,2)=-fcl(id4)*(p4(2)+ceps_2)
      rf4_312(0).b(2,1)=fcr(id4)*(p4(2)-ceps_2)
      rf4_312(0).c(1,2)=fcr(id4)*(p312(2)+ceps_1)
      rf4_312(0).c(2,1)=fcl(id4)*(-p312(2)+ceps_1)
      rf4_312(0).d(1,1)=fcl(id4)
      rf4_312(0).d(2,2)=fcr(id4)
* T -- qu=p312,qd=p4,v=1,a=rf4_312(1).a,b=rf4_312(1).b,c=rf4_312(1).c,d=
* rf4_312(1).d,cr=fcr(id4),cl=fcl(id4),nsum=0
      auxa=-quqd+p312k0*p4(1)+p4k0*p312(1)
      rf4_312(1).a(1,1)=fcr(id4)*(auxa+ceps_0)
      rf4_312(1).a(2,2)=fcl(id4)*(auxa-ceps_0)
      rf4_312(1).b(1,2)=-fcl(id4)*(p4(2)+ceps_2)
      rf4_312(1).b(2,1)=fcr(id4)*(p4(2)-ceps_2)
      rf4_312(1).c(1,2)=fcr(id4)*(p312(2)+ceps_1)
      rf4_312(1).c(2,1)=fcl(id4)*(-p312(2)+ceps_1)
      rf4_312(1).d(1,1)=fcl(id4)
      rf4_312(1).d(2,2)=fcr(id4)
* T -- qu=p312,qd=p4,v=2,a=rf4_312(2).a,b=rf4_312(2).b,c=rf4_312(2).c,d=
* rf4_312(2).d,cr=fcr(id4),cl=fcl(id4),nsum=0
      eps_0=-p312k0*p4(3)+p4k0*p312(3)
      ceps_0=eps_0*cim
      auxa=p312k0*p4(2)+p4k0*p312(2)
      rf4_312(2).a(1,1)=fcr(id4)*(auxa+ceps_0)
      rf4_312(2).a(2,2)=fcl(id4)*(auxa-ceps_0)
      rf4_312(2).b(1,2)=-fcl(id4)*p4k0
      rf4_312(2).b(2,1)=fcr(id4)*p4k0
      rf4_312(2).c(1,2)=fcr(id4)*p312k0
      rf4_312(2).c(2,1)=-fcl(id4)*p312k0
* T -- qu=p312,qd=p4,v=3,a=rf4_312(3).a,b=rf4_312(3).b,c=rf4_312(3).c,d=
* rf4_312(3).d,cr=fcr(id4),cl=fcl(id4),nsum=0
      eps_0=p312k0*p4(2)-p4k0*p312(2)
      ceps_0=eps_0*cim
      ceps_1=p312k0*cim
      ceps_2=p4k0*cim
      auxa=+p312k0*p4(3)+p4k0*p312(3)
      rf4_312(3).a(1,1)=fcr(id4)*(auxa+ceps_0)
      rf4_312(3).a(2,2)=fcl(id4)*(auxa-ceps_0)
      rf4_312(3).b(1,2)=-fcl(id4)*ceps_2
      rf4_312(3).b(2,1)=-fcr(id4)*ceps_2
      rf4_312(3).c(1,2)=fcr(id4)*ceps_1
      rf4_312(3).c(2,1)=fcl(id4)*ceps_1
  
* quqd -- p=p356,q=p4
      quqd=p356(0)*p4(0)-p356(1)*p4(1)-p356(2)*p4(2)-p356(3)*p4(
     & 3)
* T -- qu=p356,qd=p4,v=0,a=rz4_356(0).a,b=rz4_356(0).b,c=rz4_356(0).c,d=
* rz4_356(0).d,cr=zcr(id4),cl=zcl(id4),nsum=0
      eps_0=-p356(2)*p4(3)+p4(2)*p356(3)
      ceps_0=eps_0*cim
      ceps_1=p356(3)*cim
      ceps_2=p4(3)*cim
      auxa=-quqd+p356k0*p4(0)+p4k0*p356(0)
      rz4_356(0).a(1,1)=zcr(id4)*(auxa+ceps_0)
      rz4_356(0).a(2,2)=zcl(id4)*(auxa-ceps_0)
      rz4_356(0).b(1,2)=-zcl(id4)*(p4(2)+ceps_2)
      rz4_356(0).b(2,1)=zcr(id4)*(p4(2)-ceps_2)
      rz4_356(0).c(1,2)=zcr(id4)*(p356(2)+ceps_1)
      rz4_356(0).c(2,1)=zcl(id4)*(-p356(2)+ceps_1)
      rz4_356(0).d(1,1)=zcl(id4)
      rz4_356(0).d(2,2)=zcr(id4)
* T -- qu=p356,qd=p4,v=1,a=rz4_356(1).a,b=rz4_356(1).b,c=rz4_356(1).c,d=
* rz4_356(1).d,cr=zcr(id4),cl=zcl(id4),nsum=0
      auxa=-quqd+p356k0*p4(1)+p4k0*p356(1)
      rz4_356(1).a(1,1)=zcr(id4)*(auxa+ceps_0)
      rz4_356(1).a(2,2)=zcl(id4)*(auxa-ceps_0)
      rz4_356(1).b(1,2)=-zcl(id4)*(p4(2)+ceps_2)
      rz4_356(1).b(2,1)=zcr(id4)*(p4(2)-ceps_2)
      rz4_356(1).c(1,2)=zcr(id4)*(p356(2)+ceps_1)
      rz4_356(1).c(2,1)=zcl(id4)*(-p356(2)+ceps_1)
      rz4_356(1).d(1,1)=zcl(id4)
      rz4_356(1).d(2,2)=zcr(id4)
* T -- qu=p356,qd=p4,v=2,a=rz4_356(2).a,b=rz4_356(2).b,c=rz4_356(2).c,d=
* rz4_356(2).d,cr=zcr(id4),cl=zcl(id4),nsum=0
      eps_0=-p356k0*p4(3)+p4k0*p356(3)
      ceps_0=eps_0*cim
      auxa=p356k0*p4(2)+p4k0*p356(2)
      rz4_356(2).a(1,1)=zcr(id4)*(auxa+ceps_0)
      rz4_356(2).a(2,2)=zcl(id4)*(auxa-ceps_0)
      rz4_356(2).b(1,2)=-zcl(id4)*p4k0
      rz4_356(2).b(2,1)=zcr(id4)*p4k0
      rz4_356(2).c(1,2)=zcr(id4)*p356k0
      rz4_356(2).c(2,1)=-zcl(id4)*p356k0
* T -- qu=p356,qd=p4,v=3,a=rz4_356(3).a,b=rz4_356(3).b,c=rz4_356(3).c,d=
* rz4_356(3).d,cr=zcr(id4),cl=zcl(id4),nsum=0
      eps_0=p356k0*p4(2)-p4k0*p356(2)
      ceps_0=eps_0*cim
      ceps_1=p356k0*cim
      ceps_2=p4k0*cim
      auxa=+p356k0*p4(3)+p4k0*p356(3)
      rz4_356(3).a(1,1)=zcr(id4)*(auxa+ceps_0)
      rz4_356(3).a(2,2)=zcl(id4)*(auxa-ceps_0)
      rz4_356(3).b(1,2)=-zcl(id4)*ceps_2
      rz4_356(3).b(2,1)=-zcr(id4)*ceps_2
      rz4_356(3).c(1,2)=zcr(id4)*ceps_1
      rz4_356(3).c(2,1)=zcl(id4)*ceps_1
  
* T -- qu=p356,qd=p4,v=0,a=rf4_356(0).a,b=rf4_356(0).b,c=rf4_356(0).c,d=
* rf4_356(0).d,cr=fcr(id4),cl=fcl(id4),nsum=0
      eps_0=-p356(2)*p4(3)+p4(2)*p356(3)
      ceps_0=eps_0*cim
      ceps_1=p356(3)*cim
      ceps_2=p4(3)*cim
      auxa=-quqd+p356k0*p4(0)+p4k0*p356(0)
      rf4_356(0).a(1,1)=fcr(id4)*(auxa+ceps_0)
      rf4_356(0).a(2,2)=fcl(id4)*(auxa-ceps_0)
      rf4_356(0).b(1,2)=-fcl(id4)*(p4(2)+ceps_2)
      rf4_356(0).b(2,1)=fcr(id4)*(p4(2)-ceps_2)
      rf4_356(0).c(1,2)=fcr(id4)*(p356(2)+ceps_1)
      rf4_356(0).c(2,1)=fcl(id4)*(-p356(2)+ceps_1)
      rf4_356(0).d(1,1)=fcl(id4)
      rf4_356(0).d(2,2)=fcr(id4)
* T -- qu=p356,qd=p4,v=1,a=rf4_356(1).a,b=rf4_356(1).b,c=rf4_356(1).c,d=
* rf4_356(1).d,cr=fcr(id4),cl=fcl(id4),nsum=0
      auxa=-quqd+p356k0*p4(1)+p4k0*p356(1)
      rf4_356(1).a(1,1)=fcr(id4)*(auxa+ceps_0)
      rf4_356(1).a(2,2)=fcl(id4)*(auxa-ceps_0)
      rf4_356(1).b(1,2)=-fcl(id4)*(p4(2)+ceps_2)
      rf4_356(1).b(2,1)=fcr(id4)*(p4(2)-ceps_2)
      rf4_356(1).c(1,2)=fcr(id4)*(p356(2)+ceps_1)
      rf4_356(1).c(2,1)=fcl(id4)*(-p356(2)+ceps_1)
      rf4_356(1).d(1,1)=fcl(id4)
      rf4_356(1).d(2,2)=fcr(id4)
* T -- qu=p356,qd=p4,v=2,a=rf4_356(2).a,b=rf4_356(2).b,c=rf4_356(2).c,d=
* rf4_356(2).d,cr=fcr(id4),cl=fcl(id4),nsum=0
      eps_0=-p356k0*p4(3)+p4k0*p356(3)
      ceps_0=eps_0*cim
      auxa=p356k0*p4(2)+p4k0*p356(2)
      rf4_356(2).a(1,1)=fcr(id4)*(auxa+ceps_0)
      rf4_356(2).a(2,2)=fcl(id4)*(auxa-ceps_0)
      rf4_356(2).b(1,2)=-fcl(id4)*p4k0
      rf4_356(2).b(2,1)=fcr(id4)*p4k0
      rf4_356(2).c(1,2)=fcr(id4)*p356k0
      rf4_356(2).c(2,1)=-fcl(id4)*p356k0
* T -- qu=p356,qd=p4,v=3,a=rf4_356(3).a,b=rf4_356(3).b,c=rf4_356(3).c,d=
* rf4_356(3).d,cr=fcr(id4),cl=fcl(id4),nsum=0
      eps_0=p356k0*p4(2)-p4k0*p356(2)
      ceps_0=eps_0*cim
      ceps_1=p356k0*cim
      ceps_2=p4k0*cim
      auxa=+p356k0*p4(3)+p4k0*p356(3)
      rf4_356(3).a(1,1)=fcr(id4)*(auxa+ceps_0)
      rf4_356(3).a(2,2)=fcl(id4)*(auxa-ceps_0)
      rf4_356(3).b(1,2)=-fcl(id4)*ceps_2
      rf4_356(3).b(2,1)=-fcr(id4)*ceps_2
      rf4_356(3).c(1,2)=fcr(id4)*ceps_1
      rf4_356(3).c(2,1)=fcl(id4)*ceps_1
  
* quqd -- p=p378,q=p4
      quqd=p378(0)*p4(0)-p378(1)*p4(1)-p378(2)*p4(2)-p378(3)*p4(
     & 3)
* T -- qu=p378,qd=p4,v=0,a=rz4_378(0).a,b=rz4_378(0).b,c=rz4_378(0).c,d=
* rz4_378(0).d,cr=zcr(id4),cl=zcl(id4),nsum=0
      eps_0=-p378(2)*p4(3)+p4(2)*p378(3)
      ceps_0=eps_0*cim
      ceps_1=p378(3)*cim
      ceps_2=p4(3)*cim
      auxa=-quqd+p378k0*p4(0)+p4k0*p378(0)
      rz4_378(0).a(1,1)=zcr(id4)*(auxa+ceps_0)
      rz4_378(0).a(2,2)=zcl(id4)*(auxa-ceps_0)
      rz4_378(0).b(1,2)=-zcl(id4)*(p4(2)+ceps_2)
      rz4_378(0).b(2,1)=zcr(id4)*(p4(2)-ceps_2)
      rz4_378(0).c(1,2)=zcr(id4)*(p378(2)+ceps_1)
      rz4_378(0).c(2,1)=zcl(id4)*(-p378(2)+ceps_1)
      rz4_378(0).d(1,1)=zcl(id4)
      rz4_378(0).d(2,2)=zcr(id4)
* T -- qu=p378,qd=p4,v=1,a=rz4_378(1).a,b=rz4_378(1).b,c=rz4_378(1).c,d=
* rz4_378(1).d,cr=zcr(id4),cl=zcl(id4),nsum=0
      auxa=-quqd+p378k0*p4(1)+p4k0*p378(1)
      rz4_378(1).a(1,1)=zcr(id4)*(auxa+ceps_0)
      rz4_378(1).a(2,2)=zcl(id4)*(auxa-ceps_0)
      rz4_378(1).b(1,2)=-zcl(id4)*(p4(2)+ceps_2)
      rz4_378(1).b(2,1)=zcr(id4)*(p4(2)-ceps_2)
      rz4_378(1).c(1,2)=zcr(id4)*(p378(2)+ceps_1)
      rz4_378(1).c(2,1)=zcl(id4)*(-p378(2)+ceps_1)
      rz4_378(1).d(1,1)=zcl(id4)
      rz4_378(1).d(2,2)=zcr(id4)
* T -- qu=p378,qd=p4,v=2,a=rz4_378(2).a,b=rz4_378(2).b,c=rz4_378(2).c,d=
* rz4_378(2).d,cr=zcr(id4),cl=zcl(id4),nsum=0
      eps_0=-p378k0*p4(3)+p4k0*p378(3)
      ceps_0=eps_0*cim
      auxa=p378k0*p4(2)+p4k0*p378(2)
      rz4_378(2).a(1,1)=zcr(id4)*(auxa+ceps_0)
      rz4_378(2).a(2,2)=zcl(id4)*(auxa-ceps_0)
      rz4_378(2).b(1,2)=-zcl(id4)*p4k0
      rz4_378(2).b(2,1)=zcr(id4)*p4k0
      rz4_378(2).c(1,2)=zcr(id4)*p378k0
      rz4_378(2).c(2,1)=-zcl(id4)*p378k0
* T -- qu=p378,qd=p4,v=3,a=rz4_378(3).a,b=rz4_378(3).b,c=rz4_378(3).c,d=
* rz4_378(3).d,cr=zcr(id4),cl=zcl(id4),nsum=0
      eps_0=p378k0*p4(2)-p4k0*p378(2)
      ceps_0=eps_0*cim
      ceps_1=p378k0*cim
      ceps_2=p4k0*cim
      auxa=+p378k0*p4(3)+p4k0*p378(3)
      rz4_378(3).a(1,1)=zcr(id4)*(auxa+ceps_0)
      rz4_378(3).a(2,2)=zcl(id4)*(auxa-ceps_0)
      rz4_378(3).b(1,2)=-zcl(id4)*ceps_2
      rz4_378(3).b(2,1)=-zcr(id4)*ceps_2
      rz4_378(3).c(1,2)=zcr(id4)*ceps_1
      rz4_378(3).c(2,1)=zcl(id4)*ceps_1
  
* T -- qu=p378,qd=p4,v=0,a=rf4_378(0).a,b=rf4_378(0).b,c=rf4_378(0).c,d=
* rf4_378(0).d,cr=fcr(id4),cl=fcl(id4),nsum=0
      eps_0=-p378(2)*p4(3)+p4(2)*p378(3)
      ceps_0=eps_0*cim
      ceps_1=p378(3)*cim
      ceps_2=p4(3)*cim
      auxa=-quqd+p378k0*p4(0)+p4k0*p378(0)
      rf4_378(0).a(1,1)=fcr(id4)*(auxa+ceps_0)
      rf4_378(0).a(2,2)=fcl(id4)*(auxa-ceps_0)
      rf4_378(0).b(1,2)=-fcl(id4)*(p4(2)+ceps_2)
      rf4_378(0).b(2,1)=fcr(id4)*(p4(2)-ceps_2)
      rf4_378(0).c(1,2)=fcr(id4)*(p378(2)+ceps_1)
      rf4_378(0).c(2,1)=fcl(id4)*(-p378(2)+ceps_1)
      rf4_378(0).d(1,1)=fcl(id4)
      rf4_378(0).d(2,2)=fcr(id4)
* T -- qu=p378,qd=p4,v=1,a=rf4_378(1).a,b=rf4_378(1).b,c=rf4_378(1).c,d=
* rf4_378(1).d,cr=fcr(id4),cl=fcl(id4),nsum=0
      auxa=-quqd+p378k0*p4(1)+p4k0*p378(1)
      rf4_378(1).a(1,1)=fcr(id4)*(auxa+ceps_0)
      rf4_378(1).a(2,2)=fcl(id4)*(auxa-ceps_0)
      rf4_378(1).b(1,2)=-fcl(id4)*(p4(2)+ceps_2)
      rf4_378(1).b(2,1)=fcr(id4)*(p4(2)-ceps_2)
      rf4_378(1).c(1,2)=fcr(id4)*(p378(2)+ceps_1)
      rf4_378(1).c(2,1)=fcl(id4)*(-p378(2)+ceps_1)
      rf4_378(1).d(1,1)=fcl(id4)
      rf4_378(1).d(2,2)=fcr(id4)
* T -- qu=p378,qd=p4,v=2,a=rf4_378(2).a,b=rf4_378(2).b,c=rf4_378(2).c,d=
* rf4_378(2).d,cr=fcr(id4),cl=fcl(id4),nsum=0
      eps_0=-p378k0*p4(3)+p4k0*p378(3)
      ceps_0=eps_0*cim
      auxa=p378k0*p4(2)+p4k0*p378(2)
      rf4_378(2).a(1,1)=fcr(id4)*(auxa+ceps_0)
      rf4_378(2).a(2,2)=fcl(id4)*(auxa-ceps_0)
      rf4_378(2).b(1,2)=-fcl(id4)*p4k0
      rf4_378(2).b(2,1)=fcr(id4)*p4k0
      rf4_378(2).c(1,2)=fcr(id4)*p378k0
      rf4_378(2).c(2,1)=-fcl(id4)*p378k0
* T -- qu=p378,qd=p4,v=3,a=rf4_378(3).a,b=rf4_378(3).b,c=rf4_378(3).c,d=
* rf4_378(3).d,cr=fcr(id4),cl=fcl(id4),nsum=0
      eps_0=p378k0*p4(2)-p4k0*p378(2)
      ceps_0=eps_0*cim
      ceps_1=p378k0*cim
      ceps_2=p4k0*cim
      auxa=+p378k0*p4(3)+p4k0*p378(3)
      rf4_378(3).a(1,1)=fcr(id4)*(auxa+ceps_0)
      rf4_378(3).a(2,2)=fcl(id4)*(auxa-ceps_0)
      rf4_378(3).b(1,2)=-fcl(id4)*ceps_2
      rf4_378(3).b(2,1)=-fcr(id4)*ceps_2
      rf4_378(3).c(1,2)=fcr(id4)*ceps_1
      rf4_378(3).c(2,1)=fcl(id4)*ceps_1
  
* quqd -- p=p512,q=p6
      quqd=p512(0)*p6(0)-p512(1)*p6(1)-p512(2)*p6(2)-p512(3)*p6(
     & 3)
* T -- qu=p512,qd=p6,v=0,a=rz6_512(0).a,b=rz6_512(0).b,c=rz6_512(0).c,d=
* rz6_512(0).d,cr=zcr(id6),cl=zcl(id6),nsum=0
      eps_0=-p512(2)*p6(3)+p6(2)*p512(3)
      ceps_0=eps_0*cim
      ceps_1=p512(3)*cim
      ceps_2=p6(3)*cim
      auxa=-quqd+p512k0*p6(0)+p6k0*p512(0)
      rz6_512(0).a(1,1)=zcr(id6)*(auxa+ceps_0)
      rz6_512(0).a(2,2)=zcl(id6)*(auxa-ceps_0)
      rz6_512(0).b(1,2)=-zcl(id6)*(p6(2)+ceps_2)
      rz6_512(0).b(2,1)=zcr(id6)*(p6(2)-ceps_2)
      rz6_512(0).c(1,2)=zcr(id6)*(p512(2)+ceps_1)
      rz6_512(0).c(2,1)=zcl(id6)*(-p512(2)+ceps_1)
      rz6_512(0).d(1,1)=zcl(id6)
      rz6_512(0).d(2,2)=zcr(id6)
* T -- qu=p512,qd=p6,v=1,a=rz6_512(1).a,b=rz6_512(1).b,c=rz6_512(1).c,d=
* rz6_512(1).d,cr=zcr(id6),cl=zcl(id6),nsum=0
      auxa=-quqd+p512k0*p6(1)+p6k0*p512(1)
      rz6_512(1).a(1,1)=zcr(id6)*(auxa+ceps_0)
      rz6_512(1).a(2,2)=zcl(id6)*(auxa-ceps_0)
      rz6_512(1).b(1,2)=-zcl(id6)*(p6(2)+ceps_2)
      rz6_512(1).b(2,1)=zcr(id6)*(p6(2)-ceps_2)
      rz6_512(1).c(1,2)=zcr(id6)*(p512(2)+ceps_1)
      rz6_512(1).c(2,1)=zcl(id6)*(-p512(2)+ceps_1)
      rz6_512(1).d(1,1)=zcl(id6)
      rz6_512(1).d(2,2)=zcr(id6)
* T -- qu=p512,qd=p6,v=2,a=rz6_512(2).a,b=rz6_512(2).b,c=rz6_512(2).c,d=
* rz6_512(2).d,cr=zcr(id6),cl=zcl(id6),nsum=0
      eps_0=-p512k0*p6(3)+p6k0*p512(3)
      ceps_0=eps_0*cim
      auxa=p512k0*p6(2)+p6k0*p512(2)
      rz6_512(2).a(1,1)=zcr(id6)*(auxa+ceps_0)
      rz6_512(2).a(2,2)=zcl(id6)*(auxa-ceps_0)
      rz6_512(2).b(1,2)=-zcl(id6)*p6k0
      rz6_512(2).b(2,1)=zcr(id6)*p6k0
      rz6_512(2).c(1,2)=zcr(id6)*p512k0
      rz6_512(2).c(2,1)=-zcl(id6)*p512k0
* T -- qu=p512,qd=p6,v=3,a=rz6_512(3).a,b=rz6_512(3).b,c=rz6_512(3).c,d=
* rz6_512(3).d,cr=zcr(id6),cl=zcl(id6),nsum=0
      eps_0=p512k0*p6(2)-p6k0*p512(2)
      ceps_0=eps_0*cim
      ceps_1=p512k0*cim
      ceps_2=p6k0*cim
      auxa=+p512k0*p6(3)+p6k0*p512(3)
      rz6_512(3).a(1,1)=zcr(id6)*(auxa+ceps_0)
      rz6_512(3).a(2,2)=zcl(id6)*(auxa-ceps_0)
      rz6_512(3).b(1,2)=-zcl(id6)*ceps_2
      rz6_512(3).b(2,1)=-zcr(id6)*ceps_2
      rz6_512(3).c(1,2)=zcr(id6)*ceps_1
      rz6_512(3).c(2,1)=zcl(id6)*ceps_1
  
* T -- qu=p512,qd=p6,v=0,a=rf6_512(0).a,b=rf6_512(0).b,c=rf6_512(0).c,d=
* rf6_512(0).d,cr=fcr(id6),cl=fcl(id6),nsum=0
      eps_0=-p512(2)*p6(3)+p6(2)*p512(3)
      ceps_0=eps_0*cim
      ceps_1=p512(3)*cim
      ceps_2=p6(3)*cim
      auxa=-quqd+p512k0*p6(0)+p6k0*p512(0)
      rf6_512(0).a(1,1)=fcr(id6)*(auxa+ceps_0)
      rf6_512(0).a(2,2)=fcl(id6)*(auxa-ceps_0)
      rf6_512(0).b(1,2)=-fcl(id6)*(p6(2)+ceps_2)
      rf6_512(0).b(2,1)=fcr(id6)*(p6(2)-ceps_2)
      rf6_512(0).c(1,2)=fcr(id6)*(p512(2)+ceps_1)
      rf6_512(0).c(2,1)=fcl(id6)*(-p512(2)+ceps_1)
      rf6_512(0).d(1,1)=fcl(id6)
      rf6_512(0).d(2,2)=fcr(id6)
* T -- qu=p512,qd=p6,v=1,a=rf6_512(1).a,b=rf6_512(1).b,c=rf6_512(1).c,d=
* rf6_512(1).d,cr=fcr(id6),cl=fcl(id6),nsum=0
      auxa=-quqd+p512k0*p6(1)+p6k0*p512(1)
      rf6_512(1).a(1,1)=fcr(id6)*(auxa+ceps_0)
      rf6_512(1).a(2,2)=fcl(id6)*(auxa-ceps_0)
      rf6_512(1).b(1,2)=-fcl(id6)*(p6(2)+ceps_2)
      rf6_512(1).b(2,1)=fcr(id6)*(p6(2)-ceps_2)
      rf6_512(1).c(1,2)=fcr(id6)*(p512(2)+ceps_1)
      rf6_512(1).c(2,1)=fcl(id6)*(-p512(2)+ceps_1)
      rf6_512(1).d(1,1)=fcl(id6)
      rf6_512(1).d(2,2)=fcr(id6)
* T -- qu=p512,qd=p6,v=2,a=rf6_512(2).a,b=rf6_512(2).b,c=rf6_512(2).c,d=
* rf6_512(2).d,cr=fcr(id6),cl=fcl(id6),nsum=0
      eps_0=-p512k0*p6(3)+p6k0*p512(3)
      ceps_0=eps_0*cim
      auxa=p512k0*p6(2)+p6k0*p512(2)
      rf6_512(2).a(1,1)=fcr(id6)*(auxa+ceps_0)
      rf6_512(2).a(2,2)=fcl(id6)*(auxa-ceps_0)
      rf6_512(2).b(1,2)=-fcl(id6)*p6k0
      rf6_512(2).b(2,1)=fcr(id6)*p6k0
      rf6_512(2).c(1,2)=fcr(id6)*p512k0
      rf6_512(2).c(2,1)=-fcl(id6)*p512k0
* T -- qu=p512,qd=p6,v=3,a=rf6_512(3).a,b=rf6_512(3).b,c=rf6_512(3).c,d=
* rf6_512(3).d,cr=fcr(id6),cl=fcl(id6),nsum=0
      eps_0=p512k0*p6(2)-p6k0*p512(2)
      ceps_0=eps_0*cim
      ceps_1=p512k0*cim
      ceps_2=p6k0*cim
      auxa=+p512k0*p6(3)+p6k0*p512(3)
      rf6_512(3).a(1,1)=fcr(id6)*(auxa+ceps_0)
      rf6_512(3).a(2,2)=fcl(id6)*(auxa-ceps_0)
      rf6_512(3).b(1,2)=-fcl(id6)*ceps_2
      rf6_512(3).b(2,1)=-fcr(id6)*ceps_2
      rf6_512(3).c(1,2)=fcr(id6)*ceps_1
      rf6_512(3).c(2,1)=fcl(id6)*ceps_1
  
* quqd -- p=p534,q=p6
      quqd=p534(0)*p6(0)-p534(1)*p6(1)-p534(2)*p6(2)-p534(3)*p6(
     & 3)
* T -- qu=p534,qd=p6,v=0,a=rz6_534(0).a,b=rz6_534(0).b,c=rz6_534(0).c,d=
* rz6_534(0).d,cr=zcr(id6),cl=zcl(id6),nsum=0
      eps_0=-p534(2)*p6(3)+p6(2)*p534(3)
      ceps_0=eps_0*cim
      ceps_1=p534(3)*cim
      ceps_2=p6(3)*cim
      auxa=-quqd+p534k0*p6(0)+p6k0*p534(0)
      rz6_534(0).a(1,1)=zcr(id6)*(auxa+ceps_0)
      rz6_534(0).a(2,2)=zcl(id6)*(auxa-ceps_0)
      rz6_534(0).b(1,2)=-zcl(id6)*(p6(2)+ceps_2)
      rz6_534(0).b(2,1)=zcr(id6)*(p6(2)-ceps_2)
      rz6_534(0).c(1,2)=zcr(id6)*(p534(2)+ceps_1)
      rz6_534(0).c(2,1)=zcl(id6)*(-p534(2)+ceps_1)
      rz6_534(0).d(1,1)=zcl(id6)
      rz6_534(0).d(2,2)=zcr(id6)
* T -- qu=p534,qd=p6,v=1,a=rz6_534(1).a,b=rz6_534(1).b,c=rz6_534(1).c,d=
* rz6_534(1).d,cr=zcr(id6),cl=zcl(id6),nsum=0
      auxa=-quqd+p534k0*p6(1)+p6k0*p534(1)
      rz6_534(1).a(1,1)=zcr(id6)*(auxa+ceps_0)
      rz6_534(1).a(2,2)=zcl(id6)*(auxa-ceps_0)
      rz6_534(1).b(1,2)=-zcl(id6)*(p6(2)+ceps_2)
      rz6_534(1).b(2,1)=zcr(id6)*(p6(2)-ceps_2)
      rz6_534(1).c(1,2)=zcr(id6)*(p534(2)+ceps_1)
      rz6_534(1).c(2,1)=zcl(id6)*(-p534(2)+ceps_1)
      rz6_534(1).d(1,1)=zcl(id6)
      rz6_534(1).d(2,2)=zcr(id6)
* T -- qu=p534,qd=p6,v=2,a=rz6_534(2).a,b=rz6_534(2).b,c=rz6_534(2).c,d=
* rz6_534(2).d,cr=zcr(id6),cl=zcl(id6),nsum=0
      eps_0=-p534k0*p6(3)+p6k0*p534(3)
      ceps_0=eps_0*cim
      auxa=p534k0*p6(2)+p6k0*p534(2)
      rz6_534(2).a(1,1)=zcr(id6)*(auxa+ceps_0)
      rz6_534(2).a(2,2)=zcl(id6)*(auxa-ceps_0)
      rz6_534(2).b(1,2)=-zcl(id6)*p6k0
      rz6_534(2).b(2,1)=zcr(id6)*p6k0
      rz6_534(2).c(1,2)=zcr(id6)*p534k0
      rz6_534(2).c(2,1)=-zcl(id6)*p534k0
* T -- qu=p534,qd=p6,v=3,a=rz6_534(3).a,b=rz6_534(3).b,c=rz6_534(3).c,d=
* rz6_534(3).d,cr=zcr(id6),cl=zcl(id6),nsum=0
      eps_0=p534k0*p6(2)-p6k0*p534(2)
      ceps_0=eps_0*cim
      ceps_1=p534k0*cim
      ceps_2=p6k0*cim
      auxa=+p534k0*p6(3)+p6k0*p534(3)
      rz6_534(3).a(1,1)=zcr(id6)*(auxa+ceps_0)
      rz6_534(3).a(2,2)=zcl(id6)*(auxa-ceps_0)
      rz6_534(3).b(1,2)=-zcl(id6)*ceps_2
      rz6_534(3).b(2,1)=-zcr(id6)*ceps_2
      rz6_534(3).c(1,2)=zcr(id6)*ceps_1
      rz6_534(3).c(2,1)=zcl(id6)*ceps_1
  
* T -- qu=p534,qd=p6,v=0,a=rf6_534(0).a,b=rf6_534(0).b,c=rf6_534(0).c,d=
* rf6_534(0).d,cr=fcr(id6),cl=fcl(id6),nsum=0
      eps_0=-p534(2)*p6(3)+p6(2)*p534(3)
      ceps_0=eps_0*cim
      ceps_1=p534(3)*cim
      ceps_2=p6(3)*cim
      auxa=-quqd+p534k0*p6(0)+p6k0*p534(0)
      rf6_534(0).a(1,1)=fcr(id6)*(auxa+ceps_0)
      rf6_534(0).a(2,2)=fcl(id6)*(auxa-ceps_0)
      rf6_534(0).b(1,2)=-fcl(id6)*(p6(2)+ceps_2)
      rf6_534(0).b(2,1)=fcr(id6)*(p6(2)-ceps_2)
      rf6_534(0).c(1,2)=fcr(id6)*(p534(2)+ceps_1)
      rf6_534(0).c(2,1)=fcl(id6)*(-p534(2)+ceps_1)
      rf6_534(0).d(1,1)=fcl(id6)
      rf6_534(0).d(2,2)=fcr(id6)
* T -- qu=p534,qd=p6,v=1,a=rf6_534(1).a,b=rf6_534(1).b,c=rf6_534(1).c,d=
* rf6_534(1).d,cr=fcr(id6),cl=fcl(id6),nsum=0
      auxa=-quqd+p534k0*p6(1)+p6k0*p534(1)
      rf6_534(1).a(1,1)=fcr(id6)*(auxa+ceps_0)
      rf6_534(1).a(2,2)=fcl(id6)*(auxa-ceps_0)
      rf6_534(1).b(1,2)=-fcl(id6)*(p6(2)+ceps_2)
      rf6_534(1).b(2,1)=fcr(id6)*(p6(2)-ceps_2)
      rf6_534(1).c(1,2)=fcr(id6)*(p534(2)+ceps_1)
      rf6_534(1).c(2,1)=fcl(id6)*(-p534(2)+ceps_1)
      rf6_534(1).d(1,1)=fcl(id6)
      rf6_534(1).d(2,2)=fcr(id6)
* T -- qu=p534,qd=p6,v=2,a=rf6_534(2).a,b=rf6_534(2).b,c=rf6_534(2).c,d=
* rf6_534(2).d,cr=fcr(id6),cl=fcl(id6),nsum=0
      eps_0=-p534k0*p6(3)+p6k0*p534(3)
      ceps_0=eps_0*cim
      auxa=p534k0*p6(2)+p6k0*p534(2)
      rf6_534(2).a(1,1)=fcr(id6)*(auxa+ceps_0)
      rf6_534(2).a(2,2)=fcl(id6)*(auxa-ceps_0)
      rf6_534(2).b(1,2)=-fcl(id6)*p6k0
      rf6_534(2).b(2,1)=fcr(id6)*p6k0
      rf6_534(2).c(1,2)=fcr(id6)*p534k0
      rf6_534(2).c(2,1)=-fcl(id6)*p534k0
* T -- qu=p534,qd=p6,v=3,a=rf6_534(3).a,b=rf6_534(3).b,c=rf6_534(3).c,d=
* rf6_534(3).d,cr=fcr(id6),cl=fcl(id6),nsum=0
      eps_0=p534k0*p6(2)-p6k0*p534(2)
      ceps_0=eps_0*cim
      ceps_1=p534k0*cim
      ceps_2=p6k0*cim
      auxa=+p534k0*p6(3)+p6k0*p534(3)
      rf6_534(3).a(1,1)=fcr(id6)*(auxa+ceps_0)
      rf6_534(3).a(2,2)=fcl(id6)*(auxa-ceps_0)
      rf6_534(3).b(1,2)=-fcl(id6)*ceps_2
      rf6_534(3).b(2,1)=-fcr(id6)*ceps_2
      rf6_534(3).c(1,2)=fcr(id6)*ceps_1
      rf6_534(3).c(2,1)=fcl(id6)*ceps_1
  
* quqd -- p=p578,q=p6
      quqd=p578(0)*p6(0)-p578(1)*p6(1)-p578(2)*p6(2)-p578(3)*p6(
     & 3)
* T -- qu=p578,qd=p6,v=0,a=rz6_578(0).a,b=rz6_578(0).b,c=rz6_578(0).c,d=
* rz6_578(0).d,cr=zcr(id6),cl=zcl(id6),nsum=0
      eps_0=-p578(2)*p6(3)+p6(2)*p578(3)
      ceps_0=eps_0*cim
      ceps_1=p578(3)*cim
      ceps_2=p6(3)*cim
      auxa=-quqd+p578k0*p6(0)+p6k0*p578(0)
      rz6_578(0).a(1,1)=zcr(id6)*(auxa+ceps_0)
      rz6_578(0).a(2,2)=zcl(id6)*(auxa-ceps_0)
      rz6_578(0).b(1,2)=-zcl(id6)*(p6(2)+ceps_2)
      rz6_578(0).b(2,1)=zcr(id6)*(p6(2)-ceps_2)
      rz6_578(0).c(1,2)=zcr(id6)*(p578(2)+ceps_1)
      rz6_578(0).c(2,1)=zcl(id6)*(-p578(2)+ceps_1)
      rz6_578(0).d(1,1)=zcl(id6)
      rz6_578(0).d(2,2)=zcr(id6)
* T -- qu=p578,qd=p6,v=1,a=rz6_578(1).a,b=rz6_578(1).b,c=rz6_578(1).c,d=
* rz6_578(1).d,cr=zcr(id6),cl=zcl(id6),nsum=0
      auxa=-quqd+p578k0*p6(1)+p6k0*p578(1)
      rz6_578(1).a(1,1)=zcr(id6)*(auxa+ceps_0)
      rz6_578(1).a(2,2)=zcl(id6)*(auxa-ceps_0)
      rz6_578(1).b(1,2)=-zcl(id6)*(p6(2)+ceps_2)
      rz6_578(1).b(2,1)=zcr(id6)*(p6(2)-ceps_2)
      rz6_578(1).c(1,2)=zcr(id6)*(p578(2)+ceps_1)
      rz6_578(1).c(2,1)=zcl(id6)*(-p578(2)+ceps_1)
      rz6_578(1).d(1,1)=zcl(id6)
      rz6_578(1).d(2,2)=zcr(id6)
* T -- qu=p578,qd=p6,v=2,a=rz6_578(2).a,b=rz6_578(2).b,c=rz6_578(2).c,d=
* rz6_578(2).d,cr=zcr(id6),cl=zcl(id6),nsum=0
      eps_0=-p578k0*p6(3)+p6k0*p578(3)
      ceps_0=eps_0*cim
      auxa=p578k0*p6(2)+p6k0*p578(2)
      rz6_578(2).a(1,1)=zcr(id6)*(auxa+ceps_0)
      rz6_578(2).a(2,2)=zcl(id6)*(auxa-ceps_0)
      rz6_578(2).b(1,2)=-zcl(id6)*p6k0
      rz6_578(2).b(2,1)=zcr(id6)*p6k0
      rz6_578(2).c(1,2)=zcr(id6)*p578k0
      rz6_578(2).c(2,1)=-zcl(id6)*p578k0
* T -- qu=p578,qd=p6,v=3,a=rz6_578(3).a,b=rz6_578(3).b,c=rz6_578(3).c,d=
* rz6_578(3).d,cr=zcr(id6),cl=zcl(id6),nsum=0
      eps_0=p578k0*p6(2)-p6k0*p578(2)
      ceps_0=eps_0*cim
      ceps_1=p578k0*cim
      ceps_2=p6k0*cim
      auxa=+p578k0*p6(3)+p6k0*p578(3)
      rz6_578(3).a(1,1)=zcr(id6)*(auxa+ceps_0)
      rz6_578(3).a(2,2)=zcl(id6)*(auxa-ceps_0)
      rz6_578(3).b(1,2)=-zcl(id6)*ceps_2
      rz6_578(3).b(2,1)=-zcr(id6)*ceps_2
      rz6_578(3).c(1,2)=zcr(id6)*ceps_1
      rz6_578(3).c(2,1)=zcl(id6)*ceps_1
  
* T -- qu=p578,qd=p6,v=0,a=rf6_578(0).a,b=rf6_578(0).b,c=rf6_578(0).c,d=
* rf6_578(0).d,cr=fcr(id6),cl=fcl(id6),nsum=0
      eps_0=-p578(2)*p6(3)+p6(2)*p578(3)
      ceps_0=eps_0*cim
      ceps_1=p578(3)*cim
      ceps_2=p6(3)*cim
      auxa=-quqd+p578k0*p6(0)+p6k0*p578(0)
      rf6_578(0).a(1,1)=fcr(id6)*(auxa+ceps_0)
      rf6_578(0).a(2,2)=fcl(id6)*(auxa-ceps_0)
      rf6_578(0).b(1,2)=-fcl(id6)*(p6(2)+ceps_2)
      rf6_578(0).b(2,1)=fcr(id6)*(p6(2)-ceps_2)
      rf6_578(0).c(1,2)=fcr(id6)*(p578(2)+ceps_1)
      rf6_578(0).c(2,1)=fcl(id6)*(-p578(2)+ceps_1)
      rf6_578(0).d(1,1)=fcl(id6)
      rf6_578(0).d(2,2)=fcr(id6)
* T -- qu=p578,qd=p6,v=1,a=rf6_578(1).a,b=rf6_578(1).b,c=rf6_578(1).c,d=
* rf6_578(1).d,cr=fcr(id6),cl=fcl(id6),nsum=0
      auxa=-quqd+p578k0*p6(1)+p6k0*p578(1)
      rf6_578(1).a(1,1)=fcr(id6)*(auxa+ceps_0)
      rf6_578(1).a(2,2)=fcl(id6)*(auxa-ceps_0)
      rf6_578(1).b(1,2)=-fcl(id6)*(p6(2)+ceps_2)
      rf6_578(1).b(2,1)=fcr(id6)*(p6(2)-ceps_2)
      rf6_578(1).c(1,2)=fcr(id6)*(p578(2)+ceps_1)
      rf6_578(1).c(2,1)=fcl(id6)*(-p578(2)+ceps_1)
      rf6_578(1).d(1,1)=fcl(id6)
      rf6_578(1).d(2,2)=fcr(id6)
* T -- qu=p578,qd=p6,v=2,a=rf6_578(2).a,b=rf6_578(2).b,c=rf6_578(2).c,d=
* rf6_578(2).d,cr=fcr(id6),cl=fcl(id6),nsum=0
      eps_0=-p578k0*p6(3)+p6k0*p578(3)
      ceps_0=eps_0*cim
      auxa=p578k0*p6(2)+p6k0*p578(2)
      rf6_578(2).a(1,1)=fcr(id6)*(auxa+ceps_0)
      rf6_578(2).a(2,2)=fcl(id6)*(auxa-ceps_0)
      rf6_578(2).b(1,2)=-fcl(id6)*p6k0
      rf6_578(2).b(2,1)=fcr(id6)*p6k0
      rf6_578(2).c(1,2)=fcr(id6)*p578k0
      rf6_578(2).c(2,1)=-fcl(id6)*p578k0
* T -- qu=p578,qd=p6,v=3,a=rf6_578(3).a,b=rf6_578(3).b,c=rf6_578(3).c,d=
* rf6_578(3).d,cr=fcr(id6),cl=fcl(id6),nsum=0
      eps_0=p578k0*p6(2)-p6k0*p578(2)
      ceps_0=eps_0*cim
      ceps_1=p578k0*cim
      ceps_2=p6k0*cim
      auxa=+p578k0*p6(3)+p6k0*p578(3)
      rf6_578(3).a(1,1)=fcr(id6)*(auxa+ceps_0)
      rf6_578(3).a(2,2)=fcl(id6)*(auxa-ceps_0)
      rf6_578(3).b(1,2)=-fcl(id6)*ceps_2
      rf6_578(3).b(2,1)=-fcr(id6)*ceps_2
      rf6_578(3).c(1,2)=fcr(id6)*ceps_1
      rf6_578(3).c(2,1)=fcl(id6)*ceps_1
  
* quqd -- p=p712,q=p8
      quqd=p712(0)*p8(0)-p712(1)*p8(1)-p712(2)*p8(2)-p712(3)*p8(
     & 3)
* T -- qu=p712,qd=p8,v=0,a=rz8_712(0).a,b=rz8_712(0).b,c=rz8_712(0).c,d=
* rz8_712(0).d,cr=zcr(id8),cl=zcl(id8),nsum=0
      eps_0=-p712(2)*p8(3)+p8(2)*p712(3)
      ceps_0=eps_0*cim
      ceps_1=p712(3)*cim
      ceps_2=p8(3)*cim
      auxa=-quqd+p712k0*p8(0)+p8k0*p712(0)
      rz8_712(0).a(1,1)=zcr(id8)*(auxa+ceps_0)
      rz8_712(0).a(2,2)=zcl(id8)*(auxa-ceps_0)
      rz8_712(0).b(1,2)=-zcl(id8)*(p8(2)+ceps_2)
      rz8_712(0).b(2,1)=zcr(id8)*(p8(2)-ceps_2)
      rz8_712(0).c(1,2)=zcr(id8)*(p712(2)+ceps_1)
      rz8_712(0).c(2,1)=zcl(id8)*(-p712(2)+ceps_1)
      rz8_712(0).d(1,1)=zcl(id8)
      rz8_712(0).d(2,2)=zcr(id8)
* T -- qu=p712,qd=p8,v=1,a=rz8_712(1).a,b=rz8_712(1).b,c=rz8_712(1).c,d=
* rz8_712(1).d,cr=zcr(id8),cl=zcl(id8),nsum=0
      auxa=-quqd+p712k0*p8(1)+p8k0*p712(1)
      rz8_712(1).a(1,1)=zcr(id8)*(auxa+ceps_0)
      rz8_712(1).a(2,2)=zcl(id8)*(auxa-ceps_0)
      rz8_712(1).b(1,2)=-zcl(id8)*(p8(2)+ceps_2)
      rz8_712(1).b(2,1)=zcr(id8)*(p8(2)-ceps_2)
      rz8_712(1).c(1,2)=zcr(id8)*(p712(2)+ceps_1)
      rz8_712(1).c(2,1)=zcl(id8)*(-p712(2)+ceps_1)
      rz8_712(1).d(1,1)=zcl(id8)
      rz8_712(1).d(2,2)=zcr(id8)
* T -- qu=p712,qd=p8,v=2,a=rz8_712(2).a,b=rz8_712(2).b,c=rz8_712(2).c,d=
* rz8_712(2).d,cr=zcr(id8),cl=zcl(id8),nsum=0
      eps_0=-p712k0*p8(3)+p8k0*p712(3)
      ceps_0=eps_0*cim
      auxa=p712k0*p8(2)+p8k0*p712(2)
      rz8_712(2).a(1,1)=zcr(id8)*(auxa+ceps_0)
      rz8_712(2).a(2,2)=zcl(id8)*(auxa-ceps_0)
      rz8_712(2).b(1,2)=-zcl(id8)*p8k0
      rz8_712(2).b(2,1)=zcr(id8)*p8k0
      rz8_712(2).c(1,2)=zcr(id8)*p712k0
      rz8_712(2).c(2,1)=-zcl(id8)*p712k0
* T -- qu=p712,qd=p8,v=3,a=rz8_712(3).a,b=rz8_712(3).b,c=rz8_712(3).c,d=
* rz8_712(3).d,cr=zcr(id8),cl=zcl(id8),nsum=0
      eps_0=p712k0*p8(2)-p8k0*p712(2)
      ceps_0=eps_0*cim
      ceps_1=p712k0*cim
      ceps_2=p8k0*cim
      auxa=+p712k0*p8(3)+p8k0*p712(3)
      rz8_712(3).a(1,1)=zcr(id8)*(auxa+ceps_0)
      rz8_712(3).a(2,2)=zcl(id8)*(auxa-ceps_0)
      rz8_712(3).b(1,2)=-zcl(id8)*ceps_2
      rz8_712(3).b(2,1)=-zcr(id8)*ceps_2
      rz8_712(3).c(1,2)=zcr(id8)*ceps_1
      rz8_712(3).c(2,1)=zcl(id8)*ceps_1
  
* T -- qu=p712,qd=p8,v=0,a=rf8_712(0).a,b=rf8_712(0).b,c=rf8_712(0).c,d=
* rf8_712(0).d,cr=fcr(id8),cl=fcl(id8),nsum=0
      eps_0=-p712(2)*p8(3)+p8(2)*p712(3)
      ceps_0=eps_0*cim
      ceps_1=p712(3)*cim
      ceps_2=p8(3)*cim
      auxa=-quqd+p712k0*p8(0)+p8k0*p712(0)
      rf8_712(0).a(1,1)=fcr(id8)*(auxa+ceps_0)
      rf8_712(0).a(2,2)=fcl(id8)*(auxa-ceps_0)
      rf8_712(0).b(1,2)=-fcl(id8)*(p8(2)+ceps_2)
      rf8_712(0).b(2,1)=fcr(id8)*(p8(2)-ceps_2)
      rf8_712(0).c(1,2)=fcr(id8)*(p712(2)+ceps_1)
      rf8_712(0).c(2,1)=fcl(id8)*(-p712(2)+ceps_1)
      rf8_712(0).d(1,1)=fcl(id8)
      rf8_712(0).d(2,2)=fcr(id8)
* T -- qu=p712,qd=p8,v=1,a=rf8_712(1).a,b=rf8_712(1).b,c=rf8_712(1).c,d=
* rf8_712(1).d,cr=fcr(id8),cl=fcl(id8),nsum=0
      auxa=-quqd+p712k0*p8(1)+p8k0*p712(1)
      rf8_712(1).a(1,1)=fcr(id8)*(auxa+ceps_0)
      rf8_712(1).a(2,2)=fcl(id8)*(auxa-ceps_0)
      rf8_712(1).b(1,2)=-fcl(id8)*(p8(2)+ceps_2)
      rf8_712(1).b(2,1)=fcr(id8)*(p8(2)-ceps_2)
      rf8_712(1).c(1,2)=fcr(id8)*(p712(2)+ceps_1)
      rf8_712(1).c(2,1)=fcl(id8)*(-p712(2)+ceps_1)
      rf8_712(1).d(1,1)=fcl(id8)
      rf8_712(1).d(2,2)=fcr(id8)
* T -- qu=p712,qd=p8,v=2,a=rf8_712(2).a,b=rf8_712(2).b,c=rf8_712(2).c,d=
* rf8_712(2).d,cr=fcr(id8),cl=fcl(id8),nsum=0
      eps_0=-p712k0*p8(3)+p8k0*p712(3)
      ceps_0=eps_0*cim
      auxa=p712k0*p8(2)+p8k0*p712(2)
      rf8_712(2).a(1,1)=fcr(id8)*(auxa+ceps_0)
      rf8_712(2).a(2,2)=fcl(id8)*(auxa-ceps_0)
      rf8_712(2).b(1,2)=-fcl(id8)*p8k0
      rf8_712(2).b(2,1)=fcr(id8)*p8k0
      rf8_712(2).c(1,2)=fcr(id8)*p712k0
      rf8_712(2).c(2,1)=-fcl(id8)*p712k0
* T -- qu=p712,qd=p8,v=3,a=rf8_712(3).a,b=rf8_712(3).b,c=rf8_712(3).c,d=
* rf8_712(3).d,cr=fcr(id8),cl=fcl(id8),nsum=0
      eps_0=p712k0*p8(2)-p8k0*p712(2)
      ceps_0=eps_0*cim
      ceps_1=p712k0*cim
      ceps_2=p8k0*cim
      auxa=+p712k0*p8(3)+p8k0*p712(3)
      rf8_712(3).a(1,1)=fcr(id8)*(auxa+ceps_0)
      rf8_712(3).a(2,2)=fcl(id8)*(auxa-ceps_0)
      rf8_712(3).b(1,2)=-fcl(id8)*ceps_2
      rf8_712(3).b(2,1)=-fcr(id8)*ceps_2
      rf8_712(3).c(1,2)=fcr(id8)*ceps_1
      rf8_712(3).c(2,1)=fcl(id8)*ceps_1
  
* quqd -- p=p734,q=p8
      quqd=p734(0)*p8(0)-p734(1)*p8(1)-p734(2)*p8(2)-p734(3)*p8(
     & 3)
* T -- qu=p734,qd=p8,v=0,a=rz8_734(0).a,b=rz8_734(0).b,c=rz8_734(0).c,d=
* rz8_734(0).d,cr=zcr(id8),cl=zcl(id8),nsum=0
      eps_0=-p734(2)*p8(3)+p8(2)*p734(3)
      ceps_0=eps_0*cim
      ceps_1=p734(3)*cim
      ceps_2=p8(3)*cim
      auxa=-quqd+p734k0*p8(0)+p8k0*p734(0)
      rz8_734(0).a(1,1)=zcr(id8)*(auxa+ceps_0)
      rz8_734(0).a(2,2)=zcl(id8)*(auxa-ceps_0)
      rz8_734(0).b(1,2)=-zcl(id8)*(p8(2)+ceps_2)
      rz8_734(0).b(2,1)=zcr(id8)*(p8(2)-ceps_2)
      rz8_734(0).c(1,2)=zcr(id8)*(p734(2)+ceps_1)
      rz8_734(0).c(2,1)=zcl(id8)*(-p734(2)+ceps_1)
      rz8_734(0).d(1,1)=zcl(id8)
      rz8_734(0).d(2,2)=zcr(id8)
* T -- qu=p734,qd=p8,v=1,a=rz8_734(1).a,b=rz8_734(1).b,c=rz8_734(1).c,d=
* rz8_734(1).d,cr=zcr(id8),cl=zcl(id8),nsum=0
      auxa=-quqd+p734k0*p8(1)+p8k0*p734(1)
      rz8_734(1).a(1,1)=zcr(id8)*(auxa+ceps_0)
      rz8_734(1).a(2,2)=zcl(id8)*(auxa-ceps_0)
      rz8_734(1).b(1,2)=-zcl(id8)*(p8(2)+ceps_2)
      rz8_734(1).b(2,1)=zcr(id8)*(p8(2)-ceps_2)
      rz8_734(1).c(1,2)=zcr(id8)*(p734(2)+ceps_1)
      rz8_734(1).c(2,1)=zcl(id8)*(-p734(2)+ceps_1)
      rz8_734(1).d(1,1)=zcl(id8)
      rz8_734(1).d(2,2)=zcr(id8)
* T -- qu=p734,qd=p8,v=2,a=rz8_734(2).a,b=rz8_734(2).b,c=rz8_734(2).c,d=
* rz8_734(2).d,cr=zcr(id8),cl=zcl(id8),nsum=0
      eps_0=-p734k0*p8(3)+p8k0*p734(3)
      ceps_0=eps_0*cim
      auxa=p734k0*p8(2)+p8k0*p734(2)
      rz8_734(2).a(1,1)=zcr(id8)*(auxa+ceps_0)
      rz8_734(2).a(2,2)=zcl(id8)*(auxa-ceps_0)
      rz8_734(2).b(1,2)=-zcl(id8)*p8k0
      rz8_734(2).b(2,1)=zcr(id8)*p8k0
      rz8_734(2).c(1,2)=zcr(id8)*p734k0
      rz8_734(2).c(2,1)=-zcl(id8)*p734k0
* T -- qu=p734,qd=p8,v=3,a=rz8_734(3).a,b=rz8_734(3).b,c=rz8_734(3).c,d=
* rz8_734(3).d,cr=zcr(id8),cl=zcl(id8),nsum=0
      eps_0=p734k0*p8(2)-p8k0*p734(2)
      ceps_0=eps_0*cim
      ceps_1=p734k0*cim
      ceps_2=p8k0*cim
      auxa=+p734k0*p8(3)+p8k0*p734(3)
      rz8_734(3).a(1,1)=zcr(id8)*(auxa+ceps_0)
      rz8_734(3).a(2,2)=zcl(id8)*(auxa-ceps_0)
      rz8_734(3).b(1,2)=-zcl(id8)*ceps_2
      rz8_734(3).b(2,1)=-zcr(id8)*ceps_2
      rz8_734(3).c(1,2)=zcr(id8)*ceps_1
      rz8_734(3).c(2,1)=zcl(id8)*ceps_1
  
* T -- qu=p734,qd=p8,v=0,a=rf8_734(0).a,b=rf8_734(0).b,c=rf8_734(0).c,d=
* rf8_734(0).d,cr=fcr(id8),cl=fcl(id8),nsum=0
      eps_0=-p734(2)*p8(3)+p8(2)*p734(3)
      ceps_0=eps_0*cim
      ceps_1=p734(3)*cim
      ceps_2=p8(3)*cim
      auxa=-quqd+p734k0*p8(0)+p8k0*p734(0)
      rf8_734(0).a(1,1)=fcr(id8)*(auxa+ceps_0)
      rf8_734(0).a(2,2)=fcl(id8)*(auxa-ceps_0)
      rf8_734(0).b(1,2)=-fcl(id8)*(p8(2)+ceps_2)
      rf8_734(0).b(2,1)=fcr(id8)*(p8(2)-ceps_2)
      rf8_734(0).c(1,2)=fcr(id8)*(p734(2)+ceps_1)
      rf8_734(0).c(2,1)=fcl(id8)*(-p734(2)+ceps_1)
      rf8_734(0).d(1,1)=fcl(id8)
      rf8_734(0).d(2,2)=fcr(id8)
* T -- qu=p734,qd=p8,v=1,a=rf8_734(1).a,b=rf8_734(1).b,c=rf8_734(1).c,d=
* rf8_734(1).d,cr=fcr(id8),cl=fcl(id8),nsum=0
      auxa=-quqd+p734k0*p8(1)+p8k0*p734(1)
      rf8_734(1).a(1,1)=fcr(id8)*(auxa+ceps_0)
      rf8_734(1).a(2,2)=fcl(id8)*(auxa-ceps_0)
      rf8_734(1).b(1,2)=-fcl(id8)*(p8(2)+ceps_2)
      rf8_734(1).b(2,1)=fcr(id8)*(p8(2)-ceps_2)
      rf8_734(1).c(1,2)=fcr(id8)*(p734(2)+ceps_1)
      rf8_734(1).c(2,1)=fcl(id8)*(-p734(2)+ceps_1)
      rf8_734(1).d(1,1)=fcl(id8)
      rf8_734(1).d(2,2)=fcr(id8)
* T -- qu=p734,qd=p8,v=2,a=rf8_734(2).a,b=rf8_734(2).b,c=rf8_734(2).c,d=
* rf8_734(2).d,cr=fcr(id8),cl=fcl(id8),nsum=0
      eps_0=-p734k0*p8(3)+p8k0*p734(3)
      ceps_0=eps_0*cim
      auxa=p734k0*p8(2)+p8k0*p734(2)
      rf8_734(2).a(1,1)=fcr(id8)*(auxa+ceps_0)
      rf8_734(2).a(2,2)=fcl(id8)*(auxa-ceps_0)
      rf8_734(2).b(1,2)=-fcl(id8)*p8k0
      rf8_734(2).b(2,1)=fcr(id8)*p8k0
      rf8_734(2).c(1,2)=fcr(id8)*p734k0
      rf8_734(2).c(2,1)=-fcl(id8)*p734k0
* T -- qu=p734,qd=p8,v=3,a=rf8_734(3).a,b=rf8_734(3).b,c=rf8_734(3).c,d=
* rf8_734(3).d,cr=fcr(id8),cl=fcl(id8),nsum=0
      eps_0=p734k0*p8(2)-p8k0*p734(2)
      ceps_0=eps_0*cim
      ceps_1=p734k0*cim
      ceps_2=p8k0*cim
      auxa=+p734k0*p8(3)+p8k0*p734(3)
      rf8_734(3).a(1,1)=fcr(id8)*(auxa+ceps_0)
      rf8_734(3).a(2,2)=fcl(id8)*(auxa-ceps_0)
      rf8_734(3).b(1,2)=-fcl(id8)*ceps_2
      rf8_734(3).b(2,1)=-fcr(id8)*ceps_2
      rf8_734(3).c(1,2)=fcr(id8)*ceps_1
      rf8_734(3).c(2,1)=fcl(id8)*ceps_1
  
* quqd -- p=p756,q=p8
      quqd=p756(0)*p8(0)-p756(1)*p8(1)-p756(2)*p8(2)-p756(3)*p8(
     & 3)
* T -- qu=p756,qd=p8,v=0,a=rz8_756(0).a,b=rz8_756(0).b,c=rz8_756(0).c,d=
* rz8_756(0).d,cr=zcr(id8),cl=zcl(id8),nsum=0
      eps_0=-p756(2)*p8(3)+p8(2)*p756(3)
      ceps_0=eps_0*cim
      ceps_1=p756(3)*cim
      ceps_2=p8(3)*cim
      auxa=-quqd+p756k0*p8(0)+p8k0*p756(0)
      rz8_756(0).a(1,1)=zcr(id8)*(auxa+ceps_0)
      rz8_756(0).a(2,2)=zcl(id8)*(auxa-ceps_0)
      rz8_756(0).b(1,2)=-zcl(id8)*(p8(2)+ceps_2)
      rz8_756(0).b(2,1)=zcr(id8)*(p8(2)-ceps_2)
      rz8_756(0).c(1,2)=zcr(id8)*(p756(2)+ceps_1)
      rz8_756(0).c(2,1)=zcl(id8)*(-p756(2)+ceps_1)
      rz8_756(0).d(1,1)=zcl(id8)
      rz8_756(0).d(2,2)=zcr(id8)
* T -- qu=p756,qd=p8,v=1,a=rz8_756(1).a,b=rz8_756(1).b,c=rz8_756(1).c,d=
* rz8_756(1).d,cr=zcr(id8),cl=zcl(id8),nsum=0
      auxa=-quqd+p756k0*p8(1)+p8k0*p756(1)
      rz8_756(1).a(1,1)=zcr(id8)*(auxa+ceps_0)
      rz8_756(1).a(2,2)=zcl(id8)*(auxa-ceps_0)
      rz8_756(1).b(1,2)=-zcl(id8)*(p8(2)+ceps_2)
      rz8_756(1).b(2,1)=zcr(id8)*(p8(2)-ceps_2)
      rz8_756(1).c(1,2)=zcr(id8)*(p756(2)+ceps_1)
      rz8_756(1).c(2,1)=zcl(id8)*(-p756(2)+ceps_1)
      rz8_756(1).d(1,1)=zcl(id8)
      rz8_756(1).d(2,2)=zcr(id8)
* T -- qu=p756,qd=p8,v=2,a=rz8_756(2).a,b=rz8_756(2).b,c=rz8_756(2).c,d=
* rz8_756(2).d,cr=zcr(id8),cl=zcl(id8),nsum=0
      eps_0=-p756k0*p8(3)+p8k0*p756(3)
      ceps_0=eps_0*cim
      auxa=p756k0*p8(2)+p8k0*p756(2)
      rz8_756(2).a(1,1)=zcr(id8)*(auxa+ceps_0)
      rz8_756(2).a(2,2)=zcl(id8)*(auxa-ceps_0)
      rz8_756(2).b(1,2)=-zcl(id8)*p8k0
      rz8_756(2).b(2,1)=zcr(id8)*p8k0
      rz8_756(2).c(1,2)=zcr(id8)*p756k0
      rz8_756(2).c(2,1)=-zcl(id8)*p756k0
* T -- qu=p756,qd=p8,v=3,a=rz8_756(3).a,b=rz8_756(3).b,c=rz8_756(3).c,d=
* rz8_756(3).d,cr=zcr(id8),cl=zcl(id8),nsum=0
      eps_0=p756k0*p8(2)-p8k0*p756(2)
      ceps_0=eps_0*cim
      ceps_1=p756k0*cim
      ceps_2=p8k0*cim
      auxa=+p756k0*p8(3)+p8k0*p756(3)
      rz8_756(3).a(1,1)=zcr(id8)*(auxa+ceps_0)
      rz8_756(3).a(2,2)=zcl(id8)*(auxa-ceps_0)
      rz8_756(3).b(1,2)=-zcl(id8)*ceps_2
      rz8_756(3).b(2,1)=-zcr(id8)*ceps_2
      rz8_756(3).c(1,2)=zcr(id8)*ceps_1
      rz8_756(3).c(2,1)=zcl(id8)*ceps_1
  
* T -- qu=p756,qd=p8,v=0,a=rf8_756(0).a,b=rf8_756(0).b,c=rf8_756(0).c,d=
* rf8_756(0).d,cr=fcr(id8),cl=fcl(id8),nsum=0
      eps_0=-p756(2)*p8(3)+p8(2)*p756(3)
      ceps_0=eps_0*cim
      ceps_1=p756(3)*cim
      ceps_2=p8(3)*cim
      auxa=-quqd+p756k0*p8(0)+p8k0*p756(0)
      rf8_756(0).a(1,1)=fcr(id8)*(auxa+ceps_0)
      rf8_756(0).a(2,2)=fcl(id8)*(auxa-ceps_0)
      rf8_756(0).b(1,2)=-fcl(id8)*(p8(2)+ceps_2)
      rf8_756(0).b(2,1)=fcr(id8)*(p8(2)-ceps_2)
      rf8_756(0).c(1,2)=fcr(id8)*(p756(2)+ceps_1)
      rf8_756(0).c(2,1)=fcl(id8)*(-p756(2)+ceps_1)
      rf8_756(0).d(1,1)=fcl(id8)
      rf8_756(0).d(2,2)=fcr(id8)
* T -- qu=p756,qd=p8,v=1,a=rf8_756(1).a,b=rf8_756(1).b,c=rf8_756(1).c,d=
* rf8_756(1).d,cr=fcr(id8),cl=fcl(id8),nsum=0
      auxa=-quqd+p756k0*p8(1)+p8k0*p756(1)
      rf8_756(1).a(1,1)=fcr(id8)*(auxa+ceps_0)
      rf8_756(1).a(2,2)=fcl(id8)*(auxa-ceps_0)
      rf8_756(1).b(1,2)=-fcl(id8)*(p8(2)+ceps_2)
      rf8_756(1).b(2,1)=fcr(id8)*(p8(2)-ceps_2)
      rf8_756(1).c(1,2)=fcr(id8)*(p756(2)+ceps_1)
      rf8_756(1).c(2,1)=fcl(id8)*(-p756(2)+ceps_1)
      rf8_756(1).d(1,1)=fcl(id8)
      rf8_756(1).d(2,2)=fcr(id8)
* T -- qu=p756,qd=p8,v=2,a=rf8_756(2).a,b=rf8_756(2).b,c=rf8_756(2).c,d=
* rf8_756(2).d,cr=fcr(id8),cl=fcl(id8),nsum=0
      eps_0=-p756k0*p8(3)+p8k0*p756(3)
      ceps_0=eps_0*cim
      auxa=p756k0*p8(2)+p8k0*p756(2)
      rf8_756(2).a(1,1)=fcr(id8)*(auxa+ceps_0)
      rf8_756(2).a(2,2)=fcl(id8)*(auxa-ceps_0)
      rf8_756(2).b(1,2)=-fcl(id8)*p8k0
      rf8_756(2).b(2,1)=fcr(id8)*p8k0
      rf8_756(2).c(1,2)=fcr(id8)*p756k0
      rf8_756(2).c(2,1)=-fcl(id8)*p756k0
* T -- qu=p756,qd=p8,v=3,a=rf8_756(3).a,b=rf8_756(3).b,c=rf8_756(3).c,d=
* rf8_756(3).d,cr=fcr(id8),cl=fcl(id8),nsum=0
      eps_0=p756k0*p8(2)-p8k0*p756(2)
      ceps_0=eps_0*cim
      ceps_1=p756k0*cim
      ceps_2=p8k0*cim
      auxa=+p756k0*p8(3)+p8k0*p756(3)
      rf8_756(3).a(1,1)=fcr(id8)*(auxa+ceps_0)
      rf8_756(3).a(2,2)=fcl(id8)*(auxa-ceps_0)
      rf8_756(3).b(1,2)=-fcl(id8)*ceps_2
      rf8_756(3).b(2,1)=-fcr(id8)*ceps_2
      rf8_756(3).c(1,2)=fcr(id8)*ceps_1
      rf8_756(3).c(2,1)=fcl(id8)*ceps_1
  
  
* compute all single insertions of the type lhi_ (i=1,3)                
*    to a Zline                                                         
*                                                                       
*        i __                                                           
*            |_h__                                                      
*            |                                                          
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id1.eq.5.and.rmh.ge.0.d0) then
* TH -- qu=p1,qd=p234,a=lh1_234.a,b=lh1_234.b,c=lh1_234.c,coupl=1.d0
      auxa=-p1k0*p234(2)+p234k0*p1(2)
      cauxa=auxa-cim*(p234(3)*p1k0-p1(3)*p234k0)
      lh1_234.a(1,2)=cauxa
      lh1_234.a(2,1)=-conjg(cauxa)
      lh1_234.b(1,1)=p234k0
      lh1_234.b(2,2)=lh1_234.b(1,1)
      lh1_234.c(1,1)=p1k0
      lh1_234.c(2,2)=lh1_234.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id1.eq.5.and.rmh.ge.0.d0) then
* TH -- qu=p1,qd=p256,a=lh1_256.a,b=lh1_256.b,c=lh1_256.c,coupl=1.d0
      auxa=-p1k0*p256(2)+p256k0*p1(2)
      cauxa=auxa-cim*(p256(3)*p1k0-p1(3)*p256k0)
      lh1_256.a(1,2)=cauxa
      lh1_256.a(2,1)=-conjg(cauxa)
      lh1_256.b(1,1)=p256k0
      lh1_256.b(2,2)=lh1_256.b(1,1)
      lh1_256.c(1,1)=p1k0
      lh1_256.c(2,2)=lh1_256.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id1.eq.5.and.rmh.ge.0.d0) then
* TH -- qu=p1,qd=p278,a=lh1_278.a,b=lh1_278.b,c=lh1_278.c,coupl=1.d0
      auxa=-p1k0*p278(2)+p278k0*p1(2)
      cauxa=auxa-cim*(p278(3)*p1k0-p1(3)*p278k0)
      lh1_278.a(1,2)=cauxa
      lh1_278.a(2,1)=-conjg(cauxa)
      lh1_278.b(1,1)=p278k0
      lh1_278.b(2,2)=lh1_278.b(1,1)
      lh1_278.c(1,1)=p1k0
      lh1_278.c(2,2)=lh1_278.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id3.eq.5.and.rmh.ge.0.d0) then
* TH -- qu=p3,qd=p412,a=lh3_412.a,b=lh3_412.b,c=lh3_412.c,coupl=1.d0
      auxa=-p3k0*p412(2)+p412k0*p3(2)
      cauxa=auxa-cim*(p412(3)*p3k0-p3(3)*p412k0)
      lh3_412.a(1,2)=cauxa
      lh3_412.a(2,1)=-conjg(cauxa)
      lh3_412.b(1,1)=p412k0
      lh3_412.b(2,2)=lh3_412.b(1,1)
      lh3_412.c(1,1)=p3k0
      lh3_412.c(2,2)=lh3_412.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id3.eq.5.and.rmh.ge.0.d0) then
* TH -- qu=p3,qd=p456,a=lh3_456.a,b=lh3_456.b,c=lh3_456.c,coupl=1.d0
      auxa=-p3k0*p456(2)+p456k0*p3(2)
      cauxa=auxa-cim*(p456(3)*p3k0-p3(3)*p456k0)
      lh3_456.a(1,2)=cauxa
      lh3_456.a(2,1)=-conjg(cauxa)
      lh3_456.b(1,1)=p456k0
      lh3_456.b(2,2)=lh3_456.b(1,1)
      lh3_456.c(1,1)=p3k0
      lh3_456.c(2,2)=lh3_456.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id3.eq.5.and.rmh.ge.0.d0) then
* TH -- qu=p3,qd=p478,a=lh3_478.a,b=lh3_478.b,c=lh3_478.c,coupl=1.d0
      auxa=-p3k0*p478(2)+p478k0*p3(2)
      cauxa=auxa-cim*(p478(3)*p3k0-p3(3)*p478k0)
      lh3_478.a(1,2)=cauxa
      lh3_478.a(2,1)=-conjg(cauxa)
      lh3_478.b(1,1)=p478k0
      lh3_478.b(2,2)=lh3_478.b(1,1)
      lh3_478.c(1,1)=p3k0
      lh3_478.c(2,2)=lh3_478.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id5.eq.5.and.rmh.ge.0.d0) then
* TH -- qu=p5,qd=p612,a=lh5_612.a,b=lh5_612.b,c=lh5_612.c,coupl=1.d0
      auxa=-p5k0*p612(2)+p612k0*p5(2)
      cauxa=auxa-cim*(p612(3)*p5k0-p5(3)*p612k0)
      lh5_612.a(1,2)=cauxa
      lh5_612.a(2,1)=-conjg(cauxa)
      lh5_612.b(1,1)=p612k0
      lh5_612.b(2,2)=lh5_612.b(1,1)
      lh5_612.c(1,1)=p5k0
      lh5_612.c(2,2)=lh5_612.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id5.eq.5.and.rmh.ge.0.d0) then
* TH -- qu=p5,qd=p634,a=lh5_634.a,b=lh5_634.b,c=lh5_634.c,coupl=1.d0
      auxa=-p5k0*p634(2)+p634k0*p5(2)
      cauxa=auxa-cim*(p634(3)*p5k0-p5(3)*p634k0)
      lh5_634.a(1,2)=cauxa
      lh5_634.a(2,1)=-conjg(cauxa)
      lh5_634.b(1,1)=p634k0
      lh5_634.b(2,2)=lh5_634.b(1,1)
      lh5_634.c(1,1)=p5k0
      lh5_634.c(2,2)=lh5_634.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id5.eq.5.and.rmh.ge.0.d0) then
* TH -- qu=p5,qd=p678,a=lh5_678.a,b=lh5_678.b,c=lh5_678.c,coupl=1.d0
      auxa=-p5k0*p678(2)+p678k0*p5(2)
      cauxa=auxa-cim*(p678(3)*p5k0-p5(3)*p678k0)
      lh5_678.a(1,2)=cauxa
      lh5_678.a(2,1)=-conjg(cauxa)
      lh5_678.b(1,1)=p678k0
      lh5_678.b(2,2)=lh5_678.b(1,1)
      lh5_678.c(1,1)=p5k0
      lh5_678.c(2,2)=lh5_678.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id7.eq.5.and.rmh.ge.0.d0) then
* TH -- qu=p7,qd=p812,a=lh7_812.a,b=lh7_812.b,c=lh7_812.c,coupl=1.d0
      auxa=-p7k0*p812(2)+p812k0*p7(2)
      cauxa=auxa-cim*(p812(3)*p7k0-p7(3)*p812k0)
      lh7_812.a(1,2)=cauxa
      lh7_812.a(2,1)=-conjg(cauxa)
      lh7_812.b(1,1)=p812k0
      lh7_812.b(2,2)=lh7_812.b(1,1)
      lh7_812.c(1,1)=p7k0
      lh7_812.c(2,2)=lh7_812.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id7.eq.5.and.rmh.ge.0.d0) then
* TH -- qu=p7,qd=p834,a=lh7_834.a,b=lh7_834.b,c=lh7_834.c,coupl=1.d0
      auxa=-p7k0*p834(2)+p834k0*p7(2)
      cauxa=auxa-cim*(p834(3)*p7k0-p7(3)*p834k0)
      lh7_834.a(1,2)=cauxa
      lh7_834.a(2,1)=-conjg(cauxa)
      lh7_834.b(1,1)=p834k0
      lh7_834.b(2,2)=lh7_834.b(1,1)
      lh7_834.c(1,1)=p7k0
      lh7_834.c(2,2)=lh7_834.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id7.eq.5.and.rmh.ge.0.d0) then
* TH -- qu=p7,qd=p856,a=lh7_856.a,b=lh7_856.b,c=lh7_856.c,coupl=1.d0
      auxa=-p7k0*p856(2)+p856k0*p7(2)
      cauxa=auxa-cim*(p856(3)*p7k0-p7(3)*p856k0)
      lh7_856.a(1,2)=cauxa
      lh7_856.a(2,1)=-conjg(cauxa)
      lh7_856.b(1,1)=p856k0
      lh7_856.b(2,2)=lh7_856.b(1,1)
      lh7_856.c(1,1)=p7k0
      lh7_856.c(2,2)=lh7_856.c(1,1)
      endif
  
  
* compute all single insertions of the type rhi_ (i=2,4)                
*    to a Zline                                                         
*                                                                       
*            |_h__                                                      
*        i __|                                                          
*                                                                       
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id2.eq.-5.and.rmh.ge.0.d0) then
* TH -- qu=p134,qd=p2,a=rh2_134.a,b=rh2_134.b,c=rh2_134.c,coupl=1.d0
      auxa=-p134k0*p2(2)+p2k0*p134(2)
      cauxa=auxa-cim*(p2(3)*p134k0-p134(3)*p2k0)
      rh2_134.a(1,2)=cauxa
      rh2_134.a(2,1)=-conjg(cauxa)
      rh2_134.b(1,1)=p2k0
      rh2_134.b(2,2)=rh2_134.b(1,1)
      rh2_134.c(1,1)=p134k0
      rh2_134.c(2,2)=rh2_134.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id2.eq.-5.and.rmh.ge.0.d0) then
* TH -- qu=p156,qd=p2,a=rh2_156.a,b=rh2_156.b,c=rh2_156.c,coupl=1.d0
      auxa=-p156k0*p2(2)+p2k0*p156(2)
      cauxa=auxa-cim*(p2(3)*p156k0-p156(3)*p2k0)
      rh2_156.a(1,2)=cauxa
      rh2_156.a(2,1)=-conjg(cauxa)
      rh2_156.b(1,1)=p2k0
      rh2_156.b(2,2)=rh2_156.b(1,1)
      rh2_156.c(1,1)=p156k0
      rh2_156.c(2,2)=rh2_156.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id2.eq.-5.and.rmh.ge.0.d0) then
* TH -- qu=p178,qd=p2,a=rh2_178.a,b=rh2_178.b,c=rh2_178.c,coupl=1.d0
      auxa=-p178k0*p2(2)+p2k0*p178(2)
      cauxa=auxa-cim*(p2(3)*p178k0-p178(3)*p2k0)
      rh2_178.a(1,2)=cauxa
      rh2_178.a(2,1)=-conjg(cauxa)
      rh2_178.b(1,1)=p2k0
      rh2_178.b(2,2)=rh2_178.b(1,1)
      rh2_178.c(1,1)=p178k0
      rh2_178.c(2,2)=rh2_178.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id4.eq.-5.and.rmh.ge.0.d0) then
* TH -- qu=p312,qd=p4,a=rh4_312.a,b=rh4_312.b,c=rh4_312.c,coupl=1.d0
      auxa=-p312k0*p4(2)+p4k0*p312(2)
      cauxa=auxa-cim*(p4(3)*p312k0-p312(3)*p4k0)
      rh4_312.a(1,2)=cauxa
      rh4_312.a(2,1)=-conjg(cauxa)
      rh4_312.b(1,1)=p4k0
      rh4_312.b(2,2)=rh4_312.b(1,1)
      rh4_312.c(1,1)=p312k0
      rh4_312.c(2,2)=rh4_312.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id4.eq.-5.and.rmh.ge.0.d0) then
* TH -- qu=p356,qd=p4,a=rh4_356.a,b=rh4_356.b,c=rh4_356.c,coupl=1.d0
      auxa=-p356k0*p4(2)+p4k0*p356(2)
      cauxa=auxa-cim*(p4(3)*p356k0-p356(3)*p4k0)
      rh4_356.a(1,2)=cauxa
      rh4_356.a(2,1)=-conjg(cauxa)
      rh4_356.b(1,1)=p4k0
      rh4_356.b(2,2)=rh4_356.b(1,1)
      rh4_356.c(1,1)=p356k0
      rh4_356.c(2,2)=rh4_356.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id4.eq.-5.and.rmh.ge.0.d0) then
* TH -- qu=p378,qd=p4,a=rh4_378.a,b=rh4_378.b,c=rh4_378.c,coupl=1.d0
      auxa=-p378k0*p4(2)+p4k0*p378(2)
      cauxa=auxa-cim*(p4(3)*p378k0-p378(3)*p4k0)
      rh4_378.a(1,2)=cauxa
      rh4_378.a(2,1)=-conjg(cauxa)
      rh4_378.b(1,1)=p4k0
      rh4_378.b(2,2)=rh4_378.b(1,1)
      rh4_378.c(1,1)=p378k0
      rh4_378.c(2,2)=rh4_378.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id6.eq.-5.and.rmh.ge.0.d0) then
* TH -- qu=p512,qd=p6,a=rh6_512.a,b=rh6_512.b,c=rh6_512.c,coupl=1.d0
      auxa=-p512k0*p6(2)+p6k0*p512(2)
      cauxa=auxa-cim*(p6(3)*p512k0-p512(3)*p6k0)
      rh6_512.a(1,2)=cauxa
      rh6_512.a(2,1)=-conjg(cauxa)
      rh6_512.b(1,1)=p6k0
      rh6_512.b(2,2)=rh6_512.b(1,1)
      rh6_512.c(1,1)=p512k0
      rh6_512.c(2,2)=rh6_512.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id6.eq.-5.and.rmh.ge.0.d0) then
* TH -- qu=p534,qd=p6,a=rh6_534.a,b=rh6_534.b,c=rh6_534.c,coupl=1.d0
      auxa=-p534k0*p6(2)+p6k0*p534(2)
      cauxa=auxa-cim*(p6(3)*p534k0-p534(3)*p6k0)
      rh6_534.a(1,2)=cauxa
      rh6_534.a(2,1)=-conjg(cauxa)
      rh6_534.b(1,1)=p6k0
      rh6_534.b(2,2)=rh6_534.b(1,1)
      rh6_534.c(1,1)=p534k0
      rh6_534.c(2,2)=rh6_534.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id6.eq.-5.and.rmh.ge.0.d0) then
* TH -- qu=p578,qd=p6,a=rh6_578.a,b=rh6_578.b,c=rh6_578.c,coupl=1.d0
      auxa=-p578k0*p6(2)+p6k0*p578(2)
      cauxa=auxa-cim*(p6(3)*p578k0-p578(3)*p6k0)
      rh6_578.a(1,2)=cauxa
      rh6_578.a(2,1)=-conjg(cauxa)
      rh6_578.b(1,1)=p6k0
      rh6_578.b(2,2)=rh6_578.b(1,1)
      rh6_578.c(1,1)=p578k0
      rh6_578.c(2,2)=rh6_578.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id8.eq.-5.and.rmh.ge.0.d0) then
* TH -- qu=p712,qd=p8,a=rh8_712.a,b=rh8_712.b,c=rh8_712.c,coupl=1.d0
      auxa=-p712k0*p8(2)+p8k0*p712(2)
      cauxa=auxa-cim*(p8(3)*p712k0-p712(3)*p8k0)
      rh8_712.a(1,2)=cauxa
      rh8_712.a(2,1)=-conjg(cauxa)
      rh8_712.b(1,1)=p8k0
      rh8_712.b(2,2)=rh8_712.b(1,1)
      rh8_712.c(1,1)=p712k0
      rh8_712.c(2,2)=rh8_712.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id8.eq.-5.and.rmh.ge.0.d0) then
* TH -- qu=p734,qd=p8,a=rh8_734.a,b=rh8_734.b,c=rh8_734.c,coupl=1.d0
      auxa=-p734k0*p8(2)+p8k0*p734(2)
      cauxa=auxa-cim*(p8(3)*p734k0-p734(3)*p8k0)
      rh8_734.a(1,2)=cauxa
      rh8_734.a(2,1)=-conjg(cauxa)
      rh8_734.b(1,1)=p8k0
      rh8_734.b(2,2)=rh8_734.b(1,1)
      rh8_734.c(1,1)=p734k0
      rh8_734.c(2,2)=rh8_734.c(1,1)
      endif
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id8.eq.-5.and.rmh.ge.0.d0) then
* TH -- qu=p756,qd=p8,a=rh8_756.a,b=rh8_756.b,c=rh8_756.c,coupl=1.d0
      auxa=-p756k0*p8(2)+p8k0*p756(2)
      cauxa=auxa-cim*(p8(3)*p756k0-p756(3)*p8k0)
      rh8_756.a(1,2)=cauxa
      rh8_756.a(2,1)=-conjg(cauxa)
      rh8_756.b(1,1)=p8k0
      rh8_756.b(2,2)=rh8_756.b(1,1)
      rh8_756.c(1,1)=p756k0
      rh8_756.c(2,2)=rh8_756.c(1,1)
      endif
  
* COMPUTE ALL SUBDIAGRAMS WITH A Z OR A GAMMA "DECAYING" TO 4 FERMIONS  
*  WHICH CORRESPOND TO TWO Z'S                                          
*                  CZIJKL(MU)  AND CFIJKL(MU) (IJKL PARTICLE NUMBERS)   
*                                                                       
*               _____ i                     _____ i                     
*              |  |__ j                    |  |__ j                     
*    (mu) --Z--|  |__ k          (mu) --f--|  |__ k                     
*              |__|__ l                    |__|__ l                     
*                                                                       
*                                                                       
  
       	do i1=1,2
       	do i2=1,2
      	do i3=1,2
      	do i4=1,2
      	do mu=0,3
      cf1234(i1,i2,i3,i4,mu)=czero
      cf5678(i1,i2,i3,i4,mu)=czero
      cf3456(i1,i2,i3,i4,mu)=czero
      cf1278(i1,i2,i3,i4,mu)=czero
      cf3478(i1,i2,i3,i4,mu)=czero
      cf1256(i1,i2,i3,i4,mu)=czero
      enddo
      enddo
      end do
      end do
      end do
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* TsT -- aa=clinetzz(i3,i4,mu).a,bb=clinetzz(i3,i4,mu).b,cc=clinetzz(i3,
* i4,mu).c,dd=clinetzz(i3,i4,mu).d,a1=l1_34(i3,i4).a,b1=l1_34(i3,i4).b,c
* 1=l1_34(i3,i4).c,d1=l1_34(i3,i4).d,a2=rz2_134(mu).a,b2=rz2_134(mu).b,c
* 2=rz2_134(mu).c,d2=rz2_134(mu).d,prq=p134q,m=rmass(id1),nsum=0
      do iut=1,2
      cx1=l1_34(i3,i4).a(iut,1)+l1_34(i3,i4).c(iut,1)*rmass(id1)
      cx2=l1_34(i3,i4).c(iut,2)*p134q+l1_34(i3,i4).a(iut,2)*rmas
     & s(id1)
      cy1=l1_34(i3,i4).b(iut,1)+l1_34(i3,i4).d(iut,1)*rmass(id1)
      cy2=l1_34(i3,i4).d(iut,2)*p134q+l1_34(i3,i4).b(iut,2)*rmas
     & s(id1)
      cw1=l1_34(i3,i4).c(iut,1)*p134q+l1_34(i3,i4).a(iut,1)*rmas
     & s(id1)
      cw2=l1_34(i3,i4).a(iut,2)+l1_34(i3,i4).c(iut,2)*rmass(id1)
      cz1=l1_34(i3,i4).d(iut,1)*p134q+l1_34(i3,i4).b(iut,1)*rmas
     & s(id1)
      cz2=l1_34(i3,i4).b(iut,2)+l1_34(i3,i4).d(iut,2)*rmass(id1)
      clinetzz(i3,i4,mu).a(iut,1)=cx1*rz2_134(mu).a(1,1)+cx2*rz2
     & _134(mu).b(2,1)
      clinetzz(i3,i4,mu).b(iut,1)=cy1*rz2_134(mu).a(1,1)+cy2*rz2
     & _134(mu).b(2,1)
      clinetzz(i3,i4,mu).c(iut,1)=cw1*rz2_134(mu).d(1,1)+cw2*rz2
     & _134(mu).c(2,1)
      clinetzz(i3,i4,mu).d(iut,1)=cz1*rz2_134(mu).d(1,1)+cz2*rz2
     & _134(mu).c(2,1)
      clinetzz(i3,i4,mu).a(iut,2)=cw1*rz2_134(mu).b(1,2)+cw2*rz2
     & _134(mu).a(2,2)
      clinetzz(i3,i4,mu).b(iut,2)=cz1*rz2_134(mu).b(1,2)+cz2*rz2
     & _134(mu).a(2,2)
      clinetzz(i3,i4,mu).c(iut,2)=cx1*rz2_134(mu).c(1,2)+cx2*rz2
     & _134(mu).d(2,2)
      clinetzz(i3,i4,mu).d(iut,2)=cy1*rz2_134(mu).c(1,2)+cy2*rz2
     & _134(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* TTs -- aa=clinetzz(i3,i4,mu).a,bb=clinetzz(i3,i4,mu).b,cc=clinetzz(i3,
* i4,mu).c,dd=clinetzz(i3,i4,mu).d,a1=lz1_234(mu).a,b1=lz1_234(mu).b,c1=
* lz1_234(mu).c,d1=lz1_234(mu).d,a2=r2_34(i3,i4).a,b2=r2_34(i3,i4).b,c2=
* r2_34(i3,i4).c,d2=r2_34(i3,i4).d,prq=p234q,m=rmass(id1),nsum=1
      do jut=1,2
      cx1=r2_34(i3,i4).a(1,jut)+rmass(id1)*r2_34(i3,i4).b(1,jut)
      cx2=r2_34(i3,i4).a(2,jut)+rmass(id1)*r2_34(i3,i4).b(2,jut)
      cy1=p234q*r2_34(i3,i4).b(1,jut)+rmass(id1)*r2_34(i3,i4).a(
     & 1,jut)
      cy2=p234q*r2_34(i3,i4).b(2,jut)+rmass(id1)*r2_34(i3,i4).a(
     & 2,jut)
      cw1=r2_34(i3,i4).c(1,jut)+rmass(id1)*r2_34(i3,i4).d(1,jut)
      cw2=r2_34(i3,i4).c(2,jut)+rmass(id1)*r2_34(i3,i4).d(2,jut)
      cz1=p234q*r2_34(i3,i4).d(1,jut)+rmass(id1)*r2_34(i3,i4).c(
     & 1,jut)
      cz2=p234q*r2_34(i3,i4).d(2,jut)+rmass(id1)*r2_34(i3,i4).c(
     & 2,jut)
      clinetzz(i3,i4,mu).a(1,jut)=clinetzz(i3,i4,mu).a(1,jut)+lz
     & 1_234(mu).a(1,1)*cx1+lz1_234(mu).c(1,2)*cy2
      clinetzz(i3,i4,mu).b(1,jut)=clinetzz(i3,i4,mu).b(1,jut)+lz
     & 1_234(mu).d(1,1)*cy1+lz1_234(mu).b(1,2)*cx2
      clinetzz(i3,i4,mu).c(1,jut)=clinetzz(i3,i4,mu).c(1,jut)+lz
     & 1_234(mu).a(1,1)*cw1+lz1_234(mu).c(1,2)*cz2
      clinetzz(i3,i4,mu).d(1,jut)=clinetzz(i3,i4,mu).d(1,jut)+lz
     & 1_234(mu).d(1,1)*cz1+lz1_234(mu).b(1,2)*cw2
      clinetzz(i3,i4,mu).a(2,jut)=clinetzz(i3,i4,mu).a(2,jut)+lz
     & 1_234(mu).c(2,1)*cy1+lz1_234(mu).a(2,2)*cx2
      clinetzz(i3,i4,mu).b(2,jut)=clinetzz(i3,i4,mu).b(2,jut)+lz
     & 1_234(mu).b(2,1)*cx1+lz1_234(mu).d(2,2)*cy2
      clinetzz(i3,i4,mu).c(2,jut)=clinetzz(i3,i4,mu).c(2,jut)+lz
     & 1_234(mu).c(2,1)*cz1+lz1_234(mu).a(2,2)*cw2
      clinetzz(i3,i4,mu).d(2,jut)=clinetzz(i3,i4,mu).d(2,jut)+lz
     & 1_234(mu).b(2,1)*cw1+lz1_234(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id1)
      rmassr=-rmass(id2)
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* mline -- res=cz1234(&1,&2,i3,i4,mu),abcd=clinetzz(i3,i4,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cz1234(iut,jut,i3,i4,mu)=clinetzz(i3,i4,mu).a(iut,jut)+rma
     & ssl*clinetzz(i3,i4,mu).b(iut,jut)+rmassr*clinetzz(i3,i4,m
     & u).c(iut,jut)+rmassl*rmassr*clinetzz(i3,i4,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* TsT -- aa=clinetzz(i1,i2,mu).a,bb=clinetzz(i1,i2,mu).b,cc=clinetzz(i1,
* i2,mu).c,dd=clinetzz(i1,i2,mu).d,a1=l3_12(i1,i2).a,b1=l3_12(i1,i2).b,c
* 1=l3_12(i1,i2).c,d1=l3_12(i1,i2).d,a2=rz4_312(mu).a,b2=rz4_312(mu).b,c
* 2=rz4_312(mu).c,d2=rz4_312(mu).d,prq=p312q,m=rmass(id3),nsum=0
      do iut=1,2
      cx1=l3_12(i1,i2).a(iut,1)+l3_12(i1,i2).c(iut,1)*rmass(id3)
      cx2=l3_12(i1,i2).c(iut,2)*p312q+l3_12(i1,i2).a(iut,2)*rmas
     & s(id3)
      cy1=l3_12(i1,i2).b(iut,1)+l3_12(i1,i2).d(iut,1)*rmass(id3)
      cy2=l3_12(i1,i2).d(iut,2)*p312q+l3_12(i1,i2).b(iut,2)*rmas
     & s(id3)
      cw1=l3_12(i1,i2).c(iut,1)*p312q+l3_12(i1,i2).a(iut,1)*rmas
     & s(id3)
      cw2=l3_12(i1,i2).a(iut,2)+l3_12(i1,i2).c(iut,2)*rmass(id3)
      cz1=l3_12(i1,i2).d(iut,1)*p312q+l3_12(i1,i2).b(iut,1)*rmas
     & s(id3)
      cz2=l3_12(i1,i2).b(iut,2)+l3_12(i1,i2).d(iut,2)*rmass(id3)
      clinetzz(i1,i2,mu).a(iut,1)=cx1*rz4_312(mu).a(1,1)+cx2*rz4
     & _312(mu).b(2,1)
      clinetzz(i1,i2,mu).b(iut,1)=cy1*rz4_312(mu).a(1,1)+cy2*rz4
     & _312(mu).b(2,1)
      clinetzz(i1,i2,mu).c(iut,1)=cw1*rz4_312(mu).d(1,1)+cw2*rz4
     & _312(mu).c(2,1)
      clinetzz(i1,i2,mu).d(iut,1)=cz1*rz4_312(mu).d(1,1)+cz2*rz4
     & _312(mu).c(2,1)
      clinetzz(i1,i2,mu).a(iut,2)=cw1*rz4_312(mu).b(1,2)+cw2*rz4
     & _312(mu).a(2,2)
      clinetzz(i1,i2,mu).b(iut,2)=cz1*rz4_312(mu).b(1,2)+cz2*rz4
     & _312(mu).a(2,2)
      clinetzz(i1,i2,mu).c(iut,2)=cx1*rz4_312(mu).c(1,2)+cx2*rz4
     & _312(mu).d(2,2)
      clinetzz(i1,i2,mu).d(iut,2)=cy1*rz4_312(mu).c(1,2)+cy2*rz4
     & _312(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* TTs -- aa=clinetzz(i1,i2,mu).a,bb=clinetzz(i1,i2,mu).b,cc=clinetzz(i1,
* i2,mu).c,dd=clinetzz(i1,i2,mu).d,a1=lz3_412(mu).a,b1=lz3_412(mu).b,c1=
* lz3_412(mu).c,d1=lz3_412(mu).d,a2=r4_12(i1,i2).a,b2=r4_12(i1,i2).b,c2=
* r4_12(i1,i2).c,d2=r4_12(i1,i2).d,prq=p412q,m=rmass(id3),nsum=1
      do jut=1,2
      cx1=r4_12(i1,i2).a(1,jut)+rmass(id3)*r4_12(i1,i2).b(1,jut)
      cx2=r4_12(i1,i2).a(2,jut)+rmass(id3)*r4_12(i1,i2).b(2,jut)
      cy1=p412q*r4_12(i1,i2).b(1,jut)+rmass(id3)*r4_12(i1,i2).a(
     & 1,jut)
      cy2=p412q*r4_12(i1,i2).b(2,jut)+rmass(id3)*r4_12(i1,i2).a(
     & 2,jut)
      cw1=r4_12(i1,i2).c(1,jut)+rmass(id3)*r4_12(i1,i2).d(1,jut)
      cw2=r4_12(i1,i2).c(2,jut)+rmass(id3)*r4_12(i1,i2).d(2,jut)
      cz1=p412q*r4_12(i1,i2).d(1,jut)+rmass(id3)*r4_12(i1,i2).c(
     & 1,jut)
      cz2=p412q*r4_12(i1,i2).d(2,jut)+rmass(id3)*r4_12(i1,i2).c(
     & 2,jut)
      clinetzz(i1,i2,mu).a(1,jut)=clinetzz(i1,i2,mu).a(1,jut)+lz
     & 3_412(mu).a(1,1)*cx1+lz3_412(mu).c(1,2)*cy2
      clinetzz(i1,i2,mu).b(1,jut)=clinetzz(i1,i2,mu).b(1,jut)+lz
     & 3_412(mu).d(1,1)*cy1+lz3_412(mu).b(1,2)*cx2
      clinetzz(i1,i2,mu).c(1,jut)=clinetzz(i1,i2,mu).c(1,jut)+lz
     & 3_412(mu).a(1,1)*cw1+lz3_412(mu).c(1,2)*cz2
      clinetzz(i1,i2,mu).d(1,jut)=clinetzz(i1,i2,mu).d(1,jut)+lz
     & 3_412(mu).d(1,1)*cz1+lz3_412(mu).b(1,2)*cw2
      clinetzz(i1,i2,mu).a(2,jut)=clinetzz(i1,i2,mu).a(2,jut)+lz
     & 3_412(mu).c(2,1)*cy1+lz3_412(mu).a(2,2)*cx2
      clinetzz(i1,i2,mu).b(2,jut)=clinetzz(i1,i2,mu).b(2,jut)+lz
     & 3_412(mu).b(2,1)*cx1+lz3_412(mu).d(2,2)*cy2
      clinetzz(i1,i2,mu).c(2,jut)=clinetzz(i1,i2,mu).c(2,jut)+lz
     & 3_412(mu).c(2,1)*cz1+lz3_412(mu).a(2,2)*cw2
      clinetzz(i1,i2,mu).d(2,jut)=clinetzz(i1,i2,mu).d(2,jut)+lz
     & 3_412(mu).b(2,1)*cw1+lz3_412(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id3)
      rmassr=-rmass(id4)
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* mline -- res=cz1234(i1,i2,&1,&2,mu),abcd=clinetzz(i1,i2,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      cz1234(i1,i2,iut,jut,mu)=cz1234(i1,i2,iut,jut,mu)+clinetzz
     & (i1,i2,mu).a(iut,jut)+rmassl*clinetzz(i1,i2,mu).b(iut,jut
     & )+rmassr*clinetzz(i1,i2,mu).c(iut,jut)+rmassl*rmassr*clin
     & etzz(i1,i2,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i7=1,2
      do i8=1,2
      do mu=0,3
* TsT -- aa=clinetzz(i7,i8,mu).a,bb=clinetzz(i7,i8,mu).b,cc=clinetzz(i7,
* i8,mu).c,dd=clinetzz(i7,i8,mu).d,a1=l5_78(i7,i8).a,b1=l5_78(i7,i8).b,c
* 1=l5_78(i7,i8).c,d1=l5_78(i7,i8).d,a2=rz6_578(mu).a,b2=rz6_578(mu).b,c
* 2=rz6_578(mu).c,d2=rz6_578(mu).d,prq=p578q,m=rmass(id5),nsum=0
      do iut=1,2
      cx1=l5_78(i7,i8).a(iut,1)+l5_78(i7,i8).c(iut,1)*rmass(id5)
      cx2=l5_78(i7,i8).c(iut,2)*p578q+l5_78(i7,i8).a(iut,2)*rmas
     & s(id5)
      cy1=l5_78(i7,i8).b(iut,1)+l5_78(i7,i8).d(iut,1)*rmass(id5)
      cy2=l5_78(i7,i8).d(iut,2)*p578q+l5_78(i7,i8).b(iut,2)*rmas
     & s(id5)
      cw1=l5_78(i7,i8).c(iut,1)*p578q+l5_78(i7,i8).a(iut,1)*rmas
     & s(id5)
      cw2=l5_78(i7,i8).a(iut,2)+l5_78(i7,i8).c(iut,2)*rmass(id5)
      cz1=l5_78(i7,i8).d(iut,1)*p578q+l5_78(i7,i8).b(iut,1)*rmas
     & s(id5)
      cz2=l5_78(i7,i8).b(iut,2)+l5_78(i7,i8).d(iut,2)*rmass(id5)
      clinetzz(i7,i8,mu).a(iut,1)=cx1*rz6_578(mu).a(1,1)+cx2*rz6
     & _578(mu).b(2,1)
      clinetzz(i7,i8,mu).b(iut,1)=cy1*rz6_578(mu).a(1,1)+cy2*rz6
     & _578(mu).b(2,1)
      clinetzz(i7,i8,mu).c(iut,1)=cw1*rz6_578(mu).d(1,1)+cw2*rz6
     & _578(mu).c(2,1)
      clinetzz(i7,i8,mu).d(iut,1)=cz1*rz6_578(mu).d(1,1)+cz2*rz6
     & _578(mu).c(2,1)
      clinetzz(i7,i8,mu).a(iut,2)=cw1*rz6_578(mu).b(1,2)+cw2*rz6
     & _578(mu).a(2,2)
      clinetzz(i7,i8,mu).b(iut,2)=cz1*rz6_578(mu).b(1,2)+cz2*rz6
     & _578(mu).a(2,2)
      clinetzz(i7,i8,mu).c(iut,2)=cx1*rz6_578(mu).c(1,2)+cx2*rz6
     & _578(mu).d(2,2)
      clinetzz(i7,i8,mu).d(iut,2)=cy1*rz6_578(mu).c(1,2)+cy2*rz6
     & _578(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i7=1,2
      do i8=1,2
      do mu=0,3
* TTs -- aa=clinetzz(i7,i8,mu).a,bb=clinetzz(i7,i8,mu).b,cc=clinetzz(i7,
* i8,mu).c,dd=clinetzz(i7,i8,mu).d,a1=lz5_678(mu).a,b1=lz5_678(mu).b,c1=
* lz5_678(mu).c,d1=lz5_678(mu).d,a2=r6_78(i7,i8).a,b2=r6_78(i7,i8).b,c2=
* r6_78(i7,i8).c,d2=r6_78(i7,i8).d,prq=p678q,m=rmass(id5),nsum=1
      do jut=1,2
      cx1=r6_78(i7,i8).a(1,jut)+rmass(id5)*r6_78(i7,i8).b(1,jut)
      cx2=r6_78(i7,i8).a(2,jut)+rmass(id5)*r6_78(i7,i8).b(2,jut)
      cy1=p678q*r6_78(i7,i8).b(1,jut)+rmass(id5)*r6_78(i7,i8).a(
     & 1,jut)
      cy2=p678q*r6_78(i7,i8).b(2,jut)+rmass(id5)*r6_78(i7,i8).a(
     & 2,jut)
      cw1=r6_78(i7,i8).c(1,jut)+rmass(id5)*r6_78(i7,i8).d(1,jut)
      cw2=r6_78(i7,i8).c(2,jut)+rmass(id5)*r6_78(i7,i8).d(2,jut)
      cz1=p678q*r6_78(i7,i8).d(1,jut)+rmass(id5)*r6_78(i7,i8).c(
     & 1,jut)
      cz2=p678q*r6_78(i7,i8).d(2,jut)+rmass(id5)*r6_78(i7,i8).c(
     & 2,jut)
      clinetzz(i7,i8,mu).a(1,jut)=clinetzz(i7,i8,mu).a(1,jut)+lz
     & 5_678(mu).a(1,1)*cx1+lz5_678(mu).c(1,2)*cy2
      clinetzz(i7,i8,mu).b(1,jut)=clinetzz(i7,i8,mu).b(1,jut)+lz
     & 5_678(mu).d(1,1)*cy1+lz5_678(mu).b(1,2)*cx2
      clinetzz(i7,i8,mu).c(1,jut)=clinetzz(i7,i8,mu).c(1,jut)+lz
     & 5_678(mu).a(1,1)*cw1+lz5_678(mu).c(1,2)*cz2
      clinetzz(i7,i8,mu).d(1,jut)=clinetzz(i7,i8,mu).d(1,jut)+lz
     & 5_678(mu).d(1,1)*cz1+lz5_678(mu).b(1,2)*cw2
      clinetzz(i7,i8,mu).a(2,jut)=clinetzz(i7,i8,mu).a(2,jut)+lz
     & 5_678(mu).c(2,1)*cy1+lz5_678(mu).a(2,2)*cx2
      clinetzz(i7,i8,mu).b(2,jut)=clinetzz(i7,i8,mu).b(2,jut)+lz
     & 5_678(mu).b(2,1)*cx1+lz5_678(mu).d(2,2)*cy2
      clinetzz(i7,i8,mu).c(2,jut)=clinetzz(i7,i8,mu).c(2,jut)+lz
     & 5_678(mu).c(2,1)*cz1+lz5_678(mu).a(2,2)*cw2
      clinetzz(i7,i8,mu).d(2,jut)=clinetzz(i7,i8,mu).d(2,jut)+lz
     & 5_678(mu).b(2,1)*cw1+lz5_678(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id5)
      rmassr=-rmass(id6)
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* mline -- res=cz5678(&1,&2,i3,i4,mu),abcd=clinetzz(i3,i4,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cz5678(iut,jut,i3,i4,mu)=clinetzz(i3,i4,mu).a(iut,jut)+rma
     & ssl*clinetzz(i3,i4,mu).b(iut,jut)+rmassr*clinetzz(i3,i4,m
     & u).c(iut,jut)+rmassl*rmassr*clinetzz(i3,i4,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i5=1,2
      do i6=1,2
      do mu=0,3
* TsT -- aa=clinetzz(i5,i6,mu).a,bb=clinetzz(i5,i6,mu).b,cc=clinetzz(i5,
* i6,mu).c,dd=clinetzz(i5,i6,mu).d,a1=l7_56(i5,i6).a,b1=l7_56(i5,i6).b,c
* 1=l7_56(i5,i6).c,d1=l7_56(i5,i6).d,a2=rz8_756(mu).a,b2=rz8_756(mu).b,c
* 2=rz8_756(mu).c,d2=rz8_756(mu).d,prq=p756q,m=rmass(id7),nsum=0
      do iut=1,2
      cx1=l7_56(i5,i6).a(iut,1)+l7_56(i5,i6).c(iut,1)*rmass(id7)
      cx2=l7_56(i5,i6).c(iut,2)*p756q+l7_56(i5,i6).a(iut,2)*rmas
     & s(id7)
      cy1=l7_56(i5,i6).b(iut,1)+l7_56(i5,i6).d(iut,1)*rmass(id7)
      cy2=l7_56(i5,i6).d(iut,2)*p756q+l7_56(i5,i6).b(iut,2)*rmas
     & s(id7)
      cw1=l7_56(i5,i6).c(iut,1)*p756q+l7_56(i5,i6).a(iut,1)*rmas
     & s(id7)
      cw2=l7_56(i5,i6).a(iut,2)+l7_56(i5,i6).c(iut,2)*rmass(id7)
      cz1=l7_56(i5,i6).d(iut,1)*p756q+l7_56(i5,i6).b(iut,1)*rmas
     & s(id7)
      cz2=l7_56(i5,i6).b(iut,2)+l7_56(i5,i6).d(iut,2)*rmass(id7)
      clinetzz(i5,i6,mu).a(iut,1)=cx1*rz8_756(mu).a(1,1)+cx2*rz8
     & _756(mu).b(2,1)
      clinetzz(i5,i6,mu).b(iut,1)=cy1*rz8_756(mu).a(1,1)+cy2*rz8
     & _756(mu).b(2,1)
      clinetzz(i5,i6,mu).c(iut,1)=cw1*rz8_756(mu).d(1,1)+cw2*rz8
     & _756(mu).c(2,1)
      clinetzz(i5,i6,mu).d(iut,1)=cz1*rz8_756(mu).d(1,1)+cz2*rz8
     & _756(mu).c(2,1)
      clinetzz(i5,i6,mu).a(iut,2)=cw1*rz8_756(mu).b(1,2)+cw2*rz8
     & _756(mu).a(2,2)
      clinetzz(i5,i6,mu).b(iut,2)=cz1*rz8_756(mu).b(1,2)+cz2*rz8
     & _756(mu).a(2,2)
      clinetzz(i5,i6,mu).c(iut,2)=cx1*rz8_756(mu).c(1,2)+cx2*rz8
     & _756(mu).d(2,2)
      clinetzz(i5,i6,mu).d(iut,2)=cy1*rz8_756(mu).c(1,2)+cy2*rz8
     & _756(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i5=1,2
      do i6=1,2
      do mu=0,3
* TTs -- aa=clinetzz(i5,i6,mu).a,bb=clinetzz(i5,i6,mu).b,cc=clinetzz(i5,
* i6,mu).c,dd=clinetzz(i5,i6,mu).d,a1=lz7_856(mu).a,b1=lz7_856(mu).b,c1=
* lz7_856(mu).c,d1=lz7_856(mu).d,a2=r8_56(i5,i6).a,b2=r8_56(i5,i6).b,c2=
* r8_56(i5,i6).c,d2=r8_56(i5,i6).d,prq=p856q,m=rmass(id7),nsum=1
      do jut=1,2
      cx1=r8_56(i5,i6).a(1,jut)+rmass(id7)*r8_56(i5,i6).b(1,jut)
      cx2=r8_56(i5,i6).a(2,jut)+rmass(id7)*r8_56(i5,i6).b(2,jut)
      cy1=p856q*r8_56(i5,i6).b(1,jut)+rmass(id7)*r8_56(i5,i6).a(
     & 1,jut)
      cy2=p856q*r8_56(i5,i6).b(2,jut)+rmass(id7)*r8_56(i5,i6).a(
     & 2,jut)
      cw1=r8_56(i5,i6).c(1,jut)+rmass(id7)*r8_56(i5,i6).d(1,jut)
      cw2=r8_56(i5,i6).c(2,jut)+rmass(id7)*r8_56(i5,i6).d(2,jut)
      cz1=p856q*r8_56(i5,i6).d(1,jut)+rmass(id7)*r8_56(i5,i6).c(
     & 1,jut)
      cz2=p856q*r8_56(i5,i6).d(2,jut)+rmass(id7)*r8_56(i5,i6).c(
     & 2,jut)
      clinetzz(i5,i6,mu).a(1,jut)=clinetzz(i5,i6,mu).a(1,jut)+lz
     & 7_856(mu).a(1,1)*cx1+lz7_856(mu).c(1,2)*cy2
      clinetzz(i5,i6,mu).b(1,jut)=clinetzz(i5,i6,mu).b(1,jut)+lz
     & 7_856(mu).d(1,1)*cy1+lz7_856(mu).b(1,2)*cx2
      clinetzz(i5,i6,mu).c(1,jut)=clinetzz(i5,i6,mu).c(1,jut)+lz
     & 7_856(mu).a(1,1)*cw1+lz7_856(mu).c(1,2)*cz2
      clinetzz(i5,i6,mu).d(1,jut)=clinetzz(i5,i6,mu).d(1,jut)+lz
     & 7_856(mu).d(1,1)*cz1+lz7_856(mu).b(1,2)*cw2
      clinetzz(i5,i6,mu).a(2,jut)=clinetzz(i5,i6,mu).a(2,jut)+lz
     & 7_856(mu).c(2,1)*cy1+lz7_856(mu).a(2,2)*cx2
      clinetzz(i5,i6,mu).b(2,jut)=clinetzz(i5,i6,mu).b(2,jut)+lz
     & 7_856(mu).b(2,1)*cx1+lz7_856(mu).d(2,2)*cy2
      clinetzz(i5,i6,mu).c(2,jut)=clinetzz(i5,i6,mu).c(2,jut)+lz
     & 7_856(mu).c(2,1)*cz1+lz7_856(mu).a(2,2)*cw2
      clinetzz(i5,i6,mu).d(2,jut)=clinetzz(i5,i6,mu).d(2,jut)+lz
     & 7_856(mu).b(2,1)*cw1+lz7_856(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id7)
      rmassr=-rmass(id8)
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* mline -- res=cz5678(i1,i2,&1,&2,mu),abcd=clinetzz(i1,i2,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      cz5678(i1,i2,iut,jut,mu)=cz5678(i1,i2,iut,jut,mu)+clinetzz
     & (i1,i2,mu).a(iut,jut)+rmassl*clinetzz(i1,i2,mu).b(iut,jut
     & )+rmassr*clinetzz(i1,i2,mu).c(iut,jut)+rmassl*rmassr*clin
     & etzz(i1,i2,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i5=1,2
      do i6=1,2
      do mu=0,3
* TsT -- aa=clinetzz(i5,i6,mu).a,bb=clinetzz(i5,i6,mu).b,cc=clinetzz(i5,
* i6,mu).c,dd=clinetzz(i5,i6,mu).d,a1=l1_56(i5,i6).a,b1=l1_56(i5,i6).b,c
* 1=l1_56(i5,i6).c,d1=l1_56(i5,i6).d,a2=rz2_156(mu).a,b2=rz2_156(mu).b,c
* 2=rz2_156(mu).c,d2=rz2_156(mu).d,prq=p156q,m=rmass(id1),nsum=0
      do iut=1,2
      cx1=l1_56(i5,i6).a(iut,1)+l1_56(i5,i6).c(iut,1)*rmass(id1)
      cx2=l1_56(i5,i6).c(iut,2)*p156q+l1_56(i5,i6).a(iut,2)*rmas
     & s(id1)
      cy1=l1_56(i5,i6).b(iut,1)+l1_56(i5,i6).d(iut,1)*rmass(id1)
      cy2=l1_56(i5,i6).d(iut,2)*p156q+l1_56(i5,i6).b(iut,2)*rmas
     & s(id1)
      cw1=l1_56(i5,i6).c(iut,1)*p156q+l1_56(i5,i6).a(iut,1)*rmas
     & s(id1)
      cw2=l1_56(i5,i6).a(iut,2)+l1_56(i5,i6).c(iut,2)*rmass(id1)
      cz1=l1_56(i5,i6).d(iut,1)*p156q+l1_56(i5,i6).b(iut,1)*rmas
     & s(id1)
      cz2=l1_56(i5,i6).b(iut,2)+l1_56(i5,i6).d(iut,2)*rmass(id1)
      clinetzz(i5,i6,mu).a(iut,1)=cx1*rz2_156(mu).a(1,1)+cx2*rz2
     & _156(mu).b(2,1)
      clinetzz(i5,i6,mu).b(iut,1)=cy1*rz2_156(mu).a(1,1)+cy2*rz2
     & _156(mu).b(2,1)
      clinetzz(i5,i6,mu).c(iut,1)=cw1*rz2_156(mu).d(1,1)+cw2*rz2
     & _156(mu).c(2,1)
      clinetzz(i5,i6,mu).d(iut,1)=cz1*rz2_156(mu).d(1,1)+cz2*rz2
     & _156(mu).c(2,1)
      clinetzz(i5,i6,mu).a(iut,2)=cw1*rz2_156(mu).b(1,2)+cw2*rz2
     & _156(mu).a(2,2)
      clinetzz(i5,i6,mu).b(iut,2)=cz1*rz2_156(mu).b(1,2)+cz2*rz2
     & _156(mu).a(2,2)
      clinetzz(i5,i6,mu).c(iut,2)=cx1*rz2_156(mu).c(1,2)+cx2*rz2
     & _156(mu).d(2,2)
      clinetzz(i5,i6,mu).d(iut,2)=cy1*rz2_156(mu).c(1,2)+cy2*rz2
     & _156(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i5=1,2
      do i6=1,2
      do mu=0,3
* TTs -- aa=clinetzz(i5,i6,mu).a,bb=clinetzz(i5,i6,mu).b,cc=clinetzz(i5,
* i6,mu).c,dd=clinetzz(i5,i6,mu).d,a1=lz1_256(mu).a,b1=lz1_256(mu).b,c1=
* lz1_256(mu).c,d1=lz1_256(mu).d,a2=r2_56(i5,i6).a,b2=r2_56(i5,i6).b,c2=
* r2_56(i5,i6).c,d2=r2_56(i5,i6).d,prq=p256q,m=rmass(id1),nsum=1
      do jut=1,2
      cx1=r2_56(i5,i6).a(1,jut)+rmass(id1)*r2_56(i5,i6).b(1,jut)
      cx2=r2_56(i5,i6).a(2,jut)+rmass(id1)*r2_56(i5,i6).b(2,jut)
      cy1=p256q*r2_56(i5,i6).b(1,jut)+rmass(id1)*r2_56(i5,i6).a(
     & 1,jut)
      cy2=p256q*r2_56(i5,i6).b(2,jut)+rmass(id1)*r2_56(i5,i6).a(
     & 2,jut)
      cw1=r2_56(i5,i6).c(1,jut)+rmass(id1)*r2_56(i5,i6).d(1,jut)
      cw2=r2_56(i5,i6).c(2,jut)+rmass(id1)*r2_56(i5,i6).d(2,jut)
      cz1=p256q*r2_56(i5,i6).d(1,jut)+rmass(id1)*r2_56(i5,i6).c(
     & 1,jut)
      cz2=p256q*r2_56(i5,i6).d(2,jut)+rmass(id1)*r2_56(i5,i6).c(
     & 2,jut)
      clinetzz(i5,i6,mu).a(1,jut)=clinetzz(i5,i6,mu).a(1,jut)+lz
     & 1_256(mu).a(1,1)*cx1+lz1_256(mu).c(1,2)*cy2
      clinetzz(i5,i6,mu).b(1,jut)=clinetzz(i5,i6,mu).b(1,jut)+lz
     & 1_256(mu).d(1,1)*cy1+lz1_256(mu).b(1,2)*cx2
      clinetzz(i5,i6,mu).c(1,jut)=clinetzz(i5,i6,mu).c(1,jut)+lz
     & 1_256(mu).a(1,1)*cw1+lz1_256(mu).c(1,2)*cz2
      clinetzz(i5,i6,mu).d(1,jut)=clinetzz(i5,i6,mu).d(1,jut)+lz
     & 1_256(mu).d(1,1)*cz1+lz1_256(mu).b(1,2)*cw2
      clinetzz(i5,i6,mu).a(2,jut)=clinetzz(i5,i6,mu).a(2,jut)+lz
     & 1_256(mu).c(2,1)*cy1+lz1_256(mu).a(2,2)*cx2
      clinetzz(i5,i6,mu).b(2,jut)=clinetzz(i5,i6,mu).b(2,jut)+lz
     & 1_256(mu).b(2,1)*cx1+lz1_256(mu).d(2,2)*cy2
      clinetzz(i5,i6,mu).c(2,jut)=clinetzz(i5,i6,mu).c(2,jut)+lz
     & 1_256(mu).c(2,1)*cz1+lz1_256(mu).a(2,2)*cw2
      clinetzz(i5,i6,mu).d(2,jut)=clinetzz(i5,i6,mu).d(2,jut)+lz
     & 1_256(mu).b(2,1)*cw1+lz1_256(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id1)
      rmassr=-rmass(id2)
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* mline -- res=cz1256(&1,&2,i3,i4,mu),abcd=clinetzz(i3,i4,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cz1256(iut,jut,i3,i4,mu)=clinetzz(i3,i4,mu).a(iut,jut)+rma
     & ssl*clinetzz(i3,i4,mu).b(iut,jut)+rmassr*clinetzz(i3,i4,m
     & u).c(iut,jut)+rmassl*rmassr*clinetzz(i3,i4,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* TsT -- aa=clinetzz(i1,i2,mu).a,bb=clinetzz(i1,i2,mu).b,cc=clinetzz(i1,
* i2,mu).c,dd=clinetzz(i1,i2,mu).d,a1=l5_12(i1,i2).a,b1=l5_12(i1,i2).b,c
* 1=l5_12(i1,i2).c,d1=l5_12(i1,i2).d,a2=rz6_512(mu).a,b2=rz6_512(mu).b,c
* 2=rz6_512(mu).c,d2=rz6_512(mu).d,prq=p512q,m=rmass(id5),nsum=0
      do iut=1,2
      cx1=l5_12(i1,i2).a(iut,1)+l5_12(i1,i2).c(iut,1)*rmass(id5)
      cx2=l5_12(i1,i2).c(iut,2)*p512q+l5_12(i1,i2).a(iut,2)*rmas
     & s(id5)
      cy1=l5_12(i1,i2).b(iut,1)+l5_12(i1,i2).d(iut,1)*rmass(id5)
      cy2=l5_12(i1,i2).d(iut,2)*p512q+l5_12(i1,i2).b(iut,2)*rmas
     & s(id5)
      cw1=l5_12(i1,i2).c(iut,1)*p512q+l5_12(i1,i2).a(iut,1)*rmas
     & s(id5)
      cw2=l5_12(i1,i2).a(iut,2)+l5_12(i1,i2).c(iut,2)*rmass(id5)
      cz1=l5_12(i1,i2).d(iut,1)*p512q+l5_12(i1,i2).b(iut,1)*rmas
     & s(id5)
      cz2=l5_12(i1,i2).b(iut,2)+l5_12(i1,i2).d(iut,2)*rmass(id5)
      clinetzz(i1,i2,mu).a(iut,1)=cx1*rz6_512(mu).a(1,1)+cx2*rz6
     & _512(mu).b(2,1)
      clinetzz(i1,i2,mu).b(iut,1)=cy1*rz6_512(mu).a(1,1)+cy2*rz6
     & _512(mu).b(2,1)
      clinetzz(i1,i2,mu).c(iut,1)=cw1*rz6_512(mu).d(1,1)+cw2*rz6
     & _512(mu).c(2,1)
      clinetzz(i1,i2,mu).d(iut,1)=cz1*rz6_512(mu).d(1,1)+cz2*rz6
     & _512(mu).c(2,1)
      clinetzz(i1,i2,mu).a(iut,2)=cw1*rz6_512(mu).b(1,2)+cw2*rz6
     & _512(mu).a(2,2)
      clinetzz(i1,i2,mu).b(iut,2)=cz1*rz6_512(mu).b(1,2)+cz2*rz6
     & _512(mu).a(2,2)
      clinetzz(i1,i2,mu).c(iut,2)=cx1*rz6_512(mu).c(1,2)+cx2*rz6
     & _512(mu).d(2,2)
      clinetzz(i1,i2,mu).d(iut,2)=cy1*rz6_512(mu).c(1,2)+cy2*rz6
     & _512(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* TTs -- aa=clinetzz(i1,i2,mu).a,bb=clinetzz(i1,i2,mu).b,cc=clinetzz(i1,
* i2,mu).c,dd=clinetzz(i1,i2,mu).d,a1=lz5_612(mu).a,b1=lz5_612(mu).b,c1=
* lz5_612(mu).c,d1=lz5_612(mu).d,a2=r6_12(i1,i2).a,b2=r6_12(i1,i2).b,c2=
* r6_12(i1,i2).c,d2=r6_12(i1,i2).d,prq=p612q,m=rmass(id5),nsum=1
      do jut=1,2
      cx1=r6_12(i1,i2).a(1,jut)+rmass(id5)*r6_12(i1,i2).b(1,jut)
      cx2=r6_12(i1,i2).a(2,jut)+rmass(id5)*r6_12(i1,i2).b(2,jut)
      cy1=p612q*r6_12(i1,i2).b(1,jut)+rmass(id5)*r6_12(i1,i2).a(
     & 1,jut)
      cy2=p612q*r6_12(i1,i2).b(2,jut)+rmass(id5)*r6_12(i1,i2).a(
     & 2,jut)
      cw1=r6_12(i1,i2).c(1,jut)+rmass(id5)*r6_12(i1,i2).d(1,jut)
      cw2=r6_12(i1,i2).c(2,jut)+rmass(id5)*r6_12(i1,i2).d(2,jut)
      cz1=p612q*r6_12(i1,i2).d(1,jut)+rmass(id5)*r6_12(i1,i2).c(
     & 1,jut)
      cz2=p612q*r6_12(i1,i2).d(2,jut)+rmass(id5)*r6_12(i1,i2).c(
     & 2,jut)
      clinetzz(i1,i2,mu).a(1,jut)=clinetzz(i1,i2,mu).a(1,jut)+lz
     & 5_612(mu).a(1,1)*cx1+lz5_612(mu).c(1,2)*cy2
      clinetzz(i1,i2,mu).b(1,jut)=clinetzz(i1,i2,mu).b(1,jut)+lz
     & 5_612(mu).d(1,1)*cy1+lz5_612(mu).b(1,2)*cx2
      clinetzz(i1,i2,mu).c(1,jut)=clinetzz(i1,i2,mu).c(1,jut)+lz
     & 5_612(mu).a(1,1)*cw1+lz5_612(mu).c(1,2)*cz2
      clinetzz(i1,i2,mu).d(1,jut)=clinetzz(i1,i2,mu).d(1,jut)+lz
     & 5_612(mu).d(1,1)*cz1+lz5_612(mu).b(1,2)*cw2
      clinetzz(i1,i2,mu).a(2,jut)=clinetzz(i1,i2,mu).a(2,jut)+lz
     & 5_612(mu).c(2,1)*cy1+lz5_612(mu).a(2,2)*cx2
      clinetzz(i1,i2,mu).b(2,jut)=clinetzz(i1,i2,mu).b(2,jut)+lz
     & 5_612(mu).b(2,1)*cx1+lz5_612(mu).d(2,2)*cy2
      clinetzz(i1,i2,mu).c(2,jut)=clinetzz(i1,i2,mu).c(2,jut)+lz
     & 5_612(mu).c(2,1)*cz1+lz5_612(mu).a(2,2)*cw2
      clinetzz(i1,i2,mu).d(2,jut)=clinetzz(i1,i2,mu).d(2,jut)+lz
     & 5_612(mu).b(2,1)*cw1+lz5_612(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id5)
      rmassr=-rmass(id6)
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* mline -- res=cz1256(i1,i2,&1,&2,mu),abcd=clinetzz(i1,i2,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      cz1256(i1,i2,iut,jut,mu)=cz1256(i1,i2,iut,jut,mu)+clinetzz
     & (i1,i2,mu).a(iut,jut)+rmassl*clinetzz(i1,i2,mu).b(iut,jut
     & )+rmassr*clinetzz(i1,i2,mu).c(iut,jut)+rmassl*rmassr*clin
     & etzz(i1,i2,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i7=1,2
      do i8=1,2
      do mu=0,3
* TsT -- aa=clinetzz(i7,i8,mu).a,bb=clinetzz(i7,i8,mu).b,cc=clinetzz(i7,
* i8,mu).c,dd=clinetzz(i7,i8,mu).d,a1=l3_78(i7,i8).a,b1=l3_78(i7,i8).b,c
* 1=l3_78(i7,i8).c,d1=l3_78(i7,i8).d,a2=rz4_378(mu).a,b2=rz4_378(mu).b,c
* 2=rz4_378(mu).c,d2=rz4_378(mu).d,prq=p378q,m=rmass(id3),nsum=0
      do iut=1,2
      cx1=l3_78(i7,i8).a(iut,1)+l3_78(i7,i8).c(iut,1)*rmass(id3)
      cx2=l3_78(i7,i8).c(iut,2)*p378q+l3_78(i7,i8).a(iut,2)*rmas
     & s(id3)
      cy1=l3_78(i7,i8).b(iut,1)+l3_78(i7,i8).d(iut,1)*rmass(id3)
      cy2=l3_78(i7,i8).d(iut,2)*p378q+l3_78(i7,i8).b(iut,2)*rmas
     & s(id3)
      cw1=l3_78(i7,i8).c(iut,1)*p378q+l3_78(i7,i8).a(iut,1)*rmas
     & s(id3)
      cw2=l3_78(i7,i8).a(iut,2)+l3_78(i7,i8).c(iut,2)*rmass(id3)
      cz1=l3_78(i7,i8).d(iut,1)*p378q+l3_78(i7,i8).b(iut,1)*rmas
     & s(id3)
      cz2=l3_78(i7,i8).b(iut,2)+l3_78(i7,i8).d(iut,2)*rmass(id3)
      clinetzz(i7,i8,mu).a(iut,1)=cx1*rz4_378(mu).a(1,1)+cx2*rz4
     & _378(mu).b(2,1)
      clinetzz(i7,i8,mu).b(iut,1)=cy1*rz4_378(mu).a(1,1)+cy2*rz4
     & _378(mu).b(2,1)
      clinetzz(i7,i8,mu).c(iut,1)=cw1*rz4_378(mu).d(1,1)+cw2*rz4
     & _378(mu).c(2,1)
      clinetzz(i7,i8,mu).d(iut,1)=cz1*rz4_378(mu).d(1,1)+cz2*rz4
     & _378(mu).c(2,1)
      clinetzz(i7,i8,mu).a(iut,2)=cw1*rz4_378(mu).b(1,2)+cw2*rz4
     & _378(mu).a(2,2)
      clinetzz(i7,i8,mu).b(iut,2)=cz1*rz4_378(mu).b(1,2)+cz2*rz4
     & _378(mu).a(2,2)
      clinetzz(i7,i8,mu).c(iut,2)=cx1*rz4_378(mu).c(1,2)+cx2*rz4
     & _378(mu).d(2,2)
      clinetzz(i7,i8,mu).d(iut,2)=cy1*rz4_378(mu).c(1,2)+cy2*rz4
     & _378(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i7=1,2
      do i8=1,2
      do mu=0,3
* TTs -- aa=clinetzz(i7,i8,mu).a,bb=clinetzz(i7,i8,mu).b,cc=clinetzz(i7,
* i8,mu).c,dd=clinetzz(i7,i8,mu).d,a1=lz3_478(mu).a,b1=lz3_478(mu).b,c1=
* lz3_478(mu).c,d1=lz3_478(mu).d,a2=r4_78(i7,i8).a,b2=r4_78(i7,i8).b,c2=
* r4_78(i7,i8).c,d2=r4_78(i7,i8).d,prq=p478q,m=rmass(id3),nsum=1
      do jut=1,2
      cx1=r4_78(i7,i8).a(1,jut)+rmass(id3)*r4_78(i7,i8).b(1,jut)
      cx2=r4_78(i7,i8).a(2,jut)+rmass(id3)*r4_78(i7,i8).b(2,jut)
      cy1=p478q*r4_78(i7,i8).b(1,jut)+rmass(id3)*r4_78(i7,i8).a(
     & 1,jut)
      cy2=p478q*r4_78(i7,i8).b(2,jut)+rmass(id3)*r4_78(i7,i8).a(
     & 2,jut)
      cw1=r4_78(i7,i8).c(1,jut)+rmass(id3)*r4_78(i7,i8).d(1,jut)
      cw2=r4_78(i7,i8).c(2,jut)+rmass(id3)*r4_78(i7,i8).d(2,jut)
      cz1=p478q*r4_78(i7,i8).d(1,jut)+rmass(id3)*r4_78(i7,i8).c(
     & 1,jut)
      cz2=p478q*r4_78(i7,i8).d(2,jut)+rmass(id3)*r4_78(i7,i8).c(
     & 2,jut)
      clinetzz(i7,i8,mu).a(1,jut)=clinetzz(i7,i8,mu).a(1,jut)+lz
     & 3_478(mu).a(1,1)*cx1+lz3_478(mu).c(1,2)*cy2
      clinetzz(i7,i8,mu).b(1,jut)=clinetzz(i7,i8,mu).b(1,jut)+lz
     & 3_478(mu).d(1,1)*cy1+lz3_478(mu).b(1,2)*cx2
      clinetzz(i7,i8,mu).c(1,jut)=clinetzz(i7,i8,mu).c(1,jut)+lz
     & 3_478(mu).a(1,1)*cw1+lz3_478(mu).c(1,2)*cz2
      clinetzz(i7,i8,mu).d(1,jut)=clinetzz(i7,i8,mu).d(1,jut)+lz
     & 3_478(mu).d(1,1)*cz1+lz3_478(mu).b(1,2)*cw2
      clinetzz(i7,i8,mu).a(2,jut)=clinetzz(i7,i8,mu).a(2,jut)+lz
     & 3_478(mu).c(2,1)*cy1+lz3_478(mu).a(2,2)*cx2
      clinetzz(i7,i8,mu).b(2,jut)=clinetzz(i7,i8,mu).b(2,jut)+lz
     & 3_478(mu).b(2,1)*cx1+lz3_478(mu).d(2,2)*cy2
      clinetzz(i7,i8,mu).c(2,jut)=clinetzz(i7,i8,mu).c(2,jut)+lz
     & 3_478(mu).c(2,1)*cz1+lz3_478(mu).a(2,2)*cw2
      clinetzz(i7,i8,mu).d(2,jut)=clinetzz(i7,i8,mu).d(2,jut)+lz
     & 3_478(mu).b(2,1)*cw1+lz3_478(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id3)
      rmassr=-rmass(id4)
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* mline -- res=cz3478(&1,&2,i3,i4,mu),abcd=clinetzz(i3,i4,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cz3478(iut,jut,i3,i4,mu)=clinetzz(i3,i4,mu).a(iut,jut)+rma
     & ssl*clinetzz(i3,i4,mu).b(iut,jut)+rmassr*clinetzz(i3,i4,m
     & u).c(iut,jut)+rmassl*rmassr*clinetzz(i3,i4,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* TsT -- aa=clinetzz(i3,i4,mu).a,bb=clinetzz(i3,i4,mu).b,cc=clinetzz(i3,
* i4,mu).c,dd=clinetzz(i3,i4,mu).d,a1=l7_34(i3,i4).a,b1=l7_34(i3,i4).b,c
* 1=l7_34(i3,i4).c,d1=l7_34(i3,i4).d,a2=rz8_734(mu).a,b2=rz8_734(mu).b,c
* 2=rz8_734(mu).c,d2=rz8_734(mu).d,prq=p734q,m=rmass(id7),nsum=0
      do iut=1,2
      cx1=l7_34(i3,i4).a(iut,1)+l7_34(i3,i4).c(iut,1)*rmass(id7)
      cx2=l7_34(i3,i4).c(iut,2)*p734q+l7_34(i3,i4).a(iut,2)*rmas
     & s(id7)
      cy1=l7_34(i3,i4).b(iut,1)+l7_34(i3,i4).d(iut,1)*rmass(id7)
      cy2=l7_34(i3,i4).d(iut,2)*p734q+l7_34(i3,i4).b(iut,2)*rmas
     & s(id7)
      cw1=l7_34(i3,i4).c(iut,1)*p734q+l7_34(i3,i4).a(iut,1)*rmas
     & s(id7)
      cw2=l7_34(i3,i4).a(iut,2)+l7_34(i3,i4).c(iut,2)*rmass(id7)
      cz1=l7_34(i3,i4).d(iut,1)*p734q+l7_34(i3,i4).b(iut,1)*rmas
     & s(id7)
      cz2=l7_34(i3,i4).b(iut,2)+l7_34(i3,i4).d(iut,2)*rmass(id7)
      clinetzz(i3,i4,mu).a(iut,1)=cx1*rz8_734(mu).a(1,1)+cx2*rz8
     & _734(mu).b(2,1)
      clinetzz(i3,i4,mu).b(iut,1)=cy1*rz8_734(mu).a(1,1)+cy2*rz8
     & _734(mu).b(2,1)
      clinetzz(i3,i4,mu).c(iut,1)=cw1*rz8_734(mu).d(1,1)+cw2*rz8
     & _734(mu).c(2,1)
      clinetzz(i3,i4,mu).d(iut,1)=cz1*rz8_734(mu).d(1,1)+cz2*rz8
     & _734(mu).c(2,1)
      clinetzz(i3,i4,mu).a(iut,2)=cw1*rz8_734(mu).b(1,2)+cw2*rz8
     & _734(mu).a(2,2)
      clinetzz(i3,i4,mu).b(iut,2)=cz1*rz8_734(mu).b(1,2)+cz2*rz8
     & _734(mu).a(2,2)
      clinetzz(i3,i4,mu).c(iut,2)=cx1*rz8_734(mu).c(1,2)+cx2*rz8
     & _734(mu).d(2,2)
      clinetzz(i3,i4,mu).d(iut,2)=cy1*rz8_734(mu).c(1,2)+cy2*rz8
     & _734(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* TTs -- aa=clinetzz(i3,i4,mu).a,bb=clinetzz(i3,i4,mu).b,cc=clinetzz(i3,
* i4,mu).c,dd=clinetzz(i3,i4,mu).d,a1=lz7_834(mu).a,b1=lz7_834(mu).b,c1=
* lz7_834(mu).c,d1=lz7_834(mu).d,a2=r8_34(i3,i4).a,b2=r8_34(i3,i4).b,c2=
* r8_34(i3,i4).c,d2=r8_34(i3,i4).d,prq=p834q,m=rmass(id7),nsum=1
      do jut=1,2
      cx1=r8_34(i3,i4).a(1,jut)+rmass(id7)*r8_34(i3,i4).b(1,jut)
      cx2=r8_34(i3,i4).a(2,jut)+rmass(id7)*r8_34(i3,i4).b(2,jut)
      cy1=p834q*r8_34(i3,i4).b(1,jut)+rmass(id7)*r8_34(i3,i4).a(
     & 1,jut)
      cy2=p834q*r8_34(i3,i4).b(2,jut)+rmass(id7)*r8_34(i3,i4).a(
     & 2,jut)
      cw1=r8_34(i3,i4).c(1,jut)+rmass(id7)*r8_34(i3,i4).d(1,jut)
      cw2=r8_34(i3,i4).c(2,jut)+rmass(id7)*r8_34(i3,i4).d(2,jut)
      cz1=p834q*r8_34(i3,i4).d(1,jut)+rmass(id7)*r8_34(i3,i4).c(
     & 1,jut)
      cz2=p834q*r8_34(i3,i4).d(2,jut)+rmass(id7)*r8_34(i3,i4).c(
     & 2,jut)
      clinetzz(i3,i4,mu).a(1,jut)=clinetzz(i3,i4,mu).a(1,jut)+lz
     & 7_834(mu).a(1,1)*cx1+lz7_834(mu).c(1,2)*cy2
      clinetzz(i3,i4,mu).b(1,jut)=clinetzz(i3,i4,mu).b(1,jut)+lz
     & 7_834(mu).d(1,1)*cy1+lz7_834(mu).b(1,2)*cx2
      clinetzz(i3,i4,mu).c(1,jut)=clinetzz(i3,i4,mu).c(1,jut)+lz
     & 7_834(mu).a(1,1)*cw1+lz7_834(mu).c(1,2)*cz2
      clinetzz(i3,i4,mu).d(1,jut)=clinetzz(i3,i4,mu).d(1,jut)+lz
     & 7_834(mu).d(1,1)*cz1+lz7_834(mu).b(1,2)*cw2
      clinetzz(i3,i4,mu).a(2,jut)=clinetzz(i3,i4,mu).a(2,jut)+lz
     & 7_834(mu).c(2,1)*cy1+lz7_834(mu).a(2,2)*cx2
      clinetzz(i3,i4,mu).b(2,jut)=clinetzz(i3,i4,mu).b(2,jut)+lz
     & 7_834(mu).b(2,1)*cx1+lz7_834(mu).d(2,2)*cy2
      clinetzz(i3,i4,mu).c(2,jut)=clinetzz(i3,i4,mu).c(2,jut)+lz
     & 7_834(mu).c(2,1)*cz1+lz7_834(mu).a(2,2)*cw2
      clinetzz(i3,i4,mu).d(2,jut)=clinetzz(i3,i4,mu).d(2,jut)+lz
     & 7_834(mu).b(2,1)*cw1+lz7_834(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id7)
      rmassr=-rmass(id8)
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* mline -- res=cz3478(i1,i2,&1,&2,mu),abcd=clinetzz(i1,i2,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      cz3478(i1,i2,iut,jut,mu)=cz3478(i1,i2,iut,jut,mu)+clinetzz
     & (i1,i2,mu).a(iut,jut)+rmassl*clinetzz(i1,i2,mu).b(iut,jut
     & )+rmassr*clinetzz(i1,i2,mu).c(iut,jut)+rmassl*rmassr*clin
     & etzz(i1,i2,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i7=1,2
      do i8=1,2
      do mu=0,3
* TsT -- aa=clinetzz(i7,i8,mu).a,bb=clinetzz(i7,i8,mu).b,cc=clinetzz(i7,
* i8,mu).c,dd=clinetzz(i7,i8,mu).d,a1=l1_78(i7,i8).a,b1=l1_78(i7,i8).b,c
* 1=l1_78(i7,i8).c,d1=l1_78(i7,i8).d,a2=rz2_178(mu).a,b2=rz2_178(mu).b,c
* 2=rz2_178(mu).c,d2=rz2_178(mu).d,prq=p178q,m=rmass(id1),nsum=0
      do iut=1,2
      cx1=l1_78(i7,i8).a(iut,1)+l1_78(i7,i8).c(iut,1)*rmass(id1)
      cx2=l1_78(i7,i8).c(iut,2)*p178q+l1_78(i7,i8).a(iut,2)*rmas
     & s(id1)
      cy1=l1_78(i7,i8).b(iut,1)+l1_78(i7,i8).d(iut,1)*rmass(id1)
      cy2=l1_78(i7,i8).d(iut,2)*p178q+l1_78(i7,i8).b(iut,2)*rmas
     & s(id1)
      cw1=l1_78(i7,i8).c(iut,1)*p178q+l1_78(i7,i8).a(iut,1)*rmas
     & s(id1)
      cw2=l1_78(i7,i8).a(iut,2)+l1_78(i7,i8).c(iut,2)*rmass(id1)
      cz1=l1_78(i7,i8).d(iut,1)*p178q+l1_78(i7,i8).b(iut,1)*rmas
     & s(id1)
      cz2=l1_78(i7,i8).b(iut,2)+l1_78(i7,i8).d(iut,2)*rmass(id1)
      clinetzz(i7,i8,mu).a(iut,1)=cx1*rz2_178(mu).a(1,1)+cx2*rz2
     & _178(mu).b(2,1)
      clinetzz(i7,i8,mu).b(iut,1)=cy1*rz2_178(mu).a(1,1)+cy2*rz2
     & _178(mu).b(2,1)
      clinetzz(i7,i8,mu).c(iut,1)=cw1*rz2_178(mu).d(1,1)+cw2*rz2
     & _178(mu).c(2,1)
      clinetzz(i7,i8,mu).d(iut,1)=cz1*rz2_178(mu).d(1,1)+cz2*rz2
     & _178(mu).c(2,1)
      clinetzz(i7,i8,mu).a(iut,2)=cw1*rz2_178(mu).b(1,2)+cw2*rz2
     & _178(mu).a(2,2)
      clinetzz(i7,i8,mu).b(iut,2)=cz1*rz2_178(mu).b(1,2)+cz2*rz2
     & _178(mu).a(2,2)
      clinetzz(i7,i8,mu).c(iut,2)=cx1*rz2_178(mu).c(1,2)+cx2*rz2
     & _178(mu).d(2,2)
      clinetzz(i7,i8,mu).d(iut,2)=cy1*rz2_178(mu).c(1,2)+cy2*rz2
     & _178(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i7=1,2
      do i8=1,2
      do mu=0,3
* TTs -- aa=clinetzz(i7,i8,mu).a,bb=clinetzz(i7,i8,mu).b,cc=clinetzz(i7,
* i8,mu).c,dd=clinetzz(i7,i8,mu).d,a1=lz1_278(mu).a,b1=lz1_278(mu).b,c1=
* lz1_278(mu).c,d1=lz1_278(mu).d,a2=r2_78(i7,i8).a,b2=r2_78(i7,i8).b,c2=
* r2_78(i7,i8).c,d2=r2_78(i7,i8).d,prq=p278q,m=rmass(id1),nsum=1
      do jut=1,2
      cx1=r2_78(i7,i8).a(1,jut)+rmass(id1)*r2_78(i7,i8).b(1,jut)
      cx2=r2_78(i7,i8).a(2,jut)+rmass(id1)*r2_78(i7,i8).b(2,jut)
      cy1=p278q*r2_78(i7,i8).b(1,jut)+rmass(id1)*r2_78(i7,i8).a(
     & 1,jut)
      cy2=p278q*r2_78(i7,i8).b(2,jut)+rmass(id1)*r2_78(i7,i8).a(
     & 2,jut)
      cw1=r2_78(i7,i8).c(1,jut)+rmass(id1)*r2_78(i7,i8).d(1,jut)
      cw2=r2_78(i7,i8).c(2,jut)+rmass(id1)*r2_78(i7,i8).d(2,jut)
      cz1=p278q*r2_78(i7,i8).d(1,jut)+rmass(id1)*r2_78(i7,i8).c(
     & 1,jut)
      cz2=p278q*r2_78(i7,i8).d(2,jut)+rmass(id1)*r2_78(i7,i8).c(
     & 2,jut)
      clinetzz(i7,i8,mu).a(1,jut)=clinetzz(i7,i8,mu).a(1,jut)+lz
     & 1_278(mu).a(1,1)*cx1+lz1_278(mu).c(1,2)*cy2
      clinetzz(i7,i8,mu).b(1,jut)=clinetzz(i7,i8,mu).b(1,jut)+lz
     & 1_278(mu).d(1,1)*cy1+lz1_278(mu).b(1,2)*cx2
      clinetzz(i7,i8,mu).c(1,jut)=clinetzz(i7,i8,mu).c(1,jut)+lz
     & 1_278(mu).a(1,1)*cw1+lz1_278(mu).c(1,2)*cz2
      clinetzz(i7,i8,mu).d(1,jut)=clinetzz(i7,i8,mu).d(1,jut)+lz
     & 1_278(mu).d(1,1)*cz1+lz1_278(mu).b(1,2)*cw2
      clinetzz(i7,i8,mu).a(2,jut)=clinetzz(i7,i8,mu).a(2,jut)+lz
     & 1_278(mu).c(2,1)*cy1+lz1_278(mu).a(2,2)*cx2
      clinetzz(i7,i8,mu).b(2,jut)=clinetzz(i7,i8,mu).b(2,jut)+lz
     & 1_278(mu).b(2,1)*cx1+lz1_278(mu).d(2,2)*cy2
      clinetzz(i7,i8,mu).c(2,jut)=clinetzz(i7,i8,mu).c(2,jut)+lz
     & 1_278(mu).c(2,1)*cz1+lz1_278(mu).a(2,2)*cw2
      clinetzz(i7,i8,mu).d(2,jut)=clinetzz(i7,i8,mu).d(2,jut)+lz
     & 1_278(mu).b(2,1)*cw1+lz1_278(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id1)
      rmassr=-rmass(id2)
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* mline -- res=cz1278(&1,&2,i3,i4,mu),abcd=clinetzz(i3,i4,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cz1278(iut,jut,i3,i4,mu)=clinetzz(i3,i4,mu).a(iut,jut)+rma
     & ssl*clinetzz(i3,i4,mu).b(iut,jut)+rmassr*clinetzz(i3,i4,m
     & u).c(iut,jut)+rmassl*rmassr*clinetzz(i3,i4,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* TsT -- aa=clinetzz(i1,i2,mu).a,bb=clinetzz(i1,i2,mu).b,cc=clinetzz(i1,
* i2,mu).c,dd=clinetzz(i1,i2,mu).d,a1=l7_12(i1,i2).a,b1=l7_12(i1,i2).b,c
* 1=l7_12(i1,i2).c,d1=l7_12(i1,i2).d,a2=rz8_712(mu).a,b2=rz8_712(mu).b,c
* 2=rz8_712(mu).c,d2=rz8_712(mu).d,prq=p712q,m=rmass(id7),nsum=0
      do iut=1,2
      cx1=l7_12(i1,i2).a(iut,1)+l7_12(i1,i2).c(iut,1)*rmass(id7)
      cx2=l7_12(i1,i2).c(iut,2)*p712q+l7_12(i1,i2).a(iut,2)*rmas
     & s(id7)
      cy1=l7_12(i1,i2).b(iut,1)+l7_12(i1,i2).d(iut,1)*rmass(id7)
      cy2=l7_12(i1,i2).d(iut,2)*p712q+l7_12(i1,i2).b(iut,2)*rmas
     & s(id7)
      cw1=l7_12(i1,i2).c(iut,1)*p712q+l7_12(i1,i2).a(iut,1)*rmas
     & s(id7)
      cw2=l7_12(i1,i2).a(iut,2)+l7_12(i1,i2).c(iut,2)*rmass(id7)
      cz1=l7_12(i1,i2).d(iut,1)*p712q+l7_12(i1,i2).b(iut,1)*rmas
     & s(id7)
      cz2=l7_12(i1,i2).b(iut,2)+l7_12(i1,i2).d(iut,2)*rmass(id7)
      clinetzz(i1,i2,mu).a(iut,1)=cx1*rz8_712(mu).a(1,1)+cx2*rz8
     & _712(mu).b(2,1)
      clinetzz(i1,i2,mu).b(iut,1)=cy1*rz8_712(mu).a(1,1)+cy2*rz8
     & _712(mu).b(2,1)
      clinetzz(i1,i2,mu).c(iut,1)=cw1*rz8_712(mu).d(1,1)+cw2*rz8
     & _712(mu).c(2,1)
      clinetzz(i1,i2,mu).d(iut,1)=cz1*rz8_712(mu).d(1,1)+cz2*rz8
     & _712(mu).c(2,1)
      clinetzz(i1,i2,mu).a(iut,2)=cw1*rz8_712(mu).b(1,2)+cw2*rz8
     & _712(mu).a(2,2)
      clinetzz(i1,i2,mu).b(iut,2)=cz1*rz8_712(mu).b(1,2)+cz2*rz8
     & _712(mu).a(2,2)
      clinetzz(i1,i2,mu).c(iut,2)=cx1*rz8_712(mu).c(1,2)+cx2*rz8
     & _712(mu).d(2,2)
      clinetzz(i1,i2,mu).d(iut,2)=cy1*rz8_712(mu).c(1,2)+cy2*rz8
     & _712(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* TTs -- aa=clinetzz(i1,i2,mu).a,bb=clinetzz(i1,i2,mu).b,cc=clinetzz(i1,
* i2,mu).c,dd=clinetzz(i1,i2,mu).d,a1=lz7_812(mu).a,b1=lz7_812(mu).b,c1=
* lz7_812(mu).c,d1=lz7_812(mu).d,a2=r8_12(i1,i2).a,b2=r8_12(i1,i2).b,c2=
* r8_12(i1,i2).c,d2=r8_12(i1,i2).d,prq=p812q,m=rmass(id7),nsum=1
      do jut=1,2
      cx1=r8_12(i1,i2).a(1,jut)+rmass(id7)*r8_12(i1,i2).b(1,jut)
      cx2=r8_12(i1,i2).a(2,jut)+rmass(id7)*r8_12(i1,i2).b(2,jut)
      cy1=p812q*r8_12(i1,i2).b(1,jut)+rmass(id7)*r8_12(i1,i2).a(
     & 1,jut)
      cy2=p812q*r8_12(i1,i2).b(2,jut)+rmass(id7)*r8_12(i1,i2).a(
     & 2,jut)
      cw1=r8_12(i1,i2).c(1,jut)+rmass(id7)*r8_12(i1,i2).d(1,jut)
      cw2=r8_12(i1,i2).c(2,jut)+rmass(id7)*r8_12(i1,i2).d(2,jut)
      cz1=p812q*r8_12(i1,i2).d(1,jut)+rmass(id7)*r8_12(i1,i2).c(
     & 1,jut)
      cz2=p812q*r8_12(i1,i2).d(2,jut)+rmass(id7)*r8_12(i1,i2).c(
     & 2,jut)
      clinetzz(i1,i2,mu).a(1,jut)=clinetzz(i1,i2,mu).a(1,jut)+lz
     & 7_812(mu).a(1,1)*cx1+lz7_812(mu).c(1,2)*cy2
      clinetzz(i1,i2,mu).b(1,jut)=clinetzz(i1,i2,mu).b(1,jut)+lz
     & 7_812(mu).d(1,1)*cy1+lz7_812(mu).b(1,2)*cx2
      clinetzz(i1,i2,mu).c(1,jut)=clinetzz(i1,i2,mu).c(1,jut)+lz
     & 7_812(mu).a(1,1)*cw1+lz7_812(mu).c(1,2)*cz2
      clinetzz(i1,i2,mu).d(1,jut)=clinetzz(i1,i2,mu).d(1,jut)+lz
     & 7_812(mu).d(1,1)*cz1+lz7_812(mu).b(1,2)*cw2
      clinetzz(i1,i2,mu).a(2,jut)=clinetzz(i1,i2,mu).a(2,jut)+lz
     & 7_812(mu).c(2,1)*cy1+lz7_812(mu).a(2,2)*cx2
      clinetzz(i1,i2,mu).b(2,jut)=clinetzz(i1,i2,mu).b(2,jut)+lz
     & 7_812(mu).b(2,1)*cx1+lz7_812(mu).d(2,2)*cy2
      clinetzz(i1,i2,mu).c(2,jut)=clinetzz(i1,i2,mu).c(2,jut)+lz
     & 7_812(mu).c(2,1)*cz1+lz7_812(mu).a(2,2)*cw2
      clinetzz(i1,i2,mu).d(2,jut)=clinetzz(i1,i2,mu).d(2,jut)+lz
     & 7_812(mu).b(2,1)*cw1+lz7_812(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id7)
      rmassr=-rmass(id8)
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* mline -- res=cz1278(i1,i2,&1,&2,mu),abcd=clinetzz(i1,i2,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      cz1278(i1,i2,iut,jut,mu)=cz1278(i1,i2,iut,jut,mu)+clinetzz
     & (i1,i2,mu).a(iut,jut)+rmassl*clinetzz(i1,i2,mu).b(iut,jut
     & )+rmassr*clinetzz(i1,i2,mu).c(iut,jut)+rmassl*rmassr*clin
     & etzz(i1,i2,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i5=1,2
      do i6=1,2
      do mu=0,3
* TsT -- aa=clinetzz(i5,i6,mu).a,bb=clinetzz(i5,i6,mu).b,cc=clinetzz(i5,
* i6,mu).c,dd=clinetzz(i5,i6,mu).d,a1=l3_56(i5,i6).a,b1=l3_56(i5,i6).b,c
* 1=l3_56(i5,i6).c,d1=l3_56(i5,i6).d,a2=rz4_356(mu).a,b2=rz4_356(mu).b,c
* 2=rz4_356(mu).c,d2=rz4_356(mu).d,prq=p356q,m=rmass(id3),nsum=0
      do iut=1,2
      cx1=l3_56(i5,i6).a(iut,1)+l3_56(i5,i6).c(iut,1)*rmass(id3)
      cx2=l3_56(i5,i6).c(iut,2)*p356q+l3_56(i5,i6).a(iut,2)*rmas
     & s(id3)
      cy1=l3_56(i5,i6).b(iut,1)+l3_56(i5,i6).d(iut,1)*rmass(id3)
      cy2=l3_56(i5,i6).d(iut,2)*p356q+l3_56(i5,i6).b(iut,2)*rmas
     & s(id3)
      cw1=l3_56(i5,i6).c(iut,1)*p356q+l3_56(i5,i6).a(iut,1)*rmas
     & s(id3)
      cw2=l3_56(i5,i6).a(iut,2)+l3_56(i5,i6).c(iut,2)*rmass(id3)
      cz1=l3_56(i5,i6).d(iut,1)*p356q+l3_56(i5,i6).b(iut,1)*rmas
     & s(id3)
      cz2=l3_56(i5,i6).b(iut,2)+l3_56(i5,i6).d(iut,2)*rmass(id3)
      clinetzz(i5,i6,mu).a(iut,1)=cx1*rz4_356(mu).a(1,1)+cx2*rz4
     & _356(mu).b(2,1)
      clinetzz(i5,i6,mu).b(iut,1)=cy1*rz4_356(mu).a(1,1)+cy2*rz4
     & _356(mu).b(2,1)
      clinetzz(i5,i6,mu).c(iut,1)=cw1*rz4_356(mu).d(1,1)+cw2*rz4
     & _356(mu).c(2,1)
      clinetzz(i5,i6,mu).d(iut,1)=cz1*rz4_356(mu).d(1,1)+cz2*rz4
     & _356(mu).c(2,1)
      clinetzz(i5,i6,mu).a(iut,2)=cw1*rz4_356(mu).b(1,2)+cw2*rz4
     & _356(mu).a(2,2)
      clinetzz(i5,i6,mu).b(iut,2)=cz1*rz4_356(mu).b(1,2)+cz2*rz4
     & _356(mu).a(2,2)
      clinetzz(i5,i6,mu).c(iut,2)=cx1*rz4_356(mu).c(1,2)+cx2*rz4
     & _356(mu).d(2,2)
      clinetzz(i5,i6,mu).d(iut,2)=cy1*rz4_356(mu).c(1,2)+cy2*rz4
     & _356(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i5=1,2
      do i6=1,2
      do mu=0,3
* TTs -- aa=clinetzz(i5,i6,mu).a,bb=clinetzz(i5,i6,mu).b,cc=clinetzz(i5,
* i6,mu).c,dd=clinetzz(i5,i6,mu).d,a1=lz3_456(mu).a,b1=lz3_456(mu).b,c1=
* lz3_456(mu).c,d1=lz3_456(mu).d,a2=r4_56(i5,i6).a,b2=r4_56(i5,i6).b,c2=
* r4_56(i5,i6).c,d2=r4_56(i5,i6).d,prq=p456q,m=rmass(id3),nsum=1
      do jut=1,2
      cx1=r4_56(i5,i6).a(1,jut)+rmass(id3)*r4_56(i5,i6).b(1,jut)
      cx2=r4_56(i5,i6).a(2,jut)+rmass(id3)*r4_56(i5,i6).b(2,jut)
      cy1=p456q*r4_56(i5,i6).b(1,jut)+rmass(id3)*r4_56(i5,i6).a(
     & 1,jut)
      cy2=p456q*r4_56(i5,i6).b(2,jut)+rmass(id3)*r4_56(i5,i6).a(
     & 2,jut)
      cw1=r4_56(i5,i6).c(1,jut)+rmass(id3)*r4_56(i5,i6).d(1,jut)
      cw2=r4_56(i5,i6).c(2,jut)+rmass(id3)*r4_56(i5,i6).d(2,jut)
      cz1=p456q*r4_56(i5,i6).d(1,jut)+rmass(id3)*r4_56(i5,i6).c(
     & 1,jut)
      cz2=p456q*r4_56(i5,i6).d(2,jut)+rmass(id3)*r4_56(i5,i6).c(
     & 2,jut)
      clinetzz(i5,i6,mu).a(1,jut)=clinetzz(i5,i6,mu).a(1,jut)+lz
     & 3_456(mu).a(1,1)*cx1+lz3_456(mu).c(1,2)*cy2
      clinetzz(i5,i6,mu).b(1,jut)=clinetzz(i5,i6,mu).b(1,jut)+lz
     & 3_456(mu).d(1,1)*cy1+lz3_456(mu).b(1,2)*cx2
      clinetzz(i5,i6,mu).c(1,jut)=clinetzz(i5,i6,mu).c(1,jut)+lz
     & 3_456(mu).a(1,1)*cw1+lz3_456(mu).c(1,2)*cz2
      clinetzz(i5,i6,mu).d(1,jut)=clinetzz(i5,i6,mu).d(1,jut)+lz
     & 3_456(mu).d(1,1)*cz1+lz3_456(mu).b(1,2)*cw2
      clinetzz(i5,i6,mu).a(2,jut)=clinetzz(i5,i6,mu).a(2,jut)+lz
     & 3_456(mu).c(2,1)*cy1+lz3_456(mu).a(2,2)*cx2
      clinetzz(i5,i6,mu).b(2,jut)=clinetzz(i5,i6,mu).b(2,jut)+lz
     & 3_456(mu).b(2,1)*cx1+lz3_456(mu).d(2,2)*cy2
      clinetzz(i5,i6,mu).c(2,jut)=clinetzz(i5,i6,mu).c(2,jut)+lz
     & 3_456(mu).c(2,1)*cz1+lz3_456(mu).a(2,2)*cw2
      clinetzz(i5,i6,mu).d(2,jut)=clinetzz(i5,i6,mu).d(2,jut)+lz
     & 3_456(mu).b(2,1)*cw1+lz3_456(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id3)
      rmassr=-rmass(id4)
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* mline -- res=cz3456(&1,&2,i3,i4,mu),abcd=clinetzz(i3,i4,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cz3456(iut,jut,i3,i4,mu)=clinetzz(i3,i4,mu).a(iut,jut)+rma
     & ssl*clinetzz(i3,i4,mu).b(iut,jut)+rmassr*clinetzz(i3,i4,m
     & u).c(iut,jut)+rmassl*rmassr*clinetzz(i3,i4,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* TsT -- aa=clinetzz(i3,i4,mu).a,bb=clinetzz(i3,i4,mu).b,cc=clinetzz(i3,
* i4,mu).c,dd=clinetzz(i3,i4,mu).d,a1=l5_34(i3,i4).a,b1=l5_34(i3,i4).b,c
* 1=l5_34(i3,i4).c,d1=l5_34(i3,i4).d,a2=rz6_534(mu).a,b2=rz6_534(mu).b,c
* 2=rz6_534(mu).c,d2=rz6_534(mu).d,prq=p534q,m=rmass(id5),nsum=0
      do iut=1,2
      cx1=l5_34(i3,i4).a(iut,1)+l5_34(i3,i4).c(iut,1)*rmass(id5)
      cx2=l5_34(i3,i4).c(iut,2)*p534q+l5_34(i3,i4).a(iut,2)*rmas
     & s(id5)
      cy1=l5_34(i3,i4).b(iut,1)+l5_34(i3,i4).d(iut,1)*rmass(id5)
      cy2=l5_34(i3,i4).d(iut,2)*p534q+l5_34(i3,i4).b(iut,2)*rmas
     & s(id5)
      cw1=l5_34(i3,i4).c(iut,1)*p534q+l5_34(i3,i4).a(iut,1)*rmas
     & s(id5)
      cw2=l5_34(i3,i4).a(iut,2)+l5_34(i3,i4).c(iut,2)*rmass(id5)
      cz1=l5_34(i3,i4).d(iut,1)*p534q+l5_34(i3,i4).b(iut,1)*rmas
     & s(id5)
      cz2=l5_34(i3,i4).b(iut,2)+l5_34(i3,i4).d(iut,2)*rmass(id5)
      clinetzz(i3,i4,mu).a(iut,1)=cx1*rz6_534(mu).a(1,1)+cx2*rz6
     & _534(mu).b(2,1)
      clinetzz(i3,i4,mu).b(iut,1)=cy1*rz6_534(mu).a(1,1)+cy2*rz6
     & _534(mu).b(2,1)
      clinetzz(i3,i4,mu).c(iut,1)=cw1*rz6_534(mu).d(1,1)+cw2*rz6
     & _534(mu).c(2,1)
      clinetzz(i3,i4,mu).d(iut,1)=cz1*rz6_534(mu).d(1,1)+cz2*rz6
     & _534(mu).c(2,1)
      clinetzz(i3,i4,mu).a(iut,2)=cw1*rz6_534(mu).b(1,2)+cw2*rz6
     & _534(mu).a(2,2)
      clinetzz(i3,i4,mu).b(iut,2)=cz1*rz6_534(mu).b(1,2)+cz2*rz6
     & _534(mu).a(2,2)
      clinetzz(i3,i4,mu).c(iut,2)=cx1*rz6_534(mu).c(1,2)+cx2*rz6
     & _534(mu).d(2,2)
      clinetzz(i3,i4,mu).d(iut,2)=cy1*rz6_534(mu).c(1,2)+cy2*rz6
     & _534(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* TTs -- aa=clinetzz(i3,i4,mu).a,bb=clinetzz(i3,i4,mu).b,cc=clinetzz(i3,
* i4,mu).c,dd=clinetzz(i3,i4,mu).d,a1=lz5_634(mu).a,b1=lz5_634(mu).b,c1=
* lz5_634(mu).c,d1=lz5_634(mu).d,a2=r6_34(i3,i4).a,b2=r6_34(i3,i4).b,c2=
* r6_34(i3,i4).c,d2=r6_34(i3,i4).d,prq=p634q,m=rmass(id5),nsum=1
      do jut=1,2
      cx1=r6_34(i3,i4).a(1,jut)+rmass(id5)*r6_34(i3,i4).b(1,jut)
      cx2=r6_34(i3,i4).a(2,jut)+rmass(id5)*r6_34(i3,i4).b(2,jut)
      cy1=p634q*r6_34(i3,i4).b(1,jut)+rmass(id5)*r6_34(i3,i4).a(
     & 1,jut)
      cy2=p634q*r6_34(i3,i4).b(2,jut)+rmass(id5)*r6_34(i3,i4).a(
     & 2,jut)
      cw1=r6_34(i3,i4).c(1,jut)+rmass(id5)*r6_34(i3,i4).d(1,jut)
      cw2=r6_34(i3,i4).c(2,jut)+rmass(id5)*r6_34(i3,i4).d(2,jut)
      cz1=p634q*r6_34(i3,i4).d(1,jut)+rmass(id5)*r6_34(i3,i4).c(
     & 1,jut)
      cz2=p634q*r6_34(i3,i4).d(2,jut)+rmass(id5)*r6_34(i3,i4).c(
     & 2,jut)
      clinetzz(i3,i4,mu).a(1,jut)=clinetzz(i3,i4,mu).a(1,jut)+lz
     & 5_634(mu).a(1,1)*cx1+lz5_634(mu).c(1,2)*cy2
      clinetzz(i3,i4,mu).b(1,jut)=clinetzz(i3,i4,mu).b(1,jut)+lz
     & 5_634(mu).d(1,1)*cy1+lz5_634(mu).b(1,2)*cx2
      clinetzz(i3,i4,mu).c(1,jut)=clinetzz(i3,i4,mu).c(1,jut)+lz
     & 5_634(mu).a(1,1)*cw1+lz5_634(mu).c(1,2)*cz2
      clinetzz(i3,i4,mu).d(1,jut)=clinetzz(i3,i4,mu).d(1,jut)+lz
     & 5_634(mu).d(1,1)*cz1+lz5_634(mu).b(1,2)*cw2
      clinetzz(i3,i4,mu).a(2,jut)=clinetzz(i3,i4,mu).a(2,jut)+lz
     & 5_634(mu).c(2,1)*cy1+lz5_634(mu).a(2,2)*cx2
      clinetzz(i3,i4,mu).b(2,jut)=clinetzz(i3,i4,mu).b(2,jut)+lz
     & 5_634(mu).b(2,1)*cx1+lz5_634(mu).d(2,2)*cy2
      clinetzz(i3,i4,mu).c(2,jut)=clinetzz(i3,i4,mu).c(2,jut)+lz
     & 5_634(mu).c(2,1)*cz1+lz5_634(mu).a(2,2)*cw2
      clinetzz(i3,i4,mu).d(2,jut)=clinetzz(i3,i4,mu).d(2,jut)+lz
     & 5_634(mu).b(2,1)*cw1+lz5_634(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id5)
      rmassr=-rmass(id6)
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* mline -- res=cz3456(i1,i2,&1,&2,mu),abcd=clinetzz(i1,i2,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      cz3456(i1,i2,iut,jut,mu)=cz3456(i1,i2,iut,jut,mu)+clinetzz
     & (i1,i2,mu).a(iut,jut)+rmassl*clinetzz(i1,i2,mu).b(iut,jut
     & )+rmassr*clinetzz(i1,i2,mu).c(iut,jut)+rmassl*rmassr*clin
     & etzz(i1,i2,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* TsT -- aa=clinetfz(i3,i4,mu).a,bb=clinetfz(i3,i4,mu).b,cc=clinetfz(i3,
* i4,mu).c,dd=clinetfz(i3,i4,mu).d,a1=l1_34(i3,i4).a,b1=l1_34(i3,i4).b,c
* 1=l1_34(i3,i4).c,d1=l1_34(i3,i4).d,a2=rf2_134(mu).a,b2=rf2_134(mu).b,c
* 2=rf2_134(mu).c,d2=rf2_134(mu).d,prq=p134q,m=rmass(id1),nsum=0
      do iut=1,2
      cx1=l1_34(i3,i4).a(iut,1)+l1_34(i3,i4).c(iut,1)*rmass(id1)
      cx2=l1_34(i3,i4).c(iut,2)*p134q+l1_34(i3,i4).a(iut,2)*rmas
     & s(id1)
      cy1=l1_34(i3,i4).b(iut,1)+l1_34(i3,i4).d(iut,1)*rmass(id1)
      cy2=l1_34(i3,i4).d(iut,2)*p134q+l1_34(i3,i4).b(iut,2)*rmas
     & s(id1)
      cw1=l1_34(i3,i4).c(iut,1)*p134q+l1_34(i3,i4).a(iut,1)*rmas
     & s(id1)
      cw2=l1_34(i3,i4).a(iut,2)+l1_34(i3,i4).c(iut,2)*rmass(id1)
      cz1=l1_34(i3,i4).d(iut,1)*p134q+l1_34(i3,i4).b(iut,1)*rmas
     & s(id1)
      cz2=l1_34(i3,i4).b(iut,2)+l1_34(i3,i4).d(iut,2)*rmass(id1)
      clinetfz(i3,i4,mu).a(iut,1)=cx1*rf2_134(mu).a(1,1)+cx2*rf2
     & _134(mu).b(2,1)
      clinetfz(i3,i4,mu).b(iut,1)=cy1*rf2_134(mu).a(1,1)+cy2*rf2
     & _134(mu).b(2,1)
      clinetfz(i3,i4,mu).c(iut,1)=cw1*rf2_134(mu).d(1,1)+cw2*rf2
     & _134(mu).c(2,1)
      clinetfz(i3,i4,mu).d(iut,1)=cz1*rf2_134(mu).d(1,1)+cz2*rf2
     & _134(mu).c(2,1)
      clinetfz(i3,i4,mu).a(iut,2)=cw1*rf2_134(mu).b(1,2)+cw2*rf2
     & _134(mu).a(2,2)
      clinetfz(i3,i4,mu).b(iut,2)=cz1*rf2_134(mu).b(1,2)+cz2*rf2
     & _134(mu).a(2,2)
      clinetfz(i3,i4,mu).c(iut,2)=cx1*rf2_134(mu).c(1,2)+cx2*rf2
     & _134(mu).d(2,2)
      clinetfz(i3,i4,mu).d(iut,2)=cy1*rf2_134(mu).c(1,2)+cy2*rf2
     & _134(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* TTs -- aa=clinetfz(i3,i4,mu).a,bb=clinetfz(i3,i4,mu).b,cc=clinetfz(i3,
* i4,mu).c,dd=clinetfz(i3,i4,mu).d,a1=lf1_234(mu).a,b1=lf1_234(mu).b,c1=
* lf1_234(mu).c,d1=lf1_234(mu).d,a2=r2_34(i3,i4).a,b2=r2_34(i3,i4).b,c2=
* r2_34(i3,i4).c,d2=r2_34(i3,i4).d,prq=p234q,m=rmass(id1),nsum=1
      do jut=1,2
      cx1=r2_34(i3,i4).a(1,jut)+rmass(id1)*r2_34(i3,i4).b(1,jut)
      cx2=r2_34(i3,i4).a(2,jut)+rmass(id1)*r2_34(i3,i4).b(2,jut)
      cy1=p234q*r2_34(i3,i4).b(1,jut)+rmass(id1)*r2_34(i3,i4).a(
     & 1,jut)
      cy2=p234q*r2_34(i3,i4).b(2,jut)+rmass(id1)*r2_34(i3,i4).a(
     & 2,jut)
      cw1=r2_34(i3,i4).c(1,jut)+rmass(id1)*r2_34(i3,i4).d(1,jut)
      cw2=r2_34(i3,i4).c(2,jut)+rmass(id1)*r2_34(i3,i4).d(2,jut)
      cz1=p234q*r2_34(i3,i4).d(1,jut)+rmass(id1)*r2_34(i3,i4).c(
     & 1,jut)
      cz2=p234q*r2_34(i3,i4).d(2,jut)+rmass(id1)*r2_34(i3,i4).c(
     & 2,jut)
      clinetfz(i3,i4,mu).a(1,jut)=clinetfz(i3,i4,mu).a(1,jut)+lf
     & 1_234(mu).a(1,1)*cx1+lf1_234(mu).c(1,2)*cy2
      clinetfz(i3,i4,mu).b(1,jut)=clinetfz(i3,i4,mu).b(1,jut)+lf
     & 1_234(mu).d(1,1)*cy1+lf1_234(mu).b(1,2)*cx2
      clinetfz(i3,i4,mu).c(1,jut)=clinetfz(i3,i4,mu).c(1,jut)+lf
     & 1_234(mu).a(1,1)*cw1+lf1_234(mu).c(1,2)*cz2
      clinetfz(i3,i4,mu).d(1,jut)=clinetfz(i3,i4,mu).d(1,jut)+lf
     & 1_234(mu).d(1,1)*cz1+lf1_234(mu).b(1,2)*cw2
      clinetfz(i3,i4,mu).a(2,jut)=clinetfz(i3,i4,mu).a(2,jut)+lf
     & 1_234(mu).c(2,1)*cy1+lf1_234(mu).a(2,2)*cx2
      clinetfz(i3,i4,mu).b(2,jut)=clinetfz(i3,i4,mu).b(2,jut)+lf
     & 1_234(mu).b(2,1)*cx1+lf1_234(mu).d(2,2)*cy2
      clinetfz(i3,i4,mu).c(2,jut)=clinetfz(i3,i4,mu).c(2,jut)+lf
     & 1_234(mu).c(2,1)*cz1+lf1_234(mu).a(2,2)*cw2
      clinetfz(i3,i4,mu).d(2,jut)=clinetfz(i3,i4,mu).d(2,jut)+lf
     & 1_234(mu).b(2,1)*cw1+lf1_234(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id1)
      rmassr=-rmass(id2)
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* mline -- res=cf1234(&1,&2,i3,i4,mu),abcd=clinetfz(i3,i4,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cf1234(iut,jut,i3,i4,mu)=clinetfz(i3,i4,mu).a(iut,jut)+rma
     & ssl*clinetfz(i3,i4,mu).b(iut,jut)+rmassr*clinetfz(i3,i4,m
     & u).c(iut,jut)+rmassl*rmassr*clinetfz(i3,i4,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* TsT -- aa=clinetfz(i1,i2,mu).a,bb=clinetfz(i1,i2,mu).b,cc=clinetfz(i1,
* i2,mu).c,dd=clinetfz(i1,i2,mu).d,a1=l3_12(i1,i2).a,b1=l3_12(i1,i2).b,c
* 1=l3_12(i1,i2).c,d1=l3_12(i1,i2).d,a2=rf4_312(mu).a,b2=rf4_312(mu).b,c
* 2=rf4_312(mu).c,d2=rf4_312(mu).d,prq=p312q,m=rmass(id3),nsum=0
      do iut=1,2
      cx1=l3_12(i1,i2).a(iut,1)+l3_12(i1,i2).c(iut,1)*rmass(id3)
      cx2=l3_12(i1,i2).c(iut,2)*p312q+l3_12(i1,i2).a(iut,2)*rmas
     & s(id3)
      cy1=l3_12(i1,i2).b(iut,1)+l3_12(i1,i2).d(iut,1)*rmass(id3)
      cy2=l3_12(i1,i2).d(iut,2)*p312q+l3_12(i1,i2).b(iut,2)*rmas
     & s(id3)
      cw1=l3_12(i1,i2).c(iut,1)*p312q+l3_12(i1,i2).a(iut,1)*rmas
     & s(id3)
      cw2=l3_12(i1,i2).a(iut,2)+l3_12(i1,i2).c(iut,2)*rmass(id3)
      cz1=l3_12(i1,i2).d(iut,1)*p312q+l3_12(i1,i2).b(iut,1)*rmas
     & s(id3)
      cz2=l3_12(i1,i2).b(iut,2)+l3_12(i1,i2).d(iut,2)*rmass(id3)
      clinetfz(i1,i2,mu).a(iut,1)=cx1*rf4_312(mu).a(1,1)+cx2*rf4
     & _312(mu).b(2,1)
      clinetfz(i1,i2,mu).b(iut,1)=cy1*rf4_312(mu).a(1,1)+cy2*rf4
     & _312(mu).b(2,1)
      clinetfz(i1,i2,mu).c(iut,1)=cw1*rf4_312(mu).d(1,1)+cw2*rf4
     & _312(mu).c(2,1)
      clinetfz(i1,i2,mu).d(iut,1)=cz1*rf4_312(mu).d(1,1)+cz2*rf4
     & _312(mu).c(2,1)
      clinetfz(i1,i2,mu).a(iut,2)=cw1*rf4_312(mu).b(1,2)+cw2*rf4
     & _312(mu).a(2,2)
      clinetfz(i1,i2,mu).b(iut,2)=cz1*rf4_312(mu).b(1,2)+cz2*rf4
     & _312(mu).a(2,2)
      clinetfz(i1,i2,mu).c(iut,2)=cx1*rf4_312(mu).c(1,2)+cx2*rf4
     & _312(mu).d(2,2)
      clinetfz(i1,i2,mu).d(iut,2)=cy1*rf4_312(mu).c(1,2)+cy2*rf4
     & _312(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* TTs -- aa=clinetfz(i1,i2,mu).a,bb=clinetfz(i1,i2,mu).b,cc=clinetfz(i1,
* i2,mu).c,dd=clinetfz(i1,i2,mu).d,a1=lf3_412(mu).a,b1=lf3_412(mu).b,c1=
* lf3_412(mu).c,d1=lf3_412(mu).d,a2=r4_12(i1,i2).a,b2=r4_12(i1,i2).b,c2=
* r4_12(i1,i2).c,d2=r4_12(i1,i2).d,prq=p412q,m=rmass(id3),nsum=1
      do jut=1,2
      cx1=r4_12(i1,i2).a(1,jut)+rmass(id3)*r4_12(i1,i2).b(1,jut)
      cx2=r4_12(i1,i2).a(2,jut)+rmass(id3)*r4_12(i1,i2).b(2,jut)
      cy1=p412q*r4_12(i1,i2).b(1,jut)+rmass(id3)*r4_12(i1,i2).a(
     & 1,jut)
      cy2=p412q*r4_12(i1,i2).b(2,jut)+rmass(id3)*r4_12(i1,i2).a(
     & 2,jut)
      cw1=r4_12(i1,i2).c(1,jut)+rmass(id3)*r4_12(i1,i2).d(1,jut)
      cw2=r4_12(i1,i2).c(2,jut)+rmass(id3)*r4_12(i1,i2).d(2,jut)
      cz1=p412q*r4_12(i1,i2).d(1,jut)+rmass(id3)*r4_12(i1,i2).c(
     & 1,jut)
      cz2=p412q*r4_12(i1,i2).d(2,jut)+rmass(id3)*r4_12(i1,i2).c(
     & 2,jut)
      clinetfz(i1,i2,mu).a(1,jut)=clinetfz(i1,i2,mu).a(1,jut)+lf
     & 3_412(mu).a(1,1)*cx1+lf3_412(mu).c(1,2)*cy2
      clinetfz(i1,i2,mu).b(1,jut)=clinetfz(i1,i2,mu).b(1,jut)+lf
     & 3_412(mu).d(1,1)*cy1+lf3_412(mu).b(1,2)*cx2
      clinetfz(i1,i2,mu).c(1,jut)=clinetfz(i1,i2,mu).c(1,jut)+lf
     & 3_412(mu).a(1,1)*cw1+lf3_412(mu).c(1,2)*cz2
      clinetfz(i1,i2,mu).d(1,jut)=clinetfz(i1,i2,mu).d(1,jut)+lf
     & 3_412(mu).d(1,1)*cz1+lf3_412(mu).b(1,2)*cw2
      clinetfz(i1,i2,mu).a(2,jut)=clinetfz(i1,i2,mu).a(2,jut)+lf
     & 3_412(mu).c(2,1)*cy1+lf3_412(mu).a(2,2)*cx2
      clinetfz(i1,i2,mu).b(2,jut)=clinetfz(i1,i2,mu).b(2,jut)+lf
     & 3_412(mu).b(2,1)*cx1+lf3_412(mu).d(2,2)*cy2
      clinetfz(i1,i2,mu).c(2,jut)=clinetfz(i1,i2,mu).c(2,jut)+lf
     & 3_412(mu).c(2,1)*cz1+lf3_412(mu).a(2,2)*cw2
      clinetfz(i1,i2,mu).d(2,jut)=clinetfz(i1,i2,mu).d(2,jut)+lf
     & 3_412(mu).b(2,1)*cw1+lf3_412(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id3)
      rmassr=-rmass(id4)
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* mline -- res=cf1234(i1,i2,&1,&2,mu),abcd=clinetfz(i1,i2,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      cf1234(i1,i2,iut,jut,mu)=cf1234(i1,i2,iut,jut,mu)+clinetfz
     & (i1,i2,mu).a(iut,jut)+rmassl*clinetfz(i1,i2,mu).b(iut,jut
     & )+rmassr*clinetfz(i1,i2,mu).c(iut,jut)+rmassl*rmassr*clin
     & etfz(i1,i2,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i7=1,2
      do i8=1,2
      do mu=0,3
* TsT -- aa=clinetfz(i7,i8,mu).a,bb=clinetfz(i7,i8,mu).b,cc=clinetfz(i7,
* i8,mu).c,dd=clinetfz(i7,i8,mu).d,a1=l5_78(i7,i8).a,b1=l5_78(i7,i8).b,c
* 1=l5_78(i7,i8).c,d1=l5_78(i7,i8).d,a2=rf6_578(mu).a,b2=rf6_578(mu).b,c
* 2=rf6_578(mu).c,d2=rf6_578(mu).d,prq=p578q,m=rmass(id5),nsum=0
      do iut=1,2
      cx1=l5_78(i7,i8).a(iut,1)+l5_78(i7,i8).c(iut,1)*rmass(id5)
      cx2=l5_78(i7,i8).c(iut,2)*p578q+l5_78(i7,i8).a(iut,2)*rmas
     & s(id5)
      cy1=l5_78(i7,i8).b(iut,1)+l5_78(i7,i8).d(iut,1)*rmass(id5)
      cy2=l5_78(i7,i8).d(iut,2)*p578q+l5_78(i7,i8).b(iut,2)*rmas
     & s(id5)
      cw1=l5_78(i7,i8).c(iut,1)*p578q+l5_78(i7,i8).a(iut,1)*rmas
     & s(id5)
      cw2=l5_78(i7,i8).a(iut,2)+l5_78(i7,i8).c(iut,2)*rmass(id5)
      cz1=l5_78(i7,i8).d(iut,1)*p578q+l5_78(i7,i8).b(iut,1)*rmas
     & s(id5)
      cz2=l5_78(i7,i8).b(iut,2)+l5_78(i7,i8).d(iut,2)*rmass(id5)
      clinetfz(i7,i8,mu).a(iut,1)=cx1*rf6_578(mu).a(1,1)+cx2*rf6
     & _578(mu).b(2,1)
      clinetfz(i7,i8,mu).b(iut,1)=cy1*rf6_578(mu).a(1,1)+cy2*rf6
     & _578(mu).b(2,1)
      clinetfz(i7,i8,mu).c(iut,1)=cw1*rf6_578(mu).d(1,1)+cw2*rf6
     & _578(mu).c(2,1)
      clinetfz(i7,i8,mu).d(iut,1)=cz1*rf6_578(mu).d(1,1)+cz2*rf6
     & _578(mu).c(2,1)
      clinetfz(i7,i8,mu).a(iut,2)=cw1*rf6_578(mu).b(1,2)+cw2*rf6
     & _578(mu).a(2,2)
      clinetfz(i7,i8,mu).b(iut,2)=cz1*rf6_578(mu).b(1,2)+cz2*rf6
     & _578(mu).a(2,2)
      clinetfz(i7,i8,mu).c(iut,2)=cx1*rf6_578(mu).c(1,2)+cx2*rf6
     & _578(mu).d(2,2)
      clinetfz(i7,i8,mu).d(iut,2)=cy1*rf6_578(mu).c(1,2)+cy2*rf6
     & _578(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i7=1,2
      do i8=1,2
      do mu=0,3
* TTs -- aa=clinetfz(i7,i8,mu).a,bb=clinetfz(i7,i8,mu).b,cc=clinetfz(i7,
* i8,mu).c,dd=clinetfz(i7,i8,mu).d,a1=lf5_678(mu).a,b1=lf5_678(mu).b,c1=
* lf5_678(mu).c,d1=lf5_678(mu).d,a2=r6_78(i7,i8).a,b2=r6_78(i7,i8).b,c2=
* r6_78(i7,i8).c,d2=r6_78(i7,i8).d,prq=p678q,m=rmass(id5),nsum=1
      do jut=1,2
      cx1=r6_78(i7,i8).a(1,jut)+rmass(id5)*r6_78(i7,i8).b(1,jut)
      cx2=r6_78(i7,i8).a(2,jut)+rmass(id5)*r6_78(i7,i8).b(2,jut)
      cy1=p678q*r6_78(i7,i8).b(1,jut)+rmass(id5)*r6_78(i7,i8).a(
     & 1,jut)
      cy2=p678q*r6_78(i7,i8).b(2,jut)+rmass(id5)*r6_78(i7,i8).a(
     & 2,jut)
      cw1=r6_78(i7,i8).c(1,jut)+rmass(id5)*r6_78(i7,i8).d(1,jut)
      cw2=r6_78(i7,i8).c(2,jut)+rmass(id5)*r6_78(i7,i8).d(2,jut)
      cz1=p678q*r6_78(i7,i8).d(1,jut)+rmass(id5)*r6_78(i7,i8).c(
     & 1,jut)
      cz2=p678q*r6_78(i7,i8).d(2,jut)+rmass(id5)*r6_78(i7,i8).c(
     & 2,jut)
      clinetfz(i7,i8,mu).a(1,jut)=clinetfz(i7,i8,mu).a(1,jut)+lf
     & 5_678(mu).a(1,1)*cx1+lf5_678(mu).c(1,2)*cy2
      clinetfz(i7,i8,mu).b(1,jut)=clinetfz(i7,i8,mu).b(1,jut)+lf
     & 5_678(mu).d(1,1)*cy1+lf5_678(mu).b(1,2)*cx2
      clinetfz(i7,i8,mu).c(1,jut)=clinetfz(i7,i8,mu).c(1,jut)+lf
     & 5_678(mu).a(1,1)*cw1+lf5_678(mu).c(1,2)*cz2
      clinetfz(i7,i8,mu).d(1,jut)=clinetfz(i7,i8,mu).d(1,jut)+lf
     & 5_678(mu).d(1,1)*cz1+lf5_678(mu).b(1,2)*cw2
      clinetfz(i7,i8,mu).a(2,jut)=clinetfz(i7,i8,mu).a(2,jut)+lf
     & 5_678(mu).c(2,1)*cy1+lf5_678(mu).a(2,2)*cx2
      clinetfz(i7,i8,mu).b(2,jut)=clinetfz(i7,i8,mu).b(2,jut)+lf
     & 5_678(mu).b(2,1)*cx1+lf5_678(mu).d(2,2)*cy2
      clinetfz(i7,i8,mu).c(2,jut)=clinetfz(i7,i8,mu).c(2,jut)+lf
     & 5_678(mu).c(2,1)*cz1+lf5_678(mu).a(2,2)*cw2
      clinetfz(i7,i8,mu).d(2,jut)=clinetfz(i7,i8,mu).d(2,jut)+lf
     & 5_678(mu).b(2,1)*cw1+lf5_678(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id5)
      rmassr=-rmass(id6)
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* mline -- res=cf5678(&1,&2,i3,i4,mu),abcd=clinetfz(i3,i4,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cf5678(iut,jut,i3,i4,mu)=clinetfz(i3,i4,mu).a(iut,jut)+rma
     & ssl*clinetfz(i3,i4,mu).b(iut,jut)+rmassr*clinetfz(i3,i4,m
     & u).c(iut,jut)+rmassl*rmassr*clinetfz(i3,i4,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i5=1,2
      do i6=1,2
      do mu=0,3
* TsT -- aa=clinetfz(i5,i6,mu).a,bb=clinetfz(i5,i6,mu).b,cc=clinetfz(i5,
* i6,mu).c,dd=clinetfz(i5,i6,mu).d,a1=l7_56(i5,i6).a,b1=l7_56(i5,i6).b,c
* 1=l7_56(i5,i6).c,d1=l7_56(i5,i6).d,a2=rf8_756(mu).a,b2=rf8_756(mu).b,c
* 2=rf8_756(mu).c,d2=rf8_756(mu).d,prq=p756q,m=rmass(id7),nsum=0
      do iut=1,2
      cx1=l7_56(i5,i6).a(iut,1)+l7_56(i5,i6).c(iut,1)*rmass(id7)
      cx2=l7_56(i5,i6).c(iut,2)*p756q+l7_56(i5,i6).a(iut,2)*rmas
     & s(id7)
      cy1=l7_56(i5,i6).b(iut,1)+l7_56(i5,i6).d(iut,1)*rmass(id7)
      cy2=l7_56(i5,i6).d(iut,2)*p756q+l7_56(i5,i6).b(iut,2)*rmas
     & s(id7)
      cw1=l7_56(i5,i6).c(iut,1)*p756q+l7_56(i5,i6).a(iut,1)*rmas
     & s(id7)
      cw2=l7_56(i5,i6).a(iut,2)+l7_56(i5,i6).c(iut,2)*rmass(id7)
      cz1=l7_56(i5,i6).d(iut,1)*p756q+l7_56(i5,i6).b(iut,1)*rmas
     & s(id7)
      cz2=l7_56(i5,i6).b(iut,2)+l7_56(i5,i6).d(iut,2)*rmass(id7)
      clinetfz(i5,i6,mu).a(iut,1)=cx1*rf8_756(mu).a(1,1)+cx2*rf8
     & _756(mu).b(2,1)
      clinetfz(i5,i6,mu).b(iut,1)=cy1*rf8_756(mu).a(1,1)+cy2*rf8
     & _756(mu).b(2,1)
      clinetfz(i5,i6,mu).c(iut,1)=cw1*rf8_756(mu).d(1,1)+cw2*rf8
     & _756(mu).c(2,1)
      clinetfz(i5,i6,mu).d(iut,1)=cz1*rf8_756(mu).d(1,1)+cz2*rf8
     & _756(mu).c(2,1)
      clinetfz(i5,i6,mu).a(iut,2)=cw1*rf8_756(mu).b(1,2)+cw2*rf8
     & _756(mu).a(2,2)
      clinetfz(i5,i6,mu).b(iut,2)=cz1*rf8_756(mu).b(1,2)+cz2*rf8
     & _756(mu).a(2,2)
      clinetfz(i5,i6,mu).c(iut,2)=cx1*rf8_756(mu).c(1,2)+cx2*rf8
     & _756(mu).d(2,2)
      clinetfz(i5,i6,mu).d(iut,2)=cy1*rf8_756(mu).c(1,2)+cy2*rf8
     & _756(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i5=1,2
      do i6=1,2
      do mu=0,3
* TTs -- aa=clinetfz(i5,i6,mu).a,bb=clinetfz(i5,i6,mu).b,cc=clinetfz(i5,
* i6,mu).c,dd=clinetfz(i5,i6,mu).d,a1=lf7_856(mu).a,b1=lf7_856(mu).b,c1=
* lf7_856(mu).c,d1=lf7_856(mu).d,a2=r8_56(i5,i6).a,b2=r8_56(i5,i6).b,c2=
* r8_56(i5,i6).c,d2=r8_56(i5,i6).d,prq=p856q,m=rmass(id7),nsum=1
      do jut=1,2
      cx1=r8_56(i5,i6).a(1,jut)+rmass(id7)*r8_56(i5,i6).b(1,jut)
      cx2=r8_56(i5,i6).a(2,jut)+rmass(id7)*r8_56(i5,i6).b(2,jut)
      cy1=p856q*r8_56(i5,i6).b(1,jut)+rmass(id7)*r8_56(i5,i6).a(
     & 1,jut)
      cy2=p856q*r8_56(i5,i6).b(2,jut)+rmass(id7)*r8_56(i5,i6).a(
     & 2,jut)
      cw1=r8_56(i5,i6).c(1,jut)+rmass(id7)*r8_56(i5,i6).d(1,jut)
      cw2=r8_56(i5,i6).c(2,jut)+rmass(id7)*r8_56(i5,i6).d(2,jut)
      cz1=p856q*r8_56(i5,i6).d(1,jut)+rmass(id7)*r8_56(i5,i6).c(
     & 1,jut)
      cz2=p856q*r8_56(i5,i6).d(2,jut)+rmass(id7)*r8_56(i5,i6).c(
     & 2,jut)
      clinetfz(i5,i6,mu).a(1,jut)=clinetfz(i5,i6,mu).a(1,jut)+lf
     & 7_856(mu).a(1,1)*cx1+lf7_856(mu).c(1,2)*cy2
      clinetfz(i5,i6,mu).b(1,jut)=clinetfz(i5,i6,mu).b(1,jut)+lf
     & 7_856(mu).d(1,1)*cy1+lf7_856(mu).b(1,2)*cx2
      clinetfz(i5,i6,mu).c(1,jut)=clinetfz(i5,i6,mu).c(1,jut)+lf
     & 7_856(mu).a(1,1)*cw1+lf7_856(mu).c(1,2)*cz2
      clinetfz(i5,i6,mu).d(1,jut)=clinetfz(i5,i6,mu).d(1,jut)+lf
     & 7_856(mu).d(1,1)*cz1+lf7_856(mu).b(1,2)*cw2
      clinetfz(i5,i6,mu).a(2,jut)=clinetfz(i5,i6,mu).a(2,jut)+lf
     & 7_856(mu).c(2,1)*cy1+lf7_856(mu).a(2,2)*cx2
      clinetfz(i5,i6,mu).b(2,jut)=clinetfz(i5,i6,mu).b(2,jut)+lf
     & 7_856(mu).b(2,1)*cx1+lf7_856(mu).d(2,2)*cy2
      clinetfz(i5,i6,mu).c(2,jut)=clinetfz(i5,i6,mu).c(2,jut)+lf
     & 7_856(mu).c(2,1)*cz1+lf7_856(mu).a(2,2)*cw2
      clinetfz(i5,i6,mu).d(2,jut)=clinetfz(i5,i6,mu).d(2,jut)+lf
     & 7_856(mu).b(2,1)*cw1+lf7_856(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id7)
      rmassr=-rmass(id8)
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* mline -- res=cf5678(i1,i2,&1,&2,mu),abcd=clinetfz(i1,i2,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      cf5678(i1,i2,iut,jut,mu)=cf5678(i1,i2,iut,jut,mu)+clinetfz
     & (i1,i2,mu).a(iut,jut)+rmassl*clinetfz(i1,i2,mu).b(iut,jut
     & )+rmassr*clinetfz(i1,i2,mu).c(iut,jut)+rmassl*rmassr*clin
     & etfz(i1,i2,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i5=1,2
      do i6=1,2
      do mu=0,3
* TsT -- aa=clinetfz(i5,i6,mu).a,bb=clinetfz(i5,i6,mu).b,cc=clinetfz(i5,
* i6,mu).c,dd=clinetfz(i5,i6,mu).d,a1=l1_56(i5,i6).a,b1=l1_56(i5,i6).b,c
* 1=l1_56(i5,i6).c,d1=l1_56(i5,i6).d,a2=rf2_156(mu).a,b2=rf2_156(mu).b,c
* 2=rf2_156(mu).c,d2=rf2_156(mu).d,prq=p156q,m=rmass(id1),nsum=0
      do iut=1,2
      cx1=l1_56(i5,i6).a(iut,1)+l1_56(i5,i6).c(iut,1)*rmass(id1)
      cx2=l1_56(i5,i6).c(iut,2)*p156q+l1_56(i5,i6).a(iut,2)*rmas
     & s(id1)
      cy1=l1_56(i5,i6).b(iut,1)+l1_56(i5,i6).d(iut,1)*rmass(id1)
      cy2=l1_56(i5,i6).d(iut,2)*p156q+l1_56(i5,i6).b(iut,2)*rmas
     & s(id1)
      cw1=l1_56(i5,i6).c(iut,1)*p156q+l1_56(i5,i6).a(iut,1)*rmas
     & s(id1)
      cw2=l1_56(i5,i6).a(iut,2)+l1_56(i5,i6).c(iut,2)*rmass(id1)
      cz1=l1_56(i5,i6).d(iut,1)*p156q+l1_56(i5,i6).b(iut,1)*rmas
     & s(id1)
      cz2=l1_56(i5,i6).b(iut,2)+l1_56(i5,i6).d(iut,2)*rmass(id1)
      clinetfz(i5,i6,mu).a(iut,1)=cx1*rf2_156(mu).a(1,1)+cx2*rf2
     & _156(mu).b(2,1)
      clinetfz(i5,i6,mu).b(iut,1)=cy1*rf2_156(mu).a(1,1)+cy2*rf2
     & _156(mu).b(2,1)
      clinetfz(i5,i6,mu).c(iut,1)=cw1*rf2_156(mu).d(1,1)+cw2*rf2
     & _156(mu).c(2,1)
      clinetfz(i5,i6,mu).d(iut,1)=cz1*rf2_156(mu).d(1,1)+cz2*rf2
     & _156(mu).c(2,1)
      clinetfz(i5,i6,mu).a(iut,2)=cw1*rf2_156(mu).b(1,2)+cw2*rf2
     & _156(mu).a(2,2)
      clinetfz(i5,i6,mu).b(iut,2)=cz1*rf2_156(mu).b(1,2)+cz2*rf2
     & _156(mu).a(2,2)
      clinetfz(i5,i6,mu).c(iut,2)=cx1*rf2_156(mu).c(1,2)+cx2*rf2
     & _156(mu).d(2,2)
      clinetfz(i5,i6,mu).d(iut,2)=cy1*rf2_156(mu).c(1,2)+cy2*rf2
     & _156(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i5=1,2
      do i6=1,2
      do mu=0,3
* TTs -- aa=clinetfz(i5,i6,mu).a,bb=clinetfz(i5,i6,mu).b,cc=clinetfz(i5,
* i6,mu).c,dd=clinetfz(i5,i6,mu).d,a1=lf1_256(mu).a,b1=lf1_256(mu).b,c1=
* lf1_256(mu).c,d1=lf1_256(mu).d,a2=r2_56(i5,i6).a,b2=r2_56(i5,i6).b,c2=
* r2_56(i5,i6).c,d2=r2_56(i5,i6).d,prq=p256q,m=rmass(id1),nsum=1
      do jut=1,2
      cx1=r2_56(i5,i6).a(1,jut)+rmass(id1)*r2_56(i5,i6).b(1,jut)
      cx2=r2_56(i5,i6).a(2,jut)+rmass(id1)*r2_56(i5,i6).b(2,jut)
      cy1=p256q*r2_56(i5,i6).b(1,jut)+rmass(id1)*r2_56(i5,i6).a(
     & 1,jut)
      cy2=p256q*r2_56(i5,i6).b(2,jut)+rmass(id1)*r2_56(i5,i6).a(
     & 2,jut)
      cw1=r2_56(i5,i6).c(1,jut)+rmass(id1)*r2_56(i5,i6).d(1,jut)
      cw2=r2_56(i5,i6).c(2,jut)+rmass(id1)*r2_56(i5,i6).d(2,jut)
      cz1=p256q*r2_56(i5,i6).d(1,jut)+rmass(id1)*r2_56(i5,i6).c(
     & 1,jut)
      cz2=p256q*r2_56(i5,i6).d(2,jut)+rmass(id1)*r2_56(i5,i6).c(
     & 2,jut)
      clinetfz(i5,i6,mu).a(1,jut)=clinetfz(i5,i6,mu).a(1,jut)+lf
     & 1_256(mu).a(1,1)*cx1+lf1_256(mu).c(1,2)*cy2
      clinetfz(i5,i6,mu).b(1,jut)=clinetfz(i5,i6,mu).b(1,jut)+lf
     & 1_256(mu).d(1,1)*cy1+lf1_256(mu).b(1,2)*cx2
      clinetfz(i5,i6,mu).c(1,jut)=clinetfz(i5,i6,mu).c(1,jut)+lf
     & 1_256(mu).a(1,1)*cw1+lf1_256(mu).c(1,2)*cz2
      clinetfz(i5,i6,mu).d(1,jut)=clinetfz(i5,i6,mu).d(1,jut)+lf
     & 1_256(mu).d(1,1)*cz1+lf1_256(mu).b(1,2)*cw2
      clinetfz(i5,i6,mu).a(2,jut)=clinetfz(i5,i6,mu).a(2,jut)+lf
     & 1_256(mu).c(2,1)*cy1+lf1_256(mu).a(2,2)*cx2
      clinetfz(i5,i6,mu).b(2,jut)=clinetfz(i5,i6,mu).b(2,jut)+lf
     & 1_256(mu).b(2,1)*cx1+lf1_256(mu).d(2,2)*cy2
      clinetfz(i5,i6,mu).c(2,jut)=clinetfz(i5,i6,mu).c(2,jut)+lf
     & 1_256(mu).c(2,1)*cz1+lf1_256(mu).a(2,2)*cw2
      clinetfz(i5,i6,mu).d(2,jut)=clinetfz(i5,i6,mu).d(2,jut)+lf
     & 1_256(mu).b(2,1)*cw1+lf1_256(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id1)
      rmassr=-rmass(id2)
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* mline -- res=cf1256(&1,&2,i3,i4,mu),abcd=clinetfz(i3,i4,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cf1256(iut,jut,i3,i4,mu)=clinetfz(i3,i4,mu).a(iut,jut)+rma
     & ssl*clinetfz(i3,i4,mu).b(iut,jut)+rmassr*clinetfz(i3,i4,m
     & u).c(iut,jut)+rmassl*rmassr*clinetfz(i3,i4,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* TsT -- aa=clinetfz(i1,i2,mu).a,bb=clinetfz(i1,i2,mu).b,cc=clinetfz(i1,
* i2,mu).c,dd=clinetfz(i1,i2,mu).d,a1=l5_12(i1,i2).a,b1=l5_12(i1,i2).b,c
* 1=l5_12(i1,i2).c,d1=l5_12(i1,i2).d,a2=rf6_512(mu).a,b2=rf6_512(mu).b,c
* 2=rf6_512(mu).c,d2=rf6_512(mu).d,prq=p512q,m=rmass(id5),nsum=0
      do iut=1,2
      cx1=l5_12(i1,i2).a(iut,1)+l5_12(i1,i2).c(iut,1)*rmass(id5)
      cx2=l5_12(i1,i2).c(iut,2)*p512q+l5_12(i1,i2).a(iut,2)*rmas
     & s(id5)
      cy1=l5_12(i1,i2).b(iut,1)+l5_12(i1,i2).d(iut,1)*rmass(id5)
      cy2=l5_12(i1,i2).d(iut,2)*p512q+l5_12(i1,i2).b(iut,2)*rmas
     & s(id5)
      cw1=l5_12(i1,i2).c(iut,1)*p512q+l5_12(i1,i2).a(iut,1)*rmas
     & s(id5)
      cw2=l5_12(i1,i2).a(iut,2)+l5_12(i1,i2).c(iut,2)*rmass(id5)
      cz1=l5_12(i1,i2).d(iut,1)*p512q+l5_12(i1,i2).b(iut,1)*rmas
     & s(id5)
      cz2=l5_12(i1,i2).b(iut,2)+l5_12(i1,i2).d(iut,2)*rmass(id5)
      clinetfz(i1,i2,mu).a(iut,1)=cx1*rf6_512(mu).a(1,1)+cx2*rf6
     & _512(mu).b(2,1)
      clinetfz(i1,i2,mu).b(iut,1)=cy1*rf6_512(mu).a(1,1)+cy2*rf6
     & _512(mu).b(2,1)
      clinetfz(i1,i2,mu).c(iut,1)=cw1*rf6_512(mu).d(1,1)+cw2*rf6
     & _512(mu).c(2,1)
      clinetfz(i1,i2,mu).d(iut,1)=cz1*rf6_512(mu).d(1,1)+cz2*rf6
     & _512(mu).c(2,1)
      clinetfz(i1,i2,mu).a(iut,2)=cw1*rf6_512(mu).b(1,2)+cw2*rf6
     & _512(mu).a(2,2)
      clinetfz(i1,i2,mu).b(iut,2)=cz1*rf6_512(mu).b(1,2)+cz2*rf6
     & _512(mu).a(2,2)
      clinetfz(i1,i2,mu).c(iut,2)=cx1*rf6_512(mu).c(1,2)+cx2*rf6
     & _512(mu).d(2,2)
      clinetfz(i1,i2,mu).d(iut,2)=cy1*rf6_512(mu).c(1,2)+cy2*rf6
     & _512(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* TTs -- aa=clinetfz(i1,i2,mu).a,bb=clinetfz(i1,i2,mu).b,cc=clinetfz(i1,
* i2,mu).c,dd=clinetfz(i1,i2,mu).d,a1=lf5_612(mu).a,b1=lf5_612(mu).b,c1=
* lf5_612(mu).c,d1=lf5_612(mu).d,a2=r6_12(i1,i2).a,b2=r6_12(i1,i2).b,c2=
* r6_12(i1,i2).c,d2=r6_12(i1,i2).d,prq=p612q,m=rmass(id5),nsum=1
      do jut=1,2
      cx1=r6_12(i1,i2).a(1,jut)+rmass(id5)*r6_12(i1,i2).b(1,jut)
      cx2=r6_12(i1,i2).a(2,jut)+rmass(id5)*r6_12(i1,i2).b(2,jut)
      cy1=p612q*r6_12(i1,i2).b(1,jut)+rmass(id5)*r6_12(i1,i2).a(
     & 1,jut)
      cy2=p612q*r6_12(i1,i2).b(2,jut)+rmass(id5)*r6_12(i1,i2).a(
     & 2,jut)
      cw1=r6_12(i1,i2).c(1,jut)+rmass(id5)*r6_12(i1,i2).d(1,jut)
      cw2=r6_12(i1,i2).c(2,jut)+rmass(id5)*r6_12(i1,i2).d(2,jut)
      cz1=p612q*r6_12(i1,i2).d(1,jut)+rmass(id5)*r6_12(i1,i2).c(
     & 1,jut)
      cz2=p612q*r6_12(i1,i2).d(2,jut)+rmass(id5)*r6_12(i1,i2).c(
     & 2,jut)
      clinetfz(i1,i2,mu).a(1,jut)=clinetfz(i1,i2,mu).a(1,jut)+lf
     & 5_612(mu).a(1,1)*cx1+lf5_612(mu).c(1,2)*cy2
      clinetfz(i1,i2,mu).b(1,jut)=clinetfz(i1,i2,mu).b(1,jut)+lf
     & 5_612(mu).d(1,1)*cy1+lf5_612(mu).b(1,2)*cx2
      clinetfz(i1,i2,mu).c(1,jut)=clinetfz(i1,i2,mu).c(1,jut)+lf
     & 5_612(mu).a(1,1)*cw1+lf5_612(mu).c(1,2)*cz2
      clinetfz(i1,i2,mu).d(1,jut)=clinetfz(i1,i2,mu).d(1,jut)+lf
     & 5_612(mu).d(1,1)*cz1+lf5_612(mu).b(1,2)*cw2
      clinetfz(i1,i2,mu).a(2,jut)=clinetfz(i1,i2,mu).a(2,jut)+lf
     & 5_612(mu).c(2,1)*cy1+lf5_612(mu).a(2,2)*cx2
      clinetfz(i1,i2,mu).b(2,jut)=clinetfz(i1,i2,mu).b(2,jut)+lf
     & 5_612(mu).b(2,1)*cx1+lf5_612(mu).d(2,2)*cy2
      clinetfz(i1,i2,mu).c(2,jut)=clinetfz(i1,i2,mu).c(2,jut)+lf
     & 5_612(mu).c(2,1)*cz1+lf5_612(mu).a(2,2)*cw2
      clinetfz(i1,i2,mu).d(2,jut)=clinetfz(i1,i2,mu).d(2,jut)+lf
     & 5_612(mu).b(2,1)*cw1+lf5_612(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id5)
      rmassr=-rmass(id6)
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* mline -- res=cf1256(i1,i2,&1,&2,mu),abcd=clinetfz(i1,i2,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      cf1256(i1,i2,iut,jut,mu)=cf1256(i1,i2,iut,jut,mu)+clinetfz
     & (i1,i2,mu).a(iut,jut)+rmassl*clinetfz(i1,i2,mu).b(iut,jut
     & )+rmassr*clinetfz(i1,i2,mu).c(iut,jut)+rmassl*rmassr*clin
     & etfz(i1,i2,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i7=1,2
      do i8=1,2
      do mu=0,3
* TsT -- aa=clinetfz(i7,i8,mu).a,bb=clinetfz(i7,i8,mu).b,cc=clinetfz(i7,
* i8,mu).c,dd=clinetfz(i7,i8,mu).d,a1=l3_78(i7,i8).a,b1=l3_78(i7,i8).b,c
* 1=l3_78(i7,i8).c,d1=l3_78(i7,i8).d,a2=rf4_378(mu).a,b2=rf4_378(mu).b,c
* 2=rf4_378(mu).c,d2=rf4_378(mu).d,prq=p378q,m=rmass(id3),nsum=0
      do iut=1,2
      cx1=l3_78(i7,i8).a(iut,1)+l3_78(i7,i8).c(iut,1)*rmass(id3)
      cx2=l3_78(i7,i8).c(iut,2)*p378q+l3_78(i7,i8).a(iut,2)*rmas
     & s(id3)
      cy1=l3_78(i7,i8).b(iut,1)+l3_78(i7,i8).d(iut,1)*rmass(id3)
      cy2=l3_78(i7,i8).d(iut,2)*p378q+l3_78(i7,i8).b(iut,2)*rmas
     & s(id3)
      cw1=l3_78(i7,i8).c(iut,1)*p378q+l3_78(i7,i8).a(iut,1)*rmas
     & s(id3)
      cw2=l3_78(i7,i8).a(iut,2)+l3_78(i7,i8).c(iut,2)*rmass(id3)
      cz1=l3_78(i7,i8).d(iut,1)*p378q+l3_78(i7,i8).b(iut,1)*rmas
     & s(id3)
      cz2=l3_78(i7,i8).b(iut,2)+l3_78(i7,i8).d(iut,2)*rmass(id3)
      clinetfz(i7,i8,mu).a(iut,1)=cx1*rf4_378(mu).a(1,1)+cx2*rf4
     & _378(mu).b(2,1)
      clinetfz(i7,i8,mu).b(iut,1)=cy1*rf4_378(mu).a(1,1)+cy2*rf4
     & _378(mu).b(2,1)
      clinetfz(i7,i8,mu).c(iut,1)=cw1*rf4_378(mu).d(1,1)+cw2*rf4
     & _378(mu).c(2,1)
      clinetfz(i7,i8,mu).d(iut,1)=cz1*rf4_378(mu).d(1,1)+cz2*rf4
     & _378(mu).c(2,1)
      clinetfz(i7,i8,mu).a(iut,2)=cw1*rf4_378(mu).b(1,2)+cw2*rf4
     & _378(mu).a(2,2)
      clinetfz(i7,i8,mu).b(iut,2)=cz1*rf4_378(mu).b(1,2)+cz2*rf4
     & _378(mu).a(2,2)
      clinetfz(i7,i8,mu).c(iut,2)=cx1*rf4_378(mu).c(1,2)+cx2*rf4
     & _378(mu).d(2,2)
      clinetfz(i7,i8,mu).d(iut,2)=cy1*rf4_378(mu).c(1,2)+cy2*rf4
     & _378(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i7=1,2
      do i8=1,2
      do mu=0,3
* TTs -- aa=clinetfz(i7,i8,mu).a,bb=clinetfz(i7,i8,mu).b,cc=clinetfz(i7,
* i8,mu).c,dd=clinetfz(i7,i8,mu).d,a1=lf3_478(mu).a,b1=lf3_478(mu).b,c1=
* lf3_478(mu).c,d1=lf3_478(mu).d,a2=r4_78(i7,i8).a,b2=r4_78(i7,i8).b,c2=
* r4_78(i7,i8).c,d2=r4_78(i7,i8).d,prq=p478q,m=rmass(id3),nsum=1
      do jut=1,2
      cx1=r4_78(i7,i8).a(1,jut)+rmass(id3)*r4_78(i7,i8).b(1,jut)
      cx2=r4_78(i7,i8).a(2,jut)+rmass(id3)*r4_78(i7,i8).b(2,jut)
      cy1=p478q*r4_78(i7,i8).b(1,jut)+rmass(id3)*r4_78(i7,i8).a(
     & 1,jut)
      cy2=p478q*r4_78(i7,i8).b(2,jut)+rmass(id3)*r4_78(i7,i8).a(
     & 2,jut)
      cw1=r4_78(i7,i8).c(1,jut)+rmass(id3)*r4_78(i7,i8).d(1,jut)
      cw2=r4_78(i7,i8).c(2,jut)+rmass(id3)*r4_78(i7,i8).d(2,jut)
      cz1=p478q*r4_78(i7,i8).d(1,jut)+rmass(id3)*r4_78(i7,i8).c(
     & 1,jut)
      cz2=p478q*r4_78(i7,i8).d(2,jut)+rmass(id3)*r4_78(i7,i8).c(
     & 2,jut)
      clinetfz(i7,i8,mu).a(1,jut)=clinetfz(i7,i8,mu).a(1,jut)+lf
     & 3_478(mu).a(1,1)*cx1+lf3_478(mu).c(1,2)*cy2
      clinetfz(i7,i8,mu).b(1,jut)=clinetfz(i7,i8,mu).b(1,jut)+lf
     & 3_478(mu).d(1,1)*cy1+lf3_478(mu).b(1,2)*cx2
      clinetfz(i7,i8,mu).c(1,jut)=clinetfz(i7,i8,mu).c(1,jut)+lf
     & 3_478(mu).a(1,1)*cw1+lf3_478(mu).c(1,2)*cz2
      clinetfz(i7,i8,mu).d(1,jut)=clinetfz(i7,i8,mu).d(1,jut)+lf
     & 3_478(mu).d(1,1)*cz1+lf3_478(mu).b(1,2)*cw2
      clinetfz(i7,i8,mu).a(2,jut)=clinetfz(i7,i8,mu).a(2,jut)+lf
     & 3_478(mu).c(2,1)*cy1+lf3_478(mu).a(2,2)*cx2
      clinetfz(i7,i8,mu).b(2,jut)=clinetfz(i7,i8,mu).b(2,jut)+lf
     & 3_478(mu).b(2,1)*cx1+lf3_478(mu).d(2,2)*cy2
      clinetfz(i7,i8,mu).c(2,jut)=clinetfz(i7,i8,mu).c(2,jut)+lf
     & 3_478(mu).c(2,1)*cz1+lf3_478(mu).a(2,2)*cw2
      clinetfz(i7,i8,mu).d(2,jut)=clinetfz(i7,i8,mu).d(2,jut)+lf
     & 3_478(mu).b(2,1)*cw1+lf3_478(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id3)
      rmassr=-rmass(id4)
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* mline -- res=cf3478(&1,&2,i3,i4,mu),abcd=clinetfz(i3,i4,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cf3478(iut,jut,i3,i4,mu)=clinetfz(i3,i4,mu).a(iut,jut)+rma
     & ssl*clinetfz(i3,i4,mu).b(iut,jut)+rmassr*clinetfz(i3,i4,m
     & u).c(iut,jut)+rmassl*rmassr*clinetfz(i3,i4,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* TsT -- aa=clinetfz(i3,i4,mu).a,bb=clinetfz(i3,i4,mu).b,cc=clinetfz(i3,
* i4,mu).c,dd=clinetfz(i3,i4,mu).d,a1=l7_34(i3,i4).a,b1=l7_34(i3,i4).b,c
* 1=l7_34(i3,i4).c,d1=l7_34(i3,i4).d,a2=rf8_734(mu).a,b2=rf8_734(mu).b,c
* 2=rf8_734(mu).c,d2=rf8_734(mu).d,prq=p734q,m=rmass(id7),nsum=0
      do iut=1,2
      cx1=l7_34(i3,i4).a(iut,1)+l7_34(i3,i4).c(iut,1)*rmass(id7)
      cx2=l7_34(i3,i4).c(iut,2)*p734q+l7_34(i3,i4).a(iut,2)*rmas
     & s(id7)
      cy1=l7_34(i3,i4).b(iut,1)+l7_34(i3,i4).d(iut,1)*rmass(id7)
      cy2=l7_34(i3,i4).d(iut,2)*p734q+l7_34(i3,i4).b(iut,2)*rmas
     & s(id7)
      cw1=l7_34(i3,i4).c(iut,1)*p734q+l7_34(i3,i4).a(iut,1)*rmas
     & s(id7)
      cw2=l7_34(i3,i4).a(iut,2)+l7_34(i3,i4).c(iut,2)*rmass(id7)
      cz1=l7_34(i3,i4).d(iut,1)*p734q+l7_34(i3,i4).b(iut,1)*rmas
     & s(id7)
      cz2=l7_34(i3,i4).b(iut,2)+l7_34(i3,i4).d(iut,2)*rmass(id7)
      clinetfz(i3,i4,mu).a(iut,1)=cx1*rf8_734(mu).a(1,1)+cx2*rf8
     & _734(mu).b(2,1)
      clinetfz(i3,i4,mu).b(iut,1)=cy1*rf8_734(mu).a(1,1)+cy2*rf8
     & _734(mu).b(2,1)
      clinetfz(i3,i4,mu).c(iut,1)=cw1*rf8_734(mu).d(1,1)+cw2*rf8
     & _734(mu).c(2,1)
      clinetfz(i3,i4,mu).d(iut,1)=cz1*rf8_734(mu).d(1,1)+cz2*rf8
     & _734(mu).c(2,1)
      clinetfz(i3,i4,mu).a(iut,2)=cw1*rf8_734(mu).b(1,2)+cw2*rf8
     & _734(mu).a(2,2)
      clinetfz(i3,i4,mu).b(iut,2)=cz1*rf8_734(mu).b(1,2)+cz2*rf8
     & _734(mu).a(2,2)
      clinetfz(i3,i4,mu).c(iut,2)=cx1*rf8_734(mu).c(1,2)+cx2*rf8
     & _734(mu).d(2,2)
      clinetfz(i3,i4,mu).d(iut,2)=cy1*rf8_734(mu).c(1,2)+cy2*rf8
     & _734(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* TTs -- aa=clinetfz(i3,i4,mu).a,bb=clinetfz(i3,i4,mu).b,cc=clinetfz(i3,
* i4,mu).c,dd=clinetfz(i3,i4,mu).d,a1=lf7_834(mu).a,b1=lf7_834(mu).b,c1=
* lf7_834(mu).c,d1=lf7_834(mu).d,a2=r8_34(i3,i4).a,b2=r8_34(i3,i4).b,c2=
* r8_34(i3,i4).c,d2=r8_34(i3,i4).d,prq=p834q,m=rmass(id7),nsum=1
      do jut=1,2
      cx1=r8_34(i3,i4).a(1,jut)+rmass(id7)*r8_34(i3,i4).b(1,jut)
      cx2=r8_34(i3,i4).a(2,jut)+rmass(id7)*r8_34(i3,i4).b(2,jut)
      cy1=p834q*r8_34(i3,i4).b(1,jut)+rmass(id7)*r8_34(i3,i4).a(
     & 1,jut)
      cy2=p834q*r8_34(i3,i4).b(2,jut)+rmass(id7)*r8_34(i3,i4).a(
     & 2,jut)
      cw1=r8_34(i3,i4).c(1,jut)+rmass(id7)*r8_34(i3,i4).d(1,jut)
      cw2=r8_34(i3,i4).c(2,jut)+rmass(id7)*r8_34(i3,i4).d(2,jut)
      cz1=p834q*r8_34(i3,i4).d(1,jut)+rmass(id7)*r8_34(i3,i4).c(
     & 1,jut)
      cz2=p834q*r8_34(i3,i4).d(2,jut)+rmass(id7)*r8_34(i3,i4).c(
     & 2,jut)
      clinetfz(i3,i4,mu).a(1,jut)=clinetfz(i3,i4,mu).a(1,jut)+lf
     & 7_834(mu).a(1,1)*cx1+lf7_834(mu).c(1,2)*cy2
      clinetfz(i3,i4,mu).b(1,jut)=clinetfz(i3,i4,mu).b(1,jut)+lf
     & 7_834(mu).d(1,1)*cy1+lf7_834(mu).b(1,2)*cx2
      clinetfz(i3,i4,mu).c(1,jut)=clinetfz(i3,i4,mu).c(1,jut)+lf
     & 7_834(mu).a(1,1)*cw1+lf7_834(mu).c(1,2)*cz2
      clinetfz(i3,i4,mu).d(1,jut)=clinetfz(i3,i4,mu).d(1,jut)+lf
     & 7_834(mu).d(1,1)*cz1+lf7_834(mu).b(1,2)*cw2
      clinetfz(i3,i4,mu).a(2,jut)=clinetfz(i3,i4,mu).a(2,jut)+lf
     & 7_834(mu).c(2,1)*cy1+lf7_834(mu).a(2,2)*cx2
      clinetfz(i3,i4,mu).b(2,jut)=clinetfz(i3,i4,mu).b(2,jut)+lf
     & 7_834(mu).b(2,1)*cx1+lf7_834(mu).d(2,2)*cy2
      clinetfz(i3,i4,mu).c(2,jut)=clinetfz(i3,i4,mu).c(2,jut)+lf
     & 7_834(mu).c(2,1)*cz1+lf7_834(mu).a(2,2)*cw2
      clinetfz(i3,i4,mu).d(2,jut)=clinetfz(i3,i4,mu).d(2,jut)+lf
     & 7_834(mu).b(2,1)*cw1+lf7_834(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id7)
      rmassr=-rmass(id8)
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* mline -- res=cf3478(i1,i2,&1,&2,mu),abcd=clinetfz(i1,i2,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      cf3478(i1,i2,iut,jut,mu)=cf3478(i1,i2,iut,jut,mu)+clinetfz
     & (i1,i2,mu).a(iut,jut)+rmassl*clinetfz(i1,i2,mu).b(iut,jut
     & )+rmassr*clinetfz(i1,i2,mu).c(iut,jut)+rmassl*rmassr*clin
     & etfz(i1,i2,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i7=1,2
      do i8=1,2
      do mu=0,3
* TsT -- aa=clinetfz(i7,i8,mu).a,bb=clinetfz(i7,i8,mu).b,cc=clinetfz(i7,
* i8,mu).c,dd=clinetfz(i7,i8,mu).d,a1=l1_78(i7,i8).a,b1=l1_78(i7,i8).b,c
* 1=l1_78(i7,i8).c,d1=l1_78(i7,i8).d,a2=rf2_178(mu).a,b2=rf2_178(mu).b,c
* 2=rf2_178(mu).c,d2=rf2_178(mu).d,prq=p178q,m=rmass(id1),nsum=0
      do iut=1,2
      cx1=l1_78(i7,i8).a(iut,1)+l1_78(i7,i8).c(iut,1)*rmass(id1)
      cx2=l1_78(i7,i8).c(iut,2)*p178q+l1_78(i7,i8).a(iut,2)*rmas
     & s(id1)
      cy1=l1_78(i7,i8).b(iut,1)+l1_78(i7,i8).d(iut,1)*rmass(id1)
      cy2=l1_78(i7,i8).d(iut,2)*p178q+l1_78(i7,i8).b(iut,2)*rmas
     & s(id1)
      cw1=l1_78(i7,i8).c(iut,1)*p178q+l1_78(i7,i8).a(iut,1)*rmas
     & s(id1)
      cw2=l1_78(i7,i8).a(iut,2)+l1_78(i7,i8).c(iut,2)*rmass(id1)
      cz1=l1_78(i7,i8).d(iut,1)*p178q+l1_78(i7,i8).b(iut,1)*rmas
     & s(id1)
      cz2=l1_78(i7,i8).b(iut,2)+l1_78(i7,i8).d(iut,2)*rmass(id1)
      clinetfz(i7,i8,mu).a(iut,1)=cx1*rf2_178(mu).a(1,1)+cx2*rf2
     & _178(mu).b(2,1)
      clinetfz(i7,i8,mu).b(iut,1)=cy1*rf2_178(mu).a(1,1)+cy2*rf2
     & _178(mu).b(2,1)
      clinetfz(i7,i8,mu).c(iut,1)=cw1*rf2_178(mu).d(1,1)+cw2*rf2
     & _178(mu).c(2,1)
      clinetfz(i7,i8,mu).d(iut,1)=cz1*rf2_178(mu).d(1,1)+cz2*rf2
     & _178(mu).c(2,1)
      clinetfz(i7,i8,mu).a(iut,2)=cw1*rf2_178(mu).b(1,2)+cw2*rf2
     & _178(mu).a(2,2)
      clinetfz(i7,i8,mu).b(iut,2)=cz1*rf2_178(mu).b(1,2)+cz2*rf2
     & _178(mu).a(2,2)
      clinetfz(i7,i8,mu).c(iut,2)=cx1*rf2_178(mu).c(1,2)+cx2*rf2
     & _178(mu).d(2,2)
      clinetfz(i7,i8,mu).d(iut,2)=cy1*rf2_178(mu).c(1,2)+cy2*rf2
     & _178(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i7=1,2
      do i8=1,2
      do mu=0,3
* TTs -- aa=clinetfz(i7,i8,mu).a,bb=clinetfz(i7,i8,mu).b,cc=clinetfz(i7,
* i8,mu).c,dd=clinetfz(i7,i8,mu).d,a1=lf1_278(mu).a,b1=lf1_278(mu).b,c1=
* lf1_278(mu).c,d1=lf1_278(mu).d,a2=r2_78(i7,i8).a,b2=r2_78(i7,i8).b,c2=
* r2_78(i7,i8).c,d2=r2_78(i7,i8).d,prq=p278q,m=rmass(id1),nsum=1
      do jut=1,2
      cx1=r2_78(i7,i8).a(1,jut)+rmass(id1)*r2_78(i7,i8).b(1,jut)
      cx2=r2_78(i7,i8).a(2,jut)+rmass(id1)*r2_78(i7,i8).b(2,jut)
      cy1=p278q*r2_78(i7,i8).b(1,jut)+rmass(id1)*r2_78(i7,i8).a(
     & 1,jut)
      cy2=p278q*r2_78(i7,i8).b(2,jut)+rmass(id1)*r2_78(i7,i8).a(
     & 2,jut)
      cw1=r2_78(i7,i8).c(1,jut)+rmass(id1)*r2_78(i7,i8).d(1,jut)
      cw2=r2_78(i7,i8).c(2,jut)+rmass(id1)*r2_78(i7,i8).d(2,jut)
      cz1=p278q*r2_78(i7,i8).d(1,jut)+rmass(id1)*r2_78(i7,i8).c(
     & 1,jut)
      cz2=p278q*r2_78(i7,i8).d(2,jut)+rmass(id1)*r2_78(i7,i8).c(
     & 2,jut)
      clinetfz(i7,i8,mu).a(1,jut)=clinetfz(i7,i8,mu).a(1,jut)+lf
     & 1_278(mu).a(1,1)*cx1+lf1_278(mu).c(1,2)*cy2
      clinetfz(i7,i8,mu).b(1,jut)=clinetfz(i7,i8,mu).b(1,jut)+lf
     & 1_278(mu).d(1,1)*cy1+lf1_278(mu).b(1,2)*cx2
      clinetfz(i7,i8,mu).c(1,jut)=clinetfz(i7,i8,mu).c(1,jut)+lf
     & 1_278(mu).a(1,1)*cw1+lf1_278(mu).c(1,2)*cz2
      clinetfz(i7,i8,mu).d(1,jut)=clinetfz(i7,i8,mu).d(1,jut)+lf
     & 1_278(mu).d(1,1)*cz1+lf1_278(mu).b(1,2)*cw2
      clinetfz(i7,i8,mu).a(2,jut)=clinetfz(i7,i8,mu).a(2,jut)+lf
     & 1_278(mu).c(2,1)*cy1+lf1_278(mu).a(2,2)*cx2
      clinetfz(i7,i8,mu).b(2,jut)=clinetfz(i7,i8,mu).b(2,jut)+lf
     & 1_278(mu).b(2,1)*cx1+lf1_278(mu).d(2,2)*cy2
      clinetfz(i7,i8,mu).c(2,jut)=clinetfz(i7,i8,mu).c(2,jut)+lf
     & 1_278(mu).c(2,1)*cz1+lf1_278(mu).a(2,2)*cw2
      clinetfz(i7,i8,mu).d(2,jut)=clinetfz(i7,i8,mu).d(2,jut)+lf
     & 1_278(mu).b(2,1)*cw1+lf1_278(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id1)
      rmassr=-rmass(id2)
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* mline -- res=cf1278(&1,&2,i3,i4,mu),abcd=clinetfz(i3,i4,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cf1278(iut,jut,i3,i4,mu)=clinetfz(i3,i4,mu).a(iut,jut)+rma
     & ssl*clinetfz(i3,i4,mu).b(iut,jut)+rmassr*clinetfz(i3,i4,m
     & u).c(iut,jut)+rmassl*rmassr*clinetfz(i3,i4,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* TsT -- aa=clinetfz(i1,i2,mu).a,bb=clinetfz(i1,i2,mu).b,cc=clinetfz(i1,
* i2,mu).c,dd=clinetfz(i1,i2,mu).d,a1=l7_12(i1,i2).a,b1=l7_12(i1,i2).b,c
* 1=l7_12(i1,i2).c,d1=l7_12(i1,i2).d,a2=rf8_712(mu).a,b2=rf8_712(mu).b,c
* 2=rf8_712(mu).c,d2=rf8_712(mu).d,prq=p712q,m=rmass(id7),nsum=0
      do iut=1,2
      cx1=l7_12(i1,i2).a(iut,1)+l7_12(i1,i2).c(iut,1)*rmass(id7)
      cx2=l7_12(i1,i2).c(iut,2)*p712q+l7_12(i1,i2).a(iut,2)*rmas
     & s(id7)
      cy1=l7_12(i1,i2).b(iut,1)+l7_12(i1,i2).d(iut,1)*rmass(id7)
      cy2=l7_12(i1,i2).d(iut,2)*p712q+l7_12(i1,i2).b(iut,2)*rmas
     & s(id7)
      cw1=l7_12(i1,i2).c(iut,1)*p712q+l7_12(i1,i2).a(iut,1)*rmas
     & s(id7)
      cw2=l7_12(i1,i2).a(iut,2)+l7_12(i1,i2).c(iut,2)*rmass(id7)
      cz1=l7_12(i1,i2).d(iut,1)*p712q+l7_12(i1,i2).b(iut,1)*rmas
     & s(id7)
      cz2=l7_12(i1,i2).b(iut,2)+l7_12(i1,i2).d(iut,2)*rmass(id7)
      clinetfz(i1,i2,mu).a(iut,1)=cx1*rf8_712(mu).a(1,1)+cx2*rf8
     & _712(mu).b(2,1)
      clinetfz(i1,i2,mu).b(iut,1)=cy1*rf8_712(mu).a(1,1)+cy2*rf8
     & _712(mu).b(2,1)
      clinetfz(i1,i2,mu).c(iut,1)=cw1*rf8_712(mu).d(1,1)+cw2*rf8
     & _712(mu).c(2,1)
      clinetfz(i1,i2,mu).d(iut,1)=cz1*rf8_712(mu).d(1,1)+cz2*rf8
     & _712(mu).c(2,1)
      clinetfz(i1,i2,mu).a(iut,2)=cw1*rf8_712(mu).b(1,2)+cw2*rf8
     & _712(mu).a(2,2)
      clinetfz(i1,i2,mu).b(iut,2)=cz1*rf8_712(mu).b(1,2)+cz2*rf8
     & _712(mu).a(2,2)
      clinetfz(i1,i2,mu).c(iut,2)=cx1*rf8_712(mu).c(1,2)+cx2*rf8
     & _712(mu).d(2,2)
      clinetfz(i1,i2,mu).d(iut,2)=cy1*rf8_712(mu).c(1,2)+cy2*rf8
     & _712(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* TTs -- aa=clinetfz(i1,i2,mu).a,bb=clinetfz(i1,i2,mu).b,cc=clinetfz(i1,
* i2,mu).c,dd=clinetfz(i1,i2,mu).d,a1=lf7_812(mu).a,b1=lf7_812(mu).b,c1=
* lf7_812(mu).c,d1=lf7_812(mu).d,a2=r8_12(i1,i2).a,b2=r8_12(i1,i2).b,c2=
* r8_12(i1,i2).c,d2=r8_12(i1,i2).d,prq=p812q,m=rmass(id7),nsum=1
      do jut=1,2
      cx1=r8_12(i1,i2).a(1,jut)+rmass(id7)*r8_12(i1,i2).b(1,jut)
      cx2=r8_12(i1,i2).a(2,jut)+rmass(id7)*r8_12(i1,i2).b(2,jut)
      cy1=p812q*r8_12(i1,i2).b(1,jut)+rmass(id7)*r8_12(i1,i2).a(
     & 1,jut)
      cy2=p812q*r8_12(i1,i2).b(2,jut)+rmass(id7)*r8_12(i1,i2).a(
     & 2,jut)
      cw1=r8_12(i1,i2).c(1,jut)+rmass(id7)*r8_12(i1,i2).d(1,jut)
      cw2=r8_12(i1,i2).c(2,jut)+rmass(id7)*r8_12(i1,i2).d(2,jut)
      cz1=p812q*r8_12(i1,i2).d(1,jut)+rmass(id7)*r8_12(i1,i2).c(
     & 1,jut)
      cz2=p812q*r8_12(i1,i2).d(2,jut)+rmass(id7)*r8_12(i1,i2).c(
     & 2,jut)
      clinetfz(i1,i2,mu).a(1,jut)=clinetfz(i1,i2,mu).a(1,jut)+lf
     & 7_812(mu).a(1,1)*cx1+lf7_812(mu).c(1,2)*cy2
      clinetfz(i1,i2,mu).b(1,jut)=clinetfz(i1,i2,mu).b(1,jut)+lf
     & 7_812(mu).d(1,1)*cy1+lf7_812(mu).b(1,2)*cx2
      clinetfz(i1,i2,mu).c(1,jut)=clinetfz(i1,i2,mu).c(1,jut)+lf
     & 7_812(mu).a(1,1)*cw1+lf7_812(mu).c(1,2)*cz2
      clinetfz(i1,i2,mu).d(1,jut)=clinetfz(i1,i2,mu).d(1,jut)+lf
     & 7_812(mu).d(1,1)*cz1+lf7_812(mu).b(1,2)*cw2
      clinetfz(i1,i2,mu).a(2,jut)=clinetfz(i1,i2,mu).a(2,jut)+lf
     & 7_812(mu).c(2,1)*cy1+lf7_812(mu).a(2,2)*cx2
      clinetfz(i1,i2,mu).b(2,jut)=clinetfz(i1,i2,mu).b(2,jut)+lf
     & 7_812(mu).b(2,1)*cx1+lf7_812(mu).d(2,2)*cy2
      clinetfz(i1,i2,mu).c(2,jut)=clinetfz(i1,i2,mu).c(2,jut)+lf
     & 7_812(mu).c(2,1)*cz1+lf7_812(mu).a(2,2)*cw2
      clinetfz(i1,i2,mu).d(2,jut)=clinetfz(i1,i2,mu).d(2,jut)+lf
     & 7_812(mu).b(2,1)*cw1+lf7_812(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id7)
      rmassr=-rmass(id8)
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* mline -- res=cf1278(i1,i2,&1,&2,mu),abcd=clinetfz(i1,i2,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      cf1278(i1,i2,iut,jut,mu)=cf1278(i1,i2,iut,jut,mu)+clinetfz
     & (i1,i2,mu).a(iut,jut)+rmassl*clinetfz(i1,i2,mu).b(iut,jut
     & )+rmassr*clinetfz(i1,i2,mu).c(iut,jut)+rmassl*rmassr*clin
     & etfz(i1,i2,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i5=1,2
      do i6=1,2
      do mu=0,3
* TsT -- aa=clinetfz(i5,i6,mu).a,bb=clinetfz(i5,i6,mu).b,cc=clinetfz(i5,
* i6,mu).c,dd=clinetfz(i5,i6,mu).d,a1=l3_56(i5,i6).a,b1=l3_56(i5,i6).b,c
* 1=l3_56(i5,i6).c,d1=l3_56(i5,i6).d,a2=rf4_356(mu).a,b2=rf4_356(mu).b,c
* 2=rf4_356(mu).c,d2=rf4_356(mu).d,prq=p356q,m=rmass(id3),nsum=0
      do iut=1,2
      cx1=l3_56(i5,i6).a(iut,1)+l3_56(i5,i6).c(iut,1)*rmass(id3)
      cx2=l3_56(i5,i6).c(iut,2)*p356q+l3_56(i5,i6).a(iut,2)*rmas
     & s(id3)
      cy1=l3_56(i5,i6).b(iut,1)+l3_56(i5,i6).d(iut,1)*rmass(id3)
      cy2=l3_56(i5,i6).d(iut,2)*p356q+l3_56(i5,i6).b(iut,2)*rmas
     & s(id3)
      cw1=l3_56(i5,i6).c(iut,1)*p356q+l3_56(i5,i6).a(iut,1)*rmas
     & s(id3)
      cw2=l3_56(i5,i6).a(iut,2)+l3_56(i5,i6).c(iut,2)*rmass(id3)
      cz1=l3_56(i5,i6).d(iut,1)*p356q+l3_56(i5,i6).b(iut,1)*rmas
     & s(id3)
      cz2=l3_56(i5,i6).b(iut,2)+l3_56(i5,i6).d(iut,2)*rmass(id3)
      clinetfz(i5,i6,mu).a(iut,1)=cx1*rf4_356(mu).a(1,1)+cx2*rf4
     & _356(mu).b(2,1)
      clinetfz(i5,i6,mu).b(iut,1)=cy1*rf4_356(mu).a(1,1)+cy2*rf4
     & _356(mu).b(2,1)
      clinetfz(i5,i6,mu).c(iut,1)=cw1*rf4_356(mu).d(1,1)+cw2*rf4
     & _356(mu).c(2,1)
      clinetfz(i5,i6,mu).d(iut,1)=cz1*rf4_356(mu).d(1,1)+cz2*rf4
     & _356(mu).c(2,1)
      clinetfz(i5,i6,mu).a(iut,2)=cw1*rf4_356(mu).b(1,2)+cw2*rf4
     & _356(mu).a(2,2)
      clinetfz(i5,i6,mu).b(iut,2)=cz1*rf4_356(mu).b(1,2)+cz2*rf4
     & _356(mu).a(2,2)
      clinetfz(i5,i6,mu).c(iut,2)=cx1*rf4_356(mu).c(1,2)+cx2*rf4
     & _356(mu).d(2,2)
      clinetfz(i5,i6,mu).d(iut,2)=cy1*rf4_356(mu).c(1,2)+cy2*rf4
     & _356(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i5=1,2
      do i6=1,2
      do mu=0,3
* TTs -- aa=clinetfz(i5,i6,mu).a,bb=clinetfz(i5,i6,mu).b,cc=clinetfz(i5,
* i6,mu).c,dd=clinetfz(i5,i6,mu).d,a1=lf3_456(mu).a,b1=lf3_456(mu).b,c1=
* lf3_456(mu).c,d1=lf3_456(mu).d,a2=r4_56(i5,i6).a,b2=r4_56(i5,i6).b,c2=
* r4_56(i5,i6).c,d2=r4_56(i5,i6).d,prq=p456q,m=rmass(id3),nsum=1
      do jut=1,2
      cx1=r4_56(i5,i6).a(1,jut)+rmass(id3)*r4_56(i5,i6).b(1,jut)
      cx2=r4_56(i5,i6).a(2,jut)+rmass(id3)*r4_56(i5,i6).b(2,jut)
      cy1=p456q*r4_56(i5,i6).b(1,jut)+rmass(id3)*r4_56(i5,i6).a(
     & 1,jut)
      cy2=p456q*r4_56(i5,i6).b(2,jut)+rmass(id3)*r4_56(i5,i6).a(
     & 2,jut)
      cw1=r4_56(i5,i6).c(1,jut)+rmass(id3)*r4_56(i5,i6).d(1,jut)
      cw2=r4_56(i5,i6).c(2,jut)+rmass(id3)*r4_56(i5,i6).d(2,jut)
      cz1=p456q*r4_56(i5,i6).d(1,jut)+rmass(id3)*r4_56(i5,i6).c(
     & 1,jut)
      cz2=p456q*r4_56(i5,i6).d(2,jut)+rmass(id3)*r4_56(i5,i6).c(
     & 2,jut)
      clinetfz(i5,i6,mu).a(1,jut)=clinetfz(i5,i6,mu).a(1,jut)+lf
     & 3_456(mu).a(1,1)*cx1+lf3_456(mu).c(1,2)*cy2
      clinetfz(i5,i6,mu).b(1,jut)=clinetfz(i5,i6,mu).b(1,jut)+lf
     & 3_456(mu).d(1,1)*cy1+lf3_456(mu).b(1,2)*cx2
      clinetfz(i5,i6,mu).c(1,jut)=clinetfz(i5,i6,mu).c(1,jut)+lf
     & 3_456(mu).a(1,1)*cw1+lf3_456(mu).c(1,2)*cz2
      clinetfz(i5,i6,mu).d(1,jut)=clinetfz(i5,i6,mu).d(1,jut)+lf
     & 3_456(mu).d(1,1)*cz1+lf3_456(mu).b(1,2)*cw2
      clinetfz(i5,i6,mu).a(2,jut)=clinetfz(i5,i6,mu).a(2,jut)+lf
     & 3_456(mu).c(2,1)*cy1+lf3_456(mu).a(2,2)*cx2
      clinetfz(i5,i6,mu).b(2,jut)=clinetfz(i5,i6,mu).b(2,jut)+lf
     & 3_456(mu).b(2,1)*cx1+lf3_456(mu).d(2,2)*cy2
      clinetfz(i5,i6,mu).c(2,jut)=clinetfz(i5,i6,mu).c(2,jut)+lf
     & 3_456(mu).c(2,1)*cz1+lf3_456(mu).a(2,2)*cw2
      clinetfz(i5,i6,mu).d(2,jut)=clinetfz(i5,i6,mu).d(2,jut)+lf
     & 3_456(mu).b(2,1)*cw1+lf3_456(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id3)
      rmassr=-rmass(id4)
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* mline -- res=cf3456(&1,&2,i3,i4,mu),abcd=clinetfz(i3,i4,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      cf3456(iut,jut,i3,i4,mu)=clinetfz(i3,i4,mu).a(iut,jut)+rma
     & ssl*clinetfz(i3,i4,mu).b(iut,jut)+rmassr*clinetfz(i3,i4,m
     & u).c(iut,jut)+rmassl*rmassr*clinetfz(i3,i4,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
  
*    First all diagrams of the type                                     
*                                                                       
*                 |_Z,f,h__/                        |_Z,f,h__/          
*       (mu) _Z___|        \    and    (mu) _gamma__|        \          
*                 |                                 |                   
  
* Use tst because Z,f,h correspond to ts                                
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* TsT -- aa=clinetfz(i3,i4,mu).a,bb=clinetfz(i3,i4,mu).b,cc=clinetfz(i3,
* i4,mu).c,dd=clinetfz(i3,i4,mu).d,a1=l5_34(i3,i4).a,b1=l5_34(i3,i4).b,c
* 1=l5_34(i3,i4).c,d1=l5_34(i3,i4).d,a2=rf6_534(mu).a,b2=rf6_534(mu).b,c
* 2=rf6_534(mu).c,d2=rf6_534(mu).d,prq=p534q,m=rmass(id5),nsum=0
      do iut=1,2
      cx1=l5_34(i3,i4).a(iut,1)+l5_34(i3,i4).c(iut,1)*rmass(id5)
      cx2=l5_34(i3,i4).c(iut,2)*p534q+l5_34(i3,i4).a(iut,2)*rmas
     & s(id5)
      cy1=l5_34(i3,i4).b(iut,1)+l5_34(i3,i4).d(iut,1)*rmass(id5)
      cy2=l5_34(i3,i4).d(iut,2)*p534q+l5_34(i3,i4).b(iut,2)*rmas
     & s(id5)
      cw1=l5_34(i3,i4).c(iut,1)*p534q+l5_34(i3,i4).a(iut,1)*rmas
     & s(id5)
      cw2=l5_34(i3,i4).a(iut,2)+l5_34(i3,i4).c(iut,2)*rmass(id5)
      cz1=l5_34(i3,i4).d(iut,1)*p534q+l5_34(i3,i4).b(iut,1)*rmas
     & s(id5)
      cz2=l5_34(i3,i4).b(iut,2)+l5_34(i3,i4).d(iut,2)*rmass(id5)
      clinetfz(i3,i4,mu).a(iut,1)=cx1*rf6_534(mu).a(1,1)+cx2*rf6
     & _534(mu).b(2,1)
      clinetfz(i3,i4,mu).b(iut,1)=cy1*rf6_534(mu).a(1,1)+cy2*rf6
     & _534(mu).b(2,1)
      clinetfz(i3,i4,mu).c(iut,1)=cw1*rf6_534(mu).d(1,1)+cw2*rf6
     & _534(mu).c(2,1)
      clinetfz(i3,i4,mu).d(iut,1)=cz1*rf6_534(mu).d(1,1)+cz2*rf6
     & _534(mu).c(2,1)
      clinetfz(i3,i4,mu).a(iut,2)=cw1*rf6_534(mu).b(1,2)+cw2*rf6
     & _534(mu).a(2,2)
      clinetfz(i3,i4,mu).b(iut,2)=cz1*rf6_534(mu).b(1,2)+cz2*rf6
     & _534(mu).a(2,2)
      clinetfz(i3,i4,mu).c(iut,2)=cx1*rf6_534(mu).c(1,2)+cx2*rf6
     & _534(mu).d(2,2)
      clinetfz(i3,i4,mu).d(iut,2)=cy1*rf6_534(mu).c(1,2)+cy2*rf6
     & _534(mu).d(2,2)
      end do
      end do
      end do
      end do
  
*    Then those of the type                                             
*                                                                       
*       (mu) _Z___|                      (mu) _f__|                     
*                 |_Z,f,h__/     and              |_Z,f,h__/            
*                 |        \                      |        \            
*                                                                       
* Use tts because Z,f,h correspond to ts                                
  
  
      do i3=1,2
      do i4=1,2
      do mu=0,3
* TTs -- aa=clinetfz(i3,i4,mu).a,bb=clinetfz(i3,i4,mu).b,cc=clinetfz(i3,
* i4,mu).c,dd=clinetfz(i3,i4,mu).d,a1=lf5_634(mu).a,b1=lf5_634(mu).b,c1=
* lf5_634(mu).c,d1=lf5_634(mu).d,a2=r6_34(i3,i4).a,b2=r6_34(i3,i4).b,c2=
* r6_34(i3,i4).c,d2=r6_34(i3,i4).d,prq=p634q,m=rmass(id5),nsum=1
      do jut=1,2
      cx1=r6_34(i3,i4).a(1,jut)+rmass(id5)*r6_34(i3,i4).b(1,jut)
      cx2=r6_34(i3,i4).a(2,jut)+rmass(id5)*r6_34(i3,i4).b(2,jut)
      cy1=p634q*r6_34(i3,i4).b(1,jut)+rmass(id5)*r6_34(i3,i4).a(
     & 1,jut)
      cy2=p634q*r6_34(i3,i4).b(2,jut)+rmass(id5)*r6_34(i3,i4).a(
     & 2,jut)
      cw1=r6_34(i3,i4).c(1,jut)+rmass(id5)*r6_34(i3,i4).d(1,jut)
      cw2=r6_34(i3,i4).c(2,jut)+rmass(id5)*r6_34(i3,i4).d(2,jut)
      cz1=p634q*r6_34(i3,i4).d(1,jut)+rmass(id5)*r6_34(i3,i4).c(
     & 1,jut)
      cz2=p634q*r6_34(i3,i4).d(2,jut)+rmass(id5)*r6_34(i3,i4).c(
     & 2,jut)
      clinetfz(i3,i4,mu).a(1,jut)=clinetfz(i3,i4,mu).a(1,jut)+lf
     & 5_634(mu).a(1,1)*cx1+lf5_634(mu).c(1,2)*cy2
      clinetfz(i3,i4,mu).b(1,jut)=clinetfz(i3,i4,mu).b(1,jut)+lf
     & 5_634(mu).d(1,1)*cy1+lf5_634(mu).b(1,2)*cx2
      clinetfz(i3,i4,mu).c(1,jut)=clinetfz(i3,i4,mu).c(1,jut)+lf
     & 5_634(mu).a(1,1)*cw1+lf5_634(mu).c(1,2)*cz2
      clinetfz(i3,i4,mu).d(1,jut)=clinetfz(i3,i4,mu).d(1,jut)+lf
     & 5_634(mu).d(1,1)*cz1+lf5_634(mu).b(1,2)*cw2
      clinetfz(i3,i4,mu).a(2,jut)=clinetfz(i3,i4,mu).a(2,jut)+lf
     & 5_634(mu).c(2,1)*cy1+lf5_634(mu).a(2,2)*cx2
      clinetfz(i3,i4,mu).b(2,jut)=clinetfz(i3,i4,mu).b(2,jut)+lf
     & 5_634(mu).b(2,1)*cx1+lf5_634(mu).d(2,2)*cy2
      clinetfz(i3,i4,mu).c(2,jut)=clinetfz(i3,i4,mu).c(2,jut)+lf
     & 5_634(mu).c(2,1)*cz1+lf5_634(mu).a(2,2)*cw2
      clinetfz(i3,i4,mu).d(2,jut)=clinetfz(i3,i4,mu).d(2,jut)+lf
     & 5_634(mu).b(2,1)*cw1+lf5_634(mu).d(2,2)*cz2
      end do
      end do
      end do
      end do
  
      rmassl=rmass(id5)
      rmassr=-rmass(id6)
  
  
      do i1=1,2
      do i2=1,2
      do mu=0,3
* mline -- res=cf3456(i1,i2,&1,&2,mu),abcd=clinetfz(i1,i2,mu).,m1=rmassl
* ,m2=rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      cf3456(i1,i2,iut,jut,mu)=cf3456(i1,i2,iut,jut,mu)+clinetfz
     & (i1,i2,mu).a(iut,jut)+rmassl*clinetfz(i1,i2,mu).b(iut,jut
     & )+rmassr*clinetfz(i1,i2,mu).c(iut,jut)+rmassl*rmassr*clin
     & etfz(i1,i2,mu).d(iut,jut)
      enddo
      enddo
      end do
      end do
      end do
  
*    Then those with triple vertex                                      
*                                                                       
*                    /_                                                 
*                  Z/                                                   
*         (mu)_Z___/                                                    
*                  \                                                    
*                  h\_                                                  
*                    \                                                  
*                                                                       
  
  
* rmh < 0 in our convention means no higgs coupling                     
      if(id1.eq.5.and.rmh.ge.0.d0) then
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                do mu =0,3
                  cz1234(i1,i2,i3,i4,mu)= cz1234(i1,i2,i3,i4,mu)
     &             +ch12(i1,i2)*cz34(i3,i4).e(mu)
     &             *(rhzz*rhbb/(s12-cmh2)+rhhzz*rhhbb/(s12-cmhh2))
                enddo
              enddo
            enddo
          enddo
        enddo
      endif
  
* rmh < 0 in our convention means no higgs coupling                     
      if(id3.eq.5.and.rmh.ge.0.d0) then
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                do mu =0,3
                  cz1234(i1,i2,i3,i4,mu)= cz1234(i1,i2,i3,i4,mu)
     &             +ch34(i3,i4)*cz12(i1,i2).e(mu)
     &             *(rhzz*rhbb/(s34-cmh2)+rhhzz*rhhbb/(s34-cmhh2))
                enddo
              enddo
            enddo
          enddo
        enddo
      endif
  
* rmh < 0 in our convention means no higgs coupling                     
      if(id5.eq.5.and.rmh.ge.0.d0) then
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                do mu =0,3
                  cz5678(i1,i2,i3,i4,mu)= cz5678(i1,i2,i3,i4,mu)
     &             +ch56(i1,i2)*cz78(i3,i4).e(mu)
     &             *(rhzz*rhbb/(s56-cmh2)+rhhzz*rhhbb/(s56-cmhh2))
                enddo
              enddo
            enddo
          enddo
        enddo
      endif
  
* rmh < 0 in our convention means no higgs coupling                     
      if(id7.eq.5.and.rmh.ge.0.d0) then
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                do mu =0,3
                  cz5678(i1,i2,i3,i4,mu)= cz5678(i1,i2,i3,i4,mu)
     &             +ch78(i3,i4)*cz56(i1,i2).e(mu)
     &             *(rhzz*rhbb/(s78-cmh2)+rhhzz*rhhbb/(s78-cmhh2))
                enddo
              enddo
            enddo
          enddo
        enddo
      endif
  
* rmh < 0 in our convention means no higgs coupling                     
      if(id1.eq.5.and.rmh.ge.0.d0) then
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                do mu =0,3
                  cz1256(i1,i2,i3,i4,mu)= cz1256(i1,i2,i3,i4,mu)
     &             +ch12(i1,i2)*cz56(i3,i4).e(mu)
     &             *(rhzz*rhbb/(s12-cmh2)+rhhzz*rhhbb/(s12-cmhh2))
                enddo
              enddo
            enddo
          enddo
        enddo
      endif
  
* rmh < 0 in our convention means no higgs coupling                     
      if(id5.eq.5.and.rmh.ge.0.d0) then
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                do mu =0,3
                  cz1256(i1,i2,i3,i4,mu)= cz1256(i1,i2,i3,i4,mu)
     &             +ch56(i3,i4)*cz12(i1,i2).e(mu)
     &             *(rhzz*rhbb/(s56-cmh2)+rhhzz*rhhbb/(s56-cmhh2))
                enddo
              enddo
            enddo
          enddo
        enddo
      endif
  
* rmh < 0 in our convention means no higgs coupling                     
      if(id3.eq.5.and.rmh.ge.0.d0) then
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                do mu =0,3
                  cz3478(i1,i2,i3,i4,mu)= cz3478(i1,i2,i3,i4,mu)
     &             +ch34(i1,i2)*cz78(i3,i4).e(mu)
     &             *(rhzz*rhbb/(s34-cmh2)+rhhzz*rhhbb/(s34-cmhh2))
                enddo
              enddo
            enddo
          enddo
        enddo
      endif
  
* rmh < 0 in our convention means no higgs coupling                     
      if(id7.eq.5.and.rmh.ge.0.d0) then
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                do mu =0,3
                  cz3478(i1,i2,i3,i4,mu)= cz3478(i1,i2,i3,i4,mu)
     &             +ch78(i3,i4)*cz34(i1,i2).e(mu)
     &             *(rhzz*rhbb/(s78-cmh2)+rhhzz*rhhbb/(s78-cmhh2))
                enddo
              enddo
            enddo
          enddo
        enddo
      endif
  
* rmh < 0 in our convention means no higgs coupling                     
      if(id1.eq.5.and.rmh.ge.0.d0) then
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                do mu =0,3
                  cz1278(i1,i2,i3,i4,mu)= cz1278(i1,i2,i3,i4,mu)
     &             +ch12(i1,i2)*cz78(i3,i4).e(mu)
     &             *(rhzz*rhbb/(s12-cmh2)+rhhzz*rhhbb/(s12-cmhh2))
                enddo
              enddo
            enddo
          enddo
        enddo
      endif
  
* rmh < 0 in our convention means no higgs coupling                     
      if(id7.eq.5.and.rmh.ge.0.d0) then
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                do mu =0,3
                  cz1278(i1,i2,i3,i4,mu)= cz1278(i1,i2,i3,i4,mu)
     &             +ch78(i3,i4)*cz12(i1,i2).e(mu)
     &             *(rhzz*rhbb/(s78-cmh2)+rhhzz*rhhbb/(s78-cmhh2))
                enddo
              enddo
            enddo
          enddo
        enddo
      endif
  
* rmh < 0 in our convention means no higgs coupling                     
      if(id3.eq.5.and.rmh.ge.0.d0) then
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                do mu =0,3
                  cz3456(i1,i2,i3,i4,mu)= cz3456(i1,i2,i3,i4,mu)
     &             +ch34(i1,i2)*cz56(i3,i4).e(mu)
     &             *(rhzz*rhbb/(s34-cmh2)+rhhzz*rhhbb/(s34-cmhh2))
                enddo
              enddo
            enddo
          enddo
        enddo
      endif
  
* rmh < 0 in our convention means no higgs coupling                     
      if(id5.eq.5.and.rmh.ge.0.d0) then
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                do mu =0,3
                  cz3456(i1,i2,i3,i4,mu)= cz3456(i1,i2,i3,i4,mu)
     &             +ch56(i3,i4)*cz34(i1,i2).e(mu)
     &             *(rhzz*rhbb/(s56-cmh2)+rhhzz*rhhbb/(s56-cmhh2))
                enddo
              enddo
            enddo
          enddo
        enddo
      endif
  
  
  
* COMPUTE ALL SUBDIAGRAMS WITH A HIGGS "DECAYING" TO 4 FERMIONS         
*  WHICH CORRESPOND TO TWO Z's                                          
*                                                                       
*                   _____ i                                             
*                  |  |__ j                                             
*             --h--|  |__ k                                             
*                  |__|__ l                                             
*                                                                       
*                  ch1234(i1,i2,i3,i4) con t aux clineth(2,2)           
*INITIALIZATION                                                         
  
      do i1=1,2
        do i2=1,2
          do i3=1,2
            do i4=1,2
              ch1234(i1,i2,i3,i4)=czero
              ch1256(i1,i2,i3,i4)=czero
   	      ch1278(i1,i2,i3,i4)=czero
              ch5678(i1,i2,i3,i4)=czero
              ch3478(i1,i2,i3,i4)=czero	
              ch3456(i1,i2,i3,i4)=czero
              chh1234(i1,i2,i3,i4)=czero
              chh1256(i1,i2,i3,i4)=czero
   	      chh1278(i1,i2,i3,i4)=czero
              chh5678(i1,i2,i3,i4)=czero
              chh3478(i1,i2,i3,i4)=czero	
              chh3456(i1,i2,i3,i4)=czero
            enddo
          enddo
        enddo
      enddo
  
*                                                                       
*    First all diagrams of the type                                     
*                                                                       
*                   |_Z,f,h__/                                          
*              _h___|        \                                          
*                   |                                                   
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id1.eq.5.and.rmh.ge.0.d0) then
      do i3=1,2
      do i4=1,2
* TsTSC -- aa=clineth_4f(i3,i4).a,bb=clineth_4f(i3,i4).b,cc=clineth_4f(i
* 3,i4).c,dd=clineth_4f(i3,i4).d,a1=l1_34(i3,i4).a,b1=l1_34(i3,i4).b,c1=
* l1_34(i3,i4).c,d1=l1_34(i3,i4).d,a2=rh2_134.a,b2=rh2_134.b,c2=rh2_134.
* c,prq=p134q,m=rmass(id1),nsum=0
      do iut=1,2
      cx1=l1_34(i3,i4).a(iut,1)+l1_34(i3,i4).c(iut,1)*rmass(id1)
      cx2=l1_34(i3,i4).c(iut,2)*p134q+l1_34(i3,i4).a(iut,2)*rmas
     & s(id1)
      cy1=l1_34(i3,i4).b(iut,1)+l1_34(i3,i4).d(iut,1)*rmass(id1)
      cy2=l1_34(i3,i4).d(iut,2)*p134q+l1_34(i3,i4).b(iut,2)*rmas
     & s(id1)
      cw1=l1_34(i3,i4).c(iut,1)*p134q+l1_34(i3,i4).a(iut,1)*rmas
     & s(id1)
      cw2=l1_34(i3,i4).a(iut,2)+l1_34(i3,i4).c(iut,2)*rmass(id1)
      cz1=l1_34(i3,i4).d(iut,1)*p134q+l1_34(i3,i4).b(iut,1)*rmas
     & s(id1)
      cz2=l1_34(i3,i4).b(iut,2)+l1_34(i3,i4).d(iut,2)*rmass(id1)
      clineth_4f(i3,i4).a(iut,2)=cx1*rh2_134.a(1,2)+cx2*rh2_134.
     & b(2,2)
      clineth_4f(i3,i4).b(iut,2)=cy1*rh2_134.a(1,2)+cy2*rh2_134.
     & b(2,2)
      clineth_4f(i3,i4).c(iut,2)=cw2*rh2_134.c(2,2)
      clineth_4f(i3,i4).d(iut,2)=cz2*rh2_134.c(2,2)
      clineth_4f(i3,i4).a(iut,1)=cw1*rh2_134.b(1,1)+cw2*rh2_134.
     & a(2,1)
      clineth_4f(i3,i4).b(iut,1)=cz1*rh2_134.b(1,1)+cz2*rh2_134.
     & a(2,1)
      clineth_4f(i3,i4).c(iut,1)=cx1*rh2_134.c(1,1)
      clineth_4f(i3,i4).d(iut,1)=cy1*rh2_134.c(1,1)
      end do
      end do
      end do
  
  
*    Then those of the type                                             
*                                                                       
*              _h___|                                                   
*                   |_Z,f,h__/                                          
*                   |        \                                          
*                                                                       
  
      do i3=1,2
      do i4=1,2
* TSCTs -- aa=clineth_4f(i3,i4).a,bb=clineth_4f(i3,i4).b,cc=clineth_4f(i
* 3,i4).c,dd=clineth_4f(i3,i4).d,a1=lh1_234.a,b1=lh1_234.b,c1=lh1_234.c,
* a2=r2_34(i3,i4).a,b2=r2_34(i3,i4).b,c2=r2_34(i3,i4).c,d2=r2_34(i3,i4).
* d,prq=p234q,m=rmass(id1),nsum=1
      do jut=1,2
      cx1=r2_34(i3,i4).a(1,jut)+rmass(id1)*r2_34(i3,i4).b(1,jut)
      cx2=r2_34(i3,i4).a(2,jut)+rmass(id1)*r2_34(i3,i4).b(2,jut)
      cy1=p234q*r2_34(i3,i4).b(1,jut)+rmass(id1)*r2_34(i3,i4).a(
     & 1,jut)
      cy2=p234q*r2_34(i3,i4).b(2,jut)+rmass(id1)*r2_34(i3,i4).a(
     & 2,jut)
      cw1=r2_34(i3,i4).c(1,jut)+rmass(id1)*r2_34(i3,i4).d(1,jut)
      cw2=r2_34(i3,i4).c(2,jut)+rmass(id1)*r2_34(i3,i4).d(2,jut)
      cz1=p234q*r2_34(i3,i4).d(1,jut)+rmass(id1)*r2_34(i3,i4).c(
     & 1,jut)
      cz2=p234q*r2_34(i3,i4).d(2,jut)+rmass(id1)*r2_34(i3,i4).c(
     & 2,jut)
      clineth_4f(i3,i4).a(2,jut)=clineth_4f(i3,i4).a(2,jut)+lh1_
     & 234.a(2,1)*cx1+lh1_234.c(2,2)*cy2
      clineth_4f(i3,i4).b(2,jut)=clineth_4f(i3,i4).b(2,jut)+lh1_
     & 234.b(2,2)*cx2
      clineth_4f(i3,i4).c(2,jut)=clineth_4f(i3,i4).c(2,jut)+lh1_
     & 234.a(2,1)*cw1+lh1_234.c(2,2)*cz2
      clineth_4f(i3,i4).d(2,jut)=clineth_4f(i3,i4).d(2,jut)+lh1_
     & 234.b(2,2)*cw2
      clineth_4f(i3,i4).a(1,jut)=clineth_4f(i3,i4).a(1,jut)+lh1_
     & 234.c(1,1)*cy1+lh1_234.a(1,2)*cx2
      clineth_4f(i3,i4).b(1,jut)=clineth_4f(i3,i4).b(1,jut)+lh1_
     & 234.b(1,1)*cx1
      clineth_4f(i3,i4).c(1,jut)=clineth_4f(i3,i4).c(1,jut)+lh1_
     & 234.c(1,1)*cz1+lh1_234.a(1,2)*cw2
      clineth_4f(i3,i4).d(1,jut)=clineth_4f(i3,i4).d(1,jut)+lh1_
     & 234.b(1,1)*cw1
      end do
      end do
      end do
  
  
  
  
        rmassl=rmass(id1)
        rmassr=-rmassl
  
  
      do i3=1,2
      do i4=1,2
* mline -- res=ch1234(&1,&2,i3,i4),abcd=clineth_4f(i3,i4).,m1=rmassl,m2=
* rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      ch1234(iut,jut,i3,i4)=clineth_4f(i3,i4).a(iut,jut)+rmassl*
     & clineth_4f(i3,i4).b(iut,jut)+rmassr*clineth_4f(i3,i4).c(i
     & ut,jut)+rmassl*rmassr*clineth_4f(i3,i4).d(iut,jut)
      enddo
      enddo
      end do
      end do
  
  
  
  
      endif	
*                                                                       
*    First all diagrams of the type                                     
*                                                                       
*                   |_Z,f,h__/                                          
*              _h___|        \                                          
*                   |                                                   
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id3.eq.5.and.rmh.ge.0.d0) then
      do i1=1,2
      do i2=1,2
* TsTSC -- aa=clineth_4f(i1,i2).a,bb=clineth_4f(i1,i2).b,cc=clineth_4f(i
* 1,i2).c,dd=clineth_4f(i1,i2).d,a1=l3_12(i1,i2).a,b1=l3_12(i1,i2).b,c1=
* l3_12(i1,i2).c,d1=l3_12(i1,i2).d,a2=rh4_312.a,b2=rh4_312.b,c2=rh4_312.
* c,prq=p312q,m=rmass(id3),nsum=0
      do iut=1,2
      cx1=l3_12(i1,i2).a(iut,1)+l3_12(i1,i2).c(iut,1)*rmass(id3)
      cx2=l3_12(i1,i2).c(iut,2)*p312q+l3_12(i1,i2).a(iut,2)*rmas
     & s(id3)
      cy1=l3_12(i1,i2).b(iut,1)+l3_12(i1,i2).d(iut,1)*rmass(id3)
      cy2=l3_12(i1,i2).d(iut,2)*p312q+l3_12(i1,i2).b(iut,2)*rmas
     & s(id3)
      cw1=l3_12(i1,i2).c(iut,1)*p312q+l3_12(i1,i2).a(iut,1)*rmas
     & s(id3)
      cw2=l3_12(i1,i2).a(iut,2)+l3_12(i1,i2).c(iut,2)*rmass(id3)
      cz1=l3_12(i1,i2).d(iut,1)*p312q+l3_12(i1,i2).b(iut,1)*rmas
     & s(id3)
      cz2=l3_12(i1,i2).b(iut,2)+l3_12(i1,i2).d(iut,2)*rmass(id3)
      clineth_4f(i1,i2).a(iut,2)=cx1*rh4_312.a(1,2)+cx2*rh4_312.
     & b(2,2)
      clineth_4f(i1,i2).b(iut,2)=cy1*rh4_312.a(1,2)+cy2*rh4_312.
     & b(2,2)
      clineth_4f(i1,i2).c(iut,2)=cw2*rh4_312.c(2,2)
      clineth_4f(i1,i2).d(iut,2)=cz2*rh4_312.c(2,2)
      clineth_4f(i1,i2).a(iut,1)=cw1*rh4_312.b(1,1)+cw2*rh4_312.
     & a(2,1)
      clineth_4f(i1,i2).b(iut,1)=cz1*rh4_312.b(1,1)+cz2*rh4_312.
     & a(2,1)
      clineth_4f(i1,i2).c(iut,1)=cx1*rh4_312.c(1,1)
      clineth_4f(i1,i2).d(iut,1)=cy1*rh4_312.c(1,1)
      end do
      end do
      end do
  
  
*    Then those of the type                                             
*                                                                       
*              _h___|                                                   
*                   |_Z,f,h__/                                          
*                   |        \                                          
*                                                                       
  
      do i1=1,2
      do i2=1,2
* TSCTs -- aa=clineth_4f(i1,i2).a,bb=clineth_4f(i1,i2).b,cc=clineth_4f(i
* 1,i2).c,dd=clineth_4f(i1,i2).d,a1=lh3_412.a,b1=lh3_412.b,c1=lh3_412.c,
* a2=r4_12(i1,i2).a,b2=r4_12(i1,i2).b,c2=r4_12(i1,i2).c,d2=r4_12(i1,i2).
* d,prq=p412q,m=rmass(id3),nsum=1
      do jut=1,2
      cx1=r4_12(i1,i2).a(1,jut)+rmass(id3)*r4_12(i1,i2).b(1,jut)
      cx2=r4_12(i1,i2).a(2,jut)+rmass(id3)*r4_12(i1,i2).b(2,jut)
      cy1=p412q*r4_12(i1,i2).b(1,jut)+rmass(id3)*r4_12(i1,i2).a(
     & 1,jut)
      cy2=p412q*r4_12(i1,i2).b(2,jut)+rmass(id3)*r4_12(i1,i2).a(
     & 2,jut)
      cw1=r4_12(i1,i2).c(1,jut)+rmass(id3)*r4_12(i1,i2).d(1,jut)
      cw2=r4_12(i1,i2).c(2,jut)+rmass(id3)*r4_12(i1,i2).d(2,jut)
      cz1=p412q*r4_12(i1,i2).d(1,jut)+rmass(id3)*r4_12(i1,i2).c(
     & 1,jut)
      cz2=p412q*r4_12(i1,i2).d(2,jut)+rmass(id3)*r4_12(i1,i2).c(
     & 2,jut)
      clineth_4f(i1,i2).a(2,jut)=clineth_4f(i1,i2).a(2,jut)+lh3_
     & 412.a(2,1)*cx1+lh3_412.c(2,2)*cy2
      clineth_4f(i1,i2).b(2,jut)=clineth_4f(i1,i2).b(2,jut)+lh3_
     & 412.b(2,2)*cx2
      clineth_4f(i1,i2).c(2,jut)=clineth_4f(i1,i2).c(2,jut)+lh3_
     & 412.a(2,1)*cw1+lh3_412.c(2,2)*cz2
      clineth_4f(i1,i2).d(2,jut)=clineth_4f(i1,i2).d(2,jut)+lh3_
     & 412.b(2,2)*cw2
      clineth_4f(i1,i2).a(1,jut)=clineth_4f(i1,i2).a(1,jut)+lh3_
     & 412.c(1,1)*cy1+lh3_412.a(1,2)*cx2
      clineth_4f(i1,i2).b(1,jut)=clineth_4f(i1,i2).b(1,jut)+lh3_
     & 412.b(1,1)*cx1
      clineth_4f(i1,i2).c(1,jut)=clineth_4f(i1,i2).c(1,jut)+lh3_
     & 412.c(1,1)*cz1+lh3_412.a(1,2)*cw2
      clineth_4f(i1,i2).d(1,jut)=clineth_4f(i1,i2).d(1,jut)+lh3_
     & 412.b(1,1)*cw1
      end do
      end do
      end do
  
  
  
  
        rmassl=rmass(id3)
        rmassr=-rmassl
  
  
  
  
      do i1=1,2
      do i2=1,2
* mline -- res=ch1234(i1,i2,&1,&2),abcd=clineth_4f(i1,i2).,m1=rmassl,m2=
* rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      ch1234(i1,i2,iut,jut)=ch1234(i1,i2,iut,jut)+clineth_4f(i1,
     & i2).a(iut,jut)+rmassl*clineth_4f(i1,i2).b(iut,jut)+rmassr
     & *clineth_4f(i1,i2).c(iut,jut)+rmassl*rmassr*clineth_4f(i1
     & ,i2).d(iut,jut)
      enddo
      enddo
      end do
      end do
  
  
      endif	
*                                                                       
*    First all diagrams of the type                                     
*                                                                       
*                   |_Z,f,h__/                                          
*              _h___|        \                                          
*                   |                                                   
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id5.eq.5.and.rmh.ge.0.d0) then
      do i7=1,2
      do i8=1,2
* TsTSC -- aa=clineth_4f(i7,i8).a,bb=clineth_4f(i7,i8).b,cc=clineth_4f(i
* 7,i8).c,dd=clineth_4f(i7,i8).d,a1=l5_78(i7,i8).a,b1=l5_78(i7,i8).b,c1=
* l5_78(i7,i8).c,d1=l5_78(i7,i8).d,a2=rh6_578.a,b2=rh6_578.b,c2=rh6_578.
* c,prq=p578q,m=rmass(id5),nsum=0
      do iut=1,2
      cx1=l5_78(i7,i8).a(iut,1)+l5_78(i7,i8).c(iut,1)*rmass(id5)
      cx2=l5_78(i7,i8).c(iut,2)*p578q+l5_78(i7,i8).a(iut,2)*rmas
     & s(id5)
      cy1=l5_78(i7,i8).b(iut,1)+l5_78(i7,i8).d(iut,1)*rmass(id5)
      cy2=l5_78(i7,i8).d(iut,2)*p578q+l5_78(i7,i8).b(iut,2)*rmas
     & s(id5)
      cw1=l5_78(i7,i8).c(iut,1)*p578q+l5_78(i7,i8).a(iut,1)*rmas
     & s(id5)
      cw2=l5_78(i7,i8).a(iut,2)+l5_78(i7,i8).c(iut,2)*rmass(id5)
      cz1=l5_78(i7,i8).d(iut,1)*p578q+l5_78(i7,i8).b(iut,1)*rmas
     & s(id5)
      cz2=l5_78(i7,i8).b(iut,2)+l5_78(i7,i8).d(iut,2)*rmass(id5)
      clineth_4f(i7,i8).a(iut,2)=cx1*rh6_578.a(1,2)+cx2*rh6_578.
     & b(2,2)
      clineth_4f(i7,i8).b(iut,2)=cy1*rh6_578.a(1,2)+cy2*rh6_578.
     & b(2,2)
      clineth_4f(i7,i8).c(iut,2)=cw2*rh6_578.c(2,2)
      clineth_4f(i7,i8).d(iut,2)=cz2*rh6_578.c(2,2)
      clineth_4f(i7,i8).a(iut,1)=cw1*rh6_578.b(1,1)+cw2*rh6_578.
     & a(2,1)
      clineth_4f(i7,i8).b(iut,1)=cz1*rh6_578.b(1,1)+cz2*rh6_578.
     & a(2,1)
      clineth_4f(i7,i8).c(iut,1)=cx1*rh6_578.c(1,1)
      clineth_4f(i7,i8).d(iut,1)=cy1*rh6_578.c(1,1)
      end do
      end do
      end do
  
  
*    Then those of the type                                             
*                                                                       
*              _h___|                                                   
*                   |_Z,f,h__/                                          
*                   |        \                                          
*                                                                       
  
      do i7=1,2
      do i8=1,2
* TSCTs -- aa=clineth_4f(i7,i8).a,bb=clineth_4f(i7,i8).b,cc=clineth_4f(i
* 7,i8).c,dd=clineth_4f(i7,i8).d,a1=lh5_678.a,b1=lh5_678.b,c1=lh5_678.c,
* a2=r6_78(i7,i8).a,b2=r6_78(i7,i8).b,c2=r6_78(i7,i8).c,d2=r6_78(i7,i8).
* d,prq=p678q,m=rmass(id5),nsum=1
      do jut=1,2
      cx1=r6_78(i7,i8).a(1,jut)+rmass(id5)*r6_78(i7,i8).b(1,jut)
      cx2=r6_78(i7,i8).a(2,jut)+rmass(id5)*r6_78(i7,i8).b(2,jut)
      cy1=p678q*r6_78(i7,i8).b(1,jut)+rmass(id5)*r6_78(i7,i8).a(
     & 1,jut)
      cy2=p678q*r6_78(i7,i8).b(2,jut)+rmass(id5)*r6_78(i7,i8).a(
     & 2,jut)
      cw1=r6_78(i7,i8).c(1,jut)+rmass(id5)*r6_78(i7,i8).d(1,jut)
      cw2=r6_78(i7,i8).c(2,jut)+rmass(id5)*r6_78(i7,i8).d(2,jut)
      cz1=p678q*r6_78(i7,i8).d(1,jut)+rmass(id5)*r6_78(i7,i8).c(
     & 1,jut)
      cz2=p678q*r6_78(i7,i8).d(2,jut)+rmass(id5)*r6_78(i7,i8).c(
     & 2,jut)
      clineth_4f(i7,i8).a(2,jut)=clineth_4f(i7,i8).a(2,jut)+lh5_
     & 678.a(2,1)*cx1+lh5_678.c(2,2)*cy2
      clineth_4f(i7,i8).b(2,jut)=clineth_4f(i7,i8).b(2,jut)+lh5_
     & 678.b(2,2)*cx2
      clineth_4f(i7,i8).c(2,jut)=clineth_4f(i7,i8).c(2,jut)+lh5_
     & 678.a(2,1)*cw1+lh5_678.c(2,2)*cz2
      clineth_4f(i7,i8).d(2,jut)=clineth_4f(i7,i8).d(2,jut)+lh5_
     & 678.b(2,2)*cw2
      clineth_4f(i7,i8).a(1,jut)=clineth_4f(i7,i8).a(1,jut)+lh5_
     & 678.c(1,1)*cy1+lh5_678.a(1,2)*cx2
      clineth_4f(i7,i8).b(1,jut)=clineth_4f(i7,i8).b(1,jut)+lh5_
     & 678.b(1,1)*cx1
      clineth_4f(i7,i8).c(1,jut)=clineth_4f(i7,i8).c(1,jut)+lh5_
     & 678.c(1,1)*cz1+lh5_678.a(1,2)*cw2
      clineth_4f(i7,i8).d(1,jut)=clineth_4f(i7,i8).d(1,jut)+lh5_
     & 678.b(1,1)*cw1
      end do
      end do
      end do
  
  
  
  
        rmassl=rmass(id5)
        rmassr=-rmassl
  
  
      do i3=1,2
      do i4=1,2
* mline -- res=ch5678(&1,&2,i3,i4),abcd=clineth_4f(i3,i4).,m1=rmassl,m2=
* rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      ch5678(iut,jut,i3,i4)=clineth_4f(i3,i4).a(iut,jut)+rmassl*
     & clineth_4f(i3,i4).b(iut,jut)+rmassr*clineth_4f(i3,i4).c(i
     & ut,jut)+rmassl*rmassr*clineth_4f(i3,i4).d(iut,jut)
      enddo
      enddo
      end do
      end do
  
  
  
  
      endif	
*                                                                       
*    First all diagrams of the type                                     
*                                                                       
*                   |_Z,f,h__/                                          
*              _h___|        \                                          
*                   |                                                   
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id7.eq.5.and.rmh.ge.0.d0) then
      do i5=1,2
      do i6=1,2
* TsTSC -- aa=clineth_4f(i5,i6).a,bb=clineth_4f(i5,i6).b,cc=clineth_4f(i
* 5,i6).c,dd=clineth_4f(i5,i6).d,a1=l7_56(i5,i6).a,b1=l7_56(i5,i6).b,c1=
* l7_56(i5,i6).c,d1=l7_56(i5,i6).d,a2=rh8_756.a,b2=rh8_756.b,c2=rh8_756.
* c,prq=p756q,m=rmass(id7),nsum=0
      do iut=1,2
      cx1=l7_56(i5,i6).a(iut,1)+l7_56(i5,i6).c(iut,1)*rmass(id7)
      cx2=l7_56(i5,i6).c(iut,2)*p756q+l7_56(i5,i6).a(iut,2)*rmas
     & s(id7)
      cy1=l7_56(i5,i6).b(iut,1)+l7_56(i5,i6).d(iut,1)*rmass(id7)
      cy2=l7_56(i5,i6).d(iut,2)*p756q+l7_56(i5,i6).b(iut,2)*rmas
     & s(id7)
      cw1=l7_56(i5,i6).c(iut,1)*p756q+l7_56(i5,i6).a(iut,1)*rmas
     & s(id7)
      cw2=l7_56(i5,i6).a(iut,2)+l7_56(i5,i6).c(iut,2)*rmass(id7)
      cz1=l7_56(i5,i6).d(iut,1)*p756q+l7_56(i5,i6).b(iut,1)*rmas
     & s(id7)
      cz2=l7_56(i5,i6).b(iut,2)+l7_56(i5,i6).d(iut,2)*rmass(id7)
      clineth_4f(i5,i6).a(iut,2)=cx1*rh8_756.a(1,2)+cx2*rh8_756.
     & b(2,2)
      clineth_4f(i5,i6).b(iut,2)=cy1*rh8_756.a(1,2)+cy2*rh8_756.
     & b(2,2)
      clineth_4f(i5,i6).c(iut,2)=cw2*rh8_756.c(2,2)
      clineth_4f(i5,i6).d(iut,2)=cz2*rh8_756.c(2,2)
      clineth_4f(i5,i6).a(iut,1)=cw1*rh8_756.b(1,1)+cw2*rh8_756.
     & a(2,1)
      clineth_4f(i5,i6).b(iut,1)=cz1*rh8_756.b(1,1)+cz2*rh8_756.
     & a(2,1)
      clineth_4f(i5,i6).c(iut,1)=cx1*rh8_756.c(1,1)
      clineth_4f(i5,i6).d(iut,1)=cy1*rh8_756.c(1,1)
      end do
      end do
      end do
  
  
*    Then those of the type                                             
*                                                                       
*              _h___|                                                   
*                   |_Z,f,h__/                                          
*                   |        \                                          
*                                                                       
  
      do i5=1,2
      do i6=1,2
* TSCTs -- aa=clineth_4f(i5,i6).a,bb=clineth_4f(i5,i6).b,cc=clineth_4f(i
* 5,i6).c,dd=clineth_4f(i5,i6).d,a1=lh7_856.a,b1=lh7_856.b,c1=lh7_856.c,
* a2=r8_56(i5,i6).a,b2=r8_56(i5,i6).b,c2=r8_56(i5,i6).c,d2=r8_56(i5,i6).
* d,prq=p856q,m=rmass(id7),nsum=1
      do jut=1,2
      cx1=r8_56(i5,i6).a(1,jut)+rmass(id7)*r8_56(i5,i6).b(1,jut)
      cx2=r8_56(i5,i6).a(2,jut)+rmass(id7)*r8_56(i5,i6).b(2,jut)
      cy1=p856q*r8_56(i5,i6).b(1,jut)+rmass(id7)*r8_56(i5,i6).a(
     & 1,jut)
      cy2=p856q*r8_56(i5,i6).b(2,jut)+rmass(id7)*r8_56(i5,i6).a(
     & 2,jut)
      cw1=r8_56(i5,i6).c(1,jut)+rmass(id7)*r8_56(i5,i6).d(1,jut)
      cw2=r8_56(i5,i6).c(2,jut)+rmass(id7)*r8_56(i5,i6).d(2,jut)
      cz1=p856q*r8_56(i5,i6).d(1,jut)+rmass(id7)*r8_56(i5,i6).c(
     & 1,jut)
      cz2=p856q*r8_56(i5,i6).d(2,jut)+rmass(id7)*r8_56(i5,i6).c(
     & 2,jut)
      clineth_4f(i5,i6).a(2,jut)=clineth_4f(i5,i6).a(2,jut)+lh7_
     & 856.a(2,1)*cx1+lh7_856.c(2,2)*cy2
      clineth_4f(i5,i6).b(2,jut)=clineth_4f(i5,i6).b(2,jut)+lh7_
     & 856.b(2,2)*cx2
      clineth_4f(i5,i6).c(2,jut)=clineth_4f(i5,i6).c(2,jut)+lh7_
     & 856.a(2,1)*cw1+lh7_856.c(2,2)*cz2
      clineth_4f(i5,i6).d(2,jut)=clineth_4f(i5,i6).d(2,jut)+lh7_
     & 856.b(2,2)*cw2
      clineth_4f(i5,i6).a(1,jut)=clineth_4f(i5,i6).a(1,jut)+lh7_
     & 856.c(1,1)*cy1+lh7_856.a(1,2)*cx2
      clineth_4f(i5,i6).b(1,jut)=clineth_4f(i5,i6).b(1,jut)+lh7_
     & 856.b(1,1)*cx1
      clineth_4f(i5,i6).c(1,jut)=clineth_4f(i5,i6).c(1,jut)+lh7_
     & 856.c(1,1)*cz1+lh7_856.a(1,2)*cw2
      clineth_4f(i5,i6).d(1,jut)=clineth_4f(i5,i6).d(1,jut)+lh7_
     & 856.b(1,1)*cw1
      end do
      end do
      end do
  
  
  
  
        rmassl=rmass(id7)
        rmassr=-rmassl
  
  
  
  
      do i1=1,2
      do i2=1,2
* mline -- res=ch5678(i1,i2,&1,&2),abcd=clineth_4f(i1,i2).,m1=rmassl,m2=
* rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      ch5678(i1,i2,iut,jut)=ch5678(i1,i2,iut,jut)+clineth_4f(i1,
     & i2).a(iut,jut)+rmassl*clineth_4f(i1,i2).b(iut,jut)+rmassr
     & *clineth_4f(i1,i2).c(iut,jut)+rmassl*rmassr*clineth_4f(i1
     & ,i2).d(iut,jut)
      enddo
      enddo
      end do
      end do
  
  
      endif	
*                                                                       
*    First all diagrams of the type                                     
*                                                                       
*                   |_Z,f,h__/                                          
*              _h___|        \                                          
*                   |                                                   
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id1.eq.5.and.rmh.ge.0.d0) then
      do i5=1,2
      do i6=1,2
* TsTSC -- aa=clineth_4f(i5,i6).a,bb=clineth_4f(i5,i6).b,cc=clineth_4f(i
* 5,i6).c,dd=clineth_4f(i5,i6).d,a1=l1_56(i5,i6).a,b1=l1_56(i5,i6).b,c1=
* l1_56(i5,i6).c,d1=l1_56(i5,i6).d,a2=rh2_156.a,b2=rh2_156.b,c2=rh2_156.
* c,prq=p156q,m=rmass(id1),nsum=0
      do iut=1,2
      cx1=l1_56(i5,i6).a(iut,1)+l1_56(i5,i6).c(iut,1)*rmass(id1)
      cx2=l1_56(i5,i6).c(iut,2)*p156q+l1_56(i5,i6).a(iut,2)*rmas
     & s(id1)
      cy1=l1_56(i5,i6).b(iut,1)+l1_56(i5,i6).d(iut,1)*rmass(id1)
      cy2=l1_56(i5,i6).d(iut,2)*p156q+l1_56(i5,i6).b(iut,2)*rmas
     & s(id1)
      cw1=l1_56(i5,i6).c(iut,1)*p156q+l1_56(i5,i6).a(iut,1)*rmas
     & s(id1)
      cw2=l1_56(i5,i6).a(iut,2)+l1_56(i5,i6).c(iut,2)*rmass(id1)
      cz1=l1_56(i5,i6).d(iut,1)*p156q+l1_56(i5,i6).b(iut,1)*rmas
     & s(id1)
      cz2=l1_56(i5,i6).b(iut,2)+l1_56(i5,i6).d(iut,2)*rmass(id1)
      clineth_4f(i5,i6).a(iut,2)=cx1*rh2_156.a(1,2)+cx2*rh2_156.
     & b(2,2)
      clineth_4f(i5,i6).b(iut,2)=cy1*rh2_156.a(1,2)+cy2*rh2_156.
     & b(2,2)
      clineth_4f(i5,i6).c(iut,2)=cw2*rh2_156.c(2,2)
      clineth_4f(i5,i6).d(iut,2)=cz2*rh2_156.c(2,2)
      clineth_4f(i5,i6).a(iut,1)=cw1*rh2_156.b(1,1)+cw2*rh2_156.
     & a(2,1)
      clineth_4f(i5,i6).b(iut,1)=cz1*rh2_156.b(1,1)+cz2*rh2_156.
     & a(2,1)
      clineth_4f(i5,i6).c(iut,1)=cx1*rh2_156.c(1,1)
      clineth_4f(i5,i6).d(iut,1)=cy1*rh2_156.c(1,1)
      end do
      end do
      end do
  
  
*    Then those of the type                                             
*                                                                       
*              _h___|                                                   
*                   |_Z,f,h__/                                          
*                   |        \                                          
*                                                                       
  
      do i5=1,2
      do i6=1,2
* TSCTs -- aa=clineth_4f(i5,i6).a,bb=clineth_4f(i5,i6).b,cc=clineth_4f(i
* 5,i6).c,dd=clineth_4f(i5,i6).d,a1=lh1_256.a,b1=lh1_256.b,c1=lh1_256.c,
* a2=r2_56(i5,i6).a,b2=r2_56(i5,i6).b,c2=r2_56(i5,i6).c,d2=r2_56(i5,i6).
* d,prq=p256q,m=rmass(id1),nsum=1
      do jut=1,2
      cx1=r2_56(i5,i6).a(1,jut)+rmass(id1)*r2_56(i5,i6).b(1,jut)
      cx2=r2_56(i5,i6).a(2,jut)+rmass(id1)*r2_56(i5,i6).b(2,jut)
      cy1=p256q*r2_56(i5,i6).b(1,jut)+rmass(id1)*r2_56(i5,i6).a(
     & 1,jut)
      cy2=p256q*r2_56(i5,i6).b(2,jut)+rmass(id1)*r2_56(i5,i6).a(
     & 2,jut)
      cw1=r2_56(i5,i6).c(1,jut)+rmass(id1)*r2_56(i5,i6).d(1,jut)
      cw2=r2_56(i5,i6).c(2,jut)+rmass(id1)*r2_56(i5,i6).d(2,jut)
      cz1=p256q*r2_56(i5,i6).d(1,jut)+rmass(id1)*r2_56(i5,i6).c(
     & 1,jut)
      cz2=p256q*r2_56(i5,i6).d(2,jut)+rmass(id1)*r2_56(i5,i6).c(
     & 2,jut)
      clineth_4f(i5,i6).a(2,jut)=clineth_4f(i5,i6).a(2,jut)+lh1_
     & 256.a(2,1)*cx1+lh1_256.c(2,2)*cy2
      clineth_4f(i5,i6).b(2,jut)=clineth_4f(i5,i6).b(2,jut)+lh1_
     & 256.b(2,2)*cx2
      clineth_4f(i5,i6).c(2,jut)=clineth_4f(i5,i6).c(2,jut)+lh1_
     & 256.a(2,1)*cw1+lh1_256.c(2,2)*cz2
      clineth_4f(i5,i6).d(2,jut)=clineth_4f(i5,i6).d(2,jut)+lh1_
     & 256.b(2,2)*cw2
      clineth_4f(i5,i6).a(1,jut)=clineth_4f(i5,i6).a(1,jut)+lh1_
     & 256.c(1,1)*cy1+lh1_256.a(1,2)*cx2
      clineth_4f(i5,i6).b(1,jut)=clineth_4f(i5,i6).b(1,jut)+lh1_
     & 256.b(1,1)*cx1
      clineth_4f(i5,i6).c(1,jut)=clineth_4f(i5,i6).c(1,jut)+lh1_
     & 256.c(1,1)*cz1+lh1_256.a(1,2)*cw2
      clineth_4f(i5,i6).d(1,jut)=clineth_4f(i5,i6).d(1,jut)+lh1_
     & 256.b(1,1)*cw1
      end do
      end do
      end do
  
  
  
  
        rmassl=rmass(id1)
        rmassr=-rmassl
  
  
      do i3=1,2
      do i4=1,2
* mline -- res=ch1256(&1,&2,i3,i4),abcd=clineth_4f(i3,i4).,m1=rmassl,m2=
* rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      ch1256(iut,jut,i3,i4)=clineth_4f(i3,i4).a(iut,jut)+rmassl*
     & clineth_4f(i3,i4).b(iut,jut)+rmassr*clineth_4f(i3,i4).c(i
     & ut,jut)+rmassl*rmassr*clineth_4f(i3,i4).d(iut,jut)
      enddo
      enddo
      end do
      end do
  
  
  
  
      endif	
*                                                                       
*    First all diagrams of the type                                     
*                                                                       
*                   |_Z,f,h__/                                          
*              _h___|        \                                          
*                   |                                                   
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id5.eq.5.and.rmh.ge.0.d0) then
      do i1=1,2
      do i2=1,2
* TsTSC -- aa=clineth_4f(i1,i2).a,bb=clineth_4f(i1,i2).b,cc=clineth_4f(i
* 1,i2).c,dd=clineth_4f(i1,i2).d,a1=l5_12(i1,i2).a,b1=l5_12(i1,i2).b,c1=
* l5_12(i1,i2).c,d1=l5_12(i1,i2).d,a2=rh6_512.a,b2=rh6_512.b,c2=rh6_512.
* c,prq=p512q,m=rmass(id5),nsum=0
      do iut=1,2
      cx1=l5_12(i1,i2).a(iut,1)+l5_12(i1,i2).c(iut,1)*rmass(id5)
      cx2=l5_12(i1,i2).c(iut,2)*p512q+l5_12(i1,i2).a(iut,2)*rmas
     & s(id5)
      cy1=l5_12(i1,i2).b(iut,1)+l5_12(i1,i2).d(iut,1)*rmass(id5)
      cy2=l5_12(i1,i2).d(iut,2)*p512q+l5_12(i1,i2).b(iut,2)*rmas
     & s(id5)
      cw1=l5_12(i1,i2).c(iut,1)*p512q+l5_12(i1,i2).a(iut,1)*rmas
     & s(id5)
      cw2=l5_12(i1,i2).a(iut,2)+l5_12(i1,i2).c(iut,2)*rmass(id5)
      cz1=l5_12(i1,i2).d(iut,1)*p512q+l5_12(i1,i2).b(iut,1)*rmas
     & s(id5)
      cz2=l5_12(i1,i2).b(iut,2)+l5_12(i1,i2).d(iut,2)*rmass(id5)
      clineth_4f(i1,i2).a(iut,2)=cx1*rh6_512.a(1,2)+cx2*rh6_512.
     & b(2,2)
      clineth_4f(i1,i2).b(iut,2)=cy1*rh6_512.a(1,2)+cy2*rh6_512.
     & b(2,2)
      clineth_4f(i1,i2).c(iut,2)=cw2*rh6_512.c(2,2)
      clineth_4f(i1,i2).d(iut,2)=cz2*rh6_512.c(2,2)
      clineth_4f(i1,i2).a(iut,1)=cw1*rh6_512.b(1,1)+cw2*rh6_512.
     & a(2,1)
      clineth_4f(i1,i2).b(iut,1)=cz1*rh6_512.b(1,1)+cz2*rh6_512.
     & a(2,1)
      clineth_4f(i1,i2).c(iut,1)=cx1*rh6_512.c(1,1)
      clineth_4f(i1,i2).d(iut,1)=cy1*rh6_512.c(1,1)
      end do
      end do
      end do
  
  
*    Then those of the type                                             
*                                                                       
*              _h___|                                                   
*                   |_Z,f,h__/                                          
*                   |        \                                          
*                                                                       
  
      do i1=1,2
      do i2=1,2
* TSCTs -- aa=clineth_4f(i1,i2).a,bb=clineth_4f(i1,i2).b,cc=clineth_4f(i
* 1,i2).c,dd=clineth_4f(i1,i2).d,a1=lh5_612.a,b1=lh5_612.b,c1=lh5_612.c,
* a2=r6_12(i1,i2).a,b2=r6_12(i1,i2).b,c2=r6_12(i1,i2).c,d2=r6_12(i1,i2).
* d,prq=p612q,m=rmass(id5),nsum=1
      do jut=1,2
      cx1=r6_12(i1,i2).a(1,jut)+rmass(id5)*r6_12(i1,i2).b(1,jut)
      cx2=r6_12(i1,i2).a(2,jut)+rmass(id5)*r6_12(i1,i2).b(2,jut)
      cy1=p612q*r6_12(i1,i2).b(1,jut)+rmass(id5)*r6_12(i1,i2).a(
     & 1,jut)
      cy2=p612q*r6_12(i1,i2).b(2,jut)+rmass(id5)*r6_12(i1,i2).a(
     & 2,jut)
      cw1=r6_12(i1,i2).c(1,jut)+rmass(id5)*r6_12(i1,i2).d(1,jut)
      cw2=r6_12(i1,i2).c(2,jut)+rmass(id5)*r6_12(i1,i2).d(2,jut)
      cz1=p612q*r6_12(i1,i2).d(1,jut)+rmass(id5)*r6_12(i1,i2).c(
     & 1,jut)
      cz2=p612q*r6_12(i1,i2).d(2,jut)+rmass(id5)*r6_12(i1,i2).c(
     & 2,jut)
      clineth_4f(i1,i2).a(2,jut)=clineth_4f(i1,i2).a(2,jut)+lh5_
     & 612.a(2,1)*cx1+lh5_612.c(2,2)*cy2
      clineth_4f(i1,i2).b(2,jut)=clineth_4f(i1,i2).b(2,jut)+lh5_
     & 612.b(2,2)*cx2
      clineth_4f(i1,i2).c(2,jut)=clineth_4f(i1,i2).c(2,jut)+lh5_
     & 612.a(2,1)*cw1+lh5_612.c(2,2)*cz2
      clineth_4f(i1,i2).d(2,jut)=clineth_4f(i1,i2).d(2,jut)+lh5_
     & 612.b(2,2)*cw2
      clineth_4f(i1,i2).a(1,jut)=clineth_4f(i1,i2).a(1,jut)+lh5_
     & 612.c(1,1)*cy1+lh5_612.a(1,2)*cx2
      clineth_4f(i1,i2).b(1,jut)=clineth_4f(i1,i2).b(1,jut)+lh5_
     & 612.b(1,1)*cx1
      clineth_4f(i1,i2).c(1,jut)=clineth_4f(i1,i2).c(1,jut)+lh5_
     & 612.c(1,1)*cz1+lh5_612.a(1,2)*cw2
      clineth_4f(i1,i2).d(1,jut)=clineth_4f(i1,i2).d(1,jut)+lh5_
     & 612.b(1,1)*cw1
      end do
      end do
      end do
  
  
  
  
        rmassl=rmass(id5)
        rmassr=-rmassl
  
  
  
  
      do i1=1,2
      do i2=1,2
* mline -- res=ch1256(i1,i2,&1,&2),abcd=clineth_4f(i1,i2).,m1=rmassl,m2=
* rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      ch1256(i1,i2,iut,jut)=ch1256(i1,i2,iut,jut)+clineth_4f(i1,
     & i2).a(iut,jut)+rmassl*clineth_4f(i1,i2).b(iut,jut)+rmassr
     & *clineth_4f(i1,i2).c(iut,jut)+rmassl*rmassr*clineth_4f(i1
     & ,i2).d(iut,jut)
      enddo
      enddo
      end do
      end do
  
  
      endif	
*                                                                       
*    First all diagrams of the type                                     
*                                                                       
*                   |_Z,f,h__/                                          
*              _h___|        \                                          
*                   |                                                   
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id3.eq.5.and.rmh.ge.0.d0) then
      do i7=1,2
      do i8=1,2
* TsTSC -- aa=clineth_4f(i7,i8).a,bb=clineth_4f(i7,i8).b,cc=clineth_4f(i
* 7,i8).c,dd=clineth_4f(i7,i8).d,a1=l3_78(i7,i8).a,b1=l3_78(i7,i8).b,c1=
* l3_78(i7,i8).c,d1=l3_78(i7,i8).d,a2=rh4_378.a,b2=rh4_378.b,c2=rh4_378.
* c,prq=p378q,m=rmass(id3),nsum=0
      do iut=1,2
      cx1=l3_78(i7,i8).a(iut,1)+l3_78(i7,i8).c(iut,1)*rmass(id3)
      cx2=l3_78(i7,i8).c(iut,2)*p378q+l3_78(i7,i8).a(iut,2)*rmas
     & s(id3)
      cy1=l3_78(i7,i8).b(iut,1)+l3_78(i7,i8).d(iut,1)*rmass(id3)
      cy2=l3_78(i7,i8).d(iut,2)*p378q+l3_78(i7,i8).b(iut,2)*rmas
     & s(id3)
      cw1=l3_78(i7,i8).c(iut,1)*p378q+l3_78(i7,i8).a(iut,1)*rmas
     & s(id3)
      cw2=l3_78(i7,i8).a(iut,2)+l3_78(i7,i8).c(iut,2)*rmass(id3)
      cz1=l3_78(i7,i8).d(iut,1)*p378q+l3_78(i7,i8).b(iut,1)*rmas
     & s(id3)
      cz2=l3_78(i7,i8).b(iut,2)+l3_78(i7,i8).d(iut,2)*rmass(id3)
      clineth_4f(i7,i8).a(iut,2)=cx1*rh4_378.a(1,2)+cx2*rh4_378.
     & b(2,2)
      clineth_4f(i7,i8).b(iut,2)=cy1*rh4_378.a(1,2)+cy2*rh4_378.
     & b(2,2)
      clineth_4f(i7,i8).c(iut,2)=cw2*rh4_378.c(2,2)
      clineth_4f(i7,i8).d(iut,2)=cz2*rh4_378.c(2,2)
      clineth_4f(i7,i8).a(iut,1)=cw1*rh4_378.b(1,1)+cw2*rh4_378.
     & a(2,1)
      clineth_4f(i7,i8).b(iut,1)=cz1*rh4_378.b(1,1)+cz2*rh4_378.
     & a(2,1)
      clineth_4f(i7,i8).c(iut,1)=cx1*rh4_378.c(1,1)
      clineth_4f(i7,i8).d(iut,1)=cy1*rh4_378.c(1,1)
      end do
      end do
      end do
  
  
*    Then those of the type                                             
*                                                                       
*              _h___|                                                   
*                   |_Z,f,h__/                                          
*                   |        \                                          
*                                                                       
  
      do i7=1,2
      do i8=1,2
* TSCTs -- aa=clineth_4f(i7,i8).a,bb=clineth_4f(i7,i8).b,cc=clineth_4f(i
* 7,i8).c,dd=clineth_4f(i7,i8).d,a1=lh3_478.a,b1=lh3_478.b,c1=lh3_478.c,
* a2=r4_78(i7,i8).a,b2=r4_78(i7,i8).b,c2=r4_78(i7,i8).c,d2=r4_78(i7,i8).
* d,prq=p478q,m=rmass(id3),nsum=1
      do jut=1,2
      cx1=r4_78(i7,i8).a(1,jut)+rmass(id3)*r4_78(i7,i8).b(1,jut)
      cx2=r4_78(i7,i8).a(2,jut)+rmass(id3)*r4_78(i7,i8).b(2,jut)
      cy1=p478q*r4_78(i7,i8).b(1,jut)+rmass(id3)*r4_78(i7,i8).a(
     & 1,jut)
      cy2=p478q*r4_78(i7,i8).b(2,jut)+rmass(id3)*r4_78(i7,i8).a(
     & 2,jut)
      cw1=r4_78(i7,i8).c(1,jut)+rmass(id3)*r4_78(i7,i8).d(1,jut)
      cw2=r4_78(i7,i8).c(2,jut)+rmass(id3)*r4_78(i7,i8).d(2,jut)
      cz1=p478q*r4_78(i7,i8).d(1,jut)+rmass(id3)*r4_78(i7,i8).c(
     & 1,jut)
      cz2=p478q*r4_78(i7,i8).d(2,jut)+rmass(id3)*r4_78(i7,i8).c(
     & 2,jut)
      clineth_4f(i7,i8).a(2,jut)=clineth_4f(i7,i8).a(2,jut)+lh3_
     & 478.a(2,1)*cx1+lh3_478.c(2,2)*cy2
      clineth_4f(i7,i8).b(2,jut)=clineth_4f(i7,i8).b(2,jut)+lh3_
     & 478.b(2,2)*cx2
      clineth_4f(i7,i8).c(2,jut)=clineth_4f(i7,i8).c(2,jut)+lh3_
     & 478.a(2,1)*cw1+lh3_478.c(2,2)*cz2
      clineth_4f(i7,i8).d(2,jut)=clineth_4f(i7,i8).d(2,jut)+lh3_
     & 478.b(2,2)*cw2
      clineth_4f(i7,i8).a(1,jut)=clineth_4f(i7,i8).a(1,jut)+lh3_
     & 478.c(1,1)*cy1+lh3_478.a(1,2)*cx2
      clineth_4f(i7,i8).b(1,jut)=clineth_4f(i7,i8).b(1,jut)+lh3_
     & 478.b(1,1)*cx1
      clineth_4f(i7,i8).c(1,jut)=clineth_4f(i7,i8).c(1,jut)+lh3_
     & 478.c(1,1)*cz1+lh3_478.a(1,2)*cw2
      clineth_4f(i7,i8).d(1,jut)=clineth_4f(i7,i8).d(1,jut)+lh3_
     & 478.b(1,1)*cw1
      end do
      end do
      end do
  
  
  
  
        rmassl=rmass(id3)
        rmassr=-rmassl
  
  
      do i3=1,2
      do i4=1,2
* mline -- res=ch3478(&1,&2,i3,i4),abcd=clineth_4f(i3,i4).,m1=rmassl,m2=
* rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      ch3478(iut,jut,i3,i4)=clineth_4f(i3,i4).a(iut,jut)+rmassl*
     & clineth_4f(i3,i4).b(iut,jut)+rmassr*clineth_4f(i3,i4).c(i
     & ut,jut)+rmassl*rmassr*clineth_4f(i3,i4).d(iut,jut)
      enddo
      enddo
      end do
      end do
  
  
  
  
      endif	
*                                                                       
*    First all diagrams of the type                                     
*                                                                       
*                   |_Z,f,h__/                                          
*              _h___|        \                                          
*                   |                                                   
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id7.eq.5.and.rmh.ge.0.d0) then
      do i3=1,2
      do i4=1,2
* TsTSC -- aa=clineth_4f(i3,i4).a,bb=clineth_4f(i3,i4).b,cc=clineth_4f(i
* 3,i4).c,dd=clineth_4f(i3,i4).d,a1=l7_34(i3,i4).a,b1=l7_34(i3,i4).b,c1=
* l7_34(i3,i4).c,d1=l7_34(i3,i4).d,a2=rh8_734.a,b2=rh8_734.b,c2=rh8_734.
* c,prq=p734q,m=rmass(id7),nsum=0
      do iut=1,2
      cx1=l7_34(i3,i4).a(iut,1)+l7_34(i3,i4).c(iut,1)*rmass(id7)
      cx2=l7_34(i3,i4).c(iut,2)*p734q+l7_34(i3,i4).a(iut,2)*rmas
     & s(id7)
      cy1=l7_34(i3,i4).b(iut,1)+l7_34(i3,i4).d(iut,1)*rmass(id7)
      cy2=l7_34(i3,i4).d(iut,2)*p734q+l7_34(i3,i4).b(iut,2)*rmas
     & s(id7)
      cw1=l7_34(i3,i4).c(iut,1)*p734q+l7_34(i3,i4).a(iut,1)*rmas
     & s(id7)
      cw2=l7_34(i3,i4).a(iut,2)+l7_34(i3,i4).c(iut,2)*rmass(id7)
      cz1=l7_34(i3,i4).d(iut,1)*p734q+l7_34(i3,i4).b(iut,1)*rmas
     & s(id7)
      cz2=l7_34(i3,i4).b(iut,2)+l7_34(i3,i4).d(iut,2)*rmass(id7)
      clineth_4f(i3,i4).a(iut,2)=cx1*rh8_734.a(1,2)+cx2*rh8_734.
     & b(2,2)
      clineth_4f(i3,i4).b(iut,2)=cy1*rh8_734.a(1,2)+cy2*rh8_734.
     & b(2,2)
      clineth_4f(i3,i4).c(iut,2)=cw2*rh8_734.c(2,2)
      clineth_4f(i3,i4).d(iut,2)=cz2*rh8_734.c(2,2)
      clineth_4f(i3,i4).a(iut,1)=cw1*rh8_734.b(1,1)+cw2*rh8_734.
     & a(2,1)
      clineth_4f(i3,i4).b(iut,1)=cz1*rh8_734.b(1,1)+cz2*rh8_734.
     & a(2,1)
      clineth_4f(i3,i4).c(iut,1)=cx1*rh8_734.c(1,1)
      clineth_4f(i3,i4).d(iut,1)=cy1*rh8_734.c(1,1)
      end do
      end do
      end do
  
  
*    Then those of the type                                             
*                                                                       
*              _h___|                                                   
*                   |_Z,f,h__/                                          
*                   |        \                                          
*                                                                       
  
      do i3=1,2
      do i4=1,2
* TSCTs -- aa=clineth_4f(i3,i4).a,bb=clineth_4f(i3,i4).b,cc=clineth_4f(i
* 3,i4).c,dd=clineth_4f(i3,i4).d,a1=lh7_834.a,b1=lh7_834.b,c1=lh7_834.c,
* a2=r8_34(i3,i4).a,b2=r8_34(i3,i4).b,c2=r8_34(i3,i4).c,d2=r8_34(i3,i4).
* d,prq=p834q,m=rmass(id7),nsum=1
      do jut=1,2
      cx1=r8_34(i3,i4).a(1,jut)+rmass(id7)*r8_34(i3,i4).b(1,jut)
      cx2=r8_34(i3,i4).a(2,jut)+rmass(id7)*r8_34(i3,i4).b(2,jut)
      cy1=p834q*r8_34(i3,i4).b(1,jut)+rmass(id7)*r8_34(i3,i4).a(
     & 1,jut)
      cy2=p834q*r8_34(i3,i4).b(2,jut)+rmass(id7)*r8_34(i3,i4).a(
     & 2,jut)
      cw1=r8_34(i3,i4).c(1,jut)+rmass(id7)*r8_34(i3,i4).d(1,jut)
      cw2=r8_34(i3,i4).c(2,jut)+rmass(id7)*r8_34(i3,i4).d(2,jut)
      cz1=p834q*r8_34(i3,i4).d(1,jut)+rmass(id7)*r8_34(i3,i4).c(
     & 1,jut)
      cz2=p834q*r8_34(i3,i4).d(2,jut)+rmass(id7)*r8_34(i3,i4).c(
     & 2,jut)
      clineth_4f(i3,i4).a(2,jut)=clineth_4f(i3,i4).a(2,jut)+lh7_
     & 834.a(2,1)*cx1+lh7_834.c(2,2)*cy2
      clineth_4f(i3,i4).b(2,jut)=clineth_4f(i3,i4).b(2,jut)+lh7_
     & 834.b(2,2)*cx2
      clineth_4f(i3,i4).c(2,jut)=clineth_4f(i3,i4).c(2,jut)+lh7_
     & 834.a(2,1)*cw1+lh7_834.c(2,2)*cz2
      clineth_4f(i3,i4).d(2,jut)=clineth_4f(i3,i4).d(2,jut)+lh7_
     & 834.b(2,2)*cw2
      clineth_4f(i3,i4).a(1,jut)=clineth_4f(i3,i4).a(1,jut)+lh7_
     & 834.c(1,1)*cy1+lh7_834.a(1,2)*cx2
      clineth_4f(i3,i4).b(1,jut)=clineth_4f(i3,i4).b(1,jut)+lh7_
     & 834.b(1,1)*cx1
      clineth_4f(i3,i4).c(1,jut)=clineth_4f(i3,i4).c(1,jut)+lh7_
     & 834.c(1,1)*cz1+lh7_834.a(1,2)*cw2
      clineth_4f(i3,i4).d(1,jut)=clineth_4f(i3,i4).d(1,jut)+lh7_
     & 834.b(1,1)*cw1
      end do
      end do
      end do
  
  
  
  
        rmassl=rmass(id7)
        rmassr=-rmassl
  
  
  
  
      do i1=1,2
      do i2=1,2
* mline -- res=ch3478(i1,i2,&1,&2),abcd=clineth_4f(i1,i2).,m1=rmassl,m2=
* rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      ch3478(i1,i2,iut,jut)=ch3478(i1,i2,iut,jut)+clineth_4f(i1,
     & i2).a(iut,jut)+rmassl*clineth_4f(i1,i2).b(iut,jut)+rmassr
     & *clineth_4f(i1,i2).c(iut,jut)+rmassl*rmassr*clineth_4f(i1
     & ,i2).d(iut,jut)
      enddo
      enddo
      end do
      end do
  
  
      endif	
*                                                                       
*    First all diagrams of the type                                     
*                                                                       
*                   |_Z,f,h__/                                          
*              _h___|        \                                          
*                   |                                                   
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id1.eq.5.and.rmh.ge.0.d0) then
      do i7=1,2
      do i8=1,2
* TsTSC -- aa=clineth_4f(i7,i8).a,bb=clineth_4f(i7,i8).b,cc=clineth_4f(i
* 7,i8).c,dd=clineth_4f(i7,i8).d,a1=l1_78(i7,i8).a,b1=l1_78(i7,i8).b,c1=
* l1_78(i7,i8).c,d1=l1_78(i7,i8).d,a2=rh2_178.a,b2=rh2_178.b,c2=rh2_178.
* c,prq=p178q,m=rmass(id1),nsum=0
      do iut=1,2
      cx1=l1_78(i7,i8).a(iut,1)+l1_78(i7,i8).c(iut,1)*rmass(id1)
      cx2=l1_78(i7,i8).c(iut,2)*p178q+l1_78(i7,i8).a(iut,2)*rmas
     & s(id1)
      cy1=l1_78(i7,i8).b(iut,1)+l1_78(i7,i8).d(iut,1)*rmass(id1)
      cy2=l1_78(i7,i8).d(iut,2)*p178q+l1_78(i7,i8).b(iut,2)*rmas
     & s(id1)
      cw1=l1_78(i7,i8).c(iut,1)*p178q+l1_78(i7,i8).a(iut,1)*rmas
     & s(id1)
      cw2=l1_78(i7,i8).a(iut,2)+l1_78(i7,i8).c(iut,2)*rmass(id1)
      cz1=l1_78(i7,i8).d(iut,1)*p178q+l1_78(i7,i8).b(iut,1)*rmas
     & s(id1)
      cz2=l1_78(i7,i8).b(iut,2)+l1_78(i7,i8).d(iut,2)*rmass(id1)
      clineth_4f(i7,i8).a(iut,2)=cx1*rh2_178.a(1,2)+cx2*rh2_178.
     & b(2,2)
      clineth_4f(i7,i8).b(iut,2)=cy1*rh2_178.a(1,2)+cy2*rh2_178.
     & b(2,2)
      clineth_4f(i7,i8).c(iut,2)=cw2*rh2_178.c(2,2)
      clineth_4f(i7,i8).d(iut,2)=cz2*rh2_178.c(2,2)
      clineth_4f(i7,i8).a(iut,1)=cw1*rh2_178.b(1,1)+cw2*rh2_178.
     & a(2,1)
      clineth_4f(i7,i8).b(iut,1)=cz1*rh2_178.b(1,1)+cz2*rh2_178.
     & a(2,1)
      clineth_4f(i7,i8).c(iut,1)=cx1*rh2_178.c(1,1)
      clineth_4f(i7,i8).d(iut,1)=cy1*rh2_178.c(1,1)
      end do
      end do
      end do
  
  
*    Then those of the type                                             
*                                                                       
*              _h___|                                                   
*                   |_Z,f,h__/                                          
*                   |        \                                          
*                                                                       
  
      do i7=1,2
      do i8=1,2
* TSCTs -- aa=clineth_4f(i7,i8).a,bb=clineth_4f(i7,i8).b,cc=clineth_4f(i
* 7,i8).c,dd=clineth_4f(i7,i8).d,a1=lh1_278.a,b1=lh1_278.b,c1=lh1_278.c,
* a2=r2_78(i7,i8).a,b2=r2_78(i7,i8).b,c2=r2_78(i7,i8).c,d2=r2_78(i7,i8).
* d,prq=p278q,m=rmass(id1),nsum=1
      do jut=1,2
      cx1=r2_78(i7,i8).a(1,jut)+rmass(id1)*r2_78(i7,i8).b(1,jut)
      cx2=r2_78(i7,i8).a(2,jut)+rmass(id1)*r2_78(i7,i8).b(2,jut)
      cy1=p278q*r2_78(i7,i8).b(1,jut)+rmass(id1)*r2_78(i7,i8).a(
     & 1,jut)
      cy2=p278q*r2_78(i7,i8).b(2,jut)+rmass(id1)*r2_78(i7,i8).a(
     & 2,jut)
      cw1=r2_78(i7,i8).c(1,jut)+rmass(id1)*r2_78(i7,i8).d(1,jut)
      cw2=r2_78(i7,i8).c(2,jut)+rmass(id1)*r2_78(i7,i8).d(2,jut)
      cz1=p278q*r2_78(i7,i8).d(1,jut)+rmass(id1)*r2_78(i7,i8).c(
     & 1,jut)
      cz2=p278q*r2_78(i7,i8).d(2,jut)+rmass(id1)*r2_78(i7,i8).c(
     & 2,jut)
      clineth_4f(i7,i8).a(2,jut)=clineth_4f(i7,i8).a(2,jut)+lh1_
     & 278.a(2,1)*cx1+lh1_278.c(2,2)*cy2
      clineth_4f(i7,i8).b(2,jut)=clineth_4f(i7,i8).b(2,jut)+lh1_
     & 278.b(2,2)*cx2
      clineth_4f(i7,i8).c(2,jut)=clineth_4f(i7,i8).c(2,jut)+lh1_
     & 278.a(2,1)*cw1+lh1_278.c(2,2)*cz2
      clineth_4f(i7,i8).d(2,jut)=clineth_4f(i7,i8).d(2,jut)+lh1_
     & 278.b(2,2)*cw2
      clineth_4f(i7,i8).a(1,jut)=clineth_4f(i7,i8).a(1,jut)+lh1_
     & 278.c(1,1)*cy1+lh1_278.a(1,2)*cx2
      clineth_4f(i7,i8).b(1,jut)=clineth_4f(i7,i8).b(1,jut)+lh1_
     & 278.b(1,1)*cx1
      clineth_4f(i7,i8).c(1,jut)=clineth_4f(i7,i8).c(1,jut)+lh1_
     & 278.c(1,1)*cz1+lh1_278.a(1,2)*cw2
      clineth_4f(i7,i8).d(1,jut)=clineth_4f(i7,i8).d(1,jut)+lh1_
     & 278.b(1,1)*cw1
      end do
      end do
      end do
  
  
  
  
        rmassl=rmass(id1)
        rmassr=-rmassl
  
  
      do i3=1,2
      do i4=1,2
* mline -- res=ch1278(&1,&2,i3,i4),abcd=clineth_4f(i3,i4).,m1=rmassl,m2=
* rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      ch1278(iut,jut,i3,i4)=clineth_4f(i3,i4).a(iut,jut)+rmassl*
     & clineth_4f(i3,i4).b(iut,jut)+rmassr*clineth_4f(i3,i4).c(i
     & ut,jut)+rmassl*rmassr*clineth_4f(i3,i4).d(iut,jut)
      enddo
      enddo
      end do
      end do
  
  
  
  
      endif	
*                                                                       
*    First all diagrams of the type                                     
*                                                                       
*                   |_Z,f,h__/                                          
*              _h___|        \                                          
*                   |                                                   
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id7.eq.5.and.rmh.ge.0.d0) then
      do i1=1,2
      do i2=1,2
* TsTSC -- aa=clineth_4f(i1,i2).a,bb=clineth_4f(i1,i2).b,cc=clineth_4f(i
* 1,i2).c,dd=clineth_4f(i1,i2).d,a1=l7_12(i1,i2).a,b1=l7_12(i1,i2).b,c1=
* l7_12(i1,i2).c,d1=l7_12(i1,i2).d,a2=rh8_712.a,b2=rh8_712.b,c2=rh8_712.
* c,prq=p712q,m=rmass(id7),nsum=0
      do iut=1,2
      cx1=l7_12(i1,i2).a(iut,1)+l7_12(i1,i2).c(iut,1)*rmass(id7)
      cx2=l7_12(i1,i2).c(iut,2)*p712q+l7_12(i1,i2).a(iut,2)*rmas
     & s(id7)
      cy1=l7_12(i1,i2).b(iut,1)+l7_12(i1,i2).d(iut,1)*rmass(id7)
      cy2=l7_12(i1,i2).d(iut,2)*p712q+l7_12(i1,i2).b(iut,2)*rmas
     & s(id7)
      cw1=l7_12(i1,i2).c(iut,1)*p712q+l7_12(i1,i2).a(iut,1)*rmas
     & s(id7)
      cw2=l7_12(i1,i2).a(iut,2)+l7_12(i1,i2).c(iut,2)*rmass(id7)
      cz1=l7_12(i1,i2).d(iut,1)*p712q+l7_12(i1,i2).b(iut,1)*rmas
     & s(id7)
      cz2=l7_12(i1,i2).b(iut,2)+l7_12(i1,i2).d(iut,2)*rmass(id7)
      clineth_4f(i1,i2).a(iut,2)=cx1*rh8_712.a(1,2)+cx2*rh8_712.
     & b(2,2)
      clineth_4f(i1,i2).b(iut,2)=cy1*rh8_712.a(1,2)+cy2*rh8_712.
     & b(2,2)
      clineth_4f(i1,i2).c(iut,2)=cw2*rh8_712.c(2,2)
      clineth_4f(i1,i2).d(iut,2)=cz2*rh8_712.c(2,2)
      clineth_4f(i1,i2).a(iut,1)=cw1*rh8_712.b(1,1)+cw2*rh8_712.
     & a(2,1)
      clineth_4f(i1,i2).b(iut,1)=cz1*rh8_712.b(1,1)+cz2*rh8_712.
     & a(2,1)
      clineth_4f(i1,i2).c(iut,1)=cx1*rh8_712.c(1,1)
      clineth_4f(i1,i2).d(iut,1)=cy1*rh8_712.c(1,1)
      end do
      end do
      end do
  
  
*    Then those of the type                                             
*                                                                       
*              _h___|                                                   
*                   |_Z,f,h__/                                          
*                   |        \                                          
*                                                                       
  
      do i1=1,2
      do i2=1,2
* TSCTs -- aa=clineth_4f(i1,i2).a,bb=clineth_4f(i1,i2).b,cc=clineth_4f(i
* 1,i2).c,dd=clineth_4f(i1,i2).d,a1=lh7_812.a,b1=lh7_812.b,c1=lh7_812.c,
* a2=r8_12(i1,i2).a,b2=r8_12(i1,i2).b,c2=r8_12(i1,i2).c,d2=r8_12(i1,i2).
* d,prq=p812q,m=rmass(id7),nsum=1
      do jut=1,2
      cx1=r8_12(i1,i2).a(1,jut)+rmass(id7)*r8_12(i1,i2).b(1,jut)
      cx2=r8_12(i1,i2).a(2,jut)+rmass(id7)*r8_12(i1,i2).b(2,jut)
      cy1=p812q*r8_12(i1,i2).b(1,jut)+rmass(id7)*r8_12(i1,i2).a(
     & 1,jut)
      cy2=p812q*r8_12(i1,i2).b(2,jut)+rmass(id7)*r8_12(i1,i2).a(
     & 2,jut)
      cw1=r8_12(i1,i2).c(1,jut)+rmass(id7)*r8_12(i1,i2).d(1,jut)
      cw2=r8_12(i1,i2).c(2,jut)+rmass(id7)*r8_12(i1,i2).d(2,jut)
      cz1=p812q*r8_12(i1,i2).d(1,jut)+rmass(id7)*r8_12(i1,i2).c(
     & 1,jut)
      cz2=p812q*r8_12(i1,i2).d(2,jut)+rmass(id7)*r8_12(i1,i2).c(
     & 2,jut)
      clineth_4f(i1,i2).a(2,jut)=clineth_4f(i1,i2).a(2,jut)+lh7_
     & 812.a(2,1)*cx1+lh7_812.c(2,2)*cy2
      clineth_4f(i1,i2).b(2,jut)=clineth_4f(i1,i2).b(2,jut)+lh7_
     & 812.b(2,2)*cx2
      clineth_4f(i1,i2).c(2,jut)=clineth_4f(i1,i2).c(2,jut)+lh7_
     & 812.a(2,1)*cw1+lh7_812.c(2,2)*cz2
      clineth_4f(i1,i2).d(2,jut)=clineth_4f(i1,i2).d(2,jut)+lh7_
     & 812.b(2,2)*cw2
      clineth_4f(i1,i2).a(1,jut)=clineth_4f(i1,i2).a(1,jut)+lh7_
     & 812.c(1,1)*cy1+lh7_812.a(1,2)*cx2
      clineth_4f(i1,i2).b(1,jut)=clineth_4f(i1,i2).b(1,jut)+lh7_
     & 812.b(1,1)*cx1
      clineth_4f(i1,i2).c(1,jut)=clineth_4f(i1,i2).c(1,jut)+lh7_
     & 812.c(1,1)*cz1+lh7_812.a(1,2)*cw2
      clineth_4f(i1,i2).d(1,jut)=clineth_4f(i1,i2).d(1,jut)+lh7_
     & 812.b(1,1)*cw1
      end do
      end do
      end do
  
  
  
  
        rmassl=rmass(id7)
        rmassr=-rmassl
  
  
  
  
      do i1=1,2
      do i2=1,2
* mline -- res=ch1278(i1,i2,&1,&2),abcd=clineth_4f(i1,i2).,m1=rmassl,m2=
* rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      ch1278(i1,i2,iut,jut)=ch1278(i1,i2,iut,jut)+clineth_4f(i1,
     & i2).a(iut,jut)+rmassl*clineth_4f(i1,i2).b(iut,jut)+rmassr
     & *clineth_4f(i1,i2).c(iut,jut)+rmassl*rmassr*clineth_4f(i1
     & ,i2).d(iut,jut)
      enddo
      enddo
      end do
      end do
  
  
      endif	
*                                                                       
*    First all diagrams of the type                                     
*                                                                       
*                   |_Z,f,h__/                                          
*              _h___|        \                                          
*                   |                                                   
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id3.eq.5.and.rmh.ge.0.d0) then
      do i5=1,2
      do i6=1,2
* TsTSC -- aa=clineth_4f(i5,i6).a,bb=clineth_4f(i5,i6).b,cc=clineth_4f(i
* 5,i6).c,dd=clineth_4f(i5,i6).d,a1=l3_56(i5,i6).a,b1=l3_56(i5,i6).b,c1=
* l3_56(i5,i6).c,d1=l3_56(i5,i6).d,a2=rh4_356.a,b2=rh4_356.b,c2=rh4_356.
* c,prq=p356q,m=rmass(id3),nsum=0
      do iut=1,2
      cx1=l3_56(i5,i6).a(iut,1)+l3_56(i5,i6).c(iut,1)*rmass(id3)
      cx2=l3_56(i5,i6).c(iut,2)*p356q+l3_56(i5,i6).a(iut,2)*rmas
     & s(id3)
      cy1=l3_56(i5,i6).b(iut,1)+l3_56(i5,i6).d(iut,1)*rmass(id3)
      cy2=l3_56(i5,i6).d(iut,2)*p356q+l3_56(i5,i6).b(iut,2)*rmas
     & s(id3)
      cw1=l3_56(i5,i6).c(iut,1)*p356q+l3_56(i5,i6).a(iut,1)*rmas
     & s(id3)
      cw2=l3_56(i5,i6).a(iut,2)+l3_56(i5,i6).c(iut,2)*rmass(id3)
      cz1=l3_56(i5,i6).d(iut,1)*p356q+l3_56(i5,i6).b(iut,1)*rmas
     & s(id3)
      cz2=l3_56(i5,i6).b(iut,2)+l3_56(i5,i6).d(iut,2)*rmass(id3)
      clineth_4f(i5,i6).a(iut,2)=cx1*rh4_356.a(1,2)+cx2*rh4_356.
     & b(2,2)
      clineth_4f(i5,i6).b(iut,2)=cy1*rh4_356.a(1,2)+cy2*rh4_356.
     & b(2,2)
      clineth_4f(i5,i6).c(iut,2)=cw2*rh4_356.c(2,2)
      clineth_4f(i5,i6).d(iut,2)=cz2*rh4_356.c(2,2)
      clineth_4f(i5,i6).a(iut,1)=cw1*rh4_356.b(1,1)+cw2*rh4_356.
     & a(2,1)
      clineth_4f(i5,i6).b(iut,1)=cz1*rh4_356.b(1,1)+cz2*rh4_356.
     & a(2,1)
      clineth_4f(i5,i6).c(iut,1)=cx1*rh4_356.c(1,1)
      clineth_4f(i5,i6).d(iut,1)=cy1*rh4_356.c(1,1)
      end do
      end do
      end do
  
  
*    Then those of the type                                             
*                                                                       
*              _h___|                                                   
*                   |_Z,f,h__/                                          
*                   |        \                                          
*                                                                       
  
      do i5=1,2
      do i6=1,2
* TSCTs -- aa=clineth_4f(i5,i6).a,bb=clineth_4f(i5,i6).b,cc=clineth_4f(i
* 5,i6).c,dd=clineth_4f(i5,i6).d,a1=lh3_456.a,b1=lh3_456.b,c1=lh3_456.c,
* a2=r4_56(i5,i6).a,b2=r4_56(i5,i6).b,c2=r4_56(i5,i6).c,d2=r4_56(i5,i6).
* d,prq=p456q,m=rmass(id3),nsum=1
      do jut=1,2
      cx1=r4_56(i5,i6).a(1,jut)+rmass(id3)*r4_56(i5,i6).b(1,jut)
      cx2=r4_56(i5,i6).a(2,jut)+rmass(id3)*r4_56(i5,i6).b(2,jut)
      cy1=p456q*r4_56(i5,i6).b(1,jut)+rmass(id3)*r4_56(i5,i6).a(
     & 1,jut)
      cy2=p456q*r4_56(i5,i6).b(2,jut)+rmass(id3)*r4_56(i5,i6).a(
     & 2,jut)
      cw1=r4_56(i5,i6).c(1,jut)+rmass(id3)*r4_56(i5,i6).d(1,jut)
      cw2=r4_56(i5,i6).c(2,jut)+rmass(id3)*r4_56(i5,i6).d(2,jut)
      cz1=p456q*r4_56(i5,i6).d(1,jut)+rmass(id3)*r4_56(i5,i6).c(
     & 1,jut)
      cz2=p456q*r4_56(i5,i6).d(2,jut)+rmass(id3)*r4_56(i5,i6).c(
     & 2,jut)
      clineth_4f(i5,i6).a(2,jut)=clineth_4f(i5,i6).a(2,jut)+lh3_
     & 456.a(2,1)*cx1+lh3_456.c(2,2)*cy2
      clineth_4f(i5,i6).b(2,jut)=clineth_4f(i5,i6).b(2,jut)+lh3_
     & 456.b(2,2)*cx2
      clineth_4f(i5,i6).c(2,jut)=clineth_4f(i5,i6).c(2,jut)+lh3_
     & 456.a(2,1)*cw1+lh3_456.c(2,2)*cz2
      clineth_4f(i5,i6).d(2,jut)=clineth_4f(i5,i6).d(2,jut)+lh3_
     & 456.b(2,2)*cw2
      clineth_4f(i5,i6).a(1,jut)=clineth_4f(i5,i6).a(1,jut)+lh3_
     & 456.c(1,1)*cy1+lh3_456.a(1,2)*cx2
      clineth_4f(i5,i6).b(1,jut)=clineth_4f(i5,i6).b(1,jut)+lh3_
     & 456.b(1,1)*cx1
      clineth_4f(i5,i6).c(1,jut)=clineth_4f(i5,i6).c(1,jut)+lh3_
     & 456.c(1,1)*cz1+lh3_456.a(1,2)*cw2
      clineth_4f(i5,i6).d(1,jut)=clineth_4f(i5,i6).d(1,jut)+lh3_
     & 456.b(1,1)*cw1
      end do
      end do
      end do
  
  
  
  
        rmassl=rmass(id3)
        rmassr=-rmassl
  
  
      do i3=1,2
      do i4=1,2
* mline -- res=ch3456(&1,&2,i3,i4),abcd=clineth_4f(i3,i4).,m1=rmassl,m2=
* rmassr,den=0,nsum=0
      do iut=1,2
      do jut=1,2
      ch3456(iut,jut,i3,i4)=clineth_4f(i3,i4).a(iut,jut)+rmassl*
     & clineth_4f(i3,i4).b(iut,jut)+rmassr*clineth_4f(i3,i4).c(i
     & ut,jut)+rmassl*rmassr*clineth_4f(i3,i4).d(iut,jut)
      enddo
      enddo
      end do
      end do
  
  
  
  
      endif	
*                                                                       
*    First all diagrams of the type                                     
*                                                                       
*                   |_Z,f,h__/                                          
*              _h___|        \                                          
*                   |                                                   
  
* rmh < 0 in our convention means no higgs coupling                     
      if (id5.eq.5.and.rmh.ge.0.d0) then
      do i3=1,2
      do i4=1,2
* TsTSC -- aa=clineth_4f(i3,i4).a,bb=clineth_4f(i3,i4).b,cc=clineth_4f(i
* 3,i4).c,dd=clineth_4f(i3,i4).d,a1=l5_34(i3,i4).a,b1=l5_34(i3,i4).b,c1=
* l5_34(i3,i4).c,d1=l5_34(i3,i4).d,a2=rh6_534.a,b2=rh6_534.b,c2=rh6_534.
* c,prq=p534q,m=rmass(id5),nsum=0
      do iut=1,2
      cx1=l5_34(i3,i4).a(iut,1)+l5_34(i3,i4).c(iut,1)*rmass(id5)
      cx2=l5_34(i3,i4).c(iut,2)*p534q+l5_34(i3,i4).a(iut,2)*rmas
     & s(id5)
      cy1=l5_34(i3,i4).b(iut,1)+l5_34(i3,i4).d(iut,1)*rmass(id5)
      cy2=l5_34(i3,i4).d(iut,2)*p534q+l5_34(i3,i4).b(iut,2)*rmas
     & s(id5)
      cw1=l5_34(i3,i4).c(iut,1)*p534q+l5_34(i3,i4).a(iut,1)*rmas
     & s(id5)
      cw2=l5_34(i3,i4).a(iut,2)+l5_34(i3,i4).c(iut,2)*rmass(id5)
      cz1=l5_34(i3,i4).d(iut,1)*p534q+l5_34(i3,i4).b(iut,1)*rmas
     & s(id5)
      cz2=l5_34(i3,i4).b(iut,2)+l5_34(i3,i4).d(iut,2)*rmass(id5)
      clineth_4f(i3,i4).a(iut,2)=cx1*rh6_534.a(1,2)+cx2*rh6_534.
     & b(2,2)
      clineth_4f(i3,i4).b(iut,2)=cy1*rh6_534.a(1,2)+cy2*rh6_534.
     & b(2,2)
      clineth_4f(i3,i4).c(iut,2)=cw2*rh6_534.c(2,2)
      clineth_4f(i3,i4).d(iut,2)=cz2*rh6_534.c(2,2)
      clineth_4f(i3,i4).a(iut,1)=cw1*rh6_534.b(1,1)+cw2*rh6_534.
     & a(2,1)
      clineth_4f(i3,i4).b(iut,1)=cz1*rh6_534.b(1,1)+cz2*rh6_534.
     & a(2,1)
      clineth_4f(i3,i4).c(iut,1)=cx1*rh6_534.c(1,1)
      clineth_4f(i3,i4).d(iut,1)=cy1*rh6_534.c(1,1)
      end do
      end do
      end do
  
  
*    Then those of the type                                             
*                                                                       
*              _h___|                                                   
*                   |_Z,f,h__/                                          
*                   |        \                                          
*                                                                       
  
      do i3=1,2
      do i4=1,2
* TSCTs -- aa=clineth_4f(i3,i4).a,bb=clineth_4f(i3,i4).b,cc=clineth_4f(i
* 3,i4).c,dd=clineth_4f(i3,i4).d,a1=lh5_634.a,b1=lh5_634.b,c1=lh5_634.c,
* a2=r6_34(i3,i4).a,b2=r6_34(i3,i4).b,c2=r6_34(i3,i4).c,d2=r6_34(i3,i4).
* d,prq=p634q,m=rmass(id5),nsum=1
      do jut=1,2
      cx1=r6_34(i3,i4).a(1,jut)+rmass(id5)*r6_34(i3,i4).b(1,jut)
      cx2=r6_34(i3,i4).a(2,jut)+rmass(id5)*r6_34(i3,i4).b(2,jut)
      cy1=p634q*r6_34(i3,i4).b(1,jut)+rmass(id5)*r6_34(i3,i4).a(
     & 1,jut)
      cy2=p634q*r6_34(i3,i4).b(2,jut)+rmass(id5)*r6_34(i3,i4).a(
     & 2,jut)
      cw1=r6_34(i3,i4).c(1,jut)+rmass(id5)*r6_34(i3,i4).d(1,jut)
      cw2=r6_34(i3,i4).c(2,jut)+rmass(id5)*r6_34(i3,i4).d(2,jut)
      cz1=p634q*r6_34(i3,i4).d(1,jut)+rmass(id5)*r6_34(i3,i4).c(
     & 1,jut)
      cz2=p634q*r6_34(i3,i4).d(2,jut)+rmass(id5)*r6_34(i3,i4).c(
     & 2,jut)
      clineth_4f(i3,i4).a(2,jut)=clineth_4f(i3,i4).a(2,jut)+lh5_
     & 634.a(2,1)*cx1+lh5_634.c(2,2)*cy2
      clineth_4f(i3,i4).b(2,jut)=clineth_4f(i3,i4).b(2,jut)+lh5_
     & 634.b(2,2)*cx2
      clineth_4f(i3,i4).c(2,jut)=clineth_4f(i3,i4).c(2,jut)+lh5_
     & 634.a(2,1)*cw1+lh5_634.c(2,2)*cz2
      clineth_4f(i3,i4).d(2,jut)=clineth_4f(i3,i4).d(2,jut)+lh5_
     & 634.b(2,2)*cw2
      clineth_4f(i3,i4).a(1,jut)=clineth_4f(i3,i4).a(1,jut)+lh5_
     & 634.c(1,1)*cy1+lh5_634.a(1,2)*cx2
      clineth_4f(i3,i4).b(1,jut)=clineth_4f(i3,i4).b(1,jut)+lh5_
     & 634.b(1,1)*cx1
      clineth_4f(i3,i4).c(1,jut)=clineth_4f(i3,i4).c(1,jut)+lh5_
     & 634.c(1,1)*cz1+lh5_634.a(1,2)*cw2
      clineth_4f(i3,i4).d(1,jut)=clineth_4f(i3,i4).d(1,jut)+lh5_
     & 634.b(1,1)*cw1
      end do
      end do
      end do
  
  
  
  
        rmassl=rmass(id5)
        rmassr=-rmassl
  
  
  
  
      do i1=1,2
      do i2=1,2
* mline -- res=ch3456(i1,i2,&1,&2),abcd=clineth_4f(i1,i2).,m1=rmassl,m2=
* rmassr,den=0,nsum=1
      do iut=1,2
      do jut=1,2
      ch3456(i1,i2,iut,jut)=ch3456(i1,i2,iut,jut)+clineth_4f(i1,
     & i2).a(iut,jut)+rmassl*clineth_4f(i1,i2).b(iut,jut)+rmassr
     & *clineth_4f(i1,i2).c(iut,jut)+rmassl*rmassr*clineth_4f(i1
     & ,i2).d(iut,jut)
      enddo
      enddo
      end do
      end do
  
  
      endif	
  
      do i1=1,2
        do i2=1,2
          do i3=1,2
            do i4=1,2
              chh1234(i1,i2,i3,i4)=ch1234(i1,i2,i3,i4)*rhhbb
              ch1234(i1,i2,i3,i4)=ch1234(i1,i2,i3,i4)*rhbb
              chh5678(i1,i2,i3,i4)=ch5678(i1,i2,i3,i4)*rhhbb
              ch5678(i1,i2,i3,i4)=ch5678(i1,i2,i3,i4)*rhbb
              chh1256(i1,i2,i3,i4)=ch1256(i1,i2,i3,i4)*rhhbb
              ch1256(i1,i2,i3,i4)=ch1256(i1,i2,i3,i4)*rhbb
              chh3478(i1,i2,i3,i4)=ch3478(i1,i2,i3,i4)*rhhbb
              ch3478(i1,i2,i3,i4)=ch3478(i1,i2,i3,i4)*rhbb
              chh1278(i1,i2,i3,i4)=ch1278(i1,i2,i3,i4)*rhhbb
              ch1278(i1,i2,i3,i4)=ch1278(i1,i2,i3,i4)*rhbb
              chh3456(i1,i2,i3,i4)=ch3456(i1,i2,i3,i4)*rhhbb
              ch3456(i1,i2,i3,i4)=ch3456(i1,i2,i3,i4)*rhbb
            enddo
          enddo
        enddo
      enddo
  
*                                                                       
*    Then the triple vertex                                             
*                                                                       
*                    /_                      /_                         
*                  Z/                      h/                           
*             _h___/       and        _h___/                            
*                  \                       \                            
*                  Z\_                     h\_                          
*                    \                       \                          
*                                                                       
  
* rmh < 0 in our convention means no higgs coupling                     
  
      if (rmh.ge.0.d0)then
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cdum(i1,i2,i3,i4),p=cz12(i1,i2).e,q=cz34(i3,i4).e,bef=,aft=
      cdum(i1,i2,i3,i4)=(cz12(i1,i2).e(0)*cz34(i3,i4).e(0)-cz12(
     & i1,i2).e(1)*cz34(i3,i4).e(1)-cz12(i1,i2).e(2)*cz34(i3,i4)
     & .e(2)-cz12(i1,i2).e(3)*cz34(i3,i4).e(3))
      end do
      end do
      end do
      end do
  
      do i1=1,2
        do i2=1,2
          do i3=1,2
            do i4=1,2
              ch1234(i1,i2,i3,i4)=ch1234(i1,i2,i3,i4)+
     &             rhzz*cdum(i1,i2,i3,i4)
              chh1234(i1,i2,i3,i4)=chh1234(i1,i2,i3,i4)+
     &             rhhzz*cdum(i1,i2,i3,i4)
            enddo
          enddo
        enddo
      enddo
  
      	if(id1.eq.5.and.id3.eq.5)then
      do i1=1,2
        do i2=1,2
          do i3=1,2
            do i4=1,2
              cdum(i1,i2,i3,i4)=ch12(i1,i2)*ch34(i3,i4)
  
              ch1234(i1,i2,i3,i4)=ch1234(i1,i2,i3,i4)
     &             +cdum(i1,i2,i3,i4)*
     &             (r3h*rhbb/(s12-cmh2)*rhbb/(s34-cmh2)+
     &             r2h1hh*rhbb/(s12-cmh2)*rhhbb/(s34-cmhh2)+
     &             r2h1hh*rhhbb/(s12-cmhh2)*rhbb/(s34-cmh2)+
     &             r1h2hh*rhhbb/(s12-cmhh2)*rhhbb/(s34-cmhh2))
  
              chh1234(i1,i2,i3,i4)=chh1234(i1,i2,i3,i4)
     &             +cdum(i1,i2,i3,i4)*
     &             (r3hh*rhhbb/(s12-cmhh2)*rhhbb/(s34-cmhh2)+
     &             r1h2hh*rhhbb/(s12-cmhh2)*rhbb/(s34-cmh2)+
     &             r1h2hh*rhbb/(s12-cmh2)*rhhbb/(s34-cmhh2)+
     &             r2h1hh*rhbb/(s12-cmh2)*rhbb/(s34-cmh2))
  
            enddo
          enddo
        enddo
       enddo
       	endif
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cdum(i1,i2,i3,i4),p=cz56(i1,i2).e,q=cz78(i3,i4).e,bef=,aft=
      cdum(i1,i2,i3,i4)=(cz56(i1,i2).e(0)*cz78(i3,i4).e(0)-cz56(
     & i1,i2).e(1)*cz78(i3,i4).e(1)-cz56(i1,i2).e(2)*cz78(i3,i4)
     & .e(2)-cz56(i1,i2).e(3)*cz78(i3,i4).e(3))
      end do
      end do
      end do
      end do
  
      do i1=1,2
        do i2=1,2
          do i3=1,2
            do i4=1,2
              ch5678(i1,i2,i3,i4)=ch5678(i1,i2,i3,i4)+
     &             rhzz*cdum(i1,i2,i3,i4)
              chh5678(i1,i2,i3,i4)=chh5678(i1,i2,i3,i4)+
     &             rhhzz*cdum(i1,i2,i3,i4)
            enddo
          enddo
        enddo
      enddo
  
      	if(id5.eq.5.and.id7.eq.5)then
      do i1=1,2
        do i2=1,2
          do i3=1,2
            do i4=1,2
              cdum(i1,i2,i3,i4)=ch56(i1,i2)*ch78(i3,i4)
  
              ch5678(i1,i2,i3,i4)=ch5678(i1,i2,i3,i4)
     &             +cdum(i1,i2,i3,i4)*
     &             (r3h*rhbb/(s56-cmh2)*rhbb/(s78-cmh2)+
     &             r2h1hh*rhbb/(s56-cmh2)*rhhbb/(s78-cmhh2)+
     &             r2h1hh*rhhbb/(s56-cmhh2)*rhbb/(s78-cmh2)+
     &             r1h2hh*rhhbb/(s56-cmhh2)*rhhbb/(s78-cmhh2))
  
              chh5678(i1,i2,i3,i4)=chh5678(i1,i2,i3,i4)
     &             +cdum(i1,i2,i3,i4)*
     &             (r3hh*rhhbb/(s56-cmhh2)*rhhbb/(s78-cmhh2)+
     &             r1h2hh*rhhbb/(s56-cmhh2)*rhbb/(s78-cmh2)+
     &             r1h2hh*rhbb/(s56-cmh2)*rhhbb/(s78-cmhh2)+
     &             r2h1hh*rhbb/(s56-cmh2)*rhbb/(s78-cmh2))
  
            enddo
          enddo
        enddo
       enddo
       	endif
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cdum(i1,i2,i3,i4),p=cz12(i1,i2).e,q=cz56(i3,i4).e,bef=,aft=
      cdum(i1,i2,i3,i4)=(cz12(i1,i2).e(0)*cz56(i3,i4).e(0)-cz12(
     & i1,i2).e(1)*cz56(i3,i4).e(1)-cz12(i1,i2).e(2)*cz56(i3,i4)
     & .e(2)-cz12(i1,i2).e(3)*cz56(i3,i4).e(3))
      end do
      end do
      end do
      end do
  
      do i1=1,2
        do i2=1,2
          do i3=1,2
            do i4=1,2
              ch1256(i1,i2,i3,i4)=ch1256(i1,i2,i3,i4)+
     &             rhzz*cdum(i1,i2,i3,i4)
              chh1256(i1,i2,i3,i4)=chh1256(i1,i2,i3,i4)+
     &             rhhzz*cdum(i1,i2,i3,i4)
            enddo
          enddo
        enddo
      enddo
  
      	if(id1.eq.5.and.id5.eq.5)then
      do i1=1,2
        do i2=1,2
          do i3=1,2
            do i4=1,2
              cdum(i1,i2,i3,i4)=ch12(i1,i2)*ch56(i3,i4)
  
              ch1256(i1,i2,i3,i4)=ch1256(i1,i2,i3,i4)
     &             +cdum(i1,i2,i3,i4)*
     &             (r3h*rhbb/(s12-cmh2)*rhbb/(s56-cmh2)+
     &             r2h1hh*rhbb/(s12-cmh2)*rhhbb/(s56-cmhh2)+
     &             r2h1hh*rhhbb/(s12-cmhh2)*rhbb/(s56-cmh2)+
     &             r1h2hh*rhhbb/(s12-cmhh2)*rhhbb/(s56-cmhh2))
  
              chh1256(i1,i2,i3,i4)=chh1256(i1,i2,i3,i4)
     &             +cdum(i1,i2,i3,i4)*
     &             (r3hh*rhhbb/(s12-cmhh2)*rhhbb/(s56-cmhh2)+
     &             r1h2hh*rhhbb/(s12-cmhh2)*rhbb/(s56-cmh2)+
     &             r1h2hh*rhbb/(s12-cmh2)*rhhbb/(s56-cmhh2)+
     &             r2h1hh*rhbb/(s12-cmh2)*rhbb/(s56-cmh2))
  
            enddo
          enddo
        enddo
       enddo
       	endif
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cdum(i1,i2,i3,i4),p=cz34(i1,i2).e,q=cz78(i3,i4).e,bef=,aft=
      cdum(i1,i2,i3,i4)=(cz34(i1,i2).e(0)*cz78(i3,i4).e(0)-cz34(
     & i1,i2).e(1)*cz78(i3,i4).e(1)-cz34(i1,i2).e(2)*cz78(i3,i4)
     & .e(2)-cz34(i1,i2).e(3)*cz78(i3,i4).e(3))
      end do
      end do
      end do
      end do
  
      do i1=1,2
        do i2=1,2
          do i3=1,2
            do i4=1,2
              ch3478(i1,i2,i3,i4)=ch3478(i1,i2,i3,i4)+
     &             rhzz*cdum(i1,i2,i3,i4)
              chh3478(i1,i2,i3,i4)=chh3478(i1,i2,i3,i4)+
     &             rhhzz*cdum(i1,i2,i3,i4)
            enddo
          enddo
        enddo
      enddo
  
      	if(id3.eq.5.and.id7.eq.5)then
      do i1=1,2
        do i2=1,2
          do i3=1,2
            do i4=1,2
              cdum(i1,i2,i3,i4)=ch34(i1,i2)*ch78(i3,i4)
  
              ch3478(i1,i2,i3,i4)=ch3478(i1,i2,i3,i4)
     &             +cdum(i1,i2,i3,i4)*
     &             (r3h*rhbb/(s34-cmh2)*rhbb/(s78-cmh2)+
     &             r2h1hh*rhbb/(s34-cmh2)*rhhbb/(s78-cmhh2)+
     &             r2h1hh*rhhbb/(s34-cmhh2)*rhbb/(s78-cmh2)+
     &             r1h2hh*rhhbb/(s34-cmhh2)*rhhbb/(s78-cmhh2))
  
              chh3478(i1,i2,i3,i4)=chh3478(i1,i2,i3,i4)
     &             +cdum(i1,i2,i3,i4)*
     &             (r3hh*rhhbb/(s34-cmhh2)*rhhbb/(s78-cmhh2)+
     &             r1h2hh*rhhbb/(s34-cmhh2)*rhbb/(s78-cmh2)+
     &             r1h2hh*rhbb/(s34-cmh2)*rhhbb/(s78-cmhh2)+
     &             r2h1hh*rhbb/(s34-cmh2)*rhbb/(s78-cmh2))
  
            enddo
          enddo
        enddo
       enddo
       	endif
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cdum(i1,i2,i3,i4),p=cz12(i1,i2).e,q=cz78(i3,i4).e,bef=,aft=
      cdum(i1,i2,i3,i4)=(cz12(i1,i2).e(0)*cz78(i3,i4).e(0)-cz12(
     & i1,i2).e(1)*cz78(i3,i4).e(1)-cz12(i1,i2).e(2)*cz78(i3,i4)
     & .e(2)-cz12(i1,i2).e(3)*cz78(i3,i4).e(3))
      end do
      end do
      end do
      end do
  
      do i1=1,2
        do i2=1,2
          do i3=1,2
            do i4=1,2
              ch1278(i1,i2,i3,i4)=ch1278(i1,i2,i3,i4)+
     &             rhzz*cdum(i1,i2,i3,i4)
              chh1278(i1,i2,i3,i4)=chh1278(i1,i2,i3,i4)+
     &             rhhzz*cdum(i1,i2,i3,i4)
            enddo
          enddo
        enddo
      enddo
  
      	if(id1.eq.5.and.id7.eq.5)then
      do i1=1,2
        do i2=1,2
          do i3=1,2
            do i4=1,2
              cdum(i1,i2,i3,i4)=ch12(i1,i2)*ch78(i3,i4)
  
              ch1278(i1,i2,i3,i4)=ch1278(i1,i2,i3,i4)
     &             +cdum(i1,i2,i3,i4)*
     &             (r3h*rhbb/(s12-cmh2)*rhbb/(s78-cmh2)+
     &             r2h1hh*rhbb/(s12-cmh2)*rhhbb/(s78-cmhh2)+
     &             r2h1hh*rhhbb/(s12-cmhh2)*rhbb/(s78-cmh2)+
     &             r1h2hh*rhhbb/(s12-cmhh2)*rhhbb/(s78-cmhh2))
  
              chh1278(i1,i2,i3,i4)=chh1278(i1,i2,i3,i4)
     &             +cdum(i1,i2,i3,i4)*
     &             (r3hh*rhhbb/(s12-cmhh2)*rhhbb/(s78-cmhh2)+
     &             r1h2hh*rhhbb/(s12-cmhh2)*rhbb/(s78-cmh2)+
     &             r1h2hh*rhbb/(s12-cmh2)*rhhbb/(s78-cmhh2)+
     &             r2h1hh*rhbb/(s12-cmh2)*rhbb/(s78-cmh2))
  
            enddo
          enddo
        enddo
       enddo
       	endif
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cdum(i1,i2,i3,i4),p=cz34(i1,i2).e,q=cz56(i3,i4).e,bef=,aft=
      cdum(i1,i2,i3,i4)=(cz34(i1,i2).e(0)*cz56(i3,i4).e(0)-cz34(
     & i1,i2).e(1)*cz56(i3,i4).e(1)-cz34(i1,i2).e(2)*cz56(i3,i4)
     & .e(2)-cz34(i1,i2).e(3)*cz56(i3,i4).e(3))
      end do
      end do
      end do
      end do
  
      do i1=1,2
        do i2=1,2
          do i3=1,2
            do i4=1,2
              ch3456(i1,i2,i3,i4)=ch3456(i1,i2,i3,i4)+
     &             rhzz*cdum(i1,i2,i3,i4)
              chh3456(i1,i2,i3,i4)=chh3456(i1,i2,i3,i4)+
     &             rhhzz*cdum(i1,i2,i3,i4)
            enddo
          enddo
        enddo
      enddo
  
      	if(id3.eq.5.and.id5.eq.5)then
      do i1=1,2
        do i2=1,2
          do i3=1,2
            do i4=1,2
              cdum(i1,i2,i3,i4)=ch34(i1,i2)*ch56(i3,i4)
  
              ch3456(i1,i2,i3,i4)=ch3456(i1,i2,i3,i4)
     &             +cdum(i1,i2,i3,i4)*
     &             (r3h*rhbb/(s34-cmh2)*rhbb/(s56-cmh2)+
     &             r2h1hh*rhbb/(s34-cmh2)*rhhbb/(s56-cmhh2)+
     &             r2h1hh*rhhbb/(s34-cmhh2)*rhbb/(s56-cmh2)+
     &             r1h2hh*rhhbb/(s34-cmhh2)*rhhbb/(s56-cmhh2))
  
              chh3456(i1,i2,i3,i4)=chh3456(i1,i2,i3,i4)
     &             +cdum(i1,i2,i3,i4)*
     &             (r3hh*rhhbb/(s34-cmhh2)*rhhbb/(s56-cmhh2)+
     &             r1h2hh*rhhbb/(s34-cmhh2)*rhbb/(s56-cmh2)+
     &             r1h2hh*rhbb/(s34-cmh2)*rhhbb/(s56-cmhh2)+
     &             r2h1hh*rhbb/(s34-cmh2)*rhbb/(s56-cmh2))
  
            enddo
          enddo
        enddo
       enddo
       	endif
  
      endif
  
  
*     		THE QUADRIPLE COUPLING COMPUTATION                              
*                                                                       
*			Z			  H	                                                            
*			|			  |                                                             
*                       |                         |                     
*                 H_ _ _|_ _ _ Z    AND   H _ _ _ |_ _ _H               
*                       |			  |		                                       
*                       |			  |                                         
*                       H			  |                                         
*						  H	                                                             
  
  
*			FIRST ZZHH COUPLING                                                 
  
      if (rmh.ge.0.d0)then
*                                                                       
  
  
*c initialization                                                       
  
 	  do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
        	 do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
  
       cresquad_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=czero
  
                         enddo
                        enddo
                      enddo
                    enddo
                   enddo
                 enddo
               enddo
             enddo
  
  
  
*   ZZHH COUPLING                                                       
  
  
  
       	if(id1.eq.5.and.id3.eq.5)then
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cz_zzhh5678(i1,i2,i3,i4),p=cz56(i1,i2).e,q=cz78(i3,i4).e,be
* f=,aft=
      cz_zzhh5678(i1,i2,i3,i4)=(cz56(i1,i2).e(0)*cz78(i3,i4).e(0
     & )-cz56(i1,i2).e(1)*cz78(i3,i4).e(1)-cz56(i1,i2).e(2)*cz78
     & (i3,i4).e(2)-cz56(i1,i2).e(3)*cz78(i3,i4).e(3))
      end do
      end do
      end do
      end do
  
  
          do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
        	 do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
                           	
       cresquad_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &cresquad_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8) + ch12(i1,i2)*
     &	ch34(i3,i4)*cz_zzhh5678(i5,i6,i7,i8)
     &  *(r2h2z*rhbb**2/(s12-cmh2)/(s34-cmh2)+
     &  r2hh2z*rhhbb**2/(s12-cmhh2)/(s34-cmhh2)+
     &  r1h1hh2z*rhbb*rhhbb/(s12-cmhh2)/(s34-cmh2)+
     &  r1h1hh2z*rhbb*rhhbb/(s12-cmh2)/(s34-cmhh2))
                         enddo
                        enddo
                      enddo
                    enddo
                   enddo
                 enddo
               enddo
             enddo
       endif
  
  
       	if(id5.eq.5.and.id7.eq.5)then
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cz_zzhh1234(i1,i2,i3,i4),p=cz12(i1,i2).e,q=cz34(i3,i4).e,be
* f=,aft=
      cz_zzhh1234(i1,i2,i3,i4)=(cz12(i1,i2).e(0)*cz34(i3,i4).e(0
     & )-cz12(i1,i2).e(1)*cz34(i3,i4).e(1)-cz12(i1,i2).e(2)*cz34
     & (i3,i4).e(2)-cz12(i1,i2).e(3)*cz34(i3,i4).e(3))
      end do
      end do
      end do
      end do
  
  
          do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
        	 do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
                           	
       cresquad_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &cresquad_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8) + ch56(i5,i6)*
     &	ch78(i7,i8)*cz_zzhh1234(i1,i2,i3,i4)
     &  *(r2h2z*rhbb**2/(s56-cmh2)/(s78-cmh2)+
     &  r2hh2z*rhhbb**2/(s56-cmhh2)/(s78-cmhh2)+
     &  r1h1hh2z*rhbb*rhhbb/(s56-cmhh2)/(s78-cmh2)+
     &  r1h1hh2z*rhbb*rhhbb/(s56-cmh2)/(s78-cmhh2))
                         enddo
                        enddo
                      enddo
                    enddo
                   enddo
                 enddo
               enddo
             enddo
       endif
  
  
       	if(id1.eq.5.and.id5.eq.5)then
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cz_zzhh3478(i1,i2,i3,i4),p=cz34(i1,i2).e,q=cz78(i3,i4).e,be
* f=,aft=
      cz_zzhh3478(i1,i2,i3,i4)=(cz34(i1,i2).e(0)*cz78(i3,i4).e(0
     & )-cz34(i1,i2).e(1)*cz78(i3,i4).e(1)-cz34(i1,i2).e(2)*cz78
     & (i3,i4).e(2)-cz34(i1,i2).e(3)*cz78(i3,i4).e(3))
      end do
      end do
      end do
      end do
  
  
          do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
        	 do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
                           	
       cresquad_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &cresquad_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8) + ch12(i1,i2)*
     &	ch56(i5,i6)*cz_zzhh3478(i3,i4,i7,i8)
     &  *(r2h2z*rhbb**2/(s12-cmh2)/(s56-cmh2)+
     &  r2hh2z*rhhbb**2/(s12-cmhh2)/(s56-cmhh2)+
     &  r1h1hh2z*rhbb*rhhbb/(s12-cmhh2)/(s56-cmh2)+
     &  r1h1hh2z*rhbb*rhhbb/(s12-cmh2)/(s56-cmhh2))
                         enddo
                        enddo
                      enddo
                    enddo
                   enddo
                 enddo
               enddo
             enddo
       endif
  
  
       	if(id3.eq.5.and.id7.eq.5)then
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cz_zzhh1256(i1,i2,i3,i4),p=cz12(i1,i2).e,q=cz56(i3,i4).e,be
* f=,aft=
      cz_zzhh1256(i1,i2,i3,i4)=(cz12(i1,i2).e(0)*cz56(i3,i4).e(0
     & )-cz12(i1,i2).e(1)*cz56(i3,i4).e(1)-cz12(i1,i2).e(2)*cz56
     & (i3,i4).e(2)-cz12(i1,i2).e(3)*cz56(i3,i4).e(3))
      end do
      end do
      end do
      end do
  
  
          do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
        	 do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
                           	
       cresquad_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &cresquad_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8) + ch34(i3,i4)*
     &	ch78(i7,i8)*cz_zzhh1256(i1,i2,i5,i6)
     &  *(r2h2z*rhbb**2/(s34-cmh2)/(s78-cmh2)+
     &  r2hh2z*rhhbb**2/(s34-cmhh2)/(s78-cmhh2)+
     &  r1h1hh2z*rhbb*rhhbb/(s34-cmhh2)/(s78-cmh2)+
     &  r1h1hh2z*rhbb*rhhbb/(s34-cmh2)/(s78-cmhh2))
                         enddo
                        enddo
                      enddo
                    enddo
                   enddo
                 enddo
               enddo
             enddo
       endif
  
  
       	if(id1.eq.5.and.id7.eq.5)then
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cz_zzhh3456(i1,i2,i3,i4),p=cz34(i1,i2).e,q=cz56(i3,i4).e,be
* f=,aft=
      cz_zzhh3456(i1,i2,i3,i4)=(cz34(i1,i2).e(0)*cz56(i3,i4).e(0
     & )-cz34(i1,i2).e(1)*cz56(i3,i4).e(1)-cz34(i1,i2).e(2)*cz56
     & (i3,i4).e(2)-cz34(i1,i2).e(3)*cz56(i3,i4).e(3))
      end do
      end do
      end do
      end do
  
  
          do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
        	 do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
                           	
       cresquad_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &cresquad_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8) + ch12(i1,i2)*
     &	ch78(i7,i8)*cz_zzhh3456(i3,i4,i5,i6)
     &  *(r2h2z*rhbb**2/(s12-cmh2)/(s78-cmh2)+
     &  r2hh2z*rhhbb**2/(s12-cmhh2)/(s78-cmhh2)+
     &  r1h1hh2z*rhbb*rhhbb/(s12-cmhh2)/(s78-cmh2)+
     &  r1h1hh2z*rhbb*rhhbb/(s12-cmh2)/(s78-cmhh2))
                         enddo
                        enddo
                      enddo
                    enddo
                   enddo
                 enddo
               enddo
             enddo
       endif
  
  
       	if(id3.eq.5.and.id5.eq.5)then
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cz_zzhh1278(i1,i2,i3,i4),p=cz12(i1,i2).e,q=cz78(i3,i4).e,be
* f=,aft=
      cz_zzhh1278(i1,i2,i3,i4)=(cz12(i1,i2).e(0)*cz78(i3,i4).e(0
     & )-cz12(i1,i2).e(1)*cz78(i3,i4).e(1)-cz12(i1,i2).e(2)*cz78
     & (i3,i4).e(2)-cz12(i1,i2).e(3)*cz78(i3,i4).e(3))
      end do
      end do
      end do
      end do
  
  
          do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
        	 do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
                           	
       cresquad_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &cresquad_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8) + ch34(i3,i4)*
     &	ch56(i5,i6)*cz_zzhh1278(i1,i2,i7,i8)
     &  *(r2h2z*rhbb**2/(s34-cmh2)/(s56-cmh2)+
     &  r2hh2z*rhhbb**2/(s34-cmhh2)/(s56-cmhh2)+
     &  r1h1hh2z*rhbb*rhhbb/(s34-cmhh2)/(s56-cmh2)+
     &  r1h1hh2z*rhbb*rhhbb/(s34-cmh2)/(s56-cmhh2))
                         enddo
                        enddo
                      enddo
                    enddo
                   enddo
                 enddo
               enddo
             enddo
       endif
  
*		AND THEN HHHH COUPLING                                               
      		
        if(id1.eq.5.and.id3.eq.5.and.id5.eq.5.and.id7.eq.5)then
           do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
        	 do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
        cresquad_hh_hh(i1,i2,i3,i4,i5,i6).pol(i7,i8)= ch12(i1,i2)*
     &   ch34(i3,i4)*ch56(i5,i6)*ch78(i7,i8)
     &   *(r4h*rhbb**4/(s12-cmh2)/(s34-cmh2)
     &                       /(s56-cmh2)/(s78-cmh2)+
     &    r4hh*rhhbb**4/(s12-cmhh2)/(s34-cmhh2)
     &                       /(s56-cmhh2)/(s78-cmhh2)+
     &    r1h3hh*rhbb*rhhbb**3*
     &     (1.d0/(s12-cmh2)/(s34-cmhh2)/(s56-cmhh2)/(s78-cmhh2)+
     &      1.d0/(s12-cmhh2)/(s34-cmh2)/(s56-cmhh2)/(s78-cmhh2)+
     &      1.d0/(s12-cmhh2)/(s34-cmhh2)/(s56-cmh2)/(s78-cmhh2)+
     &     1.d0/(s12-cmhh2)/(s34-cmhh2)/(s56-cmhh2)/(s78-cmh2))+
     &    r2h2hh*rhbb**2*rhhbb**2*
     &     (1.d0/(s12-cmh2)/(s34-cmh2)/(s56-cmhh2)/(s78-cmhh2)+
     &      1.d0/(s12-cmh2)/(s34-cmhh2)/(s56-cmh2)/(s78-cmhh2)+
     &      1.d0/(s12-cmh2)/(s34-cmhh2)/(s56-cmhh2)/(s78-cmh2)+
     &      1.d0/(s12-cmhh2)/(s34-cmh2)/(s56-cmh2)/(s78-cmhh2)+
     &      1.d0/(s12-cmhh2)/(s34-cmh2)/(s56-cmhh2)/(s78-cmh2)+
     &      1.d0/(s12-cmhh2)/(s34-cmhh2)/(s56-cmh2)/(s78-cmh2))+
     &    r3h1hh*rhbb**3*rhhbb*
     &     (1.d0/(s12-cmhh2)/(s34-cmh2)/(s56-cmh2)/(s78-cmh2)+
     &      1.d0/(s12-cmh2)/(s34-cmhh2)/(s56-cmh2)/(s78-cmh2)+
     &      1.d0/(s12-cmh2)/(s34-cmh2)/(s56-cmhh2)/(s78-cmh2)+
     &      1.d0/(s12-cmh2)/(s34-cmh2)/(s56-cmh2)/(s78-cmhh2)))
  
                         enddo
                        enddo
                      enddo
                    enddo
                   enddo
                 enddo
               enddo
             enddo    	
       	else
           do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
        	 do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
                             	
          cresquad_hh_hh(i1,i2,i3,i4,i5,i6).pol(i7,i8)= czero
  
                         enddo
                        enddo
                      enddo
                    enddo
                   enddo
                 enddo
               enddo
             enddo    	
  
                    	
      	endif
       endif	
  
  
  
  
*  COMPUTE DIAGRAMS WITH ONE Z,GAMMA,H, PROPAGATOR CONNECTING TWO "Z" ON
*SIDE AND TWO  "Z" ON THE OTHER                                         
  
  
  
  
 	  do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
        	 do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
  
  
       creszz_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=czero
       creszz_h_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=czero
       creszz_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=czero
                         enddo
                        enddo
                      enddo
                    enddo
                   enddo
                 enddo
               enddo
             enddo
  
  
  
* FIRST COMPUTE DIAGRAMS WITH ONE Z  PROPAGATOR CONNECTING TWO "Z" ON ON
*SIDE AND TWO  "Z" ON THE OTHER                                         
* creszz_z_zz(2,2,2,2,2,2).pol(2,2)                                     
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cp1234dotcz1234(i1,i2,i3,i4),p=p1234(#),q=cz1234(i1,i2,i3,i
* 4,#),bef=,aft=
      cp1234dotcz1234(i1,i2,i3,i4)=(p1234(0)*cz1234(i1,i2,i3,i4,
     & 0)-p1234(1)*cz1234(i1,i2,i3,i4,1)-p1234(2)*cz1234(i1,i2,i
     & 3,i4,2)-p1234(3)*cz1234(i1,i2,i3,i4,3))
      end do
      end do
      end do
      end do
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cp1234dotcz5678(i1,i2,i3,i4),p=p1234(#),q=cz5678(i1,i2,i3,i
* 4,#),bef=,aft=
      cp1234dotcz5678(i1,i2,i3,i4)=(p1234(0)*cz5678(i1,i2,i3,i4,
     & 0)-p1234(1)*cz5678(i1,i2,i3,i4,1)-p1234(2)*cz5678(i1,i2,i
     & 3,i4,2)-p1234(3)*cz5678(i1,i2,i3,i4,3))
      end do
      end do
      end do
      end do
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* p.q -- p.q=creszz_z_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8),p=cz1234(i1,i2,i3
* ,i4,#),q=cz5678(i5,i6,i7,i8,#),bef=-,aft=/(p1234q-cmz2)
      creszz_z_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=-(cz1234(i1,i2,i
     & 3,i4,0)*cz5678(i5,i6,i7,i8,0)-cz1234(i1,i2,i3,i4,1)*cz567
     & 8(i5,i6,i7,i8,1)-cz1234(i1,i2,i3,i4,2)*cz5678(i5,i6,i7,i8
     & ,2)-cz1234(i1,i2,i3,i4,3)*cz5678(i5,i6,i7,i8,3))/(p1234q-
     & cmz2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
  
* SECOND COMPUTE DIAGRAMS WITH ONE GAMMA  PROPAGATOR CONNECTING TWO "Z" 
*SIDE AND TWO  "Z" ON THE OTHER                                         
  
* creszz_f_zz(2,2,2,2,2,2).pol(2,2)                                     
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* p.q -- p.q=creszz_f_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8),p=cf1234(i1,i2,i3
* ,i4,#),q=cf5678(i5,i6,i7,i8,#),bef=-,aft=/(p1234q)
      creszz_f_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=-(cf1234(i1,i2,i
     & 3,i4,0)*cf5678(i5,i6,i7,i8,0)-cf1234(i1,i2,i3,i4,1)*cf567
     & 8(i5,i6,i7,i8,1)-cf1234(i1,i2,i3,i4,2)*cf5678(i5,i6,i7,i8
     & ,2)-cf1234(i1,i2,i3,i4,3)*cf5678(i5,i6,i7,i8,3))/(p1234q)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
*THIRD THE SUM OF THE ABOVE AMPLITUDES Z+GAMMA PROPAGATOR CONNECTING TWO
*ONE SIDE AND TWO  "Z" ON THE OTHER PLUS THE PMU*PNU /Mz**2 TERM OF THE 
*PROPAGATORS                                                            
  
* creszz_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=creszz_z_zz(2,2,2,2,2,2).pol(2
*creszz_f_zz(2,2,2,2,2,2).pol(2,2)+pmu pnu/mz**2 term                   
  
 	  do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
        	 do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
  
       creszz_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=creszz_zz
     & (i1,i2,i3,i4,i5,i6).pol(i7,i8)+creszz_z_zz
     & (i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     & (cp1234dotcz1234(i1,i2,i3,i4)*cp1234dotcz5678(
     & i5,i6,i7,i8))/cmz2/(p1234q-cmz2)+creszz_f_zz(i1,i2,i3,i4,
     & i5,i6).pol(i7,i8)
  
                      	  enddo
                        enddo
                      enddo
                    enddo
                   enddo
                 enddo
               enddo
             enddo
  
*FOURTH COMPUTE DIAGRAMS WITH H HIGGS  PROPAGATOR CONNECTING TWO "Z" ON 
*SIDE AND TWO  "Z" ON THE OTHER                                         
  
       	if(rmh.ge.0.d0)then
  
* sig                                                                   
          if (i_signal.eq.0) then
            do i1=1,2
              do i2=1,2
                do i3=1,2
                  do i4=1,2
                    do i5=1,2
                      do i6=1,2
                        do i7=1,2
                          do i8=1,2
  	creszz_h_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=creszz_h_zz(i1,i2,i3,i4,
     &i5,i6).pol(i7,i8)+ch1234(i1,i2,i3,i4)*
     & ch5678(i5,i6,i7,i8)/(p1234q-cmh2)
  	creszz_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=creszz_hh_zz(i1,i2,i3,i4,
     &i5,i6).pol(i7,i8)+chh1234(i1,i2,i3,i4)*
     & chh5678(i5,i6,i7,i8)/(p1234q-cmhh2)
                          enddo
                        enddo
                      enddo
                    enddo
                  enddo
                enddo
              enddo
            enddo
          else if (i_signal.eq.1) then
            if (p1234q.gt.0.d0) then
              do i1=1,2
                do i2=1,2
                  do i3=1,2
                    do i4=1,2
                      do i5=1,2
                        do i6=1,2
                          do i7=1,2
                            do i8=1,2
  	creszz_h_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=ch1234(i1,i2,i3,i4)*
     &                           ch5678(i5,i6,i7,i8)/(p1234q-cmh2)
  	creszz_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=chh1234(i1,i2,i3,i4)*
     &                           chh5678(i5,i6,i7,i8)/(p1234q-cmhh2)
                            enddo
                          enddo
                        enddo
                      enddo
                    enddo
                  enddo
                enddo
              enddo
            endif
          else
            print*, 'ERROR: check i_signal value'
            stop
          endif
  
* sigend 	                                                              
       	endif	
  
* FIRST COMPUTE DIAGRAMS WITH ONE Z  PROPAGATOR CONNECTING TWO "Z" ON ON
*SIDE AND TWO  "Z" ON THE OTHER                                         
* creszz_z_zz(2,2,2,2,2,2).pol(2,2)                                     
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cp1256dotcz1256(i1,i2,i3,i4),p=p1256(#),q=cz1256(i1,i2,i3,i
* 4,#),bef=,aft=
      cp1256dotcz1256(i1,i2,i3,i4)=(p1256(0)*cz1256(i1,i2,i3,i4,
     & 0)-p1256(1)*cz1256(i1,i2,i3,i4,1)-p1256(2)*cz1256(i1,i2,i
     & 3,i4,2)-p1256(3)*cz1256(i1,i2,i3,i4,3))
      end do
      end do
      end do
      end do
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cp1256dotcz3478(i1,i2,i3,i4),p=p1256(#),q=cz3478(i1,i2,i3,i
* 4,#),bef=,aft=
      cp1256dotcz3478(i1,i2,i3,i4)=(p1256(0)*cz3478(i1,i2,i3,i4,
     & 0)-p1256(1)*cz3478(i1,i2,i3,i4,1)-p1256(2)*cz3478(i1,i2,i
     & 3,i4,2)-p1256(3)*cz3478(i1,i2,i3,i4,3))
      end do
      end do
      end do
      end do
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* p.q -- p.q=creszz_z_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8),p=cz1256(i1,i2,i3
* ,i4,#),q=cz3478(i5,i6,i7,i8,#),bef=-,aft=/(p1256q-cmz2)
      creszz_z_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=-(cz1256(i1,i2,i
     & 3,i4,0)*cz3478(i5,i6,i7,i8,0)-cz1256(i1,i2,i3,i4,1)*cz347
     & 8(i5,i6,i7,i8,1)-cz1256(i1,i2,i3,i4,2)*cz3478(i5,i6,i7,i8
     & ,2)-cz1256(i1,i2,i3,i4,3)*cz3478(i5,i6,i7,i8,3))/(p1256q-
     & cmz2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
  
* SECOND COMPUTE DIAGRAMS WITH ONE GAMMA  PROPAGATOR CONNECTING TWO "Z" 
*SIDE AND TWO  "Z" ON THE OTHER                                         
  
* creszz_f_zz(2,2,2,2,2,2).pol(2,2)                                     
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* p.q -- p.q=creszz_f_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8),p=cf1256(i1,i2,i3
* ,i4,#),q=cf3478(i5,i6,i7,i8,#),bef=-,aft=/(p1256q)
      creszz_f_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=-(cf1256(i1,i2,i
     & 3,i4,0)*cf3478(i5,i6,i7,i8,0)-cf1256(i1,i2,i3,i4,1)*cf347
     & 8(i5,i6,i7,i8,1)-cf1256(i1,i2,i3,i4,2)*cf3478(i5,i6,i7,i8
     & ,2)-cf1256(i1,i2,i3,i4,3)*cf3478(i5,i6,i7,i8,3))/(p1256q)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
*THIRD THE SUM OF THE ABOVE AMPLITUDES Z+GAMMA PROPAGATOR CONNECTING TWO
*ONE SIDE AND TWO  "Z" ON THE OTHER PLUS THE PMU*PNU /Mz**2 TERM OF THE 
*PROPAGATORS                                                            
  
* creszz_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=creszz_z_zz(2,2,2,2,2,2).pol(2
*creszz_f_zz(2,2,2,2,2,2).pol(2,2)+pmu pnu/mz**2 term                   
  
 	  do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
        	 do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
  
       creszz_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=creszz_zz
     & (i1,i2,i3,i4,i5,i6).pol(i7,i8)+creszz_z_zz
     & (i1,i2,i5,i6,i3,i4).pol(i7,i8)+
     & (cp1256dotcz1256(i1,i2,i5,i6)*cp1256dotcz3478(
     & i3,i4,i7,i8))/cmz2/(p1256q-cmz2)+creszz_f_zz(i1,i2,i5,i6,
     & i3,i4).pol(i7,i8)
  
                      	  enddo
                        enddo
                      enddo
                    enddo
                   enddo
                 enddo
               enddo
             enddo
  
*FOURTH COMPUTE DIAGRAMS WITH H HIGGS  PROPAGATOR CONNECTING TWO "Z" ON 
*SIDE AND TWO  "Z" ON THE OTHER                                         
  
       	if(rmh.ge.0.d0)then
  
* sig                                                                   
          if (i_signal.eq.0) then
            do i1=1,2
              do i2=1,2
                do i3=1,2
                  do i4=1,2
                    do i5=1,2
                      do i6=1,2
                        do i7=1,2
                          do i8=1,2
  	creszz_h_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=creszz_h_zz(i1,i2,i3,i4,
     &i5,i6).pol(i7,i8)+ch1256(i1,i2,i5,i6)*
     & ch3478(i3,i4,i7,i8)/(p1256q-cmh2)
  	creszz_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=creszz_hh_zz(i1,i2,i3,i4,
     &i5,i6).pol(i7,i8)+chh1256(i1,i2,i5,i6)*
     & chh3478(i3,i4,i7,i8)/(p1256q-cmhh2)
                          enddo
                        enddo
                      enddo
                    enddo
                  enddo
                enddo
              enddo
            enddo
          else if (i_signal.eq.1) then
            if (p1256q.gt.0.d0) then
              do i1=1,2
                do i2=1,2
                  do i3=1,2
                    do i4=1,2
                      do i5=1,2
                        do i6=1,2
                          do i7=1,2
                            do i8=1,2
  	creszz_h_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=ch1256(i1,i2,i5,i6)*
     &                           ch3478(i3,i4,i7,i8)/(p1256q-cmh2)
  	creszz_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=chh1256(i1,i2,i5,i6)*
     &                           chh3478(i3,i4,i7,i8)/(p1256q-cmhh2)
                            enddo
                          enddo
                        enddo
                      enddo
                    enddo
                  enddo
                enddo
              enddo
            endif
          else
            print*, 'ERROR: check i_signal value'
            stop
          endif
  
* sigend 	                                                              
       	endif	
  
* FIRST COMPUTE DIAGRAMS WITH ONE Z  PROPAGATOR CONNECTING TWO "Z" ON ON
*SIDE AND TWO  "Z" ON THE OTHER                                         
* creszz_z_zz(2,2,2,2,2,2).pol(2,2)                                     
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cp1278dotcz1278(i1,i2,i3,i4),p=p1278(#),q=cz1278(i1,i2,i3,i
* 4,#),bef=,aft=
      cp1278dotcz1278(i1,i2,i3,i4)=(p1278(0)*cz1278(i1,i2,i3,i4,
     & 0)-p1278(1)*cz1278(i1,i2,i3,i4,1)-p1278(2)*cz1278(i1,i2,i
     & 3,i4,2)-p1278(3)*cz1278(i1,i2,i3,i4,3))
      end do
      end do
      end do
      end do
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
* p.q -- p.q=cp1278dotcz3456(i1,i2,i3,i4),p=p1278(#),q=cz3456(i1,i2,i3,i
* 4,#),bef=,aft=
      cp1278dotcz3456(i1,i2,i3,i4)=(p1278(0)*cz3456(i1,i2,i3,i4,
     & 0)-p1278(1)*cz3456(i1,i2,i3,i4,1)-p1278(2)*cz3456(i1,i2,i
     & 3,i4,2)-p1278(3)*cz3456(i1,i2,i3,i4,3))
      end do
      end do
      end do
      end do
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* p.q -- p.q=creszz_z_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8),p=cz1278(i1,i2,i3
* ,i4,#),q=cz3456(i5,i6,i7,i8,#),bef=-,aft=/(p1278q-cmz2)
      creszz_z_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=-(cz1278(i1,i2,i
     & 3,i4,0)*cz3456(i5,i6,i7,i8,0)-cz1278(i1,i2,i3,i4,1)*cz345
     & 6(i5,i6,i7,i8,1)-cz1278(i1,i2,i3,i4,2)*cz3456(i5,i6,i7,i8
     & ,2)-cz1278(i1,i2,i3,i4,3)*cz3456(i5,i6,i7,i8,3))/(p1278q-
     & cmz2)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
  
* SECOND COMPUTE DIAGRAMS WITH ONE GAMMA  PROPAGATOR CONNECTING TWO "Z" 
*SIDE AND TWO  "Z" ON THE OTHER                                         
  
* creszz_f_zz(2,2,2,2,2,2).pol(2,2)                                     
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
* p.q -- p.q=creszz_f_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8),p=cf1278(i1,i2,i3
* ,i4,#),q=cf3456(i5,i6,i7,i8,#),bef=-,aft=/(p1278q)
      creszz_f_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=-(cf1278(i1,i2,i
     & 3,i4,0)*cf3456(i5,i6,i7,i8,0)-cf1278(i1,i2,i3,i4,1)*cf345
     & 6(i5,i6,i7,i8,1)-cf1278(i1,i2,i3,i4,2)*cf3456(i5,i6,i7,i8
     & ,2)-cf1278(i1,i2,i3,i4,3)*cf3456(i5,i6,i7,i8,3))/(p1278q)
      end do
      end do
      end do
      end do
      end do
      end do
      end do
      end do
  
*THIRD THE SUM OF THE ABOVE AMPLITUDES Z+GAMMA PROPAGATOR CONNECTING TWO
*ONE SIDE AND TWO  "Z" ON THE OTHER PLUS THE PMU*PNU /Mz**2 TERM OF THE 
*PROPAGATORS                                                            
  
* creszz_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=creszz_z_zz(2,2,2,2,2,2).pol(2
*creszz_f_zz(2,2,2,2,2,2).pol(2,2)+pmu pnu/mz**2 term                   
  
 	  do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
        	 do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
  
       creszz_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=creszz_zz
     & (i1,i2,i3,i4,i5,i6).pol(i7,i8)+creszz_z_zz
     & (i1,i2,i7,i8,i3,i4).pol(i5,i6)+
     & (cp1278dotcz1278(i1,i2,i7,i8)*cp1278dotcz3456(
     & i3,i4,i5,i6))/cmz2/(p1278q-cmz2)+creszz_f_zz(i1,i2,i7,i8,
     & i3,i4).pol(i5,i6)
  
                      	  enddo
                        enddo
                      enddo
                    enddo
                   enddo
                 enddo
               enddo
             enddo
  
*FOURTH COMPUTE DIAGRAMS WITH H HIGGS  PROPAGATOR CONNECTING TWO "Z" ON 
*SIDE AND TWO  "Z" ON THE OTHER                                         
  
       	if(rmh.ge.0.d0)then
  
* sig                                                                   
          if (i_signal.eq.0) then
            do i1=1,2
              do i2=1,2
                do i3=1,2
                  do i4=1,2
                    do i5=1,2
                      do i6=1,2
                        do i7=1,2
                          do i8=1,2
  	creszz_h_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=creszz_h_zz(i1,i2,i3,i4,
     &i5,i6).pol(i7,i8)+ch1278(i1,i2,i7,i8)*
     & ch3456(i3,i4,i5,i6)/(p1278q-cmh2)
  	creszz_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=creszz_hh_zz(i1,i2,i3,i4,
     &i5,i6).pol(i7,i8)+chh1278(i1,i2,i7,i8)*
     & chh3456(i3,i4,i5,i6)/(p1278q-cmhh2)
                          enddo
                        enddo
                      enddo
                    enddo
                  enddo
                enddo
              enddo
            enddo
          else if (i_signal.eq.1) then
            if (p1278q.gt.0.d0) then
              do i1=1,2
                do i2=1,2
                  do i3=1,2
                    do i4=1,2
                      do i5=1,2
                        do i6=1,2
                          do i7=1,2
                            do i8=1,2
  	creszz_h_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=ch1278(i1,i2,i7,i8)*
     &                           ch3456(i3,i4,i5,i6)/(p1278q-cmh2)
  	creszz_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=chh1278(i1,i2,i7,i8)*
     &                           chh3456(i3,i4,i5,i6)/(p1278q-cmhh2)
                            enddo
                          enddo
                        enddo
                      enddo
                    enddo
                  enddo
                enddo
              enddo
            endif
          else
            print*, 'ERROR: check i_signal value'
            stop
          endif
  
* sigend 	                                                              
       	endif	
*sig                                                                    
      if (rmh.ge.0.d0.and.i_signal.eq.1.and.p1234q.le.0.d0.and.
     &      p1256q.le.0.d0.and.p1278q.le.0.d0) then
        do i1=1,2
          do i2=1,2
            do i3=1,2
              do i4=1,2
                do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
                        creszz_h_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=czero
                        creszz_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)=czero
                      enddo
                    enddo
                  enddo
                enddo
              enddo
            enddo
          enddo
        enddo
      endif
*sigend                                                                 
        spk0=sqrt(p1k0*p2k0*p3k0*p4k0*p5k0*p6k0*p7k0*p8k0)
        res=0.d0
  
 	  do i1=1,2
            do i2=1,2
              do i3=1,2
                do i4=1,2
        	 do i5=1,2
                  do i6=1,2
                    do i7=1,2
                      do i8=1,2
  
         if(rmh.ge.0.d0)then
  
*TOTAL AMPLITUDE WITH HIGGS CONTRIBUITON                                
* sig                                                                   
           if (i_signal.eq.0) then
      cres(i1,i2,i3,i4,i5,i6).pol(i7,i8)=(creszz_zz(i1,i2,i3,i4,i5,i6).
     &pol(i7,i8)+cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &creszz_h_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &creszz_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &cresquad_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)+
     &cresquad_hh_hh(i1,i2,i3,i4,i5,i6).pol(i7,i8))/spk0
           else if (i_signal.eq.1) then
      cres(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &creszz_h_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)/spk0
     &+creszz_hh_zz(i1,i2,i3,i4,i5,i6).pol(i7,i8)/spk0
           endif
* sigend                                                                
       	 else
  
*TOTAL AMPLITUDE BUT  WITHOUT  HIGGS CONTRIBUITON                       
                                        	
      cres(i1,i2,i3,i4,i5,i6).pol(i7,i8)=(creszz_zz(i1,i2,i3,i4,i5,i6).
     &	 pol(i7,i8)+cres_3forks(i1,i2,i3,i4,i5,i6).pol(i7,i8))/spk0
  
         endif
  
*SQUARING                                                               
  
*      res=res+ cres(i1,i2,i3,i4,i5,i6).pol(i7,i8)*                     
*     &conjg(cres(i1,i2,i3,i4,i5,i6).pol(i7,i8))                        
  
                         enddo
                        enddo
                      enddo
                    enddo
                   enddo
                 enddo
               enddo
             enddo
  
*         res=res/(p1k0*p2k0*p3k0*p4k0*p5k0*p6k0*p7k0*p8k0)             
  
*diogo 10/2009 unitarization part                                       
  
*                                                                       
* ZZZZ Quartic effective coupling and unitarization                     
*                                                                       
  
      if (i_unitarize.eq.1) then
  
       call unit_4z(p12,s12,cz12,p34,s34,cz34,
     &    p56,s56,cz56,p78,s78,cz78,cunit)
  
      do i1=1,2
      do i2=1,2
      do i3=1,2
      do i4=1,2
      do i5=1,2
      do i6=1,2
      do i7=1,2
      do i8=1,2
  
       cres(i1,i2,i3,i4,i5,i6).pol(i7,i8)=
     &   cres(i1,i2,i3,i4,i5,i6).pol(i7,i8) +
     &   cunit(i1,i2,i3,i4,i5,i6).pol(i7,i8)/spk0
  
      enddo
      enddo
      enddo
      enddo
      enddo
      enddo
      enddo
      enddo
  
      endif
*end diogo                                                              
       	return
       	end
