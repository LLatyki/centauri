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
    println(h)
    cost[i] = orbit_cost(orbit)
    med_rt[i] = medium_revisit_time(orbit)
end
cost_plot = plot(H, cost, xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H, med_rt, xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost, med_rt, xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective)
