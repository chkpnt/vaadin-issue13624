#!/usr/bin/env bash
set -x

export

iptables -A OUTPUT -p tcp --dport 443 -j DROP
iptables -A OUTPUT -p tcp --dport 80 -j DROP

# Uncomment, if an interactive session into the docker container is needed:
#tail -f /dev/null

# None of them works for the Gradle build:
#mkdir -p node_modules/esbuild && cp .npmrc /node_modules/esbuild/.npmrc
#cp .npmrc ~/.npmrc
#cp .npmrc /etc/npmrc

./gradlew -Pvaadin.productionMode=true --info build

# This works (as npm seems to respect the http(s)_proxy env variables),
# so the issue has to be related to Vaadin's Gradle plugin.
# It fails with an timeout if neither the http(s)_proxy env variables nor an npm config
# is available.
#npm --ignore-scripts install
#ls -l node_modules/
#cd node_modules/esbuild
#npm run postinstall
#./bin/esbuild

#tail -f /dev/null