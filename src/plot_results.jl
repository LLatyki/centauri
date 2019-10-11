using Plots
include("helpers/file_manager.jl")

plotly()
read_file()

cost_plot = plot(H[:, 1], cost[:, 1], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 1], med_rt[:, 1], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 1], med_rt[:, 1], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 0 * 180 / pi, "Graus"))

cost_plot = plot(H[:, 2], cost[:, 2], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 2], med_rt[:, 2], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 2], med_rt[:, 2], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 10, "Graus"))

cost_plot = plot(H[:, 3], cost[:, 3], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 3], med_rt[:, 3], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 3], med_rt[:, 3], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 20, "Graus"))

cost_plot = plot(H[:, 4], cost[:, 4], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 4], med_rt[:, 4], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 4], med_rt[:, 4], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 30, "Graus"))

cost_plot = plot(H[:, 5], cost[:, 5], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 5], med_rt[:, 5], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 5], med_rt[:, 5], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 40, "Graus"))

cost_plot = plot(H[:, 6], cost[:, 6], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 6], med_rt[:, 6], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 6], med_rt[:, 6], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 50, "Graus"))

cost_plot = plot(H[:, 7], cost[:, 7], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 7], med_rt[:, 7], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 7], med_rt[:, 7], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 60, "Graus"))

cost_plot = plot(H[:, 8], cost[:, 8], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 8], med_rt[:, 8], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 8], med_rt[:, 8], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 70, "Graus"))

cost_plot = plot(H[:, 9], cost[:, 9], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 9], med_rt[:, 9], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 9], med_rt[:, 9], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 80, "Graus"))

cost_plot = plot(H[:, 10], cost[:, 10], xaxis = ("height"), yaxis = ("ΔV"))
med_rt_plot = plot(H[:, 10], med_rt[:, 10], xaxis = ("height"), yaxis = ("Medium Revisit Time"))
multi_objective = scatter(cost[:, 10], med_rt[:, 10], xaxis = ("ΔV"), yaxis = ("Medium Revisit Time"))
plot(cost_plot, med_rt_plot, multi_objective, title = string("i: ", 90, "Graus"))
