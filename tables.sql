--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: route; Type: TABLE; Schema: public; Owner: muni; Tablespace: 
--

CREATE TABLE route (
    id integer NOT NULL,
    tag character varying(5) NOT NULL,
    title character varying(64) NOT NULL,
    color text NOT NULL,
    oppositecolor text NOT NULL,
    latmin double precision NOT NULL,
    latmax double precision NOT NULL,
    lonmin double precision NOT NULL,
    lonmax double precision NOT NULL
);


ALTER TABLE public.route OWNER TO muni;

--
-- Name: route_id_seq; Type: SEQUENCE; Schema: public; Owner: muni
--

CREATE SEQUENCE route_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.route_id_seq OWNER TO muni;

--
-- Name: route_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muni
--

ALTER SEQUENCE route_id_seq OWNED BY route.id;


--
-- Name: route_stop; Type: TABLE; Schema: public; Owner: muni; Tablespace: 
--

CREATE TABLE route_stop (
    id integer NOT NULL,
    seq integer NOT NULL,
    route_id integer NOT NULL,
    tag character varying(24) NOT NULL,
    title character varying(64) NOT NULL,
    lat double precision NOT NULL,
    lon double precision NOT NULL,
    stopid integer NOT NULL,
    loc geometry NOT NULL,
    CONSTRAINT enforce_dims_loc CHECK ((st_ndims(loc) = 2)),
    CONSTRAINT enforce_srid_loc CHECK ((st_srid(loc) = 100000))
);


ALTER TABLE public.route_stop OWNER TO muni;

--
-- Name: route_stop_id_seq; Type: SEQUENCE; Schema: public; Owner: muni
--

CREATE SEQUENCE route_stop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.route_stop_id_seq OWNER TO muni;

--
-- Name: route_stop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muni
--

ALTER SEQUENCE route_stop_id_seq OWNED BY route_stop.id;


--
-- Name: run; Type: TABLE; Schema: public; Owner: muni; Tablespace: 
--

CREATE TABLE run (
    id integer NOT NULL,
    vehicle_id text NOT NULL,
    route_tag text NOT NULL,
    dir_tag text NOT NULL,
    start_time bigint NOT NULL,
    end_time bigint NOT NULL,
    start_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone NOT NULL,
    speed double precision NOT NULL,
    distance double precision NOT NULL,
    log text NOT NULL,
    runlets integer NOT NULL,
    freq integer NOT NULL
);


ALTER TABLE public.run OWNER TO muni;

--
-- Name: run_id_seq; Type: SEQUENCE; Schema: public; Owner: muni
--

CREATE SEQUENCE run_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.run_id_seq OWNER TO muni;

--
-- Name: run_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muni
--

ALTER SEQUENCE run_id_seq OWNED BY run.id;


--
-- Name: runlet; Type: TABLE; Schema: public; Owner: muni; Tablespace: 
--

CREATE TABLE runlet (
    id integer NOT NULL,
    run_id integer NOT NULL,
    lat0 double precision NOT NULL,
    lon0 double precision NOT NULL,
    t0 integer NOT NULL,
    latn double precision NOT NULL,
    lonn double precision NOT NULL,
    tn integer NOT NULL,
    path_id integer NOT NULL,
    distance double precision NOT NULL,
    stop text NOT NULL,
    stop_seq integer NOT NULL,
    loc0 geometry NOT NULL,
    locn geometry NOT NULL,
    CONSTRAINT enforce_dims_loc0 CHECK ((st_ndims(loc0) = 2)),
    CONSTRAINT enforce_dims_locn CHECK ((st_ndims(locn) = 2)),
    CONSTRAINT enforce_srid_loc0 CHECK ((st_srid(loc0) = 100000)),
    CONSTRAINT enforce_srid_locn CHECK ((st_srid(locn) = 100000))
);


ALTER TABLE public.runlet OWNER TO muni;

--
-- Name: runlet_id_seq; Type: SEQUENCE; Schema: public; Owner: muni
--

CREATE SEQUENCE runlet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.runlet_id_seq OWNER TO muni;

--
-- Name: runlet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muni
--

ALTER SEQUENCE runlet_id_seq OWNED BY runlet.id;


--
-- Name: speed; Type: TABLE; Schema: public; Owner: muni; Tablespace: 
--

CREATE TABLE speed (
    id integer NOT NULL,
    route_tag text NOT NULL,
    dir_tag text NOT NULL,
    path_id integer NOT NULL,
    hour integer NOT NULL,
    datype integer NOT NULL,
    speed double precision NOT NULL,
    min double precision NOT NULL,
    max double precision NOT NULL,
    navg integer NOT NULL
);


ALTER TABLE public.speed OWNER TO muni;

--
-- Name: speed_id_seq; Type: SEQUENCE; Schema: public; Owner: muni
--

CREATE SEQUENCE speed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.speed_id_seq OWNER TO muni;

--
-- Name: speed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muni
--

ALTER SEQUENCE speed_id_seq OWNED BY speed.id;


--
-- Name: stop; Type: TABLE; Schema: public; Owner: muni; Tablespace: 
--

CREATE TABLE stop (
    id integer NOT NULL,
    direction_id integer NOT NULL,
    seq integer NOT NULL,
    tag character varying(16) NOT NULL
);


ALTER TABLE public.stop OWNER TO muni;

--
-- Name: stop_id_seq; Type: SEQUENCE; Schema: public; Owner: muni
--

CREATE SEQUENCE stop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.stop_id_seq OWNER TO muni;

--
-- Name: stop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muni
--

ALTER SEQUENCE stop_id_seq OWNED BY stop.id;


--
-- Name: vehicle; Type: TABLE; Schema: public; Owner: muni; Tablespace: 
--

CREATE TABLE vehicle (
    id integer NOT NULL,
    vid text NOT NULL,
    routetag character varying(5) NOT NULL,
    dirtag character varying(16) NOT NULL,
    lat double precision NOT NULL,
    lon double precision NOT NULL,
    t bigint NOT NULL,
    predictable integer NOT NULL,
    heading integer NOT NULL,
    speedkmhr double precision NOT NULL,
    leadingvehicleid text NOT NULL,
    stop text NOT NULL,
    stop_seq integer NOT NULL,
    loc geometry NOT NULL,
    CONSTRAINT enforce_dims_loc CHECK ((st_ndims(loc) = 2)),
    CONSTRAINT enforce_srid_loc CHECK ((st_srid(loc) = 100000))
);


ALTER TABLE public.vehicle OWNER TO muni;

--
-- Name: vehicle_id_seq; Type: SEQUENCE; Schema: public; Owner: muni
--

CREATE SEQUENCE vehicle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.vehicle_id_seq OWNER TO muni;

--
-- Name: vehicle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muni
--

ALTER SEQUENCE vehicle_id_seq OWNED BY vehicle.id;


--
-- Name: yards; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE yards (
    gid integer NOT NULL,
    objectid numeric(11,0),
    land_id character varying(11),
    land_name character varying(100),
    category character varying(50),
    city_owned character varying(1),
    dept integer,
    the_geom geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((st_srid(the_geom) = 100000))
);


ALTER TABLE public.yards OWNER TO root;

--
-- Name: yards_gid_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE yards_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.yards_gid_seq OWNER TO root;

--
-- Name: yards_gid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE yards_gid_seq OWNED BY yards.gid;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: muni
--

ALTER TABLE ONLY route ALTER COLUMN id SET DEFAULT nextval('route_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: muni
--

ALTER TABLE ONLY route_stop ALTER COLUMN id SET DEFAULT nextval('route_stop_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: muni
--

ALTER TABLE ONLY run ALTER COLUMN id SET DEFAULT nextval('run_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: muni
--

ALTER TABLE ONLY runlet ALTER COLUMN id SET DEFAULT nextval('runlet_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: muni
--

ALTER TABLE ONLY speed ALTER COLUMN id SET DEFAULT nextval('speed_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: muni
--

ALTER TABLE ONLY stop ALTER COLUMN id SET DEFAULT nextval('stop_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: muni
--

ALTER TABLE ONLY vehicle ALTER COLUMN id SET DEFAULT nextval('vehicle_id_seq'::regclass);


--
-- Name: gid; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY yards ALTER COLUMN gid SET DEFAULT nextval('yards_gid_seq'::regclass);


--
-- Name: route_pkey; Type: CONSTRAINT; Schema: public; Owner: muni; Tablespace: 
--

ALTER TABLE ONLY route
    ADD CONSTRAINT route_pkey PRIMARY KEY (id);


--
-- Name: route_stop_pkey; Type: CONSTRAINT; Schema: public; Owner: muni; Tablespace: 
--

ALTER TABLE ONLY route_stop
    ADD CONSTRAINT route_stop_pkey PRIMARY KEY (id);


--
-- Name: run_pkey; Type: CONSTRAINT; Schema: public; Owner: muni; Tablespace: 
--

ALTER TABLE ONLY run
    ADD CONSTRAINT run_pkey PRIMARY KEY (id);


--
-- Name: runlet_pkey; Type: CONSTRAINT; Schema: public; Owner: muni; Tablespace: 
--

ALTER TABLE ONLY runlet
    ADD CONSTRAINT runlet_pkey PRIMARY KEY (id);


--
-- Name: speed_pkey; Type: CONSTRAINT; Schema: public; Owner: muni; Tablespace: 
--

ALTER TABLE ONLY speed
    ADD CONSTRAINT speed_pkey PRIMARY KEY (id);


--
-- Name: stop_pkey; Type: CONSTRAINT; Schema: public; Owner: muni; Tablespace: 
--

ALTER TABLE ONLY stop
    ADD CONSTRAINT stop_pkey PRIMARY KEY (id);


--
-- Name: vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: muni; Tablespace: 
--

ALTER TABLE ONLY vehicle
    ADD CONSTRAINT vehicle_pkey PRIMARY KEY (id);


--
-- Name: yards_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY yards
    ADD CONSTRAINT yards_pkey PRIMARY KEY (gid);


--
-- Name: route_stop_lat; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX route_stop_lat ON route_stop USING btree (lat);


--
-- Name: route_stop_loc_id; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX route_stop_loc_id ON route_stop USING gist (loc);


--
-- Name: route_stop_lon; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX route_stop_lon ON route_stop USING btree (lon);


--
-- Name: route_stop_route_id; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX route_stop_route_id ON route_stop USING btree (route_id);


--
-- Name: route_stop_seq; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX route_stop_seq ON route_stop USING btree (seq);


--
-- Name: route_stop_stopid; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX route_stop_stopid ON route_stop USING btree (stopid);


--
-- Name: route_stop_tag; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX route_stop_tag ON route_stop USING btree (tag);


--
-- Name: route_stop_tag_like; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX route_stop_tag_like ON route_stop USING btree (tag varchar_pattern_ops);


--
-- Name: route_stop_title; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX route_stop_title ON route_stop USING btree (title);


--
-- Name: route_stop_title_like; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX route_stop_title_like ON route_stop USING btree (title varchar_pattern_ops);


--
-- Name: run_dir_tag; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX run_dir_tag ON run USING btree (dir_tag);


--
-- Name: run_dir_tag_like; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX run_dir_tag_like ON run USING btree (dir_tag text_pattern_ops);


--
-- Name: run_distance; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX run_distance ON run USING btree (distance);


--
-- Name: run_end_date; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX run_end_date ON run USING btree (end_date);


--
-- Name: run_end_time; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX run_end_time ON run USING btree (end_time);


--
-- Name: run_freq; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX run_freq ON run USING btree (freq);


--
-- Name: run_route_tag; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX run_route_tag ON run USING btree (route_tag);


--
-- Name: run_route_tag_like; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX run_route_tag_like ON run USING btree (route_tag text_pattern_ops);


--
-- Name: run_runlets; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX run_runlets ON run USING btree (runlets);


--
-- Name: run_speed; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX run_speed ON run USING btree (speed);


--
-- Name: run_start_date; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX run_start_date ON run USING btree (start_date);


--
-- Name: run_start_time; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX run_start_time ON run USING btree (start_time);


--
-- Name: run_vehicle_id; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX run_vehicle_id ON run USING btree (vehicle_id);


--
-- Name: run_vehicle_id_like; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX run_vehicle_id_like ON run USING btree (vehicle_id text_pattern_ops);


--
-- Name: runlet_distance; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX runlet_distance ON runlet USING btree (distance);


--
-- Name: runlet_lat0; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX runlet_lat0 ON runlet USING btree (lat0);


--
-- Name: runlet_latn; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX runlet_latn ON runlet USING btree (latn);


--
-- Name: runlet_loc0_id; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX runlet_loc0_id ON runlet USING gist (loc0);


--
-- Name: runlet_locn_id; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX runlet_locn_id ON runlet USING gist (locn);


--
-- Name: runlet_lon0; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX runlet_lon0 ON runlet USING btree (lon0);


--
-- Name: runlet_lonn; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX runlet_lonn ON runlet USING btree (lonn);


--
-- Name: runlet_path_id; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX runlet_path_id ON runlet USING btree (path_id);


--
-- Name: runlet_run_id; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX runlet_run_id ON runlet USING btree (run_id);


--
-- Name: runlet_t0; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX runlet_t0 ON runlet USING btree (t0);


--
-- Name: runlet_tn; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX runlet_tn ON runlet USING btree (tn);


--
-- Name: speed_datype; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX speed_datype ON speed USING btree (datype);


--
-- Name: speed_dir_tag; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX speed_dir_tag ON speed USING btree (dir_tag);


--
-- Name: speed_dir_tag_like; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX speed_dir_tag_like ON speed USING btree (dir_tag text_pattern_ops);


--
-- Name: speed_hour; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX speed_hour ON speed USING btree (hour);


--
-- Name: speed_max; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX speed_max ON speed USING btree (max);


--
-- Name: speed_min; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX speed_min ON speed USING btree (min);


--
-- Name: speed_navg; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX speed_navg ON speed USING btree (navg);


--
-- Name: speed_path_id; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX speed_path_id ON speed USING btree (path_id);


--
-- Name: speed_route_tag; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX speed_route_tag ON speed USING btree (route_tag);


--
-- Name: speed_route_tag_like; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX speed_route_tag_like ON speed USING btree (route_tag text_pattern_ops);


--
-- Name: speed_speed; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX speed_speed ON speed USING btree (speed);


--
-- Name: stop_direction_id; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX stop_direction_id ON stop USING btree (direction_id);


--
-- Name: stop_seq; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX stop_seq ON stop USING btree (seq);


--
-- Name: stop_tag; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX stop_tag ON stop USING btree (tag);


--
-- Name: stop_tag_like; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX stop_tag_like ON stop USING btree (tag varchar_pattern_ops);


--
-- Name: vehicle_loc_id; Type: INDEX; Schema: public; Owner: muni; Tablespace: 
--

CREATE INDEX vehicle_loc_id ON vehicle USING gist (loc);


--
-- PostgreSQL database dump complete
--

