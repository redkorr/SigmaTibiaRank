module CharacterServiceSpec (spec) where

import Test.Hspec
import CharacterService (replaceSpaceWithPlus)

spec :: Spec
spec = do
  describe "replace spaces with pluses" $ do
    it "replaces all spaces with pluses on character with two part name" $ do
      let name = "Von Vir"
      replaceSpaceWithPlus name `shouldBe` "Von+Vir"

-- spec2 :: Spec
-- spec2 = do
--   describe "boo" $ do
--     it "testing" $ do
--       2 `shouldBe` 2