# Infrastructure Launchpad & Pre-Caching Setup

**Contribution by:** Vaishnavi (@vaishnavi-nss)

## 🚀 Overview

Engineered the foundational local infrastructure environment for the Mini-SOC project, focusing on deployment readiness, environment optimization, and log persistence.

## 🛠️ Key Contributions

### 1. Offline Dependency & Image Pre-Caching

**File:** `day2-3-precache.yml`

Configured a Docker Compose setup to pre-pull and cache core Day 2 and Day 3 container images (SIEM, ModSecurity WAF, and Keycloak IAM) locally, reducing deployment delays caused by network dependencies.

### 2. Automated SOC Control Engine

**File:** `soc_control.sh`

Developed a Bash-based utility to manage the local SOC environment lifecycle, enabling quick startup, validation, and cleanup of services.

### 3. ⭐ Persistent Log Architecture

Integrated host volume mappings (`volumes:`) into the orchestration layer to ensure security logs remain persistent and auditable across container restarts or failures.

---

## 🔍 Environment Remediation & Troubleshooting

During local deployment on Windows + WSL2 environments, several infrastructure issues were identified and resolved:

* **Registry Deprecation:** Legacy `owasp/modsecurity-crs:nginx` image references resulted in pull failures due to upstream changes.
* **Architecture Mismatch:** ARM64 image variants were cached locally, causing `exec format error` and Exit Code 255 failures on AMD64 systems.
* **WSL2 Environment Constraints:** Additional time was spent diagnosing container runtime, filesystem, and virtualization-related issues affecting service deployment.

### Remediation

* Migrated WAF image references to supported registry sources.
* Enforced `DOCKER_DEFAULT_PLATFORM=linux/amd64` for architecture compatibility.
* Refactored deployment configurations to improve reliability across Windows/WSL2 environments.

> A significant portion of the implementation timeline was dedicated to infrastructure troubleshooting and environment stabilization, which delayed feature integration but ensured a reliable deployment foundation for the team.

---

## 🚀 Infrastructure & Local Deployment

Implemented a multi-tier Mini-SOC infrastructure utilizing Docker Compose for WAF and IAM deployment.

### Hypervisor Isolation / Fallback Mode

In cases where Docker or WSL2 services were unavailable, a native TCP socket fallback architecture was used to validate:

* Port binding
* Network connectivity
* Endpoint availability

This enabled continued testing and service verification independent of the local virtualization layer.

