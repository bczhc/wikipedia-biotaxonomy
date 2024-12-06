require 'nokogiri'
require 'net/http'

# makes Wikipedia display Simplified Han variance
WIKI_REPLACEMENT = 'zh-cn'
REQUEST_INTERVAL = 1

$request_cache = {}

# @param page_url [String]
# @return [Array<Taxon>]
def fetch_page_lineage(page_url)
  if page_url.include? 'zh.wikipedia'
    page_url.gsub!('/wiki/', "/#{WIKI_REPLACEMENT}/")
  end
  puts "Fetching #{page_url}..."

  lineage = []

  body = $request_cache[page_url]
  if body == nil
    body = Net::HTTP.get(URI(page_url))
    sleep REQUEST_INTERVAL
    $request_cache[page_url] = body
  end

  # @type [Nokogiri::HTML::Document]
  doc = Nokogiri::HTML(body)
  doc.xpath(%{//table[contains(@class, 'biota')][1]//tr[not(th)]}).each do |x|
    td_children = x.xpath('./*')
    if td_children.length == 2
      # a 'skip' row
      taxon = Taxon.skip
    else
      rank = td_children[0].xpath('.//text()')[0].to_s.chomp
      rank = rank.to_s.gsub(/^(.*)((: ?)|：)$/, '\1')
      fail if rank.empty?

      name_text = td_children[1].xpath('.//text()').to_s.chomp
      if name_text.include?(' ')
        split = name_text.split(/\s+/)
        sci_name = split.last
        name = split.first
      else
        name = name_text
        sci_name = name_text
      end
      sci_name = sci_name.gsub(/[^[:ascii:]]/, '')

      page_url = td_children[3].xpath('.//a[1]/@href').to_s
      taxon = Taxon.new(rank, name, sci_name, page_url)
    end

    lineage.push taxon
  end
  lineage
end

def fetch_full_lineage(page_url)
  lineage = fetch_page_lineage page_url
  while true
    skip_index = lineage.rindex { |x| x.skip }
    return lineage if skip_index == nil
    # can't be the last one
    fail if skip_index == lineage.length - 1
    # expand the `/skip` one
    expansion_url = lineage[skip_index + 1].page_url
    fail unless expansion_url.end_with?('/skip')
    expansion_url.gsub!(/^(.*)\/skip$/, '\1')
    url = "#{URI(page_url).origin}#{expansion_url}"
    new_lineage = fetch_page_lineage url
    # replace all taxon before the skipped one with the new lineage
    lineage[..(skip_index + 1)] = new_lineage
    # and repeat... till there's no `/skip` ones
  end
end