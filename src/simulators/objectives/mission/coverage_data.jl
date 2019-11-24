#== # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 Description

   Responsible for fetching the coverage requirements from configuration
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ==#
using SatelliteToolbox

export access_point
export maximum_revisit_time

function access_point()
    # Coordinates of the point that must be accessed.
    (lat =  -15.5989, lon = -56.0949)
end
