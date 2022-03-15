--
-- PostgreSQL database dump
--

-- Dumped from database version 13.6 (Ubuntu 13.6-1.pgdg20.04+1)
-- Dumped by pg_dump version 14.1

-- Started on 2022-02-25 10:30:53

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 200 (class 1259 OID 12369504)
-- Name: buildings; Type: TABLE; Schema: public; Owner: vbmltwzifkbhsk
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


ALTER TABLE public.buildings OWNER TO vbmltwzifkbhsk;

--
-- TOC entry 209 (class 1259 OID 12369673)
-- Name: meter; Type: TABLE; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE TABLE public.meter (
    meter_num integer NOT NULL,
    utility_id integer NOT NULL,
    building_code text NOT NULL
);


ALTER TABLE public.meter OWNER TO vbmltwzifkbhsk;

--
-- TOC entry 208 (class 1259 OID 12369671)
-- Name: meter_utility_id_seq; Type: SEQUENCE; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE SEQUENCE public.meter_utility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meter_utility_id_seq OWNER TO vbmltwzifkbhsk;

--
-- TOC entry 4030 (class 0 OID 0)
-- Dependencies: 208
-- Name: meter_utility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER SEQUENCE public.meter_utility_id_seq OWNED BY public.meter.utility_id;


--
-- TOC entry 207 (class 1259 OID 12369648)
-- Name: premise; Type: TABLE; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE TABLE public.premise (
    premise_id bigint NOT NULL,
    building_code text NOT NULL,
    utility_id integer NOT NULL
);


ALTER TABLE public.premise OWNER TO vbmltwzifkbhsk;

--
-- TOC entry 206 (class 1259 OID 12369646)
-- Name: premise_utility_id_seq; Type: SEQUENCE; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE SEQUENCE public.premise_utility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.premise_utility_id_seq OWNER TO vbmltwzifkbhsk;

--
-- TOC entry 4031 (class 0 OID 0)
-- Dependencies: 206
-- Name: premise_utility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER SEQUENCE public.premise_utility_id_seq OWNED BY public.premise.utility_id;


--
-- TOC entry 205 (class 1259 OID 12369624)
-- Name: usage; Type: TABLE; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE TABLE public.usage (
    id integer NOT NULL,
    building_code text NOT NULL,
    utility_id integer NOT NULL,
    time_stamp timestamp without time zone NOT NULL,
    usage numeric NOT NULL,
    cost numeric
);


ALTER TABLE public.usage OWNER TO vbmltwzifkbhsk;

--
-- TOC entry 203 (class 1259 OID 12369620)
-- Name: usage_id_seq; Type: SEQUENCE; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE SEQUENCE public.usage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usage_id_seq OWNER TO vbmltwzifkbhsk;

--
-- TOC entry 4032 (class 0 OID 0)
-- Dependencies: 203
-- Name: usage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER SEQUENCE public.usage_id_seq OWNED BY public.usage.id;


--
-- TOC entry 204 (class 1259 OID 12369622)
-- Name: usage_utility_id_seq; Type: SEQUENCE; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE SEQUENCE public.usage_utility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usage_utility_id_seq OWNER TO vbmltwzifkbhsk;

--
-- TOC entry 4033 (class 0 OID 0)
-- Dependencies: 204
-- Name: usage_utility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER SEQUENCE public.usage_utility_id_seq OWNED BY public.usage.utility_id;


--
-- TOC entry 202 (class 1259 OID 12369604)
-- Name: utilities; Type: TABLE; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE TABLE public.utilities (
    utility_id integer NOT NULL,
    utility_type text NOT NULL
);


ALTER TABLE public.utilities OWNER TO vbmltwzifkbhsk;

--
-- TOC entry 201 (class 1259 OID 12369602)
-- Name: utilities_utility_id_seq; Type: SEQUENCE; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE SEQUENCE public.utilities_utility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.utilities_utility_id_seq OWNER TO vbmltwzifkbhsk;

--
-- TOC entry 4034 (class 0 OID 0)
-- Dependencies: 201
-- Name: utilities_utility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER SEQUENCE public.utilities_utility_id_seq OWNED BY public.utilities.utility_id;


--
-- TOC entry 3870 (class 2604 OID 12369676)
-- Name: meter utility_id; Type: DEFAULT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.meter ALTER COLUMN utility_id SET DEFAULT nextval('public.meter_utility_id_seq'::regclass);


--
-- TOC entry 3869 (class 2604 OID 12369651)
-- Name: premise utility_id; Type: DEFAULT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.premise ALTER COLUMN utility_id SET DEFAULT nextval('public.premise_utility_id_seq'::regclass);


--
-- TOC entry 3867 (class 2604 OID 12369627)
-- Name: usage id; Type: DEFAULT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.usage ALTER COLUMN id SET DEFAULT nextval('public.usage_id_seq'::regclass);


--
-- TOC entry 3868 (class 2604 OID 12369628)
-- Name: usage utility_id; Type: DEFAULT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.usage ALTER COLUMN utility_id SET DEFAULT nextval('public.usage_utility_id_seq'::regclass);


--
-- TOC entry 3866 (class 2604 OID 12369607)
-- Name: utilities utility_id; Type: DEFAULT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.utilities ALTER COLUMN utility_id SET DEFAULT nextval('public.utilities_utility_id_seq'::regclass);


--
-- TOC entry 3872 (class 2606 OID 12369511)
-- Name: buildings pk_15; Type: CONSTRAINT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT pk_15 PRIMARY KEY (building_code);


--
-- TOC entry 3886 (class 2606 OID 12369681)
-- Name: meter pk_24; Type: CONSTRAINT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.meter
    ADD CONSTRAINT pk_24 PRIMARY KEY (meter_num);


--
-- TOC entry 3874 (class 2606 OID 12369612)
-- Name: utilities pk_42; Type: CONSTRAINT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.utilities
    ADD CONSTRAINT pk_42 PRIMARY KEY (utility_id);


--
-- TOC entry 3878 (class 2606 OID 12369633)
-- Name: usage pk_55; Type: CONSTRAINT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.usage
    ADD CONSTRAINT pk_55 PRIMARY KEY (id);


--
-- TOC entry 3882 (class 2606 OID 12798443)
-- Name: premise pk_86; Type: CONSTRAINT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.premise
    ADD CONSTRAINT pk_86 PRIMARY KEY (premise_id);


--
-- TOC entry 3875 (class 1259 OID 12369644)
-- Name: fk_61; Type: INDEX; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE INDEX fk_61 ON public.usage USING btree (building_code);


--
-- TOC entry 3876 (class 1259 OID 12369645)
-- Name: fk_66; Type: INDEX; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE INDEX fk_66 ON public.usage USING btree (utility_id);


--
-- TOC entry 3883 (class 1259 OID 12369692)
-- Name: fk_79; Type: INDEX; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE INDEX fk_79 ON public.meter USING btree (utility_id);


--
-- TOC entry 3884 (class 1259 OID 12369693)
-- Name: fk_82; Type: INDEX; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE INDEX fk_82 ON public.meter USING btree (building_code);


--
-- TOC entry 3879 (class 1259 OID 12369667)
-- Name: fk_90; Type: INDEX; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE INDEX fk_90 ON public.premise USING btree (building_code);


--
-- TOC entry 3880 (class 1259 OID 12369668)
-- Name: fk_93; Type: INDEX; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE INDEX fk_93 ON public.premise USING btree (utility_id);


--
-- TOC entry 3887 (class 2606 OID 12369634)
-- Name: usage fk_59; Type: FK CONSTRAINT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.usage
    ADD CONSTRAINT fk_59 FOREIGN KEY (building_code) REFERENCES public.buildings(building_code);


--
-- TOC entry 3888 (class 2606 OID 12369639)
-- Name: usage fk_64; Type: FK CONSTRAINT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.usage
    ADD CONSTRAINT fk_64 FOREIGN KEY (utility_id) REFERENCES public.utilities(utility_id);


--
-- TOC entry 3891 (class 2606 OID 12369682)
-- Name: meter fk_77; Type: FK CONSTRAINT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.meter
    ADD CONSTRAINT fk_77 FOREIGN KEY (utility_id) REFERENCES public.utilities(utility_id);


--
-- TOC entry 3892 (class 2606 OID 12369687)
-- Name: meter fk_80; Type: FK CONSTRAINT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.meter
    ADD CONSTRAINT fk_80 FOREIGN KEY (building_code) REFERENCES public.buildings(building_code);


--
-- TOC entry 3889 (class 2606 OID 12369657)
-- Name: premise fk_88; Type: FK CONSTRAINT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.premise
    ADD CONSTRAINT fk_88 FOREIGN KEY (building_code) REFERENCES public.buildings(building_code);


--
-- TOC entry 3890 (class 2606 OID 12369662)
-- Name: premise fk_91; Type: FK CONSTRAINT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE ONLY public.premise
    ADD CONSTRAINT fk_91 FOREIGN KEY (utility_id) REFERENCES public.utilities(utility_id);


--
-- TOC entry 4028 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: vbmltwzifkbhsk
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO vbmltwzifkbhsk;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 4029 (class 0 OID 0)
-- Dependencies: 657
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON LANGUAGE plpgsql TO vbmltwzifkbhsk;


-- Completed on 2022-02-25 10:31:07

--
-- PostgreSQL database dump complete
--
 
--
-- TOC entry 
-- Name: users; Type: TABLE; Schema: public; Owner: vbmltwzifkbhsk
--

CREATE TABLE public.users (
    id serial,
   firstName  text NOT NULL,
    lastName text NOT NULL,
    password text NOT NULL,
    admin  text not null 
);

ALTER TABLE public.users OWNER TO vbmltwzifkbhsk;

--
-- TOC entry 
-- Name: users; Type: CONSTRAINT; Schema: public; Owner: vbmltwzifkbhsk
--

ALTER TABLE users 
ADD PRIMARY KEY (id);
