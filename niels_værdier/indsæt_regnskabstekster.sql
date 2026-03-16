begin transaction
insert into
    [Bolig].[dbo].[Regnskabstekster] (Sel, Afd, Nr, Teksttype, Tekstmark, Tekst)
SELECT
    distinct x.sel,
    x.afd,
    x.Nr,
    x.Teksttype,
    case
        when rn.value = 1 then 1
        else 0
    end as Værdi,
    NULL
FROM
    (
        SELECT
            a.sel,
            a.afd,
            a.navn as afdnavn,
            def.*,
            0 as value
        FROM
            [Bolig].[dbo].[Afdeling] a
            CROSS APPLY (
                SELECT
                    *
                FROM
                    [Bolig].[dbo].[Regnskabsteksttyper] rt
                    LEFT JOIN (
                        select
                            distinct tekst
                        from
                            [LejerBO_DB].[dbo].[Regnskabstekster_Niels]
                    ) rn on rt.navn = rn.tekst
                where
                    rn.tekst is not null
            ) def
    ) x
    LEFT JOIN [LejerBO_DB].[dbo].[Regnskabstekster_Niels] rn ON x.sel = rn.sel
    and x.afd = rn.afd
    and x.navn = rn.tekst
where
    x.sel > 100 commit