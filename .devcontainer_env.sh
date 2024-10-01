#!/usr/bin/zsh
set -e

function generate_devcontainer_json() {
  if [[ -f ".devcontainer.json" ]]; then
    echo "Project already has a .devcontainer.json file"
    nvim .devcontainer.json
    exit 0
  fi
  # determine the project type
  if [[ -f "pom.xml" ]]; then
    project_type="maven"
  elif [[ -f "package.json" ]]; then
    project_type="node"
  elif [[ -f "build.gradle" ]]; then
    project_type="gradle"
  elif [[ -f "requirements.txt" ]]; then
    project_type="python"
  elif [[ -f "pyproject.toml" ]]; then
    project_type="python"
  elif [[ -f "go.mod" ]]; then
    project_type="go"
  elif [[ -f "Cargo.toml" ]]; then
    project_type="rust"
  else
    echo "Project type not supported"
    exit 1
  fi

  echo "Project type: ${project_type}, generating .devcontainer.json file"

  # loop through all the files in the .devcontainer-template directory
  for file in ~/.devcontainer-template/*; do
    # if the file name matches current project type
    if [[ $file == *"/${project_type}.json" ]]; then
      # copy the file to the root directory
      cp $file .devcontainer.json
      # replace {{AIO_FEATURE_VERSION}} into variable AIO_FEATURE_VERSION to $file and put it to the .devcontainer.json
      sed -i "s/{{AIO_FEATURE_VERSION}}/${AIO_FEATURE_VERSION}/g" .devcontainer.json
      echo "Devcontainer file generated"
      nvim .devcontainer.json
      echo "Use da command to activate the devcontainer"
      exit 0
    fi
  done

  echo "Generate failed, missing template"
  exit 1
}

generate_devcontainer_json
