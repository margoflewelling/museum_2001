require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/patron'


class ExhibitTest < Minitest:: Test

  def setup
    @patron_1 = Patron.new("Bob", 20)
  end

  def test_it_exists
    assert_instance_of Patron, @patron_1
  end

  def test_it_has_attrs
    assert_equal "Bob", @patron_1.name
    assert_equal 20, @patron_1.spending_money
    assert_equal [], @patron_1.interests
  end

  def test_adding_interests
    @patron_1.add_interest("Dead Sea Scrolls")
    @patron_1.add_interest("Gems and Minerals")
    assert_equal ["Dead Sea Scrolls", "Gems and Minerals"], @patron_1.interests
  end

end



  # pry(main)> patron_1 = Patron.new("Bob", 20)
  # # => #<Patron:0x00007fcb13b5c7d8...>
  #
  # pry(main)> patron_1.name
  # # => "Bob"
  #
  # pry(main)> patron_1.spending_money
  # # => 20
  #
  # pry(main)> patron_1.interests
  # # => []
  #
  # pry(main)> patron_1.add_interest("Dead Sea Scrolls")
  #
  # pry(main)> patron_1.add_interest("Gems and Minerals")
  #
  # pry(main)> patron_1.interests
  # # => ["Dead Sea Scrolls", "Gems and Minerals"]
