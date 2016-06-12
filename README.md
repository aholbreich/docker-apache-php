
Docker image to run PHP applications on Apache2 Server

## Hello World

Start apache-php with binding the external ports 80:

    docker run -d -p 80:80 gold/apache-php

## Features

* Module support
  * curl
  * gd
  * pear
  * apc
  * mememcached
* Enabled .htaccess support


## Create Dockerfile with custom PHP application

This image can be used as a base image for your PHP application.
Considering your applicatin code is inside **/app folder**...

Create a new `Dockerfile` in your PHP application folder with the following contents:

    FROM gold/apache-php

After that, build the new `Dockerfile`:

    docker build -t username/my-app .

And test it:

    docker run -d -p 80:80 username/my-app

That's it!
Alternatively you can do test like this just by execute `make` in test subfolder of checkout project.
