defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 20 cards" do
    deck_length = length(Cards.create_deck())
    assert deck_length == 20
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck()
    refute deck == Cards.shuffle(deck)
  end

  test "create a hand based on hand_size and updates the amount of cards in the deck" do
    {hand, deck} = Cards.create_hand(5)
    assert length(hand) == 5
    assert length(deck) == 15
  end

  test "Can save my deck to the filesystem" do
    deck = Cards.create_deck()
    Cards.save(deck, "test-save-deck")
    assert File.exists?("test-save-deck")
    # some cleanup
    delete_file("test-save-deck")
  end

  test "Can load my deck of cards from the Filesystem" do
    originalDeck = Cards.create_deck()
    Cards.save(originalDeck, "test-load-cards")
    assert File.exists?("test-load-cards")
    loadedDeck = Cards.load("test-load-cards")
    assert loadedDeck == originalDeck
    delete_file("test-load-cards")
  end

  test "Return false when deck does not contains card" do
    deck = Cards.create_deck()
    refute Cards.contains?(deck, "Queen of Spades")
  end

  test "Return true when deck contains the searched card" do
    deck = Cards.create_deck()
    assert Cards.contains?(deck, "Five of Clubs")
  end

  def delete_file(filename) do
    File.rm!(filename)
  end
end
