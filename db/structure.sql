CREATE TABLE "beer_clubs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "year" integer, "city" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "beers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "style" varchar(255), "brewery_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "breweries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "year" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "memberships" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime, "updated_at" datetime, "user_id" integer, "beer_club_id" integer);
CREATE TABLE "ratings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "score" integer, "beer_id" integer, "created_at" datetime, "updated_at" datetime, "user_id" integer);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "settings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "var" varchar(255) NOT NULL, "value" text, "thing_id" integer, "thing_type" varchar(30), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar(255), "created_at" datetime, "updated_at" datetime, "password_digest" varchar(255), "admin" boolean);
CREATE UNIQUE INDEX "index_settings_on_thing_type_and_thing_id_and_var" ON "settings" ("thing_type", "thing_id", "var");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20140119135556');

INSERT INTO schema_migrations (version) VALUES ('20140119150711');

INSERT INTO schema_migrations (version) VALUES ('20140120151927');

INSERT INTO schema_migrations (version) VALUES ('20140131100823');

INSERT INTO schema_migrations (version) VALUES ('20140131154120');

INSERT INTO schema_migrations (version) VALUES ('20140131170235');

INSERT INTO schema_migrations (version) VALUES ('20140131201013');

INSERT INTO schema_migrations (version) VALUES ('20140201121809');

INSERT INTO schema_migrations (version) VALUES ('20140201121906');

INSERT INTO schema_migrations (version) VALUES ('20140201122751');

INSERT INTO schema_migrations (version) VALUES ('20140201122802');

INSERT INTO schema_migrations (version) VALUES ('20140209134853');

INSERT INTO schema_migrations (version) VALUES ('20140214174706');
