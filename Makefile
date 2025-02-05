.PHONY: help
help: ## Show this help
	@DESCRIPTION_WIDTH=$$(grep -Eh '^[a-zA-Z0-9\._-]+:.*?##' $(MAKEFILE_LIST) | \
		awk -F ':.*?##' '{ if (length($$1) > max) max = length($$1) } END { print max }'); \
	grep -Eh '^[a-zA-Z0-9\._-]+:.*?##' $(MAKEFILE_LIST) | \
	awk -v width=$$DESCRIPTION_WIDTH 'BEGIN { FS = ":.*?##" } { printf "\033[36m%-" width "s\033[0m %s\n", $$1, $$2 }'

setup: ## Setup the project
	@lefthook install

formatter-check: ## Check formatting
	@prettier --check .

formatter-fix: ## Fix formatting
	@prettier --write .

spellchecker-check: ## Check spelling
	@typos ./

NOTE_DIRS=./daily ./source ./knowledge
sync-notes: setup ## Sync notes
	@git add $(NOTE_DIRS) && \
	git commit $(NOTE_DIRS) -m "sync: update notes $$(date '+%Y-%m-%d %H:%M:%S')" || true && \
	git push origin HEAD
