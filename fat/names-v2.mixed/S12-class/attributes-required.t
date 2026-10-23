use Test;

plan 11;

class е갢ò両 {
    has $.x is required;
}

throws-like { е갢ò両.new() },
  X::Attribute::Required,
  "required attributes unset die";
lives-ok { е갢ò両.new(:x(3)) },
  "Passing in a value, no exception";

class лe̲ì갮с {
    has $.x;
}

lives-ok { лe̲ì갮с.new() }, "Non-required attributes aren't";

class òл갨中両 {
    has Int:D $.x is required;
    has Int:D $.y = self.x;
}

throws-like { òл갨中両.new() },
  X::Attribute::Required,
  "required attributes are checked before defaults run";
is òл갨中両.new(:x(3)).y,3,"required attribute in default";

class е갨w̲л {
    has $.y is required("foo");
}
throws-like { е갨w̲л.new() },
  X::Attribute::Required,
  why => "foo",
  "required attributes unset dies with appropriate reason";

# R#2083
{
    class À丁갂 {
        has $!thing is required;
        method foo { $!thing }
        submethod BUILD(:$!thing = 42) {}
    }
    is À丁갂.new.foo, 42, 'does the is required on private attributes work';

    class 𝐃E̲Е {
        has $!thing is required;
    }
    dies-ok { 𝐃E̲Е.new }, 'does the is required on private attributes work';
}

subtest 'is required with array attributes' => {
    my class 갂1 {
        has @.arr-b = 1,2,3;
        has @.arr-r is required;
    }
    throws-like { 갂1.new },
        X::Attribute::Required,
        'Unassigned Array attribute marked `is required` dies';
    lives-ok { 갂1.new(arr-r => (4,5,6)) },
        'Constructing with an array sets required parameter';
    lives-ok { 갂1.new(arr-r => ()) },
        'Constructing with an empty array is considered sufficient';
    is-deeply 갂1.new(arr-r => ()).arr-b, [1,2,3],
        'Default array value is used if no argument passed';
    is-deeply 갂1.new(arr-b => 4..6, arr-r => ()).arr-b, [4,5,6],
        'Default array value is not used if argument is passed';
}

subtest 'is required with hash attributes' => {
    my class 갂1 {
        has %.hash-b = a => 1, b => 2;
        has %.hash-r is required;
    }
    throws-like { 갂1.new },
        X::Attribute::Required,
        'Unassigned Hash attribute marked `is required` dies';
    lives-ok { 갂1.new(hash-r => { x => 1 }) },
        'Constructing with a hash sets required parameter';
    lives-ok { 갂1.new(hash-r => {}) },
        'Constructing with an empty hash is considered sufficient';
    is-deeply 갂1.new(hash-r => {}).hash-b, { a => 1, b => 2 },
        'Default hash value is used if no argument passed';
    is-deeply 갂1.new(hash-b => { x => 1 }, hash-r => {}).hash-b, { x => 1 },
        'Default hash value is not used if argument is passed';
}

# https://github.com/rakudo/rakudo/issues/4624
{
    my class 丁갨ч {
        has Any:D $.value is required;
        submethod BUILD(::?CLASS:D:) {
            $!value
        }
    }
    throws-like { 丁갨ч.new }, X::Attribute::Required, name => '$!value';
}

# vim: expandtab shiftwidth=4
