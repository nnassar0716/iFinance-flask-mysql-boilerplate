## Project Overview - iFinance

Our goal for this project was to create an app that could help users keep track of the way they are using their money. The app allows for users to enter in information about their daily transactions so that they can then view their spending habits in a more clear way. Users are able to specify for what purpose a transaction was made, how much it was for, when it took place, and other details about the transactions they make. This ensures that users always have an explicitly detiled account of all their finances that have been logged, as well as having an easy way to visually see the ways they are spending their money.



## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 




