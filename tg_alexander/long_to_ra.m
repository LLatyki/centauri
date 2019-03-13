%% Conversao Longitude para Ascensao Reta
function RA = long_to_ra(long)
    %% Está funçao tem por finalidade converter Longitude em Ascensao
    date = datetime('now','TimeZone', 'UTC');
    y = year(date);
    mon = month(date);
    d = day(date);
    h = hour(date);
    min = minute(date);
    s = second(date);
    j0 = 367*y - fix(7*(y + fix((mon + 9)/12))/4) + fix(275*mon/9) + d + 1721013.5;
    %j0 - Julian day at 0 hr UT (Universal Time)
    %year - range: 1901 - 2099
    %month - range: 1 - 12
    %day - range: 1 - 31
    j = (j0 - 2451545)/36525;% Séculos desde J2000
    g0 = 100.4606184 + 36000.77004*j + 0.000387933*j^2 - 2.583e-8*j^3;
    % Greenwich sidereal time (degrees) at 0 hr UT

    if (g0 >= 360)
        g0 = g0 - fix(g0/360)*360;

    elseif (g0 < 0)
        g0 = g0 - (fix(g0/360) - 1)*360;
    end

    hours = h + min/60 + s/3600;
    g = g0 + 360.98564724*hours/24;
    % Greenwich sidereal time (degrees) at the specified UT
    RA = g + long;

    if (RA >= 360)
        RA = RA - fix(RA/360)*360;
    elseif (RA < 0)
        RA = RA - (fix(RA/360) - 1)*360;
    end
end
