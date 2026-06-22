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

### 3. ⭐ Brownie Points: Persistent Log Architecture
* **Implementation:** Integrated local host volume mappings (`volumes:`) directly into the orchestration layer. 
* **Impact:** Solves the core vulnerability of stateless containers by ensuring that mission-critical security logs remain completely intact and locally auditable even across sudden container restarts or crashes.
