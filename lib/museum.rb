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



end
