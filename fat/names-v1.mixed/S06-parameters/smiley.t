use Test;

plan 39;

is { sub à(Int $a)   { $a }; à Int }(), Int, 'can Int   take an Int:U';
is { sub à(Int $a)   { $a }; à 42  }(),  42, 'can Int   take an Int:D';
is { sub à(Int:_ $a) { $a }; à Int }(), Int, 'can Int:_ take an Int:U';
is { sub à(Int:_ $a) { $a }; à 42  }(),  42, 'can Int:_ take an Int:D';
is { sub à(Int:U $a) { $a }; à Int }(), Int, 'can Int:U take an Int:U';
throws-like { sub à(Int:U $a) { $a }; à 42 },
  Exception,                                  'can Int:U take an Int:D';
throws-like { sub à(Int:D $a) { $a }; à Int },
  Exception,                                  'can Int:D take an Int:U';
is { sub à(Int:D $a) { $a }; à 42  }(),  42, 'can Int:D take an Int:D';
throws-like 'sub a(Int:foo $a) { $a }',
  X::InvalidTypeSmiley,                      'does Int:foo fail';

is { sub à(--> Int)   { Int }; à  }(), Int, 'can --> Int   return an Int:U';
is { sub à(--> Int)   { 42  }; à  }(),  42, 'can --> Int   return an Int:D';
is { sub à(--> Int:_) { Int }; à  }(), Int, 'can --> Int:_ return an Int:U';
is { sub à(--> Int:_) { 42  }; à  }(),  42, 'can --> Int:_ return an Int:D';
is { sub à(--> Int:U) { Int }; à  }(), Int, 'can --> Int:U return an Int:U';
# https://github.com/Raku/old-issue-tracker/issues/4627
throws-like { sub à(--> Int:U) {  42 }; à },
  X::TypeCheck::Return,                     'can --> Int:U return an Int:D';
throws-like { sub à(--> Int:D) { Int }; à },
  X::TypeCheck::Return,                     'can --> Int:D return an Int:U';
is { sub à(--> Int:D) { 42  }; à  }(),  42, 'can --> Int:D return an Int:D';
throws-like 'sub a(--> Int:foo) { }',
  X::InvalidTypeSmiley,                     'does --> Int:foo fail';

skip('use parameters is NYI until further notice', 4);# {
#     use parameters :_;
#     is { sub a(Int $a) { $a }; a Int }(), Int, 'with :_, can Int take an Int:U';
#     is { sub a(Int $a) { $a }; a  42 }(),  42, 'with :_, can Int take an Int:D';
#     is { sub a(--> Int) { Int }() }(), Int, 'with :_, can --> Int return Int:U';
#     is { sub a(--> Int) {  42 }() }(),  42, 'with :_, can --> Int return Int:D';
# }

skip('use parameters is NYI until further notice', 4);# {
#     use parameters :U;
#     is { sub a(Int $a) { $a }; a Int }(), Int, 'with :U, can Int take an Int:U';
#     dies-ok { sub a(Int $a) { $a }; a 42 },  # change to throws-like if passes
#       'with :U, can Int take an Int:D';
#     is { sub a(--> Int) { Int }() }(), Int, 'with :U, can --> Int return Int:U';
#     dies-ok { sub a(--> Int) { 42 }() },  # change to throws-like if passes
#       'with :U, can --> Int return an Int:D';
# }

skip('use parameters is NYI until further notice', 4);# {
#     use parameters :D;
#     #?rakudo todo 'not yet checking parameters pragma'
#     dies-ok { sub a(Int $a) { $a }; a Int },  # change to throws-like if passes
#       'with :D, can Int take an Int:U';
#     is { sub a(Int $a) { $a }; a  42 }(),  42, 'with :D, can Int take an Int:D';
#     #?rakudo todo 'not yet checking parameters pragma'
#     dies-ok { sub a(--> Int) { Int }() },  # change to throws-like if passes
#       'with :D, can --> Int return an Int:U';
#     is { sub a(--> Int) { 42 }() }(), 42, 'with :D, can --> Int return Int:D';
# }

skip('use parameters is NYI until further notice', 1); # { throws-like 'use parameters',        X::Pragma::MustOneOf,  :name<parameters>,
#     'use parameters';
#  }
skip('use parameters is NYI until further notice', 1); # { throws-like 'no parameters',         X::Pragma::CannotWhat, :name<parameters>,
#     :what<no>, 'no parameters';
#  }
skip('use parameters is NYI until further notice', 1); # { throws-like 'use parameters "bar"',  X::Pragma::UnknownArg, :name<parameters>,
#     :arg<bar>, 'use parameters "bar"';
#  }
skip('use parameters is NYI until further notice', 1); # { throws-like 'use parameters :U, :D', X::Pragma::OnlyOne,    :name<parameters>,
#     'use parameters :U, :D';
#  }
skip('use parameters is NYI until further notice', 1); # { throws-like 'use parameters :foo',   X::InvalidTypeSmiley,  :name<foo>,
#     'does use parameters :foo fail';
#  }

# https://github.com/Raku/old-issue-tracker/issues/5214
is Int:U        .gist, '(Int:U)',   '.gist on :U smileys';
is Proc::Async:U.gist, '(Async:U)', '.gist on :U smileys uses shortname';
is Int:D        .gist, '(Int:D)',   '.gist on :D smileys';
is Proc::Async:D.gist, '(Async:D)', '.gist on :D smileys uses shortname';

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
