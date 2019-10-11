using SatelliteToolbox
using Plots

include("simulators/objectives/objective_functions.jl")
include("helpers/file_manager.jl")

plotly()
sizeH = 800
sizeI = 10

cost = Array{Float64}(undef, sizeH, sizeI)
med_rt = Array{Float64}(undef, sizeH, sizeI)
H = Array{Int64}(undef, sizeH, sizeI)

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
    
for j = 1:sizeH
    for k = 1:sizeI
        h = j + 200
        i =  (k - 1) * 10 * pi / 180

        println("height:", h) 
        println("inclination:", i)

        orbit = Orbit(Rm + h * 1000., e, i, Ω, ω, f) 
        H[j, k] = h
        cost[j, k] = orbit_cost(orbit)
        med_rt[j, k] = medium_revisit_time(orbit)
    end
end
table = (Cost_0graus =  cost[:, 1], Revisit_time_0graus =  med_rt[:, 1], 
         Cost_10graus = cost[:, 2], Revisit_time_10graus = med_rt[:, 2], 
         Cost_20graus = cost[:, 3], Revisit_time_20graus = med_rt[:, 3],
         Cost_30graus = cost[:, 4], Revisit_time_30graus = med_rt[:, 4],
         Cost_40graus = cost[:, 5], Revisit_time_40graus = med_rt[:, 5],
         Cost_50graus = cost[:, 6], Revisit_time_50graus = med_rt[:, 6],
         Cost_60graus = cost[:, 7], Revisit_time_60graus = med_rt[:, 7],
         Cost_70graus = cost[:, 8], Revisit_time_70graus = med_rt[:, 8],
         Cost_80graus = cost[:, 9], Revisit_time_80graus = med_rt[:, 9],
         Cost_90graus = cost[:,10], Revisit_time_90graus = med_rt[:,10])
write_file(table)

cost_plot = plot(H[:, 1], cost[:, 1], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 1], med_rt[:, 1], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 1], med_rt[:, 1], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 0 * 180 / pi, "Graus"))

cost_plot = plot(H[:, 2], cost[:, 2], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 2], med_rt[:, 2], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 2], med_rt[:, 2], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 10, "Graus"))

cost_plot = plot(H[:, 3], cost[:, 3], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 3], med_rt[:, 3], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 3], med_rt[:, 3], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 20, "Graus"))

cost_plot = plot(H[:, 4], cost[:, 4], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 4], med_rt[:, 4], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 4], med_rt[:, 4], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 30, "Graus"))

cost_plot = plot(H[:, 5], cost[:, 5], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 5], med_rt[:, 5], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 5], med_rt[:, 5], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 40, "Graus"))

cost_plot = plot(H[:, 6], cost[:, 6], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 6], med_rt[:, 6], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 6], med_rt[:, 6], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 50, "Graus"))

cost_plot = plot(H[:, 7], cost[:, 7], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 7], med_rt[:, 7], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 7], med_rt[:, 7], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 60, "Graus"))

cost_plot = plot(H[:, 8], cost[:, 8], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 8], med_rt[:, 8], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 8], med_rt[:, 8], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 70, "Graus"))

cost_plot = plot(H[:, 9], cost[:, 9], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 9], med_rt[:, 9], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 9], med_rt[:, 9], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 80, "Graus"))

cost_plot = plot(H[:, 10], cost[:, 10], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 10], med_rt[:, 10], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 10], med_rt[:, 10], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 90, "Graus"))
