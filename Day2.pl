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
	my $pwd = $line[3];
	
    #count target chars in password string
	my @count1 = $pwd =~ /$c/g;
	my $count = @count1;

    if (($count >= $rmin) and ($count <= $rmax)) {
			$valid++; 
			print "VALID: ";
	}
	else {
			$invalid++;
	}
	print "There are $count \'$c' characters in $rmin-$rmax $c : $pwd  \n";

	$i++;
}
close(EXPFILE);

print "lines read:  $i \n";
print "Invalid: $invalid \n";
print "Valid: $valid \n";
