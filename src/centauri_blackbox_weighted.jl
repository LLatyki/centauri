using SatelliteToolbox
using BlackBoxOptim

include("simulators/orbit_cost.jl")
include("simulators/revisit.jl")
include("simulation.jl")


settings = Simulation.initialize()


# Objective function 
function average_objective(alpha, min_cost, min_revisit, x)
    beta = 1- alpha
    
    a = x[1]
    i = x[2]
    Ω = x[3]

    println("semimajor_axis:", a) 
    println("inclination:", i)
    println("right ascension of the ascending node:", Ω)
    satellite = settings.satellite
    injection_orbit = settings.injection_orbit
    access_area = settings.access_area
    mission_lifetime = settings.mission_lifetime

    orbit = Orbit(a, 0, i, Ω, 0, 0) 
    cost = orbit_cost(orbit, injection_orbit, satellite, mission_lifetime)/min_cost
    revisit = mean_coverage_gap(orbit, satellite, access_area, mission_lifetime)/min_revisit

    return (alpha*cost + beta*revisit)
end


function optimize_and_print(weight, min_cost, min_revisit)

    Irange = (0.,  float(pi))
    Arange = (Rm, Rm+10^6)
    Ωrange = (0.0, float(pi))
    e = 0
    ω = 0
    f = 0

    average_objective_w(y) = average_objective(weight, min_cost, min_revisit, y)
    res = bboptimize(average_objective_w; SearchRange = [Arange, Irange, Ωrange], MaxTime = 600.0, TraceMode=:verbose)

    println("## " + str(weight) +" Cost ##")
    println("Best Pair")
    println(best_candidate(res))
    println("Fitness")
    println(best_fitness(res))
    orbit = Orbit(best_candidate(res)[1], e, best_candidate(res)[2] ,  best_candidate(res)[3], ω, f) 
    println("Cost")
    println(orbit_cost(orbit))
    println("MCG")
    println(mean_coverage_gap(orbit)/60)
    return orbit
end
