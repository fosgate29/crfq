use dep::std;
use dep::ecrecover;

use dep::std::collections::vec::Vec;

fn main(
  winner_quote: pub u32,
  message_prefix: [u8; 28],
  hashed_message_quote_input: [u8; 32]
) {

  // convert quote to bytes
  // [ 0, 0, 0, 2 ]
  let quote_bytes = u32_to_bytes(2);
  let hash_quote = std::hash::keccak256(quote_bytes, 4);

  std::println(hash_quote); // should be equal to 0x2ee5f854d076701c8753d72779187e404f9b2fb705c495137d78551250314a46

  let mut concatenatedMessage: [u8; 94] = [0; 94]; // Create a new array to hold the result

  for i in 0..message_prefix.len() {
    concatenatedMessage[i] = message_prefix[i];
  }

  for i in 0..hash_quote.len() {
    concatenatedMessage[i + message_prefix.len()] = hash_quote[i];
  }

  std::println(concatenatedMessage);

  let hashed_message_quote = std::hash::keccak256(concatenatedMessage, 60);

  // bytes for message_prefix + length + message hashed
  let ethers_hash = [
   25,  69, 116, 104, 101, 114, 101, 117, 109, 32,  83, 105,
  103, 110, 101, 100,  32,  77, 101, 115, 115, 97, 103, 101,
   58,  10,  54,  54,  48, 120,  50, 101, 101, 53, 102,  56,
   53,  52, 100,  48,  55,  54,  55,  48,  49, 99,  56,  55,
   53,  51, 100,  55,  50,  55,  55,  57,  49, 56,  55, 101,
   52,  48,  52, 102,  57,  98,  50, 102,  98, 55,  48,  53,
   99,  52,  57,  53,  49,  51,  55, 100,  55, 56,  53,  53,
   49,  50,  53,  48,  51,  49,  52,  97,  52, 54
  ];

  let hashed_message_keccak256 = std::hash::keccak256(ethers_hash, 94);

  // 0x96089186c527abc46761516e289bdc598c34d1cef4de4db7a6f667c39a29982e
  std::println(hashed_message_keccak256);

  let hash_result_ethers = [
  48, 120,  57, 54,  48,  56,  57, 49,  56,  54, 99,  53,
  50,  55,  97, 98,  99,  52,  54, 55,  54,  49, 53,  49,
  54, 101,  50, 56,  57,  98, 100, 99,  53,  57, 56,  99,
  51,  52, 100, 49,  99, 101, 102, 52, 100, 101, 52, 100,
  98,  55,  97, 54, 102,  54,  54, 55,  99,  51, 57,  97,
  50,  57,  57, 56,  50, 101
];

//assert(hashed_message_keccak256 == hash_result_ethers);
//assert(hashed_message_quote_input == hashed_message_keccak256);


}

#[test]
fn test_main() {

  let hashedMessage1= [
    77,  38,  53, 141, 198, 185, 201,  97,
    188, 155, 189, 210, 212,   6, 192, 177,
    204, 222, 136,  78, 167,  73, 102, 144,
    180,  38,  71, 151,  72,  18, 228,  88
  ];

  let message_prefix = [
    25,  69, 116, 104, 101, 114, 101,
    117, 109,  32,  83, 105, 103, 110,
    101, 100,  32,  77, 101, 115, 115,
    97, 103, 101,  58,  10, 54 ,  54
  ];

  // quote1 is the winner quote
  main(2, message_prefix, hashedMessage1);
}

fn u32_to_bytes(value: u32) -> [u8; 4] {
    [
        ((value >> 24) & 0xFF) as u8,
        ((value >> 16) & 0xFF) as u8,
        ((value >> 8) & 0xFF) as u8,
        (value & 0xFF) as u8,
    ]
}
