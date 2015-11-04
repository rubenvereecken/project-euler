import Numeric (showIntAtBase)
import Data.Char (intToDigit)

-- Even after implementing this a hundred times
isPalindrome :: String -> Bool
isPalindrome "" = True
isPalindrome [s] = True
isPalindrome (h:t) = (h == last t) && (isPalindrome $ init t)

toBinary :: Int -> String
toBinary n = showIntAtBase 2 intToDigit n ""

-- A number is a special palindrome if it's a palindrome it base 2 and 10
isSpecialPalindrome :: Int -> Bool
isSpecialPalindrome x = if (isPalindrome . show) x && (isPalindrome . toBinary) x then True else False

answer :: Int -> Int
answer maxN = sum [x | x <- [1..maxN-1], isSpecialPalindrome x]

