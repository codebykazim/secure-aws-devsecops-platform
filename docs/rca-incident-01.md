# Root Cause Analysis (RCA) - Incident 01

**Date:** 2026-10-07
**Incident:** Deployment Failure (Simulated)
**Impact:** No downtime. A bad image deployment was attempted, but Kubernetes prevented an outage.

### What Happened
A deployment update was issued with an invalid container image tag (`v999.broken`). Kubernetes attempted to schedule the new pods, but they failed to pull the image and enter a `Ready` state.

### How It Was Detected
The Kubernetes deployment controller detected that the new ReplicaSet could not reach the desired state. The pods remained in `Pending`/`ImagePullBackOff`.

### Mitigation
Because Kubernetes uses a Rolling Update strategy by default, it did not terminate the old, healthy pods until the new pods were ready. The application remained fully online during the failure. The deployment was manually rolled back using `kubectl rollout undo deployment/devsecops-app-deployment`.

### Preventive Measures
- Implement CI/CD pipeline checks to ensure only existing, scanned image tags are pushed to the deployment manifest.
- Rely on Kubernetes native rolling updates and readiness probes to catch deployment failures before they impact users.
