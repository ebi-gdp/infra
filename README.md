# GeneticScores.org OpenTofu templates

[OpenTofu](https://opentofu.org/) is an open source infrastructure as code tool (forked from Terraform).

## Setup

```
$ brew update
$ brew install tofu
$ tofu init
$ gcloud auth application-default login
```

## Plan a deployment

```
$ tofu plan
```

## Execute a deployment

```
$ tofu apply
```