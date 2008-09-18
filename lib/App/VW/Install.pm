package App::VW::Install;
use strict;
use warnings;
use base 'App::VW::Command';
use File::Copy;
use File::ShareDir 'module_dir';

sub options {
  my ($class) = @_;
  (
    $class->SUPER::options,
  );
}

our %systems;
$systems{debian} = {};
$systems{ubuntu} = $systems{debian};
$systems{gentoo} = undef;
$systems{centos} = undef;

sub sys {
  require Config;
  Config->import;
}

sub run {
  my ($self) = @_;
  my $sys = sys;
  my $src = module_dir('App::VW') . "/etc/init.d/vw-ubuntu";
  my $dst = "/etc/init.d/vw";
  print "Copying $src to $dst .\n" if ($self->{verbose});
  copy($src, $dst) || die $!;
  print "Making $dst executable.\n" if ($self->{verbose});
  chmod(0755, $dst) || die $!;
  print "Creating /etc/vw .\n" if ($self->{verbose});
  if (! -d "/etc/vw" ) {
    mkdir "/etc/vw" || die $!;
  }
  print "---\n";
  print "The installation of vw was successful.\n";
  print "To make vw start upon bootup, run:  sudo update-rc.d vw defaults\n";
  return;
}

1;

=head1 NAME

App::VW::Install - install init script and config dir for vw

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 API

=head2 App->options

=head2 $vw->run

=cut
