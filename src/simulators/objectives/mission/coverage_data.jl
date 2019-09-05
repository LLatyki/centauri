#== # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 Description

   Responsible for fetching the coverage requirements from configuration
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ==#
using SatelliteToolbox

export access_point
export maximum_revisit_time

function access_point()
    # Coordinates of the point that must be accessed.
    # (latitude -90:90, longitude -180:180)
    (lat = -23.17944, lon = -45.88694)
end
