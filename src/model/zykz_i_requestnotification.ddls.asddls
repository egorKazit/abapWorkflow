@AbapCatalog.sqlViewName: 'ZYKZIRNTF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Request Notification'
define view ZYKZ_I_RequestNotification
  as select from zykz_lx_ntfk
{
  key client     as Client,
  key uuid       as UUID,
      headeruuid as HeaderUUID,
      ip         as Ip,
      message    as Message
}
