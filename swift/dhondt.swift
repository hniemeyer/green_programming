import Foundation

struct Party {
    var name: String
    var votes: Int
    var seats: Int
}

struct Quotient {
    var partyIndex: Int
    var value: Double
}

func getRandomInt(min: Int, max: Int) -> Int {
    return Int.random(in: min...max)
}

func getRandomName(length: Int) -> String {
    let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    return String((0..<length).map { _ in characters.randomElement()! })
}

func generateRandomParties(numParties: Int, maxVotes: Int) -> [Party] {
    var parties: [Party] = []
    for _ in 0..<numParties {
        let nameLength = getRandomInt(min: 1, max: 10)
        let partyName = getRandomName(length: nameLength)
        let votes = getRandomInt(min: 0, max: maxVotes)
        parties.append(Party(name: partyName, votes: votes, seats: 0))
    }
    return parties
}

func dHondt(parties: [Party], totalSeats: Int) -> [Party] {
    var parties = parties
    
    // Initialize seats for each party to 0
    for i in 0..<parties.count {
        parties[i].seats = 0
    }
    
    var quotients: [Quotient] = []
    
    // Generate all quotients
    for i in 0..<parties.count {
        for j in 1...totalSeats {
            quotients.append(Quotient(partyIndex: i, value: Double(parties[i].votes) / Double(j)))
        }
    }
    
    // Sort quotients in descending order
    quotients.sort(by: { $0.value > $1.value })
    
    // Allocate seats based on the highest quotients
    for i in 0..<totalSeats {
        let partyIndex = quotients[i].partyIndex
        parties[partyIndex].seats += 1
    }
    
    return parties
}

let numParties = 5
let maxVotes = 1000
let parties = generateRandomParties(numParties: numParties, maxVotes: maxVotes)

let totalSeats = 10
let result = dHondt(parties: parties, totalSeats: totalSeats)
print(result)
