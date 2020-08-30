
module CharacterService where

import Domain
import Network.HTTP.Simple
import Data.Aeson (decode)
getVonvir:: ()-> IO (Maybe Character)
getVonvir () = do 
    response <-  httpLBS "https://api.tibiadata.com/v2/characters/vonvir.json"
    let character= decode $ getResponseBody response :: Maybe Character 
    return character
