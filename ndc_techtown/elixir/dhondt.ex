defmodule Election do
  
   def generate_parties(num_parties) do
    Enum.map(1..num_parties, fn index ->
      party_name = <<(64 + index)::utf8>> # 'A' is 65 in ASCII, so we start at 64 + 1 = 65
      votes = index * 1000
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

parties = Election.generate_parties(10)
total_seats = 50000
result = Election.dhondt(parties, total_seats)
IO.inspect(result)
