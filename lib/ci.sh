#!/usr/bin/env bash
# Continuous Integration / Continuous Deployment tasks

# CI Install
ci_install(){
  echo 'Install VGS library'
  git clone https://github.com/vghn/vgs.git ~/vgs

  # Load VGS library (https://github.com/vghn/vgs)
  echo 'Reload VGS library'
  # shellcheck disable=1090
  . ~/vgs/load 2>/dev/null || true

  echo 'Install AWS-CLI'
  pip install --user --upgrade awscli

  if [ "$TRAVIS_PULL_REQUEST" = 'false' ]; then
    echo 'Download .env'
    download_env
  fi
}

# CI Test
ci_test(){
  e_info 'Nothing yet'
}

# CI Deploy
ci_deploy(){
  e_info 'Nothing yet'
}
