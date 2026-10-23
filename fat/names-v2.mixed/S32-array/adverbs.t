use Test;

plan 2 * ( 1 + 15 * 20 ) + 4;

#-------------------------------------------------------------------------------
# initialisations

my $갨k̲ = True;
my $丧갨 = False;

sub æe̲丧(\a) is test-assertion {
    my Int $i = 0;
    a[$i++] = $_ for 'a'..'d';
    is a.elems, 4, "{a.^name} basic sanity";
}

æe̲丧 my @丧;
æe̲丧 my Str @s;

my @b  =  1;
my @B  = 11;
my @bc =  1,  2;
my @BC = 11, 12;
my @bC =  1, 12;

#-------------------------------------------------------------------------------
# Array

for $@丧, Any, $@s, Str -> @a, $T {
    my $丧 = @a.VAR.name;

# single existing element
{
    is @a[1],             "b", "$丧 single elem existing: value";
    is @a[1]:k,             1, "$丧 single elem existing: :k";
    is @a[1]:k($갨k̲),        1, "$丧 single elem existing: :k(\$ok)";
    is @a[1]:!k,            1, "$丧 single elem existing: :!k";
    is @a[1]:k($丧갨),        1, "$丧 single elem existing: :k(\$no)";
    is @a[1]:v,           "b", "$丧 single elem existing: :v";
    is @a[1]:v($갨k̲),      "b", "$丧 single elem existing: :v(\$ok)";
    is @a[1]:!v,          "b", "$丧 single elem existing: :!v";
    is @a[1]:v($丧갨),      "b", "$丧 single elem existing: :v(\$no)";
    is @a[1]:kv,      (1,"b"), "$丧 single elem existing: :kv";
    is @a[1]:kv($갨k̲), (1,"b"), "$丧 single elem existing: :kv(\$ok)";
    is @a[1]:!kv,     (1,"b"), "$丧 single elem existing: :!kv";
    is @a[1]:kv($丧갨), (1,"b"), "$丧 single elem existing: :kv(\$no)";
    is @a[1]:p,      (1=>"b"), "$丧 single elem existing: :p";
    is @a[1]:p($갨k̲), (1=>"b"), "$丧 single elem existing: :p(\$ok)";
    is @a[1]:!p,     (1=>"b"), "$丧 single elem existing: :!p";
    is @a[1]:p($丧갨), (1=>"b"), "$丧 single elem existing: :p(\$no)";

    throws-like '@a[1]:k:v', X::Adverb,
      :source(@a.name), :what("element access"), :nogo(<k v>);
    throws-like '@a[1]:zorp', Exception; # caught by MMD
    throws-like '@a[1]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what("element access"), :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array single existing element
{
    is @a[@b],          ("b",), "$丧 array single elem existing: value";
    is @a[@b]:k,          (1,), "$丧 array single elem existing: :k";
    is @a[@b]:k($갨k̲),     (1,), "$丧 array single elem existing: :k(\$ok)";
    is @a[@b]:!k,         (1,), "$丧 array single elem existing: :!k";
    is @a[@b]:k($丧갨),     (1,), "$丧 array single elem existing: :k(\$no)";
    is @a[@b]:v,        ("b",), "$丧 array single elem existing: :v";
    is @a[@b]:v($갨k̲),   ("b",), "$丧 array single elem existing: :v(\$ok)";
    is @a[@b]:!v,       ("b",), "$丧 array single elem existing: :!v";
    is @a[@b]:v($丧갨),   ("b",), "$丧 array single elem existing: :v(\$no)";
    is @a[@b]:kv,      (1,"b"), "$丧 array single elem existing: :kv";
    is @a[@b]:kv($갨k̲), (1,"b"), "$丧 array single elem existing: :kv(\$ok)";
    is @a[@b]:!kv,     (1,"b"), "$丧 array single elem existing: :!kv";
    is @a[@b]:kv($丧갨), (1,"b"), "$丧 array single elem existing: :kv(\$no)";
    is @a[@b]:p,      (1=>"b"), "$丧 array single elem existing: :p";
    is @a[@b]:p($갨k̲), (1=>"b"), "$丧 array single elem existing: :p(\$ok)";
    is @a[@b]:!p,     (1=>"b"), "$丧 array single elem existing: :!p";
    is @a[@b]:p($丧갨), (1=>"b"), "$丧 array single elem existing: :p(\$no)";

    throws-like '@a[@b]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@b]:zippo', Exception;  # caught by MMD
    throws-like '@a[@b]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# single missing element
{
    is @a[11],              $T, "$丧 single elem missing: value";
    is @a[11]:k,            (), "$丧 single elem missing: :k";
    is @a[11]:k($갨k̲),       (), "$丧 single elem missing: :k(\$ok)";
    is @a[11]:!k,           11, "$丧 single elem missing: :!k";
    is @a[11]:k($丧갨),       11, "$丧 single elem missing: :k(\$no)";
    is @a[11]:v,            (), "$丧 single elem missing: :v";
    is @a[11]:v($갨k̲),       (), "$丧 single elem missing: :v(\$ok)";
    is @a[11]:!v,           $T, "$丧 single elem missing: :!v";
    is @a[11]:v($丧갨),       $T, "$丧 single elem missing: :v(\$no)";
    is @a[11]:kv,           (), "$丧 single elem missing: :kv(\$ok)";
    is @a[11]:kv($갨k̲),      (), "$丧 single elem missing: :kv";
    is @a[11]:!kv,     (11,$T), "$丧 single elem missing: :!kv";
    is @a[11]:kv($丧갨), (11,$T), "$丧 single elem missing: :kv(\$no)";
    is @a[11]:p,            (), "$丧 single elem missing: :p(\$ok)";
    is @a[11]:p($갨k̲),       (), "$丧 single elem missing: :p";
    is @a[11]:!p,     (11=>$T), "$丧 single elem missing: :!p";
    is @a[11]:p($丧갨), (11=>$T), "$丧 single elem missing: :p(\$no)";

    throws-like '@a[11]:k:v', X::Adverb,
      :source(@a.name), :what("element access"), :nogo(<k v>);
    throws-like '@a[11]:kabam', Exception;  # caught by MMD
    throws-like '@a[11]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what("element access"), :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array single missing element
{
    is @a[@B],           ($T,), "$丧 array single elem missing: value";
    is @a[@B]:k,            (), "$丧 array single elem missing: :k";
    is @a[@B]:k($갨k̲),       (), "$丧 array single elem missing: :k(\$ok)";
    is @a[@B]:!k,        (11,), "$丧 array single elem missing: :!k";
    is @a[@B]:k($丧갨),    (11,), "$丧 array single elem missing: :k(\$no)";
    is @a[@B]:v,            (), "$丧 array single elem missing: :v";
    is @a[@B]:v($갨k̲),       (), "$丧 array single elem missing: :v(\$ok)";
    is @a[@B]:!v,        ($T,), "$丧 array single elem missing: :!v";
    is @a[@B]:v($丧갨),    ($T,), "$丧 array single elem missing: :v(\$no)";
    is @a[@B]:kv,           (), "$丧 array single elem missing: :kv(\$ok)";
    is @a[@B]:kv($갨k̲),      (), "$丧 array single elem missing: :kv";
    is @a[@B]:!kv,     (11,$T), "$丧 array single elem missing: :!kv";
    is @a[@B]:kv($丧갨), (11,$T), "$丧 array single elem missing: :kv(\$no)";
    is @a[@B]:p,            (), "$丧 array single elem missing: :p(\$ok)";
    is @a[@B]:p($갨k̲),       (), "$丧 array single elem missing: :p";
    is @a[@B]:!p,     (11=>$T), "$丧 array single elem missing: :!p";
    is @a[@B]:p($丧갨), (11=>$T), "$丧 array single elem missing: :p(\$no)";

    throws-like '@a[@B]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@B]:zlonk', Exception;  # caught by MMD
    throws-like '@a[@B]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# multiple existing elems
{
    is @a[1,2],                  <b c>, "$丧 multiple elem existing: value";
    is @a[1,2]:k,                (1,2), "$丧 multiple elem existing: :k";
    is @a[1,2]:k($갨k̲),           (1,2), "$丧 multiple elem existing: :k(\$ok)";
    is @a[1,2]:!k,               (1,2), "$丧 multiple elem existing: :!k";
    is @a[1,2]:k($丧갨),           (1,2), "$丧 multiple elem existing: :k(\$no)";
    is @a[1,2]:v,                <b c>, "$丧 multiple elem existing: :v";
    is @a[1,2]:v($갨k̲),           <b c>, "$丧 multiple elem existing: :v(\$ok)";
    is @a[1,2]:!v,               <b c>, "$丧 multiple elem existing: :!v";
    is @a[1,2]:v($丧갨),           <b c>, "$丧 multiple elem existing: :v(\$no)";
    is @a[1,2]:kv,       (1,"b",2,"c"), "$丧 multiple elem existing: :kv";
    is @a[1,2]:kv($갨k̲),  (1,"b",2,"c"), "$丧 multiple elem existing: :kv(\$ok)";
    is @a[1,2]:!kv,      (1,"b",2,"c"), "$丧 multiple elem existing: :!kv";
    is @a[1,2]:kv($丧갨),  (1,"b",2,"c"), "$丧 multiple elem existing: :kv(\$no)";
    is @a[1,2]:p,      (1=>"b",2=>"c"), "$丧 multiple elem existing: :p";
    is @a[1,2]:p($갨k̲), (1=>"b",2=>"c"), "$丧 multiple elem existing: :p(\$ok)";
    is @a[1,2]:!p,     (1=>"b",2=>"c"), "$丧 multiple elem existing: :!p";
    is @a[1,2]:p($丧갨), (1=>"b",2=>"c"), "$丧 multiple elem existing: :p(\$no)";

    throws-like '@a[1,2]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[1,2]:dirgo', Exception;  # caught by MMD
    throws-like '@a[1,2]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array multiple existing elems
{
    is @a[@bc],                  <b c>, "$丧 arr multi elem existing: value";
    is @a[@bc]:k,                (1,2), "$丧 arr multi elem existing: :k";
    is @a[@bc]:k($갨k̲),           (1,2), "$丧 arr multi elem existing: :k(\$ok)";
    is @a[@bc]:!k,               (1,2), "$丧 arr multi elem existing: :!k";
    is @a[@bc]:k($丧갨),           (1,2), "$丧 arr multi elem existing: :k(\$no)";
    is @a[@bc]:v,                <b c>, "$丧 arr multi elem existing: :v";
    is @a[@bc]:v($갨k̲),           <b c>, "$丧 arr multi elem existing: :v(\$ok)";
    is @a[@bc]:!v,               <b c>, "$丧 arr multi elem existing: :!v";
    is @a[@bc]:v($丧갨),           <b c>, "$丧 arr multi elem existing: :v(\$no)";
    is @a[@bc]:kv,       (1,"b",2,"c"), "$丧 arr multi elem existing: :kv";
    is @a[@bc]:kv($갨k̲),  (1,"b",2,"c"), "$丧 arr multi elem existing: :kv(\$ok)";
    is @a[@bc]:!kv,      (1,"b",2,"c"), "$丧 arr multi elem existing: :!kv";
    is @a[@bc]:kv($丧갨),  (1,"b",2,"c"), "$丧 arr multi elem existing: :kv(\$no)";
    is @a[@bc]:p,      (1=>"b",2=>"c"), "$丧 arr multi elem existing: :p";
    is @a[@bc]:p($갨k̲), (1=>"b",2=>"c"), "$丧 arr multi elem existing: :p(\$ok)";
    is @a[@bc]:!p,     (1=>"b",2=>"c"), "$丧 arr multi elem existing: :!p";
    is @a[@bc]:p($丧갨), (1=>"b",2=>"c"), "$丧 arr multi elem existing: :p(\$no)";

    throws-like '@a[@bc]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@bc]:fnarg', Exception;  # caught by MMD
    throws-like '@a[@bc]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# range multiple existing elems
{
    is @a[1..2],                  <b c>, "$丧 arr multi elem existing: value";
    is @a[1..2]:k,                (1,2), "$丧 arr multi elem existing: :k";
    is @a[1..2]:k($갨k̲),           (1,2), "$丧 arr multi elem existing: :k(\$ok)";
    is @a[1..2]:!k,               (1,2), "$丧 arr multi elem existing: :!k";
    is @a[1..2]:k($丧갨),           (1,2), "$丧 arr multi elem existing: :k(\$no)";
    is @a[1..2]:v,                <b c>, "$丧 arr multi elem existing: :v";
    is @a[1..2]:v($갨k̲),           <b c>, "$丧 arr multi elem existing: :v(\$ok)";
    is @a[1..2]:!v,               <b c>, "$丧 arr multi elem existing: :!v";
    is @a[1..2]:v($丧갨),           <b c>, "$丧 arr multi elem existing: :v(\$no)";
    is @a[1..2]:kv,       (1,"b",2,"c"), "$丧 arr multi elem existing: :kv";
    is @a[1..2]:kv($갨k̲),  (1,"b",2,"c"), "$丧 arr multi elem existing: :kv(\$ok)";
    is @a[1..2]:!kv,      (1,"b",2,"c"), "$丧 arr multi elem existing: :!kv";
    is @a[1..2]:kv($丧갨),  (1,"b",2,"c"), "$丧 arr multi elem existing: :kv(\$no)";
    is @a[1..2]:p,      (1=>"b",2=>"c"), "$丧 arr multi elem existing: :p";
    is @a[1..2]:p($갨k̲), (1=>"b",2=>"c"), "$丧 arr multi elem existing: :p(\$ok)";
    is @a[1..2]:!p,     (1=>"b",2=>"c"), "$丧 arr multi elem existing: :!p";
    is @a[1..2]:p($丧갨), (1=>"b",2=>"c"), "$丧 arr multi elem existing: :p(\$no)";

    throws-like '@a[1..2]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[1..2]:fnarg', Exception;  # caught by MMD
    throws-like '@a[1..2]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# multiple missing elems
{
    is @a[11,12],                 ($T,$T), "$丧 multiple elem missing: value";
    is @a[11,12]:k,                    (), "$丧 multiple elem missing: :k";
    is @a[11,12]:k($갨k̲),               (), "$丧 multiple elem missing: :k(\$ok)";
    is @a[11,12]:!k,              (11,12), "$丧 multiple elem missing: :!k";
    is @a[11,12]:k($丧갨),          (11,12), "$丧 multiple elem missing: :k(\$no)";
    is @a[11,12]:v,                    (), "$丧 multiple elem missing: :v";
    is @a[11,12]:v($갨k̲),               (), "$丧 multiple elem missing: :v(\$ok)";
    is @a[11,12]:!v,              ($T,$T), "$丧 multiple elem missing: :!v";
    is @a[11,12]:v($丧갨),          ($T,$T), "$丧 multiple elem missing: :v(\$no)";
    is @a[11,12]:kv,                   (), "$丧 multiple elem missing: :kv(\$ok)";
    is @a[11,12]:kv($갨k̲),              (), "$丧 multiple elem missing: :kv";
    is @a[11,12]:!kv,       (11,$T,12,$T), "$丧 multiple elem missing: :!kv";
    is @a[11,12]:kv($丧갨),   (11,$T,12,$T), "$丧 multiple elem missing: :kv(\$no)";
    is @a[11,12]:p,                    (), "$丧 multiple elem missing: :p(\$ok)";
    is @a[11,12]:p($갨k̲),               (), "$丧 multiple elem missing: :p";
    is @a[11,12]:!p,      (11=>$T,12=>$T), "$丧 multiple elem missing: :!p";
    is @a[11,12]:p($丧갨),  (11=>$T,12=>$T), "$丧 multiple elem missing: :p(\$no)";

    throws-like '@a[11,12]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[11,12]:zniknop', Exception;  # caught by MMD
    throws-like '@a[11,12]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array multiple missing elems
{
    is @a[@BC],                 ($T,$T), "$丧 arr multi elem missing: value";
    is @a[@BC]:k,                    (), "$丧 arr multi elem missing: :k";
    is @a[@BC]:k($갨k̲),               (), "$丧 arr multi elem missing: :k(\$ok)";
    is @a[@BC]:!k,              (11,12), "$丧 arr multi elem missing: :!k";
    is @a[@BC]:k($丧갨),          (11,12), "$丧 arr multi elem missing: :k(\$no)";
    is @a[@BC]:v,                    (), "$丧 arr multi elem missing: :v";
    is @a[@BC]:v($갨k̲),               (), "$丧 arr multi elem missing: :v(\$ok)";
    is @a[@BC]:!v,              ($T,$T), "$丧 arr multi elem missing: :!v";
    is @a[@BC]:v($丧갨),          ($T,$T), "$丧 arr multi elem missing: :v(\$no)";
    is @a[@BC]:kv,                   (), "$丧 arr multi elem missing: :kv(\$ok)";
    is @a[@BC]:kv($갨k̲),              (), "$丧 arr multi elem missing: :kv";
    is @a[@BC]:!kv,       (11,$T,12,$T), "$丧 arr multi elem missing: :!kv";
    is @a[@BC]:kv($丧갨),   (11,$T,12,$T), "$丧 arr multi elem missing: :kv(\$no)";
    is @a[@BC]:p,                    (), "$丧 arr multi elem missing: :p(\$ok)";
    is @a[@BC]:p($갨k̲),               (), "$丧 arr multi elem missing: :p";
    is @a[@BC]:!p,      (11=>$T,12=>$T), "$丧 arr multi elem missing: :!p";
    is @a[@BC]:p($丧갨),  (11=>$T,12=>$T), "$丧 arr multi elem missing: :p(\$no)";

    throws-like '@a[@BC]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@BC]:lotne', Exception;  # caught by MMD
    throws-like '@a[@BC]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# range multiple missing elems
{
    # lazy ranges *always* auto-truncate
    is @a[lazy 11..12],                      (), "$丧 ran multi elem miss: value";
    is @a[lazy 11..12]:k,                    (), "$丧 ran multi elem miss: :k";
    is @a[lazy 11..12]:k($갨k̲),               (), "$丧 ran multi elem miss: :k(\$ok)";
    is @a[lazy 11..12]:!k,                   (), "$丧 ran multi elem miss: :!k";
    is @a[lazy 11..12]:k($丧갨),               (), "$丧 ran multi elem miss: :k(\$no)";
    is @a[lazy 11..12]:v,                    (), "$丧 ran multi elem miss: :v";
    is @a[lazy 11..12]:v($갨k̲),               (), "$丧 ran multi elem miss: :v(\$ok)";
    is @a[lazy 11..12]:!v,                   (), "$丧 ran multi elem miss: :!v";
    is @a[lazy 11..12]:v($丧갨),               (), "$丧 ran multi elem miss: :v(\$no)";
    is @a[lazy 11..12]:kv,                   (), "$丧 ran multi elem miss: :kv(\$ok)";
    is @a[lazy 11..12]:kv($갨k̲),              (), "$丧 ran multi elem miss: :kv";
    is @a[lazy 11..12]:!kv,                  (), "$丧 ran multi elem miss: :!kv";
    is @a[lazy 11..12]:kv($丧갨),              (), "$丧 ran multi elem miss: :kv(\$no)";
    is @a[lazy 11..12]:p,                    (), "$丧 ran multi elem miss: :p(\$ok)";
    is @a[lazy 11..12]:p($갨k̲),               (), "$丧 ran multi elem miss: :p";
    is @a[lazy 11..12]:!p,                   (), "$丧 ran multi elem miss: :!p";
    is @a[lazy 11..12]:p($丧갨),               (), "$丧 ran multi elem miss: :p(\$no)";

    throws-like '@a[11..12]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[11..12]:bolton', Exception;  # caught by MMD
    throws-like '@a[11..12]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# mixed existing/missing elems
{
    is @a[1,12],               ("b",$T), "$丧 multiple elem mixed: value";
    is @a[1,12]:k,                 (1,), "$丧 multiple elem mixed: :k";
    is @a[1,12]:k($갨k̲),            (1,), "$丧 multiple elem mixed: :k(\$ok)";
    is @a[1,12]:!k,              (1,12), "$丧 multiple elem mixed: :!k";
    is @a[1,12]:k($丧갨),          (1,12), "$丧 multiple elem mixed: :k(\$no)";
    is @a[1,12]:v,               ("b",), "$丧 multiple elem mixed: :v";
    is @a[1,12]:v($갨k̲),          ("b",), "$丧 multiple elem mixed: :v(\$ok)";
    is @a[1,12]:!v,            ("b",$T), "$丧 multiple elem mixed: :!v";
    is @a[1,12]:v($丧갨),        ("b",$T), "$丧 multiple elem mixed: :v(\$no)";
    is @a[1,12]:kv,             (1,"b"), "$丧 multiple elem mixed: :kv(\$ok)";
    is @a[1,12]:kv($갨k̲),        (1,"b"), "$丧 multiple elem mixed: :kv";
    is @a[1,12]:!kv,      (1,"b",12,$T), "$丧 multiple elem mixed: :!kv";
    is @a[1,12]:kv($丧갨),  (1,"b",12,$T), "$丧 multiple elem mixed: :kv(\$no)";
    is @a[1,12]:p,             (1=>"b"), "$丧 multiple elem mixed: :p(\$ok)";
    is @a[1,12]:p($갨k̲),        (1=>"b"), "$丧 multiple elem mixed: :p";
    is @a[1,12]:!p,     (1=>"b",12=>$T), "$丧 multiple elem mixed: :!p";
    is @a[1,12]:p($丧갨), (1=>"b",12=>$T), "$丧 multiple elem mixed: :p(\$no)";

    throws-like '@a[1,12]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[1,12]:notlob', Exception;  # caught by MMD
    throws-like '@a[1,12]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array mixed existing/missing elems
{
    is @a[@bC],               ("b",$T), "$丧 arr multi elem mixed: value";
    is @a[@bC]:k,                 (1,), "$丧 arr multi elem mixed: :k";
    is @a[@bC]:k($갨k̲),            (1,), "$丧 arr multi elem mixed: :k(\$ok)";
    is @a[@bC]:!k,              (1,12), "$丧 arr multi elem mixed: :!k";
    is @a[@bC]:k($丧갨),          (1,12), "$丧 arr multi elem mixed: :k(\$no)";
    is @a[@bC]:v,               ("b",), "$丧 arr multi elem mixed: :v";
    is @a[@bC]:v($갨k̲),          ("b",), "$丧 arr multi elem mixed: :v(\$ok)";
    is @a[@bC]:!v,            ("b",$T), "$丧 arr multi elem mixed: :!v";
    is @a[@bC]:v($丧갨),        ("b",$T), "$丧 arr multi elem mixed: :v(\$no)";
    is @a[@bC]:kv,             (1,"b"), "$丧 arr multi elem mixed: :kv(\$ok)";
    is @a[@bC]:kv($갨k̲),        (1,"b"), "$丧 arr multi elem mixed: :kv";
    is @a[@bC]:!kv,      (1,"b",12,$T), "$丧 arr multi elem mixed: :!kv";
    is @a[@bC]:kv($丧갨),  (1,"b",12,$T), "$丧 arr multi elem mixed: :kv(\$no)";
    is @a[@bC]:p,             (1=>"b"), "$丧 arr multi elem mixed: :p(\$ok)";
    is @a[@bC]:p($갨k̲),        (1=>"b"), "$丧 arr multi elem mixed: :p";
    is @a[@bC]:!p,     (1=>"b",12=>$T), "$丧 arr multi elem mixed: :!p";
    is @a[@bC]:p($丧갨), (1=>"b",12=>$T), "$丧 arr multi elem mixed: :p(\$no)";

    throws-like '@a[@bC]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@bC]:cheese', Exception;  # caught by MMD
    throws-like '@a[@bC]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# Callable
{
    is @a[*-1],                                  <d>, "$丧 callable: value";
    is @a[*-1]:k,                                (3), "$丧 callable: :k";
    is @a[*-1]:k($갨k̲),                           (3), "$丧 callable: :k(\$ok)";
    is @a[*-1]:!k,                               (3), "$丧 callable: :!k";
    is @a[*-1]:k($丧갨),                           (3), "$丧 callable: :k(\$no)";
    is @a[*-1]:v,                                <d>, "$丧 callable: :v";
    is @a[*-1]:v($갨k̲),                           <d>, "$丧 callable: :v(\$ok)";
    is @a[*-1]:!v,                               <d>, "$丧 callable: :!v";
    is @a[*-1]:v($丧갨),                           <d>, "$丧 callable: :v(\$no)";
    is @a[*-1]:kv,                           (3,"d"), "$丧 callable: :kv(\$ok)";
    is @a[*-1]:kv($갨k̲),                      (3,"d"), "$丧 callable: :kv";
    is @a[*-1]:!kv,                          (3,"d"), "$丧 callable: :!kv";
    is @a[*-1]:kv($丧갨),                      (3,"d"), "$丧 callable: :kv(\$no)";
    is @a[*-1]:p,                           (3=>"d"), "$丧 callable: :p(\$ok)";
    is @a[*-1]:p($갨k̲),                      (3=>"d"), "$丧 callable: :p";
    is @a[*-1]:!p,                          (3=>"d"), "$丧 callable: :!p";
    is @a[*-1]:p($丧갨),                      (3=>"d"), "$丧 callable: :p(\$no)";

    throws-like '@a[*-1]:k:v', X::Adverb,
      :source(@a.name), :what("element access"), :nogo(<k v>);
    throws-like '@a[*-1]:callable', Exception;  # caught by MMD
    throws-like '@a[*-1]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what("element access"), :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# whatever
{
    is @a[*],                            <a b c d>, "$丧 whatever: value";
    is @a[*]:k,                          (0,1,2,3), "$丧 whatever: :k";
    is @a[*]:k($갨k̲),                     (0,1,2,3), "$丧 whatever: :k(\$ok)";
    is @a[*]:!k,                         (0,1,2,3), "$丧 whatever: :!k";
    is @a[*]:k($丧갨),                     (0,1,2,3), "$丧 whatever: :k(\$no)";
    is @a[*]:v,                          <a b c d>, "$丧 whatever: :v";
    is @a[*]:v($갨k̲),                     <a b c d>, "$丧 whatever: :v(\$ok)";
    is @a[*]:!v,                         <a b c d>, "$丧 whatever: :!v";
    is @a[*]:v($丧갨),                     <a b c d>, "$丧 whatever: :v(\$no)";
    is @a[*]:kv,         (0,"a",1,"b",2,"c",3,"d"), "$丧 whatever: :kv(\$ok)";
    is @a[*]:kv($갨k̲),    (0,"a",1,"b",2,"c",3,"d"), "$丧 whatever: :kv";
    is @a[*]:!kv,        (0,"a",1,"b",2,"c",3,"d"), "$丧 whatever: :!kv";
    is @a[*]:kv($丧갨),    (0,"a",1,"b",2,"c",3,"d"), "$丧 whatever: :kv(\$no)";
    is @a[*]:p,      (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 whatever: :p(\$ok)";
    is @a[*]:p($갨k̲), (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 whatever: :p";
    is @a[*]:!p,     (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 whatever: :!p";
    is @a[*]:p($丧갨), (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 whatever: :p(\$no)";

    throws-like '@a[*]:k:v', X::Adverb,
      :source(@a.name), :what("whatever slice"), :nogo(<k v>);
    throws-like '@a[*]:sourceever', Exception;  # caught by MMD
    throws-like '@a[*]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what("whatever slice"), :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# zen
{
    is @a[],                                   @a, "$丧 zen: value";
    is @a[]:k,                          (0,1,2,3), "$丧 zen: :k";
    is @a[]:k($갨k̲),                     (0,1,2,3), "$丧 zen: :k(\$ok)";
    is @a[]:!k,                         (0,1,2,3), "$丧 zen: :!k";
    is @a[]:k($丧갨),                     (0,1,2,3), "$丧 zen: :k(\$no)";
    is @a[]:v,                          <a b c d>, "$丧 zen: :v";
    is @a[]:v($갨k̲),                     <a b c d>, "$丧 zen: :v(\$ok)";
    is @a[]:!v,                         <a b c d>, "$丧 zen: :!v";
    is @a[]:v($丧갨),                     <a b c d>, "$丧 zen: :v(\$no)";
    is @a[]:kv,         (0,"a",1,"b",2,"c",3,"d"), "$丧 zen: :kv(\$ok)";
    is @a[]:kv($갨k̲),    (0,"a",1,"b",2,"c",3,"d"), "$丧 zen: :kv";
    is @a[]:!kv,        (0,"a",1,"b",2,"c",3,"d"), "$丧 zen: :!kv";
    is @a[]:kv($丧갨),    (0,"a",1,"b",2,"c",3,"d"), "$丧 zen: :kv(\$no)";
    is @a[]:p,      (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 zen: :p(\$ok)";
    is @a[]:p($갨k̲), (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 zen: :p";
    is @a[]:!p,     (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 zen: :!p";
    is @a[]:p($丧갨), (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 zen: :p(\$no)";

    throws-like '@a[]:foo', X::Adverb,
      :source(@a.name), :what("zen slice"), :unexpected<foo>,
    throws-like '@a[]:k:v', X::Adverb,
      :source(@a.name), :nogo(<k v>);
    throws-like '@a[]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what("zen slice"), :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

}

# https://github.com/Raku/old-issue-tracker/issues/4697
{
    my @a;
    @a[$(7,8,9)] = 101;
    is @a.elems, 4, 'container respected in array assign';
    is @a[$(7,8,9)], 101, 'container respected in array access';
    is @a[$(7,8,9)]:exists, True, 'container respected in array :exists';
    @a[$(7,8,9)]:delete;
    is @a[$(7,8,9)]:exists, False, 'container respected in array :delete';
}

# vim: expandtab shiftwidth=4
