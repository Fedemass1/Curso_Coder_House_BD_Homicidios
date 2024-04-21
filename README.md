-------------------------------------------------------------------------------------------------------------
INSTRUCCIONES DE INSTALACIÓN DE LA BASE DE DATOS "HOMICIDIOS"
-------------------------------------------------------------------------------------------------------------

Para instalar la base de datos "Homicidios" de forma exitosa se deben seguir una serie de pasos.
Todos los archivos a instalar se encuentran dentro de la carpeta "Archivos SQL". Los pasos a seguir son:

1) Desde la herramienta de base de datos, en este caso MySQL Workbench, se debe abrir y ejecutar el archivo 
   "01 Script_crear_BD_Homicidios.sql" Este se encargará de crear toda la estructura de las tablas para que luego 
   puedan ser agregados los datos de forma correcta.

2) Importar los archivos .CSV con el contenido de las tablas. Estos se encuentran dentro de la carpeta 
   "02 Archivos CSV para importación de registros en tablas". Para la importación solo hay una restricción en el 
   orden y es que el archivo "Tabla_homicidios" debe ser importado en último lugar. En total de deben realizar
   siete (7) importaciones, ya que esta es la cantidad de tablas del proyecto.

3) Abrir y ejecutar el archivo "02 Script_vistas.sql" para la creación de vistas. Recordar siempre refrescar 
   el panel de navegación con los objetos para visualizar los cambios recientes.

4) Abrir y ejecutar "03 Script_funciones.sql" para la creación de funciones. La forma de utilización de las 
   funciones se encuentra en la documentación del proyecto y en el mismo código SQL.

5) Abrir y ejecutar "04 Script_SP.sql" para la creación de los Store Procedures. La forma de utilización de 
   las funciones se encuentra en la documentación del proyecto y en el mismo código SQL.

6) Abrir y ejecutar "06 Script_Triggers.sql" para la creación de Triggers y tablas de auditoria.

7) Abrir y ejecutar 07 "DCL_Script_users.sql" para la creación de usuarios con sus permisos asociados. Los 
   usuarios que se pueden visualizar al abrir el archivo son a modo de ejemplo. La cantidad de los mismos junto 
   a sus credenciales dependerán de las necesidades de cada empresa u organismo que sea usuario del proyecto.

Hasta este punto ya se contará con una base totalmente funcional y con la mayoría de sus funcionalidades 
implementadas. Sin embargo hay dos puntos extra que se pueden adicionar para una performance óptima en el 
cuidado y mantenimiento de los datos. Si bien no afectan al funcionamiento per se no se ve verá afectado, son 
requisitos fundamentales que cualquier administrador de una base de datos debe tener en cuenta para salvaguardar 
la misma en el tiempo.


8) Abrir "08 TCL.sql". Se podrán ver operaciones de ejemplo. Estás pueden ser adaptadas a las necesidades de cada 
   entre para la operación con datos.

9) Backup datos. Ante cualquier pérdida de información de la base original, se podrá recurrir a la restauración de 
   esta mediante los archivos de backup que se adjuntan. Uno de ellos respalda la estructura de las tablas y el otro 
   la información. Tener presente que si se restauran estos backups, cualquier nueva información que se halla agregado 
   se perderá, proceder con precaución y realizar nuevos backups de forma regular para evitar cualquier pérdida de información.
  
   El backup "Backup_estructura" incluye el esquema homicidios, mientras que el de los datos "Backup_datos" no. Se recomienda
   restaurar este último sobre el esquema homicidios. Tener la precaución de seleccionar a este en el caso de querer restaurar
   la información original. En cuanto al primero, que incluya el esquema, significa que ya por defecto la estructura se creará 
   sobre el esquema de nombre 'homicidios' sin necesidad de crearlo manualmente.
