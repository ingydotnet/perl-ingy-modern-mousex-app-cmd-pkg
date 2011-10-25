##
# name:      [% module.name %]
# abstract:  [% abstract %]
# author:    [% author.name %] <[% author.email %]>
# license:   [% license.type %]
# copyright: [% date.year %]

use [% perl.version %];

use Mouse 0.93 ();
use MouseX::App::Cmd 0.08 ();

#------------------------------------------------------------------------------#
package [% module.name %];

our $VERSION = '[% version %]';

#------------------------------------------------------------------------------#
package [% module.name %]::Command;
use App::Cmd::Setup -command;
use Mouse;
extends 'MouseX::App::Cmd::Command';

sub validate_args {}

# Semi-brutal hack to suppress extra options I don't care about.
around usage => sub {
    my $orig = shift;
    my $self = shift;
    my $opts = $self->{usage}->{options};
    @$opts = grep { $_->{name} ne 'help' } @$opts;
    return $self->$orig(@_);
};

#-----------------------------------------------------------------------------#
package [% module.name %];
use App::Cmd::Setup -app;
use Mouse;
extends 'MouseX::App::Cmd';

use Module::Pluggable
  require     => 1,
  search_path => [ '[% module.name %]::Command' ];
[% module.name %]->plugins;

#------------------------------------------------------------------------------#
package [% module.name %]::Command::xxx;
[% module.name %]->import( -command );
use Mouse;
extends '[% module.name %]::Command';

use constant abstract => '...';
use constant usage_desc => '[% cmd %] xxx ...';

has yyy => (
    is => 'ro',
    isa => 'Str',
    documentation => '...',
);

sub execute {
    my ($self, $opt, $args) = @_;
    ...    
}

#------------------------------------------------------------------------------#
package [% module.name %]::Command;

# Common subroutines:

1;

=head1 SYNOPSIS

...

=head1 DESCRIPTION

...
