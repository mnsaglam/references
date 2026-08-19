.PHONY: setup install-bibtool install-hook

setup: install-bibtool install-hook

install-bibtool:
	@if command -v bibtool >/dev/null 2>&1; then \
		echo "BibTool is already installed."; \
	elif [ "$$(uname -s)" = "Darwin" ]; then \
		if ! command -v brew >/dev/null 2>&1; then \
			echo "Homebrew is required to install BibTool on macOS." >&2; \
			exit 1; \
		fi; \
		brew install bib-tool; \
	elif command -v apt-get >/dev/null 2>&1; then \
		sudo apt-get install -y bibtool; \
	else \
		echo "Install BibTool, then rerun 'make setup'." >&2; \
		exit 1; \
	fi

install-hook:
	@hooks_dir="$$(git rev-parse --git-path hooks)"; \
		mkdir -p "$$hooks_dir"; \
		ln -sf "$$(pwd)/pre-commit" "$$hooks_dir/pre-commit"; \
		echo "Installed pre-commit hook in $$hooks_dir."
