package t::Intern::Diary::DBI::Factory;

use strict;
use warnings;
use utf8;
use lib 't/lib';

use parent 'Test::Class';

use Test::More;

use Test::Intern::Diary;

use Intern::Diary::Util;

sub _use : Test(1) {
    use_ok 'Intern::Diary::Util';
}

__PACKAGE__->runtests;

1;
