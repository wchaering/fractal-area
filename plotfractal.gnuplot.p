set terminal jpeg enhanced size 3840,2160
set output 'fractal.jpeg'
set border 0
set nokey
set key noautotitle
unset xlabel
unset ylabel
set format x ''
set format y ''
set tics scale 0
# set palette defined ( 0 '#D53E4F', 1 '#F46D43', 2 '#FDAE61', 3 '#FEE08B', 4 '#E6F598', 5 '#ABDDA4', 6 '#66C2A5', 7 '#3288BD' )
# set palette defined (0 "dark-blue", 1 "blue", 2 "light-blue")
set palette defined ( 0 '#FFF7FB',\
    	    	      1 '#ECE7F2',\
		      2 '#D0D1E6',\
		      3 '#A6BDDB',\
		      4 '#74A9CF',\
		      5 '#3690C0',\
		      6 '#0570B0',\
		      7 '#034E7B' )
plot '200m-500-2.dat' u 1:2:3 with dots palette
