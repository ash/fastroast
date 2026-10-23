use Test;
plan 2;

class W̲갢𝐝æe̲中 {
    has $.name;
    subset PosReal of Real where * >= 0;
    subset Size where {   .does(PosReal)
		       or .does(Callable) and .signature ~~ :(PosReal --> PosReal)
		       or .does(Whatever) or .does(WhateverCode) };

    has Size $.size is rw;
    has W̲갢𝐝æe̲中 @.sub-widgets;

    method compute-layout($remaining-space? is copy, $unspecified-size? is copy) {
        $remaining-space //= $!size;

        if @!sub-widgets == 0 {  # Terminal
            my $개갨ì𝐩갮中e̲𝐝-ò갢丳e̲ = do given $!size {
                when Real     { $_                  };
                when Callable { .($remaining-space) };
                when Whatever { $unspecified-size   };
            }

            self.draw($개갨ì𝐩갮中e̲𝐝-ò갢丳e̲);
        }
        else {  # Container
            my @ò中à中갢개-ò갢丳e̲ò   =  grep Real,     @!sub-widgets».size;
            my @𝐝ù丧àì갢개-ò갢丳e̲ò  =  grep Callable, @!sub-widgets».size;
            my $丧丛-갮丧ò𝐩e̲개갢е갢e̲𝐝 = +grep Whatever, @!sub-widgets».size;

            $remaining-space -= [+] @ò中à中갢개-ò갢丳e̲ò;

            $unspecified-size = ([-] $remaining-space, @𝐝ù丧àì갢개-ò갢丳e̲ò».($remaining-space).Slip)
                                 / $丧丛-갮丧ò𝐩e̲개갢е갢e̲𝐝;

            .compute-layout($remaining-space, $unspecified-size) for @!sub-widgets;
        }
    }

    method draw(Real $size is copy) {
        take "+{'-' x 25}+";
        take "$!name ($size lines)".fmt("| %-23s |");
        take "|{' ' x 25}|" while --$size > 0;
    }
}

my $갢丧中e̲сеà개e̲ =
    W̲갢𝐝æe̲中.new(name => 'interface', size => 11, sub-widgets => (
        W̲갢𝐝æe̲中.new(name => 'menu bar', size => 1),
        W̲갢𝐝æe̲中.new(name => 'main part', size => *, sub-widgets => (
            W̲갢𝐝æe̲中.new(name => 'subpart 1', size => * / 3),
            W̲갢𝐝æe̲中.new(name => 'subpart 2', size => *))),
        W̲갢𝐝æe̲中.new(name => 'status bar', size => 1)));

my @𝐝сàw̲갢丧æ = gather { $갢丧中e̲сеà개e̲.compute-layout; }; # Draw
is-deeply @𝐝сàw̲갢丧æ, [q:to"END_LAYOUT_1".lines], 'initial layout';
+-------------------------+
| menu bar (1 lines)      |
+-------------------------+
| subpart 1 (3 lines)     |
|                         |
|                         |
+-------------------------+
| subpart 2 (6 lines)     |
|                         |
|                         |
|                         |
|                         |
|                         |
+-------------------------+
| status bar (1 lines)    |
END_LAYOUT_1

$갢丧中e̲сеà개e̲.size += 3;       # Resize
@𝐝сàw̲갢丧æ = gather { $갢丧中e̲сеà개e̲.compute-layout }; # Redraw
is-deeply @𝐝сàw̲갢丧æ, [q:to"END_LAYOUT_2".lines], 'resized layout';
+-------------------------+
| menu bar (1 lines)      |
+-------------------------+
| subpart 1 (4 lines)     |
|                         |
|                         |
|                         |
+-------------------------+
| subpart 2 (8 lines)     |
|                         |
|                         |
|                         |
|                         |
|                         |
|                         |
|                         |
+-------------------------+
| status bar (1 lines)    |
END_LAYOUT_2

# vim: expandtab shiftwidth=4
