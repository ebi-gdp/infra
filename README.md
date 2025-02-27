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

## Pick an environment

```
$ cd environments/test
```

## Plan a deployment

```
$ tofu plan
```

> [!TIP]
> `plan` will prompt for variables. You can put these variables in a file to save time, e.g.:
>
> ```
> $ tofu plan -var-file="testing.tfvars"
> ```

If everything looks sensible, create the resources by applying the deployment.

## Execute a deployment

```
$ tofu apply
```
