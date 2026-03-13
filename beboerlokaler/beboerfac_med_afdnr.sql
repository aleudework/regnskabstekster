/****** Script for SelectTopNRows command from SSMS  ******/
SELECT distinct a.sel, a.afd, rb.[Boligtype tekst]
  FROM [LejerBO_DB].[dbo].[Lejemaal_Stamdata_samlet]  rb
INNER JOIN [Bolig].[dbo].[Afdeling] a
    ON rb.[Afdelingsnr#] = TRY_CAST(a.EksternAfdnr AS FLOAT) AND a.sel >= 100
  where [Boligtype tekst] in ('Selskabslokaler', 'Fælleshus', 'Fælleslokale')