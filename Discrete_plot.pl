#!/usr/bin/perl
# **********************
# *  Discrete_plot.pl  *
# **********************
#
# usage: Discrete_plot.pl LABEL meta_file 
#
# Where:
# LABEL is a... label which will defined the output files.
# meta_file is a file similar to the input file of WHAM. Only the first column is read.
# There are two output files: LABEL.dat and LABEL.gnu ; The first will contain all the
# values whereas the other one is a script for getting an visualization.
#
# Florent Barbault October 2020
$| = 1;
use strict;
use Math::Trig;
#-----------------------------------------------------------------------------------------------------------------------------
# Get the input arguments and declarations
#
my $LABEL=$ARGV[0];
my $meta_file=$ARGV[1];
my $nb_tot_file=0;
my $nb_tot_line=0;
my $Fichier="";
my $data="";
my $script="";
my $image_distrib="";
my @t=();
my @tv=();
my @val=(),();
my $i=0;
my $f=0;
my $j=0;
my $end=0;
my $end_plus_one=0;
my $frame=0;
print "Usage: Discrete_plot.pl LABEL meta_file\n";
#-----------------------------------------------------------------------------------------------------------------------------
# Open the meta_file and get the data
#
{
	print "Open the meta file and get the data\n";
	$data=$LABEL.".dat";
	$script=$LABEL.".gnuplot";
	open (FILE_INPUT, "< $meta_file");
	while (<FILE_INPUT>)
	{
		@t = split(' ',$_);
		$Fichier=$t[0]; #print "\n Open $Fichier";
		$f=0;
		print ".";
		open(FILE, "<$Fichier");
		while (<FILE>)
		{
			@tv = split(' ',$_);
			$val[$i][$f]=$tv[1];
			$f=$f+1;
		}
		$i=$i+1;
		close(FILE);
	}
	$frame=$f;
	$end=$i;
	$end_plus_one=$end+1;
	close(FILE_INPUT);
	print "You have $end simulations of $frame frames \n";
}
#-----------------------------------------------------------------------------------------------------------------------------
# Create a complete data file
#
{
	open (FDATA, "> $data");
	print "Create a complete data file for plotting the dispersion\n";
	for ($f=0;$f<$frame;$f++)
	{
		print FDATA "\n $f ";
		for ($i=0;$i<$end;$i++)
		{
			print FDATA " $val[$i][$f]";
		}
	}
	close(FDATA);
	print "Data compilation completed\n";
}
#-----------------------------------------------------------------------------------------------------------------------------
# Images generation with gnuplot
#
{
	print "Image generation with gnuplot\n";
	open (FSCRIPT, "> $script");
	$image_distrib=$LABEL."-distribution.png";
	print FSCRIPT "unset key\n";
	print FSCRIPT "set title \"$LABEL Data distributions vs Frames\"\n";
	print FSCRIPT "set xlabel \"Frames X 1000\" \n";
	print FSCRIPT "set ylabel \"Reaction Coordinate\" \n";
	print FSCRIPT "set term png enhanced size 1000,1000 font \"arial,20\"\n";
	print FSCRIPT "set output \"$image_distrib\"\n";
	print FSCRIPT "plot for [i=2:$end_plus_one] \"$data\" using (\$1/1000):i with dots\n";
	close(FSCRIPT);
	system ("gnuplot < $script");
	print "Done, the file $image_distrib has been created\n";
	
}



