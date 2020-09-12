{-# OPTIONS_GHC -F -pgmF hspec-discover #-}

myTest= TestCase(assertEqual "yikes" 1 1)

test=TestList [TestLabel "myTest j" myTest]
