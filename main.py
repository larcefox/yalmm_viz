from yaml import safe_load
import graphviz
import argparse


arg_parser = argparse.ArgumentParser(
    description="Yaml logic data models visualisation."
)
arg_parser.add_argument(
    "-s",
    "--simpl_edge_mode",
    action="store_true",
    help="genirates simple relation model",
)
arg_parser.add_argument(
    "-c",
    "--use_classification_table",
    action="store_true",
    help="genirates less relation for classigication table",
)
arg_parser.add_argument(
    "-f",
    "--show_fiz_name",
    action="store_true",
    help="shows fisical filds and table names",
)
arg_parser.add_argument(
    "-l", "--graf_layout", help="graphviz layout name", default="dot"
)
arg_parser.add_argument(
    "-ft", "--file_format", help="output file format", default="png"
)
arg_parser.add_argument(
    "-t",
    "--show_fild_type",
    action="store_true",
    help="shows filds types",
)
args = arg_parser.parse_args()


class Model_Draw:
    def __init__(
        self, 
        simpl_edge_mode, 
        use_classification_table, 
        show_fiz_name, 
        graf_layout,
        file_format,
        show_fild_type
    ) -> None:
        self.logic_file_name = "logic_model_pg.yaml"
        self.logic_file_dir_name = "logic_model"
        self.yaml_data = self.get_data()
        self.graf_type = graphviz.Digraph
        self.graf_layout = graf_layout
        self.main_graph_name = "logic_model"
        self.file_format = file_format
        self.graf = self.make_main_graph()
        self.entities = self.get_entities()
        self.attributes = self.get_attributes()
        self.domains = self.get_domains()
        self.edge_maper = {}
        self.table_name_fild_style = 'bgcolor="green"'
        self.classification_ref_fild_style = 'bgcolor="lightblue" align="left"'
        self.fild_style = 'align="left"'
        self.classification_table = "Классификация"
        self.simpl_edge_mode = simpl_edge_mode
        self.use_classification_table = use_classification_table
        self.show_fiz_name = show_fiz_name
        self.show_fild_type = show_fild_type

    def get_data(self) -> None:
        try:
            with open(f"{self.logic_file_dir_name}/{self.logic_file_name}") as file:
                return safe_load(file)
        except FileNotFoundError:
            print('File not found.')
            exit()

    def get_entities(self) -> None:
        return self.yaml_data["Aliases"]["Entities"]

    def get_attributes(self) -> None:
        return self.yaml_data["Aliases"]["Attributes"]
    
    def get_domains(self) -> None:
        return self.yaml_data["Domains"]

    def get_areas(self, yaml_data) -> dict:
        return yaml_data["Tables"]

    def make_main_graph(self) -> None:
        return self.graf_type(
            name=f"{self.main_graph_name}",
            node_attr={"fontname": "Helvetica"},
            format=self.file_format,
            graph_attr={
                "rankdir": "LR",
                "ratio": "auto",
                "layout": f"{self.graf_layout}",
            },
        )

    def make_subgraph(self, areas, area) -> graphviz.Graph:
        with self.graf.subgraph(
            name=f"cluster_{list(areas.keys()).index(area)}"
        ) as subgraph:
            subgraph.attr(color="blue")
            subgraph.attr(label=area)
            subgraph.node_attr["style"] = "filled"
            subgraph.node_attr["shape"] = "plaintext"
            return subgraph

    def parse_columns(self, table_log_name, table_data) -> dict:
        columns = {f'T:{table_log_name}': table_log_name}

        try:
            if table_data["columns"]:
                columns |= table_data["columns"]
            else:
                raise KeyError
        except KeyError:
            pass

        try:
            refs = table_data["refs"]
            columns.update(refs)
        except KeyError:
            pass

        return columns

    def make_edge_maper(self, table, columns) -> dict:
        self.edge_maper |= {table: {}}
        for column in columns:
            self.edge_maper[table] |= {column: list(columns.keys()).index(column)}
        return self.edge_maper
    
    def fill_labels(self, columns, refs, table_log_name) -> list:
        labels = []

        for column in columns:
            # options
            port = list(columns.keys()).index(column)
            is_table_name = True if port == 0 else False
            is_classification_table = True if table_log_name == self.classification_table else False
            try:
                is_classification_ref = True if self.classification_table in refs[column] else False
            except (KeyError, TypeError):
                is_classification_ref = False
            fild_type = columns[column] if port != 0 else "Table"
            table_name = column.split(":")[1] if is_table_name else None

            if is_table_name:
                # tables blok
                match (self.use_classification_table, is_classification_table):
                    case (True, True):
                        style = self.classification_ref_fild_style
                    case _:
                        style = self.table_name_fild_style

                match (self.show_fiz_name, self.show_fild_type):
                    case (True, False):
                        name = (
                        f'{column}</TD><TD {style} PORT="{port}">{self.entities[table_name]}'
                        if table_name in self.entities
                        else f'{column}</TD><TD {style} PORT="{port}">{table_name}'
                        )
                    case (False, True):
                        name = f'{column}</TD><TD {style} PORT="{port}"> Type'
                    case (True, True):
                        name = (
                        f'{column}</TD><TD {style}>{self.entities[table_name]}</TD><TD {style} PORT="{port}"> Type'
                        if table_name in self.entities
                        else f'{column}</TD><TD {style}>{table_name}</TD><TD {style} PORT="{port}"> Type'
                        )
                    case _:
                        name = column

            else:
                # filds blok
                match (self.use_classification_table, is_classification_ref):
                    case (True, True):
                        style = self.classification_ref_fild_style
                    case _:
                        style = self.fild_style

                match (self.show_fiz_name, self.show_fild_type):
                    case (True, False):
                        name = (
                        f'{column}</TD><TD {style} PORT="{port}">{self.attributes[column]}'
                        if column in self.attributes
                        else f'{column}</TD><TD {style} PORT="{port}">{column}'
                    )
                    case (False, True):
                        fild_type = 'Суррогатный ключ' if 'Суррогатный ключ' in fild_type else fild_type
                        name = (
                        f'{column}</TD><TD {style} PORT="{port}">{self.domains[fild_type]["type"]}'
                        if fild_type in self.domains
                        else f'{column}</TD><TD {style} PORT="{port}">{column}'
                    )
                    case (True, True):
                        fild_type = 'Суррогатный ключ' if 'Суррогатный ключ' in fild_type else fild_type
                        name = (
                        f'{column}</TD><TD {style}>{self.attributes[column]}</TD><TD {style} PORT="{port}">{self.domains[fild_type]["type"]}'
                        if column in self.attributes
                        else f'{column}</TD><TD {style}>{column}</TD><TD {style} PORT="{port}">{self.domains[fild_type]["type"]}'
                    )
                    case _:
                        name = column

            if self.show_fiz_name or self.show_fild_type:
                labels.append(f'<TR><TD {style}>{name}</TD></TR>')
            else:
                labels.append(f'<TR><TD {style} PORT="{port}">{name}</TD></TR>')

            

        return labels

    def fill_nodes(self, table_log_name, labels, subgraph) -> None:
        subgraph.node(
            table_log_name,
            f'<<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0">{"".join(labels)}</TABLE>>',
        )

    def get_refs(self, table_data) -> dict | None:
        try:
            return table_data["refs"]
        except KeyError:
            return None

    def fill_edges_simpl(self, tables, subgraph) -> None:
        for table in tables:
            connections = set()
            try:
                refs = tables[table]["refs"]
                for ref in refs:
                    connections.add(refs[ref].split(".")[0])
                for connection in connections:
                    #subgraph.edge(f'{table}:0', f'{connection}:0')
                    if self.simpl_edge_mode and connection == self.classification_table:
                        pass
                    else:
                        subgraph.edge(f"{table}", f"{connection}")
            except KeyError:
                pass

    def fill_edges(self, tables, subgraph, edge_maper) -> None:
        for table in tables:
            try:
                refs = tables[table]["refs"]

                for ref in refs:
                    current_table = table
                    current_fild_num = edge_maper[table][ref]
                    foreign_table = refs[ref].split(".")[0]

                    if (
                        self.use_classification_table
                        and foreign_table == self.classification_table
                    ):
                        continue
                    elif "Суррогатный ключ" in refs[ref].split(".")[1]:
                        foreign_fild_num = 0
                    else:
                        foreign_fild_num = refs[ref].split(".")[1]

                    subgraph.edge(
                        f"{current_table}:{current_fild_num}",
                        f"{foreign_table}:{foreign_fild_num}",
                    )

            except KeyError:
                pass
            
    def render_graph(self) -> None:
        self.graf.render(directory="./viz")

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
    draw = Model_Draw(**args.__dict__)
    draw.draw()
