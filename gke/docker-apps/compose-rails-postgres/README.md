# README

This is a rails app created locally and ran with docker-compose.

Non capisco una fava. Funziona da Dio se non ci faccio nessun cambiamento.
Ma se lancio una migrazione via docker-composer qualcosa di strano succede:

    1. Il codice cambia in docker ma cambia anche localmente (wow! Unexoected but wow)
    2. Ogni volta che runno la roba, mi torna senza la migrazione, db/schema e app/ perde
       la mia migrazione.

Ora provo la migrazione da codice "esterno" vediamo. 

# Migrations

	1. TODo
	Scaffolds
    2.
    # https://stackoverflow.com/questions/20082002/migrations-are-pending-run-bin-rake-dbmigrate-rails-env-development-to-resol/20635252
    rails generate model Homepage first_name:string  last_name:string email:string message:text
    rails generate scaffold HighScore game:string score:integer