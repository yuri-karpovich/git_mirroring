# Mirror remote git repos
## Quick Start

### Private repository
For mirroring **private repository** you should mount a directory with `id_rsa` and `id_rsa.pub` files to the `/root/ssh` folder inside a container.

```bash
docker run \
-e REPO_URL=git@github.com:yuri-karpovich/test.git \
-e REPO_DIR_NAME=test \
-e INTERVAL=600 \
-v /your/local/folder:/repos \
-v /you/ssh_keys/folder:/root/ssh \
-it spoonest/git_mirroring:latest
```

where
`-e REPO_URL=git@github.com:yuri-karpovich/test.git` - SSH URL for repo cloning
`-e REPO_DIR_NAME=test` - folder name in `/repos` folder where specified repo will be cloned
`-e INTERVAL=600` - sync interval in seconds
`-v /your/local/folder:/repos` - mont local folder where mirrors will be saved
`-v /you/ssh_keys/folder:/root/ssh` - for mirroring **private repository** you should mount a directory with `id_rsa` and `id_rsa.pub` files to the `/root/ssh` folder inside a container. 

#### docker-compose

#### docker-compose
```yaml
version: "3"
services:
  test_repo:
    image: spoonest/git_mirroring:latest
    environment:
      REPO_URL: git@github.com:yuri-karpovich/test.git
      REPO_DIR_NAME: test
      INTERVAL: 600
    volumes:
      - /your/local/folder:/repos
      - /you/ssh_keys/folder:/root/ssh
```
### Public repository
```bash
docker run \
-e REPO_URL=https://github.com/yuri-karpovich/test.git \
-e REPO_DIR_NAME=test \
-e INTERVAL=600 \
-v /your/local/folder:/repos \
-it spoonest/git_mirroring:latest
```

where
`-e REPO_URL=https://github.com/yuri-karpovich/test.git` - HTTPS URL for repo cloning
`-e REPO_DIR_NAME=test` - folder name in `/repos` folder where specified repo will be cloned
`-e INTERVAL=600` - sync interval in seconds
`-v /your/local/folder:/repos` - mont local folder where mirrors will be saved

#### docker-compose
```yaml
version: "3"
services:
  test_repo:
    image: spoonest/git_mirroring:latest
    environment:
      REPO_URL: https://github.com/yuri-karpovich/test.git
      REPO_DIR_NAME: test
      INTERVAL: 600
    volumes:
      - /your/local/folder:/repos
```

## Notes
This image use the following `ssh_config`
```
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
```

## Development
Run container with parameters `-it  --entrypoint=/bin/sh`:
```bash
docker run -it  --entrypoint=/bin/sh \
-e REPO_URL=git@github.com:yuri-karpovich/test.git \
-e REPO_DIR_NAME=test \
-e INTERVAL=600 \
-v /your/local/folder:/repos \
-v /you/ssh_keys/folder:/root/ssh \
-it spoonest/git_mirroring:latest
```
