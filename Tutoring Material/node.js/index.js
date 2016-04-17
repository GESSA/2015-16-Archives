var server = require("./server");

var handle={};
handle["/page1"] = server.page1;
handle["/page2"] = server.page2;
server.start(handle);
