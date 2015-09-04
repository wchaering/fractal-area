# Mandelbrot Fractals

Mandelbrot sets are fractal structures located in the complex plane. They are defined by the recursive formula Z<sub>n+1</sub> = Z<sup>2</sup><sub>n</sub> + c, where Z<sub>0</sub> = c. Randomly generated points are within the Mandelbrot set if |Z<sub>n</sub>| < 2 as n -> ∞, so for the script, an iteration limit is set where it can be said that the point stays within a finite radius as n -> ∞.

The function ```generate_mandelbrot(num_points_to_plot, iteration_limit)```, takes two arguments, the first being the number of points to plot (large numbers of points can be very slow), and the second is the limit that decides how many iterations are allowed to check if a point is within the set.

The script will output the results to a file storing the real values, the imaginary values and the escape iteration of the points. This file, plot.dat, can be displayed using gnuplot.

#####GNUPlot Commands:

1. Set Terminal type (I used JPEG to get an image): ```set term jpeg```
2. Set output file (Again, I set it to a .jpg): ```set output 'fractal.jpg'```
3. Plot it: ```plot 'plot.dat' u 1:2:3 with dots palette```


