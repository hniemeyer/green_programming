use crate::voting::VotingResults;

pub fn generate_parties(number_of_parties: usize) -> Vec<VotingResults> {
    let mut parties = Vec::new();
    let alphabet: Vec<char> = ('a'..='z').collect();
    for idx in 0..number_of_parties {
        let party: String = alphabet[idx].to_string();
        let votes = (idx+1)*1000;

        let voting_results = VotingResults { party, votes };
        parties.push(voting_results);
    }

    parties
}
