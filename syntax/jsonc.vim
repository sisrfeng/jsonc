" 没有base on  https://github.com/elzr/vim-json

if exists('b:current_syntax')
    if b:current_syntax == 'jsonc'
        " 强行把json变jsonc?
        finish
    en
en

" from json.vim
    hi def link jsonNoise			Noise
      syntax match   jsonNoise           /\v%(:|,)/


    syn region  jsonStringSQError oneline  start=+'+  skip=+\\\\\|\\"+  end=+'+
        " JSON does not allow strings with single quotes



" Escape sequences
hi def link jcEscape             Special
    syn match   jcEscape    "\\["\\/bfnrt]" contained
    syn match   jcEscape    "\\u\x\{4}" contained





" Strings
hi def link jcString        String
    syn region  jcString    start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=jcEscape
    syn region  jcString    start=+'+  skip=+\\\\\|\\'+  end=+'+  contains=jcEscape

" JSON Keywords
hi def link jcStr       Label
    syn match  jcStr /"\([^"]\|\\\"\)\+"[[:blank:]\r\n]*\:/ contains=jsonKeyword
    syn region jcStr      oneline matchgroup=jsonQuote start=/"/  skip=/\v\\\\|\\"/  end=/"/  concealends contains=jsonEscape contained
                                                                    " skip掉  \\或\"

                                 hi def link jsonQuote   Quote

    syn match   jsonEscape    "\\["\\/bfnrt]" contained
                            " \"  \/  \\  \b  \f  \n  \r  \t
    syn match   jsonEscape    "\\u\x\{4}" contained
                              " \uXXXX
    hi def link jsonEscape		Special


" Strings
" Separated into a match and region because a region by itself is always greedy
    syn match  jsonStringMatch /"\v([^"]|\\\")+"\ze[\r[:blank:]\n]*[,}\]]/ contains=jsonString
                                " "adsf\"asdfasdfasd "
                                                                    " ,
                                                                    " }
                                                                    " ]
                                "\v([^"]|\\\")+"[\r[:blank:]\n]*\:

" Numbers
    syn match   jcNumber    "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>"
    syn keyword jcNumber    Infinity -Infinity

" An 01.2 04.1等
    syn match   jcNumError  "\v-=<0\d\.\d*>"

" Boolean
    syn keyword jcBoolean   true false

" Null
    syn keyword jcNull      null

" Braces
    syn match   jcBraces	   "[{}\[\]]"
    syn match   jcObjAssign /@\?\%(\I\|\$\)\%(\i\|\$\)*\s*\ze::\@!/

" Comment
hi def link jcLineComment        Comment
    syn region  jcLineComment    start=+\/\/+ end=+$+ keepend
                                         " // 注释
    syn region  jcLineComment    start=+^\s*\/\/+ skip=+\n\s*\/\/+ end=+$+ keepend fold

hi def link jcComment            Comment
    syn region  jcComment        start="/\*"  end="\*/" fold
                                        " /* c风格注释  */

" Define the default highlighting.
    hi def link jcObjAssign          Identifier
    hi def link jcNumber             Number
    hi def link jcBraces             Operator
    hi def link jcNull               Function
    hi def link jcBoolean            Boolean
    hi def link jcNumError           Error

if !exists('b:current_syntax')
    let b:current_syntax = 'jsonc'
en

