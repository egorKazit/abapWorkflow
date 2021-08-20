@AbapCatalog.sqlViewName: 'ZYKZIRIRQN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Item Requisition'
define view ZYKZ_I_ItemRequisition
  as select from zykz_lx_rirqstn
{
  key mandt           as Mandt,
  key uuid            as UUID,
      itemuuid        as ItemUUID,
      headeruuid      as HeaderUUID,
      requisitionname as RequisitionName
}
