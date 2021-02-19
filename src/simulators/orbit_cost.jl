#== # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 Description

   Calculates the objective functions for a 
   given orbit and mission configuration
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ==#

using SatelliteToolbox
using PolynomialRoots
using Statistics

export orbit_cost

function orbit_cost(orb_elem::Orbit, injection_orbit::Orbit, satellite, mission_lifetime)
    # Total cost of the orbit for the given mission in propellant mass

    # Cost of transfer from injection orbit to the given orbit.
    # Considering a hommann transfers between coplanar orbits and orbit plane change at apoapsis
    a1 = injection_orbit.a*1000.0
    a2 =  orb_elem.a*1000.0
    T = 2 * pi * sqrt(a2^3 / m0)
    revolutions =mission_lifetime * 24 * 60 * 60 / T
    transfer_cost = homman_transfer_cost(a1,a2)

    # Plane transfer at the best condition
    plane_cost = plane_change_cost(injection_orbit.i, orb_elem.i, a1, a2)

    # Wertz pg 69
    maintenance_cost = maintenance_cost_per_rev(satellite.Cd, satellite.A, satellite.M,a2)
    ΔVT = transfer_cost + plane_cost + maintenance_cost*revolutions
    return ΔVT
end

function plane_change_cost(i1, i2, a1, a2)
    V1 = sqrt(m0 / a1)
    V2 = sqrt(m0 / a2)
    plane_change_v = min(V1, V2)
    plane_change_cost = 2*plane_change_v*sin((i1 - i2)/2)
    return plane_change_cost
end

function homman_transfer_cost(a1, a2)
    ΔV1 = sqrt(m0 / a1) * (sqrt(2a2 / (a1 + a2)) - 1)
    ΔV2 = sqrt(m0 / a2) * (1 - sqrt(2a1 / (a1 + a2)))
    return ΔV1 + ΔV2
end

function maintenance_cost_per_rev(Cd, A, m, a)
    V = sqrt(m0 / a)
    ρ = expatmosphere(a - Rm)
    ΔVrev = pi * (Cd * A / m) * ρ * a * V
    return ΔVrev
end