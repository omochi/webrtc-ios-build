require "pathname"
require_relative "patcher.rb"

class RegexPatcher < Patcher
	attr_accessor :regex
	attr_accessor :replace_func # (MatchData) -> String
	def patch_lines
		for i in 0...lines.length
			line = lines[i]

			m = regex.match(line)
			if m
				rep = replace_func.call(m)
				line[m.begin(0)...m.end(0)] = rep
				lines[i] = line
			end
		end
	end
end