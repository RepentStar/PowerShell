using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'codew' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'codew'
        for ($i = 1; $i -lt $commandElements.Count; $i++) {
            $element = $commandElements[$i]
            if ($element -isnot [StringConstantExpressionAst] -or
                $element.StringConstantType -ne [StringConstantType]::BareWord -or
                $element.Value.StartsWith('-') -or
                $element.Value -eq $wordToComplete) {
                break
        }
        $element.Value
    }) -join ';'

    $completions = @(switch ($command) {
        'codew' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'Initial prompt to submit in the interactive TUI. Use `exec` for non-interactive runs')
            [CompletionResult]::new('--prompt', '--prompt', [CompletionResultType]::ParameterName, 'Initial prompt to submit in the interactive TUI. Use `exec` for non-interactive runs')
            [CompletionResult]::new('--max-subagents', '--max-subagents', [CompletionResultType]::ParameterName, 'Maximum number of concurrent sub-agents (1-128; default 64)')
            [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'Path to config file')
            [CompletionResult]::new('--profile', '--profile', [CompletionResultType]::ParameterName, 'Config profile name')
            [CompletionResult]::new('-w', '-w', [CompletionResultType]::ParameterName, 'Workspace directory for file operations')
            [CompletionResult]::new('--workspace', '--workspace', [CompletionResultType]::ParameterName, 'Workspace directory for file operations')
            [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Resume a previous session by ID or prefix')
            [CompletionResult]::new('--resume', '--resume', [CompletionResultType]::ParameterName, 'Resume a previous session by ID or prefix')
            [CompletionResult]::new('--yolo', '--yolo', [CompletionResultType]::ParameterName, 'Legacy compatibility alias for Act + Full Access')
            [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Continue the most recent session in this workspace')
            [CompletionResult]::new('--continue', '--continue', [CompletionResultType]::ParameterName, 'Continue the most recent session in this workspace')
            [CompletionResult]::new('--mouse-capture', '--mouse-capture', [CompletionResultType]::ParameterName, 'Enable TUI mouse capture for internal scrolling, transcript selection, and scrollbar dragging (default off on Windows)')
            [CompletionResult]::new('--no-mouse-capture', '--no-mouse-capture', [CompletionResultType]::ParameterName, 'Disable TUI mouse capture so terminal-native text selection works')
            [CompletionResult]::new('--skip-onboarding', '--skip-onboarding', [CompletionResultType]::ParameterName, 'Skip onboarding screens')
            [CompletionResult]::new('--remote-control', '--remote-control', [CompletionResultType]::ParameterName, 'Start account-owned web remote control for this interactive session')
            [CompletionResult]::new('--fresh', '--fresh', [CompletionResultType]::ParameterName, 'Start a fresh session, ignoring any crash-recovery checkpoint')
            [CompletionResult]::new('--no-project-config', '--no-project-config', [CompletionResultType]::ParameterName, 'Skip loading project-level config from $WORKSPACE/.codewhale/config.toml')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('-V', '-V ', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('--version', '--version', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('doctor', 'doctor', [CompletionResultType]::ParameterValue, 'Run system diagnostics and check configuration')
            [CompletionResult]::new('session-diagnostics', 'session-diagnostics', [CompletionResultType]::ParameterValue, 'Summarize failure signals from a local JSONL session log without raw content')
            [CompletionResult]::new('setup', 'setup', [CompletionResultType]::ParameterValue, 'Bootstrap MCP config and/or skills directories')
            [CompletionResult]::new('remote-setup', 'remote-setup', [CompletionResultType]::ParameterValue, 'Generate a remote Codewhale agent deploy bundle (cloud + chat bridge)')
            [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate shell completions')
            [CompletionResult]::new('sessions', 'sessions', [CompletionResultType]::ParameterValue, 'List saved sessions')
            [CompletionResult]::new('init', 'init', [CompletionResultType]::ParameterValue, 'Create default AGENTS.md in current directory')
            [CompletionResult]::new('login', 'login', [CompletionResultType]::ParameterValue, 'Save an API key to the shared user config')
            [CompletionResult]::new('logout', 'logout', [CompletionResultType]::ParameterValue, 'Remove the saved API key')
            [CompletionResult]::new('auth', 'auth', [CompletionResultType]::ParameterValue, 'Manage provider authentication flows')
            [CompletionResult]::new('models', 'models', [CompletionResultType]::ParameterValue, 'List available models from the configured API endpoint')
            [CompletionResult]::new('speech', 'speech', [CompletionResultType]::ParameterValue, 'Generate speech audio with Xiaomi MiMo TTS models')
            [CompletionResult]::new('tts', 'tts', [CompletionResultType]::ParameterValue, 'Generate speech audio with Xiaomi MiMo TTS models')
            [CompletionResult]::new('exec', 'exec', [CompletionResultType]::ParameterValue, 'Run a non-interactive prompt. Use --auto for agent-with-tools mode')
            [CompletionResult]::new('fleet', 'fleet', [CompletionResultType]::ParameterValue, 'Manage local Agent Fleet runs and workers')
            [CompletionResult]::new('workflow-tool', 'workflow-tool', [CompletionResultType]::ParameterValue, 'Internal model-free Workflow tool dispatcher used by Lane Runtime')
            [CompletionResult]::new('review', 'review', [CompletionResultType]::ParameterValue, 'Run a code review over a git diff')
            [CompletionResult]::new('pr', 'pr', [CompletionResultType]::ParameterValue, 'Open the TUI pre-seeded with a GitHub PR''s title, body, and diff')
            [CompletionResult]::new('apply', 'apply', [CompletionResultType]::ParameterValue, 'Apply a patch file (or stdin) to the working tree')
            [CompletionResult]::new('eval', 'eval', [CompletionResultType]::ParameterValue, 'Run the offline evaluation harness (no network/LLM calls)')
            [CompletionResult]::new('scorecard', 'scorecard', [CompletionResultType]::ParameterValue, 'Score a run''s token/cache/cost from recorded turns; flag regressions vs a baseline')
            [CompletionResult]::new('mcp', 'mcp', [CompletionResultType]::ParameterValue, 'Manage MCP servers')
            [CompletionResult]::new('features', 'features', [CompletionResultType]::ParameterValue, 'Inspect feature flags')
            [CompletionResult]::new('integrations', 'integrations', [CompletionResultType]::ParameterValue, 'Connect third-party harnesses through Codewhale (currently: DeepSeek Harness `dsh`)')
            [CompletionResult]::new('sandbox', 'sandbox', [CompletionResultType]::ParameterValue, 'Run a command inside the sandbox')
            [CompletionResult]::new('serve', 'serve', [CompletionResultType]::ParameterValue, 'Run a local server (e.g. MCP)')
            [CompletionResult]::new('resume', 'resume', [CompletionResultType]::ParameterValue, 'Resume a previous session by ID (use --last for most recent)')
            [CompletionResult]::new('fork', 'fork', [CompletionResultType]::ParameterValue, 'Fork a previous session by ID (use --last for most recent)')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;doctor' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--json', '--json', [CompletionResultType]::ParameterName, 'Emit machine-readable structural JSON output (always offline)')
            [CompletionResult]::new('--context-json', '--context-json', [CompletionResultType]::ParameterName, 'Emit only the diagnostic context source map as JSON')
            [CompletionResult]::new('--probe-local', '--probe-local', [CompletionResultType]::ParameterName, 'Opt in to probing a local provider endpoint (may start a local service)')
            [CompletionResult]::new('--probe-api', '--probe-api', [CompletionResultType]::ParameterName, 'Opt in to probing the configured hosted provider API')
            [CompletionResult]::new('--check-updates', '--check-updates', [CompletionResultType]::ParameterName, 'Opt in to contacting the release service for an update check')
            [CompletionResult]::new('--probe-mcp', '--probe-mcp', [CompletionResultType]::ParameterName, 'Opt in to starting enabled MCP servers and checking process/protocol reachability')
            [CompletionResult]::new('--probe-search', '--probe-search', [CompletionResultType]::ParameterName, 'Opt in to a credential-free transport probe of the selected search provider')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;session-diagnostics' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--json', '--json', [CompletionResultType]::ParameterName, 'Emit machine-readable JSON with redacted source handles')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;setup' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--mcp', '--mcp', [CompletionResultType]::ParameterName, 'Initialize MCP configuration at the configured path')
            [CompletionResult]::new('--skills', '--skills', [CompletionResultType]::ParameterName, 'Initialize skills directory and an example skill')
            [CompletionResult]::new('--tools', '--tools', [CompletionResultType]::ParameterName, 'Initialize tools directory with a self-describing example script')
            [CompletionResult]::new('--plugins', '--plugins', [CompletionResultType]::ParameterName, 'Initialize plugins directory with a self-describing example')
            [CompletionResult]::new('--all', '--all', [CompletionResultType]::ParameterName, 'Initialize MCP config, skills, tools, and plugins')
            [CompletionResult]::new('--local', '--local', [CompletionResultType]::ParameterName, 'Create a local workspace skills directory (./skills)')
            [CompletionResult]::new('--force', '--force', [CompletionResultType]::ParameterName, 'Overwrite existing template files')
            [CompletionResult]::new('--status', '--status', [CompletionResultType]::ParameterName, 'Print a compact, read-only status report (no network calls)')
            [CompletionResult]::new('--clean', '--clean', [CompletionResultType]::ParameterName, 'Remove regenerable session checkpoints (latest + offline_queue)')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;remote-setup' {
            [CompletionResult]::new('--cloud', '--cloud', [CompletionResultType]::ParameterName, 'Cloud target slug (lighthouse, azure, digitalocean). Skips the prompt')
            [CompletionResult]::new('--bridge', '--bridge', [CompletionResultType]::ParameterName, 'Chat bridge slug (feishu, telegram). Skips the prompt')
            [CompletionResult]::new('--provider', '--provider', [CompletionResultType]::ParameterName, 'Provider slug; validated against the provider registry. Skips the prompt')
            [CompletionResult]::new('--out', '--out', [CompletionResultType]::ParameterName, 'Bundle output directory (default `./codewhale-deploy/<cloud>-<bridge>`)')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--generate-only', '--generate-only', [CompletionResultType]::ParameterName, 'Emit the bundle, do not provision (default)')
            [CompletionResult]::new('--apply', '--apply', [CompletionResultType]::ParameterName, 'Run the cloud CLI to auto-provision (MVP: not yet implemented)')
            [CompletionResult]::new('--yes', '--yes', [CompletionResultType]::ParameterName, 'Skip the final confirmation gate (CI / non-interactive)')
            [CompletionResult]::new('--non-interactive', '--non-interactive', [CompletionResultType]::ParameterName, 'Fail instead of prompting if any required value is missing')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;completions' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;sessions' {
            [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'Maximum number of sessions to display')
            [CompletionResult]::new('--limit', '--limit', [CompletionResultType]::ParameterName, 'Maximum number of sessions to display')
            [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Search sessions by title')
            [CompletionResult]::new('--search', '--search', [CompletionResultType]::ParameterName, 'Search sessions by title')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;init' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;login' {
            [CompletionResult]::new('--api-key', '--api-key', [CompletionResultType]::ParameterName, 'API key to store (otherwise read from stdin)')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;logout' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;auth' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('xai-device', 'xai-device', [CompletionResultType]::ParameterValue, 'Sign in to xAI/Grok with an SSH-friendly device code')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;auth;xai-device' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;auth;help' {
            [CompletionResult]::new('xai-device', 'xai-device', [CompletionResultType]::ParameterValue, 'Sign in to xAI/Grok with an SSH-friendly device code')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;auth;help;xai-device' {
            break
        }
        'codew;auth;help;help' {
            break
        }
        'codew;models' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--json', '--json', [CompletionResultType]::ParameterName, 'Print models as pretty JSON')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;speech' {
            [CompletionResult]::new('-o', '-o', [CompletionResultType]::ParameterName, 'Output audio path. Defaults to `speech.<format>` in `--output-dir`, `[speech].output_dir`, or the current directory')
            [CompletionResult]::new('--output', '--output', [CompletionResultType]::ParameterName, 'Output audio path. Defaults to `speech.<format>` in `--output-dir`, `[speech].output_dir`, or the current directory')
            [CompletionResult]::new('--output-dir', '--output-dir', [CompletionResultType]::ParameterName, 'Directory for the default `speech.<format>` output file when `-o`/`--output` is omitted')
            [CompletionResult]::new('--model', '--model', [CompletionResultType]::ParameterName, 'TTS model. Defaults to built-in voices, or is inferred from --voice-prompt/--clone-voice')
            [CompletionResult]::new('--voice', '--voice', [CompletionResultType]::ParameterName, 'Built-in voice ID, or a data:audio/...;base64,... URI for voice clone')
            [CompletionResult]::new('--instruction', '--instruction', [CompletionResultType]::ParameterName, 'Natural language style instruction; not spoken verbatim')
            [CompletionResult]::new('--voice-prompt', '--voice-prompt', [CompletionResultType]::ParameterName, 'Voice design prompt. Implies mimo-v2.5-tts-voicedesign when --model is omitted')
            [CompletionResult]::new('--clone-voice', '--clone-voice', [CompletionResultType]::ParameterName, 'MP3/WAV sample used for voice cloning. Implies mimo-v2.5-tts-voiceclone when --model is omitted')
            [CompletionResult]::new('--format', '--format', [CompletionResultType]::ParameterName, 'Output audio format requested from the API')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--json', '--json', [CompletionResultType]::ParameterName, 'Emit machine-readable JSON output')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;tts' {
            [CompletionResult]::new('-o', '-o', [CompletionResultType]::ParameterName, 'Output audio path. Defaults to `speech.<format>` in `--output-dir`, `[speech].output_dir`, or the current directory')
            [CompletionResult]::new('--output', '--output', [CompletionResultType]::ParameterName, 'Output audio path. Defaults to `speech.<format>` in `--output-dir`, `[speech].output_dir`, or the current directory')
            [CompletionResult]::new('--output-dir', '--output-dir', [CompletionResultType]::ParameterName, 'Directory for the default `speech.<format>` output file when `-o`/`--output` is omitted')
            [CompletionResult]::new('--model', '--model', [CompletionResultType]::ParameterName, 'TTS model. Defaults to built-in voices, or is inferred from --voice-prompt/--clone-voice')
            [CompletionResult]::new('--voice', '--voice', [CompletionResultType]::ParameterName, 'Built-in voice ID, or a data:audio/...;base64,... URI for voice clone')
            [CompletionResult]::new('--instruction', '--instruction', [CompletionResultType]::ParameterName, 'Natural language style instruction; not spoken verbatim')
            [CompletionResult]::new('--voice-prompt', '--voice-prompt', [CompletionResultType]::ParameterName, 'Voice design prompt. Implies mimo-v2.5-tts-voicedesign when --model is omitted')
            [CompletionResult]::new('--clone-voice', '--clone-voice', [CompletionResultType]::ParameterName, 'MP3/WAV sample used for voice cloning. Implies mimo-v2.5-tts-voiceclone when --model is omitted')
            [CompletionResult]::new('--format', '--format', [CompletionResultType]::ParameterName, 'Output audio format requested from the API')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--json', '--json', [CompletionResultType]::ParameterName, 'Emit machine-readable JSON output')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;exec' {
            [CompletionResult]::new('--model', '--model', [CompletionResultType]::ParameterName, 'Override model for this run')
            [CompletionResult]::new('--provider', '--provider', [CompletionResultType]::ParameterName, 'Override the provider for this run (e.g. `deepseek`, `openrouter`). Non-secret identifier only — credentials still resolve from the environment/config. Fleet uses this to launch a worker on its profile-pinned provider even when the parent session is on another one (#4093)')
            [CompletionResult]::new('--reasoning-effort', '--reasoning-effort', [CompletionResultType]::ParameterName, 'Override reasoning/thinking effort for this run. Accepted values: auto, off, low, medium, high, max')
            [CompletionResult]::new('--sandbox', '--sandbox', [CompletionResultType]::ParameterName, 'Sandbox policy for this exec run; independent from --auto')
            [CompletionResult]::new('--resume', '--resume', [CompletionResultType]::ParameterName, 'Resume a previous session by ID or prefix')
            [CompletionResult]::new('--session-id', '--session-id', [CompletionResultType]::ParameterName, 'Resume a previous session by ID or prefix')
            [CompletionResult]::new('--output-format', '--output-format', [CompletionResultType]::ParameterName, 'Output format for exec mode')
            [CompletionResult]::new('--allowed-tools', '--allowed-tools', [CompletionResultType]::ParameterName, 'Comma-separated list of canonical tools to allow (all others denied). Names are case-insensitive: Bash, File, Git, Run, etc')
            [CompletionResult]::new('--disallowed-tools', '--disallowed-tools', [CompletionResultType]::ParameterName, 'Comma-separated list of tools to deny (deny wins over allow)')
            [CompletionResult]::new('--max-turns', '--max-turns', [CompletionResultType]::ParameterName, 'Maximum number of model steps before the run ends. Omitted means unlimited')
            [CompletionResult]::new('--append-system-prompt', '--append-system-prompt', [CompletionResultType]::ParameterName, 'Extra text appended to the system prompt for this run')
            [CompletionResult]::new('--tool-authority-json', '--tool-authority-json', [CompletionResultType]::ParameterName, 'Internal Fleet worker authority envelope. Non-secret, versioned JSON')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--auto', '--auto', [CompletionResultType]::ParameterName, 'Enable agent-with-tools mode with automatic tool approvals. This does not authorize sandbox elevation')
            [CompletionResult]::new('--allow-sandbox-elevation', '--allow-sandbox-elevation', [CompletionResultType]::ParameterName, 'Explicitly allow a denied tool to retry with danger-full-access')
            [CompletionResult]::new('--json', '--json', [CompletionResultType]::ParameterName, 'Emit machine-readable JSON output')
            [CompletionResult]::new('--continue', '--continue', [CompletionResultType]::ParameterName, 'Continue the most recent session for this workspace')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;fleet' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('init', 'init', [CompletionResultType]::ParameterValue, 'Initialize the local fleet ledger for this workspace')
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Create a run from a task spec and start the foreground manager loop')
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List durable Fleet runs from this workspace''s ledger')
            [CompletionResult]::new('status', 'status', [CompletionResultType]::ParameterValue, 'Show queued/running/completed/failed/stale fleet counts')
            [CompletionResult]::new('inspect', 'inspect', [CompletionResultType]::ParameterValue, 'Inspect one worker''s status, heartbeat, latest event, and artifacts')
            [CompletionResult]::new('logs', 'logs', [CompletionResultType]::ParameterValue, 'Print bounded log artifacts for one worker')
            [CompletionResult]::new('artifacts', 'artifacts', [CompletionResultType]::ParameterValue, 'List artifact refs for one worker')
            [CompletionResult]::new('interrupt', 'interrupt', [CompletionResultType]::ParameterValue, 'Interrupt a running worker task and record a terminal cancellation')
            [CompletionResult]::new('restart', 'restart', [CompletionResultType]::ParameterValue, 'Restart the latest task for a worker')
            [CompletionResult]::new('resume', 'resume', [CompletionResultType]::ParameterValue, 'Resume a run from durable ledger state, reconciling orphaned/stale leases')
            [CompletionResult]::new('stop', 'stop', [CompletionResultType]::ParameterValue, 'Stop all queued and running fleet work')
            [CompletionResult]::new('alert-dry-run', 'alert-dry-run', [CompletionResultType]::ParameterValue, 'Render a redacted fleet alert payload without sending it')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;fleet;init' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;fleet;run' {
            [CompletionResult]::new('--max-workers', '--max-workers', [CompletionResultType]::ParameterName, 'Maximum local workers to lease concurrently')
            [CompletionResult]::new('--stale-after-seconds', '--stale-after-seconds', [CompletionResultType]::ParameterName, 'Seconds without heartbeat before a running task is counted stale')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--once', '--once', [CompletionResultType]::ParameterName, 'Schedule once and return instead of staying in the manager loop')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;fleet;list' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;fleet;status' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;fleet;inspect' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;fleet;logs' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;fleet;artifacts' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;fleet;interrupt' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;fleet;restart' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;fleet;resume' {
            [CompletionResult]::new('--stale-after-seconds', '--stale-after-seconds', [CompletionResultType]::ParameterName, 'Seconds without heartbeat before a leased task is treated as stale')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;fleet;stop' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--all', '--all', [CompletionResultType]::ParameterName, 'Confirm stopping all queued and running fleet tasks')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;fleet;alert-dry-run' {
            [CompletionResult]::new('--event', '--event', [CompletionResultType]::ParameterName, 'Alert event class to render')
            [CompletionResult]::new('--run-id', '--run-id', [CompletionResultType]::ParameterName, 'Fleet run id')
            [CompletionResult]::new('--worker-id', '--worker-id', [CompletionResultType]::ParameterName, 'Worker id, when the event belongs to one worker')
            [CompletionResult]::new('--task-id', '--task-id', [CompletionResultType]::ParameterName, 'Task id, when the event belongs to one task')
            [CompletionResult]::new('--reason', '--reason', [CompletionResultType]::ParameterName, 'Short human-readable reason for the alert')
            [CompletionResult]::new('--status', '--status', [CompletionResultType]::ParameterName, 'Status label to include in the payload')
            [CompletionResult]::new('--adapter', '--adapter', [CompletionResultType]::ParameterName, 'Adapter payload shape to render')
            [CompletionResult]::new('--slack-webhook-env', '--slack-webhook-env', [CompletionResultType]::ParameterName, 'Environment variable containing the Slack webhook URL')
            [CompletionResult]::new('--webhook-url-env', '--webhook-url-env', [CompletionResultType]::ParameterName, 'Environment variable containing the generic webhook URL')
            [CompletionResult]::new('--webhook-secret-env', '--webhook-secret-env', [CompletionResultType]::ParameterName, 'Optional environment variable containing the generic webhook secret')
            [CompletionResult]::new('--pagerduty-routing-key-env', '--pagerduty-routing-key-env', [CompletionResultType]::ParameterName, 'Environment variable containing the PagerDuty routing key')
            [CompletionResult]::new('--pagerduty-severity', '--pagerduty-severity', [CompletionResultType]::ParameterName, 'PagerDuty severity to render')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;fleet;help' {
            [CompletionResult]::new('init', 'init', [CompletionResultType]::ParameterValue, 'Initialize the local fleet ledger for this workspace')
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Create a run from a task spec and start the foreground manager loop')
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List durable Fleet runs from this workspace''s ledger')
            [CompletionResult]::new('status', 'status', [CompletionResultType]::ParameterValue, 'Show queued/running/completed/failed/stale fleet counts')
            [CompletionResult]::new('inspect', 'inspect', [CompletionResultType]::ParameterValue, 'Inspect one worker''s status, heartbeat, latest event, and artifacts')
            [CompletionResult]::new('logs', 'logs', [CompletionResultType]::ParameterValue, 'Print bounded log artifacts for one worker')
            [CompletionResult]::new('artifacts', 'artifacts', [CompletionResultType]::ParameterValue, 'List artifact refs for one worker')
            [CompletionResult]::new('interrupt', 'interrupt', [CompletionResultType]::ParameterValue, 'Interrupt a running worker task and record a terminal cancellation')
            [CompletionResult]::new('restart', 'restart', [CompletionResultType]::ParameterValue, 'Restart the latest task for a worker')
            [CompletionResult]::new('resume', 'resume', [CompletionResultType]::ParameterValue, 'Resume a run from durable ledger state, reconciling orphaned/stale leases')
            [CompletionResult]::new('stop', 'stop', [CompletionResultType]::ParameterValue, 'Stop all queued and running fleet work')
            [CompletionResult]::new('alert-dry-run', 'alert-dry-run', [CompletionResultType]::ParameterValue, 'Render a redacted fleet alert payload without sending it')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;fleet;help;init' {
            break
        }
        'codew;fleet;help;run' {
            break
        }
        'codew;fleet;help;list' {
            break
        }
        'codew;fleet;help;status' {
            break
        }
        'codew;fleet;help;inspect' {
            break
        }
        'codew;fleet;help;logs' {
            break
        }
        'codew;fleet;help;artifacts' {
            break
        }
        'codew;fleet;help;interrupt' {
            break
        }
        'codew;fleet;help;restart' {
            break
        }
        'codew;fleet;help;resume' {
            break
        }
        'codew;fleet;help;stop' {
            break
        }
        'codew;fleet;help;alert-dry-run' {
            break
        }
        'codew;fleet;help;help' {
            break
        }
        'codew;workflow-tool' {
            [CompletionResult]::new('--approval-source', '--approval-source', [CompletionResultType]::ParameterName, 'Authority provenance stamped by the public `workflow run` command')
            [CompletionResult]::new('--input-json', '--input-json', [CompletionResultType]::ParameterName, 'Exact Workflow tool input serialized as one JSON object')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;review' {
            [CompletionResult]::new('--base', '--base', [CompletionResultType]::ParameterName, 'Base ref to diff against (e.g. origin/main)')
            [CompletionResult]::new('--path', '--path', [CompletionResultType]::ParameterName, 'Limit diff to a specific path')
            [CompletionResult]::new('--model', '--model', [CompletionResultType]::ParameterName, 'Override model for this review')
            [CompletionResult]::new('--max-chars', '--max-chars', [CompletionResultType]::ParameterName, 'Maximum diff characters to include')
            [CompletionResult]::new('--receipt-path', '--receipt-path', [CompletionResultType]::ParameterName, 'Override where the review receipt is written or read')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--staged', '--staged', [CompletionResultType]::ParameterName, 'Review staged changes instead of the working tree')
            [CompletionResult]::new('--write-receipt', '--write-receipt', [CompletionResultType]::ParameterName, 'Write a durable pre-push review receipt after a successful review')
            [CompletionResult]::new('--check-receipt', '--check-receipt', [CompletionResultType]::ParameterName, 'Validate the current diff against a durable review receipt without calling a model')
            [CompletionResult]::new('--json', '--json', [CompletionResultType]::ParameterName, 'Emit machine-readable JSON output')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;pr' {
            [CompletionResult]::new('-R', '-R ', [CompletionResultType]::ParameterName, 'Repository in `owner/name` form. Defaults to the current workspace''s `gh` config (i.e. the repo gh thinks you''re in)')
            [CompletionResult]::new('--repo', '--repo', [CompletionResultType]::ParameterName, 'Repository in `owner/name` form. Defaults to the current workspace''s `gh` config (i.e. the repo gh thinks you''re in)')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--checkout', '--checkout', [CompletionResultType]::ParameterName, 'Skip `gh pr checkout` even if gh is available. By default the working tree is left as-is — checkout is opt-in via `--checkout` because dirty trees fail it loudly')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;apply' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;eval' {
            [CompletionResult]::new('--fail-step', '--fail-step', [CompletionResultType]::ParameterName, 'Intentionally fail a specific step (list, read, search, edit, patch, shell)')
            [CompletionResult]::new('--shell-command', '--shell-command', [CompletionResultType]::ParameterName, 'Shell command to run during the exec step')
            [CompletionResult]::new('--shell-expect-token', '--shell-expect-token', [CompletionResultType]::ParameterName, 'Token that must appear in shell output for validation')
            [CompletionResult]::new('--max-output-chars', '--max-output-chars', [CompletionResultType]::ParameterName, 'Maximum characters stored per step output summary')
            [CompletionResult]::new('--record', '--record', [CompletionResultType]::ParameterName, 'Append one JSONL fixture line per step to `<DIR>/<scenario>.jsonl`. Mock LLM tests can later replay these fixtures')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--json', '--json', [CompletionResultType]::ParameterName, 'Emit machine-readable JSON output')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;scorecard' {
            [CompletionResult]::new('--input', '--input', [CompletionResultType]::ParameterName, 'JSON file with the recorded turns to score: an array of `{ "turn_id", "provider", "model", "billing_surface", "usage": {…} }`. `turn_end` hooks emit this route provenance plus `created_at`; persisted runtime exports may instead use `id`, `effective_provider`, `effective_model`, and `effective_billing_surface`. Shell-only hook rows marked `model_backed: false` are excluded. Legacy rows without provider remain readable but their cost is unavailable')
            [CompletionResult]::new('--baseline', '--baseline', [CompletionResultType]::ParameterName, 'Optional baseline scorecard-metrics JSON to compare against. When set, the command exits non-zero if any metric regresses past the threshold')
            [CompletionResult]::new('--threshold', '--threshold', [CompletionResultType]::ParameterName, 'Regression threshold, in percent increase over the baseline')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--json', '--json', [CompletionResultType]::ParameterName, 'Emit machine-readable JSON instead of the human summary')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;mcp' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List configured MCP servers')
            [CompletionResult]::new('init', 'init', [CompletionResultType]::ParameterValue, 'Create a template MCP config at the configured path')
            [CompletionResult]::new('connect', 'connect', [CompletionResultType]::ParameterValue, 'Connect to MCP servers and report status')
            [CompletionResult]::new('tools', 'tools', [CompletionResultType]::ParameterValue, 'List tools discovered from MCP servers')
            [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add an MCP server entry')
            [CompletionResult]::new('login', 'login', [CompletionResultType]::ParameterValue, 'Authenticate to a URL-based MCP server using OAuth')
            [CompletionResult]::new('logout', 'logout', [CompletionResultType]::ParameterValue, 'Delete stored OAuth credentials for a URL-based MCP server')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Remove an MCP server entry')
            [CompletionResult]::new('enable', 'enable', [CompletionResultType]::ParameterValue, 'Enable an MCP server')
            [CompletionResult]::new('disable', 'disable', [CompletionResultType]::ParameterValue, 'Disable an MCP server')
            [CompletionResult]::new('validate', 'validate', [CompletionResultType]::ParameterValue, 'Validate MCP config and required servers')
            [CompletionResult]::new('add-self', 'add-self', [CompletionResultType]::ParameterValue, 'Register this Codewhale binary as a local MCP stdio server')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;mcp;list' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;mcp;init' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--force', '--force', [CompletionResultType]::ParameterName, 'Overwrite an existing MCP config file')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;mcp;connect' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;mcp;tools' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;mcp;add' {
            [CompletionResult]::new('--command', '--command', [CompletionResultType]::ParameterName, 'Command to launch stdio server')
            [CompletionResult]::new('--url', '--url', [CompletionResultType]::ParameterName, 'URL for streamable HTTP/SSE server')
            [CompletionResult]::new('--transport', '--transport', [CompletionResultType]::ParameterName, 'Explicit URL transport override. Use "sse" for legacy SSE endpoints')
            [CompletionResult]::new('--bearer-token-env-var', '--bearer-token-env-var', [CompletionResultType]::ParameterName, 'Environment variable containing a bearer token for URL-based servers')
            [CompletionResult]::new('--oauth-client-id', '--oauth-client-id', [CompletionResultType]::ParameterName, 'OAuth client ID for servers that do not support dynamic registration')
            [CompletionResult]::new('--oauth-resource', '--oauth-resource', [CompletionResultType]::ParameterName, 'OAuth resource parameter to append to the authorization URL')
            [CompletionResult]::new('--scope', '--scope', [CompletionResultType]::ParameterName, 'OAuth scope to request during login. Repeat or comma-separate')
            [CompletionResult]::new('--arg', '--arg', [CompletionResultType]::ParameterName, 'Arguments for command-based servers')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;mcp;login' {
            [CompletionResult]::new('--scope', '--scope', [CompletionResultType]::ParameterName, 'OAuth scope to request. Repeat or comma-separate; defaults to config/discovery')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;mcp;logout' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;mcp;remove' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;mcp;enable' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;mcp;disable' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;mcp;validate' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;mcp;add-self' {
            [CompletionResult]::new('--name', '--name', [CompletionResultType]::ParameterName, 'Server name in mcp.json (default: "codewhale")')
            [CompletionResult]::new('--workspace', '--workspace', [CompletionResultType]::ParameterName, 'Workspace directory for the MCP server')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'codew;mcp;help' {
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List configured MCP servers')
            [CompletionResult]::new('init', 'init', [CompletionResultType]::ParameterValue, 'Create a template MCP config at the configured path')
            [CompletionResult]::new('connect', 'connect', [CompletionResultType]::ParameterValue, 'Connect to MCP servers and report status')
            [CompletionResult]::new('tools', 'tools', [CompletionResultType]::ParameterValue, 'List tools discovered from MCP servers')
            [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add an MCP server entry')
            [CompletionResult]::new('login', 'login', [CompletionResultType]::ParameterValue, 'Authenticate to a URL-based MCP server using OAuth')
            [CompletionResult]::new('logout', 'logout', [CompletionResultType]::ParameterValue, 'Delete stored OAuth credentials for a URL-based MCP server')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Remove an MCP server entry')
            [CompletionResult]::new('enable', 'enable', [CompletionResultType]::ParameterValue, 'Enable an MCP server')
            [CompletionResult]::new('disable', 'disable', [CompletionResultType]::ParameterValue, 'Disable an MCP server')
            [CompletionResult]::new('validate', 'validate', [CompletionResultType]::ParameterValue, 'Validate MCP config and required servers')
            [CompletionResult]::new('add-self', 'add-self', [CompletionResultType]::ParameterValue, 'Register this Codewhale binary as a local MCP stdio server')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;mcp;help;list' {
            break
        }
        'codew;mcp;help;init' {
            break
        }
        'codew;mcp;help;connect' {
            break
        }
        'codew;mcp;help;tools' {
            break
        }
        'codew;mcp;help;add' {
            break
        }
        'codew;mcp;help;login' {
            break
        }
        'codew;mcp;help;logout' {
            break
        }
        'codew;mcp;help;remove' {
            break
        }
        'codew;mcp;help;enable' {
            break
        }
        'codew;mcp;help;disable' {
            break
        }
        'codew;mcp;help;validate' {
            break
        }
        'codew;mcp;help;add-self' {
            break
        }
        'codew;mcp;help;help' {
            break
        }
        'codew;features' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List known feature flags and their state')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;features;list' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;features;help' {
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List known feature flags and their state')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;features;help;list' {
            break
        }
        'codew;features;help;help' {
            break
        }
        'codew;integrations' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('dsh', 'dsh', [CompletionResultType]::ParameterValue, 'Official DeepSeek Harness (`dsh`) connected through Codewhale')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;integrations;dsh' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('status', 'status', [CompletionResultType]::ParameterValue, 'Detect dsh and report the integration state without writing anything')
            [CompletionResult]::new('plan', 'plan', [CompletionResultType]::ParameterValue, 'Show exactly what `connect`/`update` would write, without writing it')
            [CompletionResult]::new('connect', 'connect', [CompletionResultType]::ParameterValue, 'Write the overlay and receipt under $CODEWHALE_HOME/integrations/dsh')
            [CompletionResult]::new('update', 'update', [CompletionResultType]::ParameterValue, 'Re-derive the overlay from the current Codewhale route')
            [CompletionResult]::new('launch', 'launch', [CompletionResultType]::ParameterValue, 'Run dsh with the Codewhale overlay; extra args go to the dsh app')
            [CompletionResult]::new('disable', 'disable', [CompletionResultType]::ParameterValue, 'Keep the overlay but refuse launches')
            [CompletionResult]::new('enable', 'enable', [CompletionResultType]::ParameterValue, 'Allow launches again')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Delete Codewhale-owned files only; $DSH_HOME is never touched')
            [CompletionResult]::new('install-bundle', 'install-bundle', [CompletionResultType]::ParameterValue, 'Documented DSH plugin path: install the Codewhale bundle into a dedicated `codewhale` DSH profile via `dsh plugin add` (pnpm required)')
            [CompletionResult]::new('remove-bundle', 'remove-bundle', [CompletionResultType]::ParameterValue, '`dsh plugin --profile codewhale remove codewhale-dsh-bundle`, then delete only Codewhale-owned bundle files')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;integrations;dsh;status' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--json', '--json', [CompletionResultType]::ParameterName, 'Emit machine-readable JSON')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;integrations;dsh;plan' {
            [CompletionResult]::new('--profile', '--profile', [CompletionResultType]::ParameterName, 'DSH profile the overlay targets (`web` or `headless`)')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--json', '--json', [CompletionResultType]::ParameterName, 'json')
            [CompletionResult]::new('--allow-full-access', '--allow-full-access', [CompletionResultType]::ParameterName, 'Mirror Codewhale full access as DSH danger-full-access (only when Codewhale itself runs with full access)')
            [CompletionResult]::new('--skin', '--skin', [CompletionResultType]::ParameterName, 'Record the Codewhale palette (skin) decision for the bundle profile; applied via DSH''s `overrideTokens`, never through the overlay')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;integrations;dsh;connect' {
            [CompletionResult]::new('--profile', '--profile', [CompletionResultType]::ParameterName, 'profile')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--allow-full-access', '--allow-full-access', [CompletionResultType]::ParameterName, 'allow-full-access')
            [CompletionResult]::new('--skin', '--skin', [CompletionResultType]::ParameterName, 'skin')
            [CompletionResult]::new('--yes', '--yes', [CompletionResultType]::ParameterName, 'Confirm the disclosed plan without an interactive prompt (required when stdin is not a terminal)')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;integrations;dsh;update' {
            [CompletionResult]::new('--profile', '--profile', [CompletionResultType]::ParameterName, 'profile')
            [CompletionResult]::new('--skin', '--skin', [CompletionResultType]::ParameterName, 'Turn the bundle-profile skin on/off (`--skin false`; defaults to the previous choice)')
            [CompletionResult]::new('--ocean', '--ocean', [CompletionResultType]::ParameterName, 'Turn the ambient ocean scene behind the DSH web UI on/off (`--ocean false`; defaults to the previous choice, initially on; needs the skin)')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--allow-full-access', '--allow-full-access', [CompletionResultType]::ParameterName, 'allow-full-access')
            [CompletionResult]::new('--yes', '--yes', [CompletionResultType]::ParameterName, 'yes')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;integrations;dsh;launch' {
            [CompletionResult]::new('--profile', '--profile', [CompletionResultType]::ParameterName, 'Override the recorded profile (`web` or `headless`)')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Print the exact command instead of running it')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;integrations;dsh;disable' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;integrations;dsh;enable' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;integrations;dsh;remove' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--yes', '--yes', [CompletionResultType]::ParameterName, 'yes')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;integrations;dsh;install-bundle' {
            [CompletionResult]::new('--app', '--app', [CompletionResultType]::ParameterName, 'Which shipped DSH app the dedicated profile boots (`web` or `headless`)')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--yes', '--yes', [CompletionResultType]::ParameterName, 'yes')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;integrations;dsh;remove-bundle' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--yes', '--yes', [CompletionResultType]::ParameterName, 'yes')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;integrations;dsh;help' {
            [CompletionResult]::new('status', 'status', [CompletionResultType]::ParameterValue, 'Detect dsh and report the integration state without writing anything')
            [CompletionResult]::new('plan', 'plan', [CompletionResultType]::ParameterValue, 'Show exactly what `connect`/`update` would write, without writing it')
            [CompletionResult]::new('connect', 'connect', [CompletionResultType]::ParameterValue, 'Write the overlay and receipt under $CODEWHALE_HOME/integrations/dsh')
            [CompletionResult]::new('update', 'update', [CompletionResultType]::ParameterValue, 'Re-derive the overlay from the current Codewhale route')
            [CompletionResult]::new('launch', 'launch', [CompletionResultType]::ParameterValue, 'Run dsh with the Codewhale overlay; extra args go to the dsh app')
            [CompletionResult]::new('disable', 'disable', [CompletionResultType]::ParameterValue, 'Keep the overlay but refuse launches')
            [CompletionResult]::new('enable', 'enable', [CompletionResultType]::ParameterValue, 'Allow launches again')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Delete Codewhale-owned files only; $DSH_HOME is never touched')
            [CompletionResult]::new('install-bundle', 'install-bundle', [CompletionResultType]::ParameterValue, 'Documented DSH plugin path: install the Codewhale bundle into a dedicated `codewhale` DSH profile via `dsh plugin add` (pnpm required)')
            [CompletionResult]::new('remove-bundle', 'remove-bundle', [CompletionResultType]::ParameterValue, '`dsh plugin --profile codewhale remove codewhale-dsh-bundle`, then delete only Codewhale-owned bundle files')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;integrations;dsh;help;status' {
            break
        }
        'codew;integrations;dsh;help;plan' {
            break
        }
        'codew;integrations;dsh;help;connect' {
            break
        }
        'codew;integrations;dsh;help;update' {
            break
        }
        'codew;integrations;dsh;help;launch' {
            break
        }
        'codew;integrations;dsh;help;disable' {
            break
        }
        'codew;integrations;dsh;help;enable' {
            break
        }
        'codew;integrations;dsh;help;remove' {
            break
        }
        'codew;integrations;dsh;help;install-bundle' {
            break
        }
        'codew;integrations;dsh;help;remove-bundle' {
            break
        }
        'codew;integrations;dsh;help;help' {
            break
        }
        'codew;integrations;help' {
            [CompletionResult]::new('dsh', 'dsh', [CompletionResultType]::ParameterValue, 'Official DeepSeek Harness (`dsh`) connected through Codewhale')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;integrations;help;dsh' {
            [CompletionResult]::new('status', 'status', [CompletionResultType]::ParameterValue, 'Detect dsh and report the integration state without writing anything')
            [CompletionResult]::new('plan', 'plan', [CompletionResultType]::ParameterValue, 'Show exactly what `connect`/`update` would write, without writing it')
            [CompletionResult]::new('connect', 'connect', [CompletionResultType]::ParameterValue, 'Write the overlay and receipt under $CODEWHALE_HOME/integrations/dsh')
            [CompletionResult]::new('update', 'update', [CompletionResultType]::ParameterValue, 'Re-derive the overlay from the current Codewhale route')
            [CompletionResult]::new('launch', 'launch', [CompletionResultType]::ParameterValue, 'Run dsh with the Codewhale overlay; extra args go to the dsh app')
            [CompletionResult]::new('disable', 'disable', [CompletionResultType]::ParameterValue, 'Keep the overlay but refuse launches')
            [CompletionResult]::new('enable', 'enable', [CompletionResultType]::ParameterValue, 'Allow launches again')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Delete Codewhale-owned files only; $DSH_HOME is never touched')
            [CompletionResult]::new('install-bundle', 'install-bundle', [CompletionResultType]::ParameterValue, 'Documented DSH plugin path: install the Codewhale bundle into a dedicated `codewhale` DSH profile via `dsh plugin add` (pnpm required)')
            [CompletionResult]::new('remove-bundle', 'remove-bundle', [CompletionResultType]::ParameterValue, '`dsh plugin --profile codewhale remove codewhale-dsh-bundle`, then delete only Codewhale-owned bundle files')
            break
        }
        'codew;integrations;help;dsh;status' {
            break
        }
        'codew;integrations;help;dsh;plan' {
            break
        }
        'codew;integrations;help;dsh;connect' {
            break
        }
        'codew;integrations;help;dsh;update' {
            break
        }
        'codew;integrations;help;dsh;launch' {
            break
        }
        'codew;integrations;help;dsh;disable' {
            break
        }
        'codew;integrations;help;dsh;enable' {
            break
        }
        'codew;integrations;help;dsh;remove' {
            break
        }
        'codew;integrations;help;dsh;install-bundle' {
            break
        }
        'codew;integrations;help;dsh;remove-bundle' {
            break
        }
        'codew;integrations;help;help' {
            break
        }
        'codew;sandbox' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Run a command with sandboxing')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;sandbox;run' {
            [CompletionResult]::new('--policy', '--policy', [CompletionResultType]::ParameterName, 'Sandbox policy (danger-full-access, read-only, external-sandbox, workspace-write)')
            [CompletionResult]::new('--writable-root', '--writable-root', [CompletionResultType]::ParameterName, 'Additional writable roots (repeatable)')
            [CompletionResult]::new('--cwd', '--cwd', [CompletionResultType]::ParameterName, 'Command working directory')
            [CompletionResult]::new('--timeout-ms', '--timeout-ms', [CompletionResultType]::ParameterName, 'Timeout in milliseconds')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--network', '--network', [CompletionResultType]::ParameterName, 'Allow outbound network access')
            [CompletionResult]::new('--exclude-tmpdir', '--exclude-tmpdir', [CompletionResultType]::ParameterName, 'Exclude TMPDIR from writable paths')
            [CompletionResult]::new('--exclude-slash-tmp', '--exclude-slash-tmp', [CompletionResultType]::ParameterName, 'Exclude /tmp from writable paths')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;sandbox;help' {
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Run a command with sandboxing')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;sandbox;help;run' {
            break
        }
        'codew;sandbox;help;help' {
            break
        }
        'codew;serve' {
            [CompletionResult]::new('--host', '--host', [CompletionResultType]::ParameterName, 'Bind host for HTTP server (default localhost; --mobile defaults to 0.0.0.0)')
            [CompletionResult]::new('--port', '--port', [CompletionResultType]::ParameterName, 'Bind port for HTTP server')
            [CompletionResult]::new('--workers', '--workers', [CompletionResultType]::ParameterName, 'Background task worker count (1-8)')
            [CompletionResult]::new('--cors-origin', '--cors-origin', [CompletionResultType]::ParameterName, 'Additional CORS origin to allow (repeatable). Stacks on top of the built-in defaults (localhost:3000, localhost:1420, tauri://localhost). Also reads `CODEWHALE_CORS_ORIGINS` (comma-separated), then `DEEPSEEK_CORS_ORIGINS` as an alias, and `[runtime_api] cors_origins` from `config.toml`. Whalescale#255')
            [CompletionResult]::new('--auth-token', '--auth-token', [CompletionResultType]::ParameterName, 'Require this bearer token for `/v1/*` runtime API routes. Also reads `CODEWHALE_RUNTIME_TOKEN` when omitted, then `DEEPSEEK_RUNTIME_TOKEN` as an alias')
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--mcp', '--mcp', [CompletionResultType]::ParameterName, 'Start MCP server over stdio')
            [CompletionResult]::new('--http', '--http', [CompletionResultType]::ParameterName, 'Start runtime HTTP/SSE API server')
            [CompletionResult]::new('--mobile', '--mobile', [CompletionResultType]::ParameterName, 'Start runtime HTTP/SSE API server with the built-in mobile control page')
            [CompletionResult]::new('--web', '--web', [CompletionResultType]::ParameterName, 'Start the embedded loopback-only browser client and open it')
            [CompletionResult]::new('--qr', '--qr', [CompletionResultType]::ParameterName, 'Show a QR code for the mobile URL in the terminal (requires --mobile)')
            [CompletionResult]::new('--acp', '--acp', [CompletionResultType]::ParameterName, 'Start ACP server over stdio for editor clients such as Zed')
            [CompletionResult]::new('--insecure', '--insecure', [CompletionResultType]::ParameterName, 'Disable runtime API auth when no token is configured. Only use on a trusted loopback')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;resume' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--last', '--last', [CompletionResultType]::ParameterName, 'Continue the most recent session in this workspace without a picker')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;fork' {
            [CompletionResult]::new('--enable', '--enable', [CompletionResultType]::ParameterName, 'Enable a feature (repeatable). Equivalent to `features.<name>=true`')
            [CompletionResult]::new('--disable', '--disable', [CompletionResultType]::ParameterName, 'Disable a feature (repeatable). Equivalent to `features.<name>=false`')
            [CompletionResult]::new('--last', '--last', [CompletionResultType]::ParameterName, 'Fork the most recent session in this workspace without a picker')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'codew;help' {
            [CompletionResult]::new('doctor', 'doctor', [CompletionResultType]::ParameterValue, 'Run system diagnostics and check configuration')
            [CompletionResult]::new('session-diagnostics', 'session-diagnostics', [CompletionResultType]::ParameterValue, 'Summarize failure signals from a local JSONL session log without raw content')
            [CompletionResult]::new('setup', 'setup', [CompletionResultType]::ParameterValue, 'Bootstrap MCP config and/or skills directories')
            [CompletionResult]::new('remote-setup', 'remote-setup', [CompletionResultType]::ParameterValue, 'Generate a remote Codewhale agent deploy bundle (cloud + chat bridge)')
            [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate shell completions')
            [CompletionResult]::new('sessions', 'sessions', [CompletionResultType]::ParameterValue, 'List saved sessions')
            [CompletionResult]::new('init', 'init', [CompletionResultType]::ParameterValue, 'Create default AGENTS.md in current directory')
            [CompletionResult]::new('login', 'login', [CompletionResultType]::ParameterValue, 'Save an API key to the shared user config')
            [CompletionResult]::new('logout', 'logout', [CompletionResultType]::ParameterValue, 'Remove the saved API key')
            [CompletionResult]::new('auth', 'auth', [CompletionResultType]::ParameterValue, 'Manage provider authentication flows')
            [CompletionResult]::new('models', 'models', [CompletionResultType]::ParameterValue, 'List available models from the configured API endpoint')
            [CompletionResult]::new('speech', 'speech', [CompletionResultType]::ParameterValue, 'Generate speech audio with Xiaomi MiMo TTS models')
            [CompletionResult]::new('exec', 'exec', [CompletionResultType]::ParameterValue, 'Run a non-interactive prompt. Use --auto for agent-with-tools mode')
            [CompletionResult]::new('fleet', 'fleet', [CompletionResultType]::ParameterValue, 'Manage local Agent Fleet runs and workers')
            [CompletionResult]::new('workflow-tool', 'workflow-tool', [CompletionResultType]::ParameterValue, 'Internal model-free Workflow tool dispatcher used by Lane Runtime')
            [CompletionResult]::new('review', 'review', [CompletionResultType]::ParameterValue, 'Run a code review over a git diff')
            [CompletionResult]::new('pr', 'pr', [CompletionResultType]::ParameterValue, 'Open the TUI pre-seeded with a GitHub PR''s title, body, and diff')
            [CompletionResult]::new('apply', 'apply', [CompletionResultType]::ParameterValue, 'Apply a patch file (or stdin) to the working tree')
            [CompletionResult]::new('eval', 'eval', [CompletionResultType]::ParameterValue, 'Run the offline evaluation harness (no network/LLM calls)')
            [CompletionResult]::new('scorecard', 'scorecard', [CompletionResultType]::ParameterValue, 'Score a run''s token/cache/cost from recorded turns; flag regressions vs a baseline')
            [CompletionResult]::new('mcp', 'mcp', [CompletionResultType]::ParameterValue, 'Manage MCP servers')
            [CompletionResult]::new('features', 'features', [CompletionResultType]::ParameterValue, 'Inspect feature flags')
            [CompletionResult]::new('integrations', 'integrations', [CompletionResultType]::ParameterValue, 'Connect third-party harnesses through Codewhale (currently: DeepSeek Harness `dsh`)')
            [CompletionResult]::new('sandbox', 'sandbox', [CompletionResultType]::ParameterValue, 'Run a command inside the sandbox')
            [CompletionResult]::new('serve', 'serve', [CompletionResultType]::ParameterValue, 'Run a local server (e.g. MCP)')
            [CompletionResult]::new('resume', 'resume', [CompletionResultType]::ParameterValue, 'Resume a previous session by ID (use --last for most recent)')
            [CompletionResult]::new('fork', 'fork', [CompletionResultType]::ParameterValue, 'Fork a previous session by ID (use --last for most recent)')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'codew;help;doctor' {
            break
        }
        'codew;help;session-diagnostics' {
            break
        }
        'codew;help;setup' {
            break
        }
        'codew;help;remote-setup' {
            break
        }
        'codew;help;completions' {
            break
        }
        'codew;help;sessions' {
            break
        }
        'codew;help;init' {
            break
        }
        'codew;help;login' {
            break
        }
        'codew;help;logout' {
            break
        }
        'codew;help;auth' {
            [CompletionResult]::new('xai-device', 'xai-device', [CompletionResultType]::ParameterValue, 'Sign in to xAI/Grok with an SSH-friendly device code')
            break
        }
        'codew;help;auth;xai-device' {
            break
        }
        'codew;help;models' {
            break
        }
        'codew;help;speech' {
            break
        }
        'codew;help;exec' {
            break
        }
        'codew;help;fleet' {
            [CompletionResult]::new('init', 'init', [CompletionResultType]::ParameterValue, 'Initialize the local fleet ledger for this workspace')
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Create a run from a task spec and start the foreground manager loop')
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List durable Fleet runs from this workspace''s ledger')
            [CompletionResult]::new('status', 'status', [CompletionResultType]::ParameterValue, 'Show queued/running/completed/failed/stale fleet counts')
            [CompletionResult]::new('inspect', 'inspect', [CompletionResultType]::ParameterValue, 'Inspect one worker''s status, heartbeat, latest event, and artifacts')
            [CompletionResult]::new('logs', 'logs', [CompletionResultType]::ParameterValue, 'Print bounded log artifacts for one worker')
            [CompletionResult]::new('artifacts', 'artifacts', [CompletionResultType]::ParameterValue, 'List artifact refs for one worker')
            [CompletionResult]::new('interrupt', 'interrupt', [CompletionResultType]::ParameterValue, 'Interrupt a running worker task and record a terminal cancellation')
            [CompletionResult]::new('restart', 'restart', [CompletionResultType]::ParameterValue, 'Restart the latest task for a worker')
            [CompletionResult]::new('resume', 'resume', [CompletionResultType]::ParameterValue, 'Resume a run from durable ledger state, reconciling orphaned/stale leases')
            [CompletionResult]::new('stop', 'stop', [CompletionResultType]::ParameterValue, 'Stop all queued and running fleet work')
            [CompletionResult]::new('alert-dry-run', 'alert-dry-run', [CompletionResultType]::ParameterValue, 'Render a redacted fleet alert payload without sending it')
            break
        }
        'codew;help;fleet;init' {
            break
        }
        'codew;help;fleet;run' {
            break
        }
        'codew;help;fleet;list' {
            break
        }
        'codew;help;fleet;status' {
            break
        }
        'codew;help;fleet;inspect' {
            break
        }
        'codew;help;fleet;logs' {
            break
        }
        'codew;help;fleet;artifacts' {
            break
        }
        'codew;help;fleet;interrupt' {
            break
        }
        'codew;help;fleet;restart' {
            break
        }
        'codew;help;fleet;resume' {
            break
        }
        'codew;help;fleet;stop' {
            break
        }
        'codew;help;fleet;alert-dry-run' {
            break
        }
        'codew;help;workflow-tool' {
            break
        }
        'codew;help;review' {
            break
        }
        'codew;help;pr' {
            break
        }
        'codew;help;apply' {
            break
        }
        'codew;help;eval' {
            break
        }
        'codew;help;scorecard' {
            break
        }
        'codew;help;mcp' {
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List configured MCP servers')
            [CompletionResult]::new('init', 'init', [CompletionResultType]::ParameterValue, 'Create a template MCP config at the configured path')
            [CompletionResult]::new('connect', 'connect', [CompletionResultType]::ParameterValue, 'Connect to MCP servers and report status')
            [CompletionResult]::new('tools', 'tools', [CompletionResultType]::ParameterValue, 'List tools discovered from MCP servers')
            [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add an MCP server entry')
            [CompletionResult]::new('login', 'login', [CompletionResultType]::ParameterValue, 'Authenticate to a URL-based MCP server using OAuth')
            [CompletionResult]::new('logout', 'logout', [CompletionResultType]::ParameterValue, 'Delete stored OAuth credentials for a URL-based MCP server')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Remove an MCP server entry')
            [CompletionResult]::new('enable', 'enable', [CompletionResultType]::ParameterValue, 'Enable an MCP server')
            [CompletionResult]::new('disable', 'disable', [CompletionResultType]::ParameterValue, 'Disable an MCP server')
            [CompletionResult]::new('validate', 'validate', [CompletionResultType]::ParameterValue, 'Validate MCP config and required servers')
            [CompletionResult]::new('add-self', 'add-self', [CompletionResultType]::ParameterValue, 'Register this Codewhale binary as a local MCP stdio server')
            break
        }
        'codew;help;mcp;list' {
            break
        }
        'codew;help;mcp;init' {
            break
        }
        'codew;help;mcp;connect' {
            break
        }
        'codew;help;mcp;tools' {
            break
        }
        'codew;help;mcp;add' {
            break
        }
        'codew;help;mcp;login' {
            break
        }
        'codew;help;mcp;logout' {
            break
        }
        'codew;help;mcp;remove' {
            break
        }
        'codew;help;mcp;enable' {
            break
        }
        'codew;help;mcp;disable' {
            break
        }
        'codew;help;mcp;validate' {
            break
        }
        'codew;help;mcp;add-self' {
            break
        }
        'codew;help;features' {
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List known feature flags and their state')
            break
        }
        'codew;help;features;list' {
            break
        }
        'codew;help;integrations' {
            [CompletionResult]::new('dsh', 'dsh', [CompletionResultType]::ParameterValue, 'Official DeepSeek Harness (`dsh`) connected through Codewhale')
            break
        }
        'codew;help;integrations;dsh' {
            [CompletionResult]::new('status', 'status', [CompletionResultType]::ParameterValue, 'Detect dsh and report the integration state without writing anything')
            [CompletionResult]::new('plan', 'plan', [CompletionResultType]::ParameterValue, 'Show exactly what `connect`/`update` would write, without writing it')
            [CompletionResult]::new('connect', 'connect', [CompletionResultType]::ParameterValue, 'Write the overlay and receipt under $CODEWHALE_HOME/integrations/dsh')
            [CompletionResult]::new('update', 'update', [CompletionResultType]::ParameterValue, 'Re-derive the overlay from the current Codewhale route')
            [CompletionResult]::new('launch', 'launch', [CompletionResultType]::ParameterValue, 'Run dsh with the Codewhale overlay; extra args go to the dsh app')
            [CompletionResult]::new('disable', 'disable', [CompletionResultType]::ParameterValue, 'Keep the overlay but refuse launches')
            [CompletionResult]::new('enable', 'enable', [CompletionResultType]::ParameterValue, 'Allow launches again')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Delete Codewhale-owned files only; $DSH_HOME is never touched')
            [CompletionResult]::new('install-bundle', 'install-bundle', [CompletionResultType]::ParameterValue, 'Documented DSH plugin path: install the Codewhale bundle into a dedicated `codewhale` DSH profile via `dsh plugin add` (pnpm required)')
            [CompletionResult]::new('remove-bundle', 'remove-bundle', [CompletionResultType]::ParameterValue, '`dsh plugin --profile codewhale remove codewhale-dsh-bundle`, then delete only Codewhale-owned bundle files')
            break
        }
        'codew;help;integrations;dsh;status' {
            break
        }
        'codew;help;integrations;dsh;plan' {
            break
        }
        'codew;help;integrations;dsh;connect' {
            break
        }
        'codew;help;integrations;dsh;update' {
            break
        }
        'codew;help;integrations;dsh;launch' {
            break
        }
        'codew;help;integrations;dsh;disable' {
            break
        }
        'codew;help;integrations;dsh;enable' {
            break
        }
        'codew;help;integrations;dsh;remove' {
            break
        }
        'codew;help;integrations;dsh;install-bundle' {
            break
        }
        'codew;help;integrations;dsh;remove-bundle' {
            break
        }
        'codew;help;sandbox' {
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Run a command with sandboxing')
            break
        }
        'codew;help;sandbox;run' {
            break
        }
        'codew;help;serve' {
            break
        }
        'codew;help;resume' {
            break
        }
        'codew;help;fork' {
            break
        }
        'codew;help;help' {
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
