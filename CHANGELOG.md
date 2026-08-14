## [Unreleased] - 2023-04-14

### Added
- Added a new `pyproject.toml` configuration file to manage the project dependencies and build system
- Added a new `.gitignore` file to exclude various files and directories from version control
- Added a new `.python-version` file to specify the required Python version
- Added a new `External_stage.sql` file to create a Snowflake file format and stage, and copy data from CSV files into Snowflake tables
- Added a new `.gitignore` file in the `aws_dbt_snowflake_project` directory to exclude certain files and directories
- Added a new `.user.yml` file in the `aws_dbt_snowflake_project` directory to store a unique user ID
- Added new SQL files in the `aws_dbt_snowflake_project/analyses` directory to demonstrate the use of Jinja macros and conditional logic
- Added a new `dbt_project.yml` configuration file in the `aws_dbt_snowflake_project` directory to set up the dbt project structure and configurations
- Added new Jinja macros in the `aws_dbt_snowflake_project/macros` directory to provide custom functionality
- Added new incremental models in the `aws_dbt_snowflake_project/models/bronze` directory to load data from the staging tables

### Changed
- Updated the `aws_dbt_snowflake_project/README.md` file with instructions on how to use the dbt project

---
<!-- pushpen-footer -->
Documentation automatically generated and kept up to date by [Pushpen](https://pushpen.dev).
