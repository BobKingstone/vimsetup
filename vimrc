"BEGIN_COMMON
execute pathogen#infect()

syntax on
filetype indent on
filetype plugin on
set guifont  =Inconsolata:h15
set linespace=5
"let mapleader = ','

"set background=dark
"colorscheme ir_black 

set hlsearch
set number
set tabstop=4

"softabstop is the number of spaces a tab counts for when editing. So this value is the number of spaces that is inserted when you hit <TAB> and also the number of spaces that are removed when you backspace
set softtabstop=4

"tabs are spaces
set expandtab

set showcmd
set cursorline
set laststatus=2
set modeline
set ignorecase
set smartcase
set showmatch
set smartindent
set fileencodings=utf-8

" Close buffer without messing up NerdTree
nnoremap <leader>q :bp<cr>:bd #<cr>

" Previous buffer
nnoremap <leader>h :bp<cr>

" Next buffer
nnoremap <leader>l :bn<cr>

" Clear the highlight of search
nnoremap <leader>n :nohlsearch<CR>

noremap _ VXkP
noremap - VXp 
inoremap <c-d> <Esc>ddi
inoremap jj <Esc>

"Delete line until end
nnoremap <c-l> v$hd
"Delete line from beginning
nnoremap <c-h> v$0d

"Have Vim jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
"END_COMMON
colorscheme seti
"BEGIN_OMNISHARP_ROSLYN

" If you are using the omnisharp-roslyn backend, use the following
"
let g:syntastic_cs_checkers = ['code_checker']
"END_OMNISHARP_ROSLYN

"BEGIN_OMNISHARP

"This is the default value, setting it isn't actually necessary
let g:OmniSharp_host = "http://localhost:2000"

"Set the type lookup function to use the preview window instead of the status line
"let g:OmniSharp_typeLookupInPreview = 1

"Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 1

"Showmatch significantly slows down omnicomplete
"when the first match contains parentheses.
set noshowmatch
"let g:OmniSharp_server_type = 'roslyn'
"Super tab settings - uncomment the next 4 lines
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
"let g:SuperTabClosePreviewOnPopupClose = 1

"don't autoselect first item in omnicomplete, show if only one item (for preview)
"remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview
" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono)
" By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
" you need it with the :OmniSharpDocumentation command.
" let g:omnicomplete_fetch_documentation=1

"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
"You might also want to look at the echodoc plugin
set splitbelow

augroup omnisharp_commands
        autocmd!

        "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
        autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

        " Synchronous build (blocks Vim)
        "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
        " Builds can also run asynchronously with vim-dispatch installed
        autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
        "
        " automatic syntax check on events (TextChanged requires Vim 7.4)
        " autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

        " Automatically add new cs files to the nearest project on save
        autocmd BufWritePost *.cs call OmniSharp#AddToProject()

        "show type information automatically when the cursor stops moving
        autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

        "The following commands are contextual, based on the current cursor position.

        autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
        autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
        autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
        autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
        autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
        "finds members in the current buffer
        autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
        " cursor can be anywhere on the line containing an issue
        autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
        autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
        autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
        autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
        "navigate up by method/property/field
        autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
        "navigate down by method/property/field
        autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END


" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
" vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
" nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden
nnoremap <leader>rt :OmniSharpRunTests<cr>
nnoremap <leader>rf :OmniSharpRunTestFixture<cr>
nnoremap <leader>ra :OmniSharpRunAllTests<cr>
nnoremap <leader>rl :OmniSharpRunLastTests<cr>
"END_OMNISHARP
"BEGIN_CTRLP
"let g:ctrlp_user_command = 'find %s -type f
let g:ctrlp_switch_buffer = 0
"END_CTRLP
"BEGIN_GUNDO
nnoremap <leader>u :GundoToggle<CR>
"END_GUNDO
"BEGIN_NERDTREE
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"autocmd vimenter * NERDTree
"autocmd vimenter * wincmd p

map <D-1> :NERDTreeToggle<CR>

let g:NERDTreeWinPos = "left"
"END_NERDTREE
"BEGIN_AIRLINE
let g:airline#extensions#tabline#enabled = 1
"END_AIRLINE
