using Plots
using SatelliteToolbox
using BlackBoxOptim

# Script principal, acionado por linha de comando com diferentes opções
# Configurado a partir de um arquivo de .config, le esse arquivo e cria um objeto com esses dados
# Aplica a otimização nesse objeto
# Escreve o output em uma pasta, imagens, curvas etc

include("simulation.jl")
include("simulators/objective_functions.jl")

settings = Simulation.initialize()


#include("centauri_blackbox_multiobjective.jl")
plotly()


# Objective function
# H = altura em km
# I = inclination em graus
function multi_objective(x)
    a = x[1]
    i = x[2]
    
    println("semimajor_axis:", a) 
    println("inclination:", i)
    satellite = settings.satellite
    injection_orbit = settings.injection_orbit
    access_area = settings.access_area
    mission_lifetime = settings.mission_lifetime

    orbit = Orbit(a, 0, i, 0, 0, 0) 
    cost = orbit_cost(orbit, injection_orbit, satellite, mission_lifetime)
    revisit = mean_coverage_gap(orbit, satellite, access_area, mission_lifetime)
    return (cost, revisit)
end

function pareto(settings)
    space = settings.solution_space

    res = bboptimize(multi_objective; Method=:borg_moea,
    FitnessScheme=ParetoFitnessScheme{2}(is_minimizing=true),
    SearchRange=[space.a_range, space.i_range], NumDimensions=2, ϵ=0.1,
    MaxSteps=2000, TraceInterval=1.0, TraceMode=:verbose);
    
    return pareto_frontier(res)
end


pf = pareto(settings)

sz  = size(pf)
sz = sz[1]
x = Array{Float64}(undef, sz)
y = Array{Float64}(undef, sz)
I = Array{Float64}(undef, sz)
H = Array{Float64}(undef, sz)
for j=1:sz
    x[j], y[j] = fitness(pf[j])
    h, i = params(pf[j])

    H[j] = h + 200
    I[j] = i
end
objectives_plot = scatter(x, y/60, xaxis = ("Cost (m/s)"), yaxis = ("MCG (min)"), xtickfont = font(12), ytickfont = font(12), guidefontsize = 15, label="")
params_plot = scatter(H, I, xaxis = ("Height (Km)"), yaxis = ("Inclination (degrees)"), xtickfont = font(12), ytickfont = font(12), guidefontsize = 15, label="")
plot(params_plot)
plot(objectives_plot)