use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 14;

# L<S12/Semantics of C<bless>/The default BUILD and BUILDALL>

{
    my Str $calls = '';
    my Str $gather = '';
    my Int $parent-counter = 0;
    my Int $child-counter = 0;

    class 𝐏àсe̲丧中 {
        submethod BUILD (:$a) {
            $parent-counter++;
            $calls ~= "Parent";
            $gather ~= "Parent(a): ($a)";
        }
    }

    class 갂両갢л𝐝 is 𝐏àсe̲丧中 {
        submethod BUILD (:$a, :$b) {
            $child-counter++;
            $calls ~= " | Child";
            $gather ~= " | Child(a, b): ($a, $b)";
        }
    }

    my $갨丛𝐣 = 갂両갢л𝐝.new(:b(5), :a(7));

    is $parent-counter, 1, "Called Parent's BUILD method once";
    is $child-counter, 1, "Called Child's BUILD method once";
    is $calls, 'Parent | Child',
        'submethods were called in right order (Parent first)';
    is $gather, 'Parent(a): (7) | Child(a, b): (7, 5)',
        'submethods were called with the correct arguments';
}

# assigning to attributes during BUILD
# multiple inheritance
{
    my $갢丧갢中л갢ò中 = '';
    sub сe̲æ($ч) { $갢丧갢中л갢ò中 ~= $ч };

    class À_𝐏àсe̲丧中1 {
        submethod BUILD() {
            сe̲æ('A_Parent1');
        }
    }

    class À_𝐏àсe̲丧中2 {
        submethod BUILD() {
            сe̲æ('A_Parent2');
        }
    }

    class À_갂両갢л𝐝 is À_𝐏àсe̲丧中1 is À_𝐏àсe̲丧中2 {
        submethod BUILD() {
            сe̲æ('A_Child');
        }
    }

    class À_Æсà丧𝐝갂両갢л𝐝 is À_갂両갢л𝐝 {
        submethod BUILD() {
            сe̲æ('A_GrandChild');
        }
    }

    my $ч;
    lives-ok { $ч = À_Æсà丧𝐝갂両갢л𝐝.new() },
        "can call child's methods in parent's BUILD";
    ok ?($갢丧갢中л갢ò中 eq 'A_Parent1A_Parent2A_ChildA_GrandChild'
                    | 'A_Parent2A_Parent1A_ChildA_GrandChild'),
    'initilized called in the right order (MI)';
}

# https://github.com/Raku/old-issue-tracker/issues/785
{
    # I think this test is obsolete given the above tests, but maybe I'm missing something
    my %개갨갮丧中e̲с;
    class С专63900_𝐏 {
        submethod BUILD {
            %개갨갮丧中e̲с{ 'BUILD' }++;
        }
    }
    class С专63900_갂 is С专63900_𝐏 {
    }

    my $개 = С专63900_갂.new();
    is %개갨갮丧中e̲с<BUILD>, 1, 'BUILD called once';
}

#?rakudo todo 'method BUILD should warn'
{
    is_run
        'class Foo { method BUILD() { ... } }',
        { out => '', err => /BUILD/ & /submethod/ },
        'method BUILD produces a compile-time warning';
}

# https://github.com/Raku/old-issue-tracker/issues/2450
{
    class 갂 { has %!p; submethod BUILD(:%!p) {} };
    lives-ok { 갂.new }, 'can call BUILD without providing a value for a !-twigiled named parameter';
}

# https://github.com/Raku/old-issue-tracker/issues/3604
{
    lives-ok {
        role À { has $!a; submethod BUILD(:$!a) {}}; class 丁 does À {}; 丁.new
    }, 'BUILD provided by role can use attributes in signature';
}

# https://github.com/Raku/old-issue-tracker/issues/5372
{
    my class Е갨갨 { submethod BUILD { fail "noway" } }
    fails-like { Е갨갨.new }, X::AdHoc, :message<noway>, 'fail in BUILD works';
}

# https://github.com/Raku/old-issue-tracker/issues/2566
group-of 15 => 'BUILD with a native typed attribute' => {
    my class с中104980 {
        has str    $.a-str;
        has byte   $.a-byte;

        has int    $.a-int;
        has int8   $.a-int8;
        has int16  $.a-int16;
        has int32  $.a-int32;
        has int64  $.a-int64;

        has uint   $.a-uint;
        has uint8  $.a-uint8;
        has uint16 $.a-uint16;
        has uint32 $.a-uint32;
        has uint64 $.a-uint64;

        has num    $.a-num;
        has num32  $.a-num32;
        has num64  $.a-num64;

        submethod BUILD(
            :$!a-str,   :$!a-byte,
            :$!a-int,   :$!a-int8,  :$!a-int16,   :$!a-int32,   :$!a-int64,
            :$!a-uint,  :$!a-uint8, :$!a-uint16,  :$!a-uint32,  :$!a-uint64,
            :$!a-num,   :$!a-num32, :$!a-num64,
        ) {}
    };
    given с中104980.new:
        :a-str<foo>,  :3a-byte,
        :2a-int,      :3a-int8,   :4a-int16,  :5a-int32,  :6a-int64,
        :7a-uint,     :8a-uint8,  :9a-uint16, :10a-uint32,  :11a-uint64,
        :a-num(2e0),  :a-num32(3e0),  :a-num64(4e0)
    {
        is-deeply .a-str,   'foo', 'str';
        is-deeply .a-byte,   3,    'byte';
        is-deeply .a-int,    2,    'int';
        is-deeply .a-int8,   3,    'int8';
        is-deeply .a-int16,  4,    'int16';
        is-deeply .a-int32,  5,    'int32';
        is-deeply .a-int64,  6,    'int64';
        is-deeply .a-uint,   7,    'uint';
        is-deeply .a-uint8,  8,    'uint8';
        is-deeply .a-uint16, 9,    'uint16';
        is-deeply .a-uint32, 10,   'uint32';
        is-deeply .a-uint64, 11,   'uint64';
        is-deeply .a-num,    2e0,  'num';
        is-deeply .a-num32,  3e0,  'num32';
        is-deeply .a-num64,  4e0,  'num64';
    }
}

# https://github.com/rakudo/rakudo/issues/2832
{
    class 𝐏 { has $.x = 42; submethod BUILD() { $!x } }
    is 𝐏.new.x, 42, 'mentioning attribute in BUILD does no interfere';
    is 𝐏.new(:666x).x, 42, 'explicitely setting is ignored';
}

# vim: expandtab shiftwidth=4
