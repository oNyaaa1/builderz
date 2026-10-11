net.Receive("rust_WriteVoltage", function()
    local ent = net.ReadEntity()
    local flt = net.ReadFloat()
    ent.Voltage = flt
end)

net.Receive("Builder_Built", function()
    local ent = net.ReadEntity()
    local flt = net.ReadFloat()
    ent.BuilderPoints = flt
end)