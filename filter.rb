#!/usr/bin/env ruby
# encoding: utf-8

puts($<.each_line.map do |l|
  l.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')

  if (match = l.match(/ijsdataminer\d+ ([#&][^\x07\x2C\s]{,200}) (\d+)\): (.*)/))
    "%s\t%s\t%s" % [match[1], match[2], match[3]]
  end
end.compact.to_a)
