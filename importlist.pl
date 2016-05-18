#!/usr/bin/perl

############################################################
# You will need an ExLibris developer's key to make the program
#
# This program lists all metadata import profiles 
#
##############################################################

use strict;
use warnings;
use LWP::UserAgent;

########################################################################
# initialize a few variables. You'll need a developer's key from Ex Libris to
# make this work
########################################################################
open my $apikeyfile, '<', "apikey.txt";
my $apikey = <$apikeyfile>;
close $apikeyfile;

my $ua = LWP::UserAgent->new;
$ua->default_header('Authorization' => "apikey $apikey");

my $response = '';
my $url = '';
my $profileid = '';

my $baseurl = 'https://api-na.hosted.exlibrisgroup.com';
my $service = '/almaws/v1/conf/md-import-profiles';

my $outputfile = 'out.txt';

open (OUTFILE, '>:utf8',$outputfile);

$url = $baseurl . $service; 
$response = $ua->get($url);
print $url;
print OUTFILE $response->content;
close (OUTFILE);

