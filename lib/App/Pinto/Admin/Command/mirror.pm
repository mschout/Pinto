package App::Pinto::Admin::Command::mirror;

# ABSTRACT: get all the latest distributions from a remote repository

use strict;
use warnings;

#-----------------------------------------------------------------------------

use base 'App::Pinto::Admin::Command';

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

sub opt_spec {
    return (
        [ 'force' => 'Force action, even if indexes appear unchanged' ],
        [ 'message=s' => 'Prepend a message to the VCS log'],
        [ 'nocommit'  => 'Do not commit changes to VCS'],
# TODO       [ 'notag'     => 'Do not create any tag in VCS'],
# TODO       [ 'tag=s'     => 'Specify an alternate tag name' ],
    );
}

#------------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;
    $self->usage_error('Arguments are not allowed') if @{ $args };
    return 1;
}

#------------------------------------------------------------------------------

sub execute {
    my ($self, $opts, $args) = @_;

    $self->pinto->new_action_batch( %{$opts} );
    $self->pinto->add_action('Mirror', %{$opts});
    my $ok = $self->pinto->run_actions();
    return $ok ? 0 : 1;
}

#------------------------------------------------------------------------------

1;

__END__
