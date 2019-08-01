in#== # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 Description

   Calculates the objective functions for a 
   given orbit and mission configuration
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ==#

export covered_area
export orbit_cost
export revisit_time
export reentry_time

function covered_area(orb_elem::Array{Float64,2}, proj_time::Float64)
    # Covered area for the given orbit
    100
end

function orbit_cost(orb_elem::Array{Float64,2}, stand_orb_elem)
    # Cost of transfer from injection orbit to the given orbit
    100
end

function revisit_time(orb_elem::Array{Float64,2}, access_point)
    # Time of revisit for the point of access in seconds

    10
end

function reentry_time(orb_elem::Array{Float64,2}, access_point)
    # Time in days for the reentry of the satellite in the given orbit
    3650
end