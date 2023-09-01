ALTER TABLE eim.admin_audit
    ALTER COLUMN user_login TYPE character varying(40);

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

ALTER TABLE eim.scenario_res
    ALTER COLUMN delivery_gap DROP NOT NULL;

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

ALTER TABLE eim.trs_values_schedule
    ADD COLUMN trs_values_by_road_id bigint;

ALTER TABLE eim.modules_scenario ADD CONSTRAINT modules_scenario_pkey PRIMARY KEY (id);

ALTER TABLE eim.trs_values_by_road_id ADD CONSTRAINT trs_values_by_road_id_pkey PRIMARY KEY (id);

ALTER TABLE eim.trs_values_by_rolling_stock_type ADD CONSTRAINT trs_values_by_rolling_stock_type_pkey PRIMARY KEY (id);

ALTER TABLE eim.arrangement
    ALTER COLUMN edge_id SET NOT NULL;

ALTER TABLE eim.classification_to_classification
    ALTER COLUMN id SET DEFAULT nextval('public.main_seq'::regclass);

ALTER TABLE eim.migration_log
    ALTER COLUMN id SET DEFAULT nextval('public.main_seq'::regclass);

ALTER TABLE eim.te_values
    ADD COLUMN rolling_stock_type_id bigint;

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

ALTER TABLE eim.classification_to_classification ADD CONSTRAINT fk_classification_to_classification_object_id FOREIGN KEY (object_id) REFERENCES eim.classification (id);

ALTER TABLE eim.classification_to_classification ADD CONSTRAINT fk_classification_to_classification_relation_tp_id FOREIGN KEY (relation_tp_id) REFERENCES eim.classification (id);

ALTER TABLE eim.classification_to_classification ADD CONSTRAINT fk_classification_to_classification_subject_id FOREIGN KEY (subject_id) REFERENCES eim.classification (id);

ALTER TABLE eim.migration_log ADD CONSTRAINT fk_migration_log_migration_script_id FOREIGN KEY (migration_script_id) REFERENCES eim.migration_script (id);

ALTER TABLE eim.te_values ADD CONSTRAINT fk_te_values_rolling_stock_type_id FOREIGN KEY (rolling_stock_type_id) REFERENCES eim.classification (id);

ALTER TABLE eim.te_values DROP CONSTRAINT fk_te_values_rolling_stock_tp_id;

ALTER TABLE eim.arrangement DROP CONSTRAINT fk_arrangment_iprjstruct;

ALTER TABLE eim.project_struct DROP CONSTRAINT fk_parent_project_level;

ALTER TABLE eim.project_struct DROP CONSTRAINT fk_iprjstruct_polygon;

ALTER TABLE eim.project_struct DROP CONSTRAINT fk_iprjstruct_iprj;

ALTER TABLE eim.project_struct DROP CONSTRAINT fk_iprjstruct_edge;

ALTER TABLE eim.arrangement_schedule DROP CONSTRAINT fk_ar_to_inv_schedule;

ALTER TABLE eim.arrangement_schedule DROP CONSTRAINT arrangement_schedule_year_check;

ALTER TABLE eim.scenario_arrangement_include DROP CONSTRAINT fk_scenario_inclusion_arragement;

ALTER TABLE eim.arrangement DROP CONSTRAINT fk_arrangment_tp;

ALTER TABLE eim.arrangement DROP CONSTRAINT fk_arrangment_measure_tp;

ALTER TABLE eim.arrangement DROP CONSTRAINT fk_38;

ALTER TABLE eim.arrangement DROP CONSTRAINT arrangement_start_year_check;

ALTER TABLE eim.classification_to_classification DROP CONSTRAINT fk_clxcl_type;

ALTER TABLE eim.classification_to_classification DROP CONSTRAINT fk_clxcl_subject;

ALTER TABLE eim.classification_to_classification DROP CONSTRAINT fk_clxcl_object;

ALTER TABLE eim.te_values DROP COLUMN rolling_stock_tp_id;

ALTER TABLE eim.vat DROP CONSTRAINT fk_17;

ALTER TABLE eim.user_audit DROP CONSTRAINT fk_user_audit_session;

ALTER TABLE eim.admin_audit DROP CONSTRAINT fk_admin_audit_session;

ALTER TABLE eim.user_session DROP CONSTRAINT fk_session_user;

ALTER TABLE eim.user_session DROP CONSTRAINT fk_connection_tp;

ALTER TABLE eim.user_event DROP CONSTRAINT fk_user_event_tp;

ALTER TABLE eim.user_event DROP CONSTRAINT fk_user_event_account;

ALTER TABLE eim.user_audit DROP CONSTRAINT fk_user_audit_account;

ALTER TABLE eim.trs_values DROP CONSTRAINT fk_trs_values_trs_version_id;

ALTER TABLE eim.trs_values_schedule DROP CONSTRAINT fk_trs_values_schedule_update_user_id;

ALTER TABLE eim.trs_values_schedule DROP CONSTRAINT fk_trs_values_schedule_create_user_id;

ALTER TABLE eim.trs_values DROP CONSTRAINT fk_trs_values_update_user_id;

ALTER TABLE eim.trs_values DROP CONSTRAINT fk_trs_values_traction_type_id;

ALTER TABLE eim.trs_values DROP CONSTRAINT fk_trs_values_rolling_stock_type_id;

ALTER TABLE eim.trs_values DROP CONSTRAINT fk_trs_values_repair_type_id;

ALTER TABLE eim.trs_values DROP CONSTRAINT fk_trs_values_railroad_id;

ALTER TABLE eim.trs_values DROP CONSTRAINT fk_trs_values_passenger_service_type_id;

ALTER TABLE eim.trs_values DROP CONSTRAINT fk_trs_values_customer_id;

ALTER TABLE eim.trs_values DROP CONSTRAINT fk_trs_values_create_user_id;

ALTER TABLE eim.trs_values DROP CONSTRAINT fk_trs_values_activity_type_id;

ALTER TABLE eim.trs_values DROP CONSTRAINT trs_values_pkey;

ALTER TABLE eim.income_tax DROP CONSTRAINT fk_20;

ALTER TABLE eim.land_tax DROP CONSTRAINT fk_19;

ALTER TABLE eim.property_tax DROP CONSTRAINT fk_18;

ALTER TABLE eim.tax DROP CONSTRAINT fk_tax_mode_update_user;

ALTER TABLE eim.tax DROP CONSTRAINT fk_tax_mode_create_user;

ALTER TABLE eim.scenario DROP CONSTRAINT fk_29;

ALTER TABLE eim.station DROP CONSTRAINT fk_41;

ALTER TABLE eim.station DROP CONSTRAINT fk_25;

ALTER TABLE eim.edge DROP CONSTRAINT fk_edge_stto;

ALTER TABLE eim.edge DROP CONSTRAINT fk_edge_stfrom;

ALTER TABLE eim.setting DROP CONSTRAINT fk_settings_uu;

ALTER TABLE eim.setting DROP CONSTRAINT fk_settings_cru;

ALTER TABLE eim.setting DROP CONSTRAINT fk_setting_parameter;

ALTER TABLE eim.scenario_tariff DROP CONSTRAINT fk_scenario_tarif;

ALTER TABLE eim.scenario_res_pnl DROP CONSTRAINT fk_scenario_pnl_cargo_tp;

ALTER TABLE eim.scenario_res_pnl DROP CONSTRAINT fk_res_to_pnl;

ALTER TABLE eim.scenario_res_pivot_invest DROP CONSTRAINT fk_investment_detial;

ALTER TABLE eim.scenario_res_pivot_invest DROP CONSTRAINT fk_33;

ALTER TABLE eim.scenario_res_pivot DROP CONSTRAINT fk_res_to_fin;

ALTER TABLE eim.scenario_res DROP CONSTRAINT fk_scenario_to_results;

ALTER TABLE eim.scenario_res DROP CONSTRAINT fk_calc_result_tp;

ALTER TABLE eim.scenario_opcost_schedule DROP CONSTRAINT fk_scenario_opcost_schedule;

ALTER TABLE eim.scenario_opcost DROP CONSTRAINT fk_scenario_opcost;

ALTER TABLE eim.scenario_event_schedule DROP CONSTRAINT fk_ev_info_schdl;

ALTER TABLE eim.scenario_event_info DROP CONSTRAINT fk_ev_info;

ALTER TABLE eim.scenario_arrangement_include DROP CONSTRAINT fk_scenario_events_inclusion;

ALTER TABLE eim.scenario_event DROP CONSTRAINT fk_scenario_to_events;

ALTER TABLE eim.scenario_eq_tariff DROP CONSTRAINT fk_scenario_eq_tariff_cargo_tp;

ALTER TABLE eim.scenario_eq_tariff DROP CONSTRAINT fk_scenario_eq_tariff;

ALTER TABLE eim.scenario_eq_cost DROP CONSTRAINT fk_scenario_eq_cost_road_tp;

ALTER TABLE eim.scenario_eq_cost DROP CONSTRAINT fk_scenario_eq_cost;

ALTER TABLE eim.scenario_calculation DROP CONSTRAINT fk_calculation_update_user;

ALTER TABLE eim.scenario_calculation DROP CONSTRAINT fk_calculation_tp;

ALTER TABLE eim.scenario_calculation DROP CONSTRAINT fk_calculation_status_tp;

ALTER TABLE eim.scenario_calculation DROP CONSTRAINT fk_calculation_scenario_eim;

ALTER TABLE eim.scenario_calculation DROP CONSTRAINT fk_calculation_create_user;

ALTER TABLE eim.scenario_calculation DROP CONSTRAINT fk_cacl_phase;

ALTER TABLE eim.scenario_bottleneck_correspondence DROP CONSTRAINT fk_bottleneck_corr;

ALTER TABLE eim.scenario_bottleneck DROP CONSTRAINT fk_scenario_to_bottleneck;

ALTER TABLE eim.scenario_bottleneck DROP CONSTRAINT fk_31;

ALTER TABLE eim.scenario_arrangement_include DROP CONSTRAINT fk_scenario_inclusion_scenario;

ALTER TABLE eim.scenario_aggr_road_span DROP CONSTRAINT fk_scenario_consolicated_road_frag;

ALTER TABLE eim.scenario_aggr_road DROP CONSTRAINT fk_scenario_road;

ALTER TABLE eim.scenario_aggr_road DROP CONSTRAINT fk_scenario_consolicated_road;

ALTER TABLE eim.scenario_acl DROP CONSTRAINT fk_scenario_access_user;

ALTER TABLE eim.scenario_acl DROP CONSTRAINT fk_scenario_access_updated_user;

ALTER TABLE eim.scenario_acl DROP CONSTRAINT fk_scenario_access_created_user;

ALTER TABLE eim.scenario_acl DROP CONSTRAINT fk_access_level;

ALTER TABLE eim.scenario_acl DROP CONSTRAINT fk_8;

ALTER TABLE eim.edge_detail DROP CONSTRAINT fk_detail_edge_scenario;

ALTER TABLE eim.scenario DROP CONSTRAINT fk_scenarion_child_to_parent;

ALTER TABLE eim.scenario DROP CONSTRAINT fk_scenario_ip;

ALTER TABLE eim.scenario DROP CONSTRAINT fk_scenario_calculation_tp;

ALTER TABLE eim.scenario DROP CONSTRAINT fk_scenario_calculation_status_tp;

ALTER TABLE eim.scenario DROP CONSTRAINT fk_3;

ALTER TABLE eim.scenario DROP CONSTRAINT fk_28;

ALTER TABLE eim.scenario DROP CONSTRAINT fk_2;

ALTER TABLE eim.scenario DROP CONSTRAINT scenario_year_to_check;

ALTER TABLE eim.scenario DROP CONSTRAINT scenario_year_from_check;

ALTER TABLE eim.migration_log DROP CONSTRAINT fk_migration_script_to_log;

ALTER TABLE eim.idx_value DROP CONSTRAINT fk_15;

ALTER TABLE eim.macro_scenario DROP CONSTRAINT fk_macro_update_user;

ALTER TABLE eim.macro_scenario DROP CONSTRAINT fk_macro_create_user;

ALTER TABLE eim.investment_project_fund DROP CONSTRAINT fk_iprjfund;

ALTER TABLE eim.investment_project_fund DROP CONSTRAINT fk_iprj_funding_tp;

ALTER TABLE eim.investment_project_fund DROP CONSTRAINT fk_iprj_funding_body_repayment_tp;

ALTER TABLE eim.investment_project DROP CONSTRAINT fk_parent_iprj;

ALTER TABLE eim.investment_project DROP CONSTRAINT fk_iprj_update_user;

ALTER TABLE eim.investment_project DROP CONSTRAINT fk_iprj_stage_tp;

ALTER TABLE eim.investment_project DROP CONSTRAINT fk_iprj_purpose_tp;

ALTER TABLE eim.investment_project DROP CONSTRAINT fk_iprj_polygon;

ALTER TABLE eim.investment_project DROP CONSTRAINT fk_iprj_inclusion_tp;

ALTER TABLE eim.investment_project DROP CONSTRAINT fk_iprj_goal_tp;

ALTER TABLE eim.investment_project DROP CONSTRAINT fk_iprj_func_tp;

ALTER TABLE eim.investment_project DROP CONSTRAINT fk_iprj_cst;

ALTER TABLE eim.investment_project DROP CONSTRAINT fk_iprj_create_user;

ALTER TABLE eim.investment_project DROP CONSTRAINT fk_iprj_asset_tp;

ALTER TABLE eim.integration_process DROP CONSTRAINT fk_integration_uu;

ALTER TABLE eim.integration_process DROP CONSTRAINT fk_integration_cru;

ALTER TABLE eim.integration_process DROP CONSTRAINT fk_7;

ALTER TABLE eim.integration_process DROP CONSTRAINT fk_6;

ALTER TABLE eim.integration_process DROP CONSTRAINT fk_5;

ALTER TABLE eim.integration_process DROP CONSTRAINT fk_4;

ALTER TABLE eim.idx_value DROP CONSTRAINT fk_16;

ALTER TABLE eim.edge DROP CONSTRAINT fk_parent_edge;

ALTER TABLE eim.edge DROP CONSTRAINT fk_edge_polygon;

ALTER TABLE eim.edge DROP CONSTRAINT fk_40;

ALTER TABLE eim.edge DROP CONSTRAINT fk_39;

ALTER TABLE eim.classification DROP CONSTRAINT fk_dim;

ALTER TABLE eim.dimension DROP CONSTRAINT fk_dim_update_user;

ALTER TABLE eim.dimension DROP CONSTRAINT fk_dim_create_user;

ALTER TABLE eim.account_role DROP CONSTRAINT fk_account_role;

ALTER TABLE eim.account_status DROP CONSTRAINT fk_account_status_hist;

ALTER TABLE eim.account DROP CONSTRAINT fk_user_department;

ALTER TABLE eim.account DROP CONSTRAINT fk_pwd_hash_algorythm;

ALTER TABLE eim.account DROP CONSTRAINT fk_expert_position;

ALTER TABLE eim.account DROP CONSTRAINT fk_account_status;

ALTER TABLE eim.account DROP CONSTRAINT fk_account_ooo_status;

ALTER TABLE eim.classification DROP CONSTRAINT fl_cl_tp;

ALTER TABLE eim.classification DROP CONSTRAINT fk_parent_cl;

ALTER TABLE eim.classification DROP CONSTRAINT fk_cl_update_user;

ALTER TABLE eim.classification DROP CONSTRAINT fk_cl_create_user;

ALTER TABLE eim.admin_audit DROP CONSTRAINT fk_admin_audit_subject;

ALTER TABLE eim.admin_audit DROP CONSTRAINT fk_admin_audit_admin;

ALTER TABLE eim.account_status DROP CONSTRAINT fk_account_status_uu;

ALTER TABLE eim.account_status DROP CONSTRAINT fk_account_status_cru;

ALTER TABLE eim.account_status DROP CONSTRAINT fk_account_status2;

ALTER TABLE eim.account_role DROP CONSTRAINT fk_role_uu;

ALTER TABLE eim.account_role DROP CONSTRAINT fk_role_cru;

ALTER TABLE eim.account_role DROP CONSTRAINT fk_account_role_user;

ALTER TABLE eim.account_ooo DROP CONSTRAINT fk_ooo_deputy;

ALTER TABLE eim.account_ooo DROP CONSTRAINT fk_ooo_account;

ALTER TABLE eim.account DROP CONSTRAINT fk_user_update_user;

ALTER TABLE eim.account DROP CONSTRAINT fk_user_create_user;

ALTER TABLE eim.trs_values_schedule DROP COLUMN create_user_id;

ALTER TABLE eim.trs_values_schedule DROP COLUMN update_user_id;

DROP TABLE eim.trs_values;

