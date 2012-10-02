package Test::Deep::JSON;
use strict;
use warnings;
use 5.008_001;
use Test::Deep ();
use Test::Deep::Cmp;
use JSON;
use Exporter::Lite;

our $VERSION = '0.01';

our @EXPORT = qw(json);

sub json ($) {
    my ($expected) = @_;
    return __PACKAGE__->new($expected);
}

sub init {
    my ($self, $expected) = @_;
    $self->{val} = $expected;
}

sub descend {
    my ($self, $got) = @_;
    my $parsed = eval { decode_json($got) };
    if ($@) {
        $self->{error} = $@;
        return 0;
    }
    Test::Deep::wrap($self->{val})->descend($parsed);
}

sub diagnostics {
    my $self = shift;
    return $self->{error};
}

1;

__END__

=head1 NAME

Test::Deep::JSON - 

=head1 SYNOPSIS

  use Test::Deep::JSON;

=head1 DESCRIPTION

=head1 AUTHOR

motemen E<lt>motemen@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
