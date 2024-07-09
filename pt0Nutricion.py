import logging
import pyodbc

# Configurar logging
logging.basicConfig(filename='pt0Nutricion.log', level=logging.INFO,
                    format='%(asctime)s:%(levelname)s:%(message)s')

# Configuración de conexión a SQL Server usando autenticación de Windows
server = 'localhost'
driver = 'ODBC Driver 17 for SQL Server'
database = 'master'

# Conexión a SQL Server para la base de datos master
connection_string = f'DRIVER={driver};SERVER={server};DATABASE={database};Trusted_Connection=yes;'

try:
    # Conexión a SQL Server para crear la base de datos y las tablas
    with pyodbc.connect(connection_string, autocommit=True) as conn:
        cursor = conn.cursor()
        # Leer el script SQL desde el archivo con codificación adecuada debido al dato nvarchar
        with open('QueryTranformedNutricionsql.sql', 'r', encoding='utf-8-sig') as file:
            sql_script = file.read()
        
        # Dividir el script en declaraciones separadas por 'GO' para evitar conflictos
        statements = sql_script.split('GO')

        # Ejecutar cada instrucción en el script SQL
        for statement in statements:
            statement = statement.strip()
            if statement:
                cursor.execute(statement)
        logging.info('Drop y creacion de la tabla vacia para datos transformados exitosa.')

except Exception as e:
    logging.error(f'La tablas para datos transformados no pudo crearse: {e}')
    raise