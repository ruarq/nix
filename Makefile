.PHONY: rebuild-% build-% check-% list-hosts

rebuild-%:
	@cd hosts/$* && sudo nixos-rebuild switch --flake ".#$*"

build-%:
	@cd hosts/$* && sudo nixos-rebuild build --flake ".#$*" 

check-%:
	@cd hosts/$* && nix flake check

list-hosts:
	@ls hosts/
