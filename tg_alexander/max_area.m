%% Maximizaçao da Área de Cobertura
clear
clc
close all
%% Entradas
a_max = 8413; %Semi-eixo maior máximo para LEO
e_max = 0.25; %Excentricidade máxima para LEO
i_max = 90; % Sentido de rotaçao do satélite igual ao da Terra
qtd_sat = 1;

%% Constantes
Rt = 6378.135; %Raio da Terra em km
Int = [1]; % A posiçao no vetor para ter um valor inteiro
%% Cálculo Algortimo Genético
Perigeu = @periapsis;
Porc_Area_Cobertura = @propagation;
nvars = 1 + 6*qtd_sat;
lb_elem = [0.0001; Rt; 0; 0.0001; 0.0001; 0.0001];
ub_elem = [i_max; a_max; e_max; 359.9999; 359.9999; 359.9999];
lb = [1; lb_elem]; % x >=
ub = [qtd_sat; ub_elem]; % x <=
for sat = 1:qtd_sat-1
lb = [lb; lb_elem];
ub = [ub; ub_elem];
end
options = optimoptions('ga', 'PlotFcn', {@gaplotbestf,@gaplotstopping},
'FitnessScalingFcn', @fitscalingprop,'PopulationSize',50 ,
'FitnessLimit', -1,'FunctionTolerance', 1e-2)
%’PlotFcn’, {@gaplotbestf,@gaplotstopping: Plota gráficos da porcentagem da
% área de cobertura pelo no de geraçoes
% e das condiçoes de parada, respectivamente
%’FitnessScalingFcn’, @fitscalingprop: Troca para fitness proporcional
%’FitnessLimit’, -1: Fator parada para porcentagem de área de cobertura
%igual a 1
%’FunctionTolerance’, 1e-2: Fator de parada quando a média e o melhor valor
% tiverem uma diferença menor que 10^-2
[elementos_orbitais, porc_Area, exitflag, output, populaion,score] =
ga(Porc_Area_Cobertura, nvars,[],[],[],[],lb,ub,Perigeu,Int,options)