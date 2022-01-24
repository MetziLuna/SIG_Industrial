
--Indique el nombre del municipio que tenga geometría inválida.
SELECT m.nom_mun
FROM municipios m
WHERE ST_ISVALID(m.geom) = False

--¿En qué sistema de referencia de coordenadas (SRC) está la capa de cantones?
SELECT ST_SRID(c.geom)
FROM cantones as c
LIMIT 1

--¿Cuáles son las coordenadas de los volcanes activos en El Salvador?
SELECT v.nom, st_astext(v.geom) as coord
FROM volcanes v
WHERE v.status = 'Activo-histórico'

--¿Qué área en km cuadrados tiene el lago de Coatepeque?
SELECT ST_Area(L.geom) AS area_lago
FROM "lagos" l
WHERE d.nom_dpto = 'LAGO DE COATEPEQUE';

-- ¿Qué distancia?
SELECT ST_distance(e.geom, r.geom)
FROM escuelas e, rios r
WHERE e."NOMBRE_CEN" = 'CENTRO ESCOLAR "CANTON LAS GRANADILLAS"' and r.nom = 'RIO LAS GRANADILLAS'

-- ¿Qué ríos o quebradas tienen una longitud menor a 1 km?
SELECT r.nom, r.geom, ST_length(r.geom) as longitud
FROM rios r
WHERE ST_length(r.geom) < 1000
ORDER BY longitud

-- ¿Cuántos ríos o quebradas tienen una longitud menor a 1 km?
SELECT count(r.geom)
FROM rios r
WHERE ST_length(r.geom) < 1000

--¿Qué longitud en km tiene el Bulevar Monseñor Romero?
SELECT SUM(st_length(viasL_200K_CNR2013.geometry)) as longitud_carretera
FROM viasL_200K_CNR2013
WHERE viasL_200K_CNR2013.NOM = 'Bulevar Monseñor Romero'

--¿Cómo se distribuyen espacialmente las escuelas ubicadas en municipios de pobreza severa?
SELECT m.cod_mun4, m.nom_mun, e.nombre_cen, e.geom
from escuelas_lcc as e, municipios_lcc as m
WHERE m.pobr_fisdl = 'Pobreza Severa'
      AND ST_WITHIN(e.geom, m.geom)
ORDER BY m.nom_mun ASC

--¿Qué lagos son compartidos por varios municipios?
SELECT distinct(l.nom), l.geom
FROM lagos_lcc as l, municipios_lcc as m
WHERE ST_OVERLAPS(l.geom, m.geom)
ORDER BY l.nom
-- ¿Qué escuelas del municipio Puerto de la Libertad están ubicadas en la zona de susceptibilidad a inundación del río Grande de Tamanique? La zona de riesgo se ha delimitado como 700 m a cada lado del río.

SELECT e.nombre_cen, e.geom
FROM escuelas_lcc as e, rios_lcc as r
WHERE e.municipio = 'LA LIBERTAD' AND r.nom = 'RIO GRANDE'
      AND ST_CONTAINS(ST_BUFFER(r.geom, 700), e.geom)
ORDER BY e.nombre_cen    
-- ¿Qué escuelas del municipio Puerto de la Libertad están ubicadas en la zona de susceptibilidad a inundación del río Grande de Tamanique? La zona de riesgo se ha delimitado como 700 m a cada lado del río.

SELECT e.nombre_cen, e.geom
FROM escuelas_lcc as e, rios_lcc as r
WHERE e.municipio = 'LA LIBERTAD' AND r.nom = 'RIO GRANDE'
      AND ST_DWITHIN(e.geom,r.geom, 700)
ORDER BY e.nombre_cen
