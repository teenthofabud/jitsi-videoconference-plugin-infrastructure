function looksLikeFile(pathname) {
  return pathname.includes(".");
}

async function handleRequest(request, env) {
  const incomingUrl = new URL(request.url);
  const origin = env.S3_WEBSITE_ORIGIN.replace(/\/$/, "");
  const targetUrl = origin + incomingUrl.pathname + incomingUrl.search;

  let response = await fetch(targetUrl);

  if (
    (response.status === 404 || response.status === 403) &&
    !looksLikeFile(incomingUrl.pathname)
  ) {
    response = await fetch(`${origin}/index.html`);
  }

  return response;
}

export default {
  async fetch(request, env) {
    return handleRequest(request, env);
  }
};