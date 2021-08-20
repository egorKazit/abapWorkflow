@AbapCatalog.sqlViewName: 'ZYKZCRIRQNTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'LeverX Demo: Item Requisition'

@VDM.viewType: #CONSUMPTION

@ObjectModel: { createEnabled: true,
                updateEnabled: true,
                deleteEnabled: true,
                semanticKey: 'RequisitionName',
                usageType.dataClass: #TRANSACTIONAL,
                usageType.serviceQuality: #C,
                usageType.sizeCategory: #M,
                transactionalProcessingDelegated: true 
                }
 
define view ZYKZ_C_ItemRequisitionTP
  as select from ZYKZ_I_ItemRequisitionTP
  association [1] to ZYKZ_C_RequestHeaderTP as _RequestHeaderTP on $projection.HeaderUUID = _RequestHeaderTP.UUID
  association [1] to ZYKZ_C_RequestItemTP   as _RequestItemTP   on $projection.ItemUUID = _RequestItemTP.UUID
{

@UI.hidden: true
  key UUID,
  
  @UI.hidden: true
      ItemUUID,
      
      @UI.hidden: true
      HeaderUUID,
      
      @EndUserText.label: 'Requisition Name'
      @UI.lineItem:{position: 20 }
      RequisitionName,

      /* Associations */
      @ObjectModel.association.type: [#TO_COMPOSITION_ROOT]
      _RequestHeaderTP,

      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT]
      _RequestItemTP
}
