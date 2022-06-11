--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

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
-- Name: t_budgets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_budgets (
    s_id integer NOT NULL,
    a_shop_id integer NOT NULL,
    a_month date NOT NULL,
    a_budget_amount numeric(10,2) NOT NULL,
    a_amount_spent numeric(10,2) NOT NULL,
    a_notification_id integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.t_budgets OWNER TO postgres;

--
-- Name: t_budgets_s_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_budgets_s_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.t_budgets_s_id_seq OWNER TO postgres;

--
-- Name: t_budgets_s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t_budgets_s_id_seq OWNED BY public.t_budgets.s_id;


--
-- Name: t_shops; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_shops (
    a_id integer NOT NULL,
    a_name character varying(255) NOT NULL,
    a_online boolean NOT NULL
);


ALTER TABLE public.t_shops OWNER TO postgres;

--
-- Name: t_shops_a_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_shops_a_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.t_shops_a_id_seq OWNER TO postgres;

--
-- Name: t_shops_a_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t_shops_a_id_seq OWNED BY public.t_shops.a_id;


--
-- Name: t_shops_notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_shops_notifications (
    n_id integer NOT NULL,
    n_percentage integer NOT NULL
);


ALTER TABLE public.t_shops_notifications OWNER TO postgres;

--
-- Name: t_shops_notifications_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_shops_notifications_audit (
    audit_id integer NOT NULL,
    shop_id integer NOT NULL,
    notification_id integer NOT NULL,
    percentage_used double precision NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.t_shops_notifications_audit OWNER TO postgres;

--
-- Name: t_shops_notifications_audit_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_shops_notifications_audit_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.t_shops_notifications_audit_audit_id_seq OWNER TO postgres;

--
-- Name: t_shops_notifications_audit_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t_shops_notifications_audit_audit_id_seq OWNED BY public.t_shops_notifications_audit.audit_id;


--
-- Name: t_shops_notifications_n_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_shops_notifications_n_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.t_shops_notifications_n_id_seq OWNER TO postgres;

--
-- Name: t_shops_notifications_n_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t_shops_notifications_n_id_seq OWNED BY public.t_shops_notifications.n_id;


--
-- Name: t_budgets s_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_budgets ALTER COLUMN s_id SET DEFAULT nextval('public.t_budgets_s_id_seq'::regclass);


--
-- Name: t_shops a_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_shops ALTER COLUMN a_id SET DEFAULT nextval('public.t_shops_a_id_seq'::regclass);


--
-- Name: t_shops_notifications n_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_shops_notifications ALTER COLUMN n_id SET DEFAULT nextval('public.t_shops_notifications_n_id_seq'::regclass);


--
-- Name: t_shops_notifications_audit audit_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_shops_notifications_audit ALTER COLUMN audit_id SET DEFAULT nextval('public.t_shops_notifications_audit_audit_id_seq'::regclass);


--
-- Data for Name: t_budgets; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.t_budgets VALUES (2, 2, '2020-06-01', 990.00, 886.63, 1);
INSERT INTO public.t_budgets VALUES (4, 4, '2020-06-01', 740.00, 746.92, 1);
INSERT INTO public.t_budgets VALUES (6, 6, '2020-06-01', 640.00, 946.32, 1);
INSERT INTO public.t_budgets VALUES (9, 1, '2020-07-01', 960.00, 803.67, 1);
INSERT INTO public.t_budgets VALUES (10, 2, '2020-07-01', 670.00, 715.64, 1);
INSERT INTO public.t_budgets VALUES (11, 3, '2020-07-01', 890.00, 580.81, 1);
INSERT INTO public.t_budgets VALUES (12, 4, '2020-07-01', 590.00, 754.93, 1);
INSERT INTO public.t_budgets VALUES (13, 5, '2020-07-01', 870.00, 505.12, 1);
INSERT INTO public.t_budgets VALUES (14, 6, '2020-07-01', 700.00, 912.30, 1);
INSERT INTO public.t_budgets VALUES (15, 7, '2020-07-01', 990.00, 805.15, 1);
INSERT INTO public.t_budgets VALUES (16, 8, '2020-07-01', 720.00, 504.25, 1);
INSERT INTO public.t_budgets VALUES (1, 1, '2020-06-01', 930.00, 725.67, 1);
INSERT INTO public.t_budgets VALUES (5, 5, '2020-06-01', 630.00, 507.64, 1);
INSERT INTO public.t_budgets VALUES (7, 7, '2020-06-01', 980.00, 640.16, 1);
INSERT INTO public.t_budgets VALUES (3, 3, '2020-06-01', 650.00, 685.91, 1);
INSERT INTO public.t_budgets VALUES (8, 8, '2020-06-01', 790.00, 965.64, 1);


--
-- Data for Name: t_shops; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.t_shops VALUES (2, 'Fashion Quasar', false);
INSERT INTO public.t_shops VALUES (4, 'H&R', false);
INSERT INTO public.t_shops VALUES (5, 'Meow Meow', true);
INSERT INTO public.t_shops VALUES (6, 'Dole & Cabbage', false);
INSERT INTO public.t_shops VALUES (7, 'George Manly', true);
INSERT INTO public.t_shops VALUES (1, 'Steve McQueen', true);
INSERT INTO public.t_shops VALUES (3, 'As Seen On Sale', true);
INSERT INTO public.t_shops VALUES (8, 'Harrison Ford', true);


--
-- Data for Name: t_shops_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.t_shops_notifications VALUES (1, 0);
INSERT INTO public.t_shops_notifications VALUES (2, 50);
INSERT INTO public.t_shops_notifications VALUES (3, 100);


--
-- Data for Name: t_shops_notifications_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: t_budgets_s_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_budgets_s_id_seq', 16, true);


--
-- Name: t_shops_a_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_shops_a_id_seq', 8, true);


--
-- Name: t_shops_notifications_audit_audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_shops_notifications_audit_audit_id_seq', 94, true);


--
-- Name: t_shops_notifications_n_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_shops_notifications_n_id_seq', 3, true);


--
-- Name: t_budgets t_budgets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_budgets
    ADD CONSTRAINT t_budgets_pkey PRIMARY KEY (s_id);


--
-- Name: t_shops_notifications_audit t_shops_notifications_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_shops_notifications_audit
    ADD CONSTRAINT t_shops_notifications_audit_pkey PRIMARY KEY (audit_id);


--
-- Name: t_shops_notifications t_shops_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_shops_notifications
    ADD CONSTRAINT t_shops_notifications_pkey PRIMARY KEY (n_id);


--
-- Name: t_shops t_shops_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_shops
    ADD CONSTRAINT t_shops_pkey PRIMARY KEY (a_id);


--
-- Name: t_budgets t_budgets_a_notification_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_budgets
    ADD CONSTRAINT t_budgets_a_notification_id_fkey FOREIGN KEY (a_notification_id) REFERENCES public.t_shops_notifications(n_id);


--
-- Name: t_shops_notifications_audit t_budgets_a_notification_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_shops_notifications_audit
    ADD CONSTRAINT t_budgets_a_notification_id_fkey FOREIGN KEY (notification_id) REFERENCES public.t_shops_notifications(n_id);


--
-- Name: t_budgets t_shops_a_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_budgets
    ADD CONSTRAINT t_shops_a_id_fkey FOREIGN KEY (a_shop_id) REFERENCES public.t_shops(a_id);


--
-- PostgreSQL database dump complete
--

