SHELL := /bin/bash

VERSION ?= 0.0.1

update-chart-version:
	sed -i "s/^version:.*/version: $(VERSION)/" stakater-tekton-chart/Chart.yaml