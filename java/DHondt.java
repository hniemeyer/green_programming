import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Random;

class Party {
    String name;
    int votes;
    int seats;

    Party(String name, int votes) {
        this.name = name;
        this.votes = votes;
        this.seats = 0;
    }
}

class Quotient {
    int partyIndex;
    double value;

    Quotient(int partyIndex, double value) {
        this.partyIndex = partyIndex;
        this.value = value;
    }
}

public class DHondt {

    private static Random random = new Random();

    public static int getRandomInt(int min, int max) {
        return random.nextInt((max - min) + 1) + min;
    }

    public static String getRandomName(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        StringBuilder name = new StringBuilder();
        for (int i = 0; i < length; i++) {
            name.append(characters.charAt(random.nextInt(characters.length())));
        }
        return name.toString();
    }

    public static List<Party> generateRandomParties(int numParties, int maxVotes) {
        List<Party> parties = new ArrayList<>();
        for (int i = 0; i < numParties; i++) {
            int nameLength = getRandomInt(1, 10);
            String partyName = getRandomName(nameLength);
            int votes = getRandomInt(0, maxVotes);
            parties.add(new Party(partyName, votes));
        }
        return parties;
    }

    public static List<Party> dHondt(List<Party> parties, int totalSeats) {
        // Initialize seats for each party to 0
        for (Party party : parties) {
            party.seats = 0;
        }

        List<Quotient> quotients = new ArrayList<>();

        // Generate all quotients
        for (int i = 0; i < parties.size(); i++) {
            for (int j = 1; j <= totalSeats; j++) {
                quotients.add(new Quotient(i, (double) parties.get(i).votes / j));
            }
        }

        // Sort quotients in descending order
        Collections.sort(quotients, new Comparator<Quotient>() {
            @Override
            public int compare(Quotient q1, Quotient q2) {
                return Double.compare(q2.value, q1.value);
            }
        });

        // Allocate seats based on the highest quotients
        for (int i = 0; i < totalSeats; i++) {
            int partyIndex = quotients.get(i).partyIndex;
            parties.get(partyIndex).seats++;
        }

        return parties;
    }

    public static void main(String[] args) {
        int numParties = 5;
        int maxVotes = 1000;
        List<Party> parties = generateRandomParties(numParties, maxVotes);

        int totalSeats = 10;
        List<Party> result = dHondt(parties, totalSeats);

        for (Party party : result) {
            System.out.println("Party: " + party.name + ", Votes: " + party.votes + ", Seats: " + party.seats);
        }
    }
}
