import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class DHondt {

    public static List<Party> generateParties(int numParties) {
        List<Party> parties = new ArrayList<>();
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        
        for (int i = 0; i < numParties; i++) {
            StringBuilder name = new StringBuilder();
            name.append(characters.charAt(i));
            String partyName = name.toString();
            int votes = (i+1)*1000;
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
        int numParties = 10;
        List<Party> parties = generateParties(numParties);

        int totalSeats = 50000;
        List<Party> result = dHondt(parties, totalSeats);

        for (Party party : result) {
            System.out.println("Party: " + party.name + ", Votes: " + party.votes + ", Seats: " + party.seats);
        }
    }
}

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