# centauri
Algoritmo de otimização multiobjetivo de órbitas de satélites.


### Input:
Arquivo config.json com os dados :

- "mass":  Mass in kg
- "cross_section_area": Area in m²
- "drag_coefficient": Coefieciente de arrasto
- "sensor_aperture": Specifications of the sensor of the satellite in degrees.
- "injection_orbit": Orbit elements of the injection orbit.
- "lifetime" Duration of the mission in days
- "coordinates": Coordinates of the point that must be accessed.

### Running:
- julia
- ] 
- activate simulation
- include("src/centauri.jl")