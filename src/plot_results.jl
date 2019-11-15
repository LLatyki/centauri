using Plots
using Tables
include("centauri_blackbox_multiobjective.jl")
include("helpers/file_manager.jl")

plotly()
sizeH = 800

H = Array{Int64}(undef, sizeH)

for j = 1:sizeH
    H[j] = j + 200 
end

table = read_file()
columns = Tables.columns(table)

cost_plot_m60 = plot(H, columns[1], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_m60 = plot(H, columns[2], xaxis = ("Height (km)"), yaxis = ("Medium Revisit Time (s)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_m30 = plot(H, columns[3], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_m30 = plot(H, columns[4], xaxis = ("Height (km)"), yaxis = ("Medium Revisit Time (s)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_m5 = plot(H, columns[5], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_m5 = plot(H, columns[6], xaxis = ("Height (km)"), yaxis = ("Medium Revisit Time (s)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_5 = plot(H, columns[7], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_5 = plot(H, columns[8], xaxis = ("Height (km)"), yaxis = ("Medium Revisit Time (s)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_30 = plot(H, columns[9], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_30 = plot(H, columns[10], xaxis = ("Height (km)"), yaxis = ("Medium Revisit Time (s)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_60 = plot(H, columns[11], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_60 = plot(H, columns[12], xaxis = ("Height (km)"), yaxis = ("Medium Revisit Time (s)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
