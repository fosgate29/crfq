const { ethers } = require('ethers');

async function main() {
  // hardhat wallet 0, 1 and 2
  const sender1 = new ethers.Wallet('ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80');

  let quote = ethers.utils.zeroPad(2, 4); // [ 0, 0, 0, 2 ]
  quote = ethers.utils.keccak256(quote);

  console.log('\x1b[34m%s\x1b[0m', 'Message1 to hash 🖋: ', quote);

  console.log('hashed Message: ', ethers.utils.arrayify(ethers.utils.hashMessage(quote)));
  console.log('hashed Message1 0x: ', ethers.utils.hashMessage(quote));

  const messagePrefix = '\x19Ethereum Signed Message:\n';
  const message = ethers.utils.toUtf8Bytes(quote);

  console.log(ethers.utils.toUtf8Bytes(messagePrefix));
  console.log(ethers.utils.toUtf8Bytes(String(message.length)));
  console.log(message);

  console.log(
    'ethers_hash ',
    ethers.utils.concat([
      ethers.utils.toUtf8Bytes(messagePrefix),
      ethers.utils.toUtf8Bytes(String(message.length)),
      message,
    ]),
  );

  const hashtest = ethers.utils.concat([
    ethers.utils.toUtf8Bytes(messagePrefix),
    ethers.utils.toUtf8Bytes(String(message.length)),
    message,
  ]);

  console.log(ethers.utils.keccak256(hashtest));
  console.log(ethers.utils.toUtf8Bytes(ethers.utils.keccak256(hashtest)));
}

main();
