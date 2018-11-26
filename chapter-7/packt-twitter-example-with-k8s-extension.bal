//Following code will generate Docker image and 
//kubernetes deployment file in YAML format in your source code tree
//Please use packt-twitter-example.bal to embed this code caustiously

//comment by : Shailender singh
// --------------------------------------
import ballerina/config;
import ballerina/io;
import wso2/twitter;
import ballerina/http;
//import ballerina/time;

endpoint http:Listener listener {
   port:9090
};
//Some how it is not detecting type and reporting error around it
//type Person {
//  string name;
//};
endpoint twitter:Client tweeter {
   clintId: config:getAsString("jkBodpOzyIWVjSaDy4VVHrXZS"),
   clientSecret: config:getAsString("wV64RMfterdp9cfXlEw8CIx0qrNlyXKgo3H6cJfWcDkJ5z55vo"),
   accessToken: config:getAsString("398023992-dPAPI1FLCEXdWORTPinRKr63SERzDpXbknAhhh3Y"),
   accessTokenSecret: config:getAsString("3RsUazBMYXYiPRgfRgc6NpsrHw1YACzDwepmWNuZORd3P"),
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

@kubernetes:Deployment {
  image: "demo/ballerina-packt-image",
  name: "ballerina-packt-image"
}
// toml is file in which we defined our secure or other variables
@kubernetes:ConfigMap {
  ballerinaConf: "secretes.toml"
}
@http:ServiceConfig {
 basePath: "/"
}
// --------------------------------------

//Following is just same code that we given in above twitter example to give you reference about where you can place your deployment code
service<http:Service> hello bind listener {
  @http:ResourceConfig {
      path: "/",
      methods: ["POST"]
  }
  hi (endpoint caller, http:Request request, Person person) {
    string body = check request.getTextPayload();
    var status = check tweeter ->tweet("hello" + body + "PacktPub #ballerina example" );
    int id = status.id;
    string createdAt = status.CreatedAt;
    json js = {
      twitterID: id,
      createdAt: createdAt,
      key: "value"
    };
  
}