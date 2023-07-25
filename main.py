from yaml import safe_load
import graphviz


class model_draw:
    def __init__(self) -> None:
        self.logic_file_name = 'logic_model.yaml'
        self.logic_file_dir_name = 'logic_model'
        self.yaml_data = self.get_data()
        self.graf_type = graphviz.Digraph
        self.graf_layout = 'dot'
        self.main_graph_name = 'logic_model'
        self.graf = self.make_main_graph()
        self.entities = {}
        self.attributes = {}
        self.edge_maper = {}
        self.table_name_fild_style = 'bgcolor="green"'
        self.classification_table = 'Классификация'
        self.use_classification_table = False
        self.classification_ref_fild_style = 'bgcolor="lightblue"'
        self.simpl_edge_mode = False

    def get_data(self) -> None:
        with open(f'{self.logic_file_dir_name}/{self.logic_file_name}') as file:
            return safe_load(file)

    def get_entities(self) -> None:
        for entity in self.yaml_data['Aliases']['Entities']:
            self.entities[entity] = self.yaml_data['Aliases']['Entities'][entity]

    def get_attributes(self) -> None:
        for attribute in self.yaml_data['Aliases']['Attributes']:
            self.entities[attribute] = self.yaml_data['Aliases']['Attributes'][attribute]

    def get_areas(self, yaml_data) -> dict:
        return yaml_data['Tables']

    def make_main_graph(self) -> None:
        return self.graf_type(
            name=f'{self.main_graph_name}', 
            node_attr={'fontname':'Helvetica'}, 
            format='png',
            graph_attr={'rankdir':'LR', 'ratio':'auto', 'layout':f'{self.graf_layout}'},
            )

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

    def fill_labels(self, columns,refs, table_log_name) -> list:
        labels = []
        for column in columns:
            if self.use_classification_table and list(columns.keys()).index(column) == 0 and table_log_name == self.classification_table:
                labels.append(
                    f'<TR><TD {self.classification_ref_fild_style} PORT="{list(columns.keys()).index(column)}">{column}</TD></TR>'
                    )
            elif list(columns.keys()).index(column) == 0:
                labels.append(
                    f'<TR><TD {self.table_name_fild_style} PORT="{list(columns.keys()).index(column)}">{column}</TD></TR>'
                    )
            elif self.use_classification_table and refs and column in refs and self.classification_table in refs[column]:
                labels.append(
                    f'<TR><TD {self.classification_ref_fild_style} PORT="{list(columns.keys()).index(column)}">{column}</TD></TR>'
                    )
            else:
                labels.append(
                    f'<TR><TD PORT="{list(columns.keys()).index(column)}">{column}</TD></TR>'
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

    def get_refs(self, table_data):
            try:
                return table_data['refs']
            except KeyError:
                return None
        
    def fill_edges_simpl(self, tables, subgraph) -> None:
        connections = set()
        for table in tables:
            try:
                refs = tables[table]['refs']
                for ref in refs:
                    connections.add(refs[ref].split(".")[0])
                for connection in connections:
                    # subgraph.edge(f'{table}:0', f'{connection}:0')
                    subgraph.edge(f'{table}', f'{connection}')
            except KeyError:
                pass


    def fill_edges(self, tables, subgraph, edge_maper) -> None:
        for table in tables:
            try:
                refs = tables[table]['refs']

                for ref in refs:
                    current_table = table 
                    current_fild_num = edge_maper[table][ref]
                    foreign_table = refs[ref].split(".")[0]

                    if self.use_classification_table and foreign_table == self.classification_table:
                        continue
                    elif 'Суррогатный ключ' in refs[ref].split(".")[1]: 
                        foreign_fild_num = 0 
                    else:
                        foreign_fild_num = refs[ref].split(".")[1]
                    
                    subgraph.edge(f'{current_table}:{current_fild_num}', f'{foreign_table}:{foreign_fild_num}')

            except KeyError:
                pass
    
    def render_graph(self) -> None:
        self.graf.render(directory='./viz')    

    def draw(self) -> None:
        yaml_data = self.yaml_data
        areas = self.get_areas(yaml_data)
        for area in areas:
            subgraph = self.make_subgraph(areas, area)
            tables = areas[area]

            for table in tables:
                columns = self.parse_columns(table, tables[table])
                edge_maper = self.make_edge_maper(table, columns)
                refs = self.get_refs(tables[table])
                labels = self.fill_labels(columns, refs, table)
                self.fill_nodes(table, labels, subgraph)
            
            if self.simpl_edge_mode:
                self.fill_edges_simpl(tables, subgraph) 
            else: 
                self.fill_edges(tables, subgraph, edge_maper)

            self.graf.subgraph(subgraph)
        self.render_graph()

if __name__ == "__main__":
    draw = model_draw()
    draw.draw()
