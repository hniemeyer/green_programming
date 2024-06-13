use itertools::Itertools;

struct VotingResults {
    party: String,
    votes: usize,
}

struct DHondtIntermediate {
    party: String,
    votes_per_divisor: f64,
}

fn main() {
    const NUMBER_OF_SEATS: usize = 10;
    let election = vec![
        VotingResults {
            party: "A".to_string(),
            votes: 100,
        },
        VotingResults {
            party: "B".to_string(),
            votes: 200,
        },
        VotingResults {
            party: "C".to_string(),
            votes: 300,
        },
    ];

    let it = (1..NUMBER_OF_SEATS + 1).cartesian_product(election.iter());
    let it2 = it.map(|(i, c)| DHondtIntermediate {
        party: c.party.clone(),
        votes_per_divisor: c.votes as f64 / i as f64,
    });
    let it3 = it2.sorted_by(|a, b| {
        b.votes_per_divisor
            .partial_cmp(&a.votes_per_divisor)
            .unwrap()
    });
    println!(
        "{}",
        it3.take(NUMBER_OF_SEATS)
            .filter(|elem| elem.party == "C")
            .count()
    );
}
