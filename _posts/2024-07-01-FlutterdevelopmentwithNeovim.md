---
title: "네오빔으로 Flutter 개발하는 방법"
description: ""
coverImage: "/assets/img/2024-07-01-FlutterdevelopmentwithNeovim_0.png"
date: 2024-07-01 17:15
ogImage: 
  url: /assets/img/2024-07-01-FlutterdevelopmentwithNeovim_0.png
tag: Tech
originalTitle: "Flutter development with Neovim"
link: "https://medium.com/@lllttt06/flutter-development-with-neovim-7e45669aac53"
---


이 가이드는 플러터 개발을 위해 Neovim을 설정하고 사용하는 데 도움을 줍니다. Neovim 버전은 v0.10.0이며 플러그인 매니저는 lazy.nvim입니다. 제 dotfile은 여기에서 찾을 수 있습니다.

![이미지 0](/assets/img/2024-07-01-FlutterdevelopmentwithNeovim_0.png)

![이미지 1](/assets/img/2024-07-01-FlutterdevelopmentwithNeovim_1.png)

![이미지 2](/assets/img/2024-07-01-FlutterdevelopmentwithNeovim_2.png)

<div class="content-ad"></div>

플러터 개발을 위해 [flutter-tools.nvim](https://github.com/akinsho/flutter-tools.nvim) 플러그인이 매우 유용합니다. 만약 디버거가 필요하지 않다면 nvim-dap을 설치하지 않고 flutter-tools만 사용할 수 있습니다. 아래는 관련 구성 조각입니다:

```js
 -- 디버거
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            'nvim-neotest/nvim-nio',
            'rcarriga/nvim-dap-ui',
        },
        event = 'VeryLazy',
        config = function()
            require("dapui").setup({
                icons = { expanded = "▾", collapsed = "▸" },
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.25 },
                            "breakpoints",
                            "stacks",
                            "watches",
                        },
                        size = 10, -- 컬럼
                        position = "bottom",
                    },
                },
            })
        end
    },

    -- flutter
    {
        "akinsho/flutter-tools.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim",
        },
        config = function()
            require("flutter-tools").setup {
                flutter_path = nil,
                flutter_lookup_cmd = "asdf where flutter",
                fvm = false,
                widget_guides = { enabled = true },
                lsp = {
                    settings = {
                        showtodos = true,
                        completefunctioncalls = true,
                        analysisexcludedfolders = {
                            vim.fn.expand("$Home/.pub-cache"),
                        },
                        renamefileswithclasses = "prompt",
                        updateimportsonrename = true,
                        enablesnippets = false,
                    },
                },
                debugger = {
                    enabled = true,
                    run_via_dap = true,
                    exception_breakpoints = {},
                    register_configurations = function(paths)
                        local dap = require("dap")
                        -- 관련 문서: https://github.com/akinsho/flutter-tools.nvim/pull/292
                        dap.adapters.dart = {
                            type = "executable",
                            command = paths.flutter_bin,
                            args = { "debug-adapter" },
                        }
                        dap.configurations.dart = {}
                        require("dap.ext.vscode").load_launchjs()
                    end,
                },
            }
        end
    },
```

이 섹션에서 언급된대로, flutter_lookup_command를 asdf 등을 사용할 수 있도록 설정해야 합니다.

디버깅을 위해 nvim-dap을 사용 중이라면, require("dap.ext.vscode").load_launchjs()를 설정하여 .vscode/launch.json의 구성을 참조할 수 있습니다.

<div class="content-ad"></div>

```json
// .vscode/launch.json
{
  "version": "0.0.1",
  "configurations": [
    {
      "name": "개발용 앱 실행",
      "program": "${workspaceFolder}/lib/main.dart",
      "request": "launch",
      "type": "dart",
      "flutterMode": "debug",
      "args": [
        "--debug",
        "--flavor",
        "dev",
        "--dart-define-from-file=define/flavor/dev/common.json",
        "--dart-define-from-file=define/flavor/dev/firebase_options.json"
      ]
    },
    {
      "name": "운영용 앱 실행",
      "program": "${workspaceFolder}/lib/main.dart",
      "request": "launch",
      "type": "dart",
      "flutterMode": "debug",
      "args": [
        "--debug",
        "--flavor",
        "prd",
        "--dart-define-from-file=define/flavor/prd/common.json",
        "--dart-define-from-file=define/flavor/prd/firebase_options.json"
      ]
    }
  ]
}
```

<img src="/assets/img/2024-07-01-FlutterdevelopmentwithNeovim_3.png" />

다른 권장하는 Neovim 플러그인

- mini.files
이것은 파일 탐색기 플러그인입니다. 이전에는 nvim-tree.lua를 사용했지만, 고유한 UI/UX로 인해 mini.files로 전환했습니다.


<div class="content-ad"></div>

<img src="/assets/img/2024-07-01-FlutterdevelopmentwithNeovim_4.png" />

- no-neck-pain.nvim
이 플러그인은 버퍼를 화면 가운데에 위치시킵니다. 이 플러그인을 사용함으로써 파일 탐색기를 항상 열어두지 않아도 되는 것을 깨달았고, mini.file 플러그인과 함께 사용하면 더욱 좋습니다.
- hlchunk.nvim
이 플러그인은 코드 청크를 동적으로 강조하여 시각적으로 보기 좋고 중첩된 코드 블록을 따르기 쉽게 만듭니다.

<img src="/assets/img/2024-07-01-FlutterdevelopmentwithNeovim_5.png" />

이 안내서가 더 많은 Vimmer의 수를 늘리는 데 도움이 되기를 바랍니다. Neovim과 Flutter로 즐거운 코딩하세요!