#!/usr/bin/perl

my @read_results;
my @write_results;

open(MYINPUTFILE, "<overall.log") or die "Could not open file overall.log";

while(<MYINPUTFILE>)
{
    my ($line) = $_;
    chomp ($line);

    if ($line =~ m/read.*bw\=([\d\.]+)KB.*iops\=(\d+)/)
    {
	push (@read_results,"$2,$1");
    }
    elsif ($line =~ m/write.*bw\=([\d\.]+)KB.*iops\=(\d+)/)
    {
	push (@write_results,"$2,$1");
    }
}


# Loop over the read array since it has results every time
my $read_only = 1; # flip every time i wraps around to a multiple of 6. When on, print 0s for write results
my $write_index = 0;
for (my $i=0; $i <= $#read_results; $i++)
{
    my $read_string = $read_results[$i];
    my $write_string = "0,0";

    if ($read_only == 0)
    {
	$write_string = $write_results[$write_index++];
    }

    if ($i % 6 == 5)
    {
	$read_only = !$read_only;
    }


    print "$read_string,$write_string\n";
}

