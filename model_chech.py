from yaml import safe_load
import regex as re


class MODEL_CHECK:
    def __init__(self):
        self.logic_file_name = "logic_model.yaml"
        self.logic_file_dir_name = "logic_model"
        self.yaml_data = self.get_data()
        self.templates = self.get_templates()
        self.edge_maper = {}

    def get_data(self) -> dict:
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

    def parse_columns(self, table_log_name, table_data) -> dict:
        columns = {}

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

    def check(self) -> None:
        yaml_data = self.yaml_data
        areas = self.get_areas(yaml_data)
        columns = {}
        attributes = self.get_attributes()
        entities = self.get_entities()

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


if __name__ == "__main__":
    check = MODEL_CHECK()
    check.check()
