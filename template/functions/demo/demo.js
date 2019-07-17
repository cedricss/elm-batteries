// Docs on event and context https://www.netlify.com/docs/functions/#the-handler-method
exports.handler = async (event, context) => {
  try {
    // A faux 500ms delay to simulate a slower connection
    await new Promise(resolve => setTimeout(resolve, 500));

    return {
      statusCode: 200,
      body: JSON.stringify({
        name: "elm-batteries",
        url: "https://elm-batteries.netlify.com",
        author: "Cédric Soulas",
        license: "MIT"
      })
      // // more keys you can return:
      // headers: { "headerName": "headerValue", ... },
      // isBase64Encoded: true,
    };
  } catch (err) {
    return { statusCode: 500, body: err.toString() };
  }
};
