SELECT distinct a.sel, a.afd, a.EksternAfdNr
FROM [LejerBO_DB].[dbo].[Regnskabstekster_Vaskerier] rb
INNER JOIN [Bolig].[dbo].[Afdeling] a
    ON rb.[Afdeling_SAP] = TRY_CAST(a.EksternAfdnr AS FLOAT) AND a.sel >= 100
