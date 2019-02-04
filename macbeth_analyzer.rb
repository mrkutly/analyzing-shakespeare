require 'net/http'
require './adapter.rb'
require './play_parser.rb'

doc = Adapter.new.get_play
parsed = PlayParser.new(doc)
parsed.print_line_count
