/* Vær obs og husk og ændre til rigtige kolonner */

begin transaction
insert into [Bolig].[dbo].[Regnskabstekster] (Sel, Afd, Nr, Teksttype, Tekstmark, Tekst)

select distinct * from
(select
a.sel, 
a.afd,
1155 as kol1,
'T' as kol2,
NULL as kol3,
FORMAT(rs.[Skæringsdato C], 'dd-MM-yyyy') as dato

from [Bolig].[dbo].[Afdeling] a
LEFT JOIN (
SELECT 
	[Forretningspartner]
      ,[Støttedato A]
      ,[Skæringsdato A]
      ,[Støttedato B]
      ,[Skæringsdato B]
      ,[Støttedato C]
      ,[Skæringsdato C]

  FROM [LejerBO_DB].[dbo].[Regnskabstekster_SAP_Afd_Stamdata] ) rs
  ON rs.forretningspartner = TRY_CAST(a.EksternAfdnr AS FLOAT)
  where a.sel > 100) x
  where
  x.dato is not null
  commit
