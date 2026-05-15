# ELT/ETL Workshop

A hands-on data engineering project built to learn ETL and ELT pipeline patterns.

## What's in here

- **Meltano + dbt + Postgres** — Production-style ELT using real data engineering tools

## Stack

- Python 3.11
- Meltano (tap-csv, target-postgres)
- dbt-postgres
- PostgreSQL (Docker)

## How to run

```bash
# Start Postgres
docker run -d --name meltano-postgres -e POSTGRES_USER=meltano -e POSTGRES_PASSWORD=meltano -e POSTGRES_DB=warehouse -p 5432:5432 postgres:15

# Run the full pipeline
meltano run tap-csv target-postgres dbt-postgres:run

cd ~/meltano-workshop && cat > README.md << 'EOF'
# ELT/ETL Workshop

A hands-on data engineering project built to learn ETL and ELT pipeline patterns from scratch.

## What This Project Does

Extracts raw sales data from a CSV file, loads it into a PostgreSQL data warehouse
running in Docker, and transforms it into clean analytics-ready tables using dbt SQL models.

## Stack

- Python 3.11 — pipeline scripting and data manipulation
- Docker — runs PostgreSQL locally as a containerized data warehouse
- PostgreSQL — the destination data warehouse
- Meltano — orchestrates the pipeline (tap-csv extracts, target-postgres loads)
- dbt-postgres — transforms raw staged data into clean analytics tables
- Git + GitHub — version control

## Pipeline Flow

raw_sales.csv → Meltano (tap-csv) → PostgreSQL raw staging → dbt → clean analytics tables

## What Lands in the Warehouse

- tap_csv.raw_sales — all 20 raw rows, untouched (the EL in ELT)
- analytics.stg_sales — types cast, names cleaned
- analytics.fact_sales — business rules applied, total_revenue calculated
- analytics.rpt_revenue_by_category — aggregated report by product category

## How to Run

Start Postgres in Docker:
    docker run -d --name meltano-postgres -e POSTGRES_USER=meltano -e POSTGRES_PASSWORD=meltano -e POSTGRES_DB=warehouse -p 5432:5432 postgres:15

Install Meltano plugins:
    meltano install

Run the full ELT pipeline:
    meltano run tap-csv target-postgres dbt-postgres:run

## Concepts Covered

- Difference between ETL and ELT
- Docker containers for local infrastructure
- Singer protocol (taps and targets)
- dbt models, sources, and refs
- Staging vs fact vs report table patterns
- PostgreSQL schemas and data warehousing
