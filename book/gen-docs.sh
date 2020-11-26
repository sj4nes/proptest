#! /usr/bin/env bash

# This file is used to generate the Proptest Book and deposit it in the
# appropriate place to be hosted on GH pages.
#
# Note that it uses a repository reference to a fork of the altsysrq repo.

set -eux

mdbook build
git clone git@github.com:sj4nes/proptest.git -b gh-pages staging
cd staging
git rm -rf *
cp -r ../book/* .
git add *
git commit -qm 'Update proptest-book.'
git push
cd ..
rm -rf staging
