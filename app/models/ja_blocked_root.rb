class JaBlockedRoot < ActiveRecord::Base

  validates_presence_of :root
  validates_uniqueness_of :root

  has_many :ja_blocked_phrases, :dependent => :destroy

  attr_accessible :root

  validate :other_forms_should_not_exist
  before_create :format_root
  after_create :create_root_phrase

  def create_blocked_phrases(furigana = nil)
    # Hiragana including zenkaku Japanese symbols (i.e., full width chōonpu)
    if self.root.moji_type?(Moji::HIRA | Moji::ZEN_JSYMBOL)
      return create_phrase_forms(furigana, :furigana, :romaji, :zenkaku)

    # Katakana including zenkaku Japanese symbols (i.e., full width chōonpu)
    elsif self.root.moji_type?(Moji::KATA | Moji::ZEN_JSYMBOL)
      return create_phrase_forms(furigana, :hiragana, :romaji, :zenkaku)

    # Mixed kana (hiragana and katakana) including zenkaku Japanese symbols (i.e., full width chōonpu)
    elsif self.root.moji_type?(Moji::HIRA | Moji::KATA | Moji::ZEN_JSYMBOL)
      return create_phrase_forms(furigana, :furigana, :romaji, :zenkaku)

    # Romaji
    elsif self.root.match(/^[a-zA-Z]+$/)
      return create_phrase_forms(furigana, :zenkaku)

    # Kanji with furigana
    elsif self.root.contains_kanji? and not furigana.nil? and furigana.moji_type?(Moji::KATA | Moji::ZEN_JSYMBOL)
      return create_phrase_forms(furigana, :furigana, :hiragana, :romaji, :zenkaku)

    else
      return []
    end
  end

  private

  def create_phrase_forms(furigana = nil, *forms)
    furigana ||= self.root
    phrases = self.ja_blocked_phrases.all
    forms.each do |form|
      method_obj = JaBlockedPhrase.method("create_#{form}".to_sym)
      phrase = method_obj.call(furigana)
      if phrase.valid?
        self.ja_blocked_phrases << phrase
      end
      phrases << phrase
    end
    return phrases
  end

  def create_root_phrase
    self.ja_blocked_phrases.create(phrase: self.root, furigana: self.root.katakana?)
  end

  def format_root
    # ensure blocked root's, which are English or romaji are lowercase
    self.root.downcase! if self.root.match(/^[a-zA-Z]+$/)
  end

  def other_forms_should_not_exist
    other_forms = [self.root.hiragana, self.root.katakana, self.root.romaji.downcase, self.root.romaji.upcase.han_to_zen]

    if JaBlockedRoot.where(root: other_forms).exists?
      errors.add(:root, "already exists in another form (i.e., hiragana, katakana, romaji, zenkaku)")
    end

    if JaBlockedPhrase.where(phrase: other_forms).exists?
      errors.add(:root, "already exists as a phrase in another form (i.e., hiragana, katakana, romaji, zenkaku)")
    end
  end

end
