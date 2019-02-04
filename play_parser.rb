require 'pry'
require 'rb-readline'
require 'active_support/core_ext/hash/conversions'

class PlayParser
  attr_accessor :play, :line_count

  def initialize(doc)
    @play = Hash.from_xml(doc.to_s)
    @line_count = {}
  end

  def print_line_count
    parse_play
    @line_count.keys.each do |speaker|
      puts "#{speaker}: #{@line_count[speaker]}"
    end
  end

  private
  def parse_play
    act_array.each do |act|
      scene_array(act).each do |scene|
        parse_scene(scene)
      end
    end
  end

  def act_array
    @play["PLAY"]["ACT"]
  end

  def scene_array(act)
    act["SCENE"]
  end

  def parse_scene(scene)
    speech = scene["SPEECH"]
    count_lines(speech)
  end

  def count_lines(speech)
    speech.each do |line|
      speaker = line["SPEAKER"]

      if speaker.is_a?(Array)
        count_multiple_speakers(line)
      elsif @line_count[speaker]
        @line_count[speaker] += 1
      else
        @line_count[speaker] = 1
      end
    end
  end

  def count_multiple_speakers(line)
    line["SPEAKER"].each do |speaker|
      if @line_count[speaker]
        @line_count[speaker] += 1
      else
        @line_count[speaker] = 1
      end
    end
  end
end
