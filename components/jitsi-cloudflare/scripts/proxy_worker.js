
function looksLikeFile(pathname) {
  return pathname.includes(".");
}

async function handleRequest(request) {
  const incomingUrl = new URL(request.url);
  const ORIGIN = env.S3_WEBSITE_ORIGIN.replace(/\/$/, "");
  const targetUrl =
  ORIGIN + incomingUrl.pathname + incomingUrl.search;

  let response = await fetch(targetUrl);
  if (
    (response.status === 404 || response.status === 403) &&
    !looksLikeFile(incomingUrl.pathname)
  ) {
    response = await fetch(`${ORIGIN}/index.html`);
  }

  return response;
}

export default {
  async fetch(request) {
    return handleRequest(request);
  }
};