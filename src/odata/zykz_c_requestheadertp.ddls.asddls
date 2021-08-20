@AbapCatalog.sqlViewName: 'ZYKZCRHDRTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'LeverX Demo: Header'

@VDM.viewType: #CONSUMPTION

@UI.headerInfo:{
    typeName: 'Request',
    typeNamePlural: 'Request',
    title.value: 'RequestID',
    description.value: 'RequestName'
}

@ObjectModel:{createEnabled: true,
              updateEnabled: 'EXTERNAL_CALCULATION',
              deleteEnabled: 'EXTERNAL_CALCULATION',

              transactionalProcessingDelegated: true,

              representativeKey: 'UUID',
              semanticKey: 'RequestID',

              draftEnabled: true,
              compositionRoot: true,

              usageType.dataClass:  #TRANSACTIONAL,
              usageType.serviceQuality: #C,
              usageType.sizeCategory: #L}

//@Search.searchable: true

define view ZYKZ_C_RequestHeaderTP
  as select from ZYKZ_I_RequestHeaderTP

  association [0..*] to ZYKZ_C_RequestItemTP       as _RequestItemTP       on $projection.UUID = _RequestItemTP.HeaderUUID
  association [0..*] to ZYKZ_C_RequestNotification as _RequestNotification on $projection.UUID = _RequestNotification.HeaderUUID

  association [1..1] to ZYKZ_C_RequestStatusVH     as _RequestStatusVH     on $projection.RequestStatus = _RequestStatusVH.RequestStatus
  association [1..1] to ZYKZ_C_RequestPriorityVH   as _RequestPriorityVH   on $projection.Priority = _RequestPriorityVH.RequestPriority

{

      @UI.facet: [

                 { id:              'RequestMainInfo',
                   type:            #HEADERINFO_REFERENCE,
                   label:           'General Information',
                   position:        10 },

           // Facet for Fieldgroup 1 - nested inside Facet 1

                 { id:              'RequestMainInfoFacet',
                   type:            #FIELDGROUP_REFERENCE,
                   label:           'Info',
                   parentId:        'RequestMainInfoFacet', // Places this facet into 'Facet 1'
                   targetQualifier: 'RequestMainInfoFacet',
                   position:         10 } //,

//                   {
//                       id:              'Items',
//                       purpose:         #STANDARD,
//                       type:            #LINEITEM_REFERENCE,
//                       label:           'Request Items',
//                       position:        20,
//                       targetElement:   '_RequestItemTP'
//                     },
//                     {
//                       id:              'Notifications',
//                       purpose:         #STANDARD,
//                       type:            #LINEITEM_REFERENCE,
//                       label:           'Notifications',
//                       position:        30,
//                       targetElement:   '_RequestNotification'
//                     }
                     ]

      @UI.identification: [
      { dataAction: 'BOPF:SUBMIT', type: #FOR_ACTION, label: 'Submit', position: 0, importance: #LOW },
      { dataAction: 'BOPF:WITHDRAW', type: #FOR_ACTION, label: 'Withdraw', position: 10, importance: #LOW }
      ]

      @UI.lineItem: [{ dataAction: 'BOPF:SUBMIT', type: #FOR_ACTION, label: 'Submit', position: 0, importance: #LOW },
          { dataAction: 'BOPF:WITHDRAW', type: #FOR_ACTION, label: 'Withdraw', position: 10, importance: #LOW }]

      @UI.hidden: true
  key UUID,

      @EndUserText.label: 'Request ID'
      @UI.fieldGroup: { qualifier: 'RequestMainInfoFacet', position: 10, importance: #HIGH }
      @UI.lineItem: { position: 10 }
      @ObjectModel.readOnly: true
      RequestID,

      @EndUserText.label: 'Request'
      @UI.fieldGroup: {  qualifier: 'RequestMainInfoFacet', position: 20, importance: #HIGH }
      @UI.lineItem: { position: 20 }
      @ObjectModel.mandatory: true
      RequestName,

      @EndUserText.label: 'Description'
      @UI.fieldGroup: { qualifier: 'RequestMainInfoFacet', position: 30, importance: #HIGH }
      @UI.lineItem: { position: 30 }
      @ObjectModel.mandatory: true
      Description,

      @UI.selectionField: { position: 40 }
      @UI.textArrangement: #TEXT_ONLY
      @UI.lineItem: { position: 40, importance: #HIGH }
      @ObjectModel.readOnly: true
      @ObjectModel.foreignKey.association: '_RequestStatusVH'
      @ObjectModel.text.element: ['RequestStatusText']
      RequestStatus,
      _RequestStatusVH.RequestStatusText,

      @EndUserText.label: 'Priority'
      @UI.fieldGroup: { qualifier: 'RequestMainInfoFacet', position: 50, importance: #HIGH }
      @UI.lineItem: { position: 50 }
      @ObjectModel.mandatory: true
      @ObjectModel.foreignKey.association: '_RequestPriorityVH'
      @ObjectModel.text.element: ['RequestPriorityText']
      Priority,
      _RequestPriorityVH.RequestPriorityText,

      /* Associations */
      _RequestNotification,
      @ObjectModel.association.type: #TO_COMPOSITION_CHILD
      _RequestItemTP,

      _RequestStatusVH ,
      _RequestPriorityVH

}
