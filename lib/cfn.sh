#!/usr/bin/env bash
# AWS CloudFormation tasks

#USAGE
cfn_usage(){
  e_error 'USAGE: cfn [COMMAND] [STACK]'
  e_error 'COMMANDS: create | update | delete | validate'
  e_error "STACKS: ${stacks:-}"
  e_abort 'Please consult the README'
}

# Process CloudFormation arguments
cfn_process(){
  local action stack
  action=${1:-}
  stack=${2:-}

  get_cfn_defaults "$stack"

  case "$action" in
    create)
      cfn_validate_stack
      cfn_create_stack
      cfn_wait_for_stack
      ;;
    update)
      cfn_validate_stack
      cfn_update_stack
      cfn_wait_for_stack
      ;;
    delete)
      cfn_delete_stack
      cfn_wait_for_stack
      ;;
    validate)
      cfn_validate_stack
      ;;
    *)
      cfn_usage
      ;;
  esac
  unset stack stacks name body A P T cfn_cmd
}

# Creates a new stack
cfn_create_stack(){
  e_info 'Creating stack'
  eval "aws cloudformation create-stack ${cfn_cmd:-}"
}

# Update an existing stack
cfn_update_stack(){
  e_info 'Updating stack'
  eval "aws cloudformation update-stack ${cfn_cmd:-}"
}

# Deletes an existing stack
cfn_delete_stack(){
  e_warn "Deleting stack ${name:-}"
  eval "aws cloudformation delete-stack --stack-name ${name:-}"
}

# Validate stack
cfn_validate_stack(){
  e_info "Validating ${body:-}"
  aws cloudformation validate-template \
    --output table \
    --template-body "file://${body:-}"
}

# Wait for stack to finish
cfn_wait_for_stack(){
  if ! vgs_aws_cfn_wait "${name:-}"; then
    e_abort "FATAL: The stack ${name:-} failed"
  fi
}
