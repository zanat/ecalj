### You need to set switches (1) to (6), by hand ###

#(1) Compilar ###################
# ... Fortran and linker switches for machine LINUX with intel fortran

FC = mpif90 -132 -xHost -mcmodel=medium -heap-arrays 100
#FC = f95 

# -cm is supress all comment.
# -w95 and -w90 is to remove noisy warning related to f90 and f95 recommendations.
# See http://www.intel.com/software/products/compilers/flin/docs/ug/msg_warn.htm


#(2) CPP SWITCHES ###################
CPPSWITCH_INTELLINUXIFC  = \
-DEXPAND_ISWAP  -DEXPAND_VDV   -DCOMMONLL  -UDUMMY_ETIME -DEXPAND_MELPLN2         \
-DUSE_X0KBLAS   -DX0KBLAS_DIV  -UEXPAND_SUBSTITUTION     -UCOMMENTOUTfor_PARALLEL \
-DMbytes_X0KBLAS_DIV=2        -DNWORD_RECORDSIZE=1 -DEXPAND_SORTEA \
-DUSE_GEMM_FOR_SUM


#(3) Compilar options ###############################################
### INTEL FORTRAN LINUX ###
#FFLAGS=-O0 -check bounds -traceback -g -cpp $(CPPSWITCH_INTELLINUXIFC)
#FFLAGS_OMP=-O0 -check bounds -traceback -g -cpp $(CPPSWITCH_INTELLINUXIFC)
FFLAGS=-O3 -cpp $(CPPSWITCH_INTELLINUXIFC)
FFLAGS_OMP= -openmp -O3 -cpp $(CPPSWITCH_INTELLINUXIFC)

#gfortran
#FFLAGS=  -O3  -fomit-frame-pointer -funroll-loops  -ffast-math -ffixed-line-length-132
#FFLAGS=  -O0  -ffixed-line-length-132

#
### Don't change para_g = .o ... below (or modify it if you know how this work) 
#### don't need to read here #####NoteStart
# Some groups of .f sources are compiled into .c*_o files.  (* is 1 to 4).
# The compile options are in FFLAGS_c*. The others are with .o and FFLAGS. See makefile and Search para_g or so.
# ---> It cause a problem if a source file foo.f, which compiled into foo.c*_o contains USE module, 
#      because checkmodule does now just support *.o. In such a case, you have to modify checkmodule by yourself.
#      (This note is by takao. Oct.2003)
############## NoteEnd
para_g = .o     # ppbafp.f  psi2bc1.f psi2bc.f See makefile.
sxcf_g = .o     # sxcf.f
x0kf_g = .o     # x0kf.f
hqpe_g = .o     # hqpe.f
tet5_g = .o

### for sr8k ###
#FFLAGS    = -Oss -loglist -Xpcomp -limit -noparallel -Xparmonitor  -nosave -64  -cpp $(CPPSWITCH_SR8K)
#FFLAGS_c1 = -Oss -loglist -Xpcomp -limit -parallel -Xparmonitor -uinline=2 -nosave -64  -cpp  $(CPPSWITCH_SR8K)
## We devide .f souces to some groups, which are compiled with the same optins to the objects with the same extentions. 
#para_g = .c1_o  # ppbafp.f  psi2bc1.f psi2bc.f
#x0kf_g = .c1_o  # x0kf.f
#sxcf_g = .o     # sxcf.f
#hqpe_g = .o     # hqpe.f



#(4) BLAS + LAPACK ####################################################
### ifort ###
LIBMATH= -mkl  

### ubuntu12.04 gfortran ####
#LIBMATH= /usr/lib64/libfftw3.so.3 /usr/lib64/liblapack.so.3gf /usr/lib64/libblas.so.3gf 


# I had a problem in zgemm in pwmat. 
#LIBMATH= /opt/acml4.2.0/gfortran64/lib/libacml.a -lfftw3
# this caused segmentation fault during lmf. (just after BNDFP: started).
#LIBMATH= /opt/acml4.1.0/gfortran64/lib/libacml.a -lfftw3

# centos yum install blas, yum install lapack
#LIBMATH= -lfftw3 /usr/lib64/liblapack.so.3.0.3 /usr/lib64/libblas.a 

#LIBMATH= -lfftw3   $(HOME)/kit/numericallib/LAPACK/lapack_core2gfortran.a \
# $(HOME)/kit/numericallib/LAPACK/blas_core2gfortran.a \
# $(HOME)/kit/numericallib/LAPACK/tmglib_core2gfortran.a 

#LIBMATH= -lfftw3 -L/opt/intel/mkl/10.0.2.018/lib/em64t/lib -lmkl_lapack -lmkl_em64t  -lmkl_core

#for ubuntu thinkpadt61.
#LIBMATH=  /usr/lib64/libfftw3.so.3.1.2 /usr/lib64/liblapack.a /usr/lib64/libblas-3.a 

#LIBMATH = -L/usr/lib64/atlas/ /usr/lib64/atlas/liblapack.so.3 \
#          /usr/lib64/atlas/libf77blas.so.3 /usr/lib64/atlas/libcblas.so.3 \
#          /usr/lib64/atlas/libatlas.so.3 -lfftw3

# yum install atlas --> this did not work... normchk.si gave NaN
#LIBMATH = -L/usr/lib64/atlas/ /usr/lib64/atlas/liblapack.so.3 \
#            /usr/lib64/atlas/libf77blas.so.3 /usr/lib64/atlas/libcblas.so.3 \
#            /usr/lib64/atlas/libatlas.so.3 -lfftw3

# centos yum install blas, yum install lapack
#LIBMATH= /usr/lib64/libblas.a /usr/lib64/liblapack.so.3.0.3 -lfftw3


#(5) Linker ####################################################
LK=mpif90 -openmp
### gfortran ubuntu12.04 #######
#LK = mpif90
#LK= ifort -parallel 
#LK=mpiifort
LKFLAGS2 = $(LIBMATH) 

#LK= ifort -parallel 
#LK=mpiifort -openmp

### ifort ####################
#LK=mpiifort -openmp

### linux 586
#LKFLAGS2 = $(ECAL)/slatsm/slatsm.a  -L/usr/intel/mkl/LIB -lmkl32_lapack -lmkl32_p3  -L/usr/lib/gcc-lib/i586-redhat-linux/2.95.3 -lg2c -lpthread  
### sr8k
#LKFLAGS2 = $(COMMON) $(ECAL)/slatsm/slatsm.a  -lblas -llapack -lpl -parallel  -lm


#(6) Root of ecal #############################################
# just for make install
ECAL   = $(HOME)/ecal
BINDIR = $(HOME)/bin

