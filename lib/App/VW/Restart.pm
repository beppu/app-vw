package App::VW::Restart;
use strict;
use warnings;
use base 'App::VW::Command';

sub run {
  my ($self) = @_;
  system("vw stop");
  system("vw start");
}

1;

=head1 NAME

App::VW::Restart - restart all configured Squatting apps

=cut
