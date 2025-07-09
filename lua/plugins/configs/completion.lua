local cmp = require('cmp')

local luasnip = require('luasnip')

require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip.loaders.from_vscode").lazy_load({ 
    paths = { "~/.config/nvim/snippets/" } 
})


cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    --    ['<Tab>'] = cmp.mapping.select_next_item(),
		['<Tab>'] = cmp.mapping(function(fallback)
		    if cmp.visible() then
		        cmp.select_next_item()
		    elseif luasnip.expand_or_jumpable() then
		        luasnip.expand_or_jump()
		    else
		        fallback()
		    end
		end, { 'i', 's' }),
        ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        })
    },
    sources = {
        { name = 'nvim-forge'},
        { name = 'path' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'nvim_lsp_signature_help'},
        { name = 'nvim_lua', keyword_length = 2},
        { name = 'buffer', keyword_length = 2 },
  --      { name = 'vsnip', keyword_length = 2 },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'calc'},
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = {'menu', 'abbr', 'kind'},
		format = function(entry, vim_item)
		        local kind_icons = {
            Text = "󰉿", Method = "󰆧", Function = "󰊕", Constructor = "",
            Field = "󰜢", Variable = "󰀫", Class = "󰠱", Interface = "",
            Module = "", Property = "󰜢", Unit = "󰑭", Value = "󰎠",
            Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
            File = "󰈙", Reference = "󰈇", Folder = "󰉋", EnumMember = "",
            Constant = "󰏿", Struct = "󰙅", Event = "", Operator = "󰆕",
            TypeParameter = "",
        }

        if entry.source.name == 'luasnip' then
            local snippet_name = vim_item.abbr or ""
            local file_type = vim.bo.filetype
            
            if file_type == 'javascriptreact' or file_type == 'typescriptreact' or 
               file_type == 'jsx' or file_type == 'tsx' then
                
                if snippet_name:match("^raf") or snippet_name:match("^rfc") or 
                   snippet_name:match("^rcc") then
                    vim_item.kind = " Component"
                    vim_item.menu = "React"
                elseif snippet_name:match("use") then
                    vim_item.kind = "⇄ Hook"
                    vim_item.menu = "React"
                elseif snippet_name:match("^n") and (snippet_name:match("api") or 
                       snippet_name:match("page") or snippet_name:match("gs")) then
                    vim_item.kind = "󱓟 Next.js"
                    vim_item.menu = "Next.js"
				elseif snippet_name:match("^cl") or snippet_name:match("console") then
				    vim_item.kind = " Debug"
				    vim_item.menu = "React"
				elseif snippet_name:match("^imp") or snippet_name:match("import") then
				    vim_item.kind = "󰋺 Import"
				    vim_item.menu = "React"
                else
                    vim_item.kind = " Snippet"
                    vim_item.menu = "React"
                end
				--Golang
				elseif file_type == 'go' then

                	if snippet_name:match("^func") or snippet_name:match("^fn") then
                	    vim_item.kind = "󰊕 Function"
                	    vim_item.menu = "Go"
                	elseif snippet_name:match("^struct") or snippet_name:match("^st") then
                	    vim_item.kind = "󰙅 Struct"
                	    vim_item.menu = "Go"
                	elseif snippet_name:match("^interface") or snippet_name:match("^iface") then
                	    vim_item.kind = "󰜰 Interface"
                	    vim_item.menu = "Go"
                	elseif snippet_name:match("^if") or snippet_name:match("^for") or 
                	       snippet_name:match("^switch") or snippet_name:match("^select") then
                	    vim_item.kind = "󰘧 Control"
                	    vim_item.menu = "Go"
                	elseif snippet_name:match("^err") or snippet_name:match("error") then
                	    vim_item.kind = "󰅚 Error"
                	    vim_item.menu = "Go"
                	elseif snippet_name:match("^test") or snippet_name:match("^bench") then
                	    vim_item.kind = "󰙨 Test"
                	    vim_item.menu = "Go"
                	elseif snippet_name:match("^go") or snippet_name:match("goroutine") then
                	    vim_item.kind = "󰐱 Goroutine"
                	    vim_item.menu = "Go"
                	elseif snippet_name:match("^ch") or snippet_name:match("channel") or 
                	       snippet_name:match("^make") then
                	    vim_item.kind = "󰆕 Channel"
                	    vim_item.menu = "Go"
                	elseif snippet_name:match("^fmt") or snippet_name:match("print") then
                	    vim_item.kind = "󰆥 Print"
                	    vim_item.menu = "Go"
                	else
                	    vim_item.kind = "󰟓 Snippet"
                	    vim_item.menu = "Go"
                	end
			-- Rust
			elseif file_type == 'rust' then
                if snippet_name:match("^fn") or snippet_name:match("^func") then
                    vim_item.kind = "󰊕 Function"
                    vim_item.menu = "Rust"
                elseif snippet_name:match("^struct") or snippet_name:match("^st") then
                    vim_item.kind = "󰙅 Struct"
                    vim_item.menu = "Rust"
                elseif snippet_name:match("^enum") or snippet_name:match("^en") then
                    vim_item.kind = "󰉺 Enum"
                    vim_item.menu = "Rust"
                elseif snippet_name:match("^trait") or snippet_name:match("^tr") then
                    vim_item.kind = "󰜰 Trait"
                    vim_item.menu = "Rust"
                elseif snippet_name:match("^impl") or snippet_name:match("^imp") then
                    vim_item.kind = "󰡱 Impl"
                    vim_item.menu = "Rust"
                elseif snippet_name:match("^match") or snippet_name:match("^if") or 
                       snippet_name:match("^for") or snippet_name:match("^while") then
                    vim_item.kind = "󰘧 Control"
                    vim_item.menu = "Rust"
                elseif snippet_name:match("^result") or snippet_name:match("^option") or 
                       snippet_name:match("^ok") or snippet_name:match("^err") then
                    vim_item.kind = "󰅚 Result"
                    vim_item.menu = "Rust"
                elseif snippet_name:match("^test") or snippet_name:match("^bench") then
                    vim_item.kind = "󰙨 Test"
                    vim_item.menu = "Rust"
                elseif snippet_name:match("^macro") or snippet_name:match("^mac") then
                    vim_item.kind = "󰘦 Macro"
                    vim_item.menu = "Rust"
                elseif snippet_name:match("^vec") or snippet_name:match("^hashmap") or 
                       snippet_name:match("^btree") then
                    vim_item.kind = "󰅪 Collection"
                    vim_item.menu = "Rust"
                elseif snippet_name:match("^println") or snippet_name:match("^print") or 
                       snippet_name:match("^dbg") then
                    vim_item.kind = "󰆥 Print"
                    vim_item.menu = "Rust"
                else
                    vim_item.kind = "󱘗 Snippet"
                    vim_item.menu = "Rust"
                end

            else
                vim_item.kind = " Snippet"
                vim_item.menu = "LuaSnip"
            end
        else
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            local menu_icons = {
                copilot = '󱙺', nvim_lsp = 'λ', buffer = 'Ω', path = '🖫',
                calc = '󰪚', ['nvim-forge'] = '󱌢', nvim_lsp_signature_help = '󱧃',
                nvim_lua = '',
            }
            vim_item.menu = menu_icons[entry.source.name]
        end

        return vim_item
	end
    },
})
