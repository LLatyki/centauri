using Plots
using Tables
include("centauri_blackbox_multiobjective.jl")
include("helpers/file_manager.jl")

plotly()
sizeH = 80

H = Array{Int64}(undef, sizeH)

for j = 1:sizeH
    H[j] = j*10 + 200 
end

table = read_file()
columns = Tables.columns(table)

cost_plot_5 = plot(H, columns[1], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_5 = plot(H, columns[2]/60, xaxis = ("Height (km)"), yaxis = ("MCG (min)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_10 = plot(H, columns[3], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_10 = plot(H, columns[4]/60, xaxis = ("Height (km)"), yaxis = ("MCG (min)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_15 = plot(H, columns[5], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_15 = plot(H, columns[6]/60, xaxis = ("Height (km)"), yaxis = ("MCG (min)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_20 = plot(H, columns[7], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_20 = plot(H, columns[8]/60, xaxis = ("Height (km)"), yaxis = ("MCG (min)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_25 = plot(H, columns[9], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_25 = plot(H, columns[10]/60, xaxis = ("Height (km)"), yaxis = ("MCG (min)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_30 = plot(H, columns[11], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_30 = plot(H, columns[12]/60, xaxis = ("Height (km)"), yaxis = ("MCG (min)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
 
cost_plot_150 = plot(H, columns[13], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_150 = plot(H, columns[14]/60, xaxis = ("Height (km)"), yaxis = ("MCG (min)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_155 = plot(H, columns[15], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_155 = plot(H, columns[16]/60, xaxis = ("Height (km)"), yaxis = ("MCG (min)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_160 = plot(H, columns[17], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_160 = plot(H, columns[18]/60, xaxis = ("Height (km)"), yaxis = ("MCG (min)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_165 = plot(H, columns[19], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_165 = plot(H, columns[20]/60, xaxis = ("Height (km)"), yaxis = ("MCG (min)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_170 = plot(H, columns[21], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_170 = plot(H, columns[22]/60, xaxis = ("Height (km)"), yaxis = ("MCG (min)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")

cost_plot_175 = plot(H, columns[23], xaxis = ("Height (km)"), yaxis = ("ΔV (m/s)"), linewidth =4, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
med_rt_plot_175 = plot(H, columns[24]/60, xaxis = ("Height (km)"), yaxis = ("MCG (min)"), linewidth =3, xtickfont = font(12), ytickfont = font(12) , guidefontsize = 15, label="")
