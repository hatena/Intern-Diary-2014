#!/Users/t/.plenv/shims/perl
use strict;
use warnings;
use lib qw(lib);
use DiaryFile;

sub main {


    my $cmd = $ARGV[0];


    if ($cmd eq "add"){
        my $title = $ARGV[1];
        if ($title){
            my $myDiary = new Diary(title=>$ARGV[1]);
            $myDiary->$cmd;
        }
    }elsif($cmd eq "list"){
        Diary::list()
    }elsif($cmd eq "delete"){
        my $id = $ARGV[1];
        chomp $id;
        if($id =~m/^[0-9]+$/){
            my $myDiary = new Diary(id=>$id);
            $myDiary->$cmd;
        }
    }elsif($cmd eq "edit"){
        my $id = $ARGV[1];
        chomp $id;
        if($id =~m/^[0-9]+$/){
            my $myDiary = new Diary(id=>$id);
            $myDiary->$cmd;
        }
    }
}

&main;exit;
