module Domain where
import Data.Aeson

data Character = Character String Int
    deriving (Show, Eq)


instance FromJSON Character where
    parseJSON (Object v) = Character <$> 
                                        v .: "name" <*>
                                        v .: "level"


instance ToJSON Character where
    toJSON (Character name level) =
        object["name" .= name, "level" .= level]