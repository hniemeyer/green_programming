
data class Party(
    var name: String,
    var votes: Int,
    var seats: Int
)

data class Quotient(
    val partyIndex: Int,
    val value: Double
)

fun generateRandomParties(numParties: Int): List<Party> {
    val parties = mutableListOf<Party>()
    val characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    for (i in 0 until numParties) {
        var name = ""
        name += characters[i]
        val votes = (i+1)*1000
        parties.add(Party(name, votes, 0))
    }
    return parties
}

fun dHondt(parties: List<Party>, totalSeats: Int): List<Party> {
    // Initialize seats for each party to 0
    parties.forEach { it.seats = 0 }

    val quotients = mutableListOf<Quotient>()

    // Generate all quotients
    for (i in parties.indices) {
        for (j in 1..totalSeats) {
            quotients.add(Quotient(i, parties[i].votes.toDouble() / j))
        }
    }

    // Sort quotients in descending order
    quotients.sortByDescending { it.value }

    // Allocate seats based on the highest quotients
    for (i in 0 until totalSeats) {
        val partyIndex = quotients[i].partyIndex
        parties[partyIndex].seats++
    }

    return parties
}

fun main() {
    val numParties = 10
    val parties = generateRandomParties(numParties)

    val totalSeats = 50000
    val result = dHondt(parties, totalSeats)
    println(result)
}
