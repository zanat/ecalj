set ylab "Energy(Ry*    13.60500)"
set yra [   -18.00000:    16.00000]
set xtics ( ""         0.0000000000,\
 ""         0.8660254038,\
 ""         1.8660254038,\
 ""         2.3660254038,\
 ""         3.4840593925)
 plot \
 "bnd1.dat" u 2:3 lt 1 pt 1 not w l,\
 "bnd2.dat" u 2:3 lt 1 pt 1 not w l,\
 "bnd3.dat" u 2:3 lt 1 pt 1 not w l,\
 "bnd4.dat" u 2:3 lt 1 pt 1 not w l
 # pause -1 (instead, gnuplot -p ThisScript)
