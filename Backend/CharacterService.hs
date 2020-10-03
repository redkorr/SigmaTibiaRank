{-# LANGUAGE OverloadedStrings #-}
module CharacterService where

import Domain
import Network.HTTP.Simple (parseRequest,  getResponseBody, httpLBS )
import Data.Aeson (decode, eitherDecode, Object, (.:))
import Data.Map (Map, (!))
import Debug.Trace (trace)
import Data.Either
import Data.Either.Combinators
import Data.Aeson.Types 
import qualified Data.ByteString.Lazy as LB

getCharacter:: String-> IO (Maybe Character)
getCharacter nickname = do 
    initRequest <- parseRequest $ createApiLink nickname
    response <-  httpLBS $ initRequest
    return $ processBody $ getResponseBody response

processBody :: LB.ByteString -> Maybe Character
processBody body = rightToMaybe $ parseJson body

parseJson:: LB.ByteString -> Either String Character 
parseJson body = do 
    object <- eitherDecode body
    let parser = (\obj -> do
            allCharacters <- obj .: "characters" :: Parser Object 
            character <- allCharacters .: "data" :: Parser Character
            return character)
    parseEither parser object

createApiLink:: String -> String
createApiLink nickname = getConnectionString () ++ (replaceSpaceWithPlus nickname) ++ ".json"

replaceSpaceWithPlus:: String -> String 
replaceSpaceWithPlus str = 
    let repl ' ' = '+'
        repl x = x
    in map repl str


--todo get it from config
getConnectionString:: () -> String
getConnectionString () = "https://api.tibiadata.com/v2/characters/";
