-- A02

main :: IO ()
main = do
  [_, x] <- map (read :: String -> Int) . words <$> getLine
  as <- map (read :: String -> Int) . words <$> getLine
  putStrLn $ if x `elem` as then "Yes" else "No"
