.PHONY: rebuild-% list-hosts

rebuild-%:
	@cd hosts/$* && sudo nixos-rebuild switch --flake .

list-hosts:
	@ls hosts/
