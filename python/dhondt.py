import random

def hondt_method(votes_per_party, total_number_of_seats):
    proportional_votes = []
    for i in range(1, total_number_of_seats + 1):
        for party, votes in votes_per_party.items():
            proportional_votes.append((party, votes / i))

    proportional_votes.sort(key=lambda tup: tup[1], reverse=True)
    proportional_votes = proportional_votes[:total_number_of_seats]

    distribution = {}
    for party in votes_per_party:
        seats = 0
        for p, v in proportional_votes:
            if p == party:
                seats += 1

        distribution[party] = seats

    return distribution


if __name__ == "__main__":
    num_parties = 1000
    num_votes = 1000
    num_seats = 500
    votes = {}
    for idx in range(num_parties):
        votes["".join(random.choices("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", k=10))] = random.randint(0, num_votes)
    print(hondt_method(votes, num_seats))
