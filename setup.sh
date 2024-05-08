#!/bin/sh

pnpm install

pnpm docu-app build

node copy-docs.mjs