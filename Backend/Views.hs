module Views where

import Domain
import Web.Scotty

viewVonvir :: Maybe Character -> ActionM()
viewVonvir Nothing= json()
viewVonvir (Just character) = json character