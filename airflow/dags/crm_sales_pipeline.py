from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
from pathlib import Path

from dbt.cli.main import dbtRunner


PROJECT_ROOT = Path("/usr/local/airflow/crm_sales")
DBT_PROJECT_DIR = PROJECT_ROOT / "dbt" / "crm_sales"


def run_dbt_seed():
    print("Loading CSV files using dbt Seeds...")
    dbt = dbtRunner()
    result = dbt.invoke([
        "seed",
        "--project-dir",
        str(DBT_PROJECT_DIR),
    ])
    if not result.success:
        raise RuntimeError("dbt seed failed")


def run_dbt():
    print("Running dbt models...")
    dbt = dbtRunner()
    result = dbt.invoke([
        "run",
        "--project-dir",
        str(DBT_PROJECT_DIR),
    ])
    if not result.success:
        raise RuntimeError("dbt run failed")


def test_dbt():
    print("Running dbt data quality tests...")
    dbt = dbtRunner()
    result = dbt.invoke([
        "test",
        "--project-dir",
        str(DBT_PROJECT_DIR),
    ])
    if not result.success:
        raise RuntimeError("dbt test failed")


with DAG(
    dag_id="crm_sales_pipeline",
    start_date=datetime(2025, 1, 1),
    schedule="@daily",
    catchup=False,
    description="CRM Sales Pipeline"
) as dag:

    dbt_seed_task = PythonOperator(
        task_id="dbt_seed",
        python_callable=run_dbt_seed,
    )

    dbt_run_task = PythonOperator(
        task_id="dbt_run",
        python_callable=run_dbt,
    )

    dbt_test_task = PythonOperator(
        task_id="dbt_test",
        python_callable=test_dbt,
    )

    dbt_seed_task >> dbt_run_task >> dbt_test_task