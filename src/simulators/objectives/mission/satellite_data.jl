#== # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 Description

    Responsible for fetching the satellite data from configuration
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ==#
using SatelliteToolbox

export satellite_data
export injection_orbit
export mission_time

function satellite_data()
    # Satellite physical data
    # Mass in kg, Area in m², Drag coefficient.
    (m = 10, A = 0.2, Cd = 3)
end 

function sensor_specification()
    # Specifications of the sensor of the satellite.
    100
end

function injection_orbit()
    # Orbit elements of the injection orbit.
    # Setar elementos orbitais como configuração
    
    Orbit(0, Rm + 80000., 0., 0., 0., 0., 0.) 
end

function mission_time()
    # Duration of the mission in days

    730
end