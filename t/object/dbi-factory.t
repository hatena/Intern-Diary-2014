package t::Intern::Diary::DBI::Factory;
use strict;
use warnings;
use utf8;

use lib 't/lib';

use parent 'Test::Class';

use Test::More;

use Test::Intern::Diary;

use Intern::Diary::DBI::Factory;

sub _use : Test(1) {
    use_ok 'Intern::Diary::DBI::Factory';
}

sub _dbconfig : Test(3) {
    my $dbfactory = Intern::Diary::DBI::Factory->new;
    my $db_config = $dbfactory->dbconfig('intern_diary');
    is $db_config->{user}, 'nobody';
    is $db_config->{password}, 'nobody';
    is $db_config->{dsn}, "dbi:mysql:dbname=intern_diary_$ENV{USER}_test;host=localhost";
}

sub _dbh : Test(1) {
    my $dbfactory = Intern::Diary::DBI::Factory->new;
    my $dbh = $dbfactory->dbh('intern_diary');
    ok $dbh;

}

__PACKAGE__->runtests;

1;
