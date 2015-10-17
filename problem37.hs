import Data.Numbers.Primes

allThePrimes = primes
# Single-digit primes were not considered
almostAllThePrimes = filter (>10) allThePrimes

# These two truncatable prime functions could have been prettier
isTruncatablePrimeLeft :: String -> Bool
isTruncatablePrimeLeft "" = True
isTruncatablePrimeLeft whole@(_:t) = (isPrime (read whole :: Integer)) && isTruncatablePrimeLeft t

isTruncatablePrimeRight :: String -> Bool
isTruncatablePrimeRight "" = True
isTruncatablePrimeRight whole = (isPrime (read whole :: Integer)) && (isTruncatablePrimeRight $ init whole)

# Call as answer 0 almostAllThePrimes
answer :: Int -> [Integer] -> Integer
answer 11 sieve = 0
answer n (h:t) = let stringified = show h
                 in if (isTruncatablePrimeLeft stringified && isTruncatablePrimeRight stringified) 
                    then (h + answer (n+1) t) 
                    else (answer n t)

