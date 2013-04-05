class JaBlockedPhrase < ActiveRecord::Base

  validates_presence_of :phrase
  validates_uniqueness_of :phrase

  belongs_to :ja_blocked_root

  attr_accessible :phrase, :furigana

  def self.create_furigana(phrase)
    return nil if phrase.blank?
    create(phrase: phrase.han_to_zen.katakana, furigana: true)
  end

  def self.create_hiragana(phrase)
    return nil if phrase.blank?
    create(phrase: phrase.han_to_zen.hiragana)
  end

  def self.create_romaji(phrase)
    return nil if phrase.blank?
    create(phrase: phrase.han_to_zen.romaji)
  end

  def self.create_zenkaku(phrase)
    return nil if phrase.blank?
    zenkaku = phrase.match(/^[a-zA-Z]+$/) ? phrase.upcase.han_to_zen : phrase.han_to_zen.romaji.upcase.han_to_zen
    create(phrase: zenkaku)
  end
end
