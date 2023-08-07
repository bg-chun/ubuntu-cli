# ubuntu-cli

## Image Info
The image is based on `ubuntu:lunar`, and the default shell is `bash`, it containes `kubectl, curl, git, wget, vim, nslookup, telnet, ping, etc`.

## Configure zshrc
Quick access to isolated cli env to operate multiple clusters
```bash
cat >> ~/.zshrc <<EOF
alias cli="docker run -it --mount type=bind,source=${OPENRCS_DIR},target=/openrcs {CONTAINER_REPO?}:latest"
EOF
```
