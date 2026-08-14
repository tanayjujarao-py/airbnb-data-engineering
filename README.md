# Airbnb Data Engineering Project

This project is a data engineering pipeline that processes Airbnb data using dbt (data build tool) and Snowflake as the data warehouse.

![Python](https://img.shields.io/badge/python-3.12-blue.svg)
![Snowflake](https://img.shields.io/badge/Snowflake-blue.svg)
![dbt](https://img.shields.io/badge/dbt-1.12.0-brightgreen.svg)

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Tech Stack](#tech-stack)
4. [Prerequisites](#prerequisites)
5. [Installation](#installation)
6. [Usage](#usage)
7. [Configuration](#configuration)

## Overview
The Airbnb Data Engineering Project is a data pipeline that ingests, transforms, and loads Airbnb data into a Snowflake data warehouse. It uses dbt to manage the data transformation and modeling process.

## Features
- Ingests Airbnb data from CSV files into Snowflake staging tables
- Transforms the data using dbt models to create bronze, silver, and gold tables
- Supports incremental loading of data
- Provides a set of analysis-ready tables for reporting and business intelligence

## Tech Stack
- Python 3.12
- dbt-core>=1.12.0
- dbt-snowflake>=1.12.0
- sqlfmt>=0.0.3

## Prerequisites
To use this project, you will need:
- A Snowflake account
- AWS credentials with access to the S3 bucket containing the Airbnb data files

## Installation
1. Clone the repository:
```
git clone https://github.com/tanayjujarao/airbnb-data-engineering.git
```
2. Set up a Python virtual environment and install the required dependencies:
```
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```
3. Configure your Snowflake connection details in the `profiles.yml` file.

## Usage
1. Run the dbt models:
```
dbt run
```
2. Run the dbt tests:
```
dbt test
```

## Configuration
The main configuration for this project is in the `dbt_project.yml` file. Here you can customize the schema names, materialization strategies, and other dbt-specific settings.

The `External_stage.sql` file contains the SQL to create the Snowflake external stage and load the Airbnb data files into the staging tables.

---
<!-- pushpen-footer -->
Documentation automatically generated and kept up to date by [Pushpen](https://pushpen.dev).
