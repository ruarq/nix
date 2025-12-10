.PHONY: rebuild-% build-% check-% list-hosts

rebuild-%-no-commit:
	@cd hosts/$* && sudo nixos-rebuild switch --flake ".#$*"

rebuild-%:
	@cd hosts/$* && sudo nixos-rebuild switch --flake ".#$*"
	@git commit -a

build-%:
	@cd hosts/$* && sudo nixos-rebuild build --flake ".#$*" 

check-%:
	@cd hosts/$* && nix flake check

list-hosts:
	@ls hosts/
