begin transaction
insert into
    [Bolig].[dbo].[Regnskabstekster] (Sel, Afd, Nr, Teksttype, Tekstmark, Tekst)
select
    a.sel,
    a.afd,
    1320,
    'M',
    case
        when rn.value = 1 then 1
        else 0
    end,
    NULL
from
    [Bolig].[dbo].[Afdeling] a
    left join [LejerBO_DB].[dbo].[Regnskabstekster_Niels] rn on a.sel = rn.sel
    and a.afd = rn.afd
    and rn.tekst like 'Tostrenget vandsys (rent/gråt)'
where
    a.sel > 100 commit