var http = require('http');

var handleRequest = function(request, response) {
  console.log('Received request for URL: ' + request.url);
  fs = require('fs');
  fs.readFile('VERSION', 'utf8', function (err,data) {
  	if (err) {
        response.writeHead(542);
  	  	return console.log(err);
  	} else {
	  response.writeHead(200);
  	  response.end('[200] Hello World su Node.js from Riccardo Dockerillo v'+data+'!');
  	}
  	console.log(data);
  	}
  );
};
var www = http.createServer(handleRequest);
www.listen(8080);
