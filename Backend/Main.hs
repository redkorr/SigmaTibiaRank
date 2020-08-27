{-# LANGUAGE OverloadedStrings #-}

import Domain
import Db
import Views
import Web.Scotty
import Data.Pool (createPool)
import Database.PostgreSQL.Simple (close)

main :: IO ()
main= do
let dbConf=  Just Db.DbConfig {dbName= "psql", dbUser= "postgres", dbPassword= "postgres"} 
case dbConf  of
  Nothing -> putStrLn "no config"
  Just conf -> do
    pool <- createPool (newConn conf) close 1 40 10
    scotty 3000 $ do
    get "/vonvir" $ do
     viewVonvir $ Just $ Character "test" 1
