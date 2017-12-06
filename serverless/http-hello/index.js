/**
 * Responds to any HTTP request that can provide a "message" field in the body.
 *
 * @param {Object} req Cloud Function request context.
 * @param {Object} res Cloud Function response context.
 */

const version = '1.0';

exports.helloWorldHttp = function helloWorldHttp (req, res) {
  if (req.body.message === undefined) {
    // This is an error case, as "message" is required
    res.status(400).send('No message defined!');
  } else {
    // Everything is ok
    console.log("[helloWorldHttp v.",version,"]" , req.body.message);
    res.status(200).end();
  }
};


/**
 * HTTP Cloud Function. Riccardo from # https://cloud.google.com/functions/docs/tutorials/http
 *
 * @param {Object} req Cloud Function request context.
 * @param {Object} res Cloud Function response context.
 */
exports.helloGET = function helloGET (req, res) {
  res.send('Hello World v.'+version+'!');
};