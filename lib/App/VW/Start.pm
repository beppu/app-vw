package App::VW::Start;
use strict;
use warnings;
use base 'App::VW::Command';

sub run {
  my ($self) = @_;
  system("sudo /etc/init.d/vw start");
}

1;

=head1 NAME

App::VW::Start - start all configured Squatting apps

=cut
