{ pkgs, lib, config, ... }:

{
  env = {
    PROJECT_NAME = "openspec-llm-agent";
  };

  packages = with pkgs; [
    git
    curl
  ];

  languages.python = {
    enable = true;
    version = "3.12";
    venv.enable = true;
    uv = {
      enable = true;
      sync.enable = true;
    };
  };

  scripts = {
    test = {
      exec = ''
        pytest "$@"
      '';
      description = "Run tests with pytest";
    };

    lint = {
      exec = ''
        ruff check src/ tests/
      '';
      description = "Lint code with ruff";
    };

    format = {
      exec = ''
        ruff format src/ tests/
      '';
      description = "Format code with ruff";
    };
  };

  enterShell = ''
    echo "🐍 Python ${config.languages.python.version}"
    echo ""
    echo "Available commands:"
    echo "  test   - Run tests with pytest"
    echo "  lint   - Lint code with ruff"
    echo "  format - Format code with ruff"
    echo ""
    echo "Quick start:"
    echo "  uv sync --all-extras"
    echo "  test"
  '';

  pre-commit.hooks = {
    ruff = {
      enable = true;
    };
    ruff-format = {
      enable = true;
    };
  };
}
