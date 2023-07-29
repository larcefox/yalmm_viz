# Yalmm logic data model visualisation
## Install
pip install -r requirements.txt

## Use
Generated files saves in vis folder. Source yaml files need to place in 'logic_model' folder.
- Without parametrs shows all connections, saves in png format.
- -s groups all connections between tables
- -c exclude all connections to one table, connections shows connected filds in blue color. By default 'Классификация'
- -f sows extra column with fisical names of filds
- -f sows extra column with data types of filds
- -l changes graphwith format. By default 'dot'
- -ft changes file format