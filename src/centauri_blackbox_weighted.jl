using SatelliteToolbox
using Plots
using BlackBoxOptim

include("simulators/objectives/objective_functions.jl")

plotly()

sizeI = 10.
sizeH = 800.
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

# Objective function    
function average_objective(x)
    H = x[1]
    I = x[2]
    h = H + 200
    i =  (I - 1) * 10 * pi / 180

    println("height:", h) 
    println("inclination:", i)
    
    orbit = Orbit(Rm + h * 1000., e, i, Ω, ω, f) 
    cost = orbit_cost(orbit)
    revisit = medium_revisit_time(orbit)
    return (alpha*cost + beta*revisit)
end


compare = compare_optimizers(average_objective; SearchRange = [(0., sizeH), (0., sizeI)], NumDimensions = 2, MaxTime = 10.0);
res = bboptimize(average_objective; SearchRange = [(0., sizeH), (0., sizeI)], NumDimensions = 2, MaxTime = 60.0)
