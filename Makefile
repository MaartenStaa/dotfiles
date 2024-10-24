include Makefile.d/defaults.mk

help:
	@FILE=Makefile ./Makefile.d/generate-makefile-help
.PHONY: help

## @section Installation

## Rebuild with nix-darwin, then switch
## @param MACHINE_NAME=work-mbp The name of the machine to build for
switch:
switch: rebuild commit
switch:
	darwin-rebuild switch --flake .#$$MACHINE_NAME
.PHONY: switch

## Upgrade the system (update, commit, switch)
## @param MACHINE_NAME=work-mbp The name of the machine to build for
upgrade:
upgrade: update switch
.PHONY: upgrade

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
	--profile /nix/var/nix/profiles/system

	nix store gc

	nix store optimise
.PHONY: collect-garbage

## Update the flake inputs
update:
update: is_clean
	nix flake update
.PHONY: update

is_clean:
	@if test -n "$$(git status --porcelain)"; then echo "The repository is not clean. First commit or stash your prior changes."; exit 2; fi
.PHONY: is_clean


commit: template := $(shell mktemp)
commit: rebuild prompt
	printf "Upgrade\n\n" > $(template)
	nix store diff-closures \
		/nix/var/nix/profiles/system \
		./result \
	| ansifilter \
	>> $(template)
	git add .
	git commit --file=$(template) --edit

	echo "NOTE: The commit has not been pushed. Enter 'git push' to do it."
.PHONY: commit


prompt:
	@
	echo "Here is the summary of channges:"
	echo
	nix store diff-closures  /nix/var/nix/profiles/system ./result
	echo
	read -p "Do you want to continue? [y/N] " answer
	if [ "$${answer}" != "y" ]
	then
		echo "Aborting."
		exit 1
	fi
.PHONY: prompt

## Rebuild the system without switching
rebuild:
rebuild: result
.PHONY: rebuild


result: $(shell find . -iname '*.nix')
result: flake.lock
	# TODO: Pass as input
	darwin-rebuild build --flake .#work-mbp

# end
