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

## Verba API server

Para desplegar el API server necesitaras [Docker](https://www.docker.com) instalado en tu sistema.

```
docker build -t verba-go .
docker run -p 9900:9900 verba-go
```

El API server estará disponible en `http://localhost:9900`. La copia de los transcripts se sincroniza automaticamente cada 12 horas desde verba.civio.es.

## Verba CLI

Este proyecto incluye una CLI para crear y actualizar la base de datos de telediarios.

### Compilando el binario

Para compilar el binario necesitaras [Go](https://go.dev) instalado en tu sistema y [RSX](https://github.com/rubiojr/rsx) disponible en el `PATH`.

```bash
CGO_ENABLED=1 go install --tags fts5 github.com/rubiojr/rsx@latest

git clone https://github.com/rubiojr/verba-go
cd verba-go
CGO_ENABLED=1 rsx build -o verba
```

> [!NOTE]
> Algunos scripts utilizan SQLite y su extension FTS5, asi que compilar con `--tags fts5` es necesario.

## Creando una base de datos indexada

```bash
# crea la base de datos SQLite
./verba --db verba.db createdb

# busca en los telediarios
./verba --db verba.db search --query "sin animo de lucro"
```

## Actualizando la base de datos

```bash
# actualiza los telediarios
./verba --db verba.db sync
```

## Creando una copia local de los transcripts en formato JSON

```bash
# crea una copia local de los transcripts en formato JSON
./verba --dir transcripts download
```

## Levantando el API server para buscar en los telediarios

```bash
# crea la base de datos SQLite
./verba --db verba.db createdb
# levanta un servidor web para buscar en los telediarios
# la base de datos se sincroniza automaticamente cada 12 horas
./verba --db verba.db serve --sync

# busca en los telediarios
curl "http://localhost:9900/search?q=sin%20animo%20de%20lucro"
```

## Sintaxis de búsqueda

La sintaxis de búsqueda es la misma que la de SQLite FTS5. Puedes encontrar más información en la [documentación oficial](https://www.sqlite.org/fts5.html#full_text_query_syntax).

## Creditos

- [Civio](https://www.civio.es) - La maravillosa gente que hace posible [Verba](https://verba.civio.es) y ofrece los datos bajo licencia [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/deed.es)

## Licencia

Este proyecto esta bajo la licencia [MIT](LICENSE).
