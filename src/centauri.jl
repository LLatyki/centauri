using SatelliteToolbox
using Plots

include("simulators/objectives/objective_functions.jl")
include("helpers/file_manager.jl")

plotly()
sizeH = 5
sizeI = 10

cost = Array{Float64}(undef, sizeH, sizeI)
med_rt = Array{Float64}(undef, sizeH, sizeI)
H = Array{Int64}(undef, sizeH, sizeI)

# a: Semimajor axis
# e: Eccentricity 
e = 0.1
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

        println(h)
        println(i)

        orbit = Orbit(Rm + h * 1000., e, i, Ω, ω, f) 
        H[j, k] = h
        cost[j, k] = orbit_cost(orbit)
        med_rt[j, k] = medium_revisit_time(orbit)
    end
end
println(cost)
println(med_rt)
first_column = ["I 0 graus", "I 10 graus", "I 20 graus", "I 30 graus", "I 40 graus", "I 50 graus", "I 60 graus", "I 70 graus", "I 80 graus", "I 90 graus"]
first_height = H[1, 1]
table = (Altura = first_column, string(H[1,1], " km") = cost[1, :])
write_file(table)

#cost_plot = plot(H[:, 1], cost[:, 1], xaxis = ("height"), yaxis = ("ΔV"))
#med_rt_plot = plot(H[:, 1], med_rt[:, 1], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
#multi_objective = scatter(cost[:, 1], med_rt[:, 1], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
#plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", i * 180 / pi, "Graus"))
