# 🧾 Trabajo de Replicación – Impacto de la Certificación de Café en Etiopía

**Facultad de Ciencias Sociales – PUCP**
**Curso: Econometria Micro **

Este repositorio contiene el trabajo de replicación del artículo:

**Jena, P. R., Chichaibelu, B. B., Stellmacher, T., & Grote, U. (2012)**
*The impact of coffee certification on small-scale producers’ livelihoods: a case study from the Jimma Zone, Ethiopia*. Agricultural Economics, 43(4), 429–440.
📄 [DOI: 10.1111/j.1574-0862.2012.00594.x](https://doi.org/10.1111/j.1574-0862.2012.00594.x)

## 👥 Integrantes del grupo

* **Zarit Dafra de la Cruz Lavado**
* **Angelly Gutiérrez Sánchez**

---

## 📁 Estructura del Repositorio

```
REPLICATION_EXERCISE/
├── ARTICLE/                   # Paper original replicado
│   └── jena2012.pdf
│
├── CODE/
│   ├── Replication file.do   # Código principal reproducido y comentado
│   └── data/
│       ├── Codes-Agecon.do   # Código fuente original (autores)
│       ├── data-Agecon.dta   # Base de datos
│
├── GRAPH AND TABLES/         # Figuras y tablas replicadas (JPG)
├── TRABAJO FINAL.pdf         # Informe completo del ejercicio
├── PPT final del ejercicio.pdf
└── README.md                 # Este archivo
```

---

## 🎯 Objetivo del Proyecto

Replicar empíricamente los resultados del estudio que evalúa si la **certificación del café** (Fair Trade, Organic) mejora el bienestar de pequeños productores en Etiopía. Se aplica metodología de evaluación de impacto, en particular:

* **Regresión MCO (OLS)**
* **Emparejamiento por Puntaje de Propensión (PSM)**
* **Estimadores ATT/ATE**
* **Pruebas de balance de covariables y soporte común**

---

## 🔧 Herramientas utilizadas

* **Software**: Stata
* **Paquetes**: `psmatch2`, `pstest`, `teffects`
* **Diseño**: Emparejamiento logit con especificaciones alternativas (caliper, kernel)

---

## 📊 Tablas replicadas

| Tabla | Análisis                                                           |
| ----- | ------------------------------------------------------------------ |
| 1     | Estadísticas descriptivas                                          |
| 2     | t-tests y regresiones simples sobre tierra, rendimientos y precios |
| 3     | Regressiones OLS para ingreso per cápita, total y consumo diario   |
| 4     | Modelo Logit para PSM                                              |
| 5     | Resultados del PSM y regresiones condicionadas al soporte común    |
| 6     | Incidencia de pobreza (moderada y extrema)                         |
| 7     | Regresiones de `income_gap` e `income_gapsq`                       |

---

## ❗ Descubrimientos importantes

### ⚠️ Crítica metodológica: **el supuesto de balance no se verifica**

Aunque el estudio original asume que las covariables quedan **balanceadas** después del emparejamiento, **no presenta evidencia gráfica ni estadística** del balance de medias. En nuestra réplica:

* Utilizamos `pstest` para evaluar el **sesgo porcentual estandarizado** antes y después del emparejamiento.
* Comprobamos que **varias covariables permanecen desequilibradas**, incluso después del matching.
* Algunas variables clave **exceden el umbral crítico de ±10%** de sesgo, y otras **superan incluso ±20%**, lo cual compromete la validez causal de los resultados.

📌 **Implicación:** No se cumple el supuesto de independencia condicional ni de balance tras el emparejamiento, fundamentales para interpretar los resultados como efecto causal de la certificación.

---

## 🔍 Otras observaciones y críticas

### 🔸 Tamaño y composición de la muestra

* Solo **249 observaciones**, con más tratados (certificados) que controles, lo cual **limita seriamente el poder de emparejamiento**.
* Lo ideal es tener más controles que tratados, de modo que cada tratado pueda ser comparado con múltiples controles de características similares.

### 🔸 Soporte común insuficiente

* El soporte común (distribución del puntaje de propensión) no es sólido. Esto **debilita la comparación entre grupos**, y **viola los supuestos mínimos del PSM**.
* El estudio ajusta más bien a los **tratados a los controles**, lo cual **invierte la lógica óptima del diseño de evaluación**.

---

## 🧠 Conclusiones del artículo original

* **Sobre precios e ingresos:** No se encuentran diferencias estadísticamente significativas entre cooperativas certificadas y no certificadas.
* **Consumo:** Se detecta un **mayor consumo per cápita** entre productores certificados.
* **Conocimiento sobre certificación:** Solo el 45% de los productores certificados sabía que su cooperativa estaba certificada.
* **Desempeño desigual:** Hay **alta heterogeneidad** entre cooperativas, lo cual sugiere que la efectividad de la certificación depende del **nivel organizacional interno**.

---

## 🧾 Conclusiones propias (producto de la réplica)

* **Limitación severa del estudio original:** Las condiciones estadísticas para hacer inferencias causales **no están cumplidas**.
* **Resultados sobre consumo** podrían deberse a diferencias no observadas o a factores no controlados, más que a la certificación en sí.
* **Recomendación clave:** Recoger datos adicionales con mejor diseño muestral y control de calidad. Incluir más variables en el emparejamiento y mejorar la proporción tratados/control.
