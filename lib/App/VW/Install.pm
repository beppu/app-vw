package App::VW::Install;
use strict;
use warnings;
use base 'App::VW::Command';
use File::ShareDir 'module_dir';

sub options {
  my ($class) = @_;
  (
    $class->SUPER::options,
  );
}

sub run {
  my ($self) = @_;
  warn "This should copy ".module_dir('App::VW')."/etc/init.d/vw-* to /etc/init.d .\n";
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
