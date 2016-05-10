--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: authors; Type: TABLE; Schema: public; Owner: jwo; Tablespace: 
--

CREATE TABLE authors (
    id integer NOT NULL,
    first_name character varying,
    last_name character varying,
    bio text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE authors OWNER TO jwo;

--
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: jwo
--

CREATE SEQUENCE authors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE authors_id_seq OWNER TO jwo;

--
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jwo
--

ALTER SEQUENCE authors_id_seq OWNED BY authors.id;


--
-- Name: books; Type: TABLE; Schema: public; Owner: jwo; Tablespace: 
--

CREATE TABLE books (
    id integer NOT NULL,
    title character varying,
    photo_url character varying,
    price integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    author_id integer,
    inventory integer,
    shipping_cost numeric
);


ALTER TABLE books OWNER TO jwo;

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: jwo
--

CREATE SEQUENCE books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE books_id_seq OWNER TO jwo;

--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jwo
--

ALTER SEQUENCE books_id_seq OWNED BY books.id;


--
-- Name: orderitems; Type: TABLE; Schema: public; Owner: jwo; Tablespace: 
--

CREATE TABLE orderitems (
    id integer NOT NULL,
    order_id integer,
    book_id integer,
    shipped boolean DEFAULT false,
    quantity integer DEFAULT 0,
    shipping_cost numeric DEFAULT 0.0,
    price numeric DEFAULT 0.0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE orderitems OWNER TO jwo;

--
-- Name: orderitems_id_seq; Type: SEQUENCE; Schema: public; Owner: jwo
--

CREATE SEQUENCE orderitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orderitems_id_seq OWNER TO jwo;

--
-- Name: orderitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jwo
--

ALTER SEQUENCE orderitems_id_seq OWNED BY orderitems.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: jwo; Tablespace: 
--

CREATE TABLE orders (
    id integer NOT NULL,
    user_id integer,
    purchased_at timestamp without time zone,
    status character varying DEFAULT 'cart'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE orders OWNER TO jwo;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: jwo
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_id_seq OWNER TO jwo;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jwo
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: jwo; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO jwo;

--
-- Name: users; Type: TABLE; Schema: public; Owner: jwo; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying,
    email character varying,
    password_digest character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE users OWNER TO jwo;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: jwo
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO jwo;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jwo
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jwo
--

ALTER TABLE ONLY authors ALTER COLUMN id SET DEFAULT nextval('authors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jwo
--

ALTER TABLE ONLY books ALTER COLUMN id SET DEFAULT nextval('books_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jwo
--

ALTER TABLE ONLY orderitems ALTER COLUMN id SET DEFAULT nextval('orderitems_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jwo
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jwo
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: jwo
--

COPY authors (id, first_name, last_name, bio, created_at, updated_at) FROM stdin;
1	Frank	Miller	Frank Miller (born January 27, 1957)[1] is an American writer, artist, and film director best known for his dark comic book stories and graphic novels such as Ronin, Daredevil: Born Again, The Dark Knight Returns, Sin City and 300. He also directed the film version of The Spirit, shared directing duties with Robert Rodriguez on Sin City and Sin City: A Dame to Kill For, and produced the film 300. His film Sin City earned a Palme d'Or nomination, and he has received every major comic book industry award. In 2015, Miller was inducted into the Eisner Awards Comic Book Hall of Fame.He created the comic book characters Elektra for Marvel Comics' Daredevil series, and the future version of the Robin character, Carrie Kelly, for DC Comics.	2016-04-04 12:56:19.544311	2016-04-04 12:56:19.544311
2	Alan	Moore	Alan Moore (born 18 November 1953) is an English writer primarily known for his work in comic books including Watchmen, V for Vendetta, and From Hell.[1] Frequently described as the best graphic novel writer in history,[2][3] he has been called one of the most important British writers of the last fifty years.[4] He has occasionally used such pseudonyms as Curt Vile, Jill de Ray, Translucia Baboon and The Original Writer.	2016-04-04 12:56:19.553666	2016-04-04 12:56:19.553666
\.


--
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jwo
--

SELECT pg_catalog.setval('authors_id_seq', 2, true);


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: jwo
--

COPY books (id, title, photo_url, price, created_at, updated_at, author_id, inventory, shipping_cost) FROM stdin;
1	Batman No.1	http://5625-presscdn-22-81.pagely.netdna-cdn.com/wp-content/uploads/2011/01/expensive-batman-comics-batman-11.jpg	20000	2016-04-04 12:56:19.594998	2016-04-04 12:56:19.594998	1	\N	\N
2	Kingdom Come	http://vignette3.wikia.nocookie.net/marvel_dc/images/6/6e/Kingdom_Come_1.jpg/revision/latest?cb=20080321202106	10000	2016-04-04 12:56:19.604852	2016-04-04 12:56:19.604852	1	\N	\N
3	The Dark Knight Returns	https://nicfoley.files.wordpress.com/2014/05/1.jpg	0	2016-04-04 12:56:19.614786	2016-04-04 12:56:19.614786	2	\N	\N
\.


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jwo
--

SELECT pg_catalog.setval('books_id_seq', 3, true);


--
-- Data for Name: orderitems; Type: TABLE DATA; Schema: public; Owner: jwo
--

COPY orderitems (id, order_id, book_id, shipped, quantity, shipping_cost, price, created_at, updated_at) FROM stdin;
1	1	1	f	1	0.0	20000.0	2016-04-04 12:58:20.193497	2016-04-04 12:58:20.193497
\.


--
-- Name: orderitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jwo
--

SELECT pg_catalog.setval('orderitems_id_seq', 1, true);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: jwo
--

COPY orders (id, user_id, purchased_at, status, created_at, updated_at) FROM stdin;
1	1	2016-04-04 12:58:20.17198	pending	2016-04-04 12:58:20.172802	2016-04-04 12:58:24.226209
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jwo
--

SELECT pg_catalog.setval('orders_id_seq', 1, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: jwo
--

COPY schema_migrations (version) FROM stdin;
20160305042331
20160303143909
20160303214816
20160310041036
20160331004454
20160307223758
20160307224025
20160308215341
20160331000305
20160331000642
20160331000824
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: jwo
--

COPY users (id, username, email, password_digest, created_at, updated_at) FROM stdin;
1	\N	jesse@theironyard.com	$2a$10$lTS2N4N3W0oQQh5Z6JuWfuXKUJfZAvb.SW5dgPWFFkmFvDHXZEzkC	2016-04-04 12:58:14.955865	2016-04-04 12:58:14.955865
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jwo
--

SELECT pg_catalog.setval('users_id_seq', 1, true);


--
-- Name: authors_pkey; Type: CONSTRAINT; Schema: public; Owner: jwo; Tablespace: 
--

ALTER TABLE ONLY authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: books_pkey; Type: CONSTRAINT; Schema: public; Owner: jwo; Tablespace: 
--

ALTER TABLE ONLY books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: orderitems_pkey; Type: CONSTRAINT; Schema: public; Owner: jwo; Tablespace: 
--

ALTER TABLE ONLY orderitems
    ADD CONSTRAINT orderitems_pkey PRIMARY KEY (id);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: jwo; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: jwo; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: jwo; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: jwo
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM jwo;
GRANT ALL ON SCHEMA public TO jwo;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

