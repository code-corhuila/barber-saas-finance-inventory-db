-- NOLOGIN roles carry the permissions. The login user finance_inventory_app is created by
-- barber-saas-infra-postgres from a secret; no password is ever versioned here.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'finance_inventory_reader') THEN
        CREATE ROLE finance_inventory_reader NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'finance_inventory_writer') THEN
        CREATE ROLE finance_inventory_writer NOLOGIN;
    END IF;
END
$$;
