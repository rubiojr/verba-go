# Buscador de telediarios de RTVE

Este proyecto pretende ser un buscador de telediarios de RTVE y una re-implementación del API [Verba](https://verba.civio.es) en Go, simplificando el stack.

- Un solo binario para el despliegue.
- Sin necesidad de una base de datos externa o Elasticsearch.

El objetivo es mantener la compatibilidad con la API original y añadir nuevas funcionalidades.

Por ahora, el proyecto es un trabajo en progreso y el API server no se ha publicado todavía.

El contenido de los telediarios se obtiene de la web [Civio](https://verba.civio.es) y se almacena en una base de datos SQLite.

## Requisitos

- [Go](https://go.dev)
- [RSX](https://github.com/rubiojr/rsx)

## Verba scripts

Este proyecto incluye scripts para crear y actualizar la base de datos de telediarios.

Para ejecutar los scripts necesitaras [Go](https://go.dev) instalado en tu sistema y [RSX](https://github.com/rubiojr/rsx) disponible en el `PATH`.

```
go install --tags fts5 github.com/rubiojr/rsx@latest
```

> [!NOTE]
> Algunos scripts utilizan SQLite y su extension FTS5, asi que compilar con `--tags fts5` es necesario.

## Creando una base de datos indexada

```bash
# crea la base de datos SQLite
script/verba-createdb --db verba.db

# indexa los telediarios
script/verba-sync --db verba.db

# busca en los telediarios
script/verba-search --db verba.db "sin animo de lucro"
```

## Actualizando la base de datos

```bash
# actualiza los telediarios
script/verba-sync --db verba.db
```

## Sintaxis de búsqueda

La sintaxis de búsqueda es la misma que la de SQLite FTS5. Puedes encontrar más información en la [documentación oficial](https://www.sqlite.org/fts5.html#full_text_query_syntax).

## Creditos

- [Civio](https://www.civio.es) - La maravillosa gente que hace posible [Verba](https://verba.civio.es) y ofrece los datos bajo licencia [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/deed.es)

## Licencia

Este proyecto esta bajo la licencia [MIT](LICENSE).
