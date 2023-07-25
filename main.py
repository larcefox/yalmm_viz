from yaml import safe_load
from pprint import pprint
import graphviz
from collections import OrderedDict


with open('logic_model/logic_model.yaml') as file:
    yaml_data = safe_load(file)

dot = graphviz.Digraph(name='logic_model', node_attr={'fontname':'Helvetica,Arial,sans-serif'}, format='png')
dot.graph_attr['rankdir'] = 'LR'
dot.graph_attr['ratio'] = 'auto'

entities = {}
for entity in yaml_data['Aliases']['Entities']:
    entities[entity] = yaml_data['Aliases']['Entities'][entity]

attributes = {}
for attribute in yaml_data['Aliases']['Attributes']:
    entities[attribute] = yaml_data['Aliases']['Attributes'][attribute]

areas = yaml_data['Tables']

table_name_style = 'bgcolor="green"'

def fill_nodes():

    tables = {}
    for area in areas:
        tables = areas[area]

        with dot.subgraph(name=f'cluster_{list(areas.keys()).index(area)}') as subgraph:
            subgraph.attr(color='blue')
            subgraph.attr(label=area)
            subgraph.node_attr['style'] = 'filled'
            subgraph.node_attr['shape'] = 'plaintext'

            for table_log_name in tables:

                columns = OrderedDict()
                columns = {table_log_name: table_log_name}

                try:
                    if tables[table_log_name]['columns']:
                        columns |= tables[table_log_name]['columns']
                    else:
                        raise KeyError
                except KeyError:
                    columns |= {table_log_name: table_log_name}

                try:
                    refs = tables[table_log_name]['refs']
                    columns.update(refs)
                except KeyError:
                    pass

                
                labels, edge_maper = fill_labels(columns, table_log_name)

                subgraph.node(table_log_name, f'<<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0">{"".join(labels)}</TABLE>>')

            fill_edges(edge_maper, tables, subgraph)


def fill_labels(columns, table_log_name):
    edge_maper = {table_log_name: {}}
    labels = []
    for column in columns:
        edge_maper[table_log_name] |= {column: list(columns.keys()).index(column)}
        labels.append(
            f'<TR><TD {table_name_style if list(columns.keys()).index(column) == 0 else ""} PORT="{list(columns.keys()).index(column)}">{column}</TD></TR>'
            )
        """array1 [label=< 
            <TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0"> <TR>
                <TD PORT="a1">A(1)</TD>
                <TD PORT="a2">A(2)</TD>
                <TD PORT="ax">A(...)</TD>
                <TD PORT="an">A(n)</TD>
            </TR> </TABLE>>];
        """
        return labels, edge_maper
    

def fill_edges(edge_maper, tables, subgraph):
    for table_log_name in tables:
        try:
            refs = tables[table_log_name]['refs']

            for ref in refs:
                current_table = table_log_name
                current_fild_num = edge_maper[table_log_name][ref]
                foreign_table = refs[ref].split(".")[0]

                if 'Суррогатный ключ' in refs[ref].split(".")[1]: 
                    foreign_fild_num = 0 
                else:
                    foreign_fild_num = refs[ref].split(".")[1]
                
                subgraph.edge(f'{current_table}:{current_fild_num}', f'{foreign_table}:{foreign_fild_num}')

        except KeyError:
            pass



def render_graph():
    dot.render(directory='./viz')
    #pprint(dot.source)

def main():
    fill_nodes()
    render_graph()

if __name__ == "__main__":
    main()
