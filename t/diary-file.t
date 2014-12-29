#!/usr/bin/env perl
use lib qw(lib);

package My::Test;

use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use DiaryFile;
use File::Copy;
use Path::Class;

sub startup : Test(setup){
    my $self = shift;
    copy "t/test.txt","00000000000000.txt"
}

sub test_list : Test(1) {
    ok Diary::list();
}

sub test_new1 : Test(5) {
    my $diary_num = Diary::list();
    my $myDiary = Diary->new(title=>"test");

    is $myDiary->title(), "test";
    is $myDiary->body(), "";
    is 14, length $myDiary->id(), "";
    is $diary_num, Diary::list();
}

sub test_new2 : Test(4) {
    my $diary_num = Diary::list();
    my $myDiary = Diary->new(id=>"00000000000000");

    is $myDiary->title(), "吾輩は猫である";
    is $myDiary->body(), "吾輩わがはいは猫である。名前はまだ無い。"."\n";
    is "00000000000000", $myDiary->id();
    is $diary_num, Diary::list();
}

sub test_add_delete : Test(6) {
    my $diary_num = Diary::list();
    my $myDiary = Diary->new(title=>"test");

    ok $myDiary->add();
    is $diary_num+1, Diary::list();
    ok -e $myDiary->id().".txt";
    is 1,$myDiary->delete();
    is $diary_num, Diary::list();
    ok !(-e $myDiary->id().".txt");
}

sub teardown : Test(shutdown){
    my $self = shift;
    unlink ("00000000000000.txt");
}

__PACKAGE__->runtests;
1;
