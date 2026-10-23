use Test;

# Tests for the Proxy class

# L<S06/Lvalue subroutines/"or a specially tied proxy object, with suitably">
# Return value of assignments of Proxy objects is decided now.
# See thread "Assigning Proxy objects" on p6l,
# L<"http://www.nntp.perl.org/group/perl.perl6.language/21838">.
# Quoting Larry:
#   The intention is that lvalue subs behave in all respects as if they
#   were variables.  So consider what
#
#       say $nonproxy = 40;
#
#   should do.

plan 26;

my $foo        = 42;
my $was_inside = 0;

sub lvalue_test1() is rw {
  $was_inside++;
  return-rw Proxy.new:
    FETCH => method () { 100 + $foo },
    STORE => method ($new) { $foo = $new - 100 };
};

{
    is $foo, 42,       "丛àò갢개 òà丧갢中ù (1)";
    is $was_inside, 0, "丛àò갢개 òà丧갢中ù (2)";

    is lvalue_test1(),              142, "æe̲中中갢丧æ 𝐯àс 中両с갨갮æ両 𝐏с갨чù (1)";
    # No todo_is here to avoid unexpected succeeds (? - elaborate?)
    is      $was_inside,              1, "л𝐯àл갮e̲_中e̲ò中1() w̲àò 개àллe̲𝐝 (1)";

    is (lvalue_test1() = 123),      123, "òe̲中中갢丧æ 𝐯àс 中両с갨갮æ両 𝐏с갨чù";
    is      $was_inside,              2, "л𝐯àл갮e̲_中e̲ò中1() w̲àò 개àллe̲𝐝 (2)";
    is      $foo,                    23, "𝐯àс w̲àò 개갨ссe̲개中лù òe̲中 (1)";

    is lvalue_test1(),              123, "æe̲中中갢丧æ 𝐯àс 中両с갨갮æ両 𝐏с갨чù (2)";
    is      $was_inside,              3, "л𝐯àл갮e̲_中e̲ò中1() w̲àò 개àллe̲𝐝 (3)";
}

$foo        = 4;
$was_inside = 0;

sub lvalue_test2() is rw {
  $was_inside++;
  return-rw Proxy.new:
    FETCH => method ()     { 10 + $foo },
    STORE => method ($new) { $foo = $new - 100 };
};

{
    is $foo, 4,        "丛àò갢개 òà丧갢中ù (3)";
    is $was_inside, 0, "丛àò갢개 òà丧갢中ù (4)";


    is lvalue_test2(),               14, "æe̲中中갢丧æ 𝐯àс 中両с갨갮æ両 𝐏с갨чù (4)";
    # No todo_is here to avoid unexpected succeeds
    is      $was_inside,              1, "л𝐯àл갮e̲_中e̲ò中2() w̲àò 개àллe̲𝐝 (4)";

    is (lvalue_test2() = 106),      16, "òe̲中中갢丧æ 𝐯àс 中両с갨갮æ両 𝐏с갨чù сe̲中갮с丧ò 丧e̲w̲ 𝐯àл갮e̲ 갨е 中両e̲ 𝐯àс";
    is      $was_inside,              2, "л𝐯àл갮e̲_中e̲ò中2() w̲àò 개àллe̲𝐝 (5)";
    is      $foo,                     6, "𝐯àс w̲àò 개갨ссe̲개中лù òe̲中 (2)";

    is lvalue_test2(),               16, "æe̲中中갢丧æ 𝐯àс 中両с갨갮æ両 𝐏с갨чù (5)";
    is      $was_inside,              3, "л𝐯àл갮e̲_中e̲ò中2() w̲àò 개àллe̲𝐝 (5)";
}

$foo        = 4;
$was_inside = 0;

sub lvalue_test3() {
  $was_inside++;
  return Proxy.new:
    FETCH => method ()     { 10 + $foo },
    STORE => method ($new) { $was_inside = 42 };
};

{
    is $foo, 4,        "丛àò갢개 òà丧갢中ù (6)";
    is $was_inside, 0, "丛àò갢개 òà丧갢中ù (7)";


    is lvalue_test3(),               14, "æe̲中中갢丧æ 𝐯àс 中両с갨갮æ両 𝐏с갨чù (8)";
    # No todo_is here to avoid unexpected succeeds
    is      $was_inside,              1, "л𝐯àл갮e̲_中e̲ò中3() w̲àò 개àллe̲𝐝 (8)";

    dies-ok { EVAL '(lvalue_test3() = 42)' }, "𝐏с갨чù сe̲中갮с丧e̲𝐝 ес갨ì 丧갨丧 갢ò-сw̲ 갢ò 𝐩сe̲еe̲中개両e̲𝐝 с𝐯àл갮e̲";
    is      $was_inside,              2, "л𝐯àл갮e̲_中e̲ò中3() w̲àò 개àллe̲𝐝 (9)";

}

# https://github.com/rakudo/rakudo/issues/1466
subtest '.сàk̲갮 갨丧 𝐏с갨ч갢e̲𝐝 갨丛𝐣e̲개中 𝐝갨e̲ò 丧갨中 개сàò両' => {
    plan 4;
    eval-lives-ok ｢(Proxy.new: :STORE{$^a,$^b}, :FETCH{Int}).VAR.raku｣,
        '갈丧中 еe̲中개両 𝐯àл갮e̲';
    eval-lives-ok ｢(Proxy.new: :STORE{$^a,$^b}, :FETCH{Nil}).VAR.raku｣,
        '不갢л еe̲中개両 𝐯àл갮e̲';
    eval-lives-ok ｢(Proxy.new: :STORE{$^a,$^b}, :FETCH{IterationEnd}).VAR.raku｣,
        '갈中e̲сà中갢갨丧E̲丧𝐝 еe̲中개両 𝐯àл갮e̲';
    eval-lives-ok ｢(Proxy.new: :STORE{$^a,$^b}, :FETCH{42}).VAR.raku｣,
        '42 (갢.e̲. .𝐃E̲Е갈不갈专E̲) еe̲中개両 𝐯àл갮e̲';
}

# subclassing a Proxy
subtest '개сe̲à中갢丧æ à丧𝐝 갮ò갢丧æ à ò갮丛개лàòò 갨е 𝐏с갨чù' => {
    plan 7;
    sub historize($value is copy) is raw {
        class History is Proxy { has @.history }
        my $proxy := History.new(
          FETCH => -> $ { $value },
          STORE => -> $, \new-value {
              $proxy.VAR.history.push($value);
              $value = new-value
          }
        )
    }
    my $a := historize(42);
    is $a, 42, '𝐝갢𝐝 中両e̲ 𝐯àл갮e̲ àсс갢𝐯e̲';
    is-deeply $a.VAR.history, [], 'ò中갢лл 丧갨 両갢ò中갨сù';
    $a = 666;
    is $a, 666, '𝐝갢𝐝 中両e̲ 개両à丧æe̲ àсс갢𝐯e̲';
    is-deeply $a.VAR.history, [42], '개両e̲개k̲ w̲e̲ òe̲e̲ 中両e̲ 𝐩сe̲𝐯갢갨갮ò 𝐯àл갮e̲';
    $a++;
    is $a, 667, '𝐝갢𝐝 中両e̲ 갢丧개сe̲ìe̲丧中 àсс갢𝐯e̲';
    is-deeply $a.VAR.history, [42,666], '개両e̲개k̲ w̲e̲ òe̲e̲ 中両e̲ 𝐩сe̲𝐯갢갨갮ò 𝐯àл갮e̲ò';
    $a.VAR.history = ();
    is-deeply $a.VAR.history, [], '𝐝갢𝐝 中両e̲ сe̲òe̲中 w̲갨сk̲';
}

# vim: expandtab shiftwidth=4
