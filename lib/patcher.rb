require "pathname"

class Patcher
	attr_reader :path
	attr_reader :lines
	def patch(a_path)
		@path = a_path

		if ! path.exist?
			raise "patch target file not exists: #{path.to_s}"
		end

		@lines = path.readlines

		patch_lines

		output = lines.join("")
		path.binwrite(output)

		puts "patched: #{path.to_s}"
	end
	def patch_lines
	end
end