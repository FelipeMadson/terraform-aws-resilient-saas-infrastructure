# Terraform AWS Resilient SaaS Infrastructure

[![CI](https://github.com/FelipeMadson/terraform-aws-resilient-saas-infrastructure/actions/workflows/ci.yml/badge.svg)](https://github.com/FelipeMadson/terraform-aws-resilient-saas-infrastructure/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Release](https://img.shields.io/badge/release-v1.0.0-green.svg)](https://github.com/FelipeMadson/terraform-aws-resilient-saas-infrastructure/releases)

Production-grade Infrastructure as Code (IaC) written in **Terraform** designed by [Felipe Madison](https://github.com/FelipeMadson). Provisions a highly-available, multi-AZ cloud architecture on AWS with least-privilege IAM policies, isolated database subnets, KMS customer-managed encryption, and zero hardcoded secrets.

## Multi-AZ Architecture Topology

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        AWS REGION (us-east-1)                          │
│                                                                        │
│   VPC (10.0.0.0/16) · DNS Support · DNS Hostnames                      │
│                                                                        │
│   ┌───────────────────────────┐     ┌───────────────────────────┐      │
│   │   AVAILABILITY ZONE A     │     │   AVAILABILITY ZONE B     │      │
│   │                           │     │                           │      │
│   │  [Public Subnet 10.0.1.0] │     │  [Public Subnet 10.0.2.0] │      │
│   │    • NAT Gateway A        │     │    • NAT Gateway B        │      │
│   │                           │     │                           │      │
│   │  [App Subnet 10.0.10.0]   │     │  [App Subnet 10.0.20.0]   │      │
│   │    • EKS / Containers     │     │    • EKS / Containers     │      │
│   │                           │     │                           │      │
│   │  [DB Subnet 10.0.50.0]    │     │  [DB Subnet 10.0.60.0]    │      │
│   │    • RDS Primary (PG)     │◄───►│    • RDS Standby (MultiAZ)│      │
│   └───────────────────────────┘     └───────────────────────────┘      │
└────────────────────────────────────────────────────────────────────────┘
```

## Key Engineering Controls

- **Multi-AZ High Availability**: Redundant subnets across distinct availability zones with automatic failover.
- **Isolated Database Tier**: Database subnets have zero internet route table entries (air-gapped from direct public ingress).
- **KMS Customer-Managed Encryption**: Storage volumes, RDS instances, and S3 objects are encrypted at rest with customer-managed keys (CMK).
- **Strict S3 Bucket Hardening**: Enforces `block_public_acls = true`, `block_public_policy = true`, and TLS 1.2+ transport policies.

## Author

Authored by **[Felipe Madison](https://github.com/FelipeMadson)**.
