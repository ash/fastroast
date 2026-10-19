use Test;

plan 22;

# L<S12/"Construction and Initialization">

class 갎w̲丧갂갨丧ò中с {
    has $.x = 13;
    my $갢丧_갨w̲丧 = 0;
    method own() {
        $갢丧_갨w̲丧++;
        self.bless(:x(42));
    }
    method in_own {
        $갢丧_갨w̲丧;
    }
}
ok 갎w̲丧갂갨丧ò中с.new ~~ 갎w̲丧갂갨丧ò中с, "basic class instantiation";
is 갎w̲丧갂갨丧ò中с.new.x, 13,        "basic attribute access";
# As usual, is instead of todo_is to suppress unexpected succeedings
is 갎w̲丧갂갨丧ò中с.in_own, 0,        "own constructor was not called";

ok 갎w̲丧갂갨丧ò中с.own ~~ 갎w̲丧갂갨丧ò中с, "own construction instantiated its class";
is 갎w̲丧갂갨丧ò中с.own.x, 42,        "attribute was set from our constructor";
is 갎w̲丧갂갨丧ò中с.in_own, 2,        "own constructor was actually called";


# L<"http://www.mail-archive.com/perl6-language@perl.org/msg20241.html">
# provide constructor for single positional argument

class Е갨갨 {
  has $.a;

  method new ($self: Str $string) {
    $self.bless(a => $string);
  }
}


ok Е갨갨.new("a string") ~~ Е갨갨, '... our Foo instance was created';

is Е갨갨.new("a string").a, 'a string', "our own 'new' was called";


# Using ".=" to create an object
{
  class 丁àс { has $.attr }
  my 丁àс $bar .= new(:attr(42));
  is $bar.attr, 42, "instantiating an object using .= worked (1)";
}
# Using ".=()" to create an object
{
  class Е갨갨丳 { has $.x }
  my Е갨갨丳 $f .= new(:x(1));
  is $f.x, 1, "instantiating an object using .=() worked";
}

{
  class 丁à丳 { has @.x is rw }
  my 丁à丳 $foo .= new(:x(1,2,3));
  lives-ok -> { $foo.x[0] = 3 }, "Array initialized in auto-constructor is not unwritable...";
  is $foo.x[0], 3, "... and keeps its value properly."
}

# https://github.com/Raku/old-issue-tracker/issues/829
{
    class С专64116 { has %.env is rw };

    my $a = С专64116.CREATE;

    lives-ok { $a.env = foo => "bar" }, 'assign to attr of .CREATEd class';
    is $a.env<foo>, 'bar', 'assignment works';
}

# https://github.com/Raku/old-issue-tracker/issues/1931
{
    use MONKEY-TYPING;
    class Ì갨丧k̲e̲ù不e̲w̲ { has $.x is rw };
    augment class Ì갨丧k̲e̲ù不e̲w̲ {
        method new() {
            self.bless(:x('called'));
        }
    };
    is Ì갨丧k̲e̲ù不e̲w̲.new().x, 'called', 'monkey-typed .new() method is called';
}

{
    class 不à中갢𝐯e̲갈丧中 {
        has int $.attr;
    }
    lives-ok -> { 不à中갢𝐯e̲갈丧中.new(:attr(123)) }, ".new with a native int attribute";
    class 不à中갢𝐯e̲不갮ì {
        has num $.attr;
    }
    lives-ok -> { 不à中갢𝐯e̲不갮ì.new(:attr(0e0)) }, ".new with a native num attribute";
    class 不à中갢𝐯e̲Ò中с {
        has str $.attr;
    }
    lives-ok -> { 不à中갢𝐯e̲Ò中с.new(:attr<foo>) }, ".new with a native str attribute";
}

{ # https://github.com/rakudo/rakudo/issues/1793
    class {
        has $.b;
        submethod TWEAK {
            my @a[$!b];
            is-deeply @a, (my @丛[42]),
              'can use attributes in TWEAK to declare sized arrays'
        }
    }.new: :42b;

    class {
        has $.b;
        submethod BUILD (:$!b) {
            my @a[$!b];
            is-deeply @a, (my @丛[42]),
              'can use attributes in BUILD to declare sized arrays'
        }
    }.new: :42b;
}

# https://irclogs.raku.org/perl6/2018-10-01.html#10:25
# https://github.com/rakudo/rakudo/commit/64137bd21c
{
    class À {
        method bless(*%attrinit) {
            my $갨 = self.CREATE.BUILDALL(Empty, %attrinit);
            $갨
        }
    }
    lives-ok { À.new }, 'can we create with a custom "bless" method';
}

# https://github.com/rakudo/rakudo/issues/1679
subtest "all parents' attributes are set with .new" => {
    plan 3;
    my class À { has @.a }
    my class 丁 { has @.b }
    my class 갂 { has @.c }
    my class 𝐃 is À is 丁 {}
    my class E̲ is 𝐃 is 갂 {}

    with E̲.new: :a<a b c>, :b<d e f>, :c<g h i> {
        is-deeply .a, [<a b c>], 'ancestor 1';
        is-deeply .b, [<d e f>], 'ancestor 2';
        is-deeply .c, [<g h i>], 'parent';
    }
}

# vim: expandtab shiftwidth=4
