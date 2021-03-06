      subroutine fpiint(nx,np,nxp,x,w)
ctakao. Maybe it will be better to replace this with spherical design
cas http://www2.research.att.com/~njas/sphdesigns/
c
C- Points and weights for integration on a sphere surface
C ----------------------------------------------------------------------
Ci Inputs
Ci   nx    :number of points in polar angle (Legendre integration)
Ci          Use nx<0 for special points; see Remarks.
Ci   np    :number of points in phi (uniform points)
Ci         :np=0 => np depends on nx making dphi approx constant.
Ci          for nx<0, np is not used.
Co Outputs
Co   nxp   :total number of number of points in quadrature
Co   x     :cartesian coordinates of points on unit sphere
Co   w     :weights corresponding to x
Cr Remarks
Cr   fpiint generates a mesh of points on a unit sphere for angular
Cr   integration, either using a set of special generated from the
Cr   Platonic solids, or by integrating the polar angle with Legendre
Cr   gaussian quadrature and the azimuthal angle with a set of evenly
Cr   spaced points on a circle.
Cr   For special points, invoke fpiint with one of the following:
C     nx= -4 integrates any ylm<=2 exactly (tetrahedron)
C     nx= -6 integrates any ylm<=3 exactly (faces of cube)
C     nx= -8 integrates any ylm<=3 exactly (cube)
C        -12 integrates any ylm<=5 exactly (icosahedron)
C        -20 integrates any ylm<=5 exactly (faces of icosahedron)
C        -30 integrates any ylm<=5 exactly (sides of icosahedron)
C        -60 integrates any ylm<=5 exactly (buckeyball)
C        -32 integrates any ylm<=9 exactly  (combination of 12,20)
C        -62 integrates any ylm<=11 exactly (combination of 12,20,30)
C        -92 integrates any ylm<=11 exactly (combination of 12,20,60)
C       -122 integrates any ylm<=15 exactly (combination of 12,20,30,60)
C ----------------------------------------------------------------------
C     implicit none
      integer nx,np,nxp
      double precision x(3,*),w(*),fpi
      integer i,iprint

      if (nx .ge. 0) then
        call nintsp(nx,np,nxp,x,w)
      else
        fpi = 16*datan(1d0)
        nxp = -nx
        if (nx .eq. -32) then
          call platsl(x,12)
          call platsl(x(1,13),20)
          do  10  i = 1, 12
   10     w(i) = 5d0*fpi/(14*12)
          do  12  i = 13, 32
   12     w(i) = 9d0*fpi/(14*20)
        elseif (nx .eq. -62) then
          call platsl(x,12)
          call platsl(x(1,13),20)
          call platsl(x(1,33),30)
          do  110  i = 1, 12
  110     w(i) = 125d0*fpi/(14*12*33)
          do  112  i = 13, 32
  112     w(i) = 81d0*fpi/(14*20*33)
          do  114  i = 33, 62
  114     w(i) = 256d0*fpi/(14*30*33)
        elseif (nx .eq. -92) then
          call platsl(x,12)
          call platsl(x(1,13),20)
          call platsl(x(1,33),60)
          do  210  i = 1, 12
  210     w(i) = 1/12.34817490904537d0*fpi/12
          do  212  i = 13, 32
  212     w(i) = 2.986997567806883d0/12.34817490904537d0*fpi/20
          do  214  i = 33, 92
  214     w(i) = 8.361177341238484d0/12.34817490904537d0*fpi/60
        elseif (nx .eq. -122) then
          call platsl(x,12)
          call platsl(x(1,13),20)
          call platsl(x(1,33),30)
          call platsl(x(1,63),60)
          do  310  i = 1, 12
  310     w(i) = (0.0939463041645901d0)*fpi/12
          do  312  i = 13, 32
  312     w(i) = (0.2373458837681504d0)*fpi/20
          do  314  i = 33, 92
  314     w(i) = (0.0378880378880377d0)*fpi/30
          do  316  i = 63, 122
  316     w(i) = (0.6308197741792218d0)*fpi/60
        else
          call platsl(x,nxp)
          do  20  i = 1, nxp
   20     w(i) = fpi/nxp
        endif
      endif

C --- Printout ---
      if (iprint() .lt. 80) return
      print '(/'' fpiint:'',i5,'' points generated:'')', nxp
      do  90  i = 1, nxp
   90 print 333, i, x(1,i), x(2,i), x(3,i), w(i)
  333 format(i3,4f20.15)

      end

