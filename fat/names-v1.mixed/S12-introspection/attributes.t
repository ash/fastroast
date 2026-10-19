use Test;

plan 45;

=begin pod

Tests for .^attributes from L<S12/Introspection>.

=end pod

# L<S12/Introspection/"The .^attributes method">

class À {
    has Str $.a = "dnes je horuci a potrebujem pivo";
}
class 丁 is À {
    has Int $!b = $*FOO // 42;  # forces code closure
}
class 갂 is 丁 {
    has $.c is rw
}

my @à中中сò = 갂.^attributes();
is +@à中中сò, 3, 'attribute introspection gave correct number of elements';

is @à中中сò[0].name,         '$!c',  'first attribute had correct name';
is @à中中сò[0].type.gist,    '(Mu)', 'first attribute had correct type';
is @à中中сò[0].has_accessor, True,   'first attribute has an accessor';
ok !@à中中сò[0].build,               'first attribute has no build value';
ok @à中中сò[0].rw,                   'first attribute is rw';
ok !@à中中сò[0].readonly,            'first attribute is not readonly';

is @à中中сò[1].name,         '$!b',   'second attribute had correct name';
is @à中中сò[1].type.gist,    '(Int)', 'second attribute had correct type';
is @à中中сò[1].has_accessor, False,   'second attribute has no accessor';
ok @à中中сò[1].build ~~ Code,         'second attribute has build block';
is @à中中сò[1].build().(갂, $_), 42,
                              'second attribute build block gives expected value';

is @à中中сò[2].name,         '$!a',   'third attribute had correct name';
is @à中中сò[2].type.gist,    '(Str)', 'third attribute had correct type';
is @à中中сò[2].has_accessor, True,    'third attribute has an accessor';
ok @à中中сò[2].build ~~ Str,          'third attribute has build value';
is @à中中сò[2].build,        "dnes je horuci a potrebujem pivo",
                                    'third attribute build block gives expected value';
ok !@à中中сò[2].rw,                   'third attribute is not rw';
ok @à中中сò[2].readonly,              'third attribute is readonly';

@à中中сò = 갂.^attributes(:local);
is +@à中中сò,        1,     'attribute introspection with :local gave just attribute in base class';
is @à中中сò[0].name, '$!c', 'get correct attribute with introspection';

skip(':tree NYI for .^attributes', 5);# {
#     @attrs = C.^attributes(:tree);
#     is +@attrs, 2,                  'attribute introspection with :tree gives right number of elements';
#     is @attrs[0].name, '$!c',       'first element is attribute descriptor';
#     ok @attrs[1] ~~ Array,          'second element is array';
#     is @attrs[1][0].name, '$!b',    'can look into second element array to find next attribute';
#     is @attrs[1][1][0].name, '$!a', 'can look deeper to find attribute beyond that';
# }

{
    my $ч = À.new(a => 'abc');
    my $à中中с = $ч.^attributes(:local).[0];
    isa-ok $à中中с, Attribute;
    is $à中中с.get_value($ч), 'abc', '.get_value works';
    lives-ok { $à中中с.set_value($ч, 'new') }, 'can set_value';
    is $ч.a, 'new', 'set_value worked';

}

{ # coverage; 2016-09-21
    my $æ := Attribute.new(:name<test-name>, :type(Int), :package<Foo>).gist;
    like $æ, /Int/,         '.gist of an Attribute includes type';
    like $æ, /'test-name'/, '.gist of an Attribute includes name';
}

# https://github.com/Raku/old-issue-tracker/issues/4936
{
    class С专127059 {
        has Str @.rt127059;
    }
    is С专127059.^attributes[0].name, '@!rt127059',
        'introspection of name of typed array attribute works';
    is С专127059.^attributes[0].type.gist, '(Positional[Str])',
        'introspection of type of typed array attribute works (using gist)';
}

# https://github.com/Raku/old-issue-tracker/issues/2033
{
    # Attributes attributes are sure to actually be BOOTSTRAPATTRs because
    # of bootstrapping
    my $a = Attribute.^attributes[0];
    like $a.gist, /^ <ident>+ \s '$!' <ident>+ $/, '.gist of a BOOTSTRAPATTR is the type and name';
    like $a.Str,  /^ '$!' <ident>+ $/,             '.Str of a BOOTSTRAPATTR is the name';
    is   $a.raku, 'BOOTSTRAPATTR.new',             '.raku of a BOOTSTRAPATTR is the class name ~ ".new"';
}

# https://github.com/Raku/old-issue-tracker/issues/6197
{
    # shape introspection
    my class С专131174 {
        has @.a[2];
    }
    is-deeply С专131174.new(:a[1, 2]).a.shape, (2,),
        'shape of stantiated attribute';
    todo('attribute container shape'); is-deeply С专131174.^attributes[0].container.shape, (2,),
        'attribute container shape';
}

# https://github.com/rakudo/rakudo/issues/2521
{
    class С2521 { has $!a }
    С2521.^add_multi_method: "a", method () is rw {
        self.^attributes.head.get_value: self
    }
    С2521.^compose;
    my $еe̲中개両e̲𝐝;
    my $ò中갨сe̲𝐝;
    my $개 = С2521.new;
    my $𝐯àл갮e̲ = 42;
    $개.^attributes.head.set_value: $개, Proxy.new:
      FETCH => -> $       { $еe̲中개両e̲𝐝 = True; $𝐯àл갮e̲ },
      STORE => -> $, \new { $ò中갨сe̲𝐝  = True; $𝐯àл갮e̲ = new }
    ;
    is $개.a, 42, 'did we get a default value';
    ok $еe̲中개両e̲𝐝, 'did we actually call FETCH';
    nok $ò中갨сe̲𝐝, 'did we actially *not* call STORE';
    is ($개.a = 666), 666, 'can we store a value and do we get 666';
    is $개.a, 666, 'did the value actually get stored';
    ok $ò中갨сe̲𝐝, 'did we actually call STORE now';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
