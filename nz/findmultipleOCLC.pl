#!/usr/bin/perl

# This program expects a textual file from MarcEdit. 
#
# It normalizes all OCLC numbes from 035 |a and outputs
# a file containing all OCLC numbers associated with multiple
# MMSIDs

use strict;

my $infile = 'nz_oclc.txt';

my $entry = '';
my $mmsid = '';
my $oclc = '';
my $goodrecord = 1;
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
				if ("=001" eq substr $entry, 0, 4) {
				
				if ($entry =~ /CKB/) {
					$goodrecord = 0;
					}

				#### get MMSID

								#### delete previous entry if CKB record
								if (exists($oclcnos{$mmsid})) {
									if ($goodrecord == 0) {
										delete $oclcnos{$mmsid};
									}

								}
								$oclc = '';
								$goodrecord = 1;
								$mmsid = substr $entry, 6;
								$mmsid =~ s/[^0-9]//g;
				}

				#### Only compare if not a CKB record


				#### get OCLC
				if ($goodrecord == 1) {
					if ('=035  \\\\$a' eq substr $entry, 0, 10) {
								$oclc = substr $entry, 10;

								###### make sure field is OCLC number

								if ($oclc =~ /^(on|ocm|ocn|\(OCoLC)/) {
									####### strip unnecessary subfields
									$subfieldindex = index($oclc, '$');
	
									if ($subfieldindex > 0) {
										$oclc = substr $oclc, 0, $subfieldindex;
									}
									
									###### normalize OCLC number
									$oclc =~ s/[^0-9]//g;
									$oclc =~ s/^0*//g;
	
									###### load MMSID's into hash
									if (exists $oclcnos{$mmsid}) {
										##### make sure it hasn't recorded a normalized
										##### entry from the same record
										$mmsidindex = index($oclcnos{$mmsid}, $oclc);
	
										if ($mmsidindex == -1) {
											$oclcnos{$mmsid} .= ",$oclc";
											}
										} else {
												$oclcnos{$mmsid} = $oclc;
										}
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
