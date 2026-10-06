DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'finance_inventory_app') THEN
        REVOKE finance_inventory_writer FROM finance_inventory_app;
    END IF;
END
$$;
ALTER DEFAULT PRIVILEGES IN SCHEMA finance_inventory REVOKE ALL ON TABLES FROM finance_inventory_reader, finance_inventory_writer;
REVOKE ALL ON ALL TABLES IN SCHEMA finance_inventory FROM finance_inventory_reader, finance_inventory_writer;
REVOKE USAGE ON SCHEMA finance_inventory FROM finance_inventory_reader, finance_inventory_writer;
