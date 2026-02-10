module Examples.Utils where

import Syntax
import Variables

num :: Int -> Arith Vars
num 0 = Z
num n = S (num (n - 1))