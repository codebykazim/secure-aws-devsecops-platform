# Verification Checklist

This checklist is used to validate the completion of each phase.

- [ ] **Phase 1:** Project foundation initialized.
- [ ] **Phase 2 (Terraform):** EC2 instances running, SSH works, outputs show IPs.
- [ ] **Phase 3 (Linux):** Sudo works, system commands usable.
- [ ] **Phase 4 (Ansible):** Playbooks run successfully and are idempotent.
- [ ] **Phase 5 (Jenkins):** Master and Agent connected, plugins installed.
- [x] **Phase 6 (Docker):** App builds, Trivy scan runs, image pushed.
- [ ] **Phase 7 (CI/CD):** Pipeline triggered automatically, Quality Gate passes.
- [ ] **Phase 8 (EKS):** App deployed, pods healthy, service accessible.
- [ ] **Phase 9 (Monitoring):** Grafana shows data, test alert triggers.
- [ ] **Phase 10 (Security):** SSH secured, Fail2ban running.
- [ ] **Phase 11 (Firewall):** UFW/iptables configured, correct ports open.
- [ ] **Phase 12 (Alerts):** Pipeline and monitoring emails received.
- [ ] **Phase 13 (DNS):** Domain resolves to app (if applicable).
- [ ] **Phase 14 (Incident):** Failure simulated, detected, rolled back, and RCA written.
- [ ] **Phase 15 (Final):** README complete, resources destroyed.
