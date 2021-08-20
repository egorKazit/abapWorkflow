@AbapCatalog.sqlViewName: 'ZYKZCRPRR'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #CONSUMPTION
@Search.searchable: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel: {
    semanticKey: 'RequestPriority',
    usageType: {
      serviceQuality: #C,
      sizeCategory: #M,
      dataClass: #MASTER
    }
}
@EndUserText.label: 'Value Help for Request Priority'
define view ZYKZ_C_RequestPriorityVH
  as select from ZYKZ_I_RequestPriorityVH
{
      @Search.defaultSearchElement: true
  key RequestPriority,
      @ObjectModel.readOnly: true
      RequestPriorityText
}
