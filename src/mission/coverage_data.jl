#== # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 Description

   Responsible for fetching the coverage requirements from configuration
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ==#

export accessed_point
export maximum_revisit_time

function accessed_point()
    # Coordinates of the point that must be accessed.
    100
end

function maximum_revisit_time()
    # Maximum time in seconds to the next access.
    100
end