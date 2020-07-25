mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))
# import config.
# You can change the default config with `make cnf="config_special.env" build`
cnf ?= config.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	echo $(dir $(mkfile_path))
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: base business ## Build All images

nginx: $(base_objs) ## Build docker image nginx
	svc=bash $(current_dir)/script/gen_docker_nginx.sh

base_objs = loader jdk python3
base: $(base_objs) nginx ## Build image centos imagevideo nginx

$(base_objs): 
	svc=$($@) sufix=$@ target=$($@_target) bash $(current_dir)/script/gen_docker_base.sh

business_objs = mvn 
business: $(business_objs)

$(business_objs): ## build $(business_objs)
	svc=$@ target=$($@_target) bash $(current_dir)/script/gen_docker_business.sh

