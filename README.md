## Buen día, profe

Este es el repo de mi proyecto y aquí le paso algunas de las indicaciones que pueden ser necesarias para ejecutarlo correctamente:

1. La tabla inicial con el archivo CSV sin tratar ni transformar, la nombré `StagingNutricion` en el esquema `dbo`.
2. Los archivos de código de Python están nombrados en orden desde la `pt0` hasta la `pt3`, cada uno con sus respectivos loggings para mandar los mensajes correspondientes.
3. No es necesario correr ningún query en SQL Server.
4. En la `pt3` es necesario que cambie el nombre del server, ya que con `pyodbc` no me permitió usar `localhost`, entonces le pediría que para ese cambie al nombre de su servidor local.
5. En esa misma `pt3` el ODBC driver no me funcionó, entonces utilicé `SQL SERVER` como driver. Yo no necesité configurar nada en mi SQL para realizar dicha conexión, espero usted tampoco.

### Para ejecutar archivos

1. Como le mencioné anteriormente, están nombrados en orden del `0` al `3`. En ese orden se ejecutan los archivos y la `pt2` debe ser ejecutada dos veces para asegurar que las tablas dimensionales se dropeen y se creen vacías.
2. La `pt3` es la más tardada en ejecutarse ya que son más de 93,000 registros a cargar en la tabla fact, entonces solo esperar a que se ejecute.

Muchas gracias por el curso y sus enseñanzas. Cuídese profe y que Dios la bendiga.
