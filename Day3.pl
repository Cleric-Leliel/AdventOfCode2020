#!/usr/bin/perl -w   
#Advent of Code 2020
#Day 3: Dodge trees
#v1.0  12-03-2020 
      
my $i=0;     #line counter
my @mtn=();
my $ans = 1;

#Read in from file
open (EXPFILE , "Day3inputB.txt") or die "Error reading map file";
while (! eof(EXPFILE) ){
	$_ = readline(EXPFILE);
	#chomp $_;
	push(@mtn,$_);
	$i++;
}
close(EXPFILE);
#print @mtn;
print "lines read:  $i \n -----\n";

#Traverse - 
my @rt = (1,3,5,7,1);  # move right
my @dn = (1,1,1,1,2);     #move down
$i--;
my $j = 0;
foreach (@rt){
	print "$j: right $rt[$j] and down $dn[$j]\n";
	my $treec = 0;
	my $x= 0;   #position in row
	my $y=0;    #down 
	while ($y<=$#mtn){
		my @bob =();                #temp array's name is Bob. 
		push(@bob,split('',$mtn[$y]));
		print "$bob[$x] at $x, $y \n";
		if ($bob[$x] eq '#'){
			$treec++;
		}
		$x = $x+$_;
		if ($x>=$#bob){
			$x = $x - $#bob;
		}
		$y = $y + $dn[$j];   #incrementing 
	}
	$j++;

	print "$treec Trees hit!\n";
	$ans = $ans * $treec;
}
print "Answer: $ans\n";