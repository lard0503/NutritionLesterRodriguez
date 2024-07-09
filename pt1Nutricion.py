import pandas as pd
from sqlalchemy import create_engine
import logging

logging.basicConfig(filename='pt1Nutricion.log', level=logging.INFO, format='%(asctime)s:%(levelname)s:%(message)s')

server = 'localhost'
database = 'nutricion'
driver = 'ODBC Driver 17 for SQL Server'

connection_string = f'mssql+pyodbc://@{server}/{database}?driver={driver}&trusted_connection=yes'
engine = create_engine(connection_string)

try:
    with open('QuerySelect.sql', 'r') as file:
        query = file.read()

    data = pd.read_sql(query, engine)
    logging.info('Datos extraidos exitosamente desde SQL Server')

except Exception as e:
    logging.error(f'Error al extraer datos desde SQL Server: {e}')
    raise

try:

    # Droppear columnas que no se necesitan
    data.drop(columns=['Data_Value_Unit', 'Data_Value_Type', 'Data_Value_Footnote_Symbol', 'Data_Value_Footnote', 'Total','Datasource'], inplace=True)
    logging.info('Columnas innecesarias eliminadas')

    # Limpieza de datos nulos
    data['Data_Value'] = data['Data_Value'].fillna(0).astype(float)
    data['Data_Value_Alt']= data['Data_Value_Alt'].fillna(0).astype(float)
    data['Low_Confidence_Limit'] = data['Low_Confidence_Limit'].fillna(0).astype(float)
    data['High_Confidence_Limit'] = data['High_Confidence_Limit'].fillna(0).astype(float)
    data['Sample_Size'] = data['Sample_Size'].fillna(0).astype(float)
    data['Age_years'] = data['Age_years'].fillna('NA').astype(str)
    data['Education'] = data['Education'].fillna('NA').astype(str)
    data['Gender'] = data['Gender'].fillna('NA').astype(str)
    data['Income'] = data['Income'].fillna('NA').astype(str)
    data['Race_Ethnicity'] = data['Race_Ethnicity'].fillna('NA').astype(str)
    data['GeoLocation'] = data['GeoLocation'].fillna(0).astype(str)
    data['QuestionID'] = data['QuestionID'].astype(float)
    data['Stratification1']

    # Reemplazo de valores que son less than y older
    data['Age_years'] = data['Age_years'].str.replace(r'65 or older', '>=65')
    data['Education'] = data['Education'].str.replace(r'Less than high school', '<Highschool')
    data['Income'] = data['Income'].str.replace(r'Less than $15,000', '<$15,000')
    data['Stratification1'] = data['Stratification1'].str.replace(r'Less than high school', '<Highschool')
    data['Stratification1'] = data['Stratification1'].str.replace(r'Less than $15,000', '<$15,000')
    
    data[['Latitude', 'Longitude']] = data['GeoLocation'].str.extract(r'\(([^,]+), ([^,]+)\)')
    data['Latitude'] = data['Latitude'].fillna(0).astype(float)
    data['Longitude'] = data['Longitude'].fillna(0).astype(float)


    data.to_sql('Transformed_Nutrition', con=engine, if_exists='append', index=False)

    logging.info('Datos transformados y limpiados exitosamente y cargados en la tabla de SQL Server')

except Exception as e:
    logging.error(f'Error al limpiar datos: {e}')
    raise