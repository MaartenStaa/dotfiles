# Default settings for Make

# Always use strict bash
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.ONESHELL:

# If a recipe fails, delete it's targets to avoid broken state
.DELETE_ON_ERROR:

# Allow $$(variables) to be expanded in a second pass
.SECONDEXPANSION:

# Warn about undefined variables and
# TODO: How to make it an error, like in bash strict mode?
# TODO: Consider https://www.artificialworlds.net/blog/2015/04/22/treat-warnings-as-errors-in-a-gnu-makefile/
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --warn-undefined-functions

# Remove implicit rules - no magic please
# See https://www.gnu.org/software/make/manual/html_node/Catalogue-of-Rules.html
MAKEFLAGS += --no-builtin-rules

# Helper functions

define slugify
$(shell \
	echo $(1) \
		| tr '[:upper:]' '[:lower:]' \
		| tr --squeeze-repeats --complement '[:alnum:]\n' '-' \
)
endef

# General purpose variables

author = $(shell git config user.name)

timestamp = $(shell date '+%s')

