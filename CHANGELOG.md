# Changelog

All notable changes to this project will be documented in this file.

## [0.0.29] - 2022-09-16
- Added new triggers for gitlab and updated current trigger names. Make sure to change trigger names in values file with latest version.

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
