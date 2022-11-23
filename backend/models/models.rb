# models/models.rb

require 'date'
require 'kramdown'

class Book

  #
  # class methods
  #

  class << self
    def shelf(shelfdir)
      @@shelf = shelfdir + (if shelfdir =~ /\/$/ then '' else '/' end)
      scan
    end

    def scan
      @@books = Hash.new
      Dir.glob(@@shelf + '*.md') do |b|
        code = File.basename(b, '.md')
        @@books[code] = Book.new(code, b)
      end
    end

    def all
      books = Array.new
      @@books.each do |k, b|
        books << b
      end
      books
    end

    def find(title)
      books = Array.new
      @@books.each do |k, v|
        books << v if v.title =~ /#{title}/
      end
      books
    end

    def get(code)
      @@books[code]
    end

    def scene(code, p)
      @@books[code].scene(p)
    end

  end

  #
  # instance methods
  #

  def initialize(code, file)
    @code = code
    @file = file
    @scenes = nil
    #cfile ="#{File.dirname(file)}/#{code}_cover.jpg"
    #@cover = if File.exist?(cfile) then "#{code}_cover.jpg" else nil end
    @lead = ''
    File.foreach(file) do |l|
      break if l =~ /^\d+\./  # シーンの記述が見つかったら抜ける
      l.chomp!
      @title  = $1.strip if l =~ /^# (.+)$/
      @author = $1.strip if l =~ /^author:(.+)$/
      @date   = Date.parse($1.strip) if l =~ /^date:(.+)$/
      @lead  += $1.strip if l =~ /^> (.+)$/
    end
  end

  attr_reader :code, :title, :author, :date, :lead

  def scene(p)
    read_scenes if @scenes == nil
    @scenes[p]
  end

  private

  def read_scenes
    @scenes = Array.new
    sno = 0
    stitle = ""
    sbody = ""
    image = false
    File.foreach(@file) do |l|
      if l =~ /^(\d+)\.(.+)$/
        @scenes[sno] = Scene.new(@code, sno, stitle, sbody, image) if sno != 0
        sno = $1.to_i
        stitle = $2.strip
        sbody = ""
        image = File.exist?(@@shelf + "#{@code}_#{sno}.jpg")
      else
        sbody += l
      end
    end
    @scenes[sno] = Scene.new(@code, sno, stitle, sbody, image) if sno != 0
  end
end

class Scene
  def initialize(code, no, title, body, image)
    @code = code
    @sceneno = no
    @title = title
    lsep = false
    @body = ""
    @choices = Array.new
    @image = image
    @errors = Array.new
    body.lines.each do |l|
      l.chomp!
      if lsep == false
        if l =~ /^---\s*$/
          lsep = true
          next
        end
        @body += l + "\n"
      else
        next if l !~ /^\* \[(.+)\]\((.+)\)\s*$/
        nextno = $2.to_i
        @errors << "link no is invalid: #{l}" if nextno < 1
        @choices << Choice.new(nextno, $1)
      end
    end

  end

  attr_reader :sceneno, :title, :body, :choices, :image, :errors

  def body_html
    Kramdown::Document.new(@body).to_html
  end

end

class Choice
  def initialize(no, text)
    @sceneno = no
    @text = text
  end

  attr_reader :sceneno, :text

end

class Image
  class << self
    def set_dir(dirname)
      @@dirname = dirname + (if dirname =~ /\/$/ then '' else '/' end)
    end

    def exist?(code, no = nil)
      File.exist?(filename(code, no))
    end

    def file(code, no = nil)
      body = File.binread(filename(code, no))
    end

    private

    def filename(code, no)
      @@dirname + "#{code}_#{if no == nil then 'cover' else no end}.jpg"
    end
  end
end

