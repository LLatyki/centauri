using Plots
using SatelliteToolbox
using BlackBoxOptim

# Script principal, acionado por linha de comando com diferentes opções
# Configurado a partir de um arquivo de .config, le esse arquivo e cria um objeto com esses dados
# Aplica a otimização nesse objeto
# Escreve o output em uma pasta, imagens, curvas etc

include("simulation.jl")
include("simulators/orbit_cost.jl")
include("simulators/revisit.jl")
include("simulators/orbit_simulator.jl")
include("centauri_blackbox_weighted.jl")
settings = Simulation.initialize()

gr()
# Objective function
# H = altura em km
# I = inclination em radianos
# Ω = inclination em radianos
function multi_objective(x)
    a = x[1]
    i = x[2]
    Ω = x[3]

    println("semimajor_axis:", a) 
    println("inclination:", i)
    println("right ascension of the ascending node:", Ω)
    satellite = settings.satellite
    injection_orbit = settings.injection_orbit
    access_area = settings.access_area
    mission_lifetime = settings.mission_lifetime

    orbit = Orbit(a, 0, i, Ω, 0, 0) 
    cost = orbit_cost(orbit, injection_orbit, satellite, mission_lifetime)
    revisit = mean_coverage_gap(orbit, satellite, access_area, mission_lifetime)
    return (cost, revisit)
end

function pareto(settings)
    space = settings.solution_space

    res = bboptimize(multi_objective; Method=:borg_moea,
    FitnessScheme=ParetoFitnessScheme{2}(is_minimizing=true),
    SearchRange=[space.a_range, space.i_range, space.Ω_range], NumDimensions=2, ϵ=0.1,
    MaxSteps=2000, TraceInterval=1.0, TraceMode=:verbose);
    
    return pareto_frontier(res)
end

pf = pareto(settings)

sz  = size(pf)[1]
x = Array{Float64}(undef, sz)
y = Array{Float64}(undef, sz)
I = Array{Float64}(undef, sz)
H = Array{Float64}(undef, sz)
Ω = Array{Float64}(undef, sz)
for j=1:sz
    x[j], y[j] = fitness(pf[j])
    H[j], I[j], Ω[j] = params(pf[j])
end
H = (H .-Rm)/1000
I = I*180/pi
Ω = Ω*180/pi
x = x/1000
objectives_plot = scatter(x, y, xaxis = ("Cost (km/s)"), yaxis = ("MCG (sec)"), xtickfont = font(10), ytickfont = font(10), guidefontsize = 12, label="", reuse = false)
params_plot_1 = scatter(H, I, xaxis = ("Height (Km)"), yaxis = ("Inclination (degrees)"), xtickfont = font(10), ytickfont = font(10), guidefontsize = 10, label="", reuse = false)
params_plot_2 = scatter(H, Ω, xaxis = ("Height (Km)"), yaxis = ("Longitude of the Ascending Node (degrees)"), xtickfont = font(10), ytickfont = font(10), guidefontsize = 12, label="", reuse = false)

min_cost = x[1]
min_revisit = last(y)

savefig(objectives_plot, "objectives_plot.png")
savefig(params_plot_1, "params_plot_1.png")
savefig(params_plot_2, "params_plot_2.png")


optimize_and_print(0.7, min_cost, min_revisit)
optimize_and_print(0.6, min_cost, min_revisit)
orbit = optimize_and_print(0.5, min_cost, min_revisit)
optimize_and_print(0.4, min_cost, min_revisit)
optimize_and_print(0.3, min_cost, min_revisit)

orbit_elements_evolution(orbit, 10, settings.mission_lifetime*3600*24)