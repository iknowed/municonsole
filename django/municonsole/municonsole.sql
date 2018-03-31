BEGIN;
CREATE TABLE "route" (
    "id" serial NOT NULL PRIMARY KEY,
    "tag" varchar(5) NOT NULL,
    "title" varchar(64) NOT NULL,
    "color" text NOT NULL,
    "oppositecolor" text NOT NULL,
    "latmin" double precision NOT NULL,
    "latmax" double precision NOT NULL,
    "lonmin" double precision NOT NULL,
    "lonmax" double precision NOT NULL
)
;
CREATE TABLE "route_stop" (
    "id" serial NOT NULL PRIMARY KEY,
    "seq" integer NOT NULL,
    "route_id" integer NOT NULL REFERENCES "route" ("id") DEFERRABLE INITIALLY DEFERRED,
    "tag" varchar(24) NOT NULL,
    "title" varchar(64) NOT NULL,
    "lat" double precision NOT NULL,
    "lon" double precision NOT NULL,
    "stopid" integer NOT NULL
)
;
CREATE TABLE "direction" (
    "id" serial NOT NULL PRIMARY KEY,
    "route_id" integer NOT NULL REFERENCES "route" ("id") DEFERRABLE INITIALLY DEFERRED,
    "tag" varchar(24) NOT NULL,
    "title" varchar(64) NOT NULL,
    "name" varchar(24) NOT NULL,
    "useforui" integer NOT NULL
)
;
CREATE TABLE "direction_stop" (
    "id" serial NOT NULL PRIMARY KEY,
    "direction_id" integer NOT NULL REFERENCES "direction" ("id") DEFERRABLE INITIALLY DEFERRED,
    "seq" integer NOT NULL,
    "tag" varchar(24) NOT NULL
)
;
CREATE TABLE "path" (
    "id" serial NOT NULL PRIMARY KEY,
    "seq" integer NOT NULL,
    "route_id" integer NOT NULL REFERENCES "route" ("id") DEFERRABLE INITIALLY DEFERRED
)
;
CREATE TABLE "point" (
    "id" serial NOT NULL PRIMARY KEY,
    "seq" integer NOT NULL,
    "path_id" integer NOT NULL REFERENCES "path" ("id") DEFERRABLE INITIALLY DEFERRED,
    "lat" double precision NOT NULL,
    "lon" double precision NOT NULL
)
;
CREATE TABLE "stop" (
    "id" serial NOT NULL PRIMARY KEY,
    "direction_id" integer NOT NULL REFERENCES "direction" ("id") DEFERRABLE INITIALLY DEFERRED,
    "seq" integer NOT NULL,
    "tag" varchar(16) NOT NULL
)
;
CREATE TABLE "speed" (
    "id" serial NOT NULL PRIMARY KEY,
    "route_tag" text NOT NULL,
    "dir_tag" text NOT NULL,
    "path_id" integer NOT NULL REFERENCES "path" ("id") DEFERRABLE INITIALLY DEFERRED,
    "hour" integer NOT NULL,
    "datype" integer NOT NULL,
    "speed" double precision NOT NULL,
    "min" double precision NOT NULL,
    "max" double precision NOT NULL,
    "navg" integer NOT NULL
)
;
CREATE TABLE "vehicle" (
    "id" serial NOT NULL PRIMARY KEY,
    "vid" text NOT NULL,
    "route_id" integer NOT NULL REFERENCES "route" ("id") DEFERRABLE INITIALLY DEFERRED,
    "direction_id" integer NOT NULL REFERENCES "direction" ("id") DEFERRABLE INITIALLY DEFERRED,
    "lat" double precision NOT NULL,
    "lon" double precision NOT NULL,
    "t" bigint NOT NULL,
    "predictable" integer NOT NULL,
    "heading" integer NOT NULL,
    "speedkmhr" double precision NOT NULL,
    "leadingvehicleid" text NOT NULL,
    "stop" text NOT NULL,
    "stop_seq" integer NOT NULL
)
;
CREATE TABLE "run" (
    "id" serial NOT NULL PRIMARY KEY,
    "vehicle_id" integer NOT NULL REFERENCES "vehicle" ("id") DEFERRABLE INITIALLY DEFERRED,
    "route_id" integer NOT NULL REFERENCES "route" ("id") DEFERRABLE INITIALLY DEFERRED,
    "direction_id" integer NOT NULL REFERENCES "direction" ("id") DEFERRABLE INITIALLY DEFERRED,
    "start_time" bigint NOT NULL,
    "end_time" bigint NOT NULL,
    "start_date" timestamp with time zone NOT NULL,
    "end_date" timestamp with time zone NOT NULL,
    "speed" double precision NOT NULL,
    "distance" double precision NOT NULL,
    "log" text NOT NULL,
    "runlets" integer NOT NULL,
    "freq" integer NOT NULL
)
;
CREATE TABLE "runlet" (
    "id" serial NOT NULL PRIMARY KEY,
    "run_id" integer NOT NULL REFERENCES "run" ("id") DEFERRABLE INITIALLY DEFERRED,
    "lat0" double precision NOT NULL,
    "lon0" double precision NOT NULL,
    "t0" integer NOT NULL,
    "latn" double precision NOT NULL,
    "lonn" double precision NOT NULL,
    "tn" integer NOT NULL,
    "path_id" integer NOT NULL REFERENCES "path" ("id") DEFERRABLE INITIALLY DEFERRED,
    "distance" double precision NOT NULL,
    "stop" text NOT NULL,
    "stop_seq" integer NOT NULL
)
;
CREATE TABLE "direction_path" (
    "id" serial NOT NULL PRIMARY KEY,
    "direction_id" integer NOT NULL REFERENCES "direction" ("id") DEFERRABLE INITIALLY DEFERRED,
    "path_id" integer NOT NULL REFERENCES "path" ("id") DEFERRABLE INITIALLY DEFERRED,
    "seq" integer NOT NULL
)
;
COMMIT;
