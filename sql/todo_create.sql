BEGIN;

-- CREATE SEQUENCE "todos_id_seq" ------------------------------
CREATE SEQUENCE IF NOT EXISTS "public"."todos_id_seq"
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
-- -------------------------------------------------------------

-- CREATE TABLE "todos" ----------------------------------------
CREATE TABLE IF NOT EXISTS "todos" ( 
	"id" BIGINT DEFAULT nextval('todos_id_seq'::regclass) NOT NULL,
	"title" CHARACTER VARYING,
	"completed" BOOLEAN,
	"created_at" TIMESTAMP( 6 ) WITHOUT TIME ZONE NOT NULL,
	"updated_at" TIMESTAMP( 6 ) WITHOUT TIME ZONE NOT NULL,
	PRIMARY KEY ( "id" ) );
	;
-- -------------------------------------------------------------

-- INSERT INTO "todos" -----------------------------------------
INSERT INTO "todos" ( "title", "completed", "created_at", "updated_at") 
VALUES
	( 'Buy Milk',           FALSE, now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
	( 'Build SQL Test App',  TRUE, now() - '1 week'::INTERVAL, now() ),
	( 'Watch Wandavision',   TRUE, now() - '3 week'::INTERVAL, now() - '1 week'::INTERVAL ),
	( 'Call Dean',          FALSE, now() - '2 week'::INTERVAL, now() - '2 week'::INTERVAL ),
	( 'book Flight Ticket',  TRUE, now() - '4 week'::INTERVAL, now() -  '1 day'::INTERVAL ),
	( 'Fight the power',    FALSE, now() - '3 week'::INTERVAL, now() - '3 week'::INTERVAL )
	;
-- -------------------------------------------------------------

-- UPDATE "config.current" -------------------------------------
INSERT INTO "configs" 
VALUES ('current_status','todo')
ON CONFLICT ("key")
DO UPDATE SET VALUE = 'todo';
-- -------------------------------------------------------------

COMMIT;