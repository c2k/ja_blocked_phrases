class JaBlockedRoot < ActiveRecord::Base

  validates_presence_of :root
  validates_uniqueness_of :root

  has_many :ja_blocked_phrases, :dependent => :destroy

  attr_accessible :root

  validate :other_forms_should_not_exist
  after_create :create_root_phrase

  def create_blocked_phrases(furigana = nil)
    if self.root.moji_type?(Moji::HIRA | Moji::ZEN_JSYMBOL) # Hiragana and zenkaku Japanese symbols
      return create_phrases(:furigana, :romaji, :zenkaku)
    elsif self.root.moji_type?(Moji::KATA | Moji::ZEN_JSYMBOL) # Katakana and zenkaku Japanese symbols
      return create_phrases(:hiragana, :romaji, :zenkaku)
    elsif self.root.match(/^[a-zA-Z]+$/) # Romaji
      return create_phrases(:zenkaku)
    elsif self.root.contains_kanji? and not furigana.nil? and furigana.moji_type?(Moji::KATA | Moji::ZEN_JSYMBOL) # Katakana and zenkaku Japanese symbols
      return [
        self.ja_blocked_phrases.create_furigana(furigana),
        self.ja_blocked_phrases.create_hiragana(furigana),
        self.ja_blocked_phrases.create_romaji(furigana),
        self.ja_blocked_phrases.create_zenkaku(furigana)
      ]
    else
      return []
    end
  end

  private

  def create_root_phrase
    self.ja_blocked_phrases.create(phrase: self.root, furigana: self.root.katakana?)
  end

  def other_forms_should_not_exist
    other_forms = [self.root.hiragana, self.root.katakana, self.root.romaji.downcase, self.root.romaji.upcase.han_to_zen]

    if JaBlockedRoot.where(root: other_forms).exists?
      errors.add(:root, "already exists in another form(hiragana, katakana, romaji, zenkaku)")
    end
  end

  def create_phrases(*forms)
    forms.each do |form|
      method_obj = JaBlockedPhrase.method("create_#{form}".to_sym)
      phrase = method_obj.call(self.root)
      if phrase.valid?
        self.ja_blocked_phrases << phrase
      end
    end
    return self.ja_blocked_phrases
  end

end
