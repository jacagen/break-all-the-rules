module BreakAllTheRules (breakRules) where

import Data.Monoid


breakRules :: [(Int,Int)] -> [[Int]]
breakRules rs =
    let rules   = formRules rs
        combos  = filterDups $ quicksort $ allCombinations $ allNumbers rs
    in filter (passesAll rules) combos


data Rule =  Rule
                    Int    -- must come first
                    Int     -- must come later
                deriving Show

formRules :: [(Int, Int)] -> [Rule]
formRules = fmap (\(x, y) -> Rule y x)

allNumbers :: [(Int, Int)] -> [Int]
allNumbers ps = ps >>= pair2List

pair2List :: (a, a) -> [a]
pair2List (x, y) = [x, y]

allCombinations :: [Int] -> [[Int]]
allCombinations [] = [[]]
allCombinations ns = [0..length ns - 1] >>= \i ->
    let (x, rest) = dropNth i ns
    in (x :) `fmap` allCombinations rest

dropNth :: Int -> [Int] -> (Int, [Int])
dropNth i ns = (ns !! i, [ n | (idx, n) <- zip [0..] ns, idx /= i ])

passes :: Rule -> [Int] -> Bool
passes (Rule first second) =
    let
        p   _           _           _       _       [] = True
        p   False       False       first   second  (n:ns)
            | n == first    = p True False first second ns
            | n == second   = False
            | otherwise     = p False False first second ns
        p   False       True        first   second  (n:ns)
            | n == first    = False
            | otherwise     = p False True first second ns
        p   True        False       first   second  (n:ns)
            | n == second   = p True True first second ns
            | otherwise     = p True False first second ns
        p   True        True        first   second  (n:ns)
            | n == first    = False
            | otherwise     = p True True first second ns
    in p False False first second

passesAll :: [Rule] -> [Int] -> Bool
passesAll rs ns = getAll $ foldMap (\r -> All (passes r ns)) rs

filterDups :: [[Int]] -> [[Int]]
filterDups []   = []
filterDups [ns] = [ns]
filterDups (n1 : n2 : ns)
    | n1 == n2  = filterDups (n2 : ns)
    | otherwise = n1 : filterDups (n2 : ns)

quicksort :: Ord a => [a] -> [a]
quicksort []     = []
quicksort (p:xs) = quicksort lesser ++ [p] ++ quicksort greater
    where
        lesser  = filter (< p) xs
        greater = filter (>= p) xs