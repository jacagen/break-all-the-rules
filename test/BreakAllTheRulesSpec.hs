module BreakAllTheRulesSpec (main, spec) where

import Test.Hspec
import Test.QuickCheck

import BreakAllTheRules (breakRules)

-- `main` is here so that this module can be run from GHCi on its own.  It is
-- not needed for automatic spec discovery.
main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  it "Example tests" $ do
    breakRules [(1,2)] `shouldBe` [ [2,1] ]
    breakRules [(1,2),(2,3)] `shouldBe` [ [3,2,2,1] ]
    breakRules [(1,2),(3,4)] `shouldBe` [ [2,1,4,3], [2,4,1,3], [2,4,3,1], [4,2,1,3], [4,2,3,1], [4,3,2,1] ]
    breakRules [(1,2),(2,3),(3,1)] `shouldBe` []
    breakRules [(1,2),(2,3),(5,6)] `shouldBe` [ [3,2,2,1,6,5], [3,2,2,6,1,5], [3,2,2,6,5,1], [3,2,6,2,1,5], [3,2,6,2,5,1]
                                              , [3,2,6,5,2,1], [3,6,2,2,1,5], [3,6,2,2,5,1], [3,6,2,5,2,1], [3,6,5,2,2,1]
                                              , [6,3,2,2,1,5], [6,3,2,2,5,1], [6,3,2,5,2,1], [6,3,5,2,2,1], [6,5,3,2,2,1] ]
    breakRules [(1,2),(2,3),(5,1)] `shouldBe` [ [3,2,2,1,1,5] ]