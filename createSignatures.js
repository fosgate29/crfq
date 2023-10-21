const { ethers } = require('ethers');

async function main() {
  // hardhat wallet 0, 1 and 2
  const sender1 = new ethers.Wallet('ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80');
  const sender2 = new ethers.Wallet('59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d');
  const sender3 = new ethers.Wallet('5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a');

  const quote1 = 2;
  const quote2 = 1;
  const quote3 = 3;

  console.log('\x1b[34m%s\x1b[0m', 'signing message1 🖋: ', quote1);
  console.log('\x1b[34m%s\x1b[0m', 'signing message2 🖋: ', quote2);
  console.log('\x1b[34m%s\x1b[0m', 'signing message3 🖋: ', quote3);
  let signature1 = await sender1.signMessage(quote1); // get the signature of the message, this will be 130 bytes (concatenated r, s, and v)
  let signature2 = await sender2.signMessage(quote2); // get the signature of the message, this will be 130 bytes (concatenated r, s, and v)
  let signature3 = await sender3.signMessage(quote3); // get the signature of the message, this will be 130 bytes (concatenated r, s, and v)

  // remove last byte
  signature1 = ethers.utils.arrayify(signature1).slice(0, 64);
  signature2 = ethers.utils.arrayify(signature2).slice(0, 64);
  signature3 = ethers.utils.arrayify(signature3).slice(0, 64);

  console.log('signature1 📝: ', signature1);
  console.log('signature2 📝: ', signature2);
  console.log('signature3 📝: ', signature3);

  console.log('hashedMessage1: ', ethers.utils.arrayify(ethers.utils.hashMessage(quote1)));
  console.log('hashedMessage2: ', ethers.utils.arrayify(ethers.utils.hashMessage(quote2)));
  console.log('hashedMessage3: ', ethers.utils.arrayify(ethers.utils.hashMessage(quote3)));

  // Pub key quote 1
  let pubKey_uncompressed1 = ethers.utils.recoverPublicKey(ethers.utils.hashMessage(quote1), signature1);
  console.log('uncompressed pubkey1: ', pubKey_uncompressed1);

  let pubKey1 = pubKey_uncompressed1.slice(4);

  let pub_key_x1 = pubKey1.substring(0, 64);
  console.log('public key x 1 coordinate 📊: ', ethers.utils.arrayify('0x' + pub_key_x1));

  let pub_key_y1 = pubKey1.substring(64);
  console.log('public key y 1 coordinate 📊: ', ethers.utils.arrayify('0x' + pub_key_y1));

  // Pub key quote 2
  let pubKey_uncompressed2 = ethers.utils.recoverPublicKey(ethers.utils.hashMessage(quote2), signature2);
  console.log('uncompressed pubkey2: ', pubKey_uncompressed2);

  let pubKey2 = pubKey_uncompressed2.slice(4);

  let pub_key_x2 = pubKey2.substring(0, 64);
  console.log('public key x 2 coordinate 📊: ', ethers.utils.arrayify('0x' + pub_key_x2));

  let pub_key_y2 = pubKey2.substring(64);
  console.log('public key y 2 coordinate 📊: ', ethers.utils.arrayify('0x' + pub_key_y2));

  // Pub key quote 3
  let pubKey_uncompressed3 = ethers.utils.recoverPublicKey(ethers.utils.hashMessage(quote3), signature3);
  console.log('uncompressed pubkey3: ', pubKey_uncompressed3);

  let pubKey3 = pubKey_uncompressed3.slice(4);

  let pub_key_x3 = pubKey3.substring(0, 64);
  console.log('public key x 3 coordinate 📊: ', ethers.utils.arrayify('0x' + pub_key_x3));

  let pub_key_y3 = pubKey3.substring(64);
  console.log('public key y 3 coordinate 📊: ', ethers.utils.arrayify('0x' + pub_key_y3));
}

main();
