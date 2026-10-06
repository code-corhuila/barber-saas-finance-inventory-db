-- Every stock entry (IN) or exit (OUT). The quantity is always positive; movement_type gives the
-- direction. Append-only. It reaches the tenant through its product.
CREATE TABLE finance_inventory.inventory_movement (
    id                  uuid          NOT NULL,
    product_id          uuid          NOT NULL,
    movement_type       text          NOT NULL,
    quantity            numeric(12,2) NOT NULL,
    reason              text          NULL,
    created_by_user_id  uuid          NOT NULL,  -- no FK: identity-auth domain
    created_at          timestamptz   NOT NULL DEFAULT now(),
    CONSTRAINT pk_inventory_movement PRIMARY KEY (id),
    CONSTRAINT fk_inventory_movement_product FOREIGN KEY (product_id)
        REFERENCES finance_inventory.inventory_product (id) ON DELETE CASCADE,
    CONSTRAINT chk_inventory_movement_type     CHECK (movement_type IN ('IN','OUT')),
    CONSTRAINT chk_inventory_movement_quantity CHECK (quantity > 0),
    CONSTRAINT chk_inventory_movement_reason   CHECK (char_length(reason) <= 255)
);
