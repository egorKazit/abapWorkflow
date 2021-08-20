@AbapCatalog.sqlViewName: 'ZYKZIRPRR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Request Priority Value Help'
@VDM.viewType:#BASIC
@ObjectModel: {
    semanticKey: 'ABOPCheckingRule',
    usageType: {
      serviceQuality: #C,
      sizeCategory: #M,
      dataClass: #MASTER
    }
}
define view ZYKZ_I_RequestPriorityVH
  as select from dd07t
{
  key $session.client                            as mandt,
  key cast ( cast ( domvalue_l as abap.char( 3 ) ) as zykz_lx_de_priority ) as RequestPriority,
      ddtext                                     as RequestPriorityText
}
where
      domname    = 'ZYKZ_LX_PRIORITY'
  and ddlanguage = $session.system_language
