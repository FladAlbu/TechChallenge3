--1.0 Em que medida o contato social foi reduzido devido à pandemia? (Opções: não fez restrição; reduziu o contato, mas continuou saindo; ficou em casa, saiu somente em casos de necessidade básica; ficou rigorosamente isolado) (B11 , B9B, B9D , B9F ).

SELECT
    x1.ano,
    x1.mes,

    CASE
    WHEN x1.b011 = '1' THEN 'Sem Restrição'
    WHEN x1.b011 = '2' THEN 'Reduziu o contato'
    WHEN x1.b011 = '3' THEN 'Saiu somente por necessidade'
    WHEN x1.b011 = '4' THEN 'Completamente isolado em casa'
    END as medidas_covid,

    COUNT(x1.B009B) as total_positivo_cotonete,
    COUNT(x1.B009D) as total_positivo_dedo,
    COUNT(x1.B009F) as total_positivo_veia

FROM 
    basedosdados.br_ibge_pnad_covid.microdados x1
WHERE
    x1.B009B = '1' OR
    x1.B009D = '1' OR
    x1.B009F = '1'
GROUP BY 
    x1.ANO,
    x1.MES,
    medidas_covid
ORDER BY x1.MES;

--2.0 Quais foram as principais providência após o diagnóstico dos sintomas ? ( B1 E B2 E B3 ).

SELECT 
    x1.ANO,
    x1.MES,
    COUNT(x1.B0011) AS Febre,
    COUNT(x1.B0012) AS CansacoFadiga,
    COUNT(x1.B0013) AS Tosse,
    COUNT(x1.B0014) AS DificuldadeParaRespirarFaltaDeAr,
    COUNT(x1.B0015) AS DorDeGarganta,
    COUNT(x1.B0016) AS CongestaoNasal,
    COUNT(x1.B0017) AS DorDeCabeca,
    COUNT(x1.B0018) AS DorNoPeito,
    COUNT(x1.B0019) AS Nausea,
    COUNT(x1.B00110) AS Diarreia,
    COUNT(x1.B00111) AS PerdaDePaladar,
    COUNT(x1.B00112) AS PerdaDeOlfato,
    COUNT(x1.B00113) AS NenhumDosSintomas,

    CASE
    WHEN x1.b002 = '1' THEN 'Procurou atendimento médico'
    WHEN x1.b002 = '2' AND x1.B0031 = '1' THEN 'Ficou em casa'
    WHEN x1.b002 = '2' AND x1.B0032 = '1' THEN 'Ligou para algum profissional de saúde'
    WHEN x1.b002 = '2' AND x1.B0033 = '1' THEN 'Tomou remédio por conta própria'
    WHEN x1.b002 = '2' AND x1.B0034 = '1' THEN 'Tomou remédio por orientação médica'
    WHEN x1.b002 = '2' AND x1.B0035 = '1' THEN 'Recebeu visita de algum profissional de saúde do SUS'
    WHEN x1.b002 = '2' AND x1.B0036 = '1' THEN 'Recebeu visita de profissional de saúde particular'
    WHEN x1.b002 = '2' AND x1.B0037 = '1' THEN 'Outro'
    END as providencias,

FROM 
    basedosdados.br_ibge_pnad_covid.microdados x1
WHERE
    x1.B0011 = '1' OR
	x1.B0012 = '1' OR
	x1.B0013 = '1' OR
	x1.B0014 = '1' OR
	x1.B0015 = '1' OR
	x1.B0016 = '1' OR
	x1.B0017 = '1' OR
	x1.B0018 = '1' OR
	x1.B0019 = '1' OR
	x1.B00110 = '1' OR
	x1.B00111 = '1' OR
	x1.B00112 = '1' OR
	x1.B00113 = '1'
GROUP BY 
    x1.ANO,
    x1.MES,
    providencias
ORDER BY x1.MES;


--3.0 Correlação do sexo e escolaridade com a busca de atendimento ( A3,A5,B2).

SELECT 
    x1.ANO,
    x1.MES,

    CASE
    WHEN x1.A003 = '1' THEN 'Homem'
    WHEN x1.A003 = '2' THEN 'Mulher'
    END as sexo,

    CASE
    WHEN x1.A005 = '1' THEN 'Sem instrução'
    WHEN x1.A005 = '1' THEN 'Fundamental incompleto'
    WHEN x1.A005 = '1' THEN 'Fundamental completo'
    WHEN x1.A005 = '1' THEN 'Médio incompleto'
    WHEN x1.A005 = '1' THEN 'Médio completo'
    WHEN x1.A005 = '1' THEN 'Superior incompleto'
    WHEN x1.A005 = '1' THEN 'Superior completo'
    WHEN x1.A005 = '1' THEN 'Pós-graduação, mestrado ou doutorado completo'
    END as escolaridade,

    CASE
    WHEN x1.B002 = '1' THEN 'Procurou atendimento médico'
    WHEN x1.B002 = '2' THEN 'Não procurou atendimento médico'
    END as atendimento,
    COUNT(*) AS Quantidade
FROM 
    basedosdados.br_ibge_pnad_covid.microdados x1
GROUP BY 
    x1.ANO,
    x1.MES,
    sexo,
    escolaridade,
    atendimento
ORDER BY x1.MES;

--
Q1. Sintomas mais comuns da covid19

SELECT 
    x1.ANO,
    x1.MES,
    CASE
        WHEN x1.B0011 = '1' THEN 'Febre'
        WHEN x1.B0012 = '1' THEN 'Tosse'
        WHEN x1.B0013 = '1' THEN 'Dor de Garganta'
        WHEN x1.B0014 = '1' THEN 'Dificuldade para respirar'
        WHEN x1.B0015 = '1' THEN 'Dor de cabeça'
        WHEN x1.B0016 = '1' THEN 'Dor no peito'
        WHEN x1.B0017 = '1' THEN 'Náusea/Enjoo'
        WHEN x1.B0018 = '1' THEN 'Nariz entupido ou escorrendo'
        WHEN x1.B0019 = '1' THEN 'Fadiga/ Cansaço'
        WHEN x1.B00110 = '1' THEN 'Dor nos olhos'
        WHEN x1.B00111 = '1' THEN 'Perda de cheiro ou sabor'
        WHEN x1.B00112 = '1' THEN 'Dor muscular/Dor no corpo'
        WHEN x1.B00113 = '1' THEN 'Diarréia'
    END AS sintoma_mais_comum,
    COUNT(*) AS qtd_membros
FROM 
    basedosdados.br_ibge_pnad_covid.microdados x1
GROUP BY 
    x1.ANO,
    x1.MES,
    sintoma_mais_comum;
2.0 Quantidade de pessoas  internadas e entubadas por mês. ( B5 E B6)
SELECT 
    x.ANO,
    x.MES,
    SUM(CASE WHEN cast(B005 as int64) = 1 THEN 1 ELSE 0 END) AS qtd_internadas,
    SUM(CASE WHEN cast(B006 as int64) = 1 THEN 1 ELSE 0 END) AS qtd_entubadas
FROM 
    basedosdados.br_ibge_pnad_covid.microdados x

GROUP BY
    x.ANO,
    x.MES;
4.0 Quantidade de pessoas que apresentaram sintomas de COVID-19 e testaram positivo para covid com exame de sangue,cotonete e dedo
SELECT 
    x1.ANO,
    x1.MES,
    COUNT(*) AS positivo_dedo
FROM 
    basedosdados.br_ibge_pnad_covid.microdados x1
WHERE
    (CAST(x1.B0011 AS INT64) = 1 OR CAST(x1.B0012 AS INT64) = 1 OR
    CAST(x1.B0013 AS INT64) = 1 OR CAST(x1.B0014 AS INT64) = 1 OR
    CAST(x1.B0015 AS INT64) = 1 OR CAST(x1.B0016 AS INT64) = 1 OR
    CAST(x1.B0017 AS INT64) = 1 OR CAST(x1.B0018 AS INT64) = 1 OR
    CAST(x1.B0019 AS INT64) = 1 OR CAST(x1.B00110 AS INT64) = 1 OR
    CAST(x1.B00111 AS INT64) = 1 OR CAST(x1.B00112 AS INT64) = 1 OR
    CAST(x1.B00113 AS INT64) = 1) AND
    CAST(x1.B009B AS INT64) = 1
GROUP BY 
    x1.ANO,
    x1.MES;