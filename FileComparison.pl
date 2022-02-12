#!/usr/bin/perl
use warnings;
use Data::Dumper qw(Dumper);

#prints Explanation  
print("Hello World\nThis perl script compares and outputs the similarities of 2 files\n");

#puts commandline arguments in variables
my ($file1_name,$file2_name) = @ARGV;

#checks that it recived two arguments 
if (not defined $file2_name) {
  die "Needs 2 files please\n";
}

#checks that arguments actually relate to real files and opens them
open my $file1Handler, '<',$file1_name
    or die "Can not open file1: $_";

open my $file2Handler, '<',$file2_name
    or die "Can not open file2: $_";


my @common; #array stores lines in common
my $simCounter = 0; # stores the number of line matches found

###gets a count of lines in file2
my $lineCounter =0; #variable to store

#increment for every line read in file 2
for ($count=0; <$file2Handler>; $count++) { $lineCounter =$count;}
$lineCounter +=1; #for loop doesn't incrememnt after reading last filem corrects that off-by-1 error

seek $file2Handler, 0, 0;#returns the file2 line pointer to the beginning of the file

#for every every line in file1 check if it appears in file2 (sepperatae instances count seperatly)
while(my $file1Row = <$file1Handler>){
    while(my $file2Row = <$file2Handler>){

        #if the line is found in both then save to the common array and incrememnt simCounter
        if ($file2Row eq $file1Row){
            push(@common, $file1Row);
            $simCounter +=1;
        }
    }
    seek $file2Handler, 0, 0;#returns the file2 line pointer to the beginning of the file
}

#print($simCounter,"\n",$lineCounter,"\n");
my $percent = ($simCounter/$lineCounter)*100; # percentage which represents how much of file2 was found in file1 
printf("$percent percent of the file2 was found in file 1\nLine matches found: ");
print Dumper \@common;