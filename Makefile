TYPST   = typst
TOML    = typst.toml
DOCS    = docs/changelog.typ

.PHONY: changelog

changelog:
	@VERSION=$$(grep -oE 'version = "[^"]+"' $(TOML) | grep -oE '[0-9]+\.[0-9]+\.[0-9]+'); \
	SINCE=$$(git log --format='%H' -- $(TOML) | while read h; do \
		v=$$(git show "$${h}:$(TOML)" 2>/dev/null | grep -oE 'version = "[^"]+"' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+'); \
		[ "$$v" != "$$VERSION" ] && echo "$$h" && break; \
	done); \
	COMMITS=$$(git log --format='%s' "$${SINCE}..HEAD" | grep -E '^(feat|fix)' | tr '\n' '|'); \
	echo "Version: $$VERSION, since: $$SINCE"; \
	$(TYPST) compile $(DOCS) \
		--input version="$$VERSION" \
		--input commits="$$COMMITS"
