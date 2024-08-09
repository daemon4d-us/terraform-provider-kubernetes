---
subcategory: "apiregistration/v1"
page_title: "Kubernetes: kubernetes_api_service"
description: |-
  An API Service is an abstraction which defines for locating and communicating with servers.
---

# kubernetes_api_service

An API Service is an abstraction which defines for locating and communicating with servers.

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `metadata` (Block List, Min: 1, Max: 1) Standard api_service's metadata. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#metadata (see [below for nested schema](#nestedblock--metadata))
- `spec` (Block List, Min: 1, Max: 1) Spec contains information for locating and communicating with a server. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status (see [below for nested schema](#nestedblock--spec))

### Read-Only

- `id` (String) The ID of this resource.

<a id="nestedblock--metadata"></a>
### Nested Schema for `metadata`

Optional:

- `annotations` (Map of String) An unstructured key value map stored with the api_service that may be used to store arbitrary metadata. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/
- `generate_name` (String) Prefix, used by the server, to generate a unique name ONLY IF the `name` field has not been provided. This value will also be combined with a unique suffix. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#idempotency
- `labels` (Map of String) Map of string keys and values that can be used to organize and categorize (scope and select) the api_service. May match selectors of replication controllers and services. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
- `name` (String) Name of the api_service, must be unique. Cannot be updated. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names

Read-Only:

- `generation` (Number) A sequence number representing a specific generation of the desired state.
- `resource_version` (String) An opaque value that represents the internal version of this api_service that can be used by clients to determine when api_service has changed. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency
- `uid` (String) The unique in time and space value for this api_service. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids


<a id="nestedblock--spec"></a>
### Nested Schema for `spec`

Required:

- `group` (String) Group is the API group name this server hosts.
- `group_priority_minimum` (Number) GroupPriorityMinimum is the priority this group should have at least. Higher priority means that the group is preferred by clients over lower priority ones. Note that other versions of this group might specify even higher GroupPriorityMininum values such that the whole group gets a higher priority. The primary sort is based on GroupPriorityMinimum, ordered highest number to lowest (20 before 10). The secondary sort is based on the alphabetical comparison of the name of the object. (v1.bar before v1.foo) We'd recommend something like: *.k8s.io (except extensions) at 18000 and PaaSes (OpenShift, Deis) are recommended to be in the 2000s.
- `version` (String) Version is the API version this server hosts. For example, `v1`.
- `version_priority` (Number) VersionPriority controls the ordering of this API version inside of its group. Must be greater than zero. The primary sort is based on VersionPriority, ordered highest to lowest (20 before 10). Since it's inside of a group, the number can be small, probably in the 10s. In case of equal version priorities, the version string will be used to compute the order inside a group. If the version string is `kube-like`, it will sort above non `kube-like` version strings, which are ordered lexicographically. `Kube-like` versions start with a `v`, then are followed by a number (the major version), then optionally the string `alpha` or `beta` and another number (the minor version). These are sorted first by GA > `beta` > `alpha` (where GA is a version with no suffix such as `beta` or `alpha`), and then by comparing major version, then minor version. An example sorted list of versions: `v10`, `v2`, `v1`, `v11beta2`, `v10beta3`, `v3beta1`, `v12alpha1`, `v11alpha2`, `foo1`, `foo10`.

Optional:

- `ca_bundle` (String) CABundle is a PEM encoded CA bundle which will be used to validate an API server's serving certificate. If unspecified, system trust roots on the apiserver are used.
- `insecure_skip_tls_verify` (Boolean) InsecureSkipTLSVerify disables TLS certificate verification when communicating with this server. This is strongly discouraged. You should use the CABundle instead.
- `service` (Block List, Max: 1) Service is a reference to the service for this API server. It must communicate on port 443. If the Service is nil, that means the handling for the API groupversion is handled locally on this server. The call will simply delegate to the normal handler chain to be fulfilled. (see [below for nested schema](#nestedblock--spec--service))

<a id="nestedblock--spec--service"></a>
### Nested Schema for `spec.service`

Required:

- `name` (String) Name is the name of the service.
- `namespace` (String) Namespace is the namespace of the service.

Optional:

- `port` (Number) If specified, the port on the service that is hosting the service. Defaults to 443 for backward compatibility. Should be a valid port number (1-65535, inclusive).





## Example Usage

```terraform
resource "kubernetes_api_service" "example" {
  metadata {
    name = "terraform-example"
  }
  spec {
    selector {
      app = "${kubernetes_pod.example.metadata.0.labels.app}"
    }
    session_affinity = "ClientIP"
    port {
      port        = 8080
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
```

## Import

API service can be imported using its name, e.g.

```
$ terraform import kubernetes_api_service.example v1.terraform-name.k8s.io
```