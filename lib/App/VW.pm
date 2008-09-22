package App::VW;

use strict;
use warnings;
use base 'App::CLI';
use Config;
use YAML 'LoadFile';

our $VERSION = '0.01';

our $config = {
  etc  => '/etc/vw',
  perl => $Config{perlpath},
  init => '/etc/init.d/vw',

  pid_file => '/var/run/vw.pid',
};

sub config {
  my ($class) = @_;
  $config->{apps} = $class->apps;
  $config;
}

sub apps {
  my ($class) = @_;
  my @apps = map { LoadFile($_) } sort glob("$config->{etc}/*.yml");
  \@apps;
}

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

sub verbose {
  my ($self, @message) = @_;
  print @message, "\n" if ($self->{verbose});
}

1;

__END__

=head1 NAME

App::VW - a deployment system for Squatting+Continuity web apps

=head1 SYNOPSIS

Installing the init script and creating the config dir:

  sudo vw install

Preparing an app for vw:

  cd /path/to/squatting/app
  sudo vw setup --port=5000 --cluster-size=1
  vi vw_harness.pl

Starting and stopping vw:

  sudo /etc/init.d/vw start
  sudo /etc/init.d/vw stop

Making vw start up at boot time (on Debian-like systems):

  sudo update-rc.d vw defaults

Disabling vw from starting up at boot (on Debian-like systems):

  sudo update-rc.d -f vw remove


=head1 DESCRIPTION

=head2 camping : rv :: squatting : vw

C<vw> is a system for deploying L<Squatting> web apps using the L<Continuity>
backend.  It's modeled after C<rv> which was a system for deploying Camping
applications during the Camping 1.5 era.  (Unfortunately, I don't think it
works for Camping 2.0.)

If you like the idea of starting up a cluster of web servers and putting them
behind a reverse proxy (like nginx, perlbal, or Apache's mod_proxy_balancer),
then C<vw> might be the system for you.

=head2 Getting Started

The L</SYNOPSIS> tells you most of what you need to know.

Running C<vw help> will give you a list of subcommands.

You can also run C<vw help SUBCOMMAND> to get more information on the various
subcommands.

B<Example>:

  vw help install
  vw help setup

=head1 FILES

=head2 /etc/init.d/vw

This is the init script for vw, and it gets installed when you run
C<vw install>.  The following commands are supported.

=over 2

=item start

Start the Squatting+Continuity apps as defined in /etc/vw/*.yml.

=item stop

Stop the Squatting+Continuity apps (via SIGINT).

=item restart

Stop and start the Squatting+Continuity apps.

=item reload

This command sends a SIGHUP to the vw-bus process, but the process
hasn't been setup to respond to it yet, so it's currently a NO-OP.

=back

=head2 /etc/vw/*.yml

These L<YAML> files tell C<vw> how to start up a Squatting application.
These are created for you when you run C<vw setup>.
Here's how one might look like:

  ---
  app: Bavl
  cluster_size: 1
  dir: /www/towr.of.bavl.org
  port: 4010

The required fields are:

=over 2

=item app

This is the module name of the Squatting app.

=item dir

This is the directory that the F<vw_harness.pl> for this app is in.
This directory should be writable because some pid files are written here.
(In the future, we may write the pid files for the worker processes elsewhere.)

=item port

This is the port that the app should listen on for HTTP requests.

=item cluster_size

This is the number of processes to start for the app.

Note that if port is 2000 and cluster_size is 4, then 4 processes will
be started up, and they'll handle ports 2000, 2001, 2002, and 2003.

=back

=head2 vw_harness.pl

This is the script that that actually starts up the L<Squatting::On::Continuity>
web server.  This is also created for you when you run C<vw setup>.

It gets C<port> and C<document_root> passed to it in C<@ARGV>.  The script's
job is to start up a web server on the given port using the specified
document_root.  Some apps don't care about document_root, so ignoring it
allowed when appropriate.  However, port should not be ignored.

Feel free to edit this script as much as you want.  Any and all initialization
for your web app can be done here.

=head1 REVELATION

Although C<vw> was intended to be a system for deploying Squatting applications
on top of Continuity, it can actually deploy any perl-based web server you
want.  If you wanted to deploy a pure Continuity app, it wouldn't be too hard
to write a F<vw_harness.pl> that did just that.  The same goes for
HTTP::Server::Simple or even Catalyst.  If your goal is to reverse-proxy to a
cluster of perl-based HTTP servers, C<vw> can manage this cluster for you.

Creating a custom F<vw_harness.pl> is the key.

=head1 BUGS

Currently, C<vw> only works on Debian and Debian-derivatives (like Ubuntu).  It
may also work on other Linux systems that use SysV init for starting daemons at
boot up, but that's not guaranteed.

If you'd like to use App::VW with other Linux distros or other Unixes, send me an
email, and we can work on adding support for your system.

=head1 SEE ALSO

=head2 Utilities

L<vw>, L<vw-bus>

=head2 Related Perl Modules

L<Squatting>, L<Squatting::On::Continuity>, L<Continuity>, L<App::CLI>

=head2 Related Ruby Code

L<http://code.whytheluckystiff.net/camping/>

=head1 AUTHOR

John BEPPU C<< <beppu@cpan.org> >>

=cut
