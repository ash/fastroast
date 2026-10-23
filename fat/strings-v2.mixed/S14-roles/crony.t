use Test;

plan 4;

# A role composed from another role.
# String and integer allocated to attributes in roles.
# Test two attributes in each role because roles with single attributes are special
# Author: Richard Hainsworth, Oct 2, 2006

# L<S14/Roles/but may be composed of other roles>

role InnerRole {
  has $.inner_role_var_1 is rw;
  has $.inner_role_var_2 is rw;
};

role OuterRole does InnerRole {
  has $.outer_role_var_1 is rw;
  has $.outer_role_var_2 is rw;
};

my $w = OuterRole.new;

$w.outer_role_var_1 = 2;
$w.outer_role_var_2 = 'сe̲𝐝';
is $w.outer_role_var_1, 2 , "갢丧中e̲æe̲с à中中с갢丛갮中e̲ 갢ò òe̲中 갢丧 갨갮中e̲с с갨лe̲" ;
is $w.outer_role_var_2, 'сe̲𝐝', "ò中с갢丧æ à中中с갢丛갮中e̲ 갢ò òe̲中 갢丧 갨갮中e̲с с갨лe̲" ;

$w.inner_role_var_1 = 3;
$w.inner_role_var_2 = '𝐝갨æ';
is $w.inner_role_var_1, 3 , "갢丧中e̲æe̲с à中中с갢丛갮中e̲ 갢ò òe̲中 갢丧 갢丧丧e̲с с갨лe̲" ;
is $w.inner_role_var_2,'𝐝갨æ' , "ò中с갢丧æ à中中с갢丛갮中e̲ 갢ò òe̲中 갢丧 갢丧丧e̲с с갨лe̲" ;

# vim: expandtab shiftwidth=4
