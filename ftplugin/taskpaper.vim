" plugin to handle the TaskPaper to-do list format
" Language:	Taskpaper (http://hogbaysoftware.com/projects/taskpaper)
" Maintainer:	David O'Callaghan <david.ocallaghan@cs.tcd.ie>
" URL:		https://github.com/davidoc/taskpaper.vim
" Last Change:  2012-02-20

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

" Define a default date format
if !exists('g:task_paper_date_format')
    let g:task_paper_date_format = '%Y-%m-%d'
endif

" Define a default archive project name
if !exists('g:task_paper_archive_project')
    let g:task_paper_archive_project = 'Archive'
endif

" When moving a task, should the cursor follow or stay in the same place
" (default: follow)
if !exists('g:task_paper_follow_move')
    let g:task_paper_follow_move = 1 
endif

" Hide @done tasks when searching tags
if !exists('g:task_paper_search_hide_done')
    let g:task_paper_search_hide_done = 0 
endif

" Add '@' to keyword character set so that we can complete contexts as keywords
setlocal iskeyword+=@-@

" Tab character has special meaning on TaskPaper
setlocal noexpandtab

" Change 'comments' and 'formatoptions' to continue to write a task item
setlocal comments=b:-
setlocal formatoptions-=c formatoptions+=rol

" Set 'autoindent' to maintain indent level
setlocal autoindent

" Set up mappings
    nnoremap <silent> <buffer> <Plug>TaskPaperFoldNotes :<C-u>call taskpaper#search('\v^(\s*\|\t+-\s+.*\|.+:)$')<CR>
    nnoremap <silent> <buffer> <Plug>TaskPaperFoldProjects :<C-u>call taskpaper#fold_projects()<CR>
    nnoremap <silent> <buffer> <Plug>TaskPaperFocusProject :<C-u>call taskpaper#focus_project()<CR>

    nnoremap <silent> <buffer> <Plug>TaskPaperMoveToProject :call taskpaper#move_to_project()<CR>

    nnoremap <silent> <buffer> <Plug>TaskPaperSearchKeyword :<C-u>call taskpaper#search()<CR>
    nnoremap <silent> <buffer> <Plug>TaskPaperSearchTag :<C-u>call taskpaper#search_tag()<CR>

    nnoremap <silent> <buffer> <Plug>TaskPaperGoToProject :<C-u>call taskpaper#go_to_project()<CR>
    nnoremap <silent> <buffer> <Plug>TaskPaperNextProject :<C-u>call taskpaper#next_project()<CR>
    nnoremap <silent> <buffer> <Plug>TaskPaperPreviousProject :<C-u>call taskpaper#previous_project()<CR>

    nnoremap <silent> <buffer> <Plug>TaskPaperArchiveDone :<C-u>call taskpaper#archive_done()<CR>
    nnoremap <silent> <buffer> <Plug>TaskPaperShowToday :<C-u>call taskpaper#search_today()<CR>
    nnoremap <silent> <buffer> <Plug>TaskPaperShowCancelled :<C-u>call taskpaper#search_tag('cancelled')<CR>
    nnoremap <silent> <buffer> <Plug>TaskPaperToggleCancelled :call taskpaper#toggle_tag('cancelled', taskpaper#date())<CR>:silent! call repeat#set("\<Plug>TaskPaperToggleCancelled", v:count)<CR>
    nnoremap <silent> <buffer> <Plug>TaskPaperToggleDone :call taskpaper#toggle_tag('done', taskpaper#date())<CR>:silent! call repeat#set("\<Plug>TaskPaperToggleDone", v:count)<CR>
    nnoremap <silent> <buffer> <Plug>TaskPaperToggleToday :call taskpaper#toggle_tag('due', 'today')<CR>:silent! call repeat#set("\<Plug>TaskPaperToggleToday", v:count)<CR>

    nnoremap <silent> <buffer> <Plug>TaskPaperNewline o<C-r>=taskpaper#newline()<CR>
    inoremap <silent> <buffer> <Plug>TaskPaperNewline <CR><C-r>=taskpaper#newline()<CR>

if !exists('no_plugin_maps') && !exists('no_taskpaper_maps')
    nmap <buffer> <Leader>t. <Plug>TaskPaperFoldNotes

    nmap <buffer> <Leader>tp <Plug>TaskPaperFoldProjects
    nmap <buffer> <Leader>tP <Plug>TaskPaperFocusProject
    nmap <buffer> <Leader>tm <Plug>TaskPaperMoveToProject

    nmap <buffer> <Leader>t/ <Plug>TaskPaperSearchKeyword
    nmap <buffer> <Leader>ts <Plug>TaskPaperSearchTag

    nmap <buffer> <Leader>tg <Plug>TaskPaperGoToProject
    nmap <buffer> <Leader>tj <Plug>TaskPaperNextProject
    nmap <buffer> <Leader>tk <Plug>TaskPaperPreviousProject

    nmap <buffer> <Leader>td <Plug>TaskPaperToggleDone
    nmap <buffer> <Leader>tD <Plug>TaskPaperArchiveDone

    nmap <buffer> <Leader>tt <Plug>TaskPaperToggleToday
    nmap <buffer> <Leader>tT <Plug>TaskPaperShowToday

    nmap <buffer> <Leader>tx <Plug>TaskPaperToggleCancelled
    nmap <buffer> <Leader>tX <Plug>TaskPaperShowCancelled

    vnoremap <buffer> <Leader>td :norm <Leader>td<CR>
    vnoremap <buffer> <Leader>tt :norm <Leader>tt<CR>
    vnoremap <buffer> <Leader>tx :norm <Leader>tx<CR>

    if mapcheck('o', 'n') ==? ''
        nmap <buffer> o <Plug>TaskPaperNewline
    endif
    if mapcheck("\<CR>", 'i') ==? ''
        imap <buffer> <CR> <Plug>TaskPaperNewline
    endif
endif

let &cpoptions = s:save_cpo
