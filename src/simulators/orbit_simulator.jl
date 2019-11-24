using SatelliteToolbox
using Plots

include("objectives/mission/coverage_data.jl")

#######
# plotly()
# n = 100
# ts = range(0, stop = 8π, length = n)
# x = ts .* map(cos, ts)
# y = (0.1ts) .* map(sin, ts)
# z = 1:n
# plot(x, y, z, zcolor = reverse(z), m = (10, 0.8, :blues, Plots.stroke(0)), leg = false, cbar = true, w = 1)
# plot(x, y, z, zcolor = reverse(z), leg = false, cbar = true, w = 1)
#########

plotly()

n = 300

u = range(0, stop = 2 * π, length = n)
v = range(0, stop = π, length = n)

x = Rm * cos.(u) * sin.(v)';
y = Rm * sin.(u) * sin.(v)';
z = Rm * ones(n) * cos.(v)';

# plot(x, y, z, color = :blue, w = 1)
# 
# lat = pi * access_point().lat / 180
# lon = pi * access_point().lon / 180
# 
# x_AP = [Rm * cos(lat) * cos(lon)]
# y_AP = [Rm * cos(lat) * sin(lon)]
# z_AP = [Rm * sin(lat)]
# plot!(x_AP, y_AP, z_AP, color = :red, seriestype = :scatter)


function extract_dim(r)
    n = length(r)
    x = Array{Float64}(undef, n)
    y = Array{Float64}(undef, n)
    z = Array{Float64}(undef, n)
    for i = 1:n
        x[i] = r[i][1]
        y[i] = r[i][2]
        z[i] = r[i][3]
    end
    x, y, z 
end

orbit = Orbit(0., Rm + 1025601.0, 0, 17.1102*pi/180, 0., 0., 0.)
orbp = init_orbit_propagator(Val{:J4}, orbit)
o, r, v = propagate!(orbp, 0:10:2*365*24*60*60)
x, y, z = extract_dim(r)
plot!(x, y, z, color = :black, w = 2, label="")