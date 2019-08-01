module Centauri

export JD_J2000, R0, Rm, m0, J2, Rs, ne, au2m, sunRad
export a_wgs84, b_wgs84, f_wgs84, e_wgs84, el_wgs84

import Base: asin, atan, copy, cos, deepcopy, getindex, mod, setindex!, sin,
       show

using Interpolations
using LinearAlgebra
using OptionalData
using Parameters
using PolynomialRoots
using Printf
using ReferenceFrameRotations
using RemoteFiles
using StaticArrays
using SparseArrays
using Statistics
using SatelliteToolbox

# Re-exporting symbols from ReferenceFrameRotations.jl.
export DCM
export Quaternion

################################################################################
#                             Types and Structures
################################################################################

include("types.jl")

################################################################################
#                                  Constants
################################################################################

include("constants.jl")

################################################################################
#                                    Files
################################################################################

include("mission/coverage_data.jl")
include("mission/satellite_data.jl")

include("objectives/objective_functions.jl")

end # module
