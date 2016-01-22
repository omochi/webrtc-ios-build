require "pathname"
require_relative "patcher.rb"

class RtcBaseObjcPatcher < Patcher
	def patch_lines
		markers = [
			"'objc/RTCLogging.h'",
			"'objc/RTCLogging.mm'"
		]

		for i in 0...lines.length
			line = lines[i]

			for marker in markers
				if line.include?(marker)
					if line[0] != "#"
						line[0, 0] = "#"
					end
				end
			end

		end
	end
end