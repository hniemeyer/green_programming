use crate::voting::VotingResults;
use rand::Rng;

fn generate_random_name() -> String {
    // Define the alphabet
    let alphabet: Vec<char> = ('a'..='z').collect();

    // Generate a random length between 1 and 10
    let mut rng = rand::thread_rng();
    let name_length = rng.gen_range(1..=10);

    // Generate a random name of the determined length
    let name: String = (0..name_length)
        .map(|_| {
            let idx = rng.gen_range(0..alphabet.len());
            alphabet[idx]
        })
        .collect();

    name
}

pub fn generate_parties(number_of_parties: usize) -> Vec<VotingResults> {
    let mut rng = rand::thread_rng();
    let mut parties = Vec::new();

    for _ in 0..number_of_parties {
        let party = generate_random_name();
        let votes = rng.gen_range(1..=1000);

        let voting_results = VotingResults { party, votes };
        parties.push(voting_results);
    }

    parties
}
