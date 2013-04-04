# encoding: UTF-8
require 'csv'
namespace :ja do
  task :load_all => [:import_phrases, :create_furigana_list] do
  end

  task :import_phrases => [:environment] do
    puts "Clearing Exisiting JaBlockedRoots and JaBlockedPhrases"
    JaBlockedRoot.destroy_all

    puts "Loading new JaBlockedRoots"
    csv_text = File.read('doc/japanese_blocked_phrases.csv')
    csv = CSV.parse(csv_text, :headers => false)
    @skipped_roots = []
    @furigana_needed = []

    csv.each do |row|
      blocked_root = JaBlockedRoot.new(:root => row.first)
      if blocked_root.save
        puts "Added blocked root and root phrase: #{row.first}"

        phrases = blocked_root.create_blocked_phrases(row.second)
        phrases.each { |phrase| puts "  Added blocked phrase #{phrase.phrase}" if phrase.valid? }

        if phrases.blank?
          @furigana_needed << blocked_root.root
          puts "  Root contains kanji or other characters. Please provide the furigana."
        end
      else
        puts "Skipping #{row.first}"
        blocked_root.errors.full_messages.each { |msg| puts "  #{msg}" }
        @skipped_roots << row.first
      end
    end

    puts "Loaded #{JaBlockedRoot.count} Japanese Blocked Roots"
    puts "Loaded #{JaBlockedPhrase.count} Japanese Blocked Phrases"
    puts "Furigana needed #{@furigana_needed.count}"
    puts "Skipped #{@skipped_roots.count}"
  end

  task :create_furigana_list => [:environment] do
    path = "tmp/"
    filename = 'furigana_needed_' + Time.now.to_s(:number) + '.csv'
    @furigana_list = path + filename

    CSV.open(@furigana_list, "wb") do |csv| 
      @furigana_needed.each do |phrase|
        csv << [phrase]
      end 
    end 
  end
end