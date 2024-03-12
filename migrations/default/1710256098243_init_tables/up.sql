CREATE TABLE "public"."products" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "name" text NOT NULL, "public_a" Text, "public_b" text, "semi_public_c" text, "semi_public_d" text, PRIMARY KEY ("id") );
CREATE EXTENSION IF NOT EXISTS pgcrypto;

alter table "public"."products" add column "security" text
    null;
