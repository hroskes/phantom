*     triple vertices auxiliary
      dimension vfz(0:3), vwm(0:3), vwp(0:3)

*     complex polarization vector
      structure/polcom/
        double complex e(0:3),ek0,v
      end structure

********************NON ZERO MASS********************************

*     ts
*     output of tsts,tst,tts,tt,ttsc,tsct,tstsc,tscts
*     X X X X
*     X X X X
*     X X X X
*     X X X X
      structure/ts/
        double complex a(2,2),b(2,2),c(2,2),d(2,2)
      end structure    

*     t
*     output of t
*     a(1,1),a(2,2),b(1,2),b(2,1),c(1,2),c(2,1),d(1,1),d(2,2)
*     X 0 0 X
*     0 X X 0
*     0 X X 0
*     X 0 0 X
      structure/t/
        double complex a(2,2),b(2,2),c(2,2),d(2,2)
      end structure

*     th
*     output of th,tsc
*     a(1,2),a(2,1),b(1,1),b(2,2),c(1,1),c(2,2)
*     0 X X 0 
*     X 0 0 X
*     X 0 0 0
*     0 X 0 0
      structure/th/
        double complex a(2,2),b(2,2),c(2,2)        
      end structure

*     tx
*     output of t (+th)
*     a(1,1),a(2,2),b(1,2),b(2,1),c(1,2),c(2,1),d(1,1),d(2,2)
*     a(1,2),a(2,1),b(1,1),b(2,2),c(1,1),c(2,2)
*     T H H T
*     H T T H
*     H T T 0
*     T H 0 T
      structure/tx/
        double complex a(2,2),b(2,2),c(2,2),d(2,2)
      end structure
  
*     tw
*     output of tw,twtw
*     a(2,2),b(1,2),c(2,1),d(1,1)
*     0 0 0 0
*     0 X X 0
*     0 X X 0
*     0 0 0 0
      structure/tw/
        double complex a(2:2,2:2),b(1:1,2:2),c(2:2,1:1),d(1:1,1:1)
      end structure

*     ttw combination
*     output of tstw,ttw
*     a(1,2),a(2,2),b(1,2),b(2,2),c(1,1),c(2,1),d(1,1),d(2,1)
*     0 X X 0
*     0 X X 0
*     0 X X 0
*     0 X X 0
      structure/ttw/
        double complex a(2,2:2),b(2,2:2),c(2,1:1),d(2,1:1)
      end structure   

*     twt combination
*     output of twts,twt
*     a(2,1),a(2,2),b(1,1),b(1,2),c(2,1),c(2,2),d(1,1),d(1,2)
*     0 0 0 0
*     X X X X
*     X X X X
*     0 0 0 0
      structure/twt/
        double complex a(2:2,2),b(1:1,2),c(2:2,2),d(1:1,2)
      end structure   

************************ZERO MASS*******************************

*     tw0 
*     output of tw0
*     a(2),b(1),c(2),d(1)
*     0 0 0 0
*     0 X X 0
*     0 X X 0
*     0 0 0 0
      structure/tw0/
        double complex a(2:2),b(1:1),c(2:2),d(1:1)
      end structure

*     twl0
*     output of twl0,tlt0_w
*     a(2),c(2)
*     0 0 0 0
*     0 X X 0
*     0 0 0 0
*     0 0 0 0
      structure/twl0/
        double complex a(2:2),c(2:2)
      end structure

*     twr0
*     output of twr0,ttr0_w
*     a(2),b(1)
*     0 0 0 0
*     0 X 0 0
*     0 X 0 0
*     0 0 0 0
      structure/twr0/
        double complex a(2:2),b(1:1)
      end structure

*     t0 
*     output of t0
*     a(1),a(2),b(1),b(2),c(1),c(2),d(1),d(2)
*     X 0 0 X
*     0 X X 0
*     0 X X 0
*     X 0 0 X
      structure/t0/
         double complex a(2),b(2),c(2),d(2)
      end structure

*     tl0
*     output of tl0,tlt0
*     a(1),a(2),c(1),c(2)
*     X 0 0 X
*     0 X X 0
*     0 0 0 0
*     0 0 0 0
      structure/tl0/
         double complex a(2),c(2)
      end structure

*     tr0
*     output of tr0,ttr0
*     a(1),a(2),b(1),b(2)
*     X 0 0 0
*     0 X 0 0
*     0 X 0 0
*     X 0 0 0
      structure/tr0/
         double complex a(2),b(2)
      end structure


