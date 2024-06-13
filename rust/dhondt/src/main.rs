use itertools::Itertools;
use std::collections::HashMap;

mod generate_data;
mod voting;

struct DHondtIntermediate {
    party: String,
    votes_per_divisor: f64,
}

fn main() {
    const NUMBER_OF_SEATS: usize = 10;
    let election = generate_data::generate_parties(3);

    for party in &election {
        println!("Party: {}, Votes: {}", party.party, party.votes);
    }

    let cart_product = (1..NUMBER_OF_SEATS + 1).cartesian_product(election.iter());

    let parties_and_divisor_results = cart_product.map(|(i, c)| DHondtIntermediate {
        party: c.party.clone(),
        votes_per_divisor: c.votes as f64 / i as f64,
    });

    let seats_in_parliament = parties_and_divisor_results
        .sorted_by(|a, b| {
            b.votes_per_divisor
                .partial_cmp(&a.votes_per_divisor)
                .unwrap()
        })
        .take(NUMBER_OF_SEATS);

    let mut final_results_aggregated: HashMap<String, usize> = HashMap::new();
    for elem in seats_in_parliament {
        *final_results_aggregated.entry(elem.party).or_default() += 1;
    }

    println!("{:?}", final_results_aggregated);
}
