# 🏠 Airbnb Data Engineering Pipeline

An end-to-end **data engineering project** that ingests Airbnb data from **AWS S3**, loads it into **Snowflake**, and transforms it using **dbt Core** into a layered **Bronze, Silver, and Gold** data warehouse architecture.

The project demonstrates practical data engineering concepts including cloud data ingestion, ELT, incremental loading, dimensional modeling, dbt snapshots, SCD Type 2, reusable macros, data quality testing, and version control.

---

## 📌 Project Overview

The objective of this project is to build a **scalable data pipeline** that takes raw Airbnb data stored in AWS S3 and transforms it into clean, structured, and analytics-ready datasets in Snowflake.

The pipeline follows a layered data architecture:

> **AWS S3 → Snowflake → Bronze → Silver → Gold**

### Pipeline Flow

1. Raw Airbnb CSV files are stored in AWS S3.
2. Snowflake external stages are used to access the data.
3. Raw data is loaded into Snowflake source tables.
4. dbt transforms the source data into the **Bronze** layer.
5. The **Silver** layer cleans and enriches the data.
6. The **Gold** layer creates analytics-ready datasets.
7. dbt tests validate data quality.
8. dbt snapshots preserve historical changes to records.

---

## 🏗️ Architecture

```text
                    AWS S3
                      │
                      │ Raw CSV Files
                      ▼
              ┌─────────────────┐
              │    Snowflake    │
              │ External Stage  │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │  Source Tables  │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │  Bronze Layer   │
              │ Raw Transforms  │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │  Silver Layer   │
              │ Cleaned Data    │
              │ Business Logic  │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │   Gold Layer    │
              │ Analytics Ready │
              └────────┬────────┘
                       │
                       ▼
                BI / Analytics
```

---

## 🚀 Key Features

### ☁️ AWS S3 Data Ingestion
- Airbnb CSV data stored in AWS S3.
- Snowflake external stage configured for accessing cloud storage.
- SQL scripts provided for stage and table creation.
- Raw data loaded into Snowflake for transformation.

### 🥉 Bronze Layer
The Bronze layer contains the initial transformations of the source data.

**Example models:**
- `bronze_bookings`
- `bronze_hosts`
- `bronze_listings`

The layer focuses on creating a structured foundation from the raw source data.

### 🥈 Silver Layer
The Silver layer contains cleaned and transformed datasets.

**Example models:**
- `silver_bookings`
- `silver_hosts`
- `silver_listings`

**Transformations include:**
- Data cleaning
- String standardization
- Derived columns
- Business rules
- Calculated metrics
- Incremental processing

### 🥇 Gold Layer
The Gold layer contains analytics-ready models designed for downstream reporting and analysis.

**The layer includes:**
- Fact models
- One Big Table (OBT)
- Ephemeral models
- Business-ready datasets

---

## 🔄 Incremental Loading

The project uses dbt **incremental models** to avoid processing the entire dataset on every run.

```sql
{{ config(
    materialized='incremental',
    unique_key='booking_id'
) }}
```

Incremental models allow new or changed records to be processed without rebuilding the entire target table, reducing unnecessary warehouse computation and improving pipeline efficiency as datasets grow.

---

## 📸 dbt Snapshots & SCD Type 2

dbt snapshots are used to track **historical changes** to records, following the principles of **Slowly Changing Dimension Type 2 (SCD Type 2)**.

Instead of overwriting an existing record when an attribute changes, the previous version is preserved and a new version is created.

**Example:**

| host_id | response_rate | valid_from | valid_to   |
|---------|---------------|------------|------------|
| 101     | 85            | 2026-01-01 | 2026-03-15 |
| 101     | 95            | 2026-03-15 | NULL       |

This makes it possible to analyze how dimensional attributes changed over time.

---

## 🧩 dbt Macros

The project uses reusable dbt macros to avoid duplicating SQL logic.

```sql
{% macro multiply(x, y, precision) %}
    round({{ x }} * {{ y }}, {{ precision }})
{% endmacro %}
```

The macro can then be reused inside models:

```sql
{{ multiply('nights_booked', 'booking_amount', 2) }}
```

This demonstrates the use of **Jinja templating** and reusable SQL logic within dbt.

---

## 🧪 Data Quality Testing

dbt tests are used to validate the quality and integrity of transformed datasets.

**Tests include:**
- `not_null`
- `unique`
- `accepted_values`
- Custom data quality tests
- Business-rule validation

**Example:**

```yaml
columns:
  - name: booking_id
    tests:
      - not_null
      - unique
```

These tests help identify data quality issues before the data is consumed downstream.

---

## 📊 Data Model

The project works with three primary entities.

### 🧑‍💼 Hosts
Contains information about Airbnb hosts.

**Key attributes:**
- `host_id`
- `host_name`
- `host_since`
- `is_superhost`
- `response_rate`

### 🏘️ Listings
Contains information about Airbnb properties.

**Key attributes:**
- `listing_id`
- `host_id`
- `property_type`
- `room_type`
- `city`
- `country`
- `accommodates`
- `bedrooms`
- `bathrooms`
- `price_per_night`

### 📅 Bookings
Contains booking-level information.

**Key attributes:**
- `booking_id`
- `listing_id`
- `booking_date`
- `nights_booked`
- `booking_amount`
- `cleaning_fee`
- `service_fee`
- `booking_status`
- `created_at`

---

## 🛠️ Tech Stack

| Technology       | Purpose                                              |
|-------------------|-------------------------------------------------------|
| **Python 3.12**   | Project environment and automation                   |
| **SQL**           | Data transformation and warehouse operations          |
| **dbt Core 1.12** | Data modeling, testing, snapshots and transformations |
| **dbt Snowflake** | Snowflake adapter for dbt                             |
| **Snowflake**     | Cloud data warehouse                                  |
| **AWS S3**        | Cloud object storage                                  |
| **Jinja**         | Dynamic SQL and dbt macros                            |
| **uv**            | Python dependency and environment management          |
| **Git**           | Version control                                       |
| **GitHub**        | Source code management                                |

---

## 📁 Project Structure

```text
airbnb-data-engineering/
│
├── aws_dbt_snowflake_project/
│   │
│   ├── analyses/
│   │   └── SQL analysis files
│   │
│   ├── macros/
│   │   ├── generate_schema_name.sql
│   │   ├── multiply.sql
│   │   ├── tag.sql
│   │   └── trimmer.sql
│   │
│   ├── models/
│   │   │
│   │   ├── bronze/
│   │   │   ├── bronze_bookings.sql
│   │   │   ├── bronze_hosts.sql
│   │   │   └── bronze_listings.sql
│   │   │
│   │   ├── silver/
│   │   │   ├── silver_bookings.sql
│   │   │   ├── silver_hosts.sql
│   │   │   └── silver_listings.sql
│   │   │
│   │   └── gold/
│   │       ├── ephemeral/
│   │       │   ├── bookings.sql
│   │       │   ├── hosts.sql
│   │       │   └── listings.sql
│   │       │
│   │       ├── fact.sql
│   │       └── obt.sql
│   │
│   ├── snapshots/
│   │   ├── dim_bookings.yml
│   │   ├── dim_hosts.yml
│   │   └── dim_listings.yml
│   │
│   ├── tests/
│   │   └── source_tests.sql
│   │
│   └── dbt_project.yml
│
├── data/
│   ├── bookings.csv
│   ├── hosts.csv
│   └── listings.csv
│
├── create_table.sql
├── External_stage.sql
├── pyproject.toml
├── uv.lock
└── README.md
```

---

## ⚙️ Setup

### 1. Clone the Repository

```bash
git clone https://github.com/tanayjujarao-py/airbnb-data-engineering.git
cd airbnb-data-engineering
```

### 2. Set Up the Python Environment

This project uses **uv** for dependency management.

```bash
uv sync
```

Alternatively, a standard Python virtual environment can be created:

```bash
python -m venv .venv
```

On Windows:

```bash
.venv\Scripts\activate
```

### 3. Configure Snowflake

Create a local `profiles.yml` file for your dbt Snowflake connection.

**Example:**

```yaml
airbnb_data_engineering:
  target: dev

  outputs:
    dev:
      type: snowflake
      account: <your_account>
      user: <your_user>
      password: <your_password>
      role: <your_role>
      database: <your_database>
      warehouse: <your_warehouse>
      schema: <your_schema>
      threads: 1
```

> ⚠️ **Do not commit your `profiles.yml` file** — it contains sensitive credentials.

### 4. Configure AWS

Configure the Snowflake external stage using `External_stage.sql`.

Update the script with your own AWS S3 location and required configuration.

> ⚠️ **Do not commit AWS access keys, secret keys, or other credentials.**

---

## ▶️ Running the Project

Navigate to the dbt project:

```bash
cd aws_dbt_snowflake_project
```

**Validate the dbt connection:**

```bash
dbt debug
```

**Parse the project:**

```bash
dbt parse
```

**Run all models:**

```bash
dbt run
```

**Run a specific model:**

```bash
dbt run --select silver_bookings
```

**Run tests:**

```bash
dbt test
```

**Run snapshots:**

```bash
dbt snapshot
```

**Build the complete pipeline:**

```bash
dbt build
```

> `dbt build` runs the required models, tests, snapshots, seeds, and other selected resources according to their dependencies.

---

## 🧠 Data Engineering Concepts Demonstrated

- AWS S3 data ingestion
- Snowflake cloud data warehousing
- External stages
- ELT architecture
- Bronze / Silver / Gold architecture
- dbt project structure
- dbt sources & models
- Incremental models & unique keys
- dbt snapshots & SCD Type 2
- Jinja templating & reusable macros
- Ephemeral models
- Fact modeling & One Big Table modeling
- Data quality testing
- SQL transformations
- Schema management
- Git version control

---

## 🎯 Skills Demonstrated

### Data Engineering
- ETL / ELT pipeline development
- Data warehouse design
- Cloud data ingestion
- Data transformation
- Incremental data processing
- Historical data tracking
- Data quality engineering
- Dimensional modeling

### SQL
- Data transformation
- Joins & aggregations
- Conditional logic
- Derived metrics
- DDL and DML
- Snowflake SQL

### dbt
- Models & sources
- Snapshots & tests
- Macros & Jinja
- Incremental materializations
- Ephemeral models
- Dependency management & data lineage

### Cloud & Development Tools
- AWS S3
- Snowflake
- Git & GitHub
- VS Code
- uv

---

## 🔐 Security

Sensitive credentials are **not stored** in this repository.

The following are excluded through `.gitignore`:
- `profiles.yml`
- `.venv/`

AWS credentials and Snowflake passwords should always be stored locally or provided through secure environment variables.

---

## 🔮 Future Improvements

- [ ] Apache Airflow for pipeline orchestration
- [ ] GitHub Actions for CI/CD
- [ ] Automated data quality monitoring
- [ ] dbt documentation and lineage
- [ ] Pipeline failure notifications
- [ ] Data warehouse monitoring
- [ ] Power BI or Tableau dashboards
- [ ] Automated AWS S3 to Snowflake ingestion
- [ ] Production and development environment separation

---

## 👨‍💻 Author

**Tanay Jujarao**
*Data Analytics & Data Engineering Enthusiast*

🔗 GitHub: [github.com/tanayjujarao-py](https://github.com/tanayjujarao-py)
