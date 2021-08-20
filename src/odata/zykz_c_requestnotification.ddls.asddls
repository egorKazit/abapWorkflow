@AbapCatalog.sqlViewName: 'ZYKZCRNTF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'LeverX Demo: Approvers'

@VDM.viewType: #CONSUMPTION

@ObjectModel: { semanticKey: 'Approver',
                usageType.serviceQuality: #C,
                usageType.sizeCategory: #M
                }
define view ZYKZ_C_RequestNotification
  as select from ZYKZ_I_RequestNotification
{
      @UI.hidden: true
  key UUID,
      
      @UI.hidden: true
      HeaderUUID,
      
      @EndUserText.label: 'Notification IP'
      @UI.lineItem: { position: 10 }
      @ObjectModel.readOnly: true
      Ip,
      
      @EndUserText.label: 'Message'
      @UI.lineItem: { position: 10 }
      @ObjectModel.readOnly: true
      Message
}
