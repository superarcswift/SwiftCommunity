#!/bin/sh

echo "=== installing Templates ==="

pushd `dirname $0`
cp -r `pwd`/Xcode-Templates/SuperArc ~/Library/Developer/Xcode/Templates/File\ Templates
popd

echo "=== done ==="
