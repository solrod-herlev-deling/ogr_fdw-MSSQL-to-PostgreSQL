-- I følgende script installeres ogr_fdw extensionen, der oprettes en forbindelse til MSSQL server og hentes info om en specifik tabel, create scripts genereres, 
-- og tilsidst tildeles "SELECT" rettigheder til en ikke-superuser bruger til den nye foreign table.

-- Check om ogr_fdw extensionen er tilgængelig:
select * from pg_available_extensions;

-- Som postgres user create extensionen:
create extension ogr_fdw;

-- brug ogr_fdw_info på en tabel for at skabe create scripts for både foreign server og foreign table:
-- ogr_fdw_info.exe -s "MSSQL:server=serveradresse;database=ql5130pd;UID=database-user;PWD=password" -l "dbo.GEO_BORGER_AKTIV"

-- Stadig som postgres user, kør de genererede scripts (husk at skifte navnet på din server i begge scripts):

CREATE SERVER cognito_local
  FOREIGN DATA WRAPPER ogr_fdw
  OPTIONS (
    datasource 'MSSQL:server=serveradresse;database=ql5130pd;UID=database-user;PWD=password',
    format 'MSSQLSpatial' );

CREATE FOREIGN TABLE geo_borger_aktiv_fdw (
  fid integer,
  geom geometry,
  objectid integer,
  personnummer real,
  cpr varchar,
  fodsel_dato varchar,
  alder integer,
  kon varchar,
  kommunenummer integer,
  vejkode integer,
  vej_navn varchar,
  hus_nr varchar,
  husnummer integer,
  husbogstav varchar,
  kvh_adr_key varchar,
  etage varchar,
  side_dornr varchar,
  kvhx_adr_key varchar,
  adresse_off varchar,
  bygning_nr integer,
  navn varchar,
  adresseringsnavn varchar,
  adrnavn_dato varchar,
  co_navn varchar,
  stilling varchar,
  stilling_dato varchar,
  folkekirk_tilh_mrk varchar,
  folkekirk_mrk_dato varchar,
  borgerstatus_kode integer,
  borgerstatus varchar,
  borgerstatus_ts varchar,
  antal_born integer,
  adr_tilflyt_ts varchar,
  adr_fraflyt_ts varchar,
  kom_tilflytdato varchar,
  fraflyt_kommunenr integer,
  adressebeskyt_dato varchar,
  adr_beskyt_sltdato varchar,
  civilstand_ts varchar,
  civilstand_kode varchar,
  civilstand_txt varchar,
  civilst_ophor_ts varchar,
  personnr_agtefalle real,
  agtefalle_flag varchar,
  land_kode integer,
  land_txt varchar,
  statsb_aendret_ts varchar,
  statborg_ophor_ts varchar,
  personnummer_mor real,
  personnummer_far real,
  mor_dok varchar,
  far_dok varchar,
  personnummer_red varchar,
  personnummer_mor_red varchar,
  personnummer_far_red varchar,
  borgerstatus_um varchar,
  fodselsreg_um varchar,
  ddkncelle100m varchar,
  ddkncelle1km varchar,
  ddkncelle10km varchar,
  mi_prinx integer,
  mi_style varchar )
  SERVER cognito_local
  OPTIONS ( layer 'GEO_Borger_Aktiv' );
  
  -- Giv din normale bruger læserettigheder på tabellen:
  GRANT SELECT ON cognito.geo_borger_aktiv_fdw TO test_webgis;
