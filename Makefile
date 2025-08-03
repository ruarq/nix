.PHONY: rebuild-% build-% list-hosts

rebuild-%:
	@cd hosts/$* && sudo nixos-rebuild switch --flake .

build-%:
	@cd hosts/$* && sudo nixos-rebuild build --flake .

list-hosts:
	@ls hosts/
