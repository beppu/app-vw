package App::VW::Setup;
use strict;
use warnings;
use App::VW;
use Cwd;
use base 'App::VW::Command';
use File::ShareDir 'module_dir';
use YAML 'DumpFile';
use Data::Dump 'pp';

my $config = App::VW->config;

sub options {
  my ($class) = @_;
  (
    $class->SUPER::options,
    'port|p=i'     => 'port',
    'size|s=s'     => 'size',
    'modules|m=s@' => 'modules',
  );
}

sub run {
  my ($self, $app) = @_;
  my $cwd = getcwd;
  warn pp $self;
  my $cluster_description = {
    app          => $app,
    dir          => $cwd,
    port         => $self->{port} || 4000,
    cluster_size => $self->{size} || 1,
  };

  if ($self->{modules}) {
    $cluster_description->{modules} =
      join(" ", @{ $self->{modules} });
  }

  my $app_name = lc $cluster_description->{app};
  $app_name =~ s/::/_/g;
  my $yaml_file = "$config->{etc}/$app_name.yml";
  print "Creating $yaml_file.\n" if ($self->{verbose});
  DumpFile($yaml_file, $cluster_description) || die($!);

  my $src = module_dir('App::VW') . "/etc/vw_harness.tmpl"; 
  my $harness_file = "$cwd/vw_harness.pl";
  print "Creating $harness_file.\n" if ($self->{verbose});

  open(IN, "<", $src) || die ($!);
  my $tmpl = join('', <IN>);
  close(IN);

  $tmpl =~ s/\[%\s*(\w+)\s*%\]/$cluster_description->{$1}/eg;

  open(OUT, ">", $harness_file) || die($!);
  print OUT $tmpl;
  close(OUT);
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

  # You should have 2 new files in your system, now:
  /etc/vw/bavl.yml
  /www/towr.of.bavl.org/vw_harness.pl

=head1 DESCRIPTION

=cut
