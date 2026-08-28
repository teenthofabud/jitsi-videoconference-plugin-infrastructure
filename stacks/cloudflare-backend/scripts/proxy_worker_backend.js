export default {
  async fetch(request, env, ctx) {

    const LAMBDA_URL = env.LAMBDA_FUNCTIONAL_URL;
    
    // Parse the incoming request
    const incomingUrl = new URL(request.url);
    const targetUrl = new URL(LAMBDA_URL);
    
    //  Append the original path and query parameters so routing still works
    // Example: api.yourdomain.com/users?id=1 -> lambda-url.aws/users?id=1
    targetUrl.pathname = incomingUrl.pathname;
    targetUrl.search = incomingUrl.search;
    
    
    // Clone the request to modify the headers
    const proxyRequest = new Request(targetUrl, request);
    
    // THE FIX: Overwrite the Host header to match AWS
    proxyRequest.headers.set("Host", targetUrl.hostname);
    proxyRequest.headers.set("X-Forwarded-Host", incomingUrl.hostname);
    proxyRequest.headers.set("X-Forwarded-Proto", "https");
    
    // Forward the modified request to Lambda and return the response
    return fetch(proxyRequest);
  }
};