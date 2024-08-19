local spring = {}
local epsilon = 1e-4

local sin = math.sin
local cos = math.cos
local exp = math.exp

function spring.new(init, obj)
	local self = setmetatable({}, { __index = spring })

	self.init = init
	self.pos = init
	self.velocity = Vector3.new()
	self.obj = obj
	self.ratio = 2
	self.frequency = 50

	return self
end

function spring:update(dt)
	local x0 = self.pos - self.obj

	if self.ratio > 1 + epsilon then -- Over damped
		local za = -self.frequency * self.ratio
		local zb = self.frequency * (self.ratio * self.ratio - 1) ^ 0.5
		local z0, z1 = za - zb, za + zb
		local expt0, expt1 = exp(z0 * dt), exp(z1 * dt)
		local c1 = (self.velocity - x0 * z1) / (-2 * zb)
		local c2 = x0 - c1

		self.pos = self.obj + c1 * expt0 + c2 * expt1
		self.velocity = c1 * z1 * expt0 + c2 * z1 * expt1
	elseif self.ratio > 1 - epsilon then -- Crit damped
		local expt = exp(-self.frequency * dt)
		local c1 = self.velocity + self.frequency * x0
		local c2 = (c1 * dt + x0) * expt

		self.pos = self.obj + c2
		self.velocity = (c1 * expt) - (c2 * self.frequency)
	else -- Under damped
		local frequencyratio = self.frequency * self.ratio
		local alpha = self.frequency * (1 - self.ratio * self.ratio) ^ 0.5
		local exp = exp(-dt * frequencyratio)
		local cos = cos(dt * alpha)
		local sin = sin(dt * alpha)
		local c2 = (self.velocity + x0 * frequencyratio) / alpha

		self.pos = self.obj + exp * (x0 * cos + c2 * sin)
		self.velocity = -exp * ((x0 * frequencyratio - c2 * alpha) * cos + (x0 * alpha + c2 * frequencyratio) * sin)
	end
end

return spring
