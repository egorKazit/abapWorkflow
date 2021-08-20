@AbapCatalog.sqlViewName: 'ZYKZIRHDR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Request Header'
define view ZYKZ_I_RequestHeader
  as select from zykz_lx_request
{
  key mandt         as Mandt,
  key uuid          as UUID,
      requestid     as RequestID,
      requestname   as RequestName,
      description   as Description,
      requeststatus as RequestStatus,
      priority      as Priority
}
