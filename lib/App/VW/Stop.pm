package App::VW::Stop;
use strict;
use warnings;
use base 'App::VW::Command';

sub run {
  my ($self) = @_;
  system("sudo /etc/init.d/vw stop");
}

1;

=head1 NAME

App::VW::Stop - stop all configured Squatting apps

=cut
