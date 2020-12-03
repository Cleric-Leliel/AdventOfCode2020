#!/usr/bin/perl -w   
#Advent of Code 2020
#Day 1: find expense matches
#v1.0  12-01-2020 
      
my $i=0;     #loop counter
my  %exphash = ();   #list of expense values (puzzle input)
my $sum = 2020;      #target for matching

#Build Hash
open (EXPFILE , "Day1input.txt") or die "Error reading Expenses file";
while (! eof(EXPFILE) ){
	$_ = readline(EXPFILE);
	chomp $_;
	my $k = $_;		      # input value becomes key
	my $v = 2020 - $k;    # its match becomes value      
	#print $k. ": " . $v . "\n";
	
	$exphash {$k}=$v;    #add it to hash
	
	#Does that value already exist as a key?? 
	if (exists($exphash{$v})) {
		print "$v and $exphash{$v}  are the pair\n";
		my $ans = $v * $exphash{$v};
		print "multiplied: $ans\n";
	}
	$i++;
}
close(EXPFILE);

print "lines read: " . $i;
	
