#!/usr/bin/env perl
use strict;
use warnings;
# https://metacpan.org/pod/XML::Parser
use XML::Parser;

sub usage {
    die "Usage: $0 <path_to_xml_file> [node_name1 node_name2 ...]\n";
}

my $xml_file = shift @ARGV or usage();
my %filter = map { $_ => 1 } @ARGV;
my %counts;

my $parser = XML::Parser->new(Handlers => { Start => \&handle_start });

sub handle_start {
    my ($expat, $element, @attrs) = @_;
    if (!%filter || $filter{$element}) {
        $counts{$element}++;
    }
}

eval { $parser->parsefile($xml_file); };
if ($@) {
    die "Error parsing XML: $@";
}

print "Node counts:\n";
for my $k (sort keys %counts) {
    print "$k: $counts{$k}\n";
}

__END__
