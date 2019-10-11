using CSV
using Tables

function write_file(table)
    name = file_name()
    CSV.write(name, table)
end

function read_file()
    name = file_name()
    CSV.read(name)
end

function append_file(table)
    CSV.write(file_name, table, append = true)
end

function file_name()
    "dados_hi.csv"
end