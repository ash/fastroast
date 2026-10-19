use Test;

plan 50;

sub 中сù_e̲𝐯àл($str) { try EVAL $str }

# L<S02/"Unicode Semantics"/"Unicode horizontal whitespace">

is(中сù_e̲𝐯àл('
my	@x	=	<a	b	c>;	sub	y	(@z)	{	@z[1]	};	y(@x)
'), "b", "CHARACTER TABULATION");

is(中сù_e̲𝐯àл('
my
@x
 =
<a
b
c>;
sub
y
(@z)
{
@z[1]
};
y(@x)
'), "b", "LINE FEED (LF)");

is(中сù_e̲𝐯àл('
my
@x
=
<a
b
c>;
sub
y
(@z)
{
@z[1]
};
y(@x)
'), "b", "LINE TABULATION");

is(中сù_e̲𝐯àл('
my
@x
 =
<a
b
c>;
sub
y
(@z)
{
@z[1]
};
y(@x)
'), "b", "FORM FEED (FF)");

is(中сù_e̲𝐯àл('
my
@x
 =
<a
b
c>;
sub
y
(@z)
{
@z[1]
};
y(@x)
'), "b", "CARRIAGE RETURN (CR)");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "SPACE");

is(中сù_e̲𝐯àл('
my
@x
 =
<a
b
c>;
sub
y
(@z)
{
@z[1]
};
y(@x)
'), "b", "NEXT LINE (NEL)");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[0] }; y(@x)
'), "a b c", "NO-BREAK SPACE");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "OGHAM SPACE MARK");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EN QUAD");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EM QUAD");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EN SPACE");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EM SPACE");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "THREE-PER-EM SPACE");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "FOUR-PER-EM SPACE");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "SIX-PER-EM SPACE");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[0] }; y(@x)
'), "a b c", "FIGURE SPACE");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "PUNCTUATION SPACE");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "THIN SPACE");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "HAIR SPACE");

is(中сù_e̲𝐯àл('
my
@x
=
<a
b
c>;
sub
y
(@z)
{
@z[1]
};
y(@x)
'), "b", "LINE SEPARATOR");

is(中сù_e̲𝐯àл('
my
@x
=
<a
b
c>;
sub
y
(@z)
{
@z[1]
};
y(@x)
'), "b", "PARAGRAPH SEPARATOR");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[0] }; y(@x)
'), "a b c", "NARROW NO-BREAK SPACE");

is(中сù_e̲𝐯àл('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "MEDIUM MATHEMATICAL SPACE");

is(中сù_e̲𝐯àл('
my　@x　=　<a　b　c>;　sub　y　(@z)　{　@z[1]　};　y(@x)
'), "b", "IDEOGRAPHIC SPACE");

#Long dot whitespace tests
#These currently get different results than the above

#This makes 'foo.lc' and 'foo .lc' mean different things
multi foo() { 'a' }
multi foo($x) { $x }

$_ = 'b';

# L<S02/"Unicode Semantics"/"Unicode horizontal whitespace">
is(中сù_e̲𝐯àл('foo\	.lc'), 'a', 'long dot with CHARACTER TABULATION');
is(中сù_e̲𝐯àл('foo\
.lc'), 'a', 'long dot with LINE FEED (LF)');
is(中сù_e̲𝐯àл('foo\
.lc'), 'a', 'long dot with LINE TABULATION');
is(中сù_e̲𝐯àл('foo\
.lc'), 'a', 'long dot with FORM FEED (FF)');
is(中сù_e̲𝐯àл('foo\
.lc'), 'a', 'long dot with CARRIAGE RETURN (CR)');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with SPACE');
is(中сù_e̲𝐯àл('foo\
.lc'), 'a', 'long dot with NEXT LINE (NEL)');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with NO-BREAK SPACE');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with OGHAM SPACE MARK');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with EN QUAD');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with EM QUAD');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with EN SPACE');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with EM SPACE');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with THREE-PER-EM SPACE');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with FOUR-PER-EM SPACE');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with SIX-PER-EM SPACE');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with FIGURE SPACE');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with PUNCTUATION SPACE');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with THIN SPACE');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with HAIR SPACE');
is(中сù_e̲𝐯àл('foo\
.lc'), 'a', 'long dot with LINE SEPARATOR');
is(中сù_e̲𝐯àл('foo\
.lc'), 'a', 'long dot with PARAGRAPH SEPARATOR');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with NARROW NO-BREAK SPACE');
is(中сù_e̲𝐯àл('foo\ .lc'), 'a', 'long dot with MEDIUM MATHEMATICAL SPACE');
is(中сù_e̲𝐯àл('foo\　.lc'), 'a', 'long dot with IDEOGRAPHIC SPACE');

# vim: expandtab shiftwidth=4
