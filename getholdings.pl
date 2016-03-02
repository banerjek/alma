#!/usr/bin/perl

############################################################
# You will need an ExLibris developer's key to make the program
#
# This program reads a bib record and takes actions
#
# When sending XML as an input add the following header: 
#                 Content-Type: application/xml
# When sending JSON as an input add the following header: 
#                 Content-Type: application/json
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
#my $mmsid = '99900008525501858';
my $mmsid = '99147373710001451';

my $outputfile = 'out.txt';

open (OUTFILE, '>:utf8',$outputfile);

$url = $baseurl . $service . $mmsid . '/holdings/'; 
$response = $ua->get($url);
print $url;
print "\n$apikey";
print OUTFILE $response->content;
close (OUTFILE);

