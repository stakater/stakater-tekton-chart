SHELL := /bin/bash

VERSION ?= 0.0.1

update-version:
	sed -i "s/^version:.*/version: $(VERSION)/" pipeline-charts/Chart.yaml