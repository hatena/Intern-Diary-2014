package Intern::Diary::Config;

use strict;
use warnings;
use utf8;

use Intern::Diary::Config::Route;

use Config::ENV 'INTERN_DIARY_ENV', export => 'config';
use Path::Class qw(file);

my $Router = Intern::Diary::Config::Route->make_router;
my $Root = file(__FILE__)->dir->parent->parent->parent->absolute;

sub router { $Router }
sub root { $Root }

common {
};

$ENV{SERVER_PORT} ||= 3000;
config default => {
    origin => "http://localhost:$ENV{SERVER_PORT}",
};

config production => {
};

config local => {
    parent('default'),
    db => {
        intern_diary => {
            user     => 'nobody',
            password => 'nobody',
            dsn      => "dbi:mysql:dbname=intern_diary_$ENV{USER};host=localhost",
        },
    },
    db_timezone => 'UTC',
};

config test => {
    parent('default'),

    db => {
        intern_diary => {
            user     => 'nobody',
            password => 'nobody',
            dsn      => "dbi:mysql:dbname=intern_diary_$ENV{USER}_test;host=localhost",
        },
    },
    db_timezone => 'UTC',
};

1;
