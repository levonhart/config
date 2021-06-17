#!/usr/bin/env bash

#PUT THIS FILE IN ~/.local/share/rofi/finder.sh
#USE: rofi  -show find -modi find:~/.local/share/rofi/finder.sh
if [ ! -z "$@" ]
then
  QUERY=${@//\"/\\\"}
  if [[ "$@" == /* ]]
  then
    if [[ "$@" == *\?\? ]]
    then
      coproc ( exo-open "${QUERY%\/* \?\?}"  > /dev/null 2>&1 )
      exec 1>&-
      exit;
    else
      coproc ( exo-open "$@"  > /dev/null 2>&1 )
      exec 1>&-
      exit;
    fi
  elif [[ "$@" == \!\!* ]]
  then
    echo "!!-- Insira a sua consulta para procurar arquivos"
    echo "!!-- Para pesquisar novamente insira !<search_query>"
    echo "!!-- Para procurar em diretorios acima insira ?<search_query>"
    echo "!!-- Digite !! para mostrar a ajuda novamente"
  elif [[ "$@" == \?* ]]
  then
    echo "!!-- Insira outra consulta"
    while read -r line; do
      echo "$line" \?\?
    # done <<< $(find ~ -type d -path '*/\.*' -prune -o -not -name '.*' -type f -iname *"${QUERY#\?}"* -print)
  done <<< $(ag -S -g "(${QUERY#\?})([^/]*)(\..+$)?$" ~)
  else
    echo "!!-- Insira outra consulta"
    ag -S -g "(${QUERY#!})([^/]*)(\..+$)?$" ~
  fi
else
  echo "!!-- Insira a sua consulta para procurar arquivos"
  echo "!!-- Para pesquisar novamente insira !<search_query>"
  echo "!!-- Para procurar em diretorios acima insira ?<search_query>"
  echo "!!-- Digite !! para mostrar a ajuda novamente"
fi
