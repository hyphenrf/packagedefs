#!/bin/sh

[ -n "$1" ] || {
  echo "Please specify a package name.";
  exit 1;
}

[ ! -d "$1" ] || {
  echo "Package already exists.";
  exit 2;
}

case "${1%${1#???}}" in
	lib) fst="${1%${1#????}}";;
		*) fst="${1%${1#?}}" 	 ;;
esac

mkdir -p "$1" /sol/"$fst"/"$1"
echo "include ../Makefile.common" > "$1"/Makefile

middle=$(( $(cat packages | wc -l) / 2 )) #using cat to avoid package names etc..
sed "${middle}a$1" packages | sort | sponge packages

if [ -n "$2" ]
then
  cd $1;
  ../../common/Scripts/yauto.py $2;
  cd ->/dev/null ;
else
	cp package.skeleton.yml $1/package.yml
fi
