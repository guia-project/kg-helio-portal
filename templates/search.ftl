<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Graph Search - GUIA Knowledge Graph</title>

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

    * { box-sizing: border-box; }

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
      max-width: 1280px;
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

    h1, h2, h3 {
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
      grid-template-columns: 2fr auto;
      gap: 12px;
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
    .field textarea,
    .field select {
      border: 1px solid var(--line);
      border-radius: 10px;
      padding: 10px 12px;
      font-size: 14px;
      background: white;
    }

    textarea {
      min-height: 110px;
      resize: vertical;
    }

    .btn-guia {
      background: #0b3c5d;
      color: white;
      border: none;
      border-radius: 8px;
      padding: 10px 14px;
      cursor: pointer;
      height: 42px;
    }

    .btn-guia:hover {
      background: #145374;
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
      margin-top: 6px;
    }

    .small-btn:hover {
      text-decoration: none;
      background: #f8fafc;
    }

    .status {
      margin-top: 10px;
      color: var(--muted);
      font-size: 14px;
    }

    .grid {
      display: grid;
      grid-template-columns: 1fr 1.4fr;
      gap: 18px;
    }

    .candidate-list {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    .candidate-item {
      border: 1px solid var(--line);
      border-radius: 10px;
      padding: 12px;
      margin-bottom: 10px;
      background: #fafafa;
      cursor: pointer;
    }

    .candidate-item:hover {
      border-color: #cbd5e1;
      background: #ffffff;
    }

    .candidate-item.selected {
      border-color: #93c5fd;
      background: #eff6ff;
    }

    .candidate-title {
      font-weight: bold;
      color: var(--accent);
      margin-bottom: 4px;
    }

    .candidate-uri {
      font-family: monospace;
      font-size: 12px;
      color: var(--muted);
      word-break: break-all;
    }

    .candidate-meta {
      font-size: 12px;
      color: var(--muted);
      margin-top: 6px;
    }

    .mono-box {
      background: #fbfbfd;
      border: 1px solid var(--line);
      border-radius: 10px;
      padding: 12px;
      font-family: monospace;
      font-size: 13px;
      white-space: pre-wrap;
      word-break: break-word;
      overflow-x: auto;
    }

    .summary-pills {
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
      margin-top: 12px;
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

    .pill.ok {
      color: var(--ok);
      background: var(--ok-bg);
    }

    .table-wrap {
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      min-width: 980px;
    }

    th, td {
      text-align: left;
      border-bottom: 1px solid var(--line);
      padding: 10px 8px;
      vertical-align: top;
      font-size: 14px;
    }

    th {
      background: #fafafa;
    }

    td code {
      font-family: monospace;
      font-size: 12px;
      word-break: break-word;
    }

    .triple-kind {
      display: inline-block;
      font-size: 12px;
      font-weight: bold;
      padding: 4px 8px;
      border-radius: 999px;
      white-space: nowrap;
    }

    .kind-out {
      background: var(--accent-soft);
      color: var(--accent);
    }

    .kind-in {
      background: var(--warn-bg);
      color: var(--warn);
    }

    .empty {
      color: var(--muted);
      padding: 10px 0;
    }

    a {
      color: var(--accent);
      text-decoration: none;
    }

    a:hover {
      text-decoration: underline;
    }

    @media (max-width: 1000px) {
      .controls,
      .grid {
        grid-template-columns: 1fr;
      }

      .page-wrap {
        padding: 14px;
      }
    }

    .small-btn.visual-btn {
      background: #dcfce7;
      color: #166534;
      border-color: #86efac;
    }

    .small-btn.visual-btn:hover {
      background: #bbf7d0;
      color: #166534;
    }

    .small-btn.resource-btn {
      background: #ffedd5;
      color: #9a3412;
      border-color: #fdba74;
    }

    .small-btn.resource-btn:hover {
      background: #fed7aa;
      color: #9a3412;
    }
  </style>
  <!-- Footer Style -->
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
      <h1>Búsqueda libre sobre el Knowledge Graph</h1>
      <p class="muted">
        Escribe una consulta en lenguaje natural. La interfaz buscará entidades del grafo de datos y te sugerirá recursos relevantes. Después podrás inspeccionar sus tripletas y abrirlas en el visualizador gráfico.
      </p>
    </div>

    <div class="card">
      <div class="field" style="margin-bottom: 12px;">
        <label for="questionInput">Consulta</label>
        <textarea id="questionInput" placeholder="Ejemplo: que asignaturas coordina elena roibas"></textarea>
      </div>

      <div class="controls">
        <div class="field">
          <label for="maxCandidatesInput">Máximo de sugerencias</label>
          <input id="maxCandidatesInput" type="text" value="15" />
        </div>
        <button id="searchBtn" class="btn-guia" type="button">Buscar</button>
      </div>

      <div id="statusBox" class="status">Esperando una consulta.</div>
      <div class="summary-pills">
        <span class="pill total">Candidatos: <span id="candidateCount" style="margin-left:6px;">0</span></span>
        <span class="pill ok">Tripletas: <span id="tripleCount" style="margin-left:6px;">0</span></span>
      </div>
    </div>

    <div class="grid">
      <div class="card">
        <h2>Entidades sugeridas</h2>
        <ul id="candidatesBox" class="candidate-list">
          <li class="empty">Todavía no hay sugerencias.</li>
        </ul>
      </div>

      <div class="card">
        <h2>Entidad seleccionada</h2>
        <div id="selectedEntityBox" class="mono-box">No hay entidad seleccionada.</div>
        <div style="margin-top: 10px;">
          <a id="resourceLink" class="small-btn resource-btn" href="#" style="display:none;">Open resource</a>
          <a id="graphLink" class="small-btn visual-btn" href="#" style="display:none;">Visual Exploration</a>
        </div>
      </div>
    </div>

    <div class="card">
      <h2>Consulta SPARQL usada para sugerencias</h2>
      <div id="sparqlBox" class="mono-box">Aún no se ha generado ninguna consulta.</div>
    </div>

    <div class="card">
      <h2>Tripletas del recurso</h2>
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>Dirección</th>
              <th>Sujeto</th>
              <th>Predicado</th>
              <th>Objeto</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody id="triplesTableBody"></tbody>
        </table>
      </div>
      <div id="triplesEmpty" class="empty">Selecciona una entidad para ver sus tripletas.</div>
    </div>

  </div>
</div>

<script>
  var SPARQL_ENDPOINT = "/api/sparql";
  var DATA_GRAPH = "https://guia-kg.skai.etsisi.upm.es/data";

  var questionInput = document.getElementById("questionInput");
  var maxCandidatesInput = document.getElementById("maxCandidatesInput");
  var searchBtn = document.getElementById("searchBtn");

  var statusBox = document.getElementById("statusBox");
  var candidateCount = document.getElementById("candidateCount");
  var tripleCount = document.getElementById("tripleCount");

  var candidatesBox = document.getElementById("candidatesBox");
  var selectedEntityBox = document.getElementById("selectedEntityBox");
  var resourceLink = document.getElementById("resourceLink");
  var graphLink = document.getElementById("graphLink");

  var sparqlBox = document.getElementById("sparqlBox");
  var triplesTableBody = document.getElementById("triplesTableBody");
  var triplesEmpty = document.getElementById("triplesEmpty");

  var currentCandidates = [];
  var currentSelectedUri = "";

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
      return safeDecode(url.hostname + path + (url.hash || "")).replace(/_/g, " ");
    } catch (e) {
      var hashIndex = uri.lastIndexOf("#");
      if (hashIndex >= 0 && hashIndex < uri.length - 1) {
        return safeDecode(uri.substring(hashIndex + 1)).replace(/_/g, " ");
      }
      var slashIndex = uri.lastIndexOf("/");
      if (slashIndex >= 0 && slashIndex < uri.length - 1) {
        return safeDecode(uri.substring(slashIndex + 1)).replace(/_/g, " ");
      }
      return safeDecode(uri).replace(/_/g, " ");
    }
  }

  function normalizeText(value) {
    return (value || "")
      .toLowerCase()
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "");
  }

  function escapeRegex(str) {
    return String(str).replace(/[$()*+.?[\\\]^{|}]/g, "\\$&");
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

  function extractKeywords(question) {
    var stopwords = {
      "de": true, "la": true, "el": true, "los": true, "las": true, "un": true, "una": true,
      "y": true, "o": true, "en": true, "del": true, "al": true, "que": true, "qué": true,
      "cual": true, "cuál": true, "cuales": true, "cuáles": true, "como": true, "cómo": true,
      "para": true, "por": true, "con": true, "sin": true, "sobre": true, "esta": true,
      "este": true, "estos": true, "estas": true, "the": true, "and": true, "for": true,
      "from": true, "that": true, "those": true, "these": true, "are": true, "is": true,
      "coordina": true, "coordinan": true, "coordinar": true, "asignaturas": false
    };

    var parts = normalizeText(question).split(/[^a-zA-Z0-9áéíóúñü]+/).filter(Boolean);
    var keywords = [];

    for (var i = 0; i < parts.length; i++) {
      var token = parts[i];
      if (token.length < 3) continue;
      if (stopwords[token] === true) continue;
      if (keywords.indexOf(token) === -1) {
        keywords.push(token);
      }
    }

    return keywords.slice(0, 6);
  }

  function parseMaxCandidates() {
    var raw = parseInt(maxCandidatesInput.value, 10);
    if (isNaN(raw) || raw <= 0) {
      return 15;
    }
    return Math.min(raw, 50);
  }

  function buildCandidateQuery(keywords, limit) {
    if (!keywords.length) {
      return null;
    }

    var regexes = [];
    for (var i = 0; i < keywords.length; i++) {
      regexes.push('regex(lcase(str(?label)), "' + escapeRegex(keywords[i]) + '", "i")');
    }

    return (
      "SELECT DISTINCT ?entity ?label WHERE {\n" +
      "  GRAPH <" + DATA_GRAPH + "> {\n" +
      "    VALUES ?lp {\n" +
      "      <http://www.w3.org/2000/01/rdf-schema#label>\n" +
      "      <https://schema.org/name>\n" +
      "      <https://schema.org/email>\n" +
      "    }\n" +
      "    ?entity ?lp ?label .\n" +
      "    FILTER(isLiteral(?label))\n" +
      "    FILTER(" + regexes.join(" || ") + ")\n" +
      "  }\n" +
      "}\n" +
      "LIMIT " + limit
    );
  }

  function scoreCandidate(uri, label, keywords) {
    var haystack = normalizeText((label || "") + " " + (uri || ""));
    var score = 0;

    for (var i = 0; i < keywords.length; i++) {
      if (haystack.indexOf(keywords[i]) !== -1) {
        score += 1;
      }
    }

    if (label && label.length < 100) {
      score += 0.2;
    }

    if (uri && uri.indexOf("/resource/") !== -1) {
      score += 0.3;
    }

    return score;
  }

  async function searchCandidates(question) {
    var keywords = extractKeywords(question);
    var limit = parseMaxCandidates();
    var query = buildCandidateQuery(keywords, limit);

    if (!query) {
      return {
        query: "",
        keywords: keywords,
        candidates: []
      };
    }

    var json = await runSparql(query);
    var bindings = (json.results && json.results.bindings) ? json.results.bindings : [];

    var seen = {};
    var candidates = [];

    for (var i = 0; i < bindings.length; i++) {
      var b = bindings[i];
      if (!b.entity || !b.label) continue;

      var uri = b.entity.value;
      if (seen[uri]) continue;
      seen[uri] = true;

      candidates.push({
        uri: uri,
        label: b.label.value,
        score: scoreCandidate(uri, b.label.value, keywords)
      });
    }

    candidates.sort(function(a, b) {
      return b.score - a.score;
    });

    return {
      query: query,
      keywords: keywords,
      candidates: candidates
    };
  }

  function buildTriplesQuery(uri) {
    return (
      "SELECT ?direction ?s ?p ?o WHERE {\n" +
      "  GRAPH <" + DATA_GRAPH + "> {\n" +
      "    {\n" +
      "      BIND(\"out\" AS ?direction)\n" +
      "      BIND(<" + uri + "> AS ?s)\n" +
      "      <" + uri + "> ?p ?o .\n" +
      "    }\n" +
      "    UNION\n" +
      "    {\n" +
      "      BIND(\"in\" AS ?direction)\n" +
      "      ?s ?p <" + uri + "> .\n" +
      "      BIND(<" + uri + "> AS ?o)\n" +
      "    }\n" +
      "  }\n" +
      "}\n" +
      "LIMIT 150"
    );
  }

  async function loadTriplesForEntity(uri) {
    var query = buildTriplesQuery(uri);
    var json = await runSparql(query);
    var bindings = (json.results && json.results.bindings) ? json.results.bindings : [];

    var triples = [];
    for (var i = 0; i < bindings.length; i++) {
      var b = bindings[i];
      if (!b.s || !b.p || !b.o) continue;

      triples.push({
        direction: b.direction ? b.direction.value : "out",
        s: b.s.value,
        p: b.p.value,
        o: b.o.value,
        oType: b.o.type ? b.o.type : "literal"
      });
    }

    return {
      query: query,
      triples: triples
    };
  }

  function renderCandidates(candidates) {
    currentCandidates = candidates || [];
    candidateCount.textContent = currentCandidates.length;
    candidatesBox.innerHTML = "";

    if (!currentCandidates.length) {
      candidatesBox.innerHTML = '<li class="empty">No se han encontrado entidades candidatas.</li>';
      return;
    }

    for (var i = 0; i < currentCandidates.length; i++) {
      (function(candidate) {
        var li = document.createElement("li");
        li.className = "candidate-item" + (candidate.uri === currentSelectedUri ? " selected" : "");

        var html = "";
        html += '<div class="candidate-title">' + escapeHtml(candidate.label) + '</div>';
        html += '<div class="candidate-uri">' + escapeHtml(candidate.uri) + '</div>';
        html += '<div class="candidate-meta">score: ' + escapeHtml(String(candidate.score)) + '</div>';

        li.innerHTML = html;
        li.addEventListener("click", function() {
          selectCandidate(candidate);
        });

        candidatesBox.appendChild(li);
      })(currentCandidates[i]);
    }
  }

  function renderSelectedEntity(uri) {
    currentSelectedUri = uri || "";

    if (!uri) {
      selectedEntityBox.textContent = "No hay entidad seleccionada.";
      resourceLink.style.display = "none";
      graphLink.style.display = "none";
      return;
    }

    selectedEntityBox.textContent = uri;
    resourceLink.href = uri;
    graphLink.href = "/graph?uri=" + encodeURIComponent(uri);

    resourceLink.style.display = "inline-block";
    graphLink.style.display = "inline-block";

    renderCandidates(currentCandidates);
  }

  function renderTriples(triples) {
    triplesTableBody.innerHTML = "";
    tripleCount.textContent = triples.length;

    if (!triples.length) {
      triplesEmpty.style.display = "block";
      return;
    }

    triplesEmpty.style.display = "none";

    for (var i = 0; i < triples.length; i++) {
      var t = triples[i];
      var tr = document.createElement("tr");

      var directionBadge = t.direction === "in"
        ? '<span class="triple-kind kind-in">incoming</span>'
        : '<span class="triple-kind kind-out">outgoing</span>';

      var subjectHtml = '<code>' + escapeHtml(t.s) + '</code>';
      var predicateHtml = '<code>' + escapeHtml(t.p) + '</code>';
      var objectHtml = '<code>' + escapeHtml(t.o) + '</code>';

      var actionsHtml = '';
      if (t.s && t.s.indexOf("http") === 0) {
        actionsHtml += '<a class="small-btn" href="/graph?uri=' + encodeURIComponent(t.s) + '">Graph subject</a>';
      }
      if (t.oType === "uri" && t.o && t.o.indexOf("http") === 0) {
        actionsHtml += '<a class="small-btn" href="/graph?uri=' + encodeURIComponent(t.o) + '">Graph object</a>';
      }
      if (currentSelectedUri) {
        actionsHtml += '<a class="small-btn" href="/graph?uri=' + encodeURIComponent(currentSelectedUri) + '">Visual Exploration</a>';
      }

      tr.innerHTML =
        '<td>' + directionBadge + '</td>' +
        '<td>' + subjectHtml + '</td>' +
        '<td>' + predicateHtml + '</td>' +
        '<td>' + objectHtml + '</td>' +
        '<td>' + actionsHtml + '</td>';

      triplesTableBody.appendChild(tr);
    }
  }

  async function selectCandidate(candidate) {
    if (!candidate || !candidate.uri) {
      return;
    }

    statusBox.textContent = "Cargando tripletas del recurso seleccionado...";
    renderSelectedEntity(candidate.uri);
    sparqlBox.textContent = buildTriplesQuery(candidate.uri);
    renderTriples([]);

    try {
      var result = await loadTriplesForEntity(candidate.uri);
      sparqlBox.textContent = result.query;
      renderTriples(result.triples);
      statusBox.textContent = "Tripletas cargadas para " + compactUri(candidate.uri) + ".";
    } catch (err) {
      console.error("Error loading triples:", err);
      statusBox.textContent = "Error cargando tripletas: " + err.message;
      renderTriples([]);
    }
  }

  async function runSearch() {
    var question = questionInput.value.trim();

    if (!question) {
      statusBox.textContent = "Escribe una consulta.";
      return;
    }

    statusBox.textContent = "Buscando entidades candidatas en el grafo de datos...";
    renderSelectedEntity("");
    renderTriples([]);
    sparqlBox.textContent = "Generando consulta...";
    candidatesBox.innerHTML = '<li class="empty">Buscando...</li>';
    candidateCount.textContent = "0";
    tripleCount.textContent = "0";

    var result = await searchCandidates(question);
    console.log("Candidate search result:", result);

    sparqlBox.textContent = result.query || "No se pudo generar la consulta.";
    renderCandidates(result.candidates);

    if (!result.candidates.length) {
      statusBox.textContent = "No se encontraron entidades candidatas.";
      return;
    }

    statusBox.textContent = "Se han encontrado " + result.candidates.length + " entidades candidatas.";
    selectCandidate(result.candidates[0]);
  }

  searchBtn.addEventListener("click", function() {
    console.log("SEARCH BUTTON CLICKED");
    runSearch().catch(function(err) {
      console.error("Search ERROR:", err);
      statusBox.textContent = "Error: " + err.message;
    });
  });

  questionInput.addEventListener("keydown", function(e) {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      searchBtn.click();
    }
  });

  var params = new URLSearchParams(window.location.search);
  var initialUri = params.get("uri") || "";
  var initialQ = params.get("q") || "";

  if (initialQ) {
    questionInput.value = initialQ;
  }

  if (initialUri) {
    var syntheticCandidate = {
      uri: initialUri,
      label: compactUri(initialUri),
      score: 1
    };
    renderCandidates([syntheticCandidate]);
    selectCandidate(syntheticCandidate);
  }
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