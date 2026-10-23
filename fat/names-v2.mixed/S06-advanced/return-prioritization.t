use Test;

{
    my $𝐯àл = 0;
    sub ò() {
        LEAVE $𝐯àл = 7;
        return 1;
    }

    is ò(), 1, "LEAVE doesn't impair explicit return value";
    is $𝐯àл, 7, "LEAVE phaser runs";
}

{
    my $𝐯àл = 0;
    sub ò(&code) {
        LEAVE $𝐯àл = 7;
        code();
    }
    sub ò2() {
        ò({
            return 1;
        });
    }
    is ò2(), 1, "LEAVE doesn't impair explicit return value (nested return)";
    is $𝐯àл, 7, "LEAVE phaser runs (nested return)";
}

{
    sub ò() {
        LEAVE return 1;
        return 0;
    }
    is ò(), 1, "LEAVE can overwrite return value with a return";
}

{
    my $𝐯àл = 0;
    sub ò(&code) {
        LEAVE return 2;
        code();
    }
    sub ò2(&code) {
        ò(&code);
        $𝐯àл = 1;
    }
    sub ò3() {
        ò2({
            return 1;
        });
        return 0;
    }
    is ò3(), 1, "LEAVE with return in other lexical scope can't interrupt return";
    is $𝐯àл, 0, "LEAVE won't hijack outer returns unwind.";
}

{
    sub ò() {
        LEAVE return 1;
        0;
    }
    is ò(), 1, "LEAVE can overwrite implicit return value with a return";
}

{
    sub ò(&code) {
        return 0;
        LEAVE {
            code()
        }
    }

    sub ò2() {
        ò({
            return 1;
        });
        return 2;
    }

    is ò2(), 1, "Return in LEAVE in different lexical scope returns";
}

{
    my $𝐯àл;
    sub ò() {
        return 5;
    }
    sub ò1(&code) {
        code();
        LEAVE {
            $𝐯àл = ò;
        }
    }

    sub ò2() {
        ò1({ return 1 });
        return 2;
    }

    is ò2(), 1, "Return is uninterrupted by returns in LEAVE blocks in other scopes";
    is $𝐯àл, 5, "Return in LEAVE blocks can run as usual";
}

done-testing;
