#!/usr/bin/env ruby

require "pathname"

class App
	attr_reader :gyp_dir
	attr_reader :target_path
	def usage
		puts "#{$0} <gyp_dir>"
	end
	def main
		if ARGV.length <= 0
			usage
			return
		end
		@gyp_dir = Pathname(ARGV[0]).expand_path
		
		@target_path = gyp_dir + "pylib/gyp/xcode_emulation.py"
		if ! target_path.exist?
			raise "target file not exists: #{target_path.to_s}"
		end

		marker1 = "self._AppendPlatformVersionMinFlags(cflags)"
		marker2 = "if self._Test('ENABLE_BITCODE', 'YES', default='YES'):"

		patch = (<<EOS
    #{marker2}
      cflags.append('-fembed-bitcode')

EOS
			).lines

		lines = target_path.readlines
		index = nil
		for i in 0...lines.length
			line = lines[i]
			if line.include?(marker1)
				index = i
				break
			end
		end
		if index == nil
			raise "patch position not found"
		end
		if lines.length <= index + 2
			raise "target text is invalid"
		end
		if lines[index + 2].include?(marker2)
			# already patched
			return
		end
		lines.insert(index + 2, *patch)
		
		output = lines.join("")
		target_path.binwrite(output)

		puts "patch finished: #{target_path.to_s}"
	end
end

app = App.new
app.main()