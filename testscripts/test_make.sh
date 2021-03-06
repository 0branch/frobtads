#! /bin/sh

# Make and execute tests

cd "$T3_OUT"

CHARSET=$1
shift

skiprun="NO"
if [ $1 == "-norun" ]; then
    skiprun="YES"
    shift
fi

tstscript=""
if [ $1 == "-script" ]; then
    tstscript="YES"
    shift
fi

case "$1" in
    -nodef)
        shift
        $t3make -test -I"$T3_DAT" -a -nodef -nobanner -nopre -Fs "$T3_DAT" -Fo "$T3_OUT" -Fy "$T3_OUT" \
            -o "$T3_OUT/$1.t3" $2 $3 $4 $5 $6 $7 $8 $9 > "$T3_OUT/$1.log" 2>"$T3_OUT/$1.err"
        ;;
    -debug)
        shift
        $t3make -test -d -I"$T3_DAT" -a -nobanner -nopre -Fs "$T3_DAT" -Fo "$T3_OUT" -Fy "$T3_OUT" \
            -o "$T3_OUT/$1.t3" $2 $3 $4 $5 $6 $7 $8 $9 > "$T3_OUT/$1.log" 2>"$T3_OUT/$1.err"
        ;;
    -pre)
        shift
        $t3make -test -I"$T3_DAT" -a -nobanner -Fs "$T3_DAT" -Fo "$T3_OUT" -Fy "$T3_OUT" \
            -o "$T3_OUT/$1.t3" $2 $3 $4 $5 $6 $7 $8 $9 > "$T3_OUT/$1.log" 2>"$T3_OUT/$1.err"
        ;;
    *)
        $t3make -test -I"$T3_DAT" -a -nobanner -nopre -Fs "$T3_DAT" -Fo "$T3_OUT" -Fy "$T3_OUT" \
            -o "$T3_OUT/$1.t3" $2 $3 $4 $5 $6 $7 $8 $9 > "$T3_OUT/$1.log" 2>"$T3_OUT/$1.err"
        ;;
esac
cat "$T3_OUT/$1.err" >> "$T3_OUT/$1.log"

if [ $skiprun == "NO" ]; then
    echo "'Make' test: $1"
    if [ $tstscript == "YES" ]; then
        $TESTPROGS/test_exec -I "$T3_DAT/$1.in" -cs $CHARSET -norand "$T3_OUT/$1.t3" >> "$T3_OUT/$1.log" 2>"$T3_OUT/$1.err"
    else
        $TESTPROGS/test_exec -cs $CHARSET -norand "$T3_OUT/$1.t3" >> "$T3_OUT/$1.log" 2>"$T3_OUT/$1.err"
    fi
    cat "$T3_OUT/$1.err" >> "$T3_OUT/$1.log"
fi

rm "$T3_OUT/$1.err"
$SCRIPTS/test_diff.sh "$1"
exit $?
