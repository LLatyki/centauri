#== # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 Description

   Calculates the objective functions for a 
   given orbit and mission configuration
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ==#

using SatelliteToolbox

################################################################################
#                                    Files
################################################################################

include("mission/coverage_data.jl")
include("mission/satellite_data.jl")

export orbit_cost
export medium_revisit_time

function orbit_cost(orb_elem::Orbit)
    # Total cost of the orbit for the given mission in ΔV
    transfer_cost(orb_elem) + maintenance_cost(orb_elem) + discard_cost(orb_elem)
end

function transfer_cost(orb_elem::Orbit)
    # Cost of transfer from injection orbit to the given orbit.
    # Now, we consider only hommann transfers between coplanar orbits
    a1 = injection_orbit().a
    a2 = orb_elem.a
    ΔV1 = sqrt(m0 / a1) * (sqrt(2a2 / (a1 + a2)) - 1)
    ΔV2 = sqrt(m0 / a2) * (1 - sqrt(2a1 / (a1 + a2)))
    ΔV1 + ΔV2
end

function maintenance_cost(orb_elem::Orbit)
    # Wertz pg 69
    Cd = satellite_data().Cd
    A = satellite_data().A
    m = satellite_data().m
    a  = orb_elem.a
    ρ = expatmosphere(a - Rm)
    V = sqrt(m0 / a)

    ΔVrev = pi * (Cd * A / m) * ρ * a * V
    T = 2 * pi * sqrt(a^3 / m0)
    
    ΔVrev * mission_time() * 24 * 60 * 60 / T
end
 
function discard_cost(orb_elem::Orbit)
    # Cost of transfer from operation orbit to the discard orbit
    0
end

function access(orb_elem::Orbit, step::Int)
    # Computes the access of a satellite to a determined point during some period of time
    # Returns a boolean list
    ωearth = 2 * pi / (24 * 60 * 60)

    orbp = init_orbit_propagator(Val{:twobody}, orb_elem)
    mission_time_sec = mission_time() * 24 * 60 * 60

    o, r, v = propagate!(orbp, 0:step:mission_time_sec)
    x, y, z = extract_dim(r)

    n = length(r)
    lat = access_point().lat * pi / 180
    lon = access_point().lon * pi / 180
    access_point_direction = Array{Float64}(undef, n)
    visit = Array{Bool}(undef, n)
    for i = 1:n
        lon = lon + ωearth * i * step
        access_point_direction = [Rm * cos(lat) * cos(lon), Rm * cos(lat) * sin(lon), Rm * sin(lat)]
        satellite_pos = [x[i], y[i], z[i]]
        sep = separation(satellite_pos, access_point_direction)
        if sep < access_angle(orb_elem)
            visit[i] = true
        else
            visit[i] = false
        end
    end
    visit
end

function separation(u, v)
    acos((u[1] * v[1] + u[2] * v[2] + u[3] * v[3]) / sqrt((u[1]^2 + u[2]^2 + u[3]^2) * (v[1]^2 + v[2]^2 + v[3]^2)))
end

function medium_revisit_time(orb_elem::Orbit)    
    false_count = 0
    step  = 100
    visit = access(orb_elem, step)
    n = length(visit)

    count = Int[]
    for i = 1:n
        if visit[i] == false
            false_count = false_count + 1
        elseif false_count > 0
            push!(count, false_count)
            false_count = 0
        end
    end

    sum = 0
    n = length(count)
    for i = 1:n
        sum = sum + count[i]
    end
    step * sum / n
end

function max_revisit_time(orb_elem::Orbit)

end


function access_angle(orb_elem::Orbit)
    # Covered angle for the given orbit altitude
    acos(Rm / orb_elem.a)
end

function extract_dim(r)
    n = length(r)
    x = Array{Float64}(undef, n)
    y = Array{Float64}(undef, n)
    z = Array{Float64}(undef, n)
    for i = 1:n
        x[i] = r[i][1]
        y[i] = r[i][2]
        z[i] = r[i][3]
    end
    x, y, z 
end
