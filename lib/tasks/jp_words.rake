# encoding: UTF-8
require 'csv'
namespace :ja do
  task :load_all => [:import_phrases, :create_cleaned_root_list] do
  end

  task :import_phrases => [:environment] do
    puts "Clearing Exisiting JaBlockedRoots and JaBlockedPhrases"
    JaBlockedRoot.destroy_all

    puts "Loading new JaBlockedRoots"
    name    = 'japanese_blocked_phrases.csv'
    source  = 'doc/' + name
    cleaned = 'tmp/' + name
    file = File.exists?(cleaned) ? cleaned : source

    csv_text = File.read(file)
    csv = CSV.parse(csv_text, :headers => false)

    @roots = []
    @skipped_roots = []
    @furigana_needed = []
    @skipped_section = 0

    csv.each do |row|
      if row.first.include? '----------'
        @skipped_section += 1
        next
      end
      blocked_root = JaBlockedRoot.new(:root => row.first)
      if blocked_root.save
        puts "Added blocked root: #{row.first}"

        phrases = blocked_root.create_blocked_phrases(row.second)
        phrases.each do |phrase|
          puts "  Added blocked phrase #{phrase.phrase}" if phrase.valid?
          phrase.errors.full_messages.each { |msg| puts "  Skipping #{phrase.phrase} - #{msg}" } unless phrase.valid?
        end

        if phrases.blank?
          furigana_needed = (row.second.nil?) ? [blocked_root.root] : [blocked_root.root, row.second]
          @furigana_needed << furigana_needed
          puts "  Root contains kanji or other characters. Please provide the furigana."
        else
          root = (row.second.nil?) ? [blocked_root.root] : [blocked_root.root, row.second]
          @roots << root
        end
      else
        puts "Skipping #{row.first}"
        blocked_root.errors.full_messages.each { |msg| puts "  #{msg}" }
        skipped_root = (row.second.nil?) ? [row.first] : [row.first, row.second]
        @skipped_roots << skipped_root
      end
    end

    puts "---------- TOTALS ----------"
    puts "#{csv.count - @skipped_section} rows in CSV file"
    puts "Created #{JaBlockedRoot.count} Japanese Blocked Roots"
    puts "Created #{JaBlockedPhrase.count} Japanese Blocked Phrases"
    puts "Furigana needed #{@furigana_needed.count}"
    puts "Skipped #{@skipped_roots.count}"
  end

  task :create_cleaned_root_list => [:environment] do
    path = 'tmp/'
    name = 'japanese_blocked_phrases.csv'
    file = path + name

    CSV.open(file, "wb") do |csv|
      csv << ["----------- FURIGANA REQUIRED (#{@furigana_needed.count}) ----------"]
      @furigana_needed.each do |root|
        csv << root
      end

      csv << ["----------- SUCCESSFULLY CREATED ROOTS (#{@roots.count}) ----------"]
      @roots.each do |root|
        csv << root
      end

      csv << ["----------- SKIPPED (#{@skipped_roots.count}) ----------"]
      @skipped_roots.each do |root|
        csv << root
      end

    end 
  end

end