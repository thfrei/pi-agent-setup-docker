# agent setup and web development environment

## Getting started

1. Download and install podman desktop: <https://podman-desktop.io/downloads>
2. Download or clone THIS repository.
3. Browse into the folder
4. Open terminal and type

    ```bash
    podman compose up --build
    ```

5. Go to <http://localhost:30141> for the agent
6. Go to <http://localhost:30142/?folder=/home/node/workspace> for teh editor

## Description

Applications inside

- <http://localhost:30141> Pi web agent
- <http://localhost:30142/?folder=/home/node/workspace> VS Code in the browser
- <http://localhost:8000> some test webpage
