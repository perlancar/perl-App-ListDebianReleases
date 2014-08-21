package App::ListDebianReleases;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Version::Util qw(cmp_version);

our %SPEC;
$SPEC{list_debian_releases} = {
    v => 1.1,
    summary => 'List Debian releases',
    args => {
        detail => {
            schema => 'bool*',
        },
    },
};
sub list_debian_releases {
    require Debian::Releases; # rather chubby

    my %args = @_;

    my $dr = Debian::Releases->new;
    my $rel = $dr->releases;
    #use Data::Dump; dd $rel;
    my @res;
    for (sort {cmp_version($a, $b)} keys %$rel) {
        push @res, $args{detail} ? {version=>$_, code_name=>$rel->{$_}} : $_;
    }
    [200, "OK", \@res];
}

1;
# ABSTRACT: List Debian releases

=head1 SEE ALSO

L<Debian::Releases>

=cut
