# README

This is an study website that fetchs POKEAPI https://pokeapi.co/docs/v2 for pokemon info, whilst getting user input in order to search for pokemon id or pokemon name.
I am using Ruby On Rails, so in order to test anything you need to have Ruby 3.1.4 installed, and run bundle install on the pokeRuby directory, after everything is installed, run rails s on the terminal (need to be in pokeRuby dir)

Before Running it, you should know:

JWTs need to be created with a secret key that is private. It shouldn’t be revealed to the public. When we receive a JWT from the client, we can verify it with that secret key stored on the server.

We can generate a secret by typing the following in the terminal:

bundle exec rails secret
We will then add it to the encrypted credentials file so it won’t be exposed:

#VSCode
EDITOR='code --wait' rails credentials:edit
Then we add a new key: value in the encrypted .yml file.

# Other secrets...

# Used as the base secret for Devise-JWT

devise_jwt_secret_key: (copy and paste the generated secret here)

After saving the file, close it on your editor and you should be good to go
