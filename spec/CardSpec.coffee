describe "deck constructor", ->

  it "should create a card collection", ->
    collection = new Deck()
    expect(collection.length).toBe 52

describe "flip", ->
  card = new Card({rank:0, suit:0})
  it "should flip cards", ->
    expect(card.get('revealed')).toBe(true)
    card.flip()
    expect(card.get('revealed')).toBe(false)