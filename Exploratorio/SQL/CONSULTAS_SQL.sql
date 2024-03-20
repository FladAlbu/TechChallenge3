-- 1.0 Quantos membros do domicílio estavam temporariamente afastados do trabalho na última semana? Por qual motivo ?( C002 E C003 )
SELECT mes,
       C002 as afastado ,
       C003 as motivo_afastado,
       COUNT(*) as Quantidade
FROM `basedosdados.br_ibge_pnad_covid.microdados`
WHERE C002 IS NOT NULL
AND
C003 IS NOT NULL
GROUP BY mes, C002, C003
ORDER BY mes, C003


-- 2.0 Dos membros afastados do trabalho, quantos continuaram sendo remunerados? ( C002 e C004)
SELECT mes,
       C002 as afastado ,
       C004 as continou_remunerado,
       COUNT(*) as Quantidade
FROM `basedosdados.br_ibge_pnad_covid.microdados`
WHERE C002 IS NOT NULL
AND
C004 IS NOT NULL
GROUP BY mes, C002, C004
ORDER BY mes, C004

--  2.0 Dos membros afastados do trabalho, quantos continuaram sendo remunerados? ( C004)  -> possui dados em branco no c003
SELECT mes,
       C002 as afastado ,
       C004 as continou_remunerado,
       C003 as motivo_afastado,
       COUNT(*) as Quantidade
FROM `basedosdados.br_ibge_pnad_covid.microdados`
WHERE C002 IS NOT NULL
AND
C002 != '2'
GROUP BY mes, C002, C004, C003
ORDER BY mes, C004
---
-- 3.0 Quantas horas, por semana, o(a) Sr(a) normalmente trabalha (em todos os trabalhos)? E Quantas horas, de fato, trabalhou (em todos os trabalhos)? (C008 E C009)
SELECT mes,
       AVG(C008) as MediaHorasSemana,
       AVG(C009) as MediaHorasTrabalhadas
FROM `basedosdados.br_ibge_pnad_covid.microdados`
GROUP BY mes
ORDER BY mes

--4.0 Quanto recebe (ou retira) normalmente em seu trabalho? (C01012) Quanto recebeu (retirou), de fato, em seu trabalho, em (mês de referência)? (C011A12)
SELECT 
    mes,
    AVG(C01012) as MediaRecebia,
    AVG(C011A12) as MediaRecebeAtualmente,
    ((AVG(C011A12) - AVG(C01012)) / AVG(C01012)) * 100 as PorcentagemMudanca
FROM `basedosdados.br_ibge_pnad_covid.microdados`
GROUP BY mes
ORDER BY mes


