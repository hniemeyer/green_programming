interface Party {
    name: string;
    votes: number;
    seats: number;
}

interface Quotient {
    partyIndex: number;
    value: number;
}


function getRandomInt(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function getRandomName(length: number): string {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    let name = '';
    for (let i = 0; i < length; i++) {
        name += characters.charAt(Math.floor(Math.random() * characters.length));
    }
    return name;
}

function generateRandomParties(numParties: number, maxVotes: number): Party[] {
    const parties: Party[] = [];
    for (let i = 0; i < numParties; i++) {
        const nameLength = getRandomInt(1, 10);
        const partyName = getRandomName(nameLength);
        const votes = getRandomInt(0, maxVotes);
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

const numParties = 1000;
const maxVotes = 1000;
const parties: Party[] = generateRandomParties(numParties, maxVotes);

const totalSeats = 500;
const result = dHondt(parties, totalSeats);
console.log(result);
