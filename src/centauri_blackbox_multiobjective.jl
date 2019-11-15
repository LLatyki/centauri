using SatelliteToolbox
using Plots
using BlackBoxOptim

include("simulators/objectives/objective_functions.jl")

plotly()

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
# H = altura em km
# I = inclination em graus
function multi_objective(x)
    H = x[1]
    I = x[2]
    h = H + 200
    i =  I* pi / 180

    println("height:", h) 
    println("inclination:", i)
    
    orbit = Orbit(Rm + h * 1000., e, i, Ω, ω, f) 
    cost = orbit_cost(orbit)
    revisit = medium_revisit_time(orbit)
    return (cost, revisit)
end

function pareto(sizeH,sizeI)
    res = bboptimize(multi_objective; Method=:borg_moea,
                FitnessScheme=ParetoFitnessScheme{2}(is_minimizing=true),
                SearchRange=[sizeH, sizeI], NumDimensions=2, ϵ=0.05,
                MaxSteps=5000, TraceInterval=1.0, TraceMode=:verbose);
    
    return pareto_frontier(res)
end