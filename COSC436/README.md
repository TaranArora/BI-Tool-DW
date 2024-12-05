# BCIS_Okanagan


## Table of Contents

- [BCIS\_Okanagan](#bcis_okanagan)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
  - [Project Structure](#project-structure)
  - [Stopping the Containers](#stopping-the-containers)
  - [Creating a Backup of the SQL Database](#creating-a-backup-of-the-sql-database)
  - [Updating the Project](#updating-the-project)
  - [Database Setup](#database-setup)

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

   ```

2. Open cloned repo in vscode, or enter this command to directly open form terminal, if youa re in that directory

   ```
   code .

   ```

3. got to directory
   cd COSC436

4.2. Build and start the Docker containers:

    ```sh
    docker-compose up --build
    ```

3. Access the Jupyter Lab interface:

   Open your web browser and navigate to [http://localhost:8888](http://localhost:8888). You should see the Jupyter Lab interface.

   -
   - After Opening this link you will encounter Jypter notbook | GO inside notebooks ,there you find the .ipynb pything file , go thorught it

## Project Structure

- `docker-compose.yml`: Docker Compose configuration file
- `Dockerfile`: Dockerfile for building the Jupyter Lab environment
- `notebooks/`: Directory containing Jupyter notebooks
  - `stock_analysis.ipynb`: Main notebook for stock analysis
- `README.md`: This file

## Stopping the Containers

To stop the running containers, use the following command:

````sh
docker-compose down







## Creating a Backup of the SQL Database

To create a backup of your PostgreSQL database, follow these steps:

1. **Find the Container ID**:
    First, find the container ID of the running PostgreSQL container. You can do this by listing all running containers:
    ```sh
    docker ps
    ```

2. **Execute the Backup Command**:
    Use the `docker exec` command to create a backup of the database. Replace `CONTAINER_ID` with the actual container ID from the previous step:
    ```sh
    docker exec -t CONTAINER_ID pg_dump -U cosc stock_data > stock_data.sql
    ```

This will create a file named `stock_data.sql` in your current directory containing the backup of your PostgreSQL database.




## Updating the Project

To update the project with the latest changes, follow these steps:

1. **Pull the Latest Changes**:
    ```sh
    git pull origin main
    ```

2. **Stop and Remove Previous Docker Containers**:
    ```sh
    docker-compose down
    docker system prune -f
    ```

3. **Rebuild and Start the Docker Containers**:
    ```sh
    docker-compose up --build
    ```
## Database Setup



To set up the database schema and tables, run the following SQL queries:

```sql
-- Step 1: Create the schema if it doesn't already exist
CREATE SCHEMA IF NOT EXISTS finance_schema;

-- Step 2: Create the Stock Dimension Table
CREATE TABLE IF NOT EXISTS finance_schema.stock_dimension (
    stock_id SERIAL PRIMARY KEY,
    stock_symbol VARCHAR(10) NOT NULL UNIQUE,
    company_name VARCHAR(255) NOT NULL,
    sector VARCHAR(100),
    currency VARCHAR(10),
    exchange VARCHAR(50)
);

-- Step 3: Create the Date Dimension Table
CREATE TABLE IF NOT EXISTS finance_schema.date_dimension (
    date_id SERIAL PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    day_of_week VARCHAR(15),
    month VARCHAR(15),
    quarter VARCHAR(2),
    year INT,
    is_holiday BOOLEAN
);

-- Step 4: Create the Sector Dimension Table
CREATE TABLE IF NOT EXISTS finance_schema.sector_dimension (
    sector_id SERIAL PRIMARY KEY,
    sector_name VARCHAR(100) NOT NULL UNIQUE
);

-- Step 5: Create the Exchange Dimension Table
CREATE TABLE IF NOT EXISTS finance_schema.exchange_dimension (
    exchange_id SERIAL PRIMARY KEY,
    exchange_name VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(100)
);

-- Step 6: Create the Fact Stock Data Table
CREATE TABLE IF NOT EXISTS finance_schema.fact_stock_data (
    transaction_id SERIAL PRIMARY KEY,
    stock_id INT REFERENCES finance_schema.stock_dimension(stock_id),
    date_id INT REFERENCES finance_schema.date_dimension(date_id),
    open_price DECIMAL(10, 2),
    close_price DECIMAL(10, 2),
    high_price DECIMAL(10, 2),
    low_price DECIMAL(10, 2),
    volume INT,
    rsi DECIMAL(5, 2),
    sma DECIMAL(10, 2),
    bollinger_band DECIMAL(10, 2)
);

-- Step 7: Add Unique Constraint to Fact Stock Data Table
ALTER TABLE finance_schema.fact_stock_data
ADD CONSTRAINT unique_stock_date UNIQUE (stock_id, date_id);
```

```
-- CREATE TABLE IF NOT EXISTS finance_schema.moving_average_crossover (
--     crossover_id SERIAL PRIMARY KEY,
--     stock_id INT REFERENCES finance_schema.stock_dimension(stock_id),
--     date_id INT REFERENCES finance_schema.date_dimension(date_id),
--     short_ma DECIMAL(10, 2) NOT NULL,
--     long_ma DECIMAL(10, 2) NOT NULL,
--     price DECIMAL(10, 2) NOT NULL,
--     crossover_signal VARCHAR(4) NOT NULL,
--     UNIQUE (stock_id, date_id)
-- );
-- CREATE TABLE IF NOT EXISTS finance_schema.portfolio_history (
--     history_id SERIAL PRIMARY KEY, -- Unique identifier for each record
--     stock_id INT NOT NULL REFERENCES finance_schema.stock_dimension(stock_id),
--     trade_date DATE NOT NULL,
--     action VARCHAR(10) NOT NULL, -- BUY or SELL
--     shares INT NOT NULL, -- Number of shares traded
--     capital DECIMAL(12, 2) NOT NULL, -- Remaining cash after the trade
--     position INT NOT NULL, -- Current number of shares held
--     portfolio_value DECIMAL(12, 2) NOT NULL, -- Total value of the portfolio
--     stock_price DECIMAL(10, 2) NOT NULL, -- Price of the stock at trade time
--     UNIQUE (stock_id, trade_date, action) -- Ensure unique entries per stock, date, and action
-- );
--
-- CREATE TABLE IF NOT EXISTS finance_schema.backtesting_results (
--     backtest_id SERIAL PRIMARY KEY,  -- Unique identifier for each backtest result
--     stock_id INT NOT NULL REFERENCES finance_schema.stock_dimension(stock_id),
--     start_date DATE NOT NULL,
--     end_date DATE NOT NULL,
--     initial_capital DECIMAL(12, 2) NOT NULL,  -- Starting capital for the backtest
--     final_capital DECIMAL(12, 2) NOT NULL,    -- Ending capital after backtest
--     total_trades INT NOT NULL,                -- Number of trades executed
--     profitable_trades INT NOT NULL,           -- Number of profitable trades
--     win_ratio DECIMAL(5, 2) NOT NULL,         -- Percentage of profitable trades
--     cumulative_return DECIMAL(8, 2) NOT NULL, -- Total percentage return over the period
--     UNIQUE (stock_id, start_date, end_date)   -- Prevent duplicate entries for the same stock and period
-- );
--


```