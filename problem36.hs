import Numeric (showIntAtBase)
import Data.Char (intToDigit)

isPalindrome :: String -> Bool
isPalindrome "" = True
isPalindrome [s] = True
isPalindrome (h:t) = (h == last t) && (isPalindrome $ init t)

toBinary :: Int -> String
toBinary n = showIntAtBase 2 intToDigit n ""

isSpecialPalindrome :: Int -> Bool
isSpecialPalindrome x = if (isPalindrome . show) x && (isPalindrome . toBinary) x then True else False

answer :: Int -> Int
answer maxN = sum [x | x <- [1..maxN-1], isSpecialPalindrome x]

