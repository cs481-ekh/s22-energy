--
-- PostgreSQL database dump
--

-- Dumped from database version 13.6 (Ubuntu 13.6-1.pgdg20.04+1)
-- Dumped by pg_dump version 14.2

-- Started on 2022-04-14 09:33:31 MDT

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
-- TOC entry 200 (class 1259 OID 14524312)
-- Name: buildings; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 203 (class 1259 OID 14524344)
-- Name: meter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meter (
    meter_id integer NOT NULL,
    building_code character varying(255) NOT NULL,
    utility_id integer
);


--
-- TOC entry 205 (class 1259 OID 14524367)
-- Name: premise; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.premise (
    premise_id bigint NOT NULL,
    building_code text NOT NULL,
    utility_id integer NOT NULL
);


--
-- TOC entry 204 (class 1259 OID 14524365)
-- Name: premise_utility_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.premise_utility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4049 (class 0 OID 0)
-- Dependencies: 204
-- Name: premise_utility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.premise_utility_id_seq OWNED BY public.premise.utility_id;


--
-- TOC entry 208 (class 1259 OID 14524392)
-- Name: usage; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 206 (class 1259 OID 14524388)
-- Name: usage_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4050 (class 0 OID 0)
-- Dependencies: 206
-- Name: usage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usage_id_seq OWNED BY public.usage.id;


--
-- TOC entry 207 (class 1259 OID 14524390)
-- Name: usage_utility_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usage_utility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4051 (class 0 OID 0)
-- Dependencies: 207
-- Name: usage_utility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usage_utility_id_seq OWNED BY public.usage.utility_id;


--
-- TOC entry 202 (class 1259 OID 14524333)
-- Name: utilities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.utilities (
    utility_id integer NOT NULL,
    utility_type text NOT NULL
);


--
-- TOC entry 201 (class 1259 OID 14524331)
-- Name: utilities_utility_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.utilities_utility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4053 (class 0 OID 0)
-- Dependencies: 201
-- Name: utilities_utility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.utilities_utility_id_seq OWNED BY public.utilities.utility_id;


--
-- TOC entry 3871 (class 2604 OID 14524370)
-- Name: premise utility_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.premise ALTER COLUMN utility_id SET DEFAULT nextval('public.premise_utility_id_seq'::regclass);


--
-- TOC entry 3872 (class 2604 OID 14524395)
-- Name: usage id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usage ALTER COLUMN id SET DEFAULT nextval('public.usage_id_seq'::regclass);


--
-- TOC entry 3873 (class 2604 OID 14524396)
-- Name: usage utility_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usage ALTER COLUMN utility_id SET DEFAULT nextval('public.usage_utility_id_seq'::regclass);


--
-- TOC entry 3870 (class 2604 OID 14524336)
-- Name: utilities utility_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilities ALTER COLUMN utility_id SET DEFAULT nextval('public.utilities_utility_id_seq'::regclass);


--
-- TOC entry 4031 (class 0 OID 14524312)
-- Dependencies: 200
-- Data for Name: buildings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('005', 'HEMG', 'Hemingway Western Studies Center', '1819 CESAR CHAVEZ LANE', 13426, 1940, 43.603557, -116.202445);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('006', 'HTPT', 'Heat Plant and Telephone Building', '1830 UNIVERSITY', 7033, 1940, 43.602721, -116.203043);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('007', 'CMPS', 'Campus School', '2100 UNIVERSITY', 31799, 1954, 43.604399, -116.207062);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('009', 'MAIT', 'Maintenance Shops', '1356 UNIVERSITY', 9209, 1927, 43.601232, -116.198202);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('011', 'COMB', 'Communication', '1711 CESAR CHAVEZ LANE', 21414, 1941, 43.603679, -116.201446);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('013', 'MORA', 'Morrison Ctr for Performing Arts (Aux.)', '2201 CESAR CHAVEZ LANE', 123099, 1984, 43.606732, -116.207518);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('014', 'MORR', 'Morrison Ctr for the Performing Arts (Ed.)', '2201 CESAR CHAVEZ LANE', 58619, 1984, 43.606732, -116.207518);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('015', 'TBLA', 'Taco Bell Arena', '1401 CESAR CHAVEZ LANE', 276839, 1982, 43.603563, -116.198983);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('020', 'MORH', 'Morrison Hall', '1515 CESAR CHAVEZ LANE', 19324, 1951, 43.604448, -116.200097);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('021', 'DRIS', 'Driscoll Hall', '1607 CESAR CHAVEZ LANE', 20411, 1951, 43.604072, -116.200849);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('022', 'SH01', '1803 Donald Circle, Student Housing', '1803 DONALD CIRCLE', 1373, 1967, 43.599398, -116.205377);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('023', 'SH02', '1809 Donald Circle, Student Housing', '1809 DONALD CIRCLE', 1902, 1966, 43.599313, -116.205618);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('024', 'MB', 'Mathematics', '2000 UNIVERSITY', 58592, 1955, 43.604421, -116.205805);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('027', 'ALBR', 'Albertsons Library', '1865 CESAR CHAVEZ LANE', 201987, 1964, 43.604161, -116.203382);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('028', 'ACCS', 'Academic and Career Services', '1464 UNIVERSITY', 29270, 1964, 43.601282, -116.199406);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('034', 'RFH', 'Riverfront Hall', '1987 CESAR CHAVEZ LANE', 67023, 1971, 43.604837, -116.204809);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('035', 'STDM', 'Albertsons Stadium', '1190 UNIVERSITY', 279744, 1970, 43.602693, -116.195829);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('036', 'VARC', 'Varsity Center (Simplot Center for Athletic Excellence), Nickelson-Yanke Center', '1190 UNIVERSITY', 42063, 1970, 43.60155, -116.195881);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('037', 'KINX', 'Kinesiology Annex (Pool)', '1476 BRONCO CIRCLE', 32266, 1971, 43.602965, -116.199555);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('040', 'CHX1', 'Chrisway Annex', '2103 UNIVERSITY', 8312, 1958, 43.603679, -116.207579);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('049', 'SSAX', 'Student Systems Annex', '2065 UNIVERSITY DR', 3128, 1950, 43.602964, -116.207142);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('054', 'ENGX', 'English Annex', '1875 UNIVERSITY (ANNEX 9)', 3086, 1978, 43.602405, -116.204195);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('056', 'PHRH', 'Pioneer Hall', '1490 UNIVERSITY', 23804, 1974, 43.601585, -116.199685);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('062', 'SPEC', 'Special Events Center', '1800 UNIVERSITY', 25080, 1975, 43.602584, -116.202217);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('070', 'LAND', 'Landscape Services', '1110 VERMONT', 2120, 1946, 43.59908, -116.199583);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('071', 'EDUC', 'Education', '2133 CESAR CHAVEZ LANE', 81945, 1979, 43.606022, -116.206321);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('072', 'SCNC', 'Science Building', '2133 CESAR CHAVEZ LANE', 104650, 1977, 43.60615, -116.206412);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('074', 'SCGR', 'Science Greenhouse (Sci Nursing)', '2101 CESAR CHAVEZ LANE', 946, 1977, 43.605466, -116.20667);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('081', 'EUC4', 'Euclid Annex #4', '1136-38 EUCLID', 2112, 1975, 43.59927, -116.196697);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('075', 'COPR', 'Copper Basin', '1310 UNIVERSITY', 9952, 1977, 43.601306, -116.197539);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('082', 'UNX2', '2055 University Drive Annex', '2055 UNIVERSITY', 4199, 1999, 43.603446, -116.206969);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('083', 'BIGR', 'Biology Greenhouse', '2133 UNIVERSITY', 1975, 1999, 43.605458, -116.206684);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('138', 'TECC', 'TECenter (Technology and Entrepreneurial Center)', '16660 CanAda Road - WC', 38314, 2003, NULL, NULL);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('203', 'EUX2', 'Euclid Annex #2', '1113 S. Euclid', 3320, 2003, 43.598806, -116.197682);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('204', 'EUX3', 'Euclid Annex #3', '1129 S. Euclid', 4150, 2003, 43.598619, -116.197693);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('210', 'CPV2', 'Capitol Village #2', '2203 University', 2072, 2000, 43.605056, -116.21118);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('211', 'CPV3', 'Capitol Village #3', '2209 University', 12143, 2000, 43.605138, -116.210949);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('213', 'CPV4', 'Capitol Village #4', '2237-2239 University', 2804, 2000, 43.604784, -116.209816);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('214', 'CPV1', 'Capitol Village #1', '2710 Boise Ave', 4878, 2000, 43.60473, -116.211357);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('216', NULL, 'CGISS Lease', '515 Highland St', 5000, NULL, 43.592916, -116.177282);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('219', NULL, 'Soccer Field Restroom/Concession Bldg', '1507 Oakland', 966, 2003, 43.594036, -116.204066);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('234', 'CWSC', 'Caven-Williams Sports Complex', '1201 CESAR CHAVEZ LANE', 98549, 2006, 43.604138, -116.197005);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('235', 'ILC', 'Interactive Teaching & Learning Center', '2120 University Drive', 71907, 2007, 43.604864, -116.206362);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('242', NULL, '1156 - 1158 Euclid Annex', '1156-1158 Euclid', 2464, 1975, 43.598971, -116.197031);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('247', NULL, '1350 W. Victory Road', '1350 W. Victory Road', 100, NULL, 43.576066, -116.198224);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('255', 'LAGR', 'Lincoln Avenue Garage', '1607 University Drive', 0, 2007, 43.600272, -116.201703);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('258', NULL, 'Access Mini Storage - BSU Radio', '3462 E. Amity Rd. Boise, ID 83716', 240, NULL, 43.562824, -116.141658);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('259', 'NNHS', 'Norco Building: Nursing Department, University Health Services', '1529 BLEMONT STREET', 81291, 2009, 43.599414, -116.200482);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('264', 'SSC', 'Stueckle Sky Center', '1200 University', 180191, 2008, 43.602863, -116.196844);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('266', NULL, '1130 S. Manitou', '1130 S. Manitou', 2008, 1955, 43.598571, -116.19834);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('270', 'WMSB', 'Waste Materials Storage Bldg.', '1311 S. Bronco Lane', 268, 2008, 43.601247, -116.198169);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('278', 'DLPA', 'Dona Larsen Park - Track & Field Equipment Building', '415 E. Warm Springs Ave', 7700, 1973, 43.609514, -116.189993);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('285', 'DNX1', '1121 S. Denver', '1121 Denver', 1792, 1948, 43.598839, -116.195171);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('289', 'YFRP', 'Ron and Linda Yanke Family Research Park', '220 Park Center Blvd', 84044, 1979, 43.599896, -116.183669);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('292', NULL, 'Dona Laren Park Softball Storage Shed', '150 S. Broadway', 0, NULL, 43.608877, -116.192484);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('306', NULL, '1827 Yale', '1827 Yale', 2925, 2005, 43.601807, -116.204547);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('307', NULL, '1855 Belmont', '1855 Belmont', 1698, 1962, 43.59988, -116.204687);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('308', NULL, '1406 S. Juanita', '1406 S. Juanita', 1173, 1946, 43.602444, -116.206448);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('100', 'HML', 'Harry Morrison Civil Engineering', '1019 EUCLID', 18930, 1999, 43.599946, -116.1977);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('102', 'REC', 'Student Recreation Center', '1515 UNIVERSITY', 106749, 2002, 43.600113, -116.200529);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('105', 'GRX1', '1015 Grant Avenue Annex', '1015 GRANT', 7632, 2001, 43.6003, -116.196564);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('110', 'FACT', 'FO&M Training Center', '1216 BEACON', 1360, 1961, 43.59859, -116.197084);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('114', 'DNX3', '1113 Denver Annex', '1113 DENVER', 1671, 1950, 43.59911, -116.19513);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('115', 'GAR5', '1113 Denver Annex Garage', '1113 1/2 DENVER (GARAGE)', 480, 1950, 43.599317, -116.195196);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('117', 'GAR4', 'Internal Audit', '1117-1119 1/2 DENVER (GARAGE)', 496, 1950, 43.598955, -116.19519);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('119', 'GRX4', 'Grant Annex 4, 1023 S. Grant', '1023 S. GRANT', 4298, 1980, 43.60001, -116.19644);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('121', 'HSRV', 'Health Sciences - Riverside', '950 LUSK', 22490, 1984, 43.60933, -116.2108);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('122', 'RAPT', 'Raptor Research Center', '970 LUSK', 14954, 1970, 43.608877, -116.210704);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('301', NULL, '1514 S. Martha Cir', '1514 S Martha Cir', 1534, 1955, 43.602308, -116.209168);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('309', NULL, '1803 W. Potter', '1803 W. Potter', 2409, 1955, 43.600587, -116.204301);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('310', NULL, '1509 S. Joyce', '1509 S. Joyce', 1985, 1961, 43.600894, -116.206351);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('319', NULL, '1110 S. Grant', '1110 S. Grant', 1580, 1949, 43.599154, -116.195937);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('320', NULL, '1808 Donald Circle', '1808 Donald Circle', 1425, 1964, 43.599756, -116.205347);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('326', 'TMRK', 'The Lincoln Townhouses - Tamarack House', '1100 Lincoln Avenue', 12503, 2012, 43.599488, -116.20178);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('299', NULL, '1870 Belmont', '1870 Belmont', 1828, 1962, 43.600373, -116.20502);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('302', NULL, '1630 S. Joyce', '1630 S. Joyce', 1289, 1970, 43.599596, -116.206528);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('305', NULL, '1816 Yale', '1816 Yale', 803, 2004, 43.602265, -116.204483);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('329', 'CEDR', 'The Lincoln Townhouses - Cedar House', '1104 Lincoln Avenue', 25347, 2012, 43.598808, -116.202086);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('332', 'GBFC', 'Gene Bleymaier Football Complex', '1185 Cesar Chavez Lane', 0, 2013, 43.603807, -116.195546);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('084', 'CSTL', 'Const. Materials & Methods Lab', '1029 MANITOU', 1687, 1997, 43.60043, -116.19889);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('085', 'APTC', 'Appleton Tennis Center', '1555 CESAR CHAVEZ LANE', 3327, 2002, 43.603217, -116.200242);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('090', 'STSC', 'Student Success Ctr. (Annex #8)', '1885 UNIVERSITY DR', 2096, 1955, 43.602572, -116.204422);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('093', 'CHLC', 'Childrens Ctr.', '1830 BEACON', 16577, 1995, 43.598959, -116.203881);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('096', 'GAR3', 'Garage Stadium Storage', '1190 UNIVERSITY', 2916, 1986, 43.601232, -116.195613);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('098', 'TARX', 'Theatre Arts Annex (Costume Shop)', '2611 BOISE AVE', 7779, 1952, 43.60397, -116.21218);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('099', 'BLX1', '1375 Belmont Annex', '1375 BELMONT', 1258, 1998, 43.599503, -116.198238);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('104', 'BSGR', 'Brady Street Garage', '2200 UNIVERSITY', 399283, 2001, 43.605268, -116.208419);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('123', 'MPCB', 'Multi-Purpose Classroom Building', '2110 UNIVERSITY', 61383, 1997, 43.605093, -116.207045);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('143', 'TRAK', 'Idaho Center Sports Center', '16200 Can-Ada Rd, Nampa, ID', 3413, NULL, 43.60811, -116.50794);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('144', 'CPV5', 'Capitol Village #5', '2243 UNIVERSITY DR', 3838, 2000, 43.605058, -116.210839);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('146', 'LUX1', '1029 Lusk Annex', '1029 LUSK', 5000, NULL, 43.607882, -116.212409);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('152', 'DSTH', 'David S. Taylor Hall', '1559 CESAR CHAVEZ LANE', 65034, 2004, 43.6047792879634, -116.200220642498);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('153', 'JHKH', 'John H. Keiser Hall', '1663 CESAR CHAVEZ LANE', 49860, 2004, 43.604099906546, -116.200055462473);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('154', 'SELW', 'University Suites - Selway Suites', '1313 S. Chrisway', 46080, 2004, 43.6046579463558, -116.209266694526);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('156', 'CWTR', 'University Suites - Clearwater Suites', '1309 S. Chrisway', 34983, 2004, 43.6041143224395, -116.207965492755);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('157', 'USQ7', 'University Square - D', '1307 S. Chrisway Drive', 27339, 2004, 43.6036936355051, -116.209471227142);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('158', 'USQ5', 'University Square - E', '1305 S. Chrisway Drive', 27433, 2004, 43.6034360055885, -116.209016138824);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('159', 'USQ1', 'University Square - F', '1301 S. Chrisway Drive', 27433, 2004, 43.6037363082612, -116.208958240893);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('160', 'USQ3', 'University Square - G', '1303 S. Chrisway Drive', 33274, 2004, 43.6036425420492, -116.208178144139);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('173', 'UHAA', 'University Heights Apartments - A', '2650-2652 Boise Ave', 0, 1974, 43.5689571509401, -116.150605810169);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('174', 'UHAB', 'University Heights Apartments - B', '2654-2656 Boise Ave', 0, 1974, 43.5687259007751, -116.150334554833);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('175', 'UHAC', 'University Heights Apartments - C', '2658-2660 Boise Ave', 0, 1974, 43.6040535079992, -116.211336760848);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('176', 'UMAA', 'University Manor Apartments - A', '1910-1980 Boise Ave', 0, 1974, 43.5985596079092, -116.204267443056);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('291', NULL, 'Metal Building 8''x8''x10''', 'Ellen Dee Mountain near Contact, NV', 80, 2007, NULL, NULL);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('180', 'UVAA', 'University Village Apartments - A', '2530 W Boise Ave', 0, 1995, 43.6036104291303, -116.21043314901);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('181', 'UVAB', 'University Village Apartments - B', '2540 W Boise Ave', 0, 1995, 43.6030701079821, -116.211230343058);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('182', 'UVAC', 'University Village Apartments - C', '2550 W Boise Ave', 0, 1995, 43.6032684071053, -116.211340909983);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('330', 'ASPN', 'The Lincoln Townhouses - Aspen House', '1106 Lincoln Avenue', 12503, 2012, 43.598633, -116.201791);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('331', 'SPRC', 'The Lincoln Townhouses - Spruce House', '1107 Lincoln Avenue', 25347, 2012, 43.598843, -116.202601);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('334', NULL, '1708 Potter', '1708 Potter', 1535, 1955, 43.600828, -116.203685);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('339', NULL, 'Center for Advanced Energy Studies (CAES)ISU, Battelle', '955 University Blvd, Idaho Fall 83814', 5500, NULL, 43.5211781353192, -112.052625563823);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('340', NULL, 'Bronco Shop Meridan', '3143 East Magic View Drive, Eagle View Plaza, Suit', 2500, NULL, 43.5990260114767, -116.355830031577);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('347', 'BODO', '301 S. Capital', '301S. Capital', 0, 2012, 43.6134316074197, -116.204393403142);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('348', NULL, 'University Plaza', '960 Broadway', 0, NULL, 43.6018721936348, -116.192057071558);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('349', 'CVA', 'Center for Visual Arts', '1110 S. Capitol Blvd', 104820, 2019, 43.6065146285515, -116.209382596124);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('351', NULL, '1814 W Potter Drive', '1814 W Potter Drive', 820, 1951, 43.6011540530582, -116.204691069576);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('355', NULL, '1427 - 1429 Belmont', '1427-1429 Belmont', 2016, 1974, 43.5995292503204, -116.199540155319);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('358', NULL, '1112 Manitou Garage', '1112 Manitou Garage', 936, 1956, 43.5991980071297, -116.198312401948);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('360', NULL, '1817 W Potter Drive', '1817 W Potter Drive', 931, 1958, 43.6009090870547, -116.205135450155);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('361', NULL, '1607-1609 Martha Street', '1607-1609 Martha Street', 1776, 1958, 43.603131086309, -116.209769499637);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('362', NULL, '2500 Boise Ave', '2500 Boise Ave', 0, 1973, 43.5712815736235, -116.152538747358);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('365', 'CPV7', 'Capital Village #7', '2251 University Drive', 0, 2000, 43.604052538526, -116.21007690644);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('366', NULL, '1711 Potter Drive', '1711 Potter Drive', 0, 1958, 43.6005353791207, -116.204045525266);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('367', 'CCP', 'City Center Plaza', '777 W Main Street', 45767, 2016, 43.6152084628337, -116.203528575872);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('368', 'AFC', 'Alumni and Friends Center', '1173 University Drive', 44758, 2016, 43.6006353834435, -116.195650025041);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('369', NULL, '1843 University Drive', '1843 University Drive', 2926, 1948, 43.6020697984611, -116.203943006413);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('374', NULL, '1813 Potter', '1813 Potter', 830, 1951, 43.6007811520595, -116.204708001955);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('375', NULL, '1862 W Belmont ', '1862 W Belmont', 1158, 1962, 43.6002746791221, -116.204754860849);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('377', NULL, 'City Center Plaza Bronco Shop', '777 W Main Street', 2900, 2016, 43.6152220942945, -116.203534302548);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('380', NULL, 'Honors College Live Learn Community', '1801 Univesity Drive', 19807, 2016, 43.6013155223571, -116.202542225972);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('382', NULL, 'Sawtooth Hall', '1801 University Drive', 0, 2016, 43.6013155223571, -116.202542225972);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('383', NULL, 'Unit #0115, Idaho Self Storage - River', '1201 W. River Street, Unit #0115', 400, NULL, 43.6141242811097, -116.21460724554);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('385', NULL, 'City Center Plaza - Bike Condo', '151 S Capitol Blvd', 320, 2016, 43.6146859313976, -116.203360295824);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('386', NULL, 'City Center Plaza - 3rd floor Fenced Bike Parking', '151 S Capitol Blvd', 1000, 2016, 43.6146859313976, -116.203360295824);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('387', NULL, 'US Bank Building', '101 S Capitol Blvd', 2900, 1978, 43.6149050791208, -116.202982560843);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('388', NULL, '1923 Yale Ct', '1923 Yale Ct', 1354, 1946, 43.6024372368188, -116.205981525259);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('004', 'ADMN', 'Administration', '1910 UNIVERSITY', 44193, 1940, 43.603675, -116.204807);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('008', 'OPAL', 'Opaline School House', '1012 CESAR CHAVEZ LANE', 591, 1914, 43.60333, -116.193982);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('016', 'SMTC', 'Simplot/Micron Instructional Technical Center', '2055 CESAR CHAVEZ LANE', 41395, 1986, 43.605093, -116.205292);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('025', 'BGYM', 'Bronco Gymnasium - Department of Kinesiology', '1404 BRONCO CR', 43821, 1955, 43.602724, -116.198677);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('029', 'ENGR', 'Engineering Building', '1375 UNIVERSITY', 64476, 1989, 43.60051, -116.19827);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('030', 'LART', 'Liberal Arts', '1874 UNIVERSITY', 56054, 1967, 43.603229, -116.20334);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('031', 'CHFH', 'Chaffee Hall', '1421 CESAR CHAVEZ LANE', 101342, 1967, 43.604468, -116.198629);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('032', 'SUB', 'Student Union', '1700 UNIVERSITY', 285873, 1967, 43.601675, -116.201498);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('038', 'VARX', 'Varsity Center Annex', '1188A UNIVERSITY', 9137, 1985, 43.60157, -116.19586);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('039', 'JBBT', 'John B. Barnes Towers', '2303 CESAR CHAVEZ LANE', 67501, 1970, 43.604918, -116.206691);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('065', 'ARTX', 'Art Annex #1', '1426 BELMONT', 2109, 1946, 43.59981, -116.199498);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('078', 'SHMA', 'Student Housing Maintenance', '917 ISLAND ST', 5755, 1976, 43.60775, -116.21316);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('079', 'MNX3', 'Manitou Annex #3', '1118 S. Manitou', 2870, 1992, 43.59889, -116.19826);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('087', 'BOTC', 'Boas Tennis and Soccer Ctr.', '1507 OAKLAND', 44684, 1991, 43.594946, -116.20468);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('089', 'CSTM', 'Construction Management', '1029 MANITOU', 2108, 1999, 43.599845, -116.199164);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('101', 'MEC', 'Micron Engineering Center', '1020 MANITOU AVE', 70175, 1999, 43.599946, -116.198274);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('116', 'IARM', 'Internal Audit', '1117-1119 DENVER (DUPLEX)', 1661, 1950, 43.598955, -116.19519);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('125', 'MNX2', 'Manitou Annex #2', '1114 S. Manitou', 1957, 1997, 43.59904, -116.19833);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('137', 'CHX2', '1406 Chrisway Annex', '1406 CHRISWAY', 4210, 2002, 43.602836, -116.20733);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('155', 'PAYT', 'University Suites - Payette Suites', '1311 S. Chrisway', 34904, 2004, 43.604414860451, -116.208401841195);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('164', 'ANHF', 'Allen Noble Hall of Fame', '1190 University Drive', 19180, 1970, 43.6021463846384, -116.195230805132);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('166', 'CHCP', 'Christ Chapel', '1010 CESAR CHAVEZ LANE', 0, 1964, 43.60320244778, -116.193902324754);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('177', 'UMAB', 'University Manor Apartments - B', '2000-2024 Boise Ave', 0, 1971, 43.5989365870842, -116.205761890222);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('178', 'UPAA', 'University Park Apartments - A (N)', '860 Sherwood', 0, 1971, 43.6071287948207, -116.212011784157);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('179', 'UPAB', 'University Park Apartments - B (S)', '860 Sherwood', 0, 1971, 43.6071287948207, -116.212011784157);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('183', 'UVAD', 'University Village Apartments - D', '2560 W Boise Ave', 0, 1995, 43.6036946843319, -116.2115901383);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('184', 'UVAE', 'University Village Apartments - E', '2570 W Boise Ave', 0, 1995, 43.6036816184077, -116.211470598924);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('185', 'UVAF', 'University Village Apartments - F', '2580 W Boise Ave', 0, 1995, 43.6033972406943, -116.210976342109);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('198', 'NETS', 'Network Services', '1212 S. BEACON AVE', 1521, 1965, 43.598588, -116.196918);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('215', 'CPV6', 'Capitol Village #6', '2249 University', 25921, 2000, 43.604252, -116.210079);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('243', NULL, '1162 - 1164 Euclid Annex', '1162-1164 Euclid', 2534, 1975, 43.598808, -116.197004);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('245', 'EUX1', '1142-1144 Euclid Annex', '1142-1144 Euclid', 2592, 1975, 43.599088, -116.19702);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('267', 'ERB', 'Environmental Reseach Building', '1295 UNIVERSITY DRIVE', 101265, 2011, 43.60068, -116.196703);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('298', 'MBEB', 'Micron Business and Economics Building', '2360 University Dr', 117312, 2012, 43.605691, -116.210476);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('327', 'HWTN', 'The Lincoln Townhouses - Hawthorne House', '1102 Lincoln Avenue', 29705, 2012, 43.599286, -116.202091);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('328', 'JNPR', 'The Lincoln Townhouses - Juniper House', '1103 Lincoln Avenue', 29705, 2012, 43.599278, -116.202612);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('336', NULL, '1810 Potter', '1810 Potter', 1107, 1961, 43.601038, -116.204313);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('338', NULL, '1519 Juanita', '1519 Juanita', 1144, 1959, 43.601671, -116.20755);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('352', 'GAGE', '5475 W. Gage Street', '5475 W. Gage St.', 0, 1985, 43.6130943506323, -116.249065666963);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('370', NULL, '1802/1804 Yale Court', '1802/1804 Yale Court', 1088, 1948, 43.6021151409896, -116.204103728197);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('371', NULL, '1806/1808 Yale Court', '1806/1808 Yale Court', 1088, 1948, 43.60215498522, -116.204177888767);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('384', NULL, 'Unit #0113, Idaho Self Storage - River', '1202 W. River Street, Unit #0113', 200, NULL, 43.6139334337299, -116.214698920305);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('389', NULL, '1815 Potter Dr', '1815 Potter Dr', 849, 1951, 43.6008447214762, -116.204934255328);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('390', NULL, 'Leatherman Peak', '1311 West Belmont Street', 8364, 2018, 43.5995379079259, -116.197793537537);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('391', NULL, '1501 Juanita St. ', '1501 Juanita St.', 4148, 1948, 43.6022642831272, -116.207212065185);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('392', NULL, '1105 Manitou', '1105 Manitou', 1856, 1949, 43.5994234935232, -116.198881301951);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('393', 'MCMR', 'Micron Center for Materials Research', '1435 W. University Dr', 95569, 2019, 43.6005306218426, -116.19900584631);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('396', NULL, '1507-1509 Juanita', '1507-1509 Juanita', 1532, 1972, 43.6021116656548, -116.207447378642);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('398', NULL, 'Ambassador Structure (Admin parking lot)', '1890 W. University Dr', 136, 2018, 43.6027441356528, -116.203369072543);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('399', NULL, '2296 Yellowstone Hwy, Suite 305', '2296 Yellowstone Hwy, Suite 305', 145, NULL, 43.5168310089446, -112.00443846765);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('400', NULL, '1801 W. Yale Court', '1801 W. Yale Court', 5808, 1960, 43.6017852248315, -116.204399622206);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('401', NULL, '1833 W. Potter Dr', '1833 W. Potter Dr', 1319, 1951, 43.6009956582703, -116.20539343338);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('402', NULL, '1837 W. Potter Dr', '1837 W. Potter Dr', 0, 1957, 43.6010422746069, -116.205557048126);
INSERT INTO public.buildings (building_code, abbreviation, building_name, address, gross_sf, year_built, x_coord, y_coord) VALUES ('102N', 'REC', 'Student Recreation Center - Natatorium', '1516 UNIVERSITY', 0, 2010, 43.6017742558921, -116.201692148587);


--
-- TOC entry 4034 (class 0 OID 14524344)
-- Dependencies: 203
-- Data for Name: meter; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76802029, '008', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76797011, '070', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66509169, '084', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (22202725, '084', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (10340450, '119', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (10894900, '125', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36116353, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359901, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360030, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359904, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360076, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359925, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360020, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360031, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359929, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359900, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360027, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359906, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360078, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66532587, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75324346, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360032, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359930, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359899, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360028, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359905, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360075, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359926, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360019, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360033, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359928, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359902, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360029, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359903, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360077, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359924, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360022, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360034, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359927, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36116444, '154', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360047, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359990, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360052, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359984, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360057, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360009, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360056, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360007, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360048, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359987, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360051, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359985, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360055, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360010, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360049, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359989, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (10744496, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359983, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360058, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360008, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360050, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359988, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360053, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359986, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66508041, '155', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359992, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360039, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360038, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359994, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359974, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359896, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359898, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359973, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359991, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360040, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360036, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359993, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359971, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359897, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359895, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359972, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360042, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360041, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360037, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360035, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36052635, '156', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360025, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360018, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360005, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360024, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359958, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359954, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359922, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359955, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359919, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359952, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359921, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359957, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360023, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360017, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360003, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360015, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359920, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359951, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359953, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359956, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360026, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360004, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360006, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360016, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36116305, '157', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360001, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360070, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360067, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359960, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359945, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359968, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359967, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359962, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359944, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359959, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359969, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360073, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360000, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360071, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360069, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359946, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359943, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359961, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359970, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360002, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359999, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360072, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360068, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36052612, '158', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359910, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359908, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359936, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359939, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359948, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359916, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359889, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359950, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359949, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359915, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359888, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359947, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359942, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359909, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359935, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359941, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359918, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359917, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359890, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359887, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359940, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359907, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359938, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359937, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36052614, '159', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359975, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359995, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359892, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359966, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360062, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359911, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359883, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360060, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360059, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359912, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359884, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359914, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359977, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359997, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359893, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359964, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360061, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359885, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359886, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359913, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359978, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359998, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359894, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359965, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359976, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359996, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359891, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359963, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36373800, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360074, '160', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76803521, '203', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (21262879, '204', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76841663, '266', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (53610644, '326', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (52747069, '326', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (41125290, '326', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36209851, '326', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (62715013, '330', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36263556, '331', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (20049896, '358', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76831462, '392', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66501112, '099', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75330632, '137', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75330976, '308', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66509171, '065', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76799590, '355', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76799589, '355', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (55077997, '292', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75330914, '391', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75330922, '391', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66568819, '087', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66532737, '087', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75330964, '396', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76954477, '310', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75330963, '396', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (77785032, '301', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75330967, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76954272, '302', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66515488, '334', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76951514, '366', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (74857292, '382', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76954274, '022', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76951511, '309', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76955477, '320', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76955475, '023', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76954134, '336', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (19410537, '374', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76954133, '351', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76951515, '389', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76951516, '360', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76951532, '305', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76840855, '306', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76840854, '306', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36451910, '093', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (10090219, '006', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (79551562, '401', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (20653789, '401', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66564369, '402', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (10320376, '396', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953523, '307', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76796554, '375', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76951465, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76954259, '299', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76951466, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76951464, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66526285, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76952175, '054', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75322761, '090', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76844483, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (9080131, '004', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953459, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953462, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953484, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953486, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953485, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953483, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75330242, '388', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (13826162, '388', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953453, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953461, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953452, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953460, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953451, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953454, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953444, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953445, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953474, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953443, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953473, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953446, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953430, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66525508, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953427, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953472, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953429, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953428, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76955602, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953465, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76955599, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953466, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76955601, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76955600, '176', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (77371527, '034', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76955983, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76952834, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76955986, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953463, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953464, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76952832, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76844482, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953450, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953489, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953447, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953490, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953448, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953449, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953480, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (10290814, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953481, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953479, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953487, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953482, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76955547, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36266089, '100', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66574401, '390', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953441, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76955549, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76955550, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953440, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (76953439, '177', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360481, '082', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66507186, '049', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (21862645, '289', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36371623, '210', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (52462847, '210', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36371574, '211', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (41082523, '211', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (41069382, '213', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36451446, '213', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36129041, '215', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (55077897, '215', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36332653, '362', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329619, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329569, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329607, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329626, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329621, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329567, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329610, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329625, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329570, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329568, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329624, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329620, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75061601, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329623, '180', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329589, '181', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329594, '181', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329572, '181', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329566, '181', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329588, '181', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329592, '181', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329573, '181', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329565, '181', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329593, '181', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329591, '181', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329571, '181', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329564, '181', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329574, '181', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329587, '181', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329582, '182', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329584, '182', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328806, '182', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66536649, '182', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329580, '182', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329583, '182', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328803, '182', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328795, '182', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329585, '182', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329586, '182', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328798, '182', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75330943, '182', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328797, '182', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329579, '182', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329600, '183', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329605, '183', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329576, '183', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329563, '183', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329599, '183', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329603, '183', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329575, '183', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329581, '183', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329602, '183', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329601, '183', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329590, '183', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329577, '183', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329578, '183', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329606, '183', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75332082, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327782, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329611, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329617, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329618, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329616, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75332079, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327779, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329615, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329598, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329596, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329612, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327781, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327780, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329595, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75332081, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329613, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75329614, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75332080, '184', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75360466, '185', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359275, '098', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328801, '173', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328804, '173', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328802, '173', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328799, '173', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328805, '173', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328800, '173', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75359281, '173', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75326229, '173', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75326230, '173', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75326228, '173', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75326235, '173', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75326227, '173', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75326238, '173', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327961, '174', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327951, '174', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327962, '174', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327953, '174', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327954, '174', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327952, '174', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327955, '174', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327957, '174', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327956, '174', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327959, '174', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327958, '174', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75327960, '174', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331553, '175', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331552, '175', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331554, '175', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328832, '175', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331551, '175', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328833, '175', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328834, '175', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328827, '175', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328831, '175', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (77413027, '175', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328830, '175', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75328828, '175', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (50349433, '214', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (64753843, '347', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36371561, '347', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36128991, '278', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (36451735, '216', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (41042231, '352', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (71365791, '352', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75330626, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75330675, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75330677, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75330678, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331426, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331423, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331425, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331371, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331374, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331372, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331373, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331363, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331365, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331364, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331366, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331450, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331449, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331448, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331447, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331424, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331429, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331427, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331430, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331377, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331376, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331378, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331375, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331419, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331422, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331421, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331420, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331355, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331357, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331356, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331358, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331428, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331432, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331431, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331433, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331380, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331381, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331382, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331379, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331368, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331369, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331367, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331370, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331361, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331360, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331359, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (75331362, '178', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (66509940, '078', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (58162343, '121', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (68296175, '348', 2);
INSERT INTO public.meter (meter_id, building_code, utility_id) VALUES (77265947, '122', 2);


--
-- TOC entry 4036 (class 0 OID 14524367)
-- Dependencies: 205
-- Data for Name: premise; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60265461, '008', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60332430, '070', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60045860, '084', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60582616, '084', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60420117, '119', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60472570, '125', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60349546, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60470280, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60266742, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60299504, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60176770, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60404642, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60018719, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60269228, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60350968, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60406770, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60495524, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60446660, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60022692, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60145708, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60316552, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60142883, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60493976, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60351775, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60211825, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60210630, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60117298, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60092482, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60385936, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60263009, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60347931, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60331806, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60226536, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60386890, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60144514, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60325988, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60482043, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60298219, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60257384, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60420353, '154', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60090813, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60516491, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60054828, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60419379, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60459520, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60044047, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60049735, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60254748, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60375727, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60102850, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60182561, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60178760, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60207681, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60127723, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60486562, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60062214, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60504579, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60174789, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60347155, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60504990, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60165893, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60457350, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60025401, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60113216, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60369006, '155', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60248942, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60181230, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60254709, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60280611, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60341838, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60243522, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60110647, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60120678, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60410398, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60340448, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60263656, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60367686, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60386017, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60344591, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60244086, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60103317, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60501513, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60525670, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60451307, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60151042, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60424728, '156', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60220114, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60002725, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60170433, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60465171, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60238159, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60233051, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60071125, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60352232, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60315420, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60383642, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60264696, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60501661, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60192267, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60514623, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60199950, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60312069, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60340746, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60161327, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60112202, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60229296, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60163871, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60220188, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60015216, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60277228, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60001981, '157', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60381338, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60019791, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60231343, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60370967, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60104036, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60316274, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60343934, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60381018, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60166469, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60016081, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60351987, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60269929, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60164732, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60178945, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60164558, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60171368, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60125821, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60205028, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60146029, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60491659, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60436452, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60329121, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60383166, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60008648, '158', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60240725, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60171629, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60332713, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60124882, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60481056, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60246810, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60215561, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60005303, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60150062, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60225485, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60416018, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60506591, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60443352, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60391773, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60376462, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60353942, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60100954, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60071170, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60106831, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60527306, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60172674, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60359376, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60486158, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60299298, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60111218, '159', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60304127, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60025333, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60178594, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60427717, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60066874, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60470683, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60233642, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60173079, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60267225, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60068507, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60458289, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60202225, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60397363, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60428724, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60043901, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60418428, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60461318, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60125487, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60508631, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60268064, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60325774, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60149380, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60511755, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60089732, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60238668, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60080006, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60028419, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60423875, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60179461, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60367854, '160', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60316623, '203', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60134536, '204', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60051089, '266', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60256048, '326', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60100230, '326', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60410136, '326', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60164538, '326', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60333999, '330', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60492813, '331', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60191272, '358', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60470035, '392', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60420140, '100', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60580378, '390', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60013621, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60068155, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60360506, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60142560, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60182721, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60146460, '082', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60253786, '049', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60338347, '289', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60401250, '210', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60006813, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60040762, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60454980, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60058615, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60203845, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60381183, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60215003, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60078630, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60179887, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60119739, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60211094, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60185056, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60177087, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60229840, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60252435, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60330003, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60467693, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60186897, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60297903, '034', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60233842, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60253066, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60346593, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60506219, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60355830, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60503628, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60241328, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60519773, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60166817, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60372459, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60183090, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60526531, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60136011, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60322870, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60153265, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60378647, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60424802, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60145580, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60334493, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60196882, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60319569, '211', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60116188, '213', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60211961, '213', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60105930, '215', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60540480, '215', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60010212, '362', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60325715, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60212006, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60021991, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60145288, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60341407, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60113341, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60277214, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60359494, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60320752, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60023805, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60165154, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60209590, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60063015, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60022013, '181', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60108562, '181', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60341740, '181', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60311768, '181', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60138227, '181', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60169136, '181', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60516251, '181', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60065852, '181', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60182106, '181', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60033840, '181', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60323361, '181', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60331890, '181', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60312421, '181', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60307370, '182', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60341486, '182', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60396609, '182', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60245819, '182', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60043216, '182', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60487540, '182', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60119950, '182', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60439645, '182', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60076504, '182', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60302016, '182', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60100249, '182', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60268357, '182', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60168350, '182', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60197675, '183', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60229307, '183', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60293861, '183', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60021033, '183', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60434322, '183', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60490119, '183', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60385141, '183', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60296842, '183', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60338947, '183', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60193573, '183', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60289576, '183', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60474653, '183', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60001566, '183', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60292123, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60243648, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60021816, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60107393, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60209821, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60373865, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60118348, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60202443, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60317273, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60381895, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60285383, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60380474, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60052456, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60297346, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60493487, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60272711, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60062212, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60126734, '184', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60484938, '185', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60437880, '098', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60258719, '173', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60355440, '173', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60310051, '173', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60192393, '173', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60259856, '173', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60458011, '173', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60374056, '173', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60100185, '173', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60063354, '173', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60093390, '173', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60243550, '173', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60059522, '173', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60377640, '173', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60314074, '174', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60442751, '174', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60214462, '174', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60315434, '174', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60357311, '174', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60120506, '174', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60036652, '174', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60002620, '174', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60010796, '174', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60088074, '174', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60005820, '174', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60183659, '174', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60429568, '175', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60482602, '175', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60231457, '175', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60327965, '175', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60058968, '175', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60248577, '175', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60409612, '099', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60324489, '137', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60369981, '308', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60304940, '065', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60312524, '355', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60159585, '355', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60332875, '292', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60128912, '391', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60508260, '391', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60124551, '087', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60100539, '087', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60405961, '396', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60281318, '310', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60337815, '396', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60036861, '301', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60296771, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60135526, '302', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60066837, '334', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60430537, '366', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60203305, '382', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60567004, '382', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60464622, '022', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60244014, '309', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60485688, '320', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60083186, '023', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60254504, '336', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60141420, '374', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60206402, '351', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60440527, '389', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60332220, '360', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60177038, '305', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60296017, '306', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60166948, '306', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60324541, '093', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60039965, '006', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60448240, '401', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60247756, '401', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60023680, '402', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60409969, '396', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60421267, '307', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60294432, '375', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60497207, '177', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60192755, '299', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60169631, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60150576, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60233668, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60156203, '054', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60315910, '090', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60315914, '180', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60221345, '004', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60395893, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60099647, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60214973, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60463662, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (553113714, '022', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6567513203, '023', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3142713631, '070', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3488213119, '070', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3121623294, '078', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4035803655, '087', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1298343479, '090', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2170623690, '093', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3286123370, '098', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3579303047, '105', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4759523071, '119', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8437343955, '121', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7437343439, '122', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5198433436, '146', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (556033475, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7995903956, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8056133462, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4024813478, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2024813968, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2977003514, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (977003989, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4995903988, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1010413997, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2038223477, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4977003502, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3174043964, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9900413481, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8174043484, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6042723511, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2981503536, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3156133021, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3977003968, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6024813955, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6903450, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4156133967, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1156133003, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6981503998, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5995903485, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8995903990, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6995903985, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1142723926, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9995903437, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6038223951, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3010413480, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (274043501, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6174043963, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9981503461, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (473803331, '154', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6574933954, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1567513998, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1571023513, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2685423969, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9453113464, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2699823226, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7453113751, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4618733234, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2571023259, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (685423490, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8449603479, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7599823981, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7604333977, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7435203240, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8599823747, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9567513980, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8567513474, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7622243494, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4718733983, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6449603732, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8699823773, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5435203460, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2604333475, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6604333463, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3549603488, '155', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3160633485, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9571023452, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1704333503, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5449603989, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2549603482, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (718733454, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5604333974, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9467513465, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1553113474, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (567513969, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6453113971, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7571023965, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4622243447, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4604333991, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5685423481, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8571023972, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3618733463, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8467513988, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5567513957, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3560533971, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1722243506, '156', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9588343980, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1537043837, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9824133965, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (156133341, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8032343863, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2160633977, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (840003471, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5042723460, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7981503487, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7174043448, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7743503996, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2554623979, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (812103976, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9300503356, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7038223864, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8038223867, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4038223342, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1024813470, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2966703511, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7715503973, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5938523486, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4174043888, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (458523838, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5977003375, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7160633866, '157', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2166033953, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7722243484, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4685423487, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4699823478, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2718733508, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6571023971, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3699823489, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8923043972, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9585423510, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1725243978, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3829623488, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2567513963, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7042723458, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1699823993, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4553113468, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9435203962, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3585423976, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9042723961, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8042723469, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5024813975, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (389913485, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2225103977, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (722243994, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4327313457, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2872303974, '158', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6991403477, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4585423501, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7553113976, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3604333482, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (549603989, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2671023493, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2155123979, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1618733975, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6435203999, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5571023473, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4813503976, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9056133514, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4160633489, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8981503984, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4981503471, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5174043974, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9877003978, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5160633982, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7992903967, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9174043981, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5695113960, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6900413472, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5860503458, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8900413491, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1977003461, '159', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6977003499, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7267323449, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9449603453, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3525013484, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1718733480, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8965813507, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7699823960, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2553113482, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (604333467, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9295933975, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (535203968, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7905523455, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4449603486, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4970933961, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8585423966, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (570613505, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1435203990, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (435203992, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5699823984, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8604333972, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3250413969, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6131933456, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9622243967, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1933033973, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2435203970, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3506133483, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3567813464, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6722243967, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2618733958, '160', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9812433263, '166', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6535123359, '180', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2667103855, '180', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1604333358, '180', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5669613851, '180', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9776523346, '180', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2008433354, '180', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3410103871, '180', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1685423373, '180', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7467513878, '180', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3894523856, '180', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6553113359, '180', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (956813852, '180', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5180143347, '181', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1968003850, '181', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8095043355, '181', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4499103872, '181', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9604333374, '181', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8618733879, '181', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8435203361, '181', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8724123857, '181', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2722243853, '181', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9777133348, '181', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6965803851, '181', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6874143356, '181', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (472903873, '182', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7585423375, '182', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6458223880, '182', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7844633362, '182', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1829903854, '182', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6239233349, '182', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3718733852, '182', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6364023357, '182', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3294223874, '182', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (545223376, '182', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3436213363, '182', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2861043859, '182', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9077033362, '183', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (59103855, '183', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9599823350, '183', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5618733853, '183', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6033633358, '183', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3009133377, '183', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8311813860, '183', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1055043363, '183', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1549603856, '183', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (815903351, '183', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3435203854, '183', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9618733359, '183', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8482733876, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9355223378, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8453113883, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8886303365, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6379533364, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8036103352, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2321243855, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (271333360, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9729113877, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5825703379, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1605113884, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8079243862, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3571023858, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (704333353, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5659923856, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7868003878, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4948003380, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5092433885, '184', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9728343367, '185', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9906803465, '210', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2020313980, '211', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5106343974, '213', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7991403964, '213', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6735033863, '214', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9052623955, '266', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6808923026, '278', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5170533575, '298', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4822023049, '299', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (375423868, '301', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6160633541, '305', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2774933311, '306', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9165513035, '307', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (2474803187, '308', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5038223610, '309', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (1247203363, '310', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7567513699, '320', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3320803117, '334', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7151113599, '336', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3714633227, '338', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7641623995, '348', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5147603136, '351', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5196703562, '355', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5369313074, '355', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4316733872, '361', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9899113628, '366', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3441633979, '369', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3541633022, '370', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6059013114, '374', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3005723563, '375', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (3577429906, '380', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (9547613515, '388', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6721343118, '389', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (4445928928, '390', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8151243687, '391', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6200640516, '393', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (7614523689, '396', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (8650503188, '396', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (6709533000, '401', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (5939013611, '402', 1);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60015823, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60015767, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60348661, '388', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60529174, '388', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60453175, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60432121, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60203819, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60021757, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60160845, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60010225, '176', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60336111, '175', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60442053, '175', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60009344, '175', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60199550, '175', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60027999, '175', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60133269, '175', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60020355, '214', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60522954, '347', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60439745, '347', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60012585, '278', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60271907, '216', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60455861, '352', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60542532, '352', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60463455, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60342737, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60184282, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60498458, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60105833, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60121892, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60268783, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60136629, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60061417, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60108766, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60306105, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60469290, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60069788, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60415941, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60002062, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60487536, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60338061, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60087196, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60424878, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60040272, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60043612, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60438311, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60106663, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60091319, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60009489, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60126388, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60274533, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60501231, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60081831, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60032229, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60281509, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60112194, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60464052, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60401642, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60006671, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60426213, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60283552, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60511331, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60428927, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60151948, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60012252, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60227097, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60321890, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60428216, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60168289, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60365554, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60301329, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60465503, '178', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60075310, '078', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60335843, '121', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60204940, '348', 2);
INSERT INTO public.premise (premise_id, building_code, utility_id) VALUES (60321765, '122', 2);


--
-- TOC entry 4033 (class 0 OID 14524333)
-- Dependencies: 202
-- Data for Name: utilities; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.utilities (utility_id, utility_type) VALUES (1, 'natural_gas');
INSERT INTO public.utilities (utility_id, utility_type) VALUES (2, 'electric');
INSERT INTO public.utilities (utility_id, utility_type) VALUES (3, 'steam');
INSERT INTO public.utilities (utility_id, utility_type) VALUES (4, 'geothermal');
INSERT INTO public.utilities (utility_id, utility_type) VALUES (5, 'solar');


--
-- TOC entry 4054 (class 0 OID 0)
-- Dependencies: 204
-- Name: premise_utility_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.premise_utility_id_seq', 1, false);


--
-- TOC entry 4055 (class 0 OID 0)
-- Dependencies: 206
-- Name: usage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.usage_id_seq', 17013, true);


--
-- TOC entry 4056 (class 0 OID 0)
-- Dependencies: 207
-- Name: usage_utility_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.usage_utility_id_seq', 1, false);


--
-- TOC entry 4058 (class 0 OID 0)
-- Dependencies: 201
-- Name: utilities_utility_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.utilities_utility_id_seq', 1, false);


--
-- TOC entry 3887 (class 2606 OID 14582014)
-- Name: usage duplicate_usage; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usage
    ADD CONSTRAINT duplicate_usage UNIQUE (building_code, utility_id, time_stamp, premise_id);


--
-- TOC entry 3876 (class 2606 OID 14524319)
-- Name: buildings pk_15; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT pk_15 PRIMARY KEY (building_code);


--
-- TOC entry 3881 (class 2606 OID 14526705)
-- Name: meter pk_24; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meter
    ADD CONSTRAINT pk_24 PRIMARY KEY (meter_id);


--
-- TOC entry 3878 (class 2606 OID 14524341)
-- Name: utilities pk_42; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilities
    ADD CONSTRAINT pk_42 PRIMARY KEY (utility_id);


--
-- TOC entry 3891 (class 2606 OID 14524401)
-- Name: usage pk_55; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usage
    ADD CONSTRAINT pk_55 PRIMARY KEY (id);


--
-- TOC entry 3885 (class 2606 OID 14524415)
-- Name: premise pk_86; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.premise
    ADD CONSTRAINT pk_86 PRIMARY KEY (premise_id);


--
-- TOC entry 3888 (class 1259 OID 14524412)
-- Name: fk_61; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fk_61 ON public.usage USING btree (building_code);


--
-- TOC entry 3889 (class 1259 OID 14524413)
-- Name: fk_66; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fk_66 ON public.usage USING btree (utility_id);


--
-- TOC entry 3879 (class 1259 OID 14526714)
-- Name: fk_82; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fk_82 ON public.meter USING btree (building_code);


--
-- TOC entry 3882 (class 1259 OID 14524386)
-- Name: fk_90; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fk_90 ON public.premise USING btree (building_code);


--
-- TOC entry 3883 (class 1259 OID 14524387)
-- Name: fk_93; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fk_93 ON public.premise USING btree (utility_id);


--
-- TOC entry 3899 (class 2606 OID 14524402)
-- Name: usage fk_59; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usage
    ADD CONSTRAINT fk_59 FOREIGN KEY (building_code) REFERENCES public.buildings(building_code);


--
-- TOC entry 3900 (class 2606 OID 14524407)
-- Name: usage fk_64; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usage
    ADD CONSTRAINT fk_64 FOREIGN KEY (utility_id) REFERENCES public.utilities(utility_id);


--
-- TOC entry 3896 (class 2606 OID 14526715)
-- Name: meter fk_80; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meter
    ADD CONSTRAINT fk_80 FOREIGN KEY (building_code) REFERENCES public.buildings(building_code);


--
-- TOC entry 3897 (class 2606 OID 14524376)
-- Name: premise fk_88; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.premise
    ADD CONSTRAINT fk_88 FOREIGN KEY (building_code) REFERENCES public.buildings(building_code);


--
-- TOC entry 3898 (class 2606 OID 14524381)
-- Name: premise fk_91; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.premise
    ADD CONSTRAINT fk_91 FOREIGN KEY (utility_id) REFERENCES public.utilities(utility_id);


--
-- TOC entry 4047 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON SCHEMA public TO PUBLIC;

--
-- TOC entry 4048 (class 0 OID 0)
-- Dependencies: 661
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: -
--


-- Completed on 2022-04-14 09:33:46 MDT

--
-- PostgreSQL database dump complete
--

