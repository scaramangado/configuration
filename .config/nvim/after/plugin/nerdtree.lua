-- Disable filename color for unmatched files
vim.g['WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir'] = 1
vim.g['WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile'] = 1

-- Enable filename color for matched files
vim.g['NERDTreeFileExtensionHighlightFullName'] = 1
vim.g['NERDTreeExactMatchHighlightFullName'] = 1
vim.g['NERDTreePatternMatchHighlightFullName'] = 1
vim.g['NERDTreeHighlightFolders'] = 1
vim.g['NERDTreeHighlightFoldersFullName'] = 1

-- Hide brackets
vim.g['webdevicons_conceal_nerdtree_brackets'] = 1

-- Add custom symbols
vim.g['WebDevIconsUnicodeDecorateFileNodesExtensionSymbols'] = {}
vim.g['WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[\'kt\']'] = 'ﱃ'
vim.g['WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[\'kts\']'] = 'ﱃ'

vim.g['WebDevIconsUnicodeDecorateFileNodesExactSymbols'] = {}
vim.g['WebDevIconsUnicodeDecorateFileNodesExactSymbols[\'build.gradle\']'] = 'ﳄ'
vim.g['WebDevIconsUnicodeDecorateFileNodesExactSymbols[\'build.gradle.kts\']'] = 'ﳄ'
vim.g['WebDevIconsUnicodeDecorateFileNodesExactSymbols[\'settings.gradle\']'] = 'ﳄ'
vim.g['WebDevIconsUnicodeDecorateFileNodesExactSymbols[\'settings.gradle.kts\']'] = 'ﳄ'

