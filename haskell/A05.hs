-- A05

main :: IO ()
main = do
  [n, k] <- map (read :: String -> Int) . words <$> getLine
  print $ length [() | x <- [1..n], y <- [1..n], let z = k - (x + y), z > 0, z <= n]
