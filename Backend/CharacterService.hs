{-# LANGUAGE OverloadedStrings #-}
module CharacterService where

import Domain
import Network.HTTP.Simple (parseRequest,  getResponseBody, httpLBS )
import Data.Aeson (decode, eitherDecode, Object, (.:))
import Data.Map (Map, (!))
import Debug.Trace (trace)
import Data.Aeson.Types 
import qualified Data.ByteString.Lazy as LB

getCharacter:: String-> IO (Maybe Character)
getCharacter nickname = do 
    initRequest <- parseRequest $ createApiLink nickname
    response <-  httpLBS $ initRequest
    let responseBody =  processBody $ getResponseBody response
    let character= decode $ trace ("haskell jest pojebany" ++ show responseBody) responseBody :: Maybe ( Character) 
    return $ character 

processBody :: LB.ByteString -> LB.ByteString
processBody body = trace ( "ja prdle: " ++ show (doShit body)) body

doShit:: LB.ByteString -> Either String String 
doShit body = do 
    object <- eitherDecode body
    let parser = (\obj -> do
            characters <- obj .: "characters"
            mdata <- characters.: "data"
            name <- mdata .: "name"
            return name)
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
