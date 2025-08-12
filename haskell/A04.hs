-- A04

import Numeric (showIntAtBase)
import Data.Char (intToDigit)

main :: IO ()
main = do
  n <- readLn
  let binary = showIntAtBase 2 intToDigit n ""
  putStrLn $ replicate (10 - length binary) '0' ++ binary
