{-# LANGUAGE OverloadedStrings #-}
module CharacterService where

import Domain
import Network.HTTP.Simple (parseRequest,  getResponseBody, httpLBS )
import Data.Aeson (decode)

getCharacter:: String-> IO (Maybe Character)
getCharacter nickname = do 
    initRequest <- parseRequest $ createApiLink nickname
    response <-  httpLBS $ initRequest
    let character= decode $ getResponseBody response :: Maybe Character 
    return character

createApiLink:: String -> String
createApiLink nickname =  replaceSpaceWithPlus nickname

replaceSpaceWithPlus:: String -> String 
replaceSpaceWithPlus str = 
    let repl ' ' = '+'
        repl x = x
    in map repl str


getConnectionString:: () -> String
getConnectionString () = "https://api.tibiadata.com/v2/characters/.json";
