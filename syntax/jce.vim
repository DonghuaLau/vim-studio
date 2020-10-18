" Vim syntax file
" Language: jce
" Maintainer: tenfyzhong

if version < 600
    syntax clear
    finish
elseif exists("b:current_syntax") 
    finish
endif
let b:current_syntax="jce"

syntax case match

" c/c++ keyword
syntax keyword jceCpp03Keyword asm auto break case catch class const_cast continue 
syntax keyword JceCpp03Keyword default delete do dynamic_cast else explicit export 
syntax keyword JceCpp03Keyword extern for friend goto if inline mutable namespace 
syntax keyword JceCpp03Keyword new operator private protected public register 
syntax keyword JceCpp03Keyword reinterpret_cast return signed sizeof static 
syntax keyword JceCpp03Keyword static_cast switch template this throw try typedef 
syntax keyword JceCpp03Keyword typeid typename union using virtual void volatile wchar_t while
syntax keyword jceCpp11Keyword alignas constexpr char16_t char32_t decltype nullptr noexcept static_assert 
syntax keyword jceC99Keyword   restrict _Bool _Complex _Imaginary
syntax keyword jceC11Keyword   _Alignas _Alignof _Atomic _Static_assert _Noreturn _Thread_local _Generic

" java keyword
syntax keyword jceJavaKeyword abstract assert boolean break byte case catch char 
syntax keyword jceJavaKeyword class const continue default do double else enum 
syntax keyword jceJavaKeyword extends final finally float for goto if implements 
syntax keyword jceJavaKeyword import instanceof int interface long native new 
syntax keyword jceJavaKeyword package private protected public return strictfp 
syntax keyword jceJavaKeyword short static super switch synchronized this throw 
syntax keyword jceJavaKeyword throws transient try void volatile while

syntax keyword jceTodo         TODO todo Todo contained 
syntax keyword jceBug          BUG bug Bug ERROR error Error contained
syntax cluster jceState        contains=jceTodo,jceBug
syntax keyword jceStructure    module struct enum interface
syntax keyword jceType         void bool byte short int double float long string vector map 
syntax keyword jceBool         true false
syntax keyword jceOption       require optional
syntax keyword jceLabel        out
syntax keyword jceStatement    const key routekey
syntax keyword jceAbandonType  bool

"integer number, or floating point number without a dot and with "f".  syntax case ignore
syntax match	jceNumbers	display transparent "\<\d\|\.\d" contains=jceNumber,jceFloat,jceOctalError,jceOctal
" Same, but without octal error (for comments)
syntax match	jceNumbersCom	display contained transparent "\<\d\|\.\d" contains=jceNumber,jceFloat,jceOctal
syntax match	jceNumber		display contained "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
"hex number
syntax match	jceNumber		display contained "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"
" Flag the first zero of an octal number as something special
syntax match	jceOctal		display contained "0\o\+\(u\=l\{0,2}\|ll\=u\)\>" contains=jceOctalZero
syntax match	jceOctalZero	display contained "\<0"
syntax match	jceFloat		display contained "\d\+f"
"floating point number, with dot, optional exponent
syntax match	jceFloat		display contained "\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
"floating point number, starting with a dot, optional exponent
syntax match	jceFloat		display contained "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
"floating point number, without dot, with exponent
syntax match	jceFloat		display contained "\d\+e[-+]\=\d\+[fl]\=\>"

syntax region  jceBlock    start="{" end="}" transparent fold
" comment
syntax region jceCommentL	start="//" skip="\\$" end="$" keepend contains=@jceState
syntax region jceComment   start=/\/\*/ end=/\*\// contains=@jceState

syntax region	jceIncluded	display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syntax match	jceIncluded	display contained "<[^>]*>"
syntax match	jceInclude	display "^\s*\(%:\|#\)\s*include\>\s*["<]" contains=jceIncluded

syntax region  jceString   start=/"/ skip=/\\"/ end=/"/

syntax match jceError "unsigned"
syntax match jceType  "unsigned int"

highlight default link jceTodo         Todo
highlight default link jceBug          Error
highlight default link jceInclude      Include
highlight default link jceStructure    Structure
highlight default link jceOption       Repeat
highlight default link jceType         Type
highlight default link jceBool         Boolean
highlight default link jceLabel        Type
highlight default link jceStatement    Statement
highlight default link jceNumbers      Number
highlight default link jceNumbersCom   Number
highlight default link jceNumber       Number
highlight default link jceOctal        Number
highlight default link jceOctalZero    Error
highlight default link jceFloat        Float
highlight default link jceComment      Comment
highlight default link jceCommentL     Comment
highlight default link jceString       String
highlight link jceCpp03Keyword     Error
highlight link jceCpp11Keyword     Error
highlight link jceC99Keyword       Error
highlight link jceC11Keyword       Error
highlight link jceJavaKeyword      Error
highlight link jceAbandonType      Error
highlight link jceError        Error

syntax sync fromstart


" Highlight struct names
syn match    jceCustomScope	"{"
syn match    jceCustomStruct1	"\w\+\s*{" contains=cCustomScope
syn match    jceCustomStruct2	"\w\+\s*\n{" contains=cCustomScope
syn match    jceCustomStruct3	"\w\+\s*\n	{" contains=cCustomScope

hi def link jceCustomStruct1 Function 
hi def link jceCustomStruct2 Function 
hi def link jceCustomStruct3 Function 
