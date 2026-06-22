# Infrastructure Launchpad & Pre-Caching Setup
**Contribution by:** Vaishnavi (@vaishnavi-nss)

## 🚀 Overview
Engineered the foundational local infrastructure environment for the Mini-SOC project, focusing on environment readiness, deployment optimization, and data persistence.

## 🛠️ Key Contributions & Architecture

### 1. Offline Dependency & Image Pre-Caching
* **File:** `day2-3-precache.yml`
* **Impact:** Configured a dedicated Docker Compose layout to pull and cache core Day 2 and Day 3 container images (including SIEM environment, ModSecurity WAF, and Keycloak IAM) locally. This eliminates network deployment bottlenecks during active development.

### 2. Automated SOC Control Engine
* **File:** `soc_control.sh`
* **Impact:** Developed a modular Bash utility script to manage the local lifecycle of the SOC environment, giving the team one-touch capabilities to spin up, verify, or tear down containers cleanly.

### 3. ⭐ Persistent Log Architecture
* **Implementation:** Integrated local host volume mappings (`volumes:`) directly into the orchestration layer. 
* **Impact:** Solves the core vulnerability of stateless containers by ensuring that mission-critical security logs remain completely intact and locally auditable even across sudden container restarts or crashes.

---

## 🔍 Current Status & Environment Remediation (Day 2 Sprint)

### 🚨 Known Issue: Registry Path Changes & Architecture Mismatches
During initial localization testing on Windows host environments running WSL2, two key environment blockers were identified and are currently being bypassed:
1. **Upstream Registry Deprecation (404 Not Found):** The legacy `owasp/modsecurity-crs:nginx` tag was moved/deprecated upstream on Docker Hub, causing pull failures.
2. **Binary Execution Failures (Exit Code 255):** Docker Desktop's engine defaulted to caching ARM64 image variants (Apple Silicon) locally, triggering `exec format error` crashes when executed on standard AMD64 (Intel/AMD) Windows host hardware.

### 🛠️ Active Remediation Strategy
I am actively refactoring the orchestration layer right now with the following production-grade fixes:
* **Registry Realignment:** Shifting the WAF source to the official GitHub Container Registry path (`ghcr.io/owasp-modsecurity/modsecurity-crs:nginx-alpine`) to bypass Docker Hub 404 limitations.
* **Architecture Hardening:** Modifying deployment playbooks to explicitly enforce `DOCKER_DEFAULT_PLATFORM=linux/amd64` flags to suppress architecture guessing and ensure binary compatibility with the Windows/WSL2 host CPU.
