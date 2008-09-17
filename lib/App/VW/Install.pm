package App::VW::Install;
use strict;
use warnings;
use base 'App::CLI::Command';
use File::ShareDir 'module_dir';

sub options {
  (
    'verbose|v' => 'verbose',
  );
}

sub run {
  my ($self) = @_;
  warn "This should copy ".module_dir('App::VW')."/etc/init.d/vw-* to /etc/init.d .\n";
}

1;

=head1 NAME

App::VW::Install - install init script and config dir for vw

=cut
