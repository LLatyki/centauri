function [c, ceq] = periapsis(x)
%Função do Periapsi
Rt = 6378.135; %Raio da Terra em km
R = Rt + 300;
max_sat = 3;

for sat =1:max_sat
    c(sat) = R - x(3 + (sat-1)*6)*(1 - x(4 + (sat-1)*6));
end
ceq = [];

end

