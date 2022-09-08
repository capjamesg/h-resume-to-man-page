#!/usr/bin/perl

use strict;
use warnings;

use Web::Microformats2;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new();

my $url = "https://jamesg.blog/resume/";

my $document = $ua->get($url);

my $mf2_parser = Web::Microformats2::Parser->new;

my $parsed_doc = $mf2_parser->parse($document->decoded_content);

my $hresume = $parsed_doc->get_first("h-resume");

my $title = $hresume->get_properties("name");

if ($title) {
    $title = $title->[0];
} else {
    $title = "[YOUR NAME]";
}

my $summary = $hresume->get_properties("summary");

if ($summary) {
    my $summary_item = $summary->[0];
    $summary = ".SH SUMMARY\n\n$summary_item\n";
}

my $education_text = "";
my $education_items = $hresume->get_property("education");

for my $item ($education_items) {
    $education_text .= $item->get_properties("summary")->[0] . "\n\n";
    $education_text .= $item->get_properties("achievement")->[0];
}

my $experience = "";
my $experience_items = $hresume->get_properties("experience");

for my $item (@{$experience_items}) {
    $experience .= ".B \n";
    $experience .= $item->get_properties("name")->[0] . "\n";
    $experience .= ".PP \n";
    $experience .= $item->get_properties("summary")->[0] . "\n\n";
}

my $skills = "";

for my $item (@{$hresume->get_properties("skill")}) {
    $skills .= $item . "\n\n";
}

my $man_page = ".TH $title 1
.SH NAME
$title
$summary
.SH EXPERIENCE
$experience
.SH EDUCATION
$education_text
.SH SKILLS
$skills
.SH LEARN MORE
You can read my full resume at the following URL:
$url
";

# print $man_page;

open my $fh, ">", "resume.man";
print $fh $man_page;
close $fh;