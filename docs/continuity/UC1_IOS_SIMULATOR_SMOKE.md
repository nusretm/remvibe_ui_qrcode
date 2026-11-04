# UC-1 iOS Simulator CI smoke

2026-11-04. Approved scope: check out the existing `example` application on GitHub-hosted `macos-26`, run Flutter iOS **Simulator** build without signing or provisioning, capture standard Actions logs, and upload a zipped `Runner.app` bundle if successful.

Workflow: `.github/workflows/uc1-ios-simulator.yml`. Runs on a PR that adds this workflow, or by manual dispatch after the workflow exists on the default branch.

This is an **isolated build experiment** for RemVibe Update Center; it does not change the QR widget API or runtime, publish an IPA, or claim verification on a physical iOS device. Results must be recorded from real workflow run logs. Squash merge requires user acceptance and separate explicit approval.
