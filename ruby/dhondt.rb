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
  
  def get_random_int(min, max)
    rand(min..max)
  end
  
  def get_random_name(length)
    characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
    name = ''
    length.times do
      name += characters[rand(characters.length)]
    end
    name
  end
  
  def generate_random_parties(num_parties, max_votes)
    parties = []
    num_parties.times do
      name_length = get_random_int(1, 10)
      party_name = get_random_name(name_length)
      votes = get_random_int(0, max_votes)
      parties << Party.new(party_name, votes)
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
  
  num_parties = 5
  max_votes = 1000
  parties = generate_random_parties(num_parties, max_votes)
  
  total_seats = 10
  result = d_hondt(parties, total_seats)
  puts result.map { |party| "#{party.name}: #{party.votes} votes, #{party.seats} seats" }
  