import pandas as pd
from pprint import pprint
from yaml import safe_load, dump
import codecs


def get_refs():
    with open("logic_model/logic_model_all.yaml") as file:
        yaml_db_data = safe_load(file)
    refs = {}
    for table in yaml_db_data['schema eim']:

        try:
            fk_list = yaml_db_data['schema eim'][table]['foreign_keys']
            for fk in fk_list:
                # print(table.split(' ')[1], fk_list[fk]['columns'][0], fk_list[fk]['references']['columns'][0], fk_list[fk]['references']['table'])
                if table.split(' ')[1] in refs:
                    refs[table.split(' ')[1]] |= {fk_list[fk]['columns'][0]: (
                        fk_list[fk]['references']['table'], fk_list[fk]['references']['columns'][0])}
                else:
                    refs[table.split(' ')[1]] = {fk_list[fk]['columns'][0]: (
                        fk_list[fk]['references']['table'], fk_list[fk]['references']['columns'][0])}

        except (KeyError, TypeError):
            pass
    return refs


def parse_entities(table_fis_name, entities):
    for table_log_name in entities:
        if table_fis_name == entities[table_log_name]:
            return table_log_name


def parse_columns(table_log_name, table_fis_columns):
    filds = {}
    for columns in table_fis_columns:
        for fis_name in columns:
            filds[table_log_name] |= [fis_name, columns[fis_name]['type']]
            if fis_name in filds:
                filds[table_log_name] |= [fis_name, columns[fis_name]['type']]
            else:
                filds[table_log_name] = [fis_name, columns[fis_name]['type']]
    return filds

'''
    Суррогатный ключ
    Момент создания объекта
    Момент (опциональный)
    Срок действия объекта
      
    Создавший пользователь
    Обновивший пользователь
'''
object_filds = [
    'Суррогатный ключ',
    'Момент создания объекта',
    'Момент (опциональный)',
    'Срок действия объекта',
    'Дата создания',
    'Дата обновления',
    'Дата закрытия',
    'Суррогат',
                ]
audit_filds = [
'Создавший пользователь',
'Обновивший пользователь',
]

def pd_parse():
    refs = get_refs()
    fis_names = fill_fis_names()

    with codecs.open("logic_model/logic_model_eim.yaml", "r", "utf-8") as file:
        yaml_logic_data = safe_load(file)

    entities = yaml_logic_data["Aliases"]["Entities"]
    attributes = yaml_logic_data["Aliases"]["Attributes"]

    df_orders = pd.read_excel('/home/larce/share/ЕИМ/export phys3.xlsx')

    excel_dict = df_orders.to_dict('split')

    tables = {}

    for line in excel_dict['data']:
        table = line[0]
        column = line[1]
        c_type = line[2]

        if table in tables:
            table_fis = entities[table]
            if table_fis in refs:
                try:
                    column_fis = attributes[column]
                    ref_fis = refs[entities[table]]
                    if column_fis in ref_fis:
                        fis_ref_table_name = refs[entities[table]][attributes[column]][0]
                        fis_ref_column_name = refs[entities[table]][attributes[column]][1]
                        log_ref_table_name = list(entities.keys())[list(entities.values()).index(fis_ref_table_name)]
                        log_ref_column_name = list(attributes.keys())[list(attributes.values()).index(fis_ref_column_name)]

                        tables[table]['refs'] |= {column: f'{log_ref_table_name}.{log_ref_column_name}'}

                    else:
                        tables[table]['columns'] |= {column: c_type}
                except:
                    tables[table]['columns'] |= {column: c_type}
            else:
                tables[table]['columns'] |= {column: c_type}
        else:
            tables[table] = {'refs': {}, 'columns': {column: c_type}}

    for table in tables:

        for fild in object_filds:
            for exclude_fild in list(tables[table]['columns']):
                if fild == exclude_fild:
                    tables[table] |= {'base': 'Объект'}
                    del tables[table]['columns'][exclude_fild]

        for fild in audit_filds:
            for exclude_fild in list(tables[table]['columns']):
                if fild == exclude_fild:
                    tables[table] |= {'base': 'Аудируемый объект'}
                    del tables[table]['columns'][exclude_fild]

        for fild in object_filds:
            for exclude_fild in list(tables[table]['refs']):
                if fild == exclude_fild:
                    tables[table] |= {'base': 'Объект'}
                    del tables[table]['refs'][exclude_fild]

        for fild in audit_filds:
            for exclude_fild in list(tables[table]['refs']):
                if fild == exclude_fild:
                    tables[table] |= {'base': 'Аудируемый объект'}
                    del tables[table]['refs'][exclude_fild]

    return tables


def fill_fis_names():
    with open("logic_model/logic_model_all.yaml") as file:
        yaml_db_data = safe_load(file)

    with open("logic_model/logic_model_eim.yaml") as file:
        yaml_logic_data = safe_load(file)

    filds = {}
    entities = yaml_logic_data["Aliases"]["Entities"]
    attributes = yaml_logic_data["Aliases"]["Attributes"]


    for table in yaml_db_data['schema eim']:
        if 'table' in table:
            table_fis_name = table.split(' ')[1]
            table_fis_columns = yaml_db_data['schema eim'][table]['columns']
            table_log_name = parse_entities(table_fis_name, entities)
            for log_name in attributes:
                for fis_name_list in table_fis_columns:
                    for fis_name in fis_name_list:
                        if attributes[log_name] == fis_name:
                            if table_log_name in filds:
                                filds[table_log_name] |= {log_name: fis_name}
                            else:
                                filds[table_log_name] = {log_name: fis_name}

    return filds



with codecs.open("logic_model/logic_model_eim_from_fis.yaml", "w", "utf-8") as file:
    print(dump(pd_parse(), allow_unicode=True))
    file.write(dump(pd_parse(), allow_unicode=True))
