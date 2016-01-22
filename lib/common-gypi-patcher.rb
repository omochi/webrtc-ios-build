require "pathname"
require_relative "patcher.rb"

class CommonGypiPatcher < Patcher
	attr_accessor :var_enable_bitcode
	attr_accessor :var_symbol_private_extern

	def initialize
		@var_enable_bitcode = "YES"
		@var_symbol_private_extern = "NO"
	end

	def patch_lines
		patch_enable_bitcode
		patch_symbol_private_extern
	end

	def patch_enable_bitcode
		regex = /'ENABLE_BITCODE': '([\w]*)'/
		for line in lines
			m = regex.match(line)
			if ! m
				next
			end
			line[m.begin(1)...m.end(1)] = var_enable_bitcode
		end
	end
	
	def patch_symbol_private_extern
		regex = /'GCC_SYMBOLS_PRIVATE_EXTERN': '([\w]*)'/
		for line in lines
			m = regex.match(line)
			if ! m
				next
			end
			line[m.begin(1)...m.end(1)] = var_symbol_private_extern
		end
	end
end
