package App::VW;

use strict;
use warnings;
use base 'App::CLI';

our $VERSION = '0.01';

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

1;

__END__

=head1 NAME

App::VW - a deployment system for Squatting+Continuity web apps

=head1 DESCRIPTION

=head1 API

=head2 App::VW->error_cmd

=head1 AUTHOR

John BEPPU C<< <beppu at cpan.org> >>

=cut
