#
#  This file is part of Sample::Module.
#
#  This software is copyright (c) 2015 by Andrew Speer <andrew.speer@isolutions.com.au>.
#
#  This is free software; you can redistribute it and/or modify it under
#  the same terms as the Perl 5 programming language system itself.
#
#  Full license text is available at:
#
#  <http://dev.perl.org/licenses/>
#


#  Package Constants
#
package Sample::Module::Constant;


#  Compiler Pragma
#
use strict qw(vars);
use vars qw($VERSION @ISA %EXPORT_TAGS @EXPORT_OK @EXPORT %Constant);    ## no critic
use warnings;
no warnings qw(uninitialized);


#  External modules
#
use Cwd qw(abs_path);


#  Version information in a format suitable for CPAN etc. Must be
#  all on one line
#
$VERSION='0.001';


#===================================================================================================


#  Get module file name and path, derive name of file where local constants stored. e.g.
#  <perl lib>/Package/Constant.local will override anything in Constant.pm
#
my $module_fn=abs_path(__FILE__);
my $constant_local_fn="${module_fn}.local";


#  Constants
#  <<<
%Constant=(


    #  Constant name => Value
    #
    #COPYRIGHT_KEYWORD => 'Copyright',

    #  Local constants override anything above
    #
    %{do($constant_local_fn)}

);

#  >>>


#  Export constants to namespace, place in export tags
#
require Exporter;
@ISA=qw(Exporter);
foreach (keys %Constant) {${$_}=$ENV{$_} ? $Constant{$_}=eval($ENV{$_}) : $Constant{$_}}    ## no critic
@EXPORT=map {'$' . $_} keys %Constant;
@EXPORT_OK=@EXPORT;
%EXPORT_TAGS=(all => [@EXPORT_OK]);
$_=\%Constant;
1;

