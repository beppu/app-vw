package App::VW::Restart;
use strict;
use warnings;
use base 'App::VW::Command';

sub run {
  my ($self) = @_;
  system("/etc/init.d/vw restart");
}

1;

=head1 NAME

App::VW::Restart - restart all configured Squatting apps

=cut
