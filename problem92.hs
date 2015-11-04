import Data.Char(digitToInt)
import Data.Function.Memoize(memoize)

-- This one is slower because of all the type conversions
-- Still, I couldn't find an easy way to have a String -> Int map
-- that lazily generates the strings I need.
sumSquareDigitsSlow = (map sums [0..] !!)
  where sums 0 = 0
        sums x = let stringified = show x
                     lastbit = tail stringified
                 in (digitToInt (head stringified))^2 + 
                 if lastbit == "" then 0
                 else sumSquareDigitsSlow (read (tail stringified) :: Int)

sumSquareDigitsString "" = 0
sumSquareDigitsString (h:t) = (digitToInt h)^2 + sumSquareDigitsString t

sumSquareDigitsMem x = (memoize sumSquareDigitsString) x

endsIn89 :: Int -> Bool
endsIn89 89 = True
endsIn89 1 = False
endsIn89 x = endsIn89 $ sumSquareDigitsMem $ show x

endsIn89mem x = (memoize endsIn89) x

-- For some reason my own memoized version is slower than using 
-- the library memoize function
endsIn89slow = (map ends [0..] !!)
  where ends 0 = False
        ends 1 = False
        ends 89 = True
        ends x = endsIn89slow $ sumSquareDigitsMem $ show x


answer :: Int -> Int
answer maxN = sum [1 | x <- [2..maxN-1], endsIn89mem x]
