# BCIS_Okanagan
# BCIS_Okanagan

## Table of Contents
- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Running the Application](#running-the-application)
- [Accessing Jupyter Lab](#accessing-jupyter-lab)
- [Pushing Changes to GitHub](#pushing-changes-to-github)
- [Troubleshooting](#troubleshooting)

## Introduction
This project sets up a PostgreSQL database and a Jupyter Lab environment using Docker. The Jupyter Lab environment is configured to work with Python libraries such as `yfinance`, `sqlalchemy`, `pandas`, `matplotlib`, and `seaborn`.

## Prerequisites
Before you begin, ensure you have the following installed on your machine:
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/)

## Setup
1. **Clone the Repository**:
   ```sh
   git clone https://github.com/Harshksaw/BCIS_Okanagan.git
   cd BCIS_Okanagan

2. Open cloned repo in vscode, or enter this command to directly open form terminal, if youa re in that directory

    ```
    code .


3. got to directory 
cd COSC436

4.2. Build and start the Docker containers:

    ```sh
    docker-compose up --build
    ```

3. Access the Jupyter Lab interface:

    Open your web browser and navigate to [http://localhost:8888](http://localhost:8888). You should see the Jupyter Lab interface.

   -
   -
   After Opening this link you will encounter Jypter notbook | GO inside notebooks ,there you find the .ipynb pything file , go thorught it
   

## Project Structure

- `docker-compose.yml`: Docker Compose configuration file
- `Dockerfile`: Dockerfile for building the Jupyter Lab environment
- `notebooks/`: Directory containing Jupyter notebooks
  - `stock_analysis.ipynb`: Main notebook for stock analysis
- `README.md`: This file

## Stopping the Containers

To stop the running containers, use the following command:

```sh
docker-compose down



