//Circuit breaking example from https://ballerina.io/
import ballerina/http;
import ballerina/io;

string previousRes;

endpoint http:Listener listener {
port:9090
};

// Endpoint with circuit breaker can short circuit responses under
// some conditions. Circuit flips to OPEN state when errors or
// responses take longer than timeout. OPEN circuits bypass
// endpoint and return error.

endpoint http:Client legacyServiceResilientEP {
url: "http://localhost:9091",
circuitBreaker: {
// Failure calculation window
rollingWindow: {
// Duration of the window
timeWindowMillis: 10000,

// Each time window is divided into buckets
bucketSizeMillis: 2000,

// Min # of requests in a `RollingWindow` to trip circuit
requestVolumeThreshold: 0
},

// Percentage of failures allowed
failureThreshold: 0.0,

// Reset circuit to CLOSED state after timeout
resetTimeMillis: 1000,

// Error codes that open the circuit
statusCodes: [400, 404, 500]
},

// Invocation timeout - independent of circuit
timeoutMillis: 2000
};