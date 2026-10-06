-- Income and expenses of a barbershop (FR-016). Never edited nor deleted: a mistake is corrected
-- with a compensating record of the opposite type (DEC-FIN-02), so there is no updated_at.
CREATE TABLE finance_inventory.finance_record (
    id                      uuid        NOT NULL,
    barbershop_id           uuid        NOT NULL,
    type                    text        NOT NULL,
    category                text        NOT NULL,
    amount_cents            bigint      NOT NULL,   -- COP cents, always positive (DEC-FIN-01, FR-017)
    description             text        NULL,
    record_date             date        NOT NULL,
    related_appointment_id  uuid        NULL,       -- no FK: appointment domain
    created_at              timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_finance_record PRIMARY KEY (id),
    CONSTRAINT chk_finance_record_type        CHECK (type IN ('INCOME','EXPENSE')),
    CONSTRAINT chk_finance_record_category    CHECK (char_length(category) BETWEEN 1 AND 80),
    CONSTRAINT chk_finance_record_amount      CHECK (amount_cents > 0),
    CONSTRAINT chk_finance_record_description CHECK (char_length(description) <= 255)
);
