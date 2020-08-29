
module CharacterService where

import Domain
import Network.HTTP.Simple
getVonvir:: ()-> IO (Maybe Character)
getVonvir () = do 
    response <- httpLBS "https://api.tibiadata.com/v2/characters/vonvir.json"
    return $ Just $ Character "vonvir" 1
