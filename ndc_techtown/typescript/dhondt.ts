interface Party {
    name: string;
    votes: number;
    seats: number;
}

interface Quotient {
    partyIndex: number;
    value: number;
}

function generateParties(numParties: number): Party[] {
    const parties: Party[] = [];
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    for (let i = 0; i < numParties; i++) {
        const partyName = characters.charAt(i);
        const votes = (i + 1) * 1000;
        parties.push({ name: partyName, votes: votes, seats: 0 });
    }
    return parties;
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

const numParties = 10;
const parties: Party[] = generateParties(numParties);

const totalSeats = 50000;
const result = dHondt(parties, totalSeats);
console.log(result);
