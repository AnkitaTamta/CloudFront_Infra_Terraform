# Makefile to kickoff terraform.
# ####################################################
#
STATEBUCKET = $(STATEBUCKETNAME)
STATELOCKTABLE = $(STATELOCKTABLENAME)
STATEKEY = terraform.tfstate
STATEREGION = us-east-1

# # Before we start test that we have the mandatory executables available
	EXECUTABLES = git terraform
	K := $(foreach exec,$(EXECUTABLES),\
		$(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH, consider apt-get install $(exec)")))


.PHONY: plan

first-run:
	@echo "initialize remote state file"
	cd services/$(SERVICE) && \
    terraform init -backend-config="bucket=$(STATEBUCKET)" -backend-config="key=$(STATEKEY)" -backend-config="dynamodb_table=$(STATELOCKTABLE)" -backend-config="region=$(STATEREGION)"  
    
init:
	@echo "initialize remote state file"
	cd services/$(SERVICE) && \
	terraform workspace select $(WORKSPACE) || terraform workspace new $(WORKSPACE) && \
	terraform init --force-copy -backend-config="bucket=$(STATEBUCKET)" -backend-config="key=$(STATEKEY)" -backend-config="dynamodb_table=$(STATELOCKTABLE)" -backend-config="region=$(STATEREGION)"

validate: init
	@echo "running terraform validate"
	cd services/$(SERVICE) && \
	terraform validate -no-color

plan: validate
	@echo "running terraform plan"
	cd services/$(SERVICE) && \
	terraform plan -no-color

 apply: plan
	@echo "running terraform apply"
	cd services/$(SERVICE) && \
	terraform apply -auto-approve -no-color

plan-destroy: validate
	@echo "running terraform plan -destroy"
	cd services/$(SERVICE) && \
	terraform plan -destroy -no-color

destroy: init
	@echo "running terraform destroy"
	cd services/$(SERVICE) && \
	terraform destroy -force -no-color