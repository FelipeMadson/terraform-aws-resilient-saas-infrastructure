# Infraestrutura AWS SaaS Resiliente em Terraform

[![CI](https://github.com/FelipeMadson/terraform-aws-resilient-saas-infrastructure/actions/workflows/ci.yml/badge.svg)](https://github.com/FelipeMadson/terraform-aws-resilient-saas-infrastructure/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Release](https://img.shields.io/badge/release-v1.0.0-green.svg)](https://github.com/FelipeMadson/terraform-aws-resilient-saas-infrastructure/releases)

Infraestrutura como Código (IaC) de nível de produção desenvolvida em **Terraform** por [Felipe Madison](https://github.com/FelipeMadson). Provisiona uma arquitetura cloud multi-AZ altamente disponível na AWS com políticas IAM de menor privilégio, sub-redes isoladas para banco de dados, encriptação via chaves gerenciadas KMS e zero credenciais expostas.

## Topologia de Rede Multi-AZ

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        REGIÃO AWS (us-east-1)                          │
│                                                                        │
│   VPC (10.0.0.0/16) · Suporte a DNS · Hostnames Habilitados            │
│                                                                        │
│   ┌───────────────────────────┐     ┌───────────────────────────┐      │
│   │   ZONA DE DISPONIBILIDADE A│    │   ZONA DE DISPONIBILIDADE B│     │
│   │                           │     │                           │      │
│   │  [Subnet Pública 10.0.1.0]│     │  [Subnet Pública 10.0.2.0]│      │
│   │    • NAT Gateway A        │     │    • NAT Gateway B        │      │
│   │                           │     │                           │      │
│   │  [Subnet App 10.0.10.0]   │     │  [Subnet App 10.0.20.0]   │      │
│   │    • EKS / Containers     │     │    • EKS / Containers     │      │
│   │                           │     │                           │      │
│   │  [Subnet DB 10.0.50.0]    │     │  [Subnet DB 10.0.60.0]    │      │
│   │    • RDS Primário (PG)    │◄───►│    • RDS Standby (MultiAZ)│      │
│   └───────────────────────────┘     └───────────────────────────┘      │
└────────────────────────────────────────────────────────────────────────┘
```

## Destaques de Engenharia

- **Alta Disponibilidade Multi-AZ**: Sub-redes redundantes com failover automático entre zonas de disponibilidade.
- **Camada de Dados Isolada**: Sub-redes de banco de dados sem rota para a internet pública (isolamento air-gap).
- **Encriptação KMS**: Criptografia em repouso ativada por padrão com chaves de clientes em todos os volumes e buckets.
- **Zero AI Slop**: Módulos limpos, versionados e validados pelo Terraform CLI.

## Autor

Desenvolvido por **[Felipe Madison](https://github.com/FelipeMadson)**.
