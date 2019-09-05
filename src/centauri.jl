using SatelliteToolbox
using Plots

include("simulators/objectives/objective_functions.jl")

plotly()
size = 800

cost = Array{Float64}(undef, size)
med_rt = Array{Float64}(undef, size)
H = Array{Int64}(undef, size)

for i = 1:size
    h = i + 200 
    orbit = Orbit(0., Rm + h * 1000., 0., 0., 0., 0., 0.) 
    H[i] = h
    cost[i] = orbit_cost(orbit)
    med_rt[i] = medium_revisit_time(orbit)
end
cost = plot(H, cost)
med_rt = plot(H, med_rt)
multi_objective = plot(cost, med_rt)
plot(cost, med_rt, multi_objective)
