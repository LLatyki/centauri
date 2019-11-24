using SatelliteToolbox
using Plots

include("simulators/objectives/objective_functions.jl")
include("helpers/file_manager.jl")

plotly()
sizeH = 80

cost = Array{Float64}(undef, 80, 12)
med_rt = Array{Float64}(undef, 80, 12)
H = Array{Int64}(undef, 80, 12)

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

for iterat = [(5,1), (10,2), (15,3), (20,4), (25,5), (30,6), (150,7), (155,8), (160,9), (165,10), (170,11), (175,12)]
    for j = 1:sizeH
        (k, ind) = iterat
        h = 10*j + 200
        i =  k * pi / 180
        println("height:", h) 
        println("inclination:", k)

        orbit = Orbit(Rm + h * 1000., e, i, Ω, ω, f) 

        H[j, ind] = h
        cost[j, ind] = orbit_cost(orbit)
        println("mean_coverage_gap")
        med_rt[j, ind] = mean_coverage_gap(orbit)
        println(med_rt[j, ind])

    end
end
table = (Cost_5graus   = cost[:, 1],  Revisit_time_5graus = med_rt[:, 1], 
        Cost_10graus  = cost[:, 2],  Revisit_time_10graus = med_rt[:, 2], 
        Cost_15graus  = cost[:, 3],  Revisit_time_15graus =  med_rt[:, 3],
        Cost_20graus  = cost[:, 4], Revisit_time_20graus =   med_rt[:, 4],
        Cost_25graus  = cost[:, 5], Revisit_time_25graus =  med_rt[:, 5],
        Cost_30graus  = cost[:, 6], Revisit_time_30graus =  med_rt[:, 6],
        Cost_150graus = cost[:, 7],  Revisit_time_150graus = med_rt[:, 7], 
        Cost_155graus = cost[:, 8],  Revisit_time_155graus = med_rt[:, 8], 
        Cost_160graus = cost[:, 9],  Revisit_time_160graus =  med_rt[:, 9],
        Cost_165graus = cost[:, 10],  Revisit_time_165graus =   med_rt[:, 10],
        Cost_170graus = cost[:, 11],  Revisit_time_170graus =  med_rt[:, 11],
        Cost_175graus  = cost[:, 12],  Revisit_time_175graus =  med_rt[:, 12],
         )
write_file(table)
