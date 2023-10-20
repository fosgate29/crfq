use dep::std;
use dep::ecrecover;

fn main(
  quote1: u32,
  quote2: u32,
  quote3: u32,
  quote: pub u32,
  pub_key_x: [u8; 32],
  pub_key_y: [u8; 32],
  hashed_message: [u8; 32],
  signature: [u8; 64]
) {

  //std::println(hashed_message);
 // std::println(quote);

  //let x = [1];
  //let hash = std::hash::keccak256(x,1);
  //std::println(hash);


  ecrecover::ecrecover(pub_key_x, pub_key_y, signature, hashed_message);

  // Quotes must be greater than zero
  assert(quote1 > 0);
  assert(quote2 > 0);
  assert(quote3 > 0);
  assert(quote > 0);

  // selected quote is the smallest one
  assert(quote <= quote1);
  assert(quote <= quote2);
  assert(quote <= quote3);

  // selected quote is equal of at least one input quotes
  let mut winnerQuote: u32 = 0;
  if quote == quote1 {
    winnerQuote = quote1;
  }
  else if quote == quote2{
    winnerQuote = quote2;
  }
  else if quote == quote3 {
    winnerQuote = quote3;
  }
  assert(quote == winnerQuote);

}

#[test]
fn test_main() {

    let pub_key_x = [131, 24, 83, 91, 84, 16, 93, 74, 122, 174, 96, 192, 143, 196, 95, 150, 135, 24, 27, 79, 223, 198, 37, 189, 26, 117, 63, 167, 57, 127, 237, 117];
    let pub_key_y = [53, 71, 241, 28, 168, 105, 102, 70, 242, 243, 172, 176, 142, 49, 1, 106, 250, 194, 62, 99, 12, 93, 17, 245, 159, 97, 254, 245, 123, 13, 42, 165];
    let signature = [57, 17, 112, 239, 241, 30, 64, 157, 170, 50, 85, 145, 156, 69, 226, 85, 147, 164, 10, 82, 71, 93, 42, 132, 200, 220, 161, 255, 95, 241, 211, 141, 81, 7, 150, 25, 25, 27, 162, 213, 80, 61, 12, 170, 50, 4, 154, 203, 252, 229, 119, 29, 202, 153, 50, 25, 126, 145, 245, 23, 136, 75, 29, 177];
    let hashed_message = [13, 82, 120, 60, 76, 186, 215, 235, 175, 126, 185, 67, 252, 100, 143, 82, 130, 165, 32, 112, 68, 47, 193, 141, 141, 209, 109, 219, 47, 203, 175, 102];

    main(1, 2, 3, 1, pub_key_x,pub_key_y, hashed_message, signature);
    //main(4, 2, 5, 2);
  //  main(34, 33, 21, 21);
   // main(50, 50, 50, 50);
  //  main(250, 50, 50, 50);
    // Uncomment to make test fail
    //  main(4, 3, 1, 0); // quote cant be 0
    //  main(4, 3, 1, 3); // quote cant be bigger than one of the  inputs
    //  main(4, 3, 2, 1); // quote cant be different of quote1, quote2 or quote3
}
