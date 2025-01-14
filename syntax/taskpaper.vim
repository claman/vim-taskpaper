" Vim syntax file
" Language:	Taskpaper (https://www.taskpaper.com)
" Maintainer:	Alex Claman
" URL:		https://github.com/claman/vim-taskpaper
" Last Change:  2023-03-11

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if version < 508
  command! -nargs=+ HiLink hi link <args>
else
  command! -nargs=+ HiLink hi def link <args>
endif

" Define tag styles
if !exists('g:task_paper_styles')
    let g:task_paper_styles = {'FAIL': 'guibg=Red guifg=White'}
endif

syn case ignore

syn match taskpaperComment   /^.*$/ contains=taskpaperContext
syn match taskpaperProject   /^.\+:\(\s\+@[^ \t(]\+\(([^)]*)\)\?\)*$/ contains=taskpaperContext
syn match taskpaperListItem  /^\t*-\s\+/
syn match taskpaperContext   /\s\zs@[^ \t(]\+\(([^)]*)\)\?/
syn match taskpaperToday     /@today/
syn match taskpaperUrgent    /@urgent/
syn match taskpaperDone      /^.*\s@done\(\(\s\|([^)]*)\).*\)\?$/ contains=taskpaperToday,taskpaperUrgent
syn match taskpaperCancelled /^.*\s@cancelled\(\(\s\|([^)]*)\).*\)\?$/ contains=taskpaperToday,taskpaperUrgent

syn sync fromstart

"highlighting for Taskpaper groups
HiLink taskpaperListItem      Identifier
HiLink taskpaperContext       String
HiLink taskpaperToday         Search
HiLink taskpaperUrgent        ErrorMsg
HiLink taskpaperProject       Title
HiLink taskpaperDone          Comment
HiLink taskpaperCancelled     Comment
HiLink taskpaperComment       Comment

call taskpaper#tag_style_dict(g:task_paper_styles)

let b:current_syntax = "taskpaper"

delcommand HiLink
" vim: ts=8
