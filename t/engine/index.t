package t::Intern::Diary::Engine::Index;

use strict;
use warnings;
use utf8;
use lib 't/lib';

use parent 'Test::Class';

use Test::Intern::Diary;
use Test::Intern::Diary::Mechanize;

sub _get : Test(3) {
    my $mech = create_mech;
    $mech->get_ok('/');
    $mech->title_is('Intern::Diary');
    $mech->content_contains('Intern::Diary');
}

__PACKAGE__->runtests;

1;
