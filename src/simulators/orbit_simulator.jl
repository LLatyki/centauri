using SatelliteToolbox
using Plots
using LinearAlgebra
gr()

function orbit_elements_evolution(orb_elem::Orbit, step::Int, simulation_time::Number)
    orbp = init_orbit_propagator(Val{:J4}, orb_elem)
    T = 0:step:simulation_time
    O, R, V = propagate!(orbp, T)
    sz  = size(O)[1]
    E = Array{Float64}(undef, sz)
    I = Array{Float64}(undef, sz)
    A = Array{Float64}(undef, sz)
    Ω = Array{Float64}(undef, sz)
    for j=1:sz
        E[j] = O[j].e
        I[j] = O[j].i*180/pi
        A[j] = O[j].a/1000
        Ω[j] = O[j].Ω*180/pi
    end
    eccentricity_plot = plot(T, E)
    ascenscion_node_plot = plot(T, Ω)
    semi_major_plot = plot(T, A)
    inclination_plot = plot(T, I)

    savefig(eccentricity_plot, "eccentricity_plot.png")
    savefig(ascenscion_node_plot, "ascenscion_node_plot.png")
    savefig(semi_major_plot, "semi_major_plot.png")
    savefig(inclination_plot, "inclination_plot.png")
end