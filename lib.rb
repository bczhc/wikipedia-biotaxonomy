class Taxon
  attr_accessor :rank_display, :display, :sci_name, :skip, :page_url, :skipped_sci_names

  def initialize(rank_display, display, sci_name, page_url)
    @rank_display = rank_display
    @display = display
    @sci_name = sci_name
    @skip = false
    @page_url = page_url
    # if @sci_name != nil
    #   fail "Invalid #{@sci_name}" unless /^[A-Z][a-zA-Z]+$/.match? @sci_name
    # end
  end

  def self.skip
    taxon = Taxon.new(nil, nil, nil, nil)
    taxon.skip = true
    taxon
  end

  # @param other [Taxon]
  def ==(other)
    return false if other == nil
    cmp_token == other.cmp_token
  end

  def cmp_token
    if @skip
      return skipped_sci_names.join(' ')
    end
    @sci_name
  end

  def to_s
    "#{@display}"
  end

  def format_chinese_name
    "#{@rank_display}：#{@display}"
  end

  def format_wolfram_node_name
    if @skip
      return '...'
    end
    "[#{@rank_display}] #{@display}"
  end
end