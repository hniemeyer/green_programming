-- monte_carlo_pi.lua
-- Estimates pi using the Monte Carlo method with 10 million iterations

local iterations = 10000000
local inside = 0

math.randomseed(os.time())

for i = 1, iterations do
    -- generate random point in [-1,1] x [-1,1]
    local x = (math.random() * 2) - 1
    local y = (math.random() * 2) - 1
    if (x * x + y * y) <= 1 then
        inside = inside + 1
    end
end

local pi_estimate = (inside / iterations) * 4
print(string.format("Estimated π after %d iterations: %.6f", iterations, pi_estimate))