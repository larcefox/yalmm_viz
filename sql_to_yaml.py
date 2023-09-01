from yaml import safe_load
from pprint import pprint
import pandas as pd


with open("logic_model/logic_model_all.yaml") as file:
    yaml_db_data = safe_load(file)

with open("logic_model/logic_model_eim.yaml") as file:
    yaml_logic_data = safe_load(file)

def get_refs():
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




def fill_yaml():
    filds = {}
    refs = get_refs()
    entities = yaml_logic_data["Aliases"]["Entities"]
    attributes = yaml_logic_data["Aliases"]["Attributes"]


    for table in yaml_db_data['schema eim']:
        if 'table' in table:
            table_fis_name = table.split(' ')[1]
            table_fis_columns = yaml_db_data['schema eim'][table]['columns']
            table_log_name = parse_entities(table_fis_name, entities)

            filds |= parse_columns(table_log_name, table_fis_columns, attributes)

    pprint(filds)




def parse_entities(table_fis_name, entities):
    for table_log_name in entities:
        if table_fis_name == entities[table_log_name]:
            return table_log_name


def parse_columns(table_log_name, table_fis_columns):
    filds = {}
    for columns in table_fis_columns:
        for fis_name in columns:

            if fis_name in filds:
                filds[table_log_name] |= [fis_name, columns[fis_name]['type']]
            else:
                filds[table_log_name] = [fis_name, columns[fis_name]['type']]
    return filds


fill_yaml()

def test():
    entities = yaml_logic_data["Aliases"]["Entities"]
    attributes = yaml_logic_data["Aliases"]["Attributes"]
    tables = {}
    refs = get_refs()

    for table in yaml_db_data['schema eim']:
        if 'table' in table:
            for entity in entities:

                table_yaml_data = entities[entity]
                table_db_data = table.split(' ')[1]

                try:
                    columns_lst = yaml_db_data['schema eim'][table]['columns']
                except KeyError:
                    continue

                for columns in columns_lst:
                    for column in columns:
                        for attribute in attributes:
                            if column == attributes[attribute]:
                                if entity in tables:
                                    if table_db_data in refs:
                                        if column in refs[table_db_data]:
                                            tables[entity]['refs'] |= {attribute: f'{refs[table_db_data][column][0]}.{"Суррогатный ключ" if refs[table_db_data][column][1] == "id" else refs[table_db_data][column][1]}'}
                                        break
                                    else:
                                        tables[entity]['columns'] |= {attribute: columns[column]['type']}
                                        break
                                else:
                                    if column == 'id':
                                        continue
                                    else:
                                        tables[entity] = {'base':  'Объект', 'columns': {attribute: columns[column]['type']}, 'refs': dict()}
                                    break

    pprint(tables)
