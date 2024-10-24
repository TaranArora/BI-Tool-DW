--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+2)
-- Dumped by pg_dump version 16.4 (Debian 16.4-1.pgdg120+2)

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

--
-- Name: finance_schema; Type: SCHEMA; Schema: -; Owner: cosc
--

CREATE SCHEMA finance_schema;


ALTER SCHEMA finance_schema OWNER TO cosc;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: date_dimension; Type: TABLE; Schema: finance_schema; Owner: cosc
--

CREATE TABLE finance_schema.date_dimension (
    date_id integer NOT NULL,
    full_date date NOT NULL,
    day_of_week character varying(15),
    month character varying(15),
    quarter character varying(2),
    year integer,
    is_holiday boolean
);


ALTER TABLE finance_schema.date_dimension OWNER TO cosc;

--
-- Name: date_dimension_date_id_seq; Type: SEQUENCE; Schema: finance_schema; Owner: cosc
--

CREATE SEQUENCE finance_schema.date_dimension_date_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finance_schema.date_dimension_date_id_seq OWNER TO cosc;

--
-- Name: date_dimension_date_id_seq; Type: SEQUENCE OWNED BY; Schema: finance_schema; Owner: cosc
--

ALTER SEQUENCE finance_schema.date_dimension_date_id_seq OWNED BY finance_schema.date_dimension.date_id;


--
-- Name: exchange_dimension; Type: TABLE; Schema: finance_schema; Owner: cosc
--

CREATE TABLE finance_schema.exchange_dimension (
    exchange_id integer NOT NULL,
    exchange_name character varying(100) NOT NULL,
    country character varying(100)
);


ALTER TABLE finance_schema.exchange_dimension OWNER TO cosc;

--
-- Name: exchange_dimension_exchange_id_seq; Type: SEQUENCE; Schema: finance_schema; Owner: cosc
--

CREATE SEQUENCE finance_schema.exchange_dimension_exchange_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finance_schema.exchange_dimension_exchange_id_seq OWNER TO cosc;

--
-- Name: exchange_dimension_exchange_id_seq; Type: SEQUENCE OWNED BY; Schema: finance_schema; Owner: cosc
--

ALTER SEQUENCE finance_schema.exchange_dimension_exchange_id_seq OWNED BY finance_schema.exchange_dimension.exchange_id;


--
-- Name: fact_stock_data; Type: TABLE; Schema: finance_schema; Owner: cosc
--

CREATE TABLE finance_schema.fact_stock_data (
    transaction_id integer NOT NULL,
    stock_id integer,
    date_id integer,
    open_price numeric(10,2),
    close_price numeric(10,2),
    high_price numeric(10,2),
    low_price numeric(10,2),
    volume integer,
    rsi numeric(5,2),
    sma numeric(10,2),
    bollinger_band numeric(10,2)
);


ALTER TABLE finance_schema.fact_stock_data OWNER TO cosc;

--
-- Name: fact_stock_data_transaction_id_seq; Type: SEQUENCE; Schema: finance_schema; Owner: cosc
--

CREATE SEQUENCE finance_schema.fact_stock_data_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finance_schema.fact_stock_data_transaction_id_seq OWNER TO cosc;

--
-- Name: fact_stock_data_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: finance_schema; Owner: cosc
--

ALTER SEQUENCE finance_schema.fact_stock_data_transaction_id_seq OWNED BY finance_schema.fact_stock_data.transaction_id;


--
-- Name: sector_dimension; Type: TABLE; Schema: finance_schema; Owner: cosc
--

CREATE TABLE finance_schema.sector_dimension (
    sector_id integer NOT NULL,
    sector_name character varying(100) NOT NULL
);


ALTER TABLE finance_schema.sector_dimension OWNER TO cosc;

--
-- Name: sector_dimension_sector_id_seq; Type: SEQUENCE; Schema: finance_schema; Owner: cosc
--

CREATE SEQUENCE finance_schema.sector_dimension_sector_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finance_schema.sector_dimension_sector_id_seq OWNER TO cosc;

--
-- Name: sector_dimension_sector_id_seq; Type: SEQUENCE OWNED BY; Schema: finance_schema; Owner: cosc
--

ALTER SEQUENCE finance_schema.sector_dimension_sector_id_seq OWNED BY finance_schema.sector_dimension.sector_id;


--
-- Name: stock_dimension; Type: TABLE; Schema: finance_schema; Owner: cosc
--

CREATE TABLE finance_schema.stock_dimension (
    stock_id integer NOT NULL,
    stock_symbol character varying(10) NOT NULL,
    company_name character varying(255) NOT NULL,
    sector character varying(100),
    currency character varying(10),
    exchange character varying(50)
);


ALTER TABLE finance_schema.stock_dimension OWNER TO cosc;

--
-- Name: stock_dimension_stock_id_seq; Type: SEQUENCE; Schema: finance_schema; Owner: cosc
--

CREATE SEQUENCE finance_schema.stock_dimension_stock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finance_schema.stock_dimension_stock_id_seq OWNER TO cosc;

--
-- Name: stock_dimension_stock_id_seq; Type: SEQUENCE OWNED BY; Schema: finance_schema; Owner: cosc
--

ALTER SEQUENCE finance_schema.stock_dimension_stock_id_seq OWNED BY finance_schema.stock_dimension.stock_id;


--
-- Name: date_dimension date_id; Type: DEFAULT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.date_dimension ALTER COLUMN date_id SET DEFAULT nextval('finance_schema.date_dimension_date_id_seq'::regclass);


--
-- Name: exchange_dimension exchange_id; Type: DEFAULT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.exchange_dimension ALTER COLUMN exchange_id SET DEFAULT nextval('finance_schema.exchange_dimension_exchange_id_seq'::regclass);


--
-- Name: fact_stock_data transaction_id; Type: DEFAULT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.fact_stock_data ALTER COLUMN transaction_id SET DEFAULT nextval('finance_schema.fact_stock_data_transaction_id_seq'::regclass);


--
-- Name: sector_dimension sector_id; Type: DEFAULT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.sector_dimension ALTER COLUMN sector_id SET DEFAULT nextval('finance_schema.sector_dimension_sector_id_seq'::regclass);


--
-- Name: stock_dimension stock_id; Type: DEFAULT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.stock_dimension ALTER COLUMN stock_id SET DEFAULT nextval('finance_schema.stock_dimension_stock_id_seq'::regclass);


--
-- Data for Name: date_dimension; Type: TABLE DATA; Schema: finance_schema; Owner: cosc
--

COPY finance_schema.date_dimension (date_id, full_date, day_of_week, month, quarter, year, is_holiday) FROM stdin;
1	2020-01-02	Thursday	January	Q1	2020	f
2	2020-01-03	Friday	January	Q1	2020	f
3	2020-01-06	Monday	January	Q1	2020	f
4	2020-01-07	Tuesday	January	Q1	2020	f
5	2020-01-08	Wednesday	January	Q1	2020	f
6	2020-01-09	Thursday	January	Q1	2020	f
7	2020-01-10	Friday	January	Q1	2020	f
8	2020-01-13	Monday	January	Q1	2020	f
9	2020-01-14	Tuesday	January	Q1	2020	f
10	2020-01-15	Wednesday	January	Q1	2020	f
11	2020-01-16	Thursday	January	Q1	2020	f
12	2020-01-17	Friday	January	Q1	2020	f
13	2020-01-21	Tuesday	January	Q1	2020	f
14	2020-01-22	Wednesday	January	Q1	2020	f
15	2020-01-23	Thursday	January	Q1	2020	f
16	2020-01-24	Friday	January	Q1	2020	f
17	2020-01-27	Monday	January	Q1	2020	f
18	2020-01-28	Tuesday	January	Q1	2020	f
19	2020-01-29	Wednesday	January	Q1	2020	f
20	2020-01-30	Thursday	January	Q1	2020	f
21	2020-01-31	Friday	January	Q1	2020	f
22	2020-02-03	Monday	February	Q1	2020	f
23	2020-02-04	Tuesday	February	Q1	2020	f
24	2020-02-05	Wednesday	February	Q1	2020	f
25	2020-02-06	Thursday	February	Q1	2020	f
26	2020-02-07	Friday	February	Q1	2020	f
27	2020-02-10	Monday	February	Q1	2020	f
28	2020-02-11	Tuesday	February	Q1	2020	f
29	2020-02-12	Wednesday	February	Q1	2020	f
30	2020-02-13	Thursday	February	Q1	2020	f
31	2020-02-14	Friday	February	Q1	2020	f
32	2020-02-18	Tuesday	February	Q1	2020	f
33	2020-02-19	Wednesday	February	Q1	2020	f
34	2020-02-20	Thursday	February	Q1	2020	f
35	2020-02-21	Friday	February	Q1	2020	f
36	2020-02-24	Monday	February	Q1	2020	f
37	2020-02-25	Tuesday	February	Q1	2020	f
38	2020-02-26	Wednesday	February	Q1	2020	f
39	2020-02-27	Thursday	February	Q1	2020	f
40	2020-02-28	Friday	February	Q1	2020	f
41	2020-03-02	Monday	March	Q1	2020	f
42	2020-03-03	Tuesday	March	Q1	2020	f
43	2020-03-04	Wednesday	March	Q1	2020	f
44	2020-03-05	Thursday	March	Q1	2020	f
45	2020-03-06	Friday	March	Q1	2020	f
46	2020-03-09	Monday	March	Q1	2020	f
47	2020-03-10	Tuesday	March	Q1	2020	f
48	2020-03-11	Wednesday	March	Q1	2020	f
49	2020-03-12	Thursday	March	Q1	2020	f
50	2020-03-13	Friday	March	Q1	2020	f
51	2020-03-16	Monday	March	Q1	2020	f
52	2020-03-17	Tuesday	March	Q1	2020	f
53	2020-03-18	Wednesday	March	Q1	2020	f
54	2020-03-19	Thursday	March	Q1	2020	f
55	2020-03-20	Friday	March	Q1	2020	f
56	2020-03-23	Monday	March	Q1	2020	f
57	2020-03-24	Tuesday	March	Q1	2020	f
58	2020-03-25	Wednesday	March	Q1	2020	f
59	2020-03-26	Thursday	March	Q1	2020	f
60	2020-03-27	Friday	March	Q1	2020	f
61	2020-03-30	Monday	March	Q1	2020	f
62	2020-03-31	Tuesday	March	Q1	2020	f
63	2020-04-01	Wednesday	April	Q2	2020	f
64	2020-04-02	Thursday	April	Q2	2020	f
65	2020-04-03	Friday	April	Q2	2020	f
66	2020-04-06	Monday	April	Q2	2020	f
67	2020-04-07	Tuesday	April	Q2	2020	f
68	2020-04-08	Wednesday	April	Q2	2020	f
69	2020-04-09	Thursday	April	Q2	2020	f
70	2020-04-13	Monday	April	Q2	2020	f
71	2020-04-14	Tuesday	April	Q2	2020	f
72	2020-04-15	Wednesday	April	Q2	2020	f
73	2020-04-16	Thursday	April	Q2	2020	f
74	2020-04-17	Friday	April	Q2	2020	f
75	2020-04-20	Monday	April	Q2	2020	f
76	2020-04-21	Tuesday	April	Q2	2020	f
77	2020-04-22	Wednesday	April	Q2	2020	f
78	2020-04-23	Thursday	April	Q2	2020	f
79	2020-04-24	Friday	April	Q2	2020	f
80	2020-04-27	Monday	April	Q2	2020	f
81	2020-04-28	Tuesday	April	Q2	2020	f
82	2020-04-29	Wednesday	April	Q2	2020	f
83	2020-04-30	Thursday	April	Q2	2020	f
84	2020-05-01	Friday	May	Q2	2020	f
85	2020-05-04	Monday	May	Q2	2020	f
86	2020-05-05	Tuesday	May	Q2	2020	f
87	2020-05-06	Wednesday	May	Q2	2020	f
88	2020-05-07	Thursday	May	Q2	2020	f
89	2020-05-08	Friday	May	Q2	2020	f
90	2020-05-11	Monday	May	Q2	2020	f
91	2020-05-12	Tuesday	May	Q2	2020	f
92	2020-05-13	Wednesday	May	Q2	2020	f
93	2020-05-14	Thursday	May	Q2	2020	f
94	2020-05-15	Friday	May	Q2	2020	f
95	2020-05-18	Monday	May	Q2	2020	f
96	2020-05-19	Tuesday	May	Q2	2020	f
97	2020-05-20	Wednesday	May	Q2	2020	f
98	2020-05-21	Thursday	May	Q2	2020	f
99	2020-05-22	Friday	May	Q2	2020	f
100	2020-05-26	Tuesday	May	Q2	2020	f
101	2020-05-27	Wednesday	May	Q2	2020	f
102	2020-05-28	Thursday	May	Q2	2020	f
103	2020-05-29	Friday	May	Q2	2020	f
104	2020-06-01	Monday	June	Q2	2020	f
105	2020-06-02	Tuesday	June	Q2	2020	f
106	2020-06-03	Wednesday	June	Q2	2020	f
107	2020-06-04	Thursday	June	Q2	2020	f
108	2020-06-05	Friday	June	Q2	2020	f
109	2020-06-08	Monday	June	Q2	2020	f
110	2020-06-09	Tuesday	June	Q2	2020	f
111	2020-06-10	Wednesday	June	Q2	2020	f
112	2020-06-11	Thursday	June	Q2	2020	f
113	2020-06-12	Friday	June	Q2	2020	f
114	2020-06-15	Monday	June	Q2	2020	f
115	2020-06-16	Tuesday	June	Q2	2020	f
116	2020-06-17	Wednesday	June	Q2	2020	f
117	2020-06-18	Thursday	June	Q2	2020	f
118	2020-06-19	Friday	June	Q2	2020	f
119	2020-06-22	Monday	June	Q2	2020	f
120	2020-06-23	Tuesday	June	Q2	2020	f
121	2020-06-24	Wednesday	June	Q2	2020	f
122	2020-06-25	Thursday	June	Q2	2020	f
123	2020-06-26	Friday	June	Q2	2020	f
124	2020-06-29	Monday	June	Q2	2020	f
125	2020-06-30	Tuesday	June	Q2	2020	f
126	2020-07-01	Wednesday	July	Q3	2020	f
127	2020-07-02	Thursday	July	Q3	2020	f
128	2020-07-06	Monday	July	Q3	2020	f
129	2020-07-07	Tuesday	July	Q3	2020	f
130	2020-07-08	Wednesday	July	Q3	2020	f
131	2020-07-09	Thursday	July	Q3	2020	f
132	2020-07-10	Friday	July	Q3	2020	f
133	2020-07-13	Monday	July	Q3	2020	f
134	2020-07-14	Tuesday	July	Q3	2020	f
135	2020-07-15	Wednesday	July	Q3	2020	f
136	2020-07-16	Thursday	July	Q3	2020	f
137	2020-07-17	Friday	July	Q3	2020	f
138	2020-07-20	Monday	July	Q3	2020	f
139	2020-07-21	Tuesday	July	Q3	2020	f
140	2020-07-22	Wednesday	July	Q3	2020	f
141	2020-07-23	Thursday	July	Q3	2020	f
142	2020-07-24	Friday	July	Q3	2020	f
143	2020-07-27	Monday	July	Q3	2020	f
144	2020-07-28	Tuesday	July	Q3	2020	f
145	2020-07-29	Wednesday	July	Q3	2020	f
146	2020-07-30	Thursday	July	Q3	2020	f
147	2020-07-31	Friday	July	Q3	2020	f
148	2020-08-03	Monday	August	Q3	2020	f
149	2020-08-04	Tuesday	August	Q3	2020	f
150	2020-08-05	Wednesday	August	Q3	2020	f
151	2020-08-06	Thursday	August	Q3	2020	f
152	2020-08-07	Friday	August	Q3	2020	f
153	2020-08-10	Monday	August	Q3	2020	f
154	2020-08-11	Tuesday	August	Q3	2020	f
155	2020-08-12	Wednesday	August	Q3	2020	f
156	2020-08-13	Thursday	August	Q3	2020	f
157	2020-08-14	Friday	August	Q3	2020	f
158	2020-08-17	Monday	August	Q3	2020	f
159	2020-08-18	Tuesday	August	Q3	2020	f
160	2020-08-19	Wednesday	August	Q3	2020	f
161	2020-08-20	Thursday	August	Q3	2020	f
162	2020-08-21	Friday	August	Q3	2020	f
163	2020-08-24	Monday	August	Q3	2020	f
164	2020-08-25	Tuesday	August	Q3	2020	f
165	2020-08-26	Wednesday	August	Q3	2020	f
166	2020-08-27	Thursday	August	Q3	2020	f
167	2020-08-28	Friday	August	Q3	2020	f
168	2020-08-31	Monday	August	Q3	2020	f
169	2020-09-01	Tuesday	September	Q3	2020	f
170	2020-09-02	Wednesday	September	Q3	2020	f
171	2020-09-03	Thursday	September	Q3	2020	f
172	2020-09-04	Friday	September	Q3	2020	f
173	2020-09-08	Tuesday	September	Q3	2020	f
174	2020-09-09	Wednesday	September	Q3	2020	f
175	2020-09-10	Thursday	September	Q3	2020	f
176	2020-09-11	Friday	September	Q3	2020	f
177	2020-09-14	Monday	September	Q3	2020	f
178	2020-09-15	Tuesday	September	Q3	2020	f
179	2020-09-16	Wednesday	September	Q3	2020	f
180	2020-09-17	Thursday	September	Q3	2020	f
181	2020-09-18	Friday	September	Q3	2020	f
182	2020-09-21	Monday	September	Q3	2020	f
183	2020-09-22	Tuesday	September	Q3	2020	f
184	2020-09-23	Wednesday	September	Q3	2020	f
185	2020-09-24	Thursday	September	Q3	2020	f
186	2020-09-25	Friday	September	Q3	2020	f
187	2020-09-28	Monday	September	Q3	2020	f
188	2020-09-29	Tuesday	September	Q3	2020	f
189	2020-09-30	Wednesday	September	Q3	2020	f
190	2020-10-01	Thursday	October	Q4	2020	f
191	2020-10-02	Friday	October	Q4	2020	f
192	2020-10-05	Monday	October	Q4	2020	f
193	2020-10-06	Tuesday	October	Q4	2020	f
194	2020-10-07	Wednesday	October	Q4	2020	f
195	2020-10-08	Thursday	October	Q4	2020	f
196	2020-10-09	Friday	October	Q4	2020	f
197	2020-10-12	Monday	October	Q4	2020	f
198	2020-10-13	Tuesday	October	Q4	2020	f
199	2020-10-14	Wednesday	October	Q4	2020	f
200	2020-10-15	Thursday	October	Q4	2020	f
201	2020-10-16	Friday	October	Q4	2020	f
202	2020-10-19	Monday	October	Q4	2020	f
203	2020-10-20	Tuesday	October	Q4	2020	f
204	2020-10-21	Wednesday	October	Q4	2020	f
205	2020-10-22	Thursday	October	Q4	2020	f
206	2020-10-23	Friday	October	Q4	2020	f
207	2020-10-26	Monday	October	Q4	2020	f
208	2020-10-27	Tuesday	October	Q4	2020	f
209	2020-10-28	Wednesday	October	Q4	2020	f
210	2020-10-29	Thursday	October	Q4	2020	f
211	2020-10-30	Friday	October	Q4	2020	f
212	2020-11-02	Monday	November	Q4	2020	f
213	2020-11-03	Tuesday	November	Q4	2020	f
214	2020-11-04	Wednesday	November	Q4	2020	f
215	2020-11-05	Thursday	November	Q4	2020	f
216	2020-11-06	Friday	November	Q4	2020	f
217	2020-11-09	Monday	November	Q4	2020	f
218	2020-11-10	Tuesday	November	Q4	2020	f
219	2020-11-11	Wednesday	November	Q4	2020	f
220	2020-11-12	Thursday	November	Q4	2020	f
221	2020-11-13	Friday	November	Q4	2020	f
222	2020-11-16	Monday	November	Q4	2020	f
223	2020-11-17	Tuesday	November	Q4	2020	f
224	2020-11-18	Wednesday	November	Q4	2020	f
225	2020-11-19	Thursday	November	Q4	2020	f
226	2020-11-20	Friday	November	Q4	2020	f
227	2020-11-23	Monday	November	Q4	2020	f
228	2020-11-24	Tuesday	November	Q4	2020	f
229	2020-11-25	Wednesday	November	Q4	2020	f
230	2020-11-27	Friday	November	Q4	2020	f
231	2020-11-30	Monday	November	Q4	2020	f
232	2020-12-01	Tuesday	December	Q4	2020	f
233	2020-12-02	Wednesday	December	Q4	2020	f
234	2020-12-03	Thursday	December	Q4	2020	f
235	2020-12-04	Friday	December	Q4	2020	f
236	2020-12-07	Monday	December	Q4	2020	f
237	2020-12-08	Tuesday	December	Q4	2020	f
238	2020-12-09	Wednesday	December	Q4	2020	f
239	2020-12-10	Thursday	December	Q4	2020	f
240	2020-12-11	Friday	December	Q4	2020	f
241	2020-12-14	Monday	December	Q4	2020	f
242	2020-12-15	Tuesday	December	Q4	2020	f
243	2020-12-16	Wednesday	December	Q4	2020	f
244	2020-12-17	Thursday	December	Q4	2020	f
245	2020-12-18	Friday	December	Q4	2020	f
246	2020-12-21	Monday	December	Q4	2020	f
247	2020-12-22	Tuesday	December	Q4	2020	f
248	2020-12-23	Wednesday	December	Q4	2020	f
249	2020-12-24	Thursday	December	Q4	2020	f
250	2020-12-28	Monday	December	Q4	2020	f
251	2020-12-29	Tuesday	December	Q4	2020	f
252	2020-12-30	Wednesday	December	Q4	2020	f
253	2020-12-31	Thursday	December	Q4	2020	f
254	2021-01-04	Monday	January	Q1	2021	f
255	2021-01-05	Tuesday	January	Q1	2021	f
256	2021-01-06	Wednesday	January	Q1	2021	f
257	2021-01-07	Thursday	January	Q1	2021	f
258	2021-01-08	Friday	January	Q1	2021	f
259	2021-01-11	Monday	January	Q1	2021	f
260	2021-01-12	Tuesday	January	Q1	2021	f
261	2021-01-13	Wednesday	January	Q1	2021	f
262	2021-01-14	Thursday	January	Q1	2021	f
263	2021-01-15	Friday	January	Q1	2021	f
264	2021-01-19	Tuesday	January	Q1	2021	f
265	2021-01-20	Wednesday	January	Q1	2021	f
266	2021-01-21	Thursday	January	Q1	2021	f
267	2021-01-22	Friday	January	Q1	2021	f
268	2021-01-25	Monday	January	Q1	2021	f
269	2021-01-26	Tuesday	January	Q1	2021	f
270	2021-01-27	Wednesday	January	Q1	2021	f
271	2021-01-28	Thursday	January	Q1	2021	f
272	2021-01-29	Friday	January	Q1	2021	f
273	2021-02-01	Monday	February	Q1	2021	f
274	2021-02-02	Tuesday	February	Q1	2021	f
275	2021-02-03	Wednesday	February	Q1	2021	f
276	2021-02-04	Thursday	February	Q1	2021	f
277	2021-02-05	Friday	February	Q1	2021	f
278	2021-02-08	Monday	February	Q1	2021	f
279	2021-02-09	Tuesday	February	Q1	2021	f
280	2021-02-10	Wednesday	February	Q1	2021	f
281	2021-02-11	Thursday	February	Q1	2021	f
282	2021-02-12	Friday	February	Q1	2021	f
283	2021-02-16	Tuesday	February	Q1	2021	f
284	2021-02-17	Wednesday	February	Q1	2021	f
285	2021-02-18	Thursday	February	Q1	2021	f
286	2021-02-19	Friday	February	Q1	2021	f
287	2021-02-22	Monday	February	Q1	2021	f
288	2021-02-23	Tuesday	February	Q1	2021	f
289	2021-02-24	Wednesday	February	Q1	2021	f
290	2021-02-25	Thursday	February	Q1	2021	f
291	2021-02-26	Friday	February	Q1	2021	f
292	2021-03-01	Monday	March	Q1	2021	f
293	2021-03-02	Tuesday	March	Q1	2021	f
294	2021-03-03	Wednesday	March	Q1	2021	f
295	2021-03-04	Thursday	March	Q1	2021	f
296	2021-03-05	Friday	March	Q1	2021	f
297	2021-03-08	Monday	March	Q1	2021	f
298	2021-03-09	Tuesday	March	Q1	2021	f
299	2021-03-10	Wednesday	March	Q1	2021	f
300	2021-03-11	Thursday	March	Q1	2021	f
301	2021-03-12	Friday	March	Q1	2021	f
302	2021-03-15	Monday	March	Q1	2021	f
303	2021-03-16	Tuesday	March	Q1	2021	f
304	2021-03-17	Wednesday	March	Q1	2021	f
305	2021-03-18	Thursday	March	Q1	2021	f
306	2021-03-19	Friday	March	Q1	2021	f
307	2021-03-22	Monday	March	Q1	2021	f
308	2021-03-23	Tuesday	March	Q1	2021	f
309	2021-03-24	Wednesday	March	Q1	2021	f
310	2021-03-25	Thursday	March	Q1	2021	f
311	2021-03-26	Friday	March	Q1	2021	f
312	2021-03-29	Monday	March	Q1	2021	f
313	2021-03-30	Tuesday	March	Q1	2021	f
314	2021-03-31	Wednesday	March	Q1	2021	f
315	2021-04-01	Thursday	April	Q2	2021	f
316	2021-04-05	Monday	April	Q2	2021	f
317	2021-04-06	Tuesday	April	Q2	2021	f
318	2021-04-07	Wednesday	April	Q2	2021	f
319	2021-04-08	Thursday	April	Q2	2021	f
320	2021-04-09	Friday	April	Q2	2021	f
321	2021-04-12	Monday	April	Q2	2021	f
322	2021-04-13	Tuesday	April	Q2	2021	f
323	2021-04-14	Wednesday	April	Q2	2021	f
324	2021-04-15	Thursday	April	Q2	2021	f
325	2021-04-16	Friday	April	Q2	2021	f
326	2021-04-19	Monday	April	Q2	2021	f
327	2021-04-20	Tuesday	April	Q2	2021	f
328	2021-04-21	Wednesday	April	Q2	2021	f
329	2021-04-22	Thursday	April	Q2	2021	f
330	2021-04-23	Friday	April	Q2	2021	f
331	2021-04-26	Monday	April	Q2	2021	f
332	2021-04-27	Tuesday	April	Q2	2021	f
333	2021-04-28	Wednesday	April	Q2	2021	f
334	2021-04-29	Thursday	April	Q2	2021	f
335	2021-04-30	Friday	April	Q2	2021	f
336	2021-05-03	Monday	May	Q2	2021	f
337	2021-05-04	Tuesday	May	Q2	2021	f
338	2021-05-05	Wednesday	May	Q2	2021	f
339	2021-05-06	Thursday	May	Q2	2021	f
340	2021-05-07	Friday	May	Q2	2021	f
341	2021-05-10	Monday	May	Q2	2021	f
342	2021-05-11	Tuesday	May	Q2	2021	f
343	2021-05-12	Wednesday	May	Q2	2021	f
344	2021-05-13	Thursday	May	Q2	2021	f
345	2021-05-14	Friday	May	Q2	2021	f
346	2021-05-17	Monday	May	Q2	2021	f
347	2021-05-18	Tuesday	May	Q2	2021	f
348	2021-05-19	Wednesday	May	Q2	2021	f
349	2021-05-20	Thursday	May	Q2	2021	f
350	2021-05-21	Friday	May	Q2	2021	f
351	2021-05-24	Monday	May	Q2	2021	f
352	2021-05-25	Tuesday	May	Q2	2021	f
353	2021-05-26	Wednesday	May	Q2	2021	f
354	2021-05-27	Thursday	May	Q2	2021	f
355	2021-05-28	Friday	May	Q2	2021	f
356	2021-06-01	Tuesday	June	Q2	2021	f
357	2021-06-02	Wednesday	June	Q2	2021	f
358	2021-06-03	Thursday	June	Q2	2021	f
359	2021-06-04	Friday	June	Q2	2021	f
360	2021-06-07	Monday	June	Q2	2021	f
361	2021-06-08	Tuesday	June	Q2	2021	f
362	2021-06-09	Wednesday	June	Q2	2021	f
363	2021-06-10	Thursday	June	Q2	2021	f
364	2021-06-11	Friday	June	Q2	2021	f
365	2021-06-14	Monday	June	Q2	2021	f
366	2021-06-15	Tuesday	June	Q2	2021	f
367	2021-06-16	Wednesday	June	Q2	2021	f
368	2021-06-17	Thursday	June	Q2	2021	f
369	2021-06-18	Friday	June	Q2	2021	f
370	2021-06-21	Monday	June	Q2	2021	f
371	2021-06-22	Tuesday	June	Q2	2021	f
372	2021-06-23	Wednesday	June	Q2	2021	f
373	2021-06-24	Thursday	June	Q2	2021	f
374	2021-06-25	Friday	June	Q2	2021	f
375	2021-06-28	Monday	June	Q2	2021	f
376	2021-06-29	Tuesday	June	Q2	2021	f
377	2021-06-30	Wednesday	June	Q2	2021	f
378	2021-07-01	Thursday	July	Q3	2021	f
379	2021-07-02	Friday	July	Q3	2021	f
380	2021-07-06	Tuesday	July	Q3	2021	f
381	2021-07-07	Wednesday	July	Q3	2021	f
382	2021-07-08	Thursday	July	Q3	2021	f
383	2021-07-09	Friday	July	Q3	2021	f
384	2021-07-12	Monday	July	Q3	2021	f
385	2021-07-13	Tuesday	July	Q3	2021	f
386	2021-07-14	Wednesday	July	Q3	2021	f
387	2021-07-15	Thursday	July	Q3	2021	f
388	2021-07-16	Friday	July	Q3	2021	f
389	2021-07-19	Monday	July	Q3	2021	f
390	2021-07-20	Tuesday	July	Q3	2021	f
391	2021-07-21	Wednesday	July	Q3	2021	f
392	2021-07-22	Thursday	July	Q3	2021	f
393	2021-07-23	Friday	July	Q3	2021	f
394	2021-07-26	Monday	July	Q3	2021	f
395	2021-07-27	Tuesday	July	Q3	2021	f
396	2021-07-28	Wednesday	July	Q3	2021	f
397	2021-07-29	Thursday	July	Q3	2021	f
398	2021-07-30	Friday	July	Q3	2021	f
399	2021-08-02	Monday	August	Q3	2021	f
400	2021-08-03	Tuesday	August	Q3	2021	f
401	2021-08-04	Wednesday	August	Q3	2021	f
402	2021-08-05	Thursday	August	Q3	2021	f
403	2021-08-06	Friday	August	Q3	2021	f
404	2021-08-09	Monday	August	Q3	2021	f
405	2021-08-10	Tuesday	August	Q3	2021	f
406	2021-08-11	Wednesday	August	Q3	2021	f
407	2021-08-12	Thursday	August	Q3	2021	f
408	2021-08-13	Friday	August	Q3	2021	f
409	2021-08-16	Monday	August	Q3	2021	f
410	2021-08-17	Tuesday	August	Q3	2021	f
411	2021-08-18	Wednesday	August	Q3	2021	f
412	2021-08-19	Thursday	August	Q3	2021	f
413	2021-08-20	Friday	August	Q3	2021	f
414	2021-08-23	Monday	August	Q3	2021	f
415	2021-08-24	Tuesday	August	Q3	2021	f
416	2021-08-25	Wednesday	August	Q3	2021	f
417	2021-08-26	Thursday	August	Q3	2021	f
418	2021-08-27	Friday	August	Q3	2021	f
419	2021-08-30	Monday	August	Q3	2021	f
420	2021-08-31	Tuesday	August	Q3	2021	f
421	2021-09-01	Wednesday	September	Q3	2021	f
422	2021-09-02	Thursday	September	Q3	2021	f
423	2021-09-03	Friday	September	Q3	2021	f
424	2021-09-07	Tuesday	September	Q3	2021	f
425	2021-09-08	Wednesday	September	Q3	2021	f
426	2021-09-09	Thursday	September	Q3	2021	f
427	2021-09-10	Friday	September	Q3	2021	f
428	2021-09-13	Monday	September	Q3	2021	f
429	2021-09-14	Tuesday	September	Q3	2021	f
430	2021-09-15	Wednesday	September	Q3	2021	f
431	2021-09-16	Thursday	September	Q3	2021	f
432	2021-09-17	Friday	September	Q3	2021	f
433	2021-09-20	Monday	September	Q3	2021	f
434	2021-09-21	Tuesday	September	Q3	2021	f
435	2021-09-22	Wednesday	September	Q3	2021	f
436	2021-09-23	Thursday	September	Q3	2021	f
437	2021-09-24	Friday	September	Q3	2021	f
438	2021-09-27	Monday	September	Q3	2021	f
439	2021-09-28	Tuesday	September	Q3	2021	f
440	2021-09-29	Wednesday	September	Q3	2021	f
441	2021-09-30	Thursday	September	Q3	2021	f
442	2021-10-01	Friday	October	Q4	2021	f
443	2021-10-04	Monday	October	Q4	2021	f
444	2021-10-05	Tuesday	October	Q4	2021	f
445	2021-10-06	Wednesday	October	Q4	2021	f
446	2021-10-07	Thursday	October	Q4	2021	f
447	2021-10-08	Friday	October	Q4	2021	f
448	2021-10-11	Monday	October	Q4	2021	f
449	2021-10-12	Tuesday	October	Q4	2021	f
450	2021-10-13	Wednesday	October	Q4	2021	f
451	2021-10-14	Thursday	October	Q4	2021	f
452	2021-10-15	Friday	October	Q4	2021	f
453	2021-10-18	Monday	October	Q4	2021	f
454	2021-10-19	Tuesday	October	Q4	2021	f
455	2021-10-20	Wednesday	October	Q4	2021	f
456	2021-10-21	Thursday	October	Q4	2021	f
457	2021-10-22	Friday	October	Q4	2021	f
458	2021-10-25	Monday	October	Q4	2021	f
459	2021-10-26	Tuesday	October	Q4	2021	f
460	2021-10-27	Wednesday	October	Q4	2021	f
461	2021-10-28	Thursday	October	Q4	2021	f
462	2021-10-29	Friday	October	Q4	2021	f
463	2021-11-01	Monday	November	Q4	2021	f
464	2021-11-02	Tuesday	November	Q4	2021	f
465	2021-11-03	Wednesday	November	Q4	2021	f
466	2021-11-04	Thursday	November	Q4	2021	f
467	2021-11-05	Friday	November	Q4	2021	f
468	2021-11-08	Monday	November	Q4	2021	f
469	2021-11-09	Tuesday	November	Q4	2021	f
470	2021-11-10	Wednesday	November	Q4	2021	f
471	2021-11-11	Thursday	November	Q4	2021	f
472	2021-11-12	Friday	November	Q4	2021	f
473	2021-11-15	Monday	November	Q4	2021	f
474	2021-11-16	Tuesday	November	Q4	2021	f
475	2021-11-17	Wednesday	November	Q4	2021	f
476	2021-11-18	Thursday	November	Q4	2021	f
477	2021-11-19	Friday	November	Q4	2021	f
478	2021-11-22	Monday	November	Q4	2021	f
479	2021-11-23	Tuesday	November	Q4	2021	f
480	2021-11-24	Wednesday	November	Q4	2021	f
481	2021-11-26	Friday	November	Q4	2021	f
482	2021-11-29	Monday	November	Q4	2021	f
483	2021-11-30	Tuesday	November	Q4	2021	f
484	2021-12-01	Wednesday	December	Q4	2021	f
485	2021-12-02	Thursday	December	Q4	2021	f
486	2021-12-03	Friday	December	Q4	2021	f
487	2021-12-06	Monday	December	Q4	2021	f
488	2021-12-07	Tuesday	December	Q4	2021	f
489	2021-12-08	Wednesday	December	Q4	2021	f
490	2021-12-09	Thursday	December	Q4	2021	f
491	2021-12-10	Friday	December	Q4	2021	f
492	2021-12-13	Monday	December	Q4	2021	f
493	2021-12-14	Tuesday	December	Q4	2021	f
494	2021-12-15	Wednesday	December	Q4	2021	f
495	2021-12-16	Thursday	December	Q4	2021	f
496	2021-12-17	Friday	December	Q4	2021	f
497	2021-12-20	Monday	December	Q4	2021	f
498	2021-12-21	Tuesday	December	Q4	2021	f
499	2021-12-22	Wednesday	December	Q4	2021	f
500	2021-12-23	Thursday	December	Q4	2021	f
501	2021-12-27	Monday	December	Q4	2021	f
502	2021-12-28	Tuesday	December	Q4	2021	f
503	2021-12-29	Wednesday	December	Q4	2021	f
504	2021-12-30	Thursday	December	Q4	2021	f
505	2021-12-31	Friday	December	Q4	2021	f
506	2022-01-03	Monday	January	Q1	2022	f
507	2022-01-04	Tuesday	January	Q1	2022	f
508	2022-01-05	Wednesday	January	Q1	2022	f
509	2022-01-06	Thursday	January	Q1	2022	f
510	2022-01-07	Friday	January	Q1	2022	f
511	2022-01-10	Monday	January	Q1	2022	f
512	2022-01-11	Tuesday	January	Q1	2022	f
513	2022-01-12	Wednesday	January	Q1	2022	f
514	2022-01-13	Thursday	January	Q1	2022	f
515	2022-01-14	Friday	January	Q1	2022	f
516	2022-01-18	Tuesday	January	Q1	2022	f
517	2022-01-19	Wednesday	January	Q1	2022	f
518	2022-01-20	Thursday	January	Q1	2022	f
519	2022-01-21	Friday	January	Q1	2022	f
520	2022-01-24	Monday	January	Q1	2022	f
521	2022-01-25	Tuesday	January	Q1	2022	f
522	2022-01-26	Wednesday	January	Q1	2022	f
523	2022-01-27	Thursday	January	Q1	2022	f
524	2022-01-28	Friday	January	Q1	2022	f
525	2022-01-31	Monday	January	Q1	2022	f
526	2022-02-01	Tuesday	February	Q1	2022	f
527	2022-02-02	Wednesday	February	Q1	2022	f
528	2022-02-03	Thursday	February	Q1	2022	f
529	2022-02-04	Friday	February	Q1	2022	f
530	2022-02-07	Monday	February	Q1	2022	f
531	2022-02-08	Tuesday	February	Q1	2022	f
532	2022-02-09	Wednesday	February	Q1	2022	f
533	2022-02-10	Thursday	February	Q1	2022	f
534	2022-02-11	Friday	February	Q1	2022	f
535	2022-02-14	Monday	February	Q1	2022	f
536	2022-02-15	Tuesday	February	Q1	2022	f
537	2022-02-16	Wednesday	February	Q1	2022	f
538	2022-02-17	Thursday	February	Q1	2022	f
539	2022-02-18	Friday	February	Q1	2022	f
540	2022-02-22	Tuesday	February	Q1	2022	f
541	2022-02-23	Wednesday	February	Q1	2022	f
542	2022-02-24	Thursday	February	Q1	2022	f
543	2022-02-25	Friday	February	Q1	2022	f
544	2022-02-28	Monday	February	Q1	2022	f
545	2022-03-01	Tuesday	March	Q1	2022	f
546	2022-03-02	Wednesday	March	Q1	2022	f
547	2022-03-03	Thursday	March	Q1	2022	f
548	2022-03-04	Friday	March	Q1	2022	f
549	2022-03-07	Monday	March	Q1	2022	f
550	2022-03-08	Tuesday	March	Q1	2022	f
551	2022-03-09	Wednesday	March	Q1	2022	f
552	2022-03-10	Thursday	March	Q1	2022	f
553	2022-03-11	Friday	March	Q1	2022	f
554	2022-03-14	Monday	March	Q1	2022	f
555	2022-03-15	Tuesday	March	Q1	2022	f
556	2022-03-16	Wednesday	March	Q1	2022	f
557	2022-03-17	Thursday	March	Q1	2022	f
558	2022-03-18	Friday	March	Q1	2022	f
559	2022-03-21	Monday	March	Q1	2022	f
560	2022-03-22	Tuesday	March	Q1	2022	f
561	2022-03-23	Wednesday	March	Q1	2022	f
562	2022-03-24	Thursday	March	Q1	2022	f
563	2022-03-25	Friday	March	Q1	2022	f
564	2022-03-28	Monday	March	Q1	2022	f
565	2022-03-29	Tuesday	March	Q1	2022	f
566	2022-03-30	Wednesday	March	Q1	2022	f
567	2022-03-31	Thursday	March	Q1	2022	f
568	2022-04-01	Friday	April	Q2	2022	f
569	2022-04-04	Monday	April	Q2	2022	f
570	2022-04-05	Tuesday	April	Q2	2022	f
571	2022-04-06	Wednesday	April	Q2	2022	f
572	2022-04-07	Thursday	April	Q2	2022	f
573	2022-04-08	Friday	April	Q2	2022	f
574	2022-04-11	Monday	April	Q2	2022	f
575	2022-04-12	Tuesday	April	Q2	2022	f
576	2022-04-13	Wednesday	April	Q2	2022	f
577	2022-04-14	Thursday	April	Q2	2022	f
578	2022-04-18	Monday	April	Q2	2022	f
579	2022-04-19	Tuesday	April	Q2	2022	f
580	2022-04-20	Wednesday	April	Q2	2022	f
581	2022-04-21	Thursday	April	Q2	2022	f
582	2022-04-22	Friday	April	Q2	2022	f
583	2022-04-25	Monday	April	Q2	2022	f
584	2022-04-26	Tuesday	April	Q2	2022	f
585	2022-04-27	Wednesday	April	Q2	2022	f
586	2022-04-28	Thursday	April	Q2	2022	f
587	2022-04-29	Friday	April	Q2	2022	f
588	2022-05-02	Monday	May	Q2	2022	f
589	2022-05-03	Tuesday	May	Q2	2022	f
590	2022-05-04	Wednesday	May	Q2	2022	f
591	2022-05-05	Thursday	May	Q2	2022	f
592	2022-05-06	Friday	May	Q2	2022	f
593	2022-05-09	Monday	May	Q2	2022	f
594	2022-05-10	Tuesday	May	Q2	2022	f
595	2022-05-11	Wednesday	May	Q2	2022	f
596	2022-05-12	Thursday	May	Q2	2022	f
597	2022-05-13	Friday	May	Q2	2022	f
598	2022-05-16	Monday	May	Q2	2022	f
599	2022-05-17	Tuesday	May	Q2	2022	f
600	2022-05-18	Wednesday	May	Q2	2022	f
601	2022-05-19	Thursday	May	Q2	2022	f
602	2022-05-20	Friday	May	Q2	2022	f
603	2022-05-23	Monday	May	Q2	2022	f
604	2022-05-24	Tuesday	May	Q2	2022	f
605	2022-05-25	Wednesday	May	Q2	2022	f
606	2022-05-26	Thursday	May	Q2	2022	f
607	2022-05-27	Friday	May	Q2	2022	f
608	2022-05-31	Tuesday	May	Q2	2022	f
609	2022-06-01	Wednesday	June	Q2	2022	f
610	2022-06-02	Thursday	June	Q2	2022	f
611	2022-06-03	Friday	June	Q2	2022	f
612	2022-06-06	Monday	June	Q2	2022	f
613	2022-06-07	Tuesday	June	Q2	2022	f
614	2022-06-08	Wednesday	June	Q2	2022	f
615	2022-06-09	Thursday	June	Q2	2022	f
616	2022-06-10	Friday	June	Q2	2022	f
617	2022-06-13	Monday	June	Q2	2022	f
618	2022-06-14	Tuesday	June	Q2	2022	f
619	2022-06-15	Wednesday	June	Q2	2022	f
620	2022-06-16	Thursday	June	Q2	2022	f
621	2022-06-17	Friday	June	Q2	2022	f
622	2022-06-21	Tuesday	June	Q2	2022	f
623	2022-06-22	Wednesday	June	Q2	2022	f
624	2022-06-23	Thursday	June	Q2	2022	f
625	2022-06-24	Friday	June	Q2	2022	f
626	2022-06-27	Monday	June	Q2	2022	f
627	2022-06-28	Tuesday	June	Q2	2022	f
628	2022-06-29	Wednesday	June	Q2	2022	f
629	2022-06-30	Thursday	June	Q2	2022	f
630	2022-07-01	Friday	July	Q3	2022	f
631	2022-07-05	Tuesday	July	Q3	2022	f
632	2022-07-06	Wednesday	July	Q3	2022	f
633	2022-07-07	Thursday	July	Q3	2022	f
634	2022-07-08	Friday	July	Q3	2022	f
635	2022-07-11	Monday	July	Q3	2022	f
636	2022-07-12	Tuesday	July	Q3	2022	f
637	2022-07-13	Wednesday	July	Q3	2022	f
638	2022-07-14	Thursday	July	Q3	2022	f
639	2022-07-15	Friday	July	Q3	2022	f
640	2022-07-18	Monday	July	Q3	2022	f
641	2022-07-19	Tuesday	July	Q3	2022	f
642	2022-07-20	Wednesday	July	Q3	2022	f
643	2022-07-21	Thursday	July	Q3	2022	f
644	2022-07-22	Friday	July	Q3	2022	f
645	2022-07-25	Monday	July	Q3	2022	f
646	2022-07-26	Tuesday	July	Q3	2022	f
647	2022-07-27	Wednesday	July	Q3	2022	f
648	2022-07-28	Thursday	July	Q3	2022	f
649	2022-07-29	Friday	July	Q3	2022	f
650	2022-08-01	Monday	August	Q3	2022	f
651	2022-08-02	Tuesday	August	Q3	2022	f
652	2022-08-03	Wednesday	August	Q3	2022	f
653	2022-08-04	Thursday	August	Q3	2022	f
654	2022-08-05	Friday	August	Q3	2022	f
655	2022-08-08	Monday	August	Q3	2022	f
656	2022-08-09	Tuesday	August	Q3	2022	f
657	2022-08-10	Wednesday	August	Q3	2022	f
658	2022-08-11	Thursday	August	Q3	2022	f
659	2022-08-12	Friday	August	Q3	2022	f
660	2022-08-15	Monday	August	Q3	2022	f
661	2022-08-16	Tuesday	August	Q3	2022	f
662	2022-08-17	Wednesday	August	Q3	2022	f
663	2022-08-18	Thursday	August	Q3	2022	f
664	2022-08-19	Friday	August	Q3	2022	f
665	2022-08-22	Monday	August	Q3	2022	f
666	2022-08-23	Tuesday	August	Q3	2022	f
667	2022-08-24	Wednesday	August	Q3	2022	f
668	2022-08-25	Thursday	August	Q3	2022	f
669	2022-08-26	Friday	August	Q3	2022	f
670	2022-08-29	Monday	August	Q3	2022	f
671	2022-08-30	Tuesday	August	Q3	2022	f
672	2022-08-31	Wednesday	August	Q3	2022	f
673	2022-09-01	Thursday	September	Q3	2022	f
674	2022-09-02	Friday	September	Q3	2022	f
675	2022-09-06	Tuesday	September	Q3	2022	f
676	2022-09-07	Wednesday	September	Q3	2022	f
677	2022-09-08	Thursday	September	Q3	2022	f
678	2022-09-09	Friday	September	Q3	2022	f
679	2022-09-12	Monday	September	Q3	2022	f
680	2022-09-13	Tuesday	September	Q3	2022	f
681	2022-09-14	Wednesday	September	Q3	2022	f
682	2022-09-15	Thursday	September	Q3	2022	f
683	2022-09-16	Friday	September	Q3	2022	f
684	2022-09-19	Monday	September	Q3	2022	f
685	2022-09-20	Tuesday	September	Q3	2022	f
686	2022-09-21	Wednesday	September	Q3	2022	f
687	2022-09-22	Thursday	September	Q3	2022	f
688	2022-09-23	Friday	September	Q3	2022	f
689	2022-09-26	Monday	September	Q3	2022	f
690	2022-09-27	Tuesday	September	Q3	2022	f
691	2022-09-28	Wednesday	September	Q3	2022	f
692	2022-09-29	Thursday	September	Q3	2022	f
693	2022-09-30	Friday	September	Q3	2022	f
694	2022-10-03	Monday	October	Q4	2022	f
695	2022-10-04	Tuesday	October	Q4	2022	f
696	2022-10-05	Wednesday	October	Q4	2022	f
697	2022-10-06	Thursday	October	Q4	2022	f
698	2022-10-07	Friday	October	Q4	2022	f
699	2022-10-10	Monday	October	Q4	2022	f
700	2022-10-11	Tuesday	October	Q4	2022	f
701	2022-10-12	Wednesday	October	Q4	2022	f
702	2022-10-13	Thursday	October	Q4	2022	f
703	2022-10-14	Friday	October	Q4	2022	f
704	2022-10-17	Monday	October	Q4	2022	f
705	2022-10-18	Tuesday	October	Q4	2022	f
706	2022-10-19	Wednesday	October	Q4	2022	f
707	2022-10-20	Thursday	October	Q4	2022	f
708	2022-10-21	Friday	October	Q4	2022	f
709	2022-10-24	Monday	October	Q4	2022	f
710	2022-10-25	Tuesday	October	Q4	2022	f
711	2022-10-26	Wednesday	October	Q4	2022	f
712	2022-10-27	Thursday	October	Q4	2022	f
713	2022-10-28	Friday	October	Q4	2022	f
714	2022-10-31	Monday	October	Q4	2022	f
715	2022-11-01	Tuesday	November	Q4	2022	f
716	2022-11-02	Wednesday	November	Q4	2022	f
717	2022-11-03	Thursday	November	Q4	2022	f
718	2022-11-04	Friday	November	Q4	2022	f
719	2022-11-07	Monday	November	Q4	2022	f
720	2022-11-08	Tuesday	November	Q4	2022	f
721	2022-11-09	Wednesday	November	Q4	2022	f
722	2022-11-10	Thursday	November	Q4	2022	f
723	2022-11-11	Friday	November	Q4	2022	f
724	2022-11-14	Monday	November	Q4	2022	f
725	2022-11-15	Tuesday	November	Q4	2022	f
726	2022-11-16	Wednesday	November	Q4	2022	f
727	2022-11-17	Thursday	November	Q4	2022	f
728	2022-11-18	Friday	November	Q4	2022	f
729	2022-11-21	Monday	November	Q4	2022	f
730	2022-11-22	Tuesday	November	Q4	2022	f
731	2022-11-23	Wednesday	November	Q4	2022	f
732	2022-11-25	Friday	November	Q4	2022	f
733	2022-11-28	Monday	November	Q4	2022	f
734	2022-11-29	Tuesday	November	Q4	2022	f
735	2022-11-30	Wednesday	November	Q4	2022	f
736	2022-12-01	Thursday	December	Q4	2022	f
737	2022-12-02	Friday	December	Q4	2022	f
738	2022-12-05	Monday	December	Q4	2022	f
739	2022-12-06	Tuesday	December	Q4	2022	f
740	2022-12-07	Wednesday	December	Q4	2022	f
741	2022-12-08	Thursday	December	Q4	2022	f
742	2022-12-09	Friday	December	Q4	2022	f
743	2022-12-12	Monday	December	Q4	2022	f
744	2022-12-13	Tuesday	December	Q4	2022	f
745	2022-12-14	Wednesday	December	Q4	2022	f
746	2022-12-15	Thursday	December	Q4	2022	f
747	2022-12-16	Friday	December	Q4	2022	f
748	2022-12-19	Monday	December	Q4	2022	f
749	2022-12-20	Tuesday	December	Q4	2022	f
750	2022-12-21	Wednesday	December	Q4	2022	f
751	2022-12-22	Thursday	December	Q4	2022	f
752	2022-12-23	Friday	December	Q4	2022	f
753	2022-12-27	Tuesday	December	Q4	2022	f
754	2022-12-28	Wednesday	December	Q4	2022	f
755	2022-12-29	Thursday	December	Q4	2022	f
756	2022-12-30	Friday	December	Q4	2022	f
757	2023-01-03	Tuesday	January	Q1	2023	f
758	2023-01-04	Wednesday	January	Q1	2023	f
759	2023-01-05	Thursday	January	Q1	2023	f
760	2023-01-06	Friday	January	Q1	2023	f
761	2023-01-09	Monday	January	Q1	2023	f
762	2023-01-10	Tuesday	January	Q1	2023	f
763	2023-01-11	Wednesday	January	Q1	2023	f
764	2023-01-12	Thursday	January	Q1	2023	f
765	2023-01-13	Friday	January	Q1	2023	f
766	2023-01-17	Tuesday	January	Q1	2023	f
767	2023-01-18	Wednesday	January	Q1	2023	f
768	2023-01-19	Thursday	January	Q1	2023	f
769	2023-01-20	Friday	January	Q1	2023	f
770	2023-01-23	Monday	January	Q1	2023	f
771	2023-01-24	Tuesday	January	Q1	2023	f
772	2023-01-25	Wednesday	January	Q1	2023	f
773	2023-01-26	Thursday	January	Q1	2023	f
774	2023-01-27	Friday	January	Q1	2023	f
775	2023-01-30	Monday	January	Q1	2023	f
776	2023-01-31	Tuesday	January	Q1	2023	f
777	2023-02-01	Wednesday	February	Q1	2023	f
778	2023-02-02	Thursday	February	Q1	2023	f
779	2023-02-03	Friday	February	Q1	2023	f
780	2023-02-06	Monday	February	Q1	2023	f
781	2023-02-07	Tuesday	February	Q1	2023	f
782	2023-02-08	Wednesday	February	Q1	2023	f
783	2023-02-09	Thursday	February	Q1	2023	f
784	2023-02-10	Friday	February	Q1	2023	f
785	2023-02-13	Monday	February	Q1	2023	f
786	2023-02-14	Tuesday	February	Q1	2023	f
787	2023-02-15	Wednesday	February	Q1	2023	f
788	2023-02-16	Thursday	February	Q1	2023	f
789	2023-02-17	Friday	February	Q1	2023	f
790	2023-02-21	Tuesday	February	Q1	2023	f
791	2023-02-22	Wednesday	February	Q1	2023	f
792	2023-02-23	Thursday	February	Q1	2023	f
793	2023-02-24	Friday	February	Q1	2023	f
794	2023-02-27	Monday	February	Q1	2023	f
795	2023-02-28	Tuesday	February	Q1	2023	f
796	2023-03-01	Wednesday	March	Q1	2023	f
797	2023-03-02	Thursday	March	Q1	2023	f
798	2023-03-03	Friday	March	Q1	2023	f
799	2023-03-06	Monday	March	Q1	2023	f
800	2023-03-07	Tuesday	March	Q1	2023	f
801	2023-03-08	Wednesday	March	Q1	2023	f
802	2023-03-09	Thursday	March	Q1	2023	f
803	2023-03-10	Friday	March	Q1	2023	f
804	2023-03-13	Monday	March	Q1	2023	f
805	2023-03-14	Tuesday	March	Q1	2023	f
806	2023-03-15	Wednesday	March	Q1	2023	f
807	2023-03-16	Thursday	March	Q1	2023	f
808	2023-03-17	Friday	March	Q1	2023	f
809	2023-03-20	Monday	March	Q1	2023	f
810	2023-03-21	Tuesday	March	Q1	2023	f
811	2023-03-22	Wednesday	March	Q1	2023	f
812	2023-03-23	Thursday	March	Q1	2023	f
813	2023-03-24	Friday	March	Q1	2023	f
814	2023-03-27	Monday	March	Q1	2023	f
815	2023-03-28	Tuesday	March	Q1	2023	f
816	2023-03-29	Wednesday	March	Q1	2023	f
817	2023-03-30	Thursday	March	Q1	2023	f
818	2023-03-31	Friday	March	Q1	2023	f
819	2023-04-03	Monday	April	Q2	2023	f
820	2023-04-04	Tuesday	April	Q2	2023	f
821	2023-04-05	Wednesday	April	Q2	2023	f
822	2023-04-06	Thursday	April	Q2	2023	f
823	2023-04-10	Monday	April	Q2	2023	f
824	2023-04-11	Tuesday	April	Q2	2023	f
825	2023-04-12	Wednesday	April	Q2	2023	f
826	2023-04-13	Thursday	April	Q2	2023	f
827	2023-04-14	Friday	April	Q2	2023	f
828	2023-04-17	Monday	April	Q2	2023	f
829	2023-04-18	Tuesday	April	Q2	2023	f
830	2023-04-19	Wednesday	April	Q2	2023	f
831	2023-04-20	Thursday	April	Q2	2023	f
832	2023-04-21	Friday	April	Q2	2023	f
833	2023-04-24	Monday	April	Q2	2023	f
834	2023-04-25	Tuesday	April	Q2	2023	f
835	2023-04-26	Wednesday	April	Q2	2023	f
836	2023-04-27	Thursday	April	Q2	2023	f
837	2023-04-28	Friday	April	Q2	2023	f
838	2023-05-01	Monday	May	Q2	2023	f
839	2023-05-02	Tuesday	May	Q2	2023	f
840	2023-05-03	Wednesday	May	Q2	2023	f
841	2023-05-04	Thursday	May	Q2	2023	f
842	2023-05-05	Friday	May	Q2	2023	f
843	2023-05-08	Monday	May	Q2	2023	f
844	2023-05-09	Tuesday	May	Q2	2023	f
845	2023-05-10	Wednesday	May	Q2	2023	f
846	2023-05-11	Thursday	May	Q2	2023	f
847	2023-05-12	Friday	May	Q2	2023	f
848	2023-05-15	Monday	May	Q2	2023	f
849	2023-05-16	Tuesday	May	Q2	2023	f
850	2023-05-17	Wednesday	May	Q2	2023	f
851	2023-05-18	Thursday	May	Q2	2023	f
852	2023-05-19	Friday	May	Q2	2023	f
853	2023-05-22	Monday	May	Q2	2023	f
854	2023-05-23	Tuesday	May	Q2	2023	f
855	2023-05-24	Wednesday	May	Q2	2023	f
856	2023-05-25	Thursday	May	Q2	2023	f
857	2023-05-26	Friday	May	Q2	2023	f
858	2023-05-30	Tuesday	May	Q2	2023	f
859	2023-05-31	Wednesday	May	Q2	2023	f
860	2023-06-01	Thursday	June	Q2	2023	f
861	2023-06-02	Friday	June	Q2	2023	f
862	2023-06-05	Monday	June	Q2	2023	f
863	2023-06-06	Tuesday	June	Q2	2023	f
864	2023-06-07	Wednesday	June	Q2	2023	f
865	2023-06-08	Thursday	June	Q2	2023	f
866	2023-06-09	Friday	June	Q2	2023	f
867	2023-06-12	Monday	June	Q2	2023	f
868	2023-06-13	Tuesday	June	Q2	2023	f
869	2023-06-14	Wednesday	June	Q2	2023	f
870	2023-06-15	Thursday	June	Q2	2023	f
871	2023-06-16	Friday	June	Q2	2023	f
872	2023-06-20	Tuesday	June	Q2	2023	f
873	2023-06-21	Wednesday	June	Q2	2023	f
874	2023-06-22	Thursday	June	Q2	2023	f
875	2023-06-23	Friday	June	Q2	2023	f
876	2023-06-26	Monday	June	Q2	2023	f
877	2023-06-27	Tuesday	June	Q2	2023	f
878	2023-06-28	Wednesday	June	Q2	2023	f
879	2023-06-29	Thursday	June	Q2	2023	f
880	2023-06-30	Friday	June	Q2	2023	f
881	2023-07-03	Monday	July	Q3	2023	f
882	2023-07-05	Wednesday	July	Q3	2023	f
883	2023-07-06	Thursday	July	Q3	2023	f
884	2023-07-07	Friday	July	Q3	2023	f
885	2023-07-10	Monday	July	Q3	2023	f
886	2023-07-11	Tuesday	July	Q3	2023	f
887	2023-07-12	Wednesday	July	Q3	2023	f
888	2023-07-13	Thursday	July	Q3	2023	f
889	2023-07-14	Friday	July	Q3	2023	f
890	2023-07-17	Monday	July	Q3	2023	f
891	2023-07-18	Tuesday	July	Q3	2023	f
892	2023-07-19	Wednesday	July	Q3	2023	f
893	2023-07-20	Thursday	July	Q3	2023	f
894	2023-07-21	Friday	July	Q3	2023	f
895	2023-07-24	Monday	July	Q3	2023	f
896	2023-07-25	Tuesday	July	Q3	2023	f
897	2023-07-26	Wednesday	July	Q3	2023	f
898	2023-07-27	Thursday	July	Q3	2023	f
899	2023-07-28	Friday	July	Q3	2023	f
900	2023-07-31	Monday	July	Q3	2023	f
901	2023-08-01	Tuesday	August	Q3	2023	f
902	2023-08-02	Wednesday	August	Q3	2023	f
903	2023-08-03	Thursday	August	Q3	2023	f
904	2023-08-04	Friday	August	Q3	2023	f
905	2023-08-07	Monday	August	Q3	2023	f
906	2023-08-08	Tuesday	August	Q3	2023	f
907	2023-08-09	Wednesday	August	Q3	2023	f
908	2023-08-10	Thursday	August	Q3	2023	f
909	2023-08-11	Friday	August	Q3	2023	f
910	2023-08-14	Monday	August	Q3	2023	f
911	2023-08-15	Tuesday	August	Q3	2023	f
912	2023-08-16	Wednesday	August	Q3	2023	f
913	2023-08-17	Thursday	August	Q3	2023	f
914	2023-08-18	Friday	August	Q3	2023	f
915	2023-08-21	Monday	August	Q3	2023	f
916	2023-08-22	Tuesday	August	Q3	2023	f
917	2023-08-23	Wednesday	August	Q3	2023	f
918	2023-08-24	Thursday	August	Q3	2023	f
919	2023-08-25	Friday	August	Q3	2023	f
920	2023-08-28	Monday	August	Q3	2023	f
921	2023-08-29	Tuesday	August	Q3	2023	f
922	2023-08-30	Wednesday	August	Q3	2023	f
923	2023-08-31	Thursday	August	Q3	2023	f
924	2023-09-01	Friday	September	Q3	2023	f
925	2023-09-05	Tuesday	September	Q3	2023	f
926	2023-09-06	Wednesday	September	Q3	2023	f
927	2023-09-07	Thursday	September	Q3	2023	f
928	2023-09-08	Friday	September	Q3	2023	f
929	2023-09-11	Monday	September	Q3	2023	f
930	2023-09-12	Tuesday	September	Q3	2023	f
931	2023-09-13	Wednesday	September	Q3	2023	f
932	2023-09-14	Thursday	September	Q3	2023	f
933	2023-09-15	Friday	September	Q3	2023	f
934	2023-09-18	Monday	September	Q3	2023	f
935	2023-09-19	Tuesday	September	Q3	2023	f
936	2023-09-20	Wednesday	September	Q3	2023	f
937	2023-09-21	Thursday	September	Q3	2023	f
938	2023-09-22	Friday	September	Q3	2023	f
939	2023-09-25	Monday	September	Q3	2023	f
940	2023-09-26	Tuesday	September	Q3	2023	f
941	2023-09-27	Wednesday	September	Q3	2023	f
942	2023-09-28	Thursday	September	Q3	2023	f
943	2023-09-29	Friday	September	Q3	2023	f
\.


--
-- Data for Name: exchange_dimension; Type: TABLE DATA; Schema: finance_schema; Owner: cosc
--

COPY finance_schema.exchange_dimension (exchange_id, exchange_name, country) FROM stdin;
1	NMS	USA
\.


--
-- Data for Name: fact_stock_data; Type: TABLE DATA; Schema: finance_schema; Owner: cosc
--

COPY finance_schema.fact_stock_data (transaction_id, stock_id, date_id, open_price, close_price, high_price, low_price, volume, rsi, sma, bollinger_band) FROM stdin;
1	1	1	71.88	72.88	72.94	71.62	135480400	NaN	NaN	NaN
2	1	2	72.10	72.17	72.93	71.94	146322800	NaN	NaN	NaN
3	1	3	71.28	72.74	72.78	71.03	118387200	NaN	NaN	NaN
4	1	4	72.75	72.40	73.01	72.18	108872000	NaN	NaN	NaN
5	1	5	72.10	73.57	73.87	72.10	132079200	NaN	NaN	NaN
6	1	6	74.55	75.13	75.32	74.30	170108400	NaN	NaN	NaN
7	1	7	75.36	75.30	75.87	74.79	140644800	NaN	NaN	NaN
8	1	8	75.62	76.91	76.93	75.50	121532000	NaN	NaN	NaN
9	1	9	76.84	75.87	77.05	75.74	161954400	NaN	NaN	NaN
10	1	10	75.67	75.54	76.55	75.11	121923600	NaN	NaN	NaN
11	1	11	76.09	76.49	76.60	75.72	108829200	NaN	NaN	NaN
12	1	12	76.74	77.34	77.34	76.43	137816400	NaN	NaN	NaN
13	1	13	76.96	76.81	77.41	76.67	110843200	NaN	NaN	NaN
14	1	14	77.30	77.09	77.64	76.99	101832400	70.87	75.02	78.80
15	1	15	77.14	77.46	77.54	76.59	104472000	71.90	75.34	79.12
16	1	16	77.70	77.23	78.45	77.04	146537600	75.40	75.70	79.13
17	1	17	75.23	74.96	75.65	73.98	161940000	59.51	75.86	78.88
18	1	18	75.85	77.08	77.26	75.75	162234000	67.41	76.20	78.51
19	1	19	78.72	78.70	79.55	77.98	216229200	68.47	76.56	78.70
20	1	20	77.77	78.58	78.64	77.34	126743200	63.88	76.81	79.03
21	1	21	77.87	75.10	78.29	74.80	199588400	49.37	76.80	79.06
22	1	22	73.83	74.89	76.06	73.33	173788400	42.99	76.65	79.13
23	1	23	76.51	77.36	77.56	76.10	136616400	54.74	76.76	79.22
24	1	24	78.50	78.00	78.80	77.39	118826800	57.62	76.94	79.37
25	1	25	78.27	78.91	78.91	77.71	105425600	57.53	77.11	79.75
26	1	26	78.40	77.84	78.66	77.34	117684000	51.53	77.14	79.81
27	1	27	76.41	78.21	78.21	76.33	109348800	54.32	77.24	79.96
28	1	28	78.70	77.73	78.78	77.51	94323200	51.98	77.29	80.02
29	1	29	78.19	79.58	79.58	78.19	113730400	55.96	77.44	80.43
30	1	30	78.85	79.01	79.34	78.64	94747600	54.90	77.57	80.67
31	1	31	78.98	79.03	79.28	78.52	80113600	62.80	77.86	80.66
32	1	32	76.70	77.58	77.77	76.52	152531200	51.65	77.89	80.66
33	1	33	77.83	78.71	78.94	77.83	93984000	50.04	77.90	80.66
34	1	34	78.47	77.90	78.96	77.39	100566000	47.79	77.85	80.59
35	1	35	77.49	76.14	77.94	75.52	129554000	53.79	77.92	80.38
36	1	36	72.30	72.52	73.98	70.34	222195200	43.07	77.75	81.23
37	1	37	73.19	70.06	73.58	69.59	230673600	28.66	77.23	82.62
38	1	38	69.69	71.18	72.45	69.68	198054800	30.61	76.74	83.00
39	1	39	68.37	66.52	69.56	66.39	320605600	20.96	75.86	84.01
40	1	40	62.57	66.48	67.71	62.35	426510000	22.03	75.05	84.50
41	1	41	68.65	72.67	73.31	67.55	341397200	39.41	74.65	84.00
42	1	42	73.86	70.37	73.94	69.51	319475600	36.82	74.13	83.56
43	1	43	72.10	73.63	73.79	71.29	219178400	39.87	73.70	82.60
44	1	44	71.87	71.24	72.85	70.87	187572800	37.54	73.15	81.57
45	1	45	68.59	70.30	70.73	68.40	226176800	36.40	72.52	80.34
46	1	46	64.15	64.74	67.64	63.97	286744800	32.27	71.60	79.87
47	1	47	67.40	69.40	69.67	65.51	285290000	38.29	70.94	78.17
48	1	48	67.46	66.99	68.40	66.12	255598800	36.81	70.16	76.45
49	1	49	62.25	60.37	65.67	60.32	418474000	32.95	69.03	76.29
50	1	50	64.42	67.61	68.08	61.52	370732000	45.07	68.68	75.68
51	1	51	58.85	58.91	63.01	58.37	322423600	40.05	67.89	76.55
52	1	52	60.20	61.50	62.65	57.98	324056000	41.59	67.19	76.26
53	1	53	58.32	59.99	60.80	57.67	300233600	44.00	66.73	76.58
54	1	54	60.17	59.53	61.49	59.01	271857200	43.66	66.23	76.81
55	1	55	60.12	55.75	61.25	55.45	401693200	33.86	65.02	76.28
56	1	56	55.47	54.57	55.57	51.71	336752800	34.60	63.89	75.98
57	1	57	57.49	60.04	60.24	56.98	287531200	37.30	62.92	73.76
58	1	58	60.99	59.71	62.81	59.42	303602000	38.80	62.10	71.92
59	1	59	59.96	62.86	62.91	59.92	252087200	43.07	61.57	70.21
60	1	60	61.47	60.25	62.23	60.09	204216800	45.58	61.25	69.71
61	1	61	60.98	61.97	62.15	60.66	167976400	42.22	60.72	67.80
62	1	62	62.17	61.85	63.84	61.29	197002000	44.35	60.35	66.50
63	1	63	59.95	58.59	60.49	58.16	176218400	47.89	60.22	66.45
64	1	64	58.45	59.57	59.62	57.62	165934000	38.79	59.65	64.20
65	1	65	59.05	58.71	59.76	58.12	129880000	49.65	59.64	64.20
66	1	66	61.02	63.84	63.99	60.65	201820400	53.83	59.80	64.81
67	1	67	65.86	63.10	66.08	62.99	202887200	55.21	60.03	65.33
68	1	68	63.90	64.71	65.03	63.53	168895200	58.37	60.40	66.25
69	1	69	65.35	65.18	65.68	64.38	161834800	67.07	61.07	66.79
70	1	70	65.26	66.46	66.57	64.65	131022800	71.45	61.92	66.97
71	1	71	68.10	69.81	70.11	67.63	194994800	69.09	62.62	69.06
72	1	72	68.68	69.18	69.64	68.25	131154400	68.27	63.29	70.38
73	1	73	69.89	69.73	70.09	68.67	157125200	64.74	63.78	71.65
74	1	74	69.24	68.78	69.79	67.34	215250000	69.70	64.39	72.40
75	1	75	67.60	67.35	68.51	67.33	130015200	62.60	64.78	72.80
76	1	76	67.19	65.27	67.43	64.56	180991600	57.35	65.02	72.87
77	1	77	66.55	67.15	67.59	66.20	116862400	69.51	65.63	72.61
78	1	78	67.10	66.89	68.53	66.85	124814400	67.25	66.15	72.21
79	1	79	67.42	68.82	68.83	67.37	126161200	72.67	66.88	71.30
80	1	80	68.54	68.87	69.20	68.09	117087600	64.62	67.24	71.41
81	1	81	69.34	67.75	69.52	67.66	112004800	63.23	67.57	70.99
82	1	82	69.25	69.98	70.45	69.05	137280800	64.47	67.94	71.17
83	1	83	70.52	71.46	71.63	70.13	183064000	66.33	68.39	71.71
84	1	84	69.62	70.31	72.72	69.52	240616800	60.08	68.67	71.93
85	1	85	70.33	71.30	71.43	69.64	133568000	54.44	68.77	72.28
86	1	86	71.76	72.37	73.21	71.62	147751200	59.31	69.00	73.00
87	1	87	73.08	73.12	73.75	72.69	142333600	59.77	69.24	73.81
88	1	88	73.75	73.87	74.22	73.44	115215200	64.83	69.61	74.78
89	1	89	74.54	75.63	75.69	74.21	133838400	73.66	70.20	76.10
90	1	90	75.14	76.82	77.32	74.93	145946400	84.78	71.02	77.18
91	1	91	77.51	75.94	77.96	75.82	162301200	78.18	71.65	77.90
92	1	92	76.12	75.03	77.05	73.94	200622400	75.02	72.23	78.08
93	1	93	74.26	75.49	75.55	73.53	158929200	72.54	72.71	78.44
94	1	94	73.25	75.04	75.09	73.21	166348400	70.32	73.15	78.55
95	1	95	76.37	76.81	77.19	75.68	135178400	78.59	73.80	78.54
96	1	96	76.83	76.37	77.68	76.33	101729600	72.72	74.25	78.63
97	1	97	77.23	77.85	77.92	77.19	111504800	72.73	74.71	79.16
98	1	98	77.71	77.27	78.26	77.03	102688800	75.80	75.21	79.05
99	1	99	77.01	77.77	77.85	76.90	81803200	74.88	75.67	79.02
100	1	100	78.89	77.24	79.07	77.19	125522000	69.55	76.02	78.86
101	1	101	77.10	77.58	77.72	76.35	112945200	68.52	76.34	78.75
102	1	102	77.25	77.61	78.88	76.97	133560800	66.51	76.60	78.64
103	1	103	77.86	77.54	78.32	77.18	153532400	59.88	76.74	78.75
104	1	104	77.49	78.49	78.61	77.36	80791200	58.87	76.86	79.07
105	1	105	78.22	78.85	78.88	77.78	87642800	66.36	77.07	79.45
106	1	106	79.18	79.29	79.55	78.60	104491200	75.34	77.37	79.72
107	1	107	79.11	78.60	79.41	78.23	87560400	68.06	77.59	79.76
108	1	108	78.86	80.84	80.90	78.83	137250400	77.84	78.01	80.29
109	1	109	80.54	81.32	81.36	79.82	95654400	74.71	78.33	81.10
110	1	110	81.00	83.89	84.28	80.97	147712400	83.42	78.87	82.71
111	1	111	84.84	86.05	86.52	84.40	166651600	84.36	79.45	84.82
112	1	112	85.19	81.92	85.61	81.81	201662400	65.01	79.79	85.15
113	1	113	84.07	82.62	84.82	81.51	200146000	65.47	80.13	85.56
114	1	114	81.27	83.65	84.30	81.11	138808800	69.79	80.59	86.05
115	1	115	85.71	85.86	86.14	84.07	165428800	72.93	81.18	87.02
116	1	116	86.61	85.74	86.67	85.62	114406400	72.40	81.76	87.68
117	1	117	85.70	85.78	86.20	85.16	96820400	72.75	82.35	88.10
118	1	118	86.49	85.29	86.95	84.17	264476000	69.26	82.84	88.32
119	1	119	85.68	87.52	87.66	85.64	135445200	72.20	83.45	88.96
120	1	120	88.77	89.39	90.81	88.35	212155600	74.11	84.18	89.97
121	1	121	89.01	87.81	89.94	87.43	192623200	71.07	84.83	89.95
122	1	122	87.96	88.97	89.01	87.20	137522400	69.57	85.41	90.43
123	1	123	88.87	86.24	89.09	86.09	205256800	60.68	85.77	90.20
124	1	124	86.15	88.23	88.32	85.67	130646000	59.67	86.08	90.55
125	1	125	87.81	88.96	89.25	87.79	140223200	56.94	86.28	91.02
126	1	126	89.04	88.80	89.59	88.75	110737200	70.16	86.78	90.95
127	1	127	89.71	88.80	90.35	88.68	114041600	68.87	87.22	90.76
128	1	128	90.23	91.17	91.64	90.20	118655600	71.25	87.75	91.25
129	1	129	91.55	90.89	92.33	90.78	112424400	65.93	88.11	91.80
130	1	130	91.87	93.01	93.04	91.78	117092000	70.44	88.63	92.88
131	1	131	93.90	93.41	93.96	92.35	125642800	71.03	89.18	93.79
132	1	132	93.00	93.57	93.63	92.38	90257200	73.25	89.77	94.36
133	1	133	94.88	93.14	97.50	92.92	191649200	67.55	90.17	94.89
134	1	134	92.52	94.68	94.87	91.58	170989200	66.87	90.55	95.81
135	1	135	96.56	95.33	96.81	94.12	153198000	75.49	91.08	96.67
136	1	136	94.20	94.16	95.02	93.55	110577600	67.55	91.45	97.13
137	1	137	94.61	93.97	94.77	93.49	92186800	81.62	92.01	96.95
138	1	138	94.05	95.95	96.09	93.71	90318000	81.61	92.56	97.41
139	1	139	96.74	94.62	96.82	94.37	103433200	72.10	92.96	97.45
140	1	140	94.32	94.89	95.57	94.23	89001600	73.62	93.40	97.29
141	1	141	94.62	90.57	94.70	89.75	197004400	55.15	93.52	96.84
142	1	142	88.76	90.34	90.69	86.96	185438800	47.26	93.46	96.99
143	1	143	91.41	92.49	92.58	91.19	121214000	54.72	93.58	96.83
144	1	144	92.05	90.97	92.23	90.96	103625600	43.76	93.43	96.97
145	1	145	91.45	92.71	92.90	91.42	90329200	48.03	93.38	96.94
146	1	146	91.88	93.83	93.94	91.47	158130000	50.71	93.40	96.97
147	1	147	100.36	103.66	103.81	98.35	374336800	68.77	94.15	100.68
148	1	148	105.55	106.27	108.90	105.25	308151200	69.92	94.98	104.18
149	1	149	106.46	106.98	108.07	105.73	173071600	69.98	95.81	107.04
150	1	150	106.70	107.36	107.69	106.23	121776800	73.28	96.76	109.50
151	1	151	107.70	111.11	111.61	107.11	202428800	76.86	97.98	112.71
152	1	152	110.63	108.58	111.09	107.78	198045600	69.46	98.88	114.59
153	1	153	110.04	110.16	111.19	107.50	212403600	73.75	99.99	116.57
154	1	154	109.42	106.89	109.92	106.62	187902400	66.79	100.85	117.53
155	1	155	107.98	110.44	110.70	107.79	165598000	78.42	102.27	118.56
156	1	156	111.83	112.39	113.40	111.34	210082000	80.05	103.85	119.42
157	1	157	112.22	112.29	112.38	110.47	165565200	78.58	105.26	119.96
158	1	158	113.42	112.00	113.45	111.37	119561600	81.46	106.76	119.31
159	1	159	111.75	112.93	113.36	111.41	105633600	81.00	108.21	118.18
160	1	160	113.34	113.07	114.50	112.98	145538000	80.41	109.58	115.50
161	1	161	113.12	115.58	115.70	113.10	126907200	74.52	110.43	116.11
162	1	162	116.55	121.54	122.03	116.54	338054800	77.60	111.52	119.25
163	1	163	125.77	122.99	125.85	121.12	345937600	78.19	112.67	122.06
164	1	164	121.86	121.98	122.33	120.25	211495600	75.18	113.71	123.79
165	1	165	123.31	123.64	124.10	122.24	163022400	73.26	114.61	125.85
166	1	166	124.25	122.17	124.58	121.01	155552400	76.22	115.58	126.92
167	1	167	123.15	121.97	123.57	121.74	187630000	74.08	116.42	127.79
168	1	168	124.68	126.10	128.02	123.13	225702700	87.87	117.79	128.84
169	1	169	129.74	131.13	131.73	127.56	151948100	88.53	119.27	131.54
170	1	170	134.46	128.41	134.84	124.11	200119000	79.01	120.42	132.91
171	1	171	124.02	118.13	125.91	117.76	257599600	57.72	120.83	132.52
172	1	172	117.34	118.21	120.89	108.37	332607200	58.26	121.28	131.95
173	1	173	111.36	110.25	116.28	110.12	231366600	47.00	121.08	132.47
174	1	174	114.59	114.65	116.43	112.64	176940500	51.61	121.20	132.27
175	1	175	117.62	110.91	117.76	109.94	182274400	45.33	120.86	132.91
176	1	176	111.96	109.45	112.61	107.50	180860300	36.74	120.00	133.48
177	1	177	112.11	112.73	113.29	110.23	140150100	39.18	119.27	133.16
178	1	178	115.64	112.91	116.13	111.02	184642000	40.26	118.62	132.81
179	1	179	112.61	109.58	113.36	109.49	154679000	35.43	117.61	132.25
180	1	180	107.22	107.83	109.65	106.24	178011000	35.23	116.59	131.85
181	1	181	107.89	104.41	108.36	103.68	287104900	33.03	115.34	131.55
182	1	182	102.16	107.58	107.68	100.75	195713800	31.76	114.01	129.45
183	1	183	110.12	109.27	110.29	106.68	183055400	26.96	112.45	124.47
184	1	184	109.08	104.68	109.56	104.34	150718700	25.94	110.76	119.26
185	1	185	102.78	105.76	107.74	102.61	167743300	34.58	109.87	117.61
186	1	186	105.96	109.73	109.88	105.22	149981400	40.36	109.27	115.35
187	1	187	112.39	112.34	112.70	110.21	137672400	52.70	109.42	115.70
188	1	188	111.94	111.49	112.69	110.99	99382200	45.51	109.19	114.86
189	1	189	111.20	113.17	114.59	111.03	142675200	53.43	109.35	115.36
190	1	190	114.96	114.13	115.04	113.19	116120400	57.19	109.69	116.21
191	1	191	110.32	110.45	112.74	109.67	144712000	46.53	109.52	115.83
192	1	192	111.32	113.85	114.00	110.97	106243800	51.30	109.59	116.07
193	1	193	113.07	110.59	113.48	109.70	161498200	51.39	109.66	116.16
194	1	194	112.01	112.46	112.92	111.53	96849000	56.39	109.99	116.56
195	1	195	113.60	112.35	113.75	111.98	83477200	62.07	110.56	116.38
196	1	196	112.66	114.31	114.34	112.30	100506900	60.62	111.04	116.91
197	1	197	117.33	121.57	122.33	116.57	240226800	66.50	111.92	119.94
198	1	198	122.42	118.34	122.54	116.93	262330500	69.02	112.90	120.43
199	1	199	118.25	118.43	120.23	116.90	150712000	68.14	113.80	120.66
200	1	200	116.02	117.96	118.44	115.46	112559200	63.10	114.39	121.15
201	1	201	118.52	116.31	118.78	116.11	115393800	56.51	114.67	121.40
202	1	202	117.23	113.34	117.68	113.03	120639300	52.83	114.81	121.33
203	1	203	113.56	114.84	116.27	113.00	124423700	52.56	114.92	121.38
204	1	204	114.02	114.21	116.01	113.80	89946000	50.12	114.93	121.38
205	1	205	114.78	113.12	115.35	111.98	101988000	54.52	115.12	121.15
206	1	206	113.74	112.42	113.90	111.68	82572600	47.34	115.02	121.19
207	1	207	111.42	112.43	113.90	110.31	111850700	53.93	115.15	120.98
208	1	208	112.86	113.95	114.61	111.93	92276800	53.21	115.26	120.93
209	1	209	112.43	108.67	112.80	108.57	143937800	43.50	114.99	121.52
210	1	210	109.81	112.70	114.27	109.65	146129200	47.35	114.88	121.51
211	1	211	108.53	106.38	109.44	105.27	190272600	24.22	113.79	120.68
212	1	212	106.63	106.29	108.16	104.88	122866900	27.11	112.93	120.36
213	1	213	107.16	107.93	108.95	106.26	107624400	31.15	112.18	119.33
214	1	214	111.54	112.33	112.96	109.79	138235500	41.15	111.78	118.11
215	1	215	115.27	116.32	116.90	114.21	126387100	50.01	111.78	118.12
216	1	216	115.83	116.19	116.69	113.68	114457900	54.55	111.98	118.71
217	1	217	117.96	113.87	119.42	113.60	154515300	48.50	111.92	118.53
218	1	218	113.12	113.53	115.11	111.73	138023400	48.93	111.87	118.42
219	1	219	114.72	116.97	117.11	113.99	112295000	55.64	112.14	119.22
220	1	220	117.10	116.70	117.99	116.07	103162300	56.33	112.45	119.94
221	1	221	116.92	116.75	117.15	115.39	81581900	56.38	112.76	120.59
222	1	222	116.41	117.77	118.44	115.66	91183000	55.73	113.03	121.30
223	1	223	117.03	116.87	118.13	116.45	74271000	64.18	113.61	121.71
224	1	224	116.11	115.54	117.30	115.51	76322100	55.43	113.82	121.96
225	1	225	115.11	116.14	116.55	114.35	74113000	73.78	114.51	121.50
226	1	226	116.14	114.87	116.27	114.82	73604300	69.75	115.13	120.27
227	1	227	114.71	111.45	115.14	111.35	127959300	57.50	115.38	119.18
228	1	228	111.51	112.74	113.41	110.22	113874200	51.00	115.41	119.11
229	1	229	113.12	113.59	114.29	112.74	76499200	42.06	115.21	119.00
230	1	230	114.11	114.13	115.01	113.77	46691300	44.17	115.07	118.85
231	1	231	114.51	116.54	118.42	114.35	169410200	57.54	115.26	119.05
232	1	232	118.46	120.13	120.87	117.48	127728200	65.75	115.73	120.18
233	1	233	119.45	120.49	120.77	118.34	89004200	59.82	115.98	121.08
234	1	234	120.92	120.35	121.17	119.64	78967600	60.29	116.24	121.85
235	1	235	120.02	119.67	120.27	118.96	78260400	57.96	116.45	122.35
236	1	236	119.73	121.14	121.95	119.67	86712000	58.97	116.69	123.08
237	1	237	121.75	121.76	122.35	120.50	82225500	63.17	117.04	123.98
238	1	238	121.91	119.21	123.30	118.45	115089200	59.29	117.30	124.28
239	1	239	117.96	120.64	121.26	117.62	81312200	60.93	117.62	124.78
240	1	240	119.85	119.83	120.17	118.01	86939800	62.32	117.98	125.04
241	1	241	120.02	119.21	120.75	118.98	79184500	72.39	118.53	124.52
242	1	242	121.72	125.19	125.21	121.51	157243700	78.26	119.42	125.40
243	1	243	124.73	125.12	125.67	123.89	98208600	77.14	120.24	125.93
244	1	244	126.18	125.99	126.85	125.34	94359800	77.49	121.09	126.38
245	1	245	126.24	123.99	126.38	123.46	192541500	67.61	121.62	126.41
246	1	246	122.39	125.53	125.61	120.85	121251600	64.12	122.01	127.14
247	1	247	128.84	129.10	131.58	126.92	168904800	69.30	122.62	128.90
248	1	248	129.38	128.20	129.64	128.02	88223700	67.01	123.19	129.97
249	1	249	128.55	129.19	130.65	128.34	54930100	70.33	123.86	131.03
250	1	250	131.17	133.81	134.45	130.70	124486200	73.86	124.77	133.49
251	1	251	135.14	132.03	135.87	131.51	121047300	68.53	125.50	134.84
252	1	252	132.72	130.90	133.12	130.59	96452100	72.23	126.34	135.33
253	1	253	131.26	129.89	131.90	128.94	99116600	67.88	127.00	135.54
254	1	254	130.71	126.68	130.79	124.09	143301900	62.12	127.49	134.98
255	1	255	126.17	128.25	128.96	125.72	97664900	65.46	128.13	133.92
256	1	256	125.03	123.93	128.29	123.72	155088000	47.73	128.04	134.06
257	1	257	125.66	128.16	128.86	125.17	109578200	54.80	128.26	134.03
258	1	258	129.64	129.27	129.84	127.49	105158200	55.13	128.50	134.14
259	1	259	126.47	126.26	127.43	125.79	100384500	53.44	128.66	133.85
260	1	260	125.79	126.09	126.96	124.19	91951100	50.88	128.70	133.80
261	1	261	126.05	128.13	128.68	125.78	88636800	48.39	128.63	133.73
262	1	262	128.04	126.19	128.24	126.05	90221800	46.78	128.49	133.75
263	1	263	126.07	124.46	127.48	124.32	111598500	42.58	128.15	133.81
264	1	264	125.09	125.14	126.00	124.27	90757300	34.47	127.53	132.36
265	1	265	125.95	129.25	129.70	125.84	104319500	45.40	127.33	131.55
266	1	266	130.98	133.99	136.73	130.78	120150900	54.55	127.55	132.78
267	1	267	133.41	136.14	136.90	132.18	114459400	58.92	128.00	134.89
268	1	268	140.06	139.91	142.03	133.66	157611700	68.59	128.94	138.26
269	1	269	140.57	140.14	141.26	138.39	98390600	67.37	129.79	140.84
270	1	270	140.41	139.07	141.26	137.45	140843800	74.42	130.87	142.40
271	1	271	136.58	134.20	139.00	133.82	142621100	59.55	131.30	142.85
272	1	272	132.97	129.18	133.86	127.47	177523800	49.88	131.30	142.85
273	1	273	130.93	131.31	132.53	128.17	106239800	57.28	131.66	142.84
274	1	274	132.87	132.15	133.44	131.77	83305400	58.58	132.09	142.81
275	1	275	132.90	131.12	132.91	130.79	89880900	54.35	132.30	142.80
276	1	276	133.43	134.50	134.51	131.75	84183100	61.61	132.90	142.83
277	1	277	134.66	134.08	134.73	133.20	75693800	63.96	133.58	142.25
278	1	278	133.36	134.23	134.27	132.27	71297200	63.40	134.23	141.41
279	1	279	133.94	133.34	135.18	133.19	76774200	56.67	134.52	141.14
280	1	280	133.80	132.74	134.30	131.76	73046600	47.64	134.44	141.11
281	1	281	133.24	132.48	133.72	131.15	64280000	42.58	134.17	140.85
282	1	282	131.72	132.72	132.87	131.07	60145100	32.97	133.66	139.49
283	1	283	132.83	130.58	133.34	130.19	80576300	29.22	132.98	137.66
284	1	284	128.68	128.27	129.63	126.93	97918500	27.74	132.21	136.05
285	1	285	126.67	127.17	127.45	124.91	96856700	32.83	131.70	136.20
286	1	286	127.69	127.32	128.15	126.27	87668800	44.06	131.57	136.48
287	1	287	125.50	123.53	127.18	123.14	103916400	27.48	131.02	137.55
288	1	288	121.33	123.39	124.23	116.07	158273000	23.61	130.39	138.04
289	1	289	122.49	122.89	123.10	119.83	111039900	24.39	129.80	138.41
290	1	290	122.24	118.62	123.98	118.18	148199500	3.18	128.67	138.68
291	1	291	120.19	118.88	122.40	118.82	164560400	4.78	127.58	138.34
292	1	292	121.32	125.28	125.42	120.38	116307900	30.61	126.94	137.04
293	1	293	125.89	122.67	126.20	122.56	102260900	28.47	126.18	135.80
294	1	294	122.36	119.67	123.25	119.45	112966300	25.96	125.25	134.66
295	1	295	119.36	117.77	121.18	116.29	178155000	24.49	124.20	133.41
296	1	296	118.61	119.04	119.55	115.26	153766600	27.09	123.22	131.39
297	1	297	118.56	114.08	118.63	113.93	154376600	24.75	122.04	130.39
298	1	298	116.70	118.72	119.67	116.46	129525800	36.35	121.36	129.05
299	1	299	119.30	117.63	119.77	117.11	111943300	36.37	120.68	127.83
300	1	300	120.14	119.57	120.79	118.88	103026500	39.46	120.12	126.17
301	1	301	118.04	118.66	118.79	116.82	88105100	42.81	119.78	125.53
302	1	302	119.03	121.56	121.57	118.06	92403800	47.50	119.65	125.12
303	1	303	123.24	123.11	124.73	122.27	115227900	50.29	119.66	125.18
304	1	304	121.62	122.31	123.39	119.94	111932600	55.40	119.92	125.58
305	1	305	120.47	118.17	120.76	117.96	121229700	49.06	119.87	125.58
306	1	306	117.55	117.64	119.05	117.33	185549500	38.14	119.33	124.21
307	1	307	117.97	120.97	121.44	117.90	111912300	47.43	119.21	123.81
308	1	308	120.91	120.14	121.80	119.75	95467100	50.76	119.24	123.86
309	1	309	120.41	117.74	120.49	117.72	88530500	49.94	119.24	123.86
310	1	310	117.20	118.23	119.27	116.67	98844700	48.67	119.18	123.84
311	1	311	117.99	118.83	119.10	116.59	94071200	59.09	119.52	123.16
312	1	312	119.26	119.01	120.18	118.36	80819200	50.68	119.54	123.16
313	1	313	117.76	117.55	118.04	116.53	85671900	49.82	119.53	123.17
314	1	314	119.26	119.76	121.10	118.77	118323800	50.42	119.55	123.18
315	1	315	121.24	120.59	121.75	120.09	75089100	54.34	119.69	123.32
316	1	316	121.44	123.43	123.69	120.66	88651200	54.22	119.82	123.87
317	1	317	124.02	123.74	124.64	123.19	80171300	51.50	119.86	124.08
318	1	318	123.36	125.39	125.41	122.69	83466700	57.05	120.08	125.10
319	1	319	126.42	127.80	127.83	126.00	88844600	73.99	120.77	127.12
320	1	320	127.26	130.39	130.43	126.93	106686700	78.80	121.68	129.57
321	1	321	129.92	128.67	130.25	128.07	91420000	68.74	122.23	130.93
322	1	322	129.84	131.79	132.02	129.34	91266500	75.53	123.07	133.04
323	1	323	132.29	129.44	132.35	129.08	87222800	75.69	123.90	133.91
324	1	324	131.20	131.86	132.35	131.02	89347100	77.59	124.88	135.16
325	1	325	131.67	131.53	132.03	130.67	84922400	75.97	125.78	136.01
326	1	326	130.89	132.20	132.81	130.73	94264200	76.45	126.72	136.69
327	1	327	132.37	130.50	132.87	129.23	94812300	75.73	127.65	136.26
328	1	328	129.76	130.88	131.13	128.73	68847100	73.83	128.44	135.89
329	1	329	130.43	129.35	131.52	128.83	84566500	68.23	129.07	134.99
330	1	330	129.57	131.69	132.47	129.57	78657500	67.54	129.66	134.75
331	1	331	132.19	132.08	132.41	130.94	66905100	67.66	130.26	134.17
332	1	332	132.36	131.76	132.76	131.48	66015800	64.28	130.71	133.51
333	1	333	131.68	130.96	132.37	130.47	107760100	57.64	130.94	133.19
334	1	334	133.79	130.86	134.38	129.85	151101000	51.29	130.97	133.20
335	1	335	129.20	128.88	130.94	128.50	109839500	50.59	130.98	133.15
336	1	336	129.45	129.94	131.44	129.25	75135100	44.34	130.85	133.03
337	1	337	128.62	125.34	128.91	124.22	137564700	38.99	130.56	134.18
338	1	338	126.67	125.59	127.89	125.46	84000900	30.91	130.11	134.51
339	1	339	125.38	127.20	127.21	124.64	78128300	37.76	129.80	134.37
340	1	340	128.50	127.87	128.91	127.16	78973300	37.80	129.49	133.95
341	1	341	127.09	124.57	127.22	124.53	88071200	34.66	129.07	134.19
342	1	342	121.28	123.65	124.00	120.57	126142800	31.80	128.55	134.31
343	1	343	121.19	120.57	122.40	120.06	112172300	29.49	127.93	135.06
344	1	344	122.34	122.73	123.89	122.03	105861300	28.91	127.29	134.57
345	1	345	123.98	125.16	125.60	123.59	81918000	35.15	126.79	133.60
346	1	346	124.54	124.00	124.65	122.92	74244600	33.93	126.24	132.55
347	1	347	124.29	122.61	124.71	122.54	63342900	33.11	125.64	131.60
348	1	348	120.95	122.45	122.68	120.66	92612000	33.03	125.04	130.39
349	1	349	122.98	125.03	125.43	122.86	76857100	42.40	124.77	129.64
350	1	350	125.53	123.18	125.70	122.96	79295400	37.08	124.28	128.19
351	1	351	123.75	124.82	125.64	123.68	63092900	48.87	124.25	128.12
352	1	352	125.53	124.62	126.02	124.05	72009500	47.92	124.18	127.98
353	1	353	124.68	124.57	125.10	124.15	56575900	43.93	123.99	127.39
354	1	354	124.17	123.03	125.35	122.84	94625600	39.22	123.64	126.23
355	1	355	123.32	122.37	123.54	122.32	71311100	44.45	123.49	126.10
356	1	356	122.84	122.05	123.10	121.72	67637100	45.84	123.37	126.09
357	1	357	122.05	122.82	122.99	121.82	59278900	56.65	123.53	125.76
358	1	358	122.44	121.32	122.61	120.92	76229200	45.67	123.43	125.93
359	1	359	121.84	123.63	123.90	121.63	75169300	45.24	123.32	125.62
360	1	360	123.91	123.64	124.05	122.59	71057600	48.79	123.30	125.57
361	1	361	124.33	124.47	126.16	123.95	74403800	56.45	123.43	125.74
362	1	362	124.93	124.85	125.46	124.25	56877900	58.20	123.60	125.96
363	1	363	124.74	123.85	125.89	123.68	71186400	45.48	123.52	125.73
364	1	364	124.26	125.07	125.15	123.84	53522400	57.59	123.65	126.00
365	1	365	125.53	128.14	128.20	124.79	96906500	61.99	123.89	127.22
366	1	366	127.61	127.31	128.26	127.07	62746300	59.29	124.08	127.87
367	1	367	128.03	127.81	128.54	126.16	91815000	60.86	124.31	128.59
368	1	368	127.47	129.43	130.17	127.32	96721700	71.32	124.77	129.77
369	1	369	128.36	128.12	129.15	127.90	108953300	68.36	125.18	130.27
370	1	370	127.96	129.93	130.03	126.89	79663300	72.99	125.74	131.08
371	1	371	129.76	131.58	131.67	129.26	74783600	74.32	126.37	132.26
372	1	372	131.37	131.30	131.91	130.84	60214200	79.71	127.08	132.75
373	1	373	132.04	131.02	132.22	130.55	68711000	75.00	127.61	133.27
374	1	374	131.07	130.72	131.49	130.43	70783700	73.52	128.11	133.51
375	1	375	131.02	132.36	132.82	130.96	62111300	74.88	128.68	134.08
376	1	376	132.38	133.88	134.04	131.94	64556100	76.56	129.32	134.91
377	1	377	133.73	134.50	134.94	133.43	63261400	82.04	130.08	135.35
378	1	378	134.15	134.81	134.87	133.32	52485800	81.00	130.78	135.76
379	1	379	135.43	137.45	137.49	135.28	78852600	80.46	131.44	137.31
380	1	380	137.56	139.47	140.58	137.56	108181800	86.89	132.31	139.08
381	1	381	140.96	141.98	142.29	140.10	104911600	88.31	133.32	141.32
382	1	382	139.04	140.67	141.48	138.15	105575500	80.93	134.13	142.67
383	1	383	140.19	142.51	143.04	140.09	99890800	88.45	135.16	144.04
384	1	384	143.59	141.91	143.69	141.42	76299700	84.23	136.01	145.03
385	1	385	141.45	143.03	144.81	141.05	100827100	83.74	136.83	146.19
386	1	386	145.44	146.47	146.89	145.03	127050800	87.66	137.91	148.00
387	1	387	146.56	145.82	147.31	144.45	106820300	86.07	138.97	149.05
388	1	388	145.80	143.76	147.07	143.26	93251400	79.28	139.90	149.07
389	1	389	141.17	139.89	141.49	139.13	121434600	65.37	140.44	148.52
390	1	390	140.89	143.53	144.46	140.40	96350000	68.12	141.13	148.40
391	1	391	142.92	142.79	143.51	142.04	74993500	65.50	141.72	147.94
392	1	392	143.32	144.17	145.54	143.19	77338200	66.83	142.39	147.28
393	1	393	144.90	145.89	146.05	144.28	71447400	65.70	142.99	147.31
394	1	394	145.61	146.32	147.14	145.05	72434100	63.53	143.48	147.63
395	1	395	146.44	144.14	146.53	142.94	104818600	54.33	143.64	147.70
396	1	396	142.21	142.38	144.33	139.98	118931200	53.36	143.76	147.53
397	1	397	142.09	143.03	143.92	141.99	56699500	51.07	143.79	147.53
398	1	398	141.79	143.24	143.70	141.52	70440600	52.80	143.89	147.48
399	1	399	143.73	142.91	144.31	142.64	62880000	49.74	143.88	147.48
400	1	400	143.19	144.72	145.38	142.58	64786600	45.90	143.76	147.08
401	1	401	144.63	144.31	145.14	143.66	56368300	46.45	143.65	146.78
402	1	402	144.34	144.42	145.19	143.55	46397700	51.71	143.70	146.85
403	1	403	143.94	143.73	144.69	143.23	54126800	61.97	143.97	146.25
404	1	404	143.79	143.68	144.28	143.12	48908700	50.63	143.98	146.25
405	1	405	144.03	143.20	145.28	142.91	69023100	51.68	144.01	146.22
406	1	406	143.64	143.46	144.30	143.13	48493500	46.80	143.96	146.19
407	1	407	143.78	146.44	146.60	143.44	72282600	52.20	144.00	146.39
408	1	408	146.52	146.64	146.98	145.83	59375000	51.35	144.02	146.51
409	1	409	146.09	148.63	148.70	144.06	103296000	68.85	144.34	147.85
410	1	410	147.76	147.72	149.18	146.63	92229700	74.09	144.72	148.46
411	1	411	147.33	143.95	148.24	143.74	86326000	53.25	144.79	148.43
412	1	412	142.64	144.28	145.56	142.12	86960300	53.63	144.86	148.41
413	1	413	145.01	145.75	146.05	144.36	60549600	59.19	145.07	148.45
414	1	414	145.87	147.24	147.72	145.45	60131800	58.35	145.25	148.82
415	1	415	146.99	147.16	148.38	146.69	48606400	59.59	145.45	149.11
416	1	416	147.34	145.92	147.84	145.37	58991300	54.69	145.56	149.18
417	1	417	145.91	145.11	146.66	145.08	48597200	54.28	145.66	149.14
418	1	418	145.05	146.15	146.30	144.41	55802400	57.23	145.83	149.13
419	1	419	146.55	150.60	150.96	146.16	90956700	67.59	146.36	150.17
420	1	420	150.15	149.33	150.28	148.80	86453100	63.32	146.78	150.51
421	1	421	150.31	150.00	152.43	149.83	80313700	59.02	147.03	151.13
422	1	422	151.34	151.12	152.17	149.89	71115500	60.84	147.35	151.98
423	1	423	151.23	151.76	152.08	150.57	57808700	58.10	147.58	152.74
424	1	424	152.42	154.11	154.67	151.85	82278300	65.42	148.03	154.27
425	1	425	154.39	152.56	154.45	151.44	74420200	73.23	148.65	154.85
426	1	426	152.93	151.53	153.54	151.41	57305700	68.87	149.17	154.99
427	1	427	152.45	146.52	152.92	146.25	140893200	51.69	149.22	154.92
428	1	428	148.15	147.09	148.93	146.30	102404300	49.64	149.21	154.93
429	1	429	147.87	145.68	148.58	144.49	109296300	46.81	149.10	155.04
430	1	430	146.11	146.58	146.98	143.96	83281300	51.44	149.15	154.98
431	1	431	146.00	146.34	146.52	144.80	68034100	52.76	149.24	154.84
432	1	432	146.37	143.65	146.37	143.36	129868800	44.77	149.06	155.22
433	1	433	141.43	140.59	142.45	138.94	123478900	27.75	148.35	155.90
434	1	434	141.56	141.07	142.22	140.43	75834000	30.98	147.76	156.22
435	1	435	142.07	143.45	144.02	141.33	76404300	36.02	147.29	155.94
436	1	436	144.23	144.41	144.66	143.24	64838200	35.59	146.81	155.29
437	1	437	143.26	144.50	145.04	143.16	53477900	34.03	146.29	154.34
438	1	438	143.07	142.98	143.56	141.45	74150700	24.57	145.50	152.32
439	1	439	140.89	139.57	142.37	139.36	108972300	22.66	144.57	150.76
440	1	440	140.12	140.48	142.07	139.69	74602000	26.60	143.78	148.87
441	1	441	141.29	139.17	142.00	138.95	89056700	31.56	143.25	148.64
442	1	442	139.56	140.30	140.57	136.82	94639600	33.43	142.77	147.88
443	1	443	139.43	136.85	139.87	135.99	98322000	30.39	142.14	147.85
444	1	444	137.19	138.79	139.90	137.06	80861100	33.47	141.58	146.93
445	1	445	137.17	139.66	139.81	136.09	83221100	36.20	141.10	145.78
446	1	446	140.70	140.93	141.84	140.37	61732700	44.02	140.91	145.34
447	1	447	141.66	140.55	141.81	140.21	58773200	49.90	140.91	145.34
448	1	448	139.93	140.46	142.43	139.47	64452200	48.45	140.86	145.30
449	1	449	140.87	139.18	140.89	138.72	73035900	38.53	140.56	144.82
450	1	450	138.91	138.59	139.07	136.91	78762700	34.03	140.14	143.89
451	1	451	139.77	141.39	141.51	139.18	69907100	42.58	139.92	142.83
452	1	452	141.40	142.45	142.51	141.15	67940300	48.73	139.88	142.63
453	1	453	141.09	144.14	144.42	140.80	85589200	62.16	140.21	143.76
454	1	454	144.59	146.31	146.71	144.14	76378900	64.56	140.63	145.45
455	1	455	146.25	146.80	147.28	145.68	58418800	69.86	141.17	146.93
456	1	456	146.36	147.02	147.18	145.43	61421000	68.35	141.65	148.16
457	1	457	147.22	146.24	147.71	146.19	58883400	80.05	142.32	148.63
458	1	458	146.23	146.19	146.91	145.19	50720600	76.95	142.85	149.13
459	1	459	146.87	146.86	148.36	146.56	60893400	76.60	143.36	149.70
460	1	460	146.90	146.40	147.26	146.04	56094900	71.48	143.76	150.11
461	1	461	147.35	150.06	150.65	147.25	100077900	79.72	144.43	151.33
462	1	462	144.80	147.33	147.47	144.00	124953200	68.44	144.93	151.57
463	1	463	146.54	146.51	147.23	145.37	74588300	70.15	145.45	151.25
464	1	464	146.21	147.55	149.07	146.20	69122000	74.04	146.09	150.42
465	1	465	147.91	149.00	149.47	147.35	54511500	72.00	146.63	150.27
466	1	466	149.08	148.47	149.92	148.16	60394600	67.98	147.06	149.91
467	1	467	149.61	149.01	149.91	147.80	65463900	65.62	147.41	149.89
468	1	468	149.13	148.18	149.29	147.90	55020900	56.56	147.54	149.97
469	1	469	147.94	148.54	149.15	147.80	56787900	56.17	147.67	150.11
470	1	470	147.76	145.70	147.87	145.63	65187100	46.05	147.57	150.21
471	1	471	146.72	145.65	147.18	145.46	41000000	48.15	147.53	150.28
472	1	472	146.20	147.74	148.14	145.26	63804000	54.27	147.64	150.28
473	1	473	148.11	147.74	149.60	147.18	59222800	52.54	147.70	150.31
474	1	474	147.69	148.73	149.21	147.09	59256200	56.50	147.87	150.41
475	1	475	148.73	151.18	152.67	148.72	88807000	53.37	147.95	150.84
476	1	476	151.40	155.50	156.28	150.75	137827700	72.30	148.53	153.46
477	1	477	155.28	158.14	158.60	154.18	117305600	78.90	149.37	156.32
478	1	478	159.25	158.60	163.21	158.58	117467900	78.28	150.15	158.58
479	1	479	158.70	158.98	159.37	156.67	96041900	77.03	150.87	160.48
480	1	480	158.33	159.51	159.70	157.24	69463600	79.85	151.66	162.18
481	1	481	157.17	154.45	158.04	154.01	76959800	61.84	152.04	162.55
482	1	482	156.97	157.83	158.77	156.40	88748200	68.89	152.73	163.41
483	1	483	157.58	162.81	163.03	157.52	174048100	73.65	153.75	165.39
484	1	484	164.96	162.29	167.74	162.06	152052500	79.80	154.94	166.42
485	1	485	156.35	161.30	161.73	155.43	136739200	77.18	156.06	166.66
486	1	486	161.55	159.41	162.48	157.32	118023100	70.41	156.89	166.46
487	1	487	161.82	162.83	165.36	161.81	107497000	73.57	157.97	166.43
488	1	488	166.54	168.61	169.00	165.81	120405400	77.01	159.39	167.84
489	1	489	169.54	172.45	173.31	168.13	116998900	77.84	160.91	170.57
490	1	490	172.28	171.94	174.09	171.31	108923700	73.90	162.08	172.84
491	1	491	172.58	176.75	176.93	172.06	115402700	75.46	163.41	176.43
492	1	492	178.40	173.10	179.39	172.89	153237000	68.24	164.45	178.11
493	1	493	172.62	171.71	175.07	169.62	139380400	65.61	165.36	179.15
494	1	494	172.48	176.60	176.80	169.72	131063300	68.94	166.58	181.14
495	1	495	176.58	169.67	178.42	168.18	150185800	66.18	167.66	180.50
496	1	496	167.38	168.57	170.86	167.14	195432700	62.00	168.43	179.95
497	1	497	165.75	167.20	168.02	164.94	107499100	55.33	168.74	179.84
498	1	498	168.98	170.39	170.60	166.58	91185900	59.24	169.32	179.80
499	1	499	170.44	173.00	173.22	169.56	92135300	62.89	170.16	179.70
500	1	500	173.21	173.63	174.19	172.63	68356600	66.11	171.17	178.57
501	1	501	174.43	177.62	177.71	174.41	74919600	66.53	172.23	178.65
502	1	502	177.45	176.59	178.60	175.85	79144300	60.00	172.80	179.26
503	1	503	176.63	176.68	177.91	175.46	62348900	55.85	173.10	179.88
504	1	504	176.77	175.52	177.86	175.41	59773000	54.86	173.36	180.21
505	1	505	175.41	174.90	176.54	174.60	64062300	47.17	173.23	179.87
506	1	506	175.16	179.27	180.13	175.04	104487900	59.25	173.67	181.05
507	1	507	179.88	177.00	180.19	176.43	99310400	57.72	174.05	181.54
508	1	508	176.91	172.29	177.46	172.01	94537600	43.67	173.74	181.13
509	1	509	170.10	169.41	172.66	169.06	96904000	49.57	173.72	181.16
510	1	510	170.29	169.58	171.52	168.46	86709100	51.74	173.79	181.03
511	1	511	166.54	169.60	169.91	165.64	106765600	54.33	173.96	180.62
512	1	512	169.73	172.45	172.55	168.25	76138300	53.76	174.11	180.51
513	1	513	173.47	172.89	174.52	172.19	74805200	49.79	174.10	180.51
514	1	514	173.14	169.60	173.96	169.21	84505800	42.78	173.82	180.66
515	1	515	168.76	170.47	171.17	168.52	80440800	35.56	173.30	179.99
516	1	516	168.93	167.25	169.95	166.86	90956700	32.66	172.64	179.76
517	1	517	167.44	163.73	168.51	163.45	94815000	28.69	171.71	179.86
518	1	518	164.47	162.04	167.13	161.71	91420500	28.19	170.75	180.07
519	1	519	161.95	159.97	163.83	159.86	122848900	26.93	169.68	180.28
520	1	520	157.61	159.19	159.86	152.37	162294600	15.10	168.25	178.69
521	1	521	156.59	157.38	160.31	154.66	115798400	15.34	166.85	177.49
522	1	522	161.04	157.29	161.92	155.45	108275300	18.34	165.77	177.06
523	1	523	160.01	156.83	161.38	155.90	121954600	20.42	164.88	176.90
524	1	524	163.22	167.77	167.79	160.35	179935700	47.17	164.75	176.59
525	1	525	167.60	172.15	172.37	166.96	115541600	53.50	164.93	177.16
526	1	526	171.39	171.98	172.21	169.72	86213900	49.31	164.90	177.04
527	1	527	172.12	173.20	173.24	170.72	84914300	50.44	164.92	177.13
528	1	528	171.86	170.30	173.59	169.53	89418100	51.03	164.97	177.27
529	1	529	169.31	170.01	171.70	168.33	82465400	49.32	164.93	177.17
530	1	530	170.48	169.29	171.55	168.59	77251200	53.30	165.08	177.49
531	1	531	169.36	172.42	172.93	169.07	74829200	64.18	165.70	178.67
532	1	532	173.62	173.85	174.22	172.49	71285000	69.45	166.55	180.02
533	1	533	171.74	169.75	173.06	169.19	90865900	65.09	167.24	180.25
534	1	534	169.96	166.32	170.70	165.72	98670700	60.16	167.75	179.94
535	1	535	165.06	166.55	167.24	164.26	86185500	63.70	168.41	179.08
536	1	536	168.61	170.41	170.57	167.90	62527400	67.61	169.35	177.91
537	1	537	169.48	170.17	170.95	167.71	61177400	68.02	170.30	174.92
538	1	538	168.67	166.55	169.54	166.15	69589300	47.95	170.21	175.08
539	1	539	167.48	164.99	168.19	163.90	82772700	36.69	169.70	175.16
540	1	540	162.71	162.06	164.39	159.92	91162800	33.26	168.99	175.63
541	1	541	163.26	157.86	163.86	157.55	90009200	26.51	167.90	176.35
542	1	542	150.48	160.50	160.61	149.91	141147500	34.86	167.20	176.39
543	1	543	161.58	162.58	162.84	158.65	91974200	39.12	166.66	176.01
544	1	544	160.81	162.84	163.14	160.19	95056600	40.43	166.20	175.63
545	1	545	162.43	160.95	164.30	159.74	83474400	32.34	165.38	174.47
546	1	546	162.12	164.26	165.05	160.70	79724800	36.05	164.70	172.37
547	1	547	166.15	163.94	166.58	163.27	76678400	40.50	164.29	171.39
548	1	548	162.22	160.92	163.27	159.87	83737200	41.06	163.90	171.11
549	1	549	161.11	157.10	162.75	156.85	96418800	36.00	163.23	171.10
550	1	550	156.63	155.27	160.64	153.65	131148300	26.14	162.14	169.93
551	1	551	159.25	160.70	161.16	157.21	91454900	37.18	161.47	167.75
552	1	552	157.99	156.34	158.18	153.83	105342000	36.44	160.74	166.85
553	1	553	156.74	152.60	157.09	152.37	96970100	34.45	159.85	166.83
554	1	554	149.36	148.54	152.00	148.03	108732100	33.51	158.89	167.97
555	1	555	148.82	152.95	153.43	148.31	92964300	44.04	158.54	168.16
556	1	556	154.89	157.39	157.80	152.33	102300200	46.39	158.31	167.88
557	1	557	156.42	158.41	158.78	155.46	75615400	45.02	158.02	167.27
558	1	558	158.30	161.72	162.21	157.56	123511700	48.75	157.94	167.03
559	1	559	161.26	163.10	164.06	160.76	95811400	52.42	158.09	167.47
560	1	560	163.23	166.49	167.09	162.64	81532000	52.50	158.25	168.14
561	1	561	165.68	167.86	170.26	165.34	98062700	54.31	158.53	169.30
562	1	562	168.70	171.67	171.74	167.86	90131400	61.59	159.30	172.13
563	1	563	171.48	172.31	172.86	170.37	80546200	67.60	160.38	174.89
564	1	564	169.80	173.18	173.31	169.63	90371900	71.20	161.66	177.34
565	1	565	174.26	176.49	176.54	173.91	100589400	69.68	162.79	180.33
566	1	566	176.09	175.32	177.14	174.27	92633200	75.71	164.15	182.45
567	1	567	175.39	172.20	175.58	172.00	103049300	77.01	165.55	183.03
568	1	568	171.63	171.91	172.47	169.57	78751300	85.90	167.22	181.95
569	1	569	172.16	175.98	176.03	172.04	76468400	85.76	168.86	181.77
570	1	570	175.05	172.65	175.84	172.02	73401800	74.53	169.95	181.15
571	1	571	169.99	169.46	171.24	167.79	89058800	66.62	170.74	179.78
572	1	572	168.80	169.77	170.97	167.51	77594700	63.30	171.31	178.77
573	1	573	169.41	167.75	169.41	166.87	76575500	57.52	171.65	177.83
574	1	574	166.39	163.47	166.70	163.22	72246700	45.24	171.43	178.54
575	1	575	165.70	165.35	167.53	164.34	79265200	46.11	171.25	178.85
576	1	576	165.08	168.05	168.68	164.47	70618900	44.20	170.99	178.78
577	1	577	168.27	163.01	168.91	162.77	75329400	36.94	170.33	179.15
578	1	578	161.66	162.80	164.30	161.32	69023900	35.14	169.59	179.09
579	1	579	162.75	165.09	165.51	161.65	67723800	33.20	168.77	177.66
580	1	580	166.43	164.93	166.55	163.81	67929800	34.21	168.03	176.28
581	1	581	166.58	164.13	169.17	163.62	87227800	36.80	167.45	175.57
582	1	582	164.17	159.56	165.56	159.27	84882400	32.30	166.57	175.27
583	1	583	158.90	160.64	160.92	156.28	96046400	25.93	165.47	172.82
584	1	584	160.01	154.64	160.10	154.56	95623200	23.93	164.19	172.38
585	1	585	153.76	154.41	157.59	153.24	88063200	26.17	163.11	172.23
586	1	586	157.06	161.39	162.25	156.74	130216800	39.04	162.51	170.81
587	1	587	159.61	155.48	163.91	155.08	131747600	35.44	161.64	170.14
588	1	588	154.55	155.78	156.05	151.16	123055300	39.93	161.09	170.06
589	1	589	155.97	157.28	158.50	154.17	88966500	39.32	160.51	169.34
590	1	590	157.47	163.73	164.19	157.07	108256500	44.80	160.20	168.16
591	1	591	161.59	154.61	161.82	152.81	130525300	40.79	159.60	167.90
592	1	592	154.09	155.34	157.47	152.28	116124600	41.92	159.07	167.45
593	1	593	153.02	150.19	153.91	149.62	131577900	34.78	158.01	166.86
594	1	594	153.60	152.60	154.81	151.04	115366700	37.97	157.13	165.45
595	1	595	151.61	144.69	153.53	144.01	142689800	33.34	155.74	165.41
596	1	596	141.01	140.80	144.40	137.09	182602000	33.73	154.40	166.64
597	1	597	142.81	145.30	146.27	141.35	113990900	37.44	153.30	165.88
598	1	598	143.76	143.75	145.70	142.40	86643800	40.38	152.53	166.06
599	1	599	147.02	147.40	147.92	144.87	78336300	44.16	152.02	165.78
600	1	600	145.04	139.08	145.54	138.17	109742900	31.84	150.43	164.67
601	1	601	138.16	135.66	139.91	134.92	136095600	33.18	149.02	164.94
602	1	602	137.37	135.89	138.97	130.97	137426100	33.10	147.59	164.44
603	1	603	136.09	141.35	141.49	135.95	117726300	37.31	146.46	162.62
604	1	604	139.07	138.63	140.22	135.64	104132700	28.75	144.66	157.87
605	1	605	136.72	138.79	140.04	136.63	92482700	34.21	143.53	155.74
606	1	606	135.70	142.01	142.56	135.45	90601500	37.33	142.58	152.73
607	1	607	143.60	147.79	147.83	143.47	90978500	47.76	142.41	152.08
608	1	608	147.23	147.00	148.80	145.03	103718400	44.57	142.01	150.21
609	1	609	148.05	146.88	149.87	145.86	74286600	52.49	142.17	150.66
610	1	610	146.01	149.35	149.40	145.05	72348100	60.07	142.78	152.04
611	1	611	145.09	143.59	146.15	142.68	88570300	48.04	142.65	151.82
612	1	612	145.22	144.34	146.74	143.11	71598400	50.69	142.70	151.89
613	1	613	142.57	146.88	147.16	142.32	67808200	49.37	142.66	151.78
614	1	614	146.75	146.14	148.02	145.64	53950200	60.32	143.16	152.21
615	1	615	145.27	140.88	146.13	140.77	69473000	57.26	143.54	151.63
616	1	616	138.55	135.44	139.02	135.37	91437900	49.45	143.50	151.73
617	1	617	131.23	130.25	133.53	129.82	122207100	36.45	142.71	153.55
618	1	618	131.49	131.12	132.24	129.86	84784300	40.40	142.18	154.53
619	1	619	132.63	133.76	135.65	130.53	91533000	43.95	141.82	154.86
620	1	620	130.45	128.46	130.76	127.45	108123900	34.48	140.85	155.72
621	1	621	128.47	129.94	131.44	128.21	134520300	27.31	139.57	154.93
622	1	622	131.77	134.19	135.37	131.68	81000500	35.04	138.66	153.63
623	1	623	133.13	133.68	136.06	132.26	73409200	34.73	137.72	152.11
624	1	624	135.13	136.57	136.88	133.96	72433800	35.35	136.80	149.54
625	1	625	138.17	139.91	140.16	138.05	89116800	45.54	136.54	148.82
626	1	626	140.94	139.91	141.72	139.23	70207900	44.53	136.22	147.85
627	1	627	140.38	135.75	141.65	135.63	67083400	36.78	135.43	145.31
628	1	628	135.77	137.51	138.94	134.98	66242400	40.00	134.81	142.69
629	1	629	135.56	135.03	136.66	132.12	98964500	42.75	134.40	141.47
630	1	630	134.36	137.22	137.33	133.99	71051600	52.40	134.52	141.74
631	1	631	136.07	139.81	139.86	135.24	73353800	63.86	135.20	142.49
632	1	632	139.61	141.16	142.34	139.34	74064300	64.35	135.92	143.45
633	1	633	141.52	144.55	144.74	141.51	66253700	65.10	136.69	145.38
634	1	634	143.47	145.23	145.73	143.21	64547800	76.97	137.89	146.31
635	1	635	143.87	143.08	144.83	142.01	63141600	70.70	138.83	146.31
636	1	636	143.96	144.06	146.62	143.26	77588800	67.33	139.53	146.99
637	1	637	141.23	143.70	144.64	140.37	71185600	67.68	140.25	147.19
638	1	638	142.30	146.64	147.11	141.48	78140700	67.75	140.97	148.34
639	1	639	147.93	148.32	149.00	146.37	76259900	65.73	141.57	149.88
640	1	640	148.88	145.26	149.70	144.89	81420900	58.97	141.95	150.42
641	1	641	146.10	149.14	149.37	145.10	82982400	72.71	142.91	151.39
642	1	642	149.26	151.15	151.82	148.52	64823400	72.93	143.88	152.81
643	1	643	152.59	153.43	153.65	150.07	65086600	81.14	145.20	153.93
644	1	644	153.47	152.19	154.35	151.52	66675400	76.17	146.27	154.44
645	1	645	152.11	151.06	153.13	150.40	53623900	70.73	147.07	154.71
646	1	646	150.38	149.73	151.20	148.94	55138700	65.80	147.68	154.62
647	1	647	150.70	154.86	155.39	150.28	78620700	67.86	148.42	156.08
648	1	648	155.04	155.41	155.70	152.51	81378700	67.72	149.15	157.41
649	1	649	159.25	160.51	161.61	157.53	101786900	77.49	150.39	159.88
650	1	650	159.02	159.52	161.57	158.91	67829400	74.38	151.49	161.40
651	1	651	158.13	158.04	160.41	157.66	59907000	71.85	152.52	161.90
652	1	652	158.86	164.08	164.54	158.77	82507500	74.28	153.76	164.34
653	1	653	163.96	163.77	165.13	162.40	55474100	72.36	154.87	166.19
654	1	654	161.42	163.54	164.03	161.21	56697000	78.82	156.17	166.93
655	1	655	164.55	163.06	165.97	162.40	60276900	74.60	157.17	167.69
656	1	656	162.22	163.11	164.00	161.46	63135500	72.70	158.02	168.38
657	1	657	165.84	167.39	167.48	165.07	70170500	74.62	159.02	170.14
658	1	658	168.20	166.64	169.12	166.35	57149200	75.97	160.05	171.12
659	1	659	167.96	170.21	170.28	167.54	68039400	81.63	161.42	172.44
660	1	660	169.64	171.29	171.49	169.47	54091700	85.91	162.96	172.92
661	1	661	170.89	171.13	171.81	169.78	56377100	82.49	164.12	173.80
662	1	662	170.88	172.64	174.22	170.68	79542000	83.13	165.35	174.63
663	1	663	171.85	172.24	172.98	171.22	62290100	77.55	166.19	175.70
664	1	664	171.13	169.64	171.84	169.43	70346300	72.09	166.91	175.76
665	1	665	167.83	165.73	168.00	165.31	69026800	65.19	167.46	174.75
666	1	666	165.25	165.40	166.86	164.82	54147100	53.35	167.56	174.69
667	1	667	165.49	165.69	166.27	164.43	53841500	54.92	167.69	174.58
668	1	668	166.93	168.17	168.28	166.51	51218200	60.59	168.03	174.48
669	1	669	168.70	161.83	169.18	161.77	78961000	47.77	167.94	174.71
670	1	670	159.38	159.61	161.11	158.07	73314000	44.14	167.69	175.42
671	1	671	160.35	157.17	160.78	155.99	77906200	31.79	166.96	176.52
672	1	672	158.55	155.50	158.82	155.42	87991100	30.77	166.16	177.53
673	1	673	154.92	156.23	156.68	152.98	74229900	23.26	165.16	177.42
674	1	674	158.00	154.10	158.60	153.27	76957800	18.40	163.93	176.96
675	1	675	154.76	152.84	155.37	152.01	73714800	17.68	162.63	176.20
676	1	676	153.12	154.25	154.95	151.93	87449600	17.42	161.31	174.26
677	1	677	152.95	152.77	154.65	151.01	84923800	16.77	159.92	171.97
678	1	678	153.77	155.65	156.09	153.05	68028800	26.35	158.92	169.76
679	1	679	157.84	161.64	162.46	157.55	104956000	43.54	158.63	168.88
680	1	680	158.15	152.15	158.78	151.69	122656600	33.78	157.69	167.68
681	1	681	153.09	153.61	155.38	151.93	87965400	35.60	156.82	165.88
682	1	682	152.96	150.70	153.54	149.72	90481100	29.41	155.57	162.45
683	1	683	149.55	149.05	149.69	146.74	162278800	33.06	154.66	161.35
684	1	684	147.67	152.79	152.87	147.47	81474200	41.31	154.17	160.28
685	1	685	151.72	155.18	156.35	151.40	107689800	47.46	154.03	159.93
686	1	686	155.62	152.04	157.00	151.92	101696800	45.74	153.78	159.71
687	1	687	150.71	151.07	152.78	149.26	86652500	43.69	153.42	159.33
688	1	688	149.53	148.78	149.81	146.93	96029900	43.52	153.04	159.42
689	1	689	148.02	149.12	152.08	148.00	93339400	45.37	152.77	159.49
690	1	690	151.07	150.10	153.02	148.31	84442700	44.77	152.47	159.28
691	1	691	146.02	148.20	148.99	143.25	146691400	44.30	152.15	159.32
692	1	692	144.50	140.92	145.11	139.14	128138200	33.46	151.10	160.14
693	1	693	139.73	136.69	141.53	136.49	124925300	20.82	149.31	159.20
694	1	694	136.70	140.89	141.50	136.18	114311700	34.97	148.51	159.20
695	1	695	143.44	144.50	144.62	142.68	87830100	38.51	147.86	158.32
696	1	696	142.49	144.80	145.76	141.44	79471000	42.03	147.44	157.88
697	1	697	144.21	143.84	145.92	143.63	68402200	42.83	147.06	157.63
698	1	698	140.98	138.55	141.53	137.92	85925600	31.21	146.05	156.97
699	1	699	138.88	138.88	140.34	137.05	74899000	27.24	144.88	155.06
700	1	700	138.37	137.46	139.80	136.71	77033700	28.61	143.84	153.85
701	1	701	137.61	136.82	138.82	136.65	70433700	28.90	142.82	152.56
702	1	702	133.51	141.42	142.02	132.90	113224000	39.80	142.30	151.43
703	1	703	142.73	136.86	142.94	136.68	88598000	34.79	141.42	150.07
704	1	704	139.52	140.85	141.33	138.73	85250900	39.32	140.76	147.83
705	1	705	143.90	142.17	145.09	139.07	99136600	42.95	140.33	146.05
706	1	706	140.14	142.28	143.36	139.95	61758300	51.92	140.43	146.24
707	1	707	141.45	141.82	144.29	141.09	64522000	58.08	140.80	146.22
708	1	708	141.30	145.66	146.23	141.09	86548600	57.59	141.14	147.15
709	1	709	145.58	147.81	148.58	144.40	75981900	55.53	141.37	148.17
710	1	710	148.45	150.67	150.82	147.72	74732300	59.03	141.79	150.06
711	1	711	149.31	147.71	150.32	146.42	88194300	55.62	142.07	150.88
712	1	712	146.45	143.21	147.42	142.55	109180200	56.90	142.40	150.99
713	1	713	146.58	154.03	155.77	146.20	164762400	67.13	143.49	153.80
714	1	714	151.48	151.66	152.55	150.26	97943200	65.72	144.50	155.05
715	1	715	153.38	149.00	153.75	147.50	80379300	62.90	145.37	155.18
716	1	716	147.32	143.44	150.50	143.41	93604600	52.09	145.51	155.13
717	1	717	140.50	137.36	141.24	137.23	97918500	50.50	145.55	155.03
718	1	718	140.77	137.09	141.34	133.13	140814800	45.91	145.28	155.52
719	1	719	135.83	137.63	137.85	134.41	83374600	44.97	144.96	155.89
720	1	720	139.10	138.20	140.11	136.21	89908500	45.53	144.66	156.11
721	1	721	137.21	133.61	137.26	133.34	74917800	41.76	144.08	156.90
722	1	722	139.92	145.50	145.50	138.20	118854000	49.87	144.07	156.89
723	1	723	144.46	148.31	148.61	143.02	93979700	50.42	144.10	156.97
724	1	724	147.58	146.90	148.88	146.06	73374100	46.69	143.83	156.26
725	1	725	150.80	148.64	152.16	147.18	89868300	50.83	143.90	156.42
726	1	726	147.74	147.40	148.47	145.92	64218300	53.99	144.20	156.85
727	1	727	145.07	149.32	150.07	144.79	80389400	44.59	143.86	155.61
728	1	728	150.89	149.88	151.28	148.57	74829600	47.87	143.73	155.15
729	1	729	148.76	146.63	148.97	146.34	58724100	47.21	143.56	154.71
730	1	730	146.75	148.78	149.02	145.56	51804100	56.85	143.95	155.43
731	1	731	148.06	149.66	150.42	147.95	58301400	68.20	144.83	156.02
732	1	732	146.93	146.73	147.49	145.75	35195900	63.22	145.51	155.81
733	1	733	143.79	142.88	145.27	142.04	69246000	56.60	145.89	155.29
734	1	734	142.95	139.85	143.46	139.04	83763800	51.96	146.01	155.03
735	1	735	140.08	146.65	147.33	139.24	111380900	64.67	146.94	152.46
736	1	736	146.83	146.93	147.74	145.24	71250400	52.17	147.04	152.50
737	1	737	144.60	146.43	146.62	144.29	65447400	46.93	146.91	152.32
738	1	738	146.39	145.26	149.51	144.41	68826400	47.30	146.79	152.28
739	1	739	145.70	141.58	145.93	140.60	64727200	39.04	146.28	152.31
740	1	740	140.87	139.63	142.03	138.70	69721100	38.20	145.73	152.68
741	1	741	141.03	141.32	142.18	139.79	62128300	37.78	145.16	152.15
742	1	742	141.01	140.84	144.21	139.59	76097000	36.15	144.51	151.29
743	1	743	141.37	143.14	143.15	139.75	70462700	44.50	144.26	150.96
744	1	744	148.11	144.11	148.57	142.90	93886200	42.36	143.93	150.11
745	1	745	144.00	141.88	145.29	139.84	82291200	37.79	143.37	148.66
746	1	746	139.80	135.23	140.48	134.76	98931900	33.84	142.55	149.04
747	1	747	135.42	133.26	136.37	132.48	160156900	35.73	141.86	150.02
748	1	748	133.85	131.14	133.94	130.10	79592600	36.71	141.24	151.19
749	1	749	130.17	131.07	132.01	128.68	77432800	20.13	140.13	150.93
750	1	750	131.74	134.19	135.54	131.51	85928000	27.98	139.22	149.69
751	1	751	133.10	131.00	133.31	129.09	77852100	25.60	138.12	148.57
752	1	752	129.70	130.63	131.19	128.43	63814900	26.26	137.07	147.37
753	1	753	130.16	128.82	130.19	127.52	69007800	27.96	136.16	146.98
754	1	754	128.46	124.87	129.81	124.70	85438400	26.15	135.11	147.27
755	1	755	126.80	128.40	129.26	126.54	75703700	30.30	134.18	146.27
756	1	756	127.21	128.72	128.74	126.24	77034200	31.43	133.32	145.09
757	1	757	129.07	123.90	129.68	123.01	112117500	22.62	131.94	143.25
758	1	758	125.71	125.18	127.46	123.91	89113600	23.29	130.59	140.00
759	1	759	125.95	123.86	126.58	123.60	80962700	23.90	129.30	136.80
760	1	760	124.84	128.41	129.08	123.73	87754700	39.49	128.82	135.50
761	1	761	129.25	128.94	132.17	128.68	70790800	43.03	128.51	134.68
762	1	762	129.05	129.51	130.04	126.93	63896200	47.24	128.39	134.41
763	1	763	130.03	132.25	132.27	129.24	69458900	51.84	128.48	134.69
764	1	764	132.63	132.17	133.01	130.22	71379600	46.52	128.33	134.05
765	1	765	130.80	133.50	133.66	130.43	57809700	54.61	128.51	134.72
766	1	766	133.57	134.67	136.01	132.88	63646600	57.21	128.80	135.77
767	1	767	135.55	133.95	137.32	133.77	69672800	59.53	129.17	136.66
768	1	768	132.83	134.01	134.98	132.52	58280400	69.85	129.82	137.29
769	1	769	134.02	136.59	136.73	132.97	80223600	68.54	130.40	138.64
770	1	770	136.83	139.80	141.98	136.62	81760300	72.18	131.20	140.75
771	1	771	139.00	141.20	141.83	138.99	66435100	90.12	132.43	142.39
772	1	772	139.58	140.54	141.10	137.52	65799300	86.66	133.53	143.43
773	1	773	141.84	142.62	142.91	140.58	54105100	93.24	134.87	144.20
774	1	774	141.83	144.57	145.86	141.75	70555800	92.32	136.02	145.89
775	1	775	143.61	141.67	144.19	141.52	64015300	79.65	136.93	146.32
776	1	776	141.37	142.95	143.00	140.95	65874500	80.29	137.89	146.75
777	1	777	142.63	144.07	145.24	140.00	77663600	78.76	138.74	147.53
778	1	778	147.51	149.41	149.77	146.79	118339000	83.39	139.97	149.59
779	1	779	146.65	153.06	155.91	146.45	154357300	84.75	141.36	152.50
780	1	780	151.15	150.32	151.67	149.38	69858300	76.33	142.48	153.87
781	1	781	149.24	153.21	153.78	149.24	83322600	80.21	143.86	155.45
782	1	782	152.45	150.50	153.14	149.76	64120100	73.89	145.04	155.63
783	1	783	152.35	149.46	152.89	149.02	56007100	69.52	145.96	155.58
784	1	784	148.29	149.83	150.16	148.06	57450700	66.65	146.67	155.80
785	1	785	149.77	152.65	153.06	149.74	62199000	68.14	147.49	156.56
786	1	786	150.93	152.00	152.57	149.68	61707600	68.18	148.31	156.72
787	1	787	151.91	154.12	154.29	151.69	65573800	68.21	149.13	157.39
788	1	788	152.31	152.51	155.11	152.15	68167900	62.71	149.70	157.70
789	1	789	151.16	151.36	151.81	149.67	59144100	66.44	150.39	156.94
790	1	790	149.03	147.32	150.12	147.25	58867200	56.79	150.70	156.03
791	1	791	147.71	147.75	148.78	146.01	51011300	55.82	150.96	155.12
792	1	792	148.92	148.23	149.17	146.09	48394200	47.79	150.88	155.21
793	1	793	145.96	145.56	146.04	144.58	55469600	35.42	150.35	155.32
794	1	794	146.56	146.77	148.01	146.30	44998500	42.65	150.09	155.42
795	1	795	145.90	146.26	147.92	145.68	50547000	34.04	149.60	154.97
796	1	796	145.68	144.18	146.08	143.88	55479000	35.04	149.14	155.21
797	1	797	143.25	144.77	145.56	142.78	52238100	38.67	148.81	155.30
798	1	798	146.88	149.85	149.93	146.18	70732300	50.04	148.81	155.30
799	1	799	152.59	152.63	155.08	152.26	87558000	49.96	148.81	155.30
800	1	800	152.50	150.42	152.83	149.95	56182000	47.05	148.69	155.00
801	1	801	151.62	151.68	152.27	150.64	47204800	45.32	148.52	154.29
802	1	802	152.36	149.41	153.33	149.06	53833600	44.21	148.30	153.63
803	1	803	149.04	147.34	149.76	146.46	68572400	42.74	148.01	153.06
804	1	804	146.66	149.30	151.94	146.55	84457100	53.86	148.15	153.23
805	1	805	150.10	151.40	152.20	148.93	73695900	56.70	148.41	153.77
806	1	806	150.01	151.80	152.05	148.75	77167900	56.55	148.67	154.31
807	1	807	150.97	154.63	155.24	150.46	76161100	66.58	149.32	155.48
808	1	808	154.86	153.79	155.52	153.08	98944600	63.01	149.82	156.23
809	1	809	153.86	156.17	156.59	152.95	73641400	67.17	150.53	157.42
810	1	810	156.09	158.04	158.16	155.32	73938300	74.19	151.52	158.46
811	1	811	158.06	156.60	160.87	156.58	75701800	70.05	152.36	158.61
812	1	812	157.59	157.69	160.29	156.45	67622100	65.37	152.92	159.59
813	1	813	157.62	159.00	159.09	156.62	59196500	63.25	153.38	160.79
814	1	814	158.69	157.04	159.52	156.64	52390300	63.94	153.85	161.30
815	1	815	156.74	156.42	157.25	154.76	45992200	60.25	154.19	161.64
816	1	816	158.13	159.52	159.79	158.11	51305700	71.07	154.91	162.33
817	1	817	160.27	161.09	161.20	160.01	49501700	79.29	155.89	162.60
818	1	818	161.17	163.61	163.71	160.65	68749800	79.78	156.91	163.66
819	1	819	162.99	164.87	164.99	162.94	56976200	79.04	157.88	165.06
820	1	820	165.30	164.34	165.54	163.82	46278300	76.87	158.77	165.82
821	1	821	163.45	162.48	163.76	160.54	51511700	67.55	159.33	166.21
822	1	822	161.16	163.37	163.67	160.74	45390100	71.39	160.02	166.40
823	1	823	160.16	160.77	160.77	158.83	47716900	60.15	160.35	166.34
824	1	824	161.08	159.54	161.09	159.26	47644200	53.43	160.45	166.32
825	1	825	159.96	158.85	160.80	158.53	50133100	55.30	160.61	166.14
826	1	826	160.37	164.27	164.51	160.16	68445600	62.86	161.08	166.66
827	1	827	163.31	163.92	165.02	162.54	49386500	60.00	161.44	167.06
828	1	828	163.80	163.94	164.10	162.75	41516200	65.21	161.93	167.09
829	1	829	164.80	165.17	166.10	164.36	49923000	68.80	162.55	166.90
830	1	830	164.51	166.32	166.85	164.25	47720200	65.95	163.04	167.44
831	1	831	164.79	165.35	166.56	164.27	52456400	60.27	163.34	167.75
832	1	832	163.76	163.73	165.15	163.21	58337300	50.30	163.35	167.76
833	1	833	163.71	164.04	164.31	162.61	41949600	47.79	163.29	167.64
834	1	834	163.90	162.49	165.01	162.45	48714100	45.36	163.16	167.48
835	1	835	161.79	162.48	163.99	161.53	45498800	50.00	163.16	167.48
836	1	836	163.90	167.10	167.24	163.90	64902300	58.55	163.43	168.23
837	1	837	167.17	168.36	168.52	166.57	55209200	68.60	163.97	169.18
838	1	838	167.96	168.27	169.12	167.32	52472900	72.62	164.59	169.61
839	1	839	168.76	167.22	169.02	166.23	48425700	71.33	165.19	169.14
840	1	840	168.18	166.14	169.59	165.86	65136000	56.13	165.32	169.26
841	1	841	163.60	164.50	165.74	163.03	81235400	51.73	165.36	169.25
842	1	842	169.65	172.22	172.94	169.43	113316400	67.03	165.96	171.19
843	1	843	171.13	172.15	172.49	170.77	55962800	65.08	166.45	172.62
844	1	844	171.70	170.43	172.19	170.26	45326900	58.67	166.75	173.26
845	1	845	171.67	172.21	172.67	170.56	53724500	63.99	167.24	174.31
846	1	846	172.49	172.39	173.23	170.83	49514700	68.77	167.86	175.12
847	1	847	172.50	171.46	172.94	169.90	45497800	65.66	168.39	175.53
848	1	848	172.05	170.96	172.10	170.37	37266700	68.71	168.99	175.38
849	1	849	170.88	170.96	172.03	170.69	42110300	68.74	169.60	174.83
850	1	850	170.61	171.58	171.82	169.32	57951600	62.03	169.92	175.04
851	1	851	171.89	173.92	174.11	171.47	65496700	64.12	170.31	175.77
852	1	852	175.26	174.03	175.26	173.81	55772400	64.61	170.73	176.38
853	1	853	172.86	173.08	173.59	172.33	43570900	64.90	171.15	176.54
854	1	854	172.02	170.46	172.26	170.18	50747300	60.18	171.45	176.06
855	1	855	169.99	170.73	171.31	169.42	45143500	65.73	171.90	174.26
856	1	856	171.30	171.88	172.78	170.59	56058300	48.72	171.87	174.23
857	1	857	172.21	174.30	174.64	172.00	54835000	56.91	172.03	174.72
858	1	858	175.82	176.16	177.84	175.43	55964400	68.20	172.44	175.75
859	1	859	176.19	176.11	178.20	175.62	99625300	63.93	172.72	176.56
860	1	860	176.56	178.93	178.96	175.79	68901800	69.63	173.18	178.25
861	1	861	179.87	179.79	180.61	178.11	61945900	75.12	173.78	179.83
862	1	862	181.46	178.42	183.76	176.89	121946500	71.40	174.31	180.61
863	1	863	178.81	178.06	178.96	176.29	64848400	69.92	174.82	181.10
864	1	864	177.29	176.68	180.04	176.18	61944600	63.72	175.18	181.24
865	1	865	176.76	179.41	179.68	176.32	50214900	64.47	175.57	181.98
866	1	866	180.33	179.80	181.06	179.47	48870700	64.98	175.99	182.70
867	1	867	180.10	182.61	182.71	179.81	54274900	72.59	176.67	184.01
868	1	868	181.62	182.13	182.97	181.27	54929100	80.81	177.50	184.45
869	1	869	182.19	182.77	183.20	180.85	57462900	81.16	178.36	184.65
870	1	870	182.78	184.81	185.32	182.60	65433200	82.01	179.28	185.26
871	1	871	185.53	183.73	185.79	183.08	101235600	74.99	179.96	185.64
872	1	872	183.22	183.82	184.90	183.22	49799100	72.40	180.50	186.08
873	1	873	183.71	182.78	184.22	181.42	49515700	68.42	180.98	186.06
874	1	874	182.56	185.80	185.85	182.49	51245300	68.77	181.47	187.00
875	1	875	184.36	185.48	186.35	183.82	53079300	66.03	181.88	187.70
876	1	876	185.63	184.08	186.84	184.04	48088700	65.88	182.28	187.86
877	1	877	184.69	186.85	187.18	184.48	50730800	71.77	182.91	188.41
878	1	878	186.72	188.03	188.68	186.39	51216800	78.39	183.72	188.58
879	1	879	187.86	188.37	188.85	187.72	46347300	75.45	184.36	189.13
880	1	880	190.40	192.72	193.23	190.03	85069600	79.96	185.28	191.13
881	1	881	192.53	191.22	192.63	190.53	31458200	71.26	185.90	192.32
882	1	882	190.34	190.10	191.74	189.39	46920300	69.06	186.47	192.86
883	1	883	188.62	190.58	190.78	187.98	45094300	68.82	187.03	193.39
884	1	884	190.18	189.45	191.43	189.02	46778000	61.70	187.36	193.71
885	1	885	188.04	187.40	188.77	185.84	59922200	58.82	187.62	193.62
886	1	886	187.94	186.87	188.08	185.40	46638100	57.18	187.84	193.45
887	1	887	188.46	188.55	190.47	187.26	60750200	63.20	188.25	193.05
888	1	888	189.27	189.31	189.96	188.56	41342300	58.97	188.50	193.11
889	1	889	189.01	189.46	189.95	188.41	41573900	60.25	188.79	193.08
890	1	890	190.67	192.74	193.07	190.58	50520200	70.32	189.40	193.25
891	1	891	192.11	192.48	193.08	191.18	48353800	64.98	189.81	193.68
892	1	892	191.86	193.84	196.95	191.41	80507300	65.31	190.22	194.50
893	1	893	193.84	191.89	195.21	191.26	59581200	58.53	190.47	194.69
894	1	894	192.85	190.71	193.72	190.00	71917800	44.22	190.33	194.35
895	1	895	192.17	191.51	193.66	191.01	45377800	50.86	190.35	194.39
896	1	896	192.09	192.37	193.19	191.68	37283200	56.90	190.51	194.69
897	1	897	192.42	193.25	194.38	192.08	47471900	57.92	190.70	195.13
898	1	898	194.76	191.98	195.93	191.31	47460200	57.41	190.88	195.30
899	1	899	193.42	194.57	195.37	192.89	48291400	70.42	191.40	195.73
900	1	900	194.80	195.19	195.23	194.00	38824100	73.55	191.99	195.92
901	1	901	194.98	194.35	195.46	194.02	35175100	67.26	192.40	195.98
902	1	902	193.79	191.34	193.92	190.62	50389300	55.32	192.55	195.72
903	1	903	190.34	189.94	191.13	189.46	61235200	51.17	192.58	195.62
904	1	904	184.33	180.82	186.17	180.75	115799700	27.20	191.73	198.71
905	1	905	180.96	177.70	181.95	176.21	97576100	24.52	190.68	200.89
906	1	906	178.53	178.64	179.11	176.44	67823000	23.42	189.59	201.45
907	1	907	179.71	177.04	179.77	175.87	60378500	23.72	188.53	202.04
908	1	908	178.33	176.83	179.59	176.46	54686900	24.55	187.54	202.34
909	1	909	176.42	176.88	177.71	175.65	51988100	22.43	186.49	202.13
910	1	910	177.06	178.55	178.78	176.41	43675600	24.70	185.51	201.29
911	1	911	177.97	176.55	178.57	176.15	43622600	20.65	184.31	200.10
912	1	912	176.23	175.67	177.63	175.60	46964900	20.94	183.15	198.90
913	1	913	176.24	173.11	176.61	172.60	66062900	11.71	181.62	196.75
914	1	914	171.42	173.60	174.21	171.08	61114200	11.30	180.07	193.56
915	1	915	174.18	174.94	175.23	172.86	46311900	15.83	178.69	189.59
916	1	916	176.16	176.33	176.78	175.35	42084200	21.96	177.61	185.76
917	1	917	177.61	180.20	180.63	177.42	52722800	33.34	176.92	181.34
918	1	918	179.75	175.48	180.18	175.11	54945800	39.25	176.54	180.40
919	1	919	176.48	177.70	178.24	174.92	51449600	50.00	176.54	180.40
920	1	920	179.17	179.27	179.67	177.64	43820700	51.28	176.58	180.56
921	1	921	178.79	183.18	183.96	178.59	53003900	61.42	177.02	182.35
922	1	922	184.00	186.69	186.89	183.80	60813900	66.36	177.73	185.14
923	1	923	186.88	186.91	188.16	186.53	60794500	66.54	178.44	187.30
924	1	924	188.53	188.50	188.95	187.32	45732600	66.45	179.15	189.52
925	1	925	187.32	188.73	189.01	186.65	45280000	71.39	180.02	191.44
926	1	926	187.44	181.98	187.89	180.55	81755800	59.18	180.47	191.65
927	1	927	174.29	176.66	177.30	172.66	112488800	54.77	180.73	191.33
928	1	928	177.44	177.27	179.32	176.88	65551300	54.93	180.99	190.99
929	1	929	179.15	178.45	179.38	176.44	58953100	54.72	181.24	190.76
930	1	930	178.58	175.40	179.21	173.93	90370200	48.81	181.17	190.85
931	1	931	175.61	173.32	176.40	173.09	84267900	40.70	180.68	191.23
932	1	932	173.11	174.85	175.20	172.70	60895800	49.06	180.64	191.29
933	1	933	175.58	174.12	175.60	172.94	109205100	44.45	180.38	191.50
934	1	934	175.58	177.06	178.47	175.27	67257600	46.72	180.22	191.47
935	1	935	176.62	178.16	178.72	176.23	51826900	41.85	179.86	191.02
936	1	936	178.35	174.60	178.79	174.51	58436200	30.41	179.00	189.75
937	1	937	173.66	173.04	175.40	172.97	63047900	28.47	178.01	188.15
938	1	938	173.78	173.90	176.18	173.16	56725400	26.82	176.97	185.31
939	1	939	173.31	175.18	176.07	173.26	46172700	29.17	176.00	180.89
940	1	940	173.93	171.08	174.31	170.79	64588900	31.77	175.22	179.43
941	1	941	171.74	169.56	172.16	168.19	66921800	36.40	174.71	179.80
942	1	942	168.48	169.82	171.15	166.77	56294400	35.51	174.18	179.66
943	1	943	171.14	170.34	172.19	169.47	51814200	33.82	173.60	178.85
\.


--
-- Data for Name: sector_dimension; Type: TABLE DATA; Schema: finance_schema; Owner: cosc
--

COPY finance_schema.sector_dimension (sector_id, sector_name) FROM stdin;
1	Technology
\.


--
-- Data for Name: stock_dimension; Type: TABLE DATA; Schema: finance_schema; Owner: cosc
--

COPY finance_schema.stock_dimension (stock_id, stock_symbol, company_name, sector, currency, exchange) FROM stdin;
1	AAPL	Apple Inc.	Technology	USD	NMS
\.


--
-- Name: date_dimension_date_id_seq; Type: SEQUENCE SET; Schema: finance_schema; Owner: cosc
--

SELECT pg_catalog.setval('finance_schema.date_dimension_date_id_seq', 943, true);


--
-- Name: exchange_dimension_exchange_id_seq; Type: SEQUENCE SET; Schema: finance_schema; Owner: cosc
--

SELECT pg_catalog.setval('finance_schema.exchange_dimension_exchange_id_seq', 1, true);


--
-- Name: fact_stock_data_transaction_id_seq; Type: SEQUENCE SET; Schema: finance_schema; Owner: cosc
--

SELECT pg_catalog.setval('finance_schema.fact_stock_data_transaction_id_seq', 943, true);


--
-- Name: sector_dimension_sector_id_seq; Type: SEQUENCE SET; Schema: finance_schema; Owner: cosc
--

SELECT pg_catalog.setval('finance_schema.sector_dimension_sector_id_seq', 1, true);


--
-- Name: stock_dimension_stock_id_seq; Type: SEQUENCE SET; Schema: finance_schema; Owner: cosc
--

SELECT pg_catalog.setval('finance_schema.stock_dimension_stock_id_seq', 1, true);


--
-- Name: date_dimension date_dimension_full_date_key; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.date_dimension
    ADD CONSTRAINT date_dimension_full_date_key UNIQUE (full_date);


--
-- Name: date_dimension date_dimension_pkey; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.date_dimension
    ADD CONSTRAINT date_dimension_pkey PRIMARY KEY (date_id);


--
-- Name: exchange_dimension exchange_dimension_exchange_name_key; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.exchange_dimension
    ADD CONSTRAINT exchange_dimension_exchange_name_key UNIQUE (exchange_name);


--
-- Name: exchange_dimension exchange_dimension_pkey; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.exchange_dimension
    ADD CONSTRAINT exchange_dimension_pkey PRIMARY KEY (exchange_id);


--
-- Name: fact_stock_data fact_stock_data_pkey; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.fact_stock_data
    ADD CONSTRAINT fact_stock_data_pkey PRIMARY KEY (transaction_id);


--
-- Name: sector_dimension sector_dimension_pkey; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.sector_dimension
    ADD CONSTRAINT sector_dimension_pkey PRIMARY KEY (sector_id);


--
-- Name: sector_dimension sector_dimension_sector_name_key; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.sector_dimension
    ADD CONSTRAINT sector_dimension_sector_name_key UNIQUE (sector_name);


--
-- Name: stock_dimension stock_dimension_pkey; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.stock_dimension
    ADD CONSTRAINT stock_dimension_pkey PRIMARY KEY (stock_id);


--
-- Name: stock_dimension stock_dimension_stock_symbol_key; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.stock_dimension
    ADD CONSTRAINT stock_dimension_stock_symbol_key UNIQUE (stock_symbol);


--
-- Name: fact_stock_data fact_stock_data_date_id_fkey; Type: FK CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.fact_stock_data
    ADD CONSTRAINT fact_stock_data_date_id_fkey FOREIGN KEY (date_id) REFERENCES finance_schema.date_dimension(date_id);


--
-- Name: fact_stock_data fact_stock_data_stock_id_fkey; Type: FK CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.fact_stock_data
    ADD CONSTRAINT fact_stock_data_stock_id_fkey FOREIGN KEY (stock_id) REFERENCES finance_schema.stock_dimension(stock_id);


--
-- PostgreSQL database dump complete
--

