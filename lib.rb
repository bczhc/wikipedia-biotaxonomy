class Taxon
  attr_accessor :rank_display, :display, :sci_name, :skip, :page_url

  def initialize(rank_display, display, sci_name, page_url)
    @rank_display = rank_display
    @display = display
    @sci_name = sci_name
    @skip = false
    @page_url = page_url
  end

  def self.skip
    taxon = Taxon.new(nil, nil, nil, nil)
    taxon.skip = true
    taxon
  end

  # @param other [Taxon]
  def ==(other)
    return false if other == nil
    @sci_name == other.sci_name
  end

  def to_s
    "#{@display}"
  end

  def format_chinese_name
    "#{@rank_display}：#{@display}"
  end
end