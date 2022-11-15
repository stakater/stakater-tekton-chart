# Changelog

All notable changes to this project will be documented in this file.

## [2.0.2] - 2022-11-15
- Add params to clustertask remove-environment-v1.

## [2.0.1] - 2022-11-11
- Add clustertask stakater-create-environment-v2 to default tasks.
- Add clustertask stakater-remove-environment-v1 to default tasks.

## [2.0.0] - 2022-10-27
- Added resources to be specified in eventlistener.
- Removed podTemplate in eventlistener (removed in tekton trigger v0.15.0)

## [1.1.0] - 2022-10-21
- Added podTemplate to be specified in trigggertemplate and eventlistener.

## [1.0.0] - 2022-10-15
- Renamed repository from pipeline-chart to stakater-tekton-chart.

## [0.0.35] - 2022-09-26
- Added stakater-cosign-v1 to default tasks.

## [0.0.34] - 2022-09-26
- Added stakater-zap-proxy-v1 to default tasks.

## [0.0.33] - 2022-09-26
- Added name: stakater-gitlab-save-allure-report-v1 to default tasks.

## [0.0.32] - 2022-09-25
- Fixed typo in stakater-load-testing-v1 default tasks.

## [0.0.31] - 2022-09-25
- Added stakater-load-testing-v1 to default tasks.

## [0.0.29] - 2022-09-16
- Added new triggers for gitlab and updated current trigger names. Make sure to change trigger names in values file with latest version.
- Updated parameters for default tasks.
- Added stakater-build-image-flag-v1 to default tasks.

## [0.0.26] - 2022-09-06

- Feature : Add taskSpec support for defining tasks through default tasks and values.
- Change: Renamed taskName field to defaultTaskName.
- Change: If task doesnt exists, defining ( taskRef or taskSpec ) and ( name ) is required.
- Fix: Allow definition of kind in taskRef.
- Fix: Remove redundant code by defining it in helpers.tpl

## [0.0.25] - 2022-08-31

- Change: Seprate pullrequest trigger for action == synchronize and action == open in default interceptors

## [0.0.24] - 2022-08-05

- Feature : Add serviceaccount, role, rolebindings, clusterrolebindings for pipeline.
- Feature: Add external service account to be specified

## [0.0.23] - 2022-07-28

- Feature : Specify trigger template parameters by specifying it in triggertemplate.params[].
<b>(Note:This will only add params in .spec.params not in resourcetemplates )
</b>
