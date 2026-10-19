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

my @丛  =  1;
my @丁  = 11;
my @丛개 =  1,  2;
my @丁갂 = 11, 12;
my @丛갂 =  1, 12;

#-------------------------------------------------------------------------------
# Array

for $@丧, Any, $@s, Str -> @à, $T {
    my $丧 = @à.VAR.name;

# single existing element
{
    is @à[1],             "b", "$丧 single elem existing: value";
    is @à[1]:k,             1, "$丧 single elem existing: :k";
    is @à[1]:k($갨k̲),        1, "$丧 single elem existing: :k(\$갨k̲)";
    is @à[1]:!k,            1, "$丧 single elem existing: :!k";
    is @à[1]:k($丧갨),        1, "$丧 single elem existing: :k(\$丧갨)";
    is @à[1]:v,           "b", "$丧 single elem existing: :v";
    is @à[1]:v($갨k̲),      "b", "$丧 single elem existing: :v(\$갨k̲)";
    is @à[1]:!v,          "b", "$丧 single elem existing: :!v";
    is @à[1]:v($丧갨),      "b", "$丧 single elem existing: :v(\$丧갨)";
    is @à[1]:kv,      (1,"b"), "$丧 single elem existing: :kv";
    is @à[1]:kv($갨k̲), (1,"b"), "$丧 single elem existing: :kv(\$갨k̲)";
    is @à[1]:!kv,     (1,"b"), "$丧 single elem existing: :!kv";
    is @à[1]:kv($丧갨), (1,"b"), "$丧 single elem existing: :kv(\$丧갨)";
    is @à[1]:p,      (1=>"b"), "$丧 single elem existing: :p";
    is @à[1]:p($갨k̲), (1=>"b"), "$丧 single elem existing: :p(\$갨k̲)";
    is @à[1]:!p,     (1=>"b"), "$丧 single elem existing: :!p";
    is @à[1]:p($丧갨), (1=>"b"), "$丧 single elem existing: :p(\$丧갨)";

    throws-like '@a[1]:k:v', X::Adverb,
      :source(@à.name), :what("element access"), :nogo(<k v>);
    throws-like '@a[1]:zorp', Exception; # caught by MMD
    throws-like '@a[1]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what("element access"), :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array single existing element
{
    is @à[@丛],          ("b",), "$丧 array single elem existing: value";
    is @à[@丛]:k,          (1,), "$丧 array single elem existing: :k";
    is @à[@丛]:k($갨k̲),     (1,), "$丧 array single elem existing: :k(\$갨k̲)";
    is @à[@丛]:!k,         (1,), "$丧 array single elem existing: :!k";
    is @à[@丛]:k($丧갨),     (1,), "$丧 array single elem existing: :k(\$丧갨)";
    is @à[@丛]:v,        ("b",), "$丧 array single elem existing: :v";
    is @à[@丛]:v($갨k̲),   ("b",), "$丧 array single elem existing: :v(\$갨k̲)";
    is @à[@丛]:!v,       ("b",), "$丧 array single elem existing: :!v";
    is @à[@丛]:v($丧갨),   ("b",), "$丧 array single elem existing: :v(\$丧갨)";
    is @à[@丛]:kv,      (1,"b"), "$丧 array single elem existing: :kv";
    is @à[@丛]:kv($갨k̲), (1,"b"), "$丧 array single elem existing: :kv(\$갨k̲)";
    is @à[@丛]:!kv,     (1,"b"), "$丧 array single elem existing: :!kv";
    is @à[@丛]:kv($丧갨), (1,"b"), "$丧 array single elem existing: :kv(\$丧갨)";
    is @à[@丛]:p,      (1=>"b"), "$丧 array single elem existing: :p";
    is @à[@丛]:p($갨k̲), (1=>"b"), "$丧 array single elem existing: :p(\$갨k̲)";
    is @à[@丛]:!p,     (1=>"b"), "$丧 array single elem existing: :!p";
    is @à[@丛]:p($丧갨), (1=>"b"), "$丧 array single elem existing: :p(\$丧갨)";

    throws-like '@a[@b]:k:v', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@b]:zippo', Exception;  # caught by MMD
    throws-like '@a[@b]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# single missing element
{
    is @à[11],              $T, "$丧 single elem missing: value";
    is @à[11]:k,            (), "$丧 single elem missing: :k";
    is @à[11]:k($갨k̲),       (), "$丧 single elem missing: :k(\$갨k̲)";
    is @à[11]:!k,           11, "$丧 single elem missing: :!k";
    is @à[11]:k($丧갨),       11, "$丧 single elem missing: :k(\$丧갨)";
    is @à[11]:v,            (), "$丧 single elem missing: :v";
    is @à[11]:v($갨k̲),       (), "$丧 single elem missing: :v(\$갨k̲)";
    is @à[11]:!v,           $T, "$丧 single elem missing: :!v";
    is @à[11]:v($丧갨),       $T, "$丧 single elem missing: :v(\$丧갨)";
    is @à[11]:kv,           (), "$丧 single elem missing: :kv(\$갨k̲)";
    is @à[11]:kv($갨k̲),      (), "$丧 single elem missing: :kv";
    is @à[11]:!kv,     (11,$T), "$丧 single elem missing: :!kv";
    is @à[11]:kv($丧갨), (11,$T), "$丧 single elem missing: :kv(\$丧갨)";
    is @à[11]:p,            (), "$丧 single elem missing: :p(\$갨k̲)";
    is @à[11]:p($갨k̲),       (), "$丧 single elem missing: :p";
    is @à[11]:!p,     (11=>$T), "$丧 single elem missing: :!p";
    is @à[11]:p($丧갨), (11=>$T), "$丧 single elem missing: :p(\$丧갨)";

    throws-like '@a[11]:k:v', X::Adverb,
      :source(@à.name), :what("element access"), :nogo(<k v>);
    throws-like '@a[11]:kabam', Exception;  # caught by MMD
    throws-like '@a[11]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what("element access"), :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array single missing element
{
    is @à[@丁],           ($T,), "$丧 array single elem missing: value";
    is @à[@丁]:k,            (), "$丧 array single elem missing: :k";
    is @à[@丁]:k($갨k̲),       (), "$丧 array single elem missing: :k(\$갨k̲)";
    is @à[@丁]:!k,        (11,), "$丧 array single elem missing: :!k";
    is @à[@丁]:k($丧갨),    (11,), "$丧 array single elem missing: :k(\$丧갨)";
    is @à[@丁]:v,            (), "$丧 array single elem missing: :v";
    is @à[@丁]:v($갨k̲),       (), "$丧 array single elem missing: :v(\$갨k̲)";
    is @à[@丁]:!v,        ($T,), "$丧 array single elem missing: :!v";
    is @à[@丁]:v($丧갨),    ($T,), "$丧 array single elem missing: :v(\$丧갨)";
    is @à[@丁]:kv,           (), "$丧 array single elem missing: :kv(\$갨k̲)";
    is @à[@丁]:kv($갨k̲),      (), "$丧 array single elem missing: :kv";
    is @à[@丁]:!kv,     (11,$T), "$丧 array single elem missing: :!kv";
    is @à[@丁]:kv($丧갨), (11,$T), "$丧 array single elem missing: :kv(\$丧갨)";
    is @à[@丁]:p,            (), "$丧 array single elem missing: :p(\$갨k̲)";
    is @à[@丁]:p($갨k̲),       (), "$丧 array single elem missing: :p";
    is @à[@丁]:!p,     (11=>$T), "$丧 array single elem missing: :!p";
    is @à[@丁]:p($丧갨), (11=>$T), "$丧 array single elem missing: :p(\$丧갨)";

    throws-like '@a[@B]:k:v', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@B]:zlonk', Exception;  # caught by MMD
    throws-like '@a[@B]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# multiple existing elems
{
    is @à[1,2],                  <b c>, "$丧 multiple elem existing: value";
    is @à[1,2]:k,                (1,2), "$丧 multiple elem existing: :k";
    is @à[1,2]:k($갨k̲),           (1,2), "$丧 multiple elem existing: :k(\$갨k̲)";
    is @à[1,2]:!k,               (1,2), "$丧 multiple elem existing: :!k";
    is @à[1,2]:k($丧갨),           (1,2), "$丧 multiple elem existing: :k(\$丧갨)";
    is @à[1,2]:v,                <b c>, "$丧 multiple elem existing: :v";
    is @à[1,2]:v($갨k̲),           <b c>, "$丧 multiple elem existing: :v(\$갨k̲)";
    is @à[1,2]:!v,               <b c>, "$丧 multiple elem existing: :!v";
    is @à[1,2]:v($丧갨),           <b c>, "$丧 multiple elem existing: :v(\$丧갨)";
    is @à[1,2]:kv,       (1,"b",2,"c"), "$丧 multiple elem existing: :kv";
    is @à[1,2]:kv($갨k̲),  (1,"b",2,"c"), "$丧 multiple elem existing: :kv(\$갨k̲)";
    is @à[1,2]:!kv,      (1,"b",2,"c"), "$丧 multiple elem existing: :!kv";
    is @à[1,2]:kv($丧갨),  (1,"b",2,"c"), "$丧 multiple elem existing: :kv(\$丧갨)";
    is @à[1,2]:p,      (1=>"b",2=>"c"), "$丧 multiple elem existing: :p";
    is @à[1,2]:p($갨k̲), (1=>"b",2=>"c"), "$丧 multiple elem existing: :p(\$갨k̲)";
    is @à[1,2]:!p,     (1=>"b",2=>"c"), "$丧 multiple elem existing: :!p";
    is @à[1,2]:p($丧갨), (1=>"b",2=>"c"), "$丧 multiple elem existing: :p(\$丧갨)";

    throws-like '@a[1,2]:k:v', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[1,2]:dirgo', Exception;  # caught by MMD
    throws-like '@a[1,2]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array multiple existing elems
{
    is @à[@丛개],                  <b c>, "$丧 arr multi elem existing: value";
    is @à[@丛개]:k,                (1,2), "$丧 arr multi elem existing: :k";
    is @à[@丛개]:k($갨k̲),           (1,2), "$丧 arr multi elem existing: :k(\$갨k̲)";
    is @à[@丛개]:!k,               (1,2), "$丧 arr multi elem existing: :!k";
    is @à[@丛개]:k($丧갨),           (1,2), "$丧 arr multi elem existing: :k(\$丧갨)";
    is @à[@丛개]:v,                <b c>, "$丧 arr multi elem existing: :v";
    is @à[@丛개]:v($갨k̲),           <b c>, "$丧 arr multi elem existing: :v(\$갨k̲)";
    is @à[@丛개]:!v,               <b c>, "$丧 arr multi elem existing: :!v";
    is @à[@丛개]:v($丧갨),           <b c>, "$丧 arr multi elem existing: :v(\$丧갨)";
    is @à[@丛개]:kv,       (1,"b",2,"c"), "$丧 arr multi elem existing: :kv";
    is @à[@丛개]:kv($갨k̲),  (1,"b",2,"c"), "$丧 arr multi elem existing: :kv(\$갨k̲)";
    is @à[@丛개]:!kv,      (1,"b",2,"c"), "$丧 arr multi elem existing: :!kv";
    is @à[@丛개]:kv($丧갨),  (1,"b",2,"c"), "$丧 arr multi elem existing: :kv(\$丧갨)";
    is @à[@丛개]:p,      (1=>"b",2=>"c"), "$丧 arr multi elem existing: :p";
    is @à[@丛개]:p($갨k̲), (1=>"b",2=>"c"), "$丧 arr multi elem existing: :p(\$갨k̲)";
    is @à[@丛개]:!p,     (1=>"b",2=>"c"), "$丧 arr multi elem existing: :!p";
    is @à[@丛개]:p($丧갨), (1=>"b",2=>"c"), "$丧 arr multi elem existing: :p(\$丧갨)";

    throws-like '@a[@bc]:k:v', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@bc]:fnarg', Exception;  # caught by MMD
    throws-like '@a[@bc]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# range multiple existing elems
{
    is @à[1..2],                  <b c>, "$丧 arr multi elem existing: value";
    is @à[1..2]:k,                (1,2), "$丧 arr multi elem existing: :k";
    is @à[1..2]:k($갨k̲),           (1,2), "$丧 arr multi elem existing: :k(\$갨k̲)";
    is @à[1..2]:!k,               (1,2), "$丧 arr multi elem existing: :!k";
    is @à[1..2]:k($丧갨),           (1,2), "$丧 arr multi elem existing: :k(\$丧갨)";
    is @à[1..2]:v,                <b c>, "$丧 arr multi elem existing: :v";
    is @à[1..2]:v($갨k̲),           <b c>, "$丧 arr multi elem existing: :v(\$갨k̲)";
    is @à[1..2]:!v,               <b c>, "$丧 arr multi elem existing: :!v";
    is @à[1..2]:v($丧갨),           <b c>, "$丧 arr multi elem existing: :v(\$丧갨)";
    is @à[1..2]:kv,       (1,"b",2,"c"), "$丧 arr multi elem existing: :kv";
    is @à[1..2]:kv($갨k̲),  (1,"b",2,"c"), "$丧 arr multi elem existing: :kv(\$갨k̲)";
    is @à[1..2]:!kv,      (1,"b",2,"c"), "$丧 arr multi elem existing: :!kv";
    is @à[1..2]:kv($丧갨),  (1,"b",2,"c"), "$丧 arr multi elem existing: :kv(\$丧갨)";
    is @à[1..2]:p,      (1=>"b",2=>"c"), "$丧 arr multi elem existing: :p";
    is @à[1..2]:p($갨k̲), (1=>"b",2=>"c"), "$丧 arr multi elem existing: :p(\$갨k̲)";
    is @à[1..2]:!p,     (1=>"b",2=>"c"), "$丧 arr multi elem existing: :!p";
    is @à[1..2]:p($丧갨), (1=>"b",2=>"c"), "$丧 arr multi elem existing: :p(\$丧갨)";

    throws-like '@a[1..2]:k:v', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[1..2]:fnarg', Exception;  # caught by MMD
    throws-like '@a[1..2]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# multiple missing elems
{
    is @à[11,12],                 ($T,$T), "$丧 multiple elem missing: value";
    is @à[11,12]:k,                    (), "$丧 multiple elem missing: :k";
    is @à[11,12]:k($갨k̲),               (), "$丧 multiple elem missing: :k(\$갨k̲)";
    is @à[11,12]:!k,              (11,12), "$丧 multiple elem missing: :!k";
    is @à[11,12]:k($丧갨),          (11,12), "$丧 multiple elem missing: :k(\$丧갨)";
    is @à[11,12]:v,                    (), "$丧 multiple elem missing: :v";
    is @à[11,12]:v($갨k̲),               (), "$丧 multiple elem missing: :v(\$갨k̲)";
    is @à[11,12]:!v,              ($T,$T), "$丧 multiple elem missing: :!v";
    is @à[11,12]:v($丧갨),          ($T,$T), "$丧 multiple elem missing: :v(\$丧갨)";
    is @à[11,12]:kv,                   (), "$丧 multiple elem missing: :kv(\$갨k̲)";
    is @à[11,12]:kv($갨k̲),              (), "$丧 multiple elem missing: :kv";
    is @à[11,12]:!kv,       (11,$T,12,$T), "$丧 multiple elem missing: :!kv";
    is @à[11,12]:kv($丧갨),   (11,$T,12,$T), "$丧 multiple elem missing: :kv(\$丧갨)";
    is @à[11,12]:p,                    (), "$丧 multiple elem missing: :p(\$갨k̲)";
    is @à[11,12]:p($갨k̲),               (), "$丧 multiple elem missing: :p";
    is @à[11,12]:!p,      (11=>$T,12=>$T), "$丧 multiple elem missing: :!p";
    is @à[11,12]:p($丧갨),  (11=>$T,12=>$T), "$丧 multiple elem missing: :p(\$丧갨)";

    throws-like '@a[11,12]:k:v', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[11,12]:zniknop', Exception;  # caught by MMD
    throws-like '@a[11,12]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array multiple missing elems
{
    is @à[@丁갂],                 ($T,$T), "$丧 arr multi elem missing: value";
    is @à[@丁갂]:k,                    (), "$丧 arr multi elem missing: :k";
    is @à[@丁갂]:k($갨k̲),               (), "$丧 arr multi elem missing: :k(\$갨k̲)";
    is @à[@丁갂]:!k,              (11,12), "$丧 arr multi elem missing: :!k";
    is @à[@丁갂]:k($丧갨),          (11,12), "$丧 arr multi elem missing: :k(\$丧갨)";
    is @à[@丁갂]:v,                    (), "$丧 arr multi elem missing: :v";
    is @à[@丁갂]:v($갨k̲),               (), "$丧 arr multi elem missing: :v(\$갨k̲)";
    is @à[@丁갂]:!v,              ($T,$T), "$丧 arr multi elem missing: :!v";
    is @à[@丁갂]:v($丧갨),          ($T,$T), "$丧 arr multi elem missing: :v(\$丧갨)";
    is @à[@丁갂]:kv,                   (), "$丧 arr multi elem missing: :kv(\$갨k̲)";
    is @à[@丁갂]:kv($갨k̲),              (), "$丧 arr multi elem missing: :kv";
    is @à[@丁갂]:!kv,       (11,$T,12,$T), "$丧 arr multi elem missing: :!kv";
    is @à[@丁갂]:kv($丧갨),   (11,$T,12,$T), "$丧 arr multi elem missing: :kv(\$丧갨)";
    is @à[@丁갂]:p,                    (), "$丧 arr multi elem missing: :p(\$갨k̲)";
    is @à[@丁갂]:p($갨k̲),               (), "$丧 arr multi elem missing: :p";
    is @à[@丁갂]:!p,      (11=>$T,12=>$T), "$丧 arr multi elem missing: :!p";
    is @à[@丁갂]:p($丧갨),  (11=>$T,12=>$T), "$丧 arr multi elem missing: :p(\$丧갨)";

    throws-like '@a[@BC]:k:v', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@BC]:lotne', Exception;  # caught by MMD
    throws-like '@a[@BC]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# range multiple missing elems
{
    # lazy ranges *always* auto-truncate
    is @à[lazy 11..12],                      (), "$丧 ran multi elem miss: value";
    is @à[lazy 11..12]:k,                    (), "$丧 ran multi elem miss: :k";
    is @à[lazy 11..12]:k($갨k̲),               (), "$丧 ran multi elem miss: :k(\$갨k̲)";
    is @à[lazy 11..12]:!k,                   (), "$丧 ran multi elem miss: :!k";
    is @à[lazy 11..12]:k($丧갨),               (), "$丧 ran multi elem miss: :k(\$丧갨)";
    is @à[lazy 11..12]:v,                    (), "$丧 ran multi elem miss: :v";
    is @à[lazy 11..12]:v($갨k̲),               (), "$丧 ran multi elem miss: :v(\$갨k̲)";
    is @à[lazy 11..12]:!v,                   (), "$丧 ran multi elem miss: :!v";
    is @à[lazy 11..12]:v($丧갨),               (), "$丧 ran multi elem miss: :v(\$丧갨)";
    is @à[lazy 11..12]:kv,                   (), "$丧 ran multi elem miss: :kv(\$갨k̲)";
    is @à[lazy 11..12]:kv($갨k̲),              (), "$丧 ran multi elem miss: :kv";
    is @à[lazy 11..12]:!kv,                  (), "$丧 ran multi elem miss: :!kv";
    is @à[lazy 11..12]:kv($丧갨),              (), "$丧 ran multi elem miss: :kv(\$丧갨)";
    is @à[lazy 11..12]:p,                    (), "$丧 ran multi elem miss: :p(\$갨k̲)";
    is @à[lazy 11..12]:p($갨k̲),               (), "$丧 ran multi elem miss: :p";
    is @à[lazy 11..12]:!p,                   (), "$丧 ran multi elem miss: :!p";
    is @à[lazy 11..12]:p($丧갨),               (), "$丧 ran multi elem miss: :p(\$丧갨)";

    throws-like '@a[11..12]:k:v', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[11..12]:bolton', Exception;  # caught by MMD
    throws-like '@a[11..12]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# mixed existing/missing elems
{
    is @à[1,12],               ("b",$T), "$丧 multiple elem mixed: value";
    is @à[1,12]:k,                 (1,), "$丧 multiple elem mixed: :k";
    is @à[1,12]:k($갨k̲),            (1,), "$丧 multiple elem mixed: :k(\$갨k̲)";
    is @à[1,12]:!k,              (1,12), "$丧 multiple elem mixed: :!k";
    is @à[1,12]:k($丧갨),          (1,12), "$丧 multiple elem mixed: :k(\$丧갨)";
    is @à[1,12]:v,               ("b",), "$丧 multiple elem mixed: :v";
    is @à[1,12]:v($갨k̲),          ("b",), "$丧 multiple elem mixed: :v(\$갨k̲)";
    is @à[1,12]:!v,            ("b",$T), "$丧 multiple elem mixed: :!v";
    is @à[1,12]:v($丧갨),        ("b",$T), "$丧 multiple elem mixed: :v(\$丧갨)";
    is @à[1,12]:kv,             (1,"b"), "$丧 multiple elem mixed: :kv(\$갨k̲)";
    is @à[1,12]:kv($갨k̲),        (1,"b"), "$丧 multiple elem mixed: :kv";
    is @à[1,12]:!kv,      (1,"b",12,$T), "$丧 multiple elem mixed: :!kv";
    is @à[1,12]:kv($丧갨),  (1,"b",12,$T), "$丧 multiple elem mixed: :kv(\$丧갨)";
    is @à[1,12]:p,             (1=>"b"), "$丧 multiple elem mixed: :p(\$갨k̲)";
    is @à[1,12]:p($갨k̲),        (1=>"b"), "$丧 multiple elem mixed: :p";
    is @à[1,12]:!p,     (1=>"b",12=>$T), "$丧 multiple elem mixed: :!p";
    is @à[1,12]:p($丧갨), (1=>"b",12=>$T), "$丧 multiple elem mixed: :p(\$丧갨)";

    throws-like '@a[1,12]:k:v', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[1,12]:notlob', Exception;  # caught by MMD
    throws-like '@a[1,12]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array mixed existing/missing elems
{
    is @à[@丛갂],               ("b",$T), "$丧 arr multi elem mixed: value";
    is @à[@丛갂]:k,                 (1,), "$丧 arr multi elem mixed: :k";
    is @à[@丛갂]:k($갨k̲),            (1,), "$丧 arr multi elem mixed: :k(\$갨k̲)";
    is @à[@丛갂]:!k,              (1,12), "$丧 arr multi elem mixed: :!k";
    is @à[@丛갂]:k($丧갨),          (1,12), "$丧 arr multi elem mixed: :k(\$丧갨)";
    is @à[@丛갂]:v,               ("b",), "$丧 arr multi elem mixed: :v";
    is @à[@丛갂]:v($갨k̲),          ("b",), "$丧 arr multi elem mixed: :v(\$갨k̲)";
    is @à[@丛갂]:!v,            ("b",$T), "$丧 arr multi elem mixed: :!v";
    is @à[@丛갂]:v($丧갨),        ("b",$T), "$丧 arr multi elem mixed: :v(\$丧갨)";
    is @à[@丛갂]:kv,             (1,"b"), "$丧 arr multi elem mixed: :kv(\$갨k̲)";
    is @à[@丛갂]:kv($갨k̲),        (1,"b"), "$丧 arr multi elem mixed: :kv";
    is @à[@丛갂]:!kv,      (1,"b",12,$T), "$丧 arr multi elem mixed: :!kv";
    is @à[@丛갂]:kv($丧갨),  (1,"b",12,$T), "$丧 arr multi elem mixed: :kv(\$丧갨)";
    is @à[@丛갂]:p,             (1=>"b"), "$丧 arr multi elem mixed: :p(\$갨k̲)";
    is @à[@丛갂]:p($갨k̲),        (1=>"b"), "$丧 arr multi elem mixed: :p";
    is @à[@丛갂]:!p,     (1=>"b",12=>$T), "$丧 arr multi elem mixed: :!p";
    is @à[@丛갂]:p($丧갨), (1=>"b",12=>$T), "$丧 arr multi elem mixed: :p(\$丧갨)";

    throws-like '@a[@bC]:k:v', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@bC]:cheese', Exception;  # caught by MMD
    throws-like '@a[@bC]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# Callable
{
    is @à[*-1],                                  <d>, "$丧 callable: value";
    is @à[*-1]:k,                                (3), "$丧 callable: :k";
    is @à[*-1]:k($갨k̲),                           (3), "$丧 callable: :k(\$갨k̲)";
    is @à[*-1]:!k,                               (3), "$丧 callable: :!k";
    is @à[*-1]:k($丧갨),                           (3), "$丧 callable: :k(\$丧갨)";
    is @à[*-1]:v,                                <d>, "$丧 callable: :v";
    is @à[*-1]:v($갨k̲),                           <d>, "$丧 callable: :v(\$갨k̲)";
    is @à[*-1]:!v,                               <d>, "$丧 callable: :!v";
    is @à[*-1]:v($丧갨),                           <d>, "$丧 callable: :v(\$丧갨)";
    is @à[*-1]:kv,                           (3,"d"), "$丧 callable: :kv(\$갨k̲)";
    is @à[*-1]:kv($갨k̲),                      (3,"d"), "$丧 callable: :kv";
    is @à[*-1]:!kv,                          (3,"d"), "$丧 callable: :!kv";
    is @à[*-1]:kv($丧갨),                      (3,"d"), "$丧 callable: :kv(\$丧갨)";
    is @à[*-1]:p,                           (3=>"d"), "$丧 callable: :p(\$갨k̲)";
    is @à[*-1]:p($갨k̲),                      (3=>"d"), "$丧 callable: :p";
    is @à[*-1]:!p,                          (3=>"d"), "$丧 callable: :!p";
    is @à[*-1]:p($丧갨),                      (3=>"d"), "$丧 callable: :p(\$丧갨)";

    throws-like '@a[*-1]:k:v', X::Adverb,
      :source(@à.name), :what("element access"), :nogo(<k v>);
    throws-like '@a[*-1]:callable', Exception;  # caught by MMD
    throws-like '@a[*-1]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what("element access"), :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# whatever
{
    is @à[*],                            <a b c d>, "$丧 whatever: value";
    is @à[*]:k,                          (0,1,2,3), "$丧 whatever: :k";
    is @à[*]:k($갨k̲),                     (0,1,2,3), "$丧 whatever: :k(\$갨k̲)";
    is @à[*]:!k,                         (0,1,2,3), "$丧 whatever: :!k";
    is @à[*]:k($丧갨),                     (0,1,2,3), "$丧 whatever: :k(\$丧갨)";
    is @à[*]:v,                          <a b c d>, "$丧 whatever: :v";
    is @à[*]:v($갨k̲),                     <a b c d>, "$丧 whatever: :v(\$갨k̲)";
    is @à[*]:!v,                         <a b c d>, "$丧 whatever: :!v";
    is @à[*]:v($丧갨),                     <a b c d>, "$丧 whatever: :v(\$丧갨)";
    is @à[*]:kv,         (0,"a",1,"b",2,"c",3,"d"), "$丧 whatever: :kv(\$갨k̲)";
    is @à[*]:kv($갨k̲),    (0,"a",1,"b",2,"c",3,"d"), "$丧 whatever: :kv";
    is @à[*]:!kv,        (0,"a",1,"b",2,"c",3,"d"), "$丧 whatever: :!kv";
    is @à[*]:kv($丧갨),    (0,"a",1,"b",2,"c",3,"d"), "$丧 whatever: :kv(\$丧갨)";
    is @à[*]:p,      (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 whatever: :p(\$갨k̲)";
    is @à[*]:p($갨k̲), (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 whatever: :p";
    is @à[*]:!p,     (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 whatever: :!p";
    is @à[*]:p($丧갨), (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 whatever: :p(\$丧갨)";

    throws-like '@a[*]:k:v', X::Adverb,
      :source(@à.name), :what("whatever slice"), :nogo(<k v>);
    throws-like '@a[*]:sourceever', Exception;  # caught by MMD
    throws-like '@a[*]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what("whatever slice"), :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# zen
{
    is @à[],                                   @à, "$丧 zen: value";
    is @à[]:k,                          (0,1,2,3), "$丧 zen: :k";
    is @à[]:k($갨k̲),                     (0,1,2,3), "$丧 zen: :k(\$갨k̲)";
    is @à[]:!k,                         (0,1,2,3), "$丧 zen: :!k";
    is @à[]:k($丧갨),                     (0,1,2,3), "$丧 zen: :k(\$丧갨)";
    is @à[]:v,                          <a b c d>, "$丧 zen: :v";
    is @à[]:v($갨k̲),                     <a b c d>, "$丧 zen: :v(\$갨k̲)";
    is @à[]:!v,                         <a b c d>, "$丧 zen: :!v";
    is @à[]:v($丧갨),                     <a b c d>, "$丧 zen: :v(\$丧갨)";
    is @à[]:kv,         (0,"a",1,"b",2,"c",3,"d"), "$丧 zen: :kv(\$갨k̲)";
    is @à[]:kv($갨k̲),    (0,"a",1,"b",2,"c",3,"d"), "$丧 zen: :kv";
    is @à[]:!kv,        (0,"a",1,"b",2,"c",3,"d"), "$丧 zen: :!kv";
    is @à[]:kv($丧갨),    (0,"a",1,"b",2,"c",3,"d"), "$丧 zen: :kv(\$丧갨)";
    is @à[]:p,      (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 zen: :p(\$갨k̲)";
    is @à[]:p($갨k̲), (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 zen: :p";
    is @à[]:!p,     (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 zen: :!p";
    is @à[]:p($丧갨), (0=>"a",1=>"b",2=>"c",3=>"d"), "$丧 zen: :p(\$丧갨)";

    throws-like '@a[]:foo', X::Adverb,
      :source(@à.name), :what("zen slice"), :unexpected<foo>,
    throws-like '@a[]:k:v', X::Adverb,
      :source(@à.name), :nogo(<k v>);
    throws-like '@a[]:kv:p:zip:zop', X::Adverb,
      :source(@à.name), :what("zen slice"), :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

}

# https://github.com/Raku/old-issue-tracker/issues/4697
{
    my @à;
    @à[$(7,8,9)] = 101;
    is @à.elems, 4, 'container respected in array assign';
    is @à[$(7,8,9)], 101, 'container respected in array access';
    is @à[$(7,8,9)]:exists, True, 'container respected in array :exists';
    @à[$(7,8,9)]:delete;
    is @à[$(7,8,9)]:exists, False, 'container respected in array :delete';
}

# vim: expandtab shiftwidth=4
