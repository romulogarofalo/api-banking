# ApiBanking

:scroll: A backend to create account, make transfers between accounts and get reports of how much transfers and total has been transfered


## Table of Contents
- [Introduction](#introduction)
- [Technology](#technology)
- [Getting Started](#getting-started)
  - [Running Locally](#running-locally)
  - [Running Tests](#running-tests)
- [Available Routes](#available-routes)
- [All Tasks](#tasks)
- [Useful Links](#useful-links)  
  


## Introduction
  *Api_banking it's A backend to create account, make transfers between accounts and get reports of how much transfers and total has been transferred

## Technology
What was used:
- **[Docker](https://docs.docker.com)** and **[Docker Compose](https://docs.docker.com/compose/)** to create our development and test environments.
- **[Github Actions](https://github.com/features/actions)** to make the automated tests CI.
- **[Postgresql](https://www.postgresql.org/)** to store the data.
- **[Elixir](https://elixir-lang.org/)** language.
- **[Phoenix](https://www.phoenixframework.org/)** web framework used.


## Getting Started
To get started, you should install **Docker** and **Docker Compose**.
or to run localy, you should install **Elixir** and **Phoenix**
Then, clone the repository:
```sh
$ git clone https://github.com/romulogarofalo/api-banking.git
```
You should run 
```
mix deps.get
```
to install all the dependencies
# Running Locally
To run locally, simply run the following command:
```sh
$ mix phx.server
```
# Running Tests
To run the tests, run the following command:
```sh
$ mix test
```
# Running on docker
To run the application on docker we need to change the ``` hostname: "db"``` in our `config/dev.ex` after that we can build
```sh
$ docker-compose build
```
now we can run our docker
```sh
$ docker-compose up
```

## Available Routes

Routes

| Rotas                  | Descrição                                  | Metodos HTTP |
|------------------------|--------------------------------------------|--------------|
|/api/login              | login route and auth                       | POST         |
|/api/signup             | register of new user                       | POST         |
|/api/transaction        | create a new transfer                      | POST         |
|/api/withdraw           | create a withdraw                          | POST         |
|/api/reports            | only ADM can use to get the reports        | GET          |
[for more datails here the link for Postman docs](https://documenter.getpostman.com/view/1994420/TVYDdJvF)

## database schema

![database_schema](https://github.com/romulogarofalo/api-banking/blob/main/images/database%20api%20banking.png)

## Useful Links
[Linter used (credo)](https://github.com/rrrene/credo)  
[commit pattern used](https://gitmoji.carloscuesta.me/)


