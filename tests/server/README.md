<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Parse, verified and packaged by Elestio

[Parse](https://github.com/parse-community/parse-server) is an open source backend that can be deployed to any infrastructure that can run Node.js. Parse Server works with the Express web application framework. It can be added to existing web applications, or run by itself.

<img src="https://github.com/elestio-examples/parse/raw/main/parse.png" alt="parse" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/parse">fully managed parse</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want automated backups, reverse proxy with SSL termination, firewall, automated OS & Software updates, and a team of Linux experts and open source enthusiasts to ensure your services are always safe, and functional.

[![deploy](https://github.com/elestio-examples/parse/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/parse)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/parse.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create data folders with correct permissions

    mkdir -p ./data 
    chown -R 1001:1001 ./data

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:4040`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.3"
    services:
        mongo:
            image: mongo
            restart: always
            volumes:
                - ./data:/data/db

        parse:
            image: elestio4test/parse:${SOFTWARE_VERSION_TAG}
            restart: always
            ports:
                - 172.17.0.1:1337:1337
            links:
                - mongo
            environment:
                - PARSE_SERVER_APPLICATION_ID=${PARSE_SERVER_APPLICATION_ID}
                - PARSE_SERVER_MASTER_KEY=${MASTER_KEY}
                - PARSE_SERVER_DATABASE_URI=mongodb://mongo:27017/dev
                - PARSE_SERVER_START_LIVE_QUERY_SERVER=1
                - PARSE_SERVER_LIVE_QUERY={"classNames":["people","monitor"]}
                - PARSE_SERVER_MASTER_KEY_IPS=0.0.0.0/0

        dashboard:
            image: parseplatform/parse-dashboard:${SOFTWARE_VERSION_TAG}
            restart: always
            ports:
                - "172.17.0.1:4040:4040"
            environment:
                - PARSE_DASHBOARD_SERVER_URL=${BASE_URL}:1337/parse
                - PARSE_DASHBOARD_APP_ID=${PARSE_SERVER_APPLICATION_ID}
                - PARSE_DASHBOARD_MASTER_KEY=${MASTER_KEY}
                - PARSE_DASHBOARD_APP_NAME=MyApp
                - PARSE_DASHBOARD_ALLOW_INSECURE_HTTP=1
                - PARSE_DASHBOARD_USER_ID=${ADMIN_EMAIL}
                - PARSE_DASHBOARD_USER_PASSWORD=${ADMIN_PASSWORD}



# Maintenance

## Logging

The Elestio Parse Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/parse-community/parse-server">Parse Github repository</a>

- <a target="_blank" href="https://docs.parseplatform.org/parse-server/guide/#getting-started">Parse documentation</a>

- <a target="_blank" href="https://github.com/elestio-examples/parse">Elestio/parse Github repository</a>
