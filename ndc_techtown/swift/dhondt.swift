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

func generateParties(numParties: Int) -> [Party] {
    var parties: [Party] = []
    let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    for idx in 0..<numParties {
        let character = characters[characters.index(characters.startIndex, offsetBy: idx)]
        let partyName = String(character)
        let votes = (idx+1)*1000
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

let numParties = 10
let parties = generateParties(numParties: numParties)

let totalSeats = 50000
let result = dHondt(parties: parties, totalSeats: totalSeats)
print(result)
