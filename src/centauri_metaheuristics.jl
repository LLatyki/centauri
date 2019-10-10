using SatelliteToolbox
using Plots
using Metaheuristics

include("simulators/objectives/objective_functions.jl")

plotly()
sizeH = 800
sizeI = 10
alpha = 1
beta = 1

# a: Semimajor axis
# e: Eccentricity 
e = 0.
# i: Inclination 
# Ω: Longitude of the ascending node
Ω = 0.
# ω: Argument of periapsis 
ω = 0.
# f: True anomaly
f = 0.
    
function average_objective(H, I)
    h = H + 200
    i =  (I - 1) * 10 * pi / 180

    println("height:", h) 
    println("inclination:", i)
    
    orbit = Orbit(Rm + h * 1000., e, i, Ω, ω, f) 
    cost = orbit_cost(orbit)
    revisit = medium_revisit_time(orbit)
    alpha*cost + beta*revisit
end

# Objective function
average(x) = average_objective(x[1], x[2]) 

bounds = [0 0;
    sizeH sizeI 
]

de = DE(F=1, N=1, CR=0.1)

result = optimize(average, bounds, de)