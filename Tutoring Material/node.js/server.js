var http = require("http");
var url = require("url");
var exec = require("child_process").exec;

function start(handle) {
  function onRequest(request, response) {
    var pathname = url.parse(request.url).pathname;
    console.log("Request received for "+pathname);
    if(typeof handle[pathname] === 'function') {
      handle[pathname](request,response);
    } else {
      console.log('NO PAGE FOUND');
      response.writeHead(404, {'Content-type':'text/html'});
      response.write('NOT FOUND');
      response.end();
    }

  }
  http.createServer(onRequest).listen(8888);
  console.log('Server has started');

}

function page1(request,response) {
  exec("find /",
  {timeout:10000,maxBuffer:20000*1024},
  function(error, stdout, stderr) {
    response.writeHead(200,{"Content-type":"text/plain"});
    response.write(stdout);
    response.end();
  });
}

function page2(request,response) {
  response.writeHead(200, {"Content-type":"text/plain"});
  response.write('You are in PAGE 2');
  response.end();
}
exports.start = start;
exports.page1 = page1;
exports.page2 = page2;
