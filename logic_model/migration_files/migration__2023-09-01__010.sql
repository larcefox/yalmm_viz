CREATE SCHEMA eim;

REVOKE ALL ON SCHEMA public FROM pg_database_owner;

REVOKE USAGE ON SCHEMA public FROM PUBLIC;

COMMENT ON SCHEMA public IS NULL;

CREATE TABLE eim.account (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    email character varying(40),
    birth_dt date,
    first_nm character varying(40),
    account_lock_ts timestamp with time zone,
    name character varying(40),
    access_memorandum_no character varying(40),
    middle_nm character varying(40),
    expire_plan_dt date NOT NULL,
    phone character varying(4000),
    last_nm character varying(40),
    pwd_hash character varying(4000),
    failed_login_cnt integer NOT NULL,
    pwd_hash_alg_id bigint NOT NULL,
    position_id bigint NOT NULL,
    ooo_status_id bigint NOT NULL,
    status_id bigint NOT NULL,
    department_id bigint NOT NULL DEFAULT 737);

CREATE TABLE eim.account_ooo (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    ooo_begin_dt date NOT NULL,
    ooo_end_dt date NOT NULL,
    deputy_id bigint NOT NULL,
    account_id bigint NOT NULL);

CREATE TABLE eim.account_role (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    expire_role_dt date,
    role_id bigint NOT NULL,
    account_id bigint NOT NULL);

CREATE TABLE eim.account_status (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    status_id bigint NOT NULL,
    account_id bigint NOT NULL);

CREATE TABLE eim.admin_audit (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    ip_address character varying(40),
    admin_login character varying(40),
    user_login character varying(40) NOT NULL,
    opr_dsc character varying(40),
    admin_dept_nm character varying(40),
    user_dept_nm character varying(40),
    admin_nm character varying(40),
    user_nm character varying(40),
    admin_id bigint NOT NULL,
    user_id bigint NOT NULL,
    user_session_id bigint NOT NULL);

CREATE TABLE eim.classification (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    code character varying(40),
    name character varying(40),
    description character varying(4000),
    rank integer NOT NULL DEFAULT 2,
    parent_id bigint NOT NULL,
    dimension_id bigint NOT NULL,
    object_tp_id bigint NOT NULL);

CREATE TABLE eim.dimension (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    code character varying(40),
    name character varying(40),
    description character varying(4000));

CREATE TABLE eim.edge (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    reg_konca_per character varying(4000),
    code character varying(4000),
    name character varying(4000),
    hl_net_ind boolean NOT NULL DEFAULT false,
    polygon_id bigint NOT NULL,
    region_from_id bigint NOT NULL,
    region_to_id bigint NOT NULL,
    parent_edge_id bigint,
    station_from_id bigint NOT NULL,
    station_to_id bigint NOT NULL);

CREATE TABLE eim.edge_detail (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    capacity double precision,
    delta double precision,
    delta_delta double precision,
    dor_kod integer NOT NULL,
    dor_name character varying(40),
    empty double precision,
    end_esr integer NOT NULL,
    end_id integer NOT NULL,
    end_name character varying(40),
    hl_end_id integer NOT NULL,
    hl_start_id integer NOT NULL,
    n_empty double precision,
    n_train double precision,
    passport_end integer NOT NULL,
    passport_start integer NOT NULL,
    span_number integer NOT NULL,
    start_ers integer NOT NULL,
    start_id integer NOT NULL,
    start_name character varying(40),
    train double precision,
    year integer NOT NULL,
    scenario_id bigint NOT NULL);

CREATE TABLE eim.idx_value (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    year integer NOT NULL,
    val double precision,
    macro_scenario_id bigint NOT NULL,
    idx_tp_id bigint NOT NULL);

CREATE TABLE eim.income_tax (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    year integer NOT NULL,
    fed_share double precision,
    payment_period integer NOT NULL,
    tax_rate double precision,
    tax_id bigint NOT NULL);

CREATE TABLE eim.integration_process (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    process_start_ts timestamp with time zone NOT NULL,
    process_end_ts timestamp with time zone,
    transaction_id uuid NOT NULL,
    process_msg character varying(4000),
    slave_system_id bigint NOT NULL,
    process_id bigint NOT NULL,
    process_result_id bigint NOT NULL,
    master_system_id bigint NOT NULL);

CREATE TABLE eim.investment_project (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    version_letter character varying(40),
    version_num integer NOT NULL,
    name character varying(40),
    description character varying(40),
    purpose_tp_id bigint NOT NULL,
    polygon_id bigint NOT NULL,
    parent_investment_project_id bigint NOT NULL,
    phase_tp_id bigint NOT NULL,
    asset_tp_id bigint NOT NULL,
    ip_inclusion_tp_id bigint NOT NULL,
    prj_func_tp_id bigint NOT NULL,
    func_cst_id bigint NOT NULL,
    goal_tp_id bigint NOT NULL);

CREATE TABLE eim.investment_project_fund (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    year integer NOT NULL,
    priviledge_loan_rate double precision,
    priviledge_duration integer,
    name character varying(40),
    loan_rate double precision,
    loan_period integer,
    investment_amt double precision,
    funding_tp_id bigint NOT NULL,
    investment_project_id bigint NOT NULL,
    repayment_tp_id bigint NOT NULL);

CREATE TABLE eim.land_tax (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    year integer NOT NULL,
    payment_period integer NOT NULL,
    tax_rate double precision,
    tax_id bigint NOT NULL);

CREATE TABLE eim.macro_scenario (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    name character varying(40));

CREATE TABLE eim.migration_script (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    dbver_before integer NOT NULL DEFAULT 2,
    dbver_after integer NOT NULL DEFAULT 2,
    script_name character varying(400) NOT NULL DEFAULT ''::character varying);

CREATE TABLE eim.modules_scenario (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    scenario_id bigint NOT NULL,
    te_version bigint NOT NULL,
    trs_version_id bigint NOT NULL);

CREATE TABLE eim.property_tax (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    year integer NOT NULL,
    accounting_rate double precision,
    payment_period integer NOT NULL,
    renov_growth_rate double precision,
    evol_reduction_rate double precision,
    evol_investment_tax_rate double precision,
    renov_investment_tax_rate double precision,
    tax_id bigint NOT NULL);

CREATE TABLE eim.scenario (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    year_from integer,
    year_to integer,
    cargo_scenario_id bigint NOT NULL,
    name character varying(40),
    description character varying(4000),
    indicators_nat_lst bigint NOT NULL,
    indicators_fin_lst bigint NOT NULL,
    inflation_user_ind boolean NOT NULL DEFAULT false,
    bottleneck_liquidation_ind boolean NOT NULL DEFAULT false,
    investment_project_id bigint NOT NULL,
    macro_scenario_id bigint NOT NULL,
    tax_id bigint,
    parent_id bigint NOT NULL,
    calculation_status_id bigint NOT NULL,
    calculation_tp_id bigint NOT NULL);

CREATE TABLE eim.scenario_acl (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    account_id bigint NOT NULL,
    script bigint NOT NULL,
    access_tp_id bigint NOT NULL);

CREATE TABLE eim.scenario_aggr_road (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    railroad_id bigint NOT NULL,
    scenario_id bigint NOT NULL);

CREATE TABLE eim.scenario_aggr_road_span (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    actions character varying(4000),
    beginstation integer,
    beginstationname character varying(40),
    capacitynoparallelcargobwd integer,
    capacitynoparallelcargofwd integer,
    capacitynoparallelpassbwd integer,
    capacitynoparallelpassfwd integer,
    cargoloadbwd integer,
    cargoloadfwd integer,
    controltype character varying(40),
    detours character varying(4000),
    endstation integer,
    endstationname character varying(40),
    fragid integer,
    fragnum integer,
    glp integer,
    length integer,
    massloadbwd integer,
    massloadfwd integer,
    passengerbwd integer,
    passengerfwd integer,
    passengerspeedbwd integer,
    passengerspeedfwd integer,
    passportnum character varying(40),
    requiredcapacitybwd integer,
    requiredcapacityfwd integer,
    reservebwd integer,
    reservefwd integer,
    roadid integer,
    spanid integer,
    spannum integer,
    suburbanbwd integer,
    suburbanfwd integer,
    suburbanspeedbwd integer,
    suburbanspeedfwd integer,
    tractiontype character varying(40),
    trainsbwd integer,
    trainsfwd integer,
    varid integer,
    year integer NOT NULL,
    scenario_aggr_road_id bigint NOT NULL);

CREATE TABLE eim.scenario_arrangement_include (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    arrangement_id bigint NOT NULL,
    include_ind boolean NOT NULL DEFAULT false,
    scenario_event_id bigint NOT NULL,
    scenario_id bigint NOT NULL);

CREATE TABLE eim.scenario_bottleneck (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    begin_stan bigint NOT NULL,
    end_stan bigint NOT NULL,
    road bigint NOT NULL,
    year integer NOT NULL,
    scenario_id bigint NOT NULL,
    slice_tp_id bigint NOT NULL);

CREATE TABLE eim.scenario_bottleneck_correspondence (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    cargo_type bigint NOT NULL,
    container character varying(40),
    corr_id bigint NOT NULL,
    end_stan bigint NOT NULL,
    start_stan bigint NOT NULL,
    summ double precision,
    transit_type character varying(40),
    scenario_bottleneck_id bigint NOT NULL);

CREATE TABLE eim.scenario_calculation (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    calc_phase_done_lst bigint NOT NULL,
    rank integer NOT NULL,
    calculation_status_id bigint NOT NULL,
    scenario_id bigint NOT NULL,
    calc_phase_current_id bigint NOT NULL,
    calculation_tp_id bigint NOT NULL);

CREATE TABLE eim.scenario_eq_cost (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    year integer NOT NULL,
    factor double precision,
    railroad_id bigint NOT NULL,
    scenario_id bigint NOT NULL);

CREATE TABLE eim.scenario_eq_tariff (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    factor double precision,
    scenario_id bigint NOT NULL,
    cargo_hl_tp_id bigint NOT NULL);

CREATE TABLE eim.scenario_event (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    effective_dt date NOT NULL,
    event_start date NOT NULL,
    evolution_tp_nm character varying(40),
    invest_sum double precision,
    load_dt date NOT NULL,
    spiui_id character varying(40),
    var_id bigint NOT NULL,
    scenario_id bigint NOT NULL);

CREATE TABLE eim.scenario_event_info (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    code_from bigint NOT NULL,
    code_to bigint NOT NULL,
    communication_tool_after character varying(4000),
    communication_tool_before character varying(4000),
    len double precision,
    locomotive_tp_after character varying(4000),
    locomotive_tp_before character varying(4000),
    patch_count_after bigint NOT NULL,
    patch_count_before bigint NOT NULL,
    scenario_event_id bigint NOT NULL);

CREATE TABLE eim.scenario_event_schedule (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    load double precision,
    year integer NOT NULL,
    scenario_event_info_id bigint NOT NULL);

CREATE TABLE eim.scenario_opcost (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    cargo_tp_cd bigint NOT NULL,
    corr_id bigint NOT NULL,
    cost_empty_amt double precision,
    cost_loaded_amt double precision,
    delivery_tp character varying(40),
    gr_code_usl bigint NOT NULL,
    rod_gr_name character varying(40),
    station_from_cd bigint NOT NULL,
    station_to_cd bigint NOT NULL,
    var_id bigint NOT NULL,
    ves double precision,
    scenario_id bigint NOT NULL);

CREATE TABLE eim.scenario_opcost_schedule (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    car_count double precision,
    year integer NOT NULL,
    scenario_opcost_id bigint NOT NULL);

CREATE TABLE eim.scenario_res (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    evol_capex_amt double precision,
    renov_capex_amt double precision,
    dpp integer NOT NULL,
    irr double precision,
    npv_own_amt double precision,
    npv_region_amt double precision NOT NULL,
    npv_fed_amt double precision,
    spp integer NOT NULL,
    income_amt double precision,
    cost_amt double precision,
    delivery_gap_amt double precision NOT NULL,
    delivery_gap double precision NOT NULL,
    bottleneck_cnt integer NOT NULL,
    scenario_id bigint NOT NULL,
    slice_tp_id bigint NOT NULL);

CREATE TABLE eim.scenario_res_pivot (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    year integer NOT NULL,
    fcff_amt double precision,
    fcfe_amt double precision,
    evol_capex_amt double precision,
    renov_capex_amt double precision,
    tax_amt double precision,
    tax_vat_amt double precision,
    tax_land_amt double precision,
    tax_property_amt double precision,
    tax_income_amt double precision NOT NULL,
    ebit_amt double precision,
    ebitda_amt double precision,
    operational_cost_amt double precision,
    pure_income_amt double precision,
    fcf_amt double precision,
    fcf_own_amt double precision NOT NULL,
    scenario_res_id bigint NOT NULL);

CREATE TABLE eim.scenario_res_pivot_invest (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    investment_amt double precision,
    funding_tp_id bigint NOT NULL,
    scenario_res_pivot_id bigint NOT NULL);

CREATE TABLE eim.scenario_res_pnl (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    income_amt double precision NOT NULL,
    cost_amt double precision NOT NULL,
    year integer NOT NULL,
    delivery_gap double precision NOT NULL,
    delivery_gap_rub double precision,
    delivery double precision,
    income_growth_amt double precision,
    cost_growth_amt double precision,
    delivery_rate double precision,
    scenario_res_id bigint NOT NULL,
    cargo_hl_tp_id bigint NOT NULL);

CREATE TABLE eim.scenario_tariff (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    add_pay_empty double precision,
    add_pay_loaded double precision,
    calculation_dt date NOT NULL,
    car_cnt_per_goup bigint NOT NULL,
    car_num_per_day double precision,
    car_tp bigint NOT NULL,
    cargo_tp bigint NOT NULL,
    cargo_tp1_cd bigint NOT NULL,
    commute_tp character varying(40),
    container character varying(40),
    corr_id bigint NOT NULL,
    main_pay_empty double precision,
    main_pay_loaded double precision,
    min_way double precision,
    route_tp character varying(40),
    shipment_tp character varying(40),
    st_nz_id bigint NOT NULL,
    st_nz_nx character varying(40),
    st_ot_id bigint NOT NULL,
    st_ot_nx character varying(40),
    station_from bigint NOT NULL,
    station_to bigint NOT NULL,
    statng double precision,
    var_id bigint NOT NULL,
    volume_corr double precision,
    year integer NOT NULL,
    scenario_id bigint NOT NULL);

CREATE TABLE eim.setting (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    float_val double precision,
    str_val character varying(40),
    int_val integer,
    parameter_id bigint NOT NULL);

CREATE TABLE eim.station (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    lon double precision DEFAULT 0,
    code integer NOT NULL,
    code_cnsi integer NOT NULL,
    x double precision,
    y double precision,
    name character varying(40),
    hl_net_ind boolean NOT NULL DEFAULT false,
    lat double precision,
    railroad_id bigint,
    region_id bigint);

CREATE TABLE eim.tax (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    name character varying(40));

CREATE TABLE eim.te_version (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint,
    form_id bigint NOT NULL);

CREATE TABLE eim.trs_values_by_road_id (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    passenger_service_type_id bigint,
    customer_id bigint,
    activity_type_id bigint,
    rolling_stock_type_id bigint,
    traction_type_id bigint,
    traffic_tp_id bigint NOT NULL,
    trs_param_id bigint NOT NULL,
    railroad_id bigint NOT NULL,
    trs_version_id bigint NOT NULL);

CREATE TABLE eim.trs_values_by_rolling_stock_type (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    train_tp_id bigint,
    repair_type_id bigint,
    rolling_stock_type_id bigint NOT NULL,
    trs_version_id bigint NOT NULL);

CREATE TABLE eim.trs_values_schedule (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    year integer NOT NULL,
    val double precision,
    measure_tp_id bigint NOT NULL,
    trs_param_id bigint NOT NULL,
    trs_values_by_road_id bigint);

CREATE TABLE eim.trs_version (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    create_user_id bigint,
    update_user_id bigint);

CREATE TABLE eim.user_audit (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    ip_address character varying(40),
    file_nm character varying(40),
    user_login character varying(40),
    user_dept_nm character varying(40),
    file_sz double precision,
    data_dsc character varying(40),
    user_nm character varying(40),
    account_id bigint NOT NULL,
    user_session_id bigint NOT NULL);

CREATE TABLE eim.user_event (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    read_ind boolean NOT NULL DEFAULT false,
    url character varying(4000),
    description character varying(40),
    account_id bigint NOT NULL,
    user_event_tp_id bigint NOT NULL);

CREATE TABLE eim.user_session (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    user_agent character varying(4000),
    ip_address character varying(40),
    supplied_user_name character varying(40),
    duration double precision,
    login_ts timestamp with time zone,
    session_end_ts date,
    login_success_ind boolean NOT NULL DEFAULT false,
    jwt_token character varying(4000),
    account_id bigint NOT NULL,
    connection_tp_id bigint NOT NULL);

CREATE TABLE eim.vat (
    id bigint NOT NULL,
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    year integer NOT NULL,
    payment_period integer NOT NULL,
    income_growth_tax_rate double precision,
    opr_cost_growth_tax_rate double precision,
    investment_tax_rate double precision,
    maintenance_tax_rate double precision,
    tax_id bigint NOT NULL);

CREATE SEQUENCE public.main_seq    START WITH 1000000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE eim.account ADD CONSTRAINT account_pkey PRIMARY KEY (id);

ALTER TABLE eim.account_ooo ADD CONSTRAINT account_ooo_pkey PRIMARY KEY (id);

ALTER TABLE eim.account_role ADD CONSTRAINT account_role_pkey PRIMARY KEY (id);

ALTER TABLE eim.account_status ADD CONSTRAINT account_status_pkey PRIMARY KEY (id);

ALTER TABLE eim.admin_audit ADD CONSTRAINT admin_audit_pkey PRIMARY KEY (id);

ALTER TABLE eim.classification ADD CONSTRAINT classification_pkey PRIMARY KEY (id);

ALTER TABLE eim.dimension ADD CONSTRAINT dimension_pkey PRIMARY KEY (id);

ALTER TABLE eim.edge ADD CONSTRAINT edge_pkey PRIMARY KEY (id);

ALTER TABLE eim.edge_detail ADD CONSTRAINT edge_detail_pkey PRIMARY KEY (id);

ALTER TABLE eim.idx_value ADD CONSTRAINT idx_value_pkey PRIMARY KEY (id);

ALTER TABLE eim.idx_value ADD CONSTRAINT idx_value_year_check CHECK (year > 1900);

ALTER TABLE eim.income_tax ADD CONSTRAINT income_tax_pkey PRIMARY KEY (id);

ALTER TABLE eim.income_tax ADD CONSTRAINT income_tax_year_check CHECK (year > 1900);

ALTER TABLE eim.integration_process ADD CONSTRAINT integration_process_pkey PRIMARY KEY (id);

ALTER TABLE eim.investment_project ADD CONSTRAINT investment_project_pkey PRIMARY KEY (id);

ALTER TABLE eim.investment_project ADD CONSTRAINT investment_project_version_num_check CHECK (version_num > 0);

ALTER TABLE eim.investment_project_fund ADD CONSTRAINT investment_project_fund_pkey PRIMARY KEY (id);

ALTER TABLE eim.investment_project_fund ADD CONSTRAINT investment_project_fund_year_check CHECK (year > 1900);

ALTER TABLE eim.land_tax ADD CONSTRAINT land_tax_pkey PRIMARY KEY (id);

ALTER TABLE eim.land_tax ADD CONSTRAINT land_tax_year_check CHECK (year > 1900);

ALTER TABLE eim.macro_scenario ADD CONSTRAINT macro_scenario_pkey PRIMARY KEY (id);

ALTER TABLE eim.migration_script ADD CONSTRAINT migration_script_dbver_after_check CHECK (dbver_after > 0);

ALTER TABLE eim.migration_script ADD CONSTRAINT migration_script_dbver_before_check CHECK (dbver_before > 0);

ALTER TABLE eim.migration_script ADD CONSTRAINT migration_script_pkey PRIMARY KEY (id);

ALTER TABLE eim.modules_scenario ADD CONSTRAINT modules_scenario_pkey PRIMARY KEY (id);

ALTER TABLE eim.property_tax ADD CONSTRAINT property_tax_pkey PRIMARY KEY (id);

ALTER TABLE eim.property_tax ADD CONSTRAINT property_tax_year_check CHECK (year > 1900);

ALTER TABLE eim.scenario ADD CONSTRAINT scenario_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_acl ADD CONSTRAINT scenario_acl_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_aggr_road ADD CONSTRAINT scenario_aggr_road_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_aggr_road_span ADD CONSTRAINT scenario_aggr_road_span_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_aggr_road_span ADD CONSTRAINT scenario_aggr_road_span_year_check CHECK (year > 1900);

ALTER TABLE eim.scenario_arrangement_include ADD CONSTRAINT scenario_arrangement_include_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_bottleneck ADD CONSTRAINT scenario_bottleneck_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_bottleneck_correspondence ADD CONSTRAINT scenario_bottleneck_correspondence_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_calculation ADD CONSTRAINT scenario_calculation_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_eq_cost ADD CONSTRAINT scenario_eq_cost_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_eq_tariff ADD CONSTRAINT scenario_eq_tariff_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_event ADD CONSTRAINT scenario_event_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_event_info ADD CONSTRAINT scenario_event_info_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_event_schedule ADD CONSTRAINT scenario_event_schedule_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_opcost ADD CONSTRAINT scenario_opcost_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_opcost_schedule ADD CONSTRAINT scenario_opcost_schedule_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_res ADD CONSTRAINT scenario_res_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_res_pivot ADD CONSTRAINT scenario_res_pivot_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_res_pivot_invest ADD CONSTRAINT scenario_res_pivot_invest_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_res_pnl ADD CONSTRAINT scenario_res_pnl_pkey PRIMARY KEY (id);

ALTER TABLE eim.scenario_tariff ADD CONSTRAINT scenario_tariff_pkey PRIMARY KEY (id);

ALTER TABLE eim.setting ADD CONSTRAINT setting_pkey PRIMARY KEY (id);

ALTER TABLE eim.station ADD CONSTRAINT station_lat_check CHECK (lat >= (0)::double precision);

ALTER TABLE eim.station ADD CONSTRAINT station_lon_check CHECK (lon >= (0)::double precision);

ALTER TABLE eim.station ADD CONSTRAINT station_pkey PRIMARY KEY (id);

ALTER TABLE eim.tax ADD CONSTRAINT tax_pkey PRIMARY KEY (id);

ALTER TABLE eim.te_version ADD CONSTRAINT te_version_pkey PRIMARY KEY (id);

ALTER TABLE eim.trs_values_by_road_id ADD CONSTRAINT trs_values_by_road_id_pkey PRIMARY KEY (id);

ALTER TABLE eim.trs_values_by_rolling_stock_type ADD CONSTRAINT trs_values_by_rolling_stock_type_pkey PRIMARY KEY (id);

ALTER TABLE eim.trs_values_schedule ADD CONSTRAINT trs_values_schedule_pkey PRIMARY KEY (id);

ALTER TABLE eim.trs_version ADD CONSTRAINT trs_version_pkey PRIMARY KEY (id);

ALTER TABLE eim.user_audit ADD CONSTRAINT user_audit_pkey PRIMARY KEY (id);

ALTER TABLE eim.user_event ADD CONSTRAINT user_event_pkey PRIMARY KEY (id);

ALTER TABLE eim.user_session ADD CONSTRAINT user_session_pkey PRIMARY KEY (id);

ALTER TABLE eim.vat ADD CONSTRAINT vat_pkey PRIMARY KEY (id);

ALTER TABLE eim.vat ADD CONSTRAINT vat_year_check CHECK (year > 1900);

CREATE TABLE eim.arrangement (
    id bigint NOT NULL DEFAULT nextval('public.main_seq'::regclass),
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    start_year integer,
    duration integer,
    measure_tp_id bigint NOT NULL,
    src_stm_id character varying(4000),
    quantity integer NOT NULL,
    name character varying(40),
    generated_ind boolean NOT NULL DEFAULT false,
    cost_amt double precision,
    arrangement_tp_id bigint NOT NULL,
    project_struct_id bigint NOT NULL,
    edge_id integer);

CREATE TABLE eim.arrangement_schedule (
    id bigint NOT NULL DEFAULT nextval('public.main_seq'::regclass),
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    year integer NOT NULL,
    arrangement_id bigint NOT NULL,
    investment_amt double precision);

CREATE TABLE eim.classification_to_classification (
    id bigint NOT NULL DEFAULT nextval('public.main_seq'::regclass),
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    rank integer,
    object_id bigint NOT NULL,
    subject_id bigint NOT NULL,
    relation_tp_id bigint NOT NULL);

CREATE TABLE eim.migration_log (
    id bigint NOT NULL DEFAULT nextval('public.main_seq'::regclass),
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    dbver_before integer,
    dbver_after integer,
    execution_log bytea NOT NULL,
    success_ind boolean NOT NULL DEFAULT false,
    connection_string character varying(40),
    script bytea NOT NULL,
    migration_script_id bigint NOT NULL);

CREATE TABLE eim.project_struct (
    id bigint NOT NULL DEFAULT nextval('public.main_seq'::regclass),
    create_ts timestamp with time zone NOT NULL DEFAULT now(),
    update_ts timestamp with time zone,
    end_ts timestamp with time zone NOT NULL DEFAULT 'infinity'::timestamp with time zone,
    src_stm_id bigint NOT NULL,
    investment_project_id bigint NOT NULL,
    name character varying(40),
    polygon_id bigint NOT NULL,
    parent_project_struct_id bigint NOT NULL,
    edge_id integer);

CREATE TABLE eim.te_values (
    id bigint NOT NULL DEFAULT nextval('public.main_seq'::regclass),
    year integer NOT NULL,
    val double precision,
    version_id bigint NOT NULL,
    organisation_id bigint NOT NULL,
    object_tp_id bigint NOT NULL,
    rolling_stock_type_id bigint,
    arrangement_tp_id bigint,
    measure_tp_id bigint NOT NULL,
    te_form_tp_id bigint NOT NULL);

ALTER TABLE eim.account ADD CONSTRAINT fk_account_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.account ADD CONSTRAINT fk_account_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.account_ooo ADD CONSTRAINT fk_account_ooo_account_id FOREIGN KEY (account_id) REFERENCES eim.account (id);

ALTER TABLE eim.account_ooo ADD CONSTRAINT fk_account_ooo_deputy_id FOREIGN KEY (deputy_id) REFERENCES eim.account (id);

ALTER TABLE eim.account_role ADD CONSTRAINT fk_account_role_account_id FOREIGN KEY (account_id) REFERENCES eim.account (id);

ALTER TABLE eim.account_role ADD CONSTRAINT fk_account_role_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.account_role ADD CONSTRAINT fk_account_role_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.account_status ADD CONSTRAINT fk_account_status_account_id FOREIGN KEY (account_id) REFERENCES eim.account (id);

ALTER TABLE eim.account_status ADD CONSTRAINT fk_account_status_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.account_status ADD CONSTRAINT fk_account_status_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.admin_audit ADD CONSTRAINT fk_admin_audit_admin_id FOREIGN KEY (admin_id) REFERENCES eim.account (id);

ALTER TABLE eim.admin_audit ADD CONSTRAINT fk_admin_audit_user_id FOREIGN KEY (user_id) REFERENCES eim.account (id);

ALTER TABLE eim.classification ADD CONSTRAINT fk_classification_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.classification ADD CONSTRAINT fk_classification_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.dimension ADD CONSTRAINT fk_dimension_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.dimension ADD CONSTRAINT fk_dimension_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.integration_process ADD CONSTRAINT fk_integration_process_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.integration_process ADD CONSTRAINT fk_integration_process_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.investment_project ADD CONSTRAINT fk_investment_project_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.investment_project ADD CONSTRAINT fk_investment_project_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.macro_scenario ADD CONSTRAINT fk_macro_scenario_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.macro_scenario ADD CONSTRAINT fk_macro_scenario_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.modules_scenario ADD CONSTRAINT fk_modules_scenario_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.modules_scenario ADD CONSTRAINT fk_modules_scenario_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.scenario ADD CONSTRAINT fk_scenario_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.scenario ADD CONSTRAINT fk_scenario_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.scenario_acl ADD CONSTRAINT fk_scenario_acl_account_id FOREIGN KEY (account_id) REFERENCES eim.account (id);

ALTER TABLE eim.scenario_acl ADD CONSTRAINT fk_scenario_acl_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.scenario_acl ADD CONSTRAINT fk_scenario_acl_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.scenario_calculation ADD CONSTRAINT fk_scenario_calculation_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.scenario_calculation ADD CONSTRAINT fk_scenario_calculation_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.setting ADD CONSTRAINT fk_setting_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.setting ADD CONSTRAINT fk_setting_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.tax ADD CONSTRAINT fk_tax_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.tax ADD CONSTRAINT fk_tax_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.te_version ADD CONSTRAINT fk_te_version_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.te_version ADD CONSTRAINT fk_te_version_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.trs_version ADD CONSTRAINT fk_trs_version_create_user_id FOREIGN KEY (create_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.trs_version ADD CONSTRAINT fk_trs_version_update_user_id FOREIGN KEY (update_user_id) REFERENCES eim.account (id);

ALTER TABLE eim.user_audit ADD CONSTRAINT fk_user_audit_account_id FOREIGN KEY (account_id) REFERENCES eim.account (id);

ALTER TABLE eim.user_event ADD CONSTRAINT fk_user_event_account_id FOREIGN KEY (account_id) REFERENCES eim.account (id);

ALTER TABLE eim.user_session ADD CONSTRAINT fk_user_session_account_id FOREIGN KEY (account_id) REFERENCES eim.account (id);

ALTER TABLE eim.account ADD CONSTRAINT fk_account_department_id FOREIGN KEY (department_id) REFERENCES eim.classification (id);

ALTER TABLE eim.account ADD CONSTRAINT fk_account_ooo_status_id FOREIGN KEY (ooo_status_id) REFERENCES eim.classification (id);

ALTER TABLE eim.account ADD CONSTRAINT fk_account_position_id FOREIGN KEY (position_id) REFERENCES eim.classification (id);

ALTER TABLE eim.account ADD CONSTRAINT fk_account_pwd_hash_alg_id FOREIGN KEY (pwd_hash_alg_id) REFERENCES eim.classification (id);

ALTER TABLE eim.account ADD CONSTRAINT fk_account_status_id FOREIGN KEY (status_id) REFERENCES eim.classification (id);

ALTER TABLE eim.account_role ADD CONSTRAINT fk_account_role_role_id FOREIGN KEY (role_id) REFERENCES eim.classification (id);

ALTER TABLE eim.account_status ADD CONSTRAINT fk_account_status_status_id FOREIGN KEY (status_id) REFERENCES eim.classification (id);

ALTER TABLE eim.classification ADD CONSTRAINT fk_classification_object_tp_id FOREIGN KEY (object_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.classification ADD CONSTRAINT fk_classification_parent_id FOREIGN KEY (parent_id) REFERENCES eim.classification (id);

ALTER TABLE eim.edge ADD CONSTRAINT fk_edge_polygon_id FOREIGN KEY (polygon_id) REFERENCES eim.classification (id);

ALTER TABLE eim.edge ADD CONSTRAINT fk_edge_region_from_id FOREIGN KEY (region_from_id) REFERENCES eim.classification (id);

ALTER TABLE eim.edge ADD CONSTRAINT fk_edge_region_to_id FOREIGN KEY (region_to_id) REFERENCES eim.classification (id);

ALTER TABLE eim.idx_value ADD CONSTRAINT fk_idx_value_idx_tp_id FOREIGN KEY (idx_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.integration_process ADD CONSTRAINT fk_integration_process_master_system_id FOREIGN KEY (master_system_id) REFERENCES eim.classification (id);

ALTER TABLE eim.integration_process ADD CONSTRAINT fk_integration_process_process_id FOREIGN KEY (process_id) REFERENCES eim.classification (id);

ALTER TABLE eim.integration_process ADD CONSTRAINT fk_integration_process_process_result_id FOREIGN KEY (process_result_id) REFERENCES eim.classification (id);

ALTER TABLE eim.integration_process ADD CONSTRAINT fk_integration_process_slave_system_id FOREIGN KEY (slave_system_id) REFERENCES eim.classification (id);

ALTER TABLE eim.investment_project ADD CONSTRAINT fk_investment_project_asset_tp_id FOREIGN KEY (asset_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.investment_project ADD CONSTRAINT fk_investment_project_func_cst_id FOREIGN KEY (func_cst_id) REFERENCES eim.classification (id);

ALTER TABLE eim.investment_project ADD CONSTRAINT fk_investment_project_goal_tp_id FOREIGN KEY (goal_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.investment_project ADD CONSTRAINT fk_investment_project_ip_inclusion_tp_id FOREIGN KEY (ip_inclusion_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.investment_project ADD CONSTRAINT fk_investment_project_phase_tp_id FOREIGN KEY (phase_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.investment_project ADD CONSTRAINT fk_investment_project_polygon_id FOREIGN KEY (polygon_id) REFERENCES eim.classification (id);

ALTER TABLE eim.investment_project ADD CONSTRAINT fk_investment_project_prj_func_tp_id FOREIGN KEY (prj_func_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.investment_project ADD CONSTRAINT fk_investment_project_purpose_tp_id FOREIGN KEY (purpose_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.investment_project_fund ADD CONSTRAINT fk_investment_project_fund_funding_tp_id FOREIGN KEY (funding_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.investment_project_fund ADD CONSTRAINT fk_investment_project_fund_repayment_tp_id FOREIGN KEY (repayment_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.scenario ADD CONSTRAINT fk_scenario_calculation_status_id FOREIGN KEY (calculation_status_id) REFERENCES eim.classification (id);

ALTER TABLE eim.scenario ADD CONSTRAINT fk_scenario_calculation_tp_id FOREIGN KEY (calculation_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.scenario_acl ADD CONSTRAINT fk_scenario_acl_access_tp_id FOREIGN KEY (access_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.scenario_aggr_road ADD CONSTRAINT fk_scenario_aggr_road_railroad_id FOREIGN KEY (railroad_id) REFERENCES eim.classification (id);

ALTER TABLE eim.scenario_bottleneck ADD CONSTRAINT fk_scenario_bottleneck_slice_tp_id FOREIGN KEY (slice_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.scenario_calculation ADD CONSTRAINT fk_scenario_calculation_calc_phase_current_id FOREIGN KEY (calc_phase_current_id) REFERENCES eim.classification (id);

ALTER TABLE eim.scenario_calculation ADD CONSTRAINT fk_scenario_calculation_calculation_status_id FOREIGN KEY (calculation_status_id) REFERENCES eim.classification (id);

ALTER TABLE eim.scenario_calculation ADD CONSTRAINT fk_scenario_calculation_calculation_tp_id FOREIGN KEY (calculation_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.scenario_eq_cost ADD CONSTRAINT fk_scenario_eq_cost_railroad_id FOREIGN KEY (railroad_id) REFERENCES eim.classification (id);

ALTER TABLE eim.scenario_eq_tariff ADD CONSTRAINT fk_scenario_eq_tariff_cargo_hl_tp_id FOREIGN KEY (cargo_hl_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.scenario_res ADD CONSTRAINT fk_scenario_res_slice_tp_id FOREIGN KEY (slice_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.scenario_res_pivot_invest ADD CONSTRAINT fk_scenario_res_pivot_invest_funding_tp_id FOREIGN KEY (funding_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.scenario_res_pnl ADD CONSTRAINT fk_scenario_res_pnl_cargo_hl_tp_id FOREIGN KEY (cargo_hl_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.setting ADD CONSTRAINT fk_setting_parameter_id FOREIGN KEY (parameter_id) REFERENCES eim.classification (id);

ALTER TABLE eim.station ADD CONSTRAINT fk_station_railroad_id FOREIGN KEY (railroad_id) REFERENCES eim.classification (id);

ALTER TABLE eim.station ADD CONSTRAINT fk_station_region_id FOREIGN KEY (region_id) REFERENCES eim.classification (id);

ALTER TABLE eim.te_version ADD CONSTRAINT fk_te_version_form_id FOREIGN KEY (form_id) REFERENCES eim.classification (id);

ALTER TABLE eim.trs_values_by_road_id ADD CONSTRAINT fk_trs_values_by_road_id_activity_type_id FOREIGN KEY (activity_type_id) REFERENCES eim.classification (id);

ALTER TABLE eim.trs_values_by_road_id ADD CONSTRAINT fk_trs_values_by_road_id_customer_id FOREIGN KEY (customer_id) REFERENCES eim.classification (id);

ALTER TABLE eim.trs_values_by_road_id ADD CONSTRAINT fk_trs_values_by_road_id_passenger_service_type_id FOREIGN KEY (passenger_service_type_id) REFERENCES eim.classification (id);

ALTER TABLE eim.trs_values_by_road_id ADD CONSTRAINT fk_trs_values_by_road_id_railroad_id FOREIGN KEY (railroad_id) REFERENCES eim.classification (id);

ALTER TABLE eim.trs_values_by_road_id ADD CONSTRAINT fk_trs_values_by_road_id_rolling_stock_type_id FOREIGN KEY (rolling_stock_type_id) REFERENCES eim.classification (id);

ALTER TABLE eim.trs_values_by_road_id ADD CONSTRAINT fk_trs_values_by_road_id_traction_type_id FOREIGN KEY (traction_type_id) REFERENCES eim.classification (id);

ALTER TABLE eim.trs_values_by_road_id ADD CONSTRAINT fk_trs_values_by_road_id_traffic_tp_id FOREIGN KEY (traffic_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.trs_values_by_road_id ADD CONSTRAINT fk_trs_values_by_road_id_trs_param_id FOREIGN KEY (trs_param_id) REFERENCES eim.classification (id);

ALTER TABLE eim.trs_values_by_rolling_stock_type ADD CONSTRAINT fk_trs_values_by_rolling_stock_type_repair_type_id FOREIGN KEY (repair_type_id) REFERENCES eim.classification (id);

ALTER TABLE eim.trs_values_by_rolling_stock_type ADD CONSTRAINT fk_trs_values_by_rolling_stock_type_rolling_stock_type_id FOREIGN KEY (rolling_stock_type_id) REFERENCES eim.classification (id);

ALTER TABLE eim.trs_values_by_rolling_stock_type ADD CONSTRAINT fk_trs_values_by_rolling_stock_type_train_tp_id FOREIGN KEY (train_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.trs_values_schedule ADD CONSTRAINT fk_trs_values_schedule_measure_tp_id FOREIGN KEY (measure_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.trs_values_schedule ADD CONSTRAINT fk_trs_values_schedule_trs_param_id FOREIGN KEY (trs_param_id) REFERENCES eim.classification (id);

ALTER TABLE eim.user_event ADD CONSTRAINT fk_user_event_user_event_tp_id FOREIGN KEY (user_event_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.user_session ADD CONSTRAINT fk_user_session_connection_tp_id FOREIGN KEY (connection_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.classification ADD CONSTRAINT fk_classification_dimension_id FOREIGN KEY (dimension_id) REFERENCES eim.dimension (id);

ALTER TABLE eim.edge ADD CONSTRAINT fk_edge_parent_edge_id FOREIGN KEY (parent_edge_id) REFERENCES eim.edge (id);

ALTER TABLE eim.investment_project ADD CONSTRAINT fk_investment_project_parent_investment_project_id FOREIGN KEY (parent_investment_project_id) REFERENCES eim.investment_project (id);

ALTER TABLE eim.investment_project_fund ADD CONSTRAINT fk_investment_project_fund_investment_project_id FOREIGN KEY (investment_project_id) REFERENCES eim.investment_project (id);

ALTER TABLE eim.scenario ADD CONSTRAINT fk_scenario_investment_project_id FOREIGN KEY (investment_project_id) REFERENCES eim.investment_project (id);

ALTER TABLE eim.idx_value ADD CONSTRAINT fk_idx_value_macro_scenario_id FOREIGN KEY (macro_scenario_id) REFERENCES eim.macro_scenario (id);

ALTER TABLE eim.scenario ADD CONSTRAINT fk_scenario_macro_scenario_id FOREIGN KEY (macro_scenario_id) REFERENCES eim.macro_scenario (id);

ALTER TABLE eim.edge_detail ADD CONSTRAINT fk_edge_detail_scenario_id FOREIGN KEY (scenario_id) REFERENCES eim.scenario (id);

ALTER TABLE eim.modules_scenario ADD CONSTRAINT fk_modules_scenario_scenario_id FOREIGN KEY (scenario_id) REFERENCES eim.scenario (id);

ALTER TABLE eim.scenario ADD CONSTRAINT fk_scenario_parent_id FOREIGN KEY (parent_id) REFERENCES eim.scenario (id);

ALTER TABLE eim.scenario_acl ADD CONSTRAINT fk_scenario_acl_script FOREIGN KEY (script) REFERENCES eim.scenario (id);

ALTER TABLE eim.scenario_aggr_road ADD CONSTRAINT fk_scenario_aggr_road_scenario_id FOREIGN KEY (scenario_id) REFERENCES eim.scenario (id);

ALTER TABLE eim.scenario_arrangement_include ADD CONSTRAINT fk_scenario_arrangement_include_scenario_id FOREIGN KEY (scenario_id) REFERENCES eim.scenario (id);

ALTER TABLE eim.scenario_bottleneck ADD CONSTRAINT fk_scenario_bottleneck_scenario_id FOREIGN KEY (scenario_id) REFERENCES eim.scenario (id);

ALTER TABLE eim.scenario_calculation ADD CONSTRAINT fk_scenario_calculation_scenario_id FOREIGN KEY (scenario_id) REFERENCES eim.scenario (id);

ALTER TABLE eim.scenario_eq_cost ADD CONSTRAINT fk_scenario_eq_cost_scenario_id FOREIGN KEY (scenario_id) REFERENCES eim.scenario (id);

ALTER TABLE eim.scenario_eq_tariff ADD CONSTRAINT fk_scenario_eq_tariff_scenario_id FOREIGN KEY (scenario_id) REFERENCES eim.scenario (id);

ALTER TABLE eim.scenario_event ADD CONSTRAINT fk_scenario_event_scenario_id FOREIGN KEY (scenario_id) REFERENCES eim.scenario (id);

ALTER TABLE eim.scenario_opcost ADD CONSTRAINT fk_scenario_opcost_scenario_id FOREIGN KEY (scenario_id) REFERENCES eim.scenario (id);

ALTER TABLE eim.scenario_res ADD CONSTRAINT fk_scenario_res_scenario_id FOREIGN KEY (scenario_id) REFERENCES eim.scenario (id);

ALTER TABLE eim.scenario_tariff ADD CONSTRAINT fk_scenario_tariff_scenario_id FOREIGN KEY (scenario_id) REFERENCES eim.scenario (id);

ALTER TABLE eim.scenario_aggr_road_span ADD CONSTRAINT fk_scenario_aggr_road_span_scenario_aggr_road_id FOREIGN KEY (scenario_aggr_road_id) REFERENCES eim.scenario_aggr_road (id);

ALTER TABLE eim.scenario_bottleneck_correspondence ADD CONSTRAINT fk_scenario_bottleneck_correspondence_scenario_bottleneck_id FOREIGN KEY (scenario_bottleneck_id) REFERENCES eim.scenario_bottleneck (id);

ALTER TABLE eim.scenario_arrangement_include ADD CONSTRAINT fk_scenario_arrangement_include_scenario_event_id FOREIGN KEY (scenario_event_id) REFERENCES eim.scenario_event (id);

ALTER TABLE eim.scenario_event_info ADD CONSTRAINT fk_scenario_event_info_scenario_event_id FOREIGN KEY (scenario_event_id) REFERENCES eim.scenario_event (id);

ALTER TABLE eim.scenario_event_schedule ADD CONSTRAINT fk_scenario_event_schedule_scenario_event_info_id FOREIGN KEY (scenario_event_info_id) REFERENCES eim.scenario_event_info (id);

ALTER TABLE eim.scenario_opcost_schedule ADD CONSTRAINT fk_scenario_opcost_schedule_scenario_opcost_id FOREIGN KEY (scenario_opcost_id) REFERENCES eim.scenario_opcost (id);

ALTER TABLE eim.scenario_res_pivot ADD CONSTRAINT fk_scenario_res_pivot_scenario_res_id FOREIGN KEY (scenario_res_id) REFERENCES eim.scenario_res (id);

ALTER TABLE eim.scenario_res_pnl ADD CONSTRAINT fk_scenario_res_pnl_scenario_res_id FOREIGN KEY (scenario_res_id) REFERENCES eim.scenario_res (id);

ALTER TABLE eim.scenario_res_pivot_invest ADD CONSTRAINT fk_scenario_res_pivot_invest_scenario_res_pivot_id FOREIGN KEY (scenario_res_pivot_id) REFERENCES eim.scenario_res_pivot (id);

ALTER TABLE eim.edge ADD CONSTRAINT fk_edge_station_from_id FOREIGN KEY (station_from_id) REFERENCES eim.station (id);

ALTER TABLE eim.edge ADD CONSTRAINT fk_edge_station_to_id FOREIGN KEY (station_to_id) REFERENCES eim.station (id);

ALTER TABLE eim.income_tax ADD CONSTRAINT fk_income_tax_tax_id FOREIGN KEY (tax_id) REFERENCES eim.tax (id);

ALTER TABLE eim.land_tax ADD CONSTRAINT fk_land_tax_tax_id FOREIGN KEY (tax_id) REFERENCES eim.tax (id);

ALTER TABLE eim.property_tax ADD CONSTRAINT fk_property_tax_tax_id FOREIGN KEY (tax_id) REFERENCES eim.tax (id);

ALTER TABLE eim.scenario ADD CONSTRAINT fk_scenario_tax_id FOREIGN KEY (tax_id) REFERENCES eim.tax (id);

ALTER TABLE eim.vat ADD CONSTRAINT fk_vat_tax_id FOREIGN KEY (tax_id) REFERENCES eim.tax (id);

ALTER TABLE eim.modules_scenario ADD CONSTRAINT fk_modules_scenario_te_version FOREIGN KEY (te_version) REFERENCES eim.te_version (id);

ALTER TABLE eim.trs_values_schedule ADD CONSTRAINT fk_trs_values_schedule_trs_values_by_road_id FOREIGN KEY (trs_values_by_road_id) REFERENCES eim.trs_values_by_road_id (id);

ALTER TABLE eim.modules_scenario ADD CONSTRAINT fk_modules_scenario_trs_version_id FOREIGN KEY (trs_version_id) REFERENCES eim.trs_version (id);

ALTER TABLE eim.trs_values_by_road_id ADD CONSTRAINT fk_trs_values_by_road_id_trs_version_id FOREIGN KEY (trs_version_id) REFERENCES eim.trs_version (id);

ALTER TABLE eim.trs_values_by_rolling_stock_type ADD CONSTRAINT fk_trs_values_by_rolling_stock_type_trs_version_id FOREIGN KEY (trs_version_id) REFERENCES eim.trs_version (id);

ALTER TABLE eim.admin_audit ADD CONSTRAINT fk_admin_audit_user_session_id FOREIGN KEY (user_session_id) REFERENCES eim.user_session (id);

ALTER TABLE eim.user_audit ADD CONSTRAINT fk_user_audit_user_session_id FOREIGN KEY (user_session_id) REFERENCES eim.user_session (id);

ALTER TABLE eim.arrangement ADD CONSTRAINT arrangement_pkey PRIMARY KEY (id);

ALTER TABLE eim.arrangement_schedule ADD CONSTRAINT arrangement_schedule_pkey PRIMARY KEY (id);

ALTER TABLE eim.classification_to_classification ADD CONSTRAINT classification_to_classification_pkey PRIMARY KEY (id);

ALTER TABLE eim.classification_to_classification ADD CONSTRAINT fk_classification_to_classification_object_id FOREIGN KEY (object_id) REFERENCES eim.classification (id);

ALTER TABLE eim.classification_to_classification ADD CONSTRAINT fk_classification_to_classification_relation_tp_id FOREIGN KEY (relation_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.classification_to_classification ADD CONSTRAINT fk_classification_to_classification_subject_id FOREIGN KEY (subject_id) REFERENCES eim.classification (id);

ALTER TABLE eim.migration_log ADD CONSTRAINT fk_migration_log_migration_script_id FOREIGN KEY (migration_script_id) REFERENCES eim.migration_script (id);

ALTER TABLE eim.migration_log ADD CONSTRAINT migration_log_dbver_after_check CHECK (dbver_after > 0);

ALTER TABLE eim.migration_log ADD CONSTRAINT migration_log_dbver_before_check CHECK (dbver_before > 0);

ALTER TABLE eim.migration_log ADD CONSTRAINT migration_log_pkey PRIMARY KEY (id);

ALTER TABLE eim.project_struct ADD CONSTRAINT project_struct_pkey PRIMARY KEY (id);

ALTER TABLE eim.te_values ADD CONSTRAINT fk_te_values_arrangement_tp_id FOREIGN KEY (arrangement_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.te_values ADD CONSTRAINT fk_te_values_measure_tp_id FOREIGN KEY (measure_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.te_values ADD CONSTRAINT fk_te_values_object_tp_id FOREIGN KEY (object_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.te_values ADD CONSTRAINT fk_te_values_organisation_id FOREIGN KEY (organisation_id) REFERENCES eim.classification (id);

ALTER TABLE eim.te_values ADD CONSTRAINT fk_te_values_rolling_stock_type_id FOREIGN KEY (rolling_stock_type_id) REFERENCES eim.classification (id);

ALTER TABLE eim.te_values ADD CONSTRAINT fk_te_values_te_form_tp_id FOREIGN KEY (te_form_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.te_values ADD CONSTRAINT fk_te_values_version_id FOREIGN KEY (version_id) REFERENCES eim.te_version (id);

ALTER TABLE eim.te_values ADD CONSTRAINT te_values_pkey PRIMARY KEY (id);

