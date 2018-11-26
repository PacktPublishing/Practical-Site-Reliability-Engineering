//It is second part and extension of simple circuit breaker example and will not run directly

@http:ServiceConfig {
basePath:"/resilient/time"
}
service<http:Service> timeInfo bind listener {

@http:ResourceConfig {
methods:["GET"],
path:"/"
}
getTime (endpoint caller, http:Request req) {

var response = legacyServiceResilientEP ->
get("/legacy/localtime");

match response {

// Circuit breaker not tripped
http:Response res => {
http:Response okResponse = new;
if (res.statusCode == 200) {

string payloadContent = check res.getTextPayload();
previousRes = untaint payloadContent;
okResponse.setTextPayload(untaint payloadContent);
io:println("Remote service OK, data received");

} else {

// Remote endpoint returns an error
io:println("Error received from "+"remote service.");
okResponse.setTextPayload("Previous Response : "
+ previousRes);

}
okResponse.statusCode = http:OK_200;
_ = caller -> respond(okResponse);
}

// Circuit breaker tripped and generates error
error err => {
http:Response errResponse = new;
io:println("Circuit open, using cached data");
errResponse.setTextPayload( "Previous Response : "
+ previousRes);

// Inform client service is unavailable
errResponse.statusCode = http:OK_200;
_ = caller -> respond(errResponse);
        }
     }
   }
}