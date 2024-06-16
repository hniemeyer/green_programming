interface Party {
    name: string;
    votes: number;
    seats: number;
}

interface Quotient {
    partyIndex: number;
    value: number;
}

function dHondt(parties: Party[], totalSeats: number): Party[] {
    // Initialize seats for each party to 0
    parties.forEach(party => {
        party.seats = 0;
    });

    let quotients: Quotient[] = [];

    // Generate all quotients
    for (let i = 0; i < parties.length; i++) {
        for (let j = 1; j <= totalSeats; j++) {
            quotients.push({
                partyIndex: i,
                value: parties[i].votes / j
            });
        }
    }

    // Sort quotients in descending order
    quotients.sort((a, b) => b.value - a.value);

    // Allocate seats based on the highest quotients
    for (let i = 0; i < totalSeats; i++) {
        let partyIndex = quotients[i].partyIndex;
        parties[partyIndex].seats++;
    }

    return parties;
}

// Example usage:
const parties: Party[] = [
    { name: "Party A", votes: 1000, seats: 0 },
    { name: "Party B", votes: 800, seats: 0 },
    { name: "Party C", votes: 600, seats: 0 }
];

const totalSeats = 10;
const result = dHondt(parties, totalSeats);
console.log(result);
