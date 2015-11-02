## mercury-examples

[Mercury](https://en.wikipedia.org/wiki/Mercury_%28programming_language%29) is a *purely* declarative logic programming language influenced by Prolog and Haskell. You can download and install it from the project website [http://mercurylang.org](http://mercurylang.org).

The present repository contains some basic examples illustrating this language. To compile a *.m file, execute: 

   ```
   mmc -O2 -j4 filename.m
   ```

After that run the binary `./filename`.

## Contents

- `dialogue.m` shows how to handle basic IO (stdin/stdout).

- `fibonacci.m` defines a computation of Fibonacci numbers.

- `mapFilt.m` implements in terms of logic programming an analogue of the Haskell operators `map`, `foldr`, and `filter`. 