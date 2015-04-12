"""
Get Magnitude of complex number
"""
function magnitude(cn)
	r = real(cn)
	i = imag(cn)
	return (r^2 + i^2)^(0.5)
end

"""
Find the number of iterations before point escapes.
"""
function find_escape_iteration(iteration, iteration_value, c, iteration_limit)
	if iteration == iteration_limit
		return iteration
	elseif magnitude(iteration_value) > 2
		return iteration
	else
		iteration_value = iteration_value^2+c
		iteration+=1
		find_escape_iteration(iteration, iteration_value, c, iteration_limit)
	end
	
end

"""
Using the Monte Carlo Method, get the area contained by the fractal.
"""
function get_fractal_area_montecarlo(points_in_fractal, total_points, plot_size)
	return(points_in_fractal/total_points)*plot_size
end

"""
Plot a set number of randomly generated points, testing if each point is within the fractal or not.
Then create a 4 column matrix of the real part, the imaginary part, the number of recursive
iterations it took before the point escaped (or if it ever does), and the natural logarithm
of the escape iteration (to make the colors more vibrant).
Write that matrix to a text file that can then be plotted by GNUPlot.
"""
function generate_mandelbrot(num_points_to_plot, iteration_limit)
	# Setting up
	pointidx = 1
	
	# Write arrays to memory
	real_values = zeros(num_points_to_plot)
	imaginary_values = zeros(num_points_to_plot)
	escape_iteration = zeros(num_points_to_plot)
	log_escape_iteration = zeros(num_points_to_plot)
	points_in_fractal = 0

	while pointidx < num_points_to_plot
		# Generate Random Complex Number
		rpart = rand()*4-2 #Between -2 and 2
		ipart = rand()*4-2 #Between -2 and 2
		
		c = complex(rpart, ipart)
		start_value = complex(rpart, ipart)
		iteration = find_escape_iteration(0, start_value, c, iteration_limit)

		if iteration == iteration_limit
			points_in_fractal += 1
		end

		real_values[pointidx] = rpart
		imaginary_values[pointidx] = ipart
		escape_iteration[pointidx] = iteration
		log_escape_iteration[pointidx] = log(iteration)

		pointidx+=1
	end

	# Write to File
	writedlm("plot.dat", [real_values imaginary_values escape_iteration log_escape_iteration], ' ')
	area = get_fractal_area_montecarlo(points_in_fractal, num_points_to_plot, 16)
	println("Fractal Area: ", area)
end