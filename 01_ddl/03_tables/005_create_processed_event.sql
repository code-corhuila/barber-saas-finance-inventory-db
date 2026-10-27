-- The ids of the events this service already processed (EventEnvelope.id). The worker delivers at
-- least once: the row is written in the same transaction as the income it records, so a redelivery
-- finds it and answers DUPLICATE without recording the appointment twice (ADR-016, DEC-FIN-03).
CREATE TABLE finance_inventory.processed_event (
    event_id      uuid        NOT NULL,
    event_type    text        NOT NULL,
    outcome       text        NOT NULL,
    processed_at  timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_processed_event PRIMARY KEY (event_id),
    CONSTRAINT chk_processed_event_outcome CHECK (outcome IN ('PROCESSED','IGNORED'))
);
