package Test::Intern::Diary::Mechanize;

use strict;
use warnings;
use utf8;

use parent qw(Test::WWW::Mechanize::PSGI);

use Test::More ();

use Exporter::Lite;
our @EXPORT = qw(create_mech);

use Intern::Diary;

sub create_mech (;%) {
    return __PACKAGE__->new(@_);
}

sub new {
    my ($class, %opts) = @_;

    my $self = $class->SUPER::new(
        app     => Intern::Diary->as_psgi,
        %opts,
    );

    return $self;
}

1;
