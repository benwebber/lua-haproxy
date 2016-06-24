local http     = require('haproxy.server.http')
local jsonify  = require('haproxy.server.jsonify')
local Response = require('haproxy.server.response')
local View     = require('haproxy.server.view')

local ServerWeightView = View.new('ServerWeightView')

function ServerWeightView:get(request, context)
  return jsonify(context.stats:get_weight(request.view_args.backend, request.view_args.server))
end

function ServerWeightView:patch(request, context)
  local data = request:json()
  context.stats:set_weight(request.view_args.backend, request.view_args.server, data.current)
  return Response(http.status.OK)
end

return ServerWeightView
