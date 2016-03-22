#!/usr/bin/perl

############################################################
# You will need an ExLibris developer's key to make the program
#
# This program creates a collection 
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

###############################################
# use undef and binmode to read file as string
###############################################
local $/ = undef;
open my $xmlfile, '<', "collectioncreate.xml";
binmode $xmlfile;
my $xmlcollection = <$xmlfile>;
close $xmlfile;
print "$xmlcollection\n";

my $ua = LWP::UserAgent->new;
$ua->default_header('Authorization' => "apikey $apikey");
#$ua->default_header('Content-Type' => "application/xml");

######################################
# make sure line feeds delimit records
######################################
$/ = "\n";

my $response = '';
my $url = '';
my $oclc = '';

my $baseurl = 'https://api-na.hosted.exlibrisgroup.com';
my $service = '/almaws/v1/bibs/collections';

my $outputfile = 'out.txt';

open (OUTFILE, '>:utf8',$outputfile);

$url = $baseurl . $service; 
$response = $ua->post($url, Content_Type => 'application/xml', Content => $xmlcollection);
print $url;
print OUTFILE $response->content;
close (OUTFILE);

