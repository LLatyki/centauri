using Plots

include("centauri_blackbox_multiobjective.jl")
plotly()

Irange = (0., 90.)
Hrange = (0., 800.)

pf = pareto(Hrange, Irange)

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