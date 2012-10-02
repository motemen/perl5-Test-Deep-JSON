use strict;
use warnings;
use Test::Tester;
use Test::More tests => 5;
use Test::Deep;
use Test::Deep::JSON;

cmp_deeply {
    foo => 'bar',
    json => '{"a":1}',
}, {
    foo => 'bar',
    json => json({ a => ignore() })
};

cmp_deeply {
    foo => 'bar',
    json => '{"a":1}',
}, superhashof {
    json => json({ a => 1 })
};

subtest 'JSON cmp failure (expect raw hash)' => sub {
    check_test sub {
        cmp_deeply {
            json => '{"a":1}',
        }, {
            json => json({ a => 2 })
        }
    }, {
        ok => 0,
        diag => <<'__DIAG__'
Compared $data->{"json"}->{"a"}
   got : '1'
expect : '2'
__DIAG__
    };
};

subtest 'JSON cmp failure (expect Test::Deep object)' => sub {
    check_test sub {
        cmp_deeply {
            json => '{"a":1}',
        }, {
            json => json(superhashof { x => ignore() })
        };
    }, {
        ok => 0,
        diag => <<'__DIAG__'
Comparing hash keys of $data->{"json"}
Missing: 'x'
__DIAG__
    };
};

subtest 'JSON parse error' => sub {
    check_test sub {
        cmp_deeply {
            json => '{ invalid json }',
        }, {
            json => json({ a => ignore() })
        };
    }, {
        ok => 0,
    };
};
