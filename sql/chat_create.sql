BEGIN;

-- CREATE SEQUENCE "users_id_seq" ------------------------------
CREATE SEQUENCE "users_id_seq" INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
-- -------------------------------------------------------------

-- CREATE TABLE "users" ----------------------------------------
CREATE TABLE "users" ( 
	"id" BIGINT DEFAULT nextval('users_id_seq'::regclass) NOT NULL,
	"created_at" TIMESTAMP( 6 ) WITHOUT TIME ZONE NOT NULL,
	"updated_at" TIMESTAMP( 6 ) WITHOUT TIME ZONE NOT NULL,
	"name" CHARACTER VARYING,
	PRIMARY KEY ( "id" ) 
);
-- -------------------------------------------------------------

-- CREATE SEQUENCE "channels_id_seq" ---------------------------
CREATE SEQUENCE "channels_id_seq" INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
-- -------------------------------------------------------------

-- CREATE TABLE "channels" -------------------------------------
CREATE TABLE "channels" ( 
	"id" BIGINT DEFAULT nextval('channels_id_seq'::regclass) NOT NULL,
	"created_at" TIMESTAMP( 6 ) WITHOUT TIME ZONE NOT NULL,
	"updated_at" TIMESTAMP( 6 ) WITHOUT TIME ZONE NOT NULL,
	"title" CHARACTER VARYING,
	PRIMARY KEY ( "id" )
);
-- -------------------------------------------------------------

-- CREATE SEQUENCE "channel_memberships_id_seq" ----------------------
CREATE SEQUENCE "channel_memberships_id_seq" INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
-- -------------------------------------------------------------

-- CREATE TABLE "channel_memberships" --------------------------------
CREATE TABLE "channel_memberships" ( 
	"id" BIGINT DEFAULT nextval('channel_memberships_id_seq'::regclass) NOT NULL,
	"user_id" BIGINT NOT NULL,
	"channel_id" BIGINT NOT NULL,
	"created_at" TIMESTAMP( 6 ) WITHOUT TIME ZONE NOT NULL,
	"updated_at" TIMESTAMP( 6 ) WITHOUT TIME ZONE NOT NULL,
	PRIMARY KEY ( "id" )
);
-- -------------------------------------------------------------

-- CREATE INDEX "index_channel_memberships_on_user_id" ---------------
CREATE INDEX "index_channel_memberships_on_user_id" ON "channel_memberships" USING btree( "user_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE INDEX "index_channel_memberships_on_channel_id" ------------
CREATE INDEX "index_channel_memberships_on_channel_id" ON "channel_memberships" USING btree( "channel_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE LINK "channel_memberships_user_id" ---------------------------
ALTER TABLE "channel_memberships" ADD CONSTRAINT "channel_memberships_user_id" FOREIGN KEY ( "user_id" ) REFERENCES "users" ( "id" ) MATCH SIMPLE ON DELETE NO ACTION ON UPDATE NO ACTION;
-- -------------------------------------------------------------

-- CREATE LINK "channel_memberships_channel_id" ---------------------------
ALTER TABLE "channel_memberships" ADD CONSTRAINT "channel_memberships_channel_id" FOREIGN KEY ( "channel_id" ) REFERENCES "channels" ( "id" ) MATCH SIMPLE ON DELETE NO ACTION ON UPDATE NO ACTION;
-- -------------------------------------------------------------

-- INSERT INTO "users" -----------------------------------------
INSERT INTO "users" ( "name", "created_at", "updated_at") 
VALUES
    ( 'Paul',     now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Emilee',   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Mirella',  now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Manuel',   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Andera',   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Danika',   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Maricela', now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Lourie',   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Quinton',  now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Marcia',   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Jeanne',   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL )
;
-- -------------------------------------------------------------

-- INSERT INTO "channels" --------------------------------------
INSERT INTO "channels" ( "title", "created_at", "updated_at") 
VALUES
    ( 'Book worms',   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Social',       now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Birdwatching', now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Movie',        now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Comics',       now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL )
;
-- -------------------------------------------------------------

-- INSERT INOT "channel_memberships" ---------------------------
INSERT INTO "channel_memberships" ( "user_id", "channel_id", "created_at", "updated_at") 
VALUES
    ( (SELECT "id" FROM "users" WHERE "name" = 'Mirella'),  (SELECT "id" FROM "channels" WHERE "title" = 'Book worms'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Quinton'),  (SELECT "id" FROM "channels" WHERE "title" = 'Book worms'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Manuel'),   (SELECT "id" FROM "channels" WHERE "title" = 'Book worms'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Danika'),   (SELECT "id" FROM "channels" WHERE "title" = 'Book worms'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Lourie'),   (SELECT "id" FROM "channels" WHERE "title" = 'Book worms'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Jeanne'),   (SELECT "id" FROM "channels" WHERE "title" = 'Book worms'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    
    ( (SELECT "id" FROM "users" WHERE "name" = 'Manuel'),   (SELECT "id" FROM "channels" WHERE "title" = 'Social'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Marcia'),   (SELECT "id" FROM "channels" WHERE "title" = 'Social'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Quinton'),  (SELECT "id" FROM "channels" WHERE "title" = 'Social'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Danika'),   (SELECT "id" FROM "channels" WHERE "title" = 'Social'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Emilee'),   (SELECT "id" FROM "channels" WHERE "title" = 'Social'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Lourie'),   (SELECT "id" FROM "channels" WHERE "title" = 'Social'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Andera'),   (SELECT "id" FROM "channels" WHERE "title" = 'Social'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Jeanne'),   (SELECT "id" FROM "channels" WHERE "title" = 'Social'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),

    ( (SELECT "id" FROM "users" WHERE "name" = 'Manuel'),   (SELECT "id" FROM "channels" WHERE "title" = 'Birdwatching'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Marcia'),   (SELECT "id" FROM "channels" WHERE "title" = 'Birdwatching'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Quinton'),  (SELECT "id" FROM "channels" WHERE "title" = 'Birdwatching'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Danika'),   (SELECT "id" FROM "channels" WHERE "title" = 'Birdwatching'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Emilee'),   (SELECT "id" FROM "channels" WHERE "title" = 'Birdwatching'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Lourie'),   (SELECT "id" FROM "channels" WHERE "title" = 'Birdwatching'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Andera'),   (SELECT "id" FROM "channels" WHERE "title" = 'Birdwatching'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Jeanne'),   (SELECT "id" FROM "channels" WHERE "title" = 'Birdwatching'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Paul'),     (SELECT "id" FROM "channels" WHERE "title" = 'Birdwatching'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Maricela'), (SELECT "id" FROM "channels" WHERE "title" = 'Birdwatching'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Mirella'),  (SELECT "id" FROM "channels" WHERE "title" = 'Birdwatching'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),

    ( (SELECT "id" FROM "users" WHERE "name" = 'Lourie'),   (SELECT "id" FROM "channels" WHERE "title" = 'Movie'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Andera'),   (SELECT "id" FROM "channels" WHERE "title" = 'Movie'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Jeanne'),   (SELECT "id" FROM "channels" WHERE "title" = 'Movie'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    
    ( (SELECT "id" FROM "users" WHERE "name" = 'Manuel'),   (SELECT "id" FROM "channels" WHERE "title" = 'Comics'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Marcia'),   (SELECT "id" FROM "channels" WHERE "title" = 'Comics'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Quinton'),  (SELECT "id" FROM "channels" WHERE "title" = 'Comics'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Danika'),   (SELECT "id" FROM "channels" WHERE "title" = 'Comics'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Emilee'),   (SELECT "id" FROM "channels" WHERE "title" = 'Comics'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Lourie'),   (SELECT "id" FROM "channels" WHERE "title" = 'Comics'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Andera'),   (SELECT "id" FROM "channels" WHERE "title" = 'Comics'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Jeanne'),   (SELECT "id" FROM "channels" WHERE "title" = 'Comics'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Paul'),     (SELECT "id" FROM "channels" WHERE "title" = 'Comics'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Maricela'), (SELECT "id" FROM "channels" WHERE "title" = 'Comics'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "users" WHERE "name" = 'Mirella'),  (SELECT "id" FROM "channels" WHERE "title" = 'Comics'),   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL )
;
-- -------------------------------------------------------------

-- UPDATE "config.current" -------------------------------------
INSERT INTO "configs" 
VALUES ('current_status','chat')
ON CONFLICT ("key")
DO UPDATE SET VALUE = 'chat';
-- -------------------------------------------------------------

COMMIT;