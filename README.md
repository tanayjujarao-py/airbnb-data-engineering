# Airbnb Data Engineering

A data engineering project to ingest, transform, and analyze Airbnb data using dbt, Snowflake, and AWS.

![Python](https://img.shields.io/badge/Python-3.12-blue.svg)
![dbt](https://img.shields.io/badge/dbt-1.12.0-orange.svg)
![Snowflake](https://img.shields.io/badge/Snowflake-latest-yellow.svg)

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Tech Stack](#tech-stack)
4. [Prerequisites](#prerequisites)
5. [Installation](#installation)
6. [Usage](#usage)
7. [Configuration](#configuration)

## Overview
This project is a data engineering solution that ingests Airbnb data into a Snowflake data warehouse, transforms the raw data into a structured data model using dbt, and provides analytical capabilities for end-users.

## Features
- Automated data ingestion from CSV files into Snowflake
- Incremental loading of new data into the data warehouse
- Dimensional data modeling using dbt
- Analytical models for exploring and reporting on Airbnb data

## Tech Stack
- Python 3.12
- dbt Core 1.12.0
- dbt Snowflake 1.12.0
- Snowflake (as the data warehouse)
- AWS (for data storage and infrastructure)

## Prerequisites
To use this project, you will need:
- Access to a Snowflake account
- AWS credentials with access to the S3 bucket containing the Airbnb CSV files

## Installation
1. Clone the repository:
```
git clone https://github.com/tanayjujarao/airbnb-data-engineering.git
```
2. Install the required dependencies:
```
pip install -r requirements.txt
```
3. Configure your Snowflake connection details in the `profiles.yml` file.
4. Ensure the CSV files are available in the specified S3 bucket.

## Usage
1. Run the dbt models to load and transform the data:
```
dbt run
```
2. Run the dbt tests to ensure data quality:
```
dbt test
```
3. Explore the transformed data in the Snowflake data warehouse.

## Configuration
The project's configuration is managed through the `dbt_project.yml` file, which includes settings for:
- Model materialization (table, view, incremental)
- Schema and database naming
- Macro definitions

Additionally, the `profiles.yml` file stores the connection details for the Snowflake data warehouse.

---
<!-- pushpen-footer -->
Documentation automatically generated and kept up to date by [Pushpen](https://pushpen.dev).
