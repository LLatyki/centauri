using CSV
using Tables


function write_file(table)
    CSV.write(file_name, table)
end

function append_file(table)
    CSV.write(file_name, table, append = true)
end

function file_name()
    "dados_hi.csv"
end