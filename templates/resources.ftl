<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Explorar recursos</title>

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
      --ok: #065f46;
      --ok-bg: #d1fae5;
      --warn: #92400e;
      --warn-bg: #fef3c7;
    }

    * {
      box-sizing: border-box;
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

    .guia-navbar .navbar-nav > li > a:hover,
    .guia-navbar .navbar-nav > li > a:focus {
      background-color: #145374 !important;
      color: white !important;
    }

    .guia-navbar .navbar-toggle .icon-bar {
      background-color: white;
    }

    .page-wrap {
      padding: 24px;
    }

    .container-narrow {
      max-width: 1200px;
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

    h1, h2 {
      margin-top: 0;
    }

    h1 {
      color: var(--accent);
      margin-bottom: 8px;
    }

    .muted {
      color: var(--muted);
    }

    .controls {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 16px;
      align-items: end;
    }

    .field {
      display: flex;
      flex-direction: column;
      gap: 6px;
    }

    .field label {
      font-size: 13px;
      color: var(--muted);
      font-weight: bold;
    }

    .field input,
    .field select {
      border: 1px solid var(--line);
      border-radius: 10px;
      padding: 10px 12px;
      font-size: 14px;
      background: white;
    }

    .summary {
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
      margin-top: 16px;
    }

    .pill {
      display: inline-flex;
      align-items: center;
      padding: 6px 10px;
      border-radius: 999px;
      font-size: 12px;
      font-weight: bold;
    }

    .pill.total {
      color: var(--accent);
      background: var(--accent-soft);
    }

    .pill.info {
      color: var(--ok);
      background: var(--ok-bg);
    }

    .status {
      margin-top: 12px;
      color: var(--muted);
      font-size: 14px;
    }

    .table-wrap {
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    th, td {
      text-align: left;
      border-bottom: 1px solid var(--line);
      padding: 12px 10px;
      vertical-align: top;
      font-size: 14px;
    }

    th {
      background: #fafafa;
      position: sticky;
      top: 0;
      z-index: 1;
    }

    tr:hover {
      background: #fafcff;
    }

    a {
      color: var(--accent);
      text-decoration: none;
    }

    a:hover {
      text-decoration: underline;
    }

    code {
      font-family: monospace;
      font-size: 13px;
      word-break: break-word;
    }

    .empty {
      padding: 24px;
      text-align: center;
      color: var(--muted);
    }

    .loading {
      display: none;
      color: var(--muted);
      font-size: 14px;
      margin-top: 10px;
    }

    .small-btn {
      background: white;
      color: var(--accent);
      border: 1px solid var(--line);
      border-radius: 8px;
      padding: 6px 10px;
      cursor: pointer;
      text-decoration: none;
      display: inline-block;
      font-size: 13px;
      margin-right: 6px;
      margin-top: 4px;
      white-space: nowrap;
    }

    .small-btn:hover {
      text-decoration: none;
      background: #f8fafc;
    }

    .small-btn.visual-btn {
      background: var(--ok-bg);
      color: var(--ok);
      border-color: #86efac;
    }

    .small-btn.visual-btn:hover {
      background: #bbf7d0;
      color: var(--ok);
    }

    .small-btn.resource-btn {
      background: var(--warn-bg);
      color: var(--warn);
      border-color: #fdba74;
    }

    .small-btn.resource-btn:hover {
      background: #fed7aa;
      color: var(--warn);
    }

    @media (max-width: 900px) {
      .page-wrap {
        padding: 14px;
      }

      .controls {
        grid-template-columns: 1fr;
      }
    }
  </style>
  <style> 
    .footer {
      margin-top: 30px;
      padding: 18px 24px;
      background: #0b3c5d;
      color: white;
      border-top: 1px solid rgba(255,255,255,0.12);
    }

    .footer-inner {
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 12px;
      flex-wrap: wrap;
      text-align: center;
    }

    .footer a {
      color: white;
      text-decoration: none;
      font-weight: bold;
    }

    .footer a:hover {
      text-decoration: underline;
    }

    .footer-logo {
      width: 28px;
      height: 28px;
      object-fit: contain;
    }

    .footer-separator {
      opacity: 0.7;
    }
  </style>
</head>
<body>

<nav class="navbar guia-navbar">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#guiaNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="/">GUIA Knowledge Graph</a>
    </div>
    <div class="collapse navbar-collapse" id="guiaNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="/">Home</a></li>
        <li><a href="/resources">Recursos</a></li>
        <li><a href="/search">Búsqueda</a></li>
        <li><a href="/sparql">SPARQL</a></li>
        <li><a href="/explore">SPARQL Gráfico</a></li>
        <li><a href="/graph">Explorador Gráfico</a></li>
        <li><a href="/about">API</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="page-wrap">
  <div class="container-narrow">

    <div class="card">
      <h1>Explorar recursos</h1>
      <p class="muted">
        Selecciona un tipo de entidad para explorar sus instancias. Los datos se recuperan dinámicamente desde el endpoint SPARQL.
      </p>
    </div>

    <div class="card">
      <h2>Exploración por tipo</h2>

      <div class="controls">
        <div class="field">
          <label for="typeSelect">Tipo de recurso</label>
          <select id="typeSelect">
            <option value="">Cargando tipos...</option>
          </select>
        </div>

        <div class="field">
          <label for="searchInput">Búsqueda</label>
          <input id="searchInput" type="text" placeholder="Buscar por URI o etiqueta" disabled />
        </div>
      </div>

      <div class="summary">
        <span class="pill total">Tipos: <span id="typeCount" style="margin-left:6px;">0</span></span>
        <span class="pill info">Instancias visibles: <span id="instanceCount" style="margin-left:6px;">0</span></span>
      </div>

      <div id="status" class="status">Cargando tipos disponibles...</div>
      <div id="loading" class="loading">Cargando datos...</div>
    </div>

    <div class="card">
      <h2>Instancias</h2>
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>Etiqueta</th>
              <th>URI</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody id="resourcesTableBody"></tbody>
        </table>
      </div>
      <div id="emptyState" class="empty" style="display:none;">No hay instancias para el filtro actual.</div>
    </div>

  </div>
</div>

<script>
  var SPARQL_ENDPOINT = "/api/sparql";

  var typeSelect = document.getElementById("typeSelect");
  var searchInput = document.getElementById("searchInput");
  var resourcesTableBody = document.getElementById("resourcesTableBody");
  var emptyState = document.getElementById("emptyState");
  var typeCount = document.getElementById("typeCount");
  var instanceCount = document.getElementById("instanceCount");
  var statusBox = document.getElementById("status");
  var loadingBox = document.getElementById("loading");

  var allTypes = [];
  var allInstances = [];

  function escapeHtml(str) {
    return String(str)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#39;");
  }

  function safeDecode(value) {
    if (!value) return value;
    try {
      return decodeURIComponent(value);
    } catch (e) {
      return value;
    }
  }

  function compactUri(uri) {
    try {
      var url = new URL(uri);
      var path = url.pathname && url.pathname !== "/" ? url.pathname : "";
      return url.hostname + path + (url.hash || "");
    } catch (e) {
      var hashIndex = uri.lastIndexOf("#");
      if (hashIndex >= 0 && hashIndex < uri.length - 1) {
        return uri.substring(hashIndex + 1);
      }
      var slashIndex = uri.lastIndexOf("/");
      if (slashIndex >= 0 && slashIndex < uri.length - 1) {
        return uri.substring(slashIndex + 1);
      }
      return uri;
    }
  }

  function humanUriLabel(uri) {
    return safeDecode(compactUri(uri)).replace(/_/g, " ");
  }

  function humanFullUri(uri) {
    return safeDecode(uri);
  }

  function setLoading(isLoading, text) {
    loadingBox.style.display = isLoading ? "block" : "none";
    if (text) {
      loadingBox.textContent = text;
    }
  }

  async function runSparql(query) {
    var response = await fetch(SPARQL_ENDPOINT + "?query=" + encodeURIComponent(query), {
      method: "GET",
      headers: {
        "Accept": "application/sparql-results+json"
      }
    });

    if (!response.ok) {
      throw new Error("SPARQL endpoint error: " + response.status + " " + response.statusText);
    }

    return await response.json();
  }

  async function loadTypes() {
    setLoading(true, "Cargando tipos...");

    var query =
      "SELECT DISTINCT ?type WHERE {\n" +
      "  GRAPH <https://guia-kg.skai.etsisi.upm.es/data> { ?s a ?type . }\n" +
      "}\n" +
      "ORDER BY ?type";

    var json = await runSparql(query);
    var bindings = json.results && json.results.bindings ? json.results.bindings : [];

    allTypes = bindings
      .filter(function(b) { return b.type && b.type.value; })
      .map(function(b) {
        return b.type.value;
      });

    typeSelect.innerHTML = "";

    if (!allTypes.length) {
      var opt = document.createElement("option");
      opt.value = "";
      opt.textContent = "No hay tipos disponibles";
      typeSelect.appendChild(opt);
      typeCount.textContent = "0";
      statusBox.textContent = "No se han encontrado tipos en el grafo.";
      setLoading(false);
      return;
    }

    var defaultOption = document.createElement("option");
    defaultOption.value = "";
    defaultOption.textContent = "Selecciona un tipo";
    typeSelect.appendChild(defaultOption);

    for (var i = 0; i < allTypes.length; i++) {
      var typeUri = allTypes[i];
      var option = document.createElement("option");
      option.value = typeUri;
      option.textContent = humanUriLabel(typeUri);
      option.title = humanFullUri(typeUri);
      typeSelect.appendChild(option);
    }

    typeCount.textContent = String(allTypes.length);
    statusBox.textContent = "Selecciona un tipo para cargar sus instancias.";
    setLoading(false);
  }

  async function loadInstancesOfType(typeUri) {
    if (!typeUri) {
      allInstances = [];
      searchInput.value = "";
      searchInput.disabled = true;
      renderInstances([]);
      instanceCount.textContent = "0";
      statusBox.textContent = "Selecciona un tipo para cargar sus instancias.";
      return;
    }

    setLoading(true, "Cargando instancias...");
    statusBox.textContent = "Consultando instancias de " + humanUriLabel(typeUri) + "...";

    var query =
      "SELECT DISTINCT ?resource ?label WHERE {\n" +
      "  ?resource a <" + typeUri + "> .\n" +
      "  OPTIONAL { ?resource <http://www.w3.org/2000/01/rdf-schema#label> ?label }\n" +
      "  OPTIONAL { ?resource <https://guia.org/teachingPeriodMonths> ?label }\n" +
      "  OPTIONAL { ?resource <https://guia.org/activityDescription> ?label }\n" +
      "  OPTIONAL { ?resource <https://guia.org/evaluationType> ?label }\n" +
      "  OPTIONAL { ?resource <https://guia.org/evaluationDescription> ?label }\n" +
      "  OPTIONAL { ?resource <https://guia.org/trialWeek> ?label }\n" +
      "  OPTIONAL { ?resource <https://guia.org/trialDescription> ?label }\n" +
      "  OPTIONAL { ?resource <https://guia.org/trialMode> ?label }\n" +
      "  OPTIONAL { ?resource <https://guia.org/trialType> ?label }\n" +
      "  OPTIONAL { ?resource <https://guia.org/gradePercentage> ?label }\n" +
      "  OPTIONAL { ?resource <https://guia.org/minimumScore> ?label }\n" +
      "  OPTIONAL { ?resource <https://guia.org/bibliographyTitle> ?label }\n" +
      "  OPTIONAL { ?resource <https://guia.org/bibliographyDescription> ?label }\n" +
      "  OPTIONAL { ?resource <https://guia.org/previousCourses> ?label }\n" +
      "  OPTIONAL { ?resource <https://guia.org/previousKnowledge> ?label }\n" +

      "  OPTIONAL { ?resource <https://schema.org/name> ?label }\n" +
      "  OPTIONAL { ?resource <https://schema.org/activitiesWorkload> ?label }\n" +
      "  OPTIONAL { ?resource <https://schema.org/description> ?label }\n" +
      "  OPTIONAL { ?resource <https://schema.org/email> ?label }\n" +
      "}\n" +
      "ORDER BY ?label ?resource";

    var json = await runSparql(query);
    var bindings = json.results && json.results.bindings ? json.results.bindings : [];

    allInstances = bindings
      .filter(function(b) { return b.resource && b.resource.value; })
      .map(function(b) {
        var uri = b.resource.value;
        var label = b.label && b.label.value ? b.label.value : humanUriLabel(uri);

        return {
          uri: uri,
          label: label,
          searchBlob: (label + " " + uri).toLowerCase()
        };
      });

    searchInput.disabled = false;
    renderFilteredInstances();
    statusBox.textContent = "Mostrando instancias de " + humanUriLabel(typeUri) + ".";
    setLoading(false);
  }

  function renderInstances(rows) {
    resourcesTableBody.innerHTML = "";

    if (!rows.length) {
      emptyState.style.display = "block";
      instanceCount.textContent = "0";
      return;
    }

    emptyState.style.display = "none";
    instanceCount.textContent = String(rows.length);

    for (var i = 0; i < rows.length; i++) {
      var row = rows[i];
      var tr = document.createElement("tr");

      var html = "";
      html += "<td><a href=\"" + escapeHtml(row.uri) + "\">" + escapeHtml(row.label) + "</a></td>";
      html += "<td><code>" + escapeHtml(humanFullUri(row.uri)) + "</code></td>";
      html += "<td>";
      html += "<a class=\"small-btn resource-btn\" href=\"" + escapeHtml(row.uri) + "\">Open resource</a>";
      html += "<a class=\"small-btn visual-btn\" href=\"/graph?uri=" + encodeURIComponent(row.uri) + "\">Visual Exploration</a>";
      html += "</td>";

      tr.innerHTML = html;
      resourcesTableBody.appendChild(tr);
    }
  }

  function renderFilteredInstances() {
    var search = searchInput.value.trim().toLowerCase();

    if (!search) {
      renderInstances(allInstances);
      return;
    }

    var filtered = allInstances.filter(function(item) {
      return item.searchBlob.indexOf(search) !== -1;
    });

    renderInstances(filtered);
  }

  typeSelect.addEventListener("change", function() {
    loadInstancesOfType(typeSelect.value).catch(function(err) {
      setLoading(false);
      statusBox.textContent = "Error cargando instancias.";
      resourcesTableBody.innerHTML = "";
      emptyState.style.display = "block";
      console.error(err);
    });
  });

  searchInput.addEventListener("input", renderFilteredInstances);

  loadTypes().catch(function(err) {
    setLoading(false);
    typeSelect.innerHTML = "<option value=\"\">Error cargando tipos</option>";
    statusBox.textContent = "No se pudieron recuperar los tipos desde /api/sparql.";
    console.error(err);
  });
</script>

<footer class="footer">
  <div class="footer-inner">
    <span>Powered by</span>
    <a href="https://github.com/helio-ecosystem" target="_blank" rel="noopener noreferrer">
      <img
        class="footer-logo"
        src="https://avatars.githubusercontent.com/u/94366057?s=200&v=4"
        alt="Helio"
      />
    </a>
    <a href="https://github.com/helio-ecosystem/helio-publisher" target="_blank" rel="noopener noreferrer">
      Helio Publisher
    </a>
  </div>
</footer>
</body>
</html>