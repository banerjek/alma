#!/usr/bin/perl
use strict;
use warnings;

my $holdingsdir = 'holdings';
local $/ = undef;
$/ = "\n";
#
my @record = [];

sub processRecord {
	my ($oclc) = @_;
	my $mmsid = '';
	my $holding_institutions = '';
	my $numholdings = 0;
	my $institution = '';
	my $local_mmsid = '';
	my $p_and_e = 'no';
	my $entry = '';
	my $rectype = 'P';
	my $found_p = 0;
	my $found_e = 0;
	my $holdings_type = '';
	my $found_GPO = 0;
	my $ckb = 'no';
	my $number_of_institutions = 0;
	
	## detect mmsid
	for my $counter (0 .. $#record) {
		$entry = $record[$counter];

		if ($entry =~ /\(CKB\)/) {
			$ckb = 'yes';
			}

		if ($entry =~ />GPO</) {
			$found_GPO = 1;
			}

		if ($entry =~/<controlfield tag="001">([0-9]+)</) {
			$mmsid = $1;
			}
		if ($entry =~/<controlfield tag="006">m/) {
			$rectype = 'E';
			}
		## extract holdings
		if ($entry =~/<datafield tag="852"/) {
			$numholdings++;
			$institution = $record[$counter + 1];
			$institution =~ s/.*<subfield code="a">01ALLIANCE_([^<]*)<.*$/$1/;
			$local_mmsid = $record[$counter + 2];
			$local_mmsid =~ s/.*<subfield code="6">([0-9]+)<.*$/ ($1)/;
			$holding_institutions .= "$institution $local_mmsid, ";

			## Look for print and electronic holdings
			$holdings_type = $record[$counter + 3];
			
			if ($holdings_type =~ />P</) {
				$found_p = 1;
				}
			if ($holdings_type =~ />E</) {
				$found_e = 1;
				}
			}
		}
	
	if (length($holding_institutions) > 3) {
		$holding_institutions =~ s/, $//;
		}
	if ($found_p == 1 && $found_e == 1 && $found_GPO == 0) {
		$p_and_e = 'yes';
		}
	print "$oclc\t$mmsid\t$ckb\t$numholdings\t$holding_institutions\n";
	}

sub processFile {
	my ($oclc) = @_;
	my $infile = "holdings/$oclc";
	my $line = '';
	my $counter = 0;
	my $processrecord = 0;
	
	$oclc = substr $oclc, 0, length($oclc) - 4;

	my $outfile = "reports/$oclc.csv";

	open(INFILE, '<:encoding(UTF-8)', $infile) or die "Could not open file '$infile' $!";

	while ($line = <INFILE>) {
		chomp($line);

		if ($line =~ /<record xmlns="">/) {
			@record = [];
			$processrecord = 1;
			}

		if ($processrecord == 1) {
			push @record, $line;

			if ($line =~ /<\/record>/) {
				$processrecord = 0;
				processRecord($oclc);
				}
			}
		
		}
	close(INFILE);
	}

#################################
# Delete existing files in report
# directory
#################################

unlink glob "'reports/*.*'";

##############################
# iterate through each file in 
# holdings directory
##############################
opendir(DIR, $holdingsdir);

while (my $file = readdir(DIR)) {
	chomp($file);
	# only read *.xml files
	next if ($file !~ m/\.xml$/);

	processFile($file);
	}

closedir(DIR);
