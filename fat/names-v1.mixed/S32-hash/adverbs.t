use Test;

plan 4 * ( 1 + 14 * 20 ) + 4;

#-------------------------------------------------------------------------------
# initialisations

my $갨k̲ = True;
my $丧갨 = False;

sub æe̲丧(\h) {
    my Int $i = 0;
    h{$_} = ++$i for 'a'..'d';
    is h.elems, 4, "{h.^name} basic sanity";
}

æe̲丧 my %à;
æe̲丧 my Int %i;
æe̲丧 my %c{Cool};
æe̲丧 my Int %j{Cool};

my @b  = <b>;
my @B  = <B>;
my @丛개 = <b c>;
my @丁갂 = <B C>;
my @丛갂 = <b C>;

#-------------------------------------------------------------------------------
# Hash

for $%à, Any, $%i, Int, $%c, Mu, $%j, Int -> %両, $T {
    my $丧 = %両.VAR.name;

# single existing key
{
    is %両<b>,               2, "$丧 single key existing: value";
    is %両<b>:k,           "b", "$丧 single key existing: :k";
    is %両<b>:k($갨k̲),      "b", "$丧 single key existing: :k(\$갨k̲)";
    is %両<b>:!k,          "b", "$丧 single key existing: :!k";
    is %両<b>:k($丧갨),      "b", "$丧 single key existing: :k(\$丧갨)";
    is %両<b>:v,             2, "$丧 single key existing: :v";
    is %両<b>:v($갨k̲),        2, "$丧 single key existing: :v(\$갨k̲)";
    is %両<b>:!v,            2, "$丧 single key existing: :!v";
    is %両<b>:v($丧갨),        2, "$丧 single key existing: :v(\$丧갨)";
    is %両<b>:kv,      ("b",2), "$丧 single key existing: :kv";
    is %両<b>:kv($갨k̲), ("b",2), "$丧 single key existing: :kv(\$갨k̲)";
    is %両<b>:!kv,     ("b",2), "$丧 single key existing: :!kv";
    is %両<b>:kv($丧갨), ("b",2), "$丧 single key existing: :kv(\$丧갨)";
    is %両<b>:p,        (b=>2), "$丧 single key existing: :p";
    is %両<b>:p($갨k̲),   (b=>2), "$丧 single key existing: :p(\$갨k̲)";
    is %両<b>:!p,       (b=>2), "$丧 single key existing: :!p";
    is %両<b>:p($丧갨),   (b=>2), "$丧 single key existing: :p(\$丧갨)";

    #?rakudo.jvm todo 'wrong multi selected, https://github.com/rakudo/rakudo/issues/5709'
    throws-like '%h<b>:k:v', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<k v>);
    throws-like '%h<b>:zorp', Exception; # caught by MMD
    #?rakudo.jvm todo 'wrong multi selected, https://github.com/rakudo/rakudo/issues/5709'
    throws-like '%h<b>:kv:p:zip:zop', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array single existing key
{
    is %両{@b},            (2,), "$丧 array single key existing: value";
    is %両{@b}:k,        ("b",), "$丧 array single key existing: :k";
    is %両{@b}:k($갨k̲),   ("b",), "$丧 array single key existing: :k(\$갨k̲)";
    is %両{@b}:!k,       ("b",), "$丧 array single key existing: :!k";
    is %両{@b}:k($丧갨),   ("b",), "$丧 array single key existing: :k(\$丧갨)";
    is %両{@b}:v,          (2,), "$丧 array single key existing: :v";
    is %両{@b}:v($갨k̲),     (2,), "$丧 array single key existing: :v(\$갨k̲)";
    is %両{@b}:!v,         (2,), "$丧 array single key existing: :!v";
    is %両{@b}:v($丧갨),     (2,), "$丧 array single key existing: :v(\$丧갨)";
    is %両{@b}:kv,      ("b",2), "$丧 array single key existing: :kv";
    is %両{@b}:kv($갨k̲), ("b",2), "$丧 array single key existing: :kv(\$갨k̲)";
    is %両{@b}:!kv,     ("b",2), "$丧 array single key existing: :!kv";
    is %両{@b}:kv($丧갨), ("b",2), "$丧 array single key existing: :kv(\$丧갨)";
    is %両{@b}:p,        (b=>2), "$丧 array single key existing: :p";
    is %両{@b}:p($갨k̲),   (b=>2), "$丧 single key existing: :p(\$갨k̲)";
    is %両{@b}:!p,       (b=>2), "$丧 single key existing: :!p";
    is %両{@b}:p($丧갨),   (b=>2), "$丧 single key existing: :p(\$丧갨)";

    throws-like '%h{@b}:k:v', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{@b}:rickroll', Exception; # caught by MMD
    throws-like '%h{@b}:kv:p:zip:zop', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# single missing key
{
    todo("#5419 default type on containers on objects hashes corrected in RakuAST")
      if $T<> =:= Mu;
    is %両<B>,               $T, "$丧 single key missing: value";
    is %両<B>:k,             (), "$丧 single key missing: :k";
    is %両<B>:k($갨k̲),        (), "$丧 single key missing: :k(\$갨k̲)";
    is %両<B>:!k,           "B", "$丧 single key missing: :!k";
    is %両<B>:k($丧갨),       "B", "$丧 single key missing: :k(\$丧갨)";
    is %両<B>:v,             (), "$丧 single key missing: :v";
    is %両<B>:v($갨k̲),        (), "$丧 single key missing: :v(\$갨k̲)";
    todo("#5419 default type on containers on objects hashes corrected in RakuAST",2)
      if $T<> =:= Mu;
    is %両<B>:!v,            $T, "$丧 single key missing: :!v";
    is %両<B>:v($丧갨),        $T, "$丧 single key missing: :v(\$丧갨)";
    is %両<B>:kv,            (), "$丧 single key missing: :kv(\$갨k̲)";
    is %両<B>:kv($갨k̲),       (), "$丧 single key missing: :kv";
    is %両<B>:!kv,     ("B",$T), "$丧 single key missing: :!kv";
    is %両<B>:kv($丧갨), ("B",$T), "$丧 single key missing: :kv(\$丧갨)";
    is %両<B>:p,             (), "$丧 single key missing: :p(\$갨k̲)";
    is %両<B>:p($갨k̲),        (), "$丧 single key missing: :p";
    is %両<B>:!p,       (B=>$T), "$丧 single key missing: :!p";
    is %両<B>:p($丧갨),   (B=>$T), "$丧 single key missing: :p(\$丧갨)";

    #?rakudo.jvm todo 'wrong multi selected, https://github.com/rakudo/rakudo/issues/5709'
    throws-like '%h<B>:k:v', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<k v>);
    throws-like '%h<B>:baxter', Exception; # caught by MMD
    #?rakudo.jvm todo 'wrong multi selected, https://github.com/rakudo/rakudo/issues/5709'
    throws-like '%h<B>:kv:p:zip:zop', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array single missing key
{
    is %両{@B},            ($T,), "$丧 array single key missing: value";
    is %両{@B}:k,             (), "$丧 array single key missing: :k";
    is %両{@B}:k($갨k̲),        (), "$丧 array single key missing: :k(\$갨k̲)";
    is %両{@B}:!k,        ("B",), "$丧 array single key missing: :!k";
    is %両{@B}:k($丧갨),    ("B",), "$丧 array single key missing: :k(\$丧갨)";
    is %両{@B}:v,             (), "$丧 array single key missing: :v";
    is %両{@B}:v($갨k̲),        (), "$丧 array single key missing: :v(\$갨k̲)";
    is %両{@B}:!v,         ($T,), "$丧 array single key missing: :!v";
    is %両{@B}:v($丧갨),     ($T,), "$丧 array single key missing: :v(\$丧갨)";
    is %両{@B}:kv,            (), "$丧 array single key missing: :kv(\$갨k̲)";
    is %両{@B}:kv($갨k̲),       (), "$丧 array single key missing: :kv";
    is %両{@B}:!kv,     ("B",$T), "$丧 array single key missing: :!kv";
    is %両{@B}:kv($丧갨), ("B",$T), "$丧 array single key missing: :kv(\$丧갨)";
    is %両{@B}:p,             (), "$丧 array single key missing: :p(\$갨k̲)";
    is %両{@B}:p($갨k̲),        (), "$丧 array single key missing: :p";
    is %両{@B}:!p,       (B=>$T), "$丧 array single key missing: :!p";
    is %両{@B}:p($丧갨),   (B=>$T), "$丧 array single key missing: :p(\$丧갨)";

    throws-like '%h{@B}:k:v', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{@B}:jefferson', Exception; # caught by MMD
    throws-like '%h{@B}:kv:p:zip:zop', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# multiple existing keys
{
    is %両<b c>,                 (2,3), "$丧 multiple key existing: value";
    is %両<b c>:k,               <b c>, "$丧 multiple key existing: :k";
    is %両<b c>:k($갨k̲),          <b c>, "$丧 multiple key existing: :k(\$갨k̲)";
    is %両<b c>:!k,              <b c>, "$丧 multiple key existing: :!k";
    is %両<b c>:k($丧갨),          <b c>, "$丧 multiple key existing: :k(\$丧갨)";
    is %両<b c>:v,               (2,3), "$丧 multiple key existing: :v";
    is %両<b c>:v($갨k̲),          (2,3), "$丧 multiple key existing: :v(\$갨k̲)";
    is %両<b c>:!v,              (2,3), "$丧 multiple key existing: :!v";
    is %両<b c>:v($丧갨),          (2,3), "$丧 multiple key existing: :v(\$丧갨)";
    is %両<b c>:kv,      ("b",2,"c",3), "$丧 multiple key existing: :kv";
    is %両<b c>:kv($갨k̲), ("b",2,"c",3), "$丧 multiple key existing: :kv(\$갨k̲)";
    is %両<b c>:!kv,     ("b",2,"c",3), "$丧 multiple key existing: :!kv";
    is %両<b c>:kv($丧갨), ("b",2,"c",3), "$丧 multiple key existing: :kv(\$丧갨)";
    is %両<b c>:p,         (b=>2,c=>3), "$丧 multiple key existing: :p";
    is %両<b c>:p($갨k̲),    (b=>2,c=>3), "$丧 multiple key existing: :p(\$갨k̲)";
    is %両<b c>:!p,        (b=>2,c=>3), "$丧 multiple key existing: :!p";
    is %両<b c>:p($丧갨),    (b=>2,c=>3), "$丧 multiple key existing: :p(\$丧갨)";

    throws-like '%h<b c>:k:v', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<k v>);
    throws-like '%h<b c>:egg', Exception; # caught by MMD
    throws-like '%h<b c>:kv:p:zip:zop', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array multiple existing keys
{
    is %両{@丛개},                 (2,3), "$丧 array multi key existing: value";
    is %両{@丛개}:k,               <b c>, "$丧 array multi key existing: :k";
    is %両{@丛개}:k($갨k̲),          <b c>, "$丧 array multi key existing: :k(\$갨k̲)";
    is %両{@丛개}:!k,              <b c>, "$丧 array multi key existing: :!k";
    is %両{@丛개}:k($丧갨),          <b c>, "$丧 array multi key existing: :k(\$丧갨)";
    is %両{@丛개}:v,               (2,3), "$丧 array multi key existing: :v";
    is %両{@丛개}:v($갨k̲),          (2,3), "$丧 array multi key existing: :v(\$갨k̲)";
    is %両{@丛개}:!v,              (2,3), "$丧 array multi key existing: :!v";
    is %両{@丛개}:v($丧갨),          (2,3), "$丧 array multi key existing: :v(\$丧갨)";
    is %両{@丛개}:kv,      ("b",2,"c",3), "$丧 array multi key existing: :kv";
    is %両{@丛개}:kv($갨k̲), ("b",2,"c",3), "$丧 array multi key existing: :kv(\$갨k̲)";
    is %両{@丛개}:!kv,     ("b",2,"c",3), "$丧 array multi key existing: :!kv";
    is %両{@丛개}:kv($丧갨), ("b",2,"c",3), "$丧 array multi key existing: :kv(\$丧갨)";
    is %両{@丛개}:p,         (b=>2,c=>3), "$丧 array multi key existing: :p";
    is %両{@丛개}:p($갨k̲),    (b=>2,c=>3), "$丧 array multi key existing: :p(\$갨k̲)";
    is %両{@丛개}:!p,        (b=>2,c=>3), "$丧 array multi key existing: :!p";
    is %両{@丛개}:p($丧갨),    (b=>2,c=>3), "$丧 array multi key existing: :p(\$丧갨)";

    throws-like '%h{@bc}:k:v', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{@bc}:omelet', Exception; # caught by MMD
    throws-like '%h{@bc}:kv:p:zip:zop', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# range multiple existing keys
{
    is %両{"b".."c"},                 (2,3), "$丧 range mult key exist: value";
    is %両{"b".."c"}:k,               <b c>, "$丧 range mult key exist: :k";
    is %両{"b".."c"}:k($갨k̲),          <b c>, "$丧 range mult key exist: :k(\$갨k̲)";
    is %両{"b".."c"}:!k,              <b c>, "$丧 range mult key exist: :!k";
    is %両{"b".."c"}:k($丧갨),          <b c>, "$丧 range mult key exist: :k(\$丧갨)";
    is %両{"b".."c"}:v,               (2,3), "$丧 range mult key exist: :v";
    is %両{"b".."c"}:v($갨k̲),          (2,3), "$丧 range mult key exist: :v(\$갨k̲)";
    is %両{"b".."c"}:!v,              (2,3), "$丧 range mult key exist: :!v";
    is %両{"b".."c"}:v($丧갨),          (2,3), "$丧 range mult key exist: :v(\$丧갨)";
    is %両{"b".."c"}:kv,      ("b",2,"c",3), "$丧 range mult key exist: :kv";
    is %両{"b".."c"}:kv($갨k̲), ("b",2,"c",3), "$丧 range mult key exist: :kv(\$갨k̲)";
    is %両{"b".."c"}:!kv,     ("b",2,"c",3), "$丧 range mult key exist: :!kv";
    is %両{"b".."c"}:kv($丧갨), ("b",2,"c",3), "$丧 range mult key exist: :kv(\$丧갨)";
    is %両{"b".."c"}:p,         (b=>2,c=>3), "$丧 range mult key exist: :p";
    is %両{"b".."c"}:p($갨k̲),    (b=>2,c=>3), "$丧 range mult key exist: :p(\$갨k̲)";
    is %両{"b".."c"}:!p,        (b=>2,c=>3), "$丧 range mult key exist: :!p";
    is %両{"b".."c"}:p($丧갨),    (b=>2,c=>3), "$丧 range mult key exist: :p(\$丧갨)";

    throws-like '%h{"b".."c"}:k:v', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{"b".."c"}:rivet', Exception; # caught by MMD
    throws-like '%h{"b".."c"}:kv:p:zip:zop', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# multiple missing keys
{
    is %両<B C>,                 ($T,$T), "$丧 multiple key missing: value";
    is %両<B C>:k,                    (), "$丧 multiple key missing: :k";
    is %両<B C>:k($갨k̲),               (), "$丧 multiple key missing: :k(\$갨k̲)";
    is %両<B C>:!k,                <B C>, "$丧 multiple key missing: :!k";
    is %両<B C>:k($丧갨),            <B C>, "$丧 multiple key missing: :k(\$丧갨)";
    is %両<B C>:v,                    (), "$丧 multiple key missing: :v";
    is %両<B C>:v($갨k̲),               (), "$丧 multiple key missing: :v(\$갨k̲)";
    is %両<B C>:!v,              ($T,$T), "$丧 multiple key missing: :!v";
    is %両<B C>:v($丧갨),          ($T,$T), "$丧 multiple key missing: :v(\$丧갨)";
    is %両<B C>:kv,                   (), "$丧 multiple key missing: :kv(\$갨k̲)";
    is %両<B C>:kv($갨k̲),              (), "$丧 multiple key missing: :kv";
    is %両<B C>:!kv,     ("B",$T,"C",$T), "$丧 multiple key missing: :!kv";
    is %両<B C>:kv($丧갨), ("B",$T,"C",$T), "$丧 multiple key missing: :kv(\$丧갨)";
    is %両<B C>:p,                    (), "$丧 multiple key missing: :p(\$갨k̲)";
    is %両<B C>:p($갨k̲),               (), "$丧 multiple key missing: :p";
    is %両<B C>:!p,        (B=>$T,C=>$T), "$丧 multiple key missing: :!p";
    is %両<B C>:p($丧갨),    (B=>$T,C=>$T), "$丧 multiple key missing: :p(\$丧갨)";

    throws-like '%h<B C>:k:v', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<k v>);
    throws-like '%h<B C>:echt', Exception; # caught by MMD
    throws-like '%h<B C>:kv:p:zip:zop', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array multiple missing keys
{
    is %両{@丁갂},                 ($T,$T), "$丧 array multi key missing: value";
    is %両{@丁갂}:k,                    (), "$丧 array multi key missing: :k";
    is %両{@丁갂}:k($갨k̲),               (), "$丧 array multi key missing: :k(\$갨k̲)";
    is %両{@丁갂}:!k,                <B C>, "$丧 array multi key missing: :!k";
    is %両{@丁갂}:k($丧갨),            <B C>, "$丧 array multi key missing: :k(\$丧갨)";
    is %両{@丁갂}:v,                    (), "$丧 array multi key missing: :v";
    is %両{@丁갂}:v($갨k̲),               (), "$丧 array multi key missing: :v(\$갨k̲)";
    is %両{@丁갂}:!v,              ($T,$T), "$丧 array multi key missing: :!v";
    is %両{@丁갂}:v($丧갨),          ($T,$T), "$丧 array multi key missing: :v(\$丧갨)";
    is %両{@丁갂}:kv,                   (), "$丧 array multi key missing: :kv(\$갨k̲)";
    is %両{@丁갂}:kv($갨k̲),              (), "$丧 array multi key missing: :kv";
    is %両{@丁갂}:!kv,     ("B",$T,"C",$T), "$丧 array multi key missing: :!kv";
    is %両{@丁갂}:kv($丧갨), ("B",$T,"C",$T), "$丧 array multi key missing: :kv(\$丧갨)";
    is %両{@丁갂}:p,                    (), "$丧 array multi key missing: :p(\$갨k̲)";
    is %両{@丁갂}:p($갨k̲),               (), "$丧 array multi key missing: :p";
    is %両{@丁갂}:!p,        (B=>$T,C=>$T), "$丧 array multi key missing: :!p";
    is %両{@丁갂}:p($丧갨),    (B=>$T,C=>$T), "$丧 array multi key missing: :p(\$丧갨)";

    throws-like '%h{@BC}:k:v', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{@BC}:gaston', Exception; # caught by MMD
    throws-like '%h{@BC}:kv:p:zip:zop', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# range multiple missing keys
{
    is %両{"B".."C"},                 ($T,$T), "$丧 range mul key miss: value";
    is %両{"B".."C"}:k,                    (), "$丧 range mul key miss: :k";
    is %両{"B".."C"}:k($갨k̲),               (), "$丧 range mul key miss: :k(\$갨k̲)";
    is %両{"B".."C"}:!k,                <B C>, "$丧 range mul key miss: :!k";
    is %両{"B".."C"}:k($丧갨),            <B C>, "$丧 range mul key miss: :k(\$丧갨)";
    is %両{"B".."C"}:v,                    (), "$丧 range mul key miss: :v";
    is %両{"B".."C"}:v($갨k̲),               (), "$丧 range mul key miss: :v(\$갨k̲)";
    is %両{"B".."C"}:!v,              ($T,$T), "$丧 range mul key miss: :!v";
    is %両{"B".."C"}:v($丧갨),          ($T,$T), "$丧 range mul key miss: :v(\$丧갨)";
    is %両{"B".."C"}:kv,                   (), "$丧 range mul key miss: :kv(\$갨k̲)";
    is %両{"B".."C"}:kv($갨k̲),              (), "$丧 range mul key miss: :kv";
    is %両{"B".."C"}:!kv,     ("B",$T,"C",$T), "$丧 range mul key miss: :!kv";
    is %両{"B".."C"}:kv($丧갨), ("B",$T,"C",$T), "$丧 range mul key miss: :kv(\$丧갨)";
    is %両{"B".."C"}:p,                    (), "$丧 range mul key miss: :p(\$갨k̲)";
    is %両{"B".."C"}:p($갨k̲),               (), "$丧 range mul key miss: :p";
    is %両{"B".."C"}:!p,        (B=>$T,C=>$T), "$丧 range mul key miss: :!p";
    is %両{"B".."C"}:p($丧갨),    (B=>$T,C=>$T), "$丧 range mul key miss: :p(\$丧갨)";

    throws-like '%h{"B".."C"}:k:v', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{"B".."C"}:nostuff', Exception; # caught by MMD
    throws-like '%h{"B".."C"}:kv:p:zip:zop', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# mixed existing/missing keys
{
    is %両<b C>,                 (2,$T), "$丧 multiple key mixed: value";
    is %両<b C>:k,                  <b>, "$丧 multiple key mixed: :k";
    is %両<b C>:k($갨k̲),             <b>, "$丧 multiple key mixed: :k(\$갨k̲)";
    is %両<b C>:!k,               <b C>, "$丧 multiple key mixed: :!k";
    is %両<b C>:k($丧갨),           <b C>, "$丧 multiple key mixed: :k(\$丧갨)";
    is %両<b C>:v,                 (2,), "$丧 multiple key mixed: :v";
    is %両<b C>:v($갨k̲),            (2,), "$丧 multiple key mixed: :v(\$갨k̲)";
    is %両<b C>:!v,              (2,$T), "$丧 multiple key mixed: :!v";
    is %両<b C>:v($丧갨),          (2,$T), "$丧 multiple key mixed: :v(\$丧갨)";
    is %両<b C>:kv,             ("b",2), "$丧 multiple key mixed: :kv(\$갨k̲)";
    is %両<b C>:kv($갨k̲),        ("b",2), "$丧 multiple key mixed: :kv";
    is %両<b C>:!kv,     ("b",2,"C",$T), "$丧 multiple key mixed: :!kv";
    is %両<b C>:kv($丧갨), ("b",2,"C",$T), "$丧 multiple key mixed: :kv(\$丧갨)";
    is %両<b C>:p,               (b=>2), "$丧 multiple key mixed: :p(\$갨k̲)";
    is %両<b C>:p($갨k̲),          (b=>2), "$丧 multiple key mixed: :p";
    is %両<b C>:!p,        (b=>2,C=>$T), "$丧 multiple key mixed: :!p";
    is %両<b C>:p($丧갨),    (b=>2,C=>$T), "$丧 multiple key mixed: :p(\$丧갨)";

    throws-like '%h<b C>:k:v', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<k v>);
    throws-like '%h<b C>:fnoppo', Exception; # caught by MMD
    throws-like '%h<b C>:kv:p:zip:zop', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array mixed existing/missing keys
{
    is %両{@丛갂},                 (2,$T), "$丧 array multiple key mixed: value";
    is %両{@丛갂}:k,                  <b>, "$丧 array multiple key mixed: :k";
    is %両{@丛갂}:k($갨k̲),             <b>, "$丧 array multiple key mixed: :k(\$갨k̲)";
    is %両{@丛갂}:!k,               <b C>, "$丧 array multiple key mixed: :!k";
    is %両{@丛갂}:k($丧갨),           <b C>, "$丧 array multiple key mixed: :k(\$丧갨)";
    is %両{@丛갂}:v,                 (2,), "$丧 array multiple key mixed: :v";
    is %両{@丛갂}:v($갨k̲),            (2,), "$丧 array multiple key mixed: :v(\$갨k̲)";
    is %両{@丛갂}:!v,              (2,$T), "$丧 array multiple key mixed: :!v";
    is %両{@丛갂}:v($丧갨),          (2,$T), "$丧 array multiple key mixed: :v(\$丧갨)";
    is %両{@丛갂}:kv,             ("b",2), "$丧 array multiple key mixed: :kv(\$갨k̲)";
    is %両{@丛갂}:kv($갨k̲),        ("b",2), "$丧 array multiple key mixed: :kv";
    is %両{@丛갂}:!kv,     ("b",2,"C",$T), "$丧 array multiple key mixed: :!kv";
    is %両{@丛갂}:kv($丧갨), ("b",2,"C",$T), "$丧 array multiple key mixed: :kv(\$丧갨)";
    is %両{@丛갂}:p,               (b=>2), "$丧 array multiple key mixed: :p(\$갨k̲)";
    is %両{@丛갂}:p($갨k̲),          (b=>2), "$丧 array multiple key mixed: :p";
    is %両{@丛갂}:!p,        (b=>2,C=>$T), "$丧 array multiple key mixed: :!p";
    is %両{@丛갂}:p($丧갨),    (b=>2,C=>$T), "$丧 array multiple key mixed: :p(\$丧갨)";

    throws-like '%h{@bC}:k:v', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{@bC}:frits', Exception; # caught by MMD
    throws-like '%h{@bC}:kv:p:zip:zop', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# whatever
{
    is %両{*}.sort,                           (1,2,3,4), "$丧 whatever: value";
    is (%両{*}:k).sort,                       <a b c d>, "$丧 whatever: :k";
    is (%両{*}:k($갨k̲)).sort,                  <a b c d>, "$丧 whatever: :k(\$갨k̲)";
    is (%両{*}:!k).sort,                      <a b c d>, "$丧 whatever: :!k";
    is (%両{*}:k($丧갨)).sort,                  <a b c d>, "$丧 whatever: :k(\$丧갨)";
    is (%両{*}:v).sort,                       (1,2,3,4), "$丧 whatever: :v";
    is (%両{*}:v($갨k̲)).sort,                  (1,2,3,4), "$丧 whatever: :v(\$갨k̲)";
    is (%両{*}:!v).sort,                      (1,2,3,4), "$丧 whatever: :!v";
    is (%両{*}:v($丧갨)).sort,                  (1,2,3,4), "$丧 whatever: :v(\$丧갨)";
    is (%両{*}:kv).sort,      (1,2,3,4,"a","b","c","d"), "$丧 whatever: :kv(\$갨k̲)";
    is (%両{*}:kv($갨k̲)).sort, (1,2,3,4,"a","b","c","d"), "$丧 whatever: :kv";
    is (%両{*}:!kv).sort,     (1,2,3,4,"a","b","c","d"), "$丧 whatever: :!kv";
    is (%両{*}:kv($丧갨)).sort, (1,2,3,4,"a","b","c","d"), "$丧 whatever: :kv(\$丧갨)";
    is (%両{*}:p).sort(*.key),        (:1a,:2b,:3c,:4d), "$丧 whatever: :p(\$갨k̲)";
    is (%両{*}:p($갨k̲)).sort(*.key),   (:1a,:2b,:3c,:4d), "$丧 whatever: :p";
    is (%両{*}:!p).sort(*.key),       (:1a,:2b,:3c,:4d), "$丧 whatever: :!p";
    is (%両{*}:p($丧갨)).sort(*.key),   (:1a,:2b,:3c,:4d), "$丧 whatever: :p(\$丧갨)";

    throws-like '%h{*}:k:v', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{*}:sourceever', Exception; # caught by MMD
    throws-like '%h{*}:kv:p:zip:zop', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# zen
{
    is %両{},                                       %両, "$丧 zen: value";
    is (%両{}:k).sort,                       <a b c d>, "$丧 zen: :k";
    is (%両{}:k($갨k̲)).sort,                  <a b c d>, "$丧 zen: :k(\$갨k̲)";
    is (%両{}:!k).sort,                      <a b c d>, "$丧 zen: :!k";
    is (%両{}:k($丧갨)).sort,                  <a b c d>, "$丧 zen: :k(\$丧갨)";
    is (%両{}:v).sort,                       (1,2,3,4), "$丧 zen: :v";
    is (%両{}:v($갨k̲)).sort,                  (1,2,3,4), "$丧 zen: :v(\$갨k̲)";
    is (%両{}:!v).sort,                      (1,2,3,4), "$丧 zen: :!v";
    is (%両{}:v($丧갨)).sort,                  (1,2,3,4), "$丧 zen: :v(\$丧갨)";
    is (%両{}:kv).sort,      (1,2,3,4,"a","b","c","d"), "$丧 zen: :kv(\$갨k̲)";
    is (%両{}:kv($갨k̲)).sort, (1,2,3,4,"a","b","c","d"), "$丧 zen: :kv";
    is (%両{}:!kv).sort,     (1,2,3,4,"a","b","c","d"), "$丧 zen: :!kv";
    is (%両{}:kv($丧갨)).sort, (1,2,3,4,"a","b","c","d"), "$丧 zen: :kv(\$丧갨)";
    is (%両{}:p).sort(*.key),        (:1a,:2b,:3c,:4d), "$丧 zen: :p(\$갨k̲)";
    is (%両{}:p($갨k̲)).sort(*.key),   (:1a,:2b,:3c,:4d), "$丧 zen: :p";
    is (%両{}:!p).sort(*.key),       (:1a,:2b,:3c,:4d), "$丧 zen: :!p";
    is (%両{}:p($丧갨)).sort(*.key),   (:1a,:2b,:3c,:4d), "$丧 zen: :p(\$丧갨)";

    throws-like '%h{}:foo', X::Adverb,
      :source(%両.name), :what('{} slice'), :unexpected<foo>;
    throws-like '%h{}:k:v', X::Adverb,
      :source(%両.name), :nogo(<k v>);
    throws-like '%h{}:kv:p:zip:zop', X::Adverb,
      :source(%両.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

}

# https://github.com/Raku/old-issue-tracker/issues/4697
{
    my %両{Any};
    my $k̲e̲ù = $(1,2,3);
    %両{$k̲e̲ù} = 42;
    is %両.elems, 1, 'container respected in hash assign';
    is %両{$k̲e̲ù}, 42, 'container respected in hash access';
    is %両{$k̲e̲ù}:exists, True, 'container respected in hash :exists';
    %両{$k̲e̲ù}:delete;
    is %両.elems, 0, 'container respected in hash :delete';
}

# vim: expandtab shiftwidth=4
