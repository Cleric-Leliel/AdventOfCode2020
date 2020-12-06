#!/usr/bin/perl -w   
#Advent of Code 2020
#Day 1: find expense matches
#v1.0  12-01-2020 
      
use POSIX;   #mathy stuff	
use List::Util qw( min max );    #array max and min functions
	  
my $i=0;     #loop counter    
my @seatID =();  

open (EXPFILE , "Day5input.txt") or die "Error reading Expenses file";
while (! eof(EXPFILE) ){
	$_ = readline(EXPFILE);
	chomp $_;
	my $r1 = 0; 
	my $r2 =127; 
	my $c1 = 0;
	my  $c2 = 7;
	my @FBcode = split('',substr($_,0,7));
	my @LRcode = split('',substr($_,-3));
	print "$_ cut into @FBcode  @LRcode \n";
	foreach (@FBcode){
			if ($_ eq "F") { $r2 = $r2 - ceil(($r2-$r1) / 2);}    #mathy bits!
			elsif($_ eq "B" ){ $r1 = $r1 + ceil(($r2-$r1) / 2);}
			print "$_ narrowed to ($r1, $r2)  \n";
	}
		foreach (@LRcode){
			if ($_ eq "L") { $c2 = $c2 - ceil(($c2-$c1) / 2);}
			elsif($_ eq "R" ){ $c1 = $c1 + ceil(($c2-$c1) / 2);}
			print "$_ narrowed to ($c1, $c2)  \n";
	}
	print "Seat is row $r1 , col $c1.  $r2 $c2. Seat ID = ". ($r1* 8 + $c1)."\n"; 
	push(@seatID, $r1* 8 + $c1);
	$i++;
}

close(EXPFILE);

print "lines read: $i \n";
print "Highest Seat ID is ".max(@seatID). "\n";