module Examples.Utils where

import Syntax

num :: Int -> Arith String
num 0 = Z
num n = S (num (n - 1))