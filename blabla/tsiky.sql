CREATE TABLE loan_duration (
    id       SERIAL       PRIMARY KEY,
    duration INTEGER      NOT NULL
);

CREATE TABLE extension_duration (
    id       SERIAL       PRIMARY KEY,
    duration INTEGER      NOT NULL
);

CREATE TABLE notification_duration (
    id       SERIAL       PRIMARY KEY,
    duration INTEGER      NOT NULL
);

CREATE TABLE penality_cost (
    id   SERIAL        PRIMARY KEY,
    cost DECIMAL(10,2) NOT NULL
);

CREATE TABLE public_holiday (
    id           SERIAL       PRIMARY KEY,
    name         TEXT         NOT NULL,
    date_holiday DATE         NOT NULL
);

CREATE TABLE member_type (
    id    SERIAL       PRIMARY KEY,
    value TEXT         NOT NULL,
    quota INTEGER      NOT NULL
);

CREATE TABLE status (
    id    SERIAL       PRIMARY KEY,
    value TEXT         NOT NULL
);

CREATE TABLE member (
    id               SERIAL       PRIMARY KEY,
    email            TEXT         NOT NULL,
    id_type_member   INTEGER      NOT NULL,
    username         TEXT         NOT NULL,
    password         TEXT         NOT NULL,
    registration_date DATE        NOT NULL,

    CONSTRAINT fk_member_type
        FOREIGN KEY (id_type_member)
        REFERENCES member_type(id)
);

CREATE TABLE member_status (
    id         SERIAL  PRIMARY KEY,
    id_member  INTEGER NOT NULL,
    id_status  INTEGER NOT NULL,
    status_date DATE   NOT NULL,

    CONSTRAINT fk_member_status_member
        FOREIGN KEY (id_member)
        REFERENCES member(id),

    CONSTRAINT fk_member_status_status
        FOREIGN KEY (id_status)
        REFERENCES status(id)
);

CREATE TABLE member_quotas (
    id         SERIAL  PRIMARY KEY,
    id_member  INTEGER NOT NULL,
    quota      INTEGER NOT NULL,
    quota_date DATE    NOT NULL,

    CONSTRAINT fk_member_quotas_member
        FOREIGN KEY (id_member)
        REFERENCES member(id)
);

CREATE TABLE librarian (
    id       SERIAL PRIMARY KEY,
    username TEXT   NOT NULL,
    password TEXT   NOT NULL
);

CREATE TABLE subscription_type (
    id       SERIAL        PRIMARY KEY,
    name     TEXT          NOT NULL,
    cost     DECIMAL(10,2) NOT NULL,
    duration INTEGER       NOT NULL
);

CREATE TABLE subscription (
    id                    SERIAL  PRIMARY KEY,
    id_member             INTEGER NOT NULL,
    id_subscription_type  INTEGER NOT NULL,
    id_librarian          INTEGER NOT NULL,
    subscription_date     DATE    NOT NULL,
    subscription_start    DATE    NOT NULL,
    subscription_end      DATE    NOT NULL,

    CONSTRAINT fk_subscription_member
        FOREIGN KEY (id_member)
        REFERENCES member(id),

    CONSTRAINT fk_subscription_type
        FOREIGN KEY (id_subscription_type)
        REFERENCES subscription_type(id),

    CONSTRAINT fk_subscription_librarian
        FOREIGN KEY (id_librarian)
        REFERENCES librarian(id)
);

CREATE TABLE book_genre (
    id    SERIAL PRIMARY KEY,
    value TEXT   NOT NULL
);

CREATE TABLE book_theme (
    id    SERIAL PRIMARY KEY,
    value TEXT   NOT NULL
);

CREATE TABLE author (
    id          SERIAL PRIMARY KEY,
    name        TEXT   NOT NULL,
    artist_name TEXT   NULL
);

CREATE TABLE book (
    id             SERIAL  PRIMARY KEY,
    title          TEXT    NOT NULL,
    id_author      INTEGER NOT NULL,
    id_book_genre  INTEGER NOT NULL,
    edition_date   DATE    NOT NULL,

    CONSTRAINT fk_book_author
        FOREIGN KEY (id_author)
        REFERENCES author(id),

    CONSTRAINT fk_book_genre
        FOREIGN KEY (id_book_genre)
        REFERENCES book_genre(id)
);

CREATE TABLE book_details (
    id             SERIAL  PRIMARY KEY,
    id_book        INTEGER NOT NULL,
    id_book_theme  INTEGER NOT NULL,

    CONSTRAINT fk_book_details_book
        FOREIGN KEY (id_book)
        REFERENCES book(id),

    CONSTRAINT fk_book_details_theme
        FOREIGN KEY (id_book_theme)
        REFERENCES book_theme(id)
);

CREATE TABLE copy (
    id       SERIAL  PRIMARY KEY,
    id_book  INTEGER NOT NULL,
    copy_id  INTEGER NOT NULL,

    CONSTRAINT fk_copy_book
        FOREIGN KEY (id_book)
        REFERENCES book(id)
);

CREATE TABLE authorization (
    id               SERIAL  PRIMARY KEY,
    id_member_type   INTEGER NOT NULL,
    id_book          INTEGER NOT NULL,

    CONSTRAINT fk_authorization_member_type
        FOREIGN KEY (id_member_type)
        REFERENCES member_type(id),

    CONSTRAINT fk_authorization_book
        FOREIGN KEY (id_book)
        REFERENCES book(id)
);

CREATE TABLE loan (
    id                  SERIAL  PRIMARY KEY,
    id_member           INTEGER NOT NULL,
    id_copy             INTEGER NOT NULL,
    id_librarian_loan   INTEGER NOT NULL,
    loan_date           DATE    NOT NULL,
    start_date          DATE    NOT NULL,
    due_date            DATE    NOT NULL,
    id_librarian_return INTEGER,
    return_date         DATE,

    CONSTRAINT fk_loan_member
        FOREIGN KEY (id_member)
        REFERENCES member(id),

    CONSTRAINT fk_loan_copy
        FOREIGN KEY (id_copy)
        REFERENCES copy(id),

    CONSTRAINT fk_loan_librarian_loan
        FOREIGN KEY (id_librarian_loan)
        REFERENCES librarian(id),

    CONSTRAINT fk_loan_librarian_return
        FOREIGN KEY (id_librarian_return)
        REFERENCES librarian(id)
);

CREATE TABLE reservation (
    id              SERIAL  PRIMARY KEY,
    id_member       INTEGER NOT NULL,
    id_book         INTEGER NOT NULL,
    reservation_date DATE    NOT NULL,
    start_date      DATE    NOT NULL,
    id_librarian    INTEGER,
    treatment_date  DATE,
    id_loan         INTEGER,

    CONSTRAINT fk_reservation_member
        FOREIGN KEY (id_member)
        REFERENCES member(id),

    CONSTRAINT fk_reservation_book
        FOREIGN KEY (id_book)
        REFERENCES book(id),

    CONSTRAINT fk_reservation_librarian
        FOREIGN KEY (id_librarian)
        REFERENCES librarian(id),

    CONSTRAINT fk_reservation_loan
        FOREIGN KEY (id_loan)
        REFERENCES loan(id)
);

CREATE TABLE extension (
    id               SERIAL  PRIMARY KEY,
    id_loan          INTEGER NOT NULL,
    extension_date   DATE    NOT NULL,
    actual_due_date  DATE    NOT NULL,
    ask_due_date     DATE    NOT NULL,
    id_librarian     INTEGER,
    treatment_date   DATE,
    is_allowed       BOOLEAN,

    CONSTRAINT fk_extension_loan
        FOREIGN KEY (id_loan)
        REFERENCES loan(id),

    CONSTRAINT fk_extension_librarian
        FOREIGN KEY (id_librarian)
        REFERENCES librarian(id)
);

CREATE TABLE penality (
    id          SERIAL        PRIMARY KEY,
    id_loan     INTEGER       NOT NULL,
    id_member   INTEGER       NOT NULL,
    due_date    DATE          NOT NULL,
    return_date DATE,
    cost        DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_penality_loan
        FOREIGN KEY (id_loan)
        REFERENCES loan(id),

    CONSTRAINT fk_penality_member
        FOREIGN KEY (id_member)
        REFERENCES member(id)
);

CREATE TABLE payment (
    id            SERIAL  PRIMARY KEY,
    id_penality   INTEGER NOT NULL,
    id_librarian  INTEGER NOT NULL,
    payment_date  DATE    NOT NULL,

    CONSTRAINT fk_payment_penality
        FOREIGN KEY (id_penality)
        REFERENCES penality(id),

    CONSTRAINT fk_payment_librarian
        FOREIGN KEY (id_librarian)
        REFERENCES librarian(id)
);
