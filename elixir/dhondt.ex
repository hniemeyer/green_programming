defmodule Election do
  def get_random_int(min, max) do
    :rand.uniform(max - min + 1) + min - 1
  end

  def get_random_name(length) do
    characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
    for _ <- 1..length, into: "", do: <<Enum.random(characters)>>
  end

  def generate_random_parties(num_parties, max_votes) do
    Enum.map(1..num_parties, fn _ ->
      name_length = get_random_int(1, 10)
      party_name = get_random_name(name_length)
      votes = get_random_int(0, max_votes)
      %{name: party_name, votes: votes, seats: 0}
    end)
  end

  def dhondt(parties, total_seats) do
    quotients = for {party, i} <- Enum.with_index(parties),
                  j <- 1..total_seats do
      %{party_index: i, value: party.votes / j}
    end

    sorted_quotients = Enum.sort_by(quotients, &(&1.value), :desc)

    allocated_seats = Enum.reduce(sorted_quotients |> Enum.take(total_seats), parties, fn quotient, acc ->
      party_index = quotient.party_index
      List.update_at(acc, party_index, fn party -> Map.update!(party, :seats, &(&1 + 1)) end)
    end)

    allocated_seats
  end
end

num_parties = 5
max_votes = 1000
parties = Election.generate_random_parties(num_parties, max_votes)

total_seats = 10
result = Election.dhondt(parties, total_seats)
IO.inspect(result)
