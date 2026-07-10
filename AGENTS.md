# Neovim Configuration

Это часть dotfiles-репозитория. Neovim конфиг с lazy.nvim.

## Структура

```
init.lua                -- точка входа: подключает lazy.nvim, options, autocommands, keymaps
lua/
  config/options.lua    -- общие настройки редактора
  config/keymaps.lua    -- глобальные кеймапы через which-key
  config/autocommands.lua
  plugins/*.lua         -- спецификации lazy-плагинов (подгружаются через require("lazy").setup("plugins"))
  plugins/mini/*.lua    -- конфиги mini-модулей, возвращают таблицу опций для mini.xxx.setup()
  lsp/*.lua             -- конфиги LSP-серверов, возвращают таблицу для vim.lsp.config()
ftplugin/               -- файлтайповые настройки
snippets/               -- пользовательские сниппеты (MiniSnippets)
```

## Критичные особенности

### LSP-конфигурация (Neovim 0.11+)
**LSP настраивается через новый API `vim.lsp.config()` / `vim.lsp.enable()`, а НЕ через `lspconfig[lang].setup()`.**

- `vim.lsp.config()` ДОЛЖЕН вызываться до `vim.lsp.enable()` — иначе сервер стартует с дефолтными настройками
- `root_dir` — только функция, поля `root_markers` в этом API не существует
- Список серверов в `lua/plugins/lsp.lua:1` — массив `predefined_lsp`
- Каждый сервер требует файл `lua/lsp/<name>.lua`, который возвращает таблицу конфигурации (или `return {}` для дефолтных настроек)
- Для добавления нового LSP: создать файл в `lua/lsp/` и добавить имя в `predefined_lsp`
- Информацию о LSP-клиентах смотреть через `:checkhealth vim.lsp` (не `:LspInfo`)

### TypeScript/Vue
- Используется **vtsls** вместо `ts_ls` (`ts_ls` явно исключён в `mason.lua:14`)
- Vue-плагин для TypeScript подключается через `vtsls` (`lua/lsp/vtsls.lua`)
- Путь к `@vue/language-server` резолвится из Mason data directory

### Управление пакетами
- `lazy.nvim` с автоустановкой (клон в `stdpath("data")/lazy/lazy.nvim`)
- **Закреплённые версии** в `lazy-lock.json` — после изменений плагинов запускать синхронизацию
- Mason: `automatic_installation = false`, `ensure_installed = { "lua_ls" }` (только `lua_ls` устанавливается автоматически)

### Команды / хоткеи
- Лидер: `<Space>`
- Все кеймапы задаются через `require('which-key').add()`
- `-` — открыть Oil (файловый менеджер)
- `<C-h/j/k/l>` — навигация между сплитами nvim/tmux через vim-tmux-navigator
- `<leader>f*` — Telescope (ff — файлы, fg — grep, fb — буферы, fh — включая скрытые)
- `<leader>cp` — форматирование через Prettier CLI
- `<leader>cf` — форматирование через LSP
- `<leader>xx` / `<leader>lt` — Trouble (диагностика / LSP references)
- `<leader>h*` — Gitsigns (stage/reset/preview hunk)

### Особые настройки
- `vim.o.exrc = true` — разрешены локальные `.nvim.lua` в проектах
- Русская раскладка: настроен langmap в `config/options.lua` + плагин `langmapper.nvim`
- Фолдинг: через treesitter (`foldmethod=expr`, `nvim_treesitter#foldexpr()`)
- `clipboard = 'unnamedplus'` (системный буфер)
- Treesitter-парсеры устанавливаются в `stdpath('data')/site`

## Добавление нового LSP-сервера

1. Создать файл `lua/lsp/<имя>.lua`, возвращающий таблицу опций (или `return {}`)
2. Добавить имя в массив `predefined_lsp` в `lua/plugins/lsp.lua`
3. Если сервер требует установки через Mason — добавить вручную через `:Mason`

## Добавление нового mini-модуля

1. Создать файл `lua/plugins/mini/<имя>.lua`, возвращающий таблицу опций
2. Добавить имя модуля в массив `mini_modules` в `lua/plugins/mini/init.lua`
