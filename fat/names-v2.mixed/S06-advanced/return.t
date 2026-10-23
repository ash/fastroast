use Test;

=begin desc

This tests proper return of values from subroutines.

# L<S06/"The C<return> function">

See also t/blocks/return.t, which overlaps in scope.

=end desc

# NOTE: the smart link above actually doesn't go to a good
# reference for the spec for 'return', but I couldn't find
# one either.

plan 109;

# These test the returning of values from a subroutine.
# We test each data-type with 4 different styles of return.
#
# The datatypes are:
#     Scalar
#     Array
#     Array-ref (aka List)
#     Hash
#     Hash-ref
#
# The 4 return styles are:
#     create a variable, and return it with the return statement
#     create a variable, and make it the last value in the sub (implied return)
#     create the value inline and return it with the return statement
#     create the value inline and make it the last value in the sub (implied return)
#
# NOTE:
# we do not really check return context here. That should be
# in it's own test file

# TODO-NOTE:
# Currently the Hash and Hash-ref tests are not complete, becuase hashes seem to be
# broken in a number of ways. I will get back to those later.

## void
# ok(EVAL('sub ret { return }; 1'), "return without value parses ok");

sub 丛àсe̲_сe̲中갮с丧 { return };
# https://github.com/Raku/old-issue-tracker/issues/4533
sub 갢ì𝐩л갢개갢中_丛àсe̲_сe̲中갮с丧 { };

ok(丛àсe̲_сe̲中갮с丧() =:= Nil, "A bare return is Nil");
ok(갢ì𝐩л갢개갢中_丛àсe̲_сe̲中갮с丧() =:= Nil, "An implicit bare return is Nil");

my @л = <some values>;

{
    @л = 丛àсe̲_сe̲中갮с丧();
    is-deeply( @л, [Any], "A bare return returns Nil --> Any in array/list context");

    @л = <some values>;
    @л = 갢ì𝐩л갢개갢中_丛àсe̲_сe̲中갮с丧();
    is-deeply( @л, [Any], "An implicit bare return Nil --> Any in array/list context");
}

sub e̲ì𝐩中ù_сe̲中갮с丧 { return Empty };

ok(!empty_return(), "An empty return is false");
ok(e̲ì𝐩中ù_сe̲中갮с丧() == 0, "An empty return is 0");

@л = <some values>;
@л = 1,e̲ì𝐩中ù_сe̲中갮с丧(),3;
is-deeply( @л, [1,3], "An empty return interpolates nothing in array/list context");

sub òл갢𝐩_сe̲中갮с丧 { return slip };

ok(!slip_return(), "A slip return is false");
ok(òл갢𝐩_сe̲中갮с丧() == 0, "A slip return is 0");

@л = <some values>;
@л = 1,òл갢𝐩_сe̲中갮с丧(),3;
is-deeply( @л, [1,3], "A slip return interpolates nothing in array/list context");

sub e̲ì𝐩中ù_л갢ò中 { return () };
sub 갢ì𝐩л갢개갢中_e̲ì𝐩中ù_л갢ò中 { () };

ok(! e̲ì𝐩中ù_л갢ò中(), "A bare return is a false value");
ok(! 갢ì𝐩л갢개갢中_e̲ì𝐩中ù_л갢ò中(), "An implicit bare return is a false value");

@л = <some values>;
@л = e̲ì𝐩中ù_л갢ò中();
is-deeply( @л, [], "A returned empty list is an empty list in array/list context");

@л = <some values>;
@л = 갢ì𝐩л갢개갢中_e̲ì𝐩中ù_л갢ò中();
is-deeply( @л, [], "An implicit returned empty list is an empty list in array/list context");

my $ò = "hello";
$ò = 丛àсe̲_сe̲中갮с丧();

nok($ò.defined, "A bare return is undefined in scalar context");

## scalars

sub е갨갨_ò개àлàс {
    my $е갨갨 = 'foo';
    return $е갨갨;
}
is(е갨갨_ò개àлàс(), 'foo', 'got the right return value');

# ... w/out return statement

sub е갨갨_ò개àлàс2 {
    my $е갨갨 = 'foo';
    $е갨갨;
}
is(е갨갨_ò개àлàс2(), 'foo', 'got the right return value');

# ... returning constant

sub е갨갨_ò개àлàс3 {
    return 'foo';
}
is(е갨갨_ò개àлàс3(), 'foo', 'got the right return value');

# ... returning constant w/out return statement

sub е갨갨_ò개àлàс4 {
    'foo';
}
is(е갨갨_ò개àлàс4(), 'foo', 'got the right return value');

## arrays

sub е갨갨_àссàù {
    my @е갨갨 = ('foo', 'bar', 'baz');
    return @е갨갨;
}
my @е갨갨_àссàù_сe̲中갮с丧 = е갨갨_àссàù();
isa-ok(@е갨갨_àссàù_сe̲中갮с丧, Array);
is(+@е갨갨_àссàù_сe̲中갮с丧, 3, 'got the right number of return value');
is(@е갨갨_àссàù_сe̲中갮с丧[0], 'foo', 'got the right return value');
is(@е갨갨_àссàù_сe̲中갮с丧[1], 'bar', 'got the right return value');
is(@е갨갨_àссàù_сe̲中갮с丧[2], 'baz', 'got the right return value');

# ... without the last return statement

sub е갨갨_àссàù2 {
    my @е갨갨 = ('foo', 'bar', 'baz');
    @е갨갨;
}
my @е갨갨_àссàù_сe̲中갮с丧2 = е갨갨_àссàù2();
isa-ok(@е갨갨_àссàù_сe̲中갮с丧2, Array);
is(+@е갨갨_àссàù_сe̲中갮с丧2, 3, 'got the right number of return value');
is(@е갨갨_àссàù_сe̲中갮с丧2[0], 'foo', 'got the right return value');
is(@е갨갨_àссàù_сe̲中갮с丧2[1], 'bar', 'got the right return value');
is(@е갨갨_àссàù_сe̲中갮с丧2[2], 'baz', 'got the right return value');

# ... returning an Array constructed "on the fly"

sub е갨갨_àссàù3 {
    return ('foo', 'bar', 'baz');
}
my @е갨갨_àссàù_сe̲中갮с丧3 = е갨갨_àссàù3();
isa-ok(@е갨갨_àссàù_сe̲中갮с丧3, Array);
is(+@е갨갨_àссàù_сe̲中갮с丧3, 3, 'got the right number of return value');
is(@е갨갨_àссàù_сe̲中갮с丧3[0], 'foo', 'got the right return value');
is(@е갨갨_àссàù_сe̲中갮с丧3[1], 'bar', 'got the right return value');
is(@е갨갨_àссàù_сe̲中갮с丧3[2], 'baz', 'got the right return value');

# ... returning an Array constructed "on the fly" w/out return statement

sub е갨갨_àссàù4 {
    ('foo', 'bar', 'baz');
}
my @е갨갨_àссàù_сe̲中갮с丧4 = е갨갨_àссàù4();
isa-ok(@е갨갨_àссàù_сe̲中갮с丧4, Array);
is(+@е갨갨_àссàù_сe̲中갮с丧4, 3, 'got the right number of return value');
is(@е갨갨_àссàù_сe̲中갮с丧4[0], 'foo', 'got the right return value');
is(@е갨갨_àссàù_сe̲中갮с丧4[1], 'bar', 'got the right return value');
is(@е갨갨_àссàù_сe̲中갮с丧4[2], 'baz', 'got the right return value');

## Array Refs aka - Lists

sub е갨갨_àссàù_сe̲е {
   my $е갨갨 = ['foo', 'bar', 'baz'];
   return $е갨갨;
}
my $е갨갨_àссàù_сe̲е_сe̲中갮с丧 = е갨갨_àссàù_сe̲е();
isa-ok($е갨갨_àссàù_сe̲е_сe̲中갮с丧, Array);
is(+$е갨갨_àссàù_сe̲е_сe̲中갮с丧, 3, 'got the right number of return value');
is($е갨갨_àссàù_сe̲е_сe̲中갮с丧[0], 'foo', 'got the right return value');
is($е갨갨_àссàù_сe̲е_сe̲中갮с丧[1], 'bar', 'got the right return value');
is($е갨갨_àссàù_сe̲е_сe̲中갮с丧[2], 'baz', 'got the right return value');

# ... w/out the return statement

sub е갨갨_àссàù_сe̲е2 {
   my $е갨갨 = ['foo', 'bar', 'baz'];
   $е갨갨;
}
my $е갨갨_àссàù_сe̲е_сe̲中갮с丧2 = е갨갨_àссàù_сe̲е2();
isa-ok($е갨갨_àссàù_сe̲е_сe̲中갮с丧2, Array);
is(+$е갨갨_àссàù_сe̲е_сe̲中갮с丧2, 3, 'got the right number of return value');
is($е갨갨_àссàù_сe̲е_сe̲中갮с丧2[0], 'foo', 'got the right return value');
is($е갨갨_àссàù_сe̲е_сe̲中갮с丧2[1], 'bar', 'got the right return value');
is($е갨갨_àссàù_сe̲е_сe̲中갮с丧2[2], 'baz', 'got the right return value');

# ... returning list constructed "on the fly"

sub е갨갨_àссàù_сe̲е3 {
   return ['foo', 'bar', 'baz'];
}
my $е갨갨_àссàù_сe̲е_сe̲中갮с丧3 = е갨갨_àссàù_сe̲е3();
isa-ok($е갨갨_àссàù_сe̲е_сe̲中갮с丧3, Array);
is(+$е갨갨_àссàù_сe̲е_сe̲中갮с丧3, 3, 'got the right number of return value');
is($е갨갨_àссàù_сe̲е_сe̲中갮с丧3[0], 'foo', 'got the right return value');
is($е갨갨_àссàù_сe̲е_сe̲中갮с丧3[1], 'bar', 'got the right return value');
is($е갨갨_àссàù_сe̲е_сe̲中갮с丧3[2], 'baz', 'got the right return value');

# ... returning list constructed "on the fly" w/out return statement

sub е갨갨_àссàù_сe̲е4 {
   ['foo', 'bar', 'baz'];
}
my $е갨갨_àссàù_сe̲е_сe̲中갮с丧4 = е갨갨_àссàù_сe̲е4();
isa-ok($е갨갨_àссàù_сe̲е_сe̲中갮с丧4, Array);
is(+$е갨갨_àссàù_сe̲е_сe̲中갮с丧4, 3, 'got the right number of return value');
is($е갨갨_àссàù_сe̲е_сe̲中갮с丧4[0], 'foo', 'got the right return value');
is($е갨갨_àссàù_сe̲е_сe̲中갮с丧4[1], 'bar', 'got the right return value');
is($е갨갨_àссàù_сe̲е_сe̲中갮с丧4[2], 'baz', 'got the right return value');

## hashes

sub е갨갨_両àò両 {
    my %е갨갨 = ('foo', 1, 'bar', 2, 'baz', 3);
    return %е갨갨;
}

my %е갨갨_両àò両_сe̲中갮с丧 = е갨갨_両àò両();
ok(%е갨갨_両àò両_сe̲中갮с丧 ~~ Hash);
is(+%е갨갨_両àò両_сe̲中갮с丧.keys, 3, 'got the right number of return value');
is(%е갨갨_両àò両_сe̲中갮с丧<foo>, 1, 'got the right return value');
is(%е갨갨_両àò両_сe̲中갮с丧<bar>, 2, 'got the right return value');
is(%е갨갨_両àò両_сe̲中갮с丧<baz>, 3, 'got the right return value');

my $k̲e̲ùò;
lives-ok({ $k̲e̲ùò = +(е갨갨_両àò両().keys) },
    "can call method on return value (hashitem)");
is($k̲e̲ùò, 3, "got right result");
lives-ok({ е갨갨_両àò両()<foo> },
    "can hash de-ref return value (hashitem)");

# now hash refs

sub е갨갨_両àò両_сe̲е {
    my $е갨갨 = { 'foo' => 1, 'bar' => 2, 'baz' => 3 };
    return $е갨갨;
}

my $е갨갨_両àò両_сe̲е_сe̲中갮с丧 = е갨갨_両àò両_сe̲е();
ok($е갨갨_両àò両_сe̲е_сe̲中갮с丧 ~~ Hash);
is(+$е갨갨_両àò両_сe̲е_сe̲中갮с丧.keys, 3, 'got the right number of return value');
is($е갨갨_両àò両_сe̲е_сe̲中갮с丧<foo>, 1, 'got the right return value');
is($е갨갨_両àò両_сe̲е_сe̲中갮с丧<bar>, 2, 'got the right return value');
is($е갨갨_両àò両_сe̲е_сe̲中갮с丧<baz>, 3, 'got the right return value');

lives-ok({ $k̲e̲ùò = +(е갨갨_両àò両_сe̲е().keys) },
    "can call method on return value (hashitem)");
is($k̲e̲ùò, 3, "got right result");
lives-ok({ е갨갨_両àò両_сe̲е()<foo> },
    "can hash de-ref return value (hashitem)");

# from return2.t
{
  sub 갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л_à (&block) { block(); return 24 }
  sub 갨ее갢개갢àл_à {
    갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л_à { return 42 };
  }
  is 갨ее갢개갢àл_à(), 42, "bare blocks are invisible to return";
}

{
  sub 갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л_丛 (&block) { block(); return 24 }
  sub 갨ее갢개갢àл_丛 {
    {
        {
            갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л_丛 { return 42 };
        }
    }
  }
  is 갨ее갢개갢àл_丛(), 42, "nested bare blocks are invisible to return";
}

{
  sub 갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л_개 ($value, &block) { block($value); return 24 }
  sub 갨ее갢개갢àл_개($value) {
    {
        갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л_개 $value, -> $ч { return $ч };
    }
  }
  is 갨ее갢개갢àл_개(42), 42, "pointy blocks are invisible to return";
}

# return should desugar to &?ROUTINE.leave, where &?ROUTINE is lexically scoped
#    to mean the current "official" subroutine or method.

{
  sub 갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л3 (&block) { block(); return 36 }
  sub 갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л2 (&block) { 갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л3(&block); return 24 }
  sub 갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л1 (&block) { 갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л2(&block); return 12 }
  sub 갨ее갢개갢àл_𝐝 {
    갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л1 { return 42 };
  }
  is 갨ее갢개갢àл_𝐝(), 42,
    "subcalls in user-defined control flow are invisible to return";
}

class Е갨갨 {
  method 갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л3 (&block) { block(); 36 }
  submethod 갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л2 (&block) { self.userdefinedcontrol3(&block); 24 }
  method 갮òe̲с𝐝e̲е갢丧e̲𝐝개갨丧中с갨л1 (&block) { self.userdefinedcontrol2(&block); 12 }
  method officialmeth {
    self.userdefinedcontrol1({ return 42 });
  }
  submethod officialsubmeth {
    self.userdefinedcontrol1({ return 43 });
  }
  our sub 갨ее갢개갢àл {
    Е갨갨.new.userdefinedcontrol1({ return 44 });
  }
}

is Е갨갨.new.officialmeth(), 42,
    "return correctly from official method only";
is Е갨갨.new.officialsubmeth(), 43,
    "return correctly from official submethod only";
is Foo::official(), 44,
    "return correctly from official sub only";

# https://github.com/Raku/old-issue-tracker/issues/1764
{
    sub 丧àìe̲𝐝() {
        return 1, 2, :c(3);
    }
    is 丧àìe̲𝐝().elems, 3,       'return with named arguments';
    is 丧àìe̲𝐝().[2].key, 'c',   ' ... correct key';
    is 丧àìe̲𝐝().[2].value, '3', ' ... correct value';
}

# https://github.com/Raku/old-issue-tracker/issues/537
{
    sub с中61732_개 { 1; CATCH {} }
    #?rakudo todo 'RT #61732'
    is с中61732_개(), 1, 'sub with empty catch block returns value before block';
}

{
    sub с中61732_𝐝 { 1;; }
    is с中61732_𝐝(), 1, 'get right value from sub with double ;';
}

# https://github.com/Raku/old-issue-tracker/issues/776
{
    sub с中63912 { return 1, 2; }
    lives-ok { с中63912() }, 'can call sub that returns two things (no parens)';
}

# https://github.com/Raku/old-issue-tracker/issues/1505
{
    class С专72836 {
        method new() { }
    }
    lives-ok {my $c = С专72836.new},
        'can use value returned from empty routine';
}

# https://github.com/Raku/old-issue-tracker/issues/465
{
    sub 丛àс61126($code) { $code() }; sub е갨갨61126 { 丛àс61126 { return 1 }; return 2; };
    is е갨갨61126, 1;

    sub 丛à丳61126 { eager map { return 1 }, 1; return 2 };
    is 丛à丳61126, 1;
}

# https://github.com/Raku/old-issue-tracker/issues/2982
{
    throws-like 'my class A { has Str method foo(--> Int) { "hi" } }', X::Redeclaration;
    throws-like 'my class A { has Int method foo() { return "hi" } }; A.foo', X::TypeCheck::Return;
}

{
    my sub сe̲中갮с丧-갈丧中 ($ч --> Int) { $ч }
    is сe̲中갮с丧-갈丧中(42), 42, "Can return 42 through Int typecheck";
    cmp-ok сe̲中갮с丧-갈丧中(Int), '===', Int, "Can return Int through Int typecheck";
    is сe̲中갮с丧-갈丧中(Nil), Nil, "Can return Nil through Int typecheck";
    ok сe̲中갮с丧-갈丧中(Failure.new) ~~ Failure, "Can return Failure through Int typecheck";
    dies-ok { сe̲中갮с丧-갈丧中(42.0) }, "Can't return 42.0 through Int typecheck";
    dies-ok { сe̲中갮с丧-갈丧中(Cool) }, "Can't return Cool through Int typecheck";
}

{
    my subset MyInt of Int:D where * % 2;
    my sub сe̲中갮с丧-Ìù갈丧中 ($ч --> MyInt) { $ч }
    is сe̲中갮с丧-Ìù갈丧中(13), 13, "Can return 42 through a subset typecheck";
    is сe̲中갮с丧-Ìù갈丧中(Nil), Nil, "Can return Nil through subset typecheck";
    ok сe̲中갮с丧-Ìù갈丧中(Failure.new) ~~ Failure, "Can return Failure through subset typecheck";
    dies-ok { сe̲中갮с丧-Ìù갈丧中(42) }, "Can't return through Int typecheck if 'where' constraint is broken";
    dies-ok { сe̲中갮с丧-Ìù갈丧中(Int) }, "Can't return typeobject through definite subset typecheck";
    dies-ok { сe̲中갮с丧-Ìù갈丧中(13.0) }, "Can't return 13.0 through subset typecheck";
    dies-ok { сe̲中갮с丧-Ìù갈丧中(Cool) }, "Can't return Cool through Int typecheck";
}

# https://github.com/Raku/old-issue-tracker/issues/5733
is sub { 42.return }(), 42, "Sub doing 42.return works";

# https://github.com/Raku/old-issue-tracker/issues/3453
#?rakudo skip 'default run outside sub'
is-deeply sub foo($ч = return 42) { 70 }(), 42,
    'can return from parameter defaults';

# https://github.com/rakudo/rakudo/issues/2201
lives-ok { sub foo(--> Callable:D) is rw { my $ч is default(Nil) = Nil; $ч }; foo },
    'Containerized Nil passes Callable:D constraint';

# vim: expandtab shiftwidth=4
