#!/bin/bsh
#
# Build MV command
# based on coreutils-8.32 
#

function init() {
    SHELL_FOLDER=$(dirname $(readlink -f "$0"));
    set -x
}

function LIB() {
    S=(copy-acl.c set-acl.c acl-errno-valid.c acl-internal.c get-permissions.c set-permissions.c allocator.c areadlink.c areadlink-with-size.c areadlinkat.c argmatch.c argv-iter.c openat-proc.c backupfile.c backup-rename.c backupfile.c backup-find.c base32.c base64.c binary-io.c bitrotate.c buffer-lcm.c c-ctype.c c-strcasecmp.c c-strncasecmp.c c-strtod.c c-strtold.c canon-host.c canonicalize.c careadlinkat.c chmodat.c chownat.c cl-strtod.c cl-strtold.c cloexec.c close-stream.c closein.c closeout.c count-leading-zeros.c af_alg.c md5.c sha1.c sha256.c sha512.c cycle-check.c di-set.c diacrit.c opendir-safer.c dirname.c basename.c dirname-lgpl.c basename-lgpl.c stripslash.c dtoastr.c dtotimespec.c exclude.c exitfail.c fadvise.c creat-safer.c open-safer.c fd-hook.c fd-reopen.c fd-safer-flag.c dup-safer-flag.c fdutimensat.c file-has-acl.c file-set.c file-type.c filemode.c filenamecat.c filenamecat-lgpl.c filevercmp.c fopen-safer.c fprintftime.c freading.c freadseek.c freopen-safer.c ftoastr.c full-read.c full-write.c gethrxtime.c xtime.c getndelim2.c getprogname.c gettime.c getugroups.c hard-locale.c hash.c hash-pjw.c hash-triple.c heap.c human.c i-ring.c idcache.c ino-map.c imaxtostr.c inttostr.c offtostr.c uinttostr.c umaxtostr.c ldtoastr.c linebuffer.c localcharset.c glthread/lock.c long-options.c malloca.c math.c mbchar.c mbiter.c mbsalign.c mbscasecmp.c mbschr.c mbslen.c mbsstr.c mbswidth.c mbuiter.c memcasecmp.c memchr2.c memcmp2.c memcoll.c mgetgroups.c mkancesdirs.c dirchownmod.c mkdir-p.c modechange.c mpsort.c nproc.c nstrftime.c openat-die.c openat-safer.c opendirat.c parse-datetime.c physmem.c pipe2.c posixtm.c posixver.c printf-frexp.c printf-frexpl.c priv-set.c progname.c propername.c qcopy-acl.c qset-acl.c quotearg.c randint.c randperm.c randread.c rand-isaac.c read-file.c readtokens.c readtokens0.c renameatu.c root-dev-ino.c safe-read.c safe-write.c same.c save-cwd.c savedir.c savewd.c selinux-at.c se-context.c se-selinux.c setlocale_null.c settime.c sig-handler.c sockets.c stat-time.c statat.c mkstemp-safer.c striconv.c strnlen1.c strintcmp.c strnumcmp.c sys_socket.c tempname.c glthread/threadlib.c timespec.c glthread/tls.c trim.c u64.c unicodeio.c unistd.c dup-safer.c fd-safer.c pipe-safer.c unistr/u8-mbtoucr.c unistr/u8-uctomb.c unistr/u8-uctomb-aux.c uniwidth/width.c unlinkdir.c userspec.c utimecmp.c utimens.c verror.c version-etc.c version-etc-fsf.c wctype-h.c write-any-file.c xmalloc.c xalloc-die.c xbinary-io.c xdectoimax.c xdectoumax.c xfts.c xgetcwd.c xgetgroups.c xgethostname.c xmemcoll.c xnanosleep.c xprintf.c xreadlink.c xsize.c xstriconv.c xstrndup.c xstrtod.c xstrtoimax.c xstrtol.c xstrtoul.c xstrtol-error.c xstrtold.c xstrtoumax.c xvasprintf.c xasprintf.c yesno.c asnprintf.c chdir-long.c fchmodat.c fclose.c fcntl.c fflush.c fpurge.c freadahead.c freadptr.c fseek.c fseeko.c fseterr.c fsusage.c fts.c getfilecon.c isapipe.c lchmod.c localtime-buffer.c mbrlen.c mbrtowc.c mknod.c mkstemp.c mktime.c mountlist.c nanosleep.c obstack.c printf-args.c printf-parse.c readutmp.c regex.c sig2str.c time_rz.c vasnprintf.c)
    O="copy-acl.o set-acl.o acl-errno-valid.o acl-internal.o get-permissions.o set-permissions.o allocator.o areadlink.o areadlink-with-size.o areadlinkat.o argmatch.o argv-iter.o openat-proc.o backupfile.o backup-rename.o backupfile.o backup-find.o base32.o base64.o binary-io.o bitrotate.o buffer-lcm.o c-ctype.o c-strcasecmp.o c-strncasecmp.o c-strtod.o c-strtold.o canon-host.o canonicalize.o careadlinkat.o chmodat.o chownat.o cl-strtod.o cl-strtold.o cloexec.o close-stream.o closein.o closeout.o count-leading-zeros.o af_alg.o md5.o sha1.o sha256.o sha512.o cycle-check.o di-set.o diacrit.o opendir-safer.o dirname.o basename.o dirname-lgpl.o basename-lgpl.o stripslash.o dtoastr.o dtotimespec.o exclude.o exitfail.o fadvise.o creat-safer.o open-safer.o fd-hook.o fd-reopen.o fd-safer-flag.o dup-safer-flag.o fdutimensat.o file-has-acl.o file-set.o file-type.o filemode.o filenamecat.o filenamecat-lgpl.o filevercmp.o fopen-safer.o fprintftime.o freading.o freadseek.o freopen-safer.o ftoastr.o full-read.o full-write.o gethrxtime.o xtime.o getndelim2.o getprogname.o gettime.o getugroups.o hard-locale.o hash.o hash-pjw.o hash-triple.o heap.o human.o i-ring.o idcache.o ino-map.o imaxtostr.o inttostr.o offtostr.o uinttostr.o umaxtostr.o ldtoastr.o linebuffer.o localcharset.o glthread/lock.o long-options.o malloca.o math.o mbchar.o mbiter.o mbsalign.o mbscasecmp.o mbschr.o mbslen.o mbsstr.o mbswidth.o mbuiter.o memcasecmp.o memchr2.o memcmp2.o memcoll.o mgetgroups.o mkancesdirs.o dirchownmod.o mkdir-p.o modechange.o mpsort.o nproc.o nstrftime.o openat-die.o openat-safer.o opendirat.o parse-datetime.o physmem.o pipe2.o posixtm.o posixver.o printf-frexp.o printf-frexpl.o priv-set.o progname.o propername.o qcopy-acl.o qset-acl.o quotearg.o randint.o randperm.o randread.o rand-isaac.o read-file.o readtokens.o readtokens0.o renameatu.o root-dev-ino.o safe-read.o safe-write.o same.o save-cwd.o savedir.o savewd.o selinux-at.o se-context.o se-selinux.o setlocale_null.o settime.o sig-handler.o sockets.o stat-time.o statat.o mkstemp-safer.o striconv.o strnlen1.o strintcmp.o strnumcmp.o sys_socket.o tempname.o glthread/threadlib.o timespec.o glthread/tls.o trim.o u64.o unicodeio.o unistd.o dup-safer.o fd-safer.o pipe-safer.o unistr/u8-mbtoucr.o unistr/u8-uctomb.o unistr/u8-uctomb-aux.o uniwidth/width.o unlinkdir.o userspec.o utimecmp.o utimens.o verror.o version-etc.o version-etc-fsf.o wctype-h.o write-any-file.o xmalloc.o xalloc-die.o xbinary-io.o xdectoimax.o xdectoumax.o xfts.o xgetcwd.o xgetgroups.o xgethostname.o xmemcoll.o xnanosleep.o xprintf.o xreadlink.o xsize.o xstriconv.o xstrndup.o xstrtod.o xstrtoimax.o xstrtol.o xstrtoul.o xstrtol-error.o xstrtold.o xstrtoumax.o xvasprintf.o xasprintf.o yesno.o asnprintf.o chdir-long.o fchmodat.o fclose.o fcntl.o fflush.o fpurge.o freadahead.o freadptr.o fseek.o fseeko.o fseterr.o fsusage.o fts.o getfilecon.o isapipe.o lchmod.o localtime-buffer.o mbrlen.o mbrtowc.o mknod.o mkstemp.o mktime.o mountlist.o nanosleep.o obstack.o printf-args.o printf-parse.o readutmp.o regex.o sig2str.o time_rz.o vasnprintf.o"

    for i in ${S[@]}; do
        echo $i
        o=$(echo $i | sed 's/\.c/\.o/');
        echo $o;
        gcc -I. -I./lib -Ilib -I./lib -g -O2 -c -o lib/${o} lib/${i}
    done

    cd ${SHELL_FOLDER}/lib;
    ar cr libcoreutils.a ${O};
}

function MV() {
    cd ${SHELL_FOLDER};
    gcc -I./lib -c -o version.o version.c
    ar cr libver.a version.o
    gcc -I. -I./lib -g -O2 -c -o remove.o remove.c
    gcc -I. -I./lib -g -O2 -c -o copy.o copy.c
    gcc -I. -I./lib -g -O2 -c -o cp-hash.o cp-hash.c
    gcc -I. -I./lib -g -O2 -c -o extent-scan.o extent-scan.c
    gcc -I. -I./lib -g -O2 -c -o force-link.o force-link.c
    gcc -I. -I./lib -g -O2 -c -o selinux.o selinux.c
    gcc -I. -I./lib -g -O2 -c -o mv.o mv.c

    gcc -g -O2 -Wl,--as-needed -o mv \
        mv.o remove.o copy.o cp-hash.o extent-scan.o force-link.o selinux.o libver.a lib/libcoreutils.a lib/libcoreutils.a \
       -lselinux -lacl -lattr -pthread  -lpcre2-8 -ldl -static
    
    mv ./mv rm_
}

init
#LIB
MV