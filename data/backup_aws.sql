--
-- PostgreSQL database dump
--

\restrict vpcRnN97vADewl96TOaRuWELYSCPXzC5qMOl9rrkvsh3XW2ahyeS8MQTmN06Gpb

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

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

ALTER TABLE IF EXISTS ONLY public.volume_itens DROP CONSTRAINT IF EXISTS volume_itens_volume_id_2db69dbe_fk_pedido_volumes_id;
ALTER TABLE IF EXISTS ONLY public.volume_itens DROP CONSTRAINT IF EXISTS volume_itens_item_id_62e88330_fk_pedido_itens_id;
ALTER TABLE IF EXISTS ONLY public.pedido_volumes DROP CONSTRAINT IF EXISTS pedido_volumes_pedido_id_737bc5e9_fk_pedidos_id;
ALTER TABLE IF EXISTS ONLY public.pedido_itens DROP CONSTRAINT IF EXISTS pedido_itens_pedido_id_762d01a1_fk_pedidos_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_user_id_c564eba6_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_user_id_6a12ed8b_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_group_id_97559544_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
DROP INDEX IF EXISTS public.volume_itens_volume_id_2db69dbe;
DROP INDEX IF EXISTS public.volume_itens_item_id_62e88330;
DROP INDEX IF EXISTS public.pedido_volumes_pedido_id_737bc5e9;
DROP INDEX IF EXISTS public.pedido_itens_pedido_id_762d01a1;
DROP INDEX IF EXISTS public.django_session_session_key_c0390e0f_like;
DROP INDEX IF EXISTS public.django_session_expire_date_a5c62663;
DROP INDEX IF EXISTS public.django_admin_log_user_id_c564eba6;
DROP INDEX IF EXISTS public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX IF EXISTS public.auth_user_username_6821ab7c_like;
DROP INDEX IF EXISTS public.auth_user_user_permissions_user_id_a95ead1b;
DROP INDEX IF EXISTS public.auth_user_user_permissions_permission_id_1fbb5f2c;
DROP INDEX IF EXISTS public.auth_user_groups_user_id_6a12ed8b;
DROP INDEX IF EXISTS public.auth_user_groups_group_id_97559544;
DROP INDEX IF EXISTS public.auth_permission_content_type_id_2f476e4b;
DROP INDEX IF EXISTS public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX IF EXISTS public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX IF EXISTS public.auth_group_name_a6ea08ec_like;
ALTER TABLE IF EXISTS ONLY public.volume_itens DROP CONSTRAINT IF EXISTS volume_itens_volume_id_item_id_23236534_uniq;
ALTER TABLE IF EXISTS ONLY public.volume_itens DROP CONSTRAINT IF EXISTS volume_itens_pkey;
ALTER TABLE IF EXISTS ONLY public.pedidos DROP CONSTRAINT IF EXISTS pedidos_pkey;
ALTER TABLE IF EXISTS ONLY public.pedidos DROP CONSTRAINT IF EXISTS pedidos_picking_numero_pedido_5cf03bdf_uniq;
ALTER TABLE IF EXISTS ONLY public.pedido_volumes DROP CONSTRAINT IF EXISTS pedido_volumes_pkey;
ALTER TABLE IF EXISTS ONLY public.pedido_volumes DROP CONSTRAINT IF EXISTS pedido_volumes_pedido_id_volume_num_e4668409_uniq;
ALTER TABLE IF EXISTS ONLY public.pedido_itens DROP CONSTRAINT IF EXISTS pedido_itens_pkey;
ALTER TABLE IF EXISTS ONLY public.pedido_itens DROP CONSTRAINT IF EXISTS pedido_itens_pedido_id_codigo_produto_1c5293b0_uniq;
ALTER TABLE IF EXISTS ONLY public.import_batches DROP CONSTRAINT IF EXISTS import_batches_pkey;
ALTER TABLE IF EXISTS ONLY public.django_session DROP CONSTRAINT IF EXISTS django_session_pkey;
ALTER TABLE IF EXISTS ONLY public.django_migrations DROP CONSTRAINT IF EXISTS django_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user DROP CONSTRAINT IF EXISTS auth_user_username_key;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user DROP CONSTRAINT IF EXISTS auth_user_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_user_id_group_id_94350c0c_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_name_key;
DROP TABLE IF EXISTS public.volume_itens;
DROP TABLE IF EXISTS public.pedidos;
DROP TABLE IF EXISTS public.pedido_volumes;
DROP TABLE IF EXISTS public.pedido_itens;
DROP TABLE IF EXISTS public.import_batches;
DROP TABLE IF EXISTS public.django_session;
DROP TABLE IF EXISTS public.django_migrations;
DROP TABLE IF EXISTS public.django_content_type;
DROP TABLE IF EXISTS public.django_admin_log;
DROP TABLE IF EXISTS public.auth_user_user_permissions;
DROP TABLE IF EXISTS public.auth_user_groups;
DROP TABLE IF EXISTS public.auth_user;
DROP TABLE IF EXISTS public.auth_permission;
DROP TABLE IF EXISTS public.auth_group_permissions;
DROP TABLE IF EXISTS public.auth_group;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: import_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.import_batches (
    id bigint NOT NULL,
    total_files integer NOT NULL,
    processed_files integer NOT NULL,
    status character varying(20) NOT NULL,
    errors text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.import_batches OWNER TO postgres;

--
-- Name: import_batches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.import_batches ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.import_batches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pedido_itens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido_itens (
    id bigint NOT NULL,
    codigo_produto character varying(50),
    descricao text,
    quantidade numeric(18,3) NOT NULL,
    unidade character varying(20),
    linha_origem integer,
    pedido_id bigint NOT NULL
);


ALTER TABLE public.pedido_itens OWNER TO postgres;

--
-- Name: pedido_itens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.pedido_itens ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.pedido_itens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pedido_volumes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido_volumes (
    id bigint NOT NULL,
    volume_num integer NOT NULL,
    total_volumes integer NOT NULL,
    criado_em timestamp with time zone NOT NULL,
    pedido_id bigint NOT NULL
);


ALTER TABLE public.pedido_volumes OWNER TO postgres;

--
-- Name: pedido_volumes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.pedido_volumes ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.pedido_volumes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pedidos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedidos (
    id bigint NOT NULL,
    picking character varying(20) NOT NULL,
    numero_pedido character varying(30) NOT NULL,
    rota character varying(50),
    cliente_nome text,
    endereco_logradouro text,
    endereco_numero text,
    endereco_bairro text,
    endereco_cidade text,
    endereco_uf character varying(2),
    endereco_cep character varying(15),
    criado_em timestamp with time zone NOT NULL,
    cpf_cnpj character varying(20),
    cliente_codigo character varying(30)
);


ALTER TABLE public.pedidos OWNER TO postgres;

--
-- Name: pedidos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.pedidos ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.pedidos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: volume_itens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.volume_itens (
    id bigint NOT NULL,
    quantidade numeric(18,3) NOT NULL,
    item_id bigint NOT NULL,
    volume_id bigint NOT NULL
);


ALTER TABLE public.volume_itens OWNER TO postgres;

--
-- Name: volume_itens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.volume_itens ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.volume_itens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	3	add_permission
6	Can change permission	3	change_permission
7	Can delete permission	3	delete_permission
8	Can view permission	3	view_permission
9	Can add group	2	add_group
10	Can change group	2	change_group
11	Can delete group	2	delete_group
12	Can view group	2	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add pedido	7	add_pedido
26	Can change pedido	7	change_pedido
27	Can delete pedido	7	delete_pedido
28	Can view pedido	7	view_pedido
29	Can add pedido item	8	add_pedidoitem
30	Can change pedido item	8	change_pedidoitem
31	Can delete pedido item	8	delete_pedidoitem
32	Can view pedido item	8	view_pedidoitem
33	Can add pedido volume	9	add_pedidovolume
34	Can change pedido volume	9	change_pedidovolume
35	Can delete pedido volume	9	delete_pedidovolume
36	Can view pedido volume	9	view_pedidovolume
37	Can add volume item	10	add_volumeitem
38	Can change volume item	10	change_volumeitem
39	Can delete volume item	10	delete_volumeitem
40	Can view volume item	10	view_volumeitem
41	Can add import batch	11	add_importbatch
42	Can change import batch	11	change_importbatch
43	Can delete import batch	11	delete_importbatch
44	Can view import batch	11	view_importbatch
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$1200000$svAzac3QJbGvDn710sYjgF$Iqjk2elR/3n11MSl/BMB9kd6yfMzhwnHh1uV/AaqC9s=	\N	t	superuser			gustavo.neves@avancefarma.com.br	t	t	2026-03-04 22:31:36.839459+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	group
3	auth	permission
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	ticket_printer	pedido
8	ticket_printer	pedidoitem
9	ticket_printer	pedidovolume
10	ticket_printer	volumeitem
11	ticket_printer	importbatch
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-03-04 22:22:05.203189+00
2	auth	0001_initial	2026-03-04 22:22:05.329371+00
3	admin	0001_initial	2026-03-04 22:22:05.362209+00
4	admin	0002_logentry_remove_auto_add	2026-03-04 22:22:05.370367+00
5	admin	0003_logentry_add_action_flag_choices	2026-03-04 22:22:05.383995+00
6	contenttypes	0002_remove_content_type_name	2026-03-04 22:22:05.400306+00
7	auth	0002_alter_permission_name_max_length	2026-03-04 22:22:05.408464+00
8	auth	0003_alter_user_email_max_length	2026-03-04 22:22:05.416987+00
9	auth	0004_alter_user_username_opts	2026-03-04 22:22:05.424422+00
10	auth	0005_alter_user_last_login_null	2026-03-04 22:22:05.433207+00
11	auth	0006_require_contenttypes_0002	2026-03-04 22:22:05.435306+00
12	auth	0007_alter_validators_add_error_messages	2026-03-04 22:22:05.442688+00
13	auth	0008_alter_user_username_max_length	2026-03-04 22:22:05.458009+00
14	auth	0009_alter_user_last_name_max_length	2026-03-04 22:22:05.466824+00
15	auth	0010_alter_group_name_max_length	2026-03-04 22:22:05.477508+00
16	auth	0011_update_proxy_permissions	2026-03-04 22:22:05.485434+00
17	auth	0012_alter_user_first_name_max_length	2026-03-04 22:22:05.493822+00
18	sessions	0001_initial	2026-03-04 22:22:05.517105+00
19	ticket_printer	0001_initial	2026-03-04 22:22:05.659869+00
20	ticket_printer	0002_seed_data	2026-03-04 22:22:05.686895+00
21	ticket_printer	0003_pedido_cliente_cnpj	2026-03-04 22:22:05.751289+00
22	ticket_printer	0004_pedido_cliente_codigo	2026-03-04 22:22:05.806766+00
23	ticket_printer	0005_remove_pedido_pedidos_picking_numero_pedido_key_and_more	2026-03-04 22:30:48.43881+00
24	ticket_printer	0005_importbatch_and_more	2026-03-05 15:04:03.483892+00
25	ticket_printer	0006_remove_pedido_pedidos_picking_numero_pedido_key_and_more	2026-03-05 15:17:32.287851+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: import_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.import_batches (id, total_files, processed_files, status, errors, created_at) FROM stdin;
3	1	1	completed	\N	2026-03-05 18:17:44.401406+00
4	1	1	completed	\N	2026-03-05 18:33:02.696381+00
19	1	1	completed	\N	2026-03-06 15:27:44.791508+00
5	1	1	completed	\N	2026-03-05 18:53:36.502876+00
6	1	1	completed	\N	2026-03-05 19:38:08.594444+00
7	1	1	completed	\N	2026-03-05 20:08:12.584797+00
20	1	1	completed	\N	2026-03-06 15:31:32.491789+00
8	1	1	completed	\N	2026-03-05 20:12:38.090906+00
9	1	1	completed	\N	2026-03-05 20:20:05.402702+00
10	1	1	completed	\N	2026-03-05 20:35:46.362806+00
21	1	1	completed	\N	2026-03-06 17:15:25.834009+00
11	1	1	completed	\N	2026-03-05 20:42:19.064822+00
12	1	1	completed	\N	2026-03-05 20:42:53.083024+00
35	2	2	completed	\N	2026-03-10 14:32:47.146578+00
13	1	1	completed	\N	2026-03-05 20:44:45.840574+00
22	1	1	completed	\N	2026-03-06 20:25:18.851577+00
14	1	1	completed	\N	2026-03-05 20:48:29.511178+00
15	1	1	completed	\N	2026-03-05 20:56:54.00487+00
16	1	1	completed	\N	2026-03-05 21:01:25.950644+00
23	1	1	completed	\N	2026-03-06 20:27:55.172385+00
17	1	1	completed	\N	2026-03-05 21:11:09.465177+00
45	1	1	completed	\N	2026-03-12 15:13:28.336361+00
24	1	1	completed	\N	2026-03-06 20:31:39.636543+00
25	1	1	completed	\N	2026-03-06 20:39:07.482586+00
26	1	1	completed	\N	2026-03-06 20:41:00.38496+00
27	1	1	completed	\N	2026-03-06 20:44:54.149446+00
28	1	1	completed	\N	2026-03-06 20:47:26.394229+00
29	1	1	completed	\N	2026-03-06 21:01:20.648873+00
30	1	1	completed	\N	2026-03-06 21:05:25.361346+00
31	1	1	completed	\N	2026-03-06 21:11:50.283961+00
18	26	26	completed	\N	2026-03-06 14:23:54.142643+00
32	1	1	completed	\N	2026-03-06 21:18:19.712304+00
36	17	17	completed	\N	2026-03-10 15:11:19.916452+00
1	88	88	completed	\N	2026-03-05 15:17:56.798561+00
33	14	14	completed	\N	2026-03-09 12:35:55.610783+00
43	36	36	completed	\N	2026-03-11 20:01:36.401344+00
2	4	4	completed	\N	2026-03-05 15:18:25.817968+00
37	5	5	completed	\N	2026-03-11 13:44:24.227299+00
47	52	52	completed	\N	2026-03-13 13:24:22.672024+00
46	24	24	completed	\N	2026-03-12 19:05:05.150524+00
38	15	15	completed	\N	2026-03-11 14:33:26.420735+00
39	1	1	completed	\N	2026-03-11 14:52:22.778242+00
40	1	1	completed	\N	2026-03-11 15:11:44.451059+00
41	1	1	completed	\N	2026-03-11 15:12:12.394847+00
34	29	29	completed	\N	2026-03-09 13:22:48.176368+00
48	70	70	completed	\N	2026-03-16 19:32:35.608348+00
42	1	1	completed	\N	2026-03-11 15:14:42.320996+00
44	36	36	completed	\N	2026-03-11 20:03:14.928221+00
\.


--
-- Data for Name: pedido_itens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido_itens (id, codigo_produto, descricao, quantidade, unidade, linha_origem, pedido_id) FROM stdin;
2170	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		32	89
2171	30406	FARMAIODINE TOPICO ALMOT.FARMAX 100ML	6.000		33	89
2172	132500	COLETOR UNIVERSAL DESPACK 70 ML S/CX 100UN	1.000		34	89
2246	43494	LUVA LATEX TOP NUGARD C/PO TAM G C/100 UNID	2.000		32	97
2247	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		33	97
2248	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		34	97
2249	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		35	97
2250	30570	ALCOOL 70% FARMAX 50ML	12.000		36	97
2251	30643	CLORETO DE MAGNESIO FARMAX 33GR	6.000		37	97
2252	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	12.000		38	97
2253	43478	LUVA LATEX  TOP NUGARD C/PO TAM P C/100 UNID	3.000		39	97
2254	138410	FITA FRALDA CREMER ROSA	6.000		40	97
2444	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		43	121
2445	22721	MICROPOROSA BRANCA CREMER 1,2CMX4,5M	6.000		44	121
2446	22730	MICROPOROSA BRANCA CREMER 10CMX4,5M UNIT	3.000		45	121
2447	28169	CURATIVO CREMERCARE BEGE 10UND	6.000		46	121
2448	28177	CURATIVO CREMERCARE BEGE 40UND	3.000		47	121
2449	28207	CURATIVO CREMERCARE TRANSP C/10UN	12.000		48	121
2450	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	12.000		49	121
2451	38512	COMP. Ñ ADER.SANFARMA EST 40X10	2.000		50	121
2452	40029	ESPARADRAPO SALVELOX 10CMX3M UN	3.000		51	121
2453	180440	CURATIVO CICATRISAN  TRANSP.10 UND	12.000		52	121
2454	140317	HASTES FLEXIVEIS APOLO C/ 75 UNID.	20.000		35	122
2455	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		36	122
2456	174300	HASTES FLEXIVEIS  APOLO C/ 150 UNID.	20.000		37	122
2457	124	ALGODAO APOLO 50GR C/ 20UNID PACK***************	1.000		38	122
2458	531	ALGODAO BOLA APOLO 50GR C/ 20UNID PACK*************	1.000		39	122
2459	566	ALGODAO BOLA APOLO 100GR C/ 10UND PACK******************	1.000		40	122
2460	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	1.000		41	122
2461	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	1.000		42	122
2462	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		43	122
2463	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	5.000		44	122
2464	30511	ALCOOL GEL 70% FARMAX 50GR	12.000		45	122
2465	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	5.000		46	122
2466	30570	ALCOOL 70% FARMAX 50ML	12.000		47	122
2467	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	1.000		48	122
2468	31402	SORO FISIOL SORIMAX 100ML C/12UN PACK *************	1.000		49	122
2469	40690	GEL ADESIVO ALIVIO DE FEBRE 4 UNIDADES CREMER	1.000		50	122
2470	42633	GLICERINA FARMAX BI DESTILADA COM ALOE VERA 100 ML	5.000		51	122
2471	311219	OLEO CORPORAL DE GIRASSOL FARMAX 100ML	5.000		52	122
2472	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		32	123
2473	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	6.000		33	123
2474	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		34	123
2475	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	5.000		35	123
2476	41610	SERINGA 60 ML BICO CATETER UNID MEDIX	12.000		36	123
2477	43575	BICARBONATO DE SODIO  UNIPHAR  100 GR	24.000		33	124
2478	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	1.000		34	124
2479	41610	SERINGA 60 ML BICO CATETER UNID MEDIX	6.000		35	124
2480	42641	AGULHA MEDIX 25 X 7 CX C/ 100 UNID	1.000		36	124
2481	42650	AGULHA MEDIX 30X7 CX C/ 100 UNID	1.000		37	124
2482	36242	BICARBONATO DE SODIO  UNIPHAR  50G	12.000		53	125
2483	38946	ATADURA AMERICA 6CMX1.8M SOFT C/12 PACK****************	1.000		54	125
2484	38954	ATADURA AMERICA 8CMX1.8M SOFT C/12 PACK **************	8.000		55	125
2485	38997	ATADURA AMERICA 20CMX1.8M SOFT UNIT	6.000		56	125
2486	39004	ATADURA AMERICA 25CMX1.8M SOFT UNIT	6.000		57	125
2487	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		58	125
2488	30473	SAL AMARGO MED. POTE FARMAX 30G	6.000		59	125
2489	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	3.000		60	125
2490	30570	ALCOOL 70% FARMAX 50ML	12.000		61	125
2491	31437	DERMAEX OLEO CICATRIZANTE 100ML	4.000		62	125
2492	31445	DERMAEX OLEO CICATRIZANTE 200ML	2.000		63	125
2493	34843	ESPARADRAPO SALVELOX 2,5CMX90CM UNIT	12.000		64	125
2494	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		65	125
2495	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		66	125
2496	42820	COLETOR UNIVERSAL SAQUINHO  80ML TRANSLUCIDO PCT C/100 ***	1.000		67	125
2497	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	4.000		68	125
2498	29971	COMPRESSA GAZE AMERICA HERIKA 13 FIOS 440X10 CX ********	1.000		31	126
2499	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		31	127
2500	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	1.000		32	127
2501	1171	SER BD SOLOMED 5ML AG 0,70X30 22G 100UN-631	1.000		33	127
2502	22748	MICROPOROSA BRANCA CREMER 2,5CMX0,9M	12.000		34	127
2503	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		35	127
2504	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	12.000		36	127
2505	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	12.000		37	127
2506	40029	ESPARADRAPO SALVELOX 10CMX3M UN	6.000		38	127
2526	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	133
2531	6157	AGULHA DESC BD 0,40X12 INTRAMUSCULAR CX C/100UN	1.000		31	138
2532	35491	SERINGA BD 50ML BICO SLIP UNIT	6.000		32	138
2173	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	2.000		31	90
2255	34843	ESPARADRAPO SALVELOX 2,5CMX90CM UNIT	36.000		31	98
2256	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	24.000		32	98
2257	40029	ESPARADRAPO SALVELOX 10CMX3M UN	6.000		33	98
2507	38997	ATADURA AMERICA 20CMX1.8M SOFT UNIT	12.000		42	128
2508	221	ATADURA CREPON CREMER CYSNE 25CM UNIT	6.000		43	128
2509	230	ATADURA CREPON CREMER CYSNE 30CM UNIT	6.000		44	128
2510	30589	TINTURA DE IODO 2% FARMAX 30ML	2.000		45	128
2511	34240	BENDITA CANFORA TABLETE ESTOJO DISP C/16(8 X3,5G) BRAVIR	1.000		46	128
2527	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	134
2533	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	2.000		33	138
2534	174505	SER BD 20ML S/AGULHA LUER SLIP UND	24.000		34	138
2546	43320	CURATIVO C/ 10 MICKEY E AMIGOS SANFARMA	6.000		33	142
2547	138509	MICROPOROSA BEGE CREMER 10CMX4,5M	12.000		34	142
2548	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	12.000		35	142
2549	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		36	142
2550	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	3.000		37	142
2551	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		38	142
2552	38326	CURATIVOS CREMER PATRULHA CANINA C/10 UNID	6.000		39	142
2553	43338	CURATIVO C/ 10 MICKEY E MINNIE SANFARMA	6.000		40	142
2554	43630	BOLSA P/COLOSTOMIA OPACA  L-16CM COMP-23CM C/FILTRO 5 UNID	2.000		41	142
2555	43320	CURATIVO C/ 10 MICKEY E AMIGOS SANFARMA	6.000		32	143
2556	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	12.000		33	143
2557	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		34	143
2558	38326	CURATIVOS CREMER PATRULHA CANINA C/10 UNID	6.000		35	143
2559	43338	CURATIVO C/ 10 MICKEY E MINNIE SANFARMA	6.000		36	143
2560	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	12.000		31	144
2561	43320	CURATIVO C/ 10 MICKEY E AMIGOS SANFARMA	6.000		32	145
2562	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	12.000		33	145
2563	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		34	145
2564	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	4.000		35	145
2565	38326	CURATIVOS CREMER PATRULHA CANINA C/10 UNID	6.000		36	145
2566	43338	CURATIVO C/ 10 MICKEY E MINNIE SANFARMA	6.000		37	145
2567	42463	SOLUÇAO DE MANITOL 20% EQUIPLEX 250ML	6.000		40	146
2568	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		41	146
2569	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	5.000		42	146
2570	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	6.000		43	146
2571	1350	POVIDINE TOPICO ALMOTOLIA 100ML	6.000		44	146
2572	28169	CURATIVO CREMERCARE BEGE 10UND	24.000		45	146
2573	30430	BICARBONATO SODIO FARMAX POTE 100GR	6.000		46	146
2574	38512	COMP. Ñ ADER.SANFARMA EST 40X10	3.000		47	146
2575	43400	KIT PARA COLETA DE URINA C/1 TUBO SAQUINHO  3B UNIT	25.000		48	146
2576	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		36	147
2577	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		37	147
2578	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	6.000		38	147
2579	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	4.000		39	147
2580	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		40	147
2581	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		41	147
2582	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	6.000		42	147
2583	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		43	147
2584	182940	LUVA P/PROCED MEDIX GDE 100UN	4.000		37	148
2585	182958	LUVA P/PROCED MEDIX MED 100UN	4.000		38	148
2586	182966	LUVA P/PROCED MEDIX PEQ 100UN	2.000		39	148
2587	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	5.000		40	148
2588	30031	TORNOZELEIRA LONGA PRETA P KSN008	1.000		41	148
2589	30295	TORNOZELEIRA LONGA PRETA G KSN008	1.000		42	148
2590	30333	TORNOZELEIRA LONGA PRETA M KSN008	1.000		43	148
2591	30643	CLORETO DE MAGNESIO FARMAX 33GR	6.000		44	148
2592	37826	MUNHEQUEIRA AJUSTAVEL NEOSOFT KSN071	3.000		45	148
2593	42722	NEBULIZADOR INALAR COMPACT  C810 OMRON	20.000		32	149
2594	39373	MONITOR DE PRESSAO PULSO OMRON DIGITAL  HEM6181	4.000		31	150
2595	22756	MICROPOROSA BRANCA CREMER 2,5CMX4,5M	5.000		33	151
2596	44032	SABONETE DE ENXOFRE 90G	6.000		34	151
2597	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	1.000		35	151
2598	1350	POVIDINE TOPICO ALMOTOLIA 100ML	2.000		36	151
2599	22721	MICROPOROSA BRANCA CREMER 1,2CMX4,5M	6.000		37	151
2600	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		38	151
2601	34843	ESPARADRAPO SALVELOX 2,5CMX90CM UNIT	5.000		39	151
2602	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	4.000		40	151
2603	40029	ESPARADRAPO SALVELOX 10CMX3M UN	2.000		41	151
2604	43338	CURATIVO C/ 10 MICKEY E MINNIE SANFARMA	10.000		42	151
2605	180440	CURATIVO CICATRISAN  TRANSP.10 UND	10.000		43	151
2606	43320	CURATIVO C/ 10 MICKEY E AMIGOS SANFARMA	6.000		32	152
2607	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	12.000		33	152
2608	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		34	152
2609	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	12.000		35	152
2610	38326	CURATIVOS CREMER PATRULHA CANINA C/10 UNID	6.000		36	152
2611	43338	CURATIVO C/ 10 MICKEY E MINNIE SANFARMA	6.000		37	152
2612	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	36.000		32	153
2174	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		38	91
2175	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		39	91
2176	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	3.000		40	91
2177	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	3.000		41	91
2178	28177	CURATIVO CREMERCARE BEGE 40UND	6.000		42	91
2179	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		43	91
2180	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	6.000		44	91
2181	30570	ALCOOL 70% FARMAX 50ML	24.000		45	91
2182	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	1.000		46	91
2183	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		47	91
2184	34843	ESPARADRAPO SALVELOX 2,5CMX90CM UNIT	12.000		48	91
2185	40142	NEBULIZADOR NEB AIR MULTILASER C/FONTE HC068	1.000		49	91
2186	41440	OLEO MINERAL UNIPHAR 100 ML	6.000		50	91
2187	42943	LUVA MEDIX CIR. TAM 7,0 PAR	6.000		51	91
2188	42951	LUVA MEDIX CIR. TAM 7,5 PAR	6.000		52	91
2189	42960	LUVA MEDIX CIR. TAM 8,5 PAR	6.000		53	91
2190	43915	OLEO DE RICINO 30 ML UNIPHAR	6.000		54	91
2191	44202	LUVA MEDIX CIR. TAM 8,0 PAR	6.000		55	91
2192	124	ALGODAO APOLO 50GR C/ 20UNID PACK***************	1.000		56	91
2193	531	ALGODAO BOLA APOLO 50GR C/ 20UNID PACK*************	1.000		57	91
2194	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		58	91
2195	28207	CURATIVO CREMERCARE TRANSP C/10UN	12.000		59	91
2258	22756	MICROPOROSA BRANCA CREMER 2,5CMX4,5M	4.000		33	99
2259	28193	CURATIVO CREMERCARE TRANSP RED C/16UND	12.000		34	99
2260	138410	FITA FRALDA CREMER ROSA	3.000		35	99
2261	182940	LUVA P/PROCED MEDIX GDE 100UN	1.000		36	99
2262	182958	LUVA P/PROCED MEDIX MED 100UN	1.000		37	99
2263	28169	CURATIVO CREMERCARE BEGE 10UND	20.000		38	99
2264	28177	CURATIVO CREMERCARE BEGE 40UND	10.000		39	99
2265	36196	ESPARADRAPO TRANSPARENTE CREMER 10CMX4,5M UNIT	2.000		40	99
2266	43796	LUVA LATEX SOFT AID C/PO TAM M C/20	1.000		41	99
2267	43800	LUVA LATEX SOFT AID C/PO TAM P C/20	1.000		42	99
2268	43818	LUVA LATEX SOFT AID C/PO TAM G C/20	1.000		43	99
2269	44040	SABONETE DE GLICERINA 100G	6.000		44	99
2270	612	ESPARADRAPO BRANCO CREMER 2,5CMX0,9M	6.000		45	99
2271	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	6.000		46	99
2272	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	6.000		47	99
2273	22721	MICROPOROSA BRANCA CREMER 1,2CMX4,5M	4.000		48	99
2274	22748	MICROPOROSA BRANCA CREMER 2,5CMX0,9M	4.000		49	99
2512	38997	ATADURA AMERICA 20CMX1.8M SOFT UNIT	12.000		42	129
2513	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		43	129
2514	34240	BENDITA CANFORA TABLETE ESTOJO DISP C/16(8 X3,5G) BRAVIR	1.000		44	129
2528	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	135
2535	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	1.000		31	139
2536	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	2.000		32	139
2537	174505	SER BD 20ML S/AGULHA LUER SLIP UND	12.000		33	139
2538	180599	SER BD 10ML S/AGULHA LUER LOCK UND	12.000		34	139
2613	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	1.000		31	154
2614	906	SER BD SOLOMED 5ML AG 0,70X25 22G 100UN-630	1.000		32	154
2615	30473	SAL AMARGO MED. POTE FARMAX 30G	6.000		33	154
2616	30589	TINTURA DE IODO 2% FARMAX 30ML	6.000		34	154
2617	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	12.000		35	154
2618	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	12.000		36	154
2619	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	12.000		31	155
2620	31399	AGULHA P/CANETA 4MM NANO PENTAPOINT EASYFLOW 100UND	1.000		32	155
2621	38512	COMP. Ñ ADER.SANFARMA EST 40X10	3.000		33	155
2622	132500	COLETOR UNIVERSAL DESPACK 70 ML S/CX 100UN	2.000		34	155
2739	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	1.000		40	170
2740	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		41	170
2741	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	36.000		31	171
2742	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		31	172
2743	30570	ALCOOL 70% FARMAX 50ML	12.000		32	172
2744	31437	DERMAEX OLEO CICATRIZANTE 100ML	12.000		33	172
2745	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	12.000		34	172
2746	34819	MICROPOROSA SALVELOX 1,2CMX4,5M	12.000		35	172
2747	34843	ESPARADRAPO SALVELOX 2,5CMX90CM UNIT	12.000		36	172
2748	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	12.000		37	172
2749	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		38	172
2750	39357	VASELINA VASEMAX  FARMAX  25 GR	12.000		39	172
2751	40029	ESPARADRAPO SALVELOX 10CMX3M UN	2.000		40	172
2752	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	1.000		32	173
2753	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	2.000		33	173
2754	29823	TIRAS GTECH FREE LITE C/50 UNIDS	2.000		34	173
2755	31437	DERMAEX OLEO CICATRIZANTE 100ML	3.000		35	173
2756	43982	SABONETE ACNOL 90G	3.000		36	173
2757	183199	ESPAR MISSNER IMPERM 2,5CM X 4,5M	6.000		37	173
2758	183202	ESPAR MISSNER IMPERM 1,2CM X 4,5M	12.000		38	173
2759	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	3.000		31	174
2760	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	3.000		31	175
2761	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	3.000		31	176
2196	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		31	92
2275	34835	ESPARADRAPO SALVELOX 2,5CMX4,5M	6.000		32	100
2276	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		33	100
2277	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		34	100
2278	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	6.000		35	100
2279	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		36	100
2280	30570	ALCOOL 70% FARMAX 50ML	12.000		37	100
2281	39160	VASELINA VASEMAX  FARMAX 70G	3.000		38	100
2282	43478	LUVA LATEX  TOP NUGARD C/PO TAM P C/100 UNID	2.000		39	100
2283	43486	LUVA LATEX  TOP NUGARD C/PO TAM M C/100 UNID	3.000		40	100
2284	43796	LUVA LATEX SOFT AID C/PO TAM M C/20	6.000		41	100
2515	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	12.000		34	130
2516	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	2.000		35	130
2517	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	12.000		36	130
2518	22748	MICROPOROSA BRANCA CREMER 2,5CMX0,9M	12.000		37	130
2519	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		38	130
2520	30406	FARMAIODINE TOPICO ALMOT.FARMAX 100ML	6.000		39	130
2521	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		40	130
2522	30589	TINTURA DE IODO 2% FARMAX 30ML	6.000		41	130
2523	31399	AGULHA P/CANETA 4MM NANO PENTAPOINT EASYFLOW 100UND	2.000		42	130
2529	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	136
2539	174505	SER BD 20ML S/AGULHA LUER SLIP UND	100.000		31	140
2623	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		34	156
2624	1350	POVIDINE TOPICO ALMOTOLIA 100ML	6.000		35	156
2625	1961	MANTEIGA CACAU BATOM LUXO 3,3GR C/50UN BRAVIR	1.000		36	156
2626	29815	TIRAS GTECH FREE 1 C/50 UNIDS	3.000		37	156
2627	29823	TIRAS GTECH FREE LITE C/50 UNIDS	2.000		38	156
2628	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		39	156
2629	30538	PEDRA HUME PURA PO FARMAX 20G	6.000		40	156
2630	30570	ALCOOL 70% FARMAX 50ML	24.000		41	156
2631	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	2.000		42	156
2632	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		43	156
2633	39357	VASELINA VASEMAX  FARMAX  25 GR	6.000		44	156
2634	44172	TERMOMETRO DIGITAL  DOMOTHERM TC01 BRANCO CARTELADO	12.000		45	156
2635	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	2.000		33	157
2636	43320	CURATIVO C/ 10 MICKEY E AMIGOS SANFARMA	6.000		34	157
2637	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		35	157
2638	787	MICRO NEBULIZADOR NS ADULTO	3.000		36	157
2639	795	MICRO NEBULIZADOR NS INFANTIL.	3.000		37	157
2640	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	6.000		38	157
2641	30473	SAL AMARGO MED. POTE FARMAX 30G	6.000		39	157
2642	34703	MASCARA DESC TRIPLA C/ELASTICO MEDIX 22G BR C/50UND	10.000		40	157
2643	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	2.000		41	157
2644	38261	MONITOR DE PRESSAO PULSO GTECH DIGITAL GP400	2.000		42	157
2645	39160	VASELINA VASEMAX  FARMAX 70G	6.000		43	157
2646	40410	KIT GTECH SUPERFLOW PLUS ADULTO	3.000		44	157
2647	40428	KIT GTECH SUPERFLOW PLUS INFANTIL	3.000		45	157
2648	41610	SERINGA 60 ML BICO CATETER UNID MEDIX	10.000		46	157
2649	43338	CURATIVO C/ 10 MICKEY E MINNIE SANFARMA	6.000		47	157
2650	29823	TIRAS GTECH FREE LITE C/50 UNIDS	4.000		31	158
2651	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	3.000		31	159
2652	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	3.000		32	159
2653	40410	KIT GTECH SUPERFLOW PLUS ADULTO	6.000		33	159
2654	40428	KIT GTECH SUPERFLOW PLUS INFANTIL	6.000		34	159
2655	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	1.000		32	160
2656	40045	NEBULIZADOR GTECH COMPACT DC2	2.000		33	160
2657	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	4.000		34	160
2658	35785	APAR PRESSAO G-TECH MANUAL C/ ESTETO	1.000		35	160
2659	38261	MONITOR DE PRESSAO PULSO GTECH DIGITAL GP400	2.000		36	160
2660	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	6.000		31	161
2661	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	6.000		32	161
2662	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		33	161
2663	38296	BANDAGEM ELASTICA ADESIVA INCOTERM PRETO UNIT	2.000		34	161
2664	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		35	161
2665	39683	BANDAGEM ELASTICA ADESIVA INCOTERM BEGE UNIT	2.000		36	161
2666	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	6.000		31	162
2667	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	6.000		32	162
2668	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		33	162
2669	38296	BANDAGEM ELASTICA ADESIVA INCOTERM PRETO UNIT	2.000		34	162
2670	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		35	162
2671	39683	BANDAGEM ELASTICA ADESIVA INCOTERM BEGE UNIT	2.000		36	162
2672	43842	BANANA ZERO DA COLONIA DISPLAY C/24 UNID	1.000		37	162
2673	29815	TIRAS GTECH FREE 1 C/50 UNIDS	3.000		31	163
2674	29823	TIRAS GTECH FREE LITE C/50 UNIDS	2.000		32	163
2675	30660	GLICERINA PURA COSMETICA FARMAX 100ML	3.000		33	163
2676	34088	DUCHA GINECOLOGICA 12  SANITY	2.000		34	163
2677	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		35	163
2678	40142	NEBULIZADOR NEB AIR MULTILASER C/FONTE HC068	2.000		36	163
2679	41440	OLEO MINERAL UNIPHAR 100 ML	4.000		37	163
2197	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		33	93
2285	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		32	101
2286	30430	BICARBONATO SODIO FARMAX POTE 100GR	24.000		33	101
2287	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	6.000		34	101
2288	39160	VASELINA VASEMAX  FARMAX 70G	3.000		35	101
2289	43486	LUVA LATEX  TOP NUGARD C/PO TAM M C/100 UNID	6.000		36	101
2290	43796	LUVA LATEX SOFT AID C/PO TAM M C/20	3.000		37	101
2291	43800	LUVA LATEX SOFT AID C/PO TAM P C/20	3.000		38	101
2292	43818	LUVA LATEX SOFT AID C/PO TAM G C/20	6.000		39	101
2293	138410	FITA FRALDA CREMER ROSA	3.000		40	101
2294	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		41	101
2524	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	131
2530	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	2.000		31	137
2540	86	AGULHA DESC BD 0,80X25 INTRAMUSCULAR CX C/100UN	1.000		31	141
2541	6157	AGULHA DESC BD 0,40X12 INTRAMUSCULAR CX C/100UN	1.000		32	141
2542	41033	AGULHA DESC BD 0,50X15 INTRAD/SUBC CX C/100UN	1.000		33	141
2543	41041	AGULHA DESC BD 0,60X25 INTRAMUSCULAR CX C/100UN	1.000		34	141
2544	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		35	141
2545	174505	SER BD 20ML S/AGULHA LUER SLIP UND	12.000		36	141
2680	43486	LUVA LATEX  TOP NUGARD C/PO TAM M C/100 UNID	3.000		38	163
2681	43818	LUVA LATEX SOFT AID C/PO TAM G C/20	5.000		39	163
2682	43915	OLEO DE RICINO 30 ML UNIPHAR	2.000		40	163
2683	183229	FITA MICROPOROSA MISSNER 10,0CM X 4,5M	4.000		41	163
2684	34703	MASCARA DESC TRIPLA C/ELASTICO MEDIX 22G BR C/50UND	20.000		31	164
2685	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		32	164
2686	39365	SORO FISIOL SORIMAX 250ML C/12UN PACK**************	1.000		33	165
2687	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	1.000		34	165
2688	213	ATADURA CREPON CREMER CYSNE 20CM UNIT	12.000		35	165
2689	566	ALGODAO BOLA APOLO 100GR C/ 10UND PACK******************	1.000		36	165
2690	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	3.000		37	165
2691	29823	TIRAS GTECH FREE LITE C/50 UNIDS	2.000		38	165
2692	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		39	165
2693	30430	BICARBONATO SODIO FARMAX POTE 100GR	6.000		40	165
2694	30457	OLEO RICINO PURO FARMAX 30ML	6.000		41	165
2695	30511	ALCOOL GEL 70% FARMAX 50GR	12.000		42	165
2696	30520	OLEO DE BANANA DILUENTE FARMAX 28ML	6.000		43	165
2697	30538	PEDRA HUME PURA PO FARMAX 20G	6.000		44	165
2698	30627	ALCOOL GEL 70% FARMAX 430GR	6.000		45	165
2699	31402	SORO FISIOL SORIMAX 100ML C/12UN PACK *************	1.000		46	165
2700	31437	DERMAEX OLEO CICATRIZANTE 100ML	3.000		47	165
2701	31445	DERMAEX OLEO CICATRIZANTE 200ML	3.000		48	165
2702	33871	OLEO CAP/CORP.COCO FARMAX 100ML	6.000		49	165
2703	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	3.000		50	165
2704	40010	TERMOMETRO DIGITAL CEPALAB UNIT.	6.000		51	165
2705	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	1.000		35	166
2706	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	3.000		36	166
2707	29823	TIRAS GTECH FREE LITE C/50 UNIDS	3.000		37	166
2708	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	2.000		39	167
2709	140317	HASTES FLEXIVEIS APOLO C/ 75 UNID.	12.000		40	167
2710	182958	LUVA P/PROCED MEDIX MED 100UN	2.000		41	167
2711	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		42	167
2712	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		43	167
2713	43575	BICARBONATO DE SODIO  UNIPHAR  100 GR	12.000		44	167
2714	174300	HASTES FLEXIVEIS  APOLO C/ 150 UNID.	12.000		45	167
2715	132	ALGODAO APOLO 100GR C/ 10UNID PACK***********	1.000		46	167
2716	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	2.000		47	167
2717	42650	AGULHA MEDIX 30X7 CX C/ 100 UNID	1.000		48	167
2718	42943	LUVA MEDIX CIR. TAM 7,0 PAR	6.000		49	167
2719	42951	LUVA MEDIX CIR. TAM 7,5 PAR	6.000		50	167
2720	42960	LUVA MEDIX CIR. TAM 8,5 PAR	6.000		51	167
2721	43591	UMIDIFICADOR 2,1L CLEAR TANK MULTILASER HC210	1.000		52	167
2722	43915	OLEO DE RICINO 30 ML UNIPHAR	12.000		53	167
2723	44202	LUVA MEDIX CIR. TAM 8,0 PAR	6.000		54	167
2724	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	6.000		31	168
2725	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		32	168
2726	40894	LANCETA PARA LANCETADOR C/100 NID MEDLEVENSOHN ML03 28G	6.000		33	168
2727	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		34	168
2728	183970	COLETOR UNIVERSAL DESPACK ESTERIL 80ML CX C/100 UN	1.000		35	168
2729	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	3.000		32	169
2730	29823	TIRAS GTECH FREE LITE C/50 UNIDS	6.000		33	169
2731	38261	MONITOR DE PRESSAO PULSO GTECH DIGITAL GP400	2.000		34	169
2732	39373	MONITOR DE PRESSAO PULSO OMRON DIGITAL  HEM6181	2.000		35	169
2733	41106	MONITOR DE PRESSAO BRAÇO OMRON DIGITAL HEM7142	2.000		36	169
2734	42722	NEBULIZADOR INALAR COMPACT  C810 OMRON	2.000		37	169
2735	28177	CURATIVO CREMERCARE BEGE 40UND	6.000		36	170
2736	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		37	170
2737	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		38	170
2738	30570	ALCOOL 70% FARMAX 50ML	24.000		39	170
2198	34835	ESPARADRAPO SALVELOX 2,5CMX4,5M	12.000		36	94
2199	43494	LUVA LATEX TOP NUGARD C/PO TAM G C/100 UNID	6.000		37	94
2200	30643	CLORETO DE MAGNESIO FARMAX 33GR	12.000		38	94
2201	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		39	94
2202	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		40	94
2203	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		41	94
2204	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	12.000		42	94
2205	39160	VASELINA VASEMAX  FARMAX 70G	3.000		43	94
2206	43478	LUVA LATEX  TOP NUGARD C/PO TAM P C/100 UNID	3.000		44	94
2207	43486	LUVA LATEX  TOP NUGARD C/PO TAM M C/100 UNID	6.000		45	94
2208	43796	LUVA LATEX SOFT AID C/PO TAM M C/20	6.000		46	94
2209	43800	LUVA LATEX SOFT AID C/PO TAM P C/20	3.000		47	94
2210	43818	LUVA LATEX SOFT AID C/PO TAM G C/20	6.000		48	94
2211	138410	FITA FRALDA CREMER ROSA	4.000		49	94
2295	38946	ATADURA AMERICA 6CMX1.8M SOFT C/12 PACK****************	1.000		32	102
2296	221	ATADURA CREPON CREMER CYSNE 25CM UNIT	6.000		33	102
2297	230	ATADURA CREPON CREMER CYSNE 30CM UNIT	6.000		34	102
2298	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		35	102
2299	34240	BENDITA CANFORA TABLETE ESTOJO DISP C/16(8 X3,5G) BRAVIR	1.000		36	102
2300	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	12.000		31	103
2301	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	18.000		31	104
2302	30406	FARMAIODINE TOPICO ALMOT.FARMAX 100ML	12.000		37	105
2303	31437	DERMAEX OLEO CICATRIZANTE 100ML	24.000		38	105
2304	41203	REPELENTE 4HS FAMILY SPRAY LEV200 ML PAG 100ML NUTRIEX	12.000		39	105
2305	41335	MULETA CANADENSE (PAR) D6 CINZA DELLAMED	2.000		40	105
2306	42463	SOLUÇAO DE MANITOL 20% EQUIPLEX 250ML	43.000		41	105
2307	30538	PEDRA HUME PURA PO FARMAX 20G	12.000		42	105
2308	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	12.000		43	105
2309	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	48.000		44	105
2310	43915	OLEO DE RICINO 30 ML UNIPHAR	12.000		45	105
2311	43320	CURATIVO C/ 10 MICKEY E AMIGOS SANFARMA	6.000		32	106
2312	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	6.000		33	106
2313	29815	TIRAS GTECH FREE 1 C/50 UNIDS	4.000		34	106
2314	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		35	106
2315	30538	PEDRA HUME PURA PO FARMAX 20G	6.000		36	106
2316	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		37	106
2317	43095	CURATIVO C/20 MICKEY E AMIGOS	4.000		38	106
2318	43338	CURATIVO C/ 10 MICKEY E MINNIE SANFARMA	6.000		39	106
2319	43346	CURATIVO C/20 MICKEY E MINNIE SANFARMA	4.000		40	106
2320	43575	BICARBONATO DE SODIO  UNIPHAR  100 GR	6.000		41	106
2321	3964	MANTEIGA CACAU LIQUIDA ROLL ON 10ML DISPLAY C/24UN BRAVIR	1.000		31	107
2322	30473	SAL AMARGO MED. POTE FARMAX 30G	1.000		32	107
2323	31437	DERMAEX OLEO CICATRIZANTE 100ML	10.000		33	107
2324	39373	MONITOR DE PRESSAO PULSO OMRON DIGITAL  HEM6181	1.000		34	107
2325	42943	LUVA MEDIX CIR. TAM 7,0 PAR	1.000		35	107
2326	795	MICRO NEBULIZADOR NS INFANTIL.	2.000		31	108
2327	34240	BENDITA CANFORA TABLETE ESTOJO DISP C/16(8 X3,5G) BRAVIR	1.000		32	108
2328	40134	ESPAÇADOR EASY AIR ADULTO/INFANTIL  MULTILASER HC178	2.000		33	109
2329	30473	SAL AMARGO MED. POTE FARMAX 30G	5.000		34	109
2330	30538	PEDRA HUME PURA PO FARMAX 20G	3.000		35	109
2331	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		36	109
2332	30678	VASELINA VASEMAX LIQ.FARMAX 100ML	2.000		37	109
2333	31402	SORO FISIOL SORIMAX 100ML C/12UN PACK *************	1.000		38	109
2334	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	10.000		39	109
2335	34819	MICROPOROSA SALVELOX 1,2CMX4,5M	10.000		40	109
2336	34843	ESPARADRAPO SALVELOX 2,5CMX90CM UNIT	10.000		41	109
2337	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	10.000		42	109
2338	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	4.000		43	109
2339	36242	BICARBONATO DE SODIO  UNIPHAR  50G	5.000		44	109
2340	41440	OLEO MINERAL UNIPHAR 100 ML	2.000		45	109
2341	43907	ALCOOL 70% SPRAY 50 ML UNIPHAR	6.000		46	109
2342	43915	OLEO DE RICINO 30 ML UNIPHAR	3.000		47	109
2343	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	2.000		33	110
2344	43540	SORO FISIOLOGICO 100ML UNIPHAR C/12	1.000		34	110
2345	43907	ALCOOL 70% SPRAY 50 ML UNIPHAR	12.000		35	110
2346	29815	TIRAS GTECH FREE 1 C/50 UNIDS	4.000		36	110
2347	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	6.000		37	110
2348	35866	PERMANGANATO DE POTASSIO UNIPHAR 10 DOSES 100MG UNIT	12.000		38	110
2349	41610	SERINGA 60 ML BICO CATETER UNID MEDIX	10.000		39	110
2350	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	12.000		40	110
2351	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	6.000		36	111
2352	42463	SOLUÇAO DE MANITOL 20% EQUIPLEX 250ML	12.000		38	112
2353	30023	MUNHEQUEIRA AJUST.PRETA KSN010	3.000		39	112
2354	31046	MUNHEQUEIRA ELAST .AJUST.PRETA KSN064	1.000		40	112
2355	31135	JOELHEIRA LONGA LISA PRETA G KSN035	1.000		41	112
2356	31143	JOELHEIRA LONGA LISA PRETA M KSN035	1.000		42	112
2357	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		43	112
2358	30430	BICARBONATO SODIO FARMAX POTE 100GR	24.000		44	112
2359	31437	DERMAEX OLEO CICATRIZANTE 100ML	3.000		45	112
2360	31445	DERMAEX OLEO CICATRIZANTE 200ML	3.000		46	112
2212	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		33	95
2361	43443	TORNOZELEIRA CURTA M PRETO  KESTAL KSN0041	1.000		47	112
2362	43451	TORNOZELEIRA CURTA G PRETO  KESTAL KSN0041	1.000		48	112
2363	44148	ORTESE CURTA P/PUNHO BILATERAL PRETO P KSN0137	1.000		49	112
2364	44156	ORTESE CURTA P/PUNHO BILATERAL PRETO M KSN0137	1.000		50	112
2365	44164	ORTESE CURTA P/PUNHO BILATERAL PRETO G KSN0137	1.000		51	112
2366	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		32	113
2367	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		33	113
2368	132500	COLETOR UNIVERSAL DESPACK 70 ML S/CX 100UN	1.000		34	113
2369	31399	AGULHA P/CANETA 4MM NANO PENTAPOINT EASYFLOW 100UND	1.000		31	114
2370	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	11.000		32	114
2371	38512	COMP. Ñ ADER.SANFARMA EST 40X10	8.000		33	114
2372	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		34	114
2373	335720	PERMASSIM CAIXA C/ 500 CP	1.000		35	114
2374	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		42	115
2375	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	10.000		43	115
2376	44202	LUVA MEDIX CIR. TAM 8,0 PAR	12.000		44	115
2377	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	2.000		45	115
2378	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	1.000		46	115
2379	1724	AGULHA DESC BD 0,80X30 INTRAMUSCULAR CX C/100UN	1.000		47	115
2380	6157	AGULHA DESC BD 0,40X12 INTRAMUSCULAR CX C/100UN	1.000		48	115
2381	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		49	115
2382	30538	PEDRA HUME PURA PO FARMAX 20G	3.000		50	115
2383	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	3.000		51	115
2384	30570	ALCOOL 70% FARMAX 50ML	24.000		52	115
2385	34258	BENDITA CANFORA POTE C/200 X 0,75GR BRAVIR	1.000		53	115
2386	38512	COMP. Ñ ADER.SANFARMA EST 40X10	2.000		54	115
2387	38830	COLETOR PERFURO-CORTANTE 13L MEDIX UNIT	3.000		55	115
2388	42641	AGULHA MEDIX 25 X 7 CX C/ 100 UNID	1.000		56	115
2389	42650	AGULHA MEDIX 30X7 CX C/ 100 UNID	1.000		57	115
2390	42935	LUVA MEDIX CIR. TAM 6,5 PAR	12.000		58	115
2391	42943	LUVA MEDIX CIR. TAM 7,0 PAR	12.000		59	115
2392	42951	LUVA MEDIX CIR. TAM 7,5 PAR	12.000		60	115
2393	42960	LUVA MEDIX CIR. TAM 8,5 PAR	12.000		61	115
1611	40029	ESPARADRAPO SALVELOX 10CMX3M UN	4.000		33	2
1612	34819	MICROPOROSA SALVELOX 1,2CMX4,5M	12.000		34	2
1613	33871	OLEO CAP/CORP.COCO FARMAX 100ML	6.000		35	2
1614	33880	OLEO CAP/CORP.ARGAN FARMAX 100ML	6.000		36	2
1615	34835	ESPARADRAPO SALVELOX 2,5CMX4,5M	12.000		38	3
1616	43494	LUVA LATEX TOP NUGARD C/PO TAM G C/100 UNID	3.000		39	3
1617	30643	CLORETO DE MAGNESIO FARMAX 33GR	12.000		40	3
1618	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	12.000		41	3
1619	43486	LUVA LATEX  TOP NUGARD C/PO TAM M C/100 UNID	6.000		42	3
1620	43796	LUVA LATEX SOFT AID C/PO TAM M C/20	6.000		43	3
1621	30678	VASELINA VASEMAX LIQ.FARMAX 100ML	12.000		44	3
1622	30570	ALCOOL 70% FARMAX 50ML	12.000		45	3
1623	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	2.000		46	3
1624	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		47	3
1625	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		48	3
1626	28193	CURATIVO CREMERCARE TRANSP RED C/16UND	6.000		41	4
1627	34827	MICROPOROSA SALVELOX 5CMX4,5M UNIT	6.000		42	4
1628	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		43	4
1629	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	6.000		44	4
1630	34770	AGUA OXIGENADA RIOQUIMICA 10 VOL. 1LT UNIT	1.000		45	4
1631	31445	DERMAEX OLEO CICATRIZANTE 200ML	3.000		46	4
1632	31437	DERMAEX OLEO CICATRIZANTE 100ML	3.000		47	4
1633	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		48	4
1634	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	3.000		49	4
1635	30457	OLEO RICINO PURO FARMAX 30ML	3.000		50	4
1636	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		51	4
1637	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		36	5
1638	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	3.000		37	5
1639	34703	MASCARA DESC TRIPLA C/ELASTICO MEDIX 22G BR C/50UND	3.000		38	5
1640	33871	OLEO CAP/CORP.COCO FARMAX 100ML	3.000		39	5
1641	30600	OLEO MINERAL NATUROL MED. FARMAX 100ML	6.000		40	5
1642	33065	OLEO CAP/CORP.AMENDOAS FARMAX 100ML	3.000		41	5
1643	33847	OLEO CAP/CORP.BABOSA FARMAX 100ML	3.000		42	5
1644	132500	COLETOR UNIVERSAL DESPACK 70 ML S/CX 100UN	1.000		43	5
1645	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		33	6
1646	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		33	7
1647	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	2.000		43	8
1648	40142	NEBULIZADOR NEB AIR MULTILASER C/FONTE HC068	1.000		44	8
1649	42943	LUVA MEDIX CIR. TAM 7,0 PAR	6.000		45	8
1650	42951	LUVA MEDIX CIR. TAM 7,5 PAR	6.000		46	8
1651	42960	LUVA MEDIX CIR. TAM 8,5 PAR	6.000		47	8
1652	43915	OLEO DE RICINO 30 ML UNIPHAR	6.000		48	8
1653	44202	LUVA MEDIX CIR. TAM 8,0 PAR	6.000		49	8
1654	34835	ESPARADRAPO SALVELOX 2,5CMX4,5M	10.000		50	8
1655	34843	ESPARADRAPO SALVELOX 2,5CMX90CM UNIT	12.000		51	8
1656	33944	OLEO CAP/CORP.ROSA MOSQUETA FARMAX 100ML	3.000		52	8
1657	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		53	8
1658	33065	OLEO CAP/CORP.AMENDOAS FARMAX 100ML	3.000		54	8
1659	33855	OLEO CAP/CORP.CENOURA FARMAX 100ML	3.000		55	8
1660	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		56	8
1661	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	1.000		57	8
1662	30570	ALCOOL 70% FARMAX 50ML	24.000		58	8
1663	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		59	8
1664	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	6.000		60	8
1665	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		61	8
1666	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	2.000		62	8
1667	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		63	8
1668	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	1.000		64	8
1685	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		46	1
1686	40134	ESPAÇADOR EASY AIR ADULTO/INFANTIL  MULTILASER HC178	3.000		47	1
1687	335720	PERMASSIM CAIXA C/ 500 CP	1.000		48	1
1688	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	6.000		49	1
1689	42463	SOLUÇAO DE MANITOL 20% EQUIPLEX 250ML	6.000		50	1
1690	43400	KIT PARA COLETA DE URINA C/1 TUBO SAQUINHO  3B UNIT	25.000		51	1
1691	40142	NEBULIZADOR NEB AIR MULTILASER C/FONTE HC068	6.000		52	1
1692	39934	BOLSA  DE BORRACHA AGUA QUENTE TERMOGEL 1L	3.000		53	1
1693	38512	COMP. Ñ ADER.SANFARMA EST 40X10	2.000		54	1
1694	34258	BENDITA CANFORA POTE C/200 X 0,75GR BRAVIR	1.000		55	1
1695	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		56	1
1696	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		57	1
1697	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	6.000		58	1
1698	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	12.000		59	1
1699	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		60	1
1700	1961	MANTEIGA CACAU BATOM LUXO 3,3GR C/50UN BRAVIR	1.000		61	1
1701	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		34	9
1702	30511	ALCOOL GEL 70% FARMAX 50GR	12.000		35	9
1703	1724	AGULHA DESC BD 0,80X30 INTRAMUSCULAR CX C/100UN	2.000		36	9
1704	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	1.000		37	9
1705	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		38	9
1706	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	15.000		31	10
1707	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		32	10
1708	28193	CURATIVO CREMERCARE TRANSP RED C/16UND	12.000		34	11
1709	43346	CURATIVO C/20 MICKEY E MINNIE SANFARMA	4.000		35	11
1710	36374	CURATIVO EXTRA GRANDE XXG 08UN CREMER	6.000		36	11
1711	40762	AUTO LANCETA GTECH 28G C/ 100 UNID	2.000		37	11
1712	42722	NEBULIZADOR INALAR COMPACT  C810 OMRON	1.000		38	11
1713	43338	CURATIVO C/ 10 MICKEY E MINNIE SANFARMA	6.000		39	11
1714	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	3.000		40	11
1715	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		41	11
1716	183946	SORO FISIOL. ARBORETO 100ML 24UN	1.000		33	12
1717	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	3.000		34	12
1718	31445	DERMAEX OLEO CICATRIZANTE 200ML	4.000		35	12
1719	183946	SORO FISIOL. ARBORETO 100ML 24UN	1.000		33	13
1720	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	3.000		34	13
1721	31445	DERMAEX OLEO CICATRIZANTE 200ML	4.000		35	13
1722	31259	MANT. CACAU LUXO NATURAVENE 50UN********	1.000		34	14
1723	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	3.000		35	14
1724	31445	DERMAEX OLEO CICATRIZANTE 200ML	12.000		36	14
1725	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		37	14
1726	183954	SORO FISIOL. ARBORETO 250ML 24UN	1.000		34	15
1727	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	3.000		35	15
1728	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		36	15
1729	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		37	15
1730	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	3.000		33	16
1731	31445	DERMAEX OLEO CICATRIZANTE 200ML	3.000		34	16
1732	31437	DERMAEX OLEO CICATRIZANTE 100ML	3.000		35	16
1733	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		33	17
1734	42820	COLETOR UNIVERSAL SAQUINHO  80ML TRANSLUCIDO PCT C/100 ***	2.000		34	17
1735	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		34	18
1736	31445	DERMAEX OLEO CICATRIZANTE 200ML	2.000		35	18
1737	39373	MONITOR DE PRESSAO PULSO OMRON DIGITAL  HEM6181	1.000		36	18
1738	174505	SER BD 20ML S/AGULHA LUER SLIP UND	3.000		37	18
1739	180599	SER BD 10ML S/AGULHA LUER LOCK UND	5.000		38	18
1740	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		39	18
1741	906	SER BD SOLOMED 5ML AG 0,70X25 22G 100UN-630	1.000		40	18
1742	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		41	18
1743	40142	NEBULIZADOR NEB AIR MULTILASER C/FONTE HC068	1.000		34	19
1744	174505	SER BD 20ML S/AGULHA LUER SLIP UND	3.000		35	19
1745	180599	SER BD 10ML S/AGULHA LUER LOCK UND	5.000		36	19
1746	31445	DERMAEX OLEO CICATRIZANTE 200ML	2.000		37	19
1747	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		38	19
1748	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		39	19
1749	44172	TERMOMETRO DIGITAL  DOMOTHERM TC01 BRANCO CARTELADO	3.000		34	20
1750	44180	KIT DE NEBULIZACAO C810 OMRON	1.000		35	20
1751	174505	SER BD 20ML S/AGULHA LUER SLIP UND	1.000		36	20
1752	180599	SER BD 10ML S/AGULHA LUER LOCK UND	8.000		37	20
1753	31445	DERMAEX OLEO CICATRIZANTE 200ML	3.000		38	20
1754	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		39	20
1755	795	MICRO NEBULIZADOR NS INFANTIL.	1.000		40	20
1756	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		41	20
1757	44172	TERMOMETRO DIGITAL  DOMOTHERM TC01 BRANCO CARTELADO	3.000		33	21
1758	180599	SER BD 10ML S/AGULHA LUER LOCK UND	1.000		34	21
1759	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		35	21
1760	39373	MONITOR DE PRESSAO PULSO OMRON DIGITAL  HEM6181	1.000		36	21
1761	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		37	21
1762	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		33	22
1763	39373	MONITOR DE PRESSAO PULSO OMRON DIGITAL  HEM6181	1.000		34	22
1764	44180	KIT DE NEBULIZACAO C810 OMRON	1.000		35	22
1765	174505	SER BD 20ML S/AGULHA LUER SLIP UND	2.000		36	22
1766	31437	DERMAEX OLEO CICATRIZANTE 100ML	5.000		37	22
1767	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		38	22
1768	41106	MONITOR DE PRESSAO BRAÇO OMRON DIGITAL HEM7142	1.000		34	23
1769	42722	NEBULIZADOR INALAR COMPACT  C810 OMRON	2.000		35	23
1770	174505	SER BD 20ML S/AGULHA LUER SLIP UND	2.000		36	23
1771	31445	DERMAEX OLEO CICATRIZANTE 200ML	2.000		37	23
1772	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		38	23
1773	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	9.000		39	23
1774	44172	TERMOMETRO DIGITAL  DOMOTHERM TC01 BRANCO CARTELADO	3.000		34	24
1775	174505	SER BD 20ML S/AGULHA LUER SLIP UND	2.000		35	24
1776	31445	DERMAEX OLEO CICATRIZANTE 200ML	7.000		36	24
1777	31437	DERMAEX OLEO CICATRIZANTE 100ML	8.000		37	24
1778	787	MICRO NEBULIZADOR NS ADULTO	2.000		38	24
1779	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		39	24
1780	31445	DERMAEX OLEO CICATRIZANTE 200ML	10.000		33	25
1781	174505	SER BD 20ML S/AGULHA LUER SLIP UND	6.000		34	25
1782	31437	DERMAEX OLEO CICATRIZANTE 100ML	10.000		35	25
1783	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	6.000		36	25
1784	31445	DERMAEX OLEO CICATRIZANTE 200ML	10.000		33	26
1785	174505	SER BD 20ML S/AGULHA LUER SLIP UND	6.000		34	26
1786	31437	DERMAEX OLEO CICATRIZANTE 100ML	10.000		35	26
1787	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	6.000		36	26
1788	31445	DERMAEX OLEO CICATRIZANTE 200ML	3.000		34	27
1789	174505	SER BD 20ML S/AGULHA LUER SLIP UND	5.000		35	27
1790	180599	SER BD 10ML S/AGULHA LUER LOCK UND	2.000		36	27
1791	31437	DERMAEX OLEO CICATRIZANTE 100ML	4.000		37	27
1792	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	3.000		38	27
1793	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		39	27
1794	124	ALGODAO APOLO 50GR C/ 20UNID PACK***************	1.000		40	27
1795	183946	SORO FISIOL. ARBORETO 100ML 24UN	1.000		34	28
1796	183954	SORO FISIOL. ARBORETO 250ML 24UN	1.000		35	28
1797	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	3.000		36	28
1798	31445	DERMAEX OLEO CICATRIZANTE 200ML	9.000		37	28
1799	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		38	28
1800	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		33	29
1801	182940	LUVA P/PROCED MEDIX GDE 100UN	6.000		33	30
1802	182958	LUVA P/PROCED MEDIX MED 100UN	6.000		34	30
1803	182966	LUVA P/PROCED MEDIX PEQ 100UN	3.000		35	30
1804	906	SER BD SOLOMED 5ML AG 0,70X25 22G 100UN-630	1.000		36	30
1805	41041	AGULHA DESC BD 0,60X25 INTRAMUSCULAR CX C/100UN	1.000		37	30
1806	180599	SER BD 10ML S/AGULHA LUER LOCK UND	100.000		38	30
1807	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	1.000		39	30
1808	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	2.000		33	31
1809	29815	TIRAS GTECH FREE 1 C/50 UNIDS	3.000		34	31
1810	29823	TIRAS GTECH FREE LITE C/50 UNIDS	3.000		35	31
1811	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		36	31
1812	40762	AUTO LANCETA GTECH 28G C/ 100 UNID	4.000		37	31
1813	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	12.000		38	31
1814	1171	SER BD SOLOMED 5ML AG 0,70X30 22G 100UN-631	2.000		31	32
1815	43494	LUVA LATEX TOP NUGARD C/PO TAM G C/100 UNID	2.000		35	33
1816	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		36	33
1817	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	6.000		37	33
1818	42935	LUVA MEDIX CIR. TAM 6,5 PAR	6.000		38	33
1819	42943	LUVA MEDIX CIR. TAM 7,0 PAR	6.000		39	33
1820	42960	LUVA MEDIX CIR. TAM 8,5 PAR	6.000		40	33
1821	43478	LUVA LATEX  TOP NUGARD C/PO TAM P C/100 UNID	2.000		41	33
1822	43486	LUVA LATEX  TOP NUGARD C/PO TAM M C/100 UNID	3.000		42	33
1823	44202	LUVA MEDIX CIR. TAM 8,0 PAR	6.000		43	33
1824	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	6.000		44	33
3692	28207	CURATIVO CREMERCARE TRANSP C/10UN	12.000		32	261
3693	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	3.000		33	261
3694	34851	ESPARADRAPO SALVELOX 1,2CMX4,5M UNIT	12.000		34	261
3695	175	ATADURA CREPON CREMER CYSNE 8CM  C/6 PACK*************	3.000		35	261
3696	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	6.000		36	261
3697	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	6.000		37	261
3698	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		38	261
1833	28169	CURATIVO CREMERCARE BEGE 10UND	12.000		31	35
1834	33812	OLEO A.G.E.GIRASSOL ALMOT.FARMAX 200ML	9.000		32	35
1835	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		33	36
1836	30678	VASELINA VASEMAX LIQ.FARMAX 100ML	3.000		37	37
1837	33812	OLEO A.G.E.GIRASSOL ALMOT.FARMAX 200ML	3.000		38	37
1838	36790	JOELHEIRA COM ORIFÍCIO PRETO M KSN036	2.000		39	37
1839	30465	OLEO RICINO PURO FARMAX 100ML	6.000		40	37
1840	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		41	37
1841	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		42	37
1842	30422	SOLUÇÃO ANTIMICOTICA IODO FARMAX 30ML	6.000		43	37
1843	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	1.000		44	37
1844	906	SER BD SOLOMED 5ML AG 0,70X25 22G 100UN-630	1.000		45	37
1845	213	ATADURA CREPON CREMER CYSNE 20CM UNIT	6.000		46	37
1846	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		33	38
1847	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		34	38
1848	38512	COMP. Ñ ADER.SANFARMA EST 40X10	3.000		35	38
1849	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	2.000		31	39
1850	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	3.000		31	40
1851	44202	LUVA MEDIX CIR. TAM 8,0 PAR	12.000		35	41
1852	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	12.000		36	41
1853	42960	LUVA MEDIX CIR. TAM 8,5 PAR	12.000		37	41
1854	34703	MASCARA DESC TRIPLA C/ELASTICO MEDIX 22G BR C/50UND	12.000		38	41
1855	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		39	41
1856	31437	DERMAEX OLEO CICATRIZANTE 100ML	12.000		40	41
1857	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	1.000		35	42
1858	42463	SOLUÇAO DE MANITOL 20% EQUIPLEX 250ML	6.000		36	42
1859	43486	LUVA LATEX  TOP NUGARD C/PO TAM M C/100 UNID	3.000		37	42
1860	43494	LUVA LATEX TOP NUGARD C/PO TAM G C/100 UNID	2.000		38	42
1861	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		39	42
1862	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		40	42
1863	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		41	42
1864	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	12.000		42	42
1865	44172	TERMOMETRO DIGITAL  DOMOTHERM TC01 BRANCO CARTELADO	3.000		34	43
1866	174505	SER BD 20ML S/AGULHA LUER SLIP UND	3.000		35	43
1867	180599	SER BD 10ML S/AGULHA LUER LOCK UND	4.000		36	43
1868	31445	DERMAEX OLEO CICATRIZANTE 200ML	5.000		37	43
1869	42722	NEBULIZADOR INALAR COMPACT  C810 OMRON	1.000		38	43
1870	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		39	43
1871	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	8.000		40	43
1872	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		41	43
1873	162388	SER BD INS 100UI AG 6MM 10X10UN - 918	1.000		42	43
1874	44172	TERMOMETRO DIGITAL  DOMOTHERM TC01 BRANCO CARTELADO	3.000		35	44
1875	174505	SER BD 20ML S/AGULHA LUER SLIP UND	6.000		36	44
1876	31445	DERMAEX OLEO CICATRIZANTE 200ML	3.000		37	44
1877	31437	DERMAEX OLEO CICATRIZANTE 100ML	10.000		38	44
1878	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	6.000		39	44
1879	787	MICRO NEBULIZADOR NS ADULTO	1.000		40	44
1880	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		32	45
1881	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		33	45
1882	174505	SER BD 20ML S/AGULHA LUER SLIP UND	3.000		34	45
2394	43400	KIT PARA COLETA DE URINA C/1 TUBO SAQUINHO  3B UNIT	50.000		62	115
2395	132500	COLETOR UNIVERSAL DESPACK 70 ML S/CX 100UN	1.000		63	115
1888	213	ATADURA CREPON CREMER CYSNE 20CM UNIT	6.000		32	47
1889	33812	OLEO A.G.E.GIRASSOL ALMOT.FARMAX 200ML	6.000		33	47
1890	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		34	47
1891	30287	MUNHEQUEIRA C/TALA AJUST.BIL.PRETA KSN011	1.000		42	48
1892	31046	MUNHEQUEIRA ELAST .AJUST.PRETA KSN064	2.000		43	48
1893	335720	PERMASSIM CAIXA C/ 500 CP	1.000		44	48
1894	38512	COMP. Ñ ADER.SANFARMA EST 40X10	2.000		45	48
1895	41050	AGULHA DESC BD 0,60X30 INTRAMUSCULAR CX C/100UN	1.000		46	48
1896	174505	SER BD 20ML S/AGULHA LUER SLIP UND	10.000		47	48
1897	180599	SER BD 10ML S/AGULHA LUER LOCK UND	10.000		48	48
1898	182427	ESPARADRAPO BRANCO CREMER 5,0CMX4,5M	6.000		49	48
1899	37826	MUNHEQUEIRA AJUSTAVEL NEOSOFT KSN071	1.000		50	48
1900	37737	CURATIVO JOELHO/COTOVELO CREMER C/06	3.000		51	48
1901	37710	CURATIVOS VARIADOS 6 FORM. 30UN CREMER	6.000		52	48
1902	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	6.000		53	48
1903	30660	GLICERINA PURA COSMETICA FARMAX 100ML	6.000		54	48
1904	31399	AGULHA P/CANETA 4MM NANO PENTAPOINT EASYFLOW 100UND	1.000		55	48
1905	33812	OLEO A.G.E.GIRASSOL ALMOT.FARMAX 200ML	3.000		56	48
1906	33847	OLEO CAP/CORP.BABOSA FARMAX 100ML	6.000		57	48
1907	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	6.000		58	48
1908	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	3.000		59	48
1909	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	1.000		60	48
1910	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		61	48
2396	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	12.000		64	115
2397	174505	SER BD 20ML S/AGULHA LUER SLIP UND	20.000		65	115
2398	31437	DERMAEX OLEO CICATRIZANTE 100ML	48.000		33	116
2525	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	132
1911	30023	MUNHEQUEIRA AJUST.PRETA KSN010	2.000		35	49
1912	33871	OLEO CAP/CORP.COCO FARMAX 100ML	6.000		36	49
1913	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	3.000		37	49
1914	33812	OLEO A.G.E.GIRASSOL ALMOT.FARMAX 200ML	3.000		38	49
1915	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		39	49
3699	30457	OLEO RICINO PURO FARMAX 30ML	12.000		39	261
3700	30643	CLORETO DE MAGNESIO FARMAX 33GR	6.000		40	261
3701	34088	DUCHA GINECOLOGICA 12  SANITY	2.000		41	261
3702	34819	MICROPOROSA SALVELOX 1,2CMX4,5M	12.000		42	261
3703	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	12.000		43	261
3704	36145	COMPRESSA GAZE AMERICA REBECCA 9 FIOS C/500  UNIT	6.000		44	261
3705	183180	ESPAR MISSNER IMPERM 5,0CM X 4,5M	6.000		45	261
3706	183202	ESPAR MISSNER IMPERM 1,2CM X 4,5M	12.000		46	261
3707	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	6.000		47	261
1926	31046	MUNHEQUEIRA ELAST .AJUST.PRETA KSN064	2.000		39	51
1927	34703	MASCARA DESC TRIPLA C/ELASTICO MEDIX 22G BR C/50UND	6.000		40	51
1928	30678	VASELINA VASEMAX LIQ.FARMAX 100ML	3.000		41	51
1929	33847	OLEO CAP/CORP.BABOSA FARMAX 100ML	2.000		42	51
1930	30643	CLORETO DE MAGNESIO FARMAX 33GR	6.000		43	51
1931	30570	ALCOOL 70% FARMAX 50ML	36.000		44	51
1932	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		45	51
1933	30457	OLEO RICINO PURO FARMAX 30ML	12.000		46	51
1934	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		47	51
1935	30422	SOLUÇÃO ANTIMICOTICA IODO FARMAX 30ML	3.000		48	51
1936	37826	MUNHEQUEIRA AJUSTAVEL NEOSOFT KSN071	2.000		40	86
1937	43915	OLEO DE RICINO 30 ML UNIPHAR	6.000		41	86
1938	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	6.000		42	86
1939	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		43	86
1940	33065	OLEO CAP/CORP.AMENDOAS FARMAX 100ML	6.000		44	86
1941	33812	OLEO A.G.E.GIRASSOL ALMOT.FARMAX 200ML	3.000		45	86
1942	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		46	86
1943	31372	POVIDINE TOPICO SPRAY 30ML	3.000		47	86
1944	30570	ALCOOL 70% FARMAX 50ML	24.000		48	86
1945	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		49	86
1946	129020	PORTA COMPRIMIDOS DISCO SEMANAL  INCOTERM BRANCO UNIT	3.000		50	86
1947	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	1.000		51	86
1948	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		52	86
1949	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	1.000		35	52
1950	31372	POVIDINE TOPICO SPRAY 30ML	3.000		36	52
1951	30678	VASELINA VASEMAX LIQ.FARMAX 100ML	3.000		37	52
1952	30570	ALCOOL 70% FARMAX 50ML	36.000		38	52
1953	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	1.000		39	52
1954	612	ESPARADRAPO BRANCO CREMER 2,5CMX0,9M	150.000		40	53
1955	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	30.000		41	53
1956	31402	SORO FISIOL SORIMAX 100ML C/12UN PACK *************	10.000		42	53
1957	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	9.000		43	53
1958	28223	HASTES FLEXIVEIS CREMER  C/75   UNID.	56.000		44	53
1959	183962	SORO FISIOL. ARBORETO 500ML 24UN	100.000		129	54
1960	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	2.000		40	55
1961	31372	POVIDINE TOPICO SPRAY 30ML	6.000		41	55
1962	148300	AGULHA DESC BD 0,30X13 INTRAD/SUBC CX C/100UN	1.000		42	55
1963	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	2.000		43	55
1964	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	6.000		44	55
1965	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	6.000		45	55
1966	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	4.000		46	55
1967	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	12.000		47	55
1968	906	SER BD SOLOMED 5ML AG 0,70X25 22G 100UN-630	1.000		48	55
1969	787	MICRO NEBULIZADOR NS ADULTO	1.000		49	55
1970	1171	SER BD SOLOMED 5ML AG 0,70X30 22G 100UN-631	1.000		50	55
1971	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	2.000		33	56
1972	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	1.000		34	56
1973	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	1.000		34	57
1974	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		35	57
1975	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	3.000		36	57
1976	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	12.000		37	57
1977	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	1.000		33	58
1978	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		34	58
1979	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	12.000		35	58
1980	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	12.000		32	59
1981	40762	AUTO LANCETA GTECH 28G C/ 100 UNID	2.000		33	59
1982	30457	OLEO RICINO PURO FARMAX 30ML	12.000		34	59
1983	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	10.000		31	60
1984	35866	PERMANGANATO DE POTASSIO UNIPHAR 10 DOSES 100MG UNIT	2.000		33	61
1985	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	6.000		34	61
1986	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	3.000		35	61
1987	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	2.000		37	62
1988	35866	PERMANGANATO DE POTASSIO UNIPHAR 10 DOSES 100MG UNIT	3.000		38	62
1989	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		39	62
1990	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	6.000		40	62
1991	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	2.000		41	62
1992	29670	ALGODAO CREMER 50G C/10 UNID PACK***************	1.000		42	62
1993	183962	SORO FISIOL. ARBORETO 500ML 24UN	50.000		80	63
1994	38512	COMP. Ñ ADER.SANFARMA EST 40X10	3.000		33	64
1995	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		34	64
1996	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		35	64
1997	30686	VASELINA VASEMAX FARMAX 60GR	12.000		37	65
1998	44199	CLORETO DE MAGNESIO 33 GRS UNIPHAR	12.000		38	65
1999	30589	TINTURA DE IODO 2% FARMAX 30ML	6.000		39	65
2000	30694	VASELINA VASEMAX FARMAX 100GR	6.000		40	65
2001	30538	PEDRA HUME PURA PO FARMAX 20G	12.000		41	65
2002	30457	OLEO RICINO PURO FARMAX 30ML	12.000		42	65
2003	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		43	65
2004	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	2.000		44	65
2005	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	3.000		32	66
2006	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		33	66
2007	182940	LUVA P/PROCED MEDIX GDE 100UN	30.000		33	67
2008	28215	CURATIVO CREMERCARE TRANSP C/ 40UN	6.000		44	68
2009	34851	ESPARADRAPO SALVELOX 1,2CMX4,5M UNIT	6.000		45	68
2010	152706	ESPARADRAPO TRANSPARENTE CREMER 1,2CMX4,5M	6.000		46	68
2011	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		47	68
2012	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	12.000		48	68
2013	34835	ESPARADRAPO SALVELOX 2,5CMX4,5M	12.000		49	68
2014	34843	ESPARADRAPO SALVELOX 2,5CMX90CM UNIT	12.000		50	68
2015	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		51	68
2016	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		52	68
2017	22730	MICROPOROSA BRANCA CREMER 10CMX4,5M UNIT	6.000		53	68
2018	22748	MICROPOROSA BRANCA CREMER 2,5CMX0,9M	12.000		54	68
2019	22721	MICROPOROSA BRANCA CREMER 1,2CMX4,5M	12.000		55	68
2020	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		56	68
2021	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	12.000		57	68
2022	612	ESPARADRAPO BRANCO CREMER 2,5CMX0,9M	12.000		58	68
2023	213	ATADURA CREPON CREMER CYSNE 20CM UNIT	6.000		59	68
2024	175	ATADURA CREPON CREMER CYSNE 8CM  C/6 PACK*************	3.000		60	68
2025	152714	ESPARADRAPO TRANSPARENTE CREMER 2,5CMX4,5M UNIT	6.000		61	68
2026	28207	CURATIVO CREMERCARE TRANSP C/10UN	12.000		62	68
2027	182958	LUVA P/PROCED MEDIX MED 100UN	2.000		79	69
2028	182966	LUVA P/PROCED MEDIX PEQ 100UN	2.000		80	69
2029	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		81	69
2030	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	2.000		82	69
2031	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		83	69
2032	38946	ATADURA AMERICA 6CMX1.8M SOFT C/12 PACK****************	1.000		84	69
2033	38954	ATADURA AMERICA 8CMX1.8M SOFT C/12 PACK **************	1.000		85	69
2034	38997	ATADURA AMERICA 20CMX1.8M SOFT UNIT	6.000		86	69
2035	39004	ATADURA AMERICA 25CMX1.8M SOFT UNIT	6.000		87	69
2036	39012	ATADURA  AMERICA 30CMX1.8M SOFT UNIT	6.000		88	69
2037	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	2.000		89	69
2038	40002	HASTES SEGURANÇA PATRULHA CANINA TOPZ 50UN	3.000		90	69
2039	42242	ALCOOL PRING BACTERICIDA ZERO 46% CX COM 12 UNID	1.000		91	69
2040	43338	CURATIVO C/ 10 MICKEY E MINNIE SANFARMA	3.000		92	69
2041	43796	LUVA LATEX SOFT AID C/PO TAM M C/20	2.000		93	69
2042	43800	LUVA LATEX SOFT AID C/PO TAM P C/20	2.000		94	69
2043	43818	LUVA LATEX SOFT AID C/PO TAM G C/20	2.000		95	69
2044	182427	ESPARADRAPO BRANCO CREMER 5,0CMX4,5M	12.000		96	69
2045	39853	ESPARADRAPO BEGE CREMER 1,2CMX3,00	12.000		97	69
2046	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		98	69
2047	38750	SERINGA 5ML S/AG LUER LOCK C/100UN MEDIX *************	1.000		99	69
2048	38830	COLETOR PERFURO-CORTANTE 13L MEDIX UNIT	3.000		100	69
2049	37834	JOELHEIRA AJUSTAVEL NEOSOFT KSN076	1.000		101	69
2050	38326	CURATIVOS CREMER PATRULHA CANINA C/10 UNID	3.000		102	69
2051	31445	DERMAEX OLEO CICATRIZANTE 200ML	3.000		103	69
2052	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	2.000		104	69
2053	31437	DERMAEX OLEO CICATRIZANTE 100ML	3.000		105	69
2054	30686	VASELINA VASEMAX FARMAX 60GR	3.000		106	69
2055	30678	VASELINA VASEMAX LIQ.FARMAX 100ML	3.000		107	69
2056	30643	CLORETO DE MAGNESIO FARMAX 33GR	2.000		108	69
2057	30570	ALCOOL 70% FARMAX 50ML	24.000		109	69
2058	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		110	69
2059	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	3.000		111	69
2060	30430	BICARBONATO SODIO FARMAX POTE 100GR	6.000		112	69
2061	30473	SAL AMARGO MED. POTE FARMAX 30G	2.000		113	69
2062	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		114	69
2063	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	2.000		115	69
2064	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	2.000		116	69
2065	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	1.000		117	69
2066	182940	LUVA P/PROCED MEDIX GDE 100UN	2.000		118	69
2067	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	12.000		119	69
2068	612	ESPARADRAPO BRANCO CREMER 2,5CMX0,9M	12.000		120	69
2069	22730	MICROPOROSA BRANCA CREMER 10CMX4,5M UNIT	6.000		121	69
2070	22748	MICROPOROSA BRANCA CREMER 2,5CMX0,9M	12.000		122	69
2071	22721	MICROPOROSA BRANCA CREMER 1,2CMX4,5M	24.000		123	69
2072	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		124	69
2073	28207	CURATIVO CREMERCARE TRANSP C/10UN	8.000		125	69
2074	38954	ATADURA AMERICA 8CMX1.8M SOFT C/12 PACK **************	1.000		40	70
2075	37761	MICROPOROSA BEGE SALVELOX 2,5CMX4,5M	12.000		41	70
2076	34703	MASCARA DESC TRIPLA C/ELASTICO MEDIX 22G BR C/50UND	6.000		42	70
2077	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		43	70
2078	30660	GLICERINA PURA COSMETICA FARMAX 100ML	12.000		44	70
2079	30570	ALCOOL 70% FARMAX 50ML	24.000		45	70
2080	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		46	70
2081	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	6.000		47	70
2082	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		48	70
2083	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		49	70
2084	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		50	70
2085	44172	TERMOMETRO DIGITAL  DOMOTHERM TC01 BRANCO CARTELADO	48.000		32	71
2086	44172	TERMOMETRO DIGITAL  DOMOTHERM TC01 BRANCO CARTELADO	48.000		32	72
2087	29971	COMPRESSA GAZE AMERICA HERIKA 13 FIOS 440X10 CX ********	3.000		33	73
2088	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		32	74
2089	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	3.000		33	74
2090	36145	COMPRESSA GAZE AMERICA REBECCA 9 FIOS C/500  UNIT	4.000		32	75
2091	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	12.000		33	75
2092	30406	FARMAIODINE TOPICO ALMOT.FARMAX 100ML	6.000		32	76
2093	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	12.000		33	76
2094	36145	COMPRESSA GAZE AMERICA REBECCA 9 FIOS C/500  UNIT	3.000		34	76
2095	29670	ALGODAO CREMER 50G C/10 UNID PACK***************	2.000		35	76
2096	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	12.000		32	77
2097	30538	PEDRA HUME PURA PO FARMAX 20G	6.000		33	77
2098	38512	COMP. Ñ ADER.SANFARMA EST 40X10	3.000		34	77
2099	39160	VASELINA VASEMAX  FARMAX 70G	6.000		35	77
2100	175	ATADURA CREPON CREMER CYSNE 8CM  C/6 PACK*************	2.000		36	77
2101	221	ATADURA CREPON CREMER CYSNE 25CM UNIT	6.000		37	77
2102	36374	CURATIVO EXTRA GRANDE XXG 08UN CREMER	6.000		32	78
2103	39160	VASELINA VASEMAX  FARMAX 70G	6.000		33	78
2104	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		34	78
2105	22748	MICROPOROSA BRANCA CREMER 2,5CMX0,9M	6.000		35	78
2106	152714	ESPARADRAPO TRANSPARENTE CREMER 2,5CMX4,5M UNIT	6.000		36	78
2107	28169	CURATIVO CREMERCARE BEGE 10UND	6.000		32	79
2108	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	12.000		33	79
2109	30589	TINTURA DE IODO 2% FARMAX 30ML	6.000		34	79
2110	36374	CURATIVO EXTRA GRANDE XXG 08UN CREMER	6.000		35	79
2111	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		36	79
2112	221	ATADURA CREPON CREMER CYSNE 25CM UNIT	12.000		37	79
2113	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	2.000		31	80
2114	29815	TIRAS GTECH FREE 1 C/50 UNIDS	4.000		32	81
2115	30511	ALCOOL GEL 70% FARMAX 50GR	12.000		33	81
2116	30554	REMOVEDOR ESMALTE C/ACET.FARMAX 100ML C/12 PACK*******	5.000		34	81
2117	39160	VASELINA VASEMAX  FARMAX 70G	6.000		35	81
2118	39357	VASELINA VASEMAX  FARMAX  25 GR	6.000		36	81
2119	1171	SER BD SOLOMED 5ML AG 0,70X30 22G 100UN-631	1.000		37	81
2120	38954	ATADURA AMERICA 8CMX1.8M SOFT C/12 PACK **************	2.000		33	82
2121	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		34	82
2122	30570	ALCOOL 70% FARMAX 50ML	24.000		35	82
2123	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	12.000		36	82
2124	36145	COMPRESSA GAZE AMERICA REBECCA 9 FIOS C/500  UNIT	3.000		37	82
2125	42820	COLETOR UNIVERSAL SAQUINHO  80ML TRANSLUCIDO PCT C/100 ***	1.000		38	82
2126	39381	OXIMETRO PULSO DEDO MEDLEVENSOHN	1.000		34	83
2127	182958	LUVA P/PROCED MEDIX MED 100UN	12.000		35	83
2128	182966	LUVA P/PROCED MEDIX PEQ 100UN	6.000		36	83
2129	43907	ALCOOL 70% SPRAY 50 ML UNIPHAR	12.000		37	83
2130	182940	LUVA P/PROCED MEDIX GDE 100UN	10.000		38	83
2131	42463	SOLUÇAO DE MANITOL 20% EQUIPLEX 250ML	6.000		39	83
2132	42943	LUVA MEDIX CIR. TAM 7,0 PAR	6.000		40	83
2133	42951	LUVA MEDIX CIR. TAM 7,5 PAR	6.000		41	83
2134	43478	LUVA LATEX  TOP NUGARD C/PO TAM P C/100 UNID	6.000		42	83
2135	43486	LUVA LATEX  TOP NUGARD C/PO TAM M C/100 UNID	12.000		43	83
2136	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	5.000		35	84
2137	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	5.000		35	85
2138	42463	SOLUÇAO DE MANITOL 20% EQUIPLEX 250ML	24.000		31	87
2139	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		36	34
2140	33812	OLEO A.G.E.GIRASSOL ALMOT.FARMAX 200ML	3.000		37	34
2141	30686	VASELINA VASEMAX FARMAX 60GR	3.000		38	34
2142	30643	CLORETO DE MAGNESIO FARMAX 33GR	6.000		39	34
2143	1171	SER BD SOLOMED 5ML AG 0,70X30 22G 100UN-631	1.000		40	34
2144	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	6.000		41	34
2145	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	2.000		42	34
2146	182940	LUVA P/PROCED MEDIX GDE 100UN	3.000		43	34
2147	35874	VASELINA SOLIDA BISNAGA UNIPHAR 25G UNIT	6.000		38	88
2148	40355	PASSA FEBRE MUNILA CX COM 2 SACHET	4.000		39	88
2149	30023	MUNHEQUEIRA AJUST.PRETA KSN010	2.000		40	88
2150	31143	JOELHEIRA LONGA LISA PRETA M KSN035	1.000		41	88
2151	30570	ALCOOL 70% FARMAX 50ML	12.000		42	88
2152	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		43	88
2153	30406	FARMAIODINE TOPICO ALMOT.FARMAX 100ML	4.000		44	88
2154	29661	ALGODAO CREMER 25G C/20 UNID PACK**************	1.000		45	88
2155	38512	COMP. Ñ ADER.SANFARMA EST 40X10	2.000		34	46
2156	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	6.000		35	46
2157	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	6.000		36	46
2158	33812	OLEO A.G.E.GIRASSOL ALMOT.FARMAX 200ML	3.000		37	46
2159	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		38	46
2160	30309	JOELHEIRA LONGA C/ORIF.REF.PRETA G KSN002	2.000		40	50
2161	30325	JOELHEIRA LONGA C/ORIF.REF.PRETA M KSN002	2.000		41	50
2162	30350	JOELHEIRA CURTA PRETA M KSN034	2.000		42	50
2163	42463	SOLUÇAO DE MANITOL 20% EQUIPLEX 250ML	12.000		43	50
2164	31372	POVIDINE TOPICO SPRAY 30ML	3.000		44	50
2165	33812	OLEO A.G.E.GIRASSOL ALMOT.FARMAX 200ML	3.000		45	50
2166	33847	OLEO CAP/CORP.BABOSA FARMAX 100ML	6.000		46	50
2167	30600	OLEO MINERAL NATUROL MED. FARMAX 100ML	6.000		47	50
2168	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		48	50
2169	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	1.000		49	50
2235	34835	ESPARADRAPO SALVELOX 2,5CMX4,5M	12.000		32	96
2236	43494	LUVA LATEX TOP NUGARD C/PO TAM G C/100 UNID	3.000		33	96
2237	30570	ALCOOL 70% FARMAX 50ML	12.000		34	96
2238	30660	GLICERINA PURA COSMETICA FARMAX 100ML	12.000		35	96
2239	39160	VASELINA VASEMAX  FARMAX 70G	3.000		36	96
2240	43478	LUVA LATEX  TOP NUGARD C/PO TAM P C/100 UNID	3.000		37	96
2241	43486	LUVA LATEX  TOP NUGARD C/PO TAM M C/100 UNID	6.000		38	96
2242	43796	LUVA LATEX SOFT AID C/PO TAM M C/20	3.000		39	96
2243	43800	LUVA LATEX SOFT AID C/PO TAM P C/20	3.000		40	96
2244	43818	LUVA LATEX SOFT AID C/PO TAM G C/20	3.000		41	96
2245	138410	FITA FRALDA CREMER ROSA	3.000		42	96
2399	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		34	116
2400	38946	ATADURA AMERICA 6CMX1.8M SOFT C/12 PACK****************	2.000		35	117
2401	38954	ATADURA AMERICA 8CMX1.8M SOFT C/12 PACK **************	2.000		36	117
2402	221	ATADURA CREPON CREMER CYSNE 25CM UNIT	6.000		37	117
2403	230	ATADURA CREPON CREMER CYSNE 30CM UNIT	6.000		38	117
2404	787	MICRO NEBULIZADOR NS ADULTO	1.000		39	117
2405	3964	MANTEIGA CACAU LIQUIDA ROLL ON 10ML DISPLAY C/24UN BRAVIR	2.000		40	117
2406	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		41	117
2407	30473	SAL AMARGO MED. POTE FARMAX 30G	2.000		42	117
2408	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		43	117
2409	30589	TINTURA DE IODO 2% FARMAX 30ML	2.000		44	117
2410	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		31	118
2411	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	3.000		32	118
2412	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	3.000		33	118
2413	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		34	118
2414	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		35	118
2415	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		36	118
2416	30538	PEDRA HUME PURA PO FARMAX 20G	3.000		37	118
2417	30740	SOLUÇÃO DE AMÔNIA FARMAX 100ML C/12 PACK****************	1.000		38	118
2418	31437	DERMAEX OLEO CICATRIZANTE 100ML	12.000		39	118
2419	31445	DERMAEX OLEO CICATRIZANTE 200ML	12.000		40	118
2420	34843	ESPARADRAPO SALVELOX 2,5CMX90CM UNIT	12.000		41	118
2421	40029	ESPARADRAPO SALVELOX 10CMX3M UN	3.000		42	118
2422	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		34	119
2423	124	ALGODAO APOLO 50GR C/ 20UNID PACK***************	1.000		35	119
2424	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	1.000		36	119
2425	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	2.000		33	120
2426	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		34	120
2427	28169	CURATIVO CREMERCARE BEGE 10UND	12.000		35	120
2428	28177	CURATIVO CREMERCARE BEGE 40UND	6.000		36	120
2429	28207	CURATIVO CREMERCARE TRANSP C/10UN	12.000		37	120
2430	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	4.000		38	120
2431	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		39	120
2432	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	3.000		40	120
2433	35866	PERMANGANATO DE POTASSIO UNIPHAR 10 DOSES 100MG UNIT	6.000		41	120
2434	39160	VASELINA VASEMAX  FARMAX 70G	4.000		42	120
2435	40894	LANCETA PARA LANCETADOR C/100 NID MEDLEVENSOHN ML03 28G	3.000		43	120
2436	43907	ALCOOL 70% SPRAY 50 ML UNIPHAR	12.000		44	120
2437	28215	CURATIVO CREMERCARE TRANSP C/ 40UN	3.000		36	121
2438	140074	RIODEINE DERMO SUAVE RIOQUIMICA ALM.100ML	6.000		37	121
2439	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		38	121
2440	40746	ESPARADRAPO BRANCO MULTILASER 10CMX4,5M UNIT	6.000		39	121
2441	612	ESPARADRAPO BRANCO CREMER 2,5CMX0,9M	12.000		40	121
2442	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	6.000		41	121
2443	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	6.000		42	121
2762	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	3.000		31	177
2763	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	3.000		31	178
2764	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	3.000		31	179
2765	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	3.000		31	180
2766	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		36	181
2767	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		37	181
2768	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	6.000		38	181
2769	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	6.000		39	181
2770	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	2.000		40	181
2771	1350	POVIDINE TOPICO ALMOTOLIA 100ML	4.000		41	181
2772	22721	MICROPOROSA BRANCA CREMER 1,2CMX4,5M	6.000		42	181
2773	28169	CURATIVO CREMERCARE BEGE 10UND	3.000		43	181
2774	30465	OLEO RICINO PURO FARMAX 100ML	2.000		44	181
2775	30627	ALCOOL GEL 70% FARMAX 430GR	2.000		45	181
2776	34924	ATADURA GESSADA CYSNE 15CM UNIT	3.000		46	181
2777	37702	CURATIVO MARROM ESCURO CREMER  C/10	3.000		47	181
2778	37710	CURATIVOS VARIADOS 6 FORM. 30UN CREMER	3.000		48	181
2779	38326	CURATIVOS CREMER PATRULHA CANINA C/10 UNID	3.000		49	181
2780	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		50	181
2781	182427	ESPARADRAPO BRANCO CREMER 5,0CMX4,5M	4.000		51	181
2782	183229	FITA MICROPOROSA MISSNER 10,0CM X 4,5M	3.000		52	181
2783	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	6.000		53	181
2784	183245	FITA MICROPOROSA MISSNER 2,5CM X 4,5M	3.000		54	181
2785	183261	FITA MICROPOROSA MISSNER 2,5CM X 0,9M	6.000		55	181
2786	183695	CURATIVO CICATRISAN  BEGE10 UND	3.000		56	181
2787	29823	TIRAS GTECH FREE LITE C/50 UNIDS	2.000		31	182
2788	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	6.000		32	182
2789	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	1.000		31	183
2790	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		32	183
2791	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	18.000		31	184
2792	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		34	185
2793	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		35	185
2794	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	1.000		31	186
2795	1171	SER BD SOLOMED 5ML AG 0,70X30 22G 100UN-631	1.000		32	186
2796	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		33	186
2797	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	12.000		34	186
2798	37761	MICROPOROSA BEGE SALVELOX 2,5CMX4,5M	12.000		35	186
2799	40029	ESPARADRAPO SALVELOX 10CMX3M UN	6.000		36	186
2800	138509	MICROPOROSA BEGE CREMER 10CMX4,5M	3.000		37	186
2801	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	3.000		33	187
2802	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	2.000		36	188
2803	38962	ATADURA AMERICA 10CMX1.8M SOFT C/12 PACK ***************	1.000		37	188
2804	38970	ATADURA AMERICA 12CMX1.8M SOFT C/12 PACK ***************	1.000		38	188
2805	38954	ATADURA AMERICA 8CMX1.8M SOFT C/12 PACK **************	4.000		39	188
2806	29793	KIT MEDIDOR DE GLICOSE GTECH LITE COMPLETO	1.000		40	188
2807	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		41	188
2808	31437	DERMAEX OLEO CICATRIZANTE 100ML	8.000		42	188
2809	37729	PROTETOR OCULAR ADULTO BEGE C/ 12 UNID	6.000		43	188
2810	39357	VASELINA VASEMAX  FARMAX  25 GR	8.000		44	188
2811	43389	PROTETOR OCULAR MICKEY E AMIGOS P 10 UNID	3.000		45	188
2812	43397	PROTETOR OCULAR MICKEY E MINNIE P 10 UNID	3.000		46	188
2813	132500	COLETOR UNIVERSAL DESPACK 70 ML S/CX 100UN	1.000		47	188
2814	41599	ATADURA ELASTICA  AUTOADERENTE K-PRO LISMED 10CM X 2,0M UNIT	3.000		34	189
2815	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		35	189
2816	22721	MICROPOROSA BRANCA CREMER 1,2CMX4,5M	12.000		36	189
2817	22730	MICROPOROSA BRANCA CREMER 10CMX4,5M UNIT	6.000		37	189
2818	22748	MICROPOROSA BRANCA CREMER 2,5CMX0,9M	12.000		38	189
2819	28169	CURATIVO CREMERCARE BEGE 10UND	24.000		39	189
2820	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		40	189
2821	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		41	189
2822	30406	FARMAIODINE TOPICO ALMOT.FARMAX 100ML	6.000		42	189
2823	30414	CLOREXIDINA 1% ANTISSEP.FARMAX 30ML	6.000		43	189
2824	30554	REMOVEDOR ESMALTE C/ACET.FARMAX 100ML C/12 PACK*******	2.000		44	189
2825	30570	ALCOOL 70% FARMAX 50ML	12.000		45	189
2826	30660	GLICERINA PURA COSMETICA FARMAX 100ML	12.000		46	189
2827	31372	POVIDINE TOPICO SPRAY 30ML	3.000		47	189
2828	31402	SORO FISIOL SORIMAX 100ML C/12UN PACK *************	2.000		48	189
2829	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		49	189
2830	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	12.000		50	189
2831	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		51	189
2832	41017	FARMAIODINE TOPICO SPRAY FARMAX 30 ML	6.000		52	189
2833	30376	AGUA OXIGENADA FARMAX 10VOL 1LT	6.000		60	190
2834	29971	COMPRESSA GAZE AMERICA HERIKA 13 FIOS 440X10 CX ********	1.000		61	190
2835	38954	ATADURA AMERICA 8CMX1.8M SOFT C/12 PACK **************	3.000		62	190
2836	38997	ATADURA AMERICA 20CMX1.8M SOFT UNIT	24.000		63	190
2837	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		64	190
2838	28169	CURATIVO CREMERCARE BEGE 10UND	24.000		65	190
2919	30511	ALCOOL GEL 70% FARMAX 50GR	12.000		47	195
2839	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		66	190
2840	30414	CLOREXIDINA 1% ANTISSEP.FARMAX 30ML	6.000		67	190
2841	37710	CURATIVOS VARIADOS 6 FORM. 30UN CREMER	12.000		68	190
2842	38512	COMP. Ñ ADER.SANFARMA EST 40X10	2.000		69	190
2843	30023	MUNHEQUEIRA AJUST.PRETA KSN010	2.000		35	191
2844	30287	MUNHEQUEIRA C/TALA AJUST.BIL.PRETA KSN011	2.000		36	191
2845	1961	MANTEIGA CACAU BATOM LUXO 3,3GR C/50UN BRAVIR	1.000		37	191
2846	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		38	191
2847	30570	ALCOOL 70% FARMAX 50ML	12.000		39	191
2848	31445	DERMAEX OLEO CICATRIZANTE 200ML	3.000		40	191
2849	37842	TORNOZELEIRA AJUSTAVEL NEOSOFT KSN073	2.000		41	191
2850	42307	CURATIVO TRADICIONAL SALVELOX C/10 UNID	12.000		42	191
2851	43338	CURATIVO C/ 10 MICKEY E MINNIE SANFARMA	10.000		43	191
2852	28177	CURATIVO CREMERCARE BEGE 40UND	6.000		75	192
2853	28215	CURATIVO CREMERCARE TRANSP C/ 40UN	6.000		76	192
2854	30376	AGUA OXIGENADA FARMAX 10VOL 1LT	6.000		77	192
2855	30511	ALCOOL GEL 70% FARMAX 50GR	24.000		78	192
2856	36943	ATADURA CREPON CREMER MAX PRESS 15CM C/6 PACK************	12.000		79	192
2857	38946	ATADURA AMERICA 6CMX1.8M SOFT C/12 PACK****************	2.000		80	192
2858	38954	ATADURA AMERICA 8CMX1.8M SOFT C/12 PACK **************	3.000		81	192
2859	38997	ATADURA AMERICA 20CMX1.8M SOFT UNIT	24.000		82	192
2860	39004	ATADURA AMERICA 25CMX1.8M SOFT UNIT	12.000		83	192
2861	612	ESPARADRAPO BRANCO CREMER 2,5CMX0,9M	12.000		84	192
2862	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	12.000		85	192
2863	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		86	192
2864	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		87	192
2865	22721	MICROPOROSA BRANCA CREMER 1,2CMX4,5M	12.000		88	192
2866	22730	MICROPOROSA BRANCA CREMER 10CMX4,5M UNIT	6.000		89	192
2867	22748	MICROPOROSA BRANCA CREMER 2,5CMX0,9M	12.000		90	192
2868	28169	CURATIVO CREMERCARE BEGE 10UND	12.000		91	192
2869	28207	CURATIVO CREMERCARE TRANSP C/10UN	12.000		92	192
2870	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		93	192
2871	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		94	192
2872	30414	CLOREXIDINA 1% ANTISSEP.FARMAX 30ML	6.000		95	192
2873	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		96	192
2874	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	12.000		97	192
2875	30570	ALCOOL 70% FARMAX 50ML	24.000		98	192
2876	30627	ALCOOL GEL 70% FARMAX 430GR	6.000		99	192
2877	30660	GLICERINA PURA COSMETICA FARMAX 100ML	6.000		100	192
2878	31372	POVIDINE TOPICO SPRAY 30ML	3.000		101	192
2879	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	12.000		102	192
2880	34819	MICROPOROSA SALVELOX 1,2CMX4,5M	12.000		103	192
2881	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	12.000		104	192
2882	36145	COMPRESSA GAZE AMERICA REBECCA 9 FIOS C/500  UNIT	12.000		105	192
2883	36196	ESPARADRAPO TRANSPARENTE CREMER 10CMX4,5M UNIT	6.000		106	192
2884	38512	COMP. Ñ ADER.SANFARMA EST 40X10	2.000		107	192
2885	42293	CURATIVO TRADICIONAL SALVELOX C/35 UNID	12.000		108	192
2886	182427	ESPARADRAPO BRANCO CREMER 5,0CMX4,5M	12.000		109	192
2887	183180	ESPAR MISSNER IMPERM 5,0CM X 4,5M	12.000		110	192
2888	183199	ESPAR MISSNER IMPERM 2,5CM X 4,5M	12.000		111	192
2889	183202	ESPAR MISSNER IMPERM 1,2CM X 4,5M	12.000		112	192
2890	183210	ESPAR MISSNER IMPERM 2,5CM X 0,9M	12.000		113	192
2891	183229	FITA MICROPOROSA MISSNER 10,0CM X 4,5M	3.000		114	192
2892	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	12.000		115	192
2893	183261	FITA MICROPOROSA MISSNER 2,5CM X 0,9M	12.000		116	192
2894	30511	ALCOOL GEL 70% FARMAX 50GR	12.000		31	193
2895	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		32	193
2896	30635	BICARBONATO SODIO FARMAX CX  50GRS	12.000		33	193
2897	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		34	193
2898	183199	ESPAR MISSNER IMPERM 2,5CM X 4,5M	12.000		35	193
2899	183229	FITA MICROPOROSA MISSNER 10,0CM X 4,5M	12.000		36	193
2900	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	12.000		37	193
2901	183245	FITA MICROPOROSA MISSNER 2,5CM X 4,5M	12.000		38	193
2902	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		31	194
2903	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	3.000		32	194
2904	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		33	194
2905	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		34	194
2906	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		35	194
2907	30538	PEDRA HUME PURA PO FARMAX 20G	6.000		36	194
2908	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	12.000		37	194
2909	30570	ALCOOL 70% FARMAX 50ML	12.000		38	194
2910	30678	VASELINA VASEMAX LIQ.FARMAX 100ML	12.000		39	194
2911	34819	MICROPOROSA SALVELOX 1,2CMX4,5M	12.000		40	194
2912	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		41	194
2913	39357	VASELINA VASEMAX  FARMAX  25 GR	12.000		42	194
2914	132500	COLETOR UNIVERSAL DESPACK 70 ML S/CX 100UN	1.000		43	194
2915	38954	ATADURA AMERICA 8CMX1.8M SOFT C/12 PACK **************	1.000		43	195
2916	39004	ATADURA AMERICA 25CMX1.8M SOFT UNIT	12.000		44	195
2917	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	2.000		45	195
2918	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	2.000		46	195
2920	30554	REMOVEDOR ESMALTE C/ACET.FARMAX 100ML C/12 PACK*******	1.000		48	195
2921	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	2.000		49	195
2922	31372	POVIDINE TOPICO SPRAY 30ML	4.000		50	195
2923	31437	DERMAEX OLEO CICATRIZANTE 100ML	4.000		51	195
2924	33774	SAB.LIQ.ESF.MORANGO HIDRADERM FARMAX 180ML	2.000		52	195
2925	33901	SAB.LIQ.ESF.ERVA DOCE HIDRADERM FARMAX 180ML	2.000		53	195
2926	34703	MASCARA DESC TRIPLA C/ELASTICO MEDIX 22G BR C/50UND	4.000		54	195
2927	35645	OLEO ROSA MOSQUETA PURO FARMAX 30ML	2.000		55	195
2928	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		56	195
2929	38814	COLETOR PERFURO-CORTANTE 3.0L MEDIX UNIT	4.000		57	195
2930	42048	SAB.LIQ.ESF CAMOMILA HIDRADERM FARMAX 180ML@@@	2.000		58	195
2931	42056	SAB.LIQ.ESF.MARACUJA HIDRADERM FARMAX 180ML @@@	2.000		59	195
2932	22748	MICROPOROSA BRANCA CREMER 2,5CMX0,9M	12.000		31	196
2933	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		32	196
2934	31402	SORO FISIOL SORIMAX 100ML C/12UN PACK *************	2.000		33	196
2935	31445	DERMAEX OLEO CICATRIZANTE 200ML	4.000		34	196
2936	34703	MASCARA DESC TRIPLA C/ELASTICO MEDIX 22G BR C/50UND	4.000		35	196
2937	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	12.000		36	196
2938	34843	ESPARADRAPO SALVELOX 2,5CMX90CM UNIT	12.000		37	196
2939	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		38	196
2940	39160	VASELINA VASEMAX  FARMAX 70G	6.000		39	196
2941	183466	RIODEINE DERMOSUAVE RIOQUIMICA SPRAY 100ML	6.000		40	196
2942	33863	OLEO CAP/CORP.UVA FARMAX 100ML	6.000		33	197
2943	38962	ATADURA AMERICA 10CMX1.8M SOFT C/12 PACK ***************	1.000		34	197
2944	38970	ATADURA AMERICA 12CMX1.8M SOFT C/12 PACK ***************	1.000		35	197
2945	30406	FARMAIODINE TOPICO ALMOT.FARMAX 100ML	12.000		36	197
2946	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	6.000		37	197
2947	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	6.000		38	197
2948	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	6.000		39	197
2949	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	6.000		40	197
2950	30430	BICARBONATO SODIO FARMAX POTE 100GR	36.000		41	197
2951	30511	ALCOOL GEL 70% FARMAX 50GR	12.000		42	197
2952	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		43	197
2953	30570	ALCOOL 70% FARMAX 50ML	60.000		44	197
2954	30643	CLORETO DE MAGNESIO FARMAX 33GR	3.000		45	197
2955	30678	VASELINA VASEMAX LIQ.FARMAX 100ML	6.000		46	197
2956	33065	OLEO CAP/CORP.AMENDOAS FARMAX 100ML	6.000		47	197
2957	33855	OLEO CAP/CORP.CENOURA FARMAX 100ML	6.000		48	197
2958	33871	OLEO CAP/CORP.COCO FARMAX 100ML	6.000		49	197
2959	33880	OLEO CAP/CORP.ARGAN FARMAX 100ML	6.000		50	197
2960	33944	OLEO CAP/CORP.ROSA MOSQUETA FARMAX 100ML	6.000		51	197
2961	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		52	197
2962	39160	VASELINA VASEMAX  FARMAX 70G	6.000		53	197
2963	43915	OLEO DE RICINO 30 ML UNIPHAR	12.000		54	197
2964	180440	CURATIVO CICATRISAN  TRANSP.10 UND	48.000		55	197
2965	213	ATADURA CREPON CREMER CYSNE 20CM UNIT	18.000		31	198
2966	1350	POVIDINE TOPICO ALMOTOLIA 100ML	6.000		32	198
2967	28169	CURATIVO CREMERCARE BEGE 10UND	24.000		33	198
2968	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		34	198
2969	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		35	198
2970	34703	MASCARA DESC TRIPLA C/ELASTICO MEDIX 22G BR C/50UND	3.000		36	198
2971	38512	COMP. Ñ ADER.SANFARMA EST 40X10	3.000		37	198
2972	132500	COLETOR UNIVERSAL DESPACK 70 ML S/CX 100UN	1.000		38	198
2973	42463	SOLUÇAO DE MANITOL 20% EQUIPLEX 250ML	6.000		60	199
2974	138398	FITA FRALDA CREMER AZUL	2.000		61	199
2975	138410	FITA FRALDA CREMER ROSA	6.000		62	199
2976	182427	ESPARADRAPO BRANCO CREMER 5,0CMX4,5M	12.000		63	199
2977	29971	COMPRESSA GAZE AMERICA HERIKA 13 FIOS 440X10 CX ********	1.000		64	199
2978	38954	ATADURA AMERICA 8CMX1.8M SOFT C/12 PACK **************	2.000		65	199
2979	38997	ATADURA AMERICA 20CMX1.8M SOFT UNIT	24.000		66	199
2980	41114	OLEO MINERAL RIOQUIMICA  100 ML	12.000		67	199
2981	612	ESPARADRAPO BRANCO CREMER 2,5CMX0,9M	12.000		68	199
2982	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	12.000		69	199
2983	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		70	199
2984	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	6.000		71	199
2985	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	6.000		72	199
2986	22721	MICROPOROSA BRANCA CREMER 1,2CMX4,5M	12.000		73	199
2987	22748	MICROPOROSA BRANCA CREMER 2,5CMX0,9M	12.000		74	199
2988	28169	CURATIVO CREMERCARE BEGE 10UND	24.000		75	199
2989	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		76	199
2990	30406	FARMAIODINE TOPICO ALMOT.FARMAX 100ML	6.000		77	199
2991	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		78	199
2992	30457	OLEO RICINO PURO FARMAX 30ML	12.000		79	199
2993	30473	SAL AMARGO MED. POTE FARMAX 30G	6.000		80	199
2994	30538	PEDRA HUME PURA PO FARMAX 20G	12.000		81	199
2995	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	12.000		82	199
2996	30554	REMOVEDOR ESMALTE C/ACET.FARMAX 100ML C/12 PACK*******	3.000		83	199
2997	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		84	199
2998	30570	ALCOOL 70% FARMAX 50ML	24.000		85	199
2999	30660	GLICERINA PURA COSMETICA FARMAX 100ML	12.000		86	199
3000	30740	SOLUÇÃO DE AMÔNIA FARMAX 100ML C/12 PACK****************	1.000		87	199
3001	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		88	199
3002	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		89	199
3003	33065	OLEO CAP/CORP.AMENDOAS FARMAX 100ML	12.000		90	199
3004	33081	OLEO DE BANANA DILUENTE FARMAX 100ML	12.000		91	199
3005	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	12.000		92	199
3006	39160	VASELINA VASEMAX  FARMAX 70G	6.000		93	199
3007	39357	VASELINA VASEMAX  FARMAX  25 GR	12.000		94	199
3008	42293	CURATIVO TRADICIONAL SALVELOX C/35 UNID	12.000		95	199
3009	132500	COLETOR UNIVERSAL DESPACK 70 ML S/CX 100UN	1.000		96	199
3010	138401	FITA FRALDA CREMER BRANCA	3.000		97	199
3011	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	12.000		98	199
3012	29971	COMPRESSA GAZE AMERICA HERIKA 13 FIOS 440X10 CX ********	1.000		32	200
3013	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		33	200
3014	37486	SAB.LIQ.MORANGO  CHAMPAGNE   PREMISSE 1L C/ VALV. PUMP	2.000		34	200
3015	37494	SAB.LIQ.MIX DE FRUTAS DEOLINE C/VALVULA PREMISSE 1L	2.000		35	200
3016	37508	SAB.LIQ. PESSEGO E DAMASCO  PREMISSE 1L C/ VALV. PUMP	2.000		36	200
3017	37656	SAB.LIQ.ERVA DOCE SOFT PREMISSE  1L C/ VALV. PUMP	2.000		37	200
3018	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		34	201
3019	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		35	201
3020	42641	AGULHA MEDIX 25 X 7 CX C/ 100 UNID	3.000		36	201
3021	43745	LEITE DE MAGNESIA SOBRAL TRADICIONAL 100 ML	6.000		37	201
3022	43753	LEITE DE MAGNESIA SOBRAL HORTELÃ 100 ML	6.000		38	201
3023	28215	CURATIVO CREMERCARE TRANSP C/ 40UN	3.000		37	202
3024	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	1.000		38	202
3025	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		39	202
3026	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		40	202
3027	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	1.000		41	202
3028	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		42	202
3029	29815	TIRAS GTECH FREE 1 C/50 UNIDS	2.000		43	202
3030	30554	REMOVEDOR ESMALTE C/ACET.FARMAX 100ML C/12 PACK*******	2.000		44	202
3031	30589	TINTURA DE IODO 2% FARMAX 30ML	3.000		45	202
3032	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	1.000		46	202
3033	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		47	202
3034	33057	REMOVEDOR ESMALTE C/ACETONA FARMAX 500ML UNID.	6.000		48	202
3035	33073	REMOVEDOR ESMALTE C/ACETONA FARMAX 200ML UNID	6.000		49	202
3036	33880	OLEO CAP/CORP.ARGAN FARMAX 100ML	3.000		50	202
3037	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		51	202
3038	40010	TERMOMETRO DIGITAL CEPALAB UNIT.	6.000		52	202
3039	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	2.000		31	203
3040	1171	SER BD SOLOMED 5ML AG 0,70X30 22G 100UN-631	2.000		32	203
3041	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		33	203
3042	34703	MASCARA DESC TRIPLA C/ELASTICO MEDIX 22G BR C/50UND	6.000		31	204
3043	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	2.000		32	204
3044	132500	COLETOR UNIVERSAL DESPACK 70 ML S/CX 100UN	1.000		33	204
3045	29971	COMPRESSA GAZE AMERICA HERIKA 13 FIOS 440X10 CX ********	1.000		31	205
3046	34851	ESPARADRAPO SALVELOX 1,2CMX4,5M UNIT	12.000		34	206
3047	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		35	206
3048	31437	DERMAEX OLEO CICATRIZANTE 100ML	3.000		36	206
3049	31445	DERMAEX OLEO CICATRIZANTE 200ML	3.000		37	206
3050	40029	ESPARADRAPO SALVELOX 10CMX3M UN	6.000		38	206
3051	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	12.000		39	206
3052	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	4.000		35	207
3053	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		36	207
3054	129020	PORTA COMPRIMIDOS DISCO SEMANAL  INCOTERM BRANCO UNIT	6.000		37	207
3055	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	3.000		34	208
3056	31437	DERMAEX OLEO CICATRIZANTE 100ML	4.000		35	208
3057	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		36	208
3058	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		31	209
3059	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	12.000		32	209
3060	40134	ESPAÇADOR EASY AIR ADULTO/INFANTIL  MULTILASER HC178	1.000		32	210
3061	124	ALGODAO APOLO 50GR C/ 20UNID PACK***************	1.000		33	210
3062	531	ALGODAO BOLA APOLO 50GR C/ 20UNID PACK*************	1.000		34	210
3063	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	2.000		35	210
3064	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		36	210
3065	30554	REMOVEDOR ESMALTE C/ACET.FARMAX 100ML C/12 PACK*******	1.000		37	210
3066	30570	ALCOOL 70% FARMAX 50ML	12.000		38	210
3067	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	1.000		39	210
3068	30732	AGUA OXIGENADA FARMAX CREMOSA 40VOL 90ML C/12 PACK *******	1.000		40	210
3069	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		34	211
3070	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	1.000		35	211
3071	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		36	211
3072	30554	REMOVEDOR ESMALTE C/ACET.FARMAX 100ML C/12 PACK*******	1.000		37	211
3073	33057	REMOVEDOR ESMALTE C/ACETONA FARMAX 500ML UNID.	3.000		38	211
3074	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	6.000		39	211
3075	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	6.000		40	211
3076	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		41	211
3077	39160	VASELINA VASEMAX  FARMAX 70G	6.000		42	211
3078	39357	VASELINA VASEMAX  FARMAX  25 GR	6.000		43	211
3079	43966	SERINGA 5ML C/AGULHA 25X7 LUER LOCK MEDIX CX.C/100	1.000		44	211
3080	40134	ESPAÇADOR EASY AIR ADULTO/INFANTIL  MULTILASER HC178	2.000		33	212
3081	38261	MONITOR DE PRESSAO PULSO GTECH DIGITAL GP400	2.000		34	212
3082	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		34	213
3083	213	ATADURA CREPON CREMER CYSNE 20CM UNIT	6.000		35	213
3084	230	ATADURA CREPON CREMER CYSNE 30CM UNIT	1.000		36	213
3085	28169	CURATIVO CREMERCARE BEGE 10UND	6.000		37	213
3086	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		38	213
3087	30414	CLOREXIDINA 1% ANTISSEP.FARMAX 30ML	3.000		39	213
3088	30570	ALCOOL 70% FARMAX 50ML	24.000		40	213
3089	30635	BICARBONATO SODIO FARMAX CX  50GRS	6.000		41	213
3090	37702	CURATIVO MARROM ESCURO CREMER  C/10	6.000		42	213
3091	34703	MASCARA DESC TRIPLA C/ELASTICO MEDIX 22G BR C/50UND	125.000		34	214
3092	31437	DERMAEX OLEO CICATRIZANTE 100ML	24.000		32	215
3093	31445	DERMAEX OLEO CICATRIZANTE 200ML	24.000		33	215
3094	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	216
3095	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	217
3096	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	218
3708	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		31	262
3098	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	220
3709	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		33	263
3100	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	221
3101	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	5.000		36	222
3102	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	6.000		37	222
3103	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	6.000		38	222
3104	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		35	223
3105	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	3.000		36	223
3106	42820	COLETOR UNIVERSAL SAQUINHO  80ML TRANSLUCIDO PCT C/100 ***	1.000		37	223
3710	41440	OLEO MINERAL UNIPHAR 100 ML	12.000		34	263
3108	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	219
3109	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	224
3711	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		35	263
3712	30430	BICARBONATO SODIO FARMAX POTE 100GR	24.000		36	263
3713	183199	ESPAR MISSNER IMPERM 2,5CM X 4,5M	12.000		37	263
3714	183210	ESPAR MISSNER IMPERM 2,5CM X 0,9M	12.000		38	263
3715	36145	COMPRESSA GAZE AMERICA REBECCA 9 FIOS C/500  UNIT	36.000		31	264
3716	35890	SER BD TUBERC 1ML 0,38X13 UNIT-146	150.000		64	265
3717	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	108.000		65	265
3718	29971	COMPRESSA GAZE AMERICA HERIKA 13 FIOS 440X10 CX ********	4.000		66	265
3719	30430	BICARBONATO SODIO FARMAX POTE 100GR	425.000		67	265
3720	31372	POVIDINE TOPICO SPRAY 30ML	30.000		68	265
3721	31437	DERMAEX OLEO CICATRIZANTE 100ML	120.000		69	265
3722	31445	DERMAEX OLEO CICATRIZANTE 200ML	84.000		70	265
3723	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	48.000		71	265
3724	29661	ALGODAO CREMER 25G C/20 UNID PACK**************	1.000		72	265
3725	30473	SAL AMARGO MED. POTE FARMAX 30G	36.000		73	265
3726	30589	TINTURA DE IODO 2% FARMAX 30ML	12.000		74	265
3727	34240	BENDITA CANFORA TABLETE ESTOJO DISP C/16(8 X3,5G) BRAVIR	7.000		75	265
3728	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	12.000		76	265
3729	38512	COMP. Ñ ADER.SANFARMA EST 40X10	9.000		77	265
3730	43788	OLEO DE RÍCINO SOBRAL 100% PURO 50 ML	56.000		78	265
3731	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	2.000		79	265
3732	174505	SER BD 20ML S/AGULHA LUER SLIP UND	30.000		80	265
3733	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		34	266
3734	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		35	266
3735	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		33	267
3736	182427	ESPARADRAPO BRANCO CREMER 5,0CMX4,5M	6.000		36	268
3737	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		37	268
3738	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		38	268
3739	795	MICRO NEBULIZADOR NS INFANTIL.	2.000		39	268
3740	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	2.000		40	268
3741	1350	POVIDINE TOPICO ALMOTOLIA 100ML	4.000		41	268
3742	22721	MICROPOROSA BRANCA CREMER 1,2CMX4,5M	6.000		42	268
3743	22748	MICROPOROSA BRANCA CREMER 2,5CMX0,9M	6.000		43	268
3744	28169	CURATIVO CREMERCARE BEGE 10UND	3.000		44	268
3745	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		45	268
3746	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		46	268
3747	30465	OLEO RICINO PURO FARMAX 100ML	1.000		47	268
3748	31445	DERMAEX OLEO CICATRIZANTE 200ML	3.000		48	268
3749	37702	CURATIVO MARROM ESCURO CREMER  C/10	3.000		49	268
3750	37710	CURATIVOS VARIADOS 6 FORM. 30UN CREMER	2.000		50	268
3751	38326	CURATIVOS CREMER PATRULHA CANINA C/10 UNID	3.000		51	268
3752	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		52	268
3753	41440	OLEO MINERAL UNIPHAR 100 ML	3.000		53	268
3754	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	12.000		33	269
3755	33820	OLEO  A.G.E.GIRASSOL ALMOT.FARMAX 100ML	6.000		34	269
3756	138401	FITA FRALDA CREMER BRANCA	1.000		35	269
3757	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		36	269
3758	132	ALGODAO APOLO 100GR C/ 10UNID PACK***********	1.000		37	269
3759	531	ALGODAO BOLA APOLO 50GR C/ 20UNID PACK*************	1.000		38	269
3760	566	ALGODAO BOLA APOLO 100GR C/ 10UND PACK******************	1.000		39	269
3761	612	ESPARADRAPO BRANCO CREMER 2,5CMX0,9M	12.000		40	269
3762	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	1.000		41	269
3763	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		42	269
3764	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		43	269
3765	30520	OLEO DE BANANA DILUENTE FARMAX 28ML	12.000		44	269
3766	30643	CLORETO DE MAGNESIO FARMAX 33GR	3.000		45	269
3767	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	2.000		46	269
3768	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		47	269
3769	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		48	269
3770	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	12.000		49	269
3771	36145	COMPRESSA GAZE AMERICA REBECCA 9 FIOS C/500  UNIT	12.000		50	269
3772	37737	CURATIVO JOELHO/COTOVELO CREMER C/06	2.000		51	269
3773	148300	AGULHA DESC BD 0,30X13 INTRAD/SUBC CX C/100UN	1.000		52	269
3774	132	ALGODAO APOLO 100GR C/ 10UNID PACK***********	1.000		31	270
3775	531	ALGODAO BOLA APOLO 50GR C/ 20UNID PACK*************	1.000		32	270
3776	566	ALGODAO BOLA APOLO 100GR C/ 10UND PACK******************	1.000		33	270
3777	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		34	270
3778	30473	SAL AMARGO MED. POTE FARMAX 30G	12.000		35	270
3779	30538	PEDRA HUME PURA PO FARMAX 20G	6.000		36	270
3780	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	1.000		37	270
3781	31437	DERMAEX OLEO CICATRIZANTE 100ML	12.000		38	270
3782	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	12.000		39	270
3783	132500	COLETOR UNIVERSAL DESPACK 70 ML S/CX 100UN	1.000		40	270
3784	38512	COMP. Ñ ADER.SANFARMA EST 40X10	20.000		31	271
3785	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		32	272
3786	1350	POVIDINE TOPICO ALMOTOLIA 100ML	4.000		33	272
3787	28169	CURATIVO CREMERCARE BEGE 10UND	12.000		34	272
3788	30406	FARMAIODINE TOPICO ALMOT.FARMAX 100ML	4.000		35	272
3789	30538	PEDRA HUME PURA PO FARMAX 20G	6.000		36	272
3790	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		37	272
3791	30589	TINTURA DE IODO 2% FARMAX 30ML	6.000		38	272
3792	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	1.000		39	272
3793	30740	SOLUÇÃO DE AMÔNIA FARMAX 100ML C/12 PACK****************	1.000		40	272
3794	31437	DERMAEX OLEO CICATRIZANTE 100ML	4.000		41	272
3795	31445	DERMAEX OLEO CICATRIZANTE 200ML	3.000		42	272
3796	34304	ALIVIK BRAVIR 12G DISPLAY 12 UN	1.000		43	272
3797	35866	PERMANGANATO DE POTASSIO UNIPHAR 10 DOSES 100MG UNIT	6.000		44	272
3798	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		45	272
3799	43737	INGLESA QUINA SOBRAL 430 ML	3.000		46	272
3800	183199	ESPAR MISSNER IMPERM 2,5CM X 4,5M	12.000		47	272
3801	29971	COMPRESSA GAZE AMERICA HERIKA 13 FIOS 440X10 CX ********	2.000		32	273
3802	29971	COMPRESSA GAZE AMERICA HERIKA 13 FIOS 440X10 CX ********	1.000		34	274
3803	36242	BICARBONATO DE SODIO  UNIPHAR  50G	24.000		35	274
3804	34240	BENDITA CANFORA TABLETE ESTOJO DISP C/16(8 X3,5G) BRAVIR	1.000		36	274
3805	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	24.000		37	274
3806	335720	PERMASSIM CAIXA C/ 500 CP	1.000		38	274
3807	183490	COMP. Ñ ADER.SANFARMA EST EXTRA 40X5	100.000		31	275
3808	40371	FRALDA BABYSEC ULTRA HIPER XG 2X56	2.000		32	276
3809	124	ALGODAO APOLO 50GR C/ 20UNID PACK***************	1.000		33	276
3810	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		34	276
3811	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		35	276
3812	30457	OLEO RICINO PURO FARMAX 30ML	12.000		36	276
3813	30678	VASELINA VASEMAX LIQ.FARMAX 100ML	6.000		37	276
3814	33871	OLEO CAP/CORP.COCO FARMAX 100ML	6.000		38	276
3815	33880	OLEO CAP/CORP.ARGAN FARMAX 100ML	6.000		39	276
3816	38490	FRALDA BABYSEC ULTRA MEGA M 6X38	1.000		40	276
3817	42390	ABSORVENTE DIANA SUAVE C/ABAS PCT.C/28	2.000		41	276
3818	42633	GLICERINA FARMAX BI DESTILADA COM ALOE VERA 100 ML	6.000		42	276
3819	43974	POMADA MINANCORA 30G UNID	6.000		43	276
3820	183202	ESPAR MISSNER IMPERM 1,2CM X 4,5M	12.000		44	276
3821	34240	BENDITA CANFORA TABLETE ESTOJO DISP C/16(8 X3,5G) BRAVIR	1.000		31	277
3822	38512	COMP. Ñ ADER.SANFARMA EST 40X10	3.000		32	277
3823	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		33	278
3824	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	3.000		38	279
3825	34851	ESPARADRAPO SALVELOX 1,2CMX4,5M UNIT	12.000		39	279
3826	38962	ATADURA AMERICA 10CMX1.8M SOFT C/12 PACK ***************	1.000		40	279
3827	42463	SOLUÇAO DE MANITOL 20% EQUIPLEX 250ML	6.000		41	279
3828	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		42	279
3829	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	2.000		43	279
3830	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		44	279
3831	38954	ATADURA AMERICA 8CMX1.8M SOFT C/12 PACK **************	1.000		45	279
3832	28169	CURATIVO CREMERCARE BEGE 10UND	20.000		46	279
3833	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		47	279
3834	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		48	279
3835	30538	PEDRA HUME PURA PO FARMAX 20G	6.000		49	279
3836	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		50	279
3837	30570	ALCOOL 70% FARMAX 50ML	24.000		51	279
3838	30678	VASELINA VASEMAX LIQ.FARMAX 100ML	6.000		52	279
3839	31437	DERMAEX OLEO CICATRIZANTE 100ML	10.000		53	279
3840	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	12.000		54	279
3841	34819	MICROPOROSA SALVELOX 1,2CMX4,5M	12.000		55	279
3842	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	12.000		56	279
3843	38512	COMP. Ñ ADER.SANFARMA EST 40X10	2.000		57	279
3844	39357	VASELINA VASEMAX  FARMAX  25 GR	6.000		58	279
3845	40029	ESPARADRAPO SALVELOX 10CMX3M UN	10.000		59	279
3846	41440	OLEO MINERAL UNIPHAR 100 ML	6.000		60	279
3847	43575	BICARBONATO DE SODIO  UNIPHAR  100 GR	6.000		61	279
3848	43605	TESTE DE GRAVIDEZ HCG TIRA C/ FRASCO MULTILASER	20.000		62	279
3849	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	12.000		63	279
3850	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	2.000		31	280
3851	30589	TINTURA DE IODO 2% FARMAX 30ML	24.000		32	280
3852	43486	LUVA LATEX  TOP NUGARD C/PO TAM M C/100 UNID	10.000		33	280
3853	31437	DERMAEX OLEO CICATRIZANTE 100ML	24.000		32	281
3854	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	6.000		33	281
3855	2437	AGULHA P/ CANETA 8 MM 100UN	1.000		34	281
3856	34240	BENDITA CANFORA TABLETE ESTOJO DISP C/16(8 X3,5G) BRAVIR	1.000		35	281
3857	29971	COMPRESSA GAZE AMERICA HERIKA 13 FIOS 440X10 CX ********	1.000		33	282
3858	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		34	282
3859	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	3.000		35	282
3860	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	24.000		36	282
3861	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	24.000		37	282
3862	34819	MICROPOROSA SALVELOX 1,2CMX4,5M	24.000		38	282
3863	124	ALGODAO APOLO 50GR C/ 20UNID PACK***************	2.000		31	283
3864	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	6.000		32	283
3865	1961	MANTEIGA CACAU BATOM LUXO 3,3GR C/50UN BRAVIR	1.000		33	283
3866	31372	POVIDINE TOPICO SPRAY 30ML	3.000		34	283
3867	31437	DERMAEX OLEO CICATRIZANTE 100ML	12.000		35	283
3868	31445	DERMAEX OLEO CICATRIZANTE 200ML	12.000		36	283
3869	29661	ALGODAO CREMER 25G C/20 UNID PACK**************	1.000		31	284
3870	29670	ALGODAO CREMER 50G C/10 UNID PACK***************	1.000		32	284
3871	31399	AGULHA P/CANETA 4MM NANO PENTAPOINT EASYFLOW 100UND	6.000		33	284
3872	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		34	284
3873	174505	SER BD 20ML S/AGULHA LUER SLIP UND	20.000		35	284
3874	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	3.000		32	285
3875	182427	ESPARADRAPO BRANCO CREMER 5,0CMX4,5M	6.000		33	285
3876	612	ESPARADRAPO BRANCO CREMER 2,5CMX0,9M	12.000		34	285
3877	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	6.000		35	285
3878	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		36	285
3879	40762	AUTO LANCETA GTECH 28G C/ 100 UNID	2.000		37	285
3401	38970	ATADURA AMERICA 12CMX1.8M SOFT C/12 PACK ***************	1.000		46	225
3402	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	3.000		47	225
3403	38997	ATADURA AMERICA 20CMX1.8M SOFT UNIT	12.000		48	225
3404	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	2.000		49	225
3405	31437	DERMAEX OLEO CICATRIZANTE 100ML	2.000		50	225
3406	41041	AGULHA DESC BD 0,60X25 INTRAMUSCULAR CX C/100UN	3.000		51	225
3407	42897	LAVADOR NASAL COM FRASCO 2 BICOS INF/ADUL 300 ML 3B UNIT	3.000		52	225
3408	183210	ESPAR MISSNER IMPERM 2,5CM X 0,9M	12.000		53	225
3409	43575	BICARBONATO DE SODIO  UNIPHAR  100 GR	12.000		32	226
3410	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	3.000		33	226
3411	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	3.000		34	226
3412	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		35	226
3413	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		36	226
3414	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		37	226
3415	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	3.000		31	227
3416	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	2.000		32	227
3417	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	2.000		34	228
3418	30376	AGUA OXIGENADA FARMAX 10VOL 1LT	3.000		35	228
3419	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		36	228
3420	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		37	228
3421	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	3.000		38	228
3422	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		39	228
3423	38261	MONITOR DE PRESSAO PULSO GTECH DIGITAL GP400	2.000		40	228
3424	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		41	228
3425	40762	AUTO LANCETA GTECH 28G C/ 100 UNID	1.000		42	228
3426	44024	SABONETE DE AROEIRA 100G	12.000		43	228
3427	44130	SABONETE DE COCO 100 GRS	10.000		44	228
3428	31402	SORO FISIOL SORIMAX 100ML C/12UN PACK *************	7.000		32	229
3429	28177	CURATIVO CREMERCARE BEGE 40UND	6.000		34	230
3430	182427	ESPARADRAPO BRANCO CREMER 5,0CMX4,5M	12.000		35	230
3431	182940	LUVA P/PROCED MEDIX GDE 100UN	2.000		36	230
3432	182958	LUVA P/PROCED MEDIX MED 100UN	3.000		37	230
3433	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		38	230
3434	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		39	230
3435	213	ATADURA CREPON CREMER CYSNE 20CM UNIT	6.000		40	230
3436	612	ESPARADRAPO BRANCO CREMER 2,5CMX0,9M	12.000		41	230
3437	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	12.000		42	230
3438	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	12.000		43	230
3439	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	3.000		44	230
3440	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	3.000		45	230
3441	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	1.000		46	230
3442	1171	SER BD SOLOMED 5ML AG 0,70X30 22G 100UN-631	1.000		47	230
3443	28169	CURATIVO CREMERCARE BEGE 10UND	12.000		48	230
3444	28207	CURATIVO CREMERCARE TRANSP C/10UN	12.000		49	230
3445	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		50	230
3446	30660	GLICERINA PURA COSMETICA FARMAX 100ML	6.000		51	230
3447	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		52	230
3448	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		53	230
3449	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		54	230
3450	39160	VASELINA VASEMAX  FARMAX 70G	6.000		55	230
3451	39357	VASELINA VASEMAX  FARMAX  25 GR	12.000		56	230
3452	39853	ESPARADRAPO BEGE CREMER 1,2CMX3,00	6.000		57	230
3453	41114	OLEO MINERAL RIOQUIMICA  100 ML	6.000		58	230
3454	132500	COLETOR UNIVERSAL DESPACK 70 ML S/CX 100UN	1.000		59	230
3455	174505	SER BD 20ML S/AGULHA LUER SLIP UND	12.000		60	230
3456	180440	CURATIVO CICATRISAN  TRANSP.10 UND	15.000		61	230
3457	33537	PASTA DAGUA RIOQUIMICA 100GR	4.000		34	231
3458	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		35	231
3459	43575	BICARBONATO DE SODIO  UNIPHAR  100 GR	12.000		36	231
3460	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		37	231
3461	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		38	231
3462	42897	LAVADOR NASAL COM FRASCO 2 BICOS INF/ADUL 300 ML 3B UNIT	3.000		39	231
3463	43613	SERINGA NASAL MULTILASER C/2 UNID	3.000		40	231
3464	44130	SABONETE DE COCO 100 GRS	10.000		41	231
3465	40045	NEBULIZADOR GTECH COMPACT DC2	2.000		34	232
3466	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		35	232
3467	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		36	232
3468	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		37	232
3469	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		38	232
3470	42897	LAVADOR NASAL COM FRASCO 2 BICOS INF/ADUL 300 ML 3B UNIT	3.000		39	232
3471	43613	SERINGA NASAL MULTILASER C/2 UNID	4.000		40	232
3472	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	2.000		32	233
3473	29815	TIRAS GTECH FREE 1 C/50 UNIDS	3.000		33	233
3474	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	24.000		34	233
3475	40010	TERMOMETRO DIGITAL CEPALAB UNIT.	24.000		35	233
3476	174505	SER BD 20ML S/AGULHA LUER SLIP UND	24.000		36	233
3477	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	234
3478	31399	AGULHA P/CANETA 4MM NANO PENTAPOINT EASYFLOW 100UND	2.000		31	235
3479	38512	COMP. Ñ ADER.SANFARMA EST 40X10	9.000		32	235
3480	38512	COMP. Ñ ADER.SANFARMA EST 40X10	6.000		31	236
3481	38512	COMP. Ñ ADER.SANFARMA EST 40X10	4.000		31	237
3482	38512	COMP. Ñ ADER.SANFARMA EST 40X10	3.000		31	238
3483	170534	CORTADOR DE COMPRIMIDO TRANSP 1UN	12.000		32	238
3484	31399	AGULHA P/CANETA 4MM NANO PENTAPOINT EASYFLOW 100UND	2.000		31	239
3485	41050	AGULHA DESC BD 0,60X30 INTRAMUSCULAR CX C/100UN	2.000		32	239
3486	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	2.000		33	240
3487	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		34	240
3488	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	6.000		35	240
3489	29815	TIRAS GTECH FREE 1 C/50 UNIDS	4.000		36	240
3490	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		37	240
3491	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		38	240
3492	40762	AUTO LANCETA GTECH 28G C/ 100 UNID	2.000		39	240
3493	42897	LAVADOR NASAL COM FRASCO 2 BICOS INF/ADUL 300 ML 3B UNIT	3.000		40	240
3494	43613	SERINGA NASAL MULTILASER C/2 UNID	6.000		41	240
3495	44024	SABONETE DE AROEIRA 100G	10.000		42	240
3496	44040	SABONETE DE GLICERINA 100G	10.000		43	240
3497	44130	SABONETE DE COCO 100 GRS	10.000		44	240
3498	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	4.000		32	241
3499	30376	AGUA OXIGENADA FARMAX 10VOL 1LT	2.000		33	241
3500	39438	ALGODAO TOPZ DISCO DUPLA FACE  LEV 100 PG 85	12.000		34	241
3501	44032	SABONETE DE ENXOFRE 90G	10.000		35	241
3502	29815	TIRAS GTECH FREE 1 C/50 UNIDS	3.000		36	241
3503	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		37	241
3504	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		38	241
3505	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	3.000		39	241
3506	38261	MONITOR DE PRESSAO PULSO GTECH DIGITAL GP400	1.000		40	241
3507	40762	AUTO LANCETA GTECH 28G C/ 100 UNID	1.000		41	241
3508	182958	LUVA P/PROCED MEDIX MED 100UN	4.000		35	242
3509	182966	LUVA P/PROCED MEDIX PEQ 100UN	3.000		36	242
3510	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		37	242
3511	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	1.000		38	242
3512	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	1.000		39	242
3513	22730	MICROPOROSA BRANCA CREMER 10CMX4,5M UNIT	3.000		40	242
3514	30554	REMOVEDOR ESMALTE C/ACET.FARMAX 100ML C/12 PACK*******	5.000		41	242
3515	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	1.000		42	242
3516	30660	GLICERINA PURA COSMETICA FARMAX 100ML	3.000		43	242
3517	31402	SORO FISIOL SORIMAX 100ML C/12UN PACK *************	1.000		44	242
3518	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	12.000		45	242
3519	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	6.000		46	242
3520	35734	MASCARA CIRURGICA AMERICA EVA TRIPLA DESC.PREMIUM C/50UN	3.000		47	242
3521	40029	ESPARADRAPO SALVELOX 10CMX3M UN	6.000		48	242
3522	43370	HASTES C/75 UNIDADES MICKEY E AMIGOS	24.000		49	242
3523	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		33	243
3524	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	3.000		34	243
3525	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	24.000		35	243
3526	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	48.000		36	243
3527	42463	SOLUÇAO DE MANITOL 20% EQUIPLEX 250ML	6.000		32	244
3528	30520	OLEO DE BANANA DILUENTE FARMAX 28ML	3.000		33	244
3529	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		34	244
3530	33073	REMOVEDOR ESMALTE C/ACETONA FARMAX 200ML UNID	6.000		35	244
3531	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	12.000		36	244
3532	43370	HASTES C/75 UNIDADES MICKEY E AMIGOS	12.000		37	244
3533	43559	CLORETO DE MAGNESIO UNIPHAR 60 CPS	3.000		38	244
3534	44024	SABONETE DE AROEIRA 100G	6.000		39	244
3535	44199	CLORETO DE MAGNESIO 33 GRS UNIPHAR	3.000		40	244
3536	174300	HASTES FLEXIVEIS  APOLO C/ 150 UNID.	6.000		41	244
3537	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	3.000		34	245
3538	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	2.000		35	245
3539	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		36	245
3540	31437	DERMAEX OLEO CICATRIZANTE 100ML	12.000		37	245
3541	31445	DERMAEX OLEO CICATRIZANTE 200ML	12.000		38	245
3542	40762	AUTO LANCETA GTECH 28G C/ 100 UNID	1.000		39	245
3543	132	ALGODAO APOLO 100GR C/ 10UNID PACK***********	1.000		31	246
3544	531	ALGODAO BOLA APOLO 50GR C/ 20UNID PACK*************	1.000		32	246
3545	566	ALGODAO BOLA APOLO 100GR C/ 10UND PACK******************	1.000		33	246
3546	23540	ALGODAO BOLA COLORIDO APOLO 50GR C/20UN PACK***********	1.000		34	246
3547	174327	DISCO DE ALGODÃO APOLO ZIP LOCK 70GR	2.000		35	246
3548	40045	NEBULIZADOR GTECH COMPACT DC2	2.000		33	247
3549	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		34	247
3550	38261	MONITOR DE PRESSAO PULSO GTECH DIGITAL GP400	2.000		35	247
3551	42897	LAVADOR NASAL COM FRASCO 2 BICOS INF/ADUL 300 ML 3B UNIT	3.000		36	247
3552	44199	CLORETO DE MAGNESIO 33 GRS UNIPHAR	12.000		32	248
3553	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	2.000		33	248
3554	30430	BICARBONATO SODIO FARMAX POTE 100GR	24.000		34	248
3555	30457	OLEO RICINO PURO FARMAX 30ML	12.000		35	248
3556	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	6.000		36	248
3557	30589	TINTURA DE IODO 2% FARMAX 30ML	12.000		37	248
3558	30686	VASELINA VASEMAX FARMAX 60GR	6.000		38	248
3559	30694	VASELINA VASEMAX FARMAX 100GR	6.000		39	248
3560	30740	SOLUÇÃO DE AMÔNIA FARMAX 100ML C/12 PACK****************	2.000		40	248
3561	33081	OLEO DE BANANA DILUENTE FARMAX 100ML	12.000		41	248
3562	33944	OLEO CAP/CORP.ROSA MOSQUETA FARMAX 100ML	12.000		42	248
3563	39160	VASELINA VASEMAX  FARMAX 70G	3.000		43	248
3564	213	ATADURA CREPON CREMER CYSNE 20CM UNIT	18.000		31	249
3565	28169	CURATIVO CREMERCARE BEGE 10UND	24.000		32	249
3566	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		33	249
3567	30406	FARMAIODINE TOPICO ALMOT.FARMAX 100ML	6.000		34	249
3568	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		35	249
3569	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		36	249
3570	38512	COMP. Ñ ADER.SANFARMA EST 40X10	3.000		37	249
3571	42803	MASCARA DESCART.TRIPLA C/ELAST BRANCA MEDIX PCT  C/50 UNID	3.000		38	249
3572	132500	COLETOR UNIVERSAL DESPACK 70 ML S/CX 100UN	1.000		39	249
3573	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	1.000		31	250
3574	28169	CURATIVO CREMERCARE BEGE 10UND	24.000		32	250
3575	29661	ALGODAO CREMER 25G C/20 UNID PACK**************	2.000		33	250
3576	30473	SAL AMARGO MED. POTE FARMAX 30G	11.000		34	250
3577	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	2.000		35	250
3578	44113	RIOHEX 2% DEGERMANTE RIOQUIMICA  100 ML ALMOTOLIA	2.000		36	250
3579	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		37	250
3580	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	12.000		31	251
3581	183601	SORO FISIOL. 0,9%  ADV 5ML C/10 AMP	20.000		32	252
3582	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	3.000		33	252
3583	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	6.000		34	252
3584	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	6.000		35	252
3585	44113	RIOHEX 2% DEGERMANTE RIOQUIMICA  100 ML ALMOTOLIA	3.000		36	252
3586	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		37	252
3587	174505	SER BD 20ML S/AGULHA LUER SLIP UND	15.000		38	252
3588	29963	COMPRESSA  GAZE AMERICA HERIKA 11 FIOS 440X10 CX *******	1.000		50	253
3589	30406	FARMAIODINE TOPICO ALMOT.FARMAX 100ML	12.000		51	253
3590	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		52	253
3591	38954	ATADURA AMERICA 8CMX1.8M SOFT C/12 PACK **************	2.000		53	253
3592	38997	ATADURA AMERICA 20CMX1.8M SOFT UNIT	15.000		54	253
3593	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	3.000		55	253
3594	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	2.000		56	253
3595	1961	MANTEIGA CACAU BATOM LUXO 3,3GR C/50UN BRAVIR	1.000		57	253
3596	3964	MANTEIGA CACAU LIQUIDA ROLL ON 10ML DISPLAY C/24UN BRAVIR	1.000		58	253
3597	29661	ALGODAO CREMER 25G C/20 UNID PACK**************	3.000		59	253
3598	29670	ALGODAO CREMER 50G C/10 UNID PACK***************	3.000		60	253
3599	29793	KIT MEDIDOR DE GLICOSE GTECH LITE COMPLETO	1.000		61	253
3600	29815	TIRAS GTECH FREE 1 C/50 UNIDS	3.000		62	253
3601	29823	TIRAS GTECH FREE LITE C/50 UNIDS	3.000		63	253
3602	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		64	253
3603	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	6.000		65	253
3604	30414	CLOREXIDINA 1% ANTISSEP.FARMAX 30ML	8.000		66	253
3605	30422	SOLUÇÃO ANTIMICOTICA IODO FARMAX 30ML	5.000		67	253
3606	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		68	253
3607	30538	PEDRA HUME PURA PO FARMAX 20G	6.000		69	253
3608	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	12.000		70	253
3609	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		71	253
3610	30570	ALCOOL 70% FARMAX 50ML	48.000		72	253
3611	30589	TINTURA DE IODO 2% FARMAX 30ML	3.000		73	253
3612	30660	GLICERINA PURA COSMETICA FARMAX 100ML	12.000		74	253
3613	30678	VASELINA VASEMAX LIQ.FARMAX 100ML	6.000		75	253
3614	31437	DERMAEX OLEO CICATRIZANTE 100ML	12.000		76	253
3615	31445	DERMAEX OLEO CICATRIZANTE 200ML	12.000		77	253
3616	34304	ALIVIK BRAVIR 12G DISPLAY 12 UN	1.000		78	253
3617	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	24.000		79	253
3618	34819	MICROPOROSA SALVELOX 1,2CMX4,5M	12.000		80	253
3619	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	24.000		81	253
3620	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	3.000		82	253
3621	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	12.000		83	253
3622	36838	MUNHEQUEIRA COM TALA E TIRAS BILATERAL PRETO G KSN031	2.000		84	253
3623	39357	VASELINA VASEMAX  FARMAX  25 GR	6.000		85	253
3624	39543	OLEO DE COPAIBA  UNIPHAR 30ML	2.000		86	253
3625	40010	TERMOMETRO DIGITAL CEPALAB UNIT.	12.000		87	253
3626	40029	ESPARADRAPO SALVELOX 10CMX3M UN	15.000		88	253
3627	41440	OLEO MINERAL UNIPHAR 100 ML	10.000		89	253
3628	43478	LUVA LATEX  TOP NUGARD C/PO TAM P C/100 UNID	4.000		90	253
3629	180440	CURATIVO CICATRISAN  TRANSP.10 UND	60.000		91	253
3630	183199	ESPAR MISSNER IMPERM 2,5CM X 4,5M	24.000		92	253
3631	183202	ESPAR MISSNER IMPERM 1,2CM X 4,5M	12.000		93	253
3632	183229	FITA MICROPOROSA MISSNER 10,0CM X 4,5M	8.000		94	253
3633	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	12.000		95	253
3634	29971	COMPRESSA GAZE AMERICA HERIKA 13 FIOS 440X10 CX ********	2.000		33	254
3635	38512	COMP. Ñ ADER.SANFARMA EST 40X10	15.000		34	254
3636	31437	DERMAEX OLEO CICATRIZANTE 100ML	60.000		35	255
3637	31445	DERMAEX OLEO CICATRIZANTE 200ML	60.000		36	255
3638	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	18.000		37	255
3639	34843	ESPARADRAPO SALVELOX 2,5CMX90CM UNIT	24.000		38	255
3640	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	12.000		39	255
3641	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	18.000		40	255
3642	14770	TERMOMETRO  DIGITAL TERMOMED BRANCO CARTELADO UNIT	6.000		34	256
3643	33537	PASTA DAGUA RIOQUIMICA 100GR	2.000		35	256
3644	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		36	256
3645	38970	ATADURA AMERICA 12CMX1.8M SOFT C/12 PACK ***************	1.000		37	256
3646	42463	SOLUÇAO DE MANITOL 20% EQUIPLEX 250ML	3.000		38	256
3647	182940	LUVA P/PROCED MEDIX GDE 100UN	2.000		39	256
3648	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	1.000		40	256
3649	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		41	256
3650	1090	BOLSA TERM TERMOGEL PEQ 130MM X 180MM UNIT	2.000		42	256
3651	30473	SAL AMARGO MED. POTE FARMAX 30G	3.000		43	256
3652	30546	PEDRA HUME SPRAY C/ GLIC. FARMAX 30ML	6.000		44	256
3653	30570	ALCOOL 70% FARMAX 50ML	20.000		45	256
3654	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		46	256
3655	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	4.000		47	256
3656	36242	BICARBONATO DE SODIO  UNIPHAR  50G	6.000		48	256
3657	38512	COMP. Ñ ADER.SANFARMA EST 40X10	2.000		49	256
3658	39357	VASELINA VASEMAX  FARMAX  25 GR	6.000		50	256
3659	42293	CURATIVO TRADICIONAL SALVELOX C/35 UNID	6.000		51	256
3660	42307	CURATIVO TRADICIONAL SALVELOX C/10 UNID	6.000		52	256
3661	42897	LAVADOR NASAL COM FRASCO 2 BICOS INF/ADUL 300 ML 3B UNIT	6.000		53	256
3662	43486	LUVA LATEX  TOP NUGARD C/PO TAM M C/100 UNID	5.000		54	256
3663	129020	PORTA COMPRIMIDOS DISCO SEMANAL  INCOTERM BRANCO UNIT	3.000		55	256
3664	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	10.000		56	256
3665	170534	CORTADOR DE COMPRIMIDO TRANSP 1UN	6.000		57	256
3666	174300	HASTES FLEXIVEIS  APOLO C/ 150 UNID.	4.000		58	256
3667	183172	ESPAR MISSNER IMPERM 10,0CM X 4,5M	3.000		59	256
3668	183229	FITA MICROPOROSA MISSNER 10,0CM X 4,5M	5.000		60	256
3669	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	6.000		61	256
3670	34274	ARNICA BRAVIR GEL 120 GR	12.000		33	257
3671	787	MICRO NEBULIZADOR NS ADULTO	1.000		34	257
3672	3964	MANTEIGA CACAU LIQUIDA ROLL ON 10ML DISPLAY C/24UN BRAVIR	1.000		35	257
3673	23540	ALGODAO BOLA COLORIDO APOLO 50GR C/20UN PACK***********	1.000		36	257
3674	31054	PROTETOR DE PUNHO PRETO KSN009	1.000		37	257
3675	34932	ATADURA GESSADA CYSNE 20CM UNIT	6.000		38	257
3676	183695	CURATIVO CICATRISAN  BEGE10 UND	12.000		39	257
3677	29777	LANCETA PARA LANCETADOR GTECH 28G C/100 UNIDS	4.000		35	258
3678	43907	ALCOOL 70% SPRAY 50 ML UNIPHAR	12.000		36	258
3679	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	3.000		37	258
3680	30589	TINTURA DE IODO 2% FARMAX 30ML	4.000		38	258
3681	43915	OLEO DE RICINO 30 ML UNIPHAR	6.000		39	258
3682	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	3.000		34	259
3683	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		35	259
3684	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		36	259
3685	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		37	259
3686	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		38	259
3687	37729	PROTETOR OCULAR ADULTO BEGE C/ 12 UNID	3.000		39	259
3688	138185	COLETOR UNIVERSAL MIF CEPALAB C/CAIXA UND.	12.000		40	259
3689	37729	PROTETOR OCULAR ADULTO BEGE C/ 12 UNID	6.000		32	260
3690	34843	ESPARADRAPO SALVELOX 2,5CMX90CM UNIT	12.000		33	260
3691	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		34	260
4069	612	ESPARADRAPO BRANCO CREMER 2,5CMX0,9M	12.000		31	286
4070	1155	BOLSA TERM TERMOGEL GDE 16MM X 240MM UNIT	6.000		32	286
4071	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	2.000		33	286
4072	39357	VASELINA VASEMAX  FARMAX  25 GR	3.000		34	286
4073	183695	CURATIVO CICATRISAN  BEGE10 UND	3.000		35	286
4074	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		34	287
4075	36242	BICARBONATO DE SODIO  UNIPHAR  50G	12.000		35	287
4076	30406	FARMAIODINE TOPICO ALMOT.FARMAX 100ML	4.000		36	287
4077	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		37	287
4078	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	3.000		38	287
4079	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	12.000		39	287
4080	42820	COLETOR UNIVERSAL SAQUINHO  80ML TRANSLUCIDO PCT C/100 ***	1.000		40	287
4081	43370	HASTES C/75 UNIDADES MICKEY E AMIGOS	12.000		41	287
4082	41440	OLEO MINERAL UNIPHAR 100 ML	12.000		33	288
4083	43575	BICARBONATO DE SODIO  UNIPHAR  100 GR	12.000		34	288
4084	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	36.000		35	288
4085	29700	ALGODAO CREMER 500G UNITARIO	3.000		31	289
4086	35785	APAR PRESSAO G-TECH MANUAL C/ ESTETO	2.000		32	289
4087	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	2.000		31	290
4088	34240	BENDITA CANFORA TABLETE ESTOJO DISP C/16(8 X3,5G) BRAVIR	1.000		32	290
4089	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		33	290
4090	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		33	291
4091	30910	TOALHA UMED.GERIATRICA GERIALIMP C/50	19.000		34	291
4092	36145	COMPRESSA GAZE AMERICA REBECCA 9 FIOS C/500  UNIT	32.000		35	291
4093	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	12.000		31	292
4094	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	3.000		34	293
4095	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	1.000		35	293
4096	180440	CURATIVO CICATRISAN  TRANSP.10 UND	24.000		36	293
4097	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		33	294
4098	531	ALGODAO BOLA APOLO 50GR C/ 20UNID PACK*************	1.000		34	294
4099	566	ALGODAO BOLA APOLO 100GR C/ 10UND PACK******************	1.000		35	294
4100	29815	TIRAS GTECH FREE 1 C/50 UNIDS	3.000		36	294
4101	29823	TIRAS GTECH FREE LITE C/50 UNIDS	3.000		37	294
4102	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		38	294
4103	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	12.000		39	294
4104	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		40	294
4105	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	1.000		41	294
4106	30678	VASELINA VASEMAX LIQ.FARMAX 100ML	12.000		42	294
4107	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	6.000		43	294
4108	40029	ESPARADRAPO SALVELOX 10CMX3M UN	6.000		44	294
4109	42307	CURATIVO TRADICIONAL SALVELOX C/10 UNID	24.000		45	294
4110	44172	TERMOMETRO DIGITAL  DOMOTHERM TC01 BRANCO CARTELADO	12.000		46	294
4111	183172	ESPAR MISSNER IMPERM 10,0CM X 4,5M	6.000		47	294
4112	183199	ESPAR MISSNER IMPERM 2,5CM X 4,5M	12.000		48	294
4113	183202	ESPAR MISSNER IMPERM 1,2CM X 4,5M	12.000		49	294
4114	183210	ESPAR MISSNER IMPERM 2,5CM X 0,9M	12.000		50	294
4115	183229	FITA MICROPOROSA MISSNER 10,0CM X 4,5M	6.000		51	294
4116	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	12.000		52	294
4117	183245	FITA MICROPOROSA MISSNER 2,5CM X 4,5M	12.000		53	294
4118	335720	PERMASSIM CAIXA C/ 500 CP	1.000		54	294
4119	30660	GLICERINA PURA COSMETICA FARMAX 100ML	70.000		31	295
4120	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		34	296
4121	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	24.000		35	296
4122	40029	ESPARADRAPO SALVELOX 10CMX3M UN	6.000		36	296
4123	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		33	297
4124	29971	COMPRESSA GAZE AMERICA HERIKA 13 FIOS 440X10 CX ********	1.000		32	298
4125	892	SER BD SOLOMED 3ML AG 0,70X25 22G 100UN-632	1.000		33	298
4126	41610	SERINGA 60 ML BICO CATETER UNID MEDIX	6.000		34	298
4127	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		35	298
4128	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		31	299
4129	30570	ALCOOL 70% FARMAX 50ML	6.000		32	299
4130	30643	CLORETO DE MAGNESIO FARMAX 33GR	3.000		33	299
4131	31437	DERMAEX OLEO CICATRIZANTE 100ML	3.000		34	299
4132	31445	DERMAEX OLEO CICATRIZANTE 200ML	3.000		35	299
4133	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	1.000		36	299
4134	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		37	299
4135	39357	VASELINA VASEMAX  FARMAX  25 GR	6.000		38	299
4136	40010	TERMOMETRO DIGITAL CEPALAB UNIT.	4.000		39	299
4137	43486	LUVA LATEX  TOP NUGARD C/PO TAM M C/100 UNID	3.000		40	299
4138	183199	ESPAR MISSNER IMPERM 2,5CM X 4,5M	12.000		41	299
4139	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	3.000		42	299
4140	183245	FITA MICROPOROSA MISSNER 2,5CM X 4,5M	6.000		43	299
4141	34240	BENDITA CANFORA TABLETE ESTOJO DISP C/16(8 X3,5G) BRAVIR	1.000		31	300
4142	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		32	300
4143	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	2.000		31	301
4144	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	302
4145	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	303
4146	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	304
4147	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	305
4148	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	306
4149	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	307
4150	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	308
4151	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	309
4152	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	2.000		31	310
4153	612	ESPARADRAPO BRANCO CREMER 2,5CMX0,9M	167.000		47	311
4154	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	31.000		48	311
4155	38946	ATADURA AMERICA 6CMX1.8M SOFT C/12 PACK****************	5.000		49	311
4156	38954	ATADURA AMERICA 8CMX1.8M SOFT C/12 PACK **************	6.000		50	311
4157	43915	OLEO DE RICINO 30 ML UNIPHAR	84.000		51	311
4158	213	ATADURA CREPON CREMER CYSNE 20CM UNIT	30.000		52	311
4159	230	ATADURA CREPON CREMER CYSNE 30CM UNIT	24.000		53	311
4160	787	MICRO NEBULIZADOR NS ADULTO	6.000		54	311
4161	795	MICRO NEBULIZADOR NS INFANTIL.	2.000		55	311
4162	3964	MANTEIGA CACAU LIQUIDA ROLL ON 10ML DISPLAY C/24UN BRAVIR	7.000		56	311
4163	30473	SAL AMARGO MED. POTE FARMAX 30G	21.000		57	311
4164	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	5.000		58	311
4165	42943	LUVA MEDIX CIR. TAM 7,0 PAR	6.000		59	311
4166	42951	LUVA MEDIX CIR. TAM 7,5 PAR	6.000		60	311
4167	42960	LUVA MEDIX CIR. TAM 8,5 PAR	8.000		61	311
4168	29947	KIT MEDIDOR DE GLICOSE GTECH FREE COMPLETO	1.000		35	312
4169	182958	LUVA P/PROCED MEDIX MED 100UN	3.000		36	312
4170	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		37	312
4171	41394	MONITOR DE PRESSAO PULSO MULTILASER DIGITAL  HC204	1.000		38	312
4172	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	1.000		39	312
4173	1171	SER BD SOLOMED 5ML AG 0,70X30 22G 100UN-631	1.000		40	312
4174	1961	MANTEIGA CACAU BATOM LUXO 3,3GR C/50UN BRAVIR	1.000		41	312
4175	29815	TIRAS GTECH FREE 1 C/50 UNIDS	3.000		42	312
4176	29823	TIRAS GTECH FREE LITE C/50 UNIDS	2.000		43	312
4177	33073	REMOVEDOR ESMALTE C/ACETONA FARMAX 200ML UNID	6.000		44	312
4178	180440	CURATIVO CICATRISAN  TRANSP.10 UND	12.000		45	312
4179	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	2.000		31	313
4180	30554	REMOVEDOR ESMALTE C/ACET.FARMAX 100ML C/12 PACK*******	4.000		32	313
4181	30660	GLICERINA PURA COSMETICA FARMAX 100ML	6.000		33	313
4182	34240	BENDITA CANFORA TABLETE ESTOJO DISP C/16(8 X3,5G) BRAVIR	1.000		34	313
4183	36145	COMPRESSA GAZE AMERICA REBECCA 9 FIOS C/500  UNIT	6.000		35	313
4184	38750	SERINGA 5ML S/AG LUER LOCK C/100UN MEDIX *************	1.000		36	313
4185	41041	AGULHA DESC BD 0,60X25 INTRAMUSCULAR CX C/100UN	1.000		37	313
4186	42641	AGULHA MEDIX 25 X 7 CX C/ 100 UNID	1.000		38	313
4187	129020	PORTA COMPRIMIDOS DISCO SEMANAL  INCOTERM BRANCO UNIT	6.000		39	313
4188	36145	COMPRESSA GAZE AMERICA REBECCA 9 FIOS C/500  UNIT	18.000		31	314
4189	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		32	315
4190	1163	SER BD SOLOMED 3ML AG 0,70X30 22G 100UN-633	1.000		33	315
4191	28169	CURATIVO CREMERCARE BEGE 10UND	60.000		34	315
4192	38172	RIODEINE DEGERMANTE 100 ML RIOQUIMICA	3.000		35	315
4193	38512	COMP. Ñ ADER.SANFARMA EST 40X10	1.000		36	315
4194	183229	FITA MICROPOROSA MISSNER 10,0CM X 4,5M	4.000		37	315
4195	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	12.000		38	315
4196	183261	FITA MICROPOROSA MISSNER 2,5CM X 0,9M	12.000		39	315
4197	31437	DERMAEX OLEO CICATRIZANTE 100ML	12.000		31	316
4198	31445	DERMAEX OLEO CICATRIZANTE 200ML	12.000		32	316
4199	34800	MICROPOROSA SALVELOX 2,5CMX4,5M UNIT	6.000		33	316
4200	34860	ESPARADRAPO SALVELOX 5CMX4,5M UNIT	6.000		34	316
4201	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	6.000		35	316
4202	37761	MICROPOROSA BEGE SALVELOX 2,5CMX4,5M	6.000		36	316
4203	40029	ESPARADRAPO SALVELOX 10CMX3M UN	3.000		37	316
4204	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	9.000		31	317
4205	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	3.000		33	318
4206	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		36	319
4207	31445	DERMAEX OLEO CICATRIZANTE 200ML	60.000		37	319
4208	31399	AGULHA P/CANETA 4MM NANO PENTAPOINT EASYFLOW 100UND	2.000		31	320
4209	148300	AGULHA DESC BD 0,30X13 INTRAD/SUBC CX C/100UN	1.000		32	320
4210	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		33	320
4211	44199	CLORETO DE MAGNESIO 33 GRS UNIPHAR	12.000		32	321
4212	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	3.000		33	321
4213	30430	BICARBONATO SODIO FARMAX POTE 100GR	24.000		34	321
4214	30457	OLEO RICINO PURO FARMAX 30ML	12.000		35	321
4215	30473	SAL AMARGO MED. POTE FARMAX 30G	6.000		36	321
4216	30740	SOLUÇÃO DE AMÔNIA FARMAX 100ML C/12 PACK****************	1.000		37	321
4217	33081	OLEO DE BANANA DILUENTE FARMAX 100ML	12.000		38	321
4218	33871	OLEO CAP/CORP.COCO FARMAX 100ML	12.000		39	321
4219	39160	VASELINA VASEMAX  FARMAX 70G	6.000		40	321
4220	30368	AGUA OXIGENADA  FARMAX 10VOL 100ML C/12UN PACK **********	1.000		31	322
4221	30384	AGUA OXIGENADA  FARMAX 10VOL SPRAY 100ML	6.000		32	322
4222	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		33	322
4223	30635	BICARBONATO SODIO FARMAX CX  50GRS	12.000		34	322
4224	39551	TINTURA DE ARNICA  UNIPHAR 30ML	3.000		35	322
4225	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		31	323
4226	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		31	324
4227	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		31	325
4228	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		31	326
4229	42021	SAB.LIQ.ENCANTO DA NATUREZA HIDRADERM FARMAX 480ML	1.000		32	326
4230	183709	CURATIVO CICATRISAN  MICROPOROSO 10 UND	12.000		33	326
4231	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		31	327
4232	183709	CURATIVO CICATRISAN  MICROPOROSO 10 UND	12.000		32	327
4233	36145	COMPRESSA GAZE AMERICA REBECCA 9 FIOS C/500  UNIT	3.000		31	328
4234	44113	RIOHEX 2% DEGERMANTE RIOQUIMICA  100 ML ALMOTOLIA	3.000		32	328
4235	183180	ESPAR MISSNER IMPERM 5,0CM X 4,5M	6.000		33	328
4236	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	12.000		34	328
4237	183261	FITA MICROPOROSA MISSNER 2,5CM X 0,9M	6.000		35	328
4238	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		31	329
4239	183709	CURATIVO CICATRISAN  MICROPOROSO 10 UND	12.000		32	329
4240	36145	COMPRESSA GAZE AMERICA REBECCA 9 FIOS C/500  UNIT	3.000		31	330
4241	38512	COMP. Ñ ADER.SANFARMA EST 40X10	4.000		32	330
4242	183199	ESPAR MISSNER IMPERM 2,5CM X 4,5M	6.000		33	330
4243	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	6.000		34	330
4244	183245	FITA MICROPOROSA MISSNER 2,5CM X 4,5M	6.000		35	330
4245	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		31	331
4246	183709	CURATIVO CICATRISAN  MICROPOROSO 10 UND	12.000		32	331
4247	1600	AGULHA DESC BD 0,70X25 INTRAMUSCULAR CX C/100UN	1.000		31	332
4248	36242	BICARBONATO DE SODIO  UNIPHAR  50G	6.000		32	332
4249	38512	COMP. Ñ ADER.SANFARMA EST 40X10	4.000		33	332
4250	183237	FITA MICROPOROSA MISSNER 5,0CM X 4,5M	3.000		34	332
4251	38512	COMP. Ñ ADER.SANFARMA EST 40X10	10.000		31	333
4252	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		31	334
4253	183709	CURATIVO CICATRISAN  MICROPOROSO 10 UND	12.000		32	334
4254	42242	ALCOOL PRING BACTERICIDA ZERO 46% CX COM 12 UNID	30.000		33	335
4255	38512	COMP. Ñ ADER.SANFARMA EST 40X10	5.000		31	336
4256	1171	SER BD SOLOMED 5ML AG 0,70X30 22G 100UN-631	1.000		31	337
4257	43346	CURATIVO C/20 MICKEY E MINNIE SANFARMA	2.000		32	337
4258	38970	ATADURA AMERICA 12CMX1.8M SOFT C/12 PACK ***************	4.000		69	338
4259	138479	MICROPOROSA BEGE CREMER 1,2CMX4,5M	6.000		70	338
4260	138487	MICROPOROSA BEGE CREMER 2,5CMX4,5M	6.000		71	338
4261	138495	MICROPOROSA BEGE CREMER 5CMX4,5M	6.000		72	338
4262	38946	ATADURA AMERICA 6CMX1.8M SOFT C/12 PACK****************	1.000		73	338
4263	38954	ATADURA AMERICA 8CMX1.8M SOFT C/12 PACK **************	1.000		74	338
4264	38997	ATADURA AMERICA 20CMX1.8M SOFT UNIT	12.000		75	338
4265	39004	ATADURA AMERICA 25CMX1.8M SOFT UNIT	12.000		76	338
4266	39012	ATADURA  AMERICA 30CMX1.8M SOFT UNIT	12.000		77	338
4267	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		78	338
4268	138509	MICROPOROSA BEGE CREMER 10CMX4,5M	3.000		79	338
4269	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		31	339
4270	35203	SERINGA INS CEPALAB  50 UI AG. 6MM CX C/100 INDIV.	1.000		33	340
4271	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		34	340
4272	31437	DERMAEX OLEO CICATRIZANTE 100ML	6.000		35	340
4273	31445	DERMAEX OLEO CICATRIZANTE 200ML	6.000		36	340
4274	42897	LAVADOR NASAL COM FRASCO 2 BICOS INF/ADUL 300 ML 3B UNIT	2.000		37	340
4275	86	AGULHA DESC BD 0,80X25 INTRAMUSCULAR CX C/100UN	2.000		31	341
4276	1600	AGULHA DESC BD 0,70X25 INTRAMUSCULAR CX C/100UN	2.000		32	341
4277	35238	TIRAS GLICOSE ON CALL PLUS C/50 UND	12.000		33	341
4278	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		34	342
4279	44172	TERMOMETRO DIGITAL  DOMOTHERM TC01 BRANCO CARTELADO	12.000		35	342
4280	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		35	343
4281	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		36	343
4282	30562	AGUA BORICADA 3% FARMAX 100ML C/12 PACK *********	1.000		37	343
4283	38512	COMP. Ñ ADER.SANFARMA EST 40X10	2.000		38	343
4284	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	3.000		33	344
4285	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	2.000		34	345
4286	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		35	345
4287	41050	AGULHA DESC BD 0,60X30 INTRAMUSCULAR CX C/100UN	1.000		36	345
4288	43591	UMIDIFICADOR 2,1L CLEAR TANK MULTILASER HC210	1.000		37	345
4289	174505	SER BD 20ML S/AGULHA LUER SLIP UND	12.000		38	345
4290	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	2.000		33	346
4291	174505	SER BD 20ML S/AGULHA LUER SLIP UND	12.000		34	346
4292	31330	SORO FISIOL.SORIMAX 500ML 24UN CX **************	1.000		32	347
4293	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	6.000		33	347
4294	639	ESPARADRAPO BRANCO CREMER 2,5CMX4,5M	6.000		34	347
4295	1350	POVIDINE TOPICO ALMOTOLIA 100ML	3.000		35	347
4296	30430	BICARBONATO SODIO FARMAX POTE 100GR	12.000		36	347
4297	30864	LIMPADOR DE LINGUA DENTLIMP	3.000		37	347
4298	31399	AGULHA P/CANETA 4MM NANO PENTAPOINT EASYFLOW 100UND	1.000		38	347
4299	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		39	347
4300	124	ALGODAO APOLO 50GR C/ 20UNID PACK***************	1.000		31	348
4301	132	ALGODAO APOLO 100GR C/ 10UNID PACK***********	1.000		32	348
4302	30589	TINTURA DE IODO 2% FARMAX 30ML	12.000		33	348
4303	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	1.000		34	348
4304	38032	HASTES FLEXIVEIS PATRULHA CANINA CREMER C/75 UNID.	24.000		35	348
4305	132	ALGODAO APOLO 100GR C/ 10UNID PACK***********	1.000		31	349
4306	30589	TINTURA DE IODO 2% FARMAX 30ML	12.000		32	349
4307	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	1.000		33	349
4308	35858	VIOLETA GENCIANA UNIPHAR 30ML UNIT	2.000		34	349
4309	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	2.000		33	350
4310	30651	ALGODAO APOLO 25GR C/20UNID PACK ***********	1.000		34	350
4311	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		35	350
4312	34657	ALCOOL PRING MEDICAL 70º GL 1LT CX C/12*****************	1.000		32	351
4313	30589	TINTURA DE IODO 2% FARMAX 30ML	2.000		33	351
4314	34240	BENDITA CANFORA TABLETE ESTOJO DISP C/16(8 X3,5G) BRAVIR	1.000		34	351
4315	311219	OLEO CORPORAL DE GIRASSOL FARMAX 100ML	4.000		35	351
4316	44130	SABONETE DE COCO 100 GRS	10.000		31	352
4317	154229	SER BD INS 50UI AG 6MM 10X10UN- 917	1.000		32	352
4318	132	ALGODAO APOLO 100GR C/ 10UNID PACK***********	1.000		31	353
4319	31399	AGULHA P/CANETA 4MM NANO PENTAPOINT EASYFLOW 100UND	3.000		32	353
4320	38032	HASTES FLEXIVEIS PATRULHA CANINA CREMER C/75 UNID.	2.000		33	353
4321	132	ALGODAO APOLO 100GR C/ 10UNID PACK***********	2.000		31	354
4322	620	ESPARADRAPO BRANCO CREMER 1,2CMX4,5M	6.000		32	354
4323	30589	TINTURA DE IODO 2% FARMAX 30ML	6.000		33	354
4324	37702	CURATIVO MARROM ESCURO CREMER  C/10	3.000		34	354
4325	180440	CURATIVO CICATRISAN  TRANSP.10 UND	12.000		35	354
4326	183709	CURATIVO CICATRISAN  MICROPOROSO 10 UND	7.000		36	354
4327	34240	BENDITA CANFORA TABLETE ESTOJO DISP C/16(8 X3,5G) BRAVIR	1.000		31	355
\.


--
-- Data for Name: pedido_volumes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido_volumes (id, volume_num, total_volumes, criado_em, pedido_id) FROM stdin;
2426	1	1	2026-03-05 15:21:30.76173+00	88
2439	1	3	2026-03-05 16:15:19.348299+00	50
2440	2	3	2026-03-05 16:15:19.354691+00	50
2441	3	3	2026-03-05 16:15:19.360094+00	50
2454	1	3	2026-03-05 17:48:37.515446+00	55
2455	2	3	2026-03-05 17:48:37.522339+00	55
2456	3	3	2026-03-05 17:48:37.528182+00	55
301295	1	1	2026-03-05 19:01:38.308234+00	26
301570	1	1	2026-03-06 20:03:23.221108+00	126
2484	1	1	2026-03-05 18:43:05.228673+00	61
301690	1	1	2026-03-09 13:41:01.342376+00	144
2427	1	3	2026-03-05 15:30:21.187345+00	33
2428	2	3	2026-03-05 15:30:21.193545+00	33
2429	3	3	2026-03-05 15:30:21.198773+00	33
2442	1	4	2026-03-05 16:29:48.877371+00	48
2443	2	4	2026-03-05 16:29:48.888132+00	48
2444	3	4	2026-03-05 16:29:48.898006+00	48
2445	4	4	2026-03-05 16:29:48.907793+00	48
2457	1	1	2026-03-05 17:50:13.239491+00	40
2473	1	2	2026-03-05 18:19:03.408432+00	89
2474	2	2	2026-03-05 18:19:03.411374+00	89
2485	1	1	2026-03-05 18:46:30.193031+00	15
301296	1	7	2026-03-05 19:23:13.15916+00	91
301297	2	7	2026-03-05 19:23:13.171854+00	91
301298	3	7	2026-03-05 19:23:13.182997+00	91
301299	4	7	2026-03-05 19:23:13.19409+00	91
301300	5	7	2026-03-05 19:23:13.205047+00	91
301301	6	7	2026-03-05 19:23:13.216019+00	91
301302	7	7	2026-03-05 19:23:13.227086+00	91
301571	1	2	2026-03-06 20:08:50.501039+00	127
301572	2	2	2026-03-06 20:08:50.506652+00	127
301691	1	1	2026-03-09 13:44:20.018916+00	145
301960	1	1	2026-03-10 17:30:21.988368+00	186
302048	1	1	2026-03-11 14:46:00.353325+00	212
302319	1	1	2026-03-12 12:54:17.211521+00	241
302492	1	1	2026-03-12 19:09:02.441306+00	285
2430	1	1	2026-03-05 15:36:17.750733+00	46
2446	1	1	2026-03-05 17:00:13.974118+00	49
2458	1	3	2026-03-05 17:56:16.959568+00	57
2459	2	3	2026-03-05 17:56:16.963097+00	57
2460	3	3	2026-03-05 17:56:16.965784+00	57
2475	1	3	2026-03-05 18:22:33.449868+00	52
2476	2	3	2026-03-05 18:22:33.453951+00	52
2477	3	3	2026-03-05 18:22:33.456953+00	52
2486	1	3	2026-03-05 18:49:54.514235+00	29
2487	2	3	2026-03-05 18:49:54.51601+00	29
2488	3	3	2026-03-05 18:49:54.517035+00	29
301303	1	1	2026-03-05 19:26:21.600846+00	10
301573	1	4	2026-03-06 20:20:12.884206+00	122
301574	2	4	2026-03-06 20:20:12.894274+00	122
301575	3	4	2026-03-06 20:20:12.903354+00	122
301576	4	4	2026-03-06 20:20:12.912131+00	122
301692	1	6	2026-03-09 13:48:28.089869+00	148
301693	2	6	2026-03-09 13:48:28.09572+00	148
301694	3	6	2026-03-09 13:48:28.1006+00	148
301695	4	6	2026-03-09 13:48:28.105384+00	148
301696	5	6	2026-03-09 13:48:28.110286+00	148
301697	6	6	2026-03-09 13:48:28.115065+00	148
301940	1	3	2026-03-10 16:14:46.000828+00	187
301941	2	3	2026-03-10 16:14:46.002784+00	187
301942	3	3	2026-03-10 16:14:46.003917+00	187
301961	1	4	2026-03-10 17:47:45.568312+00	201
301962	2	4	2026-03-10 17:47:45.572333+00	201
301963	3	4	2026-03-10 17:47:45.575348+00	201
301964	4	4	2026-03-10 17:47:45.578495+00	201
302049	1	1	2026-03-11 14:47:14.119189+00	209
302311	1	1	2026-03-11 20:29:18.413058+00	251
302320	1	3	2026-03-12 13:04:43.206355+00	240
302321	2	3	2026-03-12 13:04:43.213701+00	240
302322	3	3	2026-03-12 13:04:43.219954+00	240
302493	1	1	2026-03-12 19:15:26.925328+00	284
302987	1	2	2026-03-16 20:15:52.781304+00	351
302988	2	2	2026-03-16 20:15:52.784638+00	351
2431	1	2	2026-03-05 15:48:11.151669+00	34
2432	2	2	2026-03-05 15:48:11.157007+00	34
2447	1	1	2026-03-05 17:06:51.139297+00	51
301304	1	1	2026-03-05 19:33:13.002037+00	11
301698	1	1	2026-03-09 13:53:38.41954+00	150
301943	1	4	2026-03-10 16:17:57.79373+00	185
301944	2	4	2026-03-10 16:17:57.796109+00	185
301945	3	4	2026-03-10 16:17:57.79768+00	185
301946	4	4	2026-03-10 16:17:57.799129+00	185
301965	1	1	2026-03-10 18:02:28.925831+00	188
302312	1	4	2026-03-12 12:48:39.092012+00	258
302313	2	4	2026-03-12 12:48:39.098916+00	258
302314	3	4	2026-03-12 12:48:39.101993+00	258
302315	4	4	2026-03-12 12:48:39.104897+00	258
302323	1	3	2026-03-12 13:08:40.766235+00	243
302324	2	3	2026-03-12 13:08:40.769725+00	243
302325	3	3	2026-03-12 13:08:40.772112+00	243
2433	1	2	2026-03-05 15:59:08.14085+00	37
2434	2	2	2026-03-05 15:59:08.147216+00	37
2448	1	2	2026-03-05 17:16:28.126911+00	3
2449	2	2	2026-03-05 17:16:28.133904+00	3
2462	1	3	2026-03-05 18:02:47.094434+00	58
2463	2	3	2026-03-05 18:02:47.097677+00	58
2464	3	3	2026-03-05 18:02:47.099779+00	58
2479	1	2	2026-03-05 18:33:22.95127+00	90
2480	2	2	2026-03-05 18:33:22.953107+00	90
301578	1	1	2026-03-06 20:25:32.324174+00	131
301699	1	2	2026-03-09 13:57:46.294291+00	149
301700	2	2	2026-03-09 13:57:46.296357+00	149
301947	1	1	2026-03-10 16:38:46.722368+00	203
301966	1	3	2026-03-10 18:28:53.444307+00	192
301967	2	3	2026-03-10 18:28:53.466908+00	192
301968	3	3	2026-03-10 18:28:53.489819+00	192
302055	1	5	2026-03-11 14:52:39.630761+00	223
302056	2	5	2026-03-11 14:52:39.633537+00	223
302057	3	5	2026-03-11 14:52:39.635556+00	223
302058	4	5	2026-03-11 14:52:39.637583+00	223
302059	5	5	2026-03-11 14:52:39.639571+00	223
302316	1	1	2026-03-12 12:51:07.533579+00	260
302326	1	1	2026-03-12 13:11:29.678654+00	226
302495	1	2	2026-03-12 19:21:39.535264+00	280
302496	2	2	2026-03-12 19:21:39.538219+00	280
1818	1	3	2026-03-05 15:17:57.132116+00	2
1819	2	3	2026-03-05 15:17:57.132958+00	2
1820	3	3	2026-03-05 15:17:57.133521+00	2
1828	1	11	2026-03-05 15:17:57.568503+00	4
1829	2	11	2026-03-05 15:17:57.569011+00	4
1830	3	11	2026-03-05 15:17:57.56952+00	4
1831	4	11	2026-03-05 15:17:57.570045+00	4
1832	5	11	2026-03-05 15:17:57.570552+00	4
1833	6	11	2026-03-05 15:17:57.571032+00	4
1834	7	11	2026-03-05 15:17:57.571522+00	4
1835	8	11	2026-03-05 15:17:57.571985+00	4
1836	9	11	2026-03-05 15:17:57.5725+00	4
1837	10	11	2026-03-05 15:17:57.572967+00	4
1838	11	11	2026-03-05 15:17:57.573444+00	4
1839	1	6	2026-03-05 15:17:57.775309+00	5
1840	2	6	2026-03-05 15:17:57.775816+00	5
1841	3	6	2026-03-05 15:17:57.776317+00	5
1842	4	6	2026-03-05 15:17:57.776786+00	5
1843	5	6	2026-03-05 15:17:57.77727+00	5
1844	6	6	2026-03-05 15:17:57.777765+00	5
1845	1	3	2026-03-05 15:17:57.953709+00	6
1846	2	3	2026-03-05 15:17:57.954261+00	6
1847	3	3	2026-03-05 15:17:57.954771+00	6
1851	1	14	2026-03-05 15:17:58.724225+00	8
1852	2	14	2026-03-05 15:17:58.724859+00	8
1853	3	14	2026-03-05 15:17:58.725491+00	8
1854	4	14	2026-03-05 15:17:58.726104+00	8
1855	5	14	2026-03-05 15:17:58.72672+00	8
1856	6	14	2026-03-05 15:17:58.727347+00	8
1857	7	14	2026-03-05 15:17:58.727936+00	8
1858	8	14	2026-03-05 15:17:58.728564+00	8
1859	9	14	2026-03-05 15:17:58.729175+00	8
1860	10	14	2026-03-05 15:17:58.729773+00	8
1861	11	14	2026-03-05 15:17:58.73039+00	8
1862	12	14	2026-03-05 15:17:58.730989+00	8
1863	13	14	2026-03-05 15:17:58.731607+00	8
1864	14	14	2026-03-05 15:17:58.732237+00	8
1882	1	17	2026-03-05 15:18:00.249986+00	1
1883	2	17	2026-03-05 15:18:00.250652+00	1
1884	3	17	2026-03-05 15:18:00.251272+00	1
1885	4	17	2026-03-05 15:18:00.251873+00	1
1886	5	17	2026-03-05 15:18:00.252489+00	1
1887	6	17	2026-03-05 15:18:00.253071+00	1
1888	7	17	2026-03-05 15:18:00.253685+00	1
1889	8	17	2026-03-05 15:18:00.254291+00	1
1890	9	17	2026-03-05 15:18:00.254884+00	1
1891	10	17	2026-03-05 15:18:00.255518+00	1
1892	11	17	2026-03-05 15:18:00.256255+00	1
1893	12	17	2026-03-05 15:18:00.257219+00	1
1894	13	17	2026-03-05 15:18:00.257832+00	1
1895	14	17	2026-03-05 15:18:00.258436+00	1
1896	15	17	2026-03-05 15:18:00.259024+00	1
1897	16	17	2026-03-05 15:18:00.259639+00	1
1898	17	17	2026-03-05 15:18:00.260247+00	1
1899	1	4	2026-03-05 15:18:00.593335+00	9
1900	2	4	2026-03-05 15:18:00.593993+00	9
1901	3	4	2026-03-05 15:18:00.594608+00	9
1902	4	4	2026-03-05 15:18:00.595217+00	9
1907	1	2	2026-03-05 15:18:01.254489+00	12
1908	2	2	2026-03-05 15:18:01.255024+00	12
1909	1	2	2026-03-05 15:18:01.669799+00	13
1910	2	2	2026-03-05 15:18:01.671453+00	13
1911	1	3	2026-03-05 15:18:01.941164+00	14
1912	2	3	2026-03-05 15:18:01.943596+00	14
1913	3	3	2026-03-05 15:18:01.949317+00	14
1917	1	3	2026-03-05 15:18:02.721262+00	16
1918	2	3	2026-03-05 15:18:02.722009+00	16
1919	3	3	2026-03-05 15:18:02.72255+00	16
1923	1	4	2026-03-05 15:18:03.19211+00	18
1924	2	4	2026-03-05 15:18:03.19263+00	18
1925	3	4	2026-03-05 15:18:03.193098+00	18
1926	4	4	2026-03-05 15:18:03.193577+00	18
1927	1	4	2026-03-05 15:18:03.387766+00	19
1928	2	4	2026-03-05 15:18:03.388291+00	19
1929	3	4	2026-03-05 15:18:03.388769+00	19
1930	4	4	2026-03-05 15:18:03.389354+00	19
1931	1	4	2026-03-05 15:18:03.583845+00	20
1932	2	4	2026-03-05 15:18:03.584354+00	20
1933	3	4	2026-03-05 15:18:03.58483+00	20
1934	4	4	2026-03-05 15:18:03.585322+00	20
1935	1	3	2026-03-05 15:18:03.768816+00	21
1936	2	3	2026-03-05 15:18:03.769339+00	21
1937	3	3	2026-03-05 15:18:03.769889+00	21
1938	1	3	2026-03-05 15:18:03.959965+00	22
1939	2	3	2026-03-05 15:18:03.960486+00	22
1940	3	3	2026-03-05 15:18:03.960969+00	22
1941	1	4	2026-03-05 15:18:04.16429+00	23
1942	2	4	2026-03-05 15:18:04.164791+00	23
1943	3	4	2026-03-05 15:18:04.165282+00	23
1944	4	4	2026-03-05 15:18:04.16576+00	23
1945	1	4	2026-03-05 15:18:04.355205+00	24
1946	2	4	2026-03-05 15:18:04.355701+00	24
1947	3	4	2026-03-05 15:18:04.356205+00	24
1948	4	4	2026-03-05 15:18:04.356675+00	24
1949	1	3	2026-03-05 15:18:04.539956+00	25
1950	2	3	2026-03-05 15:18:04.540483+00	25
1951	3	3	2026-03-05 15:18:04.541053+00	25
1955	1	4	2026-03-05 15:18:04.971743+00	27
1956	2	4	2026-03-05 15:18:04.972315+00	27
1957	3	4	2026-03-05 15:18:04.972856+00	27
1958	4	4	2026-03-05 15:18:04.973392+00	27
1959	1	3	2026-03-05 15:18:05.196693+00	28
1960	2	3	2026-03-05 15:18:05.197223+00	28
1961	3	3	2026-03-05 15:18:05.197801+00	28
301306	1	5	2026-03-05 19:38:38.236514+00	92
301307	2	5	2026-03-05 19:38:38.238505+00	92
301308	3	5	2026-03-05 19:38:38.239587+00	92
1965	1	2	2026-03-05 15:18:05.608+00	30
1966	2	2	2026-03-05 15:18:05.608501+00	30
1967	1	2	2026-03-05 15:18:05.795259+00	31
1968	2	2	2026-03-05 15:18:05.795751+00	31
1969	1	1	2026-03-05 15:18:05.967622+00	32
301309	4	5	2026-03-05 19:38:38.240639+00	92
301310	5	5	2026-03-05 19:38:38.24176+00	92
301701	1	1	2026-03-09 14:03:17.661431+00	152
2450	1	1	2026-03-05 17:25:42.559775+00	86
2465	1	3	2026-03-05 18:08:30.420056+00	17
2466	2	3	2026-03-05 18:08:30.422393+00	17
2467	3	3	2026-03-05 18:08:30.423874+00	17
2481	1	2	2026-03-05 18:34:26.828429+00	39
1981	1	3	2026-03-05 15:18:06.73825+00	36
1982	2	3	2026-03-05 15:18:06.738864+00	36
1983	3	3	2026-03-05 15:18:06.739468+00	36
301969	1	3	2026-03-10 18:56:30.016074+00	198
301970	2	3	2026-03-10 18:56:30.021683+00	198
301971	3	3	2026-03-10 18:56:30.025994+00	198
1991	1	3	2026-03-05 15:18:07.172532+00	38
1992	2	3	2026-03-05 15:18:07.173132+00	38
1993	3	3	2026-03-05 15:18:07.173756+00	38
302060	1	1	2026-03-11 14:58:17.913183+00	210
302317	1	2	2026-03-12 12:52:06.306855+00	229
1996	1	5	2026-03-05 15:18:07.711812+00	41
1997	2	5	2026-03-05 15:18:07.712325+00	41
1998	3	5	2026-03-05 15:18:07.712795+00	41
1999	4	5	2026-03-05 15:18:07.71327+00	41
2000	5	5	2026-03-05 15:18:07.713799+00	41
302318	2	2	2026-03-12 12:52:06.308824+00	229
302327	1	1	2026-03-12 13:13:30.335373+00	227
302497	1	3	2026-03-12 19:22:52.840407+00	278
302498	2	3	2026-03-12 19:22:52.842297+00	278
302499	3	3	2026-03-12 19:22:52.843348+00	278
2006	1	4	2026-03-05 15:18:08.12299+00	43
2007	2	4	2026-03-05 15:18:08.123504+00	43
2008	3	4	2026-03-05 15:18:08.124042+00	43
2009	4	4	2026-03-05 15:18:08.124582+00	43
2010	1	5	2026-03-05 15:18:08.318916+00	44
2011	2	5	2026-03-05 15:18:08.319438+00	44
2012	3	5	2026-03-05 15:18:08.319908+00	44
2013	4	5	2026-03-05 15:18:08.320385+00	44
2014	5	5	2026-03-05 15:18:08.320843+00	44
2015	1	2	2026-03-05 15:18:08.498798+00	45
2016	2	2	2026-03-05 15:18:08.499312+00	45
2482	2	2	2026-03-05 18:34:26.830307+00	39
2021	1	2	2026-03-05 15:18:08.862694+00	47
2022	2	2	2026-03-05 15:18:08.863228+00	47
301580	1	1	2026-03-06 20:28:08.432632+00	132
301702	1	2	2026-03-09 14:12:04.897233+00	151
301703	2	2	2026-03-09 14:12:04.904308+00	151
301954	1	6	2026-03-10 17:05:07.486531+00	202
301955	2	6	2026-03-10 17:05:07.495805+00	202
301956	3	6	2026-03-10 17:05:07.503939+00	202
301957	4	6	2026-03-10 17:05:07.511981+00	202
2076	1	11	2026-03-05 15:18:10.50902+00	53
2077	2	11	2026-03-05 15:18:10.509521+00	53
2078	3	11	2026-03-05 15:18:10.51008+00	53
2079	4	11	2026-03-05 15:18:10.510556+00	53
2080	5	11	2026-03-05 15:18:10.511005+00	53
2081	6	11	2026-03-05 15:18:10.511478+00	53
2082	7	11	2026-03-05 15:18:10.511933+00	53
2083	8	11	2026-03-05 15:18:10.512397+00	53
2084	9	11	2026-03-05 15:18:10.512873+00	53
2085	10	11	2026-03-05 15:18:10.513343+00	53
2086	11	11	2026-03-05 15:18:10.513924+00	53
2087	1	100	2026-03-05 15:18:10.903472+00	54
2088	2	100	2026-03-05 15:18:10.904001+00	54
2089	3	100	2026-03-05 15:18:10.904503+00	54
2090	4	100	2026-03-05 15:18:10.904981+00	54
2091	5	100	2026-03-05 15:18:10.905464+00	54
2092	6	100	2026-03-05 15:18:10.906001+00	54
2093	7	100	2026-03-05 15:18:10.906497+00	54
2094	8	100	2026-03-05 15:18:10.906977+00	54
2095	9	100	2026-03-05 15:18:10.907455+00	54
2096	10	100	2026-03-05 15:18:10.907921+00	54
2097	11	100	2026-03-05 15:18:10.9084+00	54
2098	12	100	2026-03-05 15:18:10.908862+00	54
2099	13	100	2026-03-05 15:18:10.909341+00	54
2100	14	100	2026-03-05 15:18:10.909914+00	54
2101	15	100	2026-03-05 15:18:10.910406+00	54
2102	16	100	2026-03-05 15:18:10.910872+00	54
2103	17	100	2026-03-05 15:18:10.911342+00	54
2104	18	100	2026-03-05 15:18:10.911805+00	54
2105	19	100	2026-03-05 15:18:10.912297+00	54
2106	20	100	2026-03-05 15:18:10.91276+00	54
2107	21	100	2026-03-05 15:18:10.913245+00	54
2108	22	100	2026-03-05 15:18:10.913788+00	54
2109	23	100	2026-03-05 15:18:10.914283+00	54
2110	24	100	2026-03-05 15:18:10.914748+00	54
2111	25	100	2026-03-05 15:18:10.915235+00	54
2112	26	100	2026-03-05 15:18:10.915698+00	54
2113	27	100	2026-03-05 15:18:10.91618+00	54
2114	28	100	2026-03-05 15:18:10.916641+00	54
2115	29	100	2026-03-05 15:18:10.917113+00	54
2116	30	100	2026-03-05 15:18:10.917634+00	54
2117	31	100	2026-03-05 15:18:10.9181+00	54
2118	32	100	2026-03-05 15:18:10.918586+00	54
2119	33	100	2026-03-05 15:18:10.919044+00	54
2120	34	100	2026-03-05 15:18:10.91953+00	54
2121	35	100	2026-03-05 15:18:10.919998+00	54
2122	36	100	2026-03-05 15:18:10.920474+00	54
2123	37	100	2026-03-05 15:18:10.920934+00	54
2124	38	100	2026-03-05 15:18:10.921407+00	54
2125	39	100	2026-03-05 15:18:10.921917+00	54
2126	40	100	2026-03-05 15:18:10.922403+00	54
2127	41	100	2026-03-05 15:18:10.922897+00	54
2128	42	100	2026-03-05 15:18:10.923369+00	54
2129	43	100	2026-03-05 15:18:10.92383+00	54
2130	44	100	2026-03-05 15:18:10.924317+00	54
2131	45	100	2026-03-05 15:18:10.924781+00	54
2132	46	100	2026-03-05 15:18:10.925261+00	54
2133	47	100	2026-03-05 15:18:10.925765+00	54
2134	48	100	2026-03-05 15:18:10.926261+00	54
2135	49	100	2026-03-05 15:18:10.926718+00	54
2136	50	100	2026-03-05 15:18:10.9272+00	54
2137	51	100	2026-03-05 15:18:10.927657+00	54
2138	52	100	2026-03-05 15:18:10.928113+00	54
2139	53	100	2026-03-05 15:18:10.928597+00	54
2140	54	100	2026-03-05 15:18:10.929056+00	54
2141	55	100	2026-03-05 15:18:10.929527+00	54
2142	56	100	2026-03-05 15:18:10.930022+00	54
2143	57	100	2026-03-05 15:18:10.930497+00	54
2144	58	100	2026-03-05 15:18:10.930966+00	54
2145	59	100	2026-03-05 15:18:10.931436+00	54
2146	60	100	2026-03-05 15:18:10.931897+00	54
2147	61	100	2026-03-05 15:18:10.93237+00	54
2148	62	100	2026-03-05 15:18:10.932827+00	54
2149	63	100	2026-03-05 15:18:10.933315+00	54
2150	64	100	2026-03-05 15:18:10.933815+00	54
2151	65	100	2026-03-05 15:18:10.934299+00	54
2152	66	100	2026-03-05 15:18:10.934762+00	54
2153	67	100	2026-03-05 15:18:10.93525+00	54
2154	68	100	2026-03-05 15:18:10.93571+00	54
2155	69	100	2026-03-05 15:18:10.9362+00	54
2156	70	100	2026-03-05 15:18:10.93669+00	54
2157	71	100	2026-03-05 15:18:10.937175+00	54
2158	72	100	2026-03-05 15:18:10.937684+00	54
2159	73	100	2026-03-05 15:18:10.938166+00	54
2160	74	100	2026-03-05 15:18:10.938627+00	54
2161	75	100	2026-03-05 15:18:10.939084+00	54
2162	76	100	2026-03-05 15:18:10.939564+00	54
2163	77	100	2026-03-05 15:18:10.940025+00	54
2164	78	100	2026-03-05 15:18:10.940543+00	54
2165	79	100	2026-03-05 15:18:10.941003+00	54
2166	80	100	2026-03-05 15:18:10.941579+00	54
2167	81	100	2026-03-05 15:18:10.942089+00	54
2168	82	100	2026-03-05 15:18:10.942567+00	54
2169	83	100	2026-03-05 15:18:10.943026+00	54
2170	84	100	2026-03-05 15:18:10.943511+00	54
2171	85	100	2026-03-05 15:18:10.943982+00	54
2172	86	100	2026-03-05 15:18:10.944461+00	54
2173	87	100	2026-03-05 15:18:10.94493+00	54
2174	88	100	2026-03-05 15:18:10.9454+00	54
2175	89	100	2026-03-05 15:18:10.945892+00	54
2176	90	100	2026-03-05 15:18:10.946401+00	54
2177	91	100	2026-03-05 15:18:10.946857+00	54
2178	92	100	2026-03-05 15:18:10.947331+00	54
2179	93	100	2026-03-05 15:18:10.947791+00	54
2180	94	100	2026-03-05 15:18:10.948268+00	54
2181	95	100	2026-03-05 15:18:10.948716+00	54
2182	96	100	2026-03-05 15:18:10.94928+00	54
2183	97	100	2026-03-05 15:18:10.949843+00	54
2184	98	100	2026-03-05 15:18:10.950355+00	54
2185	99	100	2026-03-05 15:18:10.950812+00	54
2186	100	100	2026-03-05 15:18:10.9513+00	54
301958	5	6	2026-03-10 17:05:07.520153+00	202
301959	6	6	2026-03-10 17:05:07.528081+00	202
301972	1	2	2026-03-10 19:02:34.257036+00	200
301973	2	2	2026-03-10 19:02:34.261481+00	200
302061	1	4	2026-03-11 15:01:47.69297+00	214
302062	2	4	2026-03-11 15:01:47.694791+00	214
302063	3	4	2026-03-11 15:01:47.695831+00	214
302064	4	4	2026-03-11 15:01:47.696821+00	214
302328	1	5	2026-03-12 13:21:14.50522+00	242
302329	2	5	2026-03-12 13:21:14.514317+00	242
302330	3	5	2026-03-12 13:21:14.522015+00	242
2198	1	3	2026-03-05 15:18:11.384888+00	56
2199	2	3	2026-03-05 15:18:11.385422+00	56
2200	3	3	2026-03-05 15:18:11.386024+00	56
302331	4	5	2026-03-12 13:21:14.529712+00	242
302332	5	5	2026-03-12 13:21:14.537292+00	242
302500	1	3	2026-03-12 19:30:36.600058+00	283
2208	1	2	2026-03-05 15:18:11.93149+00	59
2209	2	2	2026-03-05 15:18:11.931985+00	59
2210	1	1	2026-03-05 15:18:12.112242+00	60
301704	1	2	2026-03-09 14:27:01.540883+00	155
301705	2	2	2026-03-09 14:27:01.544816+00	155
301974	1	4	2026-03-10 19:26:22.899661+00	197
301975	2	4	2026-03-10 19:26:22.912488+00	197
301976	3	4	2026-03-10 19:26:22.924094+00	197
301977	4	4	2026-03-10 19:26:22.93666+00	197
302065	1	6	2026-03-11 15:05:28.569082+00	222
302066	2	6	2026-03-11 15:05:28.572061+00	222
302067	3	6	2026-03-11 15:05:28.574058+00	222
302068	4	6	2026-03-11 15:05:28.576008+00	222
2221	1	50	2026-03-05 15:18:12.820728+00	63
2222	2	50	2026-03-05 15:18:12.821301+00	63
2223	3	50	2026-03-05 15:18:12.821972+00	63
2224	4	50	2026-03-05 15:18:12.822467+00	63
2225	5	50	2026-03-05 15:18:12.822937+00	63
2226	6	50	2026-03-05 15:18:12.823413+00	63
2227	7	50	2026-03-05 15:18:12.823873+00	63
2228	8	50	2026-03-05 15:18:12.824351+00	63
2229	9	50	2026-03-05 15:18:12.824821+00	63
2230	10	50	2026-03-05 15:18:12.825303+00	63
2231	11	50	2026-03-05 15:18:12.825778+00	63
2232	12	50	2026-03-05 15:18:12.826264+00	63
2233	13	50	2026-03-05 15:18:12.82672+00	63
2234	14	50	2026-03-05 15:18:12.827285+00	63
2235	15	50	2026-03-05 15:18:12.827743+00	63
2236	16	50	2026-03-05 15:18:12.828227+00	63
2237	17	50	2026-03-05 15:18:12.828694+00	63
2238	18	50	2026-03-05 15:18:12.829173+00	63
2239	19	50	2026-03-05 15:18:12.829645+00	63
2240	20	50	2026-03-05 15:18:12.830099+00	63
2241	21	50	2026-03-05 15:18:12.830574+00	63
2242	22	50	2026-03-05 15:18:12.831033+00	63
2243	23	50	2026-03-05 15:18:12.831515+00	63
2244	24	50	2026-03-05 15:18:12.831969+00	63
2245	25	50	2026-03-05 15:18:12.832437+00	63
2246	26	50	2026-03-05 15:18:12.832889+00	63
2247	27	50	2026-03-05 15:18:12.833368+00	63
2248	28	50	2026-03-05 15:18:12.833841+00	63
2249	29	50	2026-03-05 15:18:12.834321+00	63
2250	30	50	2026-03-05 15:18:12.834778+00	63
2251	31	50	2026-03-05 15:18:12.83526+00	63
2252	32	50	2026-03-05 15:18:12.835716+00	63
2253	33	50	2026-03-05 15:18:12.836192+00	63
2254	34	50	2026-03-05 15:18:12.836646+00	63
2255	35	50	2026-03-05 15:18:12.837102+00	63
2256	36	50	2026-03-05 15:18:12.837599+00	63
2257	37	50	2026-03-05 15:18:12.838067+00	63
2258	38	50	2026-03-05 15:18:12.83854+00	63
2259	39	50	2026-03-05 15:18:12.838996+00	63
2260	40	50	2026-03-05 15:18:12.839465+00	63
2261	41	50	2026-03-05 15:18:12.839921+00	63
2262	42	50	2026-03-05 15:18:12.840389+00	63
2263	43	50	2026-03-05 15:18:12.840843+00	63
2264	44	50	2026-03-05 15:18:12.841321+00	63
2265	45	50	2026-03-05 15:18:12.841826+00	63
2266	46	50	2026-03-05 15:18:12.842309+00	63
2267	47	50	2026-03-05 15:18:12.842765+00	63
2268	48	50	2026-03-05 15:18:12.843338+00	63
2269	49	50	2026-03-05 15:18:12.843793+00	63
2270	50	50	2026-03-05 15:18:12.844266+00	63
2271	1	3	2026-03-05 15:18:13.04448+00	64
2272	2	3	2026-03-05 15:18:13.044973+00	64
2273	3	3	2026-03-05 15:18:13.045452+00	64
2274	1	7	2026-03-05 15:18:13.259803+00	65
2275	2	7	2026-03-05 15:18:13.260327+00	65
2276	3	7	2026-03-05 15:18:13.260812+00	65
2277	4	7	2026-03-05 15:18:13.261304+00	65
2278	5	7	2026-03-05 15:18:13.261793+00	65
2279	6	7	2026-03-05 15:18:13.262277+00	65
2280	7	7	2026-03-05 15:18:13.262734+00	65
2281	1	2	2026-03-05 15:18:13.448035+00	66
2282	2	2	2026-03-05 15:18:13.44855+00	66
2283	1	3	2026-03-05 15:18:13.632277+00	67
2284	2	3	2026-03-05 15:18:13.632782+00	67
2285	3	3	2026-03-05 15:18:13.633278+00	67
2286	1	14	2026-03-05 15:18:13.928446+00	68
2287	2	14	2026-03-05 15:18:13.92894+00	68
2288	3	14	2026-03-05 15:18:13.929529+00	68
2289	4	14	2026-03-05 15:18:13.929997+00	68
2290	5	14	2026-03-05 15:18:13.930474+00	68
2291	6	14	2026-03-05 15:18:13.930929+00	68
2292	7	14	2026-03-05 15:18:13.931414+00	68
2293	8	14	2026-03-05 15:18:13.931866+00	68
2294	9	14	2026-03-05 15:18:13.932334+00	68
2295	10	14	2026-03-05 15:18:13.932825+00	68
2296	11	14	2026-03-05 15:18:13.933466+00	68
2297	12	14	2026-03-05 15:18:13.933936+00	68
2298	13	14	2026-03-05 15:18:13.93441+00	68
2299	14	14	2026-03-05 15:18:13.934869+00	68
2300	1	48	2026-03-05 15:18:14.344887+00	69
2301	2	48	2026-03-05 15:18:14.345399+00	69
2302	3	48	2026-03-05 15:18:14.345896+00	69
2303	4	48	2026-03-05 15:18:14.346372+00	69
2304	5	48	2026-03-05 15:18:14.346835+00	69
2305	6	48	2026-03-05 15:18:14.347318+00	69
2306	7	48	2026-03-05 15:18:14.347779+00	69
2307	8	48	2026-03-05 15:18:14.348269+00	69
2308	9	48	2026-03-05 15:18:14.348724+00	69
2309	10	48	2026-03-05 15:18:14.349202+00	69
2310	11	48	2026-03-05 15:18:14.349691+00	69
2311	12	48	2026-03-05 15:18:14.350175+00	69
2312	13	48	2026-03-05 15:18:14.350631+00	69
2313	14	48	2026-03-05 15:18:14.351084+00	69
2314	15	48	2026-03-05 15:18:14.351559+00	69
2315	16	48	2026-03-05 15:18:14.352007+00	69
2316	17	48	2026-03-05 15:18:14.352508+00	69
2317	18	48	2026-03-05 15:18:14.352962+00	69
2318	19	48	2026-03-05 15:18:14.353434+00	69
2319	20	48	2026-03-05 15:18:14.353933+00	69
2320	21	48	2026-03-05 15:18:14.354412+00	69
2321	22	48	2026-03-05 15:18:14.354863+00	69
2322	23	48	2026-03-05 15:18:14.355336+00	69
2323	24	48	2026-03-05 15:18:14.355791+00	69
2324	25	48	2026-03-05 15:18:14.356264+00	69
2325	26	48	2026-03-05 15:18:14.356844+00	69
2326	27	48	2026-03-05 15:18:14.357328+00	69
2327	28	48	2026-03-05 15:18:14.357821+00	69
2328	29	48	2026-03-05 15:18:14.358299+00	69
2329	30	48	2026-03-05 15:18:14.358756+00	69
2330	31	48	2026-03-05 15:18:14.359241+00	69
2331	32	48	2026-03-05 15:18:14.359732+00	69
2332	33	48	2026-03-05 15:18:14.360211+00	69
2333	34	48	2026-03-05 15:18:14.360666+00	69
2334	35	48	2026-03-05 15:18:14.361118+00	69
2335	36	48	2026-03-05 15:18:14.361634+00	69
2336	37	48	2026-03-05 15:18:14.362104+00	69
2337	38	48	2026-03-05 15:18:14.362577+00	69
302069	5	6	2026-03-11 15:05:28.578162+00	222
302070	6	6	2026-03-11 15:05:28.580067+00	222
302333	1	3	2026-03-12 13:28:49.197314+00	228
302334	2	3	2026-03-12 13:28:49.204239+00	228
302335	3	3	2026-03-12 13:28:49.210219+00	228
2338	39	48	2026-03-05 15:18:14.363183+00	69
2339	40	48	2026-03-05 15:18:14.36368+00	69
2340	41	48	2026-03-05 15:18:14.364158+00	69
2341	42	48	2026-03-05 15:18:14.364652+00	69
2342	43	48	2026-03-05 15:18:14.365103+00	69
2343	44	48	2026-03-05 15:18:14.365579+00	69
2344	45	48	2026-03-05 15:18:14.366058+00	69
2345	46	48	2026-03-05 15:18:14.366517+00	69
2346	47	48	2026-03-05 15:18:14.36697+00	69
2347	48	48	2026-03-05 15:18:14.367454+00	69
2348	1	11	2026-03-05 15:18:14.590894+00	70
2349	2	11	2026-03-05 15:18:14.591408+00	70
2350	3	11	2026-03-05 15:18:14.591879+00	70
2351	4	11	2026-03-05 15:18:14.592385+00	70
2352	5	11	2026-03-05 15:18:14.592902+00	70
2353	6	11	2026-03-05 15:18:14.593441+00	70
2354	7	11	2026-03-05 15:18:14.593952+00	70
2355	8	11	2026-03-05 15:18:14.594443+00	70
2356	9	11	2026-03-05 15:18:14.594906+00	70
2357	10	11	2026-03-05 15:18:14.595383+00	70
2358	11	11	2026-03-05 15:18:14.595846+00	70
2359	1	2	2026-03-05 15:18:14.772454+00	71
2360	2	2	2026-03-05 15:18:14.772989+00	71
2361	1	2	2026-03-05 15:18:14.948012+00	72
2362	2	2	2026-03-05 15:18:14.948558+00	72
2363	1	3	2026-03-05 15:18:15.167438+00	73
2364	2	3	2026-03-05 15:18:15.167926+00	73
2365	3	3	2026-03-05 15:18:15.168479+00	73
2366	1	2	2026-03-05 15:18:15.343177+00	74
2367	2	2	2026-03-05 15:18:15.343672+00	74
2368	1	2	2026-03-05 15:18:15.517925+00	75
2369	2	2	2026-03-05 15:18:15.518453+00	75
2370	1	2	2026-03-05 15:18:15.707541+00	76
2371	2	2	2026-03-05 15:18:15.708036+00	76
2372	1	2	2026-03-05 15:18:15.901109+00	77
2373	2	2	2026-03-05 15:18:15.901687+00	77
2374	1	2	2026-03-05 15:18:16.106284+00	78
2375	2	2	2026-03-05 15:18:16.106885+00	78
2376	1	2	2026-03-05 15:18:16.309316+00	79
2377	2	2	2026-03-05 15:18:16.309808+00	79
2378	1	1	2026-03-05 15:18:16.49093+00	80
2379	1	2	2026-03-05 15:18:16.686891+00	81
2380	2	2	2026-03-05 15:18:16.687399+00	81
2381	1	3	2026-03-05 15:18:16.884663+00	82
2382	2	3	2026-03-05 15:18:16.885172+00	82
2383	3	3	2026-03-05 15:18:16.885736+00	82
2384	1	3	2026-03-05 15:18:17.136738+00	83
2385	2	3	2026-03-05 15:18:17.137414+00	83
2386	3	3	2026-03-05 15:18:17.138059+00	83
2387	1	5	2026-03-05 15:18:17.350274+00	84
2388	2	5	2026-03-05 15:18:17.350818+00	84
2389	3	5	2026-03-05 15:18:17.351346+00	84
2390	4	5	2026-03-05 15:18:17.35184+00	84
2391	5	5	2026-03-05 15:18:17.352345+00	84
2392	1	5	2026-03-05 15:18:17.540001+00	85
2393	2	5	2026-03-05 15:18:17.540606+00	85
2394	3	5	2026-03-05 15:18:17.541094+00	85
2395	4	5	2026-03-05 15:18:17.541675+00	85
2396	5	5	2026-03-05 15:18:17.542167+00	85
2397	1	1	2026-03-05 15:18:17.724189+00	87
301319	1	3	2026-03-05 20:13:21.953133+00	93
301320	2	3	2026-03-05 20:13:21.955081+00	93
301321	3	3	2026-03-05 20:13:21.956193+00	93
301582	1	1	2026-03-06 20:34:14.232576+00	133
301706	1	6	2026-03-09 14:36:28.156702+00	147
301707	2	6	2026-03-09 14:36:28.162528+00	147
301708	3	6	2026-03-09 14:36:28.166879+00	147
301709	4	6	2026-03-09 14:36:28.17125+00	147
301710	5	6	2026-03-09 14:36:28.175597+00	147
301711	6	6	2026-03-09 14:36:28.180042+00	147
301978	1	1	2026-03-10 19:32:56.070883+00	191
302071	1	1	2026-03-11 15:09:42.279947+00	216
302336	1	3	2026-03-12 13:32:17.192873+00	245
302337	2	3	2026-03-12 13:32:17.197439+00	245
302338	3	3	2026-03-12 13:32:17.200874+00	245
302501	2	3	2026-03-12 19:30:36.604686+00	283
302502	3	3	2026-03-12 19:30:36.608197+00	283
2451	1	3	2026-03-05 17:34:51.35595+00	42
2452	2	3	2026-03-05 17:34:51.361227+00	42
2453	3	3	2026-03-05 17:34:51.365929+00	42
2468	1	3	2026-03-05 18:13:04.820059+00	62
2469	2	3	2026-03-05 18:13:04.824558+00	62
2470	3	3	2026-03-05 18:13:04.828039+00	62
2483	1	1	2026-03-05 18:39:27.247666+00	35
301712	1	10	2026-03-09 14:51:55.801519+00	146
301713	2	10	2026-03-09 14:51:55.807303+00	146
301714	3	10	2026-03-09 14:51:55.812105+00	146
301715	4	10	2026-03-09 14:51:55.816989+00	146
301716	5	10	2026-03-09 14:51:55.821866+00	146
301717	6	10	2026-03-09 14:51:55.826719+00	146
301718	7	10	2026-03-09 14:51:55.831539+00	146
301719	8	10	2026-03-09 14:51:55.83635+00	146
301720	9	10	2026-03-09 14:51:55.841126+00	146
301721	10	10	2026-03-09 14:51:55.845963+00	146
301979	1	2	2026-03-10 19:44:39.843463+00	189
301980	2	2	2026-03-10 19:44:39.854503+00	189
302072	1	1	2026-03-11 15:09:53.073193+00	217
302339	1	2	2026-03-12 13:35:35.755757+00	247
302340	2	2	2026-03-12 13:35:35.759118+00	247
302503	1	4	2026-03-12 19:36:11.599004+00	277
302504	2	4	2026-03-12 19:36:11.601731+00	277
302505	3	4	2026-03-12 19:36:11.60329+00	277
302506	4	4	2026-03-12 19:36:11.604758+00	277
301325	1	3	2026-03-05 20:20:31.089201+00	95
301326	2	3	2026-03-05 20:20:31.091122+00	95
301327	3	3	2026-03-05 20:20:31.09228+00	95
301584	1	1	2026-03-06 20:39:18.68096+00	134
301722	1	1	2026-03-09 14:58:05.770247+00	183
301981	1	1	2026-03-10 19:50:04.597422+00	193
302341	1	2	2026-03-12 13:39:14.491505+00	231
302342	2	2	2026-03-12 13:39:14.497054+00	231
302507	1	1	2026-03-12 19:37:44.714341+00	262
301328	1	6	2026-03-05 20:30:45.603297+00	94
301329	2	6	2026-03-05 20:30:45.611455+00	94
301330	3	6	2026-03-05 20:30:45.61859+00	94
301331	4	6	2026-03-05 20:30:45.625567+00	94
301332	5	6	2026-03-05 20:30:45.632644+00	94
301333	6	6	2026-03-05 20:30:45.63971+00	94
301723	1	1	2026-03-09 15:03:16.683073+00	154
301982	1	2	2026-03-10 19:54:59.189323+00	196
301983	2	2	2026-03-10 19:54:59.195832+00	196
302074	1	1	2026-03-11 15:10:24.778731+00	218
302343	1	3	2026-03-12 13:42:39.043443+00	232
302344	2	3	2026-03-12 13:42:39.048475+00	232
302345	3	3	2026-03-12 13:42:39.05237+00	232
302508	1	3	2026-03-12 19:47:45.360096+00	282
302509	2	3	2026-03-12 19:47:45.364792+00	282
302510	3	3	2026-03-12 19:47:45.368247+00	282
301586	1	1	2026-03-06 20:41:14.141716+00	135
301724	1	1	2026-03-09 15:11:38.33119+00	182
301984	1	2	2026-03-10 20:00:49.784432+00	190
301985	2	2	2026-03-10 20:00:49.790922+00	190
302346	1	1	2026-03-12 13:50:02.45206+00	248
302511	1	2	2026-03-12 19:51:50.776811+00	263
302512	2	2	2026-03-12 19:51:50.781317+00	263
301725	1	1	2026-03-09 15:12:27.276116+00	184
301986	1	1	2026-03-10 20:18:32.767704+00	194
302076	1	1	2026-03-11 15:12:12.594352+00	219
302347	1	1	2026-03-12 13:52:10.618753+00	233
302513	1	9	2026-03-12 20:13:05.022412+00	279
302514	2	9	2026-03-12 20:13:05.036115+00	279
302515	3	9	2026-03-12 20:13:05.048918+00	279
302516	4	9	2026-03-12 20:13:05.061504+00	279
302517	5	9	2026-03-12 20:13:05.07437+00	279
302518	6	9	2026-03-12 20:13:05.087029+00	279
302519	7	9	2026-03-12 20:13:05.100474+00	279
302520	8	9	2026-03-12 20:13:05.113325+00	279
302521	9	9	2026-03-12 20:13:05.126016+00	279
301588	1	1	2026-03-06 20:45:29.175499+00	136
301726	1	1	2026-03-09 16:33:12.520913+00	142
301987	1	2	2026-03-10 20:29:35.442327+00	195
301988	2	2	2026-03-10 20:29:35.452852+00	195
302348	1	1	2026-03-12 13:52:37.068604+00	234
302522	1	5	2026-03-12 20:31:15.981254+00	276
302523	2	5	2026-03-12 20:31:15.989017+00	276
302524	3	5	2026-03-12 20:31:15.9956+00	276
302525	4	5	2026-03-12 20:31:16.002181+00	276
302526	5	5	2026-03-12 20:31:16.008721+00	276
301338	1	1	2026-03-05 20:42:53.317743+00	96
301727	1	1	2026-03-09 16:36:43.143398+00	180
301989	1	5	2026-03-10 21:01:51.730996+00	199
301990	2	5	2026-03-10 21:01:51.751021+00	199
301991	3	5	2026-03-10 21:01:51.769517+00	199
301992	4	5	2026-03-10 21:01:51.788006+00	199
301993	5	5	2026-03-10 21:01:51.806648+00	199
302078	1	1	2026-03-11 15:14:52.549+00	224
302349	1	1	2026-03-12 13:56:51.016844+00	252
301590	1	1	2026-03-06 20:47:50.819041+00	137
301728	1	1	2026-03-09 16:40:52.497085+00	153
302079	1	1	2026-03-11 15:15:04.049891+00	221
302350	1	3	2026-03-12 14:03:18.73566+00	235
302351	2	3	2026-03-12 14:03:18.738048+00	235
302352	3	3	2026-03-12 14:03:18.739704+00	235
301340	1	1	2026-03-05 20:45:18.113228+00	97
301729	1	1	2026-03-09 16:46:42.711072+00	174
302008	1	1	2026-03-11 13:44:51.868198+00	205
302080	1	1	2026-03-11 15:15:20.14784+00	220
302353	1	3	2026-03-12 14:06:20.250248+00	259
302354	2	3	2026-03-12 14:06:20.254975+00	259
302355	3	3	2026-03-12 14:06:20.258954+00	259
302529	1	2	2026-03-12 20:34:37.074759+00	273
302530	2	2	2026-03-12 20:34:37.076688+00	273
301592	1	1	2026-03-06 21:01:32.121031+00	138
301730	1	1	2026-03-09 16:46:55.366652+00	175
302009	1	2	2026-03-11 13:56:41.340718+00	204
302010	2	2	2026-03-11 13:56:41.343699+00	204
302081	1	4	2026-03-11 15:28:04.043636+00	213
302082	2	4	2026-03-11 15:28:04.049583+00	213
302083	3	4	2026-03-11 15:28:04.054659+00	213
302084	4	4	2026-03-11 15:28:04.059445+00	213
302356	1	1	2026-03-12 14:07:47.641107+00	239
302531	1	2	2026-03-12 20:43:10.389978+00	274
302532	2	2	2026-03-12 20:43:10.393788+00	274
301342	1	1	2026-03-05 20:48:49.483409+00	98
301731	1	1	2026-03-09 16:47:13.106212+00	176
302085	1	3	2026-03-11 15:33:52.513044+00	206
302086	2	3	2026-03-11 15:33:52.517516+00	206
302087	3	3	2026-03-11 15:33:52.521068+00	206
302357	1	1	2026-03-12 14:09:00.799389+00	236
302533	1	4	2026-03-12 20:58:01.629304+00	271
302534	2	4	2026-03-12 20:58:01.631354+00	271
302535	3	4	2026-03-12 20:58:01.632564+00	271
302536	4	4	2026-03-12 20:58:01.633546+00	271
301594	1	1	2026-03-06 21:05:52.929605+00	139
301732	1	1	2026-03-09 16:47:32.95028+00	178
302043	1	5	2026-03-11 14:34:05.713975+00	207
302044	2	5	2026-03-11 14:34:05.716965+00	207
302045	3	5	2026-03-11 14:34:05.7192+00	207
302046	4	5	2026-03-11 14:34:05.721279+00	207
302047	5	5	2026-03-11 14:34:05.723353+00	207
302088	1	2	2026-03-11 15:35:57.908025+00	215
302089	2	2	2026-03-11 15:35:57.910623+00	215
302358	1	1	2026-03-12 14:14:29.625684+00	257
302537	1	3	2026-03-12 21:23:34.397741+00	272
302538	2	3	2026-03-12 21:23:34.407076+00	272
302539	3	3	2026-03-12 21:23:34.415265+00	272
301345	1	1	2026-03-05 20:57:09.125764+00	99
301733	1	1	2026-03-09 16:47:59.126409+00	179
302090	1	4	2026-03-11 15:39:35.73403+00	208
302091	2	4	2026-03-11 15:39:35.736832+00	208
302092	3	4	2026-03-11 15:39:35.738922+00	208
302093	4	4	2026-03-11 15:39:35.740861+00	208
302359	1	3	2026-03-12 14:34:57.571064+00	256
302360	2	3	2026-03-12 14:34:57.585599+00	256
302361	3	3	2026-03-12 14:34:57.599286+00	256
302540	1	1	2026-03-12 21:25:37.87466+00	264
301596	1	1	2026-03-06 21:12:07.199326+00	140
301734	1	1	2026-03-09 16:48:17.247466+00	177
302094	1	3	2026-03-11 15:48:36.378354+00	211
302095	2	3	2026-03-11 15:48:36.38503+00	211
302096	3	3	2026-03-11 15:48:36.390798+00	211
302541	1	4	2026-03-12 21:29:38.077941+00	266
302542	2	4	2026-03-12 21:29:38.08038+00	266
302543	3	4	2026-03-12 21:29:38.082157+00	266
302544	4	4	2026-03-12 21:29:38.083627+00	266
301347	1	1	2026-03-05 21:01:47.392206+00	100
301735	1	1	2026-03-09 16:54:05.931298+00	173
302364	1	2	2026-03-12 15:14:05.158888+00	261
302365	2	2	2026-03-12 15:14:05.168695+00	261
302545	1	3	2026-03-12 21:32:03.043236+00	267
302546	2	3	2026-03-12 21:32:03.045023+00	267
302547	3	3	2026-03-12 21:32:03.046297+00	267
301598	1	1	2026-03-06 21:19:13.321015+00	141
301736	1	1	2026-03-09 16:57:12.966023+00	171
302366	1	1	2026-03-12 15:19:18.394291+00	238
302548	1	3	2026-03-12 21:44:04.457602+00	270
302549	2	3	2026-03-12 21:44:04.464074+00	270
302550	3	3	2026-03-12 21:44:04.469574+00	270
301350	1	2	2026-03-05 21:12:11.985925+00	101
301351	2	2	2026-03-05 21:12:11.992561+00	101
301737	1	1	2026-03-09 17:00:53.531399+00	169
302367	1	4	2026-03-12 15:39:18.11458+00	230
302368	2	4	2026-03-12 15:39:18.129815+00	230
302369	3	4	2026-03-12 15:39:18.143632+00	230
302370	4	4	2026-03-12 15:39:18.15735+00	230
301738	1	5	2026-03-09 19:27:02.596278+00	170
301739	2	5	2026-03-09 19:27:02.600938+00	170
301740	3	5	2026-03-09 19:27:02.604868+00	170
301741	4	5	2026-03-09 19:27:02.608291+00	170
301742	5	5	2026-03-09 19:27:02.612012+00	170
302371	1	4	2026-03-12 16:17:48.286459+00	225
302372	2	4	2026-03-12 16:17:48.291622+00	225
302373	3	4	2026-03-12 16:17:48.295846+00	225
302374	4	4	2026-03-12 16:17:48.300913+00	225
302652	1	5	2026-03-13 13:51:33.321755+00	268
302653	2	5	2026-03-13 13:51:33.332382+00	268
302654	3	5	2026-03-13 13:51:33.34217+00	268
302655	4	5	2026-03-13 13:51:33.351755+00	268
302656	5	5	2026-03-13 13:51:33.361163+00	268
301454	1	1	2026-03-06 14:29:23.805274+00	103
301743	1	2	2026-03-09 19:29:00.576522+00	168
301744	2	2	2026-03-09 19:29:00.580349+00	168
302375	1	2	2026-03-12 16:31:44.526291+00	249
302376	2	2	2026-03-12 16:31:44.53245+00	249
302657	1	4	2026-03-13 14:02:12.897467+00	269
302658	2	4	2026-03-13 14:02:12.908782+00	269
302659	3	4	2026-03-13 14:02:12.919406+00	269
302660	4	4	2026-03-13 14:02:12.93052+00	269
301455	1	1	2026-03-06 14:36:16.322594+00	104
301689	1	1	2026-03-09 13:32:43.384211+00	143
301745	1	6	2026-03-09 19:41:13.112131+00	167
301746	2	6	2026-03-09 19:41:13.121395+00	167
301747	3	6	2026-03-09 19:41:13.129861+00	167
301748	4	6	2026-03-09 19:41:13.138018+00	167
301749	5	6	2026-03-09 19:41:13.146093+00	167
301750	6	6	2026-03-09 19:41:13.15433+00	167
302377	1	1	2026-03-12 16:59:51.660544+00	244
302661	1	24	2026-03-13 14:53:17.828664+00	265
302662	2	24	2026-03-13 14:53:17.840406+00	265
302663	3	24	2026-03-13 14:53:17.849072+00	265
302664	4	24	2026-03-13 14:53:17.857544+00	265
302665	5	24	2026-03-13 14:53:17.866201+00	265
302666	6	24	2026-03-13 14:53:17.874545+00	265
302667	7	24	2026-03-13 14:53:17.883084+00	265
302668	8	24	2026-03-13 14:53:17.891553+00	265
302669	9	24	2026-03-13 14:53:17.900039+00	265
302670	10	24	2026-03-13 14:53:17.909272+00	265
302671	11	24	2026-03-13 14:53:17.91767+00	265
302672	12	24	2026-03-13 14:53:17.926271+00	265
302673	13	24	2026-03-13 14:53:17.934721+00	265
302674	14	24	2026-03-13 14:53:17.943305+00	265
302675	15	24	2026-03-13 14:53:17.951808+00	265
302676	16	24	2026-03-13 14:53:17.960274+00	265
302677	17	24	2026-03-13 14:53:17.968474+00	265
302678	18	24	2026-03-13 14:53:17.976603+00	265
302679	19	24	2026-03-13 14:53:17.984833+00	265
302680	20	24	2026-03-13 14:53:17.993061+00	265
302681	21	24	2026-03-13 14:53:18.001336+00	265
302682	22	24	2026-03-13 14:53:18.009664+00	265
302683	23	24	2026-03-13 14:53:18.017972+00	265
302684	24	24	2026-03-13 14:53:18.026262+00	265
301456	1	1	2026-03-06 14:40:30.714444+00	102
301751	1	1	2026-03-09 19:46:02.40082+00	172
302378	1	6	2026-03-12 17:09:34.026933+00	255
302379	2	6	2026-03-12 17:09:34.031326+00	255
302380	3	6	2026-03-12 17:09:34.034722+00	255
302381	4	6	2026-03-12 17:09:34.038074+00	255
302382	5	6	2026-03-12 17:09:34.041321+00	255
302383	6	6	2026-03-12 17:09:34.04461+00	255
301457	1	1	2026-03-06 14:47:14.004808+00	106
301752	1	6	2026-03-09 19:59:20.319048+00	181
301753	2	6	2026-03-09 19:59:20.33059+00	181
301754	3	6	2026-03-09 19:59:20.340947+00	181
301755	4	6	2026-03-09 19:59:20.351359+00	181
301756	5	6	2026-03-09 19:59:20.3618+00	181
301757	6	6	2026-03-09 19:59:20.372224+00	181
302384	1	7	2026-03-12 17:13:51.6841+00	254
302385	2	7	2026-03-12 17:13:51.686774+00	254
302386	3	7	2026-03-12 17:13:51.688396+00	254
302387	4	7	2026-03-12 17:13:51.689963+00	254
302388	5	7	2026-03-12 17:13:51.691424+00	254
302389	6	7	2026-03-12 17:13:51.692852+00	254
302390	7	7	2026-03-12 17:13:51.694345+00	254
301458	1	1	2026-03-06 14:50:44.056061+00	107
301758	1	4	2026-03-09 20:02:35.077328+00	166
301759	2	4	2026-03-09 20:02:35.080314+00	166
301760	3	4	2026-03-09 20:02:35.082398+00	166
301761	4	4	2026-03-09 20:02:35.084327+00	166
302391	1	1	2026-03-12 17:26:18.654231+00	237
301459	1	3	2026-03-06 15:02:52.032012+00	105
301460	2	3	2026-03-06 15:02:52.039226+00	105
301461	3	3	2026-03-06 15:02:52.045277+00	105
301762	1	1	2026-03-09 20:04:41.59593+00	158
302392	1	1	2026-03-12 17:30:16.398191+00	250
301462	1	1	2026-03-06 15:07:07.570955+00	108
302393	1	2	2026-03-12 17:35:06.108288+00	246
302394	2	2	2026-03-12 17:35:06.112591+00	246
301764	1	2	2026-03-09 20:07:26.645331+00	164
301765	2	2	2026-03-09 20:07:26.64775+00	164
302395	1	10	2026-03-12 18:52:10.444417+00	253
302396	2	10	2026-03-12 18:52:10.469929+00	253
302397	3	10	2026-03-12 18:52:10.492204+00	253
302398	4	10	2026-03-12 18:52:10.514634+00	253
302399	5	10	2026-03-12 18:52:10.536892+00	253
302400	6	10	2026-03-12 18:52:10.559357+00	253
302401	7	10	2026-03-12 18:52:10.581331+00	253
302402	8	10	2026-03-12 18:52:10.602748+00	253
302403	9	10	2026-03-12 18:52:10.624061+00	253
302404	10	10	2026-03-12 18:52:10.645415+00	253
301476	1	1	2026-03-06 15:27:58.67454+00	128
301766	1	2	2026-03-09 20:12:38.583364+00	163
301767	2	2	2026-03-09 20:12:38.590355+00	163
302468	1	1	2026-03-12 19:05:08.040245+00	275
301768	1	2	2026-03-09 20:16:17.528035+00	162
301769	2	2	2026-03-09 20:16:17.532775+00	162
302491	1	1	2026-03-12 19:05:22.280089+00	281
301490	1	1	2026-03-06 15:31:45.837199+00	129
301770	1	1	2026-03-09 20:19:12.717009+00	159
301491	1	1	2026-03-06 15:55:14.299222+00	109
301771	1	2	2026-03-09 20:23:43.058875+00	161
301772	2	2	2026-03-09 20:23:43.063253+00	161
301492	1	1	2026-03-06 16:38:26.678347+00	110
301773	1	1	2026-03-09 20:26:11.318916+00	160
301493	1	1	2026-03-06 16:47:42.821306+00	112
301774	1	2	2026-03-09 20:34:49.056088+00	165
301775	2	2	2026-03-09 20:34:49.066693+00	165
301494	1	2	2026-03-06 16:52:50.118126+00	113
301495	2	2	2026-03-06 16:52:50.121342+00	113
301776	1	4	2026-03-09 20:42:02.530443+00	156
301777	2	4	2026-03-09 20:42:02.552111+00	156
301778	3	4	2026-03-09 20:42:02.571466+00	156
301779	4	4	2026-03-09 20:42:02.58406+00	156
301496	1	4	2026-03-06 16:59:26.442528+00	119
301497	2	4	2026-03-06 16:59:26.445278+00	119
301498	3	4	2026-03-06 16:59:26.447279+00	119
301499	4	4	2026-03-06 16:59:26.449199+00	119
301780	1	2	2026-03-09 20:50:11.657603+00	157
301781	2	2	2026-03-09 20:50:11.666351+00	157
301500	1	1	2026-03-06 17:04:19.393219+00	116
301505	1	3	2026-03-06 17:15:46.811249+00	130
301506	2	3	2026-03-06 17:15:46.817219+00	130
301507	3	3	2026-03-06 17:15:46.822123+00	130
301508	1	3	2026-03-06 17:20:43.714892+00	114
301509	2	3	2026-03-06 17:20:43.718785+00	114
301510	3	3	2026-03-06 17:20:43.721752+00	114
301511	1	6	2026-03-06 17:23:20.670791+00	111
301512	2	6	2026-03-06 17:23:20.672615+00	111
301513	3	6	2026-03-06 17:23:20.673834+00	111
301514	4	6	2026-03-06 17:23:20.674881+00	111
301515	5	6	2026-03-06 17:23:20.675875+00	111
301516	6	6	2026-03-06 17:23:20.676857+00	111
302807	1	1	2026-03-16 19:32:36.098649+00	286
302808	1	4	2026-03-16 19:32:36.32033+00	287
302809	2	4	2026-03-16 19:32:36.320877+00	287
302810	3	4	2026-03-16 19:32:36.321376+00	287
302811	4	4	2026-03-16 19:32:36.321894+00	287
302812	1	3	2026-03-16 19:32:36.507807+00	288
302813	2	3	2026-03-16 19:32:36.508307+00	288
302814	3	3	2026-03-16 19:32:36.508806+00	288
302815	1	1	2026-03-16 19:32:36.686184+00	289
302816	1	1	2026-03-16 19:32:36.870426+00	290
302817	1	3	2026-03-16 19:32:37.063702+00	291
302818	2	3	2026-03-16 19:32:37.064245+00	291
302819	3	3	2026-03-16 19:32:37.064742+00	291
302820	1	1	2026-03-16 19:32:37.238604+00	292
302821	1	4	2026-03-16 19:32:37.420991+00	293
302822	2	4	2026-03-16 19:32:37.421494+00	293
302823	3	4	2026-03-16 19:32:37.421986+00	293
302824	4	4	2026-03-16 19:32:37.422462+00	293
302825	1	3	2026-03-16 19:32:37.652637+00	294
302826	2	3	2026-03-16 19:32:37.653162+00	294
302827	3	3	2026-03-16 19:32:37.653657+00	294
302828	1	1	2026-03-16 19:32:37.832043+00	295
302829	1	4	2026-03-16 19:32:38.028615+00	296
302830	2	4	2026-03-16 19:32:38.029149+00	296
302831	3	4	2026-03-16 19:32:38.029632+00	296
302832	4	4	2026-03-16 19:32:38.030117+00	296
302833	1	3	2026-03-16 19:32:38.20709+00	297
302834	2	3	2026-03-16 19:32:38.207613+00	297
302835	3	3	2026-03-16 19:32:38.208128+00	297
302836	1	2	2026-03-16 19:32:38.390015+00	298
302837	2	2	2026-03-16 19:32:38.390519+00	298
302838	1	1	2026-03-16 19:32:38.59038+00	299
302839	1	1	2026-03-16 19:32:38.769899+00	300
302840	1	1	2026-03-16 19:32:38.9655+00	301
302841	1	1	2026-03-16 19:32:39.138741+00	302
302842	1	1	2026-03-16 19:32:39.312294+00	303
302843	1	1	2026-03-16 19:32:39.483505+00	304
302844	1	1	2026-03-16 19:32:39.655834+00	305
302845	1	1	2026-03-16 19:32:39.831841+00	306
302846	1	1	2026-03-16 19:32:40.018716+00	307
302847	1	1	2026-03-16 19:32:40.245496+00	308
302848	1	1	2026-03-16 19:32:40.419934+00	309
302849	1	1	2026-03-16 19:32:40.592312+00	310
302850	1	18	2026-03-16 19:32:40.885899+00	311
302851	2	18	2026-03-16 19:32:40.886411+00	311
302852	3	18	2026-03-16 19:32:40.886917+00	311
302853	4	18	2026-03-16 19:32:40.887391+00	311
302854	5	18	2026-03-16 19:32:40.887884+00	311
302855	6	18	2026-03-16 19:32:40.888374+00	311
302856	7	18	2026-03-16 19:32:40.888857+00	311
302857	8	18	2026-03-16 19:32:40.889317+00	311
302858	9	18	2026-03-16 19:32:40.889796+00	311
302859	10	18	2026-03-16 19:32:40.890256+00	311
302860	11	18	2026-03-16 19:32:40.890714+00	311
302861	12	18	2026-03-16 19:32:40.891193+00	311
302862	13	18	2026-03-16 19:32:40.891657+00	311
302863	14	18	2026-03-16 19:32:40.892147+00	311
302864	15	18	2026-03-16 19:32:40.892607+00	311
302865	16	18	2026-03-16 19:32:40.893078+00	311
302866	17	18	2026-03-16 19:32:40.893545+00	311
302867	18	18	2026-03-16 19:32:40.894014+00	311
302868	1	4	2026-03-16 19:32:41.10029+00	312
302869	2	4	2026-03-16 19:32:41.100825+00	312
302870	3	4	2026-03-16 19:32:41.101315+00	312
302871	4	4	2026-03-16 19:32:41.101808+00	312
302872	1	1	2026-03-16 19:32:41.29445+00	313
302873	1	1	2026-03-16 19:32:41.465626+00	314
302874	1	2	2026-03-16 19:32:41.657059+00	315
302875	2	2	2026-03-16 19:32:41.657554+00	315
302876	1	1	2026-03-16 19:32:41.850584+00	316
302877	1	1	2026-03-16 19:32:42.03347+00	317
302878	1	3	2026-03-16 19:32:42.210086+00	318
302879	2	3	2026-03-16 19:32:42.210665+00	318
302880	3	3	2026-03-16 19:32:42.211161+00	318
302881	1	6	2026-03-16 19:32:42.394747+00	319
302882	2	6	2026-03-16 19:32:42.395272+00	319
302883	3	6	2026-03-16 19:32:42.395747+00	319
302884	4	6	2026-03-16 19:32:42.396246+00	319
302885	5	6	2026-03-16 19:32:42.396708+00	319
302886	6	6	2026-03-16 19:32:42.39719+00	319
302887	1	1	2026-03-16 19:32:42.575497+00	320
302888	1	2	2026-03-16 19:32:42.768496+00	321
302889	2	2	2026-03-16 19:32:42.768987+00	321
302890	1	1	2026-03-16 19:32:42.972376+00	322
302891	1	1	2026-03-16 19:32:43.145597+00	323
302892	1	1	2026-03-16 19:32:43.317312+00	324
302893	1	1	2026-03-16 19:32:43.48854+00	325
302894	1	1	2026-03-16 19:32:43.666713+00	326
302895	1	1	2026-03-16 19:32:43.854942+00	327
302896	1	1	2026-03-16 19:32:44.036603+00	328
302897	1	1	2026-03-16 19:32:44.21263+00	329
302898	1	1	2026-03-16 19:32:44.447651+00	330
302899	1	1	2026-03-16 19:32:44.623388+00	331
302900	1	1	2026-03-16 19:32:44.810189+00	332
302901	1	1	2026-03-16 19:32:44.996026+00	333
302902	1	1	2026-03-16 19:32:45.170946+00	334
302903	1	3	2026-03-16 19:32:45.347747+00	335
302904	2	3	2026-03-16 19:32:45.348289+00	335
302905	3	3	2026-03-16 19:32:45.348803+00	335
302906	1	1	2026-03-16 19:32:45.523005+00	336
302907	1	1	2026-03-16 19:32:45.697547+00	337
302908	1	39	2026-03-16 19:32:45.993418+00	338
302909	2	39	2026-03-16 19:32:45.995931+00	338
302910	3	39	2026-03-16 19:32:45.996452+00	338
302911	4	39	2026-03-16 19:32:45.996945+00	338
302912	5	39	2026-03-16 19:32:45.997404+00	338
302913	6	39	2026-03-16 19:32:45.997881+00	338
302914	7	39	2026-03-16 19:32:45.998332+00	338
302915	8	39	2026-03-16 19:32:45.998805+00	338
302916	9	39	2026-03-16 19:32:45.999255+00	338
302917	10	39	2026-03-16 19:32:45.999711+00	338
302918	11	39	2026-03-16 19:32:46.000193+00	338
302919	12	39	2026-03-16 19:32:46.000644+00	338
302920	13	39	2026-03-16 19:32:46.001113+00	338
302921	14	39	2026-03-16 19:32:46.001562+00	338
302922	15	39	2026-03-16 19:32:46.002031+00	338
302923	16	39	2026-03-16 19:32:46.002481+00	338
302924	17	39	2026-03-16 19:32:46.002948+00	338
302925	18	39	2026-03-16 19:32:46.003398+00	338
302926	19	39	2026-03-16 19:32:46.00387+00	338
302927	20	39	2026-03-16 19:32:46.004344+00	338
302928	21	39	2026-03-16 19:32:46.004851+00	338
302929	22	39	2026-03-16 19:32:46.005311+00	338
302930	23	39	2026-03-16 19:32:46.005798+00	338
302931	24	39	2026-03-16 19:32:46.006263+00	338
302932	25	39	2026-03-16 19:32:46.006723+00	338
302933	26	39	2026-03-16 19:32:46.007191+00	338
302934	27	39	2026-03-16 19:32:46.007639+00	338
302935	28	39	2026-03-16 19:32:46.008134+00	338
302936	29	39	2026-03-16 19:32:46.008593+00	338
302937	30	39	2026-03-16 19:32:46.009074+00	338
302938	31	39	2026-03-16 19:32:46.00954+00	338
302939	32	39	2026-03-16 19:32:46.010014+00	338
302940	33	39	2026-03-16 19:32:46.010472+00	338
302941	34	39	2026-03-16 19:32:46.010954+00	338
301531	1	15	2026-03-06 17:56:35.929878+00	115
301532	2	15	2026-03-06 17:56:35.942924+00	115
301533	3	15	2026-03-06 17:56:35.95491+00	115
301534	4	15	2026-03-06 17:56:35.96709+00	115
301535	5	15	2026-03-06 17:56:35.978953+00	115
301536	6	15	2026-03-06 17:56:35.990696+00	115
301537	7	15	2026-03-06 17:56:36.00242+00	115
301538	8	15	2026-03-06 17:56:36.014373+00	115
301539	9	15	2026-03-06 17:56:36.026215+00	115
301540	10	15	2026-03-06 17:56:36.038699+00	115
301541	11	15	2026-03-06 17:56:36.050326+00	115
301542	12	15	2026-03-06 17:56:36.062417+00	115
301543	13	15	2026-03-06 17:56:36.073791+00	115
301544	14	15	2026-03-06 17:56:36.085067+00	115
301545	15	15	2026-03-06 17:56:36.096283+00	115
302942	35	39	2026-03-16 19:32:46.011413+00	338
302943	36	39	2026-03-16 19:32:46.011945+00	338
302944	37	39	2026-03-16 19:32:46.01242+00	338
302945	38	39	2026-03-16 19:32:46.012912+00	338
302946	39	39	2026-03-16 19:32:46.013375+00	338
302947	1	1	2026-03-16 19:32:46.183872+00	339
302948	1	2	2026-03-16 19:32:46.362879+00	340
302949	2	2	2026-03-16 19:32:46.36337+00	340
302950	1	1	2026-03-16 19:32:46.537175+00	341
302951	1	4	2026-03-16 19:32:46.714605+00	342
302952	2	4	2026-03-16 19:32:46.715107+00	342
302953	3	4	2026-03-16 19:32:46.715572+00	342
302954	4	4	2026-03-16 19:32:46.716053+00	342
302955	1	5	2026-03-16 19:32:46.908705+00	343
302956	2	5	2026-03-16 19:32:46.909327+00	343
302957	3	5	2026-03-16 19:32:46.909922+00	343
302958	4	5	2026-03-16 19:32:46.910469+00	343
302959	5	5	2026-03-16 19:32:46.911038+00	343
302960	1	3	2026-03-16 19:32:47.095214+00	344
302961	2	3	2026-03-16 19:32:47.095726+00	344
302962	3	3	2026-03-16 19:32:47.096233+00	344
302963	1	4	2026-03-16 19:32:47.281272+00	345
302964	2	4	2026-03-16 19:32:47.281789+00	345
302965	3	4	2026-03-16 19:32:47.282262+00	345
302966	4	4	2026-03-16 19:32:47.282749+00	345
302967	1	3	2026-03-16 19:32:47.455757+00	346
302968	2	3	2026-03-16 19:32:47.456301+00	346
302969	3	3	2026-03-16 19:32:47.456789+00	346
302970	1	2	2026-03-16 19:32:47.642142+00	347
302971	2	2	2026-03-16 19:32:47.642629+00	347
302972	1	1	2026-03-16 19:32:47.821292+00	348
302973	1	1	2026-03-16 19:32:48.011136+00	349
302974	1	3	2026-03-16 19:32:48.189917+00	350
302975	2	3	2026-03-16 19:32:48.190464+00	350
302976	3	3	2026-03-16 19:32:48.190978+00	350
302979	1	1	2026-03-16 19:32:48.590667+00	352
302980	1	1	2026-03-16 19:32:48.765222+00	353
302981	1	1	2026-03-16 19:32:48.965449+00	354
302982	1	1	2026-03-16 19:32:49.132416+00	355
301546	1	1	2026-03-06 18:46:33.29481+00	117
301547	1	2	2026-03-06 18:56:38.850347+00	120
301548	2	2	2026-03-06 18:56:38.857659+00	120
301549	1	2	2026-03-06 19:04:10.826364+00	118
301550	2	2	2026-03-06 19:04:10.833586+00	118
301557	1	5	2026-03-06 19:21:57.062284+00	121
301558	2	5	2026-03-06 19:21:57.071934+00	121
301559	3	5	2026-03-06 19:21:57.080528+00	121
301560	4	5	2026-03-06 19:21:57.089077+00	121
301561	5	5	2026-03-06 19:21:57.097644+00	121
301564	1	3	2026-03-06 19:29:36.703181+00	123
301565	2	3	2026-03-06 19:29:36.707235+00	123
301566	3	3	2026-03-06 19:29:36.710297+00	123
301567	1	1	2026-03-06 19:35:28.018361+00	124
301568	1	2	2026-03-06 20:01:16.955424+00	125
301569	2	2	2026-03-06 20:01:16.964589+00	125
62846	1	3	2026-03-05 18:51:12.023343+00	7
62849	2	3	2026-03-05 18:51:12.025884+00	7
62851	3	3	2026-03-05 18:51:12.027345+00	7
\.


--
-- Data for Name: pedidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedidos (id, picking, numero_pedido, rota, cliente_nome, endereco_logradouro, endereco_numero, endereco_bairro, endereco_cidade, endereco_uf, endereco_cep, criado_em, cpf_cnpj, cliente_codigo) FROM stdin;
2	442062	2368919	CAP RJ -CAPITAL	403334  -  DROG CIC E DAN LTDA  -  INDEPENDENTE	ETR DO MONTEIRO		CAMPO GRANDE	RIO DE JANEIRO	RJ	23045-830	2026-03-04 15:16:09.220171+00	43866747/0001-30	
36	442461	2367572	RIO 1 -RJ INTERIOR 1	5053  -  SALES E TEIXEIRA LTDA - ME  -  DROGAVITA	RUA JOSE DE QUEIROZ		CONSELHEIRO PAULINO	NOVA FRIBURGO	RJ	28633-500	2026-03-04 15:19:01.804224+00	02568960/0001-88	
57	442798	2368129	RIO 2 -RJ INTERIOR 2	3689  -  FARM N SRA DA CONCEICAO PATY  -  INDEPENDENTE	RUA DR. SEBASTIAO LACERDA		CENTRO	PATY DO ALFERES	RJ	26950-000	2026-03-04 16:19:50.811542+00	32404246/0001-15	
77	443271	2367670	GRD RIO -GRANDE RIO	394181  -  PVGF DROGARIA LTDA  -  INDEPENDENTE	ETR DO PILAR		P. CAPIVARI	DUQUE DE CAXIAS	RJ	25231-000	2026-03-04 16:19:50.965894+00	57045594/0002-55	
93	443417	2368595	CAP RJ -CAPITAL	315591  -  MEDICAL SHOPPING MATERIAL MED  -  INDEPENDENTE	AUGUSTO VASCONCELOS		CAMPO GRANDE	RIO DE JANEIRO	RJ	23050-340	2026-03-05 20:08:12.789587+00	11375489/0001-00	
99	443506	2369028	GRD RIO -GRANDE RIO	413119  -  DROG SILVA TRINDADE LTDA  -  INDEPENDENTE	AVN DOUTOR HUMBERTO SOEIRO DE CARVALHO		TRINDADE	SÃO GONÇALO	RJ	24456-250	2026-03-05 20:56:54.23566+00	50390612/0001-06	
130	443719	2369273	LAG 1 -RJ INTERIOR 1	414280  -  L G O FARMA DE MACAE LTDA  -  INDEPENDENTE	AVN PRESIDENTE TANCREDO DE ALMEIDA NEVES		PRQ AEROPORTO	MACAÉ	RJ	27963-514	2026-03-06 17:15:26.053811+00	48833154/0001-90	
136	443883	2369702	CAP RJ -CAPITAL	409863  -  DROG RIO SUL LTDA  -  INDEPENDENTE	AVN LAURO SODRE		BOTAFOGO	RIO DE JANEIRO	RJ	22290-070	2026-03-06 20:44:54.338045+00	48198082/0001-57	
142	443980	2369575	LAG 1 -RJ INTERIOR 1	325198  -  PORTO FARMA FARM E PERF LTDA ME  -  INDEPENDENTE	ETR CLODOMIRO FAUSTINO DA CRUZ		VIRGEM SANTA	MACAÉ	RJ	27946-790	2026-03-09 12:35:55.912534+00	13035041/0001-65	
143	443999	2369591	RIO 2 -RJ INTERIOR 2	385069  -  PORTO FARMA FARM E PERF LTDA ME FIL 1  -  INDEPENDENTE	RUA ROZENDO FONTES TAVARES		BOCAINA	CONCEIÇÃO DE MACABU	RJ	28740-000	2026-03-09 12:35:56.104439+00	13035041/0002-46	
144	444006	2369613	RIO 2 -RJ INTERIOR 2	412767  -  PORTO FARMA FARM E PERF LTDA  -  INDEPENDENTE	PRC DR JOSE BONIFACIO TASSARA		CENTRO	CONCEIÇÃO DE MACABU	RJ	28740-000	2026-03-09 12:35:56.276334+00	13035041/0004-08	
145	444014	2369605	RIO 2 -RJ INTERIOR 2	412767  -  PORTO FARMA FARM E PERF LTDA  -  INDEPENDENTE	PRC DR JOSE BONIFACIO TASSARA		CENTRO	CONCEIÇÃO DE MACABU	RJ	28740-000	2026-03-09 12:35:56.455389+00	13035041/0004-08	
146	444022	2369621	CAP RJ -CAPITAL	8869  -  DROGARIA NOBRE DE REALENGO LTDA  -  INDEPENDENTE	RUA DO GOVERNO		REALENGO	RIO DE JANEIRO	RJ	21770-100	2026-03-09 12:35:56.753493+00	55596103/0001-58	
147	444030	2369630	CAP RJ -CAPITAL	334766  -  FARM RAINHA DE MARECHAL HERMES  -  MAIS BARATO	R SIRICI		M HERMES	RIO DE JANEIRO	RJ	21555-360	2026-03-09 12:35:56.973808+00	15503175/0001-99	
148	444049	2369656	GRD RIO -GRANDE RIO	330671  -  DROG ATRATIVA DE OLINDA LTDA  -  MAIS BARATO	AV GETULIO DE MOURA		CENTRO	NILÓPOLIS	RJ	26510-000	2026-03-09 12:35:57.178878+00	14087515/0001-85	
149	444057	2369664	RIO 1 -RJ INTERIOR 1	395919  -  SOS VIDA RIO ATENDIMENTO DE URGENCIA AMB  -  INDEPENDENTE	ESTRADA EUGENIO GRIPP		BRAUNES	NOVA FRIBURGO	RJ	28611-300	2026-03-09 12:35:57.356557+00	13682936/0001-91	
150	444065	2369680	LAG 1 -RJ INTERIOR 1	367060  -  FARMACIA AMERICANA DE MACAE LTDA ME  -  INDEPENDENTE	RUA ALCIDES MOURÃO		AROEIRAS	MACAÉ	RJ	27945-402	2026-03-09 12:35:57.52469+00	24730875/0001-07	
151	444073	2369672	999 -PENA E MENEGHITTI 2006 TRANSP	422495  -  SILVA FARMA PRODUTOS FARMACEUTICOS SOCIE  -  SILVA FARMA	ESTRADA ACACIO RAPOSO		TRIBOBO	SÃO GONÇALO	RJ	24750-120	2026-03-09 12:35:57.717923+00	62748757/0001-15	
152	444081	2369753	RIO 2 -RJ INTERIOR 2	385077  -  PORTO FARMA FARM E PERF LTDA ME FIL 2  -  INDEPENDENTE	RUA GUILHERME BARBOSA		PORTO	CONCEIÇÃO DE MACABU	RJ	28740-000	2026-03-09 12:35:57.910107+00	13035041/0003-27	
153	444090	2369761	GRD RIO -GRANDE RIO	44075  -  FARM FARMAVIDA DO PACHECO LTDA  -  INDEPENDENTE	ESTRADA DO PACHECO		LAGOINHA	SÃO GONÇALO	RJ	24732-570	2026-03-09 12:35:58.098437+00	03336537/0001-15	
154	444103	2369885	CAP RJ -CAPITAL	416169  -  DROG THEO FARMA LTDA  -  DROG THEO FARMA LTDA	RUA LUIZA BARATA		REALENGO	RIO DE JANEIRO	RJ	21770-230	2026-03-09 12:35:58.278495+00	52815456/0001-03	
155	444111	2369524	GRD RIO -GRANDE RIO	346128  -  DROGARIA VITAL BRASIL LTDA  -  INDEPENDENTE	AV SETE DE SETEMBRO		S ROSA	NITERÓI	RJ	24230-253	2026-03-09 12:35:58.456884+00	86865359/0001-47	
209	444782	2370727	LAG 1 -RJ INTERIOR 1	370606  -  MOREIRA E MACIEIRA DROGARIA LTDA  -  DROG VITORIA	RUA SANTA CATARINA		CIDADE PRAIANA	RIO DAS OSTRAS	RJ	28890-084	2026-03-11 14:33:26.609949+00	26746039/0001-46	
210	444790	2370743	RIO 1 -RJ INTERIOR 1	351202  -  ALIANCA RENOVADA DROG LTDA ME  -  INDEPENDENTE	R PETROPOLIS		SIDERLANDIA	VOLTA REDONDA	RJ	27273-270	2026-03-11 14:33:26.797993+00	17330221/0001-20	
211	444804	2370794	RIO 1 -RJ INTERIOR 1	416568  -  DROG GUARANI LTDA  -  DROG GUARANI	RUA BEIRA LINHA		CASCATA GUARANY	TERESÓPOLIS	RJ	25957-030	2026-03-11 14:33:26.996667+00	50286192/0001-12	
212	444812	2370808	999 -PENA E MENEGHITTI 2006 TRANSP	421545  -  DROGARIA IMBUI LTDA  -  DROGARIA IMBUI LTDA	ESTRADA JOSE GOMES DA COSTA JR		CASCATA DO IMBUI	TERESÓPOLIS	RJ	25973-001	2026-03-11 14:33:27.179779+00	59122628/0001-02	
213	444820	2370824	999 -PENA E MENEGHITTI 2006 TRANSP	422320  -  DROGARIA DO POSTO COM VAR LTDA  -  MAXCENTER	RUA CARDOSO DE CASTRO		ANCHIETA	RIO DE JANEIRO	RJ	21630-080	2026-03-11 14:33:27.37212+00	62058702/0001-83	
214	444839	2370832	RIO 2 -RJ INTERIOR 2	312193  -  TF  DROG PERF LTDA ME  -  INDEPENDENTE	PRAÇA DR. JOSÉ BONIFÁCIO TASSARA		CONCEICAO DE MACABU	CONCEIÇÃO DE MACABU	RJ	28740-000	2026-03-11 14:33:27.55572+00	10626061/0001-12	
215	444847	2370840	999 -PENA E MENEGHITTI 2006 TRANSP	420611  -  FREIRE MACIEL DROGARIA LTDA  -  UNA FARMA	AVENIDA INDEPENDENCIA		UNAMAR	RIO DAS OSTRAS	RJ	28928-542	2026-03-11 14:33:27.7474+00	45881124/0001-61	
216	444855	2370875	LAG 1 -RJ INTERIOR 1	316172  -  ED DE SOUZA DROG R DAS OSTRAS  -  MAXCENTER	RODOVIA AMARAL PEIXOTO		CENTRO	RIO DAS OSTRAS	RJ	28890-000	2026-03-11 14:33:27.918785+00	11391818/0001-07	
217	444863	2370883	LAG 1 -RJ INTERIOR 1	363987  -  M M TARGINO DROGARIA LTDA  -  MAXCENTER	AV INDEPENDENCIA		UNAMAR (TAMOIOS)	RIO DAS OSTRAS	RJ	28928-542	2026-03-11 14:33:28.09112+00	24719862/0002-18	
218	444871	2370905	CAP RJ -CAPITAL	417289  -  DROG DROGATTA LTDA 2  -  DROG DROGATTA LTDA	RUA MARIA E BARROS		TIJUCA	RIO DE JANEIRO	RJ	20270-001	2026-03-11 14:33:28.2601+00	21746650/0002-31	
220	444898	2370930	CAP RJ -CAPITAL	319490  -  DROG TURMALINA LTDA  -  INDEPENDENTE	RUA SALINOPOLIS		TAQUARA	RIO DE JANEIRO	RJ	22720-000	2026-03-11 14:33:28.600639+00	12225957/0001-15	
221	444910	2370921	CAP RJ -CAPITAL	52809  -  DROG ANNEFARMA DA TIJUCA LTDA  -  INDEPENDENTE	RUA HADOCK LOBO		ESTACIO	RIO DE JANEIRO	RJ	20260-133	2026-03-11 14:33:28.965477+00	07487024/0001-66	
222	444928	2370948	GRD RIO -GRANDE RIO	46868  -  FARM ZAMPERLINE LTDA  -  NOVA REDE	ROD RIO SAO PAULO		FAZENDA CAXIAS	SEROPÉDICA	RJ	23890-000	2026-03-11 14:33:29.232966+00	07271985/0001-39	
88	442518	2367203	RIO 1 -RJ INTERIOR 1	413070  -  FARM NOVA DE CONQUISTA LTDA  -  INDEPENDENTE	AVN ANTONIO MARIO DE AZEVEDO		CAMPO DO COELHO	NOVA FRIBURGO	RJ	28630-590	2026-03-05 15:18:26.320511+00	02442706/0001-39	
94	443484	2368730	GRD RIO -GRANDE RIO	14010  -  FARM DA PCA V CRUZ LTDA-MTZ  -  INDEPENDENTE	RUA DR. PORCIUNCULA		V CRUZ	SÃO GONÇALO	RJ	24130-240	2026-03-05 20:12:38.311889+00	02514705/0001-52	
100	443468	2368684	GRD RIO -GRANDE RIO	27634  -  DROG UP LTDA  -  INDEPENDENTE	RUA JOSE MENDONCA DE CAMPOS		COLUBANDE	SÃO GONÇALO	RJ	24451-001	2026-03-05 21:01:26.168772+00	01233332/0001-89	
131	443972	2370620	CAP RJ -CAPITAL	52809  -  DROG ANNEFARMA DA TIJUCA LTDA  -  INDEPENDENTE	RUA HADOCK LOBO		ESTACIO	RIO DE JANEIRO	RJ	20260-133	2026-03-06 20:25:19.049804+00	07487024/0001-66	
137	443875	2369699	CAP RJ -CAPITAL	9814  -  FARM PONTO DE BOTAFOGO LTDA  -  INDEPENDENTE	RUA DA PASSAGEM		BOTAFOGO	RIO DE JANEIRO	RJ	22290-030	2026-03-06 20:47:26.585452+00	33258104/0001-50	
156	444120	2369966	999 -PENA E MENEGHITTI 2006 TRANSP	422320  -  DROGARIA DO POSTO COM VAR LTDA  -  MAXCENTER	RUA CARDOSO DE CASTRO		ANCHIETA	RIO DE JANEIRO	RJ	21630-080	2026-03-09 13:22:48.395012+00	62058702/0001-83	
157	444138	2369982	LAG 1 -RJ INTERIOR 1	57525  -  E C FARIA RANGEL E DROG LTDA  -  CITYFARMA	AV JANE MARIA MARTINS		MARILEIA	RIO DAS OSTRAS	RJ	28890-000	2026-03-09 13:22:48.610762+00	07978622/0001-38	
158	444146	2369990	LAG 1 -RJ INTERIOR 1	344788  -  CMJ DROGARIA LTDA ME  -  INDEPENDENTE	R ALCIDES MOURAO		AROEIRAS	MACAÉ	RJ	27945-402	2026-03-09 13:22:48.79026+00	17690106/0001-67	
159	444154	2370000	CAP RJ -CAPITAL	54542  -  DROG RAPIDA SAO CRISTOVAO LTDA  -  OFERTAO	RUA SAO LUIZ GONZAGA		SAO CRISTOVAO	RIO DE JANEIRO	RJ	20910-060	2026-03-09 13:22:48.965857+00	08014267/0001-40	
160	444162	2370026	999 -PENA E MENEGHITTI 2006 TRANSP	420093  -  E C FARIA RANGEL E DROGARIA  -  E C FARIA RANGEL E DROGARIA	SANTA CATARINA		CIDADE BEIRA MAR	RIO DAS OSTRAS	RJ	28890-140	2026-03-09 13:22:49.146757+00	07978622/0002-19	
161	444170	2370042	LAG 1 -RJ INTERIOR 1	34517  -  DROG PH DE ARARUAMA LTDA  -  INDEPENDENTE	AV. ARARUAMA		CENTRO	ARARUAMA	RJ	28970-000	2026-03-09 13:22:49.328502+00	07089107/0001-05	
162	444189	2370050	LAG 1 -RJ INTERIOR 1	27944  -  DROG PAMELLA DE ARARUAMA LTDA  -  INDEPENDENTE	AV. JOHN KENNEDY		CENTRO	ARARUAMA	RJ	28970-000	2026-03-09 13:22:49.513769+00	05588235/0001-60	
163	444197	2370077	999 -PENA E MENEGHITTI 2006 TRANSP	421596  -  VITORIAFARMA DROGARIA LTDA  -  DROGARIA TOPFARMA	RUA SILVA CARDOSO		PILAR	DUQUE DE CAXIAS	RJ	25233-170	2026-03-09 13:22:49.721994+00	58763677/0001-61	
164	444200	2370085	LAG 1 -RJ INTERIOR 1	348104  -  DROG PERF ANJOS DA LAGOA LTDA  -  INDEPENDENTE	AV NELSON CARVALHAES		MIRANTE DA LAGOA	MACAÉ	RJ	27925-490	2026-03-09 13:22:49.897937+00	18938840/0001-65	
165	444219	2370093	RIO 1 -RJ INTERIOR 1	305685  -  DROG M W 34 LTDA ME  -  INDEPENDENTE	RUA VEREADOR FRANCISCO EUGENIO VIEIRA		CENTRO	CANTAGALO	RJ	28500-000	2026-03-09 13:22:50.101889+00	08952112/0001-54	
166	444227	2370107	GRD RIO -GRANDE RIO	406864  -  DROG CENTRAL DO AMAPÁ LTDA  -  INDEPENDENTE	RUA DALILA		PQ BARAO DE AMAPA	DUQUE DE CAXIAS	RJ	25235-460	2026-03-09 13:22:50.292316+00	45914533/0001-17	
167	444235	2370115	999 -PENA E MENEGHITTI 2006 TRANSP	422487  -  ICV DROGARIAS LTDA  -  MAIS BARATO	AVENIDA VISCONDE DE ITAUNA		JD PRIMAVERA	DUQUE DE CAXIAS	RJ	25214-415	2026-03-09 13:22:50.582903+00	63231119/0001-95	
168	444243	2370123	RIO 2 -RJ INTERIOR 2	25119  -  FARMACIA ARCOZELO LTDA ME  -  INDEPENDENTE	AV. SESQUICENTENARIO, 247 LJ 1		PATY DO ALFERES	PATY DO ALFERES	RJ	26950-000	2026-03-09 13:22:50.772748+00	05100779/0001-30	
169	444251	2370131	RIO 1 -RJ INTERIOR 1	419036  -  ESTRELA SOLITARIA DE NOVA FRIBURGO LTDA  -  FARM SANTO ANTONIO	PRC PRESIDENTE GETULIO VARGAS		CENTRO	NOVA FRIBURGO	RJ	28610-175	2026-03-09 13:22:50.957354+00	54685721/0001-01	
170	444260	2370140	999 -PENA E MENEGHITTI 2006 TRANSP	422304  -  HIPER DROGARIA III LTDA  -  MAX CENTER	AVENIDA AFONSO TAUNAY		BARRA DA TIJUCA	RIO DE JANEIRO	RJ	22621-310	2026-03-09 13:22:51.149522+00	62548054/0001-43	
171	444278	2370166	RIO 2 -RJ INTERIOR 2	312193  -  TF  DROG PERF LTDA ME  -  INDEPENDENTE	PRAÇA DR. JOSÉ BONIFÁCIO TASSARA		CONCEICAO DE MACABU	CONCEIÇÃO DE MACABU	RJ	28740-000	2026-03-09 13:22:51.323243+00	10626061/0001-12	
172	444286	2370174	GRD RIO -GRANDE RIO	53090  -  DROG LUIZA BELFORD ROXO LTDA  -  NOVA REDE	ESTRADA LUIZ DE LEMOS		CARMARI	NOVA IGUAÇU	RJ	26040-080	2026-03-09 13:22:51.523533+00	07830343/0001-22	
173	444294	2370182	LAG 1 -RJ INTERIOR 1	413143  -  DISTRIB NOSSA FARMA LTDA  -  INDEPENDENTE	RUA RESENDE		JARDIM MARILEIA	RIO DAS OSTRAS	RJ	28895-883	2026-03-09 13:22:51.7097+00	48777472/0001-81	
174	444308	2370190	RIO 1 -RJ INTERIOR 1	352675  -  DROGATUR MED E PERF -FIL04  -  INDEPENDENTE	R DO COMERCIO		CENTRO	ANGRA DOS REIS	RJ	23900-563	2026-03-09 13:22:51.882639+00	04683341/0011-31	
175	444316	2370204	RIO 1 -RJ INTERIOR 1	352640  -  DROGATUR MED E PERF -FIL06  -  INDEPENDENTE	EST MUNICIPAL		PIRATAS MALL	ANGRA DOS REIS	RJ	23907-205	2026-03-09 13:22:52.054871+00	04683341/0007-55	
176	444324	2370212	RIO 1 -RJ INTERIOR 1	352705  -  DROGATUR MED E PERF -FIL05  -  INDEPENDENTE	RUA DO COMERCIO		CENTRO	ANGRA DOS REIS	RJ	23900-563	2026-03-09 13:22:52.224729+00	04683341/0009-17	
177	444332	2370220	RIO 1 -RJ INTERIOR 1	345130  -  DROGATUR MED E PERF -FIL10  -  INDEPENDENTE	AV JULIO MARIA		CENTRO	ANGRA DOS REIS	RJ	23900-504	2026-03-09 13:22:52.396256+00	04683341/0004-02	
178	444340	2370239	RIO 1 -RJ INTERIOR 1	356514  -  DROGATUR MED E PERF -FIL11  -  INDEPENDENTE	R LUIZ ELIAS MIGUEL		PARQUE DAS PALMEIRAS	ANGRA DOS REIS	RJ	23905-400	2026-03-09 13:22:52.580565+00	04683341/0012-12	
179	444359	2370247	RIO 1 -RJ INTERIOR 1	413275  -  DROGATUR MED E PERF LTDA FIL 25  -  INDEPENDENTE	AVN JULIO MARIA		CENTRO	ANGRA DOS REIS	RJ	23900-504	2026-03-09 13:22:52.749711+00	04683341/0022-94	
180	444367	2370255	RIO 1 -RJ INTERIOR 1	417220  -  DROGATUR MED E PERF LTDA FL 26  -  DROGATUR MED E PERF LTDA	RUA DO COMERCIO		CENTRO	ANGRA DOS REIS	RJ	23900-565	2026-03-09 13:22:52.918248+00	04683341/0023-75	
181	444375	2370263	GRD RIO -GRANDE RIO	56898  -  FARM MAIS SAUDE VICENTE C LTDA  -  MAIS BARATO	R PACOTI		JD ANHANGA	DUQUE DE CAXIAS	RJ	25264-015	2026-03-09 13:22:53.132336+00	06935453/0001-96	
182	444383	2370271	999 -PENA E MENEGHITTI 2006 TRANSP	422592  -  MEGAFARMA DE TANGUA LTDA  -  DROGARIA MAX	RUA MANOEL JOAO GONCALVES,		VL STO ANTONIO	TANGUÁ	RJ	24890-000	2026-03-09 13:22:53.315423+00	56267393/0001-59	
183	444391	2370280	LAG 1 -RJ INTERIOR 1	396575  -  RG PEREIRA DROG E PERF LTDA  -  INDEPENDENTE	ALM CAMPOMAR		CIDADE BEIRA MAR	RIO DAS OSTRAS	RJ	28890-251	2026-03-09 13:22:53.501705+00	30130351/0001-88	
184	444405	2370298	RIO 1 -RJ INTERIOR 1	412651  -  DROG SERRANA DE TERESÓPOLIS LTDA  -  INDEPENDENTE	AVN LÚCIO MEIRA		VARZEA	TERESÓPOLIS	RJ	25953-003	2026-03-09 13:22:53.673107+00	47248928/0001-53	
223	444766	2370700	LAG 1 -RJ INTERIOR 1	370606  -  MOREIRA E MACIEIRA DROGARIA LTDA  -  DROG VITORIA	RUA SANTA CATARINA		CIDADE PRAIANA	RIO DAS OSTRAS	RJ	28890-084	2026-03-11 14:52:22.99895+00	26746039/0001-46	
3	442070	2368757	GRD RIO -GRANDE RIO	28010  -  FARM REAL DE TRINDADE LTDA  -  INDEPENDENTE	R.BARRA DO PIRAI		TRINDADE	SÃO GONÇALO	RJ	24456-420	2026-03-04 15:16:09.252322+00	02663625/0001-69	
6	442135	2367599	999 -PENA E MENEGHITTI 2006 TRANSP	421308  -  DROGARIA YPU DE NOVA FRIBURGO LTDA ME -   -  DROGAVITA	RUA CORONEL ZAMITH		YPU	NOVA FRIBURGO	RJ	28613-560	2026-03-04 15:19:01.2639+00	28363017/0001-22	
7	442143	2367602	999 -PENA E MENEGHITTI 2006 TRANSP	421294  -  DROGAVITA CENTRO LTDA - CENTRO  -  DROGAVITA	AV COMTE BITTENCOUT		CENTRO	NOVA FRIBURGO	RJ	28655-000	2026-03-04 15:19:01.284412+00	10515075/0001-69	
8	442151	2367769	999 -PENA E MENEGHITTI 2006 TRANSP	422029  -  DROGARIA MCBP LTDA  -  DROGARIAS RIEGO	AVENIDA VICENTE DE CARVALHO		V CARVALHO	RIO DE JANEIRO	RJ	21210-154	2026-03-04 15:19:01.301938+00	43551062/0001-02	
89	442925	2369400	GRD RIO -GRANDE RIO	419435  -  DROG LIDER DE SARACURUNA LTDA  -  LIDER DE SARACURUNA	RUA CONDE DE IRAJA		JD ROSARIO	DUQUE DE CAXIAS	RJ	25220-175	2026-03-05 18:17:44.600657+00	57660598/0001-62	
95	443425	2368609	CAP RJ -CAPITAL	316423  -  DROG BOHADANA LTDA  -  MAIS BARATO	RUA LOASA		DEODORO	RIO DE JANEIRO	RJ	21670-380	2026-03-05 20:20:05.611778+00	11232122/0001-20	
101	443476	2368706	GRD RIO -GRANDE RIO	326046  -  DROG UP LTDA FIL  -  INDEPENDENTE	AV EWERTON XAVIER		ITAIPU	NITERÓI	RJ	24342-270	2026-03-05 21:11:09.685034+00	01233332/0002-60	
132	443964	2370611	CAP RJ -CAPITAL	359190  -  DROG DROGATTA LTDA  -  INDEPENDENTE	R CD DE BONFIM		TIJUCA	RIO DE JANEIRO	RJ	20520-050	2026-03-06 20:27:55.431053+00	21746650/0001-50	
138	443905	2369729	CAP RJ -CAPITAL	403776  -  DROG FARME DE AMOEDO LTDA  -  CRISTAL	RUA FARME DE AMOEDO		IPANEMA	RIO DE JANEIRO	RJ	22420-020	2026-03-06 21:01:20.853109+00	40351640/0001-60	
185	444537	2370301	999 -PENA E MENEGHITTI 2006 TRANSP	422304  -  HIPER DROGARIA III LTDA  -  MAX CENTER	AVENIDA AFONSO TAUNAY		BARRA DA TIJUCA	RIO DE JANEIRO	RJ	22621-310	2026-03-10 14:32:47.515387+00	62548054/0001-43	
186	444545	2370310	CAP RJ -CAPITAL	34193  -  FARM MARCELLYANE LTDA  -  VIVA BEM	RUA ANIBAL PORTO		IRAJA	RIO DE JANEIRO	RJ	21230-330	2026-03-10 14:32:47.704688+00	05863269/0001-15	
219	444880	2370891	CAP RJ -CAPITAL	359190  -  DROG DROGATTA LTDA  -  INDEPENDENTE	R CD DE BONFIM		TIJUCA	RIO DE JANEIRO	RJ	20520-050	2026-03-11 14:33:28.430197+00	21746650/0001-50	
227	444944	2370972	CAP RJ -CAPITAL	7986  -  DROG TAMBAU LTDA  -  INDEPENDENTE	RUA JOAQUIM NABUCO		COPACABANA	RIO DE JANEIRO	RJ	22080-030	2026-03-11 20:01:37.042561+00	03332385/0001-82	
229	444960	2371006	CAP RJ -CAPITAL	382205  -  WILLIAN S D FERREIRA COMERCIO E SERVICOS  -  INDEPENDENTE	AV DAS AMERICAS		RECREIO DOS BANDEIRANTES	RIO DE JANEIRO	RJ	22730-704	2026-03-11 20:01:37.415278+00	27302701/0001-31	
230	444979	2371030	999 -PENA E MENEGHITTI 2006 TRANSP	422029  -  DROGARIA MCBP LTDA  -  DROGARIAS RIEGO	AVENIDA VICENTE DE CARVALHO		V CARVALHO	RIO DE JANEIRO	RJ	21210-154	2026-03-11 20:01:37.642766+00	43551062/0001-02	
231	444987	2371057	999 -PENA E MENEGHITTI 2006 TRANSP	420999  -  DROGARIA UNICA FARMA LTDA  -  UNICA FARMA	PREFEITO MILME RIBEIRO		V ARAUJO	MACAÉ	RJ	27943-120	2026-03-11 20:01:37.854259+00	20682768/0036-20	
232	444995	2371111	LAG 1 -RJ INTERIOR 1	330191  -  FARM FARMAPOLO LTDA - ME  -  UNICA FARMA	RUA VEREADOR ABREU LIMA		CENTRO	MACAÉ	RJ	27916-020	2026-03-11 20:01:38.045115+00	14513201/0001-05	
233	445002	2371120	CAP RJ -CAPITAL	34193  -  FARM MARCELLYANE LTDA  -  VIVA BEM	RUA ANIBAL PORTO		IRAJA	RIO DE JANEIRO	RJ	21230-330	2026-03-11 20:01:38.229967+00	05863269/0001-15	
234	445010	2371138	CAP RJ -CAPITAL	4510  -  DROG BARRA CENTER LTDA  -  INDEPENDENTE	AV. DAS AMERICAS		BARRA DA TIJUCA	RIO DE JANEIRO	RJ	22790-851	2026-03-11 20:01:38.402628+00	68647700/0001-06	
235	445029	2371146	CAP RJ -CAPITAL	5045  -  DROG HUMAITA CENTER LTDA  -  INDEPENDENTE	RUA HUMAITA		HUMAITA	RIO DE JANEIRO	RJ	22261-000	2026-03-11 20:01:38.576284+00	01230959/0001-86	
236	445037	2371154	CAP RJ -CAPITAL	45853  -  FARM SILVA JUNIOR LTDA -ME  -  INDEPENDENTE	AV. ALFREDO BALTAZAR DA SILVEIRA		RECREIO DOS BANDEIRANTES	RIO DE JANEIRO	RJ	22790-710	2026-03-11 20:01:38.766485+00	07183102/0001-39	
237	445045	2371103	CAP RJ -CAPITAL	12025  -  DROG MABEL LTDA  -  INDEPENDENTE	RUA MARQUES DE ABRANTES		FLAMENGO	RIO DE JANEIRO	RJ	22230-060	2026-03-11 20:01:38.936885+00	00821450/0001-45	
238	445053	2371162	CAP RJ -CAPITAL	399787  -  DROG GENARO DE CARVALHO LTDA  -  INDEPENDENTE	AVN GENARO DE CARVALHO		RECREIO DOS BANDEIRANTES	RIO DE JANEIRO	RJ	22795-077	2026-03-11 20:01:39.108337+00	39744953/0001-08	
239	445061	2371170	CAP RJ -CAPITAL	419117  -  DROG GENARO DE CARVALHO LTDA-FILIAL  -  DROG FARMA HALL	AVN GENARO DE CARVALHO		RECREIO DOS BANDEIRANTES	RIO DE JANEIRO	RJ	22795-077	2026-03-11 20:01:39.344737+00	39744953/0003-61	
240	445070	2371189	LAG 1 -RJ INTERIOR 1	312061  -  AROEIRAS II FARMÁCIA E PERFUMARIA LTDA  -  UNICA FARMA	AVN RUI BARBOSA		CENTRO	MACAÉ	RJ	27910-361	2026-03-11 20:01:39.538405+00	10610516/0001-01	
241	445088	2371197	999 -PENA E MENEGHITTI 2006 TRANSP	420875  -  L R E DROGARIAS LTDA  -  DROGARIAS UNICA FARMA	AVENIDA RUI BARBOSA		CENTRO	MACAÉ	RJ	27910-361	2026-03-11 20:01:39.750444+00	56226153/0001-06	
242	445096	2371200	CAP RJ -CAPITAL	338125  -  DROG PROGRESSO DO REGINAS  -  MAIS BARATO	R MAJOR CONRADO		CORDOVIL	RIO DE JANEIRO	RJ	21250-280	2026-03-11 20:01:39.960436+00	10287572/0001-57	
243	445100	2371219	CAP RJ -CAPITAL	413062  -  DROG NOVA ERA DE RAMOS LTDA  -  INDEPENDENTE	RUA ARAÇUAI		SARACURUNA	DUQUE DE CAXIAS	RJ	25220-675	2026-03-11 20:01:40.14791+00	46136738/0001-81	
244	445118	2371227	999 -PENA E MENEGHITTI 2006 TRANSP	422185  -  LCA COMERCIO VAREJISTA DE COSMETICOS LTD  -  DROGARIA VIDA MAIS	RUA CORREIA DIAS		V GERAL	RIO DE JANEIRO	RJ	21241-959	2026-03-11 20:01:40.336996+00	61898514/0001-09	
245	445126	2371235	LAG 1 -RJ INTERIOR 1	319309  -  CENTRO FARM E PERF LTDA  -  UNICA FARMA	RUA ALCIDES MOURAO		AROEIRAS	MACAÉ	RJ	27945-401	2026-03-11 20:01:40.525535+00	11975938/0001-43	
246	445134	2371243	CAP RJ -CAPITAL	13714  -  DROGARIA VALERIA DA PRACA DO CARMO LTDA  -  DROGARIA VALERIA	AV. BRAZ DE PINA		VL PENHA	RIO DE JANEIRO	RJ	21210-671	2026-03-11 20:01:40.722354+00	63285731/0001-40	
247	445142	2371260	LAG 1 -RJ INTERIOR 1	66427  -  AROEIRAS FARM E PERF LTDA  -  UNICA FARMA	R ALCIDES MOURAO		AROEIRAS	MACAÉ	RJ	27945-401	2026-03-11 20:01:40.907066+00	08769514/0001-18	
248	445150	2371316	CAP RJ -CAPITAL	50970  -  DROG OBELISCO DA ILHA LTDA  -  INDEPENDENTE	ESTR DO GALEAO		PORTUGUESA	RIO DE JANEIRO	RJ	21931-387	2026-03-11 20:01:41.100427+00	07605401/0001-14	
249	445169	2371324	GRD RIO -GRANDE RIO	417076  -  DROG DELGADO LTDA  -  DROG DELGADO LTDA	RUA DELGADO DE CARVALHO		VL S ANTONIO	DUQUE DE CAXIAS	RJ	25040-240	2026-03-11 20:01:41.290103+00	54398783/0001-32	
250	445177	2370956	CAP RJ -CAPITAL	365092  -  DROG POSITIVA DO METRO CENTRAL EIRELI  -  INDEPENDENTE	AV PRESIDENTE VARGAS		CENTRO	RIO DE JANEIRO	RJ	20091-060	2026-03-11 20:01:41.474554+00	22022451/0001-62	
90	442585	2367408	RIO 1 -RJ INTERIOR 1	416312  -  DROGATUR MEDICAMENTOS E PERF LTDA FIL 27  -  DROGATUR MEDICAMENTOS E PERF L	RUA JAPORANGA		JAPUIBA	ANGRA DOS REIS	RJ	23934-055	2026-03-05 18:33:02.890482+00	04683341/0024-56	
188	444561	2370352	LAG 1 -RJ INTERIOR 1	419010  -  DROG E PERFUMARIA LAGOMAR LTDA  -  DROG LAGOMAR	AVN DOUTOR SÉRGIO VIEIRA DE MELLO		LAGOMAR	MACAÉ	RJ	27966-620	2026-03-10 15:11:20.31004+00	43367857/0001-57	
96	443441	2368668	GRD RIO -GRANDE RIO	306436  -  FARM DA PCA V CRUZ LTDA FL 1  -  INDEPENDENTE	RUA DR PORCIUNCULA		VENDA DA CRUZ	SÃO GONÇALO	RJ	24411-005	2026-03-05 20:35:46.631428+00	02514705/0002-33	
102	443638	2369192	CAP RJ -CAPITAL	326739  -  DROG DIAS DO MAGARCA LTDA ME  -  HIPERDROGAS	ESTRADA DO MAGARCA		CAMPO GRANDE	RIO DE JANEIRO	RJ	23035-380	2026-03-06 14:23:54.425465+00	13260414/0001-00	
103	443557	2369079	GRD RIO -GRANDE RIO	66826  -  DROG VIVA DE SARACURUNA LTDA  -  INDEPENDENTE	AV PRES ROOSEVELT,Q 1C-LT 3 E5 LJ 4		SARACURUNA	DUQUE DE CAXIAS	RJ	25212-390	2026-03-06 14:23:54.605366+00	08829765/0001-40	
104	443565	2369087	RIO 1 -RJ INTERIOR 1	416339  -  DROG E PERF FARMA SANTOS LTDA  -  DROG E PERF FARMA SANTOS LTDA	RUA ALBATROZ		ITAPEBA	MARICÁ	RJ	24913-290	2026-03-06 14:23:54.774898+00	52945428/0001-00	
105	443573	2369117	RIO 1 -RJ INTERIOR 1	12688  -  BOANERGE CORREA SA CIA LTDA  -  NOVA REDE	RUA QUINZE DE NOVEMBRO		CENTRO	RIO BONITO	RJ	28800-000	2026-03-06 14:23:54.975097+00	31513872/0001-87	
106	443581	2369125	LAG 1 -RJ INTERIOR 1	369438  -  DROGA MAIS PROD FARM E HOSP LTDA  -  INDEPENDENTE	RUA LUIZ CARLOS APRIGIO		PRQ AEROPORTO	MACAÉ	RJ	27963-572	2026-03-06 14:23:55.169709+00	31884806/0001-13	
107	443611	2369176	CAP RJ -CAPITAL	326720  -  FARM DIAS DE GUARATIBA LTDA ME  -  HIPERDROGAS	EST DA MATRIZ		GUARATIBA	RIO DE JANEIRO	RJ	23020-710	2026-03-06 14:23:55.35355+00	12661254/0001-30	
108	443620	2369184	CAP RJ -CAPITAL	319970  -  FARM DIAS DE SEPETIBA LTDA  -  HIPERDROGAS	ESTRADA DE SEPETIBA		SEPETIBA	RIO DE JANEIRO	RJ	23545-003	2026-03-06 14:23:55.543959+00	12235692/0001-36	
109	443646	2369206	RIO 1 -RJ INTERIOR 1	419141  -  DROG PAGUE SAUDE LTDA  -  DROG SAUDE	AVN JOAQUIM DA COSTA LIMA		SAO VICENTE	BELFORD ROXO	RJ	26170-485	2026-03-06 14:23:55.743877+00	54007560/0001-05	
110	443654	2369214	LAG 1 -RJ INTERIOR 1	357146  -  BIG FARMA PROD FARM E HOSP LTD  -  INDEPENDENTE	AV TANCREDO DE ALMEIDA NEVES		PRQ AEROPORTO	MACAÉ	RJ	27963-736	2026-03-06 14:23:55.941105+00	20139603/0001-86	
111	443662	2369222	CAP RJ -CAPITAL	396508  -  DROG MAIS BARATO TOP 20 LTDA  -  MAIS BARATO	ETR DE JACAREPAGUA		ANIL	RIO DE JANEIRO	RJ	22755-158	2026-03-06 14:23:56.126723+00	38826262/0001-82	
112	443670	2369230	CAP RJ -CAPITAL	321168  -  DROG CENTRAL DE V GERAL LTDA  -  MAIS BARATO	RUA VALENTIM MAGALHAES		V GERAL	RIO DE JANEIRO	RJ	21241-330	2026-03-06 14:23:56.338417+00	11302151/0001-10	
113	443689	2369249	CAW 1 -RJ INTERIOR 1	321010  -  DIANA VASCONCELOS AZEREDO DROG  -  INDEPENDENTE	RUA PRINCIPAL		CENTRO	CAMPOS DOS GOYTACAZES	RJ	28030-000	2026-03-06 14:23:56.627025+00	01415055/0001-25	
114	443697	2369257	CAP RJ -CAPITAL	307980  -  DIABETIQUES C P MED DIAB LTDA  -  INDEPENDENTE	AV NELSON CARDOSO		TAQUARA	RIO DE JANEIRO	RJ	22730-001	2026-03-06 14:23:56.806426+00	08928303/0001-80	
115	443700	2369265	CAP RJ -CAPITAL	5355  -  DROG DEZESSETE DE MARCO LTDA  -  MAIS BARATO	RUA GUARAUNA		VICENTE DE CARVALHO	RIO DE JANEIRO	RJ	21371-010	2026-03-06 14:23:57.043943+00	01245014/0001-38	
116	443727	2369290	GRD RIO -GRANDE RIO	316903  -  DROG RAINHA DA TROPICAL LTDA  -  INDEPENDENTE	RUA FREDERICO DE CASTRO PEREIRA		JD TROPICAL	NOVA IGUAÇU	RJ	26015-061	2026-03-06 14:23:57.239401+00	74099219/0001-26	
117	443735	2369303	CAP RJ -CAPITAL	321788  -  DROGARIA DIAS LIMA JH LTDA -07  -  HIPERDROGAS	ESTRADA DA PEDRA		GUARATIBA	RIO DE JANEIRO	RJ	23030-380	2026-03-06 14:23:57.444962+00	12057989/0001-59	
118	443743	2369311	CAP RJ -CAPITAL	418749  -  DROG GILGAL LTDA  -  DROG VIVA BEM	AVN DOM HELDER CAMARA		MARIA DA GRAÇA	RIO DE JANEIRO	RJ	21050-455	2026-03-06 14:23:57.652947+00	57022174/0001-72	
119	443751	2369338	999 -PENA E MENEGHITTI 2006 TRANSP	422029  -  DROGARIA MCBP LTDA  -  DROGARIAS RIEGO	AVENIDA VICENTE DE CARVALHO		V CARVALHO	RIO DE JANEIRO	RJ	21210-154	2026-03-06 14:23:57.838394+00	43551062/0001-02	
120	443760	2369346	999 -PENA E MENEGHITTI 2006 TRANSP	420573  -  FARMÁCIA NOSSA SENHORA DE MACAÉ LTDA  -  FARMÁCIA NOSSA SENHORA DE MACA	RUA PROFESSORA ANNA BENEDICTA		DA GLORIA	MACAÉ	RJ	27933-060	2026-03-06 14:23:58.034835+00	45879470/0001-05	
121	443778	2369354	CAP RJ -CAPITAL	13714  -  DROGARIA VALERIA DA PRACA DO CARMO LTDA  -  DROGARIA VALERIA	AV. BRAZ DE PINA		VL PENHA	RIO DE JANEIRO	RJ	21210-671	2026-03-06 14:23:58.285443+00	63285731/0001-40	
122	443786	2369362	999 -PENA E MENEGHITTI 2006 TRANSP	421545  -  DROGARIA IMBUI LTDA  -  DROGARIA IMBUI LTDA	ESTRADA JOSE GOMES DA COSTA JR		CASCATA DO IMBUI	TERESÓPOLIS	RJ	25973-001	2026-03-06 14:23:58.523481+00	59122628/0001-02	
123	443794	2369370	LAG 1 -RJ INTERIOR 1	314331  -  VANUSA DA SILVA GRIGÓRIO DO NASCIMENTO E  -  UNICA FARMA	AVENIDA NOSSA SENHORA DA GLORIA		CAVALEIROS	MACAÉ	RJ	27920-360	2026-03-06 14:23:58.713491+00	10938861/0001-79	
124	443808	2369419	CAP RJ -CAPITAL	412872  -  DROG VITORIA DA MARE LTDA  -  VIVA MAIS	AVN GUILHERME MAXWELL		MARE	RIO DE JANEIRO	RJ	21040-212	2026-03-06 14:23:58.897999+00	50046079/0001-60	
125	443816	2369435	GRD RIO -GRANDE RIO	411132  -  DROG TERRA PROMETIDA LTDA  -  INDEPENDENTE	RUA DR. ALBERTO JEREMIAS DA SILVEIRA MENEZES		JARDIM SUMARE	SÃO JOÃO DE MERITI	RJ	25580-000	2026-03-06 14:23:59.146238+00	48483924/0001-12	
126	443824	2369451	CAW 1 -RJ INTERIOR 1	334332  -  DROG VALLE DE ITALVA LTDA ME  -  INDEPENDENTE	AV PORTELA SALLES		CENTRO	ITALVA	RJ	28250-000	2026-03-06 14:23:59.333962+00	14110285/0001-28	
127	443832	2369478	CAP RJ -CAPITAL	34193  -  FARM MARCELLYANE LTDA  -  VIVA BEM	RUA ANIBAL PORTO		IRAJA	RIO DE JANEIRO	RJ	21230-330	2026-03-06 14:23:59.532794+00	05863269/0001-15	
133	443956	2370603	CAP RJ -CAPITAL	28916  -  DROG ARQUIPELAGO LTDA  -  INDEPENDENTE	RUA HADOCK LOBO		ESTACIO	RIO DE JANEIRO	RJ	20260-130	2026-03-06 20:31:39.832592+00	05784885/0001-80	
139	443891	2369710	CAP RJ -CAPITAL	2267  -  FARM DIAS FERREIRA LTDA  -  INDEPENDENTE	RUA DIAS FERREIRA		LEBLON	RIO DE JANEIRO	RJ	22431-050	2026-03-06 21:05:25.566267+00	00485260/0001-02	
187	444553	2370344	LAG 1 -RJ INTERIOR 1	17183  -  ARACELI MEDEIROS MOTA DROG  -  INDEPENDENTE	AV. IRMA JOSEFINA VEIGA		PARQUE SIQUEIRA	CABO FRIO	RJ	28911-120	2026-03-10 15:11:20.105819+00	00690950/0001-95	
189	444570	2370360	999 -PENA E MENEGHITTI 2006 TRANSP	421308  -  DROGARIA YPU DE NOVA FRIBURGO LTDA ME -   -  DROGAVITA	RUA CORONEL ZAMITH		YPU	NOVA FRIBURGO	RJ	28613-560	2026-03-10 15:11:20.52318+00	28363017/0001-22	
190	444588	2370379	999 -PENA E MENEGHITTI 2006 TRANSP	421294  -  DROGAVITA CENTRO LTDA - CENTRO  -  DROGAVITA	AV COMTE BITTENCOUT		CENTRO	NOVA FRIBURGO	RJ	28655-000	2026-03-10 15:11:20.782904+00	10515075/0001-69	
191	444596	2370387	RIO 1 -RJ INTERIOR 1	419001  -  DROG TRÊS PICOS LTDA  -  DROG TRÊS PICOS LTDA	ETR DE SAO LOURENCO		SALINAS	NOVA FRIBURGO	RJ	28630-991	2026-03-10 15:11:20.992677+00	41134068/0001-40	
192	444600	2370395	RIO 1 -RJ INTERIOR 1	5053  -  SALES E TEIXEIRA LTDA - ME  -  DROGAVITA	RUA JOSE DE QUEIROZ		CONSELHEIRO PAULINO	NOVA FRIBURGO	RJ	28633-500	2026-03-10 15:11:21.364864+00	02568960/0001-88	
9	442178	2367998	CAW 1 -RJ INTERIOR 1	419729  -  DROG RCM LTDA  -  DROG RCM LTDA	ESTRADA CABUCU		CAMPO GRANDE	RIO DE JANEIRO	RJ	23017-250	2026-03-04 15:19:01.319921+00	51269519/0001-00	
10	442186	2368536	LAG 1 -RJ INTERIOR 1	344788  -  CMJ DROGARIA LTDA ME  -  INDEPENDENTE	R ALCIDES MOURAO		AROEIRAS	MACAÉ	RJ	27945-402	2026-03-04 15:19:01.334142+00	17690106/0001-67	
11	442194	2367890	LAG 1 -RJ INTERIOR 1	55000  -  GR MOREIRA E CIA LTDA ME  -  INDEPENDENTE	AV DOS BANDEIRANTES		COSTA AZUL	RIO DAS OSTRAS	RJ	28890-000	2026-03-04 15:19:01.356101+00	05466703/0001-23	
12	442208	2368269	LAG 1 -RJ INTERIOR 1	15318  -  EC DE SOUZA LTDA  -  MAXCENTER	ROD. AMARAL PEIXOTO		AQUARIOS	CABO FRIO	RJ	28927-000	2026-03-04 15:19:01.375043+00	39186952/0001-87	
13	442216	2368307	LAG 1 -RJ INTERIOR 1	328138  -  BDE DROG LTDA  -  MAXCENTER	RUA DAS CASUARINAS		RESIDENCIAL PRAIA ANCORA	RIO DAS OSTRAS	RJ	28890-000	2026-03-04 15:19:01.411316+00	13504334/0001-44	
15	442232	2368293	LAG 1 -RJ INTERIOR 1	321990  -  DJD DROG DE BUZIOS LTDA  -  MAXCENTER	RUA PROGRESSO		SEM BRACA	ARMAÇÃO DOS BÚZIOS	RJ	28950-000	2026-03-04 15:19:01.44661+00	08818571/0001-40	
16	442240	2368323	LAG 1 -RJ INTERIOR 1	59587  -  J J SILVA SOARES E DROG LTDA  -  MAXCENTER	ESTR CALIFORNIA		COSTAZUL	RIO DAS OSTRAS	RJ	28895-658	2026-03-04 15:19:01.462531+00	08017593/0001-00	
17	442267	2367793	LAG 1 -RJ INTERIOR 1	417122  -  DROG VIVA BEM DE ARARUAMA LTDA  -  DROG VIVA BEM DE ARARUAMA LTDA	RUA FRANCISCO ANDRADE		CENTRO	ARARUAMA	RJ	28979-114	2026-03-04 15:19:01.477517+00	52751318/0001-08	
18	442275	2368048	LAG 1 -RJ INTERIOR 1	412180  -  DROG SUPERAÇÃO LTDA - FIL 02  -  GRUPO ALEXANDRE	RUA LUIZ GOMES		CENTRO	SILVA JARDIM	RJ	28820-000	2026-03-04 15:19:01.490832+00	47749937/0013-61	
19	442283	2368056	LAG 1 -RJ INTERIOR 1	412015  -  DROG SUPERAÇÃO LTDA - FIL 03  -  GRUPO ALEXANDRE	AVN GOVERNADOR LEONEL DE MOURA BRIZOLA		CENTRO	ARRAIAL DO CABO	RJ	28930-000	2026-03-04 15:19:01.517981+00	47749937/0003-90	
20	442291	2368064	LAG 1 -RJ INTERIOR 1	412082  -  DROG SUPERAÇÃO LTDA - FIL 04  -  GRUPO ALEXANDRE	RUA CORONEL JOAO BRAVO		CENTRO	SAQUAREMA	RJ	28990-784	2026-03-04 15:19:01.533302+00	47749937/0009-85	
21	442305	2368080	LAG 1 -RJ INTERIOR 1	412058  -  DROG SUPERAÇÃO LTDA - FIL 06  -  GRUPO ALEXANDRE	AVN CENTRA		PARQUE VIEIRA	CABO FRIO	RJ	28915-550	2026-03-04 15:19:01.548794+00	47749937/0002-09	
23	442321	2368110	LAG 1 -RJ INTERIOR 1	411892  -  DROG SUPERAÇÃO LTDA - FIL 10  -  GRUPO ALEXANDRE	AVN GETÚLIO VARGAS		CENTRO	ARARUAMA	RJ	28979-129	2026-03-04 15:19:01.580991+00	47749937/0006-32	
24	442330	2368137	LAG 1 -RJ INTERIOR 1	412198  -  DROG SUPERAÇÃO LTDA - FIL 11  -  GRUPO ALEXANDRE	PRC SANTO ANTÔNIO		BACAXA	SAQUAREMA	RJ	28994-792	2026-03-04 15:19:01.59863+00	47749937/0010-19	
26	442356	2368170	LAG 1 -RJ INTERIOR 1	412260  -  DROG SUPERAÇÃO LTDA - FIL 13  -  GRUPO ALEXANDRE	RUA DOUTOR ANTONIO ALVES		CENTRO	SÃO PEDRO DA ALDEIA	RJ	28941-156	2026-03-04 15:19:01.629095+00	47749937/0004-70	
27	442364	2368218	LAG 1 -RJ INTERIOR 1	412031  -  DROG SUPERAÇÃO LTDA - FIL 19 MATRIZ  -  GRUPO ALEXANDRE	RUA SILVA JARDIM		CENTRO	CABO FRIO	RJ	28905-220	2026-03-04 15:19:01.643283+00	47749937/0001-28	
28	442372	2368331	LAG 1 -RJ INTERIOR 1	362417  -  MM TARGINO DROGARIA EIRELI  -  MAXCENTER	ROD AMARAL PEIXOTO		CENTRO	RIO DAS OSTRAS	RJ	28893-076	2026-03-04 15:19:01.660834+00	24719862/0001-37	
29	442380	2367580	LAG 2 -RJ INTERIOR 2	47201  -  TEIXEIRA E SALE DROG LTDA  -  DROGAVITA	PRAÇA DR ORLANDO OBERLANDER		CENTRO	BOM JARDIM	RJ	28660-000	2026-03-04 15:19:01.678315+00	28790202/0001-01	
30	442399	2368714	LAG 2 -RJ INTERIOR 2	47201  -  TEIXEIRA E SALE DROG LTDA  -  DROGAVITA	PRAÇA DR ORLANDO OBERLANDER		CENTRO	BOM JARDIM	RJ	28660-000	2026-03-04 15:19:01.69482+00	28790202/0001-01	
91	443395	2369320	999 -PENA E MENEGHITTI 2006 TRANSP	422029  -  DROGARIA MCBP LTDA  -  DROGARIAS RIEGO	AVENIDA VICENTE DE CARVALHO		V CARVALHO	RIO DE JANEIRO	RJ	21210-154	2026-03-05 18:53:36.881694+00	43551062/0001-02	
97	443433	2368641	GRD RIO -GRANDE RIO	27537  -  D ALCANTARA FARM LTDA  -  INDEPENDENTE	AV. DOMINGOS DAMASCENO DUARTE		TRINDADE	SÃO GONÇALO	RJ	24456-422	2026-03-05 20:44:46.046429+00	30944169/0001-60	
128	443603	2369168	CAP RJ -CAPITAL	303402  -  DROG ATRATIVA DE SEPETIBA LTDA  -  HIPERDROGAS	ESTRADA DO PIAI		SEPETIBA	RIO DE JANEIRO	RJ	23530-610	2026-03-06 15:27:45.032008+00	09026944/0001-02	
134	443930	2370581	CAP RJ -CAPITAL	417289  -  DROG DROGATTA LTDA 2  -  DROG DROGATTA LTDA	RUA MARIA E BARROS		TIJUCA	RIO DE JANEIRO	RJ	20270-001	2026-03-06 20:39:07.680456+00	21746650/0002-31	
140	443921	2370158	999 -PENA E MENEGHITTI 2006 TRANSP	421634  -  DROGARIA DONA MARIANA LTDA  -  DROGARIAS CRISTAL	RUA VOLUNTARIOS DA PATRIA		BOTAFOGO	RIO DE JANEIRO	RJ	22270-001	2026-03-06 21:11:50.480003+00	60660518/0001-83	
193	444618	2370409	LAG 2 -RJ INTERIOR 2	340030  -  DROG ZILLE E LIMA LTDA ME  -  INDEPENDENTE	R VISCONDE DE QUISSAMA		CENTRO	QUISSAMÃ	RJ	28735-000	2026-03-10 15:11:21.589217+00	15769320/0001-88	
194	444626	2370417	999 -PENA E MENEGHITTI 2006 TRANSP	421790  -  VL SANTOS E PAIVA DROGARIA LTDA  -  SANTOS FARMA	ESTRADA VELHA RIO DOURADO		JARDIM MIRAMAR	RIO DAS OSTRAS	RJ	28890-017	2026-03-10 15:11:21.820841+00	61411147/0001-69	
195	444634	2370433	999 -PENA E MENEGHITTI 2006 TRANSP	420468  -  L SANTOS E MONTEIRO LTDA  -  DROGARIA FERNANDES	RUA ABEL SANTOS DE SIQUEIRA		RECANTO RI DAS OSTRAS	RIO DAS OSTRAS	RJ	28890-630	2026-03-10 15:11:22.049057+00	58639942/0001-02	
196	444642	2370441	999 -PENA E MENEGHITTI 2006 TRANSP	420468  -  L SANTOS E MONTEIRO LTDA  -  DROGARIA FERNANDES	RUA ABEL SANTOS DE SIQUEIRA		RECANTO RI DAS OSTRAS	RIO DAS OSTRAS	RJ	28890-630	2026-03-10 15:11:22.263787+00	58639942/0001-02	
197	444650	2370468	CAP RJ -CAPITAL	414328  -  FRANCOS DROGARIAS LTDA MTZ  -  INDEPENDENTE	AVN GENERAL OSVALDO CORDEIRO DE FARIAS		M HERMES	RIO DE JANEIRO	RJ	21610-480	2026-03-10 15:11:22.481256+00	44335155/0001-54	
198	444669	2370476	GRD RIO -GRANDE RIO	397881  -  DROG LIDER DE CAXIAS LTDA  -  MAIS BARATO	ETR CALUNDU		VILA SAO JOSE	DUQUE DE CAXIAS	RJ	25040-610	2026-03-10 15:11:22.677731+00	40648080/0001-00	
199	444677	2370484	LAG 2 -RJ INTERIOR 2	47201  -  TEIXEIRA E SALE DROG LTDA  -  DROGAVITA	PRAÇA DR ORLANDO OBERLANDER		CENTRO	BOM JARDIM	RJ	28660-000	2026-03-10 15:11:22.98135+00	28790202/0001-01	
200	444685	2370492	CAW 1 -RJ INTERIOR 1	21903  -  TOCOS DROG LTDA  -  INDEPENDENTE	RUA GUILHERME MORISSON		TOCOS	CAMPOS DOS GOYTACAZES	RJ	28148-000	2026-03-10 15:11:23.210905+00	29614559/0001-93	
201	444693	2370336	GRD RIO -GRANDE RIO	403091  -  EXATA DROG E PERF LTDA  -  INDEPENDENTE	RUA BELISARIO PENA		VL S LUIS	NOVA IGUAÇU	RJ	26012-355	2026-03-10 15:11:23.396869+00	27375507/0001-86	
202	444707	2370514	999 -PENA E MENEGHITTI 2006 TRANSP	422207  -  DROGARIA PREFERIDA PARADA DE LUCAS LTDA  -  DROGARIA PREFERIDA	RUA LUCAS RODRIGUES		PDA LUCAS	RIO DE JANEIRO	RJ	21250-410	2026-03-10 15:11:23.61077+00	63138631/0001-91	
203	444715	2370522	LAG 1 -RJ INTERIOR 1	337153  -  MAIS VIDA DROGA LTDA  -  INDEPENDENTE	RUA L		UNAMAR	CABO FRIO	RJ	28927-000	2026-03-10 15:11:23.794406+00	03147371/0001-99	
224	444901	2370913	CAP RJ -CAPITAL	28916  -  DROG ARQUIPELAGO LTDA  -  INDEPENDENTE	RUA HADOCK LOBO		ESTACIO	RIO DE JANEIRO	RJ	20260-130	2026-03-11 15:14:42.508477+00	05784885/0001-80	
31	442402	2367904	LAG 2 -RJ INTERIOR 2	352420  -  FARM BRASIL DE QUISSAMA LTDA  -  INDEPENDENTE	R BARAO DE VILA FRANCA		CENTRO	QUISSAMÃ	RJ	28735-000	2026-03-04 15:19:01.711036+00	20483812/0001-42	
32	442410	2367718	RIO 1 -RJ INTERIOR 1	66257  -  DROG SIMAO E MARINHO LTDA  -  INDEPENDENTE	R AFONSO SALLES		MANILHA	ITABORAÍ	RJ	24800-000	2026-03-04 15:19:01.725746+00	08847231/0001-47	
33	442437	2368226	RIO 1 -RJ INTERIOR 1	22691  -  FARM MARANATA LTDA  -  CITYFARMA	RUA MANOEL JOAO GONCALVES		CENTRO	TANGUÁ	RJ	24840-000	2026-03-04 15:19:01.752878+00	28961613/0001-04	
46	442674	2368382	RIO 1 -RJ INTERIOR 1	353205  -  DROG ULTRAPOPULAR DE ITATIAIA FIL 03 (IT  -  INDEPENDENTE	R PREFEITO ASSUMPCAO		CENTRO	ITATIAIA	RJ	27580-000	2026-03-04 16:19:50.682952+00	19418959/0001-70	
38	442593	2367521	RIO 1 -RJ INTERIOR 1	356085  -  DROG RENOVACAO PROD FARM EIRELI  -  INDEPENDENTE	R SETE DE ABRIL		PARQUE MAMBUCABA	ANGRA DOS REIS	RJ	23954-065	2026-03-04 15:19:01.839639+00	20794892/0001-57	
39	442607	2367564	RIO 1 -RJ INTERIOR 1	347507  -  BRUNO P ROZALES COM DE PROD FA  -  INDEPENDENTE	AVN GOVERNADOR ROBERTO SILVEIRA		AMPARO	NOVA FRIBURGO	RJ	28605-970	2026-03-04 15:19:01.855242+00	18130584/0001-85	
40	442615	2367815	RIO 1 -RJ INTERIOR 1	417220  -  DROGATUR MED E PERF LTDA FL 26  -  DROGATUR MED E PERF LTDA	RUA DO COMERCIO		CENTRO	ANGRA DOS REIS	RJ	23900-565	2026-03-04 15:19:01.869379+00	04683341/0023-75	
41	442623	2367858	RIO 1 -RJ INTERIOR 1	362638  -  DROG FARMAPLUS LTDA - ME  -  INDEPENDENTE	AV AFONSO SALLES		APOLO II	ITABORAÍ	RJ	24858-556	2026-03-04 15:19:01.885175+00	28060082/0001-89	
42	442631	2367866	RIO 1 -RJ INTERIOR 1	402303  -  DROG PHARMARES LTDA  -  NOVA REDE	AVN 22 DE MAIO		VENDA DAS PEDRAS	ITABORAÍ	RJ	24804-703	2026-03-04 15:19:01.902973+00	12751916/0001-62	
43	442640	2368021	RIO 1 -RJ INTERIOR 1	412074  -  DROG SUPERAÇÃO LTDA - FIL 01  -  GRUPO ALEXANDRE	RUA GETULIO VARGAS		CENTRO	RIO BONITO	RJ	28800-000	2026-03-04 15:19:01.922359+00	47749937/0014-42	
50	442712	2368471	RIO 1 -RJ INTERIOR 1	359777  -  DROG CAMPOS ELISEOS LTDA FIL 08 (PARAISO  -  INDEPENDENTE	RUA NOSSA SENHORA DE FATIMA		PARAISO	RESENDE	RJ	27536-220	2026-03-04 16:19:50.713754+00	29285269/0004-96	
49	442704	2368463	RIO 1 -RJ INTERIOR 1	366900  -  DROG CAMPOS ELISEOS LTDA FIL 07 (STO AGO  -  INDEPENDENTE	R SOLDADO FRANCISCO ALVES ROCHA		S AGOSTINHO	VOLTA REDONDA	RJ	27211-160	2026-03-04 16:19:50.70751+00	29285269/0007-39	
51	442720	2368480	RIO 1 -RJ INTERIOR 1	366889  -  DROG CAMPOS ELISEOS LTDA FIL 11 (UNIAO A  -  INDEPENDENTE	AV DAS MANGUEIRAS		C ALEGRIA	RESENDE	RJ	27525-250	2026-03-04 16:19:50.722396+00	29285269/0005-77	
52	442747	2368501	RIO 1 -RJ INTERIOR 1	366935  -  DROG CAMPOS ELISEOS LTDA FIL 15 (RODOVIA  -  INDEPENDENTE	AVN DOUTOR GUSTAVO JARDIM		CENTRO	RESENDE	RJ	27511-360	2026-03-04 16:19:50.737483+00	29285269/0006-58	
53	442755	2368811	RIO 1 -RJ INTERIOR 1	405060  -  VALHALLA IMPORTACAO E COMERCIO LTDA FILI  -  INDEPENDENTE	RUA COELHO NETTO,		SANTA TEREZINHA	VASSOURAS	RJ	27700-000	2026-03-04 16:19:50.757761+00	22782636/0002-56	
54	442763	2367416	RIO 2 -RJ INTERIOR 2	9954  -  DROG CONTI MIRANDA LTDA  -  INDEPENDENTE	AV. ROBERTO SILVEIRA		VILA COLONIAL	PARATI	RJ	23970-000	2026-03-04 16:19:50.769486+00	36235927/0001-58	
55	442771	2367807	RIO 2 -RJ INTERIOR 2	34266  -  DROG PERF BERDAN MP LTDA  -  INDEPENDENTE	LGO DO MACHADINHO		CENTRO	MIGUEL PEREIRA	RJ	26900-000	2026-03-04 16:19:50.790632+00	06926467/0001-43	
56	442780	2367823	RIO 2 -RJ INTERIOR 2	34266  -  DROG PERF BERDAN MP LTDA  -  INDEPENDENTE	LGO DO MACHADINHO		CENTRO	MIGUEL PEREIRA	RJ	26900-000	2026-03-04 16:19:50.798905+00	06926467/0001-43	
58	442801	2368145	RIO 2 -RJ INTERIOR 2	3689  -  FARM N SRA DA CONCEICAO PATY  -  INDEPENDENTE	RUA DR. SEBASTIAO LACERDA		CENTRO	PATY DO ALFERES	RJ	26950-000	2026-03-04 16:19:50.817509+00	32404246/0001-15	
60	442828	2367505	RIO 2 -RJ INTERIOR 2	306550  -  J C W SIQUEIRA FARM  -  INDEPENDENTE	AVENIDA NILO PEÇANHA		CENTRO	VALENÇA	RJ	27600-000	2026-03-04 16:19:50.82922+00	09137657/0001-70	
61	442836	2368013	RIO 2 -RJ INTERIOR 2	313670  -  DROG PERF XII LTDA-ME  -  INDEPENDENTE	RUA FRANCISCO MACHADO		CENTRO	MIGUEL PEREIRA	RJ	26900-000	2026-03-04 16:19:50.833648+00	10512018/0001-26	
62	442844	2368005	RIO 2 -RJ INTERIOR 2	400718  -  DROG E PERF BERDAN MP 2 LTDA  -  INDEPENDENTE	RUA DONA MARIA JOSE		CENTRO	MIGUEL PEREIRA	RJ	26900-000	2026-03-04 16:19:50.839778+00	42656909/0001-42	
63	442909	2367262	CAP RJ -CAPITAL	419834  -  DROG LEVFARMA DE OLARIA LTDA  -  MAIS BARATO	RUA ANGELICA MOTA		OLARIA	RIO DE JANEIRO	RJ	21021-490	2026-03-04 16:19:50.849082+00	54104667/0001-63	
64	442933	2369281	CAP RJ -CAPITAL	325988  -  FARM PARANAPUAN DA ILHA LTDA  -  MAXCENTER	AV PARANAPUAN		ILHA DO GOVERNADOR	RIO DE JANEIRO	RJ	21853-480	2026-03-04 16:19:50.863157+00	12417658/0001-82	
65	443000	2367092	CAP RJ -CAPITAL	50970  -  DROG OBELISCO DA ILHA LTDA  -  INDEPENDENTE	ESTR DO GALEAO		PORTUGUESA	RIO DE JANEIRO	RJ	21931-387	2026-03-04 16:19:50.869341+00	07605401/0001-14	
66	443018	2367122	CAP RJ -CAPITAL	363618  -  DROGATUR MEDICAMENTOS E PERFUMARIA LTDA  -  INDEPENDENTE	EST RJ 14		MURIQUI	MANGARATIBA	RJ	23860-000	2026-03-04 16:19:50.87771+00	04683341/0015-65	
67	443026	2367130	CAP RJ -CAPITAL	8966  -  FARM ANDORRA LTDA  -  INDEPENDENTE	RUA ANDORRA		PADRE MIGUEL	RIO DE JANEIRO	RJ	21875-120	2026-03-04 16:19:50.883445+00	33537143/0001-96	
68	443034	2367440	GRD RIO -GRANDE RIO	56162  -  E G B BIA FARM LTDA  -  INDEPENDENTE	RUA CLARA DE ARAUJO		ENGENHO PEQUENO	NOVA IGUAÇU	RJ	26010-390	2026-03-04 16:19:50.890104+00	03133179/0001-43	
69	443042	2367424	CAP RJ -CAPITAL	407364  -  DROG MÁXIMO ECONOMIA LTDA  -  INDEPENDENTE	RUA JOAQUIM DE QUEIROZ		COMPLEXO DO ALEMAO	RIO DE JANEIRO	RJ	21061-610	2026-03-04 16:19:50.904248+00	44286507/0001-29	
70	443069	2369486	LAG 1 -RJ INTERIOR 1	329037  -  DROG DROGAMAR DE MACAE  -  INDEPENDENTE	AVENIDA W5		LAGOMAR	MACAÉ	RJ	27970-420	2026-03-04 16:19:50.925772+00	12097607/0001-10	
71	443085	2369508	CAP RJ -CAPITAL	8966  -  FARM ANDORRA LTDA  -  INDEPENDENTE	RUA ANDORRA		PADRE MIGUEL	RIO DE JANEIRO	RJ	21875-120	2026-03-04 16:19:50.934392+00	33537143/0001-96	
73	443107	2369540	RIO 2 -RJ INTERIOR 2	22810  -  DROG TERESINA LTDA  -  INDEPENDENTE	AV. JOSE DE ALENCAR		CENTRO	SUMIDOURO	RJ	28637-000	2026-03-04 16:19:50.945089+00	28835726/0001-63	
75	443212	2367637	CAP RJ -CAPITAL	6050  -  FARM CENTRAL DA TUNISIA LTDA  -  NOVA REDE	RUA TUNISIA		VILA KENEDY	RIO DE JANEIRO	RJ	21853-430	2026-03-04 16:19:50.955454+00	01009399/0001-34	
76	443263	2367653	CAP RJ -CAPITAL	11657  -  DROGAPEREZ DROG LTDA  -  NOVA REDE	EST. CORONEL VIEIRA		IRAJA	RIO DE JANEIRO	RJ	21220-310	2026-03-04 16:19:50.960004+00	29494341/0001-42	
34	442445	2368374	RIO 1 -RJ INTERIOR 1	343838  -  DROG ULTRAPOPULAR DE ANGRA DOS REIS FIL   -  INDEPENDENTE	RUA DO COMERCIO		CENTRO	ANGRA DOS REIS	RJ	23900-560	2026-03-04 15:19:01.771537+00	18242999/0001-40	
4	442119	2367475	999 -PENA E MENEGHITTI 2006 TRANSP	421030  -  ESSENCIAL FARMA PIMENTEIRAS LTDA  -  ESSENCIAL	EST DAS PIMENTEIRAS		PIMENTEIRAS	TERESÓPOLIS	RJ	25963-007	2026-03-04 15:16:09.261473+00	58111087/0001-54	
5	442127	2367483	999 -PENA E MENEGHITTI 2006 TRANSP	421545  -  DROGARIA IMBUI LTDA  -  DROGARIA IMBUI LTDA	ESTRADA JOSE GOMES DA COSTA JR		CASCATA DO IMBUI	TERESÓPOLIS	RJ	25973-001	2026-03-04 15:19:01.203481+00	59122628/0001-02	
37	442470	2368404	RIO 1 -RJ INTERIOR 1	46140  -  DROG CAMPOS ELISIOS LTDA FIL 04 (CAMPOS   -  INDEPENDENTE	PCA ESPERANTO		C ELISIOS	RESENDE	RJ	27542-200	2026-03-04 15:19:01.820654+00	29285269/0001-43	
1	442160	2367785	999 -PENA E MENEGHITTI 2006 TRANSP	422738  -  DROGARIA MAIS BARATO TOP 23 LTDA  -  DROGARIAS MAIS BARATO	RUA UBALDINO RIBEIRO DOS SANTOS		VL RCH NOVO	NOVA IGUAÇU	RJ	26015-410	2026-03-04 14:57:51.302006+00	64342964/0001-09	
14	442224	2368285	LAG 1 -RJ INTERIOR 1	64610  -  JE DROG DE BUZIOS LTDA ME  -  MAXCENTER	EST.JOSE BENTO RIBEIRO DANTAS		CEM BRACAS	ARMAÇÃO DOS BÚZIOS	RJ	28950-972	2026-03-04 15:19:01.428945+00	08394861/0001-03	
22	442313	2368099	LAG 1 -RJ INTERIOR 1	412171  -  DROG SUPERAÇÃO LTDA - FIL 07  -  GRUPO ALEXANDRE	RUA ALPHEL MARCHON		PRIMAVERA	CASIMIRO DE ABREU	RJ	28860-000	2026-03-04 15:19:01.56457+00	47749937/0012-80	
25	442348	2368161	LAG 1 -RJ INTERIOR 1	412252  -  DROG SUPERAÇÃO LTDA - FIL 12  -  GRUPO ALEXANDRE	RUA FELICIANO SODRE		CENTRO	SÃO PEDRO DA ALDEIA	RJ	28941-154	2026-03-04 15:19:01.613872+00	47749937/0005-51	
35	442453	2368366	RIO 1 -RJ INTERIOR 1	311448  -  DROG CAMPOS ELISEOS LTDA FIL 01 (ALEGRIA  -  INDEPENDENTE	AVENIDA DAS MANGUEIRAS		C ALEGRIA	RESENDE	RJ	27525-250	2026-03-04 15:19:01.789425+00	29285269/0003-05	
44	442658	2368188	RIO 1 -RJ INTERIOR 1	412201  -  DROG SUPERAÇÃO LTDA - FIL 14  -  GRUPO ALEXANDRE	AVN 22 DE MAIO		VENDA DAS PEDRAS	ITABORAÍ	RJ	24804-703	2026-03-04 15:19:01.939946+00	47749937/0016-04	
45	442666	2368196	RIO 1 -RJ INTERIOR 1	412236  -  DROG SUPERAÇÃO LTDA - FIL 16  -  GRUPO ALEXANDRE	RUA MANOEL JOAO GONCALVES		VL STO ANTONIO	TANGUÁ	RJ	24890-000	2026-03-04 16:19:50.622446+00	47749937/0015-23	
47	442682	2368439	RIO 1 -RJ INTERIOR 1	369810  -  DROG CAMPOS ELISEOS LTDA FIL 05 (RETIRO)  -  INDEPENDENTE	AV SAVIO COTA DE ALMEIDA GAMA		RETIRO	VOLTA REDONDA	RJ	27281-421	2026-03-04 16:19:50.689582+00	29285269/0008-10	
48	442690	2368455	RIO 1 -RJ INTERIOR 1	358037  -  DROG CAMPOS ELISEOS LTDA FIL 06 (MANEJO)  -  INDEPENDENTE	AV TENENTE CEL ADALBERTO MENDES		MANEJO	RESENDE	RJ	27520-302	2026-03-04 16:19:50.695888+00	29285269/0002-24	
86	442739	2368498	RIO 1 -RJ INTERIOR 1	366919  -  DROG CAMPOS ELISEOS LTDA FIL 13 (ATERRAD  -  INDEPENDENTE	AVENIDA PAULO DE FRONTIN		ATERRADO	VOLTA REDONDA	RJ	27213-150	2026-03-04 16:19:51.016255+00	29285269/0009-09	
59	442810	2368250	RIO 2 -RJ INTERIOR 2	66966  -  E G CASTRO E BARCELOS COMERCIO DE MED E   -  INDEPENDENTE	AV VICTOR SENCE		CENTRO	CONCEIÇÃO DE MACABU	RJ	28740-000	2026-03-04 16:19:50.824211+00	02213202/0001-47	
72	443093	2369516	CAP RJ -CAPITAL	25526  -  DROG BERNARDINO LTDA  -  INDEPENDENTE	RUA FIGUEIREDO CAMARGO		PADRE MIGUEL	RIO DE JANEIRO	RJ	21875-120	2026-03-04 16:19:50.939065+00	02212563/0001-79	
74	443115	2369559	LAG 1 -RJ INTERIOR 1	401846  -  DROG CASTELAR LTDA  -  INDEPENDENTE	RUA DAS ACACIAS		PRAIA DO ANCORA	RIO DAS OSTRAS	RJ	28899-422	2026-03-04 16:19:50.95083+00	40433438/0001-88	
78	443280	2367688	GRD RIO -GRANDE RIO	394203  -  PVGF DROGARIA LTDA  -  MAIS BARATO	AVN EMÍLIO DE MENEZES		JD PRIMAVERA	DUQUE DE CAXIAS	RJ	25215-255	2026-03-04 16:19:50.971516+00	57045594/0003-36	
79	443298	2367696	GRD RIO -GRANDE RIO	394173  -  PVGF DROGARIA LTDA  -  INDEPENDENTE	ETV VELHA DO PILAR		FIGUEIRA	DUQUE DE CAXIAS	RJ	25230-610	2026-03-04 16:19:50.977563+00	57045594/0001-74	
80	443301	2367726	GRD RIO -GRANDE RIO	328693  -  DROG POVAO DE INOA LTDA ME  -  INDEPENDENTE	ESTRADA RAUL VEIGA		ALCANTARA	SÃO GONÇALO	RJ	24710-480	2026-03-04 16:19:50.983984+00	13071250/0001-64	
81	443310	2367734	CAP RJ -CAPITAL	338125  -  DROG PROGRESSO DO REGINAS  -  MAIS BARATO	R MAJOR CONRADO		CORDOVIL	RIO DE JANEIRO	RJ	21250-280	2026-03-04 16:19:50.98822+00	10287572/0001-57	
82	443328	2367777	GRD RIO -GRANDE RIO	399990  -  MALU FARMA LTDA  -  REDE SAUDE DA SERRA	RUA PASTOR SILVIO LOPES,		VILA SANTA CRUZ	DUQUE DE CAXIAS	RJ	25240-265	2026-03-04 16:19:50.993575+00	42290046/0001-32	
83	443336	2367831	CAP RJ -CAPITAL	356972  -  DROG CASA DA SAUDE LTDA EPP  -  CONCEITO	AV DAS AMERICAS		BARRA DA TIJUCA	RIO DE JANEIRO	RJ	22793-081	2026-03-04 16:19:50.999171+00	19711644/0001-16	
84	443344	2367955	CAP RJ -CAPITAL	417211  -  DROG OLIVEIRA JUNQUEIRA LTDA  -  DROG OLIVEIRA JUNQUEIRA	RUA OLIVEIRA JUNQUEIRA		M HERMES	RIO DE JANEIRO	RJ	21331-170	2026-03-04 16:19:51.005386+00	54638055/0001-50	
85	443352	2367963	CAP RJ -CAPITAL	417211  -  DROG OLIVEIRA JUNQUEIRA LTDA  -  DROG OLIVEIRA JUNQUEIRA	RUA OLIVEIRA JUNQUEIRA		M HERMES	RIO DE JANEIRO	RJ	21331-170	2026-03-04 16:19:51.011083+00	54638055/0001-50	
87	443360	2368030	GRD RIO -GRANDE RIO	319350  -  DROG CANTO DA SAUDE LTDA  -  INDEPENDENTE	AV VISCONDE DO RIO BRANCO		CENTRO	NITERÓI	RJ	24020-000	2026-03-04 16:51:44.929373+00	12216147/0001-00	
92	443492	2368820	CAP RJ -CAPITAL	360716  -  DROG LE GUSTA  EIRELI-EPP  -  INDEPENDENTE	RUA LUIZA NOGUEIRA GONÇALVES		RECREIO DOS BANDEIRANTES	RIO DE JANEIRO	RJ	22793-321	2026-03-05 19:38:08.903933+00	26507735/0001-08	
98	443450	2368676	CAP RJ -CAPITAL	395544  -  RRV COM DE PROD FARMACÊUTICOS LTDA  -  INDEPENDENTE	ETR DO ITARARE		RAMOS	RIO DE JANEIRO	RJ	21061-240	2026-03-05 20:48:29.715513+00	38177926/0001-20	
129	443590	2369141	CAP RJ -CAPITAL	405680  -  DROG DIAS LIMA JH LTDA  -  HIPERDROGAS	ETR DA MATRIZ		SEPETIBA	RIO DE JANEIRO	RJ	23545-323	2026-03-06 15:31:32.711815+00	12057989/0005-82	
135	443948	2370590	CAP RJ -CAPITAL	319490  -  DROG TURMALINA LTDA  -  INDEPENDENTE	RUA SALINOPOLIS		TAQUARA	RIO DE JANEIRO	RJ	22720-000	2026-03-06 20:41:00.584436+00	12225957/0001-15	
141	443913	2369737	999 -PENA E MENEGHITTI 2006 TRANSP	422045  -  DROGARIA NOVA CURICICA LTDA  -  DROGARIA CRISTAL	ESTRADA CORONEL PEDRO CORREIA		JACAREPAGUA	RIO DE JANEIRO	RJ	22775-090	2026-03-06 21:18:19.915789+00	60422523/0001-58	
204	444723	2370573	LAG 1 -RJ INTERIOR 1	369179  -  DROG DROGALY DE MACAE LTDA ME  -  UNICA FARMA	AVN RICARDO MUYLAERT SALGADO		IMBOASSICA	MACAÉ	RJ	27945-401	2026-03-11 13:44:24.511812+00	21414788/0001-52	
205	444731	2370654	RIO 2 -RJ INTERIOR 2	19550  -  DROG JATOBA LTDA  -  INDEPENDENTE	AV. RANDOLFO PENNA		PARAIBA DO SUL	PARAÍBA DO SUL	RJ	25850-000	2026-03-11 13:44:24.69079+00	02979041/0001-05	
206	444740	2370689	CAW 1 -RJ INTERIOR 1	419087  -  MACIEIRA E ROMANO LTDA  -  FORT FARMA	ETR VELHA DE RIO DOURADO		S SEBASTIAO DO PALMITAL	CASIMIRO DE ABREU	RJ	28860-000	2026-03-11 13:44:24.877515+00	52920067/0001-48	
207	444758	2370697	LAG 1 -RJ INTERIOR 1	403318  -  MACIEIRA E DIAS DROG LTDA  -  MACIEIRA E DIAS DROG LTDA	AVN NOSSA SENHORA DA CONCEICAO		VILLAGE RIO DAS OSTRAS	RIO DAS OSTRAS	RJ	28895-602	2026-03-11 13:44:25.063627+00	37236226/0002-87	
208	444774	2370719	LAG 1 -RJ INTERIOR 1	370606  -  MOREIRA E MACIEIRA DROGARIA LTDA  -  DROG VITORIA	RUA SANTA CATARINA		CIDADE PRAIANA	RIO DAS OSTRAS	RJ	28890-084	2026-03-11 13:44:25.246622+00	26746039/0001-46	
225	445258	2371588	LAG 1 -RJ INTERIOR 1	415464  -  DROG TEIXEIRA E NOGUEIRA LTDA  -  INDEPENDENTE	RUA GOIAS		CIDADE BEIRA MAR	RIO DAS OSTRAS	RJ	28890-209	2026-03-11 20:01:36.671917+00	52045100/0001-38	
226	444936	2370964	LAG 1 -RJ INTERIOR 1	314331  -  VANUSA DA SILVA GRIGÓRIO DO NASCIMENTO E  -  UNICA FARMA	AVENIDA NOSSA SENHORA DA GLORIA		CAVALEIROS	MACAÉ	RJ	27920-360	2026-03-11 20:01:36.867543+00	10938861/0001-79	
228	444952	2370980	LAG 1 -RJ INTERIOR 1	316300  -  SOL E MAR FARMÁCIA E PERFUMARIA LTDA  -  UNICA FARMA	AVENIDA DR HUMBERTO DE QUEIROZ MATTOSO		SOL Y MAR	MACAÉ	RJ	27940-700	2026-03-11 20:01:37.238048+00	09491182/0001-15	
251	445185	2371340	GRD RIO -GRANDE RIO	66826  -  DROG VIVA DE SARACURUNA LTDA  -  INDEPENDENTE	AV PRES ROOSEVELT,Q 1C-LT 3 E5 LJ 4		SARACURUNA	DUQUE DE CAXIAS	RJ	25212-390	2026-03-11 20:01:41.652357+00	08829765/0001-40	
252	445193	2371286	999 -PENA E MENEGHITTI 2006 TRANSP	421634  -  DROGARIA DONA MARIANA LTDA  -  DROGARIAS CRISTAL	RUA VOLUNTARIOS DA PATRIA		BOTAFOGO	RIO DE JANEIRO	RJ	22270-001	2026-03-11 20:01:41.850403+00	60660518/0001-83	
253	445207	2371359	999 -PENA E MENEGHITTI 2006 TRANSP	421251  -  F. DROGARIA MAIS VIDA LTDA  -  F. DROGARIA MAIS VIDA LTDA	R MURILO PEIXOTO		PQ SAO SILVESTERE	CAMPOS DOS GOYTACAZES	RJ	28090-200	2026-03-11 20:01:42.147088+00	58048371/0001-23	
254	445215	2371545	CAP RJ -CAPITAL	20346  -  DROG PAJEU LTDA  -  MUNDIAL	RUA DELFIM CARLOS		OLARIA	RIO DE JANEIRO	RJ	21073-050	2026-03-11 20:01:42.356481+00	27203751/0001-61	
255	445223	2370670	RIO 1 -RJ INTERIOR 1	349470  -  ALDAMED DISTR DE MAT HOSP MED  -  INDEPENDENTE	R DR SIQUEIRA		CENTRO	MAGÉ	RJ	25900-000	2026-03-11 20:01:42.544021+00	15837533/0001-08	
256	445231	2371561	999 -PENA E MENEGHITTI 2006 TRANSP	421120  -  DROGARIAS SINAI LTDA  -  DROGARIAS SINAI LTDA	AVENIDA DELFIM MOREIRA		VARZEA	TERESÓPOLIS	RJ	25953-237	2026-03-11 20:01:42.796515+00	60025677/0001-06	
257	445240	2371570	GRD RIO -GRANDE RIO	318990  -  JULA DROG LTDA  -  INDEPENDENTE	AVENIDA COMENDADOR TELES		V TELES	SÃO JOÃO DE MERITI	RJ	25575-815	2026-03-11 20:01:42.997994+00	11953309/0001-12	
258	445266	2371618	LAG 1 -RJ INTERIOR 1	369179  -  DROG DROGALY DE MACAE LTDA ME  -  UNICA FARMA	AVN RICARDO MUYLAERT SALGADO		IMBOASSICA	MACAÉ	RJ	27945-401	2026-03-11 20:01:43.226557+00	21414788/0001-52	
259	445274	2371626	LAG 1 -RJ INTERIOR 1	369780  -  CLM X RIBEIRO DROGARIA LTDA ME  -  MAIS SAUDE	RUA SANTA CATARINA		CIDADE BEIRA MAR	RIO DAS OSTRAS	RJ	28890-239	2026-03-11 20:01:43.417245+00	26764511/0001-73	
260	445282	2371634	RIO 2 -RJ INTERIOR 2	66966  -  E G CASTRO E BARCELOS COMERCIO DE MED E   -  INDEPENDENTE	AV VICTOR SENCE		CENTRO	CONCEIÇÃO DE MACABU	RJ	28740-000	2026-03-11 20:01:43.666619+00	02213202/0001-47	
261	445290	2371650	GRD RIO -GRANDE RIO	316903  -  DROG RAINHA DA TROPICAL LTDA  -  INDEPENDENTE	RUA FREDERICO DE CASTRO PEREIRA		JD TROPICAL	NOVA IGUAÇU	RJ	26015-061	2026-03-12 15:13:28.651531+00	74099219/0001-26	
262	445304	2371669	GRD RIO -GRANDE RIO	330841  -  R P FERNANDES DROGARIA ME  -  INDEPENDENTE	AV NOVA AURORA		N AURORA	BELFORD ROXO	RJ	26155-070	2026-03-12 19:05:05.354467+00	14208459/0001-90	
263	445312	2371685	GRD RIO -GRANDE RIO	56162  -  E G B BIA FARM LTDA  -  INDEPENDENTE	RUA CLARA DE ARAUJO		ENGENHO PEQUENO	NOVA IGUAÇU	RJ	26010-390	2026-03-12 19:05:05.627096+00	03133179/0001-43	
264	445320	2371693	GRD RIO -GRANDE RIO	34444  -  FARM PRINCIPAL DE NILOPOLIS  -  CITYFARMA	RUA PROF. ALFREDO GONCALVES FIGUEIRA		CENTRO	NILÓPOLIS	RJ	26525-060	2026-03-12 19:05:05.800212+00	28043438/0001-76	
265	445339	2371715	RIO 1 -RJ INTERIOR 1	362476  -  JPS FARMA LIMITADA - ME  -  RETIRO	RUA MANOEL GUARANI		RETIRO	VOLTA REDONDA	RJ	27213-200	2026-03-12 19:05:06.072098+00	07381852/0005-49	
266	445347	2371723	GRD RIO -GRANDE RIO	417076  -  DROG DELGADO LTDA  -  DROG DELGADO LTDA	RUA DELGADO DE CARVALHO		VL S ANTONIO	DUQUE DE CAXIAS	RJ	25040-240	2026-03-12 19:05:06.278531+00	54398783/0001-32	
267	445355	2371731	CAP RJ -CAPITAL	409235  -  DROG DRIANA LTDA  -  MAIS BARATO	ETR ENGENHEIRO EDGARD SOUTELLO		ACARI	RIO DE JANEIRO	RJ	21531-060	2026-03-12 19:05:06.474656+00	47389639/0001-74	
268	445363	2371740	GRD RIO -GRANDE RIO	56898  -  FARM MAIS SAUDE VICENTE C LTDA  -  MAIS BARATO	R PACOTI		JD ANHANGA	DUQUE DE CAXIAS	RJ	25264-015	2026-03-12 19:05:06.6895+00	06935453/0001-96	
269	445371	2371774	GRD RIO -GRANDE RIO	330698  -  DROG REAL DE S FRANCISCO ME  -  INDEPENDENTE	RUA BEBERIBE		JD XAVANTES	BELFORD ROXO	RJ	26160-110	2026-03-12 19:05:06.909852+00	14496218/0001-93	
270	445380	2371804	CAP RJ -CAPITAL	402028  -  MIRABEL FARM E PERF LTDA  -  INDEPENDENTE	RUA ATALAIA DO NORTE		GUARATIBA	RIO DE JANEIRO	RJ	23031-030	2026-03-12 19:05:07.106213+00	30314073/0001-19	
271	445398	2371812	CAP RJ -CAPITAL	22080  -  DROG MONTERVAL LTDA  -  INDEPENDENTE	RUA BARAO DE MESQUITA		TIJUCA	RIO DE JANEIRO	RJ	20540-002	2026-03-12 19:05:07.283789+00	04944247/0001-17	
272	445401	2371820	CAP RJ -CAPITAL	320536  -  FARM SCHMITT LTDA  -  INDEPENDENTE	ESTRADA DA AGUA BRANCA		BANGU	RIO DE JANEIRO	RJ	21862-372	2026-03-12 19:05:07.499277+00	11394994/0001-94	
273	445410	2371839	CAP RJ -CAPITAL	22675  -  FARM CELLIS LTDA  -  MAIS BARATO	EST. DO QUITUNGO		BRAS DE PINA	RIO DE JANEIRO	RJ	21215-564	2026-03-12 19:05:07.679862+00	68787654/0001-40	
274	445428	2371847	GRD RIO -GRANDE RIO	419257  -  SUBLIME FARMA LTDA  -  REDE SAUDE DA SERRA	RUA CANAVIAL		PARQUE ANTARTICA	NOVA IGUAÇU	RJ	26053-040	2026-03-12 19:05:07.864925+00	57181439/0001-85	
275	445436	2371855	CAP RJ -CAPITAL	414263  -  MARCO AURELIO ALMEIDA BAHIA COMERCIO E S  -  INDEPENDENTE	RUA ARCELINA MOCHEL		BANGU	RIO DE JANEIRO	RJ	21853-064	2026-03-12 19:05:08.03887+00	50375611/0001-92	
276	445444	2371863	CAP RJ -CAPITAL	410985  -  DROGARIA NOVA DA JUANIZA LTDA  -  INDEPENDENTE	RUA ARAPONGA		GALEAO	RIO DE JANEIRO	RJ	21941-640	2026-03-12 19:05:08.232879+00	48753506/0001-06	
277	445452	2371871	GRD RIO -GRANDE RIO	14320  -  FARM LOPES E FERREIRA LTDA  -  INDEPENDENTE	RUA TAVARES DE MACEDO		ICARAI	NITERÓI	RJ	24220-211	2026-03-12 19:05:08.416592+00	03229752/0001-17	
278	445460	2371880	GRD RIO -GRANDE RIO	403091  -  EXATA DROG E PERF LTDA  -  INDEPENDENTE	RUA BELISARIO PENA		VL S LUIS	NOVA IGUAÇU	RJ	26012-355	2026-03-12 19:05:08.606535+00	27375507/0001-86	
279	445479	2371898	999 -PENA E MENEGHITTI 2006 TRANSP	422797  -  A E R PHARMA LTDA  -  ATITUDE FARMA	AVENIDA DELFIM MOREIRA		VARZEA	TERESÓPOLIS	RJ	25953-237	2026-03-12 19:05:08.836689+00	65011572/0001-11	
280	445487	2371901	CAW 1 -RJ INTERIOR 1	27308  -  DROG SAIONARA LTDA  -  INDEPENDENTE	RUA RICARDO COLARES QUITETE		BARCELOS	CAMPOS DOS GOYTACAZES	RJ	28000-000	2026-03-12 19:05:09.027339+00	27683135/0001-55	
281	445495	2371910	RIO 2 -RJ INTERIOR 2	34266  -  DROG PERF BERDAN MP LTDA  -  INDEPENDENTE	LGO DO MACHADINHO		CENTRO	MIGUEL PEREIRA	RJ	26900-000	2026-03-12 19:05:09.206899+00	06926467/0001-43	
282	445509	2371928	RIO 1 -RJ INTERIOR 1	7170  -  DROG EMAUS LTDA  -  INDEPENDENTE	AV. CRISTIANO DOS REIS MEIRELES FILHO		VISTA ALEGRE	BARRA MANSA	RJ	27320-001	2026-03-12 19:05:09.397426+00	02070840/0001-56	
283	445517	2371952	RIO 2 -RJ INTERIOR 2	400718  -  DROG E PERF BERDAN MP 2 LTDA  -  INDEPENDENTE	RUA DONA MARIA JOSE		CENTRO	MIGUEL PEREIRA	RJ	26900-000	2026-03-12 19:05:09.630836+00	42656909/0001-42	
284	445525	2371987	999 -PENA E MENEGHITTI 2006 TRANSP	422622  -  FARM PRINCESA DE COPACABANA LTDA  -  DROGARIA PRINCESA TIJUCA	RUA CAMPOS SALES		TIJUCA	RIO DE JANEIRO	RJ	20270-213	2026-03-12 19:05:09.864682+00	58374238/0002-48	
285	445533	2371995	LAG 1 -RJ INTERIOR 1	394238  -  CASA HOSPITALAR COM DE ART MED EIRELI  -  INDEPENDENTE	ALM CASIMIRO DE ABREU		NOVA ESPERANÇA	RIO DAS OSTRAS	RJ	28893-591	2026-03-12 19:05:10.048724+00	39286320/0001-95	
287	445550	2372010	GRD RIO -GRANDE RIO	407313  -  DROG IMPERIO FARMA LTDA  -  REDE SAUDE DA SERRA	AVN AUTOMÓVEL CLUBE		REDENTOR	BELFORD ROXO	RJ	26110-252	2026-03-13 13:24:23.157988+00	47396984/0001-35	
288	445568	2372029	GRD RIO -GRANDE RIO	419257  -  SUBLIME FARMA LTDA  -  REDE SAUDE DA SERRA	RUA CANAVIAL		PARQUE ANTARTICA	NOVA IGUAÇU	RJ	26053-040	2026-03-13 13:24:23.340025+00	57181439/0001-85	
289	445576	2372037	RIO 2 -RJ INTERIOR 2	34266  -  DROG PERF BERDAN MP LTDA  -  INDEPENDENTE	LGO DO MACHADINHO		CENTRO	MIGUEL PEREIRA	RJ	26900-000	2026-03-13 13:24:23.514394+00	06926467/0001-43	
290	445584	2372045	CAP RJ -CAPITAL	307980  -  DIABETIQUES C P MED DIAB LTDA  -  INDEPENDENTE	AV NELSON CARDOSO		TAQUARA	RIO DE JANEIRO	RJ	22730-001	2026-03-13 13:24:23.687103+00	08928303/0001-80	
291	445592	2372053	CAP RJ -CAPITAL	364193  -  FGT COM DE MAT HOSP LTDA - EPP  -  INDEPENDENTE	R NICARAGUA		PENHA	RIO DE JANEIRO	RJ	21020-050	2026-03-13 13:24:23.866664+00	97406060/0001-40	
292	445606	2372061	RIO 1 -RJ INTERIOR 1	1686  -  DROGA CENTER TERESOPOLIS LTDA  -  MAXCENTER	AVN FELICIANO SODRE		VARZEA	TERESÓPOLIS	RJ	25963-025	2026-03-13 13:24:24.054393+00	36463347/0001-18	
293	445614	2372100	CAP RJ -CAPITAL	415383  -  DROG LIDER DO GROTAO LTDA  -  INDEPENDENTE	RUA JURUMIRIM		PENHA	RIO DE JANEIRO	RJ	21070-820	2026-03-13 13:24:24.234551+00	51905385/0001-77	
294	445622	2372118	CAP RJ -CAPITAL	411884  -  DROG RENASCER DE OLARIA LTDA  -  INDEPENDENTE	RUA DOUTOR ALFREDO BARCELOS		RAMOS	RIO DE JANEIRO	RJ	21060-691	2026-03-13 13:24:24.447368+00	46129727/0001-74	
295	445630	2372126	GRD RIO -GRANDE RIO	356395  -  CF CARE MAT HOSPITALAR LTDA  -  INDEPENDENTE	RUA DOUTOR GETULIO VARGAS		BVERMELHO	SÃO GONÇALO	RJ	24416-000	2026-03-13 13:24:24.630999+00	11984323/0001-83	
296	445649	2372134	CAP RJ -CAPITAL	395544  -  RRV COM DE PROD FARMACÊUTICOS LTDA  -  INDEPENDENTE	ETR DO ITARARE		RAMOS	RIO DE JANEIRO	RJ	21061-240	2026-03-13 13:24:24.810051+00	38177926/0001-20	
297	445657	2372142	CAP RJ -CAPITAL	395544  -  RRV COM DE PROD FARMACÊUTICOS LTDA  -  INDEPENDENTE	ETR DO ITARARE		RAMOS	RIO DE JANEIRO	RJ	21061-240	2026-03-13 13:24:25.00259+00	38177926/0001-20	
298	445665	2372169	RIO 1 -RJ INTERIOR 1	396923  -  RF MAIA LTDA  -  INDEPENDENTE	RUA SANTA LUZIA		VISTA ALEGRE	BARRA MANSA	RJ	27230-380	2026-03-13 13:24:25.180914+00	32851150/0001-03	
299	445673	2372177	CAW 1 -RJ INTERIOR 1	10243  -  JA DE ITAPERUNA LTDA  -  BOA SAUDE	RUA ANTONIO FRANCISCO ROSA		ROBERTO SILVEIRA	ITAPERUNA	RJ	28300-000	2026-03-13 13:24:25.3721+00	03121344/0001-47	
301	445690	2372193	RIO 1 -RJ INTERIOR 1	352675  -  DROGATUR MED E PERF -FIL04  -  INDEPENDENTE	R DO COMERCIO		CENTRO	ANGRA DOS REIS	RJ	23900-563	2026-03-13 13:24:25.719069+00	04683341/0011-31	
302	445703	2372215	RIO 1 -RJ INTERIOR 1	352624  -  DROGATUR MED E PERF -FIL09  -  INDEPENDENTE	AV CARLOS SOUZA GOMES BORGES		FRADE	ANGRA DOS REIS	RJ	23946-150	2026-03-13 13:24:25.892864+00	04683341/0005-93	
303	445711	2372223	RIO 1 -RJ INTERIOR 1	356514  -  DROGATUR MED E PERF -FIL11  -  INDEPENDENTE	R LUIZ ELIAS MIGUEL		PARQUE DAS PALMEIRAS	ANGRA DOS REIS	RJ	23905-400	2026-03-13 13:24:26.162937+00	04683341/0012-12	
304	445720	2372231	RIO 1 -RJ INTERIOR 1	363600  -  DROGATUR MED E PERF LTDA FIL 13  -  INDEPENDENTE	R CORONEL MOREIRA DA SILVA		CENTRO	MANGARATIBA	RJ	23860-000	2026-03-13 13:24:26.332224+00	04683341/0014-84	
305	445738	2372240	RIO 1 -RJ INTERIOR 1	352659  -  DROGATUR MED E PERF -FIL17  -  INDEPENDENTE	EST SAO JOAO MARCOS		EL RANCHITO	MANGARATIBA	RJ	23860-000	2026-03-13 13:24:26.50189+00	04683341/0008-36	
306	445746	2372258	RIO 1 -RJ INTERIOR 1	396370  -  DROGATUR MED E PERF LTDA EPP FIL 21  -  INDEPENDENTE	ROD PROCURADOR HAROLDO FERNANDES DUARTE		NOVA ANGRA	ANGRA DOS REIS	RJ	23933-000	2026-03-13 13:24:26.671629+00	04683341/0019-99	
307	445754	2372266	RIO 1 -RJ INTERIOR 1	403954  -  DROGATUR MED E PERF LTDA FIL 22  -  INDEPENDENTE	AVN BRAULIO DE S. MATTOS		CONCEIÇÃO DE JACARI	MANGARATIBA	RJ	23885-000	2026-03-13 13:24:26.841445+00	04683341/0020-22	
308	445762	2372274	RIO 1 -RJ INTERIOR 1	413275  -  DROGATUR MED E PERF LTDA FIL 25  -  INDEPENDENTE	AVN JULIO MARIA		CENTRO	ANGRA DOS REIS	RJ	23900-504	2026-03-13 13:24:27.029237+00	04683341/0022-94	
309	445770	2372282	RIO 1 -RJ INTERIOR 1	417220  -  DROGATUR MED E PERF LTDA FL 26  -  DROGATUR MED E PERF LTDA	RUA DO COMERCIO		CENTRO	ANGRA DOS REIS	RJ	23900-565	2026-03-13 13:24:27.202256+00	04683341/0023-75	
310	445789	2372290	RIO 1 -RJ INTERIOR 1	416312  -  DROGATUR MEDICAMENTOS E PERF LTDA FIL 27  -  DROGATUR MEDICAMENTOS E PERF L	RUA JAPORANGA		JAPUIBA	ANGRA DOS REIS	RJ	23934-055	2026-03-13 13:24:27.37197+00	04683341/0024-56	
311	445797	2372304	CAP RJ -CAPITAL	321788  -  DROGARIA DIAS LIMA JH LTDA -07  -  HIPERDROGAS	ESTRADA DA PEDRA		GUARATIBA	RIO DE JANEIRO	RJ	23030-380	2026-03-13 13:24:27.603198+00	12057989/0001-59	
312	445800	2372312	999 -PENA E MENEGHITTI 2006 TRANSP	422312  -  DROGARIA DO POSTO I COM VAR LTDA  -  MAXCENTER	ESTRADA DOS BANDEIRANTES		CURICICA	RIO DE JANEIRO	RJ	22780-080	2026-03-13 13:24:27.815934+00	62059098/0001-00	
313	445819	2372320	RIO 1 -RJ INTERIOR 1	311588  -  DROG YOKOHAMA LTDA  -  INDEPENDENTE	AVENIDA ALBERTO BRAUNE		CENTRO	NOVA FRIBURGO	RJ	28613-000	2026-03-13 13:24:28.023707+00	10540913/0001-54	
314	445827	2372339	CAP RJ -CAPITAL	2810  -  DROG JARDIM DO POVO LTDA  -  INDEPENDENTE	EST. DO GALEAO		GUARABU	RIO DE JANEIRO	RJ	21921-760	2026-03-13 13:24:28.200071+00	00649884/0001-00	
315	445835	2372347	CAP RJ -CAPITAL	333158  -  FARM LAMARE GONCALVES ABREU LT  -  INDEPENDENTE	RUA FRANCISCO MANUEL		BENFICA	RIO DE JANEIRO	RJ	20911-270	2026-03-13 13:24:28.384476+00	15072048/0001-82	
316	445843	2372355	999 -PENA E MENEGHITTI 2006 TRANSP	420301  -  FREIRE MACIEL DROGARIA LTDA  -  FREIRE MACIEL DROGARIA LTDA	AVENIDA INDEPENDENCIA		AQUARIOS	CABO FRIO	RJ	28925-842	2026-03-13 13:24:28.612285+00	45881124/0002-42	
317	445851	2372363	GRD RIO -GRANDE RIO	27359  -  DROG DROGA FORTE DE D.CAXIAS  -  INDEPENDENTE	AV. NILO PECANHA		CENTRO	DUQUE DE CAXIAS	RJ	25010-141	2026-03-13 13:24:28.785447+00	05033137/0001-66	
318	445860	2372371	RIO 2 -RJ INTERIOR 2	312193  -  TF  DROG PERF LTDA ME  -  INDEPENDENTE	PRAÇA DR. JOSÉ BONIFÁCIO TASSARA		CONCEICAO DE MACABU	CONCEIÇÃO DE MACABU	RJ	28740-000	2026-03-13 13:24:28.961466+00	10626061/0001-12	
319	445878	2372380	CAP RJ -CAPITAL	330019  -  ART MED ART MED LTDA  -  INDEPENDENTE	RUA CAROLINA MACHADO		O CRUZ	RIO DE JANEIRO	RJ	21550-000	2026-03-13 13:24:29.162916+00	32067589/0001-31	
286	445541	2372002	GRD RIO -GRANDE RIO	394203  -  PVGF DROGARIA LTDA  -  MAIS BARATO	AVN EMÍLIO DE MENEZES		JD PRIMAVERA	DUQUE DE CAXIAS	RJ	25215-255	2026-03-13 13:24:22.955305+00	57045594/0003-36	
300	445681	2372185	999 -PENA E MENEGHITTI 2006 TRANSP	422355  -  DROGARIA PRAIA DA BARRA LTDA.  -  DROGARIA PRAIA DA BARRA LTDA.	AVENIDA LUCIO COSTA		BARRA DA TIJUCA	RIO DE JANEIRO	RJ	22795-006	2026-03-13 13:24:25.548321+00	42921186/0001-61	
320	445886	2372398	CAP RJ -CAPITAL	7382  -  FARM DO LEME LTDA  -  INDEPENDENTE	AV. PRADO JUNIOR		COPACABANA	RIO DE JANEIRO	RJ	22011-040	2026-03-13 13:24:29.340215+00	33156639/0001-10	
321	445894	2372401	CAP RJ -CAPITAL	370754  -  DROG TAUA LTDA  -  INDEPENDENTE	AVN PARANAPUAM		TAUA	RIO DE JANEIRO	RJ	21910-254	2026-03-13 13:24:29.525766+00	34567662/0001-60	
322	445908	2372410	CAP RJ -CAPITAL	414263  -  MARCO AURELIO ALMEIDA BAHIA COMERCIO E S  -  INDEPENDENTE	RUA ARCELINA MOCHEL		BANGU	RIO DE JANEIRO	RJ	21853-064	2026-03-13 13:24:29.705801+00	50375611/0001-92	
323	445916	2372428	CAP RJ -CAPITAL	414689  -  DROG CARIOCA AMÉRICA DA BARRA LTDA  -  INDEPENDENTE	AVN DAS AMERICAS		BARRA DA TIJUCA	RIO DE JANEIRO	RJ	22640-901	2026-03-13 13:24:29.878093+00	48639941/0001-04	
324	445924	2372444	CAP RJ -CAPITAL	411850  -  DROG BETEL DO RIACHUELO LTDA  -  INDEPENDENTE	RUA RIACHUELO		CENTRO	RIO DE JANEIRO	RJ	20230-011	2026-03-13 13:24:30.062336+00	47096809/0001-22	
325	445932	2372452	CAP RJ -CAPITAL	414697  -  DROG CARIOCA GLOBAL DA BARRA LTDA  -  INDEPENDENTE	AVN LUCIO COSTA		BARRA DA TIJUCA	RIO DE JANEIRO	RJ	22620-172	2026-03-13 13:24:30.28832+00	48623143/0001-86	
326	445940	2372460	CAP RJ -CAPITAL	414700  -  DROG CARIOCA JARDIM OCEÂNICO DA BARRA LT  -  INDEPENDENTE	AVN FERNANDO MATTOS		BARRA DA TIJUCA	RIO DE JANEIRO	RJ	22621-090	2026-03-13 13:24:30.460048+00	48580275/0001-78	
327	445959	2372479	999 -PENA E MENEGHITTI 2006 TRANSP	421936  -  DROGARIA CARIOCA KM 32 LTDA  -  DROGARIA CARIOCA	ALAMEDA SAO BERNARDO - KM 32		SAO FRANCISCO	NOVA IGUAÇU	RJ	26298-602	2026-03-13 13:24:30.633423+00	60947654/0001-59	
328	445967	2372487	GRD RIO -GRANDE RIO	22527  -  FARM MILLENIUM NILOPOLIS LTDA  -  INDEPENDENTE	AV. MIRANDELA		CENTRO	NILÓPOLIS	RJ	26520-330	2026-03-13 13:24:30.811643+00	04814086/0001-47	
329	445975	2372495	CAP RJ -CAPITAL	414662  -  DROG PRINCESA DA BARRA LTDA  -  INDEPENDENTE	RUA DEPUTADO JOSE DA ROCHA RIBAS		BARRA DA TIJUCA	RIO DE JANEIRO	RJ	22630-000	2026-03-13 13:24:31.000845+00	48594898/0001-08	
330	445983	2372509	CAP RJ -CAPITAL	327336  -  DROG COPA 2014 DE CPO GDE LTDA  -  INDEPENDENTE	ESTRADA DO MENDANHA		CAMPO GRANDE	RIO DE JANEIRO	RJ	23097-003	2026-03-13 13:24:31.177408+00	97528576/0001-68	
331	445991	2372517	CAP RJ -CAPITAL	418331  -  DROG CARIOCA PRINCIPAL LTDA  -  MAIS BARATO A	ETR CABUCU		CAMPO GRANDE	RIO DE JANEIRO	RJ	23017-250	2026-03-13 13:24:31.351115+00	55144393/0001-07	
332	446009	2372525	GRD RIO -GRANDE RIO	8125  -  DROG BEIJA FLOR DE NILOPOLIS  -  CITYFARMA	AV. MIRANDELA		CENTRO	NILÓPOLIS	RJ	26520-330	2026-03-13 13:24:31.526505+00	30609705/0001-71	
333	446017	2372533	999 -PENA E MENEGHITTI 2006 TRANSP	422550  -  DROGARIA CARIOCA PRINCIPAL DO RECREIO LT  -  DROGARIAS CARIOCA	AVENIDA DAS AMERICAS		BARRA DA TIJUCA	RIO DE JANEIRO	RJ	22793-082	2026-03-13 13:24:31.69734+00	63489738/0001-84	
334	446025	2372541	CAP RJ -CAPITAL	417378  -  DROG CARIOCA CRYSTAL DO TANQUE LTDA  -  DROG CARIOCA	RUA CANDIDO BENICIO		TANQUE	RIO DE JANEIRO	RJ	22733-003	2026-03-13 13:24:31.869774+00	54880375/0001-12	
335	446033	2372550	CAP RJ -CAPITAL	411493  -  NOVA FARMA DROG LIMITADA (DEPOSITO RIO F  -  RIOFARMA	RUA SANTO CRISTO		S CRISTO	RIO DE JANEIRO	RJ	20220-303	2026-03-13 13:24:32.060865+00	37895053/0027-67	
336	446041	2372568	CAP RJ -CAPITAL	414670  -  DROG CARIOCA MEGA POPULAR LTDA  -  INDEPENDENTE	RUA SOUZA BARROS		E NOVO	RIO DE JANEIRO	RJ	20961-150	2026-03-13 13:24:32.230008+00	48595549/0001-00	
337	446050	2372592	LAG 1 -RJ INTERIOR 1	311014  -  THIAGO F MACABU DROG LTDA  -  INDEPENDENTE	RUA PREFEITO ALPHEU MARCHON		CASIMIRO DE ABREU	CASIMIRO DE ABREU	RJ	28860-000	2026-03-13 13:24:32.402689+00	09403382/0001-79	
338	446068	2372606	999 -PENA E MENEGHITTI 2006 TRANSP	422509  -  DROGARIA LUZ DO GALEAO LTDA  -  DROGARIA LUZ DO GALEAO LTDA	ESTRADA DAS CANARIAS		GALEAO	RIO DE JANEIRO	RJ	21941-550	2026-03-16 19:32:45.983703+00	63951930/0001-40	
339	446076	2372614	CAP RJ -CAPITAL	347914  -  DROG UNIAO J E E LTDA EPP  -  INDEPENDENTE	R MACHADO DE ASSIS		FLAMENGO	RIO DE JANEIRO	RJ	22220-060	2026-03-16 19:32:46.182492+00	19171874/0001-30	
340	446092	2372649	999 -PENA E MENEGHITTI 2006 TRANSP	421685  -  DROGANEWS LAGUNA SHOPPING LTDA  -  DROGANEWS	AVENIDA ENGENHO DA PRAIA		ENGENHO DA PRAIA	MACAÉ	RJ	27966-088	2026-03-16 19:32:46.35946+00	59130652/0001-93	
341	446106	2372657	RIO 2 -RJ INTERIOR 2	308862  -  DROGACENTER MACABU LTDA  -  INDEPENDENTE	RUA EVARISTO DA SILVA RIBEIRO		CENTRO	CONCEIÇÃO DE MACABU	RJ	28740-000	2026-03-16 19:32:46.534822+00	09195396/0001-44	
342	446122	2372673	999 -PENA E MENEGHITTI 2006 TRANSP	422304  -  HIPER DROGARIA III LTDA  -  MAX CENTER	AVENIDA AFONSO TAUNAY		BARRA DA TIJUCA	RIO DE JANEIRO	RJ	22621-310	2026-03-16 19:32:46.7128+00	62548054/0001-43	
343	446130	2372681	CAP RJ -CAPITAL	6050  -  FARM CENTRAL DA TUNISIA LTDA  -  NOVA REDE	RUA TUNISIA		VILA KENEDY	RIO DE JANEIRO	RJ	21853-430	2026-03-16 19:32:46.905216+00	01009399/0001-34	
344	446149	2372690	CAP RJ -CAPITAL	6050  -  FARM CENTRAL DA TUNISIA LTDA  -  NOVA REDE	RUA TUNISIA		VILA KENEDY	RIO DE JANEIRO	RJ	21853-430	2026-03-16 19:32:47.093934+00	01009399/0001-34	
345	446157	2372703	CAP RJ -CAPITAL	11657  -  DROGAPEREZ DROG LTDA  -  NOVA REDE	EST. CORONEL VIEIRA		IRAJA	RIO DE JANEIRO	RJ	21220-310	2026-03-16 19:32:47.277956+00	29494341/0001-42	
346	446165	2372711	CAP RJ -CAPITAL	358690  -  FARM W OLIVEIRA LTDA EPP  -  NOVA REDE	R OSCAR FERREIRA		BANGU	RIO DE JANEIRO	RJ	21853-370	2026-03-16 19:32:47.454026+00	22407830/0001-70	
347	446173	2372720	RIO 1 -RJ INTERIOR 1	62740  -  L C FARM FIL 4.13 LTDA EPP  -  NOVA REDE	RUA DOMINIQUE LEVEL		CENTRO	PARACAMBI	RJ	26600-000	2026-03-16 19:32:47.637361+00	07899881/0001-73	
348	446181	2372738	CAP RJ -CAPITAL	418064  -  DROG COPA LEMOS LTDA  -  DROG COPA LEMOS LTDA	AVN NOSSA SENHORA DE COPACABANA		COPACABANA	RIO DE JANEIRO	RJ	22060-002	2026-03-16 19:32:47.816125+00	55838408/0001-29	
349	446190	2372746	CAP RJ -CAPITAL	414611  -  DROG COPA URICH LTDA  -  INDEPENDENTE	AVN NOSSA SENHORA DE COPACABANA		COPACABANA	RIO DE JANEIRO	RJ	22060-001	2026-03-16 19:32:48.00833+00	50281917/0001-80	
350	446203	2372754	CAP RJ -CAPITAL	5444  -  DROG AICHI LTDA  -  INDEPENDENTE	RUA PACHECO LEAO		JD BOTANICO	RIO DE JANEIRO	RJ	22460-030	2026-03-16 19:32:48.187386+00	02418313/0001-90	
351	446211	2372762	CAP RJ -CAPITAL	403369  -  DROG MALIBU LTDA  -  INDEPENDENTE	RUA BARATA RIBEIRO		COPACABANA	RIO DE JANEIRO	RJ	22040-002	2026-03-16 19:32:48.365652+00	41646561/0001-40	
352	446220	2372789	LAG 1 -RJ INTERIOR 1	314331  -  VANUSA DA SILVA GRIGÓRIO DO NASCIMENTO E  -  UNICA FARMA	AVENIDA NOSSA SENHORA DA GLORIA		CAVALEIROS	MACAÉ	RJ	27920-360	2026-03-16 19:32:48.588744+00	10938861/0001-79	
353	446238	2372800	CAP RJ -CAPITAL	11592  -  DROG PROVIDENCIA LTDA  -  INDEPENDENTE	RUA ARTHUR ARARIPE		GAVEA	RIO DE JANEIRO	RJ	22451-020	2026-03-16 19:32:48.762858+00	33081159/0001-37	
354	446246	2372819	CAP RJ -CAPITAL	365092  -  DROG POSITIVA DO METRO CENTRAL EIRELI  -  INDEPENDENTE	AV PRESIDENTE VARGAS		CENTRO	RIO DE JANEIRO	RJ	20091-060	2026-03-16 19:32:48.958467+00	22022451/0001-62	
355	446254	2372827	GRD RIO -GRANDE RIO	18830  -  DROG ESTRELAS DE ICARAI LTDA  -  INDEPENDENTE	RUA OTAVIO CARNEIRO		ICARAI	NITERÓI	RJ	24230-191	2026-03-16 19:32:49.131102+00	04385330/0001-01	
\.


--
-- Data for Name: volume_itens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.volume_itens (id, quantidade, item_id, volume_id) FROM stdin;
696	6.000	2147	2426
697	4.000	2148	2426
698	2.000	2149	2426
699	1.000	2150	2426
700	12.000	2151	2426
701	12.000	2152	2426
702	4.000	2153	2426
703	1.000	2154	2426
704	1.000	1815	2427
705	1.000	1816	2427
706	2.000	1817	2427
707	2.000	1818	2427
708	2.000	1819	2427
709	2.000	1820	2427
710	1.000	1821	2427
711	1.000	1822	2427
712	2.000	1823	2427
713	2.000	1824	2427
714	1.000	1815	2428
715	1.000	1816	2428
716	2.000	1817	2428
717	2.000	1818	2428
718	2.000	1819	2428
719	2.000	1820	2428
720	1.000	1821	2428
721	1.000	1822	2428
722	2.000	1823	2428
723	2.000	1824	2428
724	1.000	1815	2429
725	1.000	1816	2429
726	2.000	1817	2429
727	2.000	1818	2429
728	2.000	1819	2429
729	2.000	1820	2429
730	1.000	1821	2429
731	1.000	1822	2429
732	2.000	1823	2429
733	2.000	1824	2429
734	2.000	2155	2430
735	6.000	2156	2430
736	6.000	2157	2430
737	3.000	2158	2430
738	1.000	2159	2430
739	3.000	2139	2431
740	1.000	2140	2431
741	1.000	2141	2431
742	3.000	2142	2431
743	1.000	2143	2431
744	3.000	2144	2431
745	1.000	2145	2431
746	1.000	2146	2431
747	3.000	2139	2432
748	1.000	2140	2432
749	1.000	2141	2432
750	3.000	2142	2432
751	1.000	2143	2432
752	3.000	2144	2432
753	1.000	2145	2432
754	1.000	2146	2432
755	1.000	1836	2433
756	1.000	1837	2433
757	1.000	1838	2433
758	3.000	1839	2433
759	6.000	1840	2433
760	1.000	1841	2433
761	3.000	1842	2433
762	1.000	1843	2433
763	1.000	1844	2433
764	3.000	1845	2433
765	1.000	1836	2434
766	1.000	1837	2434
767	1.000	1838	2434
768	3.000	1839	2434
769	6.000	1840	2434
770	1.000	1841	2434
771	3.000	1842	2434
772	1.000	1843	2434
773	1.000	1844	2434
774	3.000	1845	2434
300020	10.000	1784	301295
300021	6.000	1785	301295
300022	10.000	1786	301295
300023	6.000	1787	301295
301224	2.000	2400	301546
301225	2.000	2401	301546
301226	6.000	2402	301546
301227	6.000	2403	301546
301228	1.000	2404	301546
301229	2.000	2405	301546
301230	2.000	2406	301546
301231	2.000	2407	301546
301232	1.000	2408	301546
301233	2.000	2409	301546
301744	6.000	2619	301704
301745	1.000	2620	301704
301746	1.000	2621	301704
301747	1.000	2622	301704
301748	6.000	2619	301705
301749	1.000	2620	301705
301750	1.000	2621	301705
301751	1.000	2622	301705
302204	1.000	2705	301758
302205	1.000	2706	301758
302206	1.000	2707	301758
302207	1.000	2705	301759
302208	1.000	2706	301759
302209	1.000	2707	301759
302210	1.000	2705	301760
302211	1.000	2706	301760
815	1.000	2160	2439
816	1.000	2161	2439
817	1.000	2162	2439
818	4.000	2163	2439
819	1.000	2164	2439
820	1.000	2165	2439
821	2.000	2166	2439
822	2.000	2167	2439
823	4.000	2168	2439
824	1.000	2169	2439
825	1.000	2160	2440
826	1.000	2161	2440
827	1.000	2162	2440
828	4.000	2163	2440
829	1.000	2164	2440
830	1.000	2165	2440
831	2.000	2166	2440
302212	1.000	2707	301760
302213	1.000	2705	301761
302214	1.000	2706	301761
302215	1.000	2707	301761
302604	1.000	2794	301960
302605	1.000	2795	301960
302606	1.000	2796	301960
302607	12.000	2797	301960
302608	12.000	2798	301960
832	2.000	2167	2440
833	4.000	2168	2440
834	1.000	2169	2440
835	1.000	2160	2441
836	1.000	2161	2441
837	1.000	2162	2441
838	4.000	2163	2441
839	1.000	2164	2441
840	1.000	2165	2441
841	2.000	2166	2441
842	2.000	2167	2441
843	4.000	2168	2441
844	1.000	2169	2441
845	1.000	1891	2442
846	1.000	1892	2442
847	1.000	1893	2442
848	1.000	1894	2442
849	1.000	1895	2442
850	2.000	1896	2442
851	2.000	1897	2442
852	1.000	1898	2442
853	1.000	1899	2442
854	1.000	1900	2442
855	1.000	1901	2442
856	1.000	1902	2442
857	1.000	1903	2442
858	1.000	1904	2442
859	1.000	1905	2442
860	1.000	1906	2442
861	1.000	1907	2442
862	1.000	1908	2442
863	1.000	1909	2442
864	1.000	1910	2442
865	1.000	1891	2443
866	1.000	1892	2443
867	1.000	1893	2443
868	1.000	1894	2443
869	1.000	1895	2443
870	2.000	1896	2443
871	2.000	1897	2443
872	1.000	1898	2443
873	1.000	1899	2443
874	1.000	1900	2443
875	1.000	1901	2443
876	1.000	1902	2443
877	1.000	1903	2443
878	1.000	1904	2443
879	1.000	1905	2443
880	1.000	1906	2443
881	1.000	1907	2443
882	1.000	1908	2443
883	1.000	1909	2443
884	1.000	1910	2443
885	1.000	1891	2444
886	1.000	1892	2444
887	1.000	1893	2444
888	1.000	1894	2444
889	1.000	1895	2444
890	2.000	1896	2444
891	2.000	1897	2444
892	1.000	1898	2444
893	1.000	1899	2444
894	1.000	1900	2444
895	1.000	1901	2444
896	1.000	1902	2444
897	1.000	1903	2444
898	1.000	1904	2444
899	1.000	1905	2444
900	1.000	1906	2444
901	1.000	1907	2444
902	1.000	1908	2444
903	1.000	1909	2444
904	1.000	1910	2444
905	1.000	1891	2445
906	1.000	1892	2445
907	1.000	1893	2445
908	1.000	1894	2445
909	1.000	1895	2445
910	2.000	1896	2445
911	2.000	1897	2445
912	1.000	1898	2445
913	1.000	1899	2445
914	1.000	1900	2445
915	1.000	1901	2445
916	1.000	1902	2445
917	1.000	1903	2445
918	1.000	1904	2445
919	1.000	1905	2445
920	1.000	1906	2445
921	1.000	1907	2445
922	1.000	1908	2445
923	1.000	1909	2445
924	1.000	1910	2445
925	2.000	1911	2446
926	6.000	1912	2446
927	3.000	1913	2446
928	3.000	1914	2446
929	1.000	1915	2446
930	2.000	1926	2447
931	6.000	1927	2447
932	3.000	1928	2447
933	2.000	1929	2447
934	6.000	1930	2447
935	36.000	1931	2447
936	1.000	1932	2447
937	12.000	1933	2447
938	12.000	1934	2447
939	3.000	1935	2447
940	6.000	1615	2448
941	1.000	1616	2448
942	6.000	1617	2448
943	6.000	1618	2448
944	3.000	1619	2448
945	3.000	1620	2448
946	6.000	1621	2448
947	6.000	1622	2448
948	1.000	1623	2448
949	6.000	1624	2448
950	1.000	1625	2448
951	6.000	1615	2449
952	1.000	1616	2449
953	6.000	1617	2449
954	6.000	1618	2449
955	3.000	1619	2449
956	3.000	1620	2449
957	6.000	1621	2449
958	6.000	1622	2449
959	1.000	1623	2449
960	6.000	1624	2449
961	1.000	1625	2449
962	2.000	1936	2450
963	6.000	1937	2450
964	6.000	1938	2450
965	6.000	1939	2450
966	6.000	1940	2450
967	3.000	1941	2450
968	6.000	1942	2450
969	3.000	1943	2450
970	24.000	1944	2450
971	12.000	1945	2450
972	3.000	1946	2450
973	1.000	1947	2450
974	1.000	1948	2450
975	1.000	1857	2451
976	2.000	1858	2451
977	1.000	1859	2451
978	1.000	1860	2451
979	1.000	1861	2451
980	2.000	1862	2451
981	1.000	1863	2451
982	4.000	1864	2451
983	1.000	1857	2452
984	2.000	1858	2452
985	1.000	1859	2452
986	1.000	1860	2452
987	1.000	1861	2452
988	2.000	1862	2452
989	1.000	1863	2452
990	4.000	1864	2452
991	1.000	1857	2453
992	2.000	1858	2453
993	1.000	1859	2453
994	1.000	1860	2453
995	1.000	1861	2453
996	2.000	1862	2453
997	1.000	1863	2453
998	4.000	1864	2453
999	1.000	1960	2454
1000	2.000	1961	2454
1001	1.000	1962	2454
1002	1.000	1963	2454
1003	2.000	1964	2454
1004	2.000	1965	2454
1005	1.000	1966	2454
1006	4.000	1967	2454
1007	1.000	1968	2454
1008	1.000	1969	2454
1009	1.000	1970	2454
1010	1.000	1960	2455
1011	2.000	1961	2455
1012	1.000	1962	2455
1013	1.000	1963	2455
1014	2.000	1964	2455
1015	2.000	1965	2455
1016	1.000	1966	2455
1017	4.000	1967	2455
1018	1.000	1968	2455
1019	1.000	1969	2455
1020	1.000	1970	2455
1021	1.000	1960	2456
1022	2.000	1961	2456
1023	1.000	1962	2456
1024	1.000	1963	2456
1025	2.000	1964	2456
1026	2.000	1965	2456
1027	1.000	1966	2456
1028	4.000	1967	2456
1029	1.000	1968	2456
1030	1.000	1969	2456
1031	1.000	1970	2456
1032	3.000	1850	2457
1033	1.000	1973	2458
1034	1.000	1974	2458
1035	1.000	1975	2458
1036	4.000	1976	2458
1037	1.000	1973	2459
1038	1.000	1974	2459
1039	1.000	1975	2459
1040	4.000	1976	2459
1041	1.000	1973	2460
1042	1.000	1974	2460
1043	1.000	1975	2460
1044	4.000	1976	2460
1048	1.000	1977	2462
1049	1.000	1978	2462
1050	4.000	1979	2462
1051	1.000	1977	2463
1052	1.000	1978	2463
1053	4.000	1979	2463
1054	1.000	1977	2464
1055	1.000	1978	2464
1056	4.000	1979	2464
1057	1.000	1733	2465
1058	1.000	1734	2465
1059	1.000	1733	2466
1060	1.000	1734	2466
1061	1.000	1733	2467
1062	1.000	1734	2467
1063	1.000	1987	2468
1064	1.000	1988	2468
1065	1.000	1989	2468
1066	2.000	1990	2468
1067	1.000	1991	2468
1068	1.000	1992	2468
1069	1.000	1987	2469
1070	1.000	1988	2469
1071	1.000	1989	2469
1072	2.000	1990	2469
1073	1.000	1991	2469
1074	1.000	1992	2469
1075	1.000	1987	2470
1076	1.000	1988	2470
1077	1.000	1989	2470
1078	2.000	1990	2470
1079	1.000	1991	2470
1080	1.000	1992	2470
1081	1.000	2172	2473
1082	3.000	2171	2473
1083	1.000	2170	2473
1084	1.000	2172	2474
1085	3.000	2171	2474
1086	1.000	2170	2474
1087	1.000	1949	2475
1088	1.000	1950	2475
1089	1.000	1951	2475
1090	12.000	1952	2475
1091	1.000	1953	2475
1092	1.000	1949	2476
1093	1.000	1950	2476
1094	1.000	1951	2476
1095	12.000	1952	2476
1096	1.000	1953	2476
1097	1.000	1949	2477
1098	1.000	1950	2477
1099	1.000	1951	2477
1100	12.000	1952	2477
1101	1.000	1953	2477
1102	1.000	2173	2479
1103	1.000	2173	2480
1104	1.000	1849	2481
1105	1.000	1849	2482
1106	12.000	1833	2483
1107	9.000	1834	2483
1108	2.000	1984	2484
1109	6.000	1985	2484
1110	3.000	1986	2484
1111	1.000	1726	2485
1112	3.000	1727	2485
1113	6.000	1728	2485
1114	6.000	1729	2485
1115	1.000	1800	2486
1116	1.000	1800	2487
1117	1.000	1800	2488
300024	1.000	2176	301296
300025	1.000	2177	301296
300026	1.000	2192	301296
300027	1.000	2194	301296
300028	1.000	2178	301296
300029	1.000	2195	301296
300030	1.000	2179	301296
300031	1.000	2180	301296
300032	3.000	2181	301296
300033	1.000	2182	301296
300034	1.000	2174	301296
300035	1.000	2183	301296
300036	1.000	2175	301296
300037	1.000	2184	301296
300038	1.000	2185	301296
300039	1.000	2186	301296
300040	1.000	2187	301296
300041	1.000	2188	301296
300042	1.000	2189	301296
300043	1.000	2190	301296
300044	1.000	2191	301296
300045	1.000	2193	301296
300046	1.000	2176	301297
300047	1.000	2177	301297
300048	1.000	2192	301297
300049	1.000	2194	301297
300050	1.000	2178	301297
300051	1.000	2195	301297
300052	1.000	2179	301297
300053	1.000	2180	301297
300054	3.000	2181	301297
300055	1.000	2182	301297
300056	1.000	2174	301297
300057	1.000	2183	301297
300058	1.000	2175	301297
300059	1.000	2184	301297
300060	1.000	2185	301297
300061	1.000	2186	301297
300062	1.000	2187	301297
300063	1.000	2188	301297
300064	1.000	2189	301297
300065	1.000	2190	301297
300066	1.000	2191	301297
300067	1.000	2193	301297
300068	1.000	2176	301298
300069	1.000	2177	301298
300070	1.000	2192	301298
300071	1.000	2194	301298
300072	1.000	2178	301298
300073	1.000	2195	301298
300074	1.000	2179	301298
300075	1.000	2180	301298
300076	3.000	2181	301298
300077	1.000	2182	301298
300078	1.000	2174	301298
300079	1.000	2183	301298
300080	1.000	2175	301298
300081	1.000	2184	301298
300082	1.000	2185	301298
300083	1.000	2186	301298
300084	1.000	2187	301298
300085	1.000	2188	301298
300086	1.000	2189	301298
300087	1.000	2190	301298
300088	1.000	2191	301298
300089	1.000	2193	301298
300090	1.000	2176	301299
300091	1.000	2177	301299
300092	1.000	2192	301299
300093	1.000	2194	301299
300094	1.000	2178	301299
300095	1.000	2195	301299
300096	1.000	2179	301299
300097	1.000	2180	301299
300098	3.000	2181	301299
300099	1.000	2182	301299
300100	1.000	2174	301299
300101	1.000	2183	301299
300102	1.000	2175	301299
300103	1.000	2184	301299
300104	1.000	2185	301299
300105	1.000	2186	301299
300106	1.000	2187	301299
300107	1.000	2188	301299
300108	1.000	2189	301299
300109	1.000	2190	301299
300110	1.000	2191	301299
300111	1.000	2193	301299
300112	1.000	2176	301300
300113	1.000	2177	301300
300114	1.000	2192	301300
300115	1.000	2194	301300
300116	1.000	2178	301300
300117	1.000	2195	301300
300118	1.000	2179	301300
300119	1.000	2180	301300
300120	3.000	2181	301300
300121	1.000	2182	301300
300122	1.000	2174	301300
300123	1.000	2183	301300
300124	1.000	2175	301300
300125	1.000	2184	301300
300126	1.000	2185	301300
300127	1.000	2186	301300
300128	1.000	2187	301300
300129	1.000	2188	301300
300130	1.000	2189	301300
300131	1.000	2190	301300
300132	1.000	2191	301300
300133	1.000	2193	301300
300134	1.000	2176	301301
300135	1.000	2177	301301
300136	1.000	2192	301301
300137	1.000	2194	301301
300138	1.000	2178	301301
300139	1.000	2195	301301
300140	1.000	2179	301301
300141	1.000	2180	301301
300142	3.000	2181	301301
300143	1.000	2182	301301
300144	1.000	2174	301301
300145	1.000	2183	301301
300146	1.000	2175	301301
300147	1.000	2184	301301
300148	1.000	2185	301301
300149	1.000	2186	301301
300150	1.000	2187	301301
300151	1.000	2188	301301
300152	1.000	2189	301301
300153	1.000	2190	301301
300154	1.000	2191	301301
300155	1.000	2193	301301
300156	1.000	2176	301302
300157	1.000	2177	301302
300158	1.000	2192	301302
300159	1.000	2194	301302
300160	1.000	2178	301302
300161	1.000	2195	301302
300162	1.000	2179	301302
300163	1.000	2180	301302
300164	3.000	2181	301302
300165	1.000	2182	301302
300166	1.000	2174	301302
300167	1.000	2183	301302
300168	1.000	2175	301302
300169	1.000	2184	301302
300170	1.000	2185	301302
300171	1.000	2186	301302
300172	1.000	2187	301302
300173	1.000	2188	301302
300174	1.000	2189	301302
300175	1.000	2190	301302
300176	1.000	2191	301302
300177	1.000	2193	301302
301234	1.000	2425	301547
301235	1.000	2426	301547
301236	6.000	2427	301547
301237	3.000	2428	301547
301238	6.000	2429	301547
301239	2.000	2430	301547
301240	3.000	2431	301547
301241	1.000	2432	301547
301242	3.000	2433	301547
301243	2.000	2434	301547
301244	1.000	2435	301547
301245	6.000	2436	301547
301246	1.000	2425	301548
301247	1.000	2426	301548
301248	6.000	2427	301548
301249	3.000	2428	301548
301250	6.000	2429	301548
301251	2.000	2430	301548
301252	3.000	2431	301548
301253	1.000	2432	301548
301254	3.000	2433	301548
301255	2.000	2434	301548
301256	1.000	2435	301548
301257	6.000	2436	301548
301479	1.000	2472	301564
301480	2.000	2473	301564
301481	2.000	2474	301564
301482	1.000	2475	301564
301483	4.000	2476	301564
301484	1.000	2472	301565
301485	2.000	2473	301565
301486	2.000	2474	301565
301487	1.000	2475	301565
301488	4.000	2476	301565
301489	1.000	2472	301566
301490	2.000	2473	301566
301491	2.000	2474	301566
301492	1.000	2475	301566
301493	4.000	2476	301566
301752	1.000	2576	301706
301753	1.000	2577	301706
301754	1.000	2578	301706
301755	1.000	2579	301706
301756	1.000	2580	301706
301757	2.000	2581	301706
301758	1.000	2582	301706
301759	1.000	2583	301706
301760	1.000	2576	301707
301761	1.000	2577	301707
301762	1.000	2578	301707
301763	1.000	2579	301707
301764	1.000	2580	301707
301765	2.000	2581	301707
301766	1.000	2582	301707
301767	1.000	2583	301707
301768	1.000	2576	301708
301769	1.000	2577	301708
301770	1.000	2578	301708
301771	1.000	2579	301708
301772	1.000	2580	301708
301773	2.000	2581	301708
301774	1.000	2582	301708
301775	1.000	2583	301708
301776	1.000	2576	301709
301777	1.000	2577	301709
301778	1.000	2578	301709
301779	1.000	2579	301709
301780	1.000	2580	301709
301781	2.000	2581	301709
301782	1.000	2582	301709
301783	1.000	2583	301709
301784	1.000	2576	301710
301785	1.000	2577	301710
301786	1.000	2578	301710
301787	1.000	2579	301710
301788	1.000	2580	301710
301789	2.000	2581	301710
301790	1.000	2582	301710
301791	1.000	2583	301710
301792	1.000	2576	301711
301793	1.000	2577	301711
301794	1.000	2578	301711
301795	1.000	2579	301711
301796	1.000	2580	301711
301797	2.000	2581	301711
301798	1.000	2582	301711
301799	1.000	2583	301711
302216	4.000	2650	301762
302609	6.000	2799	301960
302610	3.000	2800	301960
303234	1.000	3045	302008
305235	6.000	3716	302661
305236	4.000	3717	302661
305237	1.000	3718	302661
305238	17.000	3719	302661
305239	1.000	3720	302661
305240	5.000	3721	302661
305241	3.000	3722	302661
305242	2.000	3723	302661
305243	1.000	3724	302661
305244	1.000	3725	302661
305245	1.000	3726	302661
305246	1.000	3727	302661
305247	1.000	3728	302661
305248	1.000	3729	302661
305249	2.000	3730	302661
300178	15.000	1706	301303
300179	1.000	1707	301303
301258	6.000	2410	301549
301259	1.000	2411	301549
301260	1.000	2412	301549
301261	1.000	2413	301549
301262	6.000	2414	301549
301263	6.000	2415	301549
301264	1.000	2416	301549
301265	1.000	2417	301549
301266	6.000	2418	301549
301267	6.000	2419	301549
301268	6.000	2420	301549
301269	1.000	2421	301549
301270	6.000	2410	301550
301271	1.000	2411	301550
301272	1.000	2412	301550
301273	1.000	2413	301550
301274	6.000	2414	301550
301275	6.000	2415	301550
301276	1.000	2416	301550
301277	1.000	2417	301550
301278	6.000	2418	301550
301279	6.000	2419	301550
301280	6.000	2420	301550
301281	1.000	2421	301550
301494	24.000	2477	301567
301495	1.000	2478	301567
301496	6.000	2479	301567
301497	1.000	2480	301567
301498	1.000	2481	301567
301800	1.000	2567	301712
301801	1.000	2568	301712
301802	1.000	2569	301712
301803	1.000	2570	301712
301804	1.000	2571	301712
301805	2.000	2572	301712
301806	1.000	2573	301712
301807	1.000	2574	301712
301808	2.000	2575	301712
301809	1.000	2567	301713
301810	1.000	2568	301713
301811	1.000	2569	301713
301812	1.000	2570	301713
301813	1.000	2571	301713
301814	2.000	2572	301713
301815	1.000	2573	301713
301816	1.000	2574	301713
301817	2.000	2575	301713
301818	1.000	2567	301714
301819	1.000	2568	301714
301820	1.000	2569	301714
301821	1.000	2570	301714
301822	1.000	2571	301714
301823	2.000	2572	301714
301824	1.000	2573	301714
301825	1.000	2574	301714
301826	2.000	2575	301714
301827	1.000	2567	301715
301828	1.000	2568	301715
301829	1.000	2569	301715
301830	1.000	2570	301715
301831	1.000	2571	301715
301832	2.000	2572	301715
301833	1.000	2573	301715
301834	1.000	2574	301715
301835	2.000	2575	301715
301836	1.000	2567	301716
301837	1.000	2568	301716
301838	1.000	2569	301716
301839	1.000	2570	301716
301840	1.000	2571	301716
301841	2.000	2572	301716
301842	1.000	2573	301716
301843	1.000	2574	301716
301844	2.000	2575	301716
301845	1.000	2567	301717
301846	1.000	2568	301717
301847	1.000	2569	301717
301848	1.000	2570	301717
301849	1.000	2571	301717
301850	2.000	2572	301717
301851	1.000	2573	301717
301852	1.000	2574	301717
301853	2.000	2575	301717
301854	1.000	2567	301718
301855	1.000	2568	301718
301856	1.000	2569	301718
301857	1.000	2570	301718
301858	1.000	2571	301718
301859	2.000	2572	301718
301860	1.000	2573	301718
301861	1.000	2574	301718
301862	2.000	2575	301718
301863	1.000	2567	301719
301864	1.000	2568	301719
301865	1.000	2569	301719
301866	1.000	2570	301719
301867	1.000	2571	301719
301868	2.000	2572	301719
301869	1.000	2573	301719
301870	1.000	2574	301719
301871	2.000	2575	301719
301872	1.000	2567	301720
301873	1.000	2568	301720
301874	1.000	2569	301720
301875	1.000	2570	301720
301876	1.000	2571	301720
301877	2.000	2572	301720
301878	1.000	2573	301720
301879	1.000	2574	301720
301880	2.000	2575	301720
301881	1.000	2567	301721
301882	1.000	2568	301721
301883	1.000	2569	301721
301884	1.000	2570	301721
301885	1.000	2571	301721
301886	2.000	2572	301721
301887	1.000	2573	301721
301888	1.000	2574	301721
301889	2.000	2575	301721
302611	1.000	3018	301961
302612	3.000	3019	301961
302613	1.000	3020	301961
302614	1.000	3021	301961
302615	1.000	3022	301961
302616	1.000	3018	301962
302617	3.000	3019	301962
302618	1.000	3020	301962
302619	1.000	3021	301962
302620	1.000	3022	301962
302621	1.000	3018	301963
302622	3.000	3019	301963
302623	1.000	3020	301963
302624	1.000	3021	301963
302625	1.000	3022	301963
300180	12.000	1708	301304
300181	4.000	1709	301304
300182	6.000	1710	301304
300183	2.000	1711	301304
300184	1.000	1712	301304
300185	6.000	1713	301304
300186	3.000	1714	301304
300187	1.000	1715	301304
301499	6.000	2482	301568
301500	1.000	2483	301568
301501	4.000	2484	301568
301502	3.000	2485	301568
301503	3.000	2486	301568
301504	1.000	2487	301568
301505	3.000	2488	301568
301506	1.000	2489	301568
301507	6.000	2490	301568
301508	2.000	2491	301568
301509	1.000	2492	301568
301510	6.000	2493	301568
301511	1.000	2494	301568
301512	1.000	2495	301568
301513	1.000	2496	301568
301514	2.000	2497	301568
301515	6.000	2482	301569
301516	1.000	2483	301569
301517	4.000	2484	301569
301518	3.000	2485	301569
301519	3.000	2486	301569
301520	1.000	2487	301569
301521	3.000	2488	301569
301522	1.000	2489	301569
301523	6.000	2490	301569
301524	2.000	2491	301569
301525	1.000	2492	301569
301526	6.000	2493	301569
301527	1.000	2494	301569
301528	1.000	2495	301569
301529	1.000	2496	301569
301530	2.000	2497	301569
301890	1.000	2789	301722
301891	1.000	2790	301722
302219	10.000	2684	301764
302220	1.000	2685	301764
302221	10.000	2684	301765
302222	1.000	2685	301765
302626	1.000	3018	301964
302627	3.000	3019	301964
302628	1.000	3020	301964
302629	1.000	3021	301964
302630	1.000	3022	301964
303235	3.000	3042	302009
303236	1.000	3043	302009
303237	1.000	3044	302009
303238	3.000	3042	302010
303239	1.000	3043	302010
303240	1.000	3044	302010
305250	1.000	3731	302661
305251	1.000	3732	302661
305252	6.000	3716	302662
305253	4.000	3717	302662
305254	1.000	3718	302662
305255	17.000	3719	302662
305256	1.000	3720	302662
305257	5.000	3721	302662
305258	3.000	3722	302662
305259	2.000	3723	302662
305260	1.000	3724	302662
305261	1.000	3725	302662
305262	1.000	3726	302662
305263	1.000	3727	302662
305264	1.000	3728	302662
305265	1.000	3729	302662
305266	2.000	3730	302662
305267	1.000	3731	302662
305268	1.000	3732	302662
305269	6.000	3716	302663
305270	4.000	3717	302663
305271	1.000	3718	302663
305272	17.000	3719	302663
305273	1.000	3720	302663
305274	5.000	3721	302663
305275	3.000	3722	302663
305276	2.000	3723	302663
305277	1.000	3724	302663
305278	1.000	3725	302663
305279	1.000	3726	302663
305280	1.000	3727	302663
305281	1.000	3728	302663
305282	1.000	3729	302663
305283	2.000	3730	302663
305284	1.000	3731	302663
305285	1.000	3732	302663
305286	6.000	3716	302664
305287	4.000	3717	302664
305288	1.000	3718	302664
305289	17.000	3719	302664
305290	1.000	3720	302664
305291	5.000	3721	302664
305292	3.000	3722	302664
305293	2.000	3723	302664
305294	1.000	3724	302664
305295	1.000	3725	302664
305296	1.000	3726	302664
305297	1.000	3727	302664
305298	1.000	3728	302664
305299	1.000	3729	302664
305300	2.000	3730	302664
305301	1.000	3731	302664
305302	1.000	3732	302664
305303	6.000	3716	302665
305304	4.000	3717	302665
305305	1.000	3718	302665
305306	17.000	3719	302665
305307	1.000	3720	302665
305308	5.000	3721	302665
305309	3.000	3722	302665
305310	2.000	3723	302665
305311	1.000	3724	302665
305312	1.000	3725	302665
305313	1.000	3726	302665
305314	1.000	3727	302665
305315	1.000	3728	302665
305316	1.000	3729	302665
305317	2.000	3730	302665
305318	1.000	3731	302665
305319	1.000	3732	302665
305320	6.000	3716	302666
305321	4.000	3717	302666
300188	1.000	2196	301306
300189	1.000	2196	301307
300190	1.000	2196	301308
300191	1.000	2196	301309
300192	1.000	2196	301310
301384	1.000	2444	301557
301385	1.000	2445	301557
301386	1.000	2446	301557
301387	1.000	2447	301557
301388	1.000	2448	301557
301389	2.000	2449	301557
301390	2.000	2450	301557
301391	1.000	2451	301557
301392	1.000	2452	301557
301393	2.000	2453	301557
301394	1.000	2437	301557
301395	1.000	2438	301557
301396	1.000	2439	301557
301397	1.000	2440	301557
301398	2.000	2441	301557
301399	1.000	2442	301557
301400	1.000	2443	301557
301401	1.000	2444	301558
301402	1.000	2445	301558
301403	1.000	2446	301558
301404	1.000	2447	301558
301405	1.000	2448	301558
301406	2.000	2449	301558
301407	2.000	2450	301558
301408	1.000	2451	301558
301409	1.000	2452	301558
301410	2.000	2453	301558
301411	1.000	2437	301558
301412	1.000	2438	301558
301413	1.000	2439	301558
301414	1.000	2440	301558
301415	2.000	2441	301558
301416	1.000	2442	301558
301417	1.000	2443	301558
301418	1.000	2444	301559
301419	1.000	2445	301559
301420	1.000	2446	301559
301421	1.000	2447	301559
301422	1.000	2448	301559
301423	2.000	2449	301559
301424	2.000	2450	301559
301425	1.000	2451	301559
301426	1.000	2452	301559
301427	2.000	2453	301559
301428	1.000	2437	301559
301429	1.000	2438	301559
301430	1.000	2439	301559
301431	1.000	2440	301559
301432	2.000	2441	301559
301433	1.000	2442	301559
301434	1.000	2443	301559
301435	1.000	2444	301560
301436	1.000	2445	301560
301437	1.000	2446	301560
301438	1.000	2447	301560
301439	1.000	2448	301560
301440	2.000	2449	301560
301441	2.000	2450	301560
301442	1.000	2451	301560
301443	1.000	2452	301560
301444	2.000	2453	301560
301445	1.000	2437	301560
301446	1.000	2438	301560
301447	1.000	2439	301560
301448	1.000	2440	301560
301449	2.000	2441	301560
301450	1.000	2442	301560
301451	1.000	2443	301560
301452	1.000	2444	301561
301453	1.000	2445	301561
301454	1.000	2446	301561
301455	1.000	2447	301561
301456	1.000	2448	301561
301457	2.000	2449	301561
301458	2.000	2450	301561
301459	1.000	2451	301561
301460	1.000	2452	301561
301461	2.000	2453	301561
301462	1.000	2437	301561
301463	1.000	2438	301561
301464	1.000	2439	301561
301465	1.000	2440	301561
301466	2.000	2441	301561
301467	1.000	2442	301561
301468	1.000	2443	301561
301531	1.000	2498	301570
301892	1.000	2613	301723
301893	1.000	2614	301723
301894	6.000	2615	301723
301895	6.000	2616	301723
301896	12.000	2617	301723
301897	12.000	2618	301723
302223	1.000	2673	301766
302224	1.000	2674	301766
302225	1.000	2675	301766
302226	1.000	2676	301766
302227	1.000	2677	301766
302228	1.000	2678	301766
302229	2.000	2679	301766
302230	1.000	2680	301766
302231	2.000	2681	301766
302232	1.000	2682	301766
302233	2.000	2683	301766
302234	1.000	2673	301767
302235	1.000	2674	301767
302236	1.000	2675	301767
302237	1.000	2676	301767
302238	1.000	2677	301767
302239	1.000	2678	301767
302240	2.000	2679	301767
302241	1.000	2680	301767
302242	2.000	2681	301767
302243	1.000	2682	301767
302244	2.000	2683	301767
302631	2.000	2802	301965
302632	1.000	2803	301965
302633	1.000	2804	301965
302634	4.000	2805	301965
302635	1.000	2806	301965
302636	12.000	2807	301965
302637	8.000	2808	301965
302638	6.000	2809	301965
302639	8.000	2810	301965
302640	3.000	2811	301965
302641	3.000	2812	301965
302642	1.000	2813	301965
303241	1.000	3052	302043
303242	1.000	3053	302043
303243	1.000	3054	302043
303244	1.000	3052	302044
303245	1.000	3053	302044
300193	1.000	2197	301319
300194	1.000	2197	301320
300195	1.000	2197	301321
301532	6.000	2499	301571
301533	1.000	2500	301571
301534	1.000	2501	301571
301535	6.000	2502	301571
301536	1.000	2503	301571
301537	6.000	2504	301571
301538	6.000	2505	301571
301539	3.000	2506	301571
301540	6.000	2499	301572
301541	1.000	2500	301572
301542	1.000	2501	301572
301543	6.000	2502	301572
301544	1.000	2503	301572
301545	6.000	2504	301572
301546	6.000	2505	301572
301547	3.000	2506	301572
301898	2.000	2787	301724
301899	6.000	2788	301724
302245	3.000	2666	301768
302246	3.000	2667	301768
302247	1.000	2668	301768
302248	1.000	2669	301768
302249	2.000	2670	301768
302250	1.000	2671	301768
302251	1.000	2672	301768
302252	3.000	2666	301769
302253	3.000	2667	301769
302254	1.000	2668	301769
302255	1.000	2669	301769
302256	2.000	2670	301769
302257	1.000	2671	301769
302258	1.000	2672	301769
302643	2.000	2852	301966
302644	2.000	2853	301966
302645	2.000	2854	301966
302646	8.000	2855	301966
302647	4.000	2856	301966
302648	1.000	2857	301966
302649	1.000	2858	301966
302650	8.000	2859	301966
302651	4.000	2860	301966
302652	4.000	2861	301966
302653	4.000	2862	301966
302654	4.000	2863	301966
302655	1.000	2864	301966
302656	4.000	2865	301966
302657	2.000	2866	301966
302658	4.000	2867	301966
302659	4.000	2868	301966
302660	4.000	2869	301966
302661	1.000	2870	301966
302662	4.000	2871	301966
302663	2.000	2872	301966
302664	4.000	2873	301966
302665	4.000	2874	301966
302666	8.000	2875	301966
302667	2.000	2876	301966
302668	2.000	2877	301966
302669	1.000	2878	301966
302670	4.000	2879	301966
302671	4.000	2880	301966
302672	4.000	2881	301966
302673	4.000	2882	301966
302674	2.000	2883	301966
302675	1.000	2884	301966
302676	4.000	2885	301966
302677	4.000	2886	301966
302678	4.000	2887	301966
302679	4.000	2888	301966
302680	4.000	2889	301966
302681	4.000	2890	301966
302682	1.000	2891	301966
302683	4.000	2892	301966
302684	4.000	2893	301966
302685	2.000	2852	301967
302686	2.000	2853	301967
302687	2.000	2854	301967
302688	8.000	2855	301967
302689	4.000	2856	301967
302690	1.000	2857	301967
302691	1.000	2858	301967
302692	8.000	2859	301967
302693	4.000	2860	301967
302694	4.000	2861	301967
302695	4.000	2862	301967
302696	4.000	2863	301967
302697	1.000	2864	301967
302698	4.000	2865	301967
302699	2.000	2866	301967
302700	4.000	2867	301967
302701	4.000	2868	301967
302702	4.000	2869	301967
302703	1.000	2870	301967
302704	4.000	2871	301967
302705	2.000	2872	301967
302706	4.000	2873	301967
302707	4.000	2874	301967
302708	8.000	2875	301967
302709	2.000	2876	301967
302710	2.000	2877	301967
302711	1.000	2878	301967
302712	4.000	2879	301967
302713	4.000	2880	301967
302714	4.000	2881	301967
302715	4.000	2882	301967
302716	2.000	2883	301967
302717	1.000	2884	301967
302718	4.000	2885	301967
302719	4.000	2886	301967
302720	4.000	2887	301967
302721	4.000	2888	301967
302722	4.000	2889	301967
302723	4.000	2890	301967
302724	1.000	2891	301967
302725	4.000	2892	301967
302726	4.000	2893	301967
302727	2.000	2852	301968
302728	2.000	2853	301968
302729	2.000	2854	301968
302730	8.000	2855	301968
302731	4.000	2856	301968
302732	1.000	2857	301968
302733	1.000	2858	301968
302734	8.000	2859	301968
302735	4.000	2860	301968
302736	4.000	2861	301968
302737	4.000	2862	301968
302738	4.000	2863	301968
302739	1.000	2864	301968
302740	4.000	2865	301968
302741	2.000	2866	301968
302742	4.000	2867	301968
302743	4.000	2868	301968
300196	1.000	2212	301325
300197	1.000	2212	301326
300198	1.000	2212	301327
301548	5.000	2454	301573
301549	1.000	2455	301573
301550	5.000	2456	301573
301551	1.000	2457	301573
301552	1.000	2458	301573
301553	1.000	2459	301573
301554	1.000	2460	301573
301555	1.000	2461	301573
301556	1.000	2462	301573
301557	1.000	2463	301573
301558	3.000	2464	301573
301559	1.000	2465	301573
301560	3.000	2466	301573
301561	1.000	2467	301573
301562	1.000	2468	301573
301563	1.000	2469	301573
301564	1.000	2470	301573
301565	1.000	2471	301573
301566	5.000	2454	301574
301567	1.000	2455	301574
301568	5.000	2456	301574
301569	1.000	2457	301574
301570	1.000	2458	301574
301571	1.000	2459	301574
301572	1.000	2460	301574
301573	1.000	2461	301574
301574	1.000	2462	301574
301575	1.000	2463	301574
301576	3.000	2464	301574
301577	1.000	2465	301574
301578	3.000	2466	301574
301579	1.000	2467	301574
301580	1.000	2468	301574
301581	1.000	2469	301574
301582	1.000	2470	301574
301583	1.000	2471	301574
301584	5.000	2454	301575
301585	1.000	2455	301575
301586	5.000	2456	301575
301587	1.000	2457	301575
301588	1.000	2458	301575
301589	1.000	2459	301575
301590	1.000	2460	301575
301591	1.000	2461	301575
301592	1.000	2462	301575
301593	1.000	2463	301575
301594	3.000	2464	301575
301595	1.000	2465	301575
301596	3.000	2466	301575
301597	1.000	2467	301575
301598	1.000	2468	301575
301599	1.000	2469	301575
301600	1.000	2470	301575
301601	1.000	2471	301575
301602	5.000	2454	301576
301603	1.000	2455	301576
301604	5.000	2456	301576
301605	1.000	2457	301576
301606	1.000	2458	301576
301607	1.000	2459	301576
301608	1.000	2460	301576
301609	1.000	2461	301576
301610	1.000	2462	301576
301611	1.000	2463	301576
301612	3.000	2464	301576
301613	1.000	2465	301576
301614	3.000	2466	301576
301615	1.000	2467	301576
301616	1.000	2468	301576
301617	1.000	2469	301576
301618	1.000	2470	301576
301619	1.000	2471	301576
301900	18.000	2791	301725
302259	3.000	2651	301770
302260	3.000	2652	301770
302261	6.000	2653	301770
302262	6.000	2654	301770
302744	4.000	2869	301968
302745	1.000	2870	301968
302746	4.000	2871	301968
302747	2.000	2872	301968
302748	4.000	2873	301968
302749	4.000	2874	301968
302750	8.000	2875	301968
302751	2.000	2876	301968
302752	2.000	2877	301968
302753	1.000	2878	301968
302754	4.000	2879	301968
302755	4.000	2880	301968
302756	4.000	2881	301968
302757	4.000	2882	301968
302758	2.000	2883	301968
302759	1.000	2884	301968
302760	4.000	2885	301968
302761	4.000	2886	301968
302762	4.000	2887	301968
302763	4.000	2888	301968
302764	4.000	2889	301968
302765	4.000	2890	301968
302766	1.000	2891	301968
302767	4.000	2892	301968
302768	4.000	2893	301968
303246	1.000	3054	302044
303247	1.000	3052	302045
303248	1.000	3053	302045
303249	1.000	3054	302045
303250	1.000	3052	302046
303251	1.000	3053	302046
303252	1.000	3054	302046
303253	1.000	3052	302047
303254	1.000	3053	302047
303255	1.000	3054	302047
305322	1.000	3718	302666
305323	17.000	3719	302666
305324	1.000	3720	302666
305325	5.000	3721	302666
305326	3.000	3722	302666
305327	2.000	3723	302666
305328	1.000	3724	302666
305329	1.000	3725	302666
305330	1.000	3726	302666
305331	1.000	3727	302666
305332	1.000	3728	302666
305333	1.000	3729	302666
305334	2.000	3730	302666
305335	1.000	3731	302666
305336	1.000	3732	302666
305337	6.000	3716	302667
305338	4.000	3717	302667
305339	1.000	3718	302667
305340	17.000	3719	302667
305341	1.000	3720	302667
305342	5.000	3721	302667
300199	1.000	2211	301328
300200	1.000	2202	301328
300201	2.000	2203	301328
300202	2.000	2200	301328
300203	1.000	2201	301328
300204	2.000	2198	301328
300205	2.000	2204	301328
300206	1.000	2205	301328
300207	1.000	2206	301328
300208	1.000	2207	301328
300209	1.000	2199	301328
300210	1.000	2208	301328
300211	1.000	2209	301328
300212	1.000	2210	301328
300213	1.000	2211	301329
300214	1.000	2202	301329
300215	2.000	2203	301329
300216	2.000	2200	301329
300217	1.000	2201	301329
300218	2.000	2198	301329
300219	2.000	2204	301329
300220	1.000	2205	301329
300221	1.000	2206	301329
300222	1.000	2207	301329
300223	1.000	2199	301329
300224	1.000	2208	301329
300225	1.000	2209	301329
300226	1.000	2210	301329
300227	1.000	2211	301330
300228	1.000	2202	301330
300229	2.000	2203	301330
300230	2.000	2200	301330
300231	1.000	2201	301330
300232	2.000	2198	301330
300233	2.000	2204	301330
300234	1.000	2205	301330
300235	1.000	2206	301330
300236	1.000	2207	301330
300237	1.000	2199	301330
300238	1.000	2208	301330
300239	1.000	2209	301330
300240	1.000	2210	301330
300241	1.000	2211	301331
300242	1.000	2202	301331
300243	2.000	2203	301331
300244	2.000	2200	301331
300245	1.000	2201	301331
300246	2.000	2198	301331
300247	2.000	2204	301331
300248	1.000	2205	301331
300249	1.000	2206	301331
300250	1.000	2207	301331
300251	1.000	2199	301331
300252	1.000	2208	301331
300253	1.000	2209	301331
300254	1.000	2210	301331
300255	1.000	2211	301332
300256	1.000	2202	301332
300257	2.000	2203	301332
300258	2.000	2200	301332
300259	1.000	2201	301332
300260	2.000	2198	301332
300261	2.000	2204	301332
300262	1.000	2205	301332
300263	1.000	2206	301332
300264	1.000	2207	301332
300265	1.000	2199	301332
300266	1.000	2208	301332
300267	1.000	2209	301332
300268	1.000	2210	301332
300269	1.000	2211	301333
300270	1.000	2202	301333
300271	2.000	2203	301333
300272	2.000	2200	301333
300273	1.000	2201	301333
300274	2.000	2198	301333
300275	2.000	2204	301333
300276	1.000	2205	301333
300277	1.000	2206	301333
300278	1.000	2207	301333
300279	1.000	2199	301333
300280	1.000	2208	301333
300281	1.000	2209	301333
300282	1.000	2210	301333
301620	1.000	2524	301578
301901	6.000	2546	301726
301902	12.000	2547	301726
301903	12.000	2548	301726
301904	12.000	2549	301726
301905	3.000	2550	301726
301906	12.000	2551	301726
301907	6.000	2552	301726
301908	6.000	2553	301726
301909	2.000	2554	301726
302263	3.000	2660	301771
302264	3.000	2661	301771
302265	1.000	2662	301771
302266	1.000	2663	301771
302267	2.000	2664	301771
302268	1.000	2665	301771
302269	3.000	2660	301772
302270	3.000	2661	301772
302271	1.000	2662	301772
302272	1.000	2663	301772
302273	2.000	2664	301772
302274	1.000	2665	301772
302769	6.000	2965	301969
302770	2.000	2966	301969
302771	8.000	2967	301969
302772	1.000	2968	301969
302773	2.000	2969	301969
302774	1.000	2970	301969
302775	1.000	2971	301969
302776	1.000	2972	301969
302777	6.000	2965	301970
302778	2.000	2966	301970
302779	8.000	2967	301970
302780	1.000	2968	301970
302781	2.000	2969	301970
302782	1.000	2970	301970
302783	1.000	2971	301970
302784	1.000	2972	301970
302785	6.000	2965	301971
302786	2.000	2966	301971
302787	8.000	2967	301971
302788	1.000	2968	301971
302789	2.000	2969	301971
302790	1.000	2970	301971
302791	1.000	2971	301971
302792	1.000	2972	301971
303256	2.000	3080	302048
303257	2.000	3081	302048
305343	3.000	3722	302667
305344	2.000	3723	302667
305345	1.000	3724	302667
305346	1.000	3725	302667
301621	1.000	2525	301580
301910	3.000	2765	301727
302275	1.000	2655	301773
302276	2.000	2656	301773
302277	4.000	2657	301773
302278	1.000	2658	301773
302279	2.000	2659	301773
302793	1.000	3012	301972
302794	3.000	3013	301972
302795	1.000	3014	301972
302796	1.000	3015	301972
302797	1.000	3016	301972
302798	1.000	3017	301972
302799	1.000	3012	301973
302800	3.000	3013	301973
302801	1.000	3014	301973
302802	1.000	3015	301973
302803	1.000	3016	301973
302804	1.000	3017	301973
303258	1.000	3058	302049
303259	12.000	3059	302049
305347	1.000	3726	302667
305348	1.000	3727	302667
305349	1.000	3728	302667
305350	1.000	3729	302667
305351	2.000	3730	302667
305352	1.000	3731	302667
305353	1.000	3732	302667
305354	6.000	3716	302668
305355	4.000	3717	302668
305356	1.000	3718	302668
305357	17.000	3719	302668
305358	1.000	3720	302668
305359	5.000	3721	302668
305360	3.000	3722	302668
305361	2.000	3723	302668
305362	1.000	3724	302668
305363	1.000	3725	302668
305364	1.000	3726	302668
305365	1.000	3727	302668
305366	1.000	3728	302668
305367	1.000	3729	302668
305368	2.000	3730	302668
305369	1.000	3731	302668
305370	1.000	3732	302668
305371	6.000	3716	302669
305372	4.000	3717	302669
305373	1.000	3718	302669
305374	17.000	3719	302669
305375	1.000	3720	302669
305376	5.000	3721	302669
305377	3.000	3722	302669
305378	2.000	3723	302669
305379	1.000	3724	302669
305380	1.000	3725	302669
305381	1.000	3726	302669
305382	1.000	3727	302669
305383	1.000	3728	302669
305384	1.000	3729	302669
305385	2.000	3730	302669
305386	1.000	3731	302669
305387	1.000	3732	302669
305388	6.000	3716	302670
305389	4.000	3717	302670
305390	1.000	3718	302670
305391	17.000	3719	302670
305392	1.000	3720	302670
305393	5.000	3721	302670
305394	3.000	3722	302670
305395	2.000	3723	302670
305396	1.000	3724	302670
305397	1.000	3725	302670
305398	1.000	3726	302670
305399	1.000	3727	302670
305400	1.000	3728	302670
305401	1.000	3729	302670
305402	2.000	3730	302670
305403	1.000	3731	302670
305404	1.000	3732	302670
305405	6.000	3716	302671
305406	4.000	3717	302671
305407	1.000	3718	302671
305408	17.000	3719	302671
305409	1.000	3720	302671
305410	5.000	3721	302671
305411	3.000	3722	302671
305412	2.000	3723	302671
305413	1.000	3724	302671
305414	1.000	3725	302671
305415	1.000	3726	302671
305416	1.000	3727	302671
305417	1.000	3728	302671
305418	1.000	3729	302671
305419	2.000	3730	302671
305420	1.000	3731	302671
305421	1.000	3732	302671
305422	6.000	3716	302672
305423	4.000	3717	302672
305424	1.000	3718	302672
305425	17.000	3719	302672
305426	1.000	3720	302672
305427	5.000	3721	302672
305428	3.000	3722	302672
305429	2.000	3723	302672
305430	1.000	3724	302672
305431	1.000	3725	302672
305432	1.000	3726	302672
305433	1.000	3727	302672
305434	1.000	3728	302672
305435	1.000	3729	302672
305436	2.000	3730	302672
305437	1.000	3731	302672
305438	1.000	3732	302672
305439	6.000	3716	302673
305440	4.000	3717	302673
305441	1.000	3718	302673
305442	17.000	3719	302673
305443	1.000	3720	302673
305444	5.000	3721	302673
305445	3.000	3722	302673
305446	2.000	3723	302673
305447	1.000	3724	302673
305448	1.000	3725	302673
305449	1.000	3726	302673
305450	1.000	3727	302673
305451	1.000	3728	302673
305452	1.000	3729	302673
305453	2.000	3730	302673
305454	1.000	3731	302673
305455	1.000	3732	302673
305456	6.000	3716	302674
305457	4.000	3717	302674
305458	1.000	3718	302674
305459	17.000	3719	302674
300305	6.000	2254	301340
300306	12.000	2247	301340
300307	12.000	2248	301340
300308	1.000	2249	301340
300309	12.000	2250	301340
300310	6.000	2251	301340
300311	12.000	2252	301340
300312	3.000	2253	301340
300313	2.000	2246	301340
301622	1.000	2526	301582
301911	36.000	2612	301728
302280	1.000	2686	301774
302281	1.000	2687	301774
302282	6.000	2688	301774
302283	1.000	2689	301774
302284	1.000	2690	301774
302285	1.000	2691	301774
302286	1.000	2692	301774
302287	3.000	2693	301774
302288	3.000	2694	301774
302289	6.000	2695	301774
302290	3.000	2696	301774
302291	3.000	2697	301774
302292	3.000	2698	301774
302293	1.000	2699	301774
302294	1.000	2700	301774
302295	1.000	2701	301774
302296	3.000	2702	301774
302297	1.000	2703	301774
302298	3.000	2704	301774
302299	1.000	2686	301775
302300	1.000	2687	301775
302301	6.000	2688	301775
302302	1.000	2689	301775
302303	1.000	2690	301775
302304	1.000	2691	301775
302305	1.000	2692	301775
302306	3.000	2693	301775
302307	3.000	2694	301775
302308	6.000	2695	301775
302309	3.000	2696	301775
302310	3.000	2697	301775
302311	3.000	2698	301775
302312	1.000	2699	301775
302313	1.000	2700	301775
302314	1.000	2701	301775
302315	3.000	2702	301775
302316	1.000	2703	301775
302317	3.000	2704	301775
302805	1.000	2942	301974
302806	1.000	2943	301974
302807	1.000	2944	301974
302808	3.000	2945	301974
302809	1.000	2946	301974
302810	1.000	2947	301974
302811	1.000	2948	301974
302812	1.000	2949	301974
302813	9.000	2950	301974
302814	3.000	2951	301974
302815	1.000	2952	301974
302816	15.000	2953	301974
302817	1.000	2954	301974
302818	1.000	2955	301974
302819	1.000	2956	301974
302820	1.000	2957	301974
302821	1.000	2958	301974
302822	1.000	2959	301974
302823	1.000	2960	301974
302824	1.000	2961	301974
302825	1.000	2962	301974
302826	3.000	2963	301974
302827	12.000	2964	301974
302828	1.000	2942	301975
302829	1.000	2943	301975
302830	1.000	2944	301975
302831	3.000	2945	301975
302832	1.000	2946	301975
302833	1.000	2947	301975
302834	1.000	2948	301975
302835	1.000	2949	301975
302836	9.000	2950	301975
302837	3.000	2951	301975
302838	1.000	2952	301975
302839	15.000	2953	301975
302840	1.000	2954	301975
302841	1.000	2955	301975
302842	1.000	2956	301975
302843	1.000	2957	301975
302844	1.000	2958	301975
302845	1.000	2959	301975
302846	1.000	2960	301975
302847	1.000	2961	301975
302848	1.000	2962	301975
302849	3.000	2963	301975
302850	12.000	2964	301975
302851	1.000	2942	301976
302852	1.000	2943	301976
302853	1.000	2944	301976
302854	3.000	2945	301976
302855	1.000	2946	301976
302856	1.000	2947	301976
302857	1.000	2948	301976
302858	1.000	2949	301976
302859	9.000	2950	301976
302860	3.000	2951	301976
302861	1.000	2952	301976
302862	15.000	2953	301976
302863	1.000	2954	301976
302864	1.000	2955	301976
302865	1.000	2956	301976
302866	1.000	2957	301976
302867	1.000	2958	301976
302868	1.000	2959	301976
302869	1.000	2960	301976
302870	1.000	2961	301976
302871	1.000	2962	301976
302872	3.000	2963	301976
302873	12.000	2964	301976
302874	1.000	2942	301977
302875	1.000	2943	301977
302876	1.000	2944	301977
302877	3.000	2945	301977
302878	1.000	2946	301977
302879	1.000	2947	301977
302880	1.000	2948	301977
302881	1.000	2949	301977
302882	9.000	2950	301977
302883	3.000	2951	301977
302884	1.000	2952	301977
302885	15.000	2953	301977
302886	1.000	2954	301977
302887	1.000	2955	301977
302888	1.000	2956	301977
302889	1.000	2957	301977
302890	1.000	2958	301977
302891	1.000	2959	301977
300314	36.000	2255	301342
300315	24.000	2256	301342
300316	6.000	2257	301342
301623	1.000	2527	301584
301912	3.000	2759	301729
302318	1.000	2623	301776
302319	1.000	2624	301776
302320	1.000	2625	301776
302321	1.000	2626	301776
302322	1.000	2627	301776
302323	1.000	2628	301776
302324	1.000	2629	301776
302325	6.000	2630	301776
302326	1.000	2631	301776
302327	1.000	2632	301776
302328	1.000	2633	301776
302329	3.000	2634	301776
302330	1.000	2623	301777
302331	1.000	2624	301777
302332	1.000	2625	301777
302333	1.000	2626	301777
302334	1.000	2627	301777
302335	1.000	2628	301777
302336	1.000	2629	301777
302337	6.000	2630	301777
302338	1.000	2631	301777
302339	1.000	2632	301777
302340	1.000	2633	301777
302341	3.000	2634	301777
302342	1.000	2623	301778
302343	1.000	2624	301778
302344	1.000	2625	301778
302345	1.000	2626	301778
302346	1.000	2627	301778
302347	1.000	2628	301778
302348	1.000	2629	301778
302349	6.000	2630	301778
302350	1.000	2631	301778
302351	1.000	2632	301778
302352	1.000	2633	301778
302353	3.000	2634	301778
302354	1.000	2623	301779
302355	1.000	2624	301779
302356	1.000	2625	301779
302357	1.000	2626	301779
302358	1.000	2627	301779
302359	1.000	2628	301779
302360	1.000	2629	301779
302361	6.000	2630	301779
302362	1.000	2631	301779
302363	1.000	2632	301779
302364	1.000	2633	301779
302365	3.000	2634	301779
302892	1.000	2960	301977
302893	1.000	2961	301977
302894	1.000	2962	301977
302895	3.000	2963	301977
302896	12.000	2964	301977
303260	1.000	3104	302055
303261	1.000	3105	302055
303262	1.000	3106	302055
303263	1.000	3104	302056
303264	1.000	3105	302056
303265	1.000	3106	302056
303266	1.000	3104	302057
303267	1.000	3105	302057
303268	1.000	3106	302057
303269	1.000	3104	302058
303270	1.000	3105	302058
303271	1.000	3106	302058
303272	1.000	3104	302059
303273	1.000	3105	302059
303274	1.000	3106	302059
305460	1.000	3720	302674
305461	5.000	3721	302674
305462	3.000	3722	302674
305463	2.000	3723	302674
305464	1.000	3724	302674
305465	1.000	3725	302674
305466	1.000	3726	302674
305467	1.000	3727	302674
305468	1.000	3728	302674
305469	1.000	3729	302674
305470	2.000	3730	302674
305471	1.000	3731	302674
305472	1.000	3732	302674
305473	6.000	3716	302675
305474	4.000	3717	302675
305475	1.000	3718	302675
305476	17.000	3719	302675
305477	1.000	3720	302675
305478	5.000	3721	302675
305479	3.000	3722	302675
305480	2.000	3723	302675
305481	1.000	3724	302675
305482	1.000	3725	302675
305483	1.000	3726	302675
305484	1.000	3727	302675
305485	1.000	3728	302675
305486	1.000	3729	302675
305487	2.000	3730	302675
305488	1.000	3731	302675
305489	1.000	3732	302675
305490	6.000	3716	302676
305491	4.000	3717	302676
305492	1.000	3718	302676
305493	17.000	3719	302676
305494	1.000	3720	302676
305495	5.000	3721	302676
305496	3.000	3722	302676
305497	2.000	3723	302676
305498	1.000	3724	302676
305499	1.000	3725	302676
305500	1.000	3726	302676
305501	1.000	3727	302676
305502	1.000	3728	302676
305503	1.000	3729	302676
305504	2.000	3730	302676
305505	1.000	3731	302676
305506	1.000	3732	302676
305507	6.000	3716	302677
305508	4.000	3717	302677
305509	1.000	3718	302677
305510	17.000	3719	302677
305511	1.000	3720	302677
305512	5.000	3721	302677
305513	3.000	3722	302677
305514	2.000	3723	302677
305515	1.000	3724	302677
305516	1.000	3725	302677
305517	1.000	3726	302677
305518	1.000	3727	302677
305519	1.000	3728	302677
305520	1.000	3729	302677
305521	2.000	3730	302677
305522	1.000	3731	302677
300317	3.000	2260	301345
300318	1.000	2261	301345
300319	1.000	2262	301345
300320	4.000	2273	301345
300321	4.000	2274	301345
300322	4.000	2258	301345
300323	20.000	2263	301345
300324	10.000	2264	301345
300325	12.000	2259	301345
300326	2.000	2265	301345
300327	1.000	2266	301345
300328	1.000	2267	301345
300329	1.000	2268	301345
300330	6.000	2269	301345
300331	6.000	2270	301345
300332	6.000	2271	301345
300333	6.000	2272	301345
301624	1.000	2528	301586
301913	3.000	2760	301730
302366	1.000	2635	301780
302367	3.000	2636	301780
302368	1.000	2637	301780
302369	1.000	2638	301780
302370	1.000	2639	301780
302371	3.000	2640	301780
302372	3.000	2641	301780
302373	5.000	2642	301780
302374	1.000	2643	301780
302375	1.000	2644	301780
302376	3.000	2645	301780
302377	1.000	2646	301780
302378	1.000	2647	301780
302379	5.000	2648	301780
302380	3.000	2649	301780
302381	1.000	2635	301781
302382	3.000	2636	301781
302383	1.000	2637	301781
302384	1.000	2638	301781
302385	1.000	2639	301781
302386	3.000	2640	301781
302387	3.000	2641	301781
302388	5.000	2642	301781
302389	1.000	2643	301781
302390	1.000	2644	301781
302391	3.000	2645	301781
302392	1.000	2646	301781
302393	1.000	2647	301781
302394	5.000	2648	301781
302395	3.000	2649	301781
302897	2.000	2843	301978
302898	2.000	2844	301978
302899	1.000	2845	301978
302900	12.000	2846	301978
302901	12.000	2847	301978
302902	3.000	2848	301978
302903	2.000	2849	301978
302904	12.000	2850	301978
302905	10.000	2851	301978
303275	1.000	3060	302060
303276	1.000	3061	302060
303277	1.000	3062	302060
303278	2.000	3063	302060
303279	1.000	3064	302060
303280	1.000	3065	302060
303281	12.000	3066	302060
303282	1.000	3067	302060
303283	1.000	3068	302060
305523	1.000	3732	302677
305524	6.000	3716	302678
305525	4.000	3717	302678
305526	1.000	3718	302678
305527	17.000	3719	302678
305528	1.000	3720	302678
305529	5.000	3721	302678
305530	3.000	3722	302678
305531	2.000	3723	302678
305532	1.000	3724	302678
305533	1.000	3725	302678
305534	1.000	3726	302678
305535	1.000	3727	302678
305536	1.000	3728	302678
305537	1.000	3729	302678
305538	2.000	3730	302678
305539	1.000	3731	302678
305540	1.000	3732	302678
305541	6.000	3716	302679
305542	4.000	3717	302679
305543	1.000	3718	302679
305544	17.000	3719	302679
305545	1.000	3720	302679
305546	5.000	3721	302679
305547	3.000	3722	302679
305548	2.000	3723	302679
305549	1.000	3724	302679
305550	1.000	3725	302679
305551	1.000	3726	302679
305552	1.000	3727	302679
305553	1.000	3728	302679
305554	1.000	3729	302679
305555	2.000	3730	302679
305556	1.000	3731	302679
305557	1.000	3732	302679
305558	6.000	3716	302680
305559	4.000	3717	302680
305560	1.000	3718	302680
305561	17.000	3719	302680
305562	1.000	3720	302680
305563	5.000	3721	302680
305564	3.000	3722	302680
305565	2.000	3723	302680
305566	1.000	3724	302680
305567	1.000	3725	302680
305568	1.000	3726	302680
305569	1.000	3727	302680
305570	1.000	3728	302680
305571	1.000	3729	302680
305572	2.000	3730	302680
305573	1.000	3731	302680
305574	1.000	3732	302680
305575	6.000	3716	302681
305576	4.000	3717	302681
305577	1.000	3718	302681
305578	17.000	3719	302681
305579	1.000	3720	302681
305580	5.000	3721	302681
305581	3.000	3722	302681
305582	2.000	3723	302681
305583	1.000	3724	302681
305584	1.000	3725	302681
305585	1.000	3726	302681
305586	1.000	3727	302681
305587	1.000	3728	302681
305588	1.000	3729	302681
305589	2.000	3730	302681
305590	1.000	3731	302681
305591	1.000	3732	302681
300334	12.000	2276	301347
300335	12.000	2277	301347
300336	6.000	2278	301347
300337	1.000	2279	301347
300338	12.000	2280	301347
300339	6.000	2275	301347
300340	3.000	2281	301347
300341	2.000	2282	301347
300342	3.000	2283	301347
300343	6.000	2284	301347
301625	1.000	2529	301588
301914	3.000	2761	301731
302906	1.000	2814	301979
302907	1.000	2815	301979
302908	6.000	2816	301979
302909	3.000	2817	301979
302910	6.000	2818	301979
302911	12.000	2819	301979
302912	1.000	2820	301979
302913	6.000	2821	301979
302914	3.000	2822	301979
302915	3.000	2823	301979
302916	1.000	2824	301979
302917	6.000	2825	301979
302918	6.000	2826	301979
302919	1.000	2827	301979
302920	1.000	2828	301979
302921	3.000	2829	301979
302922	6.000	2830	301979
302923	1.000	2831	301979
302924	3.000	2832	301979
302925	1.000	2814	301980
302926	1.000	2815	301980
302927	6.000	2816	301980
302928	3.000	2817	301980
302929	6.000	2818	301980
302930	12.000	2819	301980
302931	1.000	2820	301980
302932	6.000	2821	301980
302933	3.000	2822	301980
302934	3.000	2823	301980
302935	1.000	2824	301980
302936	6.000	2825	301980
302937	6.000	2826	301980
302938	1.000	2827	301980
302939	1.000	2828	301980
302940	3.000	2829	301980
302941	6.000	2830	301980
302942	1.000	2831	301980
302943	3.000	2832	301980
303284	31.000	3091	302061
303285	31.000	3091	302062
303286	31.000	3091	302063
303287	31.000	3091	302064
305592	6.000	3716	302682
305593	4.000	3717	302682
305594	1.000	3718	302682
305595	17.000	3719	302682
305596	1.000	3720	302682
305597	5.000	3721	302682
305598	3.000	3722	302682
305599	2.000	3723	302682
305600	1.000	3724	302682
305601	1.000	3725	302682
305602	1.000	3726	302682
305603	1.000	3727	302682
305604	1.000	3728	302682
305605	1.000	3729	302682
305606	2.000	3730	302682
305607	1.000	3731	302682
305608	1.000	3732	302682
305609	6.000	3716	302683
305610	4.000	3717	302683
305611	1.000	3718	302683
305612	17.000	3719	302683
305613	1.000	3720	302683
305614	5.000	3721	302683
305615	3.000	3722	302683
305616	2.000	3723	302683
305617	1.000	3724	302683
305618	1.000	3725	302683
305619	1.000	3726	302683
305620	1.000	3727	302683
305621	1.000	3728	302683
305622	1.000	3729	302683
305623	2.000	3730	302683
305624	1.000	3731	302683
305625	1.000	3732	302683
305626	6.000	3716	302684
305627	4.000	3717	302684
305628	1.000	3718	302684
305629	17.000	3719	302684
305630	1.000	3720	302684
305631	5.000	3721	302684
305632	3.000	3722	302684
305633	2.000	3723	302684
305634	1.000	3724	302684
305635	1.000	3725	302684
305636	1.000	3726	302684
305637	1.000	3727	302684
305638	1.000	3728	302684
305639	1.000	3729	302684
305640	2.000	3730	302684
305641	1.000	3731	302684
305642	1.000	3732	302684
300344	1.000	2293	301350
300345	1.000	2285	301350
300346	12.000	2286	301350
300347	3.000	2287	301350
300348	1.000	2288	301350
300349	3.000	2289	301350
300350	1.000	2290	301350
300351	1.000	2291	301350
300352	3.000	2292	301350
300353	6.000	2294	301350
300354	1.000	2293	301351
300355	1.000	2285	301351
300356	12.000	2286	301351
300357	3.000	2287	301351
300358	1.000	2288	301351
300359	3.000	2289	301351
300360	1.000	2290	301351
300361	1.000	2291	301351
300362	3.000	2292	301351
300363	6.000	2294	301351
301626	2.000	2530	301590
301915	3.000	2763	301732
302398	1.000	2801	301940
302399	1.000	2801	301941
302400	1.000	2801	301942
302944	12.000	2894	301981
302945	1.000	2895	301981
302946	12.000	2896	301981
302947	1.000	2897	301981
302948	12.000	2898	301981
302949	12.000	2899	301981
302950	12.000	2900	301981
302951	12.000	2901	301981
303288	1.000	3101	302065
303289	1.000	3102	302065
303290	1.000	3103	302065
303291	1.000	3101	302066
303292	1.000	3102	302066
303293	1.000	3103	302066
303294	1.000	3101	302067
303295	1.000	3102	302067
303296	1.000	3103	302067
303297	1.000	3101	302068
303298	1.000	3102	302068
303299	1.000	3103	302068
303300	1.000	3101	302069
303301	1.000	3102	302069
303302	1.000	3103	302069
303303	1.000	3101	302070
303304	1.000	3102	302070
303305	1.000	3103	302070
300364	12.000	2300	301454
301627	2.000	2533	301592
301628	24.000	2534	301592
301629	6.000	2532	301592
301630	1.000	2531	301592
301916	3.000	2764	301733
302401	1.000	2792	301943
302402	1.000	2793	301943
302403	1.000	2792	301944
302404	1.000	2793	301944
302405	1.000	2792	301945
302406	1.000	2793	301945
302407	1.000	2792	301946
302408	1.000	2793	301946
302952	6.000	2932	301982
302953	6.000	2933	301982
302954	1.000	2934	301982
302955	2.000	2935	301982
302956	2.000	2936	301982
302957	6.000	2937	301982
302958	6.000	2938	301982
302959	1.000	2939	301982
302960	3.000	2940	301982
302961	3.000	2941	301982
302962	6.000	2932	301983
302963	6.000	2933	301983
302964	1.000	2934	301983
302965	2.000	2935	301983
302966	2.000	2936	301983
302967	6.000	2937	301983
302968	6.000	2938	301983
302969	1.000	2939	301983
302970	3.000	2940	301983
302971	3.000	2941	301983
303306	1.000	3094	302071
300365	18.000	2301	301455
301631	2.000	2536	301594
301632	12.000	2537	301594
301633	12.000	2538	301594
301634	1.000	2535	301594
301917	3.000	2762	301734
302409	2.000	3039	301947
302410	2.000	3040	301947
302411	1.000	3041	301947
302972	3.000	2833	301984
302973	1.000	2834	301984
302974	1.000	2835	301984
302975	12.000	2836	301984
302976	6.000	2837	301984
302977	12.000	2838	301984
302978	1.000	2839	301984
302979	3.000	2840	301984
302980	6.000	2841	301984
302981	1.000	2842	301984
302982	3.000	2833	301985
302983	1.000	2834	301985
302984	1.000	2835	301985
302985	12.000	2836	301985
302986	6.000	2837	301985
302987	12.000	2838	301985
302988	1.000	2839	301985
302989	3.000	2840	301985
302990	6.000	2841	301985
302991	1.000	2842	301985
303307	1.000	3095	302072
300366	1.000	2295	301456
300367	6.000	2296	301456
300368	6.000	2297	301456
300369	1.000	2298	301456
300370	1.000	2299	301456
301635	100.000	2539	301596
301918	1.000	2752	301735
301919	2.000	2753	301735
301920	2.000	2754	301735
301921	3.000	2755	301735
301922	3.000	2756	301735
301923	6.000	2757	301735
301924	12.000	2758	301735
302992	12.000	2902	301986
302993	3.000	2903	301986
302994	2.000	2904	301986
302995	12.000	2905	301986
302996	12.000	2906	301986
302997	6.000	2907	301986
302998	12.000	2908	301986
302999	12.000	2909	301986
303000	12.000	2910	301986
303001	12.000	2911	301986
303002	1.000	2912	301986
303003	12.000	2913	301986
303004	1.000	2914	301986
300371	6.000	2311	301457
300372	6.000	2312	301457
300373	4.000	2313	301457
300374	1.000	2314	301457
300375	6.000	2315	301457
300376	6.000	2316	301457
300377	4.000	2317	301457
300378	6.000	2318	301457
300379	4.000	2319	301457
300380	6.000	2320	301457
301636	1.000	2544	301598
301637	12.000	2545	301598
301638	1.000	2542	301598
301639	1.000	2543	301598
301640	1.000	2541	301598
301641	1.000	2540	301598
301925	36.000	2741	301736
302508	1.000	3023	301954
302509	1.000	3024	301954
302510	1.000	3025	301954
302511	1.000	3026	301954
302512	1.000	3027	301954
302513	1.000	3028	301954
302514	1.000	3029	301954
302515	1.000	3030	301954
302516	1.000	3031	301954
302517	1.000	3032	301954
302518	1.000	3033	301954
302519	1.000	3034	301954
302520	1.000	3035	301954
302521	1.000	3036	301954
302522	1.000	3037	301954
302523	1.000	3038	301954
302524	1.000	3023	301955
302525	1.000	3024	301955
302526	1.000	3025	301955
302527	1.000	3026	301955
302528	1.000	3027	301955
302529	1.000	3028	301955
302530	1.000	3029	301955
302531	1.000	3030	301955
302532	1.000	3031	301955
302533	1.000	3032	301955
302534	1.000	3033	301955
302535	1.000	3034	301955
302536	1.000	3035	301955
302537	1.000	3036	301955
302538	1.000	3037	301955
302539	1.000	3038	301955
302540	1.000	3023	301956
302541	1.000	3024	301956
302542	1.000	3025	301956
302543	1.000	3026	301956
302544	1.000	3027	301956
302545	1.000	3028	301956
302546	1.000	3029	301956
302547	1.000	3030	301956
302548	1.000	3031	301956
302549	1.000	3032	301956
302550	1.000	3033	301956
302551	1.000	3034	301956
302552	1.000	3035	301956
302553	1.000	3036	301956
302554	1.000	3037	301956
302555	1.000	3038	301956
302556	1.000	3023	301957
302557	1.000	3024	301957
302558	1.000	3025	301957
302559	1.000	3026	301957
302560	1.000	3027	301957
302561	1.000	3028	301957
302562	1.000	3029	301957
302563	1.000	3030	301957
302564	1.000	3031	301957
302565	1.000	3032	301957
302566	1.000	3033	301957
302567	1.000	3034	301957
302568	1.000	3035	301957
302569	1.000	3036	301957
302570	1.000	3037	301957
302571	1.000	3038	301957
302572	1.000	3023	301958
302573	1.000	3024	301958
302574	1.000	3025	301958
302575	1.000	3026	301958
302576	1.000	3027	301958
302577	1.000	3028	301958
302578	1.000	3029	301958
302579	1.000	3030	301958
302580	1.000	3031	301958
302581	1.000	3032	301958
302582	1.000	3033	301958
302583	1.000	3034	301958
302584	1.000	3035	301958
302585	1.000	3036	301958
302586	1.000	3037	301958
302587	1.000	3038	301958
302588	1.000	3023	301959
302589	1.000	3024	301959
302590	1.000	3025	301959
302591	1.000	3026	301959
302592	1.000	3027	301959
302593	1.000	3028	301959
302594	1.000	3029	301959
302595	1.000	3030	301959
302596	1.000	3031	301959
302597	1.000	3032	301959
302598	1.000	3033	301959
302599	1.000	3034	301959
302600	1.000	3035	301959
302601	1.000	3036	301959
302602	1.000	3037	301959
302603	1.000	3038	301959
303005	6.000	2919	301987
303006	1.000	2915	301987
303007	6.000	2916	301987
303008	1.000	2917	301987
303009	1.000	2918	301987
303010	1.000	2920	301987
303011	1.000	2921	301987
303012	2.000	2922	301987
303013	2.000	2923	301987
303014	1.000	2924	301987
303015	1.000	2925	301987
303016	2.000	2926	301987
303017	1.000	2927	301987
303018	1.000	2928	301987
303019	2.000	2929	301987
303020	1.000	2930	301987
303021	1.000	2931	301987
303022	6.000	2919	301988
303023	1.000	2915	301988
303024	6.000	2916	301988
303025	1.000	2917	301988
303026	1.000	2918	301988
303027	1.000	2920	301988
300381	1.000	2321	301458
300382	1.000	2322	301458
300383	10.000	2323	301458
300384	1.000	2324	301458
300385	1.000	2325	301458
301926	3.000	2729	301737
301927	6.000	2730	301737
301928	2.000	2731	301737
301929	2.000	2732	301737
301930	2.000	2733	301737
301931	2.000	2734	301737
303028	1.000	2921	301988
303029	2.000	2922	301988
303030	2.000	2923	301988
303031	1.000	2924	301988
303032	1.000	2925	301988
303033	2.000	2926	301988
303034	1.000	2927	301988
303035	1.000	2928	301988
303036	2.000	2929	301988
303037	1.000	2930	301988
303038	1.000	2931	301988
303309	1.000	3096	302074
300386	4.000	2302	301459
300387	8.000	2303	301459
300388	4.000	2304	301459
300389	1.000	2305	301459
300390	14.000	2306	301459
300391	4.000	2307	301459
300392	4.000	2308	301459
300393	16.000	2309	301459
300394	4.000	2310	301459
300395	4.000	2302	301460
300396	8.000	2303	301460
300397	4.000	2304	301460
300398	1.000	2305	301460
300399	14.000	2306	301460
300400	4.000	2307	301460
300401	4.000	2308	301460
300402	16.000	2309	301460
300403	4.000	2310	301460
300404	4.000	2302	301461
300405	8.000	2303	301461
300406	4.000	2304	301461
300407	1.000	2305	301461
300408	14.000	2306	301461
300409	4.000	2307	301461
300410	4.000	2308	301461
300411	16.000	2309	301461
300412	4.000	2310	301461
301647	6.000	2555	301689
301648	12.000	2556	301689
301649	12.000	2557	301689
301650	6.000	2558	301689
301651	6.000	2559	301689
301932	1.000	2739	301738
301933	1.000	2740	301738
301934	1.000	2735	301738
301935	1.000	2736	301738
301936	1.000	2737	301738
301937	4.000	2738	301738
301938	1.000	2739	301739
301939	1.000	2740	301739
301940	1.000	2735	301739
301941	1.000	2736	301739
301942	1.000	2737	301739
301943	4.000	2738	301739
301944	1.000	2739	301740
301945	1.000	2740	301740
301946	1.000	2735	301740
301947	1.000	2736	301740
301948	1.000	2737	301740
301949	4.000	2738	301740
301950	1.000	2739	301741
301951	1.000	2740	301741
301952	1.000	2735	301741
301953	1.000	2736	301741
301954	1.000	2737	301741
301955	4.000	2738	301741
301956	1.000	2739	301742
301957	1.000	2740	301742
301958	1.000	2735	301742
301959	1.000	2736	301742
301960	1.000	2737	301742
301961	4.000	2738	301742
303039	1.000	2973	301989
303040	1.000	2974	301989
303041	1.000	2975	301989
303042	2.000	2976	301989
303043	1.000	2977	301989
303044	1.000	2978	301989
303045	4.000	2979	301989
303046	2.000	2980	301989
303047	2.000	2981	301989
303048	2.000	2982	301989
303049	2.000	2983	301989
303050	1.000	2984	301989
303051	1.000	2985	301989
303052	2.000	2986	301989
303053	2.000	2987	301989
303054	4.000	2988	301989
303055	1.000	2989	301989
303056	1.000	2990	301989
303057	2.000	2991	301989
303058	2.000	2992	301989
303059	1.000	2993	301989
303060	2.000	2994	301989
303061	2.000	2995	301989
303062	1.000	2996	301989
303063	1.000	2997	301989
303064	4.000	2998	301989
303065	2.000	2999	301989
303066	1.000	3000	301989
303067	1.000	3001	301989
303068	1.000	3002	301989
303069	2.000	3003	301989
303070	2.000	3004	301989
303071	2.000	3005	301989
303072	1.000	3006	301989
303073	2.000	3007	301989
303074	2.000	3008	301989
303075	1.000	3009	301989
303076	1.000	3010	301989
303077	2.000	3011	301989
303078	1.000	2973	301990
303079	1.000	2974	301990
303080	1.000	2975	301990
303081	2.000	2976	301990
303082	1.000	2977	301990
303083	1.000	2978	301990
303084	4.000	2979	301990
303085	2.000	2980	301990
303086	2.000	2981	301990
303087	2.000	2982	301990
303088	2.000	2983	301990
303089	1.000	2984	301990
303090	1.000	2985	301990
303091	2.000	2986	301990
303092	2.000	2987	301990
303093	4.000	2988	301990
303094	1.000	2989	301990
303095	1.000	2990	301990
303096	2.000	2991	301990
303097	2.000	2992	301990
303098	1.000	2993	301990
303099	2.000	2994	301990
303100	2.000	2995	301990
303101	1.000	2996	301990
303102	1.000	2997	301990
303103	4.000	2998	301990
303104	2.000	2999	301990
303105	1.000	3000	301990
303106	1.000	3001	301990
303107	1.000	3002	301990
303108	2.000	3003	301990
303109	2.000	3004	301990
303110	2.000	3005	301990
303111	1.000	3006	301990
303112	2.000	3007	301990
300413	2.000	2326	301462
300414	1.000	2327	301462
301652	12.000	2560	301690
301962	3.000	2724	301743
301963	1.000	2725	301743
301964	3.000	2726	301743
301965	1.000	2727	301743
301966	1.000	2728	301743
301967	3.000	2724	301744
301968	1.000	2725	301744
301969	3.000	2726	301744
301970	1.000	2727	301744
301971	1.000	2728	301744
303113	2.000	3008	301990
303114	1.000	3009	301990
303115	1.000	3010	301990
303116	2.000	3011	301990
303117	1.000	2973	301991
303118	1.000	2974	301991
303119	1.000	2975	301991
303120	2.000	2976	301991
303121	1.000	2977	301991
303122	1.000	2978	301991
303123	4.000	2979	301991
303124	2.000	2980	301991
303125	2.000	2981	301991
303126	2.000	2982	301991
303127	2.000	2983	301991
303128	1.000	2984	301991
303129	1.000	2985	301991
303130	2.000	2986	301991
303131	2.000	2987	301991
303132	4.000	2988	301991
303133	1.000	2989	301991
303134	1.000	2990	301991
303135	2.000	2991	301991
303136	2.000	2992	301991
303137	1.000	2993	301991
303138	2.000	2994	301991
303139	2.000	2995	301991
303140	1.000	2996	301991
303141	1.000	2997	301991
303142	4.000	2998	301991
303143	2.000	2999	301991
303144	1.000	3000	301991
303145	1.000	3001	301991
303146	1.000	3002	301991
303147	2.000	3003	301991
303148	2.000	3004	301991
303149	2.000	3005	301991
303150	1.000	3006	301991
303151	2.000	3007	301991
303152	2.000	3008	301991
303153	1.000	3009	301991
303154	1.000	3010	301991
303155	2.000	3011	301991
303156	1.000	2973	301992
303157	1.000	2974	301992
303158	1.000	2975	301992
303159	2.000	2976	301992
303160	1.000	2977	301992
303161	1.000	2978	301992
303162	4.000	2979	301992
303163	2.000	2980	301992
303164	2.000	2981	301992
303165	2.000	2982	301992
303166	2.000	2983	301992
303167	1.000	2984	301992
303168	1.000	2985	301992
303169	2.000	2986	301992
303170	2.000	2987	301992
303171	4.000	2988	301992
303172	1.000	2989	301992
303173	1.000	2990	301992
303174	2.000	2991	301992
303175	2.000	2992	301992
303176	1.000	2993	301992
303177	2.000	2994	301992
303178	2.000	2995	301992
303179	1.000	2996	301992
303180	1.000	2997	301992
303181	4.000	2998	301992
303182	2.000	2999	301992
303183	1.000	3000	301992
303184	1.000	3001	301992
303185	1.000	3002	301992
303186	2.000	3003	301992
303187	2.000	3004	301992
303188	2.000	3005	301992
303189	1.000	3006	301992
303190	2.000	3007	301992
303191	2.000	3008	301992
303192	1.000	3009	301992
303193	1.000	3010	301992
303194	2.000	3011	301992
303195	1.000	2973	301993
303196	1.000	2974	301993
303197	1.000	2975	301993
303198	2.000	2976	301993
303199	1.000	2977	301993
303200	1.000	2978	301993
303201	4.000	2979	301993
303202	2.000	2980	301993
303203	2.000	2981	301993
303204	2.000	2982	301993
303205	2.000	2983	301993
303206	1.000	2984	301993
303207	1.000	2985	301993
303208	2.000	2986	301993
303209	2.000	2987	301993
303210	4.000	2988	301993
303211	1.000	2989	301993
303212	1.000	2990	301993
303213	2.000	2991	301993
303214	2.000	2992	301993
303215	1.000	2993	301993
303216	2.000	2994	301993
303217	2.000	2995	301993
303218	1.000	2996	301993
303219	1.000	2997	301993
303220	4.000	2998	301993
303221	2.000	2999	301993
303222	1.000	3000	301993
303223	1.000	3001	301993
303224	1.000	3002	301993
303225	2.000	3003	301993
303226	2.000	3004	301993
303227	2.000	3005	301993
303228	1.000	3006	301993
303229	2.000	3007	301993
303230	2.000	3008	301993
303231	1.000	3009	301993
303232	1.000	3010	301993
303233	2.000	3011	301993
303310	1.000	3109	302078
300415	6.000	2508	301476
300416	6.000	2509	301476
300417	2.000	2510	301476
300418	1.000	2511	301476
300419	12.000	2507	301476
301653	6.000	2561	301691
301654	12.000	2562	301691
301655	12.000	2563	301691
301656	4.000	2564	301691
301657	6.000	2565	301691
301658	6.000	2566	301691
301972	1.000	2708	301745
301973	2.000	2709	301745
301974	1.000	2710	301745
301975	1.000	2711	301745
301976	1.000	2712	301745
301977	2.000	2713	301745
301978	2.000	2714	301745
301979	1.000	2715	301745
301980	1.000	2716	301745
301981	1.000	2717	301745
301982	1.000	2718	301745
301983	1.000	2719	301745
301984	1.000	2720	301745
301985	1.000	2721	301745
301986	2.000	2722	301745
301987	1.000	2723	301745
301988	1.000	2708	301746
301989	2.000	2709	301746
301990	1.000	2710	301746
301991	1.000	2711	301746
301992	1.000	2712	301746
301993	2.000	2713	301746
301994	2.000	2714	301746
301995	1.000	2715	301746
301996	1.000	2716	301746
301997	1.000	2717	301746
301998	1.000	2718	301746
301999	1.000	2719	301746
302000	1.000	2720	301746
302001	1.000	2721	301746
302002	2.000	2722	301746
302003	1.000	2723	301746
302004	1.000	2708	301747
302005	2.000	2709	301747
302006	1.000	2710	301747
302007	1.000	2711	301747
302008	1.000	2712	301747
302009	2.000	2713	301747
302010	2.000	2714	301747
302011	1.000	2715	301747
302012	1.000	2716	301747
302013	1.000	2717	301747
302014	1.000	2718	301747
302015	1.000	2719	301747
302016	1.000	2720	301747
302017	1.000	2721	301747
302018	2.000	2722	301747
302019	1.000	2723	301747
302020	1.000	2708	301748
302021	2.000	2709	301748
302022	1.000	2710	301748
302023	1.000	2711	301748
302024	1.000	2712	301748
302025	2.000	2713	301748
302026	2.000	2714	301748
302027	1.000	2715	301748
302028	1.000	2716	301748
302029	1.000	2717	301748
302030	1.000	2718	301748
302031	1.000	2719	301748
302032	1.000	2720	301748
302033	1.000	2721	301748
302034	2.000	2722	301748
302035	1.000	2723	301748
302036	1.000	2708	301749
302037	2.000	2709	301749
302038	1.000	2710	301749
302039	1.000	2711	301749
302040	1.000	2712	301749
302041	2.000	2713	301749
302042	2.000	2714	301749
302043	1.000	2715	301749
302044	1.000	2716	301749
302045	1.000	2717	301749
302046	1.000	2718	301749
302047	1.000	2719	301749
302048	1.000	2720	301749
302049	1.000	2721	301749
302050	2.000	2722	301749
302051	1.000	2723	301749
302052	1.000	2708	301750
302053	2.000	2709	301750
302054	1.000	2710	301750
302055	1.000	2711	301750
302056	1.000	2712	301750
302057	2.000	2713	301750
302058	2.000	2714	301750
302059	1.000	2715	301750
302060	1.000	2716	301750
302061	1.000	2717	301750
302062	1.000	2718	301750
302063	1.000	2719	301750
302064	1.000	2720	301750
302065	1.000	2721	301750
302066	2.000	2722	301750
302067	1.000	2723	301750
303311	1.000	3100	302079
300420	1.000	2513	301490
300421	1.000	2514	301490
300422	12.000	2512	301490
301659	1.000	2584	301692
301660	1.000	2585	301692
301661	1.000	2586	301692
301662	1.000	2587	301692
301663	1.000	2588	301692
301664	1.000	2589	301692
301665	1.000	2590	301692
301666	1.000	2591	301692
301667	1.000	2592	301692
301668	1.000	2584	301693
301669	1.000	2585	301693
301670	1.000	2586	301693
301671	1.000	2587	301693
301672	1.000	2588	301693
301673	1.000	2589	301693
301674	1.000	2590	301693
301675	1.000	2591	301693
301676	1.000	2592	301693
301677	1.000	2584	301694
301678	1.000	2585	301694
301679	1.000	2586	301694
301680	1.000	2587	301694
301681	1.000	2588	301694
301682	1.000	2589	301694
301683	1.000	2590	301694
301684	1.000	2591	301694
301685	1.000	2592	301694
301686	1.000	2584	301695
301687	1.000	2585	301695
301688	1.000	2586	301695
301689	1.000	2587	301695
301690	1.000	2588	301695
301691	1.000	2589	301695
301692	1.000	2590	301695
301693	1.000	2591	301695
301694	1.000	2592	301695
301695	1.000	2584	301696
301696	1.000	2585	301696
301697	1.000	2586	301696
301698	1.000	2587	301696
301699	1.000	2588	301696
301700	1.000	2589	301696
301701	1.000	2590	301696
301702	1.000	2591	301696
301703	1.000	2592	301696
301704	1.000	2584	301697
301705	1.000	2585	301697
301706	1.000	2586	301697
301707	1.000	2587	301697
301708	1.000	2588	301697
301709	1.000	2589	301697
301710	1.000	2590	301697
301711	1.000	2591	301697
301712	1.000	2592	301697
302068	1.000	2742	301751
302069	12.000	2743	301751
302070	12.000	2744	301751
302071	12.000	2745	301751
302072	12.000	2746	301751
302073	12.000	2747	301751
302074	12.000	2748	301751
302075	1.000	2749	301751
302076	12.000	2750	301751
302077	2.000	2751	301751
303312	1.000	3098	302080
300423	2.000	2328	301491
300424	5.000	2329	301491
300425	3.000	2330	301491
300426	1.000	2331	301491
300427	2.000	2332	301491
300428	1.000	2333	301491
300429	10.000	2334	301491
300430	10.000	2335	301491
300431	10.000	2336	301491
300432	10.000	2337	301491
300433	4.000	2338	301491
300434	5.000	2339	301491
300435	2.000	2340	301491
300436	6.000	2341	301491
300437	3.000	2342	301491
301713	4.000	2594	301698
302078	1.000	2766	301752
302079	1.000	2767	301752
302080	1.000	2768	301752
302081	1.000	2769	301752
302082	1.000	2770	301752
302083	1.000	2771	301752
302084	1.000	2772	301752
302085	1.000	2773	301752
302086	1.000	2774	301752
302087	1.000	2775	301752
302088	1.000	2776	301752
302089	1.000	2777	301752
302090	1.000	2778	301752
302091	1.000	2779	301752
302092	1.000	2780	301752
302093	1.000	2781	301752
302094	1.000	2782	301752
302095	1.000	2783	301752
302096	1.000	2784	301752
302097	1.000	2785	301752
302098	1.000	2786	301752
302099	1.000	2766	301753
302100	1.000	2767	301753
302101	1.000	2768	301753
302102	1.000	2769	301753
302103	1.000	2770	301753
302104	1.000	2771	301753
302105	1.000	2772	301753
302106	1.000	2773	301753
302107	1.000	2774	301753
302108	1.000	2775	301753
302109	1.000	2776	301753
302110	1.000	2777	301753
302111	1.000	2778	301753
302112	1.000	2779	301753
302113	1.000	2780	301753
302114	1.000	2781	301753
302115	1.000	2782	301753
302116	1.000	2783	301753
302117	1.000	2784	301753
302118	1.000	2785	301753
302119	1.000	2786	301753
302120	1.000	2766	301754
302121	1.000	2767	301754
302122	1.000	2768	301754
302123	1.000	2769	301754
302124	1.000	2770	301754
302125	1.000	2771	301754
302126	1.000	2772	301754
302127	1.000	2773	301754
302128	1.000	2774	301754
302129	1.000	2775	301754
302130	1.000	2776	301754
302131	1.000	2777	301754
302132	1.000	2778	301754
302133	1.000	2779	301754
302134	1.000	2780	301754
302135	1.000	2781	301754
302136	1.000	2782	301754
302137	1.000	2783	301754
302138	1.000	2784	301754
302139	1.000	2785	301754
302140	1.000	2786	301754
302141	1.000	2766	301755
302142	1.000	2767	301755
302143	1.000	2768	301755
302144	1.000	2769	301755
302145	1.000	2770	301755
302146	1.000	2771	301755
302147	1.000	2772	301755
302148	1.000	2773	301755
302149	1.000	2774	301755
302150	1.000	2775	301755
302151	1.000	2776	301755
302152	1.000	2777	301755
302153	1.000	2778	301755
302154	1.000	2779	301755
302155	1.000	2780	301755
302156	1.000	2781	301755
302157	1.000	2782	301755
302158	1.000	2783	301755
302159	1.000	2784	301755
302160	1.000	2785	301755
302161	1.000	2786	301755
302162	1.000	2766	301756
302163	1.000	2767	301756
302164	1.000	2768	301756
302165	1.000	2769	301756
302166	1.000	2770	301756
302167	1.000	2771	301756
302168	1.000	2772	301756
302169	1.000	2773	301756
302170	1.000	2774	301756
302171	1.000	2775	301756
302172	1.000	2776	301756
302173	1.000	2777	301756
302174	1.000	2778	301756
302175	1.000	2779	301756
302176	1.000	2780	301756
302177	1.000	2781	301756
302178	1.000	2782	301756
302179	1.000	2783	301756
302180	1.000	2784	301756
302181	1.000	2785	301756
302182	1.000	2786	301756
302183	1.000	2766	301757
302184	1.000	2767	301757
302185	1.000	2768	301757
302186	1.000	2769	301757
302187	1.000	2770	301757
302188	1.000	2771	301757
302189	1.000	2772	301757
302190	1.000	2773	301757
302191	1.000	2774	301757
302192	1.000	2775	301757
302193	1.000	2776	301757
302194	1.000	2777	301757
302195	1.000	2778	301757
302196	1.000	2779	301757
302197	1.000	2780	301757
300438	2.000	2343	301492
300439	1.000	2344	301492
300440	12.000	2345	301492
300441	4.000	2346	301492
300442	6.000	2347	301492
300443	12.000	2348	301492
300444	10.000	2349	301492
300445	12.000	2350	301492
301714	10.000	2593	301699
301715	10.000	2593	301700
302198	1.000	2781	301757
302199	1.000	2782	301757
302200	1.000	2783	301757
302201	1.000	2784	301757
302202	1.000	2785	301757
302203	1.000	2786	301757
303313	1.000	3082	302081
303314	1.000	3083	302081
303315	1.000	3084	302081
303316	1.000	3085	302081
303317	3.000	3086	302081
303318	1.000	3087	302081
303319	6.000	3088	302081
303320	1.000	3089	302081
303321	1.000	3090	302081
303322	1.000	3082	302082
303323	1.000	3083	302082
303324	1.000	3084	302082
303325	1.000	3085	302082
303326	3.000	3086	302082
303327	1.000	3087	302082
303328	6.000	3088	302082
303329	1.000	3089	302082
303330	1.000	3090	302082
303331	1.000	3082	302083
303332	1.000	3083	302083
303333	1.000	3084	302083
303334	1.000	3085	302083
303335	3.000	3086	302083
303336	1.000	3087	302083
303337	6.000	3088	302083
303338	1.000	3089	302083
303339	1.000	3090	302083
303340	1.000	3082	302084
303341	1.000	3083	302084
303342	1.000	3084	302084
303343	1.000	3085	302084
303344	3.000	3086	302084
303345	1.000	3087	302084
303346	6.000	3088	302084
303347	1.000	3089	302084
303348	1.000	3090	302084
300446	12.000	2352	301493
300447	3.000	2353	301493
300448	1.000	2354	301493
300449	1.000	2355	301493
300450	1.000	2356	301493
300451	3.000	2357	301493
300452	24.000	2358	301493
300453	3.000	2359	301493
300454	3.000	2360	301493
300455	1.000	2361	301493
300456	1.000	2362	301493
300457	1.000	2363	301493
300458	1.000	2364	301493
300459	1.000	2365	301493
301716	6.000	2606	301701
301717	12.000	2607	301701
301718	12.000	2608	301701
301719	12.000	2609	301701
301720	6.000	2610	301701
301721	6.000	2611	301701
303349	4.000	3046	302085
303350	1.000	3047	302085
303351	1.000	3048	302085
303352	1.000	3049	302085
303353	2.000	3050	302085
303354	4.000	3051	302085
303355	4.000	3046	302086
303356	1.000	3047	302086
303357	1.000	3048	302086
303358	1.000	3049	302086
303359	2.000	3050	302086
303360	4.000	3051	302086
303361	4.000	3046	302087
303362	1.000	3047	302087
303363	1.000	3048	302087
303364	1.000	3049	302087
303365	2.000	3050	302087
303366	4.000	3051	302087
300460	1.000	2366	301494
300461	3.000	2367	301494
300462	1.000	2368	301494
300463	1.000	2366	301495
300464	3.000	2367	301495
300465	1.000	2368	301495
301722	2.000	2595	301702
301723	3.000	2596	301702
301724	1.000	2597	301702
301725	1.000	2598	301702
301726	3.000	2599	301702
301727	1.000	2600	301702
301728	2.000	2601	301702
301729	2.000	2602	301702
301730	1.000	2603	301702
301731	5.000	2604	301702
301732	5.000	2605	301702
301733	2.000	2595	301703
301734	3.000	2596	301703
301735	1.000	2597	301703
301736	1.000	2598	301703
301737	3.000	2599	301703
301738	1.000	2600	301703
301739	2.000	2601	301703
301740	2.000	2602	301703
301741	1.000	2603	301703
301742	5.000	2604	301703
301743	5.000	2605	301703
303367	12.000	3092	302088
303368	12.000	3093	302088
303369	12.000	3092	302089
303370	12.000	3093	302089
300466	1.000	2422	301496
300467	1.000	2423	301496
300468	1.000	2424	301496
300469	1.000	2422	301497
300470	1.000	2423	301497
300471	1.000	2424	301497
300472	1.000	2422	301498
300473	1.000	2423	301498
300474	1.000	2424	301498
300475	1.000	2422	301499
300476	1.000	2423	301499
300477	1.000	2424	301499
303371	1.000	3055	302090
303372	1.000	3056	302090
303373	1.000	3057	302090
303374	1.000	3055	302091
303375	1.000	3056	302091
303376	1.000	3057	302091
303377	1.000	3055	302092
303378	1.000	3056	302092
303379	1.000	3057	302092
303380	1.000	3055	302093
303381	1.000	3056	302093
303382	1.000	3057	302093
300478	2.000	2399	301500
300479	48.000	2398	301500
303383	1.000	3069	302094
303384	1.000	3070	302094
303385	1.000	3071	302094
303386	1.000	3072	302094
303387	1.000	3073	302094
303388	2.000	3074	302094
303389	2.000	3075	302094
303390	1.000	3076	302094
303391	2.000	3077	302094
303392	2.000	3078	302094
303393	1.000	3079	302094
303394	1.000	3069	302095
303395	1.000	3070	302095
303396	1.000	3071	302095
303397	1.000	3072	302095
303398	1.000	3073	302095
303399	2.000	3074	302095
303400	2.000	3075	302095
303401	1.000	3076	302095
303402	2.000	3077	302095
303403	2.000	3078	302095
303404	1.000	3079	302095
303405	1.000	3069	302096
303406	1.000	3070	302096
303407	1.000	3071	302096
303408	1.000	3072	302096
303409	1.000	3073	302096
303410	2.000	3074	302096
303411	2.000	3075	302096
303412	1.000	3076	302096
303413	2.000	3077	302096
303414	2.000	3078	302096
303415	1.000	3079	302096
300480	4.000	2515	301505
300481	4.000	2518	301505
300482	1.000	2516	301505
300483	1.000	2519	301505
300484	2.000	2520	301505
300485	1.000	2521	301505
300486	2.000	2522	301505
300487	1.000	2523	301505
300488	4.000	2517	301505
300489	4.000	2515	301506
300490	4.000	2518	301506
300491	1.000	2516	301506
300492	1.000	2519	301506
300493	2.000	2520	301506
300494	1.000	2521	301506
300495	2.000	2522	301506
300496	1.000	2523	301506
300497	4.000	2517	301506
300498	4.000	2515	301507
300499	4.000	2518	301507
300500	1.000	2516	301507
300501	1.000	2519	301507
300502	2.000	2520	301507
300503	1.000	2521	301507
300504	2.000	2522	301507
300505	1.000	2523	301507
300506	4.000	2517	301507
303416	12.000	3580	302311
300507	1.000	2369	301508
300508	3.000	2370	301508
300509	2.000	2371	301508
300510	1.000	2372	301508
300511	1.000	2373	301508
300512	1.000	2369	301509
300513	3.000	2370	301509
300514	2.000	2371	301509
300515	1.000	2372	301509
300516	1.000	2373	301509
300517	1.000	2369	301510
300518	3.000	2370	301510
300519	2.000	2371	301510
300520	1.000	2372	301510
300521	1.000	2373	301510
303417	1.000	3677	302312
303418	3.000	3678	302312
303419	1.000	3679	302312
303420	1.000	3680	302312
303421	1.000	3681	302312
303422	1.000	3677	302313
303423	3.000	3678	302313
303424	1.000	3679	302313
303425	1.000	3680	302313
303426	1.000	3681	302313
303427	1.000	3677	302314
303428	3.000	3678	302314
303429	1.000	3679	302314
303430	1.000	3680	302314
303431	1.000	3681	302314
303432	1.000	3677	302315
303433	3.000	3678	302315
303434	1.000	3679	302315
303435	1.000	3680	302315
303436	1.000	3681	302315
300522	1.000	2351	301511
300523	1.000	2351	301512
300524	1.000	2351	301513
300525	1.000	2351	301514
300526	1.000	2351	301515
300527	1.000	2351	301516
303437	6.000	3689	302316
303438	12.000	3690	302316
303439	1.000	3691	302316
303440	3.000	3428	302317
303441	3.000	3428	302318
300864	1.000	2374	301531
300865	1.000	2375	301531
300866	1.000	2376	301531
300867	1.000	2377	301531
300868	1.000	2378	301531
300869	1.000	2379	301531
300870	1.000	2380	301531
300871	1.000	2381	301531
300872	1.000	2382	301531
300873	1.000	2383	301531
300874	1.000	2384	301531
300875	1.000	2385	301531
300876	1.000	2386	301531
300877	1.000	2387	301531
300878	1.000	2388	301531
300879	1.000	2389	301531
300880	1.000	2390	301531
300881	1.000	2391	301531
300882	1.000	2392	301531
300883	1.000	2393	301531
300884	3.000	2394	301531
300885	1.000	2395	301531
300886	1.000	2396	301531
300887	1.000	2397	301531
300888	1.000	2374	301532
300889	1.000	2375	301532
300890	1.000	2376	301532
300891	1.000	2377	301532
300892	1.000	2378	301532
300893	1.000	2379	301532
300894	1.000	2380	301532
300895	1.000	2381	301532
300896	1.000	2382	301532
300897	1.000	2383	301532
300898	1.000	2384	301532
300899	1.000	2385	301532
300900	1.000	2386	301532
300901	1.000	2387	301532
300902	1.000	2388	301532
300903	1.000	2389	301532
300904	1.000	2390	301532
300905	1.000	2391	301532
300906	1.000	2392	301532
300907	1.000	2393	301532
300908	3.000	2394	301532
300909	1.000	2395	301532
300910	1.000	2396	301532
300911	1.000	2397	301532
300912	1.000	2374	301533
300913	1.000	2375	301533
300914	1.000	2376	301533
300915	1.000	2377	301533
300916	1.000	2378	301533
300917	1.000	2379	301533
300918	1.000	2380	301533
300919	1.000	2381	301533
300920	1.000	2382	301533
300921	1.000	2383	301533
300922	1.000	2384	301533
300923	1.000	2385	301533
300924	1.000	2386	301533
300925	1.000	2387	301533
300926	1.000	2388	301533
300927	1.000	2389	301533
300928	1.000	2390	301533
300929	1.000	2391	301533
300930	1.000	2392	301533
300931	1.000	2393	301533
300932	3.000	2394	301533
300933	1.000	2395	301533
300934	1.000	2396	301533
300935	1.000	2397	301533
300936	1.000	2374	301534
300937	1.000	2375	301534
300938	1.000	2376	301534
300939	1.000	2377	301534
300940	1.000	2378	301534
300941	1.000	2379	301534
300942	1.000	2380	301534
300943	1.000	2381	301534
300944	1.000	2382	301534
300945	1.000	2383	301534
300946	1.000	2384	301534
300947	1.000	2385	301534
300948	1.000	2386	301534
300949	1.000	2387	301534
300950	1.000	2388	301534
300951	1.000	2389	301534
300952	1.000	2390	301534
300953	1.000	2391	301534
300954	1.000	2392	301534
300955	1.000	2393	301534
300956	3.000	2394	301534
300957	1.000	2395	301534
300958	1.000	2396	301534
300959	1.000	2397	301534
300960	1.000	2374	301535
300961	1.000	2375	301535
300962	1.000	2376	301535
300963	1.000	2377	301535
300964	1.000	2378	301535
300965	1.000	2379	301535
300966	1.000	2380	301535
300967	1.000	2381	301535
300968	1.000	2382	301535
300969	1.000	2383	301535
300970	1.000	2384	301535
300971	1.000	2385	301535
300972	1.000	2386	301535
300973	1.000	2387	301535
300974	1.000	2388	301535
300975	1.000	2389	301535
300976	1.000	2390	301535
300977	1.000	2391	301535
300978	1.000	2392	301535
300979	1.000	2393	301535
300980	3.000	2394	301535
300981	1.000	2395	301535
300982	1.000	2396	301535
300983	1.000	2397	301535
300984	1.000	2374	301536
300985	1.000	2375	301536
300986	1.000	2376	301536
300987	1.000	2377	301536
300988	1.000	2378	301536
300989	1.000	2379	301536
300990	1.000	2380	301536
300991	1.000	2381	301536
300992	1.000	2382	301536
300993	1.000	2383	301536
300994	1.000	2384	301536
300995	1.000	2385	301536
300996	1.000	2386	301536
300997	1.000	2387	301536
300998	1.000	2388	301536
300999	1.000	2389	301536
301000	1.000	2390	301536
301001	1.000	2391	301536
301002	1.000	2392	301536
301003	1.000	2393	301536
301004	3.000	2394	301536
301005	1.000	2395	301536
301006	1.000	2396	301536
301007	1.000	2397	301536
301008	1.000	2374	301537
301009	1.000	2375	301537
301010	1.000	2376	301537
301011	1.000	2377	301537
301012	1.000	2378	301537
301013	1.000	2379	301537
301014	1.000	2380	301537
301015	1.000	2381	301537
301016	1.000	2382	301537
301017	1.000	2383	301537
301018	1.000	2384	301537
301019	1.000	2385	301537
301020	1.000	2386	301537
301021	1.000	2387	301537
301022	1.000	2388	301537
301023	1.000	2389	301537
301024	1.000	2390	301537
301025	1.000	2391	301537
301026	1.000	2392	301537
301027	1.000	2393	301537
301028	3.000	2394	301537
301029	1.000	2395	301537
301030	1.000	2396	301537
301031	1.000	2397	301537
301032	1.000	2374	301538
301033	1.000	2375	301538
301034	1.000	2376	301538
301035	1.000	2377	301538
301036	1.000	2378	301538
301037	1.000	2379	301538
301038	1.000	2380	301538
301039	1.000	2381	301538
301040	1.000	2382	301538
301041	1.000	2383	301538
301042	1.000	2384	301538
301043	1.000	2385	301538
301044	1.000	2386	301538
301045	1.000	2387	301538
301046	1.000	2388	301538
301047	1.000	2389	301538
301048	1.000	2390	301538
301049	1.000	2391	301538
301050	1.000	2392	301538
301051	1.000	2393	301538
301052	3.000	2394	301538
301053	1.000	2395	301538
301054	1.000	2396	301538
301055	1.000	2397	301538
301056	1.000	2374	301539
301057	1.000	2375	301539
301058	1.000	2376	301539
301059	1.000	2377	301539
301060	1.000	2378	301539
301061	1.000	2379	301539
301062	1.000	2380	301539
301063	1.000	2381	301539
301064	1.000	2382	301539
301065	1.000	2383	301539
301066	1.000	2384	301539
301067	1.000	2385	301539
301068	1.000	2386	301539
301069	1.000	2387	301539
301070	1.000	2388	301539
301071	1.000	2389	301539
301072	1.000	2390	301539
301073	1.000	2391	301539
301074	1.000	2392	301539
301075	1.000	2393	301539
301076	3.000	2394	301539
301077	1.000	2395	301539
301078	1.000	2396	301539
301079	1.000	2397	301539
301080	1.000	2374	301540
301081	1.000	2375	301540
301082	1.000	2376	301540
301083	1.000	2377	301540
301084	1.000	2378	301540
301085	1.000	2379	301540
301086	1.000	2380	301540
301087	1.000	2381	301540
301088	1.000	2382	301540
301089	1.000	2383	301540
301090	1.000	2384	301540
301091	1.000	2385	301540
301092	1.000	2386	301540
301093	1.000	2387	301540
301094	1.000	2388	301540
301095	1.000	2389	301540
301096	1.000	2390	301540
301097	1.000	2391	301540
301098	1.000	2392	301540
301099	1.000	2393	301540
301100	3.000	2394	301540
301101	1.000	2395	301540
301102	1.000	2396	301540
301103	1.000	2397	301540
301104	1.000	2374	301541
301105	1.000	2375	301541
301106	1.000	2376	301541
301107	1.000	2377	301541
301108	1.000	2378	301541
301109	1.000	2379	301541
301110	1.000	2380	301541
301111	1.000	2381	301541
301112	1.000	2382	301541
301113	1.000	2383	301541
301114	1.000	2384	301541
301115	1.000	2385	301541
301116	1.000	2386	301541
301117	1.000	2387	301541
301118	1.000	2388	301541
301119	1.000	2389	301541
301120	1.000	2390	301541
301121	1.000	2391	301541
301122	1.000	2392	301541
301123	1.000	2393	301541
301124	3.000	2394	301541
301125	1.000	2395	301541
301126	1.000	2396	301541
301127	1.000	2397	301541
301128	1.000	2374	301542
301129	1.000	2375	301542
301130	1.000	2376	301542
301131	1.000	2377	301542
301132	1.000	2378	301542
301133	1.000	2379	301542
301134	1.000	2380	301542
301135	1.000	2381	301542
301136	1.000	2382	301542
301137	1.000	2383	301542
301138	1.000	2384	301542
301139	1.000	2385	301542
301140	1.000	2386	301542
301141	1.000	2387	301542
301142	1.000	2388	301542
301143	1.000	2389	301542
301144	1.000	2390	301542
301145	1.000	2391	301542
301146	1.000	2392	301542
301147	1.000	2393	301542
301148	3.000	2394	301542
301149	1.000	2395	301542
301150	1.000	2396	301542
301151	1.000	2397	301542
301152	1.000	2374	301543
301153	1.000	2375	301543
301154	1.000	2376	301543
301155	1.000	2377	301543
301156	1.000	2378	301543
301157	1.000	2379	301543
301158	1.000	2380	301543
301159	1.000	2381	301543
301160	1.000	2382	301543
301161	1.000	2383	301543
301162	1.000	2384	301543
301163	1.000	2385	301543
301164	1.000	2386	301543
301165	1.000	2387	301543
301166	1.000	2388	301543
301167	1.000	2389	301543
301168	1.000	2390	301543
301169	1.000	2391	301543
301170	1.000	2392	301543
301171	1.000	2393	301543
301172	3.000	2394	301543
301173	1.000	2395	301543
301174	1.000	2396	301543
301175	1.000	2397	301543
301176	1.000	2374	301544
301177	1.000	2375	301544
301178	1.000	2376	301544
301179	1.000	2377	301544
301180	1.000	2378	301544
301181	1.000	2379	301544
301182	1.000	2380	301544
301183	1.000	2381	301544
301184	1.000	2382	301544
301185	1.000	2383	301544
301186	1.000	2384	301544
301187	1.000	2385	301544
301188	1.000	2386	301544
301189	1.000	2387	301544
301190	1.000	2388	301544
301191	1.000	2389	301544
301192	1.000	2390	301544
301193	1.000	2391	301544
301194	1.000	2392	301544
301195	1.000	2393	301544
301196	3.000	2394	301544
301197	1.000	2395	301544
301198	1.000	2396	301544
301199	1.000	2397	301544
301200	1.000	2374	301545
301201	1.000	2375	301545
301202	1.000	2376	301545
301203	1.000	2377	301545
301204	1.000	2378	301545
301205	1.000	2379	301545
301206	1.000	2380	301545
301207	1.000	2381	301545
301208	1.000	2382	301545
301209	1.000	2383	301545
301210	1.000	2384	301545
301211	1.000	2385	301545
301212	1.000	2386	301545
301213	1.000	2387	301545
301214	1.000	2388	301545
301215	1.000	2389	301545
301216	1.000	2390	301545
301217	1.000	2391	301545
301218	1.000	2392	301545
301219	1.000	2393	301545
301220	3.000	2394	301545
301221	1.000	2395	301545
301222	1.000	2396	301545
301223	1.000	2397	301545
303442	4.000	3498	302319
303443	2.000	3499	302319
303444	12.000	3500	302319
303445	10.000	3501	302319
303446	3.000	3502	302319
303447	6.000	3503	302319
303448	6.000	3504	302319
303449	3.000	3505	302319
303450	1.000	3506	302319
303451	1.000	3507	302319
303452	1.000	3486	302320
303453	1.000	3487	302320
303454	2.000	3488	302320
303455	1.000	3489	302320
303456	2.000	3490	302320
303457	2.000	3491	302320
303458	1.000	3492	302320
303459	1.000	3493	302320
303460	2.000	3494	302320
303461	3.000	3495	302320
303462	3.000	3496	302320
303463	3.000	3497	302320
303464	1.000	3486	302321
303465	1.000	3487	302321
303466	2.000	3488	302321
303467	1.000	3489	302321
303468	2.000	3490	302321
303469	2.000	3491	302321
303470	1.000	3492	302321
303471	1.000	3493	302321
303472	2.000	3494	302321
303473	3.000	3495	302321
303474	3.000	3496	302321
303475	3.000	3497	302321
303476	1.000	3486	302322
303477	1.000	3487	302322
303478	2.000	3488	302322
303479	1.000	3489	302322
303480	2.000	3490	302322
303481	2.000	3491	302322
303482	1.000	3492	302322
303483	1.000	3493	302322
303484	2.000	3494	302322
303485	3.000	3495	302322
303486	3.000	3496	302322
303487	3.000	3497	302322
303488	1.000	3523	302323
303489	1.000	3524	302323
303490	8.000	3525	302323
303491	16.000	3526	302323
303492	1.000	3523	302324
303493	1.000	3524	302324
303494	8.000	3525	302324
303495	16.000	3526	302324
303496	1.000	3523	302325
303497	1.000	3524	302325
303498	8.000	3525	302325
303499	16.000	3526	302325
303500	12.000	3409	302326
303501	3.000	3410	302326
303502	3.000	3411	302326
303503	1.000	3412	302326
303504	1.000	3413	302326
303505	1.000	3414	302326
303506	3.000	3415	302327
303507	2.000	3416	302327
303508	1.000	3508	302328
303509	1.000	3509	302328
303510	1.000	3510	302328
303511	1.000	3511	302328
303512	1.000	3512	302328
303513	1.000	3513	302328
303514	1.000	3514	302328
303515	1.000	3515	302328
303516	1.000	3516	302328
303517	1.000	3517	302328
303518	2.000	3518	302328
303519	1.000	3519	302328
303520	1.000	3520	302328
303521	1.000	3521	302328
303522	4.000	3522	302328
303523	1.000	3508	302329
303524	1.000	3509	302329
303525	1.000	3510	302329
303526	1.000	3511	302329
303527	1.000	3512	302329
303528	1.000	3513	302329
303529	1.000	3514	302329
303530	1.000	3515	302329
303531	1.000	3516	302329
303532	1.000	3517	302329
303533	2.000	3518	302329
303534	1.000	3519	302329
303535	1.000	3520	302329
303536	1.000	3521	302329
303537	4.000	3522	302329
303538	1.000	3508	302330
303539	1.000	3509	302330
303540	1.000	3510	302330
303541	1.000	3511	302330
303542	1.000	3512	302330
303543	1.000	3513	302330
303544	1.000	3514	302330
303545	1.000	3515	302330
303546	1.000	3516	302330
303547	1.000	3517	302330
303548	2.000	3518	302330
303549	1.000	3519	302330
303550	1.000	3520	302330
303551	1.000	3521	302330
303552	4.000	3522	302330
303553	1.000	3508	302331
303554	1.000	3509	302331
303555	1.000	3510	302331
303556	1.000	3511	302331
303557	1.000	3512	302331
303558	1.000	3513	302331
303559	1.000	3514	302331
303560	1.000	3515	302331
303561	1.000	3516	302331
303562	1.000	3517	302331
303563	2.000	3518	302331
303564	1.000	3519	302331
303565	1.000	3520	302331
303566	1.000	3521	302331
303567	4.000	3522	302331
303568	1.000	3508	302332
303569	1.000	3509	302332
303570	1.000	3510	302332
303571	1.000	3511	302332
303572	1.000	3512	302332
303573	1.000	3513	302332
303574	1.000	3514	302332
303575	1.000	3515	302332
303576	1.000	3516	302332
303577	1.000	3517	302332
303578	2.000	3518	302332
303579	1.000	3519	302332
303580	1.000	3520	302332
303581	1.000	3521	302332
303582	4.000	3522	302332
303583	1.000	3417	302333
303584	1.000	3418	302333
303585	1.000	3419	302333
303586	1.000	3420	302333
303587	1.000	3421	302333
303588	2.000	3422	302333
303589	1.000	3423	302333
303590	1.000	3424	302333
303591	1.000	3425	302333
303592	4.000	3426	302333
303593	3.000	3427	302333
303594	1.000	3417	302334
303595	1.000	3418	302334
303596	1.000	3419	302334
303597	1.000	3420	302334
303598	1.000	3421	302334
303599	2.000	3422	302334
303600	1.000	3423	302334
303601	1.000	3424	302334
303602	1.000	3425	302334
303603	4.000	3426	302334
303604	3.000	3427	302334
303605	1.000	3417	302335
303606	1.000	3418	302335
303607	1.000	3419	302335
303608	1.000	3420	302335
303609	1.000	3421	302335
303610	2.000	3422	302335
303611	1.000	3423	302335
303612	1.000	3424	302335
303613	1.000	3425	302335
303614	4.000	3426	302335
303615	3.000	3427	302335
303616	1.000	3537	302336
303617	1.000	3538	302336
303618	1.000	3539	302336
303619	4.000	3540	302336
303620	4.000	3541	302336
303621	1.000	3542	302336
303622	1.000	3537	302337
303623	1.000	3538	302337
303624	1.000	3539	302337
303625	4.000	3540	302337
303626	4.000	3541	302337
303627	1.000	3542	302337
303628	1.000	3537	302338
303629	1.000	3538	302338
303630	1.000	3539	302338
303631	4.000	3540	302338
303632	4.000	3541	302338
303633	1.000	3542	302338
303634	1.000	3548	302339
303635	1.000	3549	302339
303636	1.000	3550	302339
303637	1.000	3551	302339
303638	1.000	3548	302340
303639	1.000	3549	302340
303640	1.000	3550	302340
303641	1.000	3551	302340
303642	2.000	3457	302341
303643	1.000	3458	302341
303644	6.000	3459	302341
303645	3.000	3460	302341
303646	3.000	3461	302341
303647	1.000	3462	302341
303648	1.000	3463	302341
303649	5.000	3464	302341
303650	2.000	3457	302342
303651	1.000	3458	302342
303652	6.000	3459	302342
303653	3.000	3460	302342
303654	3.000	3461	302342
303655	1.000	3462	302342
303656	1.000	3463	302342
303657	5.000	3464	302342
303658	1.000	3465	302343
303659	1.000	3466	302343
303660	1.000	3467	302343
303661	2.000	3468	302343
303662	2.000	3469	302343
303663	1.000	3470	302343
303664	1.000	3471	302343
303665	1.000	3465	302344
303666	1.000	3466	302344
303667	1.000	3467	302344
303668	2.000	3468	302344
303669	2.000	3469	302344
303670	1.000	3470	302344
303671	1.000	3471	302344
303672	1.000	3465	302345
303673	1.000	3466	302345
303674	1.000	3467	302345
303675	2.000	3468	302345
303676	2.000	3469	302345
303677	1.000	3470	302345
303678	1.000	3471	302345
303679	12.000	3552	302346
303680	2.000	3553	302346
303681	24.000	3554	302346
303682	12.000	3555	302346
303683	6.000	3556	302346
303684	12.000	3557	302346
303685	6.000	3558	302346
303686	6.000	3559	302346
303687	2.000	3560	302346
303688	12.000	3561	302346
303689	12.000	3562	302346
303690	3.000	3563	302346
303691	2.000	3472	302347
303692	3.000	3473	302347
303693	24.000	3474	302347
303694	24.000	3475	302347
303695	24.000	3476	302347
303696	1.000	3477	302348
303697	20.000	3581	302349
303698	3.000	3582	302349
303699	6.000	3583	302349
303700	6.000	3584	302349
303701	3.000	3585	302349
303702	1.000	3586	302349
303703	15.000	3587	302349
303704	1.000	3478	302350
303705	3.000	3479	302350
303706	1.000	3478	302351
303707	3.000	3479	302351
303708	1.000	3478	302352
303709	3.000	3479	302352
303710	1.000	3682	302353
303711	1.000	3683	302353
303712	1.000	3684	302353
303713	2.000	3685	302353
303714	2.000	3686	302353
303715	1.000	3687	302353
303716	4.000	3688	302353
303717	1.000	3682	302354
303718	1.000	3683	302354
303719	1.000	3684	302354
303720	2.000	3685	302354
303721	2.000	3686	302354
303722	1.000	3687	302354
303723	4.000	3688	302354
303724	1.000	3682	302355
303725	1.000	3683	302355
303726	1.000	3684	302355
303727	2.000	3685	302355
303728	2.000	3686	302355
303729	1.000	3687	302355
303730	4.000	3688	302355
303731	2.000	3484	302356
303732	2.000	3485	302356
303733	6.000	3480	302357
303734	12.000	3670	302358
303735	1.000	3671	302358
303736	1.000	3672	302358
303737	1.000	3673	302358
303738	1.000	3674	302358
303739	6.000	3675	302358
303740	12.000	3676	302358
303741	2.000	3642	302359
303742	1.000	3643	302359
303743	1.000	3644	302359
303744	1.000	3645	302359
303745	1.000	3646	302359
303746	1.000	3647	302359
303747	1.000	3648	302359
303748	1.000	3649	302359
303749	1.000	3650	302359
303750	1.000	3651	302359
303751	2.000	3652	302359
303752	6.000	3653	302359
303753	2.000	3654	302359
303754	1.000	3655	302359
303755	2.000	3656	302359
303756	1.000	3657	302359
303757	2.000	3658	302359
303758	2.000	3659	302359
303759	2.000	3660	302359
303760	2.000	3661	302359
303761	1.000	3662	302359
303762	1.000	3663	302359
303763	3.000	3664	302359
303764	2.000	3665	302359
303765	1.000	3666	302359
303766	1.000	3667	302359
303767	1.000	3668	302359
303768	2.000	3669	302359
303769	2.000	3642	302360
303770	1.000	3643	302360
303771	1.000	3644	302360
303772	1.000	3645	302360
303773	1.000	3646	302360
303774	1.000	3647	302360
303775	1.000	3648	302360
303776	1.000	3649	302360
303777	1.000	3650	302360
303778	1.000	3651	302360
303779	2.000	3652	302360
303780	6.000	3653	302360
303781	2.000	3654	302360
303782	1.000	3655	302360
303783	2.000	3656	302360
303784	1.000	3657	302360
303785	2.000	3658	302360
303786	2.000	3659	302360
303787	2.000	3660	302360
303788	2.000	3661	302360
303789	1.000	3662	302360
303790	1.000	3663	302360
303791	3.000	3664	302360
303792	2.000	3665	302360
303793	1.000	3666	302360
303794	1.000	3667	302360
303795	1.000	3668	302360
303796	2.000	3669	302360
303797	2.000	3642	302361
303798	1.000	3643	302361
303799	1.000	3644	302361
303800	1.000	3645	302361
303801	1.000	3646	302361
303802	1.000	3647	302361
303803	1.000	3648	302361
303804	1.000	3649	302361
303805	1.000	3650	302361
303806	1.000	3651	302361
303807	2.000	3652	302361
303808	6.000	3653	302361
303809	2.000	3654	302361
303810	1.000	3655	302361
303811	2.000	3656	302361
303812	1.000	3657	302361
303813	2.000	3658	302361
303814	2.000	3659	302361
303815	2.000	3660	302361
303816	2.000	3661	302361
303817	1.000	3662	302361
303818	1.000	3663	302361
303819	3.000	3664	302361
303820	2.000	3665	302361
303821	1.000	3666	302361
303822	1.000	3667	302361
303823	1.000	3668	302361
303824	2.000	3669	302361
303825	6.000	3692	302364
303826	1.000	3693	302364
303827	6.000	3694	302364
303828	1.000	3695	302364
303829	3.000	3696	302364
303830	3.000	3697	302364
303831	6.000	3698	302364
303832	6.000	3699	302364
303833	3.000	3700	302364
303834	1.000	3701	302364
303835	6.000	3702	302364
303836	6.000	3703	302364
303837	3.000	3704	302364
303838	3.000	3705	302364
303839	6.000	3706	302364
303840	3.000	3707	302364
303841	6.000	3692	302365
303842	1.000	3693	302365
303843	6.000	3694	302365
303844	1.000	3695	302365
303845	3.000	3696	302365
303846	3.000	3697	302365
303847	6.000	3698	302365
303848	6.000	3699	302365
303849	3.000	3700	302365
303850	1.000	3701	302365
303851	6.000	3702	302365
303852	6.000	3703	302365
303853	3.000	3704	302365
303854	3.000	3705	302365
303855	6.000	3706	302365
303856	3.000	3707	302365
303857	3.000	3482	302366
303858	12.000	3483	302366
303859	1.000	3429	302367
303860	3.000	3430	302367
303861	1.000	3431	302367
303862	1.000	3432	302367
303863	1.000	3433	302367
303864	1.000	3434	302367
303865	1.000	3435	302367
303866	3.000	3436	302367
303867	3.000	3437	302367
303868	3.000	3438	302367
303869	1.000	3439	302367
303870	1.000	3440	302367
303871	1.000	3441	302367
303872	1.000	3442	302367
303873	3.000	3443	302367
303874	3.000	3444	302367
303875	3.000	3445	302367
303876	1.000	3446	302367
303877	1.000	3447	302367
303878	1.000	3448	302367
303879	1.000	3449	302367
303880	1.000	3450	302367
303881	3.000	3451	302367
303882	1.000	3452	302367
303883	1.000	3453	302367
303884	1.000	3454	302367
303885	3.000	3455	302367
303886	3.000	3456	302367
303887	1.000	3429	302368
303888	3.000	3430	302368
303889	1.000	3431	302368
303890	1.000	3432	302368
303891	1.000	3433	302368
303892	1.000	3434	302368
303893	1.000	3435	302368
303894	3.000	3436	302368
303895	3.000	3437	302368
303896	3.000	3438	302368
303897	1.000	3439	302368
303898	1.000	3440	302368
303899	1.000	3441	302368
303900	1.000	3442	302368
303901	3.000	3443	302368
303902	3.000	3444	302368
303903	3.000	3445	302368
303904	1.000	3446	302368
303905	1.000	3447	302368
303906	1.000	3448	302368
303907	1.000	3449	302368
303908	1.000	3450	302368
303909	3.000	3451	302368
303910	1.000	3452	302368
303911	1.000	3453	302368
303912	1.000	3454	302368
303913	3.000	3455	302368
303914	3.000	3456	302368
303915	1.000	3429	302369
303916	3.000	3430	302369
303917	1.000	3431	302369
303918	1.000	3432	302369
303919	1.000	3433	302369
303920	1.000	3434	302369
303921	1.000	3435	302369
303922	3.000	3436	302369
303923	3.000	3437	302369
303924	3.000	3438	302369
303925	1.000	3439	302369
303926	1.000	3440	302369
303927	1.000	3441	302369
303928	1.000	3442	302369
303929	3.000	3443	302369
303930	3.000	3444	302369
303931	3.000	3445	302369
303932	1.000	3446	302369
303933	1.000	3447	302369
303934	1.000	3448	302369
303935	1.000	3449	302369
303936	1.000	3450	302369
303937	3.000	3451	302369
303938	1.000	3452	302369
303939	1.000	3453	302369
303940	1.000	3454	302369
303941	3.000	3455	302369
303942	3.000	3456	302369
303943	1.000	3429	302370
303944	3.000	3430	302370
303945	1.000	3431	302370
303946	1.000	3432	302370
303947	1.000	3433	302370
303948	1.000	3434	302370
303949	1.000	3435	302370
303950	3.000	3436	302370
303951	3.000	3437	302370
303952	3.000	3438	302370
303953	1.000	3439	302370
303954	1.000	3440	302370
303955	1.000	3441	302370
303956	1.000	3442	302370
303957	3.000	3443	302370
303958	3.000	3444	302370
303959	3.000	3445	302370
303960	1.000	3446	302370
303961	1.000	3447	302370
303962	1.000	3448	302370
303963	1.000	3449	302370
303964	1.000	3450	302370
303965	3.000	3451	302370
303966	1.000	3452	302370
303967	1.000	3453	302370
303968	1.000	3454	302370
303969	3.000	3455	302370
303970	3.000	3456	302370
303971	1.000	3401	302371
303972	1.000	3402	302371
303973	3.000	3403	302371
303974	1.000	3404	302371
303975	1.000	3405	302371
303976	1.000	3406	302371
303977	1.000	3407	302371
303978	3.000	3408	302371
303979	1.000	3401	302372
303980	1.000	3402	302372
303981	3.000	3403	302372
303982	1.000	3404	302372
303983	1.000	3405	302372
303984	1.000	3406	302372
303985	1.000	3407	302372
303986	3.000	3408	302372
303987	1.000	3401	302373
303988	1.000	3402	302373
303989	3.000	3403	302373
303990	1.000	3404	302373
303991	1.000	3405	302373
303992	1.000	3406	302373
303993	1.000	3407	302373
303994	3.000	3408	302373
303995	1.000	3401	302374
303996	1.000	3402	302374
303997	3.000	3403	302374
303998	1.000	3404	302374
303999	1.000	3405	302374
304000	1.000	3406	302374
304001	1.000	3407	302374
304002	3.000	3408	302374
304003	9.000	3564	302375
304004	12.000	3565	302375
304005	1.000	3566	302375
304006	3.000	3567	302375
304007	3.000	3568	302375
304008	3.000	3569	302375
304009	1.000	3570	302375
304010	1.000	3571	302375
304011	1.000	3572	302375
304012	9.000	3564	302376
304013	12.000	3565	302376
304014	1.000	3566	302376
304015	3.000	3567	302376
304016	3.000	3568	302376
304017	3.000	3569	302376
304018	1.000	3570	302376
304019	1.000	3571	302376
304020	1.000	3572	302376
304021	6.000	3527	302377
304022	3.000	3528	302377
304023	6.000	3529	302377
304024	6.000	3530	302377
304025	12.000	3531	302377
304026	12.000	3532	302377
304027	3.000	3533	302377
304028	6.000	3534	302377
304029	3.000	3535	302377
304030	6.000	3536	302377
304031	10.000	3636	302378
304032	10.000	3637	302378
304033	3.000	3638	302378
304034	4.000	3639	302378
304035	2.000	3640	302378
304036	3.000	3641	302378
304037	10.000	3636	302379
304038	10.000	3637	302379
304039	3.000	3638	302379
304040	4.000	3639	302379
304041	2.000	3640	302379
304042	3.000	3641	302379
304043	10.000	3636	302380
304044	10.000	3637	302380
304045	3.000	3638	302380
304046	4.000	3639	302380
304047	2.000	3640	302380
304048	3.000	3641	302380
304049	10.000	3636	302381
304050	10.000	3637	302381
304051	3.000	3638	302381
304052	4.000	3639	302381
304053	2.000	3640	302381
304054	3.000	3641	302381
304055	10.000	3636	302382
304056	10.000	3637	302382
304057	3.000	3638	302382
304058	4.000	3639	302382
304059	2.000	3640	302382
304060	3.000	3641	302382
304061	10.000	3636	302383
304062	10.000	3637	302383
304063	3.000	3638	302383
304064	4.000	3639	302383
304065	2.000	3640	302383
304066	3.000	3641	302383
304067	1.000	3634	302384
304068	2.000	3635	302384
304069	1.000	3634	302385
304070	2.000	3635	302385
304071	1.000	3634	302386
304072	2.000	3635	302386
304073	1.000	3634	302387
304074	2.000	3635	302387
304075	1.000	3634	302388
304076	2.000	3635	302388
304077	1.000	3634	302389
304078	2.000	3635	302389
304079	1.000	3634	302390
304080	2.000	3635	302390
304081	4.000	3481	302391
304082	1.000	3573	302392
304083	24.000	3574	302392
304084	2.000	3575	302392
304085	11.000	3576	302392
304086	2.000	3577	302392
304087	2.000	3578	302392
304088	1.000	3579	302392
304089	1.000	3543	302393
304090	1.000	3544	302393
304091	1.000	3545	302393
304092	1.000	3546	302393
304093	1.000	3547	302393
304094	1.000	3543	302394
304095	1.000	3544	302394
304096	1.000	3545	302394
304097	1.000	3546	302394
304098	1.000	3547	302394
304099	1.000	3588	302395
304100	1.000	3589	302395
304101	1.000	3590	302395
304102	1.000	3591	302395
304103	1.000	3592	302395
304104	1.000	3593	302395
304105	1.000	3594	302395
304106	1.000	3595	302395
304107	1.000	3596	302395
304108	1.000	3597	302395
304109	1.000	3598	302395
304110	1.000	3599	302395
304111	1.000	3600	302395
304112	1.000	3601	302395
304113	1.000	3602	302395
304114	1.000	3603	302395
304115	1.000	3604	302395
304116	1.000	3605	302395
304117	1.000	3606	302395
304118	1.000	3607	302395
304119	1.000	3608	302395
304120	1.000	3609	302395
304121	4.000	3610	302395
304122	1.000	3611	302395
304123	1.000	3612	302395
304124	1.000	3613	302395
304125	1.000	3614	302395
304126	1.000	3615	302395
304127	1.000	3616	302395
304128	2.000	3617	302395
304129	1.000	3618	302395
304130	2.000	3619	302395
304131	1.000	3620	302395
304132	1.000	3621	302395
304133	1.000	3622	302395
304134	1.000	3623	302395
304135	1.000	3624	302395
304136	1.000	3625	302395
304137	1.000	3626	302395
304138	1.000	3627	302395
304139	1.000	3628	302395
304140	6.000	3629	302395
304141	2.000	3630	302395
304142	1.000	3631	302395
304143	1.000	3632	302395
304144	1.000	3633	302395
304145	1.000	3588	302396
304146	1.000	3589	302396
304147	1.000	3590	302396
304148	1.000	3591	302396
304149	1.000	3592	302396
304150	1.000	3593	302396
304151	1.000	3594	302396
304152	1.000	3595	302396
304153	1.000	3596	302396
304154	1.000	3597	302396
304155	1.000	3598	302396
304156	1.000	3599	302396
304157	1.000	3600	302396
304158	1.000	3601	302396
304159	1.000	3602	302396
304160	1.000	3603	302396
304161	1.000	3604	302396
304162	1.000	3605	302396
304163	1.000	3606	302396
304164	1.000	3607	302396
304165	1.000	3608	302396
304166	1.000	3609	302396
304167	4.000	3610	302396
304168	1.000	3611	302396
304169	1.000	3612	302396
304170	1.000	3613	302396
304171	1.000	3614	302396
304172	1.000	3615	302396
304173	1.000	3616	302396
304174	2.000	3617	302396
304175	1.000	3618	302396
304176	2.000	3619	302396
304177	1.000	3620	302396
304178	1.000	3621	302396
304179	1.000	3622	302396
304180	1.000	3623	302396
304181	1.000	3624	302396
304182	1.000	3625	302396
304183	1.000	3626	302396
304184	1.000	3627	302396
304185	1.000	3628	302396
304186	6.000	3629	302396
304187	2.000	3630	302396
304188	1.000	3631	302396
304189	1.000	3632	302396
304190	1.000	3633	302396
304191	1.000	3588	302397
304192	1.000	3589	302397
304193	1.000	3590	302397
304194	1.000	3591	302397
304195	1.000	3592	302397
304196	1.000	3593	302397
304197	1.000	3594	302397
304198	1.000	3595	302397
304199	1.000	3596	302397
304200	1.000	3597	302397
304201	1.000	3598	302397
304202	1.000	3599	302397
304203	1.000	3600	302397
304204	1.000	3601	302397
304205	1.000	3602	302397
304206	1.000	3603	302397
304207	1.000	3604	302397
304208	1.000	3605	302397
304209	1.000	3606	302397
304210	1.000	3607	302397
304211	1.000	3608	302397
304212	1.000	3609	302397
304213	4.000	3610	302397
304214	1.000	3611	302397
304215	1.000	3612	302397
304216	1.000	3613	302397
304217	1.000	3614	302397
304218	1.000	3615	302397
304219	1.000	3616	302397
304220	2.000	3617	302397
304221	1.000	3618	302397
304222	2.000	3619	302397
304223	1.000	3620	302397
304224	1.000	3621	302397
304225	1.000	3622	302397
304226	1.000	3623	302397
304227	1.000	3624	302397
304228	1.000	3625	302397
304229	1.000	3626	302397
304230	1.000	3627	302397
304231	1.000	3628	302397
304232	6.000	3629	302397
304233	2.000	3630	302397
304234	1.000	3631	302397
304235	1.000	3632	302397
304236	1.000	3633	302397
304237	1.000	3588	302398
304238	1.000	3589	302398
304239	1.000	3590	302398
304240	1.000	3591	302398
304241	1.000	3592	302398
304242	1.000	3593	302398
304243	1.000	3594	302398
304244	1.000	3595	302398
304245	1.000	3596	302398
304246	1.000	3597	302398
304247	1.000	3598	302398
304248	1.000	3599	302398
304249	1.000	3600	302398
304250	1.000	3601	302398
304251	1.000	3602	302398
304252	1.000	3603	302398
304253	1.000	3604	302398
304254	1.000	3605	302398
304255	1.000	3606	302398
304256	1.000	3607	302398
304257	1.000	3608	302398
304258	1.000	3609	302398
304259	4.000	3610	302398
304260	1.000	3611	302398
304261	1.000	3612	302398
304262	1.000	3613	302398
304263	1.000	3614	302398
304264	1.000	3615	302398
304265	1.000	3616	302398
304266	2.000	3617	302398
304267	1.000	3618	302398
304268	2.000	3619	302398
304269	1.000	3620	302398
304270	1.000	3621	302398
304271	1.000	3622	302398
304272	1.000	3623	302398
304273	1.000	3624	302398
304274	1.000	3625	302398
304275	1.000	3626	302398
304276	1.000	3627	302398
304277	1.000	3628	302398
304278	6.000	3629	302398
304279	2.000	3630	302398
304280	1.000	3631	302398
304281	1.000	3632	302398
304282	1.000	3633	302398
304283	1.000	3588	302399
304284	1.000	3589	302399
304285	1.000	3590	302399
304286	1.000	3591	302399
304287	1.000	3592	302399
304288	1.000	3593	302399
304289	1.000	3594	302399
304290	1.000	3595	302399
304291	1.000	3596	302399
304292	1.000	3597	302399
304293	1.000	3598	302399
304294	1.000	3599	302399
304295	1.000	3600	302399
304296	1.000	3601	302399
304297	1.000	3602	302399
304298	1.000	3603	302399
304299	1.000	3604	302399
304300	1.000	3605	302399
304301	1.000	3606	302399
304302	1.000	3607	302399
304303	1.000	3608	302399
304304	1.000	3609	302399
304305	4.000	3610	302399
304306	1.000	3611	302399
304307	1.000	3612	302399
304308	1.000	3613	302399
304309	1.000	3614	302399
304310	1.000	3615	302399
304311	1.000	3616	302399
304312	2.000	3617	302399
304313	1.000	3618	302399
304314	2.000	3619	302399
304315	1.000	3620	302399
304316	1.000	3621	302399
304317	1.000	3622	302399
304318	1.000	3623	302399
304319	1.000	3624	302399
304320	1.000	3625	302399
304321	1.000	3626	302399
304322	1.000	3627	302399
304323	1.000	3628	302399
304324	6.000	3629	302399
304325	2.000	3630	302399
304326	1.000	3631	302399
304327	1.000	3632	302399
304328	1.000	3633	302399
304329	1.000	3588	302400
304330	1.000	3589	302400
304331	1.000	3590	302400
304332	1.000	3591	302400
304333	1.000	3592	302400
304334	1.000	3593	302400
304335	1.000	3594	302400
304336	1.000	3595	302400
304337	1.000	3596	302400
304338	1.000	3597	302400
304339	1.000	3598	302400
304340	1.000	3599	302400
304341	1.000	3600	302400
304342	1.000	3601	302400
304343	1.000	3602	302400
304344	1.000	3603	302400
304345	1.000	3604	302400
304346	1.000	3605	302400
304347	1.000	3606	302400
304348	1.000	3607	302400
304349	1.000	3608	302400
304350	1.000	3609	302400
304351	4.000	3610	302400
304352	1.000	3611	302400
304353	1.000	3612	302400
304354	1.000	3613	302400
304355	1.000	3614	302400
304356	1.000	3615	302400
304357	1.000	3616	302400
304358	2.000	3617	302400
304359	1.000	3618	302400
304360	2.000	3619	302400
304361	1.000	3620	302400
304362	1.000	3621	302400
304363	1.000	3622	302400
304364	1.000	3623	302400
304365	1.000	3624	302400
304366	1.000	3625	302400
304367	1.000	3626	302400
304368	1.000	3627	302400
304369	1.000	3628	302400
304370	6.000	3629	302400
304371	2.000	3630	302400
304372	1.000	3631	302400
304373	1.000	3632	302400
304374	1.000	3633	302400
304375	1.000	3588	302401
304376	1.000	3589	302401
304377	1.000	3590	302401
304378	1.000	3591	302401
304379	1.000	3592	302401
304380	1.000	3593	302401
304381	1.000	3594	302401
304382	1.000	3595	302401
304383	1.000	3596	302401
304384	1.000	3597	302401
304385	1.000	3598	302401
304386	1.000	3599	302401
304387	1.000	3600	302401
304388	1.000	3601	302401
304389	1.000	3602	302401
304390	1.000	3603	302401
304391	1.000	3604	302401
304392	1.000	3605	302401
304393	1.000	3606	302401
304394	1.000	3607	302401
304395	1.000	3608	302401
304396	1.000	3609	302401
304397	4.000	3610	302401
304398	1.000	3611	302401
304399	1.000	3612	302401
304400	1.000	3613	302401
304401	1.000	3614	302401
304402	1.000	3615	302401
304403	1.000	3616	302401
304404	2.000	3617	302401
304405	1.000	3618	302401
304406	2.000	3619	302401
304407	1.000	3620	302401
304408	1.000	3621	302401
304409	1.000	3622	302401
304410	1.000	3623	302401
304411	1.000	3624	302401
304412	1.000	3625	302401
304413	1.000	3626	302401
304414	1.000	3627	302401
304415	1.000	3628	302401
304416	6.000	3629	302401
304417	2.000	3630	302401
304418	1.000	3631	302401
304419	1.000	3632	302401
304420	1.000	3633	302401
304421	1.000	3588	302402
304422	1.000	3589	302402
304423	1.000	3590	302402
304424	1.000	3591	302402
304425	1.000	3592	302402
304426	1.000	3593	302402
304427	1.000	3594	302402
304428	1.000	3595	302402
304429	1.000	3596	302402
304430	1.000	3597	302402
304431	1.000	3598	302402
304432	1.000	3599	302402
304433	1.000	3600	302402
304434	1.000	3601	302402
304435	1.000	3602	302402
304436	1.000	3603	302402
304437	1.000	3604	302402
304438	1.000	3605	302402
304439	1.000	3606	302402
304440	1.000	3607	302402
304441	1.000	3608	302402
304442	1.000	3609	302402
304443	4.000	3610	302402
304444	1.000	3611	302402
304445	1.000	3612	302402
304446	1.000	3613	302402
304447	1.000	3614	302402
304448	1.000	3615	302402
304449	1.000	3616	302402
304450	2.000	3617	302402
304451	1.000	3618	302402
304452	2.000	3619	302402
304453	1.000	3620	302402
304454	1.000	3621	302402
304455	1.000	3622	302402
304456	1.000	3623	302402
304457	1.000	3624	302402
304458	1.000	3625	302402
304459	1.000	3626	302402
304460	1.000	3627	302402
304461	1.000	3628	302402
304462	6.000	3629	302402
304463	2.000	3630	302402
304464	1.000	3631	302402
304465	1.000	3632	302402
304466	1.000	3633	302402
304467	1.000	3588	302403
304468	1.000	3589	302403
304469	1.000	3590	302403
304470	1.000	3591	302403
304471	1.000	3592	302403
304472	1.000	3593	302403
304473	1.000	3594	302403
304474	1.000	3595	302403
304475	1.000	3596	302403
304476	1.000	3597	302403
304477	1.000	3598	302403
304478	1.000	3599	302403
304479	1.000	3600	302403
304480	1.000	3601	302403
304481	1.000	3602	302403
304482	1.000	3603	302403
304483	1.000	3604	302403
304484	1.000	3605	302403
304485	1.000	3606	302403
304486	1.000	3607	302403
304487	1.000	3608	302403
304488	1.000	3609	302403
304489	4.000	3610	302403
304490	1.000	3611	302403
304491	1.000	3612	302403
304492	1.000	3613	302403
304493	1.000	3614	302403
304494	1.000	3615	302403
304495	1.000	3616	302403
304496	2.000	3617	302403
304497	1.000	3618	302403
304498	2.000	3619	302403
304499	1.000	3620	302403
304500	1.000	3621	302403
304501	1.000	3622	302403
304502	1.000	3623	302403
304503	1.000	3624	302403
304504	1.000	3625	302403
304505	1.000	3626	302403
304506	1.000	3627	302403
304507	1.000	3628	302403
304508	6.000	3629	302403
304509	2.000	3630	302403
304510	1.000	3631	302403
304511	1.000	3632	302403
304512	1.000	3633	302403
304513	1.000	3588	302404
304514	1.000	3589	302404
304515	1.000	3590	302404
304516	1.000	3591	302404
304517	1.000	3592	302404
304518	1.000	3593	302404
304519	1.000	3594	302404
304520	1.000	3595	302404
304521	1.000	3596	302404
304522	1.000	3597	302404
304523	1.000	3598	302404
304524	1.000	3599	302404
304525	1.000	3600	302404
304526	1.000	3601	302404
304527	1.000	3602	302404
304528	1.000	3603	302404
304529	1.000	3604	302404
304530	1.000	3605	302404
304531	1.000	3606	302404
304532	1.000	3607	302404
304533	1.000	3608	302404
304534	1.000	3609	302404
304535	4.000	3610	302404
304536	1.000	3611	302404
304537	1.000	3612	302404
304538	1.000	3613	302404
304539	1.000	3614	302404
304540	1.000	3615	302404
304541	1.000	3616	302404
304542	2.000	3617	302404
304543	1.000	3618	302404
304544	2.000	3619	302404
304545	1.000	3620	302404
304546	1.000	3621	302404
304547	1.000	3622	302404
304548	1.000	3623	302404
304549	1.000	3624	302404
304550	1.000	3625	302404
304551	1.000	3626	302404
304552	1.000	3627	302404
304553	1.000	3628	302404
304554	6.000	3629	302404
304555	2.000	3630	302404
304556	1.000	3631	302404
304557	1.000	3632	302404
304558	1.000	3633	302404
304559	24.000	3853	302491
304560	6.000	3854	302491
304561	1.000	3855	302491
304562	1.000	3856	302491
304563	3.000	3874	302492
304564	6.000	3875	302492
304565	12.000	3876	302492
304566	6.000	3877	302492
304567	12.000	3878	302492
304568	2.000	3879	302492
304569	1.000	3869	302493
304570	1.000	3870	302493
304571	6.000	3871	302493
304572	1.000	3872	302493
304573	20.000	3873	302493
304577	1.000	3850	302495
304578	12.000	3851	302495
304579	5.000	3852	302495
304580	1.000	3850	302496
304581	12.000	3851	302496
304582	5.000	3852	302496
304583	1.000	3823	302497
304584	1.000	3823	302498
304585	1.000	3823	302499
304586	1.000	3863	302500
304587	2.000	3864	302500
304588	1.000	3865	302500
304589	1.000	3866	302500
304590	4.000	3867	302500
304591	4.000	3868	302500
304592	1.000	3863	302501
304593	2.000	3864	302501
304594	1.000	3865	302501
304595	1.000	3866	302501
304596	4.000	3867	302501
304597	4.000	3868	302501
304598	1.000	3863	302502
304599	2.000	3864	302502
304600	1.000	3865	302502
304601	1.000	3866	302502
304602	4.000	3867	302502
304603	4.000	3868	302502
304604	1.000	3821	302503
304605	1.000	3822	302503
304606	1.000	3821	302504
304607	1.000	3822	302504
304608	1.000	3821	302505
304609	1.000	3822	302505
304610	1.000	3821	302506
304611	1.000	3822	302506
306144	1.000	4312	302987
306145	1.000	4313	302987
306146	1.000	4314	302987
306147	2.000	4315	302987
306148	1.000	4312	302988
306149	1.000	4313	302988
306150	1.000	4314	302988
306151	2.000	4315	302988
304612	5.000	3708	302507
304613	1.000	3857	302508
304614	1.000	3858	302508
304615	1.000	3859	302508
304616	8.000	3860	302508
304617	8.000	3861	302508
304618	8.000	3862	302508
304619	1.000	3857	302509
304620	1.000	3858	302509
304621	1.000	3859	302509
304622	8.000	3860	302509
304623	8.000	3861	302509
304624	8.000	3862	302509
304625	1.000	3857	302510
304626	1.000	3858	302510
304627	1.000	3859	302510
304628	8.000	3860	302510
304629	8.000	3861	302510
304630	8.000	3862	302510
304631	1.000	3709	302511
304632	6.000	3710	302511
304633	1.000	3711	302511
304634	12.000	3712	302511
304635	6.000	3713	302511
304636	6.000	3714	302511
304637	1.000	3709	302512
304638	6.000	3710	302512
304639	1.000	3711	302512
304640	12.000	3712	302512
304641	6.000	3713	302512
304642	6.000	3714	302512
304643	1.000	3824	302513
304644	1.000	3825	302513
304645	1.000	3826	302513
304646	1.000	3827	302513
304647	1.000	3828	302513
304648	1.000	3829	302513
304649	1.000	3830	302513
304650	1.000	3831	302513
304651	2.000	3832	302513
304652	1.000	3833	302513
304653	1.000	3834	302513
304654	1.000	3835	302513
304655	1.000	3836	302513
304656	2.000	3837	302513
304657	1.000	3838	302513
304658	1.000	3839	302513
304659	1.000	3840	302513
304660	1.000	3841	302513
304661	1.000	3842	302513
304662	1.000	3843	302513
304663	1.000	3844	302513
304664	1.000	3845	302513
304665	1.000	3846	302513
304666	1.000	3847	302513
304667	2.000	3848	302513
304668	1.000	3849	302513
304669	1.000	3824	302514
304670	1.000	3825	302514
304671	1.000	3826	302514
304672	1.000	3827	302514
304673	1.000	3828	302514
304674	1.000	3829	302514
304675	1.000	3830	302514
304676	1.000	3831	302514
304677	2.000	3832	302514
304678	1.000	3833	302514
304679	1.000	3834	302514
304680	1.000	3835	302514
304681	1.000	3836	302514
304682	2.000	3837	302514
304683	1.000	3838	302514
304684	1.000	3839	302514
304685	1.000	3840	302514
304686	1.000	3841	302514
304687	1.000	3842	302514
304688	1.000	3843	302514
304689	1.000	3844	302514
304690	1.000	3845	302514
304691	1.000	3846	302514
304692	1.000	3847	302514
304693	2.000	3848	302514
304694	1.000	3849	302514
304695	1.000	3824	302515
304696	1.000	3825	302515
304697	1.000	3826	302515
304698	1.000	3827	302515
304699	1.000	3828	302515
304700	1.000	3829	302515
304701	1.000	3830	302515
304702	1.000	3831	302515
304703	2.000	3832	302515
304704	1.000	3833	302515
304705	1.000	3834	302515
304706	1.000	3835	302515
304707	1.000	3836	302515
304708	2.000	3837	302515
304709	1.000	3838	302515
304710	1.000	3839	302515
304711	1.000	3840	302515
304712	1.000	3841	302515
304713	1.000	3842	302515
304714	1.000	3843	302515
304715	1.000	3844	302515
304716	1.000	3845	302515
304717	1.000	3846	302515
304718	1.000	3847	302515
304719	2.000	3848	302515
304720	1.000	3849	302515
304721	1.000	3824	302516
304722	1.000	3825	302516
304723	1.000	3826	302516
304724	1.000	3827	302516
304725	1.000	3828	302516
304726	1.000	3829	302516
304727	1.000	3830	302516
304728	1.000	3831	302516
304729	2.000	3832	302516
304730	1.000	3833	302516
304731	1.000	3834	302516
304732	1.000	3835	302516
304733	1.000	3836	302516
304734	2.000	3837	302516
304735	1.000	3838	302516
304736	1.000	3839	302516
304737	1.000	3840	302516
304738	1.000	3841	302516
304739	1.000	3842	302516
304740	1.000	3843	302516
304741	1.000	3844	302516
304742	1.000	3845	302516
304743	1.000	3846	302516
304744	1.000	3847	302516
304745	2.000	3848	302516
304746	1.000	3849	302516
304747	1.000	3824	302517
304748	1.000	3825	302517
304749	1.000	3826	302517
304750	1.000	3827	302517
304751	1.000	3828	302517
304752	1.000	3829	302517
304753	1.000	3830	302517
304754	1.000	3831	302517
304755	2.000	3832	302517
304756	1.000	3833	302517
304757	1.000	3834	302517
304758	1.000	3835	302517
304759	1.000	3836	302517
304760	2.000	3837	302517
304761	1.000	3838	302517
304762	1.000	3839	302517
304763	1.000	3840	302517
304764	1.000	3841	302517
304765	1.000	3842	302517
304766	1.000	3843	302517
304767	1.000	3844	302517
304768	1.000	3845	302517
304769	1.000	3846	302517
304770	1.000	3847	302517
304771	2.000	3848	302517
304772	1.000	3849	302517
304773	1.000	3824	302518
304774	1.000	3825	302518
304775	1.000	3826	302518
304776	1.000	3827	302518
304777	1.000	3828	302518
304778	1.000	3829	302518
304779	1.000	3830	302518
304780	1.000	3831	302518
304781	2.000	3832	302518
304782	1.000	3833	302518
304783	1.000	3834	302518
304784	1.000	3835	302518
304785	1.000	3836	302518
304786	2.000	3837	302518
304787	1.000	3838	302518
304788	1.000	3839	302518
304789	1.000	3840	302518
304790	1.000	3841	302518
304791	1.000	3842	302518
304792	1.000	3843	302518
304793	1.000	3844	302518
304794	1.000	3845	302518
304795	1.000	3846	302518
304796	1.000	3847	302518
304797	2.000	3848	302518
304798	1.000	3849	302518
304799	1.000	3824	302519
304800	1.000	3825	302519
304801	1.000	3826	302519
304802	1.000	3827	302519
304803	1.000	3828	302519
304804	1.000	3829	302519
304805	1.000	3830	302519
304806	1.000	3831	302519
304807	2.000	3832	302519
304808	1.000	3833	302519
304809	1.000	3834	302519
304810	1.000	3835	302519
304811	1.000	3836	302519
304812	2.000	3837	302519
304813	1.000	3838	302519
304814	1.000	3839	302519
304815	1.000	3840	302519
304816	1.000	3841	302519
304817	1.000	3842	302519
304818	1.000	3843	302519
304819	1.000	3844	302519
304820	1.000	3845	302519
304821	1.000	3846	302519
304822	1.000	3847	302519
304823	2.000	3848	302519
304824	1.000	3849	302519
304825	1.000	3824	302520
304826	1.000	3825	302520
304827	1.000	3826	302520
304828	1.000	3827	302520
304829	1.000	3828	302520
304830	1.000	3829	302520
304831	1.000	3830	302520
304832	1.000	3831	302520
304833	2.000	3832	302520
304834	1.000	3833	302520
304835	1.000	3834	302520
304836	1.000	3835	302520
304837	1.000	3836	302520
304838	2.000	3837	302520
304839	1.000	3838	302520
304840	1.000	3839	302520
304841	1.000	3840	302520
304842	1.000	3841	302520
304843	1.000	3842	302520
304844	1.000	3843	302520
304845	1.000	3844	302520
304846	1.000	3845	302520
304847	1.000	3846	302520
304848	1.000	3847	302520
304849	2.000	3848	302520
304850	1.000	3849	302520
304851	1.000	3824	302521
304852	1.000	3825	302521
304853	1.000	3826	302521
304854	1.000	3827	302521
304855	1.000	3828	302521
304856	1.000	3829	302521
304857	1.000	3830	302521
304858	1.000	3831	302521
304859	2.000	3832	302521
304860	1.000	3833	302521
304861	1.000	3834	302521
304862	1.000	3835	302521
304863	1.000	3836	302521
304864	2.000	3837	302521
304865	1.000	3838	302521
304866	1.000	3839	302521
304867	1.000	3840	302521
304868	1.000	3841	302521
304869	1.000	3842	302521
304870	1.000	3843	302521
304871	1.000	3844	302521
304872	1.000	3845	302521
304873	1.000	3846	302521
304874	1.000	3847	302521
304875	2.000	3848	302521
304876	1.000	3849	302521
304877	1.000	3808	302522
304878	1.000	3809	302522
304879	1.000	3810	302522
304880	2.000	3811	302522
304881	2.000	3812	302522
304882	1.000	3813	302522
304883	1.000	3814	302522
304884	1.000	3815	302522
304885	1.000	3816	302522
304886	1.000	3817	302522
304887	1.000	3818	302522
304888	1.000	3819	302522
304889	2.000	3820	302522
304890	1.000	3808	302523
304891	1.000	3809	302523
304892	1.000	3810	302523
304893	2.000	3811	302523
304894	2.000	3812	302523
304895	1.000	3813	302523
304896	1.000	3814	302523
304897	1.000	3815	302523
304898	1.000	3816	302523
304899	1.000	3817	302523
304900	1.000	3818	302523
304901	1.000	3819	302523
304902	2.000	3820	302523
304903	1.000	3808	302524
304904	1.000	3809	302524
304905	1.000	3810	302524
304906	2.000	3811	302524
304907	2.000	3812	302524
304908	1.000	3813	302524
304909	1.000	3814	302524
304910	1.000	3815	302524
304911	1.000	3816	302524
304912	1.000	3817	302524
304913	1.000	3818	302524
304914	1.000	3819	302524
304915	2.000	3820	302524
304916	1.000	3808	302525
304917	1.000	3809	302525
304918	1.000	3810	302525
304919	2.000	3811	302525
304920	2.000	3812	302525
304921	1.000	3813	302525
304922	1.000	3814	302525
304923	1.000	3815	302525
304924	1.000	3816	302525
304925	1.000	3817	302525
304926	1.000	3818	302525
304927	1.000	3819	302525
304928	2.000	3820	302525
304929	1.000	3808	302526
304930	1.000	3809	302526
304931	1.000	3810	302526
304932	2.000	3811	302526
304933	2.000	3812	302526
304934	1.000	3813	302526
304935	1.000	3814	302526
304936	1.000	3815	302526
304937	1.000	3816	302526
304938	1.000	3817	302526
304939	1.000	3818	302526
304940	1.000	3819	302526
304941	2.000	3820	302526
304959	1.000	3801	302529
304960	1.000	3801	302530
304961	1.000	3802	302531
304962	12.000	3803	302531
304963	1.000	3804	302531
304964	12.000	3805	302531
304965	1.000	3806	302531
304966	1.000	3802	302532
304967	12.000	3803	302532
304968	1.000	3804	302532
304969	12.000	3805	302532
304970	1.000	3806	302532
304971	5.000	3784	302533
304972	5.000	3784	302534
304973	5.000	3784	302535
304974	5.000	3784	302536
304975	1.000	3785	302537
304976	1.000	3786	302537
304977	4.000	3787	302537
304978	1.000	3788	302537
304979	2.000	3789	302537
304980	1.000	3790	302537
304981	2.000	3791	302537
304982	1.000	3792	302537
304983	1.000	3793	302537
304984	1.000	3794	302537
304985	1.000	3795	302537
304986	1.000	3796	302537
304987	2.000	3797	302537
304988	1.000	3798	302537
304989	1.000	3799	302537
304990	4.000	3800	302537
304991	1.000	3785	302538
304992	1.000	3786	302538
304993	4.000	3787	302538
304994	1.000	3788	302538
304995	2.000	3789	302538
304996	1.000	3790	302538
304997	2.000	3791	302538
304998	1.000	3792	302538
304999	1.000	3793	302538
305000	1.000	3794	302538
305001	1.000	3795	302538
305002	1.000	3796	302538
305003	2.000	3797	302538
305004	1.000	3798	302538
305005	1.000	3799	302538
305006	4.000	3800	302538
305007	1.000	3785	302539
305008	1.000	3786	302539
305009	4.000	3787	302539
305010	1.000	3788	302539
305011	2.000	3789	302539
305012	1.000	3790	302539
305013	2.000	3791	302539
305014	1.000	3792	302539
305015	1.000	3793	302539
305016	1.000	3794	302539
305017	1.000	3795	302539
305018	1.000	3796	302539
305019	2.000	3797	302539
305020	1.000	3798	302539
305021	1.000	3799	302539
305022	4.000	3800	302539
305023	36.000	3715	302540
305024	1.000	3733	302541
305025	1.000	3734	302541
305026	1.000	3733	302542
305027	1.000	3734	302542
305028	1.000	3733	302543
305029	1.000	3734	302543
305030	1.000	3733	302544
305031	1.000	3734	302544
305032	1.000	3735	302545
305033	1.000	3735	302546
305034	1.000	3735	302547
305035	1.000	3774	302548
305036	1.000	3775	302548
305037	1.000	3776	302548
305038	1.000	3777	302548
305039	4.000	3778	302548
305040	2.000	3779	302548
305041	1.000	3780	302548
305042	4.000	3781	302548
305043	4.000	3782	302548
305044	1.000	3783	302548
305045	1.000	3774	302549
305046	1.000	3775	302549
305047	1.000	3776	302549
305048	1.000	3777	302549
305049	4.000	3778	302549
305050	2.000	3779	302549
305051	1.000	3780	302549
305052	4.000	3781	302549
305053	4.000	3782	302549
305054	1.000	3783	302549
305055	1.000	3774	302550
305056	1.000	3775	302550
305057	1.000	3776	302550
305058	1.000	3777	302550
305059	4.000	3778	302550
305060	2.000	3779	302550
305061	1.000	3780	302550
305062	4.000	3781	302550
305063	4.000	3782	302550
305064	1.000	3783	302550
305065	1.000	3736	302652
305066	1.000	3737	302652
305067	1.000	3738	302652
305068	1.000	3739	302652
305069	1.000	3740	302652
305070	1.000	3741	302652
305071	1.000	3742	302652
305072	1.000	3743	302652
305073	1.000	3744	302652
305074	1.000	3745	302652
305075	2.000	3746	302652
305076	1.000	3747	302652
305077	1.000	3748	302652
305078	1.000	3749	302652
305079	1.000	3750	302652
305080	1.000	3751	302652
305081	1.000	3752	302652
305082	1.000	3753	302652
305083	1.000	3736	302653
305084	1.000	3737	302653
305085	1.000	3738	302653
305086	1.000	3739	302653
305087	1.000	3740	302653
305088	1.000	3741	302653
305089	1.000	3742	302653
305090	1.000	3743	302653
305091	1.000	3744	302653
305092	1.000	3745	302653
305093	2.000	3746	302653
305094	1.000	3747	302653
305095	1.000	3748	302653
305096	1.000	3749	302653
305097	1.000	3750	302653
305098	1.000	3751	302653
305099	1.000	3752	302653
305100	1.000	3753	302653
305101	1.000	3736	302654
305102	1.000	3737	302654
305103	1.000	3738	302654
305104	1.000	3739	302654
305105	1.000	3740	302654
305106	1.000	3741	302654
305107	1.000	3742	302654
305108	1.000	3743	302654
305109	1.000	3744	302654
305110	1.000	3745	302654
305111	2.000	3746	302654
305112	1.000	3747	302654
305113	1.000	3748	302654
305114	1.000	3749	302654
305115	1.000	3750	302654
305116	1.000	3751	302654
305117	1.000	3752	302654
305118	1.000	3753	302654
305119	1.000	3736	302655
305120	1.000	3737	302655
305121	1.000	3738	302655
305122	1.000	3739	302655
305123	1.000	3740	302655
305124	1.000	3741	302655
305125	1.000	3742	302655
305126	1.000	3743	302655
305127	1.000	3744	302655
305128	1.000	3745	302655
305129	2.000	3746	302655
305130	1.000	3747	302655
305131	1.000	3748	302655
305132	1.000	3749	302655
305133	1.000	3750	302655
305134	1.000	3751	302655
305135	1.000	3752	302655
305136	1.000	3753	302655
305137	1.000	3736	302656
305138	1.000	3737	302656
305139	1.000	3738	302656
305140	1.000	3739	302656
305141	1.000	3740	302656
305142	1.000	3741	302656
305143	1.000	3742	302656
305144	1.000	3743	302656
305145	1.000	3744	302656
305146	1.000	3745	302656
305147	2.000	3746	302656
305148	1.000	3747	302656
305149	1.000	3748	302656
305150	1.000	3749	302656
305151	1.000	3750	302656
305152	1.000	3751	302656
305153	1.000	3752	302656
305154	1.000	3753	302656
305155	3.000	3754	302657
305156	1.000	3755	302657
305157	1.000	3756	302657
305158	1.000	3757	302657
305159	1.000	3758	302657
305160	1.000	3759	302657
305161	1.000	3760	302657
305162	3.000	3761	302657
305163	1.000	3762	302657
305164	1.000	3763	302657
305165	3.000	3764	302657
305166	3.000	3765	302657
305167	1.000	3766	302657
305168	1.000	3767	302657
305169	1.000	3768	302657
305170	1.000	3769	302657
305171	3.000	3770	302657
305172	3.000	3771	302657
305173	1.000	3772	302657
305174	1.000	3773	302657
305175	3.000	3754	302658
305176	1.000	3755	302658
305177	1.000	3756	302658
305178	1.000	3757	302658
305179	1.000	3758	302658
305180	1.000	3759	302658
305181	1.000	3760	302658
305182	3.000	3761	302658
305183	1.000	3762	302658
305184	1.000	3763	302658
305185	3.000	3764	302658
305186	3.000	3765	302658
305187	1.000	3766	302658
305188	1.000	3767	302658
305189	1.000	3768	302658
305190	1.000	3769	302658
305191	3.000	3770	302658
305192	3.000	3771	302658
305193	1.000	3772	302658
305194	1.000	3773	302658
305195	3.000	3754	302659
305196	1.000	3755	302659
305197	1.000	3756	302659
305198	1.000	3757	302659
305199	1.000	3758	302659
305200	1.000	3759	302659
305201	1.000	3760	302659
305202	3.000	3761	302659
305203	1.000	3762	302659
305204	1.000	3763	302659
305205	3.000	3764	302659
305206	3.000	3765	302659
305207	1.000	3766	302659
305208	1.000	3767	302659
305209	1.000	3768	302659
305210	1.000	3769	302659
305211	3.000	3770	302659
305212	3.000	3771	302659
305213	1.000	3772	302659
305214	1.000	3773	302659
305215	3.000	3754	302660
305216	1.000	3755	302660
305217	1.000	3756	302660
305218	1.000	3757	302660
305219	1.000	3758	302660
305220	1.000	3759	302660
305221	1.000	3760	302660
305222	3.000	3761	302660
305223	1.000	3762	302660
305224	1.000	3763	302660
305225	3.000	3764	302660
305226	3.000	3765	302660
305227	1.000	3766	302660
305228	1.000	3767	302660
305229	1.000	3768	302660
305230	1.000	3769	302660
305231	3.000	3770	302660
305232	3.000	3771	302660
305233	1.000	3772	302660
305234	1.000	3773	302660
61475	1.000	1646	62846
61478	1.000	1646	62849
61480	1.000	1646	62851
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 44, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 11, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 25, true);


--
-- Name: import_batches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.import_batches_id_seq', 48, true);


--
-- Name: pedido_itens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_itens_id_seq', 4327, true);


--
-- Name: pedido_volumes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_volumes_id_seq', 302988, true);


--
-- Name: pedidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedidos_id_seq', 355, true);


--
-- Name: volume_itens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.volume_itens_id_seq', 306151, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: import_batches import_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_batches
    ADD CONSTRAINT import_batches_pkey PRIMARY KEY (id);


--
-- Name: pedido_itens pedido_itens_pedido_id_codigo_produto_1c5293b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_itens
    ADD CONSTRAINT pedido_itens_pedido_id_codigo_produto_1c5293b0_uniq UNIQUE (pedido_id, codigo_produto, descricao, linha_origem);


--
-- Name: pedido_itens pedido_itens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_itens
    ADD CONSTRAINT pedido_itens_pkey PRIMARY KEY (id);


--
-- Name: pedido_volumes pedido_volumes_pedido_id_volume_num_e4668409_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_volumes
    ADD CONSTRAINT pedido_volumes_pedido_id_volume_num_e4668409_uniq UNIQUE (pedido_id, volume_num);


--
-- Name: pedido_volumes pedido_volumes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_volumes
    ADD CONSTRAINT pedido_volumes_pkey PRIMARY KEY (id);


--
-- Name: pedidos pedidos_picking_numero_pedido_5cf03bdf_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_picking_numero_pedido_5cf03bdf_uniq UNIQUE (picking, numero_pedido);


--
-- Name: pedidos pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (id);


--
-- Name: volume_itens volume_itens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volume_itens
    ADD CONSTRAINT volume_itens_pkey PRIMARY KEY (id);


--
-- Name: volume_itens volume_itens_volume_id_item_id_23236534_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volume_itens
    ADD CONSTRAINT volume_itens_volume_id_item_id_23236534_uniq UNIQUE (volume_id, item_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: pedido_itens_pedido_id_762d01a1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pedido_itens_pedido_id_762d01a1 ON public.pedido_itens USING btree (pedido_id);


--
-- Name: pedido_volumes_pedido_id_737bc5e9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pedido_volumes_pedido_id_737bc5e9 ON public.pedido_volumes USING btree (pedido_id);


--
-- Name: volume_itens_item_id_62e88330; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX volume_itens_item_id_62e88330 ON public.volume_itens USING btree (item_id);


--
-- Name: volume_itens_volume_id_2db69dbe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX volume_itens_volume_id_2db69dbe ON public.volume_itens USING btree (volume_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pedido_itens pedido_itens_pedido_id_762d01a1_fk_pedidos_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_itens
    ADD CONSTRAINT pedido_itens_pedido_id_762d01a1_fk_pedidos_id FOREIGN KEY (pedido_id) REFERENCES public.pedidos(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pedido_volumes pedido_volumes_pedido_id_737bc5e9_fk_pedidos_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_volumes
    ADD CONSTRAINT pedido_volumes_pedido_id_737bc5e9_fk_pedidos_id FOREIGN KEY (pedido_id) REFERENCES public.pedidos(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: volume_itens volume_itens_item_id_62e88330_fk_pedido_itens_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volume_itens
    ADD CONSTRAINT volume_itens_item_id_62e88330_fk_pedido_itens_id FOREIGN KEY (item_id) REFERENCES public.pedido_itens(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: volume_itens volume_itens_volume_id_2db69dbe_fk_pedido_volumes_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volume_itens
    ADD CONSTRAINT volume_itens_volume_id_2db69dbe_fk_pedido_volumes_id FOREIGN KEY (volume_id) REFERENCES public.pedido_volumes(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\unrestrict vpcRnN97vADewl96TOaRuWELYSCPXzC5qMOl9rrkvsh3XW2ahyeS8MQTmN06Gpb

