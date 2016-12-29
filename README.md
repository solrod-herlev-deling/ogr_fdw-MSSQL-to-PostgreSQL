# ogr_fdw-MSSQL-to-PostgreSQL
Opret en foreign data wrapper, så enkelt-tabeller fra MSSQL kan tilgås fra PostgreSQL

 I scriptet installeres ogr_fdw extensionen, der oprettes en forbindelse til MSSQL server og hentes info om en specifik tabel, create scripts genereres, og tilsidst tildeles "SELECT" rettigheder til en ikke-superuser-bruger til den nye foreign table.

### Issues
Cognito local MSSQL bruger Danish_Norwegian_CL_AS collation, PostgreSQL bruger UTF8. Har endnu ikke fundet ud af hvordan det skal håndteres. Resultatet er at alle text columns, hvor en celle indeholder danske specialtegn bliver til "" i postgres.

Virker **__ikke__** ved at gøre følgende som postgres user:

Opret dansk collation i PostgreSQL:
  
````SQL
  CREATE COLLATION dk (locale="Danish_Denmark.1252");
````
  
  I `CREATE FOREIGN TABLE` statement:
  
````SQL
  CREATE FOREIGN TABLE cognito.geo_borger_aktiv_fdw
    ( ... ,
     vej_navn character varying COLLATE dk,
      ...
    )
````
