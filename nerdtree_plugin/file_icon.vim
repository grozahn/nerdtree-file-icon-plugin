if !exists('g:loaded_nerdtree_file_icon')
  let g:loaded_nerdtree_file_icon = 1
endif

if !exists('g:loaded_nerd_tree')
 echohl WarningMsg |
   \ echomsg 'nerdtree-file-icon requires NERDTree.'
endif

if exists('g:loaded_nerd_tree') && g:loaded_nerd_tree == 1 && !exists('g:NERDTreePathNotifier')
 echohl WarningMsg |
    \ echomsg 'nerdtree-file-icon requires a newer version of NERDTree.'
endif

if !exists('g:NERDTreeFileIcon')
  let g:NERDTreeFileIcon = '🗒'
endif

if !exists('g:NERDTreeFileIconFrontPadding')
  let g:NERDTreeFileIconFrontPadding = ' '
endif

if !exists('g:NERDTreeFileIconBackPadding')
  let g:NERDTreeFileIconBackPadding = ' '
endif

augroup nerd_tree_file_icon_hide_conceal_brackets
  au!
  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
  autocmd FileType nerdtree set conceallevel=3
  autocmd FileType nerdtree set concealcursor=nvic
augroup END

function! NERDTreeFileIconRefreshListener(event)
  let path = a:event.subject
  let flag = ''

  let fileNodeSymbol = g:NERDTreeFileIcon
  let backPadding = g:NERDTreeFileIconFrontPadding
  let frontPadding = g:NERDTreeFileIconBackPadding

  if !path.isDirectory
    let flag = frontPadding . fileNodeSymbol . backPadding
  endif

  call path.flagSet.clearFlags('file_icon')

  if flag !=# ''
    call path.flagSet.addFlag('file_icon', flag)
  endif

endfunction

function! s:SetupListeners()
  call g:NERDTreePathNotifier.AddListener('init', 'NERDTreeFileIconRefreshListener')
  call g:NERDTreePathNotifier.AddListener('refresh', 'NERDTreeFileIconRefreshListener')
  call g:NERDTreePathNotifier.AddListener('refreshFlags', 'NERDTreeFileIconRefreshListener')
endfunction

if g:loaded_nerdtree_file_icon
  call s:SetupListeners()
endif
