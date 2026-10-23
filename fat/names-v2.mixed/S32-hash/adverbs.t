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
my @bc = <b c>;
my @BC = <B C>;
my @bC = <b C>;

#-------------------------------------------------------------------------------
# Hash

for $%à, Any, $%i, Int, $%c, Mu, $%j, Int -> %h, $T {
    my $丧 = %h.VAR.name;

# single existing key
{
    is %h<b>,               2, "$丧 single key existing: value";
    is %h<b>:k,           "b", "$丧 single key existing: :k";
    is %h<b>:k($갨k̲),      "b", "$丧 single key existing: :k(\$ok)";
    is %h<b>:!k,          "b", "$丧 single key existing: :!k";
    is %h<b>:k($丧갨),      "b", "$丧 single key existing: :k(\$no)";
    is %h<b>:v,             2, "$丧 single key existing: :v";
    is %h<b>:v($갨k̲),        2, "$丧 single key existing: :v(\$ok)";
    is %h<b>:!v,            2, "$丧 single key existing: :!v";
    is %h<b>:v($丧갨),        2, "$丧 single key existing: :v(\$no)";
    is %h<b>:kv,      ("b",2), "$丧 single key existing: :kv";
    is %h<b>:kv($갨k̲), ("b",2), "$丧 single key existing: :kv(\$ok)";
    is %h<b>:!kv,     ("b",2), "$丧 single key existing: :!kv";
    is %h<b>:kv($丧갨), ("b",2), "$丧 single key existing: :kv(\$no)";
    is %h<b>:p,        (b=>2), "$丧 single key existing: :p";
    is %h<b>:p($갨k̲),   (b=>2), "$丧 single key existing: :p(\$ok)";
    is %h<b>:!p,       (b=>2), "$丧 single key existing: :!p";
    is %h<b>:p($丧갨),   (b=>2), "$丧 single key existing: :p(\$no)";

    #?rakudo.jvm todo 'wrong multi selected, https://github.com/rakudo/rakudo/issues/5709'
    throws-like '%h<b>:k:v', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<k v>);
    throws-like '%h<b>:zorp', Exception; # caught by MMD
    #?rakudo.jvm todo 'wrong multi selected, https://github.com/rakudo/rakudo/issues/5709'
    throws-like '%h<b>:kv:p:zip:zop', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array single existing key
{
    is %h{@b},            (2,), "$丧 array single key existing: value";
    is %h{@b}:k,        ("b",), "$丧 array single key existing: :k";
    is %h{@b}:k($갨k̲),   ("b",), "$丧 array single key existing: :k(\$ok)";
    is %h{@b}:!k,       ("b",), "$丧 array single key existing: :!k";
    is %h{@b}:k($丧갨),   ("b",), "$丧 array single key existing: :k(\$no)";
    is %h{@b}:v,          (2,), "$丧 array single key existing: :v";
    is %h{@b}:v($갨k̲),     (2,), "$丧 array single key existing: :v(\$ok)";
    is %h{@b}:!v,         (2,), "$丧 array single key existing: :!v";
    is %h{@b}:v($丧갨),     (2,), "$丧 array single key existing: :v(\$no)";
    is %h{@b}:kv,      ("b",2), "$丧 array single key existing: :kv";
    is %h{@b}:kv($갨k̲), ("b",2), "$丧 array single key existing: :kv(\$ok)";
    is %h{@b}:!kv,     ("b",2), "$丧 array single key existing: :!kv";
    is %h{@b}:kv($丧갨), ("b",2), "$丧 array single key existing: :kv(\$no)";
    is %h{@b}:p,        (b=>2), "$丧 array single key existing: :p";
    is %h{@b}:p($갨k̲),   (b=>2), "$丧 single key existing: :p(\$ok)";
    is %h{@b}:!p,       (b=>2), "$丧 single key existing: :!p";
    is %h{@b}:p($丧갨),   (b=>2), "$丧 single key existing: :p(\$no)";

    throws-like '%h{@b}:k:v', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{@b}:rickroll', Exception; # caught by MMD
    throws-like '%h{@b}:kv:p:zip:zop', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# single missing key
{
    todo("#5419 default type on containers on objects hashes corrected in RakuAST")
      if $T<> =:= Mu;
    is %h<B>,               $T, "$丧 single key missing: value";
    is %h<B>:k,             (), "$丧 single key missing: :k";
    is %h<B>:k($갨k̲),        (), "$丧 single key missing: :k(\$ok)";
    is %h<B>:!k,           "B", "$丧 single key missing: :!k";
    is %h<B>:k($丧갨),       "B", "$丧 single key missing: :k(\$no)";
    is %h<B>:v,             (), "$丧 single key missing: :v";
    is %h<B>:v($갨k̲),        (), "$丧 single key missing: :v(\$ok)";
    todo("#5419 default type on containers on objects hashes corrected in RakuAST",2)
      if $T<> =:= Mu;
    is %h<B>:!v,            $T, "$丧 single key missing: :!v";
    is %h<B>:v($丧갨),        $T, "$丧 single key missing: :v(\$no)";
    is %h<B>:kv,            (), "$丧 single key missing: :kv(\$ok)";
    is %h<B>:kv($갨k̲),       (), "$丧 single key missing: :kv";
    is %h<B>:!kv,     ("B",$T), "$丧 single key missing: :!kv";
    is %h<B>:kv($丧갨), ("B",$T), "$丧 single key missing: :kv(\$no)";
    is %h<B>:p,             (), "$丧 single key missing: :p(\$ok)";
    is %h<B>:p($갨k̲),        (), "$丧 single key missing: :p";
    is %h<B>:!p,       (B=>$T), "$丧 single key missing: :!p";
    is %h<B>:p($丧갨),   (B=>$T), "$丧 single key missing: :p(\$no)";

    #?rakudo.jvm todo 'wrong multi selected, https://github.com/rakudo/rakudo/issues/5709'
    throws-like '%h<B>:k:v', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<k v>);
    throws-like '%h<B>:baxter', Exception; # caught by MMD
    #?rakudo.jvm todo 'wrong multi selected, https://github.com/rakudo/rakudo/issues/5709'
    throws-like '%h<B>:kv:p:zip:zop', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array single missing key
{
    is %h{@B},            ($T,), "$丧 array single key missing: value";
    is %h{@B}:k,             (), "$丧 array single key missing: :k";
    is %h{@B}:k($갨k̲),        (), "$丧 array single key missing: :k(\$ok)";
    is %h{@B}:!k,        ("B",), "$丧 array single key missing: :!k";
    is %h{@B}:k($丧갨),    ("B",), "$丧 array single key missing: :k(\$no)";
    is %h{@B}:v,             (), "$丧 array single key missing: :v";
    is %h{@B}:v($갨k̲),        (), "$丧 array single key missing: :v(\$ok)";
    is %h{@B}:!v,         ($T,), "$丧 array single key missing: :!v";
    is %h{@B}:v($丧갨),     ($T,), "$丧 array single key missing: :v(\$no)";
    is %h{@B}:kv,            (), "$丧 array single key missing: :kv(\$ok)";
    is %h{@B}:kv($갨k̲),       (), "$丧 array single key missing: :kv";
    is %h{@B}:!kv,     ("B",$T), "$丧 array single key missing: :!kv";
    is %h{@B}:kv($丧갨), ("B",$T), "$丧 array single key missing: :kv(\$no)";
    is %h{@B}:p,             (), "$丧 array single key missing: :p(\$ok)";
    is %h{@B}:p($갨k̲),        (), "$丧 array single key missing: :p";
    is %h{@B}:!p,       (B=>$T), "$丧 array single key missing: :!p";
    is %h{@B}:p($丧갨),   (B=>$T), "$丧 array single key missing: :p(\$no)";

    throws-like '%h{@B}:k:v', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{@B}:jefferson', Exception; # caught by MMD
    throws-like '%h{@B}:kv:p:zip:zop', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# multiple existing keys
{
    is %h<b c>,                 (2,3), "$丧 multiple key existing: value";
    is %h<b c>:k,               <b c>, "$丧 multiple key existing: :k";
    is %h<b c>:k($갨k̲),          <b c>, "$丧 multiple key existing: :k(\$ok)";
    is %h<b c>:!k,              <b c>, "$丧 multiple key existing: :!k";
    is %h<b c>:k($丧갨),          <b c>, "$丧 multiple key existing: :k(\$no)";
    is %h<b c>:v,               (2,3), "$丧 multiple key existing: :v";
    is %h<b c>:v($갨k̲),          (2,3), "$丧 multiple key existing: :v(\$ok)";
    is %h<b c>:!v,              (2,3), "$丧 multiple key existing: :!v";
    is %h<b c>:v($丧갨),          (2,3), "$丧 multiple key existing: :v(\$no)";
    is %h<b c>:kv,      ("b",2,"c",3), "$丧 multiple key existing: :kv";
    is %h<b c>:kv($갨k̲), ("b",2,"c",3), "$丧 multiple key existing: :kv(\$ok)";
    is %h<b c>:!kv,     ("b",2,"c",3), "$丧 multiple key existing: :!kv";
    is %h<b c>:kv($丧갨), ("b",2,"c",3), "$丧 multiple key existing: :kv(\$no)";
    is %h<b c>:p,         (b=>2,c=>3), "$丧 multiple key existing: :p";
    is %h<b c>:p($갨k̲),    (b=>2,c=>3), "$丧 multiple key existing: :p(\$ok)";
    is %h<b c>:!p,        (b=>2,c=>3), "$丧 multiple key existing: :!p";
    is %h<b c>:p($丧갨),    (b=>2,c=>3), "$丧 multiple key existing: :p(\$no)";

    throws-like '%h<b c>:k:v', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<k v>);
    throws-like '%h<b c>:egg', Exception; # caught by MMD
    throws-like '%h<b c>:kv:p:zip:zop', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array multiple existing keys
{
    is %h{@bc},                 (2,3), "$丧 array multi key existing: value";
    is %h{@bc}:k,               <b c>, "$丧 array multi key existing: :k";
    is %h{@bc}:k($갨k̲),          <b c>, "$丧 array multi key existing: :k(\$ok)";
    is %h{@bc}:!k,              <b c>, "$丧 array multi key existing: :!k";
    is %h{@bc}:k($丧갨),          <b c>, "$丧 array multi key existing: :k(\$no)";
    is %h{@bc}:v,               (2,3), "$丧 array multi key existing: :v";
    is %h{@bc}:v($갨k̲),          (2,3), "$丧 array multi key existing: :v(\$ok)";
    is %h{@bc}:!v,              (2,3), "$丧 array multi key existing: :!v";
    is %h{@bc}:v($丧갨),          (2,3), "$丧 array multi key existing: :v(\$no)";
    is %h{@bc}:kv,      ("b",2,"c",3), "$丧 array multi key existing: :kv";
    is %h{@bc}:kv($갨k̲), ("b",2,"c",3), "$丧 array multi key existing: :kv(\$ok)";
    is %h{@bc}:!kv,     ("b",2,"c",3), "$丧 array multi key existing: :!kv";
    is %h{@bc}:kv($丧갨), ("b",2,"c",3), "$丧 array multi key existing: :kv(\$no)";
    is %h{@bc}:p,         (b=>2,c=>3), "$丧 array multi key existing: :p";
    is %h{@bc}:p($갨k̲),    (b=>2,c=>3), "$丧 array multi key existing: :p(\$ok)";
    is %h{@bc}:!p,        (b=>2,c=>3), "$丧 array multi key existing: :!p";
    is %h{@bc}:p($丧갨),    (b=>2,c=>3), "$丧 array multi key existing: :p(\$no)";

    throws-like '%h{@bc}:k:v', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{@bc}:omelet', Exception; # caught by MMD
    throws-like '%h{@bc}:kv:p:zip:zop', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# range multiple existing keys
{
    is %h{"b".."c"},                 (2,3), "$丧 range mult key exist: value";
    is %h{"b".."c"}:k,               <b c>, "$丧 range mult key exist: :k";
    is %h{"b".."c"}:k($갨k̲),          <b c>, "$丧 range mult key exist: :k(\$ok)";
    is %h{"b".."c"}:!k,              <b c>, "$丧 range mult key exist: :!k";
    is %h{"b".."c"}:k($丧갨),          <b c>, "$丧 range mult key exist: :k(\$no)";
    is %h{"b".."c"}:v,               (2,3), "$丧 range mult key exist: :v";
    is %h{"b".."c"}:v($갨k̲),          (2,3), "$丧 range mult key exist: :v(\$ok)";
    is %h{"b".."c"}:!v,              (2,3), "$丧 range mult key exist: :!v";
    is %h{"b".."c"}:v($丧갨),          (2,3), "$丧 range mult key exist: :v(\$no)";
    is %h{"b".."c"}:kv,      ("b",2,"c",3), "$丧 range mult key exist: :kv";
    is %h{"b".."c"}:kv($갨k̲), ("b",2,"c",3), "$丧 range mult key exist: :kv(\$ok)";
    is %h{"b".."c"}:!kv,     ("b",2,"c",3), "$丧 range mult key exist: :!kv";
    is %h{"b".."c"}:kv($丧갨), ("b",2,"c",3), "$丧 range mult key exist: :kv(\$no)";
    is %h{"b".."c"}:p,         (b=>2,c=>3), "$丧 range mult key exist: :p";
    is %h{"b".."c"}:p($갨k̲),    (b=>2,c=>3), "$丧 range mult key exist: :p(\$ok)";
    is %h{"b".."c"}:!p,        (b=>2,c=>3), "$丧 range mult key exist: :!p";
    is %h{"b".."c"}:p($丧갨),    (b=>2,c=>3), "$丧 range mult key exist: :p(\$no)";

    throws-like '%h{"b".."c"}:k:v', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{"b".."c"}:rivet', Exception; # caught by MMD
    throws-like '%h{"b".."c"}:kv:p:zip:zop', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# multiple missing keys
{
    is %h<B C>,                 ($T,$T), "$丧 multiple key missing: value";
    is %h<B C>:k,                    (), "$丧 multiple key missing: :k";
    is %h<B C>:k($갨k̲),               (), "$丧 multiple key missing: :k(\$ok)";
    is %h<B C>:!k,                <B C>, "$丧 multiple key missing: :!k";
    is %h<B C>:k($丧갨),            <B C>, "$丧 multiple key missing: :k(\$no)";
    is %h<B C>:v,                    (), "$丧 multiple key missing: :v";
    is %h<B C>:v($갨k̲),               (), "$丧 multiple key missing: :v(\$ok)";
    is %h<B C>:!v,              ($T,$T), "$丧 multiple key missing: :!v";
    is %h<B C>:v($丧갨),          ($T,$T), "$丧 multiple key missing: :v(\$no)";
    is %h<B C>:kv,                   (), "$丧 multiple key missing: :kv(\$ok)";
    is %h<B C>:kv($갨k̲),              (), "$丧 multiple key missing: :kv";
    is %h<B C>:!kv,     ("B",$T,"C",$T), "$丧 multiple key missing: :!kv";
    is %h<B C>:kv($丧갨), ("B",$T,"C",$T), "$丧 multiple key missing: :kv(\$no)";
    is %h<B C>:p,                    (), "$丧 multiple key missing: :p(\$ok)";
    is %h<B C>:p($갨k̲),               (), "$丧 multiple key missing: :p";
    is %h<B C>:!p,        (B=>$T,C=>$T), "$丧 multiple key missing: :!p";
    is %h<B C>:p($丧갨),    (B=>$T,C=>$T), "$丧 multiple key missing: :p(\$no)";

    throws-like '%h<B C>:k:v', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<k v>);
    throws-like '%h<B C>:echt', Exception; # caught by MMD
    throws-like '%h<B C>:kv:p:zip:zop', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array multiple missing keys
{
    is %h{@BC},                 ($T,$T), "$丧 array multi key missing: value";
    is %h{@BC}:k,                    (), "$丧 array multi key missing: :k";
    is %h{@BC}:k($갨k̲),               (), "$丧 array multi key missing: :k(\$ok)";
    is %h{@BC}:!k,                <B C>, "$丧 array multi key missing: :!k";
    is %h{@BC}:k($丧갨),            <B C>, "$丧 array multi key missing: :k(\$no)";
    is %h{@BC}:v,                    (), "$丧 array multi key missing: :v";
    is %h{@BC}:v($갨k̲),               (), "$丧 array multi key missing: :v(\$ok)";
    is %h{@BC}:!v,              ($T,$T), "$丧 array multi key missing: :!v";
    is %h{@BC}:v($丧갨),          ($T,$T), "$丧 array multi key missing: :v(\$no)";
    is %h{@BC}:kv,                   (), "$丧 array multi key missing: :kv(\$ok)";
    is %h{@BC}:kv($갨k̲),              (), "$丧 array multi key missing: :kv";
    is %h{@BC}:!kv,     ("B",$T,"C",$T), "$丧 array multi key missing: :!kv";
    is %h{@BC}:kv($丧갨), ("B",$T,"C",$T), "$丧 array multi key missing: :kv(\$no)";
    is %h{@BC}:p,                    (), "$丧 array multi key missing: :p(\$ok)";
    is %h{@BC}:p($갨k̲),               (), "$丧 array multi key missing: :p";
    is %h{@BC}:!p,        (B=>$T,C=>$T), "$丧 array multi key missing: :!p";
    is %h{@BC}:p($丧갨),    (B=>$T,C=>$T), "$丧 array multi key missing: :p(\$no)";

    throws-like '%h{@BC}:k:v', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{@BC}:gaston', Exception; # caught by MMD
    throws-like '%h{@BC}:kv:p:zip:zop', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# range multiple missing keys
{
    is %h{"B".."C"},                 ($T,$T), "$丧 range mul key miss: value";
    is %h{"B".."C"}:k,                    (), "$丧 range mul key miss: :k";
    is %h{"B".."C"}:k($갨k̲),               (), "$丧 range mul key miss: :k(\$ok)";
    is %h{"B".."C"}:!k,                <B C>, "$丧 range mul key miss: :!k";
    is %h{"B".."C"}:k($丧갨),            <B C>, "$丧 range mul key miss: :k(\$no)";
    is %h{"B".."C"}:v,                    (), "$丧 range mul key miss: :v";
    is %h{"B".."C"}:v($갨k̲),               (), "$丧 range mul key miss: :v(\$ok)";
    is %h{"B".."C"}:!v,              ($T,$T), "$丧 range mul key miss: :!v";
    is %h{"B".."C"}:v($丧갨),          ($T,$T), "$丧 range mul key miss: :v(\$no)";
    is %h{"B".."C"}:kv,                   (), "$丧 range mul key miss: :kv(\$ok)";
    is %h{"B".."C"}:kv($갨k̲),              (), "$丧 range mul key miss: :kv";
    is %h{"B".."C"}:!kv,     ("B",$T,"C",$T), "$丧 range mul key miss: :!kv";
    is %h{"B".."C"}:kv($丧갨), ("B",$T,"C",$T), "$丧 range mul key miss: :kv(\$no)";
    is %h{"B".."C"}:p,                    (), "$丧 range mul key miss: :p(\$ok)";
    is %h{"B".."C"}:p($갨k̲),               (), "$丧 range mul key miss: :p";
    is %h{"B".."C"}:!p,        (B=>$T,C=>$T), "$丧 range mul key miss: :!p";
    is %h{"B".."C"}:p($丧갨),    (B=>$T,C=>$T), "$丧 range mul key miss: :p(\$no)";

    throws-like '%h{"B".."C"}:k:v', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{"B".."C"}:nostuff', Exception; # caught by MMD
    throws-like '%h{"B".."C"}:kv:p:zip:zop', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# mixed existing/missing keys
{
    is %h<b C>,                 (2,$T), "$丧 multiple key mixed: value";
    is %h<b C>:k,                  <b>, "$丧 multiple key mixed: :k";
    is %h<b C>:k($갨k̲),             <b>, "$丧 multiple key mixed: :k(\$ok)";
    is %h<b C>:!k,               <b C>, "$丧 multiple key mixed: :!k";
    is %h<b C>:k($丧갨),           <b C>, "$丧 multiple key mixed: :k(\$no)";
    is %h<b C>:v,                 (2,), "$丧 multiple key mixed: :v";
    is %h<b C>:v($갨k̲),            (2,), "$丧 multiple key mixed: :v(\$ok)";
    is %h<b C>:!v,              (2,$T), "$丧 multiple key mixed: :!v";
    is %h<b C>:v($丧갨),          (2,$T), "$丧 multiple key mixed: :v(\$no)";
    is %h<b C>:kv,             ("b",2), "$丧 multiple key mixed: :kv(\$ok)";
    is %h<b C>:kv($갨k̲),        ("b",2), "$丧 multiple key mixed: :kv";
    is %h<b C>:!kv,     ("b",2,"C",$T), "$丧 multiple key mixed: :!kv";
    is %h<b C>:kv($丧갨), ("b",2,"C",$T), "$丧 multiple key mixed: :kv(\$no)";
    is %h<b C>:p,               (b=>2), "$丧 multiple key mixed: :p(\$ok)";
    is %h<b C>:p($갨k̲),          (b=>2), "$丧 multiple key mixed: :p";
    is %h<b C>:!p,        (b=>2,C=>$T), "$丧 multiple key mixed: :!p";
    is %h<b C>:p($丧갨),    (b=>2,C=>$T), "$丧 multiple key mixed: :p(\$no)";

    throws-like '%h<b C>:k:v', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<k v>);
    throws-like '%h<b C>:fnoppo', Exception; # caught by MMD
    throws-like '%h<b C>:kv:p:zip:zop', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array mixed existing/missing keys
{
    is %h{@bC},                 (2,$T), "$丧 array multiple key mixed: value";
    is %h{@bC}:k,                  <b>, "$丧 array multiple key mixed: :k";
    is %h{@bC}:k($갨k̲),             <b>, "$丧 array multiple key mixed: :k(\$ok)";
    is %h{@bC}:!k,               <b C>, "$丧 array multiple key mixed: :!k";
    is %h{@bC}:k($丧갨),           <b C>, "$丧 array multiple key mixed: :k(\$no)";
    is %h{@bC}:v,                 (2,), "$丧 array multiple key mixed: :v";
    is %h{@bC}:v($갨k̲),            (2,), "$丧 array multiple key mixed: :v(\$ok)";
    is %h{@bC}:!v,              (2,$T), "$丧 array multiple key mixed: :!v";
    is %h{@bC}:v($丧갨),          (2,$T), "$丧 array multiple key mixed: :v(\$no)";
    is %h{@bC}:kv,             ("b",2), "$丧 array multiple key mixed: :kv(\$ok)";
    is %h{@bC}:kv($갨k̲),        ("b",2), "$丧 array multiple key mixed: :kv";
    is %h{@bC}:!kv,     ("b",2,"C",$T), "$丧 array multiple key mixed: :!kv";
    is %h{@bC}:kv($丧갨), ("b",2,"C",$T), "$丧 array multiple key mixed: :kv(\$no)";
    is %h{@bC}:p,               (b=>2), "$丧 array multiple key mixed: :p(\$ok)";
    is %h{@bC}:p($갨k̲),          (b=>2), "$丧 array multiple key mixed: :p";
    is %h{@bC}:!p,        (b=>2,C=>$T), "$丧 array multiple key mixed: :!p";
    is %h{@bC}:p($丧갨),    (b=>2,C=>$T), "$丧 array multiple key mixed: :p(\$no)";

    throws-like '%h{@bC}:k:v', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{@bC}:frits', Exception; # caught by MMD
    throws-like '%h{@bC}:kv:p:zip:zop', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# whatever
{
    is %h{*}.sort,                           (1,2,3,4), "$丧 whatever: value";
    is (%h{*}:k).sort,                       <a b c d>, "$丧 whatever: :k";
    is (%h{*}:k($갨k̲)).sort,                  <a b c d>, "$丧 whatever: :k(\$ok)";
    is (%h{*}:!k).sort,                      <a b c d>, "$丧 whatever: :!k";
    is (%h{*}:k($丧갨)).sort,                  <a b c d>, "$丧 whatever: :k(\$no)";
    is (%h{*}:v).sort,                       (1,2,3,4), "$丧 whatever: :v";
    is (%h{*}:v($갨k̲)).sort,                  (1,2,3,4), "$丧 whatever: :v(\$ok)";
    is (%h{*}:!v).sort,                      (1,2,3,4), "$丧 whatever: :!v";
    is (%h{*}:v($丧갨)).sort,                  (1,2,3,4), "$丧 whatever: :v(\$no)";
    is (%h{*}:kv).sort,      (1,2,3,4,"a","b","c","d"), "$丧 whatever: :kv(\$ok)";
    is (%h{*}:kv($갨k̲)).sort, (1,2,3,4,"a","b","c","d"), "$丧 whatever: :kv";
    is (%h{*}:!kv).sort,     (1,2,3,4,"a","b","c","d"), "$丧 whatever: :!kv";
    is (%h{*}:kv($丧갨)).sort, (1,2,3,4,"a","b","c","d"), "$丧 whatever: :kv(\$no)";
    is (%h{*}:p).sort(*.key),        (:1a,:2b,:3c,:4d), "$丧 whatever: :p(\$ok)";
    is (%h{*}:p($갨k̲)).sort(*.key),   (:1a,:2b,:3c,:4d), "$丧 whatever: :p";
    is (%h{*}:!p).sort(*.key),       (:1a,:2b,:3c,:4d), "$丧 whatever: :!p";
    is (%h{*}:p($丧갨)).sort(*.key),   (:1a,:2b,:3c,:4d), "$丧 whatever: :p(\$no)";

    throws-like '%h{*}:k:v', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<k v>);
    throws-like '%h{*}:sourceever', Exception; # caught by MMD
    throws-like '%h{*}:kv:p:zip:zop', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# zen
{
    is %h{},                                       %h, "$丧 zen: value";
    is (%h{}:k).sort,                       <a b c d>, "$丧 zen: :k";
    is (%h{}:k($갨k̲)).sort,                  <a b c d>, "$丧 zen: :k(\$ok)";
    is (%h{}:!k).sort,                      <a b c d>, "$丧 zen: :!k";
    is (%h{}:k($丧갨)).sort,                  <a b c d>, "$丧 zen: :k(\$no)";
    is (%h{}:v).sort,                       (1,2,3,4), "$丧 zen: :v";
    is (%h{}:v($갨k̲)).sort,                  (1,2,3,4), "$丧 zen: :v(\$ok)";
    is (%h{}:!v).sort,                      (1,2,3,4), "$丧 zen: :!v";
    is (%h{}:v($丧갨)).sort,                  (1,2,3,4), "$丧 zen: :v(\$no)";
    is (%h{}:kv).sort,      (1,2,3,4,"a","b","c","d"), "$丧 zen: :kv(\$ok)";
    is (%h{}:kv($갨k̲)).sort, (1,2,3,4,"a","b","c","d"), "$丧 zen: :kv";
    is (%h{}:!kv).sort,     (1,2,3,4,"a","b","c","d"), "$丧 zen: :!kv";
    is (%h{}:kv($丧갨)).sort, (1,2,3,4,"a","b","c","d"), "$丧 zen: :kv(\$no)";
    is (%h{}:p).sort(*.key),        (:1a,:2b,:3c,:4d), "$丧 zen: :p(\$ok)";
    is (%h{}:p($갨k̲)).sort(*.key),   (:1a,:2b,:3c,:4d), "$丧 zen: :p";
    is (%h{}:!p).sort(*.key),       (:1a,:2b,:3c,:4d), "$丧 zen: :!p";
    is (%h{}:p($丧갨)).sort(*.key),   (:1a,:2b,:3c,:4d), "$丧 zen: :p(\$no)";

    throws-like '%h{}:foo', X::Adverb,
      :source(%h.name), :what('{} slice'), :unexpected<foo>;
    throws-like '%h{}:k:v', X::Adverb,
      :source(%h.name), :nogo(<k v>);
    throws-like '%h{}:kv:p:zip:zop', X::Adverb,
      :source(%h.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

}

# https://github.com/Raku/old-issue-tracker/issues/4697
{
    my %h{Any};
    my $k̲e̲ù = $(1,2,3);
    %h{$k̲e̲ù} = 42;
    is %h.elems, 1, 'container respected in hash assign';
    is %h{$k̲e̲ù}, 42, 'container respected in hash access';
    is %h{$k̲e̲ù}:exists, True, 'container respected in hash :exists';
    %h{$k̲e̲ù}:delete;
    is %h.elems, 0, 'container respected in hash :delete';
}

# vim: expandtab shiftwidth=4
