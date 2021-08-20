@AbapCatalog.sqlViewName: 'ZYKZCRSTS'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #CONSUMPTION
@Search.searchable: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel: {
    semanticKey: 'RequestStatus',
    usageType: {
      serviceQuality: #C,
      sizeCategory: #M,
      dataClass: #MASTER
    }
}
@EndUserText.label: 'Value Help for Request Status'
define view ZYKZ_C_RequestStatusVH
  as select from ZYKZ_I_RequestStatusVH
{
      @Search.defaultSearchElement: true
  key RequestStatus,
      @ObjectModel.readOnly: true
      RequestStatusText
}
