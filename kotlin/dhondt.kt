import kotlin.random.Random

data class Party(
    var name: String,
    var votes: Int,
    var seats: Int
)

data class Quotient(
    val partyIndex: Int,
    val value: Double
)

fun getRandomInt(min: Int, max: Int): Int {
    return Random.nextInt(min, max + 1)
}

fun getRandomName(length: Int): String {
    val characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    var name = ""
    for (i in 0 until length) {
        name += characters[Random.nextInt(characters.length)]
    }
    return name
}

fun generateRandomParties(numParties: Int, maxVotes: Int): List<Party> {
    val parties = mutableListOf<Party>()
    for (i in 0 until numParties) {
        val nameLength = getRandomInt(1, 10)
        val partyName = getRandomName(nameLength)
        val votes = getRandomInt(0, maxVotes)
        parties.add(Party(partyName, votes, 0))
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
    val numParties = 1000
    val maxVotes = 1000
    val parties = generateRandomParties(numParties, maxVotes)

    val totalSeats = 500
    val result = dHondt(parties, totalSeats)
    println(result)
}
