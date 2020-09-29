---
layout: page
title: Auth Server
---

Creates service, deployment and routes for Graph Server authentication and authorization.
A common redis deployment is used for the servers as cache.

Used as `forwardAuth` middleware for a `traefik` deployment.

Refer [values.yaml](https://github.com/ZettaAI/helm-charts/blob/master/charts/auth-server/values.yaml) file for variables and default values.

Refer to [templates](https://github.com/ZettaAI/helm-charts/blob/master/charts/auth-server/templates) for what's created and how.
