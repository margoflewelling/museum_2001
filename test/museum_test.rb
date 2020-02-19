require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/exhibit'
require './lib/patron'
require './lib/museum'


class MuseumTest < Minitest:: Test

  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    @dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    @bones = Exhibit.new({name: "Bones", cost: 10})
    @imax = Exhibit.new({name: "IMAX",cost: 15})
    @patron_1 = Patron.new("Bob", 0)
    @patron_1.add_interest("Dead Sea Scrolls")
    @patron_1.add_interest("Gems and Minerals")
    @patron_2 = Patron.new("Sally", 20)
    @patron_2.add_interest("IMAX")
    @patron_3 = Patron.new("Johnny", 5)
    @patron_3.add_interest("Dead Sea Scrolls")
    @tj = Patron.new("TJ", 7)
    @tj.add_interest("IMAX")
    @tj.add_interest("Gems and Minerals")
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_it_has_attrs
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
  end

  def test_adding_an_exhibit
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @dmns.exhibits
  end

  def test_recommending_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    assert_equal [@gems_and_minerals, @dead_sea_scrolls], @dmns.recommend_exhibits(@patron_1)
    assert_equal [@imax], @dmns.recommend_exhibits(@patron_2)
  end

  def test_admitting_patrons
    assert_equal [], @dmns.patrons

    @dmns.admit(@patron_1)
    @dmns.admit(@patron_2)
    @dmns.admit(@patron_3)
    assert_equal [@patron_1, @patron_2, @patron_3], @dmns.patrons
  end

  def test_patrons_by_exhibit_interest
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @dmns.admit(@patron_1)
    @dmns.admit(@patron_2)
    @dmns.admit(@patron_3)
    expected = {@gems_and_minerals => [@patron_1], @dead_sea_scrolls => [@patron_1, @patron_3], @imax => [@patron_2]}
    assert_equal expected, @dmns.patrons_by_exhibit_interest
  end

  def test_lottery_contestants
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @dmns.admit(@patron_1)
    @dmns.admit(@patron_2)
    @dmns.admit(@patron_3)
    assert_equal [@patron_1, @patron_3], @dmns.ticket_lottery_contestants(@dead_sea_scrolls)
    assert_equal [], @dmns.ticket_lottery_contestants(@imax)
  end

  def test_draw_lottery_winner
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @dmns.add_exhibit(@bones)

    @dmns.admit(@patron_1)
    @dmns.admit(@patron_2)
    @dmns.admit(@patron_3)

    assert_nil @dmns.draw_lottery_winner(@gems_and_minerals)

    @dmns.stubs(:ticket_lottery_contestants).returns([@patron_3])
    assert_equal "Johnny", @dmns.draw_lottery_winner(@dead_sea_scrolls)
  end


  def test_announcing_winner
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @dmns.add_exhibit(@bones)

    @dmns.admit(@patron_1)
    @dmns.admit(@patron_2)
    @dmns.admit(@patron_3)

    expected1 = "No winners for this lottery"
    assert_equal expected1, @dmns.announce_lottery_winner(@gems_and_minerals)

    @dmns.stubs(:draw_lottery_winner).returns("Bob")
    expected2 = "Bob has won the Dead Sea Scrolls exhibit lottery"
    assert_equal expected2, @dmns.announce_lottery_winner(@dead_sea_scrolls)
  end

end
