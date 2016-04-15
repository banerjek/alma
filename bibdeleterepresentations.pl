#!/usr/bin/perl

############################################################
# You will need an ExLibris developer's key to make the program
#
# This program deletes all digital representations associated 
# with an MMSID. Files on Amazon are automatically deleted 
# as part of this process.
#
# However, the MMSID itself is not deleted because the API does
# not permit that at the time this was created 
##############################################################

use strict;
use warnings;
use LWP::UserAgent;

########################################################################
# initialize a few variables. You'll need a developer's key from OCLC to
# make this work
########################################################################
open my $apikeyfile, '<', "apikey.txt";
my $apikey = <$apikeyfile>;
close $apikeyfile;

my $ua = LWP::UserAgent->new;
$ua->default_header('Authorization' => "apikey $apikey");
#$ua->default_header('Content-Type' => "application/xml");

######################################
# make sure line feeds delimit records
######################################
local $/ = undef;
$/ = "\n";

my $response = '';
my $url = '';
my $oclc = '';
my $baseurl = 'https://api-na.hosted.exlibrisgroup.com';
my $service = '/almaws/v1/bibs/';
my @mmsids = qw(99900099877801858 99900099877901858);
my $mmsid = '';
my @representations = [];
my $representation = '';
my $xmldata = '';
my $outputfile = 'out.txt';
my $representationurl = '';
my $deleteurl = '';


foreach $mmsid (@mmsids) {
	$url = $baseurl . $service . $mmsid; 
	$representationurl = $url . '/representations/';

	$response = $ua->get($representationurl);
	$xmldata = $response->content;
	
	@representations = $xmldata =~ m/<id>([0-9]+)<\/id>/g;
	
	foreach $representation(@representations) {
		# delete each representation
		$deleteurl = $representationurl . $representation;
		$response = $ua->delete($deleteurl);
		}
	}


