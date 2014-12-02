package t::Intern::Diary::DBI;

use strict;
use warnings;
use utf8;
use lib 't/lib';

use parent 'Test::Class';

use Test::Intern::Diary;
use Test::More;

sub _use : Test(1) {
    use_ok 'Intern::Diary::DBI';
}

__PACKAGE__->runtests;

1;
