# Mandelbrot Set Generation

Mandelbrot sets are fractal structures located in the complex plane. They are defined by the recursive formula Z<sub>n+1</sub> = Z<sup>2</sup><sub>n</sub> + c, where Z<sub>0</sub> = c. Randomly generated points are within the Mandelbrot set if |Z<sub>n</sub>| < 2 as n -> ∞, so for the script, an iteration limit is set where it can be said that the point stays within a finite radius as n -> ∞.

The function ```generate_mandelbrot(num_points_to_plot, iteration_limit, data_file, power)```, takes three arguments, the first is the number of points to plot (large numbers of points can be very slow), the second is the limit that decides how many iterations are allowed to check if a point is within the set (high iteration limits (> 300) can also be very slow), the third is the name of the data file to write to, and the fourth is the power to use in the recursive formula to generate the set.

The script will output the results to a file storing the real values, the imaginary values and the escape iteration of the points. This file, plot.dat, can be displayed using GNUplot.

#####Usage:
Run `include("mandelbrot_area.jl")` and you will be guided through generating a Mandelbrot Set.

#####GNUPlot Commands:

1. Set Terminal type (JPEG to get an image): ```set term jpeg```
2. Set output file (Again, set file to a .jpg): ```set output 'fractal.jpg'```
3. Plot it: ```plot '<datafile.dat>' u 1:2:3 with dots palette```
