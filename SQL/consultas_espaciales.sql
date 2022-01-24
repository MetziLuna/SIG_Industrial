SELECT SUM(st_length(viasL_200K_CNR2013.geometry))
FROM viasL_200K_CNR2013
WHERE viasL_200K_CNR2013.NOM = 'Bulevar Monseñor Romero'
------------------------------------------

SELECT m.cod_mun4, m.nom_mun, e.nombre_cen, e.geom
from escuelas_lcc as e, municipios_lcc as m
WHERE m.pobr_fisdl = 'Pobreza Severa'
      AND ST_WITHIN(e.geom, m.geom)
ORDER BY m.nom_mun ASC
------------------------------------------
SELECT distinct(l.nom), l.geom
FROM lagos_lcc as l, municipios_lcc as m
WHERE ST_OVERLAPS(l.geom, m.geom)
ORDER BY l.nom
------------------------------------------
SELECT e.nombre_cen, e.geom
FROM escuelas_lcc as e, rios_lcc as r
WHERE e.municipio = 'LA LIBERTAD' AND r.nom = 'RIO GRANDE'
      AND ST_CONTAINS(ST_BUFFER(r.geom, 700), e.geom)
ORDER BY e.nombre_cen    
------------------------------------------
SELECT e.nombre_cen, e.geom
FROM escuelas_lcc as e, rios_lcc as r
WHERE e.municipio = 'LA LIBERTAD' AND r.nom = 'RIO GRANDE'
      AND ST_DWITHIN(e.geom,r.geom, 700)
ORDER BY e.nombre_cen
