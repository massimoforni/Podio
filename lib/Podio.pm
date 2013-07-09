package Podio;

use 5.006;
use strict;
use warnings;

use JSON;
use REST::Client;

=head1 NAME

Podio - A simple library to intercat with Podio's API

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

my $json;
my $client;

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Podio;

    my $foo = Podio->new();
    ...

=head1 SUBROUTINES/METHODS

=head2 new()

Initialize the class

=cut

sub new {
    my $class = shift;
    my $self = {};

    $json = JSON->new->allow_nonref;
    $client = REST::Client->new();
    $client->setHost( 'https://api.podio.com' );

    bless $self, $class;

    return $self;

}


=head2 setup()

Setup the base authentication configuration


=cut
sub setup {
    my ($self, %conf) = @_;
    
    $self->{'api_key'} = $conf{'api_key'};
    $self->{'api_secret'} = $conf{'api_secret'};

    return;
}



=head2 authenticateWithAuthCode()

NOT IMPLEMENTED YET


=cut
sub authenticateWithAuthCode {

}


=head2 authenticateWithApp()

Authenticate with the "App Authentication Flow"

Return the access token if successful


=cut
sub authenticateWithApp {
    my ($self, %conf) = @_;

    $self->{'app_id'} = $conf{'app_id'};
    $self->{'app_token'} = $conf{'app_token'};
    $self->{'redirect_uri'} = $conf{'redirect_uri'};

    my $headers = {'Content_Type' => 'application/json', 'Accept' => 'application/json'};

    my $data = $client->buildQuery(
        'grant_type'    => 'app',
        'app_id'        => $self->{'app_id'},
        'app_token'     => $self->{'app_token'},
        'client_id'     => $self->{'api_key'},
        'client_secret' => $self->{'api_secret'},
        'redirect_uri'  => $self->{'redirect_uri'},
    );
        

    $client->POST('/oauth/token' . $data, ('', $headers));
    my %respData = %{ $json->decode( $client->responseContent() ) };
    if (exists($respData{'access_token'})) {
         $self->{'access_token'} = $respData{'access_token'};

        return $respData{'access_token'};
    }

    return '';


}


=head2 authenticateWithCredentials()

NOT IMPLEMENTED YET


=cut
sub authenticateWithCredentials {

}





=head1 AUTHOR

Massimo Forni, C<< <forni.massimo at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-podio at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Podio>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.



=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Podio


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Podio>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Podio>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Podio>

=item * Search CPAN

L<http://search.cpan.org/dist/Podio/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Massimo Forni.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

=cut

1; # End of Podio
