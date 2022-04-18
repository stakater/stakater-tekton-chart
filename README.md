# Pipeline-Charts
Jumbo chart for creating pipeline manifests


## Installing the Chart

To install the chart with the release name my-application in namespace test:

    helm repo add stakater https://stakater.github.io/stakater-charts
    helm repo update
    helm install my-pipeline stakater/pipeline-charts --namespace test


## Uninstall the Chart

To uninstall the chart:

    helm delete <name-of-the-chart>


## Paramaters

| Name | Description                                                                                | Value                                       |
| ---| ---------------------------------------------------------------------------------------------|---------------------------------------------|
| name | Name of the pipeline manifests                                                             | ``                                          |


#### Pipeline Paramaters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| pipeline.enabled | Enable pipeline manifest on helm chart                                                               | `true`          |
| pipeline.workspace | Workspaces required for running tekton tasks                                                       | `{}`            |
| pipeline.params| Parameters required for running tekton tasks                                                           | `{}`            |
| pipeline.tasks | Task names in the pipeline and their parameters and workspaces used                                    | `{}`            |
| pipeline.tasks.taskName | Name of already existing task, will be used as pipeline step name                             | ``              |
| pipeline.tasks.params | Parameters required by the task for execution                                                   | ``              |
| pipeline.tasks.workspace | Workspaces required by the task for execution                                                | ``              |
| pipeline.tasks.runAfter | Used to order task execution among tasks                                                      | ``              |


#### Trigger Template

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| triggertemplate.enabled | Enable trigger template manifest on helm chart                                                | `true`          |
| triggertemplate.additionalParams | Parameters in addition to pipeline parameter in trigger template                     | `{}`            |
| triggertemplate.pipelineRunNamePrefix | Prefix value for pipelineRun name                                               | ``              |
| triggertemplate.serviceAccount | Service Account to be used for pipelineRun                                             | ``              |
| triggertemplate.pipelineRunAnnotations | Annotations for pipelineRun                                                    | `{}`            |
| triggertemplate.workspaces | Workspaces used by pipelines ie volumeClaimTemplate, volumeClaimRef, configMaps, secrets | `{}`       |
| triggertemplate.workspaces.name | Name of the workspace                                                                 | ``            |
| triggertemplate.workspaces.type | Type of workspace ie volume claim template, volume claim, config map, empty dir       | ``            |
| triggertemplate.workspaces.accessModes | If type is volume claim template, define access mode                           | `ReadWriteOnce` |
| triggertemplate.workspaces.resourcesRequestsStorage | If type is volume claim template, define resourcesRequestsStorage | `1Gi`           |
| triggertemplate.workspaces.claimName | If type is volume claim, define already existing claimName                       | ``              |
| triggertemplate.workspaces.configMapName | If type is config map, define already existing config map name               | ``              |


#### Trigger Binding Parameters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| triggerbinding.enabled | Enable trigger bindings manifest on helm chart.                                                | ``              |
| triggerbinding.bindings | Trigger bindings ( > 1 ) name and parameters are passed to trigger template            | `{}`            |
| triggerbinding.bindings.name | Trigger bindings names                                                            | ``              |
| triggerbinding.bindings.bodyParams | Trigger bindings parameters                                                 | `{}`            |


#### Event listener Parameters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| eventlistener.enabled    | Enable event listener manifest on helm chart                                                 | ``              |
| eventlistener.triggers    | Define pipelines trigger templates in case of event, can use already existing trigger templates | `{}`        |
| eventlistener.triggers.name    | Trigger Name                                                                           | ``              |
| eventlistener.triggers.templateName    | Trigger Template Name to be evoked                                             | ``              |
| eventlistener.triggers.interceptors_cel_filter    | Specify Interceptors CEL filter                                     | ``              |
| eventlistener.triggers.bindings    | Trigger Bindings to be passed to trigger templates                                 | `{}`            |

 
#### Event Listener Route Parameters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| route.enabled    | Enable route manifest for event listener on helm chart                                               | ``              |
| route.routeLabels    | Route labels to be added                                                                         | `{}`            |
| route.port.targetPort    | Target port of the backend service                                                           | ``              |
| eventlistener.wildcardPolicy  | Wildcard Policy of the route.                                                           | ``              |
| eventlistener.tls.termination    | tls termination criteria for route                                                   | `edge`          |
| eventlistener.tls.insecureEdgeTerminationPolicy    | Policy for insecure traffic                                 | `Redirect`      |



# Changelog

All notable changes to this project will be documented here.
