
const S3_WEBSITE_ORIGIN =
  "http://toab-jitsi-web-dev-414772275073-eu-central-1-an.s3-website.eu-central-1.amazonaws.com";

function looksLikeFile(pathname) {
  return pathname.includes(".");
}

async function handleRequest(request) {
  const incomingUrl = new URL(request.url);

  const targetUrl =
    S3_WEBSITE_ORIGIN + incomingUrl.pathname + incomingUrl.search;

  let response = await fetch(targetUrl);
  if (
    (response.status === 404 || response.status === 403) &&
    !looksLikeFile(incomingUrl.pathname)
  ) {
    response = await fetch(`${S3_WEBSITE_ORIGIN}/index.html`);
  }

  return response;
}

export default {
  async fetch(request) {
    return handleRequest(request);
  }
};