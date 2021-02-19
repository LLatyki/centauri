module Simulation
    using SatelliteToolbox
    import JSON

    # Structs utilizados e função para parsear o arquivo de configuraçao

    export initialize

    
    struct SolutionSpace
        a_range
        i_range
        Ω_range
    end

    struct Satellite
        M
        A
        Cd
        aperture
        exhaust_v
    end

    struct AccessArea
        type
        coordinates
    end

    struct SimulationDefinition
        solution_space::SolutionSpace
        satellite::Satellite
        injection_orbit::Orbit
        access_area::AccessArea
        mission_lifetime::Int
    end

    function initialize()
        config_dict = JSON.parsefile("config.json")

        ssd = config_dict["solution_space"]
        a_range = (Rm + ssd["min_height"]*1000, Rm + ssd["max_height"]*1000)
        i_range = (ssd["min_inclination"]*pi/180, ssd["max_inclination"]*pi/180)
        Ω_range = (ssd["min_long_ascending_node"]*pi/180, ssd["max_long_ascending_node"]*pi/180)
        solution_space = SolutionSpace(a_range, i_range, Ω_range)

        mission_lifetime = config_dict["mission"]["lifetime"]
        iop = config_dict["satellite"]["injection_orbit"] #Injection Orbit Parameters
        injection_orbit = Orbit(iop["semimajor_axis"], iop["eccentricity"], iop["inclination"],iop["ascending_node_longitude"],iop["periapsis_argument"],iop["true_anomaly"])
        satellite = Satellite(config_dict["satellite"]["mass"],config_dict["satellite"]["cross_section_area"],config_dict["satellite"]["drag_coefficient"],config_dict["satellite"]["sensor_aperture"], config_dict["satellite"]["exhaust_velocity"])
        aa_dict = config_dict["mission"]["access_area"]["geometry"]
        access_area = AccessArea(aa_dict["type"], aa_dict["coordinates"])
        return SimulationDefinition(solution_space, satellite, injection_orbit, access_area, mission_lifetime)
    end
end