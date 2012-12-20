" itermcol.vim
" generate iTerm colorscheme using vim colorscheme
" author @akiomik

" return current colorscheme name
" NOTE: this function is using :redir
function! s:get_colorscheme_name()
	redir => l:coloname
		silent colo	
	redir END

	" remove \n at index 0
	return l:coloname[1 : ]
endfunction


" return xml format text
function! s:generate_color_xml(color)
	let l:red = a:color.red
	let l:blue = a:color.blue
	let l:green = a:color.green

	" build xml
	let l:xml = ""
	let l:xml = l:xml . "\t<dict>\n"
	let l:xml = l:xml . "\t\t<key>Blue Component</key>\n"
	let l:xml = l:xml . "\t\t<real>" . printf("%f", l:blue) . "</real>\n"
	let l:xml = l:xml . "\t\t<key>Green Component</key>\n"
	let l:xml = l:xml . "\t\t<real>" . printf("%f", l:green) . "</real>\n"
	let l:xml = l:xml . "\t\t<key>Red Component</key>\n"
	let l:xml = l:xml . "\t\t<real>" . printf("%f", l:red) . "</real>\n"
	let l:xml = l:xml . "\t</dict>\n"

	return l:xml
endfunction


" return parsed color of hex format
function! s:parse_hex_color(hexcolor)
	" if color is not found then return -1
	if a:hexcolor == "-1"
		return {'red': -1, 'green': -1, 'blue': -1}
	endif

	" exchange colorcode (hex to float)
	let l:red   = str2nr(a:hexcolor[0 : 1], 16) / 255.0
	let l:green = str2nr(a:hexcolor[2 : 3], 16) / 255.0
	let l:blue  = str2nr(a:hexcolor[4 : 5], 16) / 255.0

	return {'red': l:red, 'green': l:green, 'blue': l:blue}
endfunction


" return parsed color of :hi
function! s:parse_hilight(hilight, type)
	let l:target = a:type . '=#'
	let l:index = stridx(a:hilight, l:target)
	if l:index == -1
		return '-1'
	endif

	let l:begin = l:index + strlen(l:target)
	let l:end   = l:index + strlen(l:target) + 5
	let l:color = a:hilight[l:begin : l:end]
	return l:color
endfunction


" return :hi colors
" NOTE: this function is using :redir
function! s:get_hilight_colors(group)
	redir => l:hi
		silent execute "hi " . a:group
	redir END

	let l:colors = {}
	let l:colors["guifg"] = s:parse_hex_color(s:parse_hilight(l:hi, "guifg"))
	let l:colors["guibg"] = s:parse_hex_color(s:parse_hilight(l:hi, "guibg"))
	return l:colors
endfunction


" return .itermcolors xml format text
" TODO: reduce dupulicate colors
function! s:generate_iterm_colors_xml(iterm_colors)
	let l:xml = ""
	let l:xml = l:xml . '<?xml version="1.0" encoding="UTF-8"?>' . "\n"
	let l:xml = l:xml . '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' . "\n"
	let l:xml = l:xml . '<plist version="1.0">' . "\n"
	let l:xml = l:xml . "<dict>\n"

	let l:xml = l:xml . "\t<key>Ansi 0 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.black)
	let l:xml = l:xml . "\t<key>Ansi 1 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.red)
	let l:xml = l:xml . "\t<key>Ansi 2 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.green)
	let l:xml = l:xml . "\t<key>Ansi 3 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.yellow)
	let l:xml = l:xml . "\t<key>Ansi 4 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.blue)
	let l:xml = l:xml . "\t<key>Ansi 5 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.magenta)
	let l:xml = l:xml . "\t<key>Ansi 6 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.cyan)
	let l:xml = l:xml . "\t<key>Ansi 7 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.white)
	let l:xml = l:xml . "\t<key>Ansi 8 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.brblack)
	let l:xml = l:xml . "\t<key>Ansi 9 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.brred)
	let l:xml = l:xml . "\t<key>Ansi 10 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.brgreen)
	let l:xml = l:xml . "\t<key>Ansi 11 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.bryellow)
	let l:xml = l:xml . "\t<key>Ansi 12 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.brblue)
	let l:xml = l:xml . "\t<key>Ansi 13 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.brmagenta)
	let l:xml = l:xml . "\t<key>Ansi 14 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.brcyan)
	let l:xml = l:xml . "\t<key>Ansi 15 Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.brwhite)

	let l:xml = l:xml . "\t<key>Foreground Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.fg)
	let l:xml = l:xml . "\t<key>Background Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.bg)
	let l:xml = l:xml . "\t<key>Bold Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.bold)
	let l:xml = l:xml . "\t<key>Cursor Text Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.curfg)
	let l:xml = l:xml . "\t<key>Cursor Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.curbg)
	let l:xml = l:xml . "\t<key>Selected Text Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.selfg)
	let l:xml = l:xml . "\t<key>Selection Color</key>\n"
	let l:xml = l:xml . s:generate_color_xml(a:iterm_colors.selbg)

	let l:xml = l:xml . "</dict>\n"
	let l:xml = l:xml . "</plist>\n"

	return l:xml
endfunction


" return colorscheme object
function! s:build_colorscheme()
	let l:scheme = {}
	let l:scheme["normal"]         = s:get_hilight_colors("Normal")
	let l:scheme["comment"]        = s:get_hilight_colors("Comment")
	let l:scheme["constant"]       = s:get_hilight_colors("Constant")
	let l:scheme["special"]        = s:get_hilight_colors("Special")
	let l:scheme["identifier"]     = s:get_hilight_colors("Identifier")
	let l:scheme["statement"]      = s:get_hilight_colors("Statement")
	let l:scheme["preproc"]        = s:get_hilight_colors("PreProc")
	let l:scheme["include"]        = s:get_hilight_colors("Include")
	let l:scheme["type"]           = s:get_hilight_colors("Type")
	let l:scheme["ignore"]         = s:get_hilight_colors("ignore")
	let l:scheme["error"]          = s:get_hilight_colors("Error")
	let l:scheme["todo"]           = s:get_hilight_colors("Todo")
	let l:scheme["string"]         = s:get_hilight_colors("String")
	let l:scheme["character"]      = s:get_hilight_colors("Character")
	let l:scheme["number"]         = s:get_hilight_colors("Number")
	let l:scheme["boolean"]        = s:get_hilight_colors("Boolean")
	let l:scheme["float"]          = s:get_hilight_colors("Float")
	let l:scheme["function"]       = s:get_hilight_colors("Function")
	let l:scheme["conditional"]    = s:get_hilight_colors("Conditional")
	let l:scheme["repeat"]	       = s:get_hilight_colors("Repeat")
	let l:scheme["label"]          = s:get_hilight_colors("Label")
	let l:scheme["operator"]       = s:get_hilight_colors("Operator")
	let l:scheme["keyword"]        = s:get_hilight_colors("Keyword")
	let l:scheme["exception"]      = s:get_hilight_colors("Exception")
	let l:scheme["define"]         = s:get_hilight_colors("Define")
	let l:scheme["macro"]          = s:get_hilight_colors("Macro")
	let l:scheme["precondit"]      = s:get_hilight_colors("PreCondit")
	let l:scheme["storageclass"]   = s:get_hilight_colors("StorageClass")
	let l:scheme["structure"]      = s:get_hilight_colors("structure")
	let l:scheme["typedef"]        = s:get_hilight_colors("typedef")
	let l:scheme["tag"]            = s:get_hilight_colors("tag")
	let l:scheme["specialchar"]    = s:get_hilight_colors("SpecialChar")
	let l:scheme["delimiter"]      = s:get_hilight_colors("Delimiter")
	let l:scheme["specialcomment"] = s:get_hilight_colors("SpecialComment")
	let l:scheme["debug"]          = s:get_hilight_colors("Debug")
	let l:scheme["cursor"]         = s:get_hilight_colors("Cursor")
	let l:scheme["visual"]         = s:get_hilight_colors("Visual")

	return l:scheme
endfunction


" return ansi colors dictionary
function! s:build_ansi_colors()
	" these are Terminal.app ansi colors
	let l:ansi_colors = {}
	let l:ansi_colors.black   = {'red': 0.0, 		'green': 0.0, 		 'blue': 0.0}
	let l:ansi_colors.red     = {'red': 0.76078431, 'green': 0.21176471, 'blue': 0.12941176}
	let l:ansi_colors.green   = {'red': 0.14509804, 'green': 0.7372549,  'blue': 0.14117647}
	let l:ansi_colors.yellow  = {'red': 0.67843137, 'green': 0.67843137, 'blue': 0.15294118}
	let l:ansi_colors.blue 	  = {'red': 0.28627451, 'green': 0.18039216, 'blue': 0.88235294}
	let l:ansi_colors.magenta = {'red': 0.82745098, 'green': 0.21960784, 'blue': 0.82745098}
	let l:ansi_colors.cyan	  = {'red': 0.2, 		'green': 0.73333333, 'blue': 0.78431373}
	let l:ansi_colors.white   = {'red': 0.79607843, 'green': 0.8, 'blue': 0.80392157}
	let l:ansi_colors.brblack 	= {'red': 0.50588235, 'green': 0.51372549, 'blue': 0.51372549}
	let l:ansi_colors.brred 	= {'red': 0.98823529, 'green': 0.22352941, 'blue': 0.12156863}
	let l:ansi_colors.brgreen 	= {'red': 0.19215686, 'green': 0.90588235, 'blue': 0.13333333}
	let l:ansi_colors.bryellow  = {'red': 0.91764706, 'green': 0.9254902,  'blue': 0.1372549 }
	let l:ansi_colors.brblue 	= {'red': 0.34509804, 'green': 0.2,		   'blue': 1.0       }
	let l:ansi_colors.brmagenta = {'red': 0.97647059, 'green': 0.20784314, 'blue': 0.97254902}
	let l:ansi_colors.brcyan	= {'red': 0.07843137, 'green': 0.94117647, 'blue': 0.94117647}
	let l:ansi_colors.brwhite 	= {'red': 0.91372549, 'green': 0.92156863, 'blue': 0.92156863}

	return l:ansi_colors	
endfunction


" return matched color group
function! s:get_nearest_group(colorscheme, color)
	let l:nearest_group = ''
	let l:min = 3
	for l:group in keys(a:colorscheme)
		let l:red  = abs(a:color.red - a:colorscheme[l:group].guifg.red)
		let l:green = abs(a:color.green - a:colorscheme[l:group].guifg.green)
		let l:blue = abs(a:color.blue - a:colorscheme[l:group].guifg.blue)

		if (min > l:red + l:green + l:blue)
			let l:min = l:red + l:green + l:blue
			let l:nearest_group = l:group
		endif
	endfor

	return l:nearest_group
endfunction


" return iterm colors dictionary
function! s:build_iterm_colors(colorscheme, ansi_colors)
	let l:iterm_colors = {}

	" normal colors setting
	let l:normal = a:colorscheme.normal
	let l:cursor = a:colorscheme.cursor
	let l:visual = a:colorscheme.visual
	let l:iterm_colors["bg"] = {'red': l:normal.guibg.red, 'green': l:normal.guibg.green, 'blue': l:normal.guibg.blue}
	let l:iterm_colors["fg"] = {'red': l:normal.guifg.red, 'green': l:normal.guifg.green, 'blue': l:normal.guifg.blue}
	let l:iterm_colors["bold"] = {'red': l:normal.guifg.red, 'green': l:normal.guifg.green, 'blue': l:normal.guifg.blue}
	let l:iterm_colors["curfg"] = {'red': l:cursor.guifg.red, 'green': l:cursor.guifg.green, 'blue': l:cursor.guifg.blue}
	let l:iterm_colors["curbg"] = {'red': l:cursor.guibg.red, 'green': l:cursor.guibg.green, 'blue': l:cursor.guibg.blue}
	let l:iterm_colors["selfg"] = {'red': l:normal.guifg.red, 'green': l:normal.guifg.green, 'blue': l:normal.guifg.blue}
	let l:iterm_colors["selbg"] = {'red': l:visual.guibg.red, 'green': l:visual.guibg.green, 'blue': l:visual.guibg.blue}

	" ansi colors setting
	for l:color in keys(a:ansi_colors)
		let l:group = s:get_nearest_group(a:colorscheme, a:ansi_colors[l:color])
		if empty(l:group)
			throw "Error!! Color was not found."
		endif

		let l:fg = a:colorscheme[l:group].guifg
		let l:iterm_colors[l:color] = {'red': l:fg.red, 'green': l:fg.green, 'blue': l:fg.blue}
	endfor

	return l:iterm_colors
endfunction


" check iterm colors format
function! s:check_iterm_colors(iterm_colors)
	for l:group in keys(a:iterm_colors)
		for l:color in keys(a:iterm_colors[l:group])
			if a:iterm_colors[l:group][l:color] < 0
				throw "Error!! Invalid format was detected."
			endif
		endfor
	endfor
endfunction


" generate  xml
" NOTE: this function is using :redir
function! itermcolors#itermcolors()
	let s:colorscheme = s:build_colorscheme()
	let s:ansi_colors = s:build_ansi_colors()
	let s:iterm_colors = s:build_iterm_colors(s:colorscheme, s:ansi_colors)
	let s:xml = s:generate_iterm_colors_xml(s:iterm_colors)

	" output to file
	let s:schemename  = s:get_colorscheme_name()
	let s:filename = s:schemename . ".itermcolors"
	exe "redir! > " . s:filename
		silent echon s:xml
	redir END
	echo "Output '" . s:filename . "' was completed."
endfunction
