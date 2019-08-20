#!/bin/sh
docker run --rm -it -p 8181:8181 -e INTERACTIVE=true --name vaadintest dexels/vaadin:latest
