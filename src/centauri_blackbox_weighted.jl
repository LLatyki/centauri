using SatelliteToolbox
using Plots
using BlackBoxOptim

include("simulators/objective_functions.jl")
include("simulation.jl")

plotly()


Irange = (0., 180.)
Hrange = (200., 1000.)
Ωrange = (0.0, pi/2)

# a: Semimajor axis
# e: Eccentricity 
e = 0.
# i: Inclination 
# Ω: Longitude of the ascending node
# ω: Argument of periapsis 
ω = 0.
# f: True anomaly
f = 0.

settings = Simulation.initialize()


# Objective function 
function average_objective(alpha, x)
    beta = 1- alpha
    H = x[1]
    I = x[2]
    Ω = x[3]
    
    satellite = settings.satellite
    injection_orbit = settings.injection_orbit
    access_area = settings.access_area
    mission_lifetime = settings.mission_lifetime
    
    orbit = Orbit(Rm + h * 1000., e, i, Ω, ω, f) 
    orbit = Orbit(H, 0, i, Ω, 0, 0) 
    cost = orbit_cost(orbit, injection_orbit, satellite, mission_lifetime)
    revisit = mean_coverage_gap(orbit, satellite, access_area, mission_lifetime)
    return (alpha*cost + beta*revisit)
end

function average_objective_07(x)
    average_objective(0.7, x)
end

function average_objective_06(x)
    average_objective(0.6, x)
end

function average_objective_05(x)
    average_objective(0.5, x)
end

function average_objective_04(x)
    average_objective(0.4, x)
end

function average_objective_03(x)
    average_objective(0.3, x)
end


#compare = compare_optimizers(average_objective_05; SearchRange = [Hrange, Irange], NumDimensions = 2, MaxTime = 120.0);

function optimize_and_print(weight)
    average_objective_w(x) = average_objective(weight, x)
    res = bboptimize(average_objective_w; SearchRange = [Hrange, Irange, Ωrange], NumDimensions = 2, MaxTime = 600.0, TraceMode=:verbose)

    println("## " + str(weight) +" Cost ##")
    println("Best Pair")
    println(best_candidate(res))
    println("Fitness")
    println(best_fitness(res))
    orbit = Orbit(Rm + (best_candidate(res)[1] +200 )* 1000., e, best_candidate(res)[2] * pi / 180, Ω, ω, f) 
    println("Cost")
    println(orbit_cost(orbit))
    println("MCG")
    println(mean_coverage_gap(orbit)/60)
end

optimize_and_print(0.7)
optimize_and_print(0.6)
optimize_and_print(0.5)
optimize_and_print(0.4)
optimize_and_print(0.3)