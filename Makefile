V=`grep 'TG_VERSION="' Dockerfile | cut -d '"' -f 2`

.PHONY: build
build:
	docker build -t lanxuage/tigergraph:$(V) .
