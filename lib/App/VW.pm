package App::VW;

use strict;
use warnings;
use base 'App::CLI';
use Config;
use YAML 'LoadFile';

our $VERSION = '0.01';

our $config = {
  etc  => '/etc/vw',
  perl => $Config{perlpath},
  init => '/etc/init.d/vw',
};

sub config {
  my ($class) = @_;
  $config->{apps} = $class->apps;
  $config;
}

sub apps {
  my ($class) = @_;
  my @apps = map { LoadFile($_) } sort glob("$config->{etc}/*.yml");
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

sub verbose {
  my ($self, @message) = @_;
  print @message, "\n" if ($self->{verbose});
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
