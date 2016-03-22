#!/usr/bin/perl

############################################################
# You will need an ExLibris developer's key to make the program
#
# This program retrieves collecitions from Alma 
#
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
my $service = '/almaws/v1/bibs/collections';

my $outputfile = 'out.txt';

open (OUTFILE, '>:utf8',$outputfile);

$url = $baseurl . $service; 
$response = $ua->get($url);
print $url;
print OUTFILE $response->content;
close (OUTFILE);

