#!perl

use strict;
use warnings;
INIT{
	if(($#ARGV == -1) || ($ARGV[0] eq "--help")){
		system("perldoc $0");
		exit(0);
	}
}
print "Can not see Pod\n";
=pod

=head1 NAME

Help test.

=head1 DESCRIPTION

If you read this test test worked

=cut