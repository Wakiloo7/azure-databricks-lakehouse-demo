"""
Simple data quality test examples for the Azure Databricks Medallion Lakehouse project.

These checks are designed to document the validation logic used between
Bronze, Silver, and Gold layers.
"""

def test_customer_id_not_null(customers_df):
    invalid_count = customers_df.filter("customer_id IS NULL").count()
    assert invalid_count == 0, "customer_id should not contain null values"


def test_order_amount_positive(orders_df):
    invalid_count = orders_df.filter("order_amount <= 0 OR order_amount IS NULL").count()
    assert invalid_count == 0, "order_amount should be positive and not null"


def test_order_id_unique(orders_df):
    total_count = orders_df.count()
    distinct_count = orders_df.select("order_id").distinct().count()
    assert total_count == distinct_count, "order_id should be unique"