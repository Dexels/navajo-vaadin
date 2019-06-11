#!/bin/sh
BASE_CONTAINER_BUILD=$(curl -s "https://circleci.com/api/v1.1/project/github/Dexels/dexels-base?circle-token=${CIRCLE_TOKEN}&limit=1&offset=0&filter=successful" | jq '.[0].build_num')
MINORTAG=3.3
TAG=${MINORTAG}.$BASE_CONTAINER_BUILD
echo "Tag for parent: ${TAG}"

rm -rf plugins *.zip
mkdir plugins
BRANCH=newmaven
NAVAJO_VERSION=$(curl -s "https://circleci.com/api/v1.1/project/github/Dexels/navajo?circle-token=${CIRCLE_TOKEN}&limit=1&offset=0&filter=successful" | jq '.[0].build_num')
echo "Navajo Version: $NAVAJO_VERSION"
curl -s "https://${NAVAJO_VERSION}-4423334-gh.circle-artifacts.com/0/vaadin_p2.zip?circle-token=$CIRCLE_TOKEN&branch=${BRANCH}" -o vaadin_p2.zip
ls *.zip | xargs -I '{}' unzip -o '{}'
rm -rf artifacts.* content.* features* *.index
rm *.zip
docker build --build-arg TAG=${TAG} .  -t dexels/vaadin:latest
