require "pathname"
require_relative "patcher.rb"

class XcodeBitcodePatcher < Patcher
	def patch_lines
		marker1 = "self._AppendPlatformVersionMinFlags(cflags)"
		marker2 = "if self._Test('ENABLE_BITCODE', 'YES', default='YES'):"

		patch = (<<EOS
    #{marker2}
      cflags.append('-fembed-bitcode')

EOS
			).lines

		index = nil
		for i in 0...lines.length
			line = lines[i]
			if line.include?(marker1)
				index = i
				break
			end
		end

		if index == nil
			raise "patch marker not found"
		end
		if lines.length <= index + 2
			raise "unexpected target source"
		end
		if lines[index + 2].include?(marker2)
			return
		end
		lines.insert(index + 2, *patch)
	end
end
