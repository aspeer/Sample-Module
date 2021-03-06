use 5.006;
use strict;
use ExtUtils::MakeMaker;
my $mm_ver = $ExtUtils::MakeMaker::VERSION;
if ($mm_ver =~ /_/) { # dev version
    $mm_ver = eval $mm_ver;
    die $@ if $@;
}
my %WriteMakefile=(
    NAME                => 'Sample::Module',
    VERSION_FROM        => 'lib/Sample/Module.pm',
    ABSTRACT_FROM       => 'lib/Sample/Module.pm',,
    EXE_FILES           => [],
    LICENSE             => 'perl',
    AUTHOR              => 'Andrew Speer <andrew.speer@isolutions.com.au>',
    MIN_PERL_VERSION	=> '5.006',
    PREREQ_PM           =>  {
        'Test::Simple'  =>  0.44
    },
    META_MERGE => { 
        'meta-spec'     => {
            version     => 2
        },
        resources       => {
            homepage    => 'https://github.com/aspeer/Sample-Module',
            repository  => {
                type    => 'git',
                url     => 'https://github.com/aspeer/Sample-Module.git',
                web     => 'https://github.com/aspeer/Sample-Module'
            }
        }
    },
    'depend'            => {
        Makefile        => '$(VERSION_FROM)',
    },
    'dist'		=> {
	COMPRESS        =>  'gzip -9f',
	SUFFIX		=>  '.gz'
    },
);
my %MM_Compat=(
    '6.31'              => [q(LICENSE)],
    '6.46'              => [q(META_MERGE)],
    '6.48'              => [q(MIN_PERL_VERSION)],
    '6.52'              => [q(CONFIGURE_REQUIRES)],
    '6.5503'            => [q(BUILD_REQUIRES)],
    '6.64'              => [q(TEST_REQUIRES)],
);
while (my($mm_ver_test, $ar)=each %MM_Compat) {
    if (version->parse($mm_ver) < version->parse($mm_ver_test)) {
        delete @WriteMakefile{@{$ar}};
    }
}
WriteMakefile(%WriteMakefile);
package MY;
sub post_initialize {
    #  Add license file, other support files here
    #
    my $mm_or=shift();
    $mm_or->{'PM'}{'LICENSE'}='$(INST_LIBDIR)/$(BASEEXT)/LICENSE';
    $mm_or->SUPER::post_initialize;
};
