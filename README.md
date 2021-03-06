rsync
=====

RSync server running in a docker container

## Usage

Launch in compose:
```
version: '3'

services:

    rsync.from:
        image: mishamx/rsync:latest
        environment:
            USERNAME: $RS_USERNAME
            PASSWORD: $RS_USER_PASSWORD
            READONLY: $RS_READONLY
            ALLOW: $RS_ALLOW
        networks:
            - front
        volumes:
            - "$RS_PATH_FROM:/data"
        # For swarm
        deploy:
            placement:
                constraints: [node.lable.rsync == from]

    rsync.to:
        image: mishamx/rsync:latest
        environment:
            USERNAME: $RS_USERNAME
            PASSWORD: $RS_USER_PASSWORD
            RSFROM: rsync.from
        networks:
            - front
        volumes:
            - "$RS_PATH_TO:/data"
        # For swarm
        deploy:
            placement:
                constraints: [node.lable.rsync == to]
        command: /usr/bin/supervisord

networks:
    front:
        driver: bridge
```

## Env file

```
# RSync
RS_USERNAME=rsync_user
RS_USER_PASSWORD=rsync_user_password
RS_READONLY=true
RS_ALLOW=192.168.0.0/16 172.16.0.0/12
RS_PATH_FROM=./storage/from
RS_PATH_TO=./storage/to
```