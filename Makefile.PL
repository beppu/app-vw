use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME                => 'App::VW',
  AUTHOR              => 'John BEPPU <john.beppu@gmail.com>',
  VERSION_FROM        => 'lib/App/VW.pm',
  ABSTRACT_FROM       => 'lib/App/VW.pm',
  EXE_FILES           => [ 'bin/vw' ],
  PREREQ_PM => {
    'Test::More' => 0,
  },
  dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
  clean               => { FILES => 'App-VW-*' },
);

sub MY::libscan {
  my $self = shift;
  $_       = shift;
  # $self appears to be a blessed hashref that contains
  # all the attributes/value pairs passed to WriteMakeFile()
  # plus some other MakeMaker-related info.
  return 0 if /\.sw.$/ || /~$/;
  return $_;
}
