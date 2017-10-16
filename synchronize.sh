#!/bin/bash
for GROUP_DIR in `find . -maxdepth 1 -type d  | grep -F ./ | grep -v -F ./.`
do
  echo "Processing drectory $GROUP_DIR"
  cd $GROUP_DIR
  if [ -f ssh_key ]; then
    chmod 600 ssh_key
  fi
  for REPO_DIR in `find . -maxdepth 1 -type d  | grep -F ./ | grep -v -F ./.`
  do
      echo "Processing repository $GROUP_DIR/$REPO_DIR"
      cd $REPO_DIR
      echo "Fetch data from Gitlab"
      git fetch --progress origin
      git remote prune origin
      echo "Push data to Codebase/UDC"
      export GIT_SSH_COMMAND="ssh -oStrictHostKeyChecking=no -i ../ssh_key -F /dev/null"
      git push --progress target
      cd ..
  done
  cd ..
done
