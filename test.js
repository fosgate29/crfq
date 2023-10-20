const { ethers } = require('ethers');

async function main() {
  // hardhat wallet 0
  const sender = new ethers.Wallet('ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80');

  let message = 1; // byte 1
  message = ethers.utils.keccak256(message);

  console.log('\x1b[34m%s\x1b[0m', 'signing message 🖋: ', message);

  let signature = await sender.signMessage(message); // get the signature of the message, this will be 130 bytes (concatenated r, s, and v)

  // remove last byte
  signature = ethers.utils.arrayify(signature).slice(0, 64);

  console.log('signature 📝: ', signature);
  //console.log('hashed message 📝: ', ethers.utils.hashMessage(message));

  const hashBytes = ethers.utils.arrayify(message);
  console.log(hashBytes);

  let pubKey_uncompressed = ethers.utils.recoverPublicKey(message, signature);
  console.log('uncompressed pubkey: ', pubKey_uncompressed);

  // recoverPublicKey returns `0x{hex"4"}{pubKeyXCoord}{pubKeyYCoord}` - so slice 0x04 to expose just the concatenated x and y
  //    see https://github.com/indutny/elliptic/issues/86 for a non-explanation explanation 😂
  let pubKey = pubKey_uncompressed.slice(4);

  let pub_key_x = pubKey.substring(0, 64);
  console.log('public key x coordinate 📊: ', ethers.utils.arrayify('0x' + pub_key_x));

  let pub_key_y = pubKey.substring(64);
  console.log('public key y coordinate 📊: ', ethers.utils.arrayify('0x' + pub_key_y));
}

main();
