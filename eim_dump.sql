--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE eim;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:1f5EeOh2Zf860bdSpT0mxw==$ziDjqQ5DCgu+a/aRdKEQ/mnrypwam0qA+bIbp+q1fFk=:pxnbWKx9u9dTEtQFjtoQ4kAjEWYawnlYh7Hr+GLoyms=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg120+1)
-- Dumped by pg_dump version 15.3 (Debian 15.3-1.pgdg120+1)

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "eim" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg120+1)
-- Dumped by pg_dump version 15.3 (Debian 15.3-1.pgdg120+1)

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
-- Name: eim; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE eim WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE eim OWNER TO postgres;

\connect eim

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
-- Name: eim; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA eim;


ALTER SCHEMA eim OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.account (
    id bigint NOT NULL,
    name character varying(40) NOT NULL,
    last_nm character varying(40) NOT NULL,
    first_nm character varying(40) NOT NULL,
    middle_nm character varying(40) NOT NULL,
    birth_dt date,
    position_id bigint NOT NULL,
    department_id bigint NOT NULL,
    email character varying(40) NOT NULL,
    phone character varying(40),
    pwd_hash character varying(4096),
    pwd_hash_alg_id bigint NOT NULL,
    ooo_status_id bigint NOT NULL,
    status_id bigint NOT NULL,
    expire_plan_dt date NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    create_user_id bigint,
    update_user_id bigint,
    access_memorandum_no character varying(500) DEFAULT ''::character varying NOT NULL,
    failed_login_cnt integer DEFAULT 0 NOT NULL,
    account_lock_ts timestamp with time zone
);


ALTER TABLE eim.account OWNER TO postgres;

--
-- Name: account_ooo; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.account_ooo (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    ooo_begin_dt date NOT NULL,
    ooo_end_dt date NOT NULL,
    deputy_id bigint NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.account_ooo OWNER TO postgres;

--
-- Name: account_role; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.account_role (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    role_id bigint NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    create_user_id bigint,
    update_user_id bigint,
    expire_role_dt date
);


ALTER TABLE eim.account_role OWNER TO postgres;

--
-- Name: account_status; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.account_status (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    status_id bigint NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    create_user_id bigint,
    update_user_id bigint
);


ALTER TABLE eim.account_status OWNER TO postgres;

--
-- Name: admin_audit; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.admin_audit (
    id bigint NOT NULL,
    admin_id bigint NOT NULL,
    admin_nm character varying(400) NOT NULL,
    admin_dept_nm character varying(400) NOT NULL,
    admin_login character varying(400) NOT NULL,
    user_id bigint NOT NULL,
    user_login character varying(400) NOT NULL,
    user_nm character varying(400) NOT NULL,
    user_dept_nm character varying(400) NOT NULL,
    user_session_id bigint NOT NULL,
    ip_address character varying(40) NOT NULL,
    opr_dsc character varying(400) NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.admin_audit OWNER TO postgres;

--
-- Name: classification; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.classification (
    id bigint NOT NULL,
    dimension_id bigint,
    parent_id bigint,
    object_tp_id bigint,
    code character varying(400) NOT NULL,
    name character varying(400) DEFAULT ''::character varying NOT NULL,
    description character varying(4000),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    create_user_id bigint,
    update_user_id bigint,
    rank integer
);


ALTER TABLE eim.classification OWNER TO postgres;

--
-- Name: classification_to_classification; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.classification_to_classification (
    id bigint NOT NULL,
    object_id bigint NOT NULL,
    subject_id bigint NOT NULL,
    relation_tp_id bigint,
    rank integer,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.classification_to_classification OWNER TO postgres;

--
-- Name: classification_to_classification_id_seq; Type: SEQUENCE; Schema: eim; Owner: postgres
--

CREATE SEQUENCE eim.classification_to_classification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eim.classification_to_classification_id_seq OWNER TO postgres;

--
-- Name: classification_to_classification_id_seq; Type: SEQUENCE OWNED BY; Schema: eim; Owner: postgres
--

ALTER SEQUENCE eim.classification_to_classification_id_seq OWNED BY eim.classification_to_classification.id;


--
-- Name: dimension; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.dimension (
    id bigint NOT NULL,
    code character varying(40),
    name character varying(400) NOT NULL,
    description character varying(4000),
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    create_user_id bigint,
    update_user_id bigint
);


ALTER TABLE eim.dimension OWNER TO postgres;

--
-- Name: edge; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.edge (
    id bigint NOT NULL,
    polygon_id bigint NOT NULL,
    station_from_id bigint NOT NULL,
    station_to_id bigint NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    code character varying(40),
    name character varying(400),
    hl_net_ind boolean DEFAULT false NOT NULL,
    reg_konca_per character varying(400),
    parent_edge_id bigint,
    region_from_id bigint,
    region_to_id bigint
);


ALTER TABLE eim.edge OWNER TO postgres;

--
-- Name: edge_detail; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.edge_detail (
    id bigint NOT NULL,
    scenario_id bigint NOT NULL,
    start_id integer NOT NULL,
    end_id integer NOT NULL,
    year integer NOT NULL,
    train double precision NOT NULL,
    empty double precision NOT NULL,
    capacity double precision NOT NULL,
    n_train double precision NOT NULL,
    n_empty double precision NOT NULL,
    delta double precision NOT NULL,
    delta_delta double precision NOT NULL,
    start_name character varying(400) NOT NULL,
    start_ers integer NOT NULL,
    end_name character varying(400) NOT NULL,
    end_esr integer NOT NULL,
    passport_end integer NOT NULL,
    passport_start integer NOT NULL,
    dor_name character varying(40) NOT NULL,
    dor_kod integer NOT NULL,
    span_number integer NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    hl_start_id integer NOT NULL,
    hl_end_id integer NOT NULL
);


ALTER TABLE eim.edge_detail OWNER TO postgres;

--
-- Name: idx_value; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.idx_value (
    id bigint NOT NULL,
    macro_scenario_id bigint NOT NULL,
    idx_tp_id bigint NOT NULL,
    year integer NOT NULL,
    val double precision NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    CONSTRAINT idx_value_year_check CHECK ((year > 1900))
);


ALTER TABLE eim.idx_value OWNER TO postgres;

--
-- Name: income_tax; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.income_tax (
    id bigint NOT NULL,
    tax_id bigint NOT NULL,
    year integer NOT NULL,
    tax_rate double precision NOT NULL,
    fed_share double precision NOT NULL,
    payment_period integer NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    CONSTRAINT income_tax_year_check CHECK ((year > 1900))
);


ALTER TABLE eim.income_tax OWNER TO postgres;

--
-- Name: integration_process; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.integration_process (
    id bigint NOT NULL,
    transaction_id uuid,
    master_system_id bigint NOT NULL,
    slave_system_id bigint NOT NULL,
    process_id bigint NOT NULL,
    process_start_ts timestamp with time zone NOT NULL,
    process_end_ts timestamp with time zone,
    process_result_id bigint NOT NULL,
    process_msg character varying(4000),
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    create_user_id bigint,
    update_user_id bigint
);


ALTER TABLE eim.integration_process OWNER TO postgres;

--
-- Name: investment_project; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.investment_project (
    id bigint NOT NULL,
    name character varying(400) NOT NULL,
    description character varying(4000) NOT NULL,
    version_num integer DEFAULT 1 NOT NULL,
    version_letter character varying(1) DEFAULT 'A'::character varying NOT NULL,
    parent_investment_project_id bigint,
    polygon_id bigint NOT NULL,
    func_cst_id bigint NOT NULL,
    ip_inclusion_tp_id bigint NOT NULL,
    asset_tp_id bigint NOT NULL,
    goal_tp_id bigint NOT NULL,
    purpose_tp_id bigint NOT NULL,
    prj_func_tp_id bigint NOT NULL,
    phase_tp_id bigint NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    create_user_id bigint,
    update_user_id bigint,
    CONSTRAINT investment_project_version_num_check CHECK ((version_num > 0))
);


ALTER TABLE eim.investment_project OWNER TO postgres;

--
-- Name: investment_project_fund; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.investment_project_fund (
    id bigint NOT NULL,
    investment_project_id bigint NOT NULL,
    name character varying(400) NOT NULL,
    funding_tp_id bigint NOT NULL,
    year integer NOT NULL,
    investment_amt double precision DEFAULT 0 NOT NULL,
    loan_rate double precision,
    loan_period integer,
    repayment_tp_id bigint,
    priviledge_duration integer,
    priviledge_loan_rate double precision,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    CONSTRAINT investment_project_fund_year_check CHECK ((year > 1900))
);


ALTER TABLE eim.investment_project_fund OWNER TO postgres;

--
-- Name: land_tax; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.land_tax (
    id bigint NOT NULL,
    tax_id bigint NOT NULL,
    year integer NOT NULL,
    tax_rate double precision NOT NULL,
    payment_period integer NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    CONSTRAINT land_tax_year_check CHECK ((year > 1900))
);


ALTER TABLE eim.land_tax OWNER TO postgres;

--
-- Name: macro_scenario; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.macro_scenario (
    id bigint NOT NULL,
    name character varying(400) NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    create_user_id bigint,
    update_user_id bigint
);


ALTER TABLE eim.macro_scenario OWNER TO postgres;

--
-- Name: migration_log; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.migration_log (
    id bigint NOT NULL,
    connection_string character varying(400) NOT NULL,
    dbver_before integer DEFAULT 1,
    dbver_after integer DEFAULT 1,
    migration_script_id bigint NOT NULL,
    script bytea NOT NULL,
    execution_log bytea NOT NULL,
    success_ind boolean DEFAULT false NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    CONSTRAINT migration_log_dbver_after_check CHECK ((dbver_after > 0)),
    CONSTRAINT migration_log_dbver_before_check CHECK ((dbver_before > 0))
);


ALTER TABLE eim.migration_log OWNER TO postgres;

--
-- Name: migration_script; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.migration_script (
    id bigint NOT NULL,
    dbver_before integer DEFAULT 1,
    script_name character varying(400) NOT NULL,
    dbver_after integer DEFAULT 1,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    CONSTRAINT migration_script_dbver_after_check CHECK ((dbver_after > 0)),
    CONSTRAINT migration_script_dbver_before_check CHECK ((dbver_before > 0))
);


ALTER TABLE eim.migration_script OWNER TO postgres;

--
-- Name: property_tax; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.property_tax (
    id bigint NOT NULL,
    tax_id bigint NOT NULL,
    year integer NOT NULL,
    evol_investment_tax_rate double precision NOT NULL,
    renov_investment_tax_rate double precision NOT NULL,
    evol_reduction_rate double precision NOT NULL,
    renov_growth_rate double precision NOT NULL,
    accounting_rate double precision NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    payment_period integer DEFAULT 0 NOT NULL,
    CONSTRAINT property_tax_year_check CHECK ((year > 1900))
);


ALTER TABLE eim.property_tax OWNER TO postgres;

--
-- Name: scenario; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario (
    id bigint NOT NULL,
    parent_id bigint,
    name character varying(400) NOT NULL,
    description character varying(4000),
    year_from integer,
    year_to integer,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    create_user_id bigint,
    update_user_id bigint,
    calculation_tp_id bigint DEFAULT 1155 NOT NULL,
    calculation_status_id bigint DEFAULT 1158 NOT NULL,
    cargo_scenario_id bigint,
    investment_project_id bigint,
    macro_scenario_id bigint,
    inflation_user_ind boolean DEFAULT true NOT NULL,
    tax_id bigint,
    indicators_fin_lst bigint[],
    indicators_nat_lst bigint[],
    bottleneck_liquidation_ind boolean DEFAULT false NOT NULL,
    CONSTRAINT scenario_year_from_check CHECK ((year_from > 1900)),
    CONSTRAINT scenario_year_to_check CHECK ((year_to > 1900))
);


ALTER TABLE eim.scenario OWNER TO postgres;

--
-- Name: scenario_acl; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_acl (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    access_tp_id bigint NOT NULL,
    script bigint NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    create_user_id bigint,
    update_user_id bigint
);


ALTER TABLE eim.scenario_acl OWNER TO postgres;

--
-- Name: scenario_aggr_road; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_aggr_road (
    id bigint NOT NULL,
    scenario_id bigint NOT NULL,
    railroad_id bigint NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.scenario_aggr_road OWNER TO postgres;

--
-- Name: scenario_aggr_road_span; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_aggr_road_span (
    id bigint NOT NULL,
    scenario_aggr_road_id bigint NOT NULL,
    varid bigint NOT NULL,
    roadid bigint NOT NULL,
    fragid bigint NOT NULL,
    spanid bigint NOT NULL,
    fragnum bigint NOT NULL,
    spannum bigint NOT NULL,
    passportnum character varying(400) NOT NULL,
    beginstation bigint NOT NULL,
    endstation bigint NOT NULL,
    beginstationname character varying(400) NOT NULL,
    endstationname character varying(400) NOT NULL,
    year integer NOT NULL,
    glp bigint NOT NULL,
    controltype character varying(400) NOT NULL,
    tractiontype character varying(400) NOT NULL,
    length bigint NOT NULL,
    massloadfwd bigint NOT NULL,
    massloadbwd bigint NOT NULL,
    capacitynoparallelcargofwd bigint NOT NULL,
    capacitynoparallelcargobwd bigint NOT NULL,
    capacitynoparallelpassfwd bigint NOT NULL,
    capacitynoparallelpassbwd bigint NOT NULL,
    requiredcapacityfwd bigint NOT NULL,
    requiredcapacitybwd bigint NOT NULL,
    cargoloadfwd bigint NOT NULL,
    cargoloadbwd bigint NOT NULL,
    trainsfwd bigint NOT NULL,
    trainsbwd bigint NOT NULL,
    suburbanfwd bigint NOT NULL,
    suburbanbwd bigint NOT NULL,
    suburbanspeedfwd bigint NOT NULL,
    suburbanspeedbwd bigint NOT NULL,
    passengerfwd bigint NOT NULL,
    passengerbwd bigint NOT NULL,
    passengerspeedfwd bigint NOT NULL,
    passengerspeedbwd bigint NOT NULL,
    reservefwd bigint NOT NULL,
    reservebwd bigint NOT NULL,
    detours character varying(4000),
    actions character varying(4000),
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    CONSTRAINT scenario_aggr_road_span_year_check CHECK ((year > 1900))
);


ALTER TABLE eim.scenario_aggr_road_span OWNER TO postgres;

--
-- Name: scenario_arrangement_include; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_arrangement_include (
    id bigint NOT NULL,
    scenario_id bigint NOT NULL,
    arrangement_id bigint,
    include_ind boolean DEFAULT true NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    scenario_event_id bigint
);


ALTER TABLE eim.scenario_arrangement_include OWNER TO postgres;

--
-- Name: scenario_bottleneck; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_bottleneck (
    id bigint NOT NULL,
    scenario_id bigint NOT NULL,
    road bigint NOT NULL,
    year integer NOT NULL,
    begin_stan bigint NOT NULL,
    end_stan bigint NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    slice_tp_id bigint NOT NULL
);


ALTER TABLE eim.scenario_bottleneck OWNER TO postgres;

--
-- Name: scenario_bottleneck_correspondence; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_bottleneck_correspondence (
    id bigint NOT NULL,
    scenario_bottleneck_id bigint NOT NULL,
    corr_id bigint NOT NULL,
    start_stan bigint NOT NULL,
    end_stan bigint NOT NULL,
    cargo_type bigint NOT NULL,
    transit_type character varying(40) NOT NULL,
    container character varying(40) NOT NULL,
    summ double precision NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.scenario_bottleneck_correspondence OWNER TO postgres;

--
-- Name: scenario_calculation; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_calculation (
    id bigint NOT NULL,
    scenario_id bigint NOT NULL,
    calculation_tp_id bigint DEFAULT 1155 NOT NULL,
    calculation_status_id bigint DEFAULT 1158 NOT NULL,
    rank integer DEFAULT 0 NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    create_user_id bigint,
    update_user_id bigint,
    calc_phase_done_lst bigint[],
    calc_phase_current_id bigint DEFAULT 0
);


ALTER TABLE eim.scenario_calculation OWNER TO postgres;

--
-- Name: scenario_eq_cost; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_eq_cost (
    id bigint NOT NULL,
    scenario_id bigint NOT NULL,
    railroad_id bigint NOT NULL,
    year integer DEFAULT 2023 NOT NULL,
    factor double precision DEFAULT 0 NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.scenario_eq_cost OWNER TO postgres;

--
-- Name: scenario_eq_tariff; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_eq_tariff (
    id bigint NOT NULL,
    scenario_id bigint NOT NULL,
    cargo_hl_tp_id bigint NOT NULL,
    factor double precision DEFAULT 0 NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.scenario_eq_tariff OWNER TO postgres;

--
-- Name: scenario_event; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_event (
    id bigint NOT NULL,
    scenario_id bigint NOT NULL,
    var_id bigint NOT NULL,
    load_dt date NOT NULL,
    evolution_tp_nm character varying(400) NOT NULL,
    event_start date NOT NULL,
    effective_dt date NOT NULL,
    spiui_id character varying(400) NOT NULL,
    invest_sum double precision NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.scenario_event OWNER TO postgres;

--
-- Name: scenario_event_info; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_event_info (
    id bigint NOT NULL,
    scenario_event_id bigint NOT NULL,
    len double precision NOT NULL,
    code_to bigint NOT NULL,
    code_from bigint NOT NULL,
    patch_count_after bigint,
    patch_count_before bigint,
    locomotive_tp_after character varying(40),
    locomotive_tp_before character varying(40),
    communication_tool_after character varying(40),
    communication_tool_before character varying(40),
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.scenario_event_info OWNER TO postgres;

--
-- Name: scenario_event_schedule; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_event_schedule (
    id bigint NOT NULL,
    scenario_event_info_id bigint NOT NULL,
    year integer NOT NULL,
    load double precision NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.scenario_event_schedule OWNER TO postgres;

--
-- Name: scenario_opcost; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_opcost (
    id bigint NOT NULL,
    scenario_id bigint NOT NULL,
    var_id bigint NOT NULL,
    corr_id bigint NOT NULL,
    station_from_cd bigint NOT NULL,
    station_to_cd bigint NOT NULL,
    cargo_tp_cd bigint NOT NULL,
    gr_code_usl bigint NOT NULL,
    rod_gr_name character varying(40) NOT NULL,
    delivery_tp character varying(40) NOT NULL,
    ves double precision NOT NULL,
    cost_loaded_amt double precision NOT NULL,
    cost_empty_amt double precision NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.scenario_opcost OWNER TO postgres;

--
-- Name: scenario_opcost_schedule; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_opcost_schedule (
    id bigint NOT NULL,
    scenario_opcost_id bigint NOT NULL,
    year integer NOT NULL,
    car_count double precision NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.scenario_opcost_schedule OWNER TO postgres;

--
-- Name: scenario_res; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_res (
    id bigint NOT NULL,
    scenario_id bigint NOT NULL,
    slice_tp_id bigint NOT NULL,
    income_amt double precision NOT NULL,
    cost_amt double precision NOT NULL,
    evol_capex_amt double precision NOT NULL,
    renov_capex_amt double precision NOT NULL,
    npv_own_amt double precision NOT NULL,
    npv_fed_amt double precision NOT NULL,
    npv_region_amt double precision NOT NULL,
    spp integer NOT NULL,
    dpp integer NOT NULL,
    irr double precision NOT NULL,
    bottleneck_cnt integer NOT NULL,
    delivery_gap_amt double precision NOT NULL,
    delivery_gap double precision NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.scenario_res OWNER TO postgres;

--
-- Name: scenario_res_pivot; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_res_pivot (
    id bigint NOT NULL,
    year integer DEFAULT 2023 NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    scenario_res_id bigint NOT NULL,
    operational_cost_amt double precision NOT NULL,
    pure_income_amt double precision NOT NULL,
    ebit_amt double precision NOT NULL,
    ebitda_amt double precision NOT NULL,
    tax_amt double precision NOT NULL,
    tax_vat_amt double precision NOT NULL,
    tax_income_amt double precision NOT NULL,
    tax_land_amt double precision NOT NULL,
    tax_property_amt double precision NOT NULL,
    fcf_amt double precision NOT NULL,
    fcff_amt double precision NOT NULL,
    evol_capex_amt double precision NOT NULL,
    renov_capex_amt double precision NOT NULL,
    fcf_own_amt double precision NOT NULL,
    fcfe_amt double precision NOT NULL
);


ALTER TABLE eim.scenario_res_pivot OWNER TO postgres;

--
-- Name: scenario_res_pivot_invest; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_res_pivot_invest (
    id bigint NOT NULL,
    scenario_res_pivot_id bigint NOT NULL,
    investment_amt double precision NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    funding_tp_id bigint NOT NULL
);


ALTER TABLE eim.scenario_res_pivot_invest OWNER TO postgres;

--
-- Name: scenario_res_pnl; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_res_pnl (
    id bigint NOT NULL,
    cargo_hl_tp_id bigint NOT NULL,
    year integer DEFAULT 2023 NOT NULL,
    income_amt double precision NOT NULL,
    income_growth_amt double precision NOT NULL,
    cost_amt double precision NOT NULL,
    cost_growth_amt double precision NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    scenario_res_id bigint NOT NULL,
    delivery double precision NOT NULL,
    delivery_gap double precision NOT NULL,
    delivery_rate double precision NOT NULL,
    delivery_gap_rub double precision NOT NULL
);


ALTER TABLE eim.scenario_res_pnl OWNER TO postgres;

--
-- Name: scenario_tariff; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.scenario_tariff (
    id bigint NOT NULL,
    scenario_id bigint NOT NULL,
    var_id bigint NOT NULL,
    corr_id bigint NOT NULL,
    calculation_dt date NOT NULL,
    st_ot_id bigint NOT NULL,
    st_nz_id bigint NOT NULL,
    station_from bigint NOT NULL,
    station_to bigint NOT NULL,
    cargo_tp bigint NOT NULL,
    cargo_tp1_cd bigint NOT NULL,
    shipment_tp character varying(40) NOT NULL,
    year integer NOT NULL,
    route_tp character varying(40) NOT NULL,
    car_num_per_day double precision NOT NULL,
    volume_corr double precision NOT NULL,
    st_ot_nx character varying(40) NOT NULL,
    st_nz_nx character varying(40) NOT NULL,
    commute_tp character varying(40) NOT NULL,
    statng double precision NOT NULL,
    car_tp bigint NOT NULL,
    container character varying(40) NOT NULL,
    car_cnt_per_goup bigint NOT NULL,
    main_pay_loaded double precision NOT NULL,
    main_pay_empty double precision NOT NULL,
    add_pay_loaded double precision NOT NULL,
    add_pay_empty double precision NOT NULL,
    min_way double precision NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.scenario_tariff OWNER TO postgres;

--
-- Name: setting; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.setting (
    id bigint NOT NULL,
    parameter_id bigint NOT NULL,
    float_val double precision,
    str_val character varying(400) NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    create_user_id bigint,
    update_user_id bigint,
    int_val integer
);


ALTER TABLE eim.setting OWNER TO postgres;

--
-- Name: station; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.station (
    id bigint NOT NULL,
    name character varying(400) NOT NULL,
    code integer NOT NULL,
    lat double precision DEFAULT 0,
    lon double precision DEFAULT 0,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    code_cnsi integer DEFAULT 0 NOT NULL,
    x double precision DEFAULT 0,
    y double precision DEFAULT 0,
    hl_net_ind boolean DEFAULT false NOT NULL,
    railroad_id bigint,
    region_id bigint,
    CONSTRAINT station_lat_check CHECK ((lat >= (0)::double precision)),
    CONSTRAINT station_lon_check CHECK ((lon >= (0)::double precision))
);


ALTER TABLE eim.station OWNER TO postgres;

--
-- Name: tax; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.tax (
    id bigint NOT NULL,
    name character varying(400) NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    create_user_id bigint,
    update_user_id bigint
);


ALTER TABLE eim.tax OWNER TO postgres;

--
-- Name: te_version; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.te_version (
    id bigint NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    create_user_id bigint,
    update_user_id bigint,
    form_id bigint NOT NULL
);


ALTER TABLE eim.te_version OWNER TO postgres;

--
-- Name: user_audit; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.user_audit (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    user_nm character varying(400) NOT NULL,
    user_dept_nm character varying(400) NOT NULL,
    user_login character varying(400) NOT NULL,
    user_session_id bigint NOT NULL,
    ip_address character varying(40) NOT NULL,
    file_nm character varying(40) NOT NULL,
    data_dsc character varying(400) NOT NULL,
    file_sz double precision,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.user_audit OWNER TO postgres;

--
-- Name: user_event; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.user_event (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    user_event_tp_id bigint NOT NULL,
    description character varying(400) NOT NULL,
    url character varying(2048),
    read_ind boolean DEFAULT false NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.user_event OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.user_session (
    id bigint NOT NULL,
    account_id bigint,
    login_success_ind boolean NOT NULL,
    login_ts timestamp with time zone DEFAULT now(),
    ip_address character varying(40),
    supplied_user_name character varying(40) NOT NULL,
    jwt_token character varying(400),
    user_agent character varying(400),
    connection_tp_id bigint,
    session_end_ts date,
    duration real,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE eim.user_session OWNER TO postgres;

--
-- Name: vat; Type: TABLE; Schema: eim; Owner: postgres
--

CREATE TABLE eim.vat (
    id bigint NOT NULL,
    tax_id bigint NOT NULL,
    year integer NOT NULL,
    income_growth_tax_rate double precision NOT NULL,
    investment_tax_rate double precision NOT NULL,
    opr_cost_growth_tax_rate double precision NOT NULL,
    maintenance_tax_rate double precision NOT NULL,
    payment_period integer NOT NULL,
    create_ts timestamp with time zone DEFAULT now() NOT NULL,
    update_ts timestamp with time zone,
    end_ts timestamp with time zone DEFAULT 'infinity'::timestamp with time zone NOT NULL,
    CONSTRAINT vat_year_check CHECK ((year > 1900))
);


ALTER TABLE eim.vat OWNER TO postgres;

--
-- Name: classification_to_classification id; Type: DEFAULT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.classification_to_classification ALTER COLUMN id SET DEFAULT nextval('eim.classification_to_classification_id_seq'::regclass);


--
-- Data for Name: account; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.account (id, name, last_nm, first_nm, middle_nm, birth_dt, position_id, department_id, email, phone, pwd_hash, pwd_hash_alg_id, ooo_status_id, status_id, expire_plan_dt, create_ts, update_ts, end_ts, create_user_id, update_user_id, access_memorandum_no, failed_login_cnt, account_lock_ts) FROM stdin;
\.


--
-- Data for Name: account_ooo; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.account_ooo (id, account_id, ooo_begin_dt, ooo_end_dt, deputy_id, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: account_role; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.account_role (id, account_id, role_id, create_ts, update_ts, end_ts, create_user_id, update_user_id, expire_role_dt) FROM stdin;
\.


--
-- Data for Name: account_status; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.account_status (id, account_id, status_id, create_ts, update_ts, end_ts, create_user_id, update_user_id) FROM stdin;
\.


--
-- Data for Name: admin_audit; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.admin_audit (id, admin_id, admin_nm, admin_dept_nm, admin_login, user_id, user_login, user_nm, user_dept_nm, user_session_id, ip_address, opr_dsc, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: classification; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.classification (id, dimension_id, parent_id, object_tp_id, code, name, description, update_ts, end_ts, create_ts, create_user_id, update_user_id, rank) FROM stdin;
\.


--
-- Data for Name: classification_to_classification; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.classification_to_classification (id, object_id, subject_id, relation_tp_id, rank, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: dimension; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.dimension (id, code, name, description, create_ts, update_ts, end_ts, create_user_id, update_user_id) FROM stdin;
\.


--
-- Data for Name: edge; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.edge (id, polygon_id, station_from_id, station_to_id, create_ts, update_ts, end_ts, code, name, hl_net_ind, reg_konca_per, parent_edge_id, region_from_id, region_to_id) FROM stdin;
\.


--
-- Data for Name: edge_detail; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.edge_detail (id, scenario_id, start_id, end_id, year, train, empty, capacity, n_train, n_empty, delta, delta_delta, start_name, start_ers, end_name, end_esr, passport_end, passport_start, dor_name, dor_kod, span_number, create_ts, update_ts, end_ts, hl_start_id, hl_end_id) FROM stdin;
\.


--
-- Data for Name: idx_value; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.idx_value (id, macro_scenario_id, idx_tp_id, year, val, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: income_tax; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.income_tax (id, tax_id, year, tax_rate, fed_share, payment_period, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: integration_process; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.integration_process (id, transaction_id, master_system_id, slave_system_id, process_id, process_start_ts, process_end_ts, process_result_id, process_msg, create_ts, update_ts, end_ts, create_user_id, update_user_id) FROM stdin;
\.


--
-- Data for Name: investment_project; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.investment_project (id, name, description, version_num, version_letter, parent_investment_project_id, polygon_id, func_cst_id, ip_inclusion_tp_id, asset_tp_id, goal_tp_id, purpose_tp_id, prj_func_tp_id, phase_tp_id, create_ts, update_ts, end_ts, create_user_id, update_user_id) FROM stdin;
\.


--
-- Data for Name: investment_project_fund; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.investment_project_fund (id, investment_project_id, name, funding_tp_id, year, investment_amt, loan_rate, loan_period, repayment_tp_id, priviledge_duration, priviledge_loan_rate, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: land_tax; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.land_tax (id, tax_id, year, tax_rate, payment_period, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: macro_scenario; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.macro_scenario (id, name, create_ts, update_ts, end_ts, create_user_id, update_user_id) FROM stdin;
\.


--
-- Data for Name: migration_log; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.migration_log (id, connection_string, dbver_before, dbver_after, migration_script_id, script, execution_log, success_ind, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: migration_script; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.migration_script (id, dbver_before, script_name, dbver_after, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: property_tax; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.property_tax (id, tax_id, year, evol_investment_tax_rate, renov_investment_tax_rate, evol_reduction_rate, renov_growth_rate, accounting_rate, create_ts, update_ts, end_ts, payment_period) FROM stdin;
\.


--
-- Data for Name: scenario; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario (id, parent_id, name, description, year_from, year_to, create_ts, update_ts, end_ts, create_user_id, update_user_id, calculation_tp_id, calculation_status_id, cargo_scenario_id, investment_project_id, macro_scenario_id, inflation_user_ind, tax_id, indicators_fin_lst, indicators_nat_lst, bottleneck_liquidation_ind) FROM stdin;
\.


--
-- Data for Name: scenario_acl; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_acl (id, account_id, access_tp_id, script, create_ts, update_ts, end_ts, create_user_id, update_user_id) FROM stdin;
\.


--
-- Data for Name: scenario_aggr_road; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_aggr_road (id, scenario_id, railroad_id, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: scenario_aggr_road_span; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_aggr_road_span (id, scenario_aggr_road_id, varid, roadid, fragid, spanid, fragnum, spannum, passportnum, beginstation, endstation, beginstationname, endstationname, year, glp, controltype, tractiontype, length, massloadfwd, massloadbwd, capacitynoparallelcargofwd, capacitynoparallelcargobwd, capacitynoparallelpassfwd, capacitynoparallelpassbwd, requiredcapacityfwd, requiredcapacitybwd, cargoloadfwd, cargoloadbwd, trainsfwd, trainsbwd, suburbanfwd, suburbanbwd, suburbanspeedfwd, suburbanspeedbwd, passengerfwd, passengerbwd, passengerspeedfwd, passengerspeedbwd, reservefwd, reservebwd, detours, actions, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: scenario_arrangement_include; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_arrangement_include (id, scenario_id, arrangement_id, include_ind, create_ts, update_ts, end_ts, scenario_event_id) FROM stdin;
\.


--
-- Data for Name: scenario_bottleneck; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_bottleneck (id, scenario_id, road, year, begin_stan, end_stan, create_ts, update_ts, end_ts, slice_tp_id) FROM stdin;
\.


--
-- Data for Name: scenario_bottleneck_correspondence; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_bottleneck_correspondence (id, scenario_bottleneck_id, corr_id, start_stan, end_stan, cargo_type, transit_type, container, summ, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: scenario_calculation; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_calculation (id, scenario_id, calculation_tp_id, calculation_status_id, rank, create_ts, update_ts, end_ts, create_user_id, update_user_id, calc_phase_done_lst, calc_phase_current_id) FROM stdin;
\.


--
-- Data for Name: scenario_eq_cost; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_eq_cost (id, scenario_id, railroad_id, year, factor, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: scenario_eq_tariff; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_eq_tariff (id, scenario_id, cargo_hl_tp_id, factor, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: scenario_event; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_event (id, scenario_id, var_id, load_dt, evolution_tp_nm, event_start, effective_dt, spiui_id, invest_sum, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: scenario_event_info; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_event_info (id, scenario_event_id, len, code_to, code_from, patch_count_after, patch_count_before, locomotive_tp_after, locomotive_tp_before, communication_tool_after, communication_tool_before, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: scenario_event_schedule; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_event_schedule (id, scenario_event_info_id, year, load, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: scenario_opcost; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_opcost (id, scenario_id, var_id, corr_id, station_from_cd, station_to_cd, cargo_tp_cd, gr_code_usl, rod_gr_name, delivery_tp, ves, cost_loaded_amt, cost_empty_amt, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: scenario_opcost_schedule; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_opcost_schedule (id, scenario_opcost_id, year, car_count, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: scenario_res; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_res (id, scenario_id, slice_tp_id, income_amt, cost_amt, evol_capex_amt, renov_capex_amt, npv_own_amt, npv_fed_amt, npv_region_amt, spp, dpp, irr, bottleneck_cnt, delivery_gap_amt, delivery_gap, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: scenario_res_pivot; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_res_pivot (id, year, create_ts, update_ts, end_ts, scenario_res_id, operational_cost_amt, pure_income_amt, ebit_amt, ebitda_amt, tax_amt, tax_vat_amt, tax_income_amt, tax_land_amt, tax_property_amt, fcf_amt, fcff_amt, evol_capex_amt, renov_capex_amt, fcf_own_amt, fcfe_amt) FROM stdin;
\.


--
-- Data for Name: scenario_res_pivot_invest; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_res_pivot_invest (id, scenario_res_pivot_id, investment_amt, create_ts, update_ts, end_ts, funding_tp_id) FROM stdin;
\.


--
-- Data for Name: scenario_res_pnl; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_res_pnl (id, cargo_hl_tp_id, year, income_amt, income_growth_amt, cost_amt, cost_growth_amt, create_ts, update_ts, end_ts, scenario_res_id, delivery, delivery_gap, delivery_rate, delivery_gap_rub) FROM stdin;
\.


--
-- Data for Name: scenario_tariff; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.scenario_tariff (id, scenario_id, var_id, corr_id, calculation_dt, st_ot_id, st_nz_id, station_from, station_to, cargo_tp, cargo_tp1_cd, shipment_tp, year, route_tp, car_num_per_day, volume_corr, st_ot_nx, st_nz_nx, commute_tp, statng, car_tp, container, car_cnt_per_goup, main_pay_loaded, main_pay_empty, add_pay_loaded, add_pay_empty, min_way, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: setting; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.setting (id, parameter_id, float_val, str_val, create_ts, update_ts, end_ts, create_user_id, update_user_id, int_val) FROM stdin;
\.


--
-- Data for Name: station; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.station (id, name, code, lat, lon, create_ts, update_ts, end_ts, code_cnsi, x, y, hl_net_ind, railroad_id, region_id) FROM stdin;
\.


--
-- Data for Name: tax; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.tax (id, name, create_ts, update_ts, end_ts, create_user_id, update_user_id) FROM stdin;
\.


--
-- Data for Name: te_version; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.te_version (id, create_ts, update_ts, end_ts, create_user_id, update_user_id, form_id) FROM stdin;
\.


--
-- Data for Name: user_audit; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.user_audit (id, account_id, user_nm, user_dept_nm, user_login, user_session_id, ip_address, file_nm, data_dsc, file_sz, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: user_event; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.user_event (id, account_id, user_event_tp_id, description, url, read_ind, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.user_session (id, account_id, login_success_ind, login_ts, ip_address, supplied_user_name, jwt_token, user_agent, connection_tp_id, session_end_ts, duration, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Data for Name: vat; Type: TABLE DATA; Schema: eim; Owner: postgres
--

COPY eim.vat (id, tax_id, year, income_growth_tax_rate, investment_tax_rate, opr_cost_growth_tax_rate, maintenance_tax_rate, payment_period, create_ts, update_ts, end_ts) FROM stdin;
\.


--
-- Name: classification_to_classification_id_seq; Type: SEQUENCE SET; Schema: eim; Owner: postgres
--

SELECT pg_catalog.setval('eim.classification_to_classification_id_seq', 1, false);


--
-- Name: account_ooo account_ooo_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account_ooo
    ADD CONSTRAINT account_ooo_pkey PRIMARY KEY (id);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: account_role account_role_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account_role
    ADD CONSTRAINT account_role_pkey PRIMARY KEY (id);


--
-- Name: account_status account_status_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account_status
    ADD CONSTRAINT account_status_pkey PRIMARY KEY (id);


--
-- Name: admin_audit admin_audit_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.admin_audit
    ADD CONSTRAINT admin_audit_pkey PRIMARY KEY (id);


--
-- Name: classification classification_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.classification
    ADD CONSTRAINT classification_pkey PRIMARY KEY (id);


--
-- Name: classification_to_classification classification_to_classification_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.classification_to_classification
    ADD CONSTRAINT classification_to_classification_pkey PRIMARY KEY (id);


--
-- Name: dimension dimension_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.dimension
    ADD CONSTRAINT dimension_pkey PRIMARY KEY (id);


--
-- Name: edge_detail edge_detail_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.edge_detail
    ADD CONSTRAINT edge_detail_pkey PRIMARY KEY (id);


--
-- Name: edge edge_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.edge
    ADD CONSTRAINT edge_pkey PRIMARY KEY (id);


--
-- Name: idx_value idx_value_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.idx_value
    ADD CONSTRAINT idx_value_pkey PRIMARY KEY (id);


--
-- Name: income_tax income_tax_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.income_tax
    ADD CONSTRAINT income_tax_pkey PRIMARY KEY (id);


--
-- Name: integration_process integration_process_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.integration_process
    ADD CONSTRAINT integration_process_pkey PRIMARY KEY (id);


--
-- Name: investment_project_fund investment_project_fund_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project_fund
    ADD CONSTRAINT investment_project_fund_pkey PRIMARY KEY (id);


--
-- Name: investment_project investment_project_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project
    ADD CONSTRAINT investment_project_pkey PRIMARY KEY (id);


--
-- Name: land_tax land_tax_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.land_tax
    ADD CONSTRAINT land_tax_pkey PRIMARY KEY (id);


--
-- Name: macro_scenario macro_scenario_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.macro_scenario
    ADD CONSTRAINT macro_scenario_pkey PRIMARY KEY (id);


--
-- Name: migration_log migration_log_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.migration_log
    ADD CONSTRAINT migration_log_pkey PRIMARY KEY (id);


--
-- Name: migration_script migration_script_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.migration_script
    ADD CONSTRAINT migration_script_pkey PRIMARY KEY (id);


--
-- Name: property_tax property_tax_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.property_tax
    ADD CONSTRAINT property_tax_pkey PRIMARY KEY (id);


--
-- Name: scenario_acl scenario_acl_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_acl
    ADD CONSTRAINT scenario_acl_pkey PRIMARY KEY (id);


--
-- Name: scenario_aggr_road scenario_aggr_road_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_aggr_road
    ADD CONSTRAINT scenario_aggr_road_pkey PRIMARY KEY (id);


--
-- Name: scenario_aggr_road_span scenario_aggr_road_span_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_aggr_road_span
    ADD CONSTRAINT scenario_aggr_road_span_pkey PRIMARY KEY (id);


--
-- Name: scenario_arrangement_include scenario_arrangement_include_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_arrangement_include
    ADD CONSTRAINT scenario_arrangement_include_pkey PRIMARY KEY (id);


--
-- Name: scenario_bottleneck_correspondence scenario_bottleneck_correspondence_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_bottleneck_correspondence
    ADD CONSTRAINT scenario_bottleneck_correspondence_pkey PRIMARY KEY (id);


--
-- Name: scenario_bottleneck scenario_bottleneck_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_bottleneck
    ADD CONSTRAINT scenario_bottleneck_pkey PRIMARY KEY (id);


--
-- Name: scenario_calculation scenario_calculation_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_calculation
    ADD CONSTRAINT scenario_calculation_pkey PRIMARY KEY (id);


--
-- Name: scenario_eq_cost scenario_eq_cost_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_eq_cost
    ADD CONSTRAINT scenario_eq_cost_pkey PRIMARY KEY (id);


--
-- Name: scenario_eq_tariff scenario_eq_tariff_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_eq_tariff
    ADD CONSTRAINT scenario_eq_tariff_pkey PRIMARY KEY (id);


--
-- Name: scenario_event_info scenario_event_info_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_event_info
    ADD CONSTRAINT scenario_event_info_pkey PRIMARY KEY (id);


--
-- Name: scenario_event scenario_event_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_event
    ADD CONSTRAINT scenario_event_pkey PRIMARY KEY (id);


--
-- Name: scenario_event_schedule scenario_event_schedule_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_event_schedule
    ADD CONSTRAINT scenario_event_schedule_pkey PRIMARY KEY (id);


--
-- Name: scenario_opcost scenario_opcost_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_opcost
    ADD CONSTRAINT scenario_opcost_pkey PRIMARY KEY (id);


--
-- Name: scenario_opcost_schedule scenario_opcost_schedule_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_opcost_schedule
    ADD CONSTRAINT scenario_opcost_schedule_pkey PRIMARY KEY (id);


--
-- Name: scenario scenario_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario
    ADD CONSTRAINT scenario_pkey PRIMARY KEY (id);


--
-- Name: scenario_res_pivot_invest scenario_res_pivot_invest_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_res_pivot_invest
    ADD CONSTRAINT scenario_res_pivot_invest_pkey PRIMARY KEY (id);


--
-- Name: scenario_res_pivot scenario_res_pivot_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_res_pivot
    ADD CONSTRAINT scenario_res_pivot_pkey PRIMARY KEY (id);


--
-- Name: scenario_res scenario_res_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_res
    ADD CONSTRAINT scenario_res_pkey PRIMARY KEY (id);


--
-- Name: scenario_res_pnl scenario_res_pnl_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_res_pnl
    ADD CONSTRAINT scenario_res_pnl_pkey PRIMARY KEY (id);


--
-- Name: scenario_tariff scenario_tariff_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_tariff
    ADD CONSTRAINT scenario_tariff_pkey PRIMARY KEY (id);


--
-- Name: setting setting_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.setting
    ADD CONSTRAINT setting_pkey PRIMARY KEY (id);


--
-- Name: station station_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.station
    ADD CONSTRAINT station_pkey PRIMARY KEY (id);


--
-- Name: tax tax_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.tax
    ADD CONSTRAINT tax_pkey PRIMARY KEY (id);


--
-- Name: te_version te_version_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.te_version
    ADD CONSTRAINT te_version_pkey PRIMARY KEY (id);


--
-- Name: user_audit user_audit_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.user_audit
    ADD CONSTRAINT user_audit_pkey PRIMARY KEY (id);


--
-- Name: user_event user_event_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.user_event
    ADD CONSTRAINT user_event_pkey PRIMARY KEY (id);


--
-- Name: user_session user_session_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.user_session
    ADD CONSTRAINT user_session_pkey PRIMARY KEY (id);


--
-- Name: vat vat_pkey; Type: CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.vat
    ADD CONSTRAINT vat_pkey PRIMARY KEY (id);


--
-- Name: idx_value fk_15; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.idx_value
    ADD CONSTRAINT fk_15 FOREIGN KEY (macro_scenario_id) REFERENCES eim.macro_scenario(id);


--
-- Name: idx_value fk_16; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.idx_value
    ADD CONSTRAINT fk_16 FOREIGN KEY (idx_tp_id) REFERENCES eim.classification(id);


--
-- Name: vat fk_17; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.vat
    ADD CONSTRAINT fk_17 FOREIGN KEY (tax_id) REFERENCES eim.tax(id);


--
-- Name: property_tax fk_18; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.property_tax
    ADD CONSTRAINT fk_18 FOREIGN KEY (tax_id) REFERENCES eim.tax(id);


--
-- Name: land_tax fk_19; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.land_tax
    ADD CONSTRAINT fk_19 FOREIGN KEY (tax_id) REFERENCES eim.tax(id);


--
-- Name: scenario fk_2; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario
    ADD CONSTRAINT fk_2 FOREIGN KEY (create_user_id) REFERENCES eim.account(id);


--
-- Name: income_tax fk_20; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.income_tax
    ADD CONSTRAINT fk_20 FOREIGN KEY (tax_id) REFERENCES eim.tax(id);


--
-- Name: station fk_25; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.station
    ADD CONSTRAINT fk_25 FOREIGN KEY (railroad_id) REFERENCES eim.classification(id);


--
-- Name: scenario fk_28; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario
    ADD CONSTRAINT fk_28 FOREIGN KEY (macro_scenario_id) REFERENCES eim.macro_scenario(id);


--
-- Name: scenario fk_29; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario
    ADD CONSTRAINT fk_29 FOREIGN KEY (tax_id) REFERENCES eim.tax(id);


--
-- Name: scenario fk_3; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario
    ADD CONSTRAINT fk_3 FOREIGN KEY (update_user_id) REFERENCES eim.account(id);


--
-- Name: scenario_bottleneck fk_31; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_bottleneck
    ADD CONSTRAINT fk_31 FOREIGN KEY (slice_tp_id) REFERENCES eim.classification(id);


--
-- Name: scenario_res_pivot_invest fk_33; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_res_pivot_invest
    ADD CONSTRAINT fk_33 FOREIGN KEY (funding_tp_id) REFERENCES eim.classification(id);


--
-- Name: edge fk_39; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.edge
    ADD CONSTRAINT fk_39 FOREIGN KEY (region_from_id) REFERENCES eim.classification(id);


--
-- Name: integration_process fk_4; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.integration_process
    ADD CONSTRAINT fk_4 FOREIGN KEY (master_system_id) REFERENCES eim.classification(id);


--
-- Name: edge fk_40; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.edge
    ADD CONSTRAINT fk_40 FOREIGN KEY (region_to_id) REFERENCES eim.classification(id);


--
-- Name: station fk_41; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.station
    ADD CONSTRAINT fk_41 FOREIGN KEY (region_id) REFERENCES eim.classification(id);


--
-- Name: integration_process fk_5; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.integration_process
    ADD CONSTRAINT fk_5 FOREIGN KEY (slave_system_id) REFERENCES eim.classification(id);


--
-- Name: integration_process fk_6; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.integration_process
    ADD CONSTRAINT fk_6 FOREIGN KEY (process_id) REFERENCES eim.classification(id);


--
-- Name: integration_process fk_7; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.integration_process
    ADD CONSTRAINT fk_7 FOREIGN KEY (process_result_id) REFERENCES eim.classification(id);


--
-- Name: scenario_acl fk_8; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_acl
    ADD CONSTRAINT fk_8 FOREIGN KEY (script) REFERENCES eim.scenario(id);


--
-- Name: scenario_acl fk_access_level; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_acl
    ADD CONSTRAINT fk_access_level FOREIGN KEY (access_tp_id) REFERENCES eim.classification(id);


--
-- Name: account fk_account_ooo_status; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account
    ADD CONSTRAINT fk_account_ooo_status FOREIGN KEY (ooo_status_id) REFERENCES eim.classification(id);


--
-- Name: account_role fk_account_role; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account_role
    ADD CONSTRAINT fk_account_role FOREIGN KEY (role_id) REFERENCES eim.classification(id);


--
-- Name: account_role fk_account_role_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account_role
    ADD CONSTRAINT fk_account_role_user FOREIGN KEY (account_id) REFERENCES eim.account(id);


--
-- Name: account fk_account_status; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account
    ADD CONSTRAINT fk_account_status FOREIGN KEY (status_id) REFERENCES eim.classification(id);


--
-- Name: account_status fk_account_status2; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account_status
    ADD CONSTRAINT fk_account_status2 FOREIGN KEY (account_id) REFERENCES eim.account(id);


--
-- Name: account_status fk_account_status_cru; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account_status
    ADD CONSTRAINT fk_account_status_cru FOREIGN KEY (create_user_id) REFERENCES eim.account(id);


--
-- Name: account_status fk_account_status_hist; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account_status
    ADD CONSTRAINT fk_account_status_hist FOREIGN KEY (status_id) REFERENCES eim.classification(id);


--
-- Name: account_status fk_account_status_uu; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account_status
    ADD CONSTRAINT fk_account_status_uu FOREIGN KEY (update_user_id) REFERENCES eim.account(id);


--
-- Name: admin_audit fk_admin_audit_admin; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.admin_audit
    ADD CONSTRAINT fk_admin_audit_admin FOREIGN KEY (admin_id) REFERENCES eim.account(id);


--
-- Name: admin_audit fk_admin_audit_session; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.admin_audit
    ADD CONSTRAINT fk_admin_audit_session FOREIGN KEY (user_session_id) REFERENCES eim.user_session(id);


--
-- Name: admin_audit fk_admin_audit_subject; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.admin_audit
    ADD CONSTRAINT fk_admin_audit_subject FOREIGN KEY (user_id) REFERENCES eim.account(id);


--
-- Name: scenario_bottleneck_correspondence fk_bottleneck_corr; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_bottleneck_correspondence
    ADD CONSTRAINT fk_bottleneck_corr FOREIGN KEY (scenario_bottleneck_id) REFERENCES eim.scenario_bottleneck(id);


--
-- Name: scenario_calculation fk_cacl_phase; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_calculation
    ADD CONSTRAINT fk_cacl_phase FOREIGN KEY (calc_phase_current_id) REFERENCES eim.classification(id);


--
-- Name: scenario_res fk_calc_result_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_res
    ADD CONSTRAINT fk_calc_result_tp FOREIGN KEY (slice_tp_id) REFERENCES eim.classification(id);


--
-- Name: scenario_calculation fk_calculation_create_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_calculation
    ADD CONSTRAINT fk_calculation_create_user FOREIGN KEY (create_user_id) REFERENCES eim.account(id);


--
-- Name: scenario_calculation fk_calculation_scenario_eim; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_calculation
    ADD CONSTRAINT fk_calculation_scenario_eim FOREIGN KEY (scenario_id) REFERENCES eim.scenario(id);


--
-- Name: scenario_calculation fk_calculation_status_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_calculation
    ADD CONSTRAINT fk_calculation_status_tp FOREIGN KEY (calculation_status_id) REFERENCES eim.classification(id);


--
-- Name: scenario_calculation fk_calculation_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_calculation
    ADD CONSTRAINT fk_calculation_tp FOREIGN KEY (calculation_tp_id) REFERENCES eim.classification(id);


--
-- Name: scenario_calculation fk_calculation_update_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_calculation
    ADD CONSTRAINT fk_calculation_update_user FOREIGN KEY (update_user_id) REFERENCES eim.account(id);


--
-- Name: classification fk_cl_create_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.classification
    ADD CONSTRAINT fk_cl_create_user FOREIGN KEY (create_user_id) REFERENCES eim.account(id);


--
-- Name: classification fk_cl_update_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.classification
    ADD CONSTRAINT fk_cl_update_user FOREIGN KEY (update_user_id) REFERENCES eim.account(id);


--
-- Name: classification_to_classification fk_clxcl_object; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.classification_to_classification
    ADD CONSTRAINT fk_clxcl_object FOREIGN KEY (object_id) REFERENCES eim.classification(id);


--
-- Name: classification_to_classification fk_clxcl_subject; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.classification_to_classification
    ADD CONSTRAINT fk_clxcl_subject FOREIGN KEY (subject_id) REFERENCES eim.classification(id);


--
-- Name: classification_to_classification fk_clxcl_type; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.classification_to_classification
    ADD CONSTRAINT fk_clxcl_type FOREIGN KEY (relation_tp_id) REFERENCES eim.classification(id);


--
-- Name: user_session fk_connection_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.user_session
    ADD CONSTRAINT fk_connection_tp FOREIGN KEY (connection_tp_id) REFERENCES eim.classification(id);


--
-- Name: edge_detail fk_detail_edge_scenario; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.edge_detail
    ADD CONSTRAINT fk_detail_edge_scenario FOREIGN KEY (scenario_id) REFERENCES eim.scenario(id);


--
-- Name: classification fk_dim; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.classification
    ADD CONSTRAINT fk_dim FOREIGN KEY (dimension_id) REFERENCES eim.dimension(id);


--
-- Name: dimension fk_dim_create_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.dimension
    ADD CONSTRAINT fk_dim_create_user FOREIGN KEY (create_user_id) REFERENCES eim.account(id);


--
-- Name: dimension fk_dim_update_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.dimension
    ADD CONSTRAINT fk_dim_update_user FOREIGN KEY (update_user_id) REFERENCES eim.account(id);


--
-- Name: edge fk_edge_polygon; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.edge
    ADD CONSTRAINT fk_edge_polygon FOREIGN KEY (polygon_id) REFERENCES eim.classification(id);


--
-- Name: edge fk_edge_stfrom; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.edge
    ADD CONSTRAINT fk_edge_stfrom FOREIGN KEY (station_from_id) REFERENCES eim.station(id);


--
-- Name: edge fk_edge_stto; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.edge
    ADD CONSTRAINT fk_edge_stto FOREIGN KEY (station_to_id) REFERENCES eim.station(id);


--
-- Name: scenario_event_info fk_ev_info; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_event_info
    ADD CONSTRAINT fk_ev_info FOREIGN KEY (scenario_event_id) REFERENCES eim.scenario_event(id);


--
-- Name: scenario_event_schedule fk_ev_info_schdl; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_event_schedule
    ADD CONSTRAINT fk_ev_info_schdl FOREIGN KEY (scenario_event_info_id) REFERENCES eim.scenario_event_info(id);


--
-- Name: account fk_expert_position; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account
    ADD CONSTRAINT fk_expert_position FOREIGN KEY (position_id) REFERENCES eim.classification(id);


--
-- Name: integration_process fk_integration_cru; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.integration_process
    ADD CONSTRAINT fk_integration_cru FOREIGN KEY (create_user_id) REFERENCES eim.account(id);


--
-- Name: integration_process fk_integration_uu; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.integration_process
    ADD CONSTRAINT fk_integration_uu FOREIGN KEY (update_user_id) REFERENCES eim.account(id);


--
-- Name: scenario_res_pivot_invest fk_investment_detial; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_res_pivot_invest
    ADD CONSTRAINT fk_investment_detial FOREIGN KEY (scenario_res_pivot_id) REFERENCES eim.scenario_res_pivot(id);


--
-- Name: investment_project fk_iprj_asset_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project
    ADD CONSTRAINT fk_iprj_asset_tp FOREIGN KEY (asset_tp_id) REFERENCES eim.classification(id);


--
-- Name: investment_project fk_iprj_create_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project
    ADD CONSTRAINT fk_iprj_create_user FOREIGN KEY (create_user_id) REFERENCES eim.account(id);


--
-- Name: investment_project fk_iprj_cst; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project
    ADD CONSTRAINT fk_iprj_cst FOREIGN KEY (func_cst_id) REFERENCES eim.classification(id);


--
-- Name: investment_project fk_iprj_func_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project
    ADD CONSTRAINT fk_iprj_func_tp FOREIGN KEY (prj_func_tp_id) REFERENCES eim.classification(id);


--
-- Name: investment_project_fund fk_iprj_funding_body_repayment_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project_fund
    ADD CONSTRAINT fk_iprj_funding_body_repayment_tp FOREIGN KEY (repayment_tp_id) REFERENCES eim.classification(id);


--
-- Name: investment_project_fund fk_iprj_funding_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project_fund
    ADD CONSTRAINT fk_iprj_funding_tp FOREIGN KEY (funding_tp_id) REFERENCES eim.classification(id);


--
-- Name: investment_project fk_iprj_goal_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project
    ADD CONSTRAINT fk_iprj_goal_tp FOREIGN KEY (goal_tp_id) REFERENCES eim.classification(id);


--
-- Name: investment_project fk_iprj_inclusion_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project
    ADD CONSTRAINT fk_iprj_inclusion_tp FOREIGN KEY (ip_inclusion_tp_id) REFERENCES eim.classification(id);


--
-- Name: investment_project fk_iprj_polygon; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project
    ADD CONSTRAINT fk_iprj_polygon FOREIGN KEY (polygon_id) REFERENCES eim.classification(id);


--
-- Name: investment_project fk_iprj_purpose_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project
    ADD CONSTRAINT fk_iprj_purpose_tp FOREIGN KEY (purpose_tp_id) REFERENCES eim.classification(id);


--
-- Name: investment_project fk_iprj_stage_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project
    ADD CONSTRAINT fk_iprj_stage_tp FOREIGN KEY (phase_tp_id) REFERENCES eim.classification(id);


--
-- Name: investment_project fk_iprj_update_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project
    ADD CONSTRAINT fk_iprj_update_user FOREIGN KEY (update_user_id) REFERENCES eim.account(id);


--
-- Name: investment_project_fund fk_iprjfund; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project_fund
    ADD CONSTRAINT fk_iprjfund FOREIGN KEY (investment_project_id) REFERENCES eim.investment_project(id);


--
-- Name: macro_scenario fk_macro_create_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.macro_scenario
    ADD CONSTRAINT fk_macro_create_user FOREIGN KEY (create_user_id) REFERENCES eim.account(id);


--
-- Name: macro_scenario fk_macro_update_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.macro_scenario
    ADD CONSTRAINT fk_macro_update_user FOREIGN KEY (update_user_id) REFERENCES eim.account(id);


--
-- Name: migration_log fk_migration_script_to_log; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.migration_log
    ADD CONSTRAINT fk_migration_script_to_log FOREIGN KEY (migration_script_id) REFERENCES eim.migration_script(id);


--
-- Name: account_ooo fk_ooo_account; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account_ooo
    ADD CONSTRAINT fk_ooo_account FOREIGN KEY (account_id) REFERENCES eim.account(id);


--
-- Name: account_ooo fk_ooo_deputy; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account_ooo
    ADD CONSTRAINT fk_ooo_deputy FOREIGN KEY (deputy_id) REFERENCES eim.account(id);


--
-- Name: classification fk_parent_cl; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.classification
    ADD CONSTRAINT fk_parent_cl FOREIGN KEY (parent_id) REFERENCES eim.classification(id);


--
-- Name: edge fk_parent_edge; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.edge
    ADD CONSTRAINT fk_parent_edge FOREIGN KEY (parent_edge_id) REFERENCES eim.edge(id);


--
-- Name: investment_project fk_parent_iprj; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.investment_project
    ADD CONSTRAINT fk_parent_iprj FOREIGN KEY (parent_investment_project_id) REFERENCES eim.investment_project(id);


--
-- Name: account fk_pwd_hash_algorythm; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account
    ADD CONSTRAINT fk_pwd_hash_algorythm FOREIGN KEY (pwd_hash_alg_id) REFERENCES eim.classification(id);


--
-- Name: scenario_res_pivot fk_res_to_fin; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_res_pivot
    ADD CONSTRAINT fk_res_to_fin FOREIGN KEY (scenario_res_id) REFERENCES eim.scenario_res(id);


--
-- Name: scenario_res_pnl fk_res_to_pnl; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_res_pnl
    ADD CONSTRAINT fk_res_to_pnl FOREIGN KEY (scenario_res_id) REFERENCES eim.scenario_res(id);


--
-- Name: account_role fk_role_cru; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account_role
    ADD CONSTRAINT fk_role_cru FOREIGN KEY (create_user_id) REFERENCES eim.account(id);


--
-- Name: account_role fk_role_uu; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account_role
    ADD CONSTRAINT fk_role_uu FOREIGN KEY (update_user_id) REFERENCES eim.account(id);


--
-- Name: scenario_acl fk_scenario_access_created_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_acl
    ADD CONSTRAINT fk_scenario_access_created_user FOREIGN KEY (create_user_id) REFERENCES eim.account(id);


--
-- Name: scenario_acl fk_scenario_access_updated_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_acl
    ADD CONSTRAINT fk_scenario_access_updated_user FOREIGN KEY (update_user_id) REFERENCES eim.account(id);


--
-- Name: scenario_acl fk_scenario_access_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_acl
    ADD CONSTRAINT fk_scenario_access_user FOREIGN KEY (account_id) REFERENCES eim.account(id);


--
-- Name: scenario fk_scenario_calculation_status_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario
    ADD CONSTRAINT fk_scenario_calculation_status_tp FOREIGN KEY (calculation_status_id) REFERENCES eim.classification(id);


--
-- Name: scenario fk_scenario_calculation_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario
    ADD CONSTRAINT fk_scenario_calculation_tp FOREIGN KEY (calculation_tp_id) REFERENCES eim.classification(id);


--
-- Name: scenario_aggr_road fk_scenario_consolicated_road; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_aggr_road
    ADD CONSTRAINT fk_scenario_consolicated_road FOREIGN KEY (railroad_id) REFERENCES eim.classification(id);


--
-- Name: scenario_aggr_road_span fk_scenario_consolicated_road_frag; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_aggr_road_span
    ADD CONSTRAINT fk_scenario_consolicated_road_frag FOREIGN KEY (scenario_aggr_road_id) REFERENCES eim.scenario_aggr_road(id);


--
-- Name: scenario_eq_cost fk_scenario_eq_cost; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_eq_cost
    ADD CONSTRAINT fk_scenario_eq_cost FOREIGN KEY (scenario_id) REFERENCES eim.scenario(id);


--
-- Name: scenario_eq_cost fk_scenario_eq_cost_road_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_eq_cost
    ADD CONSTRAINT fk_scenario_eq_cost_road_tp FOREIGN KEY (railroad_id) REFERENCES eim.classification(id);


--
-- Name: scenario_eq_tariff fk_scenario_eq_tariff; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_eq_tariff
    ADD CONSTRAINT fk_scenario_eq_tariff FOREIGN KEY (scenario_id) REFERENCES eim.scenario(id);


--
-- Name: scenario_eq_tariff fk_scenario_eq_tariff_cargo_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_eq_tariff
    ADD CONSTRAINT fk_scenario_eq_tariff_cargo_tp FOREIGN KEY (cargo_hl_tp_id) REFERENCES eim.classification(id);


--
-- Name: scenario_arrangement_include fk_scenario_events_inclusion; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_arrangement_include
    ADD CONSTRAINT fk_scenario_events_inclusion FOREIGN KEY (scenario_event_id) REFERENCES eim.scenario_event(id);


--
-- Name: scenario_arrangement_include fk_scenario_inclusion_scenario; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_arrangement_include
    ADD CONSTRAINT fk_scenario_inclusion_scenario FOREIGN KEY (scenario_id) REFERENCES eim.scenario(id);


--
-- Name: scenario fk_scenario_ip; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario
    ADD CONSTRAINT fk_scenario_ip FOREIGN KEY (investment_project_id) REFERENCES eim.investment_project(id);


--
-- Name: scenario_opcost fk_scenario_opcost; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_opcost
    ADD CONSTRAINT fk_scenario_opcost FOREIGN KEY (scenario_id) REFERENCES eim.scenario(id);


--
-- Name: scenario_opcost_schedule fk_scenario_opcost_schedule; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_opcost_schedule
    ADD CONSTRAINT fk_scenario_opcost_schedule FOREIGN KEY (scenario_opcost_id) REFERENCES eim.scenario_opcost(id);


--
-- Name: scenario_res_pnl fk_scenario_pnl_cargo_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_res_pnl
    ADD CONSTRAINT fk_scenario_pnl_cargo_tp FOREIGN KEY (cargo_hl_tp_id) REFERENCES eim.classification(id);


--
-- Name: scenario_aggr_road fk_scenario_road; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_aggr_road
    ADD CONSTRAINT fk_scenario_road FOREIGN KEY (scenario_id) REFERENCES eim.scenario(id);


--
-- Name: scenario_tariff fk_scenario_tarif; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_tariff
    ADD CONSTRAINT fk_scenario_tarif FOREIGN KEY (scenario_id) REFERENCES eim.scenario(id);


--
-- Name: scenario_bottleneck fk_scenario_to_bottleneck; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_bottleneck
    ADD CONSTRAINT fk_scenario_to_bottleneck FOREIGN KEY (scenario_id) REFERENCES eim.scenario(id);


--
-- Name: scenario_event fk_scenario_to_events; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_event
    ADD CONSTRAINT fk_scenario_to_events FOREIGN KEY (scenario_id) REFERENCES eim.scenario(id);


--
-- Name: scenario_res fk_scenario_to_results; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario_res
    ADD CONSTRAINT fk_scenario_to_results FOREIGN KEY (scenario_id) REFERENCES eim.scenario(id);


--
-- Name: scenario fk_scenarion_child_to_parent; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.scenario
    ADD CONSTRAINT fk_scenarion_child_to_parent FOREIGN KEY (parent_id) REFERENCES eim.scenario(id);


--
-- Name: user_session fk_session_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.user_session
    ADD CONSTRAINT fk_session_user FOREIGN KEY (account_id) REFERENCES eim.account(id);


--
-- Name: setting fk_setting_parameter; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.setting
    ADD CONSTRAINT fk_setting_parameter FOREIGN KEY (parameter_id) REFERENCES eim.classification(id);


--
-- Name: setting fk_settings_cru; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.setting
    ADD CONSTRAINT fk_settings_cru FOREIGN KEY (create_user_id) REFERENCES eim.account(id);


--
-- Name: setting fk_settings_uu; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.setting
    ADD CONSTRAINT fk_settings_uu FOREIGN KEY (update_user_id) REFERENCES eim.account(id);


--
-- Name: tax fk_tax_mode_create_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.tax
    ADD CONSTRAINT fk_tax_mode_create_user FOREIGN KEY (create_user_id) REFERENCES eim.account(id);


--
-- Name: tax fk_tax_mode_update_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.tax
    ADD CONSTRAINT fk_tax_mode_update_user FOREIGN KEY (update_user_id) REFERENCES eim.account(id);


--
-- Name: te_version fk_te_version_create_user_id; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.te_version
    ADD CONSTRAINT fk_te_version_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account(id);


--
-- Name: te_version fk_te_version_form_id; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.te_version
    ADD CONSTRAINT fk_te_version_form_id FOREIGN KEY (form_id) REFERENCES eim.classification(id);


--
-- Name: te_version fk_te_version_update_user_id; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.te_version
    ADD CONSTRAINT fk_te_version_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account(id);


--
-- Name: user_audit fk_user_audit_account; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.user_audit
    ADD CONSTRAINT fk_user_audit_account FOREIGN KEY (account_id) REFERENCES eim.account(id);


--
-- Name: user_audit fk_user_audit_session; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.user_audit
    ADD CONSTRAINT fk_user_audit_session FOREIGN KEY (user_session_id) REFERENCES eim.user_session(id);


--
-- Name: account fk_user_create_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account
    ADD CONSTRAINT fk_user_create_user FOREIGN KEY (create_user_id) REFERENCES eim.account(id);


--
-- Name: account fk_user_department; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account
    ADD CONSTRAINT fk_user_department FOREIGN KEY (department_id) REFERENCES eim.classification(id);


--
-- Name: user_event fk_user_event_account; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.user_event
    ADD CONSTRAINT fk_user_event_account FOREIGN KEY (account_id) REFERENCES eim.account(id);


--
-- Name: user_event fk_user_event_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.user_event
    ADD CONSTRAINT fk_user_event_tp FOREIGN KEY (user_event_tp_id) REFERENCES eim.classification(id);


--
-- Name: account fk_user_update_user; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.account
    ADD CONSTRAINT fk_user_update_user FOREIGN KEY (update_user_id) REFERENCES eim.account(id);


--
-- Name: classification fl_cl_tp; Type: FK CONSTRAINT; Schema: eim; Owner: postgres
--

ALTER TABLE ONLY eim.classification
    ADD CONSTRAINT fl_cl_tp FOREIGN KEY (object_tp_id) REFERENCES eim.classification(id);


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg120+1)
-- Dumped by pg_dump version 15.3 (Debian 15.3-1.pgdg120+1)

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

