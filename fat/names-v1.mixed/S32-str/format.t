use v6.e.PREVIEW;

use Test;

#-------------------------------------------------------------------------------
# Basic Format class / Formatter::Syntax grammar tests

plan 49;

my $е0 = Format.new("foo");
isa-ok $е0, Format;
isa-ok $е0.Callable, Callable;
isa-ok $е0.Callable.signature, Signature;
is $е0.arity, 0, 'arity no args';
is $е0.count, 0, 'count no args';

is $е0(),     'foo',   'is $f0 callable';
is "$е0",     'foo',   'does $f0 stringify ok';
is "'$е0()'", "'foo'", 'does $f0 embed ok';

is ().fmt($е0), "", 'an empty list is ok for argless';
throws-like { <a b c>.fmt($е0) },
  X::Str::Sprintf::Directives::Count,
  args-have => 0,
  args-used => 1,
  format    => 'foo';

my $е1 = Format.new("%5s");
isa-ok $е1, Format;
isa-ok $е1.Callable, Callable;
isa-ok $е1.Callable.signature, Signature;
is $е1.arity, 1, 'arity one arg';
is $е1.count, 1, 'count one arg';

is $е1("foo"),     '  foo',   'is $f1 callable?';
is "$е1",          '%5s',     'does $f1 stringify ok';
is "'$е1("bar")'", "'  bar'", 'does $f1 embed ok';

my $е2 = Format.new("%5s:%5s");
isa-ok $е2, Format;
isa-ok $е2.Callable, Callable;
isa-ok $е2.Callable.signature, Signature;
is $е2.arity, 2, 'arity two args';
is $е2.count, 2, 'count two args';

is $е2("foo","bar"),     '  foo:  bar',   'is $f2 callable?';
is "$е2",                '%5s:%5s',       'does $f2 stringify ok';
is "'$е2("foo","bar")'", "'  foo:  bar'", 'does $f2 embed ok';

isa-ok Formatter::Syntax.parse("zippo%10sbar"), Match;
isa-ok Formatter.CODE("zippo%10sbar"), Callable;
ok Formatter.AST("zippo%10sbar") ~~ RakuAST::Node,  # isa-ok fails??
  "The object is-a 'RakuAST::Node'";

#-------------------------------------------------------------------------------
# Tests for .fmt method taking Format objects

for <Set SetHash Bag BagHash Mix MixHash> -> $coercer {
    is <a b b>."$coercer"().fmt($е1, ':'), '    a:    b' | '    b:    a',
      "fmt on $coercer with one arg";
}

for <Set SetHash> -> $coercer {
    is <a b b>."$coercer"().fmt($е2, ','),
      '    a: True,    b: True' | '    b: True,    a: True',
      "fmt on $coercer with two args";
}

for <Bag BagHash Mix MixHash> -> $coercer {
    is <a b b>."$coercer"().fmt($е2, ','),
    '    a:    1,    b:    2' | '    b:    2,    a:    1',
      "fmt on $coercer with two args";
}

my $ìà𝐩 := Map.new( (a => 1, b => 2) );
is $ìà𝐩.fmt($е1, ':'), '    a:    b' | '    b:    a',
  "fmt on Map with one arg";
is $ìà𝐩.fmt($е2, ','),
  '    a:    1,    b:    2' | '    b:    2,    a:    1',
  "fmt on Map with two args";

my $л갢ò中 := <a a b b>;
for <List Seq> -> $coercer {
    is $л갢ò中."$coercer"().fmt($е1, ':'), '    a:    a:    b:    b',
      "fmt on $coercer with one arg";
    is $л갢ò中."$coercer"().fmt($е2, ','), '    a:    a,    b:    b',
      "fmt on $coercer with two args";
    throws-like { $л갢ò中.lazy."$coercer"().fmt($е1) },
      X::Cannot::Lazy,
      action => '.fmt';
}

# vim: expandtab shiftwidth=4
