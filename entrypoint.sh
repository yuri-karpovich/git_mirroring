set -e -o pipefail
set -x

WORK_PATH=/repos
REPO_PATH="$WORK_PATH/$REPO_DIR_NAME"
SSH_PATH=/root/ssh
NEW_SSH_PATH=/root/new_ssh

if [[ ! -z "${FIRST_PULL_INTERVAL}" ]]
then
  echo "Wait $FIRST_PULL_INTERVAL seconds"
  sleep "$FIRST_PULL_INTERVAL"
fi


if [ -d "$SSH_PATH" ]
then
  if [ ! -f "$SSH_PATH/id_rsa" ]
  then
    echo "Cannot find $SSH_PATH/id_rsa"
    exit 1
  fi

    echo "Copying keys from $SSH_PATH to $NEW_SSH_PATH"
    rm -rf $NEW_SSH_PATH
    cp -R $SSH_PATH $NEW_SSH_PATH
    echo "Setting 600 permissions mode for $NEW_SSH_PATH"
    chmod 600 -R $NEW_SSH_PATH
    echo "Enabling ssh-agent"
    eval `ssh-agent -s`
    ssh-add "$NEW_SSH_PATH/id"
else
    echo "SSH file was not found"
fi

mkdir -p "$WORK_PATH"
while ( true ); do
  if [ -d "$REPO_PATH" ]
  then
      cd "$REPO_PATH" || exit
      echo "Update $REPO_PATH"
      git remote update --prune
  else
      cd "$WORK_PATH" || exit
      echo "Clone $REPO_PATH"
      git clone --mirror "$REPO_URL" "$REPO_PATH"
  fi
  echo "Sleeping $INTERVAL"
  sleep "$INTERVAL"
done