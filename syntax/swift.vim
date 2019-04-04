" Language:    Swift<https://developer.apple.com/swift/>
" URL:         http://github.com/toyamarinyon/vim-swift
" Altered to work properly

" Bail if our syntax is already loaded.
if exists('b:current_syntax') && b:current_syntax == 'swift'
  finish
endif

" {{{ Whitespace and Comments
syntax region swiftComment start=#\/\*# end=#\*\/#
"syntax match swiftComment /\/\/.*/
syntax region swiftComment start=#\/\/# end=#$#
highlight default link swiftComment Comment
" }}}

" {{{ Keywords
" Keywords used in declarations:
syntax keyword swiftDeclarationKeywords skipwhite nextgroup=swiftIdentifier,swiftDeclarationKeywords class deinit enum extension func import init internal let operator private protocol public fileprivate internal open static struct subscript typealias var
highlight default link swiftDeclarationKeywords Keyword
" Keywords used in statements:
syntax keyword swiftStatementKeywords break case continue default do else fallthrough if in for return switch where while guard repeat try catch
highlight default link swiftStatementKeywords Keyword
" Keywords used in expressions and types:
syntax keyword swiftExpressionTypeKeywords as dynamicType false is nil self Self super true #COLUMN #FILE #FUNCTION #LINE #selector
highlight default link swiftExpressionTypeKeywords Keyword
" Keywords reserved in particular contexts:
syntax keyword swiftReserveKeywords associativity convenience dynamic didSet final get infix inout lazy left mutating none nonmutating optional override postfix precedence prefix Protocol required right set Type unowned unowned(unsafe) unowned(sale) weak willSet defer @noescape @escape @autoclosure @objc highlight default link swiftReserveKeywords Keyword
highlight default link swiftReserveKeywords Keyword
" }}}

" {{{ Identifiers
syntax match swiftIdentifier /[[:alpha:]_][[:alnum:]_]*/ contained nextgroup=swiftTypeColumn skipwhite
highlight default link swiftIdentifier Identifier
" }}}

" {{{ Literals
" Integer literal
syntax match swiftIntegerLiteral /\<\d\+\%(_\d\+\)*\%(\.\d\+\%(_\d\+\)*\)\=\>/
syntax match swiftIntegerLiteral /\<\d\+\%(_\d\+\)*\%(\.\d\+\%(_\d\+\)*\)\=\%([eE][-+]\=\d\+\%(_\d\+\)*\)\>/
syntax match swiftIntegerLiteral /\<0x\x\+\%(_\x\+\)*\>/
syntax match swiftIntegerLiteral /\<0o\o\+\%(_\o\+\)*\>/
syntax match swiftIntegerLiteral /\<0b[01]\+\%(_[01]\+\)*\>/
highlight default link swiftIntegerLiteral Number
" String literal
syntax region swiftStringLiteral start=/"/ skip=/\\"/ end=/"/ contains=swiftStringInterpolation
highlight default link swiftStringLiteral String
" }}}

" {{{ String Interpolation
syntax region swiftStringInterpolation matchgroup=Tag start="\\(" end=")"  contained contains=swiftFunctionCall
syntax region swiftFunctionCall start=#[[:alnum:]]\+(# end=#)# contained
highlight default link swiftStringInterpolation NONE
highlight default link swiftFunctionCall NONE
" }}}

" {{{ Operators
syntax keyword swiftOperatorKeywords / = - + ! * % < > & \| ^ ~ .
highlight default link swiftOperatorKeywords Operator
" }}}

" {{{ Function Return Value 
syntax match swiftReturnArrow #-># skipwhite nextgroup=swiftUserType,SwiftType
" }}}

"syntax case match
"{{{ Type
syntax match   swiftTypeVariable /\<[[:alpha:]_][[:alnum:]_]*\s*:/me=e-1 nextgroup=swiftTypeColumn
syntax match   swiftTypeColumn #:# nextgroup=swiftPreType,swiftUserType,swiftType skipwhite contained
syntax keyword swiftPreType inout skipwhite nextgroup=swiftUserType,swiftType contained
syntax match   swiftUserType /\<[[:upper:]][[:alnum:]]\+/ contained
" Fundametal types in swift
syntax keyword swiftType String Bool Int Int8 Int16 Int32 Int64 UInt UInt8 UInt16 UInt32 UInt64 Float Float80 Double
highlight default link swiftTypeVariable special
highlight default link swiftTypeColumn Operator
highlight default link swiftPreType Special
highlight default link swiftUserType Underlined
highlight default link swiftType Type
" }}}

" {{{ Type Conversion Functions
"syntax keyword swiftTypeConversion String Int nextgroup=openBracket
"syntax keyword openBracket transparent contained ( 
"highlight default link swiftTypeConversion Function
" }}}

if !exists('b:current_syntax')
  let b:current_syntax = 'swift'
endif
