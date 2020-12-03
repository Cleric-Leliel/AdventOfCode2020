#!/usr/bin/perl -w   
#Advent of Code 2020
#Day 2: verify passwords given rule
#v1.0  12-02-2020 
      
#WHY DOES THE PASSWORD FILE EXIST IN PLAIN TEXT?
#WHY WAS IT HANDED OVER TO A RANDOM CUSTOMER?
# I HAVE QUESTIONS...

my $i=0;     #line counter
my $valid=0;  # Num of valid pwds
my $invalid=0;

#Read in from file
open (EXPFILE , "Day2input.txt") or die "Error reading Expenses file";
while (! eof(EXPFILE) ){
	$_ = readline(EXPFILE);
	chomp $_;
	my @line  = split(/[:,\s-]+/, $_);
	my $rmin = $line[0];
	my $rmax = $line[1];
	chomp($rmin);
	chomp($rmax);
	my $c = $line[2];
	chomp($c);
	my @pwd = split('',$line[3]);
	my $flg=0;
	
	if ($pwd[$rmin-1] eq $c ){ 
		$flg++;						#one condition satisfied
	}
	if ($pwd[$rmax-1] eq $c ){ 
		$flg++;						#one condition satisfied
	}
	if  ($flg == 1 ){			    #must be 1. Not 0 (no matches) not 2 (2 matches)
		print "VALID: ";
		$valid++;
	} else {
		$invalid++;
	}
	
	print "@pwd has char $c  at position $rmin or $rmax  with Flag = $flg\n";
	$i++;
}
close(EXPFILE);

print "lines read:  $i \n";
print "Invalid: $invalid \n";
print "Valid: $valid \n";
