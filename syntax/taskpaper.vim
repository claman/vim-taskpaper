" Vim syntax file
" Language:	Taskpaper (https://www.taskpaper.com)
" Maintainer:	Alex Claman
" URL:		https://github.com/claman/vim-taskpaper
" Last Change:  2023-02-22

if exists('b:current_syntax')
  finish
endif

" Define tag styles
if !exists('g:task_paper_styles')
    let g:task_paper_styles = {'FAIL': 'guibg=Red guifg=White'}
endif

syn case ignore

syn match TaskPaperNote         /^.*$/ contains=TaskPaperURL
syn match TaskPaperProject      /^.\+:\(\s\+@[^ \t(]\+\(([^)]*)\)\?\)*$/ contains=taskpaperContext
syn match TaskPaperListItem     /^\t*-\s\+/ contains=TaskPaperURL
syn match TaskPaperToday        /@due(today)/
syn match TaskPaperDone         /^.*\s@done\(\(\s\|([^)]*)\).*\)\?$/

syn sync fromstart

"highlighting for Taskpaper groups
hi def link TaskPaperProject         Keyword
hi def link TaskPaperListItem        Identifier
hi def link TaskPaperNote            Comment
hi def link TaskPaperToday           Todo
hi def link TaskPaperDone            Comment

call taskpaper#tag_style_dict(g:task_paper_styles)

let b:current_syntax = 'taskpaper'

delcommand HiLink
" vim: ts=4
