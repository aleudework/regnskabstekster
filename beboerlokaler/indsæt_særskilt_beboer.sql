begin transaction
insert into [Bolig].[dbo].[Regnskabstekster] (Sel, Afd, Nr, Teksttype, Tekstmark, Tekst)
SELECT

    X1.afdsel,
    X1.afdafd,
    X1.Nr,
    X1.Teksttype,
    (
        case
            when x1.sel is not null then 1
            else 0
        end
    ) as 'Tekstmark',
    NULL as 'Tekst'
FROM
    (
        SELECT
            a.sel as afdsel,
            a.afd as afdafd,
            a.navn as afdnavn,
            x.*,
            R.*
        FROM
            [Bolig].[dbo].[Afdeling] a
            CROSS APPLY (
                SELECT
                    *
                FROM
                    [Bolig].[dbo].[Regnskabsteksttyper]
                where
                    Navn like '%Særskil%'
            ) R
            LEFT JOIN (
                SELECT
                    distinct a.sel,
                    a.afd,
                    rb.[Boligtype tekst]
                FROM
                    [LejerBO_DB].[dbo].[Lejemaal_Stamdata_samlet] rb
                    INNER JOIN [Bolig].[dbo].[Afdeling] a ON rb.[Afdelingsnr#] = TRY_CAST(a.EksternAfdnr AS FLOAT)
                    AND a.sel >= 100
                where
                    [Boligtype tekst] in ('Selskabslokaler')
            ) X ON a.sel = x.sel
            and a.afd = x.afd
        WHERE
            a.sel > 100
    ) X1

commit
