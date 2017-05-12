module BibleBot
  class Reference
  
    attr_accessor :book
    attr_accessor :chapter_number
    attr_accessor :verse_number
    attr_accessor :end_chapter_number
    attr_accessor :end_verse_number
  
    def initialize( book: nil, chapter_number: nil, verse_number: nil, end_chapter_number: nil, end_verse_number: nil )
      self.book               = book
      self.chapter_number     = chapter_number
      self.verse_number       = verse_number
      self.end_chapter_number = end_chapter_number
      self.end_verse_number   = end_verse_number
      
      if end_chapter_number.nil?
        self.end_chapter_number = chapter_number
      end
      
      if end_verse_number.nil?
        self.end_verse_number = self.verse_number
      end
    end
    
    def formatted
      # if start and end chapters are the same
      if chapter_number == end_chapter_number || end_chapter_number.nil?
        if book.chapters.length == 1 # single chapter book
          # If start and end verses are the same
          if verse_number == end_verse_number
            return "#{book.name} #{verse_number}"
          else
            return "#{book.name} #{verse_number}-#{end_verse_number}"
          end
        else # multichapter book
          # If the start verse is one and the end verse is the last verse in the chapter
          if verse_number == 1 && end_verse_number == book.chapters[chapter_number-1]
            return "#{book.name} #{chapter_number}"
          # If start and end verses are the same
          elsif verse_number == end_verse_number || end_verse_number.nil?
            return "#{book.name} #{chapter_number}:#{verse_number}"
          else
            return "#{book.name} #{chapter_number}:#{verse_number}-#{end_verse_number}"
          end
        end
      else # start and end chapters are different
        return "#{book.name} #{chapter_number}:#{verse_number}-#{end_chapter_number}:#{end_verse_number}"
      end
    end
    
    def to_s
      "BibleBot::Reference — #{formatted}"
    end
  
   
  end
end