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
-- Name: backtesting_results; Type: TABLE; Schema: finance_schema; Owner: cosc
--

CREATE TABLE finance_schema.backtesting_results (
    backtest_id integer NOT NULL,
    stock_id integer,
    start_date date,
    end_date date,
    initial_capital numeric(15,2) NOT NULL,
    final_capital numeric(15,2) NOT NULL,
    total_trades integer NOT NULL,
    profitable_trades integer NOT NULL,
    win_ratio numeric(5,2) DEFAULT 0.00,
    cumulative_return numeric(10,2) DEFAULT 0.00
);


ALTER TABLE finance_schema.backtesting_results OWNER TO cosc;

--
-- Name: backtesting_results_backtest_id_seq; Type: SEQUENCE; Schema: finance_schema; Owner: cosc
--

CREATE SEQUENCE finance_schema.backtesting_results_backtest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finance_schema.backtesting_results_backtest_id_seq OWNER TO cosc;

--
-- Name: backtesting_results_backtest_id_seq; Type: SEQUENCE OWNED BY; Schema: finance_schema; Owner: cosc
--

ALTER SEQUENCE finance_schema.backtesting_results_backtest_id_seq OWNED BY finance_schema.backtesting_results.backtest_id;


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
    stock_id integer NOT NULL,
    date_id integer NOT NULL,
    open_price numeric,
    close_price numeric,
    high_price numeric,
    low_price numeric,
    volume integer,
    rsi numeric,
    sma numeric,
    bollinger_band numeric
);


ALTER TABLE finance_schema.fact_stock_data OWNER TO cosc;

--
-- Name: future_predictions; Type: TABLE; Schema: finance_schema; Owner: cosc
--

CREATE TABLE finance_schema.future_predictions (
    stock_id integer NOT NULL,
    date_id integer NOT NULL,
    predicted_trend character varying(10) NOT NULL,
    prediction_confidence double precision NOT NULL,
    CONSTRAINT future_predictions_predicted_trend_check CHECK (((predicted_trend)::text = ANY ((ARRAY['up'::character varying, 'down'::character varying])::text[]))),
    CONSTRAINT future_predictions_prediction_confidence_check CHECK (((prediction_confidence >= (0)::double precision) AND (prediction_confidence <= (1)::double precision)))
);


ALTER TABLE finance_schema.future_predictions OWNER TO cosc;

--
-- Name: moving_average_crossover; Type: TABLE; Schema: finance_schema; Owner: cosc
--

CREATE TABLE finance_schema.moving_average_crossover (
    crossover_id integer NOT NULL,
    stock_id integer,
    date_id integer,
    short_ma numeric(10,2) NOT NULL,
    long_ma numeric(10,2) NOT NULL,
    price numeric(10,2) NOT NULL,
    crossover_signal character varying(4) NOT NULL
);


ALTER TABLE finance_schema.moving_average_crossover OWNER TO cosc;

--
-- Name: moving_average_crossover_crossover_id_seq; Type: SEQUENCE; Schema: finance_schema; Owner: cosc
--

CREATE SEQUENCE finance_schema.moving_average_crossover_crossover_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finance_schema.moving_average_crossover_crossover_id_seq OWNER TO cosc;

--
-- Name: moving_average_crossover_crossover_id_seq; Type: SEQUENCE OWNED BY; Schema: finance_schema; Owner: cosc
--

ALTER SEQUENCE finance_schema.moving_average_crossover_crossover_id_seq OWNED BY finance_schema.moving_average_crossover.crossover_id;


--
-- Name: portfolio_allocation; Type: TABLE; Schema: finance_schema; Owner: cosc
--

CREATE TABLE finance_schema.portfolio_allocation (
    portfolio_id integer NOT NULL,
    stock_id integer,
    trade_date date,
    action character varying(4),
    shares integer,
    capital numeric(10,2),
    "position" integer,
    portfolio_value numeric(10,2)
);


ALTER TABLE finance_schema.portfolio_allocation OWNER TO cosc;

--
-- Name: portfolio_allocation_portfolio_id_seq; Type: SEQUENCE; Schema: finance_schema; Owner: cosc
--

CREATE SEQUENCE finance_schema.portfolio_allocation_portfolio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finance_schema.portfolio_allocation_portfolio_id_seq OWNER TO cosc;

--
-- Name: portfolio_allocation_portfolio_id_seq; Type: SEQUENCE OWNED BY; Schema: finance_schema; Owner: cosc
--

ALTER SEQUENCE finance_schema.portfolio_allocation_portfolio_id_seq OWNED BY finance_schema.portfolio_allocation.portfolio_id;


--
-- Name: portfolio_history; Type: TABLE; Schema: finance_schema; Owner: cosc
--

CREATE TABLE finance_schema.portfolio_history (
    id integer NOT NULL,
    stock_id integer NOT NULL,
    trade_date timestamp without time zone NOT NULL,
    action character varying(10) NOT NULL,
    shares integer NOT NULL,
    capital numeric NOT NULL,
    "position" integer NOT NULL,
    portfolio_value numeric NOT NULL,
    stock_price numeric NOT NULL
);


ALTER TABLE finance_schema.portfolio_history OWNER TO cosc;

--
-- Name: portfolio_history_id_seq; Type: SEQUENCE; Schema: finance_schema; Owner: cosc
--

CREATE SEQUENCE finance_schema.portfolio_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finance_schema.portfolio_history_id_seq OWNER TO cosc;

--
-- Name: portfolio_history_id_seq; Type: SEQUENCE OWNED BY; Schema: finance_schema; Owner: cosc
--

ALTER SEQUENCE finance_schema.portfolio_history_id_seq OWNED BY finance_schema.portfolio_history.id;


--
-- Name: prediction_trend; Type: TABLE; Schema: finance_schema; Owner: cosc
--

CREATE TABLE finance_schema.prediction_trend (
    trend_id integer NOT NULL,
    stock_id integer NOT NULL,
    date_id integer NOT NULL,
    closing_price numeric(12,2),
    sma numeric(12,2),
    rsi numeric(5,2),
    trend_direction character varying(15) NOT NULL,
    signal character varying(15),
    trend_description text
);


ALTER TABLE finance_schema.prediction_trend OWNER TO cosc;

--
-- Name: prediction_trend_trend_id_seq; Type: SEQUENCE; Schema: finance_schema; Owner: cosc
--

CREATE SEQUENCE finance_schema.prediction_trend_trend_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finance_schema.prediction_trend_trend_id_seq OWNER TO cosc;

--
-- Name: prediction_trend_trend_id_seq; Type: SEQUENCE OWNED BY; Schema: finance_schema; Owner: cosc
--

ALTER SEQUENCE finance_schema.prediction_trend_trend_id_seq OWNED BY finance_schema.prediction_trend.trend_id;


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
    stock_symbol character varying(10),
    company_name character varying(255),
    sector character varying(100),
    currency character varying(10),
    exchange character varying(100)
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
-- Name: backtesting_results backtest_id; Type: DEFAULT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.backtesting_results ALTER COLUMN backtest_id SET DEFAULT nextval('finance_schema.backtesting_results_backtest_id_seq'::regclass);


--
-- Name: date_dimension date_id; Type: DEFAULT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.date_dimension ALTER COLUMN date_id SET DEFAULT nextval('finance_schema.date_dimension_date_id_seq'::regclass);


--
-- Name: exchange_dimension exchange_id; Type: DEFAULT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.exchange_dimension ALTER COLUMN exchange_id SET DEFAULT nextval('finance_schema.exchange_dimension_exchange_id_seq'::regclass);


--
-- Name: moving_average_crossover crossover_id; Type: DEFAULT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.moving_average_crossover ALTER COLUMN crossover_id SET DEFAULT nextval('finance_schema.moving_average_crossover_crossover_id_seq'::regclass);


--
-- Name: portfolio_allocation portfolio_id; Type: DEFAULT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.portfolio_allocation ALTER COLUMN portfolio_id SET DEFAULT nextval('finance_schema.portfolio_allocation_portfolio_id_seq'::regclass);


--
-- Name: portfolio_history id; Type: DEFAULT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.portfolio_history ALTER COLUMN id SET DEFAULT nextval('finance_schema.portfolio_history_id_seq'::regclass);


--
-- Name: prediction_trend trend_id; Type: DEFAULT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.prediction_trend ALTER COLUMN trend_id SET DEFAULT nextval('finance_schema.prediction_trend_trend_id_seq'::regclass);


--
-- Name: sector_dimension sector_id; Type: DEFAULT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.sector_dimension ALTER COLUMN sector_id SET DEFAULT nextval('finance_schema.sector_dimension_sector_id_seq'::regclass);


--
-- Name: stock_dimension stock_id; Type: DEFAULT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.stock_dimension ALTER COLUMN stock_id SET DEFAULT nextval('finance_schema.stock_dimension_stock_id_seq'::regclass);


--
-- Data for Name: backtesting_results; Type: TABLE DATA; Schema: finance_schema; Owner: cosc
--

COPY finance_schema.backtesting_results (backtest_id, stock_id, start_date, end_date, initial_capital, final_capital, total_trades, profitable_trades, win_ratio, cumulative_return) FROM stdin;
1	1	2009-01-01	2024-10-01	10000.00	205179.41	13	5	83.33	1951.79
\.


--
-- Data for Name: date_dimension; Type: TABLE DATA; Schema: finance_schema; Owner: cosc
--

COPY finance_schema.date_dimension (date_id, full_date, day_of_week, month, quarter, year, is_holiday) FROM stdin;
1	2009-01-02	Friday	January	Q1	2009	f
2	2009-01-05	Monday	January	Q1	2009	f
3	2009-01-06	Tuesday	January	Q1	2009	f
4	2009-01-07	Wednesday	January	Q1	2009	f
5	2009-01-08	Thursday	January	Q1	2009	f
6	2009-01-09	Friday	January	Q1	2009	f
7	2009-01-12	Monday	January	Q1	2009	f
8	2009-01-13	Tuesday	January	Q1	2009	f
9	2009-01-14	Wednesday	January	Q1	2009	f
10	2009-01-15	Thursday	January	Q1	2009	f
11	2009-01-16	Friday	January	Q1	2009	f
12	2009-01-20	Tuesday	January	Q1	2009	f
13	2009-01-21	Wednesday	January	Q1	2009	f
14	2009-01-22	Thursday	January	Q1	2009	f
15	2009-01-23	Friday	January	Q1	2009	f
16	2009-01-26	Monday	January	Q1	2009	f
17	2009-01-27	Tuesday	January	Q1	2009	f
18	2009-01-28	Wednesday	January	Q1	2009	f
19	2009-01-29	Thursday	January	Q1	2009	f
20	2009-01-30	Friday	January	Q1	2009	f
21	2009-02-02	Monday	February	Q1	2009	f
22	2009-02-03	Tuesday	February	Q1	2009	f
23	2009-02-04	Wednesday	February	Q1	2009	f
24	2009-02-05	Thursday	February	Q1	2009	f
25	2009-02-06	Friday	February	Q1	2009	f
26	2009-02-09	Monday	February	Q1	2009	f
27	2009-02-10	Tuesday	February	Q1	2009	f
28	2009-02-11	Wednesday	February	Q1	2009	f
29	2009-02-12	Thursday	February	Q1	2009	f
30	2009-02-13	Friday	February	Q1	2009	f
31	2009-02-17	Tuesday	February	Q1	2009	f
32	2009-02-18	Wednesday	February	Q1	2009	f
33	2009-02-19	Thursday	February	Q1	2009	f
34	2009-02-20	Friday	February	Q1	2009	f
35	2009-02-23	Monday	February	Q1	2009	f
36	2009-02-24	Tuesday	February	Q1	2009	f
37	2009-02-25	Wednesday	February	Q1	2009	f
38	2009-02-26	Thursday	February	Q1	2009	f
39	2009-02-27	Friday	February	Q1	2009	f
40	2009-03-02	Monday	March	Q1	2009	f
41	2009-03-03	Tuesday	March	Q1	2009	f
42	2009-03-04	Wednesday	March	Q1	2009	f
43	2009-03-05	Thursday	March	Q1	2009	f
44	2009-03-06	Friday	March	Q1	2009	f
45	2009-03-09	Monday	March	Q1	2009	f
46	2009-03-10	Tuesday	March	Q1	2009	f
47	2009-03-11	Wednesday	March	Q1	2009	f
48	2009-03-12	Thursday	March	Q1	2009	f
49	2009-03-13	Friday	March	Q1	2009	f
50	2009-03-16	Monday	March	Q1	2009	f
51	2009-03-17	Tuesday	March	Q1	2009	f
52	2009-03-18	Wednesday	March	Q1	2009	f
53	2009-03-19	Thursday	March	Q1	2009	f
54	2009-03-20	Friday	March	Q1	2009	f
55	2009-03-23	Monday	March	Q1	2009	f
56	2009-03-24	Tuesday	March	Q1	2009	f
57	2009-03-25	Wednesday	March	Q1	2009	f
58	2009-03-26	Thursday	March	Q1	2009	f
59	2009-03-27	Friday	March	Q1	2009	f
60	2009-03-30	Monday	March	Q1	2009	f
61	2009-03-31	Tuesday	March	Q1	2009	f
62	2009-04-01	Wednesday	April	Q2	2009	f
63	2009-04-02	Thursday	April	Q2	2009	f
64	2009-04-03	Friday	April	Q2	2009	f
65	2009-04-06	Monday	April	Q2	2009	f
66	2009-04-07	Tuesday	April	Q2	2009	f
67	2009-04-08	Wednesday	April	Q2	2009	f
68	2009-04-09	Thursday	April	Q2	2009	f
69	2009-04-13	Monday	April	Q2	2009	f
70	2009-04-14	Tuesday	April	Q2	2009	f
71	2009-04-15	Wednesday	April	Q2	2009	f
72	2009-04-16	Thursday	April	Q2	2009	f
73	2009-04-17	Friday	April	Q2	2009	f
74	2009-04-20	Monday	April	Q2	2009	f
75	2009-04-21	Tuesday	April	Q2	2009	f
76	2009-04-22	Wednesday	April	Q2	2009	f
77	2009-04-23	Thursday	April	Q2	2009	f
78	2009-04-24	Friday	April	Q2	2009	f
79	2009-04-27	Monday	April	Q2	2009	f
80	2009-04-28	Tuesday	April	Q2	2009	f
81	2009-04-29	Wednesday	April	Q2	2009	f
82	2009-04-30	Thursday	April	Q2	2009	f
83	2009-05-01	Friday	May	Q2	2009	f
84	2009-05-04	Monday	May	Q2	2009	f
85	2009-05-05	Tuesday	May	Q2	2009	f
86	2009-05-06	Wednesday	May	Q2	2009	f
87	2009-05-07	Thursday	May	Q2	2009	f
88	2009-05-08	Friday	May	Q2	2009	f
89	2009-05-11	Monday	May	Q2	2009	f
90	2009-05-12	Tuesday	May	Q2	2009	f
91	2009-05-13	Wednesday	May	Q2	2009	f
92	2009-05-14	Thursday	May	Q2	2009	f
93	2009-05-15	Friday	May	Q2	2009	f
94	2009-05-18	Monday	May	Q2	2009	f
95	2009-05-19	Tuesday	May	Q2	2009	f
96	2009-05-20	Wednesday	May	Q2	2009	f
97	2009-05-21	Thursday	May	Q2	2009	f
98	2009-05-22	Friday	May	Q2	2009	f
99	2009-05-26	Tuesday	May	Q2	2009	f
100	2009-05-27	Wednesday	May	Q2	2009	f
101	2009-05-28	Thursday	May	Q2	2009	f
102	2009-05-29	Friday	May	Q2	2009	f
103	2009-06-01	Monday	June	Q2	2009	f
104	2009-06-02	Tuesday	June	Q2	2009	f
105	2009-06-03	Wednesday	June	Q2	2009	f
106	2009-06-04	Thursday	June	Q2	2009	f
107	2009-06-05	Friday	June	Q2	2009	f
108	2009-06-08	Monday	June	Q2	2009	f
109	2009-06-09	Tuesday	June	Q2	2009	f
110	2009-06-10	Wednesday	June	Q2	2009	f
111	2009-06-11	Thursday	June	Q2	2009	f
112	2009-06-12	Friday	June	Q2	2009	f
113	2009-06-15	Monday	June	Q2	2009	f
114	2009-06-16	Tuesday	June	Q2	2009	f
115	2009-06-17	Wednesday	June	Q2	2009	f
116	2009-06-18	Thursday	June	Q2	2009	f
117	2009-06-19	Friday	June	Q2	2009	f
118	2009-06-22	Monday	June	Q2	2009	f
119	2009-06-23	Tuesday	June	Q2	2009	f
120	2009-06-24	Wednesday	June	Q2	2009	f
121	2009-06-25	Thursday	June	Q2	2009	f
122	2009-06-26	Friday	June	Q2	2009	f
123	2009-06-29	Monday	June	Q2	2009	f
124	2009-06-30	Tuesday	June	Q2	2009	f
125	2009-07-01	Wednesday	July	Q3	2009	f
126	2009-07-02	Thursday	July	Q3	2009	f
127	2009-07-06	Monday	July	Q3	2009	f
128	2009-07-07	Tuesday	July	Q3	2009	f
129	2009-07-08	Wednesday	July	Q3	2009	f
130	2009-07-09	Thursday	July	Q3	2009	f
131	2009-07-10	Friday	July	Q3	2009	f
132	2009-07-13	Monday	July	Q3	2009	f
133	2009-07-14	Tuesday	July	Q3	2009	f
134	2009-07-15	Wednesday	July	Q3	2009	f
135	2009-07-16	Thursday	July	Q3	2009	f
136	2009-07-17	Friday	July	Q3	2009	f
137	2009-07-20	Monday	July	Q3	2009	f
138	2009-07-21	Tuesday	July	Q3	2009	f
139	2009-07-22	Wednesday	July	Q3	2009	f
140	2009-07-23	Thursday	July	Q3	2009	f
141	2009-07-24	Friday	July	Q3	2009	f
142	2009-07-27	Monday	July	Q3	2009	f
143	2009-07-28	Tuesday	July	Q3	2009	f
144	2009-07-29	Wednesday	July	Q3	2009	f
145	2009-07-30	Thursday	July	Q3	2009	f
146	2009-07-31	Friday	July	Q3	2009	f
147	2009-08-03	Monday	August	Q3	2009	f
148	2009-08-04	Tuesday	August	Q3	2009	f
149	2009-08-05	Wednesday	August	Q3	2009	f
150	2009-08-06	Thursday	August	Q3	2009	f
151	2009-08-07	Friday	August	Q3	2009	f
152	2009-08-10	Monday	August	Q3	2009	f
153	2009-08-11	Tuesday	August	Q3	2009	f
154	2009-08-12	Wednesday	August	Q3	2009	f
155	2009-08-13	Thursday	August	Q3	2009	f
156	2009-08-14	Friday	August	Q3	2009	f
157	2009-08-17	Monday	August	Q3	2009	f
158	2009-08-18	Tuesday	August	Q3	2009	f
159	2009-08-19	Wednesday	August	Q3	2009	f
160	2009-08-20	Thursday	August	Q3	2009	f
161	2009-08-21	Friday	August	Q3	2009	f
162	2009-08-24	Monday	August	Q3	2009	f
163	2009-08-25	Tuesday	August	Q3	2009	f
164	2009-08-26	Wednesday	August	Q3	2009	f
165	2009-08-27	Thursday	August	Q3	2009	f
166	2009-08-28	Friday	August	Q3	2009	f
167	2009-08-31	Monday	August	Q3	2009	f
168	2009-09-01	Tuesday	September	Q3	2009	f
169	2009-09-02	Wednesday	September	Q3	2009	f
170	2009-09-03	Thursday	September	Q3	2009	f
171	2009-09-04	Friday	September	Q3	2009	f
172	2009-09-08	Tuesday	September	Q3	2009	f
173	2009-09-09	Wednesday	September	Q3	2009	f
174	2009-09-10	Thursday	September	Q3	2009	f
175	2009-09-11	Friday	September	Q3	2009	f
176	2009-09-14	Monday	September	Q3	2009	f
177	2009-09-15	Tuesday	September	Q3	2009	f
178	2009-09-16	Wednesday	September	Q3	2009	f
179	2009-09-17	Thursday	September	Q3	2009	f
180	2009-09-18	Friday	September	Q3	2009	f
181	2009-09-21	Monday	September	Q3	2009	f
182	2009-09-22	Tuesday	September	Q3	2009	f
183	2009-09-23	Wednesday	September	Q3	2009	f
184	2009-09-24	Thursday	September	Q3	2009	f
185	2009-09-25	Friday	September	Q3	2009	f
186	2009-09-28	Monday	September	Q3	2009	f
187	2009-09-29	Tuesday	September	Q3	2009	f
188	2009-09-30	Wednesday	September	Q3	2009	f
189	2009-10-01	Thursday	October	Q4	2009	f
190	2009-10-02	Friday	October	Q4	2009	f
191	2009-10-05	Monday	October	Q4	2009	f
192	2009-10-06	Tuesday	October	Q4	2009	f
193	2009-10-07	Wednesday	October	Q4	2009	f
194	2009-10-08	Thursday	October	Q4	2009	f
195	2009-10-09	Friday	October	Q4	2009	f
196	2009-10-12	Monday	October	Q4	2009	f
197	2009-10-13	Tuesday	October	Q4	2009	f
198	2009-10-14	Wednesday	October	Q4	2009	f
199	2009-10-15	Thursday	October	Q4	2009	f
200	2009-10-16	Friday	October	Q4	2009	f
201	2009-10-19	Monday	October	Q4	2009	f
202	2009-10-20	Tuesday	October	Q4	2009	f
203	2009-10-21	Wednesday	October	Q4	2009	f
204	2009-10-22	Thursday	October	Q4	2009	f
205	2009-10-23	Friday	October	Q4	2009	f
206	2009-10-26	Monday	October	Q4	2009	f
207	2009-10-27	Tuesday	October	Q4	2009	f
208	2009-10-28	Wednesday	October	Q4	2009	f
209	2009-10-29	Thursday	October	Q4	2009	f
210	2009-10-30	Friday	October	Q4	2009	f
211	2009-11-02	Monday	November	Q4	2009	f
212	2009-11-03	Tuesday	November	Q4	2009	f
213	2009-11-04	Wednesday	November	Q4	2009	f
214	2009-11-05	Thursday	November	Q4	2009	f
215	2009-11-06	Friday	November	Q4	2009	f
216	2009-11-09	Monday	November	Q4	2009	f
217	2009-11-10	Tuesday	November	Q4	2009	f
218	2009-11-11	Wednesday	November	Q4	2009	f
219	2009-11-12	Thursday	November	Q4	2009	f
220	2009-11-13	Friday	November	Q4	2009	f
221	2009-11-16	Monday	November	Q4	2009	f
222	2009-11-17	Tuesday	November	Q4	2009	f
223	2009-11-18	Wednesday	November	Q4	2009	f
224	2009-11-19	Thursday	November	Q4	2009	f
225	2009-11-20	Friday	November	Q4	2009	f
226	2009-11-23	Monday	November	Q4	2009	f
227	2009-11-24	Tuesday	November	Q4	2009	f
228	2009-11-25	Wednesday	November	Q4	2009	f
229	2009-11-27	Friday	November	Q4	2009	f
230	2009-11-30	Monday	November	Q4	2009	f
231	2009-12-01	Tuesday	December	Q4	2009	f
232	2009-12-02	Wednesday	December	Q4	2009	f
233	2009-12-03	Thursday	December	Q4	2009	f
234	2009-12-04	Friday	December	Q4	2009	f
235	2009-12-07	Monday	December	Q4	2009	f
236	2009-12-08	Tuesday	December	Q4	2009	f
237	2009-12-09	Wednesday	December	Q4	2009	f
238	2009-12-10	Thursday	December	Q4	2009	f
239	2009-12-11	Friday	December	Q4	2009	f
240	2009-12-14	Monday	December	Q4	2009	f
241	2009-12-15	Tuesday	December	Q4	2009	f
242	2009-12-16	Wednesday	December	Q4	2009	f
243	2009-12-17	Thursday	December	Q4	2009	f
244	2009-12-18	Friday	December	Q4	2009	f
245	2009-12-21	Monday	December	Q4	2009	f
246	2009-12-22	Tuesday	December	Q4	2009	f
247	2009-12-23	Wednesday	December	Q4	2009	f
248	2009-12-24	Thursday	December	Q4	2009	f
249	2009-12-28	Monday	December	Q4	2009	f
250	2009-12-29	Tuesday	December	Q4	2009	f
251	2009-12-30	Wednesday	December	Q4	2009	f
252	2009-12-31	Thursday	December	Q4	2009	f
253	2010-01-04	Monday	January	Q1	2010	f
254	2010-01-05	Tuesday	January	Q1	2010	f
255	2010-01-06	Wednesday	January	Q1	2010	f
256	2010-01-07	Thursday	January	Q1	2010	f
257	2010-01-08	Friday	January	Q1	2010	f
258	2010-01-11	Monday	January	Q1	2010	f
259	2010-01-12	Tuesday	January	Q1	2010	f
260	2010-01-13	Wednesday	January	Q1	2010	f
261	2010-01-14	Thursday	January	Q1	2010	f
262	2010-01-15	Friday	January	Q1	2010	f
263	2010-01-19	Tuesday	January	Q1	2010	f
264	2010-01-20	Wednesday	January	Q1	2010	f
265	2010-01-21	Thursday	January	Q1	2010	f
266	2010-01-22	Friday	January	Q1	2010	f
267	2010-01-25	Monday	January	Q1	2010	f
268	2010-01-26	Tuesday	January	Q1	2010	f
269	2010-01-27	Wednesday	January	Q1	2010	f
270	2010-01-28	Thursday	January	Q1	2010	f
271	2010-01-29	Friday	January	Q1	2010	f
272	2010-02-01	Monday	February	Q1	2010	f
273	2010-02-02	Tuesday	February	Q1	2010	f
274	2010-02-03	Wednesday	February	Q1	2010	f
275	2010-02-04	Thursday	February	Q1	2010	f
276	2010-02-05	Friday	February	Q1	2010	f
277	2010-02-08	Monday	February	Q1	2010	f
278	2010-02-09	Tuesday	February	Q1	2010	f
279	2010-02-10	Wednesday	February	Q1	2010	f
280	2010-02-11	Thursday	February	Q1	2010	f
281	2010-02-12	Friday	February	Q1	2010	f
282	2010-02-16	Tuesday	February	Q1	2010	f
283	2010-02-17	Wednesday	February	Q1	2010	f
284	2010-02-18	Thursday	February	Q1	2010	f
285	2010-02-19	Friday	February	Q1	2010	f
286	2010-02-22	Monday	February	Q1	2010	f
287	2010-02-23	Tuesday	February	Q1	2010	f
288	2010-02-24	Wednesday	February	Q1	2010	f
289	2010-02-25	Thursday	February	Q1	2010	f
290	2010-02-26	Friday	February	Q1	2010	f
291	2010-03-01	Monday	March	Q1	2010	f
292	2010-03-02	Tuesday	March	Q1	2010	f
293	2010-03-03	Wednesday	March	Q1	2010	f
294	2010-03-04	Thursday	March	Q1	2010	f
295	2010-03-05	Friday	March	Q1	2010	f
296	2010-03-08	Monday	March	Q1	2010	f
297	2010-03-09	Tuesday	March	Q1	2010	f
298	2010-03-10	Wednesday	March	Q1	2010	f
299	2010-03-11	Thursday	March	Q1	2010	f
300	2010-03-12	Friday	March	Q1	2010	f
301	2010-03-15	Monday	March	Q1	2010	f
302	2010-03-16	Tuesday	March	Q1	2010	f
303	2010-03-17	Wednesday	March	Q1	2010	f
304	2010-03-18	Thursday	March	Q1	2010	f
305	2010-03-19	Friday	March	Q1	2010	f
306	2010-03-22	Monday	March	Q1	2010	f
307	2010-03-23	Tuesday	March	Q1	2010	f
308	2010-03-24	Wednesday	March	Q1	2010	f
309	2010-03-25	Thursday	March	Q1	2010	f
310	2010-03-26	Friday	March	Q1	2010	f
311	2010-03-29	Monday	March	Q1	2010	f
312	2010-03-30	Tuesday	March	Q1	2010	f
313	2010-03-31	Wednesday	March	Q1	2010	f
314	2010-04-01	Thursday	April	Q2	2010	f
315	2010-04-05	Monday	April	Q2	2010	f
316	2010-04-06	Tuesday	April	Q2	2010	f
317	2010-04-07	Wednesday	April	Q2	2010	f
318	2010-04-08	Thursday	April	Q2	2010	f
319	2010-04-09	Friday	April	Q2	2010	f
320	2010-04-12	Monday	April	Q2	2010	f
321	2010-04-13	Tuesday	April	Q2	2010	f
322	2010-04-14	Wednesday	April	Q2	2010	f
323	2010-04-15	Thursday	April	Q2	2010	f
324	2010-04-16	Friday	April	Q2	2010	f
325	2010-04-19	Monday	April	Q2	2010	f
326	2010-04-20	Tuesday	April	Q2	2010	f
327	2010-04-21	Wednesday	April	Q2	2010	f
328	2010-04-22	Thursday	April	Q2	2010	f
329	2010-04-23	Friday	April	Q2	2010	f
330	2010-04-26	Monday	April	Q2	2010	f
331	2010-04-27	Tuesday	April	Q2	2010	f
332	2010-04-28	Wednesday	April	Q2	2010	f
333	2010-04-29	Thursday	April	Q2	2010	f
334	2010-04-30	Friday	April	Q2	2010	f
335	2010-05-03	Monday	May	Q2	2010	f
336	2010-05-04	Tuesday	May	Q2	2010	f
337	2010-05-05	Wednesday	May	Q2	2010	f
338	2010-05-06	Thursday	May	Q2	2010	f
339	2010-05-07	Friday	May	Q2	2010	f
340	2010-05-10	Monday	May	Q2	2010	f
341	2010-05-11	Tuesday	May	Q2	2010	f
342	2010-05-12	Wednesday	May	Q2	2010	f
343	2010-05-13	Thursday	May	Q2	2010	f
344	2010-05-14	Friday	May	Q2	2010	f
345	2010-05-17	Monday	May	Q2	2010	f
346	2010-05-18	Tuesday	May	Q2	2010	f
347	2010-05-19	Wednesday	May	Q2	2010	f
348	2010-05-20	Thursday	May	Q2	2010	f
349	2010-05-21	Friday	May	Q2	2010	f
350	2010-05-24	Monday	May	Q2	2010	f
351	2010-05-25	Tuesday	May	Q2	2010	f
352	2010-05-26	Wednesday	May	Q2	2010	f
353	2010-05-27	Thursday	May	Q2	2010	f
354	2010-05-28	Friday	May	Q2	2010	f
355	2010-06-01	Tuesday	June	Q2	2010	f
356	2010-06-02	Wednesday	June	Q2	2010	f
357	2010-06-03	Thursday	June	Q2	2010	f
358	2010-06-04	Friday	June	Q2	2010	f
359	2010-06-07	Monday	June	Q2	2010	f
360	2010-06-08	Tuesday	June	Q2	2010	f
361	2010-06-09	Wednesday	June	Q2	2010	f
362	2010-06-10	Thursday	June	Q2	2010	f
363	2010-06-11	Friday	June	Q2	2010	f
364	2010-06-14	Monday	June	Q2	2010	f
365	2010-06-15	Tuesday	June	Q2	2010	f
366	2010-06-16	Wednesday	June	Q2	2010	f
367	2010-06-17	Thursday	June	Q2	2010	f
368	2010-06-18	Friday	June	Q2	2010	f
369	2010-06-21	Monday	June	Q2	2010	f
370	2010-06-22	Tuesday	June	Q2	2010	f
371	2010-06-23	Wednesday	June	Q2	2010	f
372	2010-06-24	Thursday	June	Q2	2010	f
373	2010-06-25	Friday	June	Q2	2010	f
374	2010-06-28	Monday	June	Q2	2010	f
375	2010-06-29	Tuesday	June	Q2	2010	f
376	2010-06-30	Wednesday	June	Q2	2010	f
377	2010-07-01	Thursday	July	Q3	2010	f
378	2010-07-02	Friday	July	Q3	2010	f
379	2010-07-06	Tuesday	July	Q3	2010	f
380	2010-07-07	Wednesday	July	Q3	2010	f
381	2010-07-08	Thursday	July	Q3	2010	f
382	2010-07-09	Friday	July	Q3	2010	f
383	2010-07-12	Monday	July	Q3	2010	f
384	2010-07-13	Tuesday	July	Q3	2010	f
385	2010-07-14	Wednesday	July	Q3	2010	f
386	2010-07-15	Thursday	July	Q3	2010	f
387	2010-07-16	Friday	July	Q3	2010	f
388	2010-07-19	Monday	July	Q3	2010	f
389	2010-07-20	Tuesday	July	Q3	2010	f
390	2010-07-21	Wednesday	July	Q3	2010	f
391	2010-07-22	Thursday	July	Q3	2010	f
392	2010-07-23	Friday	July	Q3	2010	f
393	2010-07-26	Monday	July	Q3	2010	f
394	2010-07-27	Tuesday	July	Q3	2010	f
395	2010-07-28	Wednesday	July	Q3	2010	f
396	2010-07-29	Thursday	July	Q3	2010	f
397	2010-07-30	Friday	July	Q3	2010	f
398	2010-08-02	Monday	August	Q3	2010	f
399	2010-08-03	Tuesday	August	Q3	2010	f
400	2010-08-04	Wednesday	August	Q3	2010	f
401	2010-08-05	Thursday	August	Q3	2010	f
402	2010-08-06	Friday	August	Q3	2010	f
403	2010-08-09	Monday	August	Q3	2010	f
404	2010-08-10	Tuesday	August	Q3	2010	f
405	2010-08-11	Wednesday	August	Q3	2010	f
406	2010-08-12	Thursday	August	Q3	2010	f
407	2010-08-13	Friday	August	Q3	2010	f
408	2010-08-16	Monday	August	Q3	2010	f
409	2010-08-17	Tuesday	August	Q3	2010	f
410	2010-08-18	Wednesday	August	Q3	2010	f
411	2010-08-19	Thursday	August	Q3	2010	f
412	2010-08-20	Friday	August	Q3	2010	f
413	2010-08-23	Monday	August	Q3	2010	f
414	2010-08-24	Tuesday	August	Q3	2010	f
415	2010-08-25	Wednesday	August	Q3	2010	f
416	2010-08-26	Thursday	August	Q3	2010	f
417	2010-08-27	Friday	August	Q3	2010	f
418	2010-08-30	Monday	August	Q3	2010	f
419	2010-08-31	Tuesday	August	Q3	2010	f
420	2010-09-01	Wednesday	September	Q3	2010	f
421	2010-09-02	Thursday	September	Q3	2010	f
422	2010-09-03	Friday	September	Q3	2010	f
423	2010-09-07	Tuesday	September	Q3	2010	f
424	2010-09-08	Wednesday	September	Q3	2010	f
425	2010-09-09	Thursday	September	Q3	2010	f
426	2010-09-10	Friday	September	Q3	2010	f
427	2010-09-13	Monday	September	Q3	2010	f
428	2010-09-14	Tuesday	September	Q3	2010	f
429	2010-09-15	Wednesday	September	Q3	2010	f
430	2010-09-16	Thursday	September	Q3	2010	f
431	2010-09-17	Friday	September	Q3	2010	f
432	2010-09-20	Monday	September	Q3	2010	f
433	2010-09-21	Tuesday	September	Q3	2010	f
434	2010-09-22	Wednesday	September	Q3	2010	f
435	2010-09-23	Thursday	September	Q3	2010	f
436	2010-09-24	Friday	September	Q3	2010	f
437	2010-09-27	Monday	September	Q3	2010	f
438	2010-09-28	Tuesday	September	Q3	2010	f
439	2010-09-29	Wednesday	September	Q3	2010	f
440	2010-09-30	Thursday	September	Q3	2010	f
441	2010-10-01	Friday	October	Q4	2010	f
442	2010-10-04	Monday	October	Q4	2010	f
443	2010-10-05	Tuesday	October	Q4	2010	f
444	2010-10-06	Wednesday	October	Q4	2010	f
445	2010-10-07	Thursday	October	Q4	2010	f
446	2010-10-08	Friday	October	Q4	2010	f
447	2010-10-11	Monday	October	Q4	2010	f
448	2010-10-12	Tuesday	October	Q4	2010	f
449	2010-10-13	Wednesday	October	Q4	2010	f
450	2010-10-14	Thursday	October	Q4	2010	f
451	2010-10-15	Friday	October	Q4	2010	f
452	2010-10-18	Monday	October	Q4	2010	f
453	2010-10-19	Tuesday	October	Q4	2010	f
454	2010-10-20	Wednesday	October	Q4	2010	f
455	2010-10-21	Thursday	October	Q4	2010	f
456	2010-10-22	Friday	October	Q4	2010	f
457	2010-10-25	Monday	October	Q4	2010	f
458	2010-10-26	Tuesday	October	Q4	2010	f
459	2010-10-27	Wednesday	October	Q4	2010	f
460	2010-10-28	Thursday	October	Q4	2010	f
461	2010-10-29	Friday	October	Q4	2010	f
462	2010-11-01	Monday	November	Q4	2010	f
463	2010-11-02	Tuesday	November	Q4	2010	f
464	2010-11-03	Wednesday	November	Q4	2010	f
465	2010-11-04	Thursday	November	Q4	2010	f
466	2010-11-05	Friday	November	Q4	2010	f
467	2010-11-08	Monday	November	Q4	2010	f
468	2010-11-09	Tuesday	November	Q4	2010	f
469	2010-11-10	Wednesday	November	Q4	2010	f
470	2010-11-11	Thursday	November	Q4	2010	f
471	2010-11-12	Friday	November	Q4	2010	f
472	2010-11-15	Monday	November	Q4	2010	f
473	2010-11-16	Tuesday	November	Q4	2010	f
474	2010-11-17	Wednesday	November	Q4	2010	f
475	2010-11-18	Thursday	November	Q4	2010	f
476	2010-11-19	Friday	November	Q4	2010	f
477	2010-11-22	Monday	November	Q4	2010	f
478	2010-11-23	Tuesday	November	Q4	2010	f
479	2010-11-24	Wednesday	November	Q4	2010	f
480	2010-11-26	Friday	November	Q4	2010	f
481	2010-11-29	Monday	November	Q4	2010	f
482	2010-11-30	Tuesday	November	Q4	2010	f
483	2010-12-01	Wednesday	December	Q4	2010	f
484	2010-12-02	Thursday	December	Q4	2010	f
485	2010-12-03	Friday	December	Q4	2010	f
486	2010-12-06	Monday	December	Q4	2010	f
487	2010-12-07	Tuesday	December	Q4	2010	f
488	2010-12-08	Wednesday	December	Q4	2010	f
489	2010-12-09	Thursday	December	Q4	2010	f
490	2010-12-10	Friday	December	Q4	2010	f
491	2010-12-13	Monday	December	Q4	2010	f
492	2010-12-14	Tuesday	December	Q4	2010	f
493	2010-12-15	Wednesday	December	Q4	2010	f
494	2010-12-16	Thursday	December	Q4	2010	f
495	2010-12-17	Friday	December	Q4	2010	f
496	2010-12-20	Monday	December	Q4	2010	f
497	2010-12-21	Tuesday	December	Q4	2010	f
498	2010-12-22	Wednesday	December	Q4	2010	f
499	2010-12-23	Thursday	December	Q4	2010	f
500	2010-12-27	Monday	December	Q4	2010	f
501	2010-12-28	Tuesday	December	Q4	2010	f
502	2010-12-29	Wednesday	December	Q4	2010	f
503	2010-12-30	Thursday	December	Q4	2010	f
504	2010-12-31	Friday	December	Q4	2010	f
505	2011-01-03	Monday	January	Q1	2011	f
506	2011-01-04	Tuesday	January	Q1	2011	f
507	2011-01-05	Wednesday	January	Q1	2011	f
508	2011-01-06	Thursday	January	Q1	2011	f
509	2011-01-07	Friday	January	Q1	2011	f
510	2011-01-10	Monday	January	Q1	2011	f
511	2011-01-11	Tuesday	January	Q1	2011	f
512	2011-01-12	Wednesday	January	Q1	2011	f
513	2011-01-13	Thursday	January	Q1	2011	f
514	2011-01-14	Friday	January	Q1	2011	f
515	2011-01-18	Tuesday	January	Q1	2011	f
516	2011-01-19	Wednesday	January	Q1	2011	f
517	2011-01-20	Thursday	January	Q1	2011	f
518	2011-01-21	Friday	January	Q1	2011	f
519	2011-01-24	Monday	January	Q1	2011	f
520	2011-01-25	Tuesday	January	Q1	2011	f
521	2011-01-26	Wednesday	January	Q1	2011	f
522	2011-01-27	Thursday	January	Q1	2011	f
523	2011-01-28	Friday	January	Q1	2011	f
524	2011-01-31	Monday	January	Q1	2011	f
525	2011-02-01	Tuesday	February	Q1	2011	f
526	2011-02-02	Wednesday	February	Q1	2011	f
527	2011-02-03	Thursday	February	Q1	2011	f
528	2011-02-04	Friday	February	Q1	2011	f
529	2011-02-07	Monday	February	Q1	2011	f
530	2011-02-08	Tuesday	February	Q1	2011	f
531	2011-02-09	Wednesday	February	Q1	2011	f
532	2011-02-10	Thursday	February	Q1	2011	f
533	2011-02-11	Friday	February	Q1	2011	f
534	2011-02-14	Monday	February	Q1	2011	f
535	2011-02-15	Tuesday	February	Q1	2011	f
536	2011-02-16	Wednesday	February	Q1	2011	f
537	2011-02-17	Thursday	February	Q1	2011	f
538	2011-02-18	Friday	February	Q1	2011	f
539	2011-02-22	Tuesday	February	Q1	2011	f
540	2011-02-23	Wednesday	February	Q1	2011	f
541	2011-02-24	Thursday	February	Q1	2011	f
542	2011-02-25	Friday	February	Q1	2011	f
543	2011-02-28	Monday	February	Q1	2011	f
544	2011-03-01	Tuesday	March	Q1	2011	f
545	2011-03-02	Wednesday	March	Q1	2011	f
546	2011-03-03	Thursday	March	Q1	2011	f
547	2011-03-04	Friday	March	Q1	2011	f
548	2011-03-07	Monday	March	Q1	2011	f
549	2011-03-08	Tuesday	March	Q1	2011	f
550	2011-03-09	Wednesday	March	Q1	2011	f
551	2011-03-10	Thursday	March	Q1	2011	f
552	2011-03-11	Friday	March	Q1	2011	f
553	2011-03-14	Monday	March	Q1	2011	f
554	2011-03-15	Tuesday	March	Q1	2011	f
555	2011-03-16	Wednesday	March	Q1	2011	f
556	2011-03-17	Thursday	March	Q1	2011	f
557	2011-03-18	Friday	March	Q1	2011	f
558	2011-03-21	Monday	March	Q1	2011	f
559	2011-03-22	Tuesday	March	Q1	2011	f
560	2011-03-23	Wednesday	March	Q1	2011	f
561	2011-03-24	Thursday	March	Q1	2011	f
562	2011-03-25	Friday	March	Q1	2011	f
563	2011-03-28	Monday	March	Q1	2011	f
564	2011-03-29	Tuesday	March	Q1	2011	f
565	2011-03-30	Wednesday	March	Q1	2011	f
566	2011-03-31	Thursday	March	Q1	2011	f
567	2011-04-01	Friday	April	Q2	2011	f
568	2011-04-04	Monday	April	Q2	2011	f
569	2011-04-05	Tuesday	April	Q2	2011	f
570	2011-04-06	Wednesday	April	Q2	2011	f
571	2011-04-07	Thursday	April	Q2	2011	f
572	2011-04-08	Friday	April	Q2	2011	f
573	2011-04-11	Monday	April	Q2	2011	f
574	2011-04-12	Tuesday	April	Q2	2011	f
575	2011-04-13	Wednesday	April	Q2	2011	f
576	2011-04-14	Thursday	April	Q2	2011	f
577	2011-04-15	Friday	April	Q2	2011	f
578	2011-04-18	Monday	April	Q2	2011	f
579	2011-04-19	Tuesday	April	Q2	2011	f
580	2011-04-20	Wednesday	April	Q2	2011	f
581	2011-04-21	Thursday	April	Q2	2011	f
582	2011-04-25	Monday	April	Q2	2011	f
583	2011-04-26	Tuesday	April	Q2	2011	f
584	2011-04-27	Wednesday	April	Q2	2011	f
585	2011-04-28	Thursday	April	Q2	2011	f
586	2011-04-29	Friday	April	Q2	2011	f
587	2011-05-02	Monday	May	Q2	2011	f
588	2011-05-03	Tuesday	May	Q2	2011	f
589	2011-05-04	Wednesday	May	Q2	2011	f
590	2011-05-05	Thursday	May	Q2	2011	f
591	2011-05-06	Friday	May	Q2	2011	f
592	2011-05-09	Monday	May	Q2	2011	f
593	2011-05-10	Tuesday	May	Q2	2011	f
594	2011-05-11	Wednesday	May	Q2	2011	f
595	2011-05-12	Thursday	May	Q2	2011	f
596	2011-05-13	Friday	May	Q2	2011	f
597	2011-05-16	Monday	May	Q2	2011	f
598	2011-05-17	Tuesday	May	Q2	2011	f
599	2011-05-18	Wednesday	May	Q2	2011	f
600	2011-05-19	Thursday	May	Q2	2011	f
601	2011-05-20	Friday	May	Q2	2011	f
602	2011-05-23	Monday	May	Q2	2011	f
603	2011-05-24	Tuesday	May	Q2	2011	f
604	2011-05-25	Wednesday	May	Q2	2011	f
605	2011-05-26	Thursday	May	Q2	2011	f
606	2011-05-27	Friday	May	Q2	2011	f
607	2011-05-31	Tuesday	May	Q2	2011	f
608	2011-06-01	Wednesday	June	Q2	2011	f
609	2011-06-02	Thursday	June	Q2	2011	f
610	2011-06-03	Friday	June	Q2	2011	f
611	2011-06-06	Monday	June	Q2	2011	f
612	2011-06-07	Tuesday	June	Q2	2011	f
613	2011-06-08	Wednesday	June	Q2	2011	f
614	2011-06-09	Thursday	June	Q2	2011	f
615	2011-06-10	Friday	June	Q2	2011	f
616	2011-06-13	Monday	June	Q2	2011	f
617	2011-06-14	Tuesday	June	Q2	2011	f
618	2011-06-15	Wednesday	June	Q2	2011	f
619	2011-06-16	Thursday	June	Q2	2011	f
620	2011-06-17	Friday	June	Q2	2011	f
621	2011-06-20	Monday	June	Q2	2011	f
622	2011-06-21	Tuesday	June	Q2	2011	f
623	2011-06-22	Wednesday	June	Q2	2011	f
624	2011-06-23	Thursday	June	Q2	2011	f
625	2011-06-24	Friday	June	Q2	2011	f
626	2011-06-27	Monday	June	Q2	2011	f
627	2011-06-28	Tuesday	June	Q2	2011	f
628	2011-06-29	Wednesday	June	Q2	2011	f
629	2011-06-30	Thursday	June	Q2	2011	f
630	2011-07-01	Friday	July	Q3	2011	f
631	2011-07-05	Tuesday	July	Q3	2011	f
632	2011-07-06	Wednesday	July	Q3	2011	f
633	2011-07-07	Thursday	July	Q3	2011	f
634	2011-07-08	Friday	July	Q3	2011	f
635	2011-07-11	Monday	July	Q3	2011	f
636	2011-07-12	Tuesday	July	Q3	2011	f
637	2011-07-13	Wednesday	July	Q3	2011	f
638	2011-07-14	Thursday	July	Q3	2011	f
639	2011-07-15	Friday	July	Q3	2011	f
640	2011-07-18	Monday	July	Q3	2011	f
641	2011-07-19	Tuesday	July	Q3	2011	f
642	2011-07-20	Wednesday	July	Q3	2011	f
643	2011-07-21	Thursday	July	Q3	2011	f
644	2011-07-22	Friday	July	Q3	2011	f
645	2011-07-25	Monday	July	Q3	2011	f
646	2011-07-26	Tuesday	July	Q3	2011	f
647	2011-07-27	Wednesday	July	Q3	2011	f
648	2011-07-28	Thursday	July	Q3	2011	f
649	2011-07-29	Friday	July	Q3	2011	f
650	2011-08-01	Monday	August	Q3	2011	f
651	2011-08-02	Tuesday	August	Q3	2011	f
652	2011-08-03	Wednesday	August	Q3	2011	f
653	2011-08-04	Thursday	August	Q3	2011	f
654	2011-08-05	Friday	August	Q3	2011	f
655	2011-08-08	Monday	August	Q3	2011	f
656	2011-08-09	Tuesday	August	Q3	2011	f
657	2011-08-10	Wednesday	August	Q3	2011	f
658	2011-08-11	Thursday	August	Q3	2011	f
659	2011-08-12	Friday	August	Q3	2011	f
660	2011-08-15	Monday	August	Q3	2011	f
661	2011-08-16	Tuesday	August	Q3	2011	f
662	2011-08-17	Wednesday	August	Q3	2011	f
663	2011-08-18	Thursday	August	Q3	2011	f
664	2011-08-19	Friday	August	Q3	2011	f
665	2011-08-22	Monday	August	Q3	2011	f
666	2011-08-23	Tuesday	August	Q3	2011	f
667	2011-08-24	Wednesday	August	Q3	2011	f
668	2011-08-25	Thursday	August	Q3	2011	f
669	2011-08-26	Friday	August	Q3	2011	f
670	2011-08-29	Monday	August	Q3	2011	f
671	2011-08-30	Tuesday	August	Q3	2011	f
672	2011-08-31	Wednesday	August	Q3	2011	f
673	2011-09-01	Thursday	September	Q3	2011	f
674	2011-09-02	Friday	September	Q3	2011	f
675	2011-09-06	Tuesday	September	Q3	2011	f
676	2011-09-07	Wednesday	September	Q3	2011	f
677	2011-09-08	Thursday	September	Q3	2011	f
678	2011-09-09	Friday	September	Q3	2011	f
679	2011-09-12	Monday	September	Q3	2011	f
680	2011-09-13	Tuesday	September	Q3	2011	f
681	2011-09-14	Wednesday	September	Q3	2011	f
682	2011-09-15	Thursday	September	Q3	2011	f
683	2011-09-16	Friday	September	Q3	2011	f
684	2011-09-19	Monday	September	Q3	2011	f
685	2011-09-20	Tuesday	September	Q3	2011	f
686	2011-09-21	Wednesday	September	Q3	2011	f
687	2011-09-22	Thursday	September	Q3	2011	f
688	2011-09-23	Friday	September	Q3	2011	f
689	2011-09-26	Monday	September	Q3	2011	f
690	2011-09-27	Tuesday	September	Q3	2011	f
691	2011-09-28	Wednesday	September	Q3	2011	f
692	2011-09-29	Thursday	September	Q3	2011	f
693	2011-09-30	Friday	September	Q3	2011	f
694	2011-10-03	Monday	October	Q4	2011	f
695	2011-10-04	Tuesday	October	Q4	2011	f
696	2011-10-05	Wednesday	October	Q4	2011	f
697	2011-10-06	Thursday	October	Q4	2011	f
698	2011-10-07	Friday	October	Q4	2011	f
699	2011-10-10	Monday	October	Q4	2011	f
700	2011-10-11	Tuesday	October	Q4	2011	f
701	2011-10-12	Wednesday	October	Q4	2011	f
702	2011-10-13	Thursday	October	Q4	2011	f
703	2011-10-14	Friday	October	Q4	2011	f
704	2011-10-17	Monday	October	Q4	2011	f
705	2011-10-18	Tuesday	October	Q4	2011	f
706	2011-10-19	Wednesday	October	Q4	2011	f
707	2011-10-20	Thursday	October	Q4	2011	f
708	2011-10-21	Friday	October	Q4	2011	f
709	2011-10-24	Monday	October	Q4	2011	f
710	2011-10-25	Tuesday	October	Q4	2011	f
711	2011-10-26	Wednesday	October	Q4	2011	f
712	2011-10-27	Thursday	October	Q4	2011	f
713	2011-10-28	Friday	October	Q4	2011	f
714	2011-10-31	Monday	October	Q4	2011	f
715	2011-11-01	Tuesday	November	Q4	2011	f
716	2011-11-02	Wednesday	November	Q4	2011	f
717	2011-11-03	Thursday	November	Q4	2011	f
718	2011-11-04	Friday	November	Q4	2011	f
719	2011-11-07	Monday	November	Q4	2011	f
720	2011-11-08	Tuesday	November	Q4	2011	f
721	2011-11-09	Wednesday	November	Q4	2011	f
722	2011-11-10	Thursday	November	Q4	2011	f
723	2011-11-11	Friday	November	Q4	2011	f
724	2011-11-14	Monday	November	Q4	2011	f
725	2011-11-15	Tuesday	November	Q4	2011	f
726	2011-11-16	Wednesday	November	Q4	2011	f
727	2011-11-17	Thursday	November	Q4	2011	f
728	2011-11-18	Friday	November	Q4	2011	f
729	2011-11-21	Monday	November	Q4	2011	f
730	2011-11-22	Tuesday	November	Q4	2011	f
731	2011-11-23	Wednesday	November	Q4	2011	f
732	2011-11-25	Friday	November	Q4	2011	f
733	2011-11-28	Monday	November	Q4	2011	f
734	2011-11-29	Tuesday	November	Q4	2011	f
735	2011-11-30	Wednesday	November	Q4	2011	f
736	2011-12-01	Thursday	December	Q4	2011	f
737	2011-12-02	Friday	December	Q4	2011	f
738	2011-12-05	Monday	December	Q4	2011	f
739	2011-12-06	Tuesday	December	Q4	2011	f
740	2011-12-07	Wednesday	December	Q4	2011	f
741	2011-12-08	Thursday	December	Q4	2011	f
742	2011-12-09	Friday	December	Q4	2011	f
743	2011-12-12	Monday	December	Q4	2011	f
744	2011-12-13	Tuesday	December	Q4	2011	f
745	2011-12-14	Wednesday	December	Q4	2011	f
746	2011-12-15	Thursday	December	Q4	2011	f
747	2011-12-16	Friday	December	Q4	2011	f
748	2011-12-19	Monday	December	Q4	2011	f
749	2011-12-20	Tuesday	December	Q4	2011	f
750	2011-12-21	Wednesday	December	Q4	2011	f
751	2011-12-22	Thursday	December	Q4	2011	f
752	2011-12-23	Friday	December	Q4	2011	f
753	2011-12-27	Tuesday	December	Q4	2011	f
754	2011-12-28	Wednesday	December	Q4	2011	f
755	2011-12-29	Thursday	December	Q4	2011	f
756	2011-12-30	Friday	December	Q4	2011	f
757	2012-01-03	Tuesday	January	Q1	2012	f
758	2012-01-04	Wednesday	January	Q1	2012	f
759	2012-01-05	Thursday	January	Q1	2012	f
760	2012-01-06	Friday	January	Q1	2012	f
761	2012-01-09	Monday	January	Q1	2012	f
762	2012-01-10	Tuesday	January	Q1	2012	f
763	2012-01-11	Wednesday	January	Q1	2012	f
764	2012-01-12	Thursday	January	Q1	2012	f
765	2012-01-13	Friday	January	Q1	2012	f
766	2012-01-17	Tuesday	January	Q1	2012	f
767	2012-01-18	Wednesday	January	Q1	2012	f
768	2012-01-19	Thursday	January	Q1	2012	f
769	2012-01-20	Friday	January	Q1	2012	f
770	2012-01-23	Monday	January	Q1	2012	f
771	2012-01-24	Tuesday	January	Q1	2012	f
772	2012-01-25	Wednesday	January	Q1	2012	f
773	2012-01-26	Thursday	January	Q1	2012	f
774	2012-01-27	Friday	January	Q1	2012	f
775	2012-01-30	Monday	January	Q1	2012	f
776	2012-01-31	Tuesday	January	Q1	2012	f
777	2012-02-01	Wednesday	February	Q1	2012	f
778	2012-02-02	Thursday	February	Q1	2012	f
779	2012-02-03	Friday	February	Q1	2012	f
780	2012-02-06	Monday	February	Q1	2012	f
781	2012-02-07	Tuesday	February	Q1	2012	f
782	2012-02-08	Wednesday	February	Q1	2012	f
783	2012-02-09	Thursday	February	Q1	2012	f
784	2012-02-10	Friday	February	Q1	2012	f
785	2012-02-13	Monday	February	Q1	2012	f
786	2012-02-14	Tuesday	February	Q1	2012	f
787	2012-02-15	Wednesday	February	Q1	2012	f
788	2012-02-16	Thursday	February	Q1	2012	f
789	2012-02-17	Friday	February	Q1	2012	f
790	2012-02-21	Tuesday	February	Q1	2012	f
791	2012-02-22	Wednesday	February	Q1	2012	f
792	2012-02-23	Thursday	February	Q1	2012	f
793	2012-02-24	Friday	February	Q1	2012	f
794	2012-02-27	Monday	February	Q1	2012	f
795	2012-02-28	Tuesday	February	Q1	2012	f
796	2012-02-29	Wednesday	February	Q1	2012	f
797	2012-03-01	Thursday	March	Q1	2012	f
798	2012-03-02	Friday	March	Q1	2012	f
799	2012-03-05	Monday	March	Q1	2012	f
800	2012-03-06	Tuesday	March	Q1	2012	f
801	2012-03-07	Wednesday	March	Q1	2012	f
802	2012-03-08	Thursday	March	Q1	2012	f
803	2012-03-09	Friday	March	Q1	2012	f
804	2012-03-12	Monday	March	Q1	2012	f
805	2012-03-13	Tuesday	March	Q1	2012	f
806	2012-03-14	Wednesday	March	Q1	2012	f
807	2012-03-15	Thursday	March	Q1	2012	f
808	2012-03-16	Friday	March	Q1	2012	f
809	2012-03-19	Monday	March	Q1	2012	f
810	2012-03-20	Tuesday	March	Q1	2012	f
811	2012-03-21	Wednesday	March	Q1	2012	f
812	2012-03-22	Thursday	March	Q1	2012	f
813	2012-03-23	Friday	March	Q1	2012	f
814	2012-03-26	Monday	March	Q1	2012	f
815	2012-03-27	Tuesday	March	Q1	2012	f
816	2012-03-28	Wednesday	March	Q1	2012	f
817	2012-03-29	Thursday	March	Q1	2012	f
818	2012-03-30	Friday	March	Q1	2012	f
819	2012-04-02	Monday	April	Q2	2012	f
820	2012-04-03	Tuesday	April	Q2	2012	f
821	2012-04-04	Wednesday	April	Q2	2012	f
822	2012-04-05	Thursday	April	Q2	2012	f
823	2012-04-09	Monday	April	Q2	2012	f
824	2012-04-10	Tuesday	April	Q2	2012	f
825	2012-04-11	Wednesday	April	Q2	2012	f
826	2012-04-12	Thursday	April	Q2	2012	f
827	2012-04-13	Friday	April	Q2	2012	f
828	2012-04-16	Monday	April	Q2	2012	f
829	2012-04-17	Tuesday	April	Q2	2012	f
830	2012-04-18	Wednesday	April	Q2	2012	f
831	2012-04-19	Thursday	April	Q2	2012	f
832	2012-04-20	Friday	April	Q2	2012	f
833	2012-04-23	Monday	April	Q2	2012	f
834	2012-04-24	Tuesday	April	Q2	2012	f
835	2012-04-25	Wednesday	April	Q2	2012	f
836	2012-04-26	Thursday	April	Q2	2012	f
837	2012-04-27	Friday	April	Q2	2012	f
838	2012-04-30	Monday	April	Q2	2012	f
839	2012-05-01	Tuesday	May	Q2	2012	f
840	2012-05-02	Wednesday	May	Q2	2012	f
841	2012-05-03	Thursday	May	Q2	2012	f
842	2012-05-04	Friday	May	Q2	2012	f
843	2012-05-07	Monday	May	Q2	2012	f
844	2012-05-08	Tuesday	May	Q2	2012	f
845	2012-05-09	Wednesday	May	Q2	2012	f
846	2012-05-10	Thursday	May	Q2	2012	f
847	2012-05-11	Friday	May	Q2	2012	f
848	2012-05-14	Monday	May	Q2	2012	f
849	2012-05-15	Tuesday	May	Q2	2012	f
850	2012-05-16	Wednesday	May	Q2	2012	f
851	2012-05-17	Thursday	May	Q2	2012	f
852	2012-05-18	Friday	May	Q2	2012	f
853	2012-05-21	Monday	May	Q2	2012	f
854	2012-05-22	Tuesday	May	Q2	2012	f
855	2012-05-23	Wednesday	May	Q2	2012	f
856	2012-05-24	Thursday	May	Q2	2012	f
857	2012-05-25	Friday	May	Q2	2012	f
858	2012-05-29	Tuesday	May	Q2	2012	f
859	2012-05-30	Wednesday	May	Q2	2012	f
860	2012-05-31	Thursday	May	Q2	2012	f
861	2012-06-01	Friday	June	Q2	2012	f
862	2012-06-04	Monday	June	Q2	2012	f
863	2012-06-05	Tuesday	June	Q2	2012	f
864	2012-06-06	Wednesday	June	Q2	2012	f
865	2012-06-07	Thursday	June	Q2	2012	f
866	2012-06-08	Friday	June	Q2	2012	f
867	2012-06-11	Monday	June	Q2	2012	f
868	2012-06-12	Tuesday	June	Q2	2012	f
869	2012-06-13	Wednesday	June	Q2	2012	f
870	2012-06-14	Thursday	June	Q2	2012	f
871	2012-06-15	Friday	June	Q2	2012	f
872	2012-06-18	Monday	June	Q2	2012	f
873	2012-06-19	Tuesday	June	Q2	2012	f
874	2012-06-20	Wednesday	June	Q2	2012	f
875	2012-06-21	Thursday	June	Q2	2012	f
876	2012-06-22	Friday	June	Q2	2012	f
877	2012-06-25	Monday	June	Q2	2012	f
878	2012-06-26	Tuesday	June	Q2	2012	f
879	2012-06-27	Wednesday	June	Q2	2012	f
880	2012-06-28	Thursday	June	Q2	2012	f
881	2012-06-29	Friday	June	Q2	2012	f
882	2012-07-02	Monday	July	Q3	2012	f
883	2012-07-03	Tuesday	July	Q3	2012	f
884	2012-07-05	Thursday	July	Q3	2012	f
885	2012-07-06	Friday	July	Q3	2012	f
886	2012-07-09	Monday	July	Q3	2012	f
887	2012-07-10	Tuesday	July	Q3	2012	f
888	2012-07-11	Wednesday	July	Q3	2012	f
889	2012-07-12	Thursday	July	Q3	2012	f
890	2012-07-13	Friday	July	Q3	2012	f
891	2012-07-16	Monday	July	Q3	2012	f
892	2012-07-17	Tuesday	July	Q3	2012	f
893	2012-07-18	Wednesday	July	Q3	2012	f
894	2012-07-19	Thursday	July	Q3	2012	f
895	2012-07-20	Friday	July	Q3	2012	f
896	2012-07-23	Monday	July	Q3	2012	f
897	2012-07-24	Tuesday	July	Q3	2012	f
898	2012-07-25	Wednesday	July	Q3	2012	f
899	2012-07-26	Thursday	July	Q3	2012	f
900	2012-07-27	Friday	July	Q3	2012	f
901	2012-07-30	Monday	July	Q3	2012	f
902	2012-07-31	Tuesday	July	Q3	2012	f
903	2012-08-01	Wednesday	August	Q3	2012	f
904	2012-08-02	Thursday	August	Q3	2012	f
905	2012-08-03	Friday	August	Q3	2012	f
906	2012-08-06	Monday	August	Q3	2012	f
907	2012-08-07	Tuesday	August	Q3	2012	f
908	2012-08-08	Wednesday	August	Q3	2012	f
909	2012-08-09	Thursday	August	Q3	2012	f
910	2012-08-10	Friday	August	Q3	2012	f
911	2012-08-13	Monday	August	Q3	2012	f
912	2012-08-14	Tuesday	August	Q3	2012	f
913	2012-08-15	Wednesday	August	Q3	2012	f
914	2012-08-16	Thursday	August	Q3	2012	f
915	2012-08-17	Friday	August	Q3	2012	f
916	2012-08-20	Monday	August	Q3	2012	f
917	2012-08-21	Tuesday	August	Q3	2012	f
918	2012-08-22	Wednesday	August	Q3	2012	f
919	2012-08-23	Thursday	August	Q3	2012	f
920	2012-08-24	Friday	August	Q3	2012	f
921	2012-08-27	Monday	August	Q3	2012	f
922	2012-08-28	Tuesday	August	Q3	2012	f
923	2012-08-29	Wednesday	August	Q3	2012	f
924	2012-08-30	Thursday	August	Q3	2012	f
925	2012-08-31	Friday	August	Q3	2012	f
926	2012-09-04	Tuesday	September	Q3	2012	f
927	2012-09-05	Wednesday	September	Q3	2012	f
928	2012-09-06	Thursday	September	Q3	2012	f
929	2012-09-07	Friday	September	Q3	2012	f
930	2012-09-10	Monday	September	Q3	2012	f
931	2012-09-11	Tuesday	September	Q3	2012	f
932	2012-09-12	Wednesday	September	Q3	2012	f
933	2012-09-13	Thursday	September	Q3	2012	f
934	2012-09-14	Friday	September	Q3	2012	f
935	2012-09-17	Monday	September	Q3	2012	f
936	2012-09-18	Tuesday	September	Q3	2012	f
937	2012-09-19	Wednesday	September	Q3	2012	f
938	2012-09-20	Thursday	September	Q3	2012	f
939	2012-09-21	Friday	September	Q3	2012	f
940	2012-09-24	Monday	September	Q3	2012	f
941	2012-09-25	Tuesday	September	Q3	2012	f
942	2012-09-26	Wednesday	September	Q3	2012	f
943	2012-09-27	Thursday	September	Q3	2012	f
944	2012-09-28	Friday	September	Q3	2012	f
945	2012-10-01	Monday	October	Q4	2012	f
946	2012-10-02	Tuesday	October	Q4	2012	f
947	2012-10-03	Wednesday	October	Q4	2012	f
948	2012-10-04	Thursday	October	Q4	2012	f
949	2012-10-05	Friday	October	Q4	2012	f
950	2012-10-08	Monday	October	Q4	2012	f
951	2012-10-09	Tuesday	October	Q4	2012	f
952	2012-10-10	Wednesday	October	Q4	2012	f
953	2012-10-11	Thursday	October	Q4	2012	f
954	2012-10-12	Friday	October	Q4	2012	f
955	2012-10-15	Monday	October	Q4	2012	f
956	2012-10-16	Tuesday	October	Q4	2012	f
957	2012-10-17	Wednesday	October	Q4	2012	f
958	2012-10-18	Thursday	October	Q4	2012	f
959	2012-10-19	Friday	October	Q4	2012	f
960	2012-10-22	Monday	October	Q4	2012	f
961	2012-10-23	Tuesday	October	Q4	2012	f
962	2012-10-24	Wednesday	October	Q4	2012	f
963	2012-10-25	Thursday	October	Q4	2012	f
964	2012-10-26	Friday	October	Q4	2012	f
965	2012-10-31	Wednesday	October	Q4	2012	f
966	2012-11-01	Thursday	November	Q4	2012	f
967	2012-11-02	Friday	November	Q4	2012	f
968	2012-11-05	Monday	November	Q4	2012	f
969	2012-11-06	Tuesday	November	Q4	2012	f
970	2012-11-07	Wednesday	November	Q4	2012	f
971	2012-11-08	Thursday	November	Q4	2012	f
972	2012-11-09	Friday	November	Q4	2012	f
973	2012-11-12	Monday	November	Q4	2012	f
974	2012-11-13	Tuesday	November	Q4	2012	f
975	2012-11-14	Wednesday	November	Q4	2012	f
976	2012-11-15	Thursday	November	Q4	2012	f
977	2012-11-16	Friday	November	Q4	2012	f
978	2012-11-19	Monday	November	Q4	2012	f
979	2012-11-20	Tuesday	November	Q4	2012	f
980	2012-11-21	Wednesday	November	Q4	2012	f
981	2012-11-23	Friday	November	Q4	2012	f
982	2012-11-26	Monday	November	Q4	2012	f
983	2012-11-27	Tuesday	November	Q4	2012	f
984	2012-11-28	Wednesday	November	Q4	2012	f
985	2012-11-29	Thursday	November	Q4	2012	f
986	2012-11-30	Friday	November	Q4	2012	f
987	2012-12-03	Monday	December	Q4	2012	f
988	2012-12-04	Tuesday	December	Q4	2012	f
989	2012-12-05	Wednesday	December	Q4	2012	f
990	2012-12-06	Thursday	December	Q4	2012	f
991	2012-12-07	Friday	December	Q4	2012	f
992	2012-12-10	Monday	December	Q4	2012	f
993	2012-12-11	Tuesday	December	Q4	2012	f
994	2012-12-12	Wednesday	December	Q4	2012	f
995	2012-12-13	Thursday	December	Q4	2012	f
996	2012-12-14	Friday	December	Q4	2012	f
997	2012-12-17	Monday	December	Q4	2012	f
998	2012-12-18	Tuesday	December	Q4	2012	f
999	2012-12-19	Wednesday	December	Q4	2012	f
1000	2012-12-20	Thursday	December	Q4	2012	f
1001	2012-12-21	Friday	December	Q4	2012	f
1002	2012-12-24	Monday	December	Q4	2012	f
1003	2012-12-26	Wednesday	December	Q4	2012	f
1004	2012-12-27	Thursday	December	Q4	2012	f
1005	2012-12-28	Friday	December	Q4	2012	f
1006	2012-12-31	Monday	December	Q4	2012	f
1007	2013-01-02	Wednesday	January	Q1	2013	f
1008	2013-01-03	Thursday	January	Q1	2013	f
1009	2013-01-04	Friday	January	Q1	2013	f
1010	2013-01-07	Monday	January	Q1	2013	f
1011	2013-01-08	Tuesday	January	Q1	2013	f
1012	2013-01-09	Wednesday	January	Q1	2013	f
1013	2013-01-10	Thursday	January	Q1	2013	f
1014	2013-01-11	Friday	January	Q1	2013	f
1015	2013-01-14	Monday	January	Q1	2013	f
1016	2013-01-15	Tuesday	January	Q1	2013	f
1017	2013-01-16	Wednesday	January	Q1	2013	f
1018	2013-01-17	Thursday	January	Q1	2013	f
1019	2013-01-18	Friday	January	Q1	2013	f
1020	2013-01-22	Tuesday	January	Q1	2013	f
1021	2013-01-23	Wednesday	January	Q1	2013	f
1022	2013-01-24	Thursday	January	Q1	2013	f
1023	2013-01-25	Friday	January	Q1	2013	f
1024	2013-01-28	Monday	January	Q1	2013	f
1025	2013-01-29	Tuesday	January	Q1	2013	f
1026	2013-01-30	Wednesday	January	Q1	2013	f
1027	2013-01-31	Thursday	January	Q1	2013	f
1028	2013-02-01	Friday	February	Q1	2013	f
1029	2013-02-04	Monday	February	Q1	2013	f
1030	2013-02-05	Tuesday	February	Q1	2013	f
1031	2013-02-06	Wednesday	February	Q1	2013	f
1032	2013-02-07	Thursday	February	Q1	2013	f
1033	2013-02-08	Friday	February	Q1	2013	f
1034	2013-02-11	Monday	February	Q1	2013	f
1035	2013-02-12	Tuesday	February	Q1	2013	f
1036	2013-02-13	Wednesday	February	Q1	2013	f
1037	2013-02-14	Thursday	February	Q1	2013	f
1038	2013-02-15	Friday	February	Q1	2013	f
1039	2013-02-19	Tuesday	February	Q1	2013	f
1040	2013-02-20	Wednesday	February	Q1	2013	f
1041	2013-02-21	Thursday	February	Q1	2013	f
1042	2013-02-22	Friday	February	Q1	2013	f
1043	2013-02-25	Monday	February	Q1	2013	f
1044	2013-02-26	Tuesday	February	Q1	2013	f
1045	2013-02-27	Wednesday	February	Q1	2013	f
1046	2013-02-28	Thursday	February	Q1	2013	f
1047	2013-03-01	Friday	March	Q1	2013	f
1048	2013-03-04	Monday	March	Q1	2013	f
1049	2013-03-05	Tuesday	March	Q1	2013	f
1050	2013-03-06	Wednesday	March	Q1	2013	f
1051	2013-03-07	Thursday	March	Q1	2013	f
1052	2013-03-08	Friday	March	Q1	2013	f
1053	2013-03-11	Monday	March	Q1	2013	f
1054	2013-03-12	Tuesday	March	Q1	2013	f
1055	2013-03-13	Wednesday	March	Q1	2013	f
1056	2013-03-14	Thursday	March	Q1	2013	f
1057	2013-03-15	Friday	March	Q1	2013	f
1058	2013-03-18	Monday	March	Q1	2013	f
1059	2013-03-19	Tuesday	March	Q1	2013	f
1060	2013-03-20	Wednesday	March	Q1	2013	f
1061	2013-03-21	Thursday	March	Q1	2013	f
1062	2013-03-22	Friday	March	Q1	2013	f
1063	2013-03-25	Monday	March	Q1	2013	f
1064	2013-03-26	Tuesday	March	Q1	2013	f
1065	2013-03-27	Wednesday	March	Q1	2013	f
1066	2013-03-28	Thursday	March	Q1	2013	f
1067	2013-04-01	Monday	April	Q2	2013	f
1068	2013-04-02	Tuesday	April	Q2	2013	f
1069	2013-04-03	Wednesday	April	Q2	2013	f
1070	2013-04-04	Thursday	April	Q2	2013	f
1071	2013-04-05	Friday	April	Q2	2013	f
1072	2013-04-08	Monday	April	Q2	2013	f
1073	2013-04-09	Tuesday	April	Q2	2013	f
1074	2013-04-10	Wednesday	April	Q2	2013	f
1075	2013-04-11	Thursday	April	Q2	2013	f
1076	2013-04-12	Friday	April	Q2	2013	f
1077	2013-04-15	Monday	April	Q2	2013	f
1078	2013-04-16	Tuesday	April	Q2	2013	f
1079	2013-04-17	Wednesday	April	Q2	2013	f
1080	2013-04-18	Thursday	April	Q2	2013	f
1081	2013-04-19	Friday	April	Q2	2013	f
1082	2013-04-22	Monday	April	Q2	2013	f
1083	2013-04-23	Tuesday	April	Q2	2013	f
1084	2013-04-24	Wednesday	April	Q2	2013	f
1085	2013-04-25	Thursday	April	Q2	2013	f
1086	2013-04-26	Friday	April	Q2	2013	f
1087	2013-04-29	Monday	April	Q2	2013	f
1088	2013-04-30	Tuesday	April	Q2	2013	f
1089	2013-05-01	Wednesday	May	Q2	2013	f
1090	2013-05-02	Thursday	May	Q2	2013	f
1091	2013-05-03	Friday	May	Q2	2013	f
1092	2013-05-06	Monday	May	Q2	2013	f
1093	2013-05-07	Tuesday	May	Q2	2013	f
1094	2013-05-08	Wednesday	May	Q2	2013	f
1095	2013-05-09	Thursday	May	Q2	2013	f
1096	2013-05-10	Friday	May	Q2	2013	f
1097	2013-05-13	Monday	May	Q2	2013	f
1098	2013-05-14	Tuesday	May	Q2	2013	f
1099	2013-05-15	Wednesday	May	Q2	2013	f
1100	2013-05-16	Thursday	May	Q2	2013	f
1101	2013-05-17	Friday	May	Q2	2013	f
1102	2013-05-20	Monday	May	Q2	2013	f
1103	2013-05-21	Tuesday	May	Q2	2013	f
1104	2013-05-22	Wednesday	May	Q2	2013	f
1105	2013-05-23	Thursday	May	Q2	2013	f
1106	2013-05-24	Friday	May	Q2	2013	f
1107	2013-05-28	Tuesday	May	Q2	2013	f
1108	2013-05-29	Wednesday	May	Q2	2013	f
1109	2013-05-30	Thursday	May	Q2	2013	f
1110	2013-05-31	Friday	May	Q2	2013	f
1111	2013-06-03	Monday	June	Q2	2013	f
1112	2013-06-04	Tuesday	June	Q2	2013	f
1113	2013-06-05	Wednesday	June	Q2	2013	f
1114	2013-06-06	Thursday	June	Q2	2013	f
1115	2013-06-07	Friday	June	Q2	2013	f
1116	2013-06-10	Monday	June	Q2	2013	f
1117	2013-06-11	Tuesday	June	Q2	2013	f
1118	2013-06-12	Wednesday	June	Q2	2013	f
1119	2013-06-13	Thursday	June	Q2	2013	f
1120	2013-06-14	Friday	June	Q2	2013	f
1121	2013-06-17	Monday	June	Q2	2013	f
1122	2013-06-18	Tuesday	June	Q2	2013	f
1123	2013-06-19	Wednesday	June	Q2	2013	f
1124	2013-06-20	Thursday	June	Q2	2013	f
1125	2013-06-21	Friday	June	Q2	2013	f
1126	2013-06-24	Monday	June	Q2	2013	f
1127	2013-06-25	Tuesday	June	Q2	2013	f
1128	2013-06-26	Wednesday	June	Q2	2013	f
1129	2013-06-27	Thursday	June	Q2	2013	f
1130	2013-06-28	Friday	June	Q2	2013	f
1131	2013-07-01	Monday	July	Q3	2013	f
1132	2013-07-02	Tuesday	July	Q3	2013	f
1133	2013-07-03	Wednesday	July	Q3	2013	f
1134	2013-07-05	Friday	July	Q3	2013	f
1135	2013-07-08	Monday	July	Q3	2013	f
1136	2013-07-09	Tuesday	July	Q3	2013	f
1137	2013-07-10	Wednesday	July	Q3	2013	f
1138	2013-07-11	Thursday	July	Q3	2013	f
1139	2013-07-12	Friday	July	Q3	2013	f
1140	2013-07-15	Monday	July	Q3	2013	f
1141	2013-07-16	Tuesday	July	Q3	2013	f
1142	2013-07-17	Wednesday	July	Q3	2013	f
1143	2013-07-18	Thursday	July	Q3	2013	f
1144	2013-07-19	Friday	July	Q3	2013	f
1145	2013-07-22	Monday	July	Q3	2013	f
1146	2013-07-23	Tuesday	July	Q3	2013	f
1147	2013-07-24	Wednesday	July	Q3	2013	f
1148	2013-07-25	Thursday	July	Q3	2013	f
1149	2013-07-26	Friday	July	Q3	2013	f
1150	2013-07-29	Monday	July	Q3	2013	f
1151	2013-07-30	Tuesday	July	Q3	2013	f
1152	2013-07-31	Wednesday	July	Q3	2013	f
1153	2013-08-01	Thursday	August	Q3	2013	f
1154	2013-08-02	Friday	August	Q3	2013	f
1155	2013-08-05	Monday	August	Q3	2013	f
1156	2013-08-06	Tuesday	August	Q3	2013	f
1157	2013-08-07	Wednesday	August	Q3	2013	f
1158	2013-08-08	Thursday	August	Q3	2013	f
1159	2013-08-09	Friday	August	Q3	2013	f
1160	2013-08-12	Monday	August	Q3	2013	f
1161	2013-08-13	Tuesday	August	Q3	2013	f
1162	2013-08-14	Wednesday	August	Q3	2013	f
1163	2013-08-15	Thursday	August	Q3	2013	f
1164	2013-08-16	Friday	August	Q3	2013	f
1165	2013-08-19	Monday	August	Q3	2013	f
1166	2013-08-20	Tuesday	August	Q3	2013	f
1167	2013-08-21	Wednesday	August	Q3	2013	f
1168	2013-08-22	Thursday	August	Q3	2013	f
1169	2013-08-23	Friday	August	Q3	2013	f
1170	2013-08-26	Monday	August	Q3	2013	f
1171	2013-08-27	Tuesday	August	Q3	2013	f
1172	2013-08-28	Wednesday	August	Q3	2013	f
1173	2013-08-29	Thursday	August	Q3	2013	f
1174	2013-08-30	Friday	August	Q3	2013	f
1175	2013-09-03	Tuesday	September	Q3	2013	f
1176	2013-09-04	Wednesday	September	Q3	2013	f
1177	2013-09-05	Thursday	September	Q3	2013	f
1178	2013-09-06	Friday	September	Q3	2013	f
1179	2013-09-09	Monday	September	Q3	2013	f
1180	2013-09-10	Tuesday	September	Q3	2013	f
1181	2013-09-11	Wednesday	September	Q3	2013	f
1182	2013-09-12	Thursday	September	Q3	2013	f
1183	2013-09-13	Friday	September	Q3	2013	f
1184	2013-09-16	Monday	September	Q3	2013	f
1185	2013-09-17	Tuesday	September	Q3	2013	f
1186	2013-09-18	Wednesday	September	Q3	2013	f
1187	2013-09-19	Thursday	September	Q3	2013	f
1188	2013-09-20	Friday	September	Q3	2013	f
1189	2013-09-23	Monday	September	Q3	2013	f
1190	2013-09-24	Tuesday	September	Q3	2013	f
1191	2013-09-25	Wednesday	September	Q3	2013	f
1192	2013-09-26	Thursday	September	Q3	2013	f
1193	2013-09-27	Friday	September	Q3	2013	f
1194	2013-09-30	Monday	September	Q3	2013	f
1195	2013-10-01	Tuesday	October	Q4	2013	f
1196	2013-10-02	Wednesday	October	Q4	2013	f
1197	2013-10-03	Thursday	October	Q4	2013	f
1198	2013-10-04	Friday	October	Q4	2013	f
1199	2013-10-07	Monday	October	Q4	2013	f
1200	2013-10-08	Tuesday	October	Q4	2013	f
1201	2013-10-09	Wednesday	October	Q4	2013	f
1202	2013-10-10	Thursday	October	Q4	2013	f
1203	2013-10-11	Friday	October	Q4	2013	f
1204	2013-10-14	Monday	October	Q4	2013	f
1205	2013-10-15	Tuesday	October	Q4	2013	f
1206	2013-10-16	Wednesday	October	Q4	2013	f
1207	2013-10-17	Thursday	October	Q4	2013	f
1208	2013-10-18	Friday	October	Q4	2013	f
1209	2013-10-21	Monday	October	Q4	2013	f
1210	2013-10-22	Tuesday	October	Q4	2013	f
1211	2013-10-23	Wednesday	October	Q4	2013	f
1212	2013-10-24	Thursday	October	Q4	2013	f
1213	2013-10-25	Friday	October	Q4	2013	f
1214	2013-10-28	Monday	October	Q4	2013	f
1215	2013-10-29	Tuesday	October	Q4	2013	f
1216	2013-10-30	Wednesday	October	Q4	2013	f
1217	2013-10-31	Thursday	October	Q4	2013	f
1218	2013-11-01	Friday	November	Q4	2013	f
1219	2013-11-04	Monday	November	Q4	2013	f
1220	2013-11-05	Tuesday	November	Q4	2013	f
1221	2013-11-06	Wednesday	November	Q4	2013	f
1222	2013-11-07	Thursday	November	Q4	2013	f
1223	2013-11-08	Friday	November	Q4	2013	f
1224	2013-11-11	Monday	November	Q4	2013	f
1225	2013-11-12	Tuesday	November	Q4	2013	f
1226	2013-11-13	Wednesday	November	Q4	2013	f
1227	2013-11-14	Thursday	November	Q4	2013	f
1228	2013-11-15	Friday	November	Q4	2013	f
1229	2013-11-18	Monday	November	Q4	2013	f
1230	2013-11-19	Tuesday	November	Q4	2013	f
1231	2013-11-20	Wednesday	November	Q4	2013	f
1232	2013-11-21	Thursday	November	Q4	2013	f
1233	2013-11-22	Friday	November	Q4	2013	f
1234	2013-11-25	Monday	November	Q4	2013	f
1235	2013-11-26	Tuesday	November	Q4	2013	f
1236	2013-11-27	Wednesday	November	Q4	2013	f
1237	2013-11-29	Friday	November	Q4	2013	f
1238	2013-12-02	Monday	December	Q4	2013	f
1239	2013-12-03	Tuesday	December	Q4	2013	f
1240	2013-12-04	Wednesday	December	Q4	2013	f
1241	2013-12-05	Thursday	December	Q4	2013	f
1242	2013-12-06	Friday	December	Q4	2013	f
1243	2013-12-09	Monday	December	Q4	2013	f
1244	2013-12-10	Tuesday	December	Q4	2013	f
1245	2013-12-11	Wednesday	December	Q4	2013	f
1246	2013-12-12	Thursday	December	Q4	2013	f
1247	2013-12-13	Friday	December	Q4	2013	f
1248	2013-12-16	Monday	December	Q4	2013	f
1249	2013-12-17	Tuesday	December	Q4	2013	f
1250	2013-12-18	Wednesday	December	Q4	2013	f
1251	2013-12-19	Thursday	December	Q4	2013	f
1252	2013-12-20	Friday	December	Q4	2013	f
1253	2013-12-23	Monday	December	Q4	2013	f
1254	2013-12-24	Tuesday	December	Q4	2013	f
1255	2013-12-26	Thursday	December	Q4	2013	f
1256	2013-12-27	Friday	December	Q4	2013	f
1257	2013-12-30	Monday	December	Q4	2013	f
1258	2013-12-31	Tuesday	December	Q4	2013	f
1259	2014-01-02	Thursday	January	Q1	2014	f
1260	2014-01-03	Friday	January	Q1	2014	f
1261	2014-01-06	Monday	January	Q1	2014	f
1262	2014-01-07	Tuesday	January	Q1	2014	f
1263	2014-01-08	Wednesday	January	Q1	2014	f
1264	2014-01-09	Thursday	January	Q1	2014	f
1265	2014-01-10	Friday	January	Q1	2014	f
1266	2014-01-13	Monday	January	Q1	2014	f
1267	2014-01-14	Tuesday	January	Q1	2014	f
1268	2014-01-15	Wednesday	January	Q1	2014	f
1269	2014-01-16	Thursday	January	Q1	2014	f
1270	2014-01-17	Friday	January	Q1	2014	f
1271	2014-01-21	Tuesday	January	Q1	2014	f
1272	2014-01-22	Wednesday	January	Q1	2014	f
1273	2014-01-23	Thursday	January	Q1	2014	f
1274	2014-01-24	Friday	January	Q1	2014	f
1275	2014-01-27	Monday	January	Q1	2014	f
1276	2014-01-28	Tuesday	January	Q1	2014	f
1277	2014-01-29	Wednesday	January	Q1	2014	f
1278	2014-01-30	Thursday	January	Q1	2014	f
1279	2014-01-31	Friday	January	Q1	2014	f
1280	2014-02-03	Monday	February	Q1	2014	f
1281	2014-02-04	Tuesday	February	Q1	2014	f
1282	2014-02-05	Wednesday	February	Q1	2014	f
1283	2014-02-06	Thursday	February	Q1	2014	f
1284	2014-02-07	Friday	February	Q1	2014	f
1285	2014-02-10	Monday	February	Q1	2014	f
1286	2014-02-11	Tuesday	February	Q1	2014	f
1287	2014-02-12	Wednesday	February	Q1	2014	f
1288	2014-02-13	Thursday	February	Q1	2014	f
1289	2014-02-14	Friday	February	Q1	2014	f
1290	2014-02-18	Tuesday	February	Q1	2014	f
1291	2014-02-19	Wednesday	February	Q1	2014	f
1292	2014-02-20	Thursday	February	Q1	2014	f
1293	2014-02-21	Friday	February	Q1	2014	f
1294	2014-02-24	Monday	February	Q1	2014	f
1295	2014-02-25	Tuesday	February	Q1	2014	f
1296	2014-02-26	Wednesday	February	Q1	2014	f
1297	2014-02-27	Thursday	February	Q1	2014	f
1298	2014-02-28	Friday	February	Q1	2014	f
1299	2014-03-03	Monday	March	Q1	2014	f
1300	2014-03-04	Tuesday	March	Q1	2014	f
1301	2014-03-05	Wednesday	March	Q1	2014	f
1302	2014-03-06	Thursday	March	Q1	2014	f
1303	2014-03-07	Friday	March	Q1	2014	f
1304	2014-03-10	Monday	March	Q1	2014	f
1305	2014-03-11	Tuesday	March	Q1	2014	f
1306	2014-03-12	Wednesday	March	Q1	2014	f
1307	2014-03-13	Thursday	March	Q1	2014	f
1308	2014-03-14	Friday	March	Q1	2014	f
1309	2014-03-17	Monday	March	Q1	2014	f
1310	2014-03-18	Tuesday	March	Q1	2014	f
1311	2014-03-19	Wednesday	March	Q1	2014	f
1312	2014-03-20	Thursday	March	Q1	2014	f
1313	2014-03-21	Friday	March	Q1	2014	f
1314	2014-03-24	Monday	March	Q1	2014	f
1315	2014-03-25	Tuesday	March	Q1	2014	f
1316	2014-03-26	Wednesday	March	Q1	2014	f
1317	2014-03-27	Thursday	March	Q1	2014	f
1318	2014-03-28	Friday	March	Q1	2014	f
1319	2014-03-31	Monday	March	Q1	2014	f
1320	2014-04-01	Tuesday	April	Q2	2014	f
1321	2014-04-02	Wednesday	April	Q2	2014	f
1322	2014-04-03	Thursday	April	Q2	2014	f
1323	2014-04-04	Friday	April	Q2	2014	f
1324	2014-04-07	Monday	April	Q2	2014	f
1325	2014-04-08	Tuesday	April	Q2	2014	f
1326	2014-04-09	Wednesday	April	Q2	2014	f
1327	2014-04-10	Thursday	April	Q2	2014	f
1328	2014-04-11	Friday	April	Q2	2014	f
1329	2014-04-14	Monday	April	Q2	2014	f
1330	2014-04-15	Tuesday	April	Q2	2014	f
1331	2014-04-16	Wednesday	April	Q2	2014	f
1332	2014-04-17	Thursday	April	Q2	2014	f
1333	2014-04-21	Monday	April	Q2	2014	f
1334	2014-04-22	Tuesday	April	Q2	2014	f
1335	2014-04-23	Wednesday	April	Q2	2014	f
1336	2014-04-24	Thursday	April	Q2	2014	f
1337	2014-04-25	Friday	April	Q2	2014	f
1338	2014-04-28	Monday	April	Q2	2014	f
1339	2014-04-29	Tuesday	April	Q2	2014	f
1340	2014-04-30	Wednesday	April	Q2	2014	f
1341	2014-05-01	Thursday	May	Q2	2014	f
1342	2014-05-02	Friday	May	Q2	2014	f
1343	2014-05-05	Monday	May	Q2	2014	f
1344	2014-05-06	Tuesday	May	Q2	2014	f
1345	2014-05-07	Wednesday	May	Q2	2014	f
1346	2014-05-08	Thursday	May	Q2	2014	f
1347	2014-05-09	Friday	May	Q2	2014	f
1348	2014-05-12	Monday	May	Q2	2014	f
1349	2014-05-13	Tuesday	May	Q2	2014	f
1350	2014-05-14	Wednesday	May	Q2	2014	f
1351	2014-05-15	Thursday	May	Q2	2014	f
1352	2014-05-16	Friday	May	Q2	2014	f
1353	2014-05-19	Monday	May	Q2	2014	f
1354	2014-05-20	Tuesday	May	Q2	2014	f
1355	2014-05-21	Wednesday	May	Q2	2014	f
1356	2014-05-22	Thursday	May	Q2	2014	f
1357	2014-05-23	Friday	May	Q2	2014	f
1358	2014-05-27	Tuesday	May	Q2	2014	f
1359	2014-05-28	Wednesday	May	Q2	2014	f
1360	2014-05-29	Thursday	May	Q2	2014	f
1361	2014-05-30	Friday	May	Q2	2014	f
1362	2014-06-02	Monday	June	Q2	2014	f
1363	2014-06-03	Tuesday	June	Q2	2014	f
1364	2014-06-04	Wednesday	June	Q2	2014	f
1365	2014-06-05	Thursday	June	Q2	2014	f
1366	2014-06-06	Friday	June	Q2	2014	f
1367	2014-06-09	Monday	June	Q2	2014	f
1368	2014-06-10	Tuesday	June	Q2	2014	f
1369	2014-06-11	Wednesday	June	Q2	2014	f
1370	2014-06-12	Thursday	June	Q2	2014	f
1371	2014-06-13	Friday	June	Q2	2014	f
1372	2014-06-16	Monday	June	Q2	2014	f
1373	2014-06-17	Tuesday	June	Q2	2014	f
1374	2014-06-18	Wednesday	June	Q2	2014	f
1375	2014-06-19	Thursday	June	Q2	2014	f
1376	2014-06-20	Friday	June	Q2	2014	f
1377	2014-06-23	Monday	June	Q2	2014	f
1378	2014-06-24	Tuesday	June	Q2	2014	f
1379	2014-06-25	Wednesday	June	Q2	2014	f
1380	2014-06-26	Thursday	June	Q2	2014	f
1381	2014-06-27	Friday	June	Q2	2014	f
1382	2014-06-30	Monday	June	Q2	2014	f
1383	2014-07-01	Tuesday	July	Q3	2014	f
1384	2014-07-02	Wednesday	July	Q3	2014	f
1385	2014-07-03	Thursday	July	Q3	2014	f
1386	2014-07-07	Monday	July	Q3	2014	f
1387	2014-07-08	Tuesday	July	Q3	2014	f
1388	2014-07-09	Wednesday	July	Q3	2014	f
1389	2014-07-10	Thursday	July	Q3	2014	f
1390	2014-07-11	Friday	July	Q3	2014	f
1391	2014-07-14	Monday	July	Q3	2014	f
1392	2014-07-15	Tuesday	July	Q3	2014	f
1393	2014-07-16	Wednesday	July	Q3	2014	f
1394	2014-07-17	Thursday	July	Q3	2014	f
1395	2014-07-18	Friday	July	Q3	2014	f
1396	2014-07-21	Monday	July	Q3	2014	f
1397	2014-07-22	Tuesday	July	Q3	2014	f
1398	2014-07-23	Wednesday	July	Q3	2014	f
1399	2014-07-24	Thursday	July	Q3	2014	f
1400	2014-07-25	Friday	July	Q3	2014	f
1401	2014-07-28	Monday	July	Q3	2014	f
1402	2014-07-29	Tuesday	July	Q3	2014	f
1403	2014-07-30	Wednesday	July	Q3	2014	f
1404	2014-07-31	Thursday	July	Q3	2014	f
1405	2014-08-01	Friday	August	Q3	2014	f
1406	2014-08-04	Monday	August	Q3	2014	f
1407	2014-08-05	Tuesday	August	Q3	2014	f
1408	2014-08-06	Wednesday	August	Q3	2014	f
1409	2014-08-07	Thursday	August	Q3	2014	f
1410	2014-08-08	Friday	August	Q3	2014	f
1411	2014-08-11	Monday	August	Q3	2014	f
1412	2014-08-12	Tuesday	August	Q3	2014	f
1413	2014-08-13	Wednesday	August	Q3	2014	f
1414	2014-08-14	Thursday	August	Q3	2014	f
1415	2014-08-15	Friday	August	Q3	2014	f
1416	2014-08-18	Monday	August	Q3	2014	f
1417	2014-08-19	Tuesday	August	Q3	2014	f
1418	2014-08-20	Wednesday	August	Q3	2014	f
1419	2014-08-21	Thursday	August	Q3	2014	f
1420	2014-08-22	Friday	August	Q3	2014	f
1421	2014-08-25	Monday	August	Q3	2014	f
1422	2014-08-26	Tuesday	August	Q3	2014	f
1423	2014-08-27	Wednesday	August	Q3	2014	f
1424	2014-08-28	Thursday	August	Q3	2014	f
1425	2014-08-29	Friday	August	Q3	2014	f
1426	2014-09-02	Tuesday	September	Q3	2014	f
1427	2014-09-03	Wednesday	September	Q3	2014	f
1428	2014-09-04	Thursday	September	Q3	2014	f
1429	2014-09-05	Friday	September	Q3	2014	f
1430	2014-09-08	Monday	September	Q3	2014	f
1431	2014-09-09	Tuesday	September	Q3	2014	f
1432	2014-09-10	Wednesday	September	Q3	2014	f
1433	2014-09-11	Thursday	September	Q3	2014	f
1434	2014-09-12	Friday	September	Q3	2014	f
1435	2014-09-15	Monday	September	Q3	2014	f
1436	2014-09-16	Tuesday	September	Q3	2014	f
1437	2014-09-17	Wednesday	September	Q3	2014	f
1438	2014-09-18	Thursday	September	Q3	2014	f
1439	2014-09-19	Friday	September	Q3	2014	f
1440	2014-09-22	Monday	September	Q3	2014	f
1441	2014-09-23	Tuesday	September	Q3	2014	f
1442	2014-09-24	Wednesday	September	Q3	2014	f
1443	2014-09-25	Thursday	September	Q3	2014	f
1444	2014-09-26	Friday	September	Q3	2014	f
1445	2014-09-29	Monday	September	Q3	2014	f
1446	2014-09-30	Tuesday	September	Q3	2014	f
1447	2014-10-01	Wednesday	October	Q4	2014	f
1448	2014-10-02	Thursday	October	Q4	2014	f
1449	2014-10-03	Friday	October	Q4	2014	f
1450	2014-10-06	Monday	October	Q4	2014	f
1451	2014-10-07	Tuesday	October	Q4	2014	f
1452	2014-10-08	Wednesday	October	Q4	2014	f
1453	2014-10-09	Thursday	October	Q4	2014	f
1454	2014-10-10	Friday	October	Q4	2014	f
1455	2014-10-13	Monday	October	Q4	2014	f
1456	2014-10-14	Tuesday	October	Q4	2014	f
1457	2014-10-15	Wednesday	October	Q4	2014	f
1458	2014-10-16	Thursday	October	Q4	2014	f
1459	2014-10-17	Friday	October	Q4	2014	f
1460	2014-10-20	Monday	October	Q4	2014	f
1461	2014-10-21	Tuesday	October	Q4	2014	f
1462	2014-10-22	Wednesday	October	Q4	2014	f
1463	2014-10-23	Thursday	October	Q4	2014	f
1464	2014-10-24	Friday	October	Q4	2014	f
1465	2014-10-27	Monday	October	Q4	2014	f
1466	2014-10-28	Tuesday	October	Q4	2014	f
1467	2014-10-29	Wednesday	October	Q4	2014	f
1468	2014-10-30	Thursday	October	Q4	2014	f
1469	2014-10-31	Friday	October	Q4	2014	f
1470	2014-11-03	Monday	November	Q4	2014	f
1471	2014-11-04	Tuesday	November	Q4	2014	f
1472	2014-11-05	Wednesday	November	Q4	2014	f
1473	2014-11-06	Thursday	November	Q4	2014	f
1474	2014-11-07	Friday	November	Q4	2014	f
1475	2014-11-10	Monday	November	Q4	2014	f
1476	2014-11-11	Tuesday	November	Q4	2014	f
1477	2014-11-12	Wednesday	November	Q4	2014	f
1478	2014-11-13	Thursday	November	Q4	2014	f
1479	2014-11-14	Friday	November	Q4	2014	f
1480	2014-11-17	Monday	November	Q4	2014	f
1481	2014-11-18	Tuesday	November	Q4	2014	f
1482	2014-11-19	Wednesday	November	Q4	2014	f
1483	2014-11-20	Thursday	November	Q4	2014	f
1484	2014-11-21	Friday	November	Q4	2014	f
1485	2014-11-24	Monday	November	Q4	2014	f
1486	2014-11-25	Tuesday	November	Q4	2014	f
1487	2014-11-26	Wednesday	November	Q4	2014	f
1488	2014-11-28	Friday	November	Q4	2014	f
1489	2014-12-01	Monday	December	Q4	2014	f
1490	2014-12-02	Tuesday	December	Q4	2014	f
1491	2014-12-03	Wednesday	December	Q4	2014	f
1492	2014-12-04	Thursday	December	Q4	2014	f
1493	2014-12-05	Friday	December	Q4	2014	f
1494	2014-12-08	Monday	December	Q4	2014	f
1495	2014-12-09	Tuesday	December	Q4	2014	f
1496	2014-12-10	Wednesday	December	Q4	2014	f
1497	2014-12-11	Thursday	December	Q4	2014	f
1498	2014-12-12	Friday	December	Q4	2014	f
1499	2014-12-15	Monday	December	Q4	2014	f
1500	2014-12-16	Tuesday	December	Q4	2014	f
1501	2014-12-17	Wednesday	December	Q4	2014	f
1502	2014-12-18	Thursday	December	Q4	2014	f
1503	2014-12-19	Friday	December	Q4	2014	f
1504	2014-12-22	Monday	December	Q4	2014	f
1505	2014-12-23	Tuesday	December	Q4	2014	f
1506	2014-12-24	Wednesday	December	Q4	2014	f
1507	2014-12-26	Friday	December	Q4	2014	f
1508	2014-12-29	Monday	December	Q4	2014	f
1509	2014-12-30	Tuesday	December	Q4	2014	f
1510	2014-12-31	Wednesday	December	Q4	2014	f
1511	2015-01-02	Friday	January	Q1	2015	f
1512	2015-01-05	Monday	January	Q1	2015	f
1513	2015-01-06	Tuesday	January	Q1	2015	f
1514	2015-01-07	Wednesday	January	Q1	2015	f
1515	2015-01-08	Thursday	January	Q1	2015	f
1516	2015-01-09	Friday	January	Q1	2015	f
1517	2015-01-12	Monday	January	Q1	2015	f
1518	2015-01-13	Tuesday	January	Q1	2015	f
1519	2015-01-14	Wednesday	January	Q1	2015	f
1520	2015-01-15	Thursday	January	Q1	2015	f
1521	2015-01-16	Friday	January	Q1	2015	f
1522	2015-01-20	Tuesday	January	Q1	2015	f
1523	2015-01-21	Wednesday	January	Q1	2015	f
1524	2015-01-22	Thursday	January	Q1	2015	f
1525	2015-01-23	Friday	January	Q1	2015	f
1526	2015-01-26	Monday	January	Q1	2015	f
1527	2015-01-27	Tuesday	January	Q1	2015	f
1528	2015-01-28	Wednesday	January	Q1	2015	f
1529	2015-01-29	Thursday	January	Q1	2015	f
1530	2015-01-30	Friday	January	Q1	2015	f
1531	2015-02-02	Monday	February	Q1	2015	f
1532	2015-02-03	Tuesday	February	Q1	2015	f
1533	2015-02-04	Wednesday	February	Q1	2015	f
1534	2015-02-05	Thursday	February	Q1	2015	f
1535	2015-02-06	Friday	February	Q1	2015	f
1536	2015-02-09	Monday	February	Q1	2015	f
1537	2015-02-10	Tuesday	February	Q1	2015	f
1538	2015-02-11	Wednesday	February	Q1	2015	f
1539	2015-02-12	Thursday	February	Q1	2015	f
1540	2015-02-13	Friday	February	Q1	2015	f
1541	2015-02-17	Tuesday	February	Q1	2015	f
1542	2015-02-18	Wednesday	February	Q1	2015	f
1543	2015-02-19	Thursday	February	Q1	2015	f
1544	2015-02-20	Friday	February	Q1	2015	f
1545	2015-02-23	Monday	February	Q1	2015	f
1546	2015-02-24	Tuesday	February	Q1	2015	f
1547	2015-02-25	Wednesday	February	Q1	2015	f
1548	2015-02-26	Thursday	February	Q1	2015	f
1549	2015-02-27	Friday	February	Q1	2015	f
1550	2015-03-02	Monday	March	Q1	2015	f
1551	2015-03-03	Tuesday	March	Q1	2015	f
1552	2015-03-04	Wednesday	March	Q1	2015	f
1553	2015-03-05	Thursday	March	Q1	2015	f
1554	2015-03-06	Friday	March	Q1	2015	f
1555	2015-03-09	Monday	March	Q1	2015	f
1556	2015-03-10	Tuesday	March	Q1	2015	f
1557	2015-03-11	Wednesday	March	Q1	2015	f
1558	2015-03-12	Thursday	March	Q1	2015	f
1559	2015-03-13	Friday	March	Q1	2015	f
1560	2015-03-16	Monday	March	Q1	2015	f
1561	2015-03-17	Tuesday	March	Q1	2015	f
1562	2015-03-18	Wednesday	March	Q1	2015	f
1563	2015-03-19	Thursday	March	Q1	2015	f
1564	2015-03-20	Friday	March	Q1	2015	f
1565	2015-03-23	Monday	March	Q1	2015	f
1566	2015-03-24	Tuesday	March	Q1	2015	f
1567	2015-03-25	Wednesday	March	Q1	2015	f
1568	2015-03-26	Thursday	March	Q1	2015	f
1569	2015-03-27	Friday	March	Q1	2015	f
1570	2015-03-30	Monday	March	Q1	2015	f
1571	2015-03-31	Tuesday	March	Q1	2015	f
1572	2015-04-01	Wednesday	April	Q2	2015	f
1573	2015-04-02	Thursday	April	Q2	2015	f
1574	2015-04-06	Monday	April	Q2	2015	f
1575	2015-04-07	Tuesday	April	Q2	2015	f
1576	2015-04-08	Wednesday	April	Q2	2015	f
1577	2015-04-09	Thursday	April	Q2	2015	f
1578	2015-04-10	Friday	April	Q2	2015	f
1579	2015-04-13	Monday	April	Q2	2015	f
1580	2015-04-14	Tuesday	April	Q2	2015	f
1581	2015-04-15	Wednesday	April	Q2	2015	f
1582	2015-04-16	Thursday	April	Q2	2015	f
1583	2015-04-17	Friday	April	Q2	2015	f
1584	2015-04-20	Monday	April	Q2	2015	f
1585	2015-04-21	Tuesday	April	Q2	2015	f
1586	2015-04-22	Wednesday	April	Q2	2015	f
1587	2015-04-23	Thursday	April	Q2	2015	f
1588	2015-04-24	Friday	April	Q2	2015	f
1589	2015-04-27	Monday	April	Q2	2015	f
1590	2015-04-28	Tuesday	April	Q2	2015	f
1591	2015-04-29	Wednesday	April	Q2	2015	f
1592	2015-04-30	Thursday	April	Q2	2015	f
1593	2015-05-01	Friday	May	Q2	2015	f
1594	2015-05-04	Monday	May	Q2	2015	f
1595	2015-05-05	Tuesday	May	Q2	2015	f
1596	2015-05-06	Wednesday	May	Q2	2015	f
1597	2015-05-07	Thursday	May	Q2	2015	f
1598	2015-05-08	Friday	May	Q2	2015	f
1599	2015-05-11	Monday	May	Q2	2015	f
1600	2015-05-12	Tuesday	May	Q2	2015	f
1601	2015-05-13	Wednesday	May	Q2	2015	f
1602	2015-05-14	Thursday	May	Q2	2015	f
1603	2015-05-15	Friday	May	Q2	2015	f
1604	2015-05-18	Monday	May	Q2	2015	f
1605	2015-05-19	Tuesday	May	Q2	2015	f
1606	2015-05-20	Wednesday	May	Q2	2015	f
1607	2015-05-21	Thursday	May	Q2	2015	f
1608	2015-05-22	Friday	May	Q2	2015	f
1609	2015-05-26	Tuesday	May	Q2	2015	f
1610	2015-05-27	Wednesday	May	Q2	2015	f
1611	2015-05-28	Thursday	May	Q2	2015	f
1612	2015-05-29	Friday	May	Q2	2015	f
1613	2015-06-01	Monday	June	Q2	2015	f
1614	2015-06-02	Tuesday	June	Q2	2015	f
1615	2015-06-03	Wednesday	June	Q2	2015	f
1616	2015-06-04	Thursday	June	Q2	2015	f
1617	2015-06-05	Friday	June	Q2	2015	f
1618	2015-06-08	Monday	June	Q2	2015	f
1619	2015-06-09	Tuesday	June	Q2	2015	f
1620	2015-06-10	Wednesday	June	Q2	2015	f
1621	2015-06-11	Thursday	June	Q2	2015	f
1622	2015-06-12	Friday	June	Q2	2015	f
1623	2015-06-15	Monday	June	Q2	2015	f
1624	2015-06-16	Tuesday	June	Q2	2015	f
1625	2015-06-17	Wednesday	June	Q2	2015	f
1626	2015-06-18	Thursday	June	Q2	2015	f
1627	2015-06-19	Friday	June	Q2	2015	f
1628	2015-06-22	Monday	June	Q2	2015	f
1629	2015-06-23	Tuesday	June	Q2	2015	f
1630	2015-06-24	Wednesday	June	Q2	2015	f
1631	2015-06-25	Thursday	June	Q2	2015	f
1632	2015-06-26	Friday	June	Q2	2015	f
1633	2015-06-29	Monday	June	Q2	2015	f
1634	2015-06-30	Tuesday	June	Q2	2015	f
1635	2015-07-01	Wednesday	July	Q3	2015	f
1636	2015-07-02	Thursday	July	Q3	2015	f
1637	2015-07-06	Monday	July	Q3	2015	f
1638	2015-07-07	Tuesday	July	Q3	2015	f
1639	2015-07-08	Wednesday	July	Q3	2015	f
1640	2015-07-09	Thursday	July	Q3	2015	f
1641	2015-07-10	Friday	July	Q3	2015	f
1642	2015-07-13	Monday	July	Q3	2015	f
1643	2015-07-14	Tuesday	July	Q3	2015	f
1644	2015-07-15	Wednesday	July	Q3	2015	f
1645	2015-07-16	Thursday	July	Q3	2015	f
1646	2015-07-17	Friday	July	Q3	2015	f
1647	2015-07-20	Monday	July	Q3	2015	f
1648	2015-07-21	Tuesday	July	Q3	2015	f
1649	2015-07-22	Wednesday	July	Q3	2015	f
1650	2015-07-23	Thursday	July	Q3	2015	f
1651	2015-07-24	Friday	July	Q3	2015	f
1652	2015-07-27	Monday	July	Q3	2015	f
1653	2015-07-28	Tuesday	July	Q3	2015	f
1654	2015-07-29	Wednesday	July	Q3	2015	f
1655	2015-07-30	Thursday	July	Q3	2015	f
1656	2015-07-31	Friday	July	Q3	2015	f
1657	2015-08-03	Monday	August	Q3	2015	f
1658	2015-08-04	Tuesday	August	Q3	2015	f
1659	2015-08-05	Wednesday	August	Q3	2015	f
1660	2015-08-06	Thursday	August	Q3	2015	f
1661	2015-08-07	Friday	August	Q3	2015	f
1662	2015-08-10	Monday	August	Q3	2015	f
1663	2015-08-11	Tuesday	August	Q3	2015	f
1664	2015-08-12	Wednesday	August	Q3	2015	f
1665	2015-08-13	Thursday	August	Q3	2015	f
1666	2015-08-14	Friday	August	Q3	2015	f
1667	2015-08-17	Monday	August	Q3	2015	f
1668	2015-08-18	Tuesday	August	Q3	2015	f
1669	2015-08-19	Wednesday	August	Q3	2015	f
1670	2015-08-20	Thursday	August	Q3	2015	f
1671	2015-08-21	Friday	August	Q3	2015	f
1672	2015-08-24	Monday	August	Q3	2015	f
1673	2015-08-25	Tuesday	August	Q3	2015	f
1674	2015-08-26	Wednesday	August	Q3	2015	f
1675	2015-08-27	Thursday	August	Q3	2015	f
1676	2015-08-28	Friday	August	Q3	2015	f
1677	2015-08-31	Monday	August	Q3	2015	f
1678	2015-09-01	Tuesday	September	Q3	2015	f
1679	2015-09-02	Wednesday	September	Q3	2015	f
1680	2015-09-03	Thursday	September	Q3	2015	f
1681	2015-09-04	Friday	September	Q3	2015	f
1682	2015-09-08	Tuesday	September	Q3	2015	f
1683	2015-09-09	Wednesday	September	Q3	2015	f
1684	2015-09-10	Thursday	September	Q3	2015	f
1685	2015-09-11	Friday	September	Q3	2015	f
1686	2015-09-14	Monday	September	Q3	2015	f
1687	2015-09-15	Tuesday	September	Q3	2015	f
1688	2015-09-16	Wednesday	September	Q3	2015	f
1689	2015-09-17	Thursday	September	Q3	2015	f
1690	2015-09-18	Friday	September	Q3	2015	f
1691	2015-09-21	Monday	September	Q3	2015	f
1692	2015-09-22	Tuesday	September	Q3	2015	f
1693	2015-09-23	Wednesday	September	Q3	2015	f
1694	2015-09-24	Thursday	September	Q3	2015	f
1695	2015-09-25	Friday	September	Q3	2015	f
1696	2015-09-28	Monday	September	Q3	2015	f
1697	2015-09-29	Tuesday	September	Q3	2015	f
1698	2015-09-30	Wednesday	September	Q3	2015	f
1699	2015-10-01	Thursday	October	Q4	2015	f
1700	2015-10-02	Friday	October	Q4	2015	f
1701	2015-10-05	Monday	October	Q4	2015	f
1702	2015-10-06	Tuesday	October	Q4	2015	f
1703	2015-10-07	Wednesday	October	Q4	2015	f
1704	2015-10-08	Thursday	October	Q4	2015	f
1705	2015-10-09	Friday	October	Q4	2015	f
1706	2015-10-12	Monday	October	Q4	2015	f
1707	2015-10-13	Tuesday	October	Q4	2015	f
1708	2015-10-14	Wednesday	October	Q4	2015	f
1709	2015-10-15	Thursday	October	Q4	2015	f
1710	2015-10-16	Friday	October	Q4	2015	f
1711	2015-10-19	Monday	October	Q4	2015	f
1712	2015-10-20	Tuesday	October	Q4	2015	f
1713	2015-10-21	Wednesday	October	Q4	2015	f
1714	2015-10-22	Thursday	October	Q4	2015	f
1715	2015-10-23	Friday	October	Q4	2015	f
1716	2015-10-26	Monday	October	Q4	2015	f
1717	2015-10-27	Tuesday	October	Q4	2015	f
1718	2015-10-28	Wednesday	October	Q4	2015	f
1719	2015-10-29	Thursday	October	Q4	2015	f
1720	2015-10-30	Friday	October	Q4	2015	f
1721	2015-11-02	Monday	November	Q4	2015	f
1722	2015-11-03	Tuesday	November	Q4	2015	f
1723	2015-11-04	Wednesday	November	Q4	2015	f
1724	2015-11-05	Thursday	November	Q4	2015	f
1725	2015-11-06	Friday	November	Q4	2015	f
1726	2015-11-09	Monday	November	Q4	2015	f
1727	2015-11-10	Tuesday	November	Q4	2015	f
1728	2015-11-11	Wednesday	November	Q4	2015	f
1729	2015-11-12	Thursday	November	Q4	2015	f
1730	2015-11-13	Friday	November	Q4	2015	f
1731	2015-11-16	Monday	November	Q4	2015	f
1732	2015-11-17	Tuesday	November	Q4	2015	f
1733	2015-11-18	Wednesday	November	Q4	2015	f
1734	2015-11-19	Thursday	November	Q4	2015	f
1735	2015-11-20	Friday	November	Q4	2015	f
1736	2015-11-23	Monday	November	Q4	2015	f
1737	2015-11-24	Tuesday	November	Q4	2015	f
1738	2015-11-25	Wednesday	November	Q4	2015	f
1739	2015-11-27	Friday	November	Q4	2015	f
1740	2015-11-30	Monday	November	Q4	2015	f
1741	2015-12-01	Tuesday	December	Q4	2015	f
1742	2015-12-02	Wednesday	December	Q4	2015	f
1743	2015-12-03	Thursday	December	Q4	2015	f
1744	2015-12-04	Friday	December	Q4	2015	f
1745	2015-12-07	Monday	December	Q4	2015	f
1746	2015-12-08	Tuesday	December	Q4	2015	f
1747	2015-12-09	Wednesday	December	Q4	2015	f
1748	2015-12-10	Thursday	December	Q4	2015	f
1749	2015-12-11	Friday	December	Q4	2015	f
1750	2015-12-14	Monday	December	Q4	2015	f
1751	2015-12-15	Tuesday	December	Q4	2015	f
1752	2015-12-16	Wednesday	December	Q4	2015	f
1753	2015-12-17	Thursday	December	Q4	2015	f
1754	2015-12-18	Friday	December	Q4	2015	f
1755	2015-12-21	Monday	December	Q4	2015	f
1756	2015-12-22	Tuesday	December	Q4	2015	f
1757	2015-12-23	Wednesday	December	Q4	2015	f
1758	2015-12-24	Thursday	December	Q4	2015	f
1759	2015-12-28	Monday	December	Q4	2015	f
1760	2015-12-29	Tuesday	December	Q4	2015	f
1761	2015-12-30	Wednesday	December	Q4	2015	f
1762	2015-12-31	Thursday	December	Q4	2015	f
1763	2016-01-04	Monday	January	Q1	2016	f
1764	2016-01-05	Tuesday	January	Q1	2016	f
1765	2016-01-06	Wednesday	January	Q1	2016	f
1766	2016-01-07	Thursday	January	Q1	2016	f
1767	2016-01-08	Friday	January	Q1	2016	f
1768	2016-01-11	Monday	January	Q1	2016	f
1769	2016-01-12	Tuesday	January	Q1	2016	f
1770	2016-01-13	Wednesday	January	Q1	2016	f
1771	2016-01-14	Thursday	January	Q1	2016	f
1772	2016-01-15	Friday	January	Q1	2016	f
1773	2016-01-19	Tuesday	January	Q1	2016	f
1774	2016-01-20	Wednesday	January	Q1	2016	f
1775	2016-01-21	Thursday	January	Q1	2016	f
1776	2016-01-22	Friday	January	Q1	2016	f
1777	2016-01-25	Monday	January	Q1	2016	f
1778	2016-01-26	Tuesday	January	Q1	2016	f
1779	2016-01-27	Wednesday	January	Q1	2016	f
1780	2016-01-28	Thursday	January	Q1	2016	f
1781	2016-01-29	Friday	January	Q1	2016	f
1782	2016-02-01	Monday	February	Q1	2016	f
1783	2016-02-02	Tuesday	February	Q1	2016	f
1784	2016-02-03	Wednesday	February	Q1	2016	f
1785	2016-02-04	Thursday	February	Q1	2016	f
1786	2016-02-05	Friday	February	Q1	2016	f
1787	2016-02-08	Monday	February	Q1	2016	f
1788	2016-02-09	Tuesday	February	Q1	2016	f
1789	2016-02-10	Wednesday	February	Q1	2016	f
1790	2016-02-11	Thursday	February	Q1	2016	f
1791	2016-02-12	Friday	February	Q1	2016	f
1792	2016-02-16	Tuesday	February	Q1	2016	f
1793	2016-02-17	Wednesday	February	Q1	2016	f
1794	2016-02-18	Thursday	February	Q1	2016	f
1795	2016-02-19	Friday	February	Q1	2016	f
1796	2016-02-22	Monday	February	Q1	2016	f
1797	2016-02-23	Tuesday	February	Q1	2016	f
1798	2016-02-24	Wednesday	February	Q1	2016	f
1799	2016-02-25	Thursday	February	Q1	2016	f
1800	2016-02-26	Friday	February	Q1	2016	f
1801	2016-02-29	Monday	February	Q1	2016	f
1802	2016-03-01	Tuesday	March	Q1	2016	f
1803	2016-03-02	Wednesday	March	Q1	2016	f
1804	2016-03-03	Thursday	March	Q1	2016	f
1805	2016-03-04	Friday	March	Q1	2016	f
1806	2016-03-07	Monday	March	Q1	2016	f
1807	2016-03-08	Tuesday	March	Q1	2016	f
1808	2016-03-09	Wednesday	March	Q1	2016	f
1809	2016-03-10	Thursday	March	Q1	2016	f
1810	2016-03-11	Friday	March	Q1	2016	f
1811	2016-03-14	Monday	March	Q1	2016	f
1812	2016-03-15	Tuesday	March	Q1	2016	f
1813	2016-03-16	Wednesday	March	Q1	2016	f
1814	2016-03-17	Thursday	March	Q1	2016	f
1815	2016-03-18	Friday	March	Q1	2016	f
1816	2016-03-21	Monday	March	Q1	2016	f
1817	2016-03-22	Tuesday	March	Q1	2016	f
1818	2016-03-23	Wednesday	March	Q1	2016	f
1819	2016-03-24	Thursday	March	Q1	2016	f
1820	2016-03-28	Monday	March	Q1	2016	f
1821	2016-03-29	Tuesday	March	Q1	2016	f
1822	2016-03-30	Wednesday	March	Q1	2016	f
1823	2016-03-31	Thursday	March	Q1	2016	f
1824	2016-04-01	Friday	April	Q2	2016	f
1825	2016-04-04	Monday	April	Q2	2016	f
1826	2016-04-05	Tuesday	April	Q2	2016	f
1827	2016-04-06	Wednesday	April	Q2	2016	f
1828	2016-04-07	Thursday	April	Q2	2016	f
1829	2016-04-08	Friday	April	Q2	2016	f
1830	2016-04-11	Monday	April	Q2	2016	f
1831	2016-04-12	Tuesday	April	Q2	2016	f
1832	2016-04-13	Wednesday	April	Q2	2016	f
1833	2016-04-14	Thursday	April	Q2	2016	f
1834	2016-04-15	Friday	April	Q2	2016	f
1835	2016-04-18	Monday	April	Q2	2016	f
1836	2016-04-19	Tuesday	April	Q2	2016	f
1837	2016-04-20	Wednesday	April	Q2	2016	f
1838	2016-04-21	Thursday	April	Q2	2016	f
1839	2016-04-22	Friday	April	Q2	2016	f
1840	2016-04-25	Monday	April	Q2	2016	f
1841	2016-04-26	Tuesday	April	Q2	2016	f
1842	2016-04-27	Wednesday	April	Q2	2016	f
1843	2016-04-28	Thursday	April	Q2	2016	f
1844	2016-04-29	Friday	April	Q2	2016	f
1845	2016-05-02	Monday	May	Q2	2016	f
1846	2016-05-03	Tuesday	May	Q2	2016	f
1847	2016-05-04	Wednesday	May	Q2	2016	f
1848	2016-05-05	Thursday	May	Q2	2016	f
1849	2016-05-06	Friday	May	Q2	2016	f
1850	2016-05-09	Monday	May	Q2	2016	f
1851	2016-05-10	Tuesday	May	Q2	2016	f
1852	2016-05-11	Wednesday	May	Q2	2016	f
1853	2016-05-12	Thursday	May	Q2	2016	f
1854	2016-05-13	Friday	May	Q2	2016	f
1855	2016-05-16	Monday	May	Q2	2016	f
1856	2016-05-17	Tuesday	May	Q2	2016	f
1857	2016-05-18	Wednesday	May	Q2	2016	f
1858	2016-05-19	Thursday	May	Q2	2016	f
1859	2016-05-20	Friday	May	Q2	2016	f
1860	2016-05-23	Monday	May	Q2	2016	f
1861	2016-05-24	Tuesday	May	Q2	2016	f
1862	2016-05-25	Wednesday	May	Q2	2016	f
1863	2016-05-26	Thursday	May	Q2	2016	f
1864	2016-05-27	Friday	May	Q2	2016	f
1865	2016-05-31	Tuesday	May	Q2	2016	f
1866	2016-06-01	Wednesday	June	Q2	2016	f
1867	2016-06-02	Thursday	June	Q2	2016	f
1868	2016-06-03	Friday	June	Q2	2016	f
1869	2016-06-06	Monday	June	Q2	2016	f
1870	2016-06-07	Tuesday	June	Q2	2016	f
1871	2016-06-08	Wednesday	June	Q2	2016	f
1872	2016-06-09	Thursday	June	Q2	2016	f
1873	2016-06-10	Friday	June	Q2	2016	f
1874	2016-06-13	Monday	June	Q2	2016	f
1875	2016-06-14	Tuesday	June	Q2	2016	f
1876	2016-06-15	Wednesday	June	Q2	2016	f
1877	2016-06-16	Thursday	June	Q2	2016	f
1878	2016-06-17	Friday	June	Q2	2016	f
1879	2016-06-20	Monday	June	Q2	2016	f
1880	2016-06-21	Tuesday	June	Q2	2016	f
1881	2016-06-22	Wednesday	June	Q2	2016	f
1882	2016-06-23	Thursday	June	Q2	2016	f
1883	2016-06-24	Friday	June	Q2	2016	f
1884	2016-06-27	Monday	June	Q2	2016	f
1885	2016-06-28	Tuesday	June	Q2	2016	f
1886	2016-06-29	Wednesday	June	Q2	2016	f
1887	2016-06-30	Thursday	June	Q2	2016	f
1888	2016-07-01	Friday	July	Q3	2016	f
1889	2016-07-05	Tuesday	July	Q3	2016	f
1890	2016-07-06	Wednesday	July	Q3	2016	f
1891	2016-07-07	Thursday	July	Q3	2016	f
1892	2016-07-08	Friday	July	Q3	2016	f
1893	2016-07-11	Monday	July	Q3	2016	f
1894	2016-07-12	Tuesday	July	Q3	2016	f
1895	2016-07-13	Wednesday	July	Q3	2016	f
1896	2016-07-14	Thursday	July	Q3	2016	f
1897	2016-07-15	Friday	July	Q3	2016	f
1898	2016-07-18	Monday	July	Q3	2016	f
1899	2016-07-19	Tuesday	July	Q3	2016	f
1900	2016-07-20	Wednesday	July	Q3	2016	f
1901	2016-07-21	Thursday	July	Q3	2016	f
1902	2016-07-22	Friday	July	Q3	2016	f
1903	2016-07-25	Monday	July	Q3	2016	f
1904	2016-07-26	Tuesday	July	Q3	2016	f
1905	2016-07-27	Wednesday	July	Q3	2016	f
1906	2016-07-28	Thursday	July	Q3	2016	f
1907	2016-07-29	Friday	July	Q3	2016	f
1908	2016-08-01	Monday	August	Q3	2016	f
1909	2016-08-02	Tuesday	August	Q3	2016	f
1910	2016-08-03	Wednesday	August	Q3	2016	f
1911	2016-08-04	Thursday	August	Q3	2016	f
1912	2016-08-05	Friday	August	Q3	2016	f
1913	2016-08-08	Monday	August	Q3	2016	f
1914	2016-08-09	Tuesday	August	Q3	2016	f
1915	2016-08-10	Wednesday	August	Q3	2016	f
1916	2016-08-11	Thursday	August	Q3	2016	f
1917	2016-08-12	Friday	August	Q3	2016	f
1918	2016-08-15	Monday	August	Q3	2016	f
1919	2016-08-16	Tuesday	August	Q3	2016	f
1920	2016-08-17	Wednesday	August	Q3	2016	f
1921	2016-08-18	Thursday	August	Q3	2016	f
1922	2016-08-19	Friday	August	Q3	2016	f
1923	2016-08-22	Monday	August	Q3	2016	f
1924	2016-08-23	Tuesday	August	Q3	2016	f
1925	2016-08-24	Wednesday	August	Q3	2016	f
1926	2016-08-25	Thursday	August	Q3	2016	f
1927	2016-08-26	Friday	August	Q3	2016	f
1928	2016-08-29	Monday	August	Q3	2016	f
1929	2016-08-30	Tuesday	August	Q3	2016	f
1930	2016-08-31	Wednesday	August	Q3	2016	f
1931	2016-09-01	Thursday	September	Q3	2016	f
1932	2016-09-02	Friday	September	Q3	2016	f
1933	2016-09-06	Tuesday	September	Q3	2016	f
1934	2016-09-07	Wednesday	September	Q3	2016	f
1935	2016-09-08	Thursday	September	Q3	2016	f
1936	2016-09-09	Friday	September	Q3	2016	f
1937	2016-09-12	Monday	September	Q3	2016	f
1938	2016-09-13	Tuesday	September	Q3	2016	f
1939	2016-09-14	Wednesday	September	Q3	2016	f
1940	2016-09-15	Thursday	September	Q3	2016	f
1941	2016-09-16	Friday	September	Q3	2016	f
1942	2016-09-19	Monday	September	Q3	2016	f
1943	2016-09-20	Tuesday	September	Q3	2016	f
1944	2016-09-21	Wednesday	September	Q3	2016	f
1945	2016-09-22	Thursday	September	Q3	2016	f
1946	2016-09-23	Friday	September	Q3	2016	f
1947	2016-09-26	Monday	September	Q3	2016	f
1948	2016-09-27	Tuesday	September	Q3	2016	f
1949	2016-09-28	Wednesday	September	Q3	2016	f
1950	2016-09-29	Thursday	September	Q3	2016	f
1951	2016-09-30	Friday	September	Q3	2016	f
1952	2016-10-03	Monday	October	Q4	2016	f
1953	2016-10-04	Tuesday	October	Q4	2016	f
1954	2016-10-05	Wednesday	October	Q4	2016	f
1955	2016-10-06	Thursday	October	Q4	2016	f
1956	2016-10-07	Friday	October	Q4	2016	f
1957	2016-10-10	Monday	October	Q4	2016	f
1958	2016-10-11	Tuesday	October	Q4	2016	f
1959	2016-10-12	Wednesday	October	Q4	2016	f
1960	2016-10-13	Thursday	October	Q4	2016	f
1961	2016-10-14	Friday	October	Q4	2016	f
1962	2016-10-17	Monday	October	Q4	2016	f
1963	2016-10-18	Tuesday	October	Q4	2016	f
1964	2016-10-19	Wednesday	October	Q4	2016	f
1965	2016-10-20	Thursday	October	Q4	2016	f
1966	2016-10-21	Friday	October	Q4	2016	f
1967	2016-10-24	Monday	October	Q4	2016	f
1968	2016-10-25	Tuesday	October	Q4	2016	f
1969	2016-10-26	Wednesday	October	Q4	2016	f
1970	2016-10-27	Thursday	October	Q4	2016	f
1971	2016-10-28	Friday	October	Q4	2016	f
1972	2016-10-31	Monday	October	Q4	2016	f
1973	2016-11-01	Tuesday	November	Q4	2016	f
1974	2016-11-02	Wednesday	November	Q4	2016	f
1975	2016-11-03	Thursday	November	Q4	2016	f
1976	2016-11-04	Friday	November	Q4	2016	f
1977	2016-11-07	Monday	November	Q4	2016	f
1978	2016-11-08	Tuesday	November	Q4	2016	f
1979	2016-11-09	Wednesday	November	Q4	2016	f
1980	2016-11-10	Thursday	November	Q4	2016	f
1981	2016-11-11	Friday	November	Q4	2016	f
1982	2016-11-14	Monday	November	Q4	2016	f
1983	2016-11-15	Tuesday	November	Q4	2016	f
1984	2016-11-16	Wednesday	November	Q4	2016	f
1985	2016-11-17	Thursday	November	Q4	2016	f
1986	2016-11-18	Friday	November	Q4	2016	f
1987	2016-11-21	Monday	November	Q4	2016	f
1988	2016-11-22	Tuesday	November	Q4	2016	f
1989	2016-11-23	Wednesday	November	Q4	2016	f
1990	2016-11-25	Friday	November	Q4	2016	f
1991	2016-11-28	Monday	November	Q4	2016	f
1992	2016-11-29	Tuesday	November	Q4	2016	f
1993	2016-11-30	Wednesday	November	Q4	2016	f
1994	2016-12-01	Thursday	December	Q4	2016	f
1995	2016-12-02	Friday	December	Q4	2016	f
1996	2016-12-05	Monday	December	Q4	2016	f
1997	2016-12-06	Tuesday	December	Q4	2016	f
1998	2016-12-07	Wednesday	December	Q4	2016	f
1999	2016-12-08	Thursday	December	Q4	2016	f
2000	2016-12-09	Friday	December	Q4	2016	f
2001	2016-12-12	Monday	December	Q4	2016	f
2002	2016-12-13	Tuesday	December	Q4	2016	f
2003	2016-12-14	Wednesday	December	Q4	2016	f
2004	2016-12-15	Thursday	December	Q4	2016	f
2005	2016-12-16	Friday	December	Q4	2016	f
2006	2016-12-19	Monday	December	Q4	2016	f
2007	2016-12-20	Tuesday	December	Q4	2016	f
2008	2016-12-21	Wednesday	December	Q4	2016	f
2009	2016-12-22	Thursday	December	Q4	2016	f
2010	2016-12-23	Friday	December	Q4	2016	f
2011	2016-12-27	Tuesday	December	Q4	2016	f
2012	2016-12-28	Wednesday	December	Q4	2016	f
2013	2016-12-29	Thursday	December	Q4	2016	f
2014	2016-12-30	Friday	December	Q4	2016	f
2015	2017-01-03	Tuesday	January	Q1	2017	f
2016	2017-01-04	Wednesday	January	Q1	2017	f
2017	2017-01-05	Thursday	January	Q1	2017	f
2018	2017-01-06	Friday	January	Q1	2017	f
2019	2017-01-09	Monday	January	Q1	2017	f
2020	2017-01-10	Tuesday	January	Q1	2017	f
2021	2017-01-11	Wednesday	January	Q1	2017	f
2022	2017-01-12	Thursday	January	Q1	2017	f
2023	2017-01-13	Friday	January	Q1	2017	f
2024	2017-01-17	Tuesday	January	Q1	2017	f
2025	2017-01-18	Wednesday	January	Q1	2017	f
2026	2017-01-19	Thursday	January	Q1	2017	f
2027	2017-01-20	Friday	January	Q1	2017	f
2028	2017-01-23	Monday	January	Q1	2017	f
2029	2017-01-24	Tuesday	January	Q1	2017	f
2030	2017-01-25	Wednesday	January	Q1	2017	f
2031	2017-01-26	Thursday	January	Q1	2017	f
2032	2017-01-27	Friday	January	Q1	2017	f
2033	2017-01-30	Monday	January	Q1	2017	f
2034	2017-01-31	Tuesday	January	Q1	2017	f
2035	2017-02-01	Wednesday	February	Q1	2017	f
2036	2017-02-02	Thursday	February	Q1	2017	f
2037	2017-02-03	Friday	February	Q1	2017	f
2038	2017-02-06	Monday	February	Q1	2017	f
2039	2017-02-07	Tuesday	February	Q1	2017	f
2040	2017-02-08	Wednesday	February	Q1	2017	f
2041	2017-02-09	Thursday	February	Q1	2017	f
2042	2017-02-10	Friday	February	Q1	2017	f
2043	2017-02-13	Monday	February	Q1	2017	f
2044	2017-02-14	Tuesday	February	Q1	2017	f
2045	2017-02-15	Wednesday	February	Q1	2017	f
2046	2017-02-16	Thursday	February	Q1	2017	f
2047	2017-02-17	Friday	February	Q1	2017	f
2048	2017-02-21	Tuesday	February	Q1	2017	f
2049	2017-02-22	Wednesday	February	Q1	2017	f
2050	2017-02-23	Thursday	February	Q1	2017	f
2051	2017-02-24	Friday	February	Q1	2017	f
2052	2017-02-27	Monday	February	Q1	2017	f
2053	2017-02-28	Tuesday	February	Q1	2017	f
2054	2017-03-01	Wednesday	March	Q1	2017	f
2055	2017-03-02	Thursday	March	Q1	2017	f
2056	2017-03-03	Friday	March	Q1	2017	f
2057	2017-03-06	Monday	March	Q1	2017	f
2058	2017-03-07	Tuesday	March	Q1	2017	f
2059	2017-03-08	Wednesday	March	Q1	2017	f
2060	2017-03-09	Thursday	March	Q1	2017	f
2061	2017-03-10	Friday	March	Q1	2017	f
2062	2017-03-13	Monday	March	Q1	2017	f
2063	2017-03-14	Tuesday	March	Q1	2017	f
2064	2017-03-15	Wednesday	March	Q1	2017	f
2065	2017-03-16	Thursday	March	Q1	2017	f
2066	2017-03-17	Friday	March	Q1	2017	f
2067	2017-03-20	Monday	March	Q1	2017	f
2068	2017-03-21	Tuesday	March	Q1	2017	f
2069	2017-03-22	Wednesday	March	Q1	2017	f
2070	2017-03-23	Thursday	March	Q1	2017	f
2071	2017-03-24	Friday	March	Q1	2017	f
2072	2017-03-27	Monday	March	Q1	2017	f
2073	2017-03-28	Tuesday	March	Q1	2017	f
2074	2017-03-29	Wednesday	March	Q1	2017	f
2075	2017-03-30	Thursday	March	Q1	2017	f
2076	2017-03-31	Friday	March	Q1	2017	f
2077	2017-04-03	Monday	April	Q2	2017	f
2078	2017-04-04	Tuesday	April	Q2	2017	f
2079	2017-04-05	Wednesday	April	Q2	2017	f
2080	2017-04-06	Thursday	April	Q2	2017	f
2081	2017-04-07	Friday	April	Q2	2017	f
2082	2017-04-10	Monday	April	Q2	2017	f
2083	2017-04-11	Tuesday	April	Q2	2017	f
2084	2017-04-12	Wednesday	April	Q2	2017	f
2085	2017-04-13	Thursday	April	Q2	2017	f
2086	2017-04-17	Monday	April	Q2	2017	f
2087	2017-04-18	Tuesday	April	Q2	2017	f
2088	2017-04-19	Wednesday	April	Q2	2017	f
2089	2017-04-20	Thursday	April	Q2	2017	f
2090	2017-04-21	Friday	April	Q2	2017	f
2091	2017-04-24	Monday	April	Q2	2017	f
2092	2017-04-25	Tuesday	April	Q2	2017	f
2093	2017-04-26	Wednesday	April	Q2	2017	f
2094	2017-04-27	Thursday	April	Q2	2017	f
2095	2017-04-28	Friday	April	Q2	2017	f
2096	2017-05-01	Monday	May	Q2	2017	f
2097	2017-05-02	Tuesday	May	Q2	2017	f
2098	2017-05-03	Wednesday	May	Q2	2017	f
2099	2017-05-04	Thursday	May	Q2	2017	f
2100	2017-05-05	Friday	May	Q2	2017	f
2101	2017-05-08	Monday	May	Q2	2017	f
2102	2017-05-09	Tuesday	May	Q2	2017	f
2103	2017-05-10	Wednesday	May	Q2	2017	f
2104	2017-05-11	Thursday	May	Q2	2017	f
2105	2017-05-12	Friday	May	Q2	2017	f
2106	2017-05-15	Monday	May	Q2	2017	f
2107	2017-05-16	Tuesday	May	Q2	2017	f
2108	2017-05-17	Wednesday	May	Q2	2017	f
2109	2017-05-18	Thursday	May	Q2	2017	f
2110	2017-05-19	Friday	May	Q2	2017	f
2111	2017-05-22	Monday	May	Q2	2017	f
2112	2017-05-23	Tuesday	May	Q2	2017	f
2113	2017-05-24	Wednesday	May	Q2	2017	f
2114	2017-05-25	Thursday	May	Q2	2017	f
2115	2017-05-26	Friday	May	Q2	2017	f
2116	2017-05-30	Tuesday	May	Q2	2017	f
2117	2017-05-31	Wednesday	May	Q2	2017	f
2118	2017-06-01	Thursday	June	Q2	2017	f
2119	2017-06-02	Friday	June	Q2	2017	f
2120	2017-06-05	Monday	June	Q2	2017	f
2121	2017-06-06	Tuesday	June	Q2	2017	f
2122	2017-06-07	Wednesday	June	Q2	2017	f
2123	2017-06-08	Thursday	June	Q2	2017	f
2124	2017-06-09	Friday	June	Q2	2017	f
2125	2017-06-12	Monday	June	Q2	2017	f
2126	2017-06-13	Tuesday	June	Q2	2017	f
2127	2017-06-14	Wednesday	June	Q2	2017	f
2128	2017-06-15	Thursday	June	Q2	2017	f
2129	2017-06-16	Friday	June	Q2	2017	f
2130	2017-06-19	Monday	June	Q2	2017	f
2131	2017-06-20	Tuesday	June	Q2	2017	f
2132	2017-06-21	Wednesday	June	Q2	2017	f
2133	2017-06-22	Thursday	June	Q2	2017	f
2134	2017-06-23	Friday	June	Q2	2017	f
2135	2017-06-26	Monday	June	Q2	2017	f
2136	2017-06-27	Tuesday	June	Q2	2017	f
2137	2017-06-28	Wednesday	June	Q2	2017	f
2138	2017-06-29	Thursday	June	Q2	2017	f
2139	2017-06-30	Friday	June	Q2	2017	f
2140	2017-07-03	Monday	July	Q3	2017	f
2141	2017-07-05	Wednesday	July	Q3	2017	f
2142	2017-07-06	Thursday	July	Q3	2017	f
2143	2017-07-07	Friday	July	Q3	2017	f
2144	2017-07-10	Monday	July	Q3	2017	f
2145	2017-07-11	Tuesday	July	Q3	2017	f
2146	2017-07-12	Wednesday	July	Q3	2017	f
2147	2017-07-13	Thursday	July	Q3	2017	f
2148	2017-07-14	Friday	July	Q3	2017	f
2149	2017-07-17	Monday	July	Q3	2017	f
2150	2017-07-18	Tuesday	July	Q3	2017	f
2151	2017-07-19	Wednesday	July	Q3	2017	f
2152	2017-07-20	Thursday	July	Q3	2017	f
2153	2017-07-21	Friday	July	Q3	2017	f
2154	2017-07-24	Monday	July	Q3	2017	f
2155	2017-07-25	Tuesday	July	Q3	2017	f
2156	2017-07-26	Wednesday	July	Q3	2017	f
2157	2017-07-27	Thursday	July	Q3	2017	f
2158	2017-07-28	Friday	July	Q3	2017	f
2159	2017-07-31	Monday	July	Q3	2017	f
2160	2017-08-01	Tuesday	August	Q3	2017	f
2161	2017-08-02	Wednesday	August	Q3	2017	f
2162	2017-08-03	Thursday	August	Q3	2017	f
2163	2017-08-04	Friday	August	Q3	2017	f
2164	2017-08-07	Monday	August	Q3	2017	f
2165	2017-08-08	Tuesday	August	Q3	2017	f
2166	2017-08-09	Wednesday	August	Q3	2017	f
2167	2017-08-10	Thursday	August	Q3	2017	f
2168	2017-08-11	Friday	August	Q3	2017	f
2169	2017-08-14	Monday	August	Q3	2017	f
2170	2017-08-15	Tuesday	August	Q3	2017	f
2171	2017-08-16	Wednesday	August	Q3	2017	f
2172	2017-08-17	Thursday	August	Q3	2017	f
2173	2017-08-18	Friday	August	Q3	2017	f
2174	2017-08-21	Monday	August	Q3	2017	f
2175	2017-08-22	Tuesday	August	Q3	2017	f
2176	2017-08-23	Wednesday	August	Q3	2017	f
2177	2017-08-24	Thursday	August	Q3	2017	f
2178	2017-08-25	Friday	August	Q3	2017	f
2179	2017-08-28	Monday	August	Q3	2017	f
2180	2017-08-29	Tuesday	August	Q3	2017	f
2181	2017-08-30	Wednesday	August	Q3	2017	f
2182	2017-08-31	Thursday	August	Q3	2017	f
2183	2017-09-01	Friday	September	Q3	2017	f
2184	2017-09-05	Tuesday	September	Q3	2017	f
2185	2017-09-06	Wednesday	September	Q3	2017	f
2186	2017-09-07	Thursday	September	Q3	2017	f
2187	2017-09-08	Friday	September	Q3	2017	f
2188	2017-09-11	Monday	September	Q3	2017	f
2189	2017-09-12	Tuesday	September	Q3	2017	f
2190	2017-09-13	Wednesday	September	Q3	2017	f
2191	2017-09-14	Thursday	September	Q3	2017	f
2192	2017-09-15	Friday	September	Q3	2017	f
2193	2017-09-18	Monday	September	Q3	2017	f
2194	2017-09-19	Tuesday	September	Q3	2017	f
2195	2017-09-20	Wednesday	September	Q3	2017	f
2196	2017-09-21	Thursday	September	Q3	2017	f
2197	2017-09-22	Friday	September	Q3	2017	f
2198	2017-09-25	Monday	September	Q3	2017	f
2199	2017-09-26	Tuesday	September	Q3	2017	f
2200	2017-09-27	Wednesday	September	Q3	2017	f
2201	2017-09-28	Thursday	September	Q3	2017	f
2202	2017-09-29	Friday	September	Q3	2017	f
2203	2017-10-02	Monday	October	Q4	2017	f
2204	2017-10-03	Tuesday	October	Q4	2017	f
2205	2017-10-04	Wednesday	October	Q4	2017	f
2206	2017-10-05	Thursday	October	Q4	2017	f
2207	2017-10-06	Friday	October	Q4	2017	f
2208	2017-10-09	Monday	October	Q4	2017	f
2209	2017-10-10	Tuesday	October	Q4	2017	f
2210	2017-10-11	Wednesday	October	Q4	2017	f
2211	2017-10-12	Thursday	October	Q4	2017	f
2212	2017-10-13	Friday	October	Q4	2017	f
2213	2017-10-16	Monday	October	Q4	2017	f
2214	2017-10-17	Tuesday	October	Q4	2017	f
2215	2017-10-18	Wednesday	October	Q4	2017	f
2216	2017-10-19	Thursday	October	Q4	2017	f
2217	2017-10-20	Friday	October	Q4	2017	f
2218	2017-10-23	Monday	October	Q4	2017	f
2219	2017-10-24	Tuesday	October	Q4	2017	f
2220	2017-10-25	Wednesday	October	Q4	2017	f
2221	2017-10-26	Thursday	October	Q4	2017	f
2222	2017-10-27	Friday	October	Q4	2017	f
2223	2017-10-30	Monday	October	Q4	2017	f
2224	2017-10-31	Tuesday	October	Q4	2017	f
2225	2017-11-01	Wednesday	November	Q4	2017	f
2226	2017-11-02	Thursday	November	Q4	2017	f
2227	2017-11-03	Friday	November	Q4	2017	f
2228	2017-11-06	Monday	November	Q4	2017	f
2229	2017-11-07	Tuesday	November	Q4	2017	f
2230	2017-11-08	Wednesday	November	Q4	2017	f
2231	2017-11-09	Thursday	November	Q4	2017	f
2232	2017-11-10	Friday	November	Q4	2017	f
2233	2017-11-13	Monday	November	Q4	2017	f
2234	2017-11-14	Tuesday	November	Q4	2017	f
2235	2017-11-15	Wednesday	November	Q4	2017	f
2236	2017-11-16	Thursday	November	Q4	2017	f
2237	2017-11-17	Friday	November	Q4	2017	f
2238	2017-11-20	Monday	November	Q4	2017	f
2239	2017-11-21	Tuesday	November	Q4	2017	f
2240	2017-11-22	Wednesday	November	Q4	2017	f
2241	2017-11-24	Friday	November	Q4	2017	f
2242	2017-11-27	Monday	November	Q4	2017	f
2243	2017-11-28	Tuesday	November	Q4	2017	f
2244	2017-11-29	Wednesday	November	Q4	2017	f
2245	2017-11-30	Thursday	November	Q4	2017	f
2246	2017-12-01	Friday	December	Q4	2017	f
2247	2017-12-04	Monday	December	Q4	2017	f
2248	2017-12-05	Tuesday	December	Q4	2017	f
2249	2017-12-06	Wednesday	December	Q4	2017	f
2250	2017-12-07	Thursday	December	Q4	2017	f
2251	2017-12-08	Friday	December	Q4	2017	f
2252	2017-12-11	Monday	December	Q4	2017	f
2253	2017-12-12	Tuesday	December	Q4	2017	f
2254	2017-12-13	Wednesday	December	Q4	2017	f
2255	2017-12-14	Thursday	December	Q4	2017	f
2256	2017-12-15	Friday	December	Q4	2017	f
2257	2017-12-18	Monday	December	Q4	2017	f
2258	2017-12-19	Tuesday	December	Q4	2017	f
2259	2017-12-20	Wednesday	December	Q4	2017	f
2260	2017-12-21	Thursday	December	Q4	2017	f
2261	2017-12-22	Friday	December	Q4	2017	f
2262	2017-12-26	Tuesday	December	Q4	2017	f
2263	2017-12-27	Wednesday	December	Q4	2017	f
2264	2017-12-28	Thursday	December	Q4	2017	f
2265	2017-12-29	Friday	December	Q4	2017	f
2266	2018-01-02	Tuesday	January	Q1	2018	f
2267	2018-01-03	Wednesday	January	Q1	2018	f
2268	2018-01-04	Thursday	January	Q1	2018	f
2269	2018-01-05	Friday	January	Q1	2018	f
2270	2018-01-08	Monday	January	Q1	2018	f
2271	2018-01-09	Tuesday	January	Q1	2018	f
2272	2018-01-10	Wednesday	January	Q1	2018	f
2273	2018-01-11	Thursday	January	Q1	2018	f
2274	2018-01-12	Friday	January	Q1	2018	f
2275	2018-01-16	Tuesday	January	Q1	2018	f
2276	2018-01-17	Wednesday	January	Q1	2018	f
2277	2018-01-18	Thursday	January	Q1	2018	f
2278	2018-01-19	Friday	January	Q1	2018	f
2279	2018-01-22	Monday	January	Q1	2018	f
2280	2018-01-23	Tuesday	January	Q1	2018	f
2281	2018-01-24	Wednesday	January	Q1	2018	f
2282	2018-01-25	Thursday	January	Q1	2018	f
2283	2018-01-26	Friday	January	Q1	2018	f
2284	2018-01-29	Monday	January	Q1	2018	f
2285	2018-01-30	Tuesday	January	Q1	2018	f
2286	2018-01-31	Wednesday	January	Q1	2018	f
2287	2018-02-01	Thursday	February	Q1	2018	f
2288	2018-02-02	Friday	February	Q1	2018	f
2289	2018-02-05	Monday	February	Q1	2018	f
2290	2018-02-06	Tuesday	February	Q1	2018	f
2291	2018-02-07	Wednesday	February	Q1	2018	f
2292	2018-02-08	Thursday	February	Q1	2018	f
2293	2018-02-09	Friday	February	Q1	2018	f
2294	2018-02-12	Monday	February	Q1	2018	f
2295	2018-02-13	Tuesday	February	Q1	2018	f
2296	2018-02-14	Wednesday	February	Q1	2018	f
2297	2018-02-15	Thursday	February	Q1	2018	f
2298	2018-02-16	Friday	February	Q1	2018	f
2299	2018-02-20	Tuesday	February	Q1	2018	f
2300	2018-02-21	Wednesday	February	Q1	2018	f
2301	2018-02-22	Thursday	February	Q1	2018	f
2302	2018-02-23	Friday	February	Q1	2018	f
2303	2018-02-26	Monday	February	Q1	2018	f
2304	2018-02-27	Tuesday	February	Q1	2018	f
2305	2018-02-28	Wednesday	February	Q1	2018	f
2306	2018-03-01	Thursday	March	Q1	2018	f
2307	2018-03-02	Friday	March	Q1	2018	f
2308	2018-03-05	Monday	March	Q1	2018	f
2309	2018-03-06	Tuesday	March	Q1	2018	f
2310	2018-03-07	Wednesday	March	Q1	2018	f
2311	2018-03-08	Thursday	March	Q1	2018	f
2312	2018-03-09	Friday	March	Q1	2018	f
2313	2018-03-12	Monday	March	Q1	2018	f
2314	2018-03-13	Tuesday	March	Q1	2018	f
2315	2018-03-14	Wednesday	March	Q1	2018	f
2316	2018-03-15	Thursday	March	Q1	2018	f
2317	2018-03-16	Friday	March	Q1	2018	f
2318	2018-03-19	Monday	March	Q1	2018	f
2319	2018-03-20	Tuesday	March	Q1	2018	f
2320	2018-03-21	Wednesday	March	Q1	2018	f
2321	2018-03-22	Thursday	March	Q1	2018	f
2322	2018-03-23	Friday	March	Q1	2018	f
2323	2018-03-26	Monday	March	Q1	2018	f
2324	2018-03-27	Tuesday	March	Q1	2018	f
2325	2018-03-28	Wednesday	March	Q1	2018	f
2326	2018-03-29	Thursday	March	Q1	2018	f
2327	2018-04-02	Monday	April	Q2	2018	f
2328	2018-04-03	Tuesday	April	Q2	2018	f
2329	2018-04-04	Wednesday	April	Q2	2018	f
2330	2018-04-05	Thursday	April	Q2	2018	f
2331	2018-04-06	Friday	April	Q2	2018	f
2332	2018-04-09	Monday	April	Q2	2018	f
2333	2018-04-10	Tuesday	April	Q2	2018	f
2334	2018-04-11	Wednesday	April	Q2	2018	f
2335	2018-04-12	Thursday	April	Q2	2018	f
2336	2018-04-13	Friday	April	Q2	2018	f
2337	2018-04-16	Monday	April	Q2	2018	f
2338	2018-04-17	Tuesday	April	Q2	2018	f
2339	2018-04-18	Wednesday	April	Q2	2018	f
2340	2018-04-19	Thursday	April	Q2	2018	f
2341	2018-04-20	Friday	April	Q2	2018	f
2342	2018-04-23	Monday	April	Q2	2018	f
2343	2018-04-24	Tuesday	April	Q2	2018	f
2344	2018-04-25	Wednesday	April	Q2	2018	f
2345	2018-04-26	Thursday	April	Q2	2018	f
2346	2018-04-27	Friday	April	Q2	2018	f
2347	2018-04-30	Monday	April	Q2	2018	f
2348	2018-05-01	Tuesday	May	Q2	2018	f
2349	2018-05-02	Wednesday	May	Q2	2018	f
2350	2018-05-03	Thursday	May	Q2	2018	f
2351	2018-05-04	Friday	May	Q2	2018	f
2352	2018-05-07	Monday	May	Q2	2018	f
2353	2018-05-08	Tuesday	May	Q2	2018	f
2354	2018-05-09	Wednesday	May	Q2	2018	f
2355	2018-05-10	Thursday	May	Q2	2018	f
2356	2018-05-11	Friday	May	Q2	2018	f
2357	2018-05-14	Monday	May	Q2	2018	f
2358	2018-05-15	Tuesday	May	Q2	2018	f
2359	2018-05-16	Wednesday	May	Q2	2018	f
2360	2018-05-17	Thursday	May	Q2	2018	f
2361	2018-05-18	Friday	May	Q2	2018	f
2362	2018-05-21	Monday	May	Q2	2018	f
2363	2018-05-22	Tuesday	May	Q2	2018	f
2364	2018-05-23	Wednesday	May	Q2	2018	f
2365	2018-05-24	Thursday	May	Q2	2018	f
2366	2018-05-25	Friday	May	Q2	2018	f
2367	2018-05-29	Tuesday	May	Q2	2018	f
2368	2018-05-30	Wednesday	May	Q2	2018	f
2369	2018-05-31	Thursday	May	Q2	2018	f
2370	2018-06-01	Friday	June	Q2	2018	f
2371	2018-06-04	Monday	June	Q2	2018	f
2372	2018-06-05	Tuesday	June	Q2	2018	f
2373	2018-06-06	Wednesday	June	Q2	2018	f
2374	2018-06-07	Thursday	June	Q2	2018	f
2375	2018-06-08	Friday	June	Q2	2018	f
2376	2018-06-11	Monday	June	Q2	2018	f
2377	2018-06-12	Tuesday	June	Q2	2018	f
2378	2018-06-13	Wednesday	June	Q2	2018	f
2379	2018-06-14	Thursday	June	Q2	2018	f
2380	2018-06-15	Friday	June	Q2	2018	f
2381	2018-06-18	Monday	June	Q2	2018	f
2382	2018-06-19	Tuesday	June	Q2	2018	f
2383	2018-06-20	Wednesday	June	Q2	2018	f
2384	2018-06-21	Thursday	June	Q2	2018	f
2385	2018-06-22	Friday	June	Q2	2018	f
2386	2018-06-25	Monday	June	Q2	2018	f
2387	2018-06-26	Tuesday	June	Q2	2018	f
2388	2018-06-27	Wednesday	June	Q2	2018	f
2389	2018-06-28	Thursday	June	Q2	2018	f
2390	2018-06-29	Friday	June	Q2	2018	f
2391	2018-07-02	Monday	July	Q3	2018	f
2392	2018-07-03	Tuesday	July	Q3	2018	f
2393	2018-07-05	Thursday	July	Q3	2018	f
2394	2018-07-06	Friday	July	Q3	2018	f
2395	2018-07-09	Monday	July	Q3	2018	f
2396	2018-07-10	Tuesday	July	Q3	2018	f
2397	2018-07-11	Wednesday	July	Q3	2018	f
2398	2018-07-12	Thursday	July	Q3	2018	f
2399	2018-07-13	Friday	July	Q3	2018	f
2400	2018-07-16	Monday	July	Q3	2018	f
2401	2018-07-17	Tuesday	July	Q3	2018	f
2402	2018-07-18	Wednesday	July	Q3	2018	f
2403	2018-07-19	Thursday	July	Q3	2018	f
2404	2018-07-20	Friday	July	Q3	2018	f
2405	2018-07-23	Monday	July	Q3	2018	f
2406	2018-07-24	Tuesday	July	Q3	2018	f
2407	2018-07-25	Wednesday	July	Q3	2018	f
2408	2018-07-26	Thursday	July	Q3	2018	f
2409	2018-07-27	Friday	July	Q3	2018	f
2410	2018-07-30	Monday	July	Q3	2018	f
2411	2018-07-31	Tuesday	July	Q3	2018	f
2412	2018-08-01	Wednesday	August	Q3	2018	f
2413	2018-08-02	Thursday	August	Q3	2018	f
2414	2018-08-03	Friday	August	Q3	2018	f
2415	2018-08-06	Monday	August	Q3	2018	f
2416	2018-08-07	Tuesday	August	Q3	2018	f
2417	2018-08-08	Wednesday	August	Q3	2018	f
2418	2018-08-09	Thursday	August	Q3	2018	f
2419	2018-08-10	Friday	August	Q3	2018	f
2420	2018-08-13	Monday	August	Q3	2018	f
2421	2018-08-14	Tuesday	August	Q3	2018	f
2422	2018-08-15	Wednesday	August	Q3	2018	f
2423	2018-08-16	Thursday	August	Q3	2018	f
2424	2018-08-17	Friday	August	Q3	2018	f
2425	2018-08-20	Monday	August	Q3	2018	f
2426	2018-08-21	Tuesday	August	Q3	2018	f
2427	2018-08-22	Wednesday	August	Q3	2018	f
2428	2018-08-23	Thursday	August	Q3	2018	f
2429	2018-08-24	Friday	August	Q3	2018	f
2430	2018-08-27	Monday	August	Q3	2018	f
2431	2018-08-28	Tuesday	August	Q3	2018	f
2432	2018-08-29	Wednesday	August	Q3	2018	f
2433	2018-08-30	Thursday	August	Q3	2018	f
2434	2018-08-31	Friday	August	Q3	2018	f
2435	2018-09-04	Tuesday	September	Q3	2018	f
2436	2018-09-05	Wednesday	September	Q3	2018	f
2437	2018-09-06	Thursday	September	Q3	2018	f
2438	2018-09-07	Friday	September	Q3	2018	f
2439	2018-09-10	Monday	September	Q3	2018	f
2440	2018-09-11	Tuesday	September	Q3	2018	f
2441	2018-09-12	Wednesday	September	Q3	2018	f
2442	2018-09-13	Thursday	September	Q3	2018	f
2443	2018-09-14	Friday	September	Q3	2018	f
2444	2018-09-17	Monday	September	Q3	2018	f
2445	2018-09-18	Tuesday	September	Q3	2018	f
2446	2018-09-19	Wednesday	September	Q3	2018	f
2447	2018-09-20	Thursday	September	Q3	2018	f
2448	2018-09-21	Friday	September	Q3	2018	f
2449	2018-09-24	Monday	September	Q3	2018	f
2450	2018-09-25	Tuesday	September	Q3	2018	f
2451	2018-09-26	Wednesday	September	Q3	2018	f
2452	2018-09-27	Thursday	September	Q3	2018	f
2453	2018-09-28	Friday	September	Q3	2018	f
2454	2018-10-01	Monday	October	Q4	2018	f
2455	2018-10-02	Tuesday	October	Q4	2018	f
2456	2018-10-03	Wednesday	October	Q4	2018	f
2457	2018-10-04	Thursday	October	Q4	2018	f
2458	2018-10-05	Friday	October	Q4	2018	f
2459	2018-10-08	Monday	October	Q4	2018	f
2460	2018-10-09	Tuesday	October	Q4	2018	f
2461	2018-10-10	Wednesday	October	Q4	2018	f
2462	2018-10-11	Thursday	October	Q4	2018	f
2463	2018-10-12	Friday	October	Q4	2018	f
2464	2018-10-15	Monday	October	Q4	2018	f
2465	2018-10-16	Tuesday	October	Q4	2018	f
2466	2018-10-17	Wednesday	October	Q4	2018	f
2467	2018-10-18	Thursday	October	Q4	2018	f
2468	2018-10-19	Friday	October	Q4	2018	f
2469	2018-10-22	Monday	October	Q4	2018	f
2470	2018-10-23	Tuesday	October	Q4	2018	f
2471	2018-10-24	Wednesday	October	Q4	2018	f
2472	2018-10-25	Thursday	October	Q4	2018	f
2473	2018-10-26	Friday	October	Q4	2018	f
2474	2018-10-29	Monday	October	Q4	2018	f
2475	2018-10-30	Tuesday	October	Q4	2018	f
2476	2018-10-31	Wednesday	October	Q4	2018	f
2477	2018-11-01	Thursday	November	Q4	2018	f
2478	2018-11-02	Friday	November	Q4	2018	f
2479	2018-11-05	Monday	November	Q4	2018	f
2480	2018-11-06	Tuesday	November	Q4	2018	f
2481	2018-11-07	Wednesday	November	Q4	2018	f
2482	2018-11-08	Thursday	November	Q4	2018	f
2483	2018-11-09	Friday	November	Q4	2018	f
2484	2018-11-12	Monday	November	Q4	2018	f
2485	2018-11-13	Tuesday	November	Q4	2018	f
2486	2018-11-14	Wednesday	November	Q4	2018	f
2487	2018-11-15	Thursday	November	Q4	2018	f
2488	2018-11-16	Friday	November	Q4	2018	f
2489	2018-11-19	Monday	November	Q4	2018	f
2490	2018-11-20	Tuesday	November	Q4	2018	f
2491	2018-11-21	Wednesday	November	Q4	2018	f
2492	2018-11-23	Friday	November	Q4	2018	f
2493	2018-11-26	Monday	November	Q4	2018	f
2494	2018-11-27	Tuesday	November	Q4	2018	f
2495	2018-11-28	Wednesday	November	Q4	2018	f
2496	2018-11-29	Thursday	November	Q4	2018	f
2497	2018-11-30	Friday	November	Q4	2018	f
2498	2018-12-03	Monday	December	Q4	2018	f
2499	2018-12-04	Tuesday	December	Q4	2018	f
2500	2018-12-06	Thursday	December	Q4	2018	f
2501	2018-12-07	Friday	December	Q4	2018	f
2502	2018-12-10	Monday	December	Q4	2018	f
2503	2018-12-11	Tuesday	December	Q4	2018	f
2504	2018-12-12	Wednesday	December	Q4	2018	f
2505	2018-12-13	Thursday	December	Q4	2018	f
2506	2018-12-14	Friday	December	Q4	2018	f
2507	2018-12-17	Monday	December	Q4	2018	f
2508	2018-12-18	Tuesday	December	Q4	2018	f
2509	2018-12-19	Wednesday	December	Q4	2018	f
2510	2018-12-20	Thursday	December	Q4	2018	f
2511	2018-12-21	Friday	December	Q4	2018	f
2512	2018-12-24	Monday	December	Q4	2018	f
2513	2018-12-26	Wednesday	December	Q4	2018	f
2514	2018-12-27	Thursday	December	Q4	2018	f
2515	2018-12-28	Friday	December	Q4	2018	f
2516	2018-12-31	Monday	December	Q4	2018	f
2517	2019-01-02	Wednesday	January	Q1	2019	f
2518	2019-01-03	Thursday	January	Q1	2019	f
2519	2019-01-04	Friday	January	Q1	2019	f
2520	2019-01-07	Monday	January	Q1	2019	f
2521	2019-01-08	Tuesday	January	Q1	2019	f
2522	2019-01-09	Wednesday	January	Q1	2019	f
2523	2019-01-10	Thursday	January	Q1	2019	f
2524	2019-01-11	Friday	January	Q1	2019	f
2525	2019-01-14	Monday	January	Q1	2019	f
2526	2019-01-15	Tuesday	January	Q1	2019	f
2527	2019-01-16	Wednesday	January	Q1	2019	f
2528	2019-01-17	Thursday	January	Q1	2019	f
2529	2019-01-18	Friday	January	Q1	2019	f
2530	2019-01-22	Tuesday	January	Q1	2019	f
2531	2019-01-23	Wednesday	January	Q1	2019	f
2532	2019-01-24	Thursday	January	Q1	2019	f
2533	2019-01-25	Friday	January	Q1	2019	f
2534	2019-01-28	Monday	January	Q1	2019	f
2535	2019-01-29	Tuesday	January	Q1	2019	f
2536	2019-01-30	Wednesday	January	Q1	2019	f
2537	2019-01-31	Thursday	January	Q1	2019	f
2538	2019-02-01	Friday	February	Q1	2019	f
2539	2019-02-04	Monday	February	Q1	2019	f
2540	2019-02-05	Tuesday	February	Q1	2019	f
2541	2019-02-06	Wednesday	February	Q1	2019	f
2542	2019-02-07	Thursday	February	Q1	2019	f
2543	2019-02-08	Friday	February	Q1	2019	f
2544	2019-02-11	Monday	February	Q1	2019	f
2545	2019-02-12	Tuesday	February	Q1	2019	f
2546	2019-02-13	Wednesday	February	Q1	2019	f
2547	2019-02-14	Thursday	February	Q1	2019	f
2548	2019-02-15	Friday	February	Q1	2019	f
2549	2019-02-19	Tuesday	February	Q1	2019	f
2550	2019-02-20	Wednesday	February	Q1	2019	f
2551	2019-02-21	Thursday	February	Q1	2019	f
2552	2019-02-22	Friday	February	Q1	2019	f
2553	2019-02-25	Monday	February	Q1	2019	f
2554	2019-02-26	Tuesday	February	Q1	2019	f
2555	2019-02-27	Wednesday	February	Q1	2019	f
2556	2019-02-28	Thursday	February	Q1	2019	f
2557	2019-03-01	Friday	March	Q1	2019	f
2558	2019-03-04	Monday	March	Q1	2019	f
2559	2019-03-05	Tuesday	March	Q1	2019	f
2560	2019-03-06	Wednesday	March	Q1	2019	f
2561	2019-03-07	Thursday	March	Q1	2019	f
2562	2019-03-08	Friday	March	Q1	2019	f
2563	2019-03-11	Monday	March	Q1	2019	f
2564	2019-03-12	Tuesday	March	Q1	2019	f
2565	2019-03-13	Wednesday	March	Q1	2019	f
2566	2019-03-14	Thursday	March	Q1	2019	f
2567	2019-03-15	Friday	March	Q1	2019	f
2568	2019-03-18	Monday	March	Q1	2019	f
2569	2019-03-19	Tuesday	March	Q1	2019	f
2570	2019-03-20	Wednesday	March	Q1	2019	f
2571	2019-03-21	Thursday	March	Q1	2019	f
2572	2019-03-22	Friday	March	Q1	2019	f
2573	2019-03-25	Monday	March	Q1	2019	f
2574	2019-03-26	Tuesday	March	Q1	2019	f
2575	2019-03-27	Wednesday	March	Q1	2019	f
2576	2019-03-28	Thursday	March	Q1	2019	f
2577	2019-03-29	Friday	March	Q1	2019	f
2578	2019-04-01	Monday	April	Q2	2019	f
2579	2019-04-02	Tuesday	April	Q2	2019	f
2580	2019-04-03	Wednesday	April	Q2	2019	f
2581	2019-04-04	Thursday	April	Q2	2019	f
2582	2019-04-05	Friday	April	Q2	2019	f
2583	2019-04-08	Monday	April	Q2	2019	f
2584	2019-04-09	Tuesday	April	Q2	2019	f
2585	2019-04-10	Wednesday	April	Q2	2019	f
2586	2019-04-11	Thursday	April	Q2	2019	f
2587	2019-04-12	Friday	April	Q2	2019	f
2588	2019-04-15	Monday	April	Q2	2019	f
2589	2019-04-16	Tuesday	April	Q2	2019	f
2590	2019-04-17	Wednesday	April	Q2	2019	f
2591	2019-04-18	Thursday	April	Q2	2019	f
2592	2019-04-22	Monday	April	Q2	2019	f
2593	2019-04-23	Tuesday	April	Q2	2019	f
2594	2019-04-24	Wednesday	April	Q2	2019	f
2595	2019-04-25	Thursday	April	Q2	2019	f
2596	2019-04-26	Friday	April	Q2	2019	f
2597	2019-04-29	Monday	April	Q2	2019	f
2598	2019-04-30	Tuesday	April	Q2	2019	f
2599	2019-05-01	Wednesday	May	Q2	2019	f
2600	2019-05-02	Thursday	May	Q2	2019	f
2601	2019-05-03	Friday	May	Q2	2019	f
2602	2019-05-06	Monday	May	Q2	2019	f
2603	2019-05-07	Tuesday	May	Q2	2019	f
2604	2019-05-08	Wednesday	May	Q2	2019	f
2605	2019-05-09	Thursday	May	Q2	2019	f
2606	2019-05-10	Friday	May	Q2	2019	f
2607	2019-05-13	Monday	May	Q2	2019	f
2608	2019-05-14	Tuesday	May	Q2	2019	f
2609	2019-05-15	Wednesday	May	Q2	2019	f
2610	2019-05-16	Thursday	May	Q2	2019	f
2611	2019-05-17	Friday	May	Q2	2019	f
2612	2019-05-20	Monday	May	Q2	2019	f
2613	2019-05-21	Tuesday	May	Q2	2019	f
2614	2019-05-22	Wednesday	May	Q2	2019	f
2615	2019-05-23	Thursday	May	Q2	2019	f
2616	2019-05-24	Friday	May	Q2	2019	f
2617	2019-05-28	Tuesday	May	Q2	2019	f
2618	2019-05-29	Wednesday	May	Q2	2019	f
2619	2019-05-30	Thursday	May	Q2	2019	f
2620	2019-05-31	Friday	May	Q2	2019	f
2621	2019-06-03	Monday	June	Q2	2019	f
2622	2019-06-04	Tuesday	June	Q2	2019	f
2623	2019-06-05	Wednesday	June	Q2	2019	f
2624	2019-06-06	Thursday	June	Q2	2019	f
2625	2019-06-07	Friday	June	Q2	2019	f
2626	2019-06-10	Monday	June	Q2	2019	f
2627	2019-06-11	Tuesday	June	Q2	2019	f
2628	2019-06-12	Wednesday	June	Q2	2019	f
2629	2019-06-13	Thursday	June	Q2	2019	f
2630	2019-06-14	Friday	June	Q2	2019	f
2631	2019-06-17	Monday	June	Q2	2019	f
2632	2019-06-18	Tuesday	June	Q2	2019	f
2633	2019-06-19	Wednesday	June	Q2	2019	f
2634	2019-06-20	Thursday	June	Q2	2019	f
2635	2019-06-21	Friday	June	Q2	2019	f
2636	2019-06-24	Monday	June	Q2	2019	f
2637	2019-06-25	Tuesday	June	Q2	2019	f
2638	2019-06-26	Wednesday	June	Q2	2019	f
2639	2019-06-27	Thursday	June	Q2	2019	f
2640	2019-06-28	Friday	June	Q2	2019	f
2641	2019-07-01	Monday	July	Q3	2019	f
2642	2019-07-02	Tuesday	July	Q3	2019	f
2643	2019-07-03	Wednesday	July	Q3	2019	f
2644	2019-07-05	Friday	July	Q3	2019	f
2645	2019-07-08	Monday	July	Q3	2019	f
2646	2019-07-09	Tuesday	July	Q3	2019	f
2647	2019-07-10	Wednesday	July	Q3	2019	f
2648	2019-07-11	Thursday	July	Q3	2019	f
2649	2019-07-12	Friday	July	Q3	2019	f
2650	2019-07-15	Monday	July	Q3	2019	f
2651	2019-07-16	Tuesday	July	Q3	2019	f
2652	2019-07-17	Wednesday	July	Q3	2019	f
2653	2019-07-18	Thursday	July	Q3	2019	f
2654	2019-07-19	Friday	July	Q3	2019	f
2655	2019-07-22	Monday	July	Q3	2019	f
2656	2019-07-23	Tuesday	July	Q3	2019	f
2657	2019-07-24	Wednesday	July	Q3	2019	f
2658	2019-07-25	Thursday	July	Q3	2019	f
2659	2019-07-26	Friday	July	Q3	2019	f
2660	2019-07-29	Monday	July	Q3	2019	f
2661	2019-07-30	Tuesday	July	Q3	2019	f
2662	2019-07-31	Wednesday	July	Q3	2019	f
2663	2019-08-01	Thursday	August	Q3	2019	f
2664	2019-08-02	Friday	August	Q3	2019	f
2665	2019-08-05	Monday	August	Q3	2019	f
2666	2019-08-06	Tuesday	August	Q3	2019	f
2667	2019-08-07	Wednesday	August	Q3	2019	f
2668	2019-08-08	Thursday	August	Q3	2019	f
2669	2019-08-09	Friday	August	Q3	2019	f
2670	2019-08-12	Monday	August	Q3	2019	f
2671	2019-08-13	Tuesday	August	Q3	2019	f
2672	2019-08-14	Wednesday	August	Q3	2019	f
2673	2019-08-15	Thursday	August	Q3	2019	f
2674	2019-08-16	Friday	August	Q3	2019	f
2675	2019-08-19	Monday	August	Q3	2019	f
2676	2019-08-20	Tuesday	August	Q3	2019	f
2677	2019-08-21	Wednesday	August	Q3	2019	f
2678	2019-08-22	Thursday	August	Q3	2019	f
2679	2019-08-23	Friday	August	Q3	2019	f
2680	2019-08-26	Monday	August	Q3	2019	f
2681	2019-08-27	Tuesday	August	Q3	2019	f
2682	2019-08-28	Wednesday	August	Q3	2019	f
2683	2019-08-29	Thursday	August	Q3	2019	f
2684	2019-08-30	Friday	August	Q3	2019	f
2685	2019-09-03	Tuesday	September	Q3	2019	f
2686	2019-09-04	Wednesday	September	Q3	2019	f
2687	2019-09-05	Thursday	September	Q3	2019	f
2688	2019-09-06	Friday	September	Q3	2019	f
2689	2019-09-09	Monday	September	Q3	2019	f
2690	2019-09-10	Tuesday	September	Q3	2019	f
2691	2019-09-11	Wednesday	September	Q3	2019	f
2692	2019-09-12	Thursday	September	Q3	2019	f
2693	2019-09-13	Friday	September	Q3	2019	f
2694	2019-09-16	Monday	September	Q3	2019	f
2695	2019-09-17	Tuesday	September	Q3	2019	f
2696	2019-09-18	Wednesday	September	Q3	2019	f
2697	2019-09-19	Thursday	September	Q3	2019	f
2698	2019-09-20	Friday	September	Q3	2019	f
2699	2019-09-23	Monday	September	Q3	2019	f
2700	2019-09-24	Tuesday	September	Q3	2019	f
2701	2019-09-25	Wednesday	September	Q3	2019	f
2702	2019-09-26	Thursday	September	Q3	2019	f
2703	2019-09-27	Friday	September	Q3	2019	f
2704	2019-09-30	Monday	September	Q3	2019	f
2705	2019-10-01	Tuesday	October	Q4	2019	f
2706	2019-10-02	Wednesday	October	Q4	2019	f
2707	2019-10-03	Thursday	October	Q4	2019	f
2708	2019-10-04	Friday	October	Q4	2019	f
2709	2019-10-07	Monday	October	Q4	2019	f
2710	2019-10-08	Tuesday	October	Q4	2019	f
2711	2019-10-09	Wednesday	October	Q4	2019	f
2712	2019-10-10	Thursday	October	Q4	2019	f
2713	2019-10-11	Friday	October	Q4	2019	f
2714	2019-10-14	Monday	October	Q4	2019	f
2715	2019-10-15	Tuesday	October	Q4	2019	f
2716	2019-10-16	Wednesday	October	Q4	2019	f
2717	2019-10-17	Thursday	October	Q4	2019	f
2718	2019-10-18	Friday	October	Q4	2019	f
2719	2019-10-21	Monday	October	Q4	2019	f
2720	2019-10-22	Tuesday	October	Q4	2019	f
2721	2019-10-23	Wednesday	October	Q4	2019	f
2722	2019-10-24	Thursday	October	Q4	2019	f
2723	2019-10-25	Friday	October	Q4	2019	f
2724	2019-10-28	Monday	October	Q4	2019	f
2725	2019-10-29	Tuesday	October	Q4	2019	f
2726	2019-10-30	Wednesday	October	Q4	2019	f
2727	2019-10-31	Thursday	October	Q4	2019	f
2728	2019-11-01	Friday	November	Q4	2019	f
2729	2019-11-04	Monday	November	Q4	2019	f
2730	2019-11-05	Tuesday	November	Q4	2019	f
2731	2019-11-06	Wednesday	November	Q4	2019	f
2732	2019-11-07	Thursday	November	Q4	2019	f
2733	2019-11-08	Friday	November	Q4	2019	f
2734	2019-11-11	Monday	November	Q4	2019	f
2735	2019-11-12	Tuesday	November	Q4	2019	f
2736	2019-11-13	Wednesday	November	Q4	2019	f
2737	2019-11-14	Thursday	November	Q4	2019	f
2738	2019-11-15	Friday	November	Q4	2019	f
2739	2019-11-18	Monday	November	Q4	2019	f
2740	2019-11-19	Tuesday	November	Q4	2019	f
2741	2019-11-20	Wednesday	November	Q4	2019	f
2742	2019-11-21	Thursday	November	Q4	2019	f
2743	2019-11-22	Friday	November	Q4	2019	f
2744	2019-11-25	Monday	November	Q4	2019	f
2745	2019-11-26	Tuesday	November	Q4	2019	f
2746	2019-11-27	Wednesday	November	Q4	2019	f
2747	2019-11-29	Friday	November	Q4	2019	f
2748	2019-12-02	Monday	December	Q4	2019	f
2749	2019-12-03	Tuesday	December	Q4	2019	f
2750	2019-12-04	Wednesday	December	Q4	2019	f
2751	2019-12-05	Thursday	December	Q4	2019	f
2752	2019-12-06	Friday	December	Q4	2019	f
2753	2019-12-09	Monday	December	Q4	2019	f
2754	2019-12-10	Tuesday	December	Q4	2019	f
2755	2019-12-11	Wednesday	December	Q4	2019	f
2756	2019-12-12	Thursday	December	Q4	2019	f
2757	2019-12-13	Friday	December	Q4	2019	f
2758	2019-12-16	Monday	December	Q4	2019	f
2759	2019-12-17	Tuesday	December	Q4	2019	f
2760	2019-12-18	Wednesday	December	Q4	2019	f
2761	2019-12-19	Thursday	December	Q4	2019	f
2762	2019-12-20	Friday	December	Q4	2019	f
2763	2019-12-23	Monday	December	Q4	2019	f
2764	2019-12-24	Tuesday	December	Q4	2019	f
2765	2019-12-26	Thursday	December	Q4	2019	f
2766	2019-12-27	Friday	December	Q4	2019	f
2767	2019-12-30	Monday	December	Q4	2019	f
2768	2019-12-31	Tuesday	December	Q4	2019	f
2769	2020-01-02	Thursday	January	Q1	2020	f
2770	2020-01-03	Friday	January	Q1	2020	f
2771	2020-01-06	Monday	January	Q1	2020	f
2772	2020-01-07	Tuesday	January	Q1	2020	f
2773	2020-01-08	Wednesday	January	Q1	2020	f
2774	2020-01-09	Thursday	January	Q1	2020	f
2775	2020-01-10	Friday	January	Q1	2020	f
2776	2020-01-13	Monday	January	Q1	2020	f
2777	2020-01-14	Tuesday	January	Q1	2020	f
2778	2020-01-15	Wednesday	January	Q1	2020	f
2779	2020-01-16	Thursday	January	Q1	2020	f
2780	2020-01-17	Friday	January	Q1	2020	f
2781	2020-01-21	Tuesday	January	Q1	2020	f
2782	2020-01-22	Wednesday	January	Q1	2020	f
2783	2020-01-23	Thursday	January	Q1	2020	f
2784	2020-01-24	Friday	January	Q1	2020	f
2785	2020-01-27	Monday	January	Q1	2020	f
2786	2020-01-28	Tuesday	January	Q1	2020	f
2787	2020-01-29	Wednesday	January	Q1	2020	f
2788	2020-01-30	Thursday	January	Q1	2020	f
2789	2020-01-31	Friday	January	Q1	2020	f
2790	2020-02-03	Monday	February	Q1	2020	f
2791	2020-02-04	Tuesday	February	Q1	2020	f
2792	2020-02-05	Wednesday	February	Q1	2020	f
2793	2020-02-06	Thursday	February	Q1	2020	f
2794	2020-02-07	Friday	February	Q1	2020	f
2795	2020-02-10	Monday	February	Q1	2020	f
2796	2020-02-11	Tuesday	February	Q1	2020	f
2797	2020-02-12	Wednesday	February	Q1	2020	f
2798	2020-02-13	Thursday	February	Q1	2020	f
2799	2020-02-14	Friday	February	Q1	2020	f
2800	2020-02-18	Tuesday	February	Q1	2020	f
2801	2020-02-19	Wednesday	February	Q1	2020	f
2802	2020-02-20	Thursday	February	Q1	2020	f
2803	2020-02-21	Friday	February	Q1	2020	f
2804	2020-02-24	Monday	February	Q1	2020	f
2805	2020-02-25	Tuesday	February	Q1	2020	f
2806	2020-02-26	Wednesday	February	Q1	2020	f
2807	2020-02-27	Thursday	February	Q1	2020	f
2808	2020-02-28	Friday	February	Q1	2020	f
2809	2020-03-02	Monday	March	Q1	2020	f
2810	2020-03-03	Tuesday	March	Q1	2020	f
2811	2020-03-04	Wednesday	March	Q1	2020	f
2812	2020-03-05	Thursday	March	Q1	2020	f
2813	2020-03-06	Friday	March	Q1	2020	f
2814	2020-03-09	Monday	March	Q1	2020	f
2815	2020-03-10	Tuesday	March	Q1	2020	f
2816	2020-03-11	Wednesday	March	Q1	2020	f
2817	2020-03-12	Thursday	March	Q1	2020	f
2818	2020-03-13	Friday	March	Q1	2020	f
2819	2020-03-16	Monday	March	Q1	2020	f
2820	2020-03-17	Tuesday	March	Q1	2020	f
2821	2020-03-18	Wednesday	March	Q1	2020	f
2822	2020-03-19	Thursday	March	Q1	2020	f
2823	2020-03-20	Friday	March	Q1	2020	f
2824	2020-03-23	Monday	March	Q1	2020	f
2825	2020-03-24	Tuesday	March	Q1	2020	f
2826	2020-03-25	Wednesday	March	Q1	2020	f
2827	2020-03-26	Thursday	March	Q1	2020	f
2828	2020-03-27	Friday	March	Q1	2020	f
2829	2020-03-30	Monday	March	Q1	2020	f
2830	2020-03-31	Tuesday	March	Q1	2020	f
2831	2020-04-01	Wednesday	April	Q2	2020	f
2832	2020-04-02	Thursday	April	Q2	2020	f
2833	2020-04-03	Friday	April	Q2	2020	f
2834	2020-04-06	Monday	April	Q2	2020	f
2835	2020-04-07	Tuesday	April	Q2	2020	f
2836	2020-04-08	Wednesday	April	Q2	2020	f
2837	2020-04-09	Thursday	April	Q2	2020	f
2838	2020-04-13	Monday	April	Q2	2020	f
2839	2020-04-14	Tuesday	April	Q2	2020	f
2840	2020-04-15	Wednesday	April	Q2	2020	f
2841	2020-04-16	Thursday	April	Q2	2020	f
2842	2020-04-17	Friday	April	Q2	2020	f
2843	2020-04-20	Monday	April	Q2	2020	f
2844	2020-04-21	Tuesday	April	Q2	2020	f
2845	2020-04-22	Wednesday	April	Q2	2020	f
2846	2020-04-23	Thursday	April	Q2	2020	f
2847	2020-04-24	Friday	April	Q2	2020	f
2848	2020-04-27	Monday	April	Q2	2020	f
2849	2020-04-28	Tuesday	April	Q2	2020	f
2850	2020-04-29	Wednesday	April	Q2	2020	f
2851	2020-04-30	Thursday	April	Q2	2020	f
2852	2020-05-01	Friday	May	Q2	2020	f
2853	2020-05-04	Monday	May	Q2	2020	f
2854	2020-05-05	Tuesday	May	Q2	2020	f
2855	2020-05-06	Wednesday	May	Q2	2020	f
2856	2020-05-07	Thursday	May	Q2	2020	f
2857	2020-05-08	Friday	May	Q2	2020	f
2858	2020-05-11	Monday	May	Q2	2020	f
2859	2020-05-12	Tuesday	May	Q2	2020	f
2860	2020-05-13	Wednesday	May	Q2	2020	f
2861	2020-05-14	Thursday	May	Q2	2020	f
2862	2020-05-15	Friday	May	Q2	2020	f
2863	2020-05-18	Monday	May	Q2	2020	f
2864	2020-05-19	Tuesday	May	Q2	2020	f
2865	2020-05-20	Wednesday	May	Q2	2020	f
2866	2020-05-21	Thursday	May	Q2	2020	f
2867	2020-05-22	Friday	May	Q2	2020	f
2868	2020-05-26	Tuesday	May	Q2	2020	f
2869	2020-05-27	Wednesday	May	Q2	2020	f
2870	2020-05-28	Thursday	May	Q2	2020	f
2871	2020-05-29	Friday	May	Q2	2020	f
2872	2020-06-01	Monday	June	Q2	2020	f
2873	2020-06-02	Tuesday	June	Q2	2020	f
2874	2020-06-03	Wednesday	June	Q2	2020	f
2875	2020-06-04	Thursday	June	Q2	2020	f
2876	2020-06-05	Friday	June	Q2	2020	f
2877	2020-06-08	Monday	June	Q2	2020	f
2878	2020-06-09	Tuesday	June	Q2	2020	f
2879	2020-06-10	Wednesday	June	Q2	2020	f
2880	2020-06-11	Thursday	June	Q2	2020	f
2881	2020-06-12	Friday	June	Q2	2020	f
2882	2020-06-15	Monday	June	Q2	2020	f
2883	2020-06-16	Tuesday	June	Q2	2020	f
2884	2020-06-17	Wednesday	June	Q2	2020	f
2885	2020-06-18	Thursday	June	Q2	2020	f
2886	2020-06-19	Friday	June	Q2	2020	f
2887	2020-06-22	Monday	June	Q2	2020	f
2888	2020-06-23	Tuesday	June	Q2	2020	f
2889	2020-06-24	Wednesday	June	Q2	2020	f
2890	2020-06-25	Thursday	June	Q2	2020	f
2891	2020-06-26	Friday	June	Q2	2020	f
2892	2020-06-29	Monday	June	Q2	2020	f
2893	2020-06-30	Tuesday	June	Q2	2020	f
2894	2020-07-01	Wednesday	July	Q3	2020	f
2895	2020-07-02	Thursday	July	Q3	2020	f
2896	2020-07-06	Monday	July	Q3	2020	f
2897	2020-07-07	Tuesday	July	Q3	2020	f
2898	2020-07-08	Wednesday	July	Q3	2020	f
2899	2020-07-09	Thursday	July	Q3	2020	f
2900	2020-07-10	Friday	July	Q3	2020	f
2901	2020-07-13	Monday	July	Q3	2020	f
2902	2020-07-14	Tuesday	July	Q3	2020	f
2903	2020-07-15	Wednesday	July	Q3	2020	f
2904	2020-07-16	Thursday	July	Q3	2020	f
2905	2020-07-17	Friday	July	Q3	2020	f
2906	2020-07-20	Monday	July	Q3	2020	f
2907	2020-07-21	Tuesday	July	Q3	2020	f
2908	2020-07-22	Wednesday	July	Q3	2020	f
2909	2020-07-23	Thursday	July	Q3	2020	f
2910	2020-07-24	Friday	July	Q3	2020	f
2911	2020-07-27	Monday	July	Q3	2020	f
2912	2020-07-28	Tuesday	July	Q3	2020	f
2913	2020-07-29	Wednesday	July	Q3	2020	f
2914	2020-07-30	Thursday	July	Q3	2020	f
2915	2020-07-31	Friday	July	Q3	2020	f
2916	2020-08-03	Monday	August	Q3	2020	f
2917	2020-08-04	Tuesday	August	Q3	2020	f
2918	2020-08-05	Wednesday	August	Q3	2020	f
2919	2020-08-06	Thursday	August	Q3	2020	f
2920	2020-08-07	Friday	August	Q3	2020	f
2921	2020-08-10	Monday	August	Q3	2020	f
2922	2020-08-11	Tuesday	August	Q3	2020	f
2923	2020-08-12	Wednesday	August	Q3	2020	f
2924	2020-08-13	Thursday	August	Q3	2020	f
2925	2020-08-14	Friday	August	Q3	2020	f
2926	2020-08-17	Monday	August	Q3	2020	f
2927	2020-08-18	Tuesday	August	Q3	2020	f
2928	2020-08-19	Wednesday	August	Q3	2020	f
2929	2020-08-20	Thursday	August	Q3	2020	f
2930	2020-08-21	Friday	August	Q3	2020	f
2931	2020-08-24	Monday	August	Q3	2020	f
2932	2020-08-25	Tuesday	August	Q3	2020	f
2933	2020-08-26	Wednesday	August	Q3	2020	f
2934	2020-08-27	Thursday	August	Q3	2020	f
2935	2020-08-28	Friday	August	Q3	2020	f
2936	2020-08-31	Monday	August	Q3	2020	f
2937	2020-09-01	Tuesday	September	Q3	2020	f
2938	2020-09-02	Wednesday	September	Q3	2020	f
2939	2020-09-03	Thursday	September	Q3	2020	f
2940	2020-09-04	Friday	September	Q3	2020	f
2941	2020-09-08	Tuesday	September	Q3	2020	f
2942	2020-09-09	Wednesday	September	Q3	2020	f
2943	2020-09-10	Thursday	September	Q3	2020	f
2944	2020-09-11	Friday	September	Q3	2020	f
2945	2020-09-14	Monday	September	Q3	2020	f
2946	2020-09-15	Tuesday	September	Q3	2020	f
2947	2020-09-16	Wednesday	September	Q3	2020	f
2948	2020-09-17	Thursday	September	Q3	2020	f
2949	2020-09-18	Friday	September	Q3	2020	f
2950	2020-09-21	Monday	September	Q3	2020	f
2951	2020-09-22	Tuesday	September	Q3	2020	f
2952	2020-09-23	Wednesday	September	Q3	2020	f
2953	2020-09-24	Thursday	September	Q3	2020	f
2954	2020-09-25	Friday	September	Q3	2020	f
2955	2020-09-28	Monday	September	Q3	2020	f
2956	2020-09-29	Tuesday	September	Q3	2020	f
2957	2020-09-30	Wednesday	September	Q3	2020	f
2958	2020-10-01	Thursday	October	Q4	2020	f
2959	2020-10-02	Friday	October	Q4	2020	f
2960	2020-10-05	Monday	October	Q4	2020	f
2961	2020-10-06	Tuesday	October	Q4	2020	f
2962	2020-10-07	Wednesday	October	Q4	2020	f
2963	2020-10-08	Thursday	October	Q4	2020	f
2964	2020-10-09	Friday	October	Q4	2020	f
2965	2020-10-12	Monday	October	Q4	2020	f
2966	2020-10-13	Tuesday	October	Q4	2020	f
2967	2020-10-14	Wednesday	October	Q4	2020	f
2968	2020-10-15	Thursday	October	Q4	2020	f
2969	2020-10-16	Friday	October	Q4	2020	f
2970	2020-10-19	Monday	October	Q4	2020	f
2971	2020-10-20	Tuesday	October	Q4	2020	f
2972	2020-10-21	Wednesday	October	Q4	2020	f
2973	2020-10-22	Thursday	October	Q4	2020	f
2974	2020-10-23	Friday	October	Q4	2020	f
2975	2020-10-26	Monday	October	Q4	2020	f
2976	2020-10-27	Tuesday	October	Q4	2020	f
2977	2020-10-28	Wednesday	October	Q4	2020	f
2978	2020-10-29	Thursday	October	Q4	2020	f
2979	2020-10-30	Friday	October	Q4	2020	f
2980	2020-11-02	Monday	November	Q4	2020	f
2981	2020-11-03	Tuesday	November	Q4	2020	f
2982	2020-11-04	Wednesday	November	Q4	2020	f
2983	2020-11-05	Thursday	November	Q4	2020	f
2984	2020-11-06	Friday	November	Q4	2020	f
2985	2020-11-09	Monday	November	Q4	2020	f
2986	2020-11-10	Tuesday	November	Q4	2020	f
2987	2020-11-11	Wednesday	November	Q4	2020	f
2988	2020-11-12	Thursday	November	Q4	2020	f
2989	2020-11-13	Friday	November	Q4	2020	f
2990	2020-11-16	Monday	November	Q4	2020	f
2991	2020-11-17	Tuesday	November	Q4	2020	f
2992	2020-11-18	Wednesday	November	Q4	2020	f
2993	2020-11-19	Thursday	November	Q4	2020	f
2994	2020-11-20	Friday	November	Q4	2020	f
2995	2020-11-23	Monday	November	Q4	2020	f
2996	2020-11-24	Tuesday	November	Q4	2020	f
2997	2020-11-25	Wednesday	November	Q4	2020	f
2998	2020-11-27	Friday	November	Q4	2020	f
2999	2020-11-30	Monday	November	Q4	2020	f
3000	2020-12-01	Tuesday	December	Q4	2020	f
3001	2020-12-02	Wednesday	December	Q4	2020	f
3002	2020-12-03	Thursday	December	Q4	2020	f
3003	2020-12-04	Friday	December	Q4	2020	f
3004	2020-12-07	Monday	December	Q4	2020	f
3005	2020-12-08	Tuesday	December	Q4	2020	f
3006	2020-12-09	Wednesday	December	Q4	2020	f
3007	2020-12-10	Thursday	December	Q4	2020	f
3008	2020-12-11	Friday	December	Q4	2020	f
3009	2020-12-14	Monday	December	Q4	2020	f
3010	2020-12-15	Tuesday	December	Q4	2020	f
3011	2020-12-16	Wednesday	December	Q4	2020	f
3012	2020-12-17	Thursday	December	Q4	2020	f
3013	2020-12-18	Friday	December	Q4	2020	f
3014	2020-12-21	Monday	December	Q4	2020	f
3015	2020-12-22	Tuesday	December	Q4	2020	f
3016	2020-12-23	Wednesday	December	Q4	2020	f
3017	2020-12-24	Thursday	December	Q4	2020	f
3018	2020-12-28	Monday	December	Q4	2020	f
3019	2020-12-29	Tuesday	December	Q4	2020	f
3020	2020-12-30	Wednesday	December	Q4	2020	f
3021	2020-12-31	Thursday	December	Q4	2020	f
3022	2021-01-04	Monday	January	Q1	2021	f
3023	2021-01-05	Tuesday	January	Q1	2021	f
3024	2021-01-06	Wednesday	January	Q1	2021	f
3025	2021-01-07	Thursday	January	Q1	2021	f
3026	2021-01-08	Friday	January	Q1	2021	f
3027	2021-01-11	Monday	January	Q1	2021	f
3028	2021-01-12	Tuesday	January	Q1	2021	f
3029	2021-01-13	Wednesday	January	Q1	2021	f
3030	2021-01-14	Thursday	January	Q1	2021	f
3031	2021-01-15	Friday	January	Q1	2021	f
3032	2021-01-19	Tuesday	January	Q1	2021	f
3033	2021-01-20	Wednesday	January	Q1	2021	f
3034	2021-01-21	Thursday	January	Q1	2021	f
3035	2021-01-22	Friday	January	Q1	2021	f
3036	2021-01-25	Monday	January	Q1	2021	f
3037	2021-01-26	Tuesday	January	Q1	2021	f
3038	2021-01-27	Wednesday	January	Q1	2021	f
3039	2021-01-28	Thursday	January	Q1	2021	f
3040	2021-01-29	Friday	January	Q1	2021	f
3041	2021-02-01	Monday	February	Q1	2021	f
3042	2021-02-02	Tuesday	February	Q1	2021	f
3043	2021-02-03	Wednesday	February	Q1	2021	f
3044	2021-02-04	Thursday	February	Q1	2021	f
3045	2021-02-05	Friday	February	Q1	2021	f
3046	2021-02-08	Monday	February	Q1	2021	f
3047	2021-02-09	Tuesday	February	Q1	2021	f
3048	2021-02-10	Wednesday	February	Q1	2021	f
3049	2021-02-11	Thursday	February	Q1	2021	f
3050	2021-02-12	Friday	February	Q1	2021	f
3051	2021-02-16	Tuesday	February	Q1	2021	f
3052	2021-02-17	Wednesday	February	Q1	2021	f
3053	2021-02-18	Thursday	February	Q1	2021	f
3054	2021-02-19	Friday	February	Q1	2021	f
3055	2021-02-22	Monday	February	Q1	2021	f
3056	2021-02-23	Tuesday	February	Q1	2021	f
3057	2021-02-24	Wednesday	February	Q1	2021	f
3058	2021-02-25	Thursday	February	Q1	2021	f
3059	2021-02-26	Friday	February	Q1	2021	f
3060	2021-03-01	Monday	March	Q1	2021	f
3061	2021-03-02	Tuesday	March	Q1	2021	f
3062	2021-03-03	Wednesday	March	Q1	2021	f
3063	2021-03-04	Thursday	March	Q1	2021	f
3064	2021-03-05	Friday	March	Q1	2021	f
3065	2021-03-08	Monday	March	Q1	2021	f
3066	2021-03-09	Tuesday	March	Q1	2021	f
3067	2021-03-10	Wednesday	March	Q1	2021	f
3068	2021-03-11	Thursday	March	Q1	2021	f
3069	2021-03-12	Friday	March	Q1	2021	f
3070	2021-03-15	Monday	March	Q1	2021	f
3071	2021-03-16	Tuesday	March	Q1	2021	f
3072	2021-03-17	Wednesday	March	Q1	2021	f
3073	2021-03-18	Thursday	March	Q1	2021	f
3074	2021-03-19	Friday	March	Q1	2021	f
3075	2021-03-22	Monday	March	Q1	2021	f
3076	2021-03-23	Tuesday	March	Q1	2021	f
3077	2021-03-24	Wednesday	March	Q1	2021	f
3078	2021-03-25	Thursday	March	Q1	2021	f
3079	2021-03-26	Friday	March	Q1	2021	f
3080	2021-03-29	Monday	March	Q1	2021	f
3081	2021-03-30	Tuesday	March	Q1	2021	f
3082	2021-03-31	Wednesday	March	Q1	2021	f
3083	2021-04-01	Thursday	April	Q2	2021	f
3084	2021-04-05	Monday	April	Q2	2021	f
3085	2021-04-06	Tuesday	April	Q2	2021	f
3086	2021-04-07	Wednesday	April	Q2	2021	f
3087	2021-04-08	Thursday	April	Q2	2021	f
3088	2021-04-09	Friday	April	Q2	2021	f
3089	2021-04-12	Monday	April	Q2	2021	f
3090	2021-04-13	Tuesday	April	Q2	2021	f
3091	2021-04-14	Wednesday	April	Q2	2021	f
3092	2021-04-15	Thursday	April	Q2	2021	f
3093	2021-04-16	Friday	April	Q2	2021	f
3094	2021-04-19	Monday	April	Q2	2021	f
3095	2021-04-20	Tuesday	April	Q2	2021	f
3096	2021-04-21	Wednesday	April	Q2	2021	f
3097	2021-04-22	Thursday	April	Q2	2021	f
3098	2021-04-23	Friday	April	Q2	2021	f
3099	2021-04-26	Monday	April	Q2	2021	f
3100	2021-04-27	Tuesday	April	Q2	2021	f
3101	2021-04-28	Wednesday	April	Q2	2021	f
3102	2021-04-29	Thursday	April	Q2	2021	f
3103	2021-04-30	Friday	April	Q2	2021	f
3104	2021-05-03	Monday	May	Q2	2021	f
3105	2021-05-04	Tuesday	May	Q2	2021	f
3106	2021-05-05	Wednesday	May	Q2	2021	f
3107	2021-05-06	Thursday	May	Q2	2021	f
3108	2021-05-07	Friday	May	Q2	2021	f
3109	2021-05-10	Monday	May	Q2	2021	f
3110	2021-05-11	Tuesday	May	Q2	2021	f
3111	2021-05-12	Wednesday	May	Q2	2021	f
3112	2021-05-13	Thursday	May	Q2	2021	f
3113	2021-05-14	Friday	May	Q2	2021	f
3114	2021-05-17	Monday	May	Q2	2021	f
3115	2021-05-18	Tuesday	May	Q2	2021	f
3116	2021-05-19	Wednesday	May	Q2	2021	f
3117	2021-05-20	Thursday	May	Q2	2021	f
3118	2021-05-21	Friday	May	Q2	2021	f
3119	2021-05-24	Monday	May	Q2	2021	f
3120	2021-05-25	Tuesday	May	Q2	2021	f
3121	2021-05-26	Wednesday	May	Q2	2021	f
3122	2021-05-27	Thursday	May	Q2	2021	f
3123	2021-05-28	Friday	May	Q2	2021	f
3124	2021-06-01	Tuesday	June	Q2	2021	f
3125	2021-06-02	Wednesday	June	Q2	2021	f
3126	2021-06-03	Thursday	June	Q2	2021	f
3127	2021-06-04	Friday	June	Q2	2021	f
3128	2021-06-07	Monday	June	Q2	2021	f
3129	2021-06-08	Tuesday	June	Q2	2021	f
3130	2021-06-09	Wednesday	June	Q2	2021	f
3131	2021-06-10	Thursday	June	Q2	2021	f
3132	2021-06-11	Friday	June	Q2	2021	f
3133	2021-06-14	Monday	June	Q2	2021	f
3134	2021-06-15	Tuesday	June	Q2	2021	f
3135	2021-06-16	Wednesday	June	Q2	2021	f
3136	2021-06-17	Thursday	June	Q2	2021	f
3137	2021-06-18	Friday	June	Q2	2021	f
3138	2021-06-21	Monday	June	Q2	2021	f
3139	2021-06-22	Tuesday	June	Q2	2021	f
3140	2021-06-23	Wednesday	June	Q2	2021	f
3141	2021-06-24	Thursday	June	Q2	2021	f
3142	2021-06-25	Friday	June	Q2	2021	f
3143	2021-06-28	Monday	June	Q2	2021	f
3144	2021-06-29	Tuesday	June	Q2	2021	f
3145	2021-06-30	Wednesday	June	Q2	2021	f
3146	2021-07-01	Thursday	July	Q3	2021	f
3147	2021-07-02	Friday	July	Q3	2021	f
3148	2021-07-06	Tuesday	July	Q3	2021	f
3149	2021-07-07	Wednesday	July	Q3	2021	f
3150	2021-07-08	Thursday	July	Q3	2021	f
3151	2021-07-09	Friday	July	Q3	2021	f
3152	2021-07-12	Monday	July	Q3	2021	f
3153	2021-07-13	Tuesday	July	Q3	2021	f
3154	2021-07-14	Wednesday	July	Q3	2021	f
3155	2021-07-15	Thursday	July	Q3	2021	f
3156	2021-07-16	Friday	July	Q3	2021	f
3157	2021-07-19	Monday	July	Q3	2021	f
3158	2021-07-20	Tuesday	July	Q3	2021	f
3159	2021-07-21	Wednesday	July	Q3	2021	f
3160	2021-07-22	Thursday	July	Q3	2021	f
3161	2021-07-23	Friday	July	Q3	2021	f
3162	2021-07-26	Monday	July	Q3	2021	f
3163	2021-07-27	Tuesday	July	Q3	2021	f
3164	2021-07-28	Wednesday	July	Q3	2021	f
3165	2021-07-29	Thursday	July	Q3	2021	f
3166	2021-07-30	Friday	July	Q3	2021	f
3167	2021-08-02	Monday	August	Q3	2021	f
3168	2021-08-03	Tuesday	August	Q3	2021	f
3169	2021-08-04	Wednesday	August	Q3	2021	f
3170	2021-08-05	Thursday	August	Q3	2021	f
3171	2021-08-06	Friday	August	Q3	2021	f
3172	2021-08-09	Monday	August	Q3	2021	f
3173	2021-08-10	Tuesday	August	Q3	2021	f
3174	2021-08-11	Wednesday	August	Q3	2021	f
3175	2021-08-12	Thursday	August	Q3	2021	f
3176	2021-08-13	Friday	August	Q3	2021	f
3177	2021-08-16	Monday	August	Q3	2021	f
3178	2021-08-17	Tuesday	August	Q3	2021	f
3179	2021-08-18	Wednesday	August	Q3	2021	f
3180	2021-08-19	Thursday	August	Q3	2021	f
3181	2021-08-20	Friday	August	Q3	2021	f
3182	2021-08-23	Monday	August	Q3	2021	f
3183	2021-08-24	Tuesday	August	Q3	2021	f
3184	2021-08-25	Wednesday	August	Q3	2021	f
3185	2021-08-26	Thursday	August	Q3	2021	f
3186	2021-08-27	Friday	August	Q3	2021	f
3187	2021-08-30	Monday	August	Q3	2021	f
3188	2021-08-31	Tuesday	August	Q3	2021	f
3189	2021-09-01	Wednesday	September	Q3	2021	f
3190	2021-09-02	Thursday	September	Q3	2021	f
3191	2021-09-03	Friday	September	Q3	2021	f
3192	2021-09-07	Tuesday	September	Q3	2021	f
3193	2021-09-08	Wednesday	September	Q3	2021	f
3194	2021-09-09	Thursday	September	Q3	2021	f
3195	2021-09-10	Friday	September	Q3	2021	f
3196	2021-09-13	Monday	September	Q3	2021	f
3197	2021-09-14	Tuesday	September	Q3	2021	f
3198	2021-09-15	Wednesday	September	Q3	2021	f
3199	2021-09-16	Thursday	September	Q3	2021	f
3200	2021-09-17	Friday	September	Q3	2021	f
3201	2021-09-20	Monday	September	Q3	2021	f
3202	2021-09-21	Tuesday	September	Q3	2021	f
3203	2021-09-22	Wednesday	September	Q3	2021	f
3204	2021-09-23	Thursday	September	Q3	2021	f
3205	2021-09-24	Friday	September	Q3	2021	f
3206	2021-09-27	Monday	September	Q3	2021	f
3207	2021-09-28	Tuesday	September	Q3	2021	f
3208	2021-09-29	Wednesday	September	Q3	2021	f
3209	2021-09-30	Thursday	September	Q3	2021	f
3210	2021-10-01	Friday	October	Q4	2021	f
3211	2021-10-04	Monday	October	Q4	2021	f
3212	2021-10-05	Tuesday	October	Q4	2021	f
3213	2021-10-06	Wednesday	October	Q4	2021	f
3214	2021-10-07	Thursday	October	Q4	2021	f
3215	2021-10-08	Friday	October	Q4	2021	f
3216	2021-10-11	Monday	October	Q4	2021	f
3217	2021-10-12	Tuesday	October	Q4	2021	f
3218	2021-10-13	Wednesday	October	Q4	2021	f
3219	2021-10-14	Thursday	October	Q4	2021	f
3220	2021-10-15	Friday	October	Q4	2021	f
3221	2021-10-18	Monday	October	Q4	2021	f
3222	2021-10-19	Tuesday	October	Q4	2021	f
3223	2021-10-20	Wednesday	October	Q4	2021	f
3224	2021-10-21	Thursday	October	Q4	2021	f
3225	2021-10-22	Friday	October	Q4	2021	f
3226	2021-10-25	Monday	October	Q4	2021	f
3227	2021-10-26	Tuesday	October	Q4	2021	f
3228	2021-10-27	Wednesday	October	Q4	2021	f
3229	2021-10-28	Thursday	October	Q4	2021	f
3230	2021-10-29	Friday	October	Q4	2021	f
3231	2021-11-01	Monday	November	Q4	2021	f
3232	2021-11-02	Tuesday	November	Q4	2021	f
3233	2021-11-03	Wednesday	November	Q4	2021	f
3234	2021-11-04	Thursday	November	Q4	2021	f
3235	2021-11-05	Friday	November	Q4	2021	f
3236	2021-11-08	Monday	November	Q4	2021	f
3237	2021-11-09	Tuesday	November	Q4	2021	f
3238	2021-11-10	Wednesday	November	Q4	2021	f
3239	2021-11-11	Thursday	November	Q4	2021	f
3240	2021-11-12	Friday	November	Q4	2021	f
3241	2021-11-15	Monday	November	Q4	2021	f
3242	2021-11-16	Tuesday	November	Q4	2021	f
3243	2021-11-17	Wednesday	November	Q4	2021	f
3244	2021-11-18	Thursday	November	Q4	2021	f
3245	2021-11-19	Friday	November	Q4	2021	f
3246	2021-11-22	Monday	November	Q4	2021	f
3247	2021-11-23	Tuesday	November	Q4	2021	f
3248	2021-11-24	Wednesday	November	Q4	2021	f
3249	2021-11-26	Friday	November	Q4	2021	f
3250	2021-11-29	Monday	November	Q4	2021	f
3251	2021-11-30	Tuesday	November	Q4	2021	f
3252	2021-12-01	Wednesday	December	Q4	2021	f
3253	2021-12-02	Thursday	December	Q4	2021	f
3254	2021-12-03	Friday	December	Q4	2021	f
3255	2021-12-06	Monday	December	Q4	2021	f
3256	2021-12-07	Tuesday	December	Q4	2021	f
3257	2021-12-08	Wednesday	December	Q4	2021	f
3258	2021-12-09	Thursday	December	Q4	2021	f
3259	2021-12-10	Friday	December	Q4	2021	f
3260	2021-12-13	Monday	December	Q4	2021	f
3261	2021-12-14	Tuesday	December	Q4	2021	f
3262	2021-12-15	Wednesday	December	Q4	2021	f
3263	2021-12-16	Thursday	December	Q4	2021	f
3264	2021-12-17	Friday	December	Q4	2021	f
3265	2021-12-20	Monday	December	Q4	2021	f
3266	2021-12-21	Tuesday	December	Q4	2021	f
3267	2021-12-22	Wednesday	December	Q4	2021	f
3268	2021-12-23	Thursday	December	Q4	2021	f
3269	2021-12-27	Monday	December	Q4	2021	f
3270	2021-12-28	Tuesday	December	Q4	2021	f
3271	2021-12-29	Wednesday	December	Q4	2021	f
3272	2021-12-30	Thursday	December	Q4	2021	f
3273	2021-12-31	Friday	December	Q4	2021	f
3274	2022-01-03	Monday	January	Q1	2022	f
3275	2022-01-04	Tuesday	January	Q1	2022	f
3276	2022-01-05	Wednesday	January	Q1	2022	f
3277	2022-01-06	Thursday	January	Q1	2022	f
3278	2022-01-07	Friday	January	Q1	2022	f
3279	2022-01-10	Monday	January	Q1	2022	f
3280	2022-01-11	Tuesday	January	Q1	2022	f
3281	2022-01-12	Wednesday	January	Q1	2022	f
3282	2022-01-13	Thursday	January	Q1	2022	f
3283	2022-01-14	Friday	January	Q1	2022	f
3284	2022-01-18	Tuesday	January	Q1	2022	f
3285	2022-01-19	Wednesday	January	Q1	2022	f
3286	2022-01-20	Thursday	January	Q1	2022	f
3287	2022-01-21	Friday	January	Q1	2022	f
3288	2022-01-24	Monday	January	Q1	2022	f
3289	2022-01-25	Tuesday	January	Q1	2022	f
3290	2022-01-26	Wednesday	January	Q1	2022	f
3291	2022-01-27	Thursday	January	Q1	2022	f
3292	2022-01-28	Friday	January	Q1	2022	f
3293	2022-01-31	Monday	January	Q1	2022	f
3294	2022-02-01	Tuesday	February	Q1	2022	f
3295	2022-02-02	Wednesday	February	Q1	2022	f
3296	2022-02-03	Thursday	February	Q1	2022	f
3297	2022-02-04	Friday	February	Q1	2022	f
3298	2022-02-07	Monday	February	Q1	2022	f
3299	2022-02-08	Tuesday	February	Q1	2022	f
3300	2022-02-09	Wednesday	February	Q1	2022	f
3301	2022-02-10	Thursday	February	Q1	2022	f
3302	2022-02-11	Friday	February	Q1	2022	f
3303	2022-02-14	Monday	February	Q1	2022	f
3304	2022-02-15	Tuesday	February	Q1	2022	f
3305	2022-02-16	Wednesday	February	Q1	2022	f
3306	2022-02-17	Thursday	February	Q1	2022	f
3307	2022-02-18	Friday	February	Q1	2022	f
3308	2022-02-22	Tuesday	February	Q1	2022	f
3309	2022-02-23	Wednesday	February	Q1	2022	f
3310	2022-02-24	Thursday	February	Q1	2022	f
3311	2022-02-25	Friday	February	Q1	2022	f
3312	2022-02-28	Monday	February	Q1	2022	f
3313	2022-03-01	Tuesday	March	Q1	2022	f
3314	2022-03-02	Wednesday	March	Q1	2022	f
3315	2022-03-03	Thursday	March	Q1	2022	f
3316	2022-03-04	Friday	March	Q1	2022	f
3317	2022-03-07	Monday	March	Q1	2022	f
3318	2022-03-08	Tuesday	March	Q1	2022	f
3319	2022-03-09	Wednesday	March	Q1	2022	f
3320	2022-03-10	Thursday	March	Q1	2022	f
3321	2022-03-11	Friday	March	Q1	2022	f
3322	2022-03-14	Monday	March	Q1	2022	f
3323	2022-03-15	Tuesday	March	Q1	2022	f
3324	2022-03-16	Wednesday	March	Q1	2022	f
3325	2022-03-17	Thursday	March	Q1	2022	f
3326	2022-03-18	Friday	March	Q1	2022	f
3327	2022-03-21	Monday	March	Q1	2022	f
3328	2022-03-22	Tuesday	March	Q1	2022	f
3329	2022-03-23	Wednesday	March	Q1	2022	f
3330	2022-03-24	Thursday	March	Q1	2022	f
3331	2022-03-25	Friday	March	Q1	2022	f
3332	2022-03-28	Monday	March	Q1	2022	f
3333	2022-03-29	Tuesday	March	Q1	2022	f
3334	2022-03-30	Wednesday	March	Q1	2022	f
3335	2022-03-31	Thursday	March	Q1	2022	f
3336	2022-04-01	Friday	April	Q2	2022	f
3337	2022-04-04	Monday	April	Q2	2022	f
3338	2022-04-05	Tuesday	April	Q2	2022	f
3339	2022-04-06	Wednesday	April	Q2	2022	f
3340	2022-04-07	Thursday	April	Q2	2022	f
3341	2022-04-08	Friday	April	Q2	2022	f
3342	2022-04-11	Monday	April	Q2	2022	f
3343	2022-04-12	Tuesday	April	Q2	2022	f
3344	2022-04-13	Wednesday	April	Q2	2022	f
3345	2022-04-14	Thursday	April	Q2	2022	f
3346	2022-04-18	Monday	April	Q2	2022	f
3347	2022-04-19	Tuesday	April	Q2	2022	f
3348	2022-04-20	Wednesday	April	Q2	2022	f
3349	2022-04-21	Thursday	April	Q2	2022	f
3350	2022-04-22	Friday	April	Q2	2022	f
3351	2022-04-25	Monday	April	Q2	2022	f
3352	2022-04-26	Tuesday	April	Q2	2022	f
3353	2022-04-27	Wednesday	April	Q2	2022	f
3354	2022-04-28	Thursday	April	Q2	2022	f
3355	2022-04-29	Friday	April	Q2	2022	f
3356	2022-05-02	Monday	May	Q2	2022	f
3357	2022-05-03	Tuesday	May	Q2	2022	f
3358	2022-05-04	Wednesday	May	Q2	2022	f
3359	2022-05-05	Thursday	May	Q2	2022	f
3360	2022-05-06	Friday	May	Q2	2022	f
3361	2022-05-09	Monday	May	Q2	2022	f
3362	2022-05-10	Tuesday	May	Q2	2022	f
3363	2022-05-11	Wednesday	May	Q2	2022	f
3364	2022-05-12	Thursday	May	Q2	2022	f
3365	2022-05-13	Friday	May	Q2	2022	f
3366	2022-05-16	Monday	May	Q2	2022	f
3367	2022-05-17	Tuesday	May	Q2	2022	f
3368	2022-05-18	Wednesday	May	Q2	2022	f
3369	2022-05-19	Thursday	May	Q2	2022	f
3370	2022-05-20	Friday	May	Q2	2022	f
3371	2022-05-23	Monday	May	Q2	2022	f
3372	2022-05-24	Tuesday	May	Q2	2022	f
3373	2022-05-25	Wednesday	May	Q2	2022	f
3374	2022-05-26	Thursday	May	Q2	2022	f
3375	2022-05-27	Friday	May	Q2	2022	f
3376	2022-05-31	Tuesday	May	Q2	2022	f
3377	2022-06-01	Wednesday	June	Q2	2022	f
3378	2022-06-02	Thursday	June	Q2	2022	f
3379	2022-06-03	Friday	June	Q2	2022	f
3380	2022-06-06	Monday	June	Q2	2022	f
3381	2022-06-07	Tuesday	June	Q2	2022	f
3382	2022-06-08	Wednesday	June	Q2	2022	f
3383	2022-06-09	Thursday	June	Q2	2022	f
3384	2022-06-10	Friday	June	Q2	2022	f
3385	2022-06-13	Monday	June	Q2	2022	f
3386	2022-06-14	Tuesday	June	Q2	2022	f
3387	2022-06-15	Wednesday	June	Q2	2022	f
3388	2022-06-16	Thursday	June	Q2	2022	f
3389	2022-06-17	Friday	June	Q2	2022	f
3390	2022-06-21	Tuesday	June	Q2	2022	f
3391	2022-06-22	Wednesday	June	Q2	2022	f
3392	2022-06-23	Thursday	June	Q2	2022	f
3393	2022-06-24	Friday	June	Q2	2022	f
3394	2022-06-27	Monday	June	Q2	2022	f
3395	2022-06-28	Tuesday	June	Q2	2022	f
3396	2022-06-29	Wednesday	June	Q2	2022	f
3397	2022-06-30	Thursday	June	Q2	2022	f
3398	2022-07-01	Friday	July	Q3	2022	f
3399	2022-07-05	Tuesday	July	Q3	2022	f
3400	2022-07-06	Wednesday	July	Q3	2022	f
3401	2022-07-07	Thursday	July	Q3	2022	f
3402	2022-07-08	Friday	July	Q3	2022	f
3403	2022-07-11	Monday	July	Q3	2022	f
3404	2022-07-12	Tuesday	July	Q3	2022	f
3405	2022-07-13	Wednesday	July	Q3	2022	f
3406	2022-07-14	Thursday	July	Q3	2022	f
3407	2022-07-15	Friday	July	Q3	2022	f
3408	2022-07-18	Monday	July	Q3	2022	f
3409	2022-07-19	Tuesday	July	Q3	2022	f
3410	2022-07-20	Wednesday	July	Q3	2022	f
3411	2022-07-21	Thursday	July	Q3	2022	f
3412	2022-07-22	Friday	July	Q3	2022	f
3413	2022-07-25	Monday	July	Q3	2022	f
3414	2022-07-26	Tuesday	July	Q3	2022	f
3415	2022-07-27	Wednesday	July	Q3	2022	f
3416	2022-07-28	Thursday	July	Q3	2022	f
3417	2022-07-29	Friday	July	Q3	2022	f
3418	2022-08-01	Monday	August	Q3	2022	f
3419	2022-08-02	Tuesday	August	Q3	2022	f
3420	2022-08-03	Wednesday	August	Q3	2022	f
3421	2022-08-04	Thursday	August	Q3	2022	f
3422	2022-08-05	Friday	August	Q3	2022	f
3423	2022-08-08	Monday	August	Q3	2022	f
3424	2022-08-09	Tuesday	August	Q3	2022	f
3425	2022-08-10	Wednesday	August	Q3	2022	f
3426	2022-08-11	Thursday	August	Q3	2022	f
3427	2022-08-12	Friday	August	Q3	2022	f
3428	2022-08-15	Monday	August	Q3	2022	f
3429	2022-08-16	Tuesday	August	Q3	2022	f
3430	2022-08-17	Wednesday	August	Q3	2022	f
3431	2022-08-18	Thursday	August	Q3	2022	f
3432	2022-08-19	Friday	August	Q3	2022	f
3433	2022-08-22	Monday	August	Q3	2022	f
3434	2022-08-23	Tuesday	August	Q3	2022	f
3435	2022-08-24	Wednesday	August	Q3	2022	f
3436	2022-08-25	Thursday	August	Q3	2022	f
3437	2022-08-26	Friday	August	Q3	2022	f
3438	2022-08-29	Monday	August	Q3	2022	f
3439	2022-08-30	Tuesday	August	Q3	2022	f
3440	2022-08-31	Wednesday	August	Q3	2022	f
3441	2022-09-01	Thursday	September	Q3	2022	f
3442	2022-09-02	Friday	September	Q3	2022	f
3443	2022-09-06	Tuesday	September	Q3	2022	f
3444	2022-09-07	Wednesday	September	Q3	2022	f
3445	2022-09-08	Thursday	September	Q3	2022	f
3446	2022-09-09	Friday	September	Q3	2022	f
3447	2022-09-12	Monday	September	Q3	2022	f
3448	2022-09-13	Tuesday	September	Q3	2022	f
3449	2022-09-14	Wednesday	September	Q3	2022	f
3450	2022-09-15	Thursday	September	Q3	2022	f
3451	2022-09-16	Friday	September	Q3	2022	f
3452	2022-09-19	Monday	September	Q3	2022	f
3453	2022-09-20	Tuesday	September	Q3	2022	f
3454	2022-09-21	Wednesday	September	Q3	2022	f
3455	2022-09-22	Thursday	September	Q3	2022	f
3456	2022-09-23	Friday	September	Q3	2022	f
3457	2022-09-26	Monday	September	Q3	2022	f
3458	2022-09-27	Tuesday	September	Q3	2022	f
3459	2022-09-28	Wednesday	September	Q3	2022	f
3460	2022-09-29	Thursday	September	Q3	2022	f
3461	2022-09-30	Friday	September	Q3	2022	f
3462	2022-10-03	Monday	October	Q4	2022	f
3463	2022-10-04	Tuesday	October	Q4	2022	f
3464	2022-10-05	Wednesday	October	Q4	2022	f
3465	2022-10-06	Thursday	October	Q4	2022	f
3466	2022-10-07	Friday	October	Q4	2022	f
3467	2022-10-10	Monday	October	Q4	2022	f
3468	2022-10-11	Tuesday	October	Q4	2022	f
3469	2022-10-12	Wednesday	October	Q4	2022	f
3470	2022-10-13	Thursday	October	Q4	2022	f
3471	2022-10-14	Friday	October	Q4	2022	f
3472	2022-10-17	Monday	October	Q4	2022	f
3473	2022-10-18	Tuesday	October	Q4	2022	f
3474	2022-10-19	Wednesday	October	Q4	2022	f
3475	2022-10-20	Thursday	October	Q4	2022	f
3476	2022-10-21	Friday	October	Q4	2022	f
3477	2022-10-24	Monday	October	Q4	2022	f
3478	2022-10-25	Tuesday	October	Q4	2022	f
3479	2022-10-26	Wednesday	October	Q4	2022	f
3480	2022-10-27	Thursday	October	Q4	2022	f
3481	2022-10-28	Friday	October	Q4	2022	f
3482	2022-10-31	Monday	October	Q4	2022	f
3483	2022-11-01	Tuesday	November	Q4	2022	f
3484	2022-11-02	Wednesday	November	Q4	2022	f
3485	2022-11-03	Thursday	November	Q4	2022	f
3486	2022-11-04	Friday	November	Q4	2022	f
3487	2022-11-07	Monday	November	Q4	2022	f
3488	2022-11-08	Tuesday	November	Q4	2022	f
3489	2022-11-09	Wednesday	November	Q4	2022	f
3490	2022-11-10	Thursday	November	Q4	2022	f
3491	2022-11-11	Friday	November	Q4	2022	f
3492	2022-11-14	Monday	November	Q4	2022	f
3493	2022-11-15	Tuesday	November	Q4	2022	f
3494	2022-11-16	Wednesday	November	Q4	2022	f
3495	2022-11-17	Thursday	November	Q4	2022	f
3496	2022-11-18	Friday	November	Q4	2022	f
3497	2022-11-21	Monday	November	Q4	2022	f
3498	2022-11-22	Tuesday	November	Q4	2022	f
3499	2022-11-23	Wednesday	November	Q4	2022	f
3500	2022-11-25	Friday	November	Q4	2022	f
3501	2022-11-28	Monday	November	Q4	2022	f
3502	2022-11-29	Tuesday	November	Q4	2022	f
3503	2022-11-30	Wednesday	November	Q4	2022	f
3504	2022-12-01	Thursday	December	Q4	2022	f
3505	2022-12-02	Friday	December	Q4	2022	f
3506	2022-12-05	Monday	December	Q4	2022	f
3507	2022-12-06	Tuesday	December	Q4	2022	f
3508	2022-12-07	Wednesday	December	Q4	2022	f
3509	2022-12-08	Thursday	December	Q4	2022	f
3510	2022-12-09	Friday	December	Q4	2022	f
3511	2022-12-12	Monday	December	Q4	2022	f
3512	2022-12-13	Tuesday	December	Q4	2022	f
3513	2022-12-14	Wednesday	December	Q4	2022	f
3514	2022-12-15	Thursday	December	Q4	2022	f
3515	2022-12-16	Friday	December	Q4	2022	f
3516	2022-12-19	Monday	December	Q4	2022	f
3517	2022-12-20	Tuesday	December	Q4	2022	f
3518	2022-12-21	Wednesday	December	Q4	2022	f
3519	2022-12-22	Thursday	December	Q4	2022	f
3520	2022-12-23	Friday	December	Q4	2022	f
3521	2022-12-27	Tuesday	December	Q4	2022	f
3522	2022-12-28	Wednesday	December	Q4	2022	f
3523	2022-12-29	Thursday	December	Q4	2022	f
3524	2022-12-30	Friday	December	Q4	2022	f
3525	2023-01-03	Tuesday	January	Q1	2023	f
3526	2023-01-04	Wednesday	January	Q1	2023	f
3527	2023-01-05	Thursday	January	Q1	2023	f
3528	2023-01-06	Friday	January	Q1	2023	f
3529	2023-01-09	Monday	January	Q1	2023	f
3530	2023-01-10	Tuesday	January	Q1	2023	f
3531	2023-01-11	Wednesday	January	Q1	2023	f
3532	2023-01-12	Thursday	January	Q1	2023	f
3533	2023-01-13	Friday	January	Q1	2023	f
3534	2023-01-17	Tuesday	January	Q1	2023	f
3535	2023-01-18	Wednesday	January	Q1	2023	f
3536	2023-01-19	Thursday	January	Q1	2023	f
3537	2023-01-20	Friday	January	Q1	2023	f
3538	2023-01-23	Monday	January	Q1	2023	f
3539	2023-01-24	Tuesday	January	Q1	2023	f
3540	2023-01-25	Wednesday	January	Q1	2023	f
3541	2023-01-26	Thursday	January	Q1	2023	f
3542	2023-01-27	Friday	January	Q1	2023	f
3543	2023-01-30	Monday	January	Q1	2023	f
3544	2023-01-31	Tuesday	January	Q1	2023	f
3545	2023-02-01	Wednesday	February	Q1	2023	f
3546	2023-02-02	Thursday	February	Q1	2023	f
3547	2023-02-03	Friday	February	Q1	2023	f
3548	2023-02-06	Monday	February	Q1	2023	f
3549	2023-02-07	Tuesday	February	Q1	2023	f
3550	2023-02-08	Wednesday	February	Q1	2023	f
3551	2023-02-09	Thursday	February	Q1	2023	f
3552	2023-02-10	Friday	February	Q1	2023	f
3553	2023-02-13	Monday	February	Q1	2023	f
3554	2023-02-14	Tuesday	February	Q1	2023	f
3555	2023-02-15	Wednesday	February	Q1	2023	f
3556	2023-02-16	Thursday	February	Q1	2023	f
3557	2023-02-17	Friday	February	Q1	2023	f
3558	2023-02-21	Tuesday	February	Q1	2023	f
3559	2023-02-22	Wednesday	February	Q1	2023	f
3560	2023-02-23	Thursday	February	Q1	2023	f
3561	2023-02-24	Friday	February	Q1	2023	f
3562	2023-02-27	Monday	February	Q1	2023	f
3563	2023-02-28	Tuesday	February	Q1	2023	f
3564	2023-03-01	Wednesday	March	Q1	2023	f
3565	2023-03-02	Thursday	March	Q1	2023	f
3566	2023-03-03	Friday	March	Q1	2023	f
3567	2023-03-06	Monday	March	Q1	2023	f
3568	2023-03-07	Tuesday	March	Q1	2023	f
3569	2023-03-08	Wednesday	March	Q1	2023	f
3570	2023-03-09	Thursday	March	Q1	2023	f
3571	2023-03-10	Friday	March	Q1	2023	f
3572	2023-03-13	Monday	March	Q1	2023	f
3573	2023-03-14	Tuesday	March	Q1	2023	f
3574	2023-03-15	Wednesday	March	Q1	2023	f
3575	2023-03-16	Thursday	March	Q1	2023	f
3576	2023-03-17	Friday	March	Q1	2023	f
3577	2023-03-20	Monday	March	Q1	2023	f
3578	2023-03-21	Tuesday	March	Q1	2023	f
3579	2023-03-22	Wednesday	March	Q1	2023	f
3580	2023-03-23	Thursday	March	Q1	2023	f
3581	2023-03-24	Friday	March	Q1	2023	f
3582	2023-03-27	Monday	March	Q1	2023	f
3583	2023-03-28	Tuesday	March	Q1	2023	f
3584	2023-03-29	Wednesday	March	Q1	2023	f
3585	2023-03-30	Thursday	March	Q1	2023	f
3586	2023-03-31	Friday	March	Q1	2023	f
3587	2023-04-03	Monday	April	Q2	2023	f
3588	2023-04-04	Tuesday	April	Q2	2023	f
3589	2023-04-05	Wednesday	April	Q2	2023	f
3590	2023-04-06	Thursday	April	Q2	2023	f
3591	2023-04-10	Monday	April	Q2	2023	f
3592	2023-04-11	Tuesday	April	Q2	2023	f
3593	2023-04-12	Wednesday	April	Q2	2023	f
3594	2023-04-13	Thursday	April	Q2	2023	f
3595	2023-04-14	Friday	April	Q2	2023	f
3596	2023-04-17	Monday	April	Q2	2023	f
3597	2023-04-18	Tuesday	April	Q2	2023	f
3598	2023-04-19	Wednesday	April	Q2	2023	f
3599	2023-04-20	Thursday	April	Q2	2023	f
3600	2023-04-21	Friday	April	Q2	2023	f
3601	2023-04-24	Monday	April	Q2	2023	f
3602	2023-04-25	Tuesday	April	Q2	2023	f
3603	2023-04-26	Wednesday	April	Q2	2023	f
3604	2023-04-27	Thursday	April	Q2	2023	f
3605	2023-04-28	Friday	April	Q2	2023	f
3606	2023-05-01	Monday	May	Q2	2023	f
3607	2023-05-02	Tuesday	May	Q2	2023	f
3608	2023-05-03	Wednesday	May	Q2	2023	f
3609	2023-05-04	Thursday	May	Q2	2023	f
3610	2023-05-05	Friday	May	Q2	2023	f
3611	2023-05-08	Monday	May	Q2	2023	f
3612	2023-05-09	Tuesday	May	Q2	2023	f
3613	2023-05-10	Wednesday	May	Q2	2023	f
3614	2023-05-11	Thursday	May	Q2	2023	f
3615	2023-05-12	Friday	May	Q2	2023	f
3616	2023-05-15	Monday	May	Q2	2023	f
3617	2023-05-16	Tuesday	May	Q2	2023	f
3618	2023-05-17	Wednesday	May	Q2	2023	f
3619	2023-05-18	Thursday	May	Q2	2023	f
3620	2023-05-19	Friday	May	Q2	2023	f
3621	2023-05-22	Monday	May	Q2	2023	f
3622	2023-05-23	Tuesday	May	Q2	2023	f
3623	2023-05-24	Wednesday	May	Q2	2023	f
3624	2023-05-25	Thursday	May	Q2	2023	f
3625	2023-05-26	Friday	May	Q2	2023	f
3626	2023-05-30	Tuesday	May	Q2	2023	f
3627	2023-05-31	Wednesday	May	Q2	2023	f
3628	2023-06-01	Thursday	June	Q2	2023	f
3629	2023-06-02	Friday	June	Q2	2023	f
3630	2023-06-05	Monday	June	Q2	2023	f
3631	2023-06-06	Tuesday	June	Q2	2023	f
3632	2023-06-07	Wednesday	June	Q2	2023	f
3633	2023-06-08	Thursday	June	Q2	2023	f
3634	2023-06-09	Friday	June	Q2	2023	f
3635	2023-06-12	Monday	June	Q2	2023	f
3636	2023-06-13	Tuesday	June	Q2	2023	f
3637	2023-06-14	Wednesday	June	Q2	2023	f
3638	2023-06-15	Thursday	June	Q2	2023	f
3639	2023-06-16	Friday	June	Q2	2023	f
3640	2023-06-20	Tuesday	June	Q2	2023	f
3641	2023-06-21	Wednesday	June	Q2	2023	f
3642	2023-06-22	Thursday	June	Q2	2023	f
3643	2023-06-23	Friday	June	Q2	2023	f
3644	2023-06-26	Monday	June	Q2	2023	f
3645	2023-06-27	Tuesday	June	Q2	2023	f
3646	2023-06-28	Wednesday	June	Q2	2023	f
3647	2023-06-29	Thursday	June	Q2	2023	f
3648	2023-06-30	Friday	June	Q2	2023	f
3649	2023-07-03	Monday	July	Q3	2023	f
3650	2023-07-05	Wednesday	July	Q3	2023	f
3651	2023-07-06	Thursday	July	Q3	2023	f
3652	2023-07-07	Friday	July	Q3	2023	f
3653	2023-07-10	Monday	July	Q3	2023	f
3654	2023-07-11	Tuesday	July	Q3	2023	f
3655	2023-07-12	Wednesday	July	Q3	2023	f
3656	2023-07-13	Thursday	July	Q3	2023	f
3657	2023-07-14	Friday	July	Q3	2023	f
3658	2023-07-17	Monday	July	Q3	2023	f
3659	2023-07-18	Tuesday	July	Q3	2023	f
3660	2023-07-19	Wednesday	July	Q3	2023	f
3661	2023-07-20	Thursday	July	Q3	2023	f
3662	2023-07-21	Friday	July	Q3	2023	f
3663	2023-07-24	Monday	July	Q3	2023	f
3664	2023-07-25	Tuesday	July	Q3	2023	f
3665	2023-07-26	Wednesday	July	Q3	2023	f
3666	2023-07-27	Thursday	July	Q3	2023	f
3667	2023-07-28	Friday	July	Q3	2023	f
3668	2023-07-31	Monday	July	Q3	2023	f
3669	2023-08-01	Tuesday	August	Q3	2023	f
3670	2023-08-02	Wednesday	August	Q3	2023	f
3671	2023-08-03	Thursday	August	Q3	2023	f
3672	2023-08-04	Friday	August	Q3	2023	f
3673	2023-08-07	Monday	August	Q3	2023	f
3674	2023-08-08	Tuesday	August	Q3	2023	f
3675	2023-08-09	Wednesday	August	Q3	2023	f
3676	2023-08-10	Thursday	August	Q3	2023	f
3677	2023-08-11	Friday	August	Q3	2023	f
3678	2023-08-14	Monday	August	Q3	2023	f
3679	2023-08-15	Tuesday	August	Q3	2023	f
3680	2023-08-16	Wednesday	August	Q3	2023	f
3681	2023-08-17	Thursday	August	Q3	2023	f
3682	2023-08-18	Friday	August	Q3	2023	f
3683	2023-08-21	Monday	August	Q3	2023	f
3684	2023-08-22	Tuesday	August	Q3	2023	f
3685	2023-08-23	Wednesday	August	Q3	2023	f
3686	2023-08-24	Thursday	August	Q3	2023	f
3687	2023-08-25	Friday	August	Q3	2023	f
3688	2023-08-28	Monday	August	Q3	2023	f
3689	2023-08-29	Tuesday	August	Q3	2023	f
3690	2023-08-30	Wednesday	August	Q3	2023	f
3691	2023-08-31	Thursday	August	Q3	2023	f
3692	2023-09-01	Friday	September	Q3	2023	f
3693	2023-09-05	Tuesday	September	Q3	2023	f
3694	2023-09-06	Wednesday	September	Q3	2023	f
3695	2023-09-07	Thursday	September	Q3	2023	f
3696	2023-09-08	Friday	September	Q3	2023	f
3697	2023-09-11	Monday	September	Q3	2023	f
3698	2023-09-12	Tuesday	September	Q3	2023	f
3699	2023-09-13	Wednesday	September	Q3	2023	f
3700	2023-09-14	Thursday	September	Q3	2023	f
3701	2023-09-15	Friday	September	Q3	2023	f
3702	2023-09-18	Monday	September	Q3	2023	f
3703	2023-09-19	Tuesday	September	Q3	2023	f
3704	2023-09-20	Wednesday	September	Q3	2023	f
3705	2023-09-21	Thursday	September	Q3	2023	f
3706	2023-09-22	Friday	September	Q3	2023	f
3707	2023-09-25	Monday	September	Q3	2023	f
3708	2023-09-26	Tuesday	September	Q3	2023	f
3709	2023-09-27	Wednesday	September	Q3	2023	f
3710	2023-09-28	Thursday	September	Q3	2023	f
3711	2023-09-29	Friday	September	Q3	2023	f
25978	2023-10-02	Monday	October	Q4	2023	f
25979	2023-10-03	Tuesday	October	Q4	2023	f
25980	2023-10-04	Wednesday	October	Q4	2023	f
25981	2023-10-05	Thursday	October	Q4	2023	f
25982	2023-10-06	Friday	October	Q4	2023	f
25983	2023-10-09	Monday	October	Q4	2023	f
25984	2023-10-10	Tuesday	October	Q4	2023	f
25985	2023-10-11	Wednesday	October	Q4	2023	f
25986	2023-10-12	Thursday	October	Q4	2023	f
25987	2023-10-13	Friday	October	Q4	2023	f
25988	2023-10-16	Monday	October	Q4	2023	f
25989	2023-10-17	Tuesday	October	Q4	2023	f
25990	2023-10-18	Wednesday	October	Q4	2023	f
25991	2023-10-19	Thursday	October	Q4	2023	f
25992	2023-10-20	Friday	October	Q4	2023	f
25993	2023-10-23	Monday	October	Q4	2023	f
25994	2023-10-24	Tuesday	October	Q4	2023	f
25995	2023-10-25	Wednesday	October	Q4	2023	f
25996	2023-10-26	Thursday	October	Q4	2023	f
25997	2023-10-27	Friday	October	Q4	2023	f
25998	2023-10-30	Monday	October	Q4	2023	f
25999	2023-10-31	Tuesday	October	Q4	2023	f
26000	2023-11-01	Wednesday	November	Q4	2023	f
26001	2023-11-02	Thursday	November	Q4	2023	f
26002	2023-11-03	Friday	November	Q4	2023	f
26003	2023-11-06	Monday	November	Q4	2023	f
26004	2023-11-07	Tuesday	November	Q4	2023	f
26005	2023-11-08	Wednesday	November	Q4	2023	f
26006	2023-11-09	Thursday	November	Q4	2023	f
26007	2023-11-10	Friday	November	Q4	2023	f
26008	2023-11-13	Monday	November	Q4	2023	f
26009	2023-11-14	Tuesday	November	Q4	2023	f
26010	2023-11-15	Wednesday	November	Q4	2023	f
26011	2023-11-16	Thursday	November	Q4	2023	f
26012	2023-11-17	Friday	November	Q4	2023	f
26013	2023-11-20	Monday	November	Q4	2023	f
26014	2023-11-21	Tuesday	November	Q4	2023	f
26015	2023-11-22	Wednesday	November	Q4	2023	f
26016	2023-11-24	Friday	November	Q4	2023	f
26017	2023-11-27	Monday	November	Q4	2023	f
26018	2023-11-28	Tuesday	November	Q4	2023	f
26019	2023-11-29	Wednesday	November	Q4	2023	f
26020	2023-11-30	Thursday	November	Q4	2023	f
26021	2023-12-01	Friday	December	Q4	2023	f
26022	2023-12-04	Monday	December	Q4	2023	f
26023	2023-12-05	Tuesday	December	Q4	2023	f
26024	2023-12-06	Wednesday	December	Q4	2023	f
26025	2023-12-07	Thursday	December	Q4	2023	f
26026	2023-12-08	Friday	December	Q4	2023	f
26027	2023-12-11	Monday	December	Q4	2023	f
26028	2023-12-12	Tuesday	December	Q4	2023	f
26029	2023-12-13	Wednesday	December	Q4	2023	f
26030	2023-12-14	Thursday	December	Q4	2023	f
26031	2023-12-15	Friday	December	Q4	2023	f
26032	2023-12-18	Monday	December	Q4	2023	f
26033	2023-12-19	Tuesday	December	Q4	2023	f
26034	2023-12-20	Wednesday	December	Q4	2023	f
26035	2023-12-21	Thursday	December	Q4	2023	f
26036	2023-12-22	Friday	December	Q4	2023	f
26037	2023-12-26	Tuesday	December	Q4	2023	f
26038	2023-12-27	Wednesday	December	Q4	2023	f
26039	2023-12-28	Thursday	December	Q4	2023	f
26040	2023-12-29	Friday	December	Q4	2023	f
26041	2024-01-02	Tuesday	January	Q1	2024	f
26042	2024-01-03	Wednesday	January	Q1	2024	f
26043	2024-01-04	Thursday	January	Q1	2024	f
26044	2024-01-05	Friday	January	Q1	2024	f
26045	2024-01-08	Monday	January	Q1	2024	f
26046	2024-01-09	Tuesday	January	Q1	2024	f
26047	2024-01-10	Wednesday	January	Q1	2024	f
26048	2024-01-11	Thursday	January	Q1	2024	f
26049	2024-01-12	Friday	January	Q1	2024	f
26050	2024-01-16	Tuesday	January	Q1	2024	f
26051	2024-01-17	Wednesday	January	Q1	2024	f
26052	2024-01-18	Thursday	January	Q1	2024	f
26053	2024-01-19	Friday	January	Q1	2024	f
26054	2024-01-22	Monday	January	Q1	2024	f
26055	2024-01-23	Tuesday	January	Q1	2024	f
26056	2024-01-24	Wednesday	January	Q1	2024	f
26057	2024-01-25	Thursday	January	Q1	2024	f
26058	2024-01-26	Friday	January	Q1	2024	f
26059	2024-01-29	Monday	January	Q1	2024	f
26060	2024-01-30	Tuesday	January	Q1	2024	f
26061	2024-01-31	Wednesday	January	Q1	2024	f
26062	2024-02-01	Thursday	February	Q1	2024	f
26063	2024-02-02	Friday	February	Q1	2024	f
26064	2024-02-05	Monday	February	Q1	2024	f
26065	2024-02-06	Tuesday	February	Q1	2024	f
26066	2024-02-07	Wednesday	February	Q1	2024	f
26067	2024-02-08	Thursday	February	Q1	2024	f
26068	2024-02-09	Friday	February	Q1	2024	f
26069	2024-02-12	Monday	February	Q1	2024	f
26070	2024-02-13	Tuesday	February	Q1	2024	f
26071	2024-02-14	Wednesday	February	Q1	2024	f
26072	2024-02-15	Thursday	February	Q1	2024	f
26073	2024-02-16	Friday	February	Q1	2024	f
26074	2024-02-20	Tuesday	February	Q1	2024	f
26075	2024-02-21	Wednesday	February	Q1	2024	f
26076	2024-02-22	Thursday	February	Q1	2024	f
26077	2024-02-23	Friday	February	Q1	2024	f
26078	2024-02-26	Monday	February	Q1	2024	f
26079	2024-02-27	Tuesday	February	Q1	2024	f
26080	2024-02-28	Wednesday	February	Q1	2024	f
26081	2024-02-29	Thursday	February	Q1	2024	f
26082	2024-03-01	Friday	March	Q1	2024	f
26083	2024-03-04	Monday	March	Q1	2024	f
26084	2024-03-05	Tuesday	March	Q1	2024	f
26085	2024-03-06	Wednesday	March	Q1	2024	f
26086	2024-03-07	Thursday	March	Q1	2024	f
26087	2024-03-08	Friday	March	Q1	2024	f
26088	2024-03-11	Monday	March	Q1	2024	f
26089	2024-03-12	Tuesday	March	Q1	2024	f
26090	2024-03-13	Wednesday	March	Q1	2024	f
26091	2024-03-14	Thursday	March	Q1	2024	f
26092	2024-03-15	Friday	March	Q1	2024	f
26093	2024-03-18	Monday	March	Q1	2024	f
26094	2024-03-19	Tuesday	March	Q1	2024	f
26095	2024-03-20	Wednesday	March	Q1	2024	f
26096	2024-03-21	Thursday	March	Q1	2024	f
26097	2024-03-22	Friday	March	Q1	2024	f
26098	2024-03-25	Monday	March	Q1	2024	f
26099	2024-03-26	Tuesday	March	Q1	2024	f
26100	2024-03-27	Wednesday	March	Q1	2024	f
26101	2024-03-28	Thursday	March	Q1	2024	f
26102	2024-04-01	Monday	April	Q2	2024	f
26103	2024-04-02	Tuesday	April	Q2	2024	f
26104	2024-04-03	Wednesday	April	Q2	2024	f
26105	2024-04-04	Thursday	April	Q2	2024	f
26106	2024-04-05	Friday	April	Q2	2024	f
26107	2024-04-08	Monday	April	Q2	2024	f
26108	2024-04-09	Tuesday	April	Q2	2024	f
26109	2024-04-10	Wednesday	April	Q2	2024	f
26110	2024-04-11	Thursday	April	Q2	2024	f
26111	2024-04-12	Friday	April	Q2	2024	f
26112	2024-04-15	Monday	April	Q2	2024	f
26113	2024-04-16	Tuesday	April	Q2	2024	f
26114	2024-04-17	Wednesday	April	Q2	2024	f
26115	2024-04-18	Thursday	April	Q2	2024	f
26116	2024-04-19	Friday	April	Q2	2024	f
26117	2024-04-22	Monday	April	Q2	2024	f
26118	2024-04-23	Tuesday	April	Q2	2024	f
26119	2024-04-24	Wednesday	April	Q2	2024	f
26120	2024-04-25	Thursday	April	Q2	2024	f
26121	2024-04-26	Friday	April	Q2	2024	f
26122	2024-04-29	Monday	April	Q2	2024	f
26123	2024-04-30	Tuesday	April	Q2	2024	f
26124	2024-05-01	Wednesday	May	Q2	2024	f
26125	2024-05-02	Thursday	May	Q2	2024	f
26126	2024-05-03	Friday	May	Q2	2024	f
26127	2024-05-06	Monday	May	Q2	2024	f
26128	2024-05-07	Tuesday	May	Q2	2024	f
26129	2024-05-08	Wednesday	May	Q2	2024	f
26130	2024-05-09	Thursday	May	Q2	2024	f
26131	2024-05-10	Friday	May	Q2	2024	f
26132	2024-05-13	Monday	May	Q2	2024	f
26133	2024-05-14	Tuesday	May	Q2	2024	f
26134	2024-05-15	Wednesday	May	Q2	2024	f
26135	2024-05-16	Thursday	May	Q2	2024	f
26136	2024-05-17	Friday	May	Q2	2024	f
26137	2024-05-20	Monday	May	Q2	2024	f
26138	2024-05-21	Tuesday	May	Q2	2024	f
26139	2024-05-22	Wednesday	May	Q2	2024	f
26140	2024-05-23	Thursday	May	Q2	2024	f
26141	2024-05-24	Friday	May	Q2	2024	f
26142	2024-05-28	Tuesday	May	Q2	2024	f
26143	2024-05-29	Wednesday	May	Q2	2024	f
26144	2024-05-30	Thursday	May	Q2	2024	f
26145	2024-05-31	Friday	May	Q2	2024	f
26146	2024-06-03	Monday	June	Q2	2024	f
26147	2024-06-04	Tuesday	June	Q2	2024	f
26148	2024-06-05	Wednesday	June	Q2	2024	f
26149	2024-06-06	Thursday	June	Q2	2024	f
26150	2024-06-07	Friday	June	Q2	2024	f
26151	2024-06-10	Monday	June	Q2	2024	f
26152	2024-06-11	Tuesday	June	Q2	2024	f
26153	2024-06-12	Wednesday	June	Q2	2024	f
26154	2024-06-13	Thursday	June	Q2	2024	f
26155	2024-06-14	Friday	June	Q2	2024	f
26156	2024-06-17	Monday	June	Q2	2024	f
26157	2024-06-18	Tuesday	June	Q2	2024	f
26158	2024-06-20	Thursday	June	Q2	2024	f
26159	2024-06-21	Friday	June	Q2	2024	f
26160	2024-06-24	Monday	June	Q2	2024	f
26161	2024-06-25	Tuesday	June	Q2	2024	f
26162	2024-06-26	Wednesday	June	Q2	2024	f
26163	2024-06-27	Thursday	June	Q2	2024	f
26164	2024-06-28	Friday	June	Q2	2024	f
26165	2024-07-01	Monday	July	Q3	2024	f
26166	2024-07-02	Tuesday	July	Q3	2024	f
26167	2024-07-03	Wednesday	July	Q3	2024	f
26168	2024-07-05	Friday	July	Q3	2024	f
26169	2024-07-08	Monday	July	Q3	2024	f
26170	2024-07-09	Tuesday	July	Q3	2024	f
26171	2024-07-10	Wednesday	July	Q3	2024	f
26172	2024-07-11	Thursday	July	Q3	2024	f
26173	2024-07-12	Friday	July	Q3	2024	f
26174	2024-07-15	Monday	July	Q3	2024	f
26175	2024-07-16	Tuesday	July	Q3	2024	f
26176	2024-07-17	Wednesday	July	Q3	2024	f
26177	2024-07-18	Thursday	July	Q3	2024	f
26178	2024-07-19	Friday	July	Q3	2024	f
26179	2024-07-22	Monday	July	Q3	2024	f
26180	2024-07-23	Tuesday	July	Q3	2024	f
26181	2024-07-24	Wednesday	July	Q3	2024	f
26182	2024-07-25	Thursday	July	Q3	2024	f
26183	2024-07-26	Friday	July	Q3	2024	f
26184	2024-07-29	Monday	July	Q3	2024	f
26185	2024-07-30	Tuesday	July	Q3	2024	f
26186	2024-07-31	Wednesday	July	Q3	2024	f
26187	2024-08-01	Thursday	August	Q3	2024	f
26188	2024-08-02	Friday	August	Q3	2024	f
26189	2024-08-05	Monday	August	Q3	2024	f
26190	2024-08-06	Tuesday	August	Q3	2024	f
26191	2024-08-07	Wednesday	August	Q3	2024	f
26192	2024-08-08	Thursday	August	Q3	2024	f
26193	2024-08-09	Friday	August	Q3	2024	f
26194	2024-08-12	Monday	August	Q3	2024	f
26195	2024-08-13	Tuesday	August	Q3	2024	f
26196	2024-08-14	Wednesday	August	Q3	2024	f
26197	2024-08-15	Thursday	August	Q3	2024	f
26198	2024-08-16	Friday	August	Q3	2024	f
26199	2024-08-19	Monday	August	Q3	2024	f
26200	2024-08-20	Tuesday	August	Q3	2024	f
26201	2024-08-21	Wednesday	August	Q3	2024	f
26202	2024-08-22	Thursday	August	Q3	2024	f
26203	2024-08-23	Friday	August	Q3	2024	f
26204	2024-08-26	Monday	August	Q3	2024	f
26205	2024-08-27	Tuesday	August	Q3	2024	f
26206	2024-08-28	Wednesday	August	Q3	2024	f
26207	2024-08-29	Thursday	August	Q3	2024	f
26208	2024-08-30	Friday	August	Q3	2024	f
26209	2024-09-03	Tuesday	September	Q3	2024	f
26210	2024-09-04	Wednesday	September	Q3	2024	f
26211	2024-09-05	Thursday	September	Q3	2024	f
26212	2024-09-06	Friday	September	Q3	2024	f
26213	2024-09-09	Monday	September	Q3	2024	f
26214	2024-09-10	Tuesday	September	Q3	2024	f
26215	2024-09-11	Wednesday	September	Q3	2024	f
26216	2024-09-12	Thursday	September	Q3	2024	f
26217	2024-09-13	Friday	September	Q3	2024	f
26218	2024-09-16	Monday	September	Q3	2024	f
26219	2024-09-17	Tuesday	September	Q3	2024	f
26220	2024-09-18	Wednesday	September	Q3	2024	f
26221	2024-09-19	Thursday	September	Q3	2024	f
26222	2024-09-20	Friday	September	Q3	2024	f
26223	2024-09-23	Monday	September	Q3	2024	f
26224	2024-09-24	Tuesday	September	Q3	2024	f
26225	2024-09-25	Wednesday	September	Q3	2024	f
26226	2024-09-26	Thursday	September	Q3	2024	f
26227	2024-09-27	Friday	September	Q3	2024	f
26228	2024-09-30	Monday	September	Q3	2024	f
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

COPY finance_schema.fact_stock_data (stock_id, date_id, open_price, close_price, high_price, low_price, volume, rsi, sma, bollinger_band) FROM stdin;
1	1	2.5872798930681227	2.7339963912963867	2.7427339335893692	2.5655889870632254	746015200	NaN	NaN	NaN
1	2	2.8069032943903083	2.849381685256958	2.897584478331993	2.7930445011577745	1181608400	NaN	NaN	NaN
1	3	2.8906558171752468	2.802384614944458	2.92741000990914	2.783404769928409	1289310400	NaN	NaN	NaN
1	4	2.7659312948218466	2.7418293952941895	2.786717976460536	2.7192342667216494	753048800	NaN	NaN	NaN
1	5	2.72435631587517	2.792743444442749	2.8063009640108803	2.7126064387671467	673500800	NaN	NaN	NaN
1	6	2.808107524269171	2.7288739681243896	2.813228773697856	2.7156185318773276	546845600	NaN	NaN	NaN
1	7	2.725260382206749	2.6710329055786133	2.7412278943971655	2.6375921154753117	617716400	NaN	NaN	NaN
1	8	2.6583784991151607	2.64241099357605	2.7035681447067597	2.6014391796362912	798397600	NaN	NaN	NaN
1	9	2.5981245283848025	2.570709228515625	2.62855216263714	2.552331736264986	1021664000	NaN	NaN	NaN
1	10	2.427307442769286	2.511963367462158	2.5342574270355995	2.4116418088791622	1831634000	NaN	NaN	NaN
1	11	2.5396795142550115	2.480329990386963	2.5420895032570443	2.4221859638132632	1047625600	NaN	NaN	NaN
1	12	2.4682795224118457	2.3559072017669678	2.470388439178646	2.3559072017669678	919914800	NaN	NaN	NaN
1	13	2.391757743014359	2.4953935146331787	2.496900084718947	2.389347753782245	1089270000	NaN	NaN	NaN
1	14	2.652354060354913	2.661994218826294	2.7114025198194653	2.5854726830261576	1409528400	46.45928646648047	2.64563935143607	2.933848338811548
1	15	2.615599058137678	2.661994218826294	2.7074857592113215	2.6059591007836582	763770000	46.45928646648047	2.6404963391167775	2.9244516841691772
1	16	2.6770573990681354	2.700556755065918	2.740625365310674	2.6601862676742596	692238400	42.08337719359433	2.629865986960275	2.890304479779728
1	17	2.717125089626606	2.733393669128418	2.7580979126549545	2.703568375795912	618038400	46.27394990488155	2.624938062259129	2.8736621909016833
1	18	2.77527098220038	2.837934732437134	2.8620358344834003	2.756592406885408	861406000	54.955018299745085	2.631802729197911	2.899040028636744
1	19	2.8044931927204724	2.8017821311950684	2.8421518082581074	2.789731181150394	592729200	50.47322155896115	2.6324483496802196	2.901398739103429
1	20	2.789731288012611	2.7153186798095703	2.8204600050996675	2.711703193540351	651478800	49.306713133734675	2.6314801148005893	2.899029092876564
1	21	2.684287719945368	2.756892681121826	2.7716546923524694	2.6782622450615796	558247200	54.465614758916175	2.637612955910819	2.9128920059939336
1	22	2.769244483889243	2.8011786937713623	2.813229642583186	2.719837202699192	599309200	58.12520467970403	2.6489535059247697	2.9378295887483774
1	23	2.808409764397112	2.8183507919311523	2.899693291460279	2.8047942785086772	808421600	63.422631108832114	2.666642189025879	2.965049933775107
1	24	2.7948527880203216	2.906020402908325	2.929820227803154	2.790333882296362	749246400	70.7092929223572	2.6947891201291765	3.0044729475424212
1	25	2.922890626215954	3.0042331218719482	3.012668584818939	2.922288481017392	687209600	75.73246589179949	2.732210772378104	3.056530551992899
1	26	3.012668864937386	3.0882861614227295	3.103048172673213	2.99760477547303	715010800	87.45758338580791	2.7845235552106584	3.0825779189517006
1	27	3.052737398541428	2.947293996810913	3.0882862941096665	2.924096520832438	849060800	73.07694180797591	2.8168021610804965	3.0752172302465444
1	28	2.903308597813175	2.916865110397339	2.9617536868257734	2.8852321750753673	674973600	65.1178820489381	2.835007224764143	3.0821053273239585
1	29	2.8870406302427813	2.9906764030456543	3.0051373441903175	2.8870406302427813	817188400	67.92636447685464	2.858484523636954	3.097082742669738
1	30	2.9822405670656993	2.9873626232147217	3.01086137311687	2.9560307555611938	608977600	66.26791741349322	2.8789706570761546	3.108225268026956
1	31	2.9183724558051196	2.8478755950927734	2.923493708040843	2.8403443536353774	678238400	55.79269484350126	2.88714793750218	3.1017320015277727
1	32	2.8635419025068933	2.843055486679077	2.8876427992086042	2.7933469221479448	684779200	50.28818900088934	2.8875137056623186	3.101753595212909
1	33	2.8129288158391774	2.7306830883026123	2.8394399018513026	2.714715578589698	922804400	46.314800338007586	2.8824352025985718	3.108475182973892
1	34	2.6933253227655958	2.747553586959839	2.7837054278938282	2.6812743739254263	750316000	51.800704763157974	2.884737695966448	3.1039998388664265
1	35	2.7611103770622227	2.6195149421691895	2.7716545553530283	2.6062595014320125	786982000	43.00184510987585	2.874925000326974	3.128452331049533
1	36	2.6345780027617827	2.718932628631592	2.738213743435346	2.621021289446077	807105600	46.0331223046931	2.869050281388419	3.1335144880145713
1	37	2.707184906036258	2.7463490962982178	2.7993720839225222	2.6888074034374836	833053200	46.561209373188774	2.8639073031289235	3.13532756672358
1	38	2.771654303683603	2.6869986057281494	2.7993708809103786	2.6800697128180695	629868400	39.24872479551787	2.8482628890446255	3.134092760281271
1	39	2.649039251930869	2.6906142234802246	2.750566088655503	2.64120613470997	706658400	33.02906189596301	2.825861539159502	3.108171639389634
1	40	2.654763997532722	2.649340867996216	2.7475543170868146	2.6412066764848494	770929600	25.09412736170664	2.794508303914751	3.0472180712718098
1	41	2.6791655529764316	2.662294626235962	2.7336950928272263	2.6475326156173784	724340400	31.08001078814216	2.7741512060165405	3.0196569413130185
1	42	2.716824208275869	2.7466495037078857	2.7948522959415545	2.694832029989641	741403600	39.455058274149344	2.761992948395865	2.9935143543743528
1	43	2.7252594400887356	2.6764543056488037	2.7677378266026302	2.6647054353982087	706899200	30.44617584544274	2.7395485128675188	2.933436048866472
1	44	2.661391629760935	2.5698068141937256	2.6631994735554225	2.4803301106138136	1011147200	26.97675690399143	2.709723097937448	2.8637679063258856
1	45	2.5360648559904795	2.503828763961792	2.6390974677906405	2.4875609860915953	698297600	29.35647942438814	2.6851483242852345	2.8533728546599884
1	46	2.5568520742527516	2.67012882232666	2.686397408070222	2.5414877122362185	844258800	41.308336223336575	2.6727964196886336	2.814357269184954
1	47	2.7056778738499676	2.7921414375305176	2.8340176884782298	2.6987489791451362	846372800	53.05938028366932	2.677186301776341	2.8298557413981587
1	48	2.798769075104864	2.9027059078216553	2.90963560653912	2.7716548389285465	768457200	57.06445984709859	2.688268610409328	2.8803735134931556
1	49	2.9012008061570014	2.8900532722473145	2.9283150485369567	2.862336884444006	601168400	63.76459285568721	2.7075927768434798	2.922928657560166
1	50	2.908128207732901	2.874687433242798	2.9340369392494434	2.8373301009874248	797244000	58.66574555074747	2.7187181200299944	2.951929952595274
1	51	2.8692654683363097	3.0024254322052	3.0033288511060916	2.864143413000624	786646000	62.81660191116245	2.737009286880493	3.015357518917043
1	52	3.0099575861121552	3.0584616661071777	3.1175099276896048	3.0042341879353347	796037200	68.65358354051835	2.7635423626218523	3.0883036504664703
1	53	3.0684032178843896	3.061474323272705	3.1090739709307535	3.0202004193224625	500180800	68.63458953587832	2.7900323697498868	3.147974354210928
1	54	3.075633288670922	3.060570001602173	3.1063628126152527	3.0298412821272307	695587200	71.53672113216311	2.819405879293169	3.1946864010291067
1	55	3.0943118991749086	3.243439197540283	3.2585024838149796	3.065390823940938	666397200	75.83710741063211	2.8609162058149065	3.286524218216736
1	56	3.204274170603156	3.208491802215576	3.29706427836707	3.175051821965293	640612000	71.47655880493599	2.8939049414225986	3.3517354133197217
1	57	3.2410283947653835	3.2081899642944336	3.264526938470833	3.1289571949189634	646618000	76.44580560504835	2.9318860598972867	3.4001144032042347
1	58	3.2485600133626393	3.3100192546844482	3.3133326625648913	3.2410289741219063	616252000	86.99166010160006	2.9847583770751953	3.4439447396758704
1	59	3.260611076548969	3.219036102294922	3.269648887080259	3.205479386497986	492872800	84.870550594432	3.035844615527562	3.4170672974061067
1	60	3.1485401210714556	3.147937774658203	3.163603205984104	3.0912995134871255	502796000	75.67992848846805	3.0699738264083862	3.3909504492154934
1	61	3.1768580745896826	3.166916847229004	3.2371118073657814	3.1633013618099683	570080000	72.65099539637463	3.096743498529707	3.377954600949012
1	62	3.1358867397793975	3.2744698524475098	3.283808735568639	3.1298612646354536	589372000	72.5510761031261	3.123298066002982	3.395651350667783
1	63	3.3181535400698303	3.3955790996551514	3.4570377505653096	3.307307883961134	812366800	77.09932893557317	3.1594070536749705	3.4325949656290082
1	64	3.440166232197259	3.494394302368164	3.4986121350139885	3.419981694718705	636241200	80.49207501838859	3.203671830041068	3.47894669858941
1	65	3.4627601702289135	3.568504810333252	3.577542617800565	3.4127495476811367	658064400	79.40521026199926	3.2441060713359287	3.555918057968992
1	66	3.5106636570130925	3.464569568634033	3.514881490345636	3.4401667923019	536580800	70.09542892522359	3.2731137786592757	3.58608803321419
1	67	3.4775229213275933	3.504335880279541	3.5184949407065966	3.4519154594950416	455630000	71.14498971377989	3.3047467470169067	3.61508663444949
1	68	3.567602913236602	3.602248191833496	3.615202562363515	3.553743916881519	530756800	73.67039891314427	3.343438046319144	3.6576828515810553
1	69	3.6155029994242547	3.6218297481536865	3.6447261508446043	3.5850755574771127	389236400	69.28748529210529	3.37046594279153	3.7116006608568717
1	70	3.602247587020368	3.5642879009246826	3.6203240110989094	3.5323536895218446	454622000	67.72745901395919	3.3958799498421803	3.7380454681579636
1	71	3.530847174915359	3.5441036224365234	3.5624805171144196	3.4874653629163124	412882400	66.41166066542914	3.4198737825666154	3.7523164469456396
1	72	3.5908001665739753	3.658886432647705	3.710101366859932	3.5787492152443305	593446000	66.83148602677983	3.444792866706848	3.793658935614616
1	73	3.6507517790322552	3.718235492706299	3.7432408126897325	3.6227341236668456	497495600	74.84274207327027	3.4804499660219466	3.831954090697633
1	74	3.667320378195396	3.6302645206451416	3.705280056770513	3.589894652670392	466466000	73.60663638177633	3.514901876449585	3.8171077166058995
1	75	3.581759391709929	3.6682229042053223	3.679671703301687	3.5730228594971245	470685600	74.08803359858126	3.5507094519478932	3.7868843574326503
1	76	3.6944352601524986	3.660693407058716	3.776380105295642	3.651353519248621	938767200	70.53185332809794	3.5782968487058366	3.759246188023821
1	77	3.81464114957542	3.777886152267456	3.8321146258118395	3.720946617057055	945156800	70.40863288256068	3.605604495321001	3.783129240669222
1	78	3.7549899090488394	3.732696056365967	3.7700531925692884	3.704678405330775	540764000	63.4937846859024	3.6226260491779874	3.7999151708607872
1	79	3.7025701446774026	3.7577016353607178	3.765836027108226	3.6953391720005024	480690000	61.34408612910503	3.6361401081085205	3.8241758204396286
1	80	3.716126002035413	3.732696056365967	3.802288675615894	3.7134149408341037	455856800	67.75740247042707	3.6552920000893727	3.821390317787192
1	81	3.7613170886011416	3.7700536251068115	3.821569827361124	3.7305875683698497	458110800	67.65420286870639	3.6742718390056064	3.8261850902494
1	82	3.802588778552369	3.790839910507202	3.8260877213462563	3.7634248124430987	498489600	63.960733996120695	3.687742676053728	3.8454791046222003
1	83	3.7899375181441957	3.833320140838623	3.8547101783860875	3.7899375181441957	397516000	65.14247554394306	3.702849132674081	3.873383091992921
1	84	3.863448179781997	3.9788336753845215	3.9842562035992932	3.8465772428402145	609358400	76.36031314650748	3.732459545135498	3.939422442715944
1	85	3.96919103709798	3.998112916946411	4.002631621287221	3.9502111917156175	398255200	78.90300353984397	3.7648887804576328	3.9864773939231006
1	86	4.0167910829857965	3.991785764694214	4.021912334352916	3.923096558386342	473538800	74.58832529090623	3.788667304175241	4.031667657646859
1	87	3.986663184696769	3.8881494998931885	3.988470826906781	3.8532021527342057	531776000	61.77940947501728	3.800804018974304	4.045617089051047
1	88	3.8875474467645486	3.8920669555664062	3.9535255981760766	3.80379575179413	467964000	70.54384898176818	3.8195041928972517	4.047629077520952
1	89	3.837236879558134	3.903515100479126	3.9453913517421424	3.829704632767259	404658800	69.26510531820736	3.8363107783453807	4.050679601840962
1	90	3.9032135599777438	3.7483620643615723	3.9077326664026506	3.713114240951286	609481600	55.780659145653004	3.8425728252955844	4.039233411881505
1	91	3.7119092972446763	3.5998382568359375	3.7363124755785337	3.5965238427287165	595971600	38.72577955465752	3.8298551184790477	4.063992717505102
1	92	3.608572348979321	3.704073667526245	3.72154793869858	3.6061625623947515	447826400	48.31369008171477	3.827810662133353	4.066066453882205
1	93	3.6850957811996916	3.6881089210510254	3.754387539679165	3.6637061485906433	367567200	45.855743475301544	3.822839753968375	4.0701292351069025
1	94	3.7275747813995372	3.8155438899993896	3.817050660799775	3.6625008660612774	458841600	54.397173369520786	3.8287574563707625	4.070661034685774
1	95	3.820667443951951	3.8396472930908203	3.895682616778693	3.7881302724033494	372422400	53.74641430197771	3.8337284326553345	4.073284341768484
1	96	3.8450709810703474	3.7920479774475098	3.8926714563263882	3.7748757661104224	388584000	50.06320875955896	3.833814723151071	4.07330494452872
1	97	3.770355174570273	3.7411320209503174	3.81946119041822	3.702268911105401	407946000	45.21871859952037	3.827229857444763	4.0717943886342685
1	98	3.7372160449164635	3.6905198097229004	3.7411326045595032	3.667924675555488	297998400	33.414054210634305	3.8066360098975047	4.044677253877696
1	99	3.7586050304308576	3.939967393875122	3.9414741647810527	3.7522782820113756	636927200	47.355385522937055	3.8024827582495555	4.027822958491614
1	100	3.970096075643888	4.008357048034668	4.066500886735187	3.9438852521254173	646422000	50.71342951382096	3.803666421345302	4.033420905105467
1	101	4.020406481676026	4.069212436676025	4.078852796364208	3.9776268073472965	487552800	58.093275583774336	3.816599488258362	4.084120153597226
1	102	4.078852430841144	4.091505527496338	4.09421658930948	4.03245707271428	456534400	58.77056533410949	3.8308451005390713	4.134479806655063
1	103	4.11138914383572	4.198153972625732	4.2174346881482725	4.097229277591719	452499600	61.95602854033135	3.851890734263829	4.212686704649815
1	104	4.1873096638248954	4.2023725509643555	4.258106600978528	4.168027736330655	456223600	70.99484902074063	3.8843200547354564	4.2844972064994975
1	105	4.217735410177633	4.246356010437012	4.251175987569824	4.189717759573774	565199600	83.09697391925863	3.93049989427839	4.338400617623243
1	106	4.2216529836723655	4.330410003662109	4.343666050110401	4.218941921860814	550634000	82.74034076789303	3.9752382040023804	4.412496367763342
1	107	4.377709674881254	4.358428955078125	4.410547314203819	4.314443782300728	632716000	84.6034139586038	4.023118206432888	4.471595899041365
1	108	4.332818695845158	4.333722114562988	4.34517011105816	4.200562378793798	931652400	79.92320242315768	4.060130936758859	4.520193903188597
1	109	4.332518341083727	4.299680709838867	4.355113469547784	4.234305514387888	676964400	76.26406497903253	4.092990466526577	4.55092659153704
1	110	4.286423801597871	4.225266456604004	4.288532717173644	4.166519703074109	688623600	73.99836968781582	4.123934643609183	4.551833921441129
1	111	4.20418064573116	4.216230392456055	4.264734675538972	4.174053262158217	524823600	77.59889488468669	4.157870241573879	4.526203591391751
1	112	4.1818852072487	4.126452445983887	4.190621743796111	4.098433987131079	563085600	74.2215571559302	4.189008287021092	4.443156817427291
1	113	4.097530988803344	4.099940776824951	4.125247372281374	4.063789129684572	539750400	61.815750389263954	4.200434957231794	4.418119264446085
1	114	4.117112462422146	4.107773780822754	4.17164180340949	4.100241534984351	514805200	58.06439385148568	4.207536152430943	4.403646152968567
1	115	4.117412319512106	4.0845746994018555	4.140911663470571	4.052941771619077	571412800	51.327223636173386	4.208633456911359	4.40155543517948
1	116	4.100542517962257	4.093613624572754	4.157482044865269	4.084877088846525	427680400	50.18639804435944	4.20878403527396	4.401315098957178
1	117	4.159592528524817	4.2020721435546875	4.202674289050807	4.1243450952051885	721856800	50.34533945140745	4.209063904626029	4.401539788232109
1	118	4.237920838593034	4.13850212097168	4.264732992688679	4.107170861123318	634914000	44.903771816084394	4.204501731055124	4.400653510484524
1	119	4.10927988373046	4.037276268005371	4.125848731883055	4.003233543822358	706532400	34.71385720680456	4.189567463738578	4.4030626006956
1	120	4.079755398208584	4.103856086730957	4.142418314623541	4.0628844737849	485525600	33.00197199706919	4.173385041100638	4.374901745314792
1	121	4.089697446754324	4.213518142700195	4.2237614502281895	4.073429468679158	589447600	40.31416649562145	4.163034268787929	4.336548771547481
1	122	4.211409051951369	4.291244983673096	4.324986837897977	4.209902683259666	439384400	47.34874346494029	4.16000018801008	4.321743989546631
1	123	4.321975813890747	4.277087211608887	4.336737832060825	4.264132836753696	567616000	48.55390843312307	4.158386366707938	4.314478743093493
1	124	4.2954622512328795	4.290943145751953	4.332216435774014	4.271963707201218	434224000	54.556871733724705	4.163077558789935	4.3313044647788015
1	125	4.323178635430855	4.302993297576904	4.358125982316548	4.293654617367368	414178800	55.99483130919301	4.1692749091557095	4.351727801944031
1	126	4.255394761891074	4.218338489532471	4.3029944097469714	4.211409594891986	370479200	56.394079058701735	4.1758381979806085	4.3582661274437555
1	127	4.178571466930322	4.175860404968262	4.187309211589349	4.1047613971917345	498688400	55.16818051091351	4.1812610285622736	4.358407398620407
1	128	4.171942881755165	4.079152584075928	4.208094924890733	4.072524964249666	461596800	48.261938944463004	4.179216657366071	4.360625642713353
1	129	4.094820576793992	4.133984565734863	4.158688617547421	4.049629904551957	575929200	52.88947063737897	4.182745933532715	4.358042978773302
1	130	4.150251703179326	4.108074188232422	4.157180596277376	4.095119820932073	343025200	50.829284353253364	4.183778830936977	4.356971289908316
1	131	4.1074725638554535	4.1731486320495605	4.18670514625445	4.106869211889536	445275600	48.2544356391309	4.181712865829468	4.354655178462279
1	132	4.20387627908334	4.288230895996094	4.288230895996094	4.143322282237556	483501200	58.50733409555186	4.192407778331211	4.372221337760532
1	133	4.278893985951979	4.286123752593994	4.313539265823465	4.252683970142455	347247600	65.93379550726877	4.21018259865897	4.372261075862554
1	134	4.369573710805825	4.425006866455078	4.428622150956363	4.3478828082673004	485587200	68.82074875898	4.233121940067837	4.419465549916045
1	135	4.391267566583433	4.4442901611328125	4.459354257540556	4.385543765032548	393570800	65.12655996439368	4.249605655670166	4.466759650247071
1	136	4.491285869123795	4.571723937988281	4.579858328104427	4.477728552263552	602154000	67.26001036409914	4.269639866692679	4.5468033652502635
1	137	4.617518069001399	4.6066718101501465	4.670842323995298	4.545816514753058	735526400	69.77584161679233	4.293181623731341	4.623887062477567
1	138	4.618119982048251	4.564493656158447	4.622337412362715	4.511471084479613	874781600	65.87413632326206	4.312720945903233	4.673787741366996
1	139	4.753689327013441	4.7220563888549805	4.782009058508737	4.703076545512977	874104000	70.8046950050589	4.342654023851667	4.764597158771359
1	140	4.718743549662606	4.754594326019287	4.773272094199368	4.686507656532681	526962800	78.07566331472623	4.380958012172154	4.849118652838068
1	141	4.7283844967775845	4.81997013092041	4.82027100251159	4.714827576845616	438362400	82.93274950751888	4.4269658497401645	4.933340374877995
1	142	4.8253906810776055	4.823281764984131	4.846780713505373	4.737722439742296	433311200	92.06398580249642	4.48011793409075	4.985440219359532
1	143	4.786527257047109	4.8202691078186035	4.823281442659074	4.747964624720931	363554800	91.20833120979717	4.529138258525303	5.022834555813358
1	144	4.787131884545521	4.821174621582031	4.833828122795427	4.767549487283364	382158000	94.14409202166411	4.580074003764561	5.032013446409594
1	145	4.871485614856768	4.904324054718018	4.9624678832190385	4.865460139242835	469604800	94.27226972666085	4.632300819669451	5.049313259112589
1	146	4.910349521368148	4.92240047454834	4.9709043543943565	4.907939330732109	422536800	93.50985257129996	4.677598646708897	5.070700771280912
1	147	4.977230703481011	5.013986110687256	5.020312458873251	4.966987795510743	394240000	94.47709824462028	4.7295888151441305	5.090903682184559
1	148	4.968793964522653	4.9874725341796875	4.988075081660064	4.947103059698369	395810800	89.84176458428752	4.769764934267316	5.10963756612389
1	149	4.993498130226876	4.974217414855957	5.0429054158788285	4.947103179815312	423183600	87.86026147317816	4.8076168809618265	5.106963235458325
1	150	4.988374790065872	4.938064098358154	5.016393241370534	4.913360059657401	341616800	80.09864799746131	4.83378403527396	5.1072302450389415
1	151	4.9856644678120485	4.986266613006592	5.0191050456602495	4.964876983741237	387354800	80.52286258523432	4.860897949763706	5.1116754294292805
1	152	4.99078740461188	4.962467670440674	5.019105932079077	4.930533455525461	300294400	82.97537431608492	4.88932466506958	5.077872294544294
1	153	4.931435924036334	4.905527591705322	4.952223810006107	4.876907393752356	355342400	68.24427423002844	4.902429750987461	5.064548065440621
1	154	4.89709332201349	4.980243682861328	5.022420807524143	4.894382260088894	445071200	70.70189974810599	4.918547562190464	5.061031409588282
1	155	5.020610728072835	5.073934555053711	5.081466798519709	5.016091623333944	439980800	72.14889189418476	4.936687878199986	5.089407797495711
1	156	5.059477449267541	5.02453088760376	5.068213989124786	4.9868724589179925	305816000	66.24538870378697	4.951062815529959	5.09545913867462
1	157	4.927219750157999	4.807918548583984	4.9284252475386685	4.802796491978894	524381200	49.25867304736582	4.950180632727487	5.098126423921607
1	158	4.869376080093834	4.940776348114014	4.948006515697982	4.862748459994748	431152400	56.19726446006961	4.958723613194057	5.087098059636516
1	159	4.903118254064626	4.958852291107178	4.979941052216754	4.894080443437471	413271600	53.02974263322718	4.962618487221854	5.087133940828099
1	160	4.970300395209734	5.010971546173096	5.022721222186969	4.959154071153028	342031200	54.741872057502796	4.968944992337908	5.093658206165925
1	161	5.0507384016327475	5.098036766052246	5.102556676256278	5.025130538036637	416074400	54.52174667013493	4.974948610578265	5.116021291449517
1	162	5.125150626292768	5.093216419219971	5.14292577422649	5.069416601879555	406929600	55.82475182666189	4.982501745223999	5.137134418936721
1	163	5.105268908272451	5.103461265563965	5.149856221711022	5.095326873375779	324354800	57.14290231993321	4.9917334488459995	5.159139947929516
1	164	5.088999735587261	5.043509006500244	5.1079795803434385	5.023926211985885	303998800	55.678238460645666	4.999265227999006	5.165755849788697
1	165	5.083879306483067	5.104968070983887	5.108582552240526	4.965782788407098	449181600	56.302129562072444	5.007743903568813	5.18322991799227
1	166	5.189924631243391	5.123043060302734	5.196552252018548	5.077251055718954	453700800	58.57744486381325	5.0192135742732455	5.202757382082442
1	167	5.066103492733177	5.067610263824463	5.086890980719734	5.01609365563239	311337600	58.67192355302112	5.030790907996042	5.203576521929653
1	168	5.06098143710531	4.979940414428711	5.121536248820153	4.969094962618186	469028000	49.98399603826457	5.03076924596514	5.203582231945014
1	169	4.959455060940867	4.976325988769531	5.049533499121022	4.944090099633208	364249200	44.307893203062775	5.02379720551627	5.196983952099015
1	170	5.014285020403877	5.017598628997803	5.034168280905811	4.9709024103906145	293955200	49.59187042264909	5.0233020441872736	5.19651939218043
1	171	5.039591589759362	5.130875110626221	5.142624785334809	5.0338673892603065	374628800	71.6477417647431	5.046370370047433	5.176749295411113
1	172	5.211313287681366	5.2098069190979	5.216133264913855	5.181789267914641	315047600	69.43834625322998	5.065586839403425	5.20769974030216
1	173	5.2052891752398756	5.155881881713867	5.256203239978178	5.112498857394083	811087200	63.53487317802115	5.079660381589617	5.21510866927114
1	174	5.183597089566501	5.198660373687744	5.219447858624213	5.145938678146085	491134000	63.060825222551536	5.093066726412092	5.236166365108644
1	175	5.209206310464112	5.186611175537109	5.217340703842344	5.147748058323146	348961200	56.88221459153686	5.099393469946725	5.251017875866858
1	176	5.146539461113933	5.233606338500977	5.239028459684659	5.1290663940353625	322011200	60.23732083236844	5.10942132132394	5.277014694071588
1	177	5.243247133693025	5.276988983154297	5.291750992014282	5.2296906218508425	426470800	62.070404334697216	5.121816158294678	5.311696324287072
1	178	5.362249347114498	5.479140758514404	5.505652449011055	5.358935335523081	754023200	75.29758904965337	5.152932712009975	5.416149822021765
1	179	5.482453895849736	5.559878826141357	5.627362528442738	5.482152622138845	810572000	75.83858807903542	5.185426337378366	5.524517151682802
1	180	5.598441752016645	5.574038982391357	5.620132655867328	5.566205463263441	601582800	75.73065766943668	5.217640331813267	5.612333248708773
1	181	5.552047756424587	5.5439133644104	5.578257368432915	5.471609668791047	437715600	77.98255964446955	5.25166198185512	5.671930604268394
1	182	5.579160687017611	5.557770252227783	5.584884485642242	5.508663841033867	356753600	87.17102579156567	5.2929355416979105	5.71174489516714
1	183	5.5854876876923605	5.588500022888184	5.690931084350629	5.5743401569650235	593563600	88.05283556643155	5.336662258420672	5.740643421446529
1	184	5.63971480325778	5.537887096405029	5.6547780877827885	5.506254158679048	550880400	81.9699826895332	5.37382572037833	5.745829297861104
1	185	5.483358590461316	5.494204044342041	5.588500726616493	5.466186387179935	445239200	74.41330980292643	5.399777787072318	5.74875142759183
1	186	5.539392946766087	5.608081340789795	5.624048847260947	5.523124568822522	337444800	75.56101651344702	5.428225960050311	5.775418974845366
1	187	5.625557156563057	5.584885597229004	5.645741293748639	5.5526501062327975	345385600	78.66381287849438	5.458869082587106	5.7770319085551085
1	188	5.607481019973537	5.583982467651367	5.617121781734197	5.501435456249311	539585200	77.27127609670097	5.486392089298794	5.772656739201462
1	189	5.583981034804619	5.448712348937988	5.610190642411884	5.443891164825332	524711600	65.7952723322816	5.50511360168457	5.7358138387631605
1	190	5.4652818166853185	5.570423126220703	5.601755190607504	5.463474174380238	553308000	68.62104963462086	5.529171943664551	5.700518946135707
1	191	5.609588406455217	5.604165077209473	5.62947166769349	5.551443382416162	423133200	68.28295252397889	5.5525416646684915	5.648299444109774
1	192	5.65598429792192	5.724371433258057	5.724371433258057	5.642729056371808	605085600	65.08532843675019	5.570058141435895	5.693649582493746
1	193	5.716840179825896	5.731602191925049	5.740640002547824	5.6948471952061315	465668000	61.613844897622215	5.582324096134731	5.732738656341463
1	194	5.743953151140433	5.7020769119262695	5.767752968620792	5.690628109260288	438211200	58.48304465212614	5.5914696625300815	5.7547352499745665
1	195	5.693040769799693	5.738230228424072	5.74515912321573	5.682496589602984	293272000	62.772284551224914	5.605349438531058	5.783554900595869
1	196	5.754798961747509	5.748472213745117	5.769560971518491	5.713223993629561	288024800	62.59453038545282	5.618971007210868	5.81018860115206
1	197	5.743050166101735	5.724673271179199	5.759318546935277	5.715032510842487	348020400	59.076381499406935	5.628697667803083	5.826962078287755
1	198	5.79185480285988	5.762933731079102	5.793963316764761	5.730999519721546	375510800	65.25121229101188	5.64477242742266	5.847756863174108
1	199	5.712924342415645	5.740942001342773	5.751787455906727	5.709912006650729	373556400	67.22770938888138	5.662396567208426	5.851432923891606
1	200	5.70448708235628	5.665322303771973	5.734914923182497	5.658995555740252	431426800	54.22224254425611	5.666485207421439	5.852919189873149
1	201	5.659297961465912	5.719851970672607	5.724069802937868	5.590006611760839	942230800	59.51560815912677	5.676125662667411	5.8582926820965975
1	202	6.043413860367399	5.987979888916016	6.078059137217164	5.9605647803123665	1141039200	70.68792065940055	5.704982621329171	5.943539324991025
1	203	6.010876865009776	6.173561096191406	6.287741854722364	6.002140327082401	1193726800	85.29924001062611	5.756757531847272	6.061245795289696
1	204	6.166931630830325	6.181994915008545	6.261830844058113	6.100954695515183	791392000	83.47618458480217	5.800441231046404	6.160230993000907
1	205	6.19705959519255	6.144035816192627	6.200071930528041	6.122646183913898	420786800	79.41561144271705	5.839003426688058	6.2230797395949775
1	206	6.135903132261496	6.100052356719971	6.228693043587464	6.028350805636921	484338400	72.3237611227787	5.865837778363909	6.267506371907451
1	207	6.075347261839582	5.946104049682617	6.109992534049246	5.918386464317181	756551600	60.85365565303663	5.8811593396323065	6.277094210020998
1	208	5.956347719535437	5.796375751495361	5.965687609851675	5.757210558549546	818386800	54.253988672321185	5.887894971030099	6.273787323036864
1	209	5.874703531189183	5.915374279022217	5.92923327317313	5.788541253491517	570270400	57.43550986456291	5.900548117501395	6.276797256080906
1	210	5.906637938594624	5.678880214691162	5.928931391425051	5.668938181030479	717525200	47.54517817453229	5.895577260426113	6.28217772728406
1	211	5.718045323198866	5.703283309936523	5.810835235772072	5.590609729744861	678983200	49.24580162117848	5.894049406051636	6.283716266637631
1	212	5.659297951528342	5.686411380767822	5.709608653716774	5.6011529255857395	522541600	47.260544528207454	5.8885835238865445	6.2881928790735
1	213	5.746062426264519	5.748472213745117	5.8400570095150055	5.730999142779138	487530400	50.26205899513518	5.889121396200998	6.2878941015414505
1	214	5.796372613940712	5.8454790115356445	5.8747017507289	5.778898742472551	384801200	56.177675369549306	5.901989732469831	6.280778992359569
1	215	5.79968734202422	5.854818820953369	5.880426281340682	5.796373733512672	295097600	54.77610942971384	5.9116302217756	6.277086320462592
1	216	5.9331501880055795	6.069323539733887	6.0825787831980795	5.9126647751759425	528855600	52.992084717794434	5.917440482548305	6.290630186113175
1	217	6.0560657713688295	6.115114212036133	6.175366943078556	6.055764497657752	401195200	47.60369982553453	5.913265705108643	6.275252715124421
1	218	6.162714708906298	6.123249053955078	6.175970754042386	6.080468583250535	443870000	47.5908512616259	5.909069572176252	6.258791900806205
1	219	6.119934751555716	6.085289478302002	6.172053901657616	6.068418551165972	363731200	47.5908326489108	5.904873405184064	6.24369096819106
1	220	6.11180049265787	6.159400939941406	6.1708489400270645	6.087699397505471	343240800	52.37517284757773	5.909112589699881	6.2597292822194674
1	221	6.190432495524758	6.225078582763672	6.266351889606324	6.176273430383268	485206400	62.013555836097915	5.929039342062814	6.318293578031397
1	222	6.208507317727368	6.2362236976623535	6.24947893790816	6.175970557895989	396513600	71.5084762835675	5.960457052503314	6.373840793155492
1	223	6.222365482994084	6.204891204833984	6.236223269776114	6.145843164093184	374320800	65.4849534834967	5.981136832918439	6.413343454543676
1	224	6.1642217040618155	6.040701866149902	6.1642217040618155	6.019312231976055	542326400	70.97447940766884	6.006981236594064	6.403095515899756
1	225	5.999730958263812	6.022928237915039	6.037088107443263	5.957854701788119	406666400	68.67305495974819	6.029813017163958	6.38528453964825
1	226	6.115715510556736	6.202480316162109	6.206095600194529	6.114208739975356	474896800	75.33278873094379	6.066675083977835	6.372282149644709
1	227	6.1859102983635506	6.159098148345947	6.2024803502699255	6.112703209711719	318438400	70.5333430617809	6.096005507877895	6.343317878951453
1	228	6.188019893763742	6.151566982269287	6.195552138601263	6.138612615226822	286454000	66.81017483380026	6.117868934358869	6.319716172179766
1	229	6.001837702252201	6.043111801147461	6.11451126195712	5.976230239597065	295257200	59.325681254927	6.131318432944162	6.2741182602812255
1	230	6.058778045859044	6.0226263999938965	6.075950248594726	5.9882819945225325	424858000	47.1369741988258	6.127982922962734	6.278967539806622
1	231	6.092821641983025	5.934054374694824	6.108789153084863	5.929836541573584	465763200	39.452441402452244	6.1150500774383545	6.298344050151163
1	232	5.994005100957866	5.911759376525879	6.068116836191021	5.897298638434334	715260000	37.87972362470937	6.099943671907697	6.312802779109196
1	233	5.947609468029117	5.919290542602539	5.994607766472636	5.912964196668939	448719600	40.142977439487446	6.0880866050720215	6.321922047340419
1	234	6.016299184316622	5.824090957641602	6.02172130731224	5.732505347172881	826884800	30.5757478324378	6.064135892050607	6.332626745665257
1	235	5.8240913963430545	5.692437171936035	5.837648313791854	5.684303182360625	714758800	21.335567576444987	6.02609007699149	6.342938238770803
1	236	5.704787822249	5.720152378082275	5.794867045904543	5.684904563336218	690398800	22.713933471493178	5.989227839878628	6.3205165385191995
1	237	5.762632703092681	5.95905876159668	5.969904214256305	5.733409551862214	684782000	39.34168112452057	5.971668379647391	6.278902921621972
1	238	6.010273720506761	5.917784690856934	6.016299195478946	5.9084456068846904	489669600	44.0350396528616	5.962888581412179	6.268646705502163
1	239	5.958457006933168	5.864763259887695	5.9650854333800964	5.827406109706737	429774800	42.578418667258546	5.951591082981655	6.2594737023392515
1	240	5.885850911708031	5.934354782104492	5.947911699556289	5.801194993283664	495790400	35.97103491498292	5.932439259120396	6.204349673368675
1	241	5.899708220469348	5.849697589874268	5.9503209962402535	5.82258376087487	419459600	34.48169640892593	5.910339219229562	6.1514416906168154
1	242	5.877716883902988	5.875607967376709	5.919894409959156	5.861147227716928	352984800	36.40955263360593	5.890627861022949	6.087916953672921
1	243	5.852411610068913	5.780107498168945	5.874705471759514	5.754198752671155	388838800	36.880139143407916	5.871841839381626	6.0562513325775935
1	244	5.819571320557929	5.887657165527344	5.889766081425557	5.8023983174379	608770400	43.805215025359026	5.862201179776873	6.025565093702932
1	245	5.906336384848629	5.972012042999268	6.017804842829113	5.894887581539273	611906400	51.74894221545716	5.8649124417986185	6.034552674771682
1	246	6.0084660234135585	6.036182403564453	6.050944414877515	5.984967073470225	349515600	55.51992201614002	5.873799800872803	6.065601662163038
1	247	6.061489258683336	6.088603496551514	6.097039162361293	6.049740385774799	345525600	57.22370485985514	5.8858935832977295	6.108869564445839
1	248	6.1322879418199765	6.297683238983154	6.307023129204801	6.126262465699379	500889200	68.41616135694342	5.919721603393555	6.229219908759964
1	249	6.378421701572704	6.375107288360596	6.445603328890611	6.314853750019067	644565600	77.71529613369661	5.968483754566738	6.333805256472044
1	250	6.405836632247043	6.2994890213012695	6.408548095700496	6.288342296005008	445205600	72.63954371971738	6.009864943368094	6.38512556019054
1	251	6.29135639818879	6.376012325286865	6.386858584382005	6.27569096497094	412084400	68.66238019806883	6.039647340774536	6.460902419609678
1	252	6.4208996244714625	6.348595142364502	6.427527645945777	6.34347389164166	352410800	69.52479209356946	6.07041951588222	6.515589405217353
1	253	6.429938538443087	6.447412014007568	6.4621740257756315	6.398305598620858	493729600	75.35383020549023	6.112037284033639	6.58260259249213
1	254	6.465187536085361	6.458559513092041	6.495012835085951	6.424515979042845	601904800	74.03305882687292	6.149480479104178	6.642050424061814
1	255	6.458559755219898	6.355827808380127	6.484167624601258	6.3491997851383255	552160000	72.82610191652617	6.185632637568882	6.657272486950944
1	256	6.379326216802095	6.3440775871276855	6.386858061227115	6.297983905950611	477131200	71.40097519151814	6.219094753265381	6.661555355858586
1	257	6.33564058300643	6.386253356933594	6.386856306556629	6.298284253860021	447610800	79.10858368666288	6.262390886034284	6.632524091918129
1	258	6.4109586102211065	6.329918384552002	6.416984085245418	6.279907746319512	462229600	72.33719424172816	6.293980973107474	6.595469051285356
1	259	6.302202016959379	6.25791597366333	6.3196763001465746	6.218751585129213	594459600	64.62254487846087	6.314402682440622	6.554407166008796
1	260	6.26243487119816	6.34618616104126	6.35462182634198	6.148857076807138	605892000	65.47367719547113	6.336545807974679	6.5153849778778445
1	261	6.329918645651823	6.309432029724121	6.340462825144653	6.297080207649436	432894000	61.197675503859244	6.352319274629865	6.462874160296558
1	262	6.3546223004266755	6.203989028930664	6.3748076439021775	6.202181386231365	594067600	44.69100217395181	6.3456268310546875	6.479345785587543
1	263	6.276292797826078	6.478442668914795	6.482961775425333	6.243455163886841	730007600	54.78653100963535	6.353007929665702	6.504025694177603
1	264	6.474522956058865	6.378720760345459	6.493804065543581	6.31153794965233	612152800	53.58988064194008	6.35866733959743	6.506959315740391
1	265	6.389268090427775	6.268459320068359	6.426323557360995	6.24255058036858	608154400	45.27148476070324	6.350984982081822	6.506379800065982
1	266	6.229597111904543	5.957552909851074	6.2512880205706045	5.939778560501138	881767600	36.23837122860976	6.323053394045148	6.584610970771998
1	267	6.100954581884138	6.117825508117676	6.166931515970451	6.031060687168825	1065699600	38.88204196749959	6.2995115007672995	6.57195600056146
1	268	6.204590233221165	6.204288959503174	6.438373409332771	6.10306340366563	1867110000	41.83744070693075	6.281349318368094	6.541755788652008
1	269	6.231705048036775	6.262735843658447	6.344077346961239	6.01117747843685	1722568400	46.92411919849505	6.274699892316546	6.531645190038422
1	270	6.173862932765909	6.003947734832764	6.191034734149728	5.986173385875148	1173502400	40.338838976857225	6.250404902866909	6.541185229490235
1	271	6.057872277550129	5.786129474639893	6.091614122393661	5.7316001498651	1245952400	34.50043165503065	6.207538911274502	6.5780561630815315
1	272	5.795470050327659	5.8665690422058105	5.904830001735351	5.763234565443597	749876400	38.180116997761345	6.174442529678345	6.579076605439484
1	273	5.902119602180668	5.900612831115723	5.914471424354279	5.825898948307284	698342400	40.70531625559645	6.14892087663923	6.5753602711061525
1	274	5.879824302924939	6.002138614654541	6.031361762555567	5.857229176704157	615328000	41.111439623524774	6.124346051897321	6.5413650858093755
1	275	5.926823568818947	5.785831451416016	5.976231668022625	5.771370308877544	757652000	37.621103658192894	6.0869460105896	6.5258058883110595
1	276	5.803304135406081	5.888562202453613	5.904830986710173	5.749678206585321	850306800	42.53314436054852	6.064415522984096	6.509730907117209
1	277	5.895490909556517	5.848191738128662	5.9614682478885035	5.844576453346718	478270800	33.22101916035275	6.019397599356515	6.40826399174682
1	278	5.917484735065164	5.910555839538574	5.950021502692347	5.867173214545841	632886800	37.28323302616448	5.985957247870309	6.318098680361626
1	279	5.901515103958233	5.878317832946777	5.922905939428213	5.852409098567455	370361600	38.933508481389524	5.958089998790196	6.251316049252859
1	280	5.871090525068521	5.9852705001831055	6.017807674206559	5.846386471255383	550345600	50.88909010816896	5.960069826671055	6.25365432862556
1	281	5.968396251830839	6.0367841720581055	6.074743852140964	5.8897658307174	655468800	47.20547631669295	5.954281159809658	6.2374786493539505
1	282	6.083783350500818	6.127768516540527	6.1365050536535435	6.071130254369873	543737600	47.36957018473575	5.948815413883755	6.213581424084411
1	283	6.151567738406341	6.102160453796387	6.1551830233001334	6.051245593776783	436396800	44.35263722254216	5.937345743179321	6.152863223250706
1	284	6.074443647979934	6.1136088371276855	6.14253071776003	6.053054014078898	422825200	54.66903255670421	5.94517867905753	6.178370038784307
1	285	6.081373865636159	6.075649261474609	6.12174334620569	6.058778331714361	415469600	64.55624765953408	5.965858663831439	6.189443335098608
1	286	6.0958343298265785	6.037990570068359	6.100654307944201	6.000935102814098	390563600	59.00601792400411	5.978103058678763	6.196990786869541
1	287	6.025337674691251	5.936765193939209	6.065406283235784	5.896094440065246	575094800	51.77411044098989	5.980685370309012	6.196466027510263
1	288	5.9720115982437685	6.045219898223877	6.0687184415791755	5.960261924331553	460566400	52.09985441306899	5.983762604849679	6.202075077771867
1	289	5.946405112826481	6.085590362548828	6.111499099667332	5.931643101830873	665126000	67.63538207937268	6.00517395564488	6.197063346057296
1	290	6.09703610315536	6.164519786834717	6.1810894341268	6.085588107535124	507460800	66.7028782430959	6.0248852116721014	6.221802469839555
1	291	6.1985648791411325	6.296175956726074	6.311540112172571	6.189527069660616	550093600	74.41693769423932	6.0568840844290595	6.2746110949329905
1	292	6.324495167908173	6.291958808898926	6.351609403767862	6.258517824150557	566546400	72.19480683808496	6.084127153669085	6.317842298771904
1	293	6.2946704993465765	6.306419372558594	6.322688157040543	6.264543925145691	372052800	75.43864818947472	6.114705835069929	6.344414394844499
1	294	6.304912837940058	6.34799337387085	6.354320122418094	6.285329642583004	366041200	73.36949475796567	6.140614611761911	6.388536086188874
1	295	6.475429706086769	6.596237659454346	6.61883278758318	6.466090220203204	899620400	78.7550653377717	6.180575575147357	6.519903752068206
1	296	6.628171096102428	6.60015344619751	6.630580883491422	6.575148131087479	429889600	76.6666397486938	6.2143173558371405	6.618729420485989
1	297	6.5769572230118705	6.718853950500488	6.778504547894001	6.564304126933652	920259200	81.5020431387756	6.2583668913160055	6.737580213406887
1	298	6.743256581451337	6.773684024810791	6.792965545643073	6.724276736616724	596218000	82.28709027654031	6.305515119007656	6.848958005343367
1	299	6.745666190776078	6.793566703796387	6.793566703796387	6.7278910402892	405700400	85.74859245357567	6.356794936316354	6.9407771321656915
1	300	6.849903279126923	6.826706409454346	6.860749133017184	6.801098545559167	416323600	89.4515375790375	6.413131781986782	7.016484267967196
1	301	6.789953363423575	6.743558406829834	6.7935678444059615	6.635403128237591	493502800	91.0990262358604	6.470759868621826	7.030670273990122
1	302	6.753799339067157	6.761933326721191	6.7779004305642605	6.703487837941325	446908000	90.19958887249109	6.521953684943063	7.044044252479973
1	303	6.77549077158519	6.751992225646973	6.822186991973064	6.726384763646548	450956800	88.69864948235511	6.569553818021502	7.039140964360417
1	304	6.751388185731771	6.767958641052246	6.778502818054163	6.7065000144918665	342109600	87.8070188541707	6.612656593322754	7.029961611472795
1	305	6.77217871066484	6.695656776428223	6.7857356290714534	6.664927251875943	559445600	77.03955692117019	6.641190937587193	7.017936686532186
1	306	6.64203078050537	6.770972728729248	6.808631545566175	6.632390020423046	456419600	79.57621454837732	6.675406217575073	6.998747930651893
1	307	6.7977848958918745	6.879729747772217	6.892383245398671	6.751389542397509	602431200	81.70640695056326	6.716356958661761	6.977659250187846
1	308	6.858039476794797	6.910158634185791	6.9351639557654945	6.8541225154084575	597780400	81.47807967976863	6.7565116201128275	6.932972718626361
1	309	6.956854778947459	6.828213691711426	6.95836155006831	6.816162740622076	542284400	65.9620668407386	6.773081336702619	6.92681422711694
1	310	6.897504453336567	6.956251621246338	6.987884154719076	6.885453504697885	640875200	70.92799325633872	6.798516920634678	6.946736703379486
1	311	7.019519652720673	7.001141548156738	7.045729267371275	6.9779446715928914	540744400	68.16617384782883	6.8186803204672675	6.994458380845439
1	312	7.127972800527657	7.105377674102783	7.154484887488106	7.05717468409844	527310000	70.06942817542155	6.842372723988125	7.072910788479393
1	313	7.094533380898394	7.079770565032959	7.128275236156632	7.063502587133618	430659600	67.19789297423122	6.862815856933594	7.12349848216914
1	314	7.152375184824413	7.108992576599121	7.192141704189343	7.011984858842618	603145200	67.04272159824689	6.882979154586792	7.173581931941573
1	315	7.079168417862868	7.18491268157959	7.185515229040325	7.072841267290527	684507600	76.88089007896518	6.91450445992606	7.234251618553451
1	316	7.176175234704905	7.216545104980469	7.237633458960056	7.140023196119085	447017200	77.24830918095307	6.946976729801723	7.291365875498014
1	317	7.216848404407333	7.248481750488281	7.288249086758548	7.190035439022105	628502000	78.99387160443223	6.982440267290388	7.342244345473292
1	318	7.243659103754488	7.2288970947265625	7.276798406201155	7.171355024876457	572989200	76.8044947658671	7.015364442552839	7.374981439268717
1	319	7.2734876991983075	7.284332752227783	7.287346294891415	7.244264540949755	334182800	84.91763458730745	7.057412726538522	7.39284924777714
1	320	7.296681311636437	7.299393177032471	7.3228917199628	7.284932040171272	333026400	83.7565217603209	7.095157044274466	7.410041243289092
1	321	7.286440358405043	7.303611755371094	7.314759286303798	7.263844425025684	306210800	81.25257084998893	7.125434330531529	7.432507181161894
1	322	7.389471226278088	7.401823043823242	7.405438327661195	7.35301832094895	404076400	82.95612540711927	7.160553216934204	7.473963751109407
1	323	7.404535724863928	7.499134063720703	7.502447672396121	7.396401736683022	376784800	94.06389948451994	7.208476100649152	7.50784467735919
1	324	7.488588345361521	7.453340530395508	7.56601447685539	7.367479540065198	750545600	86.60127758689578	7.2439824513026645	7.532192635383282
1	325	7.4421943344777945	7.443399429321289	7.468103069143738	7.283727580435022	566924400	84.33089181357983	7.275572299957275	7.545493186101204
1	326	7.487686031618559	7.368685722351074	7.509076064494315	7.319579310421259	738326400	71.42149997866373	7.294380017689297	7.5495046332953635
1	327	7.796785685385917	7.809439182281494	7.840469974814591	7.704296659727096	982391200	85.4299354946261	7.34649920463562	7.69412271522682
1	328	7.779913669736205	8.02785587310791	8.03629153608837	7.718454643919095	793424800	87.69141095654624	7.4121322972433905	7.889389368143322
1	329	8.07365195350214	8.159212112426758	8.199882872840773	8.043827050986332	796955600	88.22684654062917	7.481725113732474	8.084018619519654
1	330	8.190844082994902	8.119142532348633	8.208317157752129	8.079676069433583	479068800	85.18068330166321	7.546196358544486	8.215696911063503
1	331	8.051958855537327	7.8943963050842285	8.069131056978016	7.848604304221918	709343600	71.88632523348056	7.592333112444196	8.262478798327317
1	332	7.930849668509825	7.88114070892334	7.953443991937929	7.724783260521649	758402400	72.19598157926336	7.638921942029681	8.29066430576171
1	333	7.923922343907732	8.09323501586914	8.134206647175983	7.893494894252937	558840800	74.87488441563508	7.6967006751469205	8.35640361079833
1	334	8.113417125562606	7.865776538848877	8.151376813588419	7.8630654773338735	542463600	65.40475161583679	7.737156629562378	8.360360683293964
1	335	7.94862659144689	8.02424430847168	8.070338800318083	7.919704304964606	454342000	68.0828197442209	7.788630383355277	8.375567731797922
1	336	7.920005169073001	7.793170928955078	7.932055314845136	7.735027105213384	723819600	59.20623126427684	7.816583803721836	8.359813859091696
1	337	7.622954982690095	7.712129592895508	7.776902237802535	7.493409692876041	883103200	55.04924632749407	7.831797770091465	8.347987133183532
1	338	7.647057246991396	7.418697357177734	7.78021703745939	6.002742393392718	1285860800	49.26504417706435	7.829323257718768	8.353596699074586
1	339	7.342172522707104	7.105677127838135	7.428334374729698	6.784828327347702	1676018400	43.65159595017257	7.805200236184256	8.427820807609427
1	340	7.539203281282739	7.651876449584961	7.671760517734283	7.487384999059882	984306400	54.521812885355395	7.825428145272391	8.403786067015801
1	341	7.5871023440715915	7.728096008300781	7.829622419504037	7.5467332812078665	848906800	48.530040549714116	7.819617918559483	8.400297468479156
1	342	7.810044128368437	7.8959059715271	7.927237648411046	7.793776948912503	654379600	47.57109650572636	7.810192925589425	8.380503663675992
1	343	7.929946216109979	7.783531188964844	7.983572141701427	7.724482335614441	599712400	43.03588570458776	7.783358573913574	8.317109279141254
1	344	7.687123180545447	7.646753311157227	7.726890502562662	7.516606296896611	759362800	41.546275699382626	7.749616486685617	8.250650074563046
1	345	7.673267464809131	7.658806324005127	7.717855177818806	7.462681526432177	762834800	45.43656291540959	7.732788630894253	8.228674302641078
1	346	7.741954607230953	7.602769374847412	7.789253371719525	7.539502701925579	782678400	44.69578784568778	7.712904964174543	8.205479073631473
1	347	7.516608751028992	7.481661796569824	7.619641971703292	7.376520061643147	1025726800	37.928232884144116	7.6692211627960205	8.123483602886543
1	348	7.287040737003707	7.162919998168945	7.346391252129695	7.1162229781147515	1282915200	36.608970046003826	7.619017124176025	8.131348837960417
1	349	7.014095645538452	7.300300121307373	7.365976200092702	6.969809604098303	1223891200	36.09547410370534	7.567306825092861	8.048653777420043
1	350	7.449726808717109	7.434060573577881	7.558785493778457	7.418997690413306	754238800	42.83486088227106	7.541656085423061	8.009231471879113
1	351	7.21082168249337	7.387665748596191	7.434060295836594	7.144844744295193	1048006400	43.435384190896265	7.518480096544538	7.981802196899916
1	352	7.534080506327197	7.354223728179932	7.595840407903172	7.343377875018617	850654000	48.54219034469434	7.51387483733041	7.982718124220558
1	353	7.549748211742807	7.632596492767334	7.648865277417127	7.504859623765067	666282400	62.10378964294242	7.551511934825352	7.95989837919712
1	354	7.814561604455398	7.738943099975586	7.8148624759704886	7.632595477491988	815614800	52.506498512507775	7.557730981281826	7.975250863859356
1	355	7.823601979847109	7.857946395874023	8.011893720267128	7.801609390009581	876472800	53.648298436053096	7.567006008965628	8.006043402472994
1	356	7.969713050271118	7.951939105987549	7.9775461676554364	7.842879619036762	688548000	51.642444420217544	7.571008375712803	8.02376879650729
1	357	7.988994704555919	7.926934719085693	8.000142236686234	7.845290731148817	650106800	54.43037116893303	7.58125148500715	8.060440772576996
1	358	7.779012967698532	7.711228370666504	7.890180189512737	7.6711601600757815	758304400	51.899293906650946	7.585856846400669	8.068981064834848
1	359	7.7814223614583655	7.559991359710693	7.807331102361343	7.54824127992342	886942000	47.309732684300776	7.578798634665353	8.06021616465862
1	360	7.629284170537528	7.511488914489746	7.646155505613499	7.40062255454197	1000770400	47.504624349038956	7.572278601782663	8.054768960249207
1	361	7.575959045608166	7.326810836791992	7.588914221516775	7.305421603243924	854630000	45.90896126774758	7.561217818941389	8.059498036664612
1	362	7.3762161762719725	7.547034740447998	7.561193397344809	7.296681530092423	776356000	60.70527072588265	7.588654586247036	8.031700497688895
1	363	7.478347047010497	7.637416362762451	7.647960541355501	7.45243831001746	545759200	59.64817613956137	7.612734317779541	8.023756759111922
1	364	7.711230082253062	7.660616874694824	7.80733363468606	7.652482882139451	602960400	56.92203378767999	7.628916910716465	8.027281014616648
1	365	7.701584872244032	7.8235979080200195	7.828418287335303	7.69736704034316	585074000	62.433373408115415	7.660054922103882	8.045114307969365
1	366	7.866076598618577	8.051356315612793	8.066419197087132	7.8519171360662465	783678000	67.89915991078291	7.7098501069205145	8.104721104333104
1	367	8.15227990868052	8.19054126739502	8.221572057111265	8.11914060524104	872855200	65.42817081844152	7.7497033051082065	8.21697363606312
1	368	8.201989514720433	8.256819725036621	8.28483858436292	8.176984197185064	784621600	64.64472913482149	7.7866944926125665	8.326638788065514
1	369	8.365876347893987	8.139324188232422	8.405643666303567	8.095941585924786	776490400	57.96370842580142	7.8067929063524515	8.378193374393271
1	370	8.199276691769429	8.250190734863281	8.314059143422543	8.179393434187421	717262000	58.361417320518925	7.82809659412929	8.443364006618234
1	371	8.272184193616978	8.163426399230957	8.274594383213852	8.07093738462383	768457200	56.40808839965176	7.8449888569968085	8.48445562703569
1	372	8.164331586083017	8.104079246520996	8.230611009880704	8.076964607684488	714277200	61.63037708787424	7.873049633843558	8.521644552803457
1	373	8.13601452095093	8.034788131713867	8.142340868602208	8.007975165384128	549942400	64.77319024446984	7.906963688986642	8.534350583165681
1	374	8.041714642326568	8.082988739013672	8.126673025418832	7.969109688243135	584948000	67.78542372901478	7.9477851050240655	8.537570362575481
1	375	7.957060721781884	7.717554092407227	7.965195516341325	7.661217100417749	1133344800	60.930438781923705	7.975695337568011	8.467784496098718
1	376	7.733822708906166	7.5777668952941895	7.77178240507545	7.531974884414947	739452000	50.9001949840493	7.977890491485596	8.461951145871074
1	377	7.66121624821275	7.485878944396973	7.676279936027384	7.327412970933583	1022896000	45.56513521441476	7.967066390173776	8.489202624804946
1	378	7.546430744059149	7.43948221206665	7.5596875899156775	7.326807469211431	693842800	43.61500556919361	7.951271057128906	8.52424606483487
1	379	7.561797312847171	7.4903974533081055	7.61602497280401	7.415984052138991	615235600	39.71355186385308	7.927471024649484	8.548920950172777
1	380	7.54643094797039	7.792867183685303	7.795880724914771	7.524138304881814	654556000	42.371892525343725	7.909007515226092	8.529961630821662
1	381	7.907649318515863	7.775393009185791	7.920302811109947	7.678987859971136	738144400	36.80065591247546	7.879354068211147	8.481766921833318
1	382	7.739241875730198	7.821488380432129	7.829923238671316	7.6871227378434845	433322400	35.97900158308232	7.848258972167969	8.410332193773149
1	383	7.788652231030494	7.75129508972168	7.88867270470593	7.678087578120082	562878400	37.109730667827456	7.82054260798863	8.35854139970537
1	384	7.722075103279924	7.585901737213135	7.724484489597545	7.424121300736932	1190924000	28.703920264765017	7.773093393870762	8.262874383879065
1	385	7.51299425350865	7.613917350769043	7.706406391038547	7.5015450452776005	812047600	31.69404184749112	7.733842747552054	8.174484301295545
1	386	7.478348731402975	7.575356483459473	7.7416556019091045	7.450330669699098	824866000	32.1391430747403	7.696076835904803	8.08796038020743
1	387	7.6274766590951195	7.528661251068115	7.681403470796228	7.483772654742219	1039858400	32.63739510135473	7.659924915858677	8.008158476992412
1	388	7.528056715860409	7.3985114097595215	7.528056715860409	7.218354524328284	1024478000	27.76904823631773	7.61103367805481	7.888386866610885
1	389	7.3177732937805064	7.588611602783203	7.6190398544375615	7.230707176499205	1074950800	45.27383618137317	7.601823500224522	7.872420639861219
1	390	7.986283448090968	7.659409046173096	7.9880910907326825	7.652179280075592	1185671200	53.15185360271799	7.607655082430158	7.879534813126092
1	391	7.763046362869918	7.8034162521362305	7.832940283383961	7.6916456709518695	645318800	61.78452179465127	7.630336318697248	7.911283223043505
1	392	7.745269024942509	7.831130027770996	7.844386072037911	7.720866254776675	533388800	64.7393240417093	7.65831116267613	7.935363125032265
1	393	7.832938254735329	7.8112473487854	7.835950992293557	7.763948575825194	420551600	62.36369309084334	7.6812290123530795	7.951444932029869
1	394	7.859148036076182	7.955854892730713	7.977545796933089	7.8419758356124385	584771600	57.150549601354925	7.692870991570609	7.995862681685336
1	395	7.943502816679424	7.86185884475708	8.013396711214316	7.840469617208293	519985200	53.554729249180774	7.699047122682844	8.012624923457883
1	396	7.854328640290875	7.775999069213867	7.912774142594667	7.7154450527597085	643806800	48.18908064872516	7.695797886167254	8.004820068913991
1	397	7.709117551001291	7.750089168548584	7.823899219794691	7.679291050074853	448210000	49.95023802711979	7.695711748940604	8.00466795968481
1	398	7.846195857884495	7.888674259185791	7.910967717073818	7.821492209471332	428055600	62.776492670056776	7.717338357652936	8.035435417990282
1	399	7.863367808511276	7.89108419418335	7.93115240366203	7.815466480079558	417653600	61.954312664195164	7.737135989325387	8.06193562853684
1	400	7.9184987847937265	7.9227166175842285	7.961880598843053	7.842278531967308	420375200	65.07185368818864	7.761947427477155	8.086580794588256
1	401	7.885057738833926	7.884154319763184	7.928742033027604	7.849508238623646	289097200	65.5343764833257	7.787339789526803	8.08810417499943
1	402	7.826309126173944	7.835649013519287	7.87782652890507	7.761536484529021	444897600	70.56983355546879	7.818563904081072	8.019706400981537
1	403	7.877522995917602	7.885657787322998	7.897708734242781	7.819981735548355	303128000	66.10044469669597	7.839781488691058	7.993514938267464
1	404	7.828420613095332	7.815164566040039	7.846497040898004	7.759128444321172	451920000	58.44501817275519	7.8509068829672675	7.966131542757604
1	405	7.694354826865542	7.537394046783447	7.703091361820986	7.5259464507967095	620054400	37.40350360652096	7.83190529687064	8.035056958159224
1	406	7.431952539702672	7.585598945617676	7.625064603064248	7.414780336925255	534920400	38.59510399861081	7.814367362431118	8.056466866086257
1	407	7.581379439652386	7.504556655883789	7.588308332647819	7.504254979943549	354869200	36.52013354598975	7.792460884366717	8.085846415915647
1	408	7.45876746065252	7.460575103759766	7.531975799791643	7.4298451709365825	318430000	26.118711508474632	7.757083756583078	8.083213966970588
1	409	7.5340801110264835	7.591019630432129	7.671156821203309	7.507568026912092	422640400	37.38417355032306	7.73773809841701	8.069183828026487
1	410	7.602772009896963	7.624161243438721	7.672364247974169	7.579272653007079	339696000	42.56201802623348	7.726892539433071	8.062851290084748
1	411	7.6172317243366825	7.528057098388672	7.636513246359632	7.491905049065019	426706000	39.823320241896525	7.71103310585022	8.062862637604185
1	412	7.513294421244678	7.5208258628845215	7.6497678121386565	7.501544342565813	384230000	30.831899640508354	7.684758220400129	8.034375727679858
1	413	7.5855993009499265	7.405139923095703	7.591925648226577	7.388571071555787	414041600	27.351775212759293	7.65004791532244	8.007820518379065
1	414	7.310841755214733	7.228294372558594	7.320782580345391	7.189732144458079	602565600	21.49385153405312	7.600446326392038	7.986785116840584
1	415	7.171354061952927	7.317468166351318	7.350608268817302	7.146047879084316	596867600	27.665487572528193	7.5599687440054755	7.936893844242129
1	416	7.394595015204937	7.238840103149414	7.4036332279032395	7.238840103149414	466505200	27.023826875975928	7.517339536121914	7.8949507436781525
1	417	7.283128483047452	7.279211521148682	7.309037227124635	7.0966436083882005	548391200	26.47826244563484	7.4740219456808905	7.806006678693579
1	418	7.253302347334893	7.305723190307617	7.4036351757931795	7.250892156647893	383289200	29.542761643692913	7.437633275985718	7.71587132806619
1	419	7.286136987859234	7.323795795440674	7.367780948036649	7.240947545018249	420786800	39.16228268822074	7.422376258032663	7.700474875025986
1	420	7.455450419804541	7.5416131019592285	7.575655828449493	7.419600050843788	697037600	48.09593616695406	7.419234412057059	7.690294334455953
1	421	7.569629439505883	7.597044944763184	7.597044944763184	7.48858882303797	415427600	54.094426689070794	7.4258407184055875	7.71004785264995
1	422	7.685017784552674	7.795884132385254	7.796185003958251	7.667243032131923	520788800	63.054166341794854	7.4497913633074075	7.796294462408586
1	423	7.731711996826294	7.766960620880127	7.818778093322968	7.719962723631428	342557600	57.437617543484784	7.4623585769108365	7.8420949708991134
1	424	7.8263119868295155	7.920910358428955	7.965196403760223	7.805825366840304	526551200	61.38203055214356	7.483554942267282	7.929545197340138
1	425	7.984778602370611	7.925428867340088	8.029365518186696	7.9209101623361375	438575200	66.39321978684757	7.511938640049526	8.016820040693442
1	426	7.929040924061663	7.9356689453125	7.968507375638891	7.875114139679023	387542400	67.07160234515763	7.541570288794381	8.095053774113524
1	427	8.008276947429701	8.045031547546387	8.082388695279239	8.006470109050651	388780000	76.47055110505846	7.587276833398001	8.195231957500578
1	428	8.020024498220934	8.075758934020996	8.109199112819468	7.999237012170306	408150400	89.87814389557191	7.6478100163596014	8.270379699845135
1	429	8.07907473785039	8.140833854675293	8.145655039866535	8.06913230037691	429368800	89.64325449174797	7.706621851239886	8.349978530745002
1	430	8.141437915343472	8.332139015197754	8.335151753411118	8.119143652564581	652103200	97.48741574597535	7.7847146306719095	8.448566702522252
1	431	8.365876390155863	8.29598331451416	8.374011181202109	8.24506927272956	634477200	94.3257914751961	7.8573411873408725	8.50524698588186
1	432	8.317377146829632	8.532783508300781	8.549353166531677	8.310448251051474	658677600	95.20495774505375	7.944988352911813	8.603350611791534
1	433	8.55175933549204	8.549047470092773	8.656901035903788	8.519523453435076	668074400	95.19855929690087	8.032506329672676	8.660190347124486
1	434	8.517113268786927	8.668951988220215	8.675880880743838	8.508075058232773	585289600	94.8247036682981	8.113030535834175	8.758432576333531
1	435	8.626175698282445	8.704203605651855	8.819890337882615	8.616234064563814	786116800	94.74029632632738	8.192113297326225	8.836486489263525
1	436	8.800007682993355	8.806634902954102	8.843088635085834	8.753311444848	649488000	94.29584646376836	8.264309780938285	8.943023776504031
1	437	8.856640302168136	8.771682739257812	8.879234619892335	8.767164036606783	482834800	93.80019897701038	8.33607564653669	9.000579536572602
1	438	8.790065080983826	8.642143249511719	8.790065080983826	8.284841333748238	1035042400	82.12539680584305	8.387592281614031	9.024712553817835
1	439	8.653289109522783	8.657506942749023	8.731016141467506	8.61623363859638	469644000	82.29643794005104	8.439883572714669	9.032199725074353
1	440	8.70661367958068	8.54844856262207	8.73674025360098	8.473131725336629	673391600	74.86544596709405	8.483653545379639	9.001328078882954
1	441	8.620752165565365	8.511392593383789	8.63370653654403	8.476143961526294	448142800	70.10377174655719	8.51696504865374	8.968901909073157
1	442	8.483675353540592	8.394500732421875	8.522839334090012	8.36828951260672	435302000	62.79009962673459	8.539732319968087	8.92278897415351
1	443	8.495727140929485	8.704806327819824	8.720170084659003	8.490303408150673	501967200	68.90901184355255	8.58001606804984	8.894923047452297
1	444	8.724387491431909	8.712336540222168	8.796691589751598	8.593938760229284	670868800	64.53905054492355	8.607173034123011	8.894351071201228
1	445	8.746981524481216	8.713239669799805	8.751199356875052	8.643647446474699	408399600	66.39833649787528	8.636977059500557	8.865690283898413
1	446	8.788254077232011	8.859353065490723	8.87230743308441	8.736738282808805	658403200	63.819361545682234	8.660303456442696	8.908982274695848
1	447	8.879540789225596	8.898218154907227	8.95485682186744	8.875322956246794	427753200	64.4984398016885	8.68524421964373	8.955002332652334
1	448	8.899723790783803	8.994020462036133	9.022942741629906	8.811753465957969	558544000	63.7733384947474	8.708463396344866	9.024218991806876
1	449	9.04403157292815	9.042223930358887	9.097054146021208	9.0319806224664	630092400	64.1666293622219	8.73260770525251	9.095182628363855
1	450	9.088922188380378	9.107601165771484	9.112420742564202	9.05005826668847	435296400	63.01799995709974	8.754105295453753	9.167688842357153
1	451	9.262145955723813	9.482070922851562	9.489904038800201	9.185925723242585	922194000	73.75118294216529	8.804847308567592	9.373109260620062
1	452	9.594444534328968	9.58028507232666	9.610410834105105	9.468514538140269	1093010800	82.03698746219737	8.871857438768659	9.565002214172337
1	453	9.14043469023518	9.323905944824219	9.452847867644644	9.038606595335166	1232784000	69.540548098434	8.919457367488317	9.640171250889015
1	454	9.309147137627633	9.355240821838379	9.467312260850601	9.24497783007655	721624400	74.7870642912017	8.977085386003766	9.699029018398758
1	455	9.41037126710673	9.324811935424805	9.482072810743404	9.24286708427738	551460000	75.09284799758996	9.035186767578125	9.725937009797105
1	456	9.311252260341874	9.263050079345703	9.340475405755054	9.227802264659847	372778000	77.73696751746922	9.097226006644112	9.68902914914472
1	457	9.311857349576934	9.304325103759766	9.387474243503101	9.292274154027712	392462000	73.11783590569597	9.140048776354108	9.695157745700282
1	458	9.244972862043614	9.280522346496582	9.331436384096579	9.208217478581934	392929600	71.63806704108642	9.180633476802281	9.681466570981877
1	459	9.268475197045067	9.273898124694824	9.336259781493743	9.206715283293475	399002800	71.25876993462823	9.220680509294782	9.644218148379517
1	460	9.277513735961113	9.195871353149414	9.279020507170998	9.065121743981623	551051200	63.4546443145153	9.244717529841832	9.614735202468651
1	461	9.165439706939694	9.067527770996094	9.215148658002802	9.06421335824375	430511200	56.317315452290096	9.25681107384818	9.586964578564917
1	462	9.104884768154218	9.163932800292969	9.206712858236761	9.10428222079629	423889200	56.336954124785706	9.268947669437953	9.568567764741388
1	463	9.248891970937052	9.319990158081055	9.344995475531999	9.248891970937052	433930000	59.588060279301025	9.28878811427525	9.559087282532849
1	464	9.380548005487316	9.423629760742188	9.426039951370976	9.29498865157378	508348400	60.628075721110676	9.311361585344587	9.568965949940072
1	465	9.503465165868272	9.588422775268555	9.645964868928855	9.490811665264552	642488000	54.16384765540407	9.318958146231514	9.603148410162774
1	466	9.579985739917834	9.554076194763184	9.627585388356232	9.542628595559574	361253200	48.91986177752344	9.317086083548409	9.594115942894145
1	467	9.556182723887657	9.598962783813477	9.633608051795825	9.542926681399079	281758400	63.729143381575916	9.336733000619072	9.652194547410826
1	468	9.672170316170192	9.522440910339355	9.67970256075597	9.474841275618017	383544000	57.98538489006784	9.348675864083427	9.679444200325902
1	469	9.539312509613097	9.581189155578613	9.60348260698571	9.446220938816102	384227200	61.92194333649974	9.36698852266584	9.719724202733646
1	470	9.489906813572837	9.539616584777832	9.59233828929768	9.46731168242585	361284000	63.106880365328166	9.38674327305385	9.745333135420811
1	471	9.520032433659894	9.279922485351562	9.535095316603323	9.147366058466096	795846800	49.04187903741569	9.385000228881836	9.745547732095364
1	472	9.292879257270524	9.250099182128906	9.35554259874785	9.22690150175763	403606000	48.8111147964983	9.382827145712715	9.746440923982501
1	473	9.210326357381126	9.08590316772461	9.266964189111494	9.01751526255731	657650000	43.45901844961147	9.369398934500557	9.762990900207779
1	474	9.074156516064734	9.053068161010742	9.158209869276995	8.97052077410126	479449600	44.87006962782482	9.359198706490654	9.778710978951413
1	475	9.194663707865194	9.291973114013672	9.329330253036305	9.179299953939354	494491200	57.46943962381761	9.375230516706194	9.762655291518808
1	476	9.278116995289972	9.24075984954834	9.291071366112323	9.195871261240798	384843200	52.63606015370227	9.380718163081578	9.757274377349175
1	477	9.239251515369928	9.440498352050781	9.440498352050781	9.214849549048077	393075200	54.01449465060216	9.389325891222272	9.765411344591154
1	478	9.352831285065301	9.301012992858887	9.391996881390101	9.235638585551945	519447600	46.01054108547241	9.38056755065918	9.75891593098422
1	479	9.399525950720315	9.483880996704102	9.501957422758915	9.391995313234819	413725200	46.63816992790558	9.373100280761719	9.737652101270365
1	480	9.451945671573856	9.48990535736084	9.571247656114267	9.427844577467718	237585600	47.89812227925411	9.368516649518694	9.724786040238694
1	481	9.504966714127608	9.54624080657959	9.564617294590361	9.380845174260607	445785200	48.285978089738194	9.364750794001989	9.711514964729357
1	482	9.445916144887383	9.373913764953613	9.470620580329616	9.3654781040709	501858000	45.45445524210684	9.35414171218872	9.689007732898753
1	483	9.498038079041546	9.532081604003906	9.57275234572131	9.489904091591892	461750800	48.583315404563834	9.350634029933385	9.676153438924432
1	484	9.566126515403916	9.584805488586426	9.610412551568142	9.486591851436389	462837200	51.29530307752028	9.353861808776855	9.688229356209131
1	485	9.550457348225454	9.563411712646484	9.599864616764362	9.530272416368774	342092800	59.41176321591901	9.37411103929792	9.723201763441944
1	486	9.599567649189744	9.645059585571289	9.710735657548744	9.592939626344997	448481600	62.67636587133678	9.402322496686663	9.771500731684856
1	487	9.755021106158466	9.586612701416016	9.760744100657098	9.58390163992313	391454000	67.24073161921649	9.438087463378906	9.770391623361975
1	488	9.629392128656422	9.670967102050781	9.671268778038066	9.553473556400247	321935600	70.5468860993282	9.482223102024623	9.752611071967666
1	489	9.70470811753944	9.633307456970215	9.715854037793921	9.61101320305376	294151200	63.10418986988623	9.50660412652152	9.7643551810362
1	490	9.629995111149551	9.657410621643066	9.672172633954343	9.598361767928623	262511200	66.3357074057899	9.536364895956856	9.755162513469013
1	491	9.772194327393672	9.690851211547852	9.792981815906202	9.67066707506258	439815600	61.287545749745455	9.55424724306379	9.780102215166131
1	492	9.69265743579927	9.649274826049805	9.717060204062667	9.610410919713525	351008000	67.22245121832741	9.579123088291713	9.756300418814174
1	493	9.640539600583601	9.651386260986328	9.730920124422923	9.616137631437573	417312000	60.0868780193098	9.591087750026158	9.763107549653991
1	494	9.67337652738235	9.678196907043457	9.719169329693637	9.643551634933099	322030800	61.06167123465727	9.60453714643206	9.77185798813099
1	495	9.689644633443093	9.658915519714355	9.694465012768257	9.647467118817092	386929200	56.920668987848934	9.6125853402274	9.778661851353785
1	496	9.688742643532498	9.707119941711426	9.738452414547746	9.58721619623451	385610400	74.14809326602492	9.636385781424385	9.738187686421517
1	497	9.730916826525442	9.767068862915039	9.77279266048312	9.702297034215949	256354000	69.8568449147871	9.653170585632324	9.758324365734458
1	498	9.771891755620356	9.795992851257324	9.812864181331708	9.747488983997412	265921600	68.59359519051537	9.668255397251674	9.790383921304295
1	499	9.791174259574024	9.74899673461914	9.795692964063365	9.736042364244948	223157200	65.63464109419992	9.68151147024972	9.794569399605654
1	500	9.726400250729888	9.78153133392334	9.80442813814117	9.68633124558332	249816000	62.534313648204304	9.691259452274867	9.813905558677515
1	501	9.81858742367549	9.80533218383789	9.84118255150936	9.792980362968406	175924000	71.45374811976622	9.706882272447858	9.827816265352892
1	502	9.82792971241617	9.799912452697754	9.83485941279847	9.79418784764546	163139200	64.96538930665716	9.716092654636928	9.844644863236653
1	503	9.805635123381318	9.750804901123047	9.806538542539968	9.732427601692791	157494400	63.28375846104416	9.724485329219274	9.844835922048896
1	504	9.729413993455958	9.71766471862793	9.745381101075727	9.680005899507787	193508000	56.67566179718059	9.72878919328962	9.842957814562968
1	505	9.810453366535274	9.928851127624512	9.94963861290765	9.786352272433202	445138400	68.9176302571714	9.745789187295097	9.899613793445
1	506	10.0153162067372	9.980670928955078	10.017123849406044	9.886072571557657	309080800	75.91923501506697	9.769460337502617	9.957495861514927
1	507	9.928250812670898	10.0623140335083	10.072557342704465	9.92674404143675	255519600	78.5835870697261	9.798812321254186	10.030642278076844
1	508	10.0840050426649	10.054180145263672	10.099972150708801	10.029174823854534	300428800	76.85053892182944	9.825668266841344	10.083015043281277
1	509	10.062010552771763	10.126180648803711	10.133109542169679	9.999045551626871	311931200	81.03266783290749	9.859044347490583	10.143051208335837
1	510	10.207823463382647	10.316882133483887	10.34038067850002	10.157813636236876	448560000	84.05133940459072	9.902598789760045	10.262992261187968
1	511	10.390089777938634	10.292479515075684	10.392499163007034	10.22710433057362	444108000	80.55385175087652	9.940128122057233	10.346251079660432
1	512	10.340983229542829	10.376230239868164	10.376531915790746	10.303324420775091	302590400	81.7195253303471	9.98157364981515	10.43946291097401
1	513	10.39852581673035	10.414191246032715	10.44311352376489	10.359060165278832	296780400	86.72662919798272	10.029087543487549	10.519883867250718
1	514	10.42051682083325	10.498544692993164	10.498544692993164	10.37683334381784	308840000	87.44502848308994	10.080302783421107	10.608069421600991
1	515	9.927345208009886	10.262655258178711	10.386475957064256	9.821299258610269	1880998000	69.55191140974622	10.112968717302595	10.623760557586554
1	516	10.494627790338884	10.208124160766602	10.502160034635187	10.14907612794073	1135612800	66.74891631587309	10.14212669645037	10.621581416689276
1	517	10.135524512517051	10.022549629211426	10.19186151835533	9.94542512900129	764789200	60.02682782126703	10.161537034170967	10.592275564187721
1	518	10.05538461779241	9.842991828918457	10.088825605613986	9.840279962625148	754401200	54.17338068129491	10.170488970620292	10.565191374187396
1	519	9.847509853377732	10.166250228881836	10.166250228881836	9.842990345060008	574683200	57.3562952766586	10.18744604928153	10.557028343029947
1	520	10.132506470411228	10.285247802734375	10.286453701932507	10.079483106803469	546868000	59.06071266454835	10.209201540265765	10.561819876837296
1	521	10.332245425334644	10.359058380126953	10.41178006645365	10.288261077801804	506875600	58.869037337524446	10.230397565024239	10.58064816936125
1	522	10.356953011252457	10.339780807495117	10.384368523847154	10.328333207969823	285026000	58.47949341741644	10.250797612326485	10.589928255028012
1	523	10.3686994574938	10.12557601928711	10.37562834998551	10.04815149820508	592057200	49.98344633688845	10.25075442450387	10.58995357649632
1	524	10.116541630547632	10.222587585449219	10.24427929714892	10.071352173445298	377246800	47.27878406577045	10.244019099644252	10.581301269954178
1	525	10.28223999935307	10.394612312316895	10.41329048364806	10.272599237649533	426633200	52.71600417136689	10.251314299447197	10.597414519484085
1	526	10.377140266814331	10.373223304748535	10.401240564527846	10.350025621830218	258955200	49.91729380503582	10.251099518367223	10.596869381838324
1	527	10.357555107347064	10.346709251403809	10.370811153499933	10.199389994953385	393797600	48.13213581663888	10.24627937589373	10.584044260740518
1	528	10.352734444171912	10.438897132873535	10.444922608232996	10.348818287422931	321840400	48.356118225969155	10.242018835885185	10.567352421345227
1	529	10.480772633048762	10.60097885131836	10.642251344991378	10.473241191333363	485021600	59.71958898915266	10.26618480682373	10.64412937890032
1	530	10.65520725450931	10.70099925994873	10.710640020870448	10.609113573056403	381040800	63.79898572247116	10.301390171051025	10.742569550657578
1	531	10.700696293291788	10.790172576904297	10.815479569368893	10.691056338726868	482745200	72.71733295551596	10.356220381600517	10.83713131558095
1	532	10.766978886598634	10.681117057800293	10.845609339516788	10.484088009204925	928550000	75.88392674116957	10.41608646937779	10.825071643180252
1	533	10.687440801938033	10.750706672668457	10.779326468671986	10.650987084934888	367572800	71.40335596206086	10.457833358219691	10.876173348938208
1	534	10.748898514345628	10.820900917053223	10.829938323531408	10.74648832475967	310416400	70.3432918962656	10.496094294956752	10.943416178325526
1	535	10.821204111795346	10.842594146728516	10.844703465303668	10.771796823613936	284174800	69.12088807229843	10.53063256399972	11.006155801572413
1	536	10.86970593429275	10.939902305603027	10.993225740427691	10.860668527575891	481157600	72.35175564536581	10.573498385293144	11.081965240221285
1	537	10.762760996378132	10.794393539428711	10.853743272740592	10.74076760621868	530583200	76.25383153667269	10.621271065303258	11.07070122796189
1	538	10.806742690945303	10.561210632324219	10.830542913593003	10.529878164124703	816057200	62.00856053657573	10.64545842579433	11.034906801713474
1	539	10.307844200144643	10.20119571685791	10.40575614780119	10.174383562528396	872555600	43.947839912529375	10.631642954690117	11.070067077557406
1	540	10.20601958242911	10.322007179260254	10.382862073176073	10.201198397181543	671854400	48.49127928863358	10.627984660012382	11.076437486340234
1	541	10.36418300648264	10.329837799072266	10.398225733439869	10.193966958288637	499900800	49.49747045071711	10.626779556274414	11.078566660675431
1	542	10.401540029918031	10.488907814025879	10.49704180355761	10.38768224100758	380018800	51.432531691075795	10.630351747785296	11.076495161978855
1	543	10.58170154515986	10.641051292419434	10.69648407703032	10.57808625862398	403074000	51.1544283904929	10.6332140650068	11.079059791260995
1	544	10.709134481059758	10.523553848266602	10.716665923595356	10.474447427068355	456136800	44.939020177551136	10.620539392743792	11.068169496153953
1	545	10.543136081104521	10.608209609985352	10.67539245760429	10.496138174926417	602590800	44.79676508349632	10.607542037963867	11.04439190653986
1	546	10.760950866269267	10.832350730895996	10.839279624625068	10.722689503834763	500788400	54.05747708745913	10.61834444318499	11.070251463028459
1	547	10.847712456248663	10.845603942871094	10.854340476743815	10.777818576328803	453266800	52.62538012566111	10.625122819628034	11.088288755462054
1	548	10.887782673291664	10.705818176269531	10.89591746583025	10.58380513735193	546123200	46.9342284239018	10.61690262385777	11.069054877953773
1	549	10.692261891632485	10.717869758605957	10.767277850020564	10.612124681637434	356316800	46.66022117929947	10.607993738991874	11.045673615495625
1	550	10.68563076385304	10.618749618530273	10.687740081762469	10.562413453816513	453306000	41.408744200475645	10.585054261343819	10.979308087794651
1	551	10.517824584129578	10.444014549255371	10.537407774090807	10.390690318610828	507539200	40.771211325769094	10.560027190617152	10.941307449421346
1	552	10.403648414961626	10.604291915893555	10.614234352386003	10.393707587407846	471080400	51.1800582845452	10.56310442515782	10.945120518397356
1	553	10.6401409927894	10.651589393615723	10.739559706816486	10.583804820948588	435957200	64.88736878605428	10.595275402069092	10.91712344661531
1	554	10.306342667754889	10.406664848327637	10.479269834784196	10.2460895068762	721081200	52.58609840283588	10.601322378431048	10.903642396720928
1	555	10.303326793276344	9.942107200622559	10.333453364546168	9.829132357243388	1162011200	40.73970312567619	10.57362733568464	11.019864281045555
1	556	10.14756852602355	10.081591606140137	10.2313209939511	9.961687103746822	659422400	40.18006426728125	10.544533320835658	11.061993207074112
1	557	10.156607386778804	9.961989402770996	10.188843270547377	9.941804467040985	753214000	33.36760807756525	10.496028900146484	11.095346352723277
1	558	10.122267005934482	10.221985816955566	10.235241059535147	10.100273616550302	409402000	43.0955991942242	10.47448832648141	11.090976050337593
1	559	10.320198582252077	10.27922534942627	10.322006224876745	10.217164561584697	325922800	42.37214528977512	10.45098945072719	11.070592576233285
1	560	10.221383814459353	10.218672752380371	10.249702748377562	10.121061646025629	372996400	34.60322230538206	10.407155309404645	10.996636354386512
1	561	10.298806302200967	10.392801284790039	10.423832074182531	10.208727475543835	404712000	39.488056451234385	10.374812262398857	10.90763045882997
1	562	10.48619923074182	10.590739250183105	10.60640468661263	10.454565877314934	448910000	47.398647294005954	10.366592339106969	10.880633076207898
1	563	10.639238272285949	10.557594299316406	10.674486895961985	10.557594299316406	309355200	46.41120595660245	10.355144092014857	10.841899174431795
1	564	10.473844282764999	10.573262214660645	10.573262214660645	10.425642087920092	352900800	48.941930280133256	10.351894991738456	10.831626970442402
1	565	10.563619922272153	10.50306510925293	10.570851296260566	10.467214742090883	329406000	51.443772859523214	10.356112888881139	10.840351015103971
1	566	10.434678038017982	10.49945068359375	10.538313788257666	10.42564063054123	274019200	47.223992638658956	10.348624229431152	10.819384368598756
1	567	10.577778020237268	10.380447387695312	10.592238351840459	10.342487709974689	418661600	43.08329396286509	10.32925694329398	10.767513152491166
1	568	10.37292267859527	10.278926849365234	10.381659217728783	10.19487345909939	460084800	46.48423822230435	10.320132800510951	10.756762647539109
1	569	10.152388674095189	10.20962905883789	10.310854592150463	10.12256298488552	482731200	59.41058739305959	10.33924150466919	10.72506490089112
1	570	10.279827294170303	10.1840238571167	10.360566240277926	10.156910025927802	402539200	53.9170779170575	10.346558094024658	10.714819537804138
1	571	10.185830090684926	10.18522834777832	10.256024848784763	10.123467644000462	373447200	59.3868020239431	10.362503732953753	10.673990547978642
1	572	10.240661713884727	10.094245910644531	10.247590606888183	10.06080573598209	377535200	43.73883395394189	10.353379453931536	10.689135572726938
1	573	10.064122965021676	9.965910911560059	10.112626846310318	9.942412356629283	398946800	35.643481285581686	10.330999851226807	10.724798215963101
1	574	9.956566735363602	10.01410961151123	10.054177808078846	9.947830200042777	425639200	40.51928673212851	10.316388198307582	10.742032970931412
1	575	10.09304007952132	10.126481056213379	10.126781927662844	10.01772326745366	346220000	36.90762287772847	10.297365324837822	10.732008723259819
1	576	10.086416755954632	10.014715194702148	10.122568810405207	10.00387014149562	301800800	19.061210147429293	10.256220749446324	10.680156863333808
1	577	10.041221868865502	9.86528205871582	10.051465174182008	9.845398799923487	453605600	16.944518817630268	10.206769875117711	10.640667254293671
1	578	9.824314367405854	9.997542381286621	10.00899078591546	9.645361748975946	609898800	25.265298830964284	10.165647029876709	10.556957181311759
1	579	10.03519913442493	10.17860221862793	10.182216699085043	9.993322486262228	419378400	37.272496015921355	10.14247110911778	10.482809837620245
1	580	10.348816948542561	10.315677642822266	10.416300654899134	10.288262940187508	700666400	43.4744946543006	10.129344463348389	10.421078127977037
1	581	10.694972268801886	10.565427780151367	10.698889229605951	10.499751714617776	753810400	56.01030483164479	10.142557348523821	10.493939052830815
1	582	10.5545831302986	10.635021209716797	10.657315467034266	10.55337723083918	266546000	61.81520048299701	10.167992659977504	10.603402714189677
1	583	10.653397709416359	10.556992530822754	10.694671003038069	10.524756644481938	338800000	61.45911788227315	10.192804336547852	10.675460405987566
1	584	10.611824609166073	10.548859596252441	10.615139022959582	10.456973909582342	356213200	62.17586863640762	10.218864032200404	10.737531142652973
1	585	10.429556017554415	10.446427345275879	10.536806240192703	10.409371081265112	360959200	58.16543071337471	10.23752110345023	10.769594291344415
1	586	10.447331234420854	10.548255920410156	10.663339264670645	10.444016821234646	1006345200	64.09736296303316	10.26995038986206	10.819463804300046
1	587	10.536504516939218	10.432266235351562	10.558497093706496	10.408767692394061	442713600	64.59257039965003	10.303261484418597	10.829425497791076
1	588	10.48378881694741	10.49011516571045	10.541029240845752	10.412388119533423	313348000	64.8051208428746	10.337261881147112	10.844100943470725
1	589	10.491918013081033	10.531384468078613	10.599470719708698	10.450343044282748	389250400	63.176430571831496	10.3661835534232	10.867389331178991
1	590	10.496135496139377	10.446427345275879	10.572959085310126	10.42533818562405	335969200	64.29832601912959	10.397020135607038	10.856457930716608
1	591	10.535000938930906	10.443717002868652	10.544340023047083	10.430160086206941	280134400	71.2201648120587	10.43833691733224	10.780976525840392
1	592	10.47986772074398	10.47203540802002	10.520238401662887	10.439799520267165	204747200	68.84411795005423	10.472229276384626	10.702486828852484
1	593	10.510900617052423	10.527771949768066	10.535002520931913	10.443718571161899	282091600	65.39994834871516	10.497169971466064	10.65452294092917
1	594	10.514817423182388	10.46088981628418	10.544341450528764	10.40093834244402	336000000	56.82722676475916	10.507542269570488	10.62823317879187
1	595	10.427449593854725	10.44100570678711	10.457576166355162	10.311462008163774	322000000	42.53717512521364	10.498654978615898	10.619308414006914
1	596	10.413587889084896	10.258133888244629	10.431361829482565	10.253615185283929	326116000	30.09869199616874	10.4717344556536	10.625076415809723
1	597	10.218975694293313	10.041227340698242	10.279831403045057	10.020138171201408	449775200	26.248846080538527	10.43489408493042	10.70407298755269
1	598	10.002057382028989	10.126781463623047	10.126781463623047	9.963796028145804	452334400	31.856868900616803	10.404745646885463	10.71094137034518
1	599	10.136724170315677	10.239154815673828	10.274704308070389	10.12256470854442	334776400	41.16584032250591	10.389940466199603	10.707295240065351
1	600	10.305738016567208	10.259041786193848	10.315679649323194	10.2030056661703	261170000	36.74775715677834	10.36928231375558	10.6798236388003
1	601	10.229820174680237	10.09907054901123	10.271696835240505	10.093045072350074	337968400	35.323986212029936	10.345482621874128	10.684954696664127
1	602	9.940903052175692	10.074363708496094	10.121964158375105	9.924333397516946	383600000	31.136997527607804	10.31578608921596	10.673029684972779
1	603	10.107504453622392	10.007784843444824	10.119555404843057	9.982176974335598	321927200	26.777176211826415	10.278386116027832	10.64782402641888
1	604	10.04513817586843	10.146062850952148	10.19968876335963	10.027665106299116	294224000	37.279797998563836	10.256931509290423	10.61914759055443
1	605	10.121662802741627	10.092439651489258	10.14937918302291	10.07526745012844	222560800	35.738661310193535	10.231840269906181	10.58691614804545
1	606	10.086413400055672	10.165043830871582	10.171671852801687	10.071651389809597	203599200	37.96920993187496	10.209912300109863	10.537980170846273
1	607	10.276214669539911	10.47896671295166	10.47896671295166	10.273201126995232	417754400	48.40926243439793	10.206426211765834	10.520691213220417
1	608	10.510295415323968	10.409069061279297	10.608507423436786	10.383161132073157	554682800	48.314289543370954	10.202724729265485	10.505073830099512
1	609	10.438896500526035	10.42684555053711	10.483484211015762	10.372617884525534	338783200	49.53874275091736	10.201713289533343	10.50070476209164
1	610	10.338876937691932	10.346709251403809	10.403648788401856	10.303628308111032	313250000	53.09224737446297	10.208040101187569	10.515794659993157
1	611	10.414794707124958	10.1840238571167	10.455465453908305	10.177094963572017	461941200	55.18131290516585	10.218239852360316	10.511293072255045
1	612	10.187943560340468	10.003266334533691	10.189449527158917	9.999048501184799	529785200	45.80792756937805	10.209417343139648	10.521171624894576
1	613	9.995431953561186	10.009289741516113	10.086414212155775	9.961389226701286	333723600	41.59142365750448	10.19299840927124	10.52175479784132
1	614	10.039716900968758	9.9866943359375	10.0523703970297	9.964400080972984	275088800	40.05709968421089	10.173545019967216	10.51735357219283
1	615	9.958375566967188	9.818286895751953	9.99181655040415	9.806536817470535	433955200	39.811866448986144	10.15348904473441	10.545405260230101
1	616	9.857451116574195	9.839375495910645	9.890892100835318	9.793281818525827	329473200	41.451090354352154	10.136704172406878	10.561930553913742
1	617	9.941806818041407	10.015316009521484	10.039718782835665	9.921019329993722	334569200	50.25379046683691	10.137242112840925	10.561784449901772
1	618	9.934273707900443	9.843894004821777	9.950843360354993	9.787556221113249	399196000	40.03979717898986	10.115658623831612	10.568078131657192
1	619	9.848413679519151	9.795992851257324	9.902038798316998	9.590228108150521	510591200	40.19140899868418	10.094483852386475	10.578248250919804
1	620	9.911375506926653	9.648368835449219	9.919208621948052	9.621255010998032	615020000	33.71321688113903	10.057578495570592	10.594109461311467
1	621	9.561008122405468	9.499549865722656	9.571251433342457	9.354339087376525	640645600	15.5395760701427	9.987620149339948	10.542562236401842
1	622	9.540520336143818	9.800211906433105	9.815274791409443	9.495932619853841	493382400	31.57032675761326	9.944130352565221	10.450063133196569
1	623	9.795995292280802	9.719172477722168	9.90867009441596	9.712242777480185	390583200	29.36936135430365	9.893582275935582	10.328134742651505
1	624	9.60860495101182	9.978862762451172	9.992720551048816	9.583902111439786	559759200	40.29252661838202	9.867307526724678	10.220752172290355
1	625	9.983082476494031	9.831846237182617	10.036707607355275	9.793886540445213	439807200	40.62852586535489	9.842151982443673	10.1450046662117
1	626	9.869203108913611	10.003266334533691	10.059302458842367	9.858959799352018	339813600	50.0	9.842151982443673	10.1450046662117
1	627	10.051767361917147	10.100271224975586	10.143653836939702	10.045441015921897	294299600	52.32020880687553	9.848650659833636	10.170275589388302
1	628	10.123771666772388	10.063518524169922	10.133713298542013	9.998444196974853	352545200	51.94512429517133	9.854138101850237	10.188286391867463
1	629	10.083402771425977	10.112625122070312	10.126484520746171	10.027367455964692	322954800	57.93155909170342	9.875162260872978	10.23559833268755
1	630	10.121059030034438	10.341285705566406	10.348515470731503	10.068337333154528	435313200	62.16421860373739	9.911012990134102	10.347860984175433
1	631	10.33345273071211	10.527167320251465	10.539218269807938	10.318389848235784	355054000	62.34566055373812	9.947573798043388	10.49396641354356
1	632	10.512708497541905	10.59736442565918	10.667861691631252	10.445224774092328	444626000	69.10638981174401	10.001393113817487	10.643791981307873
1	633	10.685030260278989	10.761250495910645	10.785351587664268	10.66484451995782	399663600	73.1170540879308	10.070340088435582	10.816579969445787
1	634	10.644963233805003	10.836870193481445	10.845607534716846	10.610618829788642	489633200	79.48027936190728	10.155233042580742	10.962594107997198
1	635	10.735344634810566	10.664847373962402	10.838679531346164	10.629297871989602	442674400	78.57577508003956	10.23846857888358	10.993196409117866
1	636	10.65068356818538	10.657312393188477	10.77571012617761	10.502761820922753	451609200	74.54702975299881	10.299690042223249	11.04019591950296
1	637	10.795294662083553	10.785956382751465	10.84560697494607	10.7365474888836	391638800	79.74131054858245	10.375888892582484	11.077601238977486
1	638	10.876030694254156	10.778420448303223	10.894107112653773	10.735339524487635	430533600	75.93804546970492	10.43300015585763	11.125607017673948
1	639	10.880856775946988	10.993831634521484	10.99624182490479	10.820603625303182	484467200	86.09371574825076	10.515999112810407	11.176008716216627
1	640	11.009195431468433	11.261356353759766	11.286963418100028	11.004676727048237	572653200	86.87720243782577	10.60586268561227	11.306488175298718
1	641	11.387886238716732	11.353240966796875	11.407468628747688	11.246893352281543	819145600	86.83769291763352	10.69536052431379	11.436702495826589
1	642	11.933780282762672	11.656011581420898	11.938298985722678	11.628897754722654	941340400	90.48682629445828	10.809110028403145	11.618410121210463
1	643	11.657518497437927	11.66776180267334	11.75121179733171	11.565632035175398	526534400	90.30262826840557	10.920191219874791	11.744455328040573
1	644	11.698793403827569	11.848824501037598	11.901546196221737	11.681621203732956	516728800	90.05733521257817	11.027872562408447	11.917640235629039
1	645	11.759950899988986	12.005484580993652	12.05067403443282	11.737959123002417	589806000	89.90049894671381	11.133466652461461	12.113560701073174
1	646	12.050673807821491	12.153406143188477	12.186244578997472	12.041033852498138	476582400	90.30717512717442	11.244612489427839	12.311862373874355
1	647	12.068444970693134	11.827431678771973	12.130204863060712	11.81417563799573	659324400	75.47847402452376	11.320768288203649	12.391593424770544
1	648	11.798216508149014	11.804241180419922	11.959996134047227	11.693073950202288	594034000	73.7113705704313	11.38986621584211	12.450984838742361
1	649	11.678308997123294	11.76386833190918	11.904560362768413	11.568647761437733	632584400	78.79674132017414	11.46836771283831	12.458684189041232
1	650	11.983790680200412	11.952760696411133	12.035608146648487	11.820805231799806	612836000	80.99758112363654	11.56089973449707	12.462917511983044
1	651	11.97987851935787	11.716570854187012	11.987409961987488	11.69970032616034	639539600	71.1778442360029	11.627372196742467	12.413042570803459
1	652	11.778927798371535	11.82682991027832	11.856353925846024	11.515621847652948	732508000	72.79285017351673	11.702258586883545	12.321614580579865
1	653	11.731634484268602	11.368908882141113	11.789175767565945	11.368306334555031	871407600	57.37651418503433	11.729049818856376	12.23922640963639
1	654	11.461395562725317	11.25593090057373	11.553583715452998	10.92303187481739	1204590800	49.88639354522032	11.728662286485944	12.240375165952504
1	655	10.896525105197854	10.641051292419434	11.079695600667586	10.635326686502806	1143833600	37.7665233064862	11.677791595458984	12.433638478009282
1	656	10.884772494388693	11.267683029174805	11.285759456321053	10.69497403170003	1082583600	43.997426744170966	11.65005384172712	12.437197257928956
1	657	11.181519303773191	10.956774711608887	11.28696270565657	10.920924341113809	878656800	39.940310381697266	11.599269049508232	12.468910533748675
1	658	11.162540243763644	11.258343696594238	11.311065401241233	10.987805474204158	741969200	41.92084683634223	11.557091849190849	12.431856935338185
1	659	11.389995022664973	11.35745906829834	11.437293792247262	11.274309126568168	528976000	40.99164740388629	11.510804312569755	12.351270677143733
1	660	11.436990903635754	11.550869941711426	11.597867831505141	11.390595561204384	460544000	41.7286142907153	11.467766012464251	12.223967667599668
1	661	11.493933178361702	11.462600708007812	11.549667616037267	11.329440926880984	498750000	44.642068320481215	11.441706657409668	12.169113663264872
1	662	11.517735118268863	11.461398124694824	11.58431461651497	11.387888926853591	442061200	44.932255175133974	11.417217867715019	12.114510159713838
1	663	11.172180355428738	11.027873039245605	11.226710504050994	10.88688013667518	851435200	40.25365967503737	11.364646775381905	12.060333382810548
1	664	10.910980738451808	10.72600269317627	11.056493132355554	10.72509927423358	775888400	34.226752850737526	11.277021203722272	11.962570380438285
1	665	10.981477354398658	10.738354682922363	10.992624884662368	10.697683936006573	535315200	36.65422993673037	11.207148620060511	11.899087851196846
1	666	10.85464392000577	11.255329132080078	11.256534227001088	10.755226002430135	656835200	42.981877973199914	11.166327135903495	11.7614409902935
1	667	11.251415313915016	11.333059310913086	11.416811017907756	11.164951740356019	626267600	49.51441988606287	11.16376645224435	11.755423858011216
1	668	10.998651500826398	11.258946418762207	11.311065576659194	10.996241310555828	871346000	50.0412796104834	11.16398184640067	11.755785964152615
1	669	11.18212374048269	11.555996894836426	11.562624114162219	11.170977011789049	641477200	63.71846678735154	11.229335103716169	11.772454053243251
1	670	11.694577838136192	11.748504638671875	11.79459912530692	11.689155714503253	405269200	58.28831713846269	11.263679504394531	11.873908223424177
1	671	11.696684627369125	11.749105453491211	11.804839888508003	11.63522639354538	417922400	65.29424174289989	11.320274557386126	11.954391227278675
1	672	11.7665769328188	11.593649864196777	11.812068051439361	11.504173593109327	522586400	56.85928395344971	11.344224997929164	11.993415200540262
1	673	11.623478106873778	11.479170799255371	11.669270106986692	11.46983171543346	343725200	52.474277011077085	11.352918692997523	12.006119767303515
1	674	11.289672292368552	11.268885612487793	11.38788591569928	11.202004455893233	438939200	44.30660335578482	11.332776955195836	11.977012948416018
1	675	11.067637795868233	11.440305709838867	11.458079650935662	11.040824839556285	509698000	49.56447706695481	11.331184455326625	11.97414701438024
1	676	11.615646182978615	11.566539764404297	11.61685127807747	11.508394328119204	350576800	51.95823808483467	11.33869457244873	11.990602934558385
1	677	11.520441808582953	11.57286262512207	11.707529146208211	11.517730747661913	416158400	62.07120167668546	11.377622400011335	12.014491920926613
1	678	11.56654006555896	11.372222900390625	11.628901727375023	11.298110354350731	564813200	64.98540627351107	11.423780986240931	11.939324421039478
1	679	11.23725472073704	11.446333885192871	11.474652009942329	11.204114606846698	467832400	65.96040181247318	11.474350929260254	11.806568793752415
1	680	11.512611913425822	11.587327003479004	11.635227521455171	11.455672377933233	440560400	59.012165679394975	11.498065062931605	11.809695173869372
1	681	11.659630357500246	11.72831916809082	11.81598782394823	11.621670666966576	534724400	60.37315943120067	11.526297909872872	11.84506913400308
1	682	11.792487412397666	11.838581085205078	11.859670245765777	11.746393739590252	417818800	64.92862009660763	11.567700386047363	11.887457363315537
1	683	11.916310898925666	12.065738677978516	12.065738677978516	11.900946337709977	698513200	63.61881990594022	11.604110513414655	12.01981755150667
1	684	11.960292401240697	12.401045799255371	12.449248790152375	11.906065544861345	823860800	66.1980346621025	11.650720596313477	12.244400463104446
1	685	12.510103051415516	12.455875396728516	12.739367902495417	12.387789152448395	775754000	67.08420778914211	11.701204163687569	12.434667120272852
1	686	12.64236494779336	12.416415214538574	12.701112135869838	12.41219738106714	605976000	71.06960355349239	11.759973117283412	12.582726761025459
1	687	12.081704616884616	12.105504035949707	12.346518204263212	11.951255901413425	968480800	64.57317051522381	11.804711205618721	12.629802769156518
1	688	12.05911001335115	12.180219650268555	12.253728838044813	12.046155644033593	546277200	72.63221067878894	11.869806494031634	12.655661493465313
1	689	12.04645578813992	12.146175384521484	12.17057815513257	11.78857190345039	812876400	68.81335442690488	11.920225756508964	12.677430265424032
1	690	12.313679792024324	12.028380393981934	12.329345222268485	11.99222834911251	632497600	62.36493742656104	11.953214372907366	12.683816618323652
1	691	12.056395997017344	11.960594177246094	12.163346150514272	11.945529687612158	429637600	60.05004182511761	11.980909483773369	12.678031606265376
1	692	12.10851866937013	11.766580581665039	12.117255206496472	11.635227630886776	651086800	60.25702464579117	12.009077889578682	12.627702087347211
1	693	11.662643128008948	11.487908363342285	11.715968183190432	11.483690530552307	547640800	50.97733087382715	12.012047495160784	12.61933023744895
1	694	11.459289779615803	11.285457611083984	11.527676921661783	11.24237746846727	669099200	43.102957640232866	11.990485395703997	12.678763401977603
1	695	11.284554281564194	11.22219181060791	11.502370013616705	10.672079518433941	1233677200	38.01027381631747	11.954333441598076	12.747158556514888
1	696	11.082404393723305	11.395421028137207	11.442719002687848	10.854646231957148	786469600	39.80603055863287	11.922679151807513	12.768995053053226
1	697	11.247196683160706	11.368908882141113	11.592147533733469	11.20110299952952	812582400	32.34079309446436	11.872905594961983	12.763769696030792
1	698	11.321004869255544	11.140847206115723	11.380052909740584	11.101381555296715	535458000	16.228049998517662	11.782891409737724	12.69820857394821
1	699	11.420728236734966	11.7135591506958	11.7135591506958	11.394216140471197	442514800	34.428868812207	11.729868820735387	12.559216645557205
1	700	11.826834271867122	12.059412002563477	12.146478919710193	11.794599183581461	605687600	43.36430799097952	11.704368591308594	12.46160181242508
1	701	12.271805824403259	12.116653442382812	12.329347107224622	12.054893522024363	622286000	50.228813469756346	11.705164977482386	12.464236731569665
1	702	12.200705385304593	12.304643630981445	12.304643630981445	12.136536082399353	426185200	52.440042521389735	11.714052404676165	12.499537883231262
1	703	12.557706966795504	12.713461875915527	12.713461875915527	12.510708261650109	573367200	59.69919030333704	11.754572868347168	12.681820487776262
1	704	12.705629072533682	12.652907371520996	12.855057638813353	12.530893510550017	686044800	60.89103509936683	11.799181938171387	12.836706541193141
1	705	12.706231493408792	12.72069263458252	12.798118787912824	12.532400950131063	881602400	63.255250820323745	11.853474685123988	13.001093819287478
1	706	12.091345683327544	12.009099960327148	12.304340996624228	11.984395512699901	1104059600	53.58254187756188	11.870797497885567	13.020086773093045
1	707	12.050673572744055	11.909379005432129	12.061217751326913	11.876240503229972	549270400	56.573589503770926	11.900902543749128	13.028870086136836
1	708	11.993432171455384	11.835868835449219	12.024763833088347	11.77200041733321	621244400	58.94440332417116	11.940217631203788	13.012788586627558
1	709	11.93559073567533	12.224505424499512	12.24649720158844	11.912092187598818	502138000	64.73029731878265	12.011811460767474	13.00908875068359
1	710	12.202211825497697	11.983491897583008	12.24800463358906	11.971743427379991	430427200	58.47363834219077	12.053816522870745	12.986717598675357
1	711	12.103694614339465	12.068748474121094	12.127495638844547	11.844303992479633	456304800	59.916263057884805	12.10380506515503	12.94954186396948
1	712	12.278434401473328	12.191970825195312	12.321817832111133	12.107616567919157	494664800	65.34976757737044	12.178885323660714	12.81768145383058
1	713	12.141054268092864	12.199801445007324	12.241978967238424	12.126292255982378	322842800	58.50363553760525	12.213616916111537	12.7935950800049
1	714	12.12358216299417	12.194681167602539	12.331757924688286	12.082308056517174	385501200	52.68573086189542	12.223278999328613	12.79666036113231
1	715	11.972647439125545	11.94553279876709	12.035611648340069	11.846416540210669	531790000	46.843025901076444	12.211056096213204	12.801277034296028
1	716	12.053387433040491	11.972647666931152	12.06393161336805	11.903355500277154	327350800	43.488551568723324	12.187342098781041	12.787951906134996
1	717	12.022655644433218	12.143162727355957	12.153104358568593	11.910885902229076	441386400	37.661320473638646	12.1466064453125	12.66527270697869
1	718	12.111829120376255	12.057902336120605	12.15430750431651	12.025365581798624	302229200	37.262962255245405	12.104106085641044	12.53396746179964
1	719	12.047963328672386	12.042539596557617	12.050674390260458	11.934084261525756	270275600	35.14975029435486	12.05566658292498	12.298280345697954
1	720	12.117254435603536	12.238363265991211	12.291688317843331	12.097672043964511	400442000	56.485392220550814	12.072042533329554	12.331482697631547
1	721	11.959387058794402	11.908473014831543	12.077483925039589	11.87684048591398	558684000	49.977324219738335	12.071977819715228	12.33159315748431
1	722	11.961193915123951	11.605398178100586	11.96661684087422	11.5129091778658	744752400	44.826162874840186	12.05551562990461	12.396196152265446
1	723	11.647278472184611	11.587327003479004	11.710243483041918	11.45597405393614	653786000	32.84114816610645	12.010002885546003	12.417187878535863
1	724	11.554180669792865	11.425841331481934	11.606300601408824	11.393907133707236	432905200	34.3107745887454	11.97017070225307	12.483733883709215
1	725	11.472242368559344	11.714159965515137	11.734344100458026	11.431571618213681	430810800	41.04682505703296	11.944842951638359	12.472252061644193
1	726	11.726811975629408	11.59184455871582	11.783751505477813	11.578286838254453	349210400	34.84018154836471	11.901976789746966	12.440302333262336
1	727	11.568044044980335	11.370112419128418	11.586120470085572	11.312570339247358	479900400	31.08525540792739	11.842713287898473	12.420997667351317
1	728	11.415603660530156	11.295699119567871	11.447838745578991	11.293891477039677	371938000	30.133226213955226	11.778500284467425	12.387271670410113
1	729	11.158923301460176	11.117048263549805	11.197486339465124	11.023655014820072	447980400	31.102336340645167	11.71932281766619	12.413263571106658
1	730	11.17760377599157	11.342999458312988	11.385779529882905	11.175193585792174	409021200	36.83221087800419	11.674347945622035	12.3790960608218
1	731	11.282741708212134	11.05618953704834	11.322810704548742	11.052875124405656	428271200	28.322621824395156	11.596707003457206	12.31826857714348
1	732	11.099275416316818	10.953161239624023	11.181521154685157	10.94562899219315	254760800	28.123315678210176	11.517796925136022	12.263325317794527
1	733	11.217668064516937	11.331245422363281	11.349321842547067	11.156812392169684	346413200	37.68385558403128	11.466990198407855	12.153048944959348
1	734	11.322812201113138	11.243277549743652	11.412891030213085	11.152897849165015	375855200	32.101446913622596	11.395912647247314	11.92622507938608
1	735	11.487006752266907	11.514421463012695	11.516831653557752	11.396927087349688	405938400	42.759193544147415	11.367766107831683	11.816434794031885
1	736	11.524660285370459	11.687043190002441	11.719278269286683	11.470733499627014	387181200	51.57579695446422	11.3735978943961	11.837437848730394
1	737	11.744287861403906	11.740371704101562	11.85876949600226	11.70662984179009	379055600	52.91419170082134	11.384529658726283	11.87643309901232
1	738	11.854549030319976	11.840087890625	11.942519354525865	11.761156583197748	357210000	58.07787222884475	11.414118698665074	11.963235114148619
1	739	11.82502256328528	11.778024673461914	11.888891779264918	11.73072671666085	283598000	51.365899088231195	11.418680463518415	11.979471164527304
1	740	11.747295816966453	11.721989631652832	11.777724057208767	11.651794069078184	304746400	52.86468009214535	11.427976540156774	12.00520626182754
1	741	11.793090192694631	11.76928997039795	11.915103236991248	11.756335602318062	376356400	59.517304355102176	11.456489222390312	12.0602329202066
1	742	11.835270226747404	11.858467102050781	11.871120601327592	11.780439201017298	296993200	63.323872809008044	11.496686935424805	12.128596555015774
1	743	11.800020661269611	11.804841041564941	11.866901828928635	11.7328386220768	301067200	67.30859229314854	11.545814990997314	12.157194327845255
1	744	11.839790066126694	11.7135591506958	11.912094978740217	11.662042533978381	338928800	60.00331590253306	11.57228354045323	12.177897288703273
1	745	11.649988885215619	11.453864097595215	11.670475500315012	11.378246397151582	406887600	60.89477897544264	11.600688866206578	12.135153402811188
1	746	11.548461759569845	11.416205406188965	11.560813580410285	11.397225563210686	256200000	63.156907812195996	11.633763449532646	12.036751227491111
1	747	11.458984270962281	11.478867530822754	11.573164188364634	11.435184050741693	421478400	55.11058579602294	11.644307885851179	12.01999852445872
1	748	11.522552125861555	11.514719009399414	11.594253659922785	11.46259905978976	235530400	59.748922274277	11.663696561540876	11.972252148248648
1	749	11.681920565513929	11.928658485412598	11.933177992939246	11.666857685676094	337215200	63.49344120821189	11.693284920283727	12.019138337175788
1	750	11.950952489248838	11.94372272491455	11.969330587192179	11.809959615458258	262948000	59.31754168778404	11.711619172777448	12.06378197062662
1	751	11.960292454331242	12.006989479064941	12.02446335496276	11.933179428255821	202358800	59.60897184286558	11.730663299560547	12.116728250127919
1	752	12.04133686679177	12.15099811553955	12.158831234264982	12.035311390849131	269399200	60.85860856809974	11.75287117276873	12.197394404392963
1	753	12.1440633757498	12.247397422790527	12.32452186879905	12.141652382063688	265076000	66.00898920553716	11.786397797720772	12.303903640261831
1	754	12.258244608545727	12.130206108093262	12.299216220757692	12.091041333521746	228662000	63.36554458116635	11.815556117466517	12.362588053347034
1	755	12.153105198023624	12.204922676086426	12.220890587687814	12.066039896553358	215978000	64.0116388925016	11.84667273930141	12.430678309291437
1	756	12.156419812141394	12.201309204101562	12.23987144430964	12.155818069037698	179662000	61.66943230420455	11.871161460876465	12.485273776881618
1	757	12.333867890693126	12.388998985290527	12.427260355913267	12.321816938612038	302220800	68.22033091638566	11.912887028285436	12.584296172420178
1	758	12.351942081128076	12.455577850341797	12.49293579989155	12.330251172955675	260022000	73.5063640291117	11.965888363974434	12.684973684591494
1	759	12.501068813228626	12.59385871887207	12.609524150086749	12.432379199698845	271269600	89.1234037205119	12.047316551208496	12.774772019867152
1	760	12.646276673038527	12.725509643554688	12.736053820632343	12.629707022068171	318292800	92.21073499724213	12.140838282448906	12.855318929870277
1	761	12.818904264292357	12.705326080322266	12.886688841732576	12.693877678689796	394024400	90.65333762405095	12.228442464556013	12.892246591209274
1	762	12.831256333144395	12.750818252563477	12.833968199146039	12.698397424204217	258196400	90.71269454171268	12.31673526763916	12.89490302655561
1	763	12.733946216137133	12.730030059814453	12.739068271869774	12.632419783024753	215084800	85.61889978458234	12.373976094382149	12.945274530902072
1	764	12.72189657943138	12.695083618164062	12.740574747289305	12.615548957838389	212587200	82.81605475430621	12.427644729614258	12.964991130647654
1	765	12.644170067572066	12.647482872009277	12.666764391375741	12.612837598601562	226021600	78.36197940860987	12.47339425768171	12.963444318347726
1	766	12.779741836653807	12.794805526733398	12.833669444904032	12.742384689725847	242897200	78.42530095623871	12.519380501338414	12.999843130411726
1	767	12.862892094637777	12.927664756774902	12.938509809413762	12.84300882774199	276791200	79.09824295747069	12.56797102519444	13.0671737096031
1	768	12.958993273610721	12.886689186096191	12.995747060369174	12.849332047398043	261738400	84.6153443337191	12.622005530766078	13.079079079718355
1	769	12.878858129805884	12.662246704101562	12.879159001354624	12.645677048247624	413974400	68.40449286408956	12.654671532767159	13.043634667857544
1	770	12.733647125048952	12.876447677612305	12.90778015045164	12.722500397523486	306062400	73.23237030337478	12.702895709446498	13.008126669582264
1	771	12.8068524137835	12.665557861328125	12.8068524137835	12.639649127084327	547638000	59.36717700709532	12.722649914877755	12.97083660791206
1	772	13.690773876643853	13.456388473510742	13.69107474823227	13.368117254498188	958314000	72.74089714885535	12.79413638796125	13.222259097021391
1	773	13.507602600202997	13.395230293273926	13.520556166342326	13.350341705706647	323985200	68.87052910753947	12.851377214704241	13.369070617394229
1	774	13.386494245651399	13.475067138671875	13.511219192145024	13.369322844832858	299709200	68.09190324442926	12.90491703578404	13.513581726594362
1	775	13.427763867011135	13.647688865661621	13.674501825709834	13.418123912007902	379341200	71.18654097753985	12.97222866330828	13.685288756349442
1	776	13.725414823646913	13.752227783203125	13.80525035039034	13.649495453132701	391683600	71.93175856088277	13.043757915496826	13.855256765228226
1	777	13.810376968832932	13.743494987487793	13.827850045342066	13.724215072588258	270046000	72.31360899284458	13.116148267473493	13.985819375029443
1	778	13.73475457329906	13.71125602722168	13.773015129664696	13.676911627045866	186796400	72.39992566531228	13.188732010977608	14.076454364332898
1	779	13.776933981063276	13.848634719848633	13.858275479807386	13.724513153256847	286599600	75.46942029167211	13.274528571537562	14.16906445147121
1	780	13.80947095716707	13.97787857055664	14.008306819189713	13.804048833758998	249412800	75.27989325134271	13.359033788953509	14.28144252668731
1	781	14.016439745108013	14.124293327331543	14.15201051056639	13.996254002908884	316223600	75.4222741617325	13.444507258278984	14.415230387932072
1	782	14.174608962505486	14.36079216003418	14.364104965334233	14.150507057019912	407890000	78.9150079185169	13.549800327845983	14.577971254146046
1	783	14.483698547322886	14.85757064819336	14.965424186527372	14.477673075158599	884214800	88.90537294645036	13.706609180995397	14.81794320546032
1	784	14.790993768170704	14.865104675292969	14.991636394906013	14.71838721817925	631302000	88.02844796017665	13.848656109401158	15.010142801363585
1	785	15.049182303633197	15.141672134399414	15.178727597431104	14.97567312057593	517216000	96.18971342529076	14.025521414620536	15.164839309120163
1	786	15.20372713720736	15.348335266113281	15.351347198035576	15.123590762606042	460398400	95.12786893002468	14.160660471235003	15.44834119930516
1	787	15.49295738238163	14.993156433105469	15.855380646063546	14.969656263567973	1506120000	83.42623791312813	14.274798052651542	15.55346059079956
1	788	14.80726165225025	15.129918098449707	15.210657830090183	14.660544196019663	944552000	83.81177112459933	14.393001692635673	15.659095562272558
1	789	15.157038376311258	15.127213478088379	15.297429547710815	15.072382453298099	535805200	82.48511006116789	14.498682022094727	15.743603838514217
1	790	15.270616004825532	15.510725975036621	15.510725975036621	15.187466051661	605595200	84.39660958394316	14.62428903579712	15.899268117941146
1	791	15.457397111407662	15.456192016601562	15.530002062302255	15.336588368269087	483302400	82.91104143263189	14.746624537876674	15.985712124978646
1	792	15.517652761231373	15.55711841583252	15.600501835893072	15.349546030843202	568027600	84.55768741146446	14.878471851348877	16.032913312573026
1	793	15.655939669028369	15.738486289978027	15.75324830629638	15.624909669386325	415072000	84.80791693819371	15.013461249215263	16.088398016694207
1	794	15.70533648344665	15.839401245117188	15.921947810943854	15.553800263666536	547582000	84.6477093206951	15.146427154541016	16.125840757836237
1	795	15.90568326690092	16.130126953125	16.130126953125	15.842115720419773	600387200	85.43038793923935	15.289700984954834	16.210083854585672
1	796	16.31540846338643	16.3419189453125	16.497675467969373	16.13886606247484	952011200	85.30210069524692	15.431210041046143	16.34554606520777
1	797	16.51454312834129	16.403074264526367	16.515749832168623	16.231352265205242	683270000	82.60090606241047	15.5416031564985	16.52795285937853
1	798	16.39614815794841	16.424467086791992	16.473271022284994	16.344329071460983	431712400	82.70204303019345	15.652986185891288	16.66217331624512
1	799	16.43169634690345	16.06234359741211	16.493756322828926	15.846634821295947	809124400	68.63893604106075	15.718748433249337	16.704114693129966
1	800	15.776138799036255	15.974974632263184	16.07830870509741	15.551995972713032	810238800	63.330148277534	15.76350838797433	16.73319894383013
1	801	16.172009914276085	15.987936019897461	16.20153394656299	15.765299073428782	798520800	74.7674273931828	15.834564072745186	16.70142670026895
1	802	16.108431954222407	16.328357696533203	16.35848345261651	16.03100663729008	516457200	77.0907069964089	15.920166901179723	16.721498777733817
1	803	16.39524344573991	16.424165725708008	16.50159106819937	16.36210413774576	418919200	78.13339247066476	16.012806347438268	16.712701343767314
1	804	16.538944735617328	16.629928588867188	16.629928588867188	16.479293347277327	407282400	76.30625812285456	16.09274939128331	16.80122662418764
1	805	16.796835975171334	17.114973068237305	17.11738325867488	16.742907561895798	690855200	82.42636498270701	16.21123375211443	17.010175611521962
1	806	17.41473612219495	17.762096405029297	17.91694713298426	17.33489895861225	1418844000	85.51875556303865	16.3687321799142	17.436372112913
1	807	18.064265138813496	17.6409854888916	18.076316091291506	17.429797775765945	1159718000	81.25300597795997	16.5046249798366	17.703009982010713
1	808	17.61567897748398	17.641286849975586	17.750646431104915	17.413227797052578	825487600	80.61211462138081	16.633331094469344	17.908535498989092
1	809	18.026900416899746	18.109146118164062	18.12933024747978	17.746119790413193	901236000	81.71275453161171	16.774689606257848	18.23493613555692
1	810	18.06124960084211	18.25556755065918	18.2838848699231	17.819332811644145	816662000	81.32142750108639	16.91137879235404	18.545079050284134
1	811	18.158563427347154	18.15133285522461	18.366739225126338	18.118496018008543	644042000	78.21651756854101	17.036254405975342	18.766969816275125
1	812	18.009130747401738	18.056129455566406	18.21158350315677	17.94134616026068	623870800	75.72183788880685	17.152801718030656	18.92529817408111
1	813	18.090772589449575	17.95701026916504	18.130238241978045	17.907300505190985	430488800	82.56850083080987	17.288135051727295	18.989890516920596
1	814	18.069683535605442	18.28629493713379	18.291417797584405	17.933211755994392	595742000	86.67997698340317	17.453229359218053	19.051522193679034
1	815	18.26219361133806	18.512245178222656	18.566472841176306	18.25857832654525	607129600	87.52341199612819	17.63353715624128	19.082306635334255
1	816	18.629744873715563	18.606849670410156	18.722234737525213	18.38662291406201	655460400	86.53972740175206	17.796286582946777	19.11998220531902
1	817	18.461028636242883	18.373058319091797	18.574907688800437	18.29382614650958	608238400	79.92944276539367	17.935493196759904	19.027168560926917
1	818	18.340219438652387	18.06245231628418	18.394146226421242	18.01394765086461	731038000	71.31316364643511	18.037816320146835	18.829745502665066
1	819	18.131145103261783	18.63727378845215	18.641490816880793	18.087460807624193	598351600	72.05956816397828	18.146552085876465	18.798277488677307
1	820	18.89846549309605	18.959321975708008	19.046389672317197	18.75415981613258	834559600	69.15342304070519	18.2320681980678	18.97437875907463
1	821	18.809598573572025	18.808393478393555	18.855089709855147	18.588166759109946	572980800	68.49989723253256	18.315454483032227	19.033626820088223
1	822	18.888829776421815	19.090679168701172	19.12020319204282	18.780976186193808	641298000	71.0841641875608	18.41898250579834	19.13638722762124
1	823	18.863227825718653	19.16750717163086	19.276265019462805	18.83822330306707	597536800	67.37223928147432	18.49457972390311	19.29013611851387
1	824	19.278972600633704	18.932817459106445	19.401588218847703	18.85930826248976	889725200	60.80351677025739	18.54295471736363	19.35802827873941
1	825	19.166595098316517	18.865327835083008	19.186779229444895	18.779164361641953	696614800	61.52478262823872	18.59395435878209	19.392657965143982
1	826	18.829181983367498	18.761999130249023	19.019884685531814	18.693611181887096	614336800	61.363821998242365	18.644373621259415	19.383740961094095
1	827	18.80236393593474	18.233572006225586	18.82013948820739	18.181754533697262	859644800	53.911671617922075	18.664128031049454	19.336090594263084
1	828	18.37908308592545	17.477392196655273	18.38571030302977	17.420754348511025	1050786800	39.79168291435949	18.60634926387242	19.51550460666863
1	829	17.44154660963637	18.368242263793945	18.377279673036842	17.229755559559923	1025528000	48.443843867859776	18.596063341413224	19.513029800505727
1	830	18.48935178356142	18.3272705078125	18.686079947197502	18.15765618065243	954531200	46.943318132642226	18.576093401227677	19.50415828563456
1	831	18.082635512167087	17.697616577148438	18.218507133665018	17.60964626669679	834719200	43.203592446619204	18.52784756251744	19.565174071303918
1	832	17.816320462473072	17.26198959350586	17.91393155566181	17.184865116813004	1030985200	42.143282645478436	18.47067165374756	19.690657392356957
1	833	17.190580469800814	17.223417282104492	17.37314825503824	16.769107940983396	966529200	34.48997799670411	18.369681903294154	19.753354729048425
1	834	16.949575959289923	16.87938117980957	17.10261982146446	16.720311842042435	1076149200	27.292569872187315	18.221114703587123	19.76897664736083
1	835	18.54719255292687	18.377277374267578	18.6182915496312	18.256771091055068	905777600	46.3630164296548	18.190320696149552	19.704643450899976
1	836	18.50591691585586	18.307985305786133	18.518571216889825	18.140179459551117	536068400	43.1508973364814	18.134413991655624	19.56078704835095
1	837	18.228753530574014	18.16638946533203	18.26219370838133	18.09107344515602	406722400	41.33772943198832	18.06290558406285	19.360762740388175
1	838	18.009733366134775	17.593381881713867	18.02780979161596	17.56385785789724	506144800	39.05140329126744	17.967231614249094	19.18377964510177
1	839	17.621096145928135	17.53764533996582	17.978397914537627	17.51053151070874	610999200	39.126581210733335	17.87239715031215	18.99036537601047
1	840	17.480702244266006	17.653629302978516	17.69640935828334	17.4391272836027	427389200	40.94147943650906	17.793227876935685	18.790260544233675
1	841	17.789809671154437	17.528308868408203	17.816923505695012	17.482516864796803	390549600	43.82942038161501	17.742851938520158	18.715001308235692
1	842	17.385509179585004	17.029109954833984	17.424070612914157	17.026699764692243	529992400	45.893153385948075	17.710831778390066	18.74800196187873
1	843	16.916134807943386	17.156545639038086	17.2556626956881	16.90800001412444	460118400	37.09403619402076	17.624282019478933	18.626781817007533
1	844	17.159556858251786	17.117380142211914	17.21739980928366	16.832683286596307	497252000	37.1083145376881	17.537861279078893	18.48645798683605
1	845	16.98240407308593	17.147497177124023	17.292106894479446	16.89654310927156	480704000	43.279728860064964	17.498567036220006	18.464081952158306
1	846	17.310196239201623	17.187881469726562	17.34936103516282	17.12521972691559	333200000	48.99792745793276	17.4932735988072	18.465167272959174
1	847	17.021584418252594	17.073101043701172	17.306884741741534	17.002002018791817	399546000	48.008502822902834	17.482536724635533	18.470461494100267
1	848	16.948365384071227	16.81731414794922	17.0971905607403	16.798635984120946	352626400	49.15800243121267	17.478103365216935	18.478170161096074
1	849	16.91462232930257	16.665172576904297	16.96794575354137	16.622392523585685	476336000	13.415731582662616	17.355810165405273	18.299354707041395
1	850	16.691693861830466	16.451583862304688	16.77725401564681	16.299745078673187	560896000	12.636482223240819	17.223210062299454	18.110422926899766
1	851	16.428388279489756	15.97076416015625	16.49436604615493	15.97076416015625	717220000	11.118279279340143	17.066379683358328	18.00984616737138
1	852	16.086442633102646	15.978589057922363	16.37113945214113	15.731551050541691	732292400	14.247357350116118	16.951037338801793	18.00529207497654
1	853	16.102714826710034	16.90950584411621	16.917339766344163	16.089156300808423	631106000	39.976917991914	16.906170231955393	17.904885641418783
1	854	17.15865505868135	16.7796630859375	17.289104599619417	16.647406706714406	694870400	36.11572361499639	16.84374407359532	17.745777019649996
1	855	16.79563239941511	17.189088821411133	17.25657255729416	16.666992885430513	584897600	45.057160501307074	16.819514070238387	17.65834492325585
1	856	17.349059554692076	17.03122329711914	17.36804020877718	16.908004308185202	496230000	50.03419542003581	16.819665023258754	17.658659099117024
1	857	17.00922593588645	16.93993377685547	17.047185624465133	16.82484961610203	328507200	46.45357802428131	16.804192747388566	17.624199405545877
1	858	17.199322377612503	17.2405948638916	17.292714812454097	17.03091480164052	380508800	51.8581928470506	16.812993798937118	17.649950103654046
1	859	17.148108000788426	17.448471069335938	17.473174710539677	17.068573345609035	529429600	54.30799177698484	16.83449193409511	17.72237273097633
1	860	17.49577586139819	17.40509605407715	17.518672673640665	17.216201777659258	491674400	53.10644278027488	16.850007261548722	17.77144672877406
1	861	17.14689789251557	16.9007625579834	17.252040381575206	16.886603903624113	520987600	47.7824283802045	16.83769736971174	17.75086574151219
1	862	16.916130562501777	17.00018310546875	17.096889947749194	16.52448442332992	556995600	52.45173300874048	16.850759438105992	17.767894783599523
1	863	16.909206359226218	16.95620346069336	17.065865509368386	16.820634279946304	388214400	54.01840972272699	16.871547358376638	17.78374201850457
1	864	17.10503184942428	17.21619987487793	17.28820150030237	17.0366439008049	401455600	60.42385093710363	16.926162787846156	17.821445855343804
1	865	17.39184311210707	17.224037170410156	17.392745727099896	17.187282559187057	379766800	69.61521606482482	17.015682288578578	17.732239976721168
1	866	17.22041565533836	17.48311996459961	17.490953887613077	17.142086078836474	347516400	71.8307216329933	17.12314878191267	17.570354617382893
1	867	17.706056008033794	17.207460403442383	17.72955455689471	17.191190815898285	591264800	55.338452137991744	17.144431250435964	17.57592289534303
1	868	17.306585380687228	17.357799530029297	17.37165732489227	17.07280166224135	435380400	60.28294640967047	17.185726710728236	17.575478970154077
1	869	17.308384613886194	17.237285614013672	17.427685807403904	17.183659688108463	293580000	50.95544002268646	17.189169338771276	17.57989972789656
1	870	17.209565237706965	17.21830177307129	17.277652291767282	17.089662323350492	345573200	53.924698354061945	17.202532087053573	17.582645484820397
1	871	17.2023379956815	17.296634674072266	17.311396686497794	17.15865370147273	335255200	57.5240913831061	17.228010722569056	17.579004610963135
1	872	17.201132205168832	17.647607803344727	17.71117535329421	17.18335665296954	440412000	58.406912995037615	17.257083075387136	17.673832338613042
1	873	17.575907551439617	17.69671630859375	17.774743390698895	17.566870143814562	361404400	55.48745010144143	17.27481487819127	17.744415694656364
1	874	17.720817976760646	17.646406173706055	17.75215044779105	17.497579349719597	358943200	55.31784501934357	17.292051315307617	17.798518290945974
1	875	17.637364708081645	17.40328025817871	17.721116388301915	17.396350560428132	326351200	62.51498678502822	17.327945436750138	17.78363802758336
1	876	17.444557709359735	17.536745071411133	17.539456133160556	17.3354990158517	284471600	63.14002707290346	17.36627129146031	17.792520078341987
1	877	17.392138244281355	17.195411682128906	17.467455889736783	17.18336073014093	304382400	55.11333706258124	17.38335759299142	17.754400318503286
1	878	17.21227795370351	17.233367919921875	17.30747884637521	17.091771675871414	276536400	50.40547638632741	17.38458388192313	17.75335332618696
1	879	17.32284410328364	17.307781219482422	17.375264933995826	17.230055001414375	202997200	51.917570582285286	17.390565599714005	17.750733468240195
1	880	17.222521934395633	17.14358901977539	17.292716703939487	17.039954072130328	282836400	41.87222167431905	17.36631338936942	17.74488952686853
1	881	17.41323489993289	17.593996047973633	17.593996047973633	17.300259986877233	421500800	58.538622164620946	17.39392307826451	17.77891963833744
1	882	17.615981678059274	17.85066795349121	17.879287760073943	17.581938138173733	400092000	60.39900165076932	17.429127965654647	17.883739290629027
1	883	17.92175989278596	18.0582332611084	18.076008811946934	17.895249415670953	241712800	66.70739877850245	17.48776708330427	18.03759574859117
1	884	18.092881957439484	18.375471115112305	18.508028352609802	18.065467251781868	484383200	71.000552454824	17.5704220363072	18.272566814472988
1	885	18.289610385541756	18.253156661987305	18.3302811373628	18.123612964587533	418930400	67.08639944505053	17.638745035443986	18.408977425814424
1	886	18.23568247983348	18.494470596313477	18.494771467827377	18.199832110460623	379405600	65.74436819694361	17.699235234941757	18.595217562531534
1	887	18.61738602376889	18.32335090637207	18.674627228312925	18.235982328663155	511957600	61.14442566708073	17.743994849068777	18.700030764138866
1	888	18.26038208261892	18.209468841552734	18.306777425160462	17.99225574596117	469322000	59.79240071994995	17.784213611057826	18.769491703021178
1	889	18.08324135164052	18.042871475219727	18.180549953367418	17.85548323253906	428041600	61.427517918435335	17.82989869798933	18.798257480218396
1	890	18.16488935228908	18.225744247436523	18.292624618678595	18.07601478659745	311427200	62.096713700549465	17.879112924848283	18.85330797160025
1	891	18.230260522120066	18.28418731689453	18.426082829164418	18.22724698013801	301260400	71.22380264011088	17.956882613045828	18.867739537855577
1	892	18.40108201228119	18.28509521484375	18.422472855155007	18.17091364686885	293624800	70.80207157559259	18.032005991254533	18.855065347980123
1	893	18.27454238307104	18.26460075378418	18.327264070799124	18.183257663987163	252700000	69.33734433532058	18.10035024370466	18.816288031711064
1	894	18.41583400616257	18.50741958618164	18.538449565210293	18.25676473795524	436861600	76.71404938422891	18.197766712733678	18.688698739925076
1	895	18.468569755856855	18.205564498901367	18.51104897033175	18.187488066258936	397471200	62.719308684758786	18.24145017351423	18.588792918541927
1	896	17.907297842594442	18.19139289855957	18.253755345644958	17.705750973166026	487975600	57.881333947470125	18.26578766959054	18.53388942322269
1	897	18.298346465284723	18.103729248046875	18.367638625459843	18.031122674284536	565132400	51.11417320995669	18.26903738294329	18.527221300141065
1	898	17.306575714843746	17.32193946838379	17.497577628551902	17.172210044549878	877312800	28.981867497111864	18.193785122462682	18.754835571747552
1	899	17.466247809176338	17.319231033325195	17.485529330837625	17.183058504469802	406632800	30.43428920326768	18.127076148986816	18.85499116446588
1	900	17.32314582941416	17.628931045532227	17.649116789170442	17.22011261953818	403936400	32.37208073713816	18.065251895359584	18.805668494138114
1	901	17.80245649894113	17.92627716064453	18.059135227904054	17.7090624664832	379142400	42.30850228216703	18.036889484950475	18.765035986067993
1	902	18.173317408904776	18.400171279907227	18.428491812669755	18.157953656640863	462327600	53.24184585774047	18.05051108769008	18.79940435694843
1	903	18.555331059302528	18.281177520751953	18.570093073905163	18.16639420916976	384501600	54.117727707465036	18.06753294808524	18.826444293030377
1	904	18.161562016142696	18.310688018798828	18.398054946600553	18.083533362939253	332158400	51.54990064070216	18.073600360325404	18.839288402872587
1	905	18.486644934091142	18.549007415771484	18.617696246212585	18.4242824524108	344920800	54.53432108957996	18.092516081673757	18.892912102695124
1	906	18.596901598314926	18.755369186401367	18.825263091429825	18.535745839236366	302103200	57.522872909431634	18.12610707964216	18.997631008067554
1	907	18.76199381961998	18.70595932006836	18.829176653722183	18.619494967528546	290446800	56.995602486019315	18.157632691519602	19.081118460349035
1	908	18.660165675684837	18.674325942993164	18.795435567024473	18.591176003839177	244706000	52.83530557613012	18.169554574148997	19.11650361728199
1	909	18.693696411010112	18.780834197998047	18.81109093509355	18.692183978117114	221642400	60.46702097311884	18.210645266941615	19.21264993863624
1	910	18.71971396011591	18.810178756713867	18.811993352623194	18.71941179677215	194938800	61.19697329475172	18.25484425680978	19.306548144444303
1	911	18.8613123536671	19.061304092407227	19.061304092407227	18.85707560343904	278832400	66.35959867179787	18.323242459978378	19.454179279327434
1	912	19.1178814062203	19.11243438720703	19.321807715193984	19.067656045202984	340169200	90.76745222260536	18.451134954180038	19.49598078696273
1	913	19.100631585817343	19.086410522460938	19.182322311762846	18.99322305003426	257342400	89.813871821911	18.577362060546875	19.445133167319344
1	914	19.0979108721049	19.253124237060547	19.265831253748672	19.076428193205025	254534000	89.11239983575038	18.693375859941757	19.440892993380384
1	915	19.363863568642067	19.60923957824707	19.611660116535898	19.32785927348074	442761200	89.41208630702725	18.81358746119908	19.570930060132547
1	916	19.66672902474933	20.124805450439453	20.124805450439453	19.663400380222463	613384800	89.61478102461606	18.936775616237096	19.929056681303152
1	917	20.296360802387383	19.849781036376953	20.419200737155883	19.676413560104532	812719600	83.62081088947976	19.048818724496023	20.07584421068606
1	918	19.800156524900185	20.237356185913086	20.24128915695535	19.609240997132893	565322800	85.80034746711219	19.1864378792899	20.300084322141196
1	919	20.153847463783578	20.04855728149414	20.268517635763015	20.00377732382334	420128800	78.38625725546606	19.293548583984375	20.43129152155028
1	920	19.954160416843024	20.066410064697266	20.25581316717442	19.834346989959506	437340400	76.72515620322166	19.38719436100551	20.549671303581945
1	921	20.57379956667613	20.443397521972656	20.60042548539715	20.378648936642517	427008400	81.2444005405665	19.51129708971296	20.730093368643757
1	922	20.422216337604606	20.416770935058594	20.45610386941321	20.291812681322433	267416800	81.39096491318496	19.635757446289062	20.8421833259502
1	923	20.430389680123508	20.37653350830078	20.503608543423933	20.350211364916678	202806800	79.45049142470923	19.749735968453543	20.9088119962913
1	924	20.290903471031783	20.086069107055664	20.318435875050124	20.055208059790782	302699600	71.47788875603463	19.840870993477957	20.87569687277206
1	925	20.188329767839612	20.12751579284668	20.22917511962703	19.885769092913314	338321200	69.3114908141198	19.917028972080775	20.85733172387882
1	926	20.143257473984942	20.42191505432129	20.427058293802254	20.10513480698074	367892000	71.79683695129702	20.01056330544608	20.862458246631356
1	927	20.44007415060053	20.278507232666016	20.46367359490374	20.259445086521204	336375200	69.09667223982166	20.09571307046073	20.769356447293962
1	928	20.367456867322595	20.46125030517578	20.522368090955318	20.29575043808353	391196400	69.25456888899697	20.182007789611816	20.676357922548462
1	929	20.5151055199612	20.587419509887695	20.64914162432052	20.44612340604812	329666400	66.82282967101456	20.251877784729004	20.667788828186325
1	930	20.58772364575418	20.051889419555664	20.67364953699623	20.032525110161664	487998000	48.75453581707259	20.24666949680873	20.67117271328899
1	931	20.123588820615453	19.986831665039062	20.27456542404524	19.863083688402185	503983200	52.521819455499816	20.256458827427455	20.646454212996275
1	932	20.176230166624876	20.265182495117188	20.268511138108906	19.847953254566256	712233200	50.533465069355216	20.258446420942033	20.648306035343694
1	933	20.494526201645087	20.664262771606445	20.74050809304199	20.41586034251806	598360000	60.923141059088586	20.302425384521484	20.727603919634475
1	934	20.87545275455045	20.915390014648438	21.087849302974142	20.812820931494212	600474000	63.910278686844194	20.363066809517996	20.876295985941212
1	935	21.159554665485455	21.172565460205078	21.17316978673577	21.01614183953597	398031200	62.43543102797707	20.415150233677455	21.086983795614085
1	936	21.175589116782795	21.237009048461914	21.249716063345094	21.070903286005	373503200	63.810428512797195	20.47373867034912	21.27648662477196
1	937	21.187092754690205	21.24276351928711	21.299946716347446	21.166216015985537	326874800	64.75614479252228	20.53561224256243	21.433929906812985
1	938	21.153806048314525	21.139888763427734	21.181037907387676	20.986187839740722	336568400	69.17736945102197	20.610885075160436	21.523430901465176
1	939	21.252137874436695	21.181943893432617	21.332618333262918	21.159856889764548	571589200	69.18419357704437	20.686201368059432	21.600944093011677
1	940	20.781660793024123	20.90056610107422	21.03157571644223	20.664872244096504	639766400	58.750004358422736	20.720390728541783	21.62833710644354
1	941	20.8240222942632	20.37865447998047	20.960781116320828	20.362315035670168	518789600	51.60819626941101	20.72754410334996	21.621970912597657
1	942	20.23342024785003	20.125709533691406	20.35293148925179	20.005290186537124	576503200	44.73058656071927	20.70357690538679	21.64546506970575
1	943	20.09878458204108	20.614044189453125	20.639762006906047	19.979575485371736	594090000	50.37541652435138	20.70547866821289	21.646463619231433
1	944	20.536287925544084	20.183805465698242	20.607692200304847	20.1732152050786	535110800	51.916979132251114	20.714901242937362	21.629978749381554
1	945	20.30664234141812	19.950529098510742	20.475774641036782	19.863089165180934	543594800	49.49704750262536	20.712308202471053	21.636433996437468
1	946	20.02374686531294	20.00861930847168	20.16110999360558	19.686089843000275	627992400	46.214414005708505	20.6939822605678	21.66527520842316
1	947	20.116028648840327	20.315414428710938	20.327820899186378	20.048557356684494	424281200	44.70864677424674	20.66906452178955	21.6613145387805
1	948	20.309371066320164	20.174732208251953	20.400139670961366	20.13691330285751	370725600	38.376204382533565	20.61616039276123	21.630568085696453
1	949	20.126316094786176	19.744787216186523	20.15051986271709	19.70515211213569	594006000	28.745231947273595	20.514176232474192	21.573699854429517
1	950	19.572026542573404	19.308496475219727	19.592601119635376	19.246168417337728	637994000	24.152587001136055	20.376425334385463	21.528539184403257
1	951	19.323023292133396	19.238306045532227	19.378694071609452	18.866157072650644	838597200	23.590864245804724	20.233249800545828	21.419287152044376
1	952	19.355989889485393	19.391389846801758	19.514531865567637	19.273088903082428	510356000	27.263974571441196	20.10835702078683	21.250565950864633
1	953	19.560521271687044	19.003808975219727	19.581700166219058	19.003808975219727	546081200	24.012541667501083	19.952775955200195	21.057819649444898
1	954	19.04799137506426	19.05253028869629	19.22408151065619	18.919101740043786	460014800	26.65493112153807	19.820773397173202	20.878613829374746
1	955	19.132409366950604	19.205326080322266	19.21652066859153	18.87523276845927	432502000	33.65368978568854	19.736964225769043	20.79031699030501
1	956	19.2237751401274	19.660066604614258	19.675497938077893	19.091555273810233	549771600	43.85819438245835	19.703704016549246	20.733318895972292
1	957	19.632227143309656	19.50333595275879	19.75083024216549	19.48487975936463	389037600	33.9454134518308	19.624367713928223	20.51338718166777
1	958	19.351459871292725	19.14118003845215	19.426191167698363	19.061303885990046	476624400	34.626936692798594	19.54989446912493	20.411290077070312
1	959	19.09307189589908	18.45134162902832	19.11485512463921	18.44468434081459	744086000	30.518095725316172	19.442809649876185	20.45005689559727
1	960	18.529398503482334	19.183231353759766	19.22407671872626	18.479173150240243	546730800	40.87251116519168	19.383853367396764	20.343958539870137
1	961	19.091556063003985	18.55784034729004	19.179299759797814	18.507616606290703	707145600	31.843379481102616	19.258312361580984	20.150966173818926
1	962	18.802319540073075	18.662837982177734	18.956927044881198	18.475553196692633	558527200	34.26536724491676	19.1503199168614	19.9231650979257
1	963	18.758742679600168	18.442264556884766	18.8192561392609	18.32154303259336	656325600	35.826678339109364	19.05728258405413	19.835438041893855
1	964	18.438940211432804	18.27465057373047	18.57721147918527	17.881322689316907	1018432800	38.05162529885651	18.98343644823347	19.850086612495193
1	965	17.9987090590392	18.012022018432617	18.2129218308301	17.78147142258214	510003200	36.431133559183536	18.89584473201207	19.890026778294384
1	966	18.09976270892455	18.048933029174805	18.244385807969007	17.977226614123957	361298000	34.753710011290124	18.799954959324428	19.845864192224507
1	967	18.029266758197508	17.451679229736328	18.06133807760514	17.38965496555545	599373600	33.17380320353263	18.689088548932755	19.949060689176523
1	968	17.654994711682434	17.688276290893555	17.783582117228956	17.475878187161747	529135600	35.78936869894987	18.59164183480399	19.938554548489535
1	969	17.8580199963253	17.634729385375977	17.87344971557701	17.55122404856489	374917200	33.29461184309561	18.47945635659354	19.867198294564368
1	970	17.441422293574675	16.959978103637695	17.462697926832945	16.89158993664263	793648800	22.564979739980274	18.286592892238072	19.7173716110234
1	971	17.039913411619043	16.344493865966797	17.088545284200823	16.269724796712392	1056146000	20.64072850088833	18.060961314610072	19.65244978972888
1	972	16.425648779440156	16.627466201782227	16.865148822237785	16.2220068500748	929913600	26.287729015366182	17.881410326276505	19.514567865836213
1	973	16.84296189737675	16.498899459838867	16.853600527016134	16.37185110719239	515802000	29.401044957648708	17.741950171334402	19.494542822487666
1	974	16.37975325249162	16.501026153564453	16.7314139866154	16.302247416932925	532949200	16.551162463227044	17.550364085606166	19.20810731788012
1	975	16.580046960837038	16.31804847717285	16.639315827137118	16.296772848476355	477170400	18.603994575795554	17.390378952026367	19.061548599345084
1	976	16.337808723767427	15.975812911987305	16.39768469125379	15.884631392167005	789910800	14.683805653198249	17.19844858986991	18.857247912017453
1	977	15.963047662910304	16.03842544555664	16.10894004072729	15.371879827018287	1266893600	17.037087409112317	17.026745796203613	18.627570489038064
1	978	16.43446143410267	17.19492530822754	17.24872228898108	16.40923486727234	823317600	38.35289102244666	16.949622562953405	18.387176588892586
1	979	17.382759449070758	17.04842185974121	17.38397524573343	16.856027313359082	642754000	39.33843981162193	16.880793980189733	18.18535056169402
1	980	17.149945035996517	17.072439193725586	17.244773956694093	16.917427509183725	373002000	39.164865622187854	16.811044420514786	17.93902963955113
1	981	17.238692033463632	17.370298385620117	17.385496657327767	17.09979090046189	272826400	49.032735160270754	16.805231503077916	17.919753629752904
1	982	17.50403668302107	17.918310165405273	17.932594562327807	17.437473016588992	630579600	52.545655642893934	16.821662494114467	17.997367183876356
1	983	17.918915439179607	17.773935317993164	17.945359426306755	17.63169033389525	533330000	51.51015543526841	16.831605775015696	18.03886287333753
1	984	17.545681145449848	17.718017578125	17.804944653284604	17.393406180542428	520864400	59.4988606558435	16.885751451764786	18.182490367340137
1	985	17.93927596576497	17.913135528564453	18.061763003191317	17.788216898060213	514698800	71.97104082068819	16.99779728480748	18.362379712291144
1	986	17.835030100397248	17.789134979248047	17.883965525780457	17.71010979434221	391319600	67.02916198099486	17.080773626055038	18.48893184653948
1	987	18.04353746859692	17.816795349121094	18.072107891151035	17.795823253251587	364280000	69.90830086628108	17.174909046718053	18.591681745801427
1	988	17.68335920126928	17.502513885498047	17.68335920126928	17.389448026022365	557068400	63.82479694661634	17.246443884713308	18.617026172745536
1	989	17.291582269451535	16.376108169555664	17.301915733024856	16.37549945940172	1044638000	50.63585273617208	17.250591005597794	18.609372905869428
1	990	16.07672344966559	16.632938385009766	16.817429486703613	15.763357870131566	1177212400	57.33383740786485	17.297528539385116	18.503415196046625
1	991	16.82016716677915	16.20772361755371	16.874876409777016	16.108942138125897	787040800	51.74797466843799	17.309621265956334	18.463386397845163
1	992	15.95696498002702	16.103466033935547	16.36759094377544	15.85301680666775	630484400	35.60252182747452	17.23165988922119	18.553998033676578
1	993	16.405896369348476	16.455135345458984	16.703456653739646	16.33295015891035	592345600	42.57578686830354	17.189282281058176	18.5734956011126
1	994	16.649048698923927	16.382492065429688	16.656039938528707	16.29951593677465	487144000	41.470012719604185	17.140000343322754	18.58971197392237
1	995	16.143889772845842	16.09951400756836	16.34114912334023	15.981279814611796	625259600	34.23095438823373	17.04923003060477	18.592915183823823
1	996	15.645422569759754	15.494667053222656	15.748154937118931	15.366708126411929	1009579200	20.34354877482386	16.87611266544887	18.538957639966654
1	997	15.468528780471845	15.769431114196777	15.804992756546234	15.234493632019118	757607200	26.230732121156734	16.73293379374913	18.407915260503085
1	998	15.956967025969362	16.227476119995117	16.257869415343652	15.812594003383937	625685200	33.864111925607574	16.626466546739852	18.219188746914153
1	999	16.153613938854278	15.996779441833496	16.22139337413719	15.972159969304137	449369200	29.413031482583023	16.48958396911621	17.927868849746925
1	1000	16.1089391326417	15.857579231262207	16.11501811664363	15.770955738268144	481689600	29.317289171722678	16.351615701402938	17.612538416439516
1	1001	15.576126653327913	15.784631729125977	15.7949651894535	15.508347204783146	596268400	28.449012764659457	16.20646115711757	17.174727084316558
1	1002	15.815633487249448	15.810161590576172	15.934169605483179	15.765785823369411	175753200	30.881821872223142	16.085578850337438	16.722814868965667
1	1003	15.77460020047696	15.592235565185547	15.78858267413803	15.535094743521165	302436400	38.85768912308746	16.029587950025284	16.694029241059415
1	1004	15.608650677287304	15.654850959777832	15.691019700360153	15.338750256697384	455120400	35.28454827278365	15.95972456250872	16.55273015559449
1	1005	15.509875133272622	15.488597869873047	15.637227054029191	15.44391853854307	354278400	38.26634773505024	15.908358437674385	16.53258693009447
1	1006	15.517162862635614	16.174894332885742	16.27306870863154	15.470660663327306	659492400	50.979432672340295	15.913460459027972	16.54567486169292
1	1007	16.83293052876397	16.687341690063477	16.868795725841576	16.462425755586445	560518000	53.04957656668324	15.93004662649972	16.63183291423752
1	1008	16.65238409676792	16.47670555114746	16.706789775645486	16.443271957214794	352965200	51.19403194334591	15.936776161193848	16.658767652972465
1	1009	16.320789839849482	16.017759323120117	16.371244605932805	15.9821976651285	594333600	49.008108595944776	15.930936540876116	16.648567326749678
1	1010	15.865786756558391	15.92353630065918	16.087664020903127	15.659106142630257	484156400	55.93915019683501	15.961570058550153	16.63418064304922
1	1011	16.084922610459994	15.966384887695312	16.166379351946276	15.84298560220393	458707200	52.914714665042304	15.97563818522862	16.639114179285713
1	1012	15.880979871818964	15.716852188110352	15.957269896807302	15.683113424107232	407604400	41.946246942772305	15.939165047236852	16.59913592597205
1	1013	16.064864774744194	15.9116792678833	16.07003150465421	15.668828353074108	601146000	48.642406856215075	15.933086463383265	16.592338681626092
1	1014	15.835394976260805	15.814119338989258	15.966697814354603	15.775213832456531	350506800	49.297354304824665	15.92998218536377	16.591172430669555
1	1015	15.278567560940694	15.2503023147583	15.425068638509154	15.151824398523678	734207600	42.54450198521422	15.891815798623222	16.644504375533522
1	1016	15.145446278983462	14.769165992736816	15.16641837379519	14.691963686131508	876772400	37.11340985113807	15.817458970206124	16.7810301085803
1	1017	15.03420025386929	15.382213592529297	15.484035364891955	14.969157554937844	690804800	47.63178711548694	15.802457400730678	16.78743497145631
1	1018	15.510476082976036	15.27856731414795	15.523849847378212	15.258812645768959	453678400	45.79591808901066	15.7755799974714	16.797741701121865
1	1019	15.15212665260003	15.197111129760742	15.264585410661997	15.087691051785551	472922800	46.6804237470377	15.754759516034808	16.8133283434064
1	1020	15.335707126908384	15.342089653015137	15.436614994514285	15.094680735380512	461546400	39.1818342415172	15.69527346747262	16.745707629624928
1	1021	15.4648868457975	15.622937202453613	15.652723416041647	15.342094600604366	861509600	35.2881332965309	15.619244575500488	16.500885781514878
1	1022	13.981343738538538	13.692599296569824	14.15550298179229	13.684999348979005	1460852400	23.917937483750904	15.420379843030657	16.654417445380986
1	1023	13.728767342894544	13.369811058044434	13.866756217774757	13.221487099039456	1208026400	24.5440841646202	15.231240681239537	16.82896964607128
1	1024	13.307502551863402	13.672232627868652	13.774965012418768	13.247625782834149	785517600	29.190224620746974	15.070433276040214	16.814487313693064
1	1025	13.93575367423195	13.928762435913086	13.987424233360358	13.741838117397414	571158000	31.88112209056004	14.924888815198626	16.686856503363785
1	1026	13.890160283753527	13.884993553161621	14.0603685892534	13.814175418614438	417155200	33.09208463556635	14.794041769845146	16.5746385425838
1	1027	13.889554922085274	13.844266891479492	13.959460811908523	13.82876669777861	319334400	30.3592263497285	14.646369457244873	16.36968156289985
1	1028	13.954292360875549	13.78742790222168	13.965538075476553	13.627251137585729	539484400	30.59595085629678	14.501605783190046	16.14080019170389
1	1029	13.79624410280825	13.443975448608398	13.857944582330827	13.434249072735643	477117200	31.943870612377268	14.37258243560791	16.041998878383566
1	1030	13.496554781902148	13.915691375732422	13.973440909443868	13.440933298298798	573347600	41.45252933339064	14.31161996296474	15.980984889921643
1	1031	13.874053171912589	13.900800704956055	14.178906548432444	13.755818946924544	593706400	33.144308575213415	14.205804756709508	15.767153121300812
1	1032	14.162183682936993	14.314123153686523	14.368538973639147	13.883066070172713	704580800	39.7488454827199	14.13691588810512	15.574579829705069
1	1033	14.490826479893576	14.52078628540039	14.637874429919261	14.315039974198628	633158400	42.99766779162972	14.08860697065081	15.413867147090624
1	1034	14.567254099943742	14.672113418579102	14.82527741298162	14.467898568978601	517490400	43.07250508674936	14.040751525333949	15.210264398065043
1	1035	14.659272451104105	14.304339408874512	14.74701303810555	14.299447879312615	609053200	36.606578948388076	13.946565968649727	14.708586633937461
1	1036	14.283250263163449	14.277135848999023	14.479824188659503	14.16127055778603	475207600	59.67960531822324	13.988318579537529	14.75444104506449
1	1037	14.201014518430625	14.264297485351562	14.418682781251382	14.18572929819549	355275200	66.50664586713053	14.052210467202324	14.741475221645272
1	1038	14.33338375920313	14.067719459533691	14.373433571581085	14.060382164106601	391745200	57.59491213521537	14.080459526606969	14.73413891639002
1	1039	14.096456380349151	14.062520980834961	14.146287620598011	13.874814220606561	435783600	52.84314536334756	14.090013708387103	14.738027537936777
1	1040	13.992206752519234	13.721956253051758	13.992206752519234	13.720426425424506	476302400	46.922773138376485	14.078368186950684	14.747760706660376
1	1041	13.634826252246281	13.6366605758667	13.731738459009895	13.537609549394366	447182400	46.14639489809032	14.063539164406913	14.763759837558647
1	1042	13.734184826813728	13.781875610351562	13.806026314565585	13.653170087870247	330654800	49.90021184842896	14.063142572130475	14.764042860811115
1	1043	13.874817143256813	13.537003517150879	13.913642448545913	13.529971532715212	372579200	51.733360911589294	14.069787434169225	14.746756963611677
1	1044	13.568184601431378	13.725627899169922	13.804196075436868	13.379865554942072	501499600	46.04095085833432	14.056211471557617	14.753801843532134
1	1045	13.709116085924173	13.591111183166504	13.831708022839521	13.471271956551867	587350400	43.85535146958926	14.034090791429792	14.771418667984017
1	1046	13.575216555431993	13.494202613830566	13.69199859307601	13.494202613830566	322515200	31.395715697208672	13.975525038582939	14.74652082800114
1	1047	13.390261524529226	13.160059928894043	13.395765314216742	13.145080020741279	552448400	20.813134922859078	13.878330298832484	14.694951898892274
1	1048	13.078433451495435	12.841506004333496	13.090662280901375	12.80940573531478	582755600	13.362736830934594	13.74757262638637	14.602040924271165
1	1049	12.885217509368992	13.180536270141602	13.304350259404094	12.862900313116246	638433600	27.246734218882935	13.667300973619733	14.507485692903563
1	1050	13.283564788960888	13.013008117675781	13.306188118617142	12.975404883310825	460250000	25.78176043358215	13.577006135668073	14.406512946628013
1	1051	12.977545632990973	13.163419723510742	13.207137372296181	12.872380168781982	468473600	29.96539275920719	13.498372009822301	14.252516006712922
1	1052	13.139573111989547	13.198269844055176	13.311689347911399	13.10319276284064	391482000	33.18742632728903	13.43626846585955	14.129153556818304
1	1053	13.138045351357563	13.386284828186035	13.421136985575986	12.997110975606072	474236000	37.78708534891163	13.387965883527484	13.979686681570662
1	1054	13.316888781133889	13.097691535949707	13.417162718580432	13.07140037291206	465911600	38.51000362644843	13.343375546591622	13.920585637679318
1	1055	13.098301476686984	13.095243453979492	13.283257155476557	13.00383584089798	405549200	39.721397934926465	13.304702895028251	13.869686960523298
1	1056	13.232204027580568	13.222116470336914	13.28753824240995	13.15944414333927	303875600	39.29865388570353	13.26472009931292	13.759047525310969
1	1057	13.388118239854988	13.563292503356934	13.580718172692544	13.367329235109338	643960800	50.48473760583303	13.266597884041923	13.765558825653526
1	1058	13.495729941227387	13.931983947753906	13.985176895106578	13.488087332677422	606197200	53.56802699550954	13.28133760179792	13.846510141322362
1	1059	14.047539379366702	13.894378662109375	14.092480716586214	13.711254876456621	526775200	55.42551343774239	13.302999564579554	13.938223401379874
1	1060	13.983954932623465	13.82070255279541	13.99037465817086	13.744580150984197	308660800	55.890109103621604	13.326320988791329	14.013623102098986
1	1061	13.763842184601048	13.840575218200684	14.001074901910174	13.760173536435202	383255600	63.8466685191711	13.374929223741804	14.106415520783246
1	1062	13.897128889889439	14.121216773986816	14.127024240626291	13.852189188103802	395105200	76.4467243582618	13.466337135859899	14.22981374797376
1	1063	14.206209315011167	14.17227554321289	14.367015947611044	14.117247452148172	501135600	73.26452430404237	13.53717565536499	14.367528185566124
1	1064	14.229135894241532	14.09768009185791	14.241364720669567	14.079031539726932	294294000	76.60454982875102	13.614652224949428	14.43669550593879
1	1065	13.954605749907303	13.82070255279541	13.964999435775743	13.779431489116106	331237200	65.17922074489758	13.661600998469762	14.446887149348075
1	1066	13.751611647749977	13.532720565795898	13.812754143558807	13.500926435321567	442839600	56.91526470487322	13.685490335736956	14.429313350698958
1	1067	13.509490447000676	13.1123685836792	13.564519365244653	13.076600480712834	389732000	44.832828169435714	13.665924889700753	14.456586057155102
1	1068	13.072313339969984	13.139264106750488	13.394534670835002	13.03562687003088	529519200	50.8701393995575	13.668894359043666	14.45062429531401
1	1069	13.187573024198533	13.206527709960938	13.368250306870657	13.155167442303345	363216000	52.26771867773092	13.676843234470912	14.43536476719387
1	1070	13.260635040642873	13.075983047485352	13.298542765667687	13.00047209354724	358447600	47.026584390887564	13.666405132838658	14.455296205455873
1	1071	12.977543409731283	12.937801361083984	12.991301246057166	12.830189333542865	383695200	36.12694571767608	13.621727194104876	14.50139850359456
1	1072	12.988246105252978	13.029823303222656	13.069260048166154	12.916098470622552	300829200	27.191310755081645	13.55728714806693	14.470586480713665
1	1073	13.034409932799036	13.053363800048828	13.099831714235782	12.924046799831773	306614000	28.584916473529717	13.497214657919747	14.425515359469168
1	1074	13.087602519471835	13.319639205932617	13.36152253030245	13.023708122810579	375928000	38.38088797461944	13.461424418858119	14.374511755091008
1	1075	13.259411546397269	13.278060913085938	13.38995139881363	13.18237157996509	328364400	37.085908281418384	13.421244825635638	14.311686863192863
1	1076	13.272558869502934	13.13957405090332	13.272558869502934	13.117868291391556	238613200	25.889949748037495	13.35112748827253	14.154472484605838
1	1077	13.053971205155651	12.835386276245117	13.081179931148563	12.826214657987382	317520000	20.796035778986266	13.255635397774833	13.948782704567265
1	1078	12.887970146296572	13.030738830566406	13.04204926993651	12.857398898085025	305771200	27.86098497995995	13.179425307682582	13.682248222964724
1	1079	12.848225226328243	12.314143180847168	12.85831441419151	12.170763894533318	945056000	23.562254657819622	13.071813923971993	13.625696468781605
1	1080	12.38109966037711	11.985506057739258	12.405556499824371	11.914885801158473	666299200	23.23078222773104	12.961298601967949	13.7042020591785
1	1081	11.860771614919392	11.939034461975098	12.21631694536228	11.773031020348126	609274400	26.682856679346784	12.877489021846227	13.791913299629558
1	1082	12.003540226469255	12.187885284423828	12.295803446954807	11.961658539210926	429920400	32.6263179691737	12.809533391680036	13.779851942314258
1	1083	12.350526414803777	12.415949821472168	12.48473493097628	12.192166374008925	664238400	36.36365430857536	12.753063542502266	13.715846929819383
1	1084	12.031054876545687	12.395464897155762	12.69475846274978	11.999259930203067	969651200	37.79877880921074	12.70445510319301	13.665722595725804
1	1085	12.57186288205629	12.484734535217285	12.65471113967505	12.442545900675546	384837600	41.73180684233775	12.672093187059675	13.630020262483761
1	1086	12.528452228059631	12.754374504089355	12.802371426279382	12.480760618377456	764097600	45.2792652083763	12.652418272835869	13.589789205666365
1	1087	12.85372828455839	13.149353981018066	13.256353741566269	12.839971265784293	640326400	51.45931651218526	12.659274714333671	13.610579647212667
1	1088	13.301598783930558	13.536386489868164	13.611898253405565	13.208967483169989	691538400	53.17845593241103	12.67475666318621	13.677993981447209
1	1089	13.587748067575859	13.429694175720215	13.602116528986057	13.27989514903018	506909200	52.18193320497814	12.68558761051723	13.719681629073522
1	1090	13.505815553037138	13.620153427124023	13.714005979727155	13.470658907822369	421828400	56.8134077801382	12.719914708818708	13.846680210252789
1	1091	13.797162866032185	13.75650405883789	13.855861233146559	13.731128835715628	361300800	63.711676351389336	12.785708836146764	14.041683023349513
1	1092	13.93167972812507	14.084538459777832	14.130088807491882	13.888880458797276	496641600	65.0906582023392	12.860980238233294	14.294038182623655
1	1093	14.21476919727709	14.02186393737793	14.238614594061122	13.870229744915047	483753200	80.09049287124141	12.982960292271205	14.503556461732057
1	1094	14.03347891272216	14.180221557617188	14.226996408343702	13.934734001139223	472598000	91.14018503131288	13.139725685119629	14.669849406549229
1	1095	14.150064489519272	14.056511878967285	14.24823203130169	14.0198915450369	398487600	88.57533317442238	13.290974072047643	14.725464378482641
1	1096	14.093439247108446	13.939570426940918	14.146985918651529	13.862944171944916	334852000	83.52262461194223	13.416094439370292	14.737216200173009
1	1097	13.894641974210758	13.994040489196777	14.09128602708902	13.894334640839357	316948800	82.3499029159619	13.528815201350621	14.747676914283641
1	1098	13.966655017340575	13.659225463867188	14.008199262871786	13.606601602415068	447118000	72.94887012469275	13.61908381325858	14.648904351318947
1	1099	13.514590585994148	13.197312355041504	13.571213897404146	12.99759163263226	741613600	61.39734258472288	13.66998222896031	14.511518809501858
1	1100	13.024666377836967	13.373640060424805	13.474270352899305	12.891108690728725	603204000	60.20961127670808	13.71421548298427	14.398924617774842
1	1101	13.511200413438287	13.333020210266113	13.543204990149858	13.263779816045327	427904400	53.428658104100975	13.72733449935913	14.37124520670999
1	1102	13.291478892899162	13.630605697631836	13.718926252638893	13.235778410199813	451578400	51.819640536454685	13.734064442770821	14.371313210932593
1	1103	13.483505834336748	13.529973983764648	13.70907702967977	13.361949730920667	456022000	51.94123226738573	13.741227286202568	14.365868190582656
1	1104	13.665070004757025	13.58198070526123	13.797397559833094	13.485658814607222	443038400	49.21919226086044	13.738500663212367	14.365746009566339
1	1105	13.415805435552372	13.606294631958008	13.730005371624472	13.410881526899326	353021200	46.77994030338962	13.727771418435234	14.358817444657623
1	1106	13.56659352432533	13.698920249938965	13.714614794048451	13.551514468646548	276166800	40.805446104701716	13.7002272605896	14.296920758183765
1	1107	13.84509686986899	13.584750175476074	13.882331868231889	13.566594498087527	386145200	39.82740995528781	13.669004849025182	14.238316777121806
1	1108	13.540439320865476	13.692769050598145	13.771242614011106	13.521974662975206	330576400	38.38375069145559	13.634186812809535	14.122709643510579
1	1109	13.714306650826725	13.896795272827148	13.986654940293805	13.679224631993172	353519600	46.33419530908331	13.622778483799525	14.074922078946017
1	1110	13.925109059858903	13.83986759185791	14.06666978566767	13.832789062519224	384302800	47.64679984045795	13.615656852722168	14.049058584408545
1	1111	13.870639097600408	13.870331764221191	13.92080017817315	13.616756252209507	372352400	47.0467437639617	13.606820515223912	14.011052912392959
1	1112	13.947265665817458	13.826940536499023	13.984502310333701	13.767855282184529	292728800	54.65094260781992	13.618800163269043	14.03933455885316
1	1113	13.714311196172044	13.697693824768066	13.870334689087215	13.654610442049286	290589600	67.01565722736058	13.65454169682094	13.998924160560364
1	1114	13.70876807505056	13.493043899536133	13.755851707414124	13.357332398325903	416934000	53.98363833283062	13.663070542471749	13.982495553105851
1	1115	13.432730439936353	13.596138954162598	13.640145153422582	13.317943878279833	404535600	58.42706238530765	13.681864738464355	13.943343731350742
1	1116	13.68599560542497	13.506277084350586	13.81986064723318	13.441960594830782	450153200	45.4069057071226	13.67298412322998	13.94994900716116
1	1117	13.409344320714336	13.466582298278809	13.625375078429316	13.33487101795049	286112400	47.54769689148418	13.668456145695277	13.957310010665253
1	1118	13.525048227649124	13.300091743469238	13.578902228493726	13.278857805147942	265227200	39.982458066781355	13.648321219852992	13.996373966712715
1	1119	13.309632876686273	13.416109085083008	13.452422079681046	13.194230853686143	285832400	43.654898566955985	13.63473653793335	14.00405189357789
1	1120	13.398878100051869	13.234238624572754	13.426266927360263	13.186538676814866	271866000	35.3682750171165	13.601544993264335	14.02549545572516
1	1121	13.277011912530321	13.294244766235352	13.408107656659093	13.243776360191381	259414400	40.529639083111306	13.580794606889997	14.035600988909819
1	1122	13.28070533147458	13.2871675491333	13.383489434316983	13.239161094959545	195025600	35.84603506343099	13.55182307107108	14.027116153522343
1	1123	13.275782991136168	13.017284393310547	13.283784341691932	13.017284393310547	310940000	20.65707653187195	13.489000865391322	13.999101725976466
1	1124	12.903420262753853	12.827716827392578	13.108987651481572	12.776324774773919	357310800	18.977480461065653	13.416704382215228	13.994944035581636
1	1125	12.878495279663575	12.724934577941895	12.924964256239177	12.558756771296313	481118400	16.38371240322661	13.334890297480992	13.958954298711488
1	1126	12.537214732285335	12.387654304504395	12.575989688441396	12.249480003805605	480746000	13.973230590745999	13.232084138052803	13.97067045947977
1	1127	12.48489824513794	12.390422821044922	12.549214734738722	12.273482479070955	314162800	15.065754029317006	13.138707637786865	13.9506264859682
1	1128	12.429504775186123	12.250094413757324	12.456893600011256	12.175929289036567	367724000	15.602112867493943	13.049925531659808	13.960743812020441
1	1129	12.286409566967926	12.11807632446289	12.35226437665293	12.11069128360141	337246000	9.740000987107848	12.944349629538399	13.922591907376312
1	1130	12.043606224015685	12.202706336975098	12.317799423772314	11.966979122217488	578516400	14.391383655433756	12.851237433297294	13.8470760554838
1	1131	12.392271889056698	12.593223571777344	12.687084348870991	12.347033888690893	391053600	29.980198435374717	12.788854667118617	13.726354885182412
1	1132	12.615993522358028	12.87849235534668	12.975122396261932	12.600914466556182	469865200	40.83485747433078	12.758740425109863	13.65151864069691
1	1133	12.951427611705572	12.949581146240234	13.016668569733849	12.84648970053999	240928800	39.65609841708851	12.725417000906807	13.544264667693232
1	1134	12.936965562414755	12.845566749572754	13.026208932810503	12.781865741951275	274024800	41.074169335678796	12.697654724121094	13.467051786917066
1	1135	12.928347764387372	12.772631645202637	12.955735768948507	12.637227467472556	298138400	38.09189353242627	12.660396644047328	13.35192250155175
1	1136	12.728009156485289	12.997279167175293	13.032668517396166	12.628917989770613	352584400	43.98004822774141	12.639690331050328	13.264515619873405
1	1137	12.912655781595669	12.947429656982422	13.072679540305277	12.871111531198604	281405600	48.403463695625824	12.63470070702689	13.247537553942601
1	1138	13.015743825222497	13.149301528930664	13.178844973877203	12.960966997877945	326292400	57.308740682171674	12.657671042851039	13.323489481406163
1	1139	13.160382432165138	13.125300407409668	13.22623806193016	13.029902149705363	279563200	59.43716112324998	12.686268602098737	13.397383540672845
1	1140	13.079139291790193	13.153918266296387	13.277628986032752	13.07267625185073	241917200	71.13764887372645	12.741001742226738	13.47081945570703
1	1141	13.125606174805482	13.23885440826416	13.25454813141706	13.053288334923243	216538000	72.38930863922873	12.801603998456683	13.546761697226657
1	1142	13.22346783204982	13.242238998413086	13.301017738455897	13.177922505442812	198990400	78.22150678695962	12.872471468789238	13.57942170996503
1	1143	13.336718172673622	13.286865234375	13.382570845529125	13.251475868809397	218878800	84.98552693930449	12.955956390925817	13.545431907323557
1	1144	13.328095884533548	13.077290534973145	13.355176551270429	13.058825883734253	268721600	74.35714649963029	13.01842669078282	13.419201053943036
1	1145	13.216080860894335	13.11914348602295	13.225005032395233	13.093293793306216	207796400	68.17691897454287	13.05599239894322	13.375417324254663
1	1146	13.109608085634553	12.893884658813477	13.139150718587892	12.885267817859159	369395600	50.55501376186539	13.057091849190849	13.37398088597942
1	1147	13.507506694033184	13.556129455566406	13.681685801352854	13.39456744949029	591936800	65.3337930169874	13.100416728428431	13.507115255744846
1	1148	13.561980875223838	13.494277954101562	13.583522153480637	13.411496795597202	229493600	66.75691082185902	13.146753243037633	13.575591077388376
1	1149	13.395800052359613	13.570902824401855	13.572441134705034	13.366257427514759	200152400	70.58097472988098	13.203772612980433	13.630603552050069
1	1150	13.565056006115052	13.78016471862793	13.847866810565549	13.546592172744338	248057600	70.34571468934254	13.259693009512764	13.76745102580174
1	1151	13.846945550080935	13.950345993041992	14.068209185713886	13.824480626694863	309422400	74.52971460986979	13.331329890659877	13.925029245824948
1	1152	14.001734416565697	13.926030158996582	14.074051433294008	13.83063191453016	322957600	70.80449634747123	13.386810507093157	14.048509301116685
1	1153	14.025121392419313	14.053739547729492	14.05743247801043	13.948493499963272	206250800	73.55917289925209	13.453127588544573	14.184371553822707
1	1154	14.094674883653417	14.234079360961914	14.24361984563306	14.053130633607388	274783600	75.4495339622667	13.530281952449254	14.348319558243485
1	1155	14.30024000910064	14.446722984313965	14.48426696086226	14.222075435267817	318855600	76.84307126265281	13.616558279309954	14.548978891217482
1	1156	14.40271747169012	14.317474365234375	14.521811625317843	14.222690775755213	334857600	72.62953718340775	13.693360805511475	14.669091582524022
1	1157	14.27285199928087	14.309165000915527	14.371328520889698	14.210381145914273	298858000	71.84945152110203	13.766382217407227	14.763839086776846
1	1158	14.3689476221387	14.28066349029541	14.376382249488156	14.185872818762444	255777200	77.87722451692038	13.852337428501674	14.800159608313361
1	1159	14.207249807702718	14.0774564743042	14.2636282492354	14.052676032515473	266865200	70.65598302896751	13.920788356236049	14.77423389578148
1	1160	14.15211361438982	14.477371215820312	14.517330282109334	14.144988347415124	364434000	81.7414127974552	14.033894538879395	14.70030890413809
1	1161	14.588268726571211	15.165369033813477	15.323041415865498	14.498743807836737	881941200	81.92799762651163	14.1488402230399	14.991975627582647
1	1162	15.422786507013592	15.441991806030273	15.62010858817602	15.284010065174217	756372400	85.60878158598027	14.287962641034808	15.293052740449411
1	1163	15.3775562441777	15.423710823059082	15.56279824787263	15.150184683660187	490294000	84.61206819760916	14.420306069510323	15.503564976030077
1	1164	15.493098519000753	15.560628890991211	15.579524822124847	15.45313946449175	362306000	84.18459496713653	14.547482081821986	15.721277358805994
1	1165	15.622894870170942	15.728217124938965	15.91407788386745	15.612363306432357	510518400	84.16883158301053	14.674472876957484	15.950238150727321
1	1166	15.789241425886544	15.521599769592285	15.815881350174974	15.513855778684123	358688400	78.65709988935059	14.788442134857178	16.061262980963587
1	1167	15.599662816522999	15.561561584472656	15.709939835638274	15.525627545075082	335879600	77.96248479017517	14.89614370891026	16.1562740966098
1	1168	15.642718841266975	15.580144882202148	15.661614774019684	15.43269473421439	244207600	76.55595133181261	14.992291246141706	16.240166418638275
1	1169	15.58974857367508	15.520051002502441	15.592226783065458	15.468319622237347	222731600	72.53143685842022	15.068957533155169	16.30426789691638
1	1170	15.511690095960152	15.580459594726562	15.804423268942879	15.503946103472346	330965600	77.30182133636134	15.159170763833183	16.341403649601457
1	1171	15.426504110072425	15.135011672973633	15.566211966123888	15.064074975562999	424188800	65.01460779163133	15.218159811837333	16.295449915372735
1	1172	15.0547824828841	15.206568717956543	15.358356607374873	15.0547824828841	307608000	66.57427646453493	15.284295899527413	16.21774272048282
1	1173	15.229798616675529	15.23134708404541	15.380036347154512	15.213690254730523	239657600	72.06485115906202	15.366716657366071	15.995032424333186
1	1174	15.240639184949654	15.092570304870605	15.270066681668714	15.070266419624014	272297200	63.06913839470041	15.410659449441093	15.818363953047005
1	1175	15.274714400337302	15.134698867797852	15.507040758187426	15.096597636275241	331928800	49.102037169406714	15.40846872329712	15.822136851905006
1	1176	15.474825966133848	15.447875022888184	15.557844334187005	15.373221025901877	345032800	50.168639549842574	15.408888953072685	15.822715702069809
1	1177	15.496203163078514	15.341937065124512	15.50952395601705	15.29144477485165	236367600	47.76815182377182	15.403047970363072	15.818279548926059
1	1178	15.440129271882293	15.433313369750977	15.469245747006372	15.17713471032406	359525600	46.43659813902339	15.393954004560198	15.799789345298462
1	1179	15.643341096750287	15.679584503173828	15.733794104309785	15.596256762706998	340687200	48.69625686769289	15.390480245862689	15.784655748525983
1	1180	15.680509252538565	15.322416305541992	15.719230856547702	15.16319550505257	743195600	45.05911536781923	15.376252855573382	15.764373801041604
1	1181	14.466530280432302	14.488215446472168	14.6734558654389	14.398381155482175	898696400	30.90066891822866	15.299585274287633	15.897415539544419
1	1182	14.512680863361105	14.642474174499512	14.726420615652467	14.43554701595838	404051200	34.08343086738121	15.232608795166016	15.900978282104637
1	1183	14.538698476868554	14.401161193847656	14.615830659694087	14.394967326043547	298835600	32.10806643025089	15.152688094547816	15.931462751347109
1	1184	14.280355859736838	13.943325996398926	14.299250138610129	13.853493386548775	543706800	26.773148051682355	15.035749980381556	16.00595492339166
1	1185	13.876416990816026	14.10440731048584	14.240396166886748	13.862168112819639	399380800	34.09492237667118	14.962135383061	16.04924815227266
1	1186	14.347883502314216	14.394349098205566	14.446080475124514	14.269821565911995	456862000	38.25676349444822	14.90411969593593	16.02131511206582
1	1187	14.580834298791274	14.630396842956543	14.739745787989285	14.535917157477103	404541200	41.811581999311805	14.861194678715297	15.970381328776027
1	1188	14.806958336678182	14.478913307189941	14.82399478130139	14.435235290978838	699302800	41.66729688626625	14.817362036023821	15.935625110742707
1	1189	15.36765249682308	15.198518753051758	15.392743966479363	14.949463541680052	762106800	50.731930226443374	14.821920599256243	15.946259973160467
1	1190	15.329853888696833	15.15080738067627	15.348129443766714	15.11115768135882	364344400	46.37212056330207	14.800701481955391	15.884639587120486
1	1191	15.153906014743384	14.916312217712402	15.167534513259874	14.913215282871073	316957200	44.96038316896707	14.770299707140241	15.811894052571397
1	1192	15.054784526140288	15.061598777770996	15.134083952619129	14.989732328368332	237221600	45.65418909140373	14.743748664855957	15.73002131530129
1	1193	14.98600535368149	14.954099655151367	15.013575013849719	14.891216345661144	228040400	41.233718343592386	14.691928318568639	15.531754052340172
1	1194	14.783733682402312	14.768245697021484	14.92034128684813	14.695758881442945	260156400	43.01456304143778	14.652344703674316	15.412632456825648
1	1195	14.820900005237238	15.115490913391113	15.152043671086977	14.81873115865026	353883600	59.01346402513124	14.697150094168526	15.489047998609058
1	1196	15.043325472512457	15.165063858032227	15.234452107367785	14.98508917198292	289184000	57.74213282884726	14.734477928706578	15.563662725576277
1	1197	15.1944875211659	14.974552154541016	15.251486356176835	14.891844783625109	322753200	58.624570596096106	14.775434425898961	15.590217198614528
1	1198	14.988487320540623	14.962777137756348	15.011409931225838	14.825549181900499	258868400	67.71042155552271	14.848252364567347	15.510658041887643
1	1199	15.072132343064801	15.108994483947754	15.260780743081174	15.034649822376126	312292400	67.54279673267314	14.9200085912432	15.43699237845452
1	1200	15.176824357271613	14.89803409576416	15.19850951480686	14.885643049842662	290917200	59.0452040990384	14.955986091068812	15.376490702475731
1	1201	15.012644447989906	15.073049545288086	15.110221022055068	14.81563181613151	301725200	58.127337361325466	14.987604141235352	15.36723071693466
1	1202	15.219582015836101	15.167539596557617	15.25241582267125	15.086999411544147	278602800	62.91381040184137	15.036791733333043	15.289844862194832
1	1203	15.085442424855335	15.265727996826172	15.29763369748805	15.028754633769577	267738800	51.64340028132334	15.041592393602643	15.309949311316387
1	1204	15.173423730261591	15.365789413452148	15.413494130903132	15.158554469599592	261898000	55.12552039635388	15.056948253086635	15.372652459859898
1	1205	15.411323580811034	15.447566986083984	15.550411039954632	15.349681006232098	320073600	63.660761711287755	15.094895022256035	15.461404471446317
1	1206	15.512923848825654	15.522836685180664	15.566824069333428	15.464600425940167	251101200	62.30336338350062	15.12784058707101	15.558725010882151
1	1207	15.487830278473673	15.627845764160156	15.636519494785242	15.47853782283356	253593200	67.99585303227911	15.175965309143066	15.669241617472904
1	1208	15.67400900315444	15.76384162902832	15.77530293604024	15.665335268647585	290542000	77.3201612059039	15.247079304286412	15.773126219207423
1	1209	15.85304879723947	16.150117874145508	16.2411895662732	15.84530480830487	398106800	77.79579785470557	15.320981230054583	16.027230181248154
1	1210	16.306557176414913	16.103967666625977	16.369749870254626	15.737200897905858	534063600	75.27061949610307	15.38804578781128	16.200799890601683
1	1211	16.077017226515366	16.261640548706055	16.283635074360635	16.077017226515366	313723200	85.26540838169139	15.479980673108782	16.37796345525159
1	1212	16.262879793513655	16.476930618286133	16.494278087108846	16.18388975022947	384764800	87.32430456461384	15.588134493146624	16.577829195644664
1	1213	16.458652888311732	16.292617797851562	16.517818905421798	16.26628723280504	337792000	78.63877119377382	15.672679015568324	16.687949108300447
1	1214	16.388024133720684	16.414045333862305	16.448740267384466	16.207429163140244	550440800	88.34242094310142	15.780965532575335	16.763176400314844
1	1215	16.611988611264266	16.005149841308594	16.704299439678472	15.93886021435189	635807200	71.08044568869947	15.847544125148229	16.745825346605283
1	1216	16.095911112712173	16.25977897644043	16.34093784753753	16.015680329321167	354163600	73.03372955857462	15.925561223711286	16.75664444883824
1	1217	16.262879019238436	16.191631317138672	16.340011228649345	16.14733455926319	275696400	69.77652010813858	15.991697175162178	16.739812905269094
1	1218	16.232520765037947	16.108922958374023	16.256682481068072	15.979129627811927	274890000	65.99125278275773	16.0447781426566	16.701456458435768
1	1219	16.142069237063055	16.317089080810547	16.319257927958333	16.071132549915873	244627600	67.74570254110614	16.106886863708496	16.679323762514077
1	1220	16.249868033907862	16.276817321777344	16.383378677181703	16.200924222881547	265213200	65.61066745858051	16.160742623465403	16.628841416337224
1	1221	16.33134040705509	16.230701446533203	16.35346333992775	16.145952059986573	223375600	62.79372501526002	16.203803743634904	16.55771989751245
1	1222	16.18895804652086	15.968048095703125	16.301436451780994	15.964621909795431	262620400	54.11255943376876	16.218389919825963	16.504541877660447
1	1223	16.033166468997173	16.21949005126953	16.237249971907477	15.971162331190447	279316800	51.47733448581481	16.223345075334823	16.50679413617852
1	1224	16.201725804235327	16.17243766784668	16.254070381610344	16.027865662522064	227452400	51.45756187877606	16.22823578970773	16.50509825709812
1	1225	16.12944440613373	16.202354431152344	16.324181199038225	16.1085694685799	204276800	48.665345881649756	16.22400106702532	16.500475904128244
1	1226	16.139722691749583	16.221668243408203	16.272144147319434	16.107317873632375	197220800	43.69739034445344	16.205768040248326	16.440978236907046
1	1227	16.289584869322077	16.456279754638672	16.49117557343914	16.260296742541904	282419200	53.94299326705156	16.217458180018834	16.48527124713891
1	1228	16.407057980088258	16.35751724243164	16.48526285676385	16.34193883366027	317920400	48.62307064028121	16.213420459202357	16.46993212560194
1	1229	16.3575140170854	16.15934944152832	16.426060998968683	16.145952545107914	244944000	54.18575006963738	16.22443471636091	16.454279409324148
1	1230	16.171816388055305	16.188018798828125	16.30735287385872	16.13878922886675	208938800	47.77969640566114	16.2193089893886	16.448958872486394
1	1231	16.178043001474073	16.046245574951172	16.215121999709154	16.02537064640209	193916800	45.697691482756674	16.208924293518066	16.456420729409253
1	1232	16.127254158479584	16.237552642822266	16.239734151654933	16.004805119219945	262026800	53.576576681689495	16.21811212812151	16.459081047833784
1	1233	16.187078316430092	16.195802688598633	16.269335018586776	16.156232677122777	223725600	46.28367913953458	16.20944881439209	16.443716969574005
1	1234	16.23382167692673	16.318571090698242	16.384936582627503	16.233199339239455	229311600	51.21780529134201	16.21243122645787	16.45140964594368
1	1235	16.330404817984167	16.619548797607422	16.70492218345576	16.326667465147942	401382800	59.87340300849469	16.240206037248885	16.563753908099667
1	1236	16.710224381769528	17.010896682739258	17.01214302210916	16.619554440612532	363448400	74.85505276470315	16.31469522203718	16.805356836648826
1	1237	17.120574985796676	17.325904846191406	17.39632053323159	17.06854155871662	318127600	75.59454999514652	16.393724850245885	17.118765962019708
1	1238	17.386037873383646	17.175100326538086	17.5832656860876	17.162325762998204	472544800	72.13208757786674	16.465343611580984	17.2877687599041
1	1239	17.395384160846923	17.6452693939209	17.64713973507848	17.376066731577918	450968000	76.66700742020198	16.568408966064453	17.587094719015425
1	1240	17.619719645760313	17.604141235351562	17.734692374747947	17.473901264802265	377809600	75.34559279147219	16.66715703691755	17.80240866196282
1	1241	17.842494104057756	17.694494247436523	17.920076633291508	17.648070195808767	447580000	73.96865670429447	16.755600929260254	18.0070650350405
1	1242	17.628749543150963	17.4489688873291	17.658661678998037	17.43494965365578	344352400	69.99178996279281	16.833561761038645	18.113853296547234
1	1243	17.47638666472739	17.64868927001953	17.746835544323385	17.47638666472739	320493600	77.26428066137379	16.939943177359446	18.226400253140543
1	1244	17.559892920005343	17.621273040771484	17.693871877459372	17.485736575441045	278269600	76.24960526279018	17.042318480355398	18.298778544295324
1	1245	17.66645507540748	17.490724563598633	17.79015216988355	17.438692810270247	359718800	76.56440400800591	17.145495550973074	18.281022310728
1	1246	17.51502537519348	17.465171813964844	17.614729169642665	17.44928223932625	262290000	74.04201879056646	17.233182634626115	18.250086618535256
1	1247	17.537149844081167	17.27480125427246	17.538085014525805	17.251122472373464	332822000	69.9689508522631	17.310253960745676	18.133609136435062
1	1248	17.29318698149016	17.37045669555664	17.53060881094833	17.292875812644212	282592800	69.66451750010162	17.38538864680699	17.978782025779385
1	1249	17.31780453237469	17.292255401611328	17.430906943341597	17.242090646816283	229902400	63.71861993854292	17.433439118521555	17.838869673807267
1	1250	17.127430172434558	17.160768508911133	17.181956282225645	16.787810117620687	565863200	53.4187022714774	17.444144248962402	17.80721577958267
1	1251	17.121192512246463	16.964157104492188	17.13677091990335	16.9414118305911	320308800	41.27706428094421	17.418305124555314	17.8604947465032
1	1252	16.994383271293138	17.106239318847656	17.186938545848914	16.975377011714023	436413600	48.33251890655584	17.413386481148855	17.868570532270958
1	1253	17.69761454518996	17.76273536682129	17.782363965568273	17.53434906581908	501306400	52.60902351196781	17.421776907784597	17.899162435051892
1	1254	17.756503404560366	17.687334060668945	17.818507544573887	17.636234142906204	167554800	51.82007629657016	17.427719252450125	17.91681089193051
1	1255	17.700720790872687	17.56985855102539	17.74434264682423	17.553656147386246	204008000	47.30522525256941	17.418816702706472	17.89124403863919
1	1256	17.567369928629695	17.45115089416504	17.585752181306855	17.43276864148788	225884400	50.049914917753824	17.41897256033761	17.891444184478942
1	1257	17.369210159990995	17.277605056762695	17.451154053988883	17.209058061751037	253629600	41.408304165154156	17.39246654510498	17.850849893678795
1	1258	17.266706610586326	17.48013687133789	17.488237247201067	17.261408418978203	223084400	46.97738142116503	17.382385390145437	17.825029739259957
1	1259	17.3137515979504	17.234298706054688	17.35581430636415	17.199714034337326	234684800	44.76672715793047	17.36406925746373	17.808619548407968
1	1260	17.225886445138958	16.855731964111328	17.252057908481415	16.838594381394902	392467600	39.128680343285495	17.32053783961705	17.83612157748671
1	1261	16.74574509824879	16.947647094726562	17.037069037189326	16.62578700762298	412610800	43.95170475582621	17.29716968536377	17.849993792451674
1	1262	16.959793852364868	16.826438903808594	17.010892088726607	16.76038459904711	317209200	40.036553108900605	17.25831127166748	17.862991458697756
1	1263	16.78811760442404	16.933002471923828	16.99843279091957	16.784380250428352	258529600	43.488091649080495	17.232650348118373	17.86114764440462
1	1264	17.037067238410643	16.716766357421875	17.038937579368163	16.680311348794312	279148800	42.19180287727796	17.200935908726283	17.887211650774606
1	1265	16.81989925477168	16.605222702026367	16.850122569095255	16.54820392271614	304976000	43.493113976397694	17.175297737121582	17.923685621248286
1	1266	16.510821365309617	16.69215965270996	16.9030972634196	16.509886194424762	378492800	42.34027434263403	17.145720618111746	17.93734610095057
1	1267	16.76973075373883	17.024290084838867	17.034883134268746	16.752282007851033	332561600	34.477319673603446	17.092974526541575	17.801552411806725
1	1268	17.246451235342395	17.36609649658203	17.45458493504273	17.188497281927276	391638800	43.9274704433764	17.07002898624965	17.71351227120926
1	1269	17.289450065510714	17.269197463989258	17.35020787007508	17.18912056455478	229278000	44.27187768222408	17.048553194318497	17.63797571544263
1	1270	17.182891260919526	16.8460750579834	17.201273521909854	16.822083436823032	426739600	39.67039994581775	17.005333491734095	17.554983098278903
1	1271	16.856042072246574	17.107797622680664	17.138954441652395	16.83828215295127	328526800	47.18584285631197	16.993204389299667	17.52414846100698
1	1272	17.16512754207777	17.183822631835938	17.363912839157468	17.068538741000538	379985200	44.87436834443886	16.972039086478098	17.439154857131623
1	1273	17.1349045914107	17.329328536987305	17.339299251735508	16.975065314613584	403239200	51.70293240838659	16.978826931544713	17.464742818850848
1	1274	17.26140389130411	17.014324188232422	17.311879802763023	16.973194989856676	429354800	52.90822044106681	16.99015494755336	17.471077925543003
1	1275	17.13896019726505	17.15235710144043	17.286336127224168	17.004358833615008	554878800	53.69147830417696	17.004777090890066	17.49253232019702
1	1276	15.851824929729661	15.78140926361084	16.04624884553156	15.64337845045721	1065523200	37.01012334890121	16.930132116590226	17.745373450050767
1	1277	15.701957481667067	15.602252006530762	15.808516990617129	15.535886522045686	502810000	33.75180164476281	16.835078511919296	17.91592926264825
1	1278	15.658027736404026	15.57203197479248	15.781413683066102	15.476067161172134	678501600	35.35791317806233	16.753311770302908	18.028454261400004
1	1279	15.428703239303713	15.597578048706055	15.626555020445611	15.377916162557245	464797200	36.821480724991176	16.681337152208602	18.098346726569595
1	1280	15.660214249500608	15.62656307220459	15.819742428671312	15.557082534796926	401464000	35.84904656764097	16.605223110743932	18.130099076037034
1	1281	15.761153079716227	15.85275650024414	15.873633094502873	15.664875471935582	376681200	33.99180487662487	16.521542140415736	18.075653868898687
1	1282	15.783279815103528	15.971160888671875	16.054975126638414	15.773620269522004	328344800	29.699788656276937	16.42190388270787	17.92064839504957
1	1283	15.987463517373982	16.06425666809082	16.095288633823547	15.916937692134718	257765200	32.445311800957796	16.33583668300084	17.76159568251585
1	1284	16.34227949038559	16.28899383544922	16.39086297754374	16.216902857330037	370280400	41.38599301845191	16.29604516710554	17.691228893855325
1	1285	16.257029449488382	16.5808162689209	16.674849619288235	16.23634258111797	345559200	41.9265715118926	16.258403641836985	17.58604625493416
1	1286	16.631591149588747	16.799283981323242	16.855388605622366	16.596797778779063	282256800	44.35518101812757	16.23093659537179	17.490259068275762
1	1287	16.830314717408527	16.79802894592285	16.912123082539264	16.7140276860627	308100800	41.85590345693002	16.192986624581472	17.336411791842472
1	1288	16.75853826337079	17.064773559570312	17.07793762630975	16.744120396276845	307398000	50.78493308334179	16.196590151105607	17.351426654827026
1	1289	17.003334974039188	17.05097770690918	17.113354684349694	16.963842779321194	272924400	48.359223594680806	16.189348765781947	17.319373597839178
1	1290	17.113975751188764	17.113662719726562	17.276651673631523	17.1017507845125	260251600	87.39953170570814	16.28450972693307	17.488512093670924
1	1291	17.07479169004451	16.84347152709961	17.14186913039248	16.748812170038466	313768000	83.14968531673361	16.37316826411656	17.543071417516384
1	1292	16.70618500009872	16.64851188659668	16.831876330328726	16.58112140671495	305858000	76.42468233616299	16.45005968638829	17.531285656791432
1	1293	16.699916481766888	16.463581085205078	16.755709734264745	16.443207257537768	278784800	69.71533083161887	16.51191704613822	17.475771554989734
1	1294	16.397756397482265	16.535669326782227	16.60995653200239	16.374874974070792	288909600	70.29824742957331	16.57685320717948	17.39529056680186
1	1295	16.593030529851372	16.363590240478516	16.59898482207471	16.33036539031018	231952000	61.688184731833	16.613341331481934	17.33220897731718
1	1296	16.41217500354536	16.215959548950195	16.455743284639652	16.16110707133473	276217200	55.52721857458956	16.630826950073242	17.29200093013235
1	1297	16.209378773553656	16.5394344329834	16.574226119475195	16.175213149934642	301882000	59.71788374582232	16.66476821899414	17.244413581435513
1	1298	16.583630085982765	16.494613647460938	16.698664963001406	16.365473941080264	371968800	54.53917694891048	16.67945534842355	17.227652295414217
1	1299	16.406222532858916	16.54225730895996	16.632842257879325	16.387102503170535	238781200	49.0459326602886	16.676701136997767	17.22741454445327
1	1300	16.64381173067173	16.65133285522461	16.695215846578666	16.54256865609287	259140000	46.129720160740675	16.666133199419296	17.212373649002693
1	1301	16.641300591920082	16.68643569946289	16.761347289332274	16.58519264641625	200062800	47.13160766656502	16.65816225324358	17.19934521484776
1	1302	16.69991699999624	16.635974884033203	16.75163582335856	16.55291273957313	185488800	37.59936985775465	16.627533776419504	17.115506921298017
1	1303	16.646630768293516	16.626256942749023	16.674527391635802	16.488655362469434	220729600	37.6882621715226	16.597196578979492	17.020260439681767
1	1304	16.561058710139278	16.641300201416016	16.716839526238257	16.56043097342855	178584000	35.918284725238976	16.56345639910017	16.867766517687627
1	1305	16.78328751860302	16.803346633911133	16.8864087470371	16.69364170352372	279224400	48.72138353388514	16.56059033530099	16.854104302594447
1	1306	16.75383247784065	16.81965446472168	16.842848926974	16.67515778590958	199326400	56.15433577235103	16.572814805167063	16.894961859939016
1	1307	16.845669021878013	16.632841110229492	16.9152523995043	16.58613748638968	257742800	56.078408809141216	16.58490480695452	16.90205832650807
1	1308	16.574536110223438	16.446025848388672	16.64035974596483	16.393053238830756	237199200	47.02582775505968	16.57850170135498	16.90346081812223
1	1309	16.540371795987017	16.51028060913086	16.611521985469334	16.482383989807435	199544800	55.24190690142151	16.58897958483015	16.892864718200546
1	1310	16.48395400172625	16.656347274780273	16.674213501932826	16.462013344058445	209647200	65.75464539936243	16.620435850960867	16.836460473060676
1	1311	16.683301544458693	16.65195655822754	16.808050404747306	16.581117726327406	224756000	55.21631333602134	16.628473145621165	16.83983832228452
1	1312	16.60901941281228	16.571720123291016	16.69615766413754	16.529405634442682	208398400	53.460869386553064	16.633980751037598	16.83403642901539
1	1313	16.672969159899672	16.70243263244629	16.730016241367554	16.497442125025476	374046400	56.690450544617875	16.645421845572336	16.8411550082591
1	1314	16.876385098850395	16.90052032470703	16.94158100961738	16.77106759747918	355700800	59.68804503873853	16.663220950535365	16.90188212701582
1	1315	16.97292708734086	17.082317352294922	17.106139548239117	16.91305772904249	282293200	63.81544089651665	16.69149821145194	17.01920618716657
1	1316	17.130273128507625	16.91901206970215	17.208007033833525	16.890176351349456	299768000	59.15625227528794	16.711715153285436	17.05900499050481
1	1317	16.926533996254253	16.84629249572754	16.972924581507133	16.772947729991063	222031600	56.839363124994065	16.727431978498185	17.07796254158593
1	1318	16.873243150529657	16.82748031616211	16.892676201380958	16.745672009834784	200564000	55.77350758980959	16.74073055812291	17.091311614987948
1	1319	16.90177359085511	16.823726654052734	16.951297840711376	16.798335955326362	168669200	50.70079084098836	16.742186273847306	17.09405421810291
1	1320	16.855693082057417	16.977622985839844	16.984519719781602	16.82466280121316	200760000	54.96237817394837	16.753469739641464	17.12558742387366
1	1321	17.00050253619756	17.005830764770508	17.034981180218	16.934052846775046	180420800	63.013786145708835	16.780111857822963	17.168096866176555
1	1322	16.96947480078699	16.88797950744629	17.004266481355415	16.85193402738086	162344000	66.1995561937814	16.811679976327078	17.151499165558082
1	1323	16.919944007472072	16.66950225830078	16.925898297304318	16.630636162904356	275251200	55.24336900182656	16.823052951267787	17.12832086163864
1	1324	16.550404112238812	16.407787322998047	16.640676018448968	16.3582647448216	289850400	42.39395237589402	16.80529866899763	17.174540874888482
1	1325	16.461703305945413	16.406850814819336	16.490853735647242	16.25827803497635	243888400	42.4837633472772	16.787791115897043	17.208069433656963
1	1326	16.38177114205482	16.622495651245117	16.627823881228448	16.362338084600694	206169600	51.43765344024782	16.791417939322336	17.204478494445873
1	1327	16.633779290198397	16.40810203552246	16.682677479481114	16.398384669160947	239652000	42.04338975500195	16.770394325256348	17.23027277961147
1	1328	16.267676777491754	16.28679847717285	16.387726835648945	16.209377606101263	271717600	32.6907414480373	16.72655705043248	17.24613229168248
1	1329	16.35857581629225	16.351680755615234	16.366724676543704	16.21157158261067	205674000	27.938371375125556	16.674368722098215	17.18673909391445
1	1330	16.30748639630206	16.23508071899414	16.350426943634165	16.027268021816667	266490000	28.749254753870233	16.625516482761928	17.166999644609383
1	1331	16.237902731597046	16.267993927001953	16.333189843080888	16.11534672975128	214765600	31.57565953785256	16.584209442138672	17.14115318321118
1	1332	16.299017395237634	16.453857421875	16.5422494344001	16.273941409561814	284334400	39.241690960177685	16.557522092546737	17.099866150554423
1	1333	16.46640291226532	16.649141311645508	16.679543865665046	16.423147654261527	182548800	45.47229897577292	16.54505171094622	17.068736163200782
1	1334	16.55949224197303	16.66575050354004	16.669824933784916	16.50275990202679	202563200	41.29179523940893	16.522775105067662	16.990766031436223
1	1335	16.58300623420016	16.447912216186523	16.647889127502864	16.438507879381195	394940000	35.913369946082554	16.482923780168807	16.859886658037013
1	1336	17.810130831606518	17.79633903503418	17.866237112188504	17.57567531177142	759911600	64.14498969366116	16.547806603567942	17.32515532155276
1	1337	17.69478319289437	17.927045822143555	17.928610979320837	17.676918639529706	390275200	70.13282537759258	16.637631143842423	17.710142727079134
1	1338	17.9539976498152	18.62131690979004	18.673348748960127	17.946160147933327	669485600	81.1267264135711	16.795740400041854	18.2914383417888
1	1339	18.610350502528267	18.56615447998047	18.68056161432746	18.477764108849822	337377600	79.90808542834907	16.94997637612479	18.697123825194442
1	1340	18.57586579971421	18.49593734741211	18.788693633878765	18.486847720705224	456640800	77.03791220013863	17.08379364013672	19.001545251235054
1	1341	18.555808447372602	18.53951072692871	18.643572743300364	18.37902772991189	244048000	82.35631697997825	17.23603711809431	19.2582838926712
1	1342	18.566461117527975	18.57398223876953	18.624761943390634	18.484025075537836	191514400	85.6612484290402	17.399407386779785	19.460490140243767
1	1343	18.497512926693254	18.83665657043457	18.8379120442168	18.49312379035058	287067200	86.4942630155681	17.57690565926688	19.67694793627714
1	1344	18.86298468920566	18.631351470947266	18.944793027545998	18.631351470947266	374564400	84.29793219124828	17.74806785583496	19.766009527703382
1	1345	18.657680187458062	18.56615447998047	18.721622300528313	18.421970857144718	282864400	82.59247036674367	17.912222181047714	19.77981477506115
1	1346	18.541260174037674	18.533065795898438	18.735420476439504	18.482950137319687	230297200	80.82294501258814	18.06073706490653	19.751026748687448
1	1347	18.42431718465347	18.45583724975586	18.478215233492637	18.291619814715613	291597600	77.75458455249154	18.189786774771555	19.679841543809214
1	1348	18.517296907293865	18.685609817504883	18.711770204523347	18.51445883944024	213208800	79.12194284884578	18.33406244005476	19.555359711906277
1	1349	18.65944832790902	18.714921951293945	18.73950675692395	18.618474774068556	159737200	84.56431892443325	18.495991706848145	19.069238575761762
1	1350	18.67300421001126	18.71839141845703	18.829655139253997	18.651255786871424	166404000	73.83241521224915	18.561852591378347	18.979615680785027
1	1351	18.74455397316605	18.559219360351562	18.804439570803567	18.53463455167448	230846000	66.10292352883447	18.607007844107493	18.811338526379267
1	1352	18.553227266138503	18.833120346069336	18.83374990560561	18.451420419202904	276256400	56.865387801735544	18.622136660984584	18.859693856600348
1	1353	18.84383911080531	19.0562801361084	19.14264258740293	18.827448677353306	317755200	64.32661289872962	18.657145636422293	18.986058238425887
1	1354	19.053758395625888	19.060062408447266	19.113329212644775	18.934615078273616	234836000	67.15596308988776	18.69744028363909	19.075784435731165
1	1355	19.032326530671803	19.11049461364746	19.12278617731196	18.97653811613212	196859600	67.29241134866483	18.738224846976145	19.163432044536616
1	1356	19.11963560925982	19.1407527923584	19.222073726235827	19.040837964140046	200760000	67.20872670329047	18.778708457946777	19.242708446888436
1	1357	19.140116887118815	19.356969833374023	19.375881867926147	19.11553208385813	232209600	66.25678175386405	18.81587369101388	19.373727445638377
1	1358	19.412133760002018	19.71944808959961	19.726696442258923	19.404254164368428	348866000	80.95634998155022	18.893594878060476	19.618796753570653
1	1359	19.731741601168068	19.66838836669922	19.851830959767344	19.66113833000942	315481600	81.61285240391769	18.97232586996896	19.779131630468015
1	1360	19.789417599024173	20.026758193969727	20.07372266529502	19.786895994076314	376474000	86.10371684451324	19.079018184116908	20.019566813533523
1	1361	20.10870594331538	19.951740264892578	20.30381047057167	19.82251055381892	564020800	86.19582975659735	19.185868399483816	20.160706436990754
1	1362	19.98200291143244	19.814634323120117	20.009424103688218	19.620790565268265	369350800	78.60120640970385	19.26651300702776	20.24984221830225
1	1363	19.808649318951694	20.094844818115234	20.132668901695332	19.802030525153878	292709200	81.01460197590944	19.365078926086426	20.386150855831623
1	1364	20.091692373088662	20.324304580688477	20.421069925864764	20.04977110395288	335482000	82.7653866300134	19.479787009102957	20.54765455089776
1	1365	20.36780400714149	20.404050827026367	20.467720530055463	20.25464989580163	303805600	88.90082054969832	19.611560685294016	20.644826920557318
1	1366	20.48442021408264	20.34794044494629	20.52728749991636	20.313270900493634	349938400	85.17262087181113	19.719762120928085	20.71856250851725
1	1367	20.45290467470882	20.673540115356445	20.71325456200561	20.243301679419506	301660000	85.8459441589429	19.835280690874374	20.87670985014
1	1368	20.90079903213566	20.794893264770508	20.97140231594074	20.64486107627033	251108000	86.54708664328106	19.959197180611746	21.016011917496556
1	1369	20.768414061350903	20.708843231201172	20.907415470558398	20.62279554136552	182724000	83.17402054901352	20.07336493900844	21.079343954924312
1	1370	20.748553980796565	20.362442016601562	20.766205217440977	20.276394342103274	218996000	72.41483812402058	20.160628455025808	21.019280534656804
1	1371	20.34258108188972	20.139596939086914	20.39553478434515	20.0513424516422	218100000	64.32434470422146	20.216530391148158	20.94125756614126
1	1372	20.1903473181373	20.34258460998535	20.463934761682367	20.17710804857013	142244000	62.11235805091815	20.261040142604283	20.928540417220667
1	1373	20.366853904624715	20.31610870361328	20.45290157878721	20.254331058913497	118904000	62.71169818213942	20.307305880955287	20.881062238597412
1	1374	20.358031201451116	20.33817481994629	20.362444852884284	20.15504700171045	134056000	57.04107032272866	20.329549925667898	20.880131963056016
1	1375	20.36243996416593	20.267566680908203	20.36464678935269	20.15283533759846	142112000	57.15504263192736	20.3521089553833	20.860253068802663
1	1376	20.265358522019714	20.05796241760254	20.4198042919547	20.055755592561017	403592000	55.337270442230256	20.369489533560618	20.81067602906564
1	1377	20.148422677384684	20.040311813354492	20.21461396419504	19.989564935691305	174776000	48.64813748325007	20.36559431893485	20.818045348636
1	1378	20.022659462629655	19.918960571289062	20.24108800362126	19.89910419634176	156144000	39.38250596780334	20.33664117540632	20.84845684690457
1	1379	19.903515535021562	19.93661117553711	20.011626389612434	19.779960272631993	147476000	37.34429077358605	20.303252628871373	20.855514404670664
1	1380	19.938822930071304	20.05575942993164	20.08885507862966	19.81306081167052	130516000	42.35044907473526	20.282382556370326	20.849259430243112
1	1381	20.03810662690099	20.294044494628906	20.298456461897032	20.02707418375895	256116000	39.588468063417906	20.25527572631836	20.775994271137026
1	1382	20.320522853601243	20.503650665283203	20.680159683367098	20.31831602796364	197929200	42.378762454168765	20.234472683497838	20.680195829620587
1	1383	20.63382339477539	20.63382339477539	20.75517354708423	20.54777571707081	152892000	48.0811898847309	20.22911412375314	20.651461492819106
1	1384	20.711047679959808	20.625	20.75296726550774	20.538950636725513	113860000	58.117294361011325	20.247868265424454	20.716500145193912
1	1385	20.6669204447878	20.746349334716797	20.761793747574394	20.563221522751896	91567200	70.01453369489307	20.291207722255162	20.824475111663702
1	1386	20.77061616769004	21.174379348754883	21.17879131604262	20.761790549800075	225872000	73.8908635114584	20.35062163216727	21.063610619579936
1	1387	21.240576164599652	21.0375919342041	21.357514378831393	20.722083141676535	260888000	69.4876082788011	20.402156148638046	21.20325231625821
1	1388	21.0574439580499	21.046411514282227	21.169966804570198	20.907411812708258	145744000	69.26769076217695	20.452744483947754	21.322907479667435
1	1389	20.686777528204104	20.96919059753418	21.0817151334848	20.633823815218708	158744000	69.01935682679988	20.502860477992467	21.40722766288556
1	1390	21.039784684796853	21.008895874023438	21.156721137483924	20.92946702251638	136072000	78.39284351568898	20.570784296308243	21.474052979938026
1	1391	21.150112691770943	21.28028678894043	21.377366917890395	21.103779452948853	171240000	82.15134232635613	20.659353937421525	21.581529478276032
1	1392	21.35750693063793	21.03096580505371	21.36853769041025	20.966981338442125	181911600	77.03884337152711	20.73878288269043	21.573678133087228
1	1393	21.395015344991574	20.911823272705078	21.423697341451017	20.902997654568047	213585200	72.59734290335982	20.808440889630997	21.506558127961302
1	1394	20.966981262928197	20.53894805908203	21.02214011153458	20.42421839463912	229192000	60.01830209691095	20.84295436314174	21.41764235687655
1	1395	20.655886317049468	20.8346004486084	20.902996882500933	20.523503733198208	199952000	60.947317432689566	20.881565502711705	21.362353863545266
1	1396	20.95816389550188	20.726497650146484	20.96037072164292	20.677957574934364	156316000	54.70658945082001	20.897483144487655	21.337392548374762
1	1397	20.88975684172255	20.898582458496094	20.936090067297947	20.7662015735215	220788000	55.49450984428066	20.91639450618199	21.329420380673792
1	1398	21.053028344667688	21.443553924560547	21.595791197812602	20.997869497600345	371672000	63.89520976308485	20.9748626436506	21.43880749548425
1	1399	21.410457633859988	21.40825080871582	21.472235271381724	21.27366309126588	182916000	61.57410217636225	21.022141320364817	21.519475390557677
1	1400	21.368538493847048	21.54945945739746	21.586967071999666	21.322205261106465	173876000	57.289942881545926	21.048932756696427	21.61697877107662
1	1401	21.58255493315321	21.84731674194336	21.89585679966161	21.522984115335515	221272000	64.81029121078855	21.106770242963517	21.816949812491632
1	1402	21.91571464016069	21.70611000061035	21.939984668775093	21.67742800466356	172572000	61.5088724318396	21.153891563415527	21.931191213260846
1	1403	21.719347545672104	21.655363082885742	21.776711533013493	21.54945735885312	132040000	62.08233473405914	21.20290388379778	22.01575475586456
1	1404	21.436931395582658	21.09273910522461	21.50091416571128	21.03316830143398	227372000	51.24674402352472	21.208892686026438	22.01680667721528
1	1405	20.938301838787822	21.20968246459961	21.31779503313034	20.918443775527507	194044000	48.89957233832183	21.20384952000209	22.010724544593465
1	1406	21.26263121278823	21.090534210205078	21.308964438490285	20.997867758800965	159832000	50.967689560999666	21.208104406084335	22.01167372548513
1	1407	21.039793229854777	20.986841201782227	21.110396495056385	20.819157815685426	223732000	51.224815316995816	21.213462829589844	22.00948656015308
1	1408	20.905202949247897	20.951536178588867	21.06626752265506	20.89637733175708	154232000	57.5708470850935	21.242933409554617	21.957797779147214
1	1409	21.049098942574094	20.94931983947754	21.27526569904705	20.86506027610171	186844000	52.35911073456964	21.251127651759557	21.94823906555249
1	1410	20.900534837314908	21.00696563720703	21.024704667751408	20.683235942363968	167460000	55.88982188662075	21.27116107940674	21.917605500520104
1	1411	21.12448789565654	21.284135818481445	21.304092654678254	21.029142702396523	146340000	57.75436722850451	21.29870060511998	21.90858819238786
1	1412	21.295224373006743	21.27970314025879	21.481479165982208	21.199879174215734	135180000	45.788982973579486	21.28699697766985	21.891172218566954
1	1413	21.319614186928522	21.561302185058594	21.561302185058594	21.295223437726186	127664000	53.491458342942025	21.297929218837194	21.916912940822133
1	1414	21.58125762086905	21.61895179748535	21.63447302854426	21.463739486896277	112464000	51.648114037151096	21.3028929574149	21.93160368937111
1	1415	21.7076485374524	21.725387573242188	21.771951273424705	21.477046147247854	195804000	46.81948806126389	21.2941837310791	21.893078452549233
1	1416	21.83847531323368	21.987037658691406	22.033601369946645	21.725392739480082	190288000	56.89474221312204	21.314249992370605	21.986884200826687
1	1417	22.042464191409078	22.290803909301758	22.32406417628737	22.02250735454273	277596000	63.8725613483393	21.359638622828893	22.197011281906878
1	1418	22.27085413305379	22.299678802490234	22.41497917192387	22.162203788595484	210796000	84.75147236177592	21.445848601205007	22.40457645939637
1	1419	22.29967924612239	22.301897048950195	22.381721033872225	22.197682307985996	133912000	83.67280455090187	21.52386392865862	22.573274329729294
1	1420	22.237586441440634	22.465970993041992	22.499231256952946	22.215413496062432	176736000	91.26151374325254	21.622109413146973	22.751270127993713
1	1421	22.570192289200115	22.514759063720703	22.65445018292122	22.457108035549535	161080000	97.3971109777874	21.731246403285436	22.890857489484468
1	1422	22.488146503360454	22.370628356933594	22.505885538361206	22.363976641730183	132608000	91.23705683409136	21.83261013031006	22.945787821217017
1	1423	22.399452866091337	22.64557647705078	22.74313947719686	22.3284984182635	209476000	92.54717459551989	21.953771318708146	23.021115532597435
1	1424	22.525843287039375	22.67218780517578	22.789705965182947	22.5191915710673	273840000	92.42930846121247	22.072715759277344	23.053153536036405
1	1425	22.80744505371166	22.72762107849121	22.816314572257006	22.66110053524494	178380000	91.46487658095381	22.17582184927804	23.101074379262492
1	1426	22.851793107104193	22.905010223388672	23.002571553201186	22.77640472989962	214256000	92.46796197599627	22.29191521235875	23.137227966997376
1	1427	22.86065938836144	21.938251495361328	22.882832337828674	21.858427523929215	501684000	57.25257287802701	22.318840163094656	23.084131994852132
1	1428	21.91829756202388	21.756433486938477	22.193245893575853	21.683261221478475	342872000	52.52454850229268	22.32866028376988	23.05794657734559
1	1429	21.907202525922266	21.944896697998047	22.038024073133666	21.798552229910268	233828000	53.91292462606794	22.344339506966726	23.025613181203845
1	1430	22.0180625797168	21.809633255004883	22.02027868918512	21.740896644381426	185426800	46.68840902212806	22.331667763846262	23.047302620137554
1	1431	21.969289768258715	21.72760009765625	22.856221111103032	21.31739468992821	759385200	38.53787789977742	22.291438920157297	23.076884194581787
1	1432	21.732036882767247	22.395017623901367	22.41940837249011	21.676603670826896	403478400	51.530147752548615	22.298248835972377	23.085652614706778
1	1433	22.264191637172082	22.490358352661133	22.49257615437107	22.089022519202224	249412400	52.93693473042429	22.311710357666016	23.105798337872642
1	1434	22.441585760893314	22.541366577148438	22.6588847390529	22.41276109398639	250504400	51.217863518195706	22.31709575653076	23.11669386543498
1	1435	22.79635477262766	22.534709930419922	22.849571876989803	22.492581837409226	245266000	50.32671286873889	22.31852081843785	23.119705980111277
1	1436	22.128943018392373	22.36397933959961	22.452672833615374	21.927165277214318	267632400	49.89205692557316	22.31804588862828	23.11910586514786
1	1437	22.454886082927512	22.523624420166016	22.572405920242545	22.304107669821644	243706000	47.9431739806265	22.309335027422225	23.097602742249254
1	1438	22.601229078119516	22.570186614990234	22.694356467507365	22.519187316027917	149197600	48.29116253863242	22.302049228123256	23.077653750760298
1	1439	22.681057415791827	22.386152267456055	22.69436084778999	22.284155341532163	283609600	44.5156515367253	22.2776585987636	23.016204155439887
1	1440	22.57240298705432	22.4083194732666	22.64779133796712	22.30188866119121	211153600	41.60399434869044	22.242180688040598	22.8934732858317
1	1441	22.306327889158766	22.758663177490234	22.82518371965485	22.293024457400904	253608800	67.51905325135303	22.300781522478378	22.981255577686497
1	1442	22.652226809147376	22.561315536499023	22.805221312069673	22.439361802870078	240687200	67.07419114160261	22.358273097446986	22.973511714410265
1	1443	22.28637299387579	21.700998306274414	22.3307188946959	21.667738034815493	400368000	45.97376950489264	22.34085178375244	23.017282775049274
1	1444	21.847335293917354	22.339582443237305	22.339582443237305	21.818510635256064	249482000	57.50171177028367	22.378705297197616	22.9824919193838
1	1445	21.87394406806651	22.197673797607422	22.270846037680386	21.869508464111473	199065200	56.543225740677414	22.41228199005127	22.90150911346062
1	1446	22.352885871590633	22.339582443237305	22.51475158053414	22.29080095035879	221056400	49.0961326269252	22.40832233428955	22.899046443193583
1	1447	22.304107060574378	21.991464614868164	22.326281699412526	21.885032100182315	205965200	42.48502832293084	22.372687067304337	22.90816535224258
1	1448	22.011416932124412	22.15110969543457	22.22206413221424	21.738686503000487	191031200	44.30775359815006	22.344811575753347	22.88308813652738
1	1449	22.04911732751625	22.08902931213379	22.219850894571106	21.960423840400875	173878400	43.60277960752362	22.312977245875768	22.85557374393942
1	1450	22.16219987419298	22.08902931213379	22.317413899566773	22.04468172273232	148204800	45.85001402012565	22.293337958199636	22.847757199689926
1	1451	22.046902325852404	21.8961238861084	22.199898568270108	21.89168997244877	168376800	40.62290684158892	22.248516491481237	22.82380476170541
1	1452	21.898344029990653	22.350679397583008	22.419416062626606	21.79856319925954	229618800	47.07629006779522	22.232837404523575	22.781719582804616
1	1453	22.514756158284378	22.39945411682129	22.70101095984965	22.30854451844421	309506000	50.18379543099422	22.233787536621094	22.783857711562188
1	1454	22.326282154984522	22.33515167236328	22.623403374579304	22.23980647515097	265326400	49.00065596524583	22.228561265128	22.772848176948642
1	1455	22.468197635872098	22.131162643432617	22.567976775178757	22.131162643432617	214333600	41.07253048312227	22.183739798409597	22.635457800110654
1	1456	22.25976570695786	21.8961238861084	22.288590374964883	21.85621189642064	254754400	40.636715784138005	22.136226109095983	22.55564457574933
1	1457	21.72316615552055	21.62782096862793	21.98481096896862	21.104531341731782	403734400	48.76394373021846	22.130999156406947	22.574892270733308
1	1458	21.186579243625026	21.344009399414062	21.667739229982928	21.15553677300115	288618000	30.893613158324357	22.05988679613386	22.653553863196226
1	1459	21.618956358643885	21.65665054321289	21.951555687238404	21.46596012615035	272718800	40.25560268835601	22.02124227796282	22.645899363233468
1	1460	21.800775539500673	22.120071411132812	22.164417308109485	21.778602591012337	310069200	46.45673994336301	22.005562918526785	22.60636327841728
1	1461	22.84292223175707	22.720970153808594	22.84292223175707	22.454889663244405	378495600	60.88695100699835	22.05767045702253	22.76948709236083
1	1462	22.80300910753644	22.83626937866211	23.084610819154424	22.749793688747967	273052400	60.362301658044416	22.106610434395925	22.931357143807702
1	1463	23.077961109565802	23.244260787963867	23.293042297630684	22.97818028751428	284298800	65.81671771130601	22.18912696838379	23.21333949463199
1	1464	23.32186092134757	23.330730438232422	23.390597562595946	23.17773423242166	188215600	66.60738092213313	22.277819905962264	23.46653550792258
1	1465	23.248688251061456	23.306339263916016	23.388381024836455	23.215427986272775	136750800	69.75153995220258	22.378549575805664	23.663073460221895
1	1466	23.37063779735014	23.66775894165039	23.66775894165039	23.3595504805145	192243600	68.94123881745801	22.47262668609619	23.92969246634774
1	1467	23.647815301951884	23.800809860229492	23.807463268578832	23.583512554744484	210751600	69.67628350019604	22.572723524911062	24.19168114540656
1	1468	23.71654217946668	23.720977783203125	23.803017843768608	23.481505932049863	162619200	69.37374476440768	22.671711104256765	24.394249049318613
1	1469	23.949370894093185	23.947153091430664	23.956022610392985	23.771983898222295	178557200	75.23089626866542	22.801424707685197	24.619470667916925
1	1470	23.995931138035214	24.25757598876953	24.457135907412237	23.949367438966505	209130400	82.13622896940821	22.97009985787528	24.862975960667516
1	1471	24.248706201947204	24.080188751220703	24.277530865330515	23.885064439428838	166297600	84.22024501832448	23.145268985203334	24.955130043783992
1	1472	24.191053774365905	24.13783836364746	24.23540135970411	23.97597263761597	149743600	91.61137028773435	23.34482819693429	24.896880335903397
1	1473	24.184601941321308	24.206871032714844	24.226914404284965	24.006447511150245	139874000	90.95500937304728	23.526986803327286	24.7988652973533
1	1474	24.218008422218706	24.275909423828125	24.34494412253976	24.173470235764015	134766000	89.6430901323681	23.680975232805526	24.719753138661726
1	1475	24.278133442071635	24.235822677612305	24.34716983496711	24.20019077172783	108782000	85.09451253730526	23.78917898450579	24.70557270346308
1	1476	24.206869226970152	24.429563522338867	24.440698916716357	24.14006195777312	109769200	85.6172543147299	23.90298570905413	24.697196446079708
1	1477	24.35831627979668	24.774755477905273	24.814840543493393	24.356090558781105	187769600	85.2017646067889	24.012306758335658	24.836695292745343
1	1478	24.89722502918497	25.124372482299805	25.264669288721663	24.852685146891915	238091600	86.79965469445703	24.140424047197616	25.060474350058307
1	1479	25.19786924855869	25.427244186401367	25.429471605911246	24.76584161089879	176254400	89.05158553725364	24.29191725594657	25.313229650275222
1	1480	25.447283806027908	25.384929656982422	26.117594306313155	25.231271703698372	186986800	85.82795425060291	24.414572307041713	25.521819707346456
1	1481	25.37379361801815	25.714515686035156	25.763508712630042	25.362658221420048	176896000	86.90213917235708	24.551265580313547	25.796076020238925
1	1482	25.707839222076952	25.53636360168457	25.77464651523678	25.342620582595494	167476800	83.72734495205171	24.680935995919363	25.931374171918804
1	1483	25.58980440847009	25.901575088500977	26.024057640672236	25.57644159430964	173582000	84.52672495474744	24.820537567138672	26.15186054890607
1	1484	26.168808552010614	25.937206268310547	26.182169666774342	25.839220229315938	228717200	82.8628984105375	24.94051115853446	26.353514488967136
1	1485	26.021834386688052	26.418230056762695	26.449407129755777	25.97061563778073	189803200	90.88702796566017	25.107514108930314	26.63086249979896
1	1486	26.516207446577607	26.188846588134766	26.667639622625227	26.155442106840546	275361600	83.83517247672359	25.254014696393693	26.770128504755235
1	1487	26.26457205156604	26.500627517700195	26.52289661278441	26.240075537266492	163073200	85.0338368316024	25.41785444532122	26.94223867882988
1	1488	26.560748281370984	26.48503303527832	26.58969962760155	26.28906266390084	99257600	84.30117780851208	25.57564898899623	27.047270047610613
1	1489	26.458313110986257	25.625436782836914	26.556299161011918	24.779197639396756	335256000	67.19948969859733	25.67490713936942	26.928558607243353
1	1490	25.27580846758319	25.52745246887207	25.776870749980215	25.108787706784184	237395600	63.918684953766395	25.753327778407506	26.789979416656756
1	1491	25.77687242060425	25.816957473754883	25.910488698098646	25.63434816474047	172253600	63.40193391034081	25.82777077811105	26.698042505787562
1	1492	25.781317753728636	25.718963623046875	26.099770663158463	25.674425443709225	168178000	58.17503137717064	25.870241573878697	26.645489213820834
1	1493	25.8303168578267	25.60984992980957	25.850360232568093	25.529679828890064	153275600	52.65193988441356	25.883284841265	26.632120713796645
1	1494	25.409423426763635	25.03084373474121	25.53190599131245	24.85714242430685	230659600	45.551195650767305	25.85799298967634	26.697735943893875
1	1495	24.538688704527956	25.413877487182617	25.453962534442482	24.351624584307615	240832000	46.272781832137674	25.836518832615443	26.70688456224301
1	1496	25.47845538229779	24.930625915527344	25.576439717823124	24.839322137080707	178261200	43.01841481274999	25.793251855032786	26.78029624051209
1	1497	24.999663810416937	24.857139587402344	25.342613252990418	24.794783753188547	165606800	37.09421434466933	25.718649319240026	26.821511153014807
1	1498	24.598820443540117	24.436254501342773	24.91282032762882	24.402850005308597	224112400	33.06549943941242	25.611438478742325	26.899112560510883
1	1499	24.652262682105096	24.102209091186523	24.85268792728948	23.683542645907366	268872400	22.973108926476	25.4460084097726	26.874569917951852
1	1500	23.687997915952707	23.772621154785156	24.532009681209104	23.663501402260128	243162800	22.4481193876113	25.273420878819056	26.887204479579424
1	1501	23.855016221886796	24.364986419677734	24.460743346423907	23.788207246132483	213647200	27.1121596998249	25.120875086103165	26.635663812225324
1	1502	24.912814129302934	25.086515426635742	25.086515426635742	24.6433542066427	236024800	36.981775131455976	25.020980971200125	26.316885867136833
1	1503	24.99966478816491	24.892770767211914	25.217904269868995	24.866048536240783	353719200	42.21484410150731	24.968647684369767	26.21773092729451
1	1504	24.977398839427394	25.151100158691406	25.273581030443268	24.93508636970097	180670000	46.132739293824166	24.94176537649972	26.154719555320817
1	1505	25.215684732038095	25.06202507019043	25.237953829647974	25.04420911249323	104113600	41.90932438498503	24.887841633387975	25.99576837153391
1	1506	25.070934067249123	24.943998336791992	25.099883725415378	24.943998336791992	57918400	41.73014006279561	24.832486970084055	25.833851002364415
1	1507	24.964037451902257	25.384929656982422	25.50295739610754	24.943995775004694	134884000	47.75855167193878	24.816421236310685	25.770144063108
1	1508	25.34039108626432	25.367115020751953	25.55863060466579	25.320347710642814	110395600	53.77315162589464	24.840440613882883	25.833550431662758
1	1509	25.306983954566096	25.057565689086914	25.369338096180158	24.966261895730018	119526000	45.93494696564822	24.81498977116176	25.76198715124823
1	1510	25.12437797877717	24.581003189086914	25.193412687655695	24.543145555122766	165613600	46.00516334539102	24.790016719273158	25.742303033581734
1	1511	24.805917678201215	24.34716796875	24.81705307269228	23.90623251185277	212818400	44.378968666090906	24.753590175083705	25.73343207945477
1	1512	24.11556867617278	23.661272048950195	24.195738769154584	23.474209631341235	257142000	41.92943915209394	24.69823428562709	25.830943784396872
1	1513	23.72585970943974	23.66350555419922	23.92405757389281	23.300512623440994	263188400	45.0922312384911	24.666898318699428	25.891206028093915
1	1514	23.87284247108477	23.995325088500977	24.095536903460648	23.76149525489683	160423600	52.490141674113275	24.68280574253627	25.86201757258677
1	1515	24.324904573490937	24.91727066040039	24.975171667068338	24.206875140930833	237458000	55.75141224982718	24.722254616873606	25.89258454268242
1	1516	25.090975746205	24.943998336791992	25.220138896220554	24.543147767441415	214798000	48.264733969225965	24.712074824741908	25.871181640684753
1	1517	25.07538875931641	24.329362869262695	25.082069319381844	24.229151070234366	198603200	43.77777365848068	24.671831403459823	25.8429731134476
1	1518	24.814830045881223	24.54537010192871	25.11992189929338	24.2536410640754	268367600	43.24724650143336	24.628564970833914	25.767754707605803
1	1519	24.282593165412145	24.451841354370117	24.605499307099826	24.162338007391202	195826400	43.20434463790011	24.584980419703893	25.699147522032504
1	1520	24.496376037587304	23.7882080078125	24.509737153556845	23.752577798886094	240056000	38.52271319653026	24.502423967633927	25.67190531768425
1	1521	23.83497296480989	23.603370666503906	23.95745552127747	23.427441948588125	314053200	31.360647768625782	24.37516975402832	25.518410922419644
1	1522	24.01535261939484	24.21132469177246	24.266998267057435	23.716943071398276	199599600	39.236778545138186	24.292613301958358	25.284150266309602
1	1523	24.262549780250666	24.396167755126953	24.732435014569067	24.11111754787758	194303600	43.69431704239915	24.245370592389786	25.137998205785276
1	1524	24.554277991079733	25.03084373474121	25.046432270318064	24.434022845619882	215185600	54.16320683042283	24.277502059936523	25.25090417672284
1	1525	25.008571464728334	25.160003662109375	25.331477531676878	24.837095896138095	185859200	57.67130468342727	24.335561752319336	25.417749808180222
1	1526	25.32925367236059	25.186729431152344	25.467324774353628	25.119922148786404	222460000	66.44262876799579	24.444522993905203	25.541340739774533
1	1527	25.035296295572685	24.304859161376953	25.048659110774842	24.28036264903307	382274800	55.811084704473785	24.49033396584647	25.496456226006178
1	1528	26.19553532123924	25.678884506225586	26.304656774129587	25.678884506225586	585908400	62.830893340791505	24.610588209969656	25.75481518327569
1	1529	25.903799913315318	26.478351593017578	26.542933141420324	25.734551776088214	337745600	62.12378688954895	24.722093990870885	26.238719427327094
1	1530	26.367012339234698	26.090871810913086	26.723322972395344	26.021835404565344	334982000	58.434327792104035	24.80401352473668	26.487037923631277
1	1531	26.289068625372668	26.418230056762695	26.538485209317315	25.85036048522611	250956400	66.03966799611945	24.95321832384382	26.81577148650019
1	1532	26.38928113003517	26.422685623168945	26.520669984265435	26.191083289537342	207662800	64.89929525143944	25.087312289646693	27.088530857685384
1	1533	26.389276447377085	26.62533187866211	26.83689249828683	26.346963983647584	280598800	66.9562003326557	25.24256161281041	27.364976364148646
1	1534	26.833258936851163	26.81537437438965	26.88021081728184	26.661108296276215	168984800	75.50034014228456	25.458787781851633	27.559640151899394
1	1535	26.833255438234904	26.589561462402344	26.884678026144194	26.4822455729834	174826400	74.98270258401693	25.672087124415807	27.55670184721761
1	1536	26.50460550648768	26.766185760498047	26.793013454820173	26.477776106437283	155559200	73.03674403006252	25.854577200753347	27.620951085118687
1	1537	26.86678175708712	27.280391693115234	27.309457290744422	26.864547253983	248034000	74.54846757551081	26.06059319632394	27.76597308745124
1	1538	27.448083069083964	27.919822692871094	27.92876582622823	27.38771905108365	294247200	74.56905207515193	26.26694883619036	28.127654668203494
1	1539	28.18364735724464	28.2730770111084	28.50112271374741	28.074096926769148	297898000	75.50278302180135	26.48931121826172	28.516755790852663
1	1540	28.456396085770706	28.41168212890625	28.456396085770706	28.091972390713874	217088800	75.94375000767201	26.719664982387	28.840269973816582
1	1541	28.503352800302096	28.579368591308594	28.814121183097225	28.375916117661312	252609600	88.85144295146105	27.024987084524973	28.85946425812923
1	1542	28.53464941162004	28.778345108032227	28.791758955378995	28.494406163851437	179566800	85.82325071183116	27.24637712751116	29.128546793530347
1	1543	28.724692078219103	28.717985153198242	28.847658056030365	28.691157453114794	149449600	81.21928821236325	27.406350953238352	29.38553593147502
1	1544	28.75598277148708	28.952728271484375	28.952728271484375	28.6285478264115	195793600	91.66697676381872	27.610769271850586	29.595836167019915
1	1545	29.06898617747203	29.735233306884766	29.735233306884766	28.988499695220717	283896400	92.64213964815542	27.847698075430735	30.004041021223223
1	1546	29.721827339352725	29.54967498779297	29.869386497832515	29.326101745777628	276912400	88.41083947295544	28.071054458618164	30.23932426236204
1	1547	29.413289811557256	28.793991088867188	29.42223465002308	28.650904376520867	298846800	73.45262454414944	28.225958687918528	30.254684655729438
1	1548	28.793998869255304	29.158424377441406	29.25903166290082	28.306610796317273	365150000	74.41755440631198	28.393319402422225	30.30391568908359
1	1549	29.06452186219934	28.7202205657959	29.191960249402182	28.671034178958696	248059200	71.26291245134334	28.545509338378906	30.152492737498847
1	1550	28.89683935301385	28.861066818237305	29.12711950202075	28.684445471395218	192386800	71.05622669969752	28.695143699645996	29.9370905318648
1	1551	28.83200266833348	28.921430587768555	28.95720312012517	28.637491655804688	151265200	68.15047151561332	28.812360763549805	29.75211990461649
1	1552	28.86330775138471	28.73810386657715	28.966149535298193	28.688920890438336	126665200	60.066081868875216	28.870809418814524	29.661386809638252
1	1553	28.747045809793374	28.261892318725586	28.78505284884034	28.116569380673152	226068400	49.86645155589403	28.87001051221575	29.66320814078573
1	1554	28.70680554393638	28.30437469482422	28.923671881504546	28.22836060431464	291368400	48.68861599338388	28.862345695495605	29.676420825756182
1	1555	28.608430306914087	28.425100326538086	28.96838504941082	27.960067598750246	354114000	48.092825973464954	28.851326533726283	29.685821700651285
1	1556	28.261894297673237	27.83710479736328	28.442988077589106	27.67836800046826	275426400	39.384761394235674	28.784095082964217	29.779975920318638
1	1557	27.8907610481892	27.329591751098633	27.895231762365803	27.300527844629684	275756000	35.77638426221924	28.684924125671387	29.949446133752005
1	1558	27.345241919028467	27.823688507080078	27.924297486605656	27.19321205048778	193450800	39.017007494400346	28.604278428213938	29.937378601603758
1	1559	27.812506048221806	27.631410598754883	28.036079245224027	27.405602897906892	207309200	26.879640541083262	28.45400537763323	29.710009083497948
1	1560	27.696249216955437	27.93547248840332	27.93547248840332	27.47044149828185	143497200	32.71073706850234	28.338705199105398	29.449392980610448
1	1561	28.147869048719393	28.402742385864258	28.465342615236214	28.091975743104673	204092400	45.533495247315116	28.31075886317662	29.391381252662057
1	1562	28.393801139272227	28.722454071044922	28.87672015062682	28.252950613824687	261083600	44.97160813328206	28.279618127005442	29.27692991637554
1	1563	28.785053159676345	28.505586624145508	28.89683977388868	28.483229642448713	183238000	47.39126201438249	28.26428713117327	29.238759898684883
1	1564	28.673265842885986	28.147869110107422	28.706800461745296	27.982425402730957	274780400	41.765642968289264	28.213344437735422	29.126035432044425
1	1565	28.420631256304222	28.440752029418945	28.583838768440806	28.286485945958812	150838800	44.733029593713425	28.179010254996165	29.009411506936228
1	1566	28.445223158598004	28.324493408203125	28.62631522559773	28.295427796274037	131369200	45.400314011700985	28.14946665082659	28.921566766927633
1	1567	28.290953353414263	27.584461212158203	28.353553577428713	27.584461212158203	206620800	42.88396769456093	28.101078714643204	28.925935352432163
1	1568	27.44584979276076	27.776737213134766	27.919823941792988	27.410077257732027	190291600	44.62656705864985	28.06339032309396	28.896409832141828
1	1569	27.850519374222753	27.555402755737305	27.879583282336927	27.479388670333233	158184800	41.32089607353023	28.00126906803676	28.847697841060068
1	1570	27.734258952655647	28.252948760986328	28.25965568474945	27.72307960923156	188398800	54.06109808462176	28.030972208295548	28.881759410986877
1	1571	28.190344499185546	27.8192138671875	28.279774122012316	27.803563811122427	168362400	54.85152100115173	28.06594521658761	28.828180754547848
1	1572	27.906403544794234	27.778966903686523	27.97347617936796	27.52185741212452	162485600	49.51307190221149	28.062750816345215	28.82971991208093
1	1573	27.953359666905495	28.01819610595703	28.071853201619977	27.765558979221026	128880400	54.16869324468057	28.09037835257394	28.817232477858074
1	1574	27.828159442577196	28.472049713134766	28.507822247696573	27.796859327699778	148776000	55.602229572705056	28.128705297197616	28.876654662684064
1	1575	28.53688813683982	28.17246437072754	28.644202336529908	28.165757446462965	140049200	47.508502278280396	28.112256867544993	28.844203196419414
1	1576	28.136694324923393	28.080801010131836	28.259660299756256	27.939950470919413	149316800	42.697249227961244	28.0664245060512	28.70863535350564
1	1577	28.13669053445155	28.295427322387695	28.299899742176528	27.870639551780606	129936000	47.60692433394639	28.051413127354213	28.658255434577452
1	1578	28.159050997162826	28.416160583496094	28.440753778189713	28.00478660994573	160752000	53.22931235404479	28.07057680402483	28.706775286133308
1	1579	28.700094382824748	28.36026382446289	28.744811757895718	28.30660672698015	145460400	48.972582895291055	28.06482764652797	28.687936177886534
1	1580	28.393801458392254	28.237300872802734	28.45863790263033	28.150107445727365	102098400	48.88890509245756	28.058599608285085	28.672198438283154
1	1581	28.261898730252668	28.344619750976562	28.42287005668649	28.172469078414718	115881600	61.54902297158515	28.11289664677211	28.678408640652613
1	1582	28.232822252379876	28.208229064941406	28.41615220054878	28.194815219330632	113476000	56.66886381752406	28.143717493329728	28.676388140728005
1	1583	28.06962352707158	27.890764236450195	28.20153093196518	27.82592778624316	207828000	55.033563579565495	28.16767188480922	28.60864503939084
1	1584	28.074085537763946	28.527938842773438	28.644196151623284	27.984655920179712	188217200	54.203607940828654	28.1873140335083	28.667411792547966
1	1585	28.63973281062438	28.373680114746094	28.66208808728349	28.32002131014193	129740400	59.267654451343375	28.22691876547677	28.66593169184468
1	1586	28.391567190269974	28.755990982055664	28.81188429583603	28.241773518713455	150618000	64.65476300825429	28.296706199645996	28.73958234911838
1	1587	28.684445594261174	28.990739822387695	29.158419741982218	28.6486730593314	183083600	64.60719317454561	28.366173607962473	28.913617283466884
1	1588	29.174065210682183	29.127113342285156	29.205365319128216	28.892360823211945	178103600	60.876003389705986	28.4129638671875	29.094856326703287
1	1589	29.58096455076391	29.656978607177734	29.764296181303312	29.321618863810677	387816800	72.89652871711566	28.519000598362513	29.45437315912174
1	1590	30.061655827111	29.18971824645996	30.079538682132394	28.96838294814101	475696000	65.32760504325745	28.59820897238595	29.56113778870974
1	1591	29.100290231624236	28.76045799255371	29.41999828881174	28.6844439188603	253544400	56.067696589785776	28.63142544882638	29.581357434880278
1	1592	28.760456456737618	27.980186462402344	28.760456456737618	27.85274980598811	332781600	45.14673846114648	28.60028444017683	29.60747422601035
1	1593	28.19258759539381	28.829771041870117	29.09358926122926	28.01373001177917	234050400	54.441678085565776	28.63382066999163	29.63784492846049
1	1594	28.952737389179635	28.77387809753418	29.191962416690092	28.67550531655632	203953200	55.14142524362834	28.672147614615305	29.651634620151892
1	1595	28.650912007495393	28.125516891479492	28.717984668028148	28.12104447105538	197085600	48.09780727798644	28.656497410365514	29.665096548860582
1	1596	28.295420454110236	27.948883056640625	28.33789990315106	27.57998697711082	288564000	47.764050900681056	28.637972695486887	29.6906036813492
1	1597	28.011751603913282	28.121761322021484	28.305857085303504	27.843371269953384	175763600	52.04245976855641	28.654472487313406	29.662966608009643
1	1598	28.440558852005346	28.651596069335938	28.651596069335938	28.312589876419455	222201600	51.114524088999644	28.663305146353586	29.669188082005505
1	1599	28.599961853251983	28.359739303588867	28.63812765253178	28.204828842819424	168143200	49.87739239165188	28.662309374128068	29.66945419464463
1	1600	28.198098691417133	28.258716583251953	28.485467579490354	28.02298338230087	192640000	45.398883441910144	28.626789774213517	29.654566336333957
1	1601	28.321571008950812	28.29014015197754	28.55505859850458	28.258709295004266	138776800	43.26413772615411	28.576746940612793	29.59638013079624
1	1602	28.60445205155234	28.950191497802734	28.950191497802734	28.548325273376797	180814000	48.45461439831956	28.564109666006907	29.5584305149322
1	1603	28.977139053480816	28.909786224365234	29.071431643959748	28.784062770393323	152832000	42.86313403849867	28.5107387815203	29.314277451604973
1	1604	28.822226925596905	29.22858428955078	29.34757279637572	28.817735823724174	203531600	50.38206784258887	28.513514927455358	29.327361056047042
1	1605	29.340836309465267	29.201642990112305	29.383493210739708	29.105103146326964	178532800	54.709533819106404	28.545028141566686	29.431031985845898
1	1606	29.18592434756533	29.19939422607422	29.405940356526038	29.03774883255425	145819600	65.60712440559146	28.63211441040039	29.51863426730209
1	1607	29.20164393278026	29.49799156188965	29.55187450613996	29.147760988529953	158921600	59.958736934025715	28.679844447544642	29.677227583784273
1	1608	29.545136471128906	29.75617027282715	29.852710109615263	29.500232309437745	182384000	63.80697410314347	28.750008174351283	29.902093416454964
1	1609	29.769642441453847	29.100608825683594	29.83923909343179	28.988355277149765	282790400	63.67808243734311	28.819657598223007	29.92610627329948
1	1610	29.26225756742018	29.643918991088867	29.693310832167892	29.197152009110642	183332800	71.55926178765696	28.940731593540736	30.006950931358023
1	1611	29.603509381807363	29.585548400878906	29.62371420071182	29.432885201547247	122933200	69.17658088613781	29.045287813459122	30.050918930068644
1	1612	29.462062238489587	29.248781204223633	29.51145406861931	29.16346742023482	203538000	58.240370570199104	29.08794389452253	30.07207148270543
1	1613	29.248781188723065	29.307151794433594	29.49798417671604	29.19714552114429	128451200	63.97344152369721	29.155616215297155	30.05026779028882
1	1614	29.154490746110564	29.176942825317383	29.334097102646144	29.033258425230184	134670400	63.42737034233428	29.221203804016113	29.952294940349194
1	1615	29.334093933562347	29.212858200073242	29.39695563770264	29.163466371719306	123934000	63.475352336299686	29.28711223602295	29.78618261382674
1	1616	29.091631981514503	29.042240142822266	29.31613909349498	28.941212627572387	153800400	51.56849846660262	29.29368713923863	29.775773337645724
1	1617	29.07366586257055	28.88283348083496	29.11632275442011	28.817727937179253	142507200	49.55862831512895	29.29176194327218	29.780619956519498
1	1618	28.938966658316396	28.6920108795166	29.008566743736854	28.47423869709899	210699200	40.82880129150966	29.253435271126882	29.83833154332598
1	1619	28.445053577146663	28.606698989868164	28.754874522480712	28.202587170917937	224301600	40.03005794240534	29.210939271109446	29.890789819592026
1	1620	28.718954203254224	28.93448257446289	29.03775394501771	28.703238771275842	156349200	45.99737404221129	29.192017010280065	29.887811362429858
1	1621	29.001824052202938	28.869365692138672	29.22633114073477	28.84466977537192	141563600	39.78090941506596	29.14711516244071	29.838975257298884
1	1622	28.77956775184905	28.550569534301758	28.810998611064818	28.537099655453105	147544800	30.7802568300295	29.06100082397461	29.72589591557172
1	1623	28.310351909501293	28.494447708129883	28.566289929232415	28.22279425605926	175955600	38.053210453229404	29.0177036012922	29.74728648857108
1	1624	28.519133392040423	28.64710235595703	28.703229124567	28.370959613593694	125976400	26.777876421559085	28.946502413068497	29.603809601608656
1	1625	28.674046444538057	28.579753875732422	28.709966689050734	28.45402873780504	131672400	26.666330373957493	28.874659946986608	29.44522980016033
1	1626	28.564040315897163	28.70996856689453	28.80650669256314	28.56179476520162	141628800	36.175006729145764	28.83617333003453	29.3695102336223
1	1627	28.671802821688093	28.42259979248047	28.69649874082422	28.377699055607497	218867600	29.69057645550285	28.772991044180735	29.274616451758707
1	1628	28.622409651413122	28.649351119995117	28.75037862968444	28.53036263125113	136157200	38.40065685300985	28.735305922372	29.182525913893656
1	1629	28.62016947901149	28.519140243530273	28.649354789073108	28.4854638317032	121075600	35.35549489044041	28.68575463976179	29.0513165469294
1	1630	28.559553261231564	28.76161003112793	29.141027648330354	28.539348440668707	221123600	44.250274138875675	28.66570963178362	28.973236888656025
1	1631	28.92998263011093	28.624652862548828	29.006314215574907	28.624652862548828	127752400	44.66112009945641	28.6472681590489	28.928553098747276
1	1632	28.662822068223445	28.456275939941406	28.73466427427169	28.40239471361855	176267200	45.079594847773315	28.63042994907924	28.927932744693067
1	1633	28.166660245227217	27.957868576049805	28.393412893288396	27.946644248887367	196645600	38.44913154735064	28.584084919520787	29.0512716869516
1	1634	28.191358227085335	28.159927368164062	28.314837824885586	28.031958381740775	177482800	35.56471404561961	28.5287595476423	29.000624865082017
1	1635	28.489952610643243	28.42259979248047	28.498933100588502	28.28565031830859	120955200	42.24474957686715	28.496847697666713	28.928173052087896
1	1636	28.384431237848545	28.386676788330078	28.44280356039631	28.236255737424184	108844000	46.845226774911026	28.485141072954452	28.919074083418504
1	1637	28.049918219679967	28.28789520263672	28.33953259039221	28.029711689565808	112241600	46.08831091522103	28.470387322562082	28.916822754328642
1	1638	28.263194872483464	28.218294143676758	28.32156719021459	27.78723926800854	187787200	41.61547991726581	28.439758164542063	28.89275796627829
1	1639	27.94664306999858	27.517833709716797	27.982563313397645	27.511098771132794	243046400	33.35680958883471	28.363906724112375	29.02414593326941
1	1640	27.805206306192193	26.95656967163086	27.852352595573002	26.76573896332186	314380000	25.790501030756246	28.238663945879257	29.2086702304768
1	1641	27.376395961787374	27.677234649658203	27.805203626459758	27.212505027289065	245418000	40.80840050089897	28.185423578534806	29.193033327395426
1	1642	28.070118745041167	28.211559295654297	28.23400966012928	27.91071893055986	165762000	44.981952615504355	28.154152733939036	29.126290071716166
1	1643	28.29687840381726	28.200340270996094	28.370966166579574	28.07237127752184	127072400	46.24338491150739	28.131381307329452	29.08137298949877
1	1644	28.22503500669174	28.47199249267578	28.546080252327005	28.193604147358503	134596800	46.61057015137399	28.110694340297155	29.012983747123833
1	1645	28.678534488688467	28.851404190063477	28.864877492724027	28.59097686277925	144889600	52.51119001801809	28.126890863691056	29.075855514114448
1	1646	28.979376500577892	29.100608825683594	29.100608825683594	28.806505076637993	184658800	57.01025382640462	28.17291464124407	29.24518221804566
1	1647	29.40369655447417	29.65065574645996	29.852710775752595	29.343078675403724	235600800	68.212644612225	28.293828010559082	29.614609372705278
1	1648	29.82576770284685	29.35430145263672	29.84148141747718	29.2577650501334	307025600	62.59468196113042	28.37914044516427	29.81218836961588
1	1649	27.38761906525004	28.112777709960938	28.17563942026838	27.38761906525004	461802400	47.29196966877993	28.357010296412877	29.796720698150477
1	1650	28.332793878604413	28.099308013916016	28.532605050306223	28.07685593478742	203998000	47.47832717744165	28.3364839553833	29.782552510948165
1	1651	28.135233319873397	27.95113754272461	28.229525902908602	27.81643360798097	168649200	47.07033142665989	28.31242983681815	29.773109547006307
1	1652	27.634574891634465	27.562732696533203	27.751319529207162	27.416804468846895	177822000	44.596580138289866	28.26560401916504	29.780315367533614
1	1653	27.699682235717773	27.699682235717773	27.818672424001633	27.513342665647492	134472400	51.65236904670711	28.27859319959368	29.768599290424977
1	1654	27.648051171497354	27.61212921142578	27.72662831808726	27.450483816810358	148046800	56.517857346039506	28.325418881007604	29.670622898328258
1	1655	27.461714402352722	27.47294044494629	27.51784118961332	27.324764904408564	134513200	47.70325552791307	28.310826437813894	29.690314697590882
1	1656	27.52456613738032	27.232707977294922	27.53354662562413	27.145150357984	171540000	38.21621184734529	28.240908486502512	29.736415265736113
1	1657	27.27761313843035	26.590621948242188	27.51783567121762	26.3840741107753	279904000	33.176894213028305	28.125928606305802	29.862899565740427
1	1658	26.36162492547971	25.73749542236328	26.424486643368652	25.425430670805067	496554400	24.51883701883702	27.930607386997767	30.068630840058894
1	1659	25.358081389721963	25.908124923706055	26.366119705899404	25.167250658688133	397250400	21.462931470025396	27.720373153686523	30.039524817601656
1	1660	26.153946683421402	25.964506149291992	26.27347379965924	25.73672877407179	211612000	18.412281129796938	27.496365819658553	29.846849753979168
1	1661	25.840461345418436	26.052452087402344	26.217084861232127	25.82241906762218	154681600	10.037862980664343	27.239351272583008	29.349739421470424
1	1662	26.280234758580217	26.99965476989746	27.06054531514884	26.280234758580217	219806400	27.15206073471684	27.071162223815918	28.795473753332057
1	1663	26.56889941122878	25.59463882446289	26.65234365161192	25.55855599119331	388331200	26.31706216262178	26.891295160566056	28.671985743703566
1	1664	25.37814498883429	25.98931312561035	26.029907401735286	24.724126860424466	404870000	31.483350590510128	26.740581239972794	28.43596524751239
1	1665	26.16972885114184	25.969013214111328	26.250917392031322	25.831443837637845	194143200	32.20615440039833	26.599000930786133	28.186529577498124
1	1666	25.781821941926516	26.15167999267578	26.23061279851749	25.711910273981875	171718000	36.846894450576336	26.498211451939174	27.998970362740994
1	1667	26.169723167511254	26.42230987548828	26.532815807463024	26.047940382626233	163538800	38.38252421727741	26.40697056906564	27.738895916392643
1	1668	26.257683359461367	26.273469924926758	26.485462421696244	26.162963966669015	138242800	37.95935803189254	26.311352048601425	27.448554570801466
1	1669	26.183258571493727	25.93743896484375	26.277977958242904	25.863015852138048	193146000	36.66118010641961	26.201673371451243	27.134016613660194
1	1670	25.72769935710911	25.405200958251953	25.78858989312548	25.175166220842804	274006400	34.89106123051421	26.071137155805314	26.88597793126804
1	1671	24.904544451469846	23.851350784301758	25.23606406247722	23.82654307731436	513102000	30.320003924579026	25.87547492980957	27.26549463441882
1	1672	21.395398731823892	23.255966186523438	24.53693875749235	20.74814616149797	648825200	31.48607096629506	25.698222841535294	27.67364369289194
1	1673	25.057899727746907	23.39579200744629	25.057899727746907	23.341666884845488	414406400	31.16970377278973	25.518770490373885	27.83849987232665
1	1674	24.151289856677224	24.737651824951172	24.782755797615508	23.691223829560954	387098400	42.29020450540444	25.431138038635254	27.770939026709705
1	1675	25.310485037149164	25.466094970703125	25.53826237019951	24.812076944925945	338464400	46.58974229269778	25.389255387442454	27.701983101412868
1	1676	25.296952804131475	25.54953956604004	25.55404927580334	25.154873718399095	212657600	40.62409820773644	25.285675730024064	27.409924608497192
1	1677	25.265373272565597	25.43000602722168	25.829181483488178	25.258607849331504	224917200	48.72332576928072	25.273916244506836	27.39261288750919
1	1678	24.84139096168006	24.29336929321289	25.23154529335964	24.212180770432113	307383600	38.205713542903304	25.152777399335587	27.289135206470323
1	1679	24.859441992696162	25.335294723510742	25.335294723510742	24.611364907608795	247555200	46.14118493662503	25.10751179286412	27.195681121898172
1	1680	25.369118637705323	24.891010284423828	25.434520609176296	24.816587173376877	212935600	42.56060099219901	25.01746395656041	27.018581438290013
1	1681	24.575278829024374	24.642934799194336	24.909052411318573	24.471538298278528	199985200	39.47161775981514	24.890365736825125	26.726335901684372
1	1682	25.202229228835375	25.328521728515625	25.384902554530914	24.879730835203656	219374400	44.742763918716236	24.822869437081472	26.502638553224067
1	1683	25.65553375981686	24.841394424438477	25.71416858508267	24.75569446033144	340043200	44.00296218558869	24.74458054133824	26.297993532906524
1	1684	24.86845690629976	25.387161254882812	25.547282613123834	24.785014375172256	251571200	49.901441180454974	24.743291991097585	26.294372620934013
1	1685	25.21125486996612	25.757020950317383	25.757020950317383	25.204489444933046	199662000	61.958640282778894	24.87941128867013	26.427780648580214
1	1686	26.291508191342007	26.00509262084961	26.361419867641985	25.903607818439557	233453600	68.03784240806587	25.075777462550572	26.421248951579116
1	1687	26.14491553414121	26.223848342895508	26.280229166378035	25.80437487853702	173364800	68.36550161914917	25.27778148651123	26.360213338691825
1	1688	26.217087361742216	26.253171920776367	26.28248933453676	26.034414013299635	148694000	61.86440602041307	25.386032921927317	26.536749092864497
1	1689	26.084022062356436	25.69161033630371	26.27120506756348	25.64650637084307	256450400	51.81283802410698	25.402141162327357	26.563945463798905
1	1690	25.305966775598296	25.585615158081055	25.777311320545408	25.229289687097403	297141200	50.28895128740219	25.404717990330287	26.56808954558058
1	1691	25.635234029522955	25.982540130615234	26.018624685817375	25.63298003527754	200888000	54.23729259811082	25.444184712001256	26.648036313117647
1	1692	25.569833205104963	25.574344635009766	25.750252547956954	25.375883013751302	201384800	61.05918541425839	25.535682950701034	26.541121881524997
1	1693	25.62620868950431	25.78182029724121	25.872029949851093	25.551787317661717	143026800	54.503985920186174	25.567577634538925	26.573962719349385
1	1694	25.540512993024745	25.935178756713867	26.04794040348219	25.342053114130724	200878000	61.18892938882074	25.642161096845353	26.585338224741687
1	1695	26.259931811551112	25.869775772094727	26.316312632705692	25.71416415511413	224607600	63.682019368704786	25.729792594909668	26.48160893736339
1	1696	25.6758303949081	25.35784339904785	25.838207465392667	25.35784339904785	208436000	50.34017820354574	25.731886999947683	26.479036840993434
1	1697	25.445795356033557	24.595571517944336	25.599151274909214	24.324944235507907	293461600	47.319209620077494	25.71432822091239	26.557066682700327
1	1698	24.8459002164761	24.875219345092773	25.154867740335696	24.521147851892948	265892000	44.07306860494029	25.677760941641672	26.620183602448442
1	1699	24.597829376648686	24.712846755981445	24.72186789559641	24.200907836622417	255716400	37.30113662723266	25.603177070617676	26.674972145172937
1	1700	24.358773708379594	24.89326286315918	25.035343652642435	24.255033190065387	232079200	36.252098438276086	25.523760659354075	26.631435251825838
1	1701	24.7805014943331	24.98347282409668	25.116532476066386	24.59782815784907	208258800	34.15903663293115	25.4351624080113	26.499183494764623
1	1702	24.94964660743958	25.103002548217773	25.199977653718783	24.755696396437553	192787200	35.64188867427835	25.353007452828543	26.317955651304246
1	1703	25.19997500230904	24.98347282409668	25.20674042653343	24.67450698047369	187062400	40.06335591507439	25.302426201956614	26.26515338299972
1	1704	24.850414877405527	24.69480323791504	24.850414877405527	24.403877952201086	247918400	38.10962600880878	25.23879677908761	26.237960985940557
1	1705	24.80756499496148	25.285675048828125	25.321757885014573	24.69254762094233	211064400	41.156274538471	25.189020701817103	26.093526653476125
1	1706	25.42324031305095	25.168397903442383	25.427750021620035	25.132315073071435	121868800	44.437509833470024	25.16002450670515	26.03692563429455
1	1707	24.99249242547998	25.21125030517578	25.360094790773115	24.960919300637933	132197200	41.81237235185699	25.119269507271902	25.92154438002043
1	1708	25.098492682820865	24.85492706298828	25.15036208741455	24.708336548055346	177849600	35.351754154099055	25.04210867200579	25.701400146878928
1	1709	25.01730446703446	25.227041244506836	25.281166364968772	24.918073645682114	150694000	41.95378640850882	24.99619906289237	25.47088814189632
1	1710	25.20899914342884	25.042112350463867	25.25861455445786	24.927094963133552	156930400	45.694985675438936	24.97364684513637	25.402068838520876
1	1711	24.98798850634037	25.197725296020508	25.20223500606876	24.832376840272524	119036800	59.83796902227972	25.016657829284668	25.400121211095218
1	1712	25.10976558734987	25.657787322998047	25.747996994991574	24.992494218182753	195871200	62.0737956691113	25.072555541992188	25.576445627614277
1	1713	25.70965986220278	25.655534744262695	26.065987139905182	25.642002174322815	167180800	65.30014586898538	25.13989039829799	25.686823255680878
1	1714	25.784085023327272	26.04794692993164	26.04794692993164	25.73221389575054	166616400	67.53428585496685	25.22236783163888	25.932881553583602
1	1715	26.318565844779567	26.85531234741211	26.889141183221014	26.235123333137814	237467600	73.3407982053864	25.35607065473284	26.465452107172037
1	1716	26.629791266407903	25.99832534790039	26.641066398870343	25.917136823503533	265335200	59.429891788884454	25.4200222832816	26.569075900032416
1	1717	26.025388917066845	25.833694458007812	26.282485338977775	25.707400241194463	279537600	58.87059381662731	25.480752399989537	26.620248763074088
1	1718	26.370441023309066	26.898164749145508	26.904931893835947	26.17423512183826	342205600	69.7853609744735	25.638135365077428	26.91087184625559
1	1719	26.76961727645297	27.18232536315918	27.218409920089425	26.672642180460905	204909200	68.02402742055054	25.773610387529647	27.26902746039676
1	1720	27.28606820199809	26.95003890991211	27.33793932684136	26.93876205476159	197461200	66.5689068412839	25.90087045942034	27.47556016030514
1	1721	27.243218305734647	27.328916549682617	27.369510816943535	26.97484499880934	128813200	68.5354226913172	26.05213233402797	27.743947234666365
1	1722	27.24096375972775	27.64239501953125	27.849876074165746	27.220665764923023	182076000	74.58240875431116	26.251237188066757	27.991520890477236
1	1723	27.76868425463169	27.513843536376953	27.924295887521605	27.428145298878636	179544400	71.07233585732982	26.41458020891462	28.16997393651301
1	1724	27.597643192329915	27.387008666992188	27.787894567459812	27.21940754049948	158210800	71.84150337073781	26.582072802952357	28.216676449871283
1	1725	27.430047279181	27.41872215270996	27.588588681945428	27.319068297245902	132169200	71.17621598815745	26.740715435573033	28.2203192125044
1	1726	27.396071615638423	27.307741165161133	27.588586655705036	27.189967807181937	135485600	66.85345296176615	26.858569281441824	28.225128162439685
1	1727	26.47653288237891	26.44708824157715	26.741524281763503	26.28628145063508	236511600	56.87900306321359	26.915108816964285	28.123615944463573
1	1728	26.35649306577588	26.297605514526367	26.594305185870784	26.093765320179447	180872000	52.265309831001275	26.932941573006765	28.092713339747714
1	1729	26.331580321304664	26.20927619934082	26.45841345757596	26.193422057306908	130102400	43.25843032085197	26.886796133858816	28.109571406644086
1	1730	26.09149478156631	25.443737030029297	26.175296213748187	25.42788289182964	183249600	44.10011086996398	26.84718268258231	28.220600992714896
1	1731	25.226306594296478	25.860475540161133	25.874064306953358	25.140241524660123	152426800	50.270401432794436	26.849095617021835	28.216494540365392
1	1732	26.028080401705157	25.749500274658203	26.057525037942305	25.66569883548022	110467600	35.63667377561451	26.767048154558456	28.25435253419095
1	1733	26.218328196539	26.564855575561523	26.6101526171178	26.15944066013874	186698800	43.18435415454344	26.72294316973005	28.193728905926314
1	1734	26.644129612984145	26.902326583862305	27.12202089177847	26.44482018591183	173183200	49.485301833490055	26.71953514644078	28.18827380415759
1	1735	26.997449389997637	27.020099639892578	27.16052151260104	26.91817869927972	137148400	46.46975737962847	26.69747679574149	28.135751336089395
1	1736	27.013302695280238	26.66904067993164	27.11748900326466	26.576179496545517	129930000	38.96788151883761	26.62795148577009	27.959616120665583
1	1737	26.573919896553566	26.924976348876953	27.03142631559758	26.526357476353816	171212800	43.513022868813195	26.585889543805802	27.831432356702038
1	1738	26.99971096821662	26.732454299926758	27.004241708747806	26.70754041091888	85553200	42.892275751740094	26.539135660443986	27.701502124652887
1	1739	26.791343949310114	26.682628631591797	26.818523210732533	26.635066220081082	52185600	42.03817056892756	26.48655755179269	27.538921450669598
1	1740	26.723398860691436	26.793611526489258	27.045014099445353	26.669042061341106	156721200	44.43900716125955	26.44983400617327	27.41065668639061
1	1741	26.89552742580163	26.5761775970459	26.909116191971226	26.467464011746575	139409600	51.621960501619085	26.459054674421036	27.422238592919456
1	1742	26.576178962493618	26.336101531982422	26.750576201163025	26.290804490442284	133546400	50.47292208817724	26.461804389953613	27.42322103519575
1	1743	26.397258547147274	26.09149742126465	26.451615351049494	25.8695394640138	166278000	48.60659429531807	26.45339162009103	27.426319367733935
1	1744	26.11187538762767	26.958942413330078	27.00877019036631	26.071107363504495	231108000	67.50388459128283	26.561620576041086	27.374706326757977
1	1745	26.947620853609425	26.789077758789062	27.14693024735843	26.682627814774136	128336800	61.376238498281836	26.62794930594308	27.339857214088518
1	1746	26.616945367960554	26.777753829956055	26.861553524492322	26.46746375761643	137238000	62.91233282380291	26.701395988464355	27.20442946613363
1	1747	26.64412512583324	26.18661880493164	26.655450249724954	26.06431472438061	185445600	44.96684495887537	26.674379076276505	27.245079639981803
1	1748	26.281752460678007	26.311195373535156	26.485592663459467	26.16171371014334	116850800	41.66142461481008	26.632155418395996	27.217490246265154
1	1749	26.089234014175602	25.633991241455078	26.134531063174844	25.559249555431837	187544800	33.11266773002576	26.53314767565046	27.28191082783691
1	1750	25.40749940795669	25.475446701049805	25.520743744464255	24.86619161768823	257274800	34.74240261681277	26.447890962873185	27.37949056038325
1	1751	25.35314412940314	25.024734497070312	25.547924538104944	24.993026219185978	213292400	26.86159514468673	26.312159402029856	27.47046638284354
1	1752	25.15609583033156	25.217247009277344	25.36446498640707	24.64196732358438	224954000	31.549947906336385	26.20393030984061	27.47110642994327
1	1753	25.371261423848527	24.682737350463867	25.423354581070434	24.682737350463867	179091200	28.219082355512143	26.061080932617188	27.53054786896374
1	1754	24.666883551463094	24.01459503173828	24.80504005979596	23.964767244484687	385813200	23.009219070653373	25.86257975442069	27.626988386961788
1	1755	24.29770922052472	24.30903434753418	24.31809410354739	23.9104137228117	190362400	28.3052230884133	25.70064095088414	27.594342325148094
1	1756	24.324887247632642	24.28638458251953	24.3973635640692	24.109721941231975	131157600	29.534199366358166	25.554232597351074	27.5504641354818
1	1757	24.29544034615493	24.598936080932617	24.65329288120193	24.2795862074109	130629600	35.296732682420156	25.447621073041642	27.479359234062958
1	1758	24.68727132296796	24.46757698059082	24.68727132296796	24.44945746765888	54281600	21.29449300511041	25.269666399274552	27.162886201240518
1	1759	24.367909344095146	24.193513870239258	24.39055958805158	24.04856129436732	106816800	20.795170038857563	25.084268978663854	26.83989260195752
1	1760	24.225224599135444	24.628374099731445	24.78465181345709	24.202576080849266	123724800	27.920023386991232	24.93074185507638	26.401184761484462
1	1761	24.592146607050342	24.30677032470703	24.6193241486256	24.27506204088798	100855200	29.556770408548473	24.796466963631765	26.10758565393326
1	1762	24.236551760740788	23.84019660949707	24.241080773590475	23.74054104709068	163649200	24.98850314633458	24.61996705191476	25.697110637216756
1	1763	23.240011276538375	23.8605899810791	23.86512072384107	23.101852997823432	270597600	29.296796543813997	24.493295533316477	25.469086105726372
1	1764	23.9511752543472	23.262649536132812	23.973823774241684	23.19470397644936	223164000	26.570823526940842	24.33523859296526	25.34208656690139
1	1765	22.775699104976507	22.80740737915039	23.185644754746907	22.61942310453988	273829600	26.545359462777	24.17685808454241	25.392442332594612
1	1766	22.34990781395521	21.844837188720703	22.67831577933327	21.84030817445499	324377600	19.324431514963095	23.935971668788365	25.538459262699433
1	1767	22.320458371654297	21.96034049987793	22.447291469652836	21.915043458584556	283192000	23.1936334222046	23.74151475088937	25.59474160150224
1	1768	22.41558115347868	22.31592559814453	22.435964301812735	22.046403561475106	198957600	32.17681019273074	23.620181219918386	25.61352304106354
1	1769	22.773432121126728	22.639802932739258	22.80514039064828	22.38613504859576	196616800	32.593217871290236	23.500950404575892	25.51636690161338
1	1770	22.721343506514145	22.05773162841797	22.918389273229003	22.037348477363725	249758400	29.187785432860494	23.341760907854354	25.44028656830249
1	1771	22.186829825105924	22.540151596069336	22.757582239092958	21.684024703060196	252680400	31.365306263379594	23.194704873221262	25.200213726355212
1	1772	21.78820772301355	21.998842239379883	22.130206072806477	21.59795808395817	319335600	29.19843966761937	23.01836667742048	24.975308210065304
1	1773	22.28875212210587	21.892396926879883	22.34310892219055	21.62966922518947	212350800	30.047180982597553	22.854001181466238	24.77192299376661
1	1774	21.539070477871928	21.921836853027344	22.238921311690504	21.158569473070393	289337600	24.757044076287173	22.660677092415945	24.338786879624635
1	1775	21.98298982577291	21.81085968017578	22.168710466632966	21.502834949777913	208646000	25.769498264245073	22.482397760663712	23.92032018407561
1	1776	22.338578238052648	22.970481872558594	22.97954162725782	22.279692424464965	263202000	42.558141128983564	22.420275279453822	23.668085356247133
1	1777	22.993128807431845	22.52203369140625	22.995394177943087	22.4699405374761	207178000	39.32817870304165	22.32466411590576	23.2640935451188
1	1778	22.633017675173676	22.6466064453125	22.84818126624006	22.211748521152266	300308000	44.68752898976468	22.280661037990026	23.077759100350853
1	1779	21.751970222904447	21.1585693359375	21.885597697405487	21.140449829166464	533478800	37.930996931881516	22.16288689204625	23.099718685644437
1	1780	21.242374330653252	21.310319900512695	21.407710105818975	20.925289820727823	222715200	45.560531581040124	22.124707085745676	23.156163408785666
1	1781	21.4688588766581	22.046403884887695	22.046403884887695	21.36920331986204	257666000	50.64800517462046	22.13085447038923	23.15911183529741
1	1782	21.849361267412156	21.840301513671875	21.9037180618825	21.607018470766498	163774000	46.33636926736788	22.096881321498326	23.130214863312823
1	1783	21.61155123232105	21.398653030395508	21.751974847695823	21.353354253836724	149428800	40.61005223115156	22.0082277570452	23.053805357558158
1	1784	21.51641859982277	21.82217788696289	21.933156825382724	21.308049487042794	183857200	48.17411020805723	21.99140248979841	23.041121331566963
1	1785	21.829015582588557	21.997526168823242	22.16376082929042	21.67644516346597	185886800	45.58360737988316	21.952643530709402	22.954040504642713
1	1786	21.979309295486278	21.410015106201172	22.070396713241493	21.334869593600008	185672400	45.243347867098784	21.910584449768066	22.952274265021035
1	1787	21.207345758212984	21.635456085205078	21.792580094453008	21.18685200205592	216085600	47.96353713935857	21.89223153250558	22.944303721955514
1	1788	21.47150155332423	21.630903244018555	21.847236095501568	21.38952304458197	177324800	47.6849843690572	21.871450560433523	22.932459045073294
1	1789	21.842684061713697	21.466949462890625	21.940602754287607	21.428237866078433	169374400	47.28631793009576	21.846885544913157	22.929638942203876
1	1790	21.357638436097602	21.337142944335938	21.569415918446644	21.084376215811346	200298800	34.6108338407106	21.730218478611537	22.62755906881433
1	1791	21.448723736282968	21.403179168701172	21.519315644350236	21.180016868267018	161405600	38.63961719552496	21.65030029841832	22.436240597548718
1	1792	21.637734287471822	22.006637573242188	22.054458079987736	21.544370937353783	196231600	44.07793249371131	21.60458823612758	22.189692570804187
1	1793	22.0134611452585	22.343652725219727	22.364146476382402	21.895048751396633	179452800	63.93483433846402	21.68923704964774	22.336026891837964
1	1794	22.507613332556907	21.920103073120117	22.518999910825947	21.881389749414147	156084000	56.739376431344375	21.73279299054827	22.351167238675767
1	1795	21.860895738891045	21.870004653930664	22.03396164994801	21.81535290104085	141496800	47.70196626449503	21.72019304547991	22.317883327206335
1	1796	21.93148982186037	22.061288833618164	22.065844160261214	21.842680063149675	137123200	52.89006137772871	21.7359778540475	22.35848926558114
1	1797	21.951976996317846	21.562580108642578	21.974748408857543	21.53069978361752	127770400	52.11230497215626	21.74768693106515	22.348660703311598
1	1798	21.400912255992626	21.8836727142334	21.947433398352118	21.25061772569993	145022800	50.81388509530794	21.75207941872733	22.35628873267781
1	1799	21.87228480578718	22.033964157104492	22.033964157104492	21.69010995896165	110330800	50.485477355571504	21.75468213217599	22.363740414069458
1	1800	22.134155640961414	22.068119049072266	22.320884050844437	21.99297180504245	115964400	60.2846616550318	21.801689556666783	22.39760011799737
1	1801	22.056730303588306	22.01801872253418	22.36870408952803	22.008909808636556	140865200	56.32522464508064	21.829015459333146	22.427170677720113
1	1802	22.2366316728168	22.892457962036133	22.947109718467406	22.184255842281985	201628400	66.19874292946807	21.919126510620117	22.730734202317628
1	1803	22.887900818584033	22.94255256652832	22.974432897608136	22.689785843432844	132678400	69.51788632695167	22.024526732308523	22.95738104728352
1	1804	22.903840566716063	23.113340377807617	23.16116087355584	22.874236161718798	147822800	73.24189375564987	22.151397977556503	23.16148192145743
1	1805	23.311459918023203	23.457199096679688	23.625709696248485	23.08374223420394	184220400	75.05553689073449	22.298113686697825	23.429457924736486
1	1806	23.316002248240498	23.197589874267578	23.41619853668873	22.99036604813096	143315600	65.8578607905743	22.383181708199636	23.596263154181692
1	1807	22.949383912903762	23.00631332397461	23.17254796873449	22.86285183352127	126247600	59.17978668704358	22.430514608110702	23.687856891193583
1	1808	23.070076775980347	23.026811599731445	23.131561520286198	22.833250188807355	108806800	67.25837020574389	22.509565217154368	23.767832699882206
1	1809	23.092851968012443	23.038198471069336	23.28185633189265	22.805927189779528	134054400	68.43982691907034	22.59300763266427	23.82319947861867
1	1810	23.281855958720758	23.28641128540039	23.29096487473194	23.113345355884093	109632800	68.99702053682391	22.680516379220144	23.922020893571993
1	1811	23.20670920291618	23.34561538696289	23.434426878993005	23.17710479312348	100304400	82.0113194160036	22.80787604195731	23.91377938389989
1	1812	23.673530746447316	23.814716339111328	23.951346605079163	23.6484816616626	160270800	82.91907956130568	22.945807729448592	24.03675589049409
1	1813	23.821542803516213	24.13123893737793	24.20866210216949	23.816987477735683	153214000	83.83523150376209	23.095613070896693	24.22257646891348
1	1814	24.02876498994174	24.092527389526367	24.245097793785717	23.901243665467984	137682800	82.61173351719765	23.240213666643417	24.317677164974373
1	1815	24.215493058091518	24.11985206604004	24.251928714500302	23.953619161381194	176820800	84.1092868029512	23.390344619750977	24.3081124230347
1	1816	24.122135910711183	24.117582321166992	24.51381063074196	23.942238720122713	142010800	77.73206986057934	23.477853502546036	24.424303053218537
1	1817	23.967285302999628	24.302030563354492	24.431829568660664	23.958176387514353	129777600	79.0088545711174	23.57495907374791	24.562878377823957
1	1818	24.247375676829403	24.167673110961914	24.38172825385584	24.115299025369417	102814000	72.85289287905422	23.6502685546875	24.647305187073272
1	1819	24.0173805967655	24.062923431396484	24.19500008411323	23.885303944048754	104532000	64.64749053554428	23.69353457859584	24.706916972614216
1	1820	24.138071656977672	23.95362091064453	24.18133856778583	23.92401650331354	77645600	69.71535495577228	23.74753679547991	24.727085199595198
1	1821	23.885305037146818	24.52063751220703	24.545686593604763	23.8830273741067	124760400	83.01906095913655	23.855702808925084	24.816935682335306
1	1822	24.741521673389535	24.94874382019043	25.144581127519626	24.730135096570145	182404400	85.58192650598326	23.992983681815012	24.992480717293606
1	1823	24.985181491674517	24.818946838378906	25.02617073924413	24.793897757233704	103553600	81.58336112928467	24.120179993765696	25.046849342360638
1	1824	24.77112136963238	25.046659469604492	25.048937132164713	24.639044738699383	103496000	81.4484575252933	24.24591200692313	25.16288053713176
1	1825	25.144585990836525	25.30398941040039	25.547647260272036	25.11042799111941	149424800	82.67496626696199	24.385795865740096	25.308626052629098
1	1826	24.937360110215177	25.005674362182617	25.215175918653653	24.9168646184815	106314800	71.07171276826229	24.470864295959473	25.386465005892425
1	1827	25.101316607927004	25.267549514770508	25.272104840555333	24.86676597574533	105616400	70.50127738532439	24.552029337201798	25.53678833214559
1	1828	25.03755745599756	24.716476440429688	25.144585040302847	24.620835434715676	127207600	59.50076469874122	24.596597126552037	25.54767444022167
1	1829	24.800736265652848	24.743806838989258	24.996571895015222	24.6322239118379	94326800	59.50083527145741	24.641165324619838	25.553703204243728
1	1830	24.814396026866003	24.825780868530273	25.187852885475483	24.7825156904492	117630000	60.52805288014408	24.691750935145787	25.556527753368346
1	1831	24.898642918605045	25.149133682250977	25.16279618305075	24.743796609947573	108929200	62.093551391180746	24.75225830078125	25.618112721544307
1	1832	25.231119336177006	25.51348876953125	25.581803030302698	25.231119336177006	133029200	68.0293541224298	24.84838799067906	25.733286375776792
1	1833	25.417851394690484	25.52715492248535	25.5931932668127	25.351813050363138	101895600	70.1064042102815	24.952975954328263	25.782345636713366
1	1834	25.52942234881887	25.014780044555664	25.57268925228474	24.987455042238317	187756000	63.11926190135953	25.028773035321915	25.62625549856146
1	1835	24.79616902824338	24.475088119506836	24.80983152812869	24.352120408496866	243286000	49.43303572912398	25.025519507271902	25.63529103700293
1	1836	24.566173840982607	24.34528923034668	24.593500578181203	24.190441194249424	129539600	41.88610011479031	24.98241560799735	25.69261097931661
1	1837	24.28381219969405	24.39539337158203	24.614002126389238	24.1517355340768	122444000	44.180285765202896	24.95216178894043	25.72562268649531
1	1838	24.34984766645425	24.13123893737793	24.34984766645425	24.028764955488953	126210000	37.54664067762482	24.886774608067103	25.772457911216375
1	1839	23.91263229565411	24.065202713012695	24.247377538485683	23.8238225460067	134732400	32.22229703948106	24.798289843967982	25.749517699478368
1	1840	23.910355777509203	23.928573608398438	24.058372613125282	23.798774603671593	112126400	33.79040049876485	24.72135407584054	25.76961157881268
1	1841	23.662142145084665	23.76233673095703	23.97866954360535	23.662142145084665	224064800	26.67622672469693	24.61383887699672	25.727501425565052
1	1842	21.86089309776895	22.275339126586914	22.47800768402633	21.78802352360363	458408400	20.67845614228014	24.43947192600795	26.109403921597238
1	1843	22.227523973906194	21.59446907043457	22.289006986088413	21.462392392593525	328970800	17.305031329477103	24.214519228254044	26.45787909231361
1	1844	21.403181855018005	21.34625244140625	21.569416507197374	21.066160699351197	274126000	15.082398094827582	23.965981483459473	26.64608915801134
1	1845	21.398631675680132	21.323484420776367	21.423680760648054	21.04111497073119	192640400	9.144265773238217	23.692720821925572	26.621738398424025
1	1846	21.451003554773045	21.67416763305664	21.801688970734165	21.332591132265044	227325200	8.878175898959597	23.418483597891672	26.33204310040841
1	1847	21.678718308773316	21.4487247467041	21.838121696797465	21.364468595719295	164102000	8.212847387247663	23.12716715676444	25.946552555162015
1	1848	21.535787253461272	21.36166763305664	21.55182447192448	21.23336988535097	143562000	8.996980996677848	22.86623055594308	25.60819565695248
1	1849	21.39145074677979	21.24253273010254	21.40977774661383	21.04321153104909	174799600	9.934913945134056	22.6353337424142	25.33782810190922
1	1850	21.30668136881154	21.258569717407227	21.48309075729402	21.212747848503902	131745600	10.632275340784915	22.41485377720424	25.01824020078648
1	1851	21.38228598059095	21.402904510498047	21.437270474935442	21.10277870012431	134747200	12.729914300890442	22.2011045728411	24.586259297670168
1	1852	21.41665496256157	21.19442367553711	21.437273495373752	21.182967769802026	114876400	12.908932620998968	21.991332054138184	24.151179240958882
1	1853	21.242536513804254	20.697267532348633	21.256282203109556	20.497948045718164	305258800	11.641224027305654	21.750765255519322	23.650117750150613
1	1854	20.619369138727127	20.738502502441406	21.001972568799147	20.619369138727127	177571200	12.859949707634541	21.522903033665248	23.019507872381602
1	1855	21.16692664134073	21.508291244506836	21.625134819307494	20.99739010491216	245039200	26.99109720182753	21.361899784633092	22.126838437508987
1	1856	21.661793028743745	21.418941497802734	21.696157244887036	21.308972510293124	187667600	37.76768798980438	21.30072852543422	21.860445931587698
1	1857	21.572443237719554	21.66408348083496	21.813001497785894	21.5105841508985	168249600	51.13569886959098	21.305700983319962	21.87776036137156
1	1858	21.68240844389923	21.581602096557617	21.68240844389923	21.437267165711905	121768400	54.05902396051473	21.322511672973633	21.913232065655844
1	1859	21.682407771404122	21.815288543701172	21.863400185824194	21.654914655365868	128104000	57.906792898798614	21.357640538896835	22.004441178629538
1	1860	21.964212476327056	22.092510223388672	22.26662984291923	21.918390603858114	152074400	56.888455339297224	21.38752215249198	22.129035007254508
1	1861	22.27349992029165	22.429290771484375	22.472819360016192	22.18643924737703	140560800	65.57499125968931	21.457562582833425	22.385727207058434
1	1862	22.605699075029467	22.823348999023438	22.850840369855014	22.47740135001435	152675200	71.15382067357272	21.561968394688197	22.739110927718418
1	1863	22.837092487327922	23.00433921813965	23.077652446512882	22.5988240581336	225324800	75.04883972434979	21.687811715262278	23.075681431475942
1	1864	22.782116723047057	22.9906005859375	23.018093712572618	22.7385863761896	145364800	74.6416032728005	21.811528205871582	23.336582757531016
1	1865	22.81876459156714	22.878332138061523	23.00204854327664	22.6400637000093	169228800	71.1841969055231	21.916915893554688	23.522140766591125
1	1866	22.68588247242773	22.557584762573242	22.805017558371354	22.527801865049938	116693200	68.96099975114466	22.014284542628697	23.595925350185283
1	1867	22.360558866601586	22.388051986694336	22.415543358861594	22.138327619313618	160766400	75.8765456604743	22.13505486079625	23.53077706853167
1	1868	22.404089320254958	22.43387222290039	22.51405830535002	22.32619302021424	114019600	75.91035549046677	22.25615269797189	23.401680360559237
1	1869	22.449910152948345	22.59653663635254	23.343416487891485	22.349105538061433	93170000	70.4213303783369	22.333884511675155	23.406154923545785
1	1870	22.738587933145148	22.68818473815918	22.880633141930506	22.672147516838738	89638000	73.79729516128685	22.424544743129186	23.370803857662818
1	1871	22.685889486154238	22.66756248474121	22.80960592230232	22.60799492335308	83392400	70.5440595791473	22.496221814836776	23.340915727217315
1	1872	22.56675491383914	22.830224990844727	22.90811954951255	22.557590539656047	106405600	74.75028091034612	22.58540916442871	23.26081625402008
1	1873	22.573623047141613	22.64235496520996	22.761488308879773	22.56216889274708	126851600	66.69744660040894	22.644485337393625	23.15404473348302
1	1874	22.610284908895412	22.300992965698242	22.708799744951968	22.24600846936512	152082000	54.10275408698942	22.65937696184431	23.107988791721567
1	1875	22.296414863781365	22.328489303588867	22.562176505530235	22.16582557372914	127727600	47.741377969278744	22.65217685699463	23.119540023789096
1	1876	22.410959750175675	22.255168914794922	22.546132058543318	22.229967327606467	117780800	35.13196510211823	22.611592565264022	23.11240676053979
1	1877	22.097091810422565	22.34910774230957	22.394927867420446	22.01003287354161	125307200	32.03558056351581	22.564790316990443	23.028597416098403
1	1878	22.136044452533127	21.840499877929688	22.142917297628973	21.833627032833842	244032800	25.197969058748228	22.482640266418457	23.022706289588257
1	1879	21.993995802790014	21.78780174255371	22.124585082952052	21.77176452386454	137647600	25.86244746116475	22.404745238167898	23.009651683951414
1	1880	21.751147837350427	21.973379135131836	22.07418376919155	21.691580270911125	142185600	36.24635606478347	22.363016264779226	23.002138708816847
1	1881	22.051268002535945	21.89089584350586	22.19789447591358	21.84507397812195	116876400	37.79548721502452	22.327505111694336	23.01411734957844
1	1882	21.980252890251336	22.016908645629883	22.060438993822494	21.82217046612108	128960800	40.151851654970415	22.297721999032156	23.000443284437853
1	1883	21.286062540710464	21.39832305908203	21.686994711391616	21.226494985932966	301245600	26.714595906542442	22.212135314941406	23.038989046760022
1	1884	21.306680208758934	21.086740493774414	21.318136112342437	20.963024076359595	181958400	21.329261146723013	22.097746440342494	23.07103366970622
1	1885	21.28377571065879	21.441856384277344	21.457895352655186	21.109656068662392	161779600	30.403211001620505	22.010196004595077	22.983197141164148
1	1886	21.528913218862392	21.62742805480957	21.661794020451723	21.451016913545132	146124000	30.909335296653467	21.924281937735422	22.792100250330968
1	1887	21.63658965091384	21.9023494720459	21.941296745741266	21.604515219879378	143345600	38.570546479510554	21.871424402509415	22.634684680888146
1	1888	21.877148072890737	21.96879005432129	22.10167083999932	21.84049232907376	104106000	44.392921115221824	21.84769562312535	22.57314688234116
1	1889	21.854241942972223	21.76259994506836	21.856533473599395	21.641175040714174	110820800	40.99202520261863	21.807274954659597	22.478350682581485
1	1890	21.67324939796519	21.886316299438477	21.91610095370482	21.620556429214414	123796400	44.22122415560277	21.780928339276993	22.403462631848218
1	1891	21.92526506124664	21.98025131225586	22.10854906875902	21.906938058836076	100558400	44.221157483745536	21.754581451416016	22.29997267787376
1	1892	22.106253750525305	22.149784088134766	22.197895738580492	22.005449136797587	115648400	55.42154253540717	21.77667318071638	22.360740666851765
1	1893	22.165820686381153	22.218515396118164	22.372014716769797	22.161239373672736	95179600	57.50791626381606	21.807438441685267	22.437588087560556
1	1894	22.26204655699582	22.31932258605957	22.38347145894286	22.250592399938487	96670000	56.213898378947285	21.832148688180105	22.5152363812134
1	1895	22.317035769651145	22.19331932067871	22.376601589288082	22.18644472801975	103568800	55.3485638955661	21.853750365121023	22.563449918340844
1	1896	22.312451644732963	22.633197784423828	22.679017912411446	22.29641442514471	155676000	59.81035890927529	21.89777101789202	22.718788573453434
1	1897	22.66297385882578	22.63089942932129	22.75003452284538	22.566750570312312	120548000	74.41011178658334	21.985812187194824	22.839805247056653
1	1898	22.612576897800487	22.8714656829834	22.94019587312449	22.58966683442012	145975600	86.36791169497454	22.11329255785261	22.920714523884385
1	1899	22.809599417318143	22.88062286376953	22.910405762007052	22.759196244973687	95119600	84.13038835619166	22.21606159210205	23.021596650420378
1	1900	22.910413306958645	22.901248931884766	23.015800998419557	22.850845742941324	105104000	82.78304595867421	22.307048797607422	23.113936974120367
1	1901	22.871463388126177	22.779821395874023	23.13951477342509	22.7110894647035	130808000	74.51983447640691	22.369725363595144	23.177515926543776
1	1902	22.74087282744415	22.603410720825195	22.75003720094215	22.523222889699078	113254800	66.7068700603553	22.415055411202566	23.196730243873215
1	1903	22.509478542346667	22.300992965698242	22.644649126650098	22.20476966013387	161531600	63.49012302372061	22.453512055533274	23.144644422991256
1	1904	22.181861237994983	22.14749526977539	22.445331330444198	22.090219238717985	224959200	56.4479415351726	22.472167696271622	23.1093418958014
1	1905	23.888680963577663	23.58626365661621	23.907009708951172	23.540443541107802	369379200	73.82720730765205	22.586882863725936	23.39728916766371
1	1906	23.558774383289336	23.904720306396484	23.929921896546745	23.55648285293235	159479200	74.93482363628283	22.71223545074463	23.74405521995315
1	1907	23.870363372703597	23.87494468688965	23.952841011460922	23.753519759809716	110934800	73.79864844867558	22.830551828656876	23.990428437338977
1	1908	23.920764777163257	24.29649543762207	24.31940550268889	23.920764777163257	152671600	76.00971932000891	22.97177846091134	24.328321073235177
1	1909	24.29649147719103	23.936798095703125	24.30107279028725	23.82682735421179	135266400	71.606969372487	23.09631265912737	24.465064709840977
1	1910	24.012398538514464	24.236921310424805	24.248375465895208	24.003234165382874	120810400	70.5881488729338	23.210864339556014	24.677584443574368
1	1911	24.31984785586747	24.386648178100586	24.416592422938397	24.250743589448525	109634800	71.71772650874496	23.33627496446882	24.88720910943609
1	1912	24.47878049205477	24.75749969482422	24.796657952028653	24.458050270262135	162213600	72.60083608179796	23.470991679600306	25.168708798910792
1	1913	24.766716228031886	24.96251106262207	24.96251106262207	24.683793569160866	112148800	73.82927507642115	23.619697979518346	25.45388578520568
1	1914	24.930266754525253	25.063865661621094	25.093811668341775	24.879590519208488	105260800	74.3041437987065	23.77417060307094	25.709206450580876
1	1915	25.04082990715068	24.87728500366211	25.08459606350489	24.822002640168918	96034000	73.23172295545838	23.92398943219866	25.852167018922156
1	1916	24.997057364598888	24.861154556274414	25.091499728941685	24.842726520686423	109938000	75.92757762669096	24.085256849016464	25.912682397535562
1	1917	24.826608505145785	24.918746948242188	24.978637199864046	24.826608505145785	74641600	81.85299492517734	24.27223927634103	25.8288586494486
1	1918	24.909533342992788	25.218196868896484	25.23201702050296	24.895713191386314	103472800	86.08285870790118	24.49157510484968	25.541372357145487
1	1919	25.252746217980587	25.195159912109375	25.390954757987156	25.156001645891656	135177600	78.33223948715296	24.606496265956334	25.578771617496066
1	1920	25.130665967014806	25.158308029174805	25.192860167526113	24.955603088124334	101424000	74.50583114402878	24.696038246154785	25.619584241010916
1	1921	25.160604985199566	25.126052856445312	25.24583157774655	25.112230950507048	87938800	74.4336726293667	24.785403115408762	25.602708016428387
1	1922	25.054643378909166	25.190547943115234	25.266562271024007	24.960202773011687	101472400	70.29025469033122	24.849264008658274	25.641335363525812
1	1923	25.075382902969515	24.994762420654297	25.13066526835785	24.84273371909299	103280800	75.94009083834665	24.924832889011928	25.519062038674452
1	1924	25.013180291947258	25.073070526123047	25.181333033419772	24.99936014459674	85030800	73.0036091459684	24.984557832990372	25.43053644908344
1	1925	25.00857429737481	24.884187698364258	25.050036497044996	24.803567242726157	94700400	63.399309215460256	25.020096370152064	25.31430267731871
1	1926	24.736777985664	24.778240203857422	24.849646673981404	24.573233057621866	100344800	50.65152786099461	25.021577835083008	25.31024482782393
1	1927	24.74138403869191	24.633121490478516	24.865768926644762	24.488002858875547	111065200	39.248212237843646	24.998050008501327	25.35343828309779
1	1928	24.55940613448253	24.6054744720459	24.748289130323432	24.483391795847982	99881200	34.28102373586411	24.965307780674525	25.374905251541474
1	1929	24.370523306406607	24.41659164428711	24.531764246382803	24.301419042191416	99455600	34.22698266336843	24.93240111214774	25.43575426599822
1	1930	24.338279794135968	24.43963050842285	24.547893056374665	24.333671905026012	118649600	35.63599398921595	24.902292251586914	25.47028181791532
1	1931	24.44883892050615	24.58474349975586	24.60086759315216	24.32906019204712	106806000	39.25905025945508	24.878434862409318	25.4709750218347
1	1932	24.808180253768057	24.815092086791992	24.877284524850488	24.605477086598004	107210000	36.43395327759099	24.84964166368757	25.40932698511037
1	1933	24.85425186535063	24.808181762695312	24.94639031326654	24.764417361916166	107521600	36.8337646628232	24.822000367300852	25.34521362797647
1	1934	24.838124305898283	24.960206985473633	25.052345420543826	24.663061455004367	169457200	43.749804421871055	24.807850292750768	25.301779424637882
1	1935	24.704526394943947	24.306028366088867	24.709132526379328	24.241531981625542	212008000	31.41951549652228	24.749277114868164	25.274174289562595
1	1936	24.103328357265436	23.75550651550293	24.352101664912592	23.75550651550293	186228000	23.35320221993193	24.646774155753	25.335405900709276
1	1937	23.644934358375426	24.28759765625	24.3520940289581	23.617292302617233	181171200	38.32681811197953	24.59626238686698	25.27865326124623
1	1938	24.7644120213757	24.86576271057129	25.059253585207124	24.70221783555212	248704800	47.06268968107905	24.58145468575614	25.22729365432875
1	1939	25.04543948034671	25.74568748474121	26.03592298804082	25.015493473503124	443554800	60.20755271305566	24.642990384783065	25.531615711220752
1	1940	26.227102609493194	26.62099266052246	26.65784873325689	26.141874259340533	359934400	68.46715077327717	24.77461556025914	26.157814364465043
1	1941	26.517345433367748	26.471275329589844	26.749992867215795	26.26857214515136	319547600	68.40410262521264	24.905912263052805	26.5547175920143
1	1942	26.53346695954564	26.16261100769043	26.76150823961863	26.0865966618679	188092000	64.75990396158464	25.017136301313126	26.784459757540734
1	1943	26.040528187722387	26.160306930541992	26.28699750626958	25.916141556297465	138057200	67.13452852771579	25.141687393188477	26.971370695432224
1	1944	26.224801283428757	26.155698776245117	26.257049471593344	25.900015457658412	144012800	66.92415867717853	25.264263698032924	27.121071887003964
1	1945	26.339968375292948	26.402162551879883	26.475872931890784	26.25934792174885	124296000	67.57241131552556	25.39407934461321	27.29972123420221
1	1946	26.356097883086356	25.962207794189453	26.441326241432666	25.69500827075403	209924800	60.65927311512821	25.476016180855886	27.37304490579458
1	1947	25.715741877184616	26.00136947631836	26.118846038158356	25.695011649598268	119477600	61.0213261658849	25.561243874686106	27.43610871768129
1	1948	26.029017234916818	26.049747467041016	26.070479456560275	25.876988503092452	98429600	60.26041114713463	25.63906819479806	27.49683623146587
1	1949	26.187954283877335	26.24784278869629	26.406781587212222	26.128064021663445	118564400	70.00486528887555	25.777769224984304	27.49115646076247
1	1950	26.065865119355035	25.840126037597656	26.21328591492922	25.752595489411267	143548000	72.12713362230406	25.926670619419642	27.184868422913283
1	1951	25.90462465000526	26.040529251098633	26.114239655242518	25.752597710318657	145516400	70.01583336418697	26.051880019051687	26.884276127266205
1	1952	25.962211745049558	25.918445587158203	26.040530040360682	25.8631632217234	86807200	63.417558603313026	26.127071653093612	26.618113934110095
1	1953	26.04283283238476	26.02901268005371	26.330764388580047	25.943784306757795	118947200	54.49234320166551	26.147309167044504	26.591788491269043
1	1954	26.12114973103809	26.040529251098633	26.181039983590832	25.957604826762427	85812400	37.32410440276301	26.1058474949428	26.45887178755319
1	1955	26.190252169369526	26.234018325805664	26.33767297722377	26.058955457455752	115117200	44.916080652162016	26.088900566101074	26.384459735395946
1	1956	26.3307586772883	26.27317237854004	26.38834497603656	26.14648357573049	97433600	52.678462510951164	26.096797806876047	26.40641504710147
1	1957	26.49430651455686	26.731563568115234	26.892804519665034	26.425204002776045	144944000	61.33453224613741	26.137601852416992	26.59741412052824
1	1958	27.111632145527377	26.78915023803711	27.339675182474256	26.766114309735297	256164000	62.309771952440855	26.182848385402135	26.7600205671202
1	1959	27.03100763354037	27.028703689575195	27.176126227642676	26.89280087133358	150347200	62.2082729401271	26.227601323808944	26.955506230725966
1	1960	26.902013654058788	26.94577980041504	27.051738371819525	26.655544382936686	140769600	72.2626262451831	26.29785646711077	27.101357202905053
1	1961	27.153091059716523	27.095504760742188	27.219891377414076	26.980332162793516	142608800	73.58473189543881	26.376008987426758	27.2637151914156
1	1962	27.026405450029095	27.07708168029785	27.143880248494387	26.89971487435721	94499600	72.43451277672492	26.44939000265939	27.389233197993907
1	1963	27.222199689598938	27.05865478515625	27.22910976540157	27.054046896358056	98214000	69.21391360001157	26.507305145263672	27.49248236582832
1	1964	27.0079811309613	26.978036880493164	27.12545770300448	26.213290704692653	80138400	81.91248196008914	26.58858449118478	27.52310827160531
1	1965	26.91814216986195	26.964210510253906	27.037920909317755	26.796059486168186	96503200	78.93221876108986	26.654561723981583	27.55210129912924
1	1966	26.906623855655223	26.858251571655273	26.929659782945734	26.78454117355137	92770800	79.73768164749251	26.721690722874232	27.516802817800507
1	1967	26.97342614995704	27.100116729736328	27.1208469569395	26.950391978377525	94154800	81.29214741607294	26.79819815499442	27.50771944380774
1	1968	27.169215135291086	27.238319396972656	27.263657509096276	27.021794350605152	192516000	82.58150473634895	26.883754593985422	27.479452600290898
1	1969	26.33076301256388	26.6256046295166	26.650942745729225	26.100417779645237	264536800	58.67350732396461	26.91172504425049	27.403758099288517
1	1970	26.579539727891994	26.36992645263672	26.6878022825667	26.282394128059778	138248000	51.955501517694614	26.918636049543107	27.373335021013666
1	1971	26.229412595172857	26.194860458374023	26.538074367147818	26.13266626065719	151446800	37.74968676234601	26.88030011313302	27.47261531752799
1	1972	26.178732812153473	26.15339469909668	26.312333452381207	26.075076415813566	105677600	35.38122008320782	26.834889003208705	27.543394265329827
1	1973	26.134967015699388	25.68118667602539	26.206373467613453	25.460055487851175	175303200	22.00956407015765	26.73863778795515	27.66603262096297
1	1974	25.660455425494742	25.704219818115234	25.879282660780387	25.621297163583737	113326800	23.552451416568132	26.64995493207659	27.718700632702138
1	1975	25.694962606980692	25.4287052154541	25.80609499027104	25.36387769746517	107730400	16.30006979981721	26.53089782169887	27.747032726165784
1	1976	25.127716527402992	25.19948959350586	25.525944700136186	25.030475257247375	123348000	15.019817622439646	26.39678410121373	27.758820873161355
1	1977	25.486577969294178	25.5629825592041	25.586134983487387	25.343030112471002	130240000	25.30965147875152	26.289950370788574	27.662940651694317
1	1978	25.53983412484031	25.71347999572754	25.866289209988533	25.39860200853866	97016800	29.595625347771062	26.199624879019602	27.543696287178655
1	1979	25.440280384945144	25.67180824279785	25.7736810655066	25.016585747551893	236705600	29.332046551096212	26.107310431344168	27.401784800551457
1	1980	25.720429358767305	24.956388473510742	25.720429358767305	24.5025940756597	228538000	24.547112362694037	25.97146306719099	27.32432366250925
1	1981	24.801267519279097	25.104568481445312	25.206441315450636	24.669296696325638	136575600	22.606388828086452	25.82892390659877	27.086694422450158
1	1982	24.937865362405834	24.474809646606445	24.961017794912326	24.0974198741402	204702000	16.575165304565957	25.631530353001185	26.80077566516739
1	1983	24.673923036322506	24.798948287963867	24.930919092515754	24.578997535849833	129058000	26.248446231422975	25.501054900033132	26.597884297648026
1	1984	24.70401914130442	25.46574592590332	25.521313877793883	24.68086671122528	235362000	39.378726848003524	25.436470576695033	26.412770644930777
1	1985	25.424073896355413	25.45648765563965	25.549099153487774	25.19717758136578	110528000	40.974877370983094	25.383729662214005	26.25799048221136
1	1986	25.403237855018006	25.481956481933594	25.593090635339806	25.38934674824877	113715600	41.76079779318661	25.3357697895595	26.0941366760516
1	1987	25.49585036012747	25.868610382080078	25.92880635806456	25.470382152434993	117058400	52.34919705963074	25.349157197134836	26.139724323901778
1	1988	25.919542981610558	25.884815216064453	26.02836135743469	25.792203719634294	103862000	52.26749137153964	25.36205686841692	26.182894839575713
1	1989	25.782936113046667	25.752838134765625	25.8176656365506	25.54446276015896	109705600	54.22187088064562	25.385209219796316	26.232019020462143
1	1990	25.72969045926444	25.88249969482422	25.90102234757402	25.68801537378608	45903600	59.13314983411617	25.43399565560477	26.312808952243877
1	1991	25.7991520946003	25.831565856933594	26.03994130508877	25.78989076730256	108776000	53.91906762844294	25.453180176871165	26.35553409606659
1	1992	25.648656107470337	25.806095123291016	25.938065933139423	25.484271538460384	114115200	51.40258130188152	25.459795543125697	26.371677572616896
1	1993	25.838507608533945	25.588457107543945	25.977423964722618	25.53057514526389	144649200	48.801586622525555	25.45384189060756	26.360836400928356
1	1994	25.553726926446075	25.3499813079834	25.685697717306155	25.243478719431153	148347600	56.55852955908639	25.481955664498464	26.345906985096928
1	1995	25.275903421878457	25.44491958618164	25.488908691243587	25.20181455573329	106112000	55.77379804487747	25.50626645769392	26.343205018811048
1	1996	25.468064505617892	25.262004852294922	25.47501005876537	25.062890752119426	137298000	65.74055357784408	25.562494686671666	26.177189855774156
1	1997	25.352300824571383	25.45648765563965	25.55141492669876	25.28052775278735	104782000	63.867011203341534	25.609461784362793	26.04811870739891
1	1998	25.296733723946502	25.7065372467041	25.7435825510799	25.273581291920294	119994800	56.16109303229005	25.626661164419993	26.059893238802413
1	1999	25.667176782614735	25.95890235900879	26.030675424991088	25.60697904891689	108273200	61.43288448450673	25.66254792894636	26.117736055236765
1	2000	26.00289708857524	26.38260269165039	26.556248611340283	26.00289708857524	137610400	67.35037170076986	25.726879801068986	26.309001406734527
1	2001	26.229791389285964	26.232107162475586	26.6257038166769	26.04456839529865	105497600	57.70346099338943	25.752843856811523	26.39184364271379
1	2002	26.35712710472652	26.66969108581543	26.838705411145746	26.336290448076404	174935200	64.11298315843337	25.808906418936594	26.613935345355408
1	2003	26.634961558314757	26.66969108581543	26.903532920391193	26.621070453881345	136127200	67.30753582340729	25.87439591544015	26.79993026626633
1	2004	26.71368275304285	26.815555572509766	27.02624676433138	26.67895498860396	186098000	67.50630912794468	25.941042763846262	26.994611871146702
1	2005	26.966050414958655	26.85028648376465	26.97299596820351	26.77619763845718	177404400	69.23050334596637	26.013808522905624	27.17047967847644
1	2006	26.8109285813162	27.00541114807129	27.176741280653268	26.7993514810209	111117600	71.58313213145388	26.09947395324707	27.362623559271466
1	2007	27.028565938545224	27.077186584472656	27.204527633152345	27.01467483011386	85700000	78.27594626533033	26.205811773027694	27.532693953090234
1	2008	27.042451816133486	27.10264778137207	27.18136816375535	27.03782027024301	95132800	86.21979522399543	26.331002235412598	27.640665134376633
1	2009	26.93827045731847	26.924379348754883	26.9753157687116	26.773885862451227	104343600	79.55588985495318	26.436677932739258	27.675171552398343
1	2010	26.762307701585787	26.977628707885742	26.977628707885742	26.762307701585787	56998000	86.14652612289677	26.55922249385289	27.624419690776357
1	2011	26.97762252198136	27.148954391479492	27.273979634187373	26.97067696956712	73187600	86.01001238561969	26.680112974984304	27.577074159593174
1	2012	27.209155410841777	27.03319549560547	27.324919349695016	26.903538682925927	83623600	79.93762412119824	26.77487427847726	27.490814680911978
1	2013	26.961413936438884	27.026243209838867	27.11422314554179	26.949838605287415	60158000	77.08586640851888	26.851112910679408	27.40075844798412
1	2014	27.007724112352427	26.815555572509766	27.13506337026876	26.725259852134023	122345200	62.31884687187948	26.882038116455078	27.36249672629108
1	2015	26.81093145458995	26.891965866088867	26.933640958633696	26.570142227266256	115127600	69.601395162259	26.929170880998885	27.2313775838724
1	2016	26.822499060307948	26.861858367919922	26.975308277743398	26.799346630325445	84472400	57.531737642466176	26.94289711543492	27.20972023387968
1	2017	26.83871168768592	26.99846649169922	27.05634846226432	26.81324347932387	88774400	61.639510307712044	26.966381072998047	27.182719729895947
1	2018	27.037822316970757	27.299449920654297	27.35733188374643	26.96604924799006	127007600	65.43577936996223	27.00094495500837	27.263224374740606
1	2019	27.308714107186017	27.549503326416016	27.651376163971914	27.30640010009075	134247600	69.61044546653785	27.050889015197754	27.429902182964963
1	2020	27.498561565517413	27.577281951904297	27.63979369326737	27.389744961397785	97848400	67.27267699561133	27.091736929757253	27.561934023305877
1	2021	27.491616429266955	27.725460052490234	27.767135136169458	27.459202671562814	110354400	68.71650509816361	27.138042177472794	27.71714016765424
1	2022	27.528664845844634	27.609699249267578	27.62127634964979	27.36891004594118	108344800	63.91375846970168	27.174260139465332	27.8049484878498
1	2023	27.57728208925853	27.56107521057129	27.695361786218335	27.507823028360463	104447600	68.80957371758029	27.21973841530936	27.86447449397838
1	2024	27.399005277569813	27.783342361450195	27.83890855157624	27.371223065715455	137759200	71.64156317881881	27.277289390563965	27.970917017849562
1	2025	27.783338798342683	27.781023025512695	27.899102710002442	27.716195517609968	94852000	68.67274768074	27.322437150137766	28.06091352288623
1	2026	27.644422863271448	27.732402801513672	27.8041758625424	27.637477311096685	102389200	71.5094255484937	27.37238052913121	28.121096193086206
1	2027	27.887529188738696	27.783342361450195	27.887529188738696	27.72083061836056	130391600	72.67662537390855	27.426459039960587	28.176844584323625
1	2028	27.78334197210188	27.801864624023438	27.97087896516003	27.730089789431734	88200800	83.38502499793405	27.49690968649728	28.18264235643219
1	2029	27.67915832828564	27.776399612426758	27.806497600446388	27.667581227899433	92844000	81.0060527927634	27.560083525521414	28.163797600797043
1	2030	27.8805878879623	28.218618392944336	28.269554811002298	27.848174124910436	129510400	86.90179380153327	27.6569949558803	28.21147155494379
1	2031	28.169998000784414	28.232511520385742	28.34827546558474	28.15379111911326	105350400	85.96490642937428	27.74514102935791	28.237537781694996
1	2032	28.278810267132943	28.234819412231445	28.327430901615912	28.1537850214265	82251600	83.00647876062237	27.811953135899135	28.29763352264106
1	2033	27.99866347792066	28.16073226928711	28.16073226928711	27.936151734512837	121510000	74.62682437998745	27.855612346104213	28.349485229843665
1	2034	28.04960234298058	28.09590721130371	28.10516853825184	27.92689285214853	196804000	70.290050816724	27.892657007489884	28.37424744918773
1	2035	29.41099105986215	29.809219360351562	30.212079208382196	29.406361278738753	447940000	86.6450964554727	28.041496958051408	29.16315509838432
1	2036	29.63093482157323	29.75827407836914	29.957388169347634	29.58462819203329	134841600	88.66642318628857	28.194966588701522	29.6113556738112
1	2037	29.707336966857255	29.8856143951416	29.911082599182222	29.672609203544823	98029200	90.68056857357249	28.361005101885116	29.98680879213212
1	2038	29.89719232724873	30.165761947631836	30.214384350459117	29.843938378239184	107383600	90.86561929501985	28.531177929469518	30.379965663724438
1	2039	30.223642233799886	30.452856063842773	30.582511087078757	30.202805576387192	152735200	91.75106433456885	28.722023146493093	30.777317263325102
1	2040	30.41118684914833	30.570938110351562	30.61261496363037	30.381087095826683	92016400	93.4135631904933	28.924775668552943	31.11513061838209
1	2041	30.612793034350325	30.79184341430664	30.798819080576862	30.489551532707484	113399600	93.73907092384628	29.13966860089983	31.435413459394233
1	2042	30.801141775454006	30.722078323364258	30.91275596619974	30.705802954036265	80262000	91.83221136532914	29.34825529370989	31.65103807922401
1	2043	30.945318585111888	30.99414825439453	31.117393317796115	30.86858269951563	92141600	93.05263566211954	29.578094482421875	31.847136735748865
1	2044	31.03599858461388	31.39642333984375	31.412698709767646	30.984841339450863	132904800	92.9775748986622	29.805080550057546	32.123543142530096
1	2045	31.512703564866438	31.5103759765625	31.68710237632259	31.303422862227315	142492400	93.16262628850315	30.039213725498744	32.335513484880366
1	2046	31.547571895636466	31.473163604736328	31.601053187360172	31.35457017976631	90338400	92.25381381219952	30.27052402496338	32.43232789812246
1	2047	31.415024184334655	31.559192657470703	31.58477127833204	31.415024184334655	88792800	94.20524576498258	30.513271195547922	32.40031331753765
1	2048	31.677782985341352	31.787073135375977	31.798700426514976	31.61965007779745	98028800	96.05883965750647	30.776925904410227	32.17788660506652
1	2049	31.72428290955481	31.88240623474121	31.884730273291577	31.64987464628803	83347600	93.38967746365189	30.925010681152344	32.323621944616846
1	2050	31.94520431770383	31.74755096435547	31.968455357528835	31.694069669790792	83152800	90.22085035949694	31.067101887294225	32.354915565955665
1	2051	31.60338177123176	31.777780532836914	31.777780532836914	31.456885676074826	87106400	89.82113325091119	31.20225661141532	32.344915384273264
1	2052	31.889392216298575	31.840559005737305	31.95915242503541	31.689414843600503	81029600	88.79606523537188	31.321884972708567	32.341112434654505
1	2053	31.87544589184408	31.85451889038086	31.959157445849126	31.787082710352042	93931600	87.1729112605025	31.422003746032715	32.34426432915755
1	2054	32.06379123017195	32.50559997558594	32.58931151713457	31.996358608329384	145658400	90.0	31.560193879263743	32.51241424595405
1	2055	32.55444206321746	32.3126106262207	32.61955066349169	32.26610144189402	104844000	81.80973841106103	31.668820108686173	32.58992731917485
1	2056	32.27075651519481	32.50328826904297	32.51491556636597	32.22657491425919	84432400	85.46356416287614	31.79604939052037	32.64291149778389
1	2057	32.40793849600635	32.400962829589844	32.50095329514616	32.22889166044683	87000000	80.03986439264227	31.896536145891464	32.66361426806132
1	2058	32.335840158518934	32.442806243896484	32.549768781123795	32.27305563996797	69785200	76.40850223165289	31.97127778189523	32.73233344123224
1	2059	32.310275935234166	32.321903228759766	32.50792928071393	32.28004922984979	74828800	70.40963758327449	32.02924401419504	32.76218018133698
1	2060	32.26146007508164	32.24750518798828	32.273083825429424	31.868480803555627	88623600	69.11686594489524	32.084554127284456	32.75053373640926
1	2061	32.380025028844635	32.35444641113281	32.405603646556465	32.23818061210644	78451200	69.43249229117185	32.141357966831755	32.747260328487776
1	2062	32.28702805149368	32.368412017822266	32.421893315484155	32.28005238432701	69686800	65.86380164119242	32.182882172720774	32.76334050578356
1	2063	32.39166815575895	32.319583892822266	32.47305212597843	32.28470200716906	61236400	62.24055044480118	32.21410914829799	32.771514796276264
1	2064	32.41724087883668	32.661399841308594	32.72883246424	32.32887770906642	102767200	72.92949248062727	32.279384068080354	32.815041664284806
1	2065	32.72186137887552	32.71488571166992	32.791621599083754	32.61489523480261	76928000	73.24177524052449	32.346320152282715	32.84488698139655
1	2066	32.786960624608625	32.55210494995117	32.786960624608625	32.52885036712715	175540000	66.81350398551999	32.39714486258371	32.81159085021871
1	2067	32.64744957242553	32.89393615722656	32.9032358641284	32.6079196088264	86168000	71.26583365202256	32.47138895307268	32.836576304052194
1	2068	33.045075045734805	32.51722717285156	33.20552246224371	32.491648547782724	158119600	50.267970178646785	32.472219467163086	32.83779464981475
1	2069	32.519551647241414	32.88462448120117	32.92648202192119	32.498621102805764	103440800	62.20216782761539	32.51307759966169	32.92653523089222
1	2070	32.84741622455755	32.76835632324219	32.92182804801979	32.69627208685753	81385200	55.83980744082537	32.53201103210449	32.967240834992374
1	2071	32.903239758606475	32.70326232910156	32.95904865107969	32.6358296886633	89582400	56.77114841055823	32.55360385349819	32.99081778301673
1	2072	32.412582696680865	32.759056091308594	32.838115991349504	32.23353235399328	94300400	57.0396259707794	32.576193128313335	33.02135436878202
1	2073	32.76603304335606	33.43804931640625	33.49385463714466	32.69859688326233	133499200	69.900602749714	32.65591784885952	33.27190886366994
1	2074	33.41014050897588	33.512454986572266	33.59849409626969	33.29620228923059	116760000	72.55367396103834	32.746271405901226	33.46647613673036
1	2075	33.528741295866475	33.46828079223633	33.60082554420861	33.36829387954281	84829200	70.31400667057198	32.82583100455148	33.60338392881704
1	2076	33.41945365256486	33.40550231933594	33.547346787416444	33.25435459700156	78646800	68.58347858778495	32.89990888323103	33.68728505993603
1	2077	33.41713013894557	33.41480255126953	33.512465433560735	33.26365837470856	79942800	69.90707420334954	32.97813878740583	33.73414725012417
1	2078	33.31016321802445	33.663612365722656	33.691515031962666	33.29156025781382	79565600	68.85402134536666	33.04972539629255	33.864084806007114
1	2079	33.535717660404224	33.48921203613281	33.82405820792968	33.440378824349224	110871600	63.93306691523814	33.105034419468474	33.92657943976096
1	2080	33.55199486639149	33.40550231933594	33.60547970797154	33.356669104882826	84596000	65.80561564841649	33.16599137442453	33.93582096031775
1	2081	33.421776229947966	33.33108901977539	33.52641477273913	33.31481364777095	66688800	58.9866044331939	33.1972165788923	33.954877996181395
1	2082	33.39153629231333	33.29154586791992	33.45664485083216	33.228761347865934	75733600	68.47944240212814	33.25252505711147	33.901631237667594
1	2083	33.23807999334554	32.93346405029297	33.333418836818296	32.568387597646954	121517600	51.17078264940899	33.256013597760884	33.897077598600916
1	2084	32.92648631838644	32.972991943359375	33.05437590002408	32.78928993471142	81400000	55.09290729777045	33.270630427769255	33.87189331362728
1	2085	32.99855747101985	32.798580169677734	33.10784759780858	32.798580169677734	71291600	52.24982037092728	33.27743884495327	33.85261944839302
1	2086	32.89857771106653	32.97996520996094	32.99159250239607	32.756733258921535	66328400	54.92236082919382	33.29321806771414	33.81695918738461
1	2087	32.88229495948055	32.83346176147461	33.02878745719697	32.812534768679505	58790000	32.33692563162411	33.25003324236189	33.819994437793774
1	2088	32.99159963248083	32.71255874633789	33.01950230183422	32.659077447359806	69313600	27.24907450405135	33.19289779663086	33.80811319800519
1	2089	32.838121998081284	33.12181091308594	33.23342511874546	32.824170665892794	93278400	41.840165164220885	33.16814994812012	33.76318986519029
1	2090	33.12180534122639	33.082275390625	33.177610660592585	32.98461253358313	69283600	42.30330424166673	33.14506231035505	33.72533051882012
1	2091	33.368301719290756	33.400856018066406	33.47294028334446	33.29388986600216	68537200	49.710539650367366	33.14406612941197	33.72238414407442
1	2092	33.46363483888614	33.60780334472656	33.69383893070851	33.454331584743755	75486000	48.821199395371174	33.14007977076939	33.70354966572661
1	2093	33.59386213376598	33.410160064697266	33.6240923966096	33.340403378370326	80164800	48.34649614850017	33.134433201381135	33.68425085009149
1	2094	33.46595641728337	33.435726165771484	33.52176529357802	33.32411196133377	56985200	50.64794233534022	33.136592047555105	33.691210956843435
1	2095	33.50548221102782	33.403167724609375	33.554315415237035	33.31480811664439	83441600	51.57346879293833	33.14174052647182	33.70540146136564
1	2096	33.74034208437004	34.08448791503906	34.22865639515354	33.707787796984476	134411600	63.521205001411545	33.19837924412319	33.95366607472478
1	2097	34.30771876881533	34.300743103027344	34.43561188851408	34.14494732017667	181408800	74.49978400074369	33.296042033604216	34.235023948686454
1	2098	33.85428035036441	34.196102142333984	34.29609259178793	33.54734043301184	182788000	71.41671999177079	33.38340704781668	34.415860834209504
1	2099	34.070540493159115	34.0728645324707	34.21470898981311	33.905441450094365	93487600	72.71995190018745	33.47442735944475	34.5094622610216
1	2100	34.126340331863425	34.63791275024414	34.642560828119564	34.126340331863425	109310800	76.00300581659015	33.5928521837507	34.75568418371813
1	2101	34.65419488879177	35.57966995239258	35.74011737421431	34.65419488879177	195009600	84.4719896110264	33.78900991167341	35.28017986212736
1	2102	35.7796423134048	35.80754852294922	36.01450154063481	35.681979450377455	156521600	87.83401276035765	34.01008061000279	35.716015939403384
1	2103	35.723841253838884	35.63780212402344	35.79592550314115	35.37039212535665	103222800	82.66913799901332	34.1897942679269	36.01832845769478
1	2104	35.595769611984565	35.946006774902344	35.974028170637496	35.563080952624105	109020400	84.75921220292776	34.39434650966099	36.32693328167537
1	2105	36.12113451051108	36.44802474975586	36.52274017745913	36.114130050501316	130108000	85.40895546735298	34.61200141906738	36.73916909352916
1	2106	36.42700749658684	36.3546257019043	36.57644191351782	36.20285765258913	104038800	82.78399152061614	34.80820301600865	37.04049278285377
1	2107	36.410663679601704	36.30092239379883	36.43868151842886	36.12580377553434	80194000	85.72958904626294	35.0146860395159	37.22458864171631
1	2108	35.86429011064292	35.08209228515625	36.09077711457917	34.95600846287687	203070800	65.71380510854772	35.132283619471956	37.14682663381955
1	2109	35.32024779180167	35.61677932739258	35.80357317431672	35.28755913579967	134272800	69.2798909161225	35.29039873395647	37.05192214983723
1	2110	35.81293540697375	35.738216400146484	35.95302820057735	35.637816742870484	107843200	65.96003172015577	35.408522197178435	37.038586947505635
1	2111	35.957682600353614	35.95534896850586	36.09310806625419	35.70317777987687	91865600	65.96579544258248	35.5267083304269	37.04702252573234
1	2112	36.16783016855042	35.91099166870117	36.16783016855042	35.796579556649974	79675600	66.74226883983809	35.649200439453125	36.97108778387987
1	2113	35.92032314592786	35.8035774230957	35.9973757505327	35.64713858203621	76712000	66.94911708405371	35.77282278878348	36.73423962142589
1	2114	35.89463373256051	35.92732238769531	36.03940083055424	35.73119045688648	76942400	63.82208206123883	35.86492347717285	36.57119023328129
1	2115	35.95768062632456	35.86661911010742	36.013719852764545	35.79657096775657	87710400	53.79235660312294	35.885419845581055	36.57241850444623
1	2116	35.82225382249946	35.8806266784668	36.0580788780008	35.80124044942235	80507600	51.02367977531091	35.89063971383231	36.57619862885364
1	2117	35.95068576137502	35.66815948486328	35.997383347804096	35.57943513948727	97804800	50.420216877954395	35.89280809674944	36.57510638781396
1	2118	35.76387501743783	35.76620864868164	35.801234494113544	35.542058914218934	65616400	47.35742615224697	35.879965373447966	36.564714364353456
1	2119	35.8596139301065	36.296241760253906	36.296241760253906	35.69850427478251	111082800	47.78739802812672	35.86912373134068	36.51904984196357
1	2120	36.0370775857941	35.94134521484375	36.06276179354182	35.83160748660996	101326800	44.40221350735511	35.83960369655064	36.429288504152325
1	2121	35.93433076697515	36.06275177001953	36.380300267185376	35.906312934600585	106499600	46.8321353949442	35.82259150913784	36.36694571480853
1	2122	36.19584132751539	36.27756118774414	36.419991098036014	36.06975396415072	84278400	71.69520038214179	35.90798214503697	36.30783647887751
1	2123	36.24955309170385	36.188846588134766	36.317264054807936	36.05108390408606	85003200	62.38683970555196	35.94884409223284	36.33726547686856
1	2124	36.23554033077806	34.78555679321289	36.23554033077806	34.094424065189784	259530800	36.73555237813986	35.88079697745187	36.61131394653925
1	2125	34.02904942774913	33.95433044433594	34.11076930771042	33.27486938546082	289229200	26.207355760028378	35.737867082868306	36.99718177122756
1	2126	34.36060803185494	34.227516174316406	34.428318995355305	33.89128786347943	136661600	31.016068544900648	35.61761883326939	37.10632933230827
1	2127	34.43998867206281	33.893619537353516	34.43998867206281	33.58540911502718	126124800	29.508784451880317	35.481193270002095	37.2247411544247
1	2128	33.46400722018517	33.69049072265625	33.73485468264885	33.20483148378442	128661600	26.403807120080742	35.32141957964216	37.28493801157245
1	2129	33.571393210680384	33.21882247924805	33.73950730372261	33.202476371104154	201444400	24.297128078883404	35.13229124886649	37.36167293184229
1	2130	33.543380706128545	34.16913604736328	34.26253475987364	33.543380706128545	130165600	35.94162536277342	35.010041918073384	37.25033016737991
1	2131	34.29289494234919	33.85860061645508	34.29289494234919	33.84225806435883	99600400	35.371755660690965	34.88078771318708	37.165869931978015
1	2132	33.977682582095646	34.05940246582031	34.106103614002855	33.76520447137621	85063200	36.42786638897264	34.758872985839844	37.022486238191654
1	2133	34.03604177180477	34.003353118896484	34.25318705981066	33.88427022681949	76425200	30.281053878228576	34.59509522574289	36.70620900125015
1	2134	33.88661474088339	34.155128479003906	34.36060209183843	33.8819439143744	141757600	34.08233945546688	34.46750831604004	36.43945684824332
1	2135	34.36294855409551	34.04773712158203	34.62212429876555	33.945000276805	102769600	31.99846779228497	34.323578698294504	36.07587601979272
1	2136	33.85859550035022	33.55972671508789	34.12711281836354	33.5340425118483	99047600	26.849742198700014	34.129447664533345	35.51254123742061
1	2137	33.73718634839312	34.05006408691406	34.1154414184618	33.42664224214268	88329600	32.94869728386651	33.976677485874724	34.69039281222498
1	2138	33.788564766930556	33.548065185546875	33.88663079329361	33.22117843100334	125997600	38.478416987676496	33.888285228184294	34.46355885834025
1	2139	33.727841024921	33.62744140625	33.84692395091317	33.57140217267739	92096400	46.46106727986361	33.86493601117815	34.45500748320487
1	2140	33.828254305416856	33.50603485107422	33.926320321347646	33.41263966336814	57111200	41.92375883496339	33.813401630946565	34.392993977608626
1	2141	33.5503846064775	33.64377975463867	33.80722304531899	33.323897631250304	86278400	47.07484439426314	33.79555593218122	34.379874546510244
1	2142	33.39395889164168	33.32624435424805	33.506033826019866	33.25152891892857	96515200	45.84662549467719	33.769538334437776	34.40427138149927
1	2143	33.36593371814513	33.66480255126953	33.79789441558771	33.36593371814513	76806800	55.24456012194586	33.80139405386789	34.356885312104616
1	2144	33.64845739618016	33.87027359008789	34.07808086521367	33.475672418009246	84362400	45.73904890154535	33.78004673549107	34.2962412584943
1	2145	33.793205729547964	33.97999954223633	34.054718492429934	33.711485885918805	79127200	51.83593786056473	33.78871808733259	34.3145850705261
1	2146	34.059396570688904	34.02904510498047	34.13177834992738	33.8142333991513	99538000	49.518813322788105	33.78654970441546	34.30783907904015
1	2147	33.97301360558969	34.5030403137207	34.67115448050413	33.95900468549067	100797600	56.993772397797706	33.8222416469029	34.4623579236927
1	2148	34.54972657382784	34.799560546875	34.867275055548824	34.400292203770704	80528400	58.668438660947025	33.868272508893696	34.6809335851997
1	2149	34.74820855141845	34.920989990234375	35.23386776147195	34.68983567337572	95174000	61.70217769144259	33.930647713797434	34.91793549863052
1	2150	34.83692672573821	35.04240036010742	35.05407564620515	34.71317653125596	71475200	72.03372343247943	34.036552974155974	35.16100626677324
1	2151	35.135799194126584	35.26188659667969	35.35528176962479	35.01204898671546	83692000	69.58530005080172	34.123111724853516	35.42466706868812
1	2152	35.373958418124126	35.10310745239258	35.4299976546608	35.06808515630538	68974800	78.26851570615639	34.23418617248535	35.58868161192469
1	2153	35.021384153101096	35.086761474609375	35.126454593896774	34.76220849898012	105010400	77.15060326472675	34.33842332022531	35.71618831449054
1	2154	35.15914034007018	35.51171112060547	35.59343454711461	35.00036431328581	85972800	83.52855350018876	34.48168591090611	35.903024776323946
1	2155	35.444003940741204	35.66348648071289	35.92032494613752	35.444003940741204	75415600	83.60545858457633	34.62595067705427	36.09028112475311
1	2156	35.80591598669207	35.831600189208984	35.94133789509378	35.73820146969436	63124000	93.86732212989928	34.80490466526577	36.19551799948467
1	2157	35.89930675553101	35.15446853637695	35.955345980390256	34.39328777005338	129905200	73.31844482793625	34.91130937848772	36.145280115574316
1	2158	34.998028674043006	34.90696716308594	35.07741490148326	34.83458539319651	68854800	66.01709429918913	34.98535891941616	36.064991185000615
1	2159	35.000372724544405	34.72718811035156	35.100775917321485	34.58709535483587	79383600	61.29959375436273	35.03872953142439	35.967623948228095
1	2160	34.81357280589505	35.0353889465332	35.075082061148755	34.65246315299896	141474400	64.11256370011117	35.11061123439244	35.836496695054365
1	2161	37.19052863875186	36.69085693359375	37.300269937049	36.462036243926384	279747200	73.04473190830052	35.266883850097656	36.30442454465872
1	2162	36.66983085518392	36.32426452636719	36.70719034013615	36.19584352359174	108389200	65.82640262667314	35.37579127720424	36.516938606617224
1	2163	36.441012584920195	36.51572799682617	36.751553080487824	36.35228469315984	82239600	66.31613375099622	35.48970113481794	36.74768011519589
1	2164	36.67217749937969	37.080787658691406	37.10647186836006	36.581115949244996	87481200	69.11951292295603	35.63530022757394	37.12142602471558
1	2165	37.03174535846808	37.37731170654297	37.78592174363856	36.95469275250872	144823600	69.55943600133183	35.7864020211356	37.51875247874189
1	2166	37.18585095526036	37.606136322021484	37.6551710993091	37.15082865919575	104526000	72.84731962165918	35.96518979753767	37.89873213008324
1	2167	37.48189320200718	36.40830612182617	37.5053354673893	36.24656379033705	163217200	59.92267738574177	36.05958584376744	37.93660242185812
1	2168	36.70836532668343	36.914642333984375	37.17015026720112	36.58412913220803	105028400	60.406574276969884	36.15979521615164	38.060462268666846
1	2169	37.345940555701	37.470176696777344	37.55456384701671	37.212326077493834	88490800	62.64417190689489	36.288844517299104	38.287179570348584
1	2170	37.660045749577	37.88039016723633	38.021033028848926	37.53815240808274	117862000	63.86855244701794	36.43518665858677	38.58370926845548
1	2171	37.96009292327634	37.72802734375	38.09370383746087	37.54049992788116	110686400	68.75309589820937	36.619012287684846	38.73565677500255
1	2172	37.62723117075365	37.00370407104492	37.67176933170253	36.99901490231669	111762400	64.28584424043285	36.76877920968192	38.64686866893233
1	2173	37.00369866427685	36.9193115234375	37.38812817770337	36.736473314416784	109712400	65.13244032101254	36.925359453473774	38.390312862788676
1	2174	36.91931045728321	36.85133361816406	37.01072955915357	36.35907471468544	105474000	62.96565635436702	37.05506978716169	38.04311091292172
1	2175	37.090443544432254	37.45377731323242	37.50534745212218	37.04121977890299	86418400	56.411226337976245	37.10956409999302	38.095226545245026
1	2176	37.287343401910114	37.50065231323242	37.61551370916604	37.24280523661365	77596400	60.4471943806986	37.19359179905483	38.087137784819674
1	2177	37.60613186829424	37.33422088623047	37.67880146515024	37.16544657913557	79275600	57.301284716857985	37.25205557686942	38.057289305491096
1	2178	37.42330302273955	37.472530364990234	37.636615544511415	37.33423025487871	101920400	53.78248388006903	37.280037198747905	38.086857977374336
1	2179	37.53816616572657	37.84992980957031	37.97416599241473	37.48893882120858	103864000	54.49320437925497	37.313795634678435	38.175811101026994
1	2180	37.52878251659845	38.187469482421875	38.236693238496414	37.505340248228116	118067600	55.414832917727	37.355319431849885	38.32702426408926
1	2181	38.396098150592145	38.29061508178711	38.41719404899546	38.11715157129788	109078400	72.02414534339806	37.4897700718471	38.41689125923413
1	2182	38.358586931208265	38.44297409057617	38.56486744894937	38.32108073220297	107140400	69.49747085669681	37.59893662588937	38.59191703277528
1	2183	38.63049528148933	38.454689025878906	38.663312306131786	38.356237951951556	66364400	64.58325799218863	37.66925893511091	38.75780527104507
1	2184	38.38437387469021	37.99291229248047	38.50157806972743	37.63661053806663	117874000	51.64167541388341	37.67729622977121	38.7741874147365
1	2185	38.14059139556877	37.95306396484375	38.206225459804294	37.62723643996446	86606800	53.39469159360377	37.69337027413504	38.800015979655576
1	2186	37.995249059367865	37.800689697265625	38.03041245837195	37.58972361039157	87714000	64.52980931994163	37.75029781886509	38.7836892309028
1	2187	37.706933810482845	37.1842041015625	37.774910669889806	37.160761831814895	114446000	54.04455534354257	37.76921871730259	38.7451726493887
1	2188	37.62254050051096	37.85694885253906	37.98587416151204	37.47955126270231	126323200	62.96080332437211	37.84104837690081	38.66165420816443
1	2189	38.117146731979005	37.706932067871094	38.433599475006034	37.21701941316562	286856000	53.69351037931905	37.859130859375	38.65372043212821
1	2190	37.474860373907454	37.42329025268555	37.49595984298	37.01542202802357	179629600	48.94423389279913	37.85360499790737	38.659923047206284
1	2191	37.26858528227462	37.10215377807617	37.3646899885201	37.05761561877852	95042800	46.96127353283483	37.83702877589634	38.69709243605343
1	2192	37.14670946563872	37.47722625732422	37.732730623894156	37.036537201743556	196458400	50.057898841176566	37.837364196777344	38.69681895401798
1	2193	37.5311292978027	37.193580627441406	37.62254843129318	37.03652742769049	113077600	41.71590510783026	37.79048211233957	38.7160474582289
1	2194	37.39047218712409	37.20763397216797	37.45142064330102	37.13965712887909	83242400	36.53338002944372	37.720493861607146	38.664742433841276
1	2195	37.013074361965785	36.584110260009766	37.0974615049446	36.059034306276374	211805600	29.481202607471985	37.598600660051616	38.65922973145928
1	2196	36.52082716694954	35.955902099609375	36.52082716694954	35.80588087599914	150046800	23.166361962367034	37.42095266069685	38.68582775881538
1	2197	35.522241835896246	35.604286193847656	35.69336251656201	35.29252264113518	186581600	21.34780534717035	37.217352458408904	38.66925072575543
1	2198	35.15890449264777	35.2901725769043	35.59021493428694	34.96434516177219	177549200	22.000927892332882	37.02429962158203	38.72875401666727
1	2199	35.578501385757534	35.89729690551758	36.08013514424003	35.55740549131752	146640000	30.943087441413752	36.87745911734445	38.59142416466096
1	2200	36.05200763251717	36.152801513671875	36.26766290137667	35.991059167830294	102016800	35.010714959860536	36.759752818516326	38.42627888893572
1	2201	36.07309633542137	35.93010711669922	36.16451543743801	35.79414986145626	88022000	37.71239084250673	36.67017446245466	38.372848185083754
1	2202	35.913712861984344	36.12702178955078	36.129368162716496	35.630077121637065	105199200	31.30724396336386	36.54660824366978	38.12481449867073
1	2203	36.159838686535004	36.05435562133789	36.20437685505538	35.798851322423296	74795200	31.839481258588464	36.42856706891741	37.87459908238049
1	2204	36.10123828256163	36.21141052246094	36.35439979700333	36.07779958741001	64921200	36.30126885539119	36.34200423104422	37.67196165113815
1	2205	36.01215696034514	35.976993560791016	36.06606988084959	35.7378996124038	80655200	37.02718821691462	36.261635644095286	37.5281918254112
1	2206	36.141085029244856	36.424720764160156	36.436441899399156	36.11061436976941	85135200	38.064838190026144	36.18645668029785	37.25103962737804
1	2207	36.32626267334661	36.40361785888672	36.448156018148076	36.230154390391846	69630400	40.47485000524361	36.13003076825823	37.03669510769636
1	2208	36.52316136509269	36.53019332885742	36.738816599714866	36.44815255933975	65051600	42.0474055896143	36.081642150878906	36.79151791965735
1	2209	36.581768128442214	36.54426193237305	37.03652091961466	36.356738105602645	62468000	49.454100776571174	36.078795841761995	36.78026269254935
1	2210	36.5606826975795	36.69664001464844	36.79743392154388	36.509112557422704	67622400	61.668994295906174	36.13170569283621	36.90164422810301
1	2211	36.649743778481096	36.56769943237305	36.88883769948286	36.50440818185505	64500400	66.32194203921355	36.200520924159456	36.938968170214686
1	2212	36.738821891435094	36.79977035522461	36.86774720700394	36.66381307487818	65576800	76.30658083318043	36.308349336896626	36.90056222076002
1	2213	37.01309492469762	37.47722625732422	37.5053541283479	36.954492808872075	96486000	76.87346465245506	36.42120143345424	37.236221610343875
1	2214	37.45377809076373	37.61552047729492	37.70928241715624	37.324852740862866	75989200	75.91303818939942	36.52568135942732	37.54252002462726
1	2215	37.60378797933938	37.44907760620117	37.67176840547025	37.41157498766059	65496800	77.45680364188499	36.6341792515346	37.70023159323827
1	2216	36.743510422796035	36.56301498413086	36.820865610795394	36.337984961576105	170336800	56.30912754271205	36.66532162257603	37.69231087193039
1	2217	36.710680304936695	36.62629318237305	36.977905596923826	36.5583163560126	95896400	58.29888610162136	36.70617430550711	37.672161415642314
1	2218	36.77632204049379	36.607547760009766	36.96384941623017	36.45049461115687	87937200	55.98836062681	36.734469822474885	37.66040438597356
1	2219	36.63566873745825	36.82554244995117	36.90055124009319	36.614572850554545	71028800	62.891421868625045	36.7950804574149	37.61210997408834
1	2220	36.78101873138654	36.663814544677734	36.931039947302295	36.39658914205317	84828400	53.9780826856263	36.81215858459473	37.60549179901701
1	2221	36.85603612938158	36.898231506347656	36.996682616883504	36.75055305214951	68002000	57.684029119424245	36.84748813084194	37.6057261109709
1	2222	37.3389132460485	38.22029113769531	38.349216475759434	37.20061314557444	177816800	69.14501675327784	36.968209402901785	37.99827841612792
1	2223	38.41718649460602	39.080562591552734	39.39701531252877	38.37733750208399	178803200	74.10868262995372	37.14937373570034	38.64513229068861
1	2224	39.35716045832747	39.624385833740234	39.767375070035776	39.132130445762805	144187200	75.90199044365652	37.358498437064036	39.325898710861246
1	2225	39.818950710834955	39.12041473388672	39.83536101443531	38.82037229103158	134551200	71.17868190533098	37.54083524431501	39.65984731344506
1	2226	39.052435793460795	39.40639114379883	39.49781026484179	38.74301502883056	165573600	71.43419081389133	37.72702244349888	40.01673130674785
1	2227	40.78706028150476	40.435447692871094	40.84800517589083	40.1119629667559	237594400	72.99569075439672	37.938323974609375	40.638015363413594
1	2228	40.404972254126264	40.84566116333008	41.01912465620114	40.25260823430398	140105200	74.0909990986808	38.16904830932617	41.271911481066304
1	2229	40.76596639277751	40.976932525634766	41.08007279566752	40.69330035983308	97446000	76.45017400715248	38.42103794642857	41.829944499345814
1	2230	40.94176812294235	41.3121337890625	41.3121337890625	40.864412929057636	97638000	88.81262552227555	38.7602607182094	42.31477114558474
1	2231	41.047257206637916	41.227752685546875	41.279322822378006	40.58547234842456	117930400	87.47659741843039	39.08893639700754	42.64441237158071
1	2232	41.19480817763057	41.0912971496582	41.25832696109468	40.99719817312651	100582000	85.83089255621917	39.40920421055385	42.80606878162586
1	2233	40.81605602055134	40.9266242980957	41.05130706389746	40.79252948035832	67928400	83.05458704595347	39.70213862827846	42.83639827963085
1	2234	40.707836955241824	40.30791091918945	40.81134798355686	40.27026989259383	99130000	77.35609155982281	39.962431226457866	42.57091809081308
1	2235	39.98562606266664	39.77625274658203	40.06796537592378	39.611577709714346	116632400	70.68219872955372	40.168004172188894	42.10289524782183
1	2236	40.270285589433804	40.251468658447266	40.43260943895905	40.06326704175644	94550000	66.61934877344905	40.313088280814036	41.890432686697146
1	2237	40.237331171577175	40.027957916259766	40.31967046093666	39.9079811934303	87598000	58.653401235393815	40.380759375435964	41.80409440161637
1	2238	40.06089568863289	39.98796844482422	40.12441447083384	39.88916344453707	65049600	53.657561298334294	40.406729561941965	41.78310830139026
1	2239	40.176180127431266	40.73137283325195	40.86311286689641	40.176180127431266	100525200	65.46107958060975	40.52179799761091	41.68828871109918
1	2240	40.78311991522031	41.159523010253906	41.16893147228907	40.710192668098465	102355600	66.37861047337535	40.6470217023577	41.66460616872419
1	2241	41.19246809884522	41.16188430786133	41.28656710082312	41.086602234561546	56106800	58.39772451657002	40.69891003199986	41.74374057897226
1	2242	41.180703309188885	40.95486068725586	41.18776055459492	40.77842237281173	82867200	51.324590952839266	40.70670999799456	41.75787103000229
1	2243	41.00425491522009	40.71489715576172	41.1383461346195	40.430241832320306	105715200	46.9031687394561	40.68799318586077	41.72769666026775
1	2244	40.61138901427579	39.87034606933594	40.67961023782648	39.324565511992176	166665600	34.79143328053979	40.585008348737446	41.643847889696474
1	2245	40.09382737427675	40.427886962890625	40.49610817543287	39.62568016801999	166108800	42.32847362674995	40.527875082833425	41.521636657742626
1	2246	39.98091509798154	40.23969268798828	40.38554718982146	39.63980179453347	159037200	41.91251109460757	40.46704619271414	41.415466617717136
1	2247	40.57610021260973	39.94562911987305	40.60903521611618	39.905636872018505	130169600	40.907181559358854	40.39697510855539	41.344084649217194
1	2248	39.77153965533183	39.90798568725586	40.35025878455128	39.61627310973076	109400800	45.845597850638384	40.36840902056013	41.35056637776135
1	2249	39.404556851382495	39.75978469848633	40.039734064788874	39.15989730171995	114240000	49.814122552527486	40.36723273141043	41.35247969504817
1	2250	39.764474025624175	39.832698822021484	40.09617877864373	39.7362450558847	102693200	44.801134318632144	40.33732060023716	41.36233264734544
1	2251	40.10794692671986	39.84446334838867	40.22792365235798	39.71507816157419	93420800	47.59557323949294	40.32421384538923	41.370733277598916
1	2252	39.804486030642394	40.62080764770508	40.67256317769412	39.70803221660399	141095200	56.95103791048603	40.369416645595	41.40801189608352
1	2253	40.498459433745275	40.39259719848633	40.55492096771794	40.33613925415916	77636800	45.80403985425076	40.34521838596889	41.363064918466335
1	2254	40.58081726150137	40.526710510253906	40.825476841198444	40.463191704221664	95273600	41.546470765693414	40.300017493111746	41.21287964668149
1	2255	40.55727800411516	40.51493453979492	40.72901384846992	40.380839723488826	81906000	41.37929982798655	40.25380679539272	41.03468602224726
1	2256	40.84663980487308	40.9266242980957	40.97367378883572	40.57139651491565	160677200	49.64320695346362	40.25178991045271	41.02497713539214
1	2257	41.140709458534246	41.502994537353516	41.68649009008161	41.13600343189732	117684400	59.178059553098535	40.308082580566406	41.30801960434213
1	2258	41.17598902293328	41.06071472167969	41.26067954046437	40.954852472177315	109745600	65.29602070527338	40.39310891287668	41.43429460877979
1	2259	41.138349689150694	41.016021728515625	41.26773848371291	40.757244139391204	93902400	58.70470533768448	40.43511853899275	41.52850050686372
1	2260	40.97366991103295	41.17127990722656	41.40888573589228	40.957204206173	83799600	63.923731635338605	40.50166048322405	41.655527038228406
1	2261	41.09364663951214	41.17127990722656	41.26773368738501	41.051303178747375	65397600	70.08435131252743	40.589206968035015	41.74732134592493
1	2262	40.18087293163695	40.126766204833984	40.33849067642506	39.917389361407785	132742000	52.695584002466596	40.60483414786203	41.7287509348841
1	2263	40.01620549782669	40.13383102416992	40.17617449062332	39.924457730864816	85992800	54.77466264647221	40.63155174255371	41.68447526538095
1	2264	40.22792555034611	40.24674606323242	40.427890358823106	40.10559401140798	65920800	55.23184183583951	40.661126545497346	41.63789828918654
1	2265	40.11501459536895	39.81153869628906	40.131480304118206	39.80918747779533	103999600	49.62418521211699	40.65877478463309	41.64413737821961
1	2266	40.03031656858133	40.52434158325195	40.53375363475761	39.81858848545459	102223600	48.88269143762018	40.651884351457866	41.639736609471704
1	2267	40.587860421113284	40.51728439331055	41.06306851269611	40.453769198969376	118071600	51.52215663227386	40.6607905796596	41.64078996746649
1	2268	40.59020819429411	40.705482482910156	40.80899350294978	40.48199473854038	89738400	52.15396947378871	40.6735600062779	41.65068816666962
1	2269	40.801939023004046	41.16893005371094	41.25597178570926	40.710191265327325	94640000	57.10633323799694	40.72027397155762	41.72682358552768
1	2270	41.016021728515625	41.016021728515625	41.312436757256776	40.91721312928912	82271200	51.02928013197272	40.7266595023019	41.73995987328143
1	2271	41.06307372777243	41.01131820678711	41.1830504775222	40.79488765977867	86336000	43.48090855569425	40.6915397644043	41.619414802985105
1	2272	40.73607608089581	41.00190734863281	41.00426215670297	40.69843504823779	95839600	49.11917027393942	40.68733923775809	41.60852328347858
1	2273	41.07248605255835	41.23480987548828	41.284214182763485	41.04896309785556	74670800	53.102154643658416	40.70296696254185	41.65507521564557
1	2274	41.446523278327135	41.66060256958008	41.724121350537196	41.32184052400306	101672400	56.44367106348477	40.73791858128139	41.794299082494355
1	2275	41.85114878661073	41.44887161254883	42.20167404645734	41.43710834537233	118263600	53.46240406529983	40.75774656023298	41.85864861305745
1	2276	41.43947884243397	42.13347244262695	42.168758670928	41.18541081937282	137547200	77.49859905321088	40.90108272007534	42.159384903513796
1	2277	42.196978374734435	42.17110061645508	42.36871422042748	41.93349835563262	124773600	77.68551427256176	41.046601976667134	42.39094769530418
1	2278	42.01818874729041	41.98290252685547	42.24638254515911	41.735888214872794	129700400	73.12045907362308	41.17061315264021	42.517426944778656
1	2279	41.710014666790094	41.63943862915039	41.82293417322578	41.54533963872838	108434400	74.95191070961775	41.30117743355887	42.41462730862835
1	2280	41.710009424678674	41.648841857910156	42.21344649842191	41.5970899324347	130756400	68.99849317028465	41.38149888174875	42.41275348017751
1	2281	41.69824195160629	40.98543167114258	41.71000522015645	40.74547463337249	204420400	56.47363534699217	41.41493797302246	42.3514910288565
1	2282	41.053659197219645	40.253807067871094	41.157170232942754	40.117361028931185	166116000	44.57019799764472	41.38267544337681	42.44691999028156
1	2283	40.463182331725605	40.34790802001953	40.463182331725605	40.006794700849944	156572000	39.16822849458577	41.324031012398855	42.52119582202914
1	2284	40.03030778792006	39.51275634765625	40.03030778792006	39.303383118154954	202561600	33.192930378559126	41.21665491376604	42.75411966608043
1	2285	38.941106984847075	39.279869079589844	39.373968066064506	38.74584817774823	184192800	31.581527354062843	41.0929799761091	42.94746994549943
1	2286	39.256348190426905	39.38808822631836	39.625694124294576	39.16930643592293	129915600	33.18628140651592	40.97770718165806	43.04499932478875
1	2287	39.32692135430612	39.47042465209961	39.66803469146053	39.23046755307764	188923200	31.022190418590682	40.85167966570173	43.06165372459968
1	2288	39.051670252719774	37.757789611816406	39.23987179114396	37.663690637427194	346375200	17.12252567119151	40.572907311575754	43.27349160182562
1	2289	37.42845488124537	36.814449310302734	38.55295495528634	36.69917496844934	290954000	15.243569600060425	40.24187714712961	43.548156251051466
1	2290	36.42391989288778	38.35297775268555	38.51530154881326	36.22866109389691	272975200	24.866831746946332	39.97184181213379	43.22979095126007
1	2291	38.367093871237536	37.531951904296875	38.440021124272604	37.421387210423426	206434400	22.067876352421237	39.640474046979634	42.87848459766798
1	2292	37.70838522398941	36.49919509887695	37.875415031210935	36.47096612455897	217562000	20.030729780159078	39.24878065926688	42.59119090741323
1	2293	37.10153250918091	36.94563293457031	37.295222971103485	35.488216642647764	282690400	24.633171966244447	38.91350882393973	42.16329406798691
1	2294	37.439318826996704	38.43376541137695	38.71249173315674	37.205469418169905	243278000	35.01910266022364	38.68386050633022	41.53036219023967
1	2295	38.25423306280364	38.81877517700195	38.91562220350698	38.18336929696385	130196800	39.63539123306829	38.52909932817732	41.053991788863925
1	2296	38.51170952093217	39.53450012207031	39.57465542365955	38.47391862808923	162579600	46.55381769932853	38.47772026062012	40.87760954956933
1	2297	40.10612781166872	40.862003326416016	40.88562218357589	39.91952334169499	204588800	52.20269494128904	38.51444135393415	41.04952431650668
1	2298	40.71319585666641	40.72972869873047	41.29427461505424	40.57383268438632	160704400	55.548432562844276	38.60136795043945	41.35771314580021
1	2299	40.63997280331127	40.59273147583008	41.161995419044125	40.49115919767738	135722000	56.03841323457838	38.69514383588518	41.634203145951474
1	2300	40.824198700341945	40.408470153808594	41.12890819335388	40.3942945178921	149886400	54.660570286383745	38.768028259277344	41.8291829678204
1	2301	40.58091136981038	40.74625778198242	41.08876183668482	40.55965331773429	123967600	55.69445551149168	38.85915919712612	42.08207879890633
1	2302	41.02262609479968	41.454891204833984	41.4903212940656	40.99191761461115	135249600	68.12586568755837	39.123237882341655	42.55642070402602
1	2303	41.655674133314726	42.27454376220703	42.37375162303299	41.62260484637274	152648800	77.09797961324924	39.51324462890625	43.055415598939526
1	2304	42.30525740343109	42.13754653930664	42.63122509895776	42.083219190765924	155712400	71.81761644175427	39.78357097080776	43.516803927135584
1	2305	42.34304047857756	42.073760986328125	42.66428650479458	42.05722814603756	151128400	78.68769035043756	40.10798590523856	43.78732920726985
1	2306	42.172966872019295	41.33678436279297	42.46586881304559	40.78405336834091	195208000	81.74198518910103	40.45352799551828	43.53259264096337
1	2307	40.81712291560023	41.62260055541992	41.6438586082021	40.73444790462741	153816000	81.34884736562998	40.787597111293245	43.1612375804255
1	2308	41.386394514270094	41.766693115234375	41.98400608660226	41.2234088846737	113605600	77.24978089941958	41.02566337585449	43.02071087204443
1	2309	42.02415651599194	41.73125457763672	42.10446711699398	41.603702658650036	95154000	75.25588700548525	41.23369761875698	42.79843452354242
1	2310	41.32261782953467	41.343875885009766	41.53757000186826	41.16435740941671	126814000	66.63764624503573	41.36293874468122	42.58432843184121
1	2311	41.45015646402043	41.79502487182617	41.83754096913162	41.353313040953296	95096400	60.22771560137893	41.42958314078195	42.63494398253887
1	2312	42.035976645673514	42.513118743896484	42.51784395797975	41.90133507641775	128740800	67.32435515178196	41.55696814400809	42.81932052474365
1	2313	42.58633179543766	42.92411422729492	43.082374615489385	42.56743815279229	128828400	71.50302090355486	41.72349548339844	43.05131394606203
1	2314	43.12962712557874	42.51075744628906	43.344579310347164	42.3383249792126	126774000	68.60380487106676	41.87365886143276	43.02456275986446
1	2315	42.59342169290172	42.14934539794922	42.64066300838401	42.00053183011272	117473600	62.364666752277714	41.97387940543039	42.92970944575443
1	2316	42.16351782062633	42.19894790649414	42.57452483809978	42.06194917161769	90975200	57.41868542643844	42.027026312691824	42.94034633070663
1	2317	42.19893886982693	42.05012893676758	42.30995792081379	41.95564272088483	157618800	47.41690530950681	42.01099668230329	42.91341570257229
1	2318	41.88478790376434	41.40764236450195	41.920217986561596	41.0202578407007	133787200	42.47428892374544	41.95886066981724	42.912660771402216
1	2319	41.39347839355469	41.39347839355469	41.76196574354035	41.32261460987704	78597600	42.91340084594758	41.91026905604771	42.90719302759092
1	2320	41.34623658503554	40.455726623535156	41.358047817252476	40.45336221452255	148219600	41.190403900932665	41.84733636038644	43.08288646800146
1	2321	40.15573068947674	39.884090423583984	40.78877224323228	39.8250378784524	165963200	33.556695377084	41.7231570652553	43.34505905280688
1	2322	39.77543860267086	38.960514068603516	40.136839949120564	38.960514068603516	164115200	26.869077917577755	41.52271570478167	43.714811033944
1	2323	39.699852239719306	40.81003952026367	40.887989323088604	39.31482843905483	150164800	44.15468796973008	41.456914629255024	43.677168822627486
1	2324	41.02498382603324	39.76362228393555	41.3722130916181	39.428204248636995	163690400	40.74683128101485	41.34403937203543	43.74256827359057
1	2325	39.506155014654325	39.32427215576172	40.16045826236193	39.01956259085992	166674000	35.51249893193507	41.16755703517369	43.77742501718463
1	2326	39.63844130477136	39.63135528564453	40.569110262440624	39.42348911317113	153594000	32.24679181822583	40.96171678815569	43.569001374590165
1	2327	39.36207417239642	39.37152099609375	39.905358444189645	38.8494983851134	150347200	27.69876737384105	40.70796012878418	43.18054872750088
1	2328	39.598278747057826	39.77543640136719	39.86047221960695	38.94633987674078	121112000	32.80877638328539	40.5125800541469	42.79661170113343
1	2329	38.9463362867384	40.53602981567383	40.63051244755024	38.92035302233018	138422000	40.344926304100774	40.39734322684152	42.47951942317789
1	2330	40.765156880575056	40.81712341308594	41.154902270125014	40.64705178019245	107732800	41.95326796790344	40.29864147731236	42.128671746409864
1	2331	40.38486253740354	39.77307891845703	40.74153868032574	39.730559203645306	140021200	37.992107055651736	40.135995047433035	41.67746673987002
1	2332	40.12739001702959	40.167545318603516	40.88562274228827	40.12030399935664	116070800	43.28475922683551	40.04741668701172	41.40575293607223
1	2333	40.86436358915607	40.92341613769531	41.10057378331304	40.5171343154028	113634400	47.643835700256375	40.01384081159319	41.246250784082775
1	2334	40.68248045531927	40.732086181640625	41.08167625742983	40.55728934160527	89726400	51.4972772643513	40.0335807800293	41.304724373902175
1	2335	40.961211667118185	41.133644104003906	41.3367850202748	40.87381144216381	91557200	56.89701276765263	40.122834614345	41.518171255359924
1	2336	41.28482148562599	41.27301025390625	41.53520373924417	41.06514771362276	100497200	63.97371809559461	40.2880129132952	41.63738027221521
1	2337	41.343863758126446	41.53047180175781	41.617868407041804	41.29662244727783	86313600	55.39053299363435	40.33947236197336	41.82288777019723
1	2338	41.688736368022866	42.10210418701172	42.26745059375099	41.66983912092676	106421600	68.83563727312671	40.50650678362165	42.21947584836125
1	2339	42.00053574736755	42.00762176513672	42.23911035986843	41.780861987960016	83018000	72.88480558013639	40.69817461286272	42.441532158797656
1	2340	41.043883187422836	40.81712341308594	41.42890696804026	40.78405412915007	139235200	58.78848400474537	40.782872336251394	42.41460798239716
1	2341	40.297459369091705	39.144752502441406	40.44390853175316	39.07624952977101	261964400	48.61026300409117	40.7666745867048	42.4620234100561
1	2342	39.40695310035014	39.03137969970703	39.42821115602079	38.75973577265891	146062000	45.27171230678382	40.71352767944336	42.580679001972655
1	2343	39.132943351107706	38.48809051513672	39.28884294793459	38.08180868331723	134768000	36.616240057318905	40.56724630083357	42.78270356534978
1	2344	38.41249226292631	38.65578842163086	39.0738813835219	38.362890151343066	113528400	35.66267438300112	40.41286523001535	42.84403328342751
1	2345	38.766813331459566	38.790435791015625	39.14711186291193	38.58965569763296	111852000	42.58723155426584	40.3426764351981	42.90652924874641
1	2346	38.73846416046019	38.34163284301758	38.816413941589445	37.942437117362054	142623200	36.33785948419463	40.212254115513396	42.991225915973956
1	2347	38.29676670732224	39.036102294921875	39.5085227668142	38.22826372049985	169709600	35.74747212859735	40.07744598388672	42.890704718497275
1	2348	39.307735991363224	39.94314193725586	39.96676079212978	39.038456536688116	214277600	44.623295025292876	40.02109282357352	42.80935970118199
1	2349	41.39110958595013	41.70763397216797	41.98636025958866	41.05333075245407	266157600	53.29893525871345	40.06209209987095	42.936382493241155
1	2350	41.5446549865749	41.783226013183594	41.92731439273271	41.20451169030931	136272800	52.95405674262623	40.09853608267648	43.050844540088185
1	2351	42.104466390407026	43.42251968383789	43.52172753117809	42.08556914268297	224805200	59.443542168445305	40.233682359967915	43.61098810633888
1	2352	43.741400685804436	43.73667907714844	44.32956534880363	43.63983203547924	169805600	58.37366820658334	40.350437709263396	44.098638153541636
1	2353	43.69652102308314	43.946903228759766	43.9870585254927	43.384721865936356	113611200	59.818202254916244	40.48895781380789	44.62431928515894
1	2354	44.065014153534136	44.256343841552734	44.26579066380232	43.750854150580984	92844800	69.11763021971987	40.73461641584124	45.33627423950714
1	2355	44.3461046419575	44.88938522338867	44.967335022599265	44.32484298451341	111957200	86.10450332605612	41.14494732448033	46.1433105666349
1	2356	44.932069565541354	44.718658447265625	45.0672266840872	44.448340591993805	104848800	85.48819397697162	41.55118152073452	46.730747586623025
1	2357	44.818246903462736	44.614322662353516	44.941550858551565	44.545559152084344	83115200	90.44271152055258	41.98876953125	47.088097736116715
1	2358	44.28946733071471	44.20884704589844	44.35823445813676	43.89110572231908	94780800	85.54302883922803	42.385416575840544	47.22523883132759
1	2359	44.12111136303756	44.62143325805664	44.68783047454128	44.10451115437147	76732400	86.03973006529569	42.8019163949149	47.30063014716221
1	2360	44.57875102502518	44.33926010131836	44.79453201803069	44.18987270336385	69176000	87.84923302102091	43.23031834193638	46.97915544340865
1	2361	44.38668048532484	44.17801284790039	44.533694347230615	44.135332804706835	73190800	84.79046293127345	43.59759766714914	46.484861100435
1	2362	44.578750004066194	44.49101638793945	44.87989470069456	44.32028897080995	73603200	83.4609615846635	43.922445842197966	45.92695802502787
1	2363	44.668861774456545	44.379573822021484	44.787422292071575	44.2894666708165	60962800	75.97777380522335	44.11329868861607	45.667682226142006
1	2364	44.18751150145799	44.66412353515625	44.697320339222095	44.047607324584526	80233600	76.9157241060762	44.31907708304269	45.12933714819126
1	2365	44.76134016894479	44.614322662353516	44.77793676045254	44.154310879553606	92936000	65.83914665801427	44.40420586722238	45.04044300402647
1	2366	44.63330331798447	44.7162971496582	44.97001484337418	44.49577264679473	69844000	63.79735164949706	44.47417858668736	45.000078524184545
1	2367	44.48390884891369	44.5550422668457	44.75659659946628	44.31080788346593	90056400	58.685087929569185	44.517617089407786	44.94762886072224
1	2368	44.512364369858055	44.46019744873047	44.578757975260416	44.289470001072935	74762000	53.101418995386084	44.53217806134905	44.93715589539043
1	2369	44.3938115487541	44.31081771850586	44.63330255136815	44.13772033281809	109931200	39.678741752139544	44.490851811000276	44.854811368741615
1	2370	44.576390474122796	45.10991287231445	45.11465268854188	44.51948011577077	93770000	55.70148278020455	44.518798555646626	44.99947844770079
1	2371	45.441877269361875	45.48693084716797	45.86395244326104	45.37311375778101	105064800	61.77975798735453	44.5811277117048	45.288166849502396
1	2372	45.780964812721926	45.83787155151367	45.987258977202465	45.612607268042474	86264000	72.31961699480999	44.69748660496303	45.63818189756106
1	2373	45.91374824055148	45.99673843383789	46.0204519851654	45.50826966920264	83734400	70.25133294537676	44.79572268894741	45.962324119459126
1	2374	46.034672709402166	45.87343215942383	46.04889939108502	45.60785416801912	85388800	73.69945125918105	44.90530640738351	46.171201742397784
1	2375	45.33042660815007	45.45610046386719	45.527237496090784	44.99845861534631	106627200	68.29598337299686	44.996598379952566	46.220191421757626
1	2376	45.37311106754647	45.34465408325195	45.520124950045464	45.102793234917435	73234000	62.96828167486108	45.057572501046316	46.25748462508473
1	2377	45.382597967668204	45.59363555908203	45.67188594037212	45.32568761268084	67644400	67.70393297116162	45.14429119655064	46.308066767820975
1	2378	45.6268350337419	45.21898651123047	45.735912315977416	45.157336336685375	86553600	57.88406167882262	45.18392426627023	46.31457984463701
1	2379	45.4205318038614	45.24269104003906	45.425275237320285	45.105160415168235	86440400	58.99521086919721	45.228807721819194	46.31090622753925
1	2380	45.060109636410715	44.77793502807617	45.09093652853527	44.64040439467867	246876800	50.79933433328452	45.23321042742048	46.30679443914065
1	2381	44.55030624142613	44.75423049926758	44.86804759582226	44.38906203797509	73939600	52.678683189385396	45.24743815830776	46.28704892410989
1	2382	43.90058856562617	44.031005859375	44.18276317805186	43.49985343491606	134314000	45.06268299361761	45.21678161621094	46.37494612455393
1	2383	44.18750534480844	44.22307205200195	44.38905604920461	44.04048784598914	82514800	49.00041196828713	45.210514068603516	46.39054138330246
1	2384	44.40091217767496	43.97646713256836	44.66174675389447	43.853163185793704	102847600	35.22851785050241	45.12955365862165	46.48221445685791
1	2385	44.13295985429284	43.84841537475586	44.14007319491782	43.79624846471982	108801600	27.16440699772562	45.012516839163645	46.5079793837139
1	2386	43.48799651448149	43.19633865356445	43.848421501954974	42.85488378313482	126652400	16.03640508603928	44.82383591788156	46.52335735838385
1	2387	43.39078745577457	43.73223876953125	44.23019448163641	43.28408007590881	98276800	23.457529812073275	44.66208594185965	46.311030958231726
1	2388	43.92192669263943	43.668209075927734	44.40802552023664	43.63738218468829	101141200	23.788083241741305	44.50457000732422	46.074468358642285
1	2389	43.653986265640604	43.98595428466797	44.154311820290445	43.58284922779759	69460800	32.101689562608556	44.39955956595285	45.88994506772807
1	2390	44.17328333919839	43.89348220825195	44.38669447697594	43.37181656842981	90950800	32.2506895998268	44.29590443202427	45.70265172199425
1	2391	43.58758850631707	44.38431167602539	44.41276865935762	43.49273792550915	70925200	36.03492403317959	44.209524154663086	45.40577423505116
1	2392	44.52895479791347	43.611297607421875	44.566895029514164	43.52119046191513	55819200	32.998860797893286	44.09468923296247	45.176715572937965
1	2393	43.9290376998762	43.96223449707031	44.20172903656597	43.69666011951741	66416800	37.335785205161905	44.00322805132185	44.860336300629655
1	2394	43.96699195720508	44.571651458740234	44.68072513367025	43.91482502808875	69940800	48.0165320782178	43.988493510655	44.79375640465639
1	2395	44.93443770866442	45.190528869628906	45.214238803052666	44.88701422363692	79026400	53.76427817736964	44.01965767996652	44.97277339006039
1	2396	45.221350037638665	45.135986328125	45.35650713376391	45.095672571866736	63756400	60.77700837414745	44.098584856305806	45.223306215426845
1	2397	44.697325961852705	44.55031204223633	45.0008406709721	44.48628833413405	75326000	52.96403792464826	44.12195914132254	45.271160245598
1	2398	44.94154822423747	45.2972297668457	45.38733691545731	44.889381308533885	72164400	60.968905751618585	44.21629932948521	45.520452158175864
1	2399	45.30908979479504	45.368370056152344	45.489300486776436	45.26640612516418	50055600	62.743656908556495	44.32486752101353	45.74500370906816
1	2400	45.41342373740803	45.26877975463867	45.68136805899256	45.1525891395682	60172400	69.14995163850985	44.47289902823312	45.81627747841332
1	2401	44.993715044560524	45.396820068359375	45.49641046589699	44.863297755578024	62138000	66.63507593212998	44.59179769243513	45.9473900265498
1	2402	45.47507442692365	45.14784622192383	45.479817860987716	45.03639903958853	65573600	64.25971730409515	44.69748606000628	45.97113532618901
1	2403	44.979495033920074	45.4987907409668	45.657661419046526	44.979495033920074	81147200	64.4869665848646	44.805545806884766	46.075848977595435
1	2404	45.47507524569516	45.39445495605469	45.62920248284196	45.09331020571511	82704800	64.34077504936724	44.91275814601353	46.10225825455254
1	2405	45.214240402520566	45.43476486206055	45.51775867742959	44.94866598242779	63957600	60.981766845329254	44.98779051644461	46.16616965081998
1	2406	45.63393362348723	45.76435089111328	45.92085161226454	45.539086675129646	74791600	74.80883818981326	45.141580036708284	46.08458223988557
1	2407	45.77857994413519	46.19591522216797	46.2030285627545	45.629192555459426	66839600	75.26837174859794	45.301128659929546	46.13400298813922
1	2408	46.14612030350312	46.051273345947266	46.466235117068265	45.90899929143398	76304000	68.7050547059459	45.40681593758719	46.21611985598843
1	2409	46.236231341898154	45.28537368774414	46.28365482467212	45.07670963990276	96096000	51.15603469359478	45.413590567452566	46.216659161294054
1	2410	45.50351902349696	45.03165054321289	45.574656048025126	44.83246976907753	84118000	48.787171716902975	45.40613801138742	46.22213646368312
1	2411	45.12413484806782	45.121761322021484	45.56043669535862	44.89649705659699	157492000	57.50765289246258	45.446955817086355	46.12385610454982
1	2412	47.217908692811946	47.779884338378906	47.841534499496696	46.786346710448804	271742800	71.71297541224803	45.62428828648159	47.03512686164617
1	2413	47.56173902858806	49.17653274536133	49.411283879436986	47.50720220202986	249616000	77.03703984568942	45.89629990713937	48.24878434685031
1	2414	49.091167907492924	49.31880569458008	49.49664647199258	48.72362957720444	133789600	78.58098911559352	46.185587474278044	49.12781253753428
1	2415	49.32117272040691	49.574893951416016	49.61757399877474	49.10065190602749	101701600	78.96121588468579	46.4840213230678	49.892273875788064
1	2416	49.63416545511107	49.11012649536133	49.67684549494403	49.02713270478074	102349600	76.66759778831224	46.76704134259905	50.35086236276116
1	2417	48.8587927154922	49.14333724975586	49.2761244578669	48.495997801124524	90102000	75.62510058041606	47.02736609322684	50.74144821727574
1	2418	49.683973426975236	49.52984619140625	49.7432536896064	49.131480945071196	93970400	77.96656605525888	47.32275118146624	51.133920779190504
1	2419	49.34185363703656	49.38230514526367	49.7558924879173	49.17766575425853	98444800	76.3145260545401	47.604718344552175	51.39825487137963
1	2420	49.80586398285844	49.70116424560547	50.1961061475211	49.42276010656585	103563600	76.28060432463707	47.88591929844448	51.67544272567635
1	2421	50.00811822855561	49.91055679321289	50.103297814192906	49.556006119607346	82992000	75.55551706454995	48.1512508392334	51.95121104161079
1	2422	49.78445934158979	50.02717208862305	50.1461484270494	49.572681604425675	115230400	77.45876935074241	48.43524360656738	52.15252406737161
1	2423	50.38647575238874	50.76006317138672	50.87665765102423	50.319849298061754	114001600	87.98305320698049	48.826292855399	52.25698230717414
1	2424	50.78861876147969	51.77374267578125	51.861784002315645	50.721992303961294	141708000	92.31416019248955	49.307870864868164	52.31005492777312
1	2425	51.89748591399913	51.269290924072266	52.15447163776321	51.186006025774766	121150800	86.67517507630714	49.7469801221575	51.74057163311198
1	2426	51.58813338426221	51.169334411621094	51.68093476917806	50.92900355090803	104639200	79.10456659115297	49.98908369881766	51.76497792923874
1	2427	50.94566430392693	51.17171859741211	51.48343599095021	50.883794290579665	76072400	72.52604794751821	50.13159697396414	51.946399087647684
1	2428	51.07653379730228	51.27641677856445	51.64762232382829	51.064639069747564	75532800	72.29094959021307	50.271426337105886	52.11784890924642
1	2429	51.54054798819472	51.435848236083984	51.61193088202524	51.185997215068724	73905600	71.66728255346668	50.404351643153596	52.302002101372686
1	2430	51.671409472249394	51.85939407348633	52.04975689378709	51.476290213820995	82100400	82.32024625496214	50.60072789873396	52.490436054340734
1	2431	52.1140103272103	52.2781982421875	52.478077603520866	52.0925954593966	91107200	83.78986252727128	50.824646541050505	52.71337467644115
1	2432	52.385278811402436	53.058685302734375	53.18004348810578	52.20919615948251	109019200	85.05884172084936	51.07670647757394	53.15358636236168
1	2433	53.12293046357616	53.546485900878906	54.31507196328296	52.92066925358433	195175200	88.75100372808217	51.37414796011789	53.593563136640476
1	2434	53.89865929628041	54.16516876220703	54.46022775648587	53.777304738717625	173360400	89.34554326015268	51.693005425589426	54.14728918771977
1	2435	54.3507731772145	54.33887481689453	54.53399412883681	53.9272176920861	109560400	89.27809406384475	52.0093138558524	54.611040556892554
1	2436	54.48877602773721	53.98431396484375	54.650582079190634	53.563140408688696	133332000	83.67734399399527	52.29196684701102	54.82497554114472
1	2437	53.83202764631737	53.08723831176758	54.098537086543615	52.65892281039445	137160000	69.26704047671835	52.45819364275251	54.86020058307169
1	2438	52.78979114290166	52.65891647338867	53.62738176604703	52.518525296487866	150479200	58.11504299126605	52.521420342581614	54.89221516353302
1	2439	52.57563661638013	51.95220184326172	52.789796177152404	51.50960977470878	158066000	56.036867105361665	52.57019969395229	54.85661717635718
1	2440	51.876062511296325	53.265708923339844	53.37278690327242	51.53103185112702	142996000	65.25807726992053	52.71994073050363	54.88237790213266
1	2441	53.52507412606366	52.60419845581055	53.5393507053126	52.31151405772873	197114800	59.51327545725112	52.82226072038923	54.79650023279929
1	2442	53.187172096099665	53.874855041503906	54.33648371788918	52.9611178270807	166825600	64.9424755329618	53.00786345345633	54.8394927776653
1	2443	53.71781136103574	53.26332092285156	53.97717888113775	52.94922530925769	127997200	59.98956546544405	53.138397216796875	54.73250118281529
1	2444	52.86118624665085	51.845130920410156	53.05154911623781	51.699979640822946	148780400	49.92967963327336	53.13737842014858	54.73501786811932
1	2445	51.82370453873131	51.9307861328125	52.78979531956475	51.66427670357226	126286800	48.22900777609332	53.11256326947893	54.77708183275864
1	2446	51.99265451961192	51.96171951293945	52.25916032826904	51.23120675854204	108495200	43.94533594023387	53.034208570207866	54.809258536696724
1	2447	52.40668780518916	52.35671615600586	52.892109566016174	52.1473166826571	106435200	43.36513649833326	52.949225017002654	54.732529192605284
1	2448	52.53518143044649	51.79277038574219	52.67319439173339	51.70472544353477	384986800	36.68883232607577	52.779767990112305	54.515581994773896
1	2449	51.59289465595645	52.53756332397461	52.64940135851377	51.54768307209561	110773600	40.50181172465648	52.65110288347517	54.13833018581585
1	2450	52.29009577879089	52.87070083618164	53.02061217025842	52.27819741990285	98217600	44.114700115356534	52.57155908857073	53.8570625060008
1	2451	52.58753690177076	52.44952392578125	53.241906704847096	52.29247430163428	95938800	46.451256547236696	52.526008061000276	53.77754322192757
1	2452	53.25856652260138	53.52745056152344	53.882001334823016	53.19193643687781	120724800	54.507333292948054	52.58804621015276	53.94926128165074
1	2453	53.48937329667436	53.715431213378906	53.7392242992794	53.30615237485064	91717600	59.67112889119509	52.71399116516113	54.14621107449407
1	2454	54.241309655604006	54.07712173461914	54.59110036617102	53.860587567353	94403200	54.96937870092054	52.77194922310965	54.35777874418359
1	2455	54.07473764888599	54.55778121948242	54.72910741141377	53.92720817339423	99152800	62.2354699613144	52.91149084908621	54.75637809694158
1	2456	54.741010480140964	55.221675872802734	55.554808146408234	54.67676224492081	114619200	59.12911404973551	53.00769233703613	55.18032259124036
1	2457	54.91469866184158	54.25081253051758	55.28828597253746	53.95098994209454	128168000	56.38257216191094	53.07822745186942	55.34853046298647
1	2458	54.2436889154664	53.370399475097656	54.350766884208504	52.48759715696606	134322000	60.594987625402105	53.18717520577567	55.346239039909236
1	2459	52.87546039840959	53.246665954589844	53.49175689567986	52.39717324413406	118655600	59.09240913653348	53.28116662161691	55.31559364876458
1	2460	53.215727958701756	53.98431396484375	54.079497198818515	52.88497393623633	107564000	62.732155301216565	53.425637653895784	55.3401709389716
1	2461	53.648819122890245	51.48344802856445	53.86059688769502	51.409683270051694	167962400	45.65483290271784	53.36326135907854	55.47460133941382
1	2462	51.04561198333359	51.028953552246094	52.23061536075172	50.5221167924522	212497600	46.15758377783799	53.308703013828826	55.62444095057819
1	2463	52.44952870586217	52.85166931152344	53.03489388972673	51.59765768524352	161351600	51.42552542456217	53.3311391557966	55.620631083329236
1	2464	52.62561059502563	51.72138977050781	52.785038439818784	51.69997490274516	123164000	45.13594994477018	53.249045508248464	55.68724797854307
1	2465	52.09497529344284	52.861183166503906	53.06106616490166	51.57861844522682	116736000	51.64230666212136	53.27844973972866	55.684838645678006
1	2466	52.89687907280801	52.63275146484375	52.97778210890204	52.192537574613446	91541600	46.171088074442906	53.21454266139439	55.63989255458983
1	2467	51.840370353809476	51.40253829956055	52.28772254842495	50.6839201984137	130325200	40.912509573691565	53.04933602469308	55.637350532191874
1	2468	51.887964858052776	52.18540573120117	52.64941276713867	51.73805349610757	132314800	42.805452919503225	52.914213453020366	55.46838534055937
1	2469	52.29962155267364	52.5042610168457	53.14911442177731	52.09736393922277	115168400	42.09276377675636	52.767533438546316	55.144853599178674
1	2470	51.357319495941546	52.99919128417969	53.12292767547591	51.08843184683703	155071200	41.32932896583439	52.60878453935896	54.53399377976777
1	2471	52.96825515417708	51.18122863769531	53.35611545937305	51.05035396931127	163702000	38.76696911852858	52.38952854701451	54.20523224861566
1	2472	51.804670367492854	52.3019905090332	52.677956112421384	51.57623423764682	119423200	46.15778439737561	52.313213620867046	54.03890673541738
1	2473	51.37397112782754	51.469154357910156	52.39478993910838	50.6053851531139	189033600	43.917903629177516	52.1862485068185	53.87730872734259
1	2474	52.15684099276677	50.50307083129883	52.275817315618696	49.03965988169859	183742000	38.271606524914645	51.937588282993865	53.50929741393535
1	2475	50.24370203848112	50.75530242919922	51.202650955058886	49.79635351262146	146640000	47.108802476312746	51.885577883039204	53.56642579181961
1	2476	51.60717429726237	52.07831954956055	52.45666340927167	51.54530428162469	153435600	53.89780699206368	51.96053259713309	53.568852377626946
1	2477	52.12353243080215	52.87784194946289	52.91115517760701	51.59051714962672	233292800	50.10521421466889	51.962402071271626	53.57523842170265
1	2478	49.86298231424705	49.370418548583984	50.83858607469501	48.88261485292522	365314800	42.06553379621464	51.79447555541992	53.92264087575735
1	2479	48.613729191555535	47.968875885009766	48.63514405955893	47.15507822305573	264654800	33.775249154850854	51.4450250353132	54.30091035871606
1	2480	48.04740359256495	48.48761749267578	48.71367180724499	47.99267549408117	127531600	36.51286229347696	51.1489440373012	54.31683744483493
1	2481	49.011109827209225	49.958160400390625	49.984335338309	48.57327780281947	133697600	45.37275456968518	51.04577418736049	54.27163948350516
1	2482	50.139631995659315	49.78384780883789	50.17306145570035	49.3683642538669	101450400	41.994147263517604	50.87423433576311	54.09445447603155
1	2483	49.08181857886373	48.82393264770508	49.19165665626958	48.29383439646851	137463200	38.2341118753058	50.611353737967356	53.85913029349517
1	2484	47.517801003919416	46.364479064941406	47.720767943009726	46.27374038955446	204542000	31.156040229917437	50.137445722307476	53.79472944919307
1	2485	45.75796992879385	45.90123748779297	47.083212156341354	45.71498711061749	187531600	33.75349962509466	49.76030349731445	53.99698484235356
1	2486	46.300005075355834	44.60464859008789	46.43849960122923	44.39690497950876	243204000	26.568859830639084	49.21049336024693	53.98943117929021
1	2487	44.98430755896231	45.7054328918457	45.83915072447835	44.628519748642276	185915200	32.736527596076385	48.79879896981375	53.730183836737446
1	2488	45.488139007624426	46.21165084838867	46.55549878133359	45.23980641357401	147713200	36.78223880302402	48.492268971034456	53.500221205871306
1	2489	45.368756804409266	44.38019561767578	45.53590412708626	44.17245563402997	167701200	32.10522393365639	48.036904198782786	53.310743288686666
1	2490	42.59171191338846	42.259803771972656	43.331940486046875	41.90879255810015	271300800	23.620513125354222	47.33558164324079	52.89779995147068
1	2491	42.916456516777565	42.2120475769043	43.04540134395021	42.15712852123961	124496800	20.13782440706582	46.573739188058035	51.7760369853498
1	2492	41.77269251013745	41.139915466308594	42.16907310677213	41.09454976349861	94496000	23.317570547309757	45.985846110752654	51.665067393144
1	2493	41.60553496210182	41.69626998901367	41.77506878542465	40.65517637038494	179994000	28.48589011766566	45.537802832467214	51.52449857003682
1	2494	40.95365741769056	41.60553741455078	41.732092071039055	40.80322665525515	165549600	25.681488666613106	45.046225684029714	51.119114757317725
1	2495	42.2001018511923	43.205379486083984	43.288951316851275	41.770291892764284	184250000	26.35444903973898	44.56388419015067	49.9949743526008
1	2496	43.61608138833409	42.87346649169922	43.64951084552669	42.43171670979778	167080000	26.06674831517381	44.07028552464077	48.646577035146734
1	2497	43.05016237371215	42.641845703125	43.059715728969586	42.27173152295516	158126000	27.45160350478922	43.62870788574219	47.34049165602302
1	2498	44.0459006402895	44.13186264038086	44.16051542589853	43.269856121853635	163210000	41.237114328193286	43.469235283987864	46.85195292488071
1	2499	43.207757800635115	42.19054412841797	43.55160570209931	42.0902557644138	165377200	36.94991647289702	43.20418575831822	46.33841020714307
1	2500	41.01336223299014	41.72016143798828	41.73448783343773	40.6933939228223	172393600	39.22968912777619	42.998150961739675	46.11498647366437
1	2501	41.4264587958567	40.2325439453125	41.66524176596554	40.187174598025585	169126400	30.138672196757526	42.60723032270159	45.632884642432884
1	2502	39.39918239074626	40.49758529663086	40.61458659732071	39.00041534559179	248104000	28.89397643870761	42.199082783290315	44.60925170288588
1	2503	40.9894803391945	40.265968322753906	41.02051964377646	39.87675096477023	189126800	32.76653295597774	41.905209405081614	44.16860288632484
1	2504	40.68860778026071	40.37819290161133	41.05155883590484	40.35908983094183	142510800	40.52426024363021	41.77080862862723	44.16328015022704
1	2505	40.710096754530625	40.8199348449707	41.20676560938166	40.48564025206029	127594400	43.25693755644871	41.67137200491769	44.10028642488756
1	2506	40.354314683671035	39.513797760009766	40.37341775506542	39.46604190329297	162814800	42.29807045685404	41.55522074018206	44.23606945970591
1	2507	39.50663328429984	39.14607238769531	40.199105936652565	38.8571434520771	177151600	37.701511944371575	41.37306376865932	44.34354167152091
1	2508	39.48991376028072	39.6546745300293	40.003295493564984	39.25351739800612	135366000	40.956337426916924	41.233716419764924	44.33726880944828
1	2509	39.63796263251621	38.417781829833984	39.98419711957457	37.98797186776174	196189200	27.033167806614813	40.891745158604216	44.11230092643972
1	2510	38.30077924811226	37.448326110839844	38.70909964806742	37.08298853150335	259092000	25.4749232259186	40.50423513139997	43.99208446761936
1	2511	37.455477377973416	35.991737365722656	37.765895806552706	35.72907842118409	382978400	22.934830062343707	40.02922739301409	44.03579724503162
1	2512	35.3756888500166	35.06049728393555	36.187552980420826	35.0031880703125	148676800	11.321369110627217	39.381272724696565	43.463119434412704
1	2513	35.4115071975042	37.529510498046875	37.54383689005129	35.03422975272265	234330000	30.98201772763298	39.04834175109863	42.89681800840896
1	2514	37.21193139548215	37.285953521728516	37.43400141775967	35.8341564957452	212468400	31.566307476390975	38.73161261422293	42.35622717710529
1	2515	37.60831287824056	37.305057525634766	37.85187249611899	36.903903937165346	169165600	36.13740501589076	38.52250644138881	42.11172358121318
1	2516	37.85424813144179	37.665611267089844	38.05243835098526	37.364742518693454	140014000	36.70990450773201	38.320222582135884	41.7454021582903
1	2517	36.98507589456792	37.708587646484375	37.930657594048284	36.827478337398325	148158800	37.782216471360094	38.13755253383091	41.383830550487964
1	2518	34.37996114189787	33.95254135131836	34.7954447022313	33.90717201706185	365248800	27.229560425180793	37.6785774230957	41.34942634326649
1	2519	34.511295373347224	35.401954650878906	35.471203738536325	34.33698486073971	234428400	32.08020568718298	37.291578837803435	40.66624975999781
1	2520	35.50702214658344	35.323158264160156	35.53806509445111	34.83842919157571	219111200	34.914866673386115	36.99224744524275	40.25953731809817
1	2521	35.71237255601833	35.996524810791016	36.25202428139777	35.464039924991226	164101200	38.90661122357202	36.76727976117815	39.82258034444743
1	2522	36.1254684279678	36.607810974121094	36.89912644465085	35.7290915272066	180396400	39.345357024991394	36.54964665004185	39.11351294464067
1	2523	36.4143930484411	36.72481155395508	36.76540421062059	36.0227892295961	143122800	43.57672207623491	36.42872020176479	38.762394263441905
1	2524	36.50514253743208	36.3642578125	36.70094268311509	36.17800738269997	108092800	45.68770185777437	36.35128675188337	38.60996087463302
1	2525	36.02040314758041	35.81743621826172	36.12069153176698	35.6311858414098	129756800	49.252550606439726	36.338836669921875	38.60794555256003
1	2526	35.88190613728261	36.550498962402344	36.62690759306695	35.82937360965292	114843600	56.499999833587225	36.445265361240935	38.592596409897936
1	2527	36.55288817925866	36.99702453613281	37.22148105375733	36.533785109297206	122278800	47.179349772105816	36.40723064967564	38.4897178664525
1	2528	36.820321034372775	37.21670150756836	37.646511439735995	36.595864534044246	119284800	49.63223228560524	36.40228407723563	38.4760909742568
1	2529	37.608312573292196	37.44594192504883	37.699051255274355	37.245361488902034	135004000	50.731842645508515	36.412347248622346	38.506294420113875
1	2530	37.34804190501373	36.60542678833008	37.42445055400755	36.44305248846791	121576000	44.7543052405042	36.33661978585379	38.30844610745102
1	2531	36.80838279224685	36.75346374511719	37.04477917629914	36.223365412542684	92522400	45.32276262992326	36.26839665004185	38.09660497148226
1	2532	36.798835360009605	36.46215057373047	36.88718387306824	36.23292101456802	101766000	68.60179797672481	36.44765445164272	37.69875995695576
1	2533	37.12596633203503	37.67039108276367	37.75874323827236	36.84898092175312	134142000	67.43760919453945	36.609685625348774	37.86496991198073
1	2534	37.19998809789302	37.32176971435547	37.32893291020172	36.69138297511868	104768400	64.75150802553395	36.75244358607701	37.81766208799222
1	2535	37.3098235648175	36.934932708740234	37.75873652788137	36.798828367015254	166348800	57.23217225645609	36.81947272164481	37.79403098836782
1	2536	38.981315491599865	39.45888137817383	39.67378456971669	38.26018998268238	244439200	66.96986031143723	37.02312060764858	38.72631175728832
1	2537	39.66422793862977	39.74302673339844	40.354310378653395	39.29411371236649	162958400	67.61424782350645	37.23870740618025	39.463463848735515
1	2538	39.86719197468865	39.76212692260742	40.349530777734046	39.62124225175069	130672400	70.65301316673614	37.48141234261649	40.015142542014324
1	2539	39.97464186721923	40.89156723022461	40.98946908315181	39.943598927623405	125982000	78.80180100980924	37.84385027204241	40.77304525876592
1	2540	41.27601783553029	41.591209411621094	41.80611623687875	41.1542398516945	144406400	78.72106792419366	38.20390101841518	41.64307028213373
1	2541	41.70343564294899	41.60553741455078	41.9231191363072	41.273629300518444	112958400	77.61875368640523	38.533080509730745	42.337457680332435
1	2542	41.166175509900825	40.81755447387695	41.533903261011226	40.674283259034766	126966800	70.2036498937531	38.7902842930385	42.69680716135042
1	2543	40.52497977201644	40.86550521850586	40.925456958926475	40.38828804745879	95280000	69.58489764671337	39.034538813999724	43.00605411036393
1	2544	41.01899449714538	40.6305046081543	41.05736450134585	40.587341097802515	83973600	74.77096570025898	39.322044372558594	43.114803628789424
1	2545	40.791167808753904	40.980613708496094	41.006992622046425	40.69524282349631	89134000	75.3832261918724	39.623983655657085	43.2029060200678
1	2546	41.10052039709488	40.81035232543945	41.361909141349344	40.74800382453859	89960800	76.49530392352389	39.93456949506487	43.05709408932725
1	2547	40.69764522936157	40.95903396606445	41.06934313056098	40.618508484832724	87342800	73.01021622873932	40.169472558157786	43.04314781247623
1	2548	41.06694872677035	40.8679084777832	41.17486114487642	40.70723822697382	98507200	75.7393566150716	40.42276818411691	42.79690514977701
1	2549	40.697654081210246	40.99021530151367	41.11251923291614	40.644896240049384	75891200	80.61041850950906	40.712431226457866	41.98957286819479
1	2550	41.052568393634445	41.254005432128906	41.563358567613	41.004607716730774	104457600	70.56805258221215	40.840654373168945	41.920936950961995
1	2551	41.198839860520806	41.02138137817383	41.33552793623831	40.83912939082912	68998800	64.82204068273394	40.93196541922433	41.80971286328011
1	2552	41.14609567160384	41.479427337646484	41.486621256691876	41.09813499157946	75652800	68.07194092115596	41.05462973458426	41.66843823260882
1	2553	41.764785848199864	41.78157043457031	42.174853747958	41.71442477076004	87493600	61.340532406034704	41.11820139203753	41.83497777749427
1	2554	41.65687427188089	41.8055534362793	42.0381665117077	41.52737644681543	68280800	53.29929268576247	41.13351167951311	41.901161807036
1	2555	41.53696654893415	41.93504333496094	41.966219411742124	41.42185656966391	111341600	54.89826702354489	41.15704781668527	42.0032286007942
1	2556	41.80317195566177	41.5225944519043	41.944657254708254	41.46743984805265	112861600	61.79801245027296	41.20740781511579	42.05046708642498
1	2557	41.79356653922759	41.95903396606445	42.00219747263163	41.460234932688365	103544800	66.19347068632811	41.285517011369976	42.19233967611757
1	2558	42.131693020048765	42.17006301879883	42.62569486167129	41.71922468139676	109744800	72.96149889853805	41.39548546927316	42.33301764699313
1	2559	42.19165215010734	42.09333038330078	42.20603998736388	41.85592009107241	78949600	68.06885307643515	41.47496523175921	42.44894546974577
1	2560	41.88707812866738	41.85110855102539	42.083721577546385	41.71202008553712	83241600	66.51437232455885	41.5493049621582	42.4616941895122
1	2561	41.69524126203488	41.36670684814453	41.83193300627982	41.25160051452441	99185600	55.845975937569406	41.57842445373535	42.433909350419654
1	2562	40.843927639508614	41.46502685546875	41.50339685145408	40.647284154456955	95997600	58.54496820154489	41.621075766427175	42.37780659105216
1	2563	42.08372736573313	42.901466369628906	42.954224196869156	42.05015453559516	128044000	69.87528730570914	41.75759369986398	42.692651103700435
1	2564	43.1652662363853	43.38349151611328	43.805550579791884	43.014186633625165	129870400	71.18324926800169	41.90969984872	43.138534790472264
1	2565	43.70482298869039	43.5753288269043	43.95662105461445	43.385879259741806	124130000	75.61345867503638	42.09212466648647	43.498365871386454
1	2566	44.100512545676644	44.05974578857422	44.14847688030536	43.77917199498815	94318000	75.74177206326155	42.27643312726702	43.98140160448241
1	2567	44.32832888529776	44.63288116455078	44.92304926730803	44.06214294808447	156171600	76.98612015718261	42.48009817940848	44.56850779302293
1	2568	44.5561405967047	45.0885124206543	45.17723983825777	44.55374018487907	104879200	78.7244666364049	42.71459524972098	45.179967607362805
1	2569	45.16765168539396	44.731201171875	45.321128025047585	44.58491874977041	126585600	73.52721404168287	42.91432080950056	45.554497485941845
1	2570	44.65925993847138	45.12208938598633	45.4410331590325	44.29954941146415	124140800	80.39687908717809	43.17142759050642	45.92634583004822
1	2571	45.568127397516854	46.7839469909668	47.08130898978615	45.51776631722706	204136800	83.75836604663527	43.5160642351423	46.7781387722746
1	2572	46.84389095116453	45.815120697021484	47.4074387739936	45.75037179289214	169630800	73.05817862758555	43.77642549787249	47.155482396319194
1	2573	45.925432114679325	45.26116943359375	46.03814168480282	44.747982657374365	175381200	68.89833771638772	44.00269971575056	47.31994778912763
1	2574	45.96141117952851	44.793548583984375	46.25397601659863	44.263577155260194	199202000	67.09396614196088	44.21287400381906	47.3083352066476
1	2575	45.2635835211637	45.19643783569336	45.50578733952707	44.73600870996866	119393600	72.46136932017252	44.4864262172154	47.14437274293657
1	2576	45.311528940940846	45.25637435913086	45.45781134769583	44.97100346241505	83121600	72.3368191104189	44.757236753191265	46.78757877233036
1	2577	45.522562527189734	45.55133819580078	45.582514276239	45.21320945296346	94256000	68.03789513919328	44.94651331220354	46.70785834774896
1	2578	45.9566085822765	45.860687255859375	45.96619925125259	45.174839160401184	111448000	67.26842805614973	45.12345586504255	46.696003881911466
1	2579	45.82472629505906	46.52736282348633	46.63287850632169	45.815135623512674	91062800	69.30076508903426	45.33431543622698	46.8007335119397
1	2580	46.34269451420969	46.846290588378906	47.122067125703516	46.31871235480591	93087200	68.62174663191513	45.53335435049875	47.010946116125844
1	2581	46.71200885353243	46.92783737182617	47.09090439264983	46.31632872540781	76457200	66.41511390270588	45.69727979387556	47.25174540656498
1	2582	47.110086917517314	47.241981506347656	47.26596367128576	46.98538624633548	74106400	65.72130366855205	45.85109901428223	47.56416568308628
1	2583	47.10289041884987	47.985382080078125	48.016554501792015	47.083705419783556	103526800	72.48922549016507	46.08354050772531	48.011634660032335
1	2584	48.03813517588497	47.84149169921875	48.64484653226975	47.77674279115011	143072800	69.45771422114281	46.27778353009905	48.33240737014891
1	2585	47.64485453853999	48.11008071899414	48.13886004815311	47.524951034677144	86781200	61.851672553217604	46.37250736781529	48.63900600373949
1	2586	48.16523785563666	47.70960235595703	48.20120744230095	47.58730210213398	83603200	68.84545066107279	46.50782748631069	48.85572892838848
1	2587	47.76955499470552	47.6904182434082	47.99497416643162	47.05253438665943	111042800	77.04215483525769	46.68134525844029	48.99111917994472
1	2588	47.62087556739558	47.77674865722656	47.925431488793826	47.484183817930194	70146400	86.28927175329376	46.89443097795759	48.99493535587885
1	2589	47.83190862936642	47.78154754638672	48.289937245207305	47.61608012123653	102785600	84.81896139795609	47.07908167157854	48.98177922053004
1	2590	47.85109180616036	48.71200180053711	48.77195355634571	47.62807303095146	115627200	87.70269100401553	47.32591220310756	49.102429991594434
1	2591	48.70959594868468	48.887054443359375	48.95659686229854	48.565713946311256	96783200	87.37227562650547	47.564177649361746	49.20503263177142
1	2592	48.640054507160215	49.047725677490234	49.14604742621135	48.52254775923759	77758000	86.93708789338304	47.79182325090681	49.292985512478175
1	2593	49.0237378402406	49.755149841308594	49.81989874872485	48.896640437008266	93292000	87.05931715674981	48.022379466465544	49.671196404496406
1	2594	49.72639314576749	49.67843246459961	49.99497588763996	49.65205354108246	70162400	84.4318092225783	48.22467531476702	49.94530464053985
1	2595	49.599286452198484	49.22758483886719	49.82230522469842	49.18921483741621	74172800	75.65546737025768	48.38894299098423	50.01262369474988
1	2596	49.136454794659564	48.99257278442383	49.16043695928114	48.469791600822965	74596400	69.88020076573778	48.51398522513254	50.022734302102194
1	2597	49.01654871064956	49.06690979003906	49.39304745224257	48.88705454233487	88818800	64.48298409260414	48.59123720441546	50.094137621747656
1	2598	48.69521661712845	48.12207794189453	48.776750131959886	47.747979547571475	186139600	53.09374873817247	48.6112790788923	50.078162224167144
1	2599	50.330696480855615	50.48417282104492	51.63284679007926	50.17481972869853	259309200	67.90893164636223	48.78085708618164	50.52151234668993
1	2600	50.321091778073225	50.15562438964844	50.994948752481804	49.91102392422067	127985200	68.65396789193667	48.95557294573103	50.723853465710256
1	2601	50.57290627265106	50.77914047241211	50.800722227707276	50.41463274882316	83569600	71.56737083124236	49.17619596208845	51.033032882151176
1	2602	48.99017263863798	49.994964599609375	50.0812952698857	48.800726710090686	129772400	64.113513529257	49.33463995797293	51.05026563035179
1	2603	49.37146933782379	48.64725112915039	49.74077053028315	48.16044318223528	155054800	54.70419648346601	49.39647592817034	50.92294323712283
1	2604	48.41702667424918	48.65683364868164	49.2419632517631	48.38105709174992	105358000	49.66688011646066	49.39253534589495	50.92687874570867
1	2605	48.05731991188156	48.13405990600586	48.36427257005011	47.16044410033082	139634400	45.63645664177399	49.33875002179827	50.997195156210914
1	2606	47.525012204317946	47.46723556518555	47.869258710107935	46.40561691138866	164834800	41.34869168370551	49.22585787091936	51.16162463386013
1	2607	45.18753212621101	44.70847702026367	45.613622545249015	44.01758153296199	229722400	27.44147628819009	48.86538124084473	51.92809744457775
1	2608	44.87457793870742	45.416221618652344	45.66657974781634	44.63384741428745	146118800	31.965401348681098	48.56093760899135	52.087705409126485
1	2609	44.84086704811829	45.960262298583984	46.16006903559129	44.78068442877593	106178800	36.28322779083335	48.32755742754255	52.08891402982507
1	2610	45.71712146009069	45.7580451965332	46.33339083541016	45.459538110813675	132125600	36.38341224707935	48.09651974269322	52.07311323097584
1	2611	44.99975203445906	45.49806594848633	45.955452443745415	44.95882828894691	131516400	35.20723447761378	47.84160232543945	52.0034715829094
1	2612	44.17886392909346	44.075347900390625	44.378670691851724	43.398895759522695	154449200	33.865597393250596	47.55255017961775	52.16791068386726
1	2613	44.5881017219555	44.920310974121094	45.257332191350116	44.462920838446536	113459200	24.76376057657403	47.15513147626604	51.63939919149514
1	2614	44.45329935211288	44.00072479248047	44.70606713644494	43.94535780058596	118994400	23.503594447524478	46.71549579075405	51.13901841629878
1	2615	43.28333590533527	43.2496337890625	43.46147408852485	42.80428098457819	146118800	17.938176281188078	46.177673884800505	50.29308593226938
1	2616	43.37963938403598	43.08354187011719	43.84665718502143	42.99928471800924	94858800	18.934869442600288	45.68400083269392	49.47199662552421
1	2617	43.07150396814584	42.905399322509766	43.473523493613335	42.82836746661339	111792800	21.159556024948685	45.273868560791016	48.92052434036124
1	2618	42.469664673616755	42.700767517089844	43.17500678768408	42.368558327489495	113924800	20.658509001757835	44.84843526567732	48.170219173464915
1	2619	42.83799169611666	42.92224884033203	43.14612644193802	42.5298569502953	84873600	23.5394599996514	44.47616304670061	47.349700639733584
1	2620	42.42393606269451	42.144691467285156	42.84762410432637	42.12543258600589	108174400	23.27772740801005	44.09598132542202	46.6561297831625
1	2621	42.272274445071616	41.71859359741211	42.830767257665364	40.98918052500502	161584400	30.397659063625454	43.88241822378976	46.70757788240789
1	2622	42.233767346885564	43.244834899902344	43.290574291113145	42.01229568656811	123872000	37.14370637520531	43.72731917245047	46.42530375841657
1	2623	44.36181596269383	43.94294357299805	44.53273623283436	43.60592234445378	119093600	38.26991258797099	43.58322497776577	45.96436353188639
1	2624	44.07293734575599	44.58810043334961	44.648283054205194	43.849056086080246	90105200	43.53038857242183	43.49965749468122	45.6198229456494
1	2625	44.89864722693939	45.774906158447266	46.20100020037533	44.72050899594306	122737600	51.388550865060374	43.51943179539272	45.72339506574671
1	2626	46.174522631777265	46.359886169433594	47.03152273568553	46.128783243098496	104883600	62.5098804321488	43.68261310032436	46.35285193808795
1	2627	46.908750517806325	46.89671325683594	47.18318317095201	46.605431376936764	107731600	61.20053924951272	43.82378469194685	46.9465350648924
1	2628	46.68969038547058	46.747467041015625	47.175967134852	46.554881862455545	73012800	67.05529953043815	44.019980566842214	47.51372501298695
1	2629	46.87024129340717	46.73783874511719	47.37336730365211	46.6054398700842	86698400	73.85587732855248	44.26913806370327	48.01467981695665
1	2630	46.111933252432934	46.39840316772461	46.603021912035565	45.81102009322005	75046000	72.1453127588272	44.50591387067522	48.346497657334986
1	2631	46.436911234747264	46.675235748291016	46.932819142316106	46.26117900108184	58676400	74.85705633132547	44.77518790108817	48.66074157766602
1	2632	47.19522408292102	47.77297592163086	48.215919242858845	46.993011306698236	106204000	79.92051194233584	45.13748850141253	49.134133744641105
1	2633	48.06907590790761	47.63335418701172	48.117224957962435	47.498545662674516	84496800	78.06140394726677	45.473996026175364	49.46049436493907
1	2634	48.235175272565044	48.01611328125	48.2929519223193	47.671866712172545	86056000	86.69876624689559	45.89338329860142	49.59640663632125
1	2635	47.857225001391846	47.85240936279297	48.35072326998076	47.70074796960434	191202400	89.63904998986801	46.33151299612863	49.28170194465734
1	2636	47.79462897746255	47.80426025390625	48.18461486180703	47.70555987326467	72881600	86.42298254830999	46.65718623570034	49.10311020420304
1	2637	47.76815571901128	47.07966995239258	47.9679624930692	47.0122620268344	84281200	74.95217576015051	46.8812381199428	48.766554497978554
1	2638	47.60927495970345	48.097957611083984	48.38442751153247	47.50816858423742	104270000	76.35578975591145	47.13194220406668	48.58837074819476
1	2639	48.215910188824644	48.08351135253906	48.52404860796482	48.042587608363675	83598800	71.03992735297983	47.29684257507324	48.606815622440266
1	2640	47.82833196271638	47.64537811279297	48.02573272756639	47.43594376205445	124442400	62.037791171200524	47.38866342817034	48.591563801151814
1	2641	48.90921978910782	48.51923751831055	49.22698584179914	48.30257784422385	109012000	64.29175769786222	47.50455801827567	48.81143818661402
1	2642	48.48552898336706	48.80329132080078	48.899585720974464	48.47349172418838	67740800	67.68834081011855	47.651402609688894	49.05057005814296
1	2643	48.93569507350228	49.20772171020508	49.214943331245344	48.793664962035955	45448000	69.89901510685812	47.827822821480886	49.34837120088185
1	2644	48.95255021498181	49.164390563964844	49.36901296483268	48.84421854790117	69062000	73.4011508757435	48.02539334978376	49.462368180500725
1	2645	48.34108870781387	48.15091323852539	48.48311881415324	47.763337005913115	101354400	61.101022634791164	48.130798884800505	49.33951075816006
1	2646	47.95351450764578	48.44460678100586	48.50960137077678	47.85962976027634	82312000	55.74776734705071	48.178772517613005	49.37959490595516
1	2647	48.59145846276167	48.92366409301758	49.04402935681114	48.521644552737854	71588400	60.43606959786297	48.27093751089914	49.48937001299678
1	2648	48.942914150703736	48.56737518310547	49.2029035144077	48.55774757997081	80767200	54.47779785675509	48.31031336103167	49.52890160176843
1	2649	48.73589500597754	48.94051742553711	49.109028061685734	48.675712373549	70380800	58.54766857792873	48.388035365513396	49.61954755391469
1	2650	49.13068225444212	49.40030288696289	49.55918221038383	49.109017393055936	67789600	61.77617131801317	48.50203841073172	49.794735152094304
1	2651	49.25105023857042	49.22938537597656	49.61696161315287	48.98865488514049	67467200	67.27260578545783	48.65558951241629	49.70904846224169
1	2652	49.12105194156235	48.95254135131836	49.37141000803122	48.93328247339685	56430000	57.795219258809745	48.71663120814732	49.729142637634816
1	2653	49.1090191713482	49.50863265991211	49.56159366072206	49.03679929085684	74162400	61.830452568557895	48.81842558724539	49.84322414045514
1	2654	49.53992916901317	48.76959228515625	49.710849444352306	48.71422529733766	83717200	58.888455919343805	48.89872659955706	49.6731758868922
1	2655	49.02476845044198	49.884178161621094	49.886584144425385	49.01514084596864	89111600	60.39600048114163	48.99622235979353	49.898064050372724
1	2656	50.18268338243241	50.2741584777832	50.29101137652911	49.901025455222516	73420800	61.02489027406465	49.10128429957798	50.22236222763096
1	2657	49.99250010233797	50.23323059082031	50.34878019678023	49.8721348580968	59966400	58.129715704448756	49.174534933907644	50.449079244674905
1	2658	50.28619006236254	49.83602523803711	50.37044720007043	49.76621134147786	55638400	55.04151702802335	49.22250883919852	50.54506475354089
1	2659	49.946761359007695	50.00935363769531	50.48840496500306	49.8649138734609	70475600	65.9635457113816	49.35525458199637	50.58424522859435
1	2660	50.1826839212181	50.47637176513672	50.70747467184616	50.17786828248813	86693600	66.94772064986282	49.50038065229143	50.74587972231
1	2661	50.25490039518073	50.25971603393555	50.591925316151894	49.90584188720668	135742800	61.6547092961346	49.595812933785574	50.85561835597339
1	2662	52.098895192856226	51.28522491455078	53.29051045204365	50.866356188812546	277125600	71.22977940300073	49.78994505746024	51.196185350341544
1	2663	51.4922414021938	50.175445556640625	52.48645932873071	49.76861418470496	216071600	58.650780798643794	49.87815420968192	51.20770758683747
1	2664	49.477343775483895	49.11384201049805	49.69399977546768	48.5384962112125	163448400	48.149354810090394	49.85769271850586	51.22714341448072
1	2665	47.662234294545044	46.5428352355957	47.82111363712793	46.35988137306534	209572000	36.752157331616765	49.66579627990723	51.89656055318761
1	2666	47.25779980051846	47.42390441894531	47.681487794941866	46.71134058403225	143299200	42.88595853676809	49.55660792759487	52.069555459247695
1	2667	47.04115162882444	47.915000915527344	48.04018181399746	46.65839098495628	133457600	42.53834324324807	49.44277708871024	52.10502655584853
1	2668	48.194235796314935	48.97179412841797	48.99586864294031	47.99924471775164	108038000	50.919386876526794	49.45722007751465	52.105896757399854
1	2669	48.6431619585129	48.56825256347656	48.99596175846695	48.157452921825254	98478800	43.60301540711928	49.36322539193289	52.039883269265395
1	2670	48.23719999293651	48.44501495361328	48.82439958010952	48.123626486100825	89927600	40.87141866636003	49.23257228306362	51.89622764071215
1	2671	48.57551503498898	50.4965934753418	51.26260825219844	48.44502457316747	188874000	51.094661355642934	49.25138391767229	51.94898529087914
1	2672	49.09263237843947	48.99355697631836	49.88522822098317	48.95489286516682	146189600	46.7931024868964	49.19120761326381	51.87015088541152
1	2673	49.165122587641925	48.74949264526367	49.57108465942778	48.249285427657234	108909600	45.229963797033456	49.101217542375835	51.74619941787851
1	2674	49.363266755851576	49.89971923828125	50.05920590867106	49.25694230892504	110481600	47.92409714993532	49.060028076171875	51.629647830015614
1	2675	50.8952967679791	50.830055236816406	51.40516814645249	50.752727024340764	97654400	51.95283142335655	49.10076659066336	51.76852760172184
1	2676	50.95811879255859	50.832462310791016	51.554982471940136	50.82279812936807	107537200	48.33295270006632	49.06842640468052	51.63101842844793
1	2677	51.46799248420172	51.38341522216797	51.627475451973375	51.132105934155284	86141600	54.638561841045956	49.15470995221819	51.948758959283786
1	2678	51.516327591768615	51.339927673339844	51.81838401445387	50.92671286473306	89014800	59.27316666830872	49.313716070992605	52.341350439927645
1	2679	50.607745216350146	48.966976165771484	51.24085805695881	48.57067824203147	187272000	60.2676251683604	49.48686899457659	52.07762492539751
1	2680	49.74506692214679	49.89730453491211	50.06645538953352	49.55175007948856	104174400	60.43273214662112	49.663540431431365	51.97003349317472
1	2681	50.22836060199352	49.33427429199219	50.395096344038365	49.182036668870836	103493200	55.95034676530441	49.76491710117885	51.854955955150714
1	2682	49.31978196191317	49.66533279418945	49.7112459676444	49.13129901936015	63755200	53.09608916665957	49.81445557730539	51.855825326480556
1	2683	50.38301839311609	50.506256103515625	50.581169204140565	49.93839216129254	83962000	58.32646066583364	49.95288440159389	51.890421254772185
1	2684	50.78415287047786	50.441017150878906	50.85422835162441	50.06888150182888	84573600	58.618599466056644	50.095455987112864	51.83907640694101
1	2685	49.88281321972855	49.70641326904297	50.01571880745584	49.34877943160551	80092000	46.15021200308814	50.039014543805806	51.77785001513447
1	2686	50.35642681733498	50.54974365234375	50.61981911533831	50.09786845419015	76752400	58.10265783146027	50.15017073495047	51.797678549934986
1	2687	51.22876901321107	51.5380744934082	51.70481022779194	51.110361568755856	95654800	63.47504735557196	50.34935515267508	51.940711824152
1	2688	51.724146826399256	51.53324508666992	51.8135543549842	51.35201121810315	77449200	58.87611262586545	50.466035570417134	52.15210287662406
1	2689	51.915048951398695	51.75314712524414	52.30168270955568	51.00404928873257	109237600	55.43546770543806	50.53197070530483	52.34665069593772
1	2690	51.67822686457934	52.364498138427734	52.38383019099964	51.158691317853055	127111600	58.41748428274049	50.64140183585031	52.70222060128063
1	2691	52.69555945015334	54.02943801879883	54.05843794400406	52.613397297152915	177158400	62.952533575538574	50.83040346418108	53.560901764275854
1	2692	54.32183378115821	53.90861892700195	54.713297768202224	53.85304157152088	128906800	62.47950714094825	51.013881410871235	54.199197019486874
1	2693	53.16193882533482	52.85988235473633	53.35283689237944	52.441837231847586	159053200	71.70582570032789	51.29194613865444	54.38589477149874
1	2694	52.61339447394689	53.13776397705078	53.19334501317117	52.57231524325715	84632400	69.48568188314009	51.52340752737863	54.65255885055179
1	2695	53.15227014940944	53.331085205078125	53.36008513110984	52.94928541603726	73274800	75.1521506584393	51.80889402117048	54.80412200740926
1	2696	53.41806122742224	53.831275939941406	53.85060798896331	53.02659737455981	101360000	75.67006606520206	52.10646138872419	55.01070469794902
1	2697	53.647641556283865	53.393917083740234	54.07052059347336	53.25134363463478	88242400	68.72469820896836	52.312722887311665	55.1364583743763
1	2698	53.49540267080229	52.61339569091797	53.78054216826021	52.5505692814473	221652400	62.8907452545571	52.46789278302874	55.07933805616882
1	2699	52.90819651446175	52.85261917114258	53.123260516569964	52.594057131541085	76662000	69.83552148995068	52.69262177603586	54.76656654578072
1	2700	53.41082727302514	52.601314544677734	53.76363081481805	52.482910780852876	124763200	63.977733640572644	52.83916255405971	54.51200665582269
1	2701	52.81155246424069	53.410831451416016	53.52440497591303	52.470831890749665	87613600	63.07810012552453	52.972930908203125	54.489839057571075
1	2702	53.16193801957447	53.13535690307617	53.38908507197578	52.87921360984499	75334000	60.78058517192095	53.087367466517854	54.35817948566674
1	2703	53.2924153241982	52.87678909301758	53.39390952349982	52.50465352814382	101408000	57.521828307136644	53.1676276070731	54.193844862687605
1	2704	53.37941678148574	54.12126922607422	54.26867292782432	53.35283566519596	103909600	60.84113825984155	53.293111256190706	54.325899175210075
1	2705	54.387064691051116	54.27107238769531	55.14824528486397	54.176830945725996	139223200	51.834120436994546	53.310370853969026	54.402535358317984
1	2706	53.9013722801066	52.91062927246094	54.02702880383986	52.66173134935385	138449200	43.62455556340792	53.23908587864467	54.29264054255751
1	2707	52.782541530630425	53.360076904296875	53.39390707344104	51.98511558834471	114426000	53.46033974523066	53.274814060756135	54.30667557812045
1	2708	54.524816586727255	54.85586929321289	54.97186163083012	54.101937534764495	138478800	60.17178555893769	53.397535869053435	54.72540322250719
1	2709	54.67704477909794	54.867942810058594	55.56146315555386	54.573135455502594	122306000	59.29828610466163	53.507311412266326	55.048487242616694
1	2710	54.56830565409411	54.22516632080078	55.1095883917041	54.20825307885652	111820000	52.342693580326234	53.53544643947056	55.11597751799758
1	2711	54.86070251464844	54.86070251464844	55.044351515998365	54.524815876666395	74770400	58.52290535385522	53.64021682739258	55.36794121075259
1	2712	55.07816624002596	55.600120544433594	55.68469780488162	54.92593233331579	113013600	67.43796337045939	53.85355431692941	55.76312801662567
1	2713	56.29123307121026	57.07899856567383	57.424549336470406	56.13658033336911	166795600	71.5554341515651	54.155438559395925	56.63469248973932
1	2714	56.76244153673579	56.9968376159668	57.54295798858066	56.70686418732178	96427600	72.81168138004873	54.46940449305943	57.20126651270216
1	2715	57.12249576612337	56.86393737792969	57.426967321891	56.75761292401367	87360000	69.27439964126035	54.716054916381836	57.652116046555015
1	2716	56.39272756081645	56.63437271118164	56.84460649930377	56.35164832771986	73903200	69.6312707977875	54.965984616960796	57.91807944552449
1	2717	56.80835395471495	56.85426712036133	57.06449720809771	56.42897300976469	67585200	72.41295106549822	55.2500901903425	58.099875974438596
1	2718	56.687538622623364	57.12733459472656	57.410058996558924	56.61504433536088	97433600	69.02150142077959	55.464809145246235	58.39992845193458
1	2719	57.395555885867246	58.118072509765625	58.23406483418485	57.347227594298715	87247200	72.00123568619853	55.73959486825125	58.90460577817709
1	2720	58.275138049015425	57.985164642333984	58.52644735154949	57.90300249921784	82293600	83.76201046367788	56.10206168038504	59.024462816667224
1	2721	58.50228259897522	58.76325607299805	58.77775787685422	58.28963372229257	75828800	84.4423586169667	56.48800304957798	59.27448453765174
1	2722	59.084652529312926	58.85992431640625	59.15473168555274	58.43221138129828	69275200	81.06483062660668	56.77400697980608	59.65906298218801
1	2723	58.75843954349177	59.58486557006836	59.6211108701413	58.69077919188054	73477200	82.95071115760908	57.1109300340925	60.135452212094265
1	2724	59.78784556887606	60.18172836303711	60.230056658018285	59.61869469283567	96572800	91.87902402601338	57.53639875139509	60.48717315683947
1	2725	60.16239472982446	58.78984832763672	60.35087765635681	58.61586720770971	142839600	74.96923699008312	57.817052023751394	60.39548530072064
1	2726	59.14506814350186	58.78260040283203	59.275558594982016	58.28723077368662	124522000	72.29938073610292	58.044372013636995	60.324796483667825
1	2727	59.74433919769838	60.111637115478516	60.21071249695855	57.332718309830256	139162000	71.70523248702581	58.26098905290876	60.71586233209755
1	2728	60.300126418856735	61.81766128540039	61.84423871099099	60.20830377325702	151125200	77.99606028141606	58.605333600725444	61.59133289600812
1	2729	62.182542263480464	62.22362518310547	62.30820245921015	61.71133865276804	103272000	80.16860803677409	58.98816844395229	62.36160865340103
1	2730	62.11488056762878	62.13421630859375	62.390359568196075	61.93848433426413	79897600	81.45380052402966	59.38101441519601	62.8531892010814
1	2731	62.04721979393924	62.16079330444336	62.22120458929822	61.708918073636895	75864400	81.03443813922857	59.760051999773296	63.20247237284217
1	2732	62.71096423180183	62.87820053100586	63.10118472879904	62.55826957630568	94940400	81.97143861771359	60.17082813807896	63.63238267582249
1	2733	62.69887159874314	63.05031204223633	63.123020287375404	62.252910436569145	69986400	80.16612686246448	60.52313096182687	64.08716710848807
1	2734	62.604332041612686	63.549583435058594	63.615020843724096	62.59948729167758	81821200	82.57287188027695	60.920589447021484	64.50642334627237
1	2735	63.39202883663546	63.49140167236328	63.69257341677156	63.239341568460596	87388800	80.22499233069365	61.25831413269043	64.85948241202394
1	2736	63.29023739870051	64.0997543334961	64.17488862947721	63.27569575409539	102734400	81.43922955931657	61.6325877053397	65.24911902163117
1	2737	63.925277951167224	63.65625	64.19915805057941	63.52536773903266	89182800	75.28235371592604	61.92340087890625	65.48498012621306
1	2738	63.90829468811082	64.41242980957031	64.41727456006997	63.74591048586719	100206400	75.76193854317509	62.225593839372905	65.86761802542959
1	2739	64.42209642904663	64.7371826171875	64.81716165313593	64.04158024442006	86703200	91.62456307849048	62.650403431483674	65.93609979238632
1	2740	64.93109914239555	64.54088592529297	64.95533768801018	64.32275380789264	76167200	89.26245370177702	63.061709540230886	65.62367739277715
1	2741	64.35910036351942	63.789527893066406	64.48997518063773	63.11331175169603	106234400	77.22189752581336	63.32441602434431	65.26130839180131
1	2742	63.91070178360645	63.50352096557617	63.98826214796368	63.30234923280982	121395200	65.79889263539619	63.44483457292829	65.17700121093785
1	2743	63.64412317861405	63.44780349731445	63.78712100841456	63.21997444059716	65325200	62.278307434606575	63.53227588108608	65.11612870918168
1	2744	63.67319470404511	64.56027221679688	64.57723993835555	63.62714368642337	84020400	70.18958609786604	63.70556558881487	65.1557339787398
1	2745	64.69841778729275	64.05613708496094	64.75173962276358	63.62229157801935	105207600	64.6116131111711	63.84094728742327	64.99316204706474
1	2746	64.3687821181986	64.91654205322266	64.95047748832434	64.30334471751318	65235600	65.37502481750144	63.98654311043875	65.12981036391076
1	2747	64.61601250812018	64.77355194091797	64.95532991643037	64.4463501056827	46617600	63.05559778295553	64.10963167463031	65.18790496710346
1	2748	64.77839680835467	64.02462768554688	65.0159226928851	63.85254660612109	94487200	53.46784398294399	64.14356340680804	65.17478982771597
1	2749	62.606750599630736	62.883056640625	62.9024430346031	62.117164638621766	114430400	46.165568646309204	64.10011019025531	65.28893878081725
1	2750	63.27570328045217	63.438087463378906	63.81861113445702	63.18117518271127	67181600	45.80125508225039	64.05284827096122	65.29322922059524
1	2751	63.934959141831044	64.3687973022461	64.44393901247312	63.67804683126644	74424400	54.258311903850014	64.10374450683594	65.3324447020982
1	2752	64.82928461076523	65.61213684082031	65.68242637920102	64.78565228550922	106075600	56.77516840116056	64.18943786621094	65.6553261443861
1	2753	65.4400635801901	64.69356536865234	65.63395710624658	64.20639808398826	128042400	49.76916044984035	64.18632234845843	65.64737326417
1	2754	65.1007385592711	65.0716552734375	65.45702360385863	64.436638147631	90420400	52.75600688991818	64.22423444475446	65.75098597447385
1	2755	65.1516569294543	65.62670135498047	65.70668781535633	65.07652261611067	78756800	59.73800613553995	64.35546112060547	66.02993102438958
1	2756	64.90198532031415	65.79390716552734	66.06051624876014	64.79049693880305	137310400	62.29512426571562	64.5190601348877	66.2802774422738
1	2757	65.79393749772268	66.68828582763672	66.72463994743697	65.66548134338474	133587600	65.9584604696652	64.75052315848214	66.74196857842018
1	2758	67.13666515565427	67.82984161376953	68.05525192322642	67.13182040577094	128186000	66.05570787272896	64.98406382969448	67.5603735096969
1	2759	67.75955958046966	67.96315002441406	68.29277053463888	67.57292945943043	114158400	69.9111328155376	65.26313618251255	68.22416639887119
1	2760	67.81529237700892	67.80075073242188	68.32427212724674	67.6504821406466	116028400	65.82448355972289	65.46915108816964	68.71403795103681
1	2761	67.74259937530617	67.8686294555664	68.14978030836127	67.60929847111873	98369200	67.12256147489089	65.69022805350167	69.14586259900146
1	2762	68.4042663685893	67.7280502319336	68.50605789230497	67.51476289158593	275978000	71.96660672119381	65.95475823538644	69.42810335188781
1	2763	67.99224072863827	68.83326721191406	68.89385987671328	67.9534605355789	98572000	85.44614808458653	66.37977327619281	69.6861747466032
1	2764	69.00051110068192	68.89871215820312	69.04898819644636	68.5715176497753	48478800	84.54462878285489	66.76981789725167	69.86281719351032
1	2765	69.03200514767786	70.26567077636719	70.28263849577442	69.00292185530243	93121200	85.3530710240345	67.19102314540318	70.47566753554192
1	2766	70.55892938705581	70.23899841308594	71.24968709103864	69.83181757161367	146266000	82.47692429626869	67.52151325770787	71.04427562530854
1	2767	70.15658572923759	70.65586853027344	70.93944536220306	69.12893684113479	144114400	95.02158641421258	67.94739205496651	71.43890717605117
1	2768	70.2705002896589	71.172119140625	71.17938996214235	70.17112746454646	100805600	95.12333863045363	68.38313947405133	71.85125553711991
1	2769	71.79986584309097	72.79601287841797	72.85660552982391	71.54537966581154	135480400	95.78915362065739	68.89523315429688	72.70996515590514
1	2770	72.0204315021118	72.08829498291016	72.85176099103282	71.86289207131898	146322800	87.60481258170321	69.34483228410993	73.06761269502424
1	2771	71.20608458978934	72.66272735595703	72.70150755258545	70.95401700998774	118387200	87.11211709329284	69.77157810756138	73.551837607134
1	2772	72.67239390199568	72.32096099853516	72.92930612536188	72.10040288289755	108872000	80.9758448818765	70.09237234933036	73.9247029677597
1	2773	72.02285002693742	73.48434448242188	73.78730773933461	72.02285002693742	132079200	83.3427017543213	70.4867433820452	74.50694052537855
1	2774	74.46595006478736	75.04521942138672	75.2391129669444	74.21388993487531	170108400	87.4277398548057	71.00420543125698	75.38397926299375
1	2775	75.2803190714048	75.21487426757812	75.78202805010778	74.71074661224186	140644800	87.5585775837522	71.52893720354352	76.04849975711232
1	2776	75.5323939772133	76.8218002319336	76.84846485002203	75.41362732738085	121532000	90.43081481963904	72.1784907749721	76.95170861950469
1	2777	76.75878138146395	75.7844467163086	76.96964264584395	75.66084272483062	161954400	81.092571472253	72.67500359671456	77.39510058840995
1	2778	75.58328240864935	75.45967102050781	76.46793372841316	75.0258255219773	121923600	78.6817108475526	73.14364351545062	77.54039210924256
1	2779	76.00501238616502	76.40492248535156	76.51641831155123	75.64145640571084	108829200	77.86560525699754	73.58216149466378	77.96703357663597
1	2780	76.65454881201066	77.25078582763672	77.25320450403059	76.34674080549438	137816400	79.62306259705952	74.08300345284599	78.42451517421274
1	2781	76.87755592935629	76.72728729248047	77.32109101550805	76.58913423087549	110843200	75.42120411572851	74.51667622157505	78.58805199922834
1	2782	77.21442432913649	77.00114440917969	77.55616777084843	76.90661632258188	101832400	74.91196287572288	74.93303516932896	78.71281459429505
1	2783	77.05446622858818	77.3719711303711	77.45195017577431	76.5042802197772	104472000	71.9025388510972	75.25988933018276	79.03502066708134
1	2784	77.61920173441393	77.14900207519531	78.3657000922343	76.95752718801279	146537600	75.40150038486135	75.62136840820312	79.04068685181035
1	2785	75.14943709018755	74.88040924072266	75.56388879724423	73.89395899955545	161940000	59.513380052129904	75.77977425711495	78.78962068004805
1	2786	75.76505276717205	76.99871826171875	77.1707993206053	75.66567993131815	162234000	67.41255849644747	76.11389977591378	78.42785726489204
1	2787	78.63716877095959	78.61050415039062	79.46122758988011	77.89308902061387	216229200	68.46527606013137	76.48005403791156	78.61714802084275
1	2788	77.68949101302144	78.49658203125	78.5499038706555	77.25564547406604	126743200	63.879192118770696	76.72657993861607	78.94538691144538
1	2789	77.78400462606156	75.0161361694336	78.20815322919047	74.72044370453256	199588400	49.36886008120575	76.71238436017718	78.97496504420374
1	2790	73.75337231306008	74.81011199951172	75.98075876987488	73.24924470798491	173788400	42.98744486784239	76.56869234357562	79.04660937548847
1	2791	76.42188260936533	77.27987670898438	77.47135157736116	76.0147017269092	136616400	54.739606833812346	76.67550877162388	79.1366681083776
1	2792	78.411751069267	77.91004943847656	78.71229570893303	77.30412280540882	118826800	57.618727719723736	76.8505358014788	79.2876329983315
1	2793	78.18149548402742	78.82135009765625	78.82377617084421	77.62161992339047	105425600	57.52906307824258	77.02313777378627	79.65849771231073
1	2794	78.31845426530488	77.74996185302734	78.56868819994995	77.25678206283877	117684000	51.53376879352023	77.05879320417132	79.72079348087784
1	2795	76.3287076074605	78.11921691894531	78.11921691894531	76.24853875783282	109348800	54.31777077567604	77.1582167489188	79.87038360875728
1	2796	78.61726222427434	77.64790344238281	78.69014299849893	77.42925370559163	94323200	51.98196934414425	77.20441382271903	79.92706820959827
1	2797	78.09979998299478	79.49188232421875	79.49673857196723	78.09979998299478	113730400	55.95841433754105	77.35583605085101	80.34170984262802
1	2798	78.76061799356015	78.92581939697266	79.25379778682812	78.55654436332367	94747600	54.89958719014542	77.4827515738351	80.57973517779263
1	2799	78.89422750170591	78.94525146484375	79.19548537647773	78.43506373229454	80113600	62.79607865553355	77.77309744698661	80.56640039059715
1	2800	76.61539889824193	77.49972534179688	77.68193472739671	76.4331895126421	152531200	51.64692569523097	77.80888366699219	80.57212587491074
1	2801	77.74269122758709	78.62215423583984	78.85295581607006	77.74269122758709	93984000	50.03956957014542	77.80971581595284	80.57400475208739
1	2802	78.38160436292632	77.81553649902344	78.87235220810766	77.30778066851408	100566000	47.79078020854267	77.7610697065081	80.49711523947683
1	2803	77.40742498128057	76.05421447753906	77.85202015034534	75.43470537009962	129554000	53.790104274316604	77.83521815708706	80.29292468751996
1	2804	72.21806812112543	72.44157409667969	73.89924884098315	70.26721371823064	222195200	43.07493813264308	77.66603687831334	81.13770068830298
1	2805	73.11457407172517	69.98785400390625	73.4984253446428	69.51411393117301	230673600	28.659775492032196	77.1451781136649	82.52827758886522
1	2806	69.61126392711407	71.09809112548828	72.36870040431434	69.6039758492443	198054800	30.609531561575793	76.65860966273716	82.90595910105846
1	2807	68.29207211988479	66.4505386352539	69.48250516613125	66.3144895679182	320605600	20.962547998282247	75.77498027256557	83.91682893978084
1	2808	62.50025221622377	66.41167449951172	67.6385554997623	62.2840268493113	426510000	22.030404728888414	74.96510260445731	84.4117925599399
1	2809	68.57874117120816	72.59463500976562	73.23358365974926	67.47090889947629	341397200	39.40947247291812	74.57048961094448	83.91056783211813
1	2810	73.77535933674136	70.2890853881836	73.85552819395053	69.43391136932343	319475600	36.8201342234191	74.04485974993024	83.46680435641679
1	2811	72.01885987940881	73.5494155883789	73.70976072017585	71.21470980381075	219178400	39.87076460029958	73.6203978402274	82.50539712178913
1	2812	71.7953418231212	71.16368865966797	72.77441312341486	70.79683812058555	187572800	37.54188428207365	73.06595993041992	81.48114295452437
1	2813	68.5107340510731	70.21864318847656	70.65351836354851	68.32366840377551	226176800	36.39805108505074	72.44263076782227	80.25290677147088
1	2814	64.0769619398227	64.6648941040039	67.56080421303677	63.8947525693777	286744800	32.26583884822253	71.52585710797992	79.77959627828334
1	2815	67.33001496463376	69.3221664428711	69.58940835488747	65.44232100611896	285290000	38.29353478841762	70.861572265625	78.088118672242
1	2816	67.3907682408546	66.91458892822266	68.32124779609116	66.04727026677229	255598800	36.809928088343376	70.08293315342495	76.36986262068284
1	2817	62.179552305414184	60.30643844604492	65.59536986136158	60.25056194673212	418474000	32.94564788554926	68.95809200831822	76.20468735951515
1	2818	64.35392608390474	67.53165435791016	68.00540170395698	61.453148500655	370732000	45.068574502453636	68.60738345554897	75.59849527782806
1	2819	58.78074192993141	58.843910217285156	62.942401413512734	58.30699831007388	322423600	40.052887950983134	67.81138747079032	76.46533314080558
1	2820	60.1315203844917	61.43128204345703	62.58527101614985	57.91828374935874	324056000	41.59307178581205	67.12090110778809	76.17838497301616
1	2821	58.25113092125165	59.92745590209961	60.736466075066666	57.60732215662013	300233600	43.99893594359378	66.65496662684849	76.49805063877642
1	2822	60.10237727632101	59.46828842163086	61.42643149656511	58.941096340460845	271857200	43.6612874972706	66.15901047842843	76.7278474257799
1	2823	60.051354773786564	55.692909240722656	61.181055225922066	55.391655045407944	401693200	33.860727770665775	64.95174435206822	76.19374188707536
1	2824	55.4110887106565	54.50975799560547	55.51312552059559	51.65271619613283	336752800	34.60244210508762	63.82464953831264	75.89503573492085
1	2825	57.422678587356735	59.97846984863281	60.17525538486383	56.92221075272987	287531200	37.30455490419879	62.85529627118792	73.67654612684935
1	2826	60.91866936456952	59.64806365966797	62.74076316410799	59.3516694383783	303602000	38.796453999782955	62.03275162833078	71.83633101729598
1	2827	59.89100489553818	62.78691864013672	62.84522326472186	59.85213267444205	252087200	43.06568475305039	61.501914160592214	70.1305419706249
1	2828	61.404565866396354	60.187408447265625	62.162555760268454	60.01977521141477	204216800	45.57843297096263	61.18209375653948	69.6358494080335
1	2829	60.91623789559668	61.905025482177734	62.07751865016797	60.59068767059111	167976400	42.22402650509491	60.65229797363281	67.72546997315689
1	2830	62.09695630753002	61.77869415283203	63.77084923912986	61.22234982717526	197002000	44.34515289218987	60.285448346819194	66.43149413525758
1	2831	59.886146267819704	58.528079986572266	60.42548629953478	58.09563671171014	176218400	47.88562013421772	60.15842274257115	66.37569674627274
1	2832	58.38960208336811	59.504722595214844	59.55817097638504	57.55386780368069	165934000	38.79086978348529	59.5850704738072	64.12845558972286
1	2833	58.98725360699361	58.649559020996094	59.691795094969585	58.056770548986755	129880000	49.652606176447804	59.571188245500835	64.12550309348224
1	2834	60.95512445901241	63.76601028442383	63.92149180414208	60.58584936232617	201820400	53.82719406053449	59.737954548427034	64.73512378221784
1	2835	65.78972025756833	63.027427673339844	66.00837741080065	62.92296275780196	202887200	55.21238720880247	59.959381103515625	65.25833115183866
1	2836	63.83158830415397	64.6406021118164	64.95642874150907	63.464745123474984	168895200	58.37198897525409	60.32883208138602	66.17343707568992
1	2837	65.27954490531218	65.10704803466797	65.61237949299203	64.3077616237392	161834800	67.06594106024508	61.00127056666783	66.71299164324401
1	2838	65.18481070772222	66.38496398925781	66.49429260465944	64.58230223555258	131022800	71.4536509497729	61.849499566214426	66.89692808722268
1	2839	68.02483698264969	69.73760223388672	70.02914021517418	67.55108961658726	194994800	69.09037425908426	62.54658045087542	68.98486126650077
1	2840	68.60790967618321	69.10108947753906	69.56268513070003	68.17789817121714	131154400	68.27275092261371	63.22179658072336	70.3014445083312
1	2841	69.81777206662008	69.65013885498047	70.0169894216292	68.59575486882815	157125200	64.74271505911173	63.712026596069336	71.56969325015578
1	2842	69.1642646656941	68.70509338378906	69.7133247388834	67.26199423225898	215250000	69.69663341993456	64.32043266296387	72.32024186669608
1	2843	67.52680120844859	67.27899169921875	68.43298447365049	67.25955929365115	130015200	62.59680630619595	64.7042873927525	72.720542725786
1	2844	67.12106589236431	65.1993637084961	67.35672361691245	64.48510245735507	180991600	57.345547459988545	64.94862093244281	72.78730913777913
1	2845	66.4724141891117	67.07735443115234	67.51465402003916	66.12986704581802	116862400	69.50878728089685	65.55928339276996	72.52698461044663
1	2846	67.02146404669297	66.81739044189453	68.44998669440024	66.77851821991604	124814400	67.25120022231604	66.08161681038993	72.12986568471153
1	2847	67.34458885914316	68.74638366699219	68.75610357640764	67.29599672618441	126161200	72.67065029998876	66.80281857081822	71.22210927806826
1	2848	68.46214844429589	68.79499053955078	69.12782522068554	68.01270448166582	117087600	64.61857683009293	67.16203144618443	71.32830606992727
1	2849	69.25898784356464	67.67984008789062	69.44119719998857	67.5875269084947	112004800	63.2342121837022	67.49434661865234	70.91555216319415
1	2850	69.173964073941	69.90280151367188	70.37411698449395	68.96989048051049	137280800	64.46692202850315	67.87021800449916	71.09125420030658
1	2851	70.44456848623724	71.37747955322266	71.55483267240312	70.05342927151027	183064000	66.33330127132487	68.31810597011021	71.62666436128566
1	2852	69.54323880788147	70.22834777832031	72.64079791635479	69.44606196573332	240616800	60.07891710462818	68.59263338361468	71.8476029416616
1	2853	70.25265616239726	71.22200775146484	71.35076875806811	69.5602589927265	133568000	54.442339815569966	68.69866234915597	72.20156018662318
1	2854	71.68359763047998	72.29096221923828	73.12669648649918	71.53782864635428	147751200	59.30539228145394	68.92651040213448	72.9224436257091
1	2855	72.99550777203844	73.03681182861328	73.67089693622526	72.60922476151869	142333600	59.767342997890296	69.16841561453683	73.72391958555373
1	2856	73.66602924556396	73.7923583984375	74.13977654354584	73.3623469812468	115215200	64.83408379013312	69.53179168701172	74.69865630377762
1	2857	74.45498957360294	75.54876708984375	75.60236016603984	74.12612330759006	133838400	73.65831534118439	70.12248992919922	76.01923051056384
1	2858	75.05423265334322	76.73753356933594	77.23447930915694	74.8447297976167	145946400	84.78146976583302	70.94664491925921	77.09906598446551
1	2859	77.42448767187804	75.86055755615234	77.87759399228193	75.73875582103778	162301200	78.1772158590826	71.57401657104492	77.81740623226241
1	2860	76.04083401805624	74.94461822509766	76.96653181484587	73.86301804797671	200622400	75.01975270830535	72.15453284127372	77.99081715497411
1	2861	74.17969648666386	75.40502166748047	75.46592253617749	73.45375545548762	158929200	72.53646199952385	72.6301498413086	78.35419985462687
1	2862	73.16631038114848	74.959228515625	75.0055137738857	73.13220232382433	166348400	70.31690447200776	73.07045255388532	78.46239704980798
1	2863	76.28932731093329	76.72537231445312	77.10052386443475	75.59505570398892	135178400	78.58672201331136	73.71656199863979	78.45406522279443
1	2864	76.74241206985262	76.2820053100586	77.59258592543456	76.25033566486115	101729600	72.7153439107442	74.17221941266742	78.54249641280677
1	2865	77.14434774630136	77.76554107666016	77.83618073277223	77.10537029765943	111504800	72.732544753978	74.62850952148438	79.07509416935196
1	2866	77.62669752734837	77.18577575683594	78.1699360459229	76.94704163415062	102688800	75.8043594892122	75.12546866280692	78.96774377601241
1	2867	76.92267483121685	77.68272399902344	77.76554829725728	76.82036552394693	81803200	74.87876720659548	75.58694839477539	78.92903718492525
1	2868	78.80574074281053	77.15654754638672	78.98600497329699	77.10051605904029	125522000	69.55366494393984	75.93449020385742	78.77432682508507
1	2869	77.01282211981075	77.49271392822266	77.63887753036026	76.26982690652362	112945200	68.51697790177863	76.2527689252581	78.65939353249277
1	2870	77.16628904335452	77.52682495117188	78.79112789153655	76.88858487945744	133560800	66.50884660267522	76.51951653616769	78.54981967883779
1	2871	77.77040626057638	77.45128631591797	78.2332513575919	77.09318892472729	153532400	59.878463762948876	76.65541076660156	78.66034501183037
1	2872	77.40500236526634	78.40377807617188	78.5255798108143	77.2734544102799	80791200	58.869271267359004	76.77442823137555	78.98739395550402
1	2873	78.13581441439783	78.7667465209961	78.79110835527389	77.6924543067813	87642800	66.36487677795975	76.98201315743583	79.36443905408196
1	2874	79.08831525723531	79.20037078857422	79.46346673855659	78.51340711651795	104491200	75.34080914687775	77.28599548339844	79.63437015234109
1	2875	79.02254872485325	78.5182876586914	79.32217629393165	78.14313615962425	87560400	68.06108321707539	77.50837162562779	79.67180707607987
1	2876	78.76919528745188	80.75456237792969	80.81546325453446	78.73996405615183	137250400	77.8375700148202	77.92232404436383	80.19944121085423
1	2877	80.45005239746396	81.23201751708984	81.26612557402613	79.73629595752215	95654400	74.7061131312827	78.2442272731236	81.01344139187346
1	2878	80.9104694123917	83.79716491699219	84.19180139437105	80.87879976817435	147712400	83.42362554621529	78.78102438790458	82.61903118893906
1	2879	84.74966199726732	85.95306396484375	86.42321696800342	84.3087402266497	166651600	84.35905760282056	79.36584745134626	84.72931807817722
1	2880	85.0931399166828	81.826416015625	85.51944605133392	81.72410670645458	201662400	65.00705130925394	79.69732175554547	85.0540023537502
1	2881	83.9750035031546	82.53286743164062	84.72529905397784	81.41716661042786	200146000	65.47486555724005	80.04376057216099	85.46613657878025
1	2882	81.1808627446549	83.55355834960938	84.20885233004024	81.01764513591078	138808800	69.7859358680719	80.50068991524833	85.95304930571439
1	2883	85.61688845940762	85.7679214477539	86.04076362659309	83.97500316337461	165428800	72.93095647835334	81.09177616664341	86.92064785018485
1	2884	86.51580290858197	85.64857482910156	86.57670379862522	85.52677304901509	114406400	72.39990539524838	81.67190115792411	87.58837303773014
1	2885	85.60470805854047	85.68266296386719	86.1016612872621	85.071215791131	96820400	72.7542835257252	82.25985663277763	88.00302691899103
1	2886	86.39154853955934	85.1930160522461	86.85926309495805	84.07974627650528	264476000	69.26059141085918	82.74480220249721	88.22594996299904
1	2887	85.58764785972699	87.42198181152344	87.56570697612823	85.5413626026624	135445200	72.20351800986658	83.36303329467773	88.86379782989532
1	2888	88.6716626472519	89.28797912597656	90.71306090535926	88.25022596990101	212155600	74.10643929628756	84.08357674734933	89.87079071388922
1	2889	88.91528553845141	87.71188354492188	89.83854496849224	87.33673203943316	192623200	71.06973091057617	84.74026216779437	89.85444651675334
1	2890	87.86778240746746	88.87629699707031	88.915274447835	87.10530228917064	137522400	69.57496480473802	85.32038606916156	90.32846366671487
1	2891	88.77153754918204	86.14549255371094	88.99321758938132	85.99689057767071	205256800	60.68213717383538	85.67134857177734	90.10042493921758
1	2892	86.05294450913456	88.1308822631836	88.22589120557494	85.57304527140465	130646000	59.665364064445626	85.98089981079102	90.45130044010159
1	2893	87.71674543727191	88.8665542602539	89.15401204164107	87.69726042821986	140223200	56.93735296522031	86.18900626046317	90.91762539381925
1	2894	88.94451299507311	88.69847106933594	89.49018248229541	88.64975482751349	110737200	70.16447067967842	86.67986733572823	90.85162114887078
1	2895	89.6095532582672	88.69847106933594	90.2477932693981	88.58398455566804	114041600	68.87403824236105	87.12026759556362	90.66007599918022
1	2896	90.133299611757	91.07117462158203	91.54132761643254	90.10162996566636	118655600	71.25353147406715	87.6572401864188	91.14677571129539
1	2897	91.4511836132447	90.78858184814453	92.23314870498879	90.67652632855658	112424400	65.93476043667386	88.01585878644671	91.69574432752437
1	2898	91.77030618213804	92.90306091308594	92.93473055595655	91.68260506078956	117092000	70.43640183838637	88.53403636387416	92.77782499968231
1	2899	93.79951991976638	93.30257415771484	93.85311298440196	92.25020530715545	125642800	71.03279513621996	89.07831573486328	93.68576533493936
1	2900	92.89575849276069	93.46578979492188	93.52425969060765	92.28188034447685	90257200	73.25390231777925	89.6692281450544	94.25209972514557
1	2901	94.77637034737839	93.03460693359375	97.39754619914325	92.82023467943165	191649200	67.55026576202609	90.070129939488	94.78620263947515
1	2902	92.41341897123698	94.57418823242188	94.76662964226465	91.47555145597293	170989200	66.87404655258743	90.44771630423409	95.70898673559927
1	2903	96.45724252536823	95.224609375	96.70815384014621	94.02120745599402	153198000	75.48751233340201	90.9843395778111	96.56633162058145
1	2904	94.0918491550775	94.05287170410156	94.91279173687622	93.45117077912744	110577600	67.55321295634204	91.35409491402763	97.01974156880733
1	2905	94.50596306222513	93.86284637451172	94.6618654071879	93.3878166649876	92186800	81.61658480659582	91.90533447265625	96.84290561904227
1	2906	93.95057642119791	95.84093475341797	95.97979054933192	93.60465613852993	90318000	81.6055804504092	92.456052507673	97.29913238643788
1	2907	96.63505736726202	94.51814270019531	96.71057384530293	94.26723143317828	103433200	72.1034279238446	92.85973739624023	97.34274398552421
1	2908	94.21851429558046	94.78367614746094	95.46820132434986	94.13082061211013	89001600	73.61926782638773	93.2943949018206	97.17954628282924
1	2909	94.51571764664843	90.46946716308594	94.59367254925417	89.65583238188394	197004400	55.14941941254453	93.42089462280273	96.73475708764994
1	2910	88.65949991326812	90.24535369873047	90.59127395192569	86.86413581047867	185438800	47.25595040115519	93.36190741402763	96.87910199633475
1	2911	91.31233191463267	92.38418579101562	92.4767563073094	91.0882208654685	121214000	54.71968153168097	93.4758791242327	96.7272324053608
1	2912	91.95299302991992	90.86652374267578	92.1308262217511	90.86164691587753	103625600	43.75559973219537	93.33041218348912	96.86229270190253
1	2913	91.35131946620248	92.60831451416016	92.79345556721894	91.31478042525389	90329200	48.03316800053948	93.2808222089495	96.83381907003864
1	2914	91.77762295924211	93.72888946533203	93.83363719107348	91.3683708441203	158130000	50.70700841439447	93.29961504255023	96.85960266692416
1	2915	100.25259691427748	103.54124450683594	103.69227750309791	98.245298809941	374336800	68.77008706233715	94.05008915492466	100.56928445466721
1	2916	105.43160465101931	106.15023803710938	108.78115318345822	105.13197706745348	308151200	69.91946596313163	94.87694985525948	104.07045661713288
1	2917	106.34023893961368	106.85911560058594	107.95533138544933	105.6142978102183	173071600	69.97985974669295	95.70798601422992	106.91889519068103
1	2918	106.57897346726979	107.24644470214844	107.56800311782875	106.11125145953578	121776800	73.28454816902138	96.65038408551898	109.37755190866262
1	2919	107.58018642555417	110.98819732666016	111.48515059417284	106.98823165003749	202428800	76.85663596362345	97.87362343924386	112.58407729838812
1	2920	110.5074267277089	108.46479034423828	110.9662282348746	107.66433051713838	198045600	69.46430386370139	98.77532741001674	114.46412531283013
1	2921	109.91683374879184	110.04129791259766	111.06383745078631	107.37879108538309	212403600	73.74882898773883	99.88412421090263	116.44669720580349
1	2922	109.30185668966175	106.76869201660156	109.8021412960738	106.50756451384724	187902400	66.79090518466896	100.74019677298409	117.40576550586593
1	2923	107.86442881473535	110.31706237792969	110.57574703986536	107.66919763698496	165598000	78.41608319042261	102.15788214547294	118.43197350897
1	2924	111.70321312934962	112.26939392089844	113.27729135692857	111.21268497099322	210082000	80.04530002366792	103.73102787562779	119.286753738108
1	2925	112.09370465193015	112.16935729980469	112.25965191516508	110.35123604518499	165565200	78.58088469655095	105.14425441196987	119.82999445386154
1	2926	113.2968179642712	111.8764877319336	113.32122372260254	111.24686087349903	119561600	81.46353256679416	106.64496612548828	119.18254159014421
1	2927	111.62758047708495	112.80874633789062	113.23582109417252	111.2908003348021	105633600	81.00292288305259	108.0878541128976	118.0522172730471
1	2928	113.21873534210548	112.95028686523438	114.3706172584675	112.85511407883027	145538000	80.4143392627557	109.46081107003349	115.3771760687535
1	2929	112.99177121995677	115.45660400390625	115.57130437194682	112.97468644336531	126907200	74.52406570276978	110.31190817696708	115.98310679420374
1	2930	116.42057376195339	121.4063720703125	121.8920146880567	116.40837460528758	338054800	77.60394694702433	111.40163203648159	119.12115298963973
1	2931	125.63074297294527	122.8584213256836	125.71616685968111	120.98417507562561	345937600	78.19047928873336	112.54443958827427	121.92543838725433
1	2932	121.72606056016687	121.85051727294922	122.19706118429359	120.1202554216441	211495600	75.18141627961984	113.58758762904576	123.6536818587822
1	2933	123.17323105412805	123.507568359375	123.9663698240554	122.10188003313583	163022400	73.25895106027056	114.48182841709682	125.71042073813223
1	2934	124.11278882530611	122.0311050415039	124.44712610871338	120.8816586446735	155552400	76.2241477053185	115.45085089547294	126.78364801649451
1	2935	123.00972286968064	121.83344268798828	123.429476621527	121.60892012172948	187630000	74.07815328437589	116.29314695085797	127.64685433440955
1	2936	124.53988670086144	125.965087890625	127.8783894314197	122.99753487296857	225702700	87.86828913251696	117.6643180847168	128.69513279405004
1	2937	129.5964440817618	130.98260498046875	131.5878410707446	127.4195871326475	151948100	88.53295397965717	119.14042827061245	131.39850340155942
1	2938	134.31136056792818	128.26885986328125	134.69206665149915	123.97371354118887	200119000	79.00889460652087	120.28324726649693	132.76312616052135
1	2939	123.88584332486174	117.99952697753906	125.76984587273459	117.62858474412651	257599600	57.72287193832795	120.69968795776367	132.37650554326828
1	2940	117.208837599474	118.07762908935547	120.75233522289194	108.24758859749826	332607200	58.26128054544235	121.14262662615094	131.80399945153118
1	2941	111.23466214416847	110.131591796875	116.15456397882693	109.99492847765607	231366600	46.99500909461482	120.95140130179269	132.32868253445062
1	2942	114.46579279058768	114.52436065673828	116.30099125669896	112.51345114458287	176940500	51.612900704004815	121.06383514404297	132.12729206470172
1	2943	117.49190960695671	110.78561401367188	117.6285729132893	109.81920707672238	182274400	45.33169832923972	120.73019300188336	132.76146771284044
1	2944	111.83990528016459	109.33114624023438	112.4841816810679	107.37880434308732	180860300	36.7402816878753	119.86767687116351	133.33568544059406
1	2945	111.98631998364145	112.61106872558594	113.16748580661752	110.11207375780796	140150100	39.181738823525244	119.13572311401367	133.01123335366938
1	2946	115.51029888610626	112.78678131103516	115.99838431287328	110.90277126581074	184642000	40.260158277080656	118.48831340244838	132.66079815655482
1	2947	112.4841897033411	109.45805358886719	113.23583811040857	109.37020177207485	154679000	35.42607199805248	117.4847766331264	132.10874295459593
1	2948	107.1054721687997	107.710693359375	109.52637182628673	106.11953747604608	178011000	35.22808422535162	116.4618900844029	131.70617492542164
1	2949	107.76926356908416	104.2940902709961	108.23782140747392	103.56196213186861	287104900	33.03432133831582	115.20907919747489	131.40490011417822
1	2950	102.0489062682896	107.45689392089844	107.56427331516774	100.64321779610452	195713800	31.755205232563213	113.88706534249442	129.3036055508437
1	2951	109.99493172137502	109.14566040039062	110.17064277235137	106.55881360489528	183055400	26.9618931896609	112.32728358677456	124.33483430789165
1	2952	108.96019760104794	104.56742858886719	109.43851925260384	104.2257628187344	150718700	25.941337827142206	110.6343242100307	119.12948258916282
1	2953	102.6638883387229	105.6412124633789	107.62283813261864	102.49794107868442	167743300	34.5760273593028	109.75158745901925	117.48405430268134
1	2954	105.84619065741477	109.60444641113281	109.76063729998137	105.10429883056716	149981400	40.35980773727775	109.1463601248605	115.22004537875034
1	2955	112.26942309882642	112.22061157226562	112.57203371024211	110.09255860233831	137672400	52.704772321098716	109.29557582310268	115.57276276779967
1	2956	111.82037541240005	111.37133026123047	112.56225990652231	110.86372468906299	99382200	45.50514944550959	109.0703593662807	114.73586764323339
1	2957	111.07848448876676	113.05034637451172	114.46579860836158	110.91253722784417	142675200	53.42994961431367	109.23212596348354	115.2282859693133
1	2958	114.83673990006338	114.00699615478516	114.91483535664295	113.06987301860818	116120400	57.19001842105449	109.5661152430943	116.08421276483409
1	2959	110.19991323023964	110.32681274414062	112.6208199201359	109.54588062787111	144712000	46.5302285305558	109.4029541015625	115.70344008766611
1	2960	111.19563592722352	113.72391510009766	113.8703422313761	110.84421379119257	106243800	51.29660765753479	109.46989222935268	115.94279644698295
1	2961	112.942968471818	110.4635009765625	113.35296590389312	109.5751818959247	161498200	51.39376028245363	109.54170989990234	116.03632301882055
1	2962	111.88870036047932	112.33773803710938	112.79653950711614	111.41037130371913	96849000	56.391568570913066	109.87221309116909	116.43600414687468
1	2963	113.47986712829248	112.2303695678711	113.62629425281531	111.85941985940086	83477200	62.0658952961493	110.43909018380302	116.25597410145447
1	2964	112.5329700547584	114.18270111083984	114.21198504359523	112.18154796650919	100506900	60.61630992955818	110.91950498308454	116.7861617711352
1	2965	117.19908310505474	121.4356689453125	122.19708110269691	116.43767094767033	240226800	66.50065720897607	111.79736273629325	119.8071971081962
1	2966	122.28490951265286	118.21427917480469	122.4020526865995	116.79883453234461	262330500	69.01516433629772	112.77213777814593	120.29878707072751
1	2967	118.11664921581988	118.3021240234375	120.09827445319799	116.76953639349951	150712000	68.1397847699312	113.6764886038644	120.52416552198386
1	2968	115.89100965397931	117.83358764648438	118.31190929891578	115.33459254265503	112559200	63.10227257819139	114.2642844063895	121.01837370838476
1	2969	118.3900013910462	116.18385314941406	118.65357169541609	115.97885816134452	115393800	56.51055309433941	114.54737309047154	121.26460223845756
1	2970	117.10146475385224	113.21630859375	117.55050249133377	112.90393419169357	120639300	52.833604907886894	114.67915725708008	121.1974189377052
1	2971	113.43104998711324	114.7098388671875	116.14481121078373	112.87463289955475	124423700	52.563331721968076	114.79769243512835	121.24836558014627
1	2972	113.88985961376322	114.08509826660156	115.8812491871557	113.6751008194376	89946000	50.121890088169984	114.80327115740094	121.25113310975047
1	2973	114.65127845604545	112.99179077148438	115.2272232061606	111.85942886147818	101988000	54.52441940952405	114.99362673078265	121.01548409953716
1	2974	113.61653533679018	112.2987060546875	113.77272626234561	111.55681405348567	82572600	47.3357622696416	114.89182608468192	121.05272843305147
1	2975	111.29323030852764	112.3084487915039	113.77270492986723	110.19015258450182	111850700	53.926028869554486	115.02360807146344	120.84611022358162
1	2976	112.73797527774974	113.82152557373047	114.48532208435297	111.81061590078274	92276800	53.20677475129247	115.12959289550781	120.79334599451161
1	2977	112.30846534999783	108.55020141601562	112.67940761194099	108.45258581525088	143937800	43.49774225195707	114.86672374180385	121.38697187158873
1	2978	109.69232790650396	112.57202911376953	114.14366487566086	109.52637319152939	146129200	47.34813389339979	114.75167574201312	121.37986142775195
1	2979	108.41353361193957	106.26596069335938	109.32137281201784	105.15312650585602	190272600	24.220250764449872	113.66812515258789	120.54453289662771
1	2980	106.51000254927477	106.1781005859375	108.04259049320906	104.76265582569741	122866900	27.107280193867624	112.80839811052594	120.22483141567952
1	2981	107.04689181264476	107.80830383300781	108.83327868826885	106.13905268507524	107624400	31.146962149892673	112.05883952549526	119.19952479785033
1	2982	111.42014987351149	112.21084594726562	112.83559474956894	109.67280300695923	138235500	41.14935505379195	111.6572151184082	117.98499671549587
1	2983	115.13935999567666	116.1936264038086	116.76957113416694	114.085101035138	126387100	50.01433127966804	111.65791320800781	117.98784779195431
1	2984	115.69979834059455	116.06160736083984	116.56030801793857	113.55829359507692	114457900	54.5507148475432	111.86114883422852	118.5775327836478
1	2985	117.83148958484668	113.74405670166016	119.28849097709733	113.48003921920852	154515300	48.495016041732995	111.7921643938337	118.40149524785375
1	2986	112.99114291978354	113.40184020996094	114.98596046077127	111.60258321515705	138023400	48.92581662453383	111.7433602469308	118.28954507263124
1	2987	114.59482539259994	116.84388732910156	116.98078642695639	113.86143417104567	112295000	55.63957862718746	112.01851000104632	119.09322414216807
1	2988	116.9710077146568	116.57008361816406	117.86085180861238	115.94425706888252	103162300	56.331144011254196	112.3236083984375	119.80697986599463
1	2989	116.79501751530603	116.61900329589844	117.01992001427867	115.25978528064516	81581900	56.38180136199495	112.6315051487514	120.45898611661177
1	2990	116.2865036361308	117.63594818115234	118.31066299322224	115.53355864107166	91183000	55.731473512036736	112.90396390642438	121.16349952551846
1	2991	116.9025617517305	116.74610137939453	117.99775451631758	116.32562345429308	74271000	64.18239278510654	113.48938533238002	121.57971165811347
1	2992	115.98337162832838	115.41621398925781	117.16657517577093	115.3868795355888	76322100	55.42727647805071	113.6925413949149	121.82636059484034
1	2993	114.98595989049652	116.01271057128906	116.4234078594296	114.22323422382374	74113000	73.7805436484624	114.38873781476703	121.37135865280958
1	2994	116.01272303857971	114.74150848388672	116.1398415098722	114.69262020743976	73604300	69.7527820336431	115.00040980747768	120.14245718223412
1	2995	114.58503980139257	111.32878112792969	115.01529835344873	111.2309971280372	127959300	57.50347337856965	115.25187247140067	119.046659041963
1	2996	111.38747584073998	112.61956787109375	113.28450962449006	110.09669997199227	113874200	51.004367532674	115.28106689453125	118.9801549074966
1	2997	112.99115164697129	113.46051788330078	114.16457469823683	112.61956196106514	76499200	42.05741003021534	115.08584485735211	118.86508532829833
1	2998	113.98856385720809	114.00811767578125	114.88818872041372	113.6463160788627	46691300	44.17316810536119	114.93916702270508	118.71466789585406
1	2999	114.37970265524602	116.41364288330078	118.29112272745515	114.22324227134564	169410200	57.53739098066991	115.12985174996513	118.91498718342466
1	3000	118.33023398098608	120.00236511230469	120.73575635202906	117.35237899468692	127728200	65.7489385343874	115.60131781441825	120.04609010748882
1	3001	119.3178692147776	120.35440063476562	120.63797949284637	118.21289570055283	89004200	59.82486782880521	115.85206876482282	120.94730198652545
1	3002	120.78463369128563	120.21748352050781	121.03887805363206	119.5036461625339	78967600	60.286790393670834	116.11259732927594	121.71385004480582
1	3003	119.88501813402209	119.54277038574219	120.1392625157906	118.8289329732372	78260400	57.964777602918346	116.32143783569336	122.21444916307443
1	3004	119.60144600465969	121.00955963134766	121.81140045533569	119.54277709036162	86712000	58.970367232738695	116.56241008213588	122.94272222624528
1	3005	121.61582191486363	121.62559509277344	122.21231402677293	120.3641613213804	82225500	63.16619421405088	116.91094534737724	123.84366973707692
1	3006	121.77226899352718	119.08316802978516	123.16082115520817	118.32044240464886	115089200	59.286753524787024	117.17287063598633	124.1393294165706
1	3007	117.83152090843531	120.5108413696289	121.12689475984914	117.48927316966918	81312200	60.93153493042765	117.4941656930106	124.64266485473277
1	3008	119.7187725648931	119.69921875	120.04146646393382	117.88040808687671	86939800	62.32370713508425	117.84828785487584	124.8999190476746
1	3009	119.8850087460106	119.08316802978516	120.61839991794024	118.84848494369109	79184500	72.38842496426031	118.4021726335798	124.3850663833438
1	3010	121.58648808049752	125.048095703125	125.06765698112699	121.3811394241266	157243700	78.25694336996546	119.28992462158203	125.26500447517115
1	3011	124.58850113943829	124.9796371459961	125.5272335235299	123.7573184744002	98208600	77.14277085171514	120.1127188546317	125.79516451921297
1	3012	126.04551309902716	125.84994506835938	126.71046230835884	125.20455713835977	94359800	77.48517839055384	120.95856366838727	126.23773534481069
1	3013	126.1041872805181	123.85511779785156	126.24108638359085	123.32707520295313	192541500	67.60753411229682	121.49009759085519	126.27323137841994
1	3014	122.25142905164114	125.39034271240234	125.46857290305822	120.71619699711728	121251600	64.12091052002465	121.8749531337193	126.99744260460557
1	3015	128.6954934124312	128.9595184326172	131.4334903171584	126.77889110285736	168904800	69.29818257724304	122.48960440499442	128.76212098279896
1	3016	129.23329830364477	128.05987548828125	129.49730836550714	127.88385385949238	88223700	67.00588503501706	123.04977525983539	129.82851614419525
1	3017	128.41193131877873	129.0475311279297	130.50454051249665	128.1968020157988	54930100	70.33467612935239	123.7286867414202	130.8876062343423
1	3018	131.0228189408006	133.66302490234375	134.2986247912925	130.55343771852372	124486200	73.85688644339834	124.63250568934849	133.3401309556737
1	3019	134.99287186176662	131.88328552246094	135.71647493804102	131.36502361939029	121047300	68.52690481124962	125.3651978628976	134.68747003783716
1	3020	132.57761567057273	130.75880432128906	132.97853990131875	130.4458834814228	96452100	72.2263679388191	126.1991718837193	135.18343812398751
1	3021	131.11078939653768	129.75157165527344	131.75617722441675	128.8030511896917	99116600	67.87732082472948	126.85922404697963	135.38959432808218
1	3022	130.56319677250616	126.5442123413086	130.6512001367724	123.95289523825686	143301900	62.119075014271054	127.34815216064453	134.83106196897273
1	3023	126.03571704206242	128.1087646484375	128.8226094660816	125.58589722438096	97664900	65.46057093927108	127.99283763340541	133.76892094968065
1	3024	124.89164039803205	123.79644012451172	128.14789930215	123.5813108332451	155088000	47.72727713512545	127.90343366350446	133.91000811508715
1	3025	125.51747590823786	128.02078247070312	128.71506612744008	125.02854837897873	109578200	54.79791554174176	128.12065832955497	133.8869027272945
1	3026	129.49735301668466	129.1257781982422	129.69293598741686	127.34607462660249	105158200	55.13018484771582	128.35464641026087	133.9883018243726
1	3027	126.3290819935513	126.12372589111328	127.28737565620342	125.65435969810358	100384500	53.44414481135278	128.51668984549386	133.70580193454285
1	3028	125.65434107799788	125.94770050048828	126.81799067065245	124.05065981204774	91951100	50.882591441373535	128.55650111607142	133.6499613158774
1	3029	125.90862641905905	127.99146270751953	128.53905921581872	125.64461626598423	88636800	48.38924012147251	128.48735427856445	133.5835293774931
1	3030	127.90343555467703	126.05529022216797	128.09900356831466	125.9086030212775	90221800	46.775762302833044	128.34416961669922	133.6021576399563
1	3031	125.92816740358766	124.3244857788086	127.33628100990751	124.18758667379879	111598500	42.58067299706251	128.00680923461914	133.66150628911444
1	3032	124.95031843516219	124.99921417236328	125.8597314002734	124.12892376536658	90757300	34.46709549213482	127.38796561104911	132.21137022992454
1	3033	125.81081955583028	129.10618591308594	129.55600574850897	125.70325491611274	104319500	45.40455797150119	127.18960135323661	131.40698322350875
1	3034	130.83699752771275	133.83900451660156	136.57700140751876	130.63164141951881	120150900	54.55325689234308	127.40961565290179	132.63096742282136
1	3035	133.26208668957645	135.9903106689453	136.75303642382855	132.02999468266142	114459400	58.92058523081569	127.85523986816406	134.7381419250707
1	3036	139.90172260354075	139.75503540039062	141.8769789688564	133.51631569933016	157611700	68.5933946094512	128.79887008666992	138.10373756456534
1	3037	140.419974133378	139.98971557617188	141.1044696012595	138.23934689307262	98390600	67.37199080788024	129.64750943865096	140.686781304225
1	3038	140.2537497289202	138.91409301757812	141.10449381150278	137.30063807210604	140843800	74.41559699338987	130.72734178815568	142.2481988510994
1	3039	136.43033358916676	134.05413818359375	138.8456366294971	133.67277533095648	142621100	59.548074577957436	131.15829576764787	142.6943928482724
1	3040	132.8220128446859	129.0377197265625	133.71186425062007	127.32647390940271	177523800	49.875995090514344	131.1520058768136	142.69297174390022
1	3041	130.7881317015279	131.16949462890625	132.38204043638706	128.0305729028797	106239800	57.284044003023055	131.5124179295131	142.68626518509106
1	3042	132.72427464460634	132.00067138671875	133.2914324191767	131.62908165695893	83305400	58.57581992242822	131.9447729928153	142.64967599397255
1	3043	132.75359589858172	130.97390747070312	132.76338399842402	130.6512135144698	89880900	54.35089555557881	132.15780476161413	142.64020237381007
1	3044	133.28166038476758	134.34751892089844	134.35729210091307	131.6095215073622	84183100	61.610072212647566	132.75010681152344	142.66908325319935
1	3045	134.50908231283685	133.9312744140625	134.57762667448057	133.04989583580434	75693800	63.964655756947444	133.43630599975586	142.09330318601675
1	3046	133.21641330907664	134.07821655273438	134.12718536306636	132.12937146971123	71297200	63.40311118089221	134.08480616978235	141.25110543973804
1	3047	133.79417608953227	133.19679260253906	135.02812408017564	133.04011336544966	76774200	56.67451761483879	134.37699236188615	140.9803292020364
1	3048	133.65708128237208	132.58963012695312	134.15654214720848	131.62010163331232	73046600	47.6442727912486	134.28775133405412	140.95585968101403
1	3049	133.08906945057942	132.3350067138672	133.56893978199793	131.00313604563317	64280000	42.576894711726176	134.02665819440568	140.69384656476285
1	3050	131.57114601186336	132.57003784179688	132.72673203035987	130.92479369142617	60145100	32.96702183689179	133.51344408307756	139.33349028404658
1	3051	132.6875497490638	130.43511962890625	133.19678338492807	130.0433842053432	80576300	29.221612681861075	132.83097294398718	137.50826015257638
1	3052	128.53522064251587	128.13369750976562	129.48515832576604	126.7920394170657	97918500	27.742521655631975	132.06094469342912	135.89837726401475
1	3053	126.52764642744	127.02710723876953	127.31110235363661	124.77467705464633	96856700	32.83083625778305	131.55901391165597	136.05512349421886
1	3054	127.54614162419251	127.18378448486328	128.00642141328152	126.13592396767972	87668800	44.05956109020948	131.4265899658203	136.33306785747158
1	3055	125.36227259235844	123.39385223388672	127.03691001910353	123.00212422454044	103916400	27.478252107168956	130.87118693760462	137.39638353008914
1	3056	121.20017424260931	123.2567367553711	124.08915402582353	115.94124359187607	158273000	23.612709350124177	130.24662017822266	137.88502647382649
1	3057	122.35577030880219	122.75728607177734	122.96294158036311	119.70182426240041	111039900	24.388919143228804	129.65971864972795	138.25955578214666
1	3058	122.10114407243823	118.48746490478516	123.8443257123782	118.04677560357413	148199500	3.180251647175041	128.52685764857702	138.53050992741112
1	3059	120.05436932756292	118.75188446044922	122.2676260307955	118.69312040778983	164560400	4.784299715514621	127.4426155090332	138.18608132268676
1	3060	121.19038166136916	125.14682006835938	125.28392374079455	120.25023899113235	116307900	30.612179327934285	126.80465861729213	136.89141027927073
1	3061	125.75399459438512	122.53204345703125	126.05758022008334	122.42431807921778	102260900	28.469733020684828	126.04289082118443	135.6495410500403
1	3062	122.22845904908286	119.53533935546875	123.10984517040185	119.31988858452522	112966300	25.964630450918477	125.11044148036412	134.51176845266113
1	3063	119.23175875743435	117.645263671875	121.04349240645305	116.16650144793978	178155000	24.48977266464007	124.06117412022182	133.26605832083075
1	3064	118.47767529541255	118.9085693359375	119.41781793599817	115.13820351970436	153766600	27.09355761904689	123.08535494123187	131.24132687267397
1	3065	118.42871440428695	113.95323944091797	118.49726624291924	113.80634050910875	154376600	24.75245210497812	121.90807778494698	130.25004500331363
1	3066	116.56800681928502	118.58539581298828	119.53533372838129	116.33297302186078	129525800	36.34837099785177	121.22605623517718	128.91084805944962
1	3067	119.17298172916317	117.49835205078125	119.64304928541645	116.97930822801749	111943300	36.36869856009186	120.54543086460659	127.68556996478154
1	3068	120.00540599736276	119.4374008178711	120.66154604698784	118.75188247820154	103026500	39.45614513873225	119.99211774553571	126.03208646146585
1	3069	117.90968290169207	118.52664947509766	118.66375315807669	116.6953327931963	88105100	42.81167900187361	119.64446040562221	125.39431398901785
1	3070	118.89878489040193	121.4254150390625	121.43521029322805	117.92925646093556	92403800	47.49932752136774	119.51365171160016	124.98613838941952
1	3071	123.10004095769754	122.97273254394531	124.58860573684278	122.14031528444951	115227900	50.28600771154331	119.52904074532645	125.04188225069045
1	3072	121.48417554210349	122.17948913574219	123.25673544318819	119.80953829345351	111932600	55.399610762868626	119.79275676182338	125.44249386316143
1	3073	120.33837901517603	118.0369873046875	120.63217688102142	117.83133178723176	121229700	49.06097570019207	119.74169267926898	125.44462784642982
1	3074	117.42002094580913	117.5081558227539	118.91837362659142	117.2045701733795	185549500	38.13866559380775	119.19607380458287	124.07323443347524
1	3075	117.84111686267951	120.83782196044922	121.30789701087852	117.77256502944914	111912300	47.42634847101468	119.07505798339844	123.67165797200592
1	3076	120.77906994302474	120.00540924072266	121.67024380868072	119.61368126250025	95467100	50.76433008817962	119.10863440377372	123.72653564155137
1	3077	120.27960781745544	117.60607147216797	120.35795490170756	117.58648843689953	88530500	49.93731196334733	119.1058349609375	123.72760352799583
1	3078	117.0674485815543	118.0957260131836	119.1436014226742	116.53861698603541	98844700	48.66686070038832	119.04777472359794	123.70053677234985
1	3079	117.86070645319991	118.70291900634766	118.96733857179096	116.4602839493928	94071200	59.08580101869555	119.38703754970005	123.02063626274955
1	3080	119.13382812372708	118.87920379638672	120.04459257191542	118.23285893048003	80819200	50.67753729006196	119.40802383422852	123.02503400768236
1	3081	117.62566893236145	117.42001342773438	117.90967152587207	116.40152368701725	85671900	49.82239522217548	119.40242821829659	123.0323838923769
1	3082	119.1338388205137	119.62349700927734	120.9651556646715	118.64418063175005	118323800	50.416907663635236	119.41572080339704	123.04759058098772
1	3083	121.10224675861323	120.45589447021484	121.61148790302033	119.95644110841515	75089100	54.337276738392596	119.55352401733398	123.18648047535127
1	3084	121.307902963467	123.29591369628906	123.55053800574892	120.52444699817042	88651200	54.216342009879696	119.68713106427874	123.73097933595209
1	3085	123.88350517152779	123.59950256347656	124.50047171699698	123.05108785639284	80171300	51.49674240988792	119.73190035138812	123.94286469778805
1	3086	123.227370330931	125.25455474853516	125.27413778679839	122.55163970119949	83466700	57.05302768084348	119.95154789515904	124.95810690036143
1	3087	126.28281119159718	127.66365051269531	127.69302880095884	125.86171243103459	88844600	73.9872507621331	120.63916669573102	126.9796305808733
1	3088	127.11523022757024	130.24903869628906	130.2882047645079	126.79205412784927	106686700	78.79586505384225	121.5492297581264	129.4253127615756
1	3089	129.7789750855431	128.52545166015625	130.10215119503505	127.92806823530955	91420000	68.73506737970142	122.09834616524833	130.7904537909182
1	3090	129.7006303088981	131.6494598388672	131.8747133072664	129.20116952027027	91266500	75.52592768019824	122.93006406511579	132.8946970746789
1	3091	132.14893180014175	129.2991180419922	132.2076883818472	128.93677582602234	87222800	75.68851917716607	123.7652816772461	133.76772635989414
1	3092	131.05208979209115	131.718017578125	132.20767563603624	130.87580512079055	89347100	77.58830028044098	124.73830250331334	135.01158820773855
1	3093	131.52215920241792	131.3850555419922	131.8845013885763	130.52325256607145	84922400	75.97276401384862	125.64416939871651	135.86137120798128
1	3094	130.74847229706486	132.05096435546875	132.66793821028534	130.58199037213484	94264200	76.4451519159171	126.58500943865094	136.5412395550273
1	3095	132.22727854894646	130.35678100585938	132.72672443533338	129.08366694720192	94812300	75.73055968301139	127.50906426565987	136.11024504813918
1	3096	129.6223037902088	130.7387237548828	130.98355282558484	128.5842309213411	68847100	73.8346440333022	128.30300903320312	135.7421914452398
1	3097	130.2882067566081	129.21096801757812	131.37524822022579	128.69193168247196	84566500	68.23006439924802	128.92837142944336	134.84137541410053
1	3098	129.42642164716978	131.541748046875	132.3251889861631	129.42642164716978	78657500	67.54172009153913	129.51735959734236	134.5976445911704
1	3099	132.04118178165103	131.93345642089844	132.26642028388767	130.79744624263049	66905100	67.66295841148698	130.11264201572962	134.02458218125895
1	3100	132.21747705876876	131.6103057861328	132.60921251142065	131.3360984408663	66015800	64.2763549119575	130.5666242327009	133.36729632059183
1	3101	131.53195903398662	130.8170623779297	132.22728012474528	130.3274042682398	107760100	57.637650822371825	130.79186793736048	133.03942456913404
1	3102	133.64727689450586	130.7191162109375	134.23487256489253	129.71042176654404	151101000	51.294521635869934	130.8254449026925	133.05201560807143
1	3103	129.05427915465984	128.74090576171875	130.79746068058364	128.35897306655968	109839500	50.58512198881803	130.84083448137557	133.0009110014844
1	3104	129.30888019992344	129.7985382080078	131.2969054604684	129.10323220470684	75135100	44.33784182440784	130.70862579345703	132.8820366536773
1	3105	128.47649401215057	125.20557403564453	128.77029185928455	124.07935891708368	137564700	38.98832355815625	130.41622979300362	134.03039013368033
1	3106	126.52767085494165	125.45043182373047	127.75181630621465	125.32311591497991	84000900	30.906928174694855	129.96854509626115	134.35771356325165
1	3107	125.24476966777024	127.05651092529297	127.06629870942452	124.50048713627072	78128300	37.763045000252355	129.6593633379255	134.22497842285614
1	3108	128.36122497019778	127.7333984375	128.76341535016718	127.01727233833384	78973300	37.80165423219088	129.35096577235632	133.80254430446408
1	3109	126.9485841924531	124.43727111816406	127.07610137244308	124.39803103278507	88071200	34.66391471207261	128.92814363752092	134.04323813855783
1	3110	121.15098741607423	123.51515197753906	123.86829776786942	120.43486897470133	126142800	31.794940620628083	128.41217422485352	134.15884575552323
1	3111	121.05289749441623	120.43487548828125	122.26931023704257	119.92476933307705	112172300	29.4874263968986	127.78531047276088	134.9068178495453
1	3112	122.21044375165756	122.59302520751953	123.7505814669759	121.89653057032774	105861300	28.91377047046612	127.1461159842355	134.42000178294893
1	3113	123.84868340711706	125.0258560180664	125.45748946807893	123.45629004204031	81918000	35.15163521874365	126.65271595546177	133.44919153807587
1	3114	124.40782788620018	123.8682861328125	124.51573623687771	122.78921011031724	74244600	33.93431504233786	126.09971455165318	132.40034372397136
1	3115	124.15279336414982	122.4753189086914	124.57461495126144	122.4066506263375	63342900	33.11019957222827	125.50387573242188	131.4505827611143
1	3116	120.81746165373089	122.318359375	122.54398051145846	120.52316475438042	92612000	33.031263908117964	124.90382167271206	130.2485150163566
1	3117	122.84808726328852	124.88851928710938	125.29072454392407	122.72055511635658	76857100	42.40027982334045	124.62865121023995	129.49788379663238
1	3118	125.38880628218745	123.04426574707031	125.56538290126355	122.82844904772396	79295400	37.076725446689245	124.14620317731585	128.05200141937203
1	3119	123.61324616401438	124.68251037597656	125.50653716294948	123.54457788879003	63092900	48.8716124425964	124.10884148733956	127.98084796196179
1	3120	125.38881230292144	124.48631286621094	125.8793095877115	123.91734290139242	72009500	47.9157629733525	124.03997584751674	127.84287499647479
1	3121	124.54517948188607	124.43727111816406	124.96700104435908	124.01544955569106	56575900	43.9290146587552	123.85288728986468	127.2528857584023
1	3122	124.03508059261084	122.89714050292969	125.21225328568384	122.70094754884467	94625600	39.22163609925036	123.50744029453823	126.0946502878818
1	3123	123.18161536711065	122.23987579345703	123.40724398155514	122.18101940894144	71311100	44.44994706564053	123.35048348563058	125.96120804065345
1	3124	122.70092433172036	121.9161376953125	122.96578551804699	121.5826082396212	67637100	45.835419736660135	123.23626817975726	125.95368884653693
1	3125	121.91614963197536	122.68131256103516	122.85788919730133	121.69052850380683	59278900	56.653080850144626	123.39672797066825	125.62237780937157
1	3126	122.3085475666937	121.19023132324219	122.47531231710921	120.78802605947189	76229200	45.67455830937329	123.29652840750558	125.7884267202777
1	3127	121.71013896844204	123.49552154541016	123.76039022925093	121.49432225843265	75169300	45.24388532059624	123.18721880231585	125.47852712398983
1	3128	123.77019414528634	123.50533294677734	123.91734258191596	122.45568507576401	71057600	48.78532286620194	123.1612935747419	125.42748245867834
1	3129	124.1920091652742	124.329345703125	126.01663920589188	123.80942774064985	74403800	56.45042185972905	123.2937240600586	125.60350220800866
1	3130	124.79041711685983	124.7119369506836	125.32014701212847	124.11353878108089	56877900	58.19887239403801	123.46469388689313	125.8174177447667
1	3131	124.60402174580177	123.71133422851562	125.7517735312842	123.54456949776593	71186400	45.48190019279288	123.38060923985073	125.59415672607378
1	3132	124.1233618276829	124.92776489257812	125.01605695853118	123.70154025192801	53522400	57.59499200734413	123.51514489310128	125.86536527035734
1	3133	125.38881286313571	127.99821472167969	128.05707110303408	124.65307815908407	96906500	61.98578681099018	123.75198091779437	127.07562054009131
1	3134	127.46849885575233	127.17420196533203	128.11594902096468	126.92895705140872	62746300	59.29445831242584	123.94397299630302	127.72886954703785
1	3135	127.89029331217941	127.67447662353516	128.4004068461167	126.01663383321781	91815000	60.85518960579657	124.17520196097237	128.45332033861186
1	3136	127.3311548569367	129.28329467773438	130.028848752344	127.18399893605076	96721700	71.3162371396557	124.63135583060128	129.62453782658125
1	3137	128.22386736954957	127.97862243652344	129.00863918038294	127.76280569797542	108953300	68.36168508151077	125.04126630510602	130.13005369428046
1	3138	127.821640717313	129.78359985351562	129.8915082047492	126.75237658053705	79663300	72.99324921535172	125.60322788783482	130.93710503792576
1	3139	129.6168373736392	131.431640625	131.52974457093757	129.11652820534232	74783600	74.31853697323085	126.22825132097516	132.1098247234943
1	3140	131.2256581855365	131.156982421875	131.76520001229738	130.69592076705774	60214200	79.7077891067665	126.94016211373466	132.6036008783429
1	3141	131.89269442179855	130.8724822998047	132.07908292691275	130.40160134944472	68711000	75.00011635020273	127.4670878819057	133.12265649971852
1	3142	130.92156545642365	130.57821655273438	131.3433795686376	130.28391963079545	70783700	73.51622265931579	127.97229385375977	133.36068849622387
1	3143	130.8725084917287	132.21644592285156	132.67750759033626	130.81365210329452	62111300	74.87648123852765	128.53565815516882	133.93256708604258
1	3144	132.2360711979133	133.73696899414062	133.89392934410813	131.79463331112223	64556100	76.55912307872615	129.18030330113	134.76259348517797
1	3145	133.57999815698017	134.35498046875	134.79641832088436	133.2857012660367	63261400	82.04399432935844	129.94056374686105	135.204434795625
1	3146	134.00183352943276	134.65908813476562	134.71794452202494	133.17779920211535	52485800	81.00027901378834	130.63565826416016	135.61018508271164
1	3147	135.27708203046927	137.29791259765625	137.3371451958311	135.1299410766124	78852600	80.46301442715247	131.2999223981585	137.16182807624293
1	3148	137.40581837883465	139.3187255859375	140.4272223441988	137.40581837883465	108181800	86.88941428173489	132.16738837105888	138.9251980653196
1	3149	140.80978308805595	141.82020568847656	142.1341113275359	139.946531354224	104911600	88.31055428848424	133.17779758998327	141.16083007132994
1	3150	138.8871036011299	140.51553344726562	141.31992899374495	137.99440850816325	105575500	80.92955559215723	133.98010035923548	142.5156762805427
1	3151	140.0348627208468	142.3499755859375	142.8796980776628	139.9367587560338	99890800	88.45168681162107	135.00662558419364	143.8829848609276
1	3152	143.42902270895124	141.7515411376953	143.53693105527248	141.26105137597318	76299700	84.23127785027518	135.8614785330636	144.87513925397886
1	3153	141.29051033026613	142.86988830566406	144.6552786120108	140.89812442287007	100827100	83.73853766379428	136.67849622453963	146.02974215728327
1	3154	145.2831239858001	146.31314086914062	146.72516558475462	144.87109927018608	127050800	87.66459018730784	137.76107897077287	147.83969790437004
1	3155	146.4013767066168	145.65582275390625	147.14691569076902	144.29226193391412	106820300	86.0697343506494	138.81703186035156	148.88440525493004
1	3156	145.6362410789104	143.60560607910156	146.91150261100321	143.10531186121412	93251400	79.27677940098306	139.7475596836635	148.90135738096427
1	3157	141.01583140906914	139.7405548095703	141.3297520969418	138.97539184358348	121434600	65.37069847994982	140.28499603271484	148.35321831141422
1	3158	140.73134040588818	143.3701629638672	144.3021055613893	140.24085060448107	96350000	68.11801082165732	140.97308131626673	148.23893025901316
1	3159	142.76197734387125	142.6344451904297	143.35057116284176	141.87910158397807	74993500	65.50328835899771	141.56447165352958	147.78207194380954
1	3160	143.16418458989693	144.00782775878906	145.38119339718892	143.03665243470164	77338200	66.8314984805254	142.23223876953125	147.1212589661758
1	3161	144.74354520106823	145.7343292236328	145.89128955450275	144.12552325361847	71447400	65.70486982792755	142.834839957101	147.14998156886062
1	3162	145.44986711096914	146.1561737060547	146.980193077467	144.89070148629196	72434100	63.533996956731585	143.32322910853796	147.46848832049264
1	3163	146.28368684924823	143.9783935546875	146.37198639761627	142.78159713322313	104818600	54.32735523419712	143.47738538469588	147.5415923044736
1	3164	142.05564738076365	142.222412109375	144.17456681822588	139.82881959319283	118931200	53.36160161555937	143.59930528913225	147.37277815073784
1	3165	141.93796054917624	142.86988830566406	143.7625834588374	141.8300521793579	56699500	51.07415933232075	143.63644191196985	147.36693923072576
1	3166	141.63384765830753	143.085693359375	143.5467549956197	141.36897895973763	70440600	52.8006893216012	143.7317384992327	147.32028078664413
1	3167	143.57617073717145	142.7521514892578	144.1549450921184	142.48728281365686	62880000	49.74442240656314	143.72332872663225	147.32111141972618
1	3168	143.03665309613856	144.5571746826172	145.22423371904952	142.41863107171932	64786600	45.89636410706632	143.59790257045202	146.91851692753585
1	3169	144.46888896008065	144.15496826171875	144.9789876420746	143.49771363915664	56368300	46.450225199214685	143.4906986781529	146.61629761458403
1	3170	144.184398242406	144.26287841796875	145.02804141900194	143.3898070466071	46397700	51.71184017155362	143.5376467023577	146.69030850881845
1	3171	143.7814704987235	143.5751495361328	144.52812661902823	143.07410575696633	54126800	61.967768972874126	143.8115463256836	146.087565393015
1	3172	143.6341167997497	143.5260467529297	144.1253415596606	142.96605832194606	48908700	50.62654243757881	143.8226808820452	146.09091022334624
1	3173	143.86988581764166	143.0446319580078	145.11760069486573	142.74989415357072	69023100	51.683066158111295	143.8519799368722	146.06399239372791
1	3174	143.48674714232632	143.30007934570312	144.1449864839524	142.97586922382953	48493500	46.80265862626613	143.80142647879464	146.03038095563122
1	3175	143.62424572341376	146.27685546875	146.43405093286975	143.2803825195249	72282600	52.202161593013535	143.84017835344588	146.22715490572313
1	3176	146.35547686412104	146.4832000732422	146.8172292452653	145.66776533613606	59375000	51.35106511740498	143.86353737967355	146.35237249608167
1	3177	145.9330517613623	148.4677734375	148.53655210271248	143.89938895751348	103296000	68.84815948955143	144.18420737130302	147.6870705560078
1	3178	147.59336852823333	147.5540771484375	149.0179171538943	146.47337681670123	92229700	74.08801996442801	144.5650405883789	148.30071355260625
1	3179	147.1709185119843	143.79129028320312	148.07477013277662	143.58496931962586	86326000	53.24840901388448	144.630855015346	148.26907424758244
1	3180	142.48461669078313	144.12530517578125	145.40249222732663	141.9639197760047	86960300	53.63486206815606	144.70511300223214	148.24868503566745
1	3181	144.85232016522875	145.5891571044922	145.89371397416332	144.20390006084028	60549600	59.192625568834686	144.90775626046317	148.2910868543539
1	3182	145.7070661365483	147.08250427246094	147.5540757805797	145.2944391930709	60131800	58.351398594341035	145.08813694545202	148.65523488209826
1	3183	146.8270497434487	146.9940643310547	148.21230690010609	146.53231194550222	48606400	59.58801965187691	145.29092952183314	148.9510942004183
1	3184	147.18074371467267	145.75619506835938	147.681802508009	145.2060257973133	58991300	54.685534049190785	145.39759499686105	149.01549559584527
1	3185	145.74637338262988	144.95057678222656	146.5028486213895	144.9211044997288	48597200	54.28394362341598	145.49583980015345	148.9725006502342
1	3186	144.89162045275756	145.99197387695312	146.13933527747687	144.25303439583894	55802400	57.23333384059963	145.67197745186942	148.96369322735632
1	3187	146.3849609641259	150.43264770507812	150.7961641778543	146.00180629681233	90956700	67.58646290461894	146.19969286237443	150.0056514934322
1	3188	149.9807486283296	149.16531372070312	150.11829096268886	148.6347825803244	86453100	63.31995276140629	146.61863817487443	150.33997911021848
1	3189	150.14774978126363	149.83335876464844	152.2600100818127	149.6663441586924	80313700	59.022997360603235	146.87267412458147	150.96098252105392
1	3190	151.169478682178	150.95333862304688	152.00456663709258	149.7252769193417	71115500	60.83847160735176	147.19196973528182	151.8127988355245
1	3191	151.06138796700714	151.5919189453125	151.91612898961347	150.4031487828757	57808700	58.10387192380277	147.41512298583984	152.57201277160834
1	3192	152.25017314379147	153.9399871826172	154.4999755027351	151.68035073618864	82278300	65.41745042000338	147.87125941685267	154.09949816452817
1	3193	154.22488595370393	152.38771057128906	154.28383051277808	151.2775380721041	74420200	73.23420074349443	148.48528943743025	154.67571221263185
1	3194	152.76104296663132	151.365966796875	153.37015671921876	151.24806269015863	57305700	68.86844369654874	149.00247955322266	154.82256087981006
1	3195	152.27968426997802	146.3555145263672	152.75125586894956	146.0902489433872	140893200	51.68550034767808	149.05721936907088	154.752077510251
1	3196	147.98638609807605	146.9253387451172	148.76251467582847	146.13937607725978	102404300	49.6396988862148	149.0459932599749	154.7582131162585
1	3197	147.71127396657656	145.52040100097656	148.4186387371129	144.33164561645594	109296300	46.81394897726238	148.94073159354073	154.86616566840752
1	3198	145.95267630681514	146.4144287109375	146.81723655129747	143.80110978356157	83281300	51.44457452394475	148.9877482822963	154.8139486427056
1	3199	145.83480158277348	146.17864990234375	146.35549860208525	144.6362120312662	68034100	52.764296837594685	149.0754677908761	154.6722948753943
1	3200	146.2081213488854	143.49655151367188	146.2081213488854	143.20181370667203	129868800	44.76934453368677	148.89722333635603	155.04854878473026
1	3201	141.27622727741362	140.4313201904297	142.2979680614232	138.79063148485392	123478900	27.75344959722173	148.18284279959542	155.7305444339559
1	3202	141.40395977159233	140.91273498535156	142.06221417722685	140.27414875963487	75834000	30.978231433199895	147.59337288992745	156.04540808503006
1	3203	141.9147994023234	143.2902374267578	143.86004483276702	141.1779624220507	76404300	36.02011647892503	147.12600708007812	155.7660093672037
1	3204	144.07617258474733	144.25302124023438	144.49863354603244	143.08390426607792	64838200	35.58744254499575	146.6474129813058	155.11472891206733
1	3205	143.1035803589877	144.34146118164062	144.88181133910382	143.00532942454424	53477900	34.02601471648181	146.12952314104353	154.17027536461921
1	3206	142.91693075651082	142.8186798095703	143.39833641093568	141.2958950689208	74150700	24.573235484145556	145.33514404296875	152.1570164217106
1	3207	140.7358663198503	139.4193878173828	142.2095403127283	139.2032477658151	108972300	22.659483024850232	144.4088352748326	150.59798508478727
1	3208	139.96955982254588	140.3232421875	141.9148053342999	139.53727971082554	74602000	26.60282978973791	143.6200692313058	148.70620077057936
1	3209	141.13869603931272	139.0166015625	141.84606086491695	138.8004614773993	89056700	31.555522149265272	143.09586116245814	148.47203428914392
1	3210	139.40954063624275	140.14637756347656	140.41164305475672	136.66851386296668	94639600	33.429217238215315	142.6116496494838	147.71632701383055
1	3211	139.27202601919808	136.69801330566406	139.71414025618466	135.84328709733543	98322000	30.392938821020763	141.98147909981864	147.68271451815133
1	3212	137.04190501596315	138.6334686279297	139.74364151286483	136.914181766265	80861100	33.4724852026896	141.42569623674666	146.7713453605265
1	3213	137.0222167582579	139.5078125	139.65517391117527	135.94151643967965	83221100	36.20472468773035	140.94920785086495	145.61598132813174
1	3214	140.5492330571654	140.7751922607422	141.68887815597228	140.21520380127083	61732700	44.022474666731014	140.75482504708427	145.18525666293525
1	3215	141.50220155063448	140.39202880859375	141.6495629805559	140.05799957344533	58773200	49.90216870143103	140.75201851981026	145.1833825893605
1	3216	139.77307281576375	140.3035888671875	142.26848756147706	139.32113952004272	64452200	48.45301859198768	140.70850808279855	145.14503356277905
1	3217	140.7162426211821	139.02642822265625	140.73589580934828	138.56467574218755	73035900	38.5306708806206	140.40395028250558	144.65870163510843
1	3218	138.76114549498064	138.4369354248047	138.91832599092527	136.75694051407237	78762700	34.03453599740641	139.98851558140345	143.72902360226894
1	3219	139.6158725875649	141.23690795898438	141.35481207051464	139.0263970028741	69907100	42.582108684904775	139.76676177978516	142.67002002773012
1	3220	141.246745378741	142.29795837402344	142.3569029356858	140.9912989568878	67940300	48.72773745595211	139.72956739153182	142.47336246681638
1	3221	140.93235215706065	143.9779510498047	144.26285475697728	140.64744844988806	85589200	62.15935490908262	140.05517905099052	143.60420136923574
1	3222	144.4298683623013	146.14915466308594	146.55196247996375	143.97795007247626	76378900	64.55573049899544	140.47131565638952	145.29356771803913
1	3223	146.09024203898952	146.64041137695312	147.12181704316635	145.5204195129586	58418800	69.85672022370277	141.015873500279	146.76353702703227
1	3224	146.19831273525557	146.85655212402344	147.0137476472788	145.27480777486807	61421000	68.35043923413191	141.49517168317522	147.99977706190995
1	3225	147.0628786479238	146.08042907714844	147.54426934336965	146.03130360041152	58883400	80.05031795709877	142.16534423828125	148.47116976227397
1	3226	146.0705566352679	146.03126525878906	146.7484490596756	145.0291627622304	50720600	76.95030651247285	142.69375828334265	148.96440457243438
1	3227	146.7091751766454	146.69935607910156	148.19266841914728	146.3947841633798	60893400	76.59863853437582	143.20743996756417	149.5318411813866
1	3228	146.7386383860378	146.2375946044922	147.10213985553239	145.8839122319342	56094900	71.48350856978251	143.5976115635463	149.94955611849085
1	3229	147.19058275713044	149.89231872558594	150.48177939683748	147.09233181642745	100077900	79.71705813004444	144.27620370047433	151.1605036585241
1	3230	144.6362375956057	147.17095947265625	147.3085018229927	143.84045578358823	124953200	68.44332833927265	144.76673017229353	151.4059717765378
1	3231	146.375144890825	146.34567260742188	147.07267558601703	145.20602767920596	74588300	70.14587123751157	145.28953334263392	151.0800810271081
1	3232	146.05092273897117	147.38705444335938	148.90985392123366	146.04108865132204	69122000	74.03683417246052	145.928827558245	150.2502829864011
1	3233	147.75053765415043	148.83123779296875	149.30280922127793	147.19054939384307	54511500	71.99760621747002	146.47127968924386	150.10801493477348
1	3234	148.91967594049794	148.31056213378906	149.75474890276215	147.9961711425925	60394600	67.97882921932747	146.90075138637	149.7491299545347
1	3235	149.4420272974096	148.84185791015625	149.74702870500494	147.6415191356496	65463900	65.61682747565328	147.2481733049665	149.7228699543231
1	3236	148.9697640561292	148.01539611816406	149.12718897664993	147.73991001368617	55020900	56.558384453691396	147.38147626604353	149.8016107030873
1	3237	147.77925568798562	148.37942504882812	148.98942783717524	147.64151263858898	56787900	56.166418858524274	147.5056915283203	149.94044802015966
1	3238	147.6021870790371	145.53602600097656	147.71041485003775	145.46716197190455	65187100	46.0529316362031	147.41136823381697	150.04836951827698
1	3239	146.55926059562827	145.48681640625	147.02167192728697	145.2998761802244	41000000	48.14507892581174	147.3689673287528	150.1149911535151
1	3240	146.03777668648874	147.57264709472656	147.97602779837536	145.10309064575517	63804000	54.27266990266624	147.47906603131975	150.11546431620715
1	3241	147.94650571936123	147.5824737548828	149.43217889672766	147.0216531484388	59222800	52.540698766789184	147.54214586530412	150.14016140147714
1	3242	147.52347700617935	148.56639099121094	149.04849925402718	146.9331409706031	59256200	56.50444341023425	147.70848846435547	150.24416142327078
1	3243	148.56636081820668	151.0162353515625	152.50189355511282	148.55652739099617	88807000	53.36568470209781	147.7887682233538	150.66990947727814
1	3244	151.23272478015957	155.32566833496094	156.1127780614929	150.58335812980553	137827700	72.29917775936298	148.37124742780412	153.29064063040147
1	3245	155.1092228296383	157.96249389648438	158.4249203277858	154.0072781488538	117305600	78.90286644515851	149.20102037702287	156.14920502591667
1	3246	159.07423249970904	158.4248809814453	163.02944726502406	158.40519911335653	117467900	78.27700539525458	149.98943655831474	158.4016595009062
1	3247	158.5232592097014	158.80859375	159.19230760433507	156.49646218357938	96041900	77.02887264093229	150.70210484095983	160.2987937294482
1	3248	158.15925449217463	159.330078125	159.5268517998659	157.0671433318694	69463600	79.85079870804644	151.4892131260463	162.0045838010809
1	3249	156.99825748204293	154.28273010253906	157.86406453369798	153.83998564240557	76959800	61.84151885786777	151.87784685407365	162.37389823503787
1	3250	156.8014668186211	157.65745544433594	158.59214151775933	156.23081273910012	88748200	68.88972191930208	152.56656537737166	163.2348179533686
1	3251	157.41150696083542	162.63592529296875	162.85238083703447	157.34262791823772	174048100	73.65327946046116	153.5848868233817	165.2101895637556
1	3252	164.780771522949	162.1144561767578	167.55532964594474	161.87831877920462	152052500	79.8017938941767	154.76906040736608	166.23898846166233
1	3253	156.1816292767735	161.12071228027344	161.55362330337118	155.2567766388586	136739200	77.18085837333419	155.88576725551061	166.47302389643406
1	3254	161.376516727331	159.2316436767578	162.30136928042165	157.14581622535522	118023100	70.40979648007112	156.71855272565568	166.27277031397617
1	3255	161.64216510056525	162.65557861328125	165.17431721534913	161.63233167314976	107497000	73.56913499360327	157.79520307268416	166.24818367508257
1	3256	166.3549513614295	168.4210968017578	168.81465903767574	165.6268724846295	120405400	77.0073516897263	159.21339634486608	167.65874460228335
1	3257	169.35583286489788	172.25828552246094	173.12410760824633	167.9488719754966	116998900	77.84359398069756	160.7306856427874	170.37909002708963
1	3258	172.0910234690597	171.7466583251953	173.90136505237254	171.1169736434836	108923700	73.90419716054834	161.9036134992327	172.651419768872
1	3259	172.38619070089263	176.55784606933594	176.73495286088573	171.87456720769728	115402700	75.45783429016205	163.23185294015067	176.24001466273887
1	3260	178.20093567002317	172.90765380859375	179.19466739552252	172.70103171320386	153237000	68.2358257509473	164.26633671351843	177.91547680031456
1	3261	172.42551060224557	171.5203399658203	174.87538488790156	169.43451263026927	139380400	65.61130506317966	165.17431858607702	178.95014358050102
1	3262	172.2878048999529	176.4102783203125	176.60705197732372	169.5329286631927	131063300	68.94359608945884	166.3943328857422	180.94416193579033
1	3263	176.39058331265454	169.4837188720703	178.22060671100195	167.99806060749398	150185800	66.18471604142405	167.48011779785156	180.3027580761022
1	3264	167.19128474267674	168.3817901611328	170.67424008979302	166.95516235498613	195432700	61.99908354679682	168.2461417061942	179.75504872625072
1	3265	165.56786589082796	167.01417541503906	167.83080028341357	164.76108946281846	107499100	55.329283617894376	168.55887385777064	179.64111954447424
1	3266	168.79501963934456	170.2019805908203	170.40858768040073	166.39434194128998	91185900	59.244232732031946	169.13655417306083	179.59746790844014
1	3267	170.25116250826932	172.80926513671875	173.02572066741223	169.37550695696135	92135300	62.88501332368049	169.97145080566406	179.50077685713367
1	3268	173.015917408782	173.43898010253906	173.9998008970028	172.44526318406943	68356600	66.10889157555344	170.98626055036272	178.37416620845718
1	3269	174.23587328734808	177.4236602783203	177.51220616374184	174.2162064324986	74919600	66.53443776921992	172.04112352643693	178.45865453230223
1	3270	177.256379112462	176.400390625	178.40752051332709	175.65264488960494	79144300	59.995030495555156	172.61107308523995	179.06090575669245
1	3271	176.4397859889544	176.48898315429688	177.71883722352266	175.26896251299274	62348900	55.8487221167732	172.91326577322823	179.68052522060717
1	3272	176.57752357009767	175.32798767089844	177.6598011226114	175.21975991564707	59773000	54.86367954165292	173.16907501220703	180.0166489377164
1	3273	175.21976889427975	174.70816040039062	176.34139522760188	174.40314397424044	64062300	47.16529500378597	173.03695460728235	179.6709174906274
1	3274	174.9639889246719	179.0766143798828	179.93260315691342	174.84592771937227	104487900	59.250486561832595	173.47759464808874	180.85267195003686
1	3275	179.68658798247785	176.80380249023438	179.99158936284988	176.23314845059463	99310400	57.717708534398334	173.854984828404	181.33854882455674
1	3276	176.71525988783705	172.10084533691406	177.26623207071754	171.8253592454738	94537600	43.670509621431385	173.5471681867327	180.93183188121628
1	3277	169.91663581088895	169.22792053222656	172.47473828919735	168.8737219585049	96904000	49.5735110794515	173.52889687674386	180.95800168479735
1	3278	170.10361520609126	169.3952178955078	171.3334695629555	168.27359132256245	86709100	51.7440278809179	173.60128457205636	180.83143360742548
1	3279	166.3549934911358	169.4148712158203	169.71987264285875	165.4596560671489	106765600	54.332405529811794	173.77276284354073	180.4203375676474
1	3280	169.54277308913493	172.25828552246094	172.35666484220278	168.06694817720108	76138300	53.75760935272822	173.91964176722936	180.3133752226221
1	3281	173.28152209013933	172.70103454589844	174.32443598667186	172.00248580970825	74805200	49.785234110866796	173.9119110107422	180.3116867271111
1	3282	172.9470087303428	169.4148712158203	173.7734671157762	169.021308880232	84505800	42.77637110460791	173.62447466169084	180.46223628534037
1	3283	168.57858676416953	170.2807159423828	170.979264784859	168.33261590160495	80440800	35.56103218324152	173.11426435198103	179.79503365942077
1	3284	168.74580160961233	167.06336975097656	169.7592001008731	166.67965590489592	90956700	32.66365257439706	172.44733428955078	179.56489145320893
1	3285	167.26017846991508	163.55093383789062	168.32277434644473	163.2656142567515	94815000	28.687275224386	171.5231879098075	179.6661060966458
1	3286	164.28882013685183	161.85862731933594	166.94530189723943	161.53394404676334	91420500	28.193758380574167	170.56109074183874	179.86727604109535
1	3287	161.77008037475142	159.79248046875	163.64930096456078	159.684252711932	122848900	26.93249802247675	169.49568503243583	180.08363254299013
1	3288	157.44100875159458	159.0152130126953	159.68426145863555	152.20674242658725	162294600	15.097639450797999	168.06272779192244	178.49402702263507
1	3289	156.4177548992897	157.20486450195312	160.13683238368577	154.48935213627462	115798400	15.344558892093048	166.66280364990234	177.29929806556126
1	3290	160.86491050929132	157.11631774902344	161.74056599656424	155.2764608855422	108275300	18.33689936817342	165.5924802507673	176.8682350287148
1	3291	159.83182343191297	156.6538848876953	161.19942048448502	155.72903227419678	121954600	20.41675282602702	164.6943348475865	176.70205476951662
1	3292	163.03928812749427	167.58482360839844	167.6045054755724	160.17618447475024	179935700	47.17263677845593	164.56502096993583	176.39230185052625
1	3293	167.41758353014143	171.96311950683594	172.17957503076116	166.77805038659238	115541600	53.50282026090875	164.74703870500838	176.96772546040648
1	3294	171.20550150726515	171.79583740234375	172.0221263232155	169.53290315502977	86213900	49.31383660585598	164.71400669642858	176.8494387257153
1	3295	171.93359808137038	173.0060272216797	173.04539095891812	170.53648566674534	84914300	50.44246024542952	164.7357918875558	176.93392106877945
1	3296	171.66794061482483	170.1134033203125	173.39958469623934	169.34597560709165	89418100	51.025082144953984	164.78568703787667	177.07166057174018
1	3297	169.1282745462075	169.82772827148438	171.5123187730984	168.14313776987035	82465400	49.32373420273441	164.75333077566964	176.97920376441795
1	3298	170.29074266054957	169.10858154296875	171.3645381321525	168.40912782220335	77251200	53.299405917391645	164.89941733224052	177.29193436502769
1	3299	169.17754560815493	172.23147583007812	172.74375119669648	168.88200154925988	74829200	64.18199404687711	165.51945604596818	178.47708470859982
1	3300	173.43335009555227	173.65992736816406	174.02442320219117	172.30043366850177	71285000	69.448263861298	166.36240604945593	179.8199536289892
1	3301	171.55171755685703	169.56173706054688	172.87179722890681	169.00021691491136	90865900	65.0889208361811	167.06021009172713	180.05545096406578
1	3302	169.76859462390195	166.13343811035156	170.5074470849653	165.54235012870416	98670700	60.16212344594665	167.5686547415597	179.73880273584916
1	3303	164.88233741200816	166.36990356445312	167.059496301351	164.08437902845532	86185500	63.69984243721437	168.22330038888114	178.8844395325721
1	3304	168.428830184281	170.22177124023438	170.3793967268219	167.7195305266309	62527400	67.60882000184519	169.15940420968192	177.71250338310543
1	3305	169.29574363750376	169.98533630371094	170.76358766300345	167.52249461583332	61177400	68.02192606820893	170.11165073939733	174.73116502432956
1	3306	168.4879416203525	166.36990356445312	169.35486679359227	165.96599387855787	69589300	47.952698202912266	170.02487073625838	174.88807957086624
1	3307	167.29591839625454	164.81336975097656	168.0052029771983	163.71986743369874	82772700	36.685500406908815	169.51417432512557	174.96653255116405
1	3308	162.52784908789482	161.87767028808594	164.21243946447404	159.73991041394962	91162800	33.25646728375885	168.80573381696428	175.43203245637753
1	3309	163.07954147336417	157.69085693359375	163.68047553080768	157.37560593795362	90009200	26.506531717627553	167.711793082101	176.15790450776777
1	3310	150.31217357463046	160.3211669921875	160.42953264062146	149.74079243125084	141147500	34.85684243512274	167.01234763009208	176.19174062658087
1	3311	161.4048129823314	162.39981079101562	162.66578690938127	158.4789554243499	91974200	39.11666282124889	166.48178209577287	175.8175233786387
1	3312	160.63639223271767	162.665771484375	162.96131550875083	160.01575128472777	95056600	40.43298494422512	166.02158137730189	175.43440549466834
1	3313	162.25205850559507	160.77435302734375	164.1238277972452	159.56263874413696	83474400	32.34133983561787	165.20321546282088	174.27639801906875
1	3314	161.94663607610053	164.08438110351562	164.87249354079174	160.52803669540245	79724800	36.05046473776893	164.51924787248885	172.18003787574767
1	3315	165.9660199986933	163.75930786132812	166.39948265353257	163.08942196348315	76678400	40.50307233856362	164.10478864397322	171.19716759974858
1	3316	162.04515399744983	160.74476623535156	163.0893965768349	159.6906776997061	83737200	41.05918047213538	163.71988351004464	170.92204519471247
1	3317	160.93194979420673	156.9322967529297	162.56728050558442	156.67615156199417	96418800	36.002279456062766	163.04576873779297	170.91524002410054
1	3318	156.4594387052954	155.09994506835938	160.4590918337938	153.4843212668971	131148300	26.142301107201533	161.96563829694475	169.74283250448408
1	3319	159.07989329168066	160.52804565429688	160.9812152164197	157.04066784211605	91454900	37.17946755508154	161.29011753627233	167.56431272153154
1	3320	157.81891731398164	156.1638946533203	158.00609571698396	153.66163868475533	105342000	36.43975465655039	160.56111689976282	166.66210559479697
1	3321	156.5677776744671	152.43020629882812	156.9125815524345	152.20362905353198	96970100	34.44687668052032	159.67660522460938	166.6501531611615
1	3322	149.19896723804965	148.3813018798828	151.8292807234323	147.86904156044886	108732100	33.50982551883109	158.71257890973772	167.78963436437033
1	3323	148.65714063785396	152.7848663330078	153.2577428312749	148.14488031272373	92964300	44.03732948975538	158.36215100969588	167.97226916670655
1	3324	154.71573104732857	157.2179718017578	157.62188148073074	152.1642304485378	102300200	46.386759939692574	158.14049421037947	167.6989824051276
1	3325	156.25257661972952	158.23269653320312	158.60705339493342	155.28714659063266	75615400	45.0247073989569	157.84284319196428	167.08424903874996
1	3326	158.12429878796183	161.542724609375	162.0352929982588	157.3854462046361	123511700	48.75000764261632	157.76262555803572	166.8417654462601
1	3327	161.07970482927175	162.9219207763672	163.87750462789964	160.5871364535125	95811400	52.41789153494873	157.91602325439453	167.2823858430554
1	3328	163.04999075164037	166.31080627441406	166.9018793511502	162.45891767490426	81532000	52.502231946102654	158.07505362374442	167.95413962387624
1	3329	165.49315537373704	167.68016052246094	170.0740360049311	165.15819739910637	98062700	54.30550040129957	158.35511452811105	169.11168476215323
1	3330	168.51748639470068	171.48275756835938	171.551709322727	167.68012919455944	90131400	61.59081543274519	159.12211390904017	171.94548085206245
1	3331	171.29556621088122	172.12307739257812	172.6747515137094	170.18235698160333	80546200	67.60271460857886	160.20716966901506	174.69507244761
1	3332	169.61100881544317	172.9900360107422	173.11809357884718	169.4435373556172	90371900	71.20504184597598	161.4850333077567	177.1412401828533
1	3333	174.06381471485844	176.30007934570312	176.3493241575945	173.7190108396555	100589400	69.68280107581347	162.61160714285714	180.13022183897573
1	3334	175.89618261840158	175.12777709960938	176.940425244863	174.0736734844487	92633200	75.71466464836485	163.96617017473494	182.2529858353469
1	3335	175.1967121549276	172.0147247314453	175.38389053842545	171.8078394044231	103049300	77.01086629411682	165.3650643484933	182.82824660269944
1	3336	171.4433554045636	171.7191925048828	172.28072769395772	169.38442310861137	78751300	85.9048179771989	167.0320565359933	181.75150011488734
1	3337	171.97533671079117	175.78781127929688	175.83707112521444	171.84726411780443	76468400	85.75803850855833	168.67512403215682	181.5656331695904
1	3338	174.86178989450815	172.4580535888672	175.6499023764881	171.8275666096823	73401800	74.53221054038096	169.76370130266463	180.9473596567606
1	3339	169.79818332507708	169.27606201171875	171.0493112985937	167.60133241989047	89058800	66.61724079659379	170.5525131225586	179.58329432997226
1	3340	168.61602154238474	169.58145141601562	170.7833195377172	167.32549471465475	77594700	63.29858236232557	171.1267078944615	178.5730215272509
1	3341	169.2268038174018	167.56192016601562	169.2268038174018	166.68514898671697	76575500	57.516765749175	171.45813642229353	177.63641122659683
1	3342	166.2024342381658	163.2864227294922	166.51767019391744	163.04013853231345	72246700	45.23733317954855	171.24210902622767	178.33890257924048
1	3343	165.52269490513837	165.1680450439453	167.34518902716218	164.16320126523246	79265200	46.10684250204077	171.0626722063337	178.65701354082492
1	3344	164.90203813867376	167.86729431152344	168.4977812231989	164.2912581707364	70618900	44.198525728260165	170.80442483084542	178.58093483059127
1	3345	168.08403280084593	162.833251953125	168.72438072783297	162.586967757821	75329400	36.93546033544488	170.14086587088448	178.94955486499444
1	3346	161.48359993207802	162.61651611328125	164.12377400452343	161.13881111935814	69023900	35.13965691582726	169.39990016392298	178.89465826620867
1	3347	162.56729541101794	164.9119110107422	165.32568173680733	161.47379285097983	67723800	33.19769952330802	168.58645956856864	177.46607975424362
1	3348	166.25168871376107	164.7444305419922	166.36991535703385	163.63123612780706	67929800	34.21211008969972	167.84479195731026	176.08215968001434
1	3349	166.3994683269321	163.94647216796875	168.98052205416587	163.4440577878417	87227800	36.80312595308774	167.26848820277624	175.37707873459374
1	3350	163.9858867436895	159.38528442382812	165.37491827853887	159.09960135126914	84882400	32.29639701241091	166.38749476841517	175.07267352017246
1	3351	158.72522565667649	160.45907592773438	160.7447589663099	156.10477337045293	96046400	25.92821384789532	165.29258510044642	172.63375858134376
1	3352	159.83844441124967	154.46945190429688	159.92710311480064	154.3906391571423	95623200	23.929182262924712	164.00768498012	172.19462407758277
1	3353	153.59268025761008	154.2428741455078	157.4150007741114	153.07055896241795	88063200	26.171144304598386	162.9338858468192	172.03650623522782
1	3354	156.88301430273702	161.207763671875	162.07468874953122	156.5677633537738	130216800	39.04070359586374	162.3357652936663	170.62047620382435
1	3355	159.43454967903426	155.30682373046875	163.72974709401944	154.91277498971616	131747600	35.44006305831371	161.4604012625558	169.95354904256504
1	3356	154.3807770157754	155.61219787597656	155.87817395874512	150.99190440338296	123055300	39.932767417058194	160.91224234444755	169.87532047475628
1	3357	155.79938533869836	157.109619140625	158.32134827768206	153.99659814843346	88966500	39.32111923847331	160.33664049421037	169.15627144507673
1	3358	157.29681866698064	163.5524444580078	164.00559904764603	156.89290890039206	108256500	44.79815721236059	160.028436933245	167.97256759649935
1	3359	161.41466576478126	154.4398956298828	161.64124301290533	152.64693949326463	130525300	40.78721219825515	159.42891148158483	167.72047744384747
1	3360	153.91700145474738	155.1699676513672	157.30099321709514	152.1115504938457	116124600	41.91753724014048	158.89701516287667	167.26278244835913
1	3361	152.85149635884284	150.02000427246094	153.73943124959115	149.45765905699372	131577900	34.779530290100254	157.83330753871374	166.67788724252222
1	3362	153.43359356023947	152.4371337890625	154.6372276027927	150.87832879863976	115366700	37.97418038543049	156.95421491350447	165.270505397637
1	3363	151.44068137940286	144.5345916748047	153.36451764343903	143.85384613812707	142689800	33.34455760947007	155.56765202113561	165.22663462115443
1	3364	140.85461970992037	140.64743041992188	144.23859603195632	136.93787953021916	182602000	33.73474475023377	154.22923387799943	166.45998242448908
1	3365	142.6502019839293	145.1363983154297	146.1131220663248	141.19006162279788	113990900	37.44372924818699	153.13475690569197	165.70174468903525
1	3366	143.59735411573675	143.5874786376953	145.54092647551983	142.24572332922702	86643800	40.38275803384344	152.3574731009347	165.8787449042265
1	3367	146.86293191317884	147.2378387451172	147.76072719277806	144.71217042216534	78336300	44.16238439389415	151.85711342947823	165.59455752001486
1	3368	144.87988730604852	138.9307861328125	145.38303979911012	138.023115474384	109742900	31.841772589576976	150.26590074811662	164.4898169157694
1	3369	138.00339618106452	135.50733947753906	139.75951476961413	134.76740136256322	136095600	33.18194767499884	148.85165187290735	164.75464771208865
1	3370	137.2240017632513	135.74412536621094	138.81240303157122	130.8309399431796	137426100	33.10400025744822	147.43250383649553	164.25601011992504
1	3371	135.94142838049157	141.1900634765625	141.3380450828472	135.80330719659918	117726300	37.31382412137048	146.29539271763392	162.4396260696858
1	3372	138.92093441641646	138.4769744873047	140.06537583009975	135.48762522944844	104132700	28.75463472905257	144.50428771972656	157.69492435768825
1	3373	136.57285408248967	138.63482666015625	139.8877778515704	136.48406511064104	92482700	34.21364745472363	143.37535422188895	155.57079227517875
1	3374	135.5467872401753	141.85105895996094	142.40354364055585	135.30014121818982	90601500	37.32629461223631	142.42400360107422	152.56012216187312
1	3375	143.43946380251003	147.6324462890625	147.6719030298471	143.311203050322	90978500	47.755078265445704	142.2534637451172	151.90794693719926
1	3376	147.07011062465787	146.8431854248047	148.6387758545306	144.87001706901614	103718400	44.5741442109454	141.85389600481307	150.04493513811917
1	3377	147.8889731745575	146.71495056152344	149.70429963714662	145.69875493343622	74286600	52.49043334223363	142.00963592529297	150.49775975494617
1	3378	145.8467521457281	149.18141174316406	149.2406043897797	144.88976421455953	72348100	60.074589897867604	142.61920601981026	151.8767768046923
1	3379	144.92920830294685	143.4296112060547	145.98486058899564	142.52195557770006	88570300	48.043430196272695	142.4972926548549	151.65649860084724
1	3380	145.0574568165146	144.1793975830078	146.576804737733	142.9560278981118	71598400	50.69120843875842	142.5395725795201	151.72588127649365
1	3381	142.41344262583527	146.71495056152344	147.00105337046227	142.16679656313315	67808200	49.373079062143255	142.5022234235491	151.61016444215443
1	3382	146.58668349543828	145.97500610351562	147.85937050052127	145.48171399929922	53950200	60.3179442158273	143.00538199288505	152.04143136403158
1	3383	145.10680021963537	140.7263641357422	145.9651236224784	140.61783927585907	69473000	57.25651302775277	143.378169468471	151.46216706251641
1	3384	138.398032723083	135.29029846191406	138.87158893198634	135.22123034078209	91437900	49.44870727397962	143.3457532610212	151.56414019414223
1	3385	131.08745715836656	130.11074829101562	133.3862004896801	129.67664877037856	122207100	36.453571242005665	142.55437360491072	153.3854050319069
1	3386	131.34395874256492	130.97891235351562	132.09375731155245	129.71608578781024	84784300	40.39914642233182	142.0187977382115	154.35525869753928
1	3387	132.48839269838643	133.61309814453125	135.49747768055312	130.38697847648072	91533000	43.953406334974645	141.66010284423828	154.69278520912292
1	3388	130.30804408715656	128.3151397705078	130.61388278319032	127.30881966252552	108123900	34.479646780702	140.69325147356307	155.54616607443253
1	3389	128.32501262151087	129.79501342773438	131.2946256093659	128.06849109789493	134520300	27.309229620128548	139.41914912632532	154.7601142669207
1	3390	131.63005208162124	134.04718017578125	135.221217692565	131.5314027016207	81000500	35.04034615959576	138.5051487513951	153.46065320802998
1	3391	132.9816798809872	133.5341796875	135.9118362074978	132.1134960074851	73409200	34.72791659373746	137.56366511753626	151.941193809197
1	3392	134.98441909605137	136.4149627685547	136.7306617946848	133.8103818231585	72433800	35.348646942916844	136.65177590506417	149.37999071718338
1	3393	138.0231085873177	139.75950622558594	140.00615224883282	137.89486289200275	89116800	45.54168415214816	136.3896255493164	148.65942633809095
1	3394	140.78554705849837	139.75950622558594	141.56495692224246	139.07876079277202	70207900	44.53124941000733	136.07391902378626	147.6903688446147
1	3395	140.22319674520142	135.5961151123047	141.49588355408835	135.47772984284862	67083400	36.77534101385833	135.27971649169922	145.1516243121845
1	3396	135.6158632251475	137.3621063232422	138.78278990100551	134.83645332014265	66242400	39.99995748092931	134.66450936453683	142.53608907603532
1	3397	135.4087070017886	134.8858184814453	136.51367669699206	131.97539755306136	98964500	42.75221978251699	134.24732753208704	141.31278125852722
1	3398	134.21493382375945	137.066162109375	137.17468699446417	133.8400419922467	71051600	52.39746754191135	134.37417493547713	141.58260684631202
1	3399	135.92171062767136	139.66085815429688	139.71019037554066	135.09296845138468	73353800	63.86026966001507	135.0563256399972	142.33395084489595
1	3400	139.45366482669044	141.00259399414062	142.1864918716594	139.1872829116733	74064300	64.35031338991507	135.77230290004186	143.2902511295231
1	3401	141.36765146861703	144.38661193847656	144.5839257789304	141.3577910455227	66253700	65.09961791852209	136.54183959960938	145.22324437647796
1	3402	143.31121832945087	145.0673370361328	145.57050462277482	143.05471185180627	64547800	76.96959989938037	137.7384251185826	146.1490803336602
1	3403	143.71572303183265	142.92645263671875	144.67271093962017	141.85107943859236	63141600	70.69992514581172	138.67638506208147	146.14742082566826
1	3404	143.80450328591834	143.90316772460938	146.4584171134617	143.1040369550832	77588800	67.32578774795499	139.38038417271204	146.82978957264464
1	3405	141.07170136107663	143.5381622314453	144.4852747753807	140.21336274141225	71185600	67.67792901983393	140.09495435442244	147.03014436389387
1	3406	142.14709003655486	146.4781951904297	146.95175151353178	141.32822313268167	78140700	67.74546988750598	140.81375667027064	148.17863689276385
1	3407	147.77056727067165	148.15533447265625	148.83607991941642	146.21176256532723	76259900	65.7302037728772	141.41345868791853	149.71613800961856
1	3408	148.71771677345194	145.09695434570312	149.53658351575038	144.73190793272408	81420900	58.971904558910964	141.7947049822126	150.2588333063304
1	3409	145.93554648323237	148.97422790527344	149.2011380770062	144.9391017690307	82982400	72.7061492562052	142.75028446742468	151.2205756226202
1	3410	149.09260697122585	150.98684692382812	151.65773204162863	148.35266878408055	64823400	72.9327517987182	143.72348022460938	152.64575852048375
1	3411	152.42726650714104	153.265869140625	153.48291887978365	149.90161323774686	65086600	81.14355891668282	145.03634098597936	153.76375819665392
1	3412	153.30532867140192	152.02276611328125	154.18338806700862	151.3518960375733	66675400	76.17412889622804	146.10466984340124	154.27314958836737
1	3413	151.94383291278464	150.89805603027344	152.9600134725139	150.23704639800843	53623900	70.73179383091748	146.9073268345424	154.5389901472178
1	3414	150.21729620269366	149.566162109375	151.03616284792213	148.77689178411194	55138700	65.80488546694679	147.51901027134485	154.45282414716704
1	3415	150.53299771545204	154.68650817871094	155.21927200151555	150.11863421664737	78620700	67.86448888507788	148.25471714564733	155.90548223112063
1	3416	154.87399776505708	155.23904418945312	155.52514701000848	152.33848396565298	81378700	67.72095332935288	148.98126765659876	157.2361933477404
1	3417	159.07682201024468	160.32977294921875	161.43475735233827	157.3601602966314	101786900	77.49382648195771	150.22436196463448	159.70245270178913
1	3418	158.8499238200317	159.3432159423828	161.39531297785308	158.73153852797333	67829400	74.38465954028939	151.3272225516183	161.22094929253075
1	3419	157.9521463098053	157.86334228515625	160.23115354553508	157.48845050250915	59907000	71.85434456403979	152.35044969831193	161.72344578880208
1	3420	158.6822208140143	163.90126037597656	164.3550807397493	158.59343183685212	82507500	74.2849802247126	153.59495435442244	164.16016867929196
1	3421	163.78285462114704	163.58554077148438	164.94703192609583	162.22404961687292	55474100	72.35569653162324	154.69711194719588	166.01072570832798
1	3422	161.2440845435306	163.35830688476562	163.85228420818493	161.0366074346982	56697000	78.8220022638056	156.00149427141463	166.74359719398493
1	3423	164.36599556286393	162.88406372070312	165.78865254333672	162.2221359735368	60276900	74.59610205225864	156.99505397251673	167.50795530264764
1	3424	162.04430338948927	162.93345642089844	163.8226245272971	161.28357419373464	63135500	72.70072433975253	157.8483832223075	168.19863757971453
1	3425	165.6602246517888	167.20144653320312	167.30023295092772	164.8896212485773	70170500	74.61920751168849	158.84378160749162	169.9485157865627
1	3426	168.0115606543251	166.46047973632812	168.93036629204852	166.16409033464345	57149200	75.96700821336752	159.87504686628068	170.932559027678
1	3427	167.77447257106098	170.02700805664062	170.0961570458949	167.35951833556643	68039400	81.62654173825075	161.24140058244978	172.24785891383064
1	3428	169.45396902507963	171.10385131835938	171.30143921381386	169.2860185601938	54091700	85.91185719664973	162.7798069545201	172.72635531675922
1	3429	170.69882734263683	170.94581604003906	171.6176331359699	169.59232280227278	56377100	82.48669215431613	163.9411860874721	173.6100723886493
1	3430	170.68892125785695	172.44747924804688	174.0281975704134	170.49133335193497	79542000	83.12666107394378	165.1703600202288	174.4408511268675
1	3431	171.6571160502139	172.0522918701172	172.79325783867927	171.03469981262458	62290100	77.54590404342822	166.00768280029297	175.50951562877958
1	3432	170.94577013813446	169.45396423339844	171.6472244834014	169.2464871502945	70346300	72.08558816196636	166.72987910679407	175.5631288828634
1	3433	167.64600292302248	165.55154418945312	167.81395338043234	165.1267159118957	69026800	65.18658997225836	167.27903638567244	174.5567462146191
1	3434	165.0674652978081	165.2156524658203	166.6778362068351	164.64263695785368	54147100	53.35125545639166	167.37292153494698	174.49517758813025
1	3435	165.3045923923907	165.51205444335938	166.08506999483225	164.24747359700294	53841500	54.91680192908615	167.51052965436662	174.3877987019057
1	3436	166.74699023963788	167.98193359375	168.09060921191156	166.3221769618195	51218200	60.588245982592746	167.84078870500838	174.2898546892127
1	3437	168.51543646848708	161.64913940429688	168.98965049238348	161.58986453568383	78961000	47.770276673917984	167.75257982526506	174.51963659772397
1	3438	159.20888628482342	159.43612670898438	160.93780692739824	157.89491986245918	73314000	44.14299214111546	167.50277056012834	175.22672357573998
1	3439	160.17711093628972	156.9958953857422	160.6019242494096	155.820226802932	77906200	31.79412637361142	166.773802621024	176.3294263905845
1	3440	158.37900919271698	155.32623291015625	158.6457611720159	155.24719472832723	87991100	30.77443540083405	165.97849927629744	177.3309087202573
1	3441	154.75318959949817	156.0572967529297	156.51174737307286	152.80691806217294	74229900	23.260040201110698	164.9806627546038	177.22121639498062
1	3442	157.82572474107752	153.9331817626953	158.42837756374567	153.1033036355752	76957800	18.39988947092631	163.75418635777064	176.76832335479153
1	3443	154.585259235847	152.6686248779297	155.19778627085483	151.83874662243696	73714800	17.679828433647543	162.44867270333427	176.010545038168
1	3444	152.95515314889423	154.0814208984375	154.78286029004315	151.75972133468971	87449600	17.420285618388718	161.13681139264787	174.07090810881004
1	3445	152.77729663545207	152.59947204589844	154.47657973003214	150.84089901314317	84923800	16.773558960865117	159.74732426234655	171.7781090609512
1	3446	153.5973183700772	155.47442626953125	155.9190179443951	152.88598978028585	68028800	26.345742035794203	158.74878583635603	169.56876715616738
1	3447	157.66768343592295	161.46142578125	162.2814299729469	157.38118321231417	104956000	43.535312316405765	158.45663452148438	168.69036377652108
1	3448	157.97395705373035	151.98695373535156	158.60624748496193	151.5226138010885	122656600	33.77757951447779	157.51172746930803	167.4969858680846
1	3449	152.9254836377698	153.43922424316406	155.20767139298664	151.75970446301844	87965400	35.60316218939728	156.64938245500838	165.69986664260338
1	3450	152.78717273127475	150.53463745117188	153.37007740177668	149.55657204599007	90481100	29.40761407497375	155.4031470162528	162.2740793342162
1	3451	149.38861684382928	148.88475036621094	149.52692988033445	146.5828144140255	162278800	33.06236694820227	154.4914049421038	161.17711424622766
1	3452	147.51150837706584	152.61923217773438	152.6982703598037	147.30404633975175	81474200	41.30543091395422	154.00448390415735	160.1063442023241
1	3453	151.5522446171644	155.0100860595703	156.17588044200602	151.23610695285475	107689800	47.464016636605834	153.86264038085938	159.75363196308462
1	3454	155.4447684044589	151.86837768554688	156.8279138472632	151.7498279611601	101696800	45.74414621504068	153.6156507219587	159.53220421571754
1	3455	150.5445279988441	150.9001922607422	152.60934951167334	149.0922335190095	86652500	43.68957997251598	153.2472861153739	159.1511466930302
1	3456	149.36885132431644	148.6179962158203	149.64547739323916	146.77052602515988	96029900	43.521210588182775	152.8676300048828	159.24601974754322
1	3457	147.85730340041596	148.9539337158203	151.91779780340053	147.8375400855009	93339400	45.367207856218	152.602294921875	159.31655778352356
1	3458	150.90019798375215	149.93199157714844	152.85634396088452	148.14379608075552	84442700	44.76829127052622	152.3059071132115	159.10471186799336
1	3459	145.8616134152087	148.0351104736328	148.82547715169355	143.09533757949137	146691400	44.30472437706673	151.9798812866211	159.14588218008856
1	3460	144.34018488168724	140.76377868652344	144.9527119597298	138.9854572462475	128138200	33.4592321510374	150.92912074497767	159.95940046622522
1	3461	139.5782261046943	136.5353240966797	141.37631073101744	136.3377361896639	124925300	20.81888619387587	149.14868491036552	159.023235749802
1	3462	136.54522777511258	140.73414611816406	141.34668829237813	136.0314871023825	114311700	34.96966475519025	148.34491293770927	159.02344572655818
1	3463	143.283060738833	144.34017944335938	144.45872917658045	142.52233144235086	87830100	38.50765552433876	147.69498116629464	158.14299279276307
1	3464	142.33464491165762	144.63656616210938	145.60477264963058	141.28740023689022	79471000	42.02515401469793	147.27369035993303	157.7040975190247
1	3465	144.05366550708558	143.67823791503906	145.7628228353645	143.47077587995457	68402200	42.82605624208417	146.90179661342077	157.45530894756214
1	3466	140.82304314688486	138.40255737304688	141.37631039018268	137.77026702712604	85925600	31.209219926813688	145.88631984165735	156.7997599480231
1	3467	138.7285614013672	138.7285614013672	140.1808556419713	136.90085472253764	74899000	27.237555624768007	144.72335379464286	154.89330734001453
1	3468	138.21485522733482	137.30593872070312	139.64740158913798	136.55509858261405	77033700	28.61290588606505	143.6831795828683	153.68256511213664
1	3469	137.45413764848382	136.67364501953125	138.66931766793832	136.49582041546117	70433700	28.89801756780308	142.6669976370675	152.39485775394496
1	3470	133.36398764851756	141.2676239013672	141.86038757533703	132.75144558792866	113224000	39.797048283107266	142.14197104317802	151.26061339829553
1	3471	142.571713037288	136.71315002441406	142.77919011754517	136.52543625536936	88598000	34.79003278569169	141.2676293509347	149.90748261669265
1	3472	139.37077023650323	140.6946258544922	141.17871398682112	138.5804034985276	85250900	39.31917833644677	140.60781751360213	147.66287999373245
1	3473	143.73750943727143	142.01846313476562	144.93292597192462	138.91628652563887	99136600	42.94974651364628	140.17805698939733	145.88917217849857
1	3474	139.9832917841237	142.1271514892578	143.20401840140053	139.79557799531165	61758300	51.91986048942153	140.2754407610212	146.07538368812996
1	3475	141.29727289667952	141.66281127929688	144.13269781047578	140.93171943907114	64522000	58.0765723520615	140.64168984549386	146.05921795534675
1	3476	141.14906919641035	145.49607849121094	146.06909396950246	140.93171797792078	86548600	57.58815376759792	140.98182787214006	146.99010579896273
1	3477	145.4170538676587	147.6498260498047	148.42042950536802	144.24138536942965	75981900	55.52987931202398	141.21823120117188	148.00564772101694
1	3478	148.28210696285174	150.5050048828125	150.65320712247134	147.56090430315092	74732300	59.032837200650484	141.6374053955078	149.89896751695352
1	3479	149.14164832129399	147.55104064941406	150.15924045749748	146.25680732789058	88194300	55.616086016784884	141.9140341622489	150.7119068794349
1	3480	146.2864321323527	143.05581665039062	147.25462333513107	142.39388893497147	109180200	56.9041305788896	142.2464098249163	150.82159588710257
1	3481	146.41485857865877	153.86404418945312	155.60283873819793	146.0394461076168	164762400	67.12882585089037	143.327515738351	153.63383960368466
1	3482	151.31512585250383	151.49295043945312	152.3821185991709	150.09005675633261	97943200	65.71801167558036	144.34087371826172	154.88389073351783
1	3483	153.21200447728674	148.83535766601562	153.57754286316361	147.33367749566185	80379300	62.89543987812407	145.2095674787249	155.0091532069132
1	3484	147.15583065483594	143.28305053710938	150.3370455863596	143.2534131059143	93604600	52.094453787802145	145.35352652413505	154.96099190521394
1	3485	140.34882641665214	137.20713806152344	141.07991823906764	137.07869914103392	97918500	50.49762209986873	145.38881138392858	154.8622743936084
1	3486	140.61132451471516	136.93994140625	141.18529050660402	132.98156775184182	140814800	45.911762643751295	145.12061963762557	155.34904428920265
1	3487	135.68318785994535	137.47434997558594	137.70195229028033	134.25817056794372	83374600	44.965657610689334	144.79604012625558	155.71369441108314
1	3488	138.9488277817145	138.0482940673828	139.9582022856921	136.05921655660495	89908500	45.52721599514893	144.50469316755022	155.93481621195525
1	3489	137.05869016748804	133.46646118164062	137.10817285902812	133.189376229013	74917800	41.75648010312917	143.9192395891462	156.73236695431032
1	3490	139.7701824699572	145.34158325195312	145.34158325195312	138.0482844536757	118854000	49.86625121100447	143.9082042149135	156.71574637395776
1	3491	144.3025233234953	148.1421356201172	148.44890717190938	142.86760074898706	93979700	50.42147946293505	143.94336918422155	156.79778263335035
1	3492	147.41972982012294	146.73690795898438	148.71609475648887	145.89574753004618	73374100	46.691901235811585	143.67421940394811	156.0870097681057
1	3493	150.6359289335687	148.47860717773438	151.9916672429698	147.0140129756077	89868300	50.83204238490073	143.740474155971	156.25191357695374
1	3494	147.57809621983398	147.2416229248047	148.31038580901588	145.75723254673355	64218300	53.98784172082477	144.03946031842912	156.6798128804276
1	3495	144.9061704203095	149.1515350341797	149.90362066577504	144.6290854455113	80389400	44.593735897436794	143.7028525216239	155.43452902630685
1	3496	150.7249963732011	149.71560668945312	151.11093726698712	148.40935101048493	74829600	47.872808251049534	143.5758993966239	154.97828385716332
1	3497	148.59737709980914	146.46974182128906	148.8051832977112	146.18276632418628	58724100	47.20805637445141	143.40692683628626	154.54051296847902
1	3498	146.5884871676489	148.6171417236328	148.85464959506425	145.40096291048988	51804100	56.84557694363862	143.78793334960938	155.263098183414
1	3499	147.8947425813443	149.49789428710938	150.24997989598808	147.78588669453308	58301400	68.20045543674794	144.6658445085798	155.8491379703764
1	3500	146.76662602934562	146.56871032714844	147.33070163560777	145.58900721627217	35195900	63.216543367191996	145.3536137172154	155.63838393516653
1	3501	143.62961681958598	142.7191925048828	145.11400724355855	141.88793749145825	69246000	56.59860335967712	145.7282453264509	155.119994801128
1	3502	142.788408169166	139.7008819580078	143.30300090435742	138.88942331789363	83763800	51.95867227541206	145.8462873186384	154.85599997863065
1	3503	139.92852238105422	146.48953247070312	147.17235443840406	139.08737692084236	111380900	64.66785089208746	146.77650669642858	152.29174023141587
1	3504	146.6676817749002	146.76663208007812	147.57810612254133	145.08432589204557	71250400	52.172646687151165	146.8782958984375	152.33170388600215
1	3505	144.44108106262544	146.27182006835938	146.45984525867783	144.1342943784221	65447400	46.93285168998063	146.7447019304548	152.1562152953704
1	3506	146.23224678914536	145.10411071777344	149.34946051004155	144.2530596393701	68826400	47.30133718821765	146.6280735560826	152.11022917405347
1	3507	145.5395339297925	141.42282104492188	145.7671362234273	140.44311797232058	64727200	39.040937457636275	146.12408883231026	152.1443052559386
1	3508	140.7103042713057	139.4733123779297	141.87801737065325	138.54309205811114	69721100	38.19552198523281	145.5692095075335	152.5076916934998
1	3509	140.87855183085378	141.16552734375	142.02648408244	139.63166927482092	62128300	37.78389317199897	144.9987803867885	151.98155365053304
1	3510	140.85872259344615	140.68060302734375	144.05512018514585	139.4337056646384	76097000	36.145708739754085	144.35342298235213	151.12518668392894
1	3511	141.21497796538944	142.98635864257812	142.99624914077572	139.592045361148	70462700	44.50000168647309	144.1046098981585	150.79692224928542
1	3512	147.9442532885538	143.95619201660156	148.4093635202704	142.73899603359902	93886200	42.35648325162499	143.77168491908483	149.94022128143638
1	3513	143.837425594668	141.71969604492188	145.13379070269028	139.69102628885693	82291200	37.78752801849916	143.21609933035714	148.5007640104404
1	3514	139.64154021581635	135.0795135498047	140.3243621508591	134.6144033940509	98931900	33.84365754620384	142.39544241768974	148.87144074168236
1	3515	135.2675358827307	133.11021423339844	136.2175371723463	132.33833252308642	160156900	35.73323195873486	141.70908682686942	149.8580041463072
1	3516	133.70396884953303	130.9924774169922	133.7930286341792	129.95341639612556	79592600	36.71507502877127	141.0870579310826	151.02860594542352
1	3517	130.02268410086938	130.9232177734375	131.86332854040518	128.5382939109211	77432800	20.12925637761228	139.97517830984933	150.7600790440885
1	3518	131.5961236714103	134.04042053222656	135.38626813534808	131.36852142161675	85928000	27.979456557727204	139.0661631992885	149.52560809517445
1	3519	132.95187583312276	130.8539276123047	133.1596819856588	128.94401964853728	77852100	25.595260235394136	137.96488516671317	148.4028321446855
1	3520	129.5575878594223	130.48780822753906	131.04197820854492	128.29090930283763	63814900	26.261689561719493	136.92086356026786	147.20555417081812
1	3521	130.0128221280955	128.67686462402344	130.04250873040812	127.38049932303561	69007800	27.960351169924394	136.01043810163225	146.8215428220978
1	3522	128.3205924980965	124.7283706665039	129.66644031626882	124.56014157673225	85438400	26.152412893609096	134.95722797938757	147.10533929374807
1	3523	126.6580710085752	128.26121520996094	129.12215673015015	126.40078213242634	75703700	30.30211909608836	134.03549139840263	146.1124651292348
1	3524	127.07372463723176	128.57789611816406	128.5976922192292	126.10391953505118	77034200	31.4303554337708	133.17101233346122	144.92736587643634
1	3525	128.9242524939217	123.76847076416016	129.53779569151328	122.87783501765625	112117500	22.6170786979049	131.79830605643136	143.0967029135995
1	3526	125.56952732872513	125.0450439453125	127.32111217332934	123.77836538537261	89113600	23.287641707765275	130.447509765625	139.84672424938518
1	3527	125.80702181866339	123.71897888183594	126.44036106917035	123.46169000194207	80962700	23.902412261781365	129.161744253976	136.64892817541678
1	3528	124.69866253070737	128.27108764648438	128.9341133916564	123.59031523952562	87754700	39.492925455784516	128.67542811802454	135.34684771935773
1	3529	129.11225514638548	128.7955780029297	132.02166222689684	128.53828914886986	70790800	43.03066601598123	128.36723981584822	134.53584185313292
1	3530	128.90444246439094	129.3695526123047	129.89403595356941	126.78671300154889	63896200	47.2409256129057	128.2513166155134	134.2664894795553
1	3531	129.88416540348345	132.10086059570312	132.12064159652607	129.10239307095992	69458900	51.83589464479586	128.33543395996094	134.54146980035367
1	3532	132.48677761592936	132.02166748046875	132.86281286375012	130.07216715098443	71379600	46.52355268682939	128.19123731340682	133.90016988580135
1	3533	130.656019148829	133.35760498046875	133.5159435530184	130.28987441230564	57809700	54.605030139637535	128.3700714111328	134.5737279876457
1	3534	133.42691057714939	134.52536010742188	135.86130244423947	132.73419805805875	63646600	57.21357391210947	128.65846797398157	135.61582726777158
1	3535	135.39619418728472	133.80294799804688	137.16755996413974	133.62481331043077	69672800	59.52900571213322	129.02461678641183	136.50596146307427
1	3536	132.6846861145787	133.8623046875	134.8321020004952	132.37791457373308	58280400	69.84936603883449	129.6770406450544	137.13751044017658
1	3537	133.8722133053258	136.4352569580078	136.58370504947536	132.82324656561806	80223600	68.53672749217449	130.2609007699149	138.48444876178
1	3538	136.68263556675592	139.6415252685547	141.82853332640542	136.4649238107709	81760300	72.18243005522157	131.0511599949428	140.59792564048476
1	3539	138.84983924609418	141.04673767089844	141.67018630766603	138.83994874868372	66435100	90.11930402384026	132.28532191685267	142.23530789282157
1	3540	139.4238211686979	140.38372802734375	140.94778844428123	137.36546497180777	65799300	86.66025779421976	133.38094220842635	143.27444280839873
1	3541	141.68011141740982	142.46189880371094	142.7488742986824	140.42332333943187	54105100	93.24194927008686	134.719722202846	144.0369022322823
1	3542	141.6702137400347	144.411376953125	145.69785156540507	141.59104444543297	70555800	92.31960247731529	135.87260001046317	145.7310988013926
1	3543	143.4514967213056	141.5118865966797	144.03535332871843	141.36345359479515	64015300	79.64932104159136	136.7809077671596	146.16230483892753
1	3544	141.21500196773877	142.7884521484375	142.8379348478305	140.7993744728372	65874500	80.29492232848501	137.73940059116907	146.58569440286402
1	3545	142.47178209857688	143.9165802001953	145.08430842068046	139.8493652771468	77663600	78.75720364506854	138.58338056291853	147.36670663877032
1	3546	147.35045560866243	149.25048828125	149.6067274198631	146.62805663314577	118339000	83.3909412446621	139.8140106201172	149.42579759674845
1	3547	146.48954008415967	152.8922119140625	155.7422463273732	146.29162438323533	154357300	84.75360669586917	141.20933968680245	152.33592502676106
1	3548	150.98230158746472	150.15103149414062	151.5067849832526	149.21092060169065	69858300	76.32547167871142	142.32545907156808	153.6960159747704
1	3549	149.07238437886454	153.0406494140625	153.6146155336174	149.07238437886454	83322600	80.20515592252605	143.6995806012835	155.28124055031464
1	3550	152.27864483917466	150.3390350341797	152.97135723381655	149.59683994706387	64120100	73.88809912214218	144.87648991176061	155.45741605604476
1	3551	152.17967780621382	149.29995727539062	152.72395721753742	148.85464324794316	56007100	69.51950721348078	145.79539707728796	155.40866000151686
1	3552	148.1304871155474	149.66668701171875	149.99375331566142	147.89261658821053	57450700	66.64540205569166	146.5114800589425	155.6309617913342
1	3553	149.6072030213013	152.48141479492188	152.88775609688926	149.5774710997684	62199000	68.13679529545931	147.3282427106585	156.38742202726598
1	3554	150.76679417039543	151.83718872070312	152.40212547908195	149.51800808989614	61707600	68.1774195423231	148.14634704589844	156.5488660131155
1	3555	151.74801937795763	153.94827270507812	154.11675866505783	151.52006956422687	65573800	68.21063021174785	148.9668023245675	157.22015389866385
1	3556	152.14443364408874	152.34266662597656	154.93935535973205	151.985868430853	68167900	62.71297538679329	149.53332301548548	157.5243604840832
1	3557	150.99477529042434	151.1929931640625	151.63898716051196	149.50811855355659	59144100	66.43993961546056	150.2248306274414	156.77054474673307
1	3558	148.8638959311259	147.15919494628906	149.95411695272674	147.08982549385345	58867200	56.78663678825739	150.53702654157365	155.85707808934885
1	3559	147.5457355310671	147.58538818359375	148.6161303034484	145.850955150422	51011300	55.823659891422345	150.79908425467355	154.94655808592577
1	3560	148.75487896664254	148.07101440429688	149.00265510528632	145.93024005993672	48394200	47.78717639838039	150.71483612060547	155.04184786204524
1	3561	145.8013887677593	145.4049530029297	145.88067894533623	144.4237540688521	55469600	35.41928777863028	150.1800319126674	155.15070050382576
1	3562	146.39604828262136	146.6041717529297	147.84305234351663	146.13835144102467	44998500	42.651509834679764	149.9266847882952	155.252583005986
1	3563	145.74191090318052	146.0987091064453	147.7538517062128	145.5238667165713	50547000	34.04085595878624	149.4308319091797	154.80029870620137
1	3564	145.52386270219765	144.0173797607422	145.92029841797654	143.72004541238144	55479000	35.04020371228961	148.97928510393416	155.0386687354119
1	3565	143.0956567800384	144.61204528808594	145.40493182531964	142.61991578386647	52238100	38.6680023871824	148.64443424769811	155.1305762586033
1	3566	146.72310034368257	149.68650817871094	149.7657983517578	146.01942463285462	70732300	50.039030129818	148.6458500453404	155.13296184560505
1	3567	152.421971492151	152.4616241455078	154.90965374485327	152.09492027876624	87558000	49.96096907438626	148.6444364275251	155.1279554260449
1	3568	152.33275997963113	150.25144958496094	152.65982628230532	149.7856292559754	56182000	47.05455213309231	148.53116934640067	154.8271087582583
1	3569	151.45068324166047	151.51014709472656	152.10481587149795	150.47940502111874	47204800	45.32318425632527	148.35701751708984	154.11978843430794
1	3570	152.19400890417916	149.25042724609375	153.1652871071905	148.89362901108174	53833600	44.213667135886155	148.13614327566964	153.46128694845814
1	3571	148.8738114378205	147.17901611328125	149.59731347786158	146.29693372600934	68572400	42.73933477667093	147.84943062918526	152.89023817661217
1	3572	146.49514356859967	149.13148498535156	151.77773200211703	146.38612147623616	84457100	53.85806559451747	147.9903084891183	153.0581875310689
1	3573	149.93429099292322	151.23263549804688	152.03542774179175	148.7647949151356	73695900	56.69574376299085	148.2508261544364	153.5964093800475
1	3574	149.8450679963741	151.62905883789062	151.88674052270053	148.586361246658	77167900	56.55344608175985	148.50497218540735	154.14399708743647
1	3575	150.80646037730506	154.46363830566406	155.06821263966182	150.29108181642482	76161100	66.58196041803063	149.15202113560267	155.31343021980052
1	3576	154.69157989251337	153.62118530273438	155.34571244010942	152.90758890954837	98944600	63.014659310691464	149.65323638916016	156.05863036214208
1	3577	153.69057212608058	155.9998321533203	156.41610932466375	152.77874273681294	73641400	67.17078912382614	150.36045946393693	157.24381273306494
1	3578	155.9205571770909	157.8631134033203	157.98204109629864	155.14748180357108	73938300	74.19461838163224	151.34944043840682	158.28538435626007
1	3579	157.88295021864405	156.426025390625	160.6976833752444	156.40619906612653	75701800	70.0538280269394	152.19329616001673	158.43850873295165
1	3580	157.41708822504384	157.5161895751953	160.11289296719258	156.27730927542294	67622100	65.36956985356667	152.7525591169085	159.41887092896374
1	3581	157.44685878169065	158.82449340820312	158.91368918214428	156.4458486981132	59196500	63.25345816040677	153.20704977852958	160.61434236063002
1	3582	158.51724627438185	156.87200927734375	159.3398647729009	156.46565282812585	52390300	63.93985638784919	153.67994689941406	161.11968341348873
1	3583	156.56478033051607	156.24761962890625	157.08015890910474	154.5924769153983	45992200	60.24869529050211	154.0183377947126	161.46389925057528
1	3584	157.95231889750627	159.33987426757812	159.6173823169816	157.9325076961592	51305700	71.06787504476614	154.7390125819615	162.14966649007715
1	3585	160.09309198521143	160.91571044921875	161.0247325377752	159.83541028637475	49501700	79.28992157669113	155.72020503452845	162.42273110265785
1	3586	160.99499717395898	163.43310546875	163.53222195551984	160.46971306479455	68749800	79.77711427865226	156.7417493547712	163.47788367309332
1	3587	162.80872590475465	164.6918182373047	164.81074592730272	162.75916765957112	56976200	79.041894480512	157.7031195504325	164.87967101837813
1	3588	165.1180039760234	164.15663146972656	165.35585936030904	163.6412529320187	46278300	76.87077590749463	158.5979461669922	165.63472849067054
1	3589	163.27453103673446	162.30323791503906	163.5817709560874	160.36068191775178	51511700	67.55428483960551	159.15791756766183	166.02309674403733
1	3590	160.98510790466275	163.19528198242188	163.4926163777719	160.55894019900367	45390100	71.39063247881896	159.84178161621094	166.2213705438809
1	3591	159.98407924224205	160.58865356445312	160.58865356445312	158.65600290264854	47716900	60.14904328680877	160.169554574149	166.15840071558807
1	3592	160.90581330889393	159.36959838867188	160.9157189090824	159.08216962961518	47644200	53.42960740271913	160.27716064453125	166.14030645121144
1	3593	159.7858591607215	158.6758270263672	160.6183832614872	158.35866634623534	50133100	55.30122985742628	160.43786076137	165.95970658335673
1	3594	160.1922314364538	164.08726501464844	164.32513554824666	159.98409282917345	68445600	62.86383231930259	160.90722329275948	166.47617047809223
1	3595	163.12589186720774	163.74038696289062	164.8405136022097	162.362752263478	49386500	60.0	161.25835854666573	166.88127102838678
1	3596	163.6214388455325	163.76019287109375	163.91877322117935	162.57087049156098	41516200	65.2078588850409	161.750371660505	166.90597380966275
1	3597	164.6224624365103	164.98916625976562	165.9208069034402	164.17645331594588	49923000	68.79791468970377	162.37476784842355	166.71198003646856
1	3598	164.32513190006836	166.13885498046875	166.66413916449648	164.06743504696098	47720200	65.953452001942	162.86040932791573	167.2559660677132
1	3599	164.6125558769993	165.16757202148438	166.37672081756503	164.0872716600362	52456400	60.268086793615325	163.1641137259347	167.5684061716169
1	3600	163.581779650813	163.5520477294922	164.9693197226261	163.02676362208774	58337300	50.30032309293873	163.17260960170202	167.57959529900637
1	3601	163.53221719810315	163.85928344726562	164.12688585531714	162.43209076839383	41949600	47.79179108524842	163.11314283098494	167.45379033599772
1	3602	163.7205685983607	162.31320190429688	164.83060089270833	162.2735492520383	48714100	45.359359527005076	162.9814692905971	167.29753136788244
1	3603	161.60946791600787	162.30323791503906	163.80972071511513	161.35178623723965	45498800	50.0	162.9814692905971	167.29753136788244
1	3604	163.72056830592638	166.91192626953125	167.06058590759594	163.72056830592638	64902300	58.54990010011049	163.2469438825335	168.04945524797103
1	3605	166.9912068392812	168.1706085205078	168.33910959802364	166.3866324741896	55209200	68.59500915733781	163.78851209368025	168.99289472517458
1	3606	167.77418090050938	168.0814208984375	168.93377143610374	167.1398745787384	52472900	72.61964755475262	164.41078513009208	169.41875818226103
1	3607	168.57695592218053	167.04074096679688	168.8346527635164	166.0496364953305	48425700	71.33459166001829	165.0082789829799	168.95165783049146
1	3608	167.99220106828838	165.96043395996094	169.39956754565748	165.67302032909086	65136000	56.13229696382364	165.14207676478796	169.07794636508441
1	3609	163.42321284611648	164.31520080566406	165.5540813733989	162.84837044792107	81235400	51.73436192184484	165.18313489641463	169.06767485245987
1	3610	169.45902904213452	172.0260009765625	172.74950296676494	169.24098486047572	113316400	67.03424281912083	165.77354976109095	171.00543898854812
1	3611	170.94567333669093	171.95660400390625	172.30349657417247	170.5789695681054	55962800	65.07923717786986	166.27122388567244	172.42586065430328
1	3612	171.51064754209378	170.24203491210938	171.99627909889776	170.07354895127378	45326900	58.6683360389715	166.5643081665039	173.07242832143965
1	3613	171.48090823595766	172.01609802246094	172.4819183565725	170.37086089019692	53724500	63.993482543105195	167.0534885951451	174.1153420613939
1	3614	172.30350796985275	172.2043914794922	173.03691555552936	170.63844469472525	49514700	68.77419448825884	167.6715131487165	174.92518316381648
1	3615	172.3135560619337	171.27146911621094	172.75024761525086	169.7132756322357	45497800	65.65809009111229	168.2009549822126	175.33706865706526
1	3616	171.8570325169115	170.77523803710938	171.9066593124194	170.1797467789581	37266700	68.70557759248766	168.80538613455636	175.18684879365188
1	3617	170.69583819309108	170.77523803710938	171.83717876991398	170.50726545654413	42110300	68.73585668421624	169.41052900041853	174.63842983055355
1	3618	170.41792722769495	171.3905487060547	171.62873306746602	169.1376257092288	57951600	62.02916892418588	169.73043060302734	174.84662877007392
1	3619	171.69821088195278	173.7327880859375	173.92136079838062	171.2813731121169	65496700	64.11775595677489	170.12772914341517	175.57527754454907
1	3620	175.06272037880413	173.84197998046875	175.06272037880413	173.62363419943688	55772400	64.60644422434072	170.53919764927454	176.18745918855714
1	3621	172.67084490080313	172.88919067382812	173.3953627585547	172.14483421414405	43570900	64.89569083447333	170.95694405691964	176.34994205441805
1	3622	171.82725170101335	170.26905822753906	172.07537052336497	169.99116635802292	50747300	60.17568617502022	171.26470293317522	175.86257687181498
1	3623	169.80259482166662	170.5469512939453	171.1225887831174	169.2368917775998	45143500	65.73369782966475	171.70982796805245	174.07314538204514
1	3624	171.11268642842802	171.68832397460938	172.5914650743336	170.39810293275275	56058300	48.724245673503745	171.68570818219865	174.04200757881534
1	3625	172.0158462459514	174.10995483398438	174.4474079846001	171.80741974539387	54835000	56.907681554128	171.83951895577567	174.5294921313142
1	3626	175.62844336557998	175.96588134765625	177.64316710040904	175.24137858755796	55964400	68.19636187242298	172.2483651297433	175.56042210530455
1	3627	175.99564434702103	175.91624450683594	178.00044866577474	175.42992616469127	99625300	63.92554301990328	172.52694702148438	176.36860033185528
1	3628	176.36284805087817	178.73486328125	178.76463632708965	175.59863787172938	68901800	69.63001287015454	172.9934092930385	178.0576865673209
1	3629	179.6678245336984	179.5884246826172	180.412181100615	177.91113879546273	61945900	75.11987081051286	173.58747754778182	179.63703569434813
1	3630	181.25576664565278	178.2287139892578	183.55830143833987	176.70029356551757	121946500	71.39588281105591	174.119868687221	180.41039807263786
1	3631	178.61578703231345	177.86151123046875	178.76465227479207	176.09489120388227	64848400	69.92180663228012	174.62603105817522	180.8976153195283
1	3632	177.0972939477575	176.48196411132812	179.84645475343302	175.9857264641506	61944600	63.7238958028457	174.98970358712333	181.03965039576698
1	3633	176.5613658339937	179.21128845214844	179.4792459038042	176.1246893833045	50214900	64.4654217280071	175.38102504185267	181.77944120937292
1	3634	180.13428821622014	179.59835815429688	180.85879103044124	179.27083944935424	48870700	64.9793207945135	175.79219491141183	182.49706134934107
1	3635	179.90601640267764	182.40704345703125	182.50629705263665	179.60827075983389	54274900	72.58593170652577	176.4720415387835	183.80925161226077
1	3636	181.42450705779416	181.9306640625	182.76433976812353	181.06721530624512	54929100	80.80751646080084	177.30501338413782	184.245826603335
1	3637	181.9902041416917	182.5658416748047	183.00253326157815	180.6503714756975	57462900	81.16310831105899	178.16350555419922	184.44547423806486
1	3638	182.57577393042644	184.61033630371094	185.1165084295681	182.39712049072034	65433200	82.00583080682674	179.08650643484933	185.0598264944302
1	3639	185.32491183758503	183.52853393554688	185.58296511233405	182.88343103661734	101235600	74.98676291283924	179.75926208496094	185.43216490749973
1	3640	183.0223827636369	183.61785888671875	184.69966852666565	183.0223827636369	49799100	72.3996998365181	180.3058319091797	185.87795007437222
1	3641	183.50870460713088	182.57579040527344	184.01487677866285	181.21608874116987	49515700	68.42405207568197	180.78151375906808	185.85403510606358
1	3642	182.35743123046893	185.5928955078125	185.64252230545932	182.28795068496888	51245300	68.76706768951712	181.27137320382255	186.79684376356224
1	3643	184.15381217622152	185.27529907226562	186.14868226406438	183.61786698344585	53079300	66.03247145992518	181.67757851736886	187.4983437059435
1	3644	185.42415928991971	183.8759002685547	186.6349803489813	183.83619277653602	48088700	65.88503529015875	182.08094896589006	187.64938453994512
1	3645	184.491243018021	186.64491271972656	186.9724314039452	184.2728972285419	50730800	71.76589007644903	182.70833478655135	188.20770039204834
1	3646	186.5158986853118	187.8259735107422	188.4710764771	186.18839512292732	51216800	78.39054281221192	183.51862117222376	188.37091514693358
1	3647	187.6572341550609	188.16339111328125	188.63979016757608	187.51828821688443	46347300	75.45149689168846	184.1580570765904	188.92386272930096
1	3648	190.188048421843	192.51043701171875	193.0165939677774	189.820822259396	85069600	79.96318895016982	185.0803484235491	190.92130814857293
1	3649	192.32185451119005	191.0117950439453	192.4211080946957	190.3170502473471	31458200	71.26044603425825	185.6949735369001	192.10713595392556
1	3650	190.12850409377413	189.8903045654297	191.5278827838796	189.18564042572623	46920300	69.0589470653614	186.26351928710938	192.64936406927623
1	3651	188.41152151886186	190.36669921875	190.57512571080738	187.7763378847441	45094300	68.82187007811689	186.8207233973912	193.1779939796199
1	3652	189.9697113944817	189.2451934814453	191.2202248903426	188.80851704604538	46778000	61.70426416687988	187.1517846243722	193.4959209276259
1	3653	187.83589888565078	187.1907958984375	188.56041687039792	185.63260216726823	59922200	58.81518558130789	187.4133747645787	193.40623660478704
1	3654	187.73663959244752	186.66476440429688	187.8755855347649	185.19590513637428	46638100	57.18299178971541	187.63101087297713	193.23905831597193
1	3655	188.25272198118796	188.34205627441406	190.2575264802813	187.05183525729512	60750200	63.198504603958945	188.04288700648718	192.83995283064388
1	3656	189.06656985308751	189.10626220703125	189.75138032441	188.35198633031388	41342300	58.96656250876204	188.29384177071708	192.90269926492059
1	3657	188.79856640670437	189.25511169433594	189.74141488458457	188.20309033097672	41573900	60.2452374087607	188.57811410086495	192.86462903070446
1	3658	190.45600381205304	192.53028869628906	192.85780736222108	190.3666846697001	50520200	70.31687466865355	189.196284702846	193.03435969693976
1	3659	191.89511697543264	192.27224731445312	192.8677385882339	190.97210701546965	48353800	64.9762316844276	189.59823717389787	193.46387633258834
1	3660	191.6469920909872	193.63194274902344	196.7383802309494	191.20036607775168	80507300	65.30610603008283	190.01294926234655	194.2840451904763
1	3661	193.6220009023945	191.6767578125	194.9916216501567	191.05149353304836	59581200	58.534236725253706	190.26390402657645	194.47937165541535
1	3662	192.6394780020551	190.4957275390625	193.50292673966078	189.79106335340356	71917800	44.21656729466965	190.119996207101	194.13803028676415
1	3663	191.95464362925216	191.2996063232422	193.44335651892717	190.8033686933505	45377800	50.86051625500698	190.1405541556222	194.18112536861364
1	3664	191.87524425723274	192.16305541992188	192.97689240402684	191.46832576518025	37283200	56.90170787695576	190.30289350237166	194.48045741271414
1	3665	192.21268170555348	193.03643798828125	194.16785917844345	191.86532445108293	47471900	57.9163786020147	190.49358912876673	194.92002084017673
1	3666	194.54503217158796	191.76609802246094	195.71614587462116	191.1011413216581	47460200	57.40964990177874	190.67365373883928	195.0864002762219
1	3667	193.20517029738988	194.3564453125	195.15042860374737	192.6791595850325	48291400	70.41855587266969	191.18548583984375	195.51961248079124
1	3668	194.58470647584855	194.97177124023438	195.01147873318087	193.79072320060368	38824100	73.55101115585141	191.77884347098214	195.70195579869912
1	3669	194.76335631965225	194.13809204101562	195.24965951950642	193.81057337810935	35175100	67.25772112975787	192.19284602573939	195.76087101519548
1	3670	193.57240149095236	191.13092041015625	193.7113474455995	190.40641758549418	50389300	55.31809663057889	192.33746446881975	195.5086322218727
1	3671	190.1285055646349	189.73150634765625	190.92247371064892	189.2551224312535	61235200	51.17418883149763	192.37149265834265	195.40752748325934
1	3672	184.12401134794416	180.62057495117188	185.97001590594638	180.55109441504618	115799700	27.20355997319973	191.52079881940568	198.49071725864624
1	3673	180.7595446995356	177.5042266845703	181.75202007346337	176.01551362367866	97576100	24.520480506727665	190.46594020298548	200.66708155199228
1	3674	178.33787911929193	178.44705200195312	178.9135165784173	176.2437557474966	67823000	23.41888697463841	189.38130514962333	201.2286120471619
1	3675	179.5090242423061	176.8491973876953	179.56857034442828	175.678068518058	60378500	23.715571539626296	188.3221936907087	201.8214391993109
1	3676	178.12947648415997	176.63084411621094	179.38992445369044	176.26363307266737	54686900	24.553591681943203	187.33184487479073	202.11727044117922
1	3677	176.22338084720406	176.69046020507812	177.51532893244283	175.45813862661385	51988100	22.43457340924232	186.288334437779	201.90617207161
1	3678	176.86936795132465	178.35015869140625	178.57873203906215	176.2134459995229	43675600	24.697287156254617	185.30169895717077	201.06537447272768
1	3679	177.77371834663836	176.35255432128906	178.36999853743362	175.9550341940922	43622600	20.647129853890007	184.10999298095703	199.87736417477072
1	3680	176.03454634490478	175.47801208496094	177.43581469068437	175.40843772025733	46964900	20.938743151606104	182.94655827113561	198.6840930886198
1	3681	176.04448461625057	172.9239044189453	176.41219151441152	172.40711609073566	66062900	11.710474449987913	181.41566249302454	196.5294319510994
1	3682	171.23443009200113	173.410888671875	174.0171167915457	170.8965364290824	61114200	11.303741532367596	179.87559945242745	193.34337055119826
1	3683	173.98729066685254	174.7525177001953	175.0407326935708	172.66551420323125	46311900	15.830861212491214	178.4909155709403	189.38159145836886
1	3684	175.96499481130297	176.13394165039062	176.5811556555548	175.1600065691228	42084200	21.959178782553124	177.41970280238561	185.55685062562122
1	3685	177.41595140978353	179.99986267089844	180.42721123128223	177.22712403410847	52722800	33.34069946948148	176.7245853969029	181.14498918186825
1	3686	179.55266206734146	175.28919982910156	179.98001065949663	174.92147774645116	54945800	39.25454041084053	176.3437728881836	180.20108339235077
1	3687	176.28301269216934	177.50540161132812	178.04205535297126	174.73266281139772	51449600	50.00245724238686	176.34385681152344	180.2012761256543
1	3688	178.97623493994635	179.07562255859375	179.4731427043403	177.4457656979585	43820700	51.2809764701346	176.38875470842635	180.3644448692419
1	3689	178.58866011417203	182.9813232421875	183.75649819628302	178.389900027249	53003900	61.42234849453802	176.82676369803292	182.14534913720877
1	3690	183.79625497655422	186.48948669433594	186.68826194099242	183.59749489432	60813900	66.35883210229892	177.53095245361328	184.93825398576755
1	3691	186.67830137193894	186.70811462402344	187.9503840089481	186.32052718250378	60794500	66.53542771623572	178.24649919782365	187.09856814746442
1	3692	188.31811281370076	188.28829956054688	188.7454462185212	187.1155893336136	45732600	66.44735380096284	178.95636640276228	189.31069517709983
1	3693	187.11559340947835	188.5268096923828	188.8050768374951	186.44973880050088	45280000	71.39371305011883	179.8259560721261	191.22995462721198
1	3694	187.23484633917346	181.77880859375	187.68207547486304	180.34771175415628	81755800	59.17778673735148	180.27601296561105	191.43555037050874
1	3695	174.0965977246818	176.46188354492188	177.10787273977496	172.46674085776903	112488800	54.769559895913694	180.52872576032365	191.11666715404726
1	3696	177.24701069547294	177.0780487060547	179.12532149203676	176.6904612453168	65551300	54.92654996164633	180.79066576276506	190.78485832286043
1	3697	178.9563786732192	178.25076293945312	179.18495201045798	176.2432512228952	58953100	54.72105222623227	181.04054042271204	190.54746708786024
1	3698	178.37996034233754	175.20968627929688	179.0160016942275	173.73884349638047	90370200	48.806151595017106	180.97452218191964	190.63974148094368
1	3699	175.41837777577814	173.1326141357422	176.20350055461225	172.9040256402011	84267900	40.69988312137028	180.4840044294085	191.02010444710032
1	3700	172.92390792735483	174.6531524658203	175.0109266750055	172.5065072107091	60895800	49.05715174962091	180.4385724748884	191.07616191488333
1	3701	175.38855280048267	173.92764282226562	175.40843335624928	172.74501513151833	109205100	44.45126516795861	180.18301827566964	191.28587870959353
1	3702	175.38856362269223	176.86935424804688	178.27063780985006	175.08048322919404	67257600	46.7179274389347	180.02542768205916	191.25787058068536
1	3703	176.42215294794642	177.9625701904297	178.51910451081574	176.03456546307592	51826900	41.8522546267969	179.66694532121932	190.81302696188624
1	3704	178.1513672500879	174.40469360351562	178.5886485115626	174.3152386804528	58436200	30.412437681255483	178.80374581473214	189.53797326680822
1	3705	173.47050026870355	172.8543243408203	175.20967741085585	172.78476514063325	63047900	28.47444687852665	177.81418936593192	187.9469130306473
1	3706	173.58974662979438	173.70899963378906	175.98484555615838	172.9735858899277	56725400	26.82467632324355	176.77281079973494	185.1052740374742
1	3707	173.12266501245767	174.9910430908203	175.87553831983675	173.07297120229282	46172700	29.174394374635526	175.80597032819475	180.69169823910974
1	3708	173.73885876847856	170.89654541015625	174.1164984027068	170.59839768303257	64588900	31.7683275371418	175.02866581508093	179.2366223722286
1	3709	171.5524350388733	169.3759765625	171.9698357492923	168.00452141810098	66921800	36.39838461376242	174.52252960205078	179.60219550131217
1	3710	168.29272705350883	169.63438415527344	170.96609339598558	166.5833630389383	56294400	35.51268146715624	173.990839276995	179.4614694460031
1	3711	170.95614167013932	170.15115356445312	171.9996509482002	169.28652379235777	51814200	33.822996982903106	173.41229575020927	178.65048663395862
1	25978	170.16109351938684	172.67544555664062	173.22204712222216	169.87287852825236	52164500	44.831768918917234	173.23127637590682	178.37622806312805
1	25979	171.1946676938173	171.33380126953125	172.55620536089927	169.76358598551198	49594600	46.218130466109876	173.10278974260603	178.3472379335701
1	25980	170.03190052575047	172.5860137939453	173.13261538484517	169.91264751116213	53020300	45.604436608247774	172.95513807024275	178.12746192177843
1	25981	172.7151938850701	173.82827758789062	174.3649313004983	171.61205804275627	48527900	49.79322037126992	172.94803946358817	178.11488368909446
1	25982	172.72513710071527	176.39231872558594	176.88922647606876	172.10896117831024	57224100	48.99159094647816	172.91396549769811	177.9746131627945
1	25983	175.71651571148107	177.88304138183594	177.94266788538698	174.7127675180559	42390800	49.83466208508495	172.90828486851282	177.94464060512286
1	25984	176.99855858071479	177.28675842285156	178.60853494693302	176.84947714698436	43698000	56.83320864150545	173.11414773123605	178.62705234240158
1	25985	177.09792315514355	178.6880340576172	178.7377278666485	176.50164294003199	47551100	63.92978523709033	173.53084128243583	179.79046064749272
1	25986	178.95638111240146	179.59242248535156	181.21233159015208	177.9327371003315	56743100	64.01521705310266	173.95108577183314	181.00216888959716
1	25987	180.29800974299292	177.74391174316406	180.80485019878847	177.03829605191484	51427100	56.38542464496711	174.14771924700057	181.47197765898494
1	25988	175.6569128281916	177.61473083496094	177.97250506879755	175.41839161749283	52517000	69.09605539141614	174.6275907244001	181.91449235796227
1	25989	175.55752029881808	176.05442810058594	177.31657816311466	173.71897053093056	57549400	68.94027188405245	175.10462297712053	181.75737525699918
1	25990	174.4941311237392	174.7525177001953	176.48176216718392	174.027036615376	54764400	63.704080790516805	175.47020503452845	181.34508799810746
1	25991	174.9512928962145	174.37489318847656	176.7401640228471	174.106558728376	59302900	61.39413807354329	175.7718996320452	180.8498943594314
1	25992	174.2258012947257	171.8108367919922	174.3351216115833	171.57231560127875	64189300	47.67258170382973	175.71014186314173	180.96819630416272
1	25993	169.85302851446286	171.9300994873047	172.93384778812512	168.87907830418513	55980100	51.71823708233415	175.7527345929827	180.86573940103693
1	25994	171.97979837385134	172.3673858642578	172.59595921387623	170.38968729481687	43816600	49.338977796149756	175.73711831229073	180.89294280904298
1	25995	170.81702981156988	170.04185485839844	171.98972493811345	169.59462570782657	57157000	39.25555673905344	175.46665954589844	181.3934304130198
1	25996	169.31635357139493	165.85787963867188	170.32011700092076	164.64542343181446	70625300	22.624041087036346	174.71419961111886	182.51373717141874
1	25997	165.87774586751993	167.1796417236328	167.9150706400693	165.79823880916834	58499100	21.938537116157008	173.94967106410436	182.47567661825283
1	25998	167.97468177697908	169.23681640625	170.11137880369458	167.8256003695495	51131000	30.396826399504747	173.37467520577567	182.0162147493857
1	25999	168.30266621223763	169.71388244628906	169.8430681534906	166.86162156099337	44846000	27.116134072925817	172.7336643763951	181.00064711021923
1	26000	169.94247040994804	172.89410400390625	173.15249060498644	169.0679078148722	56934900	34.69576015858529	172.25521305629186	179.52777731047257
1	26001	174.43450739060134	176.47183227539062	176.68052504619254	174.37488088465793	77334800	47.30640959943961	172.16435023716517	179.1683403052151
1	26002	173.16244148240884	175.55752563476562	175.7264876371941	172.27794617495533	79763700	45.784106053868726	172.0174070085798	178.6026188346789
1	26003	175.28920139472822	178.12156677246094	178.3203268607263	175.12025456148152	63841300	54.06885871804759	172.16505977085657	179.21639475571436
1	26004	178.07185390554656	180.69554138183594	181.31170213885602	177.86316114274607	70530000	61.140101183679725	172.58956146240234	180.91275724003512
1	26005	181.22227266382137	181.75892639160156	182.31546067653568	180.466963136192	49340300	63.49432531161987	173.1169924054827	182.75890311754918
1	26006	181.82847712787998	181.28187561035156	182.98129149780723	180.68558028860784	53763500	68.73763792991024	173.79349517822266	184.3283169732822
1	26007	183.07312579736603	185.49127197265625	185.66045656490678	182.63526841968368	66133400	73.09235904292774	174.76215035574776	186.92669741569725
1	26008	184.91409464160964	183.89906311035156	185.12306234297503	183.31194313207843	43627500	68.89334885320918	175.5858415876116	188.58492324859364
1	26009	186.78494160849297	186.52621459960938	187.1929464637487	185.3917728154259	60108400	76.74344224107243	176.76329585484095	190.56094109610171
1	26010	186.93420587357204	187.09341430664062	188.5761557735661	186.86453984677962	53790500	89.03208182396449	178.28011975969588	191.57316564467538
1	26011	188.64582412031268	188.78514099121094	190.02904704723116	187.73029590080972	54412900	89.1792473713337	179.82336970738	192.5704194023141
1	26012	189.3224957374494	188.76522827148438	189.45186682219116	187.65069333955432	50922700	88.23796554019573	181.2182562691825	193.22755332483266
1	26013	188.96425501994514	190.5166473388672	190.97441144582112	188.9543092379418	46505100	88.79705316214779	182.70416804722376	193.68560465372497
1	26014	190.47683687643212	189.71058654785156	190.58630120908649	188.81498032387879	38134500	84.40985407225762	183.9053453717913	193.89883253516444
1	26015	190.55644969232256	190.3773193359375	191.98941662140743	189.89966369290923	39617700	82.30143325625215	184.89859444754464	194.46447164552248
1	26016	189.93947531002817	189.0438690185547	189.96932784078396	188.3273779116158	24048300	80.72940533466658	185.86190468924386	193.9827368432951
1	26017	188.994117188391	188.86474609375	189.74046085550287	187.9790855494866	40552600	77.46381079805431	186.62927464076452	193.53948905981468
1	26018	188.85478346401288	189.4717559814453	190.1484487418159	188.4766311807352	38415400	74.94401065835834	187.25614711216517	193.39705404166324
1	26019	189.96933244559008	188.44679260253906	191.15353347560767	188.04874872654685	43014200	69.05005302595664	187.73385184151786	193.01264173619205
1	26020	188.91449196138143	189.02395629882812	189.39216280718497	187.27254208408095	48794400	71.92786840469824	188.28685760498047	192.06200837836025
1	26021	189.40211098182942	190.30767822265625	190.6261102728152	188.3074675935333	45679300	66.35136199186907	188.6308866228376	192.17965301110286
1	26022	189.05382196941733	188.50650024414062	189.12348800008925	186.53615721754525	43389500	65.42309267861137	188.9599892752511	191.2496760386044
1	26023	189.28270844769884	192.47705078125	193.45226890347428	189.2528407319119	66628400	68.27628545185296	189.38504900251115	191.92431991254333
1	26024	193.50200591924838	191.3824005126953	193.81049216434678	191.17341763263576	41089700	62.75902014240491	189.6914051600865	192.0694800501654
1	26025	192.68602720531442	193.32290649414062	194.0493433741143	192.64621370853777	47477700	63.30220403986005	190.0155312674386	193.0168237849581
1	26026	193.25322651912307	194.75587463378906	195.0345083535154	192.72581160789824	53377300	66.21767539616512	190.44343457903182	194.27124334176887
1	26027	192.1685693679781	192.23822021484375	192.54672168765146	190.48680586341095	60943700	54.47493441786786	190.56640407017298	194.51310996762035
1	26028	192.13871428631938	193.76077270507812	193.77071848752672	190.7853438376791	52696900	60.14971065067081	190.85570308140345	195.11367069614613
1	26029	194.13890022421998	196.9949188232422	197.03471713546693	193.90007998207173	70404200	64.69295258925891	191.32838875906808	196.68509587317024
1	26030	197.0546379594379	197.14419555664062	198.64682869695653	195.2037050285768	66831600	68.98324394721655	191.9069835117885	197.9114506418515
1	26031	196.5670132843794	196.60682678222656	197.4327670575499	196.0395983209077	128256700	67.84406763924517	192.4599892752511	198.67971437291285
1	26032	195.13401948283078	194.93499755859375	195.6713953811102	193.44231035021684	55751900	62.00262419854335	192.850220816476	198.9466355143567
1	26033	195.20369275359957	195.97988891601562	195.98983469805682	194.9350047944863	40714100	66.5355715299144	193.38829912458147	199.12995879369004
1	26034	195.94008865557052	193.88018798828125	196.71628487042167	193.88018798828125	52242800	59.99183719601404	193.73517281668526	198.89870167990588
1	26035	195.14397125694492	193.7308807373047	196.11918926884985	192.55664081053737	46482500	57.388234441740295	193.9796872820173	198.75355445304558
1	26036	194.22845757962483	192.6561737060547	194.45734722393942	192.02924020237552	37122800	59.24610797376644	194.27609252929688	197.98192170411727
1	26037	192.66613899324835	192.10887145996094	192.94477275989206	191.8899427598264	28919300	49.03196610096053	194.24979400634766	198.0153633459507
1	26038	191.55158790358445	192.20835876464844	192.5566585360189	190.15840400250286	48087700	52.29156612224509	194.30879102434432	197.90281164804577
1	26039	193.19355905178492	192.63629150390625	193.7110282824159	192.2282866262087	34049900	47.92049851101075	194.25974709647042	197.92965846972788
1	26040	192.9547010641641	191.5913848876953	193.452263485871	190.7952819760843	42628800	40.18523251081391	194.03371211460657	197.95330941716207
1	26041	186.23761848029775	184.7349853515625	187.52133810124718	182.9935167810597	82488700	31.6634771570954	193.49776676722936	199.80165431582947
1	26042	183.32190833232914	183.3517608642578	184.97381929292	182.53575116647167	58414500	24.38787946141953	192.75426592145647	201.0615361161532
1	26043	181.26198308479132	181.02316284179688	182.19740286158623	179.99818547387906	71983600	8.86734041875954	191.6134262084961	201.62417931484427
1	26044	181.10277101042314	180.2967071533203	181.8690061871609	179.29163655398915	62303300	7.864659140606463	190.4100341796875	201.5442353364732
1	26045	181.20228054123743	184.65536499023438	184.6951784875532	180.6151605231867	59144500	24.906015820483333	189.55635833740234	200.47447623323296
1	26046	183.02335798455337	184.23741149902344	184.24735728099782	181.83915700040632	42841800	26.29031134402598	188.79224504743303	199.58546924209315
1	26047	183.45127673118873	185.2823028564453	185.49127057687537	183.02336513916433	46792900	26.29031134402598	188.02813175746374	198.1213555285266
1	26048	185.630561384214	184.68519592285156	186.13808471707472	182.72479898016607	49128400	28.166352291724493	187.37134660993303	197.010646192641
1	26049	185.1529124416028	185.0135955810547	185.82960518169298	184.2871587499394	40444700	29.475240780499576	186.7486833844866	195.72154325190948
1	26050	181.2719521956393	182.7347869873047	183.36170533773222	180.04793765769844	65603000	27.893646014377453	186.0400129045759	194.55870953026763
1	26051	180.3862988523529	181.78941345214844	182.03819468263436	179.42102646331548	47317400	27.40745788802745	185.30290876116072	193.3312558644654
1	26052	185.18277784532793	187.7104034423828	188.21791164443712	184.9240508532924	78005800	42.15282162788395	184.98162623814173	192.1315017054012
1	26053	188.40700480824998	190.62612915039062	191.01422726569237	187.8994965603635	68741000	46.77315530142332	184.83804321289062	191.38068970153154
1	26054	191.36250312836654	192.9447479248047	194.37773007418247	191.3226896328841	60133900	52.087157301826664	184.93471200125558	191.9314240760982
1	26055	194.06924615918857	194.22845458984375	194.79568302432682	192.8850451968675	42355600	67.67969428442824	185.6128169468471	194.1882133569057
1	26056	194.4672860626603	193.55177307128906	195.42261254918643	193.39254945946814	53631300	69.5088837524223	186.34138924734933	195.77911762534566
1	26057	194.26825745113464	193.22337341308594	195.31314148918335	192.16854359379062	54822100	75.26784670275669	187.21283285958427	196.78725725973547
1	26058	193.32288994227028	191.48190307617188	193.81049135303678	191.00424744654802	44594000	72.23097335739305	188.01177542550224	196.9454118636559
1	26059	191.07393711733675	190.79530334472656	191.26301328826548	188.6557907655265	47145600	64.28907766421429	188.45034245082311	197.27638446290635
1	26060	190.00914701951908	187.12327575683594	190.86495502370778	186.55606247111587	55859400	55.83266822181459	188.65647561209542	197.18857344557347
1	26061	186.12815142243116	183.5010223388672	186.18787167030365	183.45127824224116	55467800	46.73951173952291	188.52924128941126	197.32707791732832
1	26062	183.09303209854838	185.94903564453125	186.03859323945602	182.9238626911125	64885400	52.166552532496844	188.61951555524553	197.2721799650654
1	26063	178.9831513103476	184.94395446777344	186.41673495449575	178.3761245608121	102518000	49.88332378926701	188.61454119001115	197.2762109267353
1	26064	187.23273981487074	186.76502990722656	188.3273832549743	184.9340037750539	69668800	56.857416132787634	188.9024156842913	196.96979876775242
1	26065	185.94904424082173	188.3771514892578	188.38709727213126	185.8594866417568	43490800	60.960286117861145	189.37296840122767	196.3476456882328
1	26066	189.71060210551596	188.48660278320312	190.118606941087	187.69049986083044	53439000	51.6009902604249	189.42841121128626	196.3583548825387
1	26067	188.46670752859183	187.4019317626953	188.61597019246477	186.4366593779137	40962000	42.806397339639254	189.19811139787947	196.1707600794509
1	26068	187.96985257532495	188.1691436767578	189.30503301755343	187.3222021069975	45155200	38.55252377468911	188.85699680873327	195.49952661745561
1	26069	187.74067569026312	186.47525024414062	187.98977434952795	186.11654756664825	41781900	31.773421279563124	188.3031964983259	194.27561614391033
1	26070	185.10024282819998	184.37286376953125	185.53865891732192	182.84838113476025	56529500	29.777377653855893	187.6475601196289	193.1334516981423
1	26071	184.6518638454696	183.48606872558594	184.8610982078661	181.78224238811126	54630500	29.062308059782993	186.95203835623605	191.8278682342764
1	26072	182.88824837462906	183.19712829589844	183.82486181575325	180.69618309757163	65434500	30.998677836579475	186.36026872907365	190.86467946817163
1	26073	182.75870865343296	181.6527099609375	184.18356093832674	181.015017979917	49701400	29.825103691267714	185.7072263445173	190.091206056541
1	26074	181.13456200161647	180.9053955078125	181.7722539176	179.3510224128385	53665600	34.24547056553848	185.26309204101562	190.2477905785467
1	26075	181.28405435734408	181.66268920898438	182.23062628266825	180.00867035619171	41529700	44.55104228384313	185.13178253173828	190.40493904385642
1	26076	182.81848586019305	183.7052764892578	184.29316088677606	181.8021742653834	52292200	43.18554871238768	184.97151402064733	190.27398069204025
1	26077	184.3429666556088	181.86195373535156	184.37285727847149	181.57299077597804	45119700	41.09324702126346	184.7513711111886	190.3085597096064
1	26078	181.5829745492965	180.50686645507812	182.10108884357552	179.99869543060538	40867400	31.413782446065596	184.30435943603516	190.16245436226933
1	26079	180.4470750372319	181.9715576171875	183.25690001064538	178.9126187804792	54318900	30.80785868484888	183.84681701660156	189.32276852042102
1	26080	181.85199678307725	180.76593017578125	182.45979817680953	179.48058766314844	48953900	28.293499486919018	183.29534040178572	188.29260510612247
1	26081	180.61647239906964	180.0983428955078	181.91178855608587	178.88274013933005	136682600	28.97298655565845	182.7736554827009	187.43800985271162
1	26082	178.9026640457765	179.01226806640625	179.87912655443867	176.74048946042234	73488000	24.1126729941479	182.11959293910436	186.03230313810852
1	26083	175.51490641269265	174.4687042236328	176.26220237846417	173.16341449891394	81510100	20.766636425038286	181.26198250906808	186.1929720200388
1	26084	170.14434479927544	169.50665283203125	171.4197287337638	169.00845550750375	95132400	18.22828549775052	180.20011029924666	187.88119224227611
1	26085	170.44326190896186	168.51025390625	170.6226208472031	168.0718378391885	68587700	18.143286802763654	179.13040924072266	188.76340364928825
1	26086	168.5401544147667	168.3907012939453	170.1144598371159	167.8825454793763	71765100	18.274984960636104	178.07280731201172	188.9529403188202
1	26087	168.39069767067738	170.1144561767578	173.0737495355564	168.33091642363513	76114600	25.46608758962101	177.24864632742745	188.69398770441165
1	26088	172.31649942978052	172.12718200683594	173.75131021022753	171.42970876738985	60139500	32.287932965641076	176.6216310773577	188.16539377550788
1	26089	172.52572483722957	172.60543823242188	173.40255698056936	170.39344092810595	59825400	31.516781298810002	175.97468457903182	187.314851001348
1	26090	172.14711771653415	170.51303100585938	172.56560166885345	170.14435462584885	52488700	23.13308858215231	175.03238133021765	185.78247227468688
1	26091	172.28659461404473	172.3762664794922	173.68154097803347	171.42969464651588	72913500	30.697404063625967	174.3548322405134	184.4248845338543
1	26092	170.55286572568298	171.9976348876953	171.9976348876953	169.67603359258842	121664700	31.96780946431238	173.74702998570032	183.22747580642627
1	26093	174.93702524630143	173.09368896484375	177.06930930187292	172.89441306506424	75604200	30.888016429565326	173.11289651053292	181.32659085683298
1	26094	173.71144297319321	175.44517517089844	175.9732631292534	172.40616838919217	55215200	39.084188929702634	172.73284258161272	179.83883017108593
1	26095	175.08647190626633	178.0258331298828	178.0258331298828	174.45873840154812	53423100	46.057596522474114	172.58480616978235	179.09083392946158
1	26096	176.41168117904223	170.7521514892578	176.8500972709565	170.22406352502733	106181300	37.28134992704811	171.99479784284318	177.39394621201478
1	26097	171.14074502028382	171.65887451171875	172.42610267352754	169.44687710249696	71106600	45.127848824010954	171.7940957205636	177.00263318048673
1	26098	169.9550500090239	170.23403930664062	171.32010587263267	168.83907761478048	54288300	51.437613543423346	171.84605189732142	176.97012455212976
1	26099	169.38709229314748	169.09814453125	170.80197088667242	168.96860836017046	57388400	51.15554094600318	171.88804408482142	176.9028268993569
1	26100	169.79562681694486	172.68516540527344	172.97412838637234	169.4967053620682	60273300	57.42848968137749	172.19479152134485	176.79639096385836
1	26101	171.13077090878156	170.8617401123047	171.60903605513778	169.89523614327186	65672700	51.288196903108776	172.2481689453125	176.76232358862353
1	26102	170.5728137058907	169.4169921875	170.6325949561908	168.86897205345468	46240500	45.23475693678698	172.05458395821708	176.81672460165447
1	26103	168.47041766713258	168.2312774658203	168.72947481572177	167.62347609078947	49329500	42.49573956225475	171.74214390345983	176.90565539422366
1	26104	168.1814453345995	169.03834533691406	170.0646306043195	167.97221097339488	47691700	47.35332151372099	171.63680921282088	176.96584399594684
1	26105	169.67605100414067	168.21136474609375	171.30017927084614	168.21136474609375	53704400	42.236301153614015	171.33931623186385	176.94819193992558
1	26106	168.97855588471026	168.96859741210938	169.77567460225572	168.3408639514289	42055200	44.43222812407618	171.12295641217912	176.85478103964988
1	26107	168.42059262733576	167.84268188476562	168.58997789957206	167.6334475147346	37425500	40.35853809964609	170.74788447788782	176.6099346015174
1	26108	168.09176931793073	169.0582733154297	169.46679875844995	167.74304032326918	42451200	37.7624409862273	170.2916772024972	175.54109615351703
1	26109	168.19142141332685	167.1750946044922	168.48036917466098	166.50751200767976	49709300	28.638605117261577	169.5166244506836	172.6072714941441
1	26110	167.73307888899373	174.40892028808594	174.8274194382653	167.55373514215378	91070300	57.21024242540942	169.77782222202845	173.79690033544267
1	26111	173.63173034934167	175.91348266601562	177.71695459263955	173.58192277868224	101593300	58.19581059250393	170.08172280447823	175.20518939944876
1	26112	174.72777001691693	172.06739807128906	175.993195505436	171.87808065130085	73531800	53.230332773933426	170.21267700195312	175.4454679107532
1	26113	171.1307833718662	168.7693328857422	173.13353117115574	167.6633342016507	73711200	49.46166018213968	170.18919045584542	175.4464247161223
1	26114	168.99849837401	167.39430236816406	170.0347421275801	167.39430236816406	50901200	40.661234840821216	169.81127166748047	175.056259198308
1	26115	167.4241802492927	166.437744140625	168.0319815519269	165.94952052629202	43122900	41.94481720107465	169.49527195521765	174.9945412412793
1	26116	165.610765092168	164.40512084960938	165.80006730864108	163.48843957599198	67772100	41.06568337629244	169.1372811453683	175.27407272475733
1	26117	164.92325754431266	165.24209594726562	166.65697461863107	164.17596150778874	48116400	44.60430545020264	168.92376817975725	175.39522221773004
1	26118	164.75386398167788	166.2982635498047	166.44773187185876	164.32540636965405	49537800	45.09803172218303	168.72804805210657	175.3485973883195
1	26119	165.93957460997115	168.41064453125	168.68963384433354	165.61077772251915	48251800	50.34083340814618	168.7422823224749	175.35890208862773
1	26120	168.91879363485126	169.27749633789062	169.9949017439694	167.54376407257087	50558300	50.52634425264524	168.76434653145927	175.38627526708495
1	26121	169.26751639469646	168.68960571289062	170.72224396978115	168.57002802452664	44838400	51.470058522652636	168.82484109061105	175.425941040198
1	26122	172.74492977704497	172.8744659423828	175.39534310552878	172.47591417733986	68169400	56.005013421948604	169.09742627825057	176.04607141509092
1	26123	172.70508045160457	169.7158966064453	174.35909916149876	169.38708455902474	65934800	53.84382412878337	169.27891213553292	176.14349127274835
1	26124	168.96859497944865	168.68960571289062	172.0873148851987	168.5002883097745	50383100	39.34669450544204	168.8703896658761	175.06820024146973
1	26125	171.8880442050533	172.4061737060547	172.7947670308616	170.27388965643632	94214900	43.96434511483644	168.6198675973075	173.78959406678527
1	26126	185.97705638865938	182.71885681152344	186.32580059963428	182.00145144318	163224100	64.99296802578075	169.3806860787528	178.42165160036336
1	26127	181.6925778578994	181.0548858642578	183.5358989126904	179.76952819965473	78569700	68.12701105794818	170.25822557721818	181.2236827669676
1	26128	182.78860333233249	181.7423858642578	184.23337259597065	180.66629297548113	77305800	71.60863098794552	171.28308868408203	183.6836237458315
1	26129	182.19076551728074	182.08116149902344	182.40997355379537	180.79580390275353	45057100	74.00614714272133	172.40047563825334	185.70639553770465
1	26130	181.90182360877466	183.9045867919922	183.99425867082294	181.45344901084354	48983000	80.11694996820782	173.79329463413782	187.56800990827617
1	26131	184.48325715706596	182.63743591308594	184.67283136158454	181.7195112814573	50759500	76.51479242323528	175.03581891741072	188.62479342479892
1	26132	185.0220348889267	185.86013793945312	186.67829703001243	184.2038757983674	72044800	77.96981283890305	176.43309565952845	190.17392082677858
1	26133	187.0873746193062	187.00755310058594	187.87560260141976	185.87012310151908	52393600	77.34465201036198	177.7614462716239	191.75473709353074
1	26134	187.48648604697289	189.2924041748047	190.2203008031565	186.9476945906926	70400000	78.25156507179321	179.19108254568917	193.53586081308148
1	26135	190.04070957734746	189.41212463378906	190.66929452090585	189.23253763528552	52845200	79.64214762065447	180.67126246861048	194.61926244373737
1	26136	189.08285791419516	189.44204711914062	190.3799308889647	188.7535998742954	41282900	76.89582106130408	181.85466112409318	195.76434076172862
1	26137	188.90328335886426	190.6094207763672	191.48744227389747	188.58399727816297	44361300	86.26296621157806	183.34705570765905	196.0800798819107
1	26138	190.65930352654095	191.91647338867188	192.295606563888	190.48968851208156	42309400	89.92364602304677	185.00611768450057	195.33876134148557
1	26139	191.83664908760778	190.4697265625	192.38541249371693	189.84115686495446	34648500	83.67641862987013	186.29637145996094	194.03771545980572
1	26140	190.54955125962866	186.45880126953125	190.5695104450197	186.20936473753514	51005900	59.114021107555416	186.56351034981864	194.0261559989659
1	26141	188.3944296603675	189.5518035888672	190.15045735054443	187.61617368042806	36294600	69.35819619131051	187.1704330444336	194.06355092407773
1	26142	191.07834591388357	189.56178283691406	192.56499305086223	188.6737894364844	52280100	68.3821081751188	187.72896139962333	193.963147387909
1	26143	189.18265440509	189.86111450195312	191.81670371975596	189.0828736970108	53068000	68.32336306325797	188.284672328404	193.68086818985415
1	26144	190.33005195445256	190.85885620117188	191.74684967437963	190.2003553062749	49947900	67.04150715941104	188.78140585763114	193.69992271622536
1	26145	191.00850903182757	191.81668090820312	192.13596695656702	189.48195877103	75158300	72.84009115215134	189.43706621442522	193.1194332287433
1	26146	192.46522387732944	193.59268188476562	194.55052487571635	192.08609069758458	50080500	70.73302850484572	189.98939078194755	193.6802647212446
1	26147	194.20129645164835	193.91195678710938	194.87977170290745	192.59492465346364	47471400	69.37289942500439	190.48256247384208	194.3000687309747
1	26148	194.95958593724887	195.42852783203125	196.45620511862302	194.43078171111515	54156800	67.99294845120963	190.92085702078683	195.48560716425163
1	26149	195.24895132280378	194.0416717529297	196.05712328824086	193.73237287474004	41181800	62.6361900763664	191.2515389578683	196.01202927367754
1	26150	194.2112712938544	196.44622802734375	196.4961183769711	193.7024262662087	53103900	66.9238403954719	191.75183759416853	197.1258125679101
1	26151	196.45620195884163	192.68472290039062	196.85530953542744	191.7169079607164	97262100	54.455853609153955	191.9000734601702	197.25275064543
1	26152	193.21353266624035	206.68310546875	206.6930926736998	193.1935887051364	172373300	70.52135374697825	192.9548328944615	202.49952564965798
1	26153	206.902617394007	212.58978271484375	219.7037025197263	206.43367547843766	198134300	77.35015580038534	194.53483690534318	208.57307581360013
1	26154	214.25601418934664	213.75714111328125	216.2614784743462	211.12309188063193	97862700	86.30575161435651	196.4847183227539	213.04723944941765
1	26155	213.36801320894725	212.01107788085938	214.68503016669274	210.8237575657328	70122700	80.97991334242874	198.08895220075334	216.05047689581778
1	26156	212.88909055319678	216.18165588378906	218.45651588142053	212.2405616472853	93728300	82.93827641598565	199.99037170410156	219.62175132466461
1	26157	217.09957203800778	213.8070068359375	218.13723651623954	212.5199210550432	79943300	78.18222175291301	201.70079258510046	221.69972305272188
1	26158	213.44781843702847	209.2073974609375	213.75713252024897	208.3792815854295	86172500	69.90688961244068	203.0114026750837	222.34343837039626
1	26159	209.91581187096148	207.02235412597656	211.41243109582913	206.64320571720273	246421400	66.06919118280214	204.09752219063895	222.40149797633012
1	26160	207.25183162238307	207.67088317871094	212.22060318958276	206.1243736003879	80727000	65.24088128047131	205.10310799734933	222.4424884367668
1	26161	208.67859169129048	208.59878540039062	210.90357646615678	208.13981549353107	56713900	65.69297390362962	206.15216718401228	222.31191216667497
1	26162	211.0233076661301	212.7693634033203	214.37573529051122	210.16524538059215	66213200	67.5343134063209	207.3907982962472	222.64261644353175
1	26163	214.2061287476001	213.61746215820312	215.25376527623442	211.8714063519454	49772700	70.01224520993905	208.78906903948103	222.25364670401532
1	26164	215.28368048569334	210.14527893066406	215.58300736088682	209.8260080950157	82542700	63.70531214974615	209.7675726754325	221.20700888900072
1	26165	211.61197396968475	216.261474609375	217.01975619065925	211.4423589537816	60402900	72.52619823770563	211.45162636893136	217.91905405801037
1	26166	215.66281990345283	219.77354431152344	219.88329699479613	214.61519864650157	58046200	65.64138056271375	212.38665771484375	219.62364229698096
1	26167	219.50414962607874	221.0506591796875	221.0506591796875	218.53633465750286	37369800	61.367264920749854	212.99100603376115	221.58663406623108
1	26168	221.15041758535088	225.82984924316406	225.93960192344272	221.15041758535088	60412400	64.78490976723396	213.8533423287528	224.8633219519048
1	26169	226.57816816685514	227.30653381347656	227.33646497984205	222.74682662809306	59085900	68.85607687176665	214.9458748953683	228.0119496497528
1	26170	227.41627168952732	228.16458129882812	228.8829597417087	225.85979013808537	48076100	66.0862362025886	215.80179813929968	230.6631893752381
1	26171	228.78319647541346	232.45489501953125	232.55467572482934	228.73330612276442	62627700	73.8089189446139	217.1337901524135	234.3768997328202
1	26172	230.86848076037649	227.05709838867188	231.86622690917008	225.26115227596378	64710600	72.33460185229735	218.4087687901088	235.76647201362957
1	26173	228.40404188598967	230.0203857421875	232.11565870158282	228.1645773343909	53046500	78.22676187961292	220.0514853341239	237.11779953409047
1	26174	235.94700263838575	233.87168884277344	236.69531224247876	232.5646438368613	62631300	79.81377934244586	221.92297145298548	238.8869720914011
1	26175	234.47032795283747	234.29074096679688	235.73746973269033	231.8063477557903	43234300	79.57727675475363	223.75811113630022	240.05870804822365
1	26176	228.9328431112231	228.3641357421875	230.93832254659503	226.12917896312734	57345900	67.25545740125486	224.87202344621932	240.02912303713052
1	26177	229.76098610155705	223.6747283935547	229.92062914212065	221.7690447852705	66034600	60.25639389751153	225.59039960588728	239.33746515447862
1	26178	224.31328836166992	223.80442810058594	226.28882140195597	222.77675082247163	49151500	64.94869290825241	226.56605311802454	237.17087395321693
1	26179	226.4983442399413	223.45523071289062	227.26661302541467	222.58718122432802	48201800	59.01026763428538	227.07989283970423	236.11484499125308
1	26180	223.86429647317826	224.5028533935547	226.42851135969482	222.1781030613285	39960300	56.31326710859943	227.4177006312779	235.58818178220952
1	26181	223.49514031921132	218.0474395751953	224.29334029380243	216.64062905712152	61777600	46.47787412979857	227.20318494524275	236.20878687654874
1	26182	218.4365585703147	216.99981689453125	220.35224458682225	214.13627507494223	51391200	38.650943229711096	226.57246834891183	237.1005441560238
1	26183	218.20707238174316	217.46875	218.99530033853074	215.52313289555326	41601300	37.01944197587138	225.86976950509208	237.44769375122036
1	26184	216.47100932714253	217.7481231689453	218.80573164190093	215.26372979848315	36311800	36.04276723490371	225.125736781529	237.3870187365668
1	26185	218.6959746261333	218.30685424804688	219.8334045947242	215.63288672795753	41643800	28.9363660650515	224.1151624407087	236.1034235693711
1	26186	220.94091084366266	221.5794677734375	223.3155515626994	220.13273889458495	50036300	41.29397852633376	223.7239031110491	235.6559724026078
1	26187	223.86429233538576	217.8678436279297	223.9740450176905	216.53086747941563	62501000	31.13381098775733	222.85586438860213	234.5811200249109
1	26188	218.65606496292435	219.36447143554688	225.09153987705304	217.2193232804361	105568600	25.701857734683074	221.81963457380022	231.78301196355818
1	26189	198.64127617987643	208.79833984375	213.0188017705649	195.55824424838744	119548600	18.134182544229944	219.99874877929688	229.44871027687492
1	26190	204.83729660703725	206.762939453125	209.51672869129231	200.6168344706096	69660500	20.088404327248142	218.455806187221	229.01127584013597
1	26191	206.43367474426563	209.34710693359375	213.15848935419993	205.9248296826355	63516400	28.931925646340403	217.43240465436662	228.57037363110712
1	26192	212.6296774525561	212.8292236328125	213.71721707569145	208.35932525259923	47161100	35.30981747330111	216.6484614780971	227.39246593252594
1	26193	211.62197118803232	215.7526397705078	216.29141600978787	211.4922593126285	42201600	40.354832681720204	216.09827641078405	226.10430292836895
1	26194	215.83255236617862	217.2909393310547	219.26875909808805	215.36306766380915	38028100	41.07888422632575	215.58313969203405	224.39680479040862
1	26195	218.76929897291208	221.02682495117188	221.646138683676	218.76929897291208	44155300	53.95134065548014	215.79595293317522	225.0011209322009
1	26196	220.3276035510778	221.47633361816406	222.7848915052682	219.45854930599305	41960600	56.0325814051903	216.11570412772042	225.7995558385698
1	26197	224.35317447515422	224.47303771972656	225.10235023777113	222.5151850202656	46414000	58.83696906436124	216.61601039341517	227.2755702120838
1	26198	223.67391069385005	225.80157470703125	226.5807162697698	223.40420315535758	44340200	59.89859673089423	217.1912569318499	228.92871036773485
1	26199	225.4719428035102	225.64175415039062	225.74165035068273	222.79488010428776	40687800	59.10469777403682	217.71517835344588	230.29194359064977
1	26200	225.52188562847152	226.2610626220703	226.92034094772856	225.20222998863	30299000	56.22096717747537	218.04957798549108	231.2998634287985
1	26201	226.2710625686077	226.15118408203125	227.7294495174454	224.80267685471037	34765500	62.17214557505555	218.64124516078405	232.57851917289292
1	26202	227.53966079897057	224.2832489013672	228.08905941841815	223.65393636981634	43695300	57.14998653653611	218.99258640834265	233.2526511718261
1	26203	225.41200238324527	226.5906982421875	227.96918649391685	224.0834622297127	38677300	84.03486732111	220.26346915108817	233.76084601441303
1	26204	226.5107917661563	226.93032836914062	227.03022456881217	223.64395069142014	30602200	91.25449317486894	221.70399693080358	233.1423046034973
1	26205	225.75162066501636	227.77938842773438	228.5984945445466	224.64283997153836	35934600	90.58623993893139	223.02058846609933	232.3876869167055
1	26206	227.6695099550691	226.2410888671875	229.6073802985885	225.4319662685897	38052200	82.29637294124217	223.97857883998327	231.3962811874093
1	26207	229.8471324488683	229.53746032714844	232.66402541964027	228.62847197635801	51906300	82.60875214948737	224.9632088797433	231.25079476292225
1	26208	229.93703146120657	228.7483367919922	230.14679214282077	227.23000295250677	52990800	78.09905726748276	225.7815944126674	230.5716979198839
1	26209	228.29882348382426	222.52517700195312	228.74832587928796	220.92692932694945	50190600	53.27511703517125	225.88861955915178	230.27066713482014
1	26210	221.4164072047842	220.6072998046875	221.53627045160738	217.24099295020864	43840200	48.215034540944856	225.82654571533203	230.49321097041556
1	26211	221.38642912323468	222.13560485839844	225.23218875186365	221.2765494057299	36615400	44.89080260419446	225.65958622523718	230.6880754883893
1	26212	223.7038813850335	220.57733154296875	224.99247224215048	219.5284824188554	48423000	38.69431294644744	225.2864259992327	230.99844331883014
1	26213	220.57732363843863	220.66722106933594	221.0268260349447	216.47183996524672	67180000	39.20202332681723	224.9311022077288	231.14477044618113
1	26214	218.67940838073807	219.86810302734375	221.23659254048482	216.49181271910507	51591000	36.23059899025685	224.47446223667689	231.18673165204618
1	26215	221.21662032032157	222.41529846191406	222.84481857216005	217.65053646391294	44587100	42.718051000857166	224.2076132638114	230.92977327275005
1	26216	222.25546946786713	222.52517700195312	223.30431855196207	219.57842214055833	37498200	46.321044924525495	224.0820366995675	230.86353330657985
1	26217	223.33429284055268	222.25547790527344	223.7937787761964	221.66612995902517	36766600	40.08225660402123	223.77237810407365	230.4556237182574
1	26218	216.302019591785	216.082275390625	216.98128020943747	213.6849038037586	59357400	30.411218434788736	222.99751717703683	230.5610543284509
1	26219	215.51289221314667	216.55174255371094	216.6616222741377	214.26426595466958	45519300	29.443970456687666	222.19554247174943	229.95342652363718
1	26220	217.31091546092293	220.4474639892578	222.46524827574677	217.30091669603667	59894900	40.235666250916154	221.7817121233259	229.22156822345772
1	26221	224.74274368478322	228.61846923828125	229.56743739121873	224.38313871157	66781300	48.66974505453146	221.7160699026925	228.87195041297437
1	26222	229.7172625160979	227.94920349121094	232.83382873595048	227.36983908638868	318679900	48.839213363807715	221.65898895263672	228.58219620280624
1	26223	227.09015412184934	226.2211151123047	229.19783588273827	225.56183678133013	54146000	56.17492524072106	221.92298453194755	229.25808659890058
1	26224	228.39870925768025	227.1201171875	229.09795215651428	225.48192014495527	43556100	61.264688401612645	222.38818577357702	230.1759767783562
1	26225	224.6827959331431	226.1212158203125	227.04020291666632	223.77380760174057	42308700	57.02218539681379	222.67287227085657	230.7083427701776
1	26226	227.05019905798116	227.26995849609375	228.24887720276465	225.16227678839184	36636700	61.96429000080742	223.15091705322266	231.4416178753673
1	26227	228.20893469195548	227.53965759277344	229.26776733886913	227.05020584581527	34026000	62.20725379613307	223.64180537632532	232.1109310116962
1	26228	229.78718847660608	232.7439422607422	232.7439422607422	229.39761768078608	54541900	69.77603143050122	224.56150817871094	234.00569092802522
\.


--
-- Data for Name: future_predictions; Type: TABLE DATA; Schema: finance_schema; Owner: cosc
--

COPY finance_schema.future_predictions (stock_id, date_id, predicted_trend, prediction_confidence) FROM stdin;
\.


--
-- Data for Name: moving_average_crossover; Type: TABLE DATA; Schema: finance_schema; Owner: cosc
--

COPY finance_schema.moving_average_crossover (crossover_id, stock_id, date_id, short_ma, long_ma, price, crossover_signal) FROM stdin;
27	1	214	5.57	4.24	5.85	BUY
28	1	992	18.09	18.16	16.10	SELL
29	1	1180	14.26	14.21	15.32	BUY
30	1	1676	27.16	27.21	25.55	SELL
31	1	1929	23.41	23.40	24.42	BUY
32	1	2511	45.94	46.05	35.99	SELL
33	1	2602	46.03	45.91	49.99	BUY
34	1	3379	156.81	156.96	143.43	SELL
35	1	3457	158.23	158.19	148.95	BUY
36	1	3466	156.75	156.90	138.40	SELL
37	1	3579	146.37	146.14	156.43	BUY
38	1	26091	182.73	182.79	172.38	SELL
39	1	26154	181.95	181.46	213.76	BUY
157	1	200	5.32	4.01	5.67	BUY
\.


--
-- Data for Name: portfolio_allocation; Type: TABLE DATA; Schema: finance_schema; Owner: cosc
--

COPY finance_schema.portfolio_allocation (portfolio_id, stock_id, trade_date, action, shares, capital, "position", portfolio_value) FROM stdin;
\.


--
-- Data for Name: portfolio_history; Type: TABLE DATA; Schema: finance_schema; Owner: cosc
--

COPY finance_schema.portfolio_history (id, stock_id, trade_date, action, shares, capital, "position", portfolio_value, stock_price) FROM stdin;
105	1	2009-11-05 00:00:00	BUY	1710	4.226813316345215	1710	10000.0	5.8454813957214355
106	1	2012-12-10 00:00:00	SELL	0	27541.163516044617	0	27541.163516044617	16.103471755981445
107	1	2013-09-10 00:00:00	BUY	1797	6.781414985656738	1797	27541.163516044617	15.322416305541992
108	1	2015-08-28 00:00:00	SELL	0	45919.29373264313	0	45919.29373264313	25.54953384399414
109	1	2016-08-30 00:00:00	BUY	1880	16.10861301422119	1880	45919.29373264313	24.416587829589844
110	1	2018-12-21 00:00:00	SELL	0	67680.58920383453	0	67680.58920383453	35.99174499511719
111	1	2019-05-06 00:00:00	BUY	1353	37.386616706848145	1353	67680.58920383453	49.99497604370117
112	1	2022-06-03 00:00:00	SELL	0	194097.69186878204	0	194097.69186878204	143.4296417236328
113	1	2022-09-26 00:00:00	BUY	1303	10.736119270324707	1303	194097.69186878204	148.95391845703125
114	1	2022-10-07 00:00:00	SELL	0	180349.28825855255	0	180349.28825855255	138.40257263183594
115	1	2023-03-22 00:00:00	BUY	1152	146.50700855255127	1152	180349.28825855255	156.426025390625
116	1	2024-03-14 00:00:00	SELL	0	198723.96599292755	0	198723.96599292755	172.3762664794922
117	1	2024-06-13 00:00:00	BUY	929	143.58189868927002	929	198723.96599292755	213.75714111328125
\.


--
-- Data for Name: prediction_trend; Type: TABLE DATA; Schema: finance_schema; Owner: cosc
--

COPY finance_schema.prediction_trend (trend_id, stock_id, date_id, closing_price, sma, rsi, trend_direction, signal, trend_description) FROM stdin;
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
-- Name: backtesting_results_backtest_id_seq; Type: SEQUENCE SET; Schema: finance_schema; Owner: cosc
--

SELECT pg_catalog.setval('finance_schema.backtesting_results_backtest_id_seq', 24, true);


--
-- Name: date_dimension_date_id_seq; Type: SEQUENCE SET; Schema: finance_schema; Owner: cosc
--

SELECT pg_catalog.setval('finance_schema.date_dimension_date_id_seq', 53962, true);


--
-- Name: exchange_dimension_exchange_id_seq; Type: SEQUENCE SET; Schema: finance_schema; Owner: cosc
--

SELECT pg_catalog.setval('finance_schema.exchange_dimension_exchange_id_seq', 14, true);


--
-- Name: moving_average_crossover_crossover_id_seq; Type: SEQUENCE SET; Schema: finance_schema; Owner: cosc
--

SELECT pg_catalog.setval('finance_schema.moving_average_crossover_crossover_id_seq', 169, true);


--
-- Name: portfolio_allocation_portfolio_id_seq; Type: SEQUENCE SET; Schema: finance_schema; Owner: cosc
--

SELECT pg_catalog.setval('finance_schema.portfolio_allocation_portfolio_id_seq', 1, false);


--
-- Name: portfolio_history_id_seq; Type: SEQUENCE SET; Schema: finance_schema; Owner: cosc
--

SELECT pg_catalog.setval('finance_schema.portfolio_history_id_seq', 195, true);


--
-- Name: prediction_trend_trend_id_seq; Type: SEQUENCE SET; Schema: finance_schema; Owner: cosc
--

SELECT pg_catalog.setval('finance_schema.prediction_trend_trend_id_seq', 1, false);


--
-- Name: sector_dimension_sector_id_seq; Type: SEQUENCE SET; Schema: finance_schema; Owner: cosc
--

SELECT pg_catalog.setval('finance_schema.sector_dimension_sector_id_seq', 14, true);


--
-- Name: stock_dimension_stock_id_seq; Type: SEQUENCE SET; Schema: finance_schema; Owner: cosc
--

SELECT pg_catalog.setval('finance_schema.stock_dimension_stock_id_seq', 14, true);


--
-- Name: backtesting_results backtesting_results_pkey; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.backtesting_results
    ADD CONSTRAINT backtesting_results_pkey PRIMARY KEY (backtest_id);


--
-- Name: backtesting_results backtesting_results_stock_id_start_date_end_date_key; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.backtesting_results
    ADD CONSTRAINT backtesting_results_stock_id_start_date_end_date_key UNIQUE (stock_id, start_date, end_date);


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
    ADD CONSTRAINT fact_stock_data_pkey PRIMARY KEY (stock_id, date_id);


--
-- Name: future_predictions future_predictions_pkey; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.future_predictions
    ADD CONSTRAINT future_predictions_pkey PRIMARY KEY (stock_id, date_id);


--
-- Name: moving_average_crossover moving_average_crossover_pkey; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.moving_average_crossover
    ADD CONSTRAINT moving_average_crossover_pkey PRIMARY KEY (crossover_id);


--
-- Name: moving_average_crossover moving_average_crossover_stock_id_date_id_key; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.moving_average_crossover
    ADD CONSTRAINT moving_average_crossover_stock_id_date_id_key UNIQUE (stock_id, date_id);


--
-- Name: portfolio_allocation portfolio_allocation_pkey; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.portfolio_allocation
    ADD CONSTRAINT portfolio_allocation_pkey PRIMARY KEY (portfolio_id);


--
-- Name: portfolio_history portfolio_history_pkey; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.portfolio_history
    ADD CONSTRAINT portfolio_history_pkey PRIMARY KEY (id);


--
-- Name: prediction_trend prediction_trend_pkey; Type: CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.prediction_trend
    ADD CONSTRAINT prediction_trend_pkey PRIMARY KEY (trend_id);


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
-- Name: backtesting_results backtesting_results_stock_id_fkey; Type: FK CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.backtesting_results
    ADD CONSTRAINT backtesting_results_stock_id_fkey FOREIGN KEY (stock_id) REFERENCES finance_schema.stock_dimension(stock_id);


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
-- Name: future_predictions future_predictions_date_id_fkey; Type: FK CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.future_predictions
    ADD CONSTRAINT future_predictions_date_id_fkey FOREIGN KEY (date_id) REFERENCES finance_schema.date_dimension(date_id);


--
-- Name: future_predictions future_predictions_stock_id_fkey; Type: FK CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.future_predictions
    ADD CONSTRAINT future_predictions_stock_id_fkey FOREIGN KEY (stock_id) REFERENCES finance_schema.stock_dimension(stock_id);


--
-- Name: moving_average_crossover moving_average_crossover_date_id_fkey; Type: FK CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.moving_average_crossover
    ADD CONSTRAINT moving_average_crossover_date_id_fkey FOREIGN KEY (date_id) REFERENCES finance_schema.date_dimension(date_id);


--
-- Name: moving_average_crossover moving_average_crossover_stock_id_fkey; Type: FK CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.moving_average_crossover
    ADD CONSTRAINT moving_average_crossover_stock_id_fkey FOREIGN KEY (stock_id) REFERENCES finance_schema.stock_dimension(stock_id);


--
-- Name: portfolio_allocation portfolio_allocation_stock_id_fkey; Type: FK CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.portfolio_allocation
    ADD CONSTRAINT portfolio_allocation_stock_id_fkey FOREIGN KEY (stock_id) REFERENCES finance_schema.stock_dimension(stock_id);


--
-- Name: portfolio_allocation portfolio_allocation_stock_id_fkey1; Type: FK CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.portfolio_allocation
    ADD CONSTRAINT portfolio_allocation_stock_id_fkey1 FOREIGN KEY (stock_id) REFERENCES finance_schema.stock_dimension(stock_id);


--
-- Name: portfolio_history portfolio_history_stock_id_fkey; Type: FK CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.portfolio_history
    ADD CONSTRAINT portfolio_history_stock_id_fkey FOREIGN KEY (stock_id) REFERENCES finance_schema.stock_dimension(stock_id);


--
-- Name: prediction_trend prediction_trend_date_id_fkey; Type: FK CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.prediction_trend
    ADD CONSTRAINT prediction_trend_date_id_fkey FOREIGN KEY (date_id) REFERENCES finance_schema.date_dimension(date_id);


--
-- Name: prediction_trend prediction_trend_stock_id_fkey; Type: FK CONSTRAINT; Schema: finance_schema; Owner: cosc
--

ALTER TABLE ONLY finance_schema.prediction_trend
    ADD CONSTRAINT prediction_trend_stock_id_fkey FOREIGN KEY (stock_id) REFERENCES finance_schema.stock_dimension(stock_id);


--
-- PostgreSQL database dump complete
--

