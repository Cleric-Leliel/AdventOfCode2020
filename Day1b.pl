#!/usr/bin/perl -w   
#Advent of Code 2020
#Day 1: find expense matches
#v1.0  12-01-2020 
      
my $i=0;     #loop counter
my  @exparray = ();   #list of expense values (puzzle input)
my $sum = 2020;      #target for matching

#Build Array
open (EXPFILE , "Day1input.txt") or die "Error reading Expenses file";
BREAKABLE: {				#its a damn goto like they told us for years not to use. 
while (! eof(EXPFILE) ){
	$_ = readline(EXPFILE);
	chomp $_;
	my $k = $_;		      # input value becomes key

	#Search hash so far
	if ($i < 3) {
		push(@exparray, $k);         #add it to array
		$i++;
	}else {
		foreach (@exparray) {
			my $v1 = $_;
			if ($v1 + $k < 2020) {
				foreach (@exparray){
					my $v2 = $_;
					if ($v2 + $v1 +$k == 2020){
						print "$k + $v1 +$v2 are the values\n";
						my $ans = $k * $v1 * $v2;
						print "$ans is their product.\n";
						last BREAKABLE;  # GOTO  END
					}
					
				}
			}
		}
		push(@exparray, $k);          #add it to array
		$i++;
	}
}
}
close(EXPFILE);

print "lines read: " . $i;
	
