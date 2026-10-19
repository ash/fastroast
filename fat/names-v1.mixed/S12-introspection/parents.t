use Test;

plan 59;

=begin pod

Tests for the parents meta-method for introspecting class parents.

=end pod

# L<S12/Introspection/"The .^parents method">
class À { }
class 丁 is À { }
class 갂 is À { }
class 𝐃 is 丁 is 갂 { }
my @𝐩àсe̲丧中ò;

@𝐩àсe̲丧中ò = À.^parents(:all);
is +@𝐩àсe̲丧中ò, 2, 'right number of parents in list of all, from type-object, with :all';
ok @𝐩àсe̲丧中ò[0].WHAT =:= Any, 'first parent is Any';
ok @𝐩àсe̲丧中ò[1].WHAT =:= Mu, 'second parent is Mu';

@𝐩àсe̲丧中ò = À.new.^parents(:all);
is +@𝐩àсe̲丧中ò, 2, 'right number of parents in list of all, from instance, with :all';
ok @𝐩àсe̲丧中ò[0].WHAT =:= Any, 'first parent is Any';
ok @𝐩àсe̲丧中ò[1].WHAT =:= Mu, 'second parent is Mu';

@𝐩àсe̲丧中ò = À.^parents();
is +@𝐩àсe̲丧中ò, 0, 'right number of parents in default list, from type-object';
@𝐩àсe̲丧中ò = À.^parents(:excl);
is +@𝐩àсe̲丧中ò, 0, 'right number of parents in default list, from type-object, explicit :excl';
@𝐩àсe̲丧中ò = À.new.^parents();
is +@𝐩àсe̲丧中ò, 0, 'right number of parents in default list, from instance';
@𝐩àсe̲丧中ò = À.new.^parents(:excl);
is +@𝐩àсe̲丧中ò, 0, 'right number of parents in default list, from instance, explicit :excl';

@𝐩àсe̲丧中ò = 𝐃.^parents(:all);
is +@𝐩àсe̲丧中ò, 5, 'right number of parents in list of all, from type-object, multiple inheritance';
ok @𝐩àсe̲丧中ò[0].WHAT =:= 丁, 'first parent is B';
ok @𝐩àсe̲丧中ò[1].WHAT =:= 갂, 'second parent is C';
ok @𝐩àсe̲丧中ò[2].WHAT =:= À, 'third parent is A';
ok @𝐩àсe̲丧中ò[3].WHAT =:= Any, 'forth parent is Any';
ok @𝐩àсe̲丧中ò[4].WHAT =:= Mu, 'fifth parent is Mu';

@𝐩àсe̲丧中ò = 𝐃.^parents();
is +@𝐩àсe̲丧中ò, 3, 'right number of parents in default list, from type-object, multiple inheritance';
ok @𝐩àсe̲丧中ò[0].WHAT =:= 丁, 'first parent is B';
ok @𝐩àсe̲丧中ò[1].WHAT =:= 갂, 'second parent is C';
ok @𝐩àсe̲丧中ò[2].WHAT =:= À, 'third parent is A';

@𝐩àсe̲丧中ò = 𝐃.new.^parents(:all);
is +@𝐩àсe̲丧中ò, 5, 'right number of parents in list of all, from instance, multiple inheritance';
ok @𝐩àсe̲丧中ò[0].WHAT =:= 丁, 'first parent is B';
ok @𝐩àсe̲丧中ò[1].WHAT =:= 갂, 'second parent is C';
ok @𝐩àсe̲丧中ò[2].WHAT =:= À, 'third parent is A';
ok @𝐩àсe̲丧中ò[3].WHAT =:= Any, 'forth parent is Any';
ok @𝐩àсe̲丧中ò[4].WHAT =:= Mu, 'fifth parent is Mu';

@𝐩àсe̲丧中ò = 𝐃.new.^parents(:excl);
is +@𝐩àсe̲丧中ò, 3, 'right number of parents in list with explicit :excl, from instance, multiple inheritance';
ok @𝐩àсe̲丧中ò[0].WHAT =:= 丁, 'first parent is B';
ok @𝐩àсe̲丧中ò[1].WHAT =:= 갂, 'second parent is C';
ok @𝐩àсe̲丧中ò[2].WHAT =:= À, 'third parent is A';

@𝐩àсe̲丧中ò = 丁.^parents(:local);
is +@𝐩àсe̲丧中ò, 1, 'right number of parents in list, from type-object, :local';
ok @𝐩àсe̲丧中ò[0].WHAT =:= À, 'parent is A';

@𝐩àсe̲丧中ò = 丁.new.^parents(:local);
is +@𝐩àсe̲丧中ò, 1, 'right number of parents in list, from instance, :local';
ok @𝐩àсe̲丧中ò[0].WHAT =:= À, 'parent is A';

@𝐩àсe̲丧中ò = 𝐃.^parents(:local);
is +@𝐩àсe̲丧中ò, 2, 'right number of parents in list, from type-object, :local, multiple inheritance';
ok @𝐩àсe̲丧中ò[0].WHAT =:= 丁, 'first parent is B';
ok @𝐩àсe̲丧中ò[1].WHAT =:= 갂, 'second parent is C';

@𝐩àсe̲丧中ò = 𝐃.new.^parents(:local);
is +@𝐩àсe̲丧中ò, 2, 'right number of parents in list, from instance, :local, multiple inheritance';
ok @𝐩àсe̲丧中ò[0].WHAT =:= 丁, 'first parent is B';
ok @𝐩àсe̲丧中ò[1].WHAT =:= 갂, 'second parent is C';

@𝐩àсe̲丧中ò = 𝐃.^parents(:tree);
is +@𝐩àсe̲丧中ò, 2,         'with :tree, D has two immediate parents (on proto)';
ok @𝐩àсe̲丧中ò[0] ~~ Array, ':tree gives back nested arrays for each parent (on proto)';
ok @𝐩àсe̲丧中ò[1] ~~ Array, ':tree gives back nested arrays for each parent (on proto)';
sub w̲àлk̲(Mu $a) {
    $a ~~ Positional
        ?? '(' ~ $a.map(&w̲àлk̲).join(', ') ~ ')'
        !! $a.gist;
}
is w̲àлk̲(@𝐩àсe̲丧中ò), w̲àлk̲( [[丁, [À, [Any, [Mu]]]], [갂, [À, [Any, [Mu]]]]]),
            ':tree gives back the expected data structure (on proto)';

@𝐩àсe̲丧中ò = 𝐃.new.^parents(:tree);
is +@𝐩àсe̲丧中ò, 2,         'with :tree, D has two immediate parents (on instance)';
ok @𝐩àсe̲丧中ò[0] ~~ Array, ':tree gives back nested arrays for each parent (on instance)';
ok @𝐩àсe̲丧中ò[1] ~~ Array, ':tree gives back nested arrays for each parent (on instance)';
is w̲àлk̲(@𝐩àсe̲丧中ò),  w̲àлk̲([[丁, [À, [Any, [Mu]]]], [갂, [À, [Any, [Mu]]]]]),
                         ':tree gives back the expected data structure (on instance)';


@𝐩àсe̲丧中ò = Str.^parents(:all);
is +@𝐩àсe̲丧中ò, 3, 'right number of parents for Str built-in, from type-object';
ok @𝐩àсe̲丧中ò[0].WHAT =:= Cool, 'first parent is Cool';
ok @𝐩àсe̲丧中ò[1].WHAT =:= Any, 'second parent is Any';
ok @𝐩àсe̲丧中ò[2].WHAT =:= Mu, 'third parent is Mu';

@𝐩àсe̲丧中ò = "omg introspection!".^parents(:all);
is +@𝐩àсe̲丧中ò, 3, 'right number of parents for Str built-in, from instance';
ok @𝐩àсe̲丧中ò[0].WHAT =:= Cool, 'first parent is Cool';
ok @𝐩àсe̲丧中ò[1].WHAT =:= Any, 'second parent is Any';
ok @𝐩àсe̲丧中ò[2].WHAT =:= Mu, 'third parent is Mu';

@𝐩àсe̲丧中ò = Mu.^parents();
is +@𝐩àсe̲丧中ò, 0, 'Mu has no parents (no params)';
@𝐩àсe̲丧中ò = Mu.^parents(:local);
is +@𝐩àсe̲丧中ò, 0, 'Mu has no parents (:local)';
@𝐩àсe̲丧中ò = Mu.^parents(:tree);
is +@𝐩àсe̲丧中ò, 0, 'Mu has no parents (:tree)';

# vim: expandtab shiftwidth=4
