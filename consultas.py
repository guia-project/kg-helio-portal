
import os
import time
import requests

# Directorio base desde variable de entorno
OUTPUT_DIR = os.getenv("OUTPUT_DIR", "./resultados")

# Crear carpeta si no existe
os.makedirs(OUTPUT_DIR, exist_ok=True)

# Timestamp único para toda la ejecución
EXECUTION_TS = str(int(time.time() * 1000))

ENDPOINT = "https://guia-kg.skai.etsisi.upm.es/api/sparql"

PREFIXES = """

PREFIX guide: <https://guia.org/>
PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#>
PREFIX sch:  <https://schema.org/>
PREFIX owl:   <http://www.w3.org/2002/07/owl#>

"""


def run_query(query: str):
    full_query = PREFIXES + query

    r = requests.get(
        ENDPOINT,
        params={"query": full_query},
        headers={"Accept": "application/sparql-results+json"},
        timeout=30
    )

    if r.status_code != 200:
        print("Error HTTP:", r.status_code)
        print(r.text[:2000])
        r.raise_for_status()

    try:
        data = r.json()
    except Exception:
        print("Respuesta no JSON:")
        print(r.text[:2000])
        raise

    return data["results"]["bindings"]


##############################################
# 1. Evaluación dual (continua | global | extraordinaria)
##############################################
def check_dual_evaluation():
    query = """
    SELECT DISTINCT ?guide ?course ?degree
       (GROUP_CONCAT(DISTINCT STR(?etype); separator=",") AS ?types)
    WHERE {
        ?guide rdf:type guide:CourseGuide .
        ?guide guide:hasEvaluation ?evalSys .
        ?evalSys guide:hasEvaluationTrial ?trial .
        ?trial guide:evaluationType ?etype .
    
        ?guide ^sch:hasCourseInstance ?course .
        ?degree guide:hasCourse ?course .
    
        FILTER NOT EXISTS { ?degree rdf:type guide:MasterDegree . }
    }
    GROUP BY ?guide ?course ?degree
    """
    
    rows = run_query(query)
    results = []

    for row in rows:
        guide = row["guide"]["value"]
        types_raw = row.get("types", {}).get("value", "")
        types = {t.strip() for t in types_raw.split(",") if t.strip()}

        if not ("progressiva" in types and "global" in types):
            results.append({
                "guide": {"value": guide},
                "types": {"value": ", ".join(sorted(types))}
            })

    return results


##############################################
# 2. Peso total = 100%   REVISAR
##############################################
def check_total_weight():
    query = """
    


SELECT ?evalSys (SUM(xsd:decimal(REPLACE(STR(?weight), "[^0-9.]", ""))) AS ?totalProgresiva)
WHERE {
    # 1. Buscamos el sistema de evaluación y unificamos con owl:sameAs
    ?evalSys rdf:type guide:EvaluationSystem .
    ?evalSys owl:sameAs* ?actualEvalSys .
    ?actualEvalSys guide:hasEvaluationTrial ?trial .
    
    # 2. Nos quedamos solo con las actividades progresivas
    ?trial guide:evaluationType ?type .
    FILTER(CONTAINS(LCASE(STR(?type)), "progresiv")) 
    
    # 3. Extraemos el porcentaje en formato texto
    ?trial guide:gradePercentage ?weight .
}
GROUP BY ?evalSys
# 4. FILTRO DE AGREGACIÓN: Solo muestra los que no sumen exactamente 100
HAVING (SUM(xsd:decimal(REPLACE(STR(?weight), "[^0-9.]", ""))) != 100)
    """
    return run_query(query)


##############################################
# 3. Extraordinaria = 100%
##############################################
def check_extraordinary_weight():
    query = """
    SELECT ?evalSys (SUM(xsd:decimal(REPLACE(STR(?weight), "[^0-9.]", ""))) AS ?totalExtraordinaria)
WHERE {
    # 1. Buscamos el sistema de evaluación y unificamos con owl:sameAs
    ?evalSys rdf:type guide:EvaluationSystem .
    ?evalSys owl:sameAs* ?actualEvalSys .
    ?actualEvalSys guide:hasEvaluationTrial ?trial .
    
    # 2. FILTRO: Nos quedamos solo con la convocatoria extraordinaria
    ?trial guide:evaluationType ?type .
    FILTER(CONTAINS(LCASE(STR(?type)), "extraordinar")) 
    
    # 3. Extraemos el porcentaje en formato texto
    ?trial guide:gradePercentage ?weight .
}
GROUP BY ?evalSys
# 4. Filtramos los sistemas que NO sumen exactamente 100%
HAVING (SUM(xsd:decimal(REPLACE(STR(?weight), "[^0-9.]", ""))) != 100)
    """
    return run_query(query)


##############################################
# 4. Semanas prohibidas (11 y 7)
##############################################
def check_forbidden_weeks():
    query = """
    SELECT ?trial ?week
    WHERE {
        ?trial rdf:type guide:EvaluationTrial .
        ?trial guide:trialWeek ?week .
        FILTER(STR(?week) IN ("11", "7"))
    }
    """
    return run_query(query)


##############################################
# 5. Cobertura de competencias
##############################################
def check_competencies():
    query = """
    SELECT DISTINCT ?guide ?competency
    WHERE {
        ?guide rdf:type guide:CourseGuide .
        ?guide guide:hasCompetency ?competency .

        FILTER NOT EXISTS {
            ?guide guide:hasEvaluation ?evalSys .
            ?evalSys guide:hasEvaluationTrial ?trial .
            ?trial guide:involvesCompetency ?competency .
        }
    }
    """
    return run_query(query)



##############################################
# 6. Cronograma vacío o inexistente
##############################################
def check_empty_schedule():
    """
    Detecta CourseGuides sin estructura mínima de cronograma:
    - no tienen schedule
    - o el schedule no tiene eventos
    """
    query = """
    PREFIX sch: <https://schema.org/>
    PREFIX guide: <https://guia.org/>
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

    SELECT DISTINCT ?guide
    WHERE {
        ?guide rdf:type guide:CourseGuide .

        FILTER NOT EXISTS {
            ?guide sch:courseSchedule ?schedule .
            ?schedule sch:eventSchedule ?event .
        }
    }
    """
    return run_query(query)
##############################################
# 7. Eventos sin contenido real
##############################################
def check_empty_events():
    query = """
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX guide: <https://guia.org/>

    SELECT DISTINCT ?guide ?event
    WHERE {
        ?guide rdf:type guide:CourseGuide ;
               <https://schema.org/courseSchedule> ?schedule .

        ?schedule <https://schema.org/eventSchedule> ?event .

        FILTER NOT EXISTS {
            ?event ?p ?o .
            FILTER(?p != rdf:type)
        }
    }
    """
    return run_query(query)



def check_resultados_aprendizaje():
    return run_query("""
        SELECT DISTINCT ?guide WHERE { 
            ?guide rdf:type guide:CourseGuide ; guide:publishedAt ?url . 
            FILTER NOT EXISTS { ?guide guide:hasLearningResult ?l } 
        }""")


# 3. Recursos didácticos
def check_recursos_didacticos():
    return run_query("""
        SELECT DISTINCT ?guide WHERE { 
            ?guide rdf:type guide:CourseGuide ; guide:publishedAt ?url . 
            FILTER NOT EXISTS { ?guide guide:hasDidacticResource ?r } 
        }""")

# 4. Horario de Tutorías (Incluye filtro de Grado y PublishedAt)
def check_horario_tutorias():
    return run_query("""
        SELECT DISTINCT ?degree ?guide ?lecturer WHERE {
            ?guide rdf:type guide:CourseGuide ; guide:publishedAt ?url .
            ?course sch:hasCourseInstance ?guide .
            ?degree guide:hasCourse ?course .
            FILTER NOT EXISTS { ?degree rdf:type guide:MasterDegree }
            ?guide (sch:instructor | sch:director) ?lecturer .
            FILTER NOT EXISTS { ?lecturer guide:tutorshipsSchedule ?s }
        }""")



# 6. Idioma de la evaluación
def check_idioma_evaluacion():
    return run_query("""
        SELECT DISTINCT ?guide WHERE { 
            ?guide rdf:type guide:CourseGuide ; guide:publishedAt ?url . 
            FILTER NOT EXISTS { ?guide sch:inLanguage ?i } 
        }""")

# 7. Porcentaje de calificación (Une la prueba con guía publicada)
def check_porcentaje_calificacion():
    return run_query("""
        SELECT DISTINCT ?guide ?trial WHERE { 
            ?guide guide:publishedAt ?url ; guide:hasEvaluation ?e .
            ?e guide:hasEvaluationTrial ?trial .
            FILTER NOT EXISTS { ?trial guide:gradePercentage ?p } 
        }""")

# 8. Competencias
def check__existen_competencias():
    return run_query("""
        SELECT DISTINCT ?guide WHERE { 
            ?guide rdf:type guide:CourseGuide ; guide:publishedAt ?url . 
            FILTER NOT EXISTS { ?guide guide:hasCompetency ?c } 
        }""")

# 9. Créditos ECTS
def check_numero_creditos():
    return run_query("""
        SELECT DISTINCT ?guide WHERE { 
            ?guide rdf:type guide:CourseGuide ; guide:publishedAt ?url . 
            FILTER NOT EXISTS { ?guide guide:numberOfCredits ?n } 
        }""")

# 10. Tipo de asignatura (Une el curso con su guía publicada)
def check_tipo_asignatura():
    return run_query("""
        SELECT DISTINCT ?course WHERE { 
            ?course rdf:type guide:Course . 
            ?course sch:hasCourseInstance ?guide . ?guide guide:publishedAt ?url .
            FILTER NOT EXISTS { ?course guide:courseType ?t } 
        }""")

# 11. Periodo de impartición
def check_periodo_imparticion():
    return run_query("""
        SELECT DISTINCT ?guide WHERE { 
            ?guide rdf:type guide:CourseGuide ; guide:publishedAt ?url . 
            FILTER NOT EXISTS { ?guide guide:teachingPeriod ?p } 
        }""")

# 12. Modalidad de impartición
def check_modalidad_imparticion():
    return run_query("""
        SELECT DISTINCT ?guide WHERE { 
            ?guide rdf:type guide:CourseGuide ; guide:publishedAt ?url . 
            FILTER NOT EXISTS { ?guide guide:modeOfDelivery ?m } 
        }""")

##############################################
# 15. Evaluación en las primeras dos semanas (14 días)
# "Ninguna actividad de evaluación... antes de 14 días (semanas 1 y 2)"
##############################################
def check_evaluacion_primeras_semanas():
    query = """
    SELECT DISTINCT ?guide ?trial ?week ?etype
    WHERE {
        ?guide rdf:type guide:CourseGuide .
        ?guide guide:hasEvaluation ?evalSys .
        ?evalSys guide:hasEvaluationTrial ?trial .
        
        # Obtenemos la semana de la prueba
        ?trial guide:trialWeek ?week .
        
        # Opcional: obtener el tipo para mostrarlo en el resultado
        OPTIONAL { ?trial guide:evaluationType ?etype }
        
        # Filtramos si está en la semana 1 o 2
        FILTER(STR(?week) IN ("1", "2"))
    }
    """
    return run_query(query)

##############################################
# 13. Peso de la evaluación global (mínimo 60%)
# "El peso de la evaluación global debe ser al menos del 60"
##############################################
def check_peso_evaluacion_global():
    query = """
    SELECT ?guide ?publishedAt ?evalSys (SUM(xsd:decimal(REPLACE(STR(?weight), "[^0-9.]", ""))) AS ?total_global)
WHERE {
    # 1. Buscamos la guía y su sistema de evaluación
    ?guide rdf:type guide:CourseGuide ;
           guide:publishedAt ?publishedAt ;
           guide:hasEvaluation ?evalSys .

    # 2. Unificamos el sistema de evaluación con owl:sameAs* por si acaso
    ?evalSys owl:sameAs* ?actualEvalSys .
    ?actualEvalSys guide:hasEvaluationTrial ?trial .

    # 3. Filtramos de forma flexible para capturar "global", "Evaluación Global", etc.
    ?trial guide:evaluationType ?etype .
    FILTER(CONTAINS(LCASE(STR(?etype)), "global"))

    # 4. Extraemos el porcentaje y limpiamos cualquier carácter que no sea numérico
    ?trial guide:gradePercentage ?weight .
}
GROUP BY ?guide ?publishedAt ?evalSys
# 5. Filtramos los que tengan menos del 60% en la evaluación global
HAVING (SUM(xsd:decimal(REPLACE(STR(?weight), "[^0-9.]", ""))) < 60)
    """
    return run_query(query)

##############################################
# 14. Conflicto semanas 16 y 17 (Exámenes)
# "Si existe la semana 17, se dejará en blanco la semana 16..."
##############################################
def check_conflicto_semanas_examenes():
    # Detecta guías que tienen evaluación en la semana 16 a pesar de tener también actividades en la semana 17
    query = """
    SELECT DISTINCT ?guide
    WHERE {
        ?guide rdf:type guide:CourseGuide .
        ?guide guide:hasEvaluation ?evalSys .
        
        # Prueba en semana 16
        ?evalSys guide:hasEvaluationTrial ?trial16 .
        ?trial16 guide:trialWeek "16" .
        
        # Prueba en semana 17 (indicando que la 17 existe)
        ?evalSys guide:hasEvaluationTrial ?trial17 .
        ?trial17 guide:trialWeek "17" .
    }
    """
    return run_query(query)


# 

# Para ejecutarlo:
# 

##############################################
# Impresión amigable
##############################################
def print_results(title, rows):
    filename = f"{normalize_title(title)}_{EXECUTION_TS}.txt"
    filepath = os.path.join(OUTPUT_DIR, filename)

    with open(filepath, "w", encoding="utf-8") as f:
        f.write(f"=== {title} ===\n")

        if not rows:
            f.write("OK\n")
        else:
            for row in rows:
                simple = {k: v["value"] for k, v in row.items()}
                f.write(str(simple) + "\n")

    print(f"[OK] Resultado guardado en: {filepath}")


import unicodedata

def normalize_title(title: str) -> str:
    title = title.strip().lower().replace(" ", "_")
    return ''.join(
        c for c in unicodedata.normalize('NFD', title)
        if unicodedata.category(c) != 'Mn'
    )



##############################################
# EJECUCIÓN
##############################################
print_results("Evaluación dual", check_dual_evaluation())
print_results("Peso total", check_total_weight())
print_results("Extraordinaria", check_extraordinary_weight())
print_results("Semanas prohibidas", check_forbidden_weeks())
print_results("Competencias", check_competencies())
print_results("Cronograma vacío", check_empty_schedule())
print_results("Eventos sin actividad", check_empty_events())
print_results("horario tutorias", check_horario_tutorias())
print_results("idioma de evaluacion",check_idioma_evaluacion())
print_results("modalidad de imparticion",check_modalidad_imparticion())
print_results("numero de creditos",check_numero_creditos())
print_results("tipo asignatura",check_tipo_asignatura())
print_results("incluye porcentajes",check_porcentaje_calificacion())
print_results("recursos didácticos",check_recursos_didacticos())
print_results("resultados de aprendizaje",check_resultados_aprendizaje())
print_results("incluye competencias", check__existen_competencias())
print_results("Pruebas en las primeras 2 semanas", check_evaluacion_primeras_semanas())
print_results("Peso Evaluacion Global Menor a 60", check_peso_evaluacion_global())
print_results("Conflicto Semanas 16 y 17", check_conflicto_semanas_examenes())