@AbapCatalog.sqlViewName: 'ZYKZIRITM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Request Item'
define view ZYKZ_I_RequestItem
  as select from zykz_lx_reqitem
{
  key mandt            as Mandt,
  key uuid             as UUID,
      headeruuid       as HeaderUUID,
      itemname         as ItemName,
      description      as Description,
      requisitioncount as RequisitionCount
}
