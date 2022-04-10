--
-- PostgreSQL database dump
--

-- Dumped from database version 13.6 (Ubuntu 13.6-1.pgdg20.04+1)
-- Dumped by pg_dump version 14.1

-- Started on 2022-04-08 18:18:41 MDT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO energyDB;

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 200 (class 1259 OID 14524312)
-- Name: buildings; Type: TABLE; Schema: public; Owner: energyDB
--

CREATE TABLE public.buildings (
    building_code text NOT NULL,
    abbreviation text,
    building_name text NOT NULL,
    address text NOT NULL,
    gross_sf integer NOT NULL,
    year_built integer,
    x_coord double precision,
    y_coord double precision
);


ALTER TABLE public.buildings OWNER TO energyDB;

--
-- TOC entry 203 (class 1259 OID 14524344)
-- Name: meter; Type: TABLE; Schema: public; Owner: energyDB
--

CREATE TABLE public.meter (
    meter_id integer NOT NULL,
    building_code character varying(255) NOT NULL,
    utility_id integer
);


ALTER TABLE public.meter OWNER TO energyDB;

--
-- TOC entry 205 (class 1259 OID 14524367)
-- Name: premise; Type: TABLE; Schema: public; Owner: energyDB
--

CREATE TABLE public.premise (
    premise_id bigint NOT NULL,
    building_code text NOT NULL,
    utility_id integer NOT NULL
);


ALTER TABLE public.premise OWNER TO energyDB;

--
-- TOC entry 204 (class 1259 OID 14524365)
-- Name: premise_utility_id_seq; Type: SEQUENCE; Schema: public; Owner: energyDB
--

CREATE SEQUENCE public.premise_utility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.premise_utility_id_seq OWNER TO energyDB;

--
-- TOC entry 4039 (class 0 OID 0)
-- Dependencies: 204
-- Name: premise_utility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: energyDB
--

ALTER SEQUENCE public.premise_utility_id_seq OWNED BY public.premise.utility_id;


--
-- TOC entry 208 (class 1259 OID 14524392)
-- Name: usage; Type: TABLE; Schema: public; Owner: energyDB
--

CREATE TABLE public.usage (
    id integer NOT NULL,
    building_code text NOT NULL,
    utility_id integer NOT NULL,
    time_stamp timestamp without time zone NOT NULL,
    usage numeric NOT NULL,
    cost numeric,
    premise_id bigint
);


ALTER TABLE public.usage OWNER TO energyDB;

--
-- TOC entry 206 (class 1259 OID 14524388)
-- Name: usage_id_seq; Type: SEQUENCE; Schema: public; Owner: energyDB
--

CREATE SEQUENCE public.usage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usage_id_seq OWNER TO energyDB;

--
-- TOC entry 4040 (class 0 OID 0)
-- Dependencies: 206
-- Name: usage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: energyDB
--

ALTER SEQUENCE public.usage_id_seq OWNED BY public.usage.id;


--
-- TOC entry 207 (class 1259 OID 14524390)
-- Name: usage_utility_id_seq; Type: SEQUENCE; Schema: public; Owner: energyDB
--

CREATE SEQUENCE public.usage_utility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usage_utility_id_seq OWNER TO energyDB;

--
-- TOC entry 4041 (class 0 OID 0)
-- Dependencies: 207
-- Name: usage_utility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: energyDB
--

ALTER SEQUENCE public.usage_utility_id_seq OWNED BY public.usage.utility_id;


--
-- TOC entry 210 (class 1259 OID 14551537)
-- Name: users; Type: TABLE; Schema: public; Owner: energyDB
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    admin boolean
);


ALTER TABLE public.users OWNER TO energyDB;

--
-- TOC entry 209 (class 1259 OID 14551535)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: energyDB
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO energyDB;

--
-- TOC entry 4042 (class 0 OID 0)
-- Dependencies: 209
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: energyDB
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 202 (class 1259 OID 14524333)
-- Name: utilities; Type: TABLE; Schema: public; Owner: energyDB
--

CREATE TABLE public.utilities (
    utility_id integer NOT NULL,
    utility_type text NOT NULL
);


ALTER TABLE public.utilities OWNER TO energyDB;

--
-- TOC entry 201 (class 1259 OID 14524331)
-- Name: utilities_utility_id_seq; Type: SEQUENCE; Schema: public; Owner: energyDB
--

CREATE SEQUENCE public.utilities_utility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.utilities_utility_id_seq OWNER TO energyDB;

--
-- TOC entry 4043 (class 0 OID 0)
-- Dependencies: 201
-- Name: utilities_utility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: energyDB
--

ALTER SEQUENCE public.utilities_utility_id_seq OWNED BY public.utilities.utility_id;


--
-- TOC entry 3871 (class 2604 OID 14524370)
-- Name: premise utility_id; Type: DEFAULT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.premise ALTER COLUMN utility_id SET DEFAULT nextval('public.premise_utility_id_seq'::regclass);


--
-- TOC entry 3872 (class 2604 OID 14524395)
-- Name: usage id; Type: DEFAULT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.usage ALTER COLUMN id SET DEFAULT nextval('public.usage_id_seq'::regclass);


--
-- TOC entry 3873 (class 2604 OID 14524396)
-- Name: usage utility_id; Type: DEFAULT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.usage ALTER COLUMN utility_id SET DEFAULT nextval('public.usage_utility_id_seq'::regclass);


--
-- TOC entry 3874 (class 2604 OID 14551540)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3870 (class 2604 OID 14524336)
-- Name: utilities utility_id; Type: DEFAULT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.utilities ALTER COLUMN utility_id SET DEFAULT nextval('public.utilities_utility_id_seq'::regclass);


--
-- TOC entry 3887 (class 2606 OID 14582014)
-- Name: usage duplicate_usage; Type: CONSTRAINT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.usage
    ADD CONSTRAINT duplicate_usage UNIQUE (building_code, utility_id, time_stamp, premise_id);


--
-- TOC entry 3876 (class 2606 OID 14524319)
-- Name: buildings pk_15; Type: CONSTRAINT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT pk_15 PRIMARY KEY (building_code);


--
-- TOC entry 3881 (class 2606 OID 14526705)
-- Name: meter pk_24; Type: CONSTRAINT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.meter
    ADD CONSTRAINT pk_24 PRIMARY KEY (meter_id);


--
-- TOC entry 3878 (class 2606 OID 14524341)
-- Name: utilities pk_42; Type: CONSTRAINT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.utilities
    ADD CONSTRAINT pk_42 PRIMARY KEY (utility_id);


--
-- TOC entry 3891 (class 2606 OID 14524401)
-- Name: usage pk_55; Type: CONSTRAINT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.usage
    ADD CONSTRAINT pk_55 PRIMARY KEY (id);


--
-- TOC entry 3885 (class 2606 OID 14524415)
-- Name: premise pk_86; Type: CONSTRAINT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.premise
    ADD CONSTRAINT pk_86 PRIMARY KEY (premise_id);


--
-- TOC entry 3893 (class 2606 OID 14551547)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3895 (class 2606 OID 14551545)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3888 (class 1259 OID 14524412)
-- Name: fk_61; Type: INDEX; Schema: public; Owner: energyDB
--

CREATE INDEX fk_61 ON public.usage USING btree (building_code);


--
-- TOC entry 3889 (class 1259 OID 14524413)
-- Name: fk_66; Type: INDEX; Schema: public; Owner: energyDB
--

CREATE INDEX fk_66 ON public.usage USING btree (utility_id);


--
-- TOC entry 3879 (class 1259 OID 14526714)
-- Name: fk_82; Type: INDEX; Schema: public; Owner: energyDB
--

CREATE INDEX fk_82 ON public.meter USING btree (building_code);


--
-- TOC entry 3882 (class 1259 OID 14524386)
-- Name: fk_90; Type: INDEX; Schema: public; Owner: energyDB
--

CREATE INDEX fk_90 ON public.premise USING btree (building_code);


--
-- TOC entry 3883 (class 1259 OID 14524387)
-- Name: fk_93; Type: INDEX; Schema: public; Owner: energyDB
--

CREATE INDEX fk_93 ON public.premise USING btree (utility_id);


--
-- TOC entry 3899 (class 2606 OID 14524402)
-- Name: usage fk_59; Type: FK CONSTRAINT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.usage
    ADD CONSTRAINT fk_59 FOREIGN KEY (building_code) REFERENCES public.buildings(building_code);


--
-- TOC entry 3900 (class 2606 OID 14524407)
-- Name: usage fk_64; Type: FK CONSTRAINT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.usage
    ADD CONSTRAINT fk_64 FOREIGN KEY (utility_id) REFERENCES public.utilities(utility_id);


--
-- TOC entry 3896 (class 2606 OID 14526715)
-- Name: meter fk_80; Type: FK CONSTRAINT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.meter
    ADD CONSTRAINT fk_80 FOREIGN KEY (building_code) REFERENCES public.buildings(building_code);


--
-- TOC entry 3897 (class 2606 OID 14524376)
-- Name: premise fk_88; Type: FK CONSTRAINT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.premise
    ADD CONSTRAINT fk_88 FOREIGN KEY (building_code) REFERENCES public.buildings(building_code);


--
-- TOC entry 3898 (class 2606 OID 14524381)
-- Name: premise fk_91; Type: FK CONSTRAINT; Schema: public; Owner: energyDB
--

ALTER TABLE ONLY public.premise
    ADD CONSTRAINT fk_91 FOREIGN KEY (utility_id) REFERENCES public.utilities(utility_id);


--
-- TOC entry 4037 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: energyDB
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO energyDB;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 4038 (class 0 OID 0)
-- Dependencies: 661
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON LANGUAGE plpgsql TO energyDB;


-- Completed on 2022-04-08 18:18:49 MDT

--
-- PostgreSQL database dump complete
--

