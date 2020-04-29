BEGIN;
DROP TABLE IF EXISTS device;
DROP TABLE IF EXISTS reading;

CREATE TABLE device
(
    id           INTEGER PRIMARY KEY,
    name         TEXT NOT NULL UNIQUE,
    verbose_name TEXT,
    path         TEXT NOT NULL UNIQUE,
    last_ts      DATETIME,
    last_reading INTEGER
);

CREATE TABLE reading
(
    id     INTEGER PRIMARY KEY,
    device INTEGER,
    ts     DATETIME DEFAULT CURRENT_TIMESTAMP,
    value  INTEGER,
    FOREIGN KEY (device)
        REFERENCES device (id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
);

CREATE INDEX reading_ts_idx ON reading (ts);

CREATE TRIGGER reading_history
    AFTER UPDATE
    ON device
    WHEN old.last_ts <> new.last_ts
BEGIN
    INSERT INTO reading (device,
                         ts,
                         value)
    VALUES (new.id,
            new.last_ts,
            new.last_reading);
END;

commit;