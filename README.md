# Docker PHP Developer Environment  

![Image](https://user-images.githubusercontent.com/326840/142689359-15b3cbc6-a75f-4aa2-89fe-13773d3e838f.png)


## Ports

Ports used in the project:  
| Software | Port |  
|-------------- | -------------- |  
| **nginx** | 80 |  
| **phpmyadmin** | 8081 |  
| **postgres** | 5432 |  
| **pgadmin** | 5050 |  
| **mysql** | 3306 |  
| **php** | 9000 |  
| **xdebug** | 9003 |  
| **redis** | 6379 |  
| **rediscommander** | 8081 |  
| **mailhog** | 8025, 1025 |  
| **dozzle** | 9999 |  
| **yacht** | 19000 |  

## Use

To get started, make sure you have [Docker installed](https://docs.docker.com/) on your system and [Docker Compose](https://docs.docker.com/compose/install/), and then clone this repository.

1. Clone this project:

   ```sh
   git clone https://github.com/beeyev/Docker-PHP-Developer-Environment.git
   ```

2. Inside the folder `Docker-PHP-Developer-Environment` create your own `.env` to docker compose with the next command:

   ```sh
   cp .env.example .env
   ```

3. You need **Create** or **Put** your PHP based project in the folder source;

4. Build the project using the next commands:

   ```sh
   make up
   ```
---
