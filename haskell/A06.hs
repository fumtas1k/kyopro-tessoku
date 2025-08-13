-- A06

import Control.Monad (replicateM_)
import qualified Data.Vector.Unboxed as V

main :: IO ()
main = do
  [_, q] <- map (read :: String -> Int) . words <$> getLine
  as <- map (read :: String -> Int) . words <$> getLine
  let csum = V.fromList $ scanl (+) 0 as
  replicateM_ q $ do
    [l, r] <- map (read :: String -> Int) . words <$> getLine
    print $ (csum V.! r) - (csum V.! (l - 1))
