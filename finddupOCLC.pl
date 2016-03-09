#!/usr/bin/perl

# This program expects a textual file from MarcEdit. For efficiency
# it is recommended to run the file through 'grep "^=001\|^=035.*\$a" filename'
# before using this script
#
# It normalizes all OCLC numbes from 035 |a and outputs
# a file containing all OCLC numbers associated with multiple
# MMSIDs

use strict;

my $infile = '/media/sf_Desktop/test/junk.mrk';

my @nzdata;
my $entry = '';
my $mmsid = '';
my $oclc = '';
my $subfieldindex = '';
my $mmsidindex = '';

local $/ = undef;
$/ = "\n";

############################
# Hash to store OCLC numbers
############################

my %oclcnos = ();

open(NZDATA, '<:encoding(UTF-8)', $infile) or die "Could not open file '$infile' $!";

while ($entry = <NZDATA>) {
				chomp($entry);

				#### get MMSID
				if ("=001" eq substr $entry, 0, 4) {
								$oclc = '';
								$mmsid = substr $entry, 6;
								$mmsid =~ s/[^0-9]//g;
				}
				#### get OCLC
				if ('=035  \\\\$a' eq substr $entry, 0, 10) {
								$oclc = substr $entry, 10;

								###### make sure field is OCLC number

								if ($oclc =~ /^(on|ocm|ocn|\(OCoLC)/) {
									####### strip unnecessary subfields
									$subfieldindex = index($oclc, '$');

								
									####### strip unnecessary subfields
									$subfieldindex = index($oclc, '$');
	
									if ($subfieldindex > 0) {
										$oclc = substr $oclc, 0, $subfieldindex;
									}
									
									###### normalize OCLC number
									$oclc =~ s/[^0-9]//g;
	
									###### load MMSID's into hash
									if (exists $oclcnos{$oclc}) {
										##### make sure it hasn't recorded a normalized
										##### entry from the same record
										$mmsidindex = index($oclcnos{$oclc}, $mmsid);
	
										if ($mmsidindex == -1) {
											$oclcnos{$oclc} .= ",$mmsid";
											}
									} else {
									$oclcnos{$oclc} = $mmsid;
						}
					}				
				}
		}

	close(NZDATA);

	##### iterate through keys with more than one entry
	
	keys %oclcnos;

	while(my($key, $value) = each %oclcnos) {
		$mmsidindex = index($value, ',');

		if ($mmsidindex > -1) {
			print "$key\t$value\n";
		}
	}
