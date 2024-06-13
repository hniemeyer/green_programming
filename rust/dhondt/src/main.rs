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
    let election = generate_data::generate_parties();

    let it = (1..NUMBER_OF_SEATS + 1).cartesian_product(election.iter());

    let it2 = it.map(|(i, c)| DHondtIntermediate {
        party: c.party.clone(),
        votes_per_divisor: c.votes as f64 / i as f64,
    });

    let it3 = it2
        .sorted_by(|a, b| {
            b.votes_per_divisor
                .partial_cmp(&a.votes_per_divisor)
                .unwrap()
        })
        .take(NUMBER_OF_SEATS);

    let mut final_results: HashMap<String, usize> = HashMap::new();
    for elem in it3 {
        *final_results.entry(elem.party).or_default() += 1;
    }

    println!("{:?}", final_results);
}
