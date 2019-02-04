require 'open-uri'
require 'Nokogiri'

class Adapter
  def get_play
    xml = open("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")
    Nokogiri::XML.parse(xml)
  end
end
