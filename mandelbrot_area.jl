"""
Get Magnitude of complex number
"""
function magnitude(cn)
	r = real(cn)
	i = imag(cn)
	return (r^2 + i^2)^(0.5)
end

"""
Recursively find the number of iterations before point escapes.
"""
function find_escape_iteration(iteration, iteration_value, c, iteration_limit, power)
	if iteration == iteration_limit
		return iteration
	elseif magnitude(iteration_value) > 2
		return iteration
	else
		iteration_value = iteration_value^power + c
		iteration+=1
		find_escape_iteration(iteration, iteration_value, c, iteration_limit, power)
	end
end

"""
Using the Monte Carlo Method, get the area contained by the fractal.
"""
function get_fractal_area_montecarlo(points_in_fractal, total_points, plot_area)
	return(points_in_fractal/total_points)*plot_area
end

"""
Plot a set number of randomly generated points, testing if each point is within the fractal or not.
Then create a 4 column matrix of the real part, the imaginary part, the number of recursive
iterations it took before the point escaped (or if it ever does), and the natural logarithm
of the escape iteration (to make the colors more vibrant).
Write that matrix to a text file that can then be plotted by GNUPlot.
"""
function generate_mandelbrot(num_points_to_plot, iteration_limit, data_file, power)
	# Write arrays to memory
	println("Setting up...")
	real_values = zeros(num_points_to_plot)
	imaginary_values = zeros(num_points_to_plot)
	escape_iteration = zeros(num_points_to_plot)
	log_escape_iteration = zeros(num_points_to_plot)
	points_in_fractal = 0

	for i in 1:num_points_to_plot
		real = 4 * rand() - 2 #Between -2 and 2
		imaginary = 4 * rand() - 2 #Between -2 and 2
		
		c = complex(real, imaginary)
		start_value = complex(real, imaginary)
		iteration = find_escape_iteration(0, start_value, c, iteration_limit, power)

		if iteration == iteration_limit
			points_in_fractal += 1
		end

		real_values[i] = real
		imaginary_values[i] = imaginary
		escape_iteration[i] = iteration
		log_escape_iteration[i] = log(iteration)
		
		if (i % 100 == 0)
      		print("\r$(round(i/num_points_to_plot * 100))% done...")
    	end
	end

	area = get_fractal_area_montecarlo(points_in_fractal, num_points_to_plot, 16)
	println("\nFractal Area Estimate: ", area)
	
	println("Writing Data to File...")
	writedlm(data_file, [real_values imaginary_values escape_iteration log_escape_iteration], ' ')
	println("Done!")
end

function mandelbrot_powers(range, points, iterations, data_folder)
	if (!isdir(data_folder))
		mkdir(data_folder)
	end
	@time @sync for i = range[1]:range[2]
		data_file = string(data_folder, "/", i, ".dat")
		@spawn generate_mandelbrot(points, iterations, data_file, i)
	end
end

function query(m::AbstractString)
  println(m)
  print(">>>")
  return chomp(readline())
end

function user_setup()
	single = query("Generate a single mandlebrot set (y/n)?")
	if (single == "y")
		points = eval(parse(query("How many points should be used?")))
		iterations = eval(parse(query("What is the iteration limit?")))
		data_file = query("What should the data file be called?")
		generate_mandelbrot(points, iterations, data_file, 2)
	elseif (single == "n")
		powers = query("Generate multiple sets for a range of exponents (y/n)?")
		if (powers == "y")
			range = eval(parse(query("What range of powers? [a,b]")))
			points = eval(parse(query("How many points should be used for each set?")))
			iterations = eval(parse(query("What is the iteration limit for each set?")))
			data_folder = query("What should the data folder be called?")
			mandelbrot_powers(range, points, iterations, data_folder)
		elseif (powers == "n")
			println("There is nothing else to do.")
			user_setup()
		else
			println("Please type 'y' for yes and 'n' for no")
			user_setup()
		end
	else 
		println("Please type 'y' for yes and 'n' for no")
		user_setup()
	end
end
user_setup()