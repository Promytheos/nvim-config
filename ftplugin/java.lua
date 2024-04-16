local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
local root_dir = require("jdtls.setup").find_root(root_markers)
-- calculate workspace dir
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name
os.execute("mkdir " .. workspace_dir)
local jdtls = require('jdtls')

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- TODO: Move to config
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        vim.fn.expand "$HOME/Library/Java/JavaVirtualMachines/corretto-17.0.4.1/Contents/Home/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. vim.fn.expand "$HOME/.local/share/eclipse/lombok.jar",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.glob("/opt/homebrew/Cellar/jdtls/1.34.0/libexec/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        "/opt/homebrew/Cellar/jdtls/1.34.0/libexec/config_mac",
        "-data",
        workspace_dir,
    },
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = root_dir,

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            inlayHints = { parameterNames = { enabled = 'all' } },
            references = {
                includeDecompiledSources = true,
            },
            eclipse = {
                downloadSources = true,
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            configuration = {
                updateBuildConfiguration = 'interactive',
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path =
                        vim.fn.expand "$HOME/Library/Java/JavaVirtualMachines/corretto-17.0.4.1/Contents/Home/"
                    },
                    {
                        name = "JavaSE-18",
                        path =
                        "/Library/Java/JavaVirtualMachines/jdk-18.0.1.1.jdk/Contents/Home/"
                    },
                    {
                        name = "JavaSE-1.8",
                        path =
                        "/usr/local/Cellar/openjdk@8/1.8.0-392/libexec/openjdk.jdk/Contents/Home/",
                        default = true
                    },
                },
            },
            format = {
                enabled = true,
                settings = {
                    url = vim.fn.expand "$HOME/.local/share/eclipse/bgs-code-style.xml",
                    profile = "BGSCodeStyle",
                },
                tabSize = 4,
                insertSpaces = true,
                comments = {
                    enabled = true,
                },
                onType = {
                    enabled = true,
                },
            },
            signatureHelp = {
                enabled = true,
            },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
        },
    },
    on_attach = function()
        require("config.lsp-keymaps").register_lsp_keymaps()
    end,


    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {
            vim.fn.expand "$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar",
            -- unpack remaining bundles
            (table.unpack)(vim.split(vim.fn.glob "$MASON/share/java-test/*.jar", "\n", {})),
        },
    },
}

config.on_init = function(client, _)
    client.notify('workspace/didChangeConfiguration', { settings = config.settings })
end
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
