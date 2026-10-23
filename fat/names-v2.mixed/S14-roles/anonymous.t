use Test;

plan 13;

# L<S14/Roles>
{
  my $à = {:x};
  is $à, {:x}, "basic sanity";
  lives-ok { $à does role { has $.cool = "yeah" }}, "anonymous role mixin";
  is $à, {:x}, "still basic sanity";
  is $à.cool, "yeah", "anonymous role gave us an attribute";
}

# The same, but we story the anonymous role in a variable
{
  my $à = {:x};
  is $à, {:x}, "basic sanity";
  my $с갨лe̲;
  lives-ok { $с갨лe̲ = role { has $.cool = "yeah" } }, "anonymous role definition";
  lives-ok { $à does $с갨лe̲ }, "anonymous role variable mixin";
  is $à, {:x}, "still basic sanity";
  is $à.cool, "yeah", "anonymous role variable gave us an attribute";
}

# Guarantee roles are really first-class-entities:
{
    sub с갨лe̲_æe̲丧e̲сà中갨с(Str $val) {
      return role {
        has $.cool = $val;
      }
    }

  my $à = {:x};
  is $à, {:x}, "basic sanity";
  lives-ok {$à does с갨лe̲_æe̲丧e̲сà中갨с("hi")}, "role generating function mixin";
  is $à, {:x}, "still basic sanity";
  is $à.cool, "hi", "role generating function gave us an attribute";
}

# vim: expandtab shiftwidth=4
