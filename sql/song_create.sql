BEGIN;

-- CREATE SEQUENCE "artists_id_seq" ----------------------------
CREATE SEQUENCE "artists_id_seq" INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
-- -------------------------------------------------------------

-- CREATE SEQUENCE "albums_id_seq" -----------------------------
CREATE SEQUENCE "albums_id_seq" INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
-- -------------------------------------------------------------

-- CREATE SEQUENCE "songs_id_seq" ------------------------------
CREATE SEQUENCE "songs_id_seq" INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
-- -------------------------------------------------------------

-- CREATE TABLE "artists" --------------------------------------
CREATE TABLE "artists" ( 
	"id" BIGINT DEFAULT nextval('artists_id_seq'::regclass) NOT NULL,
	"created_at" TIMESTAMP( 6 ) WITHOUT TIME ZONE NOT NULL,
	"updated_at" TIMESTAMP( 6 ) WITHOUT TIME ZONE NOT NULL,
	"name" CHARACTER VARYING,
	PRIMARY KEY ( "id" )
);
-- -------------------------------------------------------------

-- CREATE TABLE "albums" ---------------------------------------
CREATE TABLE "albums" ( 
	"id" BIGINT DEFAULT nextval('albums_id_seq'::regclass) NOT NULL,
	"artist_id" BIGINT NOT NULL,
	"release_date" Date,
	"created_at" TIMESTAMP( 6 ) WITHOUT TIME ZONE NOT NULL,
	"updated_at" TIMESTAMP( 6 ) WITHOUT TIME ZONE NOT NULL,
	"title" CHARACTER VARYING,
	PRIMARY KEY ( "id" )
);
-- -------------------------------------------------------------

-- CREATE TABLE "songs" ----------------------------------------
CREATE TABLE "songs" ( 
	"id" BIGINT DEFAULT nextval('songs_id_seq'::regclass) NOT NULL,
	"album_id" BIGINT NOT NULL,
	"order" INTEGER,
	"title" CHARACTER VARYING,
	"created_at" TIMESTAMP( 6 ) WITHOUT TIME ZONE NOT NULL,
	"updated_at" TIMESTAMP( 6 ) WITHOUT TIME ZONE NOT NULL,
	PRIMARY KEY ( "id" )
);
-- -------------------------------------------------------------

-- CREATE INDEX "index_albums_on_artist_id" --------------------
CREATE INDEX "index_albums_on_artist_id" ON "albums" USING btree( "artist_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE INDEX "index_songs_on_album_id" ----------------------
CREATE INDEX "index_songs_on_album_id" ON "songs" USING btree( "album_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE LINK "fk_rails_124a79559a" ---------------------------
ALTER TABLE "albums" ADD CONSTRAINT "albums_artist_id" FOREIGN KEY ( "artist_id" ) REFERENCES "artists" ( "id" ) MATCH SIMPLE ON DELETE NO ACTION ON UPDATE NO ACTION;
-- -------------------------------------------------------------
-- CREATE LINK "fk_rails_f4e40cd655" ---------------------------
ALTER TABLE "songs" ADD CONSTRAINT "songs_album_id" FOREIGN KEY ( "album_id" ) REFERENCES "albums" ( "id" ) MATCH SIMPLE ON DELETE NO ACTION ON UPDATE NO ACTION;
-- -------------------------------------------------------------

-- INSERT INTO "artists" ---------------------------------------
INSERT INTO "artists" ( "name", "created_at", "updated_at" ) 
VALUES
    ( 'Metallica', now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Korn',      now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Kansas',    now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL )
    ;
-- -------------------------------------------------------------

-- INSERT INTO "albums" ----------------------------------------
INSERT INTO "albums" 
    ( "title", "artist_id", "release_date", "created_at", "updated_at") 
VALUES
    ( 'Korn',               (SELECT "id" FROM "artists" WHERE "name" = 'Korn') ,        '10-11-1994', now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Life Is Peachy',     (SELECT "id" FROM "artists" WHERE "name" = 'Korn') ,        '10-15-1996', now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Follow the Leader',  (SELECT "id" FROM "artists" WHERE "name" = 'Korn') ,        '08-18-1998', now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),

    ( 'Kill `Em All',       (SELECT "id" FROM "artists" WHERE "name" = 'Metallica') ,   '07-25-1983', now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Ride the Lightning', (SELECT "id" FROM "artists" WHERE "name" = 'Metallica') ,   '07-27-1984', now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Master of Puppets',  (SELECT "id" FROM "artists" WHERE "name" = 'Metallica') ,   '03-03-1986', now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),

    ( 'Kansas',             (SELECT "id" FROM "artists" WHERE "name" = 'Kansas') ,      '03-08-1974', now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Song for America',   (SELECT "id" FROM "artists" WHERE "name" = 'Kansas') ,      '02-01-1975', now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Masque',             (SELECT "id" FROM "artists" WHERE "name" = 'Kansas') ,      '09-20-1975', now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( 'Leftoverture',       (SELECT "id" FROM "artists" WHERE "name" = 'Kansas') ,      '10-21-1976', now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL )
    ;
-- -------------------------------------------------------------

-- INSERT INTO "songs" -----------------------------------------
INSERT INTO "songs"
    ( "album_id", "order", "title", "created_at", "updated_at") 
VALUES
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Korn'),               1,  'Blind',                                    now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Korn'),               2,  'Ball Tongue',                              now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Korn'),               3,  'Need To',                                  now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Korn'),               4,  'Clown',                                    now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Korn'),               5,  'Divine',                                   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Korn'),               6,  'Faget',                                    now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Korn'),               7,  'Shoots and Ladders',                       now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Korn'),               8,  'Predictable',                              now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Korn'),               9,  'Fake',                                     now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Korn'),               10, 'Lies',                                     now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Korn'),               11, 'Helmet in the Bush',                       now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Korn'),               12, 'Daddy',                                    now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),

    ( (SELECT "id" FROM "albums" WHERE "title" = 'Life Is Peachy'),     1,  'Twist',                                    now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Life Is Peachy'),     2,  'Chi',                                      now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Life Is Peachy'),     3,  'Lost',                                     now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Life Is Peachy'),     4,  'Swallow',                                  now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Life Is Peachy'),     5,  'Porno Creep',                              now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Life Is Peachy'),     6,  'Good God',                                 now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Life Is Peachy'),     7,  'Mr. Rogers',                               now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Life Is Peachy'),     8,  'Kunts!',                                   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Life Is Peachy'),     9,  'No Place to Hide',                         now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Life Is Peachy'),     10, 'Wicked',                                   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Life Is Peachy'),     11, 'A.D.I.D.A.S.',                             now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Life Is Peachy'),     12, 'Lowrider',                                 now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Life Is Peachy'),     13, 'Ass Itch',                                 now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Life Is Peachy'),     14, 'Kill You',                                 now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),

    ( (SELECT "id" FROM "albums" WHERE "title" = 'Follow the Leader'),  1,  'It`s On!',                                 now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Follow the Leader'),  2,  'Freak on a Leash',                         now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Follow the Leader'),  3,  'Got the Life',                             now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Follow the Leader'),  4,  'Dead Bodies Everywhere',                   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Follow the Leader'),  5,  'Children of the Korn',                     now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Follow the Leader'),  6,  'B.B.K.',                                   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Follow the Leader'),  7,  'Pretty',                                   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Follow the Leader'),  8,  'All in the Family',                        now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Follow the Leader'),  9,  'Reclaim My Place',                         now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Follow the Leader'),  10, 'Justin',                                   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Follow the Leader'),  11, 'Seed',                                     now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Follow the Leader'),  12, 'Cameltosis',                               now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Follow the Leader'),  13, 'My Gift to You',                           now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),

    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kill `Em All'),       1,  'Hit the Lights',                           now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kill `Em All'),       2,  'The Four Horsemen',                        now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kill `Em All'),       3,  'Motorbreath',                              now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kill `Em All'),       4,  'Jump in the Fire',                         now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kill `Em All'),       5,  '(Anesthesia)—Pulling Teeth',               now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kill `Em All'),       6,  'Whiplash',                                 now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kill `Em All'),       7,  'Phantom Lord',                             now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kill `Em All'),       8,  'No Remorse',                               now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kill `Em All'),       9,  'Seek & Destroy',                           now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kill `Em All'),       10, 'Metal Militia',                            now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),

    ( (SELECT "id" FROM "albums" WHERE "title" = 'Ride the Lightning'), 1,  'Fight Fire with Fire',                     now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Ride the Lightning'), 2,  'Ride the Lightning',                       now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Ride the Lightning'), 3,  'For Whom the Bell Tolls',                  now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Ride the Lightning'), 4,  'Fade to Black',                            now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Ride the Lightning'), 5,  'Trapped Under Ice',                        now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Ride the Lightning'), 6,  'Escape',                                   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Ride the Lightning'), 7,  'Creeping Death',                           now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Ride the Lightning'), 8,  'The Call of Ktulu',                        now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),

    ( (SELECT "id" FROM "albums" WHERE "title" = 'Master of Puppets'),  1,  'Battery',                                  now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Master of Puppets'),  2,  'Master of Puppets',                        now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Master of Puppets'),  3,  'The Thing That Should Not Be',             now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Master of Puppets'),  4,  'Welcome Home (Sanitarium)',                now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Master of Puppets'),  5,  'Disposable Heroes',                        now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Master of Puppets'),  6,  'Leper Messiah',                            now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Master of Puppets'),  7,  'Orion',                                    now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Master of Puppets'),  8,  'Damage, Inc.',                             now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Master of Puppets'),  9,  'Battery (Live)',                           now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Master of Puppets'),  10, 'The Thing That Should Not Be (Live)',      now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),

    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kansas'),             1, 'Can I Tell You',                            now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kansas'),             2, 'Bringing It Back',                          now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kansas'),             3, 'Lonely Wind',                               now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kansas'),             4, 'Belexes',                                   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kansas'),             5, 'Journey from Mariabronn',                   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kansas'),             6, 'The Pilgrimage',                            now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kansas'),             7, 'Aperçu',                                    now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Kansas'),             8, 'Death of Mother Nature Suite',              now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),

    ( (SELECT "id" FROM "albums" WHERE "title" = 'Song for America'),   1, 'Down the Road',                             now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Song for America'),   2, 'Song for America',                          now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Song for America'),   3, 'Lamplight Symphony',                        now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Song for America'),   4, 'Lonely Street',                             now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Song for America'),   5, 'The Devil Game',                            now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Song for America'),   6, 'Incomudro - Hymn to the Atman',             now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),

    ( (SELECT "id" FROM "albums" WHERE "title" = 'Masque'),             1, 'It Takes a Woman`s Love (To Make a Man)',   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Masque'),             2, 'Two Cents Worth',                           now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Masque'),             3, 'Icarus - Borne on Wings of Steel',          now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Masque'),             4, 'All the World',                             now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Masque'),             5, 'Child of Innocence',                        now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Masque'),             6, 'It`s You',                                  now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Masque'),             7, 'Mysteries and Mayhem',                      now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Masque'),             8, 'The Pinnacle',                              now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),

    ( (SELECT "id" FROM "albums" WHERE "title" = 'Leftoverture'),       1, 'Carry On Wayward Son',                      now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Leftoverture'),       2, 'The Wall',                                  now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Leftoverture'),       3, 'What`s on My Mind',                         now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Leftoverture'),       4, 'Miracles Out of Nowhere',                   now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Leftoverture'),       5, 'Opus Insert',                               now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Leftoverture'),       6, 'Questions of My Childhood',                 now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Leftoverture'),       7, 'Cheyenne Anthem',                           now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL ),
    ( (SELECT "id" FROM "albums" WHERE "title" = 'Leftoverture'),       8, 'Magnum Opus',                               now() - '1 week'::INTERVAL, now() - '1 week'::INTERVAL )
    ;
-- -------------------------------------------------------------

-- UPDATE "config.current" -------------------------------------
INSERT INTO "configs" 
VALUES ('current_status','song')
ON CONFLICT ("key")
DO UPDATE SET VALUE = 'song';
-- -------------------------------------------------------------

COMMIT;