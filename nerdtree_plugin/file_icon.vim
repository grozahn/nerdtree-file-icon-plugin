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

function! NERDTreeFileIconRefreshListener(event)
  let path = a:event.subject

  let fileNodeSymbol = g:NERDTreeFileIcon
  let backPadding = g:NERDTreeFileIconFrontPadding
  let frontPadding = g:NERDTreeFileIconBackPadding

  if !path.isDirectory
    let flag = frontPadding . fileNodeSymbol . backPadding

  call path.flagSet.clearFlags('file_icon')

  if flag !=? ''
    call path.flagSet.addFlag('file_icon', flag)
  endif

endfunction

function! s:SetupListeners()
  call g:NERDTreePathNotifier.AddListener('init', 'NERDTreeFileIconRefreshListener')
  call g:NERDTreePathNotifier.AddListener('refresh', 'NERDTreeFileIconRefreshListener')
  call g:NERDTreePathNotifier.AddListener('refreshFlags', 'NERDTreeFileIconRefreshListener')
endfunction

" util like helpers
" scope: local
function! s:Refresh()
  call b:NERDTree.root.refreshFlags()
  call NERDTreeRender()
endfunction
