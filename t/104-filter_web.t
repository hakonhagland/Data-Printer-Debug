use strict;
use warnings;
use Test::More tests => 1;
use Data::Printer::Object;

test_json();
exit;


sub test_json {
    my $json = '{"alpha":true,"bravo":false,"charlie":true,"delta":false}';
    my $expected = '{ alpha:true, bravo:false, charlie:true, delta:false }';
    test_json_pp($json, $expected);
}


sub test_json_pp {
    my ($json, $expected) = @_;
    SKIP: {
        my $error = !eval { require JSON::PP; 1 };
        skip 'JSON::PP not available', 1 if $error;

        my $ddp = Data::Printer::Object->new(
            colored   => 0,
            multiline => 0,
            filters   => ['Web'],
        );
        diag "::: ", $JSON::PP::VERSION;
        my $fn = $INC{'JSON/PP.pm'};
        diag "::: ", $fn;
        #system 'cat ' . $fn . ' | head -30 1>&2';
        my $data = JSON::PP::decode_json($json);
        is( $ddp->parse($data), $expected, 'JSON::PP booleans parsed' );
    };
}

