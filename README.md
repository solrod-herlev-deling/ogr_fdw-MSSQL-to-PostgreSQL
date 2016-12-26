# ogr_fdw-MSSQL-to-PostgreSQL
Opret en foreign data wrapper, så enkelt-tabeller fra MSSQL kan tilgås fra PostgreSQL

 I scriptet installeres ogr_fdw extensionen, der oprettes en forbindelse til MSSQL server og hentes info om en specifik tabel, create scripts genereres, og tilsidst tildeles "SELECT" rettigheder til en ikke-superuser-bruger til den nye foreign table.
