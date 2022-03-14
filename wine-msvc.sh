#!/bin/bash
EXE=$1
shift
ARGS=()
while [ $# -gt 0 ]; do
        a=$1
        case $a in
        [@]/*)
           path=${a:1}
           for flag in "FI" "Yc" "Yu"; do
                  sed -i -r "s#/${flag}/#/${flag}Z:/#g" ${path}
           done
           sed -i -r 's#/Zi#/Z7#g' ${path}
           ;;
        /Zi)
          a="/Z7"
          ;;
        [-/][A-Za-z][A-Za-z]/*)
           opt=${a:0:3}
           path=${a:3}
           if [ -d "$(dirname $path)" ] && [ "$(dirname $path)" != "/" ]; then
            a=${opt}z:$path
           fi
           ;;
        /*)
           if [ -d "$(dirname "$a")" ] && [ "$(dirname "$a")" != "/" ]; then
            a=z:$a
           fi
           ;;
        *)
           ;;
        esac
        ARGS+=("$a")
        shift
done
wine64 "$EXE" "${ARGS[@]}" 2> >(grep -v '^[[:alnum:]]*:\?fixme' | grep -v ^err:bcrypt:hash_init | sed 's/\r//' >&2) | sed 's/\r//' | sed 's/z:\([\\/]\)/\1/i' | sed '/^Note:/s,\\,/,g'
exit $PIPESTATUS

