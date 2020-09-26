{-# LANGUAGE OverloadedStrings #-}
module Main where 
import CharacterService ( getCharacter )
import Data.Pool (createPool)
import Database.PostgreSQL.Simple (close)
import Db
    ( newConn, DbConfig(DbConfig, dbName, dbUser, dbPassword) )
import Views ( viewVonvir )
import Web.Scotty ( get, scotty )
import Control.Monad.IO.Class (MonadIO(liftIO))


main :: IO ()
main = do
  let dbConf = Just Db.DbConfig {dbName = "psql", dbUser = "postgres", dbPassword = "postgres"}
  case dbConf of
    Nothing -> putStrLn "no config"
    Just conf -> do
      pool <- createPool (newConn conf) close 1 40 10
      scotty 3000 $ do
        get "/vonvir" $
          do
            vonvir <- liftIO $ getCharacter "vonvir" 
            viewVonvir $ vonvir 