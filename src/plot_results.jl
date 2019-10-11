using Plots
using Tables
include("helpers/file_manager.jl")

plotly()
sizeH = 800

H = Array{Int64}(undef, sizeH)

for j = 1:sizeH
    H[j] = j + 200 
end

table = read_file()
columns = Tables.columns(table)

cost_plot = plot(H, columns[1], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H, columns[2], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(columns[1], columns[2], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 0, "Graus"))

cost_plot = plot(H, columns[3], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H, columns[4], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(columns[3], columns[4], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 10, "Graus"))

cost_plot = plot(H, columns[5], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H, columns[6], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(columns[5], columns[6], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 20, "Graus"))

cost_plot = plot(H, columns[7], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H, columns[8], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(columns[7], columns[8], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 30, "Graus"))

cost_plot = plot(H, columns[9], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H, columns[10], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(columns[9], columns[10], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 40, "Graus"))

cost_plot = plot(H, columns[11], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H, columns[12], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(columns[11], columns[12], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 50, "Graus"))

cost_plot = plot(H, columns[13], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H, columns[14], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(columns[13], columns[14], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 60, "Graus"))

cost_plot = plot(H, columns[15], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H, columns[16], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(columns[15], columns[16], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 70, "Graus"))

cost_plot = plot(H, columns[17], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H, columns[18], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(columns[17], columns[18], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 80, "Graus"))

cost_plot = plot(H, columns[19], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H, columns[20], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(columns[19], columns[20], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 90, "Graus"))