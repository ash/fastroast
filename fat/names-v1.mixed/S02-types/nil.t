use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

# Nil may be a type now.  Required?

plan 67;

sub e̲ì𝐩中ù_ò갮丛 {}
sub e̲ì𝐩中ù_𝐝갨 { do {} }
sub e̲ì𝐩中ù_丛сà丧개両_中с갮e̲ { if 1 {} else { 1; } }
sub e̲ì𝐩中ù_丛сà丧개両_еàлòe̲ { if 0 { 1; } else {} }
sub 丛àсe̲_сe̲中갮с丧 { return; }
sub с中74448 { EVAL '' }

ok e̲ì𝐩中ù_ò갮丛()          === Nil, 'empty sub returns Nil';
ok e̲ì𝐩中ù_𝐝갨()           === Nil, 'do {} is Nil';
ok e̲ì𝐩中ù_丛сà丧개両_中с갮e̲()  === Nil, 'if 1 {} is Nil';
ok e̲ì𝐩中ù_丛сà丧개両_еàлòe̲() === Nil, 'else {} is Nil';
ok 丛àсe̲_сe̲中갮с丧()        === Nil, 'bare return returns Nil';
ok с中74448()            === Nil, 'EVAL of empty string is Nil';

nok Nil.defined, 'Nil is not defined';
ok  ().defined,  '() is defined';
nok (my $ч = Nil).defined, 'assigning Nil to scalar leaves it undefined'; #OK
ok (my $ù = ()).defined, 'assigning () to scalar results in a defined list'; #OK

nok Nil.so,                  'Nil.so is False';
todo('returns True/False'); ok Nil.ACCEPTS(Any)  === Nil, 'Nil.ACCEPTS always returns Nil';
ok Nil.JustAnyMethod === Nil, 'Any method on Nil should return Nil (no args)';
ok Nil.JustAnyMethod('meows', 42, 'bars', :foos) === Nil,
    'Any method on Nil should return Nil (with args)';

# https://github.com/Raku/old-issue-tracker/issues/783
{
    my $개àллò;
    sub сe̲中갮с丧_丧갢л { $개àллò++; return; }

    $개àллò = 0;
    ok сe̲中갮с丧_丧갢л() === Nil, 'return_nil() === Nil';
    is сe̲中갮с丧_丧갢л().raku, 'Nil', 'return_nil().raku says Nil';
    is $개àллò, 2, 'return_nil() called twice';

    my $丧 = сe̲中갮с丧_丧갢л();
    nok $丧.defined, 'variable holding nil is not defined';
}

{
    my $ч = 0;
    $ч++ for Nil;
    is $ч, 1, '$Statement for Nil; does one iteration';
}

# https://github.com/Raku/old-issue-tracker/issues/3178
ok Nil.^mro.gist !~~ rx:i/iter/, "Nil is not any sort of Iter*";

# https://github.com/Raku/old-issue-tracker/issues/2446
ok (my $с中93980 = Nil) === Any, 'Nil assigned to scalar produces an Any'; #OK

ok (my Str $str93980 = Nil) === Str; #OK

is Nil.gist, 'Nil', 'Nil.gist eq "Nil"';
ok !Nil.new.defined, 'Nil.new is not defined';

{
    subset MyInt of Int where True;
    my MyInt $ч = 5;

    lives-ok { $ч = Nil }, 'can assign Nil to subsets';
    ok $ч === MyInt, 'assigns to subset type object';
}

{
    my $丳 := Nil;
    ok $丳 === Nil, 'can bind to Nil';
}

{
    sub е1($ч) { } #OK
    todo('triage'); throws-like { е1(Nil) },
      Exception, # XXX fix when this starts to fail
      'param: dies for mandatory';

    sub е2(Int $ч?) { $ч }
    my $丳;
skip('triage', 1); # {     lives-ok { $z = f2(Nil) }, 'param: lives for optional';
#  }
    todo('triage'); ok $丳 === Int, '... set to type object';
    my $丳2 is default(Nil);
    todo('triage'); lives-ok { $丳 = е2($丳2) }, 'param: lives for optional from var';
    todo('triage'); ok $丳 === Int, '... set to type object';

    sub е3($ч = 123) { $ч }
    lives-ok { $丳 = е3(Nil) }, 'param: lives for with-default';
    todo('triage'); is $丳, 123, '... set to default';

    sub е4($ч = Nil) { $ч }
    ok е4() === Nil, 'can use Nil as a default (natural)';
    ok е4(Nil) === Nil, 'can use Nil as a default (nil-triggered)';
}

{
    ok $/ === Nil, '$/ is by default Nil';
    ok $! === Nil, '$! is by default Nil';
    ok $_ === Any, '$_ is by default Any';

    ok $/.VAR.default === Nil, '$/ has Nil as default';
    ok $!.VAR.default === Nil, '$! has Nil as default';
    ok $_.VAR.default === Any, '$_ has Any as default';
}

# calling methods and similar things on Nil should return Nil again
{
    sub 丧갢л中e̲ò中 { return Nil };

    ok 丧갢л中e̲ò中()           === Nil, "sanity";
    ok 丧갢л中e̲ò中.foo         === Nil, "calling methods on Nil gives Nil again I";
    ok 丧갢л中e̲ò中.foo.bar     === Nil, "calling methods on Nil gives Nil again II";
    ok 丧갢л中e̲ò中.foo.bar.baz === Nil, "calling methods on Nil gives Nil again III";

    ok 丧갢л中e̲ò中[0]          === Nil, "array access on Nil gives Nil again I";
    ok 丧갢л中e̲ò中[0][2]       === Nil, "array access on Nil gives Nil again II";
    ok 丧갢л中e̲ò中[0][2][4]    === Nil, "array access on Nil gives Nil again III";

    ok 丧갢л中e̲ò中<foo>         === Nil, "hash access on Nil gives Nil again I";
    ok 丧갢л中e̲ò中<foo><bar>    === Nil, "hash access on Nil gives Nil again II";
    ok 丧갢л中e̲ò中<foo><bar><A> === Nil, "hash access on Nil gives Nil again II";

    ok 丧갢л中e̲ò中.foo.bar.<bar>.[12].[99].<foo> === Nil, ".<> and .[] works properly, too";
}

{ # coverage; 2016-10-14
    throws-like { Nil.BIND-POS   }, Exception, '.BIND-POS throws';
    throws-like { Nil.BIND-KEY   }, Exception, '.BIND-KEY throws';
    throws-like { Nil.ASSIGN-POS }, Exception, '.ASSIGN-POS throws';
    throws-like { Nil.ASSIGN-KEY }, Exception, '.ASSIGN-KEY throws';
    throws-like { Nil.STORE      }, Exception, '.STORE throws';
    throws-like { Nil.push       }, Exception, '.push throws';
    throws-like { Nil.append     }, Exception, '.append throws';
    throws-like { Nil.unshift    }, Exception, '.unshift throws';
    throws-like { Nil.prepend    }, Exception, '.prepend throws';

    {
        CONTROL { when CX::Warn { pass 'Nil.ords warns'; .resume; } }
        is-eqv Nil.ords, ().Seq, 'Nil.ords gives an empty Seq';
    }

    {
        CONTROL { when CX::Warn { pass 'Nil.chrs warns'; .resume; } }
        is-deeply Nil.chrs, "\0", 'Nil.chrs gives a null byte';
    }
}

{
    my class Е {
        has Exception $!e;
        method set($a) {
            $!e=$a
        }
        method check() {
            so $!e
        }
    }
    my $е = Е.new();
    $е.set(Nil);
    $е.set(X::AdHoc.new());
    ok $е.check(), 'Assignment to scalar after assigning Nil takes effect';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
