from yaml import safe_load
from pprint import pprint
import graphviz


with open('logic_model.yaml') as file:
    yaml_data = safe_load(file)

entities = {}
for entity in yaml_data['Aliases']['Entities']:
    entities[entity] = yaml_data['Aliases']['Entities'][entity]

areas = {}
for area in yaml_data['Tables']:
    areas[area] = yaml_data['Tables'][area]

tables = {}
for table in areas:
    tables[table] = areas[table]

dot = graphviz.Digraph(name='g', node_attr={'shape': 'record'})
dot.graph_attr['rankdir'] = 'LR'

def fill_tables():
    for table_fiz_name in tables:

        table_log_name = list(tables[table_fiz_name].keys())[0]
        
        try:
            columns = tables[table_fiz_name][table_log_name]['columns']
        except KeyError:
            columns = {table_log_name: table_log_name}

        try:
            refs = tables[table_fiz_name][table_log_name]['refs']
            columns.update(refs)
        except KeyError:
            pass

        dot.node(table_log_name, f"{table_log_name} | {' | '.join(columns.keys())}")

def fill_filds():
    for table_fiz_name in tables:

        table_log_name = list(tables[table_fiz_name].keys())[0]

        try:
            refs = tables[table_fiz_name][table_log_name]['refs']
            foreign_log_names = set([foreign_log_key.split(".")[0] for foreign_log_key in refs.values()])
            while foreign_log_names:
                foreign_log_name = foreign_log_names.pop()
                dot.edge(table_log_name, foreign_log_name)

        except KeyError:
            pass


def render_graph():
    dot.render(directory='.')
    pprint(dot.source)

def main():
    fill_tables()
    fill_filds()
    render_graph()

if __name__ == "__main__":
    main()