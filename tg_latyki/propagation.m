%% Propagaçao da órbita
function porc_Area = propagation(element_orb)
%% Entradas
theta = 30; % Metade da abertura do sensor do satélite em graus
nd_time = 60; % Número da discretizaçao do tempo (segundos)
nd_space = 3; % Número da discretizaçao do espaço (graus)
%Os valores
lg1 = -75; % Longitude incial da área estudada
lg2 = -50; % Longitude final da área estudada
lt1 = -10; % Latitude incial da área estudada
lt2 = 0; % Latitude final da área estudada
%% Constantes
mi = 2.97554*10^15; % km^3/day^2
Rt = 6378.135;% Raio da Terra em km
wtg = 360.9856; % graus/dia solar
wtr = wtg*pi/180; % rads/dia solar
J2 = 1.0826267*10^(-3);
h_dia = 23 + 56/60 + 4/3600; % Horas em um dia solar
%% Área estudada
ag1 = long_to_ra(lg1); % Ascensao inicial da área a ser estudada
dg1 = lt1; % Declinaçao inicial da área a ser estudada
ag2 = long_to_ra(lg2); % Ascensao final da área a ser estudada
dg2 = lt2; % Declinaçao final da área a ser estudada
da = nd_space;
dd = nd_space;
if ag2 - ag1 >= 0
    ag = ag1+da/2:da:ag2-da/2; % Ascensoes dos centros das discretizaçoes em graus
else
    ag = [ag1+da/2:da:360 0:da:ag2-da/2];
    ag = ag(ag ~= 360);
end
dg = dg1+dd/2:dd:dg2-dd/2; % Declinaçoes dos centros das discretizaçoes em graus
agr = ag*pi/180; % Ascensoes dos centros das discrtizaçoes em radianos
dgr = dg*pi/180; % Declinaçoes dos centros das discrtizaçoes em radianos
nag = length(ag);
ndg = length(dg);
Area_Total = nag*ndg;
% A área total vai ser dada pela quantidade centros dos quadrados
% que há dentro da área a ser estudada
match = [];
% Vector para acumular os pontos que estao dentro da área estudada
% e estao sendo vistas pelo satélite
%% Cálculo da órbita
syms E % Anomalia Excentrica
for sat = 1:element_orb(1)
    i = element_orb(2 + (sat-1)*6); % Inclinaçao em graus
    a = element_orb(3 + (sat-1)*6); % Semieixo Maior
    e = element_orb(4 + (sat-1)*6); % Excentricidade
    M0 = element_orb(5 + (sat-1)*6); % Anomalia Média em graus
    omega0 = element_orb(6 + (sat-1)*6); % Ascensao reta do nó Ascendente em graus
    w0 = element_orb(7 + (sat-1)*6); % Argumento do perigeu em graus
    n = sqrt(mi/a^3)/(2*pi); % Movimento Médio (orbitas/ dia solar)
    T = (2*pi)/n; % Perı́odo em dia solar
    dT = nd_time/3600/h_dia;
    for dt = 0:dT:T % Delta de Tempo (dia solar)
        n = sqrt(mi/a^3)/(2*pi); % Movimento Médio (orbitas/ dia solar)
        Mg = M0 + 360*(n*dt - fix(n*dt) - fix((M0 + 360*(n*dt - fix(n*dt)))/360));
        % M (Anomalia Média) em graus
        Mr = Mg*pi/180; %M (Anoalia Média) em radianos
        Er = vpasolve(Mr == E - e*sin(E),E); % E (Anomalia Excentrica) em radianos
        Eg = vpa(Er*180/pi); %E (Anomalia Excentrica) em graus
        vr = acos((cos(Er) - e)/(1 - e*cos(Er))); % (Anomalia Verdadeira) em radianos
        v = vpa(vr*180/pi);% (Anomalia Verdadeira) em graus
        p = a*(1-e);% Perigeu
        r = (p*(1+e))/(1 + e*cos(vr)); % Distancia ao centro da Terra em km
        RE = Rt/Rt;
        a1 = a/Rt;
        ir = i*pi/180;
        d1 = (3*J2*RE^2*(3*(cos(ir))^2 - 1))/(4*a1^2*(1-e^2)^(3/2));
        a0 = -a1*(134*d1^3/81 + d1^2 + d1/3 - 1);
        p0 = a0*(1-e^2);
        domega = 360*((-3*J2*RE^2*n*dt*cos(ir))/(2*p0^2));
        omega = omega0 + domega;
        dw = 360*((3*J2*RE^2*n*dt*(5*(cos(ir))^2 - 1))/(4*p0^2));
        w = w0 + dw;
        u = w + v - 360*fix((w + v)/360);
        ur = vpa(u*pi/180);
        if (i>0 && i<90 && u>0 && u<180) || (i>90 && i<180 && u>180 && u<360)
            dalphar = acos((cos(ur))/((1 - (sin(ir))^2*(sin(ur))^2)^(1/2)));
            dalpha = vpa(dalphar*180/pi);
        end
        if (i>0 && i<90 && u>180 && u<360) || (i>90 && i<180 && u>0 && u<180)
            dalphar = acos(cos(ur)/(1 - (sin(ir))^2*(sin(ur))^2)^(1/2));
            dalpha = 360 - vpa(dalphar*180/pi);
        end
        ag0 = dalpha + omega - 360*(fix((dalpha + omega)/360));
        % Ascensao Reta Geocentrica do satélite em graus
        ag0r = vpa(ag0*pi/180); % Ascensao Reta Geocentrica do satélite em radianos
        dg0r = (sin(ur)/abs(sin(ur)))*acos(cos(ur)/cos(dalphar));
        % Declinaçao Geocentrica do satélite em radianos
        dg0 = vpa(dgr*180/pi); % Declinaçao Geocentrica em graus
        thetar = theta*pi/180;
        beta = vpa(-thetar + asin(r*sin(thetar)/Rt),4);
        % Metade do angulo de visao da Área de cobertura do centro da Terra
        for k = 1:nag
            for j = 1:ndg
                L = vpa(acos(cos(ag0r-(agr(k) + wtr*dt))*cos(dg0r-dgr(j))),4);
                % Lei dos cossenos esférica
                if L < beta
                    match = [match; agr(k) dgr(j)];
                end
            end
        end
    end
end
Area_coberta = length(unique(match,'rows'));
% Ignora pontos cobertos mais de uma vez
porc_Area = - vpa(Area_coberta/Area_Total,6)
% Sinal negativo para que a área negativa seja minimizada,
% assim a área positiva é maximizada
end