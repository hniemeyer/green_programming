class Party
    attr_accessor :name, :votes, :seats
  
    def initialize(name, votes, seats = 0)
      @name = name
      @votes = votes
      @seats = seats
    end
  end
  
  class Quotient
    attr_accessor :party_index, :value
  
    def initialize(party_index, value)
      @party_index = party_index
      @value = value
    end
  end
  
   
  def generate_parties(num_parties)
    parties = []
    characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
    idx = 0
    num_parties.times do
      party_name = characters[idx]
      votes = (idx+1)*1000
      parties << Party.new(party_name, votes)
      idx = idx + 1
    end
    parties
  end
  
  def d_hondt(parties, total_seats)
    # Initialize seats for each party to 0
    parties.each do |party|
      party.seats = 0
    end
  
    quotients = []
  
    # Generate all quotients
    parties.each_with_index do |party, i|
      (1..total_seats).each do |j|
        quotients << Quotient.new(i, party.votes.to_f / j)
      end
    end
  
    # Sort quotients in descending order
    quotients.sort_by! { |q| -q.value }
  
    # Allocate seats based on the highest quotients
    total_seats.times do |i|
      party_index = quotients[i].party_index
      parties[party_index].seats += 1
    end
  
    parties
  end
  
  num_parties = 10
  parties = generate_parties(num_parties)
  
  total_seats = 50000
  result = d_hondt(parties, total_seats)
  puts result.map { |party| "#{party.name}: #{party.votes} votes, #{party.seats} seats" }
  