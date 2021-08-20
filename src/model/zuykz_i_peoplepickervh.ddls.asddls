@AbapCatalog.sqlViewName: 'ZYKZIWFUP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED
@Search.searchable: true
@EndUserText.label: 'LeverX Demo: Workflow User Picker VH'
@ObjectModel: {
    semanticKey: 'UserID',
    representativeKey: 'UserID',
    usageType.serviceQuality: #C,
    usageType.sizeCategory: #L,
    usageType.dataClass: #MIXED
}
define view ZUYKZ_I_PeoplePickerVH
  as select from I_User as _User
  //left outer join zykz_wf_demo_usr as _DemoUserRestriction on _User.bname = _DemoUserRestriction.username
{
      @ObjectModel.text.element: 'FullName'
      @Search: { defaultSearchElement: true, ranking: #MEDIUM }
  key _User.UserID          as UserID,

      @Semantics.text: true
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      _User.UserDescription as FullName

}
