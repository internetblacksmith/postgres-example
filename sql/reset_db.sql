BEGIN;

-- DROP SEQUENCE "todos_id_seq" --------------------------------
DROP SEQUENCE IF EXISTS "todos_id_seq" CASCADE;
-- -------------------------------------------------------------

-- DROP TABLE "todos" ------------------------------------------
DROP TABLE IF EXISTS "todos" CASCADE;
-- -------------------------------------------------------------

-- DROP SEQUENCE "artists_id_seq" ------------------------------
DROP SEQUENCE IF EXISTS "artists_id_seq" CASCADE;
-- -------------------------------------------------------------

-- DROP SEQUENCE "albums_id_seq" -------------------------------
DROP SEQUENCE IF EXISTS "albums_id_seq" CASCADE;
-- -------------------------------------------------------------

-- DROP SEQUENCE "songs_id_seq" --------------------------------
DROP SEQUENCE IF EXISTS "songs_id_seq" CASCADE;
-- -------------------------------------------------------------

-- DROP LINK "fk_rails_124a79559a" -----------------------------
ALTER TABLE IF EXISTS "albums" DROP CONSTRAINT IF EXISTS "albums_artist_id";
-- -------------------------------------------------------------

-- DROP LINK "fk_rails_f4e40cd655" -----------------------------
ALTER TABLE IF EXISTS "songs" DROP CONSTRAINT IF EXISTS "songs_album_id";
-- -------------------------------------------------------------

-- DROP TABLE "artists" ----------------------------------------
DROP TABLE IF EXISTS "artists" CASCADE;
-- -------------------------------------------------------------

-- DROP TABLE "albums" -----------------------------------------
DROP TABLE IF EXISTS "albums" CASCADE;
-- -------------------------------------------------------------

-- DROP TABLE "songs" ------------------------------------------
DROP TABLE IF EXISTS "songs" CASCADE;
-- -------------------------------------------------------------

-- DROP TABLE "users" ------------------------------------------
DROP TABLE IF EXISTS "users" CASCADE;
-- -------------------------------------------------------------

-- DROP TABLE "channels" ---------------------------------------
DROP TABLE IF EXISTS "channels" CASCADE;
-- -------------------------------------------------------------

-- DROP TABLE "channel_memberships" ----------------------------
DROP TABLE IF EXISTS "channel_memberships" CASCADE;
-- -------------------------------------------------------------

-- DROP SEQUENCE "users_id_seq" --------------------------------
DROP SEQUENCE IF EXISTS "users_id_seq" CASCADE;
-- -------------------------------------------------------------

-- DROP SEQUENCE "channels_id_seq"" ----------------------------
DROP SEQUENCE IF EXISTS "channels_id_seq" CASCADE;
-- -------------------------------------------------------------

-- DROP SEQUENCE "channel_memberships_id_seq" ------------------
DROP SEQUENCE IF EXISTS "channel_memberships_id_seq" CASCADE;
-- -------------------------------------------------------------

-- CREATE TABLE "config" ---------------------------------------
CREATE TABLE IF NOT EXISTS "configs" (
	"key" CHARACTER VARYING NOT NULL,
	"value" CHARACTER VARYING NOT NULL,
	CONSTRAINT "unique_config_current_config" UNIQUE( "key" ) );
 ;
-- -------------------------------------------------------------
COMMIT;