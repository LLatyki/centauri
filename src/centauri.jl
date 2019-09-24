using SatelliteToolbox
using Plots

include("simulators/objectives/objective_functions.jl")

plotly()
size = 500

cost = Array{Float64}(undef, size)
med_rt = Array{Float64}(undef, size)
H = Array{Int64}(undef, size)

# a: Semimajor axis
# e: Eccentricity 
e = 0.1
# i: Inclination 
i = 90 * pi / 180
# Ω: Longitude of the ascending node
Ω = 0.
# ω: Argument of periapsis 
ω = 0.
# f: True anomaly
f = 0.
    
for j = 1:size
    h = j + 200 


    orbit = Orbit(Rm + h * 1000., e, i, Ω, ω, f) 
    H[j] = h
    println(h)
    cost[j] = orbit_cost(orbit)
    med_rt[j] = medium_revisit_time(orbit)
end
cost_plot = plot(H, cost, xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H, med_rt, xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost, med_rt, xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", i * 180 / pi, "Graus"))
