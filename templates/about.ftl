<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>API - GUIA Knowledge Graph</title>

  <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/jquery/jquery-3.4.0.min.js"></script>
  <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/bootstrap/bootstrap.min.js"></script>
  <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/bootstrap/bootstrap.min.css" rel="stylesheet">
  <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/helio.css" rel="stylesheet">
  <link rel="icon" type="image/png" href="https://avatars.githubusercontent.com/u/206107082?s=200&v=4">

  <style>
    :root {
      --bg: #f7f7fb;
      --card: #ffffff;
      --text: #1f2937;
      --muted: #6b7280;
      --line: #e5e7eb;
      --accent: #0b3c5d;
      --accent-soft: #dbeafe;
    }

    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background: var(--bg);
      color: var(--text);
    }

    .guia-navbar {
      background-color: #0b3c5d;
      border: none;
      border-radius: 0;
      margin-bottom: 0;
    }

    .guia-navbar .navbar-brand,
    .guia-navbar .navbar-nav > li > a {
      color: white !important;
    }

    .guia-navbar .navbar-nav > li > a:hover {
      background-color: #145374 !important;
    }

    .page-wrap {
      padding: 24px;
    }

    .container-narrow {
      max-width: 1100px;
      margin: 0 auto;
    }

    .card {
      background: var(--card);
      border: 1px solid var(--line);
      border-radius: 14px;
      padding: 20px;
      margin-bottom: 18px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    h1 {
      color: var(--accent);
      margin-top: 0;
    }

    .muted {
      color: var(--muted);
    }

    .endpoint {
      background: #fbfbfd;
      border: 1px solid var(--line);
      border-radius: 10px;
      padding: 12px;
      font-family: monospace;
      margin-top: 10px;
      overflow-x: auto;
    }

    .footer {
      margin-top: 30px;
      padding: 18px;
      background: #0b3c5d;
      color: white;
      text-align: center;
    }

    .footer a {
      color: white;
      font-weight: bold;
      text-decoration: none;
    }

    .footer-logo {
      width: 28px;
      vertical-align: middle;
      margin: 0 6px;
    }
  </style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar guia-navbar">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="/">GUIA Knowledge Graph</a>
    </div>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="/">Home</a></li>
      <li><a href="/resources">Recursos</a></li>
      <li><a href="/search">Búsqueda</a></li>
      <li><a href="/sparql">SPARQL</a></li>
      <li><a href="/explore">SPARQL Gráfico</a></li>
      <li><a href="/graph">Explorador</a></li>
      <li><a href="/about">API</a></li>
    </ul>
  </div>
</nav>

<div class="page-wrap">
  <div class="container-narrow">

    <!-- HEADER -->
    <div class="card">
      <h1>API del Knowledge Graph</h1>

      <p>
        Este portal expone una <strong>API (Application Programming Interface)</strong> que permite a aplicaciones,
        investigadores y desarrolladores acceder de forma programática a los datos del proyecto GUIA.
        Una API define un conjunto de operaciones y formatos estándar para consultar y reutilizar información
        sin necesidad de interactuar manualmente con la interfaz web.
      </p>

      <p>
        En este caso, la API se basa en un <strong>Knowledge Graph</strong>, es decir, un modelo de datos en forma
        de grafo donde la información se representa como entidades (nodos) y relaciones (aristas).
        Este enfoque permite capturar conocimiento complejo de forma estructurada, interconectada y fácilmente
        explotable por máquinas.
      </p>

      <p>
        El Knowledge Graph de GUIA está construido siguiendo estándares del
        <a href="https://www.w3.org/" target="_blank">W3C</a>, lo que garantiza interoperabilidad y reutilización.
        En particular:
      </p>

      <ul>
        <li>
          <a href="https://www.w3.org/TR/rdf11-concepts/" target="_blank">
            RDF (Resource Description Framework)
          </a> se utiliza como modelo de datos basado en tripletas sujeto–predicado–objeto.
        </li>
        <li>
          <a href="https://www.w3.org/TR/sparql11-query/" target="_blank">
            SPARQL
          </a> permite consultar el grafo mediante un lenguaje declarativo similar a SQL.
        </li>
        <li>
          <a href="https://www.w3.org/TR/owl2-overview/" target="_blank">
            OWL (Web Ontology Language)
          </a> define la ontología que estructura el dominio de conocimiento.
        </li>
      </ul>

      <p>
        Gracias a estos estándares, los datos pueden integrarse con otros sistemas, enlazarse con datasets externos
        y reutilizarse en múltiples contextos (docencia, analítica, inteligencia artificial, etc.).
      </p>

    </div>

    <!-- SPARQL -->
    <div class="card">
      <h2>Endpoints</h2>

      <p>
        El Knowledge Graph de GUIA expone sus datos a través de endpoints HTTP que permiten acceder tanto
        a recursos individuales como realizar consultas complejas sobre el grafo.
      </p>

      <p>
        Estos endpoints siguen estándares del W3C y buenas prácticas de APIs web, facilitando su integración
        en aplicaciones externas, pipelines de datos o sistemas de inteligencia artificial.
      </p>

      <hr>

      <h3>Endpoint SPARQL</h3>

      <p>
        El endpoint <code>/api/sparql</code> implementa el estándar
        <a href="https://www.w3.org/TR/sparql11-query/" target="_blank">
          SPARQL 1.1 Query Language
        </a>, permitiendo ejecutar consultas sobre el grafo RDF.
      </p>

      <p>
        Las consultas se envían mediante peticiones <strong>HTTP GET</strong> usando el parámetro <code>query</code>,
        y los resultados se devuelven en formato <code>application/sparql-results+json</code>.
      </p>

      <div class="endpoint">
        GET /api/sparql?query=...
      </div>

      <p><strong>Ejemplo:</strong> Obtener 10 recursos del grafo</p>

      <div class="endpoint">
    curl -X GET "https://guia-kg.skai.etsisi.upm.es/api/sparql?query=SELECT%20%3Fs%20WHERE%20%7B%0A%20%20%20%3Fs%20a%20%3Ftype%20.%0A%7D%20LIMIT%2010"
      </div>

      <p class="muted">
        Nota: Se recomienda acotar las consultas al named graph
        <code>&lt;https://guia-kg.skai.etsisi.upm.es/data&gt;</code> para evitar incluir elementos de ontología.
      </p>

      <hr>

      <h3>Acceso a recursos RDF</h3>

      <p>
        Cada entidad del Knowledge Graph puede recuperarse directamente mediante su URI.
        Este endpoint devuelve una representación del recurso basada en sus tripletas RDF.
      </p>

      <div class="endpoint">
        GET /resource/{id}
      </div>

      <p><strong>Ejemplo:</strong> Obtener información de un profesor</p>

      <div class="endpoint">
    curl "https://guia-kg.skai.etsisi.upm.es/resource/andreajesus.cimmino%40upm.es"
      </div>

      <p class="muted">
        Este endpoint está orientado a navegación y exploración humana, pero también puede integrarse
        en aplicaciones para recuperar contexto estructurado.
      </p>

    </div>

    <div class="card">
  <h2>Dumps de datos</h2>

  <p>
    Debido al volumen del Knowledge Graph, los datos completos también se ofrecen en forma de
    <strong>dumps descargables</strong>. Estos dumps permiten trabajar con el grafo de manera local,
    sin necesidad de realizar consultas al endpoint SPARQL.
  </p>

  <p>
    Los datasets se distribuyen en archivos comprimidos (<code>.zip</code>) organizados por curso académico,
    lo que facilita su descarga selectiva y su uso en análisis históricos o comparativos.
  </p>

  <ul>
    <li>Datos disponibles desde el curso <strong>2009–2010</strong> hasta la actualidad</li>
    <li>Formato RDF serializado (N3)</li>
    <li>Distribución segmentada por año académico</li>
  </ul>

  <h3>Listado de datasets</h3>

  <p class="muted">
    Los siguientes datasets estarán disponibles próximamente a través de Zenodo:
  </p>

  <ul>
    <li><a href="#" target="_blank">guia-kg_2009-2010.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2010-2011.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2011-2012.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2012-2013.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2013-2014.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2014-2015.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2015-2016.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2016-2017.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2017-2018.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2018-2019.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2019-2020.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2020-2021.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2021-2022.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2022-2023.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2023-2024.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2024-2025.zip</a></li>
    <li><a href="#" target="_blank">guia-kg_2025-2026.zip</a></li>
  </ul>

  <p class="muted">
    Se recomienda utilizar los dumps para cargas masivas de datos y el endpoint SPARQL para consultas
    dinámicas o exploratorias.
  </p>

</div>

  </div>
</div>

<!-- FOOTER -->
<footer class="footer">
  <div>
    Powered by
    <a href="https://github.com/helio-ecosystem" target="_blank">
      <img class="footer-logo" src="https://avatars.githubusercontent.com/u/94366057?s=200&v=4" />
    </a>
    <a href="https://github.com/helio-ecosystem/helio-publisher" target="_blank">
      Helio Publisher
    </a>
  </div>
</footer>

</body>
</html>