## pet rest-api

## Prerequisites
This needs to have git and docker installed.

## Installation 

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/your-repository.git
```

Open the terminal in this directory and run:

```
$ docker-compose up -d --build
```

or build the container with web-terminal installed from ZPM:

```
docker-compose -f "docker-compose-zpm-webterminal.yml" up -d --build
```

## How to Load data

Open terminal and call 
```
do ##class(Disript.Pet).LoadData()
```
This will load data from /pet-data/Pet-Activity.csv or provide another csv

# Consume data via REST

If you build the container locally it creates web app /pet which gives you percentage on request pet/id

Or you can setup the REST web manually and put the Disrupt.Pet as dispatch class.


## How to start coding
This repository is ready to code in VSCode with ObjectScript plugin.
Install [VSCode](https://code.visualstudio.com/) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugin and open the folder in VSCode.
Open /src/cls/PackageSample/ObjectScript.cls class and try to make changes - it will be compiled in running IRIS docker container.

Feel free to delete PackageSample folder and place your ObjectScript classes in a form
/src/cls/Package/Classname.cls

The script in Installer.cls will import everything you place under /src/cls into IRIS.

## What's insde the repo

# Dockerfile

The simplest dockerfile to start IRIS and load ObjectScript from /src/cls folder
Use the related docker-compose.yml to easily setup additional parametes like port number and where you map keys and host folders.

# Dockerfile-zpm

Dockerfile-zpm builds for you a container which contains ZPM package manager client so you are able to install packages from ZPM in this container

# Dockerfile-zpm-webterminal
Dockerfile-zpm-webterminal helps to have a container with ZPM and some preloaded ZPM packages, like webterminal


# .vscode/settings.json

Settings file to let you immedietly code in VSCode with [VSCode ObjectScript plugin](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript))

# .vscode/launch.json
Config file if you want to debug with VSCode ObjectScript
