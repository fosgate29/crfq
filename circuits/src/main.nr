
fn main(
  quote1: u32,
  quote2: u32,
  quote3: u32,
  quote: pub u32
) {

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
    main(1, 2, 3, 1);
    main(4, 2, 5, 2);
    main(34, 33, 21, 21);
    main(50, 50, 50, 50);
    main(250, 50, 50, 50);
    // Uncomment to make test fail
    //  main(4, 3, 1, 0); // quote cant be 0
    //  main(4, 3, 1, 3); // quote cant be bigger than one of the  inputs
    //  main(4, 3, 2, 1); // quote cant be different of quote1, quote2 or quote3
}
