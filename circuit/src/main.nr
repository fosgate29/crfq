use dep::std;
use dep::ecrecover;

fn main(
  quote1: u32,
  quote2: u32,
  quote3: u32,
  winner_quote: pub u32,
  pub_key_x_1: [u8; 32],
  pub_key_y_1: [u8; 32],
  signature_1: [u8; 64],
  hashed_message_quote1: [u8; 32],
  pub_key_x_2: [u8; 32],
  pub_key_y_2: [u8; 32],
  signature_2: [u8; 64],
  hashed_message_quote2: [u8; 32],
  pub_key_x_3: [u8; 32],
  pub_key_y_3: [u8; 32],
  signature_3: [u8; 64],
  hashed_message_quote3: [u8; 32]
) {

  // check signatures
  //
  // TODO
  //
  // quote1, quote2 and quote3 must be part of the signatures but we couldn't implemented
  // using Noir. It needed to be hashed inside the circuit and then we would verify the signature
  // but we had problems hashing quotes. One problem was that keccak256 receives bytes and
  // quote1, quote2 and quote3 were u32 type. And since we used ethers to sign messages,
  // it added prefix \x19Ethereum Signed Message:\n32 and we couldn't get the same hash ethers were generating
  // compared with the hash the circuit generated.
  let address1 = ecrecover::ecrecover(pub_key_x_1, pub_key_y_1, signature_1, hashed_message_quote1);
  let address2 = ecrecover::ecrecover(pub_key_x_2, pub_key_y_2, signature_2, hashed_message_quote2);
  let address3 = ecrecover::ecrecover(pub_key_x_3, pub_key_y_3, signature_3, hashed_message_quote3);

  // Quotes must be greater than zero
  assert(quote1 > 0);
  assert(quote2 > 0);
  assert(quote3 > 0);
  assert(winner_quote  > 0);

  // selected winner_quote is the smallest one
  assert(winner_quote <= quote1);
  assert(winner_quote <= quote2);
  assert(winner_quote <= quote3);

  // selected winner_quote is equal of at least one input quotes
  let mut winnerQuote: u32 = 0;
  if winner_quote == quote1 {
    winnerQuote = quote1;
  }
  else if winner_quote == quote2{
    winnerQuote = quote2;
  }
  else if winner_quote == quote3 {
    winnerQuote = quote3;
  }
  assert(winner_quote== winnerQuote);

}


#[test]
fn test_main() {

let signature1 = [
  152,  63, 237,  31, 219, 133, 235,  68, 141,  79,  0,
  132, 214, 142, 191,   7, 237, 202, 119,  79, 240, 41,
   84,  96,  70,  49,  16, 239, 172,   3,  28,  18, 46,
   88,  40,  22,  85, 230, 138, 162, 110, 101, 161, 46,
  101,  73, 240, 227, 175,  26, 160, 189, 223, 128, 45,
   90, 136, 198, 140, 182, 210,  87,  40, 245
];
let signature2 =[
    6, 141, 113, 200, 233,   9, 200,   1,  94,  84,   4,
  217,   6, 105, 203, 230, 208, 199, 249,  29,  11, 235,
  125, 252,  32,  95, 213,  82, 204, 135, 218,  17,  49,
  209, 229,  59,  90, 143, 230,   7, 152,  18,  29, 130,
  155, 112,  63, 212,  29,  88, 226,  88, 132, 175,  75,
  166, 180, 255,   9,  61, 156, 254, 235,   0
];
let signature3 = [
   10, 208, 133, 189, 103,  86, 187, 216,  59,  93, 157,
   34, 137, 249,   7,   0, 169,  48,  16, 187,   9,  51,
  167, 112,  36,  54, 171, 236, 102,  51,  13,  23,  34,
  170, 200, 117, 242,   9, 234, 118, 181,  47,   5,  57,
  239, 171, 250, 130, 161, 192,   3, 128,   1, 136,  76,
   13, 246,  25,  90, 254,  42, 175,  21,  88
];

let hashedMessage1= [
   77,  38,  53, 141, 198, 185, 201,  97,
  188, 155, 189, 210, 212,   6, 192, 177,
  204, 222, 136,  78, 167,  73, 102, 144,
  180,  38,  71, 151,  72,  18, 228,  88
];
let hashedMessage2= [
   77, 125, 248,  68, 156, 156,  60,  36,
   11,   9,  27,  31, 102,  96, 167, 101,
  147, 231, 118,  98, 237, 209, 239, 160,
   14,  93, 130, 102,   9,  65,  82,   8
];
let hashedMessage3= [
  50, 127, 180, 145, 213,  47, 235, 110,
  24, 104, 181,  29, 158, 132, 229,  64,
  97, 169,  56,  49, 148, 146, 128, 106,
  23,  26, 141, 133, 138, 119,  79,  60
];

let publickeyx1 =  [
  131,  24, 83,  91,  84,  16,  93,  74,
  122, 174, 96, 192, 143, 196,  95, 150,
  135,  24, 27,  79, 223, 198,  37, 189,
   26, 117, 63, 167,  57, 127, 237, 117
];
 
let publickeyy1 =  [
   53,  71, 241,  28, 168, 105, 102,  70,
  242, 243, 172, 176, 142,  49,   1, 106,
  250, 194,  62,  99,  12,  93,  17, 245,
  159,  97, 254, 245, 123,  13,  42, 165
];

let publickeyx2 = [
  186,  87,  52, 216, 247,   9,  23,  25,
   71,  30, 127, 126, 214, 185, 223,  23,
   13, 199,  12, 198,  97, 202,   5, 230,
  136,  96,  26, 217, 132, 240, 104, 176
];

let publickeyy2=  [
  214, 115,  81, 229, 240,  96, 115,   9,
   36, 153,  51, 106, 176, 131, 158, 248,
  165,  33, 175, 211,  52, 229,  56,   7,
   32,  95, 162, 240, 142, 236, 116, 244
];

let publickeyx3 = [
  36,   7, 253, 167, 151,  70,  85, 173,
  95,  88,   9, 244,  87,  85, 167, 141,
  46, 118,  93,  58,  91, 229, 130, 196,
  19,  67,  48,  99, 169,  65, 149,  29
];

let publickeyy3 = [
    2, 134,  36, 207, 113, 209,  74,  28,
  171,  29,  79,  46, 232,  84, 166, 244,
  217, 172, 241, 251,  75, 120,  74,   7,
  171,  20,  69, 133, 146, 134,  63, 159
];

    // quote1 is the winner quote
    main(1, 2, 3, 1, publickeyx1, publickeyy1, signature1, hashedMessage1, publickeyx2, publickeyy2, signature2, hashedMessage2, publickeyx3, publickeyy3, signature3, hashedMessage3);
    
    // quote2 is the winner quote
    main(4, 2, 5, 2, publickeyx1, publickeyy1, signature1, hashedMessage1, publickeyx2, publickeyy2, signature2, hashedMessage2, publickeyx3, publickeyy3, signature3, hashedMessage3);
    
    // quote 3 is the winner quote
    main(34, 33, 21, 21, publickeyx1, publickeyy1, signature1, hashedMessage1, publickeyx2, publickeyy2, signature2, hashedMessage2, publickeyx3, publickeyy3, signature3, hashedMessage3);
    
    // all quote are the same and the smallest one is quote 1 as the winner (default)
    main(50, 50, 50, 50, publickeyx1, publickeyy1, signature1, hashedMessage1, publickeyx2, publickeyy2, signature2, hashedMessage2, publickeyx3, publickeyy3, signature3, hashedMessage3);
    
    // if 2 quotes are equal, is a valid one
    main(250, 50, 50, 50, publickeyx1, publickeyy1, signature1, hashedMessage1, publickeyx2, publickeyy2, signature2, hashedMessage2, publickeyx3, publickeyy3, signature3, hashedMessage3);

    // Uncomment to make test fail
    //  main(4, 3, 1, 0); // winner_quote cant be 0
    //  main(4, 3, 1, 3); // winner_quote cant be bigger than one of the  inputs
    //  main(4, 3, 2, 1); // winner_quote cant be different of quote1, quote2 or quote3
}
