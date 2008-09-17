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
