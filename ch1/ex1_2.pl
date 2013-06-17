#!perl
use strict;
use warnings;
use File::Find;
use Digest::MD5;

sub find_dups(@)
{
	my @dir_list = @_;
	
	if($#dir_list <0){
		return (undef);
	}
	my %files;
	find( sub {
		#print $File::Find::name,"\n";
		#print $size,"\n";
			-f &&
			push @{$files{(stat(_))[7]}},$File::Find::name
			
			},@dir_list
	);
	my @result = ();
	foreach my $size (keys %files){
		if ($#{$files{$size}} < 1){
			next;
		}
		
		my %md5;
		
		foreach my $cur_file (@{$files{$size}}){
			open(my $fh,$cur_file) or next;
			binmode($fh);
			my $ctx = Digest::MD5->new;
			$ctx->addfile($fh);
			my $digest = $ctx->hexdigest;
			push @{$md5{$digest}},$cur_file;
			close($fh);
		}
		foreach my $hash (keys %md5){
			if ($#{$md5{$hash}} >= 1){
				push(@result, [@{$md5{$hash}}]);
			}
		}
	}
	return @result;
}
my @dir_all =("d:\\project\\wcps","H:\\·Ç¹¤×÷\\ÒôÀÖ" );
#print "exit" if -d $dir_all[1];
my @dups = find_dups(@dir_all);
open( my $rh , "> d:\\music.log" ) or die "can not ";
foreach my $cur_dup(@dups){
	print $rh "Duplicate\n";
	foreach my $cur_file (@$cur_dup){
		print $rh "\t $cur_file\n";
	}
}
# two point 
# stat(_) 
# find ( FUN_REF,@dir_list)