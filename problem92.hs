import Data.Char(digitToInt)

sumSquareDigits "" = 0
sumSquareDigits (h:t) = (digitToInt h)^2 + sumSquareDigits t

endsIn89 :: Int -> Bool
endsIn89 89 = True
endsIn89 1 = False
endsIn89 x = endsIn89 $ sumSquareDigits $ show x

answer :: Int -> Int
answer maxN = sum [1 | x <- [2..maxN-1], x /= 89, endsIn89 x]


