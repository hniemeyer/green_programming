function generateParties(numParties) {
    var parties = [];
    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    for (var i = 0; i < numParties; i++) {
        var partyName = characters.charAt(i);
        var votes = (i + 1) * 1000;
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
var numParties = 10;
var parties = generateParties(numParties);
var totalSeats = 50000;
var result = dHondt(parties, totalSeats);
console.log(result);
