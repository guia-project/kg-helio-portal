<#assign datasetName = "GUIA Knowledge Graph">
<#assign homePath = "/">
<#assign aboutPath = "/about">
<#assign resourcesPath = "/resources">

<#assign sparqlEndpoint = "/sparql">

<!DOCTYPE html>
<html lang="en">
<head>
    <title>SPARQL - ${datasetName}</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Base imports -->
    <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/jquery/jquery-3.4.0.min.js"></script>
    <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/bootstrap/bootstrap.min.js"></script>
    <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/helio.css" rel="stylesheet">

    <!-- YASQE / YASR imports -->
    <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/yasr/codeMirror/codemirror.css" rel="stylesheet">
    <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/yasr/codeMirror/codemirror.js"></script>

    <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/yasr/pivot/pivot.css" rel="stylesheet">
    <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/yasr/pivot/pivot.min.js"></script>

    <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/yasr/yasr.min.css" rel="stylesheet">
    <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/yasqe/yasqe.min.css" rel="stylesheet">
    <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/yasr/yasr.min.js"></script>
    <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/yasr/yasr.bundled.min.js"></script>
    <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/yasqe/yasqe.bundled.min.js"></script>
    <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/yasqe/yasqe.min.js"></script>

    <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/yasr/dataTables/jquery.dataTables.min.css" rel="stylesheet">
    <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/yasr/dataTables/jquery.dataTables.min.js"></script>
    <link rel="icon" type="image/png" href="https://avatars.githubusercontent.com/u/206107082?s=200&v=4">
    <style>
        body {
            background: #f5f7fa;
            color: #1a1a1a;
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

        .hero {
            background: white;
            padding: 30px;
            margin-top: 25px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .hero h1 {
            margin-top: 0;
            color: #0b3c5d;
        }

        .hero p {
            font-size: 16px;
            line-height: 1.6;
        }

        .hero code {
            background: #eef2f7;
            padding: 2px 6px;
            border-radius: 4px;
        }

        .examples-box,
        .query-box {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .examples-box h3,
        .query-box h3 {
            margin-top: 0;
            color: #0b3c5d;
        }

        .example-button {
            margin-right: 10px;
            margin-bottom: 10px;
            background: #0b3c5d;
            border: none;
            color: white;
            padding: 10px 14px;
            border-radius: 4px;
            cursor: pointer;
        }

        .example-button:hover {
            background: #145374;
        }

        #yasqe-div,
        #yasr-div {
            margin-top: 15px;
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
                <a class="navbar-brand" href="${homePath}">${datasetName}</a>
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

    <main role="main">
        <div class="container">

            <div class="hero">
                <h1>SPARQL Endpoint</h1>
                <p>
                    Esta interfaz permite consultar el <strong>GUIA Knowledge Graph</strong> mediante SPARQL.
                    Puedes escribir tus propias consultas o cargar ejemplos predefinidos.
                </p>
                <p>
                    Endpoint configurado: <code>/api/sparql</code>
                </p>
            </div>

            <div class="examples-box">
                <h3>Consultas de ejemplo</h3>
                <button class="example-button" type="button" onclick="setExample('allTriples')">Ver triples</button>
                <button class="example-button" type="button" onclick="setExample('types')">Listar tipos</button>
                <button class="example-button" type="button" onclick="setExample('countResources')">Contar recursos por tipo</button>
                <button class="example-button" type="button" onclick="setExample('numberOfSubjectsCoordinated')">Asignaturas coordinadas por profesor 2025-26</button>
                <button class="example-button" type="button" onclick="setExample('sharedCompentecies')">Comptentecias compartidas entre asignaturas</button>
                <button class="example-button" type="button" onclick="setExample('compenteciesSameCode')">Mismo codigo de competentecias en distintas asignaturas</button>
                <button class="example-button" type="button" onclick="setExample('listSubjectsProfessors')">Asignaturas y coordinadores del grado CD61</button>
                    
            </div>

            <div class="query-box">
                <h3>Editor de consultas</h3>
                <div id="yasqe-div"></div>
                <div id="yasr-div"></div>
            </div>

        </div>
    </main>

    <script type="text/javascript">
        var endpointPath = "/api/sparql";

        var yasqe = YASQE(document.getElementById("yasqe-div"), {
            value: "SELECT * WHERE {\n  ?s ?p ?o .\n}\nLIMIT 20",
            sparql: {
                showQueryButton: true,
                endpoint: endpointPath,
                requestMethod: "GET"
            }
        });

        var yasr = YASR(document.getElementById("yasr-div"), {
            getUsedPrefixes: yasqe.getPrefixesFromQuery
        });

        yasqe.options.sparql.callbacks.complete = yasr.setResponse;

        var queries = {
            allTriples: "SELECT * WHERE {\n  ?s ?p ?o .\n}\nLIMIT 25",
            types: "SELECT DISTINCT ?type WHERE {\n  ?s a ?type .\n}\nORDER BY ?type",
            countResources: "prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>\n\nSELECT ?type (COUNT(DISTINCT ?instance) AS ?count) WHERE {\n\t?instance rdf:type ?type .\n}  group by ?type",
            numberOfSubjectsCoordinated : "prefix guia: <https://guia.org/>\nprefix sch: <https://schema.org/>\nprefix xsd: <http://www.w3.org/2001/XMLSchema#>\n\nSELECT DISTINCT ?coordinator_name (count(distinct ?course_instance) as ?subjects) WHERE {\n\n\t?person a guia:Lecturer . \n\t?person sch:name ?coordinator_name .\n\t?course_instance sch:director ?person .\n\t?course_instance guia:teachingPeriod ?period .\n\tFILTER( STR(?period) = str('2025-26')) .\n\n} group by ?coordinator_name",
            sharedCompentecies: "prefix guia: <https://guia.org/>\nprefix sch: <https://schema.org/>\n\nSELECT DISTINCT ?competency_code ?lecture_name1 ?lecture_name2 WHERE {\n\t?lecture1 a guia:Course . \n\t?lecture1 sch:name ?lecture_name1 .\n\t?lecture1 sch:hasCourseInstance ?course_instance1 .\n\t?course_instance1 guia:teachingPeriod '2025-26' .\n\t?course_instance1 guia:hasCompetency ?competency1 .\n\t?competency1 guia:competencyCode ?competency_code .\n   \n\t?lecture2 a guia:Course . \n\t?lecture2 sch:name ?lecture_name2 .\n\t?lecture2 sch:hasCourseInstance ?course_instance2 .\n\t?course_instance2 guia:teachingPeriod '2025-26' .\n\t?course_instance2 guia:hasCompetency ?competency2 .\n\t?competency2 guia:competencyCode ?competency_code .\n   \n\tFILTER(?competency1!=?competency2)\n\tFILTER(LANG(?lecture_name1) = 'es' && LANG(?lecture_name2) = 'es')\n\n} LIMIT 100",
            "compenteciesSameCode" : "PREFIX guide: <https://guia.org/>\nprefix guia: <https://guia.org/>\nprefix sch: <https://schema.org/>\n\nSELECT DISTINCT ?competency_code (count(distinct ?lecture) as ?count) WHERE {\n\t?lecture a guia:Course . \n\t?lecture sch:hasCourseInstance ?course_instance .\n\t?course_instance guia:teachingPeriod ?period .\n\t?course_instance guia:hasCompetency ?competency .\n\t?competency guide:competencyCode ?competency_code\n\tFILTER(STR(?period) = '2025-26')\n}group by ?competency_code",
            "listSubjectsProfessors": "\nprefix guia: <https://guia.org/>\nprefix sch: <https://schema.org/>\nprefix xsd: <http://www.w3.org/2001/XMLSchema#>\n\nSELECT DISTINCT ?lecture_name ?lecturer_name  WHERE {\n\t?person a guia:Lecturer .\n\t?person sch:name ?lecturer_name .\n \t?person sch:email ?email .\n\t?course_instance sch:director ?person .\n\t?course_instance guia:teachingPeriod ?period .\n\t?lecture sch:name ?lecture_name .\n\t?lecture sch:hasCourseInstance ?course_instance .\n\t?degree guia:hasCourse ?lecture .\n\tFILTER( STR(?period) = str('2025-26')) .\n\tFILTER( lang(?lecture_name) = 'es' ) .\n\tVALUES ?degree { <https://guia-kg.skai.etsisi.upm.es/resource/61CD%20-%20Grado%20en%20Ciencia%20de%20Datos%20e%20Inteligencia%20Artificial> } \n\n}"
        };

        function setExample(key) {
            if (queries[key]) {
                yasqe.setValue(queries[key]);
            }
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