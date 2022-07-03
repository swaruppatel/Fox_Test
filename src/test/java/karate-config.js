function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
  }
  if (env == 'dev') {

    config.baseUrl = "https://api3.fox.com/"
    config.apiVersion= 'v2.0'
    config.registerUrl =config.baseUrl+config.apiVersion+'/register'
    config.loginUrl=config.baseUrl+config.apiVersion+'/login'
    config.resetUrl=config.baseUrl+config.apiVersion+'/reset'

  } else if (env == 'e2e') {
    // customize

  }
  karate.configure("connectTimeout",60000);
  karate.configure("readTimeout",60000)
  return config;
}