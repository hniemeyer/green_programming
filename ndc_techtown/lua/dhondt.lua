-- Define Party and Quotient tables (similar to TypeScript interfaces)
Party = {}
Party.__index = Party

function Party:new(name, votes, seats)
    local party = {
        name = name,
        votes = votes,
        seats = seats
    }
    setmetatable(party, Party)
    return party
end

Quotient = {}
Quotient.__index = Quotient

function Quotient:new(partyIndex, value)
    local quotient = {
        partyIndex = partyIndex,
        value = value
    }
    setmetatable(quotient, Quotient)
    return quotient
end

-- Function to generate parties
function generateParties(numParties)
    local characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
    local parties = {}
    for i = 1, numParties do
        local partyName = characters:sub(i,i)
        local votes = i*1000
        table.insert(parties, Party:new(partyName, votes, 0))
    end
    return parties
end

-- d'Hondt method function
function dHondt(parties, totalSeats)
    -- Initialize seats for each party to 0
    for _, party in ipairs(parties) do
        party.seats = 0
    end

    local quotients = {}

    -- Generate all quotients
    for i = 1, #parties do
        for j = 1, totalSeats do
            table.insert(quotients, Quotient:new(i, parties[i].votes / j))
        end
    end

    -- Sort quotients in descending order
    table.sort(quotients, function(a, b) return a.value > b.value end)

    -- Allocate seats based on the highest quotients
    for i = 1, totalSeats do
        local partyIndex = quotients[i].partyIndex
        parties[partyIndex].seats = parties[partyIndex].seats + 1
    end

    return parties
end

-- Main script
local numParties = 10
local parties = generateParties(numParties)

local totalSeats = 50000
local result = dHondt(parties, totalSeats)

for _, party in ipairs(result) do
    print(party.name .. ": " .. party.votes .. " votes, " .. party.seats .. " seats")
end
