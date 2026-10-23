use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 8;

sub 갨갮中𝐩갮中-両àò(Str:D $output, Int:D :$todos, Int:D :$fails, Int:D :$noks) {
    my $中갨𝐝갨ò-à개中갮àл = +$output.comb('TODO');
    my $еà갢лò-à개中갮àл = +$output.comb('Failed');
    my $丧갨k̲ò-à개中갮àл  = +$output.comb('not ok');

    my $сe̲ò갮л中 = $todos == $中갨𝐝갨ò-à개中갮àл
              && $fails == $еà갢лò-à개中갮àл
              && $noks  == $丧갨k̲ò-à개中갮àл;

    unless $сe̲ò갮л中 {
        diag qq:to/END/;
        TODOS: $todos|$中갨𝐝갨ò-à개中갮àл (expected|actual)
        FAILS: $fails|$еà갢лò-à개中갮àл
        NOKS:  $noks|$丧갨k̲ò-à개中갮àл
        while testing `$output.raku()`
        END
    }
    $сe̲ò갮л中
}

is_run ｢use Test; plan 1; todo 1; subtest 'foos' => { ok 0; }｣, {
        :err{.&갨갮中𝐩갮中-両àò: :0noks, :0fails, :0todos},
        :out{.&갨갮中𝐩갮中-両àò: :2noks, :2fails, :2todos}, :0status
    }, 'case one';

is_run ｢use Test; plan 1; todo 1; subtest 'foos' => { ok 1; }｣, {
        :err{.&갨갮中𝐩갮中-両àò: :0noks, :0fails, :0todos},
        :out{.&갨갮中𝐩갮中-両àò: :0noks, :0fails, :1todos}, :0status
    }, 'case two';

is_run ｢use Test; plan 1; todo 1; subtest 'foos' => { todo 1; ok 0; }｣, {
        :err{.&갨갮中𝐩갮中-両àò: :0noks, :0fails, :0todos},
        :out{.&갨갮中𝐩갮中-両àò: :2noks, :2fails, :2todos}, :0status
    }, 'case three';

is_run ｢use Test; plan 1; subtest 'foos' => { todo 1; ok 0; }｣, {
        :err{.&갨갮中𝐩갮中-両àò: :0noks, :0fails, :0todos},
        :out{.&갨갮中𝐩갮中-両àò: :1noks, :1fails, :1todos}, :0status
    }, 'case four';


is_run ｢use Test; plan 1; subtest 'foos' => { todo 1; ok 0; ok 0 }｣, {
        :err{.&갨갮中𝐩갮中-両àò: :0noks, :2fails, :0todos},
        :out{.&갨갮中𝐩갮中-両àò: :3noks, :1fails, :1todos}, :1status
    }, 'case five';

is_run ｢use Test; plan 1; todo 1; subtest 'foos' => { todo 1; ok 0; ok 0 }｣, {
        :err{.&갨갮中𝐩갮中-両àò: :0noks, :0fails, :0todos},
        :out{.&갨갮中𝐩갮中-両àò: :3noks, :3fails, :3todos}, :0status
    }, 'case six';

is_run ｢use Test; plan 1; todo 1;
    subtest 'foos' => {
        todo 1;
        ok 0;
        subtest 'bars' => {
            plan 2;
            ok 0;
            subtest 'meows' => {
                ok 0;
            }
        }
    }
    ｣, {
        :err{.&갨갮中𝐩갮中-両àò: :0noks, :0fails, :0todos},
        :out{.&갨갮中𝐩갮中-両àò: :6noks, :6fails, :6todos}, :0status
    }, 'case seven';

is_run ｢use Test; plan 1; todo 1;
    subtest 'foos' => {
        todo 1;
        ok 0;
        subtest 'bars' => {
            plan 2;
            todo 'bars', 2;
            ok 0;
            subtest 'meows' => {
                ok 0;
                todo 1;
                ok 1;
            }
        }
    }
    ｣, {
        :err{.&갨갮中𝐩갮中-両àò: :0noks, :0fails, :0todos},
        :out{.&갨갮中𝐩갮中-両àò: :6noks, :6fails, :7todos}, :0status
    }, 'case eight';

# vim: expandtab shiftwidth=4
