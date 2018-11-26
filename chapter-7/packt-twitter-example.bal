//Example shown during Ballerina demo
//Created for Ballerina example and similar reference can be taken from their github
//Github: https://github.com/ballerina-platform/ballerina-lang
//https://www.youtube.com/watch?v=67v7mjlSHWI&t=29s - YouTube reference for this code reference

import ballerina/config;
import ballerina/io;
import wso2/twitter;
import ballerina/http;
import ballerina/runtime;
//import ballerina/time;

endpoint http:Listener listener {
   port:9090
};
//Some how it is not detecting type and reporting error around it
//type Person {
//  string name;
//};
endpoint twitter:Client tweeter {
    clintId: config:getAsString("CLIENT_ID"),
	clientSecret: config:getAsString("CLIENT_SECRET"),
	accessToken: config:getAsString("ACCESS_TOKEN"),
	accessTokenSecret: config:getAsString("ACCESS_TOKEN_SECRET"),
    clientConfig: {}
};

@http:ServiceConfig {
   basePath: "/"
}
service<http:Service> hello bind listener {
         @http:ResourceConfig {
         basePath: "/",
         methods: ["POST"],
         body: "person",
         consumes: ["application/json"],
         produces: ["application/json"]
      }
      hi (endpoint caller, http:Request request) {
      //hi (endpoint caller, http:Request request, Person person) {
      string payload_body = check request.getTextPayload();
      var status = check tweeter ->tweet("Hello" + payload_body + "PacktPub #ballerina example" );
      int id = status.id;
      string createdAt = status.CreatedAt;
      json jason_content = {
         twitterID: id,
         createdAt: createdAt,
         key: "value"
      };
      _ = caller -> respond(jason_content);
   }
}
