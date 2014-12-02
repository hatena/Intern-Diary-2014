package Intern::Diary::DBI::Factory;

use strict;
use warnings;
use utf8;

use Intern::Diary::Config;
use Carp ();

use Intern::Diary::DBI;

sub new {
    my ($class) = @_;
    return bless +{}, $class;
}

sub dbconfig {
    my ($self, $name) = @_;
    my $dbconfig = config->param('db') // Carp::croak 'required db setting';
    return $dbconfig->{$name} // Carp::croak qq(db config for '$name' does not exist);
}

sub dbh {
    my ($self, $name) = @_;

    my $db_config = $self->dbconfig($name);
    my $user      = $db_config->{user} or Carp::croak qq(user for '$name' does not exist);
    my $password  = $db_config->{password} or Carp::croak qq(password for '$name' does not exist);
    my $dsn       = $db_config->{dsn} or Carp::croak qq(dsn for '$name' does not exist);

    my $dbh = Intern::Diary::DBI->connect($dsn, $user, $password);
    return $dbh;
}

1;
