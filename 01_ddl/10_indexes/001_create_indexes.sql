-- records of a barbershop in a period: the list and the summary
CREATE INDEX IF NOT EXISTS idx_finance_record_barbershop_date ON finance_inventory.finance_record (barbershop_id, record_date);
-- products of a barbershop, the tenant filter of the inventory
CREATE INDEX IF NOT EXISTS idx_inventory_product_barbershop_id ON finance_inventory.inventory_product (barbershop_id);
-- movement history of a product, most recent first
CREATE INDEX IF NOT EXISTS idx_inventory_movement_product_created ON finance_inventory.inventory_movement (product_id, created_at);
