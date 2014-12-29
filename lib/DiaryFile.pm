package Diary;

use strict;
use warnings;
use utf8;
use Encode;
use Mouse;
use Path::Class;

has title => (is => "rw",default=>"");
has body => (is => "rw",default=>"");
has id => (is => "rw",default=>_id());

sub BUILD {
    my $self = shift;
    if ($self->_exist_file()){
        my $file = file $self->id().".txt";
        my $reader = $file->openr;
        my @lines =$reader->getlines;
        my $title = $lines[0];
        chomp $title;
        $self->title($title);
        my $body ="";
        for(1 .. $#lines){
            $body = $body.$lines[$_];
        }
        $self->body($body);
        $reader->close;
        return;
    }
}

sub add {
    my ($self) = @_;
    my $file = file($self->id().".txt");
    my $writer = $file->open('w') or die $!;
    $writer->print($self->title()."\n");
    $writer->close;
}

sub delete {
    my ($self) = @_;
    return unlink ($self->id().".txt");
}

sub list{
    my @file_list = dir()->children;
    my $diary_num = 0;
    for (@file_list){
        if($_->relative =~ m/^[0-9]{14}/){
            $diary_num += 1;
            my $id = $&;
            my $myDiary = new Diary(id=>$id);
            $myDiary->_show();
        }
    }
    return $diary_num;
}

sub edit{
    my ($self) = @_;
    my $file = file($self->id().".txt");
    my $writer = $file->open('w') or die $!;
    $writer->print($self->title()."\n");
    $writer->print(<STDIN>);
    $writer->close;
}

sub _id{
    my ($sec,$min,$hour,$mday,$mon,$year) = localtime(time);
    $year += 1900;
    $mon +=1;
    $mon = sprintf("%02d",$mon);
    $mday = sprintf("%02d",$mday);
    $hour = sprintf("%02d",$hour);
    $min = sprintf("%02d",$min);
    $sec = sprintf("%02d",$sec);
    return "$year$mon$mday$hour$min$sec"+0;
}

sub _exist_file{
    my ($self) = @_;
    my @diary_list = dir()->children;
    for (@diary_list){
        if($_->relative eq $self->id().".txt"){
            return 1;
        }
    }
    return 0;
}
sub _show{
    my ($self) = @_;
    my $format_body = $self->body();
    $format_body =~ s/\n//g;
    print $self->id()."\t".$self->title()."\t".$format_body."\n";
}

1;
