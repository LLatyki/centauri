using SatelliteToolbox
using Plots

include("simulators/objectives/objective_functions.jl")
include("helpers/file_manager.jl")

plotly()
sizeH = 800

cost = Array{Float64}(undef, sizeH, 6)
med_rt = Array{Float64}(undef, sizeH, 6)
H = Array{Int64}(undef, sizeH, 6)

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

for iterat = [(-60,1), (-30,2), (-5,3), (5,4), (30,5), (60,6)]
    for j = 1:sizeH
        (k, ind) = iterat
        h = j + 200
        i =  k * pi / 180
        println("height:", h) 
        println("inclination:", k)

        orbit = Orbit(Rm + h * 1000., e, i, Ω, ω, f) 

        H[j, ind] = h
        cost[j, ind] = orbit_cost(orbit)
        med_rt[j, ind] = medium_revisit_time(orbit)

    end
end
table = (Cost_m60graus =  cost[:, 1], Revisit_time_m60graus =  med_rt[:, 1], 
         Cost_m30graus = cost[:, 2], Revisit_time_m30graus = med_rt[:, 2], 
         Cost_m5graus = cost[:, 3], Revisit_time_m5graus = med_rt[:, 3],
         Cost_5graus = cost[:, 4], Revisit_time_5graus = med_rt[:, 4],
         Cost_30graus = cost[:, 5], Revisit_time_30graus = med_rt[:, 5],
         Cost_60graus = cost[:, 6], Revisit_time_60graus = med_rt[:, 6])
write_file(table)
