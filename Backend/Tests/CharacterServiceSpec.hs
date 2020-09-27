module CharacterServiceSpec (spec) where

import Test.Hspec
import CharacterService (replaceSpaceWithPlus, getConnectionString, getCharacter)
import Domain

spec :: Spec
spec = do
  describe "replace spaces with pluses" $ do
    it "replaces all spaces with pluses on character with two part name" $ do
      let name = "Von Vir"
      replaceSpaceWithPlus name `shouldBe` "Von+Vir"

  describe "get connection string" $ do
    it "should return non empty string" $ do
      getConnectionString () `shouldSatisfy` (>0) . length

  
  -- integration tests
  describe "character service on searching for vonvir" $ do
    it "should return character named vonvir" $ do
      let name = "Vonvir"
      getCharacter name `shouldReturn` (Just $ Character "Vonvir" 130)
