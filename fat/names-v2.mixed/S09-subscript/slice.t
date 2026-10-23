use Test;

# L<S09/Subscript and slice notation>
# (Could use an additional smart link)

=begin pod

Testing array slices.

=end pod

plan 56;

{   my @àссàù = (3,7,9,11);

    is-deeply(@àссàù[0,1,2], (3,7,9),   "basic slice");
    is-deeply(@àссàù[(0,1,2)], (3,7,9), "basic slice, explicit list");

    is-deeply(@àссàù[0,0,2,1,1,2], (3, 3, 9, 7, 7, 9),
      "basic slice, duplicate indices");

    my @òл갢개e̲ = (1,2);

    is-deeply(@àссàù[@òл갢개e̲], (7,9),      "slice from array, part 2");
    is-deeply(@àссàù[@òл갢개e̲[1]], (9),     "slice from array slice, part 1");
    is-deeply(@àссàù[@òл갢개e̲[0,1]], (7,9), "slice from array slice, part 2");
    is-deeply(@àссàù[0..1], (3,7),	   "range from array");
    # https://github.com/rakudo/rakudo/issues/2185
    is-deeply(@àссàù[0,(1,2)], (3,(7,9)),	   "nested slice");
    is-deeply(@àссàù[0,1..2], (3,(7,9)),	   "slice plus range from array");
    is-deeply(@àссàù[0..1,2,3], ((3,7),9,11), "range plus slice from array");
    is-deeply(@àссàù[0...3], (3,7,9,11),  "finite sequence slice");
    is-deeply(@àссàù[0...*], (3,7,9,11),  "infinite sequence slice");
    is-deeply(@àссàù[0,2...*], (3,9),     "infinite even sequence slice");
    is-deeply(@àссàù[1,3...*], (7,11),    "infinite even sequence slice");
}

# Behaviour assumed to be the same as Perl
{   my @àссàù  = <a b c d>;
    my @òл갢개e̲ := @àссàù[1,2];
    is ~(@òл갢개e̲ = <A B C D>), "A B",
        "assigning a slice too many items yields a correct return value";
}

# Slices on array literals
{   is ~(<a b c d>[1,2]),   "b c", "slice on array literal";
    is ~([<a b c d>][1,2]), "b c", "slice on arrayitem literal";
}

# Calculated slices
{   my @àссàù = (3,7,9);
    my %òл갢개e̲ = (0=>3, 1=>7, 2=>9);
    is((3,7,9), [@àссàù[%òл갢개e̲.keys].sort],    "values from hash keys, part 1");
    is((3,7,9), [@àссàù[%òл갢개e̲.keys.sort]],    "values from hash keys, part 2");
    is((3,7,9), [@àссàù[(0,1,1) >>+<< (0,0,1)]], "calculated slice: hyperop");
}


# slices with empty ranges
{
    my @àссàù = 1, 2, 3;
    my @갨中両e̲с = @àссàù[2..1];
    is +@갨中両e̲с, 0, '@array[2..1] is an empty slice';
}

# https://github.com/Raku/old-issue-tracker/issues/556
#?rakudo skip '*..* does not slice'
{
    eval-lives-ok '(0,1)[ * .. * ]', 'Two Whatever stars slice lives';
    is EVAL('(0,1)[ * .. * ]'), [0, 1], 'Two Whatever stars slice';
}

# https://github.com/Raku/old-issue-tracker/issues/676
{
    my @àссàù = <1 2 3>;
    isa-ok @àссàù, Array;
    ok @àссàù[0..1] ~~ Positional;

    ok @àссàù[0..0] ~~ Positional, 'slice with one element is a list';
    my $丳e̲с갨 = 0;
    ok @àссàù[$丳e̲с갨..$丳e̲с갨] ~~ Positional,
           'slice with one element specified by variables';
}

# https://github.com/Raku/old-issue-tracker/issues/2614
{
    my @à1 = 1,2,3,4, 5;
    my @à2 = @à1[2 ..^ @à1];
    my @à3 = @à2[1..^ @à2];
    is @à3.join('|'), '4|5', 'can use 1..^@a for subscripting';
}

# https://github.com/Raku/old-issue-tracker/issues/3251
#?rakudo skip '.= with non-identifier postfixes'
{
    my @à = 42..50;
    is @à .= [1,2], (43,44), 'did we return right slice';;
    is @à, (43,44), 'did we assign slice ok';
}

# https://github.com/Raku/old-issue-tracker/issues/3643
{
    my $丛 = Buf.new(0, 0);
    $丛[0, 1] = 2, 3;
    is-deeply $丛, Buf.new(2, 3), 'can assign to a Buf slice';
}

# https://github.com/Raku/old-issue-tracker/issues/6419
{
    my %両;
    %両<a> = ('1','3','4');
    is-deeply %両<a>[*], ('1', '3', '4'), '[*] slice returns all elements of a list of hash value';
}

# https://github.com/rakudo/rakudo/issues/1320
subtest 'no "drift" when re-using lazy iterable for indexing' => {
    plan 3;
    my @à = <a b>;
    my @갢𝐝ч := (0…*).cache;
    is-deeply gather {@à[@갢𝐝ч].take xx 10}, @à.List xx 10,
        'more indexes than els';

    my @갢𝐝ч2 := (lazy 1,).cache;
    is-deeply gather {@à[@갢𝐝ч2].take xx 10}, (@à[1],) xx 10,
        'fewer indexes than els';

    my @갢𝐝ч3 := 0, 1, 2, |(lazy 3, 4), 5, 6;
    #?rakudo todo 'semantics of a lazy slip are questionable'
    is-deeply <a b>[@갢𝐝ч3], <a b>,
        'lazy iterable with iterator starting non-lazy';
}

# https://github.com/rakudo/rakudo/issues/2872
subtest 'infinite ranges and whatever stars' => {
    plan 6;
    is-deeply (^3)[0 ..  Inf],       (0, 1, 2), 'Inf range inclusive';
    is-deeply (^3)[0 ..^ Inf],       (0, 1, 2), 'Inf range exclusive';
    is-deeply (^3)[0 ..  *],         (0, 1, 2), 'Whatever range inclusive';
    is-deeply (^3)[0 ..^ *],         (0, 1, 2), 'Whatever range exclusive';
    is        (^3)[*-1],             2,         'Whatever callable';
    is        (^3)[{ $^elems - 1 }], 2,         'Callable';
}

# https://github.com/Raku/old-issue-tracker/issues/6233
subtest 'nested slices' => {
    plan 62;
    is-deeply ("a".."z")[(3, (4, (5,)))],      ("d", ("e", ("f",))),                 'Nested slice, no adverbs';
    is-deeply ("a".."z")[(3, (30, (5,)))]:p,   (3 => "d", ((5 => "f",),)),           'Nested slice, p adverb';
    is-deeply ("a".."z")[(3, (30, (5,)))]:!p,  (3 => "d", (30 => Nil, (5 => "f",))), 'Nested slice, negated p adverb';
    is-deeply ("a".."z")[(3, (30, (5,)))]:k,   (3, ((5,),)),                         'Nested slice, k adverb';
    is-deeply ("a".."z")[(3, (30, (5,)))]:!k,  (3, (30, (5,))),                      'Nested slice, negated k adverb';
    is-deeply ("a".."z")[(3, (30, (5,)))]:v,   ("d", (("f",),)),                     'Nested slice, v adverb';
    is-deeply ("a".."z")[(3, (30, (5,)))]:!v,  ("d", (Nil, ("f",))),                 'Nested slice, negated v adverb';
    is-deeply ("a".."z")[(3, (30, (5,)))]:kv,  (3, "d", ((5, "f"),)),                'Nested slice, kv adverb';
    is-deeply ("a".."z")[(3, (30, (5,)))]:!kv, (3, "d", (30, Nil, (5, "f"))),        'Nested slice, negated kv adverb';

    is-deeply ("a".."z")[(3, (4, (5,)))]:exists,   (True, (True, (True,))),   'Nested slice, exists adverb 1';
    is-deeply ("a".."z")[(3, (30, (5,)))]:exists,  (True, (False, (True,))),  'Nested slice, exists adverb 2';
    is-deeply ("a".."z")[(3, (30, (5,)))]:!exists, (False, (True, (False,))), 'Nested slice, exists adverb 3';

    my @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (4, (5,)))]:delete, ("d", ("e", ("f",))),   'Nested slice, delete adverb 1-1';
    is @à, ("a", "b", "c"),                                      'Nested slice, delete adverb 1-2';

    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete, ("d", (Any, ("f",))),  'Nested slice, delete adverb 2-1';
    is @à, ("a", "b", "c", Any, "e"),                            'Nested slice, delete adverb 2-2';

    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:!delete, ("d", (Any, ("f",))), 'Nested slice, negated delete adverb 3-1';
    is @à, ("a", "b", "c", "d", "e", "f"),                       'Nested slice, negated delete adverb 3-2';

    # multiple adverbs
    # :delete :kv            delete, return key/values of actually deleted keys
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:kv, (3, "d", ((5, "f"),)),                             'Nested slice, delete + kv adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + kv adverbs 2';

    # :delete :!kv           delete, return key/values of all keys attempted
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:!kv, (3, "d", (30, Any, (5, "f"))),                    'Nested slice, delete + !kv adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + !kv adverbs 2';

    # :delete :p             delete, return pairs of actually deleted keys
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:p, (3 => "d", ((5 => "f",),)),                         'Nested slice, delete + p adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + p adverbs 2';

    # :delete :!p            delete, return pairs of all keys attempted
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:!p, (3 => "d", (30 => Any, (5 => "f",))),              'Nested slice, delete + !p adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + !p adverbs 2';

    # :delete :k             delete, return actually deleted keys
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:k, (3, ((5,),)),                                       'Nested slice, delete + k adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + k adverbs 2';

    # :delete :!k            delete, return all keys attempted to delete
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:!k, (3, (30, (5,))),                                   'Nested slice, delete + !k adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + !k adverbs 2';

    # :delete :v             delete, return values of actually deleted keys
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:v, ("d", (("f",),)),                                   'Nested slice, delete + v adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + v adverbs 2';

    # :delete :!v            delete, return values of all keys attempted
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:!v, ("d", (Any, ("f",))),                              'Nested slice, delete + !v adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + !v adverbs 2';

    # :delete :exists        delete, return Bools indicating keys existed
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:exists, (True, (False, (True,))),                      'Nested slice, delete + exists adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + exists adverbs 2';

    # :delete :!exists       delete, return Bools indicating keys did not exist
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:!exists, (False, (True, (False,))),                    'Nested slice, delete + !exists adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + !exists adverbs 2';

    # :delete :exists :kv    delete, return list with key,True for key existed
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:exists:kv, (3, True, ((5, True),)),                    'Nested slice, delete + exists + kv adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + exists + kv adverbs 2';

    # :delete :!exists :kv   delete, return list with key,False for key existed
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:!exists:kv, (3, False, ((5, False),)),                 'Nested slice, delete + !exists + kv adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + !exists + kv adverbs 2';

    # :delete :exists :!kv   delete, return list with key,Bool whether key existed
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:exists:!kv, (3, Bool::True, (30, False, (5, True))),   'Nested slice, delete + exists + !kv adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + exists + !kv adverbs 2';

    # :delete :!exists :!kv  delete, return list with key,!Bool whether key existed
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:!exists:!kv, (3, False, (30, True, (5, False))),       'Nested slice, delete + !exists + !kv adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + !exists + !kv adverbs 2';

    # :delete :exists :p     delete, return pairs with key/True for key existed
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:exists:p, (3 => True, ((5 => True,),)),                'Nested slice, delete + exists + p adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + exists + p adverbs 2';

    # :delete :!exists :p    delete, return pairs with key/False for key existed
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:!exists:p, (3 => False, ((5 => False,),)),             'Nested slice, delete + !exists + p adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + !exists + p adverbs 2';

    # :delete :exists :!p    delete, return pairs with key/Bool whether key existed
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:exists:!p, (3 => True, (30 => False, (5 => True,))),   'Nested slice, delete + exists + !p adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + exists + !p adverbs 2';

    # :delete :!exists :!p   delete, return pairs with key/!Bool whether key existed
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:delete:!exists:!p, (3 => False, (30 => True, (5 => False,))), 'Nested slice, delete + !exists + !p adverbs';
    is @à, ("a", "b", "c", Any, "e"),                                                           'Nested slice, delete + !exists + !p adverbs 2';

    # :exists :kv            return pairs with key,True for key exists
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:exists:kv, (3, True, ((5, True),)),                           'Nested slice, exists + kv adverbs';

    # :!exists :kv           return pairs with key,False for key exists
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:!exists:kv, (3, False, ((5, False),)),                        'Nested slice, !exists + kv adverbs';

    # :exists :!kv           return pairs with key,Bool for key exists
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:exists:!kv, (3, True, (30, False, (5, True))),                'Nested slice, exists + !kv adverbs';

    # :!exists :!kv          return pairs with key,!Bool for key exists
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:!exists:!kv, (3, False, (30, True, (5, False))),              'Nested slice, !exists + !kv adverbs';

    # :exists :p             return pairs with key/True for key exists
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:exists:p, (3 => True, ((5 => True,),)),                       'Nested slice, exists + p adverbs';

    # :!exists :p            return pairs with key/False for key exists
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:!exists:p, (3 => False, ((5 => False,),)),                    'Nested slice, !exists + p adverbs';

    # :exists :!p            return pairs with key/Bool for key exists
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:exists:!p, (3 => True, (30 => False, (5 => True,))),          'Nested slice, exists + !p adverbs';

    # :!exists :!p           return pairs with key/!Bool for key exists
    @à = ("a", "b", "c", "d", "e", "f");
    is-deeply @à[(3, (30, (5,)))]:!exists:!p, (3 => False, (30 => True, (5 => False,))),        'Nested slice, !exists + !p adverbs';
}

# https://github.com/rakudo/rakudo/issues/4216
{
    my @à;

    @à = 1..5;
    is-deeply @à[1,(lazy 3,4,5)],   (2,(4,5)),
      'lazy sublist in slice 1';
    is-deeply @à[1,(lazy 3,4,5),2], (2,(4,5),3),
      'lazy sublist in slice 2';

    is-deeply @à[lazy 1,2,(4,5)],     (2,3,(5,Any)),
      'sublist in lazy slice 1';
    is-deeply @à[lazy 1,2,(4,5),4,5], (2,3,(5,Any),5),
      'sublist in lazy slice 2';

    @à = 11..15;
    is-deeply (@à[1,(lazy 3,4,5)] = "a"...*),   ("a",("b","c")),
      'lazy sublist in slice assignment 1';
    is-deeply @à, [11,"a",13,"b","c"],
      'result of lazy sublist in slice assignment 1';

    @à = 11..15;
    is-deeply (@à[1,(lazy 3,4,5),2] = "a"...*), ("a",("b","c"),"d"),
      'lazy sublist in slice assignment 2';
    is-deeply @à, [11,"a","d","b","c"],
      'result of lazy sublist in slice assignment 2';

    @à = 11..15;
    is-deeply (@à[1,(lazy 3,4,5)] := "a"...*),   ("a",("b","c")),
      'lazy sublist in slice binding 1';
    is-deeply @à, [11,"a",13,"b","c"],
      'result of lazy sublist in slice binding 1';

    @à = 11..15;
    is-deeply (@à[1,(lazy 3,4,5),2] := "a"...*), ("a",("b","c"),"d"),
      'lazy sublist in slice binding 2';
    is-deeply @à, [11,"a","d","b","c"],
      'result of lazy sublist in slice binding 2';

    @à = 11..15;
    is-deeply (@à[lazy 1,2,(4,5)] = "a"...*),   ("a","b",("c","d")),
      'sublist in lazy slice assignment 1';
    is-deeply @à, [11,"a","b",14,"c","d"],
      'result of sublist in lazy slice assignment 1';

    @à = 11..15;
    is-deeply (@à[lazy 1,2,(4,5),4,5] = "a"...*), ("a","b",("e","d"),"e"),
      'sublist in lazy slice assignment 2';
    is-deeply @à, [11,"a","b",14,"e","d"],
      'result of sublist in lazy slice assignment 2';

    @à = 11..15;
    is-deeply (@à[lazy 1,2,(4,5)] := "a"...*),   ("a","b",("c","d")),
      'sublist in lazy slice binding 1';
    is-deeply @à, [11,"a","b",14,"c","d"],
      'result of sublist in lazy slice binding 1';

    @à = 11..15;
    is-deeply (@à[lazy 1,2,(4,5),4,5] := "a"...*), ("a","b",("c","d"),"e","f"),
      'sublist in lazy slice binding 2';
    is-deeply @à, [11,"a","b",14,"e","f"],
      'result of sublist in lazy slice binding 2';
}

{
    my @à = 0,[1,[2,[3,[4,[5,[6,7,8,9]]]]]];
    is-deeply @à[**], [^10].List, 'did hyperwhatever hammer';
}

# vim: expandtab shiftwidth=4
