class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit_name)
    @exhibits << exhibit_name
  end

  def recommend_exhibits(patron)
    @exhibits.find_all do |exhibit|
      patron.interests.include?(exhibit.name)
    end
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    patrons_by_exhibit_interest = {}
    @exhibits.each do |exhibit|
      patrons_by_exhibit_interest[exhibit] = []
    end
    @patrons.each do |patron|
      recommend_exhibits(patron).each do |exhibit|
      patrons_by_exhibit_interest[exhibit] << patron
      end
    end
    patrons_by_exhibit_interest
  end

  def ticket_lottery_contestants(exhibit)
    patrons_by_exhibit_interest[exhibit].find_all do |patron|
      patron.spending_money < exhibit.cost
    end
  end

  def draw_lottery_winner(exhibit)
    if ticket_lottery_contestants(exhibit).length != 0
      return ticket_lottery_contestants(exhibit).sample.name
    else
      nil
    end
  end

  def announce_lottery_winner(exhibit)
    if ticket_lottery_contestants(exhibit).length != 0
      return "#{draw_lottery_winner(exhibit)} has won the #{exhibit.name} exhibit lottery"
    else
      return "No winners for this lottery"
    end
  end 


end
