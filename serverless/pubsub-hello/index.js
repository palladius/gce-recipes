/**
 * Cloud Function.
 *
 * @param {object} event The Cloud Functions event.
 * @param {function} callback The callback function.
 */
exports.helloWorldPS = function helloWorldPS (event, callback) {
  console.log(`My Cloud Function: ${event.data.message}`);
  callback();
};

