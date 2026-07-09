include Makefile.d/defaults.mk

NIX_DARWIN_PROFILE := /nix/var/nix/profiles/system
HOME_MANAGER_PROFILE := $(HOME)/.local/state/nix/profiles/home-manager

help:
	@FILE=Makefile ./Makefile.d/generate-makefile-help
.PHONY: help

## @section Installation

## Rebuild with nix-darwin, then switch
## @param MACHINE_NAME=work-mbp The name of the machine to build for
switch:
switch: commit-all
switch:
	sudo darwin-rebuild switch --flake .#$$MACHINE_NAME
	home-manager switch --flake .#$$MACHINE_NAME
.PHONY: switch

## Rebuild with home-manager, then switch
## @param MACHINE_NAME=work-mbp The name of the machine to build for
#switch-home-manager:
#switch-home-manager: commit-hm
switch-home-manager:
	home-manager switch --flake .#$$MACHINE_NAME
.PHONY: switch-home-manager

## Upgrade the system (update, commit, switch)
## @param MACHINE_NAME=work-mbp The name of the machine to build for
upgrade:
upgrade: update update-sources switch
.PHONY: upgrade

## Upgrade home-manager (update, commit, switch)
## @param MACHINE_NAME=work-mbp The name of the machine to build for
upgrade-home-manager:
upgrade-home-manager: update update-sources switch-home-manager
.PHONY: upgrade-home-manager

## @section Granular switching

## Rebuild and switch the active nix-darwin configuration
## @param MACHINE_NAME=work-mbp The name of the machine to build for
switch-nix-darwin:
switch-nix-darwin: rebuild-nix-darwin
switch-nix-darwin:
	sudo darwin-rebuild switch --flake .#$$MACHINE_NAME

## @section Utilities

## Check the status of the system without switching
## @param MACHINE_NAME=work-mbp The name of the machine to build for
check:
	darwin-rebuild check --flake .#$$MACHINE_NAME

## @section Maintenance

## Remove old generations and collect garbage
## @param OLDER_THAN=14d The age of the generations to remove
collect-garbage:
collect-garbage: OLDER_THAN ?= 14d
collect-garbage:
	sudo nix profile wipe-history \
	--older-than $(OLDER_THAN) \
	--profile $(NIX_DARWIN_PROFILE)

	nix profile wipe-history \
	--older-than $(OLDER_THAN) \
	--profile $(HOME_MANAGER_PROFILE)

	nix store gc

	nix store optimise
.PHONY: collect-garbage

## Update ad-hoc sources
update-sources:
	nix run nixpkgs#nvfetcher
.PHONY: update-sources

## Update the flake inputs
update:
#update: is_clean
	nix flake update
.PHONY: update

is_clean:
	@if test -n "$$(git status --porcelain)"; then echo "The repository is not clean. First commit or stash your prior changes."; exit 2; fi
.PHONY: is_clean


commit-all: template := $(shell mktemp)
commit-all: rebuild-nix-darwin rebuild-home-manager
	@echo "=== nix-darwin changes ==="; echo
	nix store diff-closures $(NIX_DARWIN_PROFILE) ./result-nix-darwin
	@echo; echo "=== home-manager changes ==="; echo
	nix store diff-closures $(HOME_MANAGER_PROFILE) ./result-home-manager
	@echo; read -p "Do you want to continue? [y/N] " answer; \
	if [ "$${answer}" != "y" ]; then echo "Aborting."; exit 1; fi

	printf "chore: upgrade flake inputs\n\n" > $(template)
	printf "nix-darwin:\n\n" >> $(template)
	nix store diff-closures $(NIX_DARWIN_PROFILE) ./result-nix-darwin \
	| ansifilter >> $(template)
	printf "\nhome-manager:\n\n" >> $(template)
	nix store diff-closures $(HOME_MANAGER_PROFILE) ./result-home-manager \
	| ansifilter >> $(template)
	git add flake.lock _sources/
	git commit --file=$(template) --edit

	echo "NOTE: The commit has not been pushed. Enter 'git push' to do it."
.PHONY: commit-all

commit-hm: template := $(shell mktemp)
commit-hm: rebuild-home-manager
	@echo "=== home-manager changes ==="; echo
	nix store diff-closures $(HOME_MANAGER_PROFILE) ./result-home-manager
	@echo; read -p "Do you want to continue? [y/N] " answer; \
	if [ "$${answer}" != "y" ]; then echo "Aborting."; exit 1; fi

	printf "Upgrade home-manager\n\n" > $(template)
	nix store diff-closures $(HOME_MANAGER_PROFILE) ./result-home-manager \
	| ansifilter >> $(template)
	git add flake.lock _sources/
	git commit --file=$(template) --edit

	echo "NOTE: The commit has not been pushed. Enter 'git push' to do it."
.PHONY: commit-hm

## Rebuild the system without switching
rebuild-nix-darwin:
rebuild-nix-darwin: result-nix-darwin
.PHONY: rebuild-nix-darwin


result-nix-darwin: $(shell find . -iname '*.nix')
result-nix-darwin: flake.lock
	darwin-rebuild build --flake ./#$$MACHINE_NAME
	rm -f result-nix-darwin
	mv result result-nix-darwin

## Rebuild the system without switching
rebuild-home-manager:
rebuild-home-manager: result-home-manager
.PHONY: rebuild-home-manager


result-home-manager: $(shell find . -iname '*.nix')
result-home-manager: flake.lock
	home-manager build --flake ./#$$MACHINE_NAME
	rm -f result-home-manager
	mv result result-home-manager
