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
