#!/usr/bin/perl -w   
#Advent of Code 2020
#Day 4: verify passports given rule
#v1.0  12-04-2020 
      
use Switch;  #cpan Switch

my $i=0;     #line counter
my $j = 1;  # passports counter
my $valid=0;  # Num of valid passports
#my $invalid=0; # Num of invalid passports
my %passport = ();


#Validation
sub validate_passport {
	my @chkfld = ("byr","iyr","eyr","hgt","hcl","ecl","pid") ; #There is no CID, only ZUUL.
	my ($passhash) = @_;
	my $fieldc = 0;
	my $validity = 0;

	foreach (@chkfld){
		if (exists($passhash->{$_})){
			$fieldc++;
			#print "PASSPORT $j: $_ : ".$passhash->{$_} ."  #fields = $fieldc \n";
			switch($_){
				case "byr"  { if (($passhash->{$_} <1920) or ($passhash->{$_} >2002)){print "$j:bad byr $passhash->{$_}\n";return(0);}		}
				case "iyr"  { if (($passhash->{$_} <2010) or ($passhash->{$_} >2020)){print "$j:bad iyr $passhash->{$_}\n";return(0);}		}
				case "eyr"  { if (($passhash->{$_} <2020) or ($passhash->{$_} >2030)){print "$j:bad eyr $passhash->{$_}\n";return(0);}		}
				case "hgt"  {   # 4'11"  min?! Elves can't get passports?!  PREPARE FOR THE ELVEN REVOLT!
					my $units = substr($passhash->{$_}, -2);
					my $ht = $passhash->{$_};
					$ht =~ s/\D//g;  #remove non-digits 
					if ($units eq "cm" and (($ht <150) or ($ht >193))){ print "$j:bad height $passhash->{$_}\n"; return(0);} 
					elsif ($units eq "in" and (($ht <59) or ($ht >76))){print "$j:bad height $passhash->{$_}\n";return(0);}
					elsif ($units ne "in" and $units ne "cm"){print "$j:bad ht-nounit $passhash->{$_}\n";return(0);}   #THIS. THIS WAS THE CONDITION I WAS MISSING. >.<
					#else {print "$j:good hgt $passhash->{$_}\n";}
				} 
				case "hcl" {    #Who is sitting in the DMV matching people's hair color to hex code?? 
					my $hcl = $passhash->{$_};
					#print "HCL: $hcl ".substr($hcl,0,1)." " . length($hcl) ."\n";
					if(length($hcl) != 7){print "$j:bad hcl $passhash->{$_}\n";return(0);}
					elsif($hcl !~ m/^(#)[0-9a-f]/i ){print "$j:bad hcl $passhash->{$_}\n";return(0);}
					#else {print "$j:good hcl $passhash->{$_}\n";}												
				}
				case "ecl" {
					my @eclopts = ("amb", "blu", "brn", "gry", "grn", "hzl","oth");
					my $ecl = $passhash->{$_};
					my $eclgood = 0;   #flag
					foreach my $k (@eclopts){
						if ($ecl eq $k){    #find in list
							$eclgood = 1;
						}
					}
					if ($eclgood == 0){print "$j: bad ecl $ecl\n"; return(0);} 
					#else {print "$j:good ecl $passhash->{$_}\n";}
				}
				case "pid"{ 
					if(length($passhash->{$_}) != 9){print "$j:bad pid $passhash->{$_}\n";return(0);}# else {
					elsif($passhash->{$_} !~ m/[0-9]/i ){print "$j:bad pid $passhash->{$_}\n";return(0);}
					#else {print "$j:good pid $passhash->{$_}\n";}
				}
			}
		}	
	} 
		
	if ($fieldc == 7){    #Other bad conditions already returned a 0. And if we counted hash keys we'd pick up cid. 
		$validity = 1;    
		#$valid++;
	} 
	#print "\n";

	return $validity;
}
#Read in from file
open (PORTFILE , "Day4input.txt") or die "Error reading passports file";
while (! eof(PORTFILE) ){
	$_ = readline(PORTFILE);
	chomp $_;
	#Load ~ combine multiline data into a passport until a break is reached, then verify and reset for next passport
	if ($_ eq ""){
		$valid = $valid + validate_passport(\%passport);    #can't pass hash directly - use reference
		#print validate_passport(\%passport);
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
$valid = $valid + validate_passport(\%passport);

close(PORTFILE);

print "lines read:  $i \n";
print "Passports: $j\n";
#print "Invalid: $invalid \n";
print "Valid: $valid \n";