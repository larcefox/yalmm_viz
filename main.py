from yaml import safe_load
import graphviz
import argparse
import regex as re


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
    "-l",
    "--graf_layout",
    help="graphviz layout name",
    default="dot"
)
arg_parser.add_argument(
    "-o",
    "--file_format",
    help="output file format",
    default="png"
)
arg_parser.add_argument(
    "-t",
    "--show_fild_type",
    action="store_true",
    help="shows filds types",
)
arg_parser.add_argument(
    "-area",
    "--draw_area",
    help="draw specified area",
)

args = arg_parser.parse_args()


class MODEL_DRAW:
    def __init__(
        self, 
        simpl_edge_mode, 
        use_classification_table, 
        show_fiz_name, 
        graf_layout,
        file_format,
        show_fild_type,
        draw_area,
    ) -> None:
        self.logic_file_name = "logic_model_pg.yaml"
        self.logic_file_dir_name = "logic_model"
        self.yaml_data = self.get_data()
        self.graf_type = graphviz.Digraph
        self.graf_layout = graf_layout
        self.main_graph_name = "logic_model"
        self.file_format = file_format
        self.line_type = "true"
        self.graf = self.make_main_graph()
        self.entities = self.get_entities()
        self.attributes = self.get_attributes()
        self.domains = self.get_domains()
        self.templates = self.get_templates()
        self.edge_maper = {}
        self.table_name_fild_style = 'bgcolor="green"'
        self.classification_ref_fild_style = 'bgcolor="lightblue" align="left"'
        self.fild_style = 'align="left"'
        self.classification_table = "Классификация"
        self.simpl_edge_mode = simpl_edge_mode
        self.use_classification_table = use_classification_table
        self.show_fiz_name = show_fiz_name
        self.show_fild_type = show_fild_type
        self.draw_area = draw_area
        self.areas = self.get_areas(self.yaml_data)
        self.attributes = self.get_attributes()
        self.entities = self.get_entities()


    def get_data(self) -> None:
        try:
            with open(f"{self.logic_file_dir_name}/{self.logic_file_name}") as file:
                return safe_load(file)
        except FileNotFoundError:
            print('File not found.')
            exit()

    def get_entities(self) -> dict:
        return self.yaml_data["Aliases"]["Entities"]
    
    def get_templates(self) -> dict:
        return self.yaml_data["Templates"]

    def get_attributes(self) -> dict:
        return self.yaml_data["Aliases"]["Attributes"]
    
    def get_domains(self) -> dict:
        return self.yaml_data["Domains"]

    def get_areas(self, yaml_data) -> dict:
        return yaml_data["Tables"]

    def make_main_graph(self) -> graphviz.Digraph:
        return self.graf_type(
            name=f"{self.main_graph_name}",
            node_attr={"fontname": "Helvetica"},
            format=self.file_format,
            graph_attr={
                "rankdir": "LR",
                "ratio": "auto",
                "layout": f"{self.graf_layout}",
                "fontsize": "25pt",
                "splines": self.line_type,
                # "nodesep": "1",
                # "ranksep": "1",
                # "margine": "1"
            },
        )

    def make_subgraph(self, areas, area) -> graphviz.Graph:
        with self.graf.subgraph(
            name=f"cluster_{list(areas.keys()).index(area)}"
        ) as subgraph:
            subgraph.attr(margin="1.5,1.5")
            subgraph.attr(color="blue")
            subgraph.attr(label=f'< <B>{area}</B>>')
            subgraph.node_attr["fontname"] = "Helvetica"
            subgraph.node_attr["fontsize"] = "15pt"
            subgraph.node_attr["style"] = "filled"
            subgraph.node_attr["shape"] = "plaintext"
            return subgraph

    def parse_columns(self, table_log_name, table_data) -> dict:
        columns = {f'{table_log_name}': table_log_name}

        try:
            columns |= table_data["columns"]
        except (KeyError, TypeError):
            pass

        try:
            refs = table_data["refs"]
            columns.update(refs)
        except (KeyError, TypeError):
            pass

        columns.update(self.parse_template(table_data, columns))

        columns = self.clear_nulls(columns)

        return {table_log_name: columns}

    @staticmethod
    def clear_nulls(columns) -> dict:
        for k, v in columns.items():
            if '[' in columns[k]:
                columns[k] = re.sub(r' \[[a-z]* *[0-9]*\]', '', columns[k])
        return columns

    def parse_template(self, table_data, columns):
        while 'base' in table_data:
            base_table = table_data['base']
            table_data = self.templates[base_table]
            try:
                columns.update(table_data["columns"])
            except (KeyError, TypeError):
                pass

            try:
                refs = table_data["refs"]
                columns.update(refs)
            except (KeyError, TypeError):
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
            try:
                fild_type = columns[column].split('.')[1] if port != 0 else "Table"
            except IndexError:
                fild_type = columns[column] if port != 0 else "Table"

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
                        f'{column}</TD><TD {style} PORT="{port}">{self.entities[column]}'
                        if column in self.entities
                        else f'{column}</TD><TD {style} PORT="{port}">{column}'
                        )
                    case (False, True):
                        name = f'{column}</TD><TD {style} PORT="{port}"> Type'
                    case (True, True):
                        name = (
                        f'{column}</TD><TD {style}>{self.entities[column]}</TD><TD {style} PORT="{port}"> Type'
                        if column in self.entities
                        else f'{column}</TD><TD {style}>{column}</TD><TD {style} PORT="{port}"> Type'
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
                        name = (
                        f'{column}</TD><TD {style} PORT="{port}">{self.domains[fild_type]["type"]}'
                        if fild_type in self.domains
                        else f'{column}</TD><TD {style} PORT="{port}">{column}'
                    )
                    case (True, True):
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
                table_data = tables[table]
                refs = table_data["refs"]
  
                #fill refs from templates
                while 'base' in table_data:
                    base_table = table_data['base']
                    table_data = self.templates[base_table]
                    try:
                        refs.update(table_data["refs"])
                    except (KeyError, TypeError):
                        pass

                for ref in refs:
                    connections.add(refs[ref].split(".")[0])
                for connection in connections:
                    if self.use_classification_table and connection == self.classification_table:
                        pass
                    else:
                        subgraph.edge(f"{table}", f"{connection}", style="dashed")
            except KeyError:
                pass

    def fill_edges(self, tables, subgraph, edge_maper) -> None:
        for table in tables:
            table_data = tables[table]
            if 'refs' in table_data:
                refs = table_data["refs"]

                #fill refs from templates
                while 'base' in table_data:
                    base_table = table_data['base']
                    table_data = self.templates[base_table]
                    try:
                        refs.update(table_data["refs"])
                    except (KeyError, TypeError):
                        pass

                refs = self.clear_nulls(refs)
                for ref in refs:
                    current_table = table
                    current_fild_num = edge_maper[table][ref]
                    foreign_table = refs[ref].split(".")[0]
                    foreign_fild = refs[ref].split(".")[1]
                    foreign_fild_num = edge_maper[foreign_table][foreign_fild]

                    if (
                        self.use_classification_table
                        and foreign_table == self.classification_table
                    ):
                        continue

                    subgraph.edge(
                        f"{current_table}:{current_fild_num}",
                        f"{foreign_table}:{foreign_fild_num}",
                        style="dashed"
                    )

    def render_graph(self) -> None:
        self.graf.render(directory="./viz")

    def model_check(self):
        columns = {}
        areas = self.areas
        entities = self.entities
        attributes = self.attributes

        for area in areas:
            tables = areas[area]
            for table in tables:
                print(f'Area {area}, table: {table}')
                columns |= self.parse_columns(table, tables[table])
                print(f'Missed table: {table}') if table not in entities else 1

                print('Missed columns: ')
                for column in columns[table]:
                    print(f'{column}') if column not in attributes else 1
                print('')

    def draw(self) -> None:
        areas = self.areas
        columns = {}

        for area in areas:
            tables = areas[area]
            for table in tables:
                columns |= self.parse_columns(table, tables[table])
                edge_maper = self.make_edge_maper(table, columns[table])

        for area in areas:
            subgraph = self.make_subgraph(areas, area)
            tables = areas[area]

            for table in tables:
                refs = self.get_refs(tables[table])
                labels = self.fill_labels(columns[table], refs, table)
                self.fill_nodes(table, labels, subgraph)

            if self.simpl_edge_mode:
                self.fill_edges_simpl(tables, subgraph)
            else:
                self.fill_edges(tables, subgraph, edge_maper)

            if (self.draw_area):
                if area == self.draw_area:
                    self.graf.subgraph(subgraph)
            else:
                self.graf.subgraph(subgraph)
        self.render_graph()


if __name__ == "__main__":
    draw = MODEL_DRAW(**args.__dict__)
    draw.draw()
