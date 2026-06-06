# TFC - Despliegue de Entorno Web Seguro Automatizado

**Autor:** Bruno Sande Noriega  
**Titulación:** Administración de Sistemas Informáticos en Red (ASIR)  
**Centro:** C.P.R. Liceo La Paz  

## Descripción del Proyecto
Este repositorio contiene la infraestructura como código (IaC) y los scripts de automatización para el despliegue de un entorno web de producción seguro. El proyecto resuelve las inconsistencias entre entornos de desarrollo y producción mediante contenedorización y aplica estrictas políticas de seguridad perimetral.

## Tecnologías Utilizadas
* **Sistema Operativo:** Ubuntu Server 24.04 LTS
* **Contenedorización:** Docker & Docker Engine
* **Proxy Inverso & Seguridad Web:** Nginx + Certificados SSL (HTTPS)
* **Cortafuegos:** Iptables (Reglas persistentes)

## Estructura del Repositorio
* `/scripts/deploy_tfc.sh`: Script principal en Bash que automatiza la instalación de dependencias, generación de certificados SSL y despliegue del contenedor.
* `/app/`: Directorio que contiene los archivos de la aplicación.

## Instrucciones de Despliegue
Para desplegar este entorno en un servidor Ubuntu limpio:

1. Otorga permisos de ejecución al script:
   ```bash
   chmod +x scripts/deploy_tfc.sh