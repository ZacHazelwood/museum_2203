require './lib/museum'
require './lib/patron'
require './lib/exhibit'

RSpec.describe do

  it "exists" do
    dmns = Museum.new("Denver Museum of Nature and Science")

    expect(dmns).to be_a(Museum)
  end

  it "has attributes" do
    dmns = Museum.new("Denver Museum of Nature and Science")

    expect(dmns.name).to eq("Denver Museum of Nature and Science")
    expect(dmns.exhibits).to eq([])
    expect(dmns.patrons).to eq([])
  end

  it "can add exhibits" do
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    expect(dmns.exhibits.count).to eq(3)
  end

  it "can recommend exhibits" do
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")

    patron_2 = Patron.new("Sally", 20)
    patron_2.add_interest("IMAX")
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    expect(dmns.recommend_exhibits(patron_1).count).to eq(2)
    expect(dmns.recommend_exhibits(patron_2).count).to eq(1)
  end

  it "can admit patrons" do
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")

    patron_2 = Patron.new("Sally", 20)
    patron_2.add_interest("IMAX")

    patron_3 = Patron.new("Johnny", 5)
    patron_3.add_interest("Dead Sea Scrolls")

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    expect(dmns.patrons.count).to eq(3)
  end

  it "assigns patrons by interest" do
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")

    patron_2 = Patron.new("Sally", 20)
    patron_2.add_interest("IMAX")

    patron_3 = Patron.new("Johnny", 5)
    patron_3.add_interest("Dead Sea Scrolls")

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)
# require 'pry'; binding.pry

    expect(dmns.patrons_by_exhibit_interest).to eq(
                                                    {gems_and_minerals => [patron_1],
                                                    dead_sea_scrolls => [patron_1, patron_2, patron_3],
                                                    imax => []
                                                    })
  end
end
