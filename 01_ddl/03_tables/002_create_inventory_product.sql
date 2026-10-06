-- Products of a barbershop's inventory (FR-018). Stock is a quantity, not money: numeric(12,2),
-- never floating point. lowStock is computed on read (current_stock <= min_stock_alert, FR-019).
CREATE TABLE finance_inventory.inventory_product (
    id               uuid          NOT NULL,
    barbershop_id    uuid          NOT NULL,
    name             text          NOT NULL,
    description      text          NULL,
    unit             text          NOT NULL DEFAULT 'unidad',
    current_stock    numeric(12,2) NOT NULL DEFAULT 0,
    min_stock_alert  numeric(12,2) NOT NULL DEFAULT 0,
    created_at       timestamptz   NOT NULL DEFAULT now(),
    CONSTRAINT pk_inventory_product PRIMARY KEY (id),
    CONSTRAINT chk_inventory_product_name  CHECK (char_length(name) BETWEEN 1 AND 120),
    CONSTRAINT chk_inventory_product_description CHECK (char_length(description) <= 255),
    CONSTRAINT chk_inventory_product_unit  CHECK (char_length(unit) BETWEEN 1 AND 20),
    -- an OUT movement that would leave negative stock is refused here too (HU-INV-001 scenario 2)
    CONSTRAINT chk_inventory_product_stock CHECK (current_stock >= 0 AND min_stock_alert >= 0)
);
