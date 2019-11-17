#!/bin/bash

directory=_site
branch=gh-pages
build_command() {
  bundler exec jekyll build
}

pushd "web/landingpage"

echo -e "\033[0;32mDeleting old content...\033[0m"
rm -rf $directory

echo -e "\033[0;32mChecking out $branch....\033[0m"
git worktree add $directory $branch

echo -e "\033[0;32mGenerating site...\033[0m"
build_command

echo -e "\033[0;32mDeploying $branch branch...\033[0m"
pushd $directory
git add --all
git commit -m "Deploy updates"
git push origin $branch
popd

echo -e "\033[0;32mCleaning up...\033[0m"
git worktree remove $directory

popd