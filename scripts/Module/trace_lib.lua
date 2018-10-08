local MissileTool = require 'missile_tool'

local TraceLib = {}

function TraceLib.StraightLine(self)
    MissileTool.Move(self)
end

function TraceLib.ArcLine()
end

function TraceLib.Parabola()
end

return TraceLib