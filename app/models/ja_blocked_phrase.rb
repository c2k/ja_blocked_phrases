class JaBlockedPhrase < ActiveRecord::Base

  validates_presence_of :phrase
  validates_uniqueness_of :phrase

  belongs_to :ja_blocked_root

  attr_accessible :phrase, :furigana

  def self.create_furigana(phrase)
    return nil if phrase.blank?
    create(phrase: phrase.katakana, furigana: true)
  end

  def self.create_hiragana(phrase)
    return nil if phrase.blank?
    create(phrase: phrase.hiragana)
  end

  def self.create_romaji(phrase)
    return nil if phrase.blank?
    create(phrase: phrase.romaji)
  end

  def self.create_zenkaku(phrase)
    return nil if phrase.blank?
    create(phrase: phrase.romaji.upcase.han_to_zen)
  end
end
