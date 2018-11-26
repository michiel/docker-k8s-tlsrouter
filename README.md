# tlsrouter

This example exposes `kubernetes.default.svc`.
This is a bad idea for production.

## Example deployment - components

![Components](https://raw.github.com/michiel/docker-k8s-tlsrouter/master/resource/components.svg?sanitize=true)

## Example deployment - sequence

![Sequence](https://raw.github.com/michiel/docker-k8s-tlsrouter/master/resource/sequence.svg?sanitize=true)

## Configurations

_Note: you have to expose this as a service_

Example `deployment.yaml`

```{.yaml}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tlsrouter
spec:
  replicas: 1
  selector:
    matchLabels:
      app: tlsrouter
  template:
    metadata:
      name: tlsrouter
      labels:
        app: tlsrouter
    spec:
      containers:
        - image: 'hub.docker.com/michielkalkman/tlsrouter:latest'
          imagePullPolicy: IfNotPresent
          name: tlsrouter
          args:
          - '/bin/tlsrouter'
          - '-conf'
          - '/etc/tlsrouter/tlsrouter.conf'
          - '-listen'
          - ':8443'
          ports:
            - containerPort: 8443
              protocol: TCP
          resources: {}
          securityContext:
            capabilities:
              drop:
              - all
          volumeMounts:
            - mountPath: /etc/tlsrouter
              name: tlsrouter-config
      volumes:
        - configMap:
            defaultMode: 420
            name: tlsrouter-config
          name: tlsrouter-config
```

Example `configmap.yaml`

```
apiVersion: apps/v1
kind: ConfigMap
metadata:
  name: tlsrouter-config
data:
  tlsrouter.conf: |
    /.*/ kubernetes.default:443
```

