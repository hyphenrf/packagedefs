#!/bin/sh

./new.sh $1 $2

[ -n "$1" ] || exit 1
cd $1

# TODO: replace this with a proper haskell skeleton
# Add haskell- to the name
if ! head -1 package.yml |grep -q haskell
then sed -i '1s/: /: haskell-/' package.yml
fi

# Remove the 7th to EOF lines
[ $(wc -l package.yml |cut -d' ' -f1) -le 5 ] || sed -i '6,$d' package.yml

# Combine with a correct package.yml
sed '1,5d' ../haskell-hostname/package.yml | cat package.yml -> package.tmp
mv package.tmp package.yml

cd ->/dev/null
