#!/usr/bin/perl -w   
#Advent of Code 2020
#Day 4: verify passports given rule
#v1.0  12-04-2020 
      

my $i=0;     #line counter
my $j = 1;  # passports counter
my $valid=0;  # Num of valid passports
my $invalid=0; # Num of invalid passports
my %passport = ();
my @chkfld = ("byr","iyr","eyr","hgt","hcl","ecl","pid") ; #There is no CID, only ZUUL.


#Read in from file
open (PORTFILE , "Day4input_test.txt") or die "Error reading passports file\n";
while (! eof(PORTFILE) ){  
	$_ = readline(PORTFILE);
	chomp $_;
	#Load ~ combine multiline data into a passport until a break is reached, then verify and reset for next passport
	if ($_ eq ""){      
		#Check for validity
		my $fieldc = 0;
		foreach (@chkfld){
			if (exists($passport{$_})){
				$fieldc++;
				print "PASSPORT $j: $_ : $passport{$_} \n";
		} }
		print "\n";
		if ($fieldc == 7){
			$valid++;
		} else {
			$invalid++;
		}
		%passport = (); #reset for new passport
		$j++;
	}else {     #build passport hash
		my @line  = split(/[,:\s]+/, $_);
		my $y=0;  
		while ($y<=$#line){
			my $k = $line[$y];
			my $v = $line[$y+1];
			$passport {$k}=$v;    #add it to hash
			#print "Passport $j : $k = $v\n";
			$y++;     #skip value
			$y++;	  #next key
			}		
	}
	$i++;
}

#Last one   
		#Check for validity
		my $fieldc = 0;
		foreach (@chkfld){
			if (exists($passport{$_})){
				$fieldc++;
				print "PASSPORT $j: $_ : $passport{$_} \n";
		} }
		print "\n";
		if ($fieldc == 7){
			$valid++;
		} else {
			$invalid++;
		}
		print "\n";

close(PORTFILE);

print "lines read:  $i \n";
print "Passports: $j\n";
print "Invalid: $invalid \n";
print "Valid: $valid \n";