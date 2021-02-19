using Test
include("../src/simulators/orbit_cost.jl")

@test  plane_change_cost(0,0,1,1203) == 0
@test  plane_change_cost(20,20,1,1203) == 0

@test  maintenance_cost_per_rev(1, 1, 1,7.0*10^6) > maintenance_cost_per_rev(1, 1, 10,7.0*10^6) 
@test  maintenance_cost_per_rev(1, 1, 1,7.0*10^6) > maintenance_cost_per_rev(1, 1, 1,8.0*10^6) 
@test  maintenance_cost_per_rev(1, 10, 1,7.0*10^6) > maintenance_cost_per_rev(1, 1, 1,7.0*10^6) 
