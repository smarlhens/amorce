.PHONY: test test-role

# Run tests for all roles
test:
	@echo "Running molecule tests for all roles..."
	@for role in roles/*; do \
		if [ -d "$$role/molecule" ]; then \
			echo "\n=== Testing $$(basename $$role) ==="; \
			(cd $$role && molecule test) || exit 1; \
		else \
			echo "\n=== Skipping $$(basename $$role) (no molecule directory) ==="; \
		fi; \
	done

# Run tests for a specific role
test-role:
	@if [ -z "$(ROLE)" ]; then \
		echo "Error: ROLE parameter is required. Usage: make test-role ROLE=role_name"; \
		exit 1; \
	fi
	@if [ ! -d "roles/$(ROLE)" ]; then \
		echo "Error: Role '$(ROLE)' not found in roles directory"; \
		exit 1; \
	fi
	@echo "Running molecule tests for role $(ROLE)..."
	@cd roles/$(ROLE) && molecule test
