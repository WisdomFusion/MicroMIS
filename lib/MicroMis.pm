package MicroMis;
use Mojo::Base 'Mojolicious';

sub startup {
  my $self = shift;

  my $config = $self->plugin('Config' => { file => 'app.conf' });
  
  $self->static->path->[0] = './public';

  # Router
  my $r = $self->routes;
  $r->any('/' => sub { $_[0]->reply->static('index.html') });
  
  my $api = $r->under('/api/v1' => sub { 1 });
  $api->post('/login')->to('auth#login');
  $api->post('/logout')->to('auth#logout');
  $api->post('/token/renew')->to('auth#renew_token');
  
  my $authed = $api->under('/' => sub { ... });
 
  $authed->get('/users')->to('user#index');
  $authed->post('/user')->to('user#store');
  $authed->get('/user/:id' => [id => qr/\d+/])->to('user#show');
  $authed->put('/user/:id' => [id => qr/\d+/])->to('user#update');
  
  $authed->get('/projects')->to('project#index');
  $authed->post('/project')->to('project#store');
  $authed->get('/project/:id' => [id => qr/\d+/])->to('project#show');
  $authed->put('/project/:id' => [id => qr/\d+/])->to('project#update');
  $authed->get('/project/list')->to('project#list');
  
  $authed->get('/tags')->to('tag#index');
  
  $authed->get('/nodes')->to('node#index');
  $authed->post('/node')->to('node#store');
  $authed->get('/node/:id' => [id => qr/\d+/])->to('node#show');
  $authed->put('/node/:id' => [id => qr/\d+/])->to('node#update');
  
  $authed->get('/logs')->to('log#index');
}

1;
