@AbapCatalog.sqlViewName: 'ZYKZIRSTS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Request Status Value Help'
@VDM.viewType:#BASIC
@ObjectModel: {
    semanticKey: 'ABOPCheckingRule',
    usageType: {
      serviceQuality: #C,
      sizeCategory: #M,
      dataClass: #MASTER
    }
}
define view ZYKZ_I_RequestStatusVH
  as select from dd07t
{
  key $session.client                                                     as mandt,
  key cast ( cast ( domvalue_l as abap.numc( 1 ) ) as zykz_lx_de_status ) as RequestStatus,
      ddtext                                                              as RequestStatusText
}
where
      domname    = 'ZYKZ_LX_STATUS'
  and ddlanguage = $session.system_language
