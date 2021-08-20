@AbapCatalog.sqlViewName: 'ZYKZCRITMTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'LeverX Demo: Item'

@VDM.viewType: #CONSUMPTION

@ObjectModel: { createEnabled: true,
                updateEnabled: true,
                deleteEnabled: true,
                semanticKey: 'ItemName',
                usageType.dataClass: #TRANSACTIONAL,
                usageType.serviceQuality: #C,
                usageType.sizeCategory: #M,
                transactionalProcessingDelegated: true }

define view ZYKZ_C_RequestItemTP
  as select from ZYKZ_I_RequestItemTP
  association [1]    to ZYKZ_C_RequestHeaderTP   as _RequestHeaderTP   on $projection.HeaderUUID = _RequestHeaderTP.UUID
  association [0..*] to ZYKZ_C_ItemRequisitionTP as _ItemRequisitionTP on $projection.UUID = _ItemRequisitionTP.ItemUUID
{

      @UI.facet: [
//                        {
//                             id:              'RequestItemMainInfo',
//                             label:           'General Information',
//                             type:             #HEADERINFO_REFERENCE,
//                             isSummary,
//                             position:        10
//                           },
                         {
                             id:              'Requisitions',
                             purpose:         #STANDARD,
                             type:            #LINEITEM_REFERENCE,
                             label:           'Request Item Requisitions',
                             position:        20,
                             targetElement:   '_ItemRequisitionTP'
                           }
                           ]

      @UI.hidden: true
  key UUID,
      @UI.hidden: true
      HeaderUUID,

      @EndUserText.label: 'Request Item'
      @UI.lineItem:{position: 10 }
      @ObjectModel.mandatory: true
      ItemName,

      @EndUserText.label: 'Description'
       @UI.lineItem:{position: 20 }
      Description,

      @EndUserText.label: 'Requisition Count'
      @UI.lineItem:{position: 30 }
      @ObjectModel.readOnly: true
      RequisitionCount,


      /* Associations */
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _ItemRequisitionTP,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT,#TO_COMPOSITION_ROOT]
      _RequestHeaderTP
}
