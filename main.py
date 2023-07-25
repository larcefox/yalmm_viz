from yaml import safe_load
from pprint import pprint
import graphviz


table_name_style = 'bgcolor="green"'

class model_draw:
    def __init__(self) -> None:
        self.yaml_data = self.get_data()
        self.graf = graphviz.Digraph(
            name='logic_model', 
            node_attr={'fontname':'Helvetica,Arial,sans-serif'}, 
            format='png',
            graph_attr={'rankdir':'LR', 'ratio':'auto'}
            )
        self.entities = {}
        self.attributes = {}
        self.edge_maper = {}

    def get_data(self) -> None:
        with open('logic_model/logic_model.yaml') as file:
            return safe_load(file)

    def get_entities(self) -> None:
        for entity in self.yaml_data['Aliases']['Entities']:
            self.entities[entity] = self.yaml_data['Aliases']['Entities'][entity]

    def get_attributes(self) -> None:
        for attribute in self.yaml_data['Aliases']['Attributes']:
            self.entities[attribute] = self.yaml_data['Aliases']['Attributes'][attribute]

    def get_areas(self, yaml_data) -> dict:
        return yaml_data['Tables']

    def make_subgraph(self, areas, area) -> graphviz.Graph:
        with self.graf.subgraph(name=f'cluster_{list(areas.keys()).index(area)}') as subgraph:
            subgraph.attr(color='blue')
            subgraph.attr(label=area)
            subgraph.node_attr['style'] = 'filled'
            subgraph.node_attr['shape'] = 'plaintext'
            return subgraph
    
    def parse_columns(self, table_log_name, table_data) -> dict:

        columns = {table_log_name: table_log_name}

        try:
            if table_data['columns']:
                columns |= table_data['columns']
            else:
                raise KeyError
        except KeyError:
            pass

        try:
            refs = table_data['refs']
            columns.update(refs)
        except KeyError:
            pass

        return columns
    
    def make_edge_maper(self, table, columns) -> dict:
        self.edge_maper |= {table: {}}
        for column in columns:
            self.edge_maper[table] |= {column: list(columns.keys()).index(column)}
        return self.edge_maper

    def fill_labels(self, columns) -> str:
        labels = []
        for column in columns:
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
        return labels

    def fill_nodes(self, table_log_name, labels, subgraph) -> None:
            subgraph.node(table_log_name, f'<<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0">{"".join(labels)}</TABLE>>')

    def fill_edges(self, tables, subgraph, edge_maper) -> None:
        for table in tables:
            try:
                refs = tables[table]['refs']

                for ref in refs:
                    current_table = table 
                    current_fild_num = edge_maper[table][ref]
                    foreign_table = refs[ref].split(".")[0]

                    if 'Суррогатный ключ' in refs[ref].split(".")[1]: 
                        foreign_fild_num = 0 
                    else:
                        foreign_fild_num = refs[ref].split(".")[1]
                    
                    subgraph.edge(f'{current_table}:{current_fild_num}', f'{foreign_table}:{foreign_fild_num}')

            except KeyError:
                pass
    
    def render_graph(self) -> None:
        self.graf.render(directory='./viz')
        #pprint(self.graf.source)       

    def draw(self) -> None:
        yaml_data = self.yaml_data
        areas = self.get_areas(yaml_data)
        for area in areas:
            subgraph = self.make_subgraph(areas, area)
            tables = areas[area]

            for table in tables:
                columns = self.parse_columns(table, tables[table])
                edge_maper = self.make_edge_maper(table, columns)
                labels = self.fill_labels(columns)
                self.fill_nodes(table, labels, subgraph)
            self.fill_edges(tables, subgraph, edge_maper)
            self.graf.subgraph(subgraph)
        self.render_graph()

if __name__ == "__main__":
    draw = model_draw()
    draw.draw()
