package App::VW;

use strict;
use warnings;
use base 'App::CLI';
use Config;
use YAML;

our $VERSION = '0.01';

our $config = {
  dir => '/etc/vw',
};

sub config {
  my ($class) = @_;
  $config;
}

sub apps {
  my ($class) = @_;
  my $config = $class->config;
  my @apps = map { Load($_) } glob("$config->{dir}/*.yml");
  \@apps;
}

sub error_cmd {
  my ($self) = @_;
  "That command does not exist.\n";
}

package App::VW::Command;
use base 'App::CLI::Command';

sub options {
  (
    'verbose|v' => 'verbose',
    'help|h'    => 'help'
  )
}

sub run {
  my ($self) = @_;
  print "Not Implmenented, Yet.\n";
}

1;

__END__

=head1 NAME

App::VW - a deployment system for Squatting+Continuity web apps

=head1 DESCRIPTION

Squatting apps are asked to deploy themselves for the volk and the fatherland.

=head1 AUTHOR

John BEPPU C<< <beppu@cpan.org> >>

=cut
