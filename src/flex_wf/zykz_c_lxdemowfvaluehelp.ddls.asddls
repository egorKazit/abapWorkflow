@AbapCatalog.sqlViewName: 'ZYKZCWFVH'
@AbapCatalog.compiler.compareFilter: true
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.dataCategory:#VALUE_HELP
@OData.publish: true
@ObjectModel.createEnabled: true
@EndUserText.label: 'LeverX Demo: Workflow Value Help'
define view ZYKZ_C_LXDemoWFValueHelp
  as select from swf_flex_ifs_vh as Document
  association [0..1] to ZYKZ_I_RequestPriorityVH as _RequestPriorityVH on $projection.RequestPriority = _RequestPriorityVH.RequestPriority
  association [0..1] to ZUYKZ_I_PeoplePickerVH   as _PeoplePickerVH    on $projection.UserID = _PeoplePickerVH.UserID
{
  key ''                                 as dummy,
      @Consumption.valueHelp: '_RequestPriorityVH'
      cast( '' as  zykz_lx_de_priority ) as RequestPriority,
      @Consumption.valueHelp: '_PeoplePickerVH'
      @ObjectModel.foreignKey.association: '_PeoplePickerVH'
      cast( '' as user )                 as UserID,

      _RequestPriorityVH,
      _PeoplePickerVH
}
