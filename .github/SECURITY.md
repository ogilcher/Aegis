# Security Policy

## Supported Versions

This project is actively developed on the `main` branch.
Security updates are applied only to the latest version.

Older versions are not guaranteed to receive patches.

---

## Reporting a Vulnerability

If you discover a security vulnerability, **please do NOT open a public GitHub issue**

Instead, report it privately using one of the following:

- GitHub Security Advisory: "Report a vulnerability" button
- Email: olivergilcher@gmail.com

Please include:

- Description of the issue
- Steps to reproduce
- Proof-of-concept (if available)
- Potential impact assessment
- Environment details

You will receive acknowledgement within **72 hours**.

---

## Responsible Disclosure

This project follows responsible disclosure practices:

- Do not publically disclose vulnerabilities until a fix is released.,
- Allow reasonable time for remediation
- Avoid accessing or modifying data that is not your own.

We appreciate security researchers who act in good faith.

---

## Security Scope

This project focuses on:

- End-to-end encryption (E2EE) architecture
- Secure key handling
- Authentication flows
- Data protection
- Database access controls (RLS policies)

However, this repository is:

- A development / portfolio project
- Not production infrastructure
- Not intended for sensitive real-world data

No security guarantees are provided.

---

## Data Handling Guarantees

The project is designed with the following goals:

- Client-side encryption before remote storage
- No plaintext sensitive data persisted remotely
- Minimal metadata exposure
- Secure key storage where possible

Implementation bugs may exist.
Please report any issues responsibly.

---

## Out of Scope

The following are generally not considered security issues:

- Theoretical vulnerabilities without proof-of-concept
- Non-security code quality concerns
- Issues in third-party dependencies
- Local environment misconfiguration

---

## Security Updates

Security fixes may be released without prior notice.

Changelog entries will indicate when a security issue has been resolved.
