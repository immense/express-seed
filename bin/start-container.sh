# Expose ports
# allocate pseudy-tty
# remove the container when we leave it
# name the container
# mount the current directory as /src
# mount /tmp into the container so we can pass a socket
# specify the image to build the container from
docker run -t \
           -i \
           -P \
           --name express-seed \
           -v $(pwd):/src \
           -v /tmp:/socket-tmp \
           -w /src \
           in_networks/express-seed \
           /bin/bash
