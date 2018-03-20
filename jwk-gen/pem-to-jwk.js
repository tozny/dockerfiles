var fs = require('fs');
var rsaPemToJwk = require('rsa-pem-to-jwk');

var pem = fs.readFileSync('/tmp/private.pem');

var jwk = rsaPemToJwk(pem, 'private');

console.log(jwk)
