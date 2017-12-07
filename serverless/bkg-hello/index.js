
/**
 * Background Cloud Function.
 *
 * @param {object} event The Cloud Functions event.
 * @param {function} callback The callback function.
 */
exports.helloBackgroundBroken = function helloBackgroundBroken (event, callback) {
  console.log(`[nkg-hello] helloBackground: event.data=${event.data}`);
  console.log(`[nkg-hello] helloBackground: about to log the whole event object, id=${event.eventId}!`);
  console.log(event);
  callback(null, `Ma ciao ${event.data.name || 'World'}!`);
};


/**
 * Background Cloud Function to be triggered by Pub/Sub.
 *
 * @param {object} event The Cloud Functions event.
 * @param {function} callback The callback function.
 */
exports.helloBackgroundFromPubSub = function (event, callback) {
  const pubsubMessage = event.data;
  const name = pubsubMessage.data ? Buffer.from(pubsubMessage.data, 'base64').toString() : 'World';

  console.log(`Hello, ${name}!`);

  callback();
};


/**
 * Background Cloud Function to be triggered by Cloud Storage.
 *
 * @param {object} event The Cloud Functions event.
 * @param {function} callback The callback function.
 */
exports.helloBackgroundFromGCS = function (event, callback) {
  const file = event.data;

  if (file.resourceState === 'not_exists') {
    console.log(`File ${file.name} deleted.`);
  } else if (file.metageneration === '1') {
    // metageneration attribute is updated on metadata changes.
    // on create value is 1
    console.log(`File ${file.name} uploaded.`);
  } else {
    console.log(`File ${file.name} metadata updated.`);
  }

  callback();
};