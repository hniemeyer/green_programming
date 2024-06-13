use crate::voting::VotingResults;

pub fn generate_parties() -> Vec<VotingResults> {
    vec![
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
    ]
}
