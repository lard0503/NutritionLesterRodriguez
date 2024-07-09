import pyodbc
import logging

# Configuración de conexión
server = 'ALEJANDROSPC'
driver = 'SQL SERVER'
database = 'master'

connection_string = f"""
    DRIVER={{{driver}}};
    SERVER={server};
    DATABASE={database};
    Trust_Connection=yes;
"""

# Configuración de logging
logging.basicConfig(filename='pt3Nutricion.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

try:
    
    conn = pyodbc.connect(connection_string, autocommit=True)
    cursor = conn.cursor()
    
    dim_sql_files = ['DimLocation.sql', 'DimClass.sql', 'DimTopic.sql', 'DimQuestion.sql', 'DimStratCat1.sql', 'DimStrat1.sql', 'DimAge.sql', 'DimEducation.sql', 'DimGender.sql', 'DimIncome.sql', 'DimRace.sql', 'FactNutricion.sql']
    
    origen = 'nutricion'
    destino = 'Dimensionalnutricion'
    
    for sql_file in dim_sql_files:
        with open(sql_file, 'r') as file:
            sql_script = file.read()
            
        logging.info(f"Ejecutando script '{sql_file}' en la base de datos '{origen}'.")
        cursor.execute(f"USE {origen}")
        cursor.execute(sql_script)
        logging.info(f"Script '{sql_file}' ejecutado correctamente en '{origen}'.")
        
        data = cursor.fetchall()
        
        logging.info(f"Cambiando a la base de datos '{destino}' para insertar datos en la tabla '{sql_file}'.")
        cursor.execute(f"USE {destino}")
        
        table_name = sql_file.split('.')[0]
        logging.info(f"Insertando datos en la tabla '{table_name}'.")
        
        
        has_identity = table_name in ['DimAge', 'DimEducation', 'DimGender', 'DimIncome', 'DimRace', 'FactNutricion']
        
        if has_identity:
            id = 1
            for row in data:
                row = (id,) + tuple(row)
                insert_query = f"INSERT INTO {table_name} VALUES ({', '.join(['?'] * (len(row)))})"
                cursor.execute(insert_query, row) 
                id += 1
            logging.info(f"Insertadas {len(data)} filas en '{table_name}'")
        else:
            for row in data:
                insert_query = f"INSERT INTO {table_name} VALUES ({', '.join(['?'] * len(row))})"
                cursor.execute(insert_query, row)
            logging.info(f"Insertadas {len(data)} filas en '{table_name}'.")

except Exception as e:
    logging.error(f"Error: {str(e)}")
    print(f"Error: {str(e)}")
    
finally:
    if 'conn' in locals():
        cursor.close()
        conn.close()
        logging.info("Conexión cerrada.")
    else:
        logging.warning("No se pudo establecer la conexión.")

print("Proceso completado.")