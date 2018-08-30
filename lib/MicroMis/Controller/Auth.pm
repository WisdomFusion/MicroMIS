package MicroMis::Controller::Auth;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::Util 'secure_compare';

sub login {
  my $c = shift;
  
  my $email = $c->param('email') // '';
  my $pass  = $c->param('pass')  // '';
  
  unless(lc($email) eq 'wisdomfusion@gmail.com' && $pass eq '123456') {
    return $c->render(
      json => {
        error   => 'invalid_email_or_password',
        message => '用户名或密码错误'
      },
      status => 400
    );
  }
  
  return $c->render(
    json => { token => $c->jwt_encode({ api_key => $c->config('api_key') }) },
    status => 200
  );
}

1;