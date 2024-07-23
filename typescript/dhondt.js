function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}
function getRandomName(length) {
    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    var name = '';
    for (var i = 0; i < length; i++) {
        name += characters.charAt(Math.floor(Math.random() * characters.length));
    }
    return name;
}
function generateRandomParties(numParties, maxVotes) {
    var parties = [];
    for (var i = 0; i < numParties; i++) {
        var nameLength = getRandomInt(1, 10);
        var partyName = getRandomName(nameLength);
        var votes = getRandomInt(0, maxVotes);
        parties.push({ name: partyName, votes: votes, seats: 0 });
    }
    return parties;
}
function dHondt(parties, totalSeats) {
    // Initialize seats for each party to 0
    parties.forEach(function (party) {
        party.seats = 0;
    });
    var quotients = [];
    // Generate all quotients
    for (var i = 0; i < parties.length; i++) {
        for (var j = 1; j <= totalSeats; j++) {
            quotients.push({
                partyIndex: i,
                value: parties[i].votes / j
            });
        }
    }
    // Sort quotients in descending order
    quotients.sort(function (a, b) { return b.value - a.value; });
    // Allocate seats based on the highest quotients
    for (var i = 0; i < totalSeats; i++) {
        var partyIndex = quotients[i].partyIndex;
        parties[partyIndex].seats++;
    }
    return parties;
}
var numParties = 1000;
var maxVotes = 1000;
var parties = generateRandomParties(numParties, maxVotes);
var totalSeats = 500;
var result = dHondt(parties, totalSeats);
console.log(result);
