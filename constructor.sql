CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm ";

CREATE TABLE IF NOT EXISTS users (
    "id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "email" VARCHAR ( 100 ) NOT NULL,
    "cpf" VARCHAR ( 155 ) NOT NULL,
    "name" VARCHAR ( 255 ) NOT NULL,
    "skills" VARCHAR ( 255 ),
    "created_at" TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "deleted_at" TIMESTAMP,
    "last_login" TIMESTAMP,
    "created_by" INT NOT NULL,
    "updated_by" INT,
    "deleted_by" INT,
    UNIQUE NULLS NOT DISTINCT ("email", "deleted_at"),
    UNIQUE NULLS NOT DISTINCT ("cpf", "deleted_at")
);
CREATE UNIQUE INDEX IF NOT EXISTS "users_email_index" ON "users" ("email") WHERE "deleted_at" IS NULL;
CREATE INDEX IF NOT EXISTS "users_skills_index" ON "users" ("skills") WHERE "deleted_at" IS NULL;


CREATE TABLE IF NOT EXISTS projects (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR ( 255 ) NOT NULL,
    "data" JSONB DEFAULT NULL,
    "created_at" TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "deleted_at" TIMESTAMP,
    "created_by" INT NOT NULL,
    "updated_by" INT,
    "deleted_by" INT,
    UNIQUE NULLS NOT DISTINCT ("name", "deleted_at")
);
CREATE UNIQUE INDEX IF NOT EXISTS "projects_name" ON "projects" ("name") WHERE "deleted_at" IS NULL;


CREATE TABLE IF NOT EXISTS rates (
    "id" SERIAL PRIMARY KEY,
    "project" INTEGER,
    "user" UUID NOT NULL,
    "rate" NUMERIC(3, 2),
    "created_at" TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "deleted_at" TIMESTAMP,
    "last_login" TIMESTAMP,
    "created_by" INT NOT NULL,
    "updated_by" INT,
    "deleted_by" INT,
    UNIQUE NULLS NOT DISTINCT ("project", "user", "deleted_at"),
    FOREIGN KEY ("project") REFERENCES "projects" ("id") ON DELETE SET NULL,
    FOREIGN KEY ("user") REFERENCES "users" ("id") ON DELETE CASCADE
);
CREATE INDEX IF NOT EXISTS "rates_project" ON "rates" USING HASH ("project") WHERE "deleted_at" IS NULL;