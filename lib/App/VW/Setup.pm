package App::VW::Setup;
use strict;
use warnings;
use App::VW;
use base 'App::VW::Command';
use YAML 'DumpFile';
use Cwd;

my $config = App::VW->config;

sub run {
  my ($self, $app) = @_;
  my $server_description = {
    app          => $app,
    dir          => getcwd,
    port         => 4000,
    cluster_size => 1,
  };
  my $app_name = lc $server_description->{app};
  $app_name =~ s/::/_/g;
  my $yaml_file = "$config->{dir}/$app_name.yml";
  print "Creating $yaml_file.\n" if ($self->{verbose});
  DumpFile($yaml_file, $server_description) || die($!);
}

1;

=head1 NAME

App::VW::Setup - setup a Squatting app for deployment via Continuity

=head1 SYNOPSIS

Usage:

  vw setup [OPTION]... <App>

Example:

  # Go to the directory your squatting app is in.
  cd /www/towr.of.bavl.org

  # Run the setup command
  sudo vw setup Bavl

  # You should have 1 new file in your system, now:
  /etc/vw/bavl.yml

=head1 DESCRIPTION

=cut
