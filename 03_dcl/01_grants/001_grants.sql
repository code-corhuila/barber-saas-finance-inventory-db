GRANT USAGE ON SCHEMA finance_inventory TO finance_inventory_reader, finance_inventory_writer;
GRANT SELECT ON ALL TABLES IN SCHEMA finance_inventory TO finance_inventory_reader;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA finance_inventory TO finance_inventory_writer;
ALTER DEFAULT PRIVILEGES IN SCHEMA finance_inventory GRANT SELECT ON TABLES TO finance_inventory_reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA finance_inventory GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO finance_inventory_writer;

-- The domain grants its writer role to its own login user (Annex J J.7). The user exists only
-- where the infrastructure created it, so the grant is conditional. No other domain is granted
-- finance_inventory_reader: other domains read this data through finance-inventory-api (Annex J J.3.3).
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'finance_inventory_app') THEN
        GRANT finance_inventory_writer TO finance_inventory_app;
    END IF;
END
$$;
