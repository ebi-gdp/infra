# GeneticScores.org OpenTofu templates

[OpenTofu](https://opentofu.org/) is an open source infrastructure as code tool (forked from Terraform).

## Setup

```
$ brew update
$ brew install tofu
$ tofu init
$ gcloud auth application-default login
```

## Before you get started

Make sure a backend bucket exists in the production project, e.g.:

```
gs://genetic-scores-tofu-state
```

Enabling object versioning, soft delete, and encryption is a good idea.

## Plan a deployment

```
$ tofu plan
```

## Execute a deployment

```
$ tofu apply
```
